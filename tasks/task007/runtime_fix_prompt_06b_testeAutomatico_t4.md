# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 4/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[10/04/2026 09:19:50 PM] Erro: Erro ao inicializar formulario Formcfo: | Property BORDERSTYLE is not found.


### LOG DA ETAPA (06b_testeAutomatico):
[2026-04-10 21:14:10] [INFO] Config FPW: (nao fornecido)
[2026-04-10 21:14:10] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-10 21:14:10] [INFO] Timeout: 300 segundos
[2026-04-10 21:14:11] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_4oy3va1y.prg
[2026-04-10 21:14:11] [INFO] Conteudo do wrapper:
[2026-04-10 21:14:11] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
QUIT

[2026-04-10 21:14:11] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_4oy3va1y.prg
[2026-04-10 21:14:11] [INFO] VFP output esperado em: C:\4c\tasks\task007\vfp_output.txt
[2026-04-10 21:14:11] [INFO] Executando Visual FoxPro 9...
[2026-04-10 21:14:11] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_4oy3va1y.prg
[2026-04-10 21:14:11] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_4oy3va1y.prg
[2026-04-10 21:14:11] [INFO] Timeout configurado: 300 segundos
[2026-04-10 21:14:12] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-10 21:14:12] [INFO] VFP9 finalizado em 1.7429695 segundos
[2026-04-10 21:14:12] [INFO] Exit Code: 
[2026-04-10 21:14:12] [INFO] 
[2026-04-10 21:14:12] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-10 21:14:12] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_4oy3va1y.prg
[2026-04-10 21:14:12] [INFO] 
[2026-04-10 21:14:12] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-10 21:14:12] [INFO] * Auto-generated wrapper for parameters
[2026-04-10 21:14:12] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-10 21:14:12] [INFO] * Parameters: 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
[2026-04-10 21:14:12] [INFO] 
[2026-04-10 21:14:13] [INFO] * Anti-dialog protections for unattended execution
[2026-04-10 21:14:13] [INFO] SET SAFETY OFF
[2026-04-10 21:14:13] [INFO] SET RESOURCE OFF
[2026-04-10 21:14:13] [INFO] SET TALK OFF
[2026-04-10 21:14:13] [INFO] SET NOTIFY OFF
[2026-04-10 21:14:13] [INFO] SYS(2335, 0)
[2026-04-10 21:14:13] [INFO] 
[2026-04-10 21:14:13] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
[2026-04-10 21:14:13] [INFO] QUIT
[2026-04-10 21:14:13] [INFO] 
[2026-04-10 21:14:13] [INFO] === Fim do Wrapper.prg ===
[2026-04-10 21:14:13] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-04-10 21:15:29] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-10 21:15:29] [INFO] Config FPW: (nao fornecido)
[2026-04-10 21:15:30] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-10 21:15:30] [INFO] Timeout: 300 segundos
[2026-04-10 21:15:30] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_vxiicdeq.prg
[2026-04-10 21:15:30] [INFO] Conteudo do wrapper:
[2026-04-10 21:15:30] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
QUIT

[2026-04-10 21:15:30] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_vxiicdeq.prg
[2026-04-10 21:15:30] [INFO] VFP output esperado em: C:\4c\tasks\task007\vfp_output.txt
[2026-04-10 21:15:30] [INFO] Executando Visual FoxPro 9...
[2026-04-10 21:15:30] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_vxiicdeq.prg
[2026-04-10 21:15:30] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_vxiicdeq.prg
[2026-04-10 21:15:30] [INFO] Timeout configurado: 300 segundos
[2026-04-10 21:15:32] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-10 21:15:32] [INFO] VFP9 finalizado em 2.4710733 segundos
[2026-04-10 21:15:32] [INFO] Exit Code: 
[2026-04-10 21:15:32] [INFO] 
[2026-04-10 21:15:32] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-10 21:15:32] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_vxiicdeq.prg
[2026-04-10 21:15:32] [INFO] 
[2026-04-10 21:15:32] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-10 21:15:32] [INFO] * Auto-generated wrapper for parameters
[2026-04-10 21:15:32] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-10 21:15:32] [INFO] * Parameters: 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
[2026-04-10 21:15:32] [INFO] 
[2026-04-10 21:15:32] [INFO] * Anti-dialog protections for unattended execution
[2026-04-10 21:15:32] [INFO] SET SAFETY OFF
[2026-04-10 21:15:32] [INFO] SET RESOURCE OFF
[2026-04-10 21:15:32] [INFO] SET TALK OFF
[2026-04-10 21:15:32] [INFO] SET NOTIFY OFF
[2026-04-10 21:15:32] [INFO] SYS(2335, 0)
[2026-04-10 21:15:32] [INFO] 
[2026-04-10 21:15:33] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
[2026-04-10 21:15:33] [INFO] QUIT
[2026-04-10 21:15:33] [INFO] 
[2026-04-10 21:15:33] [INFO] === Fim do Wrapper.prg ===
[2026-04-10 21:15:33] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-04-10 21:17:00] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-10 21:17:00] [INFO] Config FPW: (nao fornecido)
[2026-04-10 21:17:00] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-10 21:17:00] [INFO] Timeout: 300 segundos
[2026-04-10 21:17:00] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_ygcle4a1.prg
[2026-04-10 21:17:00] [INFO] Conteudo do wrapper:
[2026-04-10 21:17:00] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
QUIT

[2026-04-10 21:17:00] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_ygcle4a1.prg
[2026-04-10 21:17:00] [INFO] VFP output esperado em: C:\4c\tasks\task007\vfp_output.txt
[2026-04-10 21:17:00] [INFO] Executando Visual FoxPro 9...
[2026-04-10 21:17:00] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_ygcle4a1.prg
[2026-04-10 21:17:00] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_ygcle4a1.prg
[2026-04-10 21:17:00] [INFO] Timeout configurado: 300 segundos
[2026-04-10 21:17:02] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-10 21:17:03] [INFO] VFP9 finalizado em 2.3189264 segundos
[2026-04-10 21:17:03] [INFO] Exit Code: 
[2026-04-10 21:17:03] [INFO] 
[2026-04-10 21:17:03] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-10 21:17:03] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_ygcle4a1.prg
[2026-04-10 21:17:03] [INFO] 
[2026-04-10 21:17:03] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-10 21:17:03] [INFO] * Auto-generated wrapper for parameters
[2026-04-10 21:17:03] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-10 21:17:03] [INFO] * Parameters: 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
[2026-04-10 21:17:03] [INFO] 
[2026-04-10 21:17:03] [INFO] * Anti-dialog protections for unattended execution
[2026-04-10 21:17:03] [INFO] SET SAFETY OFF
[2026-04-10 21:17:03] [INFO] SET RESOURCE OFF
[2026-04-10 21:17:03] [INFO] SET TALK OFF
[2026-04-10 21:17:03] [INFO] SET NOTIFY OFF
[2026-04-10 21:17:03] [INFO] SYS(2335, 0)
[2026-04-10 21:17:03] [INFO] 
[2026-04-10 21:17:03] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
[2026-04-10 21:17:03] [INFO] QUIT
[2026-04-10 21:17:03] [INFO] 
[2026-04-10 21:17:03] [INFO] === Fim do Wrapper.prg ===
[2026-04-10 21:17:03] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-04-10 21:19:48] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-10 21:19:48] [INFO] Config FPW: (nao fornecido)
[2026-04-10 21:19:48] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-10 21:19:48] [INFO] Timeout: 300 segundos
[2026-04-10 21:19:48] [INFO] Wrapper PRG criado para parametros: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_xjlcacc5.prg
[2026-04-10 21:19:48] [INFO] Conteudo do wrapper:
[2026-04-10 21:19:48] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
QUIT

[2026-04-10 21:19:48] [INFO] Comando VFP: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_xjlcacc5.prg
[2026-04-10 21:19:48] [INFO] VFP output esperado em: C:\4c\tasks\task007\vfp_output.txt
[2026-04-10 21:19:48] [INFO] Executando Visual FoxPro 9...
[2026-04-10 21:19:48] [INFO] Comando completo: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_xjlcacc5.prg
[2026-04-10 21:19:48] [INFO] Executando: VFP9.EXE -T C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_xjlcacc5.prg
[2026-04-10 21:19:48] [INFO] Timeout configurado: 300 segundos
[2026-04-10 21:19:50] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-10 21:19:50] [INFO] VFP9 finalizado em 2.0061799 segundos
[2026-04-10 21:19:50] [INFO] Exit Code: 
[2026-04-10 21:19:50] [INFO] 
[2026-04-10 21:19:50] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-10 21:19:50] [INFO]   Wrapper.prg: C:\Users\clebe\AppData\Local\Temp\vfp_wrapper_xjlcacc5.prg
[2026-04-10 21:19:50] [INFO] 
[2026-04-10 21:19:50] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-10 21:19:50] [INFO] * Auto-generated wrapper for parameters
[2026-04-10 21:19:50] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-10 21:19:50] [INFO] * Parameters: 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
[2026-04-10 21:19:50] [INFO] 
[2026-04-10 21:19:50] [INFO] * Anti-dialog protections for unattended execution
[2026-04-10 21:19:50] [INFO] SET SAFETY OFF
[2026-04-10 21:19:50] [INFO] SET RESOURCE OFF
[2026-04-10 21:19:50] [INFO] SET TALK OFF
[2026-04-10 21:19:50] [INFO] SET NOTIFY OFF
[2026-04-10 21:19:50] [INFO] SYS(2335, 0)
[2026-04-10 21:19:50] [INFO] 
[2026-04-10 21:19:50] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formcfo', 'C:\4c\tasks\task007', 'CRUD'
[2026-04-10 21:19:50] [INFO] QUIT
[2026-04-10 21:19:50] [INFO] 
[2026-04-10 21:19:50] [INFO] === Fim do Wrapper.prg ===
[2026-04-10 21:19:50] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formcfo",
  "timestamp": "20260410211950",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": false,
      "erro": "CREATEOBJECT retornou valor nao-objeto",
      "detalhes": ""
    }
  ],
  "resumo": {
    "total": 1,
    "passou": 0,
    "falhou": 1,
    "percentual": 0
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formcfo.prg):
*******************************************************************************
* Formcfo.prg - Formul" + CHR(225) + "rio de Cadastro de CFOP
* Entidade  : CFOP (C" + CHR(243) + "digo Fiscal de Opera" + CHR(231) + CHR(245) + "es e Presta" + CHR(231) + CHR(245) + "es)
* Tabela    : SigCdCfo | PK: codigos
* Arquitetura: FormBase -> Formcfo -> cfoBO -> BusinessBase -> DataAccess
* Fases: 1-2 BO | 3 Form base | 4 Grid+Botoes CRUD Page1 | 5+ Page2 campos
*******************************************************************************

DEFINE CLASS Formcfo AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity - EXATAS do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de CFOP"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"
    this_cMensagemErro   = ""

    *==========================================================================
    * Init - Inicializa o formulario (APENAS DODEFAULT)
    * FormBase.Init() chama InicializarForm() automaticamente
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loException
            MostrarErro("Erro ao inicializar Formcfo:" + CHR(13) + loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa do formulario
    * Chamado automaticamente pelo FormBase.Init()
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("cfoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar o objeto de neg" + CHR(243) + "cio cfoBO.", "Erro")
                loc_lSucesso = .F.
            ELSE
                *-- Configurar estrutura visual
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.ConfigurarPaginaDados()

                *-- Tornar pageframe visivel e ativar pagina inicial
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                *-- Carregar lista inicial (pular se validando UI sem banco)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar formulario Formcfo:" + CHR(13) + ;
                        loException.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas
    * Top=-29 oculta abas, exigindo compensacao +29 em todos controles internos
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = 1000
            .Height     = 629
            .Tabs       = .F.
            .Page1.Caption   = "Lista"
            .Page2.Caption   = "Dados"
            .Page1.BackColor = RGB(234, 232, 228)
            .Page2.BackColor = RGB(234, 232, 228)
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura Page1 completa:
    *   - Container cabecalho escuro com titulo
    *   - Container botoes CRUD (Incluir/Visualizar/Alterar/Excluir/Buscar)
    *   - Container saida (Encerrar)
    *   - Botoes XML (Exporta/Importa)
    *   - Grid grd_4c_Lista com 2 colunas (codigos, descricaos)
    * Compensacao PageFrame: Top original + 29
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *----------------------------------------------------------------------
        * Container Cabecalho (fundo escuro com titulo)
        * Top=31 = original 2 + compensacao PageFrame 29
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 935
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        *-- Label sombra (efeito 3D no titulo)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Caption   = "Cadastro de CFOP"
            .Top       = 15
            .Left      = 11
            .Width     = 769
            .Height    = 40
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .BackStyle = 0
            .Alignment = 0
        ENDWITH

        *-- Label titulo (branco sobre fundo escuro)
        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de CFOP"
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .Alignment = 0
        ENDWITH

        *----------------------------------------------------------------------
        * Container Botoes CRUD (Grupo_Op - lado DIREITO)
        * Top=29 = original 0 + compensacao 29 | Left=542 (NUNCA lado esquerdo!)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .BorderStyle = 0
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
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
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *----------------------------------------------------------------------
        * Container Saida (botao X - extremo direito)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 29
            .Left        = 935
            .Width       = 60
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
            .BorderWidth = 0
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Encerrar
        loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 50
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * Botoes XML (Exporta/Importa)
        * Top=114 = original 85 + compensacao 29
        * Original: btnExpXML.Left=3, btnImpXML.Left=127
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cmd_4c_ExpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_ExpXML
            .Caption       = "Exporta XML"
            .Top           = 114
            .Left          = 3
            .Width         = 120
            .Height        = 40
            .BackColor     = RGB(234, 232, 228)
            .ForeColor     = RGB(0, 0, 0)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ExpXML, "Click", THIS, "BtnExpXMLClick")

        loc_oPagina.AddObject("cmd_4c_ImpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_ImpXML
            .Caption       = "Importa XML"
            .Top           = 114
            .Left          = 127
            .Width         = 120
            .Height        = 40
            .BackColor     = RGB(234, 232, 228)
            .ForeColor     = RGB(0, 0, 0)
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Themes        = .F.
            .SpecialEffect = 0
            .MousePointer  = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_ImpXML, "Click", THIS, "BtnImpXMLClick")

        *----------------------------------------------------------------------
        * Cursor placeholder para o Grid
        * cursor_4c_Dados: codigos C(10), descricaos C(60), situas C(1)
        * O BO usa ZAP+APPEND para preservar as colunas existentes do grid
        *----------------------------------------------------------------------
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas C(1))
        SET NULL OFF

        *----------------------------------------------------------------------
        * Grid grd_4c_Lista
        * Top=164 = original 135 + compensacao 29
        * Width=971, Height=448 (do analise.json ajustado)
        * RecordSource e ColumnCount FORA de WITH para criar colunas imediatamente
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista

        loc_oGrid.Top                 = 164
        loc_oGrid.Left                = 12
        loc_oGrid.Width               = 971
        loc_oGrid.Height              = 445
        loc_oGrid.FontName            = "Verdana"
        loc_oGrid.FontSize            = 8
        loc_oGrid.ForeColor           = RGB(90, 90, 90)
        loc_oGrid.BackColor           = RGB(255, 255, 255)
        loc_oGrid.GridLineColor       = RGB(238, 238, 238)
        loc_oGrid.GridLines           = 3
        loc_oGrid.HighlightBackColor  = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor  = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle      = 2
        loc_oGrid.DeleteMark          = .F.
        loc_oGrid.RecordMark          = .F.
        loc_oGrid.RowHeight           = 16
        loc_oGrid.ScrollBars          = 2
        loc_oGrid.ReadOnly            = .T.
        *-- RecordSource + ColumnCount FORA do WITH (cria colunas imediatamente)
        loc_oGrid.RecordSource = "cursor_4c_Dados"
        loc_oGrid.ColumnCount  = 2
        *-- Configurar colunas APOS RecordSource
        loc_oGrid.Column1.ControlSource        = "cursor_4c_Dados.codigos"
        loc_oGrid.Column1.Width                = 80
        loc_oGrid.Column1.Header1.Caption      = "C" + CHR(243) + "digo"
        loc_oGrid.Column1.DynamicForeColor     = "IIF(cursor_4c_Dados.situas='1',RGB(0,0,0),RGB(128,128,128))"
        loc_oGrid.Column2.ControlSource        = "cursor_4c_Dados.descricaos"
        loc_oGrid.Column2.Width                = 400
        loc_oGrid.Column2.Header1.Caption      = "Descri" + CHR(231) + CHR(227) + "o"
        loc_oGrid.Column2.DynamicForeColor     = "IIF(cursor_4c_Dados.situas='1',RGB(0,0,0),RGB(128,128,128))"

        *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Formulario de dados do CFOP)
    * Contem: botoes Salvar/Cancelar + PageFrame interno com 2 sub-paginas fiscais
    * Os campos serao adicionados na Fase 5
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *----------------------------------------------------------------------
        * Container Botoes Acao (Salvar/Cancelar - Grupo_Salva - lado direito)
        * Top=33 = original 4 + compensacao 29
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 837
            .Width       = 160
            .Height      = 85
            .BackStyle = 1
            .BackColor = RGB(53, 53, 53)
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salvar)
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
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * PageFrame interno (PagDados) - 2 sub-paginas com campos fiscais
        * Top original=120, com compensacao +29 = 149
        * Page1: Dados Principais + Integracao Contabil/Fiscal
        * Page2: Integracao Contabil e Integracao Fiscal
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("pgf_4c_PagDados", "PageFrame")
        WITH loc_oPagina.pgf_4c_PagDados
            .PageCount  = 2
            .Top        = 149
            .Left       = -1
            .Width      = 998
            .Height     = 476
            .Tabs       = .F.
            .Page1.Caption   = "DadosPrincipais"
            .Page2.Caption   = "Integracao"
            .Page1.BackColor = RGB(234, 232, 228)
            .Page2.BackColor = RGB(234, 232, 228)
        ENDWITH
        loc_oPagina.pgf_4c_PagDados.Visible = .T.

        *-- Configurar campos das sub-paginas de dados
        THIS.ConfigurarPaginaDadosPage1()
        THIS.ConfigurarPaginaDadosPage2()

        *-- Tornar controles visiveis
        THIS.TornarControlesVisiveis(loc_oPagina)
        *-- Fwcheckbox2 (SomaIcmFrete) tem Visible=.F. no original; reforcar
        THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1.chk_4c_SomaIcmFrete.Visible = .F.
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega registros no grid da Page1
    * Chama BO.Buscar() que usa ZAP+APPEND para preservar colunas do grid,
    * depois re-vincula o grid ao cursor_4c_Dados atualizado.
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            *-- Pular se validando UI sem conexao
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    loc_lResultado = .F.
                ELSE
                    IF THIS.this_oBusinessObject.Buscar("")
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        *-- RecordSource + ColumnCount FORA do WITH
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.ColumnCount  = 2
                        *-- ControlSource e Headers APOS RecordSource
                        loc_oGrid.Column1.ControlSource    = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column1.Width            = 80
                        loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"
                        loc_oGrid.Column1.DynamicForeColor = "IIF(cursor_4c_Dados.situas='1',RGB(0,0,0),RGB(128,128,128))"
                        loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.descricaos"
                        loc_oGrid.Column2.Width            = 400
                        loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
                        loc_oGrid.Column2.DynamicForeColor = "IIF(cursor_4c_Dados.situas='1',RGB(0,0,0),RGB(128,128,128))"
                        THIS.FormatarGridLista(loc_oGrid)
                        loc_lResultado = .T.
                    ELSE
                        loc_lResultado = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista de CFOP:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MostrarErro("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina), "Erro")
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Novo registro CFOP
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.ActivePage = 1
            THIS.AlternarPagina(2)
        CATCH TO loException
            MostrarErro("Erro ao incluir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.ActivePage = 1
                    THIS.AlternarPagina(2)
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Alterar registro selecionado
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.ActivePage = 1
                    THIS.AlternarPagina(2)
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Excluir registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_lConfirma
        loc_cCodigo   = ""
        loc_lConfirma = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

                loc_lConfirma = MsgConfirma("Confirmar exclus" + CHR(227) + "o do CFOP [" + ;
                    loc_cCodigo + "]?", "Confirmar")

                IF loc_lConfirma
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                            THIS.CarregarLista()
                        ELSE
                            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Aviso")
                        ENDIF
                    ELSE
                        MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Aviso")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Pesquisar CFOP via FormBuscaAuxiliar
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfop", "Codigos", "", ;
                "Buscar CFOP")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCfop")
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaCfop.Codigos)
                    *-- Recarregar lista e posicionar no registro encontrado
                    THIS.CarregarLista()
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
                        THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
                    ENDIF
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaCfop")
            USE IN cursor_4c_BuscaCfop
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fechar formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        TRY
            THIS.Release()
        CATCH TO loException
            MostrarErro("Erro ao encerrar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salvar (Confirmar) alteracoes
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        *-- Validacoes FORA do TRY (para permitir RETURN normal)
        THIS.FormParaBO()

        TRY
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.this_cModoAtual = "LISTA"
                THIS.AlternarPagina(1)
                loc_lResultado = .T.
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel salvar o registro.", "Aviso")
                loc_lResultado = .F.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancelar e voltar para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
            THIS.CarregarLista()
        CATCH TO loException
            MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExpXMLClick - Exportar XML do CFOP selecionado
    * Equivalente ao btnExpXML.Click do original
    *==========================================================================
    PROCEDURE BtnExpXMLClick()
        LOCAL loc_cCodigo, loc_lResultado
        loc_cCodigo   = ""
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)

                IF !EMPTY(loc_cCodigo)
                    THIS.LockScreen = .T.
                    DO FORM SigOpXml WITH THIS, loc_cCodigo, "E", "CFOP", 10
                    THIS.CarregarLista()
                    IF USED("cursor_4c_Dados")
                        SELECT cursor_4c_Dados
                        LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
                    ENDIF
                    THIS.LockScreen = .F.
                    loc_lResultado = .T.
                ENDIF
            ELSE
                MsgAviso("Selecione um CFOP para exportar.", "Aviso")
            ENDIF
        CATCH TO loException
            THIS.LockScreen = .F.
            MostrarErro("Erro ao exportar XML:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * BtnImpXMLClick - Importar XML de CFOP
    * Equivalente ao btnImpXML.Click do original
    *==========================================================================
    PROCEDURE BtnImpXMLClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.LockScreen = .T.
            DO FORM SigOpXml WITH THIS, "", "I", "CFOP", 10
            THIS.CarregarLista()
            THIS.LockScreen = .F.
            loc_lResultado = .T.
        CATCH TO loException
            THIS.LockScreen = .F.
            MostrarErro("Erro ao importar XML:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos do formulario (Page2)
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPag1, loc_oPag2
        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

            *-- Page1: Dados Principais
            loc_oPag1.txt_4c_Codigo.Value      = ""
            loc_oPag1.txt_4c_Descricao.Value   = ""
            loc_oPag1.txt_4c_Desc2s.Value      = ""
            loc_oPag1.opg_4c_Situacao.Value    = 1
            loc_oPag1.cmb_4c_Operacao.ListIndex = 0
            loc_oPag1.cmb_4c_Tipo.ListIndex    = 0
            loc_oPag1.spn_4c_Ndigito.Value     = 0
            loc_oPag1.cmb_4c_Icms.ListIndex    = 0
            loc_oPag1.cmb_4c_SobreDesc.ListIndex   = 0
            loc_oPag1.cmb_4c_InclIcms.ListIndex    = 0
            loc_oPag1.cmb_4c_IpiIcms.ListIndex     = 0
            loc_oPag1.txt_4c_CfoST.Value       = ""
            loc_oPag1.txt_4c_CfoST60.Value     = ""
            loc_oPag1.txt_4c_CfoDest.Value     = ""
            loc_oPag1.txt_4c_BcST.Value        = 0
            loc_oPag1.cmb_4c_STRIB.ListIndex   = 0
            loc_oPag1.cmb_4c_CfoTransp.ListIndex = 0
            loc_oPag1.txt_4c_Sittricm.Value    = ""
            loc_oPag1.cmb_4c_IcmsInclPreco.ListIndex = 0
            loc_oPag1.cmb_4c_ContribNFe.ListIndex    = 0
            loc_oPag1.txt_4c_AliqIVCs.Value    = 0
            loc_oPag1.txt_4c_MotDeson.Value    = ""
            loc_oPag1.cmb_4c_UnitImp.ListIndex = 0
            loc_oPag1.chk_4c_FreteICM.Value    = 0
            loc_oPag1.chk_4c_SegICM.Value      = 0
            loc_oPag1.chk_4c_DespICM.Value     = 0
            loc_oPag1.chk_4c_IcmsNF.Value      = 0
            loc_oPag1.chk_4c_SomaIcmFrete.Value = 0
            loc_oPag1.cmb_4c_IPI.ListIndex     = 0
            loc_oPag1.cmb_4c_IpiI.ListIndex    = 0
            loc_oPag1.txt_4c_Aliqs.Value       = 0
            loc_oPag1.txt_4c_Gergia1.Value     = ""
            loc_oPag1.txt_4c_IPICST.Value      = ""
            loc_oPag1.txt_4c_PISCST.Value      = ""
            loc_oPag1.txt_4c_COFCST.Value      = ""
            loc_oPag1.txt_4c_ISSQNL.Value      = ""
            loc_oPag1.txt_4c_IPIEnq.Value      = ""
            loc_oPag1.cmb_4c_NaoCreditado.ListIndex = 0
            loc_oPag1.cmb_4c_AcresDesc.ListIndex    = 0
            loc_oPag1.cmb_4c_BIPI.ListIndex    = 0
            loc_oPag1.txt_4c_BcIPI.Value       = 0
            loc_oPag1.cmb_4c_RetiraIPI.ListIndex = 0
            loc_oPag1.chk_4c_FreteIPI.Value    = 0
            loc_oPag1.chk_4c_SegIPI.Value      = 0
            loc_oPag1.chk_4c_DespIPI.Value     = 0
            loc_oPag1.opg_4c_CodTribISSQN.Value = 1
            loc_oPag1.opg_4c_RetTribs.Value    = 1
            loc_oPag1.txt_4c_AliqPIS.Value     = 0
            loc_oPag1.txt_4c_AliqCofins.Value  = 0
            loc_oPag1.txt_4c_AliqISSQN.Value   = 0
            loc_oPag1.txt_4c_AliqII.Value      = 0

            *-- Page2: Integracao Contabil/Fiscal
            loc_oPag2.txt_4c_VrcDs.Value       = ""
            loc_oPag2.txt_4c_VrcCs.Value       = ""
            loc_oPag2.txt_4c_IcmDs.Value       = ""
            loc_oPag2.txt_4c_IcmCs.Value       = ""
            loc_oPag2.txt_4c_IpiDs.Value       = ""
            loc_oPag2.txt_4c_IpiCs.Value       = ""
            loc_oPag2.txt_4c_ContFrt.Value     = ""
            loc_oPag2.txt_4c_ContSeg.Value     = ""
            loc_oPag2.txt_4c_ContDa.Value      = ""
            loc_oPag2.cmb_4c_DescInteg.ListIndex  = 0
            loc_oPag2.cmb_4c_CmbFixa.ListIndex    = 0
            loc_oPag2.opg_4c_Agrupas.Value     = 1
            loc_oPag2.opg_4c_Zeradas.Value     = 1
            loc_oPag2.opg_4c_DtIntFis.Value    = 1
            loc_oPag2.opg_4c_UtilVars.Value    = 1
            loc_oPag2.opg_4c_IntVlrCont.Value  = 1
            loc_oPag2.opg_4c_IntVlrIcms.Value  = 1
            loc_oPag2.opg_4c_IntVlrIpi.Value   = 1
            loc_oPag2.opg_4c_IndMov.Value      = 1
            loc_oPag2.opg_4c_IndPagto.Value    = 1
        CATCH TO loException
            MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme modo
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPag1, loc_oPag2, loc_lNovo
        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
            loc_lNovo = (THIS.this_cModoAtual = "INCLUIR")

            *-- getCodigo: apenas habilitado no modo Incluir
            loc_oPag1.txt_4c_Codigo.Enabled    = (par_lHabilitar AND loc_lNovo)
            loc_oPag1.txt_4c_Descricao.Enabled = par_lHabilitar
            loc_oPag1.txt_4c_Desc2s.Enabled    = par_lHabilitar
            loc_oPag1.opg_4c_Situacao.Enabled  = par_lHabilitar
            loc_oPag1.cmb_4c_Operacao.Enabled  = par_lHabilitar
            loc_oPag1.cmb_4c_Tipo.Enabled      = par_lHabilitar
            loc_oPag1.spn_4c_Ndigito.Enabled   = par_lHabilitar
            loc_oPag1.cmb_4c_Icms.Enabled      = par_lHabilitar
            loc_oPag1.cmb_4c_SobreDesc.Enabled = par_lHabilitar
            loc_oPag1.cmb_4c_InclIcms.Enabled  = par_lHabilitar
            loc_oPag1.cmb_4c_IpiIcms.Enabled   = par_lHabilitar
            loc_oPag1.txt_4c_CfoST.Enabled     = par_lHabilitar
            loc_oPag1.txt_4c_CfoST60.Enabled   = par_lHabilitar
            loc_oPag1.txt_4c_CfoDest.Enabled   = par_lHabilitar
            loc_oPag1.txt_4c_BcST.Enabled      = par_lHabilitar
            loc_oPag1.cmb_4c_STRIB.Enabled     = par_lHabilitar
            loc_oPag1.cmb_4c_CfoTransp.Enabled = par_lHabilitar
            loc_oPag1.txt_4c_Sittricm.Enabled  = par_lHabilitar
            loc_oPag1.cmb_4c_IcmsInclPreco.Enabled = par_lHabilitar
            loc_oPag1.cmb_4c_ContribNFe.Enabled    = par_lHabilitar
            loc_oPag1.txt_4c_AliqIVCs.Enabled  = par_lHabilitar
            loc_oPag1.txt_4c_MotDeson.Enabled  = par_lHabilitar
            loc_oPag1.cmb_4c_UnitImp.Enabled   = par_lHabilitar
            loc_oPag1.chk_4c_FreteICM.Enabled  = par_lHabilitar
            loc_oPag1.chk_4c_SegICM.Enabled    = par_lHabilitar
            loc_oPag1.chk_4c_DespICM.Enabled   = par_lHabilitar
            loc_oPag1.chk_4c_IcmsNF.Enabled    = par_lHabilitar
            loc_oPag1.cmb_4c_IPI.Enabled       = par_lHabilitar
            loc_oPag1.cmb_4c_IpiI.Enabled      = par_lHabilitar
            loc_oPag1.txt_4c_Aliqs.Enabled     = par_lHabilitar
            loc_oPag1.txt_4c_Gergia1.Enabled   = par_lHabilitar
            loc_oPag1.txt_4c_IPICST.Enabled    = par_lHabilitar
            loc_oPag1.txt_4c_PISCST.Enabled    = par_lHabilitar
            loc_oPag1.txt_4c_COFCST.Enabled    = par_lHabilitar
            loc_oPag1.txt_4c_ISSQNL.Enabled    = par_lHabilitar
            loc_oPag1.txt_4c_IPIEnq.Enabled    = par_lHabilitar
            loc_oPag1.cmb_4c_NaoCreditado.Enabled = par_lHabilitar
            loc_oPag1.cmb_4c_AcresDesc.Enabled    = par_lHabilitar
            loc_oPag1.cmb_4c_BIPI.Enabled      = par_lHabilitar
            loc_oPag1.txt_4c_BcIPI.Enabled     = par_lHabilitar
            loc_oPag1.cmb_4c_RetiraIPI.Enabled = par_lHabilitar
            loc_oPag1.chk_4c_FreteIPI.Enabled  = par_lHabilitar
            loc_oPag1.chk_4c_SegIPI.Enabled    = par_lHabilitar
            loc_oPag1.chk_4c_DespIPI.Enabled   = par_lHabilitar
            loc_oPag1.opg_4c_CodTribISSQN.Enabled = par_lHabilitar
            loc_oPag1.opg_4c_RetTribs.Enabled  = par_lHabilitar
            loc_oPag1.txt_4c_AliqPIS.Enabled   = par_lHabilitar
            loc_oPag1.txt_4c_AliqCofins.Enabled = par_lHabilitar
            loc_oPag1.txt_4c_AliqISSQN.Enabled = par_lHabilitar
            loc_oPag1.txt_4c_AliqII.Enabled    = par_lHabilitar

            *-- Page2
            loc_oPag2.txt_4c_VrcDs.Enabled     = par_lHabilitar
            loc_oPag2.txt_4c_VrcCs.Enabled     = par_lHabilitar
            loc_oPag2.txt_4c_IcmDs.Enabled     = par_lHabilitar
            loc_oPag2.txt_4c_IcmCs.Enabled     = par_lHabilitar
            loc_oPag2.txt_4c_IpiDs.Enabled     = par_lHabilitar
            loc_oPag2.txt_4c_IpiCs.Enabled     = par_lHabilitar
            loc_oPag2.txt_4c_ContFrt.Enabled   = par_lHabilitar
            loc_oPag2.txt_4c_ContSeg.Enabled   = par_lHabilitar
            loc_oPag2.txt_4c_ContDa.Enabled    = par_lHabilitar
            loc_oPag2.cmb_4c_DescInteg.Enabled = par_lHabilitar
            loc_oPag2.cmb_4c_CmbFixa.Enabled   = par_lHabilitar
            loc_oPag2.opg_4c_Agrupas.Enabled   = par_lHabilitar
            loc_oPag2.opg_4c_Zeradas.Enabled   = par_lHabilitar
            loc_oPag2.opg_4c_DtIntFis.Enabled  = par_lHabilitar
            loc_oPag2.opg_4c_UtilVars.Enabled  = par_lHabilitar
            loc_oPag2.opg_4c_IntVlrCont.Enabled  = par_lHabilitar
            loc_oPag2.opg_4c_IntVlrIcms.Enabled  = par_lHabilitar
            loc_oPag2.opg_4c_IntVlrIpi.Enabled   = par_lHabilitar
            loc_oPag2.opg_4c_IndMov.Enabled    = par_lHabilitar
            loc_oPag2.opg_4c_IndPagto.Enabled  = par_lHabilitar
        CATCH TO loException
            MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Carrega dados do BO para os campos visuais
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPag1, loc_oPag2, loc_oBO
        TRY
            loc_oBO   = THIS.this_oBusinessObject
            loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

            *-- Page1: campos basicos
            loc_oPag1.txt_4c_Codigo.Value    = ALLTRIM(loc_oBO.this_cCodigos)
            loc_oPag1.txt_4c_Descricao.Value = ALLTRIM(loc_oBO.this_cDescricaos)
            loc_oPag1.txt_4c_Desc2s.Value    = ALLTRIM(loc_oBO.this_cDesc2s)
            loc_oPag1.opg_4c_Situacao.Value  = IIF(loc_oBO.this_nSituas = 1, 1, 2)
            loc_oPag1.spn_4c_Ndigito.Value   = loc_oBO.this_nNdigitos

            *-- Combos S/N bound to N(1,0): ListIndex=1?Sim(1), ListIndex=2?N?o(0)
            loc_oPag1.cmb_4c_SobreDesc.ListIndex    = IIF(loc_oBO.this_nIcmsdscs = 1, 1, 2)
            loc_oPag1.cmb_4c_InclIcms.ListIndex     = MAX(1, loc_oBO.this_nInclicms + 1)
            loc_oPag1.cmb_4c_IpiIcms.ListIndex      = IIF(LEFT(UPPER(ALLTRIM(loc_oBO.this_cIpi_Icms)),1)="S",1,2)
            loc_oPag1.cmb_4c_CfoTransp.ListIndex    = IIF(loc_oBO.this_nTransps = 1, 1, 2)
            loc_oPag1.cmb_4c_IcmsInclPreco.ListIndex = IIF(loc_oBO.this_nIcmsincs = 1, 1, 2)
            loc_oPag1.cmb_4c_NaoCreditado.ListIndex  = IIF(loc_oBO.this_nIpincreds = 1, 1, 2)
            loc_oPag1.cmb_4c_RetiraIPI.ListIndex     = IIF(LEFT(UPPER(ALLTRIM(loc_oBO.this_cIpiom2s)),1)="S",1,2)
            *-- Combo2 AcresDesc (C(1) ? Sim/N?o)
            loc_oPag1.cmb_4c_AcresDesc.ListIndex     = IIF(LEFT(UPPER(ALLTRIM(loc_oBO.this_cAcresipis)),1)="S",1,2)
            *-- cmbtipo: BoundColumn=2, ListIndex=this_nTipos
            IF loc_oBO.this_nTipos >= 1 AND loc_oBO.this_nTipos <= 5
                loc_oPag1.cmb_4c_Tipo.ListIndex = loc_oBO.this_nTipos
            ELSE
                loc_oPag1.cmb_4c_Tipo.ListIndex = 0
            ENDIF
            *-- cmbOperacao (C(1): E/S)
            IF LEFT(UPPER(ALLTRIM(loc_oBO.this_cOperacaos)),1) = "E"
                loc_oPag1.cmb_4c_Operacao.ListIndex = 1
            ELSE
                loc_oPag1.cmb_4c_Operacao.ListIndex = 2
            ENDIF
            *-- cmbIcms (C(1)): T=Tributado(1), I=Isento(2), O=Outros(3), N=N Tributa(4)
            DO CASE
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cIcms)),1) = "T"
                    loc_oPag1.cmb_4c_Icms.ListIndex = 1
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cIcms)),1) = "I"
                    loc_oPag1.cmb_4c_Icms.ListIndex = 2
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cIcms)),1) = "O"
                    loc_oPag1.cmb_4c_Icms.ListIndex = 3
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cIcms)),1) = "N"
                    loc_oPag1.cmb_4c_Icms.ListIndex = 4
                OTHERWISE
                    loc_oPag1.cmb_4c_Icms.ListIndex = 0
            ENDCASE
            *-- CmbSTRIB (C(1)): S=Sim(1), N=Nao(2)
            loc_oPag1.cmb_4c_STRIB.ListIndex = IIF(LEFT(UPPER(ALLTRIM(loc_oBO.this_cSubtribs)),1)="S",1,2)
            *-- cmbContribuinte (C(1)): S=Sim(1), N=Nao(2), O=Outros(3)
            DO CASE
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cContribs)),1) = "S"
                    loc_oPag1.cmb_4c_ContribNFe.ListIndex = 1
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cContribs)),1) = "O"
                    loc_oPag1.cmb_4c_ContribNFe.ListIndex = 3
                OTHERWISE
                    loc_oPag1.cmb_4c_ContribNFe.ListIndex = 2
            ENDCASE
            *-- Combo9 UnitImp (C(1)): S=Sim(1), N=Nao(2)
            loc_oPag1.cmb_4c_UnitImp.ListIndex = IIF(LEFT(UPPER(ALLTRIM(loc_oBO.this_cUnitimps)),1)="S",1,2)
            *-- cmbIpi (C(1)): T=Tributado(1), I=Isento(2), O=Outros(3)
            DO CASE
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cIpis)),1) = "T"
                    loc_oPag1.cmb_4c_IPI.ListIndex = 1
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cIpis)),1) = "I"
                    loc_oPag1.cmb_4c_IPI.ListIndex = 2
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cIpis)),1) = "O"
                    loc_oPag1.cmb_4c_IPI.ListIndex = 3
                OTHERWISE
                    loc_oPag1.cmb_4c_IPI.ListIndex = 0
            ENDCASE
            *-- cmbIpiI (C(1)): S=Sim(1), N=Nao(2)
            loc_oPag1.cmb_4c_IpiI.ListIndex = IIF(LEFT(UPPER(ALLTRIM(loc_oBO.this_cIpiimpors)),1)="S",1,2)
            *-- Combo7 InclIPI (N(1,0)): Sim(1)=1, Nao(2)=0
            loc_oPag1.cmb_4c_InclIPI.ListIndex = IIF(loc_oBO.this_nInclipis = 1, 1, 2)
            *-- CmbBIPI (C(1)): F=FatorMarkup(1), P=PrecoVenda(2), B=BaseCMedio(3), V=ValorMerc(4), G=GrupoProd(5), M=Movimentacao(6)
            DO CASE
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cBcipis)),1) = "F"
                    loc_oPag1.cmb_4c_BIPI.ListIndex = 1
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cBcipis)),1) = "P"
                    loc_oPag1.cmb_4c_BIPI.ListIndex = 2
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cBcipis)),1) = "B"
                    loc_oPag1.cmb_4c_BIPI.ListIndex = 3
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cBcipis)),1) = "V"
                    loc_oPag1.cmb_4c_BIPI.ListIndex = 4
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cBcipis)),1) = "G"
                    loc_oPag1.cmb_4c_BIPI.ListIndex = 5
                CASE LEFT(UPPER(ALLTRIM(loc_oBO.this_cBcipis)),1) = "M"
                    loc_oPag1.cmb_4c_BIPI.ListIndex = 6
                OTHERWISE
                    loc_oPag1.cmb_4c_BIPI.ListIndex = 0
            ENDCASE

            *-- TextBoxes numericos
            loc_oPag1.txt_4c_BcST.Value     = loc_oBO.this_nPbcsts
            loc_oPag1.txt_4c_AliqIVCs.Value = loc_oBO.this_nAliqivcs
            loc_oPag1.txt_4c_Aliqs.Value    = loc_oBO.this_nAliqipis
            loc_oPag1.txt_4c_BcIPI.Value    = loc_oBO.this_nPbcipis
            loc_oPag1.txt_4c_AliqPIS.Value  = loc_oBO.this_nAliqpis
            loc_oPag1.txt_4c_AliqCofins.Value = loc_oBO.this_nAliqcofins
            loc_oPag1.txt_4c_AliqISSQN.Value  = loc_oBO.this_nAliqissqn
            loc_oPag1.txt_4c_AliqII.Value   = loc_oBO.this_nAliqii

            *-- TextBoxes char
            loc_oPag1.txt_4c_CfoST.Value    = ALLTRIM(loc_oBO.this_cCfosts)
            loc_oPag1.txt_4c_CfoST60.Value  = ALLTRIM(loc_oBO.this_cCfost60s)
            loc_oPag1.txt_4c_CfoDest.Value  = ALLTRIM(loc_oBO.this_cCoddests)
            loc_oPag1.txt_4c_Sittricm.Value = ALLTRIM(loc_oBO.this_cSittribs)
            loc_oPag1.txt_4c_Gergia1.Value  = ALLTRIM(loc_oBO.this_cCgergia1s)
            loc_oPag1.txt_4c_IPICST.Value   = ALLTRIM(loc_oBO.this_cIpicst)
            loc_oPag1.txt_4c_PISCST.Value   = ALLTRIM(loc_oBO.this_cPiscst)
            loc_oPag1.txt_4c_COFCST.Value   = ALLTRIM(loc_oBO.this_cCofcst)
            loc_oPag1.txt_4c_ISSQNL.Value   = ALLTRIM(loc_oBO.this_cIssqnl)
            loc_oPag1.txt_4c_IPIEnq.Value   = ALLTRIM(loc_oBO.this_cIpienq)
            loc_oPag1.txt_4c_MotDeson.Value = ALLTRIM(loc_oBO.this_cMotdeson)

            *-- CheckBoxes (N(1,0) ? 1/0)
            loc_oPag1.chk_4c_FreteICM.Value  = loc_oBO.this_nFrticms
            loc_oPag1.chk_4c_SegICM.Value    = loc_oBO.this_nSegicms
            loc_oPag1.chk_4c_DespICM.Value   = loc_oBO.this_nDesicms
            loc_oPag1.chk_4c_IcmsNF.Value    = loc_oBO.this_nIncicmnfs
            loc_oPag1.chk_4c_SomaIcmFrete.Value = loc_oBO.this_nSomaicmfrete
            loc_oPag1.chk_4c_FreteIPI.Value  = loc_oBO.this_nFrtipis
            loc_oPag1.chk_4c_SegIPI.Value    = loc_oBO.this_nSegipis
            loc_oPag1.chk_4c_DespIPI.Value   = loc_oBO.this_nDesipis

            *-- OptionGroups
            *-- Fwoption1 CodTribISSQN: 0=Normal,1=Retida,2=Substituta,3=Isenta,4=NaoCalc
            IF loc_oBO.this_nCtissqn >= 0 AND loc_oBO.this_nCtissqn <= 4
                loc_oPag1.opg_4c_CodTribISSQN.Value = loc_oBO.this_nCtissqn + 1
            ELSE
                loc_oPag1.opg_4c_CodTribISSQN.Value = 1
            ENDIF
            *-- Fwoption2 RetTribs: 1=Sim, 2=N?o; BO stores 1=Sim, 0=N?o
            loc_oPag1.opg_4c_RetTribs.Value = IIF(loc_oBO.this_nRettribs = 1, 1, 2)

            *-- Page2: Integracao Contabil
            loc_oPag2.txt_4c_VrcDs.Value  = ALLTRIM(loc_oBO.this_cContvcds)
            loc_oPag2.txt_4c_VrcCs.Value  = ALLTRIM(loc_oBO.this_cContvccs)
            loc_oPag2.txt_4c_IcmDs.Value  = ALLTRIM(loc_oBO.this_cConticds)
            loc_oPag2.txt_4c_IcmCs.Value  = ALLTRIM(loc_oBO.this_cConticcs)
            loc_oPag2.txt_4c_IpiDs.Value  = ALLTRIM(loc_oBO.this_cContipds)
            loc_oPag2.txt_4c_IpiCs.Value  = ALLTRIM(loc_oBO.this_cContipcs)
            loc_oPag2.txt_4c_ContFrt.Value = ALLTRIM(loc_oBO.this_cContfrt)
            loc_oPag2.txt_4c_ContSeg.Value = ALLTRIM(loc_oBO.this_cContseg)
            loc_oPag2.txt_4c_ContDa.Value  = ALLTRIM(loc_oBO.this_cContda)
            *-- Combo2 DescInteg: ListIndex=this_nPontedescs+1 (0=Sim-Desc,1=Nao-Nenhuma,2=Sim-Obs)
            IF loc_oBO.this_nPontedescs >= 0 AND loc_oBO.this_nPontedescs <= 2
                loc_oPag2.cmb_4c_DescInteg.ListIndex = loc_oBO.this_nPontedescs + 1
            ELSE
                loc_oPag2.cmb_4c_DescInteg.ListIndex = 1
            ENDIF
            *-- CmbFixa (C(1)): S->1, N->2, C->3
            LOCAL loc_nCmbFixaIdx
            loc_nCmbFixaIdx = AT(LEFT(UPPER(ALLTRIM(loc_oBO.this_cContconts)), 1), "SNC")
            loc_oPag2.cmb_4c_CmbFixa.ListIndex = IIF(loc_nCmbFixaIdx > 0, loc_nCmbFixaIdx, 0)
            *-- OptionGroups Page2 (N(1,0): 1=Sim, 2=Nao; BO stores 1/0)
            loc_oPag2.opg_4c_Agrupas.Value   = IIF(loc_oBO.this_nAgrupas = 1, 1, 2)
            loc_oPag2.opg_4c_Zeradas.Value   = IIF(loc_oBO.this_nZeradas = 1, 1, 2)
            loc_oPag2.opg_4c_DtIntFis.Value  = IIF(loc_oBO.this_nDtintfis = 1, 1, 2)
            loc_oPag2.opg_4c_UtilVars.Value  = IIF(loc_oBO.this_nUtilvars = 1, 1, 2)
            loc_oPag2.opg_4c_IntVlrCont.Value = IIF(loc_oBO.this_nIntvlrcont = 1, 1, 2)
            loc_oPag2.opg_4c_IntVlrIcms.Value = IIF(loc_oBO.this_nIntvlricms = 1, 1, 2)
            loc_oPag2.opg_4c_IntVlrIpi.Value  = IIF(loc_oBO.this_nIntvlripi = 1, 1, 2)
            loc_oPag2.opg_4c_IndMov.Value    = IIF(loc_oBO.this_nIndmov = 1, 1, 2)
            loc_oPag2.opg_4c_IndPagto.Value  = IIF(loc_oBO.this_nIndpagto = 1, 1, 2)
        CATCH TO loException
            MostrarErro("Erro ao carregar BO para form:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - L? campos visuais e transfere para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPag1, loc_oPag2, loc_oBO
        TRY
            loc_oBO   = THIS.this_oBusinessObject
            loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

            *-- Campos basicos
            loc_oBO.this_cCodigos    = ALLTRIM(loc_oPag1.txt_4c_Codigo.Value)
            loc_oBO.this_cDescricaos = ALLTRIM(loc_oPag1.txt_4c_Descricao.Value)
            loc_oBO.this_cDesc2s     = ALLTRIM(loc_oPag1.txt_4c_Desc2s.Value)
            loc_oBO.this_nSituas     = IIF(loc_oPag1.opg_4c_Situacao.Value = 1, 1, 0)
            loc_oBO.this_nNdigitos   = loc_oPag1.spn_4c_Ndigito.Value

            *-- cmbtipo: ListIndex=this_nTipos (1-5)
            loc_oBO.this_nTipos = MAX(0, loc_oPag1.cmb_4c_Tipo.ListIndex)

            *-- cmbOperacao (C(1): E/S)
            IF loc_oPag1.cmb_4c_Operacao.ListIndex = 1
                loc_oBO.this_cOperacaos = "E"
            ELSE
                loc_oBO.this_cOperacaos = "S"
            ENDIF

            *-- Combos N(1,0) Sim/N?o: ListIndex=1?1, ListIndex=2?0
            loc_oBO.this_nIcmsdscs  = IIF(loc_oPag1.cmb_4c_SobreDesc.ListIndex = 1, 1, 0)
            loc_oBO.this_nInclicms  = MAX(0, loc_oPag1.cmb_4c_InclIcms.ListIndex - 1)
            loc_oBO.this_nTransps   = IIF(loc_oPag1.cmb_4c_CfoTransp.ListIndex = 1, 1, 0)
            loc_oBO.this_nIcmsincs  = IIF(loc_oPag1.cmb_4c_IcmsInclPreco.ListIndex = 1, 1, 0)
            loc_oBO.this_nIpincreds = IIF(loc_oPag1.cmb_4c_NaoCreditado.ListIndex = 1, 1, 0)

            *-- C(1) combos: store first char of selected text
            IF loc_oPag1.cmb_4c_IpiIcms.ListIndex >= 1
                loc_oBO.this_cIpi_Icms  = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_IpiIcms.Value)), 1)
            ENDIF
            IF loc_oPag1.cmb_4c_Icms.ListIndex >= 1
                loc_oBO.this_cIcms      = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_Icms.Value)), 1)
            ENDIF
            IF loc_oPag1.cmb_4c_STRIB.ListIndex >= 1
                loc_oBO.this_cSubtribs  = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_STRIB.Value)), 1)
            ENDIF
            IF loc_oPag1.cmb_4c_ContribNFe.ListIndex >= 1
                loc_oBO.this_cContribs  = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_ContribNFe.Value)), 1)
            ENDIF
            IF loc_oPag1.cmb_4c_UnitImp.ListIndex >= 1
                loc_oBO.this_cUnitimps  = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_UnitImp.Value)), 1)
            ENDIF
            IF loc_oPag1.cmb_4c_IPI.ListIndex >= 1
                loc_oBO.this_cIpis      = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_IPI.Value)), 1)
            ENDIF
            IF loc_oPag1.cmb_4c_IpiI.ListIndex >= 1
                loc_oBO.this_cIpiimpors = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_IpiI.Value)), 1)
            ENDIF
            IF loc_oPag1.cmb_4c_AcresDesc.ListIndex >= 1
                loc_oBO.this_cAcresipis = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_AcresDesc.Value)), 1)
            ENDIF
            IF loc_oPag1.cmb_4c_BIPI.ListIndex >= 1
                loc_oBO.this_cBcipis    = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_BIPI.Value)), 1)
            ENDIF
            IF loc_oPag1.cmb_4c_RetiraIPI.ListIndex >= 1
                loc_oBO.this_cIpiom2s   = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_RetiraIPI.Value)), 1)
            ENDIF
            *-- Combo7 InclIPI (N(1,0)): ListIndex=1->1(Sim), ListIndex=2->0(Nao)
            loc_oBO.this_nInclipis = IIF(loc_oPag1.cmb_4c_InclIPI.ListIndex = 1, 1, 0)

            *-- Numericos
            loc_oBO.this_nPbcsts    = loc_oPag1.txt_4c_BcST.Value
            loc_oBO.this_nAliqivcs  = loc_oPag1.txt_4c_AliqIVCs.Value
            loc_oBO.this_nAliqipis  = loc_oPag1.txt_4c_Aliqs.Value
            loc_oBO.this_nPbcipis   = loc_oPag1.txt_4c_BcIPI.Value
            loc_oBO.this_nAliqpis   = loc_oPag1.txt_4c_AliqPIS.Value
            loc_oBO.this_nAliqcofins = loc_oPag1.txt_4c_AliqCofins.Value
            loc_oBO.this_nAliqissqn = loc_oPag1.txt_4c_AliqISSQN.Value
            loc_oBO.this_nAliqii    = loc_oPag1.txt_4c_AliqII.Value

            *-- Chars
            loc_oBO.this_cCfosts    = ALLTRIM(loc_oPag1.txt_4c_CfoST.Value)
            loc_oBO.this_cCfost60s  = ALLTRIM(loc_oPag1.txt_4c_CfoST60.Value)
            loc_oBO.this_cCoddests  = ALLTRIM(loc_oPag1.txt_4c_CfoDest.Value)
            loc_oBO.this_cSittribs  = ALLTRIM(loc_oPag1.txt_4c_Sittricm.Value)
            loc_oBO.this_cCgergia1s = LEFT(UPPER(ALLTRIM(loc_oPag1.txt_4c_Gergia1.Value)),1)
            loc_oBO.this_cIpicst    = ALLTRIM(loc_oPag1.txt_4c_IPICST.Value)
            loc_oBO.this_cPiscst    = ALLTRIM(loc_oPag1.txt_4c_PISCST.Value)
            loc_oBO.this_cCofcst    = ALLTRIM(loc_oPag1.txt_4c_COFCST.Value)
            loc_oBO.this_cIssqnl    = ALLTRIM(loc_oPag1.txt_4c_ISSQNL.Value)
            loc_oBO.this_cIpienq    = ALLTRIM(loc_oPag1.txt_4c_IPIEnq.Value)
            loc_oBO.this_cMotdeson  = ALLTRIM(loc_oPag1.txt_4c_MotDeson.Value)

            *-- CheckBoxes ? N(1,0)
            loc_oBO.this_nFrticms   = loc_oPag1.chk_4c_FreteICM.Value
            loc_oBO.this_nSegicms   = loc_oPag1.chk_4c_SegICM.Value
            loc_oBO.this_nDesicms   = loc_oPag1.chk_4c_DespICM.Value
            loc_oBO.this_nIncicmnfs = loc_oPag1.chk_4c_IcmsNF.Value
            loc_oBO.this_nSomaicmfrete = loc_oPag1.chk_4c_SomaIcmFrete.Value
            loc_oBO.this_nFrtipis   = loc_oPag1.chk_4c_FreteIPI.Value
            loc_oBO.this_nSegipis   = loc_oPag1.chk_4c_SegIPI.Value
            loc_oBO.this_nDesipis   = loc_oPag1.chk_4c_DespIPI.Value

            *-- OptionGroups Page1
            loc_oBO.this_nCtissqn   = MAX(0, loc_oPag1.opg_4c_CodTribISSQN.Value - 1)
            loc_oBO.this_nRettribs  = IIF(loc_oPag1.opg_4c_RetTribs.Value = 1, 1, 0)

            *-- Page2
            loc_oBO.this_cContvcds = ALLTRIM(loc_oPag2.txt_4c_VrcDs.Value)
            loc_oBO.this_cContvccs = ALLTRIM(loc_oPag2.txt_4c_VrcCs.Value)
            loc_oBO.this_cConticds = ALLTRIM(loc_oPag2.txt_4c_IcmDs.Value)
            loc_oBO.this_cConticcs = ALLTRIM(loc_oPag2.txt_4c_IcmCs.Value)
            loc_oBO.this_cContipds = ALLTRIM(loc_oPag2.txt_4c_IpiDs.Value)
            loc_oBO.this_cContipcs = ALLTRIM(loc_oPag2.txt_4c_IpiCs.Value)
            loc_oBO.this_cContfrt  = ALLTRIM(loc_oPag2.txt_4c_ContFrt.Value)
            loc_oBO.this_cContseg  = ALLTRIM(loc_oPag2.txt_4c_ContSeg.Value)
            loc_oBO.this_cContda   = ALLTRIM(loc_oPag2.txt_4c_ContDa.Value)
            *-- Combo2 DescInteg: ListIndex-1=pontedescs
            loc_oBO.this_nPontedescs = MAX(0, loc_oPag2.cmb_4c_DescInteg.ListIndex - 1)
            *-- CmbFixa (C(1)): ListIndex=1->S, 2->N, 3->C
            DO CASE
                CASE loc_oPag2.cmb_4c_CmbFixa.ListIndex = 1
                    loc_oBO.this_cContconts = "S"
                CASE loc_oPag2.cmb_4c_CmbFixa.ListIndex = 2
                    loc_oBO.this_cContconts = "N"
                CASE loc_oPag2.cmb_4c_CmbFixa.ListIndex = 3
                    loc_oBO.this_cContconts = "C"
            ENDCASE
            *-- OptionGroups Page2
            loc_oBO.this_nAgrupas    = IIF(loc_oPag2.opg_4c_Agrupas.Value = 1, 1, 0)
            loc_oBO.this_nZeradas    = IIF(loc_oPag2.opg_4c_Zeradas.Value = 1, 1, 0)
            loc_oBO.this_nDtintfis   = IIF(loc_oPag2.opg_4c_DtIntFis.Value = 1, 1, 0)
            loc_oBO.this_nUtilvars   = IIF(loc_oPag2.opg_4c_UtilVars.Value = 1, 1, 0)
            loc_oBO.this_nIntvlrcont = IIF(loc_oPag2.opg_4c_IntVlrCont.Value = 1, 1, 0)
            loc_oBO.this_nIntvlricms = IIF(loc_oPag2.opg_4c_IntVlrIcms.Value = 1, 1, 0)
            loc_oBO.this_nIntvlripi  = IIF(loc_oPag2.opg_4c_IntVlrIpi.Value = 1, 1, 0)
            loc_oBO.this_nIndmov     = IIF(loc_oPag2.opg_4c_IndMov.Value = 1, 1, 0)
            loc_oBO.this_nIndpagto   = IIF(loc_oPag2.opg_4c_IndPagto.Value = 1, 1, 0)
        CATCH TO loException
            MostrarErro("Erro ao transferir form para BO:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * AddObject() cria controles com Visible=.F. por padrao
    * Containers com Visible=.F. por design sao preservados via INLIST
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP, loc_lContainerOculto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    *-- Containers ocultos por design nao devem ser forcados a .T.
                    loc_lContainerOculto = (UPPER(loc_oObjeto.BaseClass) = "CONTAINER" AND ;
                        INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO"))
                    IF !loc_lContainerOculto
                        loc_oObjeto.Visible = .T.
                    ENDIF
                ENDIF

                *-- Trata PageFrame - itera Pages individualmente
                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                *-- Trata containers com ControlCount (recursivo)
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
        TRY
            par_oGrid.FontName = "Tahoma"
            par_oGrid.FontSize = 8
        CATCH TO loException
            MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loException
            MostrarErro("Aviso Destroy Formcfo:" + CHR(13) + loException.Message, "Aviso")
        ENDTRY
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDadosPage1 - Cria controles na Page1 (Dados Principais)
    * Controls da PagDados.Page1 do formulario original sigcdcfo.scx
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDadosPage1()
        LOCAL loc_oPag1, loc_oCtrl
        TRY
            loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1

            *-- Shapes (separadores horizontais/vertical)
            loc_oPag1.AddObject("shp_4c_shp01", "Shape")
            WITH loc_oPag1.shp_4c_shp01
                .Top = 92
                .Left = 3
                .Height = 1
                .Width = 984
                .BackStyle = 0
                .BorderStyle = 1
                .BorderWidth = 1
                .BorderColor = RGB(100,100,100)
            ENDWITH

            loc_oPag1.AddObject("shp_4c_shp03", "Shape")
            WITH loc_oPag1.shp_4c_shp03
                .Top = 236
                .Left = 3
                .Height = 1
                .Width = 984
                .BackStyle = 0
                .BorderStyle = 1
                .BorderWidth = 1
                .BorderColor = RGB(100,100,100)
            ENDWITH

            loc_oPag1.AddObject("shp_4c_Shape1", "Shape")
            WITH loc_oPag1.shp_4c_Shape1
                .Top = 243
                .Left = 488
                .Height = 206
                .Width = 0
                .BackStyle = 0
                .BorderStyle = 1
                .BorderWidth = 1
            ENDWITH

            *-- Labels
            loc_oPag1.AddObject("lbl_4c_Say1", "Label")
            WITH loc_oPag1.lbl_4c_Say1
                .Caption = "C" + CHR(243) + "digo :"
                .Top = 11
                .Left = 91
                .Height = 15
                .Width = 42
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say2", "Label")
            WITH loc_oPag1.lbl_4c_Say2
                .Caption = "Descri" + CHR(231) + CHR(227) + "o Nota Fiscal :"
                .Top = 38
                .Left = 23
                .Height = 15
                .Width = 110
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say29", "Label")
            WITH loc_oPag1.lbl_4c_Say29
                .Caption = "Descri" + CHR(231) + CHR(227) + "o Consulta :"
                .Top = 65
                .Left = 33
                .Height = 15
                .Width = 100
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say24", "Label")
            WITH loc_oPag1.lbl_4c_Say24
                .Caption = "Digitos Para NF :"
                .Top = 12
                .Left = 848
                .Width = 82
                .Height = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say37", "Label")
            WITH loc_oPag1.lbl_4c_Say37
                .Caption = "Tipo :"
                .Top = 12
                .Left = 616
                .Width = 35
                .Height = 15
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(224,235,235)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say3", "Label")
            WITH loc_oPag1.lbl_4c_Say3
                .Caption = "Opera" + CHR(231) + CHR(227) + "o :"
                .Top = 11
                .Left = 393
                .Height = 15
                .Width = 56
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say49", "Label")
            WITH loc_oPag1.lbl_4c_Say49
                .Caption = "CFOP ST60:"
                .Top = 102
                .Left = 614
                .Height = 15
                .Width = 60
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say11", "Label")
            WITH loc_oPag1.lbl_4c_Say11
                .Caption = "CFOP Subst.Trib.:"
                .Top = 102
                .Left = 791
                .Height = 15
                .Width = 89
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say4", "Label")
            WITH loc_oPag1.lbl_4c_Say4
                .Caption = "I C M S :"
                .Top = 105
                .Left = 90
                .Height = 15
                .Width = 43
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say14", "Label")
            WITH loc_oPag1.lbl_4c_Say14
                .Caption = "ICMS Sobre :"
                .Top = 104
                .Left = 481
                .Height = 15
                .Width = 65
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say31", "Label")
            WITH loc_oPag1.lbl_4c_Say31
                .Caption = "Sobre Desconto :"
                .Top = 131
                .Left = 48
                .Height = 15
                .Width = 85
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say25", "Label")
            WITH loc_oPag1.lbl_4c_Say25
                .Caption = "Inclui IPI na Base :"
                .Top = 132
                .Left = 285
                .Height = 15
                .Width = 92
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say19", "Label")
            WITH loc_oPag1.lbl_4c_Say19
                .Caption = "CFOP Destino :"
                .Top = 131
                .Left = 805
                .Height = 15
                .Width = 75
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say10", "Label")
            WITH loc_oPag1.lbl_4c_Say10
                .Caption = "Substitui" + CHR(231) + CHR(227) + "o Tribut.:"
                .Top = 157
                .Left = 34
                .Height = 15
                .Width = 99
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say12", "Label")
            WITH loc_oPag1.lbl_4c_Say12
                .Caption = "Base Substitui" + CHR(231) + CHR(227) + "o :"
                .Top = 157
                .Left = 284
                .Height = 15
                .Width = 93
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say28", "Label")
            WITH loc_oPag1.lbl_4c_Say28
                .Caption = "CFOP Transporte :"
                .Top = 157
                .Left = 788
                .Height = 15
                .Width = 92
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say22", "Label")
            WITH loc_oPag1.lbl_4c_Say22
                .Caption = "Situa" + CHR(231) + CHR(227) + "o Tribut.:"
                .Top = 183
                .Left = 51
                .Width = 82
                .Height = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say6", "Label")
            WITH loc_oPag1.lbl_4c_Say6
                .Caption = "Contribuinte :"
                .Top = 183
                .Left = 812
                .Height = 15
                .Width = 68
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say36", "Label")
            WITH loc_oPag1.lbl_4c_Say36
                .Caption = "ICMS Incluso no Pre" + CHR(231) + "o:"
                .Top = 182
                .Left = 264
                .Height = 15
                .Width = 113
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say23", "Label")
            WITH loc_oPag1.lbl_4c_Say23
                .Caption = "Venda Consumidor :"
                .Top = 207
                .Left = 35
                .Height = 15
                .Width = 98
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say50", "Label")
            WITH loc_oPag1.lbl_4c_Say50
                .Caption = "Mot Desoner" + CHR(231) + CHR(227) + "o ICMS :"
                .Top = 206
                .Left = 256
                .Width = 121
                .Height = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say21", "Label")
            WITH loc_oPag1.lbl_4c_Say21
                .Caption = "Inibe Valor Unit" + CHR(225) + "rio na NF Importa" + CHR(231) + CHR(227) + "o :"
                .Top = 210
                .Left = 652
                .Height = 15
                .Width = 228
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say13", "Label")
            WITH loc_oPag1.lbl_4c_Say13
                .Caption = "%"
                .Top = 207
                .Left = 219
                .Height = 15
                .Width = 13
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say38", "Label")
            WITH loc_oPag1.lbl_4c_Say38
                .Caption = "Especifica" + CHR(231) + CHR(245) + "es Para NF-e"
                .Top = 246
                .Left = 498
                .Height = 15
                .Width = 167
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .T.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say8", "Label")
            WITH loc_oPag1.lbl_4c_Say8
                .Caption = "I P I :"
                .Top = 267
                .Left = 104
                .Height = 15
                .Width = 29
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say7", "Label")
            WITH loc_oPag1.lbl_4c_Say7
                .Caption = "IPI Importa" + CHR(231) + CHR(227) + "o :"
                .Top = 267
                .Left = 296
                .Height = 15
                .Width = 81
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say30", "Label")
            WITH loc_oPag1.lbl_4c_Say30
                .Caption = "C" + CHR(243) + "digo IPI Sit. Trib.:"
                .Top = 269
                .Left = 589
                .Width = 100
                .Height = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say27", "Label")
            WITH loc_oPag1.lbl_4c_Say27
                .Caption = "Destaca ICMS na Nota Fiscal (S/N) :"
                .Top = 270
                .Left = 769
                .Height = 15
                .Width = 174
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say15", "Label")
            WITH loc_oPag1.lbl_4c_Say15
                .Caption = "Al" + CHR(237) + "quota :"
                .Top = 293
                .Left = 85
                .Height = 15
                .Width = 48
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say32", "Label")
            WITH loc_oPag1.lbl_4c_Say32
                .Caption = "Retira IPI do $ :"
                .Top = 293
                .Left = 298
                .Height = 15
                .Width = 79
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say20", "Label")
            WITH loc_oPag1.lbl_4c_Say20
                .Caption = "N" + CHR(227) + "o Creditado :"
                .Top = 319
                .Left = 55
                .Height = 15
                .Width = 78
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say17", "Label")
            WITH loc_oPag1.lbl_4c_Say17
                .Caption = "Acres/Desc na Base :"
                .Top = 319
                .Left = 273
                .Height = 15
                .Width = 104
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say33", "Label")
            WITH loc_oPag1.lbl_4c_Say33
                .Caption = "C" + CHR(243) + "digo PIS Sit. Trib.:"
                .Top = 295
                .Left = 587
                .Width = 102
                .Height = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say34", "Label")
            WITH loc_oPag1.lbl_4c_Say34
                .Caption = "C" + CHR(243) + "digo COFINS Sit. Trib.:"
                .Top = 319
                .Left = 565
                .Width = 124
                .Height = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say39", "Label")
            WITH loc_oPag1.lbl_4c_Say39
                .Caption = "Al" + CHR(237) + "quota do PIS :"
                .Top = 295
                .Left = 827
                .Height = 15
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say40", "Label")
            WITH loc_oPag1.lbl_4c_Say40
                .Caption = "%"
                .Top = 295
                .Left = 971
                .Height = 15
                .Width = 14
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(224,235,235)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say41", "Label")
            WITH loc_oPag1.lbl_4c_Say41
                .Caption = "Al" + CHR(237) + "quota do COFINS :"
                .Top = 319
                .Left = 785
                .Height = 15
                .Width = 124
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say42", "Label")
            WITH loc_oPag1.lbl_4c_Say42
                .Caption = "%"
                .Top = 319
                .Left = 971
                .Height = 15
                .Width = 14
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(224,235,235)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say5", "Label")
            WITH loc_oPag1.lbl_4c_Say5
                .Caption = "Base de C" + CHR(225) + "lculo :"
                .Top = 345
                .Left = 49
                .Height = 15
                .Width = 84
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say26", "Label")
            WITH loc_oPag1.lbl_4c_Say26
                .Caption = "Incluir ICMS :"
                .Top = 105
                .Left = 311
                .Height = 15
                .Width = 66
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say35", "Label")
            WITH loc_oPag1.lbl_4c_Say35
                .Caption = "C" + CHR(243) + "digo ISSQN Lista Serv.:"
                .Top = 343
                .Left = 562
                .Width = 127
                .Height = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say44", "Label")
            WITH loc_oPag1.lbl_4c_Say44
                .Caption = "Al" + CHR(237) + "quota do ISSQN :"
                .Top = 343
                .Left = 792
                .Height = 15
                .Width = 117
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say45", "Label")
            WITH loc_oPag1.lbl_4c_Say45
                .Caption = "%"
                .Top = 343
                .Left = 971
                .Height = 15
                .Width = 14
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(224,235,235)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say16", "Label")
            WITH loc_oPag1.lbl_4c_Say16
                .Caption = "IPI Sobre :"
                .Top = 395
                .Left = 69
                .Height = 15
                .Width = 54
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say18", "Label")
            WITH loc_oPag1.lbl_4c_Say18
                .Caption = "Calcula IPI Importa" + CHR(231) + CHR(227) + "o Para Origem Mercadoria=2 :"
                .Top = 371
                .Left = 77
                .Height = 15
                .Width = 250
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say9", "Label")
            WITH loc_oPag1.lbl_4c_Say9
                .Caption = "C" + CHR(243) + "digo Enquadramento IPI:"
                .Top = 366
                .Left = 554
                .Width = 135
                .Height = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say43", "Label")
            WITH loc_oPag1.lbl_4c_Say43
                .Caption = "C" + CHR(243) + "digo de Trib. do ISSQN:"
                .Top = 390
                .Left = 561
                .Width = 128
                .Height = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say46", "Label")
            WITH loc_oPag1.lbl_4c_Say46
                .Caption = "Informa Reten" + CHR(231) + CHR(227) + "o de Trib.:"
                .Top = 425
                .Left = 556
                .Width = 133
                .Height = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say47", "Label")
            WITH loc_oPag1.lbl_4c_Say47
                .Caption = "Al" + CHR(237) + "quota do II :"
                .Top = 425
                .Left = 820
                .Height = 15
                .Width = 89
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag1.AddObject("lbl_4c_Say48", "Label")
            WITH loc_oPag1.lbl_4c_Say48
                .Caption = "%"
                .Top = 420
                .Left = 971
                .Height = 15
                .Width = 14
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(224,235,235)
                .BackStyle = 0
            ENDWITH

            *-- TextBoxes
            loc_oPag1.AddObject("txt_4c_Codigo", "TextBox")
            WITH loc_oPag1.txt_4c_Codigo
                .Top = 7
                .Left = 136
                .Height = 24
                .Width = 91
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_Descricao", "TextBox")
            WITH loc_oPag1.txt_4c_Descricao
                .Top = 34
                .Left = 136
                .Height = 24
                .Width = 430
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Format = "!"
                .MaxLength = 60
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_Desc2s", "TextBox")
            WITH loc_oPag1.txt_4c_Desc2s
                .Top = 61
                .Left = 136
                .Height = 24
                .Width = 430
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Format = "!"
                .MaxLength = 60
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_CfoST60", "TextBox")
            WITH loc_oPag1.txt_4c_CfoST60
                .Top = 101
                .Left = 690
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_CfoST", "TextBox")
            WITH loc_oPag1.txt_4c_CfoST
                .Top = 101
                .Left = 887
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_CfoDest", "TextBox")
            WITH loc_oPag1.txt_4c_CfoDest
                .Top = 127
                .Left = 887
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_Sittricm", "TextBox")
            WITH loc_oPag1.txt_4c_Sittricm
                .Top = 179
                .Left = 136
                .Height = 22
                .Width = 31
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .MaxLength = 3
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_AliqIVCs", "TextBox")
            WITH loc_oPag1.txt_4c_AliqIVCs
                .Top = 203
                .Left = 136
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "99.99"
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("txt_4c_MotDeson", "TextBox")
            WITH loc_oPag1.txt_4c_MotDeson
                .Top = 203
                .Left = 381
                .Height = 23
                .Width = 26
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "99"
                .MaxLength = 2
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_IPICST", "TextBox")
            WITH loc_oPag1.txt_4c_IPICST
                .Top = 266
                .Left = 691
                .Height = 23
                .Width = 26
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "99"
                .MaxLength = 2
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_PISCST", "TextBox")
            WITH loc_oPag1.txt_4c_PISCST
                .Top = 291
                .Left = 691
                .Height = 23
                .Width = 26
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "99"
                .MaxLength = 2
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_COFCST", "TextBox")
            WITH loc_oPag1.txt_4c_COFCST
                .Top = 315
                .Left = 691
                .Height = 23
                .Width = 26
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "99"
                .MaxLength = 2
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_ISSQNL", "TextBox")
            WITH loc_oPag1.txt_4c_ISSQNL
                .Top = 339
                .Left = 691
                .Height = 23
                .Width = 42
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "XXXXX"
                .Format = "KR"
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_IPIEnq", "TextBox")
            WITH loc_oPag1.txt_4c_IPIEnq
                .Top = 363
                .Left = 691
                .Height = 23
                .Width = 26
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .MaxLength = 3
                .Value = ""
            ENDWITH

            loc_oPag1.AddObject("txt_4c_Aliqs", "TextBox")
            WITH loc_oPag1.txt_4c_Aliqs
                .Top = 289
                .Left = 136
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "99.99"
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("txt_4c_BcST", "TextBox")
            WITH loc_oPag1.txt_4c_BcST
                .Top = 153
                .Left = 380
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "999.99"
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("txt_4c_BcIPI", "TextBox")
            WITH loc_oPag1.txt_4c_BcIPI
                .Top = 341
                .Left = 380
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "999.99"
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("txt_4c_AliqPIS", "TextBox")
            WITH loc_oPag1.txt_4c_AliqPIS
                .Top = 291
                .Left = 916
                .Height = 23
                .Width = 52
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "999.99"
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("txt_4c_AliqCofins", "TextBox")
            WITH loc_oPag1.txt_4c_AliqCofins
                .Top = 315
                .Left = 916
                .Height = 23
                .Width = 52
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "999.99"
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("txt_4c_AliqISSQN", "TextBox")
            WITH loc_oPag1.txt_4c_AliqISSQN
                .Top = 339
                .Left = 916
                .Height = 23
                .Width = 52
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "999.99"
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("txt_4c_AliqII", "TextBox")
            WITH loc_oPag1.txt_4c_AliqII
                .Top = 421
                .Left = 916
                .Height = 23
                .Width = 52
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .InputMask = "999.99"
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("txt_4c_Gergia1", "TextBox")
            WITH loc_oPag1.txt_4c_Gergia1
                .Top = 265
                .Left = 948
                .Height = 23
                .Width = 20
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Format = "K!"
                .MaxLength = 1
                .Value = ""
            ENDWITH

            *-- Spinner (Ndigito)
            loc_oPag1.AddObject("spn_4c_Ndigito", "Spinner")
            WITH loc_oPag1.spn_4c_Ndigito
                .Top = 7
                .Left = 947
                .Height = 24
                .Width = 40
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .KeyboardHighValue = 6
                .KeyboardLowValue = 0
                .SpinnerHighValue = 6
                .SpinnerLowValue = 0
                .Value = 1
            ENDWITH

            *-- ComboBoxes
            loc_oPag1.AddObject("cmb_4c_Operacao", "ComboBox")
            WITH loc_oPag1.cmb_4c_Operacao
                .Top = 7
                .Left = 459
                .Height = 24
                .Width = 107
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Entrada,Sa" + CHR(237) + "da"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_Tipo", "ComboBox")
            WITH loc_oPag1.cmb_4c_Tipo
                .Top = 7
                .Left = 653
                .Height = 24
                .Width = 151
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Compras,Devolu" + CHR(231) + CHR(227) + "o compras,Vendas,Devolu" + CHR(231) + CHR(227) + "o vendas,Servi" + CHR(231) + "os prestados"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_Icms", "ComboBox")
            WITH loc_oPag1.cmb_4c_Icms
                .Top = 101
                .Left = 136
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Tributado,Isento,Outros,N Tributa"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_SobreDesc", "ComboBox")
            WITH loc_oPag1.cmb_4c_SobreDesc
                .Top = 127
                .Left = 136
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_IpiIcms", "ComboBox")
            WITH loc_oPag1.cmb_4c_IpiIcms
                .Top = 127
                .Left = 380
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_STRIB", "ComboBox")
            WITH loc_oPag1.cmb_4c_STRIB
                .Top = 153
                .Left = 136
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_InclIcms", "ComboBox")
            WITH loc_oPag1.cmb_4c_InclIcms
                .Top = 101
                .Left = 380
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "N" + CHR(227) + "o,Base,Pre" + CHR(231) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_ContribNFe", "ComboBox")
            WITH loc_oPag1.cmb_4c_ContribNFe
                .Top = 179
                .Left = 887
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o,Outros"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_IcmsInclPreco", "ComboBox")
            WITH loc_oPag1.cmb_4c_IcmsInclPreco
                .Top = 178
                .Left = 380
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_CfoTransp", "ComboBox")
            WITH loc_oPag1.cmb_4c_CfoTransp
                .Top = 153
                .Left = 887
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_UnitImp", "ComboBox")
            WITH loc_oPag1.cmb_4c_UnitImp
                .Top = 206
                .Left = 887
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_IPI", "ComboBox")
            WITH loc_oPag1.cmb_4c_IPI
                .Top = 263
                .Left = 136
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Tributado,Isento,Outros"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_IpiI", "ComboBox")
            WITH loc_oPag1.cmb_4c_IpiI
                .Top = 263
                .Left = 380
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_InclIPI", "ComboBox")
            WITH loc_oPag1.cmb_4c_InclIPI
                .Top = 289
                .Left = 380
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_NaoCreditado", "ComboBox")
            WITH loc_oPag1.cmb_4c_NaoCreditado
                .Top = 315
                .Left = 136
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_AcresDesc", "ComboBox")
            WITH loc_oPag1.cmb_4c_AcresDesc
                .Top = 315
                .Left = 380
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_BIPI", "ComboBox")
            WITH loc_oPag1.cmb_4c_BIPI
                .Top = 341
                .Left = 136
                .Height = 24
                .Width = 196
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Fator Markup,Preco Venda,Base C." + CHR(233) + "dio,Valor Merc.,Grupo Prod,Movimenta" + CHR(231) + CHR(227) + "o"
            ENDWITH

            loc_oPag1.AddObject("cmb_4c_RetiraIPI", "ComboBox")
            WITH loc_oPag1.cmb_4c_RetiraIPI
                .Top = 367
                .Left = 380
                .Height = 23
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim,N" + CHR(227) + "o"
            ENDWITH

            *-- OptionGroup Situacao (2 botoes: Ativo/Inativo)
            loc_oPag1.AddObject("opg_4c_Situacao", "OptionGroup")
            WITH loc_oPag1.opg_4c_Situacao
                .Top = 11
                .Left = 243
                .Height = 17
                .Width = 137
                .ButtonCount = 2
                .Buttons(1).Caption = "Ativo"
                .Buttons(1).Left = 4
                .Buttons(1).Top = 0
                .Buttons(1).AutoSize = .T.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).FontBold = .T.
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "Inativo"
                .Buttons(2).Left = 64
                .Buttons(2).Top = 0
                .Buttons(2).AutoSize = .T.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).FontBold = .T.
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
            ENDWITH

            *-- CheckBoxes ICMS
            loc_oPag1.AddObject("chk_4c_FreteICM", "CheckBox")
            WITH loc_oPag1.chk_4c_FreteICM
                .Top = 102
                .Left = 549
                .Height = 15
                .Width = 44
                .Caption = "Frete"
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize = .T.
                .SpecialEffect = 1
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("chk_4c_SegICM", "CheckBox")
            WITH loc_oPag1.chk_4c_SegICM
                .Top = 117
                .Left = 549
                .Height = 15
                .Width = 52
                .Caption = "Seguro"
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize = .T.
                .SpecialEffect = 1
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("chk_4c_DespICM", "CheckBox")
            WITH loc_oPag1.chk_4c_DespICM
                .Top = 132
                .Left = 549
                .Height = 15
                .Width = 118
                .Caption = "Despesas Acess" + CHR(243) + "rias"
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize = .T.
                .SpecialEffect = 1
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("chk_4c_IcmsNF", "CheckBox")
            WITH loc_oPag1.chk_4c_IcmsNF
                .Top = 147
                .Left = 549
                .Height = 15
                .Width = 156
                .Caption = "Incluir ICMS no Total da N.F."
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize = .T.
                .SpecialEffect = 1
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("chk_4c_SomaIcmFrete", "CheckBox")
            WITH loc_oPag1.chk_4c_SomaIcmFrete
                .Top = 163
                .Left = 549
                .Height = 15
                .Width = 180
                .Caption = "Soma ICMS frete no Total da N.F."
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize = .T.
                .SpecialEffect = 1
                .Value = 0
                .Visible = .F.
            ENDWITH

            *-- CheckBoxes IPI
            loc_oPag1.AddObject("chk_4c_FreteIPI", "CheckBox")
            WITH loc_oPag1.chk_4c_FreteIPI
                .Top = 395
                .Left = 137
                .Height = 15
                .Width = 44
                .Caption = "Frete"
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize = .T.
                .SpecialEffect = 1
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("chk_4c_SegIPI", "CheckBox")
            WITH loc_oPag1.chk_4c_SegIPI
                .Top = 395
                .Left = 188
                .Height = 15
                .Width = 52
                .Caption = "Seguro"
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize = .T.
                .SpecialEffect = 1
                .Value = 0
            ENDWITH

            loc_oPag1.AddObject("chk_4c_DespIPI", "CheckBox")
            WITH loc_oPag1.chk_4c_DespIPI
                .Top = 395
                .Left = 255
                .Height = 15
                .Width = 118
                .Caption = "Despesas Acess" + CHR(243) + "rias"
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize = .T.
                .SpecialEffect = 1
                .Value = 0
            ENDWITH

            *-- OptionGroup CodTribISSQN (5 botoes: Normal/Retida/Substituta/Isenta/NaoCalcISSQN)
            loc_oPag1.AddObject("opg_4c_CodTribISSQN", "OptionGroup")
            WITH loc_oPag1.opg_4c_CodTribISSQN
                .Top = 389
                .Left = 686
                .Height = 34
                .Width = 297
                .ButtonCount = 5
                .Buttons(1).Caption = "Normal"
                .Buttons(1).Left = 4
                .Buttons(1).Top = 0
                .Buttons(1).AutoSize = .T.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Verdana"
                .Buttons(1).FontSize = 8
                .Buttons(1).FontBold = .F.
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "Retida"
                .Buttons(2).Left = 72
                .Buttons(2).Top = 0
                .Buttons(2).AutoSize = .T.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Verdana"
                .Buttons(2).FontSize = 8
                .Buttons(2).FontBold = .F.
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
                .Buttons(3).Caption = "Substituta"
                .Buttons(3).Left = 135
                .Buttons(3).Top = 1
                .Buttons(3).Width = 76
                .Buttons(3).AutoSize = .T.
                .Buttons(3).BackStyle = 0
                .Buttons(3).FontName = "Verdana"
                .Buttons(3).FontSize = 8
                .Buttons(3).FontBold = .F.
                .Buttons(3).ForeColor = RGB(90,90,90)
                .Buttons(3).Themes = .F.
                .Buttons(4).Caption = "Isenta"
                .Buttons(4).Left = 219
                .Buttons(4).Top = 1
                .Buttons(4).Width = 52
                .Buttons(4).AutoSize = .T.
                .Buttons(4).BackStyle = 0
                .Buttons(4).ForeColor = RGB(90,90,90)
                .Buttons(4).Themes = .F.
                .Buttons(5).Caption = "N" + CHR(227) + "o Calcula ISSQN"
                .Buttons(5).Left = 4
                .Buttons(5).Top = 17
                .Buttons(5).Width = 129
                .Buttons(5).AutoSize = .T.
                .Buttons(5).BackStyle = 0
                .Buttons(5).FontName = "Verdana"
                .Buttons(5).FontSize = 8
                .Buttons(5).FontBold = .F.
                .Buttons(5).ForeColor = RGB(90,90,90)
                .Buttons(5).Themes = .F.
            ENDWITH

            *-- OptionGroup RetTribs (2 botoes: Sim/Nao)
            loc_oPag1.AddObject("opg_4c_RetTribs", "OptionGroup")
            WITH loc_oPag1.opg_4c_RetTribs
                .Top = 420
                .Left = 686
                .Height = 25
                .Width = 95
                .ButtonCount = 2
                .Buttons(1).Caption = "Sim"
                .Buttons(1).Left = 5
                .Buttons(1).Top = 5
                .Buttons(1).AutoSize = .T.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).FontBold = .F.
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "N" + CHR(227) + "o"
                .Buttons(2).Left = 53
                .Buttons(2).Top = 5
                .Buttons(2).AutoSize = .T.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).FontBold = .F.
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
            ENDWITH

            *-- BINDEVENT: F4/F5=115/116 para lookups de CFOP e ICM
            BINDEVENT(loc_oPag1.txt_4c_CfoST60, "KeyPress", THIS, "KeyPressCfoST60Handler")
            BINDEVENT(loc_oPag1.txt_4c_CfoST,   "KeyPress", THIS, "KeyPressCfoSTHandler")
            BINDEVENT(loc_oPag1.txt_4c_CfoDest,  "KeyPress", THIS, "KeyPressCfoDestHandler")
            BINDEVENT(loc_oPag1.txt_4c_Sittricm, "KeyPress", THIS, "KeyPressSittricmHandler")

            *-- BINDEVENT: validacao CST (Enter=13 apos digitar 2 chars)
            BINDEVENT(loc_oPag1.txt_4c_IPICST, "KeyPress", THIS, "ValidarIPICSTKeyPress")
            BINDEVENT(loc_oPag1.txt_4c_PISCST, "KeyPress", THIS, "ValidarPISCSTKeyPress")
            BINDEVENT(loc_oPag1.txt_4c_COFCST, "KeyPress", THIS, "ValidarCOFCSTKeyPress")

            *-- BINDEVENT: comportamento BIPI e IpiI
            BINDEVENT(loc_oPag1.cmb_4c_BIPI, "InteractiveChange", THIS, "BipiChangeHandler")
            BINDEVENT(loc_oPag1.cmb_4c_IpiI, "InteractiveChange", THIS, "IpiIChangeHandler")

        CATCH TO loException
            MostrarErro("Erro ao criar controles Page1:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDadosPage2 - Cria controles na Page2 (Integracao)
    * Controls da PagDados.Page2 do formulario original sigcdcfo.scx
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDadosPage2()
        LOCAL loc_oPag2
        TRY
            loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2

            *-- Shape separador
            loc_oPag2.AddObject("shp_4c_shp03", "Shape")
            WITH loc_oPag2.shp_4c_shp03
                .Top = 211
                .Left = 5
                .Height = 1
                .Width = 984
                .BackStyle = 0
                .BorderStyle = 1
                .BorderWidth = 1
                .BorderColor = RGB(100,100,100)
            ENDWITH

            *-- Labels
            loc_oPag2.AddObject("lbl_4c_p2Say7", "Label")
            WITH loc_oPag2.lbl_4c_p2Say7
                .Caption = "Integra" + CHR(231) + CHR(227) + "o Cont" + CHR(225) + "bil"
                .Top = 6
                .Left = 15
                .Height = 15
                .Width = 114
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .T.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say10", "Label")
            WITH loc_oPag2.lbl_4c_p2Say10
                .Caption = "Valor Cont" + CHR(225) + "bil :"
                .Top = 34
                .Left = 84
                .Height = 15
                .Width = 75
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say13", "Label")
            WITH loc_oPag2.lbl_4c_p2Say13
                .Caption = "DB"
                .Top = 34
                .Left = 247
                .Height = 15
                .Width = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say14", "Label")
            WITH loc_oPag2.lbl_4c_p2Say14
                .Caption = "CR"
                .Top = 34
                .Left = 344
                .Height = 15
                .Width = 16
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say11", "Label")
            WITH loc_oPag2.lbl_4c_p2Say11
                .Caption = "IPI :"
                .Top = 60
                .Left = 136
                .Height = 15
                .Width = 23
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say15", "Label")
            WITH loc_oPag2.lbl_4c_p2Say15
                .Caption = "DB"
                .Top = 60
                .Left = 247
                .Height = 15
                .Width = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say16", "Label")
            WITH loc_oPag2.lbl_4c_p2Say16
                .Caption = "CR"
                .Top = 60
                .Left = 344
                .Height = 15
                .Width = 16
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say12", "Label")
            WITH loc_oPag2.lbl_4c_p2Say12
                .Caption = "ICMS :"
                .Top = 86
                .Left = 125
                .Height = 15
                .Width = 34
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say17", "Label")
            WITH loc_oPag2.lbl_4c_p2Say17
                .Caption = "DB"
                .Top = 86
                .Left = 247
                .Height = 15
                .Width = 15
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say18", "Label")
            WITH loc_oPag2.lbl_4c_p2Say18
                .Caption = "CR"
                .Top = 86
                .Left = 344
                .Height = 15
                .Width = 16
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say3", "Label")
            WITH loc_oPag2.lbl_4c_p2Say3
                .Caption = "Conta de Frete :"
                .Top = 112
                .Left = 77
                .Height = 15
                .Width = 82
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say4", "Label")
            WITH loc_oPag2.lbl_4c_p2Say4
                .Caption = "Conta de Seguro :"
                .Top = 138
                .Left = 69
                .Height = 15
                .Width = 90
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say5", "Label")
            WITH loc_oPag2.lbl_4c_p2Say5
                .Caption = "Conta de Despesas :"
                .Top = 164
                .Left = 57
                .Height = 15
                .Width = 102
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say21", "Label")
            WITH loc_oPag2.lbl_4c_p2Say21
                .Caption = "Descri" + CHR(231) + CHR(227) + "o na Integra" + CHR(231) + CHR(227) + "o :"
                .Top = 31
                .Left = 490
                .Height = 15
                .Width = 151
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say8", "Label")
            WITH loc_oPag2.lbl_4c_p2Say8
                .Caption = "Pega Conta Cont" + CHR(225) + "bil da NF :"
                .Top = 57
                .Left = 477
                .Height = 15
                .Width = 164
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say29", "Label")
            WITH loc_oPag2.lbl_4c_p2Say29
                .Caption = "Agrupa CFO na Integra" + CHR(231) + CHR(227) + "o :"
                .Top = 84
                .Left = 477
                .Height = 15
                .Width = 164
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say30", "Label")
            WITH loc_oPag2.lbl_4c_p2Say30
                .Caption = "Integra" + CHR(231) + CHR(227) + "o Zerada :"
                .Top = 108
                .Left = 523
                .Height = 15
                .Width = 118
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say1", "Label")
            WITH loc_oPag2.lbl_4c_p2Say1
                .Caption = "Data Lan" + CHR(231) + "amento Contabil :"
                .Top = 132
                .Left = 479
                .Height = 15
                .Width = 162
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say2", "Label")
            WITH loc_oPag2.lbl_4c_p2Say2
                .Caption = "Utilizar a varia" + CHR(231) + CHR(227) + "o de CFOP na Integra" + CHR(231) + CHR(227) + "o :"
                .Top = 156
                .Left = 390
                .Height = 15
                .Width = 251
                .FontName = "Verdana"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say35", "Label")
            WITH loc_oPag2.lbl_4c_p2Say35
                .Caption = "Integra" + CHR(231) + CHR(227) + "o Fiscal"
                .Top = 217
                .Left = 18
                .Height = 15
                .Width = 99
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .T.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say6", "Label")
            WITH loc_oPag2.lbl_4c_p2Say6
                .Caption = "Integrar Valor Cont" + CHR(225) + "bil :"
                .Top = 239
                .Left = 115
                .Height = 15
                .Width = 118
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say33", "Label")
            WITH loc_oPag2.lbl_4c_p2Say33
                .Caption = "Integrar Valores Icms :"
                .Top = 259
                .Left = 121
                .Height = 15
                .Width = 112
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say34", "Label")
            WITH loc_oPag2.lbl_4c_p2Say34
                .Caption = "Integrar Valores Ipi :"
                .Top = 278
                .Left = 131
                .Height = 15
                .Width = 102
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say38", "Label")
            WITH loc_oPag2.lbl_4c_p2Say38
                .Caption = "Movimenta" + CHR(231) + CHR(227) + "o F" + CHR(237) + "sica de Estoque :"
                .Top = 298
                .Left = 69
                .Height = 15
                .Width = 164
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            loc_oPag2.AddObject("lbl_4c_p2Say39", "Label")
            WITH loc_oPag2.lbl_4c_p2Say39
                .Caption = "Indica" + CHR(231) + CHR(227) + "o de Pagamento :"
                .Top = 318
                .Left = 106
                .Height = 15
                .Width = 127
                .FontName = "Tahoma"
                .FontSize = 8
                .FontBold = .F.
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
            ENDWITH

            *-- TextBoxes Integracao Contabil
            loc_oPag2.AddObject("txt_4c_VrcDs", "TextBox")
            WITH loc_oPag2.txt_4c_VrcDs
                .Top = 30
                .Left = 162
                .Height = 24
                .Width = 73
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag2.AddObject("txt_4c_VrcCs", "TextBox")
            WITH loc_oPag2.txt_4c_VrcCs
                .Top = 30
                .Left = 265
                .Height = 24
                .Width = 73
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag2.AddObject("txt_4c_IpiDs", "TextBox")
            WITH loc_oPag2.txt_4c_IpiDs
                .Top = 56
                .Left = 162
                .Height = 24
                .Width = 73
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag2.AddObject("txt_4c_IpiCs", "TextBox")
            WITH loc_oPag2.txt_4c_IpiCs
                .Top = 56
                .Left = 265
                .Height = 24
                .Width = 73
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag2.AddObject("txt_4c_IcmDs", "TextBox")
            WITH loc_oPag2.txt_4c_IcmDs
                .Top = 82
                .Left = 162
                .Height = 24
                .Width = 73
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag2.AddObject("txt_4c_IcmCs", "TextBox")
            WITH loc_oPag2.txt_4c_IcmCs
                .Top = 82
                .Left = 265
                .Height = 24
                .Width = 73
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag2.AddObject("txt_4c_ContFrt", "TextBox")
            WITH loc_oPag2.txt_4c_ContFrt
                .Top = 108
                .Left = 162
                .Height = 24
                .Width = 73
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag2.AddObject("txt_4c_ContSeg", "TextBox")
            WITH loc_oPag2.txt_4c_ContSeg
                .Top = 134
                .Left = 162
                .Height = 24
                .Width = 73
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            loc_oPag2.AddObject("txt_4c_ContDa", "TextBox")
            WITH loc_oPag2.txt_4c_ContDa
                .Top = 160
                .Left = 162
                .Height = 24
                .Width = 73
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .Value = ""
            ENDWITH

            *-- ComboBoxes
            loc_oPag2.AddObject("cmb_4c_DescInteg", "ComboBox")
            WITH loc_oPag2.cmb_4c_DescInteg
                .Top = 27
                .Left = 642
                .Height = 25
                .Width = 199
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim-Descri" + CHR(231) + CHR(227) + "o CFOP,N" + CHR(227) + "o-Nenhuma,Sim-Obs. Opera" + CHR(231) + CHR(227) + "o"
            ENDWITH

            loc_oPag2.AddObject("cmb_4c_CmbFixa", "ComboBox")
            WITH loc_oPag2.cmb_4c_CmbFixa
                .Top = 53
                .Left = 642
                .Height = 25
                .Width = 132
                .FontName = "Tahoma"
                .FontSize = 8
                .SpecialEffect = 1
                .Style = 2
                .ForeColor = RGB(90,90,90)
                .BorderColor = RGB(100,100,100)
                .RowSourceType = 1
                .RowSource = "Sim (NF),N" + CHR(227) + "o (CFOP),C.C."
            ENDWITH

            *-- OptionGroups Sim/Nao (Integracao Contabil)
            loc_oPag2.AddObject("opg_4c_Agrupas", "OptionGroup")
            WITH loc_oPag2.opg_4c_Agrupas
                .Top = 79
                .Left = 638
                .Height = 27
                .Width = 94
                .ButtonCount = 2
                .Buttons(1).Caption = "Sim"
                .Buttons(1).Left = 5
                .Buttons(1).Top = 5
                .Buttons(1).Width = 40
                .Buttons(1).Height = 17
                .Buttons(1).AutoSize = .F.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "N" + CHR(227) + "o"
                .Buttons(2).Left = 51
                .Buttons(2).Top = 5
                .Buttons(2).Width = 40
                .Buttons(2).Height = 17
                .Buttons(2).AutoSize = .F.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
            ENDWITH

            loc_oPag2.AddObject("opg_4c_Zeradas", "OptionGroup")
            WITH loc_oPag2.opg_4c_Zeradas
                .Top = 103
                .Left = 638
                .Height = 27
                .Width = 94
                .ButtonCount = 2
                .Buttons(1).Caption = "Sim"
                .Buttons(1).Left = 5
                .Buttons(1).Top = 5
                .Buttons(1).Width = 40
                .Buttons(1).Height = 17
                .Buttons(1).AutoSize = .F.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "N" + CHR(227) + "o"
                .Buttons(2).Left = 51
                .Buttons(2).Top = 5
                .Buttons(2).Width = 40
                .Buttons(2).Height = 17
                .Buttons(2).AutoSize = .F.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
            ENDWITH

            loc_oPag2.AddObject("opg_4c_DtIntFis", "OptionGroup")
            WITH loc_oPag2.opg_4c_DtIntFis
                .Top = 127
                .Left = 638
                .Height = 27
                .Width = 192
                .ButtonCount = 2
                .Buttons(1).Caption = "Data Integra" + CHR(231) + CHR(227) + "o"
                .Buttons(1).Left = 5
                .Buttons(1).Top = 5
                .Buttons(1).Width = 97
                .Buttons(1).AutoSize = .T.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "Data N.F."
                .Buttons(2).Left = 122
                .Buttons(2).Top = 7
                .Buttons(2).Width = 65
                .Buttons(2).AutoSize = .T.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
            ENDWITH

            loc_oPag2.AddObject("opg_4c_UtilVars", "OptionGroup")
            WITH loc_oPag2.opg_4c_UtilVars
                .Top = 150
                .Left = 638
                .Height = 27
                .Width = 94
                .ButtonCount = 2
                .Buttons(1).Caption = "Sim"
                .Buttons(1).Left = 5
                .Buttons(1).Top = 5
                .Buttons(1).Width = 40
                .Buttons(1).Height = 17
                .Buttons(1).AutoSize = .F.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "N" + CHR(227) + "o"
                .Buttons(2).Left = 51
                .Buttons(2).Top = 5
                .Buttons(2).Width = 40
                .Buttons(2).Height = 17
                .Buttons(2).AutoSize = .F.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
            ENDWITH

            *-- OptionGroups Sim/Nao (Integracao Fiscal)
            loc_oPag2.AddObject("opg_4c_IntVlrCont", "OptionGroup")
            WITH loc_oPag2.opg_4c_IntVlrCont
                .Top = 233
                .Left = 231
                .Height = 27
                .Width = 94
                .ButtonCount = 2
                .Buttons(1).Caption = "Sim"
                .Buttons(1).Left = 5
                .Buttons(1).Top = 5
                .Buttons(1).Width = 40
                .Buttons(1).Height = 17
                .Buttons(1).AutoSize = .F.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "N" + CHR(227) + "o"
                .Buttons(2).Left = 51
                .Buttons(2).Top = 5
                .Buttons(2).Width = 40
                .Buttons(2).Height = 17
                .Buttons(2).AutoSize = .F.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
            ENDWITH

            loc_oPag2.AddObject("opg_4c_IntVlrIcms", "OptionGroup")
            WITH loc_oPag2.opg_4c_IntVlrIcms
                .Top = 253
                .Left = 231
                .Height = 27
                .Width = 94
                .ButtonCount = 2
                .Buttons(1).Caption = "Sim"
                .Buttons(1).Left = 5
                .Buttons(1).Top = 5
                .Buttons(1).Width = 40
                .Buttons(1).Height = 17
                .Buttons(1).AutoSize = .F.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "N" + CHR(227) + "o"
                .Buttons(2).Left = 51
                .Buttons(2).Top = 5
                .Buttons(2).Width = 40
                .Buttons(2).Height = 17
                .Buttons(2).AutoSize = .F.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
            ENDWITH

            loc_oPag2.AddObject("opg_4c_IntVlrIpi", "OptionGroup")
            WITH loc_oPag2.opg_4c_IntVlrIpi
                .Top = 272
                .Left = 231
                .Height = 27
                .Width = 94
                .ButtonCount = 2
                .Buttons(1).Caption = "Sim"
                .Buttons(1).Left = 5
                .Buttons(1).Top = 5
                .Buttons(1).Width = 40
                .Buttons(1).Height = 17
                .Buttons(1).AutoSize = .F.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "N" + CHR(227) + "o"
                .Buttons(2).Left = 51
                .Buttons(2).Top = 5
                .Buttons(2).Width = 40
                .Buttons(2).Height = 17
                .Buttons(2).AutoSize = .F.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
            ENDWITH

            loc_oPag2.AddObject("opg_4c_IndMov", "OptionGroup")
            WITH loc_oPag2.opg_4c_IndMov
                .Top = 292
                .Left = 231
                .Height = 27
                .Width = 94
                .ButtonCount = 2
                .Buttons(1).Caption = "Sim"
                .Buttons(1).Left = 5
                .Buttons(1).Top = 5
                .Buttons(1).Width = 40
                .Buttons(1).Height = 17
                .Buttons(1).AutoSize = .F.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "N" + CHR(227) + "o"
                .Buttons(2).Left = 51
                .Buttons(2).Top = 5
                .Buttons(2).Width = 40
                .Buttons(2).Height = 17
                .Buttons(2).AutoSize = .F.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
            ENDWITH

            loc_oPag2.AddObject("opg_4c_IndPagto", "OptionGroup")
            WITH loc_oPag2.opg_4c_IndPagto
                .Top = 312
                .Left = 231
                .Height = 27
                .Width = 94
                .ButtonCount = 2
                .Buttons(1).Caption = "Sim"
                .Buttons(1).Left = 5
                .Buttons(1).Top = 5
                .Buttons(1).Width = 40
                .Buttons(1).Height = 17
                .Buttons(1).AutoSize = .F.
                .Buttons(1).BackStyle = 0
                .Buttons(1).FontName = "Tahoma"
                .Buttons(1).FontSize = 8
                .Buttons(1).ForeColor = RGB(90,90,90)
                .Buttons(1).Themes = .F.
                .Buttons(2).Caption = "N" + CHR(227) + "o"
                .Buttons(2).Left = 51
                .Buttons(2).Top = 5
                .Buttons(2).Width = 40
                .Buttons(2).Height = 17
                .Buttons(2).AutoSize = .F.
                .Buttons(2).BackStyle = 0
                .Buttons(2).FontName = "Tahoma"
                .Buttons(2).FontSize = 8
                .Buttons(2).ForeColor = RGB(90,90,90)
                .Buttons(2).Themes = .F.
            ENDWITH

            *-- BINDEVENT: Enter=13 para validar contas contra SigCdCli
            BINDEVENT(loc_oPag2.txt_4c_ContFrt, "KeyPress", THIS, "ValidarContFrtKeyPress")
            BINDEVENT(loc_oPag2.txt_4c_ContSeg, "KeyPress", THIS, "ValidarContSegKeyPress")
            BINDEVENT(loc_oPag2.txt_4c_ContDa,  "KeyPress", THIS, "ValidarContDaKeyPress")

        CATCH TO loException
            MostrarErro("Erro ao criar controles Page2:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * KeyPressCfoST60Handler - F4 abre lookup CFOP para txt_4c_CfoST60
    *==========================================================================
    PROCEDURE KeyPressCfoST60Handler(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupCfoST60()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupCfoST60()
        LOCAL loc_oForm, loc_oPag1, loc_cValor
        TRY
            loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_cValor = ALLTRIM(loc_oPag1.txt_4c_CfoST60.Value)
            loc_oForm  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfoST60", "Codigos", loc_cValor, ;
                "Buscar CFOP")
            IF !ISNULL(loc_oForm)
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    loc_oPag1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.Codigos)
                ELSE
                    loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCfoST60")
                        loc_oPag1.txt_4c_CfoST60.Value = ALLTRIM(cursor_4c_BuscaCfoST60.Codigos)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaCfoST60")
                    USE IN cursor_4c_BuscaCfoST60
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro no lookup CfoST60:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * KeyPressCfoSTHandler - F4 abre lookup CFOP para txt_4c_CfoST
    *==========================================================================
    PROCEDURE KeyPressCfoSTHandler(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupCfoST()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupCfoST()
        LOCAL loc_oForm, loc_oPag1, loc_cValor
        TRY
            loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_cValor = ALLTRIM(loc_oPag1.txt_4c_CfoST.Value)
            loc_oForm  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfoST", "Codigos", loc_cValor, ;
                "Buscar CFOP")
            IF !ISNULL(loc_oForm)
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    loc_oPag1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.Codigos)
                ELSE
                    loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCfoST")
                        loc_oPag1.txt_4c_CfoST.Value = ALLTRIM(cursor_4c_BuscaCfoST.Codigos)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaCfoST")
                    USE IN cursor_4c_BuscaCfoST
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro no lookup CfoST:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * KeyPressCfoDestHandler - F4 abre lookup CFOP para txt_4c_CfoDest
    *==========================================================================
    PROCEDURE KeyPressCfoDestHandler(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupCfoDest()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupCfoDest()
        LOCAL loc_oForm, loc_oPag1, loc_cValor
        TRY
            loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_cValor = ALLTRIM(loc_oPag1.txt_4c_CfoDest.Value)
            loc_oForm  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCfo", "cursor_4c_BuscaCfoDest", "Codigos", loc_cValor, ;
                "Buscar CFOP")
            IF !ISNULL(loc_oForm)
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    loc_oPag1.txt_4c_CfoDest.Value = ALLTRIM(cursor_4c_BuscaCfoDest.Codigos)
                ELSE
                    loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCfoDest")
                        loc_oPag1.txt_4c_CfoDest.Value = ALLTRIM(cursor_4c_BuscaCfoDest.Codigos)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaCfoDest")
                    USE IN cursor_4c_BuscaCfoDest
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro no lookup CfoDest:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * KeyPressSittricmHandler - F4 abre lookup SigCdIcm para txt_4c_Sittricm
    *==========================================================================
    PROCEDURE KeyPressSittricmHandler(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupSittricm()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupSittricm()
        LOCAL loc_oForm, loc_oPag1, loc_cValor
        TRY
            loc_oPag1  = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_cValor = ALLTRIM(loc_oPag1.txt_4c_Sittricm.Value)
            loc_oForm  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdIcm", "cursor_4c_BuscaSittricm", "Codigos", loc_cValor, ;
                "Buscar Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
            IF !ISNULL(loc_oForm)
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    loc_oPag1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaSittricm.Codigos)
                ELSE
                    loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaSittricm")
                        loc_oPag1.txt_4c_Sittricm.Value = ALLTRIM(cursor_4c_BuscaSittricm.Codigos)
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaSittricm")
                    USE IN cursor_4c_BuscaSittricm
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro no lookup Sittricm:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarIPICSTKeyPress - Valida CST IPI ao pressionar Enter
    * Codigos validos: 00-05, 49-55, 99
    *==========================================================================
    PROCEDURE ValidarIPICSTKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oPag1
        IF par_nKeyCode = 13
            TRY
                loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
                loc_cVal  = ALLTRIM(loc_oPag1.txt_4c_IPICST.Value)
                IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "00","01","02","03","04","05","49","50","51","52","53","54","55","99")
                    MsgAviso("Conte" + CHR(250) + "do V" + CHR(225) + "lido Para IPI CST:" + CHR(13) + ;
                             "00-Entrada com recupera" + CHR(231) + CHR(227) + "o de cr" + CHR(233) + "dito" + CHR(13) + ;
                             "01 a 05-Entrada (tributada/isenta/nao-trib/imune/suspensao)" + CHR(13) + ;
                             "49-Outras entradas" + CHR(13) + ;
                             "50-Sa" + CHR(237) + "da tributada" + CHR(13) + ;
                             "51 a 55-Sa" + CHR(237) + "da (aliq zero/isenta/nao-trib/imune/suspensao)" + CHR(13) + ;
                             "99-Outras sa" + CHR(237) + "das", "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            CATCH TO loException
                MostrarErro("Erro validacao IPICST:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarPISCSTKeyPress - Valida CST PIS ao pressionar Enter
    * Codigos validos: 01-04, 06-09, 49, 50, 70, 99
    *==========================================================================
    PROCEDURE ValidarPISCSTKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oPag1
        IF par_nKeyCode = 13
            TRY
                loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
                loc_cVal  = ALLTRIM(loc_oPag1.txt_4c_PISCST.Value)
                IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "01","02","03","04","06","07","08","09","49","50","70","99")
                    MsgAviso("Conte" + CHR(250) + "do V" + CHR(225) + "lido Para PIS CST:" + CHR(13) + ;
                             "01-04: Opera" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "vel" + CHR(13) + ;
                             "06: Opera" + CHR(231) + CHR(227) + "o Al" + CHR(237) + "quota Zero" + CHR(13) + ;
                             "07: Opera" + CHR(231) + CHR(227) + "o Isenta" + CHR(13) + ;
                             "08: Sem Incid" + CHR(234) + "ncia" + CHR(13) + ;
                             "09: Com Suspens" + CHR(227) + "o" + CHR(13) + ;
                             "49: Sa" + CHR(237) + "das n" + CHR(227) + "o representativas de receita" + CHR(13) + ;
                             "50: Direito a Cr" + CHR(233) + "dito" + CHR(13) + ;
                             "70: Sem Direito a Cr" + CHR(233) + "dito" + CHR(13) + ;
                             "99: Outras Opera" + CHR(231) + CHR(245) + "es", "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            CATCH TO loException
                MostrarErro("Erro validacao PISCST:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarCOFCSTKeyPress - Valida CST COFINS ao pressionar Enter
    * Codigos validos: 01-04, 06-09, 49, 50, 70, 99
    *==========================================================================
    PROCEDURE ValidarCOFCSTKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oPag1
        IF par_nKeyCode = 13
            TRY
                loc_oPag1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
                loc_cVal  = ALLTRIM(loc_oPag1.txt_4c_COFCST.Value)
                IF !EMPTY(loc_cVal) AND !INLIST(loc_cVal, "01","02","03","04","06","07","08","09","49","50","70","99")
                    MsgAviso("Conte" + CHR(250) + "do V" + CHR(225) + "lido Para COFINS CST:" + CHR(13) + ;
                             "01-04: Opera" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "vel" + CHR(13) + ;
                             "06: Opera" + CHR(231) + CHR(227) + "o Al" + CHR(237) + "quota Zero" + CHR(13) + ;
                             "07: Opera" + CHR(231) + CHR(227) + "o Isenta" + CHR(13) + ;
                             "08: Sem Incid" + CHR(234) + "ncia" + CHR(13) + ;
                             "09: Com Suspens" + CHR(227) + "o" + CHR(13) + ;
                             "49: Sa" + CHR(237) + "das n" + CHR(227) + "o representativas de receita" + CHR(13) + ;
                             "50: Direito a Cr" + CHR(233) + "dito" + CHR(13) + ;
                             "70: Sem Direito a Cr" + CHR(233) + "dito" + CHR(13) + ;
                             "99: Outras Opera" + CHR(231) + CHR(245) + "es", "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            CATCH TO loException
                MostrarErro("Erro validacao COFCST:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarContFrtKeyPress - Valida conta de frete contra SigCdCli ao Enter
    *==========================================================================
    PROCEDURE ValidarContFrtKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oPag2, loc_cSQL, loc_nResult
        IF par_nKeyCode = 13
            TRY
                loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
                loc_cVal  = ALLTRIM(loc_oPag2.txt_4c_ContFrt.Value)
                IF !EMPTY(loc_cVal)
                    loc_cSQL   = "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cVal)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
                    IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
                        IF cursor_4c_ChkConta.nExiste = 0
                            MsgAviso("Conta n" + CHR(227) + "o cadastrada, verifique!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        USE IN cursor_4c_ChkConta
                    ENDIF
                ENDIF
            CATCH TO loException
                MostrarErro("Erro validacao ContFrt:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarContSegKeyPress - Valida conta de seguro contra SigCdCli ao Enter
    *==========================================================================
    PROCEDURE ValidarContSegKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oPag2, loc_cSQL, loc_nResult
        IF par_nKeyCode = 13
            TRY
                loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
                loc_cVal  = ALLTRIM(loc_oPag2.txt_4c_ContSeg.Value)
                IF !EMPTY(loc_cVal)
                    loc_cSQL   = "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cVal)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
                    IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
                        IF cursor_4c_ChkConta.nExiste = 0
                            MsgAviso("Conta n" + CHR(227) + "o cadastrada, verifique!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        USE IN cursor_4c_ChkConta
                    ENDIF
                ENDIF
            CATCH TO loException
                MostrarErro("Erro validacao ContSeg:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarContDaKeyPress - Valida conta de despesas contra SigCdCli ao Enter
    *==========================================================================
    PROCEDURE ValidarContDaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oPag2, loc_cSQL, loc_nResult
        IF par_nKeyCode = 13
            TRY
                loc_oPag2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
                loc_cVal  = ALLTRIM(loc_oPag2.txt_4c_ContDa.Value)
                IF !EMPTY(loc_cVal)
                    loc_cSQL   = "SELECT COUNT(*) AS nExiste FROM SigCdCli WHERE codigos = " + EscaparSQL(loc_cVal)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkConta")
                    IF loc_nResult >= 0 AND USED("cursor_4c_ChkConta")
                        IF cursor_4c_ChkConta.nExiste = 0
                            MsgAviso("Conta n" + CHR(227) + "o cadastrada, verifique!", "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        USE IN cursor_4c_ChkConta
                    ENDIF
                ENDIF
            CATCH TO loException
                MostrarErro("Erro validacao ContDa:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF
    ENDPROC

    *==========================================================================
    * BipiChangeHandler - Se base IPI nao for F ou P, zera percentual BcIPI
    * Original: CmbBIPI.LostFocus
    *==========================================================================
    PROCEDURE BipiChangeHandler()
        LOCAL loc_oPag1, loc_cPrimeiro
        TRY
            loc_oPag1    = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_cPrimeiro = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_BIPI.Value)), 1)
            IF !INLIST(loc_cPrimeiro, "F", "P")
                loc_oPag1.txt_4c_BcIPI.Value = 0
            ENDIF
        CATCH TO loException
            MostrarErro("Erro BipiChangeHandler:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * IpiIChangeHandler - Habilita/desabilita cmb_4c_RetiraIPI conforme cmbIpiI
    * Original: cmbIpiI.Valid - Se "Sim" habilita RetiraIPI; senao desabilita
    *==========================================================================
    PROCEDURE IpiIChangeHandler()
        LOCAL loc_oPag1, loc_cPrimeiro
        TRY
            loc_oPag1    = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
            loc_cPrimeiro = LEFT(UPPER(ALLTRIM(loc_oPag1.cmb_4c_IpiI.Value)), 1)
            loc_oPag1.cmb_4c_RetiraIPI.Enabled = (loc_cPrimeiro = "S")
        CATCH TO loException
            MostrarErro("Erro IpiIChangeHandler:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\cfoBO.prg):
*============================================================
* cfoBO.prg - Business Object para CFOP (C" + CHR(243) + "digo Fiscal)
* Tabela: SigCdCfo | PK: codigos
*============================================================
DEFINE CLASS cfoBO AS BusinessBase

    *-- Propriedades char - SigCdCfo
    this_cCodigos     = ""  && char(10) - PK
    this_cDescricaos  = ""  && char(60)
    this_cDesc2s      = ""  && char(60)
    this_cContconts   = ""  && char(1)
    this_cContribs    = ""  && char(1)
    this_cIcms        = ""  && char(1)
    this_cIpis        = ""  && char(1)
    this_cOperacaos   = ""  && char(1)
    this_cContvcds    = ""  && char(9)
    this_cContvccs    = ""  && char(9)
    this_cContipcs    = ""  && char(9)
    this_cContipds    = ""  && char(9)
    this_cConticcs    = ""  && char(9)
    this_cConticds    = ""  && char(9)
    this_cCoddests    = ""  && char(10)
    this_cSittribs    = ""  && char(3)
    this_cIpi_Icms    = ""  && char(1)
    this_cCgergia1s   = ""  && char(1)
    this_cBcipis      = ""  && char(1)
    this_cCfosts      = ""  && char(10)
    this_cSubtribs    = ""  && char(1)
    this_cAcresipis   = ""  && char(1)
    this_cIpiimpors   = ""  && char(1)
    this_cIpiom2s     = ""  && char(1)
    this_cUnitimps    = ""  && char(1)
    this_cContda      = ""  && char(9)
    this_cContfrt     = ""  && char(9)
    this_cContseg     = ""  && char(9)
    this_cIpicst      = ""  && char(2)
    this_cPiscst      = ""  && char(2)
    this_cCofcst      = ""  && char(2)
    this_cIssqnl      = ""  && char(5)
    this_cCfost60s    = ""  && char(10)
    this_cIpienq      = ""  && char(3)
    this_cMotdeson    = ""  && char(2)

    *-- Propriedades numeric - SigCdCfo
    this_nAliqipis    = 0   && numeric(4,2)
    this_nIpincreds   = 0   && numeric(1,0)
    this_nPontedescs  = 0   && numeric(1,0)
    this_nAliqivcs    = 0   && numeric(4,2)
    this_nNdigitos    = 0   && numeric(2,0)
    this_nInclicms    = 0   && numeric(1,0)
    this_nTransps     = 0   && numeric(1,0)
    this_nAgrupas     = 0   && numeric(1,0)
    this_nZeradas     = 0   && numeric(1,0)
    this_nIcmsdscs    = 0   && numeric(1,0)
    this_nInclipis    = 0   && numeric(1,0)
    this_cSituas      = ""  && char(1)
    this_nDesicms     = 0   && numeric(1,0)
    this_nDesipis     = 0   && numeric(1,0)
    this_nFrticms     = 0   && numeric(1,0)
    this_nFrtipis     = 0   && numeric(1,0)
    this_nPbcipis     = 0   && numeric(5,2)
    this_nPbcsts      = 0   && numeric(5,2)
    this_nSegicms     = 0   && numeric(1,0)
    this_nSegipis     = 0   && numeric(1,0)
    this_nDtintfis    = 0   && numeric(1,0)
    this_nIntvlrcont  = 0   && numeric(1,0)
    this_nIntvlricms  = 0   && numeric(1,0)
    this_nIntvlripi   = 0   && numeric(1,0)
    this_nIcmsincs    = 0   && numeric(1,0)
    this_nIncicmnfs   = 0   && numeric(1,0)
    this_nTipos       = 0   && numeric(1,0)
    this_nUtilvars    = 0   && numeric(1,0)
    this_nIndmov      = 0   && numeric(1,0)
    this_nIndpagto    = 0   && numeric(1,0)
    this_nTiporecs    = 0   && numeric(1,0)
    this_nAliqcofins  = 0   && numeric(5,2)
    this_nAliqpis     = 0   && numeric(5,2)
    this_nAliqissqn   = 0   && numeric(5,2)
    this_nCtissqn     = 0   && numeric(1,0)
    this_nRettribs    = 0   && numeric(1,0)
    this_nAliqii      = 0   && numeric(5,2)
    this_nObspads     = 0   && numeric(3,0)
    this_nSomaicmfrete = 0  && numeric(1,0)

    *============================================================
    PROCEDURE Init()
    *============================================================
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCfo"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos      = TratarNulo(codigos,      "C")
                THIS.this_cContconts    = TratarNulo(contconts,    "C")
                THIS.this_nAliqipis     = TratarNulo(aliqipis,     "N")
                THIS.this_cContribs     = TratarNulo(contribs,     "C")
                THIS.this_cDescricaos   = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s       = TratarNulo(desc2s,       "C")
                THIS.this_cIcms         = TratarNulo(icms,         "C")
                THIS.this_cIpis         = TratarNulo(ipis,         "C")
                THIS.this_cOperacaos    = TratarNulo(operacaos,    "C")
                THIS.this_cContvcds     = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs     = TratarNulo(contvccs,     "C")
                THIS.this_cContipcs     = TratarNulo(contipcs,     "C")
                THIS.this_cContipds     = TratarNulo(contipds,     "C")
                THIS.this_cConticcs     = TratarNulo(conticcs,     "C")
                THIS.this_cConticds     = TratarNulo(conticds,     "C")
                THIS.this_cCoddests     = TratarNulo(coddests,     "C")
                THIS.this_nIpincreds    = TratarNulo(ipincreds,    "N")
                THIS.this_nPontedescs   = TratarNulo(pontedescs,   "N")
                THIS.this_cSittribs     = TratarNulo(sittribs,     "C")
                THIS.this_nAliqivcs     = TratarNulo(aliqivcs,     "N")
                THIS.this_nNdigitos     = TratarNulo(ndigitos,     "N")
                THIS.this_cIpi_Icms     = TratarNulo(ipi_icms,     "C")
                THIS.this_nInclicms     = TratarNulo(inclicms,     "N")
                THIS.this_cCgergia1s    = TratarNulo(cgergia1s,    "C")
                THIS.this_nTransps      = TratarNulo(transps,      "N")
                THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas      = TratarNulo(zeradas,      "N")
                THIS.this_nIcmsdscs     = TratarNulo(icmsdscs,     "N")
                THIS.this_nInclipis     = TratarNulo(inclipis,     "N")
                THIS.this_cSituas       = TratarNulo(situas,       "C")
                THIS.this_cBcipis       = TratarNulo(bcipis,       "C")
                THIS.this_cCfosts       = TratarNulo(cfosts,       "C")
                THIS.this_nDesicms      = TratarNulo(desicms,      "N")
                THIS.this_nDesipis      = TratarNulo(desipis,      "N")
                THIS.this_nFrticms      = TratarNulo(frticms,      "N")
                THIS.this_nFrtipis      = TratarNulo(frtipis,      "N")
                THIS.this_nPbcipis      = TratarNulo(pbcipis,      "N")
                THIS.this_nPbcsts       = TratarNulo(pbcsts,       "N")
                THIS.this_nSegicms      = TratarNulo(segicms,      "N")
                THIS.this_nSegipis      = TratarNulo(segipis,      "N")
                THIS.this_cSubtribs     = TratarNulo(subtribs,     "C")
                THIS.this_cAcresipis    = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors    = TratarNulo(ipiimpors,    "C")
                THIS.this_nDtintfis     = TratarNulo(dtintfis,     "N")
                THIS.this_cIpiom2s      = TratarNulo(ipiom2s,      "C")
                THIS.this_cUnitimps     = TratarNulo(unitimps,     "C")
                THIS.this_nIntvlrcont   = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms   = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi    = TratarNulo(intvlripi,    "N")
                THIS.this_nIcmsincs     = TratarNulo(icmsincs,     "N")
                THIS.this_nIncicmnfs    = TratarNulo(incicmnfs,    "N")
                THIS.this_nTipos        = TratarNulo(tipos,        "N")
                THIS.this_nUtilvars     = TratarNulo(utilvars,     "N")
                THIS.this_cContda       = TratarNulo(contda,       "C")
                THIS.this_cContfrt      = TratarNulo(contfrt,      "C")
                THIS.this_cContseg      = TratarNulo(contseg,      "C")
                THIS.this_nIndmov       = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto     = TratarNulo(indpagto,     "N")
                THIS.this_nTiporecs     = TratarNulo(tiporecs,     "N")
                THIS.this_cIpicst       = TratarNulo(ipicst,       "C")
                THIS.this_cPiscst       = TratarNulo(piscst,       "C")
                THIS.this_cCofcst       = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl       = TratarNulo(issqnl,       "C")
                THIS.this_nAliqcofins   = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqpis      = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqissqn    = TratarNulo(aliqissqn,    "N")
                THIS.this_nCtissqn      = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs     = TratarNulo(rettribs,     "N")
                THIS.this_nAliqii       = TratarNulo(aliqii,       "N")
                THIS.this_cCfost60s     = TratarNulo(cfost60s,     "C")
                THIS.this_nObspads      = TratarNulo(obspads,      "N")
                THIS.this_cIpienq       = TratarNulo(ipienq,       "C")
                THIS.this_nSomaicmfrete = TratarNulo(somaicmfrete, "N")
                THIS.this_cMotdeson     = TratarNulo(motdeson,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCfo (
                    codigos, contconts, aliqipis, contribs, descricaos, desc2s,
                    icms, ipis, operacaos, contvcds, contvccs, contipcs, contipds,
                    conticcs, conticds, coddests, ipincreds, pontedescs, sittribs,
                    aliqivcs, ndigitos, ipi_icms, inclicms, cgergia1s, transps,
                    agrupas, zeradas, icmsdscs, inclipis, situas, bcipis, cfosts,
                    desicms, desipis, frticms, frtipis, pbcipis, pbcsts,
                    segicms, segipis, subtribs, acresipis, ipiimpors, dtintfis,
                    ipiom2s, unitimps, intvlrcont, intvlricms, intvlripi,
                    icmsincs, incicmnfs, tipos, utilvars, contda, contfrt, contseg,
                    indmov, indpagto, tiporecs, ipicst, piscst, cofcst, issqnl,
                    aliqcofins, aliqpis, aliqissqn, ctissqn, rettribs, aliqii,
                    cfost60s, obspads, ipienq, somaicmfrete, motdeson
                ) VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cContconts)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqipis, 2)>>,
                    <<EscaparSQL(THIS.this_cContribs)>>,
                    <<EscaparSQL(THIS.this_cDescricaos)>>,
                    <<EscaparSQL(THIS.this_cDesc2s)>>,
                    <<EscaparSQL(THIS.this_cIcms)>>,
                    <<EscaparSQL(THIS.this_cIpis)>>,
                    <<EscaparSQL(THIS.this_cOperacaos)>>,
                    <<EscaparSQL(THIS.this_cContvcds)>>,
                    <<EscaparSQL(THIS.this_cContvccs)>>,
                    <<EscaparSQL(THIS.this_cContipcs)>>,
                    <<EscaparSQL(THIS.this_cContipds)>>,
                    <<EscaparSQL(THIS.this_cConticcs)>>,
                    <<EscaparSQL(THIS.this_cConticds)>>,
                    <<EscaparSQL(THIS.this_cCoddests)>>,
                    <<FormatarNumeroSQL(THIS.this_nIpincreds, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPontedescs, 0)>>,
                    <<EscaparSQL(THIS.this_cSittribs)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqivcs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nNdigitos, 0)>>,
                    <<EscaparSQL(THIS.this_cIpi_Icms)>>,
                    <<FormatarNumeroSQL(THIS.this_nInclicms, 0)>>,
                    <<EscaparSQL(THIS.this_cCgergia1s)>>,
                    <<FormatarNumeroSQL(THIS.this_nTransps, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAgrupas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nZeradas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmsdscs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nInclipis, 0)>>,
                    <<EscaparSQL(THIS.this_cSituas)>>,
                    <<EscaparSQL(THIS.this_cBcipis)>>,
                    <<EscaparSQL(THIS.this_cCfosts)>>,
                    <<FormatarNumeroSQL(THIS.this_nDesicms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nDesipis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFrticms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nFrtipis, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPbcipis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nPbcsts, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nSegicms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nSegipis, 0)>>,
                    <<EscaparSQL(THIS.this_cSubtribs)>>,
                    <<EscaparSQL(THIS.this_cAcresipis)>>,
                    <<EscaparSQL(THIS.this_cIpiimpors)>>,
                    <<FormatarNumeroSQL(THIS.this_nDtintfis, 0)>>,
                    <<EscaparSQL(THIS.this_cIpiom2s)>>,
                    <<EscaparSQL(THIS.this_cUnitimps)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlrcont, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlricms, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIntvlripi, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIcmsincs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIncicmnfs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nUtilvars, 0)>>,
                    <<EscaparSQL(THIS.this_cContda)>>,
                    <<EscaparSQL(THIS.this_cContfrt)>>,
                    <<EscaparSQL(THIS.this_cContseg)>>,
                    <<FormatarNumeroSQL(THIS.this_nIndmov, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nIndpagto, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nTiporecs, 0)>>,
                    <<EscaparSQL(THIS.this_cIpicst)>>,
                    <<EscaparSQL(THIS.this_cPiscst)>>,
                    <<EscaparSQL(THIS.this_cCofcst)>>,
                    <<EscaparSQL(THIS.this_cIssqnl)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqcofins, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqissqn, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nCtissqn, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nRettribs, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAliqii, 2)>>,
                    <<EscaparSQL(THIS.this_cCfost60s)>>,
                    <<FormatarNumeroSQL(THIS.this_nObspads, 0)>>,
                    <<EscaparSQL(THIS.this_cIpienq)>>,
                    <<FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0)>>,
                    <<EscaparSQL(THIS.this_cMotdeson)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cfoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCfo SET
                    contconts    = <<EscaparSQL(THIS.this_cContconts)>>,
                    aliqipis     = <<FormatarNumeroSQL(THIS.this_nAliqipis, 2)>>,
                    contribs     = <<EscaparSQL(THIS.this_cContribs)>>,
                    descricaos   = <<EscaparSQL(THIS.this_cDescricaos)>>,
                    desc2s       = <<EscaparSQL(THIS.this_cDesc2s)>>,
                    icms         = <<EscaparSQL(THIS.this_cIcms)>>,
                    ipis         = <<EscaparSQL(THIS.this_cIpis)>>,
                    operacaos    = <<EscaparSQL(THIS.this_cOperacaos)>>,
                    contvcds     = <<EscaparSQL(THIS.this_cContvcds)>>,
                    contvccs     = <<EscaparSQL(THIS.this_cContvccs)>>,
                    contipcs     = <<EscaparSQL(THIS.this_cContipcs)>>,
                    contipds     = <<EscaparSQL(THIS.this_cContipds)>>,
                    conticcs     = <<EscaparSQL(THIS.this_cConticcs)>>,
                    conticds     = <<EscaparSQL(THIS.this_cConticds)>>,
                    coddests     = <<EscaparSQL(THIS.this_cCoddests)>>,
                    ipincreds    = <<FormatarNumeroSQL(THIS.this_nIpincreds, 0)>>,
                    pontedescs   = <<FormatarNumeroSQL(THIS.this_nPontedescs, 0)>>,
                    sittribs     = <<EscaparSQL(THIS.this_cSittribs)>>,
                    aliqivcs     = <<FormatarNumeroSQL(THIS.this_nAliqivcs, 2)>>,
                    ndigitos     = <<FormatarNumeroSQL(THIS.this_nNdigitos, 0)>>,
                    ipi_icms     = <<EscaparSQL(THIS.this_cIpi_Icms)>>,
                    inclicms     = <<FormatarNumeroSQL(THIS.this_nInclicms, 0)>>,
                    cgergia1s    = <<EscaparSQL(THIS.this_cCgergia1s)>>,
                    transps      = <<FormatarNumeroSQL(THIS.this_nTransps, 0)>>,
                    agrupas      = <<FormatarNumeroSQL(THIS.this_nAgrupas, 0)>>,
                    zeradas      = <<FormatarNumeroSQL(THIS.this_nZeradas, 0)>>,
                    icmsdscs     = <<FormatarNumeroSQL(THIS.this_nIcmsdscs, 0)>>,
                    inclipis     = <<FormatarNumeroSQL(THIS.this_nInclipis, 0)>>,
                    situas       = <<EscaparSQL(THIS.this_cSituas)>>,
                    bcipis       = <<EscaparSQL(THIS.this_cBcipis)>>,
                    cfosts       = <<EscaparSQL(THIS.this_cCfosts)>>,
                    desicms      = <<FormatarNumeroSQL(THIS.this_nDesicms, 0)>>,
                    desipis      = <<FormatarNumeroSQL(THIS.this_nDesipis, 0)>>,
                    frticms      = <<FormatarNumeroSQL(THIS.this_nFrticms, 0)>>,
                    frtipis      = <<FormatarNumeroSQL(THIS.this_nFrtipis, 0)>>,
                    pbcipis      = <<FormatarNumeroSQL(THIS.this_nPbcipis, 2)>>,
                    pbcsts       = <<FormatarNumeroSQL(THIS.this_nPbcsts, 2)>>,
                    segicms      = <<FormatarNumeroSQL(THIS.this_nSegicms, 0)>>,
                    segipis      = <<FormatarNumeroSQL(THIS.this_nSegipis, 0)>>,
                    subtribs     = <<EscaparSQL(THIS.this_cSubtribs)>>,
                    acresipis    = <<EscaparSQL(THIS.this_cAcresipis)>>,
                    ipiimpors    = <<EscaparSQL(THIS.this_cIpiimpors)>>,
                    dtintfis     = <<FormatarNumeroSQL(THIS.this_nDtintfis, 0)>>,
                    ipiom2s      = <<EscaparSQL(THIS.this_cIpiom2s)>>,
                    unitimps     = <<EscaparSQL(THIS.this_cUnitimps)>>,
                    intvlrcont   = <<FormatarNumeroSQL(THIS.this_nIntvlrcont, 0)>>,
                    intvlricms   = <<FormatarNumeroSQL(THIS.this_nIntvlricms, 0)>>,
                    intvlripi    = <<FormatarNumeroSQL(THIS.this_nIntvlripi, 0)>>,
                    icmsincs     = <<FormatarNumeroSQL(THIS.this_nIcmsincs, 0)>>,
                    incicmnfs    = <<FormatarNumeroSQL(THIS.this_nIncicmnfs, 0)>>,
                    tipos        = <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    utilvars     = <<FormatarNumeroSQL(THIS.this_nUtilvars, 0)>>,
                    contda       = <<EscaparSQL(THIS.this_cContda)>>,
                    contfrt      = <<EscaparSQL(THIS.this_cContfrt)>>,
                    contseg      = <<EscaparSQL(THIS.this_cContseg)>>,
                    indmov       = <<FormatarNumeroSQL(THIS.this_nIndmov, 0)>>,
                    indpagto     = <<FormatarNumeroSQL(THIS.this_nIndpagto, 0)>>,
                    tiporecs     = <<FormatarNumeroSQL(THIS.this_nTiporecs, 0)>>,
                    ipicst       = <<EscaparSQL(THIS.this_cIpicst)>>,
                    piscst       = <<EscaparSQL(THIS.this_cPiscst)>>,
                    cofcst       = <<EscaparSQL(THIS.this_cCofcst)>>,
                    issqnl       = <<EscaparSQL(THIS.this_cIssqnl)>>,
                    aliqcofins   = <<FormatarNumeroSQL(THIS.this_nAliqcofins, 2)>>,
                    aliqpis      = <<FormatarNumeroSQL(THIS.this_nAliqpis, 2)>>,
                    aliqissqn    = <<FormatarNumeroSQL(THIS.this_nAliqissqn, 2)>>,
                    ctissqn      = <<FormatarNumeroSQL(THIS.this_nCtissqn, 0)>>,
                    rettribs     = <<FormatarNumeroSQL(THIS.this_nRettribs, 0)>>,
                    aliqii       = <<FormatarNumeroSQL(THIS.this_nAliqii, 2)>>,
                    cfost60s     = <<EscaparSQL(THIS.this_cCfost60s)>>,
                    obspads      = <<FormatarNumeroSQL(THIS.this_nObspads, 0)>>,
                    ipienq       = <<EscaparSQL(THIS.this_cIpienq)>>,
                    somaicmfrete = <<FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0)>>,
                    motdeson     = <<EscaparSQL(THIS.this_cMotdeson)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cfoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigCdCfo WHERE codigos = <<EscaparSQL(THIS.this_cCodigos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cfoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros para o grid (codigos, descricaos, situas)
    * DynamicForeColor usa situas para destacar registros inativos
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), situas C(1))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT codigos, descricaos, situas FROM SigCdCfo"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY codigos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cfoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT codigos, contconts, aliqipis, contribs, descricaos, desc2s,
                       icms, ipis, operacaos, contvcds, contvccs, contipcs, contipds,
                       conticcs, conticds, coddests, ipincreds, pontedescs, sittribs,
                       aliqivcs, ndigitos, ipi_icms, inclicms, cgergia1s, transps,
                       agrupas, zeradas, icmsdscs, inclipis, situas, bcipis, cfosts,
                       desicms, desipis, frticms, frtipis, pbcipis, pbcsts,
                       segicms, segipis, subtribs, acresipis, ipiimpors, dtintfis,
                       ipiom2s, unitimps, intvlrcont, intvlricms, intvlripi,
                       icmsincs, incicmnfs, tipos, utilvars, contda, contfrt, contseg,
                       indmov, indpagto, tiporecs, ipicst, piscst, cofcst, issqnl,
                       aliqcofins, aliqpis, aliqissqn, ctissqn, rettribs, aliqii,
                       cfost60s, obspads, ipienq, somaicmfrete, motdeson
                FROM SigCdCfo
                WHERE codigos = <<EscaparSQL(par_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("CFOP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cfoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *--------------------------------------------------------------------------
    * Validar - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Validar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCfo" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCfo")

            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCfo")
                SELECT cursor_4c_ChkCfo
                loc_lExiste = (cursor_4c_ChkCfo.nExiste > 0)
                USE IN cursor_4c_ChkCfo
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao verificar duplicidade:" + CHR(13) + loException.Message, "cfoBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

ENDDEFINE

