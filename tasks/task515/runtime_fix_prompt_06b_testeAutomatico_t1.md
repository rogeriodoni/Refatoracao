# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 559

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-09-02 00:15:10] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-02 00:15:10] [INFO] Config FPW: (nao fornecido)
[2026-09-02 00:15:10] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 00:15:10] [INFO] Timeout: 300 segundos
[2026-09-02 00:15:10] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jowadaop.prg
[2026-09-02 00:15:10] [INFO] Conteudo do wrapper:
[2026-09-02 00:15:10] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormRss', 'C:\4c\tasks\task515', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormRss', 'C:\4c\tasks\task515', 'CRUD'
QUIT

[2026-09-02 00:15:10] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jowadaop.prg
[2026-09-02 00:15:10] [INFO] VFP output esperado em: C:\4c\tasks\task515\vfp_output.txt
[2026-09-02 00:15:10] [INFO] Executando Visual FoxPro 9...
[2026-09-02 00:15:10] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jowadaop.prg
[2026-09-02 00:15:10] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jowadaop.prg
[2026-09-02 00:15:10] [INFO] Timeout configurado: 300 segundos
[2026-09-02 00:16:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-02 00:16:44] [INFO] VFP9 finalizado em 94.0351746 segundos
[2026-09-02 00:16:44] [INFO] Exit Code: 
[2026-09-02 00:16:44] [INFO] 
[2026-09-02 00:16:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-02 00:16:44] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jowadaop.prg
[2026-09-02 00:16:44] [INFO] 
[2026-09-02 00:16:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-02 00:16:44] [INFO] * Auto-generated wrapper for parameters
[2026-09-02 00:16:44] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 00:16:44] [INFO] * Parameters: 'FormRss', 'C:\4c\tasks\task515', 'CRUD'
[2026-09-02 00:16:44] [INFO] 
[2026-09-02 00:16:44] [INFO] * Anti-dialog protections for unattended execution
[2026-09-02 00:16:44] [INFO] SET SAFETY OFF
[2026-09-02 00:16:44] [INFO] SET RESOURCE OFF
[2026-09-02 00:16:44] [INFO] SET TALK OFF
[2026-09-02 00:16:44] [INFO] SET NOTIFY OFF
[2026-09-02 00:16:44] [INFO] SYS(2335, 0)
[2026-09-02 00:16:44] [INFO] 
[2026-09-02 00:16:44] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormRss', 'C:\4c\tasks\task515', 'CRUD'
[2026-09-02 00:16:45] [INFO] QUIT
[2026-09-02 00:16:45] [INFO] 
[2026-09-02 00:16:45] [INFO] === Fim do Wrapper.prg ===
[2026-09-02 00:16:45] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormRss",
  "timestamp": "20260902001644",
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
      "passou": true,
      "erro": "",
      "detalhes": "Page2 ativada com sucesso"
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
      "detalhes": "AbrirLookup: 1 (ABRIRLOOKUPCANONICO) | KeyPress handlers: 3 (DESTINOKEYPRESS, KEYPRESS, ORIGEMKEYPRESS)"
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
    "passou": 7,
    "falhou": 2,
    "percentual": 78
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRss.prg):
*==============================================================================
* FormRss.prg - Formulario de Restricao de Setores (SigCdRps)
* Herda de: FormBase
* Tabela: SigCdRps (cidchaves, grupoos, grupods, usuars, datars)
* Fase 7/8: Form completo - Estrutura + Campos + Lookups + Eventos CRUD
*==============================================================================

DEFINE CLASS FormRss AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX - canonico frmcadastro)
    Height      = 600
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades da classe
    this_oBusinessObject          = .NULL.
    this_cModoAtual               = "LISTA"
    this_cUltimoOrigemValidada    = ""
    this_cUltimoDestinoValidado   = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o formulario via FormBase.Init()
    * CRITICO: Apenas DODEFAULT() - FormBase.Init() ja chama InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro("Erro ao iniciar FormRss:" + CHR(13) + loc_oErro.Message, "FormRss.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado pelo FormBase.Init() automaticamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.Caption = "Restri" + CHR(231) + CHR(227) + "o de Setores"

            THIS.this_oBusinessObject = CREATEOBJECT("RssBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar RssBO.", "FormRss.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !THIS.CarregarLista()
                        *-- Falha ao carregar nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                loc_lSucesso                   = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar FormRss:" + CHR(13) + loc_oErro.Message, "FormRss.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * PageFrame.Top = -29 para ocultar abas; containers compensam com +29
    *--------------------------------------------------------------------------
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
            .Page1.BackColor = RGB(53, 53, 53)
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(53, 53, 53)
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Page1 completa: cabecalho, botoes CRUD e grid
    * Grid colunas: grupoos (Grupo Origem), grupods (Grupo Destino)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_cIcones
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_cIcones = gc_4c_CaminhoIcones

        *-- Container cabecalho escuro com titulo
        *-- cntSombra.Top=2 no legado + compensacao +29 = Top=31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = "Restri" + CHR(231) + CHR(227) + "o de Setores"
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = "Restri" + CHR(231) + CHR(227) + "o de Setores"
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container botoes CRUD (Grupo_op do legado)
        *-- Left=542 canonico nova arq. (proporcional a 1000px)
        *-- Top=0 no legado + compensacao +29 = Top=29; usamos 28 conforme framework
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = loc_cIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = loc_cIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = loc_cIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = loc_cIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
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
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Container saida - padrao canonico CLAUDE.md regra #10
        *-- Left=917, Width=90; cmd_4c_Encerrar Width=75
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Encerrar", "CommandButton")
            WITH .cmd_4c_Encerrar
                .Caption         = "Encerrar"
                .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 917
                .Width           = 90
                .Height          = 75
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Grid de lista
        *-- Colunas: grupoos (Grupo Origem 100px), grupods (Grupo Destino resto)
        *-- Top=88+29=117 canonico; Width=890 (nao sobrepor cnt_4c_Saida)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 12
            .Width              = 890
            .Height             = 450
            .ColumnCount        = 2
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
            .ReadOnly           = .T.
            .Visible            = .T.
            .Column1.Width      = 100
            .Column2.Width      = 786
        ENDWITH

        *-- BINDEVENT para todos os botoes (metodos devem ser PUBLIC)
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar + campos Origem
    * Fase 5: lbl_4c_Say2, txt_4c_Origem, txt_4c_Dorigem com lookup SigCdGcr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (Grupo_Salva do legado)
        *-- Top=4+29=33 (compensacao), Left=842, Width=160
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
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
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
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
                .Visible         = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Label e TextBoxes para Grupo Origem (Say2, Get_Origem, Get_Dorigem)
        *-- Say2 original: Top=140, Left=181 -> compensado Top=169
        *-- Get_Origem original: Top=138, Left=232, W=80, H=23 -> Top=167
        *-- Get_Dorigem original: Top=138, Left=314, W=193, H=23 -> Top=167

        loc_oPagina.AddObject("lbl_4c_Say2", "Label")
        WITH loc_oPagina.lbl_4c_Say2
            .Caption   = "Origem : "
            .Top       = 169
            .Left      = 181
            .Width     = 50
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Origem", "TextBox")
        WITH loc_oPagina.txt_4c_Origem
            .Value     = ""
            .Top       = 167
            .Left      = 232
            .Width     = 80
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 3
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dorigem", "TextBox")
        WITH loc_oPagina.txt_4c_Dorigem
            .Value     = ""
            .Top       = 167
            .Left      = 314
            .Width     = 193
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(230, 230, 230)
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 4
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_Origem, "KeyPress", THIS, "ValidarOrigem")
        BINDEVENT(loc_oPagina.txt_4c_Origem, "KeyPress",  THIS, "OrigemKeyPress")

        *-- Label e TextBoxes para Grupo Destino (Say1, Get_Destino, Get_ddestino)
        *-- Say1 original: Top=176, Left=179 -> compensado Top=205
        *-- Get_Destino original: Top=174, Left=232, W=80, H=23 -> Top=203
        *-- Get_ddestino original: Top=174, Left=314, W=193, H=23 -> Top=203

        loc_oPagina.AddObject("lbl_4c_Say1", "Label")
        WITH loc_oPagina.lbl_4c_Say1
            .Caption   = "Destino : "
            .Top       = 205
            .Left      = 179
            .Width     = 52
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Destino", "TextBox")
        WITH loc_oPagina.txt_4c_Destino
            .Value     = ""
            .Top       = 203
            .Left      = 232
            .Width     = 80
            .Height    = 23
            .MaxLength = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 5
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ddestino", "TextBox")
        WITH loc_oPagina.txt_4c_Ddestino
            .Value     = ""
            .Top       = 203
            .Left      = 314
            .Width     = 193
            .Height    = 23
            .ReadOnly  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(230, 230, 230)
            .ForeColor = RGB(90, 90, 90)
            .TabIndex  = 6
            .Visible   = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.txt_4c_Destino, "KeyPress", THIS, "ValidarDestino")
        BINDEVENT(loc_oPagina.txt_4c_Destino, "KeyPress",  THIS, "DestinoKeyPress")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Busca dados e associa ao grid
    * Colunas cursor_4c_Dados: grupoos, grupods, cidchaves
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource             = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.grupoos"
                    loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.grupods"

                    *-- OBRIGATORIO: Redefinir cabecalhos apos RecordSource (VFP9 reseta)
                    loc_oGrid.Column1.Header1.Caption  = "Grupo Origem"
                    loc_oGrid.Column2.Header1.Caption  = "Grupo Destino"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "FormRss.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, "FormRss.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores dos campos do form para o BO
    * Grupo Origem so editavel em INCLUIR; Grupo Destino em INCLUIR e ALTERAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
            THIS.this_oBusinessObject.this_cGrupoos = ALLTRIM(loc_oPagina2.txt_4c_Origem.Value)
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
            THIS.this_oBusinessObject.this_cGrupods = ALLTRIM(loc_oPagina2.txt_4c_Destino.Value)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os campos do form
    * Popula codigo e descricao de Origem e Destino
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
            loc_oPagina2.txt_4c_Origem.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupoos)
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
            loc_oPagina2.txt_4c_Destino.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupods)
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Dorigem", 5)
            loc_oPagina2.txt_4c_Dorigem.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescOrigem)
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Ddestino", 5)
            loc_oPagina2.txt_4c_Ddestino.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescDestino)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa os campos da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
            loc_oPagina2.txt_4c_Origem.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
            loc_oPagina2.txt_4c_Destino.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina2, "txt_4c_Dorigem", 5)
            loc_oPagina2.txt_4c_Dorigem.Value = ""
        ENDIF
        IF PEMSTATUS(loc_oPagina2, "txt_4c_Ddestino", 5)
            loc_oPagina2.txt_4c_Ddestino.Value = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    * INCLUIR  : Origem=editavel, Destino=editavel
    * ALTERAR  : Origem=readonly, Destino=editavel (PK nao muda)
    * VISUALIZAR: ambos readonly
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina2, loc_lOrigemEdit, loc_lDestinoEdit
        loc_oPagina2    = THIS.pgf_4c_Paginas.Page2
        loc_lOrigemEdit  = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        loc_lDestinoEdit = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
            loc_oPagina2.txt_4c_Origem.ReadOnly = !loc_lOrigemEdit
        ENDIF
        IF PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
            loc_oPagina2.txt_4c_Destino.ReadOnly = !loc_lDestinoEdit
        ENDIF
        IF PEMSTATUS(loc_oPagina2, "txt_4c_Dorigem", 5)
            loc_oPagina2.txt_4c_Dorigem.ReadOnly = .T.
        ENDIF
        IF PEMSTATUS(loc_oPagina2, "txt_4c_Ddestino", 5)
            loc_oPagina2.txt_4c_Ddestino.ReadOnly = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta Confirmar e Cancelar conforme modo
    * INCLUIR/ALTERAR: Confirmar enabled
    * VISUALIZAR     : Confirmar disabled
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5)
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
            IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
                loc_oCnt.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            ENDIF
            IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
                loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * HANDLERS DOS BOTOES - PUBLIC para funcionar com BINDEVENT
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara formulario para incluir novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente-leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    * Grupo Origem nao pode ser alterado (faz parte da chave de negocio)
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cChave
        loc_cChave = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Confirma e exclui registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cChave, loc_lConfirma
        loc_cChave   = ""
        loc_lConfirma = .F.

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        loc_cChave = ALLTRIM(cursor_4c_Dados.cidchaves)

        IF EMPTY(loc_cChave)
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
            "Confirmar Exclus" + CHR(227) + "o")

        IF loc_lConfirma
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega lista com todos os registros
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Salva o registro (Inserir ou Atualizar) via botao Confirmar
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgInfo("Registro salvo com sucesso.")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * REGRA: Iterar Pages de PageFrames e Controls de Containers
    *--------------------------------------------------------------------------
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

    *--------------------------------------------------------------------------
    * ValidarOrigem - LostFocus de txt_4c_Origem: valida codigo e busca descricao
    * Guard de repeticao via this_cUltimoOrigemValidada evita re-abertura do picker
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOrigem(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_oPagina2
        loc_cGrupo   = ""
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(loc_oPagina2.txt_4c_Origem.Value)

        IF loc_cGrupo == THIS.this_cUltimoOrigemValidada
            RETURN
        ENDIF
        THIS.this_cUltimoOrigemValidada = loc_cGrupo

        IF EMPTY(loc_cGrupo)
            IF PEMSTATUS(loc_oPagina2, "txt_4c_Dorigem", 5)
                loc_oPagina2.txt_4c_Dorigem.Value = ""
            ENDIF
            RETURN
        ENDIF

        THIS.AbrirBuscaOrigem(loc_cGrupo)
    ENDPROC

    *--------------------------------------------------------------------------
    * OrigemKeyPress - Abre lookup de Origem ao pressionar F4 (nKeyCode=115)
    * BINDEVENT requer parametros declarados
    *--------------------------------------------------------------------------
    PROCEDURE OrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_oPagina2

        IF par_nKeyCode != 115
            RETURN
        ENDIF

        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(loc_oPagina2.txt_4c_Origem.Value)
        THIS.AbrirBuscaOrigem(loc_cGrupo)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaOrigem - Lookup de SigCdGcr por Codigos para o campo Origem
    * Preenche txt_4c_Origem (codigo) e txt_4c_Dorigem (descricao)
    * Usa BuscarDescricaoGrupo() do BO para obter descricao apos selecao
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaOrigem(par_cValor)
        LOCAL loc_oBusca, loc_oPagina2, loc_cCodigo, loc_cDesc
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo  = ""
        loc_cDesc    = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaOrigem", "Codigos", par_cValor, ;
                "Grupo Origem")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrigem")
                    SELECT cursor_4c_BuscaOrigem
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaOrigem.Codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar Grupo Origem:" + CHR(13) + loc_oErro.Message, ;
                "FormRss.AbrirBuscaOrigem")
        ENDTRY

        IF USED("cursor_4c_BuscaOrigem")
            USE IN cursor_4c_BuscaOrigem
        ENDIF

        IF !EMPTY(loc_cCodigo)
            loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cCodigo)
        ENDIF

        THIS.this_cUltimoOrigemValidada = loc_cCodigo

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Origem", 5)
            loc_oPagina2.txt_4c_Origem.Value = loc_cCodigo
        ENDIF
        IF PEMSTATUS(loc_oPagina2, "txt_4c_Dorigem", 5)
            loc_oPagina2.txt_4c_Dorigem.Value = loc_cDesc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDestino - LostFocus de txt_4c_Destino: valida codigo e busca descricao
    * Guard de repeticao via this_cUltimoDestinoValidado evita re-abertura do picker
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDestino(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_oPagina2
        loc_cGrupo   = ""
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(loc_oPagina2.txt_4c_Destino.Value)

        IF loc_cGrupo == THIS.this_cUltimoDestinoValidado
            RETURN
        ENDIF
        THIS.this_cUltimoDestinoValidado = loc_cGrupo

        IF EMPTY(loc_cGrupo)
            IF PEMSTATUS(loc_oPagina2, "txt_4c_Ddestino", 5)
                loc_oPagina2.txt_4c_Ddestino.Value = ""
            ENDIF
            RETURN
        ENDIF

        THIS.AbrirBuscaDestino(loc_cGrupo)
    ENDPROC

    *--------------------------------------------------------------------------
    * DestinoKeyPress - Abre lookup de Destino ao pressionar F4 (nKeyCode=115)
    * BINDEVENT requer parametros declarados
    *--------------------------------------------------------------------------
    PROCEDURE DestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cGrupo, loc_oPagina2

        IF par_nKeyCode != 115
            RETURN
        ENDIF

        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
            RETURN
        ENDIF

        loc_cGrupo = ALLTRIM(loc_oPagina2.txt_4c_Destino.Value)
        THIS.AbrirBuscaDestino(loc_cGrupo)
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDestino - Lookup de SigCdGcr por Codigos para o campo Destino
    * Preenche txt_4c_Destino (codigo) e txt_4c_Ddestino (descricao)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDestino(par_cValor)
        LOCAL loc_oBusca, loc_oPagina2, loc_cCodigo, loc_cDesc
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
        loc_cCodigo  = ""
        loc_cDesc    = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaDestino", "Codigos", par_cValor, ;
                "Grupo Destino")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDestino")
                    SELECT cursor_4c_BuscaDestino
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaDestino.Codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar Grupo Destino:" + CHR(13) + loc_oErro.Message, ;
                "FormRss.AbrirBuscaDestino")
        ENDTRY

        IF USED("cursor_4c_BuscaDestino")
            USE IN cursor_4c_BuscaDestino
        ENDIF

        IF !EMPTY(loc_cCodigo)
            loc_cDesc = THIS.this_oBusinessObject.BuscarDescricaoGrupo(loc_cCodigo)
        ENDIF

        THIS.this_cUltimoDestinoValidado = loc_cCodigo

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Destino", 5)
            loc_oPagina2.txt_4c_Destino.Value = loc_cCodigo
        ENDIF
        IF PEMSTATUS(loc_oPagina2, "txt_4c_Ddestino", 5)
            loc_oPagina2.txt_4c_Ddestino.Value = loc_cDesc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\RssBO.prg):
*==============================================================================
* RssBO.prg - Business Object para Restricao de Setores (SigCdRps)
* Tabela principal: SigCdRps
* Chave primaria : cidchaves (char 20, gerada por fUniqueIds())
*==============================================================================

DEFINE CLASS RssBO AS BusinessBase

    *-- Propriedades mapeadas para colunas de SigCdRps
    this_cCidChaves = ""        && cidchaves char(20) - PK
    this_cGrupoos   = ""        && grupoos   char(10) - Grupo Origem (FK SigCdGcr.codigos)
    this_cGrupods   = ""        && grupods   char(10) - Grupo Destino (FK SigCdGcr.codigos)
    this_cUsuars    = ""        && usuars    char(10) - usuario
    this_dDatars    = {}        && datars    datetime - data/hora do registro

    *-- Propriedades auxiliares para exibicao (lookup SigCdGcr.descrs)
    this_cDescOrigem  = ""      && descricao do Grupo Origem
    this_cDescDestino = ""      && descricao do Grupo Destino

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRps"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades da entidade
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves    = ""
        THIS.this_cGrupoos      = ""
        THIS.this_cGrupods      = ""
        THIS.this_cUsuars       = ""
        THIS.this_dDatars       = {}
        THIS.this_cDescOrigem   = ""
        THIS.this_cDescDestino  = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves   = TratarNulo(cidchaves, "C")
                THIS.this_cGrupoos     = TratarNulo(grupoos,   "C")
                THIS.this_cGrupods     = TratarNulo(grupods,   "C")
                THIS.this_cUsuars      = TratarNulo(usuars,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RssBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cGrupoos))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo Origem.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cGrupods))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo Destino.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDuplicidade()
                MsgAviso("Grupo Origem , Grupo Destino j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se par (grupoos + grupods) ja existe
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdRps" + ;
                " WHERE grupoos = " + EscaparSQL(THIS.this_cGrupoos) + ;
                " AND   grupods = " + EscaparSQL(THIS.this_cGrupods)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                SELECT cursor_4c_ChkDup
                loc_lDuplicado = !EOF("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "RssBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult
        loc_cChave = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CAST(NEWID() AS varchar(36)) AS nova_chave", ;
                "cursor_4c_NovaChave")
            IF loc_nResult >= 0 AND USED("cursor_4c_NovaChave")
                SELECT cursor_4c_NovaChave
                loc_cChave = LEFT(ALLTRIM(cursor_4c_NovaChave.nova_chave), 20)
                USE IN cursor_4c_NovaChave
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "RssBO.GerarChaveUnica")
        ENDTRY

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarChaveUnica()
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar chave para o registro.", "RssBO.Inserir")
            ELSE
                loc_cSQL = "INSERT INTO SigCdRps" + ;
                    " (cidchaves, grupoos, grupods, datars, usuars)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                    EscaparSQL(THIS.this_cGrupoos)   + ", " + ;
                    EscaparSQL(THIS.this_cGrupods)   + ", " + ;
                    "GETDATE(), " + ;
                    EscaparSQL(gc_4c_UsuarioLogado)  + ;
                    ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir restri" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RssBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdRps SET" + ;
                " grupoos = " + EscaparSQL(THIS.this_cGrupoos)   + ", " + ;
                " grupods = " + EscaparSQL(THIS.this_cGrupods)   + ", " + ;
                " datars  = GETDATE(), " + ;
                " usuars  = " + EscaparSQL(gc_4c_UsuarioLogado)  + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RssBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRps WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RssBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca todos os registros para o grid da lista
    * Colunas do grid: grupoos (Grupo Origem), grupods (Grupo Destino)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        grupoos   C(10), ;
                        grupods   C(10), ;
                        cidchaves C(20)  ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupoos, grupods, cidchaves" + ;
                    " FROM SigCdRps"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY grupoos, grupods"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar restri" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RssBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, grupoos, grupods, usuars, datars" + ;
                " FROM SigCdRps WHERE cidchaves = " + EscaparSQL(par_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por chave:" + CHR(13) + loc_oErro.Message, "RssBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarDescricaoGrupo - Busca descricao de um grupo em SigCdGcr
    * Retorna a descricao ou string vazia se nao encontrado
    *==========================================================================
    PROCEDURE BuscarDescricaoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescrs
        loc_cDescrs = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(par_cCodigo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")
                IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    IF !EOF("cursor_4c_BuscaGcr")
                        loc_cDescrs = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
                    ENDIF
                    USE IN cursor_4c_BuscaGcr
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do grupo:" + ;
                CHR(13) + loc_oErro.Message, "RssBO.BuscarDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescrs
    ENDPROC

ENDDEFINE

