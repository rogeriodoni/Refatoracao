*==============================================================================
* FormUpd.prg - Formulario de Cadastro de Unidade Produtiva
* Migrado de: SigCdUpd.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormUpd AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: canonico do Framework)
    Height      = 600
    Width       = 1000
    Caption     = "Unidade Produtiva"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual       = "LISTA"

    *-- Guardas de lookup (Problema 45: evita reabrir picker sem o valor mudar)
    this_cUltimoCodigoFaseValidado    = ""
    this_cUltimaDescricaoFaseValidada = ""

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
    *===========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *===========================================================================
    * InicializarForm - Configura estrutura completa
    * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
    *===========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("UpdBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar UpdBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormUpd.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormUpd:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormUpd.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1 com Grid e botoes CRUD completos
    * Colunas do grid (cursor_4c_Dados do UpdBO.Buscar): codigos, uniprdts,
    * descrs, ordems - transcrito de SIGCDUPD.Init() (AddCursor/pColuna)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=351, Top=0, Width=389, Height=85)
        *-- Canonico: Left=542, Top=29 (0+29 compensacao), Width=390, Height=85
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Saida - PADRAO CANONICO (prevalece sobre legado per CLAUDE.md regra #10)
        *-- Legado: Grupo_Saida.Left=726, Top=0. Canonico: Left=917, Top=29, Width=90
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

        *-- Botao Encerrar - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
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

        *-- Grid de listagem de unidades produtivas
        *-- Original: Grade.Top=88, Left varia (Framework padrao)
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 4
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 26
            .Width              = 880
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
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega dados no grid da Page1
    * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
    * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
    * Colunas transcritas de SIGCDUPD.Init(): Codigos="Fase", UniPrdts=
    * "Unid. Produtiva", Descrs="Descricao", Ordems="Ordem"
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
                loc_oGrid.ColumnCount = 4
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.uniprdts"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.descrs"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.ordems"

                loc_oGrid.Column1.Width = 80
                loc_oGrid.Column2.Width = 150
                loc_oGrid.Column3.Width = 590
                loc_oGrid.Column4.Width = 60

                *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                loc_oGrid.Column1.Header1.Caption = "Fase"
                loc_oGrid.Column2.Header1.Caption = "Unid. Produtiva"
                loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column4.Header1.Caption = "Ordem"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormUpd.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    * Ao voltar para Page1, recarrega a lista
    *===========================================================================
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

        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
                "FormUpd.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista (FontName/FontSize)
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "FormUpd.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Abre Page2 para incluir novo registro
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
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
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um registro para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(2)
                THIS.AjustarBotoesPorModo()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para alterar registro selecionado
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cIdChaves
        loc_cIdChaves = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um registro para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina(2)
                THIS.AjustarBotoesPorModo()
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui registro selecionado com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cIdChaves, loc_cFase
        loc_cIdChaves = ""
        loc_cFase     = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cIdChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
            loc_cFase     = ALLTRIM(cursor_4c_Dados.codigos) + "/" + ALLTRIM(cursor_4c_Dados.uniprdts)
        ENDIF

        IF EMPTY(loc_cIdChaves)
            MsgAviso("Selecione um registro para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da unidade produtiva [" + loc_cFase + "]?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre picker para localizar registro na lista
    * Apos selecao, posiciona o cursor no registro encontrado
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaUpd", "Codigos", "", ;
                "Buscar Fase")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos", "", "Fase")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd")
                    SELECT cursor_4c_BuscaUpd
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaUpd.Codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaUpd")
                USE IN cursor_4c_BuscaUpd
            ENDIF

            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(codigos) == loc_cCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormUpd.BtnBuscarClick")
            IF USED("cursor_4c_BuscaUpd")
                USE IN cursor_4c_BuscaUpd
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
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
    * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
    * Campos e botoes de acao sao adicionados nas proximas fases - aqui ficam
    * apenas os containers vazios (cabecalho + moldura de botoes de acao)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (faixa nas DUAS paginas - CLAUDE.md regra #11)
        *-- PRIMEIRO AddObject da pagina
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 29
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

        *-- Container Botoes de Acao (Grupo_Salva no legado) - vazio, populado
        *-- em fase posterior com cmd_4c_Confirmar / cmd_4c_Cancelar
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

        *===================================================================
        * CAMPOS - LINHA 1: Fase (lookup SigCdGcr) + Descricao (somente leitura)
        * Legado: Say1.Top=208/Left=258, getCodigos.Top=205/Left=297/Width=84
        * GetDescrs.Top=205/Left=383/Width=194 - compensacao PageFrame +29
        *===================================================================
        loc_oPagina.AddObject("lbl_4c_Fase", "Label")
        WITH loc_oPagina.lbl_4c_Fase
            .Caption   = "Fase :"
            .Top       = 237
            .Left      = 258
            .Width     = 35
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 234
            .Left          = 297
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        *-- Lookup Fase (SigCdGcr, filtro GerBals=1) - transcrito de getCodigos.Valid
        BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress", THIS, "CodigoLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Codigo, "KeyPress",  THIS, "CodigoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Codigo, "DblClick",  THIS, "CodigoDblClick")

        *-- Descricao da Fase: preenchida pelo lookup OU digitada para buscar
        *-- a Fase pela descricao (legado: When = Empty(getCodigos.Value)).
        *-- Enabled alternado dinamicamente por AtualizarEstadoDescricao()
        *-- em vez de ReadOnly fixo, para preservar a busca reversa do legado.
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 234
            .Left          = 383
            .Width         = 194
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 20
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH
        *-- Lookup reverso por Descricao - transcrito de GetDescrs.Valid
        BINDEVENT(loc_oPagina.txt_4c_Descricao, "KeyPress", THIS, "DescricaoLostFocus")
        BINDEVENT(loc_oPagina.txt_4c_Descricao, "KeyPress",  THIS, "DescricaoKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Descricao, "DblClick",  THIS, "DescricaoDblClick")

        *===================================================================
        * CAMPOS - LINHA 2: Unidade Produtiva
        * Legado: Say2.Top=233/Left=193, getUnidade.Top=230/Left=297/Width=84
        *===================================================================
        loc_oPagina.AddObject("lbl_4c_UnidadeProdutiva", "Label")
        WITH loc_oPagina.lbl_4c_UnidadeProdutiva
            .Caption   = "Unidade Produtiva :"
            .Top       = 262
            .Left      = 193
            .Width     = 100
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_UnidadeProdutiva", "TextBox")
        WITH loc_oPagina.txt_4c_UnidadeProdutiva
            .Value         = ""
            .Top           = 259
            .Left          = 297
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        *===================================================================
        * CAMPOS - LINHA 3: Quantidade
        * Legado: Say3.Top=258/Left=225, GetQtdes.Top=255/Left=297/Width=28
        * InputMask="99" (numeric(2,0))
        *===================================================================
        loc_oPagina.AddObject("lbl_4c_Quantidade", "Label")
        WITH loc_oPagina.lbl_4c_Quantidade
            .Caption   = "Quantidade :"
            .Top       = 287
            .Left      = 225
            .Width     = 68
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Quantidade", "TextBox")
        WITH loc_oPagina.txt_4c_Quantidade
            .Value         = 0
            .Top           = 284
            .Left          = 297
            .Width         = 28
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .InputMask     = "99"
            .Visible       = .T.
        ENDWITH

        *===================================================================
        * CAMPOS - LINHA 4: Horas Por Dia
        * Legado: Say34.Top=283/Left=216, get_ddr.Top=280/Left=297/Width=45
        * Label1 "Hs." Top=284/Left=349/Width=18/Height=15
        * InputMask="99.99" (hordds numeric(4,2))
        *===================================================================
        loc_oPagina.AddObject("lbl_4c_HorasPorDia", "Label")
        WITH loc_oPagina.lbl_4c_HorasPorDia
            .Caption   = "Horas Por Dia :"
            .Top       = 312
            .Left      = 216
            .Width     = 100
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_HorasPorDia", "TextBox")
        WITH loc_oPagina.txt_4c_HorasPorDia
            .Value         = 0
            .Top           = 309
            .Left          = 297
            .Width         = 45
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .InputMask     = "99.99"
            .Visible       = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Hs", "Label")
        WITH loc_oPagina.lbl_4c_Hs
            .Caption   = "Hs."
            .Top       = 313
            .Left      = 349
            .Width     = 18
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *===================================================================
        * CAMPOS - LINHA 5: Dias por Semana (validacao: 0 a 7)
        * Legado: Say35.Top=308/Left=201, get_ddf.Top=305/Left=297/Width=18
        * Label2 "(1-7)" Top=310/Left=318/Width=26/Height=15
        * ddsems numeric(1,0), MaxLength=1 no legado
        *===================================================================
        loc_oPagina.AddObject("lbl_4c_DiasPorSemana", "Label")
        WITH loc_oPagina.lbl_4c_DiasPorSemana
            .Caption   = "Dias por Semana :"
            .Top       = 337
            .Left      = 201
            .Width     = 115
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DiasPorSemana", "TextBox")
        WITH loc_oPagina.txt_4c_DiasPorSemana
            .Value         = 0
            .Top           = 334
            .Left          = 297
            .Width         = 18
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .InputMask     = "9"
            .Visible       = .T.
        ENDWITH
        *-- Validacao transcrita de get_ddf.Valid: Dias por Semana entre 0 e 7
        BINDEVENT(loc_oPagina.txt_4c_DiasPorSemana, "KeyPress", THIS, "DiasPorSemanaLostFocus")

        loc_oPagina.AddObject("lbl_4c_1a7", "Label")
        WITH loc_oPagina.lbl_4c_1a7
            .Caption   = "(1-7)"
            .Top       = 339
            .Left      = 318
            .Width     = 26
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *===================================================================
        * CAMPOS - LINHA 6: Ordem no Mapa
        * Legado: Say4.Top=334/Left=205, GET_ORDEM.Top=331/Left=297/Width=24
        * InputMask="99" (ordems numeric(2,0))
        *===================================================================
        loc_oPagina.AddObject("lbl_4c_OrdemMapa", "Label")
        WITH loc_oPagina.lbl_4c_OrdemMapa
            .Caption   = "Ordem no Mapa :"
            .Top       = 363
            .Left      = 205
            .Width     = 100
            .Height    = 17
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
        WITH loc_oPagina.txt_4c_Ordem
            .Value         = 0
            .Top           = 360
            .Left          = 297
            .Width         = 24
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .BorderStyle   = 1
            .SpecialEffect = 0
            .InputMask     = "99"
            .Visible       = .T.
        ENDWITH

        *===================================================================
        * Botoes de Acao (Grupo_Salva no legado) - Confirmar/Cancelar
        * Canonico framework_frmcadastro_layout.md: Left=5/80, Top=5, W/H=75
        *===================================================================
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores do Form (Page2) para o Business Object
    * PUBLIC: chamado por BtnSalvarClick (BINDEVENT no botao Confirmar)
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_cCodigo           = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
            .this_cUnidadeProdutiva = ALLTRIM(loc_oPagina.txt_4c_UnidadeProdutiva.Value)
            .this_nQuantidade       = loc_oPagina.txt_4c_Quantidade.Value
            .this_nHorasDia         = loc_oPagina.txt_4c_HorasPorDia.Value
            .this_nDiasSemana       = loc_oPagina.txt_4c_DiasPorSemana.Value
            .this_nOrdem            = loc_oPagina.txt_4c_Ordem.Value
        ENDWITH
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do Business Object para o Form (Page2)
    * this_cDescricaoFase vem do JOIN com SigCdGcr (BO.CarregarDoCursor)
    * PUBLIC: chamado por BtnVisualizarClick/BtnAlterarClick
    *===========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPagina.txt_4c_Codigo.Value           = .this_cCodigo
            loc_oPagina.txt_4c_Descricao.Value        = .this_cDescricaoFase
            loc_oPagina.txt_4c_UnidadeProdutiva.Value = .this_cUnidadeProdutiva
            loc_oPagina.txt_4c_Quantidade.Value       = .this_nQuantidade
            loc_oPagina.txt_4c_HorasPorDia.Value      = .this_nHorasDia
            loc_oPagina.txt_4c_DiasPorSemana.Value    = .this_nDiasSemana
            loc_oPagina.txt_4c_Ordem.Value             = .this_nOrdem
        ENDWITH

        THIS.this_cUltimoCodigoFaseValidado    = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_cUltimaDescricaoFaseValidada = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        THIS.AtualizarEstadoDescricao()
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os campos da Page2 (usado no modo INCLUIR)
    * PUBLIC: chamado por BtnIncluirClick
    *===========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value           = ""
        loc_oPagina.txt_4c_Descricao.Value        = ""
        loc_oPagina.txt_4c_UnidadeProdutiva.Value = ""
        loc_oPagina.txt_4c_Quantidade.Value       = 0
        loc_oPagina.txt_4c_HorasPorDia.Value      = 0
        loc_oPagina.txt_4c_DiasPorSemana.Value    = 0
        loc_oPagina.txt_4c_Ordem.Value            = 0

        THIS.this_cUltimoCodigoFaseValidado    = ""
        THIS.this_cUltimaDescricaoFaseValidada = ""
        THIS.AtualizarEstadoDescricao()
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os campos de dados da Page2
    * Transcrito das clausulas When do legado: getCodigos/getUnidade permitem
    * INSERIR/ALTERAR/PROCURAR; GET_ORDEM/GetQtdes/get_ddr/get_ddf permitem
    * apenas INSERIR/ALTERAR - ou seja, em CONSULTAR (Visualizar) a tela
    * inteira fica somente leitura. cmd_4c_Confirmar tambem eh desabilitado
    * em Visualizar (nao ha nada a gravar).
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Enabled                       = par_lHabilitar
        loc_oPagina.txt_4c_UnidadeProdutiva.Enabled             = par_lHabilitar
        loc_oPagina.txt_4c_Quantidade.Enabled                   = par_lHabilitar
        loc_oPagina.txt_4c_HorasPorDia.Enabled                  = par_lHabilitar
        loc_oPagina.txt_4c_DiasPorSemana.Enabled                = par_lHabilitar
        loc_oPagina.txt_4c_Ordem.Enabled                        = par_lHabilitar
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled  = par_lHabilitar

        IF par_lHabilitar
            THIS.AtualizarEstadoDescricao()
        ELSE
            loc_oPagina.txt_4c_Descricao.Enabled = .F.
        ENDIF
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita Confirmar e posiciona o foco
    * conforme this_cModoAtual (INCLUIR/ALTERAR/VISUALIZAR)
    * PUBLIC: chamado diretamente por TesteAutomatico.prg (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            DO CASE
                CASE THIS.this_cModoAtual = "INCLUIR"
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                        loc_oPg2.txt_4c_Codigo.SetFocus()
                    ENDIF
                CASE THIS.this_cModoAtual = "ALTERAR"
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
                    IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                        loc_oPg2.txt_4c_UnidadeProdutiva.SetFocus()
                    ENDIF
                OTHERWISE
                    loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
                    IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
                    ENDIF
            ENDCASE
        CATCH TO loException
            MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
                "FormUpd.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AtualizarEstadoDescricao - Alterna Enabled de txt_4c_Descricao
    * Transcrito de GetDescrs.When: Return(... And Empty(getCodigos.Value))
    * so permite digitar/buscar pela Descricao quando o Codigo esta vazio
    *===========================================================================
    PROTECTED PROCEDURE AtualizarEstadoDescricao()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_oPagina.txt_4c_Descricao.Enabled = EMPTY(ALLTRIM(loc_oPagina.txt_4c_Codigo.Value))
    ENDPROC

    *===========================================================================
    * AbrirLookupFase - Lookup de Fase por Codigo (SigCdGcr, GerBals=1)
    * Transcrito de getCodigos.Valid: busca exata primeiro; se nao achar,
    * abre o picker (FormBuscaAuxiliar). Preenche Codigo E Descricao.
    *===========================================================================
    PROTECTED PROCEDURE AbrirLookupFase()
        LOCAL loc_oBusca, loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPagina.txt_4c_Codigo.Enabled
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaFase", "Codigos", loc_cValor, ;
                "Fases", .F., .F., "GerBals = 1")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "Fase")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFase")
                    SELECT cursor_4c_BuscaFase
                    loc_oPagina.txt_4c_Codigo.Value    = ALLTRIM(cursor_4c_BuscaFase.Codigos)
                    loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(cursor_4c_BuscaFase.Descrs)
                    THIS.this_cUltimoCodigoFaseValidado = ALLTRIM(cursor_4c_BuscaFase.Codigos)
                ELSE
                    loc_oPagina.txt_4c_Codigo.Value     = ""
                    loc_oPagina.txt_4c_Descricao.Value  = ""
                    THIS.this_cUltimoCodigoFaseValidado = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaFase")
                USE IN cursor_4c_BuscaFase
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar Fase:" + CHR(13) + loException.Message, "FormUpd.AbrirLookupFase")
            IF USED("cursor_4c_BuscaFase")
                USE IN cursor_4c_BuscaFase
            ENDIF
        ENDTRY

        THIS.AtualizarEstadoDescricao()
    ENDPROC

    *===========================================================================
    * CodigoLostFocus - Dispara o lookup de Fase ao sair do campo (Problema 45:
    * guarda contra reabrir o picker quando o valor nao mudou)
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE CodigoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value)

        IF loc_cValor == THIS.this_cUltimoCodigoFaseValidado
            RETURN
        ENDIF
        THIS.this_cUltimoCodigoFaseValidado = loc_cValor

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        THIS.AbrirLookupFase()
    ENDPROC

    *===========================================================================
    * CodigoKeyPress - F4 abre o lookup de Fase explicitamente
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE CodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupFase()
        ENDIF
    ENDPROC

    *===========================================================================
    * CodigoDblClick - Duplo clique abre o lookup de Fase
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE CodigoDblClick()
        THIS.AbrirLookupFase()
    ENDPROC

    *===========================================================================
    * AbrirLookupFasePorDescricao - Lookup de Fase por Descricao (SigCdGcr,
    * GerBals=1). Transcrito de GetDescrs.Valid - busca reversa: preenche
    * Descricao E Codigo.
    *===========================================================================
    PROTECTED PROCEDURE AbrirLookupFasePorDescricao()
        LOCAL loc_oBusca, loc_oPagina, loc_cValor
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF !loc_oPagina.txt_4c_Descricao.Enabled
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaFaseDesc", "Descrs", loc_cValor, ;
                "Fases", .F., .F., "GerBals = 1")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("Codigos", "", "Fase")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFaseDesc")
                    SELECT cursor_4c_BuscaFaseDesc
                    loc_oPagina.txt_4c_Descricao.Value     = ALLTRIM(cursor_4c_BuscaFaseDesc.Descrs)
                    loc_oPagina.txt_4c_Codigo.Value         = ALLTRIM(cursor_4c_BuscaFaseDesc.Codigos)
                    THIS.this_cUltimaDescricaoFaseValidada = ALLTRIM(cursor_4c_BuscaFaseDesc.Descrs)
                    THIS.this_cUltimoCodigoFaseValidado    = ALLTRIM(cursor_4c_BuscaFaseDesc.Codigos)
                ELSE
                    loc_oPagina.txt_4c_Descricao.Value     = ""
                    THIS.this_cUltimaDescricaoFaseValidada = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaFaseDesc")
                USE IN cursor_4c_BuscaFaseDesc
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar Fase por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormUpd.AbrirLookupFasePorDescricao")
            IF USED("cursor_4c_BuscaFaseDesc")
                USE IN cursor_4c_BuscaFaseDesc
            ENDIF
        ENDTRY

        THIS.AtualizarEstadoDescricao()
    ENDPROC

    *===========================================================================
    * DescricaoLostFocus - Dispara o lookup reverso ao sair do campo
    * (Problema 45: guarda contra reabrir o picker quando o valor nao mudou)
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE DescricaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor

        IF !THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.Enabled
            RETURN
        ENDIF

        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.Value)

        IF loc_cValor == THIS.this_cUltimaDescricaoFaseValidada
            RETURN
        ENDIF
        THIS.this_cUltimaDescricaoFaseValidada = loc_cValor

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        THIS.AbrirLookupFasePorDescricao()
    ENDPROC

    *===========================================================================
    * DescricaoKeyPress - F4 abre o lookup reverso explicitamente
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE DescricaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupFasePorDescricao()
        ENDIF
    ENDPROC

    *===========================================================================
    * DescricaoDblClick - Duplo clique abre o lookup reverso
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE DescricaoDblClick()
        THIS.AbrirLookupFasePorDescricao()
    ENDPROC

    *===========================================================================
    * DiasPorSemanaLostFocus - Valida faixa 0-7 ao sair do campo
    * Transcrito literalmente de get_ddf.Valid
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE DiasPorSemanaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCampo
        loc_oCampo = THIS.pgf_4c_Paginas.Page2.txt_4c_DiasPorSemana

        IF loc_oCampo.Value < 0 OR loc_oCampo.Value > 7
            MsgAviso("A Semana s" + CHR(243) + " pode ter no m" + CHR(225) + "ximo 7 dias...")
            loc_oCampo.Value = 0
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma inclusao/alteracao do registro
    * Transcrito de Pagina.Dados.Grupo_Salva.Salva.Click: BO.ValidarDados cobre
    * o codigo obrigatorio + duplicidade (INCLUIR) + faixa de dias da semana;
    * BO.DepoisDeGravar sincroniza Ordem em todas as unidades da mesma Fase.
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso!")
            THIS.AlternarPagina(1)
        ELSE
            IF !THIS.this_oBusinessObject.this_lErroExibido
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista
    * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_oBusinessObject.CancelarEdicao()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * Destroy - Libera referencias do formulario
    *===========================================================================
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_BuscaUpd")
            USE IN cursor_4c_BuscaUpd
        ENDIF

        IF USED("cursor_4c_BuscaFase")
            USE IN cursor_4c_BuscaFase
        ENDIF

        IF USED("cursor_4c_BuscaFaseDesc")
            USE IN cursor_4c_BuscaFaseDesc
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
