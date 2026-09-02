# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-09-02 04:39:03] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-02 04:39:03] [INFO] Config FPW: (nao fornecido)
[2026-09-02 04:39:03] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 04:39:03] [INFO] Timeout: 300 segundos
[2026-09-02 04:39:03] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_erhjl1qa.prg
[2026-09-02 04:39:03] [INFO] Conteudo do wrapper:
[2026-09-02 04:39:03] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSER', 'C:\4c\tasks\task520', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSER', 'C:\4c\tasks\task520', 'CRUD'
QUIT

[2026-09-02 04:39:03] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_erhjl1qa.prg
[2026-09-02 04:39:03] [INFO] VFP output esperado em: C:\4c\tasks\task520\vfp_output.txt
[2026-09-02 04:39:03] [INFO] Executando Visual FoxPro 9...
[2026-09-02 04:39:03] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_erhjl1qa.prg
[2026-09-02 04:39:03] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_erhjl1qa.prg
[2026-09-02 04:39:03] [INFO] Timeout configurado: 300 segundos
[2026-09-02 04:40:40] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-02 04:40:40] [INFO] VFP9 finalizado em 97.0834303 segundos
[2026-09-02 04:40:40] [INFO] Exit Code: 
[2026-09-02 04:40:40] [INFO] 
[2026-09-02 04:40:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-02 04:40:40] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_erhjl1qa.prg
[2026-09-02 04:40:40] [INFO] 
[2026-09-02 04:40:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-02 04:40:40] [INFO] * Auto-generated wrapper for parameters
[2026-09-02 04:40:40] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 04:40:40] [INFO] * Parameters: 'FormSER', 'C:\4c\tasks\task520', 'CRUD'
[2026-09-02 04:40:40] [INFO] 
[2026-09-02 04:40:40] [INFO] * Anti-dialog protections for unattended execution
[2026-09-02 04:40:40] [INFO] SET SAFETY OFF
[2026-09-02 04:40:40] [INFO] SET RESOURCE OFF
[2026-09-02 04:40:40] [INFO] SET TALK OFF
[2026-09-02 04:40:40] [INFO] SET NOTIFY OFF
[2026-09-02 04:40:40] [INFO] SYS(2335, 0)
[2026-09-02 04:40:40] [INFO] 
[2026-09-02 04:40:40] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSER', 'C:\4c\tasks\task520', 'CRUD'
[2026-09-02 04:40:40] [INFO] QUIT
[2026-09-02 04:40:40] [INFO] 
[2026-09-02 04:40:40] [INFO] === Fim do Wrapper.prg ===
[2026-09-02 04:40:40] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSER",
  "timestamp": "20260902044040",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "CarregarLista",
      "passou": false,
      "erro": "Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)",
      "detalhes": ""
    },
    {
      "nome": "ModoIncluir",
      "passou": false,
      "erro": "Property ALTERNARPAGINA is not found.",
      "detalhes": "Linha: 429"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 559"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 1 (KEYPRESS)"
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
    "passou": 6,
    "falhou": 3,
    "percentual": 67
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSER.prg):
*==============================================================================
* FormSER.prg - Cadastro de Servicos dos Produtos
* Herda de FormBase
* Tabela: SigPrSer | BO: SERBO
*==============================================================================

DEFINE CLASS FormSER AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    *-- Caption sem acento aqui; definido com CHR() em InicializarForm
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Servicos dos Produtos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de controle
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    * Init - Inicializa o formulario (DODEFAULT chama InicializarForm via FormBase)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configuracao completa (chamado por FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Caption com acento correto (CHR nao permitido em DEFINE CLASS)
            THIS.Caption = "Cadastro de Servi" + CHR(231) + "os dos Produtos"

            THIS.this_oBusinessObject = CREATEOBJECT("SERBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar SERBO", "FormSER")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria o PageFrame principal com 2 paginas
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
            .Page1.Caption = "Lista"
            .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.Caption = "Dados"
            .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD e grid
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container Cabecalho (cntSombra no legado)
        * Original: Top=1, Left=-1, Width=1008, Height=80 -> canonico: Top=31
        *----------------------------------------------------------------------
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
            .Caption   = "Cadastro de Servi" + CHR(231) + "os dos Produtos"
            .Top       = 15
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Servi" + CHR(231) + "os dos Produtos"
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Container Botoes CRUD (Grupo_op no legado)
        * Original: Left=544, Top=-1, Width=385, Height=85
        * -> canonico: Left=542, Top=29 (+29 compensacao)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Incluir (Inserir no legado)
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Visualizar (Consultar no legado)
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Buscar (Procurar no legado)
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *----------------------------------------------------------------------
        * Container Saida (Grupo_Saida no legado) - PADRAO CANONICO (CLAUDE.md #10)
        * Original: Left=919, Top=-1 -> canonico PREVALECE: Left=917, Top=29
        *----------------------------------------------------------------------
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * Grid de lista (Grade no legado)
        * Original: Top=121, Left=12, Width=940, Height=470 -> Top=150 (+29)
        * ColumnCount=2 para mostrar apenas Cods e Descs (cIdChaves fica no cursor)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")

        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top         = 150
        loc_oGrid.Left        = 12
        loc_oGrid.Width       = 940
        loc_oGrid.Height      = 470
        loc_oGrid.ColumnCount = 2
        loc_oGrid.RecordSource = ""

        WITH loc_oGrid
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
            .RowHeight          = 16
            .ScrollBars         = 2
            .GridLines          = 3
            .Visible            = .T.
        ENDWITH

        WITH loc_oGrid.Column1
            .Width     = 80
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"

        WITH loc_oGrid.Column2
            .Width     = 200
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2: campos de edicao e botoes de acao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container Botoes Acao (Grupo_Salva no legado)
        * Original: Left=817, Top=11 -> Top=40 (+29 compensacao)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 40
            .Left        = 817
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Confirmar (Salva no legado)
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Cancelar
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
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * Label Codigo (Say1 no legado)
        * Original: Top=141, Left=358 -> Top=170 (+29)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 170
            .Left      = 358
            .Width     = 46
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label Descricao (Say2 no legado)
        * Original: Top=167, Left=345 -> Top=196 (+29)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 196
            .Left      = 345
            .Width     = 59
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Label QtDias (Say3 no legado)
        * Original: Top=194, Left=305 -> Top=223 (+29)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_QtDias", "Label")
        WITH loc_oPagina.lbl_4c_QtDias
            .Caption   = "Dias para entrega :"
            .Top       = 223
            .Left      = 305
            .Width     = 99
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Codigo (getCods no legado)
        * Original: Top=137, Left=405, Width=41, Height=24 -> Top=166 (+29)
        * MaxLength=3, Format="K!" -> Format="!" (uppercase; K nao suportado)
        * Habilitado apenas em INCLUIR (getCods.When = InList(pcEscolha,[INSERIR],[PROCURAR]))
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 166
            .Left          = 405
            .Width         = 41
            .Height        = 24
            .MaxLength     = 3
            .Format        = "!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox Descricao (getDescs no legado)
        * Original: Top=163, Left=405, Width=282, Height=24 -> Top=192 (+29)
        * MaxLength=30, Format="K!" -> Format="!" (uppercase)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 192
            .Left          = 405
            .Width         = 282
            .Height        = 24
            .MaxLength     = 30
            .Format        = "!"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * TextBox QtDias (getQtDias no legado)
        * Original: Top=190, Left=405, Width=41, Height=24 -> Top=219 (+29)
        * InputMask="999" (numerico 3 digitos), campo numeric
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("txt_4c_QtDias", "TextBox")
        WITH loc_oPagina.txt_4c_QtDias
            .Value         = 0
            .Top           = 219
            .Left          = 405
            .Width         = 41
            .Height        = 24
            .MaxLength     = 3
            .InputMask     = "999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .ToolTipText   = "Quantidade de dias para entrega do servi" + CHR(231) + "o."
            .Enabled       = .T.
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no Grid da Page1 a partir do BO
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF THIS.this_oBusinessObject.Buscar("")
                    *-- RecordSource ANTES de ControlSource (Problem #48)
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Cods"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descs"
                    *-- Width e Headers APOS ControlSource (Problem #32)
                    loc_oGrid.Column1.Width = 80
                    loc_oGrid.Column2.Width = 200
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do Form para o BO antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_nQtDias    = loc_oPagina.txt_4c_QtDias.Value
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para o Form apos carregar
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        loc_oPagina.txt_4c_QtDias.Value    = THIS.this_oBusinessObject.this_nQtDias
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.txt_4c_Codigo.Value    = ""
        loc_oPagina.txt_4c_Descricao.Value = ""
        loc_oPagina.txt_4c_QtDias.Value    = 0
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao
    * getCods.When = InList(pcEscolha,[INSERIR],[PROCURAR])
    * -> txt_4c_Codigo habilitado apenas em INCLUIR
    * Confirmar.Enabled usa padrao Erro140 (EXCLUIR tambem precisa confirmar)
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lConfirmar
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Codigo habilitado apenas em INCLUIR (When do getCods no legado)
        loc_oPagina.txt_4c_Codigo.Enabled    = par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR"
        loc_oPagina.txt_4c_Descricao.Enabled = par_lHabilitar
        loc_oPagina.txt_4c_QtDias.Enabled    = par_lHabilitar

        *-- Confirmar: habilitado em edicao OU em EXCLUIR (nao usar = 6, retorna LOGICAL)
        loc_lConfirmar = par_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lConfirmar
        loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Estado dos botoes conforme this_cModoAtual
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF THIS.this_cModoAtual = "VISUALIZAR"
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ELSE
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCampos - Valida campos obrigatorios antes de salvar
    * Replica validacoes de Salva.Click do legado (Codigo e Descricao obrigatorios)
    *==========================================================================
    PROTECTED PROCEDURE ValidarCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Codigo.Value))
                MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_oPagina.txt_4c_Codigo.SetFocus()
                RETURN .F.
            ENDIF

            IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Descricao.Value))
                MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_oPagina.txt_4c_Descricao.SetFocus()
                RETURN .F.
            ENDIF
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Click no botao Incluir
    * Modo: INCLUIR, foco em txt_4c_Codigo (getCods.SetFocus no legado)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Click no botao Visualizar
    * Modo: VISUALIZAR, foco em cmd_4c_Confirmar (Grupo_Salva.Salva.SetFocus)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Visualizar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.Cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Click no botao Alterar
    * Modo: ALTERAR, foco em txt_4c_Descricao (getDescs.SetFocus no legado)
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Alterar")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.Cods)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Click no botao Excluir
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "Excluir")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.Cods)

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
                THIS.CarregarLista()
            ELSE
                MsgErro("Erro ao excluir o registro.", "Excluir")
            ENDIF
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Excluir")
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Click no botao Buscar
    * Equivalente ao msv_procurar do legado: recarrega lista
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Click no botao Encerrar
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Click no botao Confirmar
    * Replica Salva.Click do legado: valida, salva via BO, volta para lista
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- Validacoes FORA do TRY (CLAUDE.md Regra Critica)
        IF !THIS.ValidarCampos()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Salvar")
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao salvar o registro.", "Salvar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Click no botao Cancelar
    * Replica Cancelar.Click: se plCancelar -> mAtivaPagina1 (retorna para lista)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Itera Pages de PageFrames E Controls de Containers
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
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
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


### BO (C:\4c\projeto\app\classes\SERBO.prg):
*==============================================================================
* SERBO.prg - Business Object para Servicos dos Produtos
* Tabela: SigPrSer
* Herda de: BusinessBase
* Fase 1/8: Propriedades e Init
*==============================================================================

DEFINE CLASS SERBO AS BusinessBase

    *-- Propriedades de dados (espelham colunas de SigPrSer)
    this_cIdChaves  = ""  && cidchaves char(20) - chave primaria UUID gerada por fUniqueIds
    this_cCodigo    = ""  && cods char(3) - codigo do servico (chave de negocio)
    this_cDescricao = ""  && descs char(30) - descricao do servico
    this_nQtDias    = 0   && qtdias numeric(3,0) - dias para entrega

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrSer"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega servicos no cursor_4c_Dados com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cIdChaves, a.Cods, a.Descs, a.qtDias" + ;
                       " FROM SigPrSer a"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                           " WHERE a.Cods LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar servi" + CHR(231) + CHR(245) + "os:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega servico pelo codigo de negocio (Cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cIdChaves, a.Cods, a.Descs, a.qtDias" + ;
                       " FROM SigPrSer a" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
            THIS.this_cCodigo    = TratarNulo(Cods,      "C")
            THIS.this_cDescricao = TratarNulo(Descs,     "C")
            THIS.this_nQtDias    = TratarNulo(qtDias,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigPrSer
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se codigo ja existe
            IF USED("cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT Cods FROM SigPrSer WHERE Cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo)), ;
                "cursor_4c_Verifica")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Verifica") > 0
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                *-- Gerar UUID para a chave primaria
                THIS.this_cIdChaves = fUniqueIds()

                loc_cSQL = "INSERT INTO SigPrSer (cIdChaves, Cods, Descs, qtDias)" + ;
                           " VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cIdChaves)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nQtDias) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Verifica")
            USE IN cursor_4c_Verifica
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigPrSer (codigo Cods nao e alterado apos insert)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrSer SET" + ;
                       " Descs = "  + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                       " qtDias = " + FormatarNumeroSQL(THIS.this_nQtDias) + ;
                       " WHERE Cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigPrSer
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrSer" + ;
                       " WHERE Cods = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir servi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

