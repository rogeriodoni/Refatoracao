# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 7/10
- Mensagem: Testes automaticos: 67% < 100%. Falhas: Teste 'CarregarLista': Function argument value, type, or count is invalid. | Detalhes: Linha: 358; Teste 'ModoIncluir': Function argument value, type, or count is invalid. | Detalhes: Linha: 444; Teste 'BtnEncerrarExiste': Function argument value, type, or count is invalid. | Detalhes: Linha: 1087, Proc: testebtnencerrarexiste

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-09-02 07:20:22] [INFO] Config FPW: (nao fornecido)
[2026-09-02 07:20:22] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 07:20:22] [INFO] Timeout: 300 segundos
[2026-09-02 07:20:22] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ll2fwvde.prg
[2026-09-02 07:20:22] [INFO] Conteudo do wrapper:
[2026-09-02 07:20:22] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSET', 'C:\4c\tasks\task521', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
QUIT

[2026-09-02 07:20:22] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ll2fwvde.prg
[2026-09-02 07:20:22] [INFO] VFP output esperado em: C:\4c\tasks\task521\vfp_output.txt
[2026-09-02 07:20:22] [INFO] Executando Visual FoxPro 9...
[2026-09-02 07:20:22] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ll2fwvde.prg
[2026-09-02 07:20:22] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ll2fwvde.prg
[2026-09-02 07:20:22] [INFO] Timeout configurado: 300 segundos
[2026-09-02 07:22:07] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-02 07:22:07] [INFO] VFP9 finalizado em 105.120007 segundos
[2026-09-02 07:22:07] [INFO] Exit Code: 
[2026-09-02 07:22:07] [INFO] 
[2026-09-02 07:22:07] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-02 07:22:07] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ll2fwvde.prg
[2026-09-02 07:22:07] [INFO] 
[2026-09-02 07:22:07] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-02 07:22:07] [INFO] * Auto-generated wrapper for parameters
[2026-09-02 07:22:07] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 07:22:07] [INFO] * Parameters: 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
[2026-09-02 07:22:07] [INFO] 
[2026-09-02 07:22:07] [INFO] * Anti-dialog protections for unattended execution
[2026-09-02 07:22:07] [INFO] SET SAFETY OFF
[2026-09-02 07:22:07] [INFO] SET RESOURCE OFF
[2026-09-02 07:22:07] [INFO] SET TALK OFF
[2026-09-02 07:22:07] [INFO] SET NOTIFY OFF
[2026-09-02 07:22:07] [INFO] SYS(2335, 0)
[2026-09-02 07:22:07] [INFO] 
[2026-09-02 07:22:07] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
[2026-09-02 07:22:07] [INFO] QUIT
[2026-09-02 07:22:07] [INFO] 
[2026-09-02 07:22:07] [INFO] === Fim do Wrapper.prg ===
[2026-09-02 07:22:07] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-09-02 08:22:21] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-02 08:22:21] [INFO] Config FPW: (nao fornecido)
[2026-09-02 08:22:21] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 08:22:21] [INFO] Timeout: 300 segundos
[2026-09-02 08:22:21] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_o4bzlw4i.prg
[2026-09-02 08:22:21] [INFO] Conteudo do wrapper:
[2026-09-02 08:22:21] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSET', 'C:\4c\tasks\task521', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
QUIT

[2026-09-02 08:22:21] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_o4bzlw4i.prg
[2026-09-02 08:22:21] [INFO] VFP output esperado em: C:\4c\tasks\task521\vfp_output.txt
[2026-09-02 08:22:21] [INFO] Executando Visual FoxPro 9...
[2026-09-02 08:22:21] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_o4bzlw4i.prg
[2026-09-02 08:22:21] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_o4bzlw4i.prg
[2026-09-02 08:22:21] [INFO] Timeout configurado: 300 segundos
[2026-09-02 08:24:07] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-02 08:24:07] [INFO] VFP9 finalizado em 105.4200975 segundos
[2026-09-02 08:24:07] [INFO] Exit Code: 
[2026-09-02 08:24:07] [INFO] 
[2026-09-02 08:24:07] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-02 08:24:07] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_o4bzlw4i.prg
[2026-09-02 08:24:07] [INFO] 
[2026-09-02 08:24:07] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-02 08:24:07] [INFO] * Auto-generated wrapper for parameters
[2026-09-02 08:24:07] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 08:24:07] [INFO] * Parameters: 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
[2026-09-02 08:24:07] [INFO] 
[2026-09-02 08:24:07] [INFO] * Anti-dialog protections for unattended execution
[2026-09-02 08:24:07] [INFO] SET SAFETY OFF
[2026-09-02 08:24:07] [INFO] SET RESOURCE OFF
[2026-09-02 08:24:07] [INFO] SET TALK OFF
[2026-09-02 08:24:07] [INFO] SET NOTIFY OFF
[2026-09-02 08:24:07] [INFO] SYS(2335, 0)
[2026-09-02 08:24:07] [INFO] 
[2026-09-02 08:24:07] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
[2026-09-02 08:24:07] [INFO] QUIT
[2026-09-02 08:24:07] [INFO] 
[2026-09-02 08:24:07] [INFO] === Fim do Wrapper.prg ===
[2026-09-02 08:24:07] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-09-02 08:47:50] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-02 08:47:50] [INFO] Config FPW: (nao fornecido)
[2026-09-02 08:47:50] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 08:47:50] [INFO] Timeout: 300 segundos
[2026-09-02 08:47:50] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wtghh1lv.prg
[2026-09-02 08:47:50] [INFO] Conteudo do wrapper:
[2026-09-02 08:47:50] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSET', 'C:\4c\tasks\task521', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
QUIT

[2026-09-02 08:47:50] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wtghh1lv.prg
[2026-09-02 08:47:50] [INFO] VFP output esperado em: C:\4c\tasks\task521\vfp_output.txt
[2026-09-02 08:47:50] [INFO] Executando Visual FoxPro 9...
[2026-09-02 08:47:50] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wtghh1lv.prg
[2026-09-02 08:47:50] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wtghh1lv.prg
[2026-09-02 08:47:50] [INFO] Timeout configurado: 300 segundos
[2026-09-02 08:49:35] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-02 08:49:35] [INFO] VFP9 finalizado em 105.0270608 segundos
[2026-09-02 08:49:35] [INFO] Exit Code: 
[2026-09-02 08:49:35] [INFO] 
[2026-09-02 08:49:35] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-02 08:49:35] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wtghh1lv.prg
[2026-09-02 08:49:35] [INFO] 
[2026-09-02 08:49:35] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-02 08:49:35] [INFO] * Auto-generated wrapper for parameters
[2026-09-02 08:49:35] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 08:49:35] [INFO] * Parameters: 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
[2026-09-02 08:49:35] [INFO] 
[2026-09-02 08:49:35] [INFO] * Anti-dialog protections for unattended execution
[2026-09-02 08:49:35] [INFO] SET SAFETY OFF
[2026-09-02 08:49:35] [INFO] SET RESOURCE OFF
[2026-09-02 08:49:35] [INFO] SET TALK OFF
[2026-09-02 08:49:35] [INFO] SET NOTIFY OFF
[2026-09-02 08:49:35] [INFO] SYS(2335, 0)
[2026-09-02 08:49:35] [INFO] 
[2026-09-02 08:49:35] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
[2026-09-02 08:49:35] [INFO] QUIT
[2026-09-02 08:49:35] [INFO] 
[2026-09-02 08:49:35] [INFO] === Fim do Wrapper.prg ===
[2026-09-02 08:49:35] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-09-02 09:15:17] [INFO] === VFP EXECUTOR v2.0 ===
[2026-09-02 09:15:17] [INFO] Config FPW: (nao fornecido)
[2026-09-02 09:15:17] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 09:15:17] [INFO] Timeout: 300 segundos
[2026-09-02 09:15:17] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xiotk5og.prg
[2026-09-02 09:15:17] [INFO] Conteudo do wrapper:
[2026-09-02 09:15:17] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSET', 'C:\4c\tasks\task521', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
QUIT

[2026-09-02 09:15:17] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xiotk5og.prg
[2026-09-02 09:15:17] [INFO] VFP output esperado em: C:\4c\tasks\task521\vfp_output.txt
[2026-09-02 09:15:17] [INFO] Executando Visual FoxPro 9...
[2026-09-02 09:15:17] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xiotk5og.prg
[2026-09-02 09:15:17] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xiotk5og.prg
[2026-09-02 09:15:17] [INFO] Timeout configurado: 300 segundos
[2026-09-02 09:17:11] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-09-02 09:17:11] [INFO] VFP9 finalizado em 113.1168634 segundos
[2026-09-02 09:17:11] [INFO] Exit Code: 
[2026-09-02 09:17:11] [INFO] 
[2026-09-02 09:17:11] [INFO] Arquivos temporarios preservados para inspecao:
[2026-09-02 09:17:11] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xiotk5og.prg
[2026-09-02 09:17:11] [INFO] 
[2026-09-02 09:17:11] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-09-02 09:17:11] [INFO] * Auto-generated wrapper for parameters
[2026-09-02 09:17:11] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-09-02 09:17:11] [INFO] * Parameters: 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
[2026-09-02 09:17:11] [INFO] 
[2026-09-02 09:17:11] [INFO] * Anti-dialog protections for unattended execution
[2026-09-02 09:17:11] [INFO] SET SAFETY OFF
[2026-09-02 09:17:11] [INFO] SET RESOURCE OFF
[2026-09-02 09:17:11] [INFO] SET TALK OFF
[2026-09-02 09:17:11] [INFO] SET NOTIFY OFF
[2026-09-02 09:17:11] [INFO] SYS(2335, 0)
[2026-09-02 09:17:11] [INFO] 
[2026-09-02 09:17:11] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSET', 'C:\4c\tasks\task521', 'CRUD'
[2026-09-02 09:17:11] [INFO] QUIT
[2026-09-02 09:17:11] [INFO] 
[2026-09-02 09:17:11] [INFO] === Fim do Wrapper.prg ===
[2026-09-02 09:17:11] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "FormSET",
  "timestamp": "20260902091710",
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
      "erro": "Function argument value, type, or count is invalid.",
      "detalhes": "Linha: 358"
    },
    {
      "nome": "ModoIncluir",
      "passou": false,
      "erro": "Function argument value, type, or count is invalid.",
      "detalhes": "Linha: 444"
    },
    {
      "nome": "ModoVisualizar",
      "passou": true,
      "erro": "Propriedade this_cModoAtual nao encontrada",
      "detalhes": ""
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnIncluirClick nao encontrado (OK para REPORT/OPERACIONAL)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": false,
      "erro": "Function argument value, type, or count is invalid.",
      "detalhes": "Linha: 1087, Proc: testebtnencerrarexiste"
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
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 0"
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSET.prg):
*==============================================================================
* FormSET.prg - Formulario de Cadastro de Setores
* Migrado de: SIGCDSET.SCX (frmcadastro)
* Tabela principal: SigCdSet (Setores)
* Tabela filha: SigCdSei (Localizacoes do Setor)
* Lookup: SigPrLcl (Localizacoes - Codigos/Descricaos)
*==============================================================================

DEFINE CLASS FormSET AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: exatos do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Setores"
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
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.WindowType = 0
        ENDIF
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
            THIS.this_oBusinessObject = CREATEOBJECT("SETBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar SETBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormSET.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible    = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormSET:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormSET.InicializarForm")
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
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Cria cabecalho, 5 botoes CRUD, grid de listagem e botao Encerrar
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado, Top=2+29=31)
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

        *-- Container Botoes CRUD (grupo_op canonico: Left=542, Top=29, Width=390)
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

        *-- Botao Incluir
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

        *-- Botao Visualizar
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

        *-- Botao Buscar
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

        *-- Container Saida canonico (CLAUDE.md #10: Left=917, Width=90)
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

        *-- Grid principal (Grade legado: colunas Setores/Descrs, Top=88+29=117)
        *-- ColumnCount fora do WITH para criacao imediata das colunas (Problema 36)
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oPagina.grd_4c_Dados.ColumnCount = 2
        WITH loc_oPagina.grd_4c_Dados
            .Top                = 117
            .Left               = 12
            .Width              = 890
            .Height             = 450
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
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Dados) - FASE 5/8 (primeira metade)
    * Controles: cnt_4c_Salva, lbl_4c_Setor, txt_4c_Setores, lbl_4c_Descricao
    * Demais controles (txt_4c_Descrs, lbl_4c_Localizacoes, grd_4c_Localizacoes,
    *   cmd_4c_Apagar) adicionados na Fase 6/8
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salva (canonico: Left=842, Top=4+29=33, Width=160, Height=85)
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(255, 255, 255)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (salva.Left=5)
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar (cancelar.Left=88)
        loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 88
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
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *-- Label Setor (Label6: Left=141, Top=141+29=170, ForeColor=36,84,155)
        loc_oPagina.AddObject("lbl_4c_Setor", "Label")
        WITH loc_oPagina.lbl_4c_Setor
            .Caption   = "Setor :"
            .Top       = 170
            .Left      = 141
            .Width     = 42
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Setores (getSetores: Left=185, Top=138+29=167, Width=80, MaxLength=10)
        loc_oPagina.AddObject("txt_4c_Setores", "TextBox")
        WITH loc_oPagina.txt_4c_Setores
            .Value     = ""
            .Top       = 167
            .Left      = 185
            .Width     = 80
            .Height    = 20
            .FontName  = "Verdana"
            .FontSize  = 8
            .MaxLength = 10
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Descricao (Label7: Left=298, Top=141+29=170, ForeColor=36,84,155)
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 170
            .Left      = 298
            .Width     = 67
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- TextBox Descricao (getDescrs: Left=366, Top=138+29=167, Width=290)
        loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
        WITH loc_oPagina.txt_4c_Descrs
            .Value     = ""
            .Top       = 167
            .Left      = 366
            .Width     = 290
            .Height    = 20
            .FontName  = "Verdana"
            .FontSize  = 8
            .MaxLength = 40
            .Enabled   = .F.
            .Visible   = .T.
        ENDWITH

        *-- Label Localizacoes (Label8: Left=201, Top=185+29=214)
        loc_oPagina.AddObject("lbl_4c_Localizacoes", "Label")
        WITH loc_oPagina.lbl_4c_Localizacoes
            .Caption   = "Localiza" + CHR(231) + CHR(245) + "es :"
            .Top       = 214
            .Left      = 201
            .Width     = 82
            .Height    = 15
            .FontName  = "Verdana"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(36, 84, 155)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Grid Localizacoes (grdLocalizacoes: Left=289, Top=183+29=212, Width=261, Height=274)
        *-- ColumnCount fora do WITH para garantir criacao imediata das colunas (Problema 36)
        loc_oPagina.AddObject("grd_4c_Localizacoes", "Grid")
        loc_oPagina.grd_4c_Localizacoes.ColumnCount = 2
        WITH loc_oPagina.grd_4c_Localizacoes
            .Top                = 212
            .Left               = 289
            .Width              = 261
            .Height             = 274
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(0, 0, 0)
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
        ENDWITH

        WITH loc_oPagina.grd_4c_Localizacoes.Column1
            .Width             = 80
            .Movable           = .F.
            .Resizable         = .F.
            .Header1.Caption   = "Localiza" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
        ENDWITH

        WITH loc_oPagina.grd_4c_Localizacoes.Column2
            .Width             = 150
            .Movable           = .F.
            .Resizable         = .F.
            .ReadOnly          = .T.
            .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Header1.Alignment = 2
        ENDWITH

        *-- BINDEVENTs para grid de localizacoes (KeyPress=F4 lookup, AfterRowColChange=validacao)
        BINDEVENT(loc_oPagina.grd_4c_Localizacoes, "KeyPress", THIS, "GridLocalizacoesKeyPress")
        BINDEVENT(loc_oPagina.grd_4c_Localizacoes, "AfterRowColChange", THIS, "GridLocAftRowColChange")

        *-- Botao Apagar linha do grid
        *-- Original: cmdApagar(group) Left=559, Top=295+29=324; Command1: Left=5, Top=5, W=40, H=40
        *-- Posicao absoluta: Left=564, Top=329
        loc_oPagina.AddObject("cmd_4c_Apagar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Apagar
            .Caption         = ""
            .Picture         = gc_4c_CaminhoIcones + "a_misc6.bmp"
            .PicturePosition = 0
            .ToolTipText     = "Excluir"
            .Top             = 329
            .Left            = 564
            .Width           = 40
            .Height          = 40
            .FontName        = "Verdana"
            .FontSize        = 8
            .ForeColor       = RGB(36, 84, 155)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Enabled         = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Apagar, "Click", THIS, "BtnApagarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega registros de SigCdSet no grid da Page1
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

                    *-- RecordSource fora de WITH para garantir auto-bind antes de override
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    WITH loc_oGrid
                        .Column1.ControlSource = "cursor_4c_Dados.Setores"
                        .Column1.Width         = 100
                        .Column2.ControlSource = "cursor_4c_Dados.Descrs"
                        .Column2.Width         = 780
                    ENDWITH

                    *-- Reconfigurar headers apos RecordSource (resetados pelo auto-bind)
                    loc_oGrid.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                "FormSET.CarregarLista")
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

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina

            IF par_nPagina = 1
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF
            ENDIF

            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "FormSET.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid de listagem
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Preparar novo setor e ir para Page2
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPg2, loc_oGrid
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()

        *-- Configurar grid apos LimparCampos (cabecalhos resetados pelo auto-bind)
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        IF PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
            loc_oGrid = loc_oPg2.grd_4c_Localizacoes
            loc_oGrid.ColumnCount = 2
            loc_oGrid.RecordSource = "cursor_4c_Localizacoes"
            WITH loc_oGrid
                .Column1.ControlSource = "cursor_4c_Localizacoes.Locals"
                .Column2.ControlSource = "cursor_4c_Localizacoes.Descricaos"
            ENDWITH
            loc_oGrid.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
            loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oGrid.Refresh()
        ENDIF

        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Visualizar setor selecionado (somente leitura)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cSetores, loc_lCarregou
        loc_lCarregou = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        loc_cSetores = ALLTRIM(cursor_4c_Dados.Setores)

        TRY
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSetores)
        CATCH TO loException
            MostrarErro("Erro ao carregar setor:" + CHR(13) + loException.Message, ;
                "FormSET.BtnVisualizarClick")
        ENDTRY

        IF loc_lCarregou
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Alterar setor selecionado
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cSetores, loc_lCarregou, loc_oPg2Alt
        loc_lCarregou = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        loc_cSetores = ALLTRIM(cursor_4c_Dados.Setores)

        TRY
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSetores)
        CATCH TO loException
            MostrarErro("Erro ao carregar setor:" + CHR(13) + loException.Message, ;
                "FormSET.BtnAlterarClick")
        ENDTRY

        IF loc_lCarregou
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()

            *-- Adicionar linha em branco ao final para nova entrada no modo ALTERAR
            IF USED("cursor_4c_Localizacoes")
                SELECT cursor_4c_Localizacoes
                INSERT INTO cursor_4c_Localizacoes (Setores, Locals, Descricaos) VALUES ("", "", "")
                loc_oPg2Alt = THIS.pgf_4c_Paginas.Page2
                IF PEMSTATUS(loc_oPg2Alt, "grd_4c_Localizacoes", 5)
                    loc_oPg2Alt.grd_4c_Localizacoes.Refresh()
                ENDIF
            ENDIF

            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Excluir setor selecionado com confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cSetores, loc_lCarregou, loc_lConfirmado
        loc_lCarregou   = .F.
        loc_lConfirmado = .F.

        IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        SELECT cursor_4c_Dados
        IF EOF("cursor_4c_Dados")
            MsgAviso("Nenhum registro selecionado.", "")
            RETURN
        ENDIF

        loc_cSetores = ALLTRIM(cursor_4c_Dados.Setores)

        TRY
            loc_lCarregou = THIS.this_oBusinessObject.CarregarPorCodigo(loc_cSetores)
        CATCH TO loException
            MostrarErro("Erro ao carregar setor:" + CHR(13) + loException.Message, ;
                "FormSET.BtnExcluirClick")
        ENDTRY

        IF loc_lCarregou
            loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do setor '" + ;
                ALLTRIM(THIS.this_oBusinessObject.this_cSetores) + "'?", ;
                "Excluir Setor")

            IF loc_lConfirmado
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Setor exclu" + CHR(237) + "do com sucesso!")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Recarrega a lista de setores
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Confirmar: valida e salva setor + localizacoes
    * Logica baseada em salva.Click do legado (SIGCDSET.pagina.dados.grupo_salva)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg2, loc_cSetores, loc_cDescrs, loc_lTemLocalizacao, loc_lSucesso
        loc_oPg2            = THIS.pgf_4c_Paginas.Page2
        loc_lTemLocalizacao = .F.
        loc_lSucesso        = .F.

        *-- Modo EXCLUIR: Confirmar executa a exclusao definitiva
        IF THIS.this_cModoAtual = "EXCLUIR"
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Setor exclu" + CHR(237) + "do com sucesso!")
                THIS.AlternarPagina(1)
            ENDIF
            RETURN
        ENDIF

        *-- Validar campos obrigatorios (FORA do TRY - RETURN permitido aqui)
        loc_cSetores = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Setores", 5)
            loc_cSetores = ALLTRIM(loc_oPg2.txt_4c_Setores.Value)
        ENDIF

        IF EMPTY(loc_cSetores)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Setor!", "")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Setores", 5)
                loc_oPg2.txt_4c_Setores.SetFocus
            ENDIF
            RETURN
        ENDIF

        loc_cDescrs = ""
        IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
            loc_cDescrs = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
        ENDIF

        IF EMPTY(loc_cDescrs)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Descri" + CHR(231) + CHR(227) + "o!", "")
            IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
                loc_oPg2.txt_4c_Descrs.SetFocus
            ENDIF
            RETURN
        ENDIF

        *-- Validar pelo menos uma localizacao com codigo preenchido
        IF USED("cursor_4c_Localizacoes")
            SELECT cursor_4c_Localizacoes
            SCAN
                IF !EMPTY(ALLTRIM(Locals))
                    loc_lTemLocalizacao = .T.
                    EXIT
                ENDIF
            ENDSCAN
        ENDIF

        IF !loc_lTemLocalizacao
            MsgAviso("N" + CHR(227) + "o Foram Cadastradas Localiza" + CHR(231) + CHR(245) + "es!", "")
            IF PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
                loc_oPg2.grd_4c_Localizacoes.SetFocus
            ENDIF
            RETURN
        ENDIF

        *-- Para INCLUIR: verificar se codigo ja existe em SigCdSet
        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarSetorExistente(loc_cSetores)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "")
                IF PEMSTATUS(loc_oPg2, "txt_4c_Setores", 5)
                    loc_oPg2.txt_4c_Setores.SetFocus
                ENDIF
                RETURN
            ENDIF
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                THIS.this_oBusinessObject.SalvarLocalizacoes(;
                    ALLTRIM(THIS.this_oBusinessObject.this_cSetores), ;
                    "cursor_4c_Localizacoes")
                MsgInfo("Setor salvo com sucesso!")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar Setor:" + CHR(13) + loException.Message, ;
                "FormSET.BtnSalvarClick")
        ENDTRY

        IF loc_lSucesso
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancelar edicao e retornar a lista
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(1)
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do BO para controles do formulario
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Setores", 5)
            loc_oPg2.txt_4c_Setores.Value = ALLTRIM(THIS.this_oBusinessObject.this_cSetores)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
            loc_oPg2.txt_4c_Descrs.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
        ENDIF

        *-- Carrega localizacoes no grid (SigCdSei enriquecido com SigPrLcl)
        THIS.this_oBusinessObject.CarregarLocalizacoes(THIS.this_oBusinessObject.this_cSetores)

        IF PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
            loc_oPg2.grd_4c_Localizacoes.ColumnCount = 2
            loc_oPg2.grd_4c_Localizacoes.RecordSource = "cursor_4c_Localizacoes"
            WITH loc_oPg2.grd_4c_Localizacoes
                .Column1.ControlSource = "cursor_4c_Localizacoes.Locals"
                .Column2.ControlSource = "cursor_4c_Localizacoes.Descricaos"
            ENDWITH
            loc_oPg2.grd_4c_Localizacoes.Column1.Header1.Caption = "Localiza" + CHR(231) + CHR(227) + "o"
            loc_oPg2.grd_4c_Localizacoes.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
            loc_oPg2.grd_4c_Localizacoes.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere valores dos controles do formulario para o BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Setores", 5)
            THIS.this_oBusinessObject.this_cSetores = ALLTRIM(loc_oPg2.txt_4c_Setores.Value)
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
            THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPg2.txt_4c_Descrs.Value)
        ENDIF
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita controles editaveis do formulario
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        *-- Codigo editavel apenas no modo INCLUIR
        IF PEMSTATUS(loc_oPg2, "txt_4c_Setores", 5)
            loc_oPg2.txt_4c_Setores.Enabled = ;
                (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
            loc_oPg2.txt_4c_Descrs.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
            loc_oPg2.grd_4c_Localizacoes.ReadOnly = !par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cmd_4c_Apagar", 5)
            loc_oPg2.cmd_4c_Apagar.Visible = (par_lHabilitar AND ;
                INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR"))
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
                    (par_lHabilitar OR THIS.this_cModoAtual = "EXCLUIR")
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa os valores dos controles do formulario
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPg2, "txt_4c_Setores", 5)
            loc_oPg2.txt_4c_Setores.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPg2, "txt_4c_Descrs", 5)
            loc_oPg2.txt_4c_Descrs.Value = ""
        ENDIF

        *-- Preparar cursor de localizacoes para edicao (cria se nao existe)
        IF USED("cursor_4c_Localizacoes")
            SELECT cursor_4c_Localizacoes
            ZAP
        ELSE
            SET NULL ON
            CREATE CURSOR cursor_4c_Localizacoes (Setores C(10), Locals C(10), Descricaos C(20))
            SET NULL OFF
        ENDIF

        *-- Linha em branco inicial para permitir nova entrada no grid
        INSERT INTO cursor_4c_Localizacoes (Setores, Locals, Descricaos) VALUES ("", "", "")
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Itera Pages de PageFrames e Controls de Containers
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
    * GridLocalizacoesKeyPress - Handler KeyPress do grid de localizacoes
    * BINDEVENT: requer par_nKeyCode + par_nShiftAltCtrl (PUBLICO)
    *===========================================================================
    PROCEDURE GridLocalizacoesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oPg2, loc_oGrid
        *-- F4 (keycode=63): abrir lookup de localizacoes na coluna 1
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            loc_oPg2  = THIS.pgf_4c_Paginas.Page2
            IF PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
                loc_oGrid = loc_oPg2.grd_4c_Localizacoes
                IF loc_oGrid.ActiveColumn = 1
                    THIS.AbrirLookupLocalizacao()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *===========================================================================
    * GridLocAftRowColChange - Handler AfterRowColChange do grid de localizacoes
    * BINDEVENT: requer par_nColIndex (PUBLICO)
    *===========================================================================
    PROCEDURE GridLocAftRowColChange(par_nColIndex)
        *-- Valida codigo ao sair da coluna Locals (col 1)
        IF par_nColIndex = 1
            THIS.ValidarLocalizacaoGrid()
        ENDIF
    ENDPROC

    *===========================================================================
    * AbrirLookupLocalizacao - Lookup FormBuscaAuxiliar para SigPrLcl
    * Preenche Locals + Descricaos na linha atual do cursor_4c_Localizacoes
    *===========================================================================
    PROCEDURE AbrirLookupLocalizacao()
        LOCAL loc_oPg2, loc_oGrid, loc_cLocAtual, loc_oFA
        LOCAL loc_cCodigo, loc_cDescricao, loc_nRecAtual, loc_lDuplic, loc_cSetorAtual
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_cLocAtual = ""
        loc_lDuplic   = .F.

        IF !PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
            RETURN
        ENDIF

        loc_oGrid = loc_oPg2.grd_4c_Localizacoes

        IF !USED("cursor_4c_Localizacoes") OR EOF("cursor_4c_Localizacoes")
            RETURN
        ENDIF

        SELECT cursor_4c_Localizacoes
        loc_nRecAtual = RECNO()
        loc_cLocAtual = ALLTRIM(Locals)

        TRY
            loc_oFA = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrLcl", "cursor_4c_BuscaLocal", "Codigos", loc_cLocAtual, ;
                "Localiza" + CHR(231) + CHR(227) + "o")

            IF VARTYPE(loc_oFA) = "O"
                IF !loc_oFA.this_lAchouRegistro
                    loc_oFA.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oFA.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oFA.Show()
                ENDIF

                IF loc_oFA.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
                    SELECT cursor_4c_BuscaLocal
                    IF !EOF()
                        loc_cCodigo    = ALLTRIM(cursor_4c_BuscaLocal.Codigos)
                        loc_cDescricao = ALLTRIM(cursor_4c_BuscaLocal.Descricaos)

                        *-- Verificar duplicata (outra linha com mesmo codigo)
                        SELECT cursor_4c_Localizacoes
                        GO loc_nRecAtual
                        SCAN
                            IF RECNO() != loc_nRecAtual AND ALLTRIM(Locals) = loc_cCodigo
                                loc_lDuplic = .T.
                                EXIT
                            ENDIF
                        ENDSCAN
                        GO loc_nRecAtual

                        IF loc_lDuplic
                            MsgAviso("Esta localiza" + CHR(231) + CHR(227) + "o j" + ;
                                CHR(225) + " foi adicionada!", "")
                        ELSE
                            *-- Verificar se pertence a outro setor
                            loc_cSetorAtual = ALLTRIM(THIS.this_oBusinessObject.this_cSetores)
                            IF EMPTY(loc_cSetorAtual) AND PEMSTATUS(loc_oPg2, "txt_4c_Setores", 5)
                                loc_cSetorAtual = ALLTRIM(loc_oPg2.txt_4c_Setores.Value)
                            ENDIF

                            IF !EMPTY(loc_cSetorAtual) AND ;
                                THIS.this_oBusinessObject.ValidarLocalizacaoOutroSetor(;
                                    loc_cCodigo, loc_cSetorAtual)
                                MsgAviso("Esta localiza" + CHR(231) + CHR(227) + "o j" + ;
                                    CHR(225) + " pertence a outro Setor!", "")
                            ELSE
                                SELECT cursor_4c_Localizacoes
                                GO loc_nRecAtual
                                REPLACE Locals     WITH loc_cCodigo
                                REPLACE Descricaos WITH loc_cDescricao
                                THIS.GarantirLinhaEmBranco()
                                loc_oGrid.Refresh()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF

                loc_oFA = .NULL.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao abrir lookup de localiza" + CHR(231) + CHR(245) + "es:" + ;
                CHR(13) + loException.Message, "FormSET.AbrirLookupLocalizacao")
        ENDTRY
    ENDPROC

    *===========================================================================
    * ValidarLocalizacaoGrid - Valida codigo digitado na coluna Locals do grid
    * Chamado por GridLocAftRowColChange ao sair da coluna 1
    *===========================================================================
    PROCEDURE ValidarLocalizacaoGrid()
        LOCAL loc_oPg2, loc_cLocais, loc_nRecAtual, loc_lAchou
        LOCAL loc_cSetorAtual, loc_lDuplic, loc_cDesc
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lAchou  = .F.
        loc_lDuplic = .F.
        loc_cDesc   = ""

        IF !PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
            RETURN
        ENDIF

        IF !USED("cursor_4c_Localizacoes") OR EOF("cursor_4c_Localizacoes")
            RETURN
        ENDIF

        SELECT cursor_4c_Localizacoes
        loc_nRecAtual = RECNO()
        loc_cLocais   = ALLTRIM(Locals)

        IF EMPTY(loc_cLocais)
            THIS.GarantirLinhaEmBranco()
            RETURN
        ENDIF

        TRY
            loc_lAchou = THIS.this_oBusinessObject.BuscarLocalizacao(loc_cLocais)
        CATCH TO loException
            MostrarErro("Erro ao validar localiza" + CHR(231) + CHR(227) + "o:" + ;
                CHR(13) + loException.Message, "FormSET.ValidarLocalizacaoGrid")
            RETURN
        ENDTRY

        IF !loc_lAchou
            SELECT cursor_4c_Localizacoes
            GO loc_nRecAtual
            REPLACE Locals     WITH ""
            REPLACE Descricaos WITH ""
            THIS.AbrirLookupLocalizacao()
            RETURN
        ENDIF

        IF USED("cursor_4c_BuscaLocal") AND !EOF("cursor_4c_BuscaLocal")
            SELECT cursor_4c_BuscaLocal
            loc_cDesc = ALLTRIM(cursor_4c_BuscaLocal.Descricaos)

            *-- Verificar duplicata
            SELECT cursor_4c_Localizacoes
            GO loc_nRecAtual
            SCAN
                IF RECNO() != loc_nRecAtual AND ALLTRIM(Locals) = loc_cLocais
                    loc_lDuplic = .T.
                    EXIT
                ENDIF
            ENDSCAN
            GO loc_nRecAtual

            IF loc_lDuplic
                MsgAviso("Esta localiza" + CHR(231) + CHR(227) + "o j" + ;
                    CHR(225) + " foi adicionada!", "")
                REPLACE Locals     WITH ""
                REPLACE Descricaos WITH ""
            ELSE
                *-- Verificar se pertence a outro setor
                loc_cSetorAtual = ALLTRIM(THIS.this_oBusinessObject.this_cSetores)
                IF EMPTY(loc_cSetorAtual) AND PEMSTATUS(loc_oPg2, "txt_4c_Setores", 5)
                    loc_cSetorAtual = ALLTRIM(loc_oPg2.txt_4c_Setores.Value)
                ENDIF

                IF !EMPTY(loc_cSetorAtual) AND ;
                    THIS.this_oBusinessObject.ValidarLocalizacaoOutroSetor(;
                        loc_cLocais, loc_cSetorAtual)
                    MsgAviso("Esta localiza" + CHR(231) + CHR(227) + "o j" + ;
                        CHR(225) + " pertence a outro Setor!", "")
                    SELECT cursor_4c_Localizacoes
                    GO loc_nRecAtual
                    REPLACE Locals     WITH ""
                    REPLACE Descricaos WITH ""
                ELSE
                    SELECT cursor_4c_Localizacoes
                    GO loc_nRecAtual
                    REPLACE Descricaos WITH loc_cDesc
                ENDIF
            ENDIF
        ENDIF

        THIS.GarantirLinhaEmBranco()
        IF PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
            loc_oPg2.grd_4c_Localizacoes.Refresh()
        ENDIF
    ENDPROC

    *===========================================================================
    * GarantirLinhaEmBranco - Garante linha em branco ao final do cursor
    * Permite ao usuario digitar nova localizacao apos preencher a anterior
    *===========================================================================
    PROTECTED PROCEDURE GarantirLinhaEmBranco()
        IF !USED("cursor_4c_Localizacoes")
            RETURN
        ENDIF

        SELECT cursor_4c_Localizacoes
        GO BOTTOM
        IF !EMPTY(ALLTRIM(Locals))
            INSERT INTO cursor_4c_Localizacoes (Setores, Locals, Descricaos) VALUES ("", "", "")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnApagarClick - Apaga localizacao da linha atual (limpa Locals/Descricaos)
    * SalvarLocalizacoes ignora linhas com Locals vazio
    *===========================================================================
    PROCEDURE BtnApagarClick()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF !PEMSTATUS(loc_oPg2, "grd_4c_Localizacoes", 5)
            RETURN
        ENDIF

        IF !USED("cursor_4c_Localizacoes") OR EOF("cursor_4c_Localizacoes")
            RETURN
        ENDIF

        SELECT cursor_4c_Localizacoes
        IF EMPTY(ALLTRIM(Locals))
            RETURN
        ENDIF

        REPLACE Locals     WITH ""
        REPLACE Descricaos WITH ""

        THIS.GarantirLinhaEmBranco()
        loc_oPg2.grd_4c_Localizacoes.Refresh()
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme this_cModoAtual
    * LISTA: CRUD habilitados | INCLUIR/ALTERAR/VISUALIZAR/EXCLUIR: CRUD desabilitados
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oPg2, loc_lEmEdicao, loc_oCnt
        loc_oPg1      = THIS.pgf_4c_Paginas.Page1
        loc_oPg2      = THIS.pgf_4c_Paginas.Page2
        loc_lEmEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR", "EXCLUIR")

        IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
            loc_oCnt = loc_oPg1.cnt_4c_Botoes
            IF PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
                loc_oCnt.cmd_4c_Incluir.Enabled = !loc_lEmEdicao
            ENDIF
            IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
                loc_oCnt.cmd_4c_Visualizar.Enabled = !loc_lEmEdicao
            ENDIF
            IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
                loc_oCnt.cmd_4c_Alterar.Enabled = !loc_lEmEdicao
            ENDIF
            IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
                loc_oCnt.cmd_4c_Excluir.Enabled = !loc_lEmEdicao
            ENDIF
            IF PEMSTATUS(loc_oCnt, "cmd_4c_Buscar", 5)
                loc_oCnt.cmd_4c_Buscar.Enabled = !loc_lEmEdicao
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg1, "cnt_4c_Saida", 5)
            IF PEMSTATUS(loc_oPg1.cnt_4c_Saida, "cmd_4c_Encerrar", 5)
                loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = !loc_lEmEdicao
            ENDIF
        ENDIF

        IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
            IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
                loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
                    INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "EXCLUIR")
            ENDIF
        ENDIF
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

        IF USED("cursor_4c_Localizacoes")
            USE IN cursor_4c_Localizacoes
        ENDIF

        IF USED("cursor_4c_BuscaLocal")
            USE IN cursor_4c_BuscaLocal
        ENDIF

        IF USED("cursor_4c_VldLcl")
            USE IN cursor_4c_VldLcl
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SETBO.prg):
*==============================================================================
* SETBO.prg
*
* Business Object para Cadastro de Setores
* Tabela principal: SigCdSet
* Tabela filha: SigCdSei (Localizacoes do Setor)
* Lookup: SigPrLcl (Localizacoes - codigo/descricao)
* Herda de: BusinessBase
*
* Colunas SigCdSet:
*   setores   char(10)  PK - Codigo do Setor
*   descrs    char(40)  Descricao do Setor
*
* Colunas SigCdSei:
*   cidchaves char(20)  PK - Chave unica
*   setores   char(10)  FK -> SigCdSet.setores
*   locals    char(10)  Codigo de Localizacao (FK -> SigPrLcl.codigos)
*==============================================================================

DEFINE CLASS SETBO AS BusinessBase

    *-- Propriedades da entidade principal (SigCdSet)
    this_cSetores = ""   && setores  char(10)  PK - Codigo do Setor
    this_cDescrs  = ""   && descrs   char(40)  Descricao do Setor

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdSet"
            THIS.this_cCampoChave = "Setores"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cSetores)
    ENDFUNC

    *==========================================================================
    * NovoRegistro - Prepara BO para INSERT
    *==========================================================================
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cSetores        = ""
        THIS.this_cDescrs         = ""
        THIS.this_lNovoRegistro   = .T.
    ENDPROC

    *==========================================================================
    * EditarRegistro - Prepara BO para UPDATE
    *==========================================================================
    PROCEDURE EditarRegistro()
        DODEFAULT()
        THIS.this_lNovoRegistro = .F.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSetores = TratarNulo(Setores, "C")
            THIS.this_cDescrs  = TratarNulo(Descrs,  "C")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT em SigCdSet para preencher cursor_4c_Dados
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT Setores, Descrs" + ;
                       " FROM SigCdSet" + ;
                       " ORDER BY Setores"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") >= 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar Setores:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo do setor
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT Setores, Descrs" + ;
                       " FROM SigCdSet" + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.CarregarPorCodigo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CarregarLocalizacoes - Carrega localizacoes do setor em cursor
    *   Enriquece Locals com Descricaos de SigPrLcl
    *   Resultado: cursor_4c_Localizacoes (Setores, Locals, Descricaos)
    *==========================================================================
    FUNCTION CarregarLocalizacoes(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Localizacoes")
                USE IN cursor_4c_Localizacoes
            ENDIF

            loc_cSQL = "SELECT a.Setores, a.Locals AS Locals," + ;
                       " ISNULL(b.Descricaos, SPACE(20)) AS Descricaos" + ;
                       " FROM SigCdSei a" + ;
                       " LEFT JOIN SigPrLcl b ON b.Codigos = a.Locals" + ;
                       " WHERE a.Setores = " + EscaparSQL(ALLTRIM(par_cSetores)) + ;
                       " ORDER BY a.Locals"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Localizacoes")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Localizacoes") AND RECCOUNT("cursor_4c_Localizacoes") >= 0
                    GO TOP IN cursor_4c_Localizacoes
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar localizacoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.CarregarLocalizacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarLocalizacaoDuplicada - Verifica se Locals ja existe no setor
    *==========================================================================
    FUNCTION ValidarLocalizacaoDuplicada(par_cLocals, par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            IF USED("cursor_4c_VldLocal")
                USE IN cursor_4c_VldLocal
            ENDIF

            loc_cSQL = "SELECT COUNT(1) AS Qt" + ;
                       " FROM SigCdSei" + ;
                       " WHERE Locals  = " + EscaparSQL(ALLTRIM(par_cLocals)) + ;
                       " AND   Setores = " + EscaparSQL(ALLTRIM(par_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldLocal")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldLocal") > 0
                SELECT cursor_4c_VldLocal
                loc_lDuplicado = (Qt > 0)
            ENDIF

            IF USED("cursor_4c_VldLocal")
                USE IN cursor_4c_VldLocal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ValidarLocalizacaoDuplicada")
        ENDTRY
        RETURN loc_lDuplicado
    ENDFUNC

    *==========================================================================
    * ValidarLocalizacaoOutroSetor - Verifica se Locals pertence a outro setor
    *==========================================================================
    FUNCTION ValidarLocalizacaoOutroSetor(par_cLocals, par_cSetoresAtual)
        LOCAL loc_cSQL, loc_nResult, loc_cSetorExistente
        loc_cSetorExistente = ""
        TRY
            IF USED("cursor_4c_VldSetor")
                USE IN cursor_4c_VldSetor
            ENDIF

            loc_cSQL = "SELECT TOP 1 Setores" + ;
                       " FROM SigCdSei" + ;
                       " WHERE Locals  = " + EscaparSQL(ALLTRIM(par_cLocals)) + ;
                       " AND   Setores <> " + EscaparSQL(ALLTRIM(par_cSetoresAtual))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldSetor")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldSetor") > 0
                SELECT cursor_4c_VldSetor
                loc_cSetorExistente = ALLTRIM(Setores)
            ENDIF

            IF USED("cursor_4c_VldSetor")
                USE IN cursor_4c_VldSetor
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ValidarLocalizacaoOutroSetor")
        ENDTRY
        RETURN loc_cSetorExistente
    ENDFUNC

    *==========================================================================
    * BuscarLocalizacao - Lookup em SigPrLcl pelo codigo
    *   Resultado: cursor_4c_BuscaLocal (Codigos, Descricaos)
    *==========================================================================
    FUNCTION BuscarLocalizacao(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_BuscaLocal")
                USE IN cursor_4c_BuscaLocal
            ENDIF

            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT Codigos, Descricaos FROM SigPrLcl ORDER BY Codigos"
            ELSE
                loc_cSQL = "SELECT Codigos, Descricaos" + ;
                           " FROM SigPrLcl" + ;
                           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaLocal")
                TABLEREVERT(.T., "cursor_4c_BuscaLocal")
                USE IN cursor_4c_BuscaLocal
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaLocal")

            IF loc_nResult >= 0
                IF USED("cursor_4c_BuscaLocal") AND RECCOUNT("cursor_4c_BuscaLocal") >= 0
                    GO TOP IN cursor_4c_BuscaLocal
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar localiza" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.BuscarLocalizacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * VerificarSetorExistente - Verifica se codigo de setor ja existe
    *==========================================================================
    FUNCTION VerificarSetorExistente(par_cSetores)
        LOCAL loc_cSQL, loc_nResult, loc_lExiste
        loc_lExiste = .F.
        TRY
            IF USED("cursor_4c_VldSet")
                USE IN cursor_4c_VldSet
            ENDIF

            loc_cSQL = "SELECT TOP 1 Setores FROM SigCdSet" + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldSet")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VldSet") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_VldSet")
                USE IN cursor_4c_VldSet
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.VerificarSetorExistente")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *==========================================================================
    * Inserir (PROTECTED) - INSERT em SigCdSet
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdSet (Setores, Descrs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cSetores)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescrs))  + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar (PROTECTED) - UPDATE em SigCdSet
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdSet SET" + ;
                       " Descrs = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ;
                       " WHERE Setores = " + EscaparSQL(ALLTRIM(THIS.this_cSetores))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao (PROTECTED) - DELETE em SigCdSet e SigCdSei
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdSei WHERE Setores = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cSetores))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdSet WHERE Setores = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cSetores))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir localiza" + CHR(231) + CHR(245) + "es do Setor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarLocalizacoes - Sincroniza SigCdSei com cursor de localizacoes
    *   par_cSetores    - Codigo do setor
    *   par_cCursorSei  - Nome do cursor com registros a salvar (Locals, Descricaos)
    *==========================================================================
    FUNCTION SalvarLocalizacoes(par_cSetores, par_cCursorSei)
        LOCAL loc_cSQL, loc_lSucesso, loc_cLocals, loc_cIdChave
        loc_lSucesso = .F.
        TRY
            *-- Delete all existing localizations for the setor (replace-all approach)
            *-- This ensures removed/changed rows are cleaned from SigCdSei
            loc_cSQL = "DELETE FROM SigCdSei WHERE Setores = " + EscaparSQL(ALLTRIM(par_cSetores))
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Insert all non-empty locals from cursor
            IF USED(par_cCursorSei) AND RECCOUNT(par_cCursorSei) > 0
                SELECT (par_cCursorSei)
                SCAN FOR !EMPTY(ALLTRIM(Locals))
                    loc_cLocals  = ALLTRIM(Locals)
                    loc_cIdChave = LOWER(SYS(2015)) + TRANSFORM(SECONDS(), "@L")
                    loc_cSQL = "INSERT INTO SigCdSei (cidchaves, Setores, Locals)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cIdChave) + ", " + ;
                               EscaparSQL(ALLTRIM(par_cSetores)) + ", " + ;
                               EscaparSQL(loc_cLocals) + ")"
                    SQLEXEC(gnConnHandle, loc_cSQL)
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SETBO.SalvarLocalizacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

