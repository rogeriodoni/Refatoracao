# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: Testes automaticos: 78% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 429

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[18/08/2026 23:57:54] FormLpr.ConfigurarPaginaDados: Erro: Property RECORDMARK is not found.
[18/08/2026 23:57:54] FormLpr.LimparCampos: Erro: Unknown member TXT_4C_TABD.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-18 23:54:05] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-18 23:54:05] [INFO] Config FPW: (nao fornecido)
[2026-08-18 23:54:05] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-18 23:54:05] [INFO] Timeout: 300 segundos
[2026-08-18 23:54:05] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yq0s2j4r.prg
[2026-08-18 23:54:05] [INFO] Conteudo do wrapper:
[2026-08-18 23:54:05] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormLpr', 'C:\4c\tasks\task461', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormLpr', 'C:\4c\tasks\task461', 'CRUD'
QUIT

[2026-08-18 23:54:05] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yq0s2j4r.prg
[2026-08-18 23:54:05] [INFO] VFP output esperado em: C:\4c\tasks\task461\vfp_output.txt
[2026-08-18 23:54:05] [INFO] Executando Visual FoxPro 9...
[2026-08-18 23:54:05] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yq0s2j4r.prg
[2026-08-18 23:54:06] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yq0s2j4r.prg
[2026-08-18 23:54:06] [INFO] Timeout configurado: 300 segundos
[2026-08-18 23:55:17] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-18 23:55:17] [INFO] VFP9 finalizado em 71.4052534 segundos
[2026-08-18 23:55:17] [INFO] Exit Code: 
[2026-08-18 23:55:17] [INFO] 
[2026-08-18 23:55:17] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-18 23:55:17] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yq0s2j4r.prg
[2026-08-18 23:55:17] [INFO] 
[2026-08-18 23:55:17] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-18 23:55:17] [INFO] * Auto-generated wrapper for parameters
[2026-08-18 23:55:17] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-18 23:55:17] [INFO] * Parameters: 'FormLpr', 'C:\4c\tasks\task461', 'CRUD'
[2026-08-18 23:55:17] [INFO] 
[2026-08-18 23:55:17] [INFO] * Anti-dialog protections for unattended execution
[2026-08-18 23:55:17] [INFO] SET SAFETY OFF
[2026-08-18 23:55:17] [INFO] SET RESOURCE OFF
[2026-08-18 23:55:17] [INFO] SET TALK OFF
[2026-08-18 23:55:17] [INFO] SET NOTIFY OFF
[2026-08-18 23:55:17] [INFO] SYS(2335, 0)
[2026-08-18 23:55:17] [INFO] 
[2026-08-18 23:55:17] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormLpr', 'C:\4c\tasks\task461', 'CRUD'
[2026-08-18 23:55:17] [INFO] QUIT
[2026-08-18 23:55:17] [INFO] 
[2026-08-18 23:55:17] [INFO] === Fim do Wrapper.prg ===
[2026-08-18 23:55:17] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-08-18 23:56:36] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-18 23:56:36] [INFO] Config FPW: (nao fornecido)
[2026-08-18 23:56:36] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-18 23:56:36] [INFO] Timeout: 300 segundos
[2026-08-18 23:56:36] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uhz0dgzq.prg
[2026-08-18 23:56:36] [INFO] Conteudo do wrapper:
[2026-08-18 23:56:36] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormLpr', 'C:\4c\tasks\task461', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormLpr', 'C:\4c\tasks\task461', 'CRUD'
QUIT

[2026-08-18 23:56:36] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uhz0dgzq.prg
[2026-08-18 23:56:36] [INFO] VFP output esperado em: C:\4c\tasks\task461\vfp_output.txt
[2026-08-18 23:56:36] [INFO] Executando Visual FoxPro 9...
[2026-08-18 23:56:36] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uhz0dgzq.prg
[2026-08-18 23:56:36] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uhz0dgzq.prg
[2026-08-18 23:56:36] [INFO] Timeout configurado: 300 segundos
[2026-08-18 23:57:55] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-08-18 23:57:55] [INFO] VFP9 finalizado em 78.4818739 segundos
[2026-08-18 23:57:55] [INFO] Exit Code: 
[2026-08-18 23:57:55] [INFO] 
[2026-08-18 23:57:55] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-18 23:57:55] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uhz0dgzq.prg
[2026-08-18 23:57:55] [INFO] 
[2026-08-18 23:57:55] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-18 23:57:55] [INFO] * Auto-generated wrapper for parameters
[2026-08-18 23:57:55] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-18 23:57:55] [INFO] * Parameters: 'FormLpr', 'C:\4c\tasks\task461', 'CRUD'
[2026-08-18 23:57:55] [INFO] 
[2026-08-18 23:57:55] [INFO] * Anti-dialog protections for unattended execution
[2026-08-18 23:57:55] [INFO] SET SAFETY OFF
[2026-08-18 23:57:55] [INFO] SET RESOURCE OFF
[2026-08-18 23:57:55] [INFO] SET TALK OFF
[2026-08-18 23:57:55] [INFO] SET NOTIFY OFF
[2026-08-18 23:57:55] [INFO] SYS(2335, 0)
[2026-08-18 23:57:55] [INFO] 
[2026-08-18 23:57:55] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormLpr', 'C:\4c\tasks\task461', 'CRUD'
[2026-08-18 23:57:55] [INFO] QUIT
[2026-08-18 23:57:55] [INFO] 
[2026-08-18 23:57:55] [INFO] === Fim do Wrapper.prg ===
[2026-08-18 23:57:55] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormLpr",
  "timestamp": "20260818235754",
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
      "passou": true,
      "erro": "",
      "detalhes": "Propriedade this_cModoAtual configurada"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormLpr.prg):
*==============================================================================
* FormLpr.prg - Listas de Precificacao
* Migrado de: SIGCDLPR.SCX
* Tabelas: SigCdLpc (cabecalho), SigCdLpi (itens da lista)
* Herda de: FormBase
*
* Uso: CREATEOBJECT("FormLpr")             && modo venda (padrao)
*      CREATEOBJECT("FormLpr", .T.)        && modo compra
*      CREATEOBJECT("FormLpr", .F., nome)  && venda com nome customizado
*==============================================================================

DEFINE CLASS FormLpr AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height          = 600
    Width           = 1000
    Caption         = "Listas de Precificacao"
    AutoCenter      = .T.
    ShowWindow      = 1
    WindowType      = 1
    ControlBox      = .F.
    TitleBar        = 0
    Themes          = .F.
    BorderStyle     = 2
    FontName        = "Tahoma"
    FontSize        = 8

    *-- Propriedades de navegacao
    this_oBusinessObject    = .NULL.
    this_cModoAtual         = "LISTA"

    *-- Propriedades especificas do SigCdLpr (mapeadas do ThisForm original)
    this_cCompVenda         = " "    && "C"=compra, " "=venda
    this_cPcEscolha         = ""     && INSERIR/ALTERAR/PROCURAR/EXCLUIR
    this_lBusca             = .F.    && flag modo busca ativo
    this_cAntCPro           = ""     && anti-bounce: ultimo cpros validado na grade
    this_cAntDPro           = ""     && anti-bounce: ultimo dpros validado na grade
    this_cAntLPreco         = ""     && anti-bounce: ultimo lpreco validado
    this_nOldCasas          = 0      && backup de SET DECIMALS antes do form
    this_lPlCancelar        = .F.    && flag: usuario cancelou operacao
    this_lUpdateok          = .T.    && flag: ultima operacao Update foi bem-sucedida
    this_cNomeFrm           = ""     && identidade do form para DO FORM ... WITH
    this_cLprecosAtual      = ""     && lpreco selecionado na lista (para detalhe)

    *==========================================================================
    * Init - Inicializa o formulario
    * par_lCompra: .T. = modo compra, .F. ou omitido = modo venda
    * par_cNomeFrm: nome alternativo do form (usado em DO FORM ... WITH ThisForm)
    *==========================================================================
    PROCEDURE Init(par_lCompra, par_cNomeFrm)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Definir modo compra vs venda ANTES do DODEFAULT()
            IF VARTYPE(par_lCompra) = "L" AND par_lCompra
                THIS.this_cCompVenda = "C"
            ELSE
                THIS.this_cCompVenda = " "
            ENDIF

            *-- Registrar nome customizado (para formularios abertos com DO FORM ... WITH)
            IF VARTYPE(par_cNomeFrm) = "C" AND !EMPTY(par_cNomeFrm)
                THIS.this_cNomeFrm = par_cNomeFrm
            ELSE
                THIS.this_cNomeFrm = "FormLpr"
            ENDIF

            *-- FormBase.Init() chama InicializarForm() internamente
            loc_lResultado = DODEFAULT()

        CATCH TO loException
            MsgErro("Erro: " + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "FormLpr.Init")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Caption com acentos (regra CLAUDE.md #4 - usar CHR())
            IF THIS.this_cCompVenda = "C"
                THIS.Caption = "Listas de Compra"
            ELSE
                THIS.Caption = "Listas de Precifica" + CHR(231) + CHR(227) + "o"
            ENDIF

            *-- Salvar decimais originais (restaurados no Destroy)
            THIS.this_nOldCasas = SET("Decimals")

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("LprBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                THIS.ConfigurarPageFrame()

                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Carregar dados apenas se nao estiver validando UI (sem conexao SQL)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"
                THIS.this_cPcEscolha           = ""

                loc_lSucesso = .T.

            ELSE
                MsgErro("Erro ao criar LprBO" + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loException
            MsgErro("Erro: " + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "FormLpr.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1=Lista e Page2=Dados
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        TRY
            THIS.AddObject("pgf_4c_Paginas", "PageFrame")
            WITH THIS.pgf_4c_Paginas
                .PageCount     = 2
                .Top           = -29
                .Left          = 0
                .Width         = THIS.Width
                .Height        = THIS.Height + 29
                .Tabs          = .F.
                .Visible       = .T.
                .Page1.Caption = "Lista"
                .Page2.Caption = "Dados"
                .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            ENDWITH
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1: Grid + botoes CRUD completo
    * Cabecalho, 5 botoes CRUD, Encerrar, filtros, Atualizar, Imprimir,
    * painel ImpLista (oculto) e grd_4c_Lista
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCnt, loc_oGrid
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *----------------------------------------------------------------------
            * Cabecalho cinza superior (cntSombra do legado)
            * Top=31 = 2 (original) + 29 (compensacao PageFrame.Top=-29)
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

                .AddObject("lbl_4c_Sombra", "Label")
                WITH .lbl_4c_Sombra
                    .Caption   = THIS.Caption
                    .Top       = 15
                    .Left      = 12
                    .Width     = THIS.Width
                    .Height    = 40
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(0, 0, 0)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Titulo", "Label")
                WITH .lbl_4c_Titulo
                    .Caption   = THIS.Caption
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .AutoSize  = .F.
                    .FontName  = "Tahoma"
                    .FontSize  = 16
                    .FontBold  = .T.
                    .ForeColor = RGB(255, 255, 255)
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *----------------------------------------------------------------------
            * Container botoes CRUD (lado direito - Grupo_Op do legado)
            * 5 botoes: Incluir(5), Visualizar(80), Alterar(155), Excluir(230), Buscar(305)
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
            loc_oCnt = loc_oPagina.cnt_4c_Botoes
            WITH loc_oCnt
                .Top         = 29
                .Left        = 542
                .Width       = 390
                .Height      = 85
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("cmd_4c_Incluir", "CommandButton")
                WITH .cmd_4c_Incluir
                    .Caption         = "Incluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Tahoma"
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

                .AddObject("cmd_4c_Visualizar", "CommandButton")
                WITH .cmd_4c_Visualizar
                    .Caption         = "Visualizar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Tahoma"
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

                .AddObject("cmd_4c_Alterar", "CommandButton")
                WITH .cmd_4c_Alterar
                    .Caption         = "Alterar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Tahoma"
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

                .AddObject("cmd_4c_Excluir", "CommandButton")
                WITH .cmd_4c_Excluir
                    .Caption         = "Excluir"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Tahoma"
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

                .AddObject("cmd_4c_Buscar", "CommandButton")
                WITH .cmd_4c_Buscar
                    .Caption         = "Buscar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            =  542
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Tahoma"
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
            ENDWITH

            *----------------------------------------------------------------------
            * Container Saida (padrao canonico - CLAUDE.md regra #10)
            * Left=917, Width=90, cmd_4c_Encerrar (Width=75, Height=75)
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

                .AddObject("cmd_4c_Encerrar", "CommandButton")
                WITH .cmd_4c_Encerrar
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 917
                    .Width           = 90
                    .Height          = 75
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .SpecialEffect   = 0
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .T.
                ENDWITH
            ENDWITH

            *----------------------------------------------------------------------
            * Container filtros de vencimento (cntFiltros.Optiongroup1 do legado)
            * Top=115 = 82 (original cntFiltros.Top) + 29 + 4 (Optiongroup1.Top)
            * 3 opcoes: Todos / A Vencer / Vencidos
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
            WITH loc_oPagina.cnt_4c_Filtros
                .Top         = 115
                .Left        = 2
                .Width       = 260
                .Height      = 33
                .BackStyle   = 0
                .BorderWidth = 0
                .Visible     = .T.

                .AddObject("opt_4c_Vencimento", "OptionGroup")
                WITH .opt_4c_Vencimento
                    .ButtonCount = 3
                    .Top         = 4
                    .Left        = 6
                    .Width       = 238
                    .Height      = 25
                    .BackStyle   = 0
                    .Value       = 1
                    .Visible     = .T.
                    WITH .Buttons(1)
                        .Caption   = "Todos"
                        .Left      = 0
                        .Top       = 3
                        .Width     = 50
                        .AutoSize  = .T.
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH
                    WITH .Buttons(2)
                        .Caption   = "A Vencer"
                        .Left      = 60
                        .Top       = 3
                        .Width     = 72
                        .AutoSize  = .T.
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .ForeColor = RGB(90, 90, 90)
                        .Themes    = .F.
                    ENDWITH
                    WITH .Buttons(3)
                        .Caption   = "Vencidos"
                        .Left      = 140
                        .Top       = 3
                        .Width     = 72
                        .AutoSize  = .T.
                        .FontName  = "Tahoma"
                        .FontSize  = 8
                        .ForeColor = RGB(90, 90, 90)
                        .Themes    = .F.
                    ENDWITH
                ENDWITH
            ENDWITH

            *----------------------------------------------------------------------
            * Botao Atualizar (bnt_Atualiza do legado)
            * Publica lista no sistema (flags=1). Top=119 = 90+29, Left=287
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("cmd_4c_Atualizar", "CommandButton")
            WITH loc_oPagina.cmd_4c_Atualizar
                .Caption         = "Atualizar"
                .Picture         = gc_4c_CaminhoIcones + "geral_confirmar_32.jpg"
                .PicturePosition = 13
                .Top             = 119
                .Left            = 287
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
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

            *----------------------------------------------------------------------
            * Botao Imprimir standalone (imprimir do legado)
            * Abre painel ImpLista. Top=119 = 90+29, Left=367
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("cmd_4c_ImprimirLista", "CommandButton")
            WITH loc_oPagina.cmd_4c_ImprimirLista
                .Caption         = "Imprimir"
                .Picture         = gc_4c_CaminhoIcones + "geral_imprimir_32.jpg"
                .PicturePosition = 13
                .Top             = 119
                .Left            = 367
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
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

            *----------------------------------------------------------------------
            * Container painel impressao (ImpLista do legado) - inicial oculto
            * Top=273 = 244 (original) + 29. Aparece sobre o grid ao clicar Imprimir.
            * TornarControlesVisiveis pula este container mas processa seus filhos.
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_ImpLista", "Container")
            WITH loc_oPagina.cnt_4c_ImpLista
                .Top         = 273
                .Left        = 211
                .Width       = 577
                .Height      = 129
                .BackStyle   = 1
                .BackColor   = RGB(240, 240, 240)
                .BorderWidth = 1
                .Visible     = .F.

                .AddObject("lbl_4c_TituloImp", "Label")
                WITH .lbl_4c_TituloImp
                    .Caption   = "Impress" + CHR(227) + "o de Listas"
                    .Top       = 9
                    .Left      = 25
                    .Width     = 203
                    .Height    = 26
                    .FontName  = "Tahoma"
                    .FontSize  = 10
                    .FontBold  = .T.
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_TipoImpLabel", "Label")
                WITH .lbl_4c_TipoImpLabel
                    .Caption   = "Tipo :"
                    .Top       = 45
                    .Left      = 30
                    .Width     = 29
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("opt_4c_TipoImp", "OptionGroup")
                WITH .opt_4c_TipoImp
                    .ButtonCount = 4
                    .Top         = 41
                    .Left        = 57
                    .Width       = 214
                    .Height      = 51
                    .BackStyle   = 0
                    .Value       = 1
                    .Visible     = .T.
                    WITH .Buttons(1)
                        .Caption  = "Vendas"
                        .Left     = 0
                        .Top      = 3
                        .AutoSize = .T.
                        .Themes   = .F.
                    ENDWITH
                    WITH .Buttons(2)
                        .Caption  = "Compras"
                        .Left     = 70
                        .Top      = 3
                        .AutoSize = .T.
                        .FontName = "Tahoma"
                        .FontSize = 8
                        .Themes   = .F.
                    ENDWITH
                    WITH .Buttons(3)
                        .Caption  = "An" + CHR(225) + "lise"
                        .Left     = 0
                        .Top      = 28
                        .AutoSize = .T.
                        .FontName = "Tahoma"
                        .FontSize = 8
                        .Themes   = .F.
                    ENDWITH
                    WITH .Buttons(4)
                        .Caption  = "Embalagem"
                        .Left     = 70
                        .Top      = 28
                        .AutoSize = .T.
                        .FontName = "Tahoma"
                        .FontSize = 8
                        .Themes   = .F.
                    ENDWITH
                ENDWITH

                .AddObject("lbl_4c_FotoLabel", "Label")
                WITH .lbl_4c_FotoLabel
                    .Caption   = "Imagem :"
                    .Top       = 88
                    .Left      = 13
                    .Width     = 47
                    .Height    = 15
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Visible   = .T.
                ENDWITH

                .AddObject("opt_4c_FotoImp", "OptionGroup")
                WITH .opt_4c_FotoImp
                    .ButtonCount = 2
                    .Top         = 84
                    .Left        = 57
                    .Width       = 97
                    .Height      = 25
                    .BackStyle   = 0
                    .Value       = 2
                    .Visible     = .T.
                    WITH .Buttons(1)
                        .Caption  = "Com"
                        .Left     = 0
                        .Top      = 3
                        .AutoSize = .T.
                        .Themes   = .F.
                    ENDWITH
                    WITH .Buttons(2)
                        .Caption  = "Sem"
                        .Left     = 45
                        .Top      = 3
                        .AutoSize = .T.
                        .FontName = "Tahoma"
                        .FontSize = 8
                        .Themes   = .F.
                    ENDWITH
                ENDWITH

                *-- Botao Excel
                .AddObject("cmd_4c_ImpExcel", "CommandButton")
                WITH .cmd_4c_ImpExcel
                    .Caption         = "\<Excel"
                    .Picture         = gc_4c_CaminhoIcones + "geral_excel_32.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 422
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Tahoma"
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

                *-- Botao Video (Visualizar relatorio)
                .AddObject("cmd_4c_ImpVideo", "CommandButton")
                WITH .cmd_4c_ImpVideo
                    .Caption         = "\<V" + CHR(237) + "deo"
                    .Picture         = gc_4c_CaminhoIcones + "geral_visualizar_32.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 347
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Tahoma"
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

                *-- Botao Impressora
                .AddObject("cmd_4c_ImpImpressora", "CommandButton")
                WITH .cmd_4c_ImpImpressora
                    .Caption         = "\<Impressora"
                    .Picture         = gc_4c_CaminhoIcones + "geral_imprimir_32.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 272
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Tahoma"
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

                *-- Botao Fechar painel (cmd_grupo do legado)
                .AddObject("cmd_4c_ImpFechar", "CommandButton")
                WITH .cmd_4c_ImpFechar
                    .Caption         = "Fechar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .PicturePosition = 13
                    .Top             = -2
                    .Left            = 493
                    .Width           = 85
                    .Height          = 85
                    .FontName        = "Tahoma"
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
            ENDWITH

            *----------------------------------------------------------------------
            * Grid principal (Grade do legado - mostra CrSigCdLpc)
            * Top=200: abaixo dos botoes Atualizar/Imprimir (top=119, height=75 -> ate 194)
            * Width=910: nao sobrepoe cnt_4c_Saida (left=917)
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("grd_4c_Lista", "Grid")
            loc_oGrid = loc_oPagina.grd_4c_Lista
            loc_oGrid.Top               = 200
            loc_oGrid.Left              = 2
            loc_oGrid.Width             = 910
            loc_oGrid.Height            = 389
            loc_oGrid.FontName          = "Verdana"
            loc_oGrid.FontSize          = 8
            loc_oGrid.ForeColor         = RGB(90, 90, 90)
            loc_oGrid.BackColor         = RGB(255, 255, 255)
            loc_oGrid.GridLineColor     = RGB(238, 238, 238)
            loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
            loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
            loc_oGrid.HighlightStyle    = 2
            loc_oGrid.DeleteMark        = .F.
            loc_oGrid.RecordMark        = .F.
            loc_oGrid.RowHeight         = 18
            loc_oGrid.ScrollBars        = 2
            loc_oGrid.ReadOnly          = .T.
            loc_oGrid.GridLines         = 3
            loc_oGrid.Visible           = .T.
            *-- ColumnCount FORA do WITH para criar colunas imediatamente
            loc_oGrid.ColumnCount       = 4
            WITH loc_oGrid
                .Column1.Header1.Caption  = "Lista de Pre" + CHR(231) + "os"
                .Column1.Width            = 250
                .Column1.ReadOnly         = .T.
                .Column2.Header1.Caption  = "Cond. Pagamento"
                .Column2.Width            = 130
                .Column2.ReadOnly         = .T.
                .Column3.Header1.Caption  = "Vencimento"
                .Column3.Width            = 120
                .Column3.ReadOnly         = .T.
                .Column4.Header1.Caption  = "Atualizada"
                .Column4.Width            = 80
                .Column4.ReadOnly         = .T.
            ENDWITH

            *----------------------------------------------------------------------
            * BINDEVENTs dos botoes (todos os handlers devem ser PUBLIC)
            *----------------------------------------------------------------------
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
            BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
            BINDEVENT(loc_oPagina.cmd_4c_Atualizar,                "Click", THIS, "BtnAtualizarClick")
            BINDEVENT(loc_oPagina.cmd_4c_ImprimirLista,            "Click", THIS, "BtnImprimirListaClick")
            BINDEVENT(loc_oPagina.cnt_4c_Filtros.opt_4c_Vencimento, "InteractiveChange", THIS, "FiltroVencimentoChanged")
            BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpVideo,      "Click", THIS, "BtnImpVideoClick")
            BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpImpressora, "Click", THIS, "BtnImpImpressoraClick")
            BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpExcel,      "Click", THIS, "BtnImpExcelClick")
            BINDEVENT(loc_oPagina.cnt_4c_ImpLista.cmd_4c_ImpFechar,     "Click", THIS, "BtnImpFecharClick")

            THIS.TornarControlesVisiveis(loc_oPagina)

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2: campos do cabecalho SigCdLpc (Fase 5)
    * Campos: Empresa, Codigo, Lpreco, Fpg, area de busca na grade, botoes
    * Fase 6 adiciona: Grade/GradeC (itens SigCdLpi) e controles ocultos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCnt
        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *----------------------------------------------------------------------
            * Container botoes acao do cabecalho (Grupo_Salva do legado)
            * Top=33=4+29, Left=842, Width=160, Height=85
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
            loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
            WITH loc_oCnt
                .Top         = 33
                .Left        = 842
                .Width       = 160
                .Height      = 85
                .BackStyle   = 0
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
                    .FontName        = "Tahoma"
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

                .AddObject("cmd_4c_Cancelar", "CommandButton")
                WITH .cmd_4c_Cancelar
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .PicturePosition = 13
                    .Top             = 5
                    .Left            = 80
                    .Width           = 75
                    .Height          = 75
                    .FontName        = "Tahoma"
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
            ENDWITH

            *----------------------------------------------------------------------
            * Shape1 - retangulo de agrupamento lado direito (Shape1 do legado)
            * top=8+29=37, left=723, width=91, height=110
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPagina.shp_4c_Shape1
                .Top         = 37
                .Left        = 723
                .Width       = 91
                .Height      = 110
                .BorderStyle = 1
                .BorderColor = RGB(90, 90, 90)
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            *----------------------------------------------------------------------
            * Say4 "Empresa :" + txt_4c_Emps (getEmps do legado)
            * Say4: top=16+29=45, left=56, width=50, height=15
            * txt_4c_Emps: top=12+29=41, left=108, width=35, height=23
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Say4", "Label")
            WITH loc_oPagina.lbl_4c_Say4
                .Caption   = "Empresa :"
                .Top       = 45
                .Left      = 56
                .Width     = 50
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
            WITH loc_oPagina.txt_4c_Emps
                .Value     = ""
                .Top       = 41
                .Left      = 108
                .Width     = 35
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 3
                .Visible   = .T.
            ENDWITH

            *----------------------------------------------------------------------
            * Say3 "Codigo :" + txt_4c_Codigo (Get_codigo do legado - somente leitura)
            * Say3: top=42+29=71, left=64, width=42, height=15
            * txt_4c_Codigo: top=38+29=67, left=108, width=94, height=23
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Say3", "Label")
            WITH loc_oPagina.lbl_4c_Say3
                .Caption   = "C" + CHR(243) + "digo :"
                .Top       = 71
                .Left      = 64
                .Width     = 42
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPagina.txt_4c_Codigo
                .Value     = ""
                .Top       = 67
                .Left      = 108
                .Width     = 94
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 30
                .ReadOnly  = .T.
                .Visible   = .T.
            ENDWITH

            *----------------------------------------------------------------------
            * txt_4c_Lpreco (Get_lpreco do legado) - codigo da lista de precos
            * top=38+29=67, left=205, width=290, height=23
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("txt_4c_Lpreco", "TextBox")
            WITH loc_oPagina.txt_4c_Lpreco
                .Value     = ""
                .Top       = 67
                .Left      = 205
                .Width     = 290
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 30
                .Visible   = .T.
            ENDWITH

            *----------------------------------------------------------------------
            * Say12 "Cond. Pagto :" + txt_4c_Fpg (Get_fpg do legado)
            * Say12: top=68+29=97, left=37, width=69, height=15
            * txt_4c_Fpg: top=65+29=94, left=108, width=94, height=23
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_Say12", "Label")
            WITH loc_oPagina.lbl_4c_Say12
                .Caption   = "Cond. Pagto :"
                .Top       = 97
                .Left      = 37
                .Width     = 69
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Fpg", "TextBox")
            WITH loc_oPagina.txt_4c_Fpg
                .Value     = ""
                .Top       = 94
                .Left      = 108
                .Width     = 94
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 12
                .Visible   = .T.
            ENDWITH

            *----------------------------------------------------------------------
            * Shape2 - linha separadora horizontal (top=145+29=174, left=9, width=980)
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
            WITH loc_oPagina.shp_4c_Shape2
                .Top         = 174
                .Left        = 9
                .Width       = 980
                .Height      = 1
                .BorderStyle = 1
                .BorderColor = RGB(90, 90, 90)
                .BackStyle   = 0
                .Visible     = .T.
            ENDWITH

            *----------------------------------------------------------------------
            * Area de busca na grade (abaixo da linha separadora):
            * lbl_4c_LblProcura: top=158+29=187, left=56, width=55, height=13
            * txt_4c_Txtcpros:   top=154+29=183, left=108, width=119, height=22
            * txt_4c_Txtdpros:   top=154+29=183, left=230, width=342, height=22
            * cmd_4c_Busca:      top=149+29=178, left=576, width=36,  height=33
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("lbl_4c_LblProcura", "Label")
            WITH loc_oPagina.lbl_4c_LblProcura
                .Caption   = "Busca :"
                .Top       = 187
                .Left      = 56
                .Width     = 55
                .Height    = 13
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Txtcpros", "TextBox")
            WITH loc_oPagina.txt_4c_Txtcpros
                .Value     = ""
                .Top       = 183
                .Left      = 108
                .Width     = 119
                .Height    = 22
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 14
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Txtdpros", "TextBox")
            WITH loc_oPagina.txt_4c_Txtdpros
                .Value     = ""
                .Top       = 183
                .Left      = 230
                .Width     = 342
                .Height    = 22
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 40
                .Visible   = .T.
            ENDWITH

            loc_oPagina.AddObject("cmd_4c_Busca", "CommandButton")
            WITH loc_oPagina.cmd_4c_Busca
                .Caption         = ""
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 0
                .Top             = 178
                .Left            = 576
                .Width           = 36
                .Height          = 33
                .FontName        = "Tahoma"
                .FontSize        = 8
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .Visible         = .T.
            ENDWITH

            *----------------------------------------------------------------------
            * BINDEVENTs dos controles da Page2 (Fase 5)
            *----------------------------------------------------------------------
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click",     THIS, "BtnSalvarClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click",     THIS, "BtnCancelarClick")
            BINDEVENT(loc_oPagina.txt_4c_Emps,    "KeyPress",                     THIS, "ValidarEmpresa")
            BINDEVENT(loc_oPagina.txt_4c_Lpreco,  "KeyPress",                     THIS, "ValidarLpreco")
            BINDEVENT(loc_oPagina.txt_4c_Fpg,     "KeyPress",                     THIS, "ValidarFpg")
            BINDEVENT(loc_oPagina.txt_4c_Txtcpros, "KeyPress",                    THIS, "ValidarCpros")
            BINDEVENT(loc_oPagina.txt_4c_Txtdpros, "KeyPress",                    THIS, "ValidarDpros")
            BINDEVENT(loc_oPagina.cmd_4c_Busca,   "Click",                         THIS, "BtnBuscaGradeClick")

            *----------------------------------------------------------------------
            * grd_4c_GradeC - Grade modo COMPRA (7 colunas)
            * top=184+29=213, left=8, width=982, height=293
            * ControlSources sao vinculados em VincularGrade() quando cursor existe
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("grd_4c_GradeC", "Grid")
            loc_oPagina.grd_4c_GradeC.ColumnCount  = 7
            loc_oPagina.grd_4c_GradeC.RecordSource = ""
            WITH loc_oPagina.grd_4c_GradeC
                .Top          = 213
                .Left         = 8
                .Width        = 982
                .Height       = 293
                .ReadOnly     = .F.
                .GridLines    = 1
                .DeleteMark   = .F.
                .Visible      = .T.
                .FontName     = "Tahoma"
                .FontSize     = 8
                WITH .Column1
                    .Width = 100
                    .RecordMark   = .F.
                ENDWITH
                WITH .Column2
                    .Width = 250
                ENDWITH
                WITH .Column3
                    .Width = 130
                ENDWITH
                WITH .Column4
                    .Width = 110
                ENDWITH
                WITH .Column5
                    .Width = 120
                ENDWITH
                WITH .Column6
                    .Width = 52
                ENDWITH
                WITH .Column7
                    .Width = 120
                ENDWITH
            ENDWITH

            *----------------------------------------------------------------------
            * grd_4c_Grade - Grade modo VENDA (9 colunas)
            * top=184+29=213, left=8, width=982, height=293
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("grd_4c_Grade", "Grid")
            loc_oPagina.grd_4c_Grade.ColumnCount  = 9
            loc_oPagina.grd_4c_Grade.RecordSource = ""
            WITH loc_oPagina.grd_4c_Grade
                .Top          = 213
                .Left         = 8
                .Width        = 982
                .Height       = 293
                .ReadOnly     = .F.
                .GridLines    = 1
                .DeleteMark   = .F.
                .Visible      = .T.
                .FontName     = "Tahoma"
                .FontSize     = 8
                WITH .Column1
                    .Width = 100
                    .RecordMark   = .F.
                ENDWITH
                WITH .Column2
                    .Width = 250
                ENDWITH
                WITH .Column3
                    .Width = 90
                ENDWITH
                WITH .Column4
                    .Width = 50
                ENDWITH
                WITH .Column5
                    .Width = 70
                ENDWITH
                WITH .Column6
                    .Width = 90
                ENDWITH
                WITH .Column7
                    .Width = 90
                ENDWITH
                WITH .Column8
                    .Width = 50
                ENDWITH
                WITH .Column9
                    .Width = 82
                ENDWITH
            ENDWITH

            *----------------------------------------------------------------------
            * Botoes de acao na grade (linha inferior: top=499+29=528)
            * INSERE=left28, DELETE=left103, COPIA=left178, Seleciona=left253
            * CmdVencimento=left328 - todos width=75, height=75
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("cmd_4c_INSERE", "CommandButton")
            WITH loc_oPagina.cmd_4c_INSERE
                .Caption         = "Inserir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                .PicturePosition = 13
                .Top             = 528
                .Left            = 28
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            loc_oPagina.AddObject("cmd_4c_DELETE", "CommandButton")
            WITH loc_oPagina.cmd_4c_DELETE
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top             = 528
                .Left            = 103
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            loc_oPagina.AddObject("cmd_4c_COPIA", "CommandButton")
            WITH loc_oPagina.cmd_4c_COPIA
                .Caption         = "Duplicar"
                .Picture         = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
                .PicturePosition = 13
                .Top             = 528
                .Left            = 178
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            loc_oPagina.AddObject("cmd_4c_Seleciona", "CommandButton")
            WITH loc_oPagina.cmd_4c_Seleciona
                .Caption         = "Selecionar"
                .Picture         = gc_4c_CaminhoIcones + "geral_marcar_60.jpg"
                .PicturePosition = 13
                .Top             = 528
                .Left            = 253
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            loc_oPagina.AddObject("cmd_4c_CmdVencimento", "CommandButton")
            WITH loc_oPagina.cmd_4c_CmdVencimento
                .Caption         = "Vencimento"
                .Picture         = gc_4c_CaminhoIcones + "geral_datas_60.jpg"
                .PicturePosition = 13
                .Top             = 528
                .Left            = 328
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .T.
            ENDWITH

            *----------------------------------------------------------------------
            * cnt_4c_Vencimentos - painel flutuante de data de vencimento em massa
            * top=499+29=528, left=415, width=200, height=75, Visible=.F.
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Vencimentos", "Container")
            WITH loc_oPagina.cnt_4c_Vencimentos
                .Top         = 528
                .Left        = 415
                .Width       = 200
                .Height      = 75
                .BackStyle   = 1
                .BackColor   = RGB(255, 255, 220)
                .Visible     = .F.

                .AddObject("lbl_4c_VencSay", "Label")
                WITH .lbl_4c_VencSay
                    .Caption   = "Vencimento Em:"
                    .Top       = 10
                    .Left      = 10
                    .Width     = 90
                    .Height    = 15
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_GetVencs", "TextBox")
                WITH .txt_4c_GetVencs
                    .Value    = {}
                    .Top      = 30
                    .Left     = 10
                    .Width    = 80
                    .Height   = 23
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Visible  = .T.
                ENDWITH

                .AddObject("cmd_4c_SalvaVenc", "CommandButton")
                WITH .cmd_4c_SalvaVenc
                    .Caption   = "OK"
                    .Top       = 15
                    .Left      = 100
                    .Width     = 42
                    .Height    = 42
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Themes    = .F.
                    .Visible   = .T.
                ENDWITH

                .AddObject("cmd_4c_FechaVenc", "CommandButton")
                WITH .cmd_4c_FechaVenc
                    .Caption   = "X"
                    .Top       = 15
                    .Left      = 148
                    .Width     = 42
                    .Height    = 42
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Themes    = .F.
                    .Visible   = .T.
                ENDWITH
            ENDWITH

            *----------------------------------------------------------------------
            * Controles opcionais (Visible=.F.) - ativados conforme flags da lista
            * opt_4c_Opt_Comissao  : top=63+29=92,  left=288 - tipo comissao
            * opt_4c_Opt_ApliTabD  : top=91+29=120, left=621 - aplica tab.desconto
            * opt_4c_Opt_Vencimento: top=63+29=92,  left=621 - tipo vencimento
            * opt_4c_Opt_Formula   : top=38+29=67,  left=621 - tipo formula
            * lbl_4c_Say9          : top=42+29=71,  left=540 - "Aplica Formulas"
            * txt_4c_Tabd          : top=91+29=120, left=108 - tabela desconto
            * txt_4c_Juros         : top=91+29=120, left=294 - % juros a.m.
            * cmd_4c_SelecionaC    : top=2+29=31,   left=773 - sel.produtos compra
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("opt_4c_Opt_Comissao", "OptionGroup")
            WITH loc_oPagina.opt_4c_Opt_Comissao
                .ButtonCount = 2
                .Top         = 92
                .Left        = 288
                .Width       = 94
                .Height      = 22
                .Value       = 1
                .BackStyle   = 0
                .Visible     = .F.
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Left      = 0
                    .Top       = 3
                    .Width     = 40
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Left      = 44
                    .Top       = 3
                    .Width     = 50
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            loc_oPagina.AddObject("opt_4c_Opt_ApliTabD", "OptionGroup")
            WITH loc_oPagina.opt_4c_Opt_ApliTabD
                .ButtonCount = 2
                .Top         = 120
                .Left        = 621
                .Width       = 94
                .Height      = 22
                .Value       = 1
                .BackStyle   = 0
                .Visible     = .F.
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Left      = 0
                    .Top       = 3
                    .Width     = 40
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Left      = 44
                    .Top       = 3
                    .Width     = 50
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            loc_oPagina.AddObject("opt_4c_Opt_Vencimento", "OptionGroup")
            WITH loc_oPagina.opt_4c_Opt_Vencimento
                .ButtonCount = 2
                .Top         = 92
                .Left        = 621
                .Width       = 94
                .Height      = 22
                .Value       = 1
                .BackStyle   = 0
                .Visible     = .F.
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Left      = 0
                    .Top       = 3
                    .Width     = 40
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Left      = 44
                    .Top       = 3
                    .Width     = 50
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            loc_oPagina.AddObject("opt_4c_Opt_Formula", "OptionGroup")
            WITH loc_oPagina.opt_4c_Opt_Formula
                .ButtonCount = 2
                .Top         = 67
                .Left        = 621
                .Width       = 94
                .Height      = 22
                .Value       = 1
                .BackStyle   = 0
                .Visible     = .F.
                WITH .Buttons(1)
                    .Caption   = "Sim"
                    .Left      = 0
                    .Top       = 3
                    .Width     = 40
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .Themes    = .F.
                ENDWITH
                WITH .Buttons(2)
                    .Caption   = "N" + CHR(227) + "o"
                    .Left      = 44
                    .Top       = 3
                    .Width     = 50
                    .AutoSize  = .T.
                    .ForeColor = RGB(90, 90, 90)
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            loc_oPagina.AddObject("lbl_4c_Say9", "Label")
            WITH loc_oPagina.lbl_4c_Say9
                .Caption   = "Aplica F" + CHR(243) + "rmulas :"
                .Top       = 71
                .Left      = 540
                .Width     = 80
                .Height    = 15
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .BackStyle = 0
                .Visible   = .F.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Tabd", "TextBox")
            WITH loc_oPagina.txt_4c_Tabd
                .Value     = ""
                .Top       = 120
                .Left      = 108
                .Width     = 94
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .MaxLength = 10
                .Visible   = .F.
            ENDWITH

            loc_oPagina.AddObject("txt_4c_Juros", "TextBox")
            WITH loc_oPagina.txt_4c_Juros
                .Value    = 0
                .Top      = 120
                .Left     = 294
                .Width    = 69
                .Height   = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .Visible  = .F.
            ENDWITH

            loc_oPagina.AddObject("cmd_4c_SelecionaC", "CommandButton")
            WITH loc_oPagina.cmd_4c_SelecionaC
                .Caption         = "Selecionar Produtos"
                .Picture         = gc_4c_CaminhoIcones + "geral_marcar_60.jpg"
                .PicturePosition = 13
                .Top             = 31
                .Left            = 773
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .AutoSize        = .F.
                .Visible         = .F.
            ENDWITH

            *----------------------------------------------------------------------
            * cnt_4c_Compra - Container modo compra: Indice, Fornecedor, Data
            * top=89+29=118, left=-15, width=512, height=51, Visible=.F.
            *----------------------------------------------------------------------
            loc_oPagina.AddObject("cnt_4c_Compra", "Container")
            WITH loc_oPagina.cnt_4c_Compra
                .Top         = 118
                .Left        = -15
                .Width       = 512
                .Height      = 51
                .BackStyle   = 0
                .Visible     = .F.

                .AddObject("lbl_4c_CompraIndice", "Label")
                WITH .lbl_4c_CompraIndice
                    .Caption   = CHR(205) + "ndice Reajuste :"
                    .Top       = 32
                    .Left      = 37
                    .Width     = 85
                    .Height    = 15
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .T.
                ENDWITH

                .AddObject("txt_4c_GetIndice", "TextBox")
                WITH .txt_4c_GetIndice
                    .Value    = ""
                    .Top      = 28
                    .Left     = 123
                    .Width    = 94
                    .Height   = 23
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Visible  = .T.
                ENDWITH

                .AddObject("lbl_4c_CompraForn", "Label")
                WITH .lbl_4c_CompraForn
                    .Caption   = "Fornecedor :"
                    .Top       = 5
                    .Left      = 57
                    .Width     = 70
                    .Height    = 15
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .F.
                ENDWITH

                .AddObject("txt_4c_GetConta", "TextBox")
                WITH .txt_4c_GetConta
                    .Value    = ""
                    .Top      = 2
                    .Left     = 123
                    .Width    = 94
                    .Height   = 23
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Visible  = .F.
                ENDWITH

                .AddObject("txt_4c_GetDconta", "TextBox")
                WITH .txt_4c_GetDconta
                    .Value    = ""
                    .Top      = 2
                    .Left     = 219
                    .Width    = 290
                    .Height   = 23
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Visible  = .F.
                ENDWITH

                .AddObject("lbl_4c_CompraDataIni", "Label")
                WITH .lbl_4c_CompraDataIni
                    .Caption   = "Data Inicial :"
                    .Top       = 32
                    .Left      = 246
                    .Width     = 70
                    .Height    = 15
                    .BackStyle = 0
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Visible   = .F.
                ENDWITH

                .AddObject("txt_4c_FwVenc", "TextBox")
                WITH .txt_4c_FwVenc
                    .Value    = {}
                    .Top      = 28
                    .Left     = 310
                    .Width    = 80
                    .Height   = 23
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .Visible  = .F.
                ENDWITH
            ENDWITH

            *----------------------------------------------------------------------
            * BINDEVENTs para controles adicionados na Fase 6
            *----------------------------------------------------------------------
            BINDEVENT(loc_oPagina.cmd_4c_INSERE,        "Click",            THIS, "BtnINSEREClick")
            BINDEVENT(loc_oPagina.cmd_4c_DELETE,        "Click",            THIS, "BtnDELETEClick")
            BINDEVENT(loc_oPagina.cmd_4c_COPIA,         "Click",            THIS, "BtnCOPIAClick")
            BINDEVENT(loc_oPagina.cmd_4c_Seleciona,     "Click",            THIS, "BtnSelecionaClick")
            BINDEVENT(loc_oPagina.cmd_4c_CmdVencimento, "Click",            THIS, "BtnCmdVencimentoClick")
            BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_SalvaVenc, "Click", THIS, "BtnSalvaVencimentoClick")
            BINDEVENT(loc_oPagina.cnt_4c_Vencimentos.cmd_4c_FechaVenc, "Click", THIS, "BtnFechaVencimentoClick")
            BINDEVENT(loc_oPagina.cmd_4c_SelecionaC,   "Click",            THIS, "BtnSelecionaCClick")
            BINDEVENT(loc_oPagina.grd_4c_Grade,  "AfterRowColChange", THIS, "GradeAfterRowColChange")
            BINDEVENT(loc_oPagina.grd_4c_GradeC, "AfterRowColChange", THIS, "GradeAfterRowColChange")
            BINDEVENT(loc_oPagina.txt_4c_Tabd, "KeyPress",  THIS, "TeclaTabd")
            BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetConta,  "KeyPress",  THIS, "TeclaGetConta")
            BINDEVENT(loc_oPagina.cnt_4c_Compra.txt_4c_GetDconta, "KeyPress",  THIS, "TeclaGetDconta")

            THIS.TornarControlesVisiveis(loc_oPagina)

            *-- Ocultar controles opcionais apos TornarControlesVisiveis
            loc_oPagina.opt_4c_Opt_Comissao.Visible   = .F.
            loc_oPagina.opt_4c_Opt_ApliTabD.Visible   = .F.
            loc_oPagina.opt_4c_Opt_Vencimento.Visible = .F.
            loc_oPagina.opt_4c_Opt_Formula.Visible    = .F.
            loc_oPagina.lbl_4c_Say9.Visible           = .F.
            loc_oPagina.txt_4c_Tabd.Visible           = .F.
            loc_oPagina.txt_4c_Juros.Visible          = .F.
            loc_oPagina.cmd_4c_SelecionaC.Visible     = .F.

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva o cabecalho da lista de precos (SigCdLpc)
    * Chamado pelo cmd_4c_Confirmar da Page2
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        *-- Validacoes obrigatorias ANTES do TRY (RETURN fora do TRY)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value))
            MsgAviso("C" + CHR(243) + "digo da Lista de Pre" + CHR(231) + ;
                CHR(227) + "o obrigat" + CHR(243) + "rio!", "Aviso")
            loc_oPg2.txt_4c_Lpreco.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                LOCAL loc_cLprecoSalvo
                loc_cLprecoSalvo = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
                IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0
                    IF THIS.this_oBusinessObject.SalvarItens(loc_cLprecoSalvo)
                        MsgInfo("Lista salva com sucesso!", "")
                        THIS.AlternarPagina(1)
                    ELSE
                        MsgErro("Cabe" + CHR(231) + "alho salvo mas houve erro ao salvar itens.", "Aviso")
                    ENDIF
                ELSE
                    MsgInfo("Lista salva com sucesso!", "")
                    THIS.AlternarPagina(1)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar:" + CHR(13) + loException.Message, "FormLpr.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para a lista (Page1)
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cPcEscolha    = ""
            THIS.this_cLprecosAtual = ""
            THIS.AlternarPagina(1)
        CATCH TO loException
            MsgErro("Erro ao cancelar:" + CHR(13) + loException.Message, "FormLpr.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarEmpresa - LostFocus do txt_4c_Emps
    * Valida empresa digitada; se vazio pre-preenche com empresa logada
    *==========================================================================
    PROCEDURE ValidarEmpresa(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cEmps, loc_nResult
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_cEmps = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)

            IF EMPTY(loc_cEmps)
                loc_oPg2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ELSE
                *-- Verificar se empresa existe em SigCdEmp
                LOCAL loc_cSQL
                loc_cSQL = "SELECT TOP 1 CEmps FROM SigCdEmp WHERE CEmps = " + ;
                           EscaparSQL(loc_cEmps)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldEmps")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldEmps") = 0
                    MsgErro("Empresa [" + loc_cEmps + "] n" + CHR(227) + "o encontrada!", "Aviso")
                    loc_oPg2.txt_4c_Emps.Value = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF
                IF USED("cursor_4c_VldEmps")
                    USE IN cursor_4c_VldEmps
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.ValidarEmpresa")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarLpreco - LostFocus do txt_4c_Lpreco
    * Para INSERIR: verifica duplicata. Para PROCURAR: carrega registro.
    *==========================================================================
    PROCEDURE ValidarLpreco(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cLpreco, loc_nResult
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)

        IF EMPTY(loc_cLpreco) OR loc_cLpreco == THIS.this_cAntLPreco
            RETURN
        ENDIF

        THIS.this_cAntLPreco = loc_cLpreco

        TRY
            IF THIS.this_cPcEscolha = "INSERIR"
                *-- Verificar duplicata
                LOCAL loc_cSQL2
                loc_cSQL2 = "SELECT TOP 1 lprecos FROM SigCdLpc WHERE lprecos = " + ;
                            EscaparSQL(loc_cLpreco)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL2, "cursor_4c_VldLpr")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldLpr") > 0
                    MsgErro("Lista de Pre" + CHR(231) + "o [" + loc_cLpreco + ;
                        "] j" + CHR(225) + " cadastrada!", "Aviso")
                    loc_oPg2.txt_4c_Lpreco.Value = THIS.this_cAntLPreco
                ENDIF
                IF USED("cursor_4c_VldLpr")
                    USE IN cursor_4c_VldLpr
                ENDIF
            ELSE
                IF THIS.this_cPcEscolha = "PROCURAR"
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLpreco)
                    THIS.BOParaForm()
                ELSE
                    MsgAviso("Lista [" + loc_cLpreco + "] n" + CHR(227) + ;
                        "o encontrada!", "Aviso")
                    loc_oPg2.txt_4c_Lpreco.Value = ""
                    THIS.this_cAntLPreco = ""
                ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.ValidarLpreco")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarFpg - LostFocus do txt_4c_Fpg (Cond. Pagamento)
    * Lookup em SigOpFp por fpags (campo fpags)
    *==========================================================================
    PROCEDURE ValidarFpg(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cFpg
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_cFpg = ALLTRIM(loc_oPg2.txt_4c_Fpg.Value)

        IF EMPTY(loc_cFpg)
            RETURN
        ENDIF

        TRY
            LOCAL loc_oBusca, loc_cSQL3
            *-- Verificar se fpag existe
            loc_cSQL3 = "SELECT TOP 1 fpags FROM SigOpFp WHERE fpags = " + EscaparSQL(loc_cFpg)
            LOCAL loc_nRes
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL3, "cursor_4c_BuscaFpg")
            IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_BuscaFpg") = 0
                *-- Nao encontrou exato - abrir lookup
                IF USED("cursor_4c_BuscaFpg")
                    USE IN cursor_4c_BuscaFpg
                ENDIF
                THIS.AbrirBuscaFpg(loc_cFpg)
            ELSE
                IF USED("cursor_4c_BuscaFpg")
                    USE IN cursor_4c_BuscaFpg
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.ValidarFpg")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaFpg - Abre FormBuscaAuxiliar para selecionar Cond. Pagamento
    *==========================================================================
    PROCEDURE AbrirBuscaFpg(par_cFpgAtual)
        LOCAL loc_oPg2, loc_oBusca
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpFp", "cursor_4c_BuscaFpg", "fpags", ;
                ALLTRIM(par_cFpgAtual), "Condi" + CHR(231) + CHR(245) + "es de Pagamento")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("fpags",  "XXXXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("fparcs", "",             "Parcelas")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
                    SELECT cursor_4c_BuscaFpg
                    loc_oPg2.txt_4c_Fpg.Value = ALLTRIM(cursor_4c_BuscaFpg.fpags)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oPg2.txt_4c_Fpg.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaFpg")
                USE IN cursor_4c_BuscaFpg
            ENDIF

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaFpg")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarCpros - LostFocus do txt_4c_Txtcpros (busca na grade por codigo)
    * Lookup em SigCdPro por cpros; preenche txt_4c_Txtdpros automaticamente
    *==========================================================================
    PROCEDURE ValidarCpros(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cCpros, loc_oBusca
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cCpros = ALLTRIM(loc_oPg2.txt_4c_Txtcpros.Value)

        IF EMPTY(loc_cCpros) OR loc_cCpros == THIS.this_cAntCPro
            RETURN
        ENDIF

        THIS.this_cAntCPro = loc_cCpros

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProd", "cpros", loc_cCpros, "Produtos", 1000)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                    SELECT cursor_4c_BuscaProd
                    loc_oPg2.txt_4c_Txtcpros.Value = ALLTRIM(cursor_4c_BuscaProd.cpros)
                    loc_oPg2.txt_4c_Txtdpros.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
                    THIS.this_cAntCPro = ALLTRIM(cursor_4c_BuscaProd.cpros)
                    THIS.this_cAntDPro = ALLTRIM(cursor_4c_BuscaProd.dpros)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oPg2.txt_4c_Txtcpros.Value = ""
                        loc_oPg2.txt_4c_Txtdpros.Value = ""
                        THIS.this_cAntCPro = ""
                        THIS.this_cAntDPro = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.ValidarCpros")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarDpros - LostFocus do txt_4c_Txtdpros (busca na grade por descricao)
    * Ativo apenas quando txt_4c_Txtcpros estiver vazio
    *==========================================================================
    PROCEDURE ValidarDpros(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cDpros, loc_oBusca
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cDpros = ALLTRIM(loc_oPg2.txt_4c_Txtdpros.Value)

        IF !EMPTY(loc_oPg2.txt_4c_Txtcpros.Value)
            RETURN
        ENDIF

        IF EMPTY(loc_cDpros) OR loc_cDpros == THIS.this_cAntDPro
            RETURN
        ENDIF

        THIS.this_cAntDPro = loc_cDpros

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaProd", "dpros", loc_cDpros, "Produtos", 1000)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                    SELECT cursor_4c_BuscaProd
                    loc_oPg2.txt_4c_Txtdpros.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
                    loc_oPg2.txt_4c_Txtcpros.Value = ALLTRIM(cursor_4c_BuscaProd.cpros)
                    THIS.this_cAntDPro = ALLTRIM(cursor_4c_BuscaProd.dpros)
                    THIS.this_cAntCPro = ALLTRIM(cursor_4c_BuscaProd.cpros)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oPg2.txt_4c_Txtdpros.Value = ""
                        THIS.this_cAntDPro = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.ValidarDpros")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscaGradeClick - Click do botao Busca na area de pesquisa da grade
    * Busca no cursor de itens (cursor_4c_Itens) pelo cpros digitado e
    * posiciona o foco na grade (grade sera vinculada na Fase 6)
    *==========================================================================
    PROCEDURE BtnBuscaGradeClick()
        LOCAL loc_oPg2, loc_cCpros
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_cCpros = ALLTRIM(loc_oPg2.txt_4c_Txtcpros.Value)

        TRY
            IF USED("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                SET NEAR ON
                IF !EMPTY(loc_cCpros)
                    SEEK PADR(loc_cCpros, 14) ORDER "cpros"
                ENDIF
                SET NEAR OFF

                *-- Tentar focar na grade de itens (adicionada na Fase 6)
                IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
                    loc_oPg2.grd_4c_Grade.Column1.SetFocus()
                ELSE
                    IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5)
                    loc_oPg2.grd_4c_GradeC.Column1.SetFocus()
                    ENDIF
                ENDIF
            ENDIF

            loc_oPg2.txt_4c_Txtcpros.Refresh()
            loc_oPg2.txt_4c_Txtdpros.Refresh()

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.BtnBuscaGradeClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores do formulario para o Business Object
    * Fase 5: campos do cabecalho SigCdLpc
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            WITH THIS.this_oBusinessObject
                .this_cEmps    = ALLTRIM(loc_oPg2.txt_4c_Emps.Value)
                .this_cLprecos = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)
                .this_cFpags   = ALLTRIM(loc_oPg2.txt_4c_Fpg.Value)
                .this_cTipos   = THIS.this_cCompVenda
                .this_cTabds   = ALLTRIM(loc_oPg2.txt_4c_Tabd.Value)
            ENDWITH
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do Business Object para o formulario
    * Fase 5: campos do cabecalho SigCdLpc
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            WITH THIS.this_oBusinessObject
                loc_oPg2.txt_4c_Emps.Value   = ALLTRIM(.this_cEmps)
                loc_oPg2.txt_4c_Codigo.Value = ALLTRIM(.this_nCodigos)
                loc_oPg2.txt_4c_Lpreco.Value = ALLTRIM(.this_cLprecos)
                loc_oPg2.txt_4c_Fpg.Value    = ALLTRIM(.this_cFpags)
                loc_oPg2.txt_4c_Tabd.Value   = ALLTRIM(.this_cTabds)
            ENDWITH

            *-- Anti-bounce: atualizar rastreadores
            THIS.this_cAntLPreco = ALLTRIM(THIS.this_oBusinessObject.this_cLprecos)
            THIS.this_cAntCPro   = ""
            THIS.this_cAntDPro   = ""
            loc_oPg2.txt_4c_Txtcpros.Value = ""
            loc_oPg2.txt_4c_Txtdpros.Value = ""

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos editaveis da Page2
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPg2.txt_4c_Emps.Value     = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            loc_oPg2.txt_4c_Codigo.Value   = ""
            loc_oPg2.txt_4c_Lpreco.Value   = ""
            loc_oPg2.txt_4c_Fpg.Value      = ""
            loc_oPg2.txt_4c_Tabd.Value     = ""
            loc_oPg2.txt_4c_Txtcpros.Value = ""
            loc_oPg2.txt_4c_Txtdpros.Value = ""
            THIS.this_cAntLPreco = ""
            THIS.this_cAntCPro   = ""
            THIS.this_cAntDPro   = ""
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos conforme modo e flags
    * par_lHabilitar: .T. = habilitar campos editaveis, .F. = somente leitura
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lFlags
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_lFlags = .F.

        TRY
            *-- Verificar se a lista ja foi publicada (flags=1)
            IF THIS.this_cPcEscolha = "ALTERAR" AND ;
               USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_lFlags = (TratarNulo(cursor_4c_Dados.flags, "N") = 1)
            ENDIF

            *-- Emps: editavel apenas em INSERIR e quando nao flags
            loc_oPg2.txt_4c_Emps.ReadOnly   = !(par_lHabilitar AND !loc_lFlags)
            *-- Lpreco: editavel apenas em INSERIR (nao pode mudar PK em ALTERAR)
            loc_oPg2.txt_4c_Lpreco.ReadOnly = !(par_lHabilitar AND THIS.this_cPcEscolha = "INSERIR")
            *-- Fpg: editavel em INSERIR e ALTERAR (quando nao flags)
            loc_oPg2.txt_4c_Fpg.ReadOnly    = !(par_lHabilitar AND !loc_lFlags)
            *-- Campos de busca na grade: sempre editaveis quando ha lista selecionada
            loc_oPg2.txt_4c_Txtcpros.ReadOnly = !par_lHabilitar
            loc_oPg2.txt_4c_Txtdpros.ReadOnly = !par_lHabilitar
            *-- Botoes acao
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
            loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarItens - Carrega SigCdLpi no cursor_4c_Itens e vincula grids
    * par_cLprecos: codigo da lista; vazio = nova lista (cursor nao carregado)
    *==========================================================================
    PROTECTED PROCEDURE CarregarItens(par_cLprecos)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            IF !EMPTY(ALLTRIM(par_cLprecos))
                loc_lSucesso = THIS.this_oBusinessObject.CarregarItens(par_cLprecos, THIS.this_cCompVenda)
            ENDIF

            IF loc_lSucesso AND USED("cursor_4c_Itens")
                *-- Criar indice para SEEK em BtnBuscaGradeClick
                SELECT cursor_4c_Itens
                INDEX ON PADR(cpros, 14) TAG cpros ADDITIVE
                GO TOP
            ENDIF

            THIS.VincularGrade()

        CATCH TO loException
            MsgErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "FormLpr.CarregarItens")
        ENDTRY
    ENDPROC

    *==========================================================================
    * VincularGrade - Define RecordSource, ControlSources e Headers dos grids
    * Exibe grd_4c_GradeC em modo compra; grd_4c_Grade em modo venda
    *==========================================================================
    PROTECTED PROCEDURE VincularGrade()
        LOCAL loc_oPg2, loc_lModoCompra, loc_oGrid
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2
        loc_lModoCompra = (THIS.this_cCompVenda = "C")

        TRY
            IF loc_lModoCompra
                *-- Modo compra: grd_4c_GradeC visivel, grd_4c_Grade oculta
                IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5)
                    loc_oGrid = loc_oPg2.grd_4c_GradeC
                    IF USED("cursor_4c_Itens")
                        loc_oGrid.ColumnCount = 7
                        loc_oGrid.RecordSource         = "cursor_4c_Itens"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.cpros"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.dpros"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.reffs"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.ean13"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.pcuss"
                        loc_oGrid.Column6.ControlSource = "cursor_4c_Itens.moevs"
                        loc_oGrid.Column7.ControlSource = "cursor_4c_Itens.pvens"
                    ELSE
                        loc_oGrid.RecordSource = ""
                    ENDIF
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
                    loc_oGrid.Column3.Header1.Caption = "Ref.Fornecedor"
                    loc_oGrid.Column4.Header1.Caption = "EAN"
                    loc_oGrid.Column5.Header1.Caption = "Custo Atual"
                    loc_oGrid.Column6.Header1.Caption = "Moe"
                    loc_oGrid.Column7.Header1.Caption = "Custo Novo"
                    loc_oGrid.FontName = "Verdana"
                    loc_oGrid.FontSize = 8
                    loc_oGrid.Visible = .T.
                    loc_oGrid.Refresh()
                ENDIF
                IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
                    loc_oPg2.grd_4c_Grade.Visible = .F.
                ENDIF
            ELSE
                *-- Modo venda: grd_4c_Grade visivel, grd_4c_GradeC oculta
                IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5)
                    loc_oGrid = loc_oPg2.grd_4c_Grade
                    IF USED("cursor_4c_Itens")
                        loc_oGrid.ColumnCount = 9
                        loc_oGrid.RecordSource         = "cursor_4c_Itens"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Itens.cpros"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Itens.dpros"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Itens.pvens"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Itens.moevs"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Itens.comiss"
                        loc_oGrid.Column6.ControlSource = "cursor_4c_Itens.vencis"
                        loc_oGrid.Column7.ControlSource = "cursor_4c_Itens.vencfs"
                        loc_oGrid.Column8.ControlSource = "cursor_4c_Itens.cgrus"
                        loc_oGrid.Column9.ControlSource = "cursor_4c_Itens.precode"
                    ELSE
                        loc_oGrid.RecordSource = ""
                    ENDIF
                    loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o do Produto"
                    loc_oGrid.Column3.Header1.Caption = "Pr. Venda"
                    loc_oGrid.Column4.Header1.Caption = "Moe"
                    loc_oGrid.Column5.Header1.Caption = "Comiss."
                    loc_oGrid.Column6.Header1.Caption = "Venc. Inicial"
                    loc_oGrid.Column7.Header1.Caption = "Venc. Final"
                    loc_oGrid.Column8.Header1.Caption = "C"
                    loc_oGrid.Column9.Header1.Caption = "Pr. De"
                    loc_oGrid.FontName = "Verdana"
                    loc_oGrid.FontSize = 8
                    loc_oGrid.Visible = .T.
                    loc_oGrid.Refresh()
                ENDIF
                IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5)
                    loc_oPg2.grd_4c_GradeC.Visible = .F.
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao vincular grade:" + CHR(13) + loException.Message, "FormLpr.VincularGrade")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnINSEREClick - Insere linha em branco no cursor de itens da lista
    *==========================================================================
    PROCEDURE BtnINSEREClick()
        LOCAL loc_oPg2, loc_cLpreco
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)

        IF EMPTY(loc_cLpreco)
            MsgAviso("Salve o cabe" + CHR(231) + "alho da lista antes de inserir itens.", "Aviso")
            RETURN
        ENDIF

        TRY
            IF !USED("cursor_4c_Itens")
                SET NULL ON
                CREATE CURSOR cursor_4c_Itens (cidchaves c(20), lprecos c(30), ;
                    cpros c(14), dpros c(40), reffs c(20), ean13 n(13,0), ;
                    pcuss n(16,6), moevs c(3), pvens n(16,6), vencis d, ;
                    vencfs d, comiss n(7,4), cgrus c(3), flagutabs n(1,0), ;
                    ordems n(6,0), ccontroles c(1), precode n(16,6))
                SET NULL OFF
            ENDIF

            SELECT cursor_4c_Itens
            SET FILTER TO
            INSERT INTO cursor_4c_Itens (lprecos, ordems) VALUES (loc_cLpreco, 255)
            SET FILTER TO !DELETED("cursor_4c_Itens")

            THIS.VincularGrade()

            SELECT cursor_4c_Itens
            GO BOTTOM

            IF THIS.this_cCompVenda = "C" AND PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) ;
                    AND loc_oPg2.grd_4c_GradeC.Visible
                loc_oPg2.grd_4c_GradeC.Column1.SetFocus()
            ELSE
                IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
                loc_oPg2.grd_4c_Grade.Column1.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inserir item:" + CHR(13) + loException.Message, "FormLpr.BtnINSEREClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnDELETEClick - Marca item atual como excluido no cursor de itens
    *==========================================================================
    PROCEDURE BtnDELETEClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND ;
               !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
                IF MsgConfirma("Confirma exclus" + CHR(227) + "o do item?", "Confirmar")
                    SELECT cursor_4c_Itens
                    IF !DELETED()
                        DELETE
                        SET FILTER TO !DELETED("cursor_4c_Itens")
                        GO TOP
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
                        loc_oPg2.grd_4c_Grade.Refresh()
                    ENDIF
                    IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) AND loc_oPg2.grd_4c_GradeC.Visible
                        loc_oPg2.grd_4c_GradeC.Refresh()
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Nenhum item selecionado para excluir.", "Aviso")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir item:" + CHR(13) + loException.Message, "FormLpr.BtnDELETEClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCOPIAClick - Duplica o item atual no cursor de itens
    *==========================================================================
    PROCEDURE BtnCOPIAClick()
        LOCAL loc_oPg2, loc_cLpreco
        LOCAL loc_cCpros, loc_cDpros, loc_cMoevs, loc_cCgrus, loc_cReffs
        LOCAL loc_nPvens, loc_nComiss, loc_nEan13, loc_nPcuss, loc_nPrecode
        LOCAL loc_dVencis, loc_dVencfs
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)

        TRY
            IF USED("cursor_4c_Itens") AND RECCOUNT("cursor_4c_Itens") > 0 AND ;
               !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                loc_cCpros   = ALLTRIM(TratarNulo(cpros,   "C"))
                loc_cDpros   = ALLTRIM(TratarNulo(dpros,   "C"))
                loc_cMoevs   = ALLTRIM(TratarNulo(moevs,   "C"))
                loc_cCgrus   = ALLTRIM(TratarNulo(cgrus,   "C"))
                loc_cReffs   = ALLTRIM(TratarNulo(reffs,   "C"))
                loc_nPvens   = TratarNulo(pvens,   "N")
                loc_nComiss  = TratarNulo(comiss,  "N")
                loc_nEan13   = TratarNulo(ean13,   "N")
                loc_nPcuss   = TratarNulo(pcuss,   "N")
                loc_nPrecode = TratarNulo(precode, "N")
                loc_dVencis  = TratarNulo(vencis,  "D")
                loc_dVencfs  = TratarNulo(vencfs,  "D")

                SET FILTER TO
                INSERT INTO cursor_4c_Itens ;
                    (lprecos, cpros, dpros, moevs, cgrus, reffs, pvens, comiss, ;
                     ean13, pcuss, precode, vencis, vencfs, ordems) ;
                    VALUES (loc_cLpreco, loc_cCpros, loc_cDpros, loc_cMoevs, ;
                            loc_cCgrus, loc_cReffs, loc_nPvens, loc_nComiss, ;
                            loc_nEan13, loc_nPcuss, loc_nPrecode, loc_dVencis, ;
                            loc_dVencfs, 255)
                SET FILTER TO !DELETED("cursor_4c_Itens")

                THIS.VincularGrade()

                SELECT cursor_4c_Itens
                GO BOTTOM
            ELSE
                MsgAviso("Nenhum item selecionado para duplicar.", "Aviso")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao duplicar item:" + CHR(13) + loException.Message, "FormLpr.BtnCOPIAClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSelecionaClick - Abre browser de produtos para adicionar item a lista
    *==========================================================================
    PROCEDURE BtnSelecionaClick()
        LOCAL loc_oPg2, loc_oBusca, loc_nResult, loc_cSQL, loc_cLpreco
        LOCAL loc_cCpros, loc_cDpros, loc_nPvens, loc_nPcuss, loc_cMoevs
        LOCAL loc_cCgrus, loc_cReffs, loc_nEan13
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_cLpreco = ALLTRIM(loc_oPg2.txt_4c_Lpreco.Value)

        IF EMPTY(loc_cLpreco)
            MsgAviso("Salve o cabe" + CHR(231) + "alho da lista antes de selecionar produtos.", "Aviso")
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 500 cpros, dpros, pvens, pcuss, moevs, cgrus, reffs, ean13" + ;
                       " FROM SigCdPro ORDER BY cpros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaProd")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaProd") > 0
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oBusca) = "O"
                    loc_oBusca.DefinirCursor("cursor_4c_BuscaProd", "cpros", "dpros", ;
                        "Selecionar Produto")
                    loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaProd"
                    loc_oBusca.Mostrar()

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                        SELECT cursor_4c_BuscaProd
                        loc_cCpros  = ALLTRIM(cursor_4c_BuscaProd.cpros)
                        loc_cDpros  = ALLTRIM(cursor_4c_BuscaProd.dpros)
                        loc_nPvens  = TratarNulo(cursor_4c_BuscaProd.pvens,  "N")
                        loc_nPcuss  = TratarNulo(cursor_4c_BuscaProd.pcuss,  "N")
                        loc_cMoevs  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.moevs, "C"))
                        loc_cCgrus  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.cgrus, "C"))
                        loc_cReffs  = ALLTRIM(TratarNulo(cursor_4c_BuscaProd.reffs, "C"))
                        loc_nEan13  = TratarNulo(cursor_4c_BuscaProd.ean13,  "N")

                        IF !USED("cursor_4c_Itens")
                            SET NULL ON
                            CREATE CURSOR cursor_4c_Itens (cidchaves c(20), lprecos c(30), ;
                                cpros c(14), dpros c(40), reffs c(20), ean13 n(13,0), ;
                                pcuss n(16,6), moevs c(3), pvens n(16,6), vencis d, ;
                                vencfs d, comiss n(7,4), cgrus c(3), flagutabs n(1,0), ;
                                ordems n(6,0), ccontroles c(30), precode n(16,6))
                            SET NULL OFF
                        ENDIF

                        SELECT cursor_4c_Itens
                        SET FILTER TO
                        INSERT INTO cursor_4c_Itens ;
                            (lprecos, cpros, dpros, moevs, cgrus, reffs, ean13, ordems, ;
                             pvens, pcuss) ;
                            VALUES (loc_cLpreco, loc_cCpros, loc_cDpros, loc_cMoevs, ;
                                    loc_cCgrus, loc_cReffs, loc_nEan13, 255, ;
                                    IIF(THIS.this_cCompVenda = "C", loc_nPcuss, loc_nPvens), ;
                                    loc_nPcuss)
                        SET FILTER TO !DELETED("cursor_4c_Itens")
                        GO BOTTOM

                        THIS.VincularGrade()
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
            ELSE
                MsgAviso("Nenhum produto encontrado.", "Aviso")
            ENDIF

            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao selecionar produto:" + CHR(13) + loException.Message, "FormLpr.BtnSelecionaClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCmdVencimentoClick - Exibe ou oculta o painel de vencimento em massa
    *==========================================================================
    PROCEDURE BtnCmdVencimentoClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Vencimentos", 5)
                loc_oPg2.cnt_4c_Vencimentos.Visible = !loc_oPg2.cnt_4c_Vencimentos.Visible
                IF loc_oPg2.cnt_4c_Vencimentos.Visible
                    *-- Pre-preencher com data atual
                    loc_oPg2.cnt_4c_Vencimentos.txt_4c_GetVencs.Value = DATE()
                    loc_oPg2.cnt_4c_Vencimentos.txt_4c_GetVencs.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.BtnCmdVencimentoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvaVencimentoClick - Aplica data de vencimento a todos os itens
    *==========================================================================
    PROCEDURE BtnSalvaVencimentoClick()
        LOCAL loc_oPg2, loc_dVenc
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        TRY
            IF PEMSTATUS(loc_oPg2, "cnt_4c_Vencimentos", 5) AND ;
               PEMSTATUS(loc_oPg2.cnt_4c_Vencimentos, "txt_4c_GetVencs", 5)
                loc_dVenc = loc_oPg2.cnt_4c_Vencimentos.txt_4c_GetVencs.Value
            ELSE
                loc_dVenc = DATE()
            ENDIF

            IF USED("cursor_4c_Itens") AND VARTYPE(loc_dVenc) = "D" AND !EMPTY(loc_dVenc)
                SELECT cursor_4c_Itens
                SET FILTER TO
                GO TOP
                SCAN
                    IF !DELETED()
                        REPLACE vencis WITH loc_dVenc
                    ENDIF
                ENDSCAN
                SET FILTER TO !DELETED("cursor_4c_Itens")
                GO TOP
                IF PEMSTATUS(loc_oPg2, "grd_4c_Grade", 5) AND loc_oPg2.grd_4c_Grade.Visible
                    loc_oPg2.grd_4c_Grade.Refresh()
                ENDIF
                IF PEMSTATUS(loc_oPg2, "grd_4c_GradeC", 5) AND loc_oPg2.grd_4c_GradeC.Visible
                    loc_oPg2.grd_4c_GradeC.Refresh()
                ENDIF
            ENDIF

            IF PEMSTATUS(loc_oPg2, "cnt_4c_Vencimentos", 5)
                loc_oPg2.cnt_4c_Vencimentos.Visible = .F.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao aplicar vencimento:" + CHR(13) + loException.Message, "FormLpr.BtnSalvaVencimentoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnFechaVencimentoClick - Oculta o painel de vencimento sem salvar
    *==========================================================================
    PROCEDURE BtnFechaVencimentoClick()
        TRY
            IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_Vencimentos", 5)
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Vencimentos.Visible = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.BtnFechaVencimentoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSelecionaCClick - Selecionar Produtos (modo compra, Visible=.F. padrao)
    * Reutiliza logica de BtnSelecionaClick adaptada para compra
    *==========================================================================
    PROCEDURE BtnSelecionaCClick()
        THIS.BtnSelecionaClick()
    ENDPROC

    *==========================================================================
    * GradeAfterRowColChange - Handler AfterRowColChange dos grids Grade/GradeC
    * par_nColIndex: coluna que ficou ativa ANTES do usuario sair (coluna origem)
    * Quando sai da coluna 1 (cpros): busca produto e pre-preenche campos
    *==========================================================================
    PROCEDURE GradeAfterRowColChange(par_nColIndex)
        LOCAL loc_cCpros, loc_nResult, loc_cSQL, loc_lContinuar
        loc_cCpros     = ""
        loc_lContinuar = .T.

        TRY
            IF par_nColIndex = 1 AND USED("cursor_4c_Itens") AND ;
               !EOF("cursor_4c_Itens") AND !BOF("cursor_4c_Itens")
                SELECT cursor_4c_Itens
                loc_cCpros = ALLTRIM(TratarNulo(cpros, "C"))

                IF !EMPTY(loc_cCpros)
                    *-- Verificar grupo em modo venda (bloqueado para certos grupos)
                    IF THIS.this_cCompVenda <> "C"
                        IF !THIS.this_oBusinessObject.ChecaGrpVenda(loc_cCpros)
                            SELECT cursor_4c_Itens
                            REPLACE cpros WITH "", dpros WITH ""
                            loc_lContinuar = .F.
                        ENDIF
                    ENDIF

                    IF loc_lContinuar
                        *-- Buscar produto no catalogo e pre-preencher campos da linha
                        loc_cSQL = "SELECT cpros, dpros, pvens, pcuss, moevs, cgrus, reffs, ean13" + ;
                                   " FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldPro")

                        IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldPro") > 0
                            SELECT cursor_4c_Itens
                            REPLACE dpros WITH ALLTRIM(cursor_4c_VldPro.dpros)
                            IF EMPTY(ALLTRIM(TratarNulo(moevs, "C")))
                                REPLACE moevs WITH ALLTRIM(cursor_4c_VldPro.moevs)
                            ENDIF
                            IF EMPTY(ALLTRIM(TratarNulo(cgrus, "C")))
                                REPLACE cgrus WITH ALLTRIM(cursor_4c_VldPro.cgrus)
                            ENDIF
                            IF THIS.this_cCompVenda = "C"
                                *-- Modo compra: custo atual + reffs + ean
                                IF TratarNulo(pcuss, "N") = 0
                                    REPLACE pcuss WITH TratarNulo(cursor_4c_VldPro.pcuss, "N")
                                ENDIF
                                IF EMPTY(ALLTRIM(TratarNulo(reffs, "C")))
                                    REPLACE reffs WITH ALLTRIM(cursor_4c_VldPro.reffs)
                                ENDIF
                                IF TratarNulo(ean13, "N") = 0
                                    REPLACE ean13 WITH TratarNulo(cursor_4c_VldPro.ean13, "N")
                                ENDIF
                            ELSE
                                *-- Modo venda: preco de venda
                                IF TratarNulo(pvens, "N") = 0
                                    REPLACE pvens WITH TratarNulo(cursor_4c_VldPro.pvens, "N")
                                ENDIF
                            ENDIF
                        ELSE
                            SELECT cursor_4c_Itens
                            REPLACE dpros WITH ""
                        ENDIF

                        IF USED("cursor_4c_VldPro")
                            USE IN cursor_4c_VldPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro na grade (col " + TRANSFORM(par_nColIndex) + "):" + ;
                    CHR(13) + loException.Message, "FormLpr.GradeAfterRowColChange")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega lista de SigCdLpc no Grid da Page1
    * Chama Buscar() no BO com filtro de CompVenda e opcoes de vencimento
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid, loc_nFiltroVenc
        loc_lResultado  = .F.
        loc_nFiltroVenc = 1

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar(THIS.this_cCompVenda)

                    *-- Ler filtro de vencimento (1=Todos, 2=A Vencer, 3=Vencidos)
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Filtros", 5)
                        loc_nFiltroVenc = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_Vencimento.Value
                    ENDIF

                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        DO CASE
                            CASE loc_nFiltroVenc = 2
                                SET FILTER TO vencis >= DATE()
                            CASE loc_nFiltroVenc = 3
                                SET FILTER TO !EMPTY(vencis) AND vencis < DATE()
                            OTHERWISE
                                SET FILTER TO
                        ENDCASE
                        GO TOP
                    ENDIF

                    *-- Vincular grid: RecordSource -> ControlSources -> Headers
                    *   VFP9 sobrescreve ControlSources e Headers ao trocar RecordSource
                    IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        IF USED("cursor_4c_Dados")
                            loc_oGrid.ColumnCount = 4
                            loc_oGrid.RecordSource = "cursor_4c_Dados"
                            loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.lprecos"
                            loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.fpags"
                            loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.vencis"
                            loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.flags"
                            loc_oGrid.Column1.Header1.Caption = "Lista de Pre" + CHR(231) + "os"
                            loc_oGrid.Column2.Header1.Caption = "Cond. Pagamento"
                            loc_oGrid.Column3.Header1.Caption = "Vencimento"
                            loc_oGrid.Column4.Header1.Caption = "Atualizada"
                            THIS.FormatarGridLista(loc_oGrid)
                            loc_oGrid.Refresh()
                        ENDIF
                    ENDIF

                    loc_lResultado = .T.
                ELSE
                    loc_lResultado = .F.
                ENDIF
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), "FormLpr.CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Containers flutuantes que devem iniciar ocultos sao pulados (mas seus
    * filhos sao processados para que fiquem prontos ao serem exibidos).
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- Containers flutuantes que iniciam ocultos no legado
                IF INLIST(loc_cNome, "CNT_4C_IMPLISTA", "CNT_4C_VENCIMENTOS", "CNT_4C_COMPRA", ;
                    "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
                    *-- Nao tornar visivel, mas processar filhos (ficam prontos para Show)
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- PageFrame: iterar Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Containers: recursar nos filhos
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (lista) e Page2 (detalhe de itens)
    * Ao voltar para Page1 (par_nPagina=1) recarrega a lista automaticamente
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            THIS.this_cModoAtual = IIF(par_nPagina = 1, "LISTA", "DADOS")
            IF par_nPagina = 1
                THIS.this_cPcEscolha    = ""
                THIS.this_cLprecosAtual = ""
                THIS.CarregarLista()
            ELSE
                *-- Ir para Page2: preencher cabecalho e carregar itens da lista
                THIS.LimparCampos()
                IF THIS.this_cPcEscolha <> "INSERIR"
                    THIS.BOParaForm()
                ELSE
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Emps.Value = ;
                        ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF
                THIS.CarregarItens(THIS.this_cLprecosAtual)
                THIS.HabilitarCampos(.T.)
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia inclusao de nova lista de precos (vai para Page2)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_cPcEscolha                         = "INSERIR"
            THIS.this_cLprecosAtual                       = ""
            THIS.this_oBusinessObject.this_lNovoRegistro  = .T.
            THIS.this_oBusinessObject.this_cLprecos       = ""
            THIS.AlternarPagina(2)
        CATCH TO loException
            MsgErro("Erro ao incluir:" + CHR(13) + loException.Message, "FormLpr.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualiza lista selecionada em modo somente leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cLprecos, loc_lOk
        loc_cLprecos = ""
        loc_lOk      = .F.

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
               !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
                loc_lOk = .T.
            ENDIF

            IF loc_lOk AND !EMPTY(loc_cLprecos)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
                    THIS.this_cPcEscolha    = "PROCURAR"
                    THIS.this_cLprecosAtual = loc_cLprecos
                    THIS.AlternarPagina(2)
                ENDIF
            ELSE
                MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao visualizar:" + CHR(13) + loException.Message, "FormLpr.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Altera lista selecionada
    * Se flags=1 (ja publicada), pede confirmacao antes de prosseguir
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cLprecos, loc_nFlags, loc_lOk, loc_lProsseguir
        loc_cLprecos    = ""
        loc_nFlags      = 0
        loc_lOk         = .F.
        loc_lProsseguir = .T.

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
               !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
                loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
                loc_lOk = .T.
            ENDIF

            IF loc_lOk AND !EMPTY(loc_cLprecos)
                IF loc_nFlags = 1
                    loc_lProsseguir = MsgConfirma("Esta lista j" + CHR(225) + ;
                        " foi atualizada no sistema." + CHR(13) + ;
                        "Deseja alterar mesmo assim?", "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF

                IF loc_lProsseguir
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
                        THIS.this_cPcEscolha    = "ALTERAR"
                        THIS.this_cLprecosAtual = loc_cLprecos
                        THIS.AlternarPagina(2)
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao alterar:" + CHR(13) + loException.Message, "FormLpr.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Exclui lista selecionada
    * Bloqueia exclusao se lista ja foi publicada (flags=1)
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cLprecos, loc_nFlags, loc_lOk
        loc_cLprecos = ""
        loc_nFlags   = 0
        loc_lOk      = .F.

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
               !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
                loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
                loc_lOk = .T.
            ENDIF

            IF loc_lOk AND !EMPTY(loc_cLprecos)
                IF loc_nFlags = 1
                    MsgErro("Lista j" + CHR(225) + " atualizada no sistema." + CHR(13) + ;
                            "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
                            "vel excluir!", "Aviso")
                ELSE
                    IF MsgConfirma("Confirma exclus" + CHR(227) + "o da lista [" + ;
                                   loc_cLprecos + "]?", "Confirmar")
                        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cLprecos)
                            IF THIS.this_oBusinessObject.Excluir()
                                MsgInfo("Lista exclu" + CHR(237) + "da com sucesso!", "")
                                THIS.CarregarLista()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir:" + CHR(13) + loException.Message, "FormLpr.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Recarrega a lista (equivalente a bnt_Busca do legado)
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.CarregarLista()
        CATCH TO loException
            MsgErro("Erro ao buscar:" + CHR(13) + loException.Message, "FormLpr.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MsgErro("Erro ao encerrar:" + CHR(13) + loException.Message, "FormLpr.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAtualizarClick - Publica a lista selecionada no sistema (flags=1)
    * Avisa se lista ja foi publicada e pede confirmacao antes de repetir
    *==========================================================================
    PROCEDURE BtnAtualizarClick()
        LOCAL loc_cLprecos, loc_nFlags, loc_lOk, loc_lProsseguir
        loc_cLprecos    = ""
        loc_nFlags      = 0
        loc_lOk         = .F.
        loc_lProsseguir = .T.

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 AND ;
               !EOF("cursor_4c_Dados") AND !BOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cLprecos = ALLTRIM(cursor_4c_Dados.lprecos)
                loc_nFlags   = TratarNulo(cursor_4c_Dados.flags, "N")
                loc_lOk = .T.
            ENDIF

            IF loc_lOk AND !EMPTY(loc_cLprecos)
                IF loc_nFlags = 1
                    loc_lProsseguir = MsgConfirma("Lista j" + CHR(225) + ;
                        " atualizada no sistema." + CHR(13) + ;
                        "Deseja atualizar novamente?", "Confirmar")
                ENDIF

                IF loc_lProsseguir
                    IF THIS.this_oBusinessObject.AtualizarFlags(loc_cLprecos)
                        MsgInfo("Lista [" + loc_cLprecos + "] atualizada com sucesso!", "")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Selecione uma lista de pre" + CHR(231) + "os!", "Aviso")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar flags:" + CHR(13) + loException.Message, "FormLpr.BtnAtualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnImprimirListaClick - Exibe ou oculta o painel de impressao (toggle)
    *==========================================================================
    PROCEDURE BtnImprimirListaClick()
        TRY
            WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista
                .Visible = !.Visible
                .Visible     = .T.
            ENDWITH
        CATCH TO loException
            MsgErro("Erro ao exibir impressao:" + CHR(13) + loException.Message, "FormLpr.BtnImprimirListaClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FiltroVencimentoChanged - Recarrega lista ao alterar o filtro de vencimento
    *==========================================================================
    PROCEDURE FiltroVencimentoChanged()
        TRY
            THIS.CarregarLista()
        CATCH TO loException
            MsgErro("Erro ao filtrar:" + CHR(13) + loException.Message, "FormLpr.FiltroVencimentoChanged")
        ENDTRY
    ENDPROC

    *==========================================================================
    * MontarRelatorio - Monta cursor_4c_Relatorio para impressao de listas
    * par_nTipo: 1=Vendas, 2=Compras, 3=Analise, 4=Embalagem
    * Retorna .T. se cursor montado com dados
    *==========================================================================
    PROTECTED FUNCTION MontarRelatorio(par_nTipo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cFiltroTipo
        loc_lSucesso    = .F.
        loc_cFiltroTipo = ""

        TRY
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF

            DO CASE
                CASE par_nTipo = 1
                    loc_cFiltroTipo = " AND b.tipos = ' '"
                CASE par_nTipo = 2
                    loc_cFiltroTipo = " AND b.tipos = 'C'"
                OTHERWISE
                    loc_cFiltroTipo = ""
            ENDCASE

            loc_cSQL = "SELECT b.lprecos, b.fpags, b.vencis AS vencis_lista," + ;
                       " b.flags, b.tipos," + ;
                       " a.cpros, a.dpros, a.pvens, a.pcuss, a.moevs," + ;
                       " a.comiss, a.vencis AS vencis_item, a.vencfs," + ;
                       " a.cgrus, a.ean13, a.reffs, a.ordems, a.precode" + ;
                       " FROM SigCdLpi a" + ;
                       " INNER JOIN SigCdLpc b ON a.lprecos = b.lprecos" + ;
                       " WHERE b.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       loc_cFiltroTipo + ;
                       " ORDER BY b.lprecos, a.ordems, a.cpros"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Relatorio")
            IF loc_nResult >= 0
                GO TOP IN cursor_4c_Relatorio
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao montar relat" + CHR(243) + "rio:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao montar relat" + CHR(243) + "rio:" + CHR(13) + ;
                    loException.Message, "FormLpr.MontarRelatorio")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BtnImpVideoClick - Visualiza relatorio de listas em video (PREVIEW)
    *==========================================================================
    PROCEDURE BtnImpVideoClick()
        LOCAL loc_nTipo
        loc_nTipo = 1

        TRY
            loc_nTipo = THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.opt_4c_TipoImp.Value
            IF THIS.MontarRelatorio(loc_nTipo)
                THIS.ExecutarReportForm("SigCdLpr", "PREVIEW", "cursor_4c_Relatorio")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao visualizar relat" + CHR(243) + "rio:" + CHR(13) + ;
                    loException.Message, "FormLpr.BtnImpVideoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnImpImpressoraClick - Imprime relatorio de listas na impressora
    *==========================================================================
    PROCEDURE BtnImpImpressoraClick()
        LOCAL loc_nTipo
        loc_nTipo = 1

        TRY
            loc_nTipo = THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.opt_4c_TipoImp.Value
            IF THIS.MontarRelatorio(loc_nTipo)
                THIS.ExecutarReportForm("SigCdLpr", "PRINTER_PROMPT", "cursor_4c_Relatorio")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao imprimir relat" + CHR(243) + "rio:" + CHR(13) + ;
                    loException.Message, "FormLpr.BtnImpImpressoraClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnImpExcelClick - Exporta relatorio de listas para Excel (XLS)
    *==========================================================================
    PROCEDURE BtnImpExcelClick()
        LOCAL loc_nTipo, loc_cArquivo
        loc_nTipo    = 1
        loc_cArquivo = ""

        TRY
            loc_nTipo    = THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.opt_4c_TipoImp.Value
            loc_cArquivo = gc_4c_CaminhoReports + "SigCdLpr.xls"

            IF THIS.MontarRelatorio(loc_nTipo)
                IF USED("cursor_4c_Relatorio")
                    SELECT cursor_4c_Relatorio
                    COPY TO (loc_cArquivo) TYPE XL5
                    MsgInfo("Arquivo exportado:" + CHR(13) + loc_cArquivo, "")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao exportar Excel:" + CHR(13) + loException.Message, "FormLpr.BtnImpExcelClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnImpFecharClick - Oculta o painel de impressao cnt_4c_ImpLista
    *==========================================================================
    PROCEDURE BtnImpFecharClick()
        TRY
            THIS.pgf_4c_Paginas.Page1.cnt_4c_ImpLista.Visible = .F.
        CATCH TO loException
            MsgErro("Erro ao fechar painel:" + CHR(13) + loException.Message, "FormLpr.BtnImpFecharClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarTabd - LostFocus do txt_4c_Tabd (Tabela de Desconto)
    * Lookup em SigOpTdz por codigos
    *==========================================================================
    PROCEDURE ValidarTabd(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_cTabd, loc_nResult
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cTabd = ALLTRIM(loc_oPg2.txt_4c_Tabd.Value)

        IF EMPTY(loc_cTabd)
            RETURN
        ENDIF

        TRY
            LOCAL loc_cSQL
            loc_cSQL = "SELECT TOP 1 codigos, descrs FROM SigOpTdz WHERE codigos = " + EscaparSQL(loc_cTabd)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaTabd")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaTabd") = 0
                IF USED("cursor_4c_BuscaTabd")
                    USE IN cursor_4c_BuscaTabd
                ENDIF
                THIS.AbrirBuscaTabd()
            ELSE
                IF USED("cursor_4c_BuscaTabd")
                    USE IN cursor_4c_BuscaTabd
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.ValidarTabd")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaTabd - Abre FormBuscaAuxiliar para selecionar Tabela de Desconto
    *==========================================================================
    PROCEDURE AbrirBuscaTabd()
        LOCAL loc_oPg2, loc_oBusca, loc_cTabd
        loc_oPg2  = THIS.pgf_4c_Paginas.Page2
        loc_cTabd = ALLTRIM(loc_oPg2.txt_4c_Tabd.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigOpTdz", "cursor_4c_BuscaTabd", "codigos", loc_cTabd, ;
                "Tabelas de Desconto")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descrs",  "",           "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabd")
                    SELECT cursor_4c_BuscaTabd
                    loc_oPg2.txt_4c_Tabd.Value = ALLTRIM(cursor_4c_BuscaTabd.codigos)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oPg2.txt_4c_Tabd.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTabd")
                USE IN cursor_4c_BuscaTabd
            ENDIF

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaTabd")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TeclaTabd - KeyPress do txt_4c_Tabd
    * F4/F5: abre lookup. ENTER/TAB: valida.
    *==========================================================================
    PROCEDURE TeclaTabd(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaTabd()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarTabd()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarGetConta - LostFocus do txt_4c_GetConta (Fornecedor, modo compra)
    * Lookup em SigCdCli por iclis; preenche txt_4c_GetDconta automaticamente
    *==========================================================================
    PROCEDURE ValidarGetConta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_oCnt, loc_cConta, loc_nResult
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_oCnt   = loc_oPg2.cnt_4c_Compra
        loc_cConta = ALLTRIM(loc_oCnt.txt_4c_GetConta.Value)

        IF EMPTY(loc_cConta)
            loc_oCnt.txt_4c_GetDconta.Value = ""
            RETURN
        ENDIF

        TRY
            LOCAL loc_cSQL
            loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cConta)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaForns")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_BuscaForns") > 0
                SELECT cursor_4c_BuscaForns
                loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
            ELSE
                IF USED("cursor_4c_BuscaForns")
                    USE IN cursor_4c_BuscaForns
                ENDIF
                THIS.AbrirBuscaGetConta()
            ENDIF
            IF USED("cursor_4c_BuscaForns")
                USE IN cursor_4c_BuscaForns
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.ValidarGetConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaGetConta - Abre FormBuscaAuxiliar para selecionar Fornecedor
    * (modo compra - campo GetConta de cnt_4c_Compra)
    *==========================================================================
    PROCEDURE AbrirBuscaGetConta()
        LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_cConta
        loc_oPg2   = THIS.pgf_4c_Paginas.Page2
        loc_oCnt   = loc_oPg2.cnt_4c_Compra
        loc_cConta = ALLTRIM(loc_oCnt.txt_4c_GetConta.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaForns", "iclis", loc_cConta, ;
                "Fornecedor")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("iclis", "XXXXXXXXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("rclis", "",                    "Raz" + CHR(227) + "o Social")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaForns")
                    SELECT cursor_4c_BuscaForns
                    loc_oCnt.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaForns.iclis)
                    loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oCnt.txt_4c_GetConta.Value  = ""
                        loc_oCnt.txt_4c_GetDconta.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaForns")
                USE IN cursor_4c_BuscaForns
            ENDIF

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaGetConta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TeclaGetConta - KeyPress do txt_4c_GetConta (Fornecedor modo compra)
    * F4/F5: abre lookup. ENTER/TAB: valida.
    *==========================================================================
    PROCEDURE TeclaGetConta(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirBuscaGetConta()
        ELSE
            IF INLIST(par_nKeyCode, 13, 9)
            THIS.ValidarGetConta()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarGetDconta - LostFocus do txt_4c_GetDconta (Descricao Fornecedor)
    * Ativo apenas quando txt_4c_GetConta estiver vazio (busca por nome)
    *==========================================================================
    PROCEDURE ValidarGetDconta(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_oCnt
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oCnt = loc_oPg2.cnt_4c_Compra

        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_GetConta.Value))
            RETURN
        ENDIF

        IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_GetDconta.Value))
            RETURN
        ENDIF

        TRY
            THIS.AbrirBuscaGetDconta()
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.ValidarGetDconta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirBuscaGetDconta - Abre FormBuscaAuxiliar para Fornecedor por descricao
    *==========================================================================
    PROCEDURE AbrirBuscaGetDconta()
        LOCAL loc_oPg2, loc_oCnt, loc_oBusca, loc_cDconta
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_oCnt    = loc_oPg2.cnt_4c_Compra
        loc_cDconta = ALLTRIM(loc_oCnt.txt_4c_GetDconta.Value)

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaForns", "rclis", loc_cDconta, ;
                "Fornecedor")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("rclis", "",                    "Raz" + CHR(227) + "o Social")
                    loc_oBusca.mAddColuna("iclis", "XXXXXXXXXXXXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaForns")
                    SELECT cursor_4c_BuscaForns
                    loc_oCnt.txt_4c_GetConta.Value  = ALLTRIM(cursor_4c_BuscaForns.iclis)
                    loc_oCnt.txt_4c_GetDconta.Value = ALLTRIM(cursor_4c_BuscaForns.rclis)
                ELSE
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oCnt.txt_4c_GetDconta.Value = ""
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaForns")
                USE IN cursor_4c_BuscaForns
            ENDIF

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.AbrirBuscaGetDconta")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TeclaGetDconta - KeyPress do txt_4c_GetDconta (Descricao Fornecedor)
    * F4/F5/ENTER/TAB: abre lookup por nome.
    *==========================================================================
    PROCEDURE TeclaGetDconta(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116, 13, 9)
            THIS.AbrirBuscaGetDconta()
        ENDIF
    ENDPROC

    *==========================================================================
    * ExecutarReportForm - Helper canonico para REPORT FORM com locale isolado
    * par_cRelatorioBase: nome-base do FRX (sem path, sem .frx)
    * par_cModo        : "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    * par_cCursorDados : alias do cursor consumido pelo FRX (guard vazio)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF !FILE(loc_cFRX)
            MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                CHR(13) + loc_cFRX, "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
        ENDTRY

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            *-- Restaurar decimais originais
            IF THIS.this_nOldCasas > 0
                SET DECIMALS TO (THIS.this_nOldCasas)
            ENDIF

            *-- Liberar Business Object
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            *-- Fechar cursores de trabalho
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF
            IF USED("cursor_4c_ItensCopia")
                USE IN cursor_4c_ItensCopia
            ENDIF
            IF USED("cursor_4c_BuscaProd")
                USE IN cursor_4c_BuscaProd
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            IF USED("cursor_4c_BuscaFpg")
                USE IN cursor_4c_BuscaFpg
            ENDIF
            IF USED("cursor_4c_BuscaTabd")
                USE IN cursor_4c_BuscaTabd
            ENDIF
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF

        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "FormLpr.Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\LprBO.prg):
*------------------------------------------------------------------------------
* LprBO.prg - Business Object para Listas de Precificacao
* Tabela principal: SigCdLpc (cabecalho da lista)
* Tabela detalhe  : SigCdLpi (itens da lista)
* Herda de        : BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS LprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades SigCdLpc - campo a campo conforme schema.sql
    *--------------------------------------------------------------------------
    this_cLprecos    = ""    && c(30) PK  - codigo da lista de precos
    this_cFpags      = ""    && c(12)     - condicao de pagamento (FK SigOpFp)
    this_nFormulas   = 0     && n(1,0)    - tipo formula de calculo
    this_nComiss     = 0     && n(1,0)    - tipo calculo comissao
    this_nNvencs     = 0     && n(1,0)    - tipo vencimento
    this_cContas     = ""    && c(10)     - conta (modo compra: fornecedor)
    this_lFlags      = .F.   && bit       - ja atualizada no sistema
    this_cTipos      = ""    && c(1)      - tipo: "C"=compra, " "=venda
    this_dVencis     = {}    && datetime  - data vencimento inicial
    this_nAplictabds = 0     && n(1,0)    - aplica tabela de desconto
    this_cCidchaves  = ""    && c(20)     - chave unica
    this_nDescos     = 0     && n(5,2)    - percentual de desconto
    this_cTabds      = ""    && c(10)     - codigo tabela desconto (FK SigOpTdz)
    this_nCodigos    = 0     && n(6,0)    - codigo sequencial (gerado por fGerUniqueKey)
    this_cEmps       = ""    && c(3)      - empresa (FK SigCdEmp)
    this_nNqtdes     = 0     && n(5,0)    - quantidade minima

    *--------------------------------------------------------------------------
    * Propriedades auxiliares - descricoes (nao persistidas no banco)
    *--------------------------------------------------------------------------
    this_cDfpags     = ""    && descricao da condicao de pagamento
    this_cDtabds     = ""    && descricao da tabela de desconto
    this_cDemps      = ""    && razao social da empresa
    this_cDcontas    = ""    && descricao da conta (modo compra)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdLpc"
        THIS.this_cCampoChave = "lprecos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cLprecos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista cabecalhos SigCdLpc filtrados por empresa e tipo
    * par_cFiltro: "C"=compra, " "=venda (vazio = venda)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cTipos
        loc_lSucesso = .F.

        TRY
            loc_cTipos = IIF(VARTYPE(par_cFiltro) = "C" AND ALLTRIM(par_cFiltro) = "C", "C", " ")

            loc_cSQL = "SELECT DISTINCT a.lprecos, a.fpags, a.formulas, a.ncomiss," + ;
                       " a.nvencs, a.contas, a.flags, a.tipos, a.vencis," + ;
                       " a.aplictabds, a.cidchaves, a.descos, a.tabds," + ;
                       " a.codigos, a.emps, a.nqtdes" + ;
                       " FROM SigCdLpc a" + ;
                       " INNER JOIN SigCdLpi b ON a.lprecos = b.lprecos" + ;
                       " WHERE a.Tipos = " + EscaparSQL(loc_cTipos) + ;
                       " AND a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " ORDER BY a.lprecos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar listas de precifica" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar listas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um SigCdLpc pela PK lprecos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cLprecos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.lprecos, a.fpags, a.formulas, a.ncomiss," + ;
                       " a.nvencs, a.contas, a.flags, a.tipos, a.vencis," + ;
                       " a.aplictabds, a.cidchaves, a.descos, a.tabds," + ;
                       " a.codigos, a.emps, a.nqtdes" + ;
                       " FROM SigCdLpc a" + ;
                       " WHERE a.lprecos = " + EscaparSQL(par_cLprecos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cLprecos     = TratarNulo(lprecos,     "C")
            THIS.this_cFpags       = TratarNulo(fpags,       "C")
            THIS.this_nFormulas    = TratarNulo(formulas,    "N")
            THIS.this_nComiss      = TratarNulo(ncomiss,     "N")
            THIS.this_nNvencs      = TratarNulo(nvencs,      "N")
            THIS.this_cContas      = TratarNulo(contas,      "C")
            THIS.this_lFlags       = (TratarNulo(flags, "N") = 1)
            THIS.this_cTipos       = TratarNulo(tipos,       "C")
            THIS.this_dVencis      = TratarNulo(vencis,      "D")
            THIS.this_nAplictabds  = TratarNulo(aplictabds,  "N")
            THIS.this_cCidchaves   = TratarNulo(cidchaves,   "C")
            THIS.this_nDescos      = TratarNulo(descos,      "N")
            THIS.this_cTabds       = TratarNulo(tabds,       "C")
            THIS.this_nCodigos     = TratarNulo(codigos,     "N")
            THIS.this_cEmps        = TratarNulo(emps,        "C")
            THIS.this_nNqtdes      = TratarNulo(nqtdes,      "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdLpc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdLpc" + ;
                       " (lprecos, fpags, formulas, ncomiss, nvencs, contas," + ;
                       " flags, tipos, vencis, aplictabds, cidchaves, descos," + ;
                       " tabds, codigos, emps, nqtdes)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cLprecos) + "," + ;
                       EscaparSQL(THIS.this_cFpags) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFormulas) + "," + ;
                       FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNvencs) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       IIF(THIS.this_lFlags, "1", "0") + "," + ;
                       EscaparSQL(THIS.this_cTipos) + "," + ;
                       FormatarDataSQL(THIS.this_dVencis) + "," + ;
                       FormatarNumeroSQL(THIS.this_nAplictabds) + "," + ;
                       EscaparSQL(THIS.this_cCidchaves) + "," + ;
                       FormatarNumeroSQL(THIS.this_nDescos) + "," + ;
                       EscaparSQL(THIS.this_cTabds) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNqtdes) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdLpc (lprecos eh PK, nao alterar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLpc SET" + ;
                       " fpags = " + EscaparSQL(THIS.this_cFpags) + "," + ;
                       " formulas = " + FormatarNumeroSQL(THIS.this_nFormulas) + "," + ;
                       " ncomiss = " + FormatarNumeroSQL(THIS.this_nComiss) + "," + ;
                       " nvencs = " + FormatarNumeroSQL(THIS.this_nNvencs) + "," + ;
                       " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " flags = " + IIF(THIS.this_lFlags, "1", "0") + "," + ;
                       " tipos = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                       " vencis = " + FormatarDataSQL(THIS.this_dVencis) + "," + ;
                       " aplictabds = " + FormatarNumeroSQL(THIS.this_nAplictabds) + "," + ;
                       " descos = " + FormatarNumeroSQL(THIS.this_nDescos) + "," + ;
                       " tabds = " + EscaparSQL(THIS.this_cTabds) + "," + ;
                       " codigos = " + FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                       " emps = " + EscaparSQL(THIS.this_cEmps) + "," + ;
                       " nqtdes = " + FormatarNumeroSQL(THIS.this_nNqtdes) + ;
                       " WHERE lprecos = " + EscaparSQL(THIS.this_cLprecos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdLpi (itens) e SigCdLpc (cabecalho)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens primeiro (FK)
            loc_cSQL = "DELETE FROM SigCdLpi WHERE lprecos = " + ;
                       EscaparSQL(THIS.this_cLprecos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM SigCdLpc WHERE lprecos = " + ;
                           EscaparSQL(THIS.this_cLprecos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir lista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega SigCdLpi de uma lista no cursor_4c_Itens
    * par_cLprecos: codigo da lista de precos
    * par_cTipos  : "C"=compra, " "=venda (determina colunas do grid)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens(par_cLprecos, par_cTipos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cLprecos))
            RETURN .F.
        ENDIF

        TRY

            IF VARTYPE(par_cTipos) != "C"
                par_cTipos = " "
            ENDIF

            IF ALLTRIM(par_cTipos) = "C"
                *-- Modo compra: colunas cpros, dpros, reffs, ean13, pcuss, moevs + custo novo
                loc_cSQL = "SELECT a.cidchaves, a.lprecos, a.cpros, a.dpros," + ;
                           " a.reffs, a.ean13, a.pcuss, a.moevs," + ;
                           " a.pvens, a.vencis, a.vencfs, a.comiss," + ;
                           " a.cgrus, a.flagutabs, a.ordems, a.ccontroles, a.precode" + ;
                           " FROM SigCdLpi a" + ;
                           " WHERE a.lprecos = " + EscaparSQL(par_cLprecos) + ;
                           " ORDER BY a.cpros"
            ELSE
                *-- Modo venda: colunas cpros, dpros, pvens, moevs, comiss, vencis, vencfs
                loc_cSQL = "SELECT a.cidchaves, a.lprecos, a.cpros, a.dpros," + ;
                           " a.pvens, a.moevs, a.comiss, a.vencis, a.vencfs," + ;
                           " a.cgrus, a.flagutabs, a.ordems, a.ccontroles," + ;
                           " a.ean13, a.pcuss, a.reffs, a.precode" + ;
                           " FROM SigCdLpi a" + ;
                           " WHERE a.lprecos = " + EscaparSQL(par_cLprecos) + ;
                           " ORDER BY a.cpros"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")
            IF loc_nResultado >= 0
                GO TOP IN cursor_4c_Itens
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarItens - Persiste cursor_4c_Itens no SQL Server via DELETE+INSERT
    * par_cLprecos: codigo da lista de precos
    * Estrategia: DELETE todos do lprecos + INSERT dos nao-deletados do cursor
    *--------------------------------------------------------------------------
    PROCEDURE SalvarItens(par_cLprecos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lErroItem
        LOCAL loc_cCidchave, loc_cCpros, loc_cDpros, loc_cMoevs
        LOCAL loc_nPvens, loc_nComiss, loc_dVencis, loc_dVencfs
        LOCAL loc_cCgrus, loc_cReffs, loc_nEan13, loc_nPcuss
        LOCAL loc_nPrecode, loc_nOrdems
        loc_lSucesso = .F.
        loc_lErroItem = .F.

        IF !USED("cursor_4c_Itens")
            RETURN .F.
        ENDIF

        TRY
            *-- Excluir todos os itens existentes para este lprecos
            loc_cSQL = "DELETE FROM SigCdLpi WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao limpar itens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Inserir todos os itens nao-deletados do cursor
                SELECT cursor_4c_Itens
                GO TOP
                DO WHILE !EOF("cursor_4c_Itens") AND !loc_lErroItem
                    IF !DELETED("cursor_4c_Itens")
                        loc_cCpros   = ALLTRIM(TratarNulo(cpros,  "C"))
                        loc_cDpros   = ALLTRIM(TratarNulo(dpros,  "C"))
                        loc_cMoevs   = ALLTRIM(TratarNulo(moevs,  "C"))
                        loc_nPvens   = TratarNulo(pvens,   "N")
                        loc_nComiss  = TratarNulo(comiss,  "N")
                        loc_dVencis  = TratarNulo(vencis,  "D")
                        loc_dVencfs  = TratarNulo(vencfs,  "D")
                        loc_cCgrus   = ALLTRIM(TratarNulo(cgrus,  "C"))
                        loc_cReffs   = ALLTRIM(TratarNulo(reffs,  "C"))
                        loc_nEan13   = TratarNulo(ean13,   "N")
                        loc_nPcuss   = TratarNulo(pcuss,   "N")
                        loc_nPrecode = TratarNulo(precode, "N")
                        loc_nOrdems  = TratarNulo(ordems, "N")

                        *-- Gerar cidchaves unico se vazio
                        loc_cCidchave = ALLTRIM(TratarNulo(cidchaves, "C"))
                        IF EMPTY(loc_cCidchave)
                            loc_cCidchave = THIS.GerarCidchave()
                        ENDIF

                        IF !EMPTY(loc_cCpros)
                            loc_cSQL = "INSERT INTO SigCdLpi" + ;
                                       " (cidchaves, lprecos, cpros, dpros, moevs," + ;
                                       " pvens, comiss, vencis, vencfs, cgrus," + ;
                                       " reffs, ean13, pcuss, precode, ordems," + ;
                                       " flagutabs, ccontroles)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cCidchave) + "," + ;
                                       EscaparSQL(par_cLprecos) + "," + ;
                                       EscaparSQL(loc_cCpros) + "," + ;
                                       EscaparSQL(loc_cDpros) + "," + ;
                                       EscaparSQL(loc_cMoevs) + "," + ;
                                       FormatarNumeroSQL(loc_nPvens) + "," + ;
                                       FormatarNumeroSQL(loc_nComiss) + "," + ;
                                       FormatarDataSQL(loc_dVencis) + "," + ;
                                       FormatarDataSQL(loc_dVencfs) + "," + ;
                                       EscaparSQL(loc_cCgrus) + "," + ;
                                       EscaparSQL(loc_cReffs) + "," + ;
                                       FormatarNumeroSQL(loc_nEan13) + "," + ;
                                       FormatarNumeroSQL(loc_nPcuss) + "," + ;
                                       FormatarNumeroSQL(loc_nPrecode) + "," + ;
                                       FormatarNumeroSQL(loc_nOrdems) + "," + ;
                                       "0,'')"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao inserir item [" + loc_cCpros + "]:" + ;
                                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lErroItem = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_Itens
                    SKIP
                ENDDO

                IF !loc_lErroItem
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar itens:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCidchave - Gera chave unica para SigCdLpi.cidchaves (char 20)
    * Formato: emps(3) + lprecos(8) + cpros(5) + seq(4)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarCidchave()
        LOCAL loc_cChave, loc_nSeq, loc_cSQL, loc_nResult
        loc_nSeq = 0

        TRY
            loc_cSQL = "SELECT COUNT(1) AS nTotal FROM SigCdLpi" + ;
                       " WHERE lprecos = " + EscaparSQL(THIS.this_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Seq")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Seq")
                loc_nSeq = TratarNulo(cursor_4c_Seq.nTotal, "N")
            ENDIF
            IF USED("cursor_4c_Seq")
                USE IN cursor_4c_Seq
            ENDIF
        CATCH TO loc_oErro
            *-- ignorar, loc_nSeq = 0
        ENDTRY

        loc_cChave = PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3) + ;
                     PADR(LEFT(ALLTRIM(THIS.this_cLprecos), 8), 8) + ;
                     TRANSFORM(DATETIME(), "YYYYMMDDHHMMSS")
        loc_cChave = LEFT(ALLTRIM(loc_cChave) + TRANSFORM(loc_nSeq), 20)

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * ChecaGrpVenda - Verifica se produto pertence a grupo permitido para venda
    * Consulta SigCdPam.GrPadFors para obter grupo padrao e valida no produto
    * Retorna .T. se pode alterar preco, .F. se grupo bloqueado
    *--------------------------------------------------------------------------
    PROCEDURE ChecaGrpVenda(par_cCpros)
        LOCAL loc_cSQL, loc_nResult, loc_lPode, loc_cGrPadFors, loc_cCgrus
        loc_lPode = .T.

        TRY
            *-- Ler grupo padrao de fornecedores em SigCdPam
            loc_cSQL = "SELECT GrPadFors FROM SigCdPam"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
            IF loc_nResult >= 0 AND !EOF("cursor_4c_Pam") AND !EMPTY(ALLTRIM(cursor_4c_Pam.GrPadFors))
                loc_cGrPadFors = ALLTRIM(cursor_4c_Pam.GrPadFors)
            ELSE
                loc_cGrPadFors = ""
            ENDIF
            IF USED("cursor_4c_Pam")
                USE IN cursor_4c_Pam
            ENDIF

            IF EMPTY(loc_cGrPadFors) OR EMPTY(ALLTRIM(par_cCpros))
                loc_lPode = .T.
            ELSE
                *-- Verificar grupo do produto
                loc_cSQL = "SELECT cgrus FROM SigCdPro WHERE cpros = " + EscaparSQL(par_cCpros)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pro")
                IF loc_nResult >= 0 AND !EOF("cursor_4c_Pro")
                    loc_cCgrus = ALLTRIM(cursor_4c_Pro.cgrus)
                    IF loc_cCgrus = loc_cGrPadFors
                        MsgAviso("Produto do grupo " + loc_cGrPadFors + " n" + CHR(227) + "o pode ter pre" + ;
                                 CHR(231) + "o alterado nesta lista!", "Aviso")
                        loc_lPode = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Pro")
                    USE IN cursor_4c_Pro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lPode
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarFlags - Marca SigCdLpc.flags=1 (lista atualizada no sistema)
    * e persiste os itens de SigCdLpi via SalvarItens
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarFlags(par_cLprecos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLpc SET flags = 1" + ;
                       " WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.this_lFlags = .T.
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar flags:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar flags:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AlterarVencimentos - Altera vencfs de todos os itens de uma lista
    * Equivalente ao cmdSalva do cntVencimentos no legado
    *--------------------------------------------------------------------------
    PROCEDURE AlterarVencimentos(par_cLprecos, par_dVencfs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(par_dVencfs)
            MsgErro("Data de vencimento inv" + CHR(225) + "lida!", "Aviso")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdLpi SET vencfs = " + FormatarDataSQL(par_dVencfs) + ;
                       " WHERE lprecos = " + EscaparSQL(par_cLprecos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
                MsgInfo("Vencimentos alterados para " + DTOC(par_dVencfs) + "!", "")
            ELSE
                MsgErro("Erro ao alterar vencimentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao alterar vencimentos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

