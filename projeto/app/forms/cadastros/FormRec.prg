*==============================================================================
* FormRec.prg - Formulario de Cadastro Financeiro de Recebimentos
* Migrado de: SIGCDREC (frmcadastro)
* Tabela: SIGCDREC
* Chave: grupos char(10) - FK -> SigCdGcr.codigos
*==============================================================================

DEFINE CLASS FormRec AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro Financeiro de Recebimentos"
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

    *==========================================================================
    * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado pelo FormBase.Init() via DODEFAULT()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ELSE
                THIS.this_oBusinessObject = CREATEOBJECT("RecBO")

                IF VARTYPE(THIS.this_oBusinessObject) != "O"
                    MostrarErro("Erro ao criar RecBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "FormRec.InicializarForm")
                ELSE
                    THIS.ConfigurarPageFrame()

                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                    THIS.pgf_4c_Paginas.Visible   = .T.
                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.this_cModoAtual = "LISTA"

                    THIS.CarregarLista()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormRec:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormRec.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame (Top=-29 esconde abas)
    * Todos os controles dentro das Pages compensam +29 no Top
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

    *==========================================================================
    * ConfigurarPaginaLista - Page1: Cabecalho + Botoes CRUD + Grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho - Top=30 (1+29 compensacao PageFrame)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
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
            .Width     = THIS.Width - 20
            .Height    = 46
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

        *-- Container botoes CRUD - canonico Left=542, Top=29 (0+29 compensacao)
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - valores canonicos CLAUDE.md regra #10
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem: Top=117 (88+29), Left=26, Width=890, Height=498
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 890
            .Height             = 498
            .ColumnCount        = 2
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
    * ConfigurarPaginaDados - Page2: Botoes Confirmar/Cancelar + campos do form
    * Campos: txt_4c_CdGrupo (codigos char(10)) + txt_4c_DsGrupo (descrs char(40))
    * Legado: get_cd_grupo (top=193, left=253) e get_ds_grupo (top=193, left=335)
    * Compensacao PageFrame +29: todos os tops recebem +29
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar - Top=33 (4+29 compensacao PageFrame)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label titulo secao (lbl_cadastro legado: top=175, left=255; compensado +29=204)
        loc_oPagina.AddObject("lbl_4c_Cadastro", "Label")
        WITH loc_oPagina.lbl_4c_Cadastro
            .Caption   = "Cadastro de Contas a Receber"
            .Top       = 204
            .Left      = 255
            .Width     = 280
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label "Grupo :" (lbl_grupo legado: top=198, left=206, width=38; compensado +29=227)
        loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPagina.lbl_4c_Grupo
            .Caption   = "Grupo :"
            .Top       = 227
            .Left      = 206
            .Width     = 38
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo do Grupo (get_cd_grupo legado: top=193,left=253,w=79,h=23; +29=222)
        *-- SigCdGcr.codigos char(10); editavel apenas no modo INCLUIR (get_cd_grupo.When)
        loc_oPagina.AddObject("txt_4c_CdGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_CdGrupo
            .Value     = ""
            .Top       = 222
            .Left      = 253
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 10
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "KeyPress", THIS, "ValidarCodigo")
        BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "KeyPress", THIS, "CdGrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_CdGrupo, "DblClick", THIS, "CdGrupoDblClick")

        *-- TextBox Descricao do Grupo (get_ds_grupo legado: top=193,left=335,w=150,h=23; +29=222)
        *-- SigCdGcr.descrs char(40); editavel apenas no modo INCLUIR (get_ds_grupo.When)
        loc_oPagina.AddObject("txt_4c_DsGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DsGrupo
            .Value     = ""
            .Top       = 222
            .Left      = 335
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 40
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "KeyPress", THIS, "ValidarDescricao")
        BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "KeyPress", THIS, "DsGrupoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_DsGrupo, "DblClick", THIS, "DsGrupoDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega cursor_4c_Dados no Grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                CREATE CURSOR cursor_4c_Dados (grupos C(10), descrs C(40))
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount FORA do WITH (Problema 36)
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 2

                    WITH loc_oGrid
                        .Column1.ControlSource   = "cursor_4c_Dados.grupos"
                        .Column1.Width           = 100
                        .Column1.Header1.Caption = "Grupo"

                        .Column2.ControlSource   = "cursor_4c_Dados.descrs"
                        .Column2.Width           = 780
                        .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ELSE
                    loc_lResultado = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1=Lista(1) e Page2=Dados(2)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia inclusao de novo registro (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            THIS.this_oBusinessObject.NovoRegistro()
        ENDIF
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza registro selecionado (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cGrupo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Visualizar")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Edita registro selecionado (PUBLIC para BINDEVENT)
    * Legado: em ALTERAR, campos ficam somente leitura (legado nao habilitava edicao)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cGrupo
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Alterar")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cGrupo, loc_lConfirma
        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado!", "Excluir")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cGrupo = ALLTRIM(cursor_4c_Dados.grupos)
        loc_lConfirma = MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo '" + ;
            loc_cGrupo + "'?", "Excluir Recebimento")
        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Localiza registro via FormBuscaAuxiliar (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cGrupo, loc_lSelecionou
        loc_lSelecionou = .F.
        loc_cGrupo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SIGCDREC", "cursor_4c_BuscaRec", "grupos", "", ;
                "Buscar Recebimento")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("grupos", "", "Grupo")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRec")
                    SELECT cursor_4c_BuscaRec
                    loc_cGrupo      = ALLTRIM(cursor_4c_BuscaRec.grupos)
                    loc_lSelecionou = .T.
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro na busca:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaRec")
            USE IN cursor_4c_BuscaRec
        ENDIF

        IF loc_lSelecionou AND USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(grupos) = loc_cGrupo
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva o registro (PUBLIC para BINDEVENT, chamado de Page2)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        *-- Validacao ANTES do TRY (CLAUDE.md regra critica)
        IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.Value))
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.SetFocus()
            RETURN loc_lSucesso
        ENDIF

        *-- Verificar duplicidade apenas no INCLUIR (legado: ChkRegister)
        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarCodigoExiste( ;
                ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.Value))
                MsgAviso("Grupo j" + CHR(225) + " cadastrado!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                THIS.pgf_4c_Paginas.Page2.txt_4c_CdGrupo.SetFocus()
                RETURN loc_lSucesso
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Salvar")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta a lista (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere campos do form para o BO antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cGrupos = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)
        THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_DsGrupo.Value)
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_CdGrupo.Value = THIS.this_oBusinessObject.this_cGrupos
        loc_oPagina.txt_4c_DsGrupo.Value = THIS.this_oBusinessObject.this_cDescrs
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa valores dos campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_CdGrupo.Value = ""
        loc_oPagina.txt_4c_DsGrupo.Value = ""
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos por modo
    * Legado: get_cd_grupo.When = INSERIR|PROCURAR; get_ds_grupo.When = INSERIR
    * Ambos os campos somente editaveis em INCLUIR
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_CdGrupo.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
        loc_oPagina.txt_4c_DsGrupo.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta botoes da Page2 conforme modo atual
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        DO CASE
            CASE THIS.this_cModoAtual = "VISUALIZAR"
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            OTHERWISE
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDCASE
    ENDPROC

    *==========================================================================
    * CdGrupoKeyPress - F4 em txt_4c_CdGrupo abre lookup SigCdGcr
    * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE CdGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4 em VFP9
            THIS.AbrirBuscaGrupo("")
        ENDIF
    ENDPROC

    *==========================================================================
    * CdGrupoDblClick - DblClick em txt_4c_CdGrupo abre lookup SigCdGcr
    * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE CdGrupoDblClick()
        THIS.AbrirBuscaGrupo("")
    ENDPROC

    *==========================================================================
    * DsGrupoKeyPress - F4 em txt_4c_DsGrupo abre lookup SigCdGcr por descricao
    * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE DsGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDesc
        IF par_nKeyCode = 28  && F4 em VFP9
            loc_cDesc = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DsGrupo.Value)
            THIS.AbrirBuscaGrupo(loc_cDesc)
        ENDIF
    ENDPROC

    *==========================================================================
    * DsGrupoDblClick - DblClick em txt_4c_DsGrupo abre lookup SigCdGcr por descricao
    * PUBLIC obrigatorio: BINDEVENT requer PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE DsGrupoDblClick()
        LOCAL loc_cDesc
        loc_cDesc = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DsGrupo.Value)
        THIS.AbrirBuscaGrupo(loc_cDesc)
    ENDPROC

    *==========================================================================
    * ValidarCodigo - LostFocus de txt_4c_CdGrupo: busca descricao em SigCdGcr
    * Equivale a get_cd_grupo.Valid (fAcessoContab 'C') do legado
    * PUBLIC obrigatorio: BINDEVENT requer metodo PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE ValidarCodigo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cCodigo, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGrupo.Value)

        IF EMPTY(loc_cCodigo)
            loc_oPagina.txt_4c_DsGrupo.Value = ""
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cCodigo, "C")
            IF USED("cursor_4c_BuscaGcr") AND RECCOUNT("cursor_4c_BuscaGcr") > 0
                SELECT cursor_4c_BuscaGcr
                IF ALLTRIM(UPPER(cursor_4c_BuscaGcr.grupos)) = UPPER(loc_cCodigo)
                    loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                ELSE
                    THIS.AbrirBuscaGrupo(loc_cCodigo)
                ENDIF
            ELSE
                THIS.AbrirBuscaGrupo(loc_cCodigo)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDescricao - LostFocus de txt_4c_DsGrupo: busca codigo em SigCdGcr
    * Equivale a get_ds_grupo.Valid (fAcessoContab 'D') do legado
    * PUBLIC obrigatorio: BINDEVENT requer metodo PUBLIC (CLAUDE.md regra #3)
    *==========================================================================
    PROCEDURE ValidarDescricao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cDesc, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_DsGrupo.Value)

        IF EMPTY(loc_cDesc)
            loc_oPagina.txt_4c_CdGrupo.Value = ""
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cDesc, "D")
            IF USED("cursor_4c_BuscaGcr") AND RECCOUNT("cursor_4c_BuscaGcr") > 0
                SELECT cursor_4c_BuscaGcr
                IF RECCOUNT("cursor_4c_BuscaGcr") = 1
                    loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.grupos)
                    loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                ELSE
                    THIS.AbrirBuscaGrupo(loc_cDesc)
                ENDIF
            ELSE
                THIS.AbrirBuscaGrupo(loc_cDesc)
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para selecao em SigCdGcr
    *==========================================================================
    PROTECTED PROCEDURE AbrirBuscaGrupo(par_cFiltro)
        LOCAL loc_oBusca, loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "grupos", par_cFiltro, ;
                "Selecionar Grupo Cont" + CHR(225) + "bil")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("grupos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    loc_oPagina.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.grupos)
                    loc_oPagina.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                ELSE
                    loc_oPagina.txt_4c_CdGrupo.Value = ""
                    loc_oPagina.txt_4c_DsGrupo.Value = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao abrir busca de grupo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Necessario pois AddObject() cria controles com Visible=.F. por padrao
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
    * Destroy - Libera recursos
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
