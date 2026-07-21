# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 3/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'CarregarLista': Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-15 08:43:48] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 08:43:48] [INFO] Config FPW: (nao fornecido)
[2026-07-15 08:43:48] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 08:43:48] [INFO] Timeout: 300 segundos
[2026-07-15 08:43:48] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1dq55ki4.prg
[2026-07-15 08:43:48] [INFO] Conteudo do wrapper:
[2026-07-15 08:43:48] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'
QUIT

[2026-07-15 08:43:48] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1dq55ki4.prg
[2026-07-15 08:43:48] [INFO] VFP output esperado em: C:\4c\tasks\task268\vfp_output.txt
[2026-07-15 08:43:48] [INFO] Executando Visual FoxPro 9...
[2026-07-15 08:43:48] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1dq55ki4.prg
[2026-07-15 08:43:48] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1dq55ki4.prg
[2026-07-15 08:43:48] [INFO] Timeout configurado: 300 segundos
[2026-07-15 08:44:07] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 08:44:07] [INFO] VFP9 finalizado em 19.7765749 segundos
[2026-07-15 08:44:07] [INFO] Exit Code: 
[2026-07-15 08:44:07] [INFO] 
[2026-07-15 08:44:07] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 08:44:07] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1dq55ki4.prg
[2026-07-15 08:44:07] [INFO] 
[2026-07-15 08:44:07] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 08:44:07] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 08:44:07] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 08:44:07] [INFO] * Parameters: 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'
[2026-07-15 08:44:07] [INFO] 
[2026-07-15 08:44:07] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 08:44:07] [INFO] SET SAFETY OFF
[2026-07-15 08:44:07] [INFO] SET RESOURCE OFF
[2026-07-15 08:44:07] [INFO] SET TALK OFF
[2026-07-15 08:44:07] [INFO] SET NOTIFY OFF
[2026-07-15 08:44:07] [INFO] SYS(2335, 0)
[2026-07-15 08:44:08] [INFO] 
[2026-07-15 08:44:08] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'
[2026-07-15 08:44:08] [INFO] QUIT
[2026-07-15 08:44:08] [INFO] 
[2026-07-15 08:44:08] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 08:44:08] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-15 08:44:58] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 08:44:58] [INFO] Config FPW: (nao fornecido)
[2026-07-15 08:44:58] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 08:44:58] [INFO] Timeout: 300 segundos
[2026-07-15 08:44:58] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ndqsijd.prg
[2026-07-15 08:44:58] [INFO] Conteudo do wrapper:
[2026-07-15 08:44:58] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'
QUIT

[2026-07-15 08:44:58] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ndqsijd.prg
[2026-07-15 08:44:58] [INFO] VFP output esperado em: C:\4c\tasks\task268\vfp_output.txt
[2026-07-15 08:44:58] [INFO] Executando Visual FoxPro 9...
[2026-07-15 08:44:58] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ndqsijd.prg
[2026-07-15 08:44:58] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ndqsijd.prg
[2026-07-15 08:44:58] [INFO] Timeout configurado: 300 segundos
[2026-07-15 08:45:21] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 08:45:21] [INFO] VFP9 finalizado em 23.1195196 segundos
[2026-07-15 08:45:21] [INFO] Exit Code: 
[2026-07-15 08:45:21] [INFO] 
[2026-07-15 08:45:21] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 08:45:21] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1ndqsijd.prg
[2026-07-15 08:45:21] [INFO] 
[2026-07-15 08:45:21] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 08:45:21] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 08:45:21] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 08:45:21] [INFO] * Parameters: 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'
[2026-07-15 08:45:21] [INFO] 
[2026-07-15 08:45:21] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 08:45:21] [INFO] SET SAFETY OFF
[2026-07-15 08:45:21] [INFO] SET RESOURCE OFF
[2026-07-15 08:45:21] [INFO] SET TALK OFF
[2026-07-15 08:45:21] [INFO] SET NOTIFY OFF
[2026-07-15 08:45:21] [INFO] SYS(2335, 0)
[2026-07-15 08:45:21] [INFO] 
[2026-07-15 08:45:21] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'
[2026-07-15 08:45:21] [INFO] QUIT
[2026-07-15 08:45:21] [INFO] 
[2026-07-15 08:45:21] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 08:45:21] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-15 08:47:19] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 08:47:19] [INFO] Config FPW: (nao fornecido)
[2026-07-15 08:47:19] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 08:47:19] [INFO] Timeout: 300 segundos
[2026-07-15 08:47:19] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rb2ta245.prg
[2026-07-15 08:47:19] [INFO] Conteudo do wrapper:
[2026-07-15 08:47:19] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'
QUIT

[2026-07-15 08:47:19] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rb2ta245.prg
[2026-07-15 08:47:19] [INFO] VFP output esperado em: C:\4c\tasks\task268\vfp_output.txt
[2026-07-15 08:47:19] [INFO] Executando Visual FoxPro 9...
[2026-07-15 08:47:19] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rb2ta245.prg
[2026-07-15 08:47:19] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rb2ta245.prg
[2026-07-15 08:47:19] [INFO] Timeout configurado: 300 segundos
[2026-07-15 08:47:42] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 08:47:42] [INFO] VFP9 finalizado em 23.0967781 segundos
[2026-07-15 08:47:42] [INFO] Exit Code: 
[2026-07-15 08:47:42] [INFO] 
[2026-07-15 08:47:42] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 08:47:42] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rb2ta245.prg
[2026-07-15 08:47:42] [INFO] 
[2026-07-15 08:47:42] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 08:47:42] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 08:47:42] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 08:47:42] [INFO] * Parameters: 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'
[2026-07-15 08:47:42] [INFO] 
[2026-07-15 08:47:42] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 08:47:42] [INFO] SET SAFETY OFF
[2026-07-15 08:47:42] [INFO] SET RESOURCE OFF
[2026-07-15 08:47:42] [INFO] SET TALK OFF
[2026-07-15 08:47:42] [INFO] SET NOTIFY OFF
[2026-07-15 08:47:42] [INFO] SYS(2335, 0)
[2026-07-15 08:47:42] [INFO] 
[2026-07-15 08:47:42] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprcom', 'C:\4c\tasks\task268', 'CRUD'
[2026-07-15 08:47:42] [INFO] QUIT
[2026-07-15 08:47:42] [INFO] 
[2026-07-15 08:47:42] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 08:47:42] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigprcom",
  "timestamp": "20260715084742",
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
      "detalhes": "AbrirLookup: 3 (ABRIRLOOKUPCOR, ABRIRLOOKUPDEPTO, ABRIRLOOKUPTAMANHO) | KeyPress handlers: 5 (CORKEYPRESS, DPTKEYPRESS, KEYPRESS, PRODUTOKEYPRESS, TAMKEYPRESS) | Campos lookup: 1"
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
    "passou": 8,
    "falhou": 1,
    "percentual": 89
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg):
*==============================================================================
* Formsigprcom.prg - Formulario Estoque M" + CHR(225) + "ximo
* Tabela: SigCdMax | PK: cidchaves
* Legado: SIGPRCOM.SCX (frmcadastro)
*
* ARQUITETURA:
*   Page1 (Lista) - Grid de produtos (SigCdPro) para selecao
*   Page2 (Dados) - Campos do produto + gradei (SigCdMax) para edicao de maximos
*
* CHAMADA EXTERNA:
*   CREATEOBJECT("Formsigprcom")                          -> modo normal (lista)
*   CREATEOBJECT("Formsigprcom", cCPros, "", cEsc, ...)  -> modo externo (produto fixo)
*==============================================================================

DEFINE CLASS Formsigprcom AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height       = 675
    Width        = 1000
    Caption      = "Estoque Maximo"
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
    FontName     = "Tahoma"
    ForeColor    = RGB(90, 90, 90)
    DataSession  = 2

    *-- Business Object e estado
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""
    this_cModoAtual      = "LISTA"

    *-- Propriedades de chamada externa (equivalentes as propriedades legadas pProduto/pcExterno)
    this_cPProduto  = ""   && c" + CHR(243) + "digo do produto quando chamado externamente
    this_cPExterno  = ""   && identificador do chamador externo (pcEsc)
    this_cPCPros    = ""   && c" + CHR(243) + "digo do produto padded (14 chars)
    this_cPDPros    = ""   && descri" + CHR(231) + CHR(227) + "o do produto
    this_cPCGrus    = ""   && c" + CHR(243) + "digo do grupo
    this_cPIFors    = ""   && c" + CHR(243) + "digo do fornecedor
    this_cPReffs    = ""   && refer" + CHR(234) + "ncia do produto
    this_lPCancelar = .F.  && indica" + CHR(231) + CHR(227) + "o de cancelamento

    *-- Propriedades de controle de varia" + CHR(231) + CHR(245) + "es do produto
    this_lTemCor    = .F.  && produto possui varia" + CHR(231) + CHR(227) + "o de cor
    this_lTemTam    = .F.  && produto possui varia" + CHR(231) + CHR(227) + "o de tamanho
    this_nTipoEstos = 0    && tipo de estoque (0=sem, 1=tam, 2=cor, 3=tam+cor)

    *-- Modo de opera" + CHR(231) + CHR(227) + "o atual
    this_cPCEscolha = ""   && modo atual: INSERIR/ALTERAR/PROCURAR

    *-- Permiss" + CHR(245) + "es de acesso
    this_lAcCopiar  = .F.  && usu" + CHR(225) + "rio tem permiss" + CHR(227) + "o de copiar entre empresas

    *--------------------------------------------------------------------------
    * Init - Inicializa form; suporta chamada externa com par" + CHR(226) + "metros de produto
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_cAcesso, par_cPcForm, par_cPcEsc, par_cPDPros, par_cPCGrus, par_cPIFors, par_cPReffs
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Capturar par" + CHR(226) + "metros de chamada externa ANTES de DODEFAULT
            IF TYPE("par_cAcesso") = "C" AND !EMPTY(par_cAcesso)
                THIS.this_cPProduto = ALLTRIM(par_cAcesso)
                THIS.this_cPCPros   = PADR(ALLTRIM(par_cAcesso), 14)
            ENDIF

            IF TYPE("par_cPcEsc") = "C" AND !EMPTY(par_cPcEsc) ;
               AND TYPE("par_cAcesso") = "C" AND !EMPTY(par_cAcesso)
                THIS.this_cPExterno = par_cPcEsc
                THIS.this_cPDPros   = TratarNulo(par_cPDPros, "C")
                THIS.this_cPCGrus   = TratarNulo(par_cPCGrus, "C")
                THIS.this_cPIFors   = TratarNulo(par_cPIFors, "C")
                THIS.this_cPReffs   = TratarNulo(par_cPReffs, "C")
            ENDIF

            *-- DODEFAULT() chama FormBase.Init() que chama THIS.InicializarForm()
            loc_lSucesso = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro("Erro em Formsigprcom.Init: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura" + CHR(231) + CHR(227) + "o inicial do formulario
    * Chamado automaticamente por FormBase.Init() via DODEFAULT()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprcomBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O" OR ISNULL(THIS.this_oBusinessObject)
                MostrarErro("Erro ao criar Business Object sigprcomBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                *-- Corrigir Caption com acento (CHR nao pode ser usado em DEFINE CLASS)
                THIS.Caption = "Estoque M" + CHR(225) + "ximo"

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Propagar Caption para labels do cabe" + CHR(231) + "alho
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption

                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    *-- Modo externo: produto j" + CHR(225) + " definido, ir direto para Page2
                    IF !EMPTY(THIS.this_cPCPros)
                        THIS.this_cPCEscolha = "ALTERAR"
                        THIS.this_cModoAtual  = "DADOS"
                        THIS.pgf_4c_Paginas.Visible    = .T.
                        THIS.pgf_4c_Paginas.ActivePage = 2
                        *-- Fases 5-8 completam carga dos dados do produto no Dados
                    ELSE
                        *-- Modo normal: listar produtos na Page1
                        IF !THIS.CarregarLista()
                            *-- Falha ao carregar nao impede abertura
                        ENDIF
                        THIS.pgf_4c_Paginas.Visible    = .T.
                        THIS.pgf_4c_Paginas.ActivePage = 1
                        THIS.this_cModoAtual = "LISTA"
                    ENDIF
                ELSE
                    THIS.pgf_4c_Paginas.Visible    = .T.
                    THIS.pgf_4c_Paginas.ActivePage = 1
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loc_oErro.LineNo) + " - " + loc_oErro.Message
            MostrarErro("Erro ao inicializar Formsigprcom:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura PageFrame principal
    * PageFrame.Top=-29 para ocultar abas; controles compensam +29 no Top
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 704   && 675 (form.Height) + 29 (compensacao abas)
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .F.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista de produtos)
    * Fase 3: containers principais; Fase 4 adiciona grid e bot" + CHR(245) + "es CRUD
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabe" + CHR(231) + "alho (equivalente ao cntSombra do legado)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 1 + 29   && compensacao PageFrame (cntSombra.Top=1)
            .Left        = -1
            .Width       = 1008
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Label sombra (offset 2px para efeito de sombra)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .AutoSize  = .F.
            .Top       = 15
            .Left      = 12
            .Width     = 980
            .Height    = 40
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Label titulo (branco sobre fundo escuro)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .AutoSize  = .F.
            .Top       = 18
            .Left      = 10
            .Width     = 980
            .Height    = 46
            .Caption   = THIS.Caption
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- Container de bot" + CHR(245) + "es CRUD (equivalente ao Grupo_op do legado)
        *-- Grupo_op.Left=544, Grupo_op.Top=-1 + compensacao +29 = 28
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = -1 + 29   && 28
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Container de sa" + CHR(237) + "da (padrao canonico - PREVALECE sobre PILAR 1)
        *-- Grupo_Saida.Left=919, Top=-1 -> canonico: Left=917, Width=90
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = -1 + 29   && 28
            .Left        = 917
            .Width       = 90
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Bot" + CHR(227) + "o Copiar Produto (btnCopiar.Left=474, Top=4 + 29 = 33)
        *-- Fora do Grupo_op, posicionado diretamente na Page1
        loc_oPagina.AddObject("cmd_4c_BtnCopiar", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnCopiar
            .Top             = 5 + 29    && 34
            .Left            = 474
            .Width           = 75
            .Height          = 75
            .Caption         = "Copiar Produto"
            .Picture         = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .ToolTipText     = "Copia Produto"
            .Visible         = .T.
        ENDWITH

        *-- Container de c" + CHR(243) + "pia entre empresas (cntCopia - inicia oculto)
        *-- Top=161 + 29=190 (compensacao PageFrame)
        loc_oPagina.AddObject("cnt_4c_Copia", "Container")
        WITH loc_oPagina.cnt_4c_Copia
            .Top           = 161 + 29   && 190
            .Left          = 256
            .Width         = 486
            .Height        = 373
            .SpecialEffect = 0
            .BackColor     = RGB(255, 255, 255)
            .BackStyle     = 1
            .Visible       = .F.    && Inicia oculto - aparece ao clicar "Copiar Produto"
            .BorderWidth   = 1
        ENDWITH

        *-- ===== BOTOES CRUD dentro de cnt_4c_Botoes (Lefts: 5,80,155,230,305) =====
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Inserir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Inserir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Top             = 5
            .Left            = 155
            .Width           = 75
            .Height          = 75
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Top             = 5
            .Left            = 230
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Top             = 5
            .Left            = 305
            .Width           = 75
            .Height          = 75
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        *-- Botao Encerrar no cnt_4c_Saida (padrao canonico)
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        *-- ===== GRID Principal: lista de produtos (SigCdPro) para selecao =====
        *-- Top=88+29=117 (compensacao PageFrame), Left=26, Width=860
        *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 5
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 88 + 29   && 117
            .Left               = 26
            .Width              = 860
            .Height             = 553
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
            *-- Larguras das colunas (headers configurados em CarregarLista)
            *-- Legado: cpros(108), dpros(285), ifors(75), reffs(150), sgrus(45)
            .Column1.Width = 100
            .Column2.Width = 360
            .Column3.Width = 100
            .Column4.Width = 165
            .Column5.Width = 65
        ENDWITH

        *-- ===== Conteudo do painel de copia (cnt_4c_Copia) =====
        *-- Labels de identificacao das empresas
        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Lbl_empresa", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Lbl_empresa
            .Top       = 35
            .Left      = 35
            .Width     = 87
            .Height    = 17
            .Caption   = "Empresa Origem :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label2
            .Top       = 60
            .Left      = 33
            .Width     = 89
            .Height    = 17
            .Caption   = "Empresa Destino :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label1
            .Top       = 85
            .Left      = 35
            .Width     = 85
            .Height    = 17
            .Caption   = "Procura Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- TextBoxes de filtro da copia
        loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_EmpOs", "TextBox")
        WITH loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs
            .Top       = 31
            .Left      = 124
            .Width     = 31
            .Height    = 23
            .InputMask = "XXX"
            .Value     = ""
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_EmpDs", "TextBox")
        WITH loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs
            .Top       = 56
            .Left      = 124
            .Width     = 31
            .Height    = 23
            .InputMask = "XXX"
            .Value     = ""
            .MaxLength = 3
            .Enabled   = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_Produto", "TextBox")
        WITH loc_oPagina.cnt_4c_Copia.txt_4c_Produto
            .Top       = 81
            .Left      = 124
            .Width     = 108
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Botoes de acao do painel de copia
        loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CmdProcessa", "CommandButton")
        WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CmdProcessa
            .Top             = 5
            .Left            = 256
            .Width           = 75
            .Height          = 75
            .Caption         = "\<Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CmdCopiar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CmdCopiar
            .Top             = 5
            .Left            = 332
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirma"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CmdSair", "CommandButton")
        WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CmdSair
            .Top             = 5
            .Left            = 407
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        *-- Grid de itens da copia (GrdItens - 6 colunas)
        *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
        loc_oPagina.cnt_4c_Copia.AddObject("grd_4c_DadosCopia", "Grid")
        loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.RecordSource = ""
        loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.ColumnCount  = 6
        WITH loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia
            .Top              = 131
            .Left             = 27
            .Width            = 403
            .Height           = 184
            .FontName         = "Tahoma"
            .FontSize         = 8
            .BackColor        = RGB(255, 255, 255)
            .GridLineColor    = RGB(238, 238, 238)
            .HighlightStyle   = 2
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .RowHeight        = 16
            .ScrollBars       = 2
            .GridLines        = 3
            .Visible          = .T.
            *-- Column1: CheckBox de selecao (Sparse=.F. obrigatorio para mostrar em todas as linhas)
            .Column1.Width    = 30
            .Column1.Sparse   = .F.
            *-- Column2..6: campos de dados
            .Column2.Width    = 70
            .Column3.Width    = 65
            .Column4.Width    = 50
            .Column5.Width    = 50
            .Column6.Width    = 120
            *-- Headers (serao reconfigurados em BtnProcessarCopiaClick apos RecordSource)
            .Column1.Header1.Caption = ""
            .Column2.Header1.Caption = "Produto"
            .Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
            .Column4.Header1.Caption = "Tam"
            .Column5.Header1.Caption = "Cor"
            .Column6.Header1.Caption = "Departamento"
        ENDWITH

        *-- CheckBox na Column1 do grd_4c_DadosCopia
        loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.Column1.AddObject("chk_4c_Check1", "CheckBox")
        WITH loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.Column1.chk_4c_Check1
            .Caption = ""
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible  = .T.
        ENDWITH
        loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.Column1.CurrentControl = "chk_4c_Check1"

        *-- Botoes Marcar/Desmarcar (standalone com icone - Themes=.T. obrigatorio)
        loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_Marcar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Copia.cmd_4c_Marcar
            .Top             = 234
            .Left            = 434
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .PicturePosition = 13
            .Themes          = .T.
            .SpecialEffect   = 0
            .ToolTipText     = "Selecionar todos"
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_Desmarcar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Copia.cmd_4c_Desmarcar
            .Top             = 274
            .Left            = 434
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 13
            .Themes          = .T.
            .SpecialEffect   = 0
            .ToolTipText     = "Desmarcar todos"
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        *-- Labels de legenda de cores (Vermelho/Azul/Preto)
        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label3
            .Top       = 317
            .Left      = 40
            .Width     = 74
            .Height    = 15
            .Caption   = "Vermelho : "
            .ForeColor = RGB(255, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label4
            .Top       = 317
            .Left      = 118
            .Width     = 250
            .Height    = 15
            .Caption   = "Produtos existem na Origem e no Destino."
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label6
            .Top       = 333
            .Left      = 45
            .Width     = 70
            .Height    = 15
            .Caption   = "Azul : "
            .ForeColor = RGB(0, 0, 255)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label5
            .Top       = 333
            .Left      = 118
            .Width     = 274
            .Height    = 15
            .Caption   = "Produtos existem no Destino mas n" + CHR(227) + "o existem na Origem"
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label7
            .Top       = 349
            .Left      = 45
            .Width     = 70
            .Height    = 15
            .Caption   = "Preto : "
            .ForeColor = RGB(0, 0, 0)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label8
            .Top       = 349
            .Left      = 118
            .Width     = 274
            .Height    = 15
            .Caption   = "Produtos existem na Origem mas n" + CHR(227) + "o existem no Destino"
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- ===== BINDEVENTs dos botoes CRUD (Page1) =====
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_BtnCopiar,                "Click", THIS, "BtnCopiarClick")

        *-- BINDEVENTs dos botoes do painel de copia
        BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdProcessa, "Click", THIS, "BtnProcessarCopiaClick")
        BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdCopiar,   "Click", THIS, "BtnConfirmarCopiaClick")
        BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdSair,     "Click", THIS, "BtnSairCopiaClick")
        BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_Marcar,      "Click", THIS, "BtnMarcarCopiaClick")
        BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_Desmarcar,   "Click", THIS, "BtnDesmarcarCopiaClick")

        *-- BINDEVENT para LostFocus de EmpOs (habilita EmpDs quando preenchido)
        BINDEVENT(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs, "KeyPress", THIS, "EmpOsLostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados do produto + grade de maximos)
    * Fase 5: botoes acao + labels + textboxes produto/grupo + optiongroup situacao
    * Fase 6: textboxes fornecedor/ref + botao excluir + gradei
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container de botoes de acao (Confirmar/Cancelar)
        *-- Grupo_Salva.Left=843, Grupo_Salva.Top=-3 + 29 = 26
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = -3 + 29   && 26
            .Left        = 843
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (salva maximos e volta para lista)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Confirmar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        *-- Botao Cancelar (descarta e volta para lista)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH

        *-- ===== LABELS (primeira metade: produto, grupo, fornecedor, ref, situacao) =====
        *-- Label Produto (Say1): top=79+29=108, left=260, width=47
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Top       = 79 + 29
            .Left      = 260
            .Width     = 47
            .Height    = 15
            .Caption   = "Produto :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Grupo (Say8): top=105+29=134, left=269, width=38
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Top       = 105 + 29
            .Left      = 269
            .Width     = 38
            .Height    = 15
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Fornecedor (Say11): top=130+29=159, left=243, width=64
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Top       = 130 + 29
            .Left      = 243
            .Width     = 64
            .Height    = 15
            .Caption   = "Fornecedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Ref. Fornecedor (Say12): top=156+29=185, left=219, width=88
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Top       = 156 + 29
            .Left      = 219
            .Width     = 88
            .Height    = 15
            .Caption   = "Ref. Fornecedor :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Situacao (Say19): top=105+29=134, left=505
        loc_oPagina.AddObject("lbl_4c_Label19", "Label")
        WITH loc_oPagina.lbl_4c_Label19
            .Top       = 105 + 29
            .Left      = 505
            .Width     = 50
            .Height    = 15
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- ===== TEXTBOXES - PRODUTO (primeira metade) =====
        *-- txt_4c__produto (get_produto): codigo do produto - editavel em INSERIR/PROCURAR
        *-- top=75+29=104, left=309, width=108, height=23
        loc_oPagina.AddObject("txt_4c__produto", "TextBox")
        WITH loc_oPagina.txt_4c__produto
            .Top       = 75 + 29
            .Left      = 309
            .Width     = 108
            .Height    = 23
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Dpro (getDpro): descricao do produto - somente leitura
        *-- top=75+29=104, left=419, width=360, height=23
        loc_oPagina.AddObject("txt_4c_Dpro", "TextBox")
        WITH loc_oPagina.txt_4c_Dpro
            .Top       = 75 + 29
            .Left      = 419
            .Width     = 360
            .Height    = 23
            .Value     = ""
            .ReadOnly  = .T.
            .BackColor = RGB(220, 220, 220)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- ===== TEXTBOXES - GRUPO (primeira metade) =====
        *-- txt_4c_Cgru (getCgru): codigo do grupo - somente leitura
        *-- top=101+29=130, left=309, width=31, height=23
        loc_oPagina.AddObject("txt_4c_Cgru", "TextBox")
        WITH loc_oPagina.txt_4c_Cgru
            .Top       = 101 + 29
            .Left      = 309
            .Width     = 31
            .Height    = 23
            .Value     = ""
            .ReadOnly  = .T.
            .BackColor = RGB(220, 220, 220)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Dgru (getDgru): descricao do grupo - somente leitura
        *-- top=101+29=130, left=343, width=150, height=23
        loc_oPagina.AddObject("txt_4c_Dgru", "TextBox")
        WITH loc_oPagina.txt_4c_Dgru
            .Top       = 101 + 29
            .Left      = 343
            .Width     = 150
            .Height    = 23
            .Value     = ""
            .ReadOnly  = .T.
            .BackColor = RGB(220, 220, 220)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- ===== OPTIONGROUP Situacao (Opc_situacao) - somente leitura (When=.F. no legado) =====
        *-- top=100+29=129, left=555, width=117, height=25; ButtonCount=2 (1=Ativo, 2=Inativo)
        loc_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
        WITH loc_oPagina.obj_4c_Opc_situacao
            .Top         = 100 + 29
            .Left        = 555
            .Width       = 117
            .Height      = 25
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1
            .Visible     = .T.
            WITH .Buttons(1)
                .Caption   = "Ativo"
                .Left      = 5
                .Top       = 5
                .Width     = 50
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Inativo"
                .Left      = 58
                .Top       = 5
                .Width     = 55
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- ===== TEXTBOXES - FORNECEDOR/REFERENCIA (Fase 6) =====
        *-- txt_4c_Ifor: codigo do fornecedor - somente leitura (top=130+29=159)
        loc_oPagina.AddObject("txt_4c_Ifor", "TextBox")
        WITH loc_oPagina.txt_4c_Ifor
            .Top       = 130 + 29
            .Left      = 309
            .Width     = 80
            .Height    = 23
            .Value     = ""
            .ReadOnly  = .T.
            .BackColor = RGB(220, 220, 220)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Dfor: nome do fornecedor - somente leitura (top=130+29=159)
        loc_oPagina.AddObject("txt_4c_Dfor", "TextBox")
        WITH loc_oPagina.txt_4c_Dfor
            .Top       = 130 + 29
            .Left      = 392
            .Width     = 220
            .Height    = 23
            .Value     = ""
            .ReadOnly  = .T.
            .BackColor = RGB(220, 220, 220)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Refs: referencia do fornecedor - somente leitura (top=156+29=185)
        loc_oPagina.AddObject("txt_4c_Refs", "TextBox")
        WITH loc_oPagina.txt_4c_Refs
            .Top       = 156 + 29
            .Left      = 309
            .Width     = 150
            .Height    = 23
            .Value     = ""
            .ReadOnly  = .T.
            .BackColor = RGB(220, 220, 220)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- ===== BOTAO EXCLUIR LINHAS (Fase 6) =====
        *-- cmd_4c_BtnExcluir: exclui linhas da empresa corrente na grade
        loc_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnExcluir
            .Top             = 414
            .Left            = 700
            .Width           = 40
            .Height          = 40
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .PicturePosition = 7
            .Themes          = .T.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .ToolTipText     = "Excluir linhas desta empresa"
            .Visible         = .T.
        ENDWITH

        *-- ===== GRADE DE MAXIMOS (Fase 6) =====
        *-- grd_4c_Gradei: grade de maximos por empresa/qtde/tamanho/cor/departamento
        *-- top=181+29=210, left=309, width=387, height=472
        loc_oPagina.AddObject("grd_4c_Gradei", "Grid")

        *-- RecordSource e ColumnCount FORA de WITH (Problema 36)
        loc_oPagina.grd_4c_Gradei.RecordSource = ""
        loc_oPagina.grd_4c_Gradei.ColumnCount  = 5

        WITH loc_oPagina.grd_4c_Gradei
            .Top          = 181 + 29
            .Left         = 309
            .Width        = 387
            .Height       = 472
            .ReadOnly     = .F.
            .DeleteMark   = .F.
            .RecordMark   = .F.
            .GridLines    = 1
            .HeaderHeight = 20
            .RowHeight    = 19
            .FontName     = "Tahoma"
            .FontSize     = 8
            .Visible      = .T.

            WITH .Column1
                .ControlSource = ""
                .Width         = 40
                .Sparse        = .F.
                WITH .Header1
                    .Caption  = "Empresa"
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .FontBold = .T.
                ENDWITH
                WITH .Text1
                    .Value    = ""
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            WITH .Column2
                .ControlSource = ""
                .Width         = 65
                .Sparse        = .F.
                WITH .Header1
                    .Caption  = "Qtde.M" + CHR(225) + "x."
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .FontBold = .T.
                ENDWITH
                WITH .Text1
                    .Value    = 0
                    .Format   = "9999.99"
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            WITH .Column3
                .ControlSource = ""
                .Width         = 55
                .Sparse        = .F.
                WITH .Header1
                    .Caption  = "Tam."
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .FontBold = .T.
                ENDWITH
                WITH .Text1
                    .Value    = ""
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            WITH .Column4
                .ControlSource = ""
                .Width         = 55
                .Sparse        = .F.
                WITH .Header1
                    .Caption  = "Cor"
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .FontBold = .T.
                ENDWITH
                WITH .Text1
                    .Value    = ""
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH
            ENDWITH

            WITH .Column5
                .ControlSource = ""
                .Width         = 172
                .Sparse        = .F.
                WITH .Header1
                    .Caption  = "Departamento"
                    .FontName = "Tahoma"
                    .FontSize = 8
                    .FontBold = .T.
                ENDWITH
                WITH .Text1
                    .Value    = ""
                    .FontName = "Tahoma"
                    .FontSize = 8
                ENDWITH
            ENDWITH
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- BINDEVENTs dos botoes de Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- BINDEVENT para busca de produto via F4
        BINDEVENT(loc_oPagina.txt_4c__produto, "KeyPress", THIS, "ProdutoKeyPress")

        *-- BINDEVENTs da grade de maximos (Fase 6)
        BINDEVENT(loc_oPagina.cmd_4c_BtnExcluir,             "Click",             THIS, "BtnExcluirGradeClick")
        BINDEVENT(loc_oPagina.grd_4c_Gradei,                 "AfterRowColChange", THIS, "GradeIAfterRowColChange")
        BINDEVENT(loc_oPagina.grd_4c_Gradei.Column2.Text1,   "KeyPress",         THIS, "QmaxsLostFocus")
        BINDEVENT(loc_oPagina.grd_4c_Gradei.Column3.Text1,   "KeyPress",          THIS, "TamKeyPress")
        BINDEVENT(loc_oPagina.grd_4c_Gradei.Column4.Text1,   "KeyPress",          THIS, "CorKeyPress")
        BINDEVENT(loc_oPagina.grd_4c_Gradei.Column5.Text1,   "KeyPress",          THIS, "DptKeyPress")
        BINDEVENT(loc_oPagina.grd_4c_Gradei.Column5.Text1,   "KeyPress",         THIS, "GradeICol5LostFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega cursor de produtos na Page1 e configura grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (cpros C(14), dpros C(65), ifors C(10), reffs C(40), sgrus C(3))
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    IF USED("cursor_4c_Dados")
                        GO TOP IN cursor_4c_Dados

                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                        *-- RecordSource FORA de WITH (Problema 36 - garante colunas existentes)
                        *-- Estrutura identica ao legado: cpros, dpros, ifors, reffs, sgrus (5 colunas)
                        loc_oGrid.ColumnCount = 5
                        loc_oGrid.RecordSource = "cursor_4c_Dados"

                        *-- ControlSource de cada coluna (identico ao legado)
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.ifors"
                        loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.reffs"
                        loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.sgrus"

                        *-- Headers: OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
                        *-- Identicos ao legado (pColuna: Produto, Descricao, Fornecedor, Referencia, Sub Grp)
                        loc_oGrid.Column1.Header1.Caption = "Produto"
                        loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column3.Header1.Caption = "Fornecedor"
                        loc_oGrid.Column4.Header1.Caption = "Refer" + CHR(234) + "ncia"
                        loc_oGrid.Column5.Header1.Caption = "Sub Grp"

                        THIS.FormatarGridLista(loc_oGrid)
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarLista: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles de um container visiveis
    * Itera recursivamente Pages e Controls
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cNome
        loc_cNome = ""

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- Containers flutuantes/ocultos por design: recursar filhos mas NAO forcar Visible
                IF INLIST(loc_cNome, "CNT_4C_COPIA", "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                *-- Tratar PageFrame: iterar Pages
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Tratar containers com ControlCount
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista de produtos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_Max")
            USE IN cursor_4c_Max
        ENDIF

        IF USED("cursor_4c_Copia")
            USE IN cursor_4c_Copia
        ENDIF

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (lista) e Page2 (dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.this_cModoAtual = "LISTA"
            ELSE
                THIS.this_cModoAtual = "DADOS"
                THIS.AjustarCamposPorModo()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em AlternarPagina: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Navega para Page2 em modo INSERIR
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_cPCEscolha = "INSERIR"
            THIS.LimparCampos()
            THIS.CarregarGradeMaximos("")
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro("Erro em BtnIncluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualiza produto selecionado em Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado, loc_cCpros
        loc_lResultado = .F.
        loc_cCpros     = ""

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
                IF EMPTY(loc_cCpros)
                    MsgAviso("Selecione um produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.this_cPCPros    = PADR(loc_cCpros, 14)
                    THIS.this_cPCEscolha = "CONSULTAR"
                    THIS.CarregarInfoProduto(loc_cCpros)
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                ENDIF
            ELSE
                MsgAviso("Nenhum produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnVisualizarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Abre produto selecionado para edicao em Page2
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado, loc_cCpros
        loc_lResultado = .F.
        loc_cCpros     = ""

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
                IF EMPTY(loc_cCpros)
                    MsgAviso("Selecione um produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    THIS.this_cPCPros    = PADR(loc_cCpros, 14)
                    THIS.this_cPCEscolha = "ALTERAR"
                    THIS.CarregarInfoProduto(loc_cCpros)
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                ENDIF
            ELSE
                MsgAviso("Nenhum produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnAlterarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui todos os maximos do produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_cCpros, loc_nResult
        loc_lResultado = .F.
        loc_cCpros     = ""
        loc_nResult    = 0

        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                loc_cCpros = ALLTRIM(cursor_4c_Dados.cpros)
                IF EMPTY(loc_cCpros)
                    MsgAviso("Selecione um produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF MsgConfirma("Excluir todos os m" + CHR(225) + "ximos do produto " + loc_cCpros + "?", ;
                            "Confirmar Exclus" + CHR(227) + "o")
                        loc_nResult = SQLEXEC(gnConnHandle, ;
                            "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(PADR(loc_cCpros, 14)))
                        IF loc_nResult > 0
                            MsgInfo("M" + CHR(225) + "ximos exclu" + CHR(237) + "dos com sucesso.", "Sucesso")
                            THIS.CarregarLista()
                            loc_lResultado = .T.
                        ELSE
                            MsgErro("Erro ao excluir m" + CHR(225) + "ximos do produto.", "Erro")
                        ENDIF
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Nenhum produto na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnExcluirClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Navega para Page2 em modo PROCURAR
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.this_cPCEscolha = "PROCURAR"
            THIS.AlternarPagina(2)
        CATCH TO loc_oErro
            MsgErro("Erro em BtnBuscarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loc_oErro
            MsgErro("Erro em BtnEncerrarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos de Page2 (primeira metade; Fase 6 completa restante)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            loc_oPagina.txt_4c__produto.Value       = ""
            loc_oPagina.txt_4c_Dpro.Value           = ""
            loc_oPagina.txt_4c_Cgru.Value           = ""
            loc_oPagina.txt_4c_Dgru.Value           = ""
            loc_oPagina.obj_4c_Opc_situacao.Value   = 1

            loc_oPagina.txt_4c_Ifor.Value           = ""
            loc_oPagina.txt_4c_Dfor.Value           = ""
            loc_oPagina.txt_4c_Refs.Value           = ""
            loc_oPagina.grd_4c_Gradei.RecordSource  = ""

            IF USED("cursor_4c_Max")
                USE IN cursor_4c_Max
            ENDIF

            THIS.this_cPCPros    = ""
            THIS.this_nTipoEstos = 0
            THIS.this_lTemTam    = .F.
            THIS.this_lTemCor    = .F.
        CATCH TO loc_oErro
            MsgErro("Erro em LimparCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCopiarClick - Exibe painel de copia entre empresas
    *--------------------------------------------------------------------------
    PROCEDURE BtnCopiarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        TRY
            IF !THIS.this_lAcCopiar
                MsgAviso("Voc" + CHR(234) + " n" + CHR(227) + "o tem permiss" + CHR(227) + "o para copiar entre empresas.", "Acesso Negado")
            ELSE
                loc_oPagina.grd_4c_Lista.Visible     = .F.
                loc_oPagina.cnt_4c_Botoes.Visible    = .F.
                loc_oPagina.cnt_4c_Saida.Visible     = .F.
                loc_oPagina.cmd_4c_BtnCopiar.Visible = .F.

                loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value   = ""
                loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value   = ""
                loc_oPagina.cnt_4c_Copia.txt_4c_Produto.Value = ""
                loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Enabled = .F.

                IF USED("cursor_4c_Copia")
                    USE IN cursor_4c_Copia
                ENDIF
                loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.RecordSource = ""

                loc_oPagina.cnt_4c_Copia.Visible = .T.
                loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCopiarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * EmpOsLostFocus - Habilita txt_4c_EmpDs quando EmpOs estiver preenchida
    *--------------------------------------------------------------------------
    PROCEDURE EmpOsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cEmpOs
        loc_oPagina = THIS.pgf_4c_Paginas.Page1
        loc_cEmpOs  = ""

        TRY
            loc_cEmpOs = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value)
            IF EMPTY(loc_cEmpOs)
                loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Enabled = .F.
                loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value   = ""
            ELSE
                loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em EmpOsLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarCopiaClick - Processa e exibe itens disponiveis para copia
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarCopiaClick()
        LOCAL loc_lResultado, loc_oPagina, loc_cEmpOs, loc_cEmpDs, loc_cProduto, loc_oGrid
        loc_lResultado = .F.
        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_cEmpOs     = ""
        loc_cEmpDs     = ""
        loc_cProduto   = ""

        TRY
            loc_cEmpOs   = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value)
            loc_cEmpDs   = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value)
            loc_cProduto = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_Produto.Value)

            IF EMPTY(loc_cEmpOs)
                MsgAviso("Informe a Empresa Origem.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(loc_cEmpDs)
                    MsgAviso("Informe a Empresa Destino.", "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF THIS.this_oBusinessObject.CarregarCopiaParaCursor(PADR(loc_cProduto, 14), PADR(loc_cEmpOs, 3), PADR(loc_cEmpDs, 3))
                        IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
                            loc_oGrid = loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia

                            *-- RecordSource FORA de WITH (Problema 36)
                            loc_oGrid.ColumnCount = 6
                            loc_oGrid.RecordSource = "cursor_4c_Copia"
                            loc_oGrid.Column1.ControlSource = "cursor_4c_Copia.marcas"
                            loc_oGrid.Column2.ControlSource = "cursor_4c_Copia.cpros"
                            loc_oGrid.Column3.ControlSource = "cursor_4c_Copia.qmaxs"
                            loc_oGrid.Column4.ControlSource = "cursor_4c_Copia.codtams"
                            loc_oGrid.Column5.ControlSource = "cursor_4c_Copia.codcores"
                            loc_oGrid.Column6.ControlSource = "cursor_4c_Copia.deptos"

                            *-- Headers: re-setar apos RecordSource (VFP9 reseta)
                            loc_oGrid.Column1.Header1.Caption = ""
                            loc_oGrid.Column2.Header1.Caption = "Produto"
                            loc_oGrid.Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
                            loc_oGrid.Column4.Header1.Caption = "Tam"
                            loc_oGrid.Column5.Header1.Caption = "Cor"
                            loc_oGrid.Column6.Header1.Caption = "Departamento"

                            GO TOP IN cursor_4c_Copia
                            loc_lResultado = .T.
                        ELSE
                            MsgAviso("Nenhum produto encontrado para c" + CHR(243) + "pia.", "Aviso")
                        ENDIF
                    ELSE
                        MsgErro("Erro ao carregar dados: " + THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnProcessarCopiaClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarCopiaClick - Confirma e executa a copia entre empresas
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarCopiaClick()
        LOCAL loc_lResultado, loc_oPagina, loc_cEmpOs, loc_cEmpDs
        loc_lResultado = .F.
        loc_oPagina    = THIS.pgf_4c_Paginas.Page1
        loc_cEmpOs     = ""
        loc_cEmpDs     = ""

        TRY
            loc_cEmpOs = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value)
            loc_cEmpDs = ALLTRIM(loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value)

            IF !USED("cursor_4c_Copia") OR RECCOUNT("cursor_4c_Copia") = 0
                MsgAviso("Processe os dados antes de confirmar a c" + CHR(243) + "pia.", "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF MsgConfirma("Confirmar c" + CHR(243) + "pia dos m" + CHR(225) + "ximos de " + ;
                        loc_cEmpOs + " para " + loc_cEmpDs + "?", "Confirmar C" + CHR(243) + "pia")
                    IF THIS.this_oBusinessObject.CopiarMaxEntreEmpresas(PADR(loc_cEmpDs, 3), "cursor_4c_Copia")
                        MsgInfo("C" + CHR(243) + "pia realizada com sucesso.", "Sucesso")
                        THIS.BtnSairCopiaClick()
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao copiar m" + CHR(225) + "ximos: " + ;
                            THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnConfirmarCopiaClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairCopiaClick - Fecha painel de copia e restaura controles principais
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairCopiaClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_oPagina.cnt_4c_Copia.Visible     = .F.
            loc_oPagina.grd_4c_Lista.Visible      = .T.
            loc_oPagina.cnt_4c_Botoes.Visible     = .T.
            loc_oPagina.cnt_4c_Saida.Visible      = .T.
            loc_oPagina.cmd_4c_BtnCopiar.Visible  = .T.

            IF USED("cursor_4c_Copia")
                USE IN cursor_4c_Copia
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnSairCopiaClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMarcarCopiaClick - Marca todos os itens para copia
    *--------------------------------------------------------------------------
    PROCEDURE BtnMarcarCopiaClick()
        TRY
            IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
                REPLACE ALL marcas WITH 1 IN cursor_4c_Copia
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_DadosCopia.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnMarcarCopiaClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnDesmarcarCopiaClick - Desmarca todos os itens da copia
    *--------------------------------------------------------------------------
    PROCEDURE BtnDesmarcarCopiaClick()
        TRY
            IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0
                REPLACE ALL marcas WITH 0 IN cursor_4c_Copia
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Copia.grd_4c_DadosCopia.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnDesmarcarCopiaClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirma e salva os maximos do produto (Grupo_Salva.Confirmar)
    * Logica: valida produto, limpa linhas vazias do cursor, salva via BO
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado, loc_oPagina, loc_cCpros
        loc_lResultado = .F.
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2
        loc_cCpros     = ""

        TRY
            loc_cCpros = ALLTRIM(loc_oPagina.txt_4c__produto.Value)

            IF INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR")
                IF THIS.this_cPCEscolha = "INSERIR" AND EMPTY(loc_cCpros)
                    MsgAviso("Produto inv" + CHR(225) + "lido !!!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_oPagina.txt_4c__produto.SetFocus()
                ELSE
                    *-- Remover linhas com empresa vazia do cursor de maximos (limpeza antes de salvar)
                    IF USED("cursor_4c_Max") AND RECCOUNT("cursor_4c_Max") > 0
                        SELECT cursor_4c_Max
                        GO TOP
                        SCAN
                            IF EMPTY(ALLTRIM(cursor_4c_Max.emps))
                                DELETE IN cursor_4c_Max
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF THIS.this_oBusinessObject.SalvarGradeMax(PADR(loc_cCpros, 14))
                        MsgInfo("M" + CHR(225) + "ximos salvos com sucesso.", "Sucesso")
                        IF !EMPTY(THIS.this_cPExterno)
                            THIS.Release()
                        ELSE
                            THIS.AlternarPagina(1)
                            THIS.CarregarLista()
                        ENDIF
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao salvar m" + CHR(225) + "ximos: " + ;
                            THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                    ENDIF
                ENDIF
            ELSE
                *-- Modo CONSULTAR/PROCURAR: apenas navegar de volta
                IF !EMPTY(THIS.this_cPExterno)
                    THIS.Release()
                ELSE
                    THIS.AlternarPagina(1)
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em BtnSalvarClick: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_lPCancelar = .T.
            IF !EMPTY(THIS.this_cPExterno)
                THIS.Release()
            ELSE
                THIS.AlternarPagina(1)
                THIS.CarregarLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BtnCancelarClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProdutoKeyPress - Handler de teclado para txt_4c__produto
    * F4 (115): abre FormBuscaAuxiliar para busca de produto na SigCdPro
    *--------------------------------------------------------------------------
    PROCEDURE ProdutoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPagina, loc_cValor, loc_oBusca, loc_cCpros
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cCpros  = ""

        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF

        IF par_nKeyCode = 115   && F4
            TRY
                loc_cValor = ALLTRIM(loc_oPagina.txt_4c__produto.Value)

                loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                    "SigCdPro", "cursor_4c_BuscaProd", "cpros", loc_cValor, "Produtos")

                IF VARTYPE(loc_oBusca) = "O"
                    IF !loc_oBusca.this_lAchouRegistro
                        loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
                        loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
                        loc_oBusca.Show()
                    ENDIF

                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
                        loc_cCpros = ALLTRIM(cursor_4c_BuscaProd.cpros)
                        loc_oPagina.txt_4c__produto.Value = loc_cCpros
                        THIS.this_cPCPros = PADR(loc_cCpros, 14)
                        THIS.CarregarInfoProduto(loc_cCpros)
                    ENDIF

                    loc_oBusca.Release()
                ENDIF

                IF USED("cursor_4c_BuscaProd")
                    USE IN cursor_4c_BuscaProd
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao buscar produto: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarInfoProduto - Carrega dados do produto na Page2
    * Popula: cpros, dpros, cgrus, dgrus, situas, tiposestos (Fase 5)
    *         ifors, rclis, reffs serao populados na Fase 6
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarInfoProduto(par_cCpros)
        LOCAL loc_lResultado, loc_oPagina, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus," + ;
                       " p.ifors, c.Rclis AS rclis, p.reffs, p.Situas, p.varias" + ;
                       " FROM SigCdPro p" + ;
                       " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                       " LEFT JOIN SigCdCli c ON c.Iclis = p.ifors" + ;
                       " WHERE p.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))

            IF USED("cursor_4c_ProdInfo")
                USE IN cursor_4c_ProdInfo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdInfo")

            IF loc_nResult > 0 AND USED("cursor_4c_ProdInfo") AND RECCOUNT("cursor_4c_ProdInfo") > 0
                SELECT cursor_4c_ProdInfo
                GO TOP

                loc_oPagina.txt_4c__produto.Value = ALLTRIM(cursor_4c_ProdInfo.cpros)
                loc_oPagina.txt_4c_Dpro.Value     = ALLTRIM(cursor_4c_ProdInfo.dpros)
                loc_oPagina.txt_4c_Cgru.Value     = ALLTRIM(cursor_4c_ProdInfo.cgrus)
                loc_oPagina.txt_4c_Dgru.Value     = TratarNulo(cursor_4c_ProdInfo.dgrus, "C")

                THIS.this_nTipoEstos = NVL(cursor_4c_ProdInfo.varias, 0)
                THIS.this_lTemTam    = INLIST(THIS.this_nTipoEstos, 1, 3)
                THIS.this_lTemCor    = INLIST(THIS.this_nTipoEstos, 2, 3)

                loc_oPagina.obj_4c_Opc_situacao.Value = IIF(NVL(cursor_4c_ProdInfo.Situas, 1) = 2, 2, 1)

                loc_oPagina.txt_4c_Ifor.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.ifors, "C"))
                loc_oPagina.txt_4c_Dfor.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.rclis, "C"))
                loc_oPagina.txt_4c_Refs.Value = ALLTRIM(TratarNulo(cursor_4c_ProdInfo.reffs, "C"))

                USE IN cursor_4c_ProdInfo

                THIS.CarregarGradeMaximos(PADR(par_cCpros, 14))

                loc_lResultado = .T.
            ELSE
                THIS.LimparCampos()
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar produto: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarCamposPorModo - Habilita/desabilita campos e grade conforme modo
    *--------------------------------------------------------------------------
    PROCEDURE AjustarCamposPorModo()
        LOCAL loc_oPagina, loc_lEditar
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEditar = INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR")

        TRY
            *-- Produto editavel apenas em INSERIR
            loc_oPagina.txt_4c__produto.ReadOnly  = !(THIS.this_cPCEscolha = "INSERIR")
            loc_oPagina.txt_4c__produto.BackColor = IIF(THIS.this_cPCEscolha = "INSERIR", ;
                RGB(255, 255, 255), RGB(220, 220, 220))

            *-- Grade editavel em INSERIR/ALTERAR; botao excluir visivel idem
            loc_oPagina.grd_4c_Gradei.ReadOnly      = !loc_lEditar
            loc_oPagina.cmd_4c_BtnExcluir.Visible   = loc_lEditar

            *-- Colunas de variacao somente se produto tem a caracteristica
            loc_oPagina.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam
            loc_oPagina.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarCamposPorModo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGradeMaximos - Carrega cursor_4c_Max e vincula a grd_4c_Gradei
    * par_cCpros vazio = modo INSERIR (cursor vazio)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarGradeMaximos(par_cCpros)
        LOCAL loc_lResultado, loc_oPagina, loc_oGrid
        loc_lResultado = .F.
        loc_oPagina    = THIS.pgf_4c_Paginas.Page2

        TRY
            IF !EMPTY(ALLTRIM(par_cCpros))
                IF THIS.this_oBusinessObject.CarregarMaxPorProduto(par_cCpros)
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
                ENDIF
            ELSE
                *-- Modo INSERIR: criar cursor vazio editavel
                IF USED("cursor_4c_Max")
                    USE IN cursor_4c_Max
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Max (cidchaves C(20), emps C(3), qmaxs N(7,2), ;
                    codtams C(4), codcores C(4), deptos C(10), ordems C(1))
                SET NULL OFF
                loc_lResultado = .T.
            ENDIF

            IF loc_lResultado AND USED("cursor_4c_Max")
                loc_oGrid = loc_oPagina.grd_4c_Gradei

                *-- RecordSource e ControlSources FORA de WITH (Problema 36)
                loc_oGrid.ColumnCount = 5
                loc_oGrid.RecordSource               = "cursor_4c_Max"
                loc_oGrid.Column1.ControlSource      = "cursor_4c_Max.emps"
                loc_oGrid.Column2.ControlSource      = "cursor_4c_Max.qmaxs"
                loc_oGrid.Column3.ControlSource      = "cursor_4c_Max.codtams"
                loc_oGrid.Column4.ControlSource      = "cursor_4c_Max.codcores"
                loc_oGrid.Column5.ControlSource      = "cursor_4c_Max.deptos"

                *-- Headers OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
                loc_oGrid.Column1.Header1.Caption = "Emp"
                loc_oGrid.Column2.Header1.Caption = "Qtde. M" + CHR(225) + "xima"
                loc_oGrid.Column3.Header1.Caption = "Tamanho"
                loc_oGrid.Column4.Header1.Caption = "Cor"
                loc_oGrid.Column5.Header1.Caption = "Departamento"

                GO TOP IN cursor_4c_Max
                loc_oGrid.Refresh()

                IF RECCOUNT("cursor_4c_Max") = 0
                    THIS.GradeINovaLinha()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarGradeMaximos: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeINovaLinha - Insere linha vazia no cursor_4c_Max e posiciona grade
    *--------------------------------------------------------------------------
    PROCEDURE GradeINovaLinha()
        LOCAL loc_cEmps
        loc_cEmps = ""

        TRY
            IF !USED("cursor_4c_Max")
                RETURN
            ENDIF

            loc_cEmps = IIF(!EMPTY(ALLTRIM(go_4c_Sistema.cCodEmpresa)), ;
                PADR(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3), SPACE(3))

            INSERT INTO cursor_4c_Max ;
                (cidchaves, emps, qmaxs, codtams, codcores, deptos, ordems) ;
                VALUES (SPACE(20), loc_cEmps, 0, SPACE(4), SPACE(4), SPACE(10), SPACE(1))

            GO BOTTOM IN cursor_4c_Max
            THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
            THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.SetFocus()
            THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.DoScroll(2)
        CATCH TO loc_oErro
            MsgErro("Erro em GradeINovaLinha: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeIAfterRowColChange - Ajusta colunas de variacao; adiciona linha ao final
    *--------------------------------------------------------------------------
    PROCEDURE GradeIAfterRowColChange(par_nColIndex)
        TRY
            THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam
            THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor

            IF USED("cursor_4c_Max") AND INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR")
                SELECT cursor_4c_Max
                IF EOF()
                    THIS.GradeINovaLinha()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em GradeIAfterRowColChange: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * QmaxsLostFocus - Valida quantidade maxima (nao pode ser negativa)
    *--------------------------------------------------------------------------
    PROCEDURE QmaxsLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
                SELECT cursor_4c_Max
                IF NVL(cursor_4c_Max.qmaxs, 0) < 0
                    REPLACE cursor_4c_Max.qmaxs WITH 0
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em QmaxsLostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TamKeyPress - F4 abre lookup SigCdTam para coluna de tamanho
    *--------------------------------------------------------------------------
    PROCEDURE TamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupTamanho()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTamanho - FormBuscaAuxiliar para SigCdTam (ctams/dtams)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupTamanho()
        LOCAL loc_oBusca, loc_cValor
        loc_cValor = ""

        TRY
            IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
                loc_cValor = ALLTRIM(TratarNulo(cursor_4c_Max.codtams, "C"))
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdTam", "cursor_4c_BuscaTam", "ctams", loc_cValor, "Tamanhos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("ctams", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dtams", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
                    IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
                        SELECT cursor_4c_Max
                        REPLACE codtams WITH PADR(ALLTRIM(cursor_4c_BuscaTam.ctams), 4)
                    ENDIF
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaTam")
                USE IN cursor_4c_BuscaTam
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar tamanho: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CorKeyPress - F4 abre lookup SigCdCor para coluna de cor
    *--------------------------------------------------------------------------
    PROCEDURE CorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupCor()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCor - FormBuscaAuxiliar para SigCdCor (ccors/dcors)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCor()
        LOCAL loc_oBusca, loc_cValor
        loc_cValor = ""

        TRY
            IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
                loc_cValor = ALLTRIM(TratarNulo(cursor_4c_Max.codcores, "C"))
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCor", "cursor_4c_BuscaCor", "ccors", loc_cValor, "Cores")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("ccors", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("dcors", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
                    IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
                        SELECT cursor_4c_Max
                        REPLACE codcores WITH PADR(ALLTRIM(cursor_4c_BuscaCor.ccors), 4)
                    ENDIF
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaCor")
                USE IN cursor_4c_BuscaCor
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar cor: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DptKeyPress - F4 abre lookup SigCdDpt para coluna de departamento
    *--------------------------------------------------------------------------
    PROCEDURE DptKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9, 115)
            RETURN
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupDepto()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDepto - FormBuscaAuxiliar para SigCdDpt (codigos/descricaos)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupDepto()
        LOCAL loc_oBusca, loc_cValor
        loc_cValor = ""

        TRY
            IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
                loc_cValor = ALLTRIM(TratarNulo(cursor_4c_Max.deptos, "C"))
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdDpt", "cursor_4c_BuscaDpt", "codigos", loc_cValor, "Departamentos")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDpt")
                    IF USED("cursor_4c_Max") AND !EOF("cursor_4c_Max") AND !BOF("cursor_4c_Max")
                        SELECT cursor_4c_Max
                        REPLACE deptos WITH PADR(ALLTRIM(cursor_4c_BuscaDpt.codigos), 10)
                    ENDIF
                    THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
                ENDIF

                loc_oBusca.Release()
            ENDIF

            IF USED("cursor_4c_BuscaDpt")
                USE IN cursor_4c_BuscaDpt
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar departamento: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeICol5LostFocus - Refresh da grade ao sair da coluna departamento
    *--------------------------------------------------------------------------
    PROCEDURE GradeICol5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
        TRY
            IF USED("cursor_4c_Max")
                THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em GradeICol5LostFocus: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirGradeClick - Exclui todas as linhas da empresa corrente no cursor
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirGradeClick()
        LOCAL loc_cEmps
        loc_cEmps = ""

        TRY
            IF !USED("cursor_4c_Max") OR RECCOUNT("cursor_4c_Max") = 0
                RETURN
            ENDIF

            IF !MsgConfirma("Excluir todos os m" + CHR(225) + "ximos desta empresa?", ;
                    "Confirmar Exclus" + CHR(227) + "o")
                RETURN
            ENDIF

            SELECT cursor_4c_Max
            IF !EOF() AND !BOF()
                loc_cEmps = ALLTRIM(TratarNulo(cursor_4c_Max.emps, "C"))
            ENDIF

            IF EMPTY(loc_cEmps)
                loc_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF

            SELECT cursor_4c_Max
            GO TOP
            SCAN
                IF ALLTRIM(cursor_4c_Max.emps) = loc_cEmps
                    DELETE
                ENDIF
            ENDSCAN
            PACK

            IF RECCOUNT("cursor_4c_Max") = 0
                THIS.GradeINovaLinha()
            ENDIF

            THIS.pgf_4c_Paginas.Page2.grd_4c_Gradei.Refresh()
        CATCH TO loc_oErro
            MsgErro("Erro em BtnExcluirGradeClick: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o Business Object
    * Campos de display (dpros, dgrus, rclis) sao read-only; apenas cpros e
    * derivados sao transferidos porque o BO os usa em SalvarGradeMax
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_cCPros  = PADR(ALLTRIM(loc_oPagina.txt_4c__produto.Value), 14)
                THIS.this_oBusinessObject.this_cDPros  = ALLTRIM(loc_oPagina.txt_4c_Dpro.Value)
                THIS.this_oBusinessObject.this_cCGrus  = ALLTRIM(loc_oPagina.txt_4c_Cgru.Value)
                THIS.this_oBusinessObject.this_cDGrus  = ALLTRIM(loc_oPagina.txt_4c_Dgru.Value)
                THIS.this_oBusinessObject.this_cIFors  = ALLTRIM(loc_oPagina.txt_4c_Ifor.Value)
                THIS.this_oBusinessObject.this_cRClis  = ALLTRIM(loc_oPagina.txt_4c_Dfor.Value)
                THIS.this_oBusinessObject.this_cReffs  = ALLTRIM(loc_oPagina.txt_4c_Refs.Value)
                THIS.this_oBusinessObject.this_nSituas = loc_oPagina.obj_4c_Opc_situacao.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormParaBO: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do Business Object para o Form
    * Popula campos de display da Page2 a partir das propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_oPagina.txt_4c__produto.Value       = ALLTRIM(THIS.this_oBusinessObject.this_cCPros)
                loc_oPagina.txt_4c_Dpro.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cDPros)
                loc_oPagina.txt_4c_Cgru.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cCGrus)
                loc_oPagina.txt_4c_Dgru.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cDGrus)
                loc_oPagina.txt_4c_Ifor.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cIFors)
                loc_oPagina.txt_4c_Dfor.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cRClis)
                loc_oPagina.txt_4c_Refs.Value           = ALLTRIM(THIS.this_oBusinessObject.this_cReffs)
                loc_oPagina.obj_4c_Opc_situacao.Value   = IIF(THIS.this_oBusinessObject.this_nSituas = 2, 2, 1)

                THIS.this_nTipoEstos = THIS.this_oBusinessObject.this_nTipoEstos
                THIS.this_lTemTam    = THIS.this_oBusinessObject.this_lTemTam
                THIS.this_lTemCor    = THIS.this_oBusinessObject.this_lTemCor
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BOParaForm: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles editaveis da Page2
    * par_lHabilitar=.T. habilita conforme modo; .F. bloqueia tudo (VISUALIZAR)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lEditar
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEditar = INLIST(THIS.this_cPCEscolha, "INSERIR", "ALTERAR") AND par_lHabilitar

        TRY
            *-- Produto: editavel apenas em INSERIR
            loc_oPagina.txt_4c__produto.ReadOnly  = !(THIS.this_cPCEscolha = "INSERIR" AND par_lHabilitar)
            loc_oPagina.txt_4c__produto.BackColor = IIF(THIS.this_cPCEscolha = "INSERIR" AND par_lHabilitar, ;
                RGB(255, 255, 255), RGB(220, 220, 220))

            *-- Grade: editavel apenas em INSERIR/ALTERAR
            loc_oPagina.grd_4c_Gradei.ReadOnly      = !loc_lEditar
            loc_oPagina.cmd_4c_BtnExcluir.Visible   = loc_lEditar

            *-- Colunas de variacao: habilitadas conforme caracteristica do produto
            loc_oPagina.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam OR !loc_lEditar
            loc_oPagina.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor OR !loc_lEditar

            *-- Botoes de acao Page2
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD da Page1 (lista)
    * Chamado apos CarregarLista para refletir se ha registros selecionaveis
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_lTemSelecao
        loc_oPg1        = THIS.pgf_4c_Paginas.Page1
        loc_lTemSelecao = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

        TRY
            WITH loc_oPg1.cnt_4c_Botoes
                .cmd_4c_Inserir.Enabled    = .T.
                .cmd_4c_Visualizar.Enabled = loc_lTemSelecao
                .cmd_4c_Alterar.Enabled    = loc_lTemSelecao
                .cmd_4c_Excluir.Enabled    = loc_lTemSelecao
                .cmd_4c_Buscar.Enabled     = .T.
                .Visible     = .T.
            ENDWITH

            loc_oPg1.cmd_4c_BtnCopiar.Enabled = THIS.this_lAcCopiar
        CATCH TO loc_oErro
            MsgErro("Erro em AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprcomBO.prg):
*==============================================================================
* sigprcomBO.prg - Business Object para Estoque M" + CHR(225) + "ximo (SigCdMax)
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS sigprcomBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Tabela SigCdMax (linha corrente da grade de estoque)
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""   && char(20) - PK
    this_cCodCores   = ""   && char(4)  - C" + CHR(243) + "digo da Cor
    this_cCodTams    = ""   && char(4)  - C" + CHR(243) + "digo do Tamanho
    this_cCPros      = ""   && char(14) - C" + CHR(243) + "digo do Produto (FK SigCdPro)
    this_cEmps       = ""   && char(3)  - Empresa
    this_cOrdems     = ""   && char(1)  - Ordem
    this_nQmaxs      = 0    && numeric(7,2) - Quantidade M" + CHR(225) + "xima
    this_cDeptos     = ""   && char(10) - Departamento (FK SigCdDpt)

    *--------------------------------------------------------------------------
    * Propriedades - Informa" + CHR(231) + CHR(245) + "es do Produto (SigCdPro - leitura)
    *--------------------------------------------------------------------------
    this_cDPros      = ""   && char(65) - Descri" + CHR(231) + CHR(227) + "o do Produto
    this_cCGrus      = ""   && char(3)  - C" + CHR(243) + "digo do Grupo
    this_cDGrus      = ""   && Descri" + CHR(231) + CHR(227) + "o do Grupo (join SigCdGrp)
    this_cIFors      = ""   && char(10) - C" + CHR(243) + "digo do Fornecedor
    this_cRClis      = ""   && Raz" + CHR(227) + "o do Fornecedor (join SigCdCli)
    this_cReffs      = ""   && char(40) - Refer" + CHR(234) + "ncia do Produto
    this_nSituas     = 0    && numeric(1,0) - Situa" + CHR(231) + CHR(227) + "o (1=ativo, 2=inativo)

    *--------------------------------------------------------------------------
    * Propriedades - Caracter" + CHR(237) + "sticas de varia" + CHR(231) + CHR(227) + "o do produto
    *--------------------------------------------------------------------------
    this_lTemCor     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Cor
    this_lTemTam     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Tamanho
    this_nTipoEstos  = 0    && Tipo de Estoque (0=sem, 1=tam, 2=cor, 3=tam+cor)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave prim" + CHR(225) + "ria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMax"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK do registro corrente (auditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - L" + CHR(234) + " linha de SigCdMax de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCodCores  = TratarNulo(codcores,  "C")
            THIS.this_cCodTams   = TratarNulo(codtams,   "C")
            THIS.this_cCPros     = TratarNulo(cpros,     "C")
            THIS.this_cEmps      = TratarNulo(emps,      "C")
            THIS.this_cOrdems    = TratarNulo(ordems,    "C")
            THIS.this_nQmaxs     = TratarNulo(qmaxs,     "N")
            THIS.this_cDeptos    = TratarNulo(deptos,    "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Pesquisa produtos em SigCdPro para a lista (Page1)
    * par_cFiltro: filtro livre por cpros/dpros/ifors/reffs
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas, p.sgrus" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " ORDER BY p.cpros"
            ELSE
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas, p.sgrus" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " WHERE p.cpros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " OR p.ifors LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY p.cpros"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega produto + SigCdMax do produto
    * par_cCPros: c" + CHR(243) + "digo do produto
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nVarias
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado!")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                " c.rclis, p.reffs, p.situas, p.codcors, p.codtams, p.varias" + ;
                " FROM SigCdPro p" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = p.ifors" + ;
                " WHERE p.cpros = " + EscaparSQL(par_cCPros)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF !USED("cursor_4c_Produto") OR RECCOUNT("cursor_4c_Produto") = 0
                MsgErro("Produto n" + CHR(227) + "o encontrado!", "Aviso")
                loc_lResultado = .F.
            ELSE
                SELECT cursor_4c_Produto
                GO TOP

                THIS.this_cCPros     = ALLTRIM(TratarNulo(cpros,  "C"))
                THIS.this_cDPros     = ALLTRIM(TratarNulo(dpros,  "C"))
                THIS.this_cCGrus     = ALLTRIM(TratarNulo(cgrus,  "C"))
                THIS.this_cDGrus     = ALLTRIM(TratarNulo(dgrus,  "C"))
                THIS.this_cIFors     = ALLTRIM(TratarNulo(ifors,  "C"))
                THIS.this_cRClis     = ALLTRIM(TratarNulo(rclis,  "C"))
                THIS.this_cReffs     = ALLTRIM(TratarNulo(reffs,  "C"))
                THIS.this_nSituas    = TratarNulo(situas, "N")
                THIS.this_lNovoRegistro = .F.

                loc_nVarias = TratarNulo(varias, "N")
                DO CASE
                    CASE loc_nVarias = 0
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 1
                        THIS.this_nTipoEstos = 1
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .F.
                    CASE loc_nVarias = 2
                        THIS.this_nTipoEstos = 2
                        THIS.this_lTemCor    = .T.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 3
                        THIS.this_nTipoEstos = 3
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .T.
                    OTHERWISE
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                ENDCASE

                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF

                loc_lResultado = THIS.CarregarMaxPorProduto(par_cCPros)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMaxPorProduto - Carrega SigCdMax de um produto em cursor_4c_Max
    * Cria cursor local EDITAVEL (SQLEXEC retorna cursor somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMaxPorProduto(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Max")
                USE IN cursor_4c_Max
            ENDIF
            IF USED("cursor_4c_MaxTemp")
                USE IN cursor_4c_MaxTemp
            ENDIF

            loc_cSQL = "SELECT m.cidchaves, m.emps, m.qmaxs, m.codtams," + ;
                " m.codcores, m.deptos, m.ordems" + ;
                " FROM SigCdMax m" + ;
                " WHERE m.cpros = " + EscaparSQL(par_cCPros) + ;
                " ORDER BY m.emps, m.codtams, m.codcores, m.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxTemp")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Criar cursor local editavel (SQLEXEC cria cursor somente leitura)
                SET NULL ON
                CREATE CURSOR cursor_4c_Max (cidchaves C(20), emps C(3), qmaxs N(7,2), ;
                    codtams C(4), codcores C(4), deptos C(10), ordems C(1))
                SET NULL OFF

                IF USED("cursor_4c_MaxTemp") AND RECCOUNT("cursor_4c_MaxTemp") > 0
                    APPEND FROM DBF("cursor_4c_MaxTemp")
                ENDIF

                IF USED("cursor_4c_MaxTemp")
                    USE IN cursor_4c_MaxTemp
                ENDIF

                GO TOP IN cursor_4c_Max
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarMaxPorProduto:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um registro em SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave               = fUniqueIds()
            THIS.this_cCidChaves     = loc_cChave

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                " VALUES (" + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(THIS.this_cCPros) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cEmps), 7) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQmaxs) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodTams), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodCores), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cDeptos), 14) + ", " + ;
                EscaparSQL(THIS.this_cOrdems) + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult < 0
                MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro de SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave do registro n" + CHR(227) + "o definida!", "Erro")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "UPDATE SigCdMax SET" + ;
                    " qmaxs = " + FormatarNumeroSQL(THIS.this_nQmaxs) + "," + ;
                    " codtams = " + LEFT(EscaparSQL(THIS.this_cCodTams), 8) + "," + ;
                    " codcores = " + LEFT(EscaparSQL(THIS.this_cCodCores), 8) + "," + ;
                    " deptos = " + LEFT(EscaparSQL(THIS.this_cDeptos), 14) + "," + ;
                    " emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7) + "," + ;
                    " ordems = " + EscaparSQL(THIS.this_cOrdems) + ;
                    " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
                IF loc_nResult < 0
                    MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdMax (PROTECTED)
    * Deleta por cidchaves OU por cpros+emps dependendo do contexto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF !EMPTY(THIS.this_cCidChaves)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cidchaves = " + ;
                    EscaparSQL(THIS.this_cCidChaves)
            ELSE
                IF !EMPTY(THIS.this_cCPros) AND !EMPTY(THIS.this_cEmps)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + ;
                    EscaparSQL(THIS.this_cCPros) + ;
                    " AND emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7)
            ELSE
                MsgErro("Nenhuma chave definida para exclus" + CHR(227) + "o!", "Erro")
                loc_lResultado = .F.
                ENDIF
            ENDIF

            IF !EMPTY(loc_cSQL)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGradeMax - Persiste cursor_4c_Max no banco (replace by delete+insert)
    * Chamado pelo form ap" + CHR(243) + "s edi" + CHR(231) + CHR(227) + "o da grade para o produto par_cCPros
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGradeMax(par_cCPros)
        LOCAL loc_lResultado, loc_nResult
        LOCAL loc_cChaveNova, loc_cInsSQL
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o definido!")
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Max")
            MsgErro("Cursor de estoque m" + CHR(225) + "ximo n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCPros) + ;
                " AND emps <> ''", ;
                "cursor_4c_DelAll")

            IF loc_nResult < 0
                MsgErro("Erro ao limpar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_DelAll")
                    USE IN cursor_4c_DelAll
                ENDIF

                SELECT cursor_4c_Max
                GO TOP
                loc_lResultado = .T.

                DO WHILE !EOF("cursor_4c_Max") AND loc_lResultado
                    IF !EMPTY(ALLTRIM(cursor_4c_Max.emps))
                        loc_cChaveNova = fUniqueIds()

                        loc_cInsSQL = "INSERT INTO SigCdMax" + ;
                            " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cChaveNova) + ", " + ;
                            EscaparSQL(par_cCPros) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.emps)), 7) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_Max.qmaxs) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codtams)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codcores)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.deptos)), 14) + ", " + ;
                            EscaparSQL(ALLTRIM(cursor_4c_Max.ordems)) + ;
                            ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cInsSQL, "cursor_4c_InsLinha")
                        IF loc_nResult < 0
                            MsgErro("Erro ao salvar linha de estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ELSE
                            IF USED("cursor_4c_InsLinha")
                                USE IN cursor_4c_InsLinha
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lResultado
                        SKIP IN cursor_4c_Max
                    ENDIF
                ENDDO

                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em SalvarGradeMax:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCopiaParaCursor - Popula cursor_4c_Copia com dados da empresa origem
    * para a funcionalidade de c" + CHR(243) + "pia entre empresas (cntCopia)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCopiaParaCursor(par_cCPros, par_cEmpOs, par_cEmpDs)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        IF EMPTY(par_cEmpOs)
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Copia")
                USE IN cursor_4c_Copia
            ENDIF
            IF USED("cursor_4c_CopiaTemp")
                USE IN cursor_4c_CopiaTemp
            ENDIF

            loc_cSQL = "SELECT o.cpros AS cpros, o.emps AS emps, o.qmaxs AS qmaxs," + ;
                " o.codtams AS codtams, o.codcores AS codcores, o.deptos AS deptos," + ;
                " CASE WHEN d.cidchaves IS NOT NULL THEN 1 ELSE 0 END AS existes," + ;
                " CAST(0 AS INT) AS marcas" + ;
                " FROM SigCdMax o" + ;
                " LEFT JOIN SigCdMax d ON d.cpros = o.cpros" + ;
                " AND d.emps = " + LEFT(EscaparSQL(par_cEmpDs), 7) + ;
                " AND d.codtams = o.codtams AND d.codcores = o.codcores" + ;
                " WHERE o.emps = " + LEFT(EscaparSQL(par_cEmpOs), 7) + ;
                IIF(!EMPTY(ALLTRIM(par_cCPros)), " AND o.cpros = " + EscaparSQL(par_cCPros), "") + ;
                " ORDER BY o.codtams, o.codcores, o.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CopiaTemp")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar c" + CHR(243) + "pia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Criar cursor local editavel (SQLEXEC cria cursor somente leitura)
                *-- Necessario para permitir REPLACE ALL marcas no form
                SET NULL ON
                CREATE CURSOR cursor_4c_Copia (cpros C(14), emps C(3), qmaxs N(7,2), ;
                    codtams C(4), codcores C(4), deptos C(10), existes N(1,0), marcas N(1,0))
                SET NULL OFF

                IF USED("cursor_4c_CopiaTemp") AND RECCOUNT("cursor_4c_CopiaTemp") > 0
                    APPEND FROM DBF("cursor_4c_CopiaTemp")
                ENDIF

                IF USED("cursor_4c_CopiaTemp")
                    USE IN cursor_4c_CopiaTemp
                ENDIF

                IF USED("cursor_4c_Copia")
                    GO TOP IN cursor_4c_Copia
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarCopiaParaCursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarMaxEntreEmpresas - Insere em SigCdMax os registros marcados do cursor
    * de c" + CHR(243) + "pia para a empresa destino
    * par_cEmpDs: empresa destino
    * par_cCursorCopia: nome do cursor com registros marcados (marcas=1, existes=0)
    *--------------------------------------------------------------------------
    PROCEDURE CopiarMaxEntreEmpresas(par_cEmpDs, par_cCursorCopia)
        LOCAL loc_lResultado, loc_nResult, loc_nCopias
        LOCAL loc_cChaveNova, loc_cCopSQL
        LOCAL loc_cCPros, loc_cEmps, loc_nQmaxs, loc_cCodTams
        LOCAL loc_cCodCores, loc_cDeptos, loc_nMarcas, loc_nExistes
        loc_lResultado = .F.
        loc_nCopias    = 0

        IF EMPTY(par_cEmpDs) OR EMPTY(par_cCursorCopia)
            MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em CopiarMaxEntreEmpresas!", "Erro")
            RETURN .F.
        ENDIF

        IF !USED(par_cCursorCopia)
            MsgErro("Cursor de c" + CHR(243) + "pia n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cCursorCopia)
            GO TOP
            loc_lResultado = .T.

            DO WHILE !EOF() AND loc_lResultado
                loc_nMarcas  = TratarNulo(marcas,   "N")
                loc_nExistes = TratarNulo(existes,  "N")

                IF loc_nMarcas = 1 AND loc_nExistes = 0
                    loc_cCPros    = ALLTRIM(TratarNulo(cpros,    "C"))
                    loc_cEmps     = ALLTRIM(TratarNulo(emps,     "C"))
                    loc_nQmaxs    = TratarNulo(qmaxs,    "N")
                    loc_cCodTams  = ALLTRIM(TratarNulo(codtams,  "C"))
                    loc_cCodCores = ALLTRIM(TratarNulo(codcores, "C"))
                    loc_cDeptos   = ALLTRIM(TratarNulo(deptos,   "C"))

                    loc_cChaveNova = fUniqueIds()

                    loc_cCopSQL = "INSERT INTO SigCdMax" + ;
                        " (cpros, emps, qmaxs, codtams, codcores, cidchaves, deptos, ordems)" + ;
                        " VALUES (" + ;
                        EscaparSQL(loc_cCPros) + ", " + ;
                        LEFT(EscaparSQL(par_cEmpDs), 7) + ", " + ;
                        FormatarNumeroSQL(loc_nQmaxs) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodTams), 8) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodCores), 8) + ", " + ;
                        EscaparSQL(loc_cChaveNova) + ", " + ;
                        LEFT(EscaparSQL(loc_cDeptos), 14) + ", " + ;
                        "' ')"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cCopSQL, "cursor_4c_CopIns")
                    IF loc_nResult >= 0
                        loc_nCopias = loc_nCopias + 1
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                    ELSE
                        MsgErro("Erro ao copiar linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                        loc_lResultado = .F.
                    ENDIF

                    SELECT (par_cCursorCopia)
                ENDIF

                IF loc_lResultado
                    SKIP
                ENDIF
            ENDDO

            IF loc_lResultado
                MsgInfo("Foram copiados " + ALLTRIM(STR(loc_nCopias)) + ;
                    " registros para " + ALLTRIM(par_cEmpDs) + "!", ;
                    "C" + CHR(243) + "pia Conclu" + CHR(237) + "da")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CopiarMaxEntreEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

