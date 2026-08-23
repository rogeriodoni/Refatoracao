# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormProduto.prg] Indicador de pendencia: * ConfigurarPgDadosStub - Cria label indicativo em tabs nao implement

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
* Migrado de: SIGCDPRO.SCX (frmcadastro)
*==============================================================================
* FASE 3/8: Estrutura base do form (PageFrame + containers vazios)
* Fases seguintes adicionarao:
*   Fase 4: Grid e botoes CRUD
*   Fases 5-6: TextBoxes de dados (pgframeDados com 8 abas internas)
*   Fases 7-8: Eventos e handlers
*==============================================================================

DEFINE CLASS FormProduto AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
    Height      = 600
    Width       = 1010
    Caption     = "Cadastro de Produtos"
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
        LOCAL loc_lSucesso, loException
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ProdutoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar ProdutoBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormProduto.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                *-- Propagar Caption para labels do cabecalho (Problema 44)
                IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra") = "O"
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                ENDIF
                IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
                    THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormProduto:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormProduto.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1 completa: cabecalho + botoes + grid
    * FASE 4: Grid e botoes CRUD adicionados ao esqueleto da Fase 3
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
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

        *-- Container Botoes CRUD (Grupo_op legado: Left=552, Top=-1, Width=385, Height=85)
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

        *-- Botao Incluir (Inserir no legado)
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

        *-- Botao Visualizar (Consultar no legado)
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

        *-- Botao Buscar (Procurar no legado)
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
        *-- Legado: Grupo_Saida.Left=927, Top=-1. Canonico: Left=917, Top=29, Width=90
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

        *-- Botao Encerrar - PADRAO CANONICO
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

        *-- Grid de listagem de produtos
        *-- Original: Grade.Top=173, Left=11, Width=972, Height=422, ColumnCount=7
        *-- Top nao precisa de compensacao pois grade esta dentro da page (coordenadas relativas)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        *-- ColumnCount FORA do WITH (auto-bind VFP9)
        loc_oPagina.grd_4c_Lista.ColumnCount = 7
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 11
            .Width              = 972
            .Height             = 422
            .FontName           = "Tahoma"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 18
            .ScrollBars         = 3
            .GridLines          = 3
            .AllowHeaderSizing  = .F.
            .AllowRowSizing     = .F.
            .Visible            = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2: BotoesAcao + pgf_4c_Dados (8 abas)
    * FASE 5: Implementacao completa com todos os campos de SigCdPro
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container BotoesAcao (canonico: Left=842, Top=33, Width=160, Height=85)
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

        *-- Botao Salvar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 70
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
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

        *-- pgf_4c_Dados: PageFrame interno com 8 abas (original: pgframeDados)
        *-- Original: Top=-58(abas ocultas), Width=1009, Height=656
        *-- Novo: abas visiveis abaixo dos BotoesAcao
        loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
        loc_oPagina.pgf_4c_Dados.PageCount = 8
        WITH loc_oPagina.pgf_4c_Dados
            .Top     = 120
            .Left    = 0
            .Width   = THIS.Width
            .Height  = 500
            .Tabs    = .T.
            .Visible = .T.

            .Page1.Caption = "Dados Principais"
            .Page2.Caption = "Custos"
            .Page3.Caption = "Dados Fiscais"
            .Page4.Caption = "Processos"
            .Page5.Caption = "Consumo"
            .Page6.Caption = "Composi" + CHR(231) + CHR(227) + "o"
            .Page7.Caption = "Designer"
            .Page8.Caption = "Servi" + CHR(231) + "os"
        ENDWITH

        *-- Tab 1: Dados Principais (campos principais de SigCdPro)
        THIS.ConfigurarPgDados(loc_oPagina.pgf_4c_Dados.Page1)

        *-- Tabs 2-8: conteudo a implementar em fases posteriores
        THIS.ConfigurarPgDadosStub(loc_oPagina.pgf_4c_Dados.Page2, ;
            "Custos / Composi" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")
        THIS.ConfigurarPgDadosStub(loc_oPagina.pgf_4c_Dados.Page3, ;
            "Dados Fiscais (NCM, ICMS, IPI, CFOP)")
        THIS.ConfigurarPgDadosStub(loc_oPagina.pgf_4c_Dados.Page4, ;
            "Processos de Produ" + CHR(231) + CHR(227) + "o")
        THIS.ConfigurarPgDadosStub(loc_oPagina.pgf_4c_Dados.Page5, ;
            "Consumo por Processo")
        THIS.ConfigurarPgDadosStub(loc_oPagina.pgf_4c_Dados.Page6, ;
            "Composi" + CHR(231) + CHR(227) + "o (Subprodutos)")
        THIS.ConfigurarPgDadosStub(loc_oPagina.pgf_4c_Dados.Page7, ;
            "Informa" + CHR(231) + CHR(245) + "es de Design")
        THIS.ConfigurarPgDadosStub(loc_oPagina.pgf_4c_Dados.Page8, ;
            "Servi" + CHR(231) + "os Associados")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPgDados - Configura Tab1 "Dados Principais" do pgf_4c_Dados
    * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgDados
    * Coordenadas originais preservadas (relativas ao page content)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgDados(par_oPg)
        LOCAL loc_oPg
        loc_oPg = par_oPg
        loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Situacao (opc_situacao: Top=114, Left=758, situas=numeric)
        loc_oPg.AddObject("opt_4c_Situacao", "OptionGroup")
        WITH loc_oPg.opt_4c_Situacao
            .ButtonCount = 2
            .Value       = 1
            .Top         = 114
            .Left        = 758
            .Width       = 156
            .Height      = 25
            .BackStyle   = 0
            .BorderStyle = 0
            .Visible     = .T.
            .Option1.Caption   = "Ativo"
            .Option1.FontName  = "Tahoma"
            .Option1.FontSize  = 8
            .Option1.BackStyle = 0
            .Option1.ForeColor = RGB(90, 90, 90)
            .Option1.Top       = 5
            .Option1.Left      = 5
            .Option1.Height    = 15
            .Option1.AutoSize  = .T.
            .Option2.Caption   = "Inativo"
            .Option2.FontName  = "Tahoma"
            .Option2.FontSize  = 8
            .Option2.BackStyle = 0
            .Option2.ForeColor = RGB(90, 90, 90)
            .Option2.Top       = 5
            .Option2.Left      = 80
            .Option2.Height    = 15
            .Option2.AutoSize  = .T.
        ENDWITH

        *-- Data da Situacao (getDtSituas: Top=115, Left=918, readonly)
        loc_oPg.AddObject("txt_4c_DtSituas", "TextBox")
        WITH loc_oPg.txt_4c_DtSituas
            .Top           = 115
            .Left          = 918
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Value         = {}
            .Enabled       = .F.
            .BackColor     = RGB(240, 240, 240)
            .ToolTipText   = "Data da Situa" + CHR(231) + CHR(227) + "o"
            .Visible       = .T.
        ENDWITH

        *-- Label "Produto:"
        loc_oPg.AddObject("lbl_4c_LbCpros", "Label")
        WITH loc_oPg.lbl_4c_LbCpros
            .Caption   = "Produto :"
            .Top       = 121
            .Left      = 47
            .Width     = 53
            .Height    = 15
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Produto (getCpro: Top=117, Left=102, Width=108)
        loc_oPg.AddObject("txt_4c_Cpros", "TextBox")
        WITH loc_oPg.txt_4c_Cpros
            .Top           = 117
            .Left          = 102
            .Width         = 108
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 14
            .Visible       = .T.
        ENDWITH

        *-- Descricao do Produto (getDpro: Top=117, Left=211, Width=290)
        loc_oPg.AddObject("txt_4c_Dpros", "TextBox")
        WITH loc_oPg.txt_4c_Dpros
            .Top           = 117
            .Left          = 211
            .Width         = 290
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 65
            .Visible       = .T.
        ENDWITH

        *-- Label "Barra:"
        loc_oPg.AddObject("lbl_4c_LbCbars", "Label")
        WITH loc_oPg.lbl_4c_LbCbars
            .Caption   = "Barra :"
            .Top       = 143
            .Left      = 595
            .Width     = 35
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo de Barras (getCbar: Top=139, Left=633, Width=108, numeric)
        loc_oPg.AddObject("txt_4c_Cbars", "TextBox")
        WITH loc_oPg.txt_4c_Cbars
            .Value         = 0
            .Top           = 139
            .Left          = 633
            .Width         = 108
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- Label "Grupo:"
        loc_oPg.AddObject("lbl_4c_LbCgrus", "Label")
        WITH loc_oPg.lbl_4c_LbCgrus
            .Caption   = "Grupo :"
            .Top       = 190
            .Left      = 62
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Grupo (getCgru: Top=186, Left=102, Width=31, MaxLength=3)
        loc_oPg.AddObject("txt_4c_Cgrus", "TextBox")
        WITH loc_oPg.txt_4c_Cgrus
            .Top           = 186
            .Left          = 102
            .Width         = 31
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyDown", THIS, "TxtCgrusKeyDown")
        BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "ValidarCgrus")

        *-- Descricao do Grupo (getDgru: Top=186, Left=134, Width=171, readonly)
        loc_oPg.AddObject("txt_4c_Dgrus", "TextBox")
        WITH loc_oPg.txt_4c_Dgrus
            .Top           = 186
            .Left          = 134
            .Width         = 171
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Label "Subgrupo:"
        loc_oPg.AddObject("lbl_4c_LbSGrus", "Label")
        WITH loc_oPg.lbl_4c_LbSGrus
            .Caption   = "Subgrupo :"
            .Top       = 213
            .Left      = 45
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Sub-grupo (GetCSGru: Top=209, Left=102, Width=52, MaxLength=6)
        loc_oPg.AddObject("txt_4c_SGrus", "TextBox")
        WITH loc_oPg.txt_4c_SGrus
            .Top           = 209
            .Left          = 102
            .Width         = 52
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 6
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_SGrus, "KeyPress", THIS, "ValidarSGrus")

        *-- Descricao do Sub-grupo (GetDsGru: Top=209, Left=155, Width=150, readonly)
        loc_oPg.AddObject("txt_4c_DsGrus", "TextBox")
        WITH loc_oPg.txt_4c_DsGrus
            .Top           = 209
            .Left          = 155
            .Width         = 150
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Label "Linha:"
        loc_oPg.AddObject("lbl_4c_LbLinhas", "Label")
        WITH loc_oPg.lbl_4c_LbLinhas
            .Caption   = "Linha :"
            .Top       = 236
            .Left      = 66
            .Width     = 34
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo da Linha (GetLin: Top=232, Left=102, Width=80)
        loc_oPg.AddObject("txt_4c_Linhas", "TextBox")
        WITH loc_oPg.txt_4c_Linhas
            .Top           = 232
            .Left          = 102
            .Width         = 80
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Linhas, "KeyPress", THIS, "ValidarLinhas")

        *-- Descricao da Linha (GetDLin: Top=232, Left=183, Width=196, readonly)
        loc_oPg.AddObject("txt_4c_DLinhas", "TextBox")
        WITH loc_oPg.txt_4c_DLinhas
            .Top           = 232
            .Left          = 183
            .Width         = 196
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Label "Obs Pessoal:" (right column)
        loc_oPg.AddObject("lbl_4c_LbObspes", "Label")
        WITH loc_oPg.lbl_4c_LbObspes
            .Caption   = "Obs Pessoal :"
            .Top       = 239
            .Left      = 563
            .Width     = 67
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Obs Pessoal (getObs1: Top=235, Left=633, Width=159, MaxLength=30)
        loc_oPg.AddObject("txt_4c_Obspes", "TextBox")
        WITH loc_oPg.txt_4c_Obspes
            .Top           = 235
            .Left          = 633
            .Width         = 159
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 30
            .Visible       = .T.
        ENDWITH

        *-- Label "Obs Pedidos:" (right column)
        loc_oPg.AddObject("lbl_4c_LbObspeds", "Label")
        WITH loc_oPg.lbl_4c_LbObspeds
            .Caption   = "Obs Pedidos :"
            .Top       = 263
            .Left      = 563
            .Width     = 67
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Obs Pedidos (getObs2: Top=259, Left=633, Width=159, MaxLength=30)
        loc_oPg.AddObject("txt_4c_Obspeds", "TextBox")
        WITH loc_oPg.txt_4c_Obspeds
            .Top           = 259
            .Left          = 633
            .Width         = 159
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 30
            .Visible       = .T.
        ENDWITH

        *-- Label "Grupo de Venda:"
        loc_oPg.AddObject("lbl_4c_LbColecoes", "Label")
        WITH loc_oPg.lbl_4c_LbColecoes
            .Caption   = "Grupo de Venda :"
            .Top       = 258
            .Left      = 14
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo Grupo de Venda/Colecao (GetCol: Top=255, Left=102, Width=80)
        loc_oPg.AddObject("txt_4c_Colecoes", "TextBox")
        WITH loc_oPg.txt_4c_Colecoes
            .Top           = 255
            .Left          = 102
            .Width         = 80
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Colecoes, "KeyPress", THIS, "ValidarColecoes")

        *-- Descricao Colecao (GetDCol: Top=255, Left=183, Width=318, readonly)
        loc_oPg.AddObject("txt_4c_DColecoes", "TextBox")
        WITH loc_oPg.txt_4c_DColecoes
            .Top           = 255
            .Left          = 183
            .Width         = 318
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Label "Fornecedor:"
        loc_oPg.AddObject("lbl_4c_LbIfors", "Label")
        WITH loc_oPg.lbl_4c_LbIfors
            .Caption   = "Fornecedor :"
            .Top       = 305
            .Left      = 36
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo Fornecedor (getIfor: Top=301, Left=102, Width=80, MaxLength=10)
        loc_oPg.AddObject("txt_4c_Ifors", "TextBox")
        WITH loc_oPg.txt_4c_Ifors
            .Top           = 301
            .Left          = 102
            .Width         = 80
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyDown", THIS, "TxtIforsKeyDown")
        BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyPress", THIS, "ValidarIfors")

        *-- Descricao Fornecedor (getDfor: Top=301, Left=183, Width=318, readonly)
        loc_oPg.AddObject("txt_4c_Dfors", "TextBox")
        WITH loc_oPg.txt_4c_Dfors
            .Top           = 301
            .Left          = 183
            .Width         = 318
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Label "Cor:"
        loc_oPg.AddObject("lbl_4c_LbCodCors", "Label")
        WITH loc_oPg.lbl_4c_LbCodCors
            .Caption   = "Cor :"
            .Top       = 328
            .Left      = 361
            .Width     = 25
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo Cor (getCor: Top=324, Left=390, Width=38)
        loc_oPg.AddObject("txt_4c_CodCors", "TextBox")
        WITH loc_oPg.txt_4c_CodCors
            .Top           = 324
            .Left          = 390
            .Width         = 38
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 4
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CodCors, "KeyPress", THIS, "ValidarCodCors")

        *-- Label "Tam:"
        loc_oPg.AddObject("lbl_4c_LbCodTams", "Label")
        WITH loc_oPg.lbl_4c_LbCodTams
            .Caption   = "Tam:"
            .Top       = 328
            .Left      = 431
            .Width     = 30
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo Tamanho (getTam: Top=324, Left=463, Width=38)
        loc_oPg.AddObject("txt_4c_CodTams", "TextBox")
        WITH loc_oPg.txt_4c_CodTams
            .Top           = 324
            .Left          = 463
            .Width         = 38
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 4
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CodTams, "KeyPress", THIS, "ValidarCodTams")

        *-- Label "Ref. Fornecedor:"
        loc_oPg.AddObject("lbl_4c_LbReffs", "Label")
        WITH loc_oPg.lbl_4c_LbReffs
            .Caption   = "Ref. Fornecedor :"
            .Top       = 327
            .Left      = 12
            .Width     = 88
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Ref. Fornecedor (getRefs: Top=324, Left=102, Width=221, MaxLength=40)
        loc_oPg.AddObject("txt_4c_Reffs", "TextBox")
        WITH loc_oPg.txt_4c_Reffs
            .Top           = 324
            .Left          = 102
            .Width         = 221
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 40
            .Visible       = .T.
        ENDWITH

        *-- Label "Valor de Custo:"
        loc_oPg.AddObject("lbl_4c_LbCustofs", "Label")
        WITH loc_oPg.lbl_4c_LbCustofs
            .Caption   = "Valor de Custo :"
            .Top       = 311
            .Left      = 551
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Custo Total (getCtotal: Top=307, Left=633, Width=127, numeric)
        loc_oPg.AddObject("txt_4c_Custofs", "TextBox")
        WITH loc_oPg.txt_4c_Custofs
            .Value         = 0
            .Top           = 307
            .Left          = 633
            .Width         = 127
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Moeda do Custo (getMctotal: Top=307, Left=761, Width=31, MaxLength=3)
        loc_oPg.AddObject("txt_4c_MoeCusfs", "TextBox")
        WITH loc_oPg.txt_4c_MoeCusfs
            .Top           = 307
            .Left          = 761
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 3
            .BackColor     = RGB(240, 240, 240)
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label "Valor de Venda:"
        loc_oPg.AddObject("lbl_4c_LbPvens", "Label")
        WITH loc_oPg.lbl_4c_LbPvens
            .Caption   = "Valor de Venda :"
            .Top       = 335
            .Left      = 510
            .Width     = 120
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- Preco de Venda (getPvenda: Top=331, Left=633, Width=127, numeric)
        loc_oPg.AddObject("txt_4c_Pvens", "TextBox")
        WITH loc_oPg.txt_4c_Pvens
            .Value         = 0
            .Top           = 331
            .Left          = 633
            .Width         = 127
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Moeda de Venda (getMpvenda: Top=331, Left=761, Width=31, MaxLength=3)
        loc_oPg.AddObject("txt_4c_Moevs", "TextBox")
        WITH loc_oPg.txt_4c_Moevs
            .Top           = 331
            .Left          = 761
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 3
            .BackColor     = RGB(240, 240, 240)
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label "Fator de Venda:"
        loc_oPg.AddObject("lbl_4c_LbFvendas", "Label")
        WITH loc_oPg.lbl_4c_LbFvendas
            .Caption   = "Fator de Venda :"
            .Top       = 359
            .Left      = 544
            .Width     = 86
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Fator de Venda (getFvenda: Top=355, Left=633, Width=127, numeric)
        loc_oPg.AddObject("txt_4c_Fvendas", "TextBox")
        WITH loc_oPg.txt_4c_Fvendas
            .Value         = 0
            .Top           = 355
            .Left          = 633
            .Width         = 127
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Moeda do Fator (getMfvenda: Top=355, Left=761, Width=31, MaxLength=3)
        loc_oPg.AddObject("txt_4c_Moepvs", "TextBox")
        WITH loc_oPg.txt_4c_Moepvs
            .Top           = 355
            .Left          = 761
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 3
            .BackColor     = RGB(240, 240, 240)
            .ReadOnly      = .T.
            .Visible       = .T.
        ENDWITH

        *-- Label "Acabamento:"
        loc_oPg.AddObject("lbl_4c_LbCodAcbs", "Label")
        WITH loc_oPg.lbl_4c_LbCodAcbs
            .Caption   = "Acabamento :"
            .Top       = 374
            .Left      = 42
            .Width     = 58
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Acabamento (get_codacb: Top=370, Left=102, Width=31)
        loc_oPg.AddObject("txt_4c_CodAcbs", "TextBox")
        WITH loc_oPg.txt_4c_CodAcbs
            .Top           = 370
            .Left          = 102
            .Width         = 31
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 3
            .ToolTipText   = "Acabamento"
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_CodAcbs, "KeyPress", THIS, "ValidarCodAcbs")

        *-- Descricao do Acabamento (get_Dacb: Top=370, Left=134, Width=150, readonly)
        loc_oPg.AddObject("txt_4c_DAcbs", "TextBox")
        WITH loc_oPg.txt_4c_DAcbs
            .Top           = 370
            .Left          = 134
            .Width         = 150
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Label "Unidades (1):"
        loc_oPg.AddObject("lbl_4c_LbCunis", "Label")
        WITH loc_oPg.lbl_4c_LbCunis
            .Caption   = "Unidades (1) :"
            .Top       = 420
            .Left      = 30
            .Width     = 70
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Unidade de Medida (Get_Cuni: Top=416, Left=102, Width=31, MaxLength=3)
        loc_oPg.AddObject("txt_4c_Cunis", "TextBox")
        WITH loc_oPg.txt_4c_Cunis
            .Top           = 416
            .Left          = 102
            .Width         = 31
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .MaxLength     = 3
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPg.txt_4c_Cunis, "KeyPress", THIS, "ValidarCunis")

        *-- Descricao da Unidade (Get_Duni: Top=416, Left=134, Width=150, readonly)
        loc_oPg.AddObject("txt_4c_Dunis", "TextBox")
        WITH loc_oPg.txt_4c_Dunis
            .Top           = 416
            .Left          = 134
            .Width         = 150
            .Height        = 22
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .BackColor     = RGB(240, 240, 240)
            .Visible       = .T.
        ENDWITH

        *-- Label "Data / Usuario"
        loc_oPg.AddObject("lbl_4c_LbDtIncs", "Label")
        WITH loc_oPg.lbl_4c_LbDtIncs
            .Caption   = "Data / Usu" + CHR(225) + "rio"
            .Top       = 420
            .Left      = 827
            .Width     = 84
            .Height    = 15
            .FontName  = "Tahoma"
            .FontBold  = .T.
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Data de Inclusao (Get_DtIncs: Top=569->adaptar, Left=827, Width=79, readonly)
        loc_oPg.AddObject("txt_4c_DtIncs", "TextBox")
        WITH loc_oPg.txt_4c_DtIncs
            .Value         = {}
            .Top           = 437
            .Left          = 827
            .Width         = 79
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
            .BackColor     = RGB(240, 240, 240)
            .ToolTipText   = "Data de inclus" + CHR(227) + "o"
            .Visible       = .T.
        ENDWITH

        *-- Data de Alteracao (getDataAlts: Top=569->adaptar, Left=907, readonly)
        loc_oPg.AddObject("txt_4c_DtAlts", "TextBox")
        WITH loc_oPg.txt_4c_DtAlts
            .Value         = {}
            .Top           = 437
            .Left          = 907
            .Width         = 79
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .Enabled       = .F.
            .BackColor     = RGB(240, 240, 240)
            .ToolTipText   = "Data de altera" + CHR(231) + CHR(227) + "o"
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *===========================================================================
    * ConfigurarPgDadosStub - Cria label indicativo em tabs nao implementadas
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgDadosStub(par_oPg, par_cConteudo)
        par_oPg.AddObject("lbl_4c_StubInfo", "Label")
        WITH par_oPg.lbl_4c_StubInfo
            .Caption   = par_cConteudo
            .Top       = 50
            .Left      = 30
            .Width     = 600
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 10
            .FontBold  = .F.
            .ForeColor = RGB(120, 120, 120)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH
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
    * CarregarLista - Carrega dados no grid da Page1
    * CRITICO: Definir ControlSources APOS RecordSource (auto-bind)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ENDIF

            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- RecordSource e ColumnCount FORA do WITH (auto-bind VFP9)
                loc_oGrid.ColumnCount  = 7
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- ControlSources APOS RecordSource (OBRIGATORIO - auto-bind sobrescreve)
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
                loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.colecoes"
                loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.situas"

                *-- Widths (originais: 110, 408, 40, 70, 150, 100, 16)
                loc_oGrid.Column1.Width = 110
                loc_oGrid.Column2.Width = 408
                loc_oGrid.Column3.Width = 40
                loc_oGrid.Column4.Width = 70
                loc_oGrid.Column5.Width = 150
                loc_oGrid.Column6.Width = 100
                loc_oGrid.Column7.Width = 40

                *-- Headers APOS RecordSource (RecordSource reseta captions)
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Grupo"
                loc_oGrid.Column4.Header1.Caption = "Sub-grupo"
                loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
                loc_oGrid.Column6.Header1.Caption = "Grp. Venda"
                loc_oGrid.Column7.Header1.Caption = "Sit."

                *-- ReadOnly em todas as colunas (grade de consulta)
                loc_oGrid.Column1.ReadOnly = .T.
                loc_oGrid.Column2.ReadOnly = .T.
                loc_oGrid.Column3.ReadOnly = .T.
                loc_oGrid.Column4.ReadOnly = .T.
                loc_oGrid.Column5.ReadOnly = .T.
                loc_oGrid.Column6.ReadOnly = .T.
                loc_oGrid.Column7.ReadOnly = .T.

                *-- Movable/Resizable (original: todos .F.)
                loc_oGrid.Column1.Movable = .F.
                loc_oGrid.Column2.Movable = .F.
                loc_oGrid.Column3.Movable = .F.
                loc_oGrid.Column4.Movable = .F.
                loc_oGrid.Column5.Movable = .F.
                loc_oGrid.Column6.Movable = .F.
                loc_oGrid.Column7.Movable = .F.

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormProduto.CarregarLista")
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
                "FormProduto.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Formata visual do grid de lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        TRY
            WITH par_oGrid
                .FontName = "Tahoma"
                .FontSize = 8
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
                "FormProduto.FormatarGridLista")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Abre Page2 para incluir novo produto
    * PUBLIC: BINDEVENT requer metodo publico
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
    * BtnVisualizarClick - Abre Page2 em modo somente leitura
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um produto para visualizar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Abre Page2 para alterar produto selecionado
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um produto para alterar.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui produto selecionado com confirmacao
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDescricao
        loc_cCodigo    = ""
        loc_cDescricao = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cpros)
            loc_cDescricao = ALLTRIM(cursor_4c_Dados.dpros)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MsgAviso("Selecione um produto para excluir.")
        ELSE
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do produto [" + ;
                    loc_cCodigo + "] - " + loc_cDescricao + "?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Produto exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Busca produto pelo codigo ou descricao
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo, loc_nRet, loException
        loc_cCodigo = ""

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
                "cursor_4c_BuscaProduto")

            IF loc_nRet > 0 AND USED("cursor_4c_BuscaProduto")
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaProduto", "cpros", "dpros", ;
                        "Buscar Produto")
                    loc_oBusca.Mostrar()
                    IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                        loc_cCodigo = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    loc_oBusca = .NULL.
                ENDIF
            ENDIF

            IF USED("cursor_4c_BuscaProduto")
                USE IN cursor_4c_BuscaProduto
            ENDIF

            IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                LOCATE FOR ALLTRIM(cpros) == loc_cCodigo
                THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_BuscaProduto")
                USE IN cursor_4c_BuscaProduto
            ENDIF
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos de entrada do pgDados.Page1
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            WITH loc_oPg
                .txt_4c_Cpros.Value     = ""
                .txt_4c_Dpros.Value     = ""
                .txt_4c_Cbars.Value     = 0
                .opt_4c_Situacao.Value  = 1
                .txt_4c_DtSituas.Value  = {}
                .txt_4c_Cgrus.Value     = ""
                .txt_4c_Dgrus.Value     = ""
                .txt_4c_SGrus.Value     = ""
                .txt_4c_DsGrus.Value    = ""
                .txt_4c_Linhas.Value    = ""
                .txt_4c_DLinhas.Value   = ""
                .txt_4c_Obspes.Value    = ""
                .txt_4c_Obspeds.Value   = ""
                .txt_4c_Colecoes.Value  = ""
                .txt_4c_DColecoes.Value = ""
                .txt_4c_Ifors.Value     = ""
                .txt_4c_Dfors.Value     = ""
                .txt_4c_Reffs.Value     = ""
                .txt_4c_CodCors.Value   = ""
                .txt_4c_CodTams.Value   = ""
                .txt_4c_Custofs.Value   = 0
                .txt_4c_MoeCusfs.Value  = ""
                .txt_4c_Pvens.Value     = 0
                .txt_4c_Moevs.Value     = ""
                .txt_4c_Fvendas.Value   = 0
                .txt_4c_Moepvs.Value    = ""
                .txt_4c_CodAcbs.Value   = ""
                .txt_4c_DAcbs.Value     = ""
                .txt_4c_Cunis.Value     = ""
                .txt_4c_Dunis.Value     = ""
                .txt_4c_DtIncs.Value    = {}
                .txt_4c_DtAlts.Value    = {}
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, ;
                "FormProduto.LimparCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita/desabilita campos de entrada por modo
    * par_lHabilitar=.T. em INCLUIR/ALTERAR, .F. em VISUALIZAR
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lModoIncluir, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_lModoIncluir = (THIS.this_cModoAtual == "INCLUIR")

            WITH loc_oPg
                *-- Codigo do produto: somente editavel em INCLUIR (PK nao pode mudar em ALTERAR)
                .txt_4c_Cpros.Enabled    = par_lHabilitar AND loc_lModoIncluir
                *-- Demais campos de entrada
                .txt_4c_Dpros.Enabled    = par_lHabilitar
                .txt_4c_Cbars.Enabled    = par_lHabilitar
                .opt_4c_Situacao.Enabled = par_lHabilitar
                .txt_4c_Cgrus.Enabled    = par_lHabilitar
                .txt_4c_SGrus.Enabled    = par_lHabilitar
                .txt_4c_Linhas.Enabled   = par_lHabilitar
                .txt_4c_Obspes.Enabled   = par_lHabilitar
                .txt_4c_Obspeds.Enabled  = par_lHabilitar
                .txt_4c_Colecoes.Enabled = par_lHabilitar
                .txt_4c_Ifors.Enabled    = par_lHabilitar
                .txt_4c_Reffs.Enabled    = par_lHabilitar
                .txt_4c_CodCors.Enabled  = par_lHabilitar
                .txt_4c_CodTams.Enabled  = par_lHabilitar
                .txt_4c_CodAcbs.Enabled  = par_lHabilitar
                .txt_4c_Cunis.Enabled    = par_lHabilitar
            ENDWITH

            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5)
                WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
                    .cmd_4c_Salvar.Enabled = par_lHabilitar
                    .Visible     = .T.
                ENDWITH
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
                "FormProduto.HabilitarCampos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta botoes por modo atual
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lEhLista
        loc_lEhLista = (THIS.this_cModoAtual == "LISTA")

        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
                WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
                    IF PEMSTATUS(.cmd_4c_Incluir, "Enabled", 5)
                        .cmd_4c_Incluir.Enabled   = loc_lEhLista
                        .cmd_4c_Alterar.Enabled   = loc_lEhLista
                        .cmd_4c_Excluir.Enabled   = loc_lEhLista
                        .cmd_4c_Visualizar.Enabled = loc_lEhLista
                        .cmd_4c_Buscar.Enabled    = loc_lEhLista
                    ENDIF
                    .Visible     = .T.
                ENDWITH
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
                "FormProduto.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores do pgDados.Page1 para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg, loc_oBO, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_oBO = THIS.this_oBusinessObject

            loc_oBO.this_cCpros    = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
            loc_oBO.this_cDpros    = ALLTRIM(loc_oPg.txt_4c_Dpros.Value)
            loc_oBO.this_nCbars    = loc_oPg.txt_4c_Cbars.Value
            loc_oBO.this_nSituas   = loc_oPg.opt_4c_Situacao.Value
            loc_oBO.this_cCgrus    = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
            loc_oBO.this_cSgrus    = ALLTRIM(loc_oPg.txt_4c_SGrus.Value)
            loc_oBO.this_cLinhas   = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
            loc_oBO.this_cObspes   = ALLTRIM(loc_oPg.txt_4c_Obspes.Value)
            loc_oBO.this_cObspeds  = ALLTRIM(loc_oPg.txt_4c_Obspeds.Value)
            loc_oBO.this_cColecoes = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
            loc_oBO.this_cIfors    = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
            loc_oBO.this_cReffs    = ALLTRIM(loc_oPg.txt_4c_Reffs.Value)
            loc_oBO.this_cCodcors  = ALLTRIM(loc_oPg.txt_4c_CodCors.Value)
            loc_oBO.this_cCodtams  = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)
            loc_oBO.this_nCustofs  = loc_oPg.txt_4c_Custofs.Value
            loc_oBO.this_nPvens    = loc_oPg.txt_4c_Pvens.Value
            loc_oBO.this_nFvendas  = loc_oPg.txt_4c_Fvendas.Value
            loc_oBO.this_cCodacbs  = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)
            loc_oBO.this_cCunis    = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)

        CATCH TO loException
            MostrarErro("Erro ao transferir form->BO:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormProduto.FormParaBO")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do BO para os campos do pgDados.Page1
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg, loc_oBO, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_oBO = THIS.this_oBusinessObject

            loc_oPg.txt_4c_Cpros.Value     = ALLTRIM(loc_oBO.this_cCpros)
            loc_oPg.txt_4c_Dpros.Value     = ALLTRIM(loc_oBO.this_cDpros)
            loc_oPg.txt_4c_Cbars.Value     = loc_oBO.this_nCbars
            loc_oPg.opt_4c_Situacao.Value  = IIF(loc_oBO.this_nSituas = 1, 1, 2)
            loc_oPg.txt_4c_DtSituas.Value  = IIF(EMPTY(loc_oBO.this_dDtsituas), {}, ;
                TTOD(loc_oBO.this_dDtsituas))
            loc_oPg.txt_4c_Cgrus.Value     = ALLTRIM(loc_oBO.this_cCgrus)
            loc_oPg.txt_4c_Dgrus.Value     = ""
            loc_oPg.txt_4c_SGrus.Value     = ALLTRIM(loc_oBO.this_cSgrus)
            loc_oPg.txt_4c_DsGrus.Value    = ""
            loc_oPg.txt_4c_Linhas.Value    = ALLTRIM(loc_oBO.this_cLinhas)
            loc_oPg.txt_4c_DLinhas.Value   = ""
            loc_oPg.txt_4c_Obspes.Value    = ALLTRIM(loc_oBO.this_cObspes)
            loc_oPg.txt_4c_Obspeds.Value   = ALLTRIM(loc_oBO.this_cObspeds)
            loc_oPg.txt_4c_Colecoes.Value  = ALLTRIM(loc_oBO.this_cColecoes)
            loc_oPg.txt_4c_DColecoes.Value = ""
            loc_oPg.txt_4c_Ifors.Value     = ALLTRIM(loc_oBO.this_cIfors)
            loc_oPg.txt_4c_Dfors.Value     = ""
            loc_oPg.txt_4c_Reffs.Value     = ALLTRIM(loc_oBO.this_cReffs)
            loc_oPg.txt_4c_CodCors.Value   = ALLTRIM(loc_oBO.this_cCodcors)
            loc_oPg.txt_4c_CodTams.Value   = ALLTRIM(loc_oBO.this_cCodtams)
            loc_oPg.txt_4c_Custofs.Value   = loc_oBO.this_nCustofs
            loc_oPg.txt_4c_MoeCusfs.Value  = ALLTRIM(loc_oBO.this_cMoecusfs)
            loc_oPg.txt_4c_Pvens.Value     = loc_oBO.this_nPvens
            loc_oPg.txt_4c_Moevs.Value     = ALLTRIM(loc_oBO.this_cMoevs)
            loc_oPg.txt_4c_Fvendas.Value   = loc_oBO.this_nFvendas
            loc_oPg.txt_4c_Moepvs.Value    = ALLTRIM(loc_oBO.this_cMoepvs)
            loc_oPg.txt_4c_CodAcbs.Value   = ALLTRIM(loc_oBO.this_cCodacbs)
            loc_oPg.txt_4c_DAcbs.Value     = ""
            loc_oPg.txt_4c_Cunis.Value     = ALLTRIM(loc_oBO.this_cCunis)
            loc_oPg.txt_4c_Dunis.Value     = ""
            loc_oPg.txt_4c_DtIncs.Value    = IIF(EMPTY(loc_oBO.this_dDtincs), {}, ;
                TTOD(loc_oBO.this_dDtincs))
            loc_oPg.txt_4c_DtAlts.Value    = IIF(EMPTY(loc_oBO.this_dDtalts), {}, ;
                TTOD(loc_oBO.this_dDtalts))

            *-- Carregar descricoes dos campos lookup (silencioso - sem dialogo)
            THIS.CarregarDescricoes()

        CATCH TO loException
            MostrarErro("Erro ao transferir BO->form:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormProduto.BOParaForm")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirma e salva o produto
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN
        ENDIF

        IF !THIS.ValidarCampos()
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Produto salvo com sucesso!")
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela e volta para lista
    * PUBLIC: BINDEVENT requer metodo publico
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

        IF USED("cursor_4c_BuscaProduto")
            USE IN cursor_4c_BuscaProduto
        ENDIF

        DODEFAULT()
    ENDPROC

    *===========================================================================
    * CarregarDescricoes - Popula campos de descricao lookup (silencioso, sem dialog)
    * Chamado de BOParaForm para carregar descricoes ao exibir registro existente
    *===========================================================================
    PROTECTED PROCEDURE CarregarDescricoes()
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

            *-- Grupo (SigCdGrp: cgrus/dgrus)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpDesc")
                IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
                    loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpDesc.dgrus)
                ENDIF
                IF USED("cursor_4c_LkpDesc")
                    USE IN cursor_4c_LkpDesc
                ENDIF
            ENDIF

            *-- Linha (SigCdLin: linhas/descs)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpDesc")
                IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
                    loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpDesc.descs)
                ENDIF
                IF USED("cursor_4c_LkpDesc")
                    USE IN cursor_4c_LkpDesc
                ENDIF
            ENDIF

            *-- Colecao/Grupo de Venda (SigCdCol: colecoes/descs)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpDesc")
                IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
                    loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpDesc.descs)
                ENDIF
                IF USED("cursor_4c_LkpDesc")
                    USE IN cursor_4c_LkpDesc
                ENDIF
            ENDIF

            *-- Fornecedor (SigCdFor: ifors/dfors)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT dfors FROM SigCdFor WHERE ifors = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpDesc")
                IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
                    loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_LkpDesc.dfors)
                ENDIF
                IF USED("cursor_4c_LkpDesc")
                    USE IN cursor_4c_LkpDesc
                ENDIF
            ENDIF

            *-- Acabamento (SigCdAca: cods/descrs)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpDesc")
                IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
                    loc_oPg.txt_4c_DAcbs.Value = ALLTRIM(cursor_4c_LkpDesc.descrs)
                ENDIF
                IF USED("cursor_4c_LkpDesc")
                    USE IN cursor_4c_LkpDesc
                ENDIF
            ENDIF

            *-- Unidade (SigCdUni: cunis/dunis)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpDesc")
                IF loc_nRet > 0 AND USED("cursor_4c_LkpDesc") AND !EOF("cursor_4c_LkpDesc")
                    loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_LkpDesc.dunis)
                ENDIF
                IF USED("cursor_4c_LkpDesc")
                    USE IN cursor_4c_LkpDesc
                ENDIF
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_LkpDesc")
                USE IN cursor_4c_LkpDesc
            ENDIF
            MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(245) + "es:" + CHR(13) + ;
                loException.Message, "FormProduto.CarregarDescricoes")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCampos - Valida campos obrigatorios antes de salvar
    *===========================================================================
    PROTECTED FUNCTION ValidarCampos()
        LOCAL loc_oPg, loc_lValido, loException
        loc_lValido = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

            IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Cpros.Value))
                MsgAviso("C" + CHR(243) + "digo do produto " + CHR(233) + " obrigat" + CHR(243) + "rio!")
                loc_oPg.txt_4c_Cpros.SetFocus()
            ELSE
                IF EMPTY(ALLTRIM(loc_oPg.txt_4c_Dpros.Value))
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria!")
                loc_oPg.txt_4c_Dpros.SetFocus()
            ELSE
                loc_lValido = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar campos:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarCampos")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *===========================================================================
    * TxtCgrusKeyDown - F4 abre busca de grupo
    * PUBLIC: BINDEVENT requer metodo publico; KeyDown exige os 2 parametros
    *===========================================================================
    PROCEDURE TxtCgrusKeyDown(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaGrupo()
        ENDIF
    ENDPROC

    *===========================================================================
    * TxtIforsKeyDown - F4 abre busca de fornecedor
    * PUBLIC: BINDEVENT requer metodo publico; KeyDown exige os 2 parametros
    *===========================================================================
    PROCEDURE TxtIforsKeyDown(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaFornecedor()
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarCgrus - LostFocus: valida cgrus e popula dgrus (SigCdGrp)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarCgrus()
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)

            IF EMPTY(loc_cCod)
                loc_oPg.txt_4c_Dgrus.Value = ""
            ELSE
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpCgrus")

                IF loc_nRet > 0 AND USED("cursor_4c_LkpCgrus") AND !EOF("cursor_4c_LkpCgrus")
                    loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_LkpCgrus.dgrus)
                    USE IN cursor_4c_LkpCgrus
                ELSE
                    IF USED("cursor_4c_LkpCgrus")
                        USE IN cursor_4c_LkpCgrus
                    ENDIF
                    loc_oPg.txt_4c_Cgrus.Value = ""
                    loc_oPg.txt_4c_Dgrus.Value = ""
                    THIS.AbrirBuscaGrupo()
                ENDIF
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_LkpCgrus")
                USE IN cursor_4c_LkpCgrus
            ENDIF
            MostrarErro("Erro ao validar grupo:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarCgrus")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarSGrus - LostFocus: sgrus sem tabela de descricao, apenas aceita valor
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarSGrus()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_oPg.txt_4c_DsGrus.Value = ""
    ENDPROC

    *===========================================================================
    * ValidarLinhas - LostFocus: valida linhas e popula DLinhas (SigCdLin)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarLinhas()
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Linhas.Value)

            IF EMPTY(loc_cCod)
                loc_oPg.txt_4c_DLinhas.Value = ""
            ELSE
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpLinha")

                IF loc_nRet > 0 AND USED("cursor_4c_LkpLinha") AND !EOF("cursor_4c_LkpLinha")
                    loc_oPg.txt_4c_DLinhas.Value = ALLTRIM(cursor_4c_LkpLinha.descs)
                    USE IN cursor_4c_LkpLinha
                ELSE
                    IF USED("cursor_4c_LkpLinha")
                        USE IN cursor_4c_LkpLinha
                    ENDIF
                    loc_oPg.txt_4c_Linhas.Value  = ""
                    loc_oPg.txt_4c_DLinhas.Value = ""
                    MsgAviso("Linha n" + CHR(227) + "o encontrada.")
                ENDIF
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_LkpLinha")
                USE IN cursor_4c_LkpLinha
            ENDIF
            MostrarErro("Erro ao validar linha:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarLinhas")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarColecoes - LostFocus: valida colecao e popula DColecoes (SigCdCol)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarColecoes()
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Colecoes.Value)

            IF EMPTY(loc_cCod)
                loc_oPg.txt_4c_DColecoes.Value = ""
            ELSE
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descs FROM SigCdCol WHERE colecoes = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpColecao")

                IF loc_nRet > 0 AND USED("cursor_4c_LkpColecao") AND !EOF("cursor_4c_LkpColecao")
                    loc_oPg.txt_4c_DColecoes.Value = ALLTRIM(cursor_4c_LkpColecao.descs)
                    USE IN cursor_4c_LkpColecao
                ELSE
                    IF USED("cursor_4c_LkpColecao")
                        USE IN cursor_4c_LkpColecao
                    ENDIF
                    loc_oPg.txt_4c_Colecoes.Value  = ""
                    loc_oPg.txt_4c_DColecoes.Value = ""
                    MsgAviso("Grupo de venda n" + CHR(227) + "o encontrado.")
                ENDIF
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_LkpColecao")
                USE IN cursor_4c_LkpColecao
            ENDIF
            MostrarErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormProduto.ValidarColecoes")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarIfors - LostFocus: valida fornecedor e popula Dfors (SigCdFor)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarIfors()
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)

            IF EMPTY(loc_cCod)
                loc_oPg.txt_4c_Dfors.Value = ""
            ELSE
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT dfors FROM SigCdFor WHERE ifors = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpForn")

                IF loc_nRet > 0 AND USED("cursor_4c_LkpForn") AND !EOF("cursor_4c_LkpForn")
                    loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_LkpForn.dfors)
                    USE IN cursor_4c_LkpForn
                ELSE
                    IF USED("cursor_4c_LkpForn")
                        USE IN cursor_4c_LkpForn
                    ENDIF
                    loc_oPg.txt_4c_Ifors.Value = ""
                    loc_oPg.txt_4c_Dfors.Value = ""
                    THIS.AbrirBuscaFornecedor()
                ENDIF
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_LkpForn")
                USE IN cursor_4c_LkpForn
            ENDIF
            MostrarErro("Erro ao validar fornecedor:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarIfors")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCodCors - LostFocus: valida codigo de cor (SigCdCor)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarCodCors()
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodCors.Value)

            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT cods FROM SigCdCor WHERE cods = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpCor")

                IF loc_nRet > 0 AND USED("cursor_4c_LkpCor") AND !EOF("cursor_4c_LkpCor")
                    USE IN cursor_4c_LkpCor
                ELSE
                    IF USED("cursor_4c_LkpCor")
                        USE IN cursor_4c_LkpCor
                    ENDIF
                    loc_oPg.txt_4c_CodCors.Value = ""
                    MsgAviso("Cor n" + CHR(227) + "o encontrada.")
                ENDIF
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_LkpCor")
                USE IN cursor_4c_LkpCor
            ENDIF
            MostrarErro("Erro ao validar cor:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarCodCors")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCodTams - LostFocus: valida codigo de tamanho (SigCdTam)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarCodTams()
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodTams.Value)

            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT cods FROM SigCdTam WHERE cods = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpTam")

                IF loc_nRet > 0 AND USED("cursor_4c_LkpTam") AND !EOF("cursor_4c_LkpTam")
                    USE IN cursor_4c_LkpTam
                ELSE
                    IF USED("cursor_4c_LkpTam")
                        USE IN cursor_4c_LkpTam
                    ENDIF
                    loc_oPg.txt_4c_CodTams.Value = ""
                    MsgAviso("Tamanho n" + CHR(227) + "o encontrado.")
                ENDIF
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_LkpTam")
                USE IN cursor_4c_LkpTam
            ENDIF
            MostrarErro("Erro ao validar tamanho:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarCodTams")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCodAcbs - LostFocus: valida acabamento e popula DAcbs (SigCdAca)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarCodAcbs()
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcbs.Value)

            IF EMPTY(loc_cCod)
                loc_oPg.txt_4c_DAcbs.Value = ""
            ELSE
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpAcab")

                IF loc_nRet > 0 AND USED("cursor_4c_LkpAcab") AND !EOF("cursor_4c_LkpAcab")
                    loc_oPg.txt_4c_DAcbs.Value = ALLTRIM(cursor_4c_LkpAcab.descrs)
                    USE IN cursor_4c_LkpAcab
                ELSE
                    IF USED("cursor_4c_LkpAcab")
                        USE IN cursor_4c_LkpAcab
                    ENDIF
                    loc_oPg.txt_4c_CodAcbs.Value = ""
                    loc_oPg.txt_4c_DAcbs.Value   = ""
                    MsgAviso("Acabamento n" + CHR(227) + "o encontrado.")
                ENDIF
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_LkpAcab")
                USE IN cursor_4c_LkpAcab
            ENDIF
            MostrarErro("Erro ao validar acabamento:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarCodAcbs")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCunis - LostFocus: valida unidade e popula Dunis (SigCdUni)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarCunis()
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunis.Value)

            IF EMPTY(loc_cCod)
                loc_oPg.txt_4c_Dunis.Value = ""
            ELSE
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpUni")

                IF loc_nRet > 0 AND USED("cursor_4c_LkpUni") AND !EOF("cursor_4c_LkpUni")
                    loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_LkpUni.dunis)
                    USE IN cursor_4c_LkpUni
                ELSE
                    IF USED("cursor_4c_LkpUni")
                        USE IN cursor_4c_LkpUni
                    ENDIF
                    loc_oPg.txt_4c_Cunis.Value = ""
                    loc_oPg.txt_4c_Dunis.Value = ""
                    MsgAviso("Unidade n" + CHR(227) + "o encontrada.")
                ENDIF
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_LkpUni")
                USE IN cursor_4c_LkpUni
            ENDIF
            MostrarErro("Erro ao validar unidade:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarCunis")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaGrupo - Abre FormBuscaAuxiliar para selecionar grupo (SigCdGrp)
    * Pattern A canonico: SQL no caller, DefinirCursor, Mostrar
    *===========================================================================
    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Cgrus.Value)

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cgrus, dgrus FROM SigCdGrp WHERE cgrus LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY cgrus", ;
                "cursor_4c_GrpBusca")

            IF loc_nRet <= 0 OR !USED("cursor_4c_GrpBusca") OR EOF("cursor_4c_GrpBusca")
                IF USED("cursor_4c_GrpBusca")
                    USE IN cursor_4c_GrpBusca
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", ;
                    "cursor_4c_GrpBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_GrpBusca", "cgrus", "dgrus", ;
                    "Buscar Grupo de Produto")
                loc_oBusca.Mostrar()

                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    loc_oPg.txt_4c_Cgrus.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_GrpBusca")
                USE IN cursor_4c_GrpBusca
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_GrpBusca")
                USE IN cursor_4c_GrpBusca
            ENDIF
            MostrarErro("Erro ao buscar grupo:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaGrupo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaFornecedor - Abre FormBuscaAuxiliar para selecionar fornecedor
    * Pattern A canonico: SQL no caller, DefinirCursor, Mostrar
    *===========================================================================
    PROCEDURE AbrirBuscaFornecedor()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Ifors.Value)

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT ifors, dfors FROM SigCdFor WHERE ifors LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' OR dfors LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY dfors", ;
                "cursor_4c_FornBusca")

            IF loc_nRet <= 0 OR !USED("cursor_4c_FornBusca") OR EOF("cursor_4c_FornBusca")
                IF USED("cursor_4c_FornBusca")
                    USE IN cursor_4c_FornBusca
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT ifors, dfors FROM SigCdFor ORDER BY dfors", ;
                    "cursor_4c_FornBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_FornBusca", "ifors", "dfors", ;
                    "Buscar Fornecedor")
                loc_oBusca.Mostrar()

                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    loc_oPg.txt_4c_Ifors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    loc_oPg.txt_4c_Dfors.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_FornBusca")
                USE IN cursor_4c_FornBusca
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_FornBusca")
                USE IN cursor_4c_FornBusca
            ENDIF
            MostrarErro("Erro ao buscar fornecedor:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaFornecedor")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*====================================================================
* ProdutoBO.prg
*
* Business Object para Cadastro de Produtos
* Tabela principal: SigCdPro
*====================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

	*-- Chave primaria e identificacao
	this_cCpros              = ""   && cpros        char(14) PK
	this_nIdpro              = 0    && idpro         numeric(10,0)
	this_cCodident           = ""   && codident      char(20) nullable

	*-- Descricoes
	this_cDpros              = ""   && dpros         char(65)
	this_cDpro2s             = ""   && dpro2s        char(45)
	this_mDpro3s             = ""   && dpro3s        text

	*-- Classificacao
	this_cCgrus              = ""   && cgrus         char(3)
	this_cSgrus              = ""   && sgrus         char(6)
	this_cLinhas             = ""   && linhas        char(10)
	this_cColecoes           = ""   && colecoes      char(10)
	this_cConjunts           = ""   && conjunts      char(6)
	this_cTipos              = ""   && tipos         char(1)
	this_cStatus             = ""   && status        char(3)
	this_nSituas             = 0    && situas        numeric(1,0)
	this_dDtsituas           = {}   && dtsituas      datetime
	this_cCclass             = ""   && cclass        char(3)
	this_cNivelqs            = ""   && nivelqs       char(10)
	this_cCategoria          = ""   && categoria     char(6)
	this_cCodctgsite         = ""   && codctgsite    char(2)
	this_cCoddptsite         = ""   && coddptsite    char(2)
	this_cCodmacro           = ""   && codmacro      char(6)

	*-- Fornecedor e referencia
	this_cIfors              = ""   && ifors         char(10)
	this_cReffs              = ""   && reffs         char(40)
	this_cCvens              = ""   && cvens         char(10)

	*-- Cor, tamanho e material
	this_cCodcors            = ""   && codcors       char(4)
	this_cCodtams            = ""   && codtams       char(4)
	this_cMatprincs          = ""   && matprincs     char(14)
	this_cMetals             = ""   && metals        char(2)
	this_cTeors              = ""   && teors         char(2)
	this_cCompos             = ""   && compos        char(30)
	this_cConquilhas         = ""   && conquilhas    char(10)
	this_cPropriedades       = ""   && propriedades  char(40)
	this_nCravcers           = 0    && cravcers      numeric(1,0)

	*-- Precos e custos
	this_nPcuss              = 0    && pcuss         numeric(11,5)
	this_nPvens              = 0    && pvens         numeric(11,5)
	this_nPvideals           = 0    && pvideals      numeric(11,5)
	this_nPrecode            = 0    && precode       numeric(11,5)
	this_nCustofs            = 0    && custofs       numeric(11,3)
	this_nCustocp            = 0    && custocp       numeric(11,5)
	this_nValors             = 0    && valors        numeric(11,2)
	this_nMarkupa            = 0    && markupa       numeric(11,3)
	this_nMargems            = 0    && margems       numeric(9,6)
	this_nFcustos            = 0    && fcustos       numeric(11,5)
	this_nFvendas            = 0    && fvendas       numeric(7,3)
	this_nFatuals            = 0    && fatuals       numeric(11,5)
	this_nFideals            = 0    && fideals       numeric(11,5)
	this_nCotacalcp          = 0    && cotacalcp     numeric(11,6)

	*-- Moedas
	this_cMoecs              = ""   && moecs         char(3)
	this_cMoecusfs           = ""   && moecusfs      char(3)
	this_cMoedas             = ""   && moedas        char(3)
	this_cMoepcs             = ""   && moepcs        char(3)
	this_cMoepvs             = ""   && moepvs        char(3)
	this_cMoevs              = ""   && moevs         char(3)

	*-- Fiscal
	this_cClfiscals          = ""   && clfiscals     char(10)
	this_cSittricms          = ""   && sittricms     char(3)
	this_nIcms               = 0    && icms          numeric(5,2)
	this_nAliqipis           = 0    && aliqipis      numeric(5,2)
	this_cIpis               = ""   && ipis          char(1)
	this_cTptribs            = ""   && tptribs       char(4)
	this_cOrigmercs          = ""   && origmercs     char(1)
	this_cExtipi             = ""   && extipi        char(3)
	this_cMercs              = ""   && mercs         char(3)
	this_cDescecfs           = ""   && descecfs      char(29)
	this_cCodgarras          = ""   && codgarras     char(10)
	this_cMftios             = ""   && mftios        char(3)
	this_nPftios             = 0    && pftios        numeric(11,3)
	this_cCftios             = ""   && cftios        char(2)
	this_cCftiocs            = ""   && cftiocs       char(2)
	this_nPftiocs            = 0    && pftiocs       numeric(11,3)
	this_cCodservs           = ""   && codservs      char(4)
	this_cIats               = ""   && iats          char(1)
	this_cCodacbs            = ""   && codacbs       char(3)
	this_nEncargos           = 0    && encargos      numeric(7,4)
	this_cCodfinp            = ""   && codfinp       char(3)
	this_cCodmatp            = ""   && codmatp       char(3)
	this_cIdecpros           = ""   && idecpros      char(3)

	*-- Peso e dimensoes
	this_nPesoms             = 0    && pesoms        numeric(8,3)
	this_nPesobs             = 0    && pesobs        numeric(7,3)
	this_nPesometal          = 0    && pesometal     numeric(9,3)
	this_nPesobris           = 0    && pesobris      numeric(9,3)
	this_nPesopdrs           = 0    && pesopdrs      numeric(9,3)
	this_nAltura             = 0    && altura        numeric(7,4)
	this_nLargura            = 0    && largura       numeric(7,4)
	this_nDiametro           = 0    && diametro      numeric(7,4)
	this_nEspessura          = 0    && espessura     numeric(7,4)
	this_nCompriment         = 0    && compriment    numeric(7,4)
	this_nVarias             = 0    && varias        numeric(1,0)
	this_nVarpesoms          = 0    && varpesoms     numeric(5,2)

	*-- Estoque e compras
	this_nQmins              = 0    && qmins         numeric(9,3)
	this_nPmins              = 0    && pmins         numeric(7,3)
	this_nQtminfabs          = 0    && qtminfabs     numeric(9,3)
	this_nLtminsv            = 0    && ltminsv       numeric(9,3)
	this_nQtdultcomp         = 0    && qtdultcomp    numeric(12,0)
	this_nVultcomps          = 0    && vultcomps     numeric(11,2)
	this_cMultcomps          = ""   && multcomps     char(3)
	this_dUltcomps           = {}   && ultcomps      datetime
	this_nQtped              = 0    && qtped         numeric(9,3)
	this_nEncoms             = 0    && encoms        numeric(1,0)
	this_nConsigs            = 0    && consigs       numeric(1,0)

	*-- Unidades e codigos de barras
	this_cCunis              = ""   && cunis         char(3)
	this_cCunips             = ""   && cunips        char(3)
	this_nCbars              = 0    && cbars         numeric(14,0)
	this_nEan13              = 0    && ean13         numeric(13,0)
	this_cSkuvtex            = ""   && skuvtex       char(50)

	*-- Composicao e montagem
	this_cCproeqs            = ""   && cproeqs       char(14)
	this_nQtdcpnts           = 0    && qtdcpnts      numeric(3,0)
	this_nMontadescs         = 0    && montadescs    numeric(1,0)
	this_nDigimaxs           = 0    && digimaxs      numeric(2,0)
	this_nOrdcompos          = 0    && ordcompos     numeric(2,0)
	this_nCasas              = 0    && casas         numeric(2,0)
	this_nVolumes            = 0    && volumes       numeric(3,0)

	*-- Dimensoes de tamanho padrao
	this_nTamhs              = 0    && tamhs         numeric(5,2)
	this_nTamls              = 0    && tamls         numeric(5,2)
	this_nTamps              = 0    && tamps         numeric(5,2)

	*-- Fabricacao e producao
	this_nFabrproprs         = 0    && fabrproprs    numeric(1,0)
	this_nTents              = 0    && tents         numeric(3,0)
	this_nTinsts             = 0    && tinsts        numeric(3,0)
	this_nDiasinas           = 0    && diasinas      numeric(5,0)
	this_nProdvars           = 0    && prodvars      numeric(1,0)
	this_nProdwebs           = 0    && prodwebs      numeric(1,0)
	this_nProtnovo           = 0    && prodnovo      numeric(1,0)
	this_nProdoff            = 0    && prodoff       numeric(1,0)
	this_nPrototipo          = 0    && prototipo     numeric(1,0)
	this_nReposauto          = 0    && reposauto     numeric(1,0)
	this_nProcfigjpgs        = 0    && procfigjpgs   numeric(1,0)

	*-- Contabilidade
	this_cContaccus          = ""   && contaccus     char(10)
	this_cGruccus            = ""   && gruccus       char(10)
	this_nComis              = 0    && comis         numeric(5,2)

	*-- Localizacao e armazenagem
	this_cLocals             = ""   && locals        char(10)
	this_cNotas              = ""   && notas         char(6)
	this_cObsetqs            = ""   && obsetqs       char(10)

	*-- Observacoes e textos
	this_cObspeds            = ""   && obspeds       char(30)
	this_cObspes             = ""   && obspes        char(30)
	this_cObsmkt             = ""   && obsmkt        char(100)
	this_mObscompras         = ""   && obscompras    text
	this_mObsinsp            = ""   && obsinsp       text
	this_mDsccompras         = ""   && dsccompras    text
	this_mDescfis            = ""   && descfis       text

	*-- Imagens e arquivos
	this_mFigjpgs            = ""   && figjpgs       text
	this_mFigjpgs64          = ""   && figjpgs64     text
	this_mFigtecs            = ""   && figtecs       text

	*-- Tipo de servico
	this_mMtiposervs         = ""   && mtiposervs    text

	*-- Marketing e site
	this_nAtivosite          = 0    && ativosite     numeric(1,0)
	this_nForalinha          = 0    && foralinha     numeric(1,0)
	this_nMostruario         = 0    && mostruario    numeric(1,0)
	this_nBestseller         = 0    && bestseller    numeric(1,0)
	this_nSegfem             = 0    && segfem        numeric(1,0)
	this_nSeginf             = 0    && seginf        numeric(1,0)
	this_nSegkids            = 0    && segkids       numeric(1,0)
	this_nSegmasc            = 0    && segmasc       numeric(1,0)
	this_nSeguni             = 0    && seguni        numeric(1,0)
	this_nSemconsulta        = 0    && semconsulta   numeric(1,0)
	this_cLancamento         = ""   && lancamento    char(30)
	this_cOrigemlac          = ""   && origemlac     char(40)

	*-- Garantia
	this_nDiasgar            = 0    && diasgar       numeric(4,0) nullable
	this_nChkgarvit          = 0    && chkgarvit     numeric(1,0)

	*-- Gemologia
	this_nMohs               = 0    && mohs          numeric(3,0)
	this_cRefracao           = ""   && refracao      char(16)
	this_cRefracaodp         = ""   && refracaodp    char(16)

	*-- Laboratorio e qualidade
	this_cUnidade1           = ""   && unidade1          char(15)
	this_cResultado1         = ""   && resultado1        char(15)
	this_cValorminimo        = ""   && valorminimo       char(15)
	this_cValormaximo        = ""   && valormaximo       char(15)
	this_cMetodoreferencia1  = ""   && metodoreferencia1 char(15)

	*-- Flags booleanos (bit)
	this_lFlagctabs          = .F.  && flagctabs     bit
	this_lTcomps             = .F.  && tcomps        bit
	this_lTransps            = .F.  && transps       bit
	this_lImpetiqs           = .F.  && impetiqs      bit
	this_lChkfunds           = .F.  && chkfunds      bit

	*-- Auditoria e controle de datas
	this_dDatas              = {}   && datas         datetime
	this_dDatatrans          = {}   && datatrans     datetime
	this_dDtfilms            = {}   && dtfilms       datetime
	this_dDtincs             = {}   && dtincs        datetime
	this_dDtcomps            = {}   && dtcomps       datetime
	this_dDtalts             = {}   && dtalts        datetime
	this_dDtlacto            = {}   && dtlacto       datetime
	this_dFimdtlacto         = {}   && fimdtlacto    datetime
	this_cUsuincs            = ""   && usuincs       char(10)
	this_cUsuaalts           = ""   && usuaalts      char(20)
	this_nNidentfixa         = 0    && nidentfixa    numeric(1,0)
	this_nObrtamser          = 0    && obrtamser     numeric(1,0)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdPro"
		THIS.this_cCampoChave = "cpros"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna o valor da chave primaria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN THIS.this_cCpros
	ENDFUNC

	*====================================================================
	* Buscar - SELECT lista para o grid
	*====================================================================
	FUNCTION Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
		loc_lSucesso = .F.
		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF
			loc_cWhere = ""
			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
				loc_cWhere = " WHERE " + par_cFiltro
			ENDIF
			loc_cSQL = "SELECT cpros, dpros, cgrus, sgrus, linhas, tipos, situas, ifors," + ;
			           " pvens, pcuss, custofs, cunis, matprincs, codcors, codtams," + ;
			           " reffs, colecoes, idpro" + ;
			           " FROM SigCdPro" + loc_cWhere + ;
			           " ORDER BY dpros"
			*-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
			IF USED("cursor_4c_Dados")
			    TABLEREVERT(.T., "cursor_4c_Dados")
			    USE IN cursor_4c_Dados
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResult >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.Buscar:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarPorCodigo - Carrega produto pelo cpros (PK)
	*====================================================================
	FUNCTION CarregarPorCodigo(par_cCpros)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			IF USED("cursor_4c_Registro")
				USE IN cursor_4c_Registro
			ENDIF
			loc_cSQL    = "SELECT * FROM SigCdPro WHERE cpros = " + EscaparSQL(par_cCpros)
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro")
			IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Registro") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Registro")
			ENDIF
			IF USED("cursor_4c_Registro")
				USE IN cursor_4c_Registro
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Popula propriedades a partir do cursor
	*====================================================================
	FUNCTION CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCpros              = TratarNulo(cpros,              "")
				THIS.this_nIdpro              = TratarNulo(idpro,              0)
				THIS.this_cCodident           = TratarNulo(codident,           "")
				THIS.this_cDpros              = TratarNulo(dpros,              "")
				THIS.this_cDpro2s             = TratarNulo(dpro2s,             "")
				THIS.this_mDpro3s             = TratarNulo(dpro3s,             "")
				THIS.this_cCgrus              = TratarNulo(cgrus,              "")
				THIS.this_cSgrus              = TratarNulo(sgrus,              "")
				THIS.this_cLinhas             = TratarNulo(linhas,             "")
				THIS.this_cColecoes           = TratarNulo(colecoes,           "")
				THIS.this_cConjunts           = TratarNulo(conjunts,           "")
				THIS.this_cTipos              = TratarNulo(tipos,              "")
				THIS.this_cStatus             = TratarNulo(status,             "")
				THIS.this_nSituas             = TratarNulo(situas,             0)
				THIS.this_dDtsituas           = TratarNulo(dtsituas,           {})
				THIS.this_cCclass             = TratarNulo(cclass,             "")
				THIS.this_cNivelqs            = TratarNulo(nivelqs,            "")
				THIS.this_cCategoria          = TratarNulo(categoria,          "")
				THIS.this_cCodctgsite         = TratarNulo(codctgsite,         "")
				THIS.this_cCoddptsite         = TratarNulo(coddptsite,         "")
				THIS.this_cCodmacro           = TratarNulo(codmacro,           "")
				THIS.this_cIfors              = TratarNulo(ifors,              "")
				THIS.this_cReffs              = TratarNulo(reffs,              "")
				THIS.this_cCvens              = TratarNulo(cvens,              "")
				THIS.this_cCodcors            = TratarNulo(codcors,            "")
				THIS.this_cCodtams            = TratarNulo(codtams,            "")
				THIS.this_cMatprincs          = TratarNulo(matprincs,          "")
				THIS.this_cMetals             = TratarNulo(metals,             "")
				THIS.this_cTeors              = TratarNulo(teors,              "")
				THIS.this_cCompos             = TratarNulo(compos,             "")
				THIS.this_cConquilhas         = TratarNulo(conquilhas,         "")
				THIS.this_cPropriedades       = TratarNulo(propriedades,       "")
				THIS.this_nCravcers           = TratarNulo(cravcers,           0)
				THIS.this_nPcuss              = TratarNulo(pcuss,              0)
				THIS.this_nPvens              = TratarNulo(pvens,              0)
				THIS.this_nPvideals           = TratarNulo(pvideals,           0)
				THIS.this_nPrecode            = TratarNulo(precode,            0)
				THIS.this_nCustofs            = TratarNulo(custofs,            0)
				THIS.this_nCustocp            = TratarNulo(custocp,            0)
				THIS.this_nValors             = TratarNulo(valors,             0)
				THIS.this_nMarkupa            = TratarNulo(markupa,            0)
				THIS.this_nMargems            = TratarNulo(margems,            0)
				THIS.this_nFcustos            = TratarNulo(fcustos,            0)
				THIS.this_nFvendas            = TratarNulo(fvendas,            0)
				THIS.this_nFatuals            = TratarNulo(fatuals,            0)
				THIS.this_nFideals            = TratarNulo(fideals,            0)
				THIS.this_nCotacalcp          = TratarNulo(cotacalcp,          0)
				THIS.this_cMoecs              = TratarNulo(moecs,              "")
				THIS.this_cMoecusfs           = TratarNulo(moecusfs,           "")
				THIS.this_cMoedas             = TratarNulo(moedas,             "")
				THIS.this_cMoepcs             = TratarNulo(moepcs,             "")
				THIS.this_cMoepvs             = TratarNulo(moepvs,             "")
				THIS.this_cMoevs              = TratarNulo(moevs,              "")
				THIS.this_cClfiscals          = TratarNulo(clfiscals,          "")
				THIS.this_cSittricms          = TratarNulo(sittricms,          "")
				THIS.this_nIcms               = TratarNulo(icms,               0)
				THIS.this_nAliqipis           = TratarNulo(aliqipis,           0)
				THIS.this_cIpis               = TratarNulo(ipis,               "")
				THIS.this_cTptribs            = TratarNulo(tptribs,            "")
				THIS.this_cOrigmercs          = TratarNulo(origmercs,          "")
				THIS.this_cExtipi             = TratarNulo(extipi,             "")
				THIS.this_cMercs              = TratarNulo(mercs,              "")
				THIS.this_cDescecfs           = TratarNulo(descecfs,           "")
				THIS.this_cCodgarras          = TratarNulo(codgarras,          "")
				THIS.this_cMftios             = TratarNulo(mftios,             "")
				THIS.this_nPftios             = TratarNulo(pftios,             0)
				THIS.this_cCftios             = TratarNulo(cftios,             "")
				THIS.this_cCftiocs            = TratarNulo(cftiocs,            "")
				THIS.this_nPftiocs            = TratarNulo(pftiocs,            0)
				THIS.this_cCodservs           = TratarNulo(codservs,           "")
				THIS.this_cIats               = TratarNulo(iats,               "")
				THIS.this_cCodacbs            = TratarNulo(codacbs,            "")
				THIS.this_nEncargos           = TratarNulo(encargos,           0)
				THIS.this_cCodfinp            = TratarNulo(codfinp,            "")
				THIS.this_cCodmatp            = TratarNulo(codmatp,            "")
				THIS.this_cIdecpros           = TratarNulo(idecpros,           "")
				THIS.this_nPesoms             = TratarNulo(pesoms,             0)
				THIS.this_nPesobs             = TratarNulo(pesobs,             0)
				THIS.this_nPesometal          = TratarNulo(pesometal,          0)
				THIS.this_nPesobris           = TratarNulo(pesobris,           0)
				THIS.this_nPesopdrs           = TratarNulo(pesopdrs,           0)
				THIS.this_nAltura             = TratarNulo(altura,             0)
				THIS.this_nLargura            = TratarNulo(largura,            0)
				THIS.this_nDiametro           = TratarNulo(diametro,           0)
				THIS.this_nEspessura          = TratarNulo(espessura,          0)
				THIS.this_nCompriment         = TratarNulo(compriment,         0)
				THIS.this_nVarias             = TratarNulo(varias,             0)
				THIS.this_nVarpesoms          = TratarNulo(varpesoms,          0)
				THIS.this_nQmins              = TratarNulo(qmins,              0)
				THIS.this_nPmins              = TratarNulo(pmins,              0)
				THIS.this_nQtminfabs          = TratarNulo(qtminfabs,          0)
				THIS.this_nLtminsv            = TratarNulo(ltminsv,            0)
				THIS.this_nQtdultcomp         = TratarNulo(qtdultcomp,         0)
				THIS.this_nVultcomps          = TratarNulo(vultcomps,          0)
				THIS.this_cMultcomps          = TratarNulo(multcomps,          "")
				THIS.this_dUltcomps           = TratarNulo(ultcomps,           {})
				THIS.this_nQtped              = TratarNulo(qtped,              0)
				THIS.this_nEncoms             = TratarNulo(encoms,             0)
				THIS.this_nConsigs            = TratarNulo(consigs,            0)
				THIS.this_cCunis              = TratarNulo(cunis,              "")
				THIS.this_cCunips             = TratarNulo(cunips,             "")
				THIS.this_nCbars              = TratarNulo(cbars,              0)
				THIS.this_nEan13              = TratarNulo(ean13,              0)
				THIS.this_cSkuvtex            = TratarNulo(skuvtex,            "")
				THIS.this_cCproeqs            = TratarNulo(cproeqs,            "")
				THIS.this_nQtdcpnts           = TratarNulo(qtdcpnts,           0)
				THIS.this_nMontadescs         = TratarNulo(montadescs,         0)
				THIS.this_nDigimaxs           = TratarNulo(digimaxs,           0)
				THIS.this_nOrdcompos          = TratarNulo(ordcompos,          0)
				THIS.this_nCasas              = TratarNulo(casas,              0)
				THIS.this_nVolumes            = TratarNulo(volumes,            0)
				THIS.this_nTamhs              = TratarNulo(tamhs,              0)
				THIS.this_nTamls              = TratarNulo(tamls,              0)
				THIS.this_nTamps              = TratarNulo(tamps,              0)
				THIS.this_nFabrproprs         = TratarNulo(fabrproprs,         0)
				THIS.this_nTents              = TratarNulo(tents,              0)
				THIS.this_nTinsts             = TratarNulo(tinsts,             0)
				THIS.this_nDiasinas           = TratarNulo(diasinas,           0)
				THIS.this_nProdvars           = TratarNulo(prodvars,           0)
				THIS.this_nProdwebs           = TratarNulo(prodwebs,           0)
				THIS.this_nProtnovo           = TratarNulo(prodnovo,           0)
				THIS.this_nProdoff            = TratarNulo(prodoff,            0)
				THIS.this_nPrototipo          = TratarNulo(prototipo,          0)
				THIS.this_nReposauto          = TratarNulo(reposauto,          0)
				THIS.this_nProcfigjpgs        = TratarNulo(procfigjpgs,        0)
				THIS.this_cContaccus          = TratarNulo(contaccus,          "")
				THIS.this_cGruccus            = TratarNulo(gruccus,            "")
				THIS.this_nComis              = TratarNulo(comis,              0)
				THIS.this_cLocals             = TratarNulo(locals,             "")
				THIS.this_cNotas              = TratarNulo(notas,              "")
				THIS.this_cObsetqs            = TratarNulo(obsetqs,            "")
				THIS.this_cObspeds            = TratarNulo(obspeds,            "")
				THIS.this_cObspes             = TratarNulo(obspes,             "")
				THIS.this_cObsmkt             = TratarNulo(obsmkt,             "")
				THIS.this_mObscompras         = TratarNulo(obscompras,         "")
				THIS.this_mObsinsp            = TratarNulo(obsinsp,            "")
				THIS.this_mDsccompras         = TratarNulo(dsccompras,         "")
				THIS.this_mDescfis            = TratarNulo(descfis,            "")
				THIS.this_mFigjpgs            = TratarNulo(figjpgs,            "")
				THIS.this_mFigjpgs64          = TratarNulo(figjpgs64,          "")
				THIS.this_mFigtecs            = TratarNulo(figtecs,            "")
				THIS.this_mMtiposervs         = TratarNulo(mtiposervs,         "")
				THIS.this_nAtivosite          = TratarNulo(ativosite,          0)
				THIS.this_nForalinha          = TratarNulo(foralinha,          0)
				THIS.this_nMostruario         = TratarNulo(mostruario,         0)
				THIS.this_nBestseller         = TratarNulo(bestseller,         0)
				THIS.this_nSegfem             = TratarNulo(segfem,             0)
				THIS.this_nSeginf             = TratarNulo(seginf,             0)
				THIS.this_nSegkids            = TratarNulo(segkids,            0)
				THIS.this_nSegmasc            = TratarNulo(segmasc,            0)
				THIS.this_nSeguni             = TratarNulo(seguni,             0)
				THIS.this_nSemconsulta        = TratarNulo(semconsulta,        0)
				THIS.this_cLancamento         = TratarNulo(lancamento,         "")
				THIS.this_cOrigemlac          = TratarNulo(origemlac,          "")
				THIS.this_nDiasgar            = TratarNulo(diasgar,            0)
				THIS.this_nChkgarvit          = TratarNulo(chkgarvit,          0)
				THIS.this_nMohs               = TratarNulo(mohs,               0)
				THIS.this_cRefracao           = TratarNulo(refracao,           "")
				THIS.this_cRefracaodp         = TratarNulo(refracaodp,         "")
				THIS.this_cUnidade1           = TratarNulo(unidade1,           "")
				THIS.this_cResultado1         = TratarNulo(resultado1,         "")
				THIS.this_cValorminimo        = TratarNulo(valorminimo,        "")
				THIS.this_cValormaximo        = TratarNulo(valormaximo,        "")
				THIS.this_cMetodoreferencia1  = TratarNulo(metodoreferencia1,  "")
				THIS.this_lFlagctabs          = (TratarNulo(flagctabs,         0) <> 0)
				THIS.this_lTcomps             = (TratarNulo(tcomps,            0) <> 0)
				THIS.this_lTransps            = (TratarNulo(transps,           0) <> 0)
				THIS.this_lImpetiqs           = (TratarNulo(impetiqs,          0) <> 0)
				THIS.this_lChkfunds           = (TratarNulo(chkfunds,          0) <> 0)
				THIS.this_dDatas              = TratarNulo(datas,              {})
				THIS.this_dDatatrans          = TratarNulo(datatrans,          {})
				THIS.this_dDtfilms            = TratarNulo(dtfilms,            {})
				THIS.this_dDtincs             = TratarNulo(dtincs,             {})
				THIS.this_dDtcomps            = TratarNulo(dtcomps,            {})
				THIS.this_dDtalts             = TratarNulo(dtalts,             {})
				THIS.this_dDtlacto            = TratarNulo(dtlacto,            {})
				THIS.this_dFimdtlacto         = TratarNulo(fimdtlacto,         {})
				THIS.this_cUsuincs            = TratarNulo(usuincs,            "")
				THIS.this_cUsuaalts           = TratarNulo(usuaalts,           "")
				THIS.this_nNidentfixa         = TratarNulo(nidentfixa,         0)
				THIS.this_nObrtamser          = TratarNulo(obrtamser,          0)
				THIS.this_lNovoRegistro       = .F.
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterProxIdPro - Gera proximo idpro (MAX+1)
	*====================================================================
	PROTECTED FUNCTION ObterProxIdPro()
		LOCAL loc_cSQL, loc_nResult, loc_nProx
		loc_nProx = 1
		TRY
			IF USED("cursor_4c_MaxIdPro")
				USE IN cursor_4c_MaxIdPro
			ENDIF
			loc_cSQL    = "SELECT ISNULL(MAX(idpro), 0) + 1 AS proximoidpro FROM SigCdPro"
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxIdPro")
			IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MaxIdPro") > 0
				SELECT cursor_4c_MaxIdPro
				loc_nProx = proximoidpro
			ENDIF
			IF USED("cursor_4c_MaxIdPro")
				USE IN cursor_4c_MaxIdPro
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.ObterProxIdPro:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_nProx
	ENDFUNC

	*====================================================================
	* Inserir - INSERT INTO SigCdPro
	*====================================================================
	PROTECTED FUNCTION Inserir()
		LOCAL loc_cCols, loc_cVals, loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			THIS.this_nIdpro   = THIS.ObterProxIdPro()
			THIS.this_dDtincs  = DATETIME()
			THIS.this_cUsuincs = gc_4c_UsuarioLogado

			loc_cCols = "cpros, dpros, dpro2s, cgrus, sgrus, linhas, colecoes, conjunts, tipos," + ;
			            " status, situas, cclass, nivelqs, categoria, codctgsite, coddptsite, codmacro," + ;
			            " ifors, reffs, cvens," + ;
			            " codcors, codtams, matprincs, metals, teors, compos, conquilhas, propriedades, cravcers," + ;
			            " pcuss, pvens, pvideals, precode, custofs, custocp, valors, markupa, margems," + ;
			            " fcustos, fvendas, fatuals, fideals, cotacalcp," + ;
			            " moecs, moecusfs, moedas, moepcs, moepvs, moevs," + ;
			            " clfiscals, sittricms, icms, aliqipis, ipis, tptribs, origmercs, extipi, mercs," + ;
			            " descecfs, codgarras, mftios, pftios, cftios, cftiocs, pftiocs," + ;
			            " codservs, iats, codacbs, encargos, codfinp, codmatp, idecpros," + ;
			            " pesoms, pesobs, pesometal, pesobris, pesopdrs," + ;
			            " altura, largura, diametro, espessura, compriment, varias, varpesoms," + ;
			            " qmins, pmins, qtminfabs, ltminsv, qtdultcomp, vultcomps, multcomps, qtped, encoms, consigs," + ;
			            " cunis, cunips, cbars, ean13, skuvtex," + ;
			            " cproeqs, qtdcpnts, montadescs, digimaxs, ordcompos, casas, volumes, tamhs, tamls, tamps," + ;
			            " fabrproprs, tents, tinsts, diasinas, prodvars, prodwebs, prodnovo, prodoff," + ;
			            " prototipo, reposauto, procfigjpgs," + ;
			            " contaccus, gruccus, comis, locals, notas, obsetqs, obspeds, obspes, obsmkt," + ;
			            " ativosite, foralinha, mostruario, bestseller," + ;
			            " segfem, seginf, segkids, segmasc, seguni, semconsulta, lancamento, origemlac," + ;
			            " chkgarvit, mohs, refracao, refracaodp," + ;
			            " unidade1, resultado1, valorminimo, valormaximo, metodoreferencia1," + ;
			            " flagctabs, tcomps, transps, impetiqs, chkfunds," + ;
			            " usuincs, usuaalts, nidentfixa, obrtamser, idpro," + ;
			            " dtsituas, dtincs, datas, datatrans, dtfilms, dtcomps, dtalts, dtlacto, fimdtlacto, ultcomps, diasgar," + ;
			            " dpro3s, descfis, figjpgs, figjpgs64, figtecs, obscompras, obsinsp, dsccompras, mtiposervs, codident"

			loc_cVals  = EscaparSQL(THIS.this_cCpros)             + ", " + ;
			             EscaparSQL(THIS.this_cDpros)              + ", " + ;
			             EscaparSQL(THIS.this_cDpro2s)             + ", " + ;
			             EscaparSQL(THIS.this_cCgrus)              + ", " + ;
			             EscaparSQL(THIS.this_cSgrus)              + ", " + ;
			             EscaparSQL(THIS.this_cLinhas)             + ", " + ;
			             EscaparSQL(THIS.this_cColecoes)           + ", " + ;
			             EscaparSQL(THIS.this_cConjunts)           + ", " + ;
			             EscaparSQL(THIS.this_cTipos)              + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cStatus)             + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSituas)      + ", " + ;
			             EscaparSQL(THIS.this_cCclass)             + ", " + ;
			             EscaparSQL(THIS.this_cNivelqs)            + ", " + ;
			             EscaparSQL(THIS.this_cCategoria)          + ", " + ;
			             EscaparSQL(THIS.this_cCodctgsite)         + ", " + ;
			             EscaparSQL(THIS.this_cCoddptsite)         + ", " + ;
			             EscaparSQL(THIS.this_cCodmacro)           + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cIfors)              + ", " + ;
			             EscaparSQL(THIS.this_cReffs)              + ", " + ;
			             EscaparSQL(THIS.this_cCvens)              + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cCodcors)            + ", " + ;
			             EscaparSQL(THIS.this_cCodtams)            + ", " + ;
			             EscaparSQL(THIS.this_cMatprincs)          + ", " + ;
			             EscaparSQL(THIS.this_cMetals)             + ", " + ;
			             EscaparSQL(THIS.this_cTeors)              + ", " + ;
			             EscaparSQL(THIS.this_cCompos)             + ", " + ;
			             EscaparSQL(THIS.this_cConquilhas)         + ", " + ;
			             EscaparSQL(THIS.this_cPropriedades)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCravcers)    + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nPcuss)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPvens)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPvideals)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPrecode)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCustofs)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCustocp)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nValors)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nMarkupa)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nMargems)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nFcustos)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nFvendas)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nFatuals)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nFideals)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCotacalcp)   + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cMoecs)              + ", " + ;
			             EscaparSQL(THIS.this_cMoecusfs)           + ", " + ;
			             EscaparSQL(THIS.this_cMoedas)             + ", " + ;
			             EscaparSQL(THIS.this_cMoepcs)             + ", " + ;
			             EscaparSQL(THIS.this_cMoepvs)             + ", " + ;
			             EscaparSQL(THIS.this_cMoevs)              + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cClfiscals)          + ", " + ;
			             EscaparSQL(THIS.this_cSittricms)          + ", " + ;
			             FormatarNumeroSQL(THIS.this_nIcms)        + ", " + ;
			             FormatarNumeroSQL(THIS.this_nAliqipis)    + ", " + ;
			             EscaparSQL(THIS.this_cIpis)               + ", " + ;
			             EscaparSQL(THIS.this_cTptribs)            + ", " + ;
			             EscaparSQL(THIS.this_cOrigmercs)          + ", " + ;
			             EscaparSQL(THIS.this_cExtipi)             + ", " + ;
			             EscaparSQL(THIS.this_cMercs)              + ", " + ;
			             EscaparSQL(THIS.this_cDescecfs)           + ", " + ;
			             EscaparSQL(THIS.this_cCodgarras)          + ", " + ;
			             EscaparSQL(THIS.this_cMftios)             + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPftios)      + ", " + ;
			             EscaparSQL(THIS.this_cCftios)             + ", " + ;
			             EscaparSQL(THIS.this_cCftiocs)            + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPftiocs)     + ", " + ;
			             EscaparSQL(THIS.this_cCodservs)           + ", " + ;
			             EscaparSQL(THIS.this_cIats)               + ", " + ;
			             EscaparSQL(THIS.this_cCodacbs)            + ", " + ;
			             FormatarNumeroSQL(THIS.this_nEncargos)    + ", " + ;
			             EscaparSQL(THIS.this_cCodfinp)            + ", " + ;
			             EscaparSQL(THIS.this_cCodmatp)            + ", " + ;
			             EscaparSQL(THIS.this_cIdecpros)           + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nPesoms)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPesobs)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPesometal)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPesobris)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPesopdrs)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nAltura)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nLargura)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nDiametro)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nEspessura)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCompriment)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nVarias)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nVarpesoms)   + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nQmins)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPmins)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nQtminfabs)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nLtminsv)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nQtdultcomp)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nVultcomps)   + ", " + ;
			             EscaparSQL(THIS.this_cMultcomps)          + ", " + ;
			             FormatarNumeroSQL(THIS.this_nQtped)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nEncoms)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nConsigs)     + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cCunis)              + ", " + ;
			             EscaparSQL(THIS.this_cCunips)             + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCbars)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nEan13)       + ", " + ;
			             EscaparSQL(THIS.this_cSkuvtex)            + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cCproeqs)            + ", " + ;
			             FormatarNumeroSQL(THIS.this_nQtdcpnts)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nMontadescs)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nDigimaxs)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nOrdcompos)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCasas)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nVolumes)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nTamhs)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nTamls)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nTamps)       + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nFabrproprs)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nTents)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nTinsts)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nDiasinas)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nProdvars)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nProdwebs)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nProtnovo)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nProdoff)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPrototipo)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nReposauto)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nProcfigjpgs) + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cContaccus)          + ", " + ;
			             EscaparSQL(THIS.this_cGruccus)            + ", " + ;
			             FormatarNumeroSQL(THIS.this_nComis)       + ", " + ;
			             EscaparSQL(THIS.this_cLocals)             + ", " + ;
			             EscaparSQL(THIS.this_cNotas)              + ", " + ;
			             EscaparSQL(THIS.this_cObsetqs)            + ", " + ;
			             EscaparSQL(THIS.this_cObspeds)            + ", " + ;
			             EscaparSQL(THIS.this_cObspes)             + ", " + ;
			             EscaparSQL(THIS.this_cObsmkt)             + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nAtivosite)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nForalinha)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nMostruario)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nBestseller)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSegfem)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSeginf)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSegkids)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSegmasc)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSeguni)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSemconsulta) + ", " + ;
			             EscaparSQL(THIS.this_cLancamento)         + ", " + ;
			             EscaparSQL(THIS.this_cOrigemlac)          + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nChkgarvit)        + ", " + ;
			             FormatarNumeroSQL(THIS.this_nMohs)             + ", " + ;
			             EscaparSQL(THIS.this_cRefracao)                + ", " + ;
			             EscaparSQL(THIS.this_cRefracaodp)              + ", " + ;
			             EscaparSQL(THIS.this_cUnidade1)                + ", " + ;
			             EscaparSQL(THIS.this_cResultado1)              + ", " + ;
			             EscaparSQL(THIS.this_cValorminimo)             + ", " + ;
			             EscaparSQL(THIS.this_cValormaximo)             + ", " + ;
			             EscaparSQL(THIS.this_cMetodoreferencia1)       + ", "

			loc_cVals  = loc_cVals + ;
			             IIF(THIS.this_lFlagctabs, "1", "0")       + ", " + ;
			             IIF(THIS.this_lTcomps,    "1", "0")       + ", " + ;
			             IIF(THIS.this_lTransps,   "1", "0")       + ", " + ;
			             IIF(THIS.this_lImpetiqs,  "1", "0")       + ", " + ;
			             IIF(THIS.this_lChkfunds,  "1", "0")       + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cUsuincs)                 + ", " + ;
			             EscaparSQL(THIS.this_cUsuincs)                 + ", " + ;
			             FormatarNumeroSQL(THIS.this_nNidentfixa)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nObrtamser)        + ", " + ;
			             FormatarNumeroSQL(THIS.this_nIdpro)            + ", "

			loc_cVals  = loc_cVals + ;
			             IIF(EMPTY(THIS.this_dDtsituas),  "NULL", FormatarDataSQL(THIS.this_dDtsituas))   + ", " + ;
			             FormatarDataSQL(THIS.this_dDtincs)                                                + ", " + ;
			             IIF(EMPTY(THIS.this_dDatas),     "NULL", FormatarDataSQL(THIS.this_dDatas))      + ", " + ;
			             IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))  + ", " + ;
			             IIF(EMPTY(THIS.this_dDtfilms),   "NULL", FormatarDataSQL(THIS.this_dDtfilms))    + ", " + ;
			             IIF(EMPTY(THIS.this_dDtcomps),   "NULL", FormatarDataSQL(THIS.this_dDtcomps))    + ", " + ;
			             IIF(EMPTY(THIS.this_dDtalts),    "NULL", FormatarDataSQL(THIS.this_dDtalts))     + ", " + ;
			             IIF(EMPTY(THIS.this_dDtlacto),   "NULL", FormatarDataSQL(THIS.this_dDtlacto))    + ", " + ;
			             IIF(EMPTY(THIS.this_dFimdtlacto),"NULL", FormatarDataSQL(THIS.this_dFimdtlacto)) + ", " + ;
			             IIF(EMPTY(THIS.this_dUltcomps),  "NULL", FormatarDataSQL(THIS.this_dUltcomps))   + ", " + ;
			             IIF(THIS.this_nDiasgar = 0,      "NULL", FormatarNumeroSQL(THIS.this_nDiasgar))  + ", "

			loc_cVals  = loc_cVals + ;
			             IIF(EMPTY(THIS.this_mDpro3s),    "NULL", EscaparSQL(THIS.this_mDpro3s))     + ", " + ;
			             IIF(EMPTY(THIS.this_mDescfis),   "NULL", EscaparSQL(THIS.this_mDescfis))    + ", " + ;
			             IIF(EMPTY(THIS.this_mFigjpgs),   "NULL", EscaparSQL(THIS.this_mFigjpgs))    + ", " + ;
			             IIF(EMPTY(THIS.this_mFigjpgs64), "NULL", EscaparSQL(THIS.this_mFigjpgs64))  + ", " + ;
			             IIF(EMPTY(THIS.this_mFigtecs),   "NULL", EscaparSQL(THIS.this_mFigtecs))    + ", " + ;
			             IIF(EMPTY(THIS.this_mObscompras),"NULL", EscaparSQL(THIS.this_mObscompras)) + ", " + ;
			             IIF(EMPTY(THIS.this_mObsinsp),   "NULL", EscaparSQL(THIS.this_mObsinsp))    + ", " + ;
			             IIF(EMPTY(THIS.this_mDsccompras),"NULL", EscaparSQL(THIS.this_mDsccompras)) + ", " + ;
			             IIF(EMPTY(THIS.this_mMtiposervs),"NULL", EscaparSQL(THIS.this_mMtiposervs)) + ", " + ;
			             IIF(EMPTY(THIS.this_cCodident),  "NULL", EscaparSQL(THIS.this_cCodident))

			loc_cSQL   = "INSERT INTO SigCdPro (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.Inserir:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* Atualizar - UPDATE SigCdPro
	*====================================================================
	PROTECTED FUNCTION Atualizar()
		LOCAL loc_cSet, loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			THIS.this_dDtalts   = DATETIME()
			THIS.this_cUsuaalts = gc_4c_UsuarioLogado

			loc_cSet  = " dpros = "        + EscaparSQL(THIS.this_cDpros)            + "," + ;
			            " dpro2s = "       + EscaparSQL(THIS.this_cDpro2s)           + "," + ;
			            " cgrus = "        + EscaparSQL(THIS.this_cCgrus)            + "," + ;
			            " sgrus = "        + EscaparSQL(THIS.this_cSgrus)            + "," + ;
			            " linhas = "       + EscaparSQL(THIS.this_cLinhas)           + "," + ;
			            " colecoes = "     + EscaparSQL(THIS.this_cColecoes)         + "," + ;
			            " conjunts = "     + EscaparSQL(THIS.this_cConjunts)         + "," + ;
			            " tipos = "        + EscaparSQL(THIS.this_cTipos)            + ","

			loc_cSet  = loc_cSet + ;
			            " status = "       + EscaparSQL(THIS.this_cStatus)           + "," + ;
			            " situas = "       + FormatarNumeroSQL(THIS.this_nSituas)    + "," + ;
			            " cclass = "       + EscaparSQL(THIS.this_cCclass)           + "," + ;
			            " nivelqs = "      + EscaparSQL(THIS.this_cNivelqs)          + "," + ;
			            " categoria = "    + EscaparSQL(THIS.this_cCategoria)        + "," + ;
			            " codctgsite = "   + EscaparSQL(THIS.this_cCodctgsite)       + "," + ;
			            " coddptsite = "   + EscaparSQL(THIS.this_cCoddptsite)       + "," + ;
			            " codmacro = "     + EscaparSQL(THIS.this_cCodmacro)         + ","

			loc_cSet  = loc_cSet + ;
			            " ifors = "        + EscaparSQL(THIS.this_cIfors)            + "," + ;
			            " reffs = "        + EscaparSQL(THIS.this_cReffs)            + "," + ;
			            " cvens = "        + EscaparSQL(THIS.this_cCvens)            + ","

			loc_cSet  = loc_cSet + ;
			            " codcors = "      + EscaparSQL(THIS.this_cCodcors)          + "," + ;
			            " codtams = "      + EscaparSQL(THIS.this_cCodtams)          + "," + ;
			            " matprincs = "    + EscaparSQL(THIS.this_cMatprincs)        + "," + ;
			            " metals = "       + EscaparSQL(THIS.this_cMetals)           + "," + ;
			            " teors = "        + EscaparSQL(THIS.this_cTeors)            + "," + ;
			            " compos = "       + EscaparSQL(THIS.this_cCompos)           + "," + ;
			            " conquilhas = "   + EscaparSQL(THIS.this_cConquilhas)       + "," + ;
			            " propriedades = " + EscaparSQL(THIS.this_cPropriedades)     + "," + ;
			            " cravcers = "     + FormatarNumeroSQL(THIS.this_nCravcers)  + ","

			loc_cSet  = loc_cSet + ;
			            " pcuss = "        + FormatarNumeroSQL(THIS.this_nPcuss)     + "," + ;
			            " pvens = "        + FormatarNumeroSQL(THIS.this_nPvens)     + "," + ;
			            " pvideals = "     + FormatarNumeroSQL(THIS.this_nPvideals)  + "," + ;
			            " precode = "      + FormatarNumeroSQL(THIS.this_nPrecode)   + "," + ;
			            " custofs = "      + FormatarNumeroSQL(THIS.this_nCustofs)   + "," + ;
			            " custocp = "      + FormatarNumeroSQL(THIS.this_nCustocp)   + "," + ;
			            " valors = "       + FormatarNumeroSQL(THIS.this_nValors)    + "," + ;
			            " markupa = "      + FormatarNumeroSQL(THIS.this_nMarkupa)   + "," + ;
			            " margems = "      + FormatarNumeroSQL(THIS.this_nMargems)   + "," + ;
			            " fcustos = "      + FormatarNumeroSQL(THIS.this_nFcustos)   + "," + ;
			            " fvendas = "      + FormatarNumeroSQL(THIS.this_nFvendas)   + "," + ;
			            " fatuals = "      + FormatarNumeroSQL(THIS.this_nFatuals)   + "," + ;
			            " fideals = "      + FormatarNumeroSQL(THIS.this_nFideals)   + "," + ;
			            " cotacalcp = "    + FormatarNumeroSQL(THIS.this_nCotacalcp) + ","

			loc_cSet  = loc_cSet + ;
			            " moecs = "        + EscaparSQL(THIS.this_cMoecs)            + "," + ;
			            " moecusfs = "     + EscaparSQL(THIS.this_cMoecusfs)         + "," + ;
			            " moedas = "       + EscaparSQL(THIS.this_cMoedas)           + "," + ;
			            " moepcs = "       + EscaparSQL(THIS.this_cMoepcs)           + "," + ;
			            " moepvs = "       + EscaparSQL(THIS.this_cMoepvs)           + "," + ;
			            " moevs = "        + EscaparSQL(THIS.this_cMoevs)            + ","

			loc_cSet  = loc_cSet + ;
			            " clfiscals = "    + EscaparSQL(THIS.this_cClfiscals)        + "," + ;
			            " sittricms = "    + EscaparSQL(THIS.this_cSittricms)        + "," + ;
			            " icms = "         + FormatarNumeroSQL(THIS.this_nIcms)      + "," + ;
			            " aliqipis = "     + FormatarNumeroSQL(THIS.this_nAliqipis)  + "," + ;
			            " ipis = "         + EscaparSQL(THIS.this_cIpis)             + "," + ;
			            " tptribs = "      + EscaparSQL(THIS.this_cTptribs)          + "," + ;
			            " origmercs = "    + EscaparSQL(THIS.this_cOrigmercs)        + "," + ;
			            " extipi = "       + EscaparSQL(THIS.this_cExtipi)           + "," + ;
			            " mercs = "        + EscaparSQL(THIS.this_cMercs)            + "," + ;
			            " descecfs = "     + EscaparSQL(THIS.this_cDescecfs)         + "," + ;
			            " codgarras = "    + EscaparSQL(THIS.this_cCodgarras)        + "," + ;
			            " mftios = "       + EscaparSQL(THIS.this_cMftios)           + "," + ;
			            " pftios = "       + FormatarNumeroSQL(THIS.this_nPftios)    + "," + ;
			            " cftios = "       + EscaparSQL(THIS.this_cCftios)           + "," + ;
			            " cftiocs = "      + EscaparSQL(THIS.this_cCftiocs)          + "," + ;
			            " pftiocs = "      + FormatarNumeroSQL(THIS.this_nPftiocs)   + "," + ;
			            " codservs = "     + EscaparSQL(THIS.this_cCodservs)         + "," + ;
			            " iats = "         + EscaparSQL(THIS.this_cIats)             + "," + ;
			            " codacbs = "      + EscaparSQL(THIS.this_cCodacbs)          + "," + ;
			            " encargos = "     + FormatarNumeroSQL(THIS.this_nEncargos)  + "," + ;
			            " codfinp = "      + EscaparSQL(THIS.this_cCodfinp)          + "," + ;
			            " codmatp = "      + EscaparSQL(THIS.this_cCodmatp)          + "," + ;
			            " idecpros = "     + EscaparSQL(THIS.this_cIdecpros)         + ","

			loc_cSet  = loc_cSet + ;
			            " pesoms = "       + FormatarNumeroSQL(THIS.this_nPesoms)    + "," + ;
			            " pesobs = "       + FormatarNumeroSQL(THIS.this_nPesobs)    + "," + ;
			            " pesometal = "    + FormatarNumeroSQL(THIS.this_nPesometal) + "," + ;
			            " pesobris = "     + FormatarNumeroSQL(THIS.this_nPesobris)  + "," + ;
			            " pesopdrs = "     + FormatarNumeroSQL(THIS.this_nPesopdrs)  + "," + ;
			            " altura = "       + FormatarNumeroSQL(THIS.this_nAltura)    + "," + ;
			            " largura = "      + FormatarNumeroSQL(THIS.this_nLargura)   + "," + ;
			            " diametro = "     + FormatarNumeroSQL(THIS.this_nDiametro)  + "," + ;
			            " espessura = "    + FormatarNumeroSQL(THIS.this_nEspessura) + "," + ;
			            " compriment = "   + FormatarNumeroSQL(THIS.this_nCompriment)+ "," + ;
			            " varias = "       + FormatarNumeroSQL(THIS.this_nVarias)    + "," + ;
			            " varpesoms = "    + FormatarNumeroSQL(THIS.this_nVarpesoms) + ","

			loc_cSet  = loc_cSet + ;
			            " qmins = "        + FormatarNumeroSQL(THIS.this_nQmins)     + "," + ;
			            " pmins = "        + FormatarNumeroSQL(THIS.this_nPmins)     + "," + ;
			            " qtminfabs = "    + FormatarNumeroSQL(THIS.this_nQtminfabs) + "," + ;
			            " ltminsv = "      + FormatarNumeroSQL(THIS.this_nLtminsv)   + "," + ;
			            " qtdultcomp = "   + FormatarNumeroSQL(THIS.this_nQtdultcomp)+ "," + ;
			            " vultcomps = "    + FormatarNumeroSQL(THIS.this_nVultcomps) + "," + ;
			            " multcomps = "    + EscaparSQL(THIS.this_cMultcomps)        + "," + ;
			            " qtped = "        + FormatarNumeroSQL(THIS.this_nQtped)     + "," + ;
			            " encoms = "       + FormatarNumeroSQL(THIS.this_nEncoms)    + "," + ;
			            " consigs = "      + FormatarNumeroSQL(THIS.this_nConsigs)   + ","

			loc_cSet  = loc_cSet + ;
			            " cunis = "        + EscaparSQL(THIS.this_cCunis)            + "," + ;
			            " cunips = "       + EscaparSQL(THIS.this_cCunips)           + "," + ;
			            " cbars = "        + FormatarNumeroSQL(THIS.this_nCbars)     + "," + ;
			            " ean13 = "        + FormatarNumeroSQL(THIS.this_nEan13)     + "," + ;
			            " skuvtex = "      + EscaparSQL(THIS.this_cSkuvtex)          + ","

			loc_cSet  = loc_cSet + ;
			            " cproeqs = "      + EscaparSQL(THIS.this_cCproeqs)          + "," + ;
			            " qtdcpnts = "     + FormatarNumeroSQL(THIS.this_nQtdcpnts)  + "," + ;
			            " montadescs = "   + FormatarNumeroSQL(THIS.this_nMontadescs)+ "," + ;
			            " digimaxs = "     + FormatarNumeroSQL(THIS.this_nDigimaxs)  + "," + ;
			            " ordcompos = "    + FormatarNumeroSQL(THIS.this_nOrdcompos) + "," + ;
			            " casas = "        + FormatarNumeroSQL(THIS.this_nCasas)     + "," + ;
			            " volumes = "      + FormatarNumeroSQL(THIS.this_nVolumes)   + "," + ;
			            " tamhs = "        + FormatarNumeroSQL(THIS.this_nTamhs)     + "," + ;
			            " tamls = "        + FormatarNumeroSQL(THIS.this_nTamls)     + "," + ;
			            " tamps = "        + FormatarNumeroSQL(THIS.this_nTamps)     + ","

			loc_cSet  = loc_cSet + ;
			            " fabrproprs = "   + FormatarNumeroSQL(THIS.this_nFabrproprs)  + "," + ;
			            " tents = "        + FormatarNumeroSQL(THIS.this_nTents)       + "," + ;
			            " tinsts = "       + FormatarNumeroSQL(THIS.this_nTinsts)      + "," + ;
			            " diasinas = "     + FormatarNumeroSQL(THIS.this_nDiasinas)    + "," + ;
			            " prodvars = "     + FormatarNumeroSQL(THIS.this_nProdvars)    + "," + ;
			            " prodwebs = "     + FormatarNumeroSQL(THIS.this_nProdwebs)    + "," + ;
			            " prodnovo = "     + FormatarNumeroSQL(THIS.this_nProtnovo)    + "," + ;
			            " prodoff = "      + FormatarNumeroSQL(THIS.this_nProdoff)     + "," + ;
			            " prototipo = "    + FormatarNumeroSQL(THIS.this_nPrototipo)   + "," + ;
			            " reposauto = "    + FormatarNumeroSQL(THIS.this_nReposauto)   + "," + ;
			            " procfigjpgs = "  + FormatarNumeroSQL(THIS.this_nProcfigjpgs) + ","

			loc_cSet  = loc_cSet + ;
			            " contaccus = "    + EscaparSQL(THIS.this_cContaccus)         + "," + ;
			            " gruccus = "      + EscaparSQL(THIS.this_cGruccus)           + "," + ;
			            " comis = "        + FormatarNumeroSQL(THIS.this_nComis)      + "," + ;
			            " locals = "       + EscaparSQL(THIS.this_cLocals)            + "," + ;
			            " notas = "        + EscaparSQL(THIS.this_cNotas)             + "," + ;
			            " obsetqs = "      + EscaparSQL(THIS.this_cObsetqs)           + "," + ;
			            " obspeds = "      + EscaparSQL(THIS.this_cObspeds)           + "," + ;
			            " obspes = "       + EscaparSQL(THIS.this_cObspes)            + "," + ;
			            " obsmkt = "       + EscaparSQL(THIS.this_cObsmkt)            + ","

			loc_cSet  = loc_cSet + ;
			            " ativosite = "    + FormatarNumeroSQL(THIS.this_nAtivosite)  + "," + ;
			            " foralinha = "    + FormatarNumeroSQL(THIS.this_nForalinha)  + "," + ;
			            " mostruario = "   + FormatarNumeroSQL(THIS.this_nMostruario) + "," + ;
			            " bestseller = "   + FormatarNumeroSQL(THIS.this_nBestseller) + "," + ;
			            " segfem = "       + FormatarNumeroSQL(THIS.this_nSegfem)     + "," + ;
			            " seginf = "       + FormatarNumeroSQL(THIS.this_nSeginf)     + "," + ;
			            " segkids = "      + FormatarNumeroSQL(THIS.this_nSegkids)    + "," + ;
			            " segmasc = "      + FormatarNumeroSQL(THIS.this_nSegmasc)    + "," + ;
			            " seguni = "       + FormatarNumeroSQL(THIS.this_nSeguni)     + "," + ;
			            " semconsulta = "  + FormatarNumeroSQL(THIS.this_nSemconsulta)+ "," + ;
			            " lancamento = "   + EscaparSQL(THIS.this_cLancamento)        + "," + ;
			            " origemlac = "    + EscaparSQL(THIS.this_cOrigemlac)         + ","

			loc_cSet  = loc_cSet + ;
			            " chkgarvit = "    + FormatarNumeroSQL(THIS.this_nChkgarvit)       + "," + ;
			            " mohs = "         + FormatarNumeroSQL(THIS.this_nMohs)            + "," + ;
			            " refracao = "     + EscaparSQL(THIS.this_cRefracao)               + "," + ;
			            " refracaodp = "   + EscaparSQL(THIS.this_cRefracaodp)             + "," + ;
			            " unidade1 = "     + EscaparSQL(THIS.this_cUnidade1)               + "," + ;
			            " resultado1 = "   + EscaparSQL(THIS.this_cResultado1)             + "," + ;
			            " valorminimo = "  + EscaparSQL(THIS.this_cValorminimo)            + "," + ;
			            " valormaximo = "  + EscaparSQL(THIS.this_cValormaximo)            + "," + ;
			            " metodoreferencia1 = " + EscaparSQL(THIS.this_cMetodoreferencia1) + ","

			loc_cSet  = loc_cSet + ;
			            " flagctabs = "    + IIF(THIS.this_lFlagctabs, "1", "0")      + "," + ;
			            " tcomps = "       + IIF(THIS.this_lTcomps,    "1", "0")      + "," + ;
			            " transps = "      + IIF(THIS.this_lTransps,   "1", "0")      + "," + ;
			            " impetiqs = "     + IIF(THIS.this_lImpetiqs,  "1", "0")      + "," + ;
			            " chkfunds = "     + IIF(THIS.this_lChkfunds,  "1", "0")      + ","

			loc_cSet  = loc_cSet + ;
			            " usuaalts = "     + EscaparSQL(THIS.this_cUsuaalts)               + "," + ;
			            " nidentfixa = "   + FormatarNumeroSQL(THIS.this_nNidentfixa)      + "," + ;
			            " obrtamser = "    + FormatarNumeroSQL(THIS.this_nObrtamser)       + ","

			loc_cSet  = loc_cSet + ;
			            " dtsituas = "     + IIF(EMPTY(THIS.this_dDtsituas),  "NULL", FormatarDataSQL(THIS.this_dDtsituas))   + "," + ;
			            " datas = "        + IIF(EMPTY(THIS.this_dDatas),     "NULL", FormatarDataSQL(THIS.this_dDatas))      + "," + ;
			            " datatrans = "    + IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))  + "," + ;
			            " dtfilms = "      + IIF(EMPTY(THIS.this_dDtfilms),   "NULL", FormatarDataSQL(THIS.this_dDtfilms))    + "," + ;
			            " dtcomps = "      + IIF(EMPTY(THIS.this_dDtcomps),   "NULL", FormatarDataSQL(THIS.this_dDtcomps))    + "," + ;
			            " dtalts = "       + FormatarDataSQL(THIS.this_dDtalts)                                               + "," + ;
			            " dtlacto = "      + IIF(EMPTY(THIS.this_dDtlacto),   "NULL", FormatarDataSQL(THIS.this_dDtlacto))    + "," + ;
			            " fimdtlacto = "   + IIF(EMPTY(THIS.this_dFimdtlacto),"NULL", FormatarDataSQL(THIS.this_dFimdtlacto)) + "," + ;
			            " ultcomps = "     + IIF(EMPTY(THIS.this_dUltcomps),  "NULL", FormatarDataSQL(THIS.this_dUltcomps))   + "," + ;
			            " diasgar = "      + IIF(THIS.this_nDiasgar = 0,      "NULL", FormatarNumeroSQL(THIS.this_nDiasgar))  + "," + ;
			            " codident = "     + IIF(EMPTY(THIS.this_cCodident),  "NULL", EscaparSQL(THIS.this_cCodident))        + ","

			loc_cSet  = loc_cSet + ;
			            " dpro3s = "       + IIF(EMPTY(THIS.this_mDpro3s),    "NULL", EscaparSQL(THIS.this_mDpro3s))     + "," + ;
			            " descfis = "      + IIF(EMPTY(THIS.this_mDescfis),   "NULL", EscaparSQL(THIS.this_mDescfis))    + "," + ;
			            " figjpgs = "      + IIF(EMPTY(THIS.this_mFigjpgs),   "NULL", EscaparSQL(THIS.this_mFigjpgs))    + "," + ;
			            " figjpgs64 = "    + IIF(EMPTY(THIS.this_mFigjpgs64), "NULL", EscaparSQL(THIS.this_mFigjpgs64))  + "," + ;
			            " figtecs = "      + IIF(EMPTY(THIS.this_mFigtecs),   "NULL", EscaparSQL(THIS.this_mFigtecs))    + "," + ;
			            " obscompras = "   + IIF(EMPTY(THIS.this_mObscompras),"NULL", EscaparSQL(THIS.this_mObscompras)) + "," + ;
			            " obsinsp = "      + IIF(EMPTY(THIS.this_mObsinsp),   "NULL", EscaparSQL(THIS.this_mObsinsp))    + "," + ;
			            " dsccompras = "   + IIF(EMPTY(THIS.this_mDsccompras),"NULL", EscaparSQL(THIS.this_mDsccompras)) + "," + ;
			            " mtiposervs = "   + IIF(EMPTY(THIS.this_mMtiposervs),"NULL", EscaparSQL(THIS.this_mMtiposervs))

			loc_cSQL   = "UPDATE SigCdPro SET" + loc_cSet + ;
			             " WHERE cpros = " + EscaparSQL(THIS.this_cCpros)
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.Atualizar:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ExecutarExclusao - DELETE FROM SigCdPro
	*====================================================================
	PROTECTED FUNCTION ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			loc_cSQL    = "DELETE FROM SigCdPro WHERE cpros = " + EscaparSQL(THIS.this_cCpros)
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

ENDDEFINE

