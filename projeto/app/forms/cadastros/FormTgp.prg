*==============================================================================
* FormTgp.prg - Formulario de Cadastro de Tipos de Geracao de O.P.
* Migrado de: SigCdTgp.SCX (frmcadastro)
*
* FASE 5/8 - FORM: CAMPOS PRINCIPAIS (Page2 - Parte 1): txt_4c_Codigos,
* txt_4c_Descrs, txt_4c_Nivel (lookup Dopps/SigCdOpd) + labels correspondentes.
* FASE 6/8 - FORM: CAMPOS RESTANTES (opt_4c_OpzeroSemPeso/opt_4c_EntradaPeso +
* labels) + lookup COMPLETO de Operacao de Producao (txt_4c_Nivel -> SigCdOpd)
* + container cnt_4c_BotoesAcao (Salvar/Cancelar). Btn*Click implementados
* nas Fases 7-8.
*==============================================================================

DEFINE CLASS FormTgp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Tipos de Gera" + CHR(231) + CHR(227) + "o de O.P."
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject       = .NULL.
    this_cModoAtual            = "LISTA"
    this_cUltimoNivelValidado  = ""

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
            THIS.this_oBusinessObject = CREATEOBJECT("TgpBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar TgpBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormTgp.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormTgp:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTgp.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1 (Grid + Botoes CRUD)
    * REGRA CLAUDE.md #11: cnt_4c_Cabecalho DEVE ser o PRIMEIRO AddObject da pagina
    * REGRA CLAUDE.md #10: cnt_4c_Saida/cmd_4c_Encerrar seguem o padrao canonico
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Canonico CLAUDE.md #11: Top=29, Left=0, Width=THIS.Width, Height=80
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

        *-- Container Botoes CRUD (Grupo_op no legado: Left=341, Top=-1)
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

        *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10, prevalece sobre legado)
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

        *-- Grid de listagem (legado: Grade.pColuna('Codigos',...,80), pColuna('Descs',...,279))
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 2
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
    * CarregarLista - Carrega dados no Grid da Page1 (cursor_4c_Dados: codigos, descs)
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
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"

                loc_oGrid.Column1.Width = 100
                loc_oGrid.Column2.Width = 770

                *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTgp.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    * PUBLIC: TesteAutomatico.prg chama direto de fora da classe (CLAUDE.md #3)
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
                "FormTgp.AlternarPagina")
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
                "FormTgp.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
    * PUBLIC (sem PROTECTED): BINDEVENT exige metodo PUBLIC (CLAUDE.md #2)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado (linha do grid) e
    * navega para Page2 em modo somente-leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. para visualizar!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado (linha do grid) e navega
    * para Page2 em modo edicao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. para alterar!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Confirma e exclui o registro selecionado (linha do grid)
    * Espelha comportamento.json: verificacao de registro selecionado + confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDesc

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
            MsgAviso("Selecione um Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. para excluir!", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        loc_cDesc   = ALLTRIM(cursor_4c_Dados.descs)

        IF MsgConfirma("Confirma exclus" + CHR(227) + "o do Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P.:" + CHR(13) + ;
                loc_cCodigo + " - " + loc_cDesc, "Excluir Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P.")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (estrutura base)
    * Containers principais VAZIOS nesta fase: cnt_4c_Cabecalho, cnt_4c_BotoesAcao
    * Campos e botoes Confirmar/Cancelar entram nas proximas fases.
    * REGRA CLAUDE.md #11: cabecalho tambem na pagina Dados (Erro152)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (identico ao da pagina Lista) - VAZIO nesta fase
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

        *-- Container BotoesAcao (Grupo_Salva legado: Left=615, Top=17, Width=160, Height=85)
        *-- Com compensacao PageFrame +29: Top=46
        *-- VAZIO nesta fase - botoes Confirmar/Cancelar entram na Fase 6
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 46
            .Left        = 615
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label Codigo (lblCodigos legado: Top=158, Left=254, Width=42)
        *-- Compensacao PageFrame +29: Top=158+29=187
        loc_oPagina.AddObject("lbl_4c_LblCodigos", "Label")
        WITH loc_oPagina.lbl_4c_LblCodigos
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 158 + 29
            .Left      = 254
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Codigo (Get_Codigos legado: chave primaria SigInTgo.codigos)
        *-- InputMask="!!!!!!!!!!" forca maiusculas em char(10); MaxLength=10
        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Top       = 155 + 29
            .Left      = 299
            .Width     = 80
            .Height    = 23
            .MaxLength = 10
            .InputMask = "!!!!!!!!!!"
            .BackStyle = 1
            .ForeColor = RGB(0, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Label Descricao (lblDescrs legado: Top=184, Left=241, Width=55, Alignment=1)
        loc_oPagina.AddObject("lbl_4c_LblDescrs", "Label")
        WITH loc_oPagina.lbl_4c_LblDescrs
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 184 + 29
            .Left      = 241
            .Width     = 55
            .Height    = 17
            .Alignment = 1
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (Get_Descrs legado: SigInTgo.descs, Format="!K", Width=220)
        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Top       = 181 + 29
            .Left      = 299
            .Width     = 220
            .Height    = 23
            .MaxLength = 30
            .Format    = "!K"
            .BackStyle = 1
            .ForeColor = RGB(0, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Label Operacao de Producao (Say35 legado: Top=212, Left=177)
        loc_oPagina.AddObject("lbl_4c_Label35", "Label")
        WITH loc_oPagina.lbl_4c_Label35
            .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o :"
            .Top       = 212 + 29
            .Left      = 177
            .Width     = 140
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Operacao de Producao / Dopps (Get_nivel legado: lookup SigCdOpd)
        loc_oPagina.AddObject("txt_4c_Nivel", "TextBox")
        WITH loc_oPagina.txt_4c_Nivel
            .Top       = 208 + 29
            .Left      = 299
            .Width     = 150
            .Height    = 21
            .MaxLength = 20
            .BackStyle = 1
            .ForeColor = RGB(0, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Lookup Operacao de Producao: F4 (KeyPress), DblClick e LostFocus
        *-- (espelha PROCEDURE Valid do legado, que dispara ao sair do campo)
        BINDEVENT(loc_oPagina.txt_4c_Nivel, "KeyPress", THIS, "NivelLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Nivel, "DblClick", THIS, "NivelLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Nivel, "KeyPress", THIS, "ValidarNivel")

        *-- Label Gerar OP Sem Peso Medio (Say4 legado: Top=245, Left=160, Width=136)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Gerar OP Sem Peso M" + CHR(233) + "dio : "
            .Top       = 245 + 29
            .Left      = 160
            .Width     = 136
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Gerar OP Sem Peso Medio (Optiongroup2 legado: ControlSource=opzers)
        loc_oPagina.AddObject("opt_4c_Opzers", "OptionGroup")
        WITH loc_oPagina.opt_4c_Opzers
            .ButtonCount = 2
            .Top         = 241 + 29
            .Left        = 299
            .Width       = 105
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Opzers.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 4
            .Width     = 34
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Opzers.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 58
            .Top       = 4
            .Width     = 37
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Label Gerar Entrada do Peso (Say1 legado: Top=268, Left=175, Width=121)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Gerar Entrada do Peso : "
            .Top       = 268 + 29
            .Left      = 175
            .Width     = 121
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- OptionGroup Gerar Entrada do Peso (Optiongroup1 legado: ControlSource=EntPes)
        loc_oPagina.AddObject("opt_4c_Entpes", "OptionGroup")
        WITH loc_oPagina.opt_4c_Entpes
            .ButtonCount = 2
            .Top         = 264 + 29
            .Left        = 299
            .Width       = 105
            .Height      = 26
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Entpes.Buttons(1)
            .Caption   = "Sim"
            .BackStyle = 0
            .Left      = 5
            .Top       = 4
            .Width     = 34
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH
        WITH loc_oPagina.opt_4c_Entpes.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .BackStyle = 0
            .Left      = 58
            .Top       = 4
            .Width     = 37
            .Height    = 15
            .Style     = 0
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- Botoes Salvar/Cancelar dentro de cnt_4c_BotoesAcao (Grupo_Salva legado)
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
    * NivelLookupKeyPress - F4 abre lookup de Operacao de Producao (SigCdOpd)
    *===========================================================================
    PROCEDURE NivelLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupOperacao()
        ENDIF
    ENDPROC

    *===========================================================================
    * NivelLookupDblClick - Duplo clique abre lookup de Operacao de Producao
    *===========================================================================
    PROCEDURE NivelLookupDblClick()
        THIS.AbrirLookupOperacao()
    ENDPROC

    *===========================================================================
    * ValidarNivel - Espelha PROCEDURE Valid do Get_nivel legado: ao sair do
    * campo com valor preenchido, valida contra SigCdOpd e abre o picker se
    * nao encontrar exato. Guard this_cUltimoNivelValidado evita reabrir o
    * lookup em toda perda de foco (Problema 45).
    *===========================================================================
    PROCEDURE ValidarNivel(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt, loc_cValor

        loc_oTxt   = THIS.pgf_4c_Paginas.Page2.txt_4c_Nivel
        loc_cValor = ALLTRIM(loc_oTxt.Value)

        IF loc_cValor == THIS.this_cUltimoNivelValidado
            RETURN
        ENDIF
        THIS.this_cUltimoNivelValidado = loc_cValor

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        THIS.AbrirLookupOperacao()
    ENDPROC

    *===========================================================================
    * AbrirLookupOperacao - Lookup COMPLETO de Operacao de Producao (SigCdOpd)
    * Legado: CreateObject('fwBuscaExt', ..., 'SigCdOpd', 'crListaRemota',
    * 'Dopps', This.Value, 'Opera??es de Produ??o', .T.)
    * SigCdOpd eh tabela single-column para este lookup: 'dopps' funciona
    * como codigo E descricao (nao ha coluna de descricao separada).
    *===========================================================================
    PROCEDURE AbrirLookupOperacao()
        LOCAL loc_oTxt, loc_oBusca, loc_cValorAtual

        loc_oTxt = THIS.pgf_4c_Paginas.Page2.txt_4c_Nivel

        IF !loc_oTxt.Enabled
            RETURN
        ENDIF

        loc_cValorAtual = ALLTRIM(loc_oTxt.Value)

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdOpd", ;
            "cursor_4c_BuscaOperacao", ;
            "dopps", ;
            loc_cValorAtual, ;
            "Opera" + CHR(231) + CHR(245) + "es de Produ" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                *-- Registro exato encontrado automaticamente pelo Init
                IF USED("cursor_4c_BuscaOperacao")
                    loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaOperacao.dopps)
                ENDIF
            ELSE
                *-- Nao encontrou exato (ou tabela vazia) - mostrar grid para selecao
                loc_oBusca.mAddColuna("dopps", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaOperacao")
                        loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaOperacao.dopps)
                    ENDIF
                ENDIF
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaOperacao")
            USE IN cursor_4c_BuscaOperacao
        ENDIF

        THIS.this_cUltimoNivelValidado = ALLTRIM(loc_oTxt.Value)
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Abre Page2 em modo BUSCAR (Codigo/Descricao como
    * criterio) - espelha o botao "Buscar" do grp_operacao legado, que
    * habilita Get_Codigos/Get_Descrs e aguarda o Confirmar para localizar
    * o registro na lista (comportamento.json: metodo Procedure de 23 linhas,
    * Seek por Codigos/Descs em CrSigInTgo)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "BUSCAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
                "FormTgp.BtnBuscarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PADRAO CANONICO CLAUDE.md #10: NAO chamar Release() apos - FormBase cuida
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva o registro (INCLUIR/ALTERAR) ou localiza na lista
    * (modo BUSCAR). Validacoes de campo obrigatorio FORA do TRY (Problema 16).
    * Espelha comportamento.json (evento Click 49 linhas): Codigos e Descs
    * obrigatorios; TgpBO.ValidarDados() reforca a validacao (defesa em camada).
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cCodBusca, loc_cDescBusca, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacoes de campo obrigatorio (FORA do TRY - Problema 16)
        IF THIS.this_cModoAtual == "INCLUIR" AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigos.Value))
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido !!!", "Campo Obrigat" + CHR(243) + "rio")
            loc_oPg2.txt_4c_Codigos.SetFocus
            RETURN .F.
        ENDIF

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descrs.Value))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida !!!", "Campo Obrigat" + CHR(243) + "rio")
            loc_oPg2.txt_4c_Descrs.SetFocus
            RETURN .F.
        ENDIF

        TRY
            IF THIS.this_cModoAtual == "BUSCAR"
                loc_cCodBusca  = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
                loc_cDescBusca = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)

                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)

                IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodBusca)
                    SELECT cursor_4c_Dados
                    LOCATE FOR ALLTRIM(cursor_4c_Dados.codigos) = loc_cCodBusca
                    IF !FOUND()
                        MsgAviso("Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. n" + CHR(227) + "o encontrado!", "Busca")
                    ENDIF
                ELSE
                    IF USED("cursor_4c_Dados") AND !EMPTY(loc_cDescBusca)
                        SELECT cursor_4c_Dados
                        LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.descs)) = UPPER(loc_cDescBusca)
                        IF !FOUND()
                            MsgAviso("Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. n" + CHR(227) + "o encontrado!", "Busca")
                        ENDIF
                    ENDIF
                ENDIF

                loc_lResultado = .T.
            ELSE
                THIS.FormParaBO()

                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Tipo de Gera" + CHR(231) + CHR(227) + "o de O.P. salvo com sucesso!", "Sucesso")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ELSE
                    *-- ValidarDados() ja mostra MsgAviso especifico; so exibe generico
                    *-- se o BO informou this_cMensagemErro (ex: falha AntesDeGravar/SQL)
                    IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                        MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, "Erro ao Salvar")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTgp.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao/busca e volta para a lista
    * PROBLEMA 2: DEVE chamar CarregarLista() (via AlternarPagina(1)) para
    * garantir que o grid seja recarregado/reformatado.
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_oBusinessObject.CancelarEdicao()
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        CATCH TO loException
            MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, ;
                "FormTgp.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores do Form para o Business Object
    * (executado antes de Salvar())
    *===========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPg2.txt_4c_Codigos.Value)
        THIS.this_oBusinessObject.this_cDescs   = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
        THIS.this_oBusinessObject.this_nEntpes  = loc_oPg2.opt_4c_Entpes.Value
        THIS.this_oBusinessObject.this_nOpzers  = loc_oPg2.opt_4c_Opzers.Value
        THIS.this_oBusinessObject.this_cDopps   = ALLTRIM(loc_oPg2.txt_4c_Nivel.Value)

        RETURN .T.
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere valores do Business Object para o Form
    * (executado apos CarregarPorCodigo())
    *===========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigos.Value = THIS.this_oBusinessObject.this_cCodigos
        loc_oPg2.txt_4c_Descrs.Value  = THIS.this_oBusinessObject.this_cDescs
        loc_oPg2.opt_4c_Entpes.Value  = IIF(INLIST(THIS.this_oBusinessObject.this_nEntpes, 1, 2), ;
            THIS.this_oBusinessObject.this_nEntpes, 1)
        loc_oPg2.opt_4c_Opzers.Value  = IIF(INLIST(THIS.this_oBusinessObject.this_nOpzers, 1, 2), ;
            THIS.this_oBusinessObject.this_nOpzers, 1)
        loc_oPg2.txt_4c_Nivel.Value   = THIS.this_oBusinessObject.this_cDopps

        THIS.this_cUltimoNivelValidado = ALLTRIM(THIS.this_oBusinessObject.this_cDopps)

        RETURN .T.
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos da Page2 (valores default)
    *===========================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigos.Value = ""
        loc_oPg2.txt_4c_Descrs.Value  = ""
        loc_oPg2.txt_4c_Nivel.Value   = ""
        loc_oPg2.opt_4c_Entpes.Value  = 1
        loc_oPg2.opt_4c_Opzers.Value  = 1

        THIS.this_cUltimoNivelValidado = ""
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos da Page2 conforme modo
    * Codigo (chave primaria): editavel apenas em INCLUIR/BUSCAR (espelha
    * comportamento.json Get_Codigos.When: InList(pcEscolha,'INSERIR','PROCURAR'))
    *===========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Codigos.Enabled = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
            loc_oPg2.txt_4c_Descrs.Enabled  = par_lHabilitar
            loc_oPg2.txt_4c_Nivel.Enabled   = par_lHabilitar
            loc_oPg2.opt_4c_Entpes.Enabled  = par_lHabilitar
            loc_oPg2.opt_4c_Opzers.Enabled  = par_lHabilitar
        CATCH TO loException
            MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
                "FormTgp.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes de acao conforme modo
    * Confirmar desabilitado em VISUALIZAR (padrao canonico dos forms CRUD)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        TRY
            loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loException
            MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
                "FormTgp.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Deve iterar Pages E Controls para PageFrames/Containers aninhados
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
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
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
