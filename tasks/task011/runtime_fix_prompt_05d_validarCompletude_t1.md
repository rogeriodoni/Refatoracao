# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormProduto.prg] Marcador: *-- Placeholder

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg):
*==============================================================================
* FormProduto.prg - Formulario de Cadastro de Produtos
* Data: 2026-04-11
* Tabela principal: SigPrFtp | PK: pkchaves
* Tabela vinculada: SigCdPro (leitura/exibicao)
* Legado: SIGCDPRO.SCX (frmcadastro, 7 abas internas)
*==============================================================================

DEFINE CLASS FormProduto AS FormBase

    *-- Propriedades visuais (copiadas do original SIGCDPRO)
    Height       = 600
    Width        = 1000
    Caption      = "Cadastro de Produtos"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades do formulario
    this_oBusinessObject  = .NULL.
    this_cMensagemErro    = ""    && OBRIGATORIO - nao herdado de FormBase

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar instancia do Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")

            IF ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object ProdutoBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Se falhar ao carregar, nao impede abertura
                    ENDIF
                ENDIF

                THIS.AjustarBotoesPorModo()
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal
    * Legado: Pagina Top=-29 (oculta abas), Width=1003, Height=631
    * Compensacao +29 aplicada em controles das Pages
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 631
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            *-- Page1 - Lista
            .Page1.Caption  = "Lista"
            .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            *-- Page2 - Dados
            .Page2.Caption  = "Dados"
            .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Top original = -1 dos grupos -> compensado para 28 (+29)
    * Grade: Top=173, Left=38, Width=922, Height=409 (7 colunas)
    * cntFiltros: Top=82, Left=0, Width=383, Height=87
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrade
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Container de cabecalho (cntSombra: Top=1+29=30, Width=1000, Height=80)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = 1000
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label titulo no cabecalho
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Produtos"
            .Top       = 20
            .Left      = 20
            .Width     = 400
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Container de filtros (cntFiltros: Top=82+29=111, Left=0, W=383, H=87)
        loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
        WITH loc_oPagina.cnt_4c_Filtros
            .Top         = 111
            .Left        = 0
            .Width       = 383
            .Height      = 87
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label Grupo de Produto
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblGrupo
            .Caption   = "\<Grupo de Produto :"
            .Top       = 18
            .Left      = 21
            .Width     = 94
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox Cgru (getCgru: Top=14, Left=116, W=31, H=23)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FilCgru", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FilCgru
            .Value    = ""
            .Top      = 14
            .Left     = 116
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_FilCgru, "KeyPress", THIS, "TxtFilCgruKeyPress")

        *-- TextBox Dgru (getDgru: Top=14, Left=149, W=156, H=23)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FilDgru", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FilDgru
            .Value    = ""
            .Top      = 14
            .Left     = 149
            .Width    = 156
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        *-- Label Ultima Alteracao
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData1", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData1
            .Caption   = CHR(218) + "ltima Altera" + CHR(231) + CHR(227) + "o :"
            .Top       = 43
            .Left      = 28
            .Width     = 87
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox DtIni (getDtIni: Top=39, Left=116, H=23)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FilDtIni", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FilDtIni
            .Value       = {}
            .Top         = 39
            .Left        = 116
            .Width       = 85
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Format      = "D"
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        *-- Label ate
        loc_oPagina.cnt_4c_Filtros.AddObject("lbl_4c_LblData2", "Label")
        WITH loc_oPagina.cnt_4c_Filtros.lbl_4c_LblData2
            .Caption   = "at" + CHR(233)
            .Top       = 43
            .Left      = 202
            .Width     = 18
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox DtFim (getDtFim: Top=39, Left=225, H=23)
        loc_oPagina.cnt_4c_Filtros.AddObject("txt_4c_FilDtFim", "TextBox")
        WITH loc_oPagina.cnt_4c_Filtros.txt_4c_FilDtFim
            .Value       = {}
            .Top         = 39
            .Left        = 225
            .Width       = 85
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Format      = "D"
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH

        *-- OptionGroup Situacao (optFilSituas: Top=19, Left=303, W=78, H=46, ButtonCount=3)
        loc_oPagina.cnt_4c_Filtros.AddObject("obj_4c_OptFilSituas", "OptionGroup")
        WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas
            .ButtonCount = 3
            .Top         = 19
            .Left        = 303
            .Width       = 78
            .Height      = 46
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas.Buttons(1)
            .Caption  = "Todos"
            .Top      = 2
            .Left     = 2
            .AutoSize = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Value    = 1
            .Visible  = .T.
        ENDWITH
        WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas.Buttons(2)
            .Caption  = "Ativo"
            .Top      = 16
            .Left     = 2
            .AutoSize = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        WITH loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas.Buttons(3)
            .Caption  = "Inativo"
            .Top      = 30
            .Left     = 2
            .AutoSize = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Filtros.obj_4c_OptFilSituas, "InteractiveChange", THIS, "FiltroSituacaoChange")

        *-- Container de botoes CRUD (Grupo_op: Left=542, Top=-1+29=28)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 400
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Inserir: Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Consultar: Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 155
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 230
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Procurar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Procurar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar
            .Caption         = "Procurar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 305
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar, "Click", THIS, "BtnProcurarClick")

        *-- Container Sair (Grupo_Saida: Left=917, Top=-1+29=28)
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 80
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Sair (Sair: Left=5)
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Sair", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Sair
            .Caption         = "Sair"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Sair, "Click", THIS, "BtnSairClick")

        *-- Grade principal (Grade: Left=38, Top=173+29=202, W=922, H=409, 7 colunas)
        *-- IMPORTANTE: RecordMark=.F., DeleteMark=.F.
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrade = loc_oPagina.grd_4c_Dados
        WITH loc_oGrade
            .Top           = 202
            .Left          = 38
            .Width         = 922
            .Height        = 409
            .FontName      = "Arial"
            .FontSize      = 8
            .RecordMark    = .F.
            .DeleteMark    = .F.
            .GridLines     = 3
            .ReadOnly      = .T.
            .Themes        = .F.
            .ColumnCount   = 7
            .Visible       = .T.
        ENDWITH

        *-- Configurar colunas APOS ColumnCount (cabecalhos serao re-aplicados pos RecordSource)
        WITH loc_oGrade.Column1
            .Width     = 110
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrade.Column2
            .Width     = 408
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrade.Column3
            .Width     = 40
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrade.Column4
            .Width     = 70
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrade.Column5
            .Width     = 150
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrade.Column6
            .Width     = 100
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrade.Column7
            .Width     = 16
            .Alignment = 3
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
            .ReadOnly  = .T.
            *-- Configurar checkbox AQUI (antes de RecordSource): AddObject, Caption, CurrentControl
            .AddObject("Check1", "CheckBox")
            .Check1.Caption = ""
            .CurrentControl = "Check1"
        ENDWITH

        *-- Label contagem de produtos (lblProdutos: Top=584, compensado 584+29=613, Left=38)
        loc_oPagina.AddObject("lbl_4c_Produtos", "Label")
        WITH loc_oPagina.lbl_4c_Produtos
            .Caption   = "Produtos Selecionados : 0"
            .Top       = 613
            .Left      = 38
            .Width     = 160
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Estrutura: botoes Salvar/Cancelar + PageFrame interno (7 abas)
    * Grupo_Salva: Left=842, Top=5+29=34, H=85
    * pgframeDados: Top=-54+29=-25, Left=-1, W=1003, H=656, 7 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oPgf
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Container de botoes Salvar/Cancelar (Grupo_Salva)
        loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oPagina.cnt_4c_BotoesDados
            .Top         = 34
            .Left        = 842
            .Width       = 155
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar (Salva: Left=5)
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 5
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (Cancelar: Left=80)
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 80
            .Top             = 5
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- PageFrame interno (pgframeDados: Top=-54+29=-25, Left=-1, W=1003, H=656, 7 pags)
        loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
        loc_oPgf = loc_oPagina.pgf_4c_Dados
        WITH loc_oPgf
            .Top       = -25
            .Left      = -1
            .Width     = 1003
            .Height    = 656
            .PageCount = 7
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        *-- Configurar abas do PageFrame interno
        WITH loc_oPgf
            .Page1.Caption = "Dados"
            .Page2.Caption = "Composi" + CHR(231) + CHR(227) + "o"
            .Page3.Caption = "Dados Fiscais"
            .Page4.Caption = "Fases P."
            .Page5.Caption = "Cons. P."
            .Page6.Caption = "Custo"
            .Page7.Caption = "Designer"
        ENDWITH

        *-- Configurar pgDados (Page1 do PageFrame interno)
        THIS.ConfigurarPaginaDadosPrincipal(loc_oPgf.Page1)

        *-- Configurar pgComposicao (Page2 do PageFrame interno)
        THIS.ConfigurarPgpgComposicao(loc_oPgf.Page2)

        *-- Configurar pgCusto (Page6 do PageFrame interno)
        THIS.ConfigurarPgpgCusto(loc_oPgf.Page6)

        *-- Configurar PgDadosFaseP (Page4 do PageFrame interno)
        THIS.ConfigurarPgPgDadosFaseP(loc_oPgf.Page4)

        *-- Configurar PgDadosConsP (Page5 do PageFrame interno)
        THIS.ConfigurarPgPgDadosConsP(loc_oPgf.Page5)

        *-- Configurar pgDadosFiscais (Page3 do PageFrame interno)
        THIS.ConfigurarPgpgDadosFiscais(loc_oPgf.Page3)

        *-- Configurar pgDesigner (Page7 do PageFrame interno)
        THIS.ConfigurarPgpgDesigner(loc_oPgf.Page7)

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDadosPrincipal - Aba "Dados" do PageFrame interno (pgDados)
    * Fase 5: Campos principais parte 1 (50%)
    * Posicoes = valores ORIGINAIS do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
    * Colunas SigCdPro: cpros, dpros, dpro2s, cgrus, cods, cbars, clins, ccols, ifors, reffs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDadosPrincipal(par_oPage)
        LOCAL loc_oPg
        loc_oPg = par_oPage

        *-- ===================================================================
        *-- LINHA 1 (top=130): getCpro + getDpro
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblProduto", "Label")
        WITH loc_oPg.lbl_4c_LblProduto
            .Caption   = "Produto :"
            .Top       = 134
            .Left      = 58
            .Width     = 53
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getCpro (cpros: Top=130, Left=113, W=108, H=23)
        loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oPg.txt_4c_Cpros
            .Value    = ""
            .Top      = 130
            .Left     = 113
            .Width    = 108
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cpros, "KeyPress", THIS, "TxtCprosKeyPress")

        *-- TextBox getDpro (dpros: Top=130, Left=222, W=290, H=23 - READ ONLY)
        loc_oPg.AddObject("txt_4c_Dpros", "TextBox")
        WITH loc_oPg.txt_4c_Dpros
            .Value     = ""
            .Top       = 130
            .Left      = 222
            .Width     = 290
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 2 (top=154): getDPro2s | getCbar (right, top=155)
        *-- ===================================================================

        *-- TextBox getDPro2s (dpro2s: Top=154, Left=113, W=399, H=23 - segunda descricao)
        loc_oPg.AddObject("txt_4c_DPro2s", "TextBox")
        WITH loc_oPg.txt_4c_DPro2s
            .Value    = ""
            .Top      = 154
            .Left     = 113
            .Width    = 399
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label Barra
        loc_oPg.AddObject("lbl_4c_LblCbar", "Label")
        WITH loc_oPg.lbl_4c_LblCbar
            .Caption   = "Barra :"
            .Top       = 159
            .Left      = 575
            .Width     = 48
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getCbar (cbars: Top=155, Left=626, W=108, H=21)
        loc_oPg.AddObject("txt_4c_Cbar", "TextBox")
        WITH loc_oPg.txt_4c_Cbar
            .Value    = ""
            .Top      = 155
            .Left     = 626
            .Width    = 108
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 3 (top=178): getCgru + getDgru
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPg.lbl_4c_LblGrupo
            .Caption   = "Grupo :"
            .Top       = 182
            .Left      = 73
            .Width     = 38
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getCgru (cgrus: Top=178, Left=113, W=31, H=23)
        loc_oPg.AddObject("txt_4c_Cgrus", "TextBox")
        WITH loc_oPg.txt_4c_Cgrus
            .Value    = ""
            .Top      = 178
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "TxtCgrusKeyPress")

        *-- TextBox getDgru display (dgrus: Top=178, Left=145, W=171, H=23 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DgruDisplay", "TextBox")
        WITH loc_oPg.txt_4c_DgruDisplay
            .Value     = ""
            .Top       = 178
            .Left      = 145
            .Width     = 171
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 4 (top=202): GetCSGru + GetDsGru
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblSubgrupo", "Label")
        WITH loc_oPg.lbl_4c_LblSubgrupo
            .Caption   = "Subgrupo :"
            .Top       = 206
            .Left      = 56
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox GetCSGru (cods: Top=202, Left=113, W=52, H=23)
        loc_oPg.AddObject("txt_4c_Cods", "TextBox")
        WITH loc_oPg.txt_4c_Cods
            .Value    = ""
            .Top      = 202
            .Left     = 113
            .Width    = 52
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- TextBox GetDsGru display (desc subgrupo: Top=202, Left=166, W=150, H=23 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DcodsDisplay", "TextBox")
        WITH loc_oPg.txt_4c_DcodsDisplay
            .Value     = ""
            .Top       = 202
            .Left      = 166
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 5 (top=226): GetLin + GetDLin (Linha / SigCdLin)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblLin", "Label")
        WITH loc_oPg.lbl_4c_LblLin
            .Caption   = "Linha :"
            .Top       = 230
            .Left      = 71
            .Width     = 40
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox GetLin (clins: Top=226, Left=113, W=80, H=23)
        loc_oPg.AddObject("txt_4c_Lin", "TextBox")
        WITH loc_oPg.txt_4c_Lin
            .Value    = ""
            .Top      = 226
            .Left     = 113
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Lin, "KeyPress", THIS, "TxtLinKeyPress")

        *-- TextBox GetDLin display (dlins: Top=226, Left=194, W=318, H=23 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DLinDisplay", "TextBox")
        WITH loc_oPg.txt_4c_DLinDisplay
            .Value     = ""
            .Top       = 226
            .Left      = 194
            .Width     = 318
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 6 (top=250): GetCol + GetDCol (Grupo de Venda / SigCdCol)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblCol", "Label")
        WITH loc_oPg.lbl_4c_LblCol
            .Caption   = "Grupo Venda :"
            .Top       = 254
            .Left      = 42
            .Width     = 69
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox GetCol (ccols: Top=250, Left=113, W=80, H=23)
        loc_oPg.AddObject("txt_4c_Col", "TextBox")
        WITH loc_oPg.txt_4c_Col
            .Value    = ""
            .Top      = 250
            .Left     = 113
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Col, "KeyPress", THIS, "TxtColKeyPress")

        *-- TextBox GetDCol display (dcols: Top=250, Left=194, W=318, H=23 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DColDisplay", "TextBox")
        WITH loc_oPg.txt_4c_DColDisplay
            .Value     = ""
            .Top       = 250
            .Left      = 194
            .Width     = 318
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 7 (top=274): getIfor + getDfor (Fornecedor)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblIfor", "Label")
        WITH loc_oPg.lbl_4c_LblIfor
            .Caption   = "Fornecedor :"
            .Top       = 278
            .Left      = 44
            .Width     = 67
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getIfor (ifors: Top=274, Left=113, W=80, H=23)
        loc_oPg.AddObject("txt_4c_Ifor", "TextBox")
        WITH loc_oPg.txt_4c_Ifor
            .Value    = ""
            .Top      = 274
            .Left     = 113
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Ifor, "KeyPress", THIS, "TxtIforKeyPress")

        *-- TextBox getDfor display (nome fornecedor: Top=274, Left=194, W=318, H=23 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DforDisplay", "TextBox")
        WITH loc_oPg.txt_4c_DforDisplay
            .Value     = ""
            .Top       = 274
            .Left      = 194
            .Width     = 318
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 8 (top=298): getRefs (Referencia do Fornecedor)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblRefs", "Label")
        WITH loc_oPg.lbl_4c_LblRefs
            .Caption   = "Ref. Fornecedor :"
            .Top       = 302
            .Left      = 20
            .Width     = 91
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getRefs (reffs: Top=298, Left=113, W=152, H=23)
        loc_oPg.AddObject("txt_4c_Refs", "TextBox")
        WITH loc_oPg.txt_4c_Refs
            .Value    = ""
            .Top      = 298
            .Left     = 113
            .Width    = 152
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 8b (top=298, right side): getCor + getTam
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblCor", "Label")
        WITH loc_oPg.lbl_4c_LblCor
            .Caption   = "Cor :"
            .Top       = 302
            .Left      = 345
            .Width     = 28
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getCor (codcors: Top=298, Left=401, W=38, H=23)
        loc_oPg.AddObject("txt_4c_Cor", "TextBox")
        WITH loc_oPg.txt_4c_Cor
            .Value    = ""
            .Top      = 298
            .Left     = 401
            .Width    = 38
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cor, "KeyPress", THIS, "TxtCorKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Cor, "DblClick", THIS, "AbrirLookupCor")

        loc_oPg.AddObject("lbl_4c_LblTam", "Label")
        WITH loc_oPg.lbl_4c_LblTam
            .Caption   = "Tam :"
            .Top       = 302
            .Left      = 445
            .Width     = 27
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getTam (codtams: Top=298, Left=474, W=38, H=23)
        loc_oPg.AddObject("txt_4c_Tam", "TextBox")
        WITH loc_oPg.txt_4c_Tam
            .Value    = ""
            .Top      = 298
            .Left     = 474
            .Width    = 38
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Tam, "KeyPress", THIS, "TxtTamKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Tam, "DblClick", THIS, "AbrirLookupTam")

        *-- RIGHT SIDE top area: getDtSituas (T:132, L:878)
        loc_oPg.AddObject("lbl_4c_LblDtSitua", "Label")
        WITH loc_oPg.lbl_4c_LblDtSitua
            .Caption   = "Dt.Situa" + CHR(231) + CHR(227) + "o :"
            .Top       = 120
            .Left      = 785
            .Width     = 91
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getDtSituas (dtsituas: Top=132, Left=878, W=80, H=21)
        loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
        WITH loc_oPg.txt_4c_DtSituas
            .Value     = {}
            .Top       = 132
            .Left      = 878
            .Width     = 80
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "D"
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 9 (top=322): getCodFinP + getDesFinP + getPesoBs
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblFinP", "Label")
        WITH loc_oPg.lbl_4c_LblFinP
            .Caption   = "Ficha :"
            .Top       = 326
            .Left      = 71
            .Width     = 40
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getCodFinP (codfinp: Top=322, Left=113, W=31, H=23)
        loc_oPg.AddObject("txt_4c_CodFinP", "TextBox")
        WITH loc_oPg.txt_4c_CodFinP
            .Value    = ""
            .Top      = 322
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CodFinP, "KeyPress", THIS, "TxtCodFinPKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CodFinP, "DblClick", THIS, "AbrirLookupFinP")

        *-- TextBox getDesFinP (desc ficha: Top=322, Left=145, W=150, H=23 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DesFinP", "TextBox")
        WITH loc_oPg.txt_4c_DesFinP
            .Value     = ""
            .Top       = 322
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblPesoB", "Label")
        WITH loc_oPg.lbl_4c_LblPesoB
            .Caption   = "Peso Base :"
            .Top       = 326
            .Left      = 316
            .Width     = 64
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getPesoBs (pesobs: Top=322, Left=401, W=111, H=23)
        loc_oPg.AddObject("txt_4c_PesoB", "TextBox")
        WITH loc_oPg.txt_4c_PesoB
            .Value    = 0.0
            .Top      = 322
            .Left     = 401
            .Width    = 111
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 10 (top=346): get_codacb + get_Dacb + getPmedio
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblAcab", "Label")
        WITH loc_oPg.lbl_4c_LblAcab
            .Caption   = "Acabamento :"
            .Top       = 350
            .Left      = 33
            .Width     = 78
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_codacb (codacbs: Top=346, Left=113, W=31, H=23)
        loc_oPg.AddObject("txt_4c_CodAcb", "TextBox")
        WITH loc_oPg.txt_4c_CodAcb
            .Value    = ""
            .Top      = 346
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CodAcb, "KeyPress", THIS, "TxtCodAcbKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CodAcb, "DblClick", THIS, "AbrirLookupAcb")

        *-- TextBox get_Dacb (desc acabamento: Top=346, Left=145, W=150, H=23 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DacbDisplay", "TextBox")
        WITH loc_oPg.txt_4c_DacbDisplay
            .Value     = ""
            .Top       = 346
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblPmedio", "Label")
        WITH loc_oPg.lbl_4c_LblPmedio
            .Caption   = "Pr." + CHR(233) + "dio :"
            .Top       = 350
            .Left      = 316
            .Width     = 64
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getPmedio (pcuss: Top=346, Left=401, W=111, H=23 - READ ONLY custo)
        loc_oPg.AddObject("txt_4c_Pmedio", "TextBox")
        WITH loc_oPg.txt_4c_Pmedio
            .Value     = 0.0
            .Top       = 346
            .Left      = 401
            .Width     = 111
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 11 (top=370): Get_Class + Get_DClass + Get_Local
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblClass", "Label")
        WITH loc_oPg.lbl_4c_LblClass
            .Caption   = "Classif. :"
            .Top       = 374
            .Left      = 55
            .Width     = 56
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox Get_Class (cclass: Top=370, Left=113, W=31, H=23)
        loc_oPg.AddObject("txt_4c_Class", "TextBox")
        WITH loc_oPg.txt_4c_Class
            .Value    = ""
            .Top      = 370
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Class, "KeyPress", THIS, "TxtClassKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Class, "DblClick", THIS, "AbrirLookupClass")

        *-- TextBox Get_DClass (desc classe: Top=370, Left=145, W=150, H=23 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DClassDisplay", "TextBox")
        WITH loc_oPg.txt_4c_DClassDisplay
            .Value     = ""
            .Top       = 370
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblLocal", "Label")
        WITH loc_oPg.lbl_4c_LblLocal
            .Caption   = "Local :"
            .Top       = 374
            .Left      = 346
            .Width     = 36
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox Get_Local (locals: Top=370, Left=401, W=111, H=23)
        loc_oPg.AddObject("txt_4c_Local", "TextBox")
        WITH loc_oPg.txt_4c_Local
            .Value    = ""
            .Top      = 370
            .Left     = 401
            .Width    = 111
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Local, "KeyPress", THIS, "TxtLocalKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Local, "DblClick", THIS, "AbrirLookupLocal")

        *-- RIGHT SIDE: Custo Total + Moeda Custo (top=362/375)
        loc_oPg.AddObject("lbl_4c_LblCtotal", "Label")
        WITH loc_oPg.lbl_4c_LblCtotal
            .Caption   = "Custo :"
            .Top       = 362
            .Left      = 572
            .Width     = 53
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getCtotal (custofs: Top=375, Left=626, W=127, H=21 - READ ONLY)
        loc_oPg.AddObject("txt_4c_Ctotal", "TextBox")
        WITH loc_oPg.txt_4c_Ctotal
            .Value     = 0.0
            .Top       = 375
            .Left      = 626
            .Width     = 127
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox getMctotal (moecs: Top=375, Left=754, W=31, H=21)
        loc_oPg.AddObject("txt_4c_Mctotal", "TextBox")
        WITH loc_oPg.txt_4c_Mctotal
            .Value    = ""
            .Top      = 375
            .Left     = 754
            .Width    = 31
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Mctotal, "KeyPress", THIS, "TxtMctotalKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Mctotal, "DblClick", THIS, "AbrirLookupMctotal")

        *-- ===================================================================
        *-- LINHA 12 (top=394): Get_Cuni + Get_Duni + Get_cunip + get_dunip
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblCuni", "Label")
        WITH loc_oPg.lbl_4c_LblCuni
            .Caption   = "Unidade :"
            .Top       = 398
            .Left      = 55
            .Width     = 57
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox Get_Cuni (cunis: Top=394, Left=113, W=31, H=23)
        loc_oPg.AddObject("txt_4c_Cuni", "TextBox")
        WITH loc_oPg.txt_4c_Cuni
            .Value    = ""
            .Top      = 394
            .Left     = 113
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cuni, "KeyPress", THIS, "TxtCuniKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Cuni, "DblClick", THIS, "AbrirLookupUni")

        *-- TextBox Get_Duni (desc unidade: Top=394, Left=145, W=150, H=23 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DuniDisplay", "TextBox")
        WITH loc_oPg.txt_4c_DuniDisplay
            .Value     = ""
            .Top       = 394
            .Left      = 145
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblCunip", "Label")
        WITH loc_oPg.lbl_4c_LblCunip
            .Caption   = "Uni.Ped. :"
            .Top       = 398
            .Left      = 278
            .Width     = 51
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox Get_cunip (cunips: Top=394, Left=330, W=31, H=23)
        loc_oPg.AddObject("txt_4c_Cunip", "TextBox")
        WITH loc_oPg.txt_4c_Cunip
            .Value    = ""
            .Top      = 394
            .Left     = 330
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cunip, "KeyPress", THIS, "TxtCunipKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Cunip, "DblClick", THIS, "AbrirLookupUniP")

        *-- TextBox get_dunip (desc uni.pedido: Top=394, Left=362, W=150, H=23 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DunipDisplay", "TextBox")
        WITH loc_oPg.txt_4c_DunipDisplay
            .Value     = ""
            .Top       = 394
            .Left      = 362
            .Width     = 150
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- RIGHT SIDE: P.Venda + Moeda Pvenda + Datas Inc/Alt (top=384/397)
        loc_oPg.AddObject("lbl_4c_LblPvenda", "Label")
        WITH loc_oPg.lbl_4c_LblPvenda
            .Caption   = "P.Venda :"
            .Top       = 384
            .Left      = 572
            .Width     = 53
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getPvenda (pvens: Top=397, Left=626, W=127, H=21)
        loc_oPg.AddObject("txt_4c_Pvenda", "TextBox")
        WITH loc_oPg.txt_4c_Pvenda
            .Value    = 0.0
            .Top      = 397
            .Left     = 626
            .Width    = 127
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- TextBox getMpvenda (moepvs: Top=397, Left=754, W=31, H=21)
        loc_oPg.AddObject("txt_4c_Mpvenda", "TextBox")
        WITH loc_oPg.txt_4c_Mpvenda
            .Value    = ""
            .Top      = 397
            .Left     = 754
            .Width    = 31
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Mpvenda, "KeyPress", THIS, "TxtMpvendaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Mpvenda, "DblClick", THIS, "AbrirLookupMpvenda")

        loc_oPg.AddObject("lbl_4c_LblInc", "Label")
        WITH loc_oPg.lbl_4c_LblInc
            .Caption   = "Inc."
            .Top       = 384
            .Left      = 793
            .Width     = 39
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getDtIncs (dtincs: Top=397, Left=833, W=79, H=21 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DtIncs", "TextBox")
        WITH loc_oPg.txt_4c_DtIncs
            .Value     = {}
            .Top       = 397
            .Left      = 833
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "D"
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("lbl_4c_LblAlt", "Label")
        WITH loc_oPg.lbl_4c_LblAlt
            .Caption   = "Alt."
            .Top       = 384
            .Left      = 876
            .Width     = 36
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getDataAlts (dtalts: Top=397, Left=914, W=79, H=21 - READ ONLY)
        loc_oPg.AddObject("txt_4c_DataAlts", "TextBox")
        WITH loc_oPg.txt_4c_DataAlts
            .Value     = {}
            .Top       = 397
            .Left      = 914
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Format    = "D"
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 13 (top=418/419): GetCodIdent + F.Venda + Mfvenda + Usuarios
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblCodIdent", "Label")
        WITH loc_oPg.lbl_4c_LblCodIdent
            .Caption   = "C" + CHR(243) + "d.Ident. :"
            .Top       = 422
            .Left      = 40
            .Width     = 71
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox GetCodIdent (codident: Top=418, Left=113, W=182, H=23)
        loc_oPg.AddObject("txt_4c_CodIdent", "TextBox")
        WITH loc_oPg.txt_4c_CodIdent
            .Value    = ""
            .Top      = 418
            .Left     = 113
            .Width    = 182
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- RIGHT SIDE: F.Venda + Moeda Fvenda + Usuarios (top=406/419)
        loc_oPg.AddObject("lbl_4c_LblFvenda", "Label")
        WITH loc_oPg.lbl_4c_LblFvenda
            .Caption   = "F.Venda :"
            .Top       = 406
            .Left      = 572
            .Width     = 53
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getFvenda (fvendas: Top=419, Left=626, W=127, H=21)
        loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
        WITH loc_oPg.txt_4c_Fvenda
            .Value    = 0.0
            .Top      = 419
            .Left     = 626
            .Width    = 127
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- TextBox getMfvenda (moevs: Top=419, Left=754, W=31, H=21)
        loc_oPg.AddObject("txt_4c_Mfvenda", "TextBox")
        WITH loc_oPg.txt_4c_Mfvenda
            .Value    = ""
            .Top      = 419
            .Left     = 754
            .Width    = 31
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Mfvenda, "KeyPress", THIS, "TxtMfvendaKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Mfvenda, "DblClick", THIS, "AbrirLookupMfvenda")

        *-- TextBox Get_Usuario (usuincs: Top=419, Left=833, W=79, H=21 - READ ONLY)
        loc_oPg.AddObject("txt_4c_UsuIncs", "TextBox")
        WITH loc_oPg.txt_4c_UsuIncs
            .Value     = ""
            .Top       = 419
            .Left      = 833
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBox getUsuaAlts (usuaalts: Top=419, Left=914, W=79, H=21 - READ ONLY)
        loc_oPg.AddObject("txt_4c_UsuaAlts", "TextBox")
        WITH loc_oPg.txt_4c_UsuaAlts
            .Value     = ""
            .Top       = 419
            .Left      = 914
            .Width     = 79
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 14 (top=448): getdsccompras + checkboxes FabrProprs/Consig/Encoms
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblDscComp", "Label")
        WITH loc_oPg.lbl_4c_LblDscComp
            .Caption   = "Descr.Compras :"
            .Top       = 435
            .Left      = 15
            .Width     = 97
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- EditBox getdsccompras (dsccompras: Top=448, Left=113, W=400, H=58)
        loc_oPg.AddObject("edt_4c_DscCompras", "EditBox")
        WITH loc_oPg.edt_4c_DscCompras
            .Value    = ""
            .Top      = 448
            .Left     = 113
            .Width    = 400
            .Height   = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- CheckBox chkFabrProprs (fabrproprs: Top=451, Left=601)
        loc_oPg.AddObject("chk_4c_FabrProprs", "CheckBox")
        WITH loc_oPg.chk_4c_FabrProprs
            .Caption  = "Fab.Pr" + CHR(243) + "pria"
            .Value    = .F.
            .Top      = 451
            .Left     = 601
            .AutoSize = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- CheckBox get_Consig (consigs: Top=451, Left=681)
        loc_oPg.AddObject("chk_4c_Consig", "CheckBox")
        WITH loc_oPg.chk_4c_Consig
            .Caption  = "Consig."
            .Value    = .F.
            .Top      = 451
            .Left     = 681
            .AutoSize = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- CheckBox chkEncoms (encoms: Top=451, Left=781)
        loc_oPg.AddObject("chk_4c_Encoms", "CheckBox")
        WITH loc_oPg.chk_4c_Encoms
            .Caption  = "Encomenda"
            .Value    = .F.
            .Top      = 451
            .Left     = 781
            .AutoSize = .T.
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 15 (top=507): getDPro3s (3a descricao)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblDPro3s", "Label")
        WITH loc_oPg.lbl_4c_LblDPro3s
            .Caption   = "3a. Descr. :"
            .Top       = 494
            .Left      = 33
            .Width     = 78
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- EditBox getDPro3s (dpro3s: Top=507, Left=113, W=400, H=58)
        loc_oPg.AddObject("edt_4c_DPro3s", "EditBox")
        WITH loc_oPg.edt_4c_DPro3s
            .Value    = ""
            .Top      = 507
            .Left     = 113
            .Width    = 400
            .Height   = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- ===================================================================
        *-- LINHA 16 (top=566): getObsCompras (observacoes compras)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblObsComp", "Label")
        WITH loc_oPg.lbl_4c_LblObsComp
            .Caption   = "Obs.Compras :"
            .Top       = 553
            .Left      = 33
            .Width     = 78
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- EditBox getObsCompras (obscompras: Top=566, Left=113, W=400, H=58)
        loc_oPg.AddObject("edt_4c_ObsCompras", "EditBox")
        WITH loc_oPg.edt_4c_ObsCompras
            .Value    = ""
            .Top      = 566
            .Left     = 113
            .Width    = 400
            .Height   = 58
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- ===================================================================
        *-- DBLCLICK BINDEVENTS para campos com lookup (Fase 5 + Fase 6)
        *-- ===================================================================
        BINDEVENT(loc_oPg.txt_4c_Cpros, "DblClick", THIS, "AbrirLookupProduto")
        BINDEVENT(loc_oPg.txt_4c_Cgrus, "DblClick", THIS, "AbrirLookupGrupo")
        BINDEVENT(loc_oPg.txt_4c_Lin,   "DblClick", THIS, "AbrirLookupLin")
        BINDEVENT(loc_oPg.txt_4c_Col,   "DblClick", THIS, "AbrirLookupCol")
        BINDEVENT(loc_oPg.txt_4c_Ifor,  "DblClick", THIS, "AbrirLookupIfor")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgpgComposicao - Aba "Composicao" (Page2 de pgf_4c_Dados)
    * Contem: grd_4c_Compo (14 cols), grd_4c_SubCp (15 cols), grd_4c_TotGrupo (3 cols)
    *         cntMtPrima + ~30 textboxes + labels + checkboxes + commandgroups
    * Posicoes = valores ORIGINAIS do layout.json (Tabs=.F. -> sem deslocamento)
    * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgpgComposicao(par_oPage)
        LOCAL loc_oPg, loc_oGrd, loc_oGrd2, loc_oGrd3, loc_oCnt

        loc_oPg = par_oPage

        *-- ===================================================================
        *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
        *-- ===================================================================

        *-- cursor_4c_Compo - composicao do produto (SIGPRCPO)
        IF USED("cursor_4c_Compo")
            USE IN cursor_4c_Compo
        ENDIF
        SET NULL OFF
        CREATE CURSOR cursor_4c_Compo ( ;
            mats      C(14), dcompos C(40), unicompos C(3),  ;
            pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
            moeds     C(3),  obscompos C(10), etiqs C(1),    ;
            qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
            ordems    N(2,0), tipos C(20))

        *-- cursor_4c_SubCp - sub-composicao (sigsubcp)
        IF USED("cursor_4c_SubCp")
            USE IN cursor_4c_SubCp
        ENDIF
        CREATE CURSOR cursor_4c_SubCp ( ;
            mats      C(14), dcompos C(40), unicompos C(3),  ;
            pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
            moeds     C(3),  obscompos C(10), etiqs C(1),    ;
            qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
            ordems    N(2,0), matsubs C(14), codtams C(4))

        *-- cursor_4c_TotGrupo - totais por grupo (calculado)
        IF USED("cursor_4c_TotGrupo")
            USE IN cursor_4c_TotGrupo
        ENDIF
        CREATE CURSOR cursor_4c_TotGrupo ( ;
            Grupo     C(3), ValGrupo N(11,3), Moeda C(3))

        *-- ===================================================================
        *-- GRID grd_4c_Compo - Composicao principal (grdCompo: top=148, left=6, w=943, h=147)
        *-- 14 colunas de SIGPRCPO
        *-- ===================================================================
        loc_oPg.AddObject("grd_4c_Compo", "Grid")
        loc_oGrd = loc_oPg.grd_4c_Compo
        WITH loc_oGrd
            .Top         = 148
            .Left        = 6
            .Width       = 943
            .Height      = 147
            .FontName    = "Tahoma"
            .FontSize    = 8
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .F.
            .RowHeight   = 16
            .ScrollBars  = 2
            .Themes      = .F.
            .ColumnCount = 14
            .Visible     = .T.
        ENDWITH

        *-- Coluna 1: Material (mats, w=108)
        WITH loc_oGrd.Column1
            .Width     = 108
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "XXXXXXXXXXXXXX"
        ENDWITH
        *-- Coluna 2: Descricao (dcompos, w=187)
        WITH loc_oGrd.Column2
            .Width     = 187
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        *-- Coluna 3: Un (unicompos, w=24)
        WITH loc_oGrd.Column3
            .Width     = 24
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        *-- Coluna 4: Valor (pcompos, w=73)
        WITH loc_oGrd.Column4
            .Width     = 73
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "9999999.999"
        ENDWITH
        *-- Coluna 5: Qtde. (qtds, w=59)
        WITH loc_oGrd.Column5
            .Width     = 59
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "9999.999"
        ENDWITH
        *-- Coluna 6: Total (totas, w=58)
        WITH loc_oGrd.Column6
            .Width     = 58
            .InputMask = "9999999.999"
        ENDWITH
        *-- Coluna 7: Moe (moeds, w=31)
        WITH loc_oGrd.Column7
            .Width = 31
        ENDWITH
        *-- Coluna 8: Observacao (obscompos, w=80)
        WITH loc_oGrd.Column8
            .Width = 80
        ENDWITH
        *-- Coluna 9: E (etiqs, w=14)
        WITH loc_oGrd.Column9
            .Width     = 14
            .Format    = "M"
            .InputMask = "N,S"
        ENDWITH
        *-- Coluna 10: Consumo (qtscons, w=58)
        WITH loc_oGrd.Column10
            .Width     = 58
            .InputMask = "99999"
        ENDWITH
        *-- Coluna 11: Qtde. (qtdcvs, w=59)
        WITH loc_oGrd.Column11
            .Width     = 59
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        *-- Coluna 12: Un (cunips, w=24, ReadOnly)
        WITH loc_oGrd.Column12
            .Width     = 24
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Coluna 13: Ord (ordems, w=24)
        WITH loc_oGrd.Column13
            .Width = 24
        ENDWITH
        *-- Coluna 14: Tipo (tipos, w=108)
        WITH loc_oGrd.Column14
            .Width = 108
        ENDWITH

        *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
        loc_oGrd.RecordSource = "cursor_4c_Compo"

        *-- ControlSource APOS RecordSource (obrigatorio)
        loc_oGrd.Column1.ControlSource  = "cursor_4c_Compo.mats"
        loc_oGrd.Column2.ControlSource  = "cursor_4c_Compo.dcompos"
        loc_oGrd.Column3.ControlSource  = "cursor_4c_Compo.unicompos"
        loc_oGrd.Column4.ControlSource  = "cursor_4c_Compo.pcompos"
        loc_oGrd.Column5.ControlSource  = "cursor_4c_Compo.qtds"
        loc_oGrd.Column6.ControlSource  = "cursor_4c_Compo.totas"
        loc_oGrd.Column7.ControlSource  = "cursor_4c_Compo.moeds"
        loc_oGrd.Column8.ControlSource  = "cursor_4c_Compo.obscompos"
        loc_oGrd.Column9.ControlSource  = "cursor_4c_Compo.etiqs"
        loc_oGrd.Column10.ControlSource = "cursor_4c_Compo.qtscons"
        loc_oGrd.Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
        loc_oGrd.Column12.ControlSource = "cursor_4c_Compo.cunips"
        loc_oGrd.Column13.ControlSource = "cursor_4c_Compo.ordems"
        loc_oGrd.Column14.ControlSource = "cursor_4c_Compo.tipos"

        *-- Cabecalhos APOS RecordSource
        loc_oGrd.Column1.Header1.Caption  = "Material"
        loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column3.Header1.Caption  = "Un"
        loc_oGrd.Column4.Header1.Caption  = "Valor"
        loc_oGrd.Column5.Header1.Caption  = "Qtde."
        loc_oGrd.Column6.Header1.Caption  = "Total"
        loc_oGrd.Column7.Header1.Caption  = "Moe"
        loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column9.Header1.Caption  = "E"
        loc_oGrd.Column10.Header1.Caption = "Consumo"
        loc_oGrd.Column11.Header1.Caption = "Qtde."
        loc_oGrd.Column12.Header1.Caption = "Un"
        loc_oGrd.Column13.Header1.Caption = "Ord"
        loc_oGrd.Column14.Header1.Caption = "Material"

        *-- Larguras re-aplicadas APOS RecordSource (RecordSource pode resetar)
        loc_oGrd.Column1.Width  = 108
        loc_oGrd.Column2.Width  = 187
        loc_oGrd.Column3.Width  = 24
        loc_oGrd.Column4.Width  = 73
        loc_oGrd.Column5.Width  = 59
        loc_oGrd.Column6.Width  = 58
        loc_oGrd.Column7.Width  = 31
        loc_oGrd.Column8.Width  = 80
        loc_oGrd.Column9.Width  = 14
        loc_oGrd.Column10.Width = 58
        loc_oGrd.Column11.Width = 59
        loc_oGrd.Column12.Width = 24
        loc_oGrd.Column13.Width = 24
        loc_oGrd.Column14.Width = 108

        *-- BINDEVENT grd_4c_Compo
        BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")

        *-- ===================================================================
        *-- GRID grd_4c_SubCp - Sub-composicao (grdsubcp: top=348, left=6, w=943, h=83)
        *-- 15 colunas de sigsubcp
        *-- ===================================================================
        loc_oPg.AddObject("grd_4c_SubCp", "Grid")
        loc_oGrd2 = loc_oPg.grd_4c_SubCp
        WITH loc_oGrd2
            .Top         = 348
            .Left        = 6
            .Width       = 943
            .Height      = 83
            .FontName    = "Tahoma"
            .FontSize    = 8
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .F.
            .RowHeight   = 16
            .ScrollBars  = 2
            .Themes      = .F.
            .ColumnCount = 15
            .Visible     = .T.
        ENDWITH

        *-- Colunas grd_4c_SubCp
        WITH loc_oGrd2.Column1
            .Width = 108
            .Movable = .F.
            .Resizable = .F.
        ENDWITH
        WITH loc_oGrd2.Column2
            .Width = 149
            .Movable = .F.
            .Resizable = .F.
        ENDWITH
        WITH loc_oGrd2.Column3
            .Width = 24
            .Movable = .F.
            .Resizable = .F.
        ENDWITH
        WITH loc_oGrd2.Column4
            .Width     = 73
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "9999999.999"
        ENDWITH
        WITH loc_oGrd2.Column5
            .Width     = 59
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "9999.999"
        ENDWITH
        WITH loc_oGrd2.Column6
            .Width     = 58
            .InputMask = "9999999.999"
        ENDWITH
        WITH loc_oGrd2.Column7
            .Width = 31
        ENDWITH
        WITH loc_oGrd2.Column8
            .Width = 80
        ENDWITH
        WITH loc_oGrd2.Column9
            .Width     = 14
            .Format    = "M"
            .InputMask = "N,S"
        ENDWITH
        WITH loc_oGrd2.Column10
            .Width     = 58
            .InputMask = "99999"
        ENDWITH
        WITH loc_oGrd2.Column11
            .Width     = 59
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        WITH loc_oGrd2.Column12
            .Width     = 24
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrd2.Column13
            .Width     = 24
            .Format    = "K"
            .InputMask = "99"
        ENDWITH
        WITH loc_oGrd2.Column14
            .Width = 108
        ENDWITH
        WITH loc_oGrd2.Column15
            .Width = 38
        ENDWITH

        *-- RecordSource APOS ColumnCount
        loc_oGrd2.RecordSource = "cursor_4c_SubCp"

        *-- ControlSource APOS RecordSource
        loc_oGrd2.Column1.ControlSource  = "cursor_4c_SubCp.mats"
        loc_oGrd2.Column2.ControlSource  = "cursor_4c_SubCp.dcompos"
        loc_oGrd2.Column3.ControlSource  = "cursor_4c_SubCp.unicompos"
        loc_oGrd2.Column4.ControlSource  = "cursor_4c_SubCp.pcompos"
        loc_oGrd2.Column5.ControlSource  = "cursor_4c_SubCp.qtds"
        loc_oGrd2.Column6.ControlSource  = "cursor_4c_SubCp.totas"
        loc_oGrd2.Column7.ControlSource  = "cursor_4c_SubCp.moeds"
        loc_oGrd2.Column8.ControlSource  = "cursor_4c_SubCp.obscompos"
        loc_oGrd2.Column9.ControlSource  = "cursor_4c_SubCp.etiqs"
        loc_oGrd2.Column10.ControlSource = "cursor_4c_SubCp.qtscons"
        loc_oGrd2.Column11.ControlSource = "cursor_4c_SubCp.qtdcvs"
        loc_oGrd2.Column12.ControlSource = "cursor_4c_SubCp.cunips"
        loc_oGrd2.Column13.ControlSource = "cursor_4c_SubCp.ordems"
        loc_oGrd2.Column14.ControlSource = "cursor_4c_SubCp.matsubs"
        loc_oGrd2.Column15.ControlSource = "cursor_4c_SubCp.codtams"

        *-- Cabecalhos grd_4c_SubCp APOS RecordSource
        loc_oGrd2.Column1.Header1.Caption  = "Material"
        loc_oGrd2.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd2.Column3.Header1.Caption  = "Un"
        loc_oGrd2.Column4.Header1.Caption  = "Valor"
        loc_oGrd2.Column5.Header1.Caption  = "Qtde."
        loc_oGrd2.Column6.Header1.Caption  = "Total"
        loc_oGrd2.Column7.Header1.Caption  = "Moe"
        loc_oGrd2.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
        loc_oGrd2.Column9.Header1.Caption  = "E"
        loc_oGrd2.Column10.Header1.Caption = "Consumo"
        loc_oGrd2.Column11.Header1.Caption = "Qtde."
        loc_oGrd2.Column12.Header1.Caption = "Un"
        loc_oGrd2.Column13.Header1.Caption = "Ord"
        loc_oGrd2.Column14.Header1.Caption = "Material"
        loc_oGrd2.Column15.Header1.Caption = "Tam"

        *-- Larguras re-aplicadas
        loc_oGrd2.Column1.Width  = 108
        loc_oGrd2.Column2.Width  = 149
        loc_oGrd2.Column3.Width  = 24
        loc_oGrd2.Column4.Width  = 73
        loc_oGrd2.Column5.Width  = 59
        loc_oGrd2.Column6.Width  = 58
        loc_oGrd2.Column7.Width  = 31
        loc_oGrd2.Column8.Width  = 80
        loc_oGrd2.Column9.Width  = 14
        loc_oGrd2.Column10.Width = 58
        loc_oGrd2.Column11.Width = 59
        loc_oGrd2.Column12.Width = 24
        loc_oGrd2.Column13.Width = 24
        loc_oGrd2.Column14.Width = 108
        loc_oGrd2.Column15.Width = 38

        *-- BINDEVENT grd_4c_SubCp
        BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")

        *-- ===================================================================
        *-- GRID grd_4c_TotGrupo - Totais por grupo (GradeGRUPO: top=34, left=582, w=229, h=107)
        *-- 3 colunas, ReadOnly
        *-- ===================================================================
        loc_oPg.AddObject("grd_4c_TotGrupo", "Grid")
        loc_oGrd3 = loc_oPg.grd_4c_TotGrupo
        WITH loc_oGrd3
            .Top         = 34
            .Left        = 582
            .Width       = 229
            .Height      = 107
            .FontName    = "Courier New"
            .FontSize    = 8
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .T.
            .RowHeight   = 17
            .Themes      = .F.
            .ColumnCount = 3
            .Visible     = .T.
        ENDWITH

        WITH loc_oGrd3.Column1
            .Width     = 35
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrd3.Column2
            .Width     = 134
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .InputMask = "999,999,999.999"
        ENDWITH
        WITH loc_oGrd3.Column3
            .Width     = 37
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH

        loc_oGrd3.RecordSource = "cursor_4c_TotGrupo"
        loc_oGrd3.Column1.ControlSource = "cursor_4c_TotGrupo.Grupo"
        loc_oGrd3.Column2.ControlSource = "cursor_4c_TotGrupo.ValGrupo"
        loc_oGrd3.Column3.ControlSource = "cursor_4c_TotGrupo.Moeda"
        loc_oGrd3.Column1.Header1.Caption = "Grupo"
        loc_oGrd3.Column2.Header1.Caption = "Total "
        loc_oGrd3.Column3.Header1.Caption = "Moeda"
        loc_oGrd3.Column1.Width = 35
        loc_oGrd3.Column2.Width = 134
        loc_oGrd3.Column3.Width = 37

        *-- ===================================================================
        *-- CONTAINER cntMtPrima (top=511, left=752, w=242, h=108)
        *-- Controles de montagem de descricao automatica
        *-- ===================================================================
        loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
        loc_oCnt = loc_oPg.cnt_4c_MtPrima
        WITH loc_oCnt
            .Top         = 511
            .Left        = 752
            .Width       = 242
            .Height      = 108
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label lblCompos: "Composicao :" (top=1, left=6, w=66, h=15)
        loc_oCnt.AddObject("lbl_4c_LblCompos", "Label")
        WITH loc_oCnt.lbl_4c_LblCompos
            .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
            .Top       = 1
            .Left      = 6
            .Width     = 66
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getCompos: descricao da materia prima (top=18, left=6, w=233, h=23)
        loc_oCnt.AddObject("txt_4c_Compos", "TextBox")
        WITH loc_oCnt.txt_4c_Compos
            .Value     = ""
            .Top       = 18
            .Left      = 6
            .Width     = 233
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label lblMontaDescs: "Montagem :" (top=42, left=6, w=59, h=15)
        loc_oCnt.AddObject("lbl_4c_LblMontaDescs", "Label")
        WITH loc_oCnt.lbl_4c_LblMontaDescs
            .Caption   = "Montagem :"
            .Top       = 42
            .Left      = 6
            .Width     = 59
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- ComboBox cmbMontaDescs: forma de montagem (top=59, left=6, w=233, h=23)
        loc_oCnt.AddObject("cmb_4c_MontaDescs", "ComboBox")
        WITH loc_oCnt.cmb_4c_MontaDescs
            .Top            = 59
            .Left           = 6
            .Width          = 233
            .Height         = 23
            .FontName       = "Tahoma"
            .FontSize       = 8
            .RowSourceType  = 1
            .RowSource      = "Qtde + Uni + Codigo, Qtde + Codigo, Uni + Codigo, Codigo, Qtde + Codigo (s/ CT),Qtde+Codigo+Peso+Unidade,Qtde + Unidade"
            .Style          = 2
            .SpecialEffect  = 1
            .Themes         = .F.
            .ToolTipText    = "Forma de Montagem da Mat" + CHR(233) + "ria Prima na Descri" + CHR(231) + CHR(227) + "o Autom" + CHR(225) + "tica do Produto"
            .Visible        = .T.
        ENDWITH

        *-- Label lblDigiMaxs: "Digitos :" (top=88, left=4, w=41, h=15)
        loc_oCnt.AddObject("lbl_4c_LblDigiMaxs", "Label")
        WITH loc_oCnt.lbl_4c_LblDigiMaxs
            .Caption   = "D" + CHR(237) + "gitos :"
            .Top       = 88
            .Left      = 4
            .Width     = 41
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getDigiMaxs: numero de digitos (top=84, left=54, w=25, h=23)
        loc_oCnt.AddObject("txt_4c_DigiMaxs", "TextBox")
        WITH loc_oCnt.txt_4c_DigiMaxs
            .Value     = 0
            .Top       = 84
            .Left      = 54
            .Width     = 25
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99"
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .ToolTipText = "N" + CHR(250) + "mero de D" + CHR(237) + "gitos da Descri" + CHR(231) + CHR(227) + "o da Mat" + CHR(233) + "ria Prima Utilizados na Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Visible   = .T.
        ENDWITH

        *-- Label lblOrdCompos: "Ordem :" (top=88, left=85, w=41, h=15)
        loc_oCnt.AddObject("lbl_4c_LblOrdCompos", "Label")
        WITH loc_oCnt.lbl_4c_LblOrdCompos
            .Caption   = "Ordem :"
            .Top       = 88
            .Left      = 85
            .Width     = 41
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getOrdCompos: ordem de apresentacao (top=84, left=136, w=25)
        loc_oCnt.AddObject("txt_4c_OrdCompos", "TextBox")
        WITH loc_oCnt.txt_4c_OrdCompos
            .Value     = 0
            .Top       = 84
            .Left      = 136
            .Width     = 25
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99"
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .ToolTipText = "Ordem de Apresenta" + CHR(231) + CHR(227) + "o da Mat" + CHR(233) + "ria Prima na Montagem da Descri" + CHR(231) + CHR(227) + "o do Produto"
            .Visible   = .T.
        ENDWITH

        *-- Label lblCasas: "Casas :" (top=88, left=165, w=38, h=15)
        loc_oCnt.AddObject("lbl_4c_LblCasas", "Label")
        WITH loc_oCnt.lbl_4c_LblCasas
            .Caption   = "Casas :"
            .Top       = 88
            .Left      = 165
            .Width     = 38
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox getCasas: casas decimais (top=84, left=213, w=25)
        loc_oCnt.AddObject("txt_4c_Casas", "TextBox")
        WITH loc_oCnt.txt_4c_Casas
            .Value     = 0
            .Top       = 84
            .Left      = 213
            .Width     = 25
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99"
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .ToolTipText = "Casas Decimais na Montagem da Quantidade da Composi" + CHR(231) + CHR(227) + "o"
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- TEXTBOXES standalone - preco/custo/venda (ligados a SigCdPro)
        *-- ===================================================================

        *-- ObsOF: observacao da OF (getObsOFs: top=297, left=99, w=850, h=21)
        loc_oPg.AddObject("lbl_4c_LblObsOFs", "Label")
        WITH loc_oPg.lbl_4c_LblObsOFs
            .Caption   = "\<Obs. da OF :"
            .Top       = 300
            .Left      = 36
            .Width     = 64
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH
        loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
        WITH loc_oPg.txt_4c_ObsOFs
            .Value    = ""
            .Top      = 297
            .Left     = 99
            .Width    = 850
            .Height   = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Label Say16: "Descricao :" (top=324, left=45, w=55, h=15)
        loc_oPg.AddObject("lbl_4c_Say16", "Label")
        WITH loc_oPg.lbl_4c_Say16
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 324
            .Left      = 45
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox Get_Desc: descricao composicao (top=321, left=99, w=298, h=21) - ReadOnly
        loc_oPg.AddObject("txt_4c_DescComp", "TextBox")
        WITH loc_oPg.txt_4c_DescComp
            .Value     = ""
            .Top       = 321
            .Left      = 99
            .Width     = 298
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Say15: "Material Principal :" (top=324, left=421, w=89, h=15)
        loc_oPg.AddObject("lbl_4c_Say15", "Label")
        WITH loc_oPg.lbl_4c_Say15
            .Caption   = "Material Principal :"
            .Top       = 324
            .Left      = 421
            .Width     = 89
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox Get_MatP: material principal (top=321, left=517, w=108, h=21) - ReadOnly
        loc_oPg.AddObject("txt_4c_MatPrincs", "TextBox")
        WITH loc_oPg.txt_4c_MatPrincs
            .Value     = ""
            .Top       = 321
            .Left      = 517
            .Width     = 108
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Say3: "Descricao :" (top=435, left=39, w=55, h=15) - sub-composicao
        loc_oPg.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oPg.lbl_4c_Say3
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 435
            .Left      = 39
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_desccp: descricao sub-composicao (top=432, left=99, w=298, h=21) - ReadOnly
        loc_oPg.AddObject("txt_4c_DescSubCp", "TextBox")
        WITH loc_oPg.txt_4c_DescSubCp
            .Value     = ""
            .Top       = 432
            .Left      = 99
            .Width     = 298
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Say5: "Substitui :" (top=435, left=465, w=50, h=15)
        loc_oPg.AddObject("lbl_4c_Say5", "Label")
        WITH loc_oPg.lbl_4c_Say5
            .Caption   = "Substitui :"
            .Top       = 435
            .Left      = 465
            .Width     = 50
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TextBox get_matsub: material substituto (top=432, left=517, w=108, h=21) - ReadOnly
        loc_oPg.AddObject("txt_4c_MatSubs", "TextBox")
        WITH loc_oPg.txt_4c_MatSubs
            .Value     = ""
            .Top       = 432
            .Left      = 517
            .Width     = 108
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LABELS separadores de secao custo/venda
        *-- ===================================================================

        *-- Say1: " Custo " (top=473, left=47, w=46, h=16)
        loc_oPg.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oPg.lbl_4c_Say1
            .Caption   = " Custo "
            .Top       = 473
            .Left      = 47
            .Width     = 46
            .Height    = 16
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say2: " Venda " (top=474, left=361, w=48, h=16)
        loc_oPg.AddObject("lbl_4c_Say2", "Label")
        WITH loc_oPg.lbl_4c_Say2
            .Caption   = " Venda "
            .Top       = 474
            .Left      = 361
            .Width     = 48
            .Height    = 16
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Shape6: divisor horizontal custo (top=497, left=9, w=158, h=2)
        loc_oPg.AddObject("shp_4c_Shape6", "Shape")
        WITH loc_oPg.shp_4c_Shape6
            .Top    = 497
            .Left   = 9
            .Width  = 158
            .Height = 2
            .Visible = .T.
        ENDWITH

        *-- Shape4: divisor horizontal venda (top=498, left=323, w=158, h=2)
        loc_oPg.AddObject("shp_4c_Shape4", "Shape")
        WITH loc_oPg.shp_4c_Shape4
            .Top    = 498
            .Left   = 323
            .Width  = 158
            .Height = 2
            .Visible = .T.
        ENDWITH

        *-- ===================================================================
        *-- CHECKBOXES liberar custo/venda + planejamento
        *-- ===================================================================

        *-- chkLiberaCusto: liberar custo (top=458, left=9, w=39, h=38)
        loc_oPg.AddObject("chk_4c_LiberaCusto", "CheckBox")
        WITH loc_oPg.chk_4c_LiberaCusto
            .Caption  = ""
            .Top      = 458
            .Left     = 9
            .Width    = 39
            .Height   = 38
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.chk_4c_LiberaCusto, "Click", THIS, "ChkLiberaCustoClick")

        *-- chkLiberaVenda: liberar venda (top=459, left=323, w=39, h=38)
        loc_oPg.AddObject("chk_4c_LiberaVenda", "CheckBox")
        WITH loc_oPg.chk_4c_LiberaVenda
            .Caption  = ""
            .Top      = 459
            .Left     = 323
            .Width    = 39
            .Height   = 38
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.chk_4c_LiberaVenda, "Click", THIS, "ChkLiberaVendaClick")

        *-- chkPlanCus: planejamento custo (top=556, left=36, w=25, h=25)
        loc_oPg.AddObject("chk_4c_PlanCus", "CheckBox")
        WITH loc_oPg.chk_4c_PlanCus
            .Caption  = ""
            .Top      = 556
            .Left     = 36
            .Width    = 25
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- chkPlanVen: planejamento venda (top=556, left=387, w=25, h=25)
        loc_oPg.AddObject("chk_4c_PlanVen", "CheckBox")
        WITH loc_oPg.chk_4c_PlanVen
            .Caption  = ""
            .Top      = 556
            .Left     = 387
            .Width    = 25
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Chk_Pvenda: usar preco de venda (top=595, left=387, w=25, h=25)
        loc_oPg.AddObject("chk_4c_Pvenda", "CheckBox")
        WITH loc_oPg.chk_4c_Pvenda
            .Caption  = ""
            .Top      = 595
            .Left     = 387
            .Width    = 25
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- ===================================================================
        *-- SECAO CUSTO - Preco de Custo (Moeda 1)
        *-- ===================================================================

        *-- lblCompra: "Preco de Custo (Moeda 1)" (top=502, left=9, w=127, h=15)
        loc_oPg.AddObject("lbl_4c_LblCompra", "Label")
        WITH loc_oPg.lbl_4c_LblCompra
            .Caption   = "Pre" + CHR(231) + "o de Custo (Moeda 1)"
            .Top       = 502
            .Left      = 9
            .Width     = 127
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- getMoec: moeda custo moeda1 (top=517, left=127, w=31, h=23)
        loc_oPg.AddObject("txt_4c_Moec", "TextBox")
        WITH loc_oPg.txt_4c_Moec
            .Value    = ""
            .Top      = 517
            .Left     = 127
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress", THIS, "TxtMoecKeyPress")

        *-- getPcus: preco de custo moeda1 (top=517, left=9, w=115, h=23)
        loc_oPg.AddObject("txt_4c_Pcus", "TextBox")
        WITH loc_oPg.txt_4c_Pcus
            .Value     = 0
            .Top       = 517
            .Left      = 9
            .Width     = 115
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99999,999.99999"
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Pcus, "LostFocus", THIS, "TxtPcusValid")

        *-- lblCuVda: "Fator de Custo (Moeda 2)" (top=502, left=161, w=126, h=15)
        loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
        WITH loc_oPg.lbl_4c_LblCuVda
            .Caption   = "Fator de Custo (Moeda 2)"
            .Top       = 502
            .Left      = 161
            .Width     = 126
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- getMoepc: moeda preco custo moeda2 (top=517, left=279, w=31, h=23)
        loc_oPg.AddObject("txt_4c_Moepc", "TextBox")
        WITH loc_oPg.txt_4c_Moepc
            .Value    = ""
            .Top      = 517
            .Left     = 279
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress", THIS, "TxtMoepcKeyPress")

        *-- getFcusto: fator de custo moeda2 (top=517, left=161, w=115, h=23)
        loc_oPg.AddObject("txt_4c_Fcusto", "TextBox")
        WITH loc_oPg.txt_4c_Fcusto
            .Value     = 0
            .Top       = 517
            .Left      = 161
            .Width     = 115
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99999,999.99999"
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Fcusto, "LostFocus", THIS, "TxtFcustoValid")

        *-- Say8: "Total " (top=542, left=161, w=29, h=15)
        loc_oPg.AddObject("lbl_4c_Say8", "Label")
        WITH loc_oPg.lbl_4c_Say8
            .Caption   = "Total "
            .Top       = 542
            .Left      = 161
            .Width     = 29
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- getMoecusf: moeda custo fator (top=557, left=279, w=31, h=23)
        loc_oPg.AddObject("txt_4c_Moecusf", "TextBox")
        WITH loc_oPg.txt_4c_Moecusf
            .Value    = ""
            .Top      = 557
            .Left     = 279
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- getCustof: custo total fatorado (top=557, left=161, w=115, h=23)
        loc_oPg.AddObject("txt_4c_Custof", "TextBox")
        WITH loc_oPg.txt_4c_Custof
            .Value     = 0
            .Top       = 557
            .Left      = 161
            .Width     = 115
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99999,999.99999"
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say6: "Peso Medio" (top=581, left=10, w=56, h=15)
        loc_oPg.AddObject("lbl_4c_Say6", "Label")
        WITH loc_oPg.lbl_4c_Say6
            .Caption   = "Peso M" + CHR(233) + "dio"
            .Top       = 581
            .Left      = 10
            .Width     = 56
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- getPesom: peso medio (top=596, left=10, w=79, h=23)
        loc_oPg.AddObject("txt_4c_Pesom", "TextBox")
        WITH loc_oPg.txt_4c_Pesom
            .Value     = 0
            .Top       = 596
            .Left      = 10
            .Width     = 79
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99,999.999"
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- cmdPesoM: botao calcular peso (top=597, left=92, w=26, h=23) - "..."
        loc_oPg.AddObject("cmd_4c_PesoM", "CommandButton")
        WITH loc_oPg.cmd_4c_PesoM
            .Caption       = "..."
            .Top           = 597
            .Left          = 92
            .Width         = 26
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_PesoM, "Click", THIS, "CmdPesoMClick")

        *-- Say7: "Cotacao" (top=581, left=161, w=42, h=15)
        loc_oPg.AddObject("lbl_4c_Say7", "Label")
        WITH loc_oPg.lbl_4c_Say7
            .Caption   = "Cota" + CHR(231) + CHR(227) + "o"
            .Top       = 581
            .Left      = 161
            .Width     = 42
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- GetCotaCalcP: cotacao calculada (top=596, left=161, w=115, h=23)
        loc_oPg.AddObject("txt_4c_CotaCalcP", "TextBox")
        WITH loc_oPg.txt_4c_CotaCalcP
            .Value     = 0
            .Top       = 596
            .Left      = 161
            .Width     = 115
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99999.999999"
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CotaCalcP, "LostFocus", THIS, "TxtCotaCalcPValid")

        *-- ===================================================================
        *-- SECAO CUSTO - MKP e Fator (lado custo)
        *-- ===================================================================

        *-- Say22: "MKP" (top=542, left=9, w=22, h=15)
        loc_oPg.AddObject("lbl_4c_Say22", "Label")
        WITH loc_oPg.lbl_4c_Say22
            .Caption   = "MKP"
            .Top       = 542
            .Left      = 9
            .Width     = 22
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Get_cmkpc: MKP custo (top=557, left=9, w=24, h=23)
        loc_oPg.AddObject("txt_4c_Cftiocs", "TextBox")
        WITH loc_oPg.txt_4c_Cftiocs
            .Value    = ""
            .Top      = 557
            .Left     = 9
            .Width    = 24
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- lblValAdics: "Valor Adicional" (top=542, left=64, w=71, h=15)
        loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
        WITH loc_oPg.lbl_4c_LblValAdics
            .Caption   = "Valor Adicional"
            .Top       = 542
            .Left      = 64
            .Width     = 71
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- get_pftioc: preco fator tioc (top=557, left=64, w=94, h=23)
        loc_oPg.AddObject("txt_4c_Pftiocs", "TextBox")
        WITH loc_oPg.txt_4c_Pftiocs
            .Value     = 0
            .Top       = 557
            .Left      = 64
            .Width     = 94
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99999,999.99999"
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- SECAO VENDA - MKP Ideal + Margem
        *-- ===================================================================

        *-- lblMkpVenda: "MKP Ideal" (top=504, left=324, w=49, h=15)
        loc_oPg.AddObject("lbl_4c_LblMkpVenda", "Label")
        WITH loc_oPg.lbl_4c_LblMkpVenda
            .Caption   = "MKP Ideal"
            .Top       = 504
            .Left      = 324
            .Width     = 49
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- getMargem: margem/markup (top=517, left=323, w=89, h=23)
        loc_oPg.AddObject("txt_4c_Margem", "TextBox")
        WITH loc_oPg.txt_4c_Margem
            .Value     = 0
            .Top       = 517
            .Left      = 323
            .Width     = 89
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999.999999"
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Margem, "LostFocus", THIS, "TxtMargemValid")

        *-- getMarkupA: markup aplicado (top=596, left=323, w=62, h=23)
        loc_oPg.AddObject("txt_4c_MarkupA", "TextBox")
        WITH loc_oPg.txt_4c_MarkupA
            .Value     = 0
            .Top       = 596
            .Left      = 323
            .Width     = 62
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "9999.999"
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_MarkupA, "LostFocus", THIS, "TxtMarkupAValid")

        *-- lblMkpApl: "MKP Aplic." (top=581, left=324, w=51, h=15)
        loc_oPg.AddObject("lbl_4c_LblMkpApl", "Label")
        WITH loc_oPg.lbl_4c_LblMkpApl
            .Caption   = "MKP Aplic."
            .Top       = 581
            .Left      = 324
            .Width     = 51
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Say14: "MKP" (top=542, left=360, w=22, h=15) - FT/IO custo
        loc_oPg.AddObject("lbl_4c_Say14", "Label")
        WITH loc_oPg.lbl_4c_Say14
            .Caption   = "MKP"
            .Top       = 542
            .Left      = 360
            .Width     = 22
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Getftio: fator tipo IO custo (top=557, left=360, w=24, h=23)
        loc_oPg.AddObject("txt_4c_Cftios", "TextBox")
        WITH loc_oPg.txt_4c_Cftios
            .Value    = ""
            .Top      = 557
            .Left     = 360
            .Width    = 24
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- getStatus: status (top=557, left=324, w=31, h=23)
        loc_oPg.AddObject("txt_4c_Status", "TextBox")
        WITH loc_oPg.txt_4c_Status
            .Value    = ""
            .Top      = 557
            .Left     = 324
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say24: "Sts" (top=542, left=324, w=17, h=15)
        loc_oPg.AddObject("lbl_4c_Say24", "Label")
        WITH loc_oPg.lbl_4c_Say24
            .Caption   = "Sts"
            .Top       = 542
            .Left      = 324
            .Width     = 17
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Chk_Pvenda checkbox
        *-- (already added above)

        *-- ===================================================================
        *-- SECAO VENDA - Preco Ideal (Moeda 1)
        *-- ===================================================================

        *-- lblIdeal: "Preco Ideal (Moeda 1)" (top=503, left=416, w=111, h=15)
        loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
        WITH loc_oPg.lbl_4c_LblIdeal
            .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
            .Top       = 503
            .Left      = 416
            .Width     = 111
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- getMoeda: moeda venda (top=517, left=529, w=31, h=23)
        loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
        WITH loc_oPg.txt_4c_Moeda
            .Value    = ""
            .Top      = 517
            .Left     = 529
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaKeyPress")

        *-- getPvideal: preco de venda ideal (top=517, left=416, w=110, h=23)
        loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
        WITH loc_oPg.txt_4c_Pvideal
            .Value     = 0
            .Top       = 517
            .Left      = 416
            .Width     = 110
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99999,999.99999"
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- lblFIdeals: "Fator Ideal" (top=503, left=563, w=55, h=15)
        loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
        WITH loc_oPg.lbl_4c_LblFIdeals
            .Caption   = "Fator Ideal"
            .Top       = 503
            .Left      = 563
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- getFIdeals: fator ideal (top=517, left=563, w=110, h=23)
        loc_oPg.AddObject("txt_4c_Fideals", "TextBox")
        WITH loc_oPg.txt_4c_Fideals
            .Value     = 0
            .Top       = 517
            .Left      = 563
            .Width     = 110
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99999,999.99999"
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say13: "Valor Adicional" (top=542, left=416, w=71, h=15) - secao venda
        loc_oPg.AddObject("lbl_4c_Say13", "Label")
        WITH loc_oPg.lbl_4c_Say13
            .Caption   = "Valor Adicional"
            .Top       = 542
            .Left      = 416
            .Width     = 71
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Get_Pftio: preco fator tipo IO venda (top=557, left=416, w=110, h=23)
        loc_oPg.AddObject("txt_4c_Pftios", "TextBox")
        WITH loc_oPg.txt_4c_Pftios
            .Value     = 0
            .Top       = 557
            .Left      = 416
            .Width     = 110
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99999,999.99999"
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- Say12: "Fator" (top=542, left=563, w=28, h=15)
        loc_oPg.AddObject("lbl_4c_Say12", "Label")
        WITH loc_oPg.lbl_4c_Say12
            .Caption   = "Fator"
            .Top       = 542
            .Left      = 563
            .Width     = 28
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Get_mftio: moeda fator IO (top=557, left=529, w=31, h=23)
        loc_oPg.AddObject("txt_4c_Mftios", "TextBox")
        WITH loc_oPg.txt_4c_Mftios
            .Value    = ""
            .Top      = 557
            .Left     = 529
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- getFvenda: fator de venda (top=557, left=563, w=110, h=23)
        loc_oPg.AddObject("txt_4c_Fvendas", "TextBox")
        WITH loc_oPg.txt_4c_Fvendas
            .Value     = 0
            .Top       = 557
            .Left      = 563
            .Width     = 110
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99,999.99999"
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- lblVenda: "Preco Atual (Moeda 2)" (top=581, left=416, w=115, h=15)
        loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
        WITH loc_oPg.lbl_4c_LblVenda
            .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
            .Top       = 581
            .Left      = 416
            .Width     = 115
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- getMoepv: moeda preco venda moeda2 (top=557, left=677, w=31, h=23)
        loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
        WITH loc_oPg.txt_4c_Moepv
            .Value    = ""
            .Top      = 557
            .Left     = 677
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress", THIS, "TxtMoepvKeyPress")

        *-- getPven: preco de venda (top=596, left=416, w=110, h=23)
        loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
        WITH loc_oPg.txt_4c_Pvens
            .Value     = 0
            .Top       = 596
            .Left      = 416
            .Width     = 110
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99999,999.99999"
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- lblFAtuals: "Fator Atual" (top=581, left=563, w=56, h=15)
        loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
        WITH loc_oPg.lbl_4c_LblFAtuals
            .Caption   = "Fator Atual"
            .Top       = 581
            .Left      = 563
            .Width     = 56
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- getMoev: moeda venda atual (top=596, left=529, w=31, h=23)
        loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
        WITH loc_oPg.txt_4c_Moevs
            .Value    = ""
            .Top      = 596
            .Left     = 529
            .Width    = 31
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH

        *-- getFAtuals: fator atual (top=596, left=563, w=110, h=23) - liberado por chkLiberaVenda
        loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
        WITH loc_oPg.txt_4c_FAtuals
            .Value     = 0
            .Top       = 596
            .Left      = 563
            .Width     = 110
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "99999,999.99999"
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- SECAO ENCARGO/FINANCEIRO
        *-- ===================================================================

        *-- Say25: "Financeiro" (top=581, left=678, w=51, h=15)
        loc_oPg.AddObject("lbl_4c_Say25", "Label")
        WITH loc_oPg.lbl_4c_Say25
            .Caption   = "Financeiro"
            .Top       = 581
            .Left      = 678
            .Width     = 51
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Get_Encarg: encargo financeiro (top=595, left=678, w=62, h=23)
        loc_oPg.AddObject("txt_4c_Encargos", "TextBox")
        WITH loc_oPg.txt_4c_Encargos
            .Value     = 0
            .Top       = 595
            .Left      = 678
            .Width     = 62
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999.99"
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- cmdCalcVals: botao calcular valores (top=507, left=678, w=40, h=40)
        loc_oPg.AddObject("cmd_4c_CalcVals", "CommandButton")
        WITH loc_oPg.cmd_4c_CalcVals
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
            .PicturePosition = 13
            .Top           = 507
            .Left          = 678
            .Width         = 40
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CalcVals, "Click", THIS, "CmdCalcValsClick")

        *-- ===================================================================
        *-- COMMANDGROUP cmdgCompo - 5 botoes (top=145, left=947, w=50, h=210)
        *-- ===================================================================
        loc_oPg.AddObject("obj_4c_CmdgCompo", "CommandGroup")
        WITH loc_oPg.obj_4c_CmdgCompo
            .ButtonCount   = 5
            .BorderStyle   = 0
            .Top           = 145
            .Left          = 947
            .Width         = 50
            .Height        = 210
            .BackColor     = RGB(162, 214, 242)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_CmdgCompo
            .Buttons(1).Top          = 5
            .Buttons(1).Left         = 5
            .Buttons(1).Height       = 40
            .Buttons(1).Width        = 40
            .Buttons(1).Caption      = ""
            .Buttons(1).Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .Buttons(1).ToolTipText  = "Inserir Item"
            .Buttons(1).SpecialEffect = 0
            .Buttons(1).BackColor    = RGB(255, 255, 255)
            .Buttons(1).ForeColor    = RGB(0, 0, 0)
            .Buttons(1).Themes       = .F.
            .Buttons(2).Top          = 45
            .Buttons(2).Left         = 5
            .Buttons(2).Height       = 40
            .Buttons(2).Width        = 40
            .Buttons(2).Caption      = ""
            .Buttons(2).Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Buttons(2).ToolTipText  = "Excluir Item"
            .Buttons(2).SpecialEffect = 0
            .Buttons(2).BackColor    = RGB(255, 255, 255)
            .Buttons(2).ForeColor    = RGB(0, 0, 0)
            .Buttons(2).Themes       = .F.
            .Buttons(3).Top          = 85
            .Buttons(3).Left         = 5
            .Buttons(3).Height       = 40
            .Buttons(3).Width        = 40
            .Buttons(3).Caption      = ""
            .Buttons(3).Picture      = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
            .Buttons(3).ToolTipText  = "Atualizar Custo"
            .Buttons(3).SpecialEffect = 0
            .Buttons(3).BackColor    = RGB(255, 255, 255)
            .Buttons(3).Themes       = .F.
            .Buttons(4).Top          = 125
            .Buttons(4).Left         = 5
            .Buttons(4).Height       = 40
            .Buttons(4).Width        = 40
            .Buttons(4).Caption      = ""
            .Buttons(4).Picture      = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
            .Buttons(4).ToolTipText  = "Atualizar Pre" + CHR(231) + "o"
            .Buttons(4).SpecialEffect = 0
            .Buttons(4).BackColor    = RGB(255, 255, 255)
            .Buttons(4).Themes       = .F.
            .Buttons(5).Top          = 165
            .Buttons(5).Left         = 5
            .Buttons(5).Height       = 40
            .Buttons(5).Width        = 40
            .Buttons(5).Caption      = ""
            .Buttons(5).Picture      = gc_4c_CaminhoIcones + "geral_servicos_26.jpg"
            .Buttons(5).ToolTipText  = "Atualizar Pesos"
            .Buttons(5).BackColor    = RGB(255, 255, 255)
            .Buttons(5).Themes       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgCompo, "Click", THIS, "CmdgCompoClick")

        *-- ===================================================================
        *-- COMMANDGROUP cmdgSubCp - 2 botoes (top=345, left=947, w=50, h=90)
        *-- ===================================================================
        loc_oPg.AddObject("obj_4c_CmdgSubCp", "CommandGroup")
        WITH loc_oPg.obj_4c_CmdgSubCp
            .ButtonCount   = 2
            .BorderStyle   = 0
            .Top           = 345
            .Left          = 947
            .Width         = 50
            .Height        = 90
            .BackColor     = RGB(162, 214, 242)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_CmdgSubCp
            .Buttons(1).Top          = 5
            .Buttons(1).Left         = 5
            .Buttons(1).Height       = 40
            .Buttons(1).Width        = 40
            .Buttons(1).Caption      = ""
            .Buttons(1).Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .Buttons(1).ToolTipText  = "Inserir Item"
            .Buttons(1).SpecialEffect = 0
            .Buttons(1).BackColor    = RGB(255, 255, 255)
            .Buttons(1).ForeColor    = RGB(0, 0, 0)
            .Buttons(1).Themes       = .F.
            .Buttons(2).Top          = 45
            .Buttons(2).Left         = 5
            .Buttons(2).Height       = 40
            .Buttons(2).Width        = 40
            .Buttons(2).Caption      = ""
            .Buttons(2).Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Buttons(2).ToolTipText  = "Excluir Item"
            .Buttons(2).SpecialEffect = 0
            .Buttons(2).BackColor    = RGB(255, 255, 255)
            .Buttons(2).ForeColor    = RGB(0, 0, 0)
            .Buttons(2).Themes       = .F.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgSubCp, "Click", THIS, "CmdgSubCpClick")

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgpgDadosFiscais - Aba "Dados Fiscais" do PageFrame interno (pgDadosFiscais)
    * Fase 13: Sub-pagina Dados Fiscais - 54 controles do original
    * Posicoes: valores do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
    * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais(par_oPage)
        LOCAL loc_oPg, loc_oGrd
        loc_oPg = par_oPage

        *-- ===================================================================
        *-- CURSOR PLACEHOLDER (criar ANTES do grid)
        *-- ===================================================================

        *-- cursor_4c_Cmv - historico valor do grama produzido (grdCmv)
        IF USED("cursor_4c_Cmv")
            USE IN cursor_4c_Cmv
        ENDIF
        SET NULL OFF
        CREATE CURSOR cursor_4c_Cmv ( ;
            datas    C(7), ;
            valcuss  N(10,2), ;
            moedas   C(3))

        *-- ===================================================================
        *-- LABELS
        *-- ===================================================================

        *-- Say16: Grupo C.C.
        loc_oPg.AddObject("lbl_4c_Say16", "Label")
        WITH loc_oPg.lbl_4c_Say16
            .Caption  = "Grupo C.C. :"
            .Top      = 165
            .Left     = 138
            .Width    = 63
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say17: Conta C.C.
        loc_oPg.AddObject("lbl_4c_Say17", "Label")
        WITH loc_oPg.lbl_4c_Say17
            .Caption  = "Conta C.C. :"
            .Top      = 189
            .Left     = 138
            .Width    = 63
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say1: Classificacao Fiscal (NCM)
        loc_oPg.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oPg.lbl_4c_Say1
            .Caption  = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
            .Top      = 216
            .Left     = 102
            .Width    = 99
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say2: Origem da Mercadoria
        loc_oPg.AddObject("lbl_4c_Say2", "Label")
        WITH loc_oPg.lbl_4c_Say2
            .Caption  = "Origem da Mercadoria :"
            .Top      = 241
            .Left     = 87
            .Width    = 114
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say3: Situacao Tributaria ICMS
        loc_oPg.AddObject("lbl_4c_Say3", "Label")
        WITH loc_oPg.lbl_4c_Say3
            .Caption  = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
            .Top      = 266
            .Left     = 74
            .Width    = 127
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say6: Codigo de Servicos para ICMS
        loc_oPg.AddObject("lbl_4c_Say6", "Label")
        WITH loc_oPg.lbl_4c_Say6
            .Caption  = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
            .Top      = 291
            .Left     = 48
            .Width    = 153
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say8: Aliquota ICMS
        loc_oPg.AddObject("lbl_4c_Say8", "Label")
        WITH loc_oPg.lbl_4c_Say8
            .Caption  = "Al" + CHR(237) + "quota ICMS :"
            .Top      = 291
            .Left     = 250
            .Width    = 76
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say4: Tipo de Tributacao
        loc_oPg.AddObject("lbl_4c_Say4", "Label")
        WITH loc_oPg.lbl_4c_Say4
            .Caption  = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
            .Top      = 291
            .Left     = 395
            .Width    = 98
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say41: IAT
        loc_oPg.AddObject("lbl_4c_Say41", "Label")
        WITH loc_oPg.lbl_4c_Say41
            .Caption  = "IAT :"
            .Top      = 290
            .Left     = 558
            .Width    = 26
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say42: [A]rredondamento [T]runcamento
        loc_oPg.AddObject("lbl_4c_Say42", "Label")
        WITH loc_oPg.lbl_4c_Say42
            .Caption  = "[A]rredondamento [T]runcamento"
            .Top      = 290
            .Left     = 609
            .Width    = 165
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say5: Situacao Tributaria IPI
        loc_oPg.AddObject("lbl_4c_Say5", "Label")
        WITH loc_oPg.lbl_4c_Say5
            .Caption  = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
            .Top      = 316
            .Left     = 85
            .Width    = 116
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say_AliqIPI: Aliquota de IPI
        loc_oPg.AddObject("lbl_4c_SayAliqIPI", "Label")
        WITH loc_oPg.lbl_4c_SayAliqIPI
            .Caption  = "Al" + CHR(237) + "quota de IPI :"
            .Top      = 316
            .Left     = 327
            .Width    = 80
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say13: Excecao da TIPI
        loc_oPg.AddObject("lbl_4c_Say13", "Label")
        WITH loc_oPg.lbl_4c_Say13
            .Caption  = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
            .Top      = 316
            .Left     = 495
            .Width    = 87
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say18: Descricao Fiscal
        loc_oPg.AddObject("lbl_4c_Say18", "Label")
        WITH loc_oPg.lbl_4c_Say18
            .Caption  = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
            .Top      = 341
            .Left     = 117
            .Width    = 84
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say9: Valor do Grama Produzido
        loc_oPg.AddObject("lbl_4c_Say9", "Label")
        WITH loc_oPg.lbl_4c_Say9
            .Caption  = "Valor do Grama Produzido"
            .Top      = 320
            .Left     = 756
            .Width    = 125
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say12: Descricao ECF
        loc_oPg.AddObject("lbl_4c_Say12", "Label")
        WITH loc_oPg.lbl_4c_Say12
            .Caption  = "Descri" + CHR(231) + CHR(227) + "o ECF :"
            .Top      = 433
            .Left     = 124
            .Width    = 77
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say11: Metal
        loc_oPg.AddObject("lbl_4c_Say11", "Label")
        WITH loc_oPg.lbl_4c_Say11
            .Caption  = "Metal :"
            .Top      = 433
            .Left     = 494
            .Width    = 35
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say7: Valor Estimado
        loc_oPg.AddObject("lbl_4c_Say7", "Label")
        WITH loc_oPg.lbl_4c_Say7
            .Caption  = "Valor Estimado :"
            .Top      = 458
            .Left     = 122
            .Width    = 79
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say15: Teor
        loc_oPg.AddObject("lbl_4c_Say15", "Label")
        WITH loc_oPg.lbl_4c_Say15
            .Caption  = "Teor :"
            .Top      = 458
            .Left     = 498
            .Width    = 31
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- Say10: IPPT/CST
        loc_oPg.AddObject("lbl_4c_Say10", "Label")
        WITH loc_oPg.lbl_4c_Say10
            .Caption  = "IPPT/CST :"
            .Top      = 483
            .Left     = 147
            .Width    = 54
            .Height   = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .AutoSize = .F.
            .Visible  = .T.
        ENDWITH

        *-- ===================================================================
        *-- TEXTBOXES - Grupo e Conta de Custo (C.C.)
        *-- ===================================================================

        *-- get_gruccus (txt_4c_Gruccus): Grupo C.C. codigo - T:161, L:206, W:80, H:23
        loc_oPg.AddObject("txt_4c_Gruccus", "TextBox")
        WITH loc_oPg.txt_4c_Gruccus
            .Value     = ""
            .Top       = 161
            .Left      = 206
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "!!!!!!!!!!"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Gruccus, "KeyPress", THIS, "TxtGruccusKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Gruccus, "DblClick", THIS, "AbrirLookupGruccus")

        *-- get_dgruccus (txt_4c_Dgruccus): Grupo C.C. descricao - T:161, L:288, W:318, H:23
        loc_oPg.AddObject("txt_4c_Dgruccus", "TextBox")
        WITH loc_oPg.txt_4c_Dgruccus
            .Value    = ""
            .Top      = 161
            .Left     = 288
            .Width    = 318
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Dgruccus, "KeyPress", THIS, "TxtDgruccusKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Dgruccus, "DblClick", THIS, "AbrirLookupDgruccus")

        *-- get_contaccus (txt_4c_Contaccus): Conta C.C. codigo - T:186, L:206, W:80, H:23
        loc_oPg.AddObject("txt_4c_Contaccus", "TextBox")
        WITH loc_oPg.txt_4c_Contaccus
            .Value     = ""
            .Top       = 186
            .Left      = 206
            .Width     = 80
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "!!!!!!!!!!"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Contaccus, "KeyPress", THIS, "TxtContaccusKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Contaccus, "DblClick", THIS, "AbrirLookupContaccus")

        *-- get_dcontaccus (txt_4c_Dcontaccus): Conta C.C. descricao - T:186, L:288, W:318, H:23
        loc_oPg.AddObject("txt_4c_Dcontaccus", "TextBox")
        WITH loc_oPg.txt_4c_Dcontaccus
            .Value    = ""
            .Top      = 186
            .Left     = 288
            .Width    = 318
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Dcontaccus, "KeyPress", THIS, "TxtDcontaccusKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Dcontaccus, "DblClick", THIS, "AbrirLookupDcontaccus")

        *-- ===================================================================
        *-- TEXTBOXES - Classificacao Fiscal (NCM)
        *-- ===================================================================

        *-- getClfiscal (txt_4c_Clfiscal): NCM codigo - T:211, L:206, W:94, H:23
        loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
        WITH loc_oPg.txt_4c_Clfiscal
            .Value     = ""
            .Top       = 211
            .Left      = 206
            .Width     = 94
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "9999.99.99"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TxtClfiscalKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Clfiscal, "DblClick", THIS, "AbrirLookupClfiscal")

        *-- getDclfiscal (txt_4c_Dclfiscal): NCM descricao - T:211, L:303, W:303, H:23
        loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
        WITH loc_oPg.txt_4c_Dclfiscal
            .Value    = ""
            .Top      = 211
            .Left     = 303
            .Width    = 303
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress", THIS, "TxtDclfiscalKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "DblClick", THIS, "AbrirLookupDclfiscal")

        *-- ===================================================================
        *-- TEXTBOXES - Origem da Mercadoria
        *-- ===================================================================

        *-- getOrigmerc (txt_4c_Origmerc): Origem codigo - T:236, L:206, W:17, H:23
        loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
        WITH loc_oPg.txt_4c_Origmerc
            .Value     = ""
            .Top       = 236
            .Left      = 206
            .Width     = 17
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 1
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Origmerc, "KeyPress", THIS, "TxtOrigmercKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Origmerc, "DblClick", THIS, "AbrirLookupOrigmerc")

        *-- getDorigmerc (txt_4c_Dorigmerc): Origem descricao - T:236, L:226, W:380, H:23
        loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
        WITH loc_oPg.txt_4c_Dorigmerc
            .Value    = ""
            .Top      = 236
            .Left     = 226
            .Width    = 380
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress", THIS, "TxtDorigmercKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "DblClick", THIS, "AbrirLookupDorigmerc")

        *-- ===================================================================
        *-- TEXTBOXES - Situacao Tributaria ICMS
        *-- ===================================================================

        *-- getSittricm (txt_4c_Sittricm): ICMS codigo - T:261, L:206, W:31, H:23
        loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
        WITH loc_oPg.txt_4c_Sittricm
            .Value     = ""
            .Top       = 261
            .Left      = 206
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "!!!"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Sittricm, "KeyPress", THIS, "TxtSittricmKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Sittricm, "DblClick", THIS, "AbrirLookupSittricm")

        *-- getDsittricm (txt_4c_Dsittricm): ICMS descricao - T:261, L:240, W:366, H:23
        loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
        WITH loc_oPg.txt_4c_Dsittricm
            .Value    = ""
            .Top      = 261
            .Left     = 240
            .Width    = 366
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Dsittricm, "KeyPress", THIS, "TxtDsittricmKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Dsittricm, "DblClick", THIS, "AbrirLookupDsittricm")

        *-- ===================================================================
        *-- TEXTBOXES - Linha de Servicos ICMS, Aliquotas, Tipo, IAT
        *-- ===================================================================

        *-- Get_CodServs (txt_4c_CodServs): Codigo de Servicos - T:286, L:206, W:38, H:23
        loc_oPg.AddObject("txt_4c_CodServs", "TextBox")
        WITH loc_oPg.txt_4c_CodServs
            .Value     = ""
            .Top       = 286
            .Left      = 206
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "!!!"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CodServs, "KeyPress", THIS, "TxtCodServsKeyPress")
        BINDEVENT(loc_oPg.txt_4c_CodServs, "DblClick", THIS, "AbrirLookupCodServs")

        *-- getIcms (txt_4c_Icms): Aliquota ICMS - T:286, L:342, W:45, H:23
        loc_oPg.AddObject("txt_4c_Icms", "TextBox")
        WITH loc_oPg.txt_4c_Icms
            .Value     = 0
            .Top       = 286
            .Left      = 342
            .Width     = 45
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999.99"
            .Visible   = .T.
        ENDWITH

        *-- Get_TpTrib (txt_4c_TpTrib): Tipo de Tributacao - T:286, L:513, W:38, H:23
        loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
        WITH loc_oPg.txt_4c_TpTrib
            .Value     = ""
            .Top       = 286
            .Left      = 513
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "!!!!"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_TpTrib, "KeyPress", THIS, "TxtTpTribKeyPress")
        BINDEVENT(loc_oPg.txt_4c_TpTrib, "DblClick", THIS, "AbrirLookupTpTrib")

        *-- getiat (txt_4c_Iat): IAT Arredondamento/Truncamento - T:286, L:589, W:17, H:23
        loc_oPg.AddObject("txt_4c_Iat", "TextBox")
        WITH loc_oPg.txt_4c_Iat
            .Value     = ""
            .Top       = 286
            .Left      = 589
            .Width     = 17
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .MaxLength = 1
            .InputMask = "!"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Iat, "LostFocus", THIS, "ValidarIat")

        *-- ===================================================================
        *-- COMBOBOX - Situacao Tributaria IPI
        *-- ===================================================================

        *-- cmbIpi (cbo_4c_CmbIpi): Sit. Trib. IPI - T:311, L:206, W:108, H:25
        loc_oPg.AddObject("cbo_4c_CmbIpi", "ComboBox")
        WITH loc_oPg.cbo_4c_CmbIpi
            .Top      = 311
            .Left     = 206
            .Width    = 108
            .Height   = 25
            .FontName = "Tahoma"
            .FontSize = 8
            .Style    = 2
            .Visible  = .T.
        ENDWITH
        loc_oPg.cbo_4c_CmbIpi.AddItem("")
        loc_oPg.cbo_4c_CmbIpi.AddItem("Tributado")
        loc_oPg.cbo_4c_CmbIpi.AddItem("Isento")
        loc_oPg.cbo_4c_CmbIpi.AddItem("Outros")

        *-- ===================================================================
        *-- TEXTBOXES - Aliquota IPI e Excecao TIPI
        *-- ===================================================================

        *-- Get_AliqIPI (txt_4c_AliqIPI): Aliquota de IPI - T:311, L:425, W:45, H:25
        loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
        WITH loc_oPg.txt_4c_AliqIPI
            .Value     = 0
            .Top       = 311
            .Left      = 425
            .Width     = 45
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999.99"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_AliqIPI, "LostFocus", THIS, "ValidarAliqIPI")

        *-- getextipi (txt_4c_Extipi): Excecao da TIPI - T:311, L:601, W:35, H:25
        loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
        WITH loc_oPg.txt_4c_Extipi
            .Value     = ""
            .Top       = 311
            .Left      = 601
            .Width     = 35
            .Height    = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "!!!!!"
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- EDITBOX - Descricao Fiscal (memo)
        *-- ===================================================================

        *-- mgetdescfi (obj_4c_Mgetdescfi): T:338, L:206, W:509, H:89
        loc_oPg.AddObject("obj_4c_Mgetdescfi", "EditBox")
        WITH loc_oPg.obj_4c_Mgetdescfi
            .Value      = ""
            .Top        = 338
            .Left       = 206
            .Width      = 509
            .Height     = 89
            .FontName   = "Tahoma"
            .FontSize   = 8
            .ScrollBars = 2
            .Visible    = .T.
        ENDWITH

        *-- ===================================================================
        *-- COMMANDBUTTON - Gerar Descricao Fiscal
        *-- ===================================================================

        *-- btnDescFis (cmd_4c_BtnDescFis): T:359, L:162, W:26, H:26
        loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnDescFis
            .Caption  = "..."
            .Top      = 359
            .Left     = 162
            .Width    = 26
            .Height   = 26
            .FontName = "Tahoma"
            .FontSize = 8
            .Themes   = .F.
            .Visible  = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "CmdBtnDescFisClick")

        *-- ===================================================================
        *-- GRID - Historico Valor do Grama Produzido (grdCmv)
        *-- T:338, L:754, W:223, H:141, 3 colunas: Periodo / Valor Custo GR / Moe
        *-- ===================================================================

        loc_oPg.AddObject("grd_4c_Dados", "Grid")
        loc_oGrd = loc_oPg.grd_4c_Dados
        WITH loc_oGrd
            .Top         = 338
            .Left        = 754
            .Width       = 223
            .Height      = 141
            .FontName    = "Tahoma"
            .FontSize    = 8
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .T.
            .RowHeight   = 16
            .ScrollBars  = 2
            .Themes      = .F.
            .ColumnCount = 3
            .Visible     = .T.
        ENDWITH

        *-- Cabecalhos ANTES do RecordSource
        loc_oGrd.Column1.Header1.Caption = "Per" + CHR(237) + "odo"
        loc_oGrd.Column2.Header1.Caption = "Valor Custo GR"
        loc_oGrd.Column3.Header1.Caption = "Moe"

        *-- Larguras das colunas
        WITH loc_oGrd.Column1
            .Width     = 60
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        WITH loc_oGrd.Column2
            .Width     = 120
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        WITH loc_oGrd.Column3
            .Width     = 40
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH

        *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
        loc_oGrd.RecordSource = "cursor_4c_Cmv"

        *-- ControlSource APOS RecordSource (obrigatorio)
        loc_oGrd.Column1.ControlSource = "cursor_4c_Cmv.datas"
        loc_oGrd.Column2.ControlSource = "cursor_4c_Cmv.valcuss"
        loc_oGrd.Column3.ControlSource = "cursor_4c_Cmv.moedas"

        *-- Reaplica larguras apos RecordSource (RecordSource pode resetar)
        loc_oGrd.Column1.Width = 60
        loc_oGrd.Column2.Width = 120
        loc_oGrd.Column3.Width = 40

        *-- ===================================================================
        *-- TEXTBOXES - Descricao ECF, Metal/Teor, Valor Estimado, IPPT/CST
        *-- ===================================================================

        *-- getDescEcfs (txt_4c_DescEcfs): T:429, L:206, W:213, H:23
        loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
        WITH loc_oPg.txt_4c_DescEcfs
            .Value    = ""
            .Top      = 429
            .Left     = 206
            .Width    = 213
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH

        *-- Get_metal (txt_4c_Metal): Metal codigo - T:429, L:537, W:24, H:23
        loc_oPg.AddObject("txt_4c_Metal", "TextBox")
        WITH loc_oPg.txt_4c_Metal
            .Value     = ""
            .Top       = 429
            .Left      = 537
            .Width     = 24
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "!!!!!!!!!!"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TxtMetalKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Metal, "DblClick", THIS, "AbrirLookupMetal")

        *-- Get_DesMetal (txt_4c_DesMetal): Metal descricao - T:429, L:564, W:150, H:23 (READ-ONLY)
        loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
        WITH loc_oPg.txt_4c_DesMetal
            .Value    = ""
            .Top      = 429
            .Left     = 564
            .Width    = 150
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        *-- getValor (txt_4c_Valor): Valor Estimado - T:454, L:206, W:108, H:23
        loc_oPg.AddObject("txt_4c_Valor", "TextBox")
        WITH loc_oPg.txt_4c_Valor
            .Value     = 0
            .Top       = 454
            .Left      = 206
            .Width     = 108
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "9,999,999.9999"
            .Visible   = .T.
        ENDWITH

        *-- GetMvalor (txt_4c_Mvalor): Moeda do Valor Estimado - T:454, L:317, W:31, H:23
        loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
        WITH loc_oPg.txt_4c_Mvalor
            .Value     = ""
            .Top       = 454
            .Left      = 317
            .Width     = 31
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "!!!"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Mvalor, "KeyPress", THIS, "TxtMvalorKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Mvalor, "DblClick", THIS, "AbrirLookupMvalor")

        *-- Get_teor (txt_4c_Teor): Teor codigo - T:454, L:537, W:24, H:23
        loc_oPg.AddObject("txt_4c_Teor", "TextBox")
        WITH loc_oPg.txt_4c_Teor
            .Value     = ""
            .Top       = 454
            .Left      = 537
            .Width     = 24
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "!!!!!!!!!!"
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TxtTeorKeyPress")
        BINDEVENT(loc_oPg.txt_4c_Teor, "DblClick", THIS, "AbrirLookupTeor")

        *-- Get_DesTeor (txt_4c_DesTeor): Teor descricao - T:454, L:564, W:150, H:23 (READ-ONLY)
        loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
        WITH loc_oPg.txt_4c_DesTeor
            .Value    = ""
            .Top      = 454
            .Left     = 564
            .Width    = 150
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        *-- getIPPTCST (txt_4c_IPPTCST): IPPT/CST - T:479, L:206, W:108, H:23 (READ-ONLY)
        loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
        WITH loc_oPg.txt_4c_IPPTCST
            .Value    = ""
            .Top      = 479
            .Left     = 206
            .Width    = 108
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgpgCusto - Aba "Custo" do PageFrame interno (pgCusto)
    * Fase 10: Sub-pagina Custo - grdCompo 12 colunas, cmbTipos, cmdgCusto,
    *          GradeGRUPO2 (totais por grupo), labels e shape
    * Posicoes: valores do layout.json (pgf_4c_Dados.Tabs=.F. -> sem +29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgpgCusto(par_oPage)
        LOCAL loc_oPg, loc_oGrd, loc_oGrd2

        loc_oPg = par_oPage

        *-- ===================================================================
        *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
        *-- ===================================================================

        *-- cursor_4c_CustoCompo - composicao custo (SIGPRCPO filtrado por tipo)
        IF USED("cursor_4c_CustoCompo")
            USE IN cursor_4c_CustoCompo
        ENDIF
        SET NULL OFF
        CREATE CURSOR cursor_4c_CustoCompo ( ;
            mats      C(14), dcompos C(40), unicompos C(3),  ;
            pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
            moeds     C(3), obscompos C(10), etiqs C(1),     ;
            qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
            CGrus     C(3), tipos C(20))

        *-- cursor_4c_TotGrupoCusto - totais por grupo custo (calculado)
        IF USED("cursor_4c_TotGrupoCusto")
            USE IN cursor_4c_TotGrupoCusto
        ENDIF
        CREATE CURSOR cursor_4c_TotGrupoCusto ( ;
            Grupo     C(3), ValGrupo N(11,3), Moeda C(3))

        *-- ===================================================================
        *-- COMBO cbo_4c_CmbTipos (cmbTipos: top=154, left=143, w=187, h=23)
        *-- ===================================================================
        loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
        WITH loc_oPg.cbo_4c_CmbTipos
            .Top           = 154
            .Left          = 143
            .Width         = 187
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .RowSourceType = 1
            .RowSource     = ""
            .Style         = 2
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")

        *-- LABEL lbl_4c_Label1 (Say1 "Tipo :": top=159, left=112, w=29, h=15)
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Caption   = "Tipo :"
            .Top       = 159
            .Left      = 112
            .Width     = 29
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- GRID grd_4c_CustoCompo (grdCompo: top=178, left=34, w=813, h=230)
        *-- 12 colunas de SIGPRCPO
        *-- ===================================================================
        loc_oPg.AddObject("grd_4c_CustoCompo", "Grid")
        loc_oGrd = loc_oPg.grd_4c_CustoCompo
        WITH loc_oGrd
            .Top         = 178
            .Left        = 34
            .Width       = 813
            .Height      = 230
            .FontName    = "Tahoma"
            .FontSize    = 8
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .F.
            .RowHeight   = 16
            .ScrollBars  = 2
            .Themes      = .F.
            .ColumnCount = 12
            .Visible     = .T.
        ENDWITH

        *-- Coluna 1: Item (mats, w=108)
        WITH loc_oGrd.Column1
            .Width     = 108
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "XXXXXXXXXXXXXX"
        ENDWITH
        *-- Coluna 2: Descricao (dcompos, w=187)
        WITH loc_oGrd.Column2
            .Width     = 187
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        *-- Coluna 3: Un (unicompos, w=24)
        WITH loc_oGrd.Column3
            .Width     = 24
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        *-- Coluna 4: Valor (pcompos, w=73)
        WITH loc_oGrd.Column4
            .Width     = 73
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "9999999.999"
        ENDWITH
        *-- Coluna 5: Qtd (qtds, w=59)
        WITH loc_oGrd.Column5
            .Width     = 59
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "9999.999"
        ENDWITH
        *-- Coluna 6: Total (totas, w=58)
        WITH loc_oGrd.Column6
            .Width     = 58
            .Movable   = .F.
            .Resizable = .F.
            .InputMask = "9999999.999"
        ENDWITH
        *-- Coluna 7: Moe (moeds, w=31)
        WITH loc_oGrd.Column7
            .Width = 31
        ENDWITH
        *-- Coluna 8: Observacao (obscompos, w=80)
        WITH loc_oGrd.Column8
            .Width = 80
        ENDWITH
        *-- Coluna 9: Etiq (etiqs, w=14)
        WITH loc_oGrd.Column9
            .Width     = 14
            .Format    = "M"
            .InputMask = "N,S"
        ENDWITH
        *-- Coluna 10: Consumo (qtscons, w=58)
        WITH loc_oGrd.Column10
            .Width     = 58
            .InputMask = "99999"
        ENDWITH
        *-- Coluna 11: Qtd (qtdcvs, w=59)
        WITH loc_oGrd.Column11
            .Width     = 59
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        *-- Coluna 12: Un (cunips, w=24, ReadOnly)
        WITH loc_oGrd.Column12
            .Width     = 24
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH

        *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
        loc_oGrd.RecordSource = "cursor_4c_CustoCompo"

        *-- ControlSource APOS RecordSource (obrigatorio)
        loc_oGrd.Column1.ControlSource  = "cursor_4c_CustoCompo.mats"
        loc_oGrd.Column2.ControlSource  = "cursor_4c_CustoCompo.dcompos"
        loc_oGrd.Column3.ControlSource  = "cursor_4c_CustoCompo.unicompos"
        loc_oGrd.Column4.ControlSource  = "cursor_4c_CustoCompo.pcompos"
        loc_oGrd.Column5.ControlSource  = "cursor_4c_CustoCompo.qtds"
        loc_oGrd.Column6.ControlSource  = "cursor_4c_CustoCompo.totas"
        loc_oGrd.Column7.ControlSource  = "cursor_4c_CustoCompo.moeds"
        loc_oGrd.Column8.ControlSource  = "cursor_4c_CustoCompo.obscompos"
        loc_oGrd.Column9.ControlSource  = "cursor_4c_CustoCompo.etiqs"
        loc_oGrd.Column10.ControlSource = "cursor_4c_CustoCompo.qtscons"
        loc_oGrd.Column11.ControlSource = "cursor_4c_CustoCompo.qtdcvs"
        loc_oGrd.Column12.ControlSource = "cursor_4c_CustoCompo.cunips"

        *-- Cabecalhos APOS RecordSource
        loc_oGrd.Column1.Header1.Caption  = "Item"
        loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column3.Header1.Caption  = "Un"
        loc_oGrd.Column4.Header1.Caption  = "Valor"
        loc_oGrd.Column5.Header1.Caption  = "Qtd"
        loc_oGrd.Column6.Header1.Caption  = "Total"
        loc_oGrd.Column7.Header1.Caption  = "Moe"
        loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column9.Header1.Caption  = "Etiq"
        loc_oGrd.Column10.Header1.Caption = "Consumo"
        loc_oGrd.Column11.Header1.Caption = "Qtd"
        loc_oGrd.Column12.Header1.Caption = "Un"

        *-- Larguras re-aplicadas APOS RecordSource (RecordSource pode resetar)
        loc_oGrd.Column1.Width  = 108
        loc_oGrd.Column2.Width  = 187
        loc_oGrd.Column3.Width  = 24
        loc_oGrd.Column4.Width  = 73
        loc_oGrd.Column5.Width  = 59
        loc_oGrd.Column6.Width  = 58
        loc_oGrd.Column7.Width  = 31
        loc_oGrd.Column8.Width  = 80
        loc_oGrd.Column9.Width  = 14
        loc_oGrd.Column10.Width = 58
        loc_oGrd.Column11.Width = 59
        loc_oGrd.Column12.Width = 24

        *-- BINDEVENT grd_4c_CustoCompo
        BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdCustoCompoAfterRowColChange")

        *-- ===================================================================
        *-- COMMANDGROUP obj_4c_CmdgCusto (cmdgCompo: top=240, left=851, w=50, h=90)
        *-- 2 botoes: Inserir, Excluir
        *-- ===================================================================
        loc_oPg.AddObject("obj_4c_CmdgCusto", "CommandGroup")
        WITH loc_oPg.obj_4c_CmdgCusto
            .ButtonCount   = 2
            .BorderStyle   = 0
            .Top           = 240
            .Left          = 851
            .Width         = 50
            .Height        = 90
            .BackColor     = RGB(162, 214, 242)
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_CmdgCusto
            .Buttons(1).Top           = 5
            .Buttons(1).Left          = 5
            .Buttons(1).Height        = 40
            .Buttons(1).Width         = 40
            .Buttons(1).Caption       = ""
            .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .Buttons(1).ToolTipText   = "Inserir Item"
            .Buttons(1).SpecialEffect = 0
            .Buttons(1).BackColor     = RGB(255, 255, 255)
            .Buttons(1).ForeColor     = RGB(0, 0, 0)
            .Buttons(1).Themes        = .F.
            .Buttons(2).Top           = 45
            .Buttons(2).Left          = 5
            .Buttons(2).Height        = 40
            .Buttons(2).Width         = 40
            .Buttons(2).Caption       = ""
            .Buttons(2).Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .Buttons(2).ToolTipText   = "Excluir Item"
            .Buttons(2).SpecialEffect = 0
            .Buttons(2).BackColor     = RGB(255, 255, 255)
            .Buttons(2).ForeColor     = RGB(0, 0, 0)
            .Buttons(2).Themes        = .F.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgCusto, "Click", THIS, "CmdgCustoClick")

        *-- ===================================================================
        *-- LABEL + TEXTBOX para descricao e grupo do item selecionado
        *-- ===================================================================

        *-- LABEL lbl_4c_Label16 (Say16 "Descricao :": top=415, left=52, w=55, h=15)
        loc_oPg.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPg.lbl_4c_Label16
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 415
            .Left      = 52
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TEXTBOX txt_4c_Desc (Get_Desc: top=412, left=116, w=304, h=21, ReadOnly)
        loc_oPg.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPg.txt_4c_Desc
            .Value     = ""
            .Top       = 412
            .Left      = 116
            .Width     = 304
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- LABEL lbl_4c_Label2 (Say2 "Grupo :": top=415, left=479, w=38, h=15)
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Caption   = "Grupo :"
            .Top       = 415
            .Left      = 479
            .Width     = 38
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- TEXTBOX txt_4c_DGruCompos (getDGruCompos: top=412, left=522, w=304, h=21, ReadOnly)
        loc_oPg.AddObject("txt_4c_DGruCompos", "TextBox")
        WITH loc_oPg.txt_4c_DGruCompos
            .Value     = ""
            .Top       = 412
            .Left      = 522
            .Width     = 304
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ReadOnly  = .T.
            .BackColor = RGB(224, 235, 235)
            .Themes    = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LABEL + SHAPE + GRID para totais por grupo (GradeGRUPO2)
        *-- ===================================================================

        *-- LABEL lbl_4c_Label3 (Say3 "Resumo por Grupo": top=445, left=35, w=107, h=15)
        loc_oPg.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPg.lbl_4c_Label3
            .Caption   = "Resumo por Grupo"
            .Top       = 445
            .Left      = 35
            .Width     = 107
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- SHAPE shp_4c_Shape2 (Shape2: top=460, left=35, w=158, h=2)
        loc_oPg.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPg.shp_4c_Shape2
            .Top       = 460
            .Left      = 35
            .Width     = 158
            .Height    = 2
            .BackStyle = 1
            .BackColor = RGB(0, 0, 0)
            .FillStyle = 0
            .Curvature = 0
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- GRID grd_4c_GruCusto (GradeGRUPO2: top=468, left=35, w=195, h=141)
        *-- 3 colunas: Grupo, Total, Moeda - ReadOnly
        *-- ===================================================================
        loc_oPg.AddObject("grd_4c_GruCusto", "Grid")
        loc_oGrd2 = loc_oPg.grd_4c_GruCusto
        WITH loc_oGrd2
            .Top         = 468
            .Left        = 35
            .Width       = 195
            .Height      = 141
            .FontName    = "Courier New"
            .FontSize    = 8
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .T.
            .RowHeight   = 17
            .Themes      = .F.
            .ColumnCount = 3
            .Visible     = .T.
        ENDWITH

        WITH loc_oGrd2.Column1
            .Width     = 35
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        WITH loc_oGrd2.Column2
            .Width     = 134
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
            .InputMask = "999,999,999.999"
        ENDWITH
        WITH loc_oGrd2.Column3
            .Width     = 37
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH

        loc_oGrd2.RecordSource = "cursor_4c_TotGrupoCusto"
        loc_oGrd2.Column1.ControlSource = "cursor_4c_TotGrupoCusto.Grupo"
        loc_oGrd2.Column2.ControlSource = "cursor_4c_TotGrupoCusto.ValGrupo"
        loc_oGrd2.Column3.ControlSource = "cursor_4c_TotGrupoCusto.Moeda"
        loc_oGrd2.Column1.Header1.Caption = "Grp"
        loc_oGrd2.Column2.Header1.Caption = "Total "
        loc_oGrd2.Column3.Header1.Caption = "Moe"
        loc_oGrd2.Column1.Width = 35
        loc_oGrd2.Column2.Width = 134
        loc_oGrd2.Column3.Width = 37

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgPgDadosConsP - Aba "Cons. P." (Page5 de pgf_4c_DadosInternos)
    * Grid grd_4c_GrdCons (9 cols) - RecordSource: crSigPrCpo
    * Ordem visual: Mats | Dcompos | Qtds | UniCompos | Grupos | Dscgrp | Ordems | QtsCons | Cats
    * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPage)
        LOCAL loc_oPg, loc_oGrd, loc_oGrd2

        loc_oPg = par_oPage

        *-- ===================================================================
        *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
        *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
        *-- ===================================================================

        *-- cursor_4c_GrdCons - consumo de produto (baseado em crSigPrCpo)
        *-- Ordem: Mats(cod), Dcompos(desc), Qtds(qtde RO), UniCompos(uni RO),
        *--        Grupos(fase), Dscgrp(desc fase), Ordems(ord RO), QtsCons(consumo), Cats(cat)
        IF USED("cursor_4c_GrdCons")
            USE IN cursor_4c_GrdCons
        ENDIF
        SET NULL OFF
        CREATE CURSOR cursor_4c_GrdCons ( ;
            Mats      C(14), ;
            Dcompos   C(40), ;
            Qtds      N(12,4), ;
            UniCompos C(3), ;
            Grupos    C(3), ;
            Dscgrp    C(40), ;
            Ordems    N(3,0), ;
            QtsCons   N(12,4), ;
            Cats      C(3))

        *-- cursor_4c_GrDTEMP - tempo por agrupamento (baseado em crSigProTp)
        IF USED("cursor_4c_GrDTEMP")
            USE IN cursor_4c_GrDTEMP
        ENDIF
        CREATE CURSOR cursor_4c_GrDTEMP ( ;
            agrupas   C(3), ;
            pertemps  N(12,3))

        *-- ===================================================================
        *-- GRID grd_4c_GrdCons
        *-- Original: top=155, left=6, w=987, h=362, RowHeight=17
        *-- ===================================================================
        loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
        loc_oGrd = loc_oPg.grd_4c_GrdCons
        WITH loc_oGrd
            .Top         = 155
            .Left        = 6
            .Width       = 987
            .Height      = 362
            .FontName    = "Tahoma"
            .FontSize    = 8
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .F.
            .RowHeight   = 17
            .ScrollBars  = 2
            .Themes      = .F.
            .ColumnCount = 9
            .Visible     = .T.
        ENDWITH

        *-- Col1: Componente/Mats (108px, ReadOnly)
        WITH loc_oGrd.Column1
            .Width     = 108
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Col2: Descricao/Dcompos (223px, ReadOnly) - visual pos 2 (orig ColumnOrder=2)
        WITH loc_oGrd.Column2
            .Width     = 223
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Col3: Qtde./Qtds (60px, ReadOnly) - visual pos 3 (orig ColumnOrder=3)
        WITH loc_oGrd.Column3
            .Width     = 60
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Col4: Uni/UniCompos (25px, ReadOnly)
        WITH loc_oGrd.Column4
            .Width     = 25
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Col5: Fase/Grupos (105px, editavel)
        WITH loc_oGrd.Column5
            .Width     = 105
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
        ENDWITH
        *-- Col6: Descricao fase/Dscgrp (254px, editavel)
        WITH loc_oGrd.Column6
            .Width     = 254
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        *-- Col7: Ord./Ordems (35px, ReadOnly)
        WITH loc_oGrd.Column7
            .Width     = 35
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Col8: Consumo/QtsCons (60px, editavel)
        WITH loc_oGrd.Column8
            .Width     = 60
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        *-- Col9: Cat./Cats (52px, editavel)
        WITH loc_oGrd.Column9
            .Width     = 52
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH

        *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
        loc_oGrd.RecordSource = "cursor_4c_GrdCons"

        *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
        loc_oGrd.Column1.ControlSource = "cursor_4c_GrdCons.Mats"
        loc_oGrd.Column2.ControlSource = "cursor_4c_GrdCons.Dcompos"
        loc_oGrd.Column3.ControlSource = "cursor_4c_GrdCons.Qtds"
        loc_oGrd.Column4.ControlSource = "cursor_4c_GrdCons.UniCompos"
        loc_oGrd.Column5.ControlSource = "cursor_4c_GrdCons.Grupos"
        loc_oGrd.Column6.ControlSource = "cursor_4c_GrdCons.Dscgrp"
        loc_oGrd.Column7.ControlSource = "cursor_4c_GrdCons.Ordems"
        loc_oGrd.Column8.ControlSource = "cursor_4c_GrdCons.QtsCons"
        loc_oGrd.Column9.ControlSource = "cursor_4c_GrdCons.Cats"

        *-- Cabecalhos APOS RecordSource
        loc_oGrd.Column1.Header1.Caption = "Componente"
        loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column3.Header1.Caption = "Qtde."
        loc_oGrd.Column4.Header1.Caption = "Uni"
        loc_oGrd.Column5.Header1.Caption = "Fase"
        loc_oGrd.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column7.Header1.Caption = "Ord."
        loc_oGrd.Column8.Header1.Caption = "Consumo"
        loc_oGrd.Column9.Header1.Caption = "Cat."

        *-- Larguras re-aplicadas APOS RecordSource
        loc_oGrd.Column1.Width = 108
        loc_oGrd.Column2.Width = 223
        loc_oGrd.Column3.Width = 60
        loc_oGrd.Column4.Width = 25
        loc_oGrd.Column5.Width = 105
        loc_oGrd.Column6.Width = 254
        loc_oGrd.Column7.Width = 35
        loc_oGrd.Column8.Width = 60
        loc_oGrd.Column9.Width = 52

        *-- BINDEVENT grd_4c_GrdCons
        BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")

        *-- ===================================================================
        *-- GRID grd_4c_GrDTEMP (grDTEMP: top=519, left=821, w=172, h=107, 2 cols)
        *-- ===================================================================
        loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
        loc_oGrd2 = loc_oPg.grd_4c_GrDTEMP
        WITH loc_oGrd2
            .Top         = 519
            .Left        = 821
            .Width       = 172
            .Height      = 107
            .FontName    = "Tahoma"
            .FontSize    = 8
            .RecordMark  = .T.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .T.
            .RowHeight   = 17
            .ScrollBars  = 2
            .Themes      = .F.
            .ColumnCount = 2
            .Visible     = .T.
        ENDWITH

        *-- Col1: Agrupamento/agrupas (80px, ReadOnly)
        WITH loc_oGrd2.Column1
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Col2: Tempo %/pertemps (60px, ReadOnly)
        WITH loc_oGrd2.Column2
            .Width      = 60
            .Movable    = .F.
            .Resizable  = .F.
            .ReadOnly   = .T.
            .InputMask  = "999,999,999.999"
        ENDWITH

        *-- RecordSource APOS ColumnCount
        loc_oGrd2.RecordSource = "cursor_4c_GrDTEMP"

        *-- ControlSource APOS RecordSource
        loc_oGrd2.Column1.ControlSource = "cursor_4c_GrDTEMP.agrupas"
        loc_oGrd2.Column2.ControlSource = "cursor_4c_GrDTEMP.pertemps"

        *-- Cabecalhos APOS RecordSource
        loc_oGrd2.Column1.Header1.Caption = "Agrupamento"
        loc_oGrd2.Column2.Header1.Caption = "Tempo %"

        *-- Larguras re-aplicadas APOS RecordSource
        loc_oGrd2.Column1.Width = 80
        loc_oGrd2.Column2.Width = 60

        *-- ===================================================================
        *-- LABEL lbl_4c_Say7 (Say7 "Qtde Componentes :": top=523, left=25, w=105, h=15)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Say7", "Label")
        WITH loc_oPg.lbl_4c_Say7
            .Caption   = "Qtde Componentes : "
            .Top       = 523
            .Left      = 25
            .Width     = 105
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- LABEL lbl_4c_Say1 (Say1 "Tempo Producao...": top=521, left=642, w=176, h=15)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oPg.lbl_4c_Say1
            .Caption   = "Tempo Produ" + CHR(231) + CHR(227) + "o por Agrupamento :"
            .Top       = 521
            .Left      = 642
            .Width     = 176
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- TEXTBOX txt_4c_Qtcpnt (Getqtcpnt: top=519, left=131, w=31, h=23)
        *-- ===================================================================
        loc_oPg.AddObject("txt_4c_Qtcpnt", "TextBox")
        WITH loc_oPg.txt_4c_Qtcpnt
            .Top           = 519
            .Left          = 131
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .F.
            .Alignment     = 3
            .InputMask     = "999"
            .MaxLength     = 3
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- CHECKBOX chk_4c_ChkFund (chkFund: top=544, left=10, w=182, h=15)
        *-- "Nao Checar Cadastro de Fundicao"
        *-- ===================================================================
        loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
        WITH loc_oPg.chk_4c_ChkFund
            .Caption       = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
            .Top           = 544
            .Left          = 10
            .Width         = 182
            .Height        = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .Alignment     = 0
            .AutoSize      = .T.
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Themes        = .F.
            .Value         = .F.
            .Visible       = .T.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgPgDadosFaseP - Aba "Fases P." (Page4 de pgf_4c_Dados)
    * Grid grd_4c_FasePro (5 cols: Ordem|Fase|Utilizacao|Uni.Produtiva|Material)
    * Grid grd_4c_Matrizes (3 cols: Matriz|Local|Qtde)
    * Campos: Qmin, CodGarras, Conquilha, PesoBris, PesoMetal, PesoPdrs, Cor, Tam
    * ImgFigJpg (foto do processo), ImgBorracha (foto da matriz)
    * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPage)
        LOCAL loc_oPg, loc_oGrd, loc_oGrd2

        loc_oPg = par_oPage

        *-- ===================================================================
        *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
        *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
        *-- ===================================================================

        *-- cursor_4c_Fase - fases de processo (baseado em crSigCdPrf)
        *-- Ordem visual: Ordems | Grupos | Descrs | UniPrdts | TpMats
        IF USED("cursor_4c_Fase")
            USE IN cursor_4c_Fase
        ENDIF
        SET NULL OFF
        CREATE CURSOR cursor_4c_Fase ( ;
            Ordems    N(3,0), ;
            Grupos    C(10), ;
            Descrs    C(40), ;
            UniPrdts  C(10), ;
            TpMats    C(3), ;
            FigProcs  M, ;
            FkChaves  C(30), ;
            GrpOrdem  C(12))

        *-- cursor_4c_Matrizes - matrizes do produto (baseado em crSigPrMtz)
        *-- Ordem visual: CMats | Locals | QMatz
        IF USED("cursor_4c_Matrizes")
            USE IN cursor_4c_Matrizes
        ENDIF
        SET NULL OFF
        CREATE CURSOR cursor_4c_Matrizes ( ;
            CMats     C(14), ;
            Locals    C(20), ;
            QMatz     N(5,2), ;
            CPros     C(14), ;
            cIdChaves C(30), ;
            DPros     C(40))
        *-- Linha vazia placeholder (grdMatrizes sempre tem ao menos 1 linha)
        INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
            VALUES ("", "", 0, "", "", "")

        *-- ===================================================================
        *-- GRID grd_4c_FasePro (GradFase: top=152, left=527, w=420, h=312, 5 cols)
        *-- crSigCdPrf: Ordems N(3), Grupos C(10), Descrs C(40), UniPrdts C(10), TpMats C(3)
        *-- ===================================================================
        loc_oPg.AddObject("grd_4c_FasePro", "Grid")
        loc_oGrd = loc_oPg.grd_4c_FasePro
        WITH loc_oGrd
            .Top         = 152
            .Left        = 527
            .Width       = 420
            .Height      = 312
            .FontName    = "Tahoma"
            .FontSize    = 8
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .F.
            .RowHeight   = 17
            .ScrollBars  = 2
            .Themes      = .F.
            .ColumnCount = 5
            .Visible     = .T.
        ENDWITH

        *-- Col1: Ordem/Ordems (40px)
        WITH loc_oGrd.Column1
            .Width     = 40
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH
        *-- Col2: Fase/Grupos (70px, editavel)
        WITH loc_oGrd.Column2
            .Width     = 70
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
        ENDWITH
        *-- Col3: Utilizacao/Descrs (165px, ReadOnly - preenchida pelo lookup da Col2)
        WITH loc_oGrd.Column3
            .Width     = 165
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Col4: Uni. Produtiva/UniPrdts (100px, editavel)
        WITH loc_oGrd.Column4
            .Width     = 100
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
        ENDWITH
        *-- Col5: Material/TpMats (45px, editavel)
        WITH loc_oGrd.Column5
            .Width     = 45
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
        ENDWITH

        *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
        loc_oGrd.RecordSource = "cursor_4c_Fase"

        *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
        loc_oGrd.Column1.ControlSource = "cursor_4c_Fase.Ordems"
        loc_oGrd.Column2.ControlSource = "cursor_4c_Fase.Grupos"
        loc_oGrd.Column3.ControlSource = "cursor_4c_Fase.Descrs"
        loc_oGrd.Column4.ControlSource = "cursor_4c_Fase.UniPrdts"
        loc_oGrd.Column5.ControlSource = "cursor_4c_Fase.TpMats"

        *-- Cabecalhos APOS RecordSource
        loc_oGrd.Column1.Header1.Caption = "Ordem"
        loc_oGrd.Column2.Header1.Caption = "Fase"
        loc_oGrd.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
        loc_oGrd.Column4.Header1.Caption = "Uni. Produtiva"
        loc_oGrd.Column5.Header1.Caption = "Material"

        *-- Larguras re-aplicadas APOS RecordSource
        loc_oGrd.Column1.Width = 40
        loc_oGrd.Column2.Width = 70
        loc_oGrd.Column3.Width = 165
        loc_oGrd.Column4.Width = 100
        loc_oGrd.Column5.Width = 45

        *-- BINDEVENT grd_4c_FasePro
        BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdFaseAfterRowColChange")
        BINDEVENT(loc_oGrd.Column2.Text1, "Valid", THIS, "FaseGrdCol2Valid")
        BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "FaseGrdCol4Valid")
        BINDEVENT(loc_oGrd.Column5.Text1, "Valid", THIS, "FaseGrdCol5Valid")

        *-- ===================================================================
        *-- COMMANDBUTTON cmd_4c_Incluir (inserir: top=152, left=950, 30x30)
        *-- ===================================================================
        loc_oPg.AddObject("cmd_4c_InsFase", "CommandButton")
        WITH loc_oPg.cmd_4c_InsFase
            .Top             = 152
            .Left            = 950
            .Width           = 30
            .Height          = 30
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Inserir Fase"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_InsFase, "Click", THIS, "FaseInserirClick")

        *-- COMMANDBUTTON cmd_4c_ExcFase (excluir: top=192, left=950, 30x30)
        loc_oPg.AddObject("cmd_4c_ExcFase", "CommandButton")
        WITH loc_oPg.cmd_4c_ExcFase
            .Top             = 192
            .Left            = 950
            .Width           = 30
            .Height          = 30
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Excluir Fase"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_ExcFase, "Click", THIS, "FaseExcluirClick")

        *-- COMMANDBUTTON cmd_4c_AltFase (Alternativa: top=232, left=950, 30x30)
        loc_oPg.AddObject("cmd_4c_AltFase", "CommandButton")
        WITH loc_oPg.cmd_4c_AltFase
            .Top             = 232
            .Left            = 950
            .Width           = 30
            .Height          = 30
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Fase Alternativa"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_AltFase, "Click", THIS, "FaseAlternativaClick")

        *-- COMMANDBUTTON cmd_4c_CmdFicha (CmdFicha: top=152, left=482, 30x30)
        loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
        WITH loc_oPg.cmd_4c_CmdFicha
            .Top             = 152
            .Left            = 482
            .Width           = 30
            .Height          = 30
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "relatorio_visualizar_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Ficha T" + CHR(233) + "cnica"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaClick")

        *-- ===================================================================
        *-- LABEL + TEXTBOX: Say13/getQmin "Qtd. Min. Producao :" (top=156/152, left=33/137)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPg.lbl_4c_Label13
            .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
            .Top       = 156
            .Left      = 33
            .Width     = 102
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Qmin", "TextBox")
        WITH loc_oPg.txt_4c_Qmin
            .Top           = 152
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .F.
            .Alignment     = 3
            .InputMask     = "99999.999"
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- LABEL + TEXTBOX: Say5/getCodGarras "Garra :" (top=181/177, left=99/137)
        *-- getCodGarras.When = .F. -> ReadOnly
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPg.lbl_4c_Label5
            .Caption   = "Garra :"
            .Top       = 181
            .Left      = 99
            .Width     = 36
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CodGarras", "TextBox")
        WITH loc_oPg.txt_4c_CodGarras
            .Top           = 177
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .T.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- LABEL + TEXTBOX: Say4/getConquilha "Conquilha :" (top=206/202, left=79/137)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPg.lbl_4c_Label4
            .Caption   = "Conquilha :"
            .Top       = 206
            .Left      = 79
            .Width     = 56
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Conquilha", "TextBox")
        WITH loc_oPg.txt_4c_Conquilha
            .Top           = 202
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Conquilha, "LostFocus", THIS, "ValidarConquilha")

        *-- ===================================================================
        *-- LABEL + TEXTBOX: Say9/getPesoBris "Peso Brilhante :" (top=231/227, left=58/137)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPg.lbl_4c_Label9
            .Caption   = "Peso Brilhante :"
            .Top       = 231
            .Left      = 58
            .Width     = 77
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
        WITH loc_oPg.txt_4c_PesoBris
            .Top           = 227
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .F.
            .Alignment     = 3
            .InputMask     = "999.9999"
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- LABEL + TEXTBOX: Say10/getPesoMetal "Peso Metal :" (top=256/252, left=74/137)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPg.lbl_4c_Label10
            .Caption   = "Peso Metal :"
            .Top       = 256
            .Left      = 74
            .Width     = 61
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_PesoMetal", "TextBox")
        WITH loc_oPg.txt_4c_PesoMetal
            .Top           = 252
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .F.
            .Alignment     = 3
            .InputMask     = "999.9999"
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- LABEL + TEXTBOX: Say8/getPesoPdrs "Peso Pedra :" (top=281/277, left=72/137)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPg.lbl_4c_Label8
            .Caption   = "Peso Pedra :"
            .Top       = 281
            .Left      = 72
            .Width     = 63
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_PesoPdrs", "TextBox")
        WITH loc_oPg.txt_4c_PesoPdrs
            .Top           = 277
            .Left          = 137
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .F.
            .Alignment     = 3
            .InputMask     = "999.9999"
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- LABEL + TEXTBOX: Say7/getCor "Cor Padrao :" (top=306/302, left=72/137)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPg.lbl_4c_Label7
            .Caption   = "Cor Padr" + CHR(227) + "o :"
            .Top       = 306
            .Left      = 72
            .Width     = 60
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Cor", "TextBox")
        WITH loc_oPg.txt_4c_Cor
            .Top           = 302
            .Left          = 137
            .Width         = 38
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cor, "LostFocus", THIS, "ValidarCor")

        *-- ===================================================================
        *-- CHECKBOX: opc_CravCera "Cravacao em Cera" (top=306, left=180)
        *-- ===================================================================
        loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
        WITH loc_oPg.chk_4c_CravCera
            .Caption       = "Crava" + CHR(231) + CHR(227) + "o em Cera"
            .Top           = 306
            .Left          = 180
            .Width         = 110
            .Height        = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .Alignment     = 0
            .AutoSize      = .T.
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Themes        = .F.
            .Value         = .F.
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- LABEL + TEXTBOX: Say2/getTam "Tamanho Padrao :" (top=331/327, left=45/137)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPg.lbl_4c_Label2
            .Caption   = "Tamanho Padr" + CHR(227) + "o :"
            .Top       = 331
            .Left      = 45
            .Width     = 90
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Tam", "TextBox")
        WITH loc_oPg.txt_4c_Tam
            .Top           = 327
            .Left          = 137
            .Width         = 38
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Tam, "LostFocus", THIS, "ValidarTam")

        *-- ===================================================================
        *-- CHECKBOX: fwoption1 "Peso Variavel" (top=331, left=180)
        *-- ===================================================================
        loc_oPg.AddObject("chk_4c_PesoVar", "CheckBox")
        WITH loc_oPg.chk_4c_PesoVar
            .Caption       = "Peso Vari" + CHR(225) + "vel"
            .Top           = 331
            .Left          = 180
            .Width         = 90
            .Height        = 15
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackStyle     = 0
            .Alignment     = 0
            .AutoSize      = .T.
            .SpecialEffect = 1
            .ForeColor     = RGB(90, 90, 90)
            .Themes        = .F.
            .Value         = .F.
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- LABEL + TEXTBOX: lblAcabamento/get_codacb/get_Dacb (top=356/352, left=16/137/177)
        *-- get_Dacb.When = .F. -> ReadOnly (preenchido pelo lookup de codacb)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_LblAcabamento", "Label")
        WITH loc_oPg.lbl_4c_LblAcabamento
            .Caption   = "Acabamento :"
            .Top       = 356
            .Left      = 16
            .Width     = 119
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_CodAcb", "TextBox")
        WITH loc_oPg.txt_4c_CodAcb
            .Top           = 352
            .Left          = 137
            .Width         = 38
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CodAcb, "LostFocus", THIS, "ValidarAcabamento")

        loc_oPg.AddObject("txt_4c_Dacb", "TextBox")
        WITH loc_oPg.txt_4c_Dacb
            .Top           = 352
            .Left          = 177
            .Width         = 207
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .T.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- SHAPE shp_4c_ShpFig (shpFig: top=152, left=231, w=244, h=148)
        *-- IMAGE img_4c_ImgFigJpg (ImgFigJpg: top=153, left=232, w=241, h=146)
        *-- ===================================================================
        loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
        WITH loc_oPg.shp_4c_ShpFig
            .Top         = 152
            .Left        = 231
            .Width       = 244
            .Height      = 148
            .BackColor   = RGB(240, 240, 240)
            .BorderColor = RGB(128, 128, 128)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("img_4c_ImgFigJpg", "Image")
        WITH loc_oPg.img_4c_ImgFigJpg
            .Top     = 153
            .Left    = 232
            .Width   = 241
            .Height  = 146
            .Stretch = 2
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPg.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")

        *-- ===================================================================
        *-- COMMANDGROUP obj_4c_CmdgFigura (cmdgFigura: top=192, left=482, 40x40, 1 botao)
        *-- Selecionar foto do processo
        *-- ===================================================================
        loc_oPg.AddObject("obj_4c_CmdgFigura", "CommandGroup")
        WITH loc_oPg.obj_4c_CmdgFigura
            .ButtonCount = 1
            .BorderStyle = 0
            .Top         = 192
            .Left        = 482
            .Width       = 40
            .Height      = 40
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_CmdgFigura
            .Buttons(1).Top           = 0
            .Buttons(1).Left          = 0
            .Buttons(1).Height        = 40
            .Buttons(1).Width         = 40
            .Buttons(1).Caption       = ""
            .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_foto_26.jpg"
            .Buttons(1).ToolTipText   = "Selecionar Foto"
            .Buttons(1).SpecialEffect = 0
            .Buttons(1).BackColor     = RGB(255, 255, 255)
            .Buttons(1).Themes        = .F.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgFigura, "Click", THIS, "CmdgFiguraClick")

        *-- ===================================================================
        *-- COMMANDGROUP obj_4c_CmdgFigCam (cmdgFigCam: top=232, left=482, 40x40, 1 botao)
        *-- Capturar da camera
        *-- ===================================================================
        loc_oPg.AddObject("obj_4c_CmdgFigCam", "CommandGroup")
        WITH loc_oPg.obj_4c_CmdgFigCam
            .ButtonCount = 1
            .BorderStyle = 0
            .Top         = 232
            .Left        = 482
            .Width       = 40
            .Height      = 40
            .Themes      = .F.
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg.obj_4c_CmdgFigCam
            .Buttons(1).Top           = 0
            .Buttons(1).Left          = 0
            .Buttons(1).Height        = 40
            .Buttons(1).Width         = 40
            .Buttons(1).Caption       = ""
            .Buttons(1).Picture       = gc_4c_CaminhoIcones + "geral_camera_26.jpg"
            .Buttons(1).ToolTipText   = "Capturar da C" + CHR(226) + "mera"
            .Buttons(1).SpecialEffect = 0
            .Buttons(1).BackColor     = RGB(255, 255, 255)
            .Buttons(1).Themes        = .F.
        ENDWITH
        BINDEVENT(loc_oPg.obj_4c_CmdgFigCam, "Click", THIS, "CmdgFigCamClick")

        *-- ===================================================================
        *-- LABEL lbl_4c_Label1 "Descricao :" (Say1: top=474, left=527, w=67, h=17)
        *-- TEXTBOX txt_4c_Desc (Get_Desc: top=471, left=595, w=395, h=23)
        *-- EDITBOX obj_4c_GetObs (Get_Obs: top=497, left=527, w=463, h=122)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPg.lbl_4c_Label1
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 474
            .Left      = 527
            .Width     = 67
            .Height    = 17
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPg.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oPg.txt_4c_Desc
            .Top           = 471
            .Left          = 595
            .Width         = 395
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ReadOnly      = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        loc_oPg.AddObject("obj_4c_GetObs", "EditBox")
        WITH loc_oPg.obj_4c_GetObs
            .Top           = 497
            .Left          = 527
            .Width         = 463
            .Height        = 122
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Themes        = .F.
            .ScrollBars    = 2
            .ReadOnly      = .F.
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- GRID grd_4c_Matrizes (grdMatrizes: top=380, left=7, w=246, h=240, 3 cols)
        *-- crSigPrMtz: CMats C(14) | Locals C(20) | QMatz N(5,2)
        *-- ===================================================================
        loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
        loc_oGrd2 = loc_oPg.grd_4c_Matrizes
        WITH loc_oGrd2
            .Top         = 380
            .Left        = 7
            .Width       = 246
            .Height      = 240
            .FontName    = "Tahoma"
            .FontSize    = 8
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .F.
            .RowHeight   = 17
            .ScrollBars  = 2
            .Themes      = .F.
            .ColumnCount = 3
            .Visible     = .T.
        ENDWITH

        *-- Col1: Matriz/CMats (80px, editavel com lookup)
        WITH loc_oGrd2.Column1
            .Width     = 80
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
        ENDWITH
        *-- Col2: Local/Locals (116px, ReadOnly)
        WITH loc_oGrd2.Column2
            .Width     = 116
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Col3: Qtde/QMatz (50px, editavel)
        WITH loc_oGrd2.Column3
            .Width     = 50
            .Movable   = .F.
            .Resizable = .F.
        ENDWITH

        *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
        loc_oGrd2.RecordSource = "cursor_4c_Matrizes"

        *-- ControlSource APOS RecordSource
        loc_oGrd2.Column1.ControlSource = "cursor_4c_Matrizes.CMats"
        loc_oGrd2.Column2.ControlSource = "cursor_4c_Matrizes.Locals"
        loc_oGrd2.Column3.ControlSource = "cursor_4c_Matrizes.QMatz"

        *-- Cabecalhos APOS RecordSource
        loc_oGrd2.Column1.Header1.Caption = "Matriz"
        loc_oGrd2.Column2.Header1.Caption = "Local"
        loc_oGrd2.Column3.Header1.Caption = "Qtde"

        *-- Larguras re-aplicadas APOS RecordSource
        loc_oGrd2.Column1.Width = 80
        loc_oGrd2.Column2.Width = 116
        loc_oGrd2.Column3.Width = 50

        *-- BINDEVENT grd_4c_Matrizes
        BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
        BINDEVENT(loc_oGrd2.Column1.Text1, "Valid", THIS, "MatrizGrdCol1Valid")

        *-- ===================================================================
        *-- COMMANDBUTTON cmd_4c_BtnInsereMtx (btnInsereMtx: top=380, left=258, 30x30)
        *-- ===================================================================
        loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnInsereMtx
            .Top             = 380
            .Left            = 258
            .Width           = 30
            .Height          = 30
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Inserir Matriz"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnInsereMtx, "Click", THIS, "BtnInsereMtxClick")

        *-- COMMANDBUTTON cmd_4c_BtnExcluiMtz (btnExcluiMtz: top=420, left=258, 30x30)
        loc_oPg.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnExcluiMtz
            .Top             = 420
            .Left            = 258
            .Width           = 30
            .Height          = 30
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Excluir Matriz"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnExcluiMtz, "Click", THIS, "BtnExcluiMtzClick")

        *-- ===================================================================
        *-- SHAPE shp_4c_ShpBorracha (shpBorracha: top=464, left=258, w=236, h=156)
        *-- IMAGE img_4c_ImgBorracha (ImgBorracha: top=465, left=260, w=232, h=154)
        *-- ===================================================================
        loc_oPg.AddObject("shp_4c_ShpBorracha", "Shape")
        WITH loc_oPg.shp_4c_ShpBorracha
            .Top         = 464
            .Left        = 258
            .Width       = 236
            .Height      = 156
            .BackColor   = RGB(240, 240, 240)
            .BorderColor = RGB(128, 128, 128)
            .BorderWidth = 1
            .Visible     = .T.
        ENDWITH

        loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
        WITH loc_oPg.img_4c_ImgBorracha
            .Top     = 465
            .Left    = 260
            .Width   = 232
            .Height  = 154
            .Stretch = 2
            .Visible = .F.
        ENDWITH

    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgpgDesigner - Aba "Designer" (Page7 do pgf_4c_Dados)
    * Controles: grd_4c_Designer (4 cols tarefas), obj_4c_GetObsTarefas,
    *            cmd_4c_BtnIniTarefa, cmd_4c_BtnFimTarefa,
    *            grd_4c_Arquivos (1 col), cmd_4c_BtnInsArqs/OpnArqs/ExcArqs,
    *            shp_4c_Shape1, img_4c_ImgArqJpg
    * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPage)
        LOCAL loc_oPg, loc_oGrd, loc_oGrd2

        loc_oPg = par_oPage

        *-- ===================================================================
        *-- CURSORS PLACEHOLDER (criar ANTES dos grids)
        *-- Campos na ORDEM VISUAL das colunas (sem ColumnOrder)
        *-- ===================================================================

        *-- cursor_4c_Tarefas - tarefas do designer (baseado em crSigPrTar)
        *-- Ordem visual: DtInis | DtFims | Usuars | Tarefas
        IF USED("cursor_4c_Tarefas")
            USE IN cursor_4c_Tarefas
        ENDIF
        SET NULL OFF
        CREATE CURSOR cursor_4c_Tarefas ( ;
            DtInis      T, ;
            DtFims      T, ;
            Usuars      C(10), ;
            Tarefas     C(10), ;
            ObsTarefas  M, ;
            CPros       C(14), ;
            pkChaves    C(30))

        *-- cursor_4c_Arquivos - arquivos do designer (baseado em crSigPrArq)
        IF USED("cursor_4c_Arquivos")
            USE IN cursor_4c_Arquivos
        ENDIF
        SET NULL OFF
        CREATE CURSOR cursor_4c_Arquivos ( ;
            Arquivos    C(254), ;
            CPros       C(14), ;
            pkChaves    C(30))

        *-- ===================================================================
        *-- GRID grd_4c_Designer (grdDesigner: top=160, left=10, w=495, h=238, 4 cols)
        *-- crSigPrTar: DtInis T | DtFims T | Usuars C(10) | Tarefas C(10)
        *-- ===================================================================
        loc_oPg.AddObject("grd_4c_Designer", "Grid")
        loc_oGrd = loc_oPg.grd_4c_Designer
        WITH loc_oGrd
            .Top         = 160
            .Left        = 10
            .Width       = 495
            .Height      = 238
            .FontName    = "Tahoma"
            .FontSize    = 8
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .F.
            .RowHeight   = 17
            .ScrollBars  = 2
            .Themes      = .F.
            .ColumnCount = 4
            .Visible     = .T.
        ENDWITH

        *-- Col1: Data de Inicio/DtInis (120px, ReadOnly)
        WITH loc_oGrd.Column1
            .Width     = 120
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Col2: Data de Conclusao/DtFims (120px, ReadOnly)
        WITH loc_oGrd.Column2
            .Width     = 120
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Col3: Usuario/Usuars (100px, ReadOnly)
        WITH loc_oGrd.Column3
            .Width     = 100
            .Movable   = .F.
            .Resizable = .F.
            .ReadOnly  = .T.
        ENDWITH
        *-- Col4: Tarefa/Tarefas (155px, editavel via lookup)
        WITH loc_oGrd.Column4
            .Width     = 155
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
        ENDWITH

        *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
        loc_oGrd.RecordSource = "cursor_4c_Tarefas"

        *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
        loc_oGrd.Column1.ControlSource = "cursor_4c_Tarefas.DtInis"
        loc_oGrd.Column2.ControlSource = "cursor_4c_Tarefas.DtFims"
        loc_oGrd.Column3.ControlSource = "cursor_4c_Tarefas.Usuars"
        loc_oGrd.Column4.ControlSource = "cursor_4c_Tarefas.Tarefas"

        *-- Cabecalhos APOS RecordSource
        loc_oGrd.Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
        loc_oGrd.Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
        loc_oGrd.Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
        loc_oGrd.Column4.Header1.Caption = "Tarefa"

        *-- Larguras re-aplicadas APOS RecordSource
        loc_oGrd.Column1.Width = 120
        loc_oGrd.Column2.Width = 120
        loc_oGrd.Column3.Width = 100
        loc_oGrd.Column4.Width = 155

        *-- BINDEVENT grd_4c_Designer
        BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
        BINDEVENT(loc_oGrd.Column4.Text1, "Valid", THIS, "DesignerCol4Valid")

        *-- ===================================================================
        *-- LABEL lbl_4c_Say31 ("Observacao da Tarefa": top=144, left=583)
        *-- ===================================================================
        loc_oPg.AddObject("lbl_4c_Say31", "Label")
        WITH loc_oPg.lbl_4c_Say31
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
            .Top       = 144
            .Left      = 583
            .Width     = 120
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- ===================================================================
        *-- EDITBOX obj_4c_GetObsTarefas (getObsTarefas: top=160, left=584, w=407, h=238)
        *-- When: InList(pcEscolha, INSERIR, ALTERAR) -> editavel so em modo edicao
        *-- ===================================================================
        loc_oPg.AddObject("obj_4c_GetObsTarefas", "EditBox")
        WITH loc_oPg.obj_4c_GetObsTarefas
            .Value         = ""
            .Top           = 160
            .Left          = 584
            .Width         = 407
            .Height        = 238
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ScrollBars    = 2
            .ReadOnly      = .F.
            .Themes        = .F.
            .ControlSource = "cursor_4c_Tarefas.ObsTarefas"
            .Visible       = .T.
        ENDWITH

        *-- ===================================================================
        *-- COMMANDBUTTON cmd_4c_BtnIniTarefa (btnIniTarefa: top=161, left=509, w=42, h=42)
        *-- When: InList(pcEscolha, INSERIR, ALTERAR)
        *-- Click: Valida tarefa aberta + insere nova linha em cursor_4c_Tarefas
        *-- ===================================================================
        loc_oPg.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnIniTarefa
            .Top             = 161
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Iniciar Tarefa"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")

        *-- ===================================================================
        *-- COMMANDBUTTON cmd_4c_BtnFimTarefa (btnFimTarefa: top=203, left=509, w=42, h=42)
        *-- When: InList(pcEscolha, INSERIR, ALTERAR)
        *-- Click: Valida pertencimento + registra DtFims
        *-- ===================================================================
        loc_oPg.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnFimTarefa
            .Top             = 203
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Finalizar Tarefa"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")

        *-- ===================================================================
        *-- GRID grd_4c_Arquivos (grdArquivos: top=415, left=10, w=495, h=202, 1 col)
        *-- crSigPrArq: Arquivos C(254)
        *-- ===================================================================
        loc_oPg.AddObject("grd_4c_Arquivos", "Grid")
        loc_oGrd2 = loc_oPg.grd_4c_Arquivos
        WITH loc_oGrd2
            .Top         = 415
            .Left        = 10
            .Width       = 495
            .Height      = 202
            .FontName    = "Tahoma"
            .FontSize    = 8
            .RecordMark  = .F.
            .DeleteMark  = .F.
            .GridLines   = 3
            .ReadOnly    = .F.
            .RowHeight   = 17
            .ScrollBars  = 2
            .Themes      = .F.
            .ColumnCount = 1
            .Visible     = .T.
        ENDWITH

        *-- Col1: Arquivos (495px, editavel)
        WITH loc_oGrd2.Column1
            .Width     = 495
            .Movable   = .F.
            .Resizable = .F.
            .Sparse    = .F.
        ENDWITH

        *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
        loc_oGrd2.RecordSource = "cursor_4c_Arquivos"

        *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
        loc_oGrd2.Column1.ControlSource = "cursor_4c_Arquivos.Arquivos"

        *-- Cabecalho APOS RecordSource
        loc_oGrd2.Column1.Header1.Caption = "Arquivos Para Designer"

        *-- Largura re-aplicada APOS RecordSource
        loc_oGrd2.Column1.Width = 495

        *-- BINDEVENT grd_4c_Arquivos
        BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")

        *-- ===================================================================
        *-- COMMANDBUTTON cmd_4c_BtnInsArqs (btnInsArqs: top=416, left=509, w=42, h=42)
        *-- When: InList(pcEscolha, INSERIR, ALTERAR)
        *-- Click: GetFile -> Insert Into cursor_4c_Arquivos
        *-- ===================================================================
        loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnInsArqs
            .Top             = 416
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Inserir Arquivo"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")

        *-- ===================================================================
        *-- COMMANDBUTTON cmd_4c_BtnExcArqs (btnExcArqs: top=458, left=509, w=42, h=42)
        *-- When: InList(pcEscolha, INSERIR, ALTERAR)
        *-- Click: Delete from cursor_4c_Arquivos
        *-- ===================================================================
        loc_oPg.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnExcArqs
            .Top             = 458
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Excluir Arquivo"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")

        *-- ===================================================================
        *-- COMMANDBUTTON cmd_4c_BtnOpnArqs (btnOpnArqs: top=500, left=509, w=42, h=42)
        *-- When: sempre habilitado (.T.)
        *-- Click: Shell.Application.Open(arquivo)
        *-- ===================================================================
        loc_oPg.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
        WITH loc_oPg.cmd_4c_BtnOpnArqs
            .Top             = 500
            .Left            = 509
            .Width           = 42
            .Height          = 42
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "relatorio_visualizar_26.jpg"
            .PicturePosition = 13
            .ToolTipText     = "Abrir Arquivo"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Themes          = .F.
            .SpecialEffect   = 0
            .BackColor       = RGB(255, 255, 255)
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPg.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")

        *-- ===================================================================
        *-- SHAPE shp_4c_Shape1 (Shape1: top=415, left=584, w=407, h=202)
        *-- Borda visual ao redor da area de preview de imagem
        *-- ===================================================================
        loc_oPg.AddObject("shp_4c_Shape1", "Shape")
        WITH loc_oPg.shp_4c_Shape1
            .Top         = 415
            .Left        = 584
            .Width       = 407
            .Height      = 202
            .BorderColor = RGB(128, 128, 128)
            .BorderWidth = 1
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- ===================================================================
        *-- IMAGE img_4c_ImgArqJpg (imgArqJpg: top=417, left=586, w=403, h=198)
        *-- Visible=.F. por padrao; exibida ao selecionar arquivo JPG/ICO/BMP/JPEG
        *-- Click: Do Form SigOpZom (zoom do arquivo)
        *-- ===================================================================
        loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
        WITH loc_oPg.img_4c_ImgArqJpg
            .Top     = 417
            .Left    = 586
            .Width   = 403
            .Height  = 198
            .Stretch = 2
            .Visible = .F.
        ENDWITH
        BINDEVENT(loc_oPg.img_4c_ImgArqJpg, "Click", THIS, "ImgArqJpgClick")

    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDesignerAfterRowColChange - Handler AfterRowColChange do grd_4c_Designer
    * Atualiza exibicao da observacao da tarefa selecionada
    *--------------------------------------------------------------------------
    PROCEDURE GrdDesignerAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
            IF PEMSTATUS(loc_oPg, "obj_4c_GetObsTarefas", 5)
                loc_oPg.obj_4c_GetObsTarefas.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesignerCol4Valid - Valid do Column4 (Tarefa) do grd_4c_Designer
    * Lookup: SigCdCad (CodCads, DesCads) - catalogo de tarefas designer
    *--------------------------------------------------------------------------
    PROCEDURE DesignerCol4Valid(par_nColIndex)
        LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
            loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT CodCads, DesCads FROM SigCdCad WHERE CodCads = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTarefas") <= 0 OR EOF("cursor_4c_ValTarefas")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("CodCads", "C" + CHR(243) + "digo", 80)
                loc_oLookup.mAddColuna("DesCads", "Descri" + CHR(231) + CHR(227) + "o", 220)
                loc_oLookup.cTabela     = "SigCdCad"
                loc_oLookup.cCampoChave = "CodCads"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ENDIF
            IF USED("cursor_4c_ValTarefas")
                USE IN cursor_4c_ValTarefas
            ENDIF
            IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas")
                SELECT cursor_4c_Tarefas
                REPLACE Tarefas WITH PADR(loc_cCodigo, 10) IN cursor_4c_Tarefas
                loc_oGrd.Column4.Text1.Value = loc_cCodigo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdArquivosAfterRowColChange - Handler AfterRowColChange do grd_4c_Arquivos
    * Exibe preview de imagem se arquivo for JPG/ICO/BMP/JPEG
    *--------------------------------------------------------------------------
    PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
        LOCAL loc_lcArq, loc_oPg, loc_nPonto
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
            CLEAR RESOURCES
            loc_oPg.img_4c_ImgArqJpg.Picture = ""
            loc_oPg.img_4c_ImgArqJpg.Visible = .F.
            IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
                RETURN
            ENDIF
            loc_lcArq  = ALLTRIM(cursor_4c_Arquivos.Arquivos)
            loc_nPonto = AT(".", loc_lcArq)
            IF !EMPTY(loc_lcArq) AND loc_nPonto > 0 AND ;
                INLIST(ALLTRIM(UPPER(SUBSTR(loc_lcArq, loc_nPonto, 5))), ".JPG", ".ICO", ".BMP", ".JPEG")
                loc_oPg.img_4c_ImgArqJpg.Picture = loc_lcArq
                loc_oPg.img_4c_ImgArqJpg.Visible = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIniTarefaClick - Inicia nova tarefa no grd_4c_Designer
    * Valida: sem tarefa aberta para o usuario + sem tarefa sem codigo
    *--------------------------------------------------------------------------
    PROCEDURE BtnIniTarefaClick()
        LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Tarefas")
                loc_lResultado = loc_lResultado
            ENDIF
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer

            *-- Validar: nao pode ter tarefa aberta (DtFims vazia) para este usuario
            SELECT cursor_4c_Tarefas
            GO TOP IN cursor_4c_Tarefas
            LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(DtFims)
            IF !EOF("cursor_4c_Tarefas")
                MsgAviso("Existe Uma Tarefa N" + CHR(227) + "o Encerrada Para Esse Usu" + CHR(225) + "rio!!!")
                loc_oGrd.Column4.SetFocus()
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Validar: nao pode ter tarefa com codigo vazio para este usuario
            SELECT cursor_4c_Tarefas
            GO TOP IN cursor_4c_Tarefas
            LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(Tarefas)
            IF !EOF("cursor_4c_Tarefas")
                MsgAviso("Existe Uma Tarefa Ainda N" + CHR(227) + "o Informada!!!")
                loc_oGrd.Column4.SetFocus()
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Inserir nova linha com DtInis = agora, DtFims = vazio ({})
            loc_tDataHora = DATETIME()
            INSERT INTO cursor_4c_Tarefas (DtInis, DtFims, Usuars, Tarefas, CPros, pkChaves) ;
                VALUES (loc_tDataHora, {}, ;
                        PADR(gc_4c_UsuarioLogado, 10), PADR("", 10), ;
                        PADR(THIS.this_oBusinessObject.this_cCpros, 14), "")

            SELECT cursor_4c_Tarefas
            GO BOTTOM IN cursor_4c_Tarefas
            loc_oGrd.Refresh()
            loc_oGrd.Column4.SetFocus()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnFimTarefaClick - Finaliza tarefa corrente no grd_4c_Designer
    * Valida: tarefa pertence ao usuario + nao esta ja finalizada
    *--------------------------------------------------------------------------
    PROCEDURE BtnFimTarefaClick()
        LOCAL loc_lResultado, loc_oGrd, loc_tDataHora
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Tarefas") OR EOF("cursor_4c_Tarefas") OR BOF("cursor_4c_Tarefas")
                loc_lResultado = loc_lResultado
            ENDIF
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer

            *-- Validar: tarefa deve pertencer ao usuario logado
            IF ALLTRIM(cursor_4c_Tarefas.Usuars) <> ALLTRIM(gc_4c_UsuarioLogado)
                MsgAviso("Essa Tarefa N" + CHR(227) + "o Pertence a Esse Usu" + CHR(225) + "rio!!!")
                loc_oGrd.Column4.SetFocus()
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Validar: tarefa nao pode estar ja finalizada
            IF !EMPTY(cursor_4c_Tarefas.DtFims)
                MsgAviso("Essa Tarefa J" + CHR(225) + " Se Encontra Finalizada!!!")
                loc_oGrd.Column4.SetFocus()
                loc_lResultado = loc_lResultado
            ENDIF

            *-- Registrar data/hora de finalizacao
            loc_tDataHora = DATETIME()
            SELECT cursor_4c_Tarefas
            REPLACE DtFims WITH loc_tDataHora IN cursor_4c_Tarefas

            loc_oGrd.Refresh()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInsArqsClick - Insere arquivo no grd_4c_Arquivos via dialog GetFile
    *--------------------------------------------------------------------------
    PROCEDURE BtnInsArqsClick()
        LOCAL loc_lResultado, loc_lcArq, loc_oGrd
        loc_lResultado = .F.
        TRY
            loc_oGrd  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
            loc_lcArq = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
                "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
            IF !EMPTY(loc_lcArq)
                INSERT INTO cursor_4c_Arquivos (CPros, pkChaves, Arquivos) ;
                    VALUES (PADR(THIS.this_oBusinessObject.this_cCpros, 14), "", UPPER(loc_lcArq))
                loc_oGrd.Refresh()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnOpnArqsClick - Abre arquivo selecionado no grd_4c_Arquivos com Shell
    *--------------------------------------------------------------------------
    PROCEDURE BtnOpnArqsClick()
        LOCAL loc_lResultado, loc_lcArq, loc_oApp
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcArq = ALLTRIM(cursor_4c_Arquivos.Arquivos)
            IF !EMPTY(loc_lcArq) AND FILE(loc_lcArq)
                loc_oApp = CREATEOBJECT("Shell.Application")
                loc_oApp.Open(loc_lcArq)
                loc_lResultado = .T.
            ELSE
                MsgAviso("Arquivo N" + CHR(227) + "o Encontrado!!!")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcArqsClick - Exclui arquivo selecionado do grd_4c_Arquivos
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcArqsClick()
        LOCAL loc_lResultado, loc_oGrd
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos") OR BOF("cursor_4c_Arquivos")
                loc_lResultado = loc_lResultado
            ENDIF
            loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
            IF !EMPTY(cursor_4c_Arquivos.Arquivos)
                SELECT cursor_4c_Arquivos
                DELETE IN cursor_4c_Arquivos
                IF !EOF("cursor_4c_Arquivos")
                    SKIP IN cursor_4c_Arquivos
                ENDIF
                IF EOF("cursor_4c_Arquivos")
                    GO BOTTOM IN cursor_4c_Arquivos
                ENDIF
                PACK IN cursor_4c_Arquivos
            ENDIF
            loc_oGrd.Refresh()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgArqJpgClick - Abre visualizador de imagem em tela cheia (SigOpZom)
    *--------------------------------------------------------------------------
    PROCEDURE ImgArqJpgClick()
        LOCAL loc_lResultado, loc_lcArq, loc_nPonto
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Arquivos") OR EOF("cursor_4c_Arquivos")
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcArq  = ALLTRIM(cursor_4c_Arquivos.Arquivos)
            loc_nPonto = AT(".", loc_lcArq)
            IF !EMPTY(loc_lcArq) AND FILE(loc_lcArq) AND loc_nPonto > 0 AND ;
                INLIST(ALLTRIM(UPPER(SUBSTR(loc_lcArq, loc_nPonto, 5))), ".JPG", ".ICO", ".BMP", ".JPEG")
                DO FORM SigOpZom WITH loc_lcArq, "Arquivo : " + loc_lcArq
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdConsAfterRowColChange - Handler AfterRowColChange do grd_4c_GrdCons
    *--------------------------------------------------------------------------
    PROCEDURE GrdConsAfterRowColChange(par_nColIndex)
        IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdFaseAfterRowColChange - Handler AfterRowColChange do grd_4c_FasePro
    * Carrega imagem FigProcs do campo memo na img_4c_ImgFigJpg
    *--------------------------------------------------------------------------
    PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
        LOCAL loc_oPage, loc_lcArquivo
        TRY
            IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
                loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
                loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
                CLEAR RESOURCES
                loc_oPage.img_4c_ImgFigJpg.Picture = ""
                loc_oPage.img_4c_ImgFigJpg.Visible = .F.
                IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
                    IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
                        loc_oPage.img_4c_ImgFigJpg.Visible = .T.
                        loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdMatrizesAfterRowColChange - Handler AfterRowColChange do grd_4c_Matrizes
    * Carrega imagem do produto matriz na img_4c_ImgBorracha via SQL
    *--------------------------------------------------------------------------
    PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
        LOCAL loc_oPage, loc_lcArquivo, loc_lcSQL
        TRY
            IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
                loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
                loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
                CLEAR RESOURCES
                loc_oPage.img_4c_ImgBorracha.Picture = ""
                loc_oPage.img_4c_ImgBorracha.Visible = .F.
                IF !EMPTY(cursor_4c_Matrizes.CMats)
                    loc_lcSQL = "SELECT FigProcs FROM SigCdPro WHERE CPros = '" + ;
                        EscaparSQL(ALLTRIM(cursor_4c_Matrizes.CMats))
                    IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_BorrachaImg") > 0
                        IF !EOF("cursor_4c_BorrachaImg")
                            IF !EMPTY(cursor_4c_BorrachaImg.FigProcs) AND !ISNULL(cursor_4c_BorrachaImg.FigProcs)
                                IF STRTOFILE(cursor_4c_BorrachaImg.FigProcs, loc_lcArquivo) > 0
                                    loc_oPage.img_4c_ImgBorracha.Visible = .T.
                                    loc_oPage.img_4c_ImgBorracha.Picture = loc_lcArquivo
                                ENDIF
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_BorrachaImg")
                            USE IN cursor_4c_BorrachaImg
                        ENDIF
                    ENDIF
                ENDIF
                loc_oPage.grd_4c_Matrizes.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ImgFigJpgClick - Click na imagem -> amplia em zoom (SigOpZom)
    *--------------------------------------------------------------------------
    PROCEDURE ImgFigJpgClick()
        LOCAL loc_lcArquivo
        TRY
            IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
                loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
                IF !EMPTY(cursor_4c_Fase.FigProcs) AND !ISNULL(cursor_4c_Fase.FigProcs)
                    STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo)
                    IF FILE(loc_lcArquivo)
                        DO FORM SigOpZom WITH loc_lcArquivo, .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdgFiguraClick - Seleciona foto do processo via GetPict
    *--------------------------------------------------------------------------
    PROCEDURE CmdgFiguraClick()
        LOCAL loc_lcFigura, loc_lcArquivo, loc_oPage
        TRY
            IF !USED("cursor_4c_Fase") OR EOF("cursor_4c_Fase")
                RETURN
            ENDIF
            IF THIS.this_cModoAtual = "VISUALIZAR"
                RETURN
            ENDIF
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            loc_oPage.grd_4c_FasePro.SetFocus()
            loc_lcFigura = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Nome do Arquivo:", "Selecionar")
            IF !EMPTY(loc_lcFigura)
                loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
                CLEAR RESOURCES
                SELECT cursor_4c_Fase
                REPLACE FigProcs WITH FILETOSTR(loc_lcFigura) IN cursor_4c_Fase
                IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
                    loc_oPage.img_4c_ImgFigJpg.Visible = .T.
                    loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdgFigCamClick - Captura foto via camera (reutiliza logica de GetPict)
    *--------------------------------------------------------------------------
    PROCEDURE CmdgFigCamClick()
        THIS.CmdgFiguraClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * FaseInserirClick - Insere nova linha no grd_4c_FasePro
    *--------------------------------------------------------------------------
    PROCEDURE FaseInserirClick()
        LOCAL loc_lResultado, loc_nOrdem, loc_oPage
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Fase")
                loc_lResultado = loc_lResultado
            ENDIF
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            SELECT cursor_4c_Fase
            IF !EOF("cursor_4c_Fase")
                IF EMPTY(cursor_4c_Fase.Grupos)
                    loc_oPage.grd_4c_FasePro.SetFocus()
                    loc_lResultado = loc_lResultado
                ENDIF
                loc_nOrdem = cursor_4c_Fase.Ordems
            ELSE
                loc_nOrdem = 0
            ENDIF
            *-- Incrementa ordens dos registros apos o atual
            SELECT cursor_4c_Fase
            SCAN FOR Ordems > loc_nOrdem
                REPLACE Ordems WITH cursor_4c_Fase.Ordems + 1 IN cursor_4c_Fase
            ENDSCAN
            *-- Insere nova linha com ordem logo apos o atual
            INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
                VALUES (loc_nOrdem + 1, "", "", "", "", "")
            GO TOP IN cursor_4c_Fase
            LOCATE FOR Ordems = loc_nOrdem + 1 AND EMPTY(Grupos)
            loc_oPage.grd_4c_FasePro.Refresh()
            loc_oPage.grd_4c_FasePro.SetFocus()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FaseExcluirClick - Exclui linha atual do grd_4c_FasePro
    *--------------------------------------------------------------------------
    PROCEDURE FaseExcluirClick()
        LOCAL loc_lResultado, loc_oPage
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Fase") OR EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
                loc_lResultado = loc_lResultado
            ENDIF
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            SELECT cursor_4c_Fase
            DELETE IN cursor_4c_Fase
            IF !EOF("cursor_4c_Fase")
                SKIP IN cursor_4c_Fase
            ENDIF
            IF EOF("cursor_4c_Fase")
                GO BOTTOM IN cursor_4c_Fase
            ENDIF
            PACK IN cursor_4c_Fase
            loc_oPage.grd_4c_FasePro.Refresh()
            loc_oPage.grd_4c_FasePro.SetFocus()
            loc_oPage.grd_4c_FasePro.Column2.SetFocus()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FaseAlternativaClick - Insere fase alternativa (mesma ordem do atual)
    *--------------------------------------------------------------------------
    PROCEDURE FaseAlternativaClick()
        LOCAL loc_lResultado, loc_nOrdem, loc_oPage
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Fase")
                loc_lResultado = loc_lResultado
            ENDIF
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            SELECT cursor_4c_Fase
            IF EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
                loc_oPage.grd_4c_FasePro.SetFocus()
                loc_lResultado = loc_lResultado
            ENDIF
            loc_nOrdem = cursor_4c_Fase.Ordems
            *-- Insere linha alternativa com mesma ordem (alternativa ao atual)
            INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
                VALUES (loc_nOrdem, "", "", "", "", "")
            GO TOP IN cursor_4c_Fase
            LOCATE FOR Ordems = loc_nOrdem AND EMPTY(Grupos)
            loc_oPage.grd_4c_FasePro.Refresh()
            loc_oPage.grd_4c_FasePro.SetFocus()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdFichaClick - Abre Ficha Tecnica do produto
    *--------------------------------------------------------------------------
    PROCEDURE CmdFichaClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            MsgAviso("Ficha T" + CHR(233) + "cnica n" + CHR(227) + "o dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
                "Ficha T" + CHR(233) + "cnica")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FaseGrdCol2Valid - Valid do Column2 (Fase/Grupos) do grd_4c_FasePro
    * Lookup: SigCdGcr (Codigos / Descrs)
    *--------------------------------------------------------------------------
    PROCEDURE FaseGrdCol2Valid(par_nColIndex)
        LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cDescr, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
            loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column2.Text1.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") <= 0 OR EOF("cursor_4c_ValGcr")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("Codigos", "C" + CHR(243) + "digo",       60)
                loc_oLookup.mAddColuna("Descrs",  "Descri" + CHR(231) + CHR(227) + "o", 200)
                loc_oLookup.cTabela     = "SigCdGcr"
                loc_oLookup.cCampoChave = "Codigos"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                    loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
                    IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") > 0 AND !EOF("cursor_4c_ValGcr")
                        loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
                    ELSE
                        loc_cDescr = ""
                    ENDIF
                ELSE
                    loc_cCodigo = ""
                    loc_cDescr  = ""
                ENDIF
                IF USED("cursor_4c_ValGcr")
                    USE IN cursor_4c_ValGcr
                ENDIF
            ELSE
                loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
                IF USED("cursor_4c_ValGcr")
                    USE IN cursor_4c_ValGcr
                ENDIF
            ENDIF
            IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
                SELECT cursor_4c_Fase
                REPLACE Grupos WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
                REPLACE Descrs WITH PADR(loc_cDescr,  40) IN cursor_4c_Fase
                loc_oGrd.Column2.Text1.Value = loc_cCodigo
                loc_oGrd.Column3.Text1.Value = loc_cDescr
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FaseGrdCol4Valid - Valid do Column4 (Uni. Produtiva/UniPrdts) do grd_4c_FasePro
    * Lookup: SigCdUpd (UniPrdts) filtrado pelo Grupo atual
    *--------------------------------------------------------------------------
    PROCEDURE FaseGrdCol4Valid(par_nColIndex)
        LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_cGrupo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
            loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column4.Text1.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_lResultado = loc_lResultado
            ENDIF
            loc_cGrupo = ""
            IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
                loc_cGrupo = ALLTRIM(cursor_4c_Fase.Grupos)
            ENDIF
            IF !EMPTY(loc_cGrupo)
                loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupo)
            ELSE
                loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd"
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValUpd") <= 0
                IF USED("cursor_4c_ValUpd")
                    USE IN cursor_4c_ValUpd
                ENDIF
                loc_lResultado = loc_lResultado
            ENDIF
            SELECT cursor_4c_ValUpd
            LOCATE FOR ALLTRIM(UniPrdts) = loc_cCodigo
            IF EOF("cursor_4c_ValUpd")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("UniPrdts", "Uni. Produtiva", 120)
                loc_oLookup.cTabela     = "SigCdUpd"
                loc_oLookup.cCampoChave = "UniPrdts"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ENDIF
            IF USED("cursor_4c_ValUpd")
                USE IN cursor_4c_ValUpd
            ENDIF
            IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
                SELECT cursor_4c_Fase
                REPLACE UniPrdts WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
                loc_oGrd.Column4.Text1.Value = loc_cCodigo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FaseGrdCol5Valid - Valid do Column5 (Material/TpMats) do grd_4c_FasePro
    * Lookup: SigOpOpt (Cods / Descs)
    *--------------------------------------------------------------------------
    PROCEDURE FaseGrdCol5Valid(par_nColIndex)
        LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
            loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column5.Text1.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT Cods, Descs FROM SigOpOpt WHERE Cods = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOpt") <= 0 OR EOF("cursor_4c_ValOpt")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
                loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
                loc_oLookup.cTabela     = "SigOpOpt"
                loc_oLookup.cCampoChave = "Cods"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ENDIF
            IF USED("cursor_4c_ValOpt")
                USE IN cursor_4c_ValOpt
            ENDIF
            IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
                SELECT cursor_4c_Fase
                REPLACE TpMats WITH PADR(loc_cCodigo, 3) IN cursor_4c_Fase
                loc_oGrd.Column5.Text1.Value = loc_cCodigo
            ENDIF
            loc_oGrd.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAcabamento - LostFocus do txt_4c_CodAcb
    * Lookup: SigCdAca (Cods / Descrs) -> preenche txt_4c_Dacb
    *--------------------------------------------------------------------------
    PROCEDURE ValidarAcabamento()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_cDescr, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_CodAcb.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_oPage.txt_4c_Dacb.Value = ""
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") <= 0 OR EOF("cursor_4c_ValAca")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
                loc_oLookup.mAddColuna("Descrs", "Descri" + CHR(231) + CHR(227) + "o", 200)
                loc_oLookup.cTabela     = "SigCdAca"
                loc_oLookup.cCampoChave = "Cods"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                    loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
                    IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") > 0 AND !EOF("cursor_4c_ValAca")
                        loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
                    ELSE
                        loc_cDescr = ""
                    ENDIF
                ELSE
                    loc_cCodigo = ""
                    loc_cDescr  = ""
                ENDIF
            ELSE
                loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
            ENDIF
            IF USED("cursor_4c_ValAca")
                USE IN cursor_4c_ValAca
            ENDIF
            loc_oPage.txt_4c_CodAcb.Value = loc_cCodigo
            loc_oPage.txt_4c_Dacb.Value   = loc_cDescr
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarConquilha - LostFocus do txt_4c_Conquilha
    * Lookup: SigCdCnq (conquilhas)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarConquilha()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cValor, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            loc_cValor = ALLTRIM(NVL(loc_oPage.txt_4c_Conquilha.Value, ""))
            IF EMPTY(loc_cValor)
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT conquilhas FROM SigCdCnq GROUP BY conquilhas"
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCnq") > 0
                SELECT cursor_4c_ValCnq
                LOCATE FOR ALLTRIM(conquilhas) = loc_cValor
                IF EOF("cursor_4c_ValCnq")
                    loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                    loc_oLookup.mAddColuna("conquilhas", "Conquilhas", 120)
                    loc_oLookup.cTabela     = "SigCdCnq"
                    loc_oLookup.cCampoChave = "conquilhas"
                    loc_oLookup.cFiltroIni  = loc_cValor
                    loc_oLookup.Show()
                    IF loc_oLookup.this_lSelecionou
                        loc_cValor = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                    ELSE
                        loc_cValor = ""
                    ENDIF
                ENDIF
                IF USED("cursor_4c_ValCnq")
                    USE IN cursor_4c_ValCnq
                ENDIF
            ENDIF
            loc_oPage.txt_4c_Conquilha.Value = loc_cValor
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCor - LostFocus do txt_4c_Cor
    * Lookup: SigCdCor (Cods / Descs)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCor()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Cor.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT Cods FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCor") <= 0 OR EOF("cursor_4c_ValCor")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
                loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
                loc_oLookup.cTabela     = "SigCdCor"
                loc_oLookup.cCampoChave = "Cods"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ENDIF
            IF USED("cursor_4c_ValCor")
                USE IN cursor_4c_ValCor
            ENDIF
            loc_oPage.txt_4c_Cor.Value = loc_cCodigo
            loc_oPage.txt_4c_Cor.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTam - LostFocus do txt_4c_Tam
    * Lookup: SigCdTam (Cods / Descs)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTam()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Tam.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT Cods FROM SigCdTam WHERE Cods = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTam") <= 0 OR EOF("cursor_4c_ValTam")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
                loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
                loc_oLookup.cTabela     = "SigCdTam"
                loc_oLookup.cCampoChave = "Cods"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ENDIF
            IF USED("cursor_4c_ValTam")
                USE IN cursor_4c_ValTam
            ENDIF
            loc_oPage.txt_4c_Tam.Value = loc_cCodigo
            loc_oPage.txt_4c_Tam.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInsereMtxClick - Insere nova linha no grd_4c_Matrizes
    *--------------------------------------------------------------------------
    PROCEDURE BtnInsereMtxClick()
        LOCAL loc_lResultado, loc_oPage
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Matrizes")
                loc_lResultado = loc_lResultado
            ENDIF
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            SELECT cursor_4c_Matrizes
            *-- Localiza linha vazia (placeholder); se nao houver, insere uma nova
            GO TOP IN cursor_4c_Matrizes
            LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
            IF EOF("cursor_4c_Matrizes")
                INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
                    VALUES ("", "", 0, "", "", "")
            ENDIF
            loc_oPage.grd_4c_Matrizes.Refresh()
            loc_oPage.grd_4c_Matrizes.SetFocus()
            loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluiMtzClick - Exclui linha atual do grd_4c_Matrizes
    * Garante sempre ao menos uma linha vazia no cursor
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluiMtzClick()
        LOCAL loc_lResultado, loc_oPage
        loc_lResultado = .F.
        TRY
            IF !USED("cursor_4c_Matrizes") OR EOF("cursor_4c_Matrizes")
                loc_lResultado = loc_lResultado
            ENDIF
            loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            SELECT cursor_4c_Matrizes
            DELETE IN cursor_4c_Matrizes
            PACK IN cursor_4c_Matrizes
            *-- Garante sempre ao menos uma linha vazia
            GO TOP IN cursor_4c_Matrizes
            LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
            IF EOF("cursor_4c_Matrizes")
                INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
                    VALUES ("", "", 0, "", "", "")
            ENDIF
            loc_oPage.grd_4c_Matrizes.Refresh()
            loc_oPage.grd_4c_Matrizes.SetFocus()
            loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MatrizGrdCol1Valid - Valid do Column1 (Matriz/CMats) do grd_4c_Matrizes
    * Lookup: SigCdPro (CPros / DPros) - produto usado como matriz
    *--------------------------------------------------------------------------
    PROCEDURE MatrizGrdCol1Valid(par_nColIndex)
        LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes
            loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column1.Text1.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMtz") <= 0 OR EOF("cursor_4c_ValMtz")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("CPros", "Matriz",                       80)
                loc_oLookup.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", 200)
                loc_oLookup.cTabela     = "SigCdPro"
                loc_oLookup.cCampoChave = "CPros"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ENDIF
            IF USED("cursor_4c_ValMtz")
                USE IN cursor_4c_ValMtz
            ENDIF
            IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
                SELECT cursor_4c_Matrizes
                REPLACE CMats WITH PADR(loc_cCodigo, 14) IN cursor_4c_Matrizes
                loc_oGrd.Column1.Text1.Value = loc_cCodigo
                loc_oGrd.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * par_oContainer: container a processar (Page1, Page2, etc.)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Itera Pages de PageFrame
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Itera containers com ControlCount
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        THIS.pgf_4c_Paginas.Visible   = .T.
        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.AjustarBotoesPorModo()
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca registros do SigPrFtp com JOIN SigCdPro
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN loc_lResultado
        ENDIF

        TRY
            loc_cWhere = THIS.MontarFiltro()

            loc_cSQL = "SELECT t.pkchaves, t.cpros, " + ;
                "ISNULL(p.dpros,'') AS dpros, " + ;
                "t.cgrus, t.cods, " + ;
                "ISNULL(p.reffs,'') AS reffs, " + ;
                "ISNULL(p.usuincs,'') AS usuincs, " + ;
                "ISNULL(p.situas,0) AS situas " + ;
                "FROM sigprftp t " + ;
                "LEFT JOIN SigCdPro p ON p.cpros = t.cpros "

            IF !EMPTY(loc_cWhere)
                loc_cSQL = loc_cSQL + "WHERE " + loc_cWhere + " "
            ENDIF

            loc_cSQL = loc_cSQL + "ORDER BY t.cpros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
                LOCAL loc_oGrd
                loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                *-- RecordSource FORA de WITH (causa erro se acessar .Column dentro do WITH)
                loc_oGrd.RecordSource = "cursor_4c_Dados"

                *-- Definir ControlSource (OBRIGATORIO apos RecordSource)
                loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.cpros"
                loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.dpros"
                loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.cgrus"
                loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.cods"
                loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.reffs"
                loc_oGrd.Column6.ControlSource = "cursor_4c_Dados.usuincs"
                loc_oGrd.Column7.ControlSource = "cursor_4c_Dados.situas"

                *-- Re-aplicar larguras e cabecalhos (RecordSource reseta esses valores)
                loc_oGrd.Column1.Width = 110
                loc_oGrd.Column2.Width = 408
                loc_oGrd.Column3.Width = 40
                loc_oGrd.Column4.Width = 70
                loc_oGrd.Column5.Width = 150
                loc_oGrd.Column6.Width = 100
                loc_oGrd.Column7.Width = 16
                loc_oGrd.Column1.Header1.Caption = "Produto"
                loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrd.Column3.Header1.Caption = "Grupo"
                loc_oGrd.Column4.Header1.Caption = "Subgrp."
                loc_oGrd.Column5.Header1.Caption = "Ref. Fornecedor"
                loc_oGrd.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
                loc_oGrd.Column7.Header1.Caption = "I"

                THIS.FormatarGridLista(loc_oGrd)
                THIS.AtualizarContagemProdutos()
                loc_lResultado = .T.
            ELSE
                MsgErro(CapturarErroSQL(), "Erro ao carregar produtos")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar lista de produtos")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarFiltro - Monta clausula WHERE baseada nos filtros da tela
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarFiltro()
        LOCAL loc_cWhere, loc_cCgru, loc_dDtIni, loc_dDtFim, loc_nSitua
        loc_cWhere = ""

        TRY
            loc_cCgru  = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FilCgru.Value)
            loc_dDtIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FilDtIni.Value
            loc_dDtFim = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FilDtFim.Value
            loc_nSitua = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.obj_4c_OptFilSituas.Value

            IF !EMPTY(loc_cCgru)
                loc_cWhere = "t.cgrus = " + EscaparSQL(loc_cCgru)
            ENDIF

            IF !EMPTY(loc_dDtIni)
                IF !EMPTY(loc_cWhere)
                    loc_cWhere = loc_cWhere + " AND "
                ENDIF
                loc_cWhere = loc_cWhere + "p.datas >= " + FormatarDataSQL(loc_dDtIni)
            ENDIF

            IF !EMPTY(loc_dDtFim)
                IF !EMPTY(loc_cWhere)
                    loc_cWhere = loc_cWhere + " AND "
                ENDIF
                loc_cWhere = loc_cWhere + "p.datas <= " + FormatarDataSQL(loc_dDtFim)
            ENDIF

            IF loc_nSitua = 2
                IF !EMPTY(loc_cWhere)
                    loc_cWhere = loc_cWhere + " AND "
                ENDIF
                loc_cWhere = loc_cWhere + "p.situas = 0"
            ENDIF
            IF loc_nSitua = 3
                IF !EMPTY(loc_cWhere)
                    loc_cWhere = loc_cWhere + " AND "
                ENDIF
                loc_cWhere = loc_cWhere + "p.situas = 1"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao montar filtro")
        ENDTRY

        RETURN loc_cWhere
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid (FontName/Size)
    * RecordSource + ControlSource ja definidos em CarregarLista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            IF .ColumnCount > 0
                .FontName = "Arial"
                .FontSize = 8
            ENDIF
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarContagemProdutos - Atualiza label de contagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarContagemProdutos()
        LOCAL loc_nTotal
        loc_nTotal = 0

        TRY
            IF USED("cursor_4c_Dados")
                loc_nTotal = RECCOUNT("cursor_4c_Dados")
            ENDIF
            THIS.pgf_4c_Paginas.Page1.lbl_4c_Produtos.Caption = ;
                "Produtos Selecionados : " + TRANSFORM(loc_nTotal)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar contagem")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados do formulario para o BO
    * Fase 5: cpros/cgrus/cods mapeados para SigPrFtp
    * Campos SigCdPro (DPro2s, Cbar, Lin, Col, Ifor, Refs) serao
    * persistidos em fase futura (Phase 7) via SQL direto em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        THIS.this_oBusinessObject.this_cCpros = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
        THIS.this_oBusinessObject.this_cCgrus = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
        THIS.this_oBusinessObject.this_cCods  = ALLTRIM(loc_oPg.txt_4c_Cods.Value)
        *-- coefs/valors: sem controle visual em pgDados -> mantidos como 0 no BO
        *-- pkchaves: gerado em BtnSalvarClick, nao vem do form
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para o formulario
    * Fase 5: preenche SigPrFtp e carrega descritivos de SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        loc_oPg.txt_4c_Cpros.Value = THIS.this_oBusinessObject.this_cCpros
        loc_oPg.txt_4c_Cgrus.Value = THIS.this_oBusinessObject.this_cCgrus
        loc_oPg.txt_4c_Cods.Value  = THIS.this_oBusinessObject.this_cCods

        *-- Carregar todos os descritivos do SigCdPro vinculado
        THIS.CarregarDadosSigCdPro(THIS.this_oBusinessObject.this_cCpros)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosSigCdPro - Busca e preenche campos de exibicao do SigCdPro
    * par_cCpros: codigo do produto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDadosSigCdPro(par_cCpros)
        LOCAL loc_cSQL, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        *-- Limpar campos de exibicao (Fase 5)
        loc_oPg.txt_4c_Dpros.Value        = ""
        loc_oPg.txt_4c_DPro2s.Value       = ""
        loc_oPg.txt_4c_Cbar.Value         = ""
        loc_oPg.txt_4c_DgruDisplay.Value  = ""
        loc_oPg.txt_4c_DcodsDisplay.Value = ""
        loc_oPg.txt_4c_Lin.Value          = ""
        loc_oPg.txt_4c_DLinDisplay.Value  = ""
        loc_oPg.txt_4c_Col.Value          = ""
        loc_oPg.txt_4c_DColDisplay.Value  = ""
        loc_oPg.txt_4c_Ifor.Value         = ""
        loc_oPg.txt_4c_DforDisplay.Value  = ""
        loc_oPg.txt_4c_Refs.Value         = ""
        *-- Limpar campos de exibicao (Fase 6)
        loc_oPg.txt_4c_Cor.Value          = ""
        loc_oPg.txt_4c_Tam.Value          = ""
        loc_oPg.txt_4c_CodFinP.Value      = ""
        loc_oPg.txt_4c_DesFinP.Value      = ""
        loc_oPg.txt_4c_PesoB.Value        = 0.0
        loc_oPg.txt_4c_CodAcb.Value       = ""
        loc_oPg.txt_4c_DacbDisplay.Value  = ""
        loc_oPg.txt_4c_Pmedio.Value       = 0.0
        loc_oPg.txt_4c_Class.Value        = ""
        loc_oPg.txt_4c_DClassDisplay.Value = ""
        loc_oPg.txt_4c_Local.Value        = ""
        loc_oPg.txt_4c_Ctotal.Value       = 0.0
        loc_oPg.txt_4c_Mctotal.Value      = ""
        loc_oPg.txt_4c_Cuni.Value         = ""
        loc_oPg.txt_4c_DuniDisplay.Value  = ""
        loc_oPg.txt_4c_Cunip.Value        = ""
        loc_oPg.txt_4c_DunipDisplay.Value = ""
        loc_oPg.txt_4c_Pvenda.Value       = 0.0
        loc_oPg.txt_4c_Mpvenda.Value      = ""
        loc_oPg.txt_4c_DtIncs.Value       = {}
        loc_oPg.txt_4c_DataAlts.Value     = {}
        loc_oPg.txt_4c_CodIdent.Value     = ""
        loc_oPg.txt_4c_Fvenda.Value       = 0.0
        loc_oPg.txt_4c_Mfvenda.Value      = ""
        loc_oPg.txt_4c_UsuIncs.Value      = ""
        loc_oPg.txt_4c_UsuaAlts.Value     = ""
        loc_oPg.txt_4c_DtSituas.Value     = {}
        loc_oPg.edt_4c_DscCompras.Value   = ""
        loc_oPg.edt_4c_DPro3s.Value       = ""
        loc_oPg.edt_4c_ObsCompras.Value   = ""
        loc_oPg.chk_4c_FabrProprs.Value   = 0
        loc_oPg.chk_4c_Consig.Value       = 0
        loc_oPg.chk_4c_Encoms.Value       = 0
        *-- Limpar campos de exibicao (Fase 11 - Page5)
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.txt_4c_Qtcpnt.Value  = 0
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.chk_4c_ChkFund.Value = 0
        *-- Limpar campos de exibicao (Fase 13 - Page3 pgDadosFiscais)
        LOCAL loc_oPg3Clear
        loc_oPg3Clear = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        loc_oPg3Clear.txt_4c_Gruccus.Value    = ""
        loc_oPg3Clear.txt_4c_Dgruccus.Value   = ""
        loc_oPg3Clear.txt_4c_Contaccus.Value  = ""
        loc_oPg3Clear.txt_4c_Dcontaccus.Value = ""
        loc_oPg3Clear.txt_4c_Clfiscal.Value   = ""
        loc_oPg3Clear.txt_4c_Dclfiscal.Value  = ""
        loc_oPg3Clear.txt_4c_Origmerc.Value   = ""
        loc_oPg3Clear.txt_4c_Dorigmerc.Value  = ""
        loc_oPg3Clear.txt_4c_Sittricm.Value   = ""
        loc_oPg3Clear.txt_4c_Dsittricm.Value  = ""
        loc_oPg3Clear.txt_4c_CodServs.Value   = ""
        loc_oPg3Clear.txt_4c_Icms.Value       = 0
        loc_oPg3Clear.txt_4c_TpTrib.Value     = ""
        loc_oPg3Clear.txt_4c_Iat.Value        = ""
        loc_oPg3Clear.cbo_4c_CmbIpi.Value     = ""
        loc_oPg3Clear.txt_4c_AliqIPI.Value    = 0
        loc_oPg3Clear.txt_4c_Extipi.Value     = ""
        loc_oPg3Clear.obj_4c_Mgetdescfi.Value = ""
        loc_oPg3Clear.txt_4c_DescEcfs.Value   = ""
        loc_oPg3Clear.txt_4c_Metal.Value      = ""
        loc_oPg3Clear.txt_4c_DesMetal.Value   = ""
        loc_oPg3Clear.txt_4c_Valor.Value      = 0
        loc_oPg3Clear.txt_4c_Mvalor.Value     = ""
        loc_oPg3Clear.txt_4c_Teor.Value       = ""
        loc_oPg3Clear.txt_4c_DesTeor.Value    = ""
        loc_oPg3Clear.txt_4c_IPPTCST.Value    = ""
        *-- Limpar grid sigcdcmv
        IF USED("cursor_4c_Cmv")
            USE IN cursor_4c_Cmv
        ENDIF
        SET NULL OFF
        CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.grd_4c_Dados.Refresh()

        IF EMPTY(par_cCpros)
            RETURN
        ENDIF

        TRY
            *-- Fase 5+6: colunas corretas de SigCdPro (linhas=linha, colecoes=col.venda)
            loc_cSQL = "SELECT p.dpros, ISNULL(p.dpro2s,'') AS dpro2s, " + ;
                "ISNULL(p.cbars,'') AS cbars, " + ;
                "ISNULL(p.cgrus,'') AS cgrus, " + ;
                "ISNULL(p.linhas,'') AS linhas, " + ;
                "ISNULL(p.colecoes,'') AS colecoes, " + ;
                "ISNULL(p.ifors,'') AS ifors, ISNULL(p.reffs,'') AS reffs, " + ;
                "ISNULL(p.codcors,'') AS codcors, ISNULL(p.codtams,'') AS codtams, " + ;
                "ISNULL(p.codfinp,'') AS codfinp, ISNULL(p.codacbs,'') AS codacbs, " + ;
                "ISNULL(p.cclass,'') AS cclass, ISNULL(p.locals,'') AS locals, " + ;
                "ISNULL(p.cunis,'') AS cunis, ISNULL(p.cunips,'') AS cunips, " + ;
                "ISNULL(p.moecs,'') AS moecs, ISNULL(p.moepvs,'') AS moepvs, " + ;
                "ISNULL(p.moevs,'') AS moevs, " + ;
                "ISNULL(p.custofs,0) AS custofs, ISNULL(p.pvens,0) AS pvens, " + ;
                "ISNULL(p.fvendas,0) AS fvendas, ISNULL(p.pesobs,0) AS pesobs, " + ;
                "ISNULL(p.pcuss,0) AS pcuss, ISNULL(p.codident,'') AS codident, " + ;
                "ISNULL(p.dsccompras,'') AS dsccompras, ISNULL(p.dpro3s,'') AS dpro3s, " + ;
                "ISNULL(p.obscompras,'') AS obscompras, " + ;
                "ISNULL(p.fabrproprs,0) AS fabrproprs, ISNULL(p.consigs,0) AS consigs, " + ;
                "ISNULL(p.encoms,0) AS encoms, p.dtsituas, p.dtincs, p.dtalts, " + ;
                "ISNULL(p.usuincs,'') AS usuincs, ISNULL(p.usuaalts,'') AS usuaalts, " + ;
                "ISNULL(p.qtdcpnts,0) AS qtdcpnts, ISNULL(p.chkfunds,0) AS chkfunds, " + ;
                "ISNULL(p.gruccus,'') AS gruccus, ISNULL(p.contaccus,'') AS contaccus, " + ;
                "ISNULL(p.clfiscals,'') AS clfiscals, ISNULL(p.origmercs,'') AS origmercs, " + ;
                "ISNULL(p.sittricms,'') AS sittricms, ISNULL(p.codservs,'') AS codservs, " + ;
                "ISNULL(p.icms,0) AS icms, ISNULL(p.tptribs,'') AS tptribs, " + ;
                "ISNULL(p.iats,'') AS iats, ISNULL(p.ipis,'') AS ipis, " + ;
                "ISNULL(p.aliqipis,0) AS aliqipis, ISNULL(p.extipi,'') AS extipi, " + ;
                "ISNULL(CAST(p.descfis AS VARCHAR(8000)),'') AS descfis, " + ;
                "ISNULL(p.descecfs,'') AS descecfs, " + ;
                "ISNULL(p.metals,'') AS metals, ISNULL(p.valors,0) AS valors, " + ;
                "ISNULL(p.moedas,'') AS moedas, ISNULL(p.teors,'') AS teors " + ;
                "FROM SigCdPro p " + ;
                "WHERE p.cpros = " + EscaparSQL(par_cCpros)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdDados") > 0
                IF !EOF("cursor_4c_ProdDados")
                    SELECT cursor_4c_ProdDados
                    *-- Fase 5: campos basicos
                    loc_oPg.txt_4c_Dpros.Value   = ALLTRIM(dpros)
                    loc_oPg.txt_4c_DPro2s.Value  = ALLTRIM(dpro2s)
                    loc_oPg.txt_4c_Cbar.Value    = ALLTRIM(cbars)
                    loc_oPg.txt_4c_Cgrus.Value   = ALLTRIM(cgrus)
                    loc_oPg.txt_4c_Lin.Value     = ALLTRIM(linhas)
                    loc_oPg.txt_4c_Col.Value     = ALLTRIM(colecoes)
                    loc_oPg.txt_4c_Ifor.Value    = ALLTRIM(ifors)
                    loc_oPg.txt_4c_Refs.Value    = ALLTRIM(reffs)
                    *-- Fase 6: campos novos
                    loc_oPg.txt_4c_Cor.Value          = ALLTRIM(codcors)
                    loc_oPg.txt_4c_Tam.Value          = ALLTRIM(codtams)
                    loc_oPg.txt_4c_CodFinP.Value      = ALLTRIM(codfinp)
                    loc_oPg.txt_4c_CodAcb.Value       = ALLTRIM(codacbs)
                    loc_oPg.txt_4c_Class.Value        = ALLTRIM(cclass)
                    loc_oPg.txt_4c_Local.Value        = ALLTRIM(locals)
                    loc_oPg.txt_4c_Cuni.Value         = ALLTRIM(cunis)
                    loc_oPg.txt_4c_Cunip.Value        = ALLTRIM(cunips)
                    loc_oPg.txt_4c_Mctotal.Value      = ALLTRIM(moecs)
                    loc_oPg.txt_4c_Mpvenda.Value      = ALLTRIM(moepvs)
                    loc_oPg.txt_4c_Mfvenda.Value      = ALLTRIM(moevs)
                    loc_oPg.txt_4c_Ctotal.Value       = custofs
                    loc_oPg.txt_4c_Pvenda.Value       = pvens
                    loc_oPg.txt_4c_Fvenda.Value       = fvendas
                    loc_oPg.txt_4c_PesoB.Value        = pesobs
                    loc_oPg.txt_4c_Pmedio.Value       = pcuss
                    loc_oPg.txt_4c_CodIdent.Value     = ALLTRIM(codident)
                    loc_oPg.edt_4c_DscCompras.Value   = ALLTRIM(dsccompras)
                    loc_oPg.edt_4c_DPro3s.Value       = ALLTRIM(dpro3s)
                    loc_oPg.edt_4c_ObsCompras.Value   = ALLTRIM(obscompras)
                    loc_oPg.chk_4c_FabrProprs.Value   = (NVL(fabrproprs, .F.) = .T.)
                    loc_oPg.chk_4c_Consig.Value       = (NVL(consigs, .F.) = .T.)
                    loc_oPg.chk_4c_Encoms.Value       = (NVL(encoms, .F.) = .T.)
                    loc_oPg.txt_4c_UsuIncs.Value      = ALLTRIM(usuincs)
                    loc_oPg.txt_4c_UsuaAlts.Value     = ALLTRIM(usuaalts)
                    *-- Datas (podem ser NULL)
                    IF !ISNULL(dtsituas)
                        loc_oPg.txt_4c_DtSituas.Value = TTOD(dtsituas)
                    ENDIF
                    IF !ISNULL(dtincs)
                        loc_oPg.txt_4c_DtIncs.Value   = TTOD(dtincs)
                    ENDIF
                    IF !ISNULL(dtalts)
                        loc_oPg.txt_4c_DataAlts.Value = TTOD(dtalts)
                    ENDIF

                    *-- Fase 11: Page5 (PgDadosConsP) - qtdcpnts e chkfunds
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.txt_4c_Qtcpnt.Value  = NVL(qtdcpnts, 0)
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.chk_4c_ChkFund.Value = (IIF(VARTYPE(chkfunds) = "L", chkfunds, (NVL(chkfunds, 0) = 1)))

                    *-- Fase 13: Page3 (pgDadosFiscais)
                    LOCAL loc_oPg3
                    loc_oPg3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
                    loc_oPg3.txt_4c_Gruccus.Value    = ALLTRIM(gruccus)
                    loc_oPg3.txt_4c_Contaccus.Value  = ALLTRIM(contaccus)
                    loc_oPg3.txt_4c_Clfiscal.Value   = ALLTRIM(clfiscals)
                    loc_oPg3.txt_4c_Origmerc.Value   = ALLTRIM(origmercs)
                    loc_oPg3.txt_4c_Sittricm.Value   = ALLTRIM(sittricms)
                    loc_oPg3.txt_4c_CodServs.Value   = ALLTRIM(codservs)
                    loc_oPg3.txt_4c_Icms.Value       = icms
                    loc_oPg3.txt_4c_TpTrib.Value     = ALLTRIM(tptribs)
                    loc_oPg3.txt_4c_Iat.Value        = ALLTRIM(iats)
                    *-- ComboBox ipis: converter char(1) para item de texto
                    LOCAL loc_cIpiTxt
                    DO CASE
                    CASE UPPER(ALLTRIM(ipis)) = "T"
                        loc_cIpiTxt = "Tributado"
                    CASE UPPER(ALLTRIM(ipis)) = "I"
                        loc_cIpiTxt = "Isento"
                    CASE UPPER(ALLTRIM(ipis)) = "O"
                        loc_cIpiTxt = "Outros"
                    OTHERWISE
                        loc_cIpiTxt = ""
                    ENDCASE
                    loc_oPg3.cbo_4c_CmbIpi.Value     = loc_cIpiTxt
                    loc_oPg3.txt_4c_AliqIPI.Value    = aliqipis
                    loc_oPg3.txt_4c_Extipi.Value     = ALLTRIM(extipi)
                    loc_oPg3.obj_4c_Mgetdescfi.Value = ALLTRIM(descfis)
                    loc_oPg3.txt_4c_DescEcfs.Value   = ALLTRIM(descecfs)
                    loc_oPg3.txt_4c_Metal.Value      = ALLTRIM(metals)
                    loc_oPg3.txt_4c_Valor.Value      = valors
                    loc_oPg3.txt_4c_Mvalor.Value     = ALLTRIM(moedas)
                    loc_oPg3.txt_4c_Teor.Value       = ALLTRIM(teors)
                    loc_oPg3.txt_4c_IPPTCST.Value    = ""
                    *-- Carregar descricoes de lookup da Fase 13
                    THIS.CarregarDescFiscais(par_cCpros, ALLTRIM(gruccus), ;
                        ALLTRIM(contaccus), ALLTRIM(clfiscals), ALLTRIM(origmercs), ;
                        ALLTRIM(sittricms), ALLTRIM(metals), ALLTRIM(teors))

                    *-- Carregar descricoes de tabelas vinculadas
                    THIS.CarregarDescGrupo(ALLTRIM(cgrus))
                    THIS.CarregarDescLin(ALLTRIM(linhas))
                    THIS.CarregarDescIfor(ALLTRIM(ifors))
                    THIS.CarregarDescCor(ALLTRIM(codcors))
                    THIS.CarregarDescTam(ALLTRIM(codtams))
                    THIS.CarregarDescFinP(ALLTRIM(codfinp))
                    THIS.CarregarDescAcb(ALLTRIM(codacbs))
                    THIS.CarregarDescClass(ALLTRIM(cclass))
                    THIS.CarregarDescLocal(ALLTRIM(locals))
                    THIS.CarregarDescUni(ALLTRIM(cunis), "uni")
                    THIS.CarregarDescUni(ALLTRIM(cunips), "unip")
                    THIS.CarregarDescMoe(ALLTRIM(moecs), "total")
                    THIS.CarregarDescMoe(ALLTRIM(moepvs), "pvenda")
                    THIS.CarregarDescMoe(ALLTRIM(moevs), "fvenda")
                ENDIF
                IF USED("cursor_4c_ProdDados")
                    USE IN cursor_4c_ProdDados
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar dados do produto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarDescricaoProduto - Compatibilidade: delega para CarregarDadosSigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarDescricaoProduto(par_cCpros)
        THIS.CarregarDadosSigCdPro(par_cCpros)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescGrupo - Carrega descricao do grupo (SigCdGrp)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescGrupo(par_cCgrus)
        LOCAL loc_cSQL, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF EMPTY(par_cCgrus)
            loc_oPg.txt_4c_DgruDisplay.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCgrus)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGru") > 0
                IF !EOF("cursor_4c_DescGru")
                    SELECT cursor_4c_DescGru
                    loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
                ELSE
                    loc_oPg.txt_4c_DgruDisplay.Value = ""
                ENDIF
                IF USED("cursor_4c_DescGru")
                    USE IN cursor_4c_DescGru
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescCods - Carrega descricao do subgrupo (via SigCdGrp ou tabela propria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescCods(par_cCods)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF EMPTY(par_cCods)
            loc_oPg.txt_4c_DcodsDisplay.Value = ""
            RETURN
        ENDIF

        *-- Placeholder: descricao do subgrupo sera implementada na Fase 7
        loc_oPg.txt_4c_DcodsDisplay.Value = par_cCods
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescLin - Carrega descricao da linha (SigCdLin, PK=linhas, desc=descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescLin(par_cLinhas)
        LOCAL loc_cSQL, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF EMPTY(par_cLinhas)
            loc_oPg.txt_4c_DLinDisplay.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(par_cLinhas)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLin") > 0
                IF !EOF("cursor_4c_DescLin")
                    SELECT cursor_4c_DescLin
                    loc_oPg.txt_4c_DLinDisplay.Value = ALLTRIM(descs)
                ELSE
                    loc_oPg.txt_4c_DLinDisplay.Value = ""
                ENDIF
                IF USED("cursor_4c_DescLin")
                    USE IN cursor_4c_DescLin
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar linha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescCol - Exibe colecoes (campo texto direto em SigCdPro)
    * Nota: nao existe tabela SigCdCol no banco; colecoes e campo texto livre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescCol(par_cColecoes)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        *-- Colecoes nao tem tabela de descricao - exibir o proprio valor
        loc_oPg.txt_4c_DColDisplay.Value = par_cColecoes
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescIfor - Carrega nome do fornecedor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescIfor(par_cIfors)
        LOCAL loc_cSQL, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF EMPTY(par_cIfors)
            loc_oPg.txt_4c_DforDisplay.Value = ""
            RETURN
        ENDIF

        TRY
            *-- Fornecedor buscado via SigCdCli (ou tabela de fornecedores)
            loc_cSQL = "SELECT Rclis AS dfors FROM SigCdCli WHERE Iclis = " + EscaparSQL(par_cIfors)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescIfor") > 0
                IF !EOF("cursor_4c_DescIfor")
                    SELECT cursor_4c_DescIfor
                    loc_oPg.txt_4c_DforDisplay.Value = ALLTRIM(dfors)
                ELSE
                    loc_oPg.txt_4c_DforDisplay.Value = ""
                ENDIF
                IF USED("cursor_4c_DescIfor")
                    USE IN cursor_4c_DescIfor
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescCor - Carrega descricao da cor (SigCdCor, PK=cods, desc=descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescCor(par_cCodCor)
        LOCAL loc_cSQL, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF EMPTY(par_cCodCor)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT descs FROM SigCdCor WHERE cods = " + EscaparSQL(par_cCodCor)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCor") > 0
                IF !EOF("cursor_4c_DescCor")
                    SELECT cursor_4c_DescCor
                    loc_oPg.txt_4c_Cor.ToolTipText = ALLTRIM(descs)
                ENDIF
                IF USED("cursor_4c_DescCor")
                    USE IN cursor_4c_DescCor
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar cor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescTam - Carrega descricao do tamanho (SigCdTam, PK=cods, desc=descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescTam(par_cCodTam)
        LOCAL loc_cSQL, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF EMPTY(par_cCodTam)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT descs FROM SigCdTam WHERE cods = " + EscaparSQL(par_cCodTam)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTam") > 0
                IF !EOF("cursor_4c_DescTam")
                    SELECT cursor_4c_DescTam
                    loc_oPg.txt_4c_Tam.ToolTipText = ALLTRIM(descs)
                ENDIF
                IF USED("cursor_4c_DescTam")
                    USE IN cursor_4c_DescTam
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar tamanho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescFinP - Carrega descricao da ficha (SigCdFip, PK=cods, desc=descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescFinP(par_cCodFinP)
        LOCAL loc_cSQL, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF EMPTY(par_cCodFinP)
            loc_oPg.txt_4c_DesFinP.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(par_cCodFinP)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFinP") > 0
                IF !EOF("cursor_4c_DescFinP")
                    SELECT cursor_4c_DescFinP
                    loc_oPg.txt_4c_DesFinP.Value = ALLTRIM(descs)
                ELSE
                    loc_oPg.txt_4c_DesFinP.Value = ""
                ENDIF
                IF USED("cursor_4c_DescFinP")
                    USE IN cursor_4c_DescFinP
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar ficha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescAcb - Carrega descricao do acabamento (SigCdAca, PK=cods, desc=descrs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescAcb(par_cCodAcb)
        LOCAL loc_cSQL, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF EMPTY(par_cCodAcb)
            loc_oPg.txt_4c_DacbDisplay.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(par_cCodAcb)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescAcb") > 0
                IF !EOF("cursor_4c_DescAcb")
                    SELECT cursor_4c_DescAcb
                    loc_oPg.txt_4c_DacbDisplay.Value = ALLTRIM(descrs)
                ELSE
                    loc_oPg.txt_4c_DacbDisplay.Value = ""
                ENDIF
                IF USED("cursor_4c_DescAcb")
                    USE IN cursor_4c_DescAcb
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescClass - Carrega descricao da classificacao (SIGCDCLS, PK=cods, desc=descs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescClass(par_cCclass)
        LOCAL loc_cSQL, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF EMPTY(par_cCclass)
            loc_oPg.txt_4c_DClassDisplay.Value = ""
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT descs FROM SIGCDCLS WHERE cods = " + EscaparSQL(par_cCclass)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescClass") > 0
                IF !EOF("cursor_4c_DescClass")
                    SELECT cursor_4c_DescClass
                    loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
                ELSE
                    loc_oPg.txt_4c_DClassDisplay.Value = ""
                ENDIF
                IF USED("cursor_4c_DescClass")
                    USE IN cursor_4c_DescClass
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescLocal - Carrega descricao do local (SigPrLcl, PK=codigos, desc=descricaos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescLocal(par_cLocals)
        LOCAL loc_cSQL, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF EMPTY(par_cLocals)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(par_cLocals)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLocal") > 0
                IF !EOF("cursor_4c_DescLocal")
                    SELECT cursor_4c_DescLocal
                    loc_oPg.txt_4c_Local.ToolTipText = ALLTRIM(descricaos)
                ENDIF
                IF USED("cursor_4c_DescLocal")
                    USE IN cursor_4c_DescLocal
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar local")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescUni - Carrega descricao da unidade (SigCdUni, PK=cunis, desc=dunis)
    * par_cTipo: "uni" = unidade principal, "unip" = unidade de pedido
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescUni(par_cCunis, par_cTipo)
        LOCAL loc_cSQL, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF EMPTY(par_cCunis)
            IF par_cTipo = "uni"
                loc_oPg.txt_4c_DuniDisplay.Value  = ""
            ELSE
                loc_oPg.txt_4c_DunipDisplay.Value = ""
            ENDIF
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(par_cCunis)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescUni") > 0
                IF !EOF("cursor_4c_DescUni")
                    SELECT cursor_4c_DescUni
                    IF par_cTipo = "uni"
                        loc_oPg.txt_4c_DuniDisplay.Value  = ALLTRIM(dunis)
                    ELSE
                        loc_oPg.txt_4c_DunipDisplay.Value = ALLTRIM(dunis)
                    ENDIF
                ELSE
                    IF par_cTipo = "uni"
                        loc_oPg.txt_4c_DuniDisplay.Value  = ""
                    ELSE
                        loc_oPg.txt_4c_DunipDisplay.Value = ""
                    ENDIF
                ENDIF
                IF USED("cursor_4c_DescUni")
                    USE IN cursor_4c_DescUni
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar unidade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescMoe - Carrega descricao da moeda (SigCdMoe, PK=cmoes, desc=dmoes)
    * par_cTipo: "total" | "pvenda" | "fvenda"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescMoe(par_cCmoes, par_cTipo)
        LOCAL loc_cSQL, loc_oPg, loc_cDesc
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cDesc = ""
        IF EMPTY(par_cCmoes)
            RETURN
        ENDIF
        TRY
            loc_cSQL = "SELECT dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCmoes)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescMoe") > 0
                IF !EOF("cursor_4c_DescMoe")
                    SELECT cursor_4c_DescMoe
                    loc_cDesc = ALLTRIM(dmoes)
                ENDIF
                IF USED("cursor_4c_DescMoe")
                    USE IN cursor_4c_DescMoe
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
        ENDTRY
        DO CASE
        CASE par_cTipo = "total"
            loc_oPg.txt_4c_Mctotal.ToolTipText = loc_cDesc
        CASE par_cTipo = "pvenda"
            loc_oPg.txt_4c_Mpvenda.ToolTipText = loc_cDesc
        CASE par_cTipo = "fvenda"
            loc_oPg.txt_4c_Mfvenda.ToolTipText = loc_cDesc
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescFiscais - Carrega descricoes e historico CMV da Fase 13
    * par_cCpros: codigo produto; demais: codigos para lookup de descricoes
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDescFiscais(par_cCpros, par_cGruccus, par_cContaccus, ;
                                             par_cClfiscals, par_cOrigmercs, par_cSittricms, ;
                                             par_cMetals, par_cTeors)
        LOCAL loc_oPg3, loc_cSQL, loc_cDesc
        loc_oPg3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3

        TRY
            *-- Grupo CC (SigCdGcr)
            IF !EMPTY(par_cGruccus)
                loc_cSQL = "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(par_cGruccus)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
                    loc_oPg3.txt_4c_Dgruccus.Value = ALLTRIM(cursor_4c_DescFisc.descrs)
                ENDIF
                IF USED("cursor_4c_DescFisc")
                    USE IN cursor_4c_DescFisc
                ENDIF
            ENDIF

            *-- Conta CC (SigCdCli)
            IF !EMPTY(par_cContaccus)
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cContaccus)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
                    loc_oPg3.txt_4c_Dcontaccus.Value = ALLTRIM(cursor_4c_DescFisc.Rclis)
                ENDIF
                IF USED("cursor_4c_DescFisc")
                    USE IN cursor_4c_DescFisc
                ENDIF
            ENDIF

            *-- Classificacao Fiscal (SigCdClf)
            IF !EMPTY(par_cClfiscals)
                loc_cSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(par_cClfiscals)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
                    loc_oPg3.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_DescFisc.Descricaos)
                ENDIF
                IF USED("cursor_4c_DescFisc")
                    USE IN cursor_4c_DescFisc
                ENDIF
            ENDIF

            *-- Origem da Mercadoria (SigCdOrg)
            IF !EMPTY(par_cOrigmercs)
                loc_cSQL = "SELECT Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(par_cOrigmercs)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
                    loc_oPg3.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_DescFisc.Descricaos)
                ENDIF
                IF USED("cursor_4c_DescFisc")
                    USE IN cursor_4c_DescFisc
                ENDIF
            ENDIF

            *-- Situacao Tributaria ICMS (SigCdIcm)
            IF !EMPTY(par_cSittricms)
                loc_cSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(par_cSittricms)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
                    loc_oPg3.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_DescFisc.Descricaos)
                ENDIF
                IF USED("cursor_4c_DescFisc")
                    USE IN cursor_4c_DescFisc
                ENDIF
            ENDIF

            *-- Metal (TmpMTal - cursor carregado em runtime)
            IF !EMPTY(par_cMetals) AND USED("TmpMTal")
                SELECT TmpMTal
                LOCATE FOR ALLTRIM(TmpMTal.Metals) == par_cMetals
                IF FOUND()
                    loc_oPg3.txt_4c_DesMetal.Value = ALLTRIM(TmpMTal.DesMetals)
                ENDIF
            ENDIF

            *-- Teor (TmpTeor - cursor carregado em runtime)
            IF !EMPTY(par_cTeors) AND USED("TmpTeor")
                SELECT TmpTeor
                LOCATE FOR ALLTRIM(TmpTeor.Teors) == par_cTeors
                IF FOUND()
                    loc_oPg3.txt_4c_DesTeor.Value = ALLTRIM(TmpTeor.DesTeors)
                ENDIF
            ENDIF

            *-- Carregar historico CMV (sigcdcmv)
            IF !EMPTY(par_cCpros)
                loc_cSQL = "SELECT datas, valcuss, moedas FROM sigcdcmv " + ;
                           "WHERE cpros = " + EscaparSQL(par_cCpros) + " ORDER BY datas DESC"
                IF USED("cursor_4c_Cmv")
                    USE IN cursor_4c_Cmv
                ENDIF
                SET NULL OFF
                CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp") > 0
                    IF !EOF("cursor_4c_CmvTemp")
                        SELECT cursor_4c_CmvTemp
                        GO TOP
                        SCAN
                            LOCAL loc_cDatas, loc_nValcuss, loc_cMoedas
                            loc_cDatas   = ALLTRIM(cursor_4c_CmvTemp.datas)
                            loc_nValcuss = cursor_4c_CmvTemp.valcuss
                            loc_cMoedas  = ALLTRIM(cursor_4c_CmvTemp.moedas)
                            INSERT INTO cursor_4c_Cmv (datas, valcuss, moedas) ;
                                VALUES (loc_cDatas, loc_nValcuss, loc_cMoedas)
                        ENDSCAN
                    ENDIF
                    IF USED("cursor_4c_CmvTemp")
                        USE IN cursor_4c_CmvTemp
                    ENDIF
                ENDIF
                SELECT cursor_4c_Cmv
                IF RECCOUNT() > 0
                    GO TOP
                ENDIF
                loc_oPg3.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar dados fiscais")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos editaveis conforme modo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lReadOnly, loc_cBgEdit, loc_cBgRO
        loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_lReadOnly = !par_lHabilitar
        loc_cBgEdit  = RGB(255, 255, 255)
        loc_cBgRO    = RGB(224, 235, 235)

        TRY
            *-- Fase 5: Campos editaveis basicos
            loc_oPg.txt_4c_Cpros.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Cpros.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_DPro2s.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_DPro2s.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Cbar.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Cbar.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Cgrus.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Cgrus.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Cods.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Cods.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Lin.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Lin.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Col.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Col.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Ifor.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Ifor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Refs.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Refs.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            *-- Fase 6: Novos campos editaveis
            loc_oPg.txt_4c_Cor.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Cor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Tam.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Tam.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_CodFinP.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_CodFinP.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_PesoB.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_PesoB.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_CodAcb.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_CodAcb.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Class.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Class.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Local.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Local.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Cuni.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Cuni.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Cunip.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Cunip.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Mctotal.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Mctotal.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Pvenda.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Pvenda.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Mpvenda.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Mpvenda.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_CodIdent.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_CodIdent.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Fvenda.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Fvenda.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.txt_4c_Mfvenda.ReadOnly  = loc_lReadOnly
            loc_oPg.txt_4c_Mfvenda.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.edt_4c_DscCompras.ReadOnly  = loc_lReadOnly
            loc_oPg.edt_4c_DscCompras.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.edt_4c_DPro3s.ReadOnly  = loc_lReadOnly
            loc_oPg.edt_4c_DPro3s.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.edt_4c_ObsCompras.ReadOnly  = loc_lReadOnly
            loc_oPg.edt_4c_ObsCompras.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg.chk_4c_FabrProprs.Enabled = par_lHabilitar
            loc_oPg.chk_4c_Consig.Enabled     = par_lHabilitar
            loc_oPg.chk_4c_Encoms.Enabled     = par_lHabilitar

            *-- Fase 13: Campos editaveis de pgDadosFiscais (Page3)
            LOCAL loc_oPg3H
            loc_oPg3H = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3

            loc_oPg3H.txt_4c_Gruccus.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Gruccus.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_Contaccus.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Contaccus.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_Clfiscal.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Clfiscal.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_Origmerc.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Origmerc.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_Sittricm.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Sittricm.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_CodServs.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_CodServs.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_Icms.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Icms.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_TpTrib.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_TpTrib.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_Iat.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Iat.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.cbo_4c_CmbIpi.Enabled = par_lHabilitar

            loc_oPg3H.txt_4c_AliqIPI.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_AliqIPI.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_Extipi.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Extipi.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.obj_4c_Mgetdescfi.ReadOnly  = loc_lReadOnly
            loc_oPg3H.obj_4c_Mgetdescfi.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_DescEcfs.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_DescEcfs.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_Metal.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Metal.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_Valor.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Valor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_Mvalor.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Mvalor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.txt_4c_Teor.ReadOnly  = loc_lReadOnly
            loc_oPg3H.txt_4c_Teor.BackColor = IIF(par_lHabilitar, loc_cBgEdit, loc_cBgRO)

            loc_oPg3H.cmd_4c_BtnDescFis.Enabled = par_lHabilitar

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao habilitar campos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa todos os campos da aba pgDados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        TRY
            *-- Linha 1: Produto
            loc_oPg.txt_4c_Cpros.Value        = ""
            loc_oPg.txt_4c_Dpros.Value        = ""
            *-- Linha 2: Descritivo 2 + Barra
            loc_oPg.txt_4c_DPro2s.Value       = ""
            loc_oPg.txt_4c_Cbar.Value         = ""
            *-- Linha 3: Grupo
            loc_oPg.txt_4c_Cgrus.Value        = ""
            loc_oPg.txt_4c_DgruDisplay.Value  = ""
            *-- Linha 4: Subgrupo
            loc_oPg.txt_4c_Cods.Value         = ""
            loc_oPg.txt_4c_DcodsDisplay.Value = ""
            *-- Linha 5: Linha
            loc_oPg.txt_4c_Lin.Value          = ""
            loc_oPg.txt_4c_DLinDisplay.Value  = ""
            *-- Linha 6: Colecao/Venda
            loc_oPg.txt_4c_Col.Value          = ""
            loc_oPg.txt_4c_DColDisplay.Value  = ""
            *-- Linha 7: Fornecedor
            loc_oPg.txt_4c_Ifor.Value         = ""
            loc_oPg.txt_4c_DforDisplay.Value  = ""
            *-- Linha 8: Ref. Fornecedor + Cor + Tamanho
            loc_oPg.txt_4c_Refs.Value         = ""
            loc_oPg.txt_4c_Cor.Value          = ""
            loc_oPg.txt_4c_Tam.Value          = ""
            *-- Linha 9: Ficha + Peso Base
            loc_oPg.txt_4c_CodFinP.Value      = ""
            loc_oPg.txt_4c_DesFinP.Value      = ""
            loc_oPg.txt_4c_PesoB.Value        = 0.0
            *-- Linha 10: Acabamento + Preco Medio
            loc_oPg.txt_4c_CodAcb.Value       = ""
            loc_oPg.txt_4c_DacbDisplay.Value  = ""
            loc_oPg.txt_4c_Pmedio.Value       = 0.0
            *-- Linha 11: Classificacao + Local
            loc_oPg.txt_4c_Class.Value         = ""
            loc_oPg.txt_4c_DClassDisplay.Value = ""
            loc_oPg.txt_4c_Local.Value         = ""
            *-- Linha 11b: Custo + Moeda
            loc_oPg.txt_4c_Ctotal.Value        = 0.0
            loc_oPg.txt_4c_Mctotal.Value       = ""
            *-- Linha 12: Unidade + Uni.Pedido
            loc_oPg.txt_4c_Cuni.Value          = ""
            loc_oPg.txt_4c_DuniDisplay.Value   = ""
            loc_oPg.txt_4c_Cunip.Value         = ""
            loc_oPg.txt_4c_DunipDisplay.Value  = ""
            *-- Linha 12b: P.Venda + Moeda + Datas
            loc_oPg.txt_4c_Pvenda.Value        = 0.0
            loc_oPg.txt_4c_Mpvenda.Value       = ""
            loc_oPg.txt_4c_DtIncs.Value        = {}
            loc_oPg.txt_4c_DataAlts.Value      = {}
            *-- Linha 13: CodIdent + F.Venda + Moeda + Usuarios
            loc_oPg.txt_4c_CodIdent.Value      = ""
            loc_oPg.txt_4c_Fvenda.Value        = 0.0
            loc_oPg.txt_4c_Mfvenda.Value       = ""
            loc_oPg.txt_4c_UsuIncs.Value       = ""
            loc_oPg.txt_4c_UsuaAlts.Value      = ""
            *-- Linha 14: Descr.Compras + Checkboxes
            loc_oPg.edt_4c_DscCompras.Value    = ""
            loc_oPg.chk_4c_FabrProprs.Value    = 0
            loc_oPg.chk_4c_Consig.Value        = 0
            loc_oPg.chk_4c_Encoms.Value        = 0
            *-- Linha 15: 3a Descricao
            loc_oPg.edt_4c_DPro3s.Value        = ""
            *-- Linha 16: Obs. Compras
            loc_oPg.edt_4c_ObsCompras.Value    = ""
            *-- Top area direito: Dt.Situacao
            loc_oPg.txt_4c_DtSituas.Value      = {}
            *-- Fase 13: pgDadosFiscais (Page3)
            LOCAL loc_oPg3L
            loc_oPg3L = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_oPg3L.txt_4c_Gruccus.Value    = ""
            loc_oPg3L.txt_4c_Dgruccus.Value   = ""
            loc_oPg3L.txt_4c_Contaccus.Value  = ""
            loc_oPg3L.txt_4c_Dcontaccus.Value = ""
            loc_oPg3L.txt_4c_Clfiscal.Value   = ""
            loc_oPg3L.txt_4c_Dclfiscal.Value  = ""
            loc_oPg3L.txt_4c_Origmerc.Value   = ""
            loc_oPg3L.txt_4c_Dorigmerc.Value  = ""
            loc_oPg3L.txt_4c_Sittricm.Value   = ""
            loc_oPg3L.txt_4c_Dsittricm.Value  = ""
            loc_oPg3L.txt_4c_CodServs.Value   = ""
            loc_oPg3L.txt_4c_Icms.Value       = 0
            loc_oPg3L.txt_4c_TpTrib.Value     = ""
            loc_oPg3L.txt_4c_Iat.Value        = ""
            loc_oPg3L.cbo_4c_CmbIpi.Value     = ""
            loc_oPg3L.txt_4c_AliqIPI.Value    = 0
            loc_oPg3L.txt_4c_Extipi.Value     = ""
            loc_oPg3L.obj_4c_Mgetdescfi.Value = ""
            loc_oPg3L.txt_4c_DescEcfs.Value   = ""
            loc_oPg3L.txt_4c_Metal.Value      = ""
            loc_oPg3L.txt_4c_DesMetal.Value   = ""
            loc_oPg3L.txt_4c_Valor.Value      = 0
            loc_oPg3L.txt_4c_Mvalor.Value     = ""
            loc_oPg3L.txt_4c_Teor.Value       = ""
            loc_oPg3L.txt_4c_DesTeor.Value    = ""
            loc_oPg3L.txt_4c_IPPTCST.Value    = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar campos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lTemRegistro
        loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
        loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")

        TRY
            loc_oCnt.cmd_4c_Incluir.Enabled    = .T.
            loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
            loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
            loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
            loc_oCnt.cmd_4c_Procurar.Enabled   = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao ajustar bot" + CHR(245) + "es")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE BOTOES CRUD
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Acao do botao Incluir
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Cpros.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Acao do botao Visualizar
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.BOParaForm()
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.HabilitarCampos(.F.)
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar registro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Acao do botao Alterar
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)

        TRY
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.BOParaForm()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.HabilitarCampos(.T.)
                THIS.AlternarPagina(2)
                THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.txt_4c_Cpros.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao alterar registro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Acao do botao Excluir
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.")
            RETURN
        ENDIF

        loc_cChave = ALLTRIM(cursor_4c_Dados.pkchaves)

        TRY
            IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
                "Excluir Produto")
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Exclu" + CHR(237) + "do")
                        THIS.CarregarLista()
                        THIS.AjustarBotoesPorModo()
                    ELSE
                        MsgErro("Erro ao excluir registro.", "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir registro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcurarClick - Acao do botao Procurar (busca e seleciona produto na lista)
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcurarClick()
        LOCAL loc_oBusca, loc_cCpros

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
            loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("cgrus", "", "Grupo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    loc_cCpros = ALLTRIM(cpros)
                    USE IN cursor_4c_Busca
                ENDIF

                *-- Posiciona grid na linha do produto selecionado
                IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    LOCATE FOR ALLTRIM(cpros) = loc_cCpros
                    THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao procurar produto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Acao do botao Salvar
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg

        *-- Validar campos obrigatorios
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cpros.Value))
            MsgAviso("Campo Produto " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Cpros.SetFocus()
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cgrus.Value))
            MsgAviso("Campo Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
            loc_oPg.txt_4c_Cgrus.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_cModoAtual = "INCLUIR"
                *-- Gerar pkchaves: char(20), unica
                THIS.this_oBusinessObject.this_cPkchaves = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
            ENDIF

            IF THIS.this_oBusinessObject.Salvar()
                THIS.AtualizarSigCdPro()
                MsgInfo("Registro salvo com sucesso.", "Salvo")
                THIS.AlternarPagina(1)
            ELSE
                MsgErro("Erro ao salvar registro.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao salvar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Acao do botao Cancelar
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_oBusinessObject.CancelarEdicao()
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - Acao do botao Sair
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * HANDLERS DE FILTROS
    *==========================================================================

    *--------------------------------------------------------------------------
    * FiltroSituacaoChange - Disparado quando muda opcao de situacao no filtro
    *--------------------------------------------------------------------------
    PROCEDURE FiltroSituacaoChange()
        IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DE KEYPRESS (ENTER/TAB/F4 disparam lookup)
    *==========================================================================

    *--------------------------------------------------------------------------
    * TxtFilCgruKeyPress - KeyPress no filtro de grupo (ENTER/TAB carrega lista)
    *--------------------------------------------------------------------------
    PROCEDURE TxtFilCgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCprosKeyPress - KeyPress no campo Cpros (ENTER/F4 abre lookup SigCdPro)
    *--------------------------------------------------------------------------
    PROCEDURE TxtCprosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            *-- Validar produto ao sair
            THIS.ValidarCpros()
        ENDIF
        IF par_nKeyCode = 115
            *-- F4 = 115 -> abrir lookup
            THIS.AbrirLookupProduto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCgrusKeyPress - KeyPress no campo Cgrus (ENTER/F4 abre lookup de grupo)
    *--------------------------------------------------------------------------
    PROCEDURE TxtCgrusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCgrus()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupGrupo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtLinKeyPress - KeyPress no campo Lin (ENTER/F4 abre lookup SigCdLin)
    *--------------------------------------------------------------------------
    PROCEDURE TxtLinKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarLin()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupLin()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtColKeyPress - KeyPress no campo Col (ENTER/F4 abre lookup SigCdCol)
    *--------------------------------------------------------------------------
    PROCEDURE TxtColKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCol()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupCol()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtIforKeyPress - KeyPress no campo Ifor (ENTER/F4 abre lookup fornecedor)
    *--------------------------------------------------------------------------
    PROCEDURE TxtIforKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarIfor()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupIfor()
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDACOES
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCpros - Valida campo cpros e carrega todos os dados do SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCpros()
        LOCAL loc_cCpros, loc_cSQL, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCpros = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        IF EMPTY(loc_cCpros)
            THIS.CarregarDadosSigCdPro("")
            RETURN
        ENDIF

        TRY
            *-- Verificar se produto existe antes de carregar todos os dados
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro") > 0
                SELECT cursor_4c_ValPro
                IF nExiste > 0
                    IF USED("cursor_4c_ValPro")
                        USE IN cursor_4c_ValPro
                    ENDIF
                    THIS.CarregarDadosSigCdPro(loc_cCpros)
                ELSE
                    IF USED("cursor_4c_ValPro")
                        USE IN cursor_4c_ValPro
                    ENDIF
                    THIS.CarregarDadosSigCdPro("")
                    MsgAviso("Produto " + loc_cCpros + " n" + CHR(227) + "o encontrado.", "Produto Inv" + CHR(225) + "lido")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar produto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCgrus - Valida campo cgrus e carrega descricao do grupo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCgrus()
        LOCAL loc_cCgrus, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCgrus = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        THIS.CarregarDescGrupo(loc_cCgrus)

        IF !EMPTY(loc_cCgrus) AND EMPTY(loc_oPg.txt_4c_DgruDisplay.Value)
            MsgAviso("Grupo " + loc_cCgrus + " n" + CHR(227) + "o encontrado.", "Grupo Inv" + CHR(225) + "lido")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLin - Valida campo lin e carrega descricao da linha (SigCdLin)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarLin()
        LOCAL loc_cClins, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cClins = ALLTRIM(loc_oPg.txt_4c_Lin.Value)

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        THIS.CarregarDescLin(loc_cClins)

        IF !EMPTY(loc_cClins) AND EMPTY(loc_oPg.txt_4c_DLinDisplay.Value)
            MsgAviso("Linha " + loc_cClins + " n" + CHR(227) + "o encontrada.", "Linha Inv" + CHR(225) + "lida")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCol - Valida campo col e carrega descricao do grupo de venda (SigCdCol)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCol()
        LOCAL loc_cCcols, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCcols = ALLTRIM(loc_oPg.txt_4c_Col.Value)

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        THIS.CarregarDescCol(loc_cCcols)

        IF !EMPTY(loc_cCcols) AND EMPTY(loc_oPg.txt_4c_DColDisplay.Value)
            MsgAviso("Grupo de venda " + loc_cCcols + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarIfor - Valida campo ifor e carrega nome do fornecedor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarIfor()
        LOCAL loc_cIfors, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cIfors = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        THIS.CarregarDescIfor(loc_cIfors)

        IF !EMPTY(loc_cIfors) AND EMPTY(loc_oPg.txt_4c_DforDisplay.Value)
            MsgAviso("Fornecedor " + loc_cIfors + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
        ENDIF
    ENDPROC

    *==========================================================================
    * LOOKUPS (FormBuscaAuxiliar)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirLookupProduto - Abre busca de produto (SigCdPro)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupProduto()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", "cursor_4c_Busca", "cpros", "", "Busca de Produto")
            loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("cgrus", "", "Grupo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    loc_oPg.txt_4c_Cpros.Value = ALLTRIM(cpros)
                    loc_oPg.txt_4c_Dpros.Value = ALLTRIM(dpros)
                    USE IN cursor_4c_Busca
                ENDIF
            ENDIF

            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de produto")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGrupo - Abre busca de grupo (SigCdGrp)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGrupo()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", "cursor_4c_Busca", "cgrus", "", "Busca de Grupo")
            loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    loc_oPg.txt_4c_Cgrus.Value       = ALLTRIM(cgrus)
                    loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
                    USE IN cursor_4c_Busca
                ENDIF
            ENDIF

            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupLin - Abre busca de linha (SigCdLin)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupLin()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdLin", "cursor_4c_Busca", "clins", "", "Busca de Linha")
            loc_oBusca.mAddColuna("clins", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dlins", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    loc_oPg.txt_4c_Lin.Value          = ALLTRIM(clins)
                    loc_oPg.txt_4c_DLinDisplay.Value  = ALLTRIM(dlins)
                    USE IN cursor_4c_Busca
                ENDIF
            ENDIF

            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de linha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCol - Abre busca de grupo de venda (SigCdCol)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCol()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCol", "cursor_4c_Busca", "ccols", "", "Busca de Grupo de Venda")
            loc_oBusca.mAddColuna("ccols", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dcols", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    loc_oPg.txt_4c_Col.Value          = ALLTRIM(ccols)
                    loc_oPg.txt_4c_DColDisplay.Value  = ALLTRIM(dcols)
                    USE IN cursor_4c_Busca
                ENDIF
            ENDIF

            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo de venda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupIfor - Abre busca de fornecedor (SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupIfor()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", "cursor_4c_Busca", "Iclis", "", "Busca de Fornecedor")
            loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Rclis", "", "Nome")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_Busca")
                    SELECT cursor_4c_Busca
                    loc_oPg.txt_4c_Ifor.Value         = ALLTRIM(Iclis)
                    loc_oPg.txt_4c_DforDisplay.Value  = ALLTRIM(Rclis)
                    USE IN cursor_4c_Busca
                ENDIF
            ENDIF

            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de fornecedor")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE KEYPRESS - FASE 6 (novos campos com lookup)
    *==========================================================================

    *--------------------------------------------------------------------------
    * TxtCorKeyPress - KeyPress no campo Cor (ENTER/F4 abre lookup SigCdCor)
    *--------------------------------------------------------------------------
    PROCEDURE TxtCorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCor()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupCor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTamKeyPress - KeyPress no campo Tamanho (ENTER/F4 abre lookup SigCdTam)
    *--------------------------------------------------------------------------
    PROCEDURE TxtTamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarTam()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupTam()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodFinPKeyPress - KeyPress no campo Ficha (ENTER/F4 abre lookup SigCdFip)
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodFinP()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupFinP()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodAcbKeyPress - KeyPress no campo Acabamento (ENTER/F4 abre lookup SigCdAca)
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodAcb()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupAcb()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtClassKeyPress - KeyPress no campo Classe (ENTER/F4 abre lookup SIGCDCLS)
    *--------------------------------------------------------------------------
    PROCEDURE TxtClassKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarClass()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupClass()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtLocalKeyPress - KeyPress no campo Local (ENTER/F4 abre lookup SigPrLcl)
    *--------------------------------------------------------------------------
    PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarLocal()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupLocal()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCuniKeyPress - KeyPress no campo Unidade (ENTER/F4 abre lookup SigCdUni)
    *--------------------------------------------------------------------------
    PROCEDURE TxtCuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCuni()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupUni()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCunipKeyPress - KeyPress no campo Uni.Pedido (ENTER/F4 abre lookup SigCdUni)
    *--------------------------------------------------------------------------
    PROCEDURE TxtCunipKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCunip()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupUniP()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMctotalKeyPress - KeyPress no campo Moeda Custo (ENTER/F4 abre lookup SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE TxtMctotalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoe("total")
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupMctotal()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMpvendaKeyPress - KeyPress no campo Moeda P.Venda (ENTER/F4 abre lookup SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE TxtMpvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoe("pvenda")
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupMpvenda()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMfvendaKeyPress - KeyPress no campo Moeda F.Venda (ENTER/F4 abre lookup SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE TxtMfvendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoe("fvenda")
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupMfvenda()
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS - FASE 9 - pgComposicao
    *==========================================================================

    *--------------------------------------------------------------------------
    * GrdCompoAfterRowColChange - AfterRowColChange do grid de composicao
    * Refresha campos de descricao e observacao da OF quando muda a linha
    *--------------------------------------------------------------------------
    PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
            loc_oPg.txt_4c_DescComp.Value = ALLTRIM(cursor_4c_Compo.dcompos)
            loc_oPg.txt_4c_ObsOFs.Value   = ALLTRIM(cursor_4c_Compo.obscompos)
        ELSE
            loc_oPg.txt_4c_DescComp.Value = ""
            loc_oPg.txt_4c_ObsOFs.Value   = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdSubCpAfterRowColChange - AfterRowColChange do grid de sub-composicao
    *--------------------------------------------------------------------------
    PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
            loc_oPg.txt_4c_DescSubCp.Value = ALLTRIM(cursor_4c_SubCp.dcompos)
            loc_oPg.txt_4c_MatSubs.Value   = ALLTRIM(cursor_4c_SubCp.matsubs)
        ELSE
            loc_oPg.txt_4c_DescSubCp.Value = ""
            loc_oPg.txt_4c_MatSubs.Value   = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkLiberaCustoClick - habilitar/desabilitar campos de custo
    *--------------------------------------------------------------------------
    PROCEDURE ChkLiberaCustoClick()
        LOCAL loc_oPg, loc_lLiberado
        loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_lLiberado = (loc_oPg.chk_4c_LiberaCusto.Value = 1)
        loc_oPg.txt_4c_Pcus.ReadOnly      = !loc_lLiberado
        loc_oPg.txt_4c_Fcusto.ReadOnly    = !loc_lLiberado
        loc_oPg.txt_4c_Moec.ReadOnly      = !loc_lLiberado
        loc_oPg.txt_4c_Moepc.ReadOnly     = !loc_lLiberado
        loc_oPg.txt_4c_CotaCalcP.ReadOnly = !loc_lLiberado
        IF loc_lLiberado
            loc_oPg.txt_4c_Pcus.BackColor   = RGB(255, 255, 255)
            loc_oPg.txt_4c_Fcusto.BackColor  = RGB(255, 255, 255)
            loc_oPg.txt_4c_CotaCalcP.BackColor = RGB(255, 255, 255)
        ELSE
            loc_oPg.txt_4c_Pcus.BackColor   = RGB(224, 235, 235)
            loc_oPg.txt_4c_Fcusto.BackColor  = RGB(224, 235, 235)
            loc_oPg.txt_4c_CotaCalcP.BackColor = RGB(224, 235, 235)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkLiberaVendaClick - habilitar/desabilitar campos de venda
    *--------------------------------------------------------------------------
    PROCEDURE ChkLiberaVendaClick()
        LOCAL loc_oPg, loc_lLiberado
        loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_lLiberado = (loc_oPg.chk_4c_LiberaVenda.Value = 1)
        loc_oPg.txt_4c_FAtuals.ReadOnly = !loc_lLiberado
        loc_oPg.txt_4c_Fideals.ReadOnly = !loc_lLiberado
        IF loc_lLiberado
            loc_oPg.txt_4c_FAtuals.BackColor = RGB(255, 255, 255)
            loc_oPg.txt_4c_Fideals.BackColor = RGB(255, 255, 255)
        ELSE
            loc_oPg.txt_4c_FAtuals.BackColor = RGB(224, 235, 235)
            loc_oPg.txt_4c_Fideals.BackColor = RGB(224, 235, 235)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtPcusValid - Valid no campo Preco de Custo -> recalcula precos
    *--------------------------------------------------------------------------
    PROCEDURE TxtPcusValid()
        THIS.CalcPrecoComposicao()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtFcustoValid - Valid no campo Fator de Custo -> recalcula precos
    *--------------------------------------------------------------------------
    PROCEDURE TxtFcustoValid()
        THIS.CalcPrecoComposicao()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMargemValid - Valid na Margem/MKP -> recalcula precos
    *--------------------------------------------------------------------------
    PROCEDURE TxtMargemValid()
        THIS.CalcPrecoComposicao()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMarkupAValid - Valid no MarkupA -> recalcula precos
    *--------------------------------------------------------------------------
    PROCEDURE TxtMarkupAValid()
        THIS.CalcPrecoComposicao()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCotaCalcPValid - Valid na Cotacao -> recalcula precos
    *--------------------------------------------------------------------------
    PROCEDURE TxtCotaCalcPValid()
        THIS.CalcPrecoComposicao()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_oPg.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMoecKeyPress - KeyPress no campo Moeda Custo (ENTER/F4 abre lookup SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE TxtMoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeCompo("moec")
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupMoeCompo("moec")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMoepcKeyPress - KeyPress no campo Moeda P.Custo (ENTER/F4 abre lookup SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE TxtMoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeCompo("moepc")
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupMoeCompo("moepc")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMoedaKeyPress - KeyPress no campo Moeda Venda (ENTER/F4 abre lookup SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeCompo("moeda")
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupMoeCompo("moeda")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMoepvKeyPress - KeyPress no campo Moeda P.Venda (ENTER/F4 abre lookup SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE TxtMoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeCompo("moepv")
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupMoeCompo("moepv")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoeCompo - Valida campo de moeda na pagina composicao
    * par_cTipo: "moec"|"moepc"|"moeda"|"moepv"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarMoeCompo(par_cTipo)
        LOCAL loc_oPg, loc_oTxt, loc_cCodMoe, loc_cSQL, loc_lOk
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        DO CASE
        CASE par_cTipo = "moec"
            loc_oTxt = loc_oPg.txt_4c_Moec
        CASE par_cTipo = "moepc"
            loc_oTxt = loc_oPg.txt_4c_Moepc
        CASE par_cTipo = "moeda"
            loc_oTxt = loc_oPg.txt_4c_Moeda
        CASE par_cTipo = "moepv"
            loc_oTxt = loc_oPg.txt_4c_Moepv
        OTHERWISE
            RETURN
        ENDCASE
        loc_cCodMoe = ALLTRIM(loc_oTxt.Value)
        IF EMPTY(loc_cCodMoe)
            RETURN
        ENDIF
        loc_lOk = .F.
        TRY
            loc_cSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodMoe)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeCompo") > 0
                loc_lOk = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao validar moeda")
        ENDTRY
        IF loc_lOk
            IF EOF("cursor_4c_BuscaMoeCompo")
                MsgAviso("Moeda " + loc_cCodMoe + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
                loc_oTxt.Value = ""
            ENDIF
            IF USED("cursor_4c_BuscaMoeCompo")
                USE IN cursor_4c_BuscaMoeCompo
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMoeCompo - Abre lookup de moeda na pagina composicao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupMoeCompo(par_cTipo)
        LOCAL loc_oBusca, loc_oPg, loc_oTxt
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        DO CASE
        CASE par_cTipo = "moec"
            loc_oTxt = loc_oPg.txt_4c_Moec
        CASE par_cTipo = "moepc"
            loc_oTxt = loc_oPg.txt_4c_Moepc
        CASE par_cTipo = "moeda"
            loc_oTxt = loc_oPg.txt_4c_Moeda
        CASE par_cTipo = "moepv"
            loc_oTxt = loc_oPg.txt_4c_Moepv
        OTHERWISE
            RETURN
        ENDCASE
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo", .T.)
            loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o", .F.)
            loc_oBusca.this_cTabela    = "SigCdMoe"
            loc_oBusca.this_cCampoBusca = "cmoes"
            loc_oBusca.this_cValorInicial = ALLTRIM(loc_oTxt.Value)
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                loc_oTxt.Value = ALLTRIM(loc_oBusca.this_cCodigoSelecionado)
            ENDIF
            IF USED("cursor_4c_BuscaAuxMoe")
                USE IN cursor_4c_BuscaAuxMoe
            ENDIF
            loc_oBusca.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir lookup de moeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcPrecoComposicao - Recalcula precos baseado nos valores de custo/margem
    * Equivalente ao CalcPreco/CalcPreMoe do legado (stub - logica completa no BO)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CalcPrecoComposicao()
        LOCAL loc_oPg, loc_nPcus, loc_nMargem, loc_nPven
        loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_nPcus  = loc_oPg.txt_4c_Pcus.Value
        loc_nMargem = loc_oPg.txt_4c_Margem.Value
        *-- Calculo simplificado: Preco Venda = Custo * (1 + Margem/100)
        *-- O calculo completo com fatores/moedas sera feito via BO
        IF loc_nMargem > 0 AND loc_nPcus > 0
            loc_nPven = loc_nPcus * (1 + loc_nMargem / 100)
            loc_oPg.txt_4c_Pvens.Value = loc_nPven
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdCalcValsClick - Botao Calcular Valores (cmdCalcVals)
    * Aciona recalculo completo de precos (equivalente ao CalcPreco do legado)
    *--------------------------------------------------------------------------
    PROCEDURE CmdCalcValsClick()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        THIS.CalcPrecoComposicao()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdPesoMClick - Botao calcular peso medio (abre form sigcdpes)
    *--------------------------------------------------------------------------
    PROCEDURE CmdPesoMClick()
        MsgAviso("Fun" + CHR(231) + CHR(227) + "o de c" + CHR(225) + "lculo de peso n" + CHR(227) + "o implementada nesta vers" + CHR(227) + "o.", "Peso M" + CHR(233) + "dio")
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdgCompoClick - Click no CommandGroup de composicao (5 botoes)
    * .Value=1 Inserir | 2 Excluir | 3 Atualizar Custo | 4 Atualizar Preco | 5 Atualizar Pesos
    *--------------------------------------------------------------------------
    PROCEDURE CmdgCompoClick()
        LOCAL loc_oPg, loc_nBtn, loc_oGrd
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_nBtn = loc_oPg.obj_4c_CmdgCompo.Value
        loc_oGrd = loc_oPg.grd_4c_Compo

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        DO CASE
        CASE loc_nBtn = 1
            *-- Inserir item de composicao
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF USED("cursor_4c_Compo")
                SELECT cursor_4c_Compo
                APPEND BLANK
                loc_oGrd.Refresh()
            ENDIF

        CASE loc_nBtn = 2
            *-- Excluir item de composicao
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
                IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
                    SELECT cursor_4c_Compo
                    DELETE
                    IF !EOF("cursor_4c_Compo")
                        SKIP
                        SKIP -1
                    ENDIF
                    loc_oGrd.Refresh()
                ENDIF
            ENDIF

        CASE loc_nBtn = 3
            *-- Atualizar custo
            THIS.CalcPrecoComposicao()

        CASE loc_nBtn = 4
            *-- Atualizar preco
            THIS.CalcPrecoComposicao()

        CASE loc_nBtn = 5
            *-- Atualizar pesos
            THIS.CmdPesoMClick()

        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdgSubCpClick - Click no CommandGroup de sub-composicao (2 botoes)
    * .Value=1 Inserir | 2 Excluir
    *--------------------------------------------------------------------------
    PROCEDURE CmdgSubCpClick()
        LOCAL loc_oPg, loc_nBtn, loc_oGrd
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_nBtn = loc_oPg.obj_4c_CmdgSubCp.Value
        loc_oGrd = loc_oPg.grd_4c_SubCp

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        DO CASE
        CASE loc_nBtn = 1
            *-- Inserir item de sub-composicao
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF USED("cursor_4c_SubCp")
                SELECT cursor_4c_SubCp
                APPEND BLANK
                loc_oGrd.Refresh()
            ENDIF

        CASE loc_nBtn = 2
            *-- Excluir item de sub-composicao
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
                IF MsgConfirma("Excluir o sub-item selecionado?", "Confirmar")
                    SELECT cursor_4c_SubCp
                    DELETE
                    IF !EOF("cursor_4c_SubCp")
                        SKIP
                        SKIP -1
                    ENDIF
                    loc_oGrd.Refresh()
                ENDIF
            ENDIF

        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdCustoCompoAfterRowColChange - AfterRowColChange do grid Custo
    * Atualiza txt_4c_Desc (descricao item) e txt_4c_DGruCompos (desc grupo)
    *--------------------------------------------------------------------------
    PROCEDURE GrdCustoCompoAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_cGrupo, loc_nRet, loc_oErro
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6

        IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
            loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_CustoCompo.dcompos)
            loc_cGrupo = ALLTRIM(cursor_4c_CustoCompo.CGrus)
            IF !EMPTY(loc_cGrupo)
                TRY
                    loc_nRet = SQLEXEC(gnConnHandle, ;
                        "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cGrupo), ;
                        "cursor_4c_GruCustoDesc")
                    IF loc_nRet > 0 AND USED("cursor_4c_GruCustoDesc") AND !EOF("cursor_4c_GruCustoDesc")
                        loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_GruCustoDesc.DGrus)
                    ELSE
                        loc_oPg.txt_4c_DGruCompos.Value = ""
                    ENDIF
                    IF USED("cursor_4c_GruCustoDesc")
                        USE IN cursor_4c_GruCustoDesc
                    ENDIF
                CATCH TO loc_oErro
                    MsgErro(loc_oErro.Message, "Erro ao buscar grupo da composi" + CHR(231) + CHR(227) + "o")
                ENDTRY
            ELSE
                loc_oPg.txt_4c_DGruCompos.Value = ""
            ENDIF
        ELSE
            loc_oPg.txt_4c_Desc.Value       = ""
            loc_oPg.txt_4c_DGruCompos.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdgCustoClick - Click no CommandGroup de composicao Custo (2 botoes)
    * .Value=1 Inserir | .Value=2 Excluir
    *--------------------------------------------------------------------------
    PROCEDURE CmdgCustoClick()
        LOCAL loc_oPg, loc_nBtn, loc_oGrd
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        loc_nBtn = loc_oPg.obj_4c_CmdgCusto.Value
        loc_oGrd = loc_oPg.grd_4c_CustoCompo

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        DO CASE
        CASE loc_nBtn = 1
            *-- Inserir item de composicao custo
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                MsgAviso("Selecione o modo Incluir ou Alterar para inserir itens.", "Aten" + CHR(231) + CHR(227) + "o")
                RETURN
            ENDIF
            IF USED("cursor_4c_CustoCompo")
                SELECT cursor_4c_CustoCompo
                APPEND BLANK
                loc_oGrd.Refresh()
            ENDIF

        CASE loc_nBtn = 2
            *-- Excluir item de composicao custo
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
                IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
                    SELECT cursor_4c_CustoCompo
                    DELETE
                    IF !EOF("cursor_4c_CustoCompo")
                        SKIP
                        SKIP -1
                    ENDIF
                    loc_oGrd.Refresh()
                ENDIF
            ENDIF

        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * CboTiposCustoInteractiveChange - InteractiveChange do cmbTipos na aba Custo
    * Filtra/recarrega grid de composicao pelo tipo selecionado
    *--------------------------------------------------------------------------
    PROCEDURE CboTiposCustoInteractiveChange()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        IF USED("cursor_4c_CustoCompo")
            GO TOP IN cursor_4c_CustoCompo
        ENDIF
        loc_oPg.grd_4c_CustoCompo.Refresh()
    ENDPROC

    *==========================================================================
    * VALIDACOES - FASE 6
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCor - Valida e carrega tooltip da cor (SigCdCor)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCor()
        LOCAL loc_cCodCor, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCodCor = ALLTRIM(loc_oPg.txt_4c_Cor.Value)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        THIS.CarregarDescCor(loc_cCodCor)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTam - Valida e carrega tooltip do tamanho (SigCdTam)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarTam()
        LOCAL loc_cCodTam, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCodTam = ALLTRIM(loc_oPg.txt_4c_Tam.Value)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        THIS.CarregarDescTam(loc_cCodTam)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodFinP - Valida campo ficha e carrega descricao (SigCdFip)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCodFinP()
        LOCAL loc_cCodFinP, loc_oPg
        loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCodFinP = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        THIS.CarregarDescFinP(loc_cCodFinP)
        IF !EMPTY(loc_cCodFinP) AND EMPTY(loc_oPg.txt_4c_DesFinP.Value)
            MsgAviso("Ficha " + loc_cCodFinP + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodAcb - Valida campo acabamento e carrega descricao (SigCdAca)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCodAcb()
        LOCAL loc_cCodAcb, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCodAcb = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        THIS.CarregarDescAcb(loc_cCodAcb)
        IF !EMPTY(loc_cCodAcb) AND EMPTY(loc_oPg.txt_4c_DacbDisplay.Value)
            MsgAviso("Acabamento " + loc_cCodAcb + " n" + CHR(227) + "o encontrado.", "Inv" + CHR(225) + "lido")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarClass - Valida campo classificacao e carrega descricao (SIGCDCLS)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarClass()
        LOCAL loc_cCclass, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCclass = ALLTRIM(loc_oPg.txt_4c_Class.Value)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        THIS.CarregarDescClass(loc_cCclass)
        IF !EMPTY(loc_cCclass) AND EMPTY(loc_oPg.txt_4c_DClassDisplay.Value)
            MsgAviso("Classifica" + CHR(231) + CHR(227) + "o " + loc_cCclass + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLocal - Valida campo local (SigPrLcl)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarLocal()
        LOCAL loc_cLocals, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cLocals = ALLTRIM(loc_oPg.txt_4c_Local.Value)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        THIS.CarregarDescLocal(loc_cLocals)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCuni - Valida campo unidade e carrega descricao (SigCdUni)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCuni()
        LOCAL loc_cCunis, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCunis  = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        THIS.CarregarDescUni(loc_cCunis, "uni")
        IF !EMPTY(loc_cCunis) AND EMPTY(loc_oPg.txt_4c_DuniDisplay.Value)
            MsgAviso("Unidade " + loc_cCunis + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCunip - Valida campo unidade de pedido (SigCdUni)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCunip()
        LOCAL loc_cCunips, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCunips = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        THIS.CarregarDescUni(loc_cCunips, "unip")
        IF !EMPTY(loc_cCunips) AND EMPTY(loc_oPg.txt_4c_DunipDisplay.Value)
            MsgAviso("Unidade " + loc_cCunips + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMoe - Valida campo moeda (SigCdMoe)
    * par_cTipo: "total" | "pvenda" | "fvenda"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarMoe(par_cTipo)
        LOCAL loc_cCmoes, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        DO CASE
        CASE par_cTipo = "total"
            loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mctotal.Value)
        CASE par_cTipo = "pvenda"
            loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value)
        OTHERWISE
            loc_cCmoes = ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value)
        ENDCASE
        THIS.CarregarDescMoe(loc_cCmoes, par_cTipo)
    ENDPROC

    *==========================================================================
    * LOOKUPS - FASE 6
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirLookupCor - Abre busca de cor (SigCdCor)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCor()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "cursor_4c_BuscaCor", "cods", ;
                ALLTRIM(loc_oPg.txt_4c_Cor.Value), "Busca de Cor")
            loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaCor")
                    SELECT cursor_4c_BuscaCor
                    loc_oPg.txt_4c_Cor.Value = ALLTRIM(cods)
                    USE IN cursor_4c_BuscaCor
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de cor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTam - Abre busca de tamanho (SigCdTam)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupTam()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "cursor_4c_BuscaTam", "cods", ;
                ALLTRIM(loc_oPg.txt_4c_Tam.Value), "Busca de Tamanho")
            loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaTam")
                    SELECT cursor_4c_BuscaTam
                    loc_oPg.txt_4c_Tam.Value = ALLTRIM(cods)
                    USE IN cursor_4c_BuscaTam
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de tamanho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupFinP - Abre busca de ficha de produto (SigCdFip)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupFinP()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdFip", "cursor_4c_BuscaFinP", "cods", ;
                ALLTRIM(loc_oPg.txt_4c_CodFinP.Value), "Busca de Ficha")
            loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaFinP")
                    SELECT cursor_4c_BuscaFinP
                    loc_oPg.txt_4c_CodFinP.Value  = ALLTRIM(cods)
                    loc_oPg.txt_4c_DesFinP.Value  = ALLTRIM(descs)
                    USE IN cursor_4c_BuscaFinP
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de ficha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupAcb - Abre busca de acabamento (SigCdAca)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupAcb()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdAca", "cursor_4c_BuscaAcb", "cods", ;
                ALLTRIM(loc_oPg.txt_4c_CodAcb.Value), "Busca de Acabamento")
            loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaAcb")
                    SELECT cursor_4c_BuscaAcb
                    loc_oPg.txt_4c_CodAcb.Value       = ALLTRIM(cods)
                    loc_oPg.txt_4c_DacbDisplay.Value  = ALLTRIM(descrs)
                    USE IN cursor_4c_BuscaAcb
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de acabamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupClass - Abre busca de classificacao (SIGCDCLS)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupClass()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SIGCDCLS", "cursor_4c_BuscaClass", "cods", ;
                ALLTRIM(loc_oPg.txt_4c_Class.Value), ;
                "Busca de Classifica" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("cods", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaClass")
                    SELECT cursor_4c_BuscaClass
                    loc_oPg.txt_4c_Class.Value         = ALLTRIM(cods)
                    loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
                    USE IN cursor_4c_BuscaClass
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupLocal - Abre busca de local (SigPrLcl)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupLocal()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrLcl", "cursor_4c_BuscaLocal", "codigos", ;
                ALLTRIM(loc_oPg.txt_4c_Local.Value), "Busca de Local")
            loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaLocal")
                    SELECT cursor_4c_BuscaLocal
                    loc_oPg.txt_4c_Local.Value = ALLTRIM(codigos)
                    USE IN cursor_4c_BuscaLocal
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de local")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUni - Abre busca de unidade (SigCdUni) para campo Cuni
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupUni()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUni", "cursor_4c_BuscaUni", "cunis", ;
                ALLTRIM(loc_oPg.txt_4c_Cuni.Value), "Busca de Unidade")
            loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaUni")
                    SELECT cursor_4c_BuscaUni
                    loc_oPg.txt_4c_Cuni.Value          = ALLTRIM(cunis)
                    loc_oPg.txt_4c_DuniDisplay.Value   = ALLTRIM(dunis)
                    USE IN cursor_4c_BuscaUni
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUniP - Abre busca de unidade de pedido (SigCdUni) para campo Cunip
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupUniP()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUni", "cursor_4c_BuscaUniP", "cunis", ;
                ALLTRIM(loc_oPg.txt_4c_Cunip.Value), "Busca de Uni.Pedido")
            loc_oBusca.mAddColuna("cunis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dunis", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaUniP")
                    SELECT cursor_4c_BuscaUniP
                    loc_oPg.txt_4c_Cunip.Value          = ALLTRIM(cunis)
                    loc_oPg.txt_4c_DunipDisplay.Value   = ALLTRIM(dunis)
                    USE IN cursor_4c_BuscaUniP
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade de pedido")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMctotal - Abre busca de moeda custo (SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMctotal()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
                ALLTRIM(loc_oPg.txt_4c_Mctotal.Value), "Busca de Moeda (Custo)")
            loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    loc_oPg.txt_4c_Mctotal.Value = ALLTRIM(cmoes)
                    THIS.CarregarDescMoe(ALLTRIM(cmoes), "total")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMpvenda - Abre busca de moeda P.Venda (SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMpvenda()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
                ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value), "Busca de Moeda (P.Venda)")
            loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    loc_oPg.txt_4c_Mpvenda.Value = ALLTRIM(cmoes)
                    THIS.CarregarDescMoe(ALLTRIM(cmoes), "pvenda")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMfvenda - Abre busca de moeda F.Venda (SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMfvenda()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", ;
                ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value), "Busca de Moeda (F.Venda)")
            loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaMoe")
                    SELECT cursor_4c_BuscaMoe
                    loc_oPg.txt_4c_Mfvenda.Value = ALLTRIM(cmoes)
                    THIS.CarregarDescMoe(ALLTRIM(cmoes), "fvenda")
                    USE IN cursor_4c_BuscaMoe
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS - FASE 13: pgDadosFiscais
    *==========================================================================

    *--------------------------------------------------------------------------
    * TxtGruccusKeyPress - KeyPress em txt_4c_Gruccus (F4/F5 abre lookup SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE TxtGruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarGruccus()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupGruccus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGruccus - LostFocus/Enter em txt_4c_Gruccus
    * Lookup: SigCdGcr (Codigos / Descrs)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGruccus()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Gruccus.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_oPage.txt_4c_Dgruccus.Value    = ""
                loc_oPage.txt_4c_Contaccus.Value   = ""
                loc_oPage.txt_4c_Dcontaccus.Value  = ""
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus") <= 0 OR EOF("cursor_4c_ValGruccus")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("Codigos", "C" + CHR(243) + "digo",       80)
                loc_oLookup.mAddColuna("Descrs",  "Descri" + CHR(231) + CHR(227) + "o", 200)
                loc_oLookup.cTabela     = "SigCdGcr"
                loc_oLookup.cCampoChave = "Codigos"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ELSE
                SELECT cursor_4c_ValGruccus
                loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
            ENDIF
            IF USED("cursor_4c_ValGruccus")
                USE IN cursor_4c_ValGruccus
            ENDIF
            IF !EMPTY(loc_cCodigo)
                loc_oPage.txt_4c_Gruccus.Value = loc_cCodigo
                loc_oPage.txt_4c_Gruccus.Refresh()
                *-- Recarregar descricao se veio do lookup
                loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus2") > 0 AND !EOF("cursor_4c_ValGruccus2")
                    SELECT cursor_4c_ValGruccus2
                    loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
                ENDIF
                IF USED("cursor_4c_ValGruccus2")
                    USE IN cursor_4c_ValGruccus2
                ENDIF
            ELSE
                loc_oPage.txt_4c_Gruccus.Value    = ""
                loc_oPage.txt_4c_Dgruccus.Value   = ""
                loc_oPage.txt_4c_Contaccus.Value  = ""
                loc_oPage.txt_4c_Dcontaccus.Value = ""
            ENDIF
            loc_oPage.txt_4c_Dgruccus.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupGruccus - Abre busca de grupo C.C. (SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupGruccus()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGruccus", "Codigos", ;
                ALLTRIM(loc_oPg.txt_4c_Gruccus.Value), "Busca de Grupo C.C.")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaGruccus")
                    SELECT cursor_4c_BuscaGruccus
                    loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
                    USE IN cursor_4c_BuscaGruccus
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDgruccusKeyPress - KeyPress em txt_4c_Dgruccus (F4 abre lookup por descricao)
    *--------------------------------------------------------------------------
    PROCEDURE TxtDgruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupDgruccus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDgruccus - Busca reversa por descricao em SigCdGcr
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDgruccus()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGruccus", "Descrs", ;
                ALLTRIM(loc_oPg.txt_4c_Dgruccus.Value), "Busca de Grupo C.C.")
            loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaGruccus")
                    SELECT cursor_4c_BuscaGruccus
                    loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
                    USE IN cursor_4c_BuscaGruccus
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtContaccusKeyPress - KeyPress em txt_4c_Contaccus (F4 abre lookup SigCdCli)
    *--------------------------------------------------------------------------
    PROCEDURE TxtContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarContaccus()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupContaccus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarContaccus - LostFocus/Enter em txt_4c_Contaccus
    * Lookup: SigCdCli filtrado por Grupos = gruccus (IClis / Rclis)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarContaccus()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_cGrupo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Contaccus.Value, ""))
            loc_cGrupo  = ALLTRIM(NVL(loc_oPage.txt_4c_Gruccus.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_oPage.txt_4c_Dcontaccus.Value = ""
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT IClis, Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
            IF !EMPTY(loc_cGrupo)
                loc_lcSQL = loc_lcSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValContaccus") <= 0 OR EOF("cursor_4c_ValContaccus")
                IF USED("cursor_4c_ValContaccus")
                    USE IN cursor_4c_ValContaccus
                ENDIF
                THIS.AbrirLookupContaccus()
                loc_lResultado = loc_lResultado
            ENDIF
            SELECT cursor_4c_ValContaccus
            loc_oPage.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
            loc_oPage.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
            loc_oPage.txt_4c_Contaccus.Refresh()
            loc_oPage.txt_4c_Dcontaccus.Refresh()
            IF USED("cursor_4c_ValContaccus")
                USE IN cursor_4c_ValContaccus
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupContaccus - Abre busca de conta C.C. (SigCdCli filtrado por grupo)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupContaccus()
        LOCAL loc_oBusca, loc_oPg, loc_cGrupo, loc_cTabela
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        loc_cGrupo = ALLTRIM(NVL(loc_oPg.txt_4c_Gruccus.Value, ""))
        TRY
            loc_cTabela = "SigCdCli"
            IF !EMPTY(loc_cGrupo)
                loc_cTabela = "SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo)
                loc_cTabela = "(SELECT IClis, Rclis FROM SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo) + ") AS t"
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaContaccus", "IClis", ;
                ALLTRIM(loc_oPg.txt_4c_Contaccus.Value), "Busca de Conta C.C.")
            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Rclis", "", "Nome")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaContaccus")
                    SELECT cursor_4c_BuscaContaccus
                    loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
                    loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
                    USE IN cursor_4c_BuscaContaccus
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDcontaccusKeyPress - KeyPress em txt_4c_Dcontaccus (F4 abre lookup por nome)
    *--------------------------------------------------------------------------
    PROCEDURE TxtDcontaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupDcontaccus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDcontaccus - Busca reversa por nome em SigCdCli
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDcontaccus()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaContaccus", "Rclis", ;
                ALLTRIM(loc_oPg.txt_4c_Dcontaccus.Value), "Busca de Conta C.C.")
            loc_oBusca.mAddColuna("Rclis", "", "Nome")
            loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaContaccus")
                    SELECT cursor_4c_BuscaContaccus
                    loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
                    loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
                    USE IN cursor_4c_BuscaContaccus
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtClfiscalKeyPress - KeyPress em txt_4c_Clfiscal (F4 abre lookup SigCdClf)
    *--------------------------------------------------------------------------
    PROCEDURE TxtClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarClfiscal()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupClfiscal()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarClfiscal - LostFocus/Enter em txt_4c_Clfiscal
    * Lookup: SigCdClf (Codigos / Descricaos)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarClfiscal()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Clfiscal.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_oPage.txt_4c_Dclfiscal.Value = ""
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf") <= 0 OR EOF("cursor_4c_ValClf")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       100)
                loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 300)
                loc_oLookup.cTabela     = "SigCdClf"
                loc_oLookup.cCampoChave = "Codigos"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ELSE
                SELECT cursor_4c_ValClf
                loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
            ENDIF
            IF USED("cursor_4c_ValClf")
                USE IN cursor_4c_ValClf
            ENDIF
            loc_oPage.txt_4c_Clfiscal.Value = loc_cCodigo
            IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dclfiscal.Value)
                *-- Recarregar descricao apos lookup
                loc_lcSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf2") > 0 AND !EOF("cursor_4c_ValClf2")
                    SELECT cursor_4c_ValClf2
                    loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
                ENDIF
                IF USED("cursor_4c_ValClf2")
                    USE IN cursor_4c_ValClf2
                ENDIF
            ENDIF
            loc_oPage.txt_4c_Clfiscal.Refresh()
            loc_oPage.txt_4c_Dclfiscal.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupClfiscal - Abre busca de classificacao fiscal (SigCdClf)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupClfiscal()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdClf", "cursor_4c_BuscaClf", "Codigos", ;
                ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaClf")
                    SELECT cursor_4c_BuscaClf
                    loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
                    USE IN cursor_4c_BuscaClf
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDclfiscalKeyPress - KeyPress em txt_4c_Dclfiscal (F4 busca reversa)
    *--------------------------------------------------------------------------
    PROCEDURE TxtDclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupDclfiscal()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDclfiscal - Busca reversa por descricao em SigCdClf
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDclfiscal()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdClf", "cursor_4c_BuscaClf", "Descricaos", ;
                ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value), "Busca de Classifica" + CHR(231) + CHR(227) + "o Fiscal")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaClf")
                    SELECT cursor_4c_BuscaClf
                    loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
                    USE IN cursor_4c_BuscaClf
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtOrigmercKeyPress - KeyPress em txt_4c_Origmerc (F4 abre lookup SigCdOrg)
    *--------------------------------------------------------------------------
    PROCEDURE TxtOrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarOrigmerc()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupOrigmerc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOrigmerc - LostFocus/Enter em txt_4c_Origmerc
    * Lookup: SigCdOrg (Codigos / Descricaos)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOrigmerc()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Origmerc.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_oPage.txt_4c_Dorigmerc.Value = ""
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg") <= 0 OR EOF("cursor_4c_ValOrg")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       60)
                loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 200)
                loc_oLookup.cTabela     = "SigCdOrg"
                loc_oLookup.cCampoChave = "Codigos"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ELSE
                SELECT cursor_4c_ValOrg
                loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
            ENDIF
            IF USED("cursor_4c_ValOrg")
                USE IN cursor_4c_ValOrg
            ENDIF
            loc_oPage.txt_4c_Origmerc.Value = loc_cCodigo
            IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dorigmerc.Value)
                loc_lcSQL = "SELECT Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg2") > 0 AND !EOF("cursor_4c_ValOrg2")
                    SELECT cursor_4c_ValOrg2
                    loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
                ENDIF
                IF USED("cursor_4c_ValOrg2")
                    USE IN cursor_4c_ValOrg2
                ENDIF
            ENDIF
            loc_oPage.txt_4c_Origmerc.Refresh()
            loc_oPage.txt_4c_Dorigmerc.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupOrigmerc - Abre busca de origem da mercadoria (SigCdOrg)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupOrigmerc()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOrg", "cursor_4c_BuscaOrg", "Codigos", ;
                ALLTRIM(loc_oPg.txt_4c_Origmerc.Value), "Busca de Origem da Mercadoria")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaOrg")
                    SELECT cursor_4c_BuscaOrg
                    loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
                    USE IN cursor_4c_BuscaOrg
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDorigmercKeyPress - KeyPress em txt_4c_Dorigmerc (F4 busca reversa)
    *--------------------------------------------------------------------------
    PROCEDURE TxtDorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupDorigmerc()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDorigmerc - Busca reversa por descricao em SigCdOrg
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDorigmerc()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOrg", "cursor_4c_BuscaOrg", "Descricaos", ;
                ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value), "Busca de Origem da Mercadoria")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaOrg")
                    SELECT cursor_4c_BuscaOrg
                    loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
                    USE IN cursor_4c_BuscaOrg
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtSittricmKeyPress - KeyPress em txt_4c_Sittricm (F4 abre lookup SigCdIcm)
    *--------------------------------------------------------------------------
    PROCEDURE TxtSittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarSittricm()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupSittricm()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSittricm - LostFocus/Enter em txt_4c_Sittricm
    * Lookup: SigCdIcm (Codigos / Descricaos)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSittricm()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Sittricm.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_oPage.txt_4c_Dsittricm.Value = ""
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm") <= 0 OR EOF("cursor_4c_ValIcm")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       60)
                loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 250)
                loc_oLookup.cTabela     = "SigCdIcm"
                loc_oLookup.cCampoChave = "Codigos"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ELSE
                SELECT cursor_4c_ValIcm
                loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
            ENDIF
            IF USED("cursor_4c_ValIcm")
                USE IN cursor_4c_ValIcm
            ENDIF
            loc_oPage.txt_4c_Sittricm.Value = loc_cCodigo
            IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dsittricm.Value)
                loc_lcSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
                IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm2") > 0 AND !EOF("cursor_4c_ValIcm2")
                    SELECT cursor_4c_ValIcm2
                    loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
                ENDIF
                IF USED("cursor_4c_ValIcm2")
                    USE IN cursor_4c_ValIcm2
                ENDIF
            ENDIF
            loc_oPage.txt_4c_Sittricm.Refresh()
            loc_oPage.txt_4c_Dsittricm.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSittricm - Abre busca situacao tributaria ICMS (SigCdIcm)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSittricm()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
                ALLTRIM(loc_oPg.txt_4c_Sittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaIcm")
                    SELECT cursor_4c_BuscaIcm
                    loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
                    USE IN cursor_4c_BuscaIcm
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDsittricmKeyPress - KeyPress em txt_4c_Dsittricm (F4 busca reversa)
    *--------------------------------------------------------------------------
    PROCEDURE TxtDsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupDsittricm()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDsittricm - Busca reversa por descricao em SigCdIcm
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDsittricm()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdIcm", "cursor_4c_BuscaIcm", "Descricaos", ;
                ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value), "Busca de Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaIcm")
                    SELECT cursor_4c_BuscaIcm
                    loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
                    USE IN cursor_4c_BuscaIcm
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodServsKeyPress - KeyPress em txt_4c_CodServs (F4 abre lookup SigCdIcm)
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodServsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodServs()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupCodServs()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodServs - LostFocus/Enter em txt_4c_CodServs
    * Lookup: SigCdIcm (Codigos) -> preenche txt_4c_Sittricm
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodServs()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_CodServs.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCodServs") <= 0 OR EOF("cursor_4c_ValCodServs")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       60)
                loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 250)
                loc_oLookup.cTabela     = "SigCdIcm"
                loc_oLookup.cCampoChave = "Codigos"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ELSE
                *-- Get_CodServs preenche txt_4c_Sittricm (conforme original)
                SELECT cursor_4c_ValCodServs
                loc_oPage.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
                loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
                loc_oPage.txt_4c_Sittricm.Refresh()
                loc_oPage.txt_4c_Dsittricm.Refresh()
            ENDIF
            IF USED("cursor_4c_ValCodServs")
                USE IN cursor_4c_ValCodServs
            ENDIF
            loc_oPage.txt_4c_CodServs.Value = loc_cCodigo
            loc_oPage.txt_4c_CodServs.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCodServs - Abre busca codigo servicos ICMS (SigCdIcm)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCodServs()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdIcm", "cursor_4c_BuscaIcm", "Codigos", ;
                ALLTRIM(loc_oPg.txt_4c_CodServs.Value), "Busca de C" + CHR(243) + "digo de Servi" + CHR(231) + "os")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaIcm")
                    SELECT cursor_4c_BuscaIcm
                    loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
                    loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
                    USE IN cursor_4c_BuscaIcm
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de c" + CHR(243) + "digo de servi" + CHR(231) + "os")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTpTribKeyPress - KeyPress em txt_4c_TpTrib (F4 abre lookup SigPrTri)
    *--------------------------------------------------------------------------
    PROCEDURE TxtTpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarTpTrib()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupTpTrib()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTpTrib - LostFocus/Enter em txt_4c_TpTrib
    * Lookup: SigPrTri (Tipos / Descs)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTpTrib()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_TpTrib.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT Tipos FROM SigPrTri WHERE Tipos = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTrib") <= 0 OR EOF("cursor_4c_ValTrib")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("Tipos", "Tipo",       60)
                loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
                loc_oLookup.cTabela     = "SigPrTri"
                loc_oLookup.cCampoChave = "Tipos"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ENDIF
            IF USED("cursor_4c_ValTrib")
                USE IN cursor_4c_ValTrib
            ENDIF
            loc_oPage.txt_4c_TpTrib.Value = loc_cCodigo
            loc_oPage.txt_4c_TpTrib.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTpTrib - Abre busca de tipo de tributacao (SigPrTri)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupTpTrib()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrTri", "cursor_4c_BuscaTrib", "Tipos", ;
                ALLTRIM(loc_oPg.txt_4c_TpTrib.Value), "Busca de Tipo de Tributa" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Tipos", "", "Tipo")
            loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaTrib")
                    SELECT cursor_4c_BuscaTrib
                    loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
                    USE IN cursor_4c_BuscaTrib
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de tipo de tributa" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarIat - LostFocus em txt_4c_Iat
    * Valida: deve ser 'A' (Arredondamento) ou 'T' (Truncamento) ou vazio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarIat()
        LOCAL loc_oPage, loc_cValor
        TRY
            loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cValor = UPPER(ALLTRIM(NVL(loc_oPage.txt_4c_Iat.Value, "")))
            IF EMPTY(loc_cValor)
                RETURN
            ENDIF
            IF !INLIST(loc_cValor, "A", "T")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
                    "Digite [A] Indicador de Arredondamento ou [T] Indicador de Truncamento!")
                loc_oPage.txt_4c_Iat.Value = ""
                loc_oPage.txt_4c_Iat.Refresh()
            ELSE
                loc_oPage.txt_4c_Iat.Value = loc_cValor
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAliqIPI - LostFocus em txt_4c_AliqIPI
    * Verifica se aliquota informada eh identica a da classificacao fiscal
    *--------------------------------------------------------------------------
    PROCEDURE ValidarAliqIPI()
        LOCAL loc_oPage, loc_nAliq, loc_nAliqClf, loc_lcSQL
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_nAliq   = loc_oPage.txt_4c_AliqIPI.Value
            IF EMPTY(ALLTRIM(NVL(loc_oPage.txt_4c_Clfiscal.Value, ""))) OR loc_nAliq = 0
                RETURN
            ENDIF
            loc_lcSQL = "SELECT aIpis FROM SigCdClf WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPage.txt_4c_Clfiscal.Value))
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAliqIPI") > 0 AND !EOF("cursor_4c_ValAliqIPI")
                SELECT cursor_4c_ValAliqIPI
                loc_nAliqClf = aIpis
                IF loc_nAliq = loc_nAliqClf
                    MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + ;
                        CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal, " + ;
                        "deixe zero e ser" + CHR(225) + " utilizada a classifica" + CHR(231) + CHR(227) + "o fiscal!")
                ENDIF
            ENDIF
            IF USED("cursor_4c_ValAliqIPI")
                USE IN cursor_4c_ValAliqIPI
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMvalorKeyPress - KeyPress em txt_4c_Mvalor (F4 abre lookup SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE TxtMvalorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMvalor()
        ENDIF
        IF par_nKeyCode = 115
            THIS.AbrirLookupMvalor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMvalor - LostFocus/Enter em txt_4c_Mvalor
    * Lookup: SigCdMoe (CMoes / DMoes)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMvalor()
        LOCAL loc_lResultado, loc_oLookup, loc_oPage, loc_cCodigo, loc_lcSQL
        loc_lResultado = .T.
        TRY
            loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cCodigo = ALLTRIM(NVL(loc_oPage.txt_4c_Mvalor.Value, ""))
            IF EMPTY(loc_cCodigo)
                loc_lResultado = loc_lResultado
            ENDIF
            loc_lcSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMvalor") <= 0 OR EOF("cursor_4c_ValMvalor")
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                loc_oLookup.mAddColuna("cmoes", "C" + CHR(243) + "digo",       60)
                loc_oLookup.mAddColuna("dmoes", "Descri" + CHR(231) + CHR(227) + "o", 200)
                loc_oLookup.cTabela     = "SigCdMoe"
                loc_oLookup.cCampoChave = "cmoes"
                loc_oLookup.cFiltroIni  = loc_cCodigo
                loc_oLookup.Show()
                IF loc_oLookup.this_lSelecionou
                    loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                ELSE
                    loc_cCodigo = ""
                ENDIF
            ENDIF
            IF USED("cursor_4c_ValMvalor")
                USE IN cursor_4c_ValMvalor
            ENDIF
            loc_oPage.txt_4c_Mvalor.Value = loc_cCodigo
            loc_oPage.txt_4c_Mvalor.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMvalor - Abre busca de moeda do valor estimado (SigCdMoe)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMvalor()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMvalor", "cmoes", ;
                ALLTRIM(loc_oPg.txt_4c_Mvalor.Value), "Busca de Moeda")
            loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()
            IF loc_oBusca.this_lSelecionou
                IF USED("cursor_4c_BuscaMvalor")
                    SELECT cursor_4c_BuscaMvalor
                    loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(cmoes)
                    USE IN cursor_4c_BuscaMvalor
                ENDIF
            ENDIF
            loc_oBusca.Release()
            loc_oBusca = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtMetalKeyPress - KeyPress em txt_4c_Metal (F4 abre lookup metal)
    *--------------------------------------------------------------------------
    PROCEDURE TxtMetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupMetal()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupMetal - Abre busca de metal (TmpMTal - cursor pre-carregado)
    * Nota: TmpMTal deve ser carregado pelo form durante init com dados da tabela de metais
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupMetal()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            IF USED("TmpMTal")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "TmpMTal", "cursor_4c_BuscaMetal", "Codigos", ;
                    ALLTRIM(loc_oPg.txt_4c_Metal.Value), "Busca de Metal")
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaMetal")
                        SELECT cursor_4c_BuscaMetal
                        loc_oPg.txt_4c_Metal.Value   = ALLTRIM(Codigos)
                        loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(Descs)
                        USE IN cursor_4c_BuscaMetal
                    ENDIF
                ENDIF
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de metal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTeorKeyPress - KeyPress em txt_4c_Teor (F4 abre lookup teor)
    *--------------------------------------------------------------------------
    PROCEDURE TxtTeorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupTeor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTeor - Abre busca de teor (TmpTeor - cursor pre-carregado)
    * Nota: TmpTeor deve ser carregado pelo form durante init com dados da tabela de teores
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupTeor()
        LOCAL loc_oBusca, loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        TRY
            IF USED("TmpTeor")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "TmpTeor", "cursor_4c_BuscaTeor", "Codigos", ;
                    ALLTRIM(loc_oPg.txt_4c_Teor.Value), "Busca de Teor")
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou
                    IF USED("cursor_4c_BuscaTeor")
                        SELECT cursor_4c_BuscaTeor
                        loc_oPg.txt_4c_Teor.Value   = ALLTRIM(Codigos)
                        loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(Descs)
                        USE IN cursor_4c_BuscaTeor
                    ENDIF
                ENDIF
                loc_oBusca.Release()
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao abrir busca de teor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdBtnDescFisClick - Click em cmd_4c_BtnDescFis
    * Gera descricao fiscal a partir da composicao do produto (campo DescFis em SigCdPro)
    *--------------------------------------------------------------------------
    PROCEDURE CmdBtnDescFisClick()
        LOCAL loc_oPage, loc_cCpros, loc_lcSQL, loc_cDescFis
        TRY
            loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
            IF EMPTY(loc_cCpros)
                MsgAviso("Salve o produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.")
                RETURN
            ENDIF
            *-- Gerar descricao fiscal baseada na composicao do produto (simplificado)
            loc_lcSQL = "SELECT TOP 1 dpros + ' ' + ISNULL(dpro2s,'') AS descFis " + ;
                "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
            IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_DescFis") > 0 AND !EOF("cursor_4c_DescFis")
                SELECT cursor_4c_DescFis
                loc_cDescFis = ALLTRIM(descFis)
                IF !EMPTY(loc_cDescFis)
                    loc_oPage.obj_4c_Mgetdescfi.Value = loc_cDescFis
                    loc_oPage.obj_4c_Mgetdescfi.Refresh()
                    *-- Persistir no banco
                    loc_lcSQL = "UPDATE SigCdPro SET DescFis = " + EscaparSQL(loc_cDescFis) + ;
                        " WHERE cpros = " + EscaparSQL(loc_cCpros)
                    SQLEXEC(gnConnHandle, loc_lcSQL)
                ELSE
                    MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
                ENDIF
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
            ENDIF
            IF USED("cursor_4c_DescFis")
                USE IN cursor_4c_DescFis
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSigCdPro - Salva campos editaveis de SigCdPro apos salvar SigPrFtp
    * Chamado por BtnSalvarClick() apos this_oBusinessObject.Salvar() com sucesso
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarSigCdPro()
        LOCAL loc_oPg, loc_cCpros, loc_cSQL, loc_lFabrProprs, loc_lConsig, loc_lEncoms
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

        IF EMPTY(loc_cCpros)
            RETURN
        ENDIF

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        *-- Converter CheckBox.Value (logico) para 0/1
        loc_lFabrProprs = IIF(loc_oPg.chk_4c_FabrProprs.Value, 1, 0)
        loc_lConsig     = IIF(loc_oPg.chk_4c_Consig.Value,     1, 0)
        loc_lEncoms     = IIF(loc_oPg.chk_4c_Encoms.Value,     1, 0)

        *-- Coletar campos fiscais (Page3)
        LOCAL loc_oPg3U, loc_cIpiVal
        loc_oPg3U = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        loc_cIpiVal = LEFT(UPPER(ALLTRIM(loc_oPg3U.cbo_4c_CmbIpi.Value)), 1)

        TRY
            loc_cSQL = "UPDATE SigCdPro SET " + ;
                "dpro2s = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_DPro2s.Value))      + ", " + ;
                "cbars = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cbar.Value))        + ", " + ;
                "cgrus = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cgrus.Value))       + ", " + ;
                "linhas = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Lin.Value))         + ", " + ;
                "colecoes = "   + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Col.Value))         + ", " + ;
                "ifors = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Ifor.Value))        + ", " + ;
                "reffs = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Refs.Value))        + ", " + ;
                "codcors = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cor.Value))         + ", " + ;
                "codtams = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Tam.Value))         + ", " + ;
                "codfinp = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodFinP.Value))     + ", " + ;
                "pesobs = "     + FormatarNumeroSQL(loc_oPg.txt_4c_PesoB.Value)         + ", " + ;
                "codacbs = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodAcb.Value))      + ", " + ;
                "cclass = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Class.Value))       + ", " + ;
                "locals = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Local.Value))       + ", " + ;
                "cunis = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cuni.Value))        + ", " + ;
                "cunips = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cunip.Value))       + ", " + ;
                "custofs = "    + FormatarNumeroSQL(loc_oPg.txt_4c_Ctotal.Value)        + ", " + ;
                "moecs = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Mctotal.Value))     + ", " + ;
                "pvens = "      + FormatarNumeroSQL(loc_oPg.txt_4c_Pvenda.Value)        + ", " + ;
                "moepvs = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value))     + ", " + ;
                "codident = "   + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodIdent.Value))    + ", " + ;
                "fvendas = "    + FormatarNumeroSQL(loc_oPg.txt_4c_Fvenda.Value)        + ", " + ;
                "moevs = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value))     + ", " + ;
                "dsccompras = " + EscaparSQL(ALLTRIM(loc_oPg.edt_4c_DscCompras.Value))  + ", " + ;
                "dpro3s = "     + EscaparSQL(ALLTRIM(loc_oPg.edt_4c_DPro3s.Value))      + ", " + ;
                "obscompras = " + EscaparSQL(ALLTRIM(loc_oPg.edt_4c_ObsCompras.Value))  + ", " + ;
                "fabrproprs = " + TRANSFORM(loc_lFabrProprs)                            + ", " + ;
                "consigs = "    + TRANSFORM(loc_lConsig)                                + ", " + ;
                "encoms = "     + TRANSFORM(loc_lEncoms)                                + ", " + ;
                "gruccus = "    + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Gruccus.Value))   + ", " + ;
                "contaccus = "  + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Contaccus.Value)) + ", " + ;
                "clfiscals = "  + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Clfiscal.Value))  + ", " + ;
                "origmercs = "  + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Origmerc.Value))  + ", " + ;
                "sittricms = "  + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Sittricm.Value))  + ", " + ;
                "codservs = "   + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_CodServs.Value))  + ", " + ;
                "icms = "       + FormatarNumeroSQL(loc_oPg3U.txt_4c_Icms.Value)        + ", " + ;
                "tptribs = "    + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_TpTrib.Value))    + ", " + ;
                "iats = "       + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Iat.Value))       + ", " + ;
                "ipis = "       + EscaparSQL(loc_cIpiVal)                               + ", " + ;
                "aliqipis = "   + FormatarNumeroSQL(loc_oPg3U.txt_4c_AliqIPI.Value)     + ", " + ;
                "extipi = "     + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Extipi.Value))    + ", " + ;
                "descfis = "    + EscaparSQL(ALLTRIM(loc_oPg3U.obj_4c_Mgetdescfi.Value))+ ", " + ;
                "descecfs = "   + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_DescEcfs.Value))  + ", " + ;
                "metals = "     + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Metal.Value))     + ", " + ;
                "valors = "     + FormatarNumeroSQL(loc_oPg3U.txt_4c_Valor.Value)       + ", " + ;
                "moedas = "     + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Mvalor.Value))    + ", " + ;
                "teors = "      + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Teor.Value))      + ;
                " WHERE cpros = " + EscaparSQL(loc_cCpros)

            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar dados do produto em SigCdPro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberacao de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(42), loc_nI
        *-- Lista de todos os cursors possiveis deste form
        loc_aCursors(1)  = "cursor_4c_Dados"
        loc_aCursors(2)  = "cursor_4c_Busca"
        loc_aCursors(3)  = "cursor_4c_ProdDados"
        loc_aCursors(4)  = "cursor_4c_DescGru"
        loc_aCursors(5)  = "cursor_4c_DescLin"
        loc_aCursors(6)  = "cursor_4c_DescCol"
        loc_aCursors(7)  = "cursor_4c_DescIfor"
        loc_aCursors(8)  = "cursor_4c_ValPro"
        loc_aCursors(9)  = "cursor_4c_ValGru"
        loc_aCursors(10) = "cursor_4c_Registro"
        *-- Fase 6: cursors adicionais
        loc_aCursors(11) = "cursor_4c_DescCor"
        loc_aCursors(12) = "cursor_4c_DescTam"
        loc_aCursors(13) = "cursor_4c_DescFinP"
        loc_aCursors(14) = "cursor_4c_DescAcb"
        loc_aCursors(15) = "cursor_4c_DescClass"
        loc_aCursors(16) = "cursor_4c_DescLocal"
        loc_aCursors(17) = "cursor_4c_DescUni"
        loc_aCursors(18) = "cursor_4c_DescMoe"
        loc_aCursors(19) = "cursor_4c_BuscaCor"
        loc_aCursors(20) = "cursor_4c_BuscaTam"
        loc_aCursors(21) = "cursor_4c_BuscaFinP"
        loc_aCursors(22) = "cursor_4c_BuscaAcb"
        loc_aCursors(23) = "cursor_4c_BuscaClass"
        loc_aCursors(24) = "cursor_4c_BuscaLocal"
        loc_aCursors(25) = "cursor_4c_BuscaUni"
        loc_aCursors(26) = "cursor_4c_BuscaUniP"
        loc_aCursors(27) = "cursor_4c_BuscaMoe"
        loc_aCursors(28) = "cursor_4c_BuscaGrupo"
        loc_aCursors(29) = "cursor_4c_ValGru"
        loc_aCursors(30) = "cursor_4c_DescGru"
        *-- Fase 9: cursors de composicao
        loc_aCursors(31) = "cursor_4c_Compo"
        loc_aCursors(32) = "cursor_4c_SubCp"
        loc_aCursors(33) = "cursor_4c_TotGrupo"
        loc_aCursors(34) = "cursor_4c_BuscaMoeCompo"
        loc_aCursors(35) = "cursor_4c_BuscaAuxMoe"
        *-- Fase 10: cursors de custo
        loc_aCursors(36) = "cursor_4c_CustoCompo"
        loc_aCursors(37) = "cursor_4c_TotGrupoCusto"
        *-- Fase 12: cursors de fases de processo e matrizes
        loc_aCursors(38) = "cursor_4c_Fase"
        loc_aCursors(39) = "cursor_4c_Matrizes"
        *-- Fase 13: cursor dados fiscais
        loc_aCursors(40) = "cursor_4c_Cmv"
        *-- Fase 14: cursors designer
        loc_aCursors(41) = "cursor_4c_Tarefas"
        loc_aCursors(42) = "cursor_4c_Arquivos"

        FOR loc_nI = 1 TO 42
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR

        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Produtos
* Tabela: SigPrFtp
*==============================================================================
DEFINE CLASS ProdutoBO AS BusinessBase

  *-- Propriedades da tabela SigPrFtp
  this_cCgrus    = ""   && char(3)   - Grupo
  this_cCods     = ""   && char(2)   - Codigo
  this_nCoefs    = 0    && numeric(6,4) - Coeficiente
  this_cCpros    = ""   && char(14)  - Codigo do Produto
  this_cPkchaves = ""   && char(20)  - Chave Primaria
  this_nValors   = 0    && numeric(10,2) - Valor

  *===========================================================================
  FUNCTION Init()
  *===========================================================================
    THIS.this_cTabela     = "SigPrFtp"
    THIS.this_cCampoChave = "pkchaves"

    RETURN DODEFAULT()
  ENDFUNC

  *===========================================================================
  FUNCTION ObterChavePrimaria()
  *===========================================================================
    RETURN THIS.this_cPkchaves
  ENDFUNC

  *===========================================================================
  FUNCTION CarregarDoCursor(par_cAliasCursor)
  *===========================================================================
    LOCAL loc_lResultado
    loc_lResultado = .F.

    TRY
      SELECT (par_cAliasCursor)
      THIS.this_cCgrus    = ALLTRIM(cgrus)
      THIS.this_cCods     = ALLTRIM(cods)
      THIS.this_nCoefs    = coefs
      THIS.this_cCpros    = ALLTRIM(cpros)
      THIS.this_cPkchaves = ALLTRIM(pkchaves)
      THIS.this_nValors   = valors
      loc_lResultado = .T.
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao carregar cursor")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  FUNCTION Buscar(par_cFiltro)
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      IF EMPTY(par_cFiltro)
        loc_cSQL = "SELECT * FROM SigPrFtp ORDER BY cpros"
      ELSE
        loc_cSQL = "SELECT * FROM SigPrFtp WHERE " + par_cFiltro + " ORDER BY cpros"
      ENDIF

      IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
        loc_lResultado = .T.
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  FUNCTION CarregarPorCodigo(par_cCodigo)
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "SELECT * FROM SigPrFtp WHERE pkchaves = " + EscaparSQL(par_cCodigo)

      IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro") > 0
        IF !EOF("cursor_4c_Registro")
          loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Registro")
        ENDIF
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao carregar produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED PROCEDURE Inserir()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "INSERT INTO SigPrFtp (cgrus, cods, coefs, cpros, pkchaves, valors) VALUES (" + ;
        EscaparSQL(THIS.this_cCgrus)    + ", " + ;
        EscaparSQL(THIS.this_cCods)     + ", " + ;
        FormatarNumeroSQL(THIS.this_nCoefs)   + ", " + ;
        EscaparSQL(THIS.this_cCpros)    + ", " + ;
        EscaparSQL(THIS.this_cPkchaves) + ", " + ;
        FormatarNumeroSQL(THIS.this_nValors)  + ")"

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
        THIS.RegistrarAuditoria("I")
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao inserir produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED PROCEDURE Atualizar()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "UPDATE SigPrFtp SET " + ;
        "cgrus = "   + EscaparSQL(THIS.this_cCgrus)          + ", " + ;
        "cods = "    + EscaparSQL(THIS.this_cCods)           + ", " + ;
        "coefs = "   + FormatarNumeroSQL(THIS.this_nCoefs)   + ", " + ;
        "cpros = "   + EscaparSQL(THIS.this_cCpros)          + ", " + ;
        "valors = "  + FormatarNumeroSQL(THIS.this_nValors)  + ;
        " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkchaves)

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
        THIS.RegistrarAuditoria("A")
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED FUNCTION ExecutarExclusao()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      THIS.RegistrarAuditoria("E")

      loc_cSQL = "DELETE FROM SigPrFtp WHERE pkchaves = " + EscaparSQL(THIS.this_cPkchaves)

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao excluir produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

ENDDEFINE

