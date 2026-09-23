*==============================================================================
* Formgpd.prg - Formulario de Cadastro de Grupo de Produto
* Migrado de: SIGCDGPD.SCX (frmcadastro)
* Fase 3/8: Estrutura base (sem controles de dados nas abas internas)
*==============================================================================

DEFINE CLASS FormGpd AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 640
    Width       = 1000
    Caption     = "Cadastro de Grupo de Produto"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2
    ShowTips    = .T.

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_lAtivaPag       = .F.
    *-- guarda de reentrancia do filtro Grande Grupo da pagina Lista (Erro173):
    *-- o LostFocus abre um form MODAL, e o vai-e-vem de foco pode redisparar o
    *-- proprio LostFocus, empilhando um segundo picker.
    this_lFiltroGdeEmCurso = .F.

    *-- Propriedades legado (original SIGCDGPD)
    composoriginal  = .F.
    digitooriginal  = .F.
    montasoriginal  = .F.

    *==========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("gpdBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar gpdBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormGpd.InicializarForm")
            ELSE
                THIS.InicializarCursoresCodificacao()
                THIS.ConfigurarPageFrame()

                WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
                    .lbl_4c_Sombra.Caption = THIS.Caption
                    .lbl_4c_Titulo.Caption = THIS.Caption
                    .Visible     = .T.
                ENDWITH

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormGpd:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormGpd.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas
    * Top=-29 para esconder abas; controles compensam +29 no Top
    *==========================================================================
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

            .Page1.Caption  = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption  = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1: cabecalho, filtro, botoes CRUD
    * Grids (grd_4c_Grade, grd_4c_Subgrupos) sao adicionados na Fase 4
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho cinza (cntSombra legado: Top=1, Left=-1, Width=1100, Height=80)
        *-- Compensacao +29: Top=30
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top       = 30
            .Left      = 0
            .Width     = THIS.Width
            .Height    = 80
            .BackColor = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible   = .T.
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

        *-- Container Botoes CRUD (Grupo_op legado: Left=544, Top=-1, Width=385, Height=85)
        *-- Canonico: Left=544, Top=29 (CLAUDE.md regra #10)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top       = 29
            .Left      =  542
            .Width     = 385
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        *-- Botao Incluir
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
        *-- Legado: Grupo_Saida.Left=919, Top=-1. Canonico: Left=917, Top=29
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top       = 29
            .Left      = 917
            .Width     = 90
            .Height    = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible   = .T.
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Container Filtro Grande Grupo (cntFiltros legado: Top=86, Left=35, Width=216, Height=34)
        *-- Compensacao +29: Top=115
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 115
            .Left        = 35
            .Width       = 216
            .Height      = 34
            .BackStyle   = 0
            .BorderWidth = 1
            .BorderColor = RGB(90, 90, 90)
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_GdeGrupo", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_GdeGrupo
            .Caption   = "Grande Grupo : "
            .Top       = 9
            .Left      = 5
            .Width     = 89
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_Gde", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_Gde
            .Value         = ""
            .Top           = 5
            .Left          = 108
            .Width         = 33
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .Format        = "!K"
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(0, 0, 0)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        *-- LostFocus, nao KeyPress: o legado (Get_gde) recarrega a grade ao SAIR do
        *-- campo, nao so no Enter, e valida com picker no Valid. BINDEVENT em "Valid"
        *-- nao dispara de forma confiavel em TextBox, entao as duas coisas moram no
        *-- handler de LostFocus. Erro172.
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_Gde, "LostFocus", THIS, "FiltroGde_LostFocus")

        *-- Botao Exporta XML (legado: Top=83, Left=759, Height=40, Width=105)
        *-- Compensacao +29: Top=112
        loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnExpXML
            .Caption         = "Exporta XML"
            .Picture         = gc_4c_CaminhoIcones + "exportar_48.png"
            .PicturePosition = 0
            .Top             = 112
            .Left            = 759
            .Width           = 105
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML, "Click", THIS, "BtnExpXMLClick")

        *-- Botao Importa XML (legado: Top=83, Left=864, Height=40, Width=105)
        *-- Compensacao +29: Top=112
        loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnImpXML
            .Caption         = "Importa XML"
            .PicturePosition = 0
            .Top             = 112
            .Left            = 864
            .Width           = 105
            .Height          = 40
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML, "Click", THIS, "BtnImpXMLClick")

        *-- Label "Grupos" (Label2 legado: Top=128, Left=34)
        *-- Compensacao +29: Top=157
        loc_oPagina.AddObject("lbl_4c_Grupos", "Label")
        WITH loc_oPagina.lbl_4c_Grupos
            .Caption   = "Grupos"
            .Top       = 157
            .Left      = 34
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label "Subgrupos" (Label1 legado: Top=128, Left=576)
        *-- Compensacao +29: Top=157
        loc_oPagina.AddObject("lbl_4c_Subgrupos", "Label")
        WITH loc_oPagina.lbl_4c_Subgrupos
            .Caption   = "Subgrupos"
            .Top       = 157
            .Left      = 576
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Grade principal de Grupos (Grade legado: Top=143, Left=34, Width=523, Height=439)
        *-- Compensacao +29: Top=172
        loc_oPagina.AddObject("grd_4c_Grade", "Grid")
        WITH loc_oPagina.grd_4c_Grade
            .Top         = 172
            .Left        = 34
            .Width       = 523
            .Height      = 479
            .ColumnCount = 3
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .FontName    = "Courier New"
            .FontSize    = 9
            .Visible     = .T.
            .Column1.Width     = 80
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column2.Width     = 304
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column3.Width     = 115
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Grade, "AfterRowColChange", THIS, "GradeAfterRowColChange")

        *-- Grid de Subgrupos (grdSigCdPsg legado: Top=143, Left=576, Width=394, Height=439)
        *-- Compensacao +29: Top=172
        loc_oPagina.AddObject("grd_4c_Subgrupos", "Grid")
        WITH loc_oPagina.grd_4c_Subgrupos
            .Top         = 172
            .Left        = 576
            .Width       = 394
            .Height      = 479
            .ColumnCount = 3
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .FontName    = "Courier New"
            .FontSize    = 9
            .Visible     = .T.
            .Column1.Width     = 70
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column2.Width     = 230
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column3.Width     = 70
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: salvar/cancelar, navegacao,
    *   PageFrame interno com 9 abas (controles de dados adicionados nas Fases 5-6)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salvar/Cancelar (Grupo_Salva legado: Top=-2, Left=840, Width~160, Height=85)
        *-- Compensacao +29: Top=27
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top       = 27
            .Left      = 840
            .Width     = 160
            .Height    = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- OptionGroup navegacao entre 9 abas internas
        *-- Legado: Optiongroup1 Top=8, Left=2, Width=801, Height=74, ButtonCount=9
        *-- Compensacao +29: Top=37
        *-- Cada botao: Width=89 (9*89=801), Height=64, Top=5
        loc_oPagina.AddObject("opt_4c_Navegacao", "OptionGroup")
        WITH loc_oPagina.opt_4c_Navegacao
            .Left        = 2
            .Top         = 37
            .Width       = 801
            .Height      = 74
            .ButtonCount = 9
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 1
            .Themes      = .F.
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Navegacao
            *-- Btn 1: Cadastro
            .Buttons(1).Caption     = "Cadastro"
            .Buttons(1).Style       = 1
            .Buttons(1).Picture     = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
            .Buttons(1).Left        = 0
            .Buttons(1).Top         = 5
            .Buttons(1).Width       = 89
            .Buttons(1).Height      = 64
            .Buttons(1).FontName    = "Tahoma"
            .Buttons(1).FontSize    = 7
            .Buttons(1).FontBold    = .T.
            .Buttons(1).AutoSize    = .F.
            .Buttons(1).WordWrap    = .T.
            .Buttons(1).SpecialEffect = 0
            .Buttons(1).ForeColor   = RGB(90, 90, 90)
            .Buttons(1).BackColor   = RGB(255, 255, 255)
            .Buttons(1).Themes      = .F.
            *-- Btn 2: Produtos
            .Buttons(2).Caption     = "Produtos"
            .Buttons(2).Style       = 1
            .Buttons(2).Picture     = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
            .Buttons(2).Left        = 89
            .Buttons(2).Top         = 5
            .Buttons(2).Width       = 89
            .Buttons(2).Height      = 64
            .Buttons(2).FontName    = "Tahoma"
            .Buttons(2).FontSize    = 7
            .Buttons(2).FontBold    = .T.
            .Buttons(2).AutoSize    = .F.
            .Buttons(2).WordWrap    = .T.
            .Buttons(2).SpecialEffect = 0
            .Buttons(2).ForeColor   = RGB(90, 90, 90)
            .Buttons(2).BackColor   = RGB(255, 255, 255)
            .Buttons(2).Themes      = .F.
            *-- Btn 3: Descricao
            .Buttons(3).Caption     = "Descri" + CHR(231) + CHR(227) + "o"
            .Buttons(3).Style       = 1
            .Buttons(3).Picture     = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
            .Buttons(3).Left        = 178
            .Buttons(3).Top         = 5
            .Buttons(3).Width       = 89
            .Buttons(3).Height      = 64
            .Buttons(3).FontName    = "Tahoma"
            .Buttons(3).FontSize    = 7
            .Buttons(3).FontBold    = .T.
            .Buttons(3).AutoSize    = .F.
            .Buttons(3).WordWrap    = .T.
            .Buttons(3).SpecialEffect = 0
            .Buttons(3).ForeColor   = RGB(90, 90, 90)
            .Buttons(3).BackColor   = RGB(255, 255, 255)
            .Buttons(3).Themes      = .F.
            *-- Btn 4: Estoque / Fiscal
            .Buttons(4).Caption     = "Estoque / Fiscal"
            .Buttons(4).Style       = 1
            .Buttons(4).Picture     = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
            .Buttons(4).Left        = 267
            .Buttons(4).Top         = 5
            .Buttons(4).Width       = 89
            .Buttons(4).Height      = 64
            .Buttons(4).FontName    = "Tahoma"
            .Buttons(4).FontSize    = 7
            .Buttons(4).FontBold    = .T.
            .Buttons(4).AutoSize    = .F.
            .Buttons(4).WordWrap    = .T.
            .Buttons(4).SpecialEffect = 0
            .Buttons(4).ForeColor   = RGB(90, 90, 90)
            .Buttons(4).BackColor   = RGB(255, 255, 255)
            .Buttons(4).Themes      = .F.
            *-- Btn 5: Industria
            .Buttons(5).Caption     = "Ind" + CHR(250) + "stria"
            .Buttons(5).Style       = 1
            .Buttons(5).Picture     = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
            .Buttons(5).Left        = 356
            .Buttons(5).Top         = 5
            .Buttons(5).Width       = 89
            .Buttons(5).Height      = 64
            .Buttons(5).FontName    = "Tahoma"
            .Buttons(5).FontSize    = 7
            .Buttons(5).FontBold    = .T.
            .Buttons(5).AutoSize    = .F.
            .Buttons(5).WordWrap    = .T.
            .Buttons(5).SpecialEffect = 0
            .Buttons(5).ForeColor   = RGB(90, 90, 90)
            .Buttons(5).BackColor   = RGB(255, 255, 255)
            .Buttons(5).Themes      = .F.
            *-- Btn 6: Configuracao
            .Buttons(6).Caption     = "Configura" + CHR(231) + CHR(227) + "o"
            .Buttons(6).Style       = 1
            .Buttons(6).Picture     = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
            .Buttons(6).Left        = 445
            .Buttons(6).Top         = 5
            .Buttons(6).Width       = 89
            .Buttons(6).Height      = 64
            .Buttons(6).FontName    = "Tahoma"
            .Buttons(6).FontSize    = 7
            .Buttons(6).FontBold    = .T.
            .Buttons(6).AutoSize    = .F.
            .Buttons(6).WordWrap    = .T.
            .Buttons(6).SpecialEffect = 0
            .Buttons(6).ForeColor   = RGB(90, 90, 90)
            .Buttons(6).BackColor   = RGB(255, 255, 255)
            .Buttons(6).Themes      = .F.
            *-- Btn 7: SubGrupos
            .Buttons(7).Caption     = "SubGrupos"
            .Buttons(7).Style       = 1
            .Buttons(7).Picture     = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
            .Buttons(7).Left        = 534
            .Buttons(7).Top         = 5
            .Buttons(7).Width       = 89
            .Buttons(7).Height      = 64
            .Buttons(7).FontName    = "Tahoma"
            .Buttons(7).FontSize    = 7
            .Buttons(7).FontBold    = .T.
            .Buttons(7).AutoSize    = .F.
            .Buttons(7).WordWrap    = .T.
            .Buttons(7).SpecialEffect = 0
            .Buttons(7).ForeColor   = RGB(90, 90, 90)
            .Buttons(7).BackColor   = RGB(255, 255, 255)
            .Buttons(7).Themes      = .F.
            *-- Btn 8: Codificacao
            .Buttons(8).Caption     = "Codifica" + CHR(231) + CHR(227) + "o"
            .Buttons(8).Style       = 1
            .Buttons(8).Picture     = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
            .Buttons(8).Left        = 623
            .Buttons(8).Top         = 5
            .Buttons(8).Width       = 89
            .Buttons(8).Height      = 64
            .Buttons(8).FontName    = "Tahoma"
            .Buttons(8).FontSize    = 7
            .Buttons(8).FontBold    = .T.
            .Buttons(8).AutoSize    = .F.
            .Buttons(8).WordWrap    = .T.
            .Buttons(8).SpecialEffect = 0
            .Buttons(8).ForeColor   = RGB(90, 90, 90)
            .Buttons(8).BackColor   = RGB(255, 255, 255)
            .Buttons(8).Themes      = .F.
            *-- Btn 9: Compos
            .Buttons(9).Caption     = "Compos"
            .Buttons(9).Style       = 1
            .Buttons(9).Picture     = gc_4c_CaminhoIcones + "geral_configuracao_60.jpg"
            .Buttons(9).Left        = 712
            .Buttons(9).Top         = 5
            .Buttons(9).Width       = 89
            .Buttons(9).Height      = 64
            .Buttons(9).FontName    = "Tahoma"
            .Buttons(9).FontSize    = 7
            .Buttons(9).FontBold    = .T.
            .Buttons(9).AutoSize    = .F.
            .Buttons(9).WordWrap    = .T.
            .Buttons(9).SpecialEffect = 0
            .Buttons(9).ForeColor   = RGB(90, 90, 90)
            .Buttons(9).BackColor   = RGB(255, 255, 255)
            .Buttons(9).Themes      = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_Navegacao, "InteractiveChange", THIS, "NavegacaoAbasChanged")

        *-- PageFrame interno com 9 abas (pgDivisoes legado: Top=-29, Width=1000, Height=639)
        *-- Top=-29 MANTIDO (nao recebe +29) para esconder abas proprias - igual ao original
        *-- Tabs=.F. pois a navegacao e feita pelo opt_4c_Navegacao acima
        *-- Controles das 9 abas sao adicionados nas Fases 5-6
        loc_oPagina.AddObject("pgf_4c_Divisoes", "PageFrame")
        WITH loc_oPagina.pgf_4c_Divisoes
            .PageCount = 9
            *-- Top -29 -> 30: abre espaco para a faixa do cabecalho (29..109).
            *-- O controle mais alto das abas esta em Top=85, entao 30+85=115.
            .Top       = 30
            .Left      = 0
            .Width     = 1000
            .Height    = 639
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH
        WITH loc_oPagina.pgf_4c_Divisoes
            *-- Paginas em ordem PageOrder (1-9), nomes canonicos 4c
            .Page1.Caption   = "Cadastro"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Produtos"
            .Page2.BackColor = RGB(255, 255, 255)

            .Page3.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Page3.BackColor = RGB(255, 255, 255)

            .Page4.Caption   = "Estoque / Fiscal"
            .Page4.BackColor = RGB(255, 255, 255)

            .Page5.Caption   = "Ind" + CHR(250) + "stria"
            .Page5.BackColor = RGB(255, 255, 255)

            .Page6.Caption   = "Configura" + CHR(231) + CHR(227) + "o"
            .Page6.BackColor = RGB(255, 255, 255)

            .Page7.Caption   = "SubGrupos"
            .Page7.BackColor = RGB(255, 255, 255)

            .Page8.Caption   = "Codifica" + CHR(231) + CHR(227) + "o"
            .Page8.BackColor = RGB(255, 255, 255)

            .Page9.Caption   = "Compos"
            .Page9.BackColor = RGB(255, 255, 255)
        ENDWITH

        *-- Preencher abas internas pgf_4c_Divisoes
        THIS.ConfigurarAbaCadastro()
        THIS.ConfigurarAbaProdutos()
        THIS.ConfigurarAbaDescricao()
        THIS.ConfigurarAbaEstoqueFiscal()
        THIS.ConfigurarAbaIndustria()
        THIS.ConfigurarAbaConfiguracao()
        THIS.ConfigurarAbaSubGrupos()
        THIS.ConfigurarAbaCodificacao()
        THIS.ConfigurarAbaComposicao()
        THIS.ConfigurarPgpgCadastro()
        THIS.ConfigurarPgpgCodificacao()
        THIS.ConfigurarPgPgCompos()
        THIS.ConfigurarPgpgConfig()
        THIS.ConfigurarPgpgDescrs()
        THIS.ConfigurarPgpgEstoque()
        THIS.ConfigurarPgpgProdutos()

        *-- Cabecalho cinza (identico ao da pagina Lista) - CLAUDE.md #11 / Erro152
        *-- Criado DEPOIS do pgf_4c_Divisoes: o PageFrame interno pinta fundo
        *-- branco sobre a area 30..109 e cobriria a faixa se ela viesse antes.
        loc_oPagina.AddObject("cnt_4c_FaixaTitulo", "Container")
        WITH loc_oPagina.cnt_4c_FaixaTitulo
            .Top           = 29
            .Left          = 0
            .Width         = THIS.Width
            .Height        = 80
            .BackColor     = RGB(100, 100, 100)
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
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
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
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
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Z-ORDER: Trazer navegacao e botoes para frente do PageFrame interno
        *-- (pgf_4c_Divisoes e o ultimo AddObject, cobre tudo; ZOrder(0) = traz para frente)
        loc_oPagina.opt_4c_Navegacao.ZOrder(0)
        loc_oPagina.cnt_4c_Salva.ZOrder(0)

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega cursor_4c_Dados e atualiza grids da Page1
    * Grids (grd_4c_Grade/grd_4c_Subgrupos) sao configurados aqui na Fase 4
    * Filtro por grande grupo (mercs) lido de txt_4c_Gde
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_cGde, loc_cFiltro
        loc_lResultado = .F.
        loc_cGde       = ""
        loc_cFiltro    = ""

        TRY
            *-- Ler filtro de grande grupo se disponivel
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Filtros", 5)
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "txt_4c_Gde", 5)
                    loc_cGde = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Gde.Value)
                ENDIF
            ENDIF

            *-- O filtro eh SEMPRE aplicado, inclusive vazio. No legado a grade nasce
            *-- ligada a [Select * From SigCdGrp Where Mercs = ?m.pcMercs] com
            *-- pcMercs = [] (Init), e o mAtivaPagina1 so preenche pcMercs quando o
            *-- Get_Gde tem valor: sem Grande Grupo escolhido a consulta nao casa nada
            *-- e a Lista abre VAZIA. Filtrar so quando preenchido fazia o migrado
            *-- carregar TODOS os grupos ao abrir (Erro172). Padr(...,3) como o legado.
            loc_cFiltro = "mercs = " + EscaparSQL(PADR(loc_cGde, 3))

            IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                loc_lResultado = .F.
            ELSE
                *-- Configurar grd_4c_Grade (grupos principais)
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Grade", 5)
                    LOCAL loc_oGrid, loc_cPrimeiroCgrus
                    loc_oGrid          = THIS.pgf_4c_Paginas.Page1.grd_4c_Grade
                    loc_cPrimeiroCgrus = ""

                    *-- 4 colunas, com caption e largura do pColuna do legado (Init):
                    *--   cgrus 'Codigo' 60 | dgrus 'Descricao' 250 | mercs 'Grande Grupo' 155
                    *--   Unificas 'Uni' 32
                    *-- O que vale em runtime eh o pColuna, nao o header desenhado no SCX
                    *-- (que dizia "Descricao do Grupo" e tinha so 3 colunas). O migrado
                    *-- seguia o SCX e perdia a coluna Uni (Erro172).
                    loc_oGrid.ColumnCount = 4
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cgrus"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dgrus"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.mercs"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.unificas"
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Grande Grupo"
                    loc_oGrid.Column4.Header1.Caption = "Uni"
                    THIS.FormatarGridLista(loc_oGrid)

                    *-- Larguras por ULTIMO: mexer em RecordSource/ControlSource e na
                    *-- fonte do Grid faz o VFP recalcular Column.Width para o default
                    *-- (90). Atribuidas antes, voltavam todas a 90 - medido. Valores
                    *-- do pColuna do legado.
                    loc_oGrid.Column1.Width = 60
                    loc_oGrid.Column2.Width = 250
                    loc_oGrid.Column3.Width = 155
                    loc_oGrid.Column4.Width = 32

                    *-- Carregar subgrupos do primeiro grupo listado
                    IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        loc_cPrimeiroCgrus = ALLTRIM(cursor_4c_Dados.cgrus)
                    ENDIF
                    THIS.CarregarSubgrupos(loc_cPrimeiroCgrus)
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar lista:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormGpd.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loc_oErro.Message, "FormGpd.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * NavegacaoAbasChanged - Troca aba interna ao clicar opt_4c_Navegacao
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE NavegacaoAbasChanged()
        LOCAL loc_nAba
        loc_nAba = THIS.pgf_4c_Paginas.Page2.opt_4c_Navegacao.Value

        IF VARTYPE(loc_nAba) = "N" AND loc_nAba >= 1 AND loc_nAba <= 9
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.ActivePage = loc_nAba
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre Page2 para incluir novo registro
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.Page2.opt_4c_Navegacao.Value = 1
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.ActivePage = 1
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cgrus)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um grupo para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.pgf_4c_Paginas.Page2.opt_4c_Navegacao.Value = 1
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.ActivePage = 1
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre Page2 para alterar registro selecionado
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cgrus)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um grupo para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.pgf_4c_Paginas.Page2.opt_4c_Navegacao.Value = 1
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.ActivePage = 1
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cgrus)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um grupo para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do Grupo [" + loc_cCodigo + "]?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre picker para localizar grupo na lista
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGpd", "cgrus", "", ;
                "Buscar Grupo de Produto")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGpd")
                    SELECT cursor_4c_BuscaGpd
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaGpd.cgrus)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaGpd")
                USE IN cursor_4c_BuscaGpd
            ENDIF

            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(cgrus) == loc_cCodigo
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Grade", 5)
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.BtnBuscarClick")
            IF USED("cursor_4c_BuscaGpd")
                USE IN cursor_4c_BuscaGpd
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma e salva o registro atual
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF !THIS.ValidarDados()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            THIS.SalvarCrMontagem(THIS.this_oBusinessObject.this_cCgrus)
            THIS.SalvarSigcdcpo(THIS.this_oBusinessObject.this_cCgrus)
            THIS.SalvarLocalProD(THIS.this_oBusinessObject.this_cCgrus)
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnExpXMLClick - Exporta dados para XML
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnExpXMLClick()
        MsgAviso("Exporta" + CHR(231) + CHR(227) + "o XML em desenvolvimento.")
    ENDPROC

    *==========================================================================
    * BtnImpXMLClick - Importa dados de XML
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnImpXMLClick()
        MsgAviso("Importa" + CHR(231) + CHR(227) + "o XML em desenvolvimento.")
    ENDPROC

    *==========================================================================
    * FiltroGde_LostFocus - Grande Grupo da pagina Lista (legado: Get_gde)
    *
    * Reproduz os DOIS eventos do legado, nesta ordem:
    *   Valid     -> se o codigo digitado nao existe em SigCdGpr, abre o picker de
    *                Grande Grupo; ESC/cancelar limpa o campo (o legado faz
    *                This.Value = '' + Return 0).
    *   LostFocus -> pcMercs = This.Value, requery do cursor e recarrega a grade.
    *
    * PUBLIC: BINDEVENT exige metodo publico (regra #3).
    *==========================================================================
    PROCEDURE FiltroGde_LostFocus()
        LOCAL loc_oTxt, loc_cValor

        *-- Guarda de reentrancia: abrir um form MODAL de dentro do LostFocus faz o
        *-- foco sair e voltar, e o proprio LostFocus pode disparar de novo - o que
        *-- empilharia um segundo picker por cima do primeiro (Erro173).
        IF THIS.this_lFiltroGdeEmCurso
            RETURN
        ENDIF
        THIS.this_lFiltroGdeEmCurso = .T.

        TRY
            loc_oTxt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Gde
            loc_cValor = UPPER(ALLTRIM(loc_oTxt.Value))

            *-- Equivalente ao Valid do legado: so age quando ha algo digitado.
            *-- NAO ha checagem de existencia aqui: o proprio FormBuscaAuxiliar.Init
            *-- ja faz o match exato e marca this_lAchouRegistro - duplicar isso com
            *-- um SQLEXEC a parte era so mais um caminho para divergir.
            IF !EMPTY(loc_cValor)
                THIS.AbrirBuscaGdeGrupoFiltro()
            ENDIF

            *-- equivalente ao LostFocus do legado: recarrega a grade com o filtro atual
            THIS.CarregarLista()

        CATCH TO loc_oErro
            MostrarErro("Erro no filtro de Grande Grupo:" + CHR(13) + ;
                loc_oErro.Message, "FormGpd.FiltroGde_LostFocus")
        ENDTRY

        THIS.this_lFiltroGdeEmCurso = .F.
    ENDPROC

    *==========================================================================
    * AbrirBuscaGdeGrupoFiltro - Picker de Grande Grupo do FILTRO da pagina Lista.
    * Separado do AbrirBuscaGdeGrupo, que devolve para o txt_4c_Mercs da pagina
    * Dados. Legado: fwbuscasel sobre crSigCdGpr (Codigos/Descs).
    *==========================================================================
    PROCEDURE AbrirBuscaGdeGrupoFiltro()
        LOCAL loc_oBusca, loc_oTxt

        loc_oTxt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_Gde

        TRY
            *-- 1o parametro do Init eh o HANDLE da conexao (par_nConn), nao a tabela
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGdeFiltro", "Codigos", ;
                ALLTRIM(loc_oTxt.Value), ;
                "Grande Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Padrao canonico do projeto (137 chamadores): o Init ja tenta o
                *-- match EXATO e, achando 1 registro so, marca this_lAchouRegistro e
                *-- this_lSelecionou - o valor ja esta resolvido e o picker NAO deve
                *-- ser mostrado. Chamar Show() aqui sem guarda abria o dialogo por
                *-- cima da tela ja preenchida (Erro173).
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGdeFiltro")
                    SELECT cursor_4c_BuscaGdeFiltro
                    loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaGdeFiltro.Codigos)
                ELSE
                    *-- so aqui o legado limpa o campo: o usuario VIU o picker e saiu
                    *-- sem escolher (ESC/Cancelar). Limpar incondicionalmente no fim
                    *-- do metodo zerava o filtro mesmo quando o valor ja estava certo,
                    *-- e a grade vinha vazia em seguida (Erro173).
                    loc_oTxt.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca de Grande Grupo:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.AbrirBuscaGdeGrupoFiltro")
        ENDTRY

        IF USED("cursor_4c_BuscaGdeFiltro")
            USE IN cursor_4c_BuscaGdeFiltro
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados do Form para o BO antes de salvar
    * Campos principais em pgCadastro (Page2.pgf_4c_Divisoes.Page1)
    * Usa PEMSTATUS pois controles sao adicionados nas Fases 5-6
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1

        IF PEMSTATUS(loc_oPg1, "txt_4c_Cgrus", 5)
            THIS.this_oBusinessObject.this_cCgrus = ALLTRIM(loc_oPg1.txt_4c_Cgrus.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Dgrus", 5)
            THIS.this_oBusinessObject.this_cDgrus = ALLTRIM(loc_oPg1.txt_4c_Dgrus.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Mercs", 5)
            THIS.this_oBusinessObject.this_cMercs = ALLTRIM(loc_oPg1.txt_4c_Mercs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Ids", 5)
            THIS.this_oBusinessObject.this_nIds = loc_oPg1.txt_4c_Ids.Value
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_DiasEnts", 5)
            THIS.this_oBusinessObject.this_nDiasents = loc_oPg1.txt_4c_DiasEnts.Value
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_DiasGar", 5)
            THIS.this_oBusinessObject.this_nDiasgar = loc_oPg1.txt_4c_DiasGar.Value
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_EtiPad", 5)
            THIS.this_oBusinessObject.this_cEtipads = UPPER(ALLTRIM(loc_oPg1.txt_4c_EtiPad.Value))
        ENDIF
        IF PEMSTATUS(loc_oPg1, "obj_4c_Fwoption1", 5)
            THIS.this_oBusinessObject.this_lServicos = (loc_oPg1.obj_4c_Fwoption1.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg1, "obj_4c_Fwoption2", 5)
            THIS.this_oBusinessObject.this_nMtprimas = loc_oPg1.obj_4c_Fwoption2.Value
        ENDIF
        IF PEMSTATUS(loc_oPg1, "chk_4c_Logalt", 5)
            THIS.this_oBusinessObject.this_lLogalt = (loc_oPg1.chk_4c_Logalt.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg1, "obj_4c_OptTipoJoals", 5)
            THIS.this_oBusinessObject.this_lNtipjoals = ;
                (loc_oPg1.obj_4c_OptTipoJoals.Value <> 5)
        ENDIF

        *-- Page2: Produtos
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        IF PEMSTATUS(loc_oPg2, "txt_4c_Idecpros", 5)
            THIS.this_oBusinessObject.this_cIdecpros = ALLTRIM(loc_oPg2.txt_4c_Idecpros.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Cgrus2", 5)
            THIS.this_oBusinessObject.this_cCgrus2 = ALLTRIM(loc_oPg2.txt_4c_Cgrus2.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Margems", 5)
            THIS.this_oBusinessObject.this_nMargens = loc_oPg2.txt_4c_Margems.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Markupa", 5)
            THIS.this_oBusinessObject.this_nMarkupa = loc_oPg2.txt_4c_Markupa.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Moemrkaps", 5)
            THIS.this_oBusinessObject.this_cMoemrkaps = ALLTRIM(loc_oPg2.txt_4c_Moemrkaps.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Arreds", 5)
            THIS.this_oBusinessObject.this_nArreds = loc_oPg2.txt_4c_Arreds.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Arredcs", 5)
            THIS.this_oBusinessObject.this_nArredcs = loc_oPg2.txt_4c_Arredcs.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Localpdr", 5)
            THIS.this_oBusinessObject.this_cLocalpdr = ALLTRIM(loc_oPg2.txt_4c_Localpdr.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Padmoecs", 5)
            THIS.this_oBusinessObject.this_cPadmoecs = ALLTRIM(loc_oPg2.txt_4c_Padmoecs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Padmoepcs", 5)
            THIS.this_oBusinessObject.this_cPadmoepcs = ALLTRIM(loc_oPg2.txt_4c_Padmoepcs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Padmoedas", 5)
            THIS.this_oBusinessObject.this_cPadmoedas = ALLTRIM(loc_oPg2.txt_4c_Padmoedas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Padmoevs", 5)
            THIS.this_oBusinessObject.this_cPadmoevs = ALLTRIM(loc_oPg2.txt_4c_Padmoevs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Padmoetcs", 5)
            THIS.this_oBusinessObject.this_cPadmoetcs = ALLTRIM(loc_oPg2.txt_4c_Padmoetcs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg2, "txt_4c_Padmargens", 5)
            THIS.this_oBusinessObject.this_nPadmargens = loc_oPg2.txt_4c_Padmargens.Value
        ENDIF
        IF PEMSTATUS(loc_oPg2, "obj_4c_Lservicos", 5)
            THIS.this_oBusinessObject.this_lLocalobrig = (loc_oPg2.obj_4c_Lservicos.Value = 1)
        ENDIF

        *-- Page4: Estoque/Fiscal
        LOCAL loc_oPg4
        loc_oPg4 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        IF PEMSTATUS(loc_oPg4, "txt_4c_Clfiscals", 5)
            THIS.this_oBusinessObject.this_cClfiscals = ALLTRIM(loc_oPg4.txt_4c_Clfiscals.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "txt_4c_Origmercs", 5)
            THIS.this_oBusinessObject.this_cOrigmercs = ALLTRIM(loc_oPg4.txt_4c_Origmercs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "txt_4c_Sittricms", 5)
            THIS.this_oBusinessObject.this_cSittricms = ALLTRIM(loc_oPg4.txt_4c_Sittricms.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "txt_4c_Moecusts", 5)
            THIS.this_oBusinessObject.this_cMoecusts = ALLTRIM(loc_oPg4.txt_4c_Moecusts.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "txt_4c_Icms", 5)
            THIS.this_oBusinessObject.this_nIcms = loc_oPg4.txt_4c_Icms.Value
        ENDIF
        IF PEMSTATUS(loc_oPg4, "txt_4c_Tptribs", 5)
            THIS.this_oBusinessObject.this_cTptribs = ALLTRIM(loc_oPg4.txt_4c_Tptribs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "txt_4c_Ipifabs", 5)
            THIS.this_oBusinessObject.this_nIpifabs = loc_oPg4.txt_4c_Ipifabs.Value
        ENDIF
        IF PEMSTATUS(loc_oPg4, "txt_4c_Ipiimpors", 5)
            THIS.this_oBusinessObject.this_nIpiimpors = loc_oPg4.txt_4c_Ipiimpors.Value
        ENDIF
        IF PEMSTATUS(loc_oPg4, "txt_4c_Unificas", 5)
            THIS.this_oBusinessObject.this_cUnificas = ALLTRIM(loc_oPg4.txt_4c_Unificas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "obj_4c_Cestoqs", 5)
            THIS.this_oBusinessObject.this_lCestoqs = (loc_oPg4.obj_4c_Cestoqs.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "obj_4c_Repauts", 5)
            THIS.this_oBusinessObject.this_lRepauts = (loc_oPg4.obj_4c_Repauts.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "obj_4c_Montagens", 5)
            THIS.this_oBusinessObject.this_lMontagens = (loc_oPg4.obj_4c_Montagens.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "obj_4c_Retiras", 5)
            THIS.this_oBusinessObject.this_lRetiras = (loc_oPg4.obj_4c_Retiras.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "obj_4c_Frtsegfs", 5)
            THIS.this_oBusinessObject.this_lFrtsegfs = (loc_oPg4.obj_4c_Frtsegfs.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "obj_4c_Frtseggs", 5)
            THIS.this_oBusinessObject.this_lFrtseggs = (loc_oPg4.obj_4c_Frtseggs.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg4, "obj_4c_Obrigfiscs", 5)
            THIS.this_oBusinessObject.this_lObrigfiscs = (loc_oPg4.obj_4c_Obrigfiscs.Value = 1)
        ENDIF

        *-- Page5: Industria
        LOCAL loc_oPg5
        loc_oPg5 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
        IF PEMSTATUS(loc_oPg5, "txt_4c_Grufins", 5)
            THIS.this_oBusinessObject.this_cGrufins = ALLTRIM(loc_oPg5.txt_4c_Grufins.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "txt_4c_Cmoeds", 5)
            THIS.this_oBusinessObject.this_cCmoeds = ALLTRIM(loc_oPg5.txt_4c_Cmoeds.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "txt_4c_Grupobxps", 5)
            THIS.this_oBusinessObject.this_cGrupobxps = ALLTRIM(loc_oPg5.txt_4c_Grupobxps.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "txt_4c_Contabxps", 5)
            THIS.this_oBusinessObject.this_cContabxps = ALLTRIM(loc_oPg5.txt_4c_Contabxps.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "txt_4c_Descricao", 5)
            THIS.this_oBusinessObject.this_cDcats = ALLTRIM(loc_oPg5.txt_4c_Descricao.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "txt_4c_Premios", 5)
            THIS.this_oBusinessObject.this_nPremios = loc_oPg5.txt_4c_Premios.Value
        ENDIF
        IF PEMSTATUS(loc_oPg5, "txt_4c_Base", 5)
            THIS.this_oBusinessObject.this_cBases = ALLTRIM(loc_oPg5.txt_4c_Base.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "obj_4c_OptGravPeso", 5)
            THIS.this_oBusinessObject.this_lPesmts = (loc_oPg5.obj_4c_OptGravPeso.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "obj_4c_Fwoption1", 5)
            THIS.this_oBusinessObject.this_lTpmovs = (loc_oPg5.obj_4c_Fwoption1.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "obj_4c_Fwoption2", 5)
            THIS.this_oBusinessObject.this_lImpops = (loc_oPg5.obj_4c_Fwoption2.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "obj_4c_Fwoption4", 5)
            THIS.this_oBusinessObject.this_lImpcps = (loc_oPg5.obj_4c_Fwoption4.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "obj_4c_Fwoption5", 5)
            THIS.this_oBusinessObject.this_lNagmts = (loc_oPg5.obj_4c_Fwoption5.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "obj_4c_Fwoption6", 5)
            THIS.this_oBusinessObject.this_lGeratubs = (loc_oPg5.obj_4c_Fwoption6.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "obj_4c_Opt_semiacab", 5)
            THIS.this_oBusinessObject.this_lSemiacabs = (loc_oPg5.obj_4c_Opt_semiacab.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg5, "obj_4c_Opt_ServProd", 5)
            THIS.this_oBusinessObject.this_lServprds = (loc_oPg5.obj_4c_Opt_ServProd.Value = 1)
        ENDIF

        *-- Page6: Configuracao
        LOCAL loc_oPg6
        loc_oPg6 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        IF PEMSTATUS(loc_oPg6, "txt_4c_Grucmvs", 5)
            THIS.this_oBusinessObject.this_cGrucmvs = ALLTRIM(loc_oPg6.txt_4c_Grucmvs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_Concmvs", 5)
            THIS.this_oBusinessObject.this_cConcmvs = ALLTRIM(loc_oPg6.txt_4c_Concmvs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_Gruestps", 5)
            THIS.this_oBusinessObject.this_cGruestps = ALLTRIM(loc_oPg6.txt_4c_Gruestps.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_Conestps", 5)
            THIS.this_oBusinessObject.this_cConestps = ALLTRIM(loc_oPg6.txt_4c_Conestps.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_Grctobccs", 5)
            THIS.this_oBusinessObject.this_cGrctobccs = ALLTRIM(loc_oPg6.txt_4c_Grctobccs.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_Comiss", 5)
            THIS.this_oBusinessObject.this_nComiss = loc_oPg6.txt_4c_Comiss.Value
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_Padlinha", 5)
            THIS.this_oBusinessObject.this_cPadlinha = ALLTRIM(loc_oPg6.txt_4c_Padlinha.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_Padcolec", 5)
            THIS.this_oBusinessObject.this_cPadcolec = ALLTRIM(loc_oPg6.txt_4c_Padcolec.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_Padcclas", 5)
            THIS.this_oBusinessObject.this_cPadcclas = ALLTRIM(loc_oPg6.txt_4c_Padcclas.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_Padfinps", 5)
            THIS.this_oBusinessObject.this_cPadfinps = ALLTRIM(loc_oPg6.txt_4c_Padfinps.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_Padfase", 5)
            THIS.this_oBusinessObject.this_cPadfase = ALLTRIM(loc_oPg6.txt_4c_Padfase.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_Cunips", 5)
            THIS.this_oBusinessObject.this_cCunips = ALLTRIM(loc_oPg6.txt_4c_Cunips.Value)
        ENDIF
        *-- Cores/Tams/Embs/Pesos/Entregas vem da "Grade de Sub-Itens" da aba
        *-- ESTOQUE/FISCAL (Page4), onde o legado os tem como CheckBox. Antes eram
        *-- lidos de OptionGroups que o migrador inventara na Page6. CheckBox.Value
        *-- eh NUMERICO (0/1). Erro175.
        LOCAL loc_oPg4SubIt
        loc_oPg4SubIt = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        IF PEMSTATUS(loc_oPg4SubIt, "chk_4c_Cors", 5)
            THIS.this_oBusinessObject.this_lCores = (loc_oPg4SubIt.chk_4c_Cors.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg4SubIt, "chk_4c_Tams", 5)
            THIS.this_oBusinessObject.this_lTams = (loc_oPg4SubIt.chk_4c_Tams.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg4SubIt, "chk_4c_Embs", 5)
            THIS.this_oBusinessObject.this_lEmbs = (loc_oPg4SubIt.chk_4c_Embs.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg4SubIt, "chk_4c_Pesos", 5)
            THIS.this_oBusinessObject.this_lPesos = (loc_oPg4SubIt.chk_4c_Pesos.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg4SubIt, "chk_4c_Entregas", 5)
            THIS.this_oBusinessObject.this_lEntregas = (loc_oPg4SubIt.chk_4c_Entregas.Value = 1)
        ENDIF
        *-- fornecs: quem grava eh o cbo_4c_Fornecs da aba PRODUTOS (legado
        *-- Get_fornobri), mapeado mais abaixo. O obj_4c_Lfornecs da Page6 era
        *-- duplicata e gravava a MESMA property do BO. Erro175.

        *-- Page6: OptionGroups (pgConfig)
        IF PEMSTATUS(loc_oPg6, "obj_4c_GetInfoGru", 5)
            THIS.this_oBusinessObject.this_lDiggprs = (loc_oPg6.obj_4c_GetInfoGru.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "obj_4c_Fwoption1", 5)
            THIS.this_oBusinessObject.this_lFtecsubs = (loc_oPg6.obj_4c_Fwoption1.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "obj_4c_Fwoption8", 5)
            THIS.this_oBusinessObject.this_lDwvendas = (loc_oPg6.obj_4c_Fwoption8.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "obj_4c_OptICustos", 5)
            THIS.this_oBusinessObject.this_lIcustos = (loc_oPg6.obj_4c_OptICustos.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "obj_4c_Fwoption2", 5)
            THIS.this_oBusinessObject.this_lCaracteris = (loc_oPg6.obj_4c_Fwoption2.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "obj_4c_OptPrdRefCmp", 5)
            THIS.this_oBusinessObject.this_lPrdrefcmp = (loc_oPg6.obj_4c_OptPrdRefCmp.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "obj_4c_Fwoption3", 5)
            THIS.this_oBusinessObject.this_lCvestims = (loc_oPg6.obj_4c_Fwoption3.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "obj_4c_Fwoption6", 5)
            THIS.this_oBusinessObject.this_lNgenerics = (loc_oPg6.obj_4c_Fwoption6.Value = 2)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "obj_4c_OptInstalas", 5)
            THIS.this_oBusinessObject.this_lChkinstalas = (loc_oPg6.obj_4c_OptInstalas.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "obj_4c_Fwoption4", 5)
            THIS.this_oBusinessObject.this_lAtupretam = (loc_oPg6.obj_4c_Fwoption4.Value = 1)
        ENDIF

        *-- Page6: CheckBoxes (pgConfig)
        IF PEMSTATUS(loc_oPg6, "chk_4c_Obrlinha", 5)
            THIS.this_oBusinessObject.this_lObrlinha = (loc_oPg6.chk_4c_Obrlinha.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "chk_4c_Obrcolec", 5)
            THIS.this_oBusinessObject.this_lObrcolec = (loc_oPg6.chk_4c_Obrcolec.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "chk_4c_Obrsgrus", 5)
            THIS.this_oBusinessObject.this_lObrsgrus = (loc_oPg6.chk_4c_Obrsgrus.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "chk_4c_Obridecs", 5)
            THIS.this_oBusinessObject.this_lObridecs = (loc_oPg6.chk_4c_Obridecs.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "chk_4c_Obrcclas", 5)
            THIS.this_oBusinessObject.this_lObrcclas = (loc_oPg6.chk_4c_Obrcclas.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "chk_4c_Obrfinps", 5)
            THIS.this_oBusinessObject.this_lObrfinps = (loc_oPg6.chk_4c_Obrfinps.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "chk_4c_Ajpvens", 5)
            THIS.this_oBusinessObject.this_lAjpvens = (loc_oPg6.chk_4c_Ajpvens.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "chk_4c_Chkmedida", 5)
            THIS.this_oBusinessObject.this_lObrdimes = (loc_oPg6.chk_4c_Chkmedida.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "chk_4c_Obrservico", 5)
            THIS.this_oBusinessObject.this_lObrservico = (loc_oPg6.chk_4c_Obrservico.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "chk_4c_Obrconjuts", 5)
            THIS.this_oBusinessObject.this_lObrconjuts = (loc_oPg6.chk_4c_Obrconjuts.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "chk_4c_Obrpesoms", 5)
            THIS.this_oBusinessObject.this_lObrpesoms = (loc_oPg6.chk_4c_Obrpesoms.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "chk_4c_Vldconjuts", 5)
            THIS.this_oBusinessObject.this_lVldconjuts = (loc_oPg6.chk_4c_Vldconjuts.Value = 1)
        ENDIF

        *-- Page6: Descricoes de preco (pgConfig)
        IF PEMSTATUS(loc_oPg6, "txt_4c_DscPcuss", 5)
            THIS.this_oBusinessObject.this_cDscpcuss = ALLTRIM(loc_oPg6.txt_4c_DscPcuss.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_DscFcustos", 5)
            THIS.this_oBusinessObject.this_cDscfcustos = ALLTRIM(loc_oPg6.txt_4c_DscFcustos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_DscPvideals", 5)
            THIS.this_oBusinessObject.this_cDscpvideals = ALLTRIM(loc_oPg6.txt_4c_DscPvideals.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_DscPvens", 5)
            THIS.this_oBusinessObject.this_cDscpvens = ALLTRIM(loc_oPg6.txt_4c_DscPvens.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_DscFideals", 5)
            THIS.this_oBusinessObject.this_cDscfideals = ALLTRIM(loc_oPg6.txt_4c_DscFideals.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg6, "txt_4c_DscFatuals", 5)
            THIS.this_oBusinessObject.this_cDscfatuals = ALLTRIM(loc_oPg6.txt_4c_DscFatuals.Value)
        ENDIF

        *-- Page8: Codificacao
        LOCAL loc_oPg8
        loc_oPg8 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8
        IF PEMSTATUS(loc_oPg8, "txt_4c_Compos", 5)
            THIS.this_oBusinessObject.this_cCompos = ALLTRIM(loc_oPg8.txt_4c_Compos.Value)
        ENDIF
        IF PEMSTATUS(loc_oPg8, "txt_4c_Digimaxs", 5)
            THIS.this_oBusinessObject.this_nDigimaxs = loc_oPg8.txt_4c_Digimaxs.Value
        ENDIF
        IF PEMSTATUS(loc_oPg8, "txt_4c_Ordcompos", 5)
            THIS.this_oBusinessObject.this_nOrdcompos = loc_oPg8.txt_4c_Ordcompos.Value
        ENDIF
        IF PEMSTATUS(loc_oPg8, "txt_4c_Casas", 5)
            THIS.this_oBusinessObject.this_nCasas = loc_oPg8.txt_4c_Casas.Value
        ENDIF

        *-- Page2: Produtos (controles criados por ConfigurarPgpgProdutos - Erro171)
        LOCAL loc_oPgProd
        loc_oPgProd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Pcustvens", 5)
            THIS.this_oBusinessObject.this_nPcustvens = loc_oPgProd.txt_4c_Pcustvens.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Coefs", 5)
            THIS.this_oBusinessObject.this_nCoefs = loc_oPgProd.txt_4c_Coefs.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Pctdctleis", 5)
            THIS.this_oBusinessObject.this_nPctdctleis = loc_oPgProd.txt_4c_Pctdctleis.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Markaplics", 5)
            THIS.this_oBusinessObject.this_nMarkaplics = loc_oPgProd.txt_4c_Markaplics.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Pcuss", 5)
            THIS.this_oBusinessObject.this_nPcuss = loc_oPgProd.txt_4c_Pcuss.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Fcustos", 5)
            THIS.this_oBusinessObject.this_nFcustos = loc_oPgProd.txt_4c_Fcustos.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Custofs", 5)
            THIS.this_oBusinessObject.this_nCustofs = loc_oPgProd.txt_4c_Custofs.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Pmargems", 5)
            THIS.this_oBusinessObject.this_nPmargens = loc_oPgProd.txt_4c_Pmargems.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Pvideals", 5)
            THIS.this_oBusinessObject.this_nPvideals = loc_oPgProd.txt_4c_Pvideals.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Pvens", 5)
            THIS.this_oBusinessObject.this_nPvens = loc_oPgProd.txt_4c_Pvens.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Varcustots", 5)
            THIS.this_oBusinessObject.this_nVarcustots = loc_oPgProd.txt_4c_Varcustots.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "txt_4c_Varpesoms", 5)
            THIS.this_oBusinessObject.this_nVarpesoms = loc_oPgProd.txt_4c_Varpesoms.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "cbo_4c_Codprods", 5)
            THIS.this_oBusinessObject.this_nCodprods = loc_oPgProd.cbo_4c_Codprods.ListIndex
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "cbo_4c_Montagrds", 5)
            THIS.this_oBusinessObject.this_nMontagrds = loc_oPgProd.cbo_4c_Montagrds.ListIndex
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "cbo_4c_Dsccompras", 5)
            THIS.this_oBusinessObject.this_nDsccompras = loc_oPgProd.cbo_4c_Dsccompras.ListIndex
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "cbo_4c_Atucomps", 5)
            THIS.this_oBusinessObject.this_lAtucomps = (loc_oPgProd.cbo_4c_Atucomps.ListIndex = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "cbo_4c_Bpesos", 5)
            THIS.this_oBusinessObject.this_nBpesos = loc_oPgProd.cbo_4c_Bpesos.ListIndex
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "cbo_4c_Fornecs", 5)
            THIS.this_oBusinessObject.this_lFornecs = (loc_oPgProd.cbo_4c_Fornecs.ListIndex = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "cbo_4c_Montadescs", 5)
            THIS.this_oBusinessObject.this_nMontadescs = loc_oPgProd.cbo_4c_Montadescs.ListIndex
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "cbo_4c_Mncompos", 5)
            THIS.this_oBusinessObject.this_nMncompos = loc_oPgProd.cbo_4c_Mncompos.ListIndex
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "opt_4c_Etidups", 5)
            THIS.this_oBusinessObject.this_lEtidups = (loc_oPgProd.opt_4c_Etidups.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "opt_4c_Sugestaos", 5)
            THIS.this_oBusinessObject.this_lSugestoas = (loc_oPgProd.opt_4c_Sugestaos.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "opt_4c_Pvcompos", 5)
            THIS.this_oBusinessObject.this_lPvcompos = (loc_oPgProd.opt_4c_Pvcompos.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "opt_4c_Mkpobrigs", 5)
            THIS.this_oBusinessObject.this_lMkpobrigs = (loc_oPgProd.opt_4c_Mkpobrigs.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "opt_4c_Chkforcomp", 5)
            THIS.this_oBusinessObject.this_lChkforcomp = (loc_oPgProd.opt_4c_Chkforcomp.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "opt_4c_Respcads", 5)
            THIS.this_oBusinessObject.this_lRespcads = (loc_oPgProd.opt_4c_Respcads.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "opt_4c_Tpcalcps", 5)
            THIS.this_oBusinessObject.this_nTpcalcps = loc_oPgProd.opt_4c_Tpcalcps.Value
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "chk_4c_Loclivre", 5)
            THIS.this_oBusinessObject.this_lLoclivre = (loc_oPgProd.chk_4c_Loclivre.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "chk_4c_Omoecs", 5)
            THIS.this_oBusinessObject.this_lOmoecs = (loc_oPgProd.chk_4c_Omoecs.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "chk_4c_Omoecusfs", 5)
            THIS.this_oBusinessObject.this_lOmoecusfs = (loc_oPgProd.chk_4c_Omoecusfs.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "chk_4c_Omoedas", 5)
            THIS.this_oBusinessObject.this_lOmoedas = (loc_oPgProd.chk_4c_Omoedas.Value = 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProd, "chk_4c_Omoevs", 5)
            THIS.this_oBusinessObject.this_lOmoevs = (loc_oPgProd.chk_4c_Omoevs.Value = 1)
        ENDIF
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para o Form apos carregar registro
    * Usa PEMSTATUS pois controles sao adicionados nas Fases 5-6
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1

        IF PEMSTATUS(loc_oPg1, "txt_4c_Cgrus", 5)
            loc_oPg1.txt_4c_Cgrus.Value  = THIS.this_oBusinessObject.this_cCgrus
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Dgrus", 5)
            loc_oPg1.txt_4c_Dgrus.Value  = THIS.this_oBusinessObject.this_cDgrus
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Mercs", 5)
            loc_oPg1.txt_4c_Mercs.Value  = THIS.this_oBusinessObject.this_cMercs
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Ids", 5)
            loc_oPg1.txt_4c_Ids.Value    = THIS.this_oBusinessObject.this_nIds
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_DiasEnts", 5)
            loc_oPg1.txt_4c_DiasEnts.Value = THIS.this_oBusinessObject.this_nDiasents
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_DiasGar", 5)
            loc_oPg1.txt_4c_DiasGar.Value = THIS.this_oBusinessObject.this_nDiasgar
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_EtiPad", 5)
            loc_oPg1.txt_4c_EtiPad.Value = THIS.this_oBusinessObject.this_cEtipads
        ENDIF
        IF PEMSTATUS(loc_oPg1, "obj_4c_Fwoption1", 5)
            loc_oPg1.obj_4c_Fwoption1.Value = IIF(THIS.this_oBusinessObject.this_lServicos, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg1, "obj_4c_Fwoption2", 5)
            LOCAL loc_nMtp
            loc_nMtp = THIS.this_oBusinessObject.this_nMtprimas
            loc_oPg1.obj_4c_Fwoption2.Value = IIF(loc_nMtp >= 1 AND loc_nMtp <= 4, loc_nMtp, 1)
        ENDIF
        IF PEMSTATUS(loc_oPg1, "chk_4c_Logalt", 5)
            loc_oPg1.chk_4c_Logalt.Value = IIF(THIS.this_oBusinessObject.this_lLogalt, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg1, "obj_4c_OptTipoJoals", 5)
            loc_oPg1.obj_4c_OptTipoJoals.Value = ;
                IIF(THIS.this_oBusinessObject.this_lNtipjoals, 2, 5)
        ENDIF
        THIS.CarregarSigCdPsgCad(THIS.this_oBusinessObject.this_cCgrus)
        THIS.CarregarDescGdeGrupo(THIS.this_oBusinessObject.this_cMercs)

        *-- Page2: Produtos
        LOCAL loc_oPg2B
        loc_oPg2B = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Idecpros", 5)
            loc_oPg2B.txt_4c_Idecpros.Value = THIS.this_oBusinessObject.this_cIdecpros
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Cgrus2", 5)
            loc_oPg2B.txt_4c_Cgrus2.Value = THIS.this_oBusinessObject.this_cCgrus2
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Margems", 5)
            loc_oPg2B.txt_4c_Margems.Value = THIS.this_oBusinessObject.this_nMargens
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Markupa", 5)
            loc_oPg2B.txt_4c_Markupa.Value = THIS.this_oBusinessObject.this_nMarkupa
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Moemrkaps", 5)
            loc_oPg2B.txt_4c_Moemrkaps.Value = THIS.this_oBusinessObject.this_cMoemrkaps
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Arreds", 5)
            loc_oPg2B.txt_4c_Arreds.Value = THIS.this_oBusinessObject.this_nArreds
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Arredcs", 5)
            loc_oPg2B.txt_4c_Arredcs.Value = THIS.this_oBusinessObject.this_nArredcs
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Localpdr", 5)
            loc_oPg2B.txt_4c_Localpdr.Value = THIS.this_oBusinessObject.this_cLocalpdr
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Padmoecs", 5)
            loc_oPg2B.txt_4c_Padmoecs.Value = THIS.this_oBusinessObject.this_cPadmoecs
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Padmoepcs", 5)
            loc_oPg2B.txt_4c_Padmoepcs.Value = THIS.this_oBusinessObject.this_cPadmoepcs
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Padmoedas", 5)
            loc_oPg2B.txt_4c_Padmoedas.Value = THIS.this_oBusinessObject.this_cPadmoedas
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Padmoevs", 5)
            loc_oPg2B.txt_4c_Padmoevs.Value = THIS.this_oBusinessObject.this_cPadmoevs
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Padmoetcs", 5)
            loc_oPg2B.txt_4c_Padmoetcs.Value = THIS.this_oBusinessObject.this_cPadmoetcs
        ENDIF
        IF PEMSTATUS(loc_oPg2B, "txt_4c_Padmargens", 5)
            loc_oPg2B.txt_4c_Padmargens.Value = THIS.this_oBusinessObject.this_nPadmargens
        ENDIF
        THIS.CarregarDescCgrus2(THIS.this_oBusinessObject.this_cCgrus2)
        THIS.CarregarDescMoemrkaps(THIS.this_oBusinessObject.this_cMoemrkaps)

        *-- Page4: Estoque/Fiscal
        LOCAL loc_oPg4B
        loc_oPg4B = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        IF PEMSTATUS(loc_oPg4B, "txt_4c_Clfiscals", 5)
            loc_oPg4B.txt_4c_Clfiscals.Value = THIS.this_oBusinessObject.this_cClfiscals
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "txt_4c_Origmercs", 5)
            loc_oPg4B.txt_4c_Origmercs.Value = THIS.this_oBusinessObject.this_cOrigmercs
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "txt_4c_Sittricms", 5)
            loc_oPg4B.txt_4c_Sittricms.Value = THIS.this_oBusinessObject.this_cSittricms
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "txt_4c_Moecusts", 5)
            loc_oPg4B.txt_4c_Moecusts.Value = THIS.this_oBusinessObject.this_cMoecusts
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "txt_4c_Icms", 5)
            loc_oPg4B.txt_4c_Icms.Value = THIS.this_oBusinessObject.this_nIcms
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "txt_4c_Tptribs", 5)
            loc_oPg4B.txt_4c_Tptribs.Value = THIS.this_oBusinessObject.this_cTptribs
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "txt_4c_Ipifabs", 5)
            loc_oPg4B.txt_4c_Ipifabs.Value = THIS.this_oBusinessObject.this_nIpifabs
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "txt_4c_Ipiimpors", 5)
            loc_oPg4B.txt_4c_Ipiimpors.Value = THIS.this_oBusinessObject.this_nIpiimpors
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "txt_4c_Unificas", 5)
            loc_oPg4B.txt_4c_Unificas.Value = THIS.this_oBusinessObject.this_cUnificas
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "obj_4c_Cestoqs", 5)
            loc_oPg4B.obj_4c_Cestoqs.Value = IIF(THIS.this_oBusinessObject.this_lCestoqs, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "obj_4c_Repauts", 5)
            loc_oPg4B.obj_4c_Repauts.Value = IIF(THIS.this_oBusinessObject.this_lRepauts, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "obj_4c_Montagens", 5)
            loc_oPg4B.obj_4c_Montagens.Value = IIF(THIS.this_oBusinessObject.this_lMontagens, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "obj_4c_Retiras", 5)
            loc_oPg4B.obj_4c_Retiras.Value = IIF(THIS.this_oBusinessObject.this_lRetiras, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "obj_4c_Frtsegfs", 5)
            loc_oPg4B.obj_4c_Frtsegfs.Value = IIF(THIS.this_oBusinessObject.this_lFrtsegfs, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "obj_4c_Frtseggs", 5)
            loc_oPg4B.obj_4c_Frtseggs.Value = IIF(THIS.this_oBusinessObject.this_lFrtseggs, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg4B, "obj_4c_Obrigfiscs", 5)
            loc_oPg4B.obj_4c_Obrigfiscs.Value = IIF(THIS.this_oBusinessObject.this_lObrigfiscs, 1, 2)
        ENDIF
        THIS.CarregarDescClfiscal(THIS.this_oBusinessObject.this_cClfiscals)
        THIS.CarregarDescOrigmerc(THIS.this_oBusinessObject.this_cOrigmercs)
        THIS.CarregarDescSittricm(THIS.this_oBusinessObject.this_cSittricms)
        THIS.CarregarDescMoecust(THIS.this_oBusinessObject.this_cMoecusts)
        THIS.CarregarDescTptrib(THIS.this_oBusinessObject.this_cTptribs)

        *-- Page5: Industria
        LOCAL loc_oPg5B
        loc_oPg5B = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
        IF PEMSTATUS(loc_oPg5B, "txt_4c_Grufins", 5)
            loc_oPg5B.txt_4c_Grufins.Value = THIS.this_oBusinessObject.this_cGrufins
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "txt_4c_Cmoeds", 5)
            loc_oPg5B.txt_4c_Cmoeds.Value = THIS.this_oBusinessObject.this_cCmoeds
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "txt_4c_Grupobxps", 5)
            loc_oPg5B.txt_4c_Grupobxps.Value = THIS.this_oBusinessObject.this_cGrupobxps
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "txt_4c_Contabxps", 5)
            loc_oPg5B.txt_4c_Contabxps.Value = THIS.this_oBusinessObject.this_cContabxps
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "txt_4c_Descricao", 5)
            loc_oPg5B.txt_4c_Descricao.Value = THIS.this_oBusinessObject.this_cDcats
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "txt_4c_Premios", 5)
            loc_oPg5B.txt_4c_Premios.Value = THIS.this_oBusinessObject.this_nPremios
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "txt_4c_Base", 5)
            loc_oPg5B.txt_4c_Base.Value = THIS.this_oBusinessObject.this_cBases
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "obj_4c_OptGravPeso", 5)
            loc_oPg5B.obj_4c_OptGravPeso.Value = IIF(THIS.this_oBusinessObject.this_lPesmts, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "obj_4c_Fwoption1", 5)
            loc_oPg5B.obj_4c_Fwoption1.Value = IIF(THIS.this_oBusinessObject.this_lTpmovs, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "obj_4c_Fwoption2", 5)
            loc_oPg5B.obj_4c_Fwoption2.Value = IIF(THIS.this_oBusinessObject.this_lImpops, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "obj_4c_Fwoption4", 5)
            loc_oPg5B.obj_4c_Fwoption4.Value = IIF(THIS.this_oBusinessObject.this_lImpcps, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "obj_4c_Fwoption5", 5)
            loc_oPg5B.obj_4c_Fwoption5.Value = IIF(THIS.this_oBusinessObject.this_lNagmts, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "obj_4c_Fwoption6", 5)
            loc_oPg5B.obj_4c_Fwoption6.Value = IIF(THIS.this_oBusinessObject.this_lGeratubs, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "obj_4c_Opt_semiacab", 5)
            loc_oPg5B.obj_4c_Opt_semiacab.Value = IIF(THIS.this_oBusinessObject.this_lSemiacabs, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg5B, "obj_4c_Opt_ServProd", 5)
            loc_oPg5B.obj_4c_Opt_ServProd.Value = IIF(THIS.this_oBusinessObject.this_lServprds, 1, 2)
        ENDIF
        THIS.CarregarDescGrufins(THIS.this_oBusinessObject.this_cGrufins)
        THIS.CarregarDescCmoeds(THIS.this_oBusinessObject.this_cCmoeds)

        *-- Page6: Configuracao
        LOCAL loc_oPg6B
        loc_oPg6B = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Grucmvs", 5)
            loc_oPg6B.txt_4c_Grucmvs.Value = THIS.this_oBusinessObject.this_cGrucmvs
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Concmvs", 5)
            loc_oPg6B.txt_4c_Concmvs.Value = THIS.this_oBusinessObject.this_cConcmvs
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Gruestps", 5)
            loc_oPg6B.txt_4c_Gruestps.Value = THIS.this_oBusinessObject.this_cGruestps
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Conestps", 5)
            loc_oPg6B.txt_4c_Conestps.Value = THIS.this_oBusinessObject.this_cConestps
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Grctobccs", 5)
            loc_oPg6B.txt_4c_Grctobccs.Value = THIS.this_oBusinessObject.this_cGrctobccs
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Comiss", 5)
            loc_oPg6B.txt_4c_Comiss.Value = THIS.this_oBusinessObject.this_nComiss
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Padlinha", 5)
            loc_oPg6B.txt_4c_Padlinha.Value = THIS.this_oBusinessObject.this_cPadlinha
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Padcolec", 5)
            loc_oPg6B.txt_4c_Padcolec.Value = THIS.this_oBusinessObject.this_cPadcolec
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Padcclas", 5)
            loc_oPg6B.txt_4c_Padcclas.Value = THIS.this_oBusinessObject.this_cPadcclas
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Padfinps", 5)
            loc_oPg6B.txt_4c_Padfinps.Value = THIS.this_oBusinessObject.this_cPadfinps
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Padfase", 5)
            loc_oPg6B.txt_4c_Padfase.Value = THIS.this_oBusinessObject.this_cPadfase
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_Cunips", 5)
            loc_oPg6B.txt_4c_Cunips.Value = THIS.this_oBusinessObject.this_cCunips
        ENDIF
        *-- Grade de Sub-Itens na aba ESTOQUE/FISCAL (Page4), CheckBox 0/1. Erro175.
        LOCAL loc_oPg4SubItB
        loc_oPg4SubItB = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        IF PEMSTATUS(loc_oPg4SubItB, "chk_4c_Cors", 5)
            loc_oPg4SubItB.chk_4c_Cors.Value = IIF(THIS.this_oBusinessObject.this_lCores, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg4SubItB, "chk_4c_Tams", 5)
            loc_oPg4SubItB.chk_4c_Tams.Value = IIF(THIS.this_oBusinessObject.this_lTams, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg4SubItB, "chk_4c_Embs", 5)
            loc_oPg4SubItB.chk_4c_Embs.Value = IIF(THIS.this_oBusinessObject.this_lEmbs, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg4SubItB, "chk_4c_Pesos", 5)
            loc_oPg4SubItB.chk_4c_Pesos.Value = IIF(THIS.this_oBusinessObject.this_lPesos, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg4SubItB, "chk_4c_Entregas", 5)
            loc_oPg4SubItB.chk_4c_Entregas.Value = IIF(THIS.this_oBusinessObject.this_lEntregas, 1, 0)
        ENDIF
        *-- fornecs: exibido pelo cbo_4c_Fornecs da aba PRODUTOS, mais abaixo. Erro175.
        THIS.CarregarDescGrucmvs(THIS.this_oBusinessObject.this_cGrucmvs)
        THIS.CarregarDescPadlinha(THIS.this_oBusinessObject.this_cPadlinha)
        THIS.CarregarDescPadcolec(THIS.this_oBusinessObject.this_cPadcolec)
        THIS.CarregarDescPadfinps(THIS.this_oBusinessObject.this_cPadfinps)
        THIS.CarregarDescPadfase(THIS.this_oBusinessObject.this_cPadfase)
        THIS.CarregarDescCunips(THIS.this_oBusinessObject.this_cCunips)

        *-- Page6: OptionGroups (pgConfig)
        IF PEMSTATUS(loc_oPg6B, "obj_4c_GetInfoGru", 5)
            loc_oPg6B.obj_4c_GetInfoGru.Value = IIF(THIS.this_oBusinessObject.this_lDiggprs, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "obj_4c_Fwoption1", 5)
            loc_oPg6B.obj_4c_Fwoption1.Value = IIF(THIS.this_oBusinessObject.this_lFtecsubs, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "obj_4c_Fwoption8", 5)
            loc_oPg6B.obj_4c_Fwoption8.Value = IIF(THIS.this_oBusinessObject.this_lDwvendas, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "obj_4c_OptICustos", 5)
            loc_oPg6B.obj_4c_OptICustos.Value = IIF(THIS.this_oBusinessObject.this_lIcustos, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "obj_4c_Fwoption2", 5)
            loc_oPg6B.obj_4c_Fwoption2.Value = IIF(THIS.this_oBusinessObject.this_lCaracteris, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "obj_4c_OptPrdRefCmp", 5)
            loc_oPg6B.obj_4c_OptPrdRefCmp.Value = IIF(THIS.this_oBusinessObject.this_lPrdrefcmp, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "obj_4c_Fwoption3", 5)
            loc_oPg6B.obj_4c_Fwoption3.Value = IIF(THIS.this_oBusinessObject.this_lCvestims, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "obj_4c_Fwoption6", 5)
            loc_oPg6B.obj_4c_Fwoption6.Value = IIF(THIS.this_oBusinessObject.this_lNgenerics, 2, 1)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "obj_4c_OptInstalas", 5)
            loc_oPg6B.obj_4c_OptInstalas.Value = IIF(THIS.this_oBusinessObject.this_lChkinstalas, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "obj_4c_Fwoption4", 5)
            loc_oPg6B.obj_4c_Fwoption4.Value = IIF(THIS.this_oBusinessObject.this_lAtupretam, 1, 2)
        ENDIF

        *-- Page6: CheckBoxes (pgConfig)
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Obrlinha", 5)
            loc_oPg6B.chk_4c_Obrlinha.Value = IIF(THIS.this_oBusinessObject.this_lObrlinha, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Obrcolec", 5)
            loc_oPg6B.chk_4c_Obrcolec.Value = IIF(THIS.this_oBusinessObject.this_lObrcolec, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Obrsgrus", 5)
            loc_oPg6B.chk_4c_Obrsgrus.Value = IIF(THIS.this_oBusinessObject.this_lObrsgrus, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Obridecs", 5)
            loc_oPg6B.chk_4c_Obridecs.Value = IIF(THIS.this_oBusinessObject.this_lObridecs, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Obrcclas", 5)
            loc_oPg6B.chk_4c_Obrcclas.Value = IIF(THIS.this_oBusinessObject.this_lObrcclas, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Obrfinps", 5)
            loc_oPg6B.chk_4c_Obrfinps.Value = IIF(THIS.this_oBusinessObject.this_lObrfinps, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Ajpvens", 5)
            loc_oPg6B.chk_4c_Ajpvens.Value = IIF(THIS.this_oBusinessObject.this_lAjpvens, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Chkmedida", 5)
            loc_oPg6B.chk_4c_Chkmedida.Value = IIF(THIS.this_oBusinessObject.this_lObrdimes, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Obrservico", 5)
            loc_oPg6B.chk_4c_Obrservico.Value = IIF(THIS.this_oBusinessObject.this_lObrservico, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Obrconjuts", 5)
            loc_oPg6B.chk_4c_Obrconjuts.Value = IIF(THIS.this_oBusinessObject.this_lObrconjuts, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Obrpesoms", 5)
            loc_oPg6B.chk_4c_Obrpesoms.Value = IIF(THIS.this_oBusinessObject.this_lObrpesoms, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "chk_4c_Vldconjuts", 5)
            loc_oPg6B.chk_4c_Vldconjuts.Value = IIF(THIS.this_oBusinessObject.this_lVldconjuts, 1, 0)
        ENDIF

        *-- Page6: Descricoes de preco (pgConfig)
        IF PEMSTATUS(loc_oPg6B, "txt_4c_DscPcuss", 5)
            loc_oPg6B.txt_4c_DscPcuss.Value = THIS.this_oBusinessObject.this_cDscpcuss
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_DscFcustos", 5)
            loc_oPg6B.txt_4c_DscFcustos.Value = THIS.this_oBusinessObject.this_cDscfcustos
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_DscPvideals", 5)
            loc_oPg6B.txt_4c_DscPvideals.Value = THIS.this_oBusinessObject.this_cDscpvideals
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_DscPvens", 5)
            loc_oPg6B.txt_4c_DscPvens.Value = THIS.this_oBusinessObject.this_cDscpvens
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_DscFideals", 5)
            loc_oPg6B.txt_4c_DscFideals.Value = THIS.this_oBusinessObject.this_cDscfideals
        ENDIF
        IF PEMSTATUS(loc_oPg6B, "txt_4c_DscFatuals", 5)
            loc_oPg6B.txt_4c_DscFatuals.Value = THIS.this_oBusinessObject.this_cDscfatuals
        ENDIF

        *-- Page8: Codificacao
        LOCAL loc_oPg8B
        loc_oPg8B = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8
        IF PEMSTATUS(loc_oPg8B, "txt_4c_Compos", 5)
            loc_oPg8B.txt_4c_Compos.Value = THIS.this_oBusinessObject.this_cCompos
        ENDIF
        IF PEMSTATUS(loc_oPg8B, "txt_4c_Digimaxs", 5)
            loc_oPg8B.txt_4c_Digimaxs.Value = THIS.this_oBusinessObject.this_nDigimaxs
        ENDIF
        IF PEMSTATUS(loc_oPg8B, "txt_4c_Ordcompos", 5)
            loc_oPg8B.txt_4c_Ordcompos.Value = THIS.this_oBusinessObject.this_nOrdcompos
        ENDIF
        IF PEMSTATUS(loc_oPg8B, "txt_4c_Casas", 5)
            loc_oPg8B.txt_4c_Casas.Value = THIS.this_oBusinessObject.this_nCasas
        ENDIF

        *-- Carregar crGrpMonta e crMontagem para grid de codificacao
        THIS.CarregarCrGrpMonta()
        THIS.CarregarCrMontagem(THIS.this_oBusinessObject.this_cCgrus, ;
            THIS.this_oBusinessObject.this_nCodprods)
        THIS.AtualizaMontagem(.F.)

        *-- Carregar crSigcdcpo para aba Compos (Page9)
        THIS.CarregarSigcdcpo(THIS.this_oBusinessObject.this_cCgrus)
        LOCAL loc_oPg9B
        loc_oPg9B = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9
        IF PEMSTATUS(loc_oPg9B, "cnt_4c_FiltroCompos", 5)
            IF PEMSTATUS(loc_oPg9B.cnt_4c_FiltroCompos, "txt_4c_FiltGrupo", 5)
                loc_oPg9B.cnt_4c_FiltroCompos.txt_4c_FiltGrupo.Value = ;
                    THIS.this_oBusinessObject.this_cDgrus
            ENDIF
        ENDIF

        *-- Visibilidade do cmdGrade conforme modo
        IF PEMSTATUS(loc_oPg8B, "obj_4c_CmdGrade", 5)
            loc_oPg8B.obj_4c_CmdGrade.Visible = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        ENDIF

        *-- Page3: Descricao (pgDescrs) - carregar LocalProD
        THIS.CarregarLocalProD(THIS.this_oBusinessObject.this_cCgrus)
        THIS.AtualizarCmbDescrs()

        *-- Page2: Produtos (controles criados por ConfigurarPgpgProdutos - Erro171)
        LOCAL loc_oPgProdB
        loc_oPgProdB = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Pcustvens", 5)
            loc_oPgProdB.txt_4c_Pcustvens.Value = THIS.this_oBusinessObject.this_nPcustvens
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Coefs", 5)
            loc_oPgProdB.txt_4c_Coefs.Value = THIS.this_oBusinessObject.this_nCoefs
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Pctdctleis", 5)
            loc_oPgProdB.txt_4c_Pctdctleis.Value = THIS.this_oBusinessObject.this_nPctdctleis
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Markaplics", 5)
            loc_oPgProdB.txt_4c_Markaplics.Value = THIS.this_oBusinessObject.this_nMarkaplics
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Pcuss", 5)
            loc_oPgProdB.txt_4c_Pcuss.Value = THIS.this_oBusinessObject.this_nPcuss
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Fcustos", 5)
            loc_oPgProdB.txt_4c_Fcustos.Value = THIS.this_oBusinessObject.this_nFcustos
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Custofs", 5)
            loc_oPgProdB.txt_4c_Custofs.Value = THIS.this_oBusinessObject.this_nCustofs
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Pmargems", 5)
            loc_oPgProdB.txt_4c_Pmargems.Value = THIS.this_oBusinessObject.this_nPmargens
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Pvideals", 5)
            loc_oPgProdB.txt_4c_Pvideals.Value = THIS.this_oBusinessObject.this_nPvideals
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Pvens", 5)
            loc_oPgProdB.txt_4c_Pvens.Value = THIS.this_oBusinessObject.this_nPvens
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Varcustots", 5)
            loc_oPgProdB.txt_4c_Varcustots.Value = THIS.this_oBusinessObject.this_nVarcustots
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "txt_4c_Varpesoms", 5)
            loc_oPgProdB.txt_4c_Varpesoms.Value = THIS.this_oBusinessObject.this_nVarpesoms
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "cbo_4c_Codprods", 5)
            loc_oPgProdB.cbo_4c_Codprods.ListIndex = ;
                IIF(THIS.this_oBusinessObject.this_nCodprods >= 1, THIS.this_oBusinessObject.this_nCodprods, 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "cbo_4c_Montagrds", 5)
            loc_oPgProdB.cbo_4c_Montagrds.ListIndex = ;
                IIF(THIS.this_oBusinessObject.this_nMontagrds >= 1, THIS.this_oBusinessObject.this_nMontagrds, 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "cbo_4c_Dsccompras", 5)
            loc_oPgProdB.cbo_4c_Dsccompras.ListIndex = ;
                IIF(THIS.this_oBusinessObject.this_nDsccompras >= 1, THIS.this_oBusinessObject.this_nDsccompras, 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "cbo_4c_Atucomps", 5)
            loc_oPgProdB.cbo_4c_Atucomps.ListIndex = IIF(THIS.this_oBusinessObject.this_lAtucomps, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "cbo_4c_Bpesos", 5)
            loc_oPgProdB.cbo_4c_Bpesos.ListIndex = ;
                IIF(THIS.this_oBusinessObject.this_nBpesos >= 1, THIS.this_oBusinessObject.this_nBpesos, 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "cbo_4c_Fornecs", 5)
            loc_oPgProdB.cbo_4c_Fornecs.ListIndex = IIF(THIS.this_oBusinessObject.this_lFornecs, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "cbo_4c_Montadescs", 5)
            loc_oPgProdB.cbo_4c_Montadescs.ListIndex = ;
                IIF(THIS.this_oBusinessObject.this_nMontadescs >= 1, THIS.this_oBusinessObject.this_nMontadescs, 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "cbo_4c_Mncompos", 5)
            loc_oPgProdB.cbo_4c_Mncompos.ListIndex = ;
                IIF(THIS.this_oBusinessObject.this_nMncompos >= 1, THIS.this_oBusinessObject.this_nMncompos, 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "opt_4c_Etidups", 5)
            loc_oPgProdB.opt_4c_Etidups.Value = IIF(THIS.this_oBusinessObject.this_lEtidups, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "opt_4c_Sugestaos", 5)
            loc_oPgProdB.opt_4c_Sugestaos.Value = IIF(THIS.this_oBusinessObject.this_lSugestoas, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "opt_4c_Pvcompos", 5)
            loc_oPgProdB.opt_4c_Pvcompos.Value = IIF(THIS.this_oBusinessObject.this_lPvcompos, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "opt_4c_Mkpobrigs", 5)
            loc_oPgProdB.opt_4c_Mkpobrigs.Value = IIF(THIS.this_oBusinessObject.this_lMkpobrigs, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "opt_4c_Chkforcomp", 5)
            loc_oPgProdB.opt_4c_Chkforcomp.Value = IIF(THIS.this_oBusinessObject.this_lChkforcomp, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "opt_4c_Respcads", 5)
            loc_oPgProdB.opt_4c_Respcads.Value = IIF(THIS.this_oBusinessObject.this_lRespcads, 1, 2)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "opt_4c_Tpcalcps", 5)
            loc_oPgProdB.opt_4c_Tpcalcps.Value = ;
                IIF(THIS.this_oBusinessObject.this_nTpcalcps >= 1, THIS.this_oBusinessObject.this_nTpcalcps, 1)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "chk_4c_Loclivre", 5)
            loc_oPgProdB.chk_4c_Loclivre.Value = IIF(THIS.this_oBusinessObject.this_lLoclivre, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "chk_4c_Omoecs", 5)
            loc_oPgProdB.chk_4c_Omoecs.Value = IIF(THIS.this_oBusinessObject.this_lOmoecs, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "chk_4c_Omoecusfs", 5)
            loc_oPgProdB.chk_4c_Omoecusfs.Value = IIF(THIS.this_oBusinessObject.this_lOmoecusfs, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "chk_4c_Omoedas", 5)
            loc_oPgProdB.chk_4c_Omoedas.Value = IIF(THIS.this_oBusinessObject.this_lOmoedas, 1, 0)
        ENDIF
        IF PEMSTATUS(loc_oPgProdB, "chk_4c_Omoevs", 5)
            loc_oPgProdB.chk_4c_Omoevs.Value = IIF(THIS.this_oBusinessObject.this_lOmoevs, 1, 0)
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    * Retorna .T. se valido, .F. se invalido (com mensagem ao usuario)
    *==========================================================================
    PROTECTED FUNCTION ValidarDados()
        LOCAL loc_lValido, loc_oPg1, loc_cCgrus, loc_cDgrus
        loc_lValido = .T.
        loc_oPg1    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1

        TRY
            *-- Validar Codigo (cgrus) obrigatorio
            IF PEMSTATUS(loc_oPg1, "txt_4c_Cgrus", 5)
                loc_cCgrus = ALLTRIM(loc_oPg1.txt_4c_Cgrus.Value)
                IF EMPTY(loc_cCgrus)
                    MsgAviso("C" + CHR(243) + "digo do grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.")
                    loc_oPg1.txt_4c_Cgrus.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

            *-- Validar Descricao (dgrus) obrigatorio
            IF loc_lValido AND PEMSTATUS(loc_oPg1, "txt_4c_Dgrus", 5)
                loc_cDgrus = ALLTRIM(loc_oPg1.txt_4c_Dgrus.Value)
                IF EMPTY(loc_cDgrus)
                    MsgAviso("Descri" + CHR(231) + CHR(227) + "o do grupo " + CHR(233) + " obrigat" + CHR(243) + "ria.")
                    loc_oPg1.txt_4c_Dgrus.SetFocus()
                    loc_lValido = .F.
                ENDIF
            ENDIF

            *-- Validar codificacao de produto (CodProds=6)
            IF loc_lValido AND THIS.this_oBusinessObject.this_nCodprods = 6
                IF !THIS.AtualizaMontagem(.T.)
                    loc_lValido = .F.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro na valida" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message, "FormGpd.ValidarDados")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2 para novo registro
    * Usa PEMSTATUS pois controles sao adicionados nas Fases 5-6
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1

        IF PEMSTATUS(loc_oPg1, "txt_4c_Cgrus", 5)
            loc_oPg1.txt_4c_Cgrus.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Dgrus", 5)
            loc_oPg1.txt_4c_Dgrus.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Mercs", 5)
            loc_oPg1.txt_4c_Mercs.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Ids", 5)
            loc_oPg1.txt_4c_Ids.Value     = 0
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_DiasEnts", 5)
            loc_oPg1.txt_4c_DiasEnts.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_DiasGar", 5)
            loc_oPg1.txt_4c_DiasGar.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_EtiPad", 5)
            loc_oPg1.txt_4c_EtiPad.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_DgdeMercs", 5)
            loc_oPg1.txt_4c_DgdeMercs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg1, "obj_4c_Fwoption1", 5)
            loc_oPg1.obj_4c_Fwoption1.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg1, "obj_4c_Fwoption2", 5)
            loc_oPg1.obj_4c_Fwoption2.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg1, "chk_4c_Logalt", 5)
            loc_oPg1.chk_4c_Logalt.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg1, "obj_4c_OptTipoJoals", 5)
            loc_oPg1.obj_4c_OptTipoJoals.Value = 5
        ENDIF
        IF USED("cursor_4c_SigCdPsg")
            SELECT cursor_4c_SigCdPsg
            ZAP
        ENDIF
        IF USED("cursor_4c_Prazos")
            SELECT cursor_4c_Prazos
            ZAP
        ENDIF

        *-- Page9: Compos
        IF USED("crSigcdcpo")
            SELECT crSigcdcpo
            ZAP
        ENDIF
        LOCAL loc_oPg9C
        loc_oPg9C = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9
        IF PEMSTATUS(loc_oPg9C, "cnt_4c_FiltroCompos", 5)
            IF PEMSTATUS(loc_oPg9C.cnt_4c_FiltroCompos, "txt_4c_FiltGrupo", 5)
                loc_oPg9C.cnt_4c_FiltroCompos.txt_4c_FiltGrupo.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg9C.cnt_4c_FiltroCompos, "txt_4c_FiltPreco", 5)
                loc_oPg9C.cnt_4c_FiltroCompos.txt_4c_FiltPreco.Value = ""
            ENDIF
            IF PEMSTATUS(loc_oPg9C.cnt_4c_FiltroCompos, "txt_4c_FiltTipo", 5)
                loc_oPg9C.cnt_4c_FiltroCompos.txt_4c_FiltTipo.Value = ""
            ENDIF
        ENDIF

        *-- Page2: Produtos
        LOCAL loc_oPg2C
        loc_oPg2C = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Idecpros", 5)
            loc_oPg2C.txt_4c_Idecpros.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Cgrus2", 5)
            loc_oPg2C.txt_4c_Cgrus2.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_DescCgrus2", 5)
            loc_oPg2C.txt_4c_DescCgrus2.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Margems", 5)
            loc_oPg2C.txt_4c_Margems.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Markupa", 5)
            loc_oPg2C.txt_4c_Markupa.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Moemrkaps", 5)
            loc_oPg2C.txt_4c_Moemrkaps.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_DescMoemrkaps", 5)
            loc_oPg2C.txt_4c_DescMoemrkaps.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Arreds", 5)
            loc_oPg2C.txt_4c_Arreds.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Arredcs", 5)
            loc_oPg2C.txt_4c_Arredcs.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Localpdr", 5)
            loc_oPg2C.txt_4c_Localpdr.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Padmoecs", 5)
            loc_oPg2C.txt_4c_Padmoecs.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Padmoepcs", 5)
            loc_oPg2C.txt_4c_Padmoepcs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Padmoedas", 5)
            loc_oPg2C.txt_4c_Padmoedas.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Padmoevs", 5)
            loc_oPg2C.txt_4c_Padmoevs.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Padmoetcs", 5)
            loc_oPg2C.txt_4c_Padmoetcs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg2C, "txt_4c_Padmargens", 5)
            loc_oPg2C.txt_4c_Padmargens.Value = 0
        ENDIF

        *-- Page4: Estoque/Fiscal
        LOCAL loc_oPg4C
        loc_oPg4C = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        IF PEMSTATUS(loc_oPg4C, "txt_4c_Clfiscals", 5)
            loc_oPg4C.txt_4c_Clfiscals.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_DescClfiscal", 5)
            loc_oPg4C.txt_4c_DescClfiscal.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_Origmercs", 5)
            loc_oPg4C.txt_4c_Origmercs.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_DescOrigmerc", 5)
            loc_oPg4C.txt_4c_DescOrigmerc.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_Sittricms", 5)
            loc_oPg4C.txt_4c_Sittricms.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_DescSittricm", 5)
            loc_oPg4C.txt_4c_DescSittricm.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_Moecusts", 5)
            loc_oPg4C.txt_4c_Moecusts.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_DescMoecust", 5)
            loc_oPg4C.txt_4c_DescMoecust.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_Icms", 5)
            loc_oPg4C.txt_4c_Icms.Value       = 0
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_Tptribs", 5)
            loc_oPg4C.txt_4c_Tptribs.Value    = ""
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_DescTptrib", 5)
            loc_oPg4C.txt_4c_DescTptrib.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_Ipifabs", 5)
            loc_oPg4C.txt_4c_Ipifabs.Value    = 0
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_Ipiimpors", 5)
            loc_oPg4C.txt_4c_Ipiimpors.Value  = 0
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "txt_4c_Unificas", 5)
            loc_oPg4C.txt_4c_Unificas.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "obj_4c_Cestoqs", 5)
            loc_oPg4C.obj_4c_Cestoqs.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "obj_4c_Repauts", 5)
            loc_oPg4C.obj_4c_Repauts.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "obj_4c_Montagens", 5)
            loc_oPg4C.obj_4c_Montagens.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "obj_4c_Retiras", 5)
            loc_oPg4C.obj_4c_Retiras.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "obj_4c_Frtsegfs", 5)
            loc_oPg4C.obj_4c_Frtsegfs.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "obj_4c_Frtseggs", 5)
            loc_oPg4C.obj_4c_Frtseggs.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg4C, "obj_4c_Obrigfiscs", 5)
            loc_oPg4C.obj_4c_Obrigfiscs.Value = 2
        ENDIF

        *-- Page5: Industria
        LOCAL loc_oPg5C
        loc_oPg5C = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
        IF PEMSTATUS(loc_oPg5C, "txt_4c_Grufins", 5)
            loc_oPg5C.txt_4c_Grufins.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "txt_4c_DescGrufins", 5)
            loc_oPg5C.txt_4c_DescGrufins.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "txt_4c_Cmoeds", 5)
            loc_oPg5C.txt_4c_Cmoeds.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "txt_4c_DescCmoeds", 5)
            loc_oPg5C.txt_4c_DescCmoeds.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "txt_4c_Grupobxps", 5)
            loc_oPg5C.txt_4c_Grupobxps.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "txt_4c_Contabxps", 5)
            loc_oPg5C.txt_4c_Contabxps.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "txt_4c_Descricao", 5)
            loc_oPg5C.txt_4c_Descricao.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "txt_4c_Premios", 5)
            loc_oPg5C.txt_4c_Premios.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "txt_4c_Base", 5)
            loc_oPg5C.txt_4c_Base.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "obj_4c_OptGravPeso", 5)
            loc_oPg5C.obj_4c_OptGravPeso.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "obj_4c_Fwoption1", 5)
            loc_oPg5C.obj_4c_Fwoption1.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "obj_4c_Fwoption2", 5)
            loc_oPg5C.obj_4c_Fwoption2.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "obj_4c_Fwoption4", 5)
            loc_oPg5C.obj_4c_Fwoption4.Value = 3
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "obj_4c_Fwoption5", 5)
            loc_oPg5C.obj_4c_Fwoption5.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "obj_4c_Fwoption6", 5)
            loc_oPg5C.obj_4c_Fwoption6.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "obj_4c_Opt_semiacab", 5)
            loc_oPg5C.obj_4c_Opt_semiacab.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg5C, "obj_4c_Opt_ServProd", 5)
            loc_oPg5C.obj_4c_Opt_ServProd.Value = 2
        ENDIF

        *-- Page6: Configuracao
        LOCAL loc_oPg6C
        loc_oPg6C = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Grucmvs", 5)
            loc_oPg6C.txt_4c_Grucmvs.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DescGrucmvs", 5)
            loc_oPg6C.txt_4c_DescGrucmvs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Concmvs", 5)
            loc_oPg6C.txt_4c_Concmvs.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DescConcmvs", 5)
            loc_oPg6C.txt_4c_DescConcmvs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Gruestps", 5)
            loc_oPg6C.txt_4c_Gruestps.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Conestps", 5)
            loc_oPg6C.txt_4c_Conestps.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Grctobccs", 5)
            loc_oPg6C.txt_4c_Grctobccs.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Comiss", 5)
            loc_oPg6C.txt_4c_Comiss.Value   = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Padlinha", 5)
            loc_oPg6C.txt_4c_Padlinha.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DescPadlinha", 5)
            loc_oPg6C.txt_4c_DescPadlinha.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Padcolec", 5)
            loc_oPg6C.txt_4c_Padcolec.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DescPadcolec", 5)
            loc_oPg6C.txt_4c_DescPadcolec.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Padcclas", 5)
            loc_oPg6C.txt_4c_Padcclas.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Padfinps", 5)
            loc_oPg6C.txt_4c_Padfinps.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DescPadfinps", 5)
            loc_oPg6C.txt_4c_DescPadfinps.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Padfase", 5)
            loc_oPg6C.txt_4c_Padfase.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DescPadfase", 5)
            loc_oPg6C.txt_4c_DescPadfase.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Cunips", 5)
            loc_oPg6C.txt_4c_Cunips.Value   = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DescCunips", 5)
            loc_oPg6C.txt_4c_DescCunips.Value = ""
        ENDIF
        *-- Grade de Sub-Itens: limpa os CheckBox da aba ESTOQUE/FISCAL (Page4).
        *-- Antes limpava OptionGroups que o migrador inventara na Page6. Erro175.
        LOCAL loc_oPg4SubItC
        loc_oPg4SubItC = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        IF PEMSTATUS(loc_oPg4SubItC, "chk_4c_Cors", 5)
            loc_oPg4SubItC.chk_4c_Cors.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg4SubItC, "chk_4c_Tams", 5)
            loc_oPg4SubItC.chk_4c_Tams.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg4SubItC, "chk_4c_Embs", 5)
            loc_oPg4SubItC.chk_4c_Embs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg4SubItC, "chk_4c_Pesos", 5)
            loc_oPg4SubItC.chk_4c_Pesos.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg4SubItC, "chk_4c_Entregas", 5)
            loc_oPg4SubItC.chk_4c_Entregas.Value = 0
        ENDIF

        *-- Page6: OptionGroups (pgConfig)
        IF PEMSTATUS(loc_oPg6C, "obj_4c_GetInfoGru", 5)
            loc_oPg6C.obj_4c_GetInfoGru.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_Fwoption1", 5)
            loc_oPg6C.obj_4c_Fwoption1.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_Fwoption8", 5)
            loc_oPg6C.obj_4c_Fwoption8.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_OptICustos", 5)
            loc_oPg6C.obj_4c_OptICustos.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_Fwoption2", 5)
            loc_oPg6C.obj_4c_Fwoption2.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_OptRecPesC", 5)
            loc_oPg6C.obj_4c_OptRecPesC.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_OptCompIna", 5)
            loc_oPg6C.obj_4c_OptCompIna.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_OptPrdRefCmp", 5)
            loc_oPg6C.obj_4c_OptPrdRefCmp.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_Fwoption3", 5)
            loc_oPg6C.obj_4c_Fwoption3.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_Fwoption6", 5)
            loc_oPg6C.obj_4c_Fwoption6.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_OptInstalas", 5)
            loc_oPg6C.obj_4c_OptInstalas.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_OptQtdRPP", 5)
            loc_oPg6C.obj_4c_OptQtdRPP.Value = 1
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_Fwoption4", 5)
            loc_oPg6C.obj_4c_Fwoption4.Value = 2
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "obj_4c_Fwoption5", 5)
            loc_oPg6C.obj_4c_Fwoption5.Value = 2
        ENDIF

        *-- Page6: CheckBoxes (pgConfig)
        IF PEMSTATUS(loc_oPg6C, "chk_4c_ChkOCCuss", 5)
            loc_oPg6C.chk_4c_ChkOCCuss.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Obrlinha", 5)
            loc_oPg6C.chk_4c_Obrlinha.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Obrcolec", 5)
            loc_oPg6C.chk_4c_Obrcolec.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Obrsgrus", 5)
            loc_oPg6C.chk_4c_Obrsgrus.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Obridecs", 5)
            loc_oPg6C.chk_4c_Obridecs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Obrcclas", 5)
            loc_oPg6C.chk_4c_Obrcclas.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Obrfinps", 5)
            loc_oPg6C.chk_4c_Obrfinps.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Ajpvens", 5)
            loc_oPg6C.chk_4c_Ajpvens.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Eqvobrigs", 5)
            loc_oPg6C.chk_4c_Eqvobrigs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Chkmedida", 5)
            loc_oPg6C.chk_4c_Chkmedida.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Obrservico", 5)
            loc_oPg6C.chk_4c_Obrservico.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Chkaltsubgs", 5)
            loc_oPg6C.chk_4c_Chkaltsubgs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Obrconjuts", 5)
            loc_oPg6C.chk_4c_Obrconjuts.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Obrpesoms", 5)
            loc_oPg6C.chk_4c_Obrpesoms.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Chkmpobriga", 5)
            loc_oPg6C.chk_4c_Chkmpobriga.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Chkobrigcompos", 5)
            loc_oPg6C.chk_4c_Chkobrigcompos.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Vldconjuts", 5)
            loc_oPg6C.chk_4c_Vldconjuts.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "chk_4c_Chkunidade2", 5)
            loc_oPg6C.chk_4c_Chkunidade2.Value = 0
        ENDIF

        *-- Page6: Descricoes de preco (pgConfig)
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DscPcuss", 5)
            loc_oPg6C.txt_4c_DscPcuss.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DscFcustos", 5)
            loc_oPg6C.txt_4c_DscFcustos.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DscPvideals", 5)
            loc_oPg6C.txt_4c_DscPvideals.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DscPvens", 5)
            loc_oPg6C.txt_4c_DscPvens.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DscFideals", 5)
            loc_oPg6C.txt_4c_DscFideals.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_DscFatuals", 5)
            loc_oPg6C.txt_4c_DscFatuals.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_Unidade2", 5)
            loc_oPg6C.txt_4c_Unidade2.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_MinRefFors", 5)
            loc_oPg6C.txt_4c_MinRefFors.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg6C, "txt_4c_MinObsComs", 5)
            loc_oPg6C.txt_4c_MinObsComs.Value = 0
        ENDIF

        *-- Page8: Codificacao
        LOCAL loc_oPg8C
        loc_oPg8C = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8
        IF PEMSTATUS(loc_oPg8C, "txt_4c_Compos", 5)
            loc_oPg8C.txt_4c_Compos.Value  = ""
        ENDIF
        IF PEMSTATUS(loc_oPg8C, "txt_4c_Digimaxs", 5)
            loc_oPg8C.txt_4c_Digimaxs.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg8C, "txt_4c_Ordcompos", 5)
            loc_oPg8C.txt_4c_Ordcompos.Value = 0
        ENDIF
        IF PEMSTATUS(loc_oPg8C, "txt_4c_Casas", 5)
            loc_oPg8C.txt_4c_Casas.Value   = 0
        ENDIF

        *-- Limpar crMontagem para novo registro
        IF USED("crMontagem")
            ZAP IN crMontagem
            INSERT INTO crMontagem (Grupos) VALUES ("")
            GO BOTTOM IN crMontagem
        ENDIF
        THIS.AtualizaMontagem(.F.)

        *-- Page3: Descricao (pgDescrs) - limpar LocalProD
        IF USED("LocalProD")
            ZAP IN LocalProD
        ENDIF
        LOCAL loc_oPg3L
        loc_oPg3L = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3
        IF PEMSTATUS(loc_oPg3L, "cbo_4c_CmbTipos", 5)
            loc_oPg3L.cbo_4c_CmbTipos.ListIndex = 0
        ENDIF
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao
    * Codigo somente leitura no Alterar/Visualizar
    * Usa PEMSTATUS pois controles sao adicionados nas Fases 5-6
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg1, loc_lCodReadOnly
        loc_oPg1       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_lCodReadOnly = (THIS.this_cModoAtual != "INCLUIR")

        IF PEMSTATUS(loc_oPg1, "txt_4c_Cgrus", 5)
            loc_oPg1.txt_4c_Cgrus.Enabled   = par_lHabilitar AND !loc_lCodReadOnly
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Dgrus", 5)
            loc_oPg1.txt_4c_Dgrus.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Mercs", 5)
            loc_oPg1.txt_4c_Mercs.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_Ids", 5)
            loc_oPg1.txt_4c_Ids.Enabled     = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_DiasEnts", 5)
            loc_oPg1.txt_4c_DiasEnts.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_DiasGar", 5)
            loc_oPg1.txt_4c_DiasGar.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg1, "txt_4c_EtiPad", 5)
            loc_oPg1.txt_4c_EtiPad.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg1, "obj_4c_Fwoption1", 5)
            loc_oPg1.obj_4c_Fwoption1.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg1, "obj_4c_Fwoption2", 5)
            loc_oPg1.obj_4c_Fwoption2.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg1, "chk_4c_Logalt", 5)
            loc_oPg1.chk_4c_Logalt.Enabled = par_lHabilitar
        ENDIF

        *-- Page2: Produtos
        LOCAL loc_oPg2H
        loc_oPg2H = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        LOCAL loc_aCtrls2H(11)
        loc_aCtrls2H(1)  = "txt_4c_Idecpros"
        loc_aCtrls2H(2)  = "txt_4c_Cgrus2"
        loc_aCtrls2H(3)  = "txt_4c_Margems"
        loc_aCtrls2H(4)  = "txt_4c_Markupa"
        loc_aCtrls2H(5)  = "txt_4c_Moemrkaps"
        loc_aCtrls2H(6)  = "txt_4c_Arreds"
        loc_aCtrls2H(7)  = "txt_4c_Arredcs"
        loc_aCtrls2H(8)  = "txt_4c_Localpdr"
        loc_aCtrls2H(9)  = "txt_4c_Padmoecs"
        loc_aCtrls2H(10) = "txt_4c_Padmoedas"
        loc_aCtrls2H(11) = "txt_4c_Padmargens"
        LOCAL loc_nH
        FOR loc_nH = 1 TO ALEN(loc_aCtrls2H)
            IF PEMSTATUS(loc_oPg2H, loc_aCtrls2H(loc_nH), 5)
                *-- Controls() eh indexado por NUMERO: Controls("nome") estoura. STORE ... TO (expr) alcanca por nome (regra #15). Erro171.
                STORE par_lHabilitar TO ("loc_oPg2H." + loc_aCtrls2H(loc_nH) + ".Enabled")
            ENDIF
        ENDFOR

        *-- Page4: Estoque/Fiscal
        LOCAL loc_oPg4H
        loc_oPg4H = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        LOCAL loc_aCtrls4H(10)
        loc_aCtrls4H(1)  = "txt_4c_Clfiscals"
        loc_aCtrls4H(2)  = "txt_4c_Origmercs"
        loc_aCtrls4H(3)  = "txt_4c_Sittricms"
        loc_aCtrls4H(4)  = "txt_4c_Moecusts"
        loc_aCtrls4H(5)  = "txt_4c_Icms"
        loc_aCtrls4H(6)  = "txt_4c_Tptribs"
        loc_aCtrls4H(7)  = "txt_4c_Ipifabs"
        loc_aCtrls4H(8)  = "txt_4c_Ipiimpors"
        loc_aCtrls4H(9)  = "txt_4c_Unificas"
        loc_aCtrls4H(10) = "obj_4c_Obrigfiscs"
        FOR loc_nH = 1 TO ALEN(loc_aCtrls4H)
            IF PEMSTATUS(loc_oPg4H, loc_aCtrls4H(loc_nH), 5)
                *-- Controls() eh indexado por NUMERO: Controls("nome") estoura. STORE ... TO (expr) alcanca por nome (regra #15). Erro171.
                STORE par_lHabilitar TO ("loc_oPg4H." + loc_aCtrls4H(loc_nH) + ".Enabled")
            ENDIF
        ENDFOR
        IF PEMSTATUS(loc_oPg4H, "obj_4c_Cestoqs", 5)
            loc_oPg4H.obj_4c_Cestoqs.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg4H, "obj_4c_Repauts", 5)
            loc_oPg4H.obj_4c_Repauts.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg4H, "obj_4c_Montagens", 5)
            loc_oPg4H.obj_4c_Montagens.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg4H, "obj_4c_Retiras", 5)
            loc_oPg4H.obj_4c_Retiras.Enabled   = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg4H, "obj_4c_Frtsegfs", 5)
            loc_oPg4H.obj_4c_Frtsegfs.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg4H, "obj_4c_Frtseggs", 5)
            loc_oPg4H.obj_4c_Frtseggs.Enabled  = par_lHabilitar
        ENDIF

        *-- Page5: Industria
        LOCAL loc_oPg5H
        loc_oPg5H = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
        LOCAL loc_aCtrls5H(7)
        loc_aCtrls5H(1) = "txt_4c_Grufins"
        loc_aCtrls5H(2) = "txt_4c_Cmoeds"
        loc_aCtrls5H(3) = "txt_4c_Grupobxps"
        loc_aCtrls5H(4) = "txt_4c_Contabxps"
        loc_aCtrls5H(5) = "txt_4c_Descricao"
        loc_aCtrls5H(6) = "txt_4c_Base"
        loc_aCtrls5H(7) = "txt_4c_Premios"
        FOR loc_nH = 1 TO ALEN(loc_aCtrls5H)
            IF PEMSTATUS(loc_oPg5H, loc_aCtrls5H(loc_nH), 5)
                *-- Controls() eh indexado por NUMERO: Controls("nome") estoura. STORE ... TO (expr) alcanca por nome (regra #15). Erro171.
                STORE par_lHabilitar TO ("loc_oPg5H." + loc_aCtrls5H(loc_nH) + ".Enabled")
            ENDIF
        ENDFOR
        IF PEMSTATUS(loc_oPg5H, "obj_4c_OptGravPeso", 5)
            loc_oPg5H.obj_4c_OptGravPeso.Enabled  = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg5H, "obj_4c_Fwoption1", 5)
            loc_oPg5H.obj_4c_Fwoption1.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg5H, "obj_4c_Fwoption2", 5)
            loc_oPg5H.obj_4c_Fwoption2.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg5H, "obj_4c_Fwoption4", 5)
            loc_oPg5H.obj_4c_Fwoption4.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg5H, "obj_4c_Fwoption5", 5)
            loc_oPg5H.obj_4c_Fwoption5.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg5H, "obj_4c_Fwoption6", 5)
            loc_oPg5H.obj_4c_Fwoption6.Enabled    = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg5H, "obj_4c_Opt_semiacab", 5)
            loc_oPg5H.obj_4c_Opt_semiacab.Enabled = par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg5H, "obj_4c_Opt_ServProd", 5)
            loc_oPg5H.obj_4c_Opt_ServProd.Enabled = par_lHabilitar
        ENDIF

        *-- Page6: Configuracao
        LOCAL loc_oPg6H
        loc_oPg6H = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        *-- 12 (era 14): os dois ultimos eram obj_4c_Lores / obj_4c_Ltams, removidos
        *-- no Erro175 - a Grade de Sub-Itens mora na aba ESTOQUE/FISCAL. Encolher o
        *-- array em vez de deixar slot vazio: PEMSTATUS com string vazia nao presta.
        LOCAL loc_aCtrls6H(12)
        loc_aCtrls6H(1)  = "txt_4c_Grucmvs"
        loc_aCtrls6H(2)  = "txt_4c_Concmvs"
        loc_aCtrls6H(3)  = "txt_4c_Gruestps"
        loc_aCtrls6H(4)  = "txt_4c_Conestps"
        loc_aCtrls6H(5)  = "txt_4c_Grctobccs"
        loc_aCtrls6H(6)  = "txt_4c_Comiss"
        loc_aCtrls6H(7)  = "txt_4c_Padlinha"
        loc_aCtrls6H(8)  = "txt_4c_Padcolec"
        loc_aCtrls6H(9)  = "txt_4c_Padcclas"
        loc_aCtrls6H(10) = "txt_4c_Padfinps"
        loc_aCtrls6H(11) = "txt_4c_Padfase"
        loc_aCtrls6H(12) = "txt_4c_Cunips"
        FOR loc_nH = 1 TO ALEN(loc_aCtrls6H)
            IF PEMSTATUS(loc_oPg6H, loc_aCtrls6H(loc_nH), 5)
                *-- Controls() eh indexado por NUMERO: Controls("nome") estoura. STORE ... TO (expr) alcanca por nome (regra #15). Erro171.
                STORE par_lHabilitar TO ("loc_oPg6H." + loc_aCtrls6H(loc_nH) + ".Enabled")
            ENDIF
        ENDFOR
        *-- Grade de Sub-Itens: habilita os CheckBox na aba ESTOQUE/FISCAL (Page4).
        *-- Antes habilitava OptionGroups inventados na Page6. Erro175.
        LOCAL loc_oPg4SubItH
        loc_oPg4SubItH = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        LOCAL ARRAY loc_aSubIt(5)
        loc_aSubIt(1) = "chk_4c_Cors"
        loc_aSubIt(2) = "chk_4c_Tams"
        loc_aSubIt(3) = "chk_4c_Embs"
        loc_aSubIt(4) = "chk_4c_Pesos"
        loc_aSubIt(5) = "chk_4c_Entregas"
        FOR loc_nH = 1 TO ALEN(loc_aSubIt)
            IF PEMSTATUS(loc_oPg4SubItH, loc_aSubIt(loc_nH), 5)
                STORE par_lHabilitar TO ("loc_oPg4SubItH." + loc_aSubIt(loc_nH) + ".Enabled")
            ENDIF
        ENDFOR

        *-- Page8: Codificacao
        LOCAL loc_oPg8H
        loc_oPg8H = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8
        LOCAL loc_aCtrls8H(4)
        loc_aCtrls8H(1) = "txt_4c_Compos"
        loc_aCtrls8H(2) = "txt_4c_Digimaxs"
        loc_aCtrls8H(3) = "txt_4c_Ordcompos"
        loc_aCtrls8H(4) = "txt_4c_Casas"
        FOR loc_nH = 1 TO ALEN(loc_aCtrls8H)
            IF PEMSTATUS(loc_oPg8H, loc_aCtrls8H(loc_nH), 5)
                *-- Controls() eh indexado por NUMERO: Controls("nome") estoura. STORE ... TO (expr) alcanca por nome (regra #15). Erro171.
                STORE par_lHabilitar TO ("loc_oPg8H." + loc_aCtrls8H(loc_nH) + ".Enabled")
            ENDIF
        ENDFOR

        IF PEMSTATUS(loc_oPg8H, "grd_4c_Codificacao", 5)
            loc_oPg8H.grd_4c_Codificacao.ReadOnly = !par_lHabilitar
        ENDIF
        IF PEMSTATUS(loc_oPg8H, "obj_4c_CmdGrade", 5)
            loc_oPg8H.obj_4c_CmdGrade.Visible = par_lHabilitar
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lLista, loc_lDados, loc_lEditar
        loc_lLista  = (THIS.this_cModoAtual = "LISTA")
        loc_lDados  = !loc_lLista
        loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
            WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                    .cmd_4c_Incluir.Enabled   = loc_lLista
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                    .cmd_4c_Visualizar.Enabled = loc_lLista
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                    .cmd_4c_Alterar.Enabled   = loc_lLista
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                    .cmd_4c_Excluir.Enabled   = loc_lLista
                ENDIF
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
                    .cmd_4c_Buscar.Enabled    = loc_lLista
                ENDIF
                .Visible     = .T.
            ENDWITH
        ENDIF

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Salva", 5)
            WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                    .cmd_4c_Confirmar.Enabled = loc_lEditar OR (THIS.this_cModoAtual = "EXCLUIR")
                ENDIF
                .Visible     = .T.
            ENDWITH
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
    *==========================================================================
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
    * GradeAfterRowColChange - Atualiza subgrupos ao navegar no grid de grupos
    * PUBLIC: BINDEVENT requer metodo publico
    * par_nColIndex: coluna atual (passado automaticamente pelo BINDEVENT)
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_cCgrus
        loc_cCgrus = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCgrus = ALLTRIM(cursor_4c_Dados.cgrus)
        ENDIF

        THIS.CarregarSubgrupos(loc_cCgrus)
    ENDPROC

    *==========================================================================
    * CarregarSubgrupos - Carrega cursor_4c_SubGrupos e vincula grd_4c_Subgrupos
    * par_cCgrus: codigo do grupo para filtrar (vazio = cursor vazio)
    *==========================================================================
    PROTECTED PROCEDURE CarregarSubgrupos(par_cCgrus)
        LOCAL loc_oGrid

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Subgrupos", 5)
            THIS.pgf_4c_Paginas.Page1.grd_4c_Subgrupos.RecordSource = ""
        ENDIF

        THIS.this_oBusinessObject.BuscarSubgrupos(par_cCgrus)

        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Subgrupos", 5)
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Subgrupos
            loc_oGrid.ColumnCount = 3
            loc_oGrid.RecordSource          = "cursor_4c_SubGrupos"
            loc_oGrid.Column1.ControlSource = "cursor_4c_SubGrupos.codigos"
            loc_oGrid.Column2.ControlSource = "cursor_4c_SubGrupos.descricaos"
            loc_oGrid.Column3.ControlSource = "cursor_4c_SubGrupos.marckupa"
            loc_oGrid.Column1.Header1.Caption = "Sub-Grupo"
            loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Sub-Grupo"
            loc_oGrid.Column3.Header1.Caption = "Markup"
            THIS.FormatarGridLista(loc_oGrid)
        ENDIF
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica estilo visual ao grid de listagem
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Verdana"
                .FontSize = 8
            ENDWITH
        CATCH TO loc_oErro
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.FormatarGridLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAbaCadastro - Preenche pgf_4c_Divisoes.Page1 (aba "Cadastro")
    * FASE 5: campos principais (labels, textboxes, OptionGroups Servicos/Material)
    * Tops originais do SCX + 29 (compensacao pgf_4c_Divisoes.Top=-29)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaCadastro()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1

        *-- Codigo (cgrus) -------------------------------------------------
        loc_oPg1.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPg1.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 129
            .Left      = 139
            .Width     = 42
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Cgrus", "TextBox")
        WITH loc_oPg1.txt_4c_Cgrus
            .Value          = ""
            .Top            = 125
            .Left           = 183
            .Width          = 33
            .Height         = 23
            .MaxLength      = 3
            .Format         = "!K"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .ForeColor      = RGB(0, 0, 0)
            .BorderColor    = RGB(100, 100, 100)
            .Visible        = .F.
        ENDWITH

        *-- Descricao (dgrus) ----------------------------------------------
        loc_oPg1.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPg1.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 154
            .Left      = 126
            .Width     = 55
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Dgrus", "TextBox")
        WITH loc_oPg1.txt_4c_Dgrus
            .Value          = ""
            .Top            = 150
            .Left           = 183
            .Width          = 150
            .Height         = 23
            .MaxLength      = 20
            .Format         = "K"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .ForeColor      = RGB(0, 0, 0)
            .BorderColor    = RGB(100, 100, 100)
            .Visible        = .F.
        ENDWITH

        *-- Identificador (ids) --------------------------------------------
        loc_oPg1.AddObject("lbl_4c_Identificador", "Label")
        WITH loc_oPg1.lbl_4c_Identificador
            .Caption   = "Identificador :"
            .Top       = 179
            .Left      = 111
            .Width     = 70
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Ids", "TextBox")
        WITH loc_oPg1.txt_4c_Ids
            .Value          = 0
            .Top            = 175
            .Left           = 183
            .Width          = 80
            .Height         = 23
            .InputMask      = "9999999999"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .ForeColor      = RGB(0, 0, 0)
            .BorderColor    = RGB(100, 100, 100)
            .Visible        = .F.
        ENDWITH

        *-- Grande Grupo (mercs) com lookup --------------------------------
        loc_oPg1.AddObject("lbl_4c_GdeGrupo", "Label")
        WITH loc_oPg1.lbl_4c_GdeGrupo
            .Caption   = "Grande Grupo :"
            .Top       = 204
            .Left      = 105
            .Width     = 76
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Mercs", "TextBox")
        WITH loc_oPg1.txt_4c_Mercs
            .Value          = ""
            .Top            = 200
            .Left           = 183
            .Width          = 33
            .Height         = 23
            .MaxLength      = 3
            .Format         = "!K"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .ForeColor      = RGB(0, 0, 0)
            .BorderColor    = RGB(100, 100, 100)
            .Visible        = .F.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_Mercs, "LostFocus", THIS, "MercsValid")
        BINDEVENT(loc_oPg1.txt_4c_Mercs, "KeyPress", THIS, "MercsKeyPress")

        loc_oPg1.AddObject("txt_4c_DgdeMercs", "TextBox")
        WITH loc_oPg1.txt_4c_DgdeMercs
            .Value          = ""
            .Top            = 200
            .Left           = 218
            .Width          = 117
            .Height         = 23
            .ReadOnly       = .T.
            .BackStyle      = 0
            .BorderStyle    = 0
            .FontName       = "Tahoma"
            .FontSize       = 8
            .ForeColor      = RGB(90, 90, 90)
            .Visible        = .F.
        ENDWITH

        *-- Adiciona na Entrega (diasents) ---------------------------------
        loc_oPg1.AddObject("lbl_4c_DiasEnts", "Label")
        WITH loc_oPg1.lbl_4c_DiasEnts
            .Caption   = "Adiciona na Entrega :"
            .Top       = 229
            .Left      = 76
            .Width     = 105
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DiasEnts", "TextBox")
        WITH loc_oPg1.txt_4c_DiasEnts
            .Value          = 0
            .Top            = 225
            .Left           = 183
            .Width          = 33
            .Height         = 23
            .InputMask      = "999"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .ForeColor      = RGB(0, 0, 0)
            .BorderColor    = RGB(100, 100, 100)
            .Visible        = .F.
        ENDWITH

        *-- Garantia de (diasgar) ------------------------------------------
        loc_oPg1.AddObject("lbl_4c_DiasGar", "Label")
        WITH loc_oPg1.lbl_4c_DiasGar
            .Caption   = "Garantia de :"
            .Top       = 254
            .Left      = 116
            .Width     = 65
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_DiasGar", "TextBox")
        WITH loc_oPg1.txt_4c_DiasGar
            .Value          = 0
            .Top            = 250
            .Left           = 183
            .Width          = 33
            .Height         = 23
            .InputMask      = "999"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .ForeColor      = RGB(0, 0, 0)
            .BorderColor    = RGB(100, 100, 100)
            .Visible        = .F.
        ENDWITH

        *-- Etiqueta Padrao (etipads) --------------------------------------
        loc_oPg1.AddObject("lbl_4c_EtiPad", "Label")
        WITH loc_oPg1.lbl_4c_EtiPad
            .Caption   = "Etiqueta Padr" + CHR(227) + "o :"
            .Top       = 279
            .Left      = 95
            .Width     = 86
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_EtiPad", "TextBox")
        WITH loc_oPg1.txt_4c_EtiPad
            .Value          = ""
            .Top            = 275
            .Left           = 183
            .Width          = 17
            .Height         = 23
            .MaxLength      = 1
            .Format         = "!K"
            .ToolTipText    = "Sim / N" + CHR(227) + "o / Selecionada"
            .FontName       = "Tahoma"
            .FontSize       = 8
            .SpecialEffect  = 1
            .ForeColor      = RGB(0, 0, 0)
            .BorderColor    = RGB(100, 100, 100)
            .Visible        = .F.
        ENDWITH
        BINDEVENT(loc_oPg1.txt_4c_EtiPad, "LostFocus", THIS, "EtiPadValid")

        *-- Servicos (fwoption1: Sim/Nao) ----------------------------------
        loc_oPg1.AddObject("lbl_4c_Servicos", "Label")
        WITH loc_oPg1.lbl_4c_Servicos
            .Caption   = "Servi" + CHR(231) + "os :"
            .Top       = 306
            .Left      = 132
            .Width     = 49
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPg1.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH loc_oPg1.obj_4c_Fwoption1
            .Value        = 2
            .Top          = 301
            .Left         = 178
            .Width        = 145
            .Height       = 25
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 103
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .F.
            ENDWITH
        ENDWITH

        *-- Material / Materia Prima (fwoption2: 4 opcoes) -----------------
        loc_oPg1.AddObject("lbl_4c_Material", "Label")
        WITH loc_oPg1.lbl_4c_Material
            .Caption   = "Material :"
            .Top       = 329
            .Left      = 134
            .Width     = 47
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        loc_oPg1.AddObject("obj_4c_Fwoption2", "OptionGroup")
        WITH loc_oPg1.obj_4c_Fwoption2
            .Value        = 1
            .Top          = 324
            .Left         = 178
            .Width        = 179
            .Height       = 42
            .ButtonCount  = 4
            .BackStyle    = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption   = "Prim" + CHR(225) + "rio"
                .Left      = 5
                .Top       = 5
                .Width     = 60
                .Height    = 15
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Secund" + CHR(225) + "rio"
                .Left      = 103
                .Top       = 5
                .Width     = 70
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Acabado"
                .Left      = 5
                .Top       = 22
                .Width     = 60
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .F.
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Matriz"
                .Left      = 103
                .Top       = 22
                .Width     = 47
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Visible   = .F.
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPg1.obj_4c_Fwoption2, "Valid", THIS, "Fwoption2Valid")

        THIS.AdicionarChkLogalt()

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *==========================================================================
    * MercsValid - Valida codigo do Grande Grupo e abre lookup se nao encontrado
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE MercsValid()
        LOCAL loc_lResultado, loc_cMercs, loc_oPg1, loc_nResult, loc_cDesc
        loc_lResultado = .T.
        loc_oPg1       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1

        IF !PEMSTATUS(loc_oPg1, "txt_4c_Mercs", 5)
            RETURN .T.
        ENDIF

        loc_cMercs = ALLTRIM(UPPER(loc_oPg1.txt_4c_Mercs.Value))

        IF EMPTY(loc_cMercs)
            IF PEMSTATUS(loc_oPg1, "txt_4c_DgdeMercs", 5)
                loc_oPg1.txt_4c_DgdeMercs.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descs FROM SigCdGpr WHERE codigos = " + EscaparSQL(loc_cMercs), ;
                "cursor_4c_BuscaMercs")

            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaMercs")
                loc_cDesc = ALLTRIM(cursor_4c_BuscaMercs.descs)
                loc_oPg1.txt_4c_Mercs.Value = ALLTRIM(cursor_4c_BuscaMercs.codigos)
                IF PEMSTATUS(loc_oPg1, "txt_4c_DgdeMercs", 5)
                    loc_oPg1.txt_4c_DgdeMercs.Value = loc_cDesc
                ENDIF
            ELSE
                THIS.AbrirBuscaGdeGrupo()
                loc_lResultado = .F.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Grande Grupo:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.MercsValid")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_BuscaMercs")
            USE IN cursor_4c_BuscaMercs
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * MercsKeyPress - Abre lookup do Grande Grupo com F4
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE MercsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGdeGrupo()
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaGdeGrupo - Abre FormBuscaAuxiliar para SigCdGpr (Grande Grupo)
    * PUBLIC: chamado por MercsValid e MercsKeyPress
    *==========================================================================
    PROCEDURE AbrirBuscaGdeGrupo()
        LOCAL loc_oBusca, loc_oPg1, loc_cCodigo, loc_cDesc
        loc_oPg1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cCodigo = ""
        loc_cDesc   = ""

        TRY
            *-- 1o parametro do Init eh o HANDLE da conexao (par_nConn): passar a tabela
            *-- ali deslocava TODOS os argumentos e o picker consultava a "tabela"
            *-- codigos. Erro172.
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGde", "Codigos", ;
                IIF(PEMSTATUS(loc_oPg1, "txt_4c_Mercs", 5), ALLTRIM(loc_oPg1.txt_4c_Mercs.Value), ""), ;
                "Grande Grupo")

            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGde")
                    SELECT cursor_4c_BuscaGde
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaGde.Codigos)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaGde.Descs)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca de Grande Grupo:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.AbrirBuscaGdeGrupo")
        ENDTRY

        IF USED("cursor_4c_BuscaGde")
            USE IN cursor_4c_BuscaGde
        ENDIF

        IF !EMPTY(loc_cCodigo) AND PEMSTATUS(loc_oPg1, "txt_4c_Mercs", 5)
            loc_oPg1.txt_4c_Mercs.Value = loc_cCodigo
            IF PEMSTATUS(loc_oPg1, "txt_4c_DgdeMercs", 5)
                loc_oPg1.txt_4c_DgdeMercs.Value = loc_cDesc
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * EtiPadValid - Valida Etiqueta Padrao: somente S, N ou D
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE EtiPadValid()
        LOCAL loc_cValor, loc_oPg1
        loc_oPg1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_cValor = ""

        IF PEMSTATUS(loc_oPg1, "txt_4c_EtiPad", 5)
            loc_cValor = UPPER(ALLTRIM(loc_oPg1.txt_4c_EtiPad.Value))
        ENDIF

        IF EMPTY(loc_cValor) OR INLIST(loc_cValor, "S", "N", "D")
            RETURN .T.
        ENDIF

        MsgAviso("Etiqueta Padr" + CHR(227) + "o: informe S, N ou D.")
        IF PEMSTATUS(loc_oPg1, "txt_4c_EtiPad", 5)
            loc_oPg1.txt_4c_EtiPad.SetFocus()
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Fwoption2Valid - Valida mudanca de tipo de material (mtprimas)
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE Fwoption2Valid()
        LOCAL loc_oPg1, loc_nValor
        loc_oPg1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        loc_nValor = 1

        IF PEMSTATUS(loc_oPg1, "obj_4c_Fwoption2", 5)
            loc_nValor = loc_oPg1.obj_4c_Fwoption2.Value
        ENDIF

        *-- Tipo "Acabado" requer que configuracoes de composicao estejam vazias
        IF loc_nValor = 3
            LOCAL loc_nCheck
            loc_nCheck = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cgrus FROM SigCdGrp WHERE cgrus = " + ;
                EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cCgrus)) + ;
                " AND (LTRIM(RTRIM(ISNULL(compos,''))) <> '' OR ISNULL(digimaxs,0) <> 0 OR " + ;
                " ISNULL(ordcompos,0) <> 0 OR ISNULL(casas,0) <> 0)", ;
                "cursor_4c_ChkComp")
            IF loc_nCheck > 0 AND !EOF("cursor_4c_ChkComp")
                MsgAviso("Existem Configura" + CHR(231) + CHR(245) + "es de Cadastro de Produtos Neste Grupo." + ;
                    CHR(13) + "Limpe essas configura" + CHR(231) + CHR(245) + "es antes de prosseguir.")
                IF USED("cursor_4c_ChkComp")
                    USE IN cursor_4c_ChkComp
                ENDIF
                RETURN .F.
            ENDIF
            IF USED("cursor_4c_ChkComp")
                USE IN cursor_4c_ChkComp
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDescGdeGrupo - Preenche txt_4c_DgdeMercs com descricao do mercs
    * Chamado pelo BOParaForm apos carregar um registro
    *==========================================================================
    PROTECTED PROCEDURE CarregarDescGdeGrupo(par_cMercs)
        LOCAL loc_oPg1, loc_nResult
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1

        IF !PEMSTATUS(loc_oPg1, "txt_4c_DgdeMercs", 5)
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(par_cMercs))
            loc_oPg1.txt_4c_DgdeMercs.Value = ""
            RETURN
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT descs FROM SigCdGpr WHERE codigos = " + EscaparSQL(ALLTRIM(par_cMercs)), ;
                "cursor_4c_DescMercs")
            IF loc_nResult > 0 AND !EOF("cursor_4c_DescMercs")
                loc_oPg1.txt_4c_DgdeMercs.Value = ALLTRIM(cursor_4c_DescMercs.descs)
            ELSE
                loc_oPg1.txt_4c_DgdeMercs.Value = ""
            ENDIF
        CATCH TO loc_oErro
            loc_oPg1.txt_4c_DgdeMercs.Value = ""
        ENDTRY

        IF USED("cursor_4c_DescMercs")
            USE IN cursor_4c_DescMercs
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            LOCAL loc_aCursors(26), loc_nC
            loc_aCursors(1)  = "cursor_4c_Dados"
            loc_aCursors(2)  = "cursor_4c_SubGrupos"
            loc_aCursors(3)  = "cursor_4c_BuscaGpd"
            loc_aCursors(4)  = "cursor_4c_BuscaMercs"
            loc_aCursors(5)  = "cursor_4c_BuscaGdegrp"
            loc_aCursors(6)  = "cursor_4c_BuscaClfiscal"
            loc_aCursors(7)  = "cursor_4c_BuscaOrigmerc"
            loc_aCursors(8)  = "cursor_4c_BuscaSittricm"
            loc_aCursors(9)  = "cursor_4c_BuscaMoeda"
            loc_aCursors(10) = "cursor_4c_BuscaTptrib"
            loc_aCursors(11) = "cursor_4c_BuscaGruContab"
            loc_aCursors(12) = "cursor_4c_BuscaCtaContab"
            loc_aCursors(13) = "cursor_4c_BuscaLinha"
            loc_aCursors(14) = "cursor_4c_BuscaColec"
            loc_aCursors(15) = "cursor_4c_BuscaFinp"
            loc_aCursors(16) = "cursor_4c_BuscaFase"
            loc_aCursors(17) = "cursor_4c_BuscaUnidade"
            loc_aCursors(18) = "cursor_4c_BuscaCgrus2"
            loc_aCursors(19) = "cursor_4c_BuscaAuxiliar"
            loc_aCursors(20) = "cursor_4c_SigCdPsg"
            loc_aCursors(21) = "cursor_4c_Prazos"
            loc_aCursors(22) = "crMontagem"
            loc_aCursors(23) = "crGrpMonta"
            loc_aCursors(24) = "crSigcdcpo"
            loc_aCursors(25) = "LocalProD"
            loc_aCursors(26) = "cursor_4c_BuscaGpr"
            FOR loc_nC = 1 TO 26
                IF USED(loc_aCursors(loc_nC))
                    USE IN (loc_aCursors(loc_nC))
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            *-- Erros no Destroy nao devem impedir o fechamento
        ENDTRY

        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarAbaProdutos - Preenche Page2 (aba Produtos)
    * Campos: idecpros, cgrus2, margems, markupa, moemrkaps, arreds,
    *         arredcs, localpdr, padmoecs, padmoepcs, padmoedas, padmoevs, padmoetcs, padmargens
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaProdutos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2

        *-- Identificador Codigo Produto (idecpros) Top=100+29=129
        loc_oPg.AddObject("lbl_4c_Idecpros", "Label")
        WITH loc_oPg.lbl_4c_Idecpros
            .Caption   = "Identificador Cód Produto :"
            .Top       = 129
            .Left      = 36
            .Width     = 131
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Idecpros", "TextBox")
        WITH loc_oPg.txt_4c_Idecpros
            .Value         = ""
            .Top           = 125
            .Left          = 169
            .Width         = 30
            .Height        = 23
            .MaxLength     = 2
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Idecpros, "KeyPress", THIS, "IdecprosKeyPress")

        *-- Grande Grupo 2 (cgrus2) Top=567+29=596
        loc_oPg.AddObject("lbl_4c_Cgrus2", "Label")
        WITH loc_oPg.lbl_4c_Cgrus2
            .Caption   = "Grande Grupo 2 :"
            .Top       = 596
            .Left      = 75
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cgrus2", "TextBox")
        WITH loc_oPg.txt_4c_Cgrus2
            .Value         = ""
            .Top           = 592
            .Left          = 165
            .Width         = 32
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cgrus2, "LostFocus", THIS, "Cgrus2Valid")
        BINDEVENT(loc_oPg.txt_4c_Cgrus2, "KeyPress", THIS, "Cgrus2KeyPress")

        loc_oPg.AddObject("txt_4c_DescCgrus2", "TextBox")
        WITH loc_oPg.txt_4c_DescCgrus2
            .Value       = ""
            .Top         = 592
            .Left        = 199
            .Width       = 120
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Margem (margems) Top=250+29=279
        loc_oPg.AddObject("lbl_4c_Margems", "Label")
        WITH loc_oPg.lbl_4c_Margems
            .Caption   = "Margem % :"
            .Top       = 279
            .Left      = 350
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Margems", "TextBox")
        WITH loc_oPg.txt_4c_Margems
            .Value         = 0
            .Top           = 275
            .Left          = 422
            .Width         = 80
            .Height        = 23
            .InputMask     = "999,999.999999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Markup Aplicado (markupa) Top=300+29=329
        loc_oPg.AddObject("lbl_4c_Markupa", "Label")
        WITH loc_oPg.lbl_4c_Markupa
            .Caption   = "Markup Aplicado :"
            .Top       = 329
            .Left      = 330
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Markupa", "TextBox")
        WITH loc_oPg.txt_4c_Markupa
            .Value         = 0
            .Top           = 325
            .Left          = 422
            .Width         = 80
            .Height        = 23
            .InputMask     = "999,999,999.999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Moeda Markup (moemrkaps) Top=300+29=329
        loc_oPg.AddObject("lbl_4c_Moemrkaps", "Label")
        WITH loc_oPg.lbl_4c_Moemrkaps
            .Caption   = "Moeda Markup :"
            .Top       = 329
            .Left      = 430
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Moemrkaps", "TextBox")
        WITH loc_oPg.txt_4c_Moemrkaps
            .Value         = ""
            .Top           = 325
            .Left          = 505
            .Width         = 32
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moemrkaps, "LostFocus", THIS, "MoemrkapsValid")
        BINDEVENT(loc_oPg.txt_4c_Moemrkaps, "KeyPress", THIS, "MoemrkapsKeyPress")

        loc_oPg.AddObject("txt_4c_DescMoemrkaps", "TextBox")
        WITH loc_oPg.txt_4c_DescMoemrkaps
            .Value       = ""
            .Top         = 325
            .Left        = 540
            .Width       = 100
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Arredonda Venda (arreds) Top=225+29=254
        loc_oPg.AddObject("lbl_4c_Arreds", "Label")
        WITH loc_oPg.lbl_4c_Arreds
            .Caption   = "Arred. Venda :"
            .Top       = 254
            .Left      = 90
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Arreds", "TextBox")
        WITH loc_oPg.txt_4c_Arreds
            .Value         = 0
            .Top           = 250
            .Left          = 169
            .Width         = 72
            .Height        = 23
            .InputMask     = "999,999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Arredonda Compra (arredcs) Top=250+29=279
        loc_oPg.AddObject("lbl_4c_Arredcs", "Label")
        WITH loc_oPg.lbl_4c_Arredcs
            .Caption   = "Arred. Compra :"
            .Top       = 279
            .Left      = 82
            .Width     = 85
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Arredcs", "TextBox")
        WITH loc_oPg.txt_4c_Arredcs
            .Value         = 0
            .Top           = 275
            .Left          = 169
            .Width         = 72
            .Height        = 23
            .InputMask     = "999,999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Localizacao Padrao (localpdr) Top=345+29=374
        loc_oPg.AddObject("lbl_4c_Localpdr", "Label")
        WITH loc_oPg.lbl_4c_Localpdr
            .Caption   = "Localiza" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :"
            .Top       = 374
            .Left      = 70
            .Width     = 97
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Localpdr", "TextBox")
        WITH loc_oPg.txt_4c_Localpdr
            .Value         = ""
            .Top           = 370
            .Left          = 169
            .Width         = 96
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Padrão Moeda Compra (padmoecs) Top=399+29=428
        loc_oPg.AddObject("lbl_4c_PadMoecs", "Label")
        WITH loc_oPg.lbl_4c_PadMoecs
            .Caption   = "Padr" + CHR(227) + "o Moeda Compra :"
            .Top       = 428
            .Left      = 698
            .Width     = 119
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Padmoecs", "TextBox")
        WITH loc_oPg.txt_4c_Padmoecs
            .Value         = ""
            .Top           = 424
            .Left          = 819
            .Width         = 32
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Padmoecs, "LostFocus", THIS, "PadmoecsPg2Valid")
        BINDEVENT(loc_oPg.txt_4c_Padmoecs, "KeyPress", THIS, "PadmoecsPg2KeyPress")

        *-- Padrão Moeda Preço Compra (padmoepcs) Top=423+29=452
        loc_oPg.AddObject("lbl_4c_PadMoepcs", "Label")
        WITH loc_oPg.lbl_4c_PadMoepcs
            .Caption   = "Padr" + CHR(227) + "o Moeda Pr" + CHR(231) + "o Compra :"
            .Top       = 452
            .Left      = 691
            .Width     = 126
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Padmoepcs", "TextBox")
        WITH loc_oPg.txt_4c_Padmoepcs
            .Value         = ""
            .Top           = 448
            .Left          = 819
            .Width         = 32
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Padmoepcs, "LostFocus", THIS, "PadmoepcsValid")
        BINDEVENT(loc_oPg.txt_4c_Padmoepcs, "KeyPress", THIS, "PadmoepcsKeyPress")

        *-- Padrão Moeda Venda (padmoedas) Top=447+29=476
        loc_oPg.AddObject("lbl_4c_PadMoedas", "Label")
        WITH loc_oPg.lbl_4c_PadMoedas
            .Caption   = "Padr" + CHR(227) + "o Moeda Venda :"
            .Top       = 476
            .Left      = 702
            .Width     = 115
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Padmoedas", "TextBox")
        WITH loc_oPg.txt_4c_Padmoedas
            .Value         = ""
            .Top           = 472
            .Left          = 819
            .Width         = 32
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Padmoedas, "LostFocus", THIS, "PadmoedasValid")
        BINDEVENT(loc_oPg.txt_4c_Padmoedas, "KeyPress", THIS, "PadmoedasKeyPress")

        *-- Padrão Moeda Val Venda (padmoevs) Top=471+29=500
        loc_oPg.AddObject("lbl_4c_PadMoevs", "Label")
        WITH loc_oPg.lbl_4c_PadMoevs
            .Caption   = "Padr" + CHR(227) + "o Moeda Val Venda :"
            .Top       = 500
            .Left      = 684
            .Width     = 133
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Padmoevs", "TextBox")
        WITH loc_oPg.txt_4c_Padmoevs
            .Value         = ""
            .Top           = 496
            .Left          = 819
            .Width         = 32
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Padmoevs, "LostFocus", THIS, "PadmoevsValid")
        BINDEVENT(loc_oPg.txt_4c_Padmoevs, "KeyPress", THIS, "PadmoevsKeyPress")

        *-- Padrão Margens (padmargens) Top=495+29=524
        loc_oPg.AddObject("lbl_4c_Padmargens", "Label")
        WITH loc_oPg.lbl_4c_Padmargens
            .Caption   = "Padr" + CHR(227) + "o Margens :"
            .Top       = 524
            .Left      = 719
            .Width     = 98
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Padmargens", "TextBox")
        WITH loc_oPg.txt_4c_Padmargens
            .Value         = 0
            .Top           = 520
            .Left          = 819
            .Width         = 98
            .Height        = 23
            .InputMask     = "999,999.999999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Padrão Moeda Terceiros (padmoetcs) Top=519+29=548
        loc_oPg.AddObject("lbl_4c_PadMoetcs", "Label")
        WITH loc_oPg.lbl_4c_PadMoetcs
            .Caption   = "Padr" + CHR(227) + "o Moeda Terceiros :"
            .Top       = 548
            .Left      = 686
            .Width     = 131
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Padmoetcs", "TextBox")
        WITH loc_oPg.txt_4c_Padmoetcs
            .Value         = ""
            .Top           = 544
            .Left          = 819
            .Width         = 32
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Padmoetcs, "LostFocus", THIS, "PadmoetcsValid")
        BINDEVENT(loc_oPg.txt_4c_Padmoetcs, "KeyPress", THIS, "PadmoetcsKeyPress")

        *-- Opcao Localizacao Obrigatoria
        loc_oPg.AddObject("lbl_4c_Lservicos", "Label")
        WITH loc_oPg.lbl_4c_Lservicos
            .Caption   = "Local Obrig. :"
            .Top       = 399
            .Left      = 90
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Lservicos", "OptionGroup")
        WITH loc_oPg.obj_4c_Lservicos
            .Value        = 2
            .Top          = 394
            .Left         = 169
            .Width        = 120
            .Height       = 25
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Left    = 5
                .Top     = 5
                .Width   = 34
                .Height  = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Left    = 60
                .Top     = 5
                .Width   = 34
                .Height  = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * ConfigurarAbaDescricao - Preenche Page3 (aba Descrição)
    * Grid de descrições multi-idioma (grdDescrs)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaDescricao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3

        *-- Label cabecalho
        loc_oPg.AddObject("lbl_4c_TituloDescrs", "Label")
        WITH loc_oPg.lbl_4c_TituloDescrs
            .Caption   = "Descri" + CHR(231) + CHR(245) + "es do Grupo de Produto"
            .Top       = 100
            .Left      = 104
            .Width     = 250
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Grade de Descricoes (grdDescrs)
        *-- Legado: Top=144+29=173, Left=104, Width=725, Height=445
        loc_oPg.AddObject("grd_4c_Descrs", "Grid")
        WITH loc_oPg.grd_4c_Descrs
            .Top         = 173
            .Left        = 104
            .Width       = 725
            .Height      = 445
            .ColumnCount = 4
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .FontName    = "Courier New"
            .FontSize    = 8
            .Visible     = .F.
            .Column1.Width     = 80
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column2.Width     = 250
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column3.Width     = 200
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column4.Width     = 170
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
        ENDWITH

        *-- Botoes inserir/excluir descricao
        loc_oPg.AddObject("cmg_4c_BotoesDescrs", "CommandGroup")
        WITH loc_oPg.cmg_4c_BotoesDescrs
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 343
            .Left        = 830
            .Width       = 43
            .Height      = 89
            .Themes      = .F.
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption    = ""
                .Picture    = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .Top        = -1
                .Left       = -1
                .Height     = 45
                .Width      = 45
                .Themes     = .F.
                .ToolTipText = "Inserir"
                .BackColor  = RGB(255,255,255)
            ENDWITH
            WITH .Buttons(2)
                .Caption    = ""
                .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Top        = 44
                .Left       = -1
                .Height     = 45
                .Width      = 45
                .Themes     = .F.
                .ToolTipText = "Excluir"
                .BackColor  = RGB(255,255,255)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPg.cmg_4c_BotoesDescrs, "Click", THIS, "BtnDescrsClick")

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * ConfigurarAbaEstoqueFiscal - Preenche Page4 (aba Estoque/Fiscal)
    * Campos: clfiscals, origmercs, sittricms, moecusts, icms, tptribs,
    *         ipifabs, ipiimpors, unificas, e flags booleanos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaEstoqueFiscal()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4

        *-- Classificacao Fiscal (clfiscals) Top=361+29=390
        loc_oPg.AddObject("lbl_4c_Clfiscals", "Label")
        WITH loc_oPg.lbl_4c_Clfiscals
            .Caption   = "Classif. Fiscal :"
            .Top       = 390
            .Left      = 90
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Clfiscals", "TextBox")
        WITH loc_oPg.txt_4c_Clfiscals
            .Value         = ""
            .Top           = 386
            .Left          = 182
            .Width         = 94
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Clfiscals, "LostFocus", THIS, "ClfiscalsValid")
        BINDEVENT(loc_oPg.txt_4c_Clfiscals, "KeyPress", THIS, "ClfiscalsKeyPress")

        loc_oPg.AddObject("txt_4c_DescClfiscal", "TextBox")
        WITH loc_oPg.txt_4c_DescClfiscal
            .Value       = ""
            .Top         = 386
            .Left        = 277
            .Width       = 198
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Origem Mercadoria (origmercs) Top=385+29=414
        loc_oPg.AddObject("lbl_4c_Origmercs", "Label")
        WITH loc_oPg.lbl_4c_Origmercs
            .Caption   = "Origem Merc. :"
            .Top       = 414
            .Left      = 90
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Origmercs", "TextBox")
        WITH loc_oPg.txt_4c_Origmercs
            .Value         = ""
            .Top           = 410
            .Left          = 182
            .Width         = 17
            .Height        = 23
            .MaxLength     = 1
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Origmercs, "LostFocus", THIS, "OrigmercsValid")
        BINDEVENT(loc_oPg.txt_4c_Origmercs, "KeyPress", THIS, "OrigmercsKeyPress")

        loc_oPg.AddObject("txt_4c_DescOrigmerc", "TextBox")
        WITH loc_oPg.txt_4c_DescOrigmerc
            .Value       = ""
            .Top         = 410
            .Left        = 200
            .Width       = 275
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Situação Tributaria ICMS (sittricms) Top=409+29=438
        loc_oPg.AddObject("lbl_4c_Sittricms", "Label")
        WITH loc_oPg.lbl_4c_Sittricms
            .Caption   = "Sit. Trib. ICMS :"
            .Top       = 438
            .Left      = 85
            .Width     = 95
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Sittricms", "TextBox")
        WITH loc_oPg.txt_4c_Sittricms
            .Value         = ""
            .Top           = 434
            .Left          = 182
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Sittricms, "LostFocus", THIS, "SittricmsValid")
        BINDEVENT(loc_oPg.txt_4c_Sittricms, "KeyPress", THIS, "SittricmsKeyPress")

        loc_oPg.AddObject("txt_4c_DescSittricm", "TextBox")
        WITH loc_oPg.txt_4c_DescSittricm
            .Value       = ""
            .Top         = 434
            .Left        = 214
            .Width       = 261
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- ICMS % (icms numeric 5,2) Top=361+29=390 (lado direito)
        loc_oPg.AddObject("lbl_4c_Icms", "Label")
        WITH loc_oPg.lbl_4c_Icms
            .Caption   = "ICMS % :"
            .Top       = 390
            .Left      = 550
            .Width     = 78
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Icms", "TextBox")
        WITH loc_oPg.txt_4c_Icms
            .Value         = 0
            .Top           = 386
            .Left          = 630
            .Width         = 45
            .Height        = 23
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Tipo Tributacao ICMS (tptribs) Top=385+29=414
        *-- O migrador tinha lido o Top do Get_CodServs (409) em vez do Get_TpTrib
        *-- (385), e as duas linhas ficavam uma sobre a outra ("SerTipo Paba ICMS").
        *-- Caption/Left/Width transcritos do Say13 do legado. Erro175.
        loc_oPg.AddObject("lbl_4c_Tptribs", "Label")
        WITH loc_oPg.lbl_4c_Tptribs
            .Caption   = "Tipo Tributa" + CHR(231) + CHR(227) + "o ICMS :"
            .Top       = 418
            .Left      = 517
            .Width     = 111
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Tptribs", "TextBox")
        WITH loc_oPg.txt_4c_Tptribs
            .Value         = ""
            *-- legado Get_TpTrib: Top=385 (+29). Erro175.
            .Top           = 414
            .Left          = 630
            .Width         = 33
            .Height        = 23
            .MaxLength     = 4
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Tptribs, "LostFocus", THIS, "TptribsValid")
        BINDEVENT(loc_oPg.txt_4c_Tptribs, "KeyPress", THIS, "TptribsKeyPress")

        loc_oPg.AddObject("txt_4c_DescTptrib", "TextBox")
        WITH loc_oPg.txt_4c_DescTptrib
            .Value       = ""
            .Top         = 434
            .Left        = 666
            .Width       = 120
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- IPI Fabricacao Propria (ipifabs) Top=361+29=390
        loc_oPg.AddObject("lbl_4c_Ipifabs", "Label")
        WITH loc_oPg.lbl_4c_Ipifabs
            .Caption   = "IPI Fab. Propria % :"
            .Top       = 390
            .Left      = 790
            .Width     = 79
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Ipifabs", "TextBox")
        WITH loc_oPg.txt_4c_Ipifabs
            .Value         = 0
            .Top           = 386
            .Left          = 871
            .Width         = 50
            .Height        = 23
            .InputMask     = "999,999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- IPI Importado (ipiimpors) Top=385+29=414
        loc_oPg.AddObject("lbl_4c_Ipiimpors", "Label")
        WITH loc_oPg.lbl_4c_Ipiimpors
            .Caption   = "IPI Importado % :"
            .Top       = 414
            .Left      = 795
            .Width     = 74
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Ipiimpors", "TextBox")
        WITH loc_oPg.txt_4c_Ipiimpors
            .Value         = 0
            .Top           = 410
            .Left          = 871
            .Width         = 50
            .Height        = 23
            .InputMask     = "999,999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Moeda Custo (moecusts) Top=163+29=192
        loc_oPg.AddObject("lbl_4c_Moecusts", "Label")
        WITH loc_oPg.lbl_4c_Moecusts
            .Caption   = "Moeda Custo :"
            .Top       = 192
            .Left      = 60
            .Width     = 97
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Moecusts", "TextBox")
        WITH loc_oPg.txt_4c_Moecusts
            .Value         = ""
            .Top           = 188
            .Left          = 159
            .Width         = 32
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moecusts, "LostFocus", THIS, "MoecustsValid")
        BINDEVENT(loc_oPg.txt_4c_Moecusts, "KeyPress", THIS, "MoecustsKeyPress")

        loc_oPg.AddObject("txt_4c_DescMoecust", "TextBox")
        WITH loc_oPg.txt_4c_DescMoecust
            .Value       = ""
            .Top         = 188
            .Left        = 194
            .Width       = 154
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Codigo de Unificacao (unificas) Top=188+29=217
        loc_oPg.AddObject("lbl_4c_Unificas", "Label")
        WITH loc_oPg.lbl_4c_Unificas
            .Caption   = "C" + CHR(243) + "d. Unifica" + CHR(231) + CHR(227) + "o :"
            .Top       = 217
            .Left      = 50
            .Width     = 107
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Unificas", "TextBox")
        WITH loc_oPg.txt_4c_Unificas
            .Value         = ""
            .Top           = 213
            .Left          = 159
            .Width         = 32
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Controla Estoque (cestoqs) Top=110+29=139
        loc_oPg.AddObject("lbl_4c_Cestoqs", "Label")
        WITH loc_oPg.lbl_4c_Cestoqs
            .Caption   = "Controla Estoque :"
            .Top       = 139
            .Left      = 45
            .Width     = 112
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Cestoqs", "OptionGroup")
        WITH loc_oPg.obj_4c_Cestoqs
            .Value        = 2
            .Top          = 134
            .Left         = 159
            .Width        = 120
            .Height       = 25
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Left = 5
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Left = 60
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        *-- Reposicao Automatica (repauts) Top=236+29=265
        loc_oPg.AddObject("lbl_4c_Repauts", "Label")
        WITH loc_oPg.lbl_4c_Repauts
            .Caption   = "Reposi" + CHR(231) + CHR(227) + "o Autom. :"
            .Top       = 265
            .Left      = 55
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Repauts", "OptionGroup")
        WITH loc_oPg.obj_4c_Repauts
            .Value        = 2
            .Top          = 260
            .Left         = 159
            .Width        = 120
            .Height       = 25
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Left = 5
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Left = 60
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        *-- Montagens (montagens) Top=258+29=287
        loc_oPg.AddObject("lbl_4c_Montagens", "Label")
        WITH loc_oPg.lbl_4c_Montagens
            .Caption   = "Fabrica" + CHR(231) + CHR(227) + "o Pr" + CHR(243) + "pria :"
            .Top       = 287
            .Left      = 60
            .Width     = 97
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Montagens", "OptionGroup")
        WITH loc_oPg.obj_4c_Montagens
            .Value        = 2
            .Top          = 282
            .Left         = 159
            .Width        = 120
            .Height       = 25
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Left = 5
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Left = 60
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        *-- Retiravel (retiras) Top=278+29=307
        loc_oPg.AddObject("lbl_4c_Retiras", "Label")
        WITH loc_oPg.lbl_4c_Retiras
            .Caption   = "Retir" + CHR(225) + "vel :"
            .Top       = 307
            .Left      = 105
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Retiras", "OptionGroup")
        WITH loc_oPg.obj_4c_Retiras
            .Value        = 2
            .Top          = 302
            .Left         = 159
            .Width        = 120
            .Height       = 25
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Left = 5
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Left = 60
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        *-- Frete Seguro Fiscal (frtsegfs)
        loc_oPg.AddObject("lbl_4c_Frtsegfs", "Label")
        WITH loc_oPg.lbl_4c_Frtsegfs
            .Caption   = "Frt/Seg Fiscal :"
            .Top       = 487
            .Left      = 880
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Frtsegfs", "OptionGroup")
        WITH loc_oPg.obj_4c_Frtsegfs
            .Value        = 2
            .Top          = 502
            .Left         = 880
            .Width        = 120
            .Height       = 25
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Left = 5
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Left = 60
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        *-- Frete Seguro Gerencial (frtseggs)
        loc_oPg.AddObject("lbl_4c_Frtseggs", "Label")
        WITH loc_oPg.lbl_4c_Frtseggs
            .Caption   = "Frt/Seg Gerencial :"
            .Top       = 537
            .Left      = 880
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Frtseggs", "OptionGroup")
        WITH loc_oPg.obj_4c_Frtseggs
            .Value        = 2
            .Top          = 552
            .Left         = 880
            .Width        = 120
            .Height       = 25
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Left = 5
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Left = 60
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        *-- Obrigatorio Fiscal (obrigfiscs) = legado Optiongroup2: Top=339+29=368,
        *-- Left=176, Width=91. Estava em Top=314/Left=440, do outro lado da tela,
        *-- caindo em cima do bloco "Grade de Sub-Itens". O label desta linha eh o
        *-- Label2 do legado ("Class. Fiscal Obrigatoria :"), que o
        *-- ConfigurarPgpgEstoque ja cria como lbl_4c_ClassFiscalOb - o
        *-- lbl_4c_Obrigfiscs que existia aqui era DUPLICATA, com caption inventado
        *-- ("Obrig. Fiscal :"), e foi removido. Erro175.
        loc_oPg.AddObject("obj_4c_Obrigfiscs", "OptionGroup")
        WITH loc_oPg.obj_4c_Obrigfiscs
            .Value        = 2
            .Top          = 368
            .Left         = 176
            .Width        = 91
            .Height       = 25
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Left = 5
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Left = 60
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * ConfigurarAbaIndustria - Preenche Page5 (aba Indústria)
    * Campos: grufins, cmoeds, grupobxps, contabxps
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaIndustria()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5

        *-- Grupo Financeiro (grufins) Top=411+29=440
        loc_oPg.AddObject("lbl_4c_Grufins", "Label")
        WITH loc_oPg.lbl_4c_Grufins
            .Caption   = "Grupo Financeiro :"
            .Top       = 440
            .Left      = 60
            .Width     = 105
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Grufins", "TextBox")
        WITH loc_oPg.txt_4c_Grufins
            .Value         = ""
            .Top           = 436
            .Left          = 167
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Grufins, "LostFocus", THIS, "GrufinsValid")
        BINDEVENT(loc_oPg.txt_4c_Grufins, "KeyPress", THIS, "GrufinsKeyPress")

        loc_oPg.AddObject("txt_4c_DescGrufins", "TextBox")
        WITH loc_oPg.txt_4c_DescGrufins
            .Value       = ""
            .Top         = 436
            .Left        = 249
            .Width       = 200
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Moeda (cmoeds) Top=363+29=392
        loc_oPg.AddObject("lbl_4c_Cmoeds", "Label")
        WITH loc_oPg.lbl_4c_Cmoeds
            .Caption   = "Moeda :"
            .Top       = 392
            .Left      = 105
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cmoeds", "TextBox")
        WITH loc_oPg.txt_4c_Cmoeds
            .Value         = ""
            .Top           = 388
            .Left          = 167
            .Width         = 32
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cmoeds, "LostFocus", THIS, "CmoedsValid")
        BINDEVENT(loc_oPg.txt_4c_Cmoeds, "KeyPress", THIS, "CmoedsKeyPress")

        loc_oPg.AddObject("txt_4c_DescCmoeds", "TextBox")
        WITH loc_oPg.txt_4c_DescCmoeds
            .Value       = ""
            .Top         = 388
            .Left        = 201
            .Width       = 150
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Grupo Exp/Bonus (grupobxps) Top=411+29=440 (lado direito)
        loc_oPg.AddObject("lbl_4c_Grupobxps", "Label")
        WITH loc_oPg.lbl_4c_Grupobxps
            .Caption   = "Grupo Exp/B" + CHR(244) + "nus :"
            .Top       = 469
            .Left      = 60
            .Width     = 105
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Grupobxps", "TextBox")
        WITH loc_oPg.txt_4c_Grupobxps
            .Value         = ""
            .Top           = 465
            .Left          = 167
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Grupobxps, "LostFocus", THIS, "GrupobxpsValid")
        BINDEVENT(loc_oPg.txt_4c_Grupobxps, "KeyPress", THIS, "GrupobxpsKeyPress")

        *-- Conta Exp/Bonus (contabxps)
        loc_oPg.AddObject("lbl_4c_Contabxps", "Label")
        WITH loc_oPg.lbl_4c_Contabxps
            .Caption   = "Conta Exp/B" + CHR(244) + "nus :"
            .Top       = 494
            .Left      = 60
            .Width     = 105
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Contabxps", "TextBox")
        WITH loc_oPg.txt_4c_Contabxps
            .Value         = ""
            .Top           = 490
            .Left          = 167
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Contabxps, "LostFocus", THIS, "ContabxpsValid")
        BINDEVENT(loc_oPg.txt_4c_Contabxps, "KeyPress", THIS, "ContabxpsKeyPress")

        THIS.ConfigurarPgPage1()
        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * ConfigurarPgPage1 - Controles restantes da aba Industria (Page5)
    * Labels, TextBoxes e OptionGroups adicionais (23 controles)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage1()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5

        *-- Mov.Producao p/Unidade (Say16) Top=135+29=164
        loc_oPg.AddObject("lbl_4c_Say16", "Label")
        WITH loc_oPg.lbl_4c_Say16
            .Caption   = "Mov.Produ" + CHR(231) + CHR(227) + "o p/Unidade :"
            .Top       = 164
            .Left      = 123
            .Width     = 130
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- fwoption1 (tpmovs) Sim/Nao Top=135+29=164
        loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption1
            .Value       = 2
            .Top         = 164
            .Left        = 249
            .Width       = 86
            .Height      = 16
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 1
                .Width     = 34
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 44
                .Top       = 1
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Material (Say15) Top=154+29=183
        loc_oPg.AddObject("lbl_4c_Say15", "Label")
        WITH loc_oPg.lbl_4c_Say15
            .Caption   = "Material :"
            .Top       = 183
            .Left      = 206
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- opt_semiacab (semiacabs) 5 botoes Top=149+29=178
        loc_oPg.AddObject("obj_4c_Opt_semiacab", "OptionGroup")
        WITH loc_oPg.obj_4c_Opt_semiacab
            .Value       = 2
            .Top         = 178
            .Left        = 249
            .Width       = 370
            .Height      = 27
            .ButtonCount = 5
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Semi Acabado"
                .Left      = 5
                .Top       = 6
                .Width     = 85
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Nenhum"
                .Left      = 106
                .Top       = 6
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Acabado"
                .Left      = 175
                .Top       = 6
                .Width     = 68
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Pedra"
                .Left      = 246
                .Top       = 5
                .Width     = 61
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "Feitio"
                .Left      = 304
                .Top       = 5
                .Width     = 61
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Imprime na Tira de OP (Say17) Top=174+29=203
        loc_oPg.AddObject("lbl_4c_Say17", "Label")
        WITH loc_oPg.lbl_4c_Say17
            .Caption   = "Imprime na Tira de OP :"
            .Top       = 203
            .Left      = 138
            .Width     = 115
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- fwoption2 (impops) Sim/Nao/Outros Top=173+29=202
        loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption2
            .Value       = 2
            .Top         = 202
            .Left        = 249
            .Width       = 139
            .Height      = 17
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 1
                .Width     = 34
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 44
                .Top       = 1
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Outros"
                .Left      = 83
                .Top       = 1
                .Width     = 61
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Nao Agrega por Material Principal (Say22) Top=192+29=221
        loc_oPg.AddObject("lbl_4c_Say22", "Label")
        WITH loc_oPg.lbl_4c_Say22
            .Caption   = "N" + CHR(227) + "o Agrega por Material Principal :"
            .Top       = 221
            .Left      = 85
            .Width     = 168
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- fwoption5 (nagmts) Sim/Nao Top=191+29=220
        loc_oPg.AddObject("obj_4c_Fwoption5", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption5
            .Value       = 2
            .Top         = 220
            .Left        = 249
            .Width       = 86
            .Height      = 18
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 1
                .Width     = 34
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 44
                .Top       = 1
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Imprime como Componente (Say18) Top=212+29=241
        loc_oPg.AddObject("lbl_4c_Say18", "Label")
        WITH loc_oPg.lbl_4c_Say18
            .Caption   = "Imprime como Componente :"
            .Top       = 241
            .Left      = 114
            .Width     = 139
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- fwoption4 (impcps) Sim/Nao/Nenhum Top=210+29=239
        loc_oPg.AddObject("obj_4c_Fwoption4", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption4
            .Value       = 3
            .Top         = 239
            .Left        = 249
            .Width       = 139
            .Height      = 17
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 1
                .Width     = 34
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 44
                .Top       = 1
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Nenhum"
                .Left      = 83
                .Top       = 1
                .Width     = 61
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Grupo/Conta de Finalizacao de Pedras (Say5) Top=234+29=263
        loc_oPg.AddObject("lbl_4c_Say5", "Label")
        WITH loc_oPg.lbl_4c_Say5
            .Caption   = "Grupo/Conta de Finaliza" + CHR(231) + CHR(227) + "o de Pedras :"
            .Top       = 263
            .Left      = 61
            .Width     = 192
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Variacao % (Say13) Top=234+29=263
        loc_oPg.AddObject("lbl_4c_Say13", "Label")
        WITH loc_oPg.lbl_4c_Say13
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o : %"
            .Top       = 263
            .Left      = 489
            .Width     = 121
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Premios (getPremios - premios) Top=230+29=259
        loc_oPg.AddObject("txt_4c_Premios", "TextBox")
        WITH loc_oPg.txt_4c_Premios
            .Value         = 0
            .Top           = 259
            .Left          = 541
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Gerar tubos por (Say7) Top=258+29=287
        loc_oPg.AddObject("lbl_4c_Say7", "Label")
        WITH loc_oPg.lbl_4c_Say7
            .Caption   = "Gerar tubos por :"
            .Top       = 287
            .Left      = 168
            .Width     = 85
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Fwoption6 (geratubs) Componentes/Matrizes Top=254+29=283
        loc_oPg.AddObject("obj_4c_Fwoption6", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption6
            .Value       = 2
            .Top         = 283
            .Left        = 249
            .Width       = 169
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Componentes"
                .Left      = 5
                .Top       = 5
                .Width     = 84
                .AutoSize  = .T.
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Matrizes"
                .Left      = 106
                .Top       = 5
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- Gravar no peso de metal (Say9) Top=279+29=308
        loc_oPg.AddObject("lbl_4c_Say9", "Label")
        WITH loc_oPg.lbl_4c_Say9
            .Caption   = "Gravar no peso de metal :"
            .Top       = 308
            .Left      = 126
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- optGravPeso (pesmts) Sim/Nao Top=275+29=304
        loc_oPg.AddObject("obj_4c_OptGravPeso", "OptionGroup")
        WITH loc_oPg.obj_4c_OptGravPeso
            .Value       = 2
            .Top         = 304
            .Left        = 249
            .Width       = 86
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 44
                .Top       = 5
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Cadastro Automatico de Categoria/Servico (Say1) Top=318+29=347 BOLD
        loc_oPg.AddObject("lbl_4c_SecAutocat", "Label")
        WITH loc_oPg.lbl_4c_SecAutocat
            .Caption   = "Cadastro Autom" + CHR(225) + "tico de Categoria / Servi" + CHR(231) + "o"
            .Top       = 347
            .Left      = 68
            .Width     = 251
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Linha separadora (Shape1) Top=334+29=363
        loc_oPg.AddObject("lbl_4c_Sepline1", "Label")
        WITH loc_oPg.lbl_4c_Sepline1
            .Caption     = ""
            .Top         = 363
            .Left        = 68
            .Width       = 326
            .Height      = 2
            .BackStyle   = 1
            .BackColor   = RGB(160, 160, 160)
            .BorderStyle = 0
            .Visible     = .F.
        ENDWITH

        *-- Servico de Producao (Say2) Top=342+29=371
        loc_oPg.AddObject("lbl_4c_Say2", "Label")
        WITH loc_oPg.lbl_4c_Say2
            .Caption   = "Servi" + CHR(231) + "o de Produ" + CHR(231) + CHR(227) + "o :"
            .Top       = 371
            .Left      = 114
            .Width     = 110
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- opt_ServProd (servprds) Sim/Nao Top=341+29=370
        loc_oPg.AddObject("obj_4c_Opt_ServProd", "OptionGroup")
        WITH loc_oPg.obj_4c_Opt_ServProd
            .Value       = 2
            .Top         = 370
            .Left        = 243
            .Width       = 86
            .Height      = 18
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .SpecialEffect = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 1
                .Width     = 34
                .AutoSize  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 44
                .Top       = 1
                .AutoSize  = .T.
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Base (P,Q,V) (Say6) Top=387+29=416
        loc_oPg.AddObject("lbl_4c_Say6", "Label")
        WITH loc_oPg.lbl_4c_Say6
            .Caption   = "Base (P,Q,V) :"
            .Top       = 416
            .Left      = 158
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Base (Get_base - bases) Top=384+29=413
        loc_oPg.AddObject("txt_4c_Base", "TextBox")
        WITH loc_oPg.txt_4c_Base
            .Value         = ""
            .Top           = 413
            .Left          = 245
            .Width         = 17
            .Height        = 23
            .MaxLength     = 1
            .Format    = "M"
            .InputMask = "P,Q,V"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Descricao Categoria (Say3) Top=436+29=465
        loc_oPg.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oPg.lbl_4c_Say3
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o Categoria :"
            .Top       = 465
            .Left      = 116
            .Width     = 130
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Descricao (Get_Descs - dcats) Top=433+29=462
        loc_oPg.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPg.txt_4c_Descricao
            .Value         = ""
            .Top           = 462
            .Left          = 245
            .Width         = 115
            .Height        = 23
            .MaxLength     = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaConfiguracao - Preenche Page6 (aba Configuração)
    * Campos: grucmvs, concmvs, gruestps, conestps, grctobccs, comiss,
    *         padlinha, padcolec, padcclas, padfinps, padfase, cunips
    *         cores, tams, embs, pesos, entregas, fornecs
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaConfiguracao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6

        *-- Label secao Contabilidade
        loc_oPg.AddObject("lbl_4c_SecContab", "Label")
        WITH loc_oPg.lbl_4c_SecContab
            .Caption   = "Contabilidade"
            .Top       = 85
            .Left      = 600
            .Width     = 175
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Grupo CMV (grucmvs) Top=85+29=114
        loc_oPg.AddObject("lbl_4c_Grucmvs", "Label")
        WITH loc_oPg.lbl_4c_Grucmvs
            .Caption   = "Grupo CMV :"
            .Top       = 114
            .Left      = 598
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Grucmvs", "TextBox")
        WITH loc_oPg.txt_4c_Grucmvs
            .Value         = ""
            .Top           = 110
            .Left          = 675
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Grucmvs, "LostFocus", THIS, "GrucmvsValid")
        BINDEVENT(loc_oPg.txt_4c_Grucmvs, "KeyPress", THIS, "GrucmvsKeyPress")

        loc_oPg.AddObject("txt_4c_DescGrucmvs", "TextBox")
        WITH loc_oPg.txt_4c_DescGrucmvs
            .Value       = ""
            .Top         = 110
            .Left        = 757
            .Width       = 150
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Conta CMV (concmvs) Top=85+29=114 (segunda coluna)
        loc_oPg.AddObject("lbl_4c_Concmvs", "Label")
        WITH loc_oPg.lbl_4c_Concmvs
            .Caption   = "Conta CMV :"
            .Top       = 139
            .Left      = 598
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Concmvs", "TextBox")
        WITH loc_oPg.txt_4c_Concmvs
            .Value         = ""
            .Top           = 135
            .Left          = 675
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Concmvs, "LostFocus", THIS, "ConcmvsValid")
        BINDEVENT(loc_oPg.txt_4c_Concmvs, "KeyPress", THIS, "ConcmvsKeyPress")

        loc_oPg.AddObject("txt_4c_DescConcmvs", "TextBox")
        WITH loc_oPg.txt_4c_DescConcmvs
            .Value       = ""
            .Top         = 135
            .Left        = 757
            .Width       = 150
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Grupo Estoque (gruestps) Top=161+29=190
        loc_oPg.AddObject("lbl_4c_Gruestps", "Label")
        WITH loc_oPg.lbl_4c_Gruestps
            .Caption   = "Grupo Estoque :"
            .Top       = 190
            .Left      = 590
            .Width     = 83
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Gruestps", "TextBox")
        WITH loc_oPg.txt_4c_Gruestps
            .Value         = ""
            .Top           = 186
            .Left          = 675
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Gruestps, "LostFocus", THIS, "GruestpsValid")
        BINDEVENT(loc_oPg.txt_4c_Gruestps, "KeyPress", THIS, "GruestpsKeyPress")

        *-- Conta Estoque (conestps)
        loc_oPg.AddObject("lbl_4c_Conestps", "Label")
        WITH loc_oPg.lbl_4c_Conestps
            .Caption   = "Conta Estoque :"
            .Top       = 190
            .Left      = 760
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Conestps", "TextBox")
        WITH loc_oPg.txt_4c_Conestps
            .Value         = ""
            *-- legado getCtaEsts: Top=161, MESMA linha do getGrpEsts (Grupo Estoque).
            *-- Estava em 206, 20px abaixo do par, caindo em cima do opt de
            *-- "Calcula Valor Estimado" da linha seguinte. Erro175.
            .Top           = 186
            .Left          = 757
            .Width         = 80
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Conestps, "LostFocus", THIS, "ConestpsValid")
        BINDEVENT(loc_oPg.txt_4c_Conestps, "KeyPress", THIS, "ConestpsKeyPress")

        *-- Grupo C.C. / Contra-conta (grctobccs)
        loc_oPg.AddObject("lbl_4c_Grctobccs", "Label")
        WITH loc_oPg.lbl_4c_Grctobccs
            .Caption   = "Grupo C.C. :"
            .Top       = 165
            .Left      = 598
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Grctobccs", "TextBox")
        WITH loc_oPg.txt_4c_Grctobccs
            .Value         = ""
            .Top           = 161
            .Left          = 675
            .Width         = 80
            .Height        = 23
            .MaxLength     = 21
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Comissao % (comiss) Top=85+29=114
        loc_oPg.AddObject("lbl_4c_Comiss", "Label")
        WITH loc_oPg.lbl_4c_Comiss
            .Caption   = "Comiss" + CHR(227) + "o % :"
            .Top       = 114
            .Left      = 155
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Comiss", "TextBox")
        WITH loc_oPg.txt_4c_Comiss
            .Value         = 0
            .Top           = 110
            .Left          = 259
            .Width         = 52
            .Height        = 23
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Linha Padrao (padlinha) Top=445+29=474
        loc_oPg.AddObject("lbl_4c_Padlinha", "Label")
        WITH loc_oPg.lbl_4c_Padlinha
            .Caption   = "Linha Padr" + CHR(227) + "o :"
            .Top       = 474
            .Left      = 340
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Padlinha", "TextBox")
        WITH loc_oPg.txt_4c_Padlinha
            .Value         = ""
            .Top           = 470
            .Left          = 412
            .Width         = 94
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Padlinha, "LostFocus", THIS, "PadlinhaValid")
        BINDEVENT(loc_oPg.txt_4c_Padlinha, "KeyPress", THIS, "PadlinhaKeyPress")

        loc_oPg.AddObject("txt_4c_DescPadlinha", "TextBox")
        WITH loc_oPg.txt_4c_DescPadlinha
            .Value       = ""
            .Top         = 470
            .Left        = 508
            .Width       = 150
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Colecao Padrao (padcolec) Top=471+29=500
        loc_oPg.AddObject("lbl_4c_Padcolec", "Label")
        WITH loc_oPg.lbl_4c_Padcolec
            .Caption   = "Cole" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :"
            .Top       = 500
            .Left      = 330
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Padcolec", "TextBox")
        WITH loc_oPg.txt_4c_Padcolec
            .Value         = ""
            .Top           = 496
            .Left          = 412
            .Width         = 94
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Padcolec, "LostFocus", THIS, "PadcolecValid")
        BINDEVENT(loc_oPg.txt_4c_Padcolec, "KeyPress", THIS, "PadcolecKeyPress")

        loc_oPg.AddObject("txt_4c_DescPadcolec", "TextBox")
        WITH loc_oPg.txt_4c_DescPadcolec
            .Value       = ""
            .Top         = 496
            .Left        = 508
            .Width       = 150
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Classificacao Padrao (padcclas) Top=445+29=474
        loc_oPg.AddObject("lbl_4c_Padcclas", "Label")
        WITH loc_oPg.lbl_4c_Padcclas
            .Caption   = "Classif. Padr" + CHR(227) + "o :"
            .Top       = 474
            .Left      = 85
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Padcclas", "TextBox")
        WITH loc_oPg.txt_4c_Padcclas
            .Value         = ""
            .Top           = 470
            .Left          = 164
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Padcclas, "LostFocus", THIS, "PadcclasValid")
        BINDEVENT(loc_oPg.txt_4c_Padcclas, "KeyPress", THIS, "PadcclasKeyPress")

        *-- Finalidade Padrao (padfinps) Top=445+29=474 (col 2)
        loc_oPg.AddObject("lbl_4c_Padfinps", "Label")
        WITH loc_oPg.lbl_4c_Padfinps
            .Caption   = "Finalidade Padr" + CHR(227) + "o :"
            .Top       = 500
            .Left      = 77
            .Width     = 85
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Padfinps", "TextBox")
        WITH loc_oPg.txt_4c_Padfinps
            .Value         = ""
            .Top           = 496
            .Left          = 164
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Padfinps, "LostFocus", THIS, "PadfinpsValid")
        BINDEVENT(loc_oPg.txt_4c_Padfinps, "KeyPress", THIS, "PadfinpsKeyPress")

        loc_oPg.AddObject("txt_4c_DescPadfinps", "TextBox")
        WITH loc_oPg.txt_4c_DescPadfinps
            .Value       = ""
            .Top         = 496
            .Left        = 197
            .Width       = 140
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Fase Padrao (padfase) Top=496+29=525
        loc_oPg.AddObject("lbl_4c_Padfase", "Label")
        WITH loc_oPg.lbl_4c_Padfase
            .Caption   = "Fase Padr" + CHR(227) + "o :"
            .Top       = 525
            .Left      = 340
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Padfase", "TextBox")
        WITH loc_oPg.txt_4c_Padfase
            .Value         = ""
            .Top           = 521
            .Left          = 412
            .Width         = 94
            .Height        = 23
            .MaxLength     = 10
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Padfase, "LostFocus", THIS, "PadfaseValid")
        BINDEVENT(loc_oPg.txt_4c_Padfase, "KeyPress", THIS, "PadfaseKeyPress")

        loc_oPg.AddObject("txt_4c_DescPadfase", "TextBox")
        WITH loc_oPg.txt_4c_DescPadfase
            .Value       = ""
            .Top         = 521
            .Left        = 508
            .Width       = 150
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *-- Unidade 1 (cunips) Top=496+29=525
        loc_oPg.AddObject("lbl_4c_Cunips", "Label")
        WITH loc_oPg.lbl_4c_Cunips
            .Caption   = "Unidade 1 :"
            .Top       = 525
            .Left      = 85
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cunips", "TextBox")
        WITH loc_oPg.txt_4c_Cunips
            .Value         = ""
            .Top           = 521
            .Left          = 164
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cunips, "LostFocus", THIS, "CunipsValid")
        BINDEVENT(loc_oPg.txt_4c_Cunips, "KeyPress", THIS, "CunipsKeyPress")

        loc_oPg.AddObject("txt_4c_DescCunips", "TextBox")
        WITH loc_oPg.txt_4c_DescCunips
            .Value       = ""
            .Top         = 521
            .Left        = 197
            .Width       = 140
            .Height      = 23
            .ReadOnly    = .T.
            .BackStyle   = 0
            .BorderStyle = 0
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(90, 90, 90)
            .Visible     = .F.
        ENDWITH

        *======================================================================
        * REMOVIDOS (Erro175): seis pares label+OptionGroup que o migrador criou
        * AQUI, na pagina Configuracao, em Top 149/174/199/224/249/274 e Left 85 -
        * exatamente entre as linhas do ConfigurarPgpgConfig, deixando rotulo sobre
        * rotulo ("Cor :" sobre "Grupo Manual na Copia de Produto :", e por ai).
        *
        * Eles nao existem nesta pagina no legado. Medido no dump:
        *   cores / tams / embs / pesos / entregas -> sao o bloco "Grade de Sub-Itens"
        *     da aba ESTOQUE/FISCAL (pgEstoque), como CheckBox: ChkCors, ChkTams,
        *     ChkEmbs, ChkPesos, ChkEntregas. O migrado ja os tem la
        *     (chk_4c_Cors/Tams/Embs/Pesos/Entregas), so faltava liga-los ao BO.
        *   fornecs -> eh o Get_fornobri da aba PRODUTOS (pgProdutos), que o migrado
        *     ja tem como cbo_4c_Fornecs, inclusive mapeado.
        *
        * O mapeamento em FormParaBO/BOParaForm/LimparCampos foi re-apontado para os
        * controles legitimos. O Top vinha como ARGUMENTO da chamada (nao como linha
        * `.Top =`), e por isso estes seis escaparam da varredura de offset do Erro175.
        *======================================================================

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * ConfigurarPgpgConfig - Preenche Page6 (pgConfig): opcoes de configuracao,
    * titulos de preco e preenchimento padrao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgConfig()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6

        *-- OptionGroups coluna esquerda (Left=253) ---------------------------------

        *-- get_InfoGru: Diggprs (Grupo Manual na Copia de Produto)
        loc_oPg.AddObject("lbl_4c_LbInfoGru", "Label")
        WITH loc_oPg.lbl_4c_LbInfoGru
            .Caption   = "Grupo Manual na C" + CHR(243) + "pia de Produto :"
            .Top       = 143
            .Left      = 81
            .Width     = 172
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_GetInfoGru", "OptionGroup")
        WITH loc_oPg.obj_4c_GetInfoGru
            .Value       = 2
            .Top         = 138
            .Left        = 253
            .Width       = 97
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 55
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- fwoption1: ftecsubs (Utiliza Subgrupo na Ficha Tecnica)
        loc_oPg.AddObject("lbl_4c_LbFwoption1", "Label")
        WITH loc_oPg.lbl_4c_LbFwoption1
            .Caption   = "Utiliza Subgrupo na Ficha T" + CHR(233) + "cnica :"
            .Top       = 166
            .Left      = 89
            .Width     = 164
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption1
            .Value       = 2
            .Top         = 161
            .Left        = 253
            .Width       = 97
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 55
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- fwoption8: dwvendas (Alerta Ref. Fornecedor Igual em Produtos)
        loc_oPg.AddObject("lbl_4c_LbFwoption8", "Label")
        WITH loc_oPg.lbl_4c_LbFwoption8
            .Caption   = "Alerta Ref. Fornecedor Igual em Produtos :"
            .Top       = 190
            .Left      = 47
            .Width     = 206
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Fwoption8", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption8
            .Value       = 2
            .Top         = 185
            .Left        = 253
            .Width       = 97
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 55
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- optICustos: ICustos (Inibir Pasta de Custos)
        loc_oPg.AddObject("lbl_4c_LbOptICustos", "Label")
        WITH loc_oPg.lbl_4c_LbOptICustos
            .Caption   = "Inibir Pasta de Custos :"
            .Top       = 213
            .Left      = 143
            .Width     = 110
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_OptICustos", "OptionGroup")
        WITH loc_oPg.obj_4c_OptICustos
            .Value       = 2
            .Top         = 208
            .Left        = 253
            .Width       = 97
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 55
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- fwoption2: Caracteris (Utiliza Caracteristicas)
        loc_oPg.AddObject("lbl_4c_LbFwoption2", "Label")
        WITH loc_oPg.lbl_4c_LbFwoption2
            .Caption   = "Utiliza Caracter" + CHR(237) + "sticas :"
            .Top       = 235
            .Left      = 146
            .Width     = 107
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption2
            .Value       = 2
            .Top         = 230
            .Left        = 253
            .Width       = 97
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 55
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- optRecPesC: 3 botoes Nao/Uni1/Uni2 (Recalculo de Pesos)
        loc_oPg.AddObject("lbl_4c_LbOptRecPesC", "Label")
        WITH loc_oPg.lbl_4c_LbOptRecPesC
            .Caption   = "Rec" + CHR(225) + "lculo de Pesos de Componentes :"
            .Top       = 255
            .Left      = 73
            .Width     = 180
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_OptRecPesC", "OptionGroup")
        WITH loc_oPg.obj_4c_OptRecPesC
            .Value       = 1
            .Top         = 250
            .Left        = 253
            .Width       = 158
            .Height      = 25
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 5
                .Top       = 5
                .Width     = 37
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Uni 1"
                .Left      = 55
                .Top       = 5
                .Width     = 42
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Uni 2"
                .Left      = 111
                .Top       = 5
                .Width     = 42
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- optCompIna: Nao Mostrar Componentes Inativos (cfggergprs)
        loc_oPg.AddObject("lbl_4c_LbOptCompIna", "Label")
        WITH loc_oPg.lbl_4c_LbOptCompIna
            .Caption   = "N" + CHR(227) + "o Mostrar Componentes Inativos :"
            .Top       = 275
            .Left      = 78
            .Width     = 175
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_OptCompIna", "OptionGroup")
        WITH loc_oPg.obj_4c_OptCompIna
            .Value       = 1
            .Top         = 271
            .Left        = 253
            .Width       = 97
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 55
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- Opt_PrdRefCmp: PrdRefCmp (Produto por Referencia na Composicao)
        loc_oPg.AddObject("lbl_4c_LbOptPrdRefCmp", "Label")
        WITH loc_oPg.lbl_4c_LbOptPrdRefCmp
            .Caption   = "Prod. por Refer" + CHR(234) + "ncia na Composi" + CHR(231) + CHR(227) + "o :"
            .Top       = 294
            .Left      = 69
            .Width     = 184
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_OptPrdRefCmp", "OptionGroup")
        WITH loc_oPg.obj_4c_OptPrdRefCmp
            .Value       = 2
            .Top         = 290
            .Left        = 253
            .Width       = 99
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 57
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- OptionGroups coluna direita (Left=669) ----------------------------------

        *-- fwoption3: cvestims (Calcula Valor Estimado)
        loc_oPg.AddObject("lbl_4c_LbFwoption3", "Label")
        WITH loc_oPg.lbl_4c_LbFwoption3
            .Caption   = "Calcula Valor Estimado :"
            .Top       = 216
            .Left      = 557
            .Width     = 112
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption3
            .Value       = 2
            .Top         = 211
            .Left        = 669
            .Width       = 122
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 80
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- fwoption6: nGenerics (Calculo de Qtde.) - Nenhum/Peso Medio
        loc_oPg.AddObject("lbl_4c_LbFwoption6", "Label")
        WITH loc_oPg.lbl_4c_LbFwoption6
            .Caption   = "C" + CHR(225) + "lculo de Qtde. :"
            .Top       = 233
            .Left      = 584
            .Width     = 85
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Fwoption6", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption6
            .Value       = 1
            .Top         = 228
            .Left        = 669
            .Width       = 157
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Nenhum"
                .Left      = 5
                .Top       = 5
                .Width     = 57
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Peso M" + CHR(233) + "dio"
                .Left      = 80
                .Top       = 5
                .Width     = 72
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- optInstalas: chkInstalas (Calculo de Valor de Custo) - Qtde/Peso
        loc_oPg.AddObject("lbl_4c_LbOptInstalas", "Label")
        WITH loc_oPg.lbl_4c_LbOptInstalas
            .Caption   = "Calculo de Valor de Custo :"
            .Top       = 251
            .Left      = 542
            .Width     = 127
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_OptInstalas", "OptionGroup")
        WITH loc_oPg.obj_4c_OptInstalas
            .Value       = 1
            .Top         = 246
            .Left        = 669
            .Width       = 126
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Qtde"
                .Left      = 5
                .Top       = 5
                .Width     = 42
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Peso"
                .Left      = 80
                .Top       = 5
                .Width     = 40
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- optQtdRPP: Qtde no Doc. Padrao da Mov. - Imprimir/Ocultar
        loc_oPg.AddObject("lbl_4c_LbOptQtdRPP", "Label")
        WITH loc_oPg.lbl_4c_LbOptQtdRPP
            .Caption   = "Qtde. no Doc. Padr" + CHR(227) + "o da Mov. :"
            .Top       = 269
            .Left      = 517
            .Width     = 152
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_OptQtdRPP", "OptionGroup")
        WITH loc_oPg.obj_4c_OptQtdRPP
            .Value       = 1
            .Top         = 264
            .Left        = 669
            .Width       = 138
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Imprimir"
                .Left      = 5
                .Top       = 5
                .Width     = 56
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Ocultar"
                .Left      = 80
                .Top       = 5
                .Width     = 52
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- Fwoption4: AtuPreTam (Atualiza Preco do Tamanho quando salvar Produto)
        loc_oPg.AddObject("lbl_4c_LbFwoption4", "Label")
        WITH loc_oPg.lbl_4c_LbFwoption4
            .Caption   = "Atualiza o Pre" + CHR(231) + "o do Tamanho quando salvar o Produto :"
            .Top       = 287
            .Left      = 404
            .Width     = 265
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Fwoption4", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption4
            .Value       = 2
            .Top         = 283
            .Left        = 669
            .Width       = 122
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 80
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- Fwoption5: AtuDesCol (cfggergprs - Atualiza Design pela Colecao)
        loc_oPg.AddObject("lbl_4c_LbFwoption5", "Label")
        WITH loc_oPg.lbl_4c_LbFwoption5
            .Caption   = "Atualiza dados do Design pela cole" + CHR(231) + CHR(227) + "o quando salvar o Produto :"
            .Top       = 307
            .Left      = 360
            .Width     = 309
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Fwoption5", "OptionGroup")
        WITH loc_oPg.obj_4c_Fwoption5
            .Value       = 2
            .Top         = 303
            .Left        = 669
            .Width       = 122
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 80
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- chkOCCuss: C.C. Obrigatorio (cfggergprs) Top=140, Left=844
        loc_oPg.AddObject("chk_4c_ChkOCCuss", "CheckBox")
        WITH loc_oPg.chk_4c_ChkOCCuss
            .Caption       = "C.C. Obrigat" + CHR(243) + "rio"
            .Top           = 169
            .Left          = 844
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Finalidades container (Top=193, Left=851)
        loc_oPg.AddObject("cnt_4c_Finalidades", "Container")
        WITH loc_oPg.cnt_4c_Finalidades
            .Top         = 222
            .Left        = 851
            .Width       = 66
            .Height      = 64
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .F.
        ENDWITH
        loc_oPg.cnt_4c_Finalidades.AddObject("lbl_4c_LblPedido", "Label")
        WITH loc_oPg.cnt_4c_Finalidades.lbl_4c_LblPedido
            .Caption   = "Finalidade"
            .Top       = 3
            .Left      = 3
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH
        loc_oPg.cnt_4c_Finalidades.AddObject("cmd_4c_BtnOptFin", "CommandButton")
        WITH loc_oPg.cnt_4c_Finalidades.cmd_4c_BtnOptFin
            .Top         = 20
            .Left        = 3
            .Width       = 60
            .Height      = 40
            .Caption     = ""
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .ToolTipText = "Selecionar Finalidade da opera" + CHR(231) + CHR(227) + "o"
            .Themes      = .T.
            .Visible     = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_Finalidades.cmd_4c_BtnOptFin, "Click", THIS, "BtnOptFinClick")

        *-- Shape2: linha separadora horizontal (Top=309)
        loc_oPg.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPg.shp_4c_Shape2
            .Top           = 338
            .Left          = 8
            .Width         = 980
            .Height        = 1
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Titulo secao Titulos do Cadastro de Produtos (Top=314)
        loc_oPg.AddObject("lbl_4c_TitulosCadProd", "Label")
        WITH loc_oPg.lbl_4c_TitulosCadProd
            .Caption   = "T" + CHR(237) + "tulos do Cadastro de Produtos"
            .Top       = 343
            .Left      = 17
            .Width     = 220
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Descricoes de preco Row1 (labels Top~335, textboxes Top=349) -----------

        *-- DscPcuss (Preco de Custo)
        loc_oPg.AddObject("lbl_4c_LbDscPcuss", "Label")
        WITH loc_oPg.lbl_4c_LbDscPcuss
            .Caption   = "Pre" + CHR(231) + "o de Custo :"
            .Top       = 364
            .Left      = 18
            .Width     = 95
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_DscPcuss", "TextBox")
        WITH loc_oPg.txt_4c_DscPcuss
            .Value         = ""
            .Top           = 378
            .Left          = 18
            .Width         = 115
            .Height        = 23
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- DscFcustos (Fator de Custo)
        loc_oPg.AddObject("lbl_4c_LbDscFcustos", "Label")
        WITH loc_oPg.lbl_4c_LbDscFcustos
            .Caption   = "Fator de Custo :"
            .Top       = 364
            .Left      = 137
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_DscFcustos", "TextBox")
        WITH loc_oPg.txt_4c_DscFcustos
            .Value         = ""
            .Top           = 378
            .Left          = 137
            .Width         = 115
            .Height        = 23
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- DscPvideals (Preco Ideal)
        loc_oPg.AddObject("lbl_4c_LbDscPvideals", "Label")
        WITH loc_oPg.lbl_4c_LbDscPvideals
            .Caption   = "Pre" + CHR(231) + "o Ideal :"
            .Top       = 364
            .Left      = 257
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_DscPvideals", "TextBox")
        WITH loc_oPg.txt_4c_DscPvideals
            .Value         = ""
            .Top           = 378
            .Left          = 257
            .Width         = 115
            .Height        = 23
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Acabamento (display only)
        loc_oPg.AddObject("lbl_4c_LbAcabamento", "Label")
        WITH loc_oPg.lbl_4c_LbAcabamento
            .Caption   = "Acabamento :"
            .Top       = 363
            .Left      = 377
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_Acabamento", "TextBox")
        WITH loc_oPg.txt_4c_Acabamento
            .Value         = ""
            .Top           = 378
            .Left          = 377
            .Width         = 115
            .Height        = 23
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Classificacao (display only)
        loc_oPg.AddObject("lbl_4c_LbClassificacao", "Label")
        WITH loc_oPg.lbl_4c_LbClassificacao
            .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
            .Top       = 363
            .Left      = 496
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_Classificacao", "TextBox")
        WITH loc_oPg.txt_4c_Classificacao
            .Value         = ""
            .Top           = 378
            .Left          = 496
            .Width         = 115
            .Height        = 23
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Modelo row 1 (display only)
        loc_oPg.AddObject("lbl_4c_LbModeloR1", "Label")
        WITH loc_oPg.lbl_4c_LbModeloR1
            .Caption   = "Modelo :"
            .Top       = 363
            .Left      = 616
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_Modelo", "TextBox")
        WITH loc_oPg.txt_4c_Modelo
            .Value         = ""
            .Top           = 378
            .Left          = 616
            .Width         = 115
            .Height        = 23
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Descricoes de preco Row2 (labels Top~374, textboxes Top=389) -----------

        *-- DscPvens (Preco Atual)
        loc_oPg.AddObject("lbl_4c_LbDscPvens", "Label")
        WITH loc_oPg.lbl_4c_LbDscPvens
            .Caption   = "Pre" + CHR(231) + "o Atual :"
            .Top       = 403
            .Left      = 18
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_DscPvens", "TextBox")
        WITH loc_oPg.txt_4c_DscPvens
            .Value         = ""
            .Top           = 418
            .Left          = 18
            .Width         = 115
            .Height        = 23
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- DscFideals (Fator Ideal)
        loc_oPg.AddObject("lbl_4c_LbDscFideals", "Label")
        WITH loc_oPg.lbl_4c_LbDscFideals
            .Caption   = "Fator Ideal :"
            .Top       = 403
            .Left      = 137
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_DscFideals", "TextBox")
        WITH loc_oPg.txt_4c_DscFideals
            .Value         = ""
            .Top           = 418
            .Left          = 137
            .Width         = 115
            .Height        = 23
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- DscFatuals (Fator Atual)
        loc_oPg.AddObject("lbl_4c_LbDscFatuals", "Label")
        WITH loc_oPg.lbl_4c_LbDscFatuals
            .Caption   = "Fator Atual :"
            .Top       = 403
            .Left      = 257
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_DscFatuals", "TextBox")
        WITH loc_oPg.txt_4c_DscFatuals
            .Value         = ""
            .Top           = 418
            .Left          = 257
            .Width         = 115
            .Height        = 23
            .MaxLength     = 30
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Profundidade (display only)
        loc_oPg.AddObject("lbl_4c_LbProfundidade", "Label")
        WITH loc_oPg.lbl_4c_LbProfundidade
            .Caption   = "Profundidade :"
            .Top       = 405
            .Left      = 377
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_Profundidade", "TextBox")
        WITH loc_oPg.txt_4c_Profundidade
            .Value         = ""
            .Top           = 420
            .Left          = 377
            .Width         = 115
            .Height        = 23
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Altura (display only)
        loc_oPg.AddObject("lbl_4c_LbAltura", "Label")
        WITH loc_oPg.lbl_4c_LbAltura
            .Caption   = "Altura :"
            .Top       = 405
            .Left      = 496
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_Altura", "TextBox")
        WITH loc_oPg.txt_4c_Altura
            .Value         = ""
            .Top           = 420
            .Left          = 496
            .Width         = 115
            .Height        = 23
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Comprimento (display only)
        loc_oPg.AddObject("lbl_4c_LbComprimento", "Label")
        WITH loc_oPg.lbl_4c_LbComprimento
            .Caption   = "Comprimento :"
            .Top       = 405
            .Left      = 616
            .Width     = 80
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_Comprimento", "TextBox")
        WITH loc_oPg.txt_4c_Comprimento
            .Value         = ""
            .Top           = 420
            .Left          = 616
            .Width         = 115
            .Height        = 23
            .MaxLength     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Shape1: linha separadora horizontal (Top=420)
        loc_oPg.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPg.shp_4c_Shape1
            .Top           = 449
            .Left          = 8
            .Width         = 980
            .Height        = 1
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Titulo secao Preenchimento Padrao (Top=427)
        loc_oPg.AddObject("lbl_4c_SecPreenchimento", "Label")
        WITH loc_oPg.lbl_4c_SecPreenchimento
            .Caption   = "Preenchimento Padr" + CHR(227) + "o"
            .Top       = 456
            .Left      = 19
            .Width     = 140
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Checkboxes secao Preenchimento Padrao ----------------------------------

        *-- chk_4c_Ajpvens: AJPvens (Cor Obrigatoria) Top=448, Left=809
        loc_oPg.AddObject("chk_4c_Ajpvens", "CheckBox")
        WITH loc_oPg.chk_4c_Ajpvens
            .Caption       = "Cor Obrigat" + CHR(243) + "ria"
            .Top           = 477
            .Left          = 809
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_Obrlinha: ObrLinha Top=448, Left=510
        loc_oPg.AddObject("chk_4c_Obrlinha", "CheckBox")
        WITH loc_oPg.chk_4c_Obrlinha
            .Caption       = "Obrigat" + CHR(243) + "rio"
            .Top           = 477
            .Left          = 510
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_Obridecs: ObrIdeCs Top=448, Left=617
        loc_oPg.AddObject("chk_4c_Obridecs", "CheckBox")
        WITH loc_oPg.chk_4c_Obridecs
            .Caption       = "Identificador Obrigat" + CHR(243) + "rio"
            .Top           = 477
            .Left          = 617
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_Obrcclas: ObrCClas Top=449, Left=201
        loc_oPg.AddObject("chk_4c_Obrcclas", "CheckBox")
        WITH loc_oPg.chk_4c_Obrcclas
            .Caption       = "Obrigat" + CHR(243) + "rio"
            .Top           = 478
            .Left          = 201
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_Obrsgrus: ObrSgrus Top=466, Left=617
        loc_oPg.AddObject("chk_4c_Obrsgrus", "CheckBox")
        WITH loc_oPg.chk_4c_Obrsgrus
            .Caption       = "Subgrupo Obrigat" + CHR(243) + "rio"
            .Top           = 495
            .Left          = 617
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_EqvObrigs: Equivalente Obrigatorio (cfggergprs) Top=466, Left=809
        loc_oPg.AddObject("chk_4c_EqvObrigs", "CheckBox")
        WITH loc_oPg.chk_4c_EqvObrigs
            .Caption       = "Equivalente Obrigat" + CHR(243) + "rio"
            .Top           = 495
            .Left          = 809
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_Obrfinps: ObrFinPs Top=475, Left=201
        loc_oPg.AddObject("chk_4c_Obrfinps", "CheckBox")
        WITH loc_oPg.chk_4c_Obrfinps
            .Caption       = "Obrigat" + CHR(243) + "rio"
            .Top           = 504
            .Left          = 201
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_Obrcolec: ObrColec Top=475, Left=510
        loc_oPg.AddObject("chk_4c_Obrcolec", "CheckBox")
        WITH loc_oPg.chk_4c_Obrcolec
            .Caption       = "Obrigat" + CHR(243) + "rio"
            .Top           = 504
            .Left          = 510
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_AltSubgs: Permite Alterar Subgrupo (cfggergprs) Top=484, Left=617
        loc_oPg.AddObject("chk_4c_AltSubgs", "CheckBox")
        WITH loc_oPg.chk_4c_AltSubgs
            .Caption       = "Permite Alterar Subgrupo"
            .Top           = 513
            .Left          = 617
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_Chkmedida: ObrDimes (Dimensoes P,A,L) Top=484, Left=809
        loc_oPg.AddObject("chk_4c_Chkmedida", "CheckBox")
        WITH loc_oPg.chk_4c_Chkmedida
            .Caption       = "Dimens" + CHR(245) + "es (P, A, L)"
            .Top           = 513
            .Left          = 809
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_ObrigCompos: "Compos" Obrigatorio (cfggergprs) Top=503, Left=617
        loc_oPg.AddObject("chk_4c_ObrigCompos", "CheckBox")
        WITH loc_oPg.chk_4c_ObrigCompos
            .Caption       = CHR(34) + "Compos" + CHR(34) + " Obrigat" + CHR(243) + "rio"
            .Top           = 532
            .Left          = 617
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_MpObriga: Material principal Obrigatorio (cfggergprs) Top=503, Left=809
        loc_oPg.AddObject("chk_4c_MpObriga", "CheckBox")
        WITH loc_oPg.chk_4c_MpObriga
            .Caption       = "Material principal Obrigat" + CHR(243) + "rio"
            .Top           = 532
            .Left          = 809
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- txt_4c_Unidade2 / lbl / chk (cfggergprs)
        loc_oPg.AddObject("lbl_4c_Unidade2", "Label")
        WITH loc_oPg.lbl_4c_Unidade2
            .Caption   = "Unidade 2 :"
            .Top       = 553
            .Left      = 105
            .Width     = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_Unidade2", "TextBox")
        WITH loc_oPg.txt_4c_Unidade2
            .Value         = ""
            .Top           = 550
            .Left          = 164
            .Width         = 31
            .Height        = 23
            .MaxLength     = 3
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Unidade2, "LostFocus", THIS, "Unidade2Valid")
        BINDEVENT(loc_oPg.txt_4c_Unidade2, "KeyPress", THIS, "Unidade2KeyPress")

        *-- chk_4c_Chkunidade2: Unidade2 Obrigatorio (cfggergprs) Top=526, Left=201
        loc_oPg.AddObject("chk_4c_Chkunidade2", "CheckBox")
        WITH loc_oPg.chk_4c_Chkunidade2
            .Caption       = "Obrigat" + CHR(243) + "rio"
            .Top           = 555
            .Left          = 201
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_Obrpesoms: ObrPesoMs Top=522, Left=617
        loc_oPg.AddObject("chk_4c_Obrpesoms", "CheckBox")
        WITH loc_oPg.chk_4c_Obrpesoms
            .Caption       = "Peso M" + CHR(233) + "dio Obrigat" + CHR(243) + "rio"
            .Top           = 551
            .Left          = 617
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_Obrservico: ObrServico Top=522, Left=809
        loc_oPg.AddObject("chk_4c_Obrservico", "CheckBox")
        WITH loc_oPg.chk_4c_Obrservico
            .Caption       = "Servi" + CHR(231) + "os Obrigat" + CHR(243) + "rio"
            .Top           = 551
            .Left          = 809
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_Obrconjuts: ObrConjuts Top=544, Left=617
        loc_oPg.AddObject("chk_4c_Obrconjuts", "CheckBox")
        WITH loc_oPg.chk_4c_Obrconjuts
            .Caption       = "Conjunto/Cod. Pai Obrigat" + CHR(243) + "rio"
            .Top           = 573
            .Left          = 617
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- chk_4c_Vldconjuts: vldconjuts Top=565, Left=617
        loc_oPg.AddObject("chk_4c_Vldconjuts", "CheckBox")
        WITH loc_oPg.chk_4c_Vldconjuts
            .Caption       = "Valida Inf. Conjunto/Cod. Pai"
            .Top           = 594
            .Left          = 617
            .Value         = 0
            .Height        = 19
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- txt_4c_MinRefFors: Minimo Ref. Fornecedor Top=547, Left=164
        loc_oPg.AddObject("lbl_4c_MinRefFors", "Label")
        WITH loc_oPg.lbl_4c_MinRefFors
            .Caption   = "Minimo Ref. Fornec.:"
            .Top       = 580
            .Left      = 60
            .Width     = 102
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_MinRefFors", "TextBox")
        WITH loc_oPg.txt_4c_MinRefFors
            .Value         = 0
            .Top           = 576
            .Left          = 164
            .Width         = 31
            .Height        = 23
            .InputMask     = "99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- txt_4c_MinObsComs: Minimo Obs. Componente Top=573, Left=164
        loc_oPg.AddObject("lbl_4c_MinObsComs", "Label")
        WITH loc_oPg.lbl_4c_MinObsComs
            .Caption   = "Minimo Obs. Componente :"
            .Top       = 606
            .Left      = 31
            .Width     = 131
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH
        loc_oPg.AddObject("txt_4c_MinObsComs", "TextBox")
        WITH loc_oPg.txt_4c_MinObsComs
            .Value         = 0
            .Top           = 602
            .Left          = 164
            .Width         = 31
            .Height        = 23
            .InputMask     = "99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * AdicionarOpcaoSimNao - Helper para criar label + OptionGroup Sim/Nao
    *==========================================================================
    PROTECTED PROCEDURE AdicionarOpcaoSimNao(par_oPage, par_cNomeLbl, par_cNomeOpt, ;
        par_cCaption, par_nTop, par_nLeftLbl, par_nLeftOpt)

        *-- Controls() eh array indexado por NUMERO, nunca por nome (medido no VFP9):
        *-- em WITH, Controls("nome") estoura "CONTROLS is not an object" e a tela nao
        *-- abre; em expressao, "Invalid subscript reference". Para alcancar membro por
        *-- NOME usa-se EVALUATE (leitura) / STORE ... TO (...) (atribuicao) - regra #15
        *-- do CLAUDE.md. O PEMSTATUS que guarda esses blocos devolve .T. e nao protege.
        *-- Erro171.
        par_oPage.AddObject(par_cNomeLbl, "Label")
        WITH EVALUATE("par_oPage." + par_cNomeLbl)
            .Caption   = par_cCaption
            .Top       = par_nTop
            .Left      = par_nLeftLbl
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        par_oPage.AddObject(par_cNomeOpt, "OptionGroup")
        WITH EVALUATE("par_oPage." + par_cNomeOpt)
            .Value        = 2
            .Top          = par_nTop - 4
            .Left         = par_nLeftOpt
            .Width        = 120
            .Height       = 25
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Left    = 5
                .Top     = 5
                .Width   = 34
                .Height  = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Left    = 60
                .Top     = 5
                .Width   = 34
                .Height  = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarAbaSubGrupos - Preenche Page7 (aba SubGrupos)
    * Grid para gestao de subgrupos do grupo atual
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaSubGrupos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page7

        *-- Label titulo
        loc_oPg.AddObject("lbl_4c_TituloSgrus", "Label")
        WITH loc_oPg.lbl_4c_TituloSgrus
            .Caption   = "Sub-Grupos do Grupo"
            .Top       = 100
            .Left      = 149
            .Width     = 200
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Grid de SubGrupos (grd_4c_SigCdPsg)
        *-- Legado: Top=122+29=151, Left=149, Width=592, Height=462
        loc_oPg.AddObject("grd_4c_SigCdPsg", "Grid")
        WITH loc_oPg.grd_4c_SigCdPsg
            .Top         = 151
            .Left        = 149
            .Width       = 592
            .Height      = 462
            .ColumnCount = 3
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .FontName    = "Courier New"
            .FontSize    = 9
            .Visible     = .F.
            .Column1.Width     = 80
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column2.Width     = 350
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column3.Width     = 120
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
        ENDWITH

        *-- Botoes inserir/excluir subgrupo
        loc_oPg.AddObject("cmg_4c_BotoesSgrus", "CommandGroup")
        WITH loc_oPg.cmg_4c_BotoesSgrus
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 303
            .Left        = 756
            .Width       = 43
            .Height      = 89
            .Themes      = .F.
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption    = ""
                .Picture    = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .Top        = -1
                .Left       = -1
                .Height     = 45
                .Width      = 45
                .Themes     = .F.
                .ToolTipText = "Inserir Sub-Grupo"
                .BackColor  = RGB(255,255,255)
            ENDWITH
            WITH .Buttons(2)
                .Caption    = ""
                .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Top        = 44
                .Left       = -1
                .Height     = 45
                .Width      = 45
                .Themes     = .F.
                .ToolTipText = "Excluir Sub-Grupo"
                .BackColor  = RGB(255,255,255)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPg.cmg_4c_BotoesSgrus, "Click", THIS, "BtnSubGrupoClick")

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * ConfigurarAbaCodificacao - Preenche Page8 (aba Codificação)
    * Campos: compos (mascara), digimaxs, ordcompos, casas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaCodificacao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8

        *-- Mascara do Codigo (compos) Top=166+29=195
        loc_oPg.AddObject("lbl_4c_Compos", "Label")
        WITH loc_oPg.lbl_4c_Compos
            .Caption   = "M" + CHR(225) + "scara C" + CHR(243) + "d. Produto :"
            .Top       = 195
            .Left      = 360
            .Width     = 155
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Compos", "TextBox")
        WITH loc_oPg.txt_4c_Compos
            .Value         = ""
            .Top           = 191
            .Left          = 518
            .Width         = 162
            .Height        = 28
            .MaxLength     = 30
            .Format        = "!K"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Digitos Maximo (digimaxs)
        loc_oPg.AddObject("lbl_4c_Digimaxs", "Label")
        WITH loc_oPg.lbl_4c_Digimaxs
            .Caption   = "D" + CHR(237) + "gitos M" + CHR(225) + "ximo :"
            .Top       = 260
            .Left      = 35
            .Width     = 120
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Digimaxs", "TextBox")
        WITH loc_oPg.txt_4c_Digimaxs
            .Value         = 0
            .Top           = 256
            .Left          = 157
            .Width         = 40
            .Height        = 23
            .InputMask     = "99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Ordem Composicao (ordcompos)
        loc_oPg.AddObject("lbl_4c_Ordcompos", "Label")
        WITH loc_oPg.lbl_4c_Ordcompos
            .Caption   = "Ordem Composi" + CHR(231) + CHR(227) + "o :"
            .Top       = 285
            .Left      = 35
            .Width     = 120
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Ordcompos", "TextBox")
        WITH loc_oPg.txt_4c_Ordcompos
            .Value         = 0
            .Top           = 281
            .Left          = 157
            .Width         = 40
            .Height        = 23
            .InputMask     = "99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Casas Decimais (casas)
        loc_oPg.AddObject("lbl_4c_Casas", "Label")
        WITH loc_oPg.lbl_4c_Casas
            .Caption   = "Casas Decimais :"
            .Top       = 310
            .Left      = 35
            .Width     = 120
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Casas", "TextBox")
        WITH loc_oPg.txt_4c_Casas
            .Value         = 0
            .Top           = 306
            .Left          = 157
            .Width         = 40
            .Height        = 23
            .InputMask     = "99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Grid de Componentes de Codificacao (grdCodificacao)
        *-- Legado: Top=139+29=168, Left=280, Width=202, Height=326
        loc_oPg.AddObject("grd_4c_Codificacao", "Grid")
        WITH loc_oPg.grd_4c_Codificacao
            .Top         = 168
            .Left        = 280
            .Width       = 202
            .Height      = 326
            .ColumnCount = 3
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .FontName    = "Courier New"
            .FontSize    = 8
            .Visible     = .F.
            .Column1.Width     = 60
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column2.Width     = 80
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column3.Width     = 40
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * ConfigurarAbaComposicao - Preenche Page9 (aba Compos)
    * Grid de composicao de produtos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAbaComposicao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9

        *-- Label titulo
        loc_oPg.AddObject("lbl_4c_TituloCompos", "Label")
        WITH loc_oPg.lbl_4c_TituloCompos
            .Caption   = "Composi" + CHR(231) + CHR(227) + "o de Produtos"
            .Top       = 145
            .Left      = 77
            .Width     = 200
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Filtro container (Top=203+29=232)
        loc_oPg.AddObject("cnt_4c_FiltroCompos", "Container")
        WITH loc_oPg.cnt_4c_FiltroCompos
            .Top         = 232
            .Left        = 77
            .Width       = 779
            .Height      = 49
            .BackStyle   = 0
            .BorderWidth = 1
            .BorderColor = RGB(180, 180, 180)
            .Visible     = .F.
        ENDWITH

        loc_oPg.cnt_4c_FiltroCompos.AddObject("lbl_4c_FiltGrupo", "Label")
        WITH loc_oPg.cnt_4c_FiltroCompos.lbl_4c_FiltGrupo
            .Caption   = "Grupo :"
            .Top       = 14
            .Left      = 5
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.cnt_4c_FiltroCompos.AddObject("txt_4c_FiltGrupo", "TextBox")
        WITH loc_oPg.cnt_4c_FiltroCompos.txt_4c_FiltGrupo
            .Value       = ""
            .Top         = 10
            .Left        = 48
            .Width       = 185
            .Height      = 23
            .MaxLength   = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible     = .F.
        ENDWITH
        BINDEVENT(loc_oPg.cnt_4c_FiltroCompos.txt_4c_FiltGrupo, "KeyPress", ;
            THIS, "FiltroComposKeyPress")

        loc_oPg.cnt_4c_FiltroCompos.AddObject("lbl_4c_FiltPreco", "Label")
        WITH loc_oPg.cnt_4c_FiltroCompos.lbl_4c_FiltPreco
            .Caption   = "Pre" + CHR(231) + "o :"
            .Top       = 14
            .Left      = 250
            .Width     = 40
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.cnt_4c_FiltroCompos.AddObject("txt_4c_FiltPreco", "TextBox")
        WITH loc_oPg.cnt_4c_FiltroCompos.txt_4c_FiltPreco
            .Value       = ""
            .Top         = 10
            .Left        = 295
            .Width       = 162
            .Height      = 23
            .MaxLength   = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible     = .F.
        ENDWITH

        loc_oPg.cnt_4c_FiltroCompos.AddObject("lbl_4c_FiltTipo", "Label")
        WITH loc_oPg.cnt_4c_FiltroCompos.lbl_4c_FiltTipo
            .Caption   = "Tipo :"
            .Top       = 14
            .Left      = 475
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.cnt_4c_FiltroCompos.AddObject("txt_4c_FiltTipo", "TextBox")
        WITH loc_oPg.cnt_4c_FiltroCompos.txt_4c_FiltTipo
            .Value       = ""
            .Top         = 10
            .Left        = 515
            .Width       = 168
            .Height      = 23
            .MaxLength   = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .ForeColor   = RGB(0, 0, 0)
            .SpecialEffect = 1
            .Visible     = .F.
        ENDWITH

        *-- Grid de Composicao (grd_4c_Compos) Top=262+29=291
        loc_oPg.AddObject("grd_4c_Compos", "Grid")
        WITH loc_oPg.grd_4c_Compos
            .Top         = 291
            .Left        = 77
            .Width       = 782
            .Height      = 264
            .ColumnCount = 4
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .ReadOnly    = .T.
            .FontName    = "Courier New"
            .FontSize    = 8
            .Visible     = .F.
            .Column1.Width     = 150
            .Column1.Movable   = .F.
            .Column1.Resizable = .F.
            .Column2.Width     = 250
            .Column2.Movable   = .F.
            .Column2.Resizable = .F.
            .Column3.Width     = 200
            .Column3.Movable   = .F.
            .Column3.Resizable = .F.
            .Column4.Width     = 150
            .Column4.Movable   = .F.
            .Column4.Resizable = .F.
        ENDWITH

        *-- Botoes inserir/excluir composicao
        loc_oPg.AddObject("cmg_4c_BotoesCompos", "CommandGroup")
        WITH loc_oPg.cmg_4c_BotoesCompos
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 355
            .Left        = 865
            .Width       = 43
            .Height      = 89
            .Themes      = .F.
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption    = ""
                .Picture    = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .Top        = -1
                .Left       = -1
                .Height     = 45
                .Width      = 45
                .Themes     = .F.
                .ToolTipText = "Inserir"
                .BackColor  = RGB(255,255,255)
            ENDWITH
            WITH .Buttons(2)
                .Caption    = ""
                .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Top        = 44
                .Left       = -1
                .Height     = 45
                .Width      = 45
                .Themes     = .F.
                .ToolTipText = "Excluir"
                .BackColor  = RGB(255,255,255)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPg.cmg_4c_BotoesCompos, "Click", THIS, "BtnComposClick")

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * BtnDescrsClick - Clique em botoes de descricao
    *==========================================================================
    PROCEDURE BtnDescrsClick()
        MsgAviso("Edi" + CHR(231) + CHR(227) + "o de descri" + CHR(231) + CHR(245) + "es em desenvolvimento.")
    ENDPROC

    *==========================================================================
    * BtnSubGrupoClick - Clique em botoes de sub-grupo
    *==========================================================================
    PROCEDURE BtnSubGrupoClick()
        MsgAviso("Edi" + CHR(231) + CHR(227) + "o de sub-grupos em desenvolvimento.")
    ENDPROC

    *==========================================================================
    * BtnComposClick - Dispatch Inserir/Excluir composicao pelo Value do group
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnComposClick()
        LOCAL loc_oPg9
        loc_oPg9 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9
        IF PEMSTATUS(loc_oPg9, "cmg_4c_BotoesCompos", 5)
            IF loc_oPg9.cmg_4c_BotoesCompos.Value = 1
                THIS.BtnComposInserirClick()
            ELSE
                THIS.BtnComposExcluirClick()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * FiltroComposKeyPress - Filtra composicao ao pressionar Enter
    *==========================================================================
    PROCEDURE FiltroComposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13
            MsgAviso("Filtro de composi" + CHR(231) + CHR(227) + "o em desenvolvimento.")
        ENDIF
    ENDPROC

    *-- =====================================================================
    *-- HANDLERS E LOOKUP METHODS - Pagina 2 (Produtos)
    *-- =====================================================================

    PROCEDURE IdecprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupIdecpros()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupIdecpros()
        LOCAL loc_oPg2, loc_oBusca, loc_cCodigo
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        loc_cCodigo = ""

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Idecpros", 5)
            RETURN
        ENDIF
        IF !loc_oPg2.txt_4c_Idecpros.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdIco", "cursor_4c_BuscaIdecpros", "Codigos", ;
                ALLTRIM(loc_oPg2.txt_4c_Idecpros.Value), ;
                "Identificador C" + CHR(243) + "digo Produto")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIdecpros")
                    SELECT cursor_4c_BuscaIdecpros
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaIdecpros.Codigos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupIdecpros")
        ENDTRY

        IF USED("cursor_4c_BuscaIdecpros")
            USE IN cursor_4c_BuscaIdecpros
        ENDIF
        IF !EMPTY(loc_cCodigo) AND PEMSTATUS(loc_oPg2, "txt_4c_Idecpros", 5)
            loc_oPg2.txt_4c_Idecpros.Value = loc_cCodigo
        ENDIF
    ENDPROC

    PROCEDURE Cgrus2Valid()
        LOCAL loc_oPg2, loc_cCodigo, loc_nResult, loc_cDesc
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Cgrus2", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(UPPER(loc_oPg2.txt_4c_Cgrus2.Value))
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg2, "txt_4c_DescCgrus2", 5)
                loc_oPg2.txt_4c_DescCgrus2.Value = ""
            ENDIF
            RETURN .T.
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaCgrus2")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaCgrus2")
                loc_cDesc = ALLTRIM(cursor_4c_BuscaCgrus2.Descs)
                loc_oPg2.txt_4c_Cgrus2.Value = ALLTRIM(cursor_4c_BuscaCgrus2.Codigos)
                IF PEMSTATUS(loc_oPg2, "txt_4c_DescCgrus2", 5)
                    loc_oPg2.txt_4c_DescCgrus2.Value = loc_cDesc
                ENDIF
            ELSE
                THIS.AbrirLookupCgrus2()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Grande Grupo 2:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.Cgrus2Valid")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_BuscaCgrus2")
            USE IN cursor_4c_BuscaCgrus2
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Cgrus2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCgrus2()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupCgrus2()
        LOCAL loc_oPg2, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg2, "txt_4c_Cgrus2", 5)
            RETURN
        ENDIF
        IF !loc_oPg2.txt_4c_Cgrus2.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaCgrus2", "Codigos", ;
                ALLTRIM(loc_oPg2.txt_4c_Cgrus2.Value), ;
                "Grande Grupo 2")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCgrus2")
                    SELECT cursor_4c_BuscaCgrus2
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCgrus2.Codigos)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaCgrus2.Descs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupCgrus2")
        ENDTRY

        IF USED("cursor_4c_BuscaCgrus2")
            USE IN cursor_4c_BuscaCgrus2
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg2, "txt_4c_Cgrus2", 5)
                loc_oPg2.txt_4c_Cgrus2.Value = loc_cCodigo
            ENDIF
            IF PEMSTATUS(loc_oPg2, "txt_4c_DescCgrus2", 5)
                loc_oPg2.txt_4c_DescCgrus2.Value = loc_cDesc
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescCgrus2(par_cCodigo)
        LOCAL loc_oPg2, loc_nResult
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        IF !PEMSTATUS(loc_oPg2, "txt_4c_DescCgrus2", 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            loc_oPg2.txt_4c_DescCgrus2.Value = ""
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descs FROM SigCdGpr WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpDescCgrus2")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpDescCgrus2")
                loc_oPg2.txt_4c_DescCgrus2.Value = ALLTRIM(cursor_4c_TmpDescCgrus2.Descs)
            ELSE
                loc_oPg2.txt_4c_DescCgrus2.Value = ""
            ENDIF
        CATCH TO loc_oErro
            loc_oPg2.txt_4c_DescCgrus2.Value = ""
        ENDTRY
        IF USED("cursor_4c_TmpDescCgrus2")
            USE IN cursor_4c_TmpDescCgrus2
        ENDIF
    ENDPROC

    *-- Moeda Markup handlers
    PROCEDURE MoemrkapsValid()
        LOCAL loc_oPg2, loc_cCodigo
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        IF !PEMSTATUS(loc_oPg2, "txt_4c_Moemrkaps", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(UPPER(loc_oPg2.txt_4c_Moemrkaps.Value))
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg2, "txt_4c_DescMoemrkaps", 5)
                loc_oPg2.txt_4c_DescMoemrkaps.Value = ""
            ENDIF
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarMoedaEPreencher(loc_cCodigo, loc_oPg2, ;
            "txt_4c_Moemrkaps", "txt_4c_DescMoemrkaps", "cursor_4c_BuscaMoeMrkaps")
    ENDPROC

    PROCEDURE MoemrkapsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda("txt_4c_Moemrkaps", "txt_4c_DescMoemrkaps", 2)
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescMoemrkaps(par_cCodigo)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        THIS.CarregarDescMoeda(par_cCodigo, loc_oPg2, "txt_4c_DescMoemrkaps")
    ENDPROC

    *-- Padmoecs handlers
    PROCEDURE PadmoecsPg2Valid()
        LOCAL loc_oPg2, loc_cCodigo
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Padmoecs", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg2.txt_4c_Padmoecs.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarMoedaEPreencher(loc_cCodigo, loc_oPg2, ;
            "txt_4c_Padmoecs", "", "cursor_4c_BscPadMoecs")
    ENDPROC

    PROCEDURE PadmoecsPg2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda("txt_4c_Padmoecs", "", 2)
        ENDIF
    ENDPROC

    PROCEDURE PadmoepcsValid()
        LOCAL loc_oPg2, loc_cCodigo
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Padmoepcs", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg2.txt_4c_Padmoepcs.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarMoedaEPreencher(loc_cCodigo, loc_oPg2, ;
            "txt_4c_Padmoepcs", "", "cursor_4c_BscPadMoePcs")
    ENDPROC

    PROCEDURE PadmoepcsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda("txt_4c_Padmoepcs", "", 2)
        ENDIF
    ENDPROC

    PROCEDURE PadmoedasValid()
        LOCAL loc_oPg2, loc_cCodigo
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Padmoedas", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg2.txt_4c_Padmoedas.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarMoedaEPreencher(loc_cCodigo, loc_oPg2, ;
            "txt_4c_Padmoedas", "", "cursor_4c_BscPadMoeDas")
    ENDPROC

    PROCEDURE PadmoedasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda("txt_4c_Padmoedas", "", 2)
        ENDIF
    ENDPROC

    PROCEDURE PadmoevsValid()
        LOCAL loc_oPg2, loc_cCodigo
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Padmoevs", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg2.txt_4c_Padmoevs.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarMoedaEPreencher(loc_cCodigo, loc_oPg2, ;
            "txt_4c_Padmoevs", "", "cursor_4c_BscPadMoeVs")
    ENDPROC

    PROCEDURE PadmoevsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda("txt_4c_Padmoevs", "", 2)
        ENDIF
    ENDPROC

    PROCEDURE PadmoetcsValid()
        LOCAL loc_oPg2, loc_cCodigo
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Padmoetcs", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg2.txt_4c_Padmoetcs.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarMoedaEPreencher(loc_cCodigo, loc_oPg2, ;
            "txt_4c_Padmoetcs", "", "cursor_4c_BscPadMoeTcs")
    ENDPROC

    PROCEDURE PadmoetcsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda("txt_4c_Padmoetcs", "", 2)
        ENDIF
    ENDPROC

    *-- =====================================================================
    *-- HANDLERS E LOOKUP METHODS - Pagina 4 (Estoque/Fiscal)
    *-- =====================================================================

    PROCEDURE ClfiscalsValid()
        LOCAL loc_oPg4, loc_cCodigo, loc_nResult, loc_cDesc
        loc_oPg4    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg4, "txt_4c_Clfiscals", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(UPPER(loc_oPg4.txt_4c_Clfiscals.Value))
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg4, "txt_4c_DescClfiscal", 5)
                loc_oPg4.txt_4c_DescClfiscal.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaClfiscal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaClfiscal")
                loc_cDesc = ALLTRIM(cursor_4c_BuscaClfiscal.Descricaos)
                loc_oPg4.txt_4c_Clfiscals.Value = ALLTRIM(cursor_4c_BuscaClfiscal.Codigos)
                IF PEMSTATUS(loc_oPg4, "txt_4c_DescClfiscal", 5)
                    loc_oPg4.txt_4c_DescClfiscal.Value = loc_cDesc
                ENDIF
            ELSE
                THIS.AbrirLookupClfiscal()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Classif. Fiscal:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.ClfiscalsValid")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_BuscaClfiscal")
            USE IN cursor_4c_BuscaClfiscal
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE ClfiscalsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupClfiscal()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupClfiscal()
        LOCAL loc_oPg4, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_oPg4    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg4, "txt_4c_Clfiscals", 5)
            RETURN
        ENDIF
        IF !loc_oPg4.txt_4c_Clfiscals.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdClf", "cursor_4c_BuscaClfiscal", "Codigos", ;
                ALLTRIM(loc_oPg4.txt_4c_Clfiscals.Value), ;
                "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClfiscal")
                    SELECT cursor_4c_BuscaClfiscal
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaClfiscal.Codigos)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaClfiscal.Descricaos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupClfiscal")
        ENDTRY

        IF USED("cursor_4c_BuscaClfiscal")
            USE IN cursor_4c_BuscaClfiscal
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg4, "txt_4c_Clfiscals", 5)
                loc_oPg4.txt_4c_Clfiscals.Value = loc_cCodigo
            ENDIF
            IF PEMSTATUS(loc_oPg4, "txt_4c_DescClfiscal", 5)
                loc_oPg4.txt_4c_DescClfiscal.Value = loc_cDesc
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescClfiscal(par_cCodigo)
        LOCAL loc_oPg4, loc_nResult
        loc_oPg4 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        IF !PEMSTATUS(loc_oPg4, "txt_4c_DescClfiscal", 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            loc_oPg4.txt_4c_DescClfiscal.Value = ""
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpClfiscal")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpClfiscal")
                loc_oPg4.txt_4c_DescClfiscal.Value = ALLTRIM(cursor_4c_TmpClfiscal.Descricaos)
            ELSE
                loc_oPg4.txt_4c_DescClfiscal.Value = ""
            ENDIF
        CATCH TO loc_oErro
            loc_oPg4.txt_4c_DescClfiscal.Value = ""
        ENDTRY
        IF USED("cursor_4c_TmpClfiscal")
            USE IN cursor_4c_TmpClfiscal
        ENDIF
    ENDPROC

    PROCEDURE OrigmercsValid()
        LOCAL loc_oPg4, loc_cCodigo, loc_nResult, loc_cDesc
        loc_oPg4    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg4, "txt_4c_Origmercs", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(UPPER(loc_oPg4.txt_4c_Origmercs.Value))
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg4, "txt_4c_DescOrigmerc", 5)
                loc_oPg4.txt_4c_DescOrigmerc.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaOrigmerc")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaOrigmerc")
                loc_cDesc = ALLTRIM(cursor_4c_BuscaOrigmerc.Descricaos)
                loc_oPg4.txt_4c_Origmercs.Value = ALLTRIM(cursor_4c_BuscaOrigmerc.Codigos)
                IF PEMSTATUS(loc_oPg4, "txt_4c_DescOrigmerc", 5)
                    loc_oPg4.txt_4c_DescOrigmerc.Value = loc_cDesc
                ENDIF
            ELSE
                THIS.AbrirLookupOrigmerc()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Origem Mercadoria:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.OrigmercsValid")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_BuscaOrigmerc")
            USE IN cursor_4c_BuscaOrigmerc
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE OrigmercsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupOrigmerc()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupOrigmerc()
        LOCAL loc_oPg4, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_oPg4    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg4, "txt_4c_Origmercs", 5)
            RETURN
        ENDIF
        IF !loc_oPg4.txt_4c_Origmercs.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOrg", "cursor_4c_BuscaOrigmerc", "Codigos", ;
                ALLTRIM(loc_oPg4.txt_4c_Origmercs.Value), ;
                "Origem da Mercadoria")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrigmerc")
                    SELECT cursor_4c_BuscaOrigmerc
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaOrigmerc.Codigos)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaOrigmerc.Descricaos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupOrigmerc")
        ENDTRY

        IF USED("cursor_4c_BuscaOrigmerc")
            USE IN cursor_4c_BuscaOrigmerc
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg4, "txt_4c_Origmercs", 5)
                loc_oPg4.txt_4c_Origmercs.Value = loc_cCodigo
            ENDIF
            IF PEMSTATUS(loc_oPg4, "txt_4c_DescOrigmerc", 5)
                loc_oPg4.txt_4c_DescOrigmerc.Value = loc_cDesc
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescOrigmerc(par_cCodigo)
        LOCAL loc_oPg4, loc_nResult
        loc_oPg4 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        IF !PEMSTATUS(loc_oPg4, "txt_4c_DescOrigmerc", 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            loc_oPg4.txt_4c_DescOrigmerc.Value = ""
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpOrigmerc")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpOrigmerc")
                loc_oPg4.txt_4c_DescOrigmerc.Value = ALLTRIM(cursor_4c_TmpOrigmerc.Descricaos)
            ELSE
                loc_oPg4.txt_4c_DescOrigmerc.Value = ""
            ENDIF
        CATCH TO loc_oErro
            loc_oPg4.txt_4c_DescOrigmerc.Value = ""
        ENDTRY
        IF USED("cursor_4c_TmpOrigmerc")
            USE IN cursor_4c_TmpOrigmerc
        ENDIF
    ENDPROC

    PROCEDURE SittricmsValid()
        LOCAL loc_oPg4, loc_cCodigo, loc_nResult, loc_cDesc
        loc_oPg4    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg4, "txt_4c_Sittricms", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(UPPER(loc_oPg4.txt_4c_Sittricms.Value))
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg4, "txt_4c_DescSittricm", 5)
                loc_oPg4.txt_4c_DescSittricm.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaSittricm")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaSittricm")
                loc_cDesc = ALLTRIM(cursor_4c_BuscaSittricm.Descricaos)
                loc_oPg4.txt_4c_Sittricms.Value = ALLTRIM(cursor_4c_BuscaSittricm.Codigos)
                IF PEMSTATUS(loc_oPg4, "txt_4c_DescSittricm", 5)
                    loc_oPg4.txt_4c_DescSittricm.Value = loc_cDesc
                ENDIF
            ELSE
                THIS.AbrirLookupSittricm()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Sit. Trib. ICMS:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.SittricmsValid")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_BuscaSittricm")
            USE IN cursor_4c_BuscaSittricm
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE SittricmsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupSittricm()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupSittricm()
        LOCAL loc_oPg4, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_oPg4    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg4, "txt_4c_Sittricms", 5)
            RETURN
        ENDIF
        IF !loc_oPg4.txt_4c_Sittricms.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdIcm", "cursor_4c_BuscaSittricm", "Codigos", ;
                ALLTRIM(loc_oPg4.txt_4c_Sittricms.Value), ;
                "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSittricm")
                    SELECT cursor_4c_BuscaSittricm
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaSittricm.Codigos)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaSittricm.Descricaos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupSittricm")
        ENDTRY

        IF USED("cursor_4c_BuscaSittricm")
            USE IN cursor_4c_BuscaSittricm
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg4, "txt_4c_Sittricms", 5)
                loc_oPg4.txt_4c_Sittricms.Value = loc_cCodigo
            ENDIF
            IF PEMSTATUS(loc_oPg4, "txt_4c_DescSittricm", 5)
                loc_oPg4.txt_4c_DescSittricm.Value = loc_cDesc
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescSittricm(par_cCodigo)
        LOCAL loc_oPg4, loc_nResult
        loc_oPg4 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        IF !PEMSTATUS(loc_oPg4, "txt_4c_DescSittricm", 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            loc_oPg4.txt_4c_DescSittricm.Value = ""
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpSittricm")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpSittricm")
                loc_oPg4.txt_4c_DescSittricm.Value = ALLTRIM(cursor_4c_TmpSittricm.Descricaos)
            ELSE
                loc_oPg4.txt_4c_DescSittricm.Value = ""
            ENDIF
        CATCH TO loc_oErro
            loc_oPg4.txt_4c_DescSittricm.Value = ""
        ENDTRY
        IF USED("cursor_4c_TmpSittricm")
            USE IN cursor_4c_TmpSittricm
        ENDIF
    ENDPROC

    PROCEDURE MoecustsValid()
        LOCAL loc_oPg4, loc_cCodigo
        loc_oPg4    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg4, "txt_4c_Moecusts", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg4.txt_4c_Moecusts.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg4, "txt_4c_DescMoecust", 5)
                loc_oPg4.txt_4c_DescMoecust.Value = ""
            ENDIF
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarMoedaEPreencher(loc_cCodigo, loc_oPg4, ;
            "txt_4c_Moecusts", "txt_4c_DescMoecust", "cursor_4c_BuscaMoecusts")
    ENDPROC

    PROCEDURE MoecustsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda("txt_4c_Moecusts", "txt_4c_DescMoecust", 4)
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescMoecust(par_cCodigo)
        LOCAL loc_oPg4
        loc_oPg4 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        THIS.CarregarDescMoeda(par_cCodigo, loc_oPg4, "txt_4c_DescMoecust")
    ENDPROC

    PROCEDURE TptribsValid()
        LOCAL loc_oPg4, loc_cCodigo, loc_nResult, loc_cDesc
        loc_oPg4    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg4, "txt_4c_Tptribs", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(UPPER(loc_oPg4.txt_4c_Tptribs.Value))
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg4, "txt_4c_DescTptrib", 5)
                loc_oPg4.txt_4c_DescTptrib.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Tipos, Descs FROM SigPrTri WHERE Tipos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaTptrib")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaTptrib")
                loc_cDesc = ALLTRIM(cursor_4c_BuscaTptrib.Descs)
                loc_oPg4.txt_4c_Tptribs.Value = ALLTRIM(cursor_4c_BuscaTptrib.Tipos)
                IF PEMSTATUS(loc_oPg4, "txt_4c_DescTptrib", 5)
                    loc_oPg4.txt_4c_DescTptrib.Value = loc_cDesc
                ENDIF
            ELSE
                THIS.AbrirLookupTptrib()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Tipo Trib. ICMS:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.TptribsValid")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_BuscaTptrib")
            USE IN cursor_4c_BuscaTptrib
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE TptribsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupTptrib()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupTptrib()
        LOCAL loc_oPg4, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_oPg4    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg4, "txt_4c_Tptribs", 5)
            RETURN
        ENDIF
        IF !loc_oPg4.txt_4c_Tptribs.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrTri", "cursor_4c_BuscaTptrib", "Tipos", ;
                ALLTRIM(loc_oPg4.txt_4c_Tptribs.Value), ;
                "Tipo Tributa" + CHR(231) + CHR(227) + "o ICMS")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Tipos", "", "Tipo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTptrib")
                    SELECT cursor_4c_BuscaTptrib
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaTptrib.Tipos)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaTptrib.Descs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupTptrib")
        ENDTRY

        IF USED("cursor_4c_BuscaTptrib")
            USE IN cursor_4c_BuscaTptrib
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg4, "txt_4c_Tptribs", 5)
                loc_oPg4.txt_4c_Tptribs.Value = loc_cCodigo
            ENDIF
            IF PEMSTATUS(loc_oPg4, "txt_4c_DescTptrib", 5)
                loc_oPg4.txt_4c_DescTptrib.Value = loc_cDesc
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescTptrib(par_cCodigo)
        LOCAL loc_oPg4, loc_nResult
        loc_oPg4 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        IF !PEMSTATUS(loc_oPg4, "txt_4c_DescTptrib", 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            loc_oPg4.txt_4c_DescTptrib.Value = ""
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descs FROM SigPrTri WHERE Tipos = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpTptrib")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpTptrib")
                loc_oPg4.txt_4c_DescTptrib.Value = ALLTRIM(cursor_4c_TmpTptrib.Descs)
            ELSE
                loc_oPg4.txt_4c_DescTptrib.Value = ""
            ENDIF
        CATCH TO loc_oErro
            loc_oPg4.txt_4c_DescTptrib.Value = ""
        ENDTRY
        IF USED("cursor_4c_TmpTptrib")
            USE IN cursor_4c_TmpTptrib
        ENDIF
    ENDPROC

    *-- =====================================================================
    *-- HANDLERS E LOOKUP METHODS - Pagina 5 (Industria)
    *-- =====================================================================

    PROCEDURE GrufinsValid()
        LOCAL loc_oPg5, loc_cCodigo, loc_nResult
        loc_oPg5    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg5, "txt_4c_Grufins", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg5.txt_4c_Grufins.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg5, "txt_4c_DescGrufins", 5)
                loc_oPg5.txt_4c_DescGrufins.Value = ""
            ENDIF
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarGrupoContab(loc_cCodigo, loc_oPg5, ;
            "txt_4c_Grufins", "txt_4c_DescGrufins", "cursor_4c_BscGrufins")
    ENDPROC

    PROCEDURE GrufinsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoContab("txt_4c_Grufins", "txt_4c_DescGrufins", 5)
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescGrufins(par_cCodigo)
        LOCAL loc_oPg5
        loc_oPg5 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
        THIS.CarregarDescGruContab(par_cCodigo, loc_oPg5, "txt_4c_DescGrufins")
    ENDPROC

    PROCEDURE CmoedsValid()
        LOCAL loc_oPg5, loc_cCodigo
        loc_oPg5    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg5, "txt_4c_Cmoeds", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg5.txt_4c_Cmoeds.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg5, "txt_4c_DescCmoeds", 5)
                loc_oPg5.txt_4c_DescCmoeds.Value = ""
            ENDIF
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarMoedaEPreencher(loc_cCodigo, loc_oPg5, ;
            "txt_4c_Cmoeds", "txt_4c_DescCmoeds", "cursor_4c_BscCmoeds")
    ENDPROC

    PROCEDURE CmoedsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda("txt_4c_Cmoeds", "txt_4c_DescCmoeds", 5)
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescCmoeds(par_cCodigo)
        LOCAL loc_oPg5
        loc_oPg5 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
        THIS.CarregarDescMoeda(par_cCodigo, loc_oPg5, "txt_4c_DescCmoeds")
    ENDPROC

    PROCEDURE GrupobxpsValid()
        LOCAL loc_oPg5, loc_cCodigo
        loc_oPg5    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg5, "txt_4c_Grupobxps", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg5.txt_4c_Grupobxps.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarGrupoContab(loc_cCodigo, loc_oPg5, ;
            "txt_4c_Grupobxps", "", "cursor_4c_BscGrupobxps")
    ENDPROC

    PROCEDURE GrupobxpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoContab("txt_4c_Grupobxps", "", 5)
        ENDIF
    ENDPROC

    PROCEDURE ContabxpsValid()
        LOCAL loc_oPg5, loc_cCodigo
        loc_oPg5    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page5
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg5, "txt_4c_Contabxps", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg5.txt_4c_Contabxps.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarContaContab(loc_cCodigo, loc_oPg5, ;
            "txt_4c_Contabxps", "", "cursor_4c_BscContabxps")
    ENDPROC

    PROCEDURE ContabxpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaContab("txt_4c_Contabxps", "", 5)
        ENDIF
    ENDPROC

    *-- =====================================================================
    *-- HANDLERS E LOOKUP METHODS - Pagina 6 (Configuracao)
    *-- =====================================================================

    PROCEDURE GrucmvsValid()
        LOCAL loc_oPg6, loc_cCodigo
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg6, "txt_4c_Grucmvs", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg6.txt_4c_Grucmvs.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescGrucmvs", 5)
                loc_oPg6.txt_4c_DescGrucmvs.Value = ""
            ENDIF
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarGrupoContab(loc_cCodigo, loc_oPg6, ;
            "txt_4c_Grucmvs", "txt_4c_DescGrucmvs", "cursor_4c_BscGrucmvs")
    ENDPROC

    PROCEDURE GrucmvsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoContab("txt_4c_Grucmvs", "txt_4c_DescGrucmvs", 6)
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescGrucmvs(par_cCodigo)
        LOCAL loc_oPg6
        loc_oPg6 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        THIS.CarregarDescGruContab(par_cCodigo, loc_oPg6, "txt_4c_DescGrucmvs")
    ENDPROC

    PROCEDURE ConcmvsValid()
        LOCAL loc_oPg6, loc_cCodigo
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg6, "txt_4c_Concmvs", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg6.txt_4c_Concmvs.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescConcmvs", 5)
                loc_oPg6.txt_4c_DescConcmvs.Value = ""
            ENDIF
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarContaContab(loc_cCodigo, loc_oPg6, ;
            "txt_4c_Concmvs", "txt_4c_DescConcmvs", "cursor_4c_BscConcmvs")
    ENDPROC

    PROCEDURE ConcmvsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaContab("txt_4c_Concmvs", "txt_4c_DescConcmvs", 6)
        ENDIF
    ENDPROC

    PROCEDURE GruestpsValid()
        LOCAL loc_oPg6, loc_cCodigo
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg6, "txt_4c_Gruestps", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg6.txt_4c_Gruestps.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarGrupoContab(loc_cCodigo, loc_oPg6, ;
            "txt_4c_Gruestps", "", "cursor_4c_BscGruestps")
    ENDPROC

    PROCEDURE GruestpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoContab("txt_4c_Gruestps", "", 6)
        ENDIF
    ENDPROC

    PROCEDURE ConestpsValid()
        LOCAL loc_oPg6, loc_cCodigo
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg6, "txt_4c_Conestps", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg6.txt_4c_Conestps.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF
        RETURN THIS.ValidarContaContab(loc_cCodigo, loc_oPg6, ;
            "txt_4c_Conestps", "", "cursor_4c_BscConestps")
    ENDPROC

    PROCEDURE ConestpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaContab("txt_4c_Conestps", "", 6)
        ENDIF
    ENDPROC

    PROCEDURE PadlinhaValid()
        LOCAL loc_oPg6, loc_cCodigo, loc_nResult, loc_cDesc
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg6, "txt_4c_Padlinha", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(UPPER(loc_oPg6.txt_4c_Padlinha.Value))
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadlinha", 5)
                loc_oPg6.txt_4c_DescPadlinha.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Linhas, Descs FROM SigCdLin WHERE Linhas = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaLinha")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaLinha")
                loc_cDesc = ALLTRIM(cursor_4c_BuscaLinha.Descs)
                loc_oPg6.txt_4c_Padlinha.Value = ALLTRIM(cursor_4c_BuscaLinha.Linhas)
                IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadlinha", 5)
                    loc_oPg6.txt_4c_DescPadlinha.Value = loc_cDesc
                ENDIF
            ELSE
                THIS.AbrirLookupPadlinha()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Linha:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.PadlinhaValid")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_BuscaLinha")
            USE IN cursor_4c_BuscaLinha
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE PadlinhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupPadlinha()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupPadlinha()
        LOCAL loc_oPg6, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg6, "txt_4c_Padlinha", 5)
            RETURN
        ENDIF
        IF !loc_oPg6.txt_4c_Padlinha.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLin", "cursor_4c_BuscaLinha", "Linhas", ;
                ALLTRIM(loc_oPg6.txt_4c_Padlinha.Value), ;
                "Linha Padr" + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLinha")
                    SELECT cursor_4c_BuscaLinha
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaLinha.Linhas)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaLinha.Descs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupPadlinha")
        ENDTRY

        IF USED("cursor_4c_BuscaLinha")
            USE IN cursor_4c_BuscaLinha
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_Padlinha", 5)
                loc_oPg6.txt_4c_Padlinha.Value = loc_cCodigo
            ENDIF
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadlinha", 5)
                loc_oPg6.txt_4c_DescPadlinha.Value = loc_cDesc
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescPadlinha(par_cCodigo)
        LOCAL loc_oPg6, loc_nResult
        loc_oPg6 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        IF !PEMSTATUS(loc_oPg6, "txt_4c_DescPadlinha", 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            loc_oPg6.txt_4c_DescPadlinha.Value = ""
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descs FROM SigCdLin WHERE Linhas = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpLinha")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpLinha")
                loc_oPg6.txt_4c_DescPadlinha.Value = ALLTRIM(cursor_4c_TmpLinha.Descs)
            ELSE
                loc_oPg6.txt_4c_DescPadlinha.Value = ""
            ENDIF
        CATCH TO loc_oErro
            loc_oPg6.txt_4c_DescPadlinha.Value = ""
        ENDTRY
        IF USED("cursor_4c_TmpLinha")
            USE IN cursor_4c_TmpLinha
        ENDIF
    ENDPROC

    PROCEDURE PadcolecValid()
        LOCAL loc_oPg6, loc_cCodigo, loc_nResult, loc_cDesc
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg6, "txt_4c_Padcolec", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(UPPER(loc_oPg6.txt_4c_Padcolec.Value))
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadcolec", 5)
                loc_oPg6.txt_4c_DescPadcolec.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaColec")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaColec")
                loc_cDesc = ALLTRIM(cursor_4c_BuscaColec.Descs)
                loc_oPg6.txt_4c_Padcolec.Value = ALLTRIM(cursor_4c_BuscaColec.Colecoes)
                IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadcolec", 5)
                    loc_oPg6.txt_4c_DescPadcolec.Value = loc_cDesc
                ENDIF
            ELSE
                THIS.AbrirLookupPadcolec()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message, "FormGpd.PadcolecValid")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_BuscaColec")
            USE IN cursor_4c_BuscaColec
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE PadcolecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupPadcolec()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupPadcolec()
        LOCAL loc_oPg6, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg6, "txt_4c_Padcolec", 5)
            RETURN
        ENDIF
        IF !loc_oPg6.txt_4c_Padcolec.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "cursor_4c_BuscaColec", "Colecoes", ;
                ALLTRIM(loc_oPg6.txt_4c_Padcolec.Value), ;
                "Cole" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaColec")
                    SELECT cursor_4c_BuscaColec
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaColec.Colecoes)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaColec.Descs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupPadcolec")
        ENDTRY

        IF USED("cursor_4c_BuscaColec")
            USE IN cursor_4c_BuscaColec
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_Padcolec", 5)
                loc_oPg6.txt_4c_Padcolec.Value = loc_cCodigo
            ENDIF
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadcolec", 5)
                loc_oPg6.txt_4c_DescPadcolec.Value = loc_cDesc
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescPadcolec(par_cCodigo)
        LOCAL loc_oPg6, loc_nResult
        loc_oPg6 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        IF !PEMSTATUS(loc_oPg6, "txt_4c_DescPadcolec", 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            loc_oPg6.txt_4c_DescPadcolec.Value = ""
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descs FROM SigCdCol WHERE Colecoes = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpColec")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpColec")
                loc_oPg6.txt_4c_DescPadcolec.Value = ALLTRIM(cursor_4c_TmpColec.Descs)
            ELSE
                loc_oPg6.txt_4c_DescPadcolec.Value = ""
            ENDIF
        CATCH TO loc_oErro
            loc_oPg6.txt_4c_DescPadcolec.Value = ""
        ENDTRY
        IF USED("cursor_4c_TmpColec")
            USE IN cursor_4c_TmpColec
        ENDIF
    ENDPROC

    PROCEDURE PadcclasValid()
        LOCAL loc_oPg6, loc_cCodigo, loc_nResult
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPg6, "txt_4c_Padcclas", 5)
            loc_cCodigo = ALLTRIM(UPPER(loc_oPg6.txt_4c_Padcclas.Value))
        ENDIF
        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 Cods FROM SigCdCls WHERE Cods = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BscPadcclas")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BscPadcclas")
                loc_oPg6.txt_4c_Padcclas.Value = ALLTRIM(cursor_4c_BscPadcclas.Cods)
            ELSE
                THIS.AbrirLookupPadcclas()
                IF USED("cursor_4c_BscPadcclas")
                    USE IN cursor_4c_BscPadcclas
                ENDIF
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Classif.:" + CHR(13) + loc_oErro.Message, "FormGpd.PadcclasValid")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_BscPadcclas")
            USE IN cursor_4c_BscPadcclas
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE PadcclasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupPadcclas()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupPadcclas()
        LOCAL loc_oPg6, loc_oBusca, loc_cCodigo
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""

        IF !PEMSTATUS(loc_oPg6, "txt_4c_Padcclas", 5)
            RETURN
        ENDIF
        IF !loc_oPg6.txt_4c_Padcclas.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCls", "cursor_4c_BuscaPadcclas", "Cods", ;
                ALLTRIM(loc_oPg6.txt_4c_Padcclas.Value), ;
                "Classifica" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPadcclas")
                    SELECT cursor_4c_BuscaPadcclas
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaPadcclas.Cods)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupPadcclas")
        ENDTRY

        IF USED("cursor_4c_BuscaPadcclas")
            USE IN cursor_4c_BuscaPadcclas
        ENDIF
        IF !EMPTY(loc_cCodigo) AND PEMSTATUS(loc_oPg6, "txt_4c_Padcclas", 5)
            loc_oPg6.txt_4c_Padcclas.Value = loc_cCodigo
        ENDIF
    ENDPROC

    PROCEDURE PadfinpsValid()
        LOCAL loc_oPg6, loc_cCodigo, loc_nResult, loc_cDesc
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg6, "txt_4c_Padfinps", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(UPPER(loc_oPg6.txt_4c_Padfinps.Value))
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadfinps", 5)
                loc_oPg6.txt_4c_DescPadfinps.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Cods, Descs FROM SigCdFip WHERE Cods = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaFinp")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaFinp")
                loc_cDesc = ALLTRIM(cursor_4c_BuscaFinp.Descs)
                loc_oPg6.txt_4c_Padfinps.Value = ALLTRIM(cursor_4c_BuscaFinp.Cods)
                IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadfinps", 5)
                    loc_oPg6.txt_4c_DescPadfinps.Value = loc_cDesc
                ENDIF
            ELSE
                THIS.AbrirLookupPadfinps()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Finalidade:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.PadfinpsValid")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_BuscaFinp")
            USE IN cursor_4c_BuscaFinp
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE PadfinpsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupPadfinps()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupPadfinps()
        LOCAL loc_oPg6, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg6, "txt_4c_Padfinps", 5)
            RETURN
        ENDIF
        IF !loc_oPg6.txt_4c_Padfinps.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdFip", "cursor_4c_BuscaFinp", "Cods", ;
                ALLTRIM(loc_oPg6.txt_4c_Padfinps.Value), ;
                "Finalidade Padr" + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinp")
                    SELECT cursor_4c_BuscaFinp
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaFinp.Cods)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaFinp.Descs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupPadfinps")
        ENDTRY

        IF USED("cursor_4c_BuscaFinp")
            USE IN cursor_4c_BuscaFinp
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_Padfinps", 5)
                loc_oPg6.txt_4c_Padfinps.Value = loc_cCodigo
            ENDIF
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadfinps", 5)
                loc_oPg6.txt_4c_DescPadfinps.Value = loc_cDesc
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescPadfinps(par_cCodigo)
        LOCAL loc_oPg6, loc_nResult
        loc_oPg6 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        IF !PEMSTATUS(loc_oPg6, "txt_4c_DescPadfinps", 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            loc_oPg6.txt_4c_DescPadfinps.Value = ""
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descs FROM SigCdFip WHERE Cods = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpFinp")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpFinp")
                loc_oPg6.txt_4c_DescPadfinps.Value = ALLTRIM(cursor_4c_TmpFinp.Descs)
            ELSE
                loc_oPg6.txt_4c_DescPadfinps.Value = ""
            ENDIF
        CATCH TO loc_oErro
            loc_oPg6.txt_4c_DescPadfinps.Value = ""
        ENDTRY
        IF USED("cursor_4c_TmpFinp")
            USE IN cursor_4c_TmpFinp
        ENDIF
    ENDPROC

    PROCEDURE PadfaseValid()
        LOCAL loc_oPg6, loc_cCodigo, loc_nResult, loc_cDesc
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg6, "txt_4c_Padfase", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(UPPER(loc_oPg6.txt_4c_Padfase.Value))
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadfase", 5)
                loc_oPg6.txt_4c_DescPadfase.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, Ordems FROM SigCdLnf WHERE grupos = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaFase")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaFase")
                loc_cDesc = ALLTRIM(cursor_4c_BuscaFase.Ordems)
                loc_oPg6.txt_4c_Padfase.Value = ALLTRIM(cursor_4c_BuscaFase.grupos)
                IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadfase", 5)
                    loc_oPg6.txt_4c_DescPadfase.Value = loc_cDesc
                ENDIF
            ELSE
                THIS.AbrirLookupPadfase()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Fase:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.PadfaseValid")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_BuscaFase")
            USE IN cursor_4c_BuscaFase
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE PadfaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupPadfase()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupPadfase()
        LOCAL loc_oPg6, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg6, "txt_4c_Padfase", 5)
            RETURN
        ENDIF
        IF !loc_oPg6.txt_4c_Padfase.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLnf", "cursor_4c_BuscaFase", "grupos", ;
                ALLTRIM(loc_oPg6.txt_4c_Padfase.Value), ;
                "Fase Padr" + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("grupos", "", "Fase")
                    loc_oBusca.mAddColuna("Ordems", "", "Ordem")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFase")
                    SELECT cursor_4c_BuscaFase
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaFase.grupos)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaFase.Ordems)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupPadfase")
        ENDTRY

        IF USED("cursor_4c_BuscaFase")
            USE IN cursor_4c_BuscaFase
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_Padfase", 5)
                loc_oPg6.txt_4c_Padfase.Value = loc_cCodigo
            ENDIF
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescPadfase", 5)
                loc_oPg6.txt_4c_DescPadfase.Value = loc_cDesc
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescPadfase(par_cCodigo)
        LOCAL loc_oPg6, loc_nResult
        loc_oPg6 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        IF !PEMSTATUS(loc_oPg6, "txt_4c_DescPadfase", 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            loc_oPg6.txt_4c_DescPadfase.Value = ""
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Ordems FROM SigCdLnf WHERE grupos = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpFase")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpFase")
                loc_oPg6.txt_4c_DescPadfase.Value = ALLTRIM(cursor_4c_TmpFase.Ordems)
            ELSE
                loc_oPg6.txt_4c_DescPadfase.Value = ""
            ENDIF
        CATCH TO loc_oErro
            loc_oPg6.txt_4c_DescPadfase.Value = ""
        ENDTRY
        IF USED("cursor_4c_TmpFase")
            USE IN cursor_4c_TmpFase
        ENDIF
    ENDPROC

    PROCEDURE CunipsValid()
        LOCAL loc_oPg6, loc_cCodigo, loc_nResult, loc_cDesc
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg6, "txt_4c_Cunips", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(UPPER(loc_oPg6.txt_4c_Cunips.Value))
        IF EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescCunips", 5)
                loc_oPg6.txt_4c_DescCunips.Value = ""
            ENDIF
            RETURN .T.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CUnis, DUnis FROM SigCdUni WHERE CUnis = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_BuscaUnidade")
            IF loc_nResult > 0 AND !EOF("cursor_4c_BuscaUnidade")
                loc_cDesc = ALLTRIM(cursor_4c_BuscaUnidade.DUnis)
                loc_oPg6.txt_4c_Cunips.Value = ALLTRIM(cursor_4c_BuscaUnidade.CUnis)
                IF PEMSTATUS(loc_oPg6, "txt_4c_DescCunips", 5)
                    loc_oPg6.txt_4c_DescCunips.Value = loc_cDesc
                ENDIF
            ELSE
                THIS.AbrirLookupCunips()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Unidade:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.CunipsValid")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_BuscaUnidade")
            USE IN cursor_4c_BuscaUnidade
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE CunipsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCunips()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupCunips()
        LOCAL loc_oPg6, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_oPg6    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg6, "txt_4c_Cunips", 5)
            RETURN
        ENDIF
        IF !loc_oPg6.txt_4c_Cunips.Enabled
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUni", "cursor_4c_BuscaUnidade", "CUnis", ;
                ALLTRIM(loc_oPg6.txt_4c_Cunips.Value), ;
                "Unidade 1")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUnidade")
                    SELECT cursor_4c_BuscaUnidade
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaUnidade.CUnis)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaUnidade.DUnis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca:" + CHR(13) + loc_oErro.Message, "FormGpd.AbrirLookupCunips")
        ENDTRY

        IF USED("cursor_4c_BuscaUnidade")
            USE IN cursor_4c_BuscaUnidade
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF PEMSTATUS(loc_oPg6, "txt_4c_Cunips", 5)
                loc_oPg6.txt_4c_Cunips.Value = loc_cCodigo
            ENDIF
            IF PEMSTATUS(loc_oPg6, "txt_4c_DescCunips", 5)
                loc_oPg6.txt_4c_DescCunips.Value = loc_cDesc
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE CarregarDescCunips(par_cCodigo)
        LOCAL loc_oPg6, loc_nResult
        loc_oPg6 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        IF !PEMSTATUS(loc_oPg6, "txt_4c_DescCunips", 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            loc_oPg6.txt_4c_DescCunips.Value = ""
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT DUnis FROM SigCdUni WHERE CUnis = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpUnidade")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpUnidade")
                loc_oPg6.txt_4c_DescCunips.Value = ALLTRIM(cursor_4c_TmpUnidade.DUnis)
            ELSE
                loc_oPg6.txt_4c_DescCunips.Value = ""
            ENDIF
        CATCH TO loc_oErro
            loc_oPg6.txt_4c_DescCunips.Value = ""
        ENDTRY
        IF USED("cursor_4c_TmpUnidade")
            USE IN cursor_4c_TmpUnidade
        ENDIF
    ENDPROC

    *-- =====================================================================
    *-- HANDLERS pgConfig: Unidade2, BtnOptFin
    *-- =====================================================================

    PROCEDURE Unidade2Valid()
        LOCAL loc_oPg6, loc_cCodigo, loc_nResult
        loc_oPg6 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        IF !PEMSTATUS(loc_oPg6, "txt_4c_Unidade2", 5)
            RETURN .T.
        ENDIF
        loc_cCodigo = ALLTRIM(loc_oPg6.txt_4c_Unidade2.Value)
        IF EMPTY(loc_cCodigo)
            RETURN .T.
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CUnis, DUnis FROM SigCdUni WHERE CUnis = " + EscaparSQL(loc_cCodigo), ;
                "cursor_4c_TmpUni2")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpUni2")
                loc_oPg6.txt_4c_Unidade2.Value = ALLTRIM(cursor_4c_TmpUni2.CUnis)
            ELSE
                IF USED("cursor_4c_TmpUni2")
                    USE IN cursor_4c_TmpUni2
                ENDIF
                THIS.AbrirLookupUnidade2()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_TmpUni2")
            USE IN cursor_4c_TmpUni2
        ENDIF
        RETURN .T.
    ENDPROC

    PROCEDURE Unidade2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupUnidade2()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupUnidade2()
        LOCAL loc_oPg6, loc_oBusca, loc_cCodSel
        loc_oPg6 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page6
        IF !PEMSTATUS(loc_oPg6, "txt_4c_Unidade2", 5)
            RETURN
        ENDIF
        TRY
            *-- 1o parametro eh o HANDLE (par_nConn), que vai direto ao SQLEXEC. Erro172.
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUni", "cursor_4c_BuscaUni2", "CUnis", ;
                ALLTRIM(loc_oPg6.txt_4c_Unidade2.Value), ;
                "Unidade 2")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
            ENDIF
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.Show()
                ENDIF
                loc_cCodSel = loc_oBusca.this_cCodigoSelecionado
                IF !EMPTY(ALLTRIM(loc_cCodSel))
                    loc_oPg6.txt_4c_Unidade2.Value = ALLTRIM(loc_cCodSel)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnOptFinClick()
        MsgAviso("Finalidades de pedido s" + CHR(227) + "o configuradas no cadastro de Opera" + CHR(231) + CHR(245) + "es de Pedido (SigOpIns).")
    ENDPROC

    *-- =====================================================================
    *-- HELPERS COMPARTILHADOS - Moeda, Grupo Contab, Conta Contab
    *-- =====================================================================

    *-- Valida moeda e preenche descricao (helper compartilhado)
    PROTECTED FUNCTION ValidarMoedaEPreencher(par_cCodigo, par_oPagina, ;
        par_cTxtCod, par_cTxtDesc, par_cCursorNome)
        LOCAL loc_nResult, loc_cDesc
        loc_nResult = 0
        loc_cDesc   = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCodigo), ;
                par_cCursorNome)
            IF loc_nResult > 0 AND !EOF(par_cCursorNome)
                loc_cDesc = ALLTRIM(dmoes)
                IF PEMSTATUS(par_oPagina, par_cTxtCod, 5)
                    STORE ALLTRIM(cmoes) TO ("par_oPagina." + par_cTxtCod + ".Value")
                ENDIF
                IF !EMPTY(par_cTxtDesc) AND PEMSTATUS(par_oPagina, par_cTxtDesc, 5)
                    STORE loc_cDesc TO ("par_oPagina." + par_cTxtDesc + ".Value")
                ENDIF
            ELSE
                THIS.AbrirLookupMoeda(par_cTxtCod, par_cTxtDesc, 0)
                IF USED(par_cCursorNome)
                    USE IN (par_cCursorNome)
                ENDIF
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Moeda:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.ValidarMoedaEPreencher")
            IF USED(par_cCursorNome)
                USE IN (par_cCursorNome)
            ENDIF
            loc_lResultado = .F.
        ENDTRY
        IF USED(par_cCursorNome)
            USE IN (par_cCursorNome)
        ENDIF
        RETURN .T.
    ENDFUNC

    *-- Abre lookup de moeda com referencia ao campo na pagina especificada
    PROCEDURE AbrirLookupMoeda(par_cTxtCod, par_cTxtDesc, par_nPagina)
        LOCAL loc_oPg, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF par_nPagina >= 1 AND par_nPagina <= 9
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Pages(par_nPagina)
        ELSE
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoeda", "cmoes", ;
                IIF(PEMSTATUS(loc_oPg, par_cTxtCod, 5), ;
                    ALLTRIM(EVALUATE("loc_oPg." + par_cTxtCod + ".Value")), ""), ;
                "Moeda")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
                    SELECT cursor_4c_BuscaMoeda
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaMoeda.dmoes)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca de Moeda:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.AbrirLookupMoeda")
        ENDTRY

        IF USED("cursor_4c_BuscaMoeda")
            USE IN cursor_4c_BuscaMoeda
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF !EMPTY(par_cTxtCod) AND PEMSTATUS(loc_oPg, par_cTxtCod, 5)
                STORE loc_cCodigo TO ("loc_oPg." + par_cTxtCod + ".Value")
            ENDIF
            IF !EMPTY(par_cTxtDesc) AND PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
                STORE loc_cDesc TO ("loc_oPg." + par_cTxtDesc + ".Value")
            ENDIF
        ENDIF
    ENDPROC

    *-- Carrega descricao de moeda em campo Desc
    PROTECTED PROCEDURE CarregarDescMoeda(par_cCodigo, par_oPagina, par_cTxtDesc)
        LOCAL loc_nResult
        IF !PEMSTATUS(par_oPagina, par_cTxtDesc, 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            STORE "" TO ("par_oPagina." + par_cTxtDesc + ".Value")
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpMoeda")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpMoeda")
                STORE ALLTRIM(cursor_4c_TmpMoeda.dmoes) TO ("par_oPagina." + par_cTxtDesc + ".Value")
            ELSE
                STORE "" TO ("par_oPagina." + par_cTxtDesc + ".Value")
            ENDIF
        CATCH TO loc_oErro
            STORE "" TO ("par_oPagina." + par_cTxtDesc + ".Value")
        ENDTRY
        IF USED("cursor_4c_TmpMoeda")
            USE IN cursor_4c_TmpMoeda
        ENDIF
    ENDPROC

    *-- Valida Grupo Contabil (SigCdGcr) e preenche descricao
    PROTECTED FUNCTION ValidarGrupoContab(par_cCodigo, par_oPagina, ;
        par_cTxtCod, par_cTxtDesc, par_cCursorNome)
        LOCAL loc_nResult, loc_cDesc
        loc_nResult = 0
        loc_cDesc   = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(par_cCodigo), ;
                par_cCursorNome)
            IF loc_nResult > 0 AND !EOF(par_cCursorNome)
                loc_cDesc = ALLTRIM(Descrs)
                IF PEMSTATUS(par_oPagina, par_cTxtCod, 5)
                    STORE ALLTRIM(Codigos) TO ("par_oPagina." + par_cTxtCod + ".Value")
                ENDIF
                IF !EMPTY(par_cTxtDesc) AND PEMSTATUS(par_oPagina, par_cTxtDesc, 5)
                    STORE loc_cDesc TO ("par_oPagina." + par_cTxtDesc + ".Value")
                ENDIF
            ELSE
                IF USED(par_cCursorNome)
                    USE IN (par_cCursorNome)
                ENDIF
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Grupo Cont" + CHR(225) + "bil:" + CHR(13) + ;
                loc_oErro.Message, "FormGpd.ValidarGrupoContab")
            IF USED(par_cCursorNome)
                USE IN (par_cCursorNome)
            ENDIF
            loc_lResultado = .F.
        ENDTRY
        IF USED(par_cCursorNome)
            USE IN (par_cCursorNome)
        ENDIF
        RETURN .T.
    ENDFUNC

    *-- Abre lookup de Grupo Contabil (SigCdGcr)
    PROCEDURE AbrirLookupGrupoContab(par_cTxtCod, par_cTxtDesc, par_nPagina)
        LOCAL loc_oPg, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF par_nPagina >= 1 AND par_nPagina <= 9
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Pages(par_nPagina)
        ELSE
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGruContab", "Codigos", ;
                IIF(PEMSTATUS(loc_oPg, par_cTxtCod, 5), ;
                    ALLTRIM(EVALUATE("loc_oPg." + par_cTxtCod + ".Value")), ""), ;
                "Grupo Cont" + CHR(225) + "bil")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGruContab")
                    SELECT cursor_4c_BuscaGruContab
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaGruContab.Codigos)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaGruContab.Descrs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca de Grupo Cont" + CHR(225) + "bil:" + CHR(13) + ;
                loc_oErro.Message, "FormGpd.AbrirLookupGrupoContab")
        ENDTRY

        IF USED("cursor_4c_BuscaGruContab")
            USE IN cursor_4c_BuscaGruContab
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF !EMPTY(par_cTxtCod) AND PEMSTATUS(loc_oPg, par_cTxtCod, 5)
                STORE loc_cCodigo TO ("loc_oPg." + par_cTxtCod + ".Value")
            ENDIF
            IF !EMPTY(par_cTxtDesc) AND PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
                STORE loc_cDesc TO ("loc_oPg." + par_cTxtDesc + ".Value")
            ENDIF
        ENDIF
    ENDPROC

    *-- Carrega descricao de Grupo Contabil em campo Desc
    PROTECTED PROCEDURE CarregarDescGruContab(par_cCodigo, par_oPagina, par_cTxtDesc)
        LOCAL loc_nResult
        IF !PEMSTATUS(par_oPagina, par_cTxtDesc, 5)
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(par_cCodigo))
            STORE "" TO ("par_oPagina." + par_cTxtDesc + ".Value")
            RETURN
        ENDIF
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_TmpGruContab")
            IF loc_nResult > 0 AND !EOF("cursor_4c_TmpGruContab")
                STORE ALLTRIM(cursor_4c_TmpGruContab.Descrs) TO ("par_oPagina." + par_cTxtDesc + ".Value")
            ELSE
                STORE "" TO ("par_oPagina." + par_cTxtDesc + ".Value")
            ENDIF
        CATCH TO loc_oErro
            STORE "" TO ("par_oPagina." + par_cTxtDesc + ".Value")
        ENDTRY
        IF USED("cursor_4c_TmpGruContab")
            USE IN cursor_4c_TmpGruContab
        ENDIF
    ENDPROC

    *-- Valida Conta Contabil (SigCdCli)
    PROTECTED FUNCTION ValidarContaContab(par_cCodigo, par_oPagina, ;
        par_cTxtCod, par_cTxtDesc, par_cCursorNome)
        LOCAL loc_nResult, loc_cDesc
        loc_nResult = 0
        loc_cDesc   = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(par_cCodigo), ;
                par_cCursorNome)
            IF loc_nResult > 0 AND !EOF(par_cCursorNome)
                loc_cDesc = ALLTRIM(Rclis)
                IF PEMSTATUS(par_oPagina, par_cTxtCod, 5)
                    STORE ALLTRIM(Iclis) TO ("par_oPagina." + par_cTxtCod + ".Value")
                ENDIF
                IF !EMPTY(par_cTxtDesc) AND PEMSTATUS(par_oPagina, par_cTxtDesc, 5)
                    STORE loc_cDesc TO ("par_oPagina." + par_cTxtDesc + ".Value")
                ENDIF
            ELSE
                IF USED(par_cCursorNome)
                    USE IN (par_cCursorNome)
                ENDIF
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao validar Conta:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.ValidarContaContab")
            IF USED(par_cCursorNome)
                USE IN (par_cCursorNome)
            ENDIF
            loc_lResultado = .F.
        ENDTRY
        IF USED(par_cCursorNome)
            USE IN (par_cCursorNome)
        ENDIF
        RETURN .T.
    ENDFUNC

    *-- Abre lookup de Conta Contabil (SigCdCli)
    PROCEDURE AbrirLookupContaContab(par_cTxtCod, par_cTxtDesc, par_nPagina)
        LOCAL loc_oPg, loc_oBusca, loc_cCodigo, loc_cDesc
        loc_cCodigo = ""
        loc_cDesc   = ""

        IF par_nPagina >= 1 AND par_nPagina <= 9
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Pages(par_nPagina)
        ELSE
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCtaContab", "Iclis", ;
                IIF(PEMSTATUS(loc_oPg, par_cTxtCod, 5), ;
                    ALLTRIM(EVALUATE("loc_oPg." + par_cTxtCod + ".Value")), ""), ;
                "Conta")
            IF VARTYPE(loc_oBusca) = "O"
                *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Rclis", "", "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtaContab")
                    SELECT cursor_4c_BuscaCtaContab
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCtaContab.Iclis)
                    loc_cDesc   = ALLTRIM(cursor_4c_BuscaCtaContab.Rclis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro na busca de Conta:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.AbrirLookupContaContab")
        ENDTRY

        IF USED("cursor_4c_BuscaCtaContab")
            USE IN cursor_4c_BuscaCtaContab
        ENDIF
        IF !EMPTY(loc_cCodigo)
            IF !EMPTY(par_cTxtCod) AND PEMSTATUS(loc_oPg, par_cTxtCod, 5)
                STORE loc_cCodigo TO ("loc_oPg." + par_cTxtCod + ".Value")
            ENDIF
            IF !EMPTY(par_cTxtDesc) AND PEMSTATUS(loc_oPg, par_cTxtDesc, 5)
                STORE loc_cDesc TO ("loc_oPg." + par_cTxtDesc + ".Value")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * chk_4c_Logalt - CheckBox bloqueio de alteracoes (na Page1 / pgCadastro)
    * Adicionado aqui pois foi referenciado em FormParaBO/BOParaForm
    *==========================================================================
    PROTECTED PROCEDURE AdicionarChkLogalt()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1

        loc_oPg1.AddObject("lbl_4c_Logalt", "Label")
        WITH loc_oPg1.lbl_4c_Logalt
            .Caption   = "Bloqueio de Altera" + CHR(231) + CHR(245) + "es :"
            .Top       = 423
            .Left      = 63
            .Width     = 118
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg1.AddObject("chk_4c_Logalt", "OptionGroup")
        WITH loc_oPg1.chk_4c_Logalt
            .Value        = 2
            .Top          = 418
            .Left         = 183
            .Width        = 120
            .Height       = 25
            .ButtonCount  = 2
            .BackStyle    = 0
            .BorderStyle  = 0
            .Visible      = .F.
            WITH .Buttons(1)
                .Caption = "Sim"
                .Left = 5
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption = "N" + CHR(227) + "o"
                .Left = 60
                .Top  = 5
                .Width = 34
                .Height = 15
                .BackStyle = 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        ENDWITH
        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *==========================================================================
    * ConfigurarPgpgCadastro - Controles restantes da aba Cadastro (Page1)
    * Labels: sufixos "dias", "[S/N/D]", "Tipo de Produto :", AddEntPorEmp
    * OptionGroup: obj_4c_OptTipoJoals (8 opcoes joalheria)
    * Grid: grd_4c_PsgCad (sub-grupos inline) + obj_4c_CmdgCompo
    * Grid: grd_4c_Prazos + cmd_4c_InserirPrazo + cmd_4c_ExcluirPrazo
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgCadastro()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1

        *-- "dias" apos DiasEnts (Say12: Top=201+29=230, Left=220)
        loc_oPg1.AddObject("lbl_4c_DiasSufEnts", "Label")
        WITH loc_oPg1.lbl_4c_DiasSufEnts
            .Caption   = "dias"
            .Top       = 230
            .Left      = 220
            .Width     = 21
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        *-- "dias" apos DiasGar (Say6: Top=226+29=255, Left=220)
        loc_oPg1.AddObject("lbl_4c_DiasSufGar", "Label")
        WITH loc_oPg1.lbl_4c_DiasSufGar
            .Caption   = "dias"
            .Top       = 255
            .Left      = 220
            .Width     = 21
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        *-- "[S/N/D]" apos EtiPad (Say36: Top=250+29=279, Left=204)
        loc_oPg1.AddObject("lbl_4c_EtiPadSN", "Label")
        WITH loc_oPg1.lbl_4c_EtiPadSN
            .Caption   = "[S/N/D]"
            .Top       = 279
            .Left      = 204
            .Width     = 41
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        *-- "Tipo de Produto :" (Say23: Top=340+29=369, Left=96)
        loc_oPg1.AddObject("lbl_4c_TipoProduto", "Label")
        WITH loc_oPg1.lbl_4c_TipoProduto
            .Caption   = "Tipo de Produto :"
            .Top       = 369
            .Left      = 96
            .Width     = 85
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        *-- optTipoJoals 8 opcoes joalheria (Top=335+29=364, Left=178)
        *-- BO this_lNtipjoals e logical (bug pre-existente) - Value=5(Nenhum) default seguro
        loc_oPg1.AddObject("obj_4c_OptTipoJoals", "OptionGroup")
        WITH loc_oPg1.obj_4c_OptTipoJoals
            .Value         = 5
            .Top           = 364
            .Left          = 178
            .Width         = 271
            .Height        = 59
            .ButtonCount   = 8
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Visible       = .F.
            WITH .Buttons(1)
                .Caption   = "Pedra"
                .Left      = 5
                .Top       = 5
                .Width     = 46
                .Height    = 15
                .BackStyle = 0
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Brilhante"
                .Left      = 103
                .Top       = 5
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Garra"
                .Left      = 181
                .Top       = 5
                .Width     = 50
                .Height    = 16
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "M" + CHR(227) + "o de Obra"
                .Left      = 5
                .Top       = 21
                .Width     = 92
                .Height    = 16
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "Nenhum"
                .Left      = 103
                .Top       = 21
                .Width     = 65
                .Height    = 17
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH .Buttons(6)
                .Caption   = "Semi Acabado"
                .Left      = 181
                .Top       = 22
                .Width     = 85
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH .Buttons(7)
                .Caption   = "Rel" + CHR(243) + "gio"
                .Left      = 5
                .Top       = 39
                .Width     = 53
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
            WITH .Buttons(8)
                .Caption   = "Componente Rel" + CHR(243) + "gio"
                .Left      = 103
                .Top       = 38
                .Width     = 117
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
            ENDWITH
        ENDWITH

        *-- "Adiciona na Entrega por Empresa" (Say3: Top=417+29=446, Left=185)
        loc_oPg1.AddObject("lbl_4c_AddEntPorEmp", "Label")
        WITH loc_oPg1.lbl_4c_AddEntPorEmp
            .Caption   = "Adiciona na Entrega por Empresa"
            .Top       = 446
            .Left      = 185
            .Width     = 161
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .F.
        ENDWITH

        *-- Grid sub-grupos inline (grdSigCdPsg: Top=137+29=166, Left=525, W=372, H=445)
        *-- cursor schema: SigCdPsg (cidchaves c20 PK, marckupa n8.2)
        IF !USED("cursor_4c_SigCdPsg")
            CREATE CURSOR cursor_4c_SigCdPsg ;
                (cgrus c(3), codigos c(6), descricaos c(20), cidchaves c(20), ;
                 cgrucods c(9), marckupa n(8,2), pesoprods n(1,0))
        ENDIF
        loc_oPg1.AddObject("grd_4c_PsgCad", "Grid")
        WITH loc_oPg1.grd_4c_PsgCad
            .Top           = 166
            .Left          = 525
            .Width         = 372
            .Height        = 445
            .ColumnCount   = 4
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .RowHeight     = 17
            .ScrollBars    = 2
            .GridLines     = 3
            .GridLineColor = RGB(238, 238, 238)
            .FontSize      = 8
            .RecordSource  = "cursor_4c_SigCdPsg"
            .Visible       = .F.
        ENDWITH
        WITH loc_oPg1.grd_4c_PsgCad
            .Column1.ControlSource    = "cursor_4c_SigCdPsg.codigos"
            .Column1.Width            = 65
            .Column1.Movable          = .F.
            .Column1.Resizable        = .F.
            .Column1.ReadOnly         = .T.
            .Column1.Header1.Caption  = "Sub-Grupo"
            .Column1.Header1.FontName = "Tahoma"
            .Column1.Header1.FontSize = 8
            .Column1.Header1.Alignment = 2
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .T.
            .Column2.ControlSource    = "cursor_4c_SigCdPsg.descricaos"
            .Column2.Width            = 185
            .Column2.Movable          = .F.
            .Column2.Resizable        = .F.
            .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.FontName = "Tahoma"
            .Column2.Header1.FontSize = 8
            .Column2.Header1.Alignment = 2
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column3.ControlSource    = "cursor_4c_SigCdPsg.pesoprods"
            .Column3.Width            = 17
            .Column3.ColumnOrder      = 4
            .Column3.Sparse           = .F.
            .Column3.Header1.Caption  = ""
            .Column4.ControlSource    = "cursor_4c_SigCdPsg.marckupa"
            .Column4.Width            = 70
            .Column4.ColumnOrder      = 3
            .Column4.InputMask        = "999,999.99"
            .Column4.Header1.Caption  = "Markup"
            .Column4.Header1.FontName = "Tahoma"
            .Column4.Header1.FontSize = 8
            .Column4.Header1.Alignment = 2
            .Column4.Text1.BorderStyle = 0
            .Column4.Text1.InputMask   = "999,999.99"
            .Column4.Text1.Margin      = 0
        ENDWITH

        *-- CheckBox da Column3 (pesoprods). A Column nasce so com Header1 e Text1:
        *-- o CheckBox tem de ser CRIADO com AddObject e eleito CurrentControl, senao
        *-- a coluna segue desenhando o Text1 (regra #18). Antes daqui o form apenas
        *-- atribuia .Column3.Check1.<prop>, o que estourava "Unknown member CHECK1."
        *-- no Init e a tela nao abria. Geometria transcrita do SCX legado
        *-- (SIGCDGPD...grdSigCdPsg.Column3.Check1: Top 27, Left 11, 60x17, Alignment 0,
        *-- Caption ""). Erro171.
        loc_oPg1.grd_4c_PsgCad.Column3.AddObject("Check1", "CheckBox")
        WITH loc_oPg1.grd_4c_PsgCad.Column3.Check1
            .Caption   = ""
            .Alignment = 0
            .Top       = 27
            .Left      = 11
            .Width     = 60
            .Height    = 17
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH
        loc_oPg1.grd_4c_PsgCad.Column3.CurrentControl = "Check1"
        loc_oPg1.grd_4c_PsgCad.Column3.Sparse         = .F.

        BINDEVENT(loc_oPg1.grd_4c_PsgCad.Column1.Text1, "Valid", THIS, "PsgCadCodigoValid")

        *-- CommandGroup inserir/excluir sub-grupos (cmdgCompo: Top=284+29=313, Left=903)
        loc_oPg1.AddObject("obj_4c_CmdgCompo", "CommandGroup")
        WITH loc_oPg1.obj_4c_CmdgCompo
            .Top         = 313
            .Left        = 903
            .Width       = 43
            .Height      = 89
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Themes      = .F.
            .Visible     = .F.
            WITH .Buttons(1)
                .AutoSize        = .F.
                .Top             = -1
                .Left            = -1
                .Height          = 45
                .Width           = 45
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .ToolTipText     = "Inserir"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .FontBold        = .T.
            ENDWITH
            WITH .Buttons(2)
                .AutoSize        = .F.
                .Top             = 44
                .Left            = -1
                .Height          = 45
                .Width           = 45
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .ToolTipText     = "Excluir"
                .ForeColor       = RGB(36, 84, 155)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .FontBold        = .T.
                .FontName        = "Verdana"
                .FontSize        = 8
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPg1.obj_4c_CmdgCompo.Buttons(1), "Click", THIS, "PsgCadInserirClick")
        BINDEVENT(loc_oPg1.obj_4c_CmdgCompo.Buttons(2), "Click", THIS, "PsgCadExcluirClick")

        *-- Grid Prazos (GradPrz: Top=433+29=462, Left=185, W=120, H=165)
        IF !USED("cursor_4c_Prazos")
            CREATE CURSOR cursor_4c_Prazos (Cemps c(3), diasprz n(3,0))
        ENDIF
        loc_oPg1.AddObject("grd_4c_Prazos", "Grid")
        WITH loc_oPg1.grd_4c_Prazos
            .Top           = 462
            .Left          = 185
            .Width         = 120
            .Height        = 165
            .ColumnCount   = 2
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLines     = 3
            .GridLineWidth = 1
            .HeaderHeight  = 20
            .ScrollBars    = 2
            .GridLineColor = RGB(238, 238, 238)
            .ToolTipText   = "Esta grade " + CHR(233) + " usada para calcular prazo de entrega"
            .RecordSource  = "cursor_4c_Prazos"
            .Visible       = .F.
        ENDWITH
        WITH loc_oPg1.grd_4c_Prazos
            .Column1.ControlSource    = "cursor_4c_Prazos.Cemps"
            .Column1.Width            = 45
            .Column1.Header1.Caption  = "Empresa"
            .Column1.Header1.FontName = "Tahoma"
            .Column1.Header1.FontSize = 8
            .Column1.Header1.Alignment = 2
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.Format      = "!"
            .Column2.ControlSource    = "cursor_4c_Prazos.diasprz"
            .Column2.Width            = 52
            .Column2.Header1.Caption  = "Dias"
            .Column2.Header1.FontName = "Tahoma"
            .Column2.Header1.FontSize = 8
            .Column2.Header1.Alignment = 2
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.InputMask   = "999"
            .Column2.Text1.Margin      = 0
        ENDWITH
        BINDEVENT(loc_oPg1.grd_4c_Prazos.Column1.Text1, "Valid", THIS, "PrazoEmpresaValid")

        *-- Inserir prazo (inserir: Top=459+29=488, Left=310)
        loc_oPg1.AddObject("cmd_4c_InserirPrazo", "CommandButton")
        WITH loc_oPg1.cmd_4c_InserirPrazo
            .Top             = 488
            .Left            = 310
            .Width           = 45
            .Height          = 45
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ToolTipText     = "Inserir Prazo"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .FontBold        = .T.
            .FontName        = "Verdana"
            .FontSize        = 8
            .Themes          = .T.
            .Visible         = .F.
        ENDWITH
        BINDEVENT(loc_oPg1.cmd_4c_InserirPrazo, "Click", THIS, "InserirPrazoClick")

        *-- Excluir prazo (excluir: Top=504+29=533, Left=310)
        loc_oPg1.AddObject("cmd_4c_ExcluirPrazo", "CommandButton")
        WITH loc_oPg1.cmd_4c_ExcluirPrazo
            .Top             = 533
            .Left            = 310
            .Width           = 45
            .Height          = 45
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText     = "Excluir Prazo"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .FontBold        = .T.
            .FontName        = "Verdana"
            .FontSize        = 8
            .Themes          = .T.
            .Visible         = .F.
        ENDWITH
        BINDEVENT(loc_oPg1.cmd_4c_ExcluirPrazo, "Click", THIS, "ExcluirPrazoClick")

        THIS.TornarControlesVisiveis(loc_oPg1)
    ENDPROC

    *==========================================================================
    * CarregarSigCdPsgCad - Carrega cursor_4c_SigCdPsg com sub-grupos do grupo
    *==========================================================================
    PROCEDURE CarregarSigCdPsgCad(par_cCgrus)
        LOCAL loc_cSql, loc_nRet, loc_lProsseguir
        IF !USED("cursor_4c_SigCdPsg")
            RETURN
        ENDIF
        loc_lProsseguir = .T.
        TRY
            SELECT cursor_4c_SigCdPsg
            ZAP
            IF EMPTY(ALLTRIM(par_cCgrus))
                loc_lProsseguir = .F.
            ENDIF
            IF loc_lProsseguir
                loc_cSql = "SELECT cgrus, codigos, descricaos, cidchaves, cgrucods, " + ;
                           "marckupa, pesoprods " + ;
                           "FROM SigCdPsg " + ;
                           "WHERE cgrus = " + EscaparSQL(ALLTRIM(par_cCgrus)) + ;
                           " ORDER BY codigos"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SigCdPsg")
                IF loc_nRet < 0
                    MsgErro("Erro ao carregar sub-grupos.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PsgCadCodigoValid - Valida codigo do sub-grupo (Column1 do grd_4c_PsgCad)
    * Verifica duplicidade de codigos no cursor
    *==========================================================================
    PROCEDURE PsgCadCodigoValid()
        LOCAL loc_oPg1, loc_cCod, loc_oGrd, loc_lOk
        loc_lOk  = .T.
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page1
        IF !PEMSTATUS(loc_oPg1, "grd_4c_PsgCad", 5)
            RETURN loc_lOk
        ENDIF
        loc_oGrd = loc_oPg1.grd_4c_PsgCad
        IF !USED("cursor_4c_SigCdPsg")
            RETURN loc_lOk
        ENDIF
        loc_cCod = ALLTRIM(cursor_4c_SigCdPsg.codigos)
        IF EMPTY(loc_cCod)
            RETURN loc_lOk
        ENDIF
        LOCAL loc_nRecno
        loc_nRecno = RECNO("cursor_4c_SigCdPsg")
        SELECT cursor_4c_SigCdPsg
        SCAN FOR ALLTRIM(codigos) = loc_cCod AND RECNO() <> loc_nRecno
            MsgAviso("C" + CHR(243) + "digo " + loc_cCod + " j" + ;
                CHR(225) + " cadastrado.", "Sub-Grupo")
            loc_lOk = .F.
            EXIT
        ENDSCAN
        IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_SigCdPsg")
            GO loc_nRecno IN cursor_4c_SigCdPsg
        ENDIF
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * PsgCadInserirClick - Insere linha em branco no cursor_4c_SigCdPsg
    *==========================================================================
    PROCEDURE PsgCadInserirClick()
        IF !USED("cursor_4c_SigCdPsg")
            RETURN
        ENDIF
        LOCAL loc_cCgrus
        loc_cCgrus = ALLTRIM(THIS.this_oBusinessObject.this_cCgrus)
        SELECT cursor_4c_SigCdPsg
        APPEND BLANK
        REPLACE cgrus WITH loc_cCgrus
        REPLACE cidchaves WITH SYS(2015)
    ENDPROC

    *==========================================================================
    * PsgCadExcluirClick - Exclui sub-grupo selecionado do cursor_4c_SigCdPsg
    * Verifica se existem produtos vinculados antes de excluir
    *==========================================================================
    PROCEDURE PsgCadExcluirClick()
        LOCAL loc_lProsseguir
        IF !USED("cursor_4c_SigCdPsg")
            RETURN
        ENDIF
        IF RECCOUNT("cursor_4c_SigCdPsg") = 0 OR EOF("cursor_4c_SigCdPsg")
            RETURN
        ENDIF
        LOCAL loc_cCod, loc_cCgrus, loc_nRet, loc_nCount, loc_lExcluir
        loc_lExcluir = .F.
        loc_cCod   = ALLTRIM(cursor_4c_SigCdPsg.codigos)
        loc_cCgrus = ALLTRIM(cursor_4c_SigCdPsg.cgrus)
        IF EMPTY(loc_cCod)
            SELECT cursor_4c_SigCdPsg
            DELETE
            PACK
            RETURN
        ENDIF
        loc_lProsseguir = .T.
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT COUNT(*) AS qtd FROM SigCdPro " + ;
                "WHERE codigos = " + EscaparSQL(loc_cCod) + ;
                " AND cgrus = " + EscaparSQL(loc_cCgrus), ;
                "cursor_4c_ChkPsgPro")
            IF loc_nRet > 0
                SELECT cursor_4c_ChkPsgPro
                loc_nCount = cursor_4c_ChkPsgPro.qtd
                IF USED("cursor_4c_ChkPsgPro")
                    USE IN cursor_4c_ChkPsgPro
                ENDIF
                IF loc_nCount > 0
                    MsgAviso("Sub-grupo '" + loc_cCod + "' possui " + ;
                        ALLTRIM(STR(loc_nCount)) + " produto(s) vinculado(s). " + ;
                        "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
                        "vel excluir.", "Sub-Grupo")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF
            IF loc_lProsseguir
                loc_lExcluir = MsgConfirma("Excluir sub-grupo '" + loc_cCod + "'?", "Confirmar")
                IF loc_lExcluir
                    SELECT cursor_4c_SigCdPsg
                    DELETE
                    PACK
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PrazoEmpresaValid - Valida empresa digitada na Column1 do grd_4c_Prazos
    *==========================================================================
    PROCEDURE PrazoEmpresaValid()
        LOCAL loc_lOk, loc_cEmps, loc_nRet
        loc_lOk  = .T.
        IF !USED("cursor_4c_Prazos")
            RETURN loc_lOk
        ENDIF
        loc_cEmps = ALLTRIM(cursor_4c_Prazos.Cemps)
        IF EMPTY(loc_cEmps)
            RETURN loc_lOk
        ENDIF
        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas FROM SigCdEmp " + ;
                "WHERE emps = " + EscaparSQL(loc_cEmps), ;
                "cursor_4c_BuscaEmpPrz")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaEmpPrz") > 0
                IF USED("cursor_4c_BuscaEmpPrz")
                    USE IN cursor_4c_BuscaEmpPrz
                ENDIF
                *-- Verificar duplicidade
                LOCAL loc_nRecno
                loc_nRecno = RECNO("cursor_4c_Prazos")
                SELECT cursor_4c_Prazos
                SCAN FOR ALLTRIM(Cemps) = loc_cEmps AND RECNO() <> loc_nRecno
                    MsgAviso("Empresa " + loc_cEmps + " j" + CHR(225) + ;
                        " adicionada.", "Prazo")
                    loc_lOk = .F.
                    EXIT
                ENDSCAN
                IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT("cursor_4c_Prazos")
                    GO loc_nRecno IN cursor_4c_Prazos
                ENDIF
            ELSE
                IF USED("cursor_4c_BuscaEmpPrz")
                    USE IN cursor_4c_BuscaEmpPrz
                ENDIF
                THIS.AbrirBuscaEmpPrazo()
                loc_lOk = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmpPrazo - Abre FormBuscaAuxiliar para lookup de empresa (Prazos)
    *==========================================================================
    PROCEDURE AbrirBuscaEmpPrazo()
        LOCAL loc_oForm
        loc_oForm = FormBuscaAuxiliar.Init("SigCdEmp", "cemps", "razas", ;
            "", "", "", "", "", "")
        IF VARTYPE(loc_oForm) = "O"
            *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
            IF !loc_oForm.this_lAchouRegistro
                loc_oForm.Show()
            ENDIF
            IF USED("cursor_4c_BuscaAuxiliar") AND RECCOUNT("cursor_4c_BuscaAuxiliar") > 0
                IF USED("cursor_4c_Prazos") AND !EOF("cursor_4c_Prazos")
                    SELECT cursor_4c_Prazos
                    REPLACE Cemps WITH ALLTRIM(cursor_4c_BuscaAuxiliar.emps)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * InserirPrazoClick - Insere linha em branco no cursor_4c_Prazos
    *==========================================================================
    PROCEDURE InserirPrazoClick()
        IF !USED("cursor_4c_Prazos")
            RETURN
        ENDIF
        SELECT cursor_4c_Prazos
        APPEND BLANK
    ENDPROC

    *==========================================================================
    * ExcluirPrazoClick - Exclui linha atual do cursor_4c_Prazos
    *==========================================================================
    PROCEDURE ExcluirPrazoClick()
        IF !USED("cursor_4c_Prazos")
            RETURN
        ENDIF
        IF RECCOUNT("cursor_4c_Prazos") = 0 OR EOF("cursor_4c_Prazos")
            RETURN
        ENDIF
        LOCAL loc_lConfirma
        loc_lConfirma = MsgConfirma("Excluir prazo de entrega?", "Confirmar")
        IF loc_lConfirma
            SELECT cursor_4c_Prazos
            DELETE
            PACK
        ENDIF
    ENDPROC

    *==========================================================================
    * InicializarCursoresCodificacao - Cria crMontagem e crGrpMonta vazios
    * Chamado em InicializarForm() antes de ConfigurarPageFrame()
    *==========================================================================
    PROTECTED PROCEDURE InicializarCursoresCodificacao()
        TRY
            IF !USED("crMontagem")
                CREATE CURSOR crMontagem (Grupos c(10), Posicoes n(1,0), Digitos n(1,0))
            ENDIF
            IF !USED("crGrpMonta")
                CREATE CURSOR crGrpMonta (Grupos c(10), Descs c(20))
                SELECT crGrpMonta
                INDEX ON Grupos TAG Grupos
                INDEX ON Descs TAG Descs
            ENDIF
            IF !USED("LocalProD")
                CREATE CURSOR LocalProD ;
                    (CGrus c(3), TpMontas n(1,0), COrds n(2,0), CpMontas n(2,0), ;
                     Virgulas n(1,0), TpCompos n(1,0), ZeroDirs n(1,0), Linguas n(1,0), ;
                     ChecaEtiqs n(1,0), Agrupar n(1,0), Mercs c(3), cidchaves c(20))
                SELECT LocalProD
                INDEX ON CGrus + STR(TpMontas, 1) + STR(COrds, 2) TAG Ordem
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar cursores de codifica" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "FormGpd.InicializarCursoresCodificacao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarCrGrpMonta - Popula crGrpMonta com grupos fixos + SigCdGrp
    * Chamado em BOParaForm() ao carregar registro
    *==========================================================================
    PROTECTED PROCEDURE CarregarCrGrpMonta()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_lProsseguir
        loc_lResultado = .F.

        loc_lProsseguir = .T.
        TRY
            IF !USED("crGrpMonta")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                ZAP IN crGrpMonta

            *-- Grupos fixos de montagem
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("SEQUENCIAL", 10), "N" + CHR(218) + "MERO SEQUENCIAL")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("/", 10), "BARRA DIVISORA")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR(".", 10), "PONTO DIVISOR")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("SUBGRUPO", 10), "SUBGRUPOS")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("REF.FORNEC", 10), "REF. FORNECEDOR")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("CONJUNTO", 10), "CONJUNTO")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("MODELO", 10), "MODELO")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("COR", 10), "COR PADR" + CHR(195) + "O")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("OBS.COMPO.", 10), "OBS.COMPONENTE")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("IDENTIFIC.", 10), "IDENTIFICADOR")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("COMPO1", 10), "COMPOSI" + CHR(199) + CHR(195) + "O 1")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("COMPO2", 10), "COMPOSI" + CHR(199) + CHR(195) + "O 2")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("COMPO3", 10), "COMPOSI" + CHR(199) + CHR(195) + "O 3")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("GRUPOVENDA", 10), "GRUPO DE VENDA")
                INSERT INTO crGrpMonta (Grupos, Descs) VALUES (PADR("LINHA", 10), "LINHA")

            *-- Grupos dinamicos de SigCdGrp
                loc_cSQL = "SELECT CGrus, DGrus FROM SigCdGrp"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposMonta")
                IF loc_nResult > 0 AND USED("cursor_4c_GruposMonta")
                    SELECT cursor_4c_GruposMonta
                    SCAN
                        INSERT INTO crGrpMonta (Grupos, Descs) ;
                            VALUES (PADR(ALLTRIM(cursor_4c_GruposMonta.CGrus), 10), ;
                                    LEFT(ALLTRIM(cursor_4c_GruposMonta.DGrus), 20))
                    ENDSCAN
                    USE IN cursor_4c_GruposMonta
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupos de montagem:" + CHR(13) + ;
                loc_oErro.Message, "FormGpd.CarregarCrGrpMonta")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarCrMontagem - Carrega crMontagem de SigCdGgc
    * Chamado em BOParaForm() apos carregar registro
    *==========================================================================
    PROTECTED PROCEDURE CarregarCrMontagem(par_cCgrus, par_nCodprods)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_lProsseguir
        loc_lResultado = .F.

        loc_lProsseguir = .T.
        TRY
            IF !USED("crMontagem")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                ZAP IN crMontagem

            *-- Carregar de SigCdGgc apenas se CodProds=6 (Identificador+Composicao)
                IF par_nCodprods = 6 AND !EMPTY(par_cCgrus)
                    loc_cSQL = "SELECT grupos, posicoes, digitos FROM SigCdGgc " + ;
                               "WHERE cgrus = " + EscaparSQL(par_cCgrus) + ;
                               " ORDER BY posicoes, grupos, digitos"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GgcLoad")
                    IF loc_nResult > 0 AND USED("cursor_4c_GgcLoad")
                        SELECT cursor_4c_GgcLoad
                        SCAN
                            INSERT INTO crMontagem (Grupos, Posicoes, Digitos) ;
                                VALUES (cursor_4c_GgcLoad.grupos, ;
                                        cursor_4c_GgcLoad.posicoes, ;
                                        cursor_4c_GgcLoad.digitos)
                        ENDSCAN
                        USE IN cursor_4c_GgcLoad
                    ENDIF
                ENDIF

            *-- Sempre garantir ao menos uma linha em branco para edicao
                IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                    IF RECCOUNT("crMontagem") = 0 OR ;
                       (!EOF("crMontagem") AND !EMPTY(crMontagem.Grupos))
                        INSERT INTO crMontagem (Grupos) VALUES ("")
                    ENDIF
                    GO BOTTOM IN crMontagem
                ENDIF

            *-- Atualizar grid se existir
                LOCAL loc_oPg8
                loc_oPg8 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8
                IF PEMSTATUS(loc_oPg8, "grd_4c_Codificacao", 5)
                    loc_oPg8.grd_4c_Codificacao.Refresh
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar montagem:" + CHR(13) + ;
                loc_oErro.Message, "FormGpd.CarregarCrMontagem")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * SalvarCrMontagem - Salva crMontagem em SigCdGgc apos gravar SigCdGrp
    * Chamado em BtnSalvarClick() apos this_oBusinessObject.Salvar()
    *==========================================================================
    PROTECTED PROCEDURE SalvarCrMontagem(par_cCgrus)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCgrus
        loc_lResultado = .F.
        loc_cCgrus     = ALLTRIM(par_cCgrus)

        TRY
            IF !USED("crMontagem") OR EMPTY(loc_cCgrus) OR ;
               THIS.this_oBusinessObject.this_nCodprods != 6
                loc_lResultado = .T.
            ENDIF

            *-- Remover registros existentes de SigCdGgc para o grupo
            loc_cSQL    = "DELETE FROM SigCdGgc WHERE cgrus = " + EscaparSQL(loc_cCgrus)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir codifica" + CHR(231) + CHR(227) + ;
                    "o anterior (SigCdGgc).", "FormGpd.SalvarCrMontagem")
                loc_lResultado = .F.
            ENDIF

            *-- Inserir linhas validas de crMontagem
            SELECT crMontagem
            SCAN
                IF !EMPTY(crMontagem.Grupos) AND !EMPTY(crMontagem.Posicoes) AND ;
                   !EMPTY(crMontagem.Digitos)
                    LOCAL loc_cGuid
                    loc_cGuid = SYS(2015)
                    loc_cSQL  = "INSERT INTO SigCdGgc (cgrus, cidchaves, grupos, posicoes, digitos) " + ;
                                "VALUES (" + EscaparSQL(loc_cCgrus) + ", " + ;
                                EscaparSQL(loc_cGuid) + ", " + ;
                                EscaparSQL(ALLTRIM(crMontagem.Grupos)) + ", " + ;
                                FormatarNumeroSQL(crMontagem.Posicoes) + ", " + ;
                                FormatarNumeroSQL(crMontagem.Digitos) + ")"
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao salvar linha de codifica" + CHR(231) + CHR(227) + ;
                            "o (SigCdGgc).", "FormGpd.SalvarCrMontagem")
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
            ENDSCAN

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar codifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message, "FormGpd.SalvarCrMontagem")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC


    *==========================================================================
    * ConfigurarPgpgProdutos - Segunda passada sobre a Page2 (aba Produtos) do
    * pgf_4c_Divisoes, que o ConfigurarAbaProdutos() nao cobria.
    *
    * O metodo era CHAMADO em ConfigurarPaginaDados mas nunca foi gerado: o Init
    * estourava "Property CONFIGURARPGPGPRODUTOS is not found" e a tela do Cadastro
    * de Grupo de Produto nao abria (Erro171).
    *
    * Transcrito de tasks\task438\sigcdgpd_form_codigo_fonte.txt
    * (SIGCDGPD.Pagina.Dados.pgDivisoes.pgProdutos): 115 controles no legado, 30 ja
    * criados pelo ConfigurarAbaProdutos e 71 criados aqui. Os 14 restantes sao os 6
    * campos que o migrador colocou em OUTRAS abas (Compos/Casas/DigiMaxs/OrdCompos
    * em Page8, Montagens em Page4, PesMts em Page5) mais os labels e botoes que os
    * acompanham - duplica-los aqui criaria dois controles gravando a MESMA property
    * do BO. Ficam registrados como pendencia de re-layout, nao omitidos em silencio.
    *
    * Top = Top do legado + 29 (compensacao do pgf_4c_Paginas.Top = -29), igual ao
    * resto do form. Acentos por CHR() (regra #4). OptionGroup NAO tem ForeColor:
    * a cor vai nos Buttons (regra #33).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgProdutos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page2

        *-- lbl_etiqueta () Top=112+29=141
        loc_oPg.AddObject("lbl_4c_Etidups", "Label")
        WITH loc_oPg.lbl_4c_Etidups
            .Caption   = "Etiqueta Dupla :"
            .Top       = 141
            .Left      = 618
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- opt_descricao_produto (etidups) Top=112+29=141
        loc_oPg.AddObject("opt_4c_Etidups", "OptionGroup")
        WITH loc_oPg.opt_4c_Etidups
            .ButtonCount = 2
            .Top         = 141
            .Left        = 695
            .Width       = 116
            .Height      = 15
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 0
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 70
                .Top       = 0
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Get_CodProd (codprods) Top=125+29=154
        loc_oPg.AddObject("cbo_4c_Codprods", "ComboBox")
        WITH loc_oPg.cbo_4c_Codprods
            .Top           = 154
            .Left          = 199
            .Width         = 303
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "Manual,Grupo,Fornecedor,Identificador 8 D" + CHR(237) + "gitos,Identificador 5 D" + CHR(237) + "gitos,Codifica" + CHR(231) + CHR(227) + "o,Identificador + Fornecedor,Fornecedor + Identificador,Grupo + SubGrupo + Ident. + Classif.,Grupo + SubGrupo + 5 D" + CHR(237) + "gitos"
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Label9 () Top=129+29=158
        loc_oPg.AddObject("lbl_4c_Codprods", "Label")
        WITH loc_oPg.lbl_4c_Codprods
            .Caption   = "C" + CHR(243) + "digo Autom" + CHR(225) + "tico :"
            .Top       = 158
            .Left      = 98
            .Width     = 99
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- getMontaDescs (MontaGrDs) Top=150+29=179
        loc_oPg.AddObject("cbo_4c_Montagrds", "ComboBox")
        WITH loc_oPg.cbo_4c_Montagrds
            .Top           = 179
            .Left          = 199
            .Width         = 303
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "Composi" + CHR(231) + CHR(227) + "o,Grupo + Composi" + CHR(231) + CHR(227) + "o,SubGrupo + Composi" + CHR(231) + CHR(227) + "o,Grupo + SubGrupo + Composi" + CHR(231) + CHR(227) + "o,Manual,Grupo + Fornecedor (4 Dig.) + Ref.Forneedor,Grupo + Cor + Composi" + CHR(231) + CHR(227) + "o,Grupo + Pedras + Ouro,Grupo + Pedras,Configura" + CHR(231) + CHR(227) + "o,Grupo + SubGrupo + Ident. + Classif."
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Say2 () Top=152+29=181
        loc_oPg.AddObject("lbl_4c_Sugestaos", "Label")
        WITH loc_oPg.lbl_4c_Sugestaos
            .Caption   = "Sugest" + CHR(227) + "o de Pre" + CHR(231) + "os :"
            .Top       = 181
            .Left      = 593
            .Width     = 104
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- optSugestaos (Sugestaos) Top=152+29=181
        loc_oPg.AddObject("opt_4c_Sugestaos", "OptionGroup")
        WITH loc_oPg.opt_4c_Sugestaos
            .ButtonCount = 2
            .Value       = 2
            .Top         = 181
            .Left        = 695
            .Width       = 116
            .Height      = 15
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 0
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 70
                .Top       = 0
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Label7 () Top=154+29=183
        loc_oPg.AddObject("lbl_4c_Montagrds", "Label")
        WITH loc_oPg.lbl_4c_Montagrds
            .Caption   = "Montar Descri" + CHR(231) + CHR(227) + "o com :"
            .Top       = 183
            .Left      = 83
            .Width     = 114
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Say17 () Top=172+29=201
        loc_oPg.AddObject("lbl_4c_Pvcompos", "Label")
        WITH loc_oPg.lbl_4c_Pvcompos
            .Caption   = "Preco Composicao :"
            .Top       = 201
            .Left      = 601
            .Width     = 96
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- fwoption1 (PvCompos) Top=172+29=201
        loc_oPg.AddObject("opt_4c_Pvcompos", "OptionGroup")
        WITH loc_oPg.opt_4c_Pvcompos
            .ButtonCount = 2
            .Value       = 1
            .Top         = 201
            .Left        = 695
            .Width       = 130
            .Height      = 15
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Custo"
                .Left      = 5
                .Top       = 0
                .Width     = 46
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Venda"
                .Left      = 70
                .Top       = 0
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- cmbDscCompras (DscCompras) Top=175+29=204
        loc_oPg.AddObject("cbo_4c_Dsccompras", "ComboBox")
        WITH loc_oPg.cbo_4c_Dsccompras
            .Top           = 204
            .Left          = 199
            .Width         = 303
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "Nenhuma,Portugu" + CHR(234) + "s,Ingl" + CHR(234) + "s"
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Label1 () Top=179+29=208
        loc_oPg.AddObject("lbl_4c_Dsccompras", "Label")
        WITH loc_oPg.lbl_4c_Dsccompras
            .Caption   = "Montar Descri" + CHR(231) + CHR(227) + "o de Compra :"
            .Top       = 208
            .Left      = 50
            .Width     = 147
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Say13 () Top=193+29=222
        loc_oPg.AddObject("lbl_4c_Mkpobrigs", "Label")
        WITH loc_oPg.lbl_4c_Mkpobrigs
            .Caption   = "Markup Obrigat" + CHR(243) + "rio :"
            .Top       = 222
            .Left      = 596
            .Width     = 101
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Get_Mkp (MkpObrigs) Top=193+29=222
        loc_oPg.AddObject("opt_4c_Mkpobrigs", "OptionGroup")
        WITH loc_oPg.opt_4c_Mkpobrigs
            .ButtonCount = 2
            .Value       = 2
            .Top         = 222
            .Left        = 695
            .Width       = 116
            .Height      = 15
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 0
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 70
                .Top       = 0
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- get_atupreco (atucomps) Top=200+29=229
        loc_oPg.AddObject("cbo_4c_Atucomps", "ComboBox")
        WITH loc_oPg.cbo_4c_Atucomps
            .Top           = 229
            .Left          = 199
            .Width         = 72
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- get_bpeso (bpesos) Top=200+29=229
        loc_oPg.AddObject("cbo_4c_Bpesos", "ComboBox")
        WITH loc_oPg.cbo_4c_Bpesos
            .Top           = 229
            .Left          = 422
            .Width         = 80
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o,Peso"
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Label3 () Top=204+29=233
        loc_oPg.AddObject("lbl_4c_Atucomps", "Label")
        WITH loc_oPg.lbl_4c_Atucomps
            .Caption   = "Atualiza Pre" + CHR(231) + "o Composi" + CHR(231) + CHR(227) + "o :"
            .Top       = 233
            .Left      = 60
            .Width     = 137
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Label6 () Top=204+29=233
        loc_oPg.AddObject("lbl_4c_Bpesos", "Label")
        WITH loc_oPg.lbl_4c_Bpesos
            .Caption   = "Base de Peso :"
            .Top       = 233
            .Left      = 347
            .Width     = 73
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Get_fornobri (fornecs) Top=225+29=254
        loc_oPg.AddObject("cbo_4c_Fornecs", "ComboBox")
        WITH loc_oPg.cbo_4c_Fornecs
            .Top           = 254
            .Left          = 422
            .Width         = 80
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o"
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Label4 () Top=229+29=258
        loc_oPg.AddObject("lbl_4c_Fornecs", "Label")
        WITH loc_oPg.lbl_4c_Fornecs
            .Caption   = "Fornecedor Obrigat" + CHR(243) + "rio :"
            .Top       = 258
            .Left      = 299
            .Width     = 121
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Say19 () Top=255+29=284
        loc_oPg.AddObject("lbl_4c_Chkforcomp", "Label")
        WITH loc_oPg.lbl_4c_Chkforcomp
            .Caption   = "Fornec. X Compos. :"
            .Top       = 284
            .Left      = 597
            .Width     = 100
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- fwoption2 (chkforcomp) Top=255+29=284
        loc_oPg.AddObject("opt_4c_Chkforcomp", "OptionGroup")
        WITH loc_oPg.opt_4c_Chkforcomp
            .ButtonCount = 2
            .Value       = 2
            .Top         = 284
            .Left        = 695
            .Width       = 116
            .Height      = 15
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 0
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 70
                .Top       = 0
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Say31 () Top=274+29=303
        loc_oPg.AddObject("lbl_4c_Respcads", "Label")
        WITH loc_oPg.lbl_4c_Respcads
            .Caption   = "Calcula Peso Compos. :"
            .Top       = 303
            .Left      = 583
            .Width     = 114
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Get_RespCad (respcads) Top=274+29=303
        loc_oPg.AddObject("opt_4c_Respcads", "OptionGroup")
        WITH loc_oPg.opt_4c_Respcads
            .ButtonCount = 2
            .Value       = 2
            .Top         = 303
            .Left        = 695
            .Width       = 116
            .Height      = 15
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 0
                .Width     = 34
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 70
                .Top       = 0
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Get_PCV (pcustvens) Top=275+29=304
        loc_oPg.AddObject("txt_4c_Pcustvens", "TextBox")
        WITH loc_oPg.txt_4c_Pcustvens
            .Value         = 0
            .Top           = 304
            .Left          = 199
            .Width         = 72
            .Height        = 23
            .Format        = "K"
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Get_cusFeitio (Coefs) Top=275+29=304
        loc_oPg.AddObject("txt_4c_Coefs", "TextBox")
        WITH loc_oPg.txt_4c_Coefs
            .Value         = 0
            .Top           = 304
            .Left          = 422
            .Width         = 80
            .Height        = 23
            .Format        = "K"
            .InputMask     = "999.9999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Say15 () Top=279+29=308
        loc_oPg.AddObject("lbl_4c_Pcustvens", "Label")
        WITH loc_oPg.lbl_4c_Pcustvens
            .Caption   = "% Custo/Venda Valor :"
            .Top       = 308
            .Left      = 85
            .Width     = 112
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Say8 () Top=279+29=308
        loc_oPg.AddObject("lbl_4c_Coefs", "Label")
        WITH loc_oPg.lbl_4c_Coefs
            .Caption   = "Coef. Custo Feitio :"
            .Top       = 308
            .Left      = 324
            .Width     = 96
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- get_TipoPreco (TpCalcPs) Top=289+29=318
        loc_oPg.AddObject("opt_4c_Tpcalcps", "OptionGroup")
        WITH loc_oPg.opt_4c_Tpcalcps
            .ButtonCount = 6
            .Top         = 318
            .Left        = 695
            .Width       = 253
            .Height      = 65
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "\<Composi" + CHR(231) + CHR(227) + "o"
                .Left      = 5
                .Top       = 5
                .Width     = 75
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Custo / \<Venda"
                .Left      = 114
                .Top       = 5
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Por Moedas"
                .Left      = 5
                .Top       = 25
                .Width     = 74
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Custo x Feitio"
                .Left      = 114
                .Top       = 25
                .Width     = 84
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "Custo + Feitio"
                .Left      = 5
                .Top       = 45
                .Width     = 86
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(6)
                .Caption   = "Custo x Peso x MKP Vda"
                .Left      = 114
                .Top       = 45
                .Width     = 134
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Say12 () Top=295+29=324
        loc_oPg.AddObject("lbl_4c_Tpcalcps", "Label")
        WITH loc_oPg.lbl_4c_Tpcalcps
            .Caption   = "C" + CHR(225) + "lculo de Pre" + CHR(231) + "o :"
            .Top       = 324
            .Left      = 609
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- getPctDctLeis (pctdctleis) Top=300+29=329
        loc_oPg.AddObject("txt_4c_Pctdctleis", "TextBox")
        WITH loc_oPg.txt_4c_Pctdctleis
            .Value         = 0
            .Top           = 329
            .Left          = 199
            .Width         = 72
            .Height        = 23
            .Format        = "K"
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .ToolTipText   = "Usado na Venda Leil" + CHR(227) + "o Para Pedir Senha de Libera" + CHR(231) + CHR(227) + "o"
            .Visible       = .F.
        ENDWITH

        *-- Get_MarkAp (MarkAplics) Top=300+29=329
        loc_oPg.AddObject("txt_4c_Markaplics", "TextBox")
        WITH loc_oPg.txt_4c_Markaplics
            .Value         = 0
            .Top           = 329
            .Left          = 422
            .Width         = 80
            .Height        = 23
            .Format        = "K"
            .InputMask     = "999.999999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Say30 () Top=304+29=333
        loc_oPg.AddObject("lbl_4c_Pctdctleis", "Label")
        WITH loc_oPg.lbl_4c_Pctdctleis
            .Caption   = "% Desconto Permitido :"
            .Top       = 333
            .Left      = 82
            .Width     = 115
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- fwDescGrades () Top=322+29=351
        loc_oPg.AddObject("opt_4c_DescGrades", "OptionGroup")
        WITH loc_oPg.opt_4c_DescGrades
            .ButtonCount = 2
            .Value       = 2
            .Top         = 351
            .Left        = 193
            .Width       = 154
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                .Left      = 5
                .Top       = 5
                .Width     = 64
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Descritivo"
                .Left      = 84
                .Top       = 5
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Say32 () Top=326+29=355
        loc_oPg.AddObject("lbl_4c_DescGrades", "Label")
        WITH loc_oPg.lbl_4c_DescGrades
            .Caption   = "Grade Cadastro Produtos :"
            .Top       = 355
            .Left      = 66
            .Width     = 131
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- chkLocLivre (LocLivre) Top=349+29=378
        loc_oPg.AddObject("chk_4c_Loclivre", "CheckBox")
        WITH loc_oPg.chk_4c_Loclivre
            .Caption       = "Localiza" + CHR(231) + CHR(227) + "o Livre "
            .Value         = 0
            .Top           = 378
            .Left          = 307
            .Width         = 101
            .Height        = 15
            .Alignment     = 0
            .AutoSize      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .F.
        ENDWITH

        *-- Shape6 () Top=356+29=385
        loc_oPg.AddObject("shp_4c_LinLocLivre", "Shape")
        WITH loc_oPg.shp_4c_LinLocLivre
            .Top           = 385
            .Left          = 295
            .Width         = 13
            .Height        = 1
            .BackStyle     = 0
            .Curvature     = 0
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        *-- chkCalProCs () Top=357+29=386
        loc_oPg.AddObject("chk_4c_CalProCs", "CheckBox")
        WITH loc_oPg.chk_4c_CalProCs
            .Caption       = "N" + CHR(227) + "o Aplica Fator no C" + CHR(225) + "lculo de Custo de Produto"
            .Value         = 0
            .Top           = 386
            .Left          = 698
            .Width         = 251
            .Height        = 15
            .Alignment     = 0
            .AutoSize      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .F.
        ENDWITH

        *-- Say1 () Top=371+29=400
        loc_oPg.AddObject("lbl_4c_TitValMin", "Label")
        WITH loc_oPg.lbl_4c_TitValMin
            .Caption   = "Valores M" + CHR(237) + "nimos Para Cadastro"
            .Top       = 400
            .Left      = 24
            .Width     = 177
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Say6 () Top=371+29=400
        loc_oPg.AddObject("lbl_4c_TitObrigMoedas", "Label")
        WITH loc_oPg.lbl_4c_TitObrigMoedas
            .Caption   = "Obrigatoriedade de Moedas Cadastro"
            .Top       = 400
            .Left      = 314
            .Width     = 212
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Say22 () Top=378+29=407
        loc_oPg.AddObject("lbl_4c_TitPadraoCad", "Label")
        WITH loc_oPg.lbl_4c_TitPadraoCad
            .Caption   = "Padr" + CHR(227) + "o do Cadastro"
            .Top       = 407
            .Left      = 679
            .Width     = 113
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Shape3 () Top=386+29=415
        loc_oPg.AddObject("shp_4c_LinValMin", "Shape")
        WITH loc_oPg.shp_4c_LinValMin
            .Top           = 415
            .Left          = 24
            .Width         = 236
            .Height        = 2
            .BackStyle     = 0
            .BorderWidth   = 2
            .BorderColor   = RGB(90,90,90)
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        *-- Shape1 () Top=386+29=415
        loc_oPg.AddObject("shp_4c_LinObrigMoedas", "Shape")
        WITH loc_oPg.shp_4c_LinObrigMoedas
            .Top           = 415
            .Left          = 314
            .Width         = 305
            .Height        = 2
            .BackStyle     = 0
            .BorderWidth   = 2
            .BorderColor   = RGB(90,90,90)
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        *-- getPcus (pcuss) Top=392+29=421
        loc_oPg.AddObject("txt_4c_Pcuss", "TextBox")
        WITH loc_oPg.txt_4c_Pcuss
            .Value         = 0
            .Top           = 421
            .Left          = 143
            .Width         = 115
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .InputMask     = "99,999,999.999"
            .MaxLength     = 14
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- fwcheckbox1 (omoecs) Top=392+29=421
        loc_oPg.AddObject("chk_4c_Omoecs", "CheckBox")
        WITH loc_oPg.chk_4c_Omoecs
            .Caption       = "Pre" + CHR(231) + "o de Custo da Composi" + CHR(231) + CHR(227) + "o"
            .Value         = 0
            .Top           = 421
            .Left          = 314
            .Width         = 166
            .Height        = 15
            .Alignment     = 0
            .AutoSize      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .F.
        ENDWITH

        *-- Shape4 () Top=393+29=422
        loc_oPg.AddObject("shp_4c_LinPadraoCad", "Shape")
        WITH loc_oPg.shp_4c_LinPadraoCad
            .Top           = 422
            .Left          = 679
            .Width         = 304
            .Height        = 2
            .BackStyle     = 0
            .BorderWidth   = 2
            .BorderColor   = RGB(90,90,90)
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        *-- Say5 () Top=395+29=424
        loc_oPg.AddObject("lbl_4c_Pcuss", "Label")
        WITH loc_oPg.lbl_4c_Pcuss
            .Caption   = "Pre" + CHR(231) + "o Composi" + CHR(231) + CHR(227) + "o :"
            .Top       = 424
            .Left      = 45
            .Width     = 96
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- fwcheckbox2 (omoecusfs) Top=409+29=438
        loc_oPg.AddObject("chk_4c_Omoecusfs", "CheckBox")
        WITH loc_oPg.chk_4c_Omoecusfs
            .Caption       = "Total de Custo da Composi" + CHR(231) + CHR(227) + "o"
            .Value         = 0
            .Top           = 438
            .Left          = 314
            .Width         = 163
            .Height        = 15
            .Alignment     = 0
            .AutoSize      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .F.
        ENDWITH

        *-- getFcusto (fcustos) Top=417+29=446
        loc_oPg.AddObject("txt_4c_Fcustos", "TextBox")
        WITH loc_oPg.txt_4c_Fcustos
            .Value         = 0
            .Top           = 446
            .Left          = 143
            .Width         = 115
            .Height        = 23
            .Alignment     = 3
            .Format        = "K"
            .InputMask     = "9,999.999"
            .MaxLength     = 9
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Say7 () Top=420+29=449
        loc_oPg.AddObject("lbl_4c_Fcustos", "Label")
        WITH loc_oPg.lbl_4c_Fcustos
            .Caption   = "Fator de Custo :"
            .Top       = 449
            .Left      = 60
            .Width     = 81
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- fwcheckbox3 (omoedas) Top=426+29=455
        loc_oPg.AddObject("chk_4c_Omoedas", "CheckBox")
        WITH loc_oPg.chk_4c_Omoedas
            .Caption       = "Pre" + CHR(231) + "o Ideal de Venda"
            .Value         = 0
            .Top           = 455
            .Left          = 314
            .Width         = 120
            .Height        = 15
            .Alignment     = 0
            .AutoSize      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .F.
        ENDWITH

        *-- getCustof (custofs) Top=442+29=471
        loc_oPg.AddObject("txt_4c_Custofs", "TextBox")
        WITH loc_oPg.txt_4c_Custofs
            .Value         = 0
            .Top           = 471
            .Left          = 143
            .Width         = 115
            .Height        = 23
            .Alignment     = 3
            .InputMask     = "99,999,999.999"
            .MaxLength     = 14
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- fwcheckbox4 (omoevs) Top=443+29=472
        loc_oPg.AddObject("chk_4c_Omoevs", "CheckBox")
        WITH loc_oPg.chk_4c_Omoevs
            .Caption       = "Pre" + CHR(231) + "o Atual de Venda"
            .Value         = 0
            .Top           = 472
            .Left          = 314
            .Width         = 121
            .Height        = 15
            .Alignment     = 0
            .AutoSize      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 1
            .Visible       = .F.
        ENDWITH

        *-- Say3 () Top=445+29=474
        loc_oPg.AddObject("lbl_4c_Custofs", "Label")
        WITH loc_oPg.lbl_4c_Custofs
            .Caption   = "Total de Custo:"
            .Top       = 474
            .Left      = 65
            .Width     = 76
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- getMargem (pmargems) Top=467+29=496
        loc_oPg.AddObject("txt_4c_Pmargems", "TextBox")
        WITH loc_oPg.txt_4c_Pmargems
            .Value         = 0
            .Top           = 496
            .Left          = 143
            .Width         = 115
            .Height        = 23
            .Alignment     = 3
            .InputMask     = "999.999999"
            .MaxLength     = 6
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Say4 () Top=468+29=497
        loc_oPg.AddObject("lbl_4c_TitMateriaPrima", "Label")
        WITH loc_oPg.lbl_4c_TitMateriaPrima
            .Caption   = "Mat" + CHR(233) + "ria Prima"
            .Top       = 497
            .Left      = 314
            .Width     = 82
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Say9 () Top=470+29=499
        loc_oPg.AddObject("lbl_4c_Pmargems", "Label")
        WITH loc_oPg.lbl_4c_Pmargems
            .Caption   = "MarkUp Ideal :"
            .Top       = 499
            .Left      = 69
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Shape2 () Top=485+29=514
        loc_oPg.AddObject("shp_4c_LinMateriaPrima", "Shape")
        WITH loc_oPg.shp_4c_LinMateriaPrima
            .Top           = 514
            .Left          = 314
            .Width         = 305
            .Height        = 2
            .BackStyle     = 0
            .BorderWidth   = 2
            .BorderColor   = RGB(90,90,90)
            .SpecialEffect = 0
            .Visible       = .F.
        ENDWITH

        *-- getPvideal (pvideals) Top=492+29=521
        loc_oPg.AddObject("txt_4c_Pvideals", "TextBox")
        WITH loc_oPg.txt_4c_Pvideals
            .Value         = 0
            .Top           = 521
            .Left          = 143
            .Width         = 115
            .Height        = 23
            .Alignment     = 3
            .InputMask     = "9,999,999.99"
            .MaxLength     = 12
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Say10 () Top=495+29=524
        loc_oPg.AddObject("lbl_4c_Pvideals", "Label")
        WITH loc_oPg.lbl_4c_Pvideals
            .Caption   = "Pre" + CHR(231) + "o Ideal :"
            .Top       = 524
            .Left      = 78
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- cmbMontaDescs (MontaDescs) Top=518+29=547
        loc_oPg.AddObject("cbo_4c_Montadescs", "ComboBox")
        WITH loc_oPg.cbo_4c_Montadescs
            .Top           = 547
            .Left          = 397
            .Width         = 221
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "Qtde + Uni + Codigo, Qtde + Codigo, Uni + Codigo, Codigo, Qtde + Codigo (s/ CT),Qtde+Codigo+Peso+Unidade,Qtde + Unidade"
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .ToolTipText   = "Forma de Montagem da Mat" + CHR(233) + "ria Prima na Descri" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica do Produto"
            .Visible       = .F.
        ENDWITH

        *-- btnAtuMontas () Top=518+29=547
        loc_oPg.AddObject("cmd_4c_AtuMontas", "CommandButton")
        WITH loc_oPg.cmd_4c_AtuMontas
            .Caption       = ""
            .Top           = 547
            .Left          = 622
            .Width         = 40
            .Height        = 23
            .Picture       = gc_4c_CaminhoIcones + "geral_circulo_16.jpg"
            .Themes        = .T.
            .Visible       = .F.
        ENDWITH

        *-- lblMontaDescs () Top=522+29=551
        loc_oPg.AddObject("lbl_4c_Montadescs", "Label")
        WITH loc_oPg.lbl_4c_Montadescs
            .Caption   = "Montagem :"
            .Top       = 551
            .Left      = 336
            .Width     = 59
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- getPven (pvens) Top=542+29=571
        loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
        WITH loc_oPg.txt_4c_Pvens
            .Value         = 0
            .Top           = 571
            .Left          = 143
            .Width         = 115
            .Height        = 23
            .Alignment     = 3
            .InputMask     = "9,999,999.99"
            .MaxLength     = 14
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- getvarcustots (varcustots) Top=543+29=572
        loc_oPg.AddObject("txt_4c_Varcustots", "TextBox")
        WITH loc_oPg.txt_4c_Varcustots
            .Value         = 0
            .Top           = 572
            .Left          = 819
            .Width         = 52
            .Height        = 23
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- cmbMnCompos (MnCompos) Top=544+29=573
        loc_oPg.AddObject("cbo_4c_Mncompos", "ComboBox")
        WITH loc_oPg.cbo_4c_Mncompos
            .Top           = 573
            .Left          = 397
            .Width         = 221
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "Autom" + CHR(225) + "tica,Grupo + Classifica" + CHR(231) + CHR(227) + "o,Classifica" + CHR(231) + CHR(227) + "o Componentes,Identificado + C" + CHR(243) + "digo,Manual"
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .ToolTipText   = "Forma de Montagem do Campo Compos"
            .Visible       = .F.
        ENDWITH

        *-- Say11 () Top=545+29=574
        loc_oPg.AddObject("lbl_4c_Pvens", "Label")
        WITH loc_oPg.lbl_4c_Pvens
            .Caption   = "Pre" + CHR(231) + "o Atual :"
            .Top       = 574
            .Left      = 77
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Say35 () Top=547+29=576
        loc_oPg.AddObject("lbl_4c_Varcustots", "Label")
        WITH loc_oPg.lbl_4c_Varcustots
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o Custo  :                    %"
            .Top       = 576
            .Left      = 733
            .Width     = 155
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- Say18 () Top=548+29=577
        loc_oPg.AddObject("lbl_4c_Mncompos", "Label")
        WITH loc_oPg.lbl_4c_Mncompos
            .Caption   = "Compos :"
            .Top       = 577
            .Left      = 348
            .Width     = 47
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- getVarPesoMs (varPesoMs) Top=568+29=597
        loc_oPg.AddObject("txt_4c_Varpesoms", "TextBox")
        WITH loc_oPg.txt_4c_Varpesoms
            .Value         = 0
            .Top           = 597
            .Left          = 819
            .Width         = 52
            .Height        = 23
            .InputMask     = "999.99"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Say34 () Top=572+29=601
        loc_oPg.AddObject("lbl_4c_Varpesoms", "Label")
        WITH loc_oPg.lbl_4c_Varpesoms
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o Peso  :                    %"
            .Top       = 601
            .Left      = 738
            .Width     = 150
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC
    *==========================================================================
    * ConfigurarPgpgCodificacao - Adiciona controles restantes da aba Codificacao
    * Page8 de pgf_4c_Divisoes: Shape, labels, CommandGroup, getMontagem,
    *   atualiza grd_4c_Codificacao (RecordSource, headers, BINDEVENTs)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgCodificacao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8

        *-- Shape3: moldura da area de montagem (Top=139+29=168)
        loc_oPg.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPg.shp_4c_Shape3
            .Top           = 168
            .Left          = 488
            .Width         = 228
            .Height        = 84
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- lblMdc: "Montagem do Codigo de Produto" (Top=145+29=174)
        loc_oPg.AddObject("lbl_4c_LblMdc", "Label")
        WITH loc_oPg.lbl_4c_LblMdc
            .Caption   = "Montagem do C" + CHR(243) + "digo de Produto"
            .Top       = 174
            .Left      = 496
            .Width     = 212
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 128)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- lblErros: "A Montagem Contem Erros" (Top=199+29=228) - inicialmente oculto
        loc_oPg.AddObject("lbl_4c_LblErros", "Label")
        WITH loc_oPg.lbl_4c_LblErros
            .Caption   = "A Montagem Cont" + CHR(233) + "m Erros"
            .Top       = 228
            .Left      = 515
            .Width     = 174
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 0, 0)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- txt_4c_Montagem: preview da montagem, somente leitura (Top=166+29=195)
        loc_oPg.AddObject("txt_4c_Montagem", "TextBox")
        WITH loc_oPg.txt_4c_Montagem
            .Value         = ""
            .Top           = 195
            .Left          = 518
            .Width         = 162
            .Height        = 28
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .Alignment     = 2
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .ReadOnly      = .T.
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Montagem, "When", THIS, "MontagemWhen")

        *-- obj_4c_CmdGrade: botoes Inserir/Excluir da grade (Top=252+29=281)
        loc_oPg.AddObject("obj_4c_CmdGrade", "CommandGroup")
        WITH loc_oPg.obj_4c_CmdGrade
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Top         = 281
            .Left        = 482
            .Width       = 55
            .Height      = 100
            .Themes      = .F.
            .Visible     = .F.
            WITH .Buttons(1)
                .Caption    = ""
                .Picture    = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .Top        = 5
                .Left       = 5
                .Height     = 45
                .Width      = 45
                .Themes     = .F.
                .ToolTipText = "Inserir"
                .BackColor  = RGB(255, 255, 255)
            ENDWITH
            WITH .Buttons(2)
                .Caption    = ""
                .Picture    = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Top        = 50
                .Left       = 5
                .Height     = 45
                .Width      = 45
                .Themes     = .F.
                .ToolTipText = "Excluir"
                .BackColor  = RGB(255, 255, 255)
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdGrade.Buttons(1), "Click", THIS, "CmdGradeInserirClick")
        BINDEVENT(loc_oPg.obj_4c_CmdGrade.Buttons(2), "Click", THIS, "CmdGradeExcluirClick")

        *-- grd_4c_Codificacao: ja criado em ConfigurarAbaCodificacao()
        *-- Atualizar para modo edicao: RecordSource, headers, BINDEVENTs
        WITH loc_oPg.grd_4c_Codificacao
            .ReadOnly    = .T.
            .RecordSource = "crMontagem"
            .Column1.ControlSource = "crMontagem.Grupos"
            .Column2.ControlSource = "crMontagem.Posicoes"
            .Column3.ControlSource = "crMontagem.Digitos"
            .Column1.Header1.Caption = "Grp. de Carac."
            .Column2.Header1.Caption = "Posi" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Caption = "D" + CHR(237) + "gitos"
            .Column1.ReadOnly = .T.
            .Column2.ReadOnly = .F.
            .Column3.ReadOnly = .F.
            .Column1.Text1.ReadOnly = .T.
            .Column2.Text1.InputMask = "9"
            .Column3.Text1.InputMask = "9"
        ENDWITH
        BINDEVENT(loc_oPg.grd_4c_Codificacao, "AfterRowColChange", ;
            THIS, "GrdCodificacaoAfterRowColChange")
        BINDEVENT(loc_oPg.grd_4c_Codificacao.Column1.Text1, "Valid", ;
            THIS, "GrdCodificacaoCol1Valid")
        BINDEVENT(loc_oPg.grd_4c_Codificacao.Column2.Text1, "LostFocus", ;
            THIS, "GrdCodificacaoCol2LostFocus")
        BINDEVENT(loc_oPg.grd_4c_Codificacao.Column3.Text1, "LostFocus", ;
            THIS, "GrdCodificacaoCol3LostFocus")
        BINDEVENT(loc_oPg.grd_4c_Codificacao.Column3.Text1, "When", ;
            THIS, "GrdCodificacaoCol3When")

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * ConfigurarPgPgCompos - Finaliza aba Compos (Page9): RecordSource, headers,
    *   BINDEVENTs do grid crSigcdcpo e controles auxiliares
    * Chamada apos ConfigurarAbaComposicao() que cria os objetos base
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgPgCompos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9

        *-- Criar cursor crSigcdcpo vazio (schema de sigcdcpo)
        IF !USED("crSigcdcpo")
            CREATE CURSOR crSigcdcpo ;
                (cidchaves c(20), compos c(14), fxfins n(12,2), fxinis n(12,2), ;
                 grupos c(10), tipos c(10), valors c(2), vltps c(20))
        ENDIF

        *-- Atualizar grd_4c_Compos com RecordSource e edicao
        *-- grd_4c_Compos foi criado em ConfigurarAbaComposicao (ReadOnly=.T., sem RecordSource)
        WITH loc_oPg.grd_4c_Compos
            .RecordSource = "crSigcdcpo"
            .ReadOnly     = .F.
            .Column1.ControlSource      = "crSigcdcpo.fxinis"
            .Column1.Header1.Caption    = "Faixa Inicial"
            .Column1.Header1.FontName   = "Tahoma"
            .Column1.Header1.FontSize   = 8
            .Column1.Header1.Alignment  = 2
            .Column1.ReadOnly           = .F.
            .Column1.Text1.BorderStyle  = 0
            .Column1.Text1.Margin       = 0
            .Column2.ControlSource      = "crSigcdcpo.fxfins"
            .Column2.Header1.Caption    = "Faixa Final"
            .Column2.Header1.FontName   = "Tahoma"
            .Column2.Header1.FontSize   = 8
            .Column2.Header1.Alignment  = 2
            .Column2.ReadOnly           = .F.
            .Column2.Text1.BorderStyle  = 0
            .Column2.Text1.Margin       = 0
            .Column3.ControlSource      = "crSigcdcpo.compos"
            .Column3.Header1.Caption    = "Compos"
            .Column3.Header1.FontName   = "Tahoma"
            .Column3.Header1.FontSize   = 8
            .Column3.Header1.Alignment  = 2
            .Column3.ReadOnly           = .F.
            .Column3.Text1.BorderStyle  = 0
            .Column3.Text1.Margin       = 0
            .Column3.Text1.MaxLength    = 14
            .Column4.ControlSource      = "crSigcdcpo.vltps"
            .Column4.Header1.Caption    = "Valor Tipo"
            .Column4.Header1.FontName   = "Tahoma"
            .Column4.Header1.FontSize   = 8
            .Column4.Header1.Alignment  = 2
            .Column4.ReadOnly           = .F.
            .Column4.Text1.BorderStyle  = 0
            .Column4.Text1.Margin       = 0
            .Column4.Text1.MaxLength    = 20
        ENDWITH

        *-- BINDEVENTs para colunas do grid (fxinis, fxfins, compos, vltps)
        BINDEVENT(loc_oPg.grd_4c_Compos.Column1.Text1, "LostFocus", ;
            THIS, "ComposGridCol1LostFocus")
        BINDEVENT(loc_oPg.grd_4c_Compos.Column1.Text1, "Valid", ;
            THIS, "ComposGridCol1Valid")
        BINDEVENT(loc_oPg.grd_4c_Compos.Column2.Text1, "LostFocus", ;
            THIS, "ComposGridCol2LostFocus")
        BINDEVENT(loc_oPg.grd_4c_Compos.Column2.Text1, "Valid", ;
            THIS, "ComposGridCol2Valid")
        BINDEVENT(loc_oPg.grd_4c_Compos.Column3.Text1, "Valid", ;
            THIS, "ComposGridCol3Valid")
        BINDEVENT(loc_oPg.grd_4c_Compos.Column4.Text1, "Valid", ;
            THIS, "ComposGridCol4Valid")

        *-- BINDEVENTs para filtros: txt_4c_FiltTipo (= txtTipos legado)
        BINDEVENT(loc_oPg.cnt_4c_FiltroCompos.txt_4c_FiltTipo, "LostFocus", ;
            THIS, "TxtTiposValid")
        BINDEVENT(loc_oPg.cnt_4c_FiltroCompos.txt_4c_FiltTipo, "LostFocus", ;
            THIS, "TxtTiposLostFocus")
        BINDEVENT(loc_oPg.cnt_4c_FiltroCompos.txt_4c_FiltTipo, "When", ;
            THIS, "TxtTiposWhen")

        *-- BINDEVENTs para filtros: txt_4c_FiltPreco (= txtPreco legado)
        BINDEVENT(loc_oPg.cnt_4c_FiltroCompos.txt_4c_FiltPreco, "LostFocus", ;
            THIS, "TxtPrecoValid")
        BINDEVENT(loc_oPg.cnt_4c_FiltroCompos.txt_4c_FiltPreco, "When", ;
            THIS, "TxtPrecoWhen")

        *-- Botao Copiar Compos (cmdCopiarCompos: Top=125+29=154, Left=901, Visible=.F.)
        loc_oPg.AddObject("cmd_4c_CopiarCompos", "CommandButton")
        WITH loc_oPg.cmd_4c_CopiarCompos
            .Caption         = "Copiar um Compos"
            .Top             = 154
            .Left            = 901
            .Width           = 43
            .Height          = 43
            .Visible         = .F.
            .Themes          = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .ToolTipText     = "Copiar estrutura de composi" + CHR(231) + CHR(227) + "o de outro grupo"
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CopiarCompos, "Click", THIS, "CmdCopiarComposClick")

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * AtualizaMontagem - Calcula e exibe preview do codigo de produto
    * par_lSalvar=.T. valida e exibe erros; par_lSalvar=.F. apenas atualiza
    * Retorna .T. se OK, .F. se ha erros na montagem
    *==========================================================================
    PROCEDURE AtualizaMontagem(par_lSalvar)
        LOCAL loc_lResultado, loc_lcPro, loc_llDup, loc_llErr, loc_lnTam
        loc_lResultado = .T.
        loc_lcPro      = ""
        loc_llDup      = .F.
        loc_llErr      = .T.
        loc_lnTam      = 0

        TRY
            IF !USED("crMontagem")
                loc_lResultado = .T.
            ENDIF

            *-- Selecionar configuracoes na ordem de montagem
            SELECT Posicoes, Grupos, Digitos ;
              FROM crMontagem ;
             WHERE !EMPTY(Grupos) AND !EMPTY(Posicoes) AND !EMPTY(Digitos) ;
             ORDER BY Posicoes, Grupos, Digitos ;
              INTO CURSOR LocalMontagemTmp

            *-- Verificar posicoes duplicadas
            SELECT Posicoes, SUM(1) AS Soma ;
              FROM crMontagem ;
             WHERE !EMPTY(Grupos) AND !EMPTY(Posicoes) AND !EMPTY(Digitos) ;
             GROUP BY Posicoes ;
              INTO CURSOR LocalErros1Tmp

            *-- Verificar grupos duplicados (exceto / e .)
            SELECT Grupos, SUM(1) AS Soma ;
              FROM crMontagem ;
             WHERE !EMPTY(Grupos) AND !EMPTY(Posicoes) AND !EMPTY(Digitos) ;
                   AND !Grupos IN (PADR("/", 10), PADR(".", 10)) ;
             GROUP BY Grupos ;
              INTO CURSOR LocalErros2Tmp

            *-- Checar duplicatas de posicao
            SELECT LocalErros1Tmp
            SCAN
                IF LocalErros1Tmp.Soma > 1
                    loc_llDup = .T.
                ENDIF
            ENDSCAN

            *-- Checar duplicatas de grupo
            SELECT LocalErros2Tmp
            SCAN
                IF LocalErros2Tmp.Soma > 1
                    loc_llDup = .T.
                ENDIF
            ENDSCAN

            loc_lnTam = LEN(ALLTRIM(loc_lcPro))

            SELECT LocalMontagemTmp
            SCAN
                LOCAL loc_lnMax
                loc_lnMax = IIF(loc_lnTam + LocalMontagemTmp.Digitos <= 14, ;
                                LocalMontagemTmp.Digitos, 14 - loc_lnTam)
                loc_llErr = IIF(loc_lnTam + LocalMontagemTmp.Digitos <= 14, .F., .T.)
                loc_lnTam = loc_lnTam + loc_lnMax

                DO CASE
                    CASE LocalMontagemTmp.Grupos = PADR("/", 10)
                        loc_lcPro = loc_lcPro + "/"
                    CASE LocalMontagemTmp.Grupos = PADR(".", 10)
                        loc_lcPro = loc_lcPro + "."
                    OTHERWISE
                        loc_lcPro = loc_lcPro + ;
                            REPLICATE(STR(LocalMontagemTmp.Posicoes, 1), loc_lnMax)
                ENDCASE
            ENDSCAN

            *-- Atualizar lbl_4c_LblErros e txt_4c_Montagem
            LOCAL loc_oPg8M
            loc_oPg8M = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8
            IF PEMSTATUS(loc_oPg8M, "lbl_4c_LblErros", 5)
                loc_oPg8M.lbl_4c_LblErros.Visible = (loc_llDup OR loc_llErr)
            ENDIF
            IF PEMSTATUS(loc_oPg8M, "txt_4c_Montagem", 5)
                loc_oPg8M.txt_4c_Montagem.Value = loc_lcPro
                loc_oPg8M.txt_4c_Montagem.Refresh
            ENDIF

            *-- Se chamado para salvar, validar e mostrar erros
            IF par_lSalvar
                DO CASE
                    CASE loc_llDup
                        MsgAviso("Existe Um Grupo/Refer" + CHR(234) + "ncia/" + ;
                            "C" + CHR(243) + "digo de Posi" + CHR(231) + CHR(227) + "o Duplicado" + ;
                            CHR(13) + "na Grade de Codifica" + CHR(231) + CHR(227) + ;
                            "o de Caracter" + CHR(237) + "sticas!!!")
                        loc_lResultado = .F.
                    CASE loc_llErr
                        IF RECCOUNT("LocalMontagemTmp") > 0
                            MsgAviso("A Soma Dos D" + CHR(237) + "gitos na Grade de " + ;
                                "Codifica" + CHR(231) + CHR(227) + "o" + CHR(13) + ;
                                "Ultrapassou o Limite de 10 Caracteres!!!")
                        ELSE
                            MsgAviso("Nenhum Grupo de Caracter" + CHR(237) + "stica " + ;
                                "Foi Selecionado" + CHR(13) + ;
                                "na Grade de Codifica" + CHR(231) + CHR(227) + ;
                                "o!!! Verifique os Dados!!!")
                        ENDIF
                        loc_lResultado = .F.
                ENDCASE
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em AtualizaMontagem:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormGpd")
            loc_lResultado = .F.
        ENDTRY

        IF USED("LocalMontagemTmp")
            USE IN LocalMontagemTmp
        ENDIF
        IF USED("LocalErros1Tmp")
            USE IN LocalErros1Tmp
        ENDIF
        IF USED("LocalErros2Tmp")
            USE IN LocalErros2Tmp
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * GrdCodificacaoAfterRowColChange - Atualiza preview ao mudar linha/coluna
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE GrdCodificacaoAfterRowColChange(par_nColIndex)
        THIS.AtualizaMontagem(.F.)
    ENDPROC

    *==========================================================================
    * GrdCodificacaoCol1Valid - Valida grupo de caracteristica digitado
    * Faz LOCATE em crGrpMonta; se nao encontrar, limpa o campo
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE GrdCodificacaoCol1Valid()
        LOCAL loc_lcGru, loc_oTxt, loc_lResultado
        loc_lResultado = .T.
        loc_oTxt = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8.grd_4c_Codificacao.Column1.Text1

        TRY
            loc_lcGru = PADR(ALLTRIM(loc_oTxt.Value), 10)

            IF !EMPTY(loc_lcGru) AND USED("crGrpMonta")
                SELECT crGrpMonta
                GO TOP IN crGrpMonta
                LOCATE FOR Grupos = loc_lcGru
                IF EOF("crGrpMonta")
                    MsgAviso("Grupo '" + ALLTRIM(loc_lcGru) + "' n" + CHR(227) + ;
                        "o encontrado na lista de grupos de montagem.")
                    loc_oTxt.Value = ""
                ELSE
                    loc_oTxt.Value = crGrpMonta.Grupos
                ENDIF
            ENDIF

            *-- Se barra ou ponto, forcar Digitos=1
            IF USED("crMontagem") AND INLIST(loc_oTxt.Value, PADR("/", 10), PADR(".", 10))
                REPLACE Digitos WITH 1 IN crMontagem
            ENDIF

            loc_oTxt.Refresh
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.GrdCodificacaoCol1Valid")
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * GrdCodificacaoCol2LostFocus - Auto-avanca para proxima linha ao sair
    * Aplica somente em INCLUIR/ALTERAR quando Grupos = PADR("/",10)
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE GrdCodificacaoCol2LostFocus()
        LOCAL loc_oPg8
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("crMontagem")
            RETURN
        ENDIF
        IF !(crMontagem.Grupos = PADR("/", 10))
            RETURN
        ENDIF
        IF !INLIST(LASTKEY(), 13, 49, 50, 51, 52, 53, 54, 55, 56, 57)
            RETURN
        ENDIF

        TRY
            IF !EOF("crMontagem") AND !EMPTY(crMontagem.Grupos) AND ;
               !EMPTY(crMontagem.Posicoes) AND !EMPTY(crMontagem.Digitos)
                SKIP IN crMontagem
            ENDIF
            IF EOF("crMontagem")
                INSERT INTO crMontagem (Grupos) VALUES ("")
                GO BOTTOM IN crMontagem
            ENDIF
            loc_oPg8 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8
            IF PEMSTATUS(loc_oPg8, "grd_4c_Codificacao", 5)
                loc_oPg8.grd_4c_Codificacao.Refresh
            ENDIF
            KEYBOARD "{DNARROW}"
        CATCH TO loc_oErro
            MsgErro("Erro em Col2LostFocus:" + CHR(13) + loc_oErro.Message, "FormGpd")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdCodificacaoCol3LostFocus - Auto-avanca ao sair de Digitos
    * CONJUNTO sempre fica com Digitos=6 (regra de negocio legada)
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE GrdCodificacaoCol3LostFocus()
        LOCAL loc_oPg8
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF
        IF !USED("crMontagem")
            RETURN
        ENDIF
        IF !INLIST(LASTKEY(), 13, 49, 50, 51, 52, 53, 54, 55, 56, 57)
            RETURN
        ENDIF

        TRY
            *-- CONJUNTO sempre tem tamanho 6
            IF crMontagem.Grupos = PADR("CONJUNTO", 10)
                REPLACE Digitos WITH 6 IN crMontagem
            ENDIF

            IF !EOF("crMontagem") AND !EMPTY(crMontagem.Grupos) AND ;
               !EMPTY(crMontagem.Posicoes) AND !EMPTY(crMontagem.Digitos)
                SKIP IN crMontagem
            ENDIF
            IF EOF("crMontagem")
                INSERT INTO crMontagem (Grupos) VALUES ("")
                GO BOTTOM IN crMontagem
            ENDIF
            loc_oPg8 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8
            IF PEMSTATUS(loc_oPg8, "grd_4c_Codificacao", 5)
                loc_oPg8.grd_4c_Codificacao.Refresh
            ENDIF
            KEYBOARD "{DNARROW}"
        CATCH TO loc_oErro
            MsgErro("Erro em Col3LostFocus:" + CHR(13) + loc_oErro.Message, "FormGpd")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GrdCodificacaoCol3When - Coluna Digitos somente para grupos reais
    * Retorna .F. para barra/ponto (Digitos fixo=1, nao editavel)
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE GrdCodificacaoCol3When()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN .F.
        ENDIF
        IF !USED("crMontagem")
            RETURN .F.
        ENDIF
        RETURN !(crMontagem.Grupos = PADR("/", 10))
    ENDPROC

    *==========================================================================
    * MontagemWhen - txt_4c_Montagem sempre somente leitura
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE MontagemWhen()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * CmdGradeInserirClick - Insere nova linha em branco em crMontagem
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE CmdGradeInserirClick()
        LOCAL loc_oPg8
        IF !USED("crMontagem")
            RETURN
        ENDIF

        TRY
            loc_oPg8 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8

            GO TOP IN crMontagem
            IF PEMSTATUS(loc_oPg8, "grd_4c_Codificacao", 5)
                loc_oPg8.grd_4c_Codificacao.Refresh
            ENDIF
            GO BOTTOM IN crMontagem

            IF EOF("crMontagem") OR ;
               (!EOF("crMontagem") AND !EMPTY(crMontagem.Grupos) AND ;
                !EMPTY(crMontagem.Posicoes) AND !EMPTY(crMontagem.Digitos))
                INSERT INTO crMontagem (Grupos) VALUES ("")
                GO BOTTOM IN crMontagem
                IF PEMSTATUS(loc_oPg8, "grd_4c_Codificacao", 5)
                    loc_oPg8.grd_4c_Codificacao.Refresh
                ENDIF
            ENDIF

            IF PEMSTATUS(loc_oPg8, "grd_4c_Codificacao", 5)
                loc_oPg8.grd_4c_Codificacao.Column1.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir linha:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.CmdGradeInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdGradeExcluirClick - Exclui linha atual de crMontagem
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE CmdGradeExcluirClick()
        LOCAL loc_oPg8
        IF !USED("crMontagem")
            RETURN
        ENDIF

        TRY
            loc_oPg8 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page8

            IF PEMSTATUS(loc_oPg8, "grd_4c_Codificacao", 5)
                loc_oPg8.grd_4c_Codificacao.Refresh
            ENDIF

            IF !EOF("crMontagem")
                DELETE IN crMontagem
            ENDIF

            GO TOP IN crMontagem
            IF PEMSTATUS(loc_oPg8, "grd_4c_Codificacao", 5)
                loc_oPg8.grd_4c_Codificacao.Refresh
            ENDIF
            GO BOTTOM IN crMontagem

            IF EOF("crMontagem") OR ;
               (!EOF("crMontagem") AND !EMPTY(crMontagem.Grupos) AND ;
                !EMPTY(crMontagem.Posicoes) AND !EMPTY(crMontagem.Digitos))
                INSERT INTO crMontagem (Grupos) VALUES ("")
                GO BOTTOM IN crMontagem
                IF PEMSTATUS(loc_oPg8, "grd_4c_Codificacao", 5)
                    loc_oPg8.grd_4c_Codificacao.Refresh
                ENDIF
            ENDIF

            IF PEMSTATUS(loc_oPg8, "grd_4c_Codificacao", 5)
                loc_oPg8.grd_4c_Codificacao.Column1.SetFocus
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir linha:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.CmdGradeExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ComposGridCol1LostFocus - fxinis LostFocus: auto-calcula fxfins sugerido
    * Formula: valorFinal = fxinis + fxinis * 0.5. Atualiza Column2 se ainda zero.
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE ComposGridCol1LostFocus()
        LOCAL loc_oPg9, loc_nValor, loc_nValorFinal, loc_lProsseguir
        loc_oPg9 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9

        loc_lProsseguir = .T.
        TRY
            IF !USED("crSigcdcpo")
                loc_lProsseguir = .F.
            ENDIF
            IF loc_lProsseguir
                loc_nValor      = 0
                loc_nValorFinal = 0
                IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                    loc_nValor      = loc_oPg9.grd_4c_Compos.Column1.Text1.Value
                    loc_nValorFinal = loc_nValor + loc_nValor * 0.5
                    IF crSigcdcpo.fxfins = 0
                        loc_oPg9.grd_4c_Compos.Column2.Text1.Value = loc_nValorFinal
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao calcular faixa final:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.ComposGridCol1LostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ComposGridCol1Valid - fxinis Valid: valida que nao esta sobreposto
    * Retorna .F. se valor = 0 ou intervalo ja coberto por outro registro
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE ComposGridCol1Valid()
        LOCAL loc_lResultado, loc_oPg9, loc_nVal, loc_cVltp, loc_nReg
        loc_lResultado = .T.
        loc_oPg9       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9

        TRY
            IF !USED("crSigcdcpo")
                loc_lResultado = .T.
            ENDIF
            loc_nVal  = 0
            loc_cVltp = ""
            loc_nReg  = 0
            IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                loc_nVal = loc_oPg9.grd_4c_Compos.Column1.Text1.Value
            ENDIF

            IF !EMPTY(crSigcdcpo.vltps) AND loc_nVal = 0
                MsgAviso("Faixa Inicial n" + CHR(227) + "o informada !!!")
                loc_lResultado = .F.
            ENDIF

            IF loc_lResultado AND loc_nVal = 0
                MsgAviso("Valor n" + CHR(227) + "o pode ser zero !!!")
                loc_lResultado = .F.
            ENDIF

            IF loc_lResultado AND USED("crSigcdcpo")
                loc_cVltp = ALLTRIM(crSigcdcpo.vltps)
                loc_nReg  = RECNO("crSigcdcpo")
                SELECT * FROM crSigcdcpo ;
                    WHERE fxinis <= loc_nVal AND fxfins > loc_nVal ;
                    AND ALLTRIM(vltps) = loc_cVltp AND RECNO() <> loc_nReg ;
                    INTO CURSOR crComposCurTmp
                SELECT crComposCurTmp
                GO TOP IN crComposCurTmp
                IF !EOF("crComposCurTmp")
                    MsgAviso("Este valor de faixa inicial j" + CHR(225) + " est" + CHR(225) + ;
                        " coberto por outro intervalo.")
                    loc_lResultado = .F.
                ENDIF
                IF USED("crComposCurTmp")
                    USE IN crComposCurTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar faixa inicial:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.ComposGridCol1Valid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ComposGridCol2LostFocus - fxfins LostFocus: valida sobreposicao de faixas
    * Exibe aviso se intervalo [fxinis,fxfins] se sobrep a outro registro
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE ComposGridCol2LostFocus()
        LOCAL loc_lResultado, loc_nValI, loc_nValF, loc_cVltp, loc_nReg, loc_lProsseguir
        loc_lResultado = .T.

        loc_lProsseguir = .T.
        TRY
            IF !USED("crSigcdcpo")
                loc_lProsseguir = .F.
            ENDIF
            IF loc_lProsseguir
                loc_nValI = crSigcdcpo.fxinis
                loc_nValF = crSigcdcpo.fxfins
                loc_cVltp = ALLTRIM(crSigcdcpo.vltps)
                loc_nReg  = RECNO("crSigcdcpo")

                SELECT * FROM crSigcdcpo ;
                    WHERE (fxinis <= loc_nValF AND fxfins > loc_nValF ;
                        AND ALLTRIM(vltps) = loc_cVltp AND RECNO() <> loc_nReg) ;
                    OR (fxinis BETWEEN loc_nValI AND loc_nValF ;
                        AND ALLTRIM(vltps) = loc_cVltp AND RECNO() <> loc_nReg) ;
                    OR (fxfins BETWEEN loc_nValI AND loc_nValF ;
                        AND ALLTRIM(vltps) = loc_cVltp AND RECNO() <> loc_nReg) ;
                    INTO CURSOR crComposFfTmp
                SELECT crComposFfTmp
                GO TOP IN crComposFfTmp
                IF !EOF("crComposFfTmp")
                    MsgAviso("Este valor de faixa final est" + CHR(225) + " sobreposto com outro intervalo.")
                ENDIF
                IF USED("crComposFfTmp")
                    USE IN crComposFfTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar faixa final:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.ComposGridCol2LostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ComposGridCol2Valid - fxfins Valid: valida minimo e maximo
    * Retorna .F. se menor que fxinis ou maior que permitido
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE ComposGridCol2Valid()
        LOCAL loc_lResultado, loc_oPg9, loc_nValF, loc_nVlMax
        loc_lResultado = .T.
        loc_oPg9       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9

        TRY
            IF !USED("crSigcdcpo")
                loc_lResultado = .T.
            ENDIF
            loc_nValF = 0
            IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                loc_nValF = loc_oPg9.grd_4c_Compos.Column2.Text1.Value
            ENDIF

            IF !EMPTY(crSigcdcpo.vltps) AND loc_nValF = 0
                MsgAviso("Faixa Final n" + CHR(227) + "o informada !!!")
                loc_lResultado = .F.
            ENDIF

            IF loc_lResultado AND loc_nValF < crSigcdcpo.fxinis
                MsgAviso("Faixa Final n" + CHR(227) + "o pode ser menor que a faixa inicial !!!")
                loc_lResultado = .F.
            ENDIF

            *-- Valida maximo apenas se fxinis >= 50
            IF loc_lResultado AND crSigcdcpo.fxinis >= 50
                loc_nVlMax = loc_nValF + crSigcdcpo.fxinis * 0.5
                IF loc_nValF > loc_nVlMax
                    MsgAviso("Faixa Final excede o valor m" + CHR(225) + "ximo permitido !!!")
                    loc_lResultado = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar faixa final:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.ComposGridCol2Valid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ComposGridCol3Valid - compos Valid: valida unicidade local e no servidor
    * Retorna .F. se ja existe um compos com mesmo codigo no grupo
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE ComposGridCol3Valid()
        LOCAL loc_lResultado, loc_oPg9, loc_cVal, loc_nReg, loc_cSql, loc_nRet
        loc_lResultado = .T.
        loc_oPg9       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9

        TRY
            IF LASTKEY() = 27
                loc_lResultado = .T.
            ENDIF

            IF !USED("crSigcdcpo")
                loc_lResultado = .T.
            ENDIF

            loc_cVal = ""
            IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                loc_cVal = ALLTRIM(loc_oPg9.grd_4c_Compos.Column3.Text1.Value)
            ENDIF

            *-- Verificar unicidade local no cursor
            loc_nReg = RECNO("crSigcdcpo")
            SELECT crSigcdcpo
            LOCATE FOR ALLTRIM(compos) = loc_cVal AND RECNO() <> loc_nReg
            IF !EOF("crSigcdcpo")
                MsgAviso("O valor " + loc_cVal + " j" + CHR(225) + ;
                    " foi informado para esse grupo !!!")
                GO loc_nReg IN crSigcdcpo
                loc_lResultado = .F.
            ENDIF
            GO loc_nReg IN crSigcdcpo

            *-- Verificar unicidade no servidor (excluindo o registro atual)
            IF loc_lResultado AND !EMPTY(loc_cVal)
                loc_cSql = "SELECT * FROM sigcdcpo WHERE compos = " + ;
                    EscaparSQL(loc_cVal) + ;
                    " AND cidchaves <> " + EscaparSQL(ALLTRIM(crSigcdcpo.cidchaves))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "crComposUniTmp")
                IF loc_nRet > 0 AND RECCOUNT("crComposUniTmp") > 0
                    MsgAviso("O valor " + loc_cVal + ;
                        " j" + CHR(225) + " existe em outro registro no banco de dados !!!")
                    loc_lResultado = .F.
                ENDIF
                IF USED("crComposUniTmp")
                    USE IN crComposUniTmp
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar compos:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.ComposGridCol3Valid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ComposGridCol4Valid - vltps Valid: lookup por tipo (MODELO/CLASSIFICA/SUBGRUPO/LINHA)
    * Abre FormBuscaAuxiliar na tabela correspondente ao tipo informado
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE ComposGridCol4Valid()
        LOCAL loc_lResultado, loc_oPg9, loc_cTipo, loc_cVal, loc_oBusca
        LOCAL loc_cSql, loc_nRet, loc_cCgrus
        loc_lResultado = .T.
        loc_oPg9       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9

        TRY
            IF LASTKEY() = 27
                loc_lResultado = .T.
            ENDIF

            IF !USED("crSigcdcpo")
                loc_lResultado = .T.
            ENDIF

            loc_cTipo = ""
            loc_cVal  = ""
            loc_cCgrus = ALLTRIM(THIS.this_oBusinessObject.this_cCgrus)

            IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltTipo", 5)
                loc_cTipo = ALLTRIM(loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltTipo.Value)
            ENDIF
            IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                loc_cVal = ALLTRIM(loc_oPg9.grd_4c_Compos.Column4.Text1.Value)
            ENDIF

            DO CASE
            CASE loc_cTipo = "MODELO"
                *-- Busca em SigCdFip (Cods, Descs)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdFip", "cursor_4c_BuscaSigCdFip", "Cods", ;
                    loc_cVal, "Modelo")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    IF !loc_oBusca.this_lSelecionou
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSigCdFip")
                        SELECT cursor_4c_BuscaSigCdFip
                        IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                            loc_oPg9.grd_4c_Compos.Column4.Text1.Value = ;
                                ALLTRIM(cursor_4c_BuscaSigCdFip.Cods)
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaSigCdFip")
                    USE IN cursor_4c_BuscaSigCdFip
                ENDIF

            CASE loc_cTipo = "CLASSIFICA"
                *-- Busca em SigCdCls (Cods, Descs)
                loc_cSql = "SELECT a.Cods, a.Descs FROM SigCdCls a"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "crSigCdClsTmp")
                IF loc_nRet > 0 AND USED("crSigCdClsTmp")
                    *-- Tentar localizar o valor atual
                    SELECT crSigCdClsTmp
                    LOCATE FOR PADR(ALLTRIM(Cods), 3) = PADR(loc_cVal, 3)
                    IF !EOF("crSigCdClsTmp")
                        IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                            loc_oPg9.grd_4c_Compos.Column4.Text1.Value = ;
                                ALLTRIM(crSigCdClsTmp.Cods)
                        ENDIF
                    ELSE
                        *-- Nao encontrou: abrir picker
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle)
                        IF VARTYPE(loc_oBusca) = "O"
                            GO TOP IN crSigCdClsTmp
                            loc_oBusca.DefinirCursor("crSigCdClsTmp", "Cods", "Descs", ;
                                "Classifica" + CHR(231) + CHR(227) + "o")
                            loc_oBusca.Mostrar()
                            IF loc_oBusca.this_lSelecionou AND USED("crSigCdClsTmp")
                                SELECT crSigCdClsTmp
                                IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                                    loc_oPg9.grd_4c_Compos.Column4.Text1.Value = ;
                                        ALLTRIM(crSigCdClsTmp.Cods)
                                ENDIF
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                ELSE
                    MsgErro("Falha ao carregar classifica" + CHR(231) + CHR(245) + "es.", ;
                        "FormGpd.ComposGridCol4Valid")
                ENDIF
                IF USED("crSigCdClsTmp")
                    USE IN crSigCdClsTmp
                ENDIF

            CASE loc_cTipo = "SUBGRUPO"
                *-- Busca em SigCdPsg (Codigos, Descricaos) do grupo atual
                loc_cSql = "SELECT Codigos, Descricaos FROM SigCdPsg " + ;
                    "WHERE cgrus = " + EscaparSQL(loc_cCgrus) + ;
                    " ORDER BY Descricaos"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "crPsgTmp")
                IF loc_nRet > 0 AND USED("crPsgTmp")
                    SELECT crPsgTmp
                    LOCATE FOR ALLTRIM(Codigos) = loc_cVal
                    IF !EOF("crPsgTmp")
                        IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                            loc_oPg9.grd_4c_Compos.Column4.Text1.Value = ;
                                ALLTRIM(crPsgTmp.Codigos)
                        ENDIF
                    ELSE
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle)
                        IF VARTYPE(loc_oBusca) = "O"
                            GO TOP IN crPsgTmp
                            loc_oBusca.DefinirCursor("crPsgTmp", "Codigos", "Descricaos", ;
                                "Sub-Grupo")
                            loc_oBusca.Mostrar()
                            IF loc_oBusca.this_lSelecionou AND USED("crPsgTmp")
                                SELECT crPsgTmp
                                IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                                    loc_oPg9.grd_4c_Compos.Column4.Text1.Value = ;
                                        ALLTRIM(crPsgTmp.Codigos)
                                ENDIF
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                ELSE
                    MsgErro("Falha ao carregar sub-grupos.", "FormGpd.ComposGridCol4Valid")
                ENDIF
                IF USED("crPsgTmp")
                    USE IN crPsgTmp
                ENDIF

            CASE loc_cTipo = "LINHA"
                *-- Busca em SigCdLin (Linhas, Descs)
                loc_cSql = "SELECT a.Linhas, a.Descs FROM SigCdLin a"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "crLinTmp")
                IF loc_nRet > 0 AND USED("crLinTmp")
                    SELECT crLinTmp
                    LOCATE FOR ALLTRIM(Linhas) = loc_cVal
                    IF !EOF("crLinTmp")
                        IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                            loc_oPg9.grd_4c_Compos.Column4.Text1.Value = ;
                                ALLTRIM(crLinTmp.Linhas)
                        ENDIF
                    ELSE
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle)
                        IF VARTYPE(loc_oBusca) = "O"
                            GO TOP IN crLinTmp
                            loc_oBusca.DefinirCursor("crLinTmp", "Linhas", "Descs", ;
                                "Linha")
                            loc_oBusca.Mostrar()
                            IF loc_oBusca.this_lSelecionou AND USED("crLinTmp")
                                SELECT crLinTmp
                                IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                                    loc_oPg9.grd_4c_Compos.Column4.Text1.Value = ;
                                        ALLTRIM(crLinTmp.Linhas)
                                ENDIF
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                    ENDIF
                ELSE
                    MsgErro("Falha ao carregar linhas.", "FormGpd.ComposGridCol4Valid")
                ENDIF
                IF USED("crLinTmp")
                    USE IN crLinTmp
                ENDIF

            OTHERWISE
                *-- Tipo nao reconhecido: nao faz nada, aceita o valor
            ENDCASE
        CATCH TO loc_oErro
            MsgErro("Erro ao validar valor tipo:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.ComposGridCol4Valid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * TxtTiposValid - Valida tipo informado em txt_4c_FiltTipo
    * Valores validos: MODELO, CLASSIFICA, SUBGRUPO, LINHA
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TxtTiposValid()
        LOCAL loc_lResultado, loc_cVal, loc_oBusca, loc_oPg9
        loc_lResultado = .T.
        loc_oPg9       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9

        TRY
            IF LASTKEY() = 27
                loc_lResultado = .T.
            ENDIF

            loc_cVal = ""
            IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltTipo", 5)
                loc_cVal = ALLTRIM(loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltTipo.Value)
            ENDIF

            IF EMPTY(loc_cVal)
                MsgAviso("Informe o tipo !!!")
                loc_lResultado = .F.
            ENDIF

            IF loc_lResultado AND !INLIST(loc_cVal, "MODELO", "CLASSIFICA", "SUBGRUPO", "LINHA")
                *-- Tipo invalido: mostrar picker com opcoes
                CREATE CURSOR crTiposPicker (codigo c(10), descricao c(30))
                INSERT INTO crTiposPicker VALUES ("MODELO",     "MODELO")
                INSERT INTO crTiposPicker VALUES ("CLASSIFICA", "CLASSIFICA")
                INSERT INTO crTiposPicker VALUES ("SUBGRUPO",   "SUBGRUPO")
                INSERT INTO crTiposPicker VALUES ("LINHA",      "LINHA")
                GO TOP IN crTiposPicker

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle)
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("crTiposPicker", "codigo", "descricao", "Tipo")
                    loc_oBusca.Mostrar()
                    IF loc_oBusca.this_lSelecionou AND USED("crTiposPicker")
                        SELECT crTiposPicker
                        IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltTipo", 5)
                            loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltTipo.Value = ;
                                ALLTRIM(crTiposPicker.codigo)
                        ENDIF
                    ELSE
                        loc_lResultado = .F.
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("crTiposPicker")
                    USE IN crTiposPicker
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar tipo:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.TxtTiposValid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * TxtTiposLostFocus - Propaga tipo para todas as linhas do crSigcdcpo
    * E foca na coluna vltps (Column4) para preenchimento
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TxtTiposLostFocus()
        LOCAL loc_oPg9, loc_cTipo, loc_cCgrus, loc_lProsseguir
        loc_oPg9  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9
        loc_cTipo = ""
        loc_cCgrus = ALLTRIM(THIS.this_oBusinessObject.this_cCgrus)

        loc_lProsseguir = .T.
        TRY
            IF !USED("crSigcdcpo")
                loc_lProsseguir = .F.
            ENDIF
            IF loc_lProsseguir
                IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltTipo", 5)
                    loc_cTipo = ALLTRIM(loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltTipo.Value)
                ENDIF
                SELECT crSigcdcpo
                REPLACE ALL grupos WITH loc_cCgrus IN crSigcdcpo
                REPLACE ALL tipos  WITH loc_cTipo  IN crSigcdcpo
                IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                    loc_oPg9.grd_4c_Compos.Column4.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao propagar tipo:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.TxtTiposLostFocus")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtTiposWhen - Permite edicao do tipo apenas se nenhum registro foi salvo
    * Retorna .T. (editavel) se nao ha cidchaves preenchidas no cursor
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TxtTiposWhen()
        LOCAL loc_lEditavel, loc_nQr
        loc_lEditavel = .T.
        loc_nQr       = 0

        TRY
            IF USED("crSigcdcpo")
                SELECT crSigcdcpo
                COUNT FOR !EMPTY(cidchaves) TO loc_nQr
                loc_lEditavel = (loc_nQr = 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TxtTiposWhen:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.TxtTiposWhen")
        ENDTRY

        RETURN loc_lEditavel
    ENDPROC

    *==========================================================================
    * TxtPrecoValid - Valida preco informado em txt_4c_FiltPreco
    * Valores validos: PC (Preco Custo), PV (Preco Venda)
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TxtPrecoValid()
        LOCAL loc_lResultado, loc_cVal, loc_oBusca, loc_oPg9
        loc_lResultado = .T.
        loc_oPg9       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9

        TRY
            IF LASTKEY() = 27
                loc_lResultado = .T.
            ENDIF

            loc_cVal = ""
            IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltPreco", 5)
                loc_cVal = ALLTRIM(loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltPreco.Value)
            ENDIF

            IF EMPTY(loc_cVal)
                MsgAviso("Pre" + CHR(231) + "o n" + CHR(227) + "o informado !!!")
                loc_lResultado = .F.
            ENDIF

            IF loc_lResultado AND !INLIST(loc_cVal, "PC", "PV")
                *-- Preco invalido: mostrar picker
                CREATE CURSOR crPrecosPicker (codigo c(3), descricao c(30))
                INSERT INTO crPrecosPicker VALUES ("PC", "PRE" + CHR(199) + "O CUSTO")
                INSERT INTO crPrecosPicker VALUES ("PV", "PRE" + CHR(199) + "O VENDA")
                GO TOP IN crPrecosPicker

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle)
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("crPrecosPicker", "codigo", "descricao", ;
                        "Tipo de Pre" + CHR(231) + "o")
                    loc_oBusca.Mostrar()
                    IF loc_oBusca.this_lSelecionou AND USED("crPrecosPicker")
                        SELECT crPrecosPicker
                        IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltPreco", 5)
                            loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltPreco.Value = ;
                                ALLTRIM(crPrecosPicker.codigo)
                        ENDIF
                    ELSE
                        loc_lResultado = .F.
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("crPrecosPicker")
                    USE IN crPrecosPicker
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar pre" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.TxtPrecoValid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * TxtPrecoWhen - Permite edicao do preco apenas se nenhum registro foi salvo
    * Igual a TxtTiposWhen
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE TxtPrecoWhen()
        LOCAL loc_lEditavel, loc_nQr
        loc_lEditavel = .T.
        loc_nQr       = 0

        TRY
            IF USED("crSigcdcpo")
                SELECT crSigcdcpo
                COUNT FOR !EMPTY(cidchaves) TO loc_nQr
                loc_lEditavel = (loc_nQr = 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em TxtPrecoWhen:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.TxtPrecoWhen")
        ENDTRY

        RETURN loc_lEditavel
    ENDPROC

    *==========================================================================
    * BtnComposInserirClick - Insere nova linha em branco em crSigcdcpo
    * Exige tipo e preco informados; foca Column4 (vltps) para edicao
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnComposInserirClick()
        LOCAL loc_oPg9, loc_cTipo, loc_cPreco, loc_cCgrus, loc_lProsseguir
        loc_oPg9  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9
        loc_cTipo  = ""
        loc_cPreco = ""
        loc_cCgrus = ALLTRIM(THIS.this_oBusinessObject.this_cCgrus)

        loc_lProsseguir = .T.
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !USED("crSigcdcpo")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltPreco", 5)
                    loc_cPreco = ALLTRIM(loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltPreco.Value)
                ENDIF
                IF EMPTY(loc_cPreco)
                    MsgAviso("Informe o Tipo Pre" + CHR(231) + "o !!!")
                    IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltPreco", 5)
                        loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltPreco.SetFocus
                    ENDIF
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltTipo", 5)
                    loc_cTipo = ALLTRIM(loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltTipo.Value)
                ENDIF
                IF EMPTY(loc_cTipo)
                    MsgAviso("Informe o tipo antes de inserir registros !!!")
                    IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltTipo", 5)
                        loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltTipo.SetFocus
                    ENDIF
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT crSigcdcpo
                INSERT INTO crSigcdcpo ;
                    (grupos,    tipos,    vltps, valors,    fxinis, fxfins, compos, cidchaves) ;
                    VALUES ;
                    (loc_cCgrus, loc_cTipo, "",  loc_cPreco, 0,      0,      "",    "")

                GO BOTTOM IN crSigcdcpo

                IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                    loc_oPg9.grd_4c_Compos.Refresh
                    loc_oPg9.grd_4c_Compos.Column4.SetFocus
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir composi" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "FormGpd.BtnComposInserirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnComposExcluirClick - Exclui linha atual de crSigcdcpo com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE BtnComposExcluirClick()
        LOCAL loc_oPg9, loc_cCompos, loc_lProsseguir
        loc_oPg9   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9
        loc_cCompos = ""

        loc_lProsseguir = .T.
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !USED("crSigcdcpo")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT crSigcdcpo
                IF EOF("crSigcdcpo")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF
            IF loc_lProsseguir
                loc_cCompos = ALLTRIM(crSigcdcpo.compos)

                IF MsgConfirma("Deseja excluir a Compos '" + loc_cCompos + "' ?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    DELETE FROM crSigcdcpo WHERE ALLTRIM(compos) = loc_cCompos
                    GO TOP IN crSigcdcpo
                    IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                        loc_oPg9.grd_4c_Compos.Refresh
                        loc_oPg9.grd_4c_Compos.Column4.SetFocus
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir composi" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "FormGpd.BtnComposExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdCopiarComposClick - Copia estrutura de composicao de outro grupo
    * Abre picker de grupos que tenham compos; copia faixas/valores para o atual
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE CmdCopiarComposClick()
        LOCAL loc_lResultado, loc_cSql, loc_nRet, loc_oBusca, loc_cGrupoSel, loc_lProsseguir
        LOCAL loc_oPg9, loc_cCgrus
        loc_lResultado = .T.
        loc_oPg9   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page9
        loc_cCgrus = ALLTRIM(THIS.this_oBusinessObject.this_cCgrus)

        loc_lProsseguir = .T.
        TRY
            IF !USED("crSigcdcpo")
                loc_lProsseguir = .F.
            ENDIF

            *-- Listar grupos com composicao definida
            IF loc_lProsseguir
                loc_cSql = "SELECT DISTINCT a.grupos, b.dgrus " + ;
                    "FROM sigcdcpo a " + ;
                    "INNER JOIN sigcdgrp b ON b.cgrus = a.grupos"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "crGruposCompos")
                IF loc_nRet < 1
                    MsgErro("Falha ao carregar grupos com composi" + CHR(231) + CHR(227) + "o.", ;
                        "FormGpd.CmdCopiarComposClick")
                    loc_lResultado = .F.
                ENDIF

                IF loc_lResultado AND USED("crGruposCompos")
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle)
                    IF VARTYPE(loc_oBusca) = "O"
                        GO TOP IN crGruposCompos
                        loc_oBusca.DefinirCursor("crGruposCompos", "grupos", "dgrus", ;
                            "Sele" + CHR(231) + CHR(227) + "o de Grupo")
                        loc_oBusca.Mostrar()
                        loc_cGrupoSel = ""
                        IF loc_oBusca.this_lSelecionou AND USED("crGruposCompos")
                            SELECT crGruposCompos
                            loc_cGrupoSel = ALLTRIM(crGruposCompos.grupos)
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                ENDIF

                IF loc_lResultado AND !EMPTY(loc_cGrupoSel)
                    *-- Carregar composicoes do grupo selecionado
                    loc_cSql = "SELECT * FROM sigcdcpo WHERE grupos = " + EscaparSQL(loc_cGrupoSel)
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "crSigcdcpoCopia")
                    IF loc_nRet < 1
                        MsgErro("Falha ao carregar composi" + CHR(231) + CHR(245) + "es do grupo selecionado.", ;
                            "FormGpd.CmdCopiarComposClick")
                        loc_lResultado = .F.
                    ENDIF
    
                    IF loc_lResultado AND USED("crSigcdcpoCopia")
                        *-- Obter tipo/preco do grupo copiado
                        LOCAL loc_cSql2, loc_nRet2
                        loc_cSql2 = "SELECT DISTINCT tipos, valors FROM sigcdcpo WHERE grupos = " + ;
                            EscaparSQL(loc_cGrupoSel)
                        loc_nRet2 = SQLEXEC(gnConnHandle, loc_cSql2, "crTipoCopia")
                        IF loc_nRet2 > 0 AND USED("crTipoCopia") AND !EOF("crTipoCopia")
                            *-- Atualizar filtros com tipo/preco do grupo copiado
                            IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltTipo", 5)
                                loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltTipo.Value = ;
                                    ALLTRIM(crTipoCopia.tipos)
                            ENDIF
                            IF PEMSTATUS(loc_oPg9.cnt_4c_FiltroCompos, "txt_4c_FiltPreco", 5)
                                loc_oPg9.cnt_4c_FiltroCompos.txt_4c_FiltPreco.Value = ;
                                    ALLTRIM(crTipoCopia.valors)
                            ENDIF
                        ENDIF
                        IF USED("crTipoCopia")
                            USE IN crTipoCopia
                        ENDIF
    
                        *-- Copiar linhas de faixa para crSigcdcpo atual (sem compos)
                        SELECT crSigcdcpo
                        ZAP
                        SELECT crSigcdcpoCopia
                        SCAN
                            SELECT crSigcdcpo
                            INSERT INTO crSigcdcpo ;
                                (grupos, tipos, vltps, valors, fxinis, fxfins, compos, cidchaves) ;
                                VALUES ;
                                (loc_cCgrus, ;
                                 ALLTRIM(crSigcdcpoCopia.tipos), ;
                                 ALLTRIM(crSigcdcpoCopia.vltps), ;
                                 ALLTRIM(crSigcdcpoCopia.valors), ;
                                 crSigcdcpoCopia.fxinis, ;
                                 crSigcdcpoCopia.fxfins, ;
                                 "", "")
                            SELECT crSigcdcpoCopia
                        ENDSCAN
                        IF PEMSTATUS(loc_oPg9, "grd_4c_Compos", 5)
                            loc_oPg9.grd_4c_Compos.Refresh
                            GO TOP IN crSigcdcpo
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao copiar composi" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "FormGpd.CmdCopiarComposClick")
        ENDTRY
        IF loc_lProsseguir
    
            IF USED("crGruposCompos")
                USE IN crGruposCompos
            ENDIF
            IF USED("crSigcdcpoCopia")
                USE IN crSigcdcpoCopia
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarSigcdcpo - Carrega cursor crSigcdcpo do servidor para o grupo dado
    * par_cCgrus: codigo do grupo (SigCdGrp.cgrus)
    *==========================================================================
    PROCEDURE CarregarSigcdcpo(par_cCgrus)
        LOCAL loc_cSql, loc_nRet, loc_lProsseguir
        IF !USED("crSigcdcpo")
            RETURN
        ENDIF
        loc_lProsseguir = .T.
        TRY
            SELECT crSigcdcpo
            ZAP
            IF EMPTY(ALLTRIM(par_cCgrus))
                loc_lProsseguir = .F.
            ENDIF
            IF loc_lProsseguir
                loc_cSql = "SELECT cidchaves, compos, fxfins, fxinis, grupos, tipos, valors, vltps " + ;
                    "FROM sigcdcpo WHERE grupos = " + EscaparSQL(ALLTRIM(par_cCgrus))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "crSigcdcpo")
                IF loc_nRet < 0
                    MsgErro("Falha ao carregar composi" + CHR(231) + CHR(245) + "es.", ;
                        "FormGpd.CarregarSigcdcpo")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar composi" + CHR(231) + CHR(245) + "es:" + ;
                CHR(13) + loc_oErro.Message, "FormGpd.CarregarSigcdcpo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SalvarSigcdcpo - Grava crSigcdcpo em sigcdcpo no servidor
    * Limpa linhas incompletas, atribui cidchaves, substitui no servidor
    * par_cCgrus: codigo do grupo atual
    *==========================================================================
    PROCEDURE SalvarSigcdcpo(par_cCgrus)
        LOCAL loc_lResultado, loc_cSql, loc_nRet, loc_cCid
        loc_lResultado = .T.

        IF !USED("crSigcdcpo")
            RETURN
        ENDIF

        TRY
            SELECT crSigcdcpo

            *-- Remover linhas incompletas (compos/tipos/grupos/vltps vazio ou faixas = 0)
            DELETE FROM crSigcdcpo ;
                WHERE EMPTY(ALLTRIM(compos)) OR EMPTY(ALLTRIM(tipos)) ;
                OR EMPTY(ALLTRIM(grupos)) OR EMPTY(ALLTRIM(vltps)) ;
                OR fxinis = 0 OR fxfins = 0

            *-- Atribuir cidchaves para linhas novas (sem UUID ainda)
            SELECT crSigcdcpo
            SCAN FOR EMPTY(ALLTRIM(cidchaves))
                REPLACE cidchaves WITH LEFT(SYS(2015) + SYS(2015), 20) IN crSigcdcpo
            ENDSCAN

            *-- Deletar registros existentes do grupo no servidor
            loc_cSql = "DELETE FROM sigcdcpo WHERE grupos = " + EscaparSQL(ALLTRIM(par_cCgrus))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSql)
            IF loc_nRet < 0
                MsgErro("Falha ao limpar composi" + CHR(231) + CHR(245) + "es anteriores.", ;
                    "FormGpd.SalvarSigcdcpo")
                loc_lResultado = .F.
            ENDIF

            *-- Inserir linhas validas do cursor no servidor
            IF loc_lResultado
                SELECT crSigcdcpo
                SCAN FOR !DELETED()
                    loc_cCid = ALLTRIM(crSigcdcpo.cidchaves)
                    IF EMPTY(loc_cCid)
                        LOOP
                    ENDIF
                    loc_cSql = "INSERT INTO sigcdcpo " + ;
                        "(cidchaves, compos, fxfins, fxinis, grupos, tipos, valors, vltps) VALUES (" + ;
                        EscaparSQL(loc_cCid) + ", " + ;
                        EscaparSQL(ALLTRIM(crSigcdcpo.compos)) + ", " + ;
                        FormatarNumeroSQL(crSigcdcpo.fxfins) + ", " + ;
                        FormatarNumeroSQL(crSigcdcpo.fxinis) + ", " + ;
                        EscaparSQL(ALLTRIM(crSigcdcpo.grupos)) + ", " + ;
                        EscaparSQL(ALLTRIM(crSigcdcpo.tipos)) + ", " + ;
                        EscaparSQL(ALLTRIM(crSigcdcpo.valors)) + ", " + ;
                        EscaparSQL(ALLTRIM(crSigcdcpo.vltps)) + ")"
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSql)
                    IF loc_nRet < 0
                        MsgErro("Falha ao gravar linha de composi" + CHR(231) + CHR(227) + "o.", ;
                            "FormGpd.SalvarSigcdcpo")
                        loc_lResultado = .F.
                        EXIT
                    ENDIF
                    SELECT crSigcdcpo
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar composi" + CHR(231) + CHR(245) + "es:" + ;
                CHR(13) + loc_oErro.Message, "FormGpd.SalvarSigcdcpo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPgpgDescrs - Cria controles na Page3 (pgDescrs)
    * cmbTipos, cmbLingua, cmdGrade e grd_4c_Dados (8 colunas) com LocalProD
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgDescrs()
        LOCAL loc_oPg, loc_oGrd
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3

        *-- Label Say1 (Tipo :) Top=120+29=149, Left=204, Width=32
        loc_oPg.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oPg.lbl_4c_Say1
            .Caption   = "Tipo :"
            .Top       = 149
            .Left      = 204
            .Width     = 32
            .Height    = 15
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- ComboBox cmbTipos Top=117+29=146, Left=238, Width=245
        loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
        WITH loc_oPg.cbo_4c_CmbTipos
            .Top           = 146
            .Left          = 238
            .Width         = 245
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "Descri" + CHR(231) + CHR(227) + "o do Produto," + ;
                "Descri" + CHR(231) + CHR(227) + "o de Compra," + ;
                "Descri" + CHR(231) + CHR(227) + "o Completa," + ;
                "Caracteristicas," + ;
                "Descri" + CHR(231) + CHR(227) + "o Fiscal," + ;
                "Descri" + CHR(231) + CHR(227) + "o ECF,Titulo"
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", ;
            THIS, "PgDescrs_CmbTiposInteractiveChange")

        *-- Label Say2 (Lingua :) Top=120+29=149, Left=493, Width=45
        loc_oPg.AddObject("lbl_4c_Say2", "Label")
        WITH loc_oPg.lbl_4c_Say2
            .Caption   = "L" + CHR(237) + "ngua :"
            .Top       = 149
            .Left      = 493
            .Width     = 45
            .Height    = 15
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        *-- ComboBox cmbLingua Top=117+29=146, Left=540, Width=146
        loc_oPg.AddObject("cbo_4c_CmbLingua", "ComboBox")
        WITH loc_oPg.cbo_4c_CmbLingua
            .Top           = 146
            .Left          = 540
            .Width         = 146
            .Height        = 23
            .RowSourceType = 1
            .RowSource     = "Portugu" + CHR(234) + "s,Ingl" + CHR(234) + "s"
            .ControlSource = "LocalProD.Linguas"
            .BoundTo       = .F.
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.cbo_4c_CmbLingua, "InteractiveChange", ;
            THIS, "PgDescrs_CmbLinguaInteractiveChange")
        BINDEVENT(loc_oPg.cbo_4c_CmbLingua, "When", ;
            THIS, "PgDescrs_CmbLinguaWhen")

        *-- CommandGroup obj_4c_CmdGrade Top=314+29=343, Left=830, Width=55, Height=100
        loc_oPg.AddObject("obj_4c_CmdGrade", "CommandGroup")
        WITH loc_oPg.obj_4c_CmdGrade
            .Top         = 343
            .Left        = 830
            .Width       = 55
            .Height      = 100
            .BackStyle   = 0
            .BorderStyle = 0
            .ButtonCount = 2
            .Visible     = .F.
            .Buttons(1).Top             = 5
            .Buttons(1).Left            = 5
            .Buttons(1).Width           = 45
            .Buttons(1).Height          = 45
            .Buttons(1).Caption         = ""
            .Buttons(1).FontName        = "Verdana"
            .Buttons(1).FontSize        = 8
            .Buttons(1).Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .Buttons(1).DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .Buttons(1).ToolTipText     = "Inserir"
            .Buttons(1).Themes          = .T.
            .Buttons(1).ForeColor       = RGB(36, 84, 155)
            .Buttons(1).BackColor       = RGB(255, 255, 255)
            .Buttons(2).Top             = 50
            .Buttons(2).Left            = 5
            .Buttons(2).Width           = 45
            .Buttons(2).Height          = 45
            .Buttons(2).Caption         = ""
            .Buttons(2).FontName        = "Verdana"
            .Buttons(2).FontSize        = 8
            .Buttons(2).Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Buttons(2).DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Buttons(2).ToolTipText     = "Excluir"
            .Buttons(2).Themes          = .T.
            .Buttons(2).ForeColor       = RGB(36, 84, 155)
            .Buttons(2).BackColor       = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdGrade.Buttons(1), "Click", ;
            THIS, "PgDescrs_CmdGradeClick")
        BINDEVENT(loc_oPg.obj_4c_CmdGrade.Buttons(2), "Click", ;
            THIS, "PgDescrs_CmdGradeClick")

        *-- Grid grd_4c_Dados Top=144+29=173, Left=104, Width=725, Height=445
        loc_oPg.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = loc_oPg.grd_4c_Dados

        *-- RecordSource PRIMEIRO (VFP9 reseta headers ao setar RecordSource)
        WITH loc_oGrd
            .RecordSource      = "LocalProD"
            .ColumnCount       = 8
            .Top               = 173
            .Left              = 104
            .Width             = 725
            .Height            = 445
            .HeaderHeight      = 23
            .RowHeight         = 22
            .ScrollBars        = 2
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .AllowHeaderSizing = .T.
            .AllowRowSizing    = .T.
            .GridLineColor     = RGB(238, 238, 238)
            .FontName          = "Tahoma"
            .FontSize          = 8
            .Visible           = .F.
        ENDWITH

        *-- Column1 (COrds - read-only, sem header)
        WITH loc_oGrd.Column1
            .ControlSource      = "LocalProD.COrds"
            .Width              = 26
            .ReadOnly           = .T.
            .Movable            = .F.
            .Resizable          = .F.
            .FontSize           = 8
            .Visible            = .T.
            .Header1.Caption    = ""
            .Header1.Alignment  = 6
            .Header1.FontName   = "Tahoma"
            .Header1.FontSize   = 8
            .Text1.BorderStyle  = 0
            .Text1.Margin       = 0
            .Text1.ReadOnly     = .T.
            .Text1.ForeColor    = RGB(0, 0, 0)
            .Text1.BackColor    = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(loc_oGrd.Column1.Text1, "When", THIS, "PgDescrs_GrdDados_Col1_When")

        *-- Column2 (CpMontas - Montagem)
        WITH loc_oGrd.Column2
            .ControlSource     = "LocalProD.CpMontas"
            .Width             = 150
            .Sparse            = .F.
            .FontSize          = 8
            .Visible           = .T.
            .Format            = "K"
            .Movable           = .F.
            .Header1.Caption   = "Montagem"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        loc_oGrd.Column2.AddObject("cbo_4c_Fwcombo1", "ComboBox")
        WITH loc_oGrd.Column2.cbo_4c_Fwcombo1
            .RowSourceType = 1
            .RowSource     = "Grupo,Subgrupo,Composi" + CHR(231) + CHR(227) + "o," + ;
                "Fornec. 4(D" + CHR(237) + "g.),Ref. Fornec.,Cor,Ouro," + ;
                "Cor + Ouro,Metal,Manual,Dimens" + CHR(227) + "o," + ;
                "C" + CHR(243) + "digo,Categoria"
            .BoundTo       = .F.
            .Style         = 2
            .ColumnCount   = 1
            .ColumnWidths  = "150"
            .FirstElement  = 1
            .Left          = 8
            .Top           = 35
            .Margin        = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        *-- CurrentControl: sem isto a coluna continua desenhando o Text1 e o
        *-- ComboBox acima NUNCA aparece (CorretorAutomatico #198)
        loc_oGrd.Column2.CurrentControl = "cbo_4c_Fwcombo1"
        loc_oGrd.Column2.Sparse         = .F.
        BINDEVENT(loc_oGrd.Column2.cbo_4c_Fwcombo1, "InteractiveChange", ;
            THIS, "PgDescrs_GrdDados_Col2_InteractiveChange")
        BINDEVENT(loc_oGrd.Column2.cbo_4c_Fwcombo1, "When", ;
            THIS, "PgDescrs_GrdDados_Col2_When")

        *-- Column3 (Virgulas)
        WITH loc_oGrd.Column3
            .ControlSource     = "LocalProD.Virgulas"
            .Width             = 71
            .Sparse            = .F.
            .FontSize          = 8
            .Visible           = .T.
            .Format            = "K"
            .Header1.Caption   = "V" + CHR(237) + "rgulas"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        loc_oGrd.Column3.AddObject("cbo_4c_Fwcombo1", "ComboBox")
        WITH loc_oGrd.Column3.cbo_4c_Fwcombo1
            .RowSourceType = 1
            .RowSource     = "N" + CHR(227) + "o,No Final,Entre Itens"
            .BoundTo       = .F.
            .Style         = 2
            .ColumnCount   = 1
            .ColumnWidths  = "100"
            .Left          = 13
            .Top           = 35
            .Margin        = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        *-- CurrentControl: sem isto a coluna continua desenhando o Text1 e o
        *-- ComboBox acima NUNCA aparece (CorretorAutomatico #198)
        loc_oGrd.Column3.CurrentControl = "cbo_4c_Fwcombo1"
        loc_oGrd.Column3.Sparse         = .F.
        BINDEVENT(loc_oGrd.Column3.cbo_4c_Fwcombo1, "When", ;
            THIS, "PgDescrs_GrdDados_Col3_When")

        *-- Column4 (TpCompos - Composicao)
        WITH loc_oGrd.Column4
            .ControlSource     = "LocalProD.TpCompos"
            .Width             = 180
            .Sparse            = .F.
            .FontSize          = 8
            .Visible           = .T.
            .Format            = "K"
            .Header1.Caption   = "Composi" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        loc_oGrd.Column4.AddObject("cbo_4c_Fwcombo1", "ComboBox")
        WITH loc_oGrd.Column4.cbo_4c_Fwcombo1
            .RowSourceType = 1
            .RowSource     = "N" + CHR(227) + "o Aplic" + CHR(225) + "vel,Cadastro," + ;
                "Qtd. e Descr. Inteiras,Qtd. e Descr. 3 Pos.,Descr. 3 Pos.," + ;
                "Descr. 3 Pos. + Peso,Descr. Inteira + Peso,Descr. Inteira," + ;
                "Descr. Inteira + Classif. + Peso"
            .BoundTo       = .F.
            .Style         = 2
            .ColumnCount   = 1
            .ColumnWidths  = "160"
            .Left          = 8
            .Top           = 23
            .Margin        = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        *-- CurrentControl: sem isto a coluna continua desenhando o Text1 e o
        *-- ComboBox acima NUNCA aparece (CorretorAutomatico #198)
        loc_oGrd.Column4.CurrentControl = "cbo_4c_Fwcombo1"
        loc_oGrd.Column4.Sparse         = .F.
        BINDEVENT(loc_oGrd.Column4.cbo_4c_Fwcombo1, "When", ;
            THIS, "PgDescrs_GrdDados_Col4_When")

        *-- Column5 (ZeroDirs - Zeros a Direita)
        WITH loc_oGrd.Column5
            .ControlSource     = "LocalProD.ZeroDirs"
            .Width             = 80
            .Sparse            = .F.
            .FontSize          = 8
            .Visible           = .T.
            .Format            = "K"
            .Header1.Caption   = "Zeros a Direita"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        loc_oGrd.Column5.AddObject("cbo_4c_Fwcombo1", "ComboBox")
        WITH loc_oGrd.Column5.cbo_4c_Fwcombo1
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o,N" + CHR(227) + "o Aplic" + CHR(225) + "vel"
            .BoundTo       = .F.
            .Style         = 2
            .ColumnCount   = 1
            .ColumnWidths  = "80"
            .Left          = 16
            .Top           = 35
            .Margin        = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        *-- CurrentControl: sem isto a coluna continua desenhando o Text1 e o
        *-- ComboBox acima NUNCA aparece (CorretorAutomatico #198)
        loc_oGrd.Column5.CurrentControl = "cbo_4c_Fwcombo1"
        loc_oGrd.Column5.Sparse         = .F.
        BINDEVENT(loc_oGrd.Column5.cbo_4c_Fwcombo1, "When", ;
            THIS, "PgDescrs_GrdDados_Col5_When")

        *-- Column6 (ChecaEtiqs - Etiquetas)
        WITH loc_oGrd.Column6
            .ControlSource     = "LocalProD.ChecaEtiqs"
            .Width             = 80
            .Sparse            = .F.
            .FontSize          = 8
            .Visible           = .T.
            .Format            = "K"
            .Header1.Caption   = "Etiquetas"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        loc_oGrd.Column6.AddObject("cbo_4c_Fwcombo1", "ComboBox")
        WITH loc_oGrd.Column6.cbo_4c_Fwcombo1
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o,Ambos"
            .BoundTo       = .F.
            .Style         = 2
            .ColumnCount   = 1
            .ColumnWidths  = "80"
            .Left          = 13
            .Top           = 35
            .Margin        = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        *-- CurrentControl: sem isto a coluna continua desenhando o Text1 e o
        *-- ComboBox acima NUNCA aparece (CorretorAutomatico #198)
        loc_oGrd.Column6.CurrentControl = "cbo_4c_Fwcombo1"
        loc_oGrd.Column6.Sparse         = .F.
        BINDEVENT(loc_oGrd.Column6.cbo_4c_Fwcombo1, "When", ;
            THIS, "PgDescrs_GrdDados_Col6_When")

        *-- Column7 (Agrupar - Agrupamento)
        WITH loc_oGrd.Column7
            .ControlSource     = "LocalProD.Agrupar"
            .Width             = 77
            .Sparse            = .F.
            .FontSize          = 8
            .Visible           = .T.
            .Format            = "K"
            .Header1.Caption   = "Agrupamento"
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
        ENDWITH
        loc_oGrd.Column7.AddObject("cbo_4c_Fwcombo1", "ComboBox")
        WITH loc_oGrd.Column7.cbo_4c_Fwcombo1
            .RowSourceType = 1
            .RowSource     = "Sim,N" + CHR(227) + "o,N" + CHR(227) + "o Aplic" + CHR(225) + "vel"
            .BoundTo       = .F.
            .Style         = 2
            .ColumnCount   = 1
            .ColumnWidths  = "80"
            .Left          = 15
            .Top           = 35
            .Margin        = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
        ENDWITH

        *-- CurrentControl: sem isto a coluna continua desenhando o Text1 e o
        *-- ComboBox acima NUNCA aparece (CorretorAutomatico #198)
        loc_oGrd.Column7.CurrentControl = "cbo_4c_Fwcombo1"
        loc_oGrd.Column7.Sparse         = .F.
        BINDEVENT(loc_oGrd.Column7.cbo_4c_Fwcombo1, "When", ;
            THIS, "PgDescrs_GrdDados_Col7_When")

        *-- Column8 (Mercs - G.Grp. - lookup SigCdGpr)
        WITH loc_oGrd.Column8
            .ControlSource     = "LocalProD.Mercs"
            .Width             = 33
            .FontSize          = 8
            .Visible           = .T.
            .Format            = "K"
            .Header1.Caption   = "G.Grp."
            .Header1.Alignment = 2
            .Header1.FontName  = "Tahoma"
            .Header1.FontSize  = 8
            .Text1.BorderStyle = 0
            .Text1.Margin      = 0
            .Text1.ForeColor   = RGB(0, 0, 0)
            .Text1.BackColor   = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(loc_oGrd.Column8.Text1, "Valid", THIS, "PgDescrs_GrdDados_Col8_Valid")
        BINDEVENT(loc_oGrd.Column8.Text1, "When", THIS, "PgDescrs_GrdDados_Col8_When")

        THIS.TornarControlesVisiveis(loc_oPg)
    ENDPROC

    *==========================================================================
    * ConfigurarPgpgEstoque - Adiciona controles restantes da Page4 (Estoque/Fiscal)
    * Complementa ConfigurarAbaEstoqueFiscal: secao headers, combos avaliacao,
    * checkboxes grade/frete, option groups patrimonio, CjIcms, ChkUni1s, Encoms
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgEstoque()
        LOCAL loc_oPg, loc_cRowAval
        loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_cRowAval = "Custo S/ICMS S/IPI,Custo S/ICMS C/IPI,Nenhum,Custo C/ICMS e IPI, Custo C/ICMS S/IPI"

        *-- Section header: " Estoque " (Say4 T=89+25=114)
        loc_oPg.AddObject("lbl_4c_SecEstoque", "Label")
        WITH loc_oPg.lbl_4c_SecEstoque
            .Caption   = " Estoque "
            .Top       = 114
            .Left      = 19
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        *-- Section header: " Fiscal " (Say5 T=324+25=349)
        loc_oPg.AddObject("lbl_4c_SecFiscal", "Label")
        WITH loc_oPg.lbl_4c_SecFiscal
            .Caption   = " Fiscal "
            .Top       = 349
            .Left      = 19
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        *-- Section header: "Posicao Patrimonial" (Say6 T=474+25=499)
        loc_oPg.AddObject("lbl_4c_SecPatri", "Label")
        WITH loc_oPg.lbl_4c_SecPatri
            .Caption   = "Posi" + CHR(231) + CHR(227) + "o Patrimonial"
            .Top       = 499
            .Left      = 19
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        *-- Separator line (Shape2 T=320+25=345)
        loc_oPg.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPg.shp_4c_Shape2
            .Top           = 345
            .Left          = 8
            .Height        = 1
            .Width         = 980
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Bounding rect for Grade area (Shape3 T=255+25=280)
        loc_oPg.AddObject("shp_4c_Shape3", "Shape")
        WITH loc_oPg.shp_4c_Shape3
            .Top           = 280
            .Left          = 438
            .Height        = 61
            .Width         = 229
            .BackStyle     = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Separator line (Shape5 T=469+25=494)
        loc_oPg.AddObject("shp_4c_Shape5", "Shape")
        WITH loc_oPg.shp_4c_Shape5
            .Top           = 494
            .Left          = 8
            .Height        = 1
            .Width         = 980
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Tipo Controle Estoque (TipoEstos) T=141+25=166 / combo T=136+25=161
        loc_oPg.AddObject("lbl_4c_TipoEstos", "Label")
        WITH loc_oPg.lbl_4c_TipoEstos
            .Caption   = "Tipo Controle Estoque :"
            .Top       = 166
            .Left      = 42
            .Width     = 115
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("cbo_4c_TipoEstos", "ComboBox")
        WITH loc_oPg.cbo_4c_TipoEstos
            .Value         = 1
            .Top           = 161
            .Left          = 159
            .Width         = 190
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = "C" + CHR(243) + "digo,C" + CHR(243) + "digo/Cor,C" + CHR(243) + "digo/Tamanho,C" + CHR(243) + "digo/Cor/Tamanho"
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.cbo_4c_TipoEstos, "InteractiveChange", THIS, "TipoEstosChanged")

        *-- Inventario (Invents) T=215+25=240 / opt T=212+25=237
        loc_oPg.AddObject("lbl_4c_Invents", "Label")
        WITH loc_oPg.lbl_4c_Invents
            .Caption   = "Invent" + CHR(225) + "rio :"
            .Top       = 240
            .Left      = 98
            .Width     = 59
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Invents", "OptionGroup")
        WITH loc_oPg.obj_4c_Invents
            .Value         = 1
            .Top           = 237
            .Left          = 151
            .Width         = 110
            .Height        = 25
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Visible       = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 5
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 68
                .Top       = 5
                .Width     = 37
                .Height    = 15
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Avaliacao Estoque headers (Label10/Label11 T=119+25=144)
        loc_oPg.AddObject("lbl_4c_CustoFiscal", "Label")
        WITH loc_oPg.lbl_4c_CustoFiscal
            .Caption   = "Custo Fiscal"
            .Top       = 144
            .Left      = 443
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_CustoGerencial", "Label")
        WITH loc_oPg.lbl_4c_CustoGerencial
            .Caption   = "Custo Gerencial"
            .Top       = 144
            .Left      = 667
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        *-- Row labels: Nacional/Importado/Origem(2) (T=139+25=164 / 165+25=190 / 191+25=216)
        loc_oPg.AddObject("lbl_4c_AvalNacional", "Label")
        WITH loc_oPg.lbl_4c_AvalNacional
            .Caption   = "Nacional :"
            .Top       = 164
            .Left      = 392
            .Width     = 49
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_AvalImportado", "Label")
        WITH loc_oPg.lbl_4c_AvalImportado
            .Caption   = "Importado :"
            .Top       = 190
            .Left      = 382
            .Width     = 59
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_AvalOrigem2", "Label")
        WITH loc_oPg.lbl_4c_AvalOrigem2
            .Caption   = "Origem (2):"
            .Top       = 216
            .Left      = 384
            .Width     = 57
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        *-- Avaliacao Estoque combos - Fiscal (T=134+25=159 / 160+25=185 / 186+25=211)
        loc_oPg.AddObject("cbo_4c_Avalests", "ComboBox")
        WITH loc_oPg.cbo_4c_Avalests
            .Value         = 1
            .Top           = 159
            .Left          = 443
            .Width         = 208
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = loc_cRowAval
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        loc_oPg.AddObject("cbo_4c_Avalestis", "ComboBox")
        WITH loc_oPg.cbo_4c_Avalestis
            .Value         = 1
            .Top           = 185
            .Left          = 443
            .Width         = 208
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = loc_cRowAval
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        loc_oPg.AddObject("cbo_4c_Avalest2s", "ComboBox")
        WITH loc_oPg.cbo_4c_Avalest2s
            .Value         = 1
            .Top           = 211
            .Left          = 443
            .Width         = 208
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = loc_cRowAval
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Avaliacao Estoque combos - Gerencial (T=134+25=159 / 160+25=185 / 186+25=211, L=667)
        loc_oPg.AddObject("cbo_4c_Avalestngs", "ComboBox")
        WITH loc_oPg.cbo_4c_Avalestngs
            .Value         = 1
            .Top           = 159
            .Left          = 667
            .Width         = 208
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = loc_cRowAval
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        loc_oPg.AddObject("cbo_4c_Avalestigs", "ComboBox")
        WITH loc_oPg.cbo_4c_Avalestigs
            .Value         = 1
            .Top           = 185
            .Left          = 667
            .Width         = 208
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = loc_cRowAval
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        loc_oPg.AddObject("cbo_4c_Avalest2gs", "ComboBox")
        WITH loc_oPg.cbo_4c_Avalest2gs
            .Value         = 1
            .Top           = 211
            .Left          = 667
            .Width         = 208
            .Height        = 24
            .RowSourceType = 1
            .RowSource     = loc_cRowAval
            .Style         = 2
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- Incluir Seguro+Frete no Custo (FrtSegFs/FrtSegGs) T=216+25=241
        loc_oPg.AddObject("chk_4c_FrtSegFs", "CheckBox")
        WITH loc_oPg.chk_4c_FrtSegFs
            .Value         = 0
            .Caption       = "Incluir Seguro+Frete no Custo"
            .Top           = 241
            .Left          = 443
            .Width         = 164
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        loc_oPg.AddObject("chk_4c_FrtSegGs", "CheckBox")
        WITH loc_oPg.chk_4c_FrtSegGs
            .Value         = 0
            .Caption       = "Incluir Seguro+Frete no Custo"
            .Top           = 241
            .Left          = 667
            .Width         = 164
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Incluir Desp.Acessorias no Custo (DespacFs/DespacGs) T=234+25=259
        loc_oPg.AddObject("chk_4c_Despacfs", "CheckBox")
        WITH loc_oPg.chk_4c_Despacfs
            .Value         = 0
            .Caption       = "Incluir Desp.Acessorias no Custo"
            .Top           = 259
            .Left          = 443
            .Width         = 175
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Despacgs", "CheckBox")
        WITH loc_oPg.chk_4c_Despacgs
            .Value         = 0
            .Caption       = "Incluir Desp.Acessorias no Custo"
            .Top           = 259
            .Left          = 667
            .Width         = 175
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Grade de Sub-Itens label + checkboxes (T=258+25=283)
        loc_oPg.AddObject("lbl_4c_GradeSubItens", "Label")
        WITH loc_oPg.lbl_4c_GradeSubItens
            .Caption   = "Grade de Sub-Itens :"
            .Top       = 283
            .Left      = 338
            .Width     = 103
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Tams", "CheckBox")
        WITH loc_oPg.chk_4c_Tams
            .Value         = 0
            .Caption       = "Tamanho"
            .Top           = 283
            .Left          = 443
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Embs", "CheckBox")
        WITH loc_oPg.chk_4c_Embs
            .Value         = 0
            .Caption       = "Embalagem"
            .Top           = 283
            .Left          = 520
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Pesos", "CheckBox")
        WITH loc_oPg.chk_4c_Pesos
            .Value         = 0
            .Caption       = "Peso"
            .Top           = 283
            .Left          = 612
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Cors", "CheckBox")
        WITH loc_oPg.chk_4c_Cors
            .Value         = 0
            .Caption       = "Cor"
            .Top           = 298
            .Left          = 443
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        loc_oPg.AddObject("chk_4c_Entregas", "CheckBox")
        WITH loc_oPg.chk_4c_Entregas
            .Value         = 0
            .Caption       = "Entrega"
            .Top           = 298
            .Left          = 520
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Obrigatorio Grade (chkObrigGrd 4-button) T=290+25=315 / label T=293+25=318
        loc_oPg.AddObject("lbl_4c_ObrigGrd", "Label")
        WITH loc_oPg.lbl_4c_ObrigGrd
            .Caption   = "Obrigat" + CHR(243) + "rio :"
            .Top       = 318
            .Left      = 378
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_ChkObrigGrd", "OptionGroup")
        WITH loc_oPg.obj_4c_ChkObrigGrd
            .Value         = 1
            .Top           = 315
            .Left          = 439
            .Width         = 239
            .Height        = 21
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Visible       = .F.
            WITH .Buttons(1)
                .Caption   = "Cor"
                .Left      = 3
                .Top       = 3
                .Width     = 35
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Tam"
                .Left      = 49
                .Top       = 3
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Ambos"
                .Height    = 15
                .Left      = 99
                .Top       = 3
                .Width     = 50
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Nenhum"
                .Height    = 17
                .Left      = 163
                .Top       = 2
                .Width     = 70
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Calculo de Total na Mov. label + ChkUni1s (T=260+25=285 / opt T=254+25=279)
        loc_oPg.AddObject("lbl_4c_CalcTotal", "Label")
        WITH loc_oPg.lbl_4c_CalcTotal
            .Caption   = "C" + CHR(225) + "lculo de Total na Mov.: "
            .Top       = 285
            .Left      = 668
            .Width     = 144
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .WordWrap  = .T.
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_ChkUni1s", "OptionGroup")
        WITH loc_oPg.obj_4c_ChkUni1s
            .Value         = 1
            .Top           = 279
            .Left          = 816
            .Width         = 155
            .Height        = 59
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Visible       = .F.
            WITH .Buttons(1)
                .Caption   = "Quantidade X Fator / Peso"
                .Left      = 5
                .Top       = 5
                .Width     = 145
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Peso X Fator / Quantidade"
                .Left      = 5
                .Top       = 22
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Quantidade X Unit" + CHR(225) + "rio"
                .Height    = 15
                .Left      = 5
                .Top       = 39
                .Width     = 123
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Encomendavel (Encoms 3-button) T=298+25=323 / opt T=294+25=319
        loc_oPg.AddObject("lbl_4c_Encoms", "Label")
        WITH loc_oPg.lbl_4c_Encoms
            .Caption   = "Encomend" + CHR(225) + "vel :"
            .Top       = 323
            .Left      = 79
            .Width     = 78
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("obj_4c_Encoms", "OptionGroup")
        WITH loc_oPg.obj_4c_Encoms
            .Value         = 2
            .Top           = 319
            .Left          = 151
            .Width         = 182
            .Height        = 21
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Visible       = .F.
            WITH .Buttons(1)
                .Caption   = "Sim"
                .Left      = 5
                .Top       = 6
                .Width     = 34
                .Height    = 15
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "N" + CHR(227) + "o"
                .Left      = 68
                .Top       = 6
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Verifica"
                .Height    = 17
                .Left      = 118
                .Top       = 5
                .Width     = 61
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Class. Fiscal Obrigatoria label (Label2 T=342+25=367)
        loc_oPg.AddObject("lbl_4c_ClassFiscalOb", "Label")
        WITH loc_oPg.lbl_4c_ClassFiscalOb
            .Caption   = "Class. Fiscal Obrigat" + CHR(243) + "ria :"
            .Top       = 367
            .Left      = 56
            .Width     = 124
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        *-- Transferencias / Locais label (Say26 T=439+25=464)
        loc_oPg.AddObject("lbl_4c_TransfLocais", "Label")
        WITH loc_oPg.lbl_4c_TransfLocais
            .Caption   = "Transfer" + CHR(234) + "ncias / Locais :"
            .Top       = 464
            .Left      = 61
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        *-- Servico Para ICMS label + CodServs TextBox (T=413+25=438 / T=409+25=434)
        loc_oPg.AddObject("lbl_4c_CodServs", "Label")
        WITH loc_oPg.lbl_4c_CodServs
            .Caption   = "Servi" + CHR(231) + "o Para ICMS :"
            .Top       = 438
            .Left      = 531
            .Width     = 97
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Codservs", "TextBox")
        WITH loc_oPg.txt_4c_Codservs
            .Value         = 0
            .Top           = 434
            .Left          = 630
            .Width         = 33
            .Height        = 23
            .InputMask     = "9999"
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .BorderColor   = RGB(100, 100, 100)
            .Visible       = .F.
        ENDWITH

        *-- CjIcms 3-button (Fwoption3 T=435+25=460)
        loc_oPg.AddObject("obj_4c_CjIcms", "OptionGroup")
        WITH loc_oPg.obj_4c_CjIcms
            .Value         = 1
            .Top           = 460
            .Left          = 176
            .Width         = 263
            .Height        = 25
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Visible       = .F.
            WITH .Buttons(1)
                .Caption   = "Padr" + CHR(227) + "o"
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 52
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
                .Left      = 70
                .Top       = 5
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal"
                .Height    = 15
                .Left      = 165
                .Top       = 5
                .Width     = 93
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- Posicao Patrimonial labels (Label3/Label13 T=495+25=520)
        loc_oPg.AddObject("lbl_4c_CustoPat", "Label")
        WITH loc_oPg.lbl_4c_CustoPat
            .Caption   = "Custo :"
            .Top       = 520
            .Left      = 112
            .Width     = 37
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_CustoRealPat", "Label")
        WITH loc_oPg.lbl_4c_CustoRealPat
            .Caption   = "Custo Real :"
            .Top       = 520
            .Left      = 359
            .Width     = 61
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .F.
        ENDWITH

        *-- PatriCustos 5-button (Optiongroup3 T=489+25=514, L=151)
        loc_oPg.AddObject("obj_4c_PatriCustos", "OptionGroup")
        WITH loc_oPg.obj_4c_PatriCustos
            .Value         = 1
            .Top           = 514
            .Left          = 151
            .Width         = 166
            .Height        = 88
            .ButtonCount   = 5
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Visible       = .F.
            WITH .Buttons(1)
                .Caption   = "Padr" + CHR(227) + "o"
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 52
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Pre" + CHR(231) + "o de Custo Cadastro"
                .Height    = 15
                .Left      = 5
                .Top       = 20
                .Width     = 138
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Custo Total Cadastro"
                .Height    = 15
                .Left      = 5
                .Top       = 35
                .Width     = 120
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Peso da " + CHR(218) + "ltima Entrada"
                .Height    = 15
                .Left      = 5
                .Top       = 51
                .Width     = 129
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "Total Peso da " + CHR(218) + "ltima Entrada"
                .Height    = 15
                .Left      = 5
                .Top       = 68
                .Width     = 156
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

        *-- PatriReals 5-button (Optiongroup4 T=489+25=514, L=430)
        loc_oPg.AddObject("obj_4c_PatriReals", "OptionGroup")
        WITH loc_oPg.obj_4c_PatriReals
            .Value         = 1
            .Top           = 514
            .Left          = 430
            .Width         = 166
            .Height        = 88
            .ButtonCount   = 5
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 0
            .Visible       = .F.
            WITH .Buttons(1)
                .Caption   = "Padr" + CHR(227) + "o"
                .Height    = 15
                .Left      = 5
                .Top       = 5
                .Width     = 52
                .BackStyle = 0
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Pre" + CHR(231) + "o de Custo Cadastro"
                .Height    = 15
                .Left      = 5
                .Top       = 20
                .Width     = 138
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Custo Total Cadastro"
                .Height    = 15
                .Left      = 5
                .Top       = 35
                .Width     = 120
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Peso da " + CHR(218) + "ltima Entrada"
                .Height    = 15
                .Left      = 5
                .Top       = 51
                .Width     = 129
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "Total Peso da " + CHR(218) + "ltima Entrada"
                .Height    = 15
                .Left      = 5
                .Top       = 68
                .Width     = 156
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        ENDWITH

    ENDPROC

    *==========================================================================
    * TipoEstosChanged - Handler para InteractiveChange de cbo_4c_TipoEstos
    * Valor: 1=Codigo, 2=Codigo/Cor, 3=Codigo/Tamanho, 4=Codigo/Cor/Tamanho
    * Forca chk_4c_Tams=1 quando 3 ou 4, desabilita controle
    * Forca chk_4c_Cors=1 quando 2 ou 4, desabilita controle
    *==========================================================================
    PROCEDURE TipoEstosChanged()
        LOCAL loc_oPg, loc_nVal
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page4
        loc_nVal = loc_oPg.cbo_4c_TipoEstos.Value

        IF INLIST(loc_nVal, 3, 4)
            loc_oPg.chk_4c_Tams.Value = 1
        ENDIF
        loc_oPg.chk_4c_Tams.Enabled = !INLIST(loc_nVal, 3, 4)

        IF INLIST(loc_nVal, 2, 4)
            loc_oPg.chk_4c_Cors.Value = 1
        ENDIF
        loc_oPg.chk_4c_Cors.Enabled = !INLIST(loc_nVal, 2, 4)
    ENDPROC

    *==========================================================================
    * CarregarLocalProD - Carrega SigCdPrd no cursor LocalProD via SQLEXEC
    * par_cCgrus: codigo do grupo para filtrar
    *==========================================================================
    PROTECTED PROCEDURE CarregarLocalProD(par_cCgrus)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        IF !USED("LocalProD")
            RETURN
        ENDIF

        TRY
            ZAP IN LocalProD

            loc_cSQL = "SELECT cgrus, tpmontas, cords, cpmontas, virgulas, tpcompos, " + ;
                "zerodirs, linguas, checaetiqs, agrupar, mercs, cidchaves " + ;
                "FROM SigCdPrd WHERE cgrus = " + EscaparSQL(ALLTRIM(par_cCgrus)) + ;
                " ORDER BY cgrus, tpmontas, cords"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalProD_temp")

            IF loc_nResult > 0 AND USED("cursor_4c_LocalProD_temp")
                SELECT LocalProD
                APPEND FROM DBF("cursor_4c_LocalProD_temp")
                USE IN cursor_4c_LocalProD_temp
                SELECT LocalProD
                IF RECCOUNT() > 0
                    SET ORDER TO TAG Ordem IN LocalProD
                    GO TOP IN LocalProD
                ENDIF
            ELSE
                IF USED("cursor_4c_LocalProD_temp")
                USE IN cursor_4c_LocalProD_temp
                ENDIF
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar LocalProD:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.CarregarLocalProD")
        ENDTRY
    ENDPROC

    *==========================================================================
    * SalvarLocalProD - Grava LocalProD em SigCdPrd no servidor
    * Atribui cidchaves para novas linhas, substitui no servidor
    * par_cCgrus: codigo do grupo atual
    *==========================================================================
    PROTECTED PROCEDURE SalvarLocalProD(par_cCgrus)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_cCid
        loc_lResultado = .T.
        loc_cCid       = ""

        IF !USED("LocalProD")
            RETURN
        ENDIF

        TRY
            *-- Atribuir cidchaves para linhas sem chave
            SELECT LocalProD
            SCAN FOR EMPTY(ALLTRIM(cidchaves))
                REPLACE cidchaves WITH LEFT(SYS(2015) + SYS(2015), 20) IN LocalProD
            ENDSCAN

            *-- Deletar registros existentes do grupo no servidor
            loc_cSQL = "DELETE FROM SigCdPrd WHERE cgrus = " + EscaparSQL(ALLTRIM(par_cCgrus))
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 0
                MsgErro("Falha ao limpar LocalProD anteriores.", "FormGpd.SalvarLocalProD")
                loc_lResultado = .F.
            ENDIF

            *-- Inserir linhas validas do cursor no servidor
            IF loc_lResultado
                SELECT LocalProD
                SCAN FOR !DELETED()
                    loc_cCid = ALLTRIM(LocalProD.cidchaves)
                    IF EMPTY(loc_cCid)
                        LOOP
                    ENDIF
                    loc_cSQL = "INSERT INTO SigCdPrd " + ;
                        "(cgrus, tpmontas, cords, cpmontas, virgulas, tpcompos, " + ;
                        "zerodirs, linguas, checaetiqs, agrupar, mercs, cidchaves) " + ;
                        "VALUES (" + ;
                        EscaparSQL(ALLTRIM(LocalProD.CGrus)) + "," + ;
                        FormatarNumeroSQL(LocalProD.TpMontas) + "," + ;
                        FormatarNumeroSQL(LocalProD.COrds) + "," + ;
                        FormatarNumeroSQL(LocalProD.CpMontas) + "," + ;
                        FormatarNumeroSQL(LocalProD.Virgulas) + "," + ;
                        FormatarNumeroSQL(LocalProD.TpCompos) + "," + ;
                        FormatarNumeroSQL(LocalProD.ZeroDirs) + "," + ;
                        FormatarNumeroSQL(LocalProD.Linguas) + "," + ;
                        FormatarNumeroSQL(LocalProD.ChecaEtiqs) + "," + ;
                        FormatarNumeroSQL(LocalProD.Agrupar) + "," + ;
                        EscaparSQL(ALLTRIM(LocalProD.Mercs)) + "," + ;
                        EscaparSQL(m.loc_cCid) + ")"
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nRet < 0
                        MsgErro("Falha ao gravar linha de LocalProD.", "FormGpd.SalvarLocalProD")
                        loc_lResultado = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar LocalProD:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.SalvarLocalProD")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AtualizarCmbDescrs - Inicializa cmbTipos em TpMontas=1 e aplica filtro
    * Chamado em BOParaForm apos CarregarLocalProD
    *==========================================================================
    PROTECTED PROCEDURE AtualizarCmbDescrs()
        LOCAL loc_oPg3, loc_cCgrus
        loc_oPg3  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3
        loc_cCgrus = ""

        IF !USED("LocalProD") OR !PEMSTATUS(loc_oPg3, "cbo_4c_CmbTipos", 5)
            RETURN
        ENDIF

        TRY
            loc_cCgrus = THIS.this_oBusinessObject.this_cCgrus
            loc_oPg3.cbo_4c_CmbTipos.ListIndex = 1
            SELECT LocalProD
            SET KEY TO m.loc_cCgrus + STR(1, 1) IN LocalProD
            GO TOP IN LocalProD
            IF PEMSTATUS(loc_oPg3, "grd_4c_Dados", 5)
                loc_oPg3.grd_4c_Dados.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPg3, "cbo_4c_CmbLingua", 5)
                loc_oPg3.cbo_4c_CmbLingua.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar combos de descri" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "FormGpd.AtualizarCmbDescrs")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PgDescrs_CmbTiposInteractiveChange - Filtra LocalProD pelo TpMontas selecionado
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE PgDescrs_CmbTiposInteractiveChange()
        LOCAL loc_oPg3, loc_cCgrus, loc_nTipo
        loc_oPg3   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3
        loc_cCgrus = ""
        loc_nTipo  = 1

        IF !PEMSTATUS(loc_oPg3, "cbo_4c_CmbTipos", 5)
            RETURN
        ENDIF

        TRY
            loc_cCgrus = THIS.this_oBusinessObject.this_cCgrus
            loc_nTipo  = loc_oPg3.cbo_4c_CmbTipos.ListIndex
            IF USED("LocalProD")
                SELECT LocalProD
                SET KEY TO m.loc_cCgrus + STR(m.loc_nTipo, 1) IN LocalProD
                GO TOP IN LocalProD
            ENDIF
            IF PEMSTATUS(loc_oPg3, "grd_4c_Dados", 5)
                loc_oPg3.grd_4c_Dados.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPg3, "cbo_4c_CmbLingua", 5)
                loc_oPg3.cbo_4c_CmbLingua.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao filtrar por tipo:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.PgDescrs_CmbTiposInteractiveChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PgDescrs_CmbLinguaInteractiveChange - Atualiza Linguas no LocalProD
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE PgDescrs_CmbLinguaInteractiveChange()
        LOCAL loc_oPg3, loc_nTipo, loc_nLingua
        loc_oPg3   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3
        loc_nTipo  = 1
        loc_nLingua = 1

        IF !PEMSTATUS(loc_oPg3, "cbo_4c_CmbTipos", 5) OR ;
           !PEMSTATUS(loc_oPg3, "cbo_4c_CmbLingua", 5) OR ;
           !USED("LocalProD")
            RETURN
        ENDIF

        TRY
            loc_nTipo   = loc_oPg3.cbo_4c_CmbTipos.ListIndex
            loc_nLingua = loc_oPg3.cbo_4c_CmbLingua.ListIndex
            UPDATE LocalProD SET Linguas = m.loc_nLingua WHERE TpMontas = m.loc_nTipo
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar l" + CHR(237) + "ngua:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.PgDescrs_CmbLinguaInteractiveChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PgDescrs_CmbLinguaWhen - Habilita cmbLingua apenas no modo edicao
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    FUNCTION PgDescrs_CmbLinguaWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * PgDescrs_CmdGradeClick - Inserir ou Excluir linha em LocalProD
    * Botao 1 = Inserir, Botao 2 = Excluir (lido de obj_4c_CmdGrade.Value)
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE PgDescrs_CmdGradeClick()
        LOCAL loc_oPg3, loc_nBotao, loc_nOrd, loc_nTipo, loc_nLingua, loc_cCgrus
        loc_oPg3    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3
        loc_nBotao  = 1
        loc_nOrd    = 1
        loc_nTipo   = 1
        loc_nLingua = 1
        loc_cCgrus  = ""

        IF !PEMSTATUS(loc_oPg3, "obj_4c_CmdGrade", 5) OR !USED("LocalProD")
            RETURN
        ENDIF

        TRY
            loc_nBotao = loc_oPg3.obj_4c_CmdGrade.Value
            loc_cCgrus = THIS.this_oBusinessObject.this_cCgrus
            IF PEMSTATUS(loc_oPg3, "cbo_4c_CmbTipos", 5)
                loc_nTipo = loc_oPg3.cbo_4c_CmbTipos.ListIndex
            ENDIF

            IF loc_nBotao = 1
                *-- Botao Inserir
                IF PEMSTATUS(loc_oPg3, "cbo_4c_CmbLingua", 5)
                    IF loc_oPg3.cbo_4c_CmbLingua.ListIndex = 0
                        loc_oPg3.cbo_4c_CmbLingua.ListIndex = 1
                    ENDIF
                    loc_nLingua = loc_oPg3.cbo_4c_CmbLingua.ListIndex
                ENDIF

                *-- Renumerar COrds (SCAN respeita SET KEY TO ativo)
                loc_nOrd = 1
                SELECT LocalProD
                SCAN
                    IF LocalProD.COrds <> loc_nOrd
                        REPLACE COrds WITH loc_nOrd IN LocalProD
                    ENDIF
                    loc_nOrd = loc_nOrd + 1
                ENDSCAN

                *-- Inserir nova linha (loc_nOrd = proximo ordinal)
                INSERT INTO LocalProD ;
                    (CGrus, TpMontas, COrds, CpMontas, Virgulas, TpCompos, ;
                     ZeroDirs, Linguas, ChecaEtiqs, Agrupar, Mercs, cidchaves) ;
                VALUES ;
                    (m.loc_cCgrus, m.loc_nTipo, m.loc_nOrd, 1, 1, 1, ;
                     3, m.loc_nLingua, 3, 3, "", "")

                SELECT LocalProD
                SET KEY TO m.loc_cCgrus + STR(m.loc_nTipo, 1) IN LocalProD
                GO BOTTOM IN LocalProD
            ELSE
                *-- Botao Excluir
                IF !EOF("LocalProD")
                    DELETE IN LocalProD
                ENDIF

                *-- Renumerar COrds apos exclusao
                loc_nOrd = 1
                SELECT LocalProD
                SCAN FOR !DELETED()
                    IF LocalProD.COrds <> loc_nOrd
                        REPLACE COrds WITH loc_nOrd IN LocalProD
                    ENDIF
                    loc_nOrd = loc_nOrd + 1
                ENDSCAN

                SELECT LocalProD
                GO BOTTOM IN LocalProD
            ENDIF

            IF PEMSTATUS(loc_oPg3, "cbo_4c_CmbLingua", 5)
                loc_oPg3.cbo_4c_CmbLingua.Refresh()
            ENDIF
            IF PEMSTATUS(loc_oPg3, "grd_4c_Dados", 5)
                loc_oPg3.grd_4c_Dados.Refresh()
                IF PEMSTATUS(loc_oPg3.grd_4c_Dados, "Column2", 5)
                    loc_oPg3.grd_4c_Dados.Column2.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro no comando de grade:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.PgDescrs_CmdGradeClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PgDescrs_GrdDados_Col1_When - COrds sempre somente leitura
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    FUNCTION PgDescrs_GrdDados_Col1_When()
        RETURN .F.
    ENDPROC

    *==========================================================================
    * PgDescrs_GrdDados_Col2_InteractiveChange - Ao mudar CpMontas:
    * Se CpMontas != 3, reseta TpCompos, ChecaEtiqs, ZeroDirs, Agrupar, Mercs
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    PROCEDURE PgDescrs_GrdDados_Col2_InteractiveChange()
        TRY
            IF USED("LocalProD") AND !EOF("LocalProD")
                IF LocalProD.CpMontas <> 3
                    REPLACE TpCompos   WITH 1, ;
                            ChecaEtiqs WITH 3, ;
                            ZeroDirs   WITH 3, ;
                            Agrupar    WITH 3, ;
                            Mercs      WITH "" IN LocalProD
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro no campo Montagem:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.PgDescrs_GrdDados_Col2_InteractiveChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * PgDescrs_GrdDados_Col2_When - CpMontas editavel apenas em INCLUIR/ALTERAR
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    FUNCTION PgDescrs_GrdDados_Col2_When()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * PgDescrs_GrdDados_Col3_When - Virgulas editavel apenas em INCLUIR/ALTERAR
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    FUNCTION PgDescrs_GrdDados_Col3_When()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *==========================================================================
    * PgDescrs_GrdDados_Col4_When - TpCompos editavel em INCLUIR/ALTERAR E CpMontas=3
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    FUNCTION PgDescrs_GrdDados_Col4_When()
        LOCAL loc_lResultado
        loc_lResultado = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        IF loc_lResultado AND USED("LocalProD") AND !EOF("LocalProD")
            loc_lResultado = (LocalProD.CpMontas = 3)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PgDescrs_GrdDados_Col5_When - ZeroDirs editavel em INCLUIR/ALTERAR E CpMontas=3
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    FUNCTION PgDescrs_GrdDados_Col5_When()
        LOCAL loc_lResultado
        loc_lResultado = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        IF loc_lResultado AND USED("LocalProD") AND !EOF("LocalProD")
            loc_lResultado = (LocalProD.CpMontas = 3)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PgDescrs_GrdDados_Col6_When - ChecaEtiqs editavel em INCLUIR/ALTERAR E CpMontas=3
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    FUNCTION PgDescrs_GrdDados_Col6_When()
        LOCAL loc_lResultado
        loc_lResultado = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        IF loc_lResultado AND USED("LocalProD") AND !EOF("LocalProD")
            loc_lResultado = (LocalProD.CpMontas = 3)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PgDescrs_GrdDados_Col7_When - Agrupar editavel em INCLUIR/ALTERAR E CpMontas=3
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    FUNCTION PgDescrs_GrdDados_Col7_When()
        LOCAL loc_lResultado
        loc_lResultado = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        IF loc_lResultado AND USED("LocalProD") AND !EOF("LocalProD")
            loc_lResultado = (LocalProD.CpMontas = 3)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PgDescrs_GrdDados_Col8_Valid - Valida Mercs (G.Grp.) em SigCdGpr
    * Abre FormBuscaAuxiliar se codigo nao encontrado
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    FUNCTION PgDescrs_GrdDados_Col8_Valid()
        LOCAL loc_lResultado, loc_cMercs, loc_nRet, loc_oPg3, loc_oBusca, loc_lContinuar
        loc_lResultado = .T.
        loc_cMercs     = ""
        loc_nRet       = 0
        loc_lContinuar = .T.
        loc_oPg3       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Divisoes.Page3

        TRY
            IF !PEMSTATUS(loc_oPg3, "grd_4c_Dados", 5)
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_cMercs = ALLTRIM(loc_oPg3.grd_4c_Dados.Column8.Text1.Value)
                IF EMPTY(loc_cMercs)
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descs FROM SigCdGpr WHERE codigos = " + EscaparSQL(loc_cMercs), ;
                    "cursor_4c_BuscaGpr")

                IF loc_nRet > 0 AND USED("cursor_4c_BuscaGpr")
                    IF RECCOUNT("cursor_4c_BuscaGpr") = 0
                        USE IN cursor_4c_BuscaGpr
                        *-- 1o parametro eh o HANDLE (par_nConn). Erro172.
                        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                            "SigCdGpr", "cursor_4c_BuscaGprCol", "codigos", ;
                            ALLTRIM(loc_cMercs), ;
                            "Grande Grupo")
                        IF VARTYPE(loc_oBusca) = "O"
                            *-- Show() so quando o Init NAO resolveu pelo match exato (Erro173)
                            IF !loc_oBusca.this_lAchouRegistro
                                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                                loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                                loc_oBusca.Show()
                            ENDIF
                            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGprCol")
                                SELECT cursor_4c_BuscaGprCol
                                loc_oPg3.grd_4c_Dados.Column8.Text1.Value = ;
                                    ALLTRIM(cursor_4c_BuscaGprCol.codigos)
                            ENDIF
                            loc_oBusca.Release()
                        ENDIF
                        IF USED("cursor_4c_BuscaGprCol")
                            USE IN cursor_4c_BuscaGprCol
                        ENDIF
                    ELSE
                        USE IN cursor_4c_BuscaGpr
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar Grande Grupo:" + CHR(13) + loc_oErro.Message, ;
                "FormGpd.PgDescrs_GrdDados_Col8_Valid")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * PgDescrs_GrdDados_Col8_When - Mercs editavel em INCLUIR/ALTERAR E CpMontas=3
    * PUBLIC: BINDEVENT requer metodo publico
    *==========================================================================
    FUNCTION PgDescrs_GrdDados_Col8_When()
        LOCAL loc_lResultado
        loc_lResultado = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        IF loc_lResultado AND USED("LocalProD") AND !EOF("LocalProD")
            loc_lResultado = (LocalProD.CpMontas = 3)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
