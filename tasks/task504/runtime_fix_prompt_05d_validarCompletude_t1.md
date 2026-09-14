# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormProduto.prg] Procedure vazia (sem codigo): ChkFundClick
[FormProduto.prg] Procedure vazia (sem codigo): CboTiposCustoInteractiveChange
[FormProduto.prg] Procedure vazia (sem codigo): GrdCompoAfterRowColChange
[FormProduto.prg] Procedure vazia (sem codigo): GrdSubCpAfterRowColChange
[FormProduto.prg] Procedure vazia (sem codigo): ChkLiberaCustoClick
[FormProduto.prg] Procedure vazia (sem codigo): ChkLiberaVendaClick
[FormProduto.prg] Procedure vazia (sem codigo): ChkPlanCusClick
[FormProduto.prg] Procedure vazia (sem codigo): ChkPlanVenClick
[FormProduto.prg] Procedure vazia (sem codigo): ChkPvendaClick
[FormProduto.prg] Procedure vazia (sem codigo): TxtObsOFsWhen
[FormProduto.prg] Procedure vazia (sem codigo): TxtObsOFsKeyPress

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO

### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormProduto",
  "timestamp": "20260823031820",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": true,
      "erro": "",
      "detalhes": "0 registros em cursor_4c_Dados"
    },
    {
      "nome": "ModoIncluir",
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
    },
    {
      "nome": "ModoVisualizar",
      "passou": true,
      "erro": "",
      "detalhes": "Modo VISUALIZAR configurado"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "BtnIncluirClick navegou para Page2 | BtnCancelarClick retornou para Page1"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnEncerrarClick encontrado"
    },
    {
      "nome": "GridTemDados",
      "passou": true,
      "erro": "",
      "detalhes": "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 3 (KEYPRESS, TXTCGRUSKEYPRESS, TXTIFORSKEYPRESS)"
    },
    {
      "nome": "Fechar",
      "passou": true,
      "erro": "",
      "detalhes": "Formulario fechado com sucesso"
    }
  ],
  "resumo": {
    "total": 9,
    "passou": 9,
    "falhou": 0,
    "percentual": 100
  }
}



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
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
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
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
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

        *-- Container BotoesAcao (original: Top=85, Left=9, Width=160, Height=85)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 85
            .Left        = 9
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

        *-- Tabs 2-8: label descritivo de cada aba
        THIS.ConfigurarPgpgCusto(loc_oPagina.pgf_4c_Dados.Page2)
        THIS.ConfigurarPgpgDadosFiscais(loc_oPagina.pgf_4c_Dados.Page3)
        THIS.ConfigurarPgPgDadosFaseP(loc_oPagina.pgf_4c_Dados.Page4)
        THIS.ConfigurarPgPgDadosConsP(loc_oPagina.pgf_4c_Dados.Page5)
        THIS.ConfigurarPgpgComposicao(loc_oPagina.pgf_4c_Dados.Page6)
        THIS.ConfigurarPgpgDesigner(loc_oPagina.pgf_4c_Dados.Page7)
        THIS.ConfigurarPgpgServico(loc_oPagina.pgf_4c_Dados.Page8)

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
        BINDEVENT(loc_oPg.opt_4c_Situacao, "InteractiveChange", THIS, "OptSituacaoInteractiveChange")

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
        BINDEVENT(loc_oPg.txt_4c_Cgrus, "KeyPress", THIS, "TxtCgrusKeyPress")
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
        BINDEVENT(loc_oPg.txt_4c_Ifors, "KeyPress", THIS, "TxtIforsKeyPress")
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
    * ConfigurarPgDadosInfo - Configura label descritivo em aba do pgf_4c_Dados
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgDadosInfo(par_oPg, par_cConteudo)
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
                CREATE CURSOR cursor_4c_Dados (cpros C(14), dpros C(65), cgrus C(3), ;
                    sgrus C(6), linhas C(10), tipos C(1), situas N(1,0), ifors C(10), ;
                    pvens N(11,5), pcuss N(11,5), custofs N(11,3), cunis C(3), ;
                    matprincs C(14), codcors C(4), codtams C(4), reffs C(40), ;
                    colecoes C(10), idpro N(10,0))
                loc_lResultado = .T.
            ELSE
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
                loc_oGrid.Column4.Header1.Caption = "Subgrp."
                loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
                loc_oGrid.Column6.Header1.Caption = "Grp"
                loc_oGrid.Column7.Header1.Caption = "I"

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
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProduto"
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
    PROCEDURE AjustarBotoesPorModo()
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

            *-- Campos da aba FaseP (Page4 de pgf_4c_Dados)
            LOCAL loc_oPgFP
            loc_oPgFP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF PEMSTATUS(loc_oPgFP, "txt_4c_QminFabs", 5)
                loc_oBO.this_nQtminfabs  = loc_oPgFP.txt_4c_QminFabs.Value
                loc_oBO.this_cCodgarras  = ALLTRIM(loc_oPgFP.txt_4c_CodGarras.Value)
                loc_oBO.this_cConquilhas = ALLTRIM(loc_oPgFP.txt_4c_Conquilhas.Value)
                loc_oBO.this_nPesobris   = loc_oPgFP.txt_4c_PesoBris.Value
                loc_oBO.this_nPesometal  = loc_oPgFP.txt_4c_PesoMetal.Value
                loc_oBO.this_nPesopdrs   = loc_oPgFP.txt_4c_PesoPdrs.Value
                loc_oBO.this_cCodcors    = ALLTRIM(loc_oPgFP.txt_4c_CodCorsFP.Value)
                loc_oBO.this_cCodtams    = ALLTRIM(loc_oPgFP.txt_4c_CodTamsFP.Value)
                loc_oBO.this_cCodacbs    = ALLTRIM(loc_oPgFP.txt_4c_CodAcbsFP.Value)
                loc_oBO.this_nCravcers   = IIF(loc_oPgFP.chk_4c_CravCera.Value = 1, 1, 0)
                loc_oBO.this_nVarias     = IIF(loc_oPgFP.chk_4c_Varias.Value = 1, 1, 0)
                loc_oBO.this_nDiasgar    = loc_oPgFP.txt_4c_DiasGar.Value
                loc_oBO.this_nTents      = loc_oPgFP.txt_4c_TEnts.Value
                loc_oBO.this_nVolumes    = loc_oPgFP.txt_4c_Volumes.Value
                loc_oBO.this_nLtminsv    = loc_oPgFP.txt_4c_LtMinsV.Value
                loc_oBO.this_nProdvars   = loc_oPgFP.opt_4c_Prodvars.Value

                *-- Flush obs do EditBox para o cursor da linha selecionada antes de salvar
                IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase") AND ;
                        PEMSTATUS(loc_oPgFP, "edt_4c_Obs", 5)
                    SELECT cursor_4c_GradFase
                    REPLACE cursor_4c_GradFase.obs WITH loc_oPgFP.edt_4c_Obs.Value
                ENDIF
            ENDIF

            *-- Campos da aba Dados Fiscais (Page3 de pgf_4c_Dados)
            LOCAL loc_oPgFisc, loc_nIpiIdx
            loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF PEMSTATUS(loc_oPgFisc, "txt_4c_Clfiscal", 5)
                loc_oBO.this_cClfiscals  = ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)
                loc_oBO.this_cOrigmercs  = ALLTRIM(loc_oPgFisc.txt_4c_Origmerc.Value)
                loc_oBO.this_cSittricms  = ALLTRIM(loc_oPgFisc.txt_4c_Sittricm.Value)
                loc_oBO.this_nIcms       = loc_oPgFisc.txt_4c_Icms.Value
                loc_oBO.this_cTptribs    = ALLTRIM(loc_oPgFisc.txt_4c_TpTrib.Value)
                loc_oBO.this_cIats       = ALLTRIM(loc_oPgFisc.txt_4c_Iat.Value)
                loc_oBO.this_nAliqipis   = loc_oPgFisc.txt_4c_AliqIPI.Value
                loc_oBO.this_cExtipi     = ALLTRIM(loc_oPgFisc.txt_4c_Extipi.Value)
                loc_oBO.this_mDescfis    = loc_oPgFisc.obj_4c_Mgetdescfi.Value
                loc_oBO.this_cGruccus    = ALLTRIM(loc_oPgFisc.txt_4c__gruccus.Value)
                loc_oBO.this_cContaccus  = ALLTRIM(loc_oPgFisc.txt_4c__contaccus.Value)
                loc_oBO.this_cMetals     = ALLTRIM(loc_oPgFisc.txt_4c_Metal.Value)
                loc_oBO.this_cTeors      = ALLTRIM(loc_oPgFisc.txt_4c_Teor.Value)
                loc_oBO.this_nValors     = loc_oPgFisc.txt_4c_Valor.Value
                loc_oBO.this_cMoedas     = ALLTRIM(loc_oPgFisc.txt_4c_Mvalor.Value)
                loc_oBO.this_cDescecfs   = ALLTRIM(loc_oPgFisc.txt_4c_DescEcfs.Value)
                loc_oBO.this_cCodservs   = ALLTRIM(loc_oPgFisc.txt_4c_Codigo.Value)
                *-- IPI combo: ListIndex -> Code
                loc_nIpiIdx = loc_oPgFisc.cbo_4c_CmbIpi.ListIndex
                DO CASE
                CASE loc_nIpiIdx = 2
                    loc_oBO.this_cIpis = "T"
                CASE loc_nIpiIdx = 3
                    loc_oBO.this_cIpis = "I"
                CASE loc_nIpiIdx = 4
                    loc_oBO.this_cIpis = "O"
                OTHERWISE
                    loc_oBO.this_cIpis = ""
                ENDCASE
            ENDIF

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

            *-- Preencher controles da aba FaseP (Page4)
            LOCAL loc_oPgFP
            loc_oPgFP = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF PEMSTATUS(loc_oPgFP, "txt_4c_QminFabs", 5)
                loc_oPgFP.txt_4c_QminFabs.Value    = loc_oBO.this_nQtminfabs
                loc_oPgFP.txt_4c_CodGarras.Value   = ALLTRIM(loc_oBO.this_cCodgarras)
                loc_oPgFP.txt_4c_Conquilhas.Value  = ALLTRIM(loc_oBO.this_cConquilhas)
                loc_oPgFP.txt_4c_PesoBris.Value    = loc_oBO.this_nPesobris
                loc_oPgFP.txt_4c_PesoMetal.Value   = loc_oBO.this_nPesometal
                loc_oPgFP.txt_4c_PesoPdrs.Value    = loc_oBO.this_nPesopdrs
                loc_oPgFP.txt_4c_CodCorsFP.Value   = ALLTRIM(loc_oBO.this_cCodcors)
                loc_oPgFP.txt_4c_CodTamsFP.Value   = ALLTRIM(loc_oBO.this_cCodtams)
                loc_oPgFP.txt_4c_CodAcbsFP.Value   = ALLTRIM(loc_oBO.this_cCodacbs)
                loc_oPgFP.txt_4c_DacbFP.Value      = ""
                loc_oPgFP.chk_4c_CravCera.Value    = IIF(loc_oBO.this_nCravcers = 1, 1, 0)
                loc_oPgFP.chk_4c_Varias.Value      = IIF(loc_oBO.this_nVarias = 1, 1, 0)
                loc_oPgFP.txt_4c_DiasGar.Value     = loc_oBO.this_nDiasgar
                loc_oPgFP.txt_4c_TEnts.Value       = loc_oBO.this_nTents
                loc_oPgFP.txt_4c_Volumes.Value     = loc_oBO.this_nVolumes
                loc_oPgFP.txt_4c_LtMinsV.Value     = loc_oBO.this_nLtminsv
                loc_oPgFP.txt_4c_DtUcp.Value       = IIF(EMPTY(loc_oBO.this_dUltcomps), "", ;
                    TRANSFORM(TTOD(loc_oBO.this_dUltcomps), "@YL"))
                loc_oPgFP.txt_4c_VUcp.Value        = loc_oBO.this_nVultcomps
                loc_oPgFP.txt_4c_MUcp.Value        = ALLTRIM(loc_oBO.this_cMultcomps)
                loc_oPgFP.opt_4c_Prodvars.Value    = IIF(loc_oBO.this_nProdvars = 1, 1, 2)
                *-- Carregar grids de FaseP
                THIS.CarregarFaseP()
                *-- Carregar grid de Servicos (Page8)
                THIS.CarregarServicos()
            ENDIF

            *-- Preencher controles da aba Dados Fiscais (Page3 de pgf_4c_Dados)
            LOCAL loc_oPgFisc
            loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF PEMSTATUS(loc_oPgFisc, "txt_4c_Clfiscal", 5)
                loc_oPgFisc.txt_4c_Clfiscal.Value    = ALLTRIM(loc_oBO.this_cClfiscals)
                loc_oPgFisc.txt_4c_Dclfiscal.Value   = ""
                loc_oPgFisc.txt_4c_Origmerc.Value    = ALLTRIM(loc_oBO.this_cOrigmercs)
                loc_oPgFisc.txt_4c_Dorigmerc.Value   = ""
                loc_oPgFisc.txt_4c_Sittricm.Value    = ALLTRIM(loc_oBO.this_cSittricms)
                loc_oPgFisc.txt_4c_Dsittricm.Value   = ""
                loc_oPgFisc.txt_4c_Icms.Value        = loc_oBO.this_nIcms
                loc_oPgFisc.txt_4c_TpTrib.Value      = ALLTRIM(loc_oBO.this_cTptribs)
                loc_oPgFisc.txt_4c_Iat.Value         = ALLTRIM(loc_oBO.this_cIats)
                loc_oPgFisc.txt_4c_AliqIPI.Value     = loc_oBO.this_nAliqipis
                loc_oPgFisc.txt_4c_Extipi.Value      = ALLTRIM(loc_oBO.this_cExtipi)
                loc_oPgFisc.obj_4c_Mgetdescfi.Value  = loc_oBO.this_mDescfis
                loc_oPgFisc.txt_4c__gruccus.Value    = ALLTRIM(loc_oBO.this_cGruccus)
                loc_oPgFisc.txt_4c__dgruccus.Value   = ""
                loc_oPgFisc.txt_4c__contaccus.Value  = ALLTRIM(loc_oBO.this_cContaccus)
                loc_oPgFisc.txt_4c__dcontaccus.Value = ""
                loc_oPgFisc.txt_4c_Metal.Value       = ALLTRIM(loc_oBO.this_cMetals)
                loc_oPgFisc.txt_4c_DesMetal.Value    = ""
                loc_oPgFisc.txt_4c_Teor.Value        = ALLTRIM(loc_oBO.this_cTeors)
                loc_oPgFisc.txt_4c_DesTeor.Value     = ""
                loc_oPgFisc.txt_4c_Valor.Value       = loc_oBO.this_nValors
                loc_oPgFisc.txt_4c_Mvalor.Value      = ALLTRIM(loc_oBO.this_cMoedas)
                loc_oPgFisc.txt_4c_DescEcfs.Value    = ALLTRIM(loc_oBO.this_cDescecfs)
                loc_oPgFisc.txt_4c_Codigo.Value      = ALLTRIM(loc_oBO.this_cCodservs)
                *-- IPI combo: Code -> ListIndex
                DO CASE
                CASE ALLTRIM(loc_oBO.this_cIpis) = "T"
                    loc_oPgFisc.cbo_4c_CmbIpi.ListIndex = 2
                CASE ALLTRIM(loc_oBO.this_cIpis) = "I"
                    loc_oPgFisc.cbo_4c_CmbIpi.ListIndex = 3
                CASE ALLTRIM(loc_oBO.this_cIpis) = "O"
                    loc_oPgFisc.cbo_4c_CmbIpi.ListIndex = 4
                OTHERWISE
                    loc_oPgFisc.cbo_4c_CmbIpi.ListIndex = 1
                ENDCASE
                *-- Carregar descricoes dos campos lookup fiscais (silencioso)
                THIS.CarregarDescricoesFiscais()
            ENDIF

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

        IF USED("cursor_4c_GrdCompo")
            USE IN cursor_4c_GrdCompo
        ENDIF
        IF USED("cursor_4c_GrdSubCp")
            USE IN cursor_4c_GrdSubCp
        ENDIF
        IF USED("cursor_4c_GrdRelogios")
            USE IN cursor_4c_GrdRelogios
        ENDIF
        IF USED("TotGrupo")
            USE IN TotGrupo
        ENDIF

        IF USED("cursor_4c_GrdConsP")
            USE IN cursor_4c_GrdConsP
        ENDIF
        IF USED("cursor_4c_GrDTEMP")
            USE IN cursor_4c_GrDTEMP
        ENDIF
        IF USED("cursor_4c_GradFase")
            USE IN cursor_4c_GradFase
        ENDIF
        IF USED("cursor_4c_GrdMatrizes")
            USE IN cursor_4c_GrdMatrizes
        ENDIF
        IF USED("cursor_4c_TotGrupo2")
            USE IN cursor_4c_TotGrupo2
        ENDIF

        IF USED("cursor_4c_GrdServico")
            USE IN cursor_4c_GrdServico
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
    * CarregarDescricoesFiscais - Popula campos descricao da aba Dados Fiscais
    * Chamado de BOParaForm ao exibir registro existente
    *===========================================================================
    PROTECTED PROCEDURE CarregarDescricoesFiscais()
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                RETURN
            ENDIF

            *-- Classificacao Fiscal (SigCdClf: codigos/descricaos)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpFiscDesc")
                IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
                    loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
                ENDIF
                IF USED("cursor_4c_LkpFiscDesc")
                    USE IN cursor_4c_LkpFiscDesc
                ENDIF
            ENDIF

            *-- Origem Mercadoria (SIGCDORG: codigos/descricaos)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpFiscDesc")
                IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
                    loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
                ENDIF
                IF USED("cursor_4c_LkpFiscDesc")
                    USE IN cursor_4c_LkpFiscDesc
                ENDIF
            ENDIF

            *-- Situacao Tributaria ICMS (SIGCDICM: codigos/descricaos)
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
                    "cursor_4c_LkpFiscDesc")
                IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
                    loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descricaos)
                ENDIF
                IF USED("cursor_4c_LkpFiscDesc")
                    USE IN cursor_4c_LkpFiscDesc
                ENDIF
            ENDIF

            *-- Metal (SigCdMtl: codigos/descs WHERE tipos='M')
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
                    " AND tipos = 'M'", ;
                    "cursor_4c_LkpFiscDesc")
                IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
                    loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descs)
                ENDIF
                IF USED("cursor_4c_LkpFiscDesc")
                    USE IN cursor_4c_LkpFiscDesc
                ENDIF
            ENDIF

            *-- Teor (SigCdMtl: codigos/descs WHERE tipos<>'M')
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
                    " AND tipos <> 'M'", ;
                    "cursor_4c_LkpFiscDesc")
                IF loc_nRet > 0 AND USED("cursor_4c_LkpFiscDesc") AND !EOF("cursor_4c_LkpFiscDesc")
                    loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(cursor_4c_LkpFiscDesc.descs)
                ENDIF
                IF USED("cursor_4c_LkpFiscDesc")
                    USE IN cursor_4c_LkpFiscDesc
                ENDIF
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_LkpFiscDesc")
                USE IN cursor_4c_LkpFiscDesc
            ENDIF
            MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(245) + "es fiscais:" + CHR(13) + ;
                loException.Message, "FormProduto.CarregarDescricoesFiscais")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarCampos - Valida campos obrigatorios antes de salvar
    *===========================================================================
    PROTECTED PROCEDURE ValidarCampos()
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
    ENDPROC

    *===========================================================================
    * TxtCgrusKeyPress - F4 abre busca de grupo
    * PUBLIC: BINDEVENT requer metodo publico
    * KeyDown nao e bindavel via BINDEVENT em VFP9 - usar KeyPress
    * F4 em KeyPress: par_nKeyCode = 0 (teclas de funcao nao tem ASCII)
    *===========================================================================
    PROCEDURE TxtCgrusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 0
            THIS.AbrirBuscaGrupo()
        ENDIF
    ENDPROC

    *===========================================================================
    * TxtIforsKeyPress - F4 abre busca de fornecedor
    * PUBLIC: BINDEVENT requer metodo publico
    * KeyDown nao e bindavel via BINDEVENT em VFP9 - usar KeyPress
    *===========================================================================
    PROCEDURE TxtIforsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 0
            THIS.AbrirBuscaFornecedor()
        ENDIF
    ENDPROC

    *===========================================================================
    * ValidarCgrus - LostFocus: valida cgrus e popula dgrus (SigCdGrp)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarCgrus(par_nKeyCode, par_nShiftAltCtrl)
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
    PROCEDURE ValidarSGrus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_oPg.txt_4c_DsGrus.Value = ""
    ENDPROC

    *===========================================================================
    * ValidarLinhas - LostFocus: valida linhas e popula DLinhas (SigCdLin)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarLinhas(par_nKeyCode, par_nShiftAltCtrl)
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
    PROCEDURE ValidarColecoes(par_nKeyCode, par_nShiftAltCtrl)
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
    PROCEDURE ValidarIfors(par_nKeyCode, par_nShiftAltCtrl)
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
    PROCEDURE ValidarCodCors(par_nKeyCode, par_nShiftAltCtrl)
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
    PROCEDURE ValidarCodTams(par_nKeyCode, par_nShiftAltCtrl)
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
    PROCEDURE ValidarCodAcbs(par_nKeyCode, par_nShiftAltCtrl)
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
    PROCEDURE ValidarCunis(par_nKeyCode, par_nShiftAltCtrl)
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
                loc_oBusca.this_cCursorDestino = "cursor_4c_GrpBusca"
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
                loc_oBusca.this_cCursorDestino = "cursor_4c_FornBusca"
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

    *===========================================================================
    * OptSituacaoInteractiveChange - Atualiza DtSituas ao mudar Situacao
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE OptSituacaoInteractiveChange()
        LOCAL loc_oPg, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
            IF PEMSTATUS(loc_oPg, "txt_4c_DtSituas", 5)
                loc_oPg.txt_4c_DtSituas.Value = DATE()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao atualizar data da situa" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loException.Message, "FormProduto.OptSituacaoInteractiveChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarPgpgDadosFiscais - Configura Page3 "Dados Fiscais" do pgf_4c_Dados
    * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgDadosFiscais
    * 64 objetos: labels, textboxes, editbox, combobox, optiongroup, grid, button
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais(par_oPg)
        LOCAL loc_oPg, loc_oGrid, loc_oErro
        TRY
            loc_oPg = par_oPg
            loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Cursor placeholder para grd_4c_Cmv (RecordSource = TotGrupo2)
            IF !USED("cursor_4c_TotGrupo2")
                CREATE CURSOR cursor_4c_TotGrupo2 ( ;
                    Grupo    C(3), ValGrupo N(12,3), Moeda C(3), Estimado N(1,0))
            ENDIF

            *====================================================================
            *  SECAO: Configuracao / Tipo produto (topo)
            *====================================================================

            *-- lbl_4c_Label29: "Configuracao :" (Say29, top=128, left=129)
            loc_oPg.AddObject("lbl_4c_Label29", "Label")
            WITH loc_oPg.lbl_4c_Label29
                .Caption   = "Configura" + CHR(231) + CHR(227) + "o :"
                .Top       = 128
                .Left      = 129
                .Width     = 73
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- obj_4c_Fwoption1: OptionGroup "Importado / Nacional" (Fwoption1, top=123, left=204)
            *-- ControlSource: TpCodPro (nao existe no schema atual - UI-only)
            loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
            WITH loc_oPg.obj_4c_Fwoption1
                .ButtonCount  = 2
                .Top          = 123
                .Left         = 204
                .Width        = 151
                .Height       = 24
                .BackStyle    = 0
                .BorderStyle  = 0
                .Value        = 1
                .AutoSize     = .F.
                .Visible      = .T.

                .Buttons(1).Caption   = "Importado"
                .Buttons(1).FontName  = "Tahoma"
                .Buttons(1).FontSize  = 8
                .Buttons(1).ForeColor = RGB(90, 90, 90)
                .Buttons(1).BackStyle = 0
                .Buttons(1).Left      = 5
                .Buttons(1).Top       = 5
                .Buttons(1).Height    = 15
                .Buttons(1).AutoSize  = .T.

                .Buttons(2).Caption   = "Nacional"
                .Buttons(2).FontName  = "Tahoma"
                .Buttons(2).FontSize  = 8
                .Buttons(2).ForeColor = RGB(90, 90, 90)
                .Buttons(2).BackStyle = 0
                .Buttons(2).Left      = 86
                .Buttons(2).Top       = 5
                .Buttons(2).Height    = 15
                .Buttons(2).AutoSize  = .T.
            ENDWITH

            *====================================================================
            *  SECAO: Codigo Importado / Nacional / DCR
            *====================================================================

            *-- lbl_4c_Label14: "Codigo Importado :" (Say14, top=154, left=107)
            loc_oPg.AddObject("lbl_4c_Label14", "Label")
            WITH loc_oPg.lbl_4c_Label14
                .Caption   = "C" + CHR(243) + "digo Importado :"
                .Top       = 154
                .Left      = 107
                .Width     = 95
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c__CodImpPro: Codigo Importado (get_CodImpPro, top=150, left=206)
            loc_oPg.AddObject("txt_4c__CodImpPro", "TextBox")
            WITH loc_oPg.txt_4c__CodImpPro
                .Top           = 150
                .Left          = 206
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            *-- txt_4c__DCodImpPro: Descricao Codigo Importado (get_DCodImpPro, top=150, left=288)
            loc_oPg.AddObject("txt_4c__DCodImpPro", "TextBox")
            WITH loc_oPg.txt_4c__DCodImpPro
                .Top           = 150
                .Left          = 288
                .Width         = 318
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Label19: "Codigo Nacional :" (Say19, top=178, left=117)
            loc_oPg.AddObject("lbl_4c_Label19", "Label")
            WITH loc_oPg.lbl_4c_Label19
                .Caption   = "C" + CHR(243) + "digo Nacional :"
                .Top       = 178
                .Left      = 117
                .Width     = 85
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c__codnacpro: Codigo Nacional (get_codnacpro, top=175, left=206)
            loc_oPg.AddObject("txt_4c__codnacpro", "TextBox")
            WITH loc_oPg.txt_4c__codnacpro
                .Top           = 175
                .Left          = 206
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            *-- txt_4c__dcodnacpro: Descricao Codigo Nacional (get_dcodnacpro, top=175, left=288)
            loc_oPg.AddObject("txt_4c__dcodnacpro", "TextBox")
            WITH loc_oPg.txt_4c__dcodnacpro
                .Top           = 175
                .Left          = 288
                .Width         = 318
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Label20: "Codigo DCR :" (Say20, top=203, left=136)
            loc_oPg.AddObject("lbl_4c_Label20", "Label")
            WITH loc_oPg.lbl_4c_Label20
                .Caption   = "C" + CHR(243) + "digo DCR :"
                .Top       = 203
                .Left      = 136
                .Width     = 66
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c__coddcr: Codigo DCR (get_coddcr, top=200, left=206)
            loc_oPg.AddObject("txt_4c__coddcr", "TextBox")
            WITH loc_oPg.txt_4c__coddcr
                .Top           = 200
                .Left          = 206
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            *====================================================================
            *  SECAO: Centro de Custo (gruccus / contaccus)
            *====================================================================

            *-- lbl_4c_Label16: "Grupo C.C. :" (Say16, top=229, left=139)
            loc_oPg.AddObject("lbl_4c_Label16", "Label")
            WITH loc_oPg.lbl_4c_Label16
                .Caption   = "Grupo C.C. :"
                .Top       = 229
                .Left      = 139
                .Width     = 63
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c__gruccus: Grupo CC (get_gruccus, top=225, left=206)
            loc_oPg.AddObject("txt_4c__gruccus", "TextBox")
            WITH loc_oPg.txt_4c__gruccus
                .Top           = 225
                .Left          = 206
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c__gruccus, "LostFocus",    THIS, "TxtGruccusValid")
            BINDEVENT(loc_oPg.txt_4c__gruccus, "KeyPress", THIS, "TxtGruccusKeyPress")

            *-- txt_4c__dgruccus: Descricao Grupo CC (get_dgruccus, top=225, left=288)
            loc_oPg.AddObject("txt_4c__dgruccus", "TextBox")
            WITH loc_oPg.txt_4c__dgruccus
                .Top           = 225
                .Left          = 288
                .Width         = 318
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c__dgruccus, "When",    THIS, "TxtDgruccusWhen")
            BINDEVENT(loc_oPg.txt_4c__dgruccus, "LostFocus",   THIS, "TxtDgruccusValid")
            BINDEVENT(loc_oPg.txt_4c__dgruccus, "KeyPress",THIS, "TxtDgruccusKeyPress")

            *-- lbl_4c_Label17: "Conta C.C. :" (Say17, top=253, left=139)
            loc_oPg.AddObject("lbl_4c_Label17", "Label")
            WITH loc_oPg.lbl_4c_Label17
                .Caption   = "Conta C.C. :"
                .Top       = 253
                .Left      = 139
                .Width     = 63
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c__contaccus: Conta CC (get_contaccus, top=250, left=206)
            loc_oPg.AddObject("txt_4c__contaccus", "TextBox")
            WITH loc_oPg.txt_4c__contaccus
                .Top           = 250
                .Left          = 206
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c__contaccus, "When",    THIS, "TxtContaccusWhen")
            BINDEVENT(loc_oPg.txt_4c__contaccus, "LostFocus",   THIS, "TxtContaccusValid")
            BINDEVENT(loc_oPg.txt_4c__contaccus, "KeyPress",THIS, "TxtContaccusKeyPress")

            *-- txt_4c__dcontaccus: Descricao Conta CC (get_dcontaccus, top=250, left=288)
            loc_oPg.AddObject("txt_4c__dcontaccus", "TextBox")
            WITH loc_oPg.txt_4c__dcontaccus
                .Top           = 250
                .Left          = 288
                .Width         = 318
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c__dcontaccus, "When",    THIS, "TxtDcontaccusWhen")
            BINDEVENT(loc_oPg.txt_4c__dcontaccus, "LostFocus",   THIS, "TxtDcontaccusValid")
            BINDEVENT(loc_oPg.txt_4c__dcontaccus, "KeyPress",THIS, "TxtDcontaccusKeyPress")

            *====================================================================
            *  SECAO: Classificacao Fiscal / Origem Mercadoria / ICMS
            *====================================================================

            *-- lbl_4c_Label1: "Classificacao Fiscal :" (Say1, top=280, left=103)
            loc_oPg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPg.lbl_4c_Label1
                .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"
                .Top       = 280
                .Left      = 103
                .Width     = 99
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Clfiscal: Classificacao Fiscal (getClfiscal, top=275, left=206)
            loc_oPg.AddObject("txt_4c_Clfiscal", "TextBox")
            WITH loc_oPg.txt_4c_Clfiscal
                .Top           = 275
                .Left          = 206
                .Width         = 94
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .MaxLength     = 10
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress",    THIS, "ValidarClfiscal")
            BINDEVENT(loc_oPg.txt_4c_Clfiscal, "KeyPress", THIS, "TxtClfiscalKeyPress")

            *-- txt_4c_Dclfiscal: Descricao Classificacao Fiscal (getDclfiscal, top=275, left=303)
            loc_oPg.AddObject("txt_4c_Dclfiscal", "TextBox")
            WITH loc_oPg.txt_4c_Dclfiscal
                .Top           = 275
                .Left          = 303
                .Width         = 303
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "When",    THIS, "TxtDclfiscalWhen")
            BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress",   THIS, "ValidarDclfiscal")
            BINDEVENT(loc_oPg.txt_4c_Dclfiscal, "KeyPress",THIS, "TxtDclfiscalKeyPress")

            *-- lbl_4c_Label2: "Origem da Mercadoria :" (Say2, top=305, left=88)
            loc_oPg.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPg.lbl_4c_Label2
                .Caption   = "Origem da Mercadoria :"
                .Top       = 305
                .Left      = 88
                .Width     = 114
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Origmerc: Origem Mercadoria (getOrigmerc, top=300, left=206)
            loc_oPg.AddObject("txt_4c_Origmerc", "TextBox")
            WITH loc_oPg.txt_4c_Origmerc
                .Top           = 300
                .Left          = 206
                .Width         = 17
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .MaxLength     = 1
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Origmerc, "KeyPress",    THIS, "ValidarOrigmerc")
            BINDEVENT(loc_oPg.txt_4c_Origmerc, "KeyPress", THIS, "TxtOrigmercKeyPress")

            *-- txt_4c_Dorigmerc: Descricao Origem (getDorigmerc, top=300, left=226)
            loc_oPg.AddObject("txt_4c_Dorigmerc", "TextBox")
            WITH loc_oPg.txt_4c_Dorigmerc
                .Top           = 300
                .Left          = 226
                .Width         = 380
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "When",    THIS, "TxtDorigmercWhen")
            BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress",   THIS, "ValidarDorigmerc")
            BINDEVENT(loc_oPg.txt_4c_Dorigmerc, "KeyPress",THIS, "TxtDorigmercKeyPress")

            *-- lbl_4c_Label3: "Situacao Tributaria ICMS :" (Say3, top=330, left=75)
            loc_oPg.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPg.lbl_4c_Label3
                .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS :"
                .Top       = 330
                .Left      = 75
                .Width     = 127
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Sittricm: Situacao Tributaria ICMS (getSittricm, top=325, left=206)
            loc_oPg.AddObject("txt_4c_Sittricm", "TextBox")
            WITH loc_oPg.txt_4c_Sittricm
                .Top           = 325
                .Left          = 206
                .Width         = 31
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .MaxLength     = 3
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Sittricm, "KeyPress",    THIS, "ValidarSittricm")
            BINDEVENT(loc_oPg.txt_4c_Sittricm, "KeyPress", THIS, "TxtSittricmKeyPress")

            *-- txt_4c_Dsittricm: Descricao Situacao ICMS (getDsittricm, top=325, left=240)
            loc_oPg.AddObject("txt_4c_Dsittricm", "TextBox")
            WITH loc_oPg.txt_4c_Dsittricm
                .Top           = 325
                .Left          = 240
                .Width         = 366
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Dsittricm, "When",    THIS, "TxtDsittricmWhen")
            BINDEVENT(loc_oPg.txt_4c_Dsittricm, "KeyPress",   THIS, "ValidarDsittricm")
            BINDEVENT(loc_oPg.txt_4c_Dsittricm, "KeyPress",THIS, "TxtDsittricmKeyPress")

            *-- lbl_4c_Label6: "Codigo de Servicos para ICMS :" (Say6, top=355, left=49)
            loc_oPg.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPg.lbl_4c_Label6
                .Caption   = "C" + CHR(243) + "digo de Servi" + CHR(231) + "os para ICMS :"
                .Top       = 355
                .Left      = 49
                .Width     = 153
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Codigo: Codigo Servicos (Get_CodServs, top=350, left=206)
            loc_oPg.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPg.txt_4c_Codigo
                .Top           = 350
                .Left          = 206
                .Width         = 38
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .MaxLength     = 4
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Codigo, "KeyPress",    THIS, "ValidarCodServsFiscal")
            BINDEVENT(loc_oPg.txt_4c_Codigo, "KeyPress", THIS, "TxtCodServsFiscalKeyPress")

            *-- lbl_4c_Label8: "Aliquota ICMS :" (Say8, top=355, left=263)
            loc_oPg.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oPg.lbl_4c_Label8
                .Caption   = "Al" + CHR(237) + "quota ICMS :"
                .Top       = 355
                .Left      = 263
                .Width     = 76
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Icms: Aliquota ICMS (getIcms, top=350, left=342)
            loc_oPg.AddObject("txt_4c_Icms", "TextBox")
            WITH loc_oPg.txt_4c_Icms
                .Top           = 350
                .Left          = 342
                .Width         = 45
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .InputMask     = "99.99"
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Label4: "Tipo de Tributacao :" (Say4, top=355, left=411)
            loc_oPg.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPg.lbl_4c_Label4
                .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
                .Top       = 355
                .Left      = 411
                .Width     = 98
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_TpTrib: Tipo Tributacao (Get_TpTrib, top=350, left=513)
            loc_oPg.AddObject("txt_4c_TpTrib", "TextBox")
            WITH loc_oPg.txt_4c_TpTrib
                .Top           = 350
                .Left          = 513
                .Width         = 38
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .MaxLength     = 4
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_TpTrib, "KeyPress",    THIS, "ValidarTpTrib")
            BINDEVENT(loc_oPg.txt_4c_TpTrib, "KeyPress", THIS, "TxtTpTribKeyPress")

            *-- lbl_4c_Label41: "IAT :" (Say41, top=354, left=558)
            loc_oPg.AddObject("lbl_4c_Label41", "Label")
            WITH loc_oPg.lbl_4c_Label41
                .Caption   = "IAT :"
                .Top       = 354
                .Left      = 558
                .Width     = 26
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Iat: IAT - Indicador Arredondamento/Truncamento (getiat, top=350, left=589)
            loc_oPg.AddObject("txt_4c_Iat", "TextBox")
            WITH loc_oPg.txt_4c_Iat
                .Top           = 350
                .Left          = 589
                .Width         = 17
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .MaxLength     = 1
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Iat, "KeyPress",    THIS, "ValidarIat")
            BINDEVENT(loc_oPg.txt_4c_Iat, "KeyPress", THIS, "TxtIatKeyPress")

            *-- lbl_4c_Label42: "[A]rredondamento [T]runcamento" (Say42, top=354, left=609)
            loc_oPg.AddObject("lbl_4c_Label42", "Label")
            WITH loc_oPg.lbl_4c_Label42
                .Caption   = "[A]rredondamento [T]runcamento"
                .Top       = 354
                .Left      = 609
                .Width     = 165
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *====================================================================
            *  SECAO: IPI (Situacao Tributaria / Aliquota / Excecao TIPI)
            *====================================================================

            *-- lbl_4c_Label5: "Situacao Tributaria IPI :" (Say5, top=380, left=86)
            loc_oPg.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPg.lbl_4c_Label5
                .Caption   = "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria IPI :"
                .Top       = 380
                .Left      = 86
                .Width     = 116
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- cbo_4c_CmbIpi: Situacao Tributaria IPI combo (cmbIpi, top=375, left=206)
            *-- Itens: "", "Tributado" (T), "Isento" (I), "Outros" (O)
            loc_oPg.AddObject("cbo_4c_CmbIpi", "ComboBox")
            WITH loc_oPg.cbo_4c_CmbIpi
                .Top           = 375
                .Left          = 206
                .Width         = 108
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Style         = 2
                .Visible       = .T.
            ENDWITH
            loc_oPg.cbo_4c_CmbIpi.Clear()
            loc_oPg.cbo_4c_CmbIpi.AddItem(PADR("", 10))
            loc_oPg.cbo_4c_CmbIpi.AddItem("\<" + PADR("Tributado", 9))
            loc_oPg.cbo_4c_CmbIpi.AddItem("\<" + PADR("Isento", 9))
            loc_oPg.cbo_4c_CmbIpi.AddItem("\<" + PADR("Outros", 9))
            BINDEVENT(loc_oPg.cbo_4c_CmbIpi, "When", THIS, "CboIpiWhen")

            *-- lbl_4c__AliqIPI: "Aliquota de IPI :" (Say_AliqIPI, top=380, left=340)
            loc_oPg.AddObject("lbl_4c__AliqIPI", "Label")
            WITH loc_oPg.lbl_4c__AliqIPI
                .Caption   = "Al" + CHR(237) + "quota de IPI :"
                .Top       = 380
                .Left      = 340
                .Width     = 80
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_AliqIPI: Aliquota IPI (Get_AliqIPI, top=375, left=425)
            loc_oPg.AddObject("txt_4c_AliqIPI", "TextBox")
            WITH loc_oPg.txt_4c_AliqIPI
                .Top           = 375
                .Left          = 425
                .Width         = 45
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .InputMask     = "99.99"
                .Value         = 0
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_AliqIPI, "KeyPress",    THIS, "ValidarAliqIPI")
            BINDEVENT(loc_oPg.txt_4c_AliqIPI, "KeyPress", THIS, "TxtAliqIPIKeyPress")

            *-- lbl_4c_Label13: "Excecao da TIPI :" (Say13, top=380, left=511)
            loc_oPg.AddObject("lbl_4c_Label13", "Label")
            WITH loc_oPg.lbl_4c_Label13
                .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
                .Top       = 380
                .Left      = 511
                .Width     = 87
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Extipi: Excecao TIPI (getextipi, top=375, left=601)
            *-- When: enabled only when SigCdClf.IpiProds = 'S'
            loc_oPg.AddObject("txt_4c_Extipi", "TextBox")
            WITH loc_oPg.txt_4c_Extipi
                .Top           = 375
                .Left          = 601
                .Width         = 35
                .Height        = 25
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .MaxLength     = 3
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Extipi, "When", THIS, "TxtExtipipWhen")

            *====================================================================
            *  SECAO: Descricao Fiscal (memo) + Botao gerar descricao
            *====================================================================

            *-- lbl_4c_Label18: "Descricao Fiscal :" (Say18, top=405, left=118)
            loc_oPg.AddObject("lbl_4c_Label18", "Label")
            WITH loc_oPg.lbl_4c_Label18
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
                .Top       = 405
                .Left      = 118
                .Width     = 84
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- obj_4c_Mgetdescfi: Descricao Fiscal editbox/memo (mgetdescfi, top=402, left=206)
            loc_oPg.AddObject("obj_4c_Mgetdescfi", "EditBox")
            WITH loc_oPg.obj_4c_Mgetdescfi
                .Top           = 402
                .Left          = 206
                .Width         = 509
                .Height        = 89
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ScrollBars    = 2
                .Visible       = .T.
            ENDWITH

            *-- cmd_4c_BtnDescFis: Botao gerar descricao fiscal (btnDescFis, top=423, left=162)
            loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
            WITH loc_oPg.cmd_4c_BtnDescFis
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
                .PicturePosition = 0
                .Top             = 423
                .Left            = 162
                .Width           = 32
                .Height          = 32
                .ToolTipText     = "Gerar Descri" + CHR(231) + CHR(227) + "o Fiscal"
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_BtnDescFis, "Click", THIS, "CmdBtnDescFisClick")

            *====================================================================
            *  SECAO: Valor Grama / Grid CMV (Custo Medio Vendido)
            *====================================================================

            *-- lbl_4c_Label9: "Valor do Grama Produzido" (Say9, top=384, left=756)
            loc_oPg.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPg.lbl_4c_Label9
                .Caption   = "Valor do Grama Produzido"
                .Top       = 384
                .Left      = 756
                .Width     = 125
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- grd_4c_Cmv: Grid Custo Medio Vendido (grdCmv, top=402, left=754, 3 colunas)
            *-- ReadOnly: todos os When retornam .F. (grid somente leitura)
            loc_oPg.AddObject("grd_4c_Cmv", "Grid")
            WITH loc_oPg.grd_4c_Cmv
                .Top        = 402
                .Left       = 754
                .Width      = 223
                .Height     = 141
                .FontName   = "Courier New"
                .FontSize   = 8
                .RecordMark = .T.
                .RowHeight  = 17
                .DeleteMark = .F.
                .ReadOnly   = .T.
                .Visible    = .T.
            ENDWITH
            loc_oPg.grd_4c_Cmv.ColumnCount  = 3
            loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_TotGrupo2"
            loc_oGrid = loc_oPg.grd_4c_Cmv

            loc_oGrid.Column1.ControlSource   = "cursor_4c_TotGrupo2.Grupo"
            loc_oGrid.Column1.Width           = 59
            loc_oGrid.Column1.Movable         = .F.
            loc_oGrid.Column1.Resizable       = .F.
            loc_oGrid.Column1.ReadOnly        = .T.
            loc_oGrid.Column1.FontName        = "Courier New"
            loc_oGrid.Column1.FontSize        = 8
            loc_oGrid.Column1.Header1.Caption = "Per" + CHR(237) + "odo"

            loc_oGrid.Column2.ControlSource   = "cursor_4c_TotGrupo2.ValGrupo"
            loc_oGrid.Column2.Width           = 100
            loc_oGrid.Column2.Movable         = .F.
            loc_oGrid.Column2.Resizable       = .F.
            loc_oGrid.Column2.ReadOnly        = .T.
            loc_oGrid.Column2.InputMask       = "999,999,999.999"
            loc_oGrid.Column2.FontName        = "Courier New"
            loc_oGrid.Column2.FontSize        = 8
            loc_oGrid.Column2.Header1.Caption = "Valor Custo GR"

            loc_oGrid.Column3.ControlSource   = "cursor_4c_TotGrupo2.Moeda"
            loc_oGrid.Column3.Width           = 31
            loc_oGrid.Column3.ReadOnly        = .T.
            loc_oGrid.Column3.Header1.Caption = "Moe"

            *====================================================================
            *  SECAO: Descricao ECF / Metal / Teor
            *====================================================================

            *-- lbl_4c_Label12: "Descricao ECF :" (Say12, top=497, left=125)
            loc_oPg.AddObject("lbl_4c_Label12", "Label")
            WITH loc_oPg.lbl_4c_Label12
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
                .Top       = 497
                .Left      = 125
                .Width     = 77
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_DescEcfs: Descricao ECF (getDescEcfs, top=493, left=206)
            loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
            WITH loc_oPg.txt_4c_DescEcfs
                .Top           = 493
                .Left          = 206
                .Width         = 213
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .MaxLength     = 29
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Label11: "Metal :" (Say11, top=497, left=498)
            loc_oPg.AddObject("lbl_4c_Label11", "Label")
            WITH loc_oPg.lbl_4c_Label11
                .Caption   = "Metal :"
                .Top       = 497
                .Left      = 498
                .Width     = 35
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Metal: Codigo Metal (Get_metal, top=493, left=537)
            loc_oPg.AddObject("txt_4c_Metal", "TextBox")
            WITH loc_oPg.txt_4c_Metal
                .Top           = 493
                .Left          = 537
                .Width         = 24
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .MaxLength     = 2
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress",    THIS, "ValidarMetal")
            BINDEVENT(loc_oPg.txt_4c_Metal, "KeyPress", THIS, "TxtMetalKeyPress")

            *-- txt_4c_DesMetal: Descricao Metal (Get_DesMetal, top=493, left=564)
            loc_oPg.AddObject("txt_4c_DesMetal", "TextBox")
            WITH loc_oPg.txt_4c_DesMetal
                .Top           = 493
                .Left          = 564
                .Width         = 150
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Label15: "Teor :" (Say15, top=522, left=502)
            loc_oPg.AddObject("lbl_4c_Label15", "Label")
            WITH loc_oPg.lbl_4c_Label15
                .Caption   = "Teor :"
                .Top       = 522
                .Left      = 502
                .Width     = 31
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Teor: Codigo Teor (Get_teor, top=518, left=537)
            loc_oPg.AddObject("txt_4c_Teor", "TextBox")
            WITH loc_oPg.txt_4c_Teor
                .Top           = 518
                .Left          = 537
                .Width         = 24
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .MaxLength     = 2
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress",    THIS, "ValidarTeor")
            BINDEVENT(loc_oPg.txt_4c_Teor, "KeyPress", THIS, "TxtTeorKeyPress")

            *-- txt_4c_DesTeor: Descricao Teor (Get_DesTeor, top=518, left=564)
            loc_oPg.AddObject("txt_4c_DesTeor", "TextBox")
            WITH loc_oPg.txt_4c_DesTeor
                .Top           = 518
                .Left          = 564
                .Width         = 150
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

            *====================================================================
            *  SECAO: Valor Estimado / Moeda / IPPT/CST
            *====================================================================

            *-- lbl_4c_Label7: "Valor Estimado :" (Say7, top=522, left=123)
            loc_oPg.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPg.lbl_4c_Label7
                .Caption   = "Valor Estimado :"
                .Top       = 522
                .Left      = 123
                .Width     = 79
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Valor: Valor Estimado (getValor, top=518, left=206)
            loc_oPg.AddObject("txt_4c_Valor", "TextBox")
            WITH loc_oPg.txt_4c_Valor
                .Top           = 518
                .Left          = 206
                .Width         = 108
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .InputMask     = "999,999,999.99"
                .Value         = 0
                .MaxLength     = 14
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_Mvalor: Moeda do Valor Estimado (GetMvalor, top=518, left=317)
            loc_oPg.AddObject("txt_4c_Mvalor", "TextBox")
            WITH loc_oPg.txt_4c_Mvalor
                .Top           = 518
                .Left          = 317
                .Width         = 31
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .MaxLength     = 3
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Mvalor, "KeyPress",    THIS, "ValidarMvalorFiscal")
            BINDEVENT(loc_oPg.txt_4c_Mvalor, "KeyPress", THIS, "TxtMvalorFiscalKeyPress")

            *-- lbl_4c_Label10: "IPPT/CST :" (Say10, top=547, left=148)
            loc_oPg.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oPg.lbl_4c_Label10
                .Caption   = "IPPT/CST :"
                .Top       = 547
                .Left      = 148
                .Width     = 54
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_IPPTCST: IPPT/CST (getIPPTCST, top=543, left=206)
            *-- ReadOnly: When retorna .F. no legado
            loc_oPg.AddObject("txt_4c_IPPTCST", "TextBox")
            WITH loc_oPg.txt_4c_IPPTCST
                .Top           = 543
                .Left          = 206
                .Width         = 108
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Visible       = .T.
            ENDWITH

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar p" + CHR(225) + "gina Dados Fiscais:" + ;
                CHR(13) + loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormProduto.ConfigurarPgpgDadosFiscais")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarPgpgCusto - Configura Page2 "Custos" do pgf_4c_Dados
    * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgCusto
    * grdCompo(12 colunas) + cmdgCompo(2 botoes) + cmbTipos + GradeGRUPO2(3 colunas)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgCusto(par_oPg)
        LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oErro
        TRY
            loc_oPg = par_oPg

            *-- Cursors placeholder para os grids (ANTES de RecordSource)
            *-- Reutiliza cursor_4c_GrdCompo e TotGrupo criados por pgComposicao se existirem
            IF !USED("cursor_4c_GrdCompo")
                CREATE CURSOR cursor_4c_GrdCompo ( ;
                    cpros    C(14), dpros    C(65),  cunis  C(5),  ;
                    valor    N(14,3), qtdes  N(10,3), total N(14,3), ;
                    moeda    C(3),  obs      C(80),  estoc  C(1),   ;
                    consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
                    ords     N(5,0), matprinc C(14))
            ENDIF
            IF !USED("TotGrupo")
                CREATE CURSOR TotGrupo (Grupo C(10), ValGrupo N(14,3), Moeda C(3))
            ENDIF

            *-- lbl_4c_Label1: "Tipo :" (Say1, top=159, left=107)
            loc_oPg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPg.lbl_4c_Label1
                .Caption   = "Tipo :"
                .Top       = 159
                .Left      = 107
                .Width     = 29
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- cbo_4c_CmbTipos: combo de tipos de composicao (cmbTipos, top=154, left=143)
            loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
            WITH loc_oPg.cbo_4c_CmbTipos
                .Top           = 154
                .Left          = 143
                .Width         = 187
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Style         = 2
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cbo_4c_CmbTipos, "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")

            *-- grd_4c_GrdCusto: grade principal de custo (grdCompo, top=178, left=34, 12 colunas)
            loc_oPg.AddObject("grd_4c_GrdCusto", "Grid")
            WITH loc_oPg.grd_4c_GrdCusto
                .Top        = 178
                .Left       = 34
                .Width      = 813
                .Height     = 230
                .FontName   = "Tahoma"
                .FontSize   = 8
                .RecordMark = .F.
                .RowHeight  = 16
                .ScrollBars = 2
                .DeleteMark = .F.
                .Visible    = .T.
            ENDWITH
            loc_oPg.grd_4c_GrdCusto.ColumnCount  = 12
            loc_oPg.grd_4c_GrdCusto.RecordSource = "cursor_4c_GrdCompo"
            loc_oGrid = loc_oPg.grd_4c_GrdCusto

            loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdCompo.cpros"
            loc_oGrid.Column1.Width           = 90
            loc_oGrid.Column1.ColumnOrder     = 1
            loc_oGrid.Column1.Movable         = .F.
            loc_oGrid.Column1.Resizable       = .F.
            loc_oGrid.Column1.Header1.Caption = "Item"

            loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdCompo.dpros"
            loc_oGrid.Column2.Width           = 175
            loc_oGrid.Column2.ColumnOrder     = 2
            loc_oGrid.Column2.Movable         = .F.
            loc_oGrid.Column2.Resizable       = .F.
            loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdCompo.cunis"
            loc_oGrid.Column3.Width           = 30
            loc_oGrid.Column3.ColumnOrder     = 3
            loc_oGrid.Column3.Movable         = .F.
            loc_oGrid.Column3.Resizable       = .F.
            loc_oGrid.Column3.Header1.Caption = "Un"

            loc_oGrid.Column4.ControlSource   = "cursor_4c_GrdCompo.valor"
            loc_oGrid.Column4.Width           = 75
            loc_oGrid.Column4.ColumnOrder     = 4
            loc_oGrid.Column4.Movable         = .F.
            loc_oGrid.Column4.Resizable       = .F.
            loc_oGrid.Column4.InputMask       = "9999999.999"
            loc_oGrid.Column4.Header1.Caption = "Valor"

            loc_oGrid.Column5.ControlSource   = "cursor_4c_GrdCompo.qtdes"
            loc_oGrid.Column5.Width           = 55
            loc_oGrid.Column5.ColumnOrder     = 5
            loc_oGrid.Column5.Movable         = .F.
            loc_oGrid.Column5.Resizable       = .F.
            loc_oGrid.Column5.InputMask       = "9999.999"
            loc_oGrid.Column5.Header1.Caption = "Qtd"

            loc_oGrid.Column6.ControlSource   = "cursor_4c_GrdCompo.total"
            loc_oGrid.Column6.Width           = 75
            loc_oGrid.Column6.ColumnOrder     = 6
            loc_oGrid.Column6.Movable         = .F.
            loc_oGrid.Column6.Resizable       = .F.
            loc_oGrid.Column6.InputMask       = "9999999.999"
            loc_oGrid.Column6.Header1.Caption = "Total"

            loc_oGrid.Column7.ControlSource   = "cursor_4c_GrdCompo.moeda"
            loc_oGrid.Column7.Width           = 30
            loc_oGrid.Column7.ColumnOrder     = 7
            loc_oGrid.Column7.Header1.Caption = "Moe"

            loc_oGrid.Column8.ControlSource   = "cursor_4c_GrdCompo.obs"
            loc_oGrid.Column8.Width           = 100
            loc_oGrid.Column8.ColumnOrder     = 8
            loc_oGrid.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"

            loc_oGrid.Column9.ControlSource   = "cursor_4c_GrdCompo.estoc"
            loc_oGrid.Column9.Width           = 25
            loc_oGrid.Column9.ColumnOrder     = 9
            loc_oGrid.Column9.Format          = "M"
            loc_oGrid.Column9.InputMask       = "N,S"
            loc_oGrid.Column9.Header1.Caption = "Etiq"

            loc_oGrid.Column10.ControlSource   = "cursor_4c_GrdCompo.consumo"
            loc_oGrid.Column10.Width           = 55
            loc_oGrid.Column10.ColumnOrder     = 10
            loc_oGrid.Column10.InputMask       = "99999"
            loc_oGrid.Column10.Header1.Caption = "Consumo"

            loc_oGrid.Column11.ControlSource   = "cursor_4c_GrdCompo.qtdes2"
            loc_oGrid.Column11.Width           = 55
            loc_oGrid.Column11.ColumnOrder     = 11
            loc_oGrid.Column11.Movable         = .F.
            loc_oGrid.Column11.Resizable       = .F.
            loc_oGrid.Column11.Header1.Caption = "Qtd"

            loc_oGrid.Column12.ControlSource   = "cursor_4c_GrdCompo.cunis2"
            loc_oGrid.Column12.Width           = 30
            loc_oGrid.Column12.ColumnOrder     = 12
            loc_oGrid.Column12.Movable         = .F.
            loc_oGrid.Column12.Resizable       = .F.
            loc_oGrid.Column12.ReadOnly        = .T.
            loc_oGrid.Column12.Header1.Caption = "Un"

            BINDEVENT(loc_oPg.grd_4c_GrdCusto, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")

            *-- cmg_4c_CmdgCusto: 2 botoes de controle (cmdgCompo, top=240, left=851)
            loc_oPg.AddObject("cmg_4c_CmdgCusto", "CommandGroup")
            WITH loc_oPg.cmg_4c_CmdgCusto
                .Top         = 240
                .Left        = 851
                .Width       = 50
                .Height      = 90
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .BackColor   = RGB(162, 214, 242)
                .ButtonCount = 2
                .Visible     = .T.
            ENDWITH
            WITH loc_oPg.cmg_4c_CmdgCusto
                .Command1.Top          = 5
                .Command1.Left         = 5
                .Command1.Height       = 40
                .Command1.Width        = 40
                .Command1.Caption      = ""
                .Command1.Picture      = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Command1.ToolTipText  = "Inserir Item"
                .Command1.Style        = 0
                .Command1.SpecialEffect = 0
                .Command1.BackColor    = RGB(255, 255, 255)
                .Command2.Top          = 45
                .Command2.Left         = 5
                .Command2.Height       = 40
                .Command2.Width        = 40
                .Command2.Caption      = ""
                .Command2.Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Command2.ToolTipText  = "Excluir Item"
                .Command2.Style        = 0
                .Command2.SpecialEffect = 0
                .Command2.BackColor    = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(loc_oPg.cmg_4c_CmdgCusto, "Click", THIS, "CmgCustoClick")

            *-- lbl_4c_Label16: "Descricao :" (Say16, top=415, left=53)
            loc_oPg.AddObject("lbl_4c_Label16", "Label")
            WITH loc_oPg.lbl_4c_Label16
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .Top       = 415
                .Left      = 53
                .Width     = 55
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Desc: descricao do material (Get_Desc, top=412, left=116, readonly)
            loc_oPg.AddObject("txt_4c_Desc", "TextBox")
            WITH loc_oPg.txt_4c_Desc
                .Top           = 412
                .Left          = 116
                .Width         = 304
                .Height        = 21
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .BackColor     = RGB(240, 240, 240)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Label2: "Grupo :" (Say2, top=415, left=480)
            loc_oPg.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPg.lbl_4c_Label2
                .Caption   = "Grupo :"
                .Top       = 415
                .Left      = 480
                .Width     = 38
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_DGruCompos: descricao do grupo (getDGruCompos, top=412, left=522, readonly)
            loc_oPg.AddObject("txt_4c_DGruCompos", "TextBox")
            WITH loc_oPg.txt_4c_DGruCompos
                .Top           = 412
                .Left          = 522
                .Width         = 304
                .Height        = 21
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .BackColor     = RGB(240, 240, 240)
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Label3: "Resumo por Grupo" (Say3, top=445, left=35)
            loc_oPg.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPg.lbl_4c_Label3
                .Caption   = "Resumo por Grupo"
                .Top       = 445
                .Left      = 35
                .Width     = 107
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- shp_4c_Shape2: separador (Shape2, top=460, left=35, width=158, height=2)
            loc_oPg.AddObject("shp_4c_Shape2", "Shape")
            WITH loc_oPg.shp_4c_Shape2
                .Top         = 460
                .Left        = 35
                .Width       = 158
                .Height      = 2
                .BorderWidth = 1
                .BackStyle   = 1
                .Visible     = .T.
            ENDWITH

            *-- grd_4c_GradeGrupo2: grade de resumo por grupo (GradeGRUPO2, top=468, left=35)
            loc_oPg.AddObject("grd_4c_GradeGrupo2", "Grid")
            WITH loc_oPg.grd_4c_GradeGrupo2
                .Top          = 468
                .Left         = 35
                .Width        = 195
                .Height       = 141
                .FontName     = "Verdana"
                .FontSize     = 8
                .DeleteMark   = .F.
                .HeaderHeight = 14
                .ReadOnly     = .T.
                .RecordMark   = .F.
                .RowHeight    = 16
                .Visible      = .T.
            ENDWITH
            loc_oPg.grd_4c_GradeGrupo2.ColumnCount  = 3
            loc_oPg.grd_4c_GradeGrupo2.RecordSource = "TotGrupo"
            loc_oGrid2 = loc_oPg.grd_4c_GradeGrupo2

            loc_oGrid2.Column1.ControlSource   = "TotGrupo.Grupo"
            loc_oGrid2.Column1.Width           = 35
            loc_oGrid2.Column1.Movable         = .F.
            loc_oGrid2.Column1.Resizable       = .F.
            loc_oGrid2.Column1.ReadOnly        = .T.
            loc_oGrid2.Column1.Header1.Caption = "Grp"

            loc_oGrid2.Column2.ControlSource   = "TotGrupo.ValGrupo"
            loc_oGrid2.Column2.Width           = 120
            loc_oGrid2.Column2.Movable         = .F.
            loc_oGrid2.Column2.Resizable       = .F.
            loc_oGrid2.Column2.ReadOnly        = .T.
            loc_oGrid2.Column2.InputMask       = "999,999,999.999"
            loc_oGrid2.Column2.Header1.Caption = "Total "

            loc_oGrid2.Column3.ControlSource   = "TotGrupo.Moeda"
            loc_oGrid2.Column3.Width           = 37
            loc_oGrid2.Column3.Movable         = .F.
            loc_oGrid2.Column3.Resizable       = .F.
            loc_oGrid2.Column3.ReadOnly        = .T.
            loc_oGrid2.Column3.Header1.Caption = "Moe"

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar p" + CHR(225) + "gina Custos:" + ;
                CHR(13) + loc_oErro.Message, "FormProduto.ConfigurarPgpgCusto")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarPgpgComposicao - Configura Page6 "Composicao" do pgf_4c_Dados
    * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgComposicao
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgComposicao(par_oPg)
        LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oGrid3, loc_oGradeGrupo, loc_oCnt, loc_oErro
        TRY
            loc_oPg = par_oPg

            *-- Cursors placeholder para os grids (ANTES de RecordSource)
            IF !USED("cursor_4c_GrdCompo")
                CREATE CURSOR cursor_4c_GrdCompo ( ;
                    cpros    C(14), dpros   C(65), cunis   C(5),  ;
                    valor    N(14,3), qtdes N(10,3), total  N(14,3), ;
                    moeda    C(3),  obs    C(80),  estoc   C(1),  ;
                    consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
                    ords     N(5,0), matprinc C(14))
            ENDIF
            IF !USED("cursor_4c_GrdSubCp")
                CREATE CURSOR cursor_4c_GrdSubCp ( ;
                    cpros    C(14), dpros   C(65), cunis   C(5),  ;
                    valor    N(14,3), qtdes N(10,3), total  N(14,3), ;
                    moeda    C(3),  obs    C(80),  estoc   C(1),  ;
                    consumo  N(10,0), qtdes2 N(10,3), cunis2 C(5),  ;
                    ords     N(5,0), matprinc C(14), tamanho C(10))
            ENDIF
            IF !USED("cursor_4c_GrdRelogios")
                CREATE CURSOR cursor_4c_GrdRelogios ( ;
                    grp C(5), descricao C(60), produto C(14), descprod C(60))
            ENDIF
            IF !USED("TotGrupo")
                CREATE CURSOR TotGrupo (Grupo C(10), ValGrupo N(14,3), Moeda C(3))
            ENDIF

            *-- grdCompo: grade principal de composicao (14 colunas)
            loc_oPg.AddObject("grd_4c_GrdCompo", "Grid")
            WITH loc_oPg.grd_4c_GrdCompo
                .Top        = 117
                .Left       = 6
                .Width      = 943
                .Height     = 147
                .FontName   = "Tahoma"
                .FontSize   = 8
                .RecordMark = .F.
                .RowHeight  = 16
                .ScrollBars = 2
                .TabStop    = .F.
                .Visible    = .T.
            ENDWITH
            loc_oPg.grd_4c_GrdCompo.ColumnCount  = 14
            loc_oPg.grd_4c_GrdCompo.RecordSource = "cursor_4c_GrdCompo"
            loc_oGrid = loc_oPg.grd_4c_GrdCompo

            loc_oGrid.Column1.ControlSource  = "cursor_4c_GrdCompo.cpros"
            loc_oGrid.Column1.Width          = 108
            loc_oGrid.Column1.ColumnOrder    = 1
            loc_oGrid.Column1.Movable        = .F.
            loc_oGrid.Column1.Resizable      = .F.
            loc_oGrid.Column1.Header1.Caption = "Material"

            loc_oGrid.Column2.ControlSource  = "cursor_4c_GrdCompo.dpros"
            loc_oGrid.Column2.Width          = 187
            loc_oGrid.Column2.ColumnOrder    = 2
            loc_oGrid.Column2.Movable        = .F.
            loc_oGrid.Column2.Resizable      = .F.
            loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            loc_oGrid.Column3.ControlSource  = "cursor_4c_GrdCompo.cunis"
            loc_oGrid.Column3.Width          = 24
            loc_oGrid.Column3.ColumnOrder    = 4
            loc_oGrid.Column3.Movable        = .F.
            loc_oGrid.Column3.Resizable      = .F.
            loc_oGrid.Column3.Header1.Caption = "Un"

            loc_oGrid.Column4.ControlSource  = "cursor_4c_GrdCompo.valor"
            loc_oGrid.Column4.Width          = 73
            loc_oGrid.Column4.ColumnOrder    = 7
            loc_oGrid.Column4.Movable        = .F.
            loc_oGrid.Column4.Resizable      = .F.
            loc_oGrid.Column4.InputMask      = "9999999.999"
            loc_oGrid.Column4.Header1.Caption = "Valor"

            loc_oGrid.Column5.ControlSource  = "cursor_4c_GrdCompo.qtdes"
            loc_oGrid.Column5.Width          = 59
            loc_oGrid.Column5.ColumnOrder    = 3
            loc_oGrid.Column5.Movable        = .F.
            loc_oGrid.Column5.Resizable      = .F.
            loc_oGrid.Column5.InputMask      = "9999.999"
            loc_oGrid.Column5.Header1.Caption = "Qtde."

            loc_oGrid.Column6.ControlSource  = "cursor_4c_GrdCompo.total"
            loc_oGrid.Column6.Width          = 58
            loc_oGrid.Column6.ColumnOrder    = 9
            loc_oGrid.Column6.InputMask      = "9999999.999"
            loc_oGrid.Column6.Header1.Caption = "Total"

            loc_oGrid.Column7.ControlSource  = "cursor_4c_GrdCompo.moeda"
            loc_oGrid.Column7.Width          = 31
            loc_oGrid.Column7.ColumnOrder    = 8
            loc_oGrid.Column7.Header1.Caption = "Moe"

            loc_oGrid.Column8.ControlSource  = "cursor_4c_GrdCompo.obs"
            loc_oGrid.Column8.Width          = 80
            loc_oGrid.Column8.ColumnOrder    = 10
            loc_oGrid.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"

            loc_oGrid.Column9.ControlSource  = "cursor_4c_GrdCompo.estoc"
            loc_oGrid.Column9.Width          = 14
            loc_oGrid.Column9.ColumnOrder    = 12
            loc_oGrid.Column9.Format         = "M"
            loc_oGrid.Column9.InputMask      = "N,S"
            loc_oGrid.Column9.Header1.Caption = "E"

            loc_oGrid.Column10.ControlSource  = "cursor_4c_GrdCompo.consumo"
            loc_oGrid.Column10.Width          = 58
            loc_oGrid.Column10.ColumnOrder    = 13
            loc_oGrid.Column10.InputMask      = "99999"
            loc_oGrid.Column10.Header1.Caption = "Consumo"

            loc_oGrid.Column11.ControlSource  = "cursor_4c_GrdCompo.qtdes2"
            loc_oGrid.Column11.Width          = 59
            loc_oGrid.Column11.ColumnOrder    = 5
            loc_oGrid.Column11.Movable        = .F.
            loc_oGrid.Column11.Resizable      = .F.
            loc_oGrid.Column11.Header1.Caption = "Qtde."

            loc_oGrid.Column12.ControlSource  = "cursor_4c_GrdCompo.cunis2"
            loc_oGrid.Column12.Width          = 24
            loc_oGrid.Column12.ColumnOrder    = 6
            loc_oGrid.Column12.Movable        = .F.
            loc_oGrid.Column12.ReadOnly       = .T.
            loc_oGrid.Column12.Header1.Caption = "Un"

            loc_oGrid.Column13.ControlSource  = "cursor_4c_GrdCompo.ords"
            loc_oGrid.Column13.Width          = 24
            loc_oGrid.Column13.ColumnOrder    = 14
            loc_oGrid.Column13.Format         = "K"
            loc_oGrid.Column13.InputMask      = "99"
            loc_oGrid.Column13.Header1.Caption = "Ord"

            loc_oGrid.Column14.ControlSource  = "cursor_4c_GrdCompo.matprinc"
            loc_oGrid.Column14.Width          = 108
            loc_oGrid.Column14.ColumnOrder    = 11
            loc_oGrid.Column14.Header1.Caption = "Material"

            *-- cmg_4c_CmdgCompo: 5 botoes de controle da composicao
            loc_oPg.AddObject("cmg_4c_CmdgCompo", "CommandGroup")
            WITH loc_oPg.cmg_4c_CmdgCompo
                .Top         = 114
                .Left        = 947
                .Width       = 50
                .Height      = 210
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .BackColor   = RGB(162, 214, 242)
                .ButtonCount = 5
                .Visible     = .T.
            ENDWITH
            WITH loc_oPg.cmg_4c_CmdgCompo
                .Command1.Top     = 5
                .Command1.Left    = 5
                .Command1.Height  = 40
                .Command1.Width   = 40
                .Command1.Caption = ""
                .Command1.Picture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Command1.ToolTipText = "Inserir Item"
                .Command1.Style   = 0
                .Command1.SpecialEffect = 0
                .Command1.BackColor = RGB(255, 255, 255)
                .Command2.Top     = 45
                .Command2.Left    = 5
                .Command2.Height  = 40
                .Command2.Width   = 40
                .Command2.Caption = ""
                .Command2.Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Command2.ToolTipText = "Excluir Item"
                .Command2.Style   = 0
                .Command2.SpecialEffect = 0
                .Command2.BackColor = RGB(255, 255, 255)
                .Command3.Top     = 85
                .Command3.Left    = 5
                .Command3.Height  = 40
                .Command3.Width   = 40
                .Command3.Caption = ""
                .Command3.Picture = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
                .Command3.ToolTipText = "Atualizar Custo"
                .Command3.Style   = 0
                .Command3.SpecialEffect = 0
                .Command3.BackColor = RGB(255, 255, 255)
                .Command4.Top     = 125
                .Command4.Left    = 5
                .Command4.Height  = 40
                .Command4.Width   = 40
                .Command4.Caption = ""
                .Command4.Picture = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
                .Command4.ToolTipText = "Atualizar Pre" + CHR(231) + "o"
                .Command4.Style   = 0
                .Command4.SpecialEffect = 0
                .Command4.BackColor = RGB(255, 255, 255)
                .Command5.Top     = 165
                .Command5.Left    = 5
                .Command5.Height  = 40
                .Command5.Width   = 40
                .Command5.Caption = ""
                .Command5.Picture = gc_4c_CaminhoIcones + "geral_servicos_26.jpg"
                .Command5.ToolTipText = "Atualizar Pesos"
                .Command5.BackColor = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(loc_oPg.cmg_4c_CmdgCompo, "Click", THIS, "CmgCompoClick")

            *-- grdsubcp: grade de subcomposicao (15 colunas)
            loc_oPg.AddObject("grd_4c_GrdSubCp", "Grid")
            WITH loc_oPg.grd_4c_GrdSubCp
                .Top        = 317
                .Left       = 6
                .Width      = 943
                .Height     = 83
                .FontName   = "Tahoma"
                .FontSize   = 8
                .RecordMark = .F.
                .RowHeight  = 16
                .ScrollBars = 2
                .TabStop    = .F.
                .Visible    = .T.
            ENDWITH
            loc_oPg.grd_4c_GrdSubCp.ColumnCount  = 15
            loc_oPg.grd_4c_GrdSubCp.RecordSource = "cursor_4c_GrdSubCp"
            loc_oGrid2 = loc_oPg.grd_4c_GrdSubCp

            loc_oGrid2.Column1.ControlSource  = "cursor_4c_GrdSubCp.cpros"
            loc_oGrid2.Column1.Width          = 108
            loc_oGrid2.Column1.ColumnOrder    = 1
            loc_oGrid2.Column1.Movable        = .F.
            loc_oGrid2.Column1.Resizable      = .F.
            loc_oGrid2.Column1.Header1.Caption = "Material"

            loc_oGrid2.Column2.ControlSource  = "cursor_4c_GrdSubCp.dpros"
            loc_oGrid2.Column2.Width          = 149
            loc_oGrid2.Column2.ColumnOrder    = 2
            loc_oGrid2.Column2.Movable        = .F.
            loc_oGrid2.Column2.Resizable      = .F.
            loc_oGrid2.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            loc_oGrid2.Column3.ControlSource  = "cursor_4c_GrdSubCp.cunis"
            loc_oGrid2.Column3.Width          = 24
            loc_oGrid2.Column3.ColumnOrder    = 4
            loc_oGrid2.Column3.Movable        = .F.
            loc_oGrid2.Column3.Resizable      = .F.
            loc_oGrid2.Column3.Header1.Caption = "Un"

            loc_oGrid2.Column4.ControlSource  = "cursor_4c_GrdSubCp.valor"
            loc_oGrid2.Column4.Width          = 73
            loc_oGrid2.Column4.ColumnOrder    = 7
            loc_oGrid2.Column4.Movable        = .F.
            loc_oGrid2.Column4.Resizable      = .F.
            loc_oGrid2.Column4.InputMask      = "9999999.999"
            loc_oGrid2.Column4.Header1.Caption = "Valor"

            loc_oGrid2.Column5.ControlSource  = "cursor_4c_GrdSubCp.qtdes"
            loc_oGrid2.Column5.Width          = 59
            loc_oGrid2.Column5.ColumnOrder    = 3
            loc_oGrid2.Column5.Movable        = .F.
            loc_oGrid2.Column5.Resizable      = .F.
            loc_oGrid2.Column5.InputMask      = "9999.999"
            loc_oGrid2.Column5.Header1.Caption = "Qtde."

            loc_oGrid2.Column6.ControlSource  = "cursor_4c_GrdSubCp.total"
            loc_oGrid2.Column6.Width          = 58
            loc_oGrid2.Column6.ColumnOrder    = 9
            loc_oGrid2.Column6.InputMask      = "9999999.999"
            loc_oGrid2.Column6.Header1.Caption = "Total"

            loc_oGrid2.Column7.ControlSource  = "cursor_4c_GrdSubCp.moeda"
            loc_oGrid2.Column7.Width          = 31
            loc_oGrid2.Column7.ColumnOrder    = 8
            loc_oGrid2.Column7.Header1.Caption = "Moe"

            loc_oGrid2.Column8.ControlSource  = "cursor_4c_GrdSubCp.obs"
            loc_oGrid2.Column8.Width          = 80
            loc_oGrid2.Column8.ColumnOrder    = 10
            loc_oGrid2.Column8.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"

            loc_oGrid2.Column9.ControlSource  = "cursor_4c_GrdSubCp.estoc"
            loc_oGrid2.Column9.Width          = 14
            loc_oGrid2.Column9.ColumnOrder    = 12
            loc_oGrid2.Column9.Format         = "M"
            loc_oGrid2.Column9.InputMask      = "N,S"
            loc_oGrid2.Column9.Header1.Caption = "E"

            loc_oGrid2.Column10.ControlSource  = "cursor_4c_GrdSubCp.consumo"
            loc_oGrid2.Column10.Width          = 58
            loc_oGrid2.Column10.ColumnOrder    = 13
            loc_oGrid2.Column10.InputMask      = "99999"
            loc_oGrid2.Column10.Header1.Caption = "Consumo"

            loc_oGrid2.Column11.ControlSource  = "cursor_4c_GrdSubCp.qtdes2"
            loc_oGrid2.Column11.Width          = 59
            loc_oGrid2.Column11.ColumnOrder    = 5
            loc_oGrid2.Column11.Movable        = .F.
            loc_oGrid2.Column11.Resizable      = .F.
            loc_oGrid2.Column11.Header1.Caption = "Qtde."

            loc_oGrid2.Column12.ControlSource  = "cursor_4c_GrdSubCp.cunis2"
            loc_oGrid2.Column12.Width          = 24
            loc_oGrid2.Column12.ColumnOrder    = 6
            loc_oGrid2.Column12.Movable        = .F.
            loc_oGrid2.Column12.ReadOnly       = .T.
            loc_oGrid2.Column12.Header1.Caption = "Un"

            loc_oGrid2.Column13.ControlSource  = "cursor_4c_GrdSubCp.ords"
            loc_oGrid2.Column13.Width          = 24
            loc_oGrid2.Column13.ColumnOrder    = 14
            loc_oGrid2.Column13.Format         = "K"
            loc_oGrid2.Column13.InputMask      = "99"
            loc_oGrid2.Column13.Header1.Caption = "Ord"

            loc_oGrid2.Column14.ControlSource  = "cursor_4c_GrdSubCp.matprinc"
            loc_oGrid2.Column14.Width          = 108
            loc_oGrid2.Column14.ColumnOrder    = 11
            loc_oGrid2.Column14.Header1.Caption = "Material"
            loc_oGrid2.Column14.Header1.BackColor = RGB(240, 240, 240)

            loc_oGrid2.Column15.ControlSource  = "cursor_4c_GrdSubCp.tamanho"
            loc_oGrid2.Column15.Width          = 38
            loc_oGrid2.Column15.Header1.Caption = "Tam"
            loc_oGrid2.Column15.Header1.ToolTipText = "Tamanho"

            *-- cmg_4c_CmdgSubCp: 2 botoes de subcomposicao
            loc_oPg.AddObject("cmg_4c_CmdgSubCp", "CommandGroup")
            WITH loc_oPg.cmg_4c_CmdgSubCp
                .Top         = 314
                .Left        = 947
                .Width       = 50
                .Height      = 90
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .BackColor   = RGB(162, 214, 242)
                .ButtonCount = 2
                .Visible     = .T.
            ENDWITH
            WITH loc_oPg.cmg_4c_CmdgSubCp
                .Command1.Top     = 5
                .Command1.Left    = 5
                .Command1.Height  = 40
                .Command1.Width   = 40
                .Command1.Caption = ""
                .Command1.Picture = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
                .Command1.ToolTipText = "Inserir Item"
                .Command1.Style   = 0
                .Command1.SpecialEffect = 0
                .Command1.BackColor = RGB(255, 255, 255)
                .Command2.Top     = 45
                .Command2.Left    = 5
                .Command2.Height  = 40
                .Command2.Width   = 40
                .Command2.Caption = ""
                .Command2.Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .Command2.ToolTipText = "Excluir Item"
                .Command2.Style   = 0
                .Command2.SpecialEffect = 0
                .Command2.BackColor = RGB(255, 255, 255)
            ENDWITH
            BINDEVENT(loc_oPg.cmg_4c_CmdgSubCp, "Click", THIS, "CmgSubCpClick")

            *-- grdRelogios: grade de relogios (inicialmente oculta)
            loc_oPg.AddObject("grd_4c_GrdRelogios", "Grid")
            WITH loc_oPg.grd_4c_GrdRelogios
                .Top        = 117
                .Left       = 6
                .Width      = 943
                .Height     = 307
                .FontName   = "Verdana"
                .FontSize   = 8
                .RecordMark = .F.
                .RowHeight  = 16
                .ScrollBars = 2
                .TabStop    = .F.
                .Visible    = .F.
            ENDWITH
            loc_oPg.grd_4c_GrdRelogios.ColumnCount  = 4
            loc_oPg.grd_4c_GrdRelogios.RecordSource = "cursor_4c_GrdRelogios"
            loc_oGrid3 = loc_oPg.grd_4c_GrdRelogios

            loc_oGrid3.Column1.ControlSource  = "cursor_4c_GrdRelogios.grp"
            loc_oGrid3.Column1.Width          = 31
            loc_oGrid3.Column1.ColumnOrder    = 1
            loc_oGrid3.Column1.Movable        = .F.
            loc_oGrid3.Column1.Resizable      = .F.
            loc_oGrid3.Column1.Header1.Caption = "Grp"

            loc_oGrid3.Column2.ControlSource  = "cursor_4c_GrdRelogios.descricao"
            loc_oGrid3.Column2.Width          = 150
            loc_oGrid3.Column2.Movable        = .F.
            loc_oGrid3.Column2.Resizable      = .F.
            loc_oGrid3.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            loc_oGrid3.Column3.ControlSource  = "cursor_4c_GrdRelogios.produto"
            loc_oGrid3.Column3.Width          = 115
            loc_oGrid3.Column3.ColumnOrder    = 3
            loc_oGrid3.Column3.Movable        = .F.
            loc_oGrid3.Column3.Resizable      = .F.
            loc_oGrid3.Column3.Header1.Caption = "Produto"

            loc_oGrid3.Column4.ControlSource  = "cursor_4c_GrdRelogios.descprod"
            loc_oGrid3.Column4.Width          = 290
            loc_oGrid3.Column4.ColumnOrder    = 4
            loc_oGrid3.Column4.Movable        = .F.
            loc_oGrid3.Column4.Resizable      = .F.
            loc_oGrid3.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

            *-- GradeGRUPO: grade de totais por grupo
            loc_oPg.AddObject("grd_4c_GradeGrupo", "Grid")
            WITH loc_oPg.grd_4c_GradeGrupo
                .Top          = 41
                .Left         = 619
                .Width        = 215
                .Height       = 68
                .FontName     = "Verdana"
                .FontSize     = 8
                .DeleteMark   = .F.
                .HeaderHeight = 14
                .ReadOnly     = .T.
                .RecordMark   = .F.
                .RowHeight    = 16
                .Visible      = .T.
            ENDWITH
            loc_oPg.grd_4c_GradeGrupo.ColumnCount  = 3
            loc_oPg.grd_4c_GradeGrupo.RecordSource = "TotGrupo"
            loc_oGradeGrupo = loc_oPg.grd_4c_GradeGrupo

            loc_oGradeGrupo.Column1.ControlSource  = "TotGrupo.Grupo"
            loc_oGradeGrupo.Column1.Width          = 35
            loc_oGradeGrupo.Column1.Movable        = .F.
            loc_oGradeGrupo.Column1.Resizable      = .F.
            loc_oGradeGrupo.Column1.ReadOnly       = .T.
            loc_oGradeGrupo.Column1.Header1.Caption = "Grupo"

            loc_oGradeGrupo.Column2.ControlSource  = "TotGrupo.ValGrupo"
            loc_oGradeGrupo.Column2.Width          = 120
            loc_oGradeGrupo.Column2.Movable        = .F.
            loc_oGradeGrupo.Column2.Resizable      = .F.
            loc_oGradeGrupo.Column2.ReadOnly       = .T.
            loc_oGradeGrupo.Column2.InputMask      = "999,999,999.999"
            loc_oGradeGrupo.Column2.Header1.Caption = "Total "

            loc_oGradeGrupo.Column3.ControlSource  = "TotGrupo.Moeda"
            loc_oGradeGrupo.Column3.Width          = 37
            loc_oGradeGrupo.Column3.Movable        = .F.
            loc_oGradeGrupo.Column3.Resizable      = .F.
            loc_oGradeGrupo.Column3.ReadOnly       = .T.
            loc_oGradeGrupo.Column3.Header1.Caption = "Moeda"

            *-- BINDEVENT para grids
            BINDEVENT(loc_oPg.grd_4c_GrdCompo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
            BINDEVENT(loc_oPg.grd_4c_GrdSubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")

            *-- Say4: "Obs. da OF :"
            loc_oPg.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPg.lbl_4c_Label4
                .Caption   = "Obs. da OF :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 33
                .Top       = 269
                .Width     = 64
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getObsOFs: observacao da ordem de fabricacao
            loc_oPg.AddObject("txt_4c_ObsOFs", "TextBox")
            WITH loc_oPg.txt_4c_ObsOFs
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Format    = "K!"
                .Height    = 21
                .Left      = 99
                .MaxLength = 120
                .SpecialEffect = 1
                .Top       = 266
                .Width     = 850
                .BackColor = RGB(240, 240, 240)
                .Value     = ""
                .Visible   = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_ObsOFs, "When", THIS, "TxtObsOFsWhen")
            BINDEVENT(loc_oPg.txt_4c_ObsOFs, "KeyPress", THIS, "TxtObsOFsKeyPress")

            *-- Say16: "Descricao :" (para Get_Desc)
            loc_oPg.AddObject("lbl_4c_Label16", "Label")
            WITH loc_oPg.lbl_4c_Label16
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 40
                .Top       = 293
                .Width     = 55
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_Desc: descricao do produto na composicao principal
            loc_oPg.AddObject("txt_4c_Desc", "TextBox")
            WITH loc_oPg.txt_4c_Desc
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Height    = 21
                .Left      = 99
                .SpecialEffect = 1
                .Top       = 290
                .Width     = 298
                .BackColor = RGB(240, 240, 240)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Say15: "Material Principal :"
            loc_oPg.AddObject("lbl_4c_Label15", "Label")
            WITH loc_oPg.lbl_4c_Label15
                .Caption   = "Material Principal :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 418
                .Top       = 293
                .Width     = 89
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_MatP: codigo do material principal
            loc_oPg.AddObject("txt_4c_MatP", "TextBox")
            WITH loc_oPg.txt_4c_MatP
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Height    = 21
                .Left      = 517
                .MaxLength = 14
                .SpecialEffect = 1
                .Top       = 290
                .Width     = 108
                .BackColor = RGB(240, 240, 240)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Say3: "Descricao :" (para grdsubcp)
            loc_oPg.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oPg.lbl_4c_Label3
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 40
                .Top       = 404
                .Width     = 55
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- get_desccp: descricao do subcomponente
            loc_oPg.AddObject("txt_4c__desccp", "TextBox")
            WITH loc_oPg.txt_4c__desccp
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Height    = 21
                .Left      = 99
                .SpecialEffect = 1
                .Top       = 401
                .Width     = 298
                .BackColor = RGB(240, 240, 240)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Say5: "Substitui :"
            loc_oPg.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPg.lbl_4c_Label5
                .Caption   = "Substitui :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 466
                .Top       = 404
                .Width     = 50
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- get_matsub: material substituto
            loc_oPg.AddObject("txt_4c__matsub", "TextBox")
            WITH loc_oPg.txt_4c__matsub
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Height    = 21
                .Left      = 517
                .MaxLength = 14
                .SpecialEffect = 1
                .Top       = 401
                .Width     = 108
                .BackColor = RGB(240, 240, 240)
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Shape6 e Shape4: separadores visuais das secoes custo/venda
            loc_oPg.AddObject("shp_4c_Shape6", "Shape")
            WITH loc_oPg.shp_4c_Shape6
                .Top          = 468
                .Left         = 7
                .Height       = 2
                .Width        = 369
                .BackStyle    = 0
                .BorderWidth  = 2
                .SpecialEffect = 0
                .Visible      = .T.
            ENDWITH

            loc_oPg.AddObject("shp_4c_Shape4", "Shape")
            WITH loc_oPg.shp_4c_Shape4
                .Top          = 468
                .Left         = 383
                .Height       = 2
                .Width        = 350
                .BackStyle    = 0
                .BorderWidth  = 2
                .SpecialEffect = 0
                .Visible      = .T.
            ENDWITH

            *-- Say1: " Custo " - titulo da secao de custo
            loc_oPg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPg.lbl_4c_Label1
                .Caption   = " Custo "
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 9
                .BackStyle = 0
                .Height    = 16
                .Left      = 45
                .Top       = 442
                .Width     = 46
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Say2: " Venda " - titulo da secao de venda
            loc_oPg.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPg.lbl_4c_Label2
                .Caption   = " Venda "
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 9
                .BackStyle = 0
                .Height    = 16
                .Left      = 421
                .Top       = 442
                .Width     = 48
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- chkLiberaCusto: cadeado de liberacao de edicao de custo
            loc_oPg.AddObject("chk_4c_ChkLiberaCusto", "CheckBox")
            WITH loc_oPg.chk_4c_ChkLiberaCusto
                .Top           = 431
                .Left          = 7
                .Height        = 35
                .Width         = 35
                .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
                .Alignment     = 0
                .Caption       = ""
                .Value         = 0
                .SpecialEffect = 0
                .Style         = 1
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.chk_4c_ChkLiberaCusto, "Click", THIS, "ChkLiberaCustoClick")

            *-- chkLiberaVenda: cadeado de liberacao de edicao de venda
            loc_oPg.AddObject("chk_4c_ChkLiberaVenda", "CheckBox")
            WITH loc_oPg.chk_4c_ChkLiberaVenda
                .Top           = 431
                .Left          = 383
                .Height        = 35
                .Width         = 35
                .Picture       = gc_4c_CaminhoIcones + "geral_lock_on_34.jpg"
                .Alignment     = 0
                .Caption       = ""
                .Value         = 0
                .SpecialEffect = 0
                .Style         = 1
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.chk_4c_ChkLiberaVenda, "Click", THIS, "ChkLiberaVendaClick")

            *==============================================================
            *-- SECAO CUSTO (Left < 380)
            *==============================================================

            *-- lblCompra: "Preco de Custo (Moeda 1)"
            loc_oPg.AddObject("lbl_4c_LblCompra", "Label")
            WITH loc_oPg.lbl_4c_LblCompra
                .Caption   = "Pre" + CHR(231) + "o de Custo (Moeda 1)"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 7
                .Top       = 474
                .Width     = 127
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getPcus: preco de custo
            loc_oPg.AddObject("txt_4c_Pcus", "TextBox")
            WITH loc_oPg.txt_4c_Pcus
                .Alignment     = 3
                .Format        = "K"
                .Height        = 23
                .InputMask     = "999,999.99999"
                .Left          = 7
                .SpecialEffect = 1
                .Top           = 489
                .Width         = 115
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_Moec: moeda de custo (lookup SigCdMoe)
            loc_oPg.AddObject("txt_4c_Moec", "TextBox")
            WITH loc_oPg.txt_4c_Moec
                .Format        = "K"
                .Height        = 23
                .Left          = 125
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 489
                .Width         = 31
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress", THIS, "ValidarMoec")
            BINDEVENT(loc_oPg.txt_4c_Moec, "KeyPress", THIS, "TxtMoecKeyPress")

            *-- Say22: "MKP" (custo)
            loc_oPg.AddObject("lbl_4c_Label22", "Label")
            WITH loc_oPg.lbl_4c_Label22
                .Caption   = "MKP"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 7
                .Top       = 514
                .Width     = 22
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_cmkpc: codigo MKP custo (lookup SigPrFti)
            loc_oPg.AddObject("txt_4c_Cmkpc", "TextBox")
            WITH loc_oPg.txt_4c_Cmkpc
                .Height        = 23
                .Left          = 7
                .MaxLength     = 2
                .SpecialEffect = 1
                .Top           = 529
                .Width         = 24
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Cmkpc, "KeyPress", THIS, "ValidarCmkpc")
            BINDEVENT(loc_oPg.txt_4c_Cmkpc, "KeyPress", THIS, "TxtCmkpcKeyPress")

            *-- chkPlanCus: planejamento custo
            loc_oPg.AddObject("chk_4c_ChkPlanCus", "CheckBox")
            WITH loc_oPg.chk_4c_ChkPlanCus
                .Top           = 528
                .Left          = 34
                .Height        = 25
                .Width         = 25
                .Picture       = gc_4c_CaminhoIcones + "geral_datas_26.jpg"
                .Alignment     = 0
                .Caption       = ""
                .Value         = 0
                .SpecialEffect = 1
                .Style         = 1
                .BackColor     = RGB(162, 214, 242)
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.chk_4c_ChkPlanCus, "Click", THIS, "ChkPlanCusClick")

            *-- lblValAdics: "Valor Adicional" (custo)
            loc_oPg.AddObject("lbl_4c_LblValAdics", "Label")
            WITH loc_oPg.lbl_4c_LblValAdics
                .Caption   = "Valor Adicional"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 62
                .Top       = 514
                .Width     = 71
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- get_pftioc: valor adicional custo
            loc_oPg.AddObject("txt_4c__pftioc", "TextBox")
            WITH loc_oPg.txt_4c__pftioc
                .Alignment     = 3
                .Height        = 23
                .InputMask     = "999,999.99999"
                .Left          = 62
                .SpecialEffect = 1
                .Top           = 529
                .Width         = 94
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lblCuVda: "Fator de Custo (Moeda 2)"
            loc_oPg.AddObject("lbl_4c_LblCuVda", "Label")
            WITH loc_oPg.lbl_4c_LblCuVda
                .Caption   = "Fator de Custo (Moeda 2)"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 158
                .Top       = 474
                .Width     = 126
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getFcusto: fator de custo
            loc_oPg.AddObject("txt_4c_Fcusto", "TextBox")
            WITH loc_oPg.txt_4c_Fcusto
                .Alignment     = 3
                .Format        = "K"
                .Height        = 23
                .InputMask     = "999,999.99999"
                .Left          = 159
                .SpecialEffect = 1
                .Top           = 489
                .Width         = 109
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_Moepc: moeda fator custo (lookup SigCdMoe)
            loc_oPg.AddObject("txt_4c_Moepc", "TextBox")
            WITH loc_oPg.txt_4c_Moepc
                .Height        = 23
                .Left          = 270
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 489
                .Width         = 31
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress", THIS, "ValidarMoepc")
            BINDEVENT(loc_oPg.txt_4c_Moepc, "KeyPress", THIS, "TxtMoepcKeyPress")

            *-- Say8: "Total "
            loc_oPg.AddObject("lbl_4c_Label8", "Label")
            WITH loc_oPg.lbl_4c_Label8
                .Caption   = "Total "
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 158
                .Top       = 514
                .Width     = 29
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getCustof: total custo
            loc_oPg.AddObject("txt_4c_Custof", "TextBox")
            WITH loc_oPg.txt_4c_Custof
                .Alignment     = 3
                .Height        = 23
                .InputMask     = "999,999.99999"
                .Left          = 159
                .SpecialEffect = 1
                .Top           = 529
                .Width         = 109
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- txt_4c_Moecusf: moeda total custo (lookup SigCdMoe)
            loc_oPg.AddObject("txt_4c_Moecusf", "TextBox")
            WITH loc_oPg.txt_4c_Moecusf
                .Height        = 23
                .Left          = 270
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 529
                .Width         = 31
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Moecusf, "KeyPress", THIS, "ValidarMoecusf")
            BINDEVENT(loc_oPg.txt_4c_Moecusf, "KeyPress", THIS, "TxtMoecusfKeyPress")

            *-- Say6: "Peso Medio"
            loc_oPg.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPg.lbl_4c_Label6
                .Caption   = "Peso M" + CHR(233) + "dio"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 8
                .Top       = 553
                .Width     = 56
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getPesom: peso medio
            loc_oPg.AddObject("txt_4c_Peso", "TextBox")
            WITH loc_oPg.txt_4c_Peso
                .Alignment     = 3
                .Format        = "K"
                .Height        = 23
                .InputMask     = "99,999.999"
                .Left          = 8
                .MaxLength     = 10
                .SpecialEffect = 1
                .Top           = 568
                .Width         = 79
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- Say10: "Var. Peso %"
            loc_oPg.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oPg.lbl_4c_Label10
                .Caption   = "Var. Peso %"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 88
                .Top       = 553
                .Width     = 62
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getVarPesoMs: variacao de peso
            loc_oPg.AddObject("txt_4c_VarPesoMs", "TextBox")
            WITH loc_oPg.txt_4c_VarPesoMs
                .Height        = 23
                .InputMask     = "999.99"
                .Left          = 92
                .SpecialEffect = 1
                .Top           = 568
                .Width         = 52
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- Say9: "Custo MP Propria" (negrito)
            loc_oPg.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPg.lbl_4c_Label9
                .Caption   = "Custo MP Pr" + CHR(243) + "pria"
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 158
                .Top       = 555
                .Width     = 98
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getCustoCp: custo MP propria (fundo verde)
            loc_oPg.AddObject("txt_4c_CustoCp", "TextBox")
            WITH loc_oPg.txt_4c_CustoCp
                .Alignment     = 3
                .Height        = 23
                .InputMask     = "9999,999.99999"
                .Left          = 158
                .SpecialEffect = 1
                .Top           = 568
                .Width         = 105
                .BackColor     = RGB(0, 255, 0)
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- Say7: "Preco De"
            loc_oPg.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPg.lbl_4c_Label7
                .Caption   = "Pre" + CHR(231) + "o De"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 272
                .Top       = 555
                .Width     = 45
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getPrecoDe: preco De (borda vermelha)
            loc_oPg.AddObject("txt_4c_PrecoDe", "TextBox")
            WITH loc_oPg.txt_4c_PrecoDe
                .Alignment   = 3
                .Height      = 23
                .InputMask   = "9999,999.99999"
                .Left        = 272
                .SpecialEffect = 1
                .Top         = 568
                .Width       = 105
                .BorderColor = RGB(255, 0, 0)
                .Value       = 0
                .Visible     = .T.
            ENDWITH

            *==============================================================
            *-- SECAO VENDA (Left >= 380)
            *==============================================================

            *-- lblMkpVenda: "MKP Ideal"
            loc_oPg.AddObject("lbl_4c_LblMkpVenda", "Label")
            WITH loc_oPg.lbl_4c_LblMkpVenda
                .Caption   = "MKP Ideal"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 384
                .Top       = 476
                .Width     = 49
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getMargem: margem/markup ideal
            loc_oPg.AddObject("txt_4c_Margem", "TextBox")
            WITH loc_oPg.txt_4c_Margem
                .Alignment     = 3
                .Height        = 23
                .InputMask     = "999.999999"
                .Left          = 383
                .MaxLength     = 6
                .SpecialEffect = 1
                .Top           = 489
                .Width         = 89
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- Say14: "MKP" (venda)
            loc_oPg.AddObject("lbl_4c_Label14", "Label")
            WITH loc_oPg.lbl_4c_Label14
                .Caption   = "MKP"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 420
                .Top       = 514
                .Width     = 22
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Getftio: codigo MKP venda (lookup SigPrFti)
            loc_oPg.AddObject("txt_4c_Ftio", "TextBox")
            WITH loc_oPg.txt_4c_Ftio
                .Height        = 23
                .Left          = 420
                .MaxLength     = 2
                .SpecialEffect = 1
                .Top           = 529
                .Width         = 24
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Ftio, "KeyPress", THIS, "ValidarFtio")
            BINDEVENT(loc_oPg.txt_4c_Ftio, "KeyPress", THIS, "TxtFtioKeyPress")

            *-- getStatus: status do produto (lookup SigCdPst)
            loc_oPg.AddObject("txt_4c_Status", "TextBox")
            WITH loc_oPg.txt_4c_Status
                .Format        = "K"
                .Height        = 23
                .Left          = 384
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 529
                .Width         = 31
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Status, "KeyPress", THIS, "ValidarStatus")
            BINDEVENT(loc_oPg.txt_4c_Status, "KeyPress", THIS, "TxtStatusKeyPress")

            *-- Say24: "Sts"
            loc_oPg.AddObject("lbl_4c_Label24", "Label")
            WITH loc_oPg.lbl_4c_Label24
                .Caption   = "Sts"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 384
                .Top       = 514
                .Width     = 17
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- chkPlanVen: planejamento venda
            loc_oPg.AddObject("chk_4c_ChkPlanVen", "CheckBox")
            WITH loc_oPg.chk_4c_ChkPlanVen
                .Top           = 528
                .Left          = 447
                .Height        = 25
                .Width         = 25
                .Picture       = gc_4c_CaminhoIcones + "geral_datas_26.jpg"
                .Alignment     = 0
                .Caption       = ""
                .Value         = 0
                .SpecialEffect = 0
                .Style         = 1
                .BackColor     = RGB(162, 214, 242)
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.chk_4c_ChkPlanVen, "Click", THIS, "ChkPlanVenClick")

            *-- Chk_Pvenda: copia preco ideal para atual
            loc_oPg.AddObject("chk_4c_Chk_Pvenda", "CheckBox")
            WITH loc_oPg.chk_4c_Chk_Pvenda
                .Top           = 567
                .Left          = 447
                .Height        = 25
                .Width         = 25
                .Picture       = gc_4c_CaminhoIcones + "a_arrow1.bmp"
                .Alignment     = 0
                .Caption       = ""
                .Value         = 0
                .SpecialEffect = 0
                .Style         = 1
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.chk_4c_Chk_Pvenda, "Click", THIS, "ChkPvendaClick")

            *-- Say13: "Valor Adicional" (venda)
            loc_oPg.AddObject("lbl_4c_Label13", "Label")
            WITH loc_oPg.lbl_4c_Label13
                .Caption   = "Valor Adicional"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 476
                .Top       = 514
                .Width     = 71
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_Pftio: valor adicional venda
            loc_oPg.AddObject("txt_4c_Pftio", "TextBox")
            WITH loc_oPg.txt_4c_Pftio
                .Alignment     = 3
                .Height        = 23
                .InputMask     = "999,999.99999"
                .Left          = 476
                .SpecialEffect = 1
                .Top           = 529
                .Width         = 105
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- Get_mftio: moeda valor adicional venda (lookup SigCdMoe)
            loc_oPg.AddObject("txt_4c_Mftio", "TextBox")
            WITH loc_oPg.txt_4c_Mftio
                .Height        = 23
                .Left          = 584
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 529
                .Width         = 31
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Mftio, "KeyPress", THIS, "ValidarMftio")
            BINDEVENT(loc_oPg.txt_4c_Mftio, "KeyPress", THIS, "TxtMftioKeyPress")

            *-- Say12: "Fator"
            loc_oPg.AddObject("lbl_4c_Label12", "Label")
            WITH loc_oPg.lbl_4c_Label12
                .Caption   = "Fator"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 618
                .Top       = 514
                .Width     = 28
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getFvenda: fator de venda
            loc_oPg.AddObject("txt_4c_Fvenda", "TextBox")
            WITH loc_oPg.txt_4c_Fvenda
                .Alignment     = 3
                .Height        = 23
                .InputMask     = "99,999.99999"
                .Left          = 618
                .SpecialEffect = 1
                .Top           = 529
                .Width         = 105
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- getMoepv: moeda fator de venda (lookup SigCdMoe)
            loc_oPg.AddObject("txt_4c_Moepv", "TextBox")
            WITH loc_oPg.txt_4c_Moepv
                .Height        = 23
                .Left          = 726
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 529
                .Width         = 31
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress", THIS, "ValidarMoepv")
            BINDEVENT(loc_oPg.txt_4c_Moepv, "KeyPress", THIS, "TxtMoepvKeyPress")

            *-- getMoeda: moeda de venda ideal (lookup SigCdMoe)
            loc_oPg.AddObject("txt_4c_Moeda", "TextBox")
            WITH loc_oPg.txt_4c_Moeda
                .Height        = 23
                .Left          = 584
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 489
                .Width         = 31
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoeda")
            BINDEVENT(loc_oPg.txt_4c_Moeda, "KeyPress", THIS, "TxtMoedaKeyPress")

            *-- lblIdeal: "Preco Ideal (Moeda 1)"
            loc_oPg.AddObject("lbl_4c_LblIdeal", "Label")
            WITH loc_oPg.lbl_4c_LblIdeal
                .Caption   = "Pre" + CHR(231) + "o Ideal  (Moeda 1)"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 476
                .Top       = 475
                .Width     = 111
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getPvideal: preco ideal
            loc_oPg.AddObject("txt_4c_Pvideal", "TextBox")
            WITH loc_oPg.txt_4c_Pvideal
                .Alignment     = 3
                .Height        = 23
                .InputMask     = "999,999.99999"
                .Left          = 476
                .SpecialEffect = 1
                .Top           = 489
                .Width         = 105
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lblFIdeals: "Fator Ideal"
            loc_oPg.AddObject("lbl_4c_LblFIdeals", "Label")
            WITH loc_oPg.lbl_4c_LblFIdeals
                .Caption   = "Fator Ideal"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 618
                .Top       = 475
                .Width     = 55
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getFIdeals: fator ideal
            loc_oPg.AddObject("txt_4c_FIdeals", "TextBox")
            WITH loc_oPg.txt_4c_FIdeals
                .Alignment     = 3
                .Height        = 23
                .InputMask     = "999,999.99999"
                .Left          = 618
                .SpecialEffect = 1
                .Top           = 489
                .Width         = 105
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lblMkpApl: "MKP Aplic."
            loc_oPg.AddObject("lbl_4c_LblMkpApl", "Label")
            WITH loc_oPg.lbl_4c_LblMkpApl
                .Caption   = "MKP Aplic."
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 384
                .Top       = 553
                .Width     = 51
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getMarkupA: markup aplicado
            loc_oPg.AddObject("txt_4c_MarkupA", "TextBox")
            WITH loc_oPg.txt_4c_MarkupA
                .Alignment     = 3
                .Height        = 23
                .InputMask     = "9999.999"
                .Left          = 383
                .SpecialEffect = 1
                .Top           = 568
                .Width         = 62
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lblVenda: "Preco Atual (Moeda 2)"
            loc_oPg.AddObject("lbl_4c_LblVenda", "Label")
            WITH loc_oPg.lbl_4c_LblVenda
                .Caption   = "Pre" + CHR(231) + "o  Atual  (Moeda 2)"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 476
                .Top       = 553
                .Width     = 115
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getPven: preco de venda atual
            loc_oPg.AddObject("txt_4c_Pven", "TextBox")
            WITH loc_oPg.txt_4c_Pven
                .Alignment     = 3
                .Height        = 23
                .InputMask     = "9999,999.99999"
                .Left          = 476
                .SpecialEffect = 1
                .Top           = 568
                .Width         = 105
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- getMoev: moeda preco atual (lookup SigCdMoe)
            loc_oPg.AddObject("txt_4c_Moev", "TextBox")
            WITH loc_oPg.txt_4c_Moev
                .Height        = 23
                .Left          = 584
                .MaxLength     = 3
                .SpecialEffect = 1
                .Top           = 568
                .Width         = 31
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Moev, "KeyPress", THIS, "ValidarMoev")
            BINDEVENT(loc_oPg.txt_4c_Moev, "KeyPress", THIS, "TxtMoevKeyPress")

            *-- lblFAtuals: "Fator Atual"
            loc_oPg.AddObject("lbl_4c_LblFAtuals", "Label")
            WITH loc_oPg.lbl_4c_LblFAtuals
                .Caption   = "Fator Atual"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 618
                .Top       = 553
                .Width     = 56
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getFAtuals: fator atual
            loc_oPg.AddObject("txt_4c_FAtuals", "TextBox")
            WITH loc_oPg.txt_4c_FAtuals
                .Alignment     = 3
                .Height        = 23
                .InputMask     = "999,999.99999"
                .Left          = 618
                .SpecialEffect = 1
                .Top           = 568
                .Width         = 105
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- Say25: "Financeiro"
            loc_oPg.AddObject("lbl_4c_Label25", "Label")
            WITH loc_oPg.lbl_4c_Label25
                .Caption   = "Financeiro"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 727
                .Top       = 553
                .Width     = 51
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_Encarg: encargos financeiros
            loc_oPg.AddObject("txt_4c_Encarg", "TextBox")
            WITH loc_oPg.txt_4c_Encarg
                .Alignment     = 1
                .Height        = 23
                .InputMask     = "999.99"
                .Left          = 727
                .MaxLength     = 6
                .SpecialEffect = 1
                .Top           = 567
                .Width         = 62
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- cmdCalcVals: botao calcular valores pelas moedas
            loc_oPg.AddObject("cmd_4c_CmdCalcVals", "CommandButton")
            WITH loc_oPg.cmd_4c_CmdCalcVals
                .Top           = 479
                .Left          = 727
                .Height        = 40
                .Width         = 40
                .FontBold      = .T.
                .WordWrap      = .T.
                .Caption       = ""
                .Picture       = gc_4c_CaminhoIcones + "geral_calculadora_26.jpg"
                .ToolTipText   = "Calcular os Valores Pelas Moedas Informadas"
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_CmdCalcVals, "Click", THIS, "CmdCalcValsClick")

            *==============================================================
            *-- cntMtPrima: container de informacoes de materia prima
            *==============================================================
            loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
            WITH loc_oPg.cnt_4c_MtPrima
                .Top           = 471
                .Left          = 785
                .Width         = 211
                .Height        = 124
                .BackStyle     = 0
                .BorderWidth   = 0
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH
            loc_oCnt = loc_oPg.cnt_4c_MtPrima

            loc_oCnt.AddObject("lbl_4c_LblCompos", "Label")
            WITH loc_oCnt.lbl_4c_LblCompos
                .Caption   = "Composi" + CHR(231) + CHR(227) + "o :"
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 6
                .Top       = 6
                .Width     = 66
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_Compos", "TextBox")
            WITH loc_oCnt.txt_4c_Compos
                .FontName            = "Tahoma"
                .Height              = 23
                .Left                = 6
                .SpecialEffect       = 1
                .Top                 = 20
                .Width               = 202
                .Enabled             = .F.
                .DisabledBackColor   = RGB(255, 255, 255)
                .DisabledForeColor   = RGB(0, 0, 0)
                .Value               = ""
                .Visible             = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblMontaDescs", "Label")
            WITH loc_oCnt.lbl_4c_LblMontaDescs
                .Caption   = "Montagem :"
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 6
                .Top       = 43
                .Width     = 59
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("cbo_4c_CmbMontaDescs", "ComboBox")
            WITH loc_oCnt.cbo_4c_CmbMontaDescs
                .FontName      = "Tahoma"
                .RowSourceType = 1
                .RowSource     = "Qtde + Uni + Codigo, Qtde + Codigo, Uni + Codigo, Codigo, Qtde + Codigo (s/ CT),Qtde+Codigo+Peso+Unidade,Qtde + Unidade"
                .Enabled       = .F.
                .Height        = 23
                .Left          = 6
                .SpecialEffect = 1
                .Style         = 2
                .Top           = 57
                .Width         = 202
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblDigiMaxs", "Label")
            WITH loc_oCnt.lbl_4c_LblDigiMaxs
                .Caption   = "D" + CHR(237) + "gitos :"
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 6
                .Top       = 80
                .Width     = 41
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_DigiMaxs", "TextBox")
            WITH loc_oCnt.txt_4c_DigiMaxs
                .FontName            = "Tahoma"
                .InputMask           = "99"
                .Left                = 6
                .SpecialEffect       = 1
                .Top                 = 95
                .Width               = 25
                .Enabled             = .F.
                .DisabledBackColor   = RGB(255, 255, 255)
                .DisabledForeColor   = RGB(0, 0, 0)
                .Value               = 0
                .Visible             = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblOrdCompos", "Label")
            WITH loc_oCnt.lbl_4c_LblOrdCompos
                .Caption   = "Ordem :"
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 85
                .Top       = 80
                .Width     = 41
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_OrdCompos", "TextBox")
            WITH loc_oCnt.txt_4c_OrdCompos
                .FontName            = "Tahoma"
                .InputMask           = "99"
                .Left                = 85
                .SpecialEffect       = 1
                .Top                 = 95
                .Width               = 25
                .Enabled             = .F.
                .DisabledBackColor   = RGB(255, 255, 255)
                .DisabledForeColor   = RGB(0, 0, 0)
                .Value               = 0
                .Visible             = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblCasas", "Label")
            WITH loc_oCnt.lbl_4c_LblCasas
                .Caption   = "Casas :"
                .FontBold  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 165
                .Top       = 80
                .Width     = 38
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("txt_4c_Casas", "TextBox")
            WITH loc_oCnt.txt_4c_Casas
                .FontName            = "Tahoma"
                .InputMask           = "99"
                .Left                = 165
                .SpecialEffect       = 1
                .Top                 = 95
                .Width               = 25
                .Enabled             = .F.
                .DisabledBackColor   = RGB(255, 255, 255)
                .DisabledForeColor   = RGB(0, 0, 0)
                .Value               = 0
                .Visible             = .T.
            ENDWITH

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar p" + CHR(225) + "gina Composi" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loc_oErro.Message, "FormProduto.ConfigurarPgpgComposicao")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarPgPgDadosConsP - Configura Page5 "Consumo" do pgf_4c_Dados
    * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP
    * GrdCons: 9 colunas (top=149, left=6, width=987, height=347)
    * grDTEMP: 2 colunas (top=500, left=821, width=172, height=107)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPg)
        LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oErro
        TRY
            loc_oPg = par_oPg
            loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Cursors placeholder (ANTES de RecordSource - REGRA CRITICA VFP9)
            IF !USED("cursor_4c_GrdConsP")
                CREATE CURSOR cursor_4c_GrdConsP ( ;
                    mats      C(14), qtds     N(8,3),  unicompos C(3), ;
                    grupos    C(10), dscgrp   C(20),   ordems    N(2,0), ;
                    qtscons   N(8,3), cats    C(6),    dcats     C(15))
            ENDIF
            IF !USED("cursor_4c_GrDTEMP")
                CREATE CURSOR cursor_4c_GrDTEMP (grupos C(10), tempopct N(8,3))
            ENDIF

            *-- grd_4c_GrdConsP: grade principal de consumo por processo (9 colunas)
            *-- Original GrdCons: top=149, left=6, width=987, height=347, columnCount=9
            loc_oPg.AddObject("grd_4c_GrdConsP", "Grid")
            WITH loc_oPg.grd_4c_GrdConsP
                .Top        = 149
                .Left       = 6
                .Width      = 987
                .Height     = 347
                .FontName   = "Tahoma"
                .FontSize   = 8
                .RecordMark = .F.
                .DeleteMark = .F.
                .RowHeight  = 18
                .ScrollBars = 3
                .GridLines  = 3
                .GridLineColor      = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle     = 2
                .AllowHeaderSizing  = .F.
                .AllowRowSizing     = .F.
                .Visible    = .T.
            ENDWITH
            loc_oPg.grd_4c_GrdConsP.ColumnCount  = 9
            loc_oPg.grd_4c_GrdConsP.RecordSource = "cursor_4c_GrdConsP"
            loc_oGrid = loc_oPg.grd_4c_GrdConsP

            *-- Column1: Componente (mats C14) - somente leitura (When=.F. original)
            loc_oGrid.Column1.ControlSource    = "cursor_4c_GrdConsP.mats"
            loc_oGrid.Column1.Width            = 130
            loc_oGrid.Column1.ReadOnly         = .T.
            loc_oGrid.Column1.Movable          = .F.
            loc_oGrid.Column1.Resizable        = .F.
            loc_oGrid.Column1.Header1.Caption  = "Componente"

            *-- Column2: Qtde. (qtds N8.3) - somente leitura (When=.F. original)
            loc_oGrid.Column2.ControlSource    = "cursor_4c_GrdConsP.qtds"
            loc_oGrid.Column2.Width            = 65
            loc_oGrid.Column2.ReadOnly         = .T.
            loc_oGrid.Column2.Movable          = .F.
            loc_oGrid.Column2.Resizable        = .F.
            loc_oGrid.Column2.InputMask        = "9999.999"
            loc_oGrid.Column2.Header1.Caption  = "Qtde."

            *-- Column3: Uni (unicompos C3) - somente leitura (When=.F. original)
            loc_oGrid.Column3.ControlSource    = "cursor_4c_GrdConsP.unicompos"
            loc_oGrid.Column3.Width            = 38
            loc_oGrid.Column3.ReadOnly         = .T.
            loc_oGrid.Column3.Movable          = .F.
            loc_oGrid.Column3.Resizable        = .F.
            loc_oGrid.Column3.Header1.Caption  = "Uni"

            *-- Column4: Fase (grupos C10) - editavel, lookup SigCdGcr
            *-- Original When: Return(Inlist(ThisForm.pcEscolha,'INSERIR','ALTERAR'))
            loc_oGrid.Column4.ControlSource    = "cursor_4c_GrdConsP.grupos"
            loc_oGrid.Column4.Width            = 80
            loc_oGrid.Column4.ReadOnly         = .F.
            loc_oGrid.Column4.Movable          = .F.
            loc_oGrid.Column4.Resizable        = .F.
            loc_oGrid.Column4.Header1.Caption  = "Fase"
            BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdConsPCol4FaseValid")

            *-- Column5: Descricao fase (dscgrp C20) - editavel, lookup SigCdGcr por descrs
            *-- Original When: Return(Inlist(...) And Empty(Column4.Text1.Value))
            loc_oGrid.Column5.ControlSource    = "cursor_4c_GrdConsP.dscgrp"
            loc_oGrid.Column5.Width            = 180
            loc_oGrid.Column5.ReadOnly         = .F.
            loc_oGrid.Column5.Movable          = .F.
            loc_oGrid.Column5.Resizable        = .F.
            loc_oGrid.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
            BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GrdConsPCol5DescFaseValid")

            *-- Column6: Ord. (ordems N2) - somente leitura (When=.F. original)
            loc_oGrid.Column6.ControlSource    = "cursor_4c_GrdConsP.ordems"
            loc_oGrid.Column6.Width            = 40
            loc_oGrid.Column6.ReadOnly         = .T.
            loc_oGrid.Column6.Movable          = .F.
            loc_oGrid.Column6.Resizable        = .F.
            loc_oGrid.Column6.InputMask        = "99"
            loc_oGrid.Column6.Header1.Caption  = "Ord."

            *-- Column7: Consumo (qtscons N8.3) - editavel
            *-- Original When: Return Inlist(ThisForm.pcEscolha,'INSERIR','ALTERAR')
            loc_oGrid.Column7.ControlSource    = "cursor_4c_GrdConsP.qtscons"
            loc_oGrid.Column7.Width            = 75
            loc_oGrid.Column7.ReadOnly         = .F.
            loc_oGrid.Column7.Movable          = .F.
            loc_oGrid.Column7.Resizable        = .F.
            loc_oGrid.Column7.InputMask        = "9999.999"
            loc_oGrid.Column7.Header1.Caption  = "Consumo"

            *-- Column8: Cat. (cats C6) - editavel, lookup SigCdCat por Cods
            *-- Original When: Return(InList(ThisForm.pcEscolha,"INSERIR","ALTERAR"))
            loc_oGrid.Column8.ControlSource    = "cursor_4c_GrdConsP.cats"
            loc_oGrid.Column8.Width            = 55
            loc_oGrid.Column8.ReadOnly         = .F.
            loc_oGrid.Column8.Movable          = .F.
            loc_oGrid.Column8.Resizable        = .F.
            loc_oGrid.Column8.Header1.Caption  = "Cat."
            BINDEVENT(loc_oGrid.Column8.Text1, "Valid", THIS, "GrdConsPCol8CatValid")

            *-- Column9: Descricao Cat. (dcats C15) - somente leitura
            loc_oGrid.Column9.ControlSource    = "cursor_4c_GrdConsP.dcats"
            loc_oGrid.Column9.Width            = 185
            loc_oGrid.Column9.ReadOnly         = .T.
            loc_oGrid.Column9.Movable          = .F.
            loc_oGrid.Column9.Resizable        = .F.
            loc_oGrid.Column9.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"

            BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdConsPAfterRowColChange")

            *-- lbl_4c_Label7: "Qtde Componentes :" (Say7: top=505, left=23, w=105)
            loc_oPg.AddObject("lbl_4c_Label7", "Label")
            WITH loc_oPg.lbl_4c_Label7
                .Caption   = "Qtde Componentes : "
                .Top       = 505
                .Left      = 23
                .Width     = 105
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Qtcpnt: quantidade componentes (Getqtcpnt: top=500, left=132, w=31, h=23)
            *-- Original When: Return InList(ThisForm.pcEscolha,'INSERIR','ALTERAR')
            loc_oPg.AddObject("txt_4c_Qtcpnt", "TextBox")
            WITH loc_oPg.txt_4c_Qtcpnt
                .Top               = 500
                .Left              = 132
                .Width             = 31
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .SpecialEffect     = 1
                .InputMask         = "99"
                .Value             = 0
                .Enabled           = .F.
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .Visible           = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Qtcpnt, "When", THIS, "TxtQtcpntWhen")

            *-- chk_4c_ChkFund: (chkFund: top=525, left=11, w=182, h=15)
            *-- Original caption: "Nao Checar Cadastro de Fundicao"
            loc_oPg.AddObject("chk_4c_ChkFund", "CheckBox")
            WITH loc_oPg.chk_4c_ChkFund
                .Caption   = "N" + CHR(227) + "o Checar Cadastro de Fundi" + CHR(231) + CHR(227) + "o"
                .Top       = 525
                .Left      = 11
                .Width     = 182
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Value     = 0
                .Visible   = .T.
            ENDWITH
            BINDEVENT(loc_oPg.chk_4c_ChkFund, "Click", THIS, "ChkFundClick")

            *-- lbl_4c_Label1: "Tempo Producao por Agrupamento :" (Say1: top=501, left=643, w=176)
            loc_oPg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPg.lbl_4c_Label1
                .Caption   = "Tempo Produ" + CHR(231) + CHR(227) + "o por Agrupamento :"
                .Top       = 501
                .Left      = 643
                .Width     = 176
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- grd_4c_GrDTEMP: grade tempo producao por agrupamento
            *-- Original grDTEMP: top=500, left=821, w=172, h=107, 2 colunas (ambas readonly)
            loc_oPg.AddObject("grd_4c_GrDTEMP", "Grid")
            WITH loc_oPg.grd_4c_GrDTEMP
                .Top        = 500
                .Left       = 821
                .Width      = 172
                .Height     = 107
                .FontName   = "Tahoma"
                .FontSize   = 8
                .RecordMark = .F.
                .DeleteMark = .F.
                .RowHeight  = 18
                .ScrollBars = 2
                .GridLines  = 3
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .Visible    = .T.
            ENDWITH
            loc_oPg.grd_4c_GrDTEMP.ColumnCount  = 2
            loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
            loc_oGrid2 = loc_oPg.grd_4c_GrDTEMP

            *-- Column1: Agrupamento (grupos C10) - somente leitura (When=.F. original)
            loc_oGrid2.Column1.ControlSource    = "cursor_4c_GrDTEMP.grupos"
            loc_oGrid2.Column1.Width            = 100
            loc_oGrid2.Column1.ReadOnly         = .T.
            loc_oGrid2.Column1.Header1.Caption  = "Agrupamento"

            *-- Column2: Tempo % (tempopct N8.3) - somente leitura (When=.F. original)
            loc_oGrid2.Column2.ControlSource    = "cursor_4c_GrDTEMP.tempopct"
            loc_oGrid2.Column2.Width            = 72
            loc_oGrid2.Column2.ReadOnly         = .T.
            loc_oGrid2.Column2.InputMask        = "9999.99"
            loc_oGrid2.Column2.Header1.Caption  = "Tempo %"

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar p" + CHR(225) + "gina Consumo por Processo:" + ;
                CHR(13) + loc_oErro.Message, "FormProduto.ConfigurarPgPgDadosConsP")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Handlers de BINDEVENT para pgDadosConsP (Page5)
    * Todos PUBLIC - requerido pelo BINDEVENT
    *===========================================================================

    *-- Controla acesso ao campo Qtde Componentes
    *-- Original When: Return InList(ThisForm.pcEscolha,'INSERIR','ALTERAR')
    PROCEDURE TxtQtcpntWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *-- Checkbox "Nao Checar Cadastro de Fundicao"
    PROCEDURE ChkFundClick()
        *-- Salvo no BO via FormParaBO ao salvar o registro
    ENDPROC

    *-- Column4 (Fase/Grupos): Valid - lookup SigCdGcr por codigos
    *-- Original: fwBuscaInt crSigCdPrf GrpOrdem (Grupos+Ordems)
    PROCEDURE GrdConsPCol4FaseValid()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        LOCAL loc_cGrupos, loc_nRet, loc_lSucesso, loException
        loc_lSucesso = .T.
        TRY
            IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
                loc_cGrupos = ALLTRIM(cursor_4c_GrdConsP.grupos)
                IF !EMPTY(loc_cGrupos)
                    loc_nRet = SQLEXEC(gnConnHandle, ;
                        "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cGrupos), ;
                        "cursor_4c_GcrFase")
                    IF loc_nRet > 0 AND USED("cursor_4c_GcrFase") AND !EOF("cursor_4c_GcrFase")
                        SELECT cursor_4c_GrdConsP
                        REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(cursor_4c_GcrFase.descrs)
                        IF USED("cursor_4c_GcrFase")
                            USE IN cursor_4c_GcrFase
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_GcrFase")
                            USE IN cursor_4c_GcrFase
                        ENDIF
                        THIS.AbrirBuscaFaseConsP()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_GcrFase")
                USE IN cursor_4c_GcrFase
            ENDIF
            MostrarErro("Erro ao validar Fase:" + CHR(13) + loException.Message, ;
                "FormProduto.GrdConsPCol4FaseValid")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *-- Column5 (Descricao Fase/dscgrp): Valid - lookup SigCdGcr por descrs
    *-- Original: fwBuscaInt crSigCdPrf Descrs
    PROCEDURE GrdConsPCol5DescFaseValid()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        LOCAL loc_cDescrs, loc_nRet, loc_lSucesso, loException
        loc_lSucesso = .T.
        TRY
            IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
                loc_cDescrs = ALLTRIM(cursor_4c_GrdConsP.dscgrp)
                IF !EMPTY(loc_cDescrs)
                    loc_nRet = SQLEXEC(gnConnHandle, ;
                        "SELECT codigos, descrs FROM SigCdGcr WHERE descrs = " + EscaparSQL(loc_cDescrs), ;
                        "cursor_4c_GcrDescFase")
                    IF loc_nRet > 0 AND USED("cursor_4c_GcrDescFase") AND !EOF("cursor_4c_GcrDescFase")
                        SELECT cursor_4c_GrdConsP
                        REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(cursor_4c_GcrDescFase.codigos)
                        IF USED("cursor_4c_GcrDescFase")
                            USE IN cursor_4c_GcrDescFase
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_GcrDescFase")
                            USE IN cursor_4c_GcrDescFase
                        ENDIF
                        THIS.AbrirBuscaDescFaseConsP()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_GcrDescFase")
                USE IN cursor_4c_GcrDescFase
            ENDIF
            MostrarErro("Erro ao validar Descri" + CHR(231) + CHR(227) + "o Fase:" + ;
                CHR(13) + loException.Message, "FormProduto.GrdConsPCol5DescFaseValid")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *-- Column8 (Cat./cats): Valid - lookup SigCdCat por Cods
    *-- Original: fwBuscaExt SigCdCat CrListaRemota Cods
    PROCEDURE GrdConsPCol8CatValid()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        LOCAL loc_cCats, loc_nRet, loc_lSucesso, loException
        loc_lSucesso = .T.
        TRY
            IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
                loc_cCats = ALLTRIM(cursor_4c_GrdConsP.cats)
                IF EMPTY(loc_cCats)
                    SELECT cursor_4c_GrdConsP
                    REPLACE cursor_4c_GrdConsP.dcats WITH ""
                ELSE
                    loc_nRet = SQLEXEC(gnConnHandle, ;
                        "SELECT cods, descs FROM SigCdCat WHERE cods = " + EscaparSQL(loc_cCats), ;
                        "cursor_4c_CatBusca")
                    IF loc_nRet > 0 AND USED("cursor_4c_CatBusca") AND !EOF("cursor_4c_CatBusca")
                        SELECT cursor_4c_GrdConsP
                        REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(cursor_4c_CatBusca.descs)
                        IF USED("cursor_4c_CatBusca")
                            USE IN cursor_4c_CatBusca
                        ENDIF
                    ELSE
                        IF USED("cursor_4c_CatBusca")
                            USE IN cursor_4c_CatBusca
                        ENDIF
                        THIS.AbrirBuscaCatConsP()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_CatBusca")
                USE IN cursor_4c_CatBusca
            ENDIF
            MostrarErro("Erro ao validar Categoria:" + CHR(13) + loException.Message, ;
                "FormProduto.GrdConsPCol8CatValid")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *-- AfterRowColChange: atualiza colunas de descricao ao navegar no grid
    PROCEDURE GrdConsPAfterRowColChange(par_nColIndex)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_nRet, loException
        TRY
            IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
                *-- Atualizar dcats (Column9) se cats (Column8) foi preenchido
                IF !EMPTY(ALLTRIM(cursor_4c_GrdConsP.cats)) AND EMPTY(ALLTRIM(cursor_4c_GrdConsP.dcats))
                    loc_nRet = SQLEXEC(gnConnHandle, ;
                        "SELECT descs FROM SigCdCat WHERE cods = " + EscaparSQL(ALLTRIM(cursor_4c_GrdConsP.cats)), ;
                        "cursor_4c_GCatDesc")
                    IF loc_nRet > 0 AND USED("cursor_4c_GCatDesc") AND !EOF("cursor_4c_GCatDesc")
                        SELECT cursor_4c_GrdConsP
                        REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(cursor_4c_GCatDesc.descs)
                    ENDIF
                    IF USED("cursor_4c_GCatDesc")
                        USE IN cursor_4c_GCatDesc
                    ENDIF
                ENDIF
                *-- Atualizar dscgrp (Column5) se grupos (Column4) foi preenchido e dscgrp vazio
                IF !EMPTY(ALLTRIM(cursor_4c_GrdConsP.grupos)) AND EMPTY(ALLTRIM(cursor_4c_GrdConsP.dscgrp))
                    loc_nRet = SQLEXEC(gnConnHandle, ;
                        "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(ALLTRIM(cursor_4c_GrdConsP.grupos)), ;
                        "cursor_4c_GFaseDesc")
                    IF loc_nRet > 0 AND USED("cursor_4c_GFaseDesc") AND !EOF("cursor_4c_GFaseDesc")
                        SELECT cursor_4c_GrdConsP
                        REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(cursor_4c_GFaseDesc.descrs)
                    ENDIF
                    IF USED("cursor_4c_GFaseDesc")
                        USE IN cursor_4c_GFaseDesc
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_GCatDesc")
                USE IN cursor_4c_GCatDesc
            ENDIF
            IF USED("cursor_4c_GFaseDesc")
                USE IN cursor_4c_GFaseDesc
            ENDIF
            MostrarErro("Erro ao atualizar descri" + CHR(231) + CHR(245) + "es do grid ConsP:" + ;
                CHR(13) + loException.Message, "FormProduto.GrdConsPAfterRowColChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaFaseConsP - Lookup de fase/processo para Column4 de GrdConsP
    * Tabela: SigCdGcr (codigos C10, descrs C40)
    *===========================================================================
    PROCEDURE AbrirBuscaFaseConsP()
        LOCAL loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
                loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.grupos)

                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE " + ;
                    EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
                    "cursor_4c_FaseBusca")

                IF loc_nRet <= 0 OR !USED("cursor_4c_FaseBusca") OR EOF("cursor_4c_FaseBusca")
                    IF USED("cursor_4c_FaseBusca")
                        USE IN cursor_4c_FaseBusca
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
                        "cursor_4c_FaseBusca")
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_FaseBusca", "codigos", "descrs", ;
                        "Buscar Fase/Processo")
                    loc_oBusca.Mostrar()
                    IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
                        SELECT cursor_4c_GrdConsP
                        REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
                        REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    ENDIF
                    loc_oBusca = .NULL.
                ENDIF

                IF USED("cursor_4c_FaseBusca")
                    USE IN cursor_4c_FaseBusca
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_FaseBusca")
                USE IN cursor_4c_FaseBusca
            ENDIF
            MostrarErro("Erro ao buscar Fase:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaFaseConsP")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaDescFaseConsP - Lookup de fase por descricao para Column5 de GrdConsP
    * Tabela: SigCdGcr (codigos C10, descrs C40)
    *===========================================================================
    PROCEDURE AbrirBuscaDescFaseConsP()
        LOCAL loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
                loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.dscgrp)

                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT descrs, codigos FROM SigCdGcr WHERE descrs LIKE " + ;
                    EscaparSQL(loc_cValAtual + "%") + " ORDER BY descrs", ;
                    "cursor_4c_DescFaseBusca")

                IF loc_nRet <= 0 OR !USED("cursor_4c_DescFaseBusca") OR EOF("cursor_4c_DescFaseBusca")
                    IF USED("cursor_4c_DescFaseBusca")
                        USE IN cursor_4c_DescFaseBusca
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT descrs, codigos FROM SigCdGcr ORDER BY descrs", ;
                        "cursor_4c_DescFaseBusca")
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_DescFaseBusca", "descrs", "codigos", ;
                        "Buscar Fase por Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Mostrar()
                    IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
                        SELECT cursor_4c_GrdConsP
                        REPLACE cursor_4c_GrdConsP.dscgrp WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
                        REPLACE cursor_4c_GrdConsP.grupos WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    ENDIF
                    loc_oBusca = .NULL.
                ENDIF

                IF USED("cursor_4c_DescFaseBusca")
                    USE IN cursor_4c_DescFaseBusca
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_DescFaseBusca")
                USE IN cursor_4c_DescFaseBusca
            ENDIF
            MostrarErro("Erro ao buscar Fase por descri" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loException.Message, "FormProduto.AbrirBuscaDescFaseConsP")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaCatConsP - Lookup de categoria para Column8 de GrdConsP
    * Tabela: SigCdCat (cods C6, descs C15)
    *===========================================================================
    PROCEDURE AbrirBuscaCatConsP()
        LOCAL loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            IF USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
                loc_cValAtual = ALLTRIM(cursor_4c_GrdConsP.cats)

                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT cods, descs FROM SigCdCat WHERE cods LIKE " + ;
                    EscaparSQL(loc_cValAtual + "%") + " ORDER BY cods", ;
                    "cursor_4c_CatBusca")

                IF loc_nRet <= 0 OR !USED("cursor_4c_CatBusca") OR EOF("cursor_4c_CatBusca")
                    IF USED("cursor_4c_CatBusca")
                        USE IN cursor_4c_CatBusca
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCat ORDER BY cods", ;
                        "cursor_4c_CatBusca")
                ENDIF

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_CatBusca", "cods", "descs", "Buscar Categoria")
                    loc_oBusca.Mostrar()
                    IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdConsP") AND !EOF("cursor_4c_GrdConsP")
                        SELECT cursor_4c_GrdConsP
                        REPLACE cursor_4c_GrdConsP.cats  WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
                        REPLACE cursor_4c_GrdConsP.dcats WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    ENDIF
                    loc_oBusca = .NULL.
                ENDIF

                IF USED("cursor_4c_CatBusca")
                    USE IN cursor_4c_CatBusca
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_CatBusca")
                USE IN cursor_4c_CatBusca
            ENDIF
            MostrarErro("Erro ao buscar Categoria:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaCatConsP")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Handlers de BINDEVENT para pgCusto (Page2)
    * Todos PUBLIC - requerido pelo BINDEVENT
    *===========================================================================

    PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            IF !USED("cursor_4c_GrdCompo") OR EOF("cursor_4c_GrdCompo")
                RETURN
            ENDIF
            IF !EMPTY(cursor_4c_GrdCompo.cpros)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT dpros FROM SigCdPro WHERE cpros = '" + ;
                    EscaparSQL(ALLTRIM(cursor_4c_GrdCompo.cpros)) + "", ;
                    "cursor_4c_DescCusto")
                IF loc_nRet > 0 AND USED("cursor_4c_DescCusto") AND !EOF("cursor_4c_DescCusto")
                    IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
                        loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_DescCusto.dpros)
                    ENDIF
                    USE IN cursor_4c_DescCusto
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
                    loc_oPg.txt_4c_Desc.Value = ""
                ENDIF
            ENDIF
            IF !EMPTY(cursor_4c_GrdCompo.cpros)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT b.dgrus FROM SigCdPro a " + ;
                    "INNER JOIN SigCdGrp b ON a.cgrus = b.cgrus " + ;
                    "WHERE a.cpros = " + EscaparSQL(ALLTRIM(cursor_4c_GrdCompo.cpros)) + "", ;
                    "cursor_4c_GruCusto")
                IF loc_nRet > 0 AND USED("cursor_4c_GruCusto") AND !EOF("cursor_4c_GruCusto")
                    IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
                        loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_GruCusto.dgrus)
                    ENDIF
                    USE IN cursor_4c_GruCusto
                ENDIF
            ELSE
                IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
                    loc_oPg.txt_4c_DGruCompos.Value = ""
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_DescCusto")
                USE IN cursor_4c_DescCusto
            ENDIF
            IF USED("cursor_4c_GruCusto")
                USE IN cursor_4c_GruCusto
            ENDIF
            MostrarErro("Erro ao atualizar detalhes do custo:" + CHR(13) + loException.Message, ;
                "FormProduto.GrdCustoAfterRowColChange")
        ENDTRY
    ENDPROC

    PROCEDURE CmgCustoClick()
        LOCAL loc_oPg, loc_nBotao
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
        loc_nBotao = loc_oPg.cmg_4c_CmdgCusto.Value
        DO CASE
        CASE loc_nBotao = 1
            THIS.CmdCustoInserirClick()
        CASE loc_nBotao = 2
            THIS.CmdCustoExcluirClick()
        ENDCASE
    ENDPROC

    PROCEDURE CmdCustoInserirClick()
        LOCAL loException
        TRY
            IF !USED("cursor_4c_GrdCompo")
                RETURN
            ENDIF
            SELECT cursor_4c_GrdCompo
            APPEND BLANK
        CATCH TO loException
            MostrarErro("Erro ao inserir item de custo:" + CHR(13) + loException.Message, ;
                "FormProduto.CmdCustoInserirClick")
        ENDTRY
    ENDPROC

    PROCEDURE CmdCustoExcluirClick()
        LOCAL loc_lConfirma, loException
        TRY
            IF !USED("cursor_4c_GrdCompo") OR EOF("cursor_4c_GrdCompo")
                RETURN
            ENDIF
            loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste item de custo?")
            IF loc_lConfirma
                SELECT cursor_4c_GrdCompo
                DELETE
                IF !EOF()
                    SKIP
                    SKIP -1
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir item de custo:" + CHR(13) + loException.Message, ;
                "FormProduto.CmdCustoExcluirClick")
        ENDTRY
    ENDPROC

    PROCEDURE CboTiposCustoInteractiveChange()
        *-- Filtra o grid de custo pelo tipo selecionado no combo
    ENDPROC

    *===========================================================================
    * Handlers de BINDEVENT para pgComposicao
    * Todos PUBLIC - requerido pelo BINDEVENT
    *===========================================================================

    PROCEDURE GrdCompoAfterRowColChange(par_nColIndex)
        *-- Atualiza campos de detalhes ao navegar no grid de composicao principal
    ENDPROC

    PROCEDURE GrdSubCpAfterRowColChange(par_nColIndex)
        *-- Atualiza campos de detalhes ao navegar no grid de subcomposicao
    ENDPROC

    PROCEDURE CmgCompoClick()
        LOCAL loc_oPg, loc_nBotao
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        loc_nBotao = loc_oPg.cmg_4c_CmdgCompo.Value
        DO CASE
        CASE loc_nBotao = 1
            THIS.CmdCompoInserirClick()
        CASE loc_nBotao = 2
            THIS.CmdCompoExcluirClick()
        CASE loc_nBotao = 3
            THIS.CmdCompoAtualizaClick()
        CASE loc_nBotao = 4
            THIS.CmdCompoPrecoClick()
        CASE loc_nBotao = 5
            THIS.CmdAtuPesosClick()
        ENDCASE
    ENDPROC

    PROCEDURE CmgSubCpClick()
        LOCAL loc_oPg, loc_nBotao
        loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        loc_nBotao = loc_oPg.cmg_4c_CmdgSubCp.Value
        DO CASE
        CASE loc_nBotao = 1
            THIS.CmdSubCpInserirClick()
        CASE loc_nBotao = 2
            THIS.CmdSubCpExcluirClick()
        ENDCASE
    ENDPROC

    PROCEDURE CmdCompoInserirClick()
        MsgInfo("Inserir item de composi" + CHR(231) + CHR(227) + "o - a implementar")
    ENDPROC

    PROCEDURE CmdCompoExcluirClick()
        MsgInfo("Excluir item de composi" + CHR(231) + CHR(227) + "o - a implementar")
    ENDPROC

    PROCEDURE CmdCompoAtualizaClick()
        MsgInfo("Atualizar custo da composi" + CHR(231) + CHR(227) + "o - a implementar")
    ENDPROC

    PROCEDURE CmdCompoPrecoClick()
        MsgInfo("Atualizar pre" + CHR(231) + "o da composi" + CHR(231) + CHR(227) + "o - a implementar")
    ENDPROC

    PROCEDURE CmdAtuPesosClick()
        MsgInfo("Atualizar pesos - a implementar")
    ENDPROC

    PROCEDURE CmdSubCpInserirClick()
        MsgInfo("Inserir subcomponente - a implementar")
    ENDPROC

    PROCEDURE CmdSubCpExcluirClick()
        MsgInfo("Excluir subcomponente - a implementar")
    ENDPROC

    PROCEDURE ChkLiberaCustoClick()
        *-- Alterna bloqueio de edicao dos campos de custo
    ENDPROC

    PROCEDURE ChkLiberaVendaClick()
        *-- Alterna bloqueio de edicao dos campos de venda
    ENDPROC

    PROCEDURE ChkPlanCusClick()
        *-- Acao de planejamento de custo
    ENDPROC

    PROCEDURE ChkPlanVenClick()
        *-- Acao de planejamento de venda
    ENDPROC

    PROCEDURE ChkPvendaClick()
        *-- Copia preco ideal para preco atual de venda
    ENDPROC

    PROCEDURE CmdCalcValsClick()
        MsgInfo("Calcular valores pelas moedas - a implementar")
    ENDPROC

    PROCEDURE TxtObsOFsWhen()
        *-- Controla acesso ao campo ObsOFs
    ENDPROC

    PROCEDURE TxtObsOFsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        *-- Processa teclas no campo ObsOFs
    ENDPROC

    *-- Validacoes/lookups de moeda (SigCdMoe: cmoeds, dmoeds)

    PROCEDURE ValidarMoec()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        IF !PEMSTATUS(loc_oPg, "txt_4c_Moec", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moec.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        THIS.AbrirBuscaMoedaCompo("txt_4c_Moec")
    ENDPROC

    PROCEDURE TxtMoecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoec()
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoepc()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        IF !PEMSTATUS(loc_oPg, "txt_4c_Moepc", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moepc.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        THIS.AbrirBuscaMoedaCompo("txt_4c_Moepc")
    ENDPROC

    PROCEDURE TxtMoepcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoepc()
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoecusf()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        IF !PEMSTATUS(loc_oPg, "txt_4c_Moecusf", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moecusf.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        THIS.AbrirBuscaMoedaCompo("txt_4c_Moecusf")
    ENDPROC

    PROCEDURE TxtMoecusfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoecusf()
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoeda()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        IF !PEMSTATUS(loc_oPg, "txt_4c_Moeda", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moeda.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        THIS.AbrirBuscaMoedaCompo("txt_4c_Moeda")
    ENDPROC

    PROCEDURE TxtMoedaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoeda()
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoepv()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        IF !PEMSTATUS(loc_oPg, "txt_4c_Moepv", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moepv.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        THIS.AbrirBuscaMoedaCompo("txt_4c_Moepv")
    ENDPROC

    PROCEDURE TxtMoepvKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoepv()
        ENDIF
    ENDPROC

    PROCEDURE ValidarMoev()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        IF !PEMSTATUS(loc_oPg, "txt_4c_Moev", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Moev.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        THIS.AbrirBuscaMoedaCompo("txt_4c_Moev")
    ENDPROC

    PROCEDURE TxtMoevKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMoev()
        ENDIF
    ENDPROC

    PROCEDURE ValidarMftio()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        IF !PEMSTATUS(loc_oPg, "txt_4c_Mftio", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Mftio.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        THIS.AbrirBuscaMoedaCompo("txt_4c_Mftio")
    ENDPROC

    PROCEDURE TxtMftioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMftio()
        ENDIF
    ENDPROC

    *-- Validacoes/lookups de feitio/markup (SigPrFti: cods, descs)

    PROCEDURE ValidarFtio()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        IF !PEMSTATUS(loc_oPg, "txt_4c_Ftio", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ftio.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        THIS.AbrirBuscaFeitioCompo("txt_4c_Ftio")
    ENDPROC

    PROCEDURE TxtFtioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarFtio()
        ENDIF
    ENDPROC

    PROCEDURE ValidarCmkpc()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        IF !PEMSTATUS(loc_oPg, "txt_4c_Cmkpc", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cmkpc.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        THIS.AbrirBuscaFeitioCompo("txt_4c_Cmkpc")
    ENDPROC

    PROCEDURE TxtCmkpcKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCmkpc()
        ENDIF
    ENDPROC

    *-- Validacao/lookup de status (SigCdPst: cods, descs)

    PROCEDURE ValidarStatus()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod
        loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
        IF !PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
            RETURN
        ENDIF
        loc_cCod = ALLTRIM(loc_oPg.txt_4c_Status.Value)
        IF EMPTY(loc_cCod)
            RETURN
        ENDIF
        THIS.AbrirBuscaStatusCompo()
    ENDPROC

    PROCEDURE TxtStatusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarStatus()
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirBuscaMoedaCompo - Lookup de moeda para campos da pgComposicao
    * Pattern A canonico: SQL no caller, DefinirCursor, Mostrar
    *===========================================================================
    PROCEDURE AbrirBuscaMoedaCompo(par_cCampoDestino)
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
                loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY cmoeds", ;
                "cursor_4c_MoedaBusca")

            IF loc_nRet <= 0 OR !USED("cursor_4c_MoedaBusca") OR EOF("cursor_4c_MoedaBusca")
                IF USED("cursor_4c_MoedaBusca")
                    USE IN cursor_4c_MoedaBusca
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT cmoeds, dmoeds FROM SigCdMoe ORDER BY cmoeds", ;
                    "cursor_4c_MoedaBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_MoedaBusca"
                loc_oBusca.DefinirCursor("cursor_4c_MoedaBusca", "cmoeds", "dmoeds", "Buscar Moeda")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
                    loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_MoedaBusca")
                USE IN cursor_4c_MoedaBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_MoedaBusca")
                USE IN cursor_4c_MoedaBusca
            ENDIF
            MostrarErro("Erro ao buscar moeda:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaMoedaCompo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaFeitioCompo - Lookup de feitio/markup para campos da pgComposicao
    * SigPrFti: cods (char 2), descs (char 20)
    *===========================================================================
    PROCEDURE AbrirBuscaFeitioCompo(par_cCampoDestino)
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
                loc_cValAtual = ALLTRIM(loc_oPg.&par_cCampoDestino..Value)
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cods, descs FROM SigPrFti WHERE cods LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
                "cursor_4c_FeitioBusca")

            IF loc_nRet <= 0 OR !USED("cursor_4c_FeitioBusca") OR EOF("cursor_4c_FeitioBusca")
                IF USED("cursor_4c_FeitioBusca")
                    USE IN cursor_4c_FeitioBusca
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigPrFti ORDER BY cods", ;
                    "cursor_4c_FeitioBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_FeitioBusca"
                loc_oBusca.DefinirCursor("cursor_4c_FeitioBusca", "cods", "descs", "Buscar Feitio/MKP")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, par_cCampoDestino, 5)
                    loc_oPg.&par_cCampoDestino..Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_FeitioBusca")
                USE IN cursor_4c_FeitioBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_FeitioBusca")
                USE IN cursor_4c_FeitioBusca
            ENDIF
            MostrarErro("Erro ao buscar feitio:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaFeitioCompo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AbrirBuscaStatusCompo - Lookup de status para campo txt_4c_Status
    * SigCdPst: cods (char 3), descs (char 20)
    *===========================================================================
    PROCEDURE AbrirBuscaStatusCompo()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
                loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Status.Value)
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cods, descs FROM SigCdPst WHERE cods LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", ;
                "cursor_4c_StatusBusca")

            IF loc_nRet <= 0 OR !USED("cursor_4c_StatusBusca") OR EOF("cursor_4c_StatusBusca")
                IF USED("cursor_4c_StatusBusca")
                    USE IN cursor_4c_StatusBusca
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdPst ORDER BY cods", ;
                    "cursor_4c_StatusBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.this_cCursorDestino = "cursor_4c_StatusBusca"
                loc_oBusca.DefinirCursor("cursor_4c_StatusBusca", "cods", "descs", "Buscar Status")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND PEMSTATUS(loc_oPg, "txt_4c_Status", 5)
                    loc_oPg.txt_4c_Status.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_StatusBusca")
                USE IN cursor_4c_StatusBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_StatusBusca")
                USE IN cursor_4c_StatusBusca
            ENDIF
            MostrarErro("Erro ao buscar status:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaStatusCompo")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarPgPgDadosFaseP - Configura Page4 "Processos" do pgf_4c_Dados
    * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosFaseP
    * GradFase: 5 colunas (top=129, left=527, width=420, height=168)
    * grdMatrizes: 3 colunas (top=305, left=527, width=245, height=192)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPg)
        LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oErro
        TRY
            loc_oPg = par_oPg
            loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Cursors placeholder (ANTES de RecordSource - REGRA CRITICA VFP9)
            IF !USED("cursor_4c_GradFase")
                CREATE CURSOR cursor_4c_GradFase ( ;
                    cidchaves C(20), ordems N(2,0), grupos C(10), ;
                    minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
            ENDIF
            IF !USED("cursor_4c_GrdMatrizes")
                CREATE CURSOR cursor_4c_GrdMatrizes ( ;
                    cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
            ENDIF

            *-- shp_4c_Fig: Shape moldura da figura do produto
            *-- Original shpFig: top=129, left=231, width=244, height=148
            loc_oPg.AddObject("shp_4c_Fig", "Shape")
            WITH loc_oPg.shp_4c_Fig
                .Top           = 129
                .Left          = 231
                .Width         = 244
                .Height        = 148
                .BackStyle     = 0
                .BorderWidth   = 2
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- img_4c_ImgFig: Imagem da figura do produto
            *-- Original ImgFigJpg: top=130, left=232, width=241, height=146
            loc_oPg.AddObject("img_4c_ImgFig", "Image")
            WITH loc_oPg.img_4c_ImgFig
                .Top     = 130
                .Left    = 232
                .Width   = 241
                .Height  = 146
                .Stretch = 1
                .Visible = .T.
            ENDWITH

            *-- cmd_4c_CmdFicha: Ficha Tecnica
            *-- Original CmdFicha: top=129, left=482, width=40, height=40
            loc_oPg.AddObject("cmd_4c_CmdFicha", "CommandButton")
            WITH loc_oPg.cmd_4c_CmdFicha
                .Top             = 129
                .Left            = 482
                .Width           = 40
                .Height          = 40
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
                .PicturePosition = 14
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Ficha T" + CHR(233) + "cnica"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_CmdFicha, "Click", THIS, "CmdFichaFasePClick")

            *-- cmd_4c_Figura: Capturar imagem do produto (arquivo)
            *-- Original cmdgFigura: top=169, left=482, width=40, height=40
            loc_oPg.AddObject("cmd_4c_Figura", "CommandButton")
            WITH loc_oPg.cmd_4c_Figura
                .Top             = 169
                .Left            = 482
                .Width           = 40
                .Height          = 40
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "geral_picture_26.jpg"
                .PicturePosition = 14
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Capturar Imagem do Produto"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_Figura, "Click", THIS, "CmdFiguraFasePClick")

            *-- cmd_4c_FigCam: Capturar imagem via WebCam
            *-- Original cmdgFigCam: top=209, left=482, width=40, height=40
            loc_oPg.AddObject("cmd_4c_FigCam", "CommandButton")
            WITH loc_oPg.cmd_4c_FigCam
                .Top             = 209
                .Left            = 482
                .Width           = 40
                .Height          = 40
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
                .PicturePosition = 14
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Capturar Imagem do Produto - WebCam"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_FigCam, "Click", THIS, "CmdFigCamFasePClick")

            *-- grd_4c_GradFase: Grade de Fases de Producao (5 colunas)
            *-- Original GradFase: top=129, left=527, width=420, height=168, columnCount=5
            loc_oPg.AddObject("grd_4c_GradFase", "Grid")
            WITH loc_oPg.grd_4c_GradFase
                .Top               = 129
                .Left              = 527
                .Width             = 420
                .Height            = 168
                .FontName          = "Tahoma"
                .FontSize          = 8
                .RecordMark        = .F.
                .DeleteMark        = .F.
                .HeaderHeight      = 20
                .RowHeight         = 18
                .ScrollBars        = 2
                .GridLines         = 3
                .GridLineColor     = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle    = 2
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .Visible           = .T.
            ENDWITH
            loc_oPg.grd_4c_GradFase.ColumnCount  = 5
            loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
            loc_oGrid = loc_oPg.grd_4c_GradFase

            *-- Column1: Ordem (ordems N2,0) - width=45
            loc_oGrid.Column1.ControlSource   = "cursor_4c_GradFase.ordems"
            loc_oGrid.Column1.Width           = 45
            loc_oGrid.Column1.ReadOnly        = .F.
            loc_oGrid.Column1.Movable         = .F.
            loc_oGrid.Column1.Resizable       = .F.
            loc_oGrid.Column1.Header1.Caption = "Ordem"
            BINDEVENT(loc_oGrid.Column1.Text1, "Valid", THIS, "GrdFaseCol1OrdValid")

            *-- Column2: Fase/Grupo (grupos C10) - lookup SigCdGcr, width=80
            loc_oGrid.Column2.ControlSource   = "cursor_4c_GradFase.grupos"
            loc_oGrid.Column2.Width           = 80
            loc_oGrid.Column2.ReadOnly        = .F.
            loc_oGrid.Column2.Movable         = .F.
            loc_oGrid.Column2.Resizable       = .F.
            loc_oGrid.Column2.Header1.Caption = "Fase"
            BINDEVENT(loc_oGrid.Column2.Text1, "Valid", THIS, "GrdFaseCol2FaseValid")

            *-- Column3: Utilizacao (minutos N9,1) - width=70
            loc_oGrid.Column3.ControlSource   = "cursor_4c_GradFase.minutos"
            loc_oGrid.Column3.Width           = 70
            loc_oGrid.Column3.ReadOnly        = .F.
            loc_oGrid.Column3.Movable         = .F.
            loc_oGrid.Column3.Resizable       = .F.
            loc_oGrid.Column3.InputMask       = "99,999.9"
            loc_oGrid.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"

            *-- Column4: Uni. Produtiva (uniprdts C10) - lookup SigCdUpd, width=84
            loc_oGrid.Column4.ControlSource   = "cursor_4c_GradFase.uniprdts"
            loc_oGrid.Column4.Width           = 84
            loc_oGrid.Column4.ReadOnly        = .F.
            loc_oGrid.Column4.Movable         = .F.
            loc_oGrid.Column4.Resizable       = .F.
            loc_oGrid.Column4.Header1.Caption = "Uni. Produtiva"
            BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdFaseCol4UniPrdtValid")

            *-- Column5: Material (matprdts C15) - lookup SigOpOpt, width=115
            loc_oGrid.Column5.ControlSource   = "cursor_4c_GradFase.matprdts"
            loc_oGrid.Column5.Width           = 115
            loc_oGrid.Column5.ReadOnly        = .F.
            loc_oGrid.Column5.Movable         = .F.
            loc_oGrid.Column5.Resizable       = .F.
            loc_oGrid.Column5.Header1.Caption = "Material"
            BINDEVENT(loc_oGrid.Column5.Text1, "Valid", THIS, "GrdFaseCol5MatPrdtValid")

            BINDEVENT(loc_oGrid, "BeforeRowColChange", THIS, "GrdFaseBeforeRowColChange")
            BINDEVENT(loc_oGrid, "AfterRowColChange",  THIS, "GrdFaseAfterRowColChange")

            *-- cmd_4c_InserirFase: Inserir fase na GradFase
            *-- Original inserir: top=129, left=950, width=40, height=40
            loc_oPg.AddObject("cmd_4c_InserirFase", "CommandButton")
            WITH loc_oPg.cmd_4c_InserirFase
                .Top             = 129
                .Left            = 950
                .Width           = 40
                .Height          = 40
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 14
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_InserirFase, "Click", THIS, "BtnInserirFaseClick")

            *-- cmd_4c_ExcluirFase: Excluir fase da GradFase
            *-- Original excluir: top=169, left=950, width=40, height=40
            loc_oPg.AddObject("cmd_4c_ExcluirFase", "CommandButton")
            WITH loc_oPg.cmd_4c_ExcluirFase
                .Top             = 169
                .Left            = 950
                .Width           = 40
                .Height          = 40
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .PicturePosition = 14
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Excluir"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_ExcluirFase, "Click", THIS, "BtnExcluirFaseClick")

            *-- cmd_4c_Alternativa: Alternativa de insercao na GradFase
            *-- Original Alternativa: top=209, left=950, width=40, height=40
            loc_oPg.AddObject("cmd_4c_Alternativa", "CommandButton")
            WITH loc_oPg.cmd_4c_Alternativa
                .Top             = 209
                .Left            = 950
                .Width           = 40
                .Height          = 40
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "geral_pn_cfg_26.jpg"
                .PicturePosition = 14
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Alternativa"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_Alternativa, "Click", THIS, "BtnAlternativaFaseClick")

            *--------------------------------------------------------------
            *-- Area esquerda: campos do produto (pesos, tamanhos, etc.)
            *--------------------------------------------------------------

            *-- lbl_4c_Say13: "Qtd. Min. Producao :"
            *-- Original Say13: top=133, left=32, width=102
            loc_oPg.AddObject("lbl_4c_Say13", "Label")
            WITH loc_oPg.lbl_4c_Say13
                .Caption   = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 32
                .Top       = 133
                .Width     = 102
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_QminFabs: Quantidade minima de fabricacao (getQmin)
            *-- Original getQmin: top=129, left=137, width=80, height=23, ControlSource=crSigCdPro.qtminFabs
            loc_oPg.AddObject("txt_4c_QminFabs", "TextBox")
            WITH loc_oPg.txt_4c_QminFabs
                .Top           = 129
                .Left          = 137
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999.99"
                .MaxLength     = 10
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Say5: "Garra :"
            *-- Original Say5: top=158, left=98, width=36
            loc_oPg.AddObject("lbl_4c_Say5", "Label")
            WITH loc_oPg.lbl_4c_Say5
                .Caption   = "Garra :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 98
                .Top       = 158
                .Width     = 36
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_CodGarras: Codigo de garra (getCodGarras)
            *-- Original getCodGarras: top=154, left=137, width=80, height=23, ControlSource=crSigCdPro.CodGarras
            loc_oPg.AddObject("txt_4c_CodGarras", "TextBox")
            WITH loc_oPg.txt_4c_CodGarras
                .Top           = 154
                .Left          = 137
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 10
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Say4: "Conquilha :"
            *-- Original Say4: top=183, left=78
            loc_oPg.AddObject("lbl_4c_Say4", "Label")
            WITH loc_oPg.lbl_4c_Say4
                .Caption   = "Conquilha :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 78
                .Top       = 183
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Conquilhas: Conquilha (getConquilha)
            *-- Original getConquilha: top=179, left=137, width=80, height=23, ControlSource=crSigCdPro.Conquilhas
            loc_oPg.AddObject("txt_4c_Conquilhas", "TextBox")
            WITH loc_oPg.txt_4c_Conquilhas
                .Top           = 179
                .Left          = 137
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 10
                .SpecialEffect = 1
                .Alignment     = 3
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_Conquilhas, "KeyPress", THIS, "ValidarConquilhaFaseP")

            *-- lbl_4c_Say9: "Peso Brilhante :"
            *-- Original Say9: top=208, left=57, width=77
            loc_oPg.AddObject("lbl_4c_Say9", "Label")
            WITH loc_oPg.lbl_4c_Say9
                .Caption   = "Peso Brilhante :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 57
                .Top       = 208
                .Width     = 77
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_PesoBris: Peso Brilhante (getPesoBris)
            *-- Original getPesoBris: top=204, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoBris
            loc_oPg.AddObject("txt_4c_PesoBris", "TextBox")
            WITH loc_oPg.txt_4c_PesoBris
                .Top           = 204
                .Left          = 137
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "99,999.999"
                .MaxLength     = 10
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Say10: "Peso Metal :"
            *-- Original Say10: top=233, left=73, width=61
            loc_oPg.AddObject("lbl_4c_Say10", "Label")
            WITH loc_oPg.lbl_4c_Say10
                .Caption   = "Peso Metal :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 73
                .Top       = 233
                .Width     = 61
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_PesoMetal: Peso Metal (getPesoMetal)
            *-- Original getPesoMetal: top=229, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoMetal
            loc_oPg.AddObject("txt_4c_PesoMetal", "TextBox")
            WITH loc_oPg.txt_4c_PesoMetal
                .Top           = 229
                .Left          = 137
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "99,999.999"
                .MaxLength     = 10
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Say8: "Peso Pedra :"
            *-- Original Say8: top=258, left=71, width=63
            loc_oPg.AddObject("lbl_4c_Say8", "Label")
            WITH loc_oPg.lbl_4c_Say8
                .Caption   = "Peso Pedra :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 71
                .Top       = 258
                .Width     = 63
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_PesoPdrs: Peso de Pedras (getPesoPdrs)
            *-- Original getPesoPdrs: top=254, left=137, width=80, height=23, ControlSource=crSigCdPro.PesoPdrs
            loc_oPg.AddObject("txt_4c_PesoPdrs", "TextBox")
            WITH loc_oPg.txt_4c_PesoPdrs
                .Top           = 254
                .Left          = 137
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "99,999.999"
                .MaxLength     = 10
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Say7: "Cor Padrao :"
            *-- Original Say7: top=283, left=71
            loc_oPg.AddObject("lbl_4c_Say7", "Label")
            WITH loc_oPg.lbl_4c_Say7
                .Caption   = "Cor Padr" + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 71
                .Top       = 283
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_CodCorsFP: Cor Padrao (getCor) - espelha Page1 CodCors
            *-- Original getCor: top=279, left=137, width=38, ControlSource=crSigCdPro.CodCors
            loc_oPg.AddObject("txt_4c_CodCorsFP", "TextBox")
            WITH loc_oPg.txt_4c_CodCorsFP
                .Top           = 279
                .Left          = 137
                .Width         = 38
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 4
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_CodCorsFP, "KeyPress", THIS, "ValidarCorFaseP")

            *-- chk_4c_CravCera: Cravacao em Cera (opc_CravCera)
            *-- Original opc_CravCera: top=283, left=180, ControlSource=crSigCdPro.CravCers
            loc_oPg.AddObject("chk_4c_CravCera", "CheckBox")
            WITH loc_oPg.chk_4c_CravCera
                .Caption       = "Crava" + CHR(231) + CHR(227) + "o em Cera"
                .Top           = 283
                .Left          = 180
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackStyle     = 0
                .AutoSize      = .T.
                .Alignment     = 0
                .Value         = 0
                .SpecialEffect = 1
                .ForeColor     = RGB(90, 90, 90)
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Say2: "Tamanho Padrao :"
            *-- Original Say2: top=308, left=44
            loc_oPg.AddObject("lbl_4c_Say2", "Label")
            WITH loc_oPg.lbl_4c_Say2
                .Caption   = "Tamanho Padr" + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Left      = 44
                .Top       = 308
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_CodTamsFP: Tamanho Padrao (getTam) - espelha Page1 CodTams
            *-- Original getTam: top=304, left=137, width=38, ControlSource=crSigCdPro.CodTams
            loc_oPg.AddObject("txt_4c_CodTamsFP", "TextBox")
            WITH loc_oPg.txt_4c_CodTamsFP
                .Top           = 304
                .Left          = 137
                .Width         = 38
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 4
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_CodTamsFP, "KeyPress", THIS, "ValidarTamFaseP")

            *-- chk_4c_Varias: Peso Variavel (fwoption1)
            *-- Original fwoption1: top=308, left=180, ControlSource=crSigCdPro.Varias
            loc_oPg.AddObject("chk_4c_Varias", "CheckBox")
            WITH loc_oPg.chk_4c_Varias
                .Caption       = "Peso Vari" + CHR(225) + "vel"
                .Top           = 308
                .Left          = 180
                .FontName      = "Tahoma"
                .FontSize      = 8
                .BackStyle     = 0
                .AutoSize      = .T.
                .Alignment     = 0
                .Value         = 0
                .SpecialEffect = 1
                .ForeColor     = RGB(90, 90, 90)
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Acabamento: "Acabamento :"
            *-- Original lblAcabamento: top=333, left=15, width=119, Alignment=1
            loc_oPg.AddObject("lbl_4c_Acabamento", "Label")
            WITH loc_oPg.lbl_4c_Acabamento
                .Caption   = "Acabamento :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 1
                .Height    = 15
                .Left      = 15
                .Top       = 333
                .Width     = 119
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_CodAcbsFP: Codigo de Acabamento (get_codacb)
            *-- Original get_codacb: top=329, left=137, width=38, ControlSource=crSigCdPro.codAcbs
            loc_oPg.AddObject("txt_4c_CodAcbsFP", "TextBox")
            WITH loc_oPg.txt_4c_CodAcbsFP
                .Top           = 329
                .Left          = 137
                .Width         = 38
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 3
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_CodAcbsFP, "KeyPress", THIS, "ValidarAcabamentoFaseP")

            *-- txt_4c_DacbFP: Descricao Acabamento (get_Dacb) - somente leitura
            *-- Original get_Dacb: top=329, left=177, width=207, height=23
            loc_oPg.AddObject("txt_4c_DacbFP", "TextBox")
            WITH loc_oPg.txt_4c_DacbFP
                .Top           = 329
                .Left          = 177
                .Width         = 207
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Label9: "Entrega :"
            *-- Original Label9: top=359, left=87, width=47
            loc_oPg.AddObject("lbl_4c_Label9", "Label")
            WITH loc_oPg.lbl_4c_Label9
                .Caption   = "Entrega :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 87
                .Top       = 359
                .Width     = 47
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_TEnts: Tempo de Entrega em Dias (getTEnts)
            *-- Original getTEnts: top=355, left=137, width=31, height=23, ControlSource=crSigCdPro.tents
            loc_oPg.AddObject("txt_4c_TEnts", "TextBox")
            WITH loc_oPg.txt_4c_TEnts
                .Top           = 355
                .Left          = 137
                .Width         = 31
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999"
                .MaxLength     = 10
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Label10: "Dias"
            *-- Original Label10: top=359, left=170, width=22
            loc_oPg.AddObject("lbl_4c_Label10", "Label")
            WITH loc_oPg.lbl_4c_Label10
                .Caption   = "Dias"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 170
                .Top       = 359
                .Width     = 22
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- lbl_4c_Say46: "Garantia :"
            *-- Original Say46: top=384, left=84, width=50
            loc_oPg.AddObject("lbl_4c_Say46", "Label")
            WITH loc_oPg.lbl_4c_Say46
                .Caption   = "Garantia :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 84
                .Top       = 384
                .Width     = 50
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_DiasGar: Dias de Garantia (getDiasGar)
            *-- Original getDiasGar: top=380, left=137, width=31, height=23, ControlSource=crSigCdPro.DiasGar
            loc_oPg.AddObject("txt_4c_DiasGar", "TextBox")
            WITH loc_oPg.txt_4c_DiasGar
                .Top           = 380
                .Left          = 137
                .Width         = 31
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999"
                .MaxLength     = 3
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Say47: "Dias"
            *-- Original Say47: top=384, left=170, width=22
            loc_oPg.AddObject("lbl_4c_Say47", "Label")
            WITH loc_oPg.lbl_4c_Say47
                .Caption   = "Dias"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 170
                .Top       = 384
                .Width     = 22
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- lbl_4c_Say26: "Volumes :"
            *-- Original Say26: top=409, left=86, width=48
            loc_oPg.AddObject("lbl_4c_Say26", "Label")
            WITH loc_oPg.lbl_4c_Say26
                .Caption   = "Volumes :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 86
                .Top       = 409
                .Width     = 48
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Volumes: Numero de Volumes (fwget3)
            *-- Original fwget3: top=405, left=137, width=31, height=23, ControlSource=crSigCdPro.volumes
            loc_oPg.AddObject("txt_4c_Volumes", "TextBox")
            WITH loc_oPg.txt_4c_Volumes
                .Top           = 405
                .Left          = 137
                .Width         = 31
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .MaxLength     = 3
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Say21: "Lote Minimo :"
            *-- Original Say21: top=434, left=69, width=65
            loc_oPg.AddObject("lbl_4c_Say21", "Label")
            WITH loc_oPg.lbl_4c_Say21
                .Caption   = "Lote M" + CHR(237) + "nimo :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 69
                .Top       = 434
                .Width     = 65
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_LtMinsV: Lote Minimo de Venda (getLtMinsV)
            *-- Original getLtMinsV: top=430, left=137, width=80, height=23, ControlSource=crSigCdPro.ltminsv
            loc_oPg.AddObject("txt_4c_LtMinsV", "TextBox")
            WITH loc_oPg.txt_4c_LtMinsV
                .Top           = 430
                .Left          = 137
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999.99"
                .MaxLength     = 10
                .SpecialEffect = 1
                .Value         = 0
                .Visible       = .T.
            ENDWITH

            *-- lbl_4c_Say19: "Ult.Compra :"
            *-- Original Say19: top=459, left=71, width=63
            loc_oPg.AddObject("lbl_4c_Say19", "Label")
            WITH loc_oPg.lbl_4c_Say19
                .Caption   = CHR(218) + "lt.Compra :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 71
                .Top       = 459
                .Width     = 63
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_DtUcp: Data da ultima compra (get_Dtucp) - somente leitura
            *-- Original get_Dtucp: top=455, left=137, width=79, height=23, ControlSource=crSigCdPro.UltComps
            loc_oPg.AddObject("txt_4c_DtUcp", "TextBox")
            WITH loc_oPg.txt_4c_DtUcp
                .Top               = 455
                .Left              = 137
                .Width             = 79
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .MaxLength         = 10
                .SpecialEffect     = 1
                .ReadOnly          = .T.
                .Value             = ""
                .BackColor         = RGB(240, 240, 240)
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(224, 235, 235)
                .DisabledForeColor = RGB(36, 84, 155)
                .Visible           = .T.
            ENDWITH

            *-- txt_4c_VUcp: Valor da ultima compra (Get_vucp) - somente leitura
            *-- Original Get_vucp: top=455, left=217, width=97, height=23, ControlSource=crSigCdPro.vUltComps
            loc_oPg.AddObject("txt_4c_VUcp", "TextBox")
            WITH loc_oPg.txt_4c_VUcp
                .Top               = 455
                .Left              = 217
                .Width             = 97
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .InputMask         = "99,999.99999"
                .SpecialEffect     = 1
                .ReadOnly          = .T.
                .Value             = 0
                .BackColor         = RGB(240, 240, 240)
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(224, 235, 235)
                .DisabledForeColor = RGB(36, 84, 155)
                .Visible           = .T.
            ENDWITH

            *-- txt_4c_MUcp: Moeda da ultima compra (Get_mucp) - somente leitura
            *-- Original Get_mucp: top=455, left=315, width=31, height=23, ControlSource=crSigCdPro.MUltComps
            loc_oPg.AddObject("txt_4c_MUcp", "TextBox")
            WITH loc_oPg.txt_4c_MUcp
                .Top               = 455
                .Left              = 315
                .Width             = 31
                .Height            = 23
                .FontName          = "Tahoma"
                .FontSize          = 8
                .MaxLength         = 3
                .SpecialEffect     = 1
                .ReadOnly          = .T.
                .Value             = ""
                .BackColor         = RGB(240, 240, 240)
                .ForeColor         = RGB(0, 0, 0)
                .DisabledBackColor = RGB(224, 235, 235)
                .DisabledForeColor = RGB(36, 84, 155)
                .Visible           = .T.
            ENDWITH

            *-- lbl_4c_Say36: "Variacao :"
            *-- Original Say36: top=481, left=84, width=50
            loc_oPg.AddObject("lbl_4c_Say36", "Label")
            WITH loc_oPg.lbl_4c_Say36
                .Caption   = "Varia" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 15
                .Left      = 84
                .Top       = 481
                .Width     = 50
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- opt_4c_Prodvars: Variacao p/ e-commerce Sim/Nao (Fwoption2)
            *-- Original Fwoption2: top=482, left=132, width=93, height=15, ControlSource=crSigCdPro.prodvars
            loc_oPg.AddObject("opt_4c_Prodvars", "OptionGroup")
            WITH loc_oPg.opt_4c_Prodvars
                .ButtonCount = 2
                .Value       = 1
                .Top         = 482
                .Left        = 132
                .Width       = 93
                .Height      = 15
                .BackStyle   = 0
                .BorderStyle = 0
                .Visible     = .T.
                .Option1.Caption   = "Sim"
                .Option1.FontName  = "Tahoma"
                .Option1.FontSize  = 8
                .Option1.BackStyle = 0
                .Option1.ForeColor = RGB(90, 90, 90)
                .Option1.Alignment = 2
                .Option1.Top       = 0
                .Option1.Left      = 5
                .Option1.Height    = 15
                .Option1.AutoSize  = .T.
                .Option2.Caption   = "N" + CHR(227) + "o"
                .Option2.FontName  = "Tahoma"
                .Option2.FontSize  = 8
                .Option2.BackStyle = 0
                .Option2.ForeColor = RGB(90, 90, 90)
                .Option2.Alignment = 2
                .Option2.Top       = 0
                .Option2.Left      = 47
                .Option2.Height    = 15
                .Option2.AutoSize  = .T.
            ENDWITH

            *--------------------------------------------------------------
            *-- Area direita: descricao da fase, observacoes
            *--------------------------------------------------------------

            *-- lbl_4c_Say1Desc: "Descricao :" (rotulo de Get_Desc)
            *-- Original Say1: top=508, left=527, width=67
            loc_oPg.AddObject("lbl_4c_Say1Desc", "Label")
            WITH loc_oPg.lbl_4c_Say1Desc
                .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Height    = 17
                .Left      = 527
                .Top       = 508
                .Width     = 67
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- txt_4c_Desc: Descricao da fase selecionada (Get_Desc) - somente leitura
            *-- Original Get_Desc: top=505, left=595, width=395, height=23, ControlSource=crSigCdGcr.descrs
            loc_oPg.AddObject("txt_4c_Desc", "TextBox")
            WITH loc_oPg.txt_4c_Desc
                .Top           = 505
                .Left          = 595
                .Width         = 395
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .ReadOnly      = .T.
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- edt_4c_Obs: Observacoes da fase (Get_Obs - fwmemo)
            *-- Original Get_Obs: top=531, left=527, width=463, height=92, ControlSource=crSigCdPrf.Obs
            loc_oPg.AddObject("edt_4c_Obs", "EditBox")
            WITH loc_oPg.edt_4c_Obs
                .Top           = 531
                .Left          = 527
                .Width         = 463
                .Height        = 92
                .FontName      = "Tahoma"
                .FontSize      = 8
                .SpecialEffect = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *--------------------------------------------------------------
            *-- Area de Matrizes (grdMatrizes + shpBorracha + ImgBorracha)
            *--------------------------------------------------------------

            *-- shp_4c_Borracha: Moldura da imagem do molde
            *-- Original shpBorracha: top=387, left=779, width=210, height=112
            loc_oPg.AddObject("shp_4c_Borracha", "Shape")
            WITH loc_oPg.shp_4c_Borracha
                .Top           = 387
                .Left          = 779
                .Width         = 210
                .Height        = 112
                .BackStyle     = 0
                .BorderWidth   = 2
                .SpecialEffect = 0
                .Visible       = .T.
            ENDWITH

            *-- img_4c_ImgBorracha: Imagem do molde da matriz
            *-- Original ImgBorracha: top=388, left=780, width=208, height=110
            loc_oPg.AddObject("img_4c_ImgBorracha", "Image")
            WITH loc_oPg.img_4c_ImgBorracha
                .Top     = 388
                .Left    = 780
                .Width   = 208
                .Height  = 110
                .Stretch = 1
                .Visible = .T.
            ENDWITH

            *-- cmd_4c_InserirMtz: Inserir linha na grdMatrizes
            *-- Original btnInsereMtx: top=302, left=778, width=39, height=40
            loc_oPg.AddObject("cmd_4c_InserirMtz", "CommandButton")
            WITH loc_oPg.cmd_4c_InserirMtz
                .Top             = 302
                .Left            = 778
                .Width           = 39
                .Height          = 40
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 14
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_InserirMtz, "Click", THIS, "BtnInserirMtzClick")

            *-- cmd_4c_ExcluirMtz: Excluir linha da grdMatrizes
            *-- Original btnExcluiMtz: top=342, left=778, width=39, height=40
            loc_oPg.AddObject("cmd_4c_ExcluirMtz", "CommandButton")
            WITH loc_oPg.cmd_4c_ExcluirMtz
                .Top             = 342
                .Left            = 778
                .Width           = 39
                .Height          = 40
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
                .PicturePosition = 14
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Excluir"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_ExcluirMtz, "Click", THIS, "BtnExcluirMtzClick")

            *-- grd_4c_GrdMatrizes: Grade de Matrizes (3 colunas)
            *-- Original grdMatrizes: top=305, left=527, width=245, height=192, columnCount=3
            loc_oPg.AddObject("grd_4c_GrdMatrizes", "Grid")
            WITH loc_oPg.grd_4c_GrdMatrizes
                .Top               = 305
                .Left              = 527
                .Width             = 245
                .Height            = 192
                .FontName          = "Tahoma"
                .FontSize          = 8
                .RecordMark        = .F.
                .DeleteMark        = .F.
                .HeaderHeight      = 20
                .RowHeight         = 18
                .ScrollBars        = 2
                .GridLines         = 3
                .GridLineColor     = RGB(238, 238, 238)
                .HighlightBackColor = RGB(255, 255, 255)
                .HighlightForeColor = RGB(15, 41, 104)
                .HighlightStyle    = 2
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .Visible           = .T.
            ENDWITH
            loc_oPg.grd_4c_GrdMatrizes.ColumnCount  = 3
            loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
            loc_oGrid2 = loc_oPg.grd_4c_GrdMatrizes

            *-- Column1: Matriz (cmats C14) - lookup, width=108
            loc_oGrid2.Column1.ControlSource   = "cursor_4c_GrdMatrizes.cmats"
            loc_oGrid2.Column1.Width           = 108
            loc_oGrid2.Column1.ReadOnly        = .F.
            loc_oGrid2.Column1.Movable         = .F.
            loc_oGrid2.Column1.Resizable       = .F.
            loc_oGrid2.Column1.Header1.Caption = "Matriz"
            BINDEVENT(loc_oGrid2.Column1.Text1, "Valid", THIS, "GrdMatrizesCol1Valid")

            *-- Column2: Qtde (qtds N3,0) - width=34
            loc_oGrid2.Column2.ControlSource   = "cursor_4c_GrdMatrizes.qtds"
            loc_oGrid2.Column2.Width           = 34
            loc_oGrid2.Column2.ReadOnly        = .F.
            loc_oGrid2.Column2.Movable         = .F.
            loc_oGrid2.Column2.Resizable       = .F.
            loc_oGrid2.Column2.InputMask       = "9999"
            loc_oGrid2.Column2.Header1.Caption = "Qtde"

            *-- Column3: Local (dpros C65) - somente leitura (descricao do produto matriz), width=80
            loc_oGrid2.Column3.ControlSource   = "cursor_4c_GrdMatrizes.dpros"
            loc_oGrid2.Column3.Width           = 80
            loc_oGrid2.Column3.ReadOnly        = .T.
            loc_oGrid2.Column3.Movable         = .F.
            loc_oGrid2.Column3.Resizable       = .F.
            loc_oGrid2.Column3.Header1.Caption = "Local"

            BINDEVENT(loc_oGrid2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar p" + CHR(225) + "gina Processos de Produ" + ;
                CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
                "FormProduto.ConfigurarPgPgDadosFaseP")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CarregarFaseP - Popula grids de FaseP do banco (SigCdPrf + SigPrMtz)
    * Chamado de BOParaForm quando produto e carregado para edicao/visualizacao
    *===========================================================================
    PROTECTED PROCEDURE CarregarFaseP()
        LOCAL loc_cCpros, loc_nRet, loc_oPg, loException
        TRY
            loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
            IF EMPTY(loc_cCpros) OR TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4

            *-- Carregar GradFase de SigCdPrf
            IF USED("cursor_4c_GradFase")
                USE IN cursor_4c_GradFase
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs" + ;
                " FROM SigCdPrf WHERE produtos = " + EscaparSQL(loc_cCpros) + ;
                "' ORDER BY ordems", "cursor_4c_GradFase")
            IF loc_nRet <= 0
                CREATE CURSOR cursor_4c_GradFase ( ;
                    cidchaves C(20), ordems N(2,0), grupos C(10), ;
                    minutos   N(9,1), uniprdts C(10), matprdts C(15), obs M)
            ENDIF
            IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
                loc_oPg.grd_4c_GradFase.ColumnCount = 5
                loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
                loc_oPg.grd_4c_GradFase.Column1.ControlSource = "cursor_4c_GradFase.ordems"
                loc_oPg.grd_4c_GradFase.Column2.ControlSource = "cursor_4c_GradFase.grupos"
                loc_oPg.grd_4c_GradFase.Column3.ControlSource = "cursor_4c_GradFase.minutos"
                loc_oPg.grd_4c_GradFase.Column4.ControlSource = "cursor_4c_GradFase.uniprdts"
                loc_oPg.grd_4c_GradFase.Column5.ControlSource = "cursor_4c_GradFase.matprdts"
                loc_oPg.grd_4c_GradFase.Column1.Header1.Caption = "Ordem"
                loc_oPg.grd_4c_GradFase.Column2.Header1.Caption = "Fase"
                loc_oPg.grd_4c_GradFase.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
                loc_oPg.grd_4c_GradFase.Column4.Header1.Caption = "Uni. Produtiva"
                loc_oPg.grd_4c_GradFase.Column5.Header1.Caption = "Material"
                loc_oPg.grd_4c_GradFase.Refresh()
            ENDIF

            *-- Carregar grdMatrizes de SigPrMtz + SigCdPro (descricao do produto matriz)
            IF USED("cursor_4c_GrdMatrizes")
                USE IN cursor_4c_GrdMatrizes
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT m.cidchaves, m.cmats, m.qtds, ISNULL(p.dpros,'') AS dpros" + ;
                " FROM SigPrMtz m LEFT JOIN SigCdPro p ON p.cpros = m.cmats" + ;
                " WHERE m.cpros = " + EscaparSQL(loc_cCpros) + ;
                " ORDER BY m.cmats", "cursor_4c_GrdMatrizes")
            IF loc_nRet <= 0
                CREATE CURSOR cursor_4c_GrdMatrizes ( ;
                    cidchaves C(20), cmats C(14), qtds N(3,0), dpros C(65))
            ENDIF
            IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
                loc_oPg.grd_4c_GrdMatrizes.ColumnCount = 3
                loc_oPg.grd_4c_GrdMatrizes.RecordSource = "cursor_4c_GrdMatrizes"
                loc_oPg.grd_4c_GrdMatrizes.Column1.ControlSource = "cursor_4c_GrdMatrizes.cmats"
                loc_oPg.grd_4c_GrdMatrizes.Column2.ControlSource = "cursor_4c_GrdMatrizes.qtds"
                loc_oPg.grd_4c_GrdMatrizes.Column3.ControlSource = "cursor_4c_GrdMatrizes.dpros"
                loc_oPg.grd_4c_GrdMatrizes.Column1.Header1.Caption = "Matriz"
                loc_oPg.grd_4c_GrdMatrizes.Column2.Header1.Caption = "Qtde"
                loc_oPg.grd_4c_GrdMatrizes.Column3.Header1.Caption = "Local"
                loc_oPg.grd_4c_GrdMatrizes.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar FaseP:" + CHR(13) + loException.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormProduto.CarregarFaseP")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GrdFaseBeforeRowColChange - Persiste obs do EditBox no cursor antes de mudar linha
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE GrdFaseBeforeRowColChange(par_nColIndex)
        IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
            LOCAL loc_oPgBC
            loc_oPgBC = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF PEMSTATUS(loc_oPgBC, "edt_4c_Obs", 5)
                SELECT cursor_4c_GradFase
                REPLACE cursor_4c_GradFase.obs WITH loc_oPgBC.edt_4c_Obs.Value
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * GrdFaseAfterRowColChange - Exibe imagem da fase e atualiza descricao
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE GrdFaseAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_lcArquivo, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF !PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5) OR !USED("cursor_4c_GradFase")
                RETURN
            ENDIF

            CLEAR RESOURCES
            loc_oPg.img_4c_ImgFig.Picture = ""
            loc_oPg.img_4c_ImgFig.Visible = .F.
            loc_oPg.txt_4c_Desc.Value     = ""
            loc_oPg.edt_4c_Obs.Value      = ""

            IF !EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
                LOCAL loc_cGrupos, loc_cCidchaves
                SELECT cursor_4c_GradFase
                loc_cGrupos    = ALLTRIM(cursor_4c_GradFase.grupos)
                loc_cCidchaves = ALLTRIM(cursor_4c_GradFase.cidchaves)

                *-- Carregar descricao do grupo/fase (SigCdGcr)
                IF !EMPTY(loc_cGrupos)
                    loc_nRet = SQLEXEC(gnConnHandle, ;
                        "SELECT descrs FROM SigCdGcr WHERE codigos = '" + ;
                        EscaparSQL(loc_cGrupos) + "", "cursor_4c_FaseGcrDesc")
                    IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrDesc") AND !EOF("cursor_4c_FaseGcrDesc")
                        SELECT cursor_4c_FaseGcrDesc
                        loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_FaseGcrDesc.descrs)
                    ENDIF
                    IF USED("cursor_4c_FaseGcrDesc")
                        USE IN cursor_4c_FaseGcrDesc
                    ENDIF
                ENDIF

                *-- Obs vem do cursor (ja carregado em CarregarFaseP / gravado por BeforeRowColChange)
                SELECT cursor_4c_GradFase
                IF !ISNULL(cursor_4c_GradFase.obs)
                    loc_oPg.edt_4c_Obs.Value = cursor_4c_GradFase.obs
                ENDIF

                *-- Figura carregada do banco (campo figprocs - binario nao armazenado no cursor)
                IF !EMPTY(loc_cCidchaves)
                    loc_nRet = SQLEXEC(gnConnHandle, ;
                        "SELECT figprocs FROM SigCdPrf WHERE cidchaves = '" + ;
                        EscaparSQL(loc_cCidchaves) + "", "cursor_4c_FasePrfFig")
                    IF loc_nRet > 0 AND USED("cursor_4c_FasePrfFig") AND !EOF("cursor_4c_FasePrfFig")
                        SELECT cursor_4c_FasePrfFig
                        IF !ISNULL(cursor_4c_FasePrfFig.figprocs) AND ;
                                !EMPTY(cursor_4c_FasePrfFig.figprocs)
                            loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                            IF STRTOFILE(cursor_4c_FasePrfFig.figprocs, loc_lcArquivo) > 0
                                loc_oPg.img_4c_ImgFig.Visible = .T.
                                loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
                            ENDIF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_FasePrfFig")
                        USE IN cursor_4c_FasePrfFig
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar linha de fase:" + CHR(13) + loException.Message, ;
                "FormProduto.GrdFaseAfterRowColChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GrdFaseCol1OrdValid - Valida coluna Ordem da GradFase
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE GrdFaseCol1OrdValid()
        IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
            SELECT cursor_4c_GradFase
            IF cursor_4c_GradFase.ordems <= 0
                MsgAviso("Ordem deve ser maior que zero.", "Fase")
                RETURN .F.
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *===========================================================================
    * GrdFaseCol2FaseValid - Lookup de fase/grupo (SigCdGcr) na GradFase
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE GrdFaseCol2FaseValid()
        LOCAL loc_cValAtual, loc_nRet, loc_oBusca, loException
        TRY
            IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
                loc_lResultado = .T.
            ENDIF
            SELECT cursor_4c_GradFase
            loc_cValAtual = ALLTRIM(cursor_4c_GradFase.grupos)
            IF EMPTY(loc_cValAtual)
                loc_lResultado = .T.
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = '" + ;
                EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseGcrBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_FaseGcrBusca") AND !EOF("cursor_4c_FaseGcrBusca")
                IF USED("cursor_4c_FaseGcrBusca")
                    USE IN cursor_4c_FaseGcrBusca
                ENDIF
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_FaseGcrBusca")
                USE IN cursor_4c_FaseGcrBusca
            ENDIF

            *-- Codigo nao encontrado: abrir busca
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descrs FROM SigCdGcr WHERE codigos LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY codigos", "cursor_4c_FaseGcrBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_FaseGcrBusca") OR EOF("cursor_4c_FaseGcrBusca")
                IF USED("cursor_4c_FaseGcrBusca")
                    USE IN cursor_4c_FaseGcrBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descrs FROM SigCdGcr ORDER BY codigos", ;
                    "cursor_4c_FaseGcrBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_FaseGcrBusca", "codigos", "descrs", ;
                    "Selecionar Fase/Grupo")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
                    SELECT cursor_4c_GradFase
                    REPLACE cursor_4c_GradFase.grupos WITH loc_oBusca.cCodigoSelecionado
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_FaseGcrBusca")
                USE IN cursor_4c_FaseGcrBusca
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_FaseGcrBusca")
                USE IN cursor_4c_FaseGcrBusca
            ENDIF
            MostrarErro("Erro ao validar fase:" + CHR(13) + loException.Message, ;
                "FormProduto.GrdFaseCol2FaseValid")
        ENDTRY
        RETURN .T.
    ENDPROC

    *===========================================================================
    * GrdFaseCol4UniPrdtValid - Lookup de Unidade Produtiva (SigCdUpd) na GradFase
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE GrdFaseCol4UniPrdtValid()
        LOCAL loc_cValAtual, loc_cGrupos, loc_nRet, loc_oBusca, loException
        TRY
            IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
                loc_lResultado = .T.
            ENDIF
            SELECT cursor_4c_GradFase
            loc_cValAtual = ALLTRIM(cursor_4c_GradFase.uniprdts)
            loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
            IF EMPTY(loc_cValAtual)
                loc_lResultado = .T.
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT uniprdts FROM SigCdUpd WHERE codigos = '" + ;
                EscaparSQL(loc_cGrupos) + " AND uniprdts = '" + ;
                EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseUpdBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_FaseUpdBusca") AND !EOF("cursor_4c_FaseUpdBusca")
                IF USED("cursor_4c_FaseUpdBusca")
                    USE IN cursor_4c_FaseUpdBusca
                ENDIF
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_FaseUpdBusca")
                USE IN cursor_4c_FaseUpdBusca
            ENDIF

            *-- Abrir busca das unidades produtivas para este grupo
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT uniprdts FROM SigCdUpd WHERE codigos = '" + ;
                EscaparSQL(loc_cGrupos) + " ORDER BY uniprdts", "cursor_4c_FaseUpdBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_FaseUpdBusca") OR EOF("cursor_4c_FaseUpdBusca")
                IF USED("cursor_4c_FaseUpdBusca")
                    USE IN cursor_4c_FaseUpdBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT DISTINCT uniprdts FROM SigCdUpd ORDER BY uniprdts", ;
                    "cursor_4c_FaseUpdBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_FaseUpdBusca", "uniprdts", "uniprdts", ;
                    "Selecionar Uni. Produtiva")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
                    SELECT cursor_4c_GradFase
                    REPLACE cursor_4c_GradFase.uniprdts WITH loc_oBusca.cCodigoSelecionado
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_FaseUpdBusca")
                USE IN cursor_4c_FaseUpdBusca
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_FaseUpdBusca")
                USE IN cursor_4c_FaseUpdBusca
            ENDIF
            MostrarErro("Erro ao validar uni. produtiva:" + CHR(13) + loException.Message, ;
                "FormProduto.GrdFaseCol4UniPrdtValid")
        ENDTRY
        RETURN .T.
    ENDPROC

    *===========================================================================
    * GrdFaseCol5MatPrdtValid - Lookup de Material (SigOpOpt) na GradFase
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE GrdFaseCol5MatPrdtValid()
        LOCAL loc_cValAtual, loc_cGrupos, loc_nRet, loc_oBusca, loException
        TRY
            IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
                loc_lResultado = .T.
            ENDIF
            SELECT cursor_4c_GradFase
            loc_cValAtual = ALLTRIM(cursor_4c_GradFase.matprdts)
            loc_cGrupos   = ALLTRIM(cursor_4c_GradFase.grupos)
            IF EMPTY(loc_cValAtual)
                loc_lResultado = .T.
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cods, descs FROM SigOpOpt WHERE cods = '" + ;
                EscaparSQL(loc_cValAtual) + "", "cursor_4c_FaseOptBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_FaseOptBusca") AND !EOF("cursor_4c_FaseOptBusca")
                IF USED("cursor_4c_FaseOptBusca")
                    USE IN cursor_4c_FaseOptBusca
                ENDIF
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_FaseOptBusca")
                USE IN cursor_4c_FaseOptBusca
            ENDIF

            *-- Abrir busca filtrando pelo grupo da fase
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cods, descs FROM SigOpOpt WHERE grupos = '" + ;
                EscaparSQL(loc_cGrupos) + " AND cods LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_FaseOptBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_FaseOptBusca") OR EOF("cursor_4c_FaseOptBusca")
                IF USED("cursor_4c_FaseOptBusca")
                    USE IN cursor_4c_FaseOptBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT cods, descs FROM SigOpOpt ORDER BY cods", ;
                    "cursor_4c_FaseOptBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_FaseOptBusca", "cods", "descs", ;
                    "Selecionar Material")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GradFase")
                    SELECT cursor_4c_GradFase
                    REPLACE cursor_4c_GradFase.matprdts WITH loc_oBusca.cCodigoSelecionado
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_FaseOptBusca")
                USE IN cursor_4c_FaseOptBusca
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_FaseOptBusca")
                USE IN cursor_4c_FaseOptBusca
            ENDIF
            MostrarErro("Erro ao validar material:" + CHR(13) + loException.Message, ;
                "FormProduto.GrdFaseCol5MatPrdtValid")
        ENDTRY
        RETURN .T.
    ENDPROC

    *===========================================================================
    * BtnInserirFaseClick - Insere nova linha na GradFase (cursor_4c_GradFase)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnInserirFaseClick()
        LOCAL loc_oPg, loc_nProxOrdem, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF !USED("cursor_4c_GradFase")
                RETURN
            ENDIF

            SELECT cursor_4c_GradFase
            IF EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase") OR ;
                    RECCOUNT("cursor_4c_GradFase") = 0
                loc_nProxOrdem = 1
            ELSE
                GO BOTTOM IN cursor_4c_GradFase
                loc_nProxOrdem = cursor_4c_GradFase.ordems + 1
            ENDIF

            INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
                VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")

            IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
                loc_oPg.grd_4c_GradFase.Refresh()
                GO BOTTOM IN cursor_4c_GradFase
                loc_oPg.grd_4c_GradFase.Column2.SetFocus()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir fase:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnInserirFaseClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirFaseClick - Exclui linha atual da GradFase
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnExcluirFaseClick()
        LOCAL loc_oPg, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
                RETURN
            ENDIF

            SELECT cursor_4c_GradFase
            IF !MsgConfirma("Excluir esta fase de produ" + CHR(231) + CHR(227) + "o?")
                RETURN
            ENDIF
            DELETE IN cursor_4c_GradFase
            IF !EOF("cursor_4c_GradFase")
                SKIP IN cursor_4c_GradFase
            ENDIF
            IF EOF("cursor_4c_GradFase") AND RECCOUNT("cursor_4c_GradFase") > 0
                GO BOTTOM IN cursor_4c_GradFase
            ENDIF

            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
                loc_oPg.grd_4c_GradFase.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir fase:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnExcluirFaseClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnAlternativaFaseClick - Insere fase alternativa apos a fase atual
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnAlternativaFaseClick()
        LOCAL loc_oPg, loc_nOrdemAtual, loc_nProxOrdem, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF !USED("cursor_4c_GradFase")
                RETURN
            ENDIF

            SELECT cursor_4c_GradFase
            IF EOF("cursor_4c_GradFase") OR RECCOUNT("cursor_4c_GradFase") = 0
                loc_nOrdemAtual = 0
            ELSE
                loc_nOrdemAtual = cursor_4c_GradFase.ordems
            ENDIF
            loc_nProxOrdem = loc_nOrdemAtual + 1

            INSERT INTO cursor_4c_GradFase (cidchaves, ordems, grupos, minutos, uniprdts, matprdts, obs) ;
                VALUES (SYS(2015), loc_nProxOrdem, "", 0, "", "", "")

            IF PEMSTATUS(loc_oPg, "grd_4c_GradFase", 5)
                loc_oPg.grd_4c_GradFase.Refresh()
                GO BOTTOM IN cursor_4c_GradFase
                loc_oPg.grd_4c_GradFase.Column2.SetFocus()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir fase alternativa:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnAlternativaFaseClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CmdFichaFasePClick - Abre formulario de Ficha Tecnica do produto
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE CmdFichaFasePClick()
        LOCAL loc_cCpros, loException
        TRY
            loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
            IF EMPTY(loc_cCpros)
                MsgAviso("Selecione um produto para abrir a Ficha T" + CHR(233) + "cnica.", ;
                    "Ficha T" + CHR(233) + "cnica")
                RETURN
            ENDIF
            MsgInfo("Ficha T" + CHR(233) + "cnica: " + loc_cCpros)
        CATCH TO loException
            MostrarErro("Erro ao abrir Ficha T" + CHR(233) + "cnica:" + CHR(13) + ;
                loException.Message, "FormProduto.CmdFichaFasePClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CmdFiguraFasePClick - Captura imagem do produto via seletor de arquivo
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE CmdFiguraFasePClick()
        LOCAL loc_lcFigura, loc_lcArquivo, loc_oPg, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
                MsgAviso("Selecione uma fase na grade para associar a imagem.", "Imagem")
                RETURN
            ENDIF

            loc_lcFigura = ALLTRIM(GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", ;
                "Nome do Arquivo:", "Selecionar"))
            IF EMPTY(loc_lcFigura) OR !FILE(loc_lcFigura)
                RETURN
            ENDIF

            loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
            COPY FILE (loc_lcFigura) TO (loc_lcArquivo)

            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5)
                CLEAR RESOURCES
                loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
                loc_oPg.img_4c_ImgFig.Visible = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao capturar imagem:" + CHR(13) + loException.Message, ;
                "FormProduto.CmdFiguraFasePClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CmdFigCamFasePClick - Captura imagem do produto via WebCam (SigImage)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE CmdFigCamFasePClick()
        LOCAL loc_lcFigura, loc_lcArquivo, loc_oPg, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase")
                MsgAviso("Selecione uma fase na grade para associar a imagem.", "Imagem WebCam")
                RETURN
            ENDIF

            loc_lcFigura = ""
            DO FORM SigImage TO loc_lcFigura
            IF EMPTY(loc_lcFigura) OR !FILE(loc_lcFigura)
                RETURN
            ENDIF

            loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
            COPY FILE (loc_lcFigura) TO (loc_lcArquivo)

            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF PEMSTATUS(loc_oPg, "img_4c_ImgFig", 5)
                CLEAR RESOURCES
                loc_oPg.img_4c_ImgFig.Picture = loc_lcArquivo
                loc_oPg.img_4c_ImgFig.Visible = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao capturar imagem via WebCam:" + CHR(13) + loException.Message, ;
                "FormProduto.CmdFigCamFasePClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarConquilhaFaseP - Lookup de Conquilha (sigcdcnq) em txt_4c_Conquilhas
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarConquilhaFaseP()
        LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF !PEMSTATUS(loc_oPg, "txt_4c_Conquilhas", 5)
                loc_lResultado = .T.
            ENDIF
            loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Conquilhas.Value)
            IF EMPTY(loc_cValAtual)
                loc_lResultado = .T.
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT conquilhas FROM sigcdcnq WHERE conquilhas = '" + ;
                EscaparSQL(loc_cValAtual) + "", "cursor_4c_CnqBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_CnqBusca") AND !EOF("cursor_4c_CnqBusca")
                IF USED("cursor_4c_CnqBusca")
                    USE IN cursor_4c_CnqBusca
                ENDIF
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_CnqBusca")
                USE IN cursor_4c_CnqBusca
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT DISTINCT conquilhas FROM sigcdcnq WHERE conquilhas LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY conquilhas", "cursor_4c_CnqBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_CnqBusca") OR EOF("cursor_4c_CnqBusca")
                IF USED("cursor_4c_CnqBusca")
                    USE IN cursor_4c_CnqBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT DISTINCT conquilhas FROM sigcdcnq ORDER BY conquilhas", ;
                    "cursor_4c_CnqBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_CnqBusca", "conquilhas", "conquilhas", ;
                    "Selecionar Conquilha")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    loc_oPg.txt_4c_Conquilhas.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_CnqBusca")
                USE IN cursor_4c_CnqBusca
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_CnqBusca")
                USE IN cursor_4c_CnqBusca
            ENDIF
            MostrarErro("Erro ao validar conquilha:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarConquilhaFaseP")
        ENDTRY
        RETURN .T.
    ENDPROC

    *===========================================================================
    * ValidarCorFaseP - Lookup de Cor Padrao (SigCdCor) em txt_4c_CodCorsFP
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarCorFaseP()
        LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF !PEMSTATUS(loc_oPg, "txt_4c_CodCorsFP", 5)
                loc_lResultado = .T.
            ENDIF
            loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodCorsFP.Value)
            IF EMPTY(loc_cValAtual)
                loc_lResultado = .T.
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cods, descs FROM SigCdCor WHERE cods = '" + ;
                EscaparSQL(loc_cValAtual) + "", "cursor_4c_CorFPBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_CorFPBusca") AND !EOF("cursor_4c_CorFPBusca")
                IF USED("cursor_4c_CorFPBusca")
                    USE IN cursor_4c_CorFPBusca
                ENDIF
                *-- Sincronizar com Page1
                LOCAL loc_oPg1
                loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                IF PEMSTATUS(loc_oPg1, "txt_4c_CodCors", 5)
                    loc_oPg1.txt_4c_CodCors.Value = loc_cValAtual
                ENDIF
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_CorFPBusca")
                USE IN cursor_4c_CorFPBusca
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cods, descs FROM SigCdCor WHERE cods LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_CorFPBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_CorFPBusca") OR EOF("cursor_4c_CorFPBusca")
                IF USED("cursor_4c_CorFPBusca")
                    USE IN cursor_4c_CorFPBusca
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdCor ORDER BY cods", ;
                    "cursor_4c_CorFPBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_CorFPBusca", "cods", "descs", ;
                    "Selecionar Cor Padr" + CHR(227) + "o")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    loc_oPg.txt_4c_CodCorsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    LOCAL loc_oPg1b
                    loc_oPg1b = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                    IF PEMSTATUS(loc_oPg1b, "txt_4c_CodCors", 5)
                        loc_oPg1b.txt_4c_CodCors.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_CorFPBusca")
                USE IN cursor_4c_CorFPBusca
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_CorFPBusca")
                USE IN cursor_4c_CorFPBusca
            ENDIF
            MostrarErro("Erro ao validar cor padr" + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormProduto.ValidarCorFaseP")
        ENDTRY
        RETURN .T.
    ENDPROC

    *===========================================================================
    * ValidarTamFaseP - Lookup de Tamanho Padrao (SigCdTam) em txt_4c_CodTamsFP
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarTamFaseP()
        LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF !PEMSTATUS(loc_oPg, "txt_4c_CodTamsFP", 5)
                loc_lResultado = .T.
            ENDIF
            loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodTamsFP.Value)
            IF EMPTY(loc_cValAtual)
                loc_lResultado = .T.
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cods, descs FROM SigCdTam WHERE cods = '" + ;
                EscaparSQL(loc_cValAtual) + "", "cursor_4c_TamFPBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_TamFPBusca") AND !EOF("cursor_4c_TamFPBusca")
                IF USED("cursor_4c_TamFPBusca")
                    USE IN cursor_4c_TamFPBusca
                ENDIF
                LOCAL loc_oPg1c
                loc_oPg1c = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                IF PEMSTATUS(loc_oPg1c, "txt_4c_CodTams", 5)
                    loc_oPg1c.txt_4c_CodTams.Value = loc_cValAtual
                ENDIF
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_TamFPBusca")
                USE IN cursor_4c_TamFPBusca
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cods, descs FROM SigCdTam WHERE cods LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_TamFPBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_TamFPBusca") OR EOF("cursor_4c_TamFPBusca")
                IF USED("cursor_4c_TamFPBusca")
                    USE IN cursor_4c_TamFPBusca
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT cods, descs FROM SigCdTam ORDER BY cods", ;
                    "cursor_4c_TamFPBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_TamFPBusca", "cods", "descs", ;
                    "Selecionar Tamanho Padr" + CHR(227) + "o")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    loc_oPg.txt_4c_CodTamsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    LOCAL loc_oPg1d
                    loc_oPg1d = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                    IF PEMSTATUS(loc_oPg1d, "txt_4c_CodTams", 5)
                        loc_oPg1d.txt_4c_CodTams.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_TamFPBusca")
                USE IN cursor_4c_TamFPBusca
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_TamFPBusca")
                USE IN cursor_4c_TamFPBusca
            ENDIF
            MostrarErro("Erro ao validar tamanho padr" + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "FormProduto.ValidarTamFaseP")
        ENDTRY
        RETURN .T.
    ENDPROC

    *===========================================================================
    * ValidarAcabamentoFaseP - Lookup de Acabamento (SigCdAca) em txt_4c_CodAcbsFP
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE ValidarAcabamentoFaseP()
        LOCAL loc_oPg, loc_cValAtual, loc_nRet, loc_oBusca, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF !PEMSTATUS(loc_oPg, "txt_4c_CodAcbsFP", 5)
                loc_lResultado = .T.
            ENDIF
            loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CodAcbsFP.Value)
            IF EMPTY(loc_cValAtual)
                loc_oPg.txt_4c_DacbFP.Value = ""
                loc_lResultado = .T.
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cods, descrs FROM SigCdAca WHERE cods = '" + ;
                EscaparSQL(loc_cValAtual) + "", "cursor_4c_AcaFPBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_AcaFPBusca") AND !EOF("cursor_4c_AcaFPBusca")
                SELECT cursor_4c_AcaFPBusca
                loc_oPg.txt_4c_DacbFP.Value = ALLTRIM(cursor_4c_AcaFPBusca.descrs)
                IF USED("cursor_4c_AcaFPBusca")
                    USE IN cursor_4c_AcaFPBusca
                ENDIF
                LOCAL loc_oPg1e
                loc_oPg1e = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                IF PEMSTATUS(loc_oPg1e, "txt_4c_CodAcbs", 5)
                    loc_oPg1e.txt_4c_CodAcbs.Value = loc_cValAtual
                ENDIF
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_AcaFPBusca")
                USE IN cursor_4c_AcaFPBusca
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cods, descrs FROM SigCdAca WHERE cods LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY cods", "cursor_4c_AcaFPBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_AcaFPBusca") OR EOF("cursor_4c_AcaFPBusca")
                IF USED("cursor_4c_AcaFPBusca")
                    USE IN cursor_4c_AcaFPBusca
                ENDIF
                SQLEXEC(gnConnHandle, "SELECT cods, descrs FROM SigCdAca ORDER BY cods", ;
                    "cursor_4c_AcaFPBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_AcaFPBusca", "cods", "descrs", ;
                    "Selecionar Acabamento")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    loc_oPg.txt_4c_CodAcbsFP.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    loc_oPg.txt_4c_DacbFP.Value    = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    LOCAL loc_oPg1f
                    loc_oPg1f = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                    IF PEMSTATUS(loc_oPg1f, "txt_4c_CodAcbs", 5)
                        loc_oPg1f.txt_4c_CodAcbs.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_AcaFPBusca")
                USE IN cursor_4c_AcaFPBusca
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_AcaFPBusca")
                USE IN cursor_4c_AcaFPBusca
            ENDIF
            MostrarErro("Erro ao validar acabamento:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarAcabamentoFaseP")
        ENDTRY
        RETURN .T.
    ENDPROC

    *===========================================================================
    * GrdMatrizesCol1Valid - Lookup de produto-matriz (SigCdPro) em grdMatrizes
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE GrdMatrizesCol1Valid()
        LOCAL loc_cValAtual, loc_nRet, loc_oBusca, loException
        TRY
            IF !USED("cursor_4c_GrdMatrizes") OR EOF("cursor_4c_GrdMatrizes")
                loc_lResultado = .T.
            ENDIF
            SELECT cursor_4c_GrdMatrizes
            loc_cValAtual = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
            IF EMPTY(loc_cValAtual)
                loc_lResultado = .T.
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cpros, dpros FROM SigCdPro WHERE cpros = '" + ;
                EscaparSQL(loc_cValAtual) + "", "cursor_4c_MtzPrBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_MtzPrBusca") AND !EOF("cursor_4c_MtzPrBusca")
                SELECT cursor_4c_MtzPrBusca
                SELECT cursor_4c_GrdMatrizes
                REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(cursor_4c_MtzPrBusca.dpros)
                IF USED("cursor_4c_MtzPrBusca")
                    USE IN cursor_4c_MtzPrBusca
                ENDIF
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_MtzPrBusca")
                USE IN cursor_4c_MtzPrBusca
            ENDIF

            *-- Codigo nao encontrado: abrir busca
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cpros, dpros FROM SigCdPro WHERE cpros LIKE '" + ;
                EscaparSQL(loc_cValAtual) + "%' ORDER BY cpros", "cursor_4c_MtzPrBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_MtzPrBusca") OR EOF("cursor_4c_MtzPrBusca")
                IF USED("cursor_4c_MtzPrBusca")
                    USE IN cursor_4c_MtzPrBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT cpros, dpros FROM SigCdPro ORDER BY cpros", ;
                    "cursor_4c_MtzPrBusca")
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_MtzPrBusca", "cpros", "dpros", ;
                    "Selecionar Produto Matriz")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND USED("cursor_4c_GrdMatrizes")
                    SELECT cursor_4c_GrdMatrizes
                    REPLACE cursor_4c_GrdMatrizes.cmats WITH ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    REPLACE cursor_4c_GrdMatrizes.dpros WITH ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                ENDIF
                loc_oBusca = .NULL.
            ENDIF

            IF USED("cursor_4c_MtzPrBusca")
                USE IN cursor_4c_MtzPrBusca
            ENDIF

        CATCH TO loException
            IF USED("cursor_4c_MtzPrBusca")
                USE IN cursor_4c_MtzPrBusca
            ENDIF
            MostrarErro("Erro ao validar matriz:" + CHR(13) + loException.Message, ;
                "FormProduto.GrdMatrizesCol1Valid")
        ENDTRY
        RETURN .T.
    ENDPROC

    *===========================================================================
    * GrdMatrizesAfterRowColChange - Exibe imagem do molde da matriz selecionada
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE GrdMatrizesAfterRowColChange(par_nColIndex)
        LOCAL loc_oPg, loc_lcArquivo, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF !PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) OR !USED("cursor_4c_GrdMatrizes")
                RETURN
            ENDIF

            CLEAR RESOURCES
            loc_oPg.img_4c_ImgBorracha.Picture = ""
            loc_oPg.img_4c_ImgBorracha.Visible = .F.

            IF !EOF("cursor_4c_GrdMatrizes") AND !BOF("cursor_4c_GrdMatrizes")
                SELECT cursor_4c_GrdMatrizes
                LOCAL loc_cCmats
                loc_cCmats = ALLTRIM(cursor_4c_GrdMatrizes.cmats)
                IF !EMPTY(loc_cCmats)
                    loc_nRet = SQLEXEC(gnConnHandle, ;
                        "SELECT figprocs FROM SigCdPro WHERE cpros = '" + ;
                        EscaparSQL(loc_cCmats) + "", "cursor_4c_MtzImgPro")
                    IF loc_nRet > 0 AND USED("cursor_4c_MtzImgPro") AND !EOF("cursor_4c_MtzImgPro")
                        SELECT cursor_4c_MtzImgPro
                        IF !ISNULL(cursor_4c_MtzImgPro.figprocs) AND ;
                                !EMPTY(cursor_4c_MtzImgPro.figprocs)
                            loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
                            IF STRTOFILE(cursor_4c_MtzImgPro.figprocs, loc_lcArquivo) > 0
                                loc_oPg.img_4c_ImgBorracha.Visible = .T.
                                loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
                            ENDIF
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_MtzImgPro")
                        USE IN cursor_4c_MtzImgPro
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar imagem de matriz:" + CHR(13) + loException.Message, ;
                "FormProduto.GrdMatrizesAfterRowColChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnInserirMtzClick - Insere nova linha em grdMatrizes (cursor_4c_GrdMatrizes)
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnInserirMtzClick()
        LOCAL loc_oPg, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_GrdMatrizes")
                RETURN
            ENDIF

            INSERT INTO cursor_4c_GrdMatrizes (cidchaves, cmats, qtds, dpros) ;
                VALUES (SYS(2015), "", 0, "")

            GO BOTTOM IN cursor_4c_GrdMatrizes

            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
                loc_oPg.grd_4c_GrdMatrizes.Refresh()
                loc_oPg.grd_4c_GrdMatrizes.Column1.SetFocus()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir matriz:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnInserirMtzClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirMtzClick - Exclui linha atual de grdMatrizes
    * PUBLIC: BINDEVENT requer metodo publico
    *===========================================================================
    PROCEDURE BtnExcluirMtzClick()
        LOCAL loc_oPg, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            IF !USED("cursor_4c_GrdMatrizes") OR EOF("cursor_4c_GrdMatrizes")
                RETURN
            ENDIF

            SELECT cursor_4c_GrdMatrizes
            IF !MsgConfirma("Excluir este registro de matriz?")
                RETURN
            ENDIF
            DELETE IN cursor_4c_GrdMatrizes
            IF !EOF("cursor_4c_GrdMatrizes")
                SKIP IN cursor_4c_GrdMatrizes
            ENDIF
            IF EOF("cursor_4c_GrdMatrizes") AND RECCOUNT("cursor_4c_GrdMatrizes") > 0
                GO BOTTOM IN cursor_4c_GrdMatrizes
            ENDIF

            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
            IF PEMSTATUS(loc_oPg, "grd_4c_GrdMatrizes", 5)
                loc_oPg.grd_4c_GrdMatrizes.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir matriz:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnExcluirMtzClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Handlers de BINDEVENT para pgDadosFiscais (Page3 de pgf_4c_Dados)
    * Todos PUBLIC - requerido pelo BINDEVENT
    *===========================================================================

    *-- Classificacao Fiscal (clfiscals): Valid
    PROCEDURE ValidarClfiscal()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
            IF EMPTY(loc_cCod)
                IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
                    loc_oPg.txt_4c_Dclfiscal.Value = ""
                ENDIF
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cCod), ;
                "cursor_4c_ClfBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
                IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
                    loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
                ENDIF
                IF USED("cursor_4c_ClfBusca")
                    USE IN cursor_4c_ClfBusca
                ENDIF
            ELSE
                IF USED("cursor_4c_ClfBusca")
                    USE IN cursor_4c_ClfBusca
                ENDIF
                THIS.AbrirBuscaClfiscal()
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_ClfBusca")
                USE IN cursor_4c_ClfBusca
            ENDIF
            MostrarErro("Erro ao validar Classif. Fiscal:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarClfiscal")
        ENDTRY
    ENDPROC

    PROCEDURE TxtClfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarClfiscal()
        ENDIF
    ENDPROC

    *-- Classificacao Fiscal descricao: When
    PROCEDURE TxtDclfiscalWhen()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
            RETURN .F.
        ENDIF
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
               EMPTY(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))
    ENDPROC

    *-- Classificacao Fiscal descricao: Valid (busca por descricao)
    PROCEDURE ValidarDclfiscal()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
                RETURN
            ENDIF
            loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dclfiscal.Value)
            IF EMPTY(loc_cDesc)
                THIS.AbrirBuscaClfiscal()
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SigCdClf WHERE descricaos LIKE " + ;
                EscaparSQL(loc_cDesc + "%"), ;
                "cursor_4c_ClfBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_ClfBusca") AND !EOF("cursor_4c_ClfBusca")
                IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                    loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.codigos)
                ENDIF
                loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_ClfBusca.descricaos)
                IF USED("cursor_4c_ClfBusca")
                    USE IN cursor_4c_ClfBusca
                ENDIF
            ELSE
                IF USED("cursor_4c_ClfBusca")
                    USE IN cursor_4c_ClfBusca
                ENDIF
                THIS.AbrirBuscaClfiscal()
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_ClfBusca")
                USE IN cursor_4c_ClfBusca
            ENDIF
            MostrarErro("Erro ao buscar Classif. Fiscal:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarDclfiscal")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDclfiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDclfiscal()
        ENDIF
    ENDPROC

    *-- Origem Mercadoria (origmercs): Valid
    PROCEDURE ValidarOrigmerc()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
            IF EMPTY(loc_cCod)
                IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
                    loc_oPg.txt_4c_Dorigmerc.Value = ""
                ENDIF
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos = " + EscaparSQL(loc_cCod), ;
                "cursor_4c_OrgBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
                IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
                    loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
                ENDIF
                IF USED("cursor_4c_OrgBusca")
                    USE IN cursor_4c_OrgBusca
                ENDIF
            ELSE
                IF USED("cursor_4c_OrgBusca")
                    USE IN cursor_4c_OrgBusca
                ENDIF
                THIS.AbrirBuscaOrigmerc()
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_OrgBusca")
                USE IN cursor_4c_OrgBusca
            ENDIF
            MostrarErro("Erro ao validar Origem Mercadoria:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarOrigmerc")
        ENDTRY
    ENDPROC

    PROCEDURE TxtOrigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarOrigmerc()
        ENDIF
    ENDPROC

    *-- Origem Mercadoria descricao: When
    PROCEDURE TxtDorigmercWhen()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        IF !PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
            RETURN .F.
        ENDIF
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
               EMPTY(ALLTRIM(loc_oPg.txt_4c_Origmerc.Value))
    ENDPROC

    *-- Origem Mercadoria descricao: Valid
    PROCEDURE ValidarDorigmerc()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
                RETURN
            ENDIF
            loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dorigmerc.Value)
            IF EMPTY(loc_cDesc)
                THIS.AbrirBuscaOrigmerc()
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SIGCDORG WHERE descricaos LIKE " + ;
                EscaparSQL(loc_cDesc + "%"), ;
                "cursor_4c_OrgBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_OrgBusca") AND !EOF("cursor_4c_OrgBusca")
                IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
                    loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(cursor_4c_OrgBusca.codigos)
                ENDIF
                loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_OrgBusca.descricaos)
                IF USED("cursor_4c_OrgBusca")
                    USE IN cursor_4c_OrgBusca
                ENDIF
            ELSE
                IF USED("cursor_4c_OrgBusca")
                    USE IN cursor_4c_OrgBusca
                ENDIF
                THIS.AbrirBuscaOrigmerc()
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_OrgBusca")
                USE IN cursor_4c_OrgBusca
            ENDIF
            MostrarErro("Erro ao buscar Origem Mercadoria:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarDorigmerc")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDorigmerc()
        ENDIF
    ENDPROC

    *-- Situacao Tributaria ICMS (sittricms): Valid
    PROCEDURE ValidarSittricm()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
            IF EMPTY(loc_cCod)
                IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
                    loc_oPg.txt_4c_Dsittricm.Value = ""
                ENDIF
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
                "cursor_4c_IcmBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
                IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
                    loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
                ENDIF
                IF USED("cursor_4c_IcmBusca")
                    USE IN cursor_4c_IcmBusca
                ENDIF
            ELSE
                IF USED("cursor_4c_IcmBusca")
                    USE IN cursor_4c_IcmBusca
                ENDIF
                THIS.AbrirBuscaSittricm()
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_IcmBusca")
                USE IN cursor_4c_IcmBusca
            ENDIF
            MostrarErro("Erro ao validar Sit. Tribut" + CHR(225) + "ria ICMS:" + ;
                CHR(13) + loException.Message, "FormProduto.ValidarSittricm")
        ENDTRY
    ENDPROC

    PROCEDURE TxtSittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarSittricm()
        ENDIF
    ENDPROC

    *-- Situacao Tributaria ICMS descricao: When
    PROCEDURE TxtDsittricmWhen()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        IF !PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
            RETURN .F.
        ENDIF
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
               EMPTY(ALLTRIM(loc_oPg.txt_4c_Sittricm.Value))
    ENDPROC

    *-- Situacao Tributaria ICMS descricao: Valid
    PROCEDURE ValidarDsittricm()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cDesc, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
                RETURN
            ENDIF
            loc_cDesc = ALLTRIM(loc_oPg.txt_4c_Dsittricm.Value)
            IF EMPTY(loc_cDesc)
                THIS.AbrirBuscaSittricm()
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SIGCDICM WHERE descricaos LIKE " + ;
                EscaparSQL(loc_cDesc + "%"), ;
                "cursor_4c_IcmBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_IcmBusca") AND !EOF("cursor_4c_IcmBusca")
                IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
                    loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_IcmBusca.codigos)
                ENDIF
                loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmBusca.descricaos)
                IF USED("cursor_4c_IcmBusca")
                    USE IN cursor_4c_IcmBusca
                ENDIF
            ELSE
                IF USED("cursor_4c_IcmBusca")
                    USE IN cursor_4c_IcmBusca
                ENDIF
                THIS.AbrirBuscaSittricm()
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_IcmBusca")
                USE IN cursor_4c_IcmBusca
            ENDIF
            MostrarErro("Erro ao buscar Sit. Tribut" + CHR(225) + "ria ICMS:" + ;
                CHR(13) + loException.Message, "FormProduto.ValidarDsittricm")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDsittricm()
        ENDIF
    ENDPROC

    *-- Codigo Servico Fiscal: Valid (lookup SIGCDICM, copia para Sittricm)
    PROCEDURE ValidarCodServsFiscal()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos = " + EscaparSQL(loc_cCod), ;
                "cursor_4c_IcmServBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_IcmServBusca") AND !EOF("cursor_4c_IcmServBusca")
                IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
                    loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_IcmServBusca.codigos)
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
                    loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_IcmServBusca.descricaos)
                ENDIF
                IF USED("cursor_4c_IcmServBusca")
                    USE IN cursor_4c_IcmServBusca
                ENDIF
            ELSE
                IF USED("cursor_4c_IcmServBusca")
                    USE IN cursor_4c_IcmServBusca
                ENDIF
                THIS.AbrirBuscaCodServsFiscal()
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_IcmServBusca")
                USE IN cursor_4c_IcmServBusca
            ENDIF
            MostrarErro("Erro ao validar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal:" + ;
                CHR(13) + loException.Message, "FormProduto.ValidarCodServsFiscal")
        ENDTRY
    ENDPROC

    PROCEDURE TxtCodServsFiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCodServsFiscal()
        ENDIF
    ENDPROC

    *-- Tipo de Tributacao (tptribs): Valid
    PROCEDURE ValidarTpTrib()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT tipos, descs FROM SigPrTri WHERE tipos = " + EscaparSQL(loc_cCod), ;
                "cursor_4c_TpTribBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_TpTribBusca") AND !EOF("cursor_4c_TpTribBusca")
                IF USED("cursor_4c_TpTribBusca")
                    USE IN cursor_4c_TpTribBusca
                ENDIF
            ELSE
                IF USED("cursor_4c_TpTribBusca")
                    USE IN cursor_4c_TpTribBusca
                ENDIF
                THIS.AbrirBuscaTpTrib()
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_TpTribBusca")
                USE IN cursor_4c_TpTribBusca
            ENDIF
            MostrarErro("Erro ao validar Tipo de Tributa" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loException.Message, "FormProduto.ValidarTpTrib")
        ENDTRY
    ENDPROC

    PROCEDURE TxtTpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarTpTrib()
        ENDIF
    ENDPROC

    *-- IAT (iats): Valid - aceita 'A','T' ou vazio
    PROCEDURE ValidarIat()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        LOCAL loc_oPg, loc_cVal, loc_lSucesso, loException
        loc_lSucesso = .T.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Iat", 5)
                loc_lSucesso = .T.
            ENDIF
            loc_cVal = ALLTRIM(loc_oPg.txt_4c_Iat.Value)
            IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "A", "T")
                MsgAviso("IAT deve ser 'A' (Arredondamento) ou 'T' (Truncamento).")
                loc_oPg.txt_4c_Iat.SetFocus()
                loc_lSucesso = .F.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar IAT:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarIat")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE TxtIatKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarIat()
        ENDIF
    ENDPROC

    *-- Combo IPI (ipis): When - edicao somente em INCLUIR/ALTERAR
    PROCEDURE CboIpiWhen()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *-- Aliquota IPI (nAliqipis): Valid - verifica contra padrao da clf fiscal
    PROCEDURE ValidarAliqIPI()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cClf, loc_nAliq, loc_nAliqRef, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5) OR !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                RETURN
            ENDIF
            loc_nAliq = loc_oPg.txt_4c_AliqIPI.Value
            loc_cClf  = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
            IF EMPTY(loc_cClf) OR loc_nAliq = 0
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT aipis FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
                "cursor_4c_ClfAliq")
            IF loc_nRet > 0 AND USED("cursor_4c_ClfAliq") AND !EOF("cursor_4c_ClfAliq")
                loc_nAliqRef = cursor_4c_ClfAliq.aipis
                IF loc_nAliqRef > 0 AND ABS(loc_nAliq - loc_nAliqRef) > 0.001
                    MsgAviso("Al" + CHR(237) + "quota IPI informada (" + ;
                        TRANSFORM(loc_nAliq) + "%) difere da padr" + CHR(227) + ;
                        "o da classifica" + CHR(231) + CHR(227) + "o fiscal (" + ;
                        TRANSFORM(loc_nAliqRef) + "%).")
                ENDIF
            ENDIF
            IF USED("cursor_4c_ClfAliq")
                USE IN cursor_4c_ClfAliq
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_ClfAliq")
                USE IN cursor_4c_ClfAliq
            ENDIF
            MostrarErro("Erro ao validar Al" + CHR(237) + "quota IPI:" + ;
                CHR(13) + loException.Message, "FormProduto.ValidarAliqIPI")
        ENDTRY
    ENDPROC

    PROCEDURE TxtAliqIPIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarAliqIPI()
        ENDIF
    ENDPROC

    *-- Extensao IPI (extipi): When - habilitado quando clf fiscal tem ipiprods='S'
    PROCEDURE TxtExtipipWhen()
        LOCAL loc_oPg, loc_cClf, loc_nRet, loc_lPermite, loException
        loc_lPermite = .F.
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                loc_lResultado = .F.
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                loc_lResultado = .F.
            ENDIF
            loc_cClf = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
            IF EMPTY(loc_cClf)
                loc_lResultado = .F.
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT ipiprods FROM SigCdClf WHERE codigos = " + EscaparSQL(loc_cClf), ;
                "cursor_4c_ClfIpiProd")
            IF loc_nRet > 0 AND USED("cursor_4c_ClfIpiProd") AND !EOF("cursor_4c_ClfIpiProd")
                loc_lPermite = (ALLTRIM(cursor_4c_ClfIpiProd.ipiprods) = "S")
            ENDIF
            IF USED("cursor_4c_ClfIpiProd")
                USE IN cursor_4c_ClfIpiProd
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_ClfIpiProd")
                USE IN cursor_4c_ClfIpiProd
            ENDIF
        ENDTRY
        RETURN loc_lPermite
    ENDPROC

    *-- Botao Descricao Fiscal: Click - gera descricao fiscal via fGerDescFis
    PROCEDURE CmdBtnDescFisClick()
        LOCAL loc_oPg, loc_cCpros, loc_cDescFis, loc_oPg1, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
            IF EMPTY(loc_cCpros)
                loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
                IF PEMSTATUS(loc_oPg1, "txt_4c_Cpros", 5)
                    loc_cCpros = ALLTRIM(loc_oPg1.txt_4c_Cpros.Value)
                ENDIF
            ENDIF
            IF EMPTY(loc_cCpros)
                MsgAviso("Salve o produto antes de gerar a descri" + CHR(231) + CHR(227) + "o fiscal.")
                RETURN
            ENDIF
            loc_cDescFis = fGerDescFis(0, loc_cCpros, go_4c_Sistema.cCodEmpresa, .F.)
            IF !EMPTY(ALLTRIM(loc_cDescFis))
                IF PEMSTATUS(loc_oPg, "obj_4c_Mgetdescfi", 5)
                    loc_oPg.obj_4c_Mgetdescfi.Value = loc_cDescFis
                ENDIF
                THIS.this_oBusinessObject.this_mDescfis = loc_cDescFis
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal:" + ;
                CHR(13) + loException.Message, "FormProduto.CmdBtnDescFisClick")
        ENDTRY
    ENDPROC

    *-- Metal (metals): Valid - lookup SigCdMtl WHERE tipos='M'
    PROCEDURE ValidarMetal()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
            IF EMPTY(loc_cCod)
                IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
                    loc_oPg.txt_4c_DesMetal.Value = ""
                ENDIF
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
                " AND tipos = 'M'", ;
                "cursor_4c_MetalBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_MetalBusca") AND !EOF("cursor_4c_MetalBusca")
                IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
                    loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(cursor_4c_MetalBusca.descs)
                ENDIF
                IF USED("cursor_4c_MetalBusca")
                    USE IN cursor_4c_MetalBusca
                ENDIF
            ELSE
                IF USED("cursor_4c_MetalBusca")
                    USE IN cursor_4c_MetalBusca
                ENDIF
                THIS.AbrirBuscaMetal()
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_MetalBusca")
                USE IN cursor_4c_MetalBusca
            ENDIF
            MostrarErro("Erro ao validar Metal:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarMetal")
        ENDTRY
    ENDPROC

    PROCEDURE TxtMetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMetal()
        ENDIF
    ENDPROC

    *-- Teor (teors): Valid - lookup SigCdMtl WHERE tipos<>'M'
    PROCEDURE ValidarTeor()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
            IF EMPTY(loc_cCod)
                IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
                    loc_oPg.txt_4c_DesTeor.Value = ""
                ENDIF
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descs FROM SigCdMtl WHERE codigos = " + EscaparSQL(loc_cCod) + ;
                " AND tipos <> 'M'", ;
                "cursor_4c_TeorBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_TeorBusca") AND !EOF("cursor_4c_TeorBusca")
                IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
                    loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(cursor_4c_TeorBusca.descs)
                ENDIF
                IF USED("cursor_4c_TeorBusca")
                    USE IN cursor_4c_TeorBusca
                ENDIF
            ELSE
                IF USED("cursor_4c_TeorBusca")
                    USE IN cursor_4c_TeorBusca
                ENDIF
                THIS.AbrirBuscaTeor()
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_TeorBusca")
                USE IN cursor_4c_TeorBusca
            ENDIF
            MostrarErro("Erro ao validar Teor:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarTeor")
        ENDTRY
    ENDPROC

    PROCEDURE TxtTeorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarTeor()
        ENDIF
    ENDPROC

    *-- Moeda Valor (moedas): Valid - lookup SigCdMoe
    PROCEDURE ValidarMvalorFiscal()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
                RETURN
            ENDIF
            loc_cCod = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
            IF EMPTY(loc_cCod)
                RETURN
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds = " + EscaparSQL(loc_cCod), ;
                "cursor_4c_MoeFiscalBusca")
            IF loc_nRet > 0 AND USED("cursor_4c_MoeFiscalBusca") AND !EOF("cursor_4c_MoeFiscalBusca")
                IF USED("cursor_4c_MoeFiscalBusca")
                    USE IN cursor_4c_MoeFiscalBusca
                ENDIF
            ELSE
                IF USED("cursor_4c_MoeFiscalBusca")
                    USE IN cursor_4c_MoeFiscalBusca
                ENDIF
                THIS.AbrirBuscaMvalorFiscal()
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_MoeFiscalBusca")
                USE IN cursor_4c_MoeFiscalBusca
            ENDIF
            MostrarErro("Erro ao validar Moeda Valor:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarMvalorFiscal")
        ENDTRY
    ENDPROC

    PROCEDURE TxtMvalorFiscalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarMvalorFiscal()
        ENDIF
    ENDPROC

    *-- Centro de Custo: Grupo (gruccus): Valid
    PROCEDURE TxtGruccusValid()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cGrp, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
                RETURN
            ENDIF
            loc_cGrp = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
            IF EMPTY(loc_cGrp)
                IF PEMSTATUS(loc_oPg, "txt_4c__dgruccus", 5)
                    loc_oPg.txt_4c__dgruccus.Value = ""
                ENDIF
                RETURN
            ENDIF
            fAcessoContab(Usuar, "C", loc_cGrp)
        CATCH TO loException
            MostrarErro("Erro ao validar Grupo CC:" + CHR(13) + loException.Message, ;
                "FormProduto.TxtGruccusValid")
        ENDTRY
    ENDPROC

    PROCEDURE TxtGruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.TxtGruccusValid()
        ENDIF
    ENDPROC

    *-- Centro de Custo: Descricao Grupo (dgruccus): When
    PROCEDURE TxtDgruccusWhen()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
            RETURN .F.
        ENDIF
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
               EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
    ENDPROC

    *-- Centro de Custo: Descricao Grupo (dgruccus): Valid
    PROCEDURE TxtDgruccusValid()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cDesc, loException
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cDesc = ALLTRIM(loc_oPg.txt_4c__dgruccus.Value)
            fAcessoContab(Usuar, "D", loc_cDesc)
        CATCH TO loException
            MostrarErro("Erro ao buscar Descri" + CHR(231) + CHR(227) + "o Grupo CC:" + ;
                CHR(13) + loException.Message, "FormProduto.TxtDgruccusValid")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDgruccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.TxtDgruccusValid()
        ENDIF
    ENDPROC

    *-- Centro de Custo: Conta (contaccus): When
    PROCEDURE TxtContaccusWhen()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
            RETURN .F.
        ENDIF
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
               !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value))
    ENDPROC

    *-- Centro de Custo: Conta (contaccus): Valid
    PROCEDURE TxtContaccusValid()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cGrp, loc_cCta, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                RETURN
            ENDIF
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cGrp = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
            loc_cCta = ALLTRIM(loc_oPg.txt_4c__contaccus.Value)
            IF EMPTY(loc_cCta)
                IF PEMSTATUS(loc_oPg, "txt_4c__dcontaccus", 5)
                    loc_oPg.txt_4c__dcontaccus.Value = ""
                ENDIF
                RETURN
            ENDIF
            fAcessoContas(Usuar, loc_cGrp, "C", loc_cCta)
        CATCH TO loException
            MostrarErro("Erro ao validar Conta CC:" + CHR(13) + loException.Message, ;
                "FormProduto.TxtContaccusValid")
        ENDTRY
    ENDPROC

    PROCEDURE TxtContaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.TxtContaccusValid()
        ENDIF
    ENDPROC

    *-- Centro de Custo: Descricao Conta (dcontaccus): When
    PROCEDURE TxtDcontaccusWhen()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
        IF !PEMSTATUS(loc_oPg, "txt_4c__gruccus", 5)
            RETURN .F.
        ENDIF
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND ;
               !EMPTY(ALLTRIM(loc_oPg.txt_4c__gruccus.Value)) AND ;
               EMPTY(ALLTRIM(loc_oPg.txt_4c__contaccus.Value))
    ENDPROC

    *-- Centro de Custo: Descricao Conta (dcontaccus): Valid
    PROCEDURE TxtDcontaccusValid()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cGrp, loc_cDesc, loException
        TRY
            loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cGrp  = ALLTRIM(loc_oPg.txt_4c__gruccus.Value)
            loc_cDesc = ALLTRIM(loc_oPg.txt_4c__dcontaccus.Value)
            fAcessoContas(Usuar, loc_cGrp, "D", loc_cDesc)
        CATCH TO loException
            MostrarErro("Erro ao buscar Descri" + CHR(231) + CHR(227) + "o Conta CC:" + ;
                CHR(13) + loException.Message, "FormProduto.TxtDcontaccusValid")
        ENDTRY
    ENDPROC

    PROCEDURE TxtDcontaccusKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.TxtDcontaccusValid()
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirBusca* - Helpers de lookup para pgDadosFiscais (Page3)
    *===========================================================================

    *-- Classificacao Fiscal (SigCdClf: codigos/descricaos)
    PROCEDURE AbrirBuscaClfiscal()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SigCdClf WHERE codigos LIKE " + ;
                EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
                "cursor_4c_ClfBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_ClfBusca") OR EOF("cursor_4c_ClfBusca")
                IF USED("cursor_4c_ClfBusca")
                    USE IN cursor_4c_ClfBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descricaos FROM SigCdClf ORDER BY codigos", ;
                    "cursor_4c_ClfBusca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_ClfBusca", "codigos", "descricaos", ;
                    "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
                        loc_oPg.txt_4c_Clfiscal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
                        loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
            IF USED("cursor_4c_ClfBusca")
                USE IN cursor_4c_ClfBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_ClfBusca")
                USE IN cursor_4c_ClfBusca
            ENDIF
            MostrarErro("Erro ao buscar Classif. Fiscal:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaClfiscal")
        ENDTRY
    ENDPROC

    *-- Origem Mercadoria (SIGCDORG: codigos/descricaos)
    PROCEDURE AbrirBuscaOrigmerc()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
                loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Origmerc.Value)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SIGCDORG WHERE codigos LIKE " + ;
                EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
                "cursor_4c_OrgBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_OrgBusca") OR EOF("cursor_4c_OrgBusca")
                IF USED("cursor_4c_OrgBusca")
                    USE IN cursor_4c_OrgBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descricaos FROM SIGCDORG ORDER BY codigos", ;
                    "cursor_4c_OrgBusca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_OrgBusca", "codigos", "descricaos", ;
                    "Buscar Origem Mercadoria")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    IF PEMSTATUS(loc_oPg, "txt_4c_Origmerc", 5)
                        loc_oPg.txt_4c_Origmerc.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dorigmerc", 5)
                        loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
            IF USED("cursor_4c_OrgBusca")
                USE IN cursor_4c_OrgBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_OrgBusca")
                USE IN cursor_4c_OrgBusca
            ENDIF
            MostrarErro("Erro ao buscar Origem Mercadoria:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaOrigmerc")
        ENDTRY
    ENDPROC

    *-- Situacao Tributaria ICMS (SIGCDICM: codigos/descricaos)
    PROCEDURE AbrirBuscaSittricm()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
                loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Sittricm.Value)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
                EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
                "cursor_4c_IcmBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_IcmBusca") OR EOF("cursor_4c_IcmBusca")
                IF USED("cursor_4c_IcmBusca")
                    USE IN cursor_4c_IcmBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
                    "cursor_4c_IcmBusca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_IcmBusca", "codigos", "descricaos", ;
                    "Buscar Sit. Tributaria ICMS")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
                        loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
                        loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
            IF USED("cursor_4c_IcmBusca")
                USE IN cursor_4c_IcmBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_IcmBusca")
                USE IN cursor_4c_IcmBusca
            ENDIF
            MostrarErro("Erro ao buscar Sit. Tributaria ICMS:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaSittricm")
        ENDTRY
    ENDPROC

    *-- Codigo Servico Fiscal (SIGCDICM: codigos/descricaos)
    PROCEDURE AbrirBuscaCodServsFiscal()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
                loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Codigo.Value)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descricaos FROM SIGCDICM WHERE codigos LIKE " + ;
                EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
                "cursor_4c_CodServBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_CodServBusca") OR EOF("cursor_4c_CodServBusca")
                IF USED("cursor_4c_CodServBusca")
                    USE IN cursor_4c_CodServBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descricaos FROM SIGCDICM ORDER BY codigos", ;
                    "cursor_4c_CodServBusca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_CodServBusca", "codigos", "descricaos", ;
                    "Buscar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    IF PEMSTATUS(loc_oPg, "txt_4c_Codigo", 5)
                        loc_oPg.txt_4c_Codigo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Sittricm", 5)
                        loc_oPg.txt_4c_Sittricm.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_Dsittricm", 5)
                        loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
            IF USED("cursor_4c_CodServBusca")
                USE IN cursor_4c_CodServBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_CodServBusca")
                USE IN cursor_4c_CodServBusca
            ENDIF
            MostrarErro("Erro ao buscar C" + CHR(243) + "d. Servi" + CHR(231) + "o Fiscal:" + ;
                CHR(13) + loException.Message, "FormProduto.AbrirBuscaCodServsFiscal")
        ENDTRY
    ENDPROC

    *-- Tipo Tributacao (SigPrTri: tipos/descs)
    PROCEDURE AbrirBuscaTpTrib()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
                loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_TpTrib.Value)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT tipos, descs FROM SigPrTri WHERE tipos LIKE " + ;
                EscaparSQL(loc_cValAtual + "%") + " ORDER BY tipos", ;
                "cursor_4c_TpTribBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_TpTribBusca") OR EOF("cursor_4c_TpTribBusca")
                IF USED("cursor_4c_TpTribBusca")
                    USE IN cursor_4c_TpTribBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT tipos, descs FROM SigPrTri ORDER BY tipos", ;
                    "cursor_4c_TpTribBusca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_TpTribBusca", "tipos", "descs", ;
                    "Buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    IF PEMSTATUS(loc_oPg, "txt_4c_TpTrib", 5)
                        loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
            IF USED("cursor_4c_TpTribBusca")
                USE IN cursor_4c_TpTribBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_TpTribBusca")
                USE IN cursor_4c_TpTribBusca
            ENDIF
            MostrarErro("Erro ao buscar Tipo de Tributa" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loException.Message, "FormProduto.AbrirBuscaTpTrib")
        ENDTRY
    ENDPROC

    *-- Metal (SigCdMtl: codigos/descs WHERE tipos='M')
    PROCEDURE AbrirBuscaMetal()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
                loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Metal.Value)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descs FROM SigCdMtl " + ;
                "WHERE tipos = 'M' AND codigos LIKE " + ;
                EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
                "cursor_4c_MetalBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_MetalBusca") OR EOF("cursor_4c_MetalBusca")
                IF USED("cursor_4c_MetalBusca")
                    USE IN cursor_4c_MetalBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descs FROM SigCdMtl WHERE tipos = 'M' ORDER BY codigos", ;
                    "cursor_4c_MetalBusca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_MetalBusca", "codigos", "descs", "Buscar Metal")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    IF PEMSTATUS(loc_oPg, "txt_4c_Metal", 5)
                        loc_oPg.txt_4c_Metal.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_DesMetal", 5)
                        loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
            IF USED("cursor_4c_MetalBusca")
                USE IN cursor_4c_MetalBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_MetalBusca")
                USE IN cursor_4c_MetalBusca
            ENDIF
            MostrarErro("Erro ao buscar Metal:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaMetal")
        ENDTRY
    ENDPROC

    *-- Teor (SigCdMtl: codigos/descs WHERE tipos<>'M')
    PROCEDURE AbrirBuscaTeor()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
                loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Teor.Value)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT codigos, descs FROM SigCdMtl " + ;
                "WHERE tipos <> 'M' AND codigos LIKE " + ;
                EscaparSQL(loc_cValAtual + "%") + " ORDER BY codigos", ;
                "cursor_4c_TeorBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_TeorBusca") OR EOF("cursor_4c_TeorBusca")
                IF USED("cursor_4c_TeorBusca")
                    USE IN cursor_4c_TeorBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codigos, descs FROM SigCdMtl WHERE tipos <> 'M' ORDER BY codigos", ;
                    "cursor_4c_TeorBusca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_TeorBusca", "codigos", "descs", "Buscar Teor")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    IF PEMSTATUS(loc_oPg, "txt_4c_Teor", 5)
                        loc_oPg.txt_4c_Teor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_DesTeor", 5)
                        loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
            IF USED("cursor_4c_TeorBusca")
                USE IN cursor_4c_TeorBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_TeorBusca")
                USE IN cursor_4c_TeorBusca
            ENDIF
            MostrarErro("Erro ao buscar Teor:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaTeor")
        ENDTRY
    ENDPROC

    *-- Moeda Valor (SigCdMoe: cmoeds/dmoeds)
    PROCEDURE AbrirBuscaMvalorFiscal()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
                loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_Mvalor.Value)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT cmoeds, dmoeds FROM SigCdMoe WHERE cmoeds LIKE " + ;
                EscaparSQL(loc_cValAtual + "%") + " ORDER BY cmoeds", ;
                "cursor_4c_MoeFiscalBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_MoeFiscalBusca") OR EOF("cursor_4c_MoeFiscalBusca")
                IF USED("cursor_4c_MoeFiscalBusca")
                    USE IN cursor_4c_MoeFiscalBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT cmoeds, dmoeds FROM SigCdMoe ORDER BY cmoeds", ;
                    "cursor_4c_MoeFiscalBusca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_MoeFiscalBusca", "cmoeds", "dmoeds", ;
                    "Buscar Moeda")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    IF PEMSTATUS(loc_oPg, "txt_4c_Mvalor", 5)
                        loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
            IF USED("cursor_4c_MoeFiscalBusca")
                USE IN cursor_4c_MoeFiscalBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_MoeFiscalBusca")
                USE IN cursor_4c_MoeFiscalBusca
            ENDIF
            MostrarErro("Erro ao buscar Moeda:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaMvalorFiscal")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarPgpgDesigner - Configura Page7 "Designer" do pgf_4c_Dados
    * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgDesigner
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgDesigner(par_oPg)
        LOCAL loc_oPg, loc_oGrid, loc_oErro
        TRY
            loc_oPg = par_oPg

            *-- Cursors placeholder (preenchidos pelo BO ao carregar produto)
            IF !USED("cursor_4c_GrdDesigner")
                CREATE CURSOR cursor_4c_GrdDesigner ( ;
                    dtini D, dtfim D, usuarios C(10), codcads C(10))
            ENDIF
            IF !USED("cursor_4c_GrdArquivos")
                CREATE CURSOR cursor_4c_GrdArquivos (arqnome C(200))
            ENDIF
            IF !USED("crTarefas")
                CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    SQLEXEC(gnConnHandle, ;
                        "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
                        "FROM SigCdCad ORDER BY codcads", ;
                        "crTarefas")
                ENDIF
            ENDIF

            *-- grdDesigner: grade historico de designer (4 colunas)
            *-- Original: top=145, left=10, width=495, height=180
            loc_oPg.AddObject("grd_4c_GrdDesigner", "Grid")
            WITH loc_oPg.grd_4c_GrdDesigner
                .Top        = 145
                .Left       = 10
                .Width      = 495
                .Height     = 180
                .FontName   = "Tahoma"
                .FontSize   = 8
                .RecordMark = .F.
                .RowHeight  = 16
                .ScrollBars = 2
                .TabStop    = .F.
                .Visible    = .T.
            ENDWITH
            loc_oPg.grd_4c_GrdDesigner.ColumnCount  = 4
            loc_oPg.grd_4c_GrdDesigner.RecordSource = "cursor_4c_GrdDesigner"
            loc_oGrid = loc_oPg.grd_4c_GrdDesigner

            loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdDesigner.dtini"
            loc_oGrid.Column1.Width           = 100
            loc_oGrid.Column1.ColumnOrder     = 1
            loc_oGrid.Column1.Movable         = .F.
            loc_oGrid.Column1.Resizable       = .F.
            loc_oGrid.Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"

            loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdDesigner.dtfim"
            loc_oGrid.Column2.Width           = 100
            loc_oGrid.Column2.ColumnOrder     = 2
            loc_oGrid.Column2.Movable         = .F.
            loc_oGrid.Column2.Resizable       = .F.
            loc_oGrid.Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"

            loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdDesigner.usuarios"
            loc_oGrid.Column3.Width           = 100
            loc_oGrid.Column3.ColumnOrder     = 3
            loc_oGrid.Column3.Movable         = .F.
            loc_oGrid.Column3.Resizable       = .F.
            loc_oGrid.Column3.Header1.Caption = "Usu" + CHR(225) + "rio"

            loc_oGrid.Column4.ControlSource   = "cursor_4c_GrdDesigner.codcads"
            loc_oGrid.Column4.Width           = 193
            loc_oGrid.Column4.ColumnOrder     = 4
            loc_oGrid.Column4.Movable         = .F.
            loc_oGrid.Column4.Resizable       = .F.
            loc_oGrid.Column4.Header1.Caption = "Tarefa"
            BINDEVENT(loc_oGrid.Column4.Text1, "Valid", THIS, "GrdDesignerCol4TarefaValid")

            *-- Say31: label "Observacao da Tarefa"
            *-- Original: top=129, left=583, width=126, height=15
            loc_oPg.AddObject("lbl_4c_Label31", "Label")
            WITH loc_oPg.lbl_4c_Label31
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
                .Top       = 129
                .Left      = 583
                .Width     = 126
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getObsTarefas: editbox (fwmemo) observacao da tarefa
            *-- Original: top=145, left=584, width=407, height=113
            loc_oPg.AddObject("obj_4c_GetObsTarefas", "EditBox")
            WITH loc_oPg.obj_4c_GetObsTarefas
                .Top        = 145
                .Left       = 584
                .Width      = 407
                .Height     = 113
                .FontName   = "Tahoma"
                .FontSize   = 8
                .ScrollBars = 2
                .ReadOnly   = .F.
                .Visible    = .T.
            ENDWITH

            *-- btnIniTarefa: botao Inicio de Tarefa
            *-- Original: top=146, left=509, width=42, height=42
            loc_oPg.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
            WITH loc_oPg.cmd_4c_BtnIniTarefa
                .Caption       = "IN"
                .Top           = 146
                .Left          = 509
                .Width         = 42
                .Height        = 42
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")

            *-- btnFimTarefa: botao Fim de Tarefa
            *-- Original: top=188, left=509, width=42, height=42
            loc_oPg.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
            WITH loc_oPg.cmd_4c_BtnFimTarefa
                .Caption       = "FI"
                .Top           = 188
                .Left          = 509
                .Width         = 42
                .Height        = 42
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_BtnFimTarefa, "Click", THIS, "BtnFimTarefaClick")

            *-- Say1: label "Inspiracao"
            *-- Original: top=265, left=583, width=62, height=15
            loc_oPg.AddObject("lbl_4c_Label1", "Label")
            WITH loc_oPg.lbl_4c_Label1
                .Caption   = "Inspira" + CHR(231) + CHR(227) + "o"
                .Top       = 265
                .Left      = 583
                .Width     = 62
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- getObsInsp: editbox (fwmemo) observacao de inspiracao
            *-- Original: top=281, left=584, width=407, height=113
            loc_oPg.AddObject("obj_4c_GetObsInsp", "EditBox")
            WITH loc_oPg.obj_4c_GetObsInsp
                .Top        = 281
                .Left       = 584
                .Width      = 407
                .Height     = 113
                .FontName   = "Tahoma"
                .FontSize   = 8
                .ScrollBars = 2
                .ReadOnly   = .F.
                .Visible    = .T.
            ENDWITH

            *-- grdArquivos: grade de arquivos do designer (1 coluna)
            *-- Original: top=334, left=10, width=495, height=164
            loc_oPg.AddObject("grd_4c_GrdArquivos", "Grid")
            WITH loc_oPg.grd_4c_GrdArquivos
                .Top        = 334
                .Left       = 10
                .Width      = 495
                .Height     = 164
                .FontName   = "Tahoma"
                .FontSize   = 8
                .RecordMark = .F.
                .RowHeight  = 16
                .ScrollBars = 2
                .TabStop    = .F.
                .Visible    = .T.
            ENDWITH
            loc_oPg.grd_4c_GrdArquivos.ColumnCount  = 1
            loc_oPg.grd_4c_GrdArquivos.RecordSource = "cursor_4c_GrdArquivos"
            loc_oPg.grd_4c_GrdArquivos.Column1.ControlSource   = "cursor_4c_GrdArquivos.arqnome"
            loc_oPg.grd_4c_GrdArquivos.Column1.Width           = 493
            loc_oPg.grd_4c_GrdArquivos.Column1.ColumnOrder     = 1
            loc_oPg.grd_4c_GrdArquivos.Column1.Movable         = .F.
            loc_oPg.grd_4c_GrdArquivos.Column1.Resizable       = .F.
            loc_oPg.grd_4c_GrdArquivos.Column1.Header1.Caption = "Arquivos Para Designer"

            *-- btnInsArqs: botao Inserir Arquivo
            *-- Original: top=335, left=509, width=42, height=42
            loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
            WITH loc_oPg.cmd_4c_BtnInsArqs
                .Caption       = "+"
                .Top           = 335
                .Left          = 509
                .Width         = 42
                .Height        = 42
                .FontName      = "Tahoma"
                .FontSize      = 12
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")

            *-- btnExcArqs: botao Excluir Arquivo selecionado
            *-- Original: top=377, left=509, width=42, height=42
            loc_oPg.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
            WITH loc_oPg.cmd_4c_BtnExcArqs
                .Caption       = "-"
                .Top           = 377
                .Left          = 509
                .Width         = 42
                .Height        = 42
                .FontName      = "Tahoma"
                .FontSize      = 12
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_BtnExcArqs, "Click", THIS, "BtnExcArqsClick")

            *-- btnOpnArqs: botao Abrir Arquivo selecionado
            *-- Original: top=419, left=509, width=42, height=42
            loc_oPg.AddObject("cmd_4c_BtnOpnArqs", "CommandButton")
            WITH loc_oPg.cmd_4c_BtnOpnArqs
                .Caption       = "AB"
                .Top           = 419
                .Left          = 509
                .Width         = 42
                .Height        = 42
                .FontName      = "Tahoma"
                .FontSize      = 8
                .FontBold      = .T.
                .BackColor     = RGB(255, 255, 255)
                .Themes        = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.cmd_4c_BtnOpnArqs, "Click", THIS, "BtnOpnArqsClick")

            *-- Shape1: retangulo decorativo sobre area de imagem
            *-- Original: top=400, left=584, width=407, height=202
            loc_oPg.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPg.shp_4c_Shape1
                .Top     = 400
                .Left    = 584
                .Width   = 407
                .Height  = 202
                .Visible = .T.
            ENDWITH

            *-- imgArqJpg: imagem do arquivo selecionado (inicialmente oculta)
            *-- Original: top=402, left=586, width=403, height=198, visible=false
            loc_oPg.AddObject("img_4c_ImgArqJpg", "Image")
            WITH loc_oPg.img_4c_ImgArqJpg
                .Top     = 402
                .Left    = 586
                .Width   = 403
                .Height  = 198
                .Visible = .F.
            ENDWITH

            *-- Say19: label secao "Dados do Lancamento"
            *-- Original: top=504, left=18, width=127, height=15
            loc_oPg.AddObject("lbl_4c_Label19", "Label")
            WITH loc_oPg.lbl_4c_Label19
                .Caption   = "Dados do Lan" + CHR(231) + "amento"
                .Top       = 504
                .Left      = 18
                .Width     = 127
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Line1: linha separadora da secao
            *-- Original: top=518, left=14, width=317, height=0
            loc_oPg.AddObject("lin_4c_Line1", "Line")
            WITH loc_oPg.lin_4c_Line1
                .Top     = 518
                .Left    = 14
                .Width   = 317
                .Height  = 1
                .Visible = .T.
            ENDWITH

            *-- Say6: label "Data Apr. Amostra :"
            *-- Original: top=531, left=16, width=99, height=15
            loc_oPg.AddObject("lbl_4c_Label6", "Label")
            WITH loc_oPg.lbl_4c_Label6
                .Caption   = "Data Apr. Amostra :"
                .Top       = 531
                .Left      = 16
                .Width     = 99
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- Get_DtAprAmo: textbox data aprovacao de amostra (fweditdata)
            *-- Original: top=527, left=118, width=80, height=23
            loc_oPg.AddObject("txt_4c_DtAprAmo", "TextBox")
            WITH loc_oPg.txt_4c_DtAprAmo
                .Top           = 527
                .Left          = 118
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "99/99/9999"
                .Value         = {}
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH

            *-- Say4: label "Desenvolvido por :"
            *-- Original: top=556, left=23, width=92, height=15
            loc_oPg.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oPg.lbl_4c_Label4
                .Caption   = "Desenvolvido por :"
                .Top       = 556
                .Left      = 23
                .Width     = 92
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- GetDesLacto: textbox usuario desenvolvedor (fwget -> SigCdUsu.usuarios)
            *-- Original: top=552, left=118, width=91, height=22
            loc_oPg.AddObject("txt_4c_DesLacto", "TextBox")
            WITH loc_oPg.txt_4c_DesLacto
                .Top           = 552
                .Left          = 118
                .Width         = 91
                .Height        = 22
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .MaxLength     = 10
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_DesLacto, "KeyPress", THIS, "ValidarDesLacto")

            *-- Say5: label "Criado por :"
            *-- Original: top=580, left=56, width=59, height=15
            loc_oPg.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oPg.lbl_4c_Label5
                .Caption   = "Criado por :"
                .Top       = 580
                .Left      = 56
                .Width     = 59
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            *-- GetCriaLacto: textbox usuario criador (fwget -> SigCdUsu.usuarios)
            *-- Original: top=576, left=118, width=91, height=22
            loc_oPg.AddObject("txt_4c_CriaLacto", "TextBox")
            WITH loc_oPg.txt_4c_CriaLacto
                .Top           = 576
                .Left          = 118
                .Width         = 91
                .Height        = 22
                .FontName      = "Tahoma"
                .FontSize      = 8
                .Value         = ""
                .MaxLength     = 10
                .SpecialEffect = 1
                .Visible       = .T.
            ENDWITH
            BINDEVENT(loc_oPg.txt_4c_CriaLacto, "KeyPress", THIS, "ValidarCriaLacto")

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar pgDesigner:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "FormProduto.ConfigurarPgpgDesigner")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Handlers de BINDEVENT para pgDesigner (Page7)
    * Todos PUBLIC - requerido pelo BINDEVENT
    *===========================================================================

    *-- grdDesigner Column4 (Tarefa/CodCads): Valid - lookup crTarefas por CodCads
    PROCEDURE GrdDesignerCol4TarefaValid()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        LOCAL loc_cCodCads, loc_lSucesso, loException
        loc_lSucesso = .T.
        TRY
            IF USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
                loc_cCodCads = ALLTRIM(cursor_4c_GrdDesigner.codcads)
                IF !EMPTY(loc_cCodCads)
                    IF USED("crTarefas")
                        SELECT crTarefas
                        GO TOP
                        LOCATE FOR ALLTRIM(CodCads) = loc_cCodCads
                        IF EOF("crTarefas")
                            THIS.AbrirBuscaTarefaDesigner()
                        ENDIF
                        IF USED("cursor_4c_GrdDesigner")
                            SELECT cursor_4c_GrdDesigner
                        ENDIF
                    ELSE
                        THIS.AbrirBuscaTarefaDesigner()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar Tarefa:" + CHR(13) + loException.Message, ;
                "FormProduto.GrdDesignerCol4TarefaValid")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    PROCEDURE AbrirBuscaTarefaDesigner()
        LOCAL loc_oBusca, loc_nRet, loException
        TRY
            IF !USED("crTarefas")
                CREATE CURSOR crTarefas (CodCads C(10), DesCads C(40))
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT LEFT(codcads, 10) AS CodCads, descads AS DesCads " + ;
                    "FROM SigCdCad ORDER BY codcads", ;
                    "crTarefas")
                IF loc_nRet <= 0 OR EOF("crTarefas")
                    MsgAviso("Sem tarefas cadastradas para selecionar.")
                    RETURN
                ENDIF
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("crTarefas", "CodCads", "DesCads", ;
                    "Selecionar Tarefa")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado) AND ;
                    USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
                    SELECT cursor_4c_GrdDesigner
                    REPLACE cursor_4c_GrdDesigner.codcads WITH ;
                        ALLTRIM(loc_oBusca.cCodigoSelecionado)
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar Tarefa:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaTarefaDesigner")
        ENDTRY
    ENDPROC

    *-- GetDesLacto (txt_4c_DesLacto): Valid - valida usuario desenvolvedor em SigCdUsu
    PROCEDURE ValidarDesLacto()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
            loc_cCod = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
                loc_cCod = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
            ENDIF
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT usuarios FROM SigCdUsu " + ;
                    "WHERE usuarios = " + EscaparSQL(loc_cCod) + " AND cativos <> 'N'", ;
                    "cursor_4c_DesLactoBusca")
                IF loc_nRet > 0 AND USED("cursor_4c_DesLactoBusca") AND !EOF("cursor_4c_DesLactoBusca")
                    IF USED("cursor_4c_DesLactoBusca")
                        USE IN cursor_4c_DesLactoBusca
                    ENDIF
                ELSE
                    IF USED("cursor_4c_DesLactoBusca")
                        USE IN cursor_4c_DesLactoBusca
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
                        loc_oPg.txt_4c_DesLacto.Value = ""
                    ENDIF
                    THIS.AbrirBuscaDesLacto()
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_DesLactoBusca")
                USE IN cursor_4c_DesLactoBusca
            ENDIF
            MostrarErro("Erro ao validar Desenvolvedor:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarDesLacto")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaDesLacto()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
                loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_DesLacto.Value)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT usuarios, ncomps FROM SigCdUsu " + ;
                "WHERE cativos <> 'N' AND usuarios LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
                " ORDER BY usuarios", ;
                "cursor_4c_DesLactoBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_DesLactoBusca") OR EOF("cursor_4c_DesLactoBusca")
                IF USED("cursor_4c_DesLactoBusca")
                    USE IN cursor_4c_DesLactoBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT usuarios, ncomps FROM SigCdUsu WHERE cativos <> 'N' ORDER BY usuarios", ;
                    "cursor_4c_DesLactoBusca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_DesLactoBusca", "usuarios", "ncomps", ;
                    "Selecionar Desenvolvedor")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    IF PEMSTATUS(loc_oPg, "txt_4c_DesLacto", 5)
                        loc_oPg.txt_4c_DesLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
            IF USED("cursor_4c_DesLactoBusca")
                USE IN cursor_4c_DesLactoBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_DesLactoBusca")
                USE IN cursor_4c_DesLactoBusca
            ENDIF
            MostrarErro("Erro ao buscar Desenvolvedor:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaDesLacto")
        ENDTRY
    ENDPROC

    *-- GetCriaLacto (txt_4c_CriaLacto): Valid - valida usuario criador em SigCdUsu
    PROCEDURE ValidarCriaLacto()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oPg, loc_cCod, loc_nRet, loException
        TRY
            loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
            loc_cCod = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
                loc_cCod = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
            ENDIF
            IF !EMPTY(loc_cCod)
                loc_nRet = SQLEXEC(gnConnHandle, ;
                    "SELECT usuarios FROM SigCdUsu " + ;
                    "WHERE usuarios = " + EscaparSQL(loc_cCod) + " AND cativos <> 'N'", ;
                    "cursor_4c_CriaLactoBusca")
                IF loc_nRet > 0 AND USED("cursor_4c_CriaLactoBusca") AND !EOF("cursor_4c_CriaLactoBusca")
                    IF USED("cursor_4c_CriaLactoBusca")
                        USE IN cursor_4c_CriaLactoBusca
                    ENDIF
                ELSE
                    IF USED("cursor_4c_CriaLactoBusca")
                        USE IN cursor_4c_CriaLactoBusca
                    ENDIF
                    IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
                        loc_oPg.txt_4c_CriaLacto.Value = ""
                    ENDIF
                    THIS.AbrirBuscaCriaLacto()
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_CriaLactoBusca")
                USE IN cursor_4c_CriaLactoBusca
            ENDIF
            MostrarErro("Erro ao validar Criador:" + CHR(13) + loException.Message, ;
                "FormProduto.ValidarCriaLacto")
        ENDTRY
    ENDPROC

    PROCEDURE AbrirBuscaCriaLacto()
        LOCAL loc_oPg, loc_oBusca, loc_cValAtual, loc_nRet, loException
        TRY
            loc_oPg       = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
            loc_cValAtual = ""
            IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
                loc_cValAtual = ALLTRIM(loc_oPg.txt_4c_CriaLacto.Value)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT usuarios, ncomps FROM SigCdUsu " + ;
                "WHERE cativos <> 'N' AND usuarios LIKE " + EscaparSQL(loc_cValAtual + "%") + ;
                " ORDER BY usuarios", ;
                "cursor_4c_CriaLactoBusca")
            IF loc_nRet <= 0 OR !USED("cursor_4c_CriaLactoBusca") OR EOF("cursor_4c_CriaLactoBusca")
                IF USED("cursor_4c_CriaLactoBusca")
                    USE IN cursor_4c_CriaLactoBusca
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT usuarios, ncomps FROM SigCdUsu WHERE cativos <> 'N' ORDER BY usuarios", ;
                    "cursor_4c_CriaLactoBusca")
            ENDIF
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.DefinirCursor("cursor_4c_CriaLactoBusca", "usuarios", "ncomps", ;
                    "Selecionar Criador")
                loc_oBusca.Mostrar()
                IF !EMPTY(loc_oBusca.cCodigoSelecionado)
                    IF PEMSTATUS(loc_oPg, "txt_4c_CriaLacto", 5)
                        loc_oPg.txt_4c_CriaLacto.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
                    ENDIF
                ENDIF
                loc_oBusca = .NULL.
            ENDIF
            IF USED("cursor_4c_CriaLactoBusca")
                USE IN cursor_4c_CriaLactoBusca
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_CriaLactoBusca")
                USE IN cursor_4c_CriaLactoBusca
            ENDIF
            MostrarErro("Erro ao buscar Criador:" + CHR(13) + loException.Message, ;
                "FormProduto.AbrirBuscaCriaLacto")
        ENDTRY
    ENDPROC

    *-- btnIniTarefa: registra inicio de tarefa na linha corrente do grdDesigner
    PROCEDURE BtnIniTarefaClick()
        LOCAL loc_oPg, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                MsgAviso("Habilite Incluir ou Alterar para registrar tarefa.")
            ELSE
                IF USED("cursor_4c_GrdDesigner")
                    SELECT cursor_4c_GrdDesigner
                    APPEND BLANK
                    REPLACE cursor_4c_GrdDesigner.dtini    WITH DATE()
                    REPLACE cursor_4c_GrdDesigner.usuarios WITH ALLTRIM(gc_4c_UsuarioLogado)
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
                    IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
                        loc_oPg.grd_4c_GrdDesigner.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao registrar inicio de tarefa:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnIniTarefaClick")
        ENDTRY
    ENDPROC

    *-- btnFimTarefa: registra data conclusao na linha corrente do grdDesigner
    PROCEDURE BtnFimTarefaClick()
        LOCAL loc_oPg, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                MsgAviso("Habilite Incluir ou Alterar para registrar conclus" + CHR(227) + "o.")
            ELSE
                IF USED("cursor_4c_GrdDesigner") AND !EOF("cursor_4c_GrdDesigner")
                    SELECT cursor_4c_GrdDesigner
                    REPLACE cursor_4c_GrdDesigner.dtfim WITH DATE()
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
                    IF PEMSTATUS(loc_oPg, "grd_4c_GrdDesigner", 5)
                        loc_oPg.grd_4c_GrdDesigner.Refresh()
                    ENDIF
                ELSE
                    MsgAviso("Selecione um registro de tarefa para registrar conclus" + CHR(227) + "o.")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao registrar fim de tarefa:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnFimTarefaClick")
        ENDTRY
    ENDPROC

    *-- btnInsArqs: insere arquivo via dialogo na lista grdArquivos
    PROCEDURE BtnInsArqsClick()
        LOCAL loc_oPg, loc_cArquivo, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                MsgAviso("Habilite Incluir ou Alterar para inserir arquivo.")
            ELSE
                loc_cArquivo = GETFILE("*", "Selecionar Arquivo")
                IF !EMPTY(loc_cArquivo) AND USED("cursor_4c_GrdArquivos")
                    SELECT cursor_4c_GrdArquivos
                    APPEND BLANK
                    REPLACE cursor_4c_GrdArquivos.arqnome WITH ALLTRIM(loc_cArquivo)
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
                    IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
                        loc_oPg.grd_4c_GrdArquivos.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inserir arquivo:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnInsArqsClick")
        ENDTRY
    ENDPROC

    *-- btnExcArqs: exclui arquivo selecionado da lista grdArquivos
    PROCEDURE BtnExcArqsClick()
        LOCAL loc_oPg, loc_lConfirm, loException
        TRY
            IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                MsgAviso("Habilite Incluir ou Alterar para excluir arquivo.")
            ELSE
                IF USED("cursor_4c_GrdArquivos") AND !EOF("cursor_4c_GrdArquivos")
                    loc_lConfirm = MsgConfirma("Confirma exclus" + CHR(227) + "o do arquivo selecionado?")
                    IF loc_lConfirm
                        SELECT cursor_4c_GrdArquivos
                        DELETE
                        PACK
                        loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
                        IF PEMSTATUS(loc_oPg, "grd_4c_GrdArquivos", 5)
                            loc_oPg.grd_4c_GrdArquivos.Refresh()
                        ENDIF
                    ENDIF
                ELSE
                    MsgAviso("Selecione um arquivo para excluir.")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir arquivo:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnExcArqsClick")
        ENDTRY
    ENDPROC

    *-- btnOpnArqs: abre arquivo selecionado com aplicativo associado do SO
    PROCEDURE BtnOpnArqsClick()
        LOCAL loc_cArquivo, loc_oPg, loException
        TRY
            IF USED("cursor_4c_GrdArquivos") AND !EOF("cursor_4c_GrdArquivos")
                loc_cArquivo = ALLTRIM(cursor_4c_GrdArquivos.arqnome)
                IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
                    DECLARE INTEGER ShellExecute IN Shell32 ;
                        INTEGER hwnd, STRING lpOp, STRING lpFile, ;
                        STRING lpParams, STRING lpDir, INTEGER nShow
                    ShellExecute(0, "open", loc_cArquivo, "", "", 1)
                    loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
                    IF PEMSTATUS(loc_oPg, "img_4c_ImgArqJpg", 5)
                        IF INLIST(UPPER(RIGHT(ALLTRIM(loc_cArquivo), 4)), ".JPG", ".PNG") OR ;
                            UPPER(RIGHT(ALLTRIM(loc_cArquivo), 5)) = ".JPEG"
                            loc_oPg.img_4c_ImgArqJpg.Picture = loc_cArquivo
                            loc_oPg.img_4c_ImgArqJpg.Visible = .T.
                        ELSE
                            loc_oPg.img_4c_ImgArqJpg.Visible = .F.
                        ENDIF
                    ENDIF
                ELSE
                    MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArquivo)
                ENDIF
            ELSE
                MsgAviso("Selecione um arquivo para abrir.")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao abrir arquivo:" + CHR(13) + loException.Message, ;
                "FormProduto.BtnOpnArqsClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ConfigurarPgpgServico - Configura Page8 "Servicos" do pgf_4c_Dados
    * Controles mapeados de SIGCDPRO.Pagina.Dados.pgframeDados.pgServico
    * grdServico: top=171, left=339, width=320, height=387, 3 colunas
    *   Column1 (ColumnOrder=2): Descs - editavel em INCLUIR/ALTERAR E Marcas=1
    *   Column2 (ColumnOrder=3): Cods  - somente leitura
    *   Column3 (ColumnOrder=1): Marcas (CheckBox) - editavel em INCLUIR/ALTERAR
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPgpgServico(par_oPg)
        LOCAL loc_oPg, loc_oGrid, loc_oErro
        TRY
            loc_oPg = par_oPg
            loc_oPg.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Cursor placeholder ANTES de RecordSource (REGRA CRITICA VFP9)
            IF !USED("cursor_4c_GrdServico")
                CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
            ENDIF

            *-- grd_4c_Dados: grade de servicos associados
            *-- Original grdServico: top=171, left=339, width=320, height=387
            loc_oPg.AddObject("grd_4c_Dados", "Grid")
            WITH loc_oPg.grd_4c_Dados
                .Top        = 171
                .Left       = 339
                .Width      = 320
                .Height     = 387
                .FontName   = "Tahoma"
                .FontSize   = 8
                .DeleteMark = .F.
                .RecordMark = .F.
                .RowHeight  = 16
                .ScrollBars = 2
                .Visible    = .T.
            ENDWITH
            loc_oPg.grd_4c_Dados.ColumnCount  = 3
            loc_oPg.grd_4c_Dados.RecordSource = "cursor_4c_GrdServico"
            loc_oGrid = loc_oPg.grd_4c_Dados

            *-- Column1: Descs/Descricao Servico (ColumnOrder=2 - exibida como 2a coluna)
            *-- When: editavel em INCLUIR/ALTERAR E Marcas=1 na linha atual
            *-- Valid: fAcessoEmpresa (validacao empresa por descricao de servico)
            loc_oGrid.Column1.ControlSource   = "cursor_4c_GrdServico.Descs"
            loc_oGrid.Column1.Width           = 228
            loc_oGrid.Column1.ColumnOrder     = 2
            loc_oGrid.Column1.Movable         = .F.
            loc_oGrid.Column1.Resizable       = .F.
            loc_oGrid.Column1.Header1.Caption = "Servi" + CHR(231) + "os"
            loc_oGrid.Column1.Text1.Alignment  = 3
            loc_oGrid.Column1.Text1.BorderStyle = 0
            loc_oGrid.Column1.Text1.Margin     = 0
            BINDEVENT(loc_oGrid.Column1.Text1, "When",  THIS, "GrdServicoCol1When")
            BINDEVENT(loc_oGrid.Column1.Text1, "Valid",  THIS, "GrdServicoCol1Valid")

            *-- Column2: Cods/Codigo Servico (ColumnOrder=3, somente leitura)
            loc_oGrid.Column2.ControlSource   = "cursor_4c_GrdServico.Cods"
            loc_oGrid.Column2.Width           = 50
            loc_oGrid.Column2.ColumnOrder     = 3
            loc_oGrid.Column2.Movable         = .F.
            loc_oGrid.Column2.Resizable       = .F.
            loc_oGrid.Column2.ReadOnly        = .T.
            loc_oGrid.Column2.Header1.Caption = "C" + CHR(243) + "digo"
            loc_oGrid.Column2.Text1.BorderStyle = 0
            loc_oGrid.Column2.Text1.Margin     = 0
            loc_oGrid.Column2.Text1.ReadOnly   = .T.

            *-- Column3: Marcas/CheckBox (ColumnOrder=1 - primeira coluna visualmente)
            *-- Sparse=.F. obrigatorio para CheckBox funcionar em coluna de grid
            *-- When: editavel em INCLUIR/ALTERAR
            *-- KeyPress: Space(32) ou Enter(13) togla Marcas (0->1, 1->0)
            loc_oGrid.Column3.ControlSource   = "cursor_4c_GrdServico.Marcas"
            loc_oGrid.Column3.Width           = 17
            loc_oGrid.Column3.ColumnOrder     = 1
            loc_oGrid.Column3.Movable         = .F.
            loc_oGrid.Column3.Resizable       = .F.
            loc_oGrid.Column3.Sparse          = .F.
            loc_oGrid.Column3.Header1.Caption = ""
            loc_oGrid.Column3.AddObject("Check1", "CheckBox")
            WITH loc_oGrid.Column3.Check1
                .Caption   = ""
                .Alignment = 0
                .ReadOnly  = .F.
                .Visible   = .T.
                .Top       = 9
                .Left      = 2
                .Height    = 17
                .Width     = 22
            ENDWITH
            BINDEVENT(loc_oGrid.Column3.Check1, "When",     THIS, "GrdServicoChk3When")
            BINDEVENT(loc_oGrid.Column3.Check1, "KeyPress", THIS, "GrdServicoChk3KeyPress")

        CATCH TO loc_oErro
            MostrarErro("Erro ao configurar pgServico:" + CHR(13) + loc_oErro.Message, ;
                "FormProduto.ConfigurarPgpgServico")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CarregarServicos - Popula cursor_4c_GrdServico com todos os servicos
    * de SigPrSer, marcando Marcas=1 para os associados ao produto em SigSerPr.
    * Chamado de BOParaForm ao carregar registro existente.
    *===========================================================================
    PROTECTED PROCEDURE CarregarServicos()
        LOCAL loc_cCpros, loc_nRet, loc_oPg, loc_oGrid, loException
        TRY
            loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
            IF EMPTY(loc_cCpros) OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                RETURN
            ENDIF

            loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page8

            *-- Carregar todos os servicos com Marcas=0/1 via LEFT JOIN em SigSerPr
            IF USED("cursor_4c_GrdServico")
                USE IN cursor_4c_GrdServico
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT CASE WHEN s.cods IS NOT NULL THEN 1 ELSE 0 END AS Marcas," + ;
                " p.cods, p.descs, p.qtdias" + ;
                " FROM SigPrSer p" + ;
                " LEFT JOIN SigSerPr s ON s.cods = p.cods AND s.cpros = " + EscaparSQL(loc_cCpros) + ;
                " ORDER BY p.descs", ;
                "cursor_4c_GrdServico")
            IF loc_nRet <= 0
                CREATE CURSOR cursor_4c_GrdServico (Marcas N(1,0), Cods C(3), Descs C(30), qtdias N(3,0))
            ENDIF

            *-- Reassociar RecordSource e ControlSources apos recarregar cursor
            IF PEMSTATUS(loc_oPg, "grd_4c_Dados", 5)
                loc_oGrid = loc_oPg.grd_4c_Dados
                loc_oGrid.ColumnCount = 3
                loc_oGrid.RecordSource          = "cursor_4c_GrdServico"
                loc_oGrid.Column1.ControlSource = "cursor_4c_GrdServico.Descs"
                loc_oGrid.Column2.ControlSource = "cursor_4c_GrdServico.Cods"
                loc_oGrid.Column3.ControlSource = "cursor_4c_GrdServico.Marcas"
                loc_oGrid.Refresh()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar Servi" + CHR(231) + "os:" + CHR(13) + ;
                loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormProduto.CarregarServicos")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Handlers de BINDEVENT para pgServico (Page8)
    * Todos PUBLIC - requerido pelo BINDEVENT
    *===========================================================================

    *-- Column1 Text1 When: editavel em INCLUIR/ALTERAR E Marcas=1 na linha atual
    PROCEDURE GrdServicoCol1When()
        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN .F.
        ENDIF
        IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
            RETURN cursor_4c_GrdServico.Marcas = 1
        ENDIF
        RETURN .F.
    ENDPROC

    *-- Column1 Text1 Valid: fAcessoEmpresa (validacao de empresa por descricao de servico)
    PROCEDURE GrdServicoCol1Valid()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF
        LOCAL loc_cDescs, loException
        loc_cDescs = ""
        TRY
            IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
                loc_cDescs = ALLTRIM(cursor_4c_GrdServico.Descs)
            ENDIF
            IF !EMPTY(loc_cDescs)
                *!! CORRETOR #110: fAcessoEmpresa() NAO existe na nova arquitetura. Substituir por bloco FormBuscaAuxiliar apontando SigCdEmp (chave Cemps modo C, Razas modo D). Ver Formsigatcrp.prg:2278-2378.
                fAcessoEmpresa(Usuar, "C", loc_cDescs, .NULL., "")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro na valida" + CHR(231) + CHR(227) + "o de empresa:" + ;
                CHR(13) + loException.Message, "FormProduto.GrdServicoCol1Valid")
        ENDTRY
        RETURN .T.
    ENDPROC

    *-- Column3 Check1 When: editavel apenas em INCLUIR/ALTERAR
    PROCEDURE GrdServicoChk3When()
        RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
    ENDPROC

    *-- Column3 Check1 KeyPress: Space(32) ou Enter(13) togla Marcas (0->1 / 1->0)
    PROCEDURE GrdServicoChk3KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            IF USED("cursor_4c_GrdServico") AND !EOF("cursor_4c_GrdServico")
                REPLACE cursor_4c_GrdServico.Marcas WITH IIF(cursor_4c_GrdServico.Marcas = 0, 1, 0)
            ENDIF
        ENDIF
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
				THIS.SalvarFaseP()
				THIS.SalvarServicos()
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
				THIS.SalvarFaseP()
				THIS.SalvarServicos()
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
			*-- Excluir sub-tabelas de processos e matrizes antes do produto principal
			SQLEXEC(gnConnHandle, "DELETE FROM SigCdPrf WHERE produtos = " + EscaparSQL(THIS.this_cCpros))
			SQLEXEC(gnConnHandle, "DELETE FROM sigprmtz WHERE cpros = "    + EscaparSQL(THIS.this_cCpros))

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

	*====================================================================
	* SalvarFaseP - Persiste cursor_4c_GradFase -> SigCdPrf
	*               e cursor_4c_GrdMatrizes -> sigprmtz
	* Chamado por Inserir() e Atualizar() apos sucesso no SigCdPro.
	* Estrategia SigCdPrf: UPDATE linhas existentes (preserva figprocs),
	*   INSERT novas, DELETE removidas.
	* Estrategia sigprmtz: DELETE + INSERT simples.
	*====================================================================
	PROTECTED PROCEDURE SalvarFaseP()
		LOCAL loc_cCpros, loc_nRet, loc_cSQL, loc_cKey, loException
		TRY
			loc_cCpros = ALLTRIM(THIS.this_cCpros)

			*--------------------------------------------------------------
			*-- SigCdPrf: processos de producao (cursor_4c_GradFase)
			*--------------------------------------------------------------
			IF USED("cursor_4c_GradFase")
				*-- Obter cidchaves existentes no banco para este produto
				loc_nRet = SQLEXEC(gnConnHandle, ;
					"SELECT cidchaves FROM SigCdPrf WHERE produtos = " + EscaparSQL(loc_cCpros), ;
					"cursor_4c_PrfExist")
				IF loc_nRet < 0
					IF USED("cursor_4c_PrfExist")
						USE IN cursor_4c_PrfExist
					ENDIF
					CREATE CURSOR cursor_4c_PrfExist (cidchaves C(20))
				ENDIF

				*-- Coletar cidchaves dos registros nao-deletados do cursor
				LOCAL loc_cKeysAtivos
				loc_cKeysAtivos = ","
				SELECT cursor_4c_GradFase
				SCAN
					loc_cKeysAtivos = loc_cKeysAtivos + ALLTRIM(cursor_4c_GradFase.cidchaves) + ","
				ENDSCAN

				*-- INSERT/UPDATE linhas do cursor (SCAN ignora registros deletados)
				SELECT cursor_4c_GradFase
				SCAN
					loc_cKey = ALLTRIM(cursor_4c_GradFase.cidchaves)
					SELECT cursor_4c_PrfExist
					LOCATE FOR ALLTRIM(cursor_4c_PrfExist.cidchaves) = loc_cKey
					IF FOUND()
						*-- Linha existente: UPDATE (preserva figprocs e etiquetas)
						loc_cSQL = "UPDATE SigCdPrf SET" + ;
							" ordems   = " + TRANSFORM(cursor_4c_GradFase.ordems)             + "," + ;
							" grupos   = " + EscaparSQL(ALLTRIM(cursor_4c_GradFase.grupos))   + "," + ;
							" minutos  = " + TRANSFORM(cursor_4c_GradFase.minutos)            + "," + ;
							" uniprdts = " + EscaparSQL(ALLTRIM(cursor_4c_GradFase.uniprdts)) + "," + ;
							" matprdts = " + EscaparSQL(ALLTRIM(cursor_4c_GradFase.matprdts)) + "," + ;
							" obs      = " + IIF(EMPTY(cursor_4c_GradFase.obs), "NULL", ;
								EscaparSQL(ALLTRIM(cursor_4c_GradFase.obs))) + ;
							" WHERE cidchaves = " + EscaparSQL(loc_cKey)
					ELSE
						*-- Linha nova: INSERT com figprocs NULL
						loc_cSQL = "INSERT INTO SigCdPrf" + ;
							" (produtos, ordems, grupos, etiquetas, ordem2, cidchaves," + ;
							"  minutos, uniprdts, matprdts, obs)" + ;
							" VALUES (" + ;
							EscaparSQL(loc_cCpros)                                             + "," + ;
							TRANSFORM(cursor_4c_GradFase.ordems)                               + "," + ;
							EscaparSQL(ALLTRIM(cursor_4c_GradFase.grupos))                     + "," + ;
							"0,0," + ;
							EscaparSQL(loc_cKey)                                               + "," + ;
							TRANSFORM(cursor_4c_GradFase.minutos)                              + "," + ;
							EscaparSQL(ALLTRIM(cursor_4c_GradFase.uniprdts))                   + "," + ;
							EscaparSQL(ALLTRIM(cursor_4c_GradFase.matprdts))                   + "," + ;
							IIF(EMPTY(cursor_4c_GradFase.obs), "NULL", ;
								EscaparSQL(ALLTRIM(cursor_4c_GradFase.obs))) + ")"
					ENDIF
					SELECT cursor_4c_GradFase
					SQLEXEC(gnConnHandle, loc_cSQL)
				ENDSCAN

				*-- DELETE linhas removidas (em DB mas nao no cursor ativo)
				IF USED("cursor_4c_PrfExist") AND RECCOUNT("cursor_4c_PrfExist") > 0
					SELECT cursor_4c_PrfExist
					SCAN
						loc_cKey = ALLTRIM(cursor_4c_PrfExist.cidchaves)
						IF !( ("," + loc_cKey + ",") $ loc_cKeysAtivos )
							SQLEXEC(gnConnHandle, ;
								"DELETE FROM SigCdPrf WHERE cidchaves = " + EscaparSQL(loc_cKey))
						ENDIF
					ENDSCAN
				ENDIF

				IF USED("cursor_4c_PrfExist")
					USE IN cursor_4c_PrfExist
				ENDIF
			ENDIF

			*--------------------------------------------------------------
			*-- sigprmtz: matrizes (cursor_4c_GrdMatrizes) — DELETE + INSERT simples
			*--------------------------------------------------------------
			IF USED("cursor_4c_GrdMatrizes")
				SQLEXEC(gnConnHandle, ;
					"DELETE FROM sigprmtz WHERE cpros = " + EscaparSQL(loc_cCpros))

				SELECT cursor_4c_GrdMatrizes
				SCAN
					IF !EMPTY(ALLTRIM(cursor_4c_GrdMatrizes.cmats))
						loc_cSQL = "INSERT INTO sigprmtz (cidchaves, cmats, cpros, qtds) VALUES (" + ;
							EscaparSQL(ALLTRIM(cursor_4c_GrdMatrizes.cidchaves)) + "," + ;
							EscaparSQL(ALLTRIM(cursor_4c_GrdMatrizes.cmats))     + "," + ;
							EscaparSQL(loc_cCpros)                               + "," + ;
							TRANSFORM(cursor_4c_GrdMatrizes.qtds)                + ")"
						SQLEXEC(gnConnHandle, loc_cSQL)
					ENDIF
				ENDSCAN
			ENDIF

		CATCH TO loException
			MsgErro("Erro ao salvar processos/matrizes:" + CHR(13) + loException.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
				"ProdutoBO.SalvarFaseP")
		ENDTRY
	ENDPROC

	*====================================================================
	* SalvarServicos - Persiste cursor_4c_GrdServico -> SigSerPr
	* Estrategia: DELETE todos do produto + INSERT novos com Marcas=1
	* Chamado por Inserir() e Atualizar() apos sucesso em SigCdPro.
	*====================================================================
	PROTECTED PROCEDURE SalvarServicos()
		LOCAL loc_cCpros, loc_cCods, loc_cIdChaves, loc_cSQL, loException
		TRY
			loc_cCpros = ALLTRIM(THIS.this_cCpros)

			*-- Remover associacoes anteriores do produto
			SQLEXEC(gnConnHandle, "DELETE FROM SigSerPr WHERE cpros = " + EscaparSQL(loc_cCpros))

			*-- Inserir servicos marcados (Marcas=1) do cursor de tela
			IF USED("cursor_4c_GrdServico")
				SELECT cursor_4c_GrdServico
				GO TOP
				SCAN FOR cursor_4c_GrdServico.Marcas = 1
					loc_cCods     = ALLTRIM(cursor_4c_GrdServico.Cods)
					loc_cIdChaves = fUniqueIds()
					loc_cSQL      = "INSERT INTO SigSerPr (cidchaves, cods, cpros) VALUES (" + ;
					               EscaparSQL(loc_cIdChaves) + ", " + ;
					               EscaparSQL(loc_cCods)     + ", " + ;
					               EscaparSQL(loc_cCpros)    + ")"
					SQLEXEC(gnConnHandle, loc_cSQL)
				ENDSCAN
			ENDIF

		CATCH TO loException
			MsgErro("Erro ao salvar Servi" + CHR(231) + "os:" + CHR(13) + ;
				loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
				"ProdutoBO.SalvarServicos")
		ENDTRY
	ENDPROC

ENDDEFINE

