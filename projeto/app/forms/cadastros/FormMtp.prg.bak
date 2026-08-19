*==============================================================================
* FormMtp.prg - Formulario de Cadastro de Modelos de Trabalho de Producao
* Migrado de: SigCdMtp.SCX (frmcadastro)
* Tabela: SigIdPcp
*==============================================================================

DEFINE CLASS FormMtp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Modelos de Trabalho de Producao"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject     = .NULL.
    this_cModoAtual          = "LISTA"
    this_cIdChaveSelecionado = ""

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Modelos de Trabalho de Produ" + CHR(231) + CHR(227) + "o"

            THIS.this_oBusinessObject = CREATEOBJECT("MtpBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar MtpBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormMtp.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormMtp:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormMtp.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1: cabecalho, 5 botoes CRUD,
    * botao Encerrar e grid de listagem com 3 colunas (Tipos/Descs/Limites)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original Top=1; com compensacao +29 para PageFrame.Top=-29: Top=31
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
            .Top       = 15
            .Left      = 10
            .Width     = 769
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
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container Botoes CRUD (Grupo_op: Left=339, Top=-1, Width=389)
        *-- Canonico: Left=542, Top=29, Width=390, Height=85
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

        *-- Botao Incluir (Inserir no legado: Left=5, Top=5)
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

        *-- Botao Visualizar (Consultar no legado: Left=81, Top=5)
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

        *-- Botao Alterar (Alterar no legado: Left=157, Top=5)
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

        *-- Botao Excluir (Excluir no legado: Left=233, Top=5)
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

        *-- Botao Buscar (Procurar no legado: Left=309, Top=5)
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

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
        *-- Legado: Grupo_Saida.Left=719, Top=-1. Canonico: Left=917, Top=29, Width=90
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

        *-- Botao Encerrar (Sair no legado: Left=5, Top=5 dentro de Grupo_Saida)
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

        *-- Grid de lista (Grade no legado: FontName=Tahoma, FontSize=8, ForeColor=90,90,90)
        *-- Colunas originais: Tipos (Codigo), descs (Descricao), limites (Prod. Minima)
        *-- Top=88+29=117 (compensacao PageFrame), Width=890 (nao sobrepoe cnt_4c_Saida)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid              = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top          = 117
        loc_oGrid.Left         = 26
        loc_oGrid.Width        = 890
        loc_oGrid.Height       = 498
        loc_oGrid.ColumnCount  = 3
        loc_oGrid.RecordSource = ""
        loc_oGrid.FontName     = "Tahoma"
        loc_oGrid.FontSize     = 8
        loc_oGrid.ForeColor    = RGB(90, 90, 90)
        loc_oGrid.BackColor    = RGB(255, 255, 255)
        loc_oGrid.RowHeight    = 16
        loc_oGrid.GridLines    = 3
        loc_oGrid.GridLineColor      = RGB(238, 238, 238)
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle     = 2
        loc_oGrid.DeleteMark   = .F.
        loc_oGrid.RecordMark   = .F.
        loc_oGrid.ScrollBars   = 2
        loc_oGrid.Visible      = .T.

        WITH loc_oGrid.Column1
            .Width     = 80
            .Alignment = 0
        ENDWITH
        WITH loc_oGrid.Column1.Header1
            .Caption  = "C" + CHR(243) + "digo"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        WITH loc_oGrid.Column2
            .Width     = 440
            .Alignment = 0
        ENDWITH
        WITH loc_oGrid.Column2.Header1
            .Caption  = "Descri" + CHR(231) + CHR(227) + "o"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        WITH loc_oGrid.Column3
            .Width     = 150
            .Alignment = 3
        ENDWITH
        WITH loc_oGrid.Column3.Header1
            .Caption  = "Prod. M" + CHR(237) + "nima"
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 com todos os campos do formulario
    * Campos: Tipos, Grupos, Descs, Limites, Fmaxs, Valors, Moedas+DescMoe, Ganhos
    * Tops originais do legado compensados em +29 (PageFrame.Top=-29)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salva/Cancelar (Grupo_Salva no legado: Left=842, Top=4+29=33)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva.Left=5, Top=5 no legado)
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

        *-- Botao Cancelar (Cancelar.Left=81, Top=5 no legado)
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

        *-- === LINHA 1: Codigo (Say1.Top=147->176 / Get_tipos.Top=144->173) ===
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo : "
            .Top       = 176
            .Left      = 250
            .Height    = 17
            .Width     = 49
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
        WITH loc_oPagina.txt_4c_Tipos
            .Value     = ""
            .Top       = 173
            .Left      = 299
            .Width     = 24
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .MaxLength = 5
            .TabIndex  = 1
            .Visible   = .T.
        ENDWITH

        *-- === LINHA 2: Grupo (Say8.Top=174->203 / Get_grupo.Top=171->200) ===
        loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPagina.lbl_4c_Grupo
            .Caption   = "Grupo : "
            .Top       = 203
            .Left      = 254
            .Height    = 17
            .Width     = 45
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value     = ""
            .Top       = 200
            .Left      = 299
            .Width     = 80
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .MaxLength = 10
            .TabIndex  = 2
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress",  THIS, "GrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick",  THIS, "GrupoDblClick")

        *-- === LINHA 3: Descricao (Say2.Top=202->231 / Get_Descs.Top=199->228) ===
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
            .Top       = 231
            .Left      = 237
            .Height    = 17
            .Width     = 62
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value     = ""
            .Top       = 228
            .Left      = 299
            .Width     = 80
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .TabIndex  = 3
            .Visible   = .T.
        ENDWITH

        *-- === LINHA 4: Producao Minima (Say3.Top=229->258 / Get_limites.Top=226->255) ===
        loc_oPagina.AddObject("lbl_4c_ProdMinima", "Label")
        WITH loc_oPagina.lbl_4c_ProdMinima
            .Caption   = "Produ" + CHR(231) + CHR(227) + "o M" + CHR(237) + "nima : "
            .Top       = 258
            .Left      = 203
            .Height    = 17
            .Width     = 96
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Limites", "TextBox")
        WITH loc_oPagina.txt_4c_Limites
            .Value     = 0
            .Top       = 255
            .Left      = 299
            .Width     = 94
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 3
            .TabIndex  = 4
            .Visible   = .T.
        ENDWITH

        *-- === LINHA 5: Falha Admitida (Say4.Top=256->285 / Get_fmaxs.Top=253->282) + % (Say6.Top=256->285) ===
        loc_oPagina.AddObject("lbl_4c_FalhaAdmitida", "Label")
        WITH loc_oPagina.lbl_4c_FalhaAdmitida
            .Caption   = "Falha Admitida : "
            .Top       = 285
            .Left      = 213
            .Height    = 17
            .Width     = 86
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fmaxs", "TextBox")
        WITH loc_oPagina.txt_4c_Fmaxs
            .Value     = 0
            .Top       = 282
            .Left      = 299
            .Width     = 66
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 3
            .TabIndex  = 5
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Porcentagem", "Label")
        WITH loc_oPagina.lbl_4c_Porcentagem
            .Caption   = "%"
            .Top       = 285
            .Left      = 371
            .Height    = 17
            .Width     = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- === LINHA 6: Valor do Premio (Say5.Top=284->313 / Get_valors.Top=281->310) ===
        loc_oPagina.AddObject("lbl_4c_ValorPremio", "Label")
        WITH loc_oPagina.lbl_4c_ValorPremio
            .Caption   = "Valor do Pr" + CHR(234) + "mio : "
            .Top       = 313
            .Left      = 209
            .Height    = 17
            .Width     = 90
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Valors", "TextBox")
        WITH loc_oPagina.txt_4c_Valors
            .Value     = 0
            .Top       = 310
            .Left      = 299
            .Width     = 66
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 3
            .TabIndex  = 6
            .Visible   = .T.
        ENDWITH

        *-- === LINHA 7: Moeda (Say7.Top=311->340) + Cmoes (Top=308->337) + Dmoes (Top=308->337) ===
        loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
        WITH loc_oPagina.lbl_4c_Moeda
            .Caption   = "Moeda : "
            .Top       = 340
            .Left      = 251
            .Height    = 17
            .Width     = 48
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Moedas", "TextBox")
        WITH loc_oPagina.txt_4c_Moedas
            .Value     = ""
            .Top       = 337
            .Left      = 299
            .Width     = 31
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .MaxLength = 10
            .TabIndex  = 7
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Moedas, "KeyPress", THIS, "ValidarMoedaPorCodigo")
        BINDEVENT(loc_oPagina.txt_4c_Moedas, "KeyPress",  THIS, "MoedasKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Moedas, "DblClick",  THIS, "MoedasDblClick")

        loc_oPagina.AddObject("txt_4c_DescMoe", "TextBox")
        WITH loc_oPagina.txt_4c_DescMoe
            .Value     = ""
            .Top       = 337
            .Left      = 335
            .Width     = 115
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 0
            .TabIndex  = 8
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DescMoe, "KeyPress", THIS, "ValidarMoedaPorDescricao")
        BINDEVENT(loc_oPagina.txt_4c_DescMoe, "KeyPress",  THIS, "DescMoeKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DescMoe, "DblClick",  THIS, "DescMoeDblClick")

        *-- === LINHA 8: Contabilizar Ganhos (fwcheckbox.Top=338->367) ===
        loc_oPagina.AddObject("chk_4c_Ganhos", "CheckBox")
        WITH loc_oPagina.chk_4c_Ganhos
            .Caption   = "Contabilizar Ganhos"
            .Value     = 0
            .Top       = 367
            .Left      = 298
            .Width     = 132
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .TabIndex  = 9
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * Percorre Pages de PageFrames e Controls de Containers
    *===========================================================================
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

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "FormMtp.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados do BO no grid da Page1
    * Colunas: tipos (Codigo), descs (Descricao), limites (Prod.Minima)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            CREATE CURSOR cursor_4c_Dados (tipos c(10), grupos c(10), descs c(60), ;
                limites n(14,2), fmaxs n(14,2), valors n(14,2), moedas c(10), ;
                ganhos l, desc_moe c(60))
            loc_lResultado = .T.
        ELSE
            TRY
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource          = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.limites"

                    *-- Reconfigurar cabecalhos APOS ControlSource (VFP9 reseta ao alterar)
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Header1.Caption = "Prod. M" + CHR(237) + "nima"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao carregar lista:" + CHR(13) + ;
                    loException.Message, "FormMtp.CarregarLista")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista (fonte Tahoma 8)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Navega para Page2 em modo INCLUIR
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado em modo VISUALIZAR
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cTipos, loc_cGrupos

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cTipos  = ALLTRIM(cursor_4c_Dados.tipos)
        loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)

        IF THIS.this_oBusinessObject.CarregarPorTipoGrupo(loc_cTipos, loc_cGrupos)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado em modo ALTERAR
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cTipos, loc_cGrupos

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cTipos  = ALLTRIM(cursor_4c_Dados.tipos)
        loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)

        IF THIS.this_oBusinessObject.CarregarPorTipoGrupo(loc_cTipos, loc_cGrupos)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cTipos, loc_cGrupos, loc_lConfirma

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cTipos  = ALLTRIM(cursor_4c_Dados.tipos)
        loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
            "Excluir")

        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorTipoGrupo(loc_cTipos, loc_cGrupos)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
                        "Exclus" + CHR(227) + "o")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre busca (FormBuscaAuxiliar) e posiciona grid no resultado
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cTipos, loc_cGrupos, loc_nResult
        loc_cTipos  = ""
        loc_cGrupos = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT tipos, grupos, descs, limites" + ;
                " FROM SigIdPcp ORDER BY tipos, grupos", ;
                "cursor_4c_Busca")

            IF loc_nResult >= 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_Busca", "tipos", "descs", ;
                        "Buscar Modelo de Produ" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("limites", "", "Prod. M" + CHR(237) + "nima")
                    loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
                    IF loc_oBusca.Mostrar()
                        IF USED("cursor_4c_Busca")
                            SELECT cursor_4c_Busca
                            loc_cTipos  = ALLTRIM(cursor_4c_Busca.tipos)
                            loc_cGrupos = ALLTRIM(cursor_4c_Busca.grupos)
                            IF !EMPTY(loc_cTipos) AND USED("cursor_4c_Dados")
                                SELECT cursor_4c_Dados
                                LOCATE FOR ALLTRIM(tipos) == loc_cTipos AND ALLTRIM(grupos) == loc_cGrupos
                            ENDIF
                        ENDIF
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgErro("Erro ao buscar modelos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro na busca:" + CHR(13) + loException.Message, ;
                "FormMtp.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva o registro atual (INCLUIR ou ALTERAR)
    * Validacoes: Tipos e Grupos obrigatorios; duplicidade Tipos+Grupos no INCLUIR
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso, loc_oPag2, loc_cTipos, loc_cGrupos, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        loc_oPag2    = THIS.pgf_4c_Paginas.Page2
        loc_cTipos   = ALLTRIM(loc_oPag2.txt_4c_Tipos.Value)
        loc_cGrupos  = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)

        *-- Validacoes obrigatorias no modo INCLUIR (replicado do Salva.Click legado)
        IF THIS.this_cModoAtual == "INCLUIR"
            IF EMPTY(loc_cTipos)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo...", "")
                loc_oPag2.txt_4c_Tipos.SetFocus()
                RETURN .F.
            ENDIF
            IF EMPTY(loc_cGrupos)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo...", "")
                loc_oPag2.txt_4c_Grupo.SetFocus()
                RETURN .F.
            ENDIF

            *-- Verificar duplicidade de Tipos+Grupos
            loc_cSQL = "SELECT Tipos, Grupos FROM SigIdPcp" + ;
                " WHERE Tipos=" + EscaparSQL(loc_cTipos) + ;
                " AND Grupos=" + EscaparSQL(loc_cGrupos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesqDup")
            IF loc_nResult >= 0 AND USED("cursor_4c_PesqDup") AND !EOF("cursor_4c_PesqDup")
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado...", "")
                loc_oPag2.txt_4c_Grupo.SetFocus()
                USE IN cursor_4c_PesqDup
                RETURN .F.
            ENDIF
            IF USED("cursor_4c_PesqDup")
                USE IN cursor_4c_PesqDup
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            loc_lSucesso = THIS.this_oBusinessObject.Salvar()
            IF loc_lSucesso
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
                "FormMtp.BtnSalvarClick")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Volta para Page1 sem salvar
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * ValidarGrupo - LostFocus de txt_4c_Grupo: valida em SigCdGcr (gerbals=1)
    *===========================================================================
    PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor, loc_oBusca
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Gcr", "codigos", loc_cValor, ;
                "Selecionar Grupo", .F., .F., "gerbals=1")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Gcr")
                        SELECT cursor_4c_Gcr
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Gcr.codigos)
                    ELSE
                        THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar grupo:" + CHR(13) + loException.Message, ;
                "FormMtp.ValidarGrupo")
        ENDTRY

        IF USED("cursor_4c_Gcr")
            USE IN cursor_4c_Gcr
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarMoedaPorCodigo - LostFocus de txt_4c_Moedas: valida Cmoes em SigCdMoe
    * Se encontrado, preenche txt_4c_DescMoe; se nao, abre picker
    *===========================================================================
    PROCEDURE ValidarMoedaPorCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag2, loc_cValor, loc_oBusca
        loc_oPag2  = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPag2.txt_4c_Moedas.Value)

        IF EMPTY(loc_cValor)
            loc_oPag2.txt_4c_DescMoe.Value = ""
            loc_oPag2.txt_4c_DescMoe.ReadOnly = !((THIS.this_cModoAtual == "INCLUIR" OR ;
                THIS.this_cModoAtual == "ALTERAR"))
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Moe", "cmoes", loc_cValor, ;
                "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Moe")
                        SELECT cursor_4c_Moe
                        loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
                        loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                    ENDIF
                ELSE
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
                        SELECT cursor_4c_Moe
                        loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
                        loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
                        loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                    ELSE
                        loc_oPag2.txt_4c_Moedas.Value  = ""
                        loc_oPag2.txt_4c_DescMoe.Value = ""
                        loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar moeda:" + CHR(13) + loException.Message, ;
                "FormMtp.ValidarMoedaPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Moe")
            USE IN cursor_4c_Moe
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarMoedaPorDescricao - LostFocus de txt_4c_DescMoe: busca Dmoes em SigCdMoe
    * Se encontrado exato, preenche Moedas; se nao, abre picker
    *===========================================================================
    PROCEDURE ValidarMoedaPorDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPag2, loc_cValor, loc_oBusca
        loc_oPag2  = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPag2.txt_4c_DescMoe.Value)

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Moe", "dmoes", loc_cValor, ;
                "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_Moe")
                        SELECT cursor_4c_Moe
                        loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
                        loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
                        loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                    ENDIF
                ELSE
                    loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
                        SELECT cursor_4c_Moe
                        loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(cursor_4c_Moe.cmoes)
                        loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(cursor_4c_Moe.dmoes)
                        loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                    ELSE
                        loc_oPag2.txt_4c_Moedas.Value  = ""
                        loc_oPag2.txt_4c_DescMoe.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao validar moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormMtp.ValidarMoedaPorDescricao")
        ENDTRY

        IF USED("cursor_4c_Moe")
            USE IN cursor_4c_Moe
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos controles para propriedades do BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cTipos   = ALLTRIM(loc_oPag2.txt_4c_Tipos.Value)
        THIS.this_oBusinessObject.this_cGrupos  = ALLTRIM(loc_oPag2.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cDescs   = ALLTRIM(loc_oPag2.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_nLimites = loc_oPag2.txt_4c_Limites.Value
        THIS.this_oBusinessObject.this_nFmaxs   = loc_oPag2.txt_4c_Fmaxs.Value
        THIS.this_oBusinessObject.this_nValors  = loc_oPag2.txt_4c_Valors.Value
        THIS.this_oBusinessObject.this_cMoedas  = ALLTRIM(loc_oPag2.txt_4c_Moedas.Value)
        THIS.this_oBusinessObject.this_lGanhos  = loc_oPag2.chk_4c_Ganhos.Value
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do BO para os controles do formulario
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        loc_oPag2.txt_4c_Tipos.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
        loc_oPag2.txt_4c_Grupo.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
        loc_oPag2.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
        loc_oPag2.txt_4c_Limites.Value   = THIS.this_oBusinessObject.this_nLimites
        loc_oPag2.txt_4c_Fmaxs.Value     = THIS.this_oBusinessObject.this_nFmaxs
        loc_oPag2.txt_4c_Valors.Value    = THIS.this_oBusinessObject.this_nValors
        loc_oPag2.txt_4c_Moedas.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cMoedas)
        loc_oPag2.txt_4c_DescMoe.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDescMoe)
        loc_oPag2.chk_4c_Ganhos.Value    = THIS.this_oBusinessObject.this_lGanhos
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita controles conforme o modo atual
    *   tipos/grupos: editaveis apenas em INCLUIR
    *   campos gerais: editaveis em INCLUIR e ALTERAR
    *   txt_4c_DescMoe: editavel apenas quando Moedas esta vazio
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag2, loc_lIncluir, loc_lDescMoeHab
        loc_oPag2    = THIS.pgf_4c_Paginas.Page2
        loc_lIncluir = (THIS.this_cModoAtual == "INCLUIR")

        loc_oPag2.txt_4c_Tipos.ReadOnly      = !(par_lHabilitar AND loc_lIncluir)
        loc_oPag2.txt_4c_Grupo.ReadOnly      = !(par_lHabilitar AND loc_lIncluir)

        loc_oPag2.txt_4c_Descricao.ReadOnly  = !par_lHabilitar
        loc_oPag2.txt_4c_Limites.ReadOnly    = !par_lHabilitar
        loc_oPag2.txt_4c_Fmaxs.ReadOnly     = !par_lHabilitar
        loc_oPag2.txt_4c_Valors.ReadOnly     = !par_lHabilitar
        loc_oPag2.txt_4c_Moedas.ReadOnly     = !par_lHabilitar

        loc_lDescMoeHab = par_lHabilitar AND EMPTY(ALLTRIM(loc_oPag2.txt_4c_Moedas.Value))
        loc_oPag2.txt_4c_DescMoe.ReadOnly    = !loc_lDescMoeHab

        loc_oPag2.chk_4c_Ganhos.Enabled     = par_lHabilitar

        IF VARTYPE(loc_oPag2.cnt_4c_Salva) = "O"
            loc_oPag2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos de Page2 para valores defaults
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        loc_oPag2.txt_4c_Tipos.Value     = ""
        loc_oPag2.txt_4c_Grupo.Value     = ""
        loc_oPag2.txt_4c_Descricao.Value = ""
        loc_oPag2.txt_4c_Limites.Value   = 0
        loc_oPag2.txt_4c_Fmaxs.Value     = 0
        loc_oPag2.txt_4c_Valors.Value    = 0
        loc_oPag2.txt_4c_Moedas.Value    = ""
        loc_oPag2.txt_4c_DescMoe.Value   = ""
        loc_oPag2.chk_4c_Ganhos.Value    = 0
    ENDPROC

    *===========================================================================
    * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: abre lookup no F4
    *===========================================================================
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *===========================================================================
    * GrupoDblClick - Handler DblClick de txt_4c_Grupo
    *===========================================================================
    PROCEDURE GrupoDblClick()
        THIS.AbrirLookupGrupo()
    ENDPROC

    *===========================================================================
    * AbrirLookupGrupo - FormBuscaAuxiliar para SigCdGcr (gerbals=1)
    * Campos: codigos (Codigo), descrs (Descricao)
    *===========================================================================
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF loc_oPag2.txt_4c_Grupo.ReadOnly
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_Gcr", "codigos", "", ;
                "Selecionar Grupo", .F., .F., "gerbals=1")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Gcr")
                    SELECT cursor_4c_Gcr
                    loc_oPag2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_Gcr.codigos)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir lookup de grupo:" + CHR(13) + loException.Message, ;
                "FormMtp.AbrirLookupGrupo")
        ENDTRY

        IF USED("cursor_4c_Gcr")
            USE IN cursor_4c_Gcr
        ENDIF
    ENDPROC

    *===========================================================================
    * MoedasKeyPress - Handler KeyPress de txt_4c_Moedas: abre lookup no F4
    *===========================================================================
    PROCEDURE MoedasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupMoedaCodigo()
        ENDIF
    ENDPROC

    *===========================================================================
    * MoedasDblClick - Handler DblClick de txt_4c_Moedas
    *===========================================================================
    PROCEDURE MoedasDblClick()
        THIS.AbrirLookupMoedaCodigo()
    ENDPROC

    *===========================================================================
    * AbrirLookupMoedaCodigo - FormBuscaAuxiliar para SigCdMoe por CMOES
    * Campos: cmoes (Codigo), dmoes (Descricao)
    *===========================================================================
    PROCEDURE AbrirLookupMoedaCodigo()
        LOCAL loc_oBusca, loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF loc_oPag2.txt_4c_Moedas.ReadOnly
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Moe", "cmoes", "", ;
                "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
                    SELECT cursor_4c_Moe
                    loc_oPag2.txt_4c_Moedas.Value     = ALLTRIM(cursor_4c_Moe.cmoes)
                    loc_oPag2.txt_4c_DescMoe.Value    = ALLTRIM(cursor_4c_Moe.dmoes)
                    loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                ELSE
                    loc_oPag2.txt_4c_Moedas.Value  = ""
                    loc_oPag2.txt_4c_DescMoe.Value = ""
                    loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir lookup de moeda:" + CHR(13) + loException.Message, ;
                "FormMtp.AbrirLookupMoedaCodigo")
        ENDTRY

        IF USED("cursor_4c_Moe")
            USE IN cursor_4c_Moe
        ENDIF
    ENDPROC

    *===========================================================================
    * DescMoeKeyPress - Handler KeyPress de txt_4c_DescMoe: abre lookup no F4
    *===========================================================================
    PROCEDURE DescMoeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupMoedaDescricao()
        ENDIF
    ENDPROC

    *===========================================================================
    * DescMoeDblClick - Handler DblClick de txt_4c_DescMoe
    *===========================================================================
    PROCEDURE DescMoeDblClick()
        THIS.AbrirLookupMoedaDescricao()
    ENDPROC

    *===========================================================================
    * AbrirLookupMoedaDescricao - FormBuscaAuxiliar para SigCdMoe por DMOES
    * Campos: cmoes (Codigo), dmoes (Descricao)
    *===========================================================================
    PROCEDURE AbrirLookupMoedaDescricao()
        LOCAL loc_oBusca, loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        IF loc_oPag2.txt_4c_DescMoe.ReadOnly
            RETURN
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_Moe", "dmoes", "", ;
                "Selecionar Moeda")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Moe")
                    SELECT cursor_4c_Moe
                    loc_oPag2.txt_4c_Moedas.Value     = ALLTRIM(cursor_4c_Moe.cmoes)
                    loc_oPag2.txt_4c_DescMoe.Value    = ALLTRIM(cursor_4c_Moe.dmoes)
                    loc_oPag2.txt_4c_DescMoe.ReadOnly = .T.
                ELSE
                    loc_oPag2.txt_4c_Moedas.Value  = ""
                    loc_oPag2.txt_4c_DescMoe.Value = ""
                    loc_oPag2.txt_4c_DescMoe.ReadOnly = .F.
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir lookup de moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormMtp.AbrirLookupMoedaDescricao")
        ENDTRY

        IF USED("cursor_4c_Moe")
            USE IN cursor_4c_Moe
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta foco conforme o modo atual
    * Legado: INSERIR->get_Tipos, ALTERAR->get_descs, CONSULTAR->salva.cancelar
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPag2
        loc_oPag2 = THIS.pgf_4c_Paginas.Page2

        DO CASE
        CASE THIS.this_cModoAtual == "INCLUIR"
            loc_oPag2.txt_4c_Tipos.SetFocus()
        CASE THIS.this_cModoAtual == "ALTERAR"
            loc_oPag2.txt_4c_Descricao.SetFocus()
        CASE THIS.this_cModoAtual == "VISUALIZAR"
            IF VARTYPE(loc_oPag2.cnt_4c_Salva) = "O"
                loc_oPag2.cnt_4c_Salva.cmd_4c_Cancelar.SetFocus()
            ENDIF
        ENDCASE
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos do formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
