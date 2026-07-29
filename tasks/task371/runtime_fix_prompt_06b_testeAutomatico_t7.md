# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 7/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc); Teste 'ModoIncluir': Property ALTERNARPAGINA is not found. | Detalhes: Linha: 412; Teste 'ModoVisualizar': Property AJUSTARBOTOESPORMODO is not found. | Detalhes: Linha: 542

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-29 01:19:16] [INFO] Config FPW: (nao fornecido)
[2026-07-29 01:19:16] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 01:19:16] [INFO] Timeout: 300 segundos
[2026-07-29 01:19:16] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uvv5fy0f.prg
[2026-07-29 01:19:16] [INFO] Conteudo do wrapper:
[2026-07-29 01:19:16] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormClf', 'C:\4c\tasks\task371', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
QUIT

[2026-07-29 01:19:16] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uvv5fy0f.prg
[2026-07-29 01:19:16] [INFO] VFP output esperado em: C:\4c\tasks\task371\vfp_output.txt
[2026-07-29 01:19:16] [INFO] Executando Visual FoxPro 9...
[2026-07-29 01:19:16] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uvv5fy0f.prg
[2026-07-29 01:19:16] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uvv5fy0f.prg
[2026-07-29 01:19:16] [INFO] Timeout configurado: 300 segundos
[2026-07-29 01:20:01] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 01:20:01] [INFO] VFP9 finalizado em 44.91732 segundos
[2026-07-29 01:20:01] [INFO] Exit Code: 
[2026-07-29 01:20:01] [INFO] 
[2026-07-29 01:20:01] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 01:20:01] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uvv5fy0f.prg
[2026-07-29 01:20:01] [INFO] 
[2026-07-29 01:20:01] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 01:20:01] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 01:20:01] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 01:20:01] [INFO] * Parameters: 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
[2026-07-29 01:20:01] [INFO] 
[2026-07-29 01:20:01] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 01:20:01] [INFO] SET SAFETY OFF
[2026-07-29 01:20:01] [INFO] SET RESOURCE OFF
[2026-07-29 01:20:01] [INFO] SET TALK OFF
[2026-07-29 01:20:01] [INFO] SET NOTIFY OFF
[2026-07-29 01:20:01] [INFO] SYS(2335, 0)
[2026-07-29 01:20:01] [INFO] 
[2026-07-29 01:20:01] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
[2026-07-29 01:20:01] [INFO] QUIT
[2026-07-29 01:20:01] [INFO] 
[2026-07-29 01:20:01] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 01:20:01] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-29 01:26:47] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-29 01:26:47] [INFO] Config FPW: (nao fornecido)
[2026-07-29 01:26:47] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 01:26:47] [INFO] Timeout: 300 segundos
[2026-07-29 01:26:47] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_25m4hbfv.prg
[2026-07-29 01:26:47] [INFO] Conteudo do wrapper:
[2026-07-29 01:26:47] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormClf', 'C:\4c\tasks\task371', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
QUIT

[2026-07-29 01:26:47] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_25m4hbfv.prg
[2026-07-29 01:26:47] [INFO] VFP output esperado em: C:\4c\tasks\task371\vfp_output.txt
[2026-07-29 01:26:47] [INFO] Executando Visual FoxPro 9...
[2026-07-29 01:26:47] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_25m4hbfv.prg
[2026-07-29 01:26:47] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_25m4hbfv.prg
[2026-07-29 01:26:47] [INFO] Timeout configurado: 300 segundos
[2026-07-29 01:27:32] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 01:27:32] [INFO] VFP9 finalizado em 45.0863316 segundos
[2026-07-29 01:27:32] [INFO] Exit Code: 
[2026-07-29 01:27:32] [INFO] 
[2026-07-29 01:27:32] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 01:27:32] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_25m4hbfv.prg
[2026-07-29 01:27:32] [INFO] 
[2026-07-29 01:27:32] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 01:27:32] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 01:27:32] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 01:27:32] [INFO] * Parameters: 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
[2026-07-29 01:27:32] [INFO] 
[2026-07-29 01:27:32] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 01:27:32] [INFO] SET SAFETY OFF
[2026-07-29 01:27:32] [INFO] SET RESOURCE OFF
[2026-07-29 01:27:32] [INFO] SET TALK OFF
[2026-07-29 01:27:32] [INFO] SET NOTIFY OFF
[2026-07-29 01:27:32] [INFO] SYS(2335, 0)
[2026-07-29 01:27:32] [INFO] 
[2026-07-29 01:27:32] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
[2026-07-29 01:27:32] [INFO] QUIT
[2026-07-29 01:27:32] [INFO] 
[2026-07-29 01:27:32] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 01:27:32] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-29 01:34:43] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-29 01:34:43] [INFO] Config FPW: (nao fornecido)
[2026-07-29 01:34:43] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 01:34:43] [INFO] Timeout: 300 segundos
[2026-07-29 01:34:43] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ob5jf03d.prg
[2026-07-29 01:34:43] [INFO] Conteudo do wrapper:
[2026-07-29 01:34:43] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormClf', 'C:\4c\tasks\task371', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
QUIT

[2026-07-29 01:34:43] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ob5jf03d.prg
[2026-07-29 01:34:43] [INFO] VFP output esperado em: C:\4c\tasks\task371\vfp_output.txt
[2026-07-29 01:34:43] [INFO] Executando Visual FoxPro 9...
[2026-07-29 01:34:43] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ob5jf03d.prg
[2026-07-29 01:34:43] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ob5jf03d.prg
[2026-07-29 01:34:43] [INFO] Timeout configurado: 300 segundos
[2026-07-29 01:35:28] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 01:35:28] [INFO] VFP9 finalizado em 45.0763986 segundos
[2026-07-29 01:35:28] [INFO] Exit Code: 
[2026-07-29 01:35:28] [INFO] 
[2026-07-29 01:35:28] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 01:35:28] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ob5jf03d.prg
[2026-07-29 01:35:28] [INFO] 
[2026-07-29 01:35:28] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 01:35:28] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 01:35:28] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 01:35:28] [INFO] * Parameters: 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
[2026-07-29 01:35:28] [INFO] 
[2026-07-29 01:35:28] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 01:35:28] [INFO] SET SAFETY OFF
[2026-07-29 01:35:28] [INFO] SET RESOURCE OFF
[2026-07-29 01:35:28] [INFO] SET TALK OFF
[2026-07-29 01:35:28] [INFO] SET NOTIFY OFF
[2026-07-29 01:35:28] [INFO] SYS(2335, 0)
[2026-07-29 01:35:28] [INFO] 
[2026-07-29 01:35:28] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
[2026-07-29 01:35:28] [INFO] QUIT
[2026-07-29 01:35:28] [INFO] 
[2026-07-29 01:35:28] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 01:35:28] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-29 01:38:24] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-29 01:38:24] [INFO] Config FPW: (nao fornecido)
[2026-07-29 01:38:24] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 01:38:24] [INFO] Timeout: 300 segundos
[2026-07-29 01:38:24] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y5fspujh.prg
[2026-07-29 01:38:24] [INFO] Conteudo do wrapper:
[2026-07-29 01:38:24] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormClf', 'C:\4c\tasks\task371', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
QUIT

[2026-07-29 01:38:24] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y5fspujh.prg
[2026-07-29 01:38:24] [INFO] VFP output esperado em: C:\4c\tasks\task371\vfp_output.txt
[2026-07-29 01:38:24] [INFO] Executando Visual FoxPro 9...
[2026-07-29 01:38:24] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y5fspujh.prg
[2026-07-29 01:38:24] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y5fspujh.prg
[2026-07-29 01:38:24] [INFO] Timeout configurado: 300 segundos
[2026-07-29 01:39:09] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-29 01:39:09] [INFO] VFP9 finalizado em 45.0098952 segundos
[2026-07-29 01:39:09] [INFO] Exit Code: 
[2026-07-29 01:39:09] [INFO] 
[2026-07-29 01:39:09] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-29 01:39:09] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_y5fspujh.prg
[2026-07-29 01:39:09] [INFO] 
[2026-07-29 01:39:09] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-29 01:39:09] [INFO] * Auto-generated wrapper for parameters
[2026-07-29 01:39:09] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-29 01:39:09] [INFO] * Parameters: 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
[2026-07-29 01:39:09] [INFO] 
[2026-07-29 01:39:09] [INFO] * Anti-dialog protections for unattended execution
[2026-07-29 01:39:09] [INFO] SET SAFETY OFF
[2026-07-29 01:39:09] [INFO] SET RESOURCE OFF
[2026-07-29 01:39:09] [INFO] SET TALK OFF
[2026-07-29 01:39:09] [INFO] SET NOTIFY OFF
[2026-07-29 01:39:09] [INFO] SYS(2335, 0)
[2026-07-29 01:39:09] [INFO] 
[2026-07-29 01:39:09] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormClf', 'C:\4c\tasks\task371', 'CRUD'
[2026-07-29 01:39:09] [INFO] QUIT
[2026-07-29 01:39:09] [INFO] 
[2026-07-29 01:39:09] [INFO] === Fim do Wrapper.prg ===
[2026-07-29 01:39:09] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormClf",
  "timestamp": "20260729013909",
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
      "detalhes": "Linha: 412"
    },
    {
      "nome": "ModoVisualizar",
      "passou": false,
      "erro": "Property AJUSTARBOTOESPORMODO is not found.",
      "detalhes": "Linha: 542"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 6 (IVACOL1KEYPRESS, IVACOL2KEYPRESS, IVAGRIDKEYPRESS, KEYPRESS, REDCOL1KEYPRESS, REDGRIDKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormClf.prg):
*==============================================================================
* FormClf.prg - Formulario de Cadastro de Classificacao Fiscal
* Data: 2026-07-28
* Tabela: SIGCDCLF | PK: codigos
* Legado: SIGCDCLF.SCX (frmcadastro)
* Tabelas filhas: sigcdiva (IVAs por estado), sigcdred (Reducoes por estado)
*==============================================================================

DEFINE CLASS FormClf AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 600
    Width        = 1000
    Caption      = "Cadastro de Classificacao Fiscal"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""    && OBRIGATORIO - nao herdado de FormBase
    this_lTemProduto     = .F.   && .T. se ha produtos com AliqIPI<>0

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
            THIS.this_oBusinessObject = CREATEOBJECT("ClfBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar Business Object ClfBO", "Erro Cr" + CHR(237) + "tico")
                loc_lSucesso = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha ao carregar nao impede abertura
                    ENDIF
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormClf:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura o PageFrame principal
    * Legado: Pagina Width=1003, PageFrame.Top=-29 (oculta abas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 629
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.

            *-- Page1 - Lista
            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            *-- Page2 - Dados
            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao +29 aplicada: Top original 0 -> 29, Top 2 -> 31
    * Colunas lista legado: Codigos(94), Descricaos(290), Aipis(45), Unidades(31), Cest(70)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de cabecalho (cntSombra: Top=2 -> 31)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1020
            .Height      = 80
            .BackColor   = RGB(192, 192, 192)
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Classificacao Fiscal"
            .Top       = 20
            .Left      = 20
            .Width     = 600
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (Grupo_op: Left=542, Top=0 -> 29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 400
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

        *-- Botao Visualizar (Left=80)
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

        *-- Botao Buscar (Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container de saida - canonico (Left=917, Top=29)
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
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de lista (Grade: Top=121, Left=12, Width=940, Height=470)
        *-- Colunas: Codigos(94), Descricaos(290), Aipis(45), Unidades(31), Cest(70)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        WITH loc_oPagina.grd_4c_Lista
            .Top               = 121
            .Left              = 12
            .Width             = 940
            .Height            = 470
            .ReadOnly          = .T.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 3
            .GridLines         = 3
            .AllowHeaderSizing = .T.
            .Visible           = .T.
        ENDWITH

        *-- ColumnCount FORA do WITH para criacao imediata das colunas (Problema 36)
        loc_oPagina.grd_4c_Lista.ColumnCount = 5
        loc_oPagina.grd_4c_Lista.Column1.Width = 94
        loc_oPagina.grd_4c_Lista.Column2.Width = 290
        loc_oPagina.grd_4c_Lista.Column3.Width = 45
        loc_oPagina.grd_4c_Lista.Column4.Width = 31
        loc_oPagina.grd_4c_Lista.Column5.Width = 70

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Compensacao +29 em TODOS os controles (Top_original + 29)
    * Legado: campos em SIGCDCLF.Pagina.Dados.*
    * Nota: Grids filhos (GradIva, GradRed) serao adicionados nas proximas fases
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de botoes de acao (Grupo_Salva: posicao aprox. Right side)
        loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oPagina.cnt_4c_BotoesDados
            .Top         = 38
            .Left        = 819
            .Width       = 165
            .Height      = 85
            .BackStyle = 1
            .BackColor   = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar (Confirmar: Left=7, Top=5)
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 7
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

        *-- Botao Cancelar (Left=82, Top=5)
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Width           = 75
            .Height          = 75
            .Left            = 82
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

        *-- shp_4c_Shape2: fundo decorativo inferior (top=421+29=450)
        loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
        WITH loc_oPagina.shp_4c_Shape2
            .Top           = 450
            .Left          = 54
            .Width         = 912
            .Height        = 38
            .BackStyle     = 0
            .BorderWidth   = 1
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label1: Say1 (Codigo) top=44+29=73
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 73
            .Left      = 223
            .Width     = 42
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Codigo: getCodigo top=39+29=68; InputMask NCM 9999.99.9999
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value         = ""
            .Top           = 68
            .Left          = 268
            .Width         = 94
            .Height        = 25
            .Format        = "R"
            .InputMask     = "9999.99.9999"
            .MaxLength     = 12
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label2: Say2 (Descricao) top=44+29=73
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 73
            .Left      = 387
            .Width     = 55
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Descricao: getDescricao top=39+29=68; Format=! (uppercase)
        loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
        WITH loc_oPagina.txt_4c_Descricao
            .Value         = ""
            .Top           = 68
            .Left          = 443
            .Width         = 290
            .Height        = 25
            .Format        = "!"
            .InputMask     = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
            .MaxLength     = 40
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label4: Say4 (Unidade) top=72+29=101
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Unidade :"
            .Top       = 101
            .Left      = 217
            .Width     = 48
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Unidade: getUnidade top=67+29=96; Format=! (uppercase)
        loc_oPagina.AddObject("txt_4c_Unidade", "TextBox")
        WITH loc_oPagina.txt_4c_Unidade
            .Value         = ""
            .Top           = 96
            .Left          = 268
            .Width         = 31
            .Height        = 25
            .Format        = "!"
            .InputMask     = "XXX"
            .MaxLength     = 3
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label18: Say18 (Subst Trib em SP) top=72+29=101
        loc_oPagina.AddObject("lbl_4c_Label18", "Label")
        WITH loc_oPagina.lbl_4c_Label18
            .Caption   = "Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria em SP por :"
            .Top       = 101
            .Left      = 362
            .Width     = 167
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- opt_4c_Opt_TpSubSt: opt_TpSubSt top=66+29=95
        *-- Value=2 default (Valor Determinado); getIVAST habilitado quando Value=1 (IVA)
        loc_oPagina.AddObject("opt_4c_Opt_TpSubSt", "OptionGroup")
        WITH loc_oPagina.opt_4c_Opt_TpSubSt
            .ButtonCount = 2
            .Top         = 95
            .Left        = 527
            .Width       = 182
            .Height      = 27
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Opt_TpSubSt.Buttons(1)
            .Caption   = "IVA"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPagina.opt_4c_Opt_TpSubSt.Buttons(2)
            .Caption   = "Valor Determinado"
            .Left      = 58
            .Top       = 5
            .AutoSize  = .T.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        BINDEVENT(loc_oPagina.opt_4c_Opt_TpSubSt, "InteractiveChange", THIS, "TpSubStChanged")

        *-- lbl_4c_Label11: Say11 (Tipo da Mercadoria label) top=100+29=129
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = "C" + CHR(243) + "digo do Tipo da Mercadoria :"
            .Top       = 129
            .Left      = 114
            .Width     = 151
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- cbo_4c_CmbTipoMerc: CmbTipoMerc top=95+29=124; itens 01-76 via PopularCmbTipoMerc
        loc_oPagina.AddObject("cbo_4c_CmbTipoMerc", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbTipoMerc
            .Top           = 124
            .Left          = 268
            .Width         = 54
            .Height        = 25
            .Style         = 2
            .SpecialEffect = 1
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        THIS.PopularCmbTipoMerc()
        BINDEVENT(loc_oPagina.cbo_4c_CmbTipoMerc, "InteractiveChange", THIS, "CmbTipoMercChange")

        *-- lbl_4c_Label10: Say10 (IVAST label) top=100+29=129
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "IVA-ST Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria SP :"
            .Top       = 129
            .Left      = 362
            .Width     = 167
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_IVAST: getIVAST top=95+29=124; habilitado somente quando TpSubSt=1 (IVA)
        loc_oPagina.AddObject("txt_4c_IVAST", "TextBox")
        WITH loc_oPagina.txt_4c_IVAST
            .Value         = 0
            .Top           = 124
            .Left          = 533
            .Width         = 70
            .Height        = 25
            .InputMask     = "9999.999"
            .MaxLength     = 8
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_LblTipoMerc: lblTipoMerc - descricao dinamica do tipo de mercadoria
        *-- Aparece sobre shp_4c_Shape2 (top=424+29=453)
        loc_oPagina.AddObject("lbl_4c_LblTipoMerc", "Label")
        WITH loc_oPagina.lbl_4c_LblTipoMerc
            .Caption   = ""
            .Top       = 453
            .Left      = 59
            .Width     = 902
            .Height    = 32
            .AutoSize  = .F.
            .WordWrap  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label5: Say5 (Base Reduzida ICMS) top=128+29=157
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Base Reduzida ICMS :"
            .Top       = 157
            .Left      = 158
            .Width     = 107
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- cbo_4c_Cmbbred: Cmbbred top=123+29=152; base reducao S/N
        loc_oPagina.AddObject("cbo_4c_Cmbbred", "ComboBox")
        WITH loc_oPagina.cbo_4c_Cmbbred
            .Top           = 152
            .Left          = 268
            .Width         = 54
            .Height        = 24
            .Style         = 2
            .SpecialEffect = 1
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- txt_4c_Areduzida: getAreduzida top=123+29=152; BIcms
        loc_oPagina.AddObject("txt_4c_Areduzida", "TextBox")
        WITH loc_oPagina.txt_4c_Areduzida
            .Value         = 0
            .Top           = 152
            .Left          = 533
            .Width         = 45
            .Height        = 25
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_Areduzida, "LostFocus", THIS, "ValidarAreduzida")

        *-- lbl_4c_Label8: Say8 (Aliquota Base Reduzida ICMS) top=128+29=157
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Al" + CHR(237) + "quota Base Reduzida de ICMS :"
            .Top       = 157
            .Left      = 365
            .Width     = 164
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label6: Say6 (Aliquota Reduzida ICMS) top=156+29=185
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Al" + CHR(237) + "quota Reduzida ICMS :"
            .Top       = 185
            .Left      = 142
            .Width     = 123
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- cbo_4c_CmbAred: CmbAred top=151+29=180; aliq reducao S/N
        loc_oPagina.AddObject("cbo_4c_CmbAred", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbAred
            .Top           = 180
            .Left          = 268
            .Width         = 54
            .Height        = 24
            .Style         = 2
            .SpecialEffect = 1
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- txt_4c_AreduzidaS: getAreduzidaS top=151+29=180; BIcmss
        loc_oPagina.AddObject("txt_4c_AreduzidaS", "TextBox")
        WITH loc_oPagina.txt_4c_AreduzidaS
            .Value         = 0
            .Top           = 180
            .Left          = 533
            .Width         = 45
            .Height        = 25
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_AreduzidaS, "LostFocus", THIS, "ValidarAreduzidaS")

        *-- lbl_4c_Label12: Say12 (Aliquota Base Reduzida de Subst) top=156+29=185
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Al" + CHR(237) + "quota Base Reduzida de Subst :"
            .Top       = 185
            .Left      = 363
            .Width     = 166
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label7: Say7 (IPI) top=184+29=213
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "IPI :"
            .Top       = 213
            .Left      = 242
            .Width     = 23
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- cbo_4c_CmbIpi: cmbIpi top=179+29=208; Tributado/Isento/Outros
        loc_oPagina.AddObject("cbo_4c_CmbIpi", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbIpi
            .Top           = 208
            .Left          = 268
            .Width         = 91
            .Height        = 25
            .Style         = 2
            .SpecialEffect = 1
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label3: Say3 (Aliquota IPI) top=184+29=213
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Al" + CHR(237) + "quota IPI :"
            .Top       = 213
            .Left      = 464
            .Width     = 65
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Aipi: getAipi top=179+29=208; aipis 99.99
        loc_oPagina.AddObject("txt_4c_Aipi", "TextBox")
        WITH loc_oPagina.txt_4c_Aipi
            .Value         = 0
            .Top           = 208
            .Left          = 533
            .Width         = 45
            .Height        = 25
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label9: Say9 (Cadastrar IPI por Produto) top=213+29=242
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = "Cadastrar IPI por Produto :"
            .Top       = 242
            .Left      = 131
            .Width     = 134
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- cbo_4c_CmbIPip: CmbIPip top=208+29=237; S/N
        loc_oPagina.AddObject("cbo_4c_CmbIPip", "ComboBox")
        WITH loc_oPagina.cbo_4c_CmbIPip
            .Top           = 237
            .Left          = 268
            .Width         = 54
            .Height        = 24
            .Style         = 2
            .SpecialEffect = 1
            .RowSourceType = 0
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c__IPI: Say_IPI top=213+29=242; Visible=.F. ate TemProduto=.T.
        loc_oPagina.AddObject("lbl_4c__IPI", "Label")
        WITH loc_oPagina.lbl_4c__IPI
            .Caption   = "Existem Produtos Com Aliquota de IPI"
            .Top       = 242
            .Left      = 326
            .Width     = 250
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(255, 0, 0)
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .T.
            .Visible   = .F.
        ENDWITH

        *-- lbl_4c_Label14: Say14 (Aliquota ICMS para FCP) top=240+29=269
        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = "Al" + CHR(237) + "quota ICMS para FCP :"
            .Top       = 269
            .Left      = 142
            .Width     = 123
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_AliqFcp: getAliqFcp top=235+29=264; 99.99
        loc_oPagina.AddObject("txt_4c_AliqFcp", "TextBox")
        WITH loc_oPagina.txt_4c_AliqFcp
            .Value         = 0
            .Top           = 264
            .Left          = 268
            .Width         = 45
            .Height        = 25
            .InputMask     = "99.99"
            .MaxLength     = 5
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_AliqFcp, "LostFocus", THIS, "ValidarAliqFcp")

        *-- lbl_4c_Label16: Say16 (CEST) top=268+29=297
        loc_oPagina.AddObject("lbl_4c_Label16", "Label")
        WITH loc_oPagina.lbl_4c_Label16
            .Caption   = "CEST :"
            .Top       = 297
            .Left      = 231
            .Width     = 34
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Cest: getCest top=263+29=292; 7 digitos CEST
        loc_oPagina.AddObject("txt_4c_Cest", "TextBox")
        WITH loc_oPagina.txt_4c_Cest
            .Value         = ""
            .Top           = 292
            .Left          = 268
            .Width         = 94
            .Height        = 25
            .InputMask     = "9999999"
            .MaxLength     = 7
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- lbl_4c_Label13: Say13 (IVA-ST para os estados) top=156+29=185
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "IVA-ST para os estados :"
            .Top       = 185
            .Left      = 693
            .Width     = 122
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label15: Say15 (Aliquotas de Reducao para os estados) top=247+29=276
        loc_oPagina.AddObject("lbl_4c_Label15", "Label")
        WITH loc_oPagina.lbl_4c_Label15
            .Caption   = "Aliquotas de Redu" + CHR(231) + CHR(227) + "o para os estados :"
            .Top       = 276
            .Left      = 387
            .Width     = 193
            .Height    = 15
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- cmd_4c_Incluir: inserir IVA top=246+29=275; Left=932
        loc_oPagina.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cmd_4c_Incluir
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ToolTipText   = "Inserir"
            .Top           = 275
            .Left          = 932
            .Width         = 45
            .Height        = 45
            .FontName      = "Verdana"
            .FontSize      = 8
            .FontBold      = .T.
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(36, 84, 155)
            .Themes        = .F.
            .SpecialEffect = 0
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Incluir, "Click", THIS, "BtnIncluirIvaClick")

        *-- cmd_4c_Excluir: excluir IVA top=291+29=320; Left=932
        loc_oPagina.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cmd_4c_Excluir
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText   = "Excluir"
            .Top           = 320
            .Left          = 932
            .Width         = 45
            .Height        = 45
            .FontName      = "Verdana"
            .FontSize      = 8
            .FontBold      = .T.
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(36, 84, 155)
            .Themes        = .F.
            .SpecialEffect = 0
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Excluir, "Click", THIS, "BtnExcluirIvaClick")

        *-- cmd_4c_InsRed: InsRed top=315+29=344; Left=626
        loc_oPagina.AddObject("cmd_4c_InsRed", "CommandButton")
        WITH loc_oPagina.cmd_4c_InsRed
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .ToolTipText   = "Inserir"
            .Top           = 344
            .Left          = 626
            .Width         = 45
            .Height        = 45
            .FontName      = "Verdana"
            .FontSize      = 8
            .FontBold      = .T.
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(36, 84, 155)
            .Themes        = .F.
            .SpecialEffect = 0
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_InsRed, "Click", THIS, "BtnInsRedClick")

        *-- cmd_4c_ExcRed: ExcRed top=360+29=389; Left=626
        loc_oPagina.AddObject("cmd_4c_ExcRed", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExcRed
            .Caption       = ""
            .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText   = "Excluir"
            .Top           = 389
            .Left          = 626
            .Width         = 45
            .Height        = 45
            .FontName      = "Verdana"
            .FontSize      = 8
            .FontBold      = .T.
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(36, 84, 155)
            .Themes        = .F.
            .SpecialEffect = 0
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ExcRed, "Click", THIS, "BtnExcRedClick")

        *-- grd_4c_IVA: GradIva top=171+29=200; Left=693; Width=235; Height=234
        loc_oPagina.AddObject("grd_4c_IVA", "Grid")
        WITH loc_oPagina.grd_4c_IVA
            .Top           = 200
            .Left          = 693
            .Width         = 235
            .Height        = 234
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ScrollBars    = 2
            .GridLines     = 3
            .GridLineWidth = 1
            .GridLineColor = RGB(238, 238, 238)
            .HeaderHeight  = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- ColumnCount FORA do WITH (Problema 36)
        loc_oPagina.grd_4c_IVA.ColumnCount = 4
        loc_oPagina.grd_4c_IVA.Column1.Width = 45
        loc_oPagina.grd_4c_IVA.Column2.Width = 45
        loc_oPagina.grd_4c_IVA.Column3.Width = 60
        loc_oPagina.grd_4c_IVA.Column4.Width = 60

        WITH loc_oPagina.grd_4c_IVA.Column1
            .FontName = "Tahoma"
            .FontSize = 8
            .Format   = "!"
        ENDWITH
        WITH loc_oPagina.grd_4c_IVA.Column1.Header1
            .Caption   = "UF Ori"
            .Alignment = 2
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.grd_4c_IVA.Column1.Controls(1)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Alignment   = 3
        ENDWITH

        WITH loc_oPagina.grd_4c_IVA.Column2
            .FontName = "Tahoma"
            .FontSize = 8
            .Format   = "!"
        ENDWITH
        WITH loc_oPagina.grd_4c_IVA.Column2.Header1
            .Caption   = "UF Des"
            .Alignment = 2
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.grd_4c_IVA.Column2.Controls(1)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Alignment   = 3
            .ForeColor   = RGB(0, 0, 0)
            .BackColor   = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oPagina.grd_4c_IVA.Column3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999.999"
        ENDWITH
        WITH loc_oPagina.grd_4c_IVA.Column3.Header1
            .Caption   = "IVA"
            .Alignment = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.grd_4c_IVA.Column3.Controls(1)
            .FontName  = "Tahoma"
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oPagina.grd_4c_IVA.Column4
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999.999"
        ENDWITH
        WITH loc_oPagina.grd_4c_IVA.Column4.Header1
            .Caption   = "IVA Im"
            .Alignment = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.grd_4c_IVA.Column4.Controls(1)
            .FontName  = "Tahoma"
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_IVA, "KeyPress", THIS, "IvaGridKeyPress")
        BINDEVENT(loc_oPagina.grd_4c_IVA, "AfterRowColChange", THIS, "IvaLostFocusValidar")

        *-- grd_4c_Reducao: GradRed top=262+29=291; Left=388; Width=235; Height=143
        loc_oPagina.AddObject("grd_4c_Reducao", "Grid")
        WITH loc_oPagina.grd_4c_Reducao
            .Top           = 291
            .Left          = 388
            .Width         = 235
            .Height        = 143
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ScrollBars    = 2
            .GridLines     = 3
            .GridLineWidth = 1
            .GridLineColor = RGB(238, 238, 238)
            .HeaderHeight  = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- ColumnCount FORA do WITH
        loc_oPagina.grd_4c_Reducao.ColumnCount = 3
        loc_oPagina.grd_4c_Reducao.Column1.Width = 51
        loc_oPagina.grd_4c_Reducao.Column2.Width = 72
        loc_oPagina.grd_4c_Reducao.Column3.Width = 72

        WITH loc_oPagina.grd_4c_Reducao.Column1
            .FontName = "Tahoma"
            .FontSize = 8
            .Format   = "!"
        ENDWITH
        WITH loc_oPagina.grd_4c_Reducao.Column1.Header1
            .Caption   = "UF Dest"
            .Alignment = 2
            .FontBold  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.grd_4c_Reducao.Column1.Controls(1)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Alignment   = 3
        ENDWITH

        WITH loc_oPagina.grd_4c_Reducao.Column2
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999.999"
        ENDWITH
        WITH loc_oPagina.grd_4c_Reducao.Column2.Header1
            .Caption   = "Aliq Red"
            .Alignment = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.grd_4c_Reducao.Column2.Controls(1)
            .FontName  = "Tahoma"
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        WITH loc_oPagina.grd_4c_Reducao.Column3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .InputMask = "999.999"
        ENDWITH
        WITH loc_oPagina.grd_4c_Reducao.Column3.Header1
            .Caption   = "Aliq B Red"
            .Alignment = 2
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH
        WITH loc_oPagina.grd_4c_Reducao.Column3.Controls(1)
            .FontName  = "Tahoma"
            .ForeColor = RGB(0, 0, 0)
            .BackColor = RGB(255, 255, 255)
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Reducao, "KeyPress", THIS, "RedGridKeyPress")
        BINDEVENT(loc_oPagina.grd_4c_Reducao, "AfterRowColChange", THIS, "RedLostFocusValidar")

        *-- Popular combos apos criacao dos controles
        THIS.PopularCombos()

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Liberacao de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("crIva")
            USE IN crIva
        ENDIF
        IF USED("crRed")
            USE IN crRed
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
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
        LOCAL loc_nI, loc_oObjeto, loc_lExcluido

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_lExcluido = INLIST(UPPER(loc_oObjeto.Name), "LBL_4C__IPI", "CNT_4C_CABECALHO")

                IF PEMSTATUS(loc_oObjeto, "Visible", 5) AND !loc_lExcluido
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF !loc_lExcluido
                    *-- Trata PageFrame - itera Pages
                    IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                        LOCAL loc_nP
                        FOR loc_nP = 1 TO loc_oObjeto.PageCount
                            THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                        ENDFOR
                    ENDIF

                    *-- Trata containers com ControlCount
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Metodos CRUD - placeholders para fases 4-8
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lResultado = .F.
            ELSE
                *-- RecordSource PRIMEIRO (reseta ControlSource e Headers automaticamente)
                loc_oGrid.ColumnCount = 5
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- ControlSource APOS RecordSource
                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aipis"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.unidades"
                loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cest"

                *-- Larguras (legado: Codigos=94, Descricaos=290, Aipis=45, Unidades=31, Cest=70)
                loc_oGrid.Column1.Width = 94
                loc_oGrid.Column2.Width = 290
                loc_oGrid.Column3.Width = 45
                loc_oGrid.Column4.Width = 31
                loc_oGrid.Column5.Width = 70

                *-- Headers OBRIGATORIO apos RecordSource (VFP reseta ao mudar RecordSource)
                loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "q. IPI"
                loc_oGrid.Column4.Header1.Caption = "UN"
                loc_oGrid.Column5.Header1.Caption = "CEST"

                THIS.FormatarGridLista(loc_oGrid)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.this_lTemProduto = .F.
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.CriarCursoresFilhos()
            THIS.VincularGridsFilhos()
            THIS.AtualizarSayIPI()
            THIS.pgf_4c_Paginas.ActivePage = 2
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao incluir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.CarregarFilhos(loc_cCodigo)
                    THIS.VincularGridsFilhos()
                    THIS.VerificarTemProduto(loc_cCodigo)
                    THIS.AtualizarSayIPI()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    loc_lResultado = .T.
                ENDIF
            ELSE
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado, loc_cCodigo
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.CarregarFilhos(loc_cCodigo)
                    THIS.VincularGridsFilhos()
                    THIS.VerificarTemProduto(loc_cCodigo)
                    THIS.AtualizarSayIPI()
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    loc_lResultado = .T.
                ENDIF
            ELSE
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cCodigo, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
                IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
                    *-- Verifica se existem produtos usando esta classificacao fiscal
                    loc_cSQL = "SELECT TOP 1 cpros FROM SigCdPro WHERE clfiscals = " + EscaparSQL(loc_cCodigo) + ;
                               " UNION ALL " + ;
                               "SELECT TOP 1 cpros FROM SigCdPrc WHERE clfiscals = " + EscaparSQL(loc_cCodigo)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExcPro") > 0
                        IF USED("cursor_4c_ChkExcPro") AND !EOF("cursor_4c_ChkExcPro")
                            IF USED("cursor_4c_ChkExcPro")
                                USE IN cursor_4c_ChkExcPro
                            ENDIF
                            MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Excluir, Classifica" + CHR(231) + CHR(227) + "o Fiscal J" + CHR(225) + " Informada em Produtos.", "Aviso")
                        ELSE
                            IF USED("cursor_4c_ChkExcPro")
                                USE IN cursor_4c_ChkExcPro
                            ENDIF
                            *-- Excluir filhos antes do registro principal
                            SQLEXEC(gnConnHandle, "DELETE FROM SigCdIva WHERE codigos = " + EscaparSQL(loc_cCodigo))
                            SQLEXEC(gnConnHandle, "DELETE FROM SigCdRed WHERE codigos = " + EscaparSQL(loc_cCodigo))
                            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                                IF THIS.this_oBusinessObject.Excluir()
                                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Sucesso")
                                    THIS.CarregarLista()
                                    loc_lResultado = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                    ELSE
                        MostrarErro("Erro ao verificar produtos vinculados.", "Erro")
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_lResultado, loc_oBusca, loc_cFiltro
        loc_lResultado = .F.
        TRY
            loc_cFiltro = ""
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cFiltro = ALLTRIM(cursor_4c_Dados.codigos)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SIGCDCLF", "cursor_4c_BuscaClf", "codigos", loc_cFiltro, ;
                "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
                    SELECT cursor_4c_BuscaClf
                    loc_cFiltro = ALLTRIM(cursor_4c_BuscaClf.codigos)
                    IF THIS.this_oBusinessObject.Buscar("codigos = '" + ALLTRIM(loc_cFiltro) + "'")
                        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                            GO TOP IN cursor_4c_Dados
                        ENDIF
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaClf")
                USE IN cursor_4c_BuscaClf
            ENDIF
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MostrarErro("Erro ao encerrar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPg2, loc_cCodigo
        loc_lResultado = .F.
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio.", "Aviso")
            loc_oPg2.txt_4c_Codigo.SetFocus()
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descricao.Value))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.", "Aviso")
            loc_oPg2.txt_4c_Descricao.SetFocus()
            RETURN .F.
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
                THIS.SalvarFilhos(loc_cCodigo)
                MsgInfo("Registro salvo com sucesso.", "Sucesso")
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.CarregarLista()
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    PROCEDURE BtnCancelarClick()
        TRY
            THIS.pgf_4c_Paginas.ActivePage = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        CATCH TO loException
            MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            WITH THIS.this_oBusinessObject
                .this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
                .this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
                .this_cUnidade   = ALLTRIM(loc_oPg2.txt_4c_Unidade.Value)
                .this_cCest      = ALLTRIM(loc_oPg2.txt_4c_Cest.Value)
                .this_nAipi      = loc_oPg2.txt_4c_Aipi.Value
                .this_nIndIVAST  = loc_oPg2.txt_4c_IVAST.Value
                .this_nBIcms     = loc_oPg2.txt_4c_Areduzida.Value
                .this_nBIcmss    = loc_oPg2.txt_4c_AreduzidaS.Value
                .this_nAliqFcp   = loc_oPg2.txt_4c_AliqFcp.Value

                *-- ComboBoxes S/N (ListIndex 1=Sim/Tributado, 2=Nao/Isento, 3=Outros)
                .this_cBaseReds = IIF(loc_oPg2.cbo_4c_Cmbbred.ListIndex = 1, "S", "N")
                .this_cAliqReds = IIF(loc_oPg2.cbo_4c_CmbAred.ListIndex = 1, "S", "N")
                *-- cmbIpi: Tributado(1)="T", Isento(2)="I", Outros(3)="O"
                .this_cIpis     = IIF(loc_oPg2.cbo_4c_CmbIpi.ListIndex = 2, "I", ;
                                      IIF(loc_oPg2.cbo_4c_CmbIpi.ListIndex = 3, "O", "T"))
                .this_cIpiProds = IIF(loc_oPg2.cbo_4c_CmbIPip.ListIndex = 1, "S", "N")

                *-- TipoMercs via ComboBox
                .this_nTipoMercs = loc_oPg2.cbo_4c_CmbTipoMerc.ListIndex

                *-- TpSubSt via OptionGroup
                .this_nTpSubSt = loc_oPg2.opt_4c_Opt_TpSubSt.Value
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro em FormParaBO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            WITH THIS.this_oBusinessObject
                loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(.this_cCodigo)
                loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(.this_cDescricao)
                loc_oPg2.txt_4c_Unidade.Value   = ALLTRIM(.this_cUnidade)
                loc_oPg2.txt_4c_Cest.Value      = ALLTRIM(.this_cCest)
                loc_oPg2.txt_4c_Aipi.Value      = .this_nAipi
                loc_oPg2.txt_4c_IVAST.Value     = .this_nIndIVAST
                loc_oPg2.txt_4c_Areduzida.Value = .this_nBIcms
                loc_oPg2.txt_4c_AreduzidaS.Value= .this_nBIcmss
                loc_oPg2.txt_4c_AliqFcp.Value   = .this_nAliqFcp

                *-- ComboBoxes S/N (plain strings - no \< prefix no sistema novo)
                loc_oPg2.cbo_4c_Cmbbred.Value = IIF(UPPER(ALLTRIM(.this_cBaseReds)) = "S", "Sim", "N" + CHR(227) + "o")
                loc_oPg2.cbo_4c_CmbAred.Value = IIF(UPPER(ALLTRIM(.this_cAliqReds)) = "S", "Sim", "N" + CHR(227) + "o")
                *-- cmbIpi: T=Tributado, I=Isento, O=Outros
                loc_oPg2.cbo_4c_CmbIpi.Value  = IIF(UPPER(ALLTRIM(.this_cIpis)) = "O", "Outros", ;
                                                     IIF(UPPER(ALLTRIM(.this_cIpis)) = "I", "Isento", "Tributado"))
                loc_oPg2.cbo_4c_CmbIPip.Value = IIF(UPPER(ALLTRIM(.this_cIpiProds)) = "S", "Sim", "N" + CHR(227) + "o")

                *-- TipoMercs
                loc_oPg2.cbo_4c_CmbTipoMerc.ListIndex = .this_nTipoMercs

                *-- TpSubSt
                loc_oPg2.opt_4c_Opt_TpSubSt.Value = IIF(.this_nTpSubSt > 0, .this_nTpSubSt, 1)
            ENDWITH
            THIS.TpSubStChanged()
            THIS.CmbTipoMercChange()
        CATCH TO loException
            MostrarErro("Erro em BOParaForm:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_oPg2.txt_4c_Codigo.Value     = ""
            loc_oPg2.txt_4c_Descricao.Value  = ""
            loc_oPg2.txt_4c_Unidade.Value    = ""
            loc_oPg2.txt_4c_Cest.Value       = ""
            loc_oPg2.txt_4c_Aipi.Value       = 0
            loc_oPg2.txt_4c_IVAST.Value      = 0
            loc_oPg2.txt_4c_Areduzida.Value  = 0
            loc_oPg2.txt_4c_AreduzidaS.Value = 0
            loc_oPg2.txt_4c_AliqFcp.Value    = 0
            loc_oPg2.cbo_4c_Cmbbred.ListIndex = 2
            loc_oPg2.cbo_4c_CmbAred.ListIndex = 2
            loc_oPg2.cbo_4c_CmbIpi.ListIndex  = 1
            loc_oPg2.cbo_4c_CmbIPip.ListIndex = 2
            loc_oPg2.cbo_4c_CmbTipoMerc.ListIndex = 0
            loc_oPg2.opt_4c_Opt_TpSubSt.Value = 1
            IF USED("crIva")
                SELECT crIva
                ZAP
            ENDIF
            IF USED("crRed")
                SELECT crRed
                ZAP
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em LimparCampos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lCodigoHab
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_lCodigoHab = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        TRY
            loc_oPg2.txt_4c_Codigo.Enabled    = loc_lCodigoHab
            loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
            loc_oPg2.txt_4c_Unidade.Enabled   = par_lHabilitar
            loc_oPg2.txt_4c_Cest.Enabled      = par_lHabilitar
            loc_oPg2.txt_4c_Aipi.Enabled      = par_lHabilitar
            loc_oPg2.txt_4c_IVAST.Enabled     = par_lHabilitar AND (loc_oPg2.opt_4c_Opt_TpSubSt.Value = 1)
            loc_oPg2.txt_4c_Areduzida.Enabled = par_lHabilitar
            loc_oPg2.txt_4c_AreduzidaS.Enabled= par_lHabilitar
            loc_oPg2.txt_4c_AliqFcp.Enabled   = par_lHabilitar
            loc_oPg2.cbo_4c_Cmbbred.Enabled   = par_lHabilitar
            loc_oPg2.cbo_4c_CmbAred.Enabled   = par_lHabilitar
            loc_oPg2.cbo_4c_CmbIpi.Enabled    = par_lHabilitar
            loc_oPg2.cbo_4c_CmbIPip.Enabled   = par_lHabilitar AND !THIS.this_lTemProduto
            loc_oPg2.cbo_4c_CmbTipoMerc.Enabled= par_lHabilitar
            loc_oPg2.opt_4c_Opt_TpSubSt.Enabled= par_lHabilitar
            *-- Botoes de grid IVA/RED habilitados so em INCLUIR/ALTERAR
            IF PEMSTATUS(loc_oPg2, "cmd_4c_Incluir", 5)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_Excluir", 5)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_InsRed", 5)
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_ExcRed", 5)
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em HabilitarCampos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularCmbTipoMerc - Popula ComboBox de Tipo de Mercadoria (76 itens)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PopularCmbTipoMerc()
        LOCAL loc_oPg2, loc_i
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_oPg2.cbo_4c_CmbTipoMerc.Clear()
            FOR loc_i = 1 TO 76
                loc_oPg2.cbo_4c_CmbTipoMerc.AddItem(TRANSFORM(loc_i, "@L 99"))
            ENDFOR
        CATCH TO loException
            MostrarErro("Erro em PopularCmbTipoMerc:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TpSubStChanged - Handler InteractiveChange opt_4c_Opt_TpSubSt
    * Legado: getIVAST.When = Return(This.Parent.opt_TpSubSt.Value == 1)
    *--------------------------------------------------------------------------
    PROCEDURE TpSubStChanged()
        LOCAL loc_oPg2, loc_lHabilitar
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_lHabilitar = (loc_oPg2.opt_4c_Opt_TpSubSt.Value = 1) AND ;
                             INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            loc_oPg2.txt_4c_IVAST.Enabled = loc_lHabilitar
        CATCH TO loException
            MostrarErro("Erro em TpSubStChanged:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmbTipoMercChange - Handler InteractiveChange cbo_4c_CmbTipoMerc
    * Legado: CmbTipoMerc.InteractiveChange -> lblTipoMerc.Caption = ar_Msgs(This.Value)
    *--------------------------------------------------------------------------
    PROCEDURE CmbTipoMercChange()
        LOCAL loc_oPg2, loc_nIdx
        LOCAL ar_Msgs(76)
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            ar_Msgs(1)  = "Medicamentos constantes da Lista Positiva da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
            ar_Msgs(2)  = "Medicamentos constantes da Lista Negativa da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
            ar_Msgs(3)  = "Medicamentos constantes da Lista Neutra da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
            ar_Msgs(4)  = "Produtos Cosm" + CHR(233) + "ticos e de Perfumaria Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 18%"
            ar_Msgs(5)  = "Produtos Cosm" + CHR(233) + "ticos e de Perfumaria Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 25%"
            ar_Msgs(6)  = "Produtos de Higiene Pessoal Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 18%, itens de 1 a 10 do artigo 313-G do RICMS"
            ar_Msgs(7)  = "Produtos de Higiene Pessoal Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 12%, itens de 1 a 10 do artigo 313-G do RICMS"
            ar_Msgs(8)  = "Bebida Alco" + CHR(243) + "lica, exceto cerveja e chope, sujeita ao IVA-ST"
            ar_Msgs(9)  = "Bebida Alco" + CHR(243) + "lica, exceto cerveja e chope, sujeita ao Pre" + CHR(231) + "o Final ao Consumidor, divulgado pela SEFAZ/SP"
            ar_Msgs(10) = "Prepara" + CHR(231) + CHR(245) + "es qu" + CHR(237) + "micas contraceptivas " + CHR(224) + " base de horm" + CHR(244) + "nios ou espermicidas, constantes da Lista Positiva da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
            ar_Msgs(11) = "Prepara" + CHR(231) + CHR(245) + "es qu" + CHR(237) + "micas contraceptivas " + CHR(224) + " base de horm" + CHR(244) + "nios ou espermicidas, constantes da Lista Negativa da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
            ar_Msgs(12) = "Prepara" + CHR(231) + CHR(245) + "es qu" + CHR(237) + "micas contraceptivas " + CHR(224) + " base de horm" + CHR(244) + "nios ou espermicidas, constantes da Lista Neutra da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
            ar_Msgs(13) = "Produtos de Higiene Pessoal Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 18%, itens 11 a 19 do artigo 313-G do RICMS"
            ar_Msgs(14) = "Produtos de Higiene Pessoal Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 12%, itens 11 a 19 do artigo 313-G do RICMS"
            ar_Msgs(15) = "Produtos de Limpeza - " + CHR(193) + "gua sanit" + CHR(225) + "ria, branqueador ou alvejante"
            ar_Msgs(16) = "Produtos de Limpeza - odorizante/desodorizante de ambiente e superf" + CHR(237) + "cie"
            ar_Msgs(17) = "Produtos de Limpeza - sab" + CHR(245) + "es em barras, peda" + CHR(231) + "os ou figuras moldados"
            ar_Msgs(18) = "Produtos de Limpeza - sab" + CHR(245) + "es ou detergentes em p" + CHR(243) + ", flocos, palhetas, gr" + CHR(226) + "nulos ou outras formas semelhantes"
            ar_Msgs(19) = "Produtos de Limpeza - detergentes l" + CHR(237) + "quidos"
            ar_Msgs(20) = "Produtos de Limpeza - outras prepara" + CHR(231) + CHR(245) + "es tensoativas para lavagem e limpeza (inclusive multiuso e limpadores)"
            ar_Msgs(21) = "Produtos de Limpeza - pomadas, cremes e prepara" + CHR(231) + CHR(245) + "es semelhantes, para cal" + CHR(231) + "ados ou para couros"
            ar_Msgs(22) = "Produtos de Limpeza - pastas, p" + CHR(243) + "s, sapon" + CHR(225) + "ceos e outras prepara" + CHR(231) + CHR(245) + "es para arear"
            ar_Msgs(23) = "Produtos de Limpeza - facilitadores e goma para passar roupa"
            ar_Msgs(24) = "Produtos de Limpeza - inseticidas, rodenticidas, fungicidas, raticidas e outros produtos semelhantes, apresentados em formas ou embalagens exclusivamente para uso domissanit" + CHR(225) + "rio direto"
            ar_Msgs(25) = "Produtos de Limpeza - desinfetantes apresentados em formas ou embalagens exclusivamente para uso domissanit" + CHR(225) + "rio direto"
            ar_Msgs(26) = "Produtos de Limpeza - amaciante/suavizante"
            ar_Msgs(27) = "Produtos de Limpeza - esponjas para limpeza"
            ar_Msgs(28) = "Papel para escrita, impress" + CHR(227) + "o ou outros fins gr" + CHR(225) + "ficos, em folhas, de peso entre 40 e 150g/m2"
            ar_Msgs(29) = "L" + CHR(226) + "mpadas, tubos, v" + CHR(225) + "lvulas, reatores e " + CHR(34) + "starters" + CHR(34)
            ar_Msgs(30) = "Pilhas e Baterias Novas"
            ar_Msgs(31) = "Produtos Fonogr" + CHR(225) + "ficos"
            ar_Msgs(32) = "Autope" + CHR(231) + "as - IVA ST de 26,50%"
            ar_Msgs(33) = "Autope" + CHR(231) + "as - IVA ST de 40%"
            ar_Msgs(34) = "Ra" + CHR(231) + CHR(227) + "o tipo " + CHR(34) + "pet" + CHR(34) + " para animais dom" + CHR(233) + "sticos"
            ar_Msgs(35) = "Chocolates - IVA ST de 43,23%"
            ar_Msgs(36) = "Chocolates - IVA ST de 24,73%"
            ar_Msgs(37) = "Sucos e Bebidas Prontas - IVA ST de 40,46%"
            ar_Msgs(38) = "Sucos e Bebidas Prontas - IVA ST de 51,23%"
            ar_Msgs(39) = "Sucos e Bebidas Prontas - IVA ST de 38,84%"
            ar_Msgs(40) = "Sucos e Bebidas Prontas - IVA ST de 39,83%"
            ar_Msgs(41) = "Latic" + CHR(237) + "nios e Matinais - IVA ST de 20,23%"
            ar_Msgs(42) = "Latic" + CHR(237) + "nios e Matinais - IVA ST de 24,73%"
            ar_Msgs(43) = "Latic" + CHR(237) + "nios e Matinais - IVA ST de 49,87%"
            ar_Msgs(44) = "Latic" + CHR(237) + "nios e Matinais - IVA ST de 43,65%"
            ar_Msgs(45) = "Snacks"
            ar_Msgs(46) = "Molhos, temperos e condimentos - IVA ST de 60,23%"
            ar_Msgs(47) = "Molhos, temperos e condimentos - IVA ST de 62,52%"
            ar_Msgs(48) = "Molhos, temperos e condimentos - IVA ST de 62,24%"
            ar_Msgs(49) = "Molhos, temperos e condimentos - IVA ST de 40,82%"
            ar_Msgs(50) = "Barras de Cereais"
            ar_Msgs(51) = "Outros - Prepara" + CHR(231) + CHR(245) + "es aliment" + CHR(237) + "cias compostas homogeneizadas (alimento infantil em conserva salgado ou doce) - IVA ST de 49,87%"
            ar_Msgs(52) = "Outros - Prepara" + CHR(231) + CHR(245) + "es para caldos em embalagem igual ou inferior a 1 kg - IVA ST de 54,81%"
            ar_Msgs(53) = "Outros - Prepara" + CHR(231) + CHR(245) + "es para sopas em embalagem igual ou inferior a 1 kg - IVA ST de 56,59%"
            ar_Msgs(54) = "Chocolates - IVA ST de 43,23% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(55) = "Chocolates - IVA ST de 24,73% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(56) = "Sucos e Bebidas Prontas - IVA ST de 40,46% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(57) = "Sucos e Bebidas Prontas - IVA ST de 51,23% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(58) = "Sucos e Bebidas Prontas - IVA ST de 38,84% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(59) = "Sucos e Bebidas Prontas - IVA ST de 39,83% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(60) = "Latic" + CHR(237) + "nios e Matinais - IVA ST de 20,23% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(61) = "Latic" + CHR(237) + "nios e Matinais - IVA ST de 24,73% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(62) = "Latic" + CHR(237) + "nios e Matinais - IVA ST de 49,87% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(63) = "Latic" + CHR(237) + "nios e Matinais - IVA ST de 43,65% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(64) = "Snacks - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(65) = "Molhos, temperos e condimentos - IVA ST de 60,23% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(66) = "Molhos, temperos e condimentos - IVA ST de 62,52% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(67) = "Molhos, temperos e condimentos - IVA ST de 62,24% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(68) = "Molhos, temperos e condimentos - IVA ST de 40,82% - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(69) = "Barras de Cereais - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(70) = "Prepara" + CHR(231) + CHR(245) + "es aliment" + CHR(237) + "cias compostas homogeneizadas (alimento infantil em conserva salgado ou doce) - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(71) = "Prepara" + CHR(231) + CHR(245) + "es para caldos em embalagem igual ou inferior a 1 kg - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(72) = "Prepara" + CHR(231) + CHR(245) + "es para sopas em embalagem igual ou inferior a 1 kg - Contribuinte que preenche condi" + CHR(231) + CHR(245) + "es do " + CHR(167) + " 7" + CHR(176) + " do artigo 1" + CHR(176) + " do Decreto 52.942/2008"
            ar_Msgs(73) = "Materiais de constru" + CHR(231) + CHR(227) + "o e cong" + CHR(234) + "neres - IVA ST de 29,68%"
            ar_Msgs(74) = "Materiais de constru" + CHR(231) + CHR(227) + "o e cong" + CHR(234) + "neres - IVA ST de 45%"
            ar_Msgs(75) = "Autope" + CHR(231) + "as - IVA ST de 26,50%"
            ar_Msgs(76) = "Autope" + CHR(231) + "as - IVA ST de 40%"
            loc_nIdx = loc_oPg2.cbo_4c_CmbTipoMerc.ListIndex
            IF loc_nIdx >= 1 AND loc_nIdx <= 76
                loc_oPg2.lbl_4c_LblTipoMerc.Caption = ar_Msgs(loc_nIdx)
            ELSE
                loc_oPg2.lbl_4c_LblTipoMerc.Caption = ""
            ENDIF
            loc_oPg2.lbl_4c_LblTipoMerc.Refresh()
        CATCH TO loException
            MostrarErro("Erro em CmbTipoMercChange:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularCombos - Popula os 4 ComboBoxes da Page2
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PopularCombos
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_oPg2.cbo_4c_Cmbbred.Clear()
            loc_oPg2.cbo_4c_Cmbbred.AddItem("Sim")
            loc_oPg2.cbo_4c_Cmbbred.AddItem("N" + CHR(227) + "o")

            loc_oPg2.cbo_4c_CmbAred.Clear()
            loc_oPg2.cbo_4c_CmbAred.AddItem("Sim")
            loc_oPg2.cbo_4c_CmbAred.AddItem("N" + CHR(227) + "o")

            loc_oPg2.cbo_4c_CmbIpi.Clear()
            loc_oPg2.cbo_4c_CmbIpi.AddItem("Tributado")
            loc_oPg2.cbo_4c_CmbIpi.AddItem("Isento")
            loc_oPg2.cbo_4c_CmbIpi.AddItem("Outros")

            loc_oPg2.cbo_4c_CmbIPip.Clear()
            loc_oPg2.cbo_4c_CmbIPip.AddItem("Sim")
            loc_oPg2.cbo_4c_CmbIPip.AddItem("N" + CHR(227) + "o")
        CATCH TO loException
            MostrarErro("Erro em PopularCombos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursoresFilhos - Cria cursores locais crIva e crRed com 1 linha em branco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursoresFilhos
        TRY
            IF USED("crIva")
                USE IN crIva
            ENDIF
            IF USED("crRed")
                USE IN crRed
            ENDIF

            SET NULL OFF
            CREATE CURSOR crIva (codigos c(12), estasO c(2), estasD c(2), ;
                                 indivast n(7,3), indivastPi n(7,3), cidChaves c(10))
            SELECT crIva
            APPEND BLANK

            CREATE CURSOR crRed (codigos c(12), estas c(2), aReds n(7,3), ;
                                 bReds n(7,3), cidChaves c(10))
            SELECT crRed
            APPEND BLANK
            SET NULL ON
        CATCH TO loException
            SET NULL ON
            MostrarErro("Erro em CriarCursoresFilhos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFilhos - Carrega crIva e crRed do banco para o codigo informado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarFilhos
        LPARAMETERS par_cCodigo
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            IF USED("crIva")
                USE IN crIva
            ENDIF
            IF USED("crRed")
                USE IN crRed
            ENDIF

            SET NULL OFF
            CREATE CURSOR crIva (codigos c(12), estasO c(2), estasD c(2), ;
                                 indivast n(7,3), indivastPi n(7,3), cidChaves c(10))
            CREATE CURSOR crRed (codigos c(12), estas c(2), aReds n(7,3), ;
                                 bReds n(7,3), cidChaves c(10))
            SET NULL ON

            *-- Carregar IVAs do banco
            loc_cSQL = "SELECT codigos, estasO, estasD, indivast, indivastPi, cidChaves " + ;
                       "FROM SigCdIva WHERE codigos = " + EscaparSQL(par_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpIva") > 0
                IF USED("cursor_4c_TmpIva") AND RECCOUNT("cursor_4c_TmpIva") > 0
                    SELECT cursor_4c_TmpIva
                    SCAN
                        SELECT crIva
                        APPEND BLANK
                        REPLACE crIva.codigos    WITH cursor_4c_TmpIva.codigos, ;
                                crIva.estasO     WITH cursor_4c_TmpIva.estasO, ;
                                crIva.estasD     WITH cursor_4c_TmpIva.estasD, ;
                                crIva.indivast   WITH cursor_4c_TmpIva.indivast, ;
                                crIva.indivastPi WITH cursor_4c_TmpIva.indivastPi, ;
                                crIva.cidChaves  WITH cursor_4c_TmpIva.cidChaves
                        SELECT cursor_4c_TmpIva
                    ENDSCAN
                ENDIF
                IF USED("cursor_4c_TmpIva")
                    USE IN cursor_4c_TmpIva
                ENDIF
            ENDIF
            SELECT crIva
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF

            *-- Carregar Reducoes do banco
            loc_cSQL = "SELECT codigos, estas, aReds, bReds, cidChaves " + ;
                       "FROM SigCdRed WHERE codigos = " + EscaparSQL(par_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpRed") > 0
                IF USED("cursor_4c_TmpRed") AND RECCOUNT("cursor_4c_TmpRed") > 0
                    SELECT cursor_4c_TmpRed
                    SCAN
                        SELECT crRed
                        APPEND BLANK
                        REPLACE crRed.codigos   WITH cursor_4c_TmpRed.codigos, ;
                                crRed.estas     WITH cursor_4c_TmpRed.estas, ;
                                crRed.aReds     WITH cursor_4c_TmpRed.aReds, ;
                                crRed.bReds     WITH cursor_4c_TmpRed.bReds, ;
                                crRed.cidChaves WITH cursor_4c_TmpRed.cidChaves
                        SELECT cursor_4c_TmpRed
                    ENDSCAN
                ENDIF
                IF USED("cursor_4c_TmpRed")
                    USE IN cursor_4c_TmpRed
                ENDIF
            ENDIF
            SELECT crRed
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro em CarregarFilhos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGridsFilhos - Vincula grids grd_4c_IVA e grd_4c_Reducao aos cursores
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VincularGridsFilhos
        LOCAL loc_oPg2, loc_oGrdIva, loc_oGrdRed
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_oGrdIva = loc_oPg2.grd_4c_IVA
        loc_oGrdRed = loc_oPg2.grd_4c_Reducao
        TRY
            loc_oGrdIva.RecordSource = "crIva"
            loc_oGrdIva.Column1.ControlSource = "crIva.estasO"
            loc_oGrdIva.Column2.ControlSource = "crIva.estasD"
            loc_oGrdIva.Column3.ControlSource = "crIva.indivast"
            loc_oGrdIva.Column4.ControlSource = "crIva.indivastPi"
            loc_oGrdIva.Column1.Width = 45
            loc_oGrdIva.Column2.Width = 45
            loc_oGrdIva.Column3.Width = 60
            loc_oGrdIva.Column4.Width = 60
            loc_oGrdIva.Column1.Header1.Caption = "UF Ori"
            loc_oGrdIva.Column2.Header1.Caption = "UF Des"
            loc_oGrdIva.Column3.Header1.Caption = "IVA"
            loc_oGrdIva.Column4.Header1.Caption = "IVA Im"
            loc_oGrdIva.Refresh()

            loc_oGrdRed.RecordSource = "crRed"
            loc_oGrdRed.Column1.ControlSource = "crRed.estas"
            loc_oGrdRed.Column2.ControlSource = "crRed.aReds"
            loc_oGrdRed.Column3.ControlSource = "crRed.bReds"
            loc_oGrdRed.Column1.Width = 51
            loc_oGrdRed.Column2.Width = 72
            loc_oGrdRed.Column3.Width = 72
            loc_oGrdRed.Column1.Header1.Caption = "UF Dest"
            loc_oGrdRed.Column2.Header1.Caption = "Aliq Red"
            loc_oGrdRed.Column3.Header1.Caption = "Aliq B Red"
            loc_oGrdRed.Refresh()
        CATCH TO loException
            MostrarErro("Erro em VincularGridsFilhos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarFilhos - Salva SigCdIva e SigCdRed via DELETE+INSERT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarFilhos
        LPARAMETERS par_cCodigo
        LOCAL loc_lResultado, loc_cSQL, loc_cChave
        loc_lResultado = .T.
        TRY
            SQLEXEC(gnConnHandle, "DELETE FROM SigCdIva WHERE codigos = " + EscaparSQL(par_cCodigo))

            IF USED("crIva")
                SELECT crIva
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crIva.estasO)) AND !EMPTY(ALLTRIM(crIva.estasD))
                        loc_cChave = IIF(EMPTY(ALLTRIM(crIva.cidChaves)), ;
                                         LEFT(SYS(2015) + SYS(2015), 10), ;
                                         ALLTRIM(crIva.cidChaves))
                        loc_cSQL = "INSERT INTO SigCdIva (codigos, estasO, estasD, indivast, indivastPi, cidchaves) " + ;
                                   "VALUES (" + EscaparSQL(par_cCodigo) + ", " + ;
                                   EscaparSQL(PADR(ALLTRIM(crIva.estasO), 2)) + ", " + ;
                                   EscaparSQL(PADR(ALLTRIM(crIva.estasD), 2)) + ", " + ;
                                   FormatarNumeroSQL(crIva.indivast) + ", " + ;
                                   FormatarNumeroSQL(crIva.indivastPi) + ", " + ;
                                   EscaparSQL(loc_cChave) + ")"
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                ENDSCAN
            ENDIF

            SQLEXEC(gnConnHandle, "DELETE FROM SigCdRed WHERE codigos = " + EscaparSQL(par_cCodigo))

            IF USED("crRed")
                SELECT crRed
                GO TOP
                SCAN
                    IF !EMPTY(ALLTRIM(crRed.estas))
                        loc_cChave = IIF(EMPTY(ALLTRIM(crRed.cidChaves)), ;
                                         LEFT(SYS(2015) + SYS(2015), 10), ;
                                         ALLTRIM(crRed.cidChaves))
                        loc_cSQL = "INSERT INTO SigCdRed (codigos, estas, aReds, bReds, cidchaves) " + ;
                                   "VALUES (" + EscaparSQL(par_cCodigo) + ", " + ;
                                   EscaparSQL(PADR(ALLTRIM(crRed.estas), 2)) + ", " + ;
                                   FormatarNumeroSQL(crRed.aReds) + ", " + ;
                                   FormatarNumeroSQL(crRed.bReds) + ", " + ;
                                   EscaparSQL(loc_cChave) + ")"
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em SalvarFilhos:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirIvaClick - Adiciona linha em branco ao grid IVA
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirIvaClick
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crIva")
                SELECT crIva
                LOCATE FOR EMPTY(ALLTRIM(estasO))
                IF EOF()
                    APPEND BLANK
                    REPLACE crIva.estasO    WITH SPACE(2), ;
                            crIva.estasD    WITH SPACE(2), ;
                            crIva.indivast  WITH 0, ;
                            crIva.indivastPi WITH 0
                ENDIF
                THIS.pgf_4c_Paginas.Page2.grd_4c_IVA.Refresh()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao incluir IVA:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirIvaClick - Exclui linha corrente do grid IVA
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirIvaClick
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crIva")
                SELECT crIva
                IF !EOF() AND !BOF()
                    DELETE
                    THIS.pgf_4c_Paginas.Page2.grd_4c_IVA.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir IVA:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnInsRedClick - Adiciona linha em branco ao grid Reducao
    *--------------------------------------------------------------------------
    PROCEDURE BtnInsRedClick
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crRed")
                SELECT crRed
                LOCATE FOR EMPTY(ALLTRIM(estas))
                IF EOF()
                    APPEND BLANK
                    REPLACE crRed.estas WITH SPACE(2), ;
                            crRed.aReds WITH 0, ;
                            crRed.bReds WITH 0
                ENDIF
                THIS.pgf_4c_Paginas.Page2.grd_4c_Reducao.Refresh()
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao incluir Redu" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcRedClick - Exclui linha corrente do grid Reducao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcRedClick
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("crRed")
                SELECT crRed
                IF !EOF() AND !BOF()
                    DELETE
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Reducao.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir Redu" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * IvaCol1KeyPress - Handler KeyPress para grd_4c_IVA.Column1 (estasO)
    *--------------------------------------------------------------------------
    PROCEDURE IvaCol1KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupUF(THIS.pgf_4c_Paginas.Page2.grd_4c_IVA.Column1.Controls(1))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * IvaCol2KeyPress - Handler KeyPress para grd_4c_IVA.Column2 (estasD)
    *--------------------------------------------------------------------------
    PROCEDURE IvaCol2KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupUF(THIS.pgf_4c_Paginas.Page2.grd_4c_IVA.Column2.Controls(1))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RedCol1KeyPress - Handler KeyPress para grd_4c_Reducao.Column1 (estas)
    *--------------------------------------------------------------------------
    PROCEDURE RedCol1KeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        IF par_nKeyCode = 115  && F4
            THIS.AbrirLookupUF(THIS.pgf_4c_Paginas.Page2.grd_4c_Reducao.Column1.Controls(1))
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * IvaGridKeyPress - Handler KeyPress do grd_4c_IVA (nivel Grid)
    * VFP9 nao permite BINDEVENT em Column.Controls(1).KeyPress durante init
    *--------------------------------------------------------------------------
    PROCEDURE IvaGridKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2, loc_nCol
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF par_nKeyCode = 115  && F4
            loc_nCol = loc_oPg2.grd_4c_IVA.ActiveColumn
            IF loc_nCol = 1
                THIS.AbrirLookupUF(loc_oPg2.grd_4c_IVA.Column1.Controls(1))
            ENDIF
            IF loc_nCol = 2
                THIS.AbrirLookupUF(loc_oPg2.grd_4c_IVA.Column2.Controls(1))
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RedGridKeyPress - Handler KeyPress do grd_4c_Reducao (nivel Grid)
    *--------------------------------------------------------------------------
    PROCEDURE RedGridKeyPress
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF par_nKeyCode = 115  && F4
            IF loc_oPg2.grd_4c_Reducao.ActiveColumn = 1
                THIS.AbrirLookupUF(loc_oPg2.grd_4c_Reducao.Column1.Controls(1))
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupUF - Abre FormBuscaAuxiliar em SigCdUfs para selecao de estado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupUF
        LPARAMETERS par_oCampo
        LOCAL loc_lResultado, loc_oBusca, loc_cAtual
        loc_lResultado = .F.
        TRY
            IF VARTYPE(par_oCampo) != "O"
                loc_lResultado = .F.
            ELSE
                loc_cAtual = PADR(ALLTRIM(par_oCampo.Value), 2)
                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdUfs", "cursor_4c_BuscaUf", "Estados", loc_cAtual, ;
                    "Sele" + CHR(231) + CHR(227) + "o")
                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("Estados", "", "UF")
                        loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
                        SELECT cursor_4c_BuscaUf
                        par_oCampo.Value = ALLTRIM(cursor_4c_BuscaUf.Estados)
                        par_oCampo.Refresh()
                    ENDIF
                    loc_oBusca.Release()
                ENDIF
                IF USED("cursor_4c_BuscaUf")
                    USE IN cursor_4c_BuscaUf
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao abrir lookup UF:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * IvaLostFocusValidar - Verifica duplicatas em crIva (estasO+estasD)
    *--------------------------------------------------------------------------
    PROCEDURE IvaLostFocusValidar
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        TRY
            IF USED("crIva")
                SELECT estasO, estasD FROM crIva ;
                    INTO CURSOR cursor_4c_DupIva ;
                    GROUP BY estasO, estasD HAVING COUNT(1) > 1
                SELECT cursor_4c_DupIva
                IF RECCOUNT() > 0
                    MsgAviso("IVA j" + CHR(225) + " lan" + CHR(231) + "ado!!!", "Aviso")
                ENDIF
                IF USED("cursor_4c_DupIva")
                    USE IN cursor_4c_DupIva
                ENDIF
                SELECT crIva
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em IvaLostFocusValidar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RedLostFocusValidar - Verifica duplicatas em crRed (estas)
    *--------------------------------------------------------------------------
    PROCEDURE RedLostFocusValidar
        LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
        TRY
            IF USED("crRed")
                SELECT estas FROM crRed ;
                    INTO CURSOR cursor_4c_DupRed ;
                    GROUP BY estas HAVING COUNT(1) > 1
                SELECT cursor_4c_DupRed
                IF RECCOUNT() > 0
                    MsgAviso("Redu" + CHR(231) + CHR(227) + "o j" + CHR(225) + " lan" + CHR(231) + "ada!!!", "Aviso")
                ENDIF
                IF USED("cursor_4c_DupRed")
                    USE IN cursor_4c_DupRed
                ENDIF
                SELECT crRed
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em RedLostFocusValidar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAliqFcp - Valida range 0-2 para AliqFcp (LostFocus)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarAliqFcp
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            IF loc_oPg2.txt_4c_AliqFcp.Value < 0 OR loc_oPg2.txt_4c_AliqFcp.Value > 2
                MsgAviso("Valor da Al" + CHR(237) + "quota Inv" + CHR(225) + "lida.", "Aviso")
                loc_oPg2.txt_4c_AliqFcp.SetFocus()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em ValidarAliqFcp:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAreduzida - Valida >= 0 para BIcms (LostFocus)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarAreduzida
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            IF loc_oPg2.txt_4c_Areduzida.Value < 0
                MsgAviso("Valor da Al" + CHR(237) + "quota Inv" + CHR(225) + "lida.", "Aviso")
                loc_oPg2.txt_4c_Areduzida.SetFocus()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em ValidarAreduzida:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarAreduzidaS - Valida >= 0 para BIcmss (LostFocus)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarAreduzidaS
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            IF loc_oPg2.txt_4c_AreduzidaS.Value < 0
                MsgAviso("Valor da Al" + CHR(237) + "quota Inv" + CHR(225) + "lida.", "Aviso")
                loc_oPg2.txt_4c_AreduzidaS.SetFocus()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em ValidarAreduzidaS:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarTemProduto - Verifica se ha produtos com AliqIPI<>0 para este CLF
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE VerificarTemProduto
        LPARAMETERS par_cCodigo
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS QtProd FROM SigCdPro " + ;
                       "WHERE clfiscals = " + EscaparSQL(par_cCodigo)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkProd") > 0
                IF USED("cursor_4c_ChkProd")
                    SELECT cursor_4c_ChkProd
                    THIS.this_lTemProduto = (cursor_4c_ChkProd.QtProd > 0)
                    USE IN cursor_4c_ChkProd
                ELSE
                    THIS.this_lTemProduto = .F.
                ENDIF
            ELSE
                THIS.this_lTemProduto = .F.
            ENDIF
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro em VerificarTemProduto:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarSayIPI - Exibe/oculta lbl_4c__IPI conforme this_lTemProduto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarSayIPI
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            IF PEMSTATUS(loc_oPg2, "lbl_4c__IPI", 5)
                loc_oPg2.lbl_4c__IPI.Visible = THIS.this_lTemProduto
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em AtualizarSayIPI:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme modo atual
    * Modos: LISTA, INCLUIR, ALTERAR, VISUALIZAR
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lModoEdicao, loc_lModoLista
        loc_oPg1 = THIS.pgf_4c_Paginas.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        TRY
            loc_lModoLista  = (THIS.this_cModoAtual = "LISTA")
            loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            *-- Botoes da Page1 (CRUD)
            IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
                WITH loc_oPg1.cnt_4c_Botoes
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
                        .cmd_4c_Incluir.Enabled   = loc_lModoLista
                    ENDIF
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
                        .cmd_4c_Visualizar.Enabled = loc_lModoLista
                    ENDIF
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
                        .cmd_4c_Alterar.Enabled   = loc_lModoLista
                    ENDIF
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
                        .cmd_4c_Excluir.Enabled   = loc_lModoLista
                    ENDIF
                    IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
                        .cmd_4c_Buscar.Enabled    = loc_lModoLista
                    ENDIF
                    .Visible     = .T.
                ENDWITH
            ENDIF

            *-- Botoes da Page2 (Salvar/Cancelar)
            IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesDados", 5)
                WITH loc_oPg2.cnt_4c_BotoesDados
                    IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesDados, "cmd_4c_Salvar", 5)
                        .cmd_4c_Salvar.Enabled   = loc_lModoEdicao
                    ENDIF
                    IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesDados, "cmd_4c_Cancelar", 5)
                        .cmd_4c_Cancelar.Enabled = .T.
                    ENDIF
                    .Visible     = .T.
                ENDWITH
            ENDIF

            *-- Botoes de grid filhos (IVA e Reducao)
            IF PEMSTATUS(loc_oPg2, "cmd_4c_Incluir", 5)
                loc_oPg2.cmd_4c_Incluir.Enabled = loc_lModoEdicao
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_Excluir", 5)
                loc_oPg2.cmd_4c_Excluir.Enabled = loc_lModoEdicao
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_InsRed", 5)
                loc_oPg2.cmd_4c_InsRed.Enabled = loc_lModoEdicao
            ENDIF
            IF PEMSTATUS(loc_oPg2, "cmd_4c_ExcRed", 5)
                loc_oPg2.cmd_4c_ExcRed.Enabled = loc_lModoEdicao
            ENDIF
        CATCH TO loException
            MostrarErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ClfBO.prg):
*==============================================================================
* ClfBO.prg - Business Object para Classificacao Fiscal
* Tabela: SIGCDCLF
* Tabelas filhas: sigcdiva (IVAs por estado), sigcdred (Reducoes por estado)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS ClfBO AS BusinessBase

    *-- Propriedades da entidade (SIGCDCLF)
    this_cCodigo    = ""   && codigos char(10) PK
    this_cDescricao = ""   && descricaos char(40)
    this_nAipi      = 0    && aipis numeric(9,2) - Aliq. IPI padrao
    this_cUnidade   = ""   && unidades char(3)
    this_cAliqReds  = ""   && aliqreds char(1) S/N - Aliquota Reduzida ICMS
    this_cBaseReds  = ""   && basereds char(1) S/N - Base Reduzida ICMS
    this_cIpis      = ""   && ipis char(1) S/N - flag IPI
    this_cSitRibs   = ""   && sitribs char(3) - Situacao Tributaria
    this_nBIcms     = 0    && bicms numeric(9,6) - percentual Base Reduzida ICMS
    this_nIndIVAST  = 0    && indivast numeric(7,3) - IVA-ST SP
    this_cIpiProds  = ""   && ipiprods char(1) S/N - IPI por produto
    this_nTipoMercs = 0    && tipoMercs numeric(2,0) - Codigo Tipo Mercadoria
    this_nTpSubSt   = 0    && TpSubSt numeric(1,0) - 1=IVA 2=Valor Determinado
    this_nBIcmss    = 0    && bicmss numeric(9,6) - Base Reduzida Substituicao
    this_nAliqFcp   = 0    && aliqfcp numeric(6,3) - Aliquota ICMS FCP
    this_cCest      = ""   && cest char(7) - CEST
    this_cUniTrib   = ""   && unitrib char(6) - Unidade Tributaria

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDCLF"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(codigos,    "C")
            THIS.this_cDescricao = TratarNulo(descricaos, "C")
            THIS.this_nAipi      = TratarNulo(aipis,      "N")
            THIS.this_cUnidade   = TratarNulo(unidades,   "C")
            THIS.this_cAliqReds  = TratarNulo(aliqreds,   "C")
            THIS.this_cBaseReds  = TratarNulo(basereds,   "C")
            THIS.this_cIpis      = TratarNulo(ipis,       "C")
            THIS.this_cSitRibs   = TratarNulo(sitribs,    "C")
            THIS.this_nBIcms     = TratarNulo(bicms,      "N")
            THIS.this_nIndIVAST  = TratarNulo(indivast,   "N")
            THIS.this_cIpiProds  = TratarNulo(ipiprods,   "C")
            THIS.this_nTipoMercs = TratarNulo(tipoMercs,  "N")
            THIS.this_nTpSubSt   = TratarNulo(TpSubSt,    "N")
            THIS.this_nBIcmss    = TratarNulo(bicmss,     "N")
            THIS.this_nAliqFcp   = TratarNulo(aliqfcp,    "N")
            THIS.this_cCest      = TratarNulo(cest,        "C")
            THIS.this_cUniTrib   = TratarNulo(unitrib,    "C")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SIGCDCLF
    * par_cFiltro: condicao WHERE adicional (vazio = todos)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT codigos, descricaos, aipis, unidades, cest" + ;
                " FROM SIGCDCLF"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY codigos"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT codigos, descricaos, aipis, unidades," + ;
                " aliqreds, basereds, ipis, sitribs, bicms, indivast," + ;
                " ipiprods, tipoMercs, TpSubSt, bicmss, aliqfcp, cest, unitrib" + ;
                " FROM SIGCDCLF WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarIVAsPorCodigo - Carrega registros de sigcdiva para cursor local
    * Retorna cursor crIva readwrite
    *--------------------------------------------------------------------------
    FUNCTION CarregarIVAsPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM sigcdiva WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpIva_4c")
            IF loc_nResultado >= 0
                IF USED("crIva")
                    SELECT crIva
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR crIva ;
                        (cidchaves C(20), codigos C(10), estasO C(2), estasD C(2), ;
                         indivast N(7,3), indivastpi N(7,3), diasprz N(3,0))
                    SET NULL OFF
                ENDIF
                SELECT TmpIva_4c
                SCAN
                    SELECT crIva
                    APPEND BLANK
                    REPLACE codigos    WITH ALLTRIM(TmpIva_4c.codigos), ;
                            estasO     WITH ALLTRIM(TmpIva_4c.estaso), ;
                            estasD     WITH ALLTRIM(TmpIva_4c.estasd), ;
                            cidchaves  WITH ALLTRIM(TmpIva_4c.cidchaves), ;
                            indivast   WITH TmpIva_4c.indivast, ;
                            indivastpi WITH TmpIva_4c.indivastpi, ;
                            diasprz    WITH TmpIva_4c.diasprz
                ENDSCAN
                USE IN TmpIva_4c
                IF RECCOUNT("crIva") = 0
                    SELECT crIva
                    APPEND BLANK
                ENDIF
                SELECT crIva
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar IVAs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarIVAsPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("TmpIva_4c")
                USE IN TmpIva_4c
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarReducoesPorCodigo - Carrega registros de sigcdred para cursor local
    * Retorna cursor crRed readwrite
    *--------------------------------------------------------------------------
    FUNCTION CarregarReducoesPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM sigcdred WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpRed_4c")
            IF loc_nResultado >= 0
                IF USED("crRed")
                    SELECT crRed
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR crRed ;
                        (cidchaves C(20), codigos C(10), estas C(2), ;
                         areds N(6,3), breds N(6,3))
                    SET NULL OFF
                ENDIF
                SELECT TmpRed_4c
                SCAN
                    SELECT crRed
                    APPEND BLANK
                    REPLACE codigos   WITH ALLTRIM(TmpRed_4c.codigos), ;
                            estas     WITH ALLTRIM(TmpRed_4c.estas), ;
                            cidchaves WITH ALLTRIM(TmpRed_4c.cidchaves), ;
                            areds     WITH TmpRed_4c.areds, ;
                            breds     WITH TmpRed_4c.breds
                ENDSCAN
                USE IN TmpRed_4c
                SELECT crRed
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar Redu" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarReducoesPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("TmpRed_4c")
                USE IN TmpRed_4c
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Validar()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND (THIS.this_nAliqFcp < 0 OR THIS.this_nAliqFcp > 2)
            MsgAviso("Valor da Al" + CHR(237) + "quota FCP Inv" + CHR(225) + "lida. Deve ser entre 0 e 2.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nBIcms < 0
            MsgAviso("Al" + CHR(237) + "quota Base Reduzida ICMS inv" + CHR(225) + "lida.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nBIcmss < 0
            MsgAviso("Al" + CHR(237) + "quota Base Reduzida Substitui" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicata - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtde FROM SIGCDCLF WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dup")
                TABLEREVERT(.T., "cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lExiste = (cursor_4c_Dup.qtde > 0)
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicata:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCidChave
        loc_lResultado = .F.
        TRY
            IF THIS.VerificarDuplicata()
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGCDCLF" + ;
                    " (codigos, descricaos, aipis, unidades, aliqreds, basereds," + ;
                    " ipis, sitribs, bicms, indivast, ipiprods, tipoMercs," + ;
                    " TpSubSt, bicmss, aliqfcp, cest, unitrib)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCodigo)    + ", " + ;
                    EscaparSQL(THIS.this_cDescricao) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nAipi)      + ", " + ;
                    EscaparSQL(THIS.this_cUnidade)   + ", " + ;
                    EscaparSQL(THIS.this_cAliqReds)  + ", " + ;
                    EscaparSQL(THIS.this_cBaseReds)  + ", " + ;
                    EscaparSQL(THIS.this_cIpis)      + ", " + ;
                    EscaparSQL(THIS.this_cSitRibs)   + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBIcms)     + ", " + ;
                    FormatarNumeroSQL(THIS.this_nIndIVAST)  + ", " + ;
                    EscaparSQL(THIS.this_cIpiProds)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTipoMercs) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTpSubSt)   + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBIcmss)    + ", " + ;
                    FormatarNumeroSQL(THIS.this_nAliqFcp)   + ", " + ;
                    EscaparSQL(THIS.this_cCest)      + ", " + ;
                    EscaparSQL(THIS.this_cUniTrib)   + ")"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.SalvarIVAs(THIS.this_cCodigo)
                    THIS.SalvarReducoes(THIS.this_cCodigo)
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SIGCDCLF SET" + ;
                " descricaos = "  + EscaparSQL(THIS.this_cDescricao) + "," + ;
                " aipis = "       + FormatarNumeroSQL(THIS.this_nAipi)     + "," + ;
                " unidades = "    + EscaparSQL(THIS.this_cUnidade)   + "," + ;
                " aliqreds = "    + EscaparSQL(THIS.this_cAliqReds)  + "," + ;
                " basereds = "    + EscaparSQL(THIS.this_cBaseReds)  + "," + ;
                " ipis = "        + EscaparSQL(THIS.this_cIpis)      + "," + ;
                " sitribs = "     + EscaparSQL(THIS.this_cSitRibs)   + "," + ;
                " bicms = "       + FormatarNumeroSQL(THIS.this_nBIcms)    + "," + ;
                " indivast = "    + FormatarNumeroSQL(THIS.this_nIndIVAST) + "," + ;
                " ipiprods = "    + EscaparSQL(THIS.this_cIpiProds)  + "," + ;
                " tipoMercs = "   + FormatarNumeroSQL(THIS.this_nTipoMercs)+ "," + ;
                " TpSubSt = "     + FormatarNumeroSQL(THIS.this_nTpSubSt)  + "," + ;
                " bicmss = "      + FormatarNumeroSQL(THIS.this_nBIcmss)   + "," + ;
                " aliqfcp = "     + FormatarNumeroSQL(THIS.this_nAliqFcp)  + "," + ;
                " cest = "        + EscaparSQL(THIS.this_cCest)      + "," + ;
                " unitrib = "     + EscaparSQL(THIS.this_cUniTrib)   + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.SalvarIVAs(THIS.this_cCodigo)
                THIS.SalvarReducoes(THIS.this_cCodigo)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdiva WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "DELETE FROM sigcdred WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "DELETE FROM SIGCDCLF WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarIVAs - Salva registros do cursor crIva em sigcdiva
    * Estrategia: DELETE todos os IVAs do codigo + INSERT dos do cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarIVAs(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cCidChave, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdiva WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            SQLEXEC(gnConnHandle, loc_cSQL)
            IF USED("crIva")
                SELECT crIva
                SCAN
                    IF !EMPTY(ALLTRIM(crIva.estasO)) OR !EMPTY(ALLTRIM(crIva.estasD))
                        loc_cCidChave = SYS(2015)
                        loc_cSQL = "INSERT INTO sigcdiva" + ;
                            " (cidchaves, codigos, estaso, estasd, indivast, indivastpi, diasprz)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cCidChave)            + ", " + ;
                            EscaparSQL(ALLTRIM(par_cCodigo))     + ", " + ;
                            EscaparSQL(ALLTRIM(crIva.estasO))    + ", " + ;
                            EscaparSQL(ALLTRIM(crIva.estasD))    + ", " + ;
                            FormatarNumeroSQL(crIva.indivast)    + ", " + ;
                            FormatarNumeroSQL(crIva.indivastpi)  + ", " + ;
                            FormatarNumeroSQL(crIva.diasprz)     + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar IVA:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.SalvarIVAs:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarReducoes - Salva registros do cursor crRed em sigcdred
    * Estrategia: DELETE todas as reducoes do codigo + INSERT dos do cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarReducoes(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cCidChave, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdred WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            SQLEXEC(gnConnHandle, loc_cSQL)
            IF USED("crRed")
                SELECT crRed
                SCAN
                    IF !EMPTY(ALLTRIM(crRed.estas))
                        loc_cCidChave = SYS(2015)
                        loc_cSQL = "INSERT INTO sigcdred" + ;
                            " (cidchaves, codigos, estas, areds, breds)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cCidChave)         + ", " + ;
                            EscaparSQL(ALLTRIM(par_cCodigo))  + ", " + ;
                            EscaparSQL(ALLTRIM(crRed.estas))  + ", " + ;
                            FormatarNumeroSQL(crRed.areds)    + ", " + ;
                            FormatarNumeroSQL(crRed.breds)    + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar Redu" + CHR(231) + CHR(227) + "o:" + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.SalvarReducoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarTemProduto - Verifica se existem produtos com aliquota IPI
    * Retorna .T. se ha produtos com IPI associados a este codigo
    *--------------------------------------------------------------------------
    FUNCTION VerificarTemProduto(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lTem
        loc_lTem = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtde FROM SigCdPro" + ;
                " WHERE clfiscals = " + EscaparSQL(ALLTRIM(par_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmPro")
                TABLEREVERT(.T., "cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmPro")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_TmPro") > 0
                SELECT cursor_4c_TmPro
                loc_lTem = (cursor_4c_TmPro.qtde > 0)
            ENDIF
            IF USED("cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.VerificarTemProduto:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF
        ENDTRY
        RETURN loc_lTem
    ENDFUNC

ENDDEFINE

