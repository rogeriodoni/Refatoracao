*==============================================================================
* FormUfs.prg - Formulario de Cadastro de Estados (UFs)
* Tabela: SigCdUfs
* Herda de: FormBase
* Tipo: CRUD (frmcadastro)
* Migrado de: SigCdUfs.SCX (SIGCDUFD)
*==============================================================================

DEFINE CLASS FormUfs AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Estados"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    BackColor   = RGB(100, 100, 100)

    *-- Propriedades internas
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *==========================================================================
    * Init - Delega para FormBase (que chama InicializarForm)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria estrutura base do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("UfsBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar UfsBO", "Erro")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_sombra2.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_titulo2.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                *-- Carregar lista inicial (apenas se nao estiver em modo validacao UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 2 paginas (Lista e Dados)
    * e containers base de cabecalho/botoes em cada pagina
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 631    && runtime adiciona +4 -> total 635
            .Tabs      = .F.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * PAGE 1 - Container sombra/titulo (cntSombra: Top=2 + 29 = 31)
        *----------------------------------------------------------------------
        THIS.pgf_4c_Paginas.Page1.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra
            .Top         = 31
            .Left        = 0
            .Width       = 1009
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra
            .Caption   = THIS.Caption
            .Top       = 45
            .Left      = 12
            .Width     = 980
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(30, 30, 30)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo
            .Caption   = THIS.Caption
            .Top       = 43
            .Left      = 10
            .Width     = 980
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD - Page1 (Grupo_op: Left=543, Top=0; +29 = 29)
        THIS.pgf_4c_Paginas.Page1.AddObject("cnt_4c_Botoes", "Container")
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            .Top         = 29
            .Left        =  542
            .Width       = 380
            .Height      = 88
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container botao Encerrar - Page1 (Grupo_Saida: Left=918, Top=0; +29 = 29)
        THIS.pgf_4c_Paginas.Page1.AddObject("cnt_4c_BotaoSair", "Container")
        WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_BotaoSair
            .Top         = 29
            .Left        = 918
            .Width       = 80
            .Height      = 88
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * PAGE 2 - Container sombra/titulo (compensacao Top = 2 + 29 = 31)
        *----------------------------------------------------------------------
        THIS.pgf_4c_Paginas.Page2.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra
            .Top         = 31
            .Left        = 0
            .Width       = 1009
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.AddObject("lbl_4c_sombra2", "Label")
        WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_sombra2
            .Caption   = THIS.Caption
            .Top       = 45
            .Left      = 12
            .Width     = 980
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(30, 30, 30)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.AddObject("lbl_4c_titulo2", "Label")
        WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_Sombra.lbl_4c_titulo2
            .Caption   = THIS.Caption
            .Top       = 43
            .Left      = 10
            .Width     = 980
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container botoes Salvar/Cancelar - Page2 (Grupo_Salva: Left=842, Top=4; +29 = 33)
        THIS.pgf_4c_Paginas.Page2.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Cria botoes CRUD e Grid na Page1
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCnt, loc_oSair, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Botoes CRUD no cnt_4c_Botoes (ja criado no ConfigurarPageFrame)
        * Posicoes baseadas no Framework: Grupo_op com botoes Left=5,80,155,230,305
        *----------------------------------------------------------------------
        loc_oCnt = loc_oPagina.cnt_4c_Botoes

        *-- Incluir
        loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Visualizar
        loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar
        loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir
        loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oCnt.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Buscar
        loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *----------------------------------------------------------------------
        * Botao Encerrar no cnt_4c_BotaoSair
        *----------------------------------------------------------------------
        loc_oSair = loc_oPagina.cnt_4c_BotaoSair
        loc_oSair.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oSair.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        BINDEVENT(loc_oSair.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * Grid de listagem (Grade no original: top=121+29=150, left=12)
        * Colunas: estados(UF), descrs(Nome), aicms, bicms, areduzidas
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top         = 150
        loc_oGrid.Left        = 12
        loc_oGrid.Width       = 941
        loc_oGrid.Height      = 470
        loc_oGrid.ColumnCount = 5

        WITH loc_oGrid
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

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgErro("Par" + CHR(226) + "metro inv" + CHR(225) + "lido em AlternarPagina.", "Erro")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega cursor_4c_Dados no grid da Page1
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    loc_lResultado = .F.
                ELSE
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 5

                    *-- ControlSource APOS RecordSource (Problema 48)
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.estados"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aicms"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.bicms"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.areduzidas"

                    *-- Larguras das colunas (originais: 40, 250, 80, 80, 80)
                    loc_oGrid.Column1.Width = 60
                    loc_oGrid.Column2.Width = 350
                    loc_oGrid.Column3.Width = 90
                    loc_oGrid.Column4.Width = 100
                    loc_oGrid.Column5.Width = 110

                    *-- Headers APOS RecordSource (Problema 6 / Problema 32)
                    loc_oGrid.Column1.Header1.Caption = "UF"
                    loc_oGrid.Column2.Header1.Caption = "Nome"
                    loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "q. ICMS"
                    loc_oGrid.Column4.Header1.Caption = "B.ICMS Redu"
                    loc_oGrid.Column5.Header1.Caption = "Al" + CHR(237) + "q. Reduzida"

                    *-- Alinhamento das colunas numericas
                    loc_oGrid.Column1.Alignment = 0
                    loc_oGrid.Column2.Alignment = 0
                    loc_oGrid.Column3.Alignment = 2
                    loc_oGrid.Column4.Alignment = 2
                    loc_oGrid.Column5.Alignment = 2

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.FormatarGridLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles do container visiveis
    * Percorre recursivamente Pages de PageFrames e Controls de Containers
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP
        loc_nI = 0
        loc_nP = 0

        TRY
            FOR loc_nI = 1 TO par_oContainer.ControlCount
                loc_oObjeto = par_oContainer.Controls(loc_nI)

                IF VARTYPE(loc_oObjeto) = "O"
                    IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                        IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_SOMBRA")
                            loc_oObjeto.Visible = .T.
                        ENDIF
                    ENDIF

                    *-- Trata PageFrame - itera Pages
                    IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                        FOR loc_nP = 1 TO loc_oObjeto.PageCount
                            THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                        ENDFOR
                    ENDIF

                    *-- Trata containers com ControlCount
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDFOR
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Abre Page2 em modo INCLUIR (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
            THIS.pgf_4c_Paginas.ActivePage = 2
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre Page2 em modo VISUALIZAR com registro selecionado
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cEstado
        loc_cEstado = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarChkboxesPorBoConteudo()
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
                    THIS.pgf_4c_Paginas.ActivePage = 2
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre Page2 em modo ALTERAR com registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cEstado
        loc_cEstado = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)

                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.BOParaForm()
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarChkboxesPorBoConteudo()
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
                    THIS.pgf_4c_Paginas.ActivePage = 2
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui registro selecionado com confirmacao
    * Verifica dependencias em SigCdCli antes de excluir
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cEstado, loc_cDescr, loc_nDep, loc_lConfirmado
        loc_cEstado    = ""
        loc_cDescr     = ""
        loc_nDep       = 0
        loc_lConfirmado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
                MsgAviso("Nenhum registro selecionado.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                SELECT cursor_4c_Dados
                loc_cEstado = ALLTRIM(cursor_4c_Dados.estados)
                loc_cDescr  = ALLTRIM(cursor_4c_Dados.descrs)

                *-- Verificar dependencia em SigCdCli (clientes cadastrados neste estado)
                SQLEXEC(gnConnHandle, ;
                    "SELECT COUNT(*) AS qtd FROM SigCdCli WHERE Estas = " + EscaparSQL(loc_cEstado), ;
                    "cursor_4c_DepCli")
                IF USED("cursor_4c_DepCli")
                    SELECT cursor_4c_DepCli
                    loc_nDep = NVL(cursor_4c_DepCli.qtd, 0)
                    USE IN cursor_4c_DepCli
                ENDIF

                IF loc_nDep > 0
                    MsgAviso("UF '" + loc_cEstado + "' n" + CHR(227) + "o pode ser exclu" + ;
                        CHR(237) + "do." + CHR(13) + ;
                        "Existem " + TRANSFORM(loc_nDep) + " cliente(s) cadastrado(s) neste estado.", ;
                        "Depend" + CHR(234) + "ncia")
                ELSE
                    loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do estado:" + ;
                        CHR(13) + loc_cEstado + " - " + loc_cDescr, ;
                        "Confirmar Exclus" + CHR(227) + "o")

                    IF loc_lConfirmado
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cEstado)
                            IF THIS.this_oBusinessObject.Excluir()
                                MsgSucesso("Estado exclu" + CHR(237) + "do com sucesso!")
                                THIS.CarregarLista()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Abre pesquisa de estados e recarrega lista com filtro
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cFiltro
        loc_cFiltro = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUfs", "cursor_4c_BuscaEstados", "estados", "", ;
                "Buscar Estado")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("estados", "", "UF")
                loc_oBusca.mAddColuna("descrs",  "", "Nome")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEstados")
                    SELECT cursor_4c_BuscaEstados
                    loc_cFiltro = ALLTRIM(cursor_4c_BuscaEstados.estados)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaEstados")
                USE IN cursor_4c_BuscaEstados
            ENDIF

            *-- Recarrega lista com filtro (ou sem filtro se vazio)
            IF EMPTY(loc_cFiltro)
                THIS.CarregarLista()
            ELSE
                LOCAL loc_oGrid
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    loc_oGrid.ColumnCount = 5
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 5

                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.estados"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aicms"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.bicms"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.areduzidas"

                    loc_oGrid.Column1.Header1.Caption = "UF"
                    loc_oGrid.Column2.Header1.Caption = "Nome"
                    loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "q. ICMS"
                    loc_oGrid.Column4.Header1.Caption = "B.ICMS Redu"
                    loc_oGrid.Column5.Header1.Caption = "Al" + CHR(237) + "q. Reduzida"

                    THIS.FormatarGridLista(loc_oGrid)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.BtnBuscarClick")
            IF USED("cursor_4c_BuscaEstados")
                USE IN cursor_4c_BuscaEstados
            ENDIF
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarChkboxesPorBoConteudo - Ajusta enabled/value dos checkboxes
    * conforme o conteudo do BO (logica do Activate original)
    * Chamado apos BOParaForm() em VISUALIZAR e ALTERAR
    *==========================================================================
    PROTECTED PROCEDURE AjustarChkboxesPorBoConteudo()
        LOCAL loc_oPg2, loc_lGer50, loc_lGer60
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lGer50 = (THIS.this_oBusinessObject.this_nGer50 <> 0)
        loc_lGer60 = (THIS.this_oBusinessObject.this_nGer60 <> 0)

        TRY
            *-- Ger50 controla Ger54 (Tipo 54 so valido se Tipo 50 ativo)
            IF PEMSTATUS(loc_oPg2, "chk_4c_ChkGer54", 5)
                IF !loc_lGer50
                    loc_oPg2.chk_4c_ChkGer54.Value   = 0
                    loc_oPg2.chk_4c_ChkGer54.Enabled = .F.
                ELSE
                    loc_oPg2.chk_4c_ChkGer54.Enabled = .T.
                ENDIF
            ENDIF

            *-- Ger60 controla Ger60I/D/R/P (subcategorias)
            IF PEMSTATUS(loc_oPg2, "chk_4c_ChkGer60I", 5)
                IF !loc_lGer60
                    loc_oPg2.chk_4c_ChkGer60I.Value   = 0
                    loc_oPg2.chk_4c_ChkGer60I.Enabled = .F.
                    loc_oPg2.chk_4c_ChkGer60D.Value   = 0
                    loc_oPg2.chk_4c_ChkGer60D.Enabled = .F.
                    loc_oPg2.chk_4c_ChkGer60R.Value   = 0
                    loc_oPg2.chk_4c_ChkGer60R.Enabled = .F.
                    loc_oPg2.chk_4c_ChkGer60P.Value   = 0
                    loc_oPg2.chk_4c_ChkGer60P.Enabled = .F.
                ELSE
                    loc_oPg2.chk_4c_ChkGer60I.Enabled = .T.
                    loc_oPg2.chk_4c_ChkGer60D.Enabled = .T.
                    loc_oPg2.chk_4c_ChkGer60R.Enabled = .T.
                    loc_oPg2.chk_4c_ChkGer60P.Enabled = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.AjustarChkboxesPorBoConteudo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Cria campos de edicao na Page2 (PARTE 1 - 50%)
    * Campos principais: Botoes Confirmar/Cancelar, campos de texto,
    * labels, combobox IPI, shape separador, label Sintegra
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Botoes Confirmar / Cancelar em cnt_4c_BotoesAcao
        * (container ja criado em ConfigurarPageFrame: Top=33, Left=842)
        *----------------------------------------------------------------------
        loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao

        loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Confirmar
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
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
        BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * Label "U.F. :" (Say1: top=116+29=145, left=254, width=33)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "U.F. :"
            .Top       = 145
            .Left      = 254
            .Width     = 33
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox getEstado - sigla UF (top=111+29=140, left=289, width=24)
        * Editavel apenas nos modos INSERIR/PROCURAR (When event no original)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Estado", "TextBox")
        WITH loc_oPagina.txt_4c_Estado
            .Value     = ""
            .Top       = 140
            .Left      = 289
            .Width     = 24
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 2
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Get_Descr - Descricao (top=111+29=140, left=315, width=276)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
        WITH loc_oPagina.txt_4c_Descr
            .Value     = ""
            .Top       = 140
            .Left      = 315
            .Width     = 276
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 30
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Cod. IBGE :" (Say5: top=116+29=145, left=617, width=58)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "C" + CHR(243) + "d. IBGE :"
            .Top       = 145
            .Left      = 617
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox getUFIBGES - Codigo IBGE (top=111+29=140, left=675, width=24)
        * Editavel apenas nos modos INSERIR/PROCURAR (When event no original)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_UFIBGES", "TextBox")
        WITH loc_oPagina.txt_4c_UFIBGES
            .Value     = 0
            .Top       = 140
            .Left      = 675
            .Width     = 24
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Aliquota de ICMS :" (Say2: top=143+29=172, left=193, width=94)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Al" + CHR(237) + "quota de ICMS :"
            .Top       = 172
            .Left      = 193
            .Width     = 94
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox getAicms - Aliquota ICMS (top=138+29=167, left=289, width=45)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Aicms", "TextBox")
        WITH loc_oPagina.txt_4c_Aicms
            .Value     = 0
            .Top       = 167
            .Left      = 289
            .Width     = 45
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "N"
            .InputMask = "99.99"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Base de ICMS Reduzida :" (Say3: top=143+29=172, left=361, width=125)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Base de ICMS Reduzida :"
            .Top       = 172
            .Left      = 361
            .Width     = 125
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox getBicms - Base ICMS Reduzida (top=138+29=167, left=489, width=45)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Bicms", "TextBox")
        WITH loc_oPagina.txt_4c_Bicms
            .Value     = 0
            .Top       = 167
            .Left      = 489
            .Width     = 45
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "N"
            .InputMask = "99.99"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "IPI :" (Say6: top=143+29=172, left=649, width=26)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "IPI :"
            .Top       = 172
            .Left      = 649
            .Width     = 26
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * ComboBox cmbIpi - Tipo IPI (top=138+29=167, left=675, width=91)
        * Itens: Tributado, Isento, Outros
        * Habilitado apenas nos modos INSERIR/ALTERAR (When no original)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cbo_4c_CmbIpi", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbIpi
            .Top           = 167
            .Left          = 675
            .Width         = 91
            .Height        = 25
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 0
            .Style         = 2
            .Visible       = .T.
        ENDWITH
        *-- Popula itens (logica do Activate original: padr(texto,9))
        loc_oPagina.cbo_4c_CmbIpi.AddItem(PADR("Tributado", 9))
        loc_oPagina.cbo_4c_CmbIpi.AddItem(PADR("Isento",    9))
        loc_oPagina.cbo_4c_CmbIpi.AddItem(PADR("Outros",    9))

        *----------------------------------------------------------------------
        * Label "Aliquota Local SubstituicaoTributaria :"
        * (Say7: top=170+29=199, left=102, width=185)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Al" + CHR(237) + "quota Local Substitui" + CHR(231) + ;
                         CHR(227) + "oTribut" + CHR(225) + "ria :"
            .Top       = 199
            .Left      = 102
            .Width     = 185
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Get_AliqSB - Aliquota Local ST (top=165+29=194, left=289, width=45)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_AliqSB", "TextBox")
        WITH loc_oPagina.txt_4c_AliqSB
            .Value     = 0
            .Top       = 194
            .Left      = 289
            .Width     = 45
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "N"
            .InputMask = "99.99"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Aliquota Reduzida :" (Say4: top=170+29=199, left=388, width=98)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Al" + CHR(237) + "quota Reduzida :"
            .Top       = 199
            .Left      = 388
            .Width     = 98
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox getAreduzida - Aliquota Reduzida (top=165+29=194, left=489, width=45)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Areduzida", "TextBox")
        WITH loc_oPagina.txt_4c_Areduzida
            .Value     = 0
            .Top       = 194
            .Left      = 489
            .Width     = 45
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "N"
            .InputMask = "99.99"
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * CheckBox CAT 52 (fwcheckbox6: top=169+29=198, left=615, width=60)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("chk_4c_Fwcheckbox6", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox6
            .Caption   = "CAT 52 :"
            .Value     = 0
            .Top       = 198
            .Left      = 615
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "LayOut NFCe :" (Say8: top=197+29=226, left=211, width=76)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "LayOut NFCe :"
            .Top       = 226
            .Left      = 211
            .Width     = 76
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox layoutnf - Layout NFC-e (top=192+29=221, left=289, width=89)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Layoutnf", "TextBox")
        WITH loc_oPagina.txt_4c_Layoutnf
            .Value     = ""
            .Top       = 221
            .Left      = 289
            .Width     = 89
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 8
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Shape2 - Separador horizontal entre campos e secao Sintegra
        * (top=228+29=257, left=9, width=980, height=1)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top         = 257
            .Left        = 9
            .Width       = 980
            .Height      = 1
            .BackStyle   = 1
            .BackColor   = RGB(128, 128, 128)
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label "Geracao de Arquivos Sintegra" (sayl?: top=231+29=260, left=17)
        * Original: Visible=.F. (presente mas oculto no legado mas exibido na screenshot 2)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_SaylQ", "Label")
        WITH loc_oPagina.lbl_4c_SaylQ
            .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivos Sintegra"
            .Top       = 260
            .Left      = 17
            .Width     = 170
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * SECAO SINTEGRA - Checkboxes coluna 1 (left=21)
        *----------------------------------------------------------------------
        *-- chkGer50: top=252+29=281
        loc_oPagina.AddObject("chk_4c_ChkGer50", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer50
            .Caption   = "Tipo 50 - Nota Fiscal (Modelos 1, 1A, 4, 6, 21, 22)"
            .Value     = 0
            .Top       = 281
            .Left      = 21
            .Width     = 258
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.chk_4c_ChkGer50, "InteractiveChange", THIS, "ChkGer50InteractiveChange")

        *-- chkGer51: top=270+29=299
        loc_oPagina.AddObject("chk_4c_ChkGer51", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer51
            .Caption   = "Tipo 51 - Nota Fiscal de IPI (Modelo 1 e 1A)"
            .Value     = 0
            .Top       = 299
            .Left      = 21
            .Width     = 226
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkGer53: top=288+29=317
        loc_oPagina.AddObject("chk_4c_ChkGer53", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer53
            .Caption   = "Tipo 53 - Registro de Substitui" + CHR(231) + CHR(227) + ;
                         "o Tribut" + CHR(225) + "ria"
            .Value     = 0
            .Top       = 317
            .Left      = 21
            .Width     = 228
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkGer54: top=305+29=334 (habilitado apenas se chkGer50 ativo)
        loc_oPagina.AddObject("chk_4c_ChkGer54", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer54
            .Caption   = "Tipo 54 - Registro de Produtos das Notas Fiscais"
            .Value     = 0
            .Top       = 334
            .Left      = 21
            .Width     = 249
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkGer60: top=322+29=351
        loc_oPagina.AddObject("chk_4c_ChkGer60", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer60
            .Caption   = "Tipo 60 - Notas Emitidas Por EFC / PDV"
            .Value     = 0
            .Top       = 351
            .Left      = 21
            .Width     = 203
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.chk_4c_ChkGer60, "InteractiveChange", THIS, "ChkGer60InteractiveChange")

        *-- chkGer60I: top=340+29=369
        loc_oPagina.AddObject("chk_4c_ChkGer60I", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer60I
            .Caption   = "Tipo 60 - ( I ) " + CHR(205) + "tens dos Cupons"
            .Value     = 0
            .Top       = 369
            .Left      = 21
            .Width     = 168
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * SECAO SINTEGRA - Checkboxes coluna 2 (left=354)
        *----------------------------------------------------------------------
        *-- chkGer60D: top=252+29=281 (habilitado apenas se chkGer60 ativo)
        loc_oPagina.AddObject("chk_4c_ChkGer60D", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer60D
            .Caption   = "Tipo 60 - (D) Resumo Di" + CHR(225) + "rio dos Cupons"
            .Value     = 0
            .Top       = 281
            .Left      = 354
            .Width     = 208
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkGer60R: top=270+29=299
        loc_oPagina.AddObject("chk_4c_ChkGer60R", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer60R
            .Caption   = "Tipo 60 - (R) Resumo Mensal dos Cupons"
            .Value     = 0
            .Top       = 299
            .Left      = 21
            .Width     = 214
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkGer60P: top=288+29=317
        loc_oPagina.AddObject("chk_4c_ChkGer60P", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer60P
            .Caption   = "Tipo 60 - (P) Condi" + CHR(231) + CHR(245) + "es de Pagamento"
            .Value     = 0
            .Top       = 317
            .Left      = 354
            .Width     = 201
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- chkGer61: top=305+29=334
        loc_oPagina.AddObject("chk_4c_ChkGer61", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer61
            .Caption   = "Tipo 61 - Nota Fiscal (Modelos 14, 15, 16, 13, 2, 4)"
            .Value     = 0
            .Top       = 334
            .Left      = 354
            .Width     = 263
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkGer70: top=322+29=351
        loc_oPagina.AddObject("chk_4c_ChkGer70", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer70
            .Caption   = "Tipo 70 - Notas e Conhecimentos de Transportes"
            .Value     = 0
            .Top       = 351
            .Left      = 354
            .Width     = 252
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- chkGer74: top=340+29=369
        loc_oPagina.AddObject("chk_4c_ChkGer74", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer74
            .Caption   = "Tipo 74 - Invent" + CHR(225) + "rio"
            .Value     = 0
            .Top       = 369
            .Left      = 354
            .Width     = 113
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * SECAO SINTEGRA - Checkboxes coluna 3 (left=688)
        *----------------------------------------------------------------------
        *-- chkGer75: top=252+29=281
        loc_oPagina.AddObject("chk_4c_ChkGer75", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkGer75
            .Caption   = "Tipo 75 - Produtos"
            .Value     = 0
            .Top       = 281
            .Left      = 688
            .Width     = 106
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox5 "Usar barrar no NCM": top=252+29=281, left=817
        loc_oPagina.AddObject("chk_4c_Fwcheckbox5", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox5
            .Caption   = "Usar barrar no NCM"
            .Value     = 0
            .Top       = 281
            .Left      = 817
            .Width     = 113
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox1 "Tipo 77": top=270+29=299
        loc_oPagina.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox1
            .Caption   = "Tipo 77 - Objetos Para Transportadora"
            .Value     = 0
            .Top       = 299
            .Left      = 688
            .Width     = 204
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox3 "Tipo 88 GIM para PB": top=288+29=317
        *-- When original: habilitado apenas se estado = "PB"
        loc_oPagina.AddObject("chk_4c_Fwcheckbox3", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox3
            .Caption   = "Tipo 88 - Apura" + CHR(231) + CHR(227) + ;
                         "o de ICMS - GIM para PB"
            .Value     = 0
            .Top       = 317
            .Left      = 688
            .Width     = 221
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox8 "Tipo 88 MS": top=305+29=334
        *-- When original: habilitado apenas se estado = "MS"
        loc_oPagina.AddObject("chk_4c_Fwcheckbox8", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox8
            .Caption   = "Tipo 88 - MS"
            .Value     = 0
            .Top       = 334
            .Left      = 688
            .Width     = 77
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox2 "Tipos (16,17,18,19) Selos Para Sefaz": top=322+29=351
        loc_oPagina.AddObject("chk_4c_Fwcheckbox2", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox2
            .Caption   = "Tipos (16, 17, 18 e 19) - Selos Para Sefaz"
            .Value     = 0
            .Top       = 351
            .Left      = 688
            .Width     = 218
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- fwcheckbox7 "Usar Codigo de Identidade dos Produtos": top=340+29=369
        loc_oPagina.AddObject("chk_4c_Fwcheckbox7", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox7
            .Caption   = "Usar C" + CHR(243) + "digo de Identidade dos Produtos"
            .Value     = 0
            .Top       = 369
            .Left      = 688
            .Width     = 212
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * fwcheckbox4 "sem uso" - rodape, Visible=.F. (top=553+29=582, left=467)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("chk_4c_Fwcheckbox4", "CheckBox")
        WITH loc_oPagina.chk_4c_Fwcheckbox4
            .Caption   = "sem uso"
            .Value     = 0
            .Top       = 582
            .Left      = 467
            .Width     = 67
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(200, 0, 0)
            .Visible   = .F.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- Restaurar Visible=.F. para controles que devem iniciar ocultos
        loc_oPagina.chk_4c_Fwcheckbox4.Visible = .F.
    ENDPROC

    *==========================================================================
    * ChkGer50InteractiveChange - Controla habilitacao do Ger54
    * (logica do Valid event de chkGer50 no original)
    * PUBLIC para funcionar com BINDEVENT
    *==========================================================================
    PROCEDURE ChkGer50InteractiveChange()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF loc_oPg2.chk_4c_ChkGer50.Value = 0
                loc_oPg2.chk_4c_ChkGer54.Value   = 0
                loc_oPg2.chk_4c_ChkGer54.Enabled = .F.
            ELSE
                loc_oPg2.chk_4c_ChkGer54.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.ChkGer50InteractiveChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ChkGer60InteractiveChange - Controla habilitacao de Ger60I/D/R/P
    * (logica do Valid event de chkGer60 no original)
    * PUBLIC para funcionar com BINDEVENT
    *==========================================================================
    PROCEDURE ChkGer60InteractiveChange()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF loc_oPg2.chk_4c_ChkGer60.Value = 0
                loc_oPg2.chk_4c_ChkGer60I.Value   = 0
                loc_oPg2.chk_4c_ChkGer60I.Enabled = .F.
                loc_oPg2.chk_4c_ChkGer60D.Value   = 0
                loc_oPg2.chk_4c_ChkGer60D.Enabled = .F.
                loc_oPg2.chk_4c_ChkGer60R.Value   = 0
                loc_oPg2.chk_4c_ChkGer60R.Enabled = .F.
                loc_oPg2.chk_4c_ChkGer60P.Value   = 0
                loc_oPg2.chk_4c_ChkGer60P.Enabled = .F.
            ELSE
                loc_oPg2.chk_4c_ChkGer60I.Enabled = .T.
                loc_oPg2.chk_4c_ChkGer60D.Enabled = .T.
                loc_oPg2.chk_4c_ChkGer60R.Enabled = .T.
                loc_oPg2.chk_4c_ChkGer60P.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.ChkGer60InteractiveChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Valida e salva o registro (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cEstado, loc_cDescr

        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cEstado = ALLTRIM(loc_oPg2.txt_4c_Estado.Value)
        loc_cDescr  = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)

        *-- Validacoes FORA do TRY (Problema 16)
        IF EMPTY(loc_cEstado)
            MsgAviso("U.F. inv" + CHR(225) + "lido.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Estado.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(loc_cDescr)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg2.txt_4c_Descr.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgSucesso("Estado salvo com sucesso!")
                THIS.AlternarPagina(1)
                THIS.this_cModoAtual = "LISTA"
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista (PUBLIC para BINDEVENT)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do Form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2, loc_oBO, loc_cIpi
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            loc_oBO.this_cEstados    = ALLTRIM(loc_oPg2.txt_4c_Estado.Value)
            loc_oBO.this_cDescrs     = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
            loc_oBO.this_nUFIBGEs   = loc_oPg2.txt_4c_UFIBGES.Value
            loc_oBO.this_nAicms      = loc_oPg2.txt_4c_Aicms.Value
            loc_oBO.this_nBicms      = loc_oPg2.txt_4c_Bicms.Value
            loc_oBO.this_nAliqsbs    = loc_oPg2.txt_4c_AliqSB.Value
            loc_oBO.this_nAreduzidas = loc_oPg2.txt_4c_Areduzida.Value
            loc_oBO.this_cLayoutnf   = ALLTRIM(loc_oPg2.txt_4c_Layoutnf.Value)

            *-- IPI: mapear item selecionado para codigo T/I/O
            loc_cIpi = UPPER(ALLTRIM(loc_oPg2.cbo_4c_CmbIpi.Value))
            IF "TRIBUTADO" $ loc_cIpi
                loc_oBO.this_cIpis = "T"
            ELSE
                IF "ISENTO" $ loc_cIpi
                    loc_oBO.this_cIpis = "I"
                ELSE
                    loc_oBO.this_cIpis = "O"
                ENDIF
            ENDIF

            *-- CAT 52
            loc_oBO.this_nNcotepe52s = IIF(loc_oPg2.chk_4c_Fwcheckbox6.Value = 1, 1, 0)

            *-- Sintegra flags (CheckBox.Value logico -> NUMERIC 0/1)
            loc_oBO.this_nGer50     = IIF(loc_oPg2.chk_4c_ChkGer50.Value     = 1, 1, 0)
            loc_oBO.this_nGer51     = IIF(loc_oPg2.chk_4c_ChkGer51.Value     = 1, 1, 0)
            loc_oBO.this_nGer53     = IIF(loc_oPg2.chk_4c_ChkGer53.Value     = 1, 1, 0)
            loc_oBO.this_nGer54     = IIF(loc_oPg2.chk_4c_ChkGer54.Value     = 1, 1, 0)
            loc_oBO.this_nGer60     = IIF(loc_oPg2.chk_4c_ChkGer60.Value     = 1, 1, 0)
            loc_oBO.this_nGer60I    = IIF(loc_oPg2.chk_4c_ChkGer60I.Value    = 1, 1, 0)
            loc_oBO.this_nGer60D    = IIF(loc_oPg2.chk_4c_ChkGer60D.Value    = 1, 1, 0)
            loc_oBO.this_nGer60R    = IIF(loc_oPg2.chk_4c_ChkGer60R.Value    = 1, 1, 0)
            loc_oBO.this_nGer60P    = IIF(loc_oPg2.chk_4c_ChkGer60P.Value    = 1, 1, 0)
            loc_oBO.this_nGer61     = IIF(loc_oPg2.chk_4c_ChkGer61.Value     = 1, 1, 0)
            loc_oBO.this_nGer70     = IIF(loc_oPg2.chk_4c_ChkGer70.Value     = 1, 1, 0)
            loc_oBO.this_nGer74     = IIF(loc_oPg2.chk_4c_ChkGer74.Value     = 1, 1, 0)
            loc_oBO.this_nGer75     = IIF(loc_oPg2.chk_4c_ChkGer75.Value     = 1, 1, 0)
            loc_oBO.this_nGer77     = IIF(loc_oPg2.chk_4c_Fwcheckbox1.Value  = 1, 1, 0)
            loc_oBO.this_nGer88     = IIF(loc_oPg2.chk_4c_Fwcheckbox3.Value  = 1, 1, 0)
            loc_oBO.this_nGer88ms   = IIF(loc_oPg2.chk_4c_Fwcheckbox8.Value  = 1, 1, 0)
            loc_oBO.this_nGerSefaz  = IIF(loc_oPg2.chk_4c_Fwcheckbox2.Value  = 1, 1, 0)
            loc_oBO.this_nGerncm    = IIF(loc_oPg2.chk_4c_Fwcheckbox5.Value  = 1, 1, 0)
            loc_oBO.this_nCodidents = IIF(loc_oPg2.chk_4c_Fwcheckbox7.Value  = 1, 1, 0)
            loc_oBO.this_nNgersufr1s = IIF(loc_oPg2.chk_4c_Fwcheckbox4.Value = 1, 1, 0)
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para o Form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2, loc_oBO, loc_cIpi
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO  = THIS.this_oBusinessObject

        TRY
            loc_oPg2.txt_4c_Estado.Value    = ALLTRIM(loc_oBO.this_cEstados)
            loc_oPg2.txt_4c_Descr.Value     = ALLTRIM(loc_oBO.this_cDescrs)
            loc_oPg2.txt_4c_UFIBGES.Value   = loc_oBO.this_nUFIBGEs
            loc_oPg2.txt_4c_Aicms.Value     = loc_oBO.this_nAicms
            loc_oPg2.txt_4c_Bicms.Value     = loc_oBO.this_nBicms
            loc_oPg2.txt_4c_AliqSB.Value    = loc_oBO.this_nAliqsbs
            loc_oPg2.txt_4c_Areduzida.Value = loc_oBO.this_nAreduzidas
            loc_oPg2.txt_4c_Layoutnf.Value  = ALLTRIM(loc_oBO.this_cLayoutnf)

            *-- IPI: mapear codigo T/I/O para item do ComboBox
            loc_cIpi = UPPER(ALLTRIM(loc_oBO.this_cIpis))
            DO CASE
                CASE loc_cIpi = "T"
                    loc_oPg2.cbo_4c_CmbIpi.Value = PADR("Tributado", 9)
                CASE loc_cIpi = "I"
                    loc_oPg2.cbo_4c_CmbIpi.Value = PADR("Isento", 9)
                OTHERWISE
                    loc_oPg2.cbo_4c_CmbIpi.Value = PADR("Outros", 9)
            ENDCASE

            *-- CAT 52
            loc_oPg2.chk_4c_Fwcheckbox6.Value = IIF(loc_oBO.this_nNcotepe52s = 1, 1, 0)

            *-- Sintegra flags (NUMERIC 0/1 para CheckBox)
            loc_oPg2.chk_4c_ChkGer50.Value    = IIF(loc_oBO.this_nGer50     = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer51.Value    = IIF(loc_oBO.this_nGer51     = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer53.Value    = IIF(loc_oBO.this_nGer53     = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer54.Value    = IIF(loc_oBO.this_nGer54     = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer60.Value    = IIF(loc_oBO.this_nGer60     = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer60I.Value   = IIF(loc_oBO.this_nGer60I   = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer60D.Value   = IIF(loc_oBO.this_nGer60D   = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer60R.Value   = IIF(loc_oBO.this_nGer60R   = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer60P.Value   = IIF(loc_oBO.this_nGer60P   = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer61.Value    = IIF(loc_oBO.this_nGer61     = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer70.Value    = IIF(loc_oBO.this_nGer70     = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer74.Value    = IIF(loc_oBO.this_nGer74     = 1, 1, 0)
            loc_oPg2.chk_4c_ChkGer75.Value    = IIF(loc_oBO.this_nGer75     = 1, 1, 0)
            loc_oPg2.chk_4c_Fwcheckbox1.Value = IIF(loc_oBO.this_nGer77     = 1, 1, 0)
            loc_oPg2.chk_4c_Fwcheckbox3.Value = IIF(loc_oBO.this_nGer88     = 1, 1, 0)
            loc_oPg2.chk_4c_Fwcheckbox8.Value = IIF(loc_oBO.this_nGer88ms   = 1, 1, 0)
            loc_oPg2.chk_4c_Fwcheckbox2.Value = IIF(loc_oBO.this_nGerSefaz  = 1, 1, 0)
            loc_oPg2.chk_4c_Fwcheckbox5.Value = IIF(loc_oBO.this_nGerncm    = 1, 1, 0)
            loc_oPg2.chk_4c_Fwcheckbox7.Value = IIF(loc_oBO.this_nCodidents = 1, 1, 0)
            loc_oPg2.chk_4c_Fwcheckbox4.Value = IIF(loc_oBO.this_nNgersufr1s = 1, 1, 0)
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita os campos de edicao
    * Respeita regras do original:
    *   - Estado e UFIBGES: somente editaveis em modo INCLUIR
    *   - cmbIpi: editavel em INCLUIR e ALTERAR
    *   - fwcheckbox3 (PB): habilitado apenas se estado = "PB"
    *   - fwcheckbox8 (MS): habilitado apenas se estado = "MS"
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lIncluir, loc_cEstado
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lIncluir = (THIS.this_cModoAtual = "INCLUIR")
        loc_cEstado = UPPER(ALLTRIM(loc_oPg2.txt_4c_Estado.Value))

        TRY
            *-- Estado e UFIBGES: somente em INCLUIR (When = INSERIR ou PROCURAR)
            loc_oPg2.txt_4c_Estado.Enabled  = par_lHabilitar AND loc_lIncluir
            loc_oPg2.txt_4c_UFIBGES.Enabled = par_lHabilitar AND loc_lIncluir

            *-- Campos de texto/numero: habilitados em INCLUIR e ALTERAR
            loc_oPg2.txt_4c_Descr.Enabled     = par_lHabilitar
            loc_oPg2.txt_4c_Aicms.Enabled     = par_lHabilitar
            loc_oPg2.txt_4c_Bicms.Enabled     = par_lHabilitar
            loc_oPg2.txt_4c_AliqSB.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_Areduzida.Enabled = par_lHabilitar
            loc_oPg2.txt_4c_Layoutnf.Enabled  = par_lHabilitar

            *-- ComboBox IPI: habilitado em INCLUIR e ALTERAR
            loc_oPg2.cbo_4c_CmbIpi.Enabled = par_lHabilitar

            *-- Checkboxes simples
            loc_oPg2.chk_4c_Fwcheckbox6.Enabled = par_lHabilitar
            loc_oPg2.chk_4c_ChkGer50.Enabled    = par_lHabilitar
            loc_oPg2.chk_4c_ChkGer51.Enabled    = par_lHabilitar
            loc_oPg2.chk_4c_ChkGer53.Enabled    = par_lHabilitar
            loc_oPg2.chk_4c_ChkGer60.Enabled    = par_lHabilitar
            loc_oPg2.chk_4c_ChkGer61.Enabled    = par_lHabilitar
            loc_oPg2.chk_4c_ChkGer70.Enabled    = par_lHabilitar
            loc_oPg2.chk_4c_ChkGer74.Enabled    = par_lHabilitar
            loc_oPg2.chk_4c_ChkGer75.Enabled    = par_lHabilitar
            loc_oPg2.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
            loc_oPg2.chk_4c_Fwcheckbox2.Enabled = par_lHabilitar
            loc_oPg2.chk_4c_Fwcheckbox5.Enabled = par_lHabilitar
            loc_oPg2.chk_4c_Fwcheckbox7.Enabled = par_lHabilitar

            *-- Ger54 habilitado somente se Ger50 estiver marcado
            IF par_lHabilitar
                loc_oPg2.chk_4c_ChkGer54.Enabled = (loc_oPg2.chk_4c_ChkGer50.Value = 1)
            ELSE
                loc_oPg2.chk_4c_ChkGer54.Enabled = .F.
            ENDIF

            *-- Ger60I/D/R/P habilitados somente se Ger60 estiver marcado
            IF par_lHabilitar
                LOCAL loc_lGer60
                loc_lGer60 = (loc_oPg2.chk_4c_ChkGer60.Value = 1)
                loc_oPg2.chk_4c_ChkGer60I.Enabled = loc_lGer60
                loc_oPg2.chk_4c_ChkGer60D.Enabled = loc_lGer60
                loc_oPg2.chk_4c_ChkGer60R.Enabled = loc_lGer60
                loc_oPg2.chk_4c_ChkGer60P.Enabled = loc_lGer60
            ELSE
                loc_oPg2.chk_4c_ChkGer60I.Enabled = .F.
                loc_oPg2.chk_4c_ChkGer60D.Enabled = .F.
                loc_oPg2.chk_4c_ChkGer60R.Enabled = .F.
                loc_oPg2.chk_4c_ChkGer60P.Enabled = .F.
            ENDIF

            *-- Tipo 88 GIM para PB: apenas se estado = "PB"
            loc_oPg2.chk_4c_Fwcheckbox3.Enabled = par_lHabilitar AND (loc_cEstado = "PB")

            *-- Tipo 88 MS: apenas se estado = "MS"
            loc_oPg2.chk_4c_Fwcheckbox8.Enabled = par_lHabilitar AND (loc_cEstado = "MS")
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de edicao da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Estado.Value    = ""
            loc_oPg2.txt_4c_Descr.Value     = ""
            loc_oPg2.txt_4c_UFIBGES.Value   = 0
            loc_oPg2.txt_4c_Aicms.Value     = 0
            loc_oPg2.txt_4c_Bicms.Value     = 0
            loc_oPg2.txt_4c_AliqSB.Value    = 0
            loc_oPg2.txt_4c_Areduzida.Value = 0
            loc_oPg2.txt_4c_Layoutnf.Value  = ""

            *-- ComboBox IPI: default "Tributado"
            loc_oPg2.cbo_4c_CmbIpi.Value = PADR("Tributado", 9)

            *-- CAT 52
            loc_oPg2.chk_4c_Fwcheckbox6.Value = 0

            *-- Sintegra flags
            loc_oPg2.chk_4c_ChkGer50.Value    = 0
            loc_oPg2.chk_4c_ChkGer51.Value    = 0
            loc_oPg2.chk_4c_ChkGer53.Value    = 0
            loc_oPg2.chk_4c_ChkGer54.Value    = 0
            loc_oPg2.chk_4c_ChkGer60.Value    = 0
            loc_oPg2.chk_4c_ChkGer60I.Value   = 0
            loc_oPg2.chk_4c_ChkGer60D.Value   = 0
            loc_oPg2.chk_4c_ChkGer60R.Value   = 0
            loc_oPg2.chk_4c_ChkGer60P.Value   = 0
            loc_oPg2.chk_4c_ChkGer61.Value    = 0
            loc_oPg2.chk_4c_ChkGer70.Value    = 0
            loc_oPg2.chk_4c_ChkGer74.Value    = 0
            loc_oPg2.chk_4c_ChkGer75.Value    = 0
            loc_oPg2.chk_4c_Fwcheckbox1.Value = 0
            loc_oPg2.chk_4c_Fwcheckbox2.Value = 0
            loc_oPg2.chk_4c_Fwcheckbox3.Value = 0
            loc_oPg2.chk_4c_Fwcheckbox4.Value = 0
            loc_oPg2.chk_4c_Fwcheckbox5.Value = 0
            loc_oPg2.chk_4c_Fwcheckbox7.Value = 0
            loc_oPg2.chk_4c_Fwcheckbox8.Value = 0
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD da Page1
    * conforme disponibilidade de registros no cursor
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lTemRegistros
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        loc_lTemRegistros = USED("cursor_4c_Dados") AND ;
                            !EOF("cursor_4c_Dados") AND ;
                            RECCOUNT("cursor_4c_Dados") > 0

        TRY
            *-- Incluir, Buscar, Encerrar: sempre habilitados
            loc_oCnt.cmd_4c_Incluir.Enabled  = .T.
            loc_oCnt.cmd_4c_Buscar.Enabled   = .T.
            THIS.pgf_4c_Paginas.Page1.cnt_4c_BotaoSair.cmd_4c_Encerrar.Enabled = .T.

            *-- Visualizar, Alterar, Excluir: apenas quando ha registros
            loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lTemRegistros
            loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lTemRegistros
            loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lTemRegistros
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormUfs.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
