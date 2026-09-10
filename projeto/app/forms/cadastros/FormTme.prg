*==============================================================================
* FormTme.prg - Formulario de Cadastro de Transporte de Movimentacao de
*               Estoque (Configuracao de Transporte/FTP entre empresas)
* Migrado de: SigCdTme.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS FormTme AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Transporte de Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
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

    *-- Guardas anti-repeticao para LostFocus (Problema 45: LostFocus dispara
    *-- sempre, ao contrario de Valid que so dispara quando o valor muda)
    this_cUltimoTransTipo   = ""
    this_cUltimoDirGeracao  = ""
    this_cUltimoDirLeitura  = ""
    this_cUltimoDirRecepcao = ""
    this_cUltimoDirArquivar = ""

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
            THIS.this_oBusinessObject = CREATEOBJECT("TmeBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar TmeBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormTme.InicializarForm")
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
                    IF PEMSTATUS(THIS, "CarregarLista", 5)
                        THIS.CarregarLista()
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormTme:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTme.InicializarForm")
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
    * ConfigurarPaginaLista - Page1: cabecalho + Grid + botoes CRUD completos
    * Grid: cursor_4c_Dados (tipoemps, tipos, emps, descrs) - populado por CarregarLista()
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
        *-- Original: Top=1. Com compensacao +29: Top=31
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

        *-- Container Botoes CRUD (Grupo_op no legado) - CANONICO (CLAUDE.md regra Framework)
        *-- Left=542, Top=29, Width=390, Height=85 (lado DIREITO)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
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
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
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

        *-- Grid de listagem de transportes
        *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
        *-- Colunas: tipos (Transporte), emps (Empresa), descrs (Descricao)
        *-- tipoemps (PK concatenada) permanece no cursor mas nao eh exibida
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
        loc_oPagina.grd_4c_Lista.ColumnCount = 3
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
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.emps"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.extensao"

                loc_oGrid.Column1.Width = 150
                loc_oGrid.Column2.Width = 80
                loc_oGrid.Column3.Width = 640

                *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
                *-- Column1 (tipos): o header legado NAO vem de um objeto Header1 estatico do SCX
                *-- (por isso invisivel a scan estatico) - vem do framework Sig*, setado em
                *-- runtime no Init do form (SigCdTme_form_codigo_fonte.txt linha 2677):
                *-- .pfSqlTabela(1).pColuna('Tipos','','','Tipo',52,.t.)
                *-- Caption correta = "Tipo" (NAO "Processo" - esse eh o rotulo do campo na
                *-- Pagina.Dados/Say7, um controle diferente do mesmo formulario)
                loc_oGrid.Column1.Header1.Caption = "Tipo"
                loc_oGrid.Column2.Header1.Caption = "Emp"
                *-- Column3: pColuna do legado declara EXATAMENTE 3 colunas na grade da Lista
                *-- (Tipos->"Tipo", Emps->"Emp", Extensao->"Extensao" - linhas 2677/2678/2679 do
                *-- fonte legado). Descrs NAO aparece na grade legada - usar Descrs aqui era
                *-- desvio do PILAR 1 (grid deve ser identica ao legado). Corrigido para
                *-- Extensao, com o mesmo Caption literal do pColuna (sem acento no legado).
                loc_oGrid.Column3.Header1.Caption = "Extensao"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTme.CarregarLista")
            loc_lResultado = .F.
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
                "FormTme.FormatarGridLista")
        ENDTRY
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
                "FormTme.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Page2: cabecalho + container de acao (vazio)
    * Campos e botoes Confirmar/Cancelar serao adicionados em fases futuras
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (identico ao da pagina Lista) - PRIMEIRO AddObject da pagina
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
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

        *-- Container BotoesAcao (Grupo_Salva no legado) - Confirmar/Cancelar
        *-- Canonico: Left=842, Top=33, Width=160, Height=85
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Left=5)
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

        *-- Botao Cancelar (Left=80)
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

        *-- FASE 5/8 - Campos Principais Parte 1 (Secao "Configuracao do
        *-- Transporte" do legado: Pageframe1.Page1, Top original 12..149).
        *-- FASE 6/8 - Campos Restantes Parte 2 (Secao "Configuracao da area
        *-- do FTP" do legado: Pageframe1.Page1, Top original 185..306).
        *-- Traducao de coordenadas: Top_novo = Top_original + 103
        *-- (compensa cabecalho canonico Top=29/Height=80 -> minimo 109).
        THIS.AdicionarCamposIdentificacao(loc_oPagina)
        THIS.AdicionarCamposTransporte(loc_oPagina)
        THIS.AdicionarCamposFtp(loc_oPagina)

        *-- FASE 9 - PageFrame interno (legado Pageframe1.Page2.Configuracao, 3
        *-- sub-paginas: Titulos/Pag/Rec/Lote Chq, Operacoes de Estoque e
        *-- Configuracao). Posicionado abaixo da secao FTP, que termina em
        *-- Top=411 (shp_4c_DivisorFtpFim). Page2 = legado Configuracao.Page1
        *-- "Operacoes de Estoque" (grid de 11 colunas) - conteudo desta fase.
        loc_oPagina.AddObject("pgf_4c_DadosInternos", "PageFrame")
        WITH loc_oPagina.pgf_4c_DadosInternos
            .PageCount = 3
            .Top       = 145
            .Left      = 48
            .Width     = 708
            .Height    = 420
            .Visible   = .T.

            .Page1.Caption   = "Titulos/Pag/Rec/Lote Chq"
            .Page1.FontName  = "Tahoma"
            .Page1.FontSize  = 8
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.ForeColor = RGB(90, 90, 90)

            .Page2.Caption   = "Opera" + CHR(231) + CHR(245) + "es de Estoque"
            .Page2.FontName  = "Tahoma"
            .Page2.FontSize  = 8
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.ForeColor = RGB(90, 90, 90)

            .Page3.Caption   = "Configura" + CHR(231) + CHR(227) + "o"
            .Page3.FontName  = "Tahoma"
            .Page3.FontSize  = 8
            .Page3.BackColor = RGB(255, 255, 255)
            .Page3.ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Aumenta a altura do form para acomodar o PageFrame interno
        *-- (Top=420 + Height=291 + margem). pgf_4c_Paginas.Height precisa ser
        *-- ressincronizado (foi calculado em ConfigurarPageFrame com o
        *-- THIS.Height antigo).
        THIS.Height = 730
        THIS.pgf_4c_Paginas.Height = THIS.Height + 29

        THIS.ConfigurarPgPage1()
        THIS.ConfigurarPgPage2()

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * AdicionarCamposIdentificacao - Linha de identificacao (fora da caixa
    * "Configuracao do Transporte"): Processo/Tipos, Empresa, Descricao,
    * Tipo de Extensao do Arquivo. Legado: Top 12/16.
    *===========================================================================
    PROTECTED PROCEDURE AdicionarCamposIdentificacao(par_oPagina)
        *-- Processo (Tipos) - chave do transporte
        par_oPagina.AddObject("lbl_4c_Processo", "Label")
        WITH par_oPagina.lbl_4c_Processo
            .Caption   = "Processo :"
            .Top       = 119
            .Left      = 18
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Tipos", "TextBox")
        WITH par_oPagina.txt_4c_Tipos
            .Top       = 115
            .Left      = 85
            .Width     = 52
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Empresa (Emps) - fAcessoEmpresa() NAO foi portada, campo simples
        par_oPagina.AddObject("lbl_4c_Empresa", "Label")
        WITH par_oPagina.lbl_4c_Empresa
            .Caption   = "Empresa :"
            .Top       = 119
            .Left      = 142
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Emps", "TextBox")
        WITH par_oPagina.txt_4c_Emps
            .Top        = 115
            .Left       = 210
            .Width      = 31
            .Height     = 23
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ForeColor  = RGB(0, 0, 0)
            .BackColor  = RGB(255, 255, 255)
            .Value      = ""
            .Visible    = .T.
            .MaxLength   = 3
        ENDWITH

        *-- Descricao (Descrs)
        par_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH par_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 119
            .Left      = 247
            .Width     = 63
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH par_oPagina.txt_4c_Descrs
            .Top       = 115
            .Left      = 320
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Tipo de Extensao do Arquivo (Extensao)
        par_oPagina.AddObject("lbl_4c_TipoExtensao", "Label")
        WITH par_oPagina.lbl_4c_TipoExtensao
            .Caption   = "Tipo de Extens" + CHR(227) + "o do Arquivo :"
            .Top       = 119
            .Left      = 492
            .Width     = 170
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Extensao", "TextBox")
        WITH par_oPagina.txt_4c_Extensao
            .Top       = 115
            .Left      = 668
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * AdicionarCamposTransporte - Caixa "Configuracao do Transporte" (legado
    * Shape3+Say15, Top 44..149): Transporte(Dados)/lookup, diretorio de
    * geracao, No.Transporte Ok, diretorio de leitura, Nao Checar Sequencia,
    * diretorio de recepcao, diretorio para arquivar.
    *===========================================================================
    PROTECTED PROCEDURE AdicionarCamposTransporte(par_oPagina)
        *-- Divisor + titulo da secao (Shape3 + Say15 do legado)
        par_oPagina.AddObject("shp_4c_DivisorTransporte", "Shape")
        WITH par_oPagina.shp_4c_DivisorTransporte
            .Top     = 147
            .Left    = 6
            .Width   = 690
            .Height  = 2
            .Visible = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_SecaoTransporte", "Label")
        WITH par_oPagina.lbl_4c_SecaoTransporte
            .Caption   = " Configura" + CHR(231) + CHR(227) + "o do Transporte"
            .Top       = 150
            .Left      = 6
            .Width     = 250
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Transporte (Dados) - lookup SigPrTrn.Codigos (F4/LostFocus)
        par_oPagina.AddObject("lbl_4c_TransporteDados", "Label")
        WITH par_oPagina.lbl_4c_TransporteDados
            .Caption   = "Transporte (Dados) :"
            .Top       = 157
            .Left      = 506
            .Width     = 120
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_TransTipo", "TextBox")
        WITH par_oPagina.txt_4c_TransTipo
            .Top       = 153
            .Left      = 629
            .Width     = 52
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_TransTipo, "KeyPress", THIS, "TeclaTransTipo")
        BINDEVENT(par_oPagina.txt_4c_TransTipo, "KeyPress", THIS, "ValidarTransTipo")

        *-- Transporte - diretorio de geracao/gravacao (drivets)
        par_oPagina.AddObject("lbl_4c_Transporte", "Label")
        WITH par_oPagina.lbl_4c_Transporte
            .Caption   = "Transporte :"
            .Top       = 183
            .Left      = 15
            .Width     = 62
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DirGeracao", "TextBox")
        WITH par_oPagina.txt_4c_DirGeracao
            .Top       = 180
            .Left      = 79
            .Width     = 430
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_DirGeracao, "KeyPress", THIS, "ValidarDirGeracao")

        *-- No. Transporte Ok (clrarqs) - numerico
        par_oPagina.AddObject("lbl_4c_NoTransporteOk", "Label")
        WITH par_oPagina.lbl_4c_NoTransporteOk
            .Caption   = "No. Transporte Ok :"
            .Top       = 184
            .Left      = 555
            .Width     = 120
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_ClrArqOks", "TextBox")
        WITH par_oPagina.txt_4c_ClrArqOks
            .Top       = 180
            .Left      = 650
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .InputMask = "999"
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Leitura - diretorio de leitura do zip (drivels)
        par_oPagina.AddObject("lbl_4c_Leitura", "Label")
        WITH par_oPagina.lbl_4c_Leitura
            .Caption   = "Leitura :"
            .Top       = 205
            .Left      = 35
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DirLeitura", "TextBox")
        WITH par_oPagina.txt_4c_DirLeitura
            .Top       = 202
            .Left      = 79
            .Width     = 430
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_DirLeitura, "KeyPress", THIS, "ValidarDirLeitura")

        *-- Nao Checar Sequencia (nchkseqs)
        par_oPagina.AddObject("chk_4c_Seqnum", "CheckBox")
        WITH par_oPagina.chk_4c_Seqnum
            .Caption   = "N" + CHR(227) + "o Checar Sequ" + CHR(234) + "ncia "
            .Top       = 207
            .Left      = 531
            .Width     = 129
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Recepcao - diretorio de recepcao do transporte (drivers)
        par_oPagina.AddObject("lbl_4c_Recepcao", "Label")
        WITH par_oPagina.lbl_4c_Recepcao
            .Caption   = "Recep" + CHR(231) + CHR(227) + "o :"
            .Top       = 228
            .Left      = 21
            .Width     = 56
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DirRecepcao", "TextBox")
        WITH par_oPagina.txt_4c_DirRecepcao
            .Top       = 225
            .Left      = 79
            .Width     = 430
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_DirRecepcao, "KeyPress", THIS, "ValidarDirRecepcao")

        *-- Arquivar - diretorio para arquivar arquivo recebido (paths, opcional)
        par_oPagina.AddObject("lbl_4c_Arquivar", "Label")
        WITH par_oPagina.lbl_4c_Arquivar
            .Caption   = "Arquivar :"
            .Top       = 252
            .Left      = 27
            .Width     = 50
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_DirArquivar", "TextBox")
        WITH par_oPagina.txt_4c_DirArquivar
            .Top       = 249
            .Left      = 79
            .Width     = 430
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_DirArquivar, "KeyPress", THIS, "ValidarDirArquivar")

        *-- Caixa decorativa em torno de "Prox.Transp." e "Prox.Recebe" (Shape2 do legado)
        par_oPagina.AddObject("shp_4c_CaixaProximos", "Shape")
        WITH par_oPagina.shp_4c_CaixaProximos
            .Top     = 230
            .Left    = 516
            .Width   = 172
            .Height  = 48
            .Visible = .T.
        ENDWITH

        *-- Proximo Numero de Transporte (sem ControlSource no legado - campo
        *-- desvinculado, nao gravado na tabela)
        par_oPagina.AddObject("lbl_4c_ProxTransp", "Label")
        WITH par_oPagina.lbl_4c_ProxTransp
            .Caption   = "Pr" + CHR(243) + "x.Transp."
            .Top       = 235
            .Left      = 523
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_ProxTransp", "TextBox")
        WITH par_oPagina.txt_4c_ProxTransp
            .Top       = 250
            .Left      = 529
            .Width     = 58
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .InputMask = "999999"
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Proximo Numero de Recebimento (sem ControlSource no legado - campo
        *-- desvinculado, nao gravado na tabela)
        par_oPagina.AddObject("lbl_4c_ProxRecebe", "Label")
        WITH par_oPagina.lbl_4c_ProxRecebe
            .Caption   = "Pr" + CHR(243) + "x.Recebe"
            .Top       = 234
            .Left      = 604
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_ProxRecebe", "TextBox")
        WITH par_oPagina.txt_4c_ProxRecebe
            .Top       = 249
            .Left      = 612
            .Width     = 58
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .InputMask = "999999"
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        *-- Divisor de fechamento da caixa "Configuracao do Transporte" (Shape1 do legado)
        par_oPagina.AddObject("shp_4c_DivisorTransporteFim", "Shape")
        WITH par_oPagina.shp_4c_DivisorTransporteFim
            .Top     = 285
            .Left    = 4
            .Width   = 690
            .Height  = 2
            .Visible = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * AdicionarCamposFtp - Caixa "Configuracao da area do FTP" (legado Say12,
    * Top 185..306): tipo de conexao (D/B), limpar diretorio de envio/FTP,
    * endereco FTP, usuario, senha (+ redigita confirmacao), pasta de envio,
    * pasta de recepcao.
    *===========================================================================
    PROTECTED PROCEDURE AdicionarCamposFtp(par_oPagina)
        *-- Titulo da secao (Say12 do legado)
        par_oPagina.AddObject("lbl_4c_SecaoFtp", "Label")
        WITH par_oPagina.lbl_4c_SecaoFtp
            .Caption   = " Configura" + CHR(231) + CHR(227) + "o da " + CHR(225) + "rea do FTP "
            .Top       = 288
            .Left      = 5
            .Width     = 194
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Tipo de Conexao (tpconexao) - D=Dial-Up / B=Banda Larga
        par_oPagina.AddObject("lbl_4c_TipoConexao", "Label")
        WITH par_oPagina.lbl_4c_TipoConexao
            .Caption   = "Tipo de Conex" + CHR(227) + "o :"
            .Top       = 314
            .Left      = 27
            .Width     = 90
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("txt_4c_Tpconexao", "TextBox")
        WITH par_oPagina.txt_4c_Tpconexao
            .Top       = 310
            .Left      = 122
            .Width     = 28
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_DialUpBanda", "Label")
        WITH par_oPagina.lbl_4c_DialUpBanda
            .Caption   = "(D/B) Dial-Up / Banda Larga"
            .Top       = 313
            .Left      = 153
            .Width     = 159
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Limpa diretorio de envio (locdel) - legado Top=210 + offset canonico +103 = 313
        *-- (confere com os vizinhos da mesma linha: Say19/Say5 legado Top=210/211 ->
        *-- lbl_4c_DialUpBanda/lbl_4c_TipoConexao migrado Top=313/314). Offset sistemico da
        *-- faixa de cabecalho injetada na Pagina.Dados (CLAUDE.md regra #11 - prevalece sobre
        *-- PILAR 1). O diff de 103px vs o legado NAO eh desalinhamento - eh o re-layout
        *-- obrigatorio de toda a pagina apos a faixa. NAO alterar.
        par_oPagina.AddObject("chk_4c_Chklocdel", "CheckBox")
        WITH par_oPagina.chk_4c_Chklocdel
            .Caption   = "Limpa diret" + CHR(243) + "rio de envio"
            .Top       = 313
            .Left      = 362
            .Width     = 160
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Limpa diretorio do FTP (ftpdel) - legado Top=210 + offset canonico +103 = 313
        *-- (mesma linha de chk_4c_Chklocdel acima - offset sistemico CLAUDE.md regra #11,
        *-- ver comentario). NAO alterar.
        par_oPagina.AddObject("chk_4c_Chkftpdel", "CheckBox")
        WITH par_oPagina.chk_4c_Chkftpdel
            .Caption   = "Limpa diret" + CHR(243) + "rio do FTP"
            .Top       = 313
            .Left      = 527
            .Width     = 160
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- Endereco FTP (ftpend)
        par_oPagina.AddObject("txt_4c_Ftpend", "TextBox")
        WITH par_oPagina.txt_4c_Ftpend
            .Top       = 333
            .Left      = 122
            .Width     = 330
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_EnderecoFtp", "Label")
        WITH par_oPagina.lbl_4c_EnderecoFtp
            .Caption   = "Endere" + CHR(231) + "o FTP :"
            .Top       = 335
            .Left      = 42
            .Width     = 75
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Usuario do FTP (ftpusuario)
        par_oPagina.AddObject("txt_4c_Ftpusuario", "TextBox")
        WITH par_oPagina.txt_4c_Ftpusuario
            .Top       = 333
            .Left      = 526
            .Width     = 160
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_Usuario", "Label")
        WITH par_oPagina.lbl_4c_Usuario
            .Caption   = "Usu" + CHR(225) + "rio :"
            .Top       = 336
            .Left      = 477
            .Width     = 45
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Pasta p/ Envio (dirftpts)
        par_oPagina.AddObject("txt_4c_Dirftpts", "TextBox")
        WITH par_oPagina.txt_4c_Dirftpts
            .Top       = 356
            .Left      = 122
            .Width     = 330
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_PastaEnvio", "Label")
        WITH par_oPagina.lbl_4c_PastaEnvio
            .Caption   = "Pasta p/ Envio :"
            .Top       = 358
            .Left      = 39
            .Width     = 78
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Senha do FTP (ftpsenha) - criptografada; Valid legado codifica ao
        *-- perder o foco (fDecriptografar, apesar do nome, CODIFICA para gravar)
        par_oPagina.AddObject("txt_4c_Ftpsenha", "TextBox")
        WITH par_oPagina.txt_4c_Ftpsenha
            .Top          = 356
            .Left         = 526
            .Width        = 130
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .ForeColor    = RGB(0, 0, 0)
            .BackColor    = RGB(255, 255, 255)
            .PasswordChar = "*"
            .Value        = ""
            .Visible      = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Ftpsenha, "KeyPress", THIS, "ValidarFtpSenha")

        par_oPagina.AddObject("lbl_4c_Senha", "Label")
        WITH par_oPagina.lbl_4c_Senha
            .Caption   = "Senha :"
            .Top       = 359
            .Left      = 483
            .Width     = 39
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Pasta p/Recepcao (dirftpls)
        par_oPagina.AddObject("txt_4c_Dirftpls", "TextBox")
        WITH par_oPagina.txt_4c_Dirftpls
            .Top       = 379
            .Left      = 122
            .Width     = 330
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        par_oPagina.AddObject("lbl_4c_PastaRecepcao", "Label")
        WITH par_oPagina.lbl_4c_PastaRecepcao
            .Caption   = "Pasta p/Recep" + CHR(231) + CHR(227) + "o :"
            .Top       = 381
            .Left      = 21
            .Width     = 96
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Redigita a Senha (sem ControlSource no legado - campo de
        *-- confirmacao apenas, nao gravado na tabela)
        par_oPagina.AddObject("txt_4c_Senha2", "TextBox")
        WITH par_oPagina.txt_4c_Senha2
            .Top          = 379
            .Left         = 526
            .Width        = 130
            .Height       = 23
            .FontName     = "Tahoma"
            .FontSize     = 8
            .ForeColor    = RGB(0, 0, 0)
            .BackColor    = RGB(255, 255, 255)
            .PasswordChar = "*"
            .Value        = ""
            .Visible      = .T.
        ENDWITH
        BINDEVENT(par_oPagina.txt_4c_Senha2, "KeyPress", THIS, "ValidarSenha2")

        par_oPagina.AddObject("lbl_4c_Redigita", "Label")
        WITH par_oPagina.lbl_4c_Redigita
            .Caption   = "Redigita :"
            .Top       = 382
            .Left      = 474
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Divisor de fechamento da caixa "Configuracao da area do FTP" (Shape4 do legado)
        par_oPagina.AddObject("shp_4c_DivisorFtpFim", "Shape")
        WITH par_oPagina.shp_4c_DivisorFtpFim
            .Top     = 409
            .Left    = 4
            .Width   = 690
            .Height  = 2
            .Visible = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarPgPage1 - pgf_4c_DadosInternos.Page2 (legado Pageframe1.Page2.
    * Configuracao.Page1 "Operacoes de Estoque"): grid grd_4c_Grade (11
    * colunas, cursor_4c_Grade = csGrade legado) + 14 labels de legenda S/N/T
    * abaixo da grade. fAcessoEmpresa()/fAcessoMovmto()/fAcessoContas() NAO
    * foram portadas (memoria do projeto) - colunas Emp/Empds/Operacao
    * Destino/Local Entrega ficam como campos simples, sem lookup.
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage1()
        LOCAL loc_oPgN, loc_nCol

        IF !USED("cursor_4c_Grade")
            SET NULL ON
            CREATE CURSOR cursor_4c_Grade (tipoemps C(9), emps C(3), dopes C(20), ;
                cidchaves C(20), chkpagos C(1), chksubns C(1), empds C(3), ;
                dopeds C(20), contaes C(10), apagas C(1), ndias N(2), ;
                numeras C(1), dttrans C(1))
            SET NULL OFF
        ENDIF

        loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2

        *-- Grid de operacoes (csGrade no legado)
        loc_oPgN.AddObject("grd_4c_Grade", "Grid")
        loc_oPgN.grd_4c_Grade.ColumnCount  = 11
        loc_oPgN.grd_4c_Grade.RecordSource = "cursor_4c_Grade"
        WITH loc_oPgN.grd_4c_Grade
            .Top               = 1
            .Left              = 55
            .Width             = 595
            .Height            = 241
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 16
            .RowHeight         = 16
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.

            .Column1.ControlSource = "cursor_4c_Grade.emps"
            .Column1.Width         = 34
            .Column1.Movable       = .F.
            .Column1.Resizable     = .F.

            .Column2.ControlSource = "cursor_4c_Grade.dopes"
            .Column2.Width         = 148
            .Column2.Movable       = .F.
            .Column2.Resizable     = .F.

            .Column3.ControlSource = "cursor_4c_Grade.chkpagos"
            .Column3.Width         = 17
            .Column3.ColumnOrder   = 4
            .Column3.Movable       = .F.
            .Column3.Resizable     = .F.

            .Column4.ControlSource = "cursor_4c_Grade.chksubns"
            .Column4.Width         = 17
            .Column4.ColumnOrder   = 5
            .Column4.Movable       = .F.
            .Column4.Resizable     = .F.

            .Column5.ControlSource = "cursor_4c_Grade.empds"
            .Column5.Width         = 31
            .Column5.ColumnOrder   = 3
            .Column5.Movable       = .F.
            .Column5.Resizable     = .F.

            .Column6.ControlSource = "cursor_4c_Grade.dopeds"
            .Column6.Width         = 140
            .Column6.Movable       = .F.
            .Column6.Resizable     = .F.

            .Column7.ControlSource = "cursor_4c_Grade.contaes"
            .Column7.Width         = 78
            .Column7.Movable       = .F.
            .Column7.Resizable     = .F.

            .Column8.ControlSource = "cursor_4c_Grade.apagas"
            .Column8.Width         = 27

            .Column9.ControlSource = "cursor_4c_Grade.ndias"
            .Column9.Width         = 24

            .Column10.ControlSource = "cursor_4c_Grade.numeras"
            .Column10.Width         = 27

            .Column11.ControlSource = "cursor_4c_Grade.dttrans"
            .Column11.Width         = 20
            .Column11.Movable       = .F.
            .Column11.Resizable     = .F.
            .Column11.ForeColor     = RGB(0, 0, 0)

            *-- Headers (OBRIGATORIO apos RecordSource/ControlSource)
            .Column1.Header1.Caption  = "Emp"
            .Column2.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Caption  = "Pg"
            .Column4.Header1.Caption  = "Bx"
            .Column5.Header1.Caption  = "Empds"
            .Column6.Header1.Caption  = "Opera" + CHR(231) + CHR(227) + "o Destino"
            .Column7.Header1.Caption  = "Local Entrega"
            .Column8.Header1.Caption  = "Del"
            .Column9.Header1.Caption  = "DD"
            .Column10.Header1.Caption = "NN"
            .Column11.Header1.Caption = "DT"
        ENDWITH

        *-- Text1 de cada coluna: fonte/alinhamento/sem borda (padrao legado)
        FOR loc_nCol = 1 TO 11
            WITH loc_oPgN.grd_4c_Grade.Columns(loc_nCol).Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDFOR

        *-- Colunas numerica/S-N-T: mascaras (CLAUDE.md - TextBox S/N exige
        *-- Format="M" + InputMask enumerada)
        WITH loc_oPgN.grd_4c_Grade
            .Column3.Text1.Format     = "M"
            .Column3.Text1.InputMask  = "S,N,T, "
            .Column4.Text1.Format     = "M"
            .Column4.Text1.InputMask  = "S,N,T, "
            .Column8.Text1.Format     = "M"
            .Column8.Text1.InputMask  = "S,N, "
            .Column9.Text1.InputMask  = "99"
            .Column10.Text1.Format    = "M"
            .Column10.Text1.InputMask = "S,N, "
            .Column11.Text1.Format    = "M"
            .Column11.Text1.InputMask = "S,N, "
        ENDWITH

        *-- Validacoes (LostFocus - fAcessoEmpresa/fAcessoMovmto/fAcessoContas
        *-- NAO foram portadas: colunas 1/5/6/7 ficam sem lookup, campo simples)
        BINDEVENT(loc_oPgN.grd_4c_Grade.Column2.Text1,  "KeyPress", THIS, "ValidarGradeOperacao")
        BINDEVENT(loc_oPgN.grd_4c_Grade.Column3.Text1,  "KeyPress", THIS, "ValidarGradeSNT3")
        BINDEVENT(loc_oPgN.grd_4c_Grade.Column4.Text1,  "KeyPress", THIS, "ValidarGradeSNT4")
        BINDEVENT(loc_oPgN.grd_4c_Grade.Column7.Text1,  "KeyPress", THIS, "ValidarGradeLocalEntrega")
        BINDEVENT(loc_oPgN.grd_4c_Grade.Column8.Text1,  "KeyPress", THIS, "ValidarGradeApagas")
        BINDEVENT(loc_oPgN.grd_4c_Grade.Column10.Text1, "KeyPress", THIS, "ValidarGradeNumeras")
        BINDEVENT(loc_oPgN.grd_4c_Grade.Column11.Text1, "KeyPress", THIS, "ValidarGradeDtTrans")

        *-- Legenda [S]im/[N]ao/[T]odos - Pg/Bx (Label1..Label10 do legado)
        loc_oPgN.AddObject("lbl_4c_LegendaPg", "Label")
        WITH loc_oPgN.lbl_4c_LegendaPg
            .Caption   = "[    ]im / [    ]ao / [    ]odos"
            .Top       = 247
            .Left      = 69
            .Width     = 137
            .Height    = 13
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_LegendaBx", "Label")
        WITH loc_oPgN.lbl_4c_LegendaBx
            .Caption   = "[    ]im / [    ]ao / [    ]odos"
            .Top       = 247
            .Left      = 318
            .Width     = 137
            .Height    = 13
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_RotuloPg", "Label")
        WITH loc_oPgN.lbl_4c_RotuloPg
            .Caption   = "Pg(Pago) : "
            .Top       = 247
            .Left      = 12
            .Width     = 59
            .Height    = 13
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_RotuloBx", "Label")
        WITH loc_oPgN.lbl_4c_RotuloBx
            .Caption   = "Bx(Baixado) : "
            .Top       = 247
            .Left      = 245
            .Width     = 74
            .Height    = 13
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_PgS", "Label")
        WITH loc_oPgN.lbl_4c_PgS
            .Caption   = "S"
            .Top       = 246
            .Left      = 77
            .Width     = 10
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_BxS", "Label")
        WITH loc_oPgN.lbl_4c_BxS
            .Caption   = "S"
            .Top       = 246
            .Left      = 326
            .Width     = 10
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_PgN", "Label")
        WITH loc_oPgN.lbl_4c_PgN
            .Caption   = "N"
            .Top       = 246
            .Left      = 122
            .Width     = 10
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_BxN", "Label")
        WITH loc_oPgN.lbl_4c_BxN
            .Caption   = "N"
            .Top       = 246
            .Left      = 372
            .Width     = 10
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_PgT", "Label")
        WITH loc_oPgN.lbl_4c_PgT
            .Caption   = "T"
            .Top       = 246
            .Left      = 169
            .Width     = 9
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_BxT", "Label")
        WITH loc_oPgN.lbl_4c_BxT
            .Caption   = "T"
            .Top       = 246
            .Left      = 418
            .Width     = 9
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Legenda [S]im/[N]ao - Nn/Troca Numeracao (Label11..Label14 do legado)
        loc_oPgN.AddObject("lbl_4c_LegendaNn", "Label")
        WITH loc_oPgN.lbl_4c_LegendaNn
            .Caption   = "[    ]im / [    ]ao"
            .Top       = 247
            .Left      = 594
            .Width     = 81
            .Height    = 13
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_RotuloNn", "Label")
        WITH loc_oPgN.lbl_4c_RotuloNn
            .Caption   = "Nn(Troca Numera" + CHR(231) + CHR(227) + "o) : "
            .Top       = 247
            .Left      = 477
            .Width     = 122
            .Height    = 13
            .FontName  = "Tahoma"
            .FontSize  = 7
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_NnS", "Label")
        WITH loc_oPgN.lbl_4c_NnS
            .Caption   = "S"
            .Top       = 246
            .Left      = 602
            .Width     = 10
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_NnN", "Label")
        WITH loc_oPgN.lbl_4c_NnN
            .Caption   = "N"
            .Top       = 246
            .Left      = 648
            .Width     = 10
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPgN)
    ENDPROC

    *===========================================================================
    * ValidarGradeOperacao - LostFocus da coluna "Opera" + CHR(231)+CHR(227) +
    * "o" (Dopes) do grid de opera" + CHR(231) + CHR(245) + "es. Reproduz o
    * aviso do Valid legado: PAGAMENTO/RECEBIMENTO devem ser informados na
    * aba "Titulos/Pag/Rec/Lote Chq", nao aqui. fAcessoMovmto() NAO foi
    * portada - sem lookup, apenas o aviso.
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE ValidarGradeOperacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrid, loc_cValor
        loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade
        loc_cValor = ALLTRIM(UPPER(loc_oGrid.Column2.Text1.Value))

        IF INLIST(loc_cValor, "PAGAMENTO", "RECEBIMENTO")
            MsgAviso('Favor informar as opera' + CHR(231) + CHR(245) + 'es de PAGAMENTO/RECEBIMENTO na Aba "Titulos/Pag/Rec/Lote Chq"', ;
                "Aten" + CHR(231) + CHR(227) + "o")
            loc_oGrid.Column2.Text1.Value = ""
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarGradeSNT3/ValidarGradeSNT4 - LostFocus das colunas "Pg"/"Bx"
    * (S/N/T) do grid de opera" + CHR(231) + CHR(245) + "es
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE ValidarGradeSNT3(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oText
        loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column3.Text1
        IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N", "T")
            MsgAviso("Informe [S]im / [N]ao / [T]odos")
        ENDIF
    ENDPROC

    PROCEDURE ValidarGradeSNT4(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oText
        loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column4.Text1
        IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N", "T")
            MsgAviso("Informe [S]im / [N]ao / [T]odos")
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarGradeLocalEntrega - LostFocus da coluna "Local Entrega" (ContaEs).
    * fAcessoContas() NAO foi portada (memoria do projeto: lookup UX proibido
    * quando a funcao nao existe de fato) - campo simples. Reproduz apenas o
    * retorno de foco do legado para a coluna 1.
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE ValidarGradeLocalEntrega(par_nKeyCode, par_nShiftAltCtrl)
        THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column1.SetFocus()
    ENDPROC

    *===========================================================================
    * ValidarGradeApagas - LostFocus da coluna "Del" (S/N). Se [S], confirma a
    * delecao dos dados apos a geracao do transporte; se recusado, limpa o
    * valor (adaptacao do Valid legado - Return .f. mantinha o foco na
    * celula, o que nao se aplica a um handler de LostFocus).
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE ValidarGradeApagas(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oText
        loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column8.Text1

        IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N")
            MsgAviso("Informe [S]im / [N]ao / [ ]")
        ELSE
            IF UPPER(loc_oText.Value) == "S"
                IF !MsgConfirma("Confirma Dele" + CHR(231) + CHR(227) + "o dos Dados ap" + CHR(243) + "s a gera" + CHR(231) + CHR(227) + "o do Transporte?")
                    loc_oText.Value = ""
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarGradeNumeras - LostFocus da coluna "NN" (troca numeracao, S/N).
    * Se [S], confirma a troca de numeracao na recepcao dos dados; se
    * recusado, limpa o valor (mesma adaptacao de ValidarGradeApagas).
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE ValidarGradeNumeras(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oText
        loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column10.Text1

        IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N")
            MsgAviso("Informe [S]im / [N]ao / [ ]")
        ELSE
            IF UPPER(loc_oText.Value) == "S"
                IF !MsgConfirma("Confirma Troca da Numera" + CHR(231) + CHR(227) + "o desta Opera" + CHR(231) + CHR(227) + "o Na Recep" + CHR(231) + CHR(227) + "o dos Dados ?")
                    loc_oText.Value = ""
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarGradeDtTrans - LostFocus da coluna "DT" (S/N). Se [S], confirma o
    * envio da movimentacao com a data de transporte ja preenchida na
    * recepcao dos dados; se recusado, limpa o valor (mesma adaptacao de
    * ValidarGradeApagas).
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE ValidarGradeDtTrans(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oText
        loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page2.grd_4c_Grade.Column11.Text1

        IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N")
            MsgAviso("Informe [S]im / [N]ao / [ ]")
        ELSE
            IF UPPER(loc_oText.Value) == "S"
                IF !MsgConfirma("Confirma Enviar a Movimenta" + CHR(231) + CHR(227) + "o com a Data de Transporte j" + CHR(225) + " Preenchida na Opera" + CHR(231) + CHR(227) + "o Na Recep" + CHR(231) + CHR(227) + "o dos Dados ?")
                    loc_oText.Value = ""
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * ConfigurarPgPage2 - pgf_4c_DadosInternos.Page1 (legado Pageframe1.Page2.
    * Configuracao.Page2 "Titulos/Pag/Rec/Lote Chq"): grid grd_4c_Titulos (3
    * colunas, cursor_4c_Titulos = CsTitulo legado - mesmo cursor que
    * TmeBO.this_cCursorTitulos/BuscarTitulos ja usam) + 4 labels de legenda
    * S/N/A abaixo da grade. Coluna 1 (Emp): fAcessoEmpresa() NAO foi portada
    * (memoria do projeto) - fica como campo simples, sem lookup. Coluna 2
    * (Opera" + CHR(231) + CHR(227) + "o): fwBuscaSel legado -> equivalente
    * moderno FormBuscaAuxiliar (Modo 2, cursor local cursor_4c_Operacoes
    * montado por TmeBO.BuscarOperacoesDisponiveis).
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgPage2()
        LOCAL loc_oPgN, loc_nCol

        IF !USED("cursor_4c_Titulos")
            SET NULL ON
            CREATE CURSOR cursor_4c_Titulos (tipoemps C(9), emps C(3), dopes C(20), ;
                cidchaves C(20), cnotas C(1), empds C(3))
            SET NULL OFF
        ENDIF

        loc_oPgN = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1

        *-- Grid de titulos/pagamentos/recebimentos/lote de cheque (CsTitulo no legado)
        loc_oPgN.AddObject("grd_4c_Titulos", "Grid")
        loc_oPgN.grd_4c_Titulos.ColumnCount  = 3
        loc_oPgN.grd_4c_Titulos.RecordSource = "cursor_4c_Titulos"
        WITH loc_oPgN.grd_4c_Titulos
            .Top               = 1
            .Left              = 222
            .Width             = 260
            .Height            = 242
            .FontName          = "Tahoma"
            .FontSize          = 8
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .HeaderHeight      = 16
            .RowHeight         = 16
            .ScrollBars        = 2
            .GridLineColor     = RGB(238, 238, 238)
            .Visible           = .T.

            .Column1.ControlSource = "cursor_4c_Titulos.emps"
            .Column1.Width         = 40
            .Column1.Movable       = .F.
            .Column1.Resizable     = .F.

            .Column2.ControlSource = "cursor_4c_Titulos.dopes"
            .Column2.Width         = 150
            .Column2.Movable       = .F.
            .Column2.Resizable     = .F.

            .Column3.ControlSource = "cursor_4c_Titulos.cnotas"
            .Column3.Width         = 38
            .Column3.Movable       = .F.
            .Column3.Resizable     = .F.

            *-- Headers (OBRIGATORIO apos RecordSource/ControlSource)
            .Column1.Header1.Caption = "Emp"
            .Column2.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Caption = "S/N/A"
        ENDWITH

        *-- Text1 de cada coluna: fonte/alinhamento/sem borda (padrao legado)
        FOR loc_nCol = 1 TO 3
            WITH loc_oPgN.grd_4c_Titulos.Columns(loc_nCol).Text1
                .FontName    = "Tahoma"
                .FontSize    = 8
                .BorderStyle = 0
                .Margin      = 0
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
            ENDWITH
        ENDFOR

        *-- Coluna S/N/A: mascara (CLAUDE.md - TextBox S/N exige Format="M" +
        *-- InputMask enumerada)
        loc_oPgN.grd_4c_Titulos.Column3.Text1.Format    = "M"
        loc_oPgN.grd_4c_Titulos.Column3.Text1.InputMask = "S,N,A, "

        *-- Validacoes (LostFocus - fAcessoEmpresa NAO foi portada: coluna 1
        *-- fica sem lookup, campo simples)
        BINDEVENT(loc_oPgN.grd_4c_Titulos.Column2.Text1, "KeyPress", THIS, "ValidarGradeTituloOperacao")
        BINDEVENT(loc_oPgN.grd_4c_Titulos.Column3.Text1, "KeyPress", THIS, "ValidarGradeTituloSNA")

        *-- Legenda [S]im/[N]ao/[A]mbos (Label1/5/7/9 do legado)
        loc_oPgN.AddObject("lbl_4c_LegendaSNA", "Label")
        WITH loc_oPgN.lbl_4c_LegendaSNA
            .Caption   = "[ S ]im / [ N ]ao / [ A ]mbos"
            .Top       = 248
            .Left      = 270
            .Width     = 155
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_SnaS", "Label")
        WITH loc_oPgN.lbl_4c_SnaS
            .Caption   = "S"
            .Top       = 247
            .Left      = 278
            .Width     = 10
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_SnaN", "Label")
        WITH loc_oPgN.lbl_4c_SnaN
            .Caption   = "N"
            .Top       = 247
            .Left      = 326
            .Width     = 10
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oPgN.AddObject("lbl_4c_SnaA", "Label")
        WITH loc_oPgN.lbl_4c_SnaA
            .Caption   = "A"
            .Top       = 247
            .Left      = 375
            .Width     = 11
            .Height    = 16
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPgN)
    ENDPROC

    *===========================================================================
    * ValidarGradeTituloOperacao - LostFocus da coluna "Opera" + CHR(231) +
    * CHR(227) + "o" (Dopes) do grid de t" + CHR(237) + "tulos. Reproduz o
    * Valid legado: se o valor nao existir em SigOpOpe nem for uma das
    * operacoes especiais fixas (PAGAMENTO/RECEBIMENTO/LOTE DE CHEQUE), abre
    * FormBuscaAuxiliar (equivalente ao fwBuscaSel legado sobre CrSigOpOpe)
    * para selecao; ao selecionar, marca cnotas = "A" (Replace ... With 'A'
    * in CsTitulo do legado).
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE ValidarGradeTituloOperacao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oGrid, loc_cValor, loc_oBusca

        loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1.grd_4c_Titulos
        loc_cValor = ALLTRIM(UPPER(loc_oGrid.Column2.Text1.Value))

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.BuscarOperacoesDisponiveis()
            RETURN
        ENDIF

        IF USED("cursor_4c_Operacoes")
            IF !SEEK(loc_cValor, "cursor_4c_Operacoes", "dopes")
                TRY
                    loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                    IF VARTYPE(loc_oBusca) = "O"
                        loc_oBusca.this_cCursorDestino = "cursor_4c_Operacoes"
                        loc_oBusca.this_cTitulo        = "Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos"
                        loc_oBusca.mAddColuna("dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()

                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Operacoes")
                            loc_oGrid.Column2.Text1.Value = ALLTRIM(cursor_4c_Operacoes.dopes)
                            IF USED("cursor_4c_Titulos")
                                REPLACE cnotas WITH "A" IN cursor_4c_Titulos
                            ENDIF
                        ENDIF
                        loc_oBusca.Release()
                    ENDIF
                CATCH TO loException
                    MsgErro(loException.Message, "FormTme.ValidarGradeTituloOperacao")
                ENDTRY
            ENDIF
            USE IN cursor_4c_Operacoes
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarGradeTituloSNA - LostFocus da coluna "S/N/A" do grid de titulos
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE ValidarGradeTituloSNA(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oText
        loc_oText = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1.grd_4c_Titulos.Column3.Text1

        IF !EMPTY(loc_oText.Value) AND !INLIST(UPPER(loc_oText.Value), "S", "N", "A")
            MsgAviso("Informe [S]sim / [N]ao / [A]mbos")
        ENDIF
    ENDPROC

    *===========================================================================
    * TeclaTransTipo - KeyPress (F4) para txt_4c_TransTipo
    * PUBLIC + LPARAMETERS obrigatorios (BINDEVENT so funciona com metodo
    * PUBLIC; KeyPress sempre passa 2 parametros - CLAUDE.md regras #2/#38)
    *===========================================================================
    PROCEDURE TeclaTransTipo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 63
            THIS.AbrirBuscaTransTipo(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_TransTipo.Value))
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarTransTipo - LostFocus para txt_4c_TransTipo (mesma logica do
    * Valid legado: se preenchido, busca/valida em SigPrTrn). Guard evita
    * reabrir o lookup quando o valor nao mudou desde a ultima validacao.
    *===========================================================================
    PROCEDURE ValidarTransTipo(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_TransTipo.Value)

        IF loc_cValor == THIS.this_cUltimoTransTipo
            RETURN
        ENDIF
        THIS.this_cUltimoTransTipo = loc_cValor

        IF !EMPTY(loc_cValor)
            THIS.AbrirBuscaTransTipo(loc_cValor)
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirBuscaTransTipo - FormBuscaAuxiliar sobre SigPrTrn (Codigos/Descrs)
    *===========================================================================
    PROCEDURE AbrirBuscaTransTipo(par_cValor)
        LOCAL loc_oBusca, loc_oPg2

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrTrn", "cursor_4c_BuscaTransTipo", "Codigos", par_cValor, ;
                "Tipo de Transporte")

            IF VARTYPE(loc_oBusca) = "O"
                IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                    IF USED("cursor_4c_BuscaTransTipo")
                        loc_oPg2.txt_4c_TransTipo.Value = ALLTRIM(cursor_4c_BuscaTransTipo.Codigos)
                    ENDIF
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                        IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTransTipo")
                            loc_oPg2.txt_4c_TransTipo.Value = ALLTRIM(cursor_4c_BuscaTransTipo.Codigos)
                        ELSE
                            loc_oPg2.txt_4c_TransTipo.Value = ""
                        ENDIF
                    ENDIF
                ENDIF
                THIS.this_cUltimoTransTipo = ALLTRIM(loc_oPg2.txt_4c_TransTipo.Value)
                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MsgErro(loException.Message, "FormTme.AbrirBuscaTransTipo")
        ENDTRY

        IF USED("cursor_4c_BuscaTransTipo")
            USE IN cursor_4c_BuscaTransTipo
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarDirGeracao/ValidarDirLeitura/ValidarDirRecepcao/ValidarDirArquivar
    * LostFocus - reproduz o Valid legado: se o diretorio nao existe, oferece
    * GETDIR() para selecao; se confirmado invalido, avisa e limpa o campo.
    * Se existe, normaliza (UPPER + barra final). Guard evita repetir o
    * GETDIR quando o valor nao mudou desde a ultima validacao (Problema 45).
    * Arquivar aceita vazio (campo opcional no legado).
    *===========================================================================
    PROCEDURE ValidarDirGeracao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirGeracao.Value)

        IF loc_cValor == THIS.this_cUltimoDirGeracao
            RETURN
        ENDIF

        IF !DIRECTORY(loc_cValor)
            loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio Grava" + CHR(231) + CHR(227) + "o do Transporte")
            IF !DIRECTORY(loc_cValor)
                MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
                loc_cValor = ""
            ENDIF
        ELSE
            loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
        ENDIF

        THIS.this_cUltimoDirGeracao = loc_cValor
        THIS.pgf_4c_Paginas.Page2.txt_4c_DirGeracao.Value = loc_cValor
        THIS.pgf_4c_Paginas.Page2.txt_4c_DirGeracao.Refresh()
    ENDPROC

    PROCEDURE ValidarDirLeitura(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirLeitura.Value)

        IF loc_cValor == THIS.this_cUltimoDirLeitura
            RETURN
        ENDIF

        IF !DIRECTORY(loc_cValor)
            loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio Leitura do Zip")
            IF !DIRECTORY(loc_cValor)
                MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
                loc_cValor = ""
            ENDIF
        ELSE
            loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
        ENDIF

        THIS.this_cUltimoDirLeitura = loc_cValor
        THIS.pgf_4c_Paginas.Page2.txt_4c_DirLeitura.Value = loc_cValor
        THIS.pgf_4c_Paginas.Page2.txt_4c_DirLeitura.Refresh()
    ENDPROC

    PROCEDURE ValidarDirRecepcao(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirRecepcao.Value)

        IF loc_cValor == THIS.this_cUltimoDirRecepcao
            RETURN
        ENDIF

        IF !DIRECTORY(loc_cValor)
            loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio Recep" + CHR(231) + CHR(227) + "o do Transporte")
            IF !DIRECTORY(loc_cValor)
                MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
                loc_cValor = ""
            ENDIF
        ELSE
            loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
        ENDIF

        THIS.this_cUltimoDirRecepcao = loc_cValor
        THIS.pgf_4c_Paginas.Page2.txt_4c_DirRecepcao.Value = loc_cValor
        THIS.pgf_4c_Paginas.Page2.txt_4c_DirRecepcao.Refresh()
    ENDPROC

    PROCEDURE ValidarDirArquivar(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cValor
        loc_cValor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_DirArquivar.Value)

        IF loc_cValor == THIS.this_cUltimoDirArquivar
            RETURN
        ENDIF

        IF !EMPTY(loc_cValor)
            IF !DIRECTORY(loc_cValor)
                loc_cValor = GETDIR(loc_cValor, "Diret" + CHR(243) + "rio para Arquivar o arquivo recebido")
                IF !DIRECTORY(loc_cValor)
                    MsgAviso("Diret" + CHR(243) + "rio N" + CHR(227) + "o Localizado!!!")
                    loc_cValor = ""
                ENDIF
            ELSE
                loc_cValor = ALLTRIM(UPPER(loc_cValor)) + IIF(RIGHT(ALLTRIM(loc_cValor), 1) != "\", "\", "")
            ENDIF
        ENDIF

        THIS.this_cUltimoDirArquivar = loc_cValor
        THIS.pgf_4c_Paginas.Page2.txt_4c_DirArquivar.Value = loc_cValor
        THIS.pgf_4c_Paginas.Page2.txt_4c_DirArquivar.Refresh()
    ENDPROC

    *===========================================================================
    * ValidarFtpSenha - LostFocus para txt_4c_Ftpsenha. Reproduz o Valid
    * legado: codifica o valor digitado usando fDecriptografar() (funcao do
    * Framework legado que, apesar do nome, CODIFICA o valor para gravacao -
    * ver comentario em pafBO.prg linha ~902).
    *===========================================================================
    PROCEDURE ValidarFtpSenha(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cValor

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)

        IF !EMPTY(loc_cValor)
            loc_oPg2.txt_4c_Ftpsenha.Value = fDecriptografar(loc_cValor)
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarSenha2 - LostFocus para txt_4c_Senha2 (campo "Redigita"). Reproduz
    * o Valid legado: compara a senha ja codificada de txt_4c_Ftpsenha com a
    * codificacao do valor redigitado. Se nao conferir, pergunta se o usuario
    * deseja continuar com a senha em branco:
    *   - Confirmou (Sim): limpa AMBOS os campos (senha + redigita)
    *   - Recusou (Nao): limpa apenas o campo de redigita
    *===========================================================================
    PROCEDURE ValidarSenha2(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cSenhaCodificada, loc_cRedigitaCodificada

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !EMPTY(ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value))
            loc_cSenhaCodificada    = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)
            loc_cRedigitaCodificada = fDecriptografar(ALLTRIM(loc_oPg2.txt_4c_Senha2.Value))

            IF loc_cSenhaCodificada != loc_cRedigitaCodificada
                IF MsgConfirma("A Senha N" + CHR(227) + "o Confere!!! Deseja Continuar Com a Senha em Branco ?", ;
                        "Erro na Confirma" + CHR(231) + CHR(227) + "o da Senha...")
                    *-- Confirmou: limpa senha + redigita
                    loc_oPg2.txt_4c_Ftpsenha.Value = ""
                    loc_oPg2.txt_4c_Senha2.Value    = ""
                ELSE
                    *-- Recusou: limpa apenas a redigita
                    loc_oPg2.txt_4c_Senha2.Value = ""
                ENDIF
            ENDIF
        ENDIF
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
    * BOParaForm - Transfere dados do BusinessObject para os controles da Page2
    * Campos txt_4c_ProxTransp/txt_4c_ProxRecebe/txt_4c_Senha2 sao desvinculados
    * (sem coluna na tabela) - sempre limpos ao carregar um registro.
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Tipos.Value       = THIS.this_oBusinessObject.this_cTipos
            loc_oPg2.txt_4c_Emps.Value        = THIS.this_oBusinessObject.this_cEmps
            loc_oPg2.txt_4c_Descrs.Value      = THIS.this_oBusinessObject.this_cDescricao
            loc_oPg2.txt_4c_Extensao.Value    = THIS.this_oBusinessObject.this_cExtensao
            loc_oPg2.txt_4c_TransTipo.Value   = THIS.this_oBusinessObject.this_cTipoTransporte
            loc_oPg2.txt_4c_DirGeracao.Value  = THIS.this_oBusinessObject.this_cDirGeracao
            loc_oPg2.txt_4c_ClrArqOks.Value   = TRANSFORM(THIS.this_oBusinessObject.this_nTransporteOk)
            loc_oPg2.txt_4c_DirLeitura.Value  = THIS.this_oBusinessObject.this_cDirLeitura
            loc_oPg2.chk_4c_Seqnum.Value      = THIS.this_oBusinessObject.this_lNaoChecarSequencia
            loc_oPg2.txt_4c_DirRecepcao.Value = THIS.this_oBusinessObject.this_cDirRecepcao
            loc_oPg2.txt_4c_DirArquivar.Value = THIS.this_oBusinessObject.this_cDirArquivar
            loc_oPg2.txt_4c_Tpconexao.Value   = THIS.this_oBusinessObject.this_cTipoConexao
            loc_oPg2.chk_4c_Chklocdel.Value   = THIS.this_oBusinessObject.this_lLimpaDirEnvio
            loc_oPg2.chk_4c_Chkftpdel.Value   = THIS.this_oBusinessObject.this_lLimpaDirFtp
            loc_oPg2.txt_4c_Ftpend.Value      = THIS.this_oBusinessObject.this_cFtpEndereco
            loc_oPg2.txt_4c_Ftpusuario.Value  = THIS.this_oBusinessObject.this_cFtpUsuario
            loc_oPg2.txt_4c_Dirftpts.Value    = THIS.this_oBusinessObject.this_cDirFtpEnvio
            loc_oPg2.txt_4c_Ftpsenha.Value    = THIS.this_oBusinessObject.this_cFtpSenha
            loc_oPg2.txt_4c_Dirftpls.Value    = THIS.this_oBusinessObject.this_cDirFtpRecepcao

            *-- Campos desvinculados (nao gravados na tabela)
            loc_oPg2.txt_4c_ProxTransp.Value = ""
            loc_oPg2.txt_4c_ProxRecebe.Value = ""
            loc_oPg2.txt_4c_Senha2.Value     = ""

            *-- Sincroniza guardas anti-repeticao (Problema 45) com o valor carregado
            THIS.this_cUltimoTransTipo   = ALLTRIM(loc_oPg2.txt_4c_TransTipo.Value)
            THIS.this_cUltimoDirGeracao  = ALLTRIM(loc_oPg2.txt_4c_DirGeracao.Value)
            THIS.this_cUltimoDirLeitura  = ALLTRIM(loc_oPg2.txt_4c_DirLeitura.Value)
            THIS.this_cUltimoDirRecepcao = ALLTRIM(loc_oPg2.txt_4c_DirRecepcao.Value)
            THIS.this_cUltimoDirArquivar = ALLTRIM(loc_oPg2.txt_4c_DirArquivar.Value)
        CATCH TO loException
            MostrarErro("Erro ao carregar dados no formul" + CHR(225) + "rio:" + CHR(13) + ;
                loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTme.BOParaForm")
        ENDTRY
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os controles da Page2 (usado em Incluir)
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Tipos.Value       = ""
            loc_oPg2.txt_4c_Emps.Value        = ""
            loc_oPg2.txt_4c_Descrs.Value      = ""
            loc_oPg2.txt_4c_Extensao.Value    = ""
            loc_oPg2.txt_4c_TransTipo.Value   = ""
            loc_oPg2.txt_4c_DirGeracao.Value  = ""
            loc_oPg2.txt_4c_ClrArqOks.Value   = ""
            loc_oPg2.txt_4c_DirLeitura.Value  = ""
            loc_oPg2.chk_4c_Seqnum.Value      = 0
            loc_oPg2.txt_4c_DirRecepcao.Value = ""
            loc_oPg2.txt_4c_DirArquivar.Value = ""
            loc_oPg2.txt_4c_ProxTransp.Value  = ""
            loc_oPg2.txt_4c_ProxRecebe.Value  = ""
            loc_oPg2.txt_4c_Tpconexao.Value   = ""
            loc_oPg2.chk_4c_Chklocdel.Value   = 0
            loc_oPg2.chk_4c_Chkftpdel.Value   = 0
            loc_oPg2.txt_4c_Ftpend.Value      = ""
            loc_oPg2.txt_4c_Ftpusuario.Value  = ""
            loc_oPg2.txt_4c_Dirftpts.Value    = ""
            loc_oPg2.txt_4c_Ftpsenha.Value    = ""
            loc_oPg2.txt_4c_Dirftpls.Value    = ""
            loc_oPg2.txt_4c_Senha2.Value      = ""

            *-- Reseta guardas anti-repeticao (Problema 45)
            THIS.this_cUltimoTransTipo   = ""
            THIS.this_cUltimoDirGeracao  = ""
            THIS.this_cUltimoDirLeitura  = ""
            THIS.this_cUltimoDirRecepcao = ""
            THIS.this_cUltimoDirArquivar = ""
        CATCH TO loException
            MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, ;
                "FormTme.LimparCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita os controles da Page2
    * Tipos/Emps (chave) so ficam editaveis em modo INCLUIR
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lChaveHabilitar
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            *-- Chave (Tipos+Emps): editavel apenas em INCLUIR
            loc_lChaveHabilitar = (THIS.this_cModoAtual = "INCLUIR")
            loc_oPg2.txt_4c_Tipos.Enabled = loc_lChaveHabilitar
            loc_oPg2.txt_4c_Emps.Enabled  = loc_lChaveHabilitar

            *-- Demais campos
            loc_oPg2.txt_4c_Descrs.Enabled      = par_lHabilitar
            loc_oPg2.txt_4c_Extensao.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_TransTipo.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_DirGeracao.Enabled  = par_lHabilitar
            loc_oPg2.txt_4c_ClrArqOks.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_DirLeitura.Enabled  = par_lHabilitar
            loc_oPg2.chk_4c_Seqnum.Enabled      = par_lHabilitar
            loc_oPg2.txt_4c_DirRecepcao.Enabled = par_lHabilitar
            loc_oPg2.txt_4c_DirArquivar.Enabled = par_lHabilitar
            loc_oPg2.txt_4c_ProxTransp.Enabled  = par_lHabilitar
            loc_oPg2.txt_4c_ProxRecebe.Enabled  = par_lHabilitar
            loc_oPg2.txt_4c_Tpconexao.Enabled   = par_lHabilitar
            loc_oPg2.chk_4c_Chklocdel.Enabled   = par_lHabilitar
            loc_oPg2.chk_4c_Chkftpdel.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_Ftpend.Enabled      = par_lHabilitar
            loc_oPg2.txt_4c_Ftpusuario.Enabled  = par_lHabilitar
            loc_oPg2.txt_4c_Dirftpts.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_Ftpsenha.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_Dirftpls.Enabled    = par_lHabilitar
            loc_oPg2.txt_4c_Senha2.Enabled      = par_lHabilitar
        CATCH TO loException
            MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
                "FormTme.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar conforme this_cModoAtual
    * PUBLIC: chamado por TesteAutomatico.prg diretamente de fora da classe
    * (CLAUDE.md regra #3 - BINDEVENT/chamada externa exige metodo PUBLIC)
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoesAcao
        loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao

        TRY
            loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loException
            MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
                "FormTme.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara Page2 para inclusao de novo transporte
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao incluir transporte:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTme.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Abre o transporte selecionado em modo somente leitura
    * PUBLIC: BINDEVENT (Click do botao + DblClick do grid) exige metodo PUBLIC
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cTipoEmps, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Visualizar")
        ELSE
            SELECT cursor_4c_Dados
            loc_cTipoEmps = ALLTRIM(cursor_4c_Dados.tipoemps)

            TRY
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipoEmps)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Visualizar")
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao visualizar transporte:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), ;
                    "FormTme.BtnVisualizarClick")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre o transporte selecionado para edicao
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cTipoEmps, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Alterar")
        ELSE
            SELECT cursor_4c_Dados
            loc_cTipoEmps = ALLTRIM(cursor_4c_Dados.tipoemps)

            TRY
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipoEmps)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Alterar")
                ENDIF
            CATCH TO loException
                MostrarErro("Erro ao alterar transporte:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), ;
                    "FormTme.BtnAlterarClick")
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o transporte selecionado apos confirmacao
    * (TmeBO.ExecutarExclusao ja remove SigCdMei/SigCdMet antes de SigCdMe)
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cTipoEmps, loc_lResultado
        loc_lResultado = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "Excluir")
        ELSE
            SELECT cursor_4c_Dados
            loc_cTipoEmps = ALLTRIM(cursor_4c_Dados.tipoemps)

            IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cTipoEmps)
                MsgAviso("Registro n" + CHR(227) + "o encontrado!", "Excluir")
            ELSE
                IF MsgConfirmaExclusao()
                    TRY
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgExcluidoSucesso()
                            THIS.CarregarLista()
                            loc_lResultado = .T.
                        ENDIF
                    CATCH TO loException
                        MostrarErro("Erro ao excluir transporte:" + CHR(13) + loException.Message + CHR(13) + ;
                            "Linha: " + TRANSFORM(loException.LineNo), ;
                            "FormTme.BtnExcluirClick")
                    ENDTRY
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Localiza um transporte na lista via FormBuscaAuxiliar
    * (SigCdMe, chave "tipos") e posiciona o grid no registro selecionado
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cTipoEmps
        loc_cTipoEmps = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMe", "cursor_4c_BuscaTme", "tipos", "", ;
                "Buscar Transporte")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("tipos",  "", "Transporte")
                loc_oBusca.mAddColuna("emps",   "", "Emp")
                loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTme")
                    SELECT cursor_4c_BuscaTme
                    loc_cTipoEmps = ALLTRIM(cursor_4c_BuscaTme.tipoemps)
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTme")
                USE IN cursor_4c_BuscaTme
            ENDIF

            IF !EMPTY(loc_cTipoEmps) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(tipoemps) == loc_cTipoEmps
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormTme.BtnBuscarClick")
            IF USED("cursor_4c_BuscaTme")
                USE IN cursor_4c_BuscaTme
            ENDIF
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PADRAO CANONICO CLAUDE.md #10: NAO chamar Release() apos - FormBase cuida
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere dados da Page2 para o BusinessObject antes de
    * salvar. this_cTipoEmps (PK) eh calculado dentro de TmeBO.ValidarDados()
    * a partir de this_cTipos + this_cEmps - nao precisa ser setado aqui.
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cTipos              = UPPER(ALLTRIM(loc_oPg2.txt_4c_Tipos.Value))
        THIS.this_oBusinessObject.this_cEmps               = UPPER(ALLTRIM(loc_oPg2.txt_4c_Emps.Value))
        THIS.this_oBusinessObject.this_cDescricao          = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
        THIS.this_oBusinessObject.this_cExtensao           = UPPER(ALLTRIM(loc_oPg2.txt_4c_Extensao.Value))
        THIS.this_oBusinessObject.this_cTipoTransporte     = UPPER(ALLTRIM(loc_oPg2.txt_4c_TransTipo.Value))
        THIS.this_oBusinessObject.this_cDirGeracao         = ALLTRIM(loc_oPg2.txt_4c_DirGeracao.Value)
        THIS.this_oBusinessObject.this_nTransporteOk       = loc_oPg2.txt_4c_ClrArqOks.Value
        THIS.this_oBusinessObject.this_cDirLeitura         = ALLTRIM(loc_oPg2.txt_4c_DirLeitura.Value)
        THIS.this_oBusinessObject.this_lNaoChecarSequencia = loc_oPg2.chk_4c_Seqnum.Value
        THIS.this_oBusinessObject.this_cDirRecepcao        = ALLTRIM(loc_oPg2.txt_4c_DirRecepcao.Value)
        THIS.this_oBusinessObject.this_cDirArquivar        = ALLTRIM(loc_oPg2.txt_4c_DirArquivar.Value)
        THIS.this_oBusinessObject.this_cTipoConexao        = UPPER(ALLTRIM(loc_oPg2.txt_4c_Tpconexao.Value))
        THIS.this_oBusinessObject.this_lLimpaDirEnvio      = loc_oPg2.chk_4c_Chklocdel.Value
        THIS.this_oBusinessObject.this_lLimpaDirFtp        = loc_oPg2.chk_4c_Chkftpdel.Value
        THIS.this_oBusinessObject.this_cFtpEndereco        = ALLTRIM(loc_oPg2.txt_4c_Ftpend.Value)
        THIS.this_oBusinessObject.this_cFtpUsuario         = ALLTRIM(loc_oPg2.txt_4c_Ftpusuario.Value)
        THIS.this_oBusinessObject.this_cDirFtpEnvio        = ALLTRIM(loc_oPg2.txt_4c_Dirftpts.Value)
        THIS.this_oBusinessObject.this_cFtpSenha           = ALLTRIM(loc_oPg2.txt_4c_Ftpsenha.Value)
        THIS.this_oBusinessObject.this_cDirFtpRecepcao     = ALLTRIM(loc_oPg2.txt_4c_Dirftpls.Value)
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva o transporte (INCLUIR/ALTERAR) via TmeBO.Salvar()
    * Validacoes de campo obrigatorio ficam em TmeBO.ValidarDados() (Codigo do
    * Transporte / Empresa - espelha o Valid legado do CmdBotoes.Click).
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN loc_lResultado
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgSucesso("Transporte salvo com sucesso!")
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar transporte:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormTme.BtnSalvarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela a edicao e volta para a lista (recarregada)
    * PUBLIC: BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
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

        IF USED("cursor_4c_Itens")
            USE IN cursor_4c_Itens
        ENDIF

        IF USED("cursor_4c_Titulos")
            USE IN cursor_4c_Titulos
        ENDIF

        IF USED("cursor_4c_Grade")
            USE IN cursor_4c_Grade
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE
