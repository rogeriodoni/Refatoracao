*==============================================================================
* FORMACESSOGRUPO.PRG
* Formulario de cadastro de grupos de acesso
*
* Tabela: SigCdGra
* Campos: Grupos (PK), NComps
*
* IMPORTANTE: Este eh um formulario MVP (Minimum Viable Product).
*             Funcionalidades complexas de gestao de acessos serao adicionadas
*             incrementalmente apos o CRUD basico funcionar.
*
* MVP inclui:
* - CRUD basico (Incluir, Alterar, Excluir, Consultar, Buscar)
* - Lista de grupos (grid Page1)
* - Campos basicos (Page2): Codigo, Nome Completo
*
* Funcionalidades futuras (pos-MVP):
* - Gestao de usuarios do grupo (ListBox drag-drop)
* - Gestao de acessos a programas (grid com checkboxes)
* - Copia de acessos entre grupos
* - Gestao de acessos a campos de telas
*
* REGRAS APLICADAS:
* - Nomenclatura: loc_ para locais, par_ para parametros, this_ para classe
* - Controles: tipo_4c_Nome (txt_4c_, cmd_4c_, grd_4c_, lbl_4c_, cnt_4c_, pgf_4c_)
* - ShowWindow = 1, WindowType = 1 para forms modais estaveis
* - BINDEVENT funciona com Click, NAO funciona com Valid/When
* - NUNCA usar CLEAR EVENTS em botoes de fechar
* - SEMPRE inicializar TextBox.Value (string="", numeric=0)
*==============================================================================

*------------------------------------------------------------------------------
* FormAcessoGrupo - Formulario de cadastro de grupos de acesso (MVP)
*------------------------------------------------------------------------------
DEFINE CLASS FormAcessoGrupo AS FormBase

    *-- Propriedades visuais do formulario (PILAR 1 - UX FIDELITY)
    DataSession = 2
    Height = 600
    Width = 1000
    Caption = "Acesso de Grupos"
    this_cTituloForm = "Acesso de Grupos"
    ShowWindow = 1
    WindowType = 1
    AutoCenter = .T.

    *-- Propriedades do frmcadastro (SEM barra de titulo)
    ControlBox = .F.
    Closable = .F.
    MaxButton = .F.
    TitleBar = 0
    Themes = .F.
    BorderStyle = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Inicializa formulario (chamado por FormBase.Init)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            * Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("AcessoGrupoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar AcessoGrupoBO", "Erro")
                loc_lSucesso = .F.
            ENDIF

            * Configurar PageFrame e paginas
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()

            * Pula CarregarLista se estiver validando UI (sem conexao SQL)
            IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                IF !THIS.CarregarLista()
                    * Se falhar ao carregar, nao impede abertura
                ENDIF
            ENDIF

            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.Visible = .T.
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"
            loc_lSucesso = .T.

        CATCH TO loException
            MostrarErro("Erro ao inicializar formul" + CHR(225) + "rio:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loException.Message + CHR(13) + ;
                       "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top = -29              && Esconde abas
            .Left = 0
            .Width = 1000
            .Height = 629
            .Tabs = .F.             && Sem abas visiveis
            .Visible = .T.

            * Configurar Page1 (Lista)
            .Page1.Caption = "Lista"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255,255,255)
            .Page1.ForeColor = RGB(90,90,90)

            * Configurar Page2 (Dados)
            .Page2.Caption = "Dados"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255,255,255)
            .Page2.ForeColor = RGB(90,90,90)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista de grupos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container do cabecalho
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top = 31               && Compensa PageFrame.Top=-29 (+29)
            .Left = 0
            .Width = 1009
            .Height = 80
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label titulo
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption = "Acesso de Grupos"
            .Top = 10
            .Left = 20
            .Width = 200
            .Height = 25
            .FontName = "Tahoma"
            .FontSize = 14
            .FontBold = .T.
            .BackStyle = 0
            .ForeColor = RGB(90,90,90)
        ENDWITH

        *-- Container dos botoes CRUD
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top = 29               && Framework: 0 + 29 (compensa PageFrame.Top=-29)
            .Left = 542
            .Width = 465
            .Height = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption = "Incluir"
            .Width = 75
            .Height = 75
            .Left = 5
            .Top = 5
            .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption = "Visualizar"
            .Width = 75
            .Height = 75
            .Left = 80
            .Top = 5
            .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption = "Alterar"
            .Width = 75
            .Height = 75
            .Left = 155
            .Top = 5
            .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption = "Excluir"
            .Width = 75
            .Height = 75
            .Left = 230
            .Top = 5
            .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption = "Buscar"
            .Width = 75
            .Height = 75
            .Left = 305
            .Top = 5
            .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Botao Encerrar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar
            .Caption = "Encerrar"
            .Width = 75
            .Height = 75
            .Left = 380
            .Top = 5
            .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de dados
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top = 121              && Ja alto o suficiente
            .Left = 62
            .Width = 935
            .Height = 450
            .ColumnCount = 2
            .RecordSourceType = 1
            .ReadOnly = .T.
            .DeleteMark = .F.
            .RecordMark = .F.
            .ScrollBars = 3
            .GridLines = 3
            .AllowHeaderSizing = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .GridLineColor = RGB(238,238,238)
            .Visible = .T.

            * Coluna 1: Grupo
            .Column1.Width = 100
            .Column1.Header1.Caption = "Grupo"
            .Column1.Header1.Alignment = 2

            * Coluna 2: Nome Completo
            .Column2.Width = 400
            .Column2.Header1.Caption = "Nome Completo"
            .Column2.Header1.Alignment = 2
        ENDWITH

        * Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Campos do grupo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container dos botoes de acao (Salvar/Cancelar)
        loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oPagina.cnt_4c_BotoesDados
            .Top = 38               && Framework: 9 + 29 (compensa PageFrame.Top=-29)
            .Left = 817
            .Width = 155
            .Height = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption = "Salvar"
            .Width = 75
            .Height = 75
            .Left = 5
            .Top = 5
            .Picture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption = "Encerrar"
            .Width = 75
            .Height = 75
            .Left = 80
            .Top = 5
            .Picture = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes = .F.
            .SpecialEffect = 0
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .Visible = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label: Grupo
        loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
        WITH loc_oPagina.lbl_4c_Grupo
            .Caption = "Grupo :"
            .Top = 140
            .Left = 320
            .Width = 50
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1  && Right
        ENDWITH

        *-- TextBox: Grupo (codigo)
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Top = 137
            .Left = 375
            .Width = 100
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 10
            .Value = ""
            .BorderStyle = 1
            .SpecialEffect = 1
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- Label: Nome Completo
        loc_oPagina.AddObject("lbl_4c_NomeCompleto", "Label")
        WITH loc_oPagina.lbl_4c_NomeCompleto
            .Caption = "Nome Completo :"
            .Top = 175
            .Left = 270
            .Width = 100
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1  && Right
        ENDWITH

        *-- TextBox: Nome Completo
        loc_oPagina.AddObject("txt_4c_NomeCompleto", "TextBox")
        WITH loc_oPagina.txt_4c_NomeCompleto
            .Top = 172
            .Left = 375
            .Width = 400
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .MaxLength = 50
            .Value = ""
            .BorderStyle = 1
            .SpecialEffect = 1
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        * Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega lista de grupos no grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_oGrid, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            * Buscar dados
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lSucesso = .F.
            ENDIF

            * Definir RecordSource (RESETA colunas)
            loc_oGrid.ColumnCount = 2
            loc_oGrid.RecordSource = "cursor_4c_Dados"
            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Grupos"
            loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.NComps"

            * RECONFIGURAR cabecalhos APOS RecordSource (OBRIGATORIO)
            loc_oGrid.Column1.Header1.Caption = "Grupo"
            loc_oGrid.Column2.Header1.Caption = "Nome Completo"
            loc_oGrid.Column1.Width = 100
            loc_oGrid.Column2.Width = 400

            * Aplicar formatacao visual
            THIS.FormatarGridLista(loc_oGrid)

            loc_lSucesso = .T.

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + CHR(13) + ;
                       "Erro: " + loException.Message + CHR(13) + ;
                       "Linha: " + TRANSFORM(loException.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do formulario para o Business Object
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
            .this_cNomeCompleto = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do Business Object para o formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_Grupo.Value = THIS.this_oBusinessObject.this_cGrupo
            .txt_4c_NomeCompleto.Value = THIS.this_oBusinessObject.this_cNomeCompleto
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        WITH THIS.pgf_4c_Paginas.Page2
            .txt_4c_Grupo.Value = ""
            .txt_4c_NomeCompleto.Value = ""
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        WITH THIS.pgf_4c_Paginas.Page2
            * Codigo: somente habilitado no modo INCLUIR
            .txt_4c_Grupo.Enabled = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")

            * Outros campos: habilitados em INCLUIR e ALTERAR
            .txt_4c_NomeCompleto.Enabled = par_lHabilitar
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inclusao de novo grupo
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()  && OBRIGATORIO: Prepara BO para INSERT
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"           && ANTES de HabilitarCampos!
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizacao de grupo
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cGrupo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum grupo selecionado!")
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(cursor_4c_Dados.Grupos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alteracao de grupo
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cGrupo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum grupo selecionado!")
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(cursor_4c_Dados.Grupos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
            THIS.this_oBusinessObject.EditarRegistro()  && APOS CarregarPorCodigo!
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"            && ANTES de HabilitarCampos!
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclusao de grupo
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cGrupo

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum grupo selecionado!")
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(cursor_4c_Dados.Grupos)

        IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo " + loc_cGrupo + "?", "Confirma" + CHR(231) + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgSucesso("Grupo exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Busca de grupo
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGra", "cursor_4c_Busca", "Grupos", "", "Buscar Grupo")

            * Adicionar colunas ao grid
            loc_oBusca.mAddColuna("Grupos", "", "Grupo")
            loc_oBusca.mAddColuna("NComps", "", "Nome Completo")

            * Mostrar modal
            loc_oBusca.Show()

            * Verificar selecao
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    * Recarregar lista filtrada pelo grupo selecionado
                    LOCAL loc_cGrupo
                    loc_cGrupo = ALLTRIM(cursor_4c_Busca.Grupos)
                    THIS.this_oBusinessObject.Buscar("Grupos = " + EscaparSQL(loc_cGrupo))

                    * Atualizar grid
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 2
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.Grupos"
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.NComps"

                    * Reconfigurar cabecalhos
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Grupo"
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Nome Completo"
                ENDIF
            ENDIF

            * Limpar
            IF USED("cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF
            loc_oBusca.Release()

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + ;
                       "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
                       loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salvar grupo
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        * Validacao FORA do TRY (RETURN funciona fora de TRY)
        IF EMPTY(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
            MsgAviso("C" + CHR(243) + "digo do grupo " + CHR(233) + " obrigat" + CHR(243) + "rio!")
            THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.Value)
            MsgAviso("Nome do grupo " + CHR(233) + " obrigat" + CHR(243) + "rio!")
            THIS.pgf_4c_Paginas.Page2.txt_4c_NomeCompleto.SetFocus()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Grupo salvo com sucesso!")
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancelar e voltar para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()  && Recarrega lista + formatacao
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            *-- Verificar se grid tem colunas antes de formatar
            *-- CORRIGIDO: Nao usar SetAll para FontName em Column (Column nao tem FontName)
            *-- Definir FontName diretamente no Grid (aplica aos controles internos)
            IF .ColumnCount > 0
                .FontName = "Tahoma"
                .FontSize = 8
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                * Trata PageFrame - itera Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                * Trata containers com ControlCount
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE
