# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 4/10
- Mensagem: Testes automaticos: 89% < 100%. Falhas: Teste 'GridTemDados': Nenhum cursor de grid encontrado apos instanciacao

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-04-15 10:28:40] [INFO] Config FPW: (nao fornecido)
[2026-04-15 10:28:40] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-15 10:28:40] [INFO] Timeout: 300 segundos
[2026-04-15 10:28:40] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_bdfmn3jx.prg
[2026-04-15 10:28:40] [INFO] Conteudo do wrapper:
[2026-04-15 10:28:40] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
QUIT

[2026-04-15 10:28:40] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_bdfmn3jx.prg
[2026-04-15 10:28:40] [INFO] VFP output esperado em: C:\4c\tasks\task017\vfp_output.txt
[2026-04-15 10:28:40] [INFO] Executando Visual FoxPro 9...
[2026-04-15 10:28:40] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_bdfmn3jx.prg
[2026-04-15 10:28:40] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_bdfmn3jx.prg
[2026-04-15 10:28:40] [INFO] Timeout configurado: 300 segundos
[2026-04-15 10:28:44] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-15 10:28:44] [INFO] VFP9 finalizado em 3.5476678 segundos
[2026-04-15 10:28:44] [INFO] Exit Code: 
[2026-04-15 10:28:44] [INFO] 
[2026-04-15 10:28:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-15 10:28:44] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_bdfmn3jx.prg
[2026-04-15 10:28:44] [INFO] 
[2026-04-15 10:28:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-15 10:28:44] [INFO] * Auto-generated wrapper for parameters
[2026-04-15 10:28:44] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-15 10:28:44] [INFO] * Parameters: 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
[2026-04-15 10:28:44] [INFO] 
[2026-04-15 10:28:44] [INFO] * Anti-dialog protections for unattended execution
[2026-04-15 10:28:44] [INFO] SET SAFETY OFF
[2026-04-15 10:28:44] [INFO] SET RESOURCE OFF
[2026-04-15 10:28:44] [INFO] SET TALK OFF
[2026-04-15 10:28:44] [INFO] SET NOTIFY OFF
[2026-04-15 10:28:44] [INFO] SYS(2335, 0)
[2026-04-15 10:28:44] [INFO] 
[2026-04-15 10:28:44] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
[2026-04-15 10:28:44] [INFO] QUIT
[2026-04-15 10:28:44] [INFO] 
[2026-04-15 10:28:44] [INFO] === Fim do Wrapper.prg ===
[2026-04-15 10:28:44] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-04-15 10:33:18] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-15 10:33:18] [INFO] Config FPW: (nao fornecido)
[2026-04-15 10:33:18] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-15 10:33:18] [INFO] Timeout: 300 segundos
[2026-04-15 10:33:18] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5ogc3ngs.prg
[2026-04-15 10:33:18] [INFO] Conteudo do wrapper:
[2026-04-15 10:33:18] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
QUIT

[2026-04-15 10:33:18] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5ogc3ngs.prg
[2026-04-15 10:33:18] [INFO] VFP output esperado em: C:\4c\tasks\task017\vfp_output.txt
[2026-04-15 10:33:18] [INFO] Executando Visual FoxPro 9...
[2026-04-15 10:33:18] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5ogc3ngs.prg
[2026-04-15 10:33:18] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5ogc3ngs.prg
[2026-04-15 10:33:18] [INFO] Timeout configurado: 300 segundos
[2026-04-15 10:33:21] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-15 10:33:21] [INFO] VFP9 finalizado em 3.5894464 segundos
[2026-04-15 10:33:21] [INFO] Exit Code: 
[2026-04-15 10:33:21] [INFO] 
[2026-04-15 10:33:21] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-15 10:33:21] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_5ogc3ngs.prg
[2026-04-15 10:33:21] [INFO] 
[2026-04-15 10:33:21] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-15 10:33:21] [INFO] * Auto-generated wrapper for parameters
[2026-04-15 10:33:21] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-15 10:33:21] [INFO] * Parameters: 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
[2026-04-15 10:33:21] [INFO] 
[2026-04-15 10:33:21] [INFO] * Anti-dialog protections for unattended execution
[2026-04-15 10:33:21] [INFO] SET SAFETY OFF
[2026-04-15 10:33:21] [INFO] SET RESOURCE OFF
[2026-04-15 10:33:22] [INFO] SET TALK OFF
[2026-04-15 10:33:22] [INFO] SET NOTIFY OFF
[2026-04-15 10:33:22] [INFO] SYS(2335, 0)
[2026-04-15 10:33:22] [INFO] 
[2026-04-15 10:33:22] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
[2026-04-15 10:33:22] [INFO] QUIT
[2026-04-15 10:33:22] [INFO] 
[2026-04-15 10:33:22] [INFO] === Fim do Wrapper.prg ===
[2026-04-15 10:33:22] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-04-15 10:36:30] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-15 10:36:30] [INFO] Config FPW: (nao fornecido)
[2026-04-15 10:36:30] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-15 10:36:30] [INFO] Timeout: 300 segundos
[2026-04-15 10:36:30] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_qbgzkg2p.prg
[2026-04-15 10:36:30] [INFO] Conteudo do wrapper:
[2026-04-15 10:36:30] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
QUIT

[2026-04-15 10:36:30] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_qbgzkg2p.prg
[2026-04-15 10:36:30] [INFO] VFP output esperado em: C:\4c\tasks\task017\vfp_output.txt
[2026-04-15 10:36:30] [INFO] Executando Visual FoxPro 9...
[2026-04-15 10:36:30] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_qbgzkg2p.prg
[2026-04-15 10:36:30] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_qbgzkg2p.prg
[2026-04-15 10:36:30] [INFO] Timeout configurado: 300 segundos
[2026-04-15 10:36:35] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-15 10:36:35] [INFO] VFP9 finalizado em 5.1341418 segundos
[2026-04-15 10:36:35] [INFO] Exit Code: 
[2026-04-15 10:36:35] [INFO] 
[2026-04-15 10:36:35] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-15 10:36:35] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_qbgzkg2p.prg
[2026-04-15 10:36:35] [INFO] 
[2026-04-15 10:36:35] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-15 10:36:35] [INFO] * Auto-generated wrapper for parameters
[2026-04-15 10:36:35] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-15 10:36:35] [INFO] * Parameters: 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
[2026-04-15 10:36:35] [INFO] 
[2026-04-15 10:36:35] [INFO] * Anti-dialog protections for unattended execution
[2026-04-15 10:36:35] [INFO] SET SAFETY OFF
[2026-04-15 10:36:35] [INFO] SET RESOURCE OFF
[2026-04-15 10:36:35] [INFO] SET TALK OFF
[2026-04-15 10:36:35] [INFO] SET NOTIFY OFF
[2026-04-15 10:36:36] [INFO] SYS(2335, 0)
[2026-04-15 10:36:36] [INFO] 
[2026-04-15 10:36:36] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
[2026-04-15 10:36:36] [INFO] QUIT
[2026-04-15 10:36:36] [INFO] 
[2026-04-15 10:36:36] [INFO] === Fim do Wrapper.prg ===
[2026-04-15 10:36:36] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-04-15 10:37:40] [INFO] === VFP EXECUTOR v2.0 ===
[2026-04-15 10:37:40] [INFO] Config FPW: (nao fornecido)
[2026-04-15 10:37:40] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-15 10:37:40] [INFO] Timeout: 300 segundos
[2026-04-15 10:37:40] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_ijxld4yr.prg
[2026-04-15 10:37:40] [INFO] Conteudo do wrapper:
[2026-04-15 10:37:40] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
QUIT

[2026-04-15 10:37:40] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_ijxld4yr.prg
[2026-04-15 10:37:40] [INFO] VFP output esperado em: C:\4c\tasks\task017\vfp_output.txt
[2026-04-15 10:37:40] [INFO] Executando Visual FoxPro 9...
[2026-04-15 10:37:40] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_ijxld4yr.prg
[2026-04-15 10:37:40] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_ijxld4yr.prg
[2026-04-15 10:37:40] [INFO] Timeout configurado: 300 segundos
[2026-04-15 10:37:46] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-04-15 10:37:46] [INFO] VFP9 finalizado em 5.2000428 segundos
[2026-04-15 10:37:46] [INFO] Exit Code: 
[2026-04-15 10:37:46] [INFO] 
[2026-04-15 10:37:46] [INFO] Arquivos temporarios preservados para inspecao:
[2026-04-15 10:37:46] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_ijxld4yr.prg
[2026-04-15 10:37:46] [INFO] 
[2026-04-15 10:37:46] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-04-15 10:37:46] [INFO] * Auto-generated wrapper for parameters
[2026-04-15 10:37:46] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-04-15 10:37:46] [INFO] * Parameters: 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
[2026-04-15 10:37:46] [INFO] 
[2026-04-15 10:37:46] [INFO] * Anti-dialog protections for unattended execution
[2026-04-15 10:37:46] [INFO] SET SAFETY OFF
[2026-04-15 10:37:46] [INFO] SET RESOURCE OFF
[2026-04-15 10:37:46] [INFO] SET TALK OFF
[2026-04-15 10:37:46] [INFO] SET NOTIFY OFF
[2026-04-15 10:37:46] [INFO] SYS(2335, 0)
[2026-04-15 10:37:46] [INFO] 
[2026-04-15 10:37:46] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigtosen', 'C:\4c\tasks\task017', 'OPERACIONAL'
[2026-04-15 10:37:46] [INFO] QUIT
[2026-04-15 10:37:46] [INFO] 
[2026-04-15 10:37:46] [INFO] === Fim do Wrapper.prg ===
[2026-04-15 10:37:46] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigtosen",
  "timestamp": "20260415103745",
  "testes": [
    {
      "nome": "Instanciacao",
      "passou": true,
      "erro": "",
      "detalhes": "Objeto criado com sucesso"
    },
    {
      "nome": "ContainersFlutuantes",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum container flutuante encontrado (OK)"
    },
    {
      "nome": "CarregarDadosReais",
      "passou": true,
      "erro": "",
      "detalhes": "CarregarLista() executado | (sem registros - tabela pode estar vazia)"
    },
    {
      "nome": "NavegacaoPaginas",
      "passou": true,
      "erro": "",
      "detalhes": "Nenhum PageFrame encontrado (form sem paginas)"
    },
    {
      "nome": "BtnIncluirNavegacao",
      "passou": true,
      "erro": "",
      "detalhes": "Metodo BtnIncluirClick nao encontrado (OK para REPORT/OPERACIONAL)"
    },
    {
      "nome": "BtnEncerrarExiste",
      "passou": true,
      "erro": "",
      "detalhes": "BtnEncerrarClick nao encontrado, mas existe: BtnSairClick"
    },
    {
      "nome": "GridTemDados",
      "passou": false,
      "erro": "Nenhum cursor de grid encontrado apos instanciacao",
      "detalhes": ""
    },
    {
      "nome": "LookupMetodosExistem",
      "passou": true,
      "erro": "",
      "detalhes": "AbrirLookup: 0 | KeyPress handlers: 5 (KEYPRESS, TXTDEMPKEYPRESS, TXTEMPKEYPRESS, TXTSENHAKEYPRESS, TXTUSUARIOKEYPRESS)"
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigtosen.prg):
*==============================================================================
* Formsigtosen.prg - Formulario de Acesso ao Sistema (Login/Autenticacao)
* Data: 2026-04-15
* Tipo: OPERACIONAL (layout flat, sem PageFrame)
* Ref: tasks/task017/sigtosen_form_codigo_fonte.txt
*==============================================================================

DEFINE CLASS Formsigtosen AS FormBase

    Height      = 356
    Width       = 382
    AutoCenter  = .T.
    BackColor   = RGB(255,255,255)
    BorderStyle = 2
    Caption     = "Acesso ao Sistema"
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    WindowType  = 1
    ShowTips    = .T.
    DataSession = 2

    this_lGetUsuario    = .F.
    this_lPrimeiraVez   = .F.
    this_lAutomatico    = .F.
    this_lUsuarioOk     = .F.
    this_nBloqueiaSenha = 1
    this_cUsuarioAtual  = ""
    this_cNomePrograma  = ""

    *==========================================================================
    * Init - Aceita parametros de controle de login
    *==========================================================================
    PROCEDURE Init(par_lGetUsuario, par_lPrimeiraVez, par_lAutomatico, par_cPrograma)
        THIS.this_lGetUsuario   = IIF(TYPE("par_lGetUsuario")  = "L", par_lGetUsuario,  .F.)
        THIS.this_lPrimeiraVez  = IIF(TYPE("par_lPrimeiraVez") = "L", par_lPrimeiraVez, .F.)
        THIS.this_lAutomatico   = IIF(TYPE("par_lAutomatico")  = "L", par_lAutomatico,  .F.)
        THIS.this_cNomePrograma = IIF(TYPE("par_cPrograma")    = "C", par_cPrograma,    "OPERACIONAL")
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria BO, conecta e inicializa interface de login
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigtosenBO")
            THIS.this_oBusinessObject.this_cNomePrograma = THIS.this_cNomePrograma

            SET SYSMENU TO
            SET SYSMENU OFF
            HIDE POPUP ALL

            IF TYPE("goSistema") = "O" AND TYPE("goSistema.BarraAtalho") = "O"
                goSistema.BarraAtalho.Release()
            ENDIF

            THIS.CriarImagemLogo()
            THIS.CriarLabels()
            THIS.CriarCamposLogin()
            THIS.CriarBotaoSaida()

            IF gnConnHandle > 0
                THIS.this_lUsuarioOk = (NOT THIS.this_lGetUsuario)

                THIS.LockScreen = .T.

                THIS.txt_4c_USUARIO.Enabled = THIS.this_lGetUsuario
                THIS.this_nBloqueiaSenha    = 1

                PUBLIC gcUsuar, gcEmpr, _tipoe, usuar
                gcUsuar = PADR(IIF(TYPE("gcUsuar") = "C", gcUsuar, ""), 10)
                gcEmpr  = PADR(IIF(TYPE("gcEmpr") = "C", gcEmpr, ""), 3)
                usuar   = PADR(IIF(TYPE("usuar") = "C", usuar, ""), 10)
                _empr   = PADR(IIF(TYPE("_empr") = "C", _empr, ""), 3)

                IF TYPE("lcEmpresaLogada") = "C" AND NOT EMPTY(lcEmpresaLogada)
                    go_4c_Sistema.cCodEmpresa = lcEmpresaLogada
                ENDIF

                IF THIS.this_lPrimeiraVez
                    THIS.txt_4c_USUARIO.Value = usuar
                ELSE
                    THIS.txt_4c_USUARIO.Value = usuar
                ENDIF

                THIS.this_cUsuarioAtual = PADR(IIF(THIS.this_lPrimeiraVez, "", gcUsuar), 10)

                THIS.AjustarEmpresas()

                THIS.txt_4c_SENHA.Enabled = THIS.this_lGetUsuario
                THIS.txt_4c_SENHA.Value   = IIF(THIS.this_lGetUsuario, SPACE(10), REPLICATE("*", 10))

                THIS.this_oBusinessObject.CarregarParametros()

                IF THIS.this_oBusinessObject.this_nPafEcf = 1
                    THIS.lbl_4c_Label3.Visible = .T.
                ENDIF

                IF TYPE("_Screen.poTimer") = "O"
                    fDelAcesso()
                ENDIF

                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.VincularEventos()

                IF THIS.this_lGetUsuario
                    THIS.AlternarPagina(1)
                ELSE
                    THIS.ValidarUsuario()
                    IF THIS.this_lAutomatico
                        THIS.txt_4c_EMP.Value = go_4c_Sistema.cCodEmpresa
                    ENDIF
                    THIS.AlternarPagina(2)
                ENDIF

                THIS.Refresh()
                THIS.LockScreen = .F.

                DECLARE INTEGER SetForegroundWindow IN user32 INTEGER
                SetForegroundWindow(THIS.HWnd)
            ELSE
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                    "o com Servidor de Banco de Dados.", "Erro")
                DO pEncerrar
                loc_lResultado = .F.
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CriarImagemLogo - Adiciona imagem do logotipo 4Control
    *==========================================================================
    PROTECTED PROCEDURE CriarImagemLogo()
        THIS.AddObject("img_4c_ImgFigJpg", "Image")
        WITH THIS.img_4c_ImgFigJpg
            .Top         = 0
            .Left        = 94
            .Width       = 191
            .Height      = 72
            .Picture     = gc_4c_CaminhoIcones + "4control_logo2.png"
            .Stretch     = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Enabled     = .F.
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CriarLabels - Adiciona todos os Labels da tela de login
    *==========================================================================
    PROTECTED PROCEDURE CriarLabels()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 9
            .BackStyle  = 0
            .Caption    = "Usu" + CHR(225) + "rio :"
            .Height     = 16
            .Left       = 22
            .Top        = 95
            .Width      = 55
            .ForeColor  = RGB(128,128,128)
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 9
            .BackStyle  = 0
            .Caption    = "Senha :"
            .Height     = 16
            .Left       = 22
            .Top        = 145
            .Width      = 48
            .ForeColor  = RGB(128,128,128)
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH THIS.lbl_4c_LblEmpresa
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontName   = "Tahoma"
            .FontSize   = 9
            .BackStyle  = 0
            .Caption    = "Empresa :"
            .Height     = 16
            .Left       = 22
            .Top        = 198
            .Width      = 61
            .ForeColor  = RGB(128,128,128)
            .Visible    = .T.
        ENDWITH

        THIS.AddObject("lbl_4c_LbltitT", "Label")
        WITH THIS.lbl_4c_LbltitT
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontItalic = .T.
            .FontSize   = 18
            .BackStyle  = 0
            .Caption    = "4Control"
            .Height     = 31
            .Left       = 271
            .Top        = 253
            .Width      = 99
            .ForeColor  = RGB(128,128,128)
            .Visible    = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_LblTitF", "Label")
        WITH THIS.lbl_4c_LblTitF
            .AutoSize   = .T.
            .FontBold   = .T.
            .FontItalic = .T.
            .FontSize   = 18
            .BackStyle  = 0
            .Caption    = "4Control"
            .Height     = 31
            .Left       = 272
            .Top        = 253
            .Width      = 99
            .ForeColor  = RGB(36,84,155)
            .Visible    = .F.
        ENDWITH

        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .AutoSize    = .T.
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackStyle   = 0
            .BorderStyle = 0
            .Caption     = "MENU FISCAL INACESS" + CHR(205) + "VEL NESTA TELA"
            .Height      = 15
            .Left        = 32
            .Top         = 260
            .Width       = 217
            .ForeColor   = RGB(128,128,128)
            .Visible     = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CriarCamposLogin - Adiciona TextBoxes de usuario, senha e empresa
    *==========================================================================
    PROTECTED PROCEDURE CriarCamposLogin()
        THIS.AddObject("txt_4c_USUARIO", "TextBox")
        WITH THIS.txt_4c_USUARIO
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 11
            .BackStyle     = 1
            .Format        = "K!"
            .Height        = 25
            .Left          = 22
            .MaxLength     = 10
            .SelectOnEntry = .F.
            .SpecialEffect = 1
            .TabIndex      = 1
            .ToolTipText   = "Usu" + CHR(225) + "rio do Sistema"
            .Top           = 113
            .Width         = 119
            .ForeColor     = RGB(90,90,90)
            .BorderColor   = RGB(238,238,238)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_SENHA", "TextBox")
        WITH THIS.txt_4c_SENHA
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 11
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K!"
            .Height        = 26
            .Left          = 22
            .MaxLength     = 10
            .SpecialEffect = 1
            .TabIndex      = 2
            .ToolTipText   = "Senha do Usu" + CHR(225) + "rio"
            .Top           = 166
            .Width         = 120
            .PasswordChar  = "*"
            .ForeColor     = RGB(90,90,90)
            .DisabledForeColor = RGB(128,128,128)
            .BorderColor   = RGB(238,238,238)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_EMP", "TextBox")
        WITH THIS.txt_4c_EMP
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 11
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 26
            .Left          = 22
            .MaxLength     = 3
            .SpecialEffect = 1
            .TabIndex      = 3
            .ToolTipText   = "C" + CHR(243) + "digo da Empresa"
            .Top           = 217
            .Width         = 45
            .ForeColor     = RGB(90,90,90)
            .BorderColor   = RGB(238,238,238)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        THIS.AddObject("txt_4c_Demp", "TextBox")
        WITH THIS.txt_4c_Demp
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 11
            .BackStyle     = 1
            .BorderStyle   = 1
            .Format        = "K"
            .Height        = 26
            .Left          = 74
            .MaxLength     = 40
            .SpecialEffect = 1
            .TabIndex      = 4
            .ToolTipText   = "Descri" + CHR(231) + CHR(227) + "o da Empresa"
            .Top           = 217
            .Width         = 294
            .ForeColor     = RGB(90,90,90)
            .BorderColor   = RGB(238,238,238)
            .Value         = ""
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * CriarBotaoSaida - Adiciona CommandGroup SAIDA (botao de encerrar sistema)
    *==========================================================================
    PROTECTED PROCEDURE CriarBotaoSaida()
        THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
        WITH THIS.obj_4c_SAIDA
            .ButtonCount = 1
            .BorderStyle = 0
            .Value       = 0
            .Height      = 80
            .Left        = 290
            .Top         = 116
            .Width       = 78
            .TabIndex    = 5
            .BackColor   = RGB(255,255,255)
            .Visible     = .T.
        ENDWITH
        WITH THIS.obj_4c_SAIDA.Buttons(1)
            .Top         = 2
            .Left        = 1
            .Height      = 75
            .Width       = 75
            .FontBold    = .T.
            .FontItalic  = .F.
            .FontName    = "Small Fonts"
            .FontSize    = 7
            .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel      = .T.
            .Caption     = ""
            .ToolTipText = "[ESC] Sair do Sistema"
            .BackColor   = RGB(255,255,255)
            .Themes      = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Configura layout principal da tela de login
    * Form OPERACIONAL (login) - nao tem PageFrame/Grid/CRUD
    * Organiza posicionamento dos controles de autenticacao
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_lEmpVisivel

        loc_lEmpVisivel = .F.

        IF gnConnHandle > 0
            IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 1
                loc_lEmpVisivel = .T.
            ENDIF
        ENDIF

        THIS.lbl_4c_LblEmpresa.Visible = loc_lEmpVisivel
        THIS.txt_4c_EMP.Visible        = loc_lEmpVisivel
        THIS.txt_4c_Demp.Visible       = loc_lEmpVisivel

        IF THIS.this_lGetUsuario
            THIS.txt_4c_USUARIO.Enabled = .T.
            THIS.txt_4c_SENHA.Enabled   = .T.
        ELSE
            THIS.txt_4c_USUARIO.Enabled = .F.
            THIS.txt_4c_SENHA.Enabled   = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna estado do formulario de login
    * par_nPagina: 1=Modo usuario/senha, 2=Modo selecao empresa
    * Form OPERACIONAL (login) - nao tem PageFrame, alterna visibilidade
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        DO CASE
            CASE par_nPagina = 1
                THIS.txt_4c_USUARIO.Enabled = THIS.this_lGetUsuario
                THIS.txt_4c_SENHA.Enabled   = THIS.this_lGetUsuario
                THIS.txt_4c_EMP.Enabled     = .F.
                THIS.txt_4c_Demp.Enabled    = .F.
                IF THIS.this_lGetUsuario
                    THIS.txt_4c_USUARIO.SetFocus()
                ENDIF

            CASE par_nPagina = 2
                THIS.txt_4c_USUARIO.Enabled = .F.
                THIS.txt_4c_SENHA.Enabled   = .F.
                THIS.txt_4c_EMP.Enabled     = .T.
                THIS.txt_4c_Demp.Enabled    = .T.
                THIS.txt_4c_EMP.SetFocus()
        ENDCASE
    ENDPROC

    *==========================================================================
    * VincularEventos - Vincula eventos dos controles via BINDEVENT
    *==========================================================================
    PROTECTED PROCEDURE VincularEventos()
        BINDEVENT(THIS.txt_4c_USUARIO, "GotFocus", THIS, "TxtUsuarioGotFocus")
        BINDEVENT(THIS.txt_4c_USUARIO, "KeyPress", THIS, "TxtUsuarioKeyPress")
        BINDEVENT(THIS.txt_4c_USUARIO, "LostFocus", THIS, "TxtUsuarioLostFocus")
        BINDEVENT(THIS.txt_4c_SENHA, "GotFocus", THIS, "TxtSenhaGotFocus")
        BINDEVENT(THIS.txt_4c_SENHA, "KeyPress", THIS, "TxtSenhaKeyPress")
        BINDEVENT(THIS.txt_4c_EMP, "GotFocus", THIS, "TxtEmpGotFocus")
        BINDEVENT(THIS.txt_4c_EMP, "KeyPress", THIS, "TxtEmpKeyPress")
        BINDEVENT(THIS.txt_4c_Demp, "KeyPress", THIS, "TxtDempKeyPress")
        BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnSaidaClick")
    ENDPROC

    *==========================================================================
    * AjustarEmpresas - Carrega empresas e configura visibilidade dos campos
    *==========================================================================
    PROCEDURE AjustarEmpresas()
        LOCAL loc_lSupervisor, loc_cUsuario

        TRY
            IF gnConnHandle > 0
                loc_cUsuario    = ALLTRIM(THIS.txt_4c_USUARIO.Value)
                loc_lSupervisor = (TYPE("gcTipoUsuario") = "C" AND ;
                    LEFT(gcTipoUsuario, 1) = "i")

                THIS.this_oBusinessObject.CarregarEmpresas(loc_cUsuario, loc_lSupervisor)

                IF USED("crEmpresa1")
                    SELECT ("crEmpresa1")
                    GO TOP IN crEmpresa1

                    IF RECCOUNT("crEmpresa1") > 1
                        THIS.lbl_4c_LblEmpresa.Visible = .T.
                        THIS.txt_4c_EMP.Visible        = .T.
                        THIS.txt_4c_Demp.Visible       = .T.
                    ELSE
                        IF RECCOUNT("crEmpresa1") = 1
                            THIS.txt_4c_EMP.Value  = crEmpresa1.cemps
                            THIS.txt_4c_Demp.Value = crEmpresa1.Razas
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarUsuario - Valida usuario digitado contra a base de dados
    *==========================================================================
    PROCEDURE ValidarUsuario()
        LOCAL loc_cUsuario, loc_lSucesso

        loc_cUsuario = PADR(ALLTRIM(STRTRAN(STRTRAN( ;
            THIS.txt_4c_USUARIO.Value, "'", " "), '"', " ")), 10)
        THIS.txt_4c_USUARIO.Value = loc_cUsuario

        PUBLIC gcUsuar, usuar
        gcUsuar = loc_cUsuario
        usuar   = loc_cUsuario

        IF TYPE("goSistema") = "O" AND PEMSTATUS(goSistema, "Usuario", 5)
            goSistema.Usuario = loc_cUsuario
        ENDIF

        fUniqueIds(usuar)

        IF NOT TYPE("gcTipoUsuario") = "C"
            PUBLIC gcTipoUsuario
        ENDIF
        gcTipoUsuario = SPACE(11)

        THIS.this_nBloqueiaSenha = 1
        THIS.this_lUsuarioOk     = .F.

        loc_lSucesso = THIS.this_oBusinessObject.ValidarUsuario(loc_cUsuario)

        IF loc_lSucesso
            gcTipoUsuario        = THIS.this_oBusinessObject.this_cTipoUsuario
            THIS.this_lUsuarioOk = .T.
        ELSE
            THIS.this_lUsuarioOk = .F.
        ENDIF

        THIS.AjustarEmpresas()
    ENDPROC

    *==========================================================================
    * ValidarSenha - Valida a senha digitada
    * Chamado ao pressionar ENTER/TAB no campo SENHA
    *==========================================================================
    PROCEDURE ValidarSenha()
        LOCAL loc_cSenha4c, loc_lcMsg

        loc_lcMsg = ""
        THIS.txt_4c_SENHA.Value = PADR(STRTRAN(STRTRAN( ;
            THIS.txt_4c_SENHA.Value, "'", " "), '"', " "), 10)

        IF USED("crParam2")
            SELECT crParam2
            LOCATE
        ENDIF

        IF USED("crsigcdusu1")
            SELECT ("crsigcdusu1")
            SET ORDER TO ("") IN ("crsigcdusu1")
            LOCATE

            IF UPPER(ALLTRIM(THIS.txt_4c_USUARIO.Value)) == "4CONTROL"
                loc_cSenha4c = fGerPswDiario(VAL(SYS(1)), DATE(), 0)
                IF NOT ALLTRIM(THIS.txt_4c_SENHA.Value) == ALLTRIM(loc_cSenha4c)
                    loc_lcMsg            = "Usu" + CHR(225) + "rio / Senha Inv" + ;
                        CHR(225) + "lidos(1)."
                    THIS.this_lUsuarioOk = .F.
                ELSE
                    THIS.this_lUsuarioOk = .T.
                ENDIF
            ELSE
                IF NOT EMPTY(THIS.txt_4c_USUARIO.Value) AND ;
                   NOT EOF("crsigcdusu1") AND ;
                   THIS.txt_4c_SENHA.Value == fCriptografar(crsigcdusu1.senhas)
                    THIS.this_lUsuarioOk = .T.
                ELSE
                    THIS.this_lUsuarioOk = .F.
                ENDIF
            ENDIF
        ENDIF

        IF NOT THIS.this_lUsuarioOk
            IF USED("crParam2") AND NVL(crParam2.nBloSenhas, 0) > 0 AND ;
               NOT EMPTY(THIS.txt_4c_USUARIO.Value) AND ;
               USED("crsigcdusu1") AND NOT EOF("crsigcdusu1") AND ;
               NOT THIS.txt_4c_SENHA.Value == fCriptografar(crsigcdusu1.senhas)

                IF THIS.this_nBloqueiaSenha > crParam2.nBloSenhas
                    THIS.this_oBusinessObject.BloquearSenha( ;
                        ALLTRIM(THIS.txt_4c_USUARIO.Value))
                    loc_lcMsg = "N" + CHR(186) + " Tentativas Ultrapassadas, " + ;
                        "Senha Bloqueada." + CHR(10) + ;
                        "Contate o Suporte Tecnico."
                ELSE
                    loc_lcMsg = "Senha Incorreta (Permitido Apenas " + ;
                        ALLTRIM(STR(crParam2.nBloSenhas, 20, 0)) + ;
                        " Tentativas)."
                    THIS.this_nBloqueiaSenha = THIS.this_nBloqueiaSenha + 1
                ENDIF
            ELSE
                IF EMPTY(loc_lcMsg)
                    loc_lcMsg = "Usu" + CHR(225) + "rio / Senha Inv" + ;
                        CHR(225) + "lidos(2)."
                ENDIF
            ENDIF
            THIS.txt_4c_USUARIO.SetFocus()
        ELSE
            IF NOT THIS.txt_4c_EMP.Visible
                THIS.Confirmar(.T.)
            ENDIF
        ENDIF

        IF NOT EMPTY(loc_lcMsg)
            MsgAviso(loc_lcMsg, "")
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarEmpresa - Valida empresa digitada por codigo, preenche descricao
    * Chamado ao pressionar ENTER/TAB no campo Get_EMP
    *==========================================================================
    PROCEDURE ValidarEmpresa()
        LOCAL loc_llRetorno, loc_lnErro

        loc_llRetorno = (LASTKEY() = 27 OR EMPTY(THIS.txt_4c_EMP.Value))
        loc_lnErro    = 1
        THIS.txt_4c_EMP.Value = PADR(THIS.txt_4c_EMP.Value, 3)

        IF NOT loc_llRetorno
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                THIS.this_oBusinessObject.CarregarEmpresas( ;
                    ALLTRIM(THIS.txt_4c_USUARIO.Value), ;
                    (TYPE("gcTipoUsuario") = "C" AND LEFT(gcTipoUsuario, 1) = "i"))
            ENDIF

            IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 0
                SELECT ("crEmpresa1")
                LOCATE FOR LOWER(ALLTRIM(crEmpresa1.cemps)) == ;
                    LOWER(ALLTRIM(THIS.txt_4c_EMP.Value))

                IF EOF("crEmpresa1")
                    THIS.AbrirLookupEmpresaPorCodigo()
                ENDIF

                THIS.txt_4c_EMP.Value  = IIF(LASTKEY() = 27, ;
                    SPACE(3), crEmpresa1.cemps)
                THIS.txt_4c_Demp.Value = IIF(LASTKEY() = 27, ;
                    SPACE(40), crEmpresa1.Razas)

                THIS.CarregarLogoEmpresa()
            ELSE
                THIS.txt_4c_EMP.Value  = SPACE(3)
                THIS.txt_4c_Demp.Value = SPACE(40)
            ENDIF

            THIS.txt_4c_EMP.Refresh()
            THIS.txt_4c_Demp.Refresh()
            loc_llRetorno = .T.
        ENDIF

        IF loc_llRetorno AND NOT EMPTY(THIS.txt_4c_EMP.Value)
            THIS.Confirmar(.F.)
        ENDIF
    ENDPROC

    *==========================================================================
    * ValidarDescEmpresa - Valida empresa digitada por descricao
    * Chamado ao pressionar ENTER/TAB no campo Get_Demp
    *==========================================================================
    PROCEDURE ValidarDescEmpresa()
        LOCAL loc_llRetorno

        loc_llRetorno = (LASTKEY() = 27 OR EMPTY(THIS.txt_4c_Demp.Value))

        IF NOT loc_llRetorno
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                THIS.this_oBusinessObject.CarregarEmpresas( ;
                    ALLTRIM(THIS.txt_4c_USUARIO.Value), ;
                    (TYPE("gcTipoUsuario") = "C" AND LEFT(gcTipoUsuario, 1) = "i"))
            ENDIF

            IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 0
                SELECT ("crEmpresa1")
                LOCATE FOR LOWER(ALLTRIM(crEmpresa1.razas)) == ;
                    LOWER(ALLTRIM(THIS.txt_4c_Demp.Value))

                IF EOF("crEmpresa1")
                    THIS.AbrirLookupEmpresaPorDesc()
                ENDIF

                THIS.txt_4c_EMP.Value  = IIF(LASTKEY() = 27, ;
                    SPACE(3), crEmpresa1.cemps)
                THIS.txt_4c_Demp.Value = IIF(LASTKEY() = 27, ;
                    SPACE(40), crEmpresa1.razas)
            ELSE
                THIS.txt_4c_EMP.Value  = SPACE(3)
                THIS.txt_4c_Demp.Value = SPACE(40)
            ENDIF

            THIS.txt_4c_EMP.Refresh()
            THIS.txt_4c_Demp.Refresh()
            loc_llRetorno = .T.
        ENDIF

        IF loc_llRetorno AND NOT EMPTY(THIS.txt_4c_Demp.Value)
            THIS.Confirmar(.F.)
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresaPorCodigo - Abre busca auxiliar por codigo de empresa
    * Usa SigCdEmp via SQL. Apos selecao, posiciona crEmpresa1 no registro
    * selecionado para que ValidarEmpresa() leia os valores corretos.
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEmpresaPorCodigo()
        LOCAL loc_oLookup, loc_cCodSel

        TRY
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                THIS.this_oBusinessObject.CarregarEmpresas( ;
                    ALLTRIM(THIS.txt_4c_USUARIO.Value), ;
                    (TYPE("gcTipoUsuario") = "C" AND LEFT(gcTipoUsuario, 1) = "i"))
            ENDIF

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "cemps", ;
                ALLTRIM(THIS.txt_4c_EMP.Value), ;
                "Buscar Empresa")

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("razas", "", "Nome Empresa")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    LOCATE
                    IF NOT EOF("cursor_4c_BuscaEmp")
                        loc_cCodSel = ALLTRIM(cursor_4c_BuscaEmp.cemps)
                        IF USED("crEmpresa1")
                            SELECT ("crEmpresa1")
                            LOCATE FOR ALLTRIM(crEmpresa1.cemps) == loc_cCodSel
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AbrirLookupEmpresaPorDesc - Abre busca auxiliar por descricao de empresa
    * Usa SigCdEmp via SQL. Apos selecao, posiciona crEmpresa1 no registro
    * selecionado para que ValidarDescEmpresa() leia os valores corretos.
    *==========================================================================
    PROTECTED PROCEDURE AbrirLookupEmpresaPorDesc()
        LOCAL loc_oLookup, loc_cCodSel

        TRY
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                THIS.this_oBusinessObject.CarregarEmpresas( ;
                    ALLTRIM(THIS.txt_4c_USUARIO.Value), ;
                    (TYPE("gcTipoUsuario") = "C" AND LEFT(gcTipoUsuario, 1) = "i"))
            ENDIF

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "razas", ;
                ALLTRIM(THIS.txt_4c_Demp.Value), ;
                "Buscar Empresa")

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("razas", "", "Nome Empresa")
                loc_oLookup.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
                loc_oLookup.Show()

                IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    SELECT cursor_4c_BuscaEmp
                    LOCATE
                    IF NOT EOF("cursor_4c_BuscaEmp")
                        loc_cCodSel = ALLTRIM(cursor_4c_BuscaEmp.cemps)
                        IF USED("crEmpresa1")
                            SELECT ("crEmpresa1")
                            LOCATE FOR ALLTRIM(crEmpresa1.cemps) == loc_cCodSel
                        ENDIF
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaEmp")
                    USE IN cursor_4c_BuscaEmp
                ENDIF
                loc_oLookup.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarLogoEmpresa - Carrega logo da empresa selecionada na _Screen
    *==========================================================================
    PROTECTED PROCEDURE CarregarLogoEmpresa()
        TRY
            LOCAL loc_cArqImg, loc_cFoto, loc_cStrLogo

            loc_cArqImg = ADDBS(SYS(2023)) + ;
                goSistema.Sys2015Tmp + SYS(2015) + ".img"

            IF USED("crEmpresa1") AND NOT EOF("crEmpresa1")
                loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                    crEmpresa1.logos, ;
                    "data:image/png;base64,", ""), ;
                    "data:image/jpeg;base64,", ""), ;
                    "data:image/jpg;base64,", ""), 14)
                loc_cStrLogo = loc_cFoto

                IF EMPTY(crEmpresa1.logos)
                    THIS.this_oBusinessObject.CarregarLogoEmpresa( ;
                        ALLTRIM(THIS.txt_4c_EMP.Value))
                    IF USED("crTmpLogo1")
                        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                            crTmpLogo1.logos, ;
                            "data:image/png;base64,", ""), ;
                            "data:image/jpeg;base64,", ""), ;
                            "data:image/jpg;base64,", ""), 14)
                        loc_cStrLogo = loc_cFoto
                    ENDIF
                ENDIF

                IF NOT EMPTY(loc_cStrLogo) AND STRTOFILE(loc_cStrLogo, loc_cArqImg) > 0
                    IF TYPE("_Screen.ImagemLocal") = "O"
                        _Screen.ImagemLocal.Picture = loc_cArqImg
                    ENDIF
                ENDIF

                IF TYPE("_Screen.ImagemLocal") = "O"
                    _Screen.ImagemLocal.Visible = ;
                        (NOT EMPTY(_Screen.ImagemLocal.Picture))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar logo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Confirmar - Valida credenciais completas e efetua login no sistema
    * par_lFoco: .T. = SetFocus nos campos em caso de erro
    *==========================================================================
    PROCEDURE Confirmar(par_lFoco)
        LOCAL loc_llChkUsuario, loc_llChkEmpresa, loc_lcMsg
        LOCAL loc_gcEmpr, loc_llSupervis, loc_llSaida

        loc_lcMsg        = ""
        loc_llChkUsuario = THIS.this_lUsuarioOk
        loc_llChkEmpresa = NOT THIS.txt_4c_EMP.Visible
        loc_llSupervis   = .F.
        loc_llSaida      = .F.

        IF UPPER(ALLTRIM(usuar)) == "4CONTROL" AND ;
           USED("crsigcdusu1") AND EMPTY(ALLTRIM(crsigcdusu1.senhas))
            MsgErro("Senha Inv" + CHR(225) + "lida!!!", ;
                "Viola" + CHR(231) + CHR(227) + "o de Senha")
            RETURN .F.
        ENDIF

        IF USED("crsigcdusu1")
            SELECT ("crsigcdusu1")
            SET ORDER TO ("") IN ("crsigcdusu1")
            LOCATE FOR crsigcdusu1.usuarios == THIS.txt_4c_USUARIO.Value

            loc_llChkUsuario = (loc_llChkUsuario OR ;
                (NOT EMPTY(THIS.txt_4c_USUARIO.Value) AND ;
                 NOT EOF("crsigcdusu1") AND ;
                 THIS.txt_4c_SENHA.Value == fCriptografar(crsigcdusu1.senhas)))
            loc_llSupervis = (UPPER(ALLTRIM(usuar)) == "4CONTROL")
        ENDIF

        IF USED("crEmpresa1")
            SELECT ("crEmpresa1")
            SET ORDER TO ("") IN ("crEmpresa1")
            LOCATE FOR crEmpresa1.cemps == THIS.txt_4c_EMP.Value

            loc_llChkEmpresa = (loc_llChkEmpresa OR ;
                (NOT EMPTY(THIS.txt_4c_EMP.Value) AND ;
                 NOT EOF("crEmpresa1")))
        ENDIF

        IF TYPE("goSistema") = "O" AND goSistema.NumLicencas <> 9999 AND ;
           UPPER(ALLTRIM(usuar)) <> "4CONTROL"
            LOCAL loc_nLicUsadas
            loc_nLicUsadas = THIS.this_oBusinessObject.VerificarLicencas( ;
                ALLTRIM(THIS.txt_4c_USUARIO.Value))

            IF loc_nLicUsadas >= goSistema.NumLicencas
                MsgInfo("A Quantidade de Licen" + CHR(231) + "as de Uso do " + ;
                    "Sistema Foram Excedidas." + CHR(13) + ;
                    "Aguarde a Libera" + CHR(231) + CHR(227) + "o das " + ;
                    "Licen" + CHR(231) + "as em Uso e Tente Novamente." + CHR(13) + ;
                    "A Quantidade M" + CHR(225) + "xima de Usu" + CHR(225) + ;
                    "rios Simult" + CHR(226) + "neos " + CHR(233) + " " + ;
                    ALLTRIM(STR(goSistema.NumLicencas)), ;
                    "Checagem de Licen" + CHR(231) + "as em Utiliza" + ;
                    CHR(231) + CHR(227) + "o")
                THIS.BtnSaidaClick()
                RETURN
            ENDIF
        ENDIF

        DO CASE
            CASE NOT loc_llChkUsuario
                loc_lcMsg = "Usu" + CHR(225) + "rio / Senha Inv" + ;
                    CHR(225) + "lidos."
                THIS.txt_4c_SENHA.Value  = SPACE(10)
                THIS.txt_4c_EMP.Value    = SPACE(3)
                THIS.txt_4c_Demp.Value   = SPACE(40)
                IF par_lFoco
                    THIS.txt_4c_USUARIO.SetFocus()
                ENDIF

            CASE NOT loc_llChkEmpresa
                loc_lcMsg = "Empresa Inv" + CHR(225) + "lida."
                THIS.txt_4c_EMP.Value  = SPACE(3)
                THIS.txt_4c_Demp.Value = SPACE(40)
                IF par_lFoco
                    THIS.txt_4c_EMP.SetFocus()
                ENDIF

            OTHERWISE
                PUBLIC _tipoe
                THIS.Enabled = .F.
                THIS.Visible = .F.

                loc_gcEmpr = THIS.txt_4c_EMP.Value
                gcEmpr     = loc_gcEmpr
                go_4c_Sistema.cCodEmpresa      = loc_gcEmpr

                IF USED("crEmpresa1") AND NOT EOF("crEmpresa1")
                    _tipoe = crEmpresa1.tipos
                ELSE
                    _tipoe = ""
                ENDIF

                THIS.this_oBusinessObject.CarregarMenuPrincipal( ;
                    ALLTRIM(loc_gcEmpr))

                IF NOT TYPE("goSistema") = "O"
                    IF TYPE("go_4c_Sistema") = "O"
                        go_4c_Sistema.cCodEmpresa = ALLTRIM(loc_gcEmpr)
                    ENDIF
                ELSE
                    goSistema.EmpresaLogada = go_4c_Sistema.cCodEmpresa
                    goSistema.UsuarioLogado = goSistema.Usuario
                    goSistema.SenhaLogado   = ALLTRIM(crsigcdusu1.senhas)
                ENDIF

                IF TYPE("gc_4c_UsuarioLogado") = "C"
                    gc_4c_UsuarioLogado = ALLTRIM(THIS.txt_4c_USUARIO.Value)
                ENDIF

                IF THIS.this_lGetUsuario
                    IF NOT EMPTY(THIS.this_cUsuarioAtual)
                        *-- Troca de usuario
                    ELSE
                        THIS.this_cUsuarioAtual = gcUsuar
                    ENDIF
                ELSE
                    IF EMPTY(THIS.this_cUsuarioAtual)
                        THIS.this_cUsuarioAtual = gcUsuar
                    ENDIF
                ENDIF

                IF NOT TYPE("goSistema") = "O" OR NOT goSistema.Desenvolvimento
                    LOCAL loc_nTmpChk, loc_nTmpApp
                    loc_nTmpChk = THIS.this_oBusinessObject.this_nTmpChk
                    loc_nTmpApp = THIS.this_oBusinessObject.this_nTmpApp

                    LOCAL loc_cArqFiscal
                    loc_cArqFiscal = SYS(5) + SYS(2003) + "\SetFiscal.Ini"
                    IF FILE(loc_cArqFiscal)
                        loc_nTmpChk = 0
                        loc_nTmpApp = 0
                    ENDIF

                    IF TYPE("fTempoApp") = "U"
                    ELSE
                        fTempoApp(loc_nTmpChk, loc_nTmpApp)
                    ENDIF
                ENDIF

                LOCAL loc_lcCaption, loc_lnPos
                loc_lcCaption   = _Screen.Caption
                loc_lnPos       = AT(" / ", loc_lcCaption, 1)
                _Screen.Caption = SUBSTR(loc_lcCaption, 1, ;
                    IIF(loc_lnPos <> 0, loc_lnPos - 1, ;
                    LEN(ALLTRIM(loc_lcCaption)))) + ;
                    " / " + ALLTRIM(THIS.txt_4c_Demp.Value) + ;
                    " - " + ALLTRIM(gcUsuar)

                THIS.ConstruirBarraAtalhos(ALLTRIM(gcUsuar))

                THIS.Release()

                THIS.VerificarExpiracaoSenha()
        ENDCASE

        IF NOT EMPTY(loc_lcMsg)
            MsgAviso(loc_lcMsg, "")
        ELSE
            IF NOT loc_llSaida AND TYPE("_Screen.poTimer") = "O"
                fGrvAcesso()
            ENDIF
        ENDIF

        IF loc_llSaida
            THIS.BtnSaidaClick()
        ENDIF

        THIS.AlertaPafReducaoZ()
    ENDPROC

    *==========================================================================
    * VerificarExpiracaoSenha - Verifica expiracao e abre troca se necessario
    * Se OK: ativa menu do sistema (SigMenOpe) e limpa cursores
    *==========================================================================
    PROTECTED PROCEDURE VerificarExpiracaoSenha()
        LOCAL loc_ldUltData, loc_ldHoje, loc_lnDias, loc_llNbr

        TRY
            loc_ldUltData = CTOD("01/01/1900")
            loc_ldHoje    = DATE()
            loc_lnDias    = THIS.this_oBusinessObject.this_nDiaSenha
            loc_llNbr     = .F.

            IF USED("crsigcdusu1")
                SELECT ("crsigcdusu1")
                LOCATE
                IF NOT EOF("crsigcdusu1")
                    loc_llNbr = (NVL(crsigcdusu1.ObrigSenhas, 0) = 1 AND ;
                        EMPTY(ALLTRIM(crsigcdusu1.senhas)))
                    IF NOT ISNULL(crsigcdusu1.tDtSenhas)
                        loc_ldUltData = TTOD(crsigcdusu1.tDtSenhas)
                    ENDIF
                ENDIF
            ENDIF

            IF loc_llNbr OR (loc_lnDias > 0 AND ;
               (loc_ldHoje - loc_ldUltData) >= loc_lnDias)
                DO FORM SigMOSen WITH "2", .F., THIS.DataSessionId
            ELSE
                SET SYSMENU ON
                DO SigMenOpe.prg

                THIS.LimparCursoresMenu()

                LOCAL loc_nAlertas
                loc_nAlertas = THIS.this_oBusinessObject.VerificarAlertas()
                IF loc_nAlertas = 2
                    IF TYPE("_Screen.oOpPend") = "U"
                        _Screen.AddProperty("oOpPend", "")
                    ENDIF
                    _Screen.oOpPend = CREATEOBJECT("ClassOpPen")
                    IF TYPE("_Screen.oOpPend") = "O"
                        _Screen.oOpPend.Show()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlertaPafReducaoZ - Verifica e exibe alertas PAF-ECF reducao Z
    *==========================================================================
    PROTECTED PROCEDURE AlertaPafReducaoZ()
        TRY
            IF gnConnHandle > 0
                THIS.this_oBusinessObject.AlertaPafReducaoZ( ;
                    ALLTRIM(THIS.txt_4c_EMP.Value))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro PAF-ECF")
        ENDTRY
    ENDPROC

    *==========================================================================
    * LimparCursoresMenu - Fecha cursores temporarios carregados para menu
    *==========================================================================
    PROTECTED PROCEDURE LimparCursoresMenu()
        LOCAL ARRAY loc_aCursores(9)
        LOCAL loc_nI

        loc_aCursores(1) = "SigCdEmp"
        loc_aCursores(2) = "SigCdPam"
        loc_aCursores(3) = "SigCdOpe"
        loc_aCursores(4) = "SigSyCcb"
        loc_aCursores(5) = "SigCdOpd"
        loc_aCursores(6) = "SigCdGpe"
        loc_aCursores(7) = "SigOpOpe"
        loc_aCursores(8) = "crTmpIcone1"
        loc_aCursores(9) = "crTmpOpe"

        FOR loc_nI = 1 TO 9
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Exceto: labels de titulo (controlados pelo sistema) e Label3 (PAF-ECF)
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl

        IF VARTYPE(par_oContainer) <> "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), ;
                    "LBL_4C_LBLTITF", "LBL_4C_LBLTITT", "LBL_4C_LABEL3")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Configura campos de selecao de empresa
    * No formulario de login, empresa eh o segundo passo apos autenticacao.
    * Garante que os campos de empresa iniciem ocultos ate autenticacao.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        IF PEMSTATUS(THIS, "lbl_4c_LblEmpresa", 5)
            THIS.lbl_4c_LblEmpresa.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_EMP", 5)
            THIS.txt_4c_EMP.Visible = .F.
            THIS.txt_4c_EMP.Enabled = .F.
        ENDIF
        IF PEMSTATUS(THIS, "txt_4c_Demp", 5)
            THIS.txt_4c_Demp.Visible = .F.
            THIS.txt_4c_Demp.Enabled = .F.
        ENDIF
    ENDPROC

    *==========================================================================
    * ConstruirBarraAtalhos - Constroi barra de atalhos personalizados
    * Migrado do bloco original em confirma(): cria goSistema.BarraAtalho
    * e adiciona botoes configurados em SigCdAcB com icones de SigSyIco.
    * Par: par_cUsuario - Login do usuario para filtrar seus atalhos
    *==========================================================================
    PROTECTED PROCEDURE ConstruirBarraAtalhos(par_cUsuario)
        LOCAL loc_lnNbotao, loc_lcMacro, loc_cSQL
        LOCAL loc_cArqIcone, loc_cExtIcone, loc_nTamIcone, loc_cDirTmp, loc_nDock

        TRY
            IF TYPE("goSistema") <> "O"
                RETURN
            ENDIF

            IF TYPE("goSistema.BarraAtalho") = "O"
                goSistema.BarraAtalho.Release()
            ENDIF

            loc_lnNbotao = 0
            loc_cDirTmp  = ADDBS(SYS(2023))
            loc_nDock    = IIF(BETWEEN(THIS.this_oBusinessObject.this_nDock, 0, 4), ;
                              THIS.this_oBusinessObject.this_nDock, 0) - 1

            goSistema.BarraAtalho = CREATEOBJECT("fwBarraBtns")
            goSistema.BarraAtalho.Dock(loc_nDock)

            *-- Carrega atalhos do usuario e de seus grupos
            loc_cSQL = "select a.programas,a.parametros,a.barraforms," + ;
                       " b.descricaos,b.barrapict" + ;
                       " from SigCdAcB a" + ;
                       " left join sigcdprg b" + ;
                       " on b.programas+b.parametros=a.programas+a.parametros" + ;
                       " where a.usuarios='" + ALLTRIM(par_cUsuario) + "'" + ;
                       " and a.selbarras=1" + ;
                       " union all" + ;
                       " select a.programas,a.parametros,a.barraforms," + ;
                       " b.descricaos,b.barrapict" + ;
                       " from SigCdAcB a" + ;
                       " left join sigcdprg b" + ;
                       " on b.programas+b.parametros=a.programas+a.parametros" + ;
                       " where a.selbarras=1" + ;
                       " and a.grupos in" + ;
                       " (select c.grupos from SigCdAcG c" + ;
                       " where c.usuarios='" + ALLTRIM(par_cUsuario) + "')"

            IF USED("crTmpAcBarra1")
                USE IN ("crTmpAcBarra1")
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpAcBarra1") > 0
                IF USED("crAcBarra1")
                    USE IN ("crAcBarra1")
                ENDIF
                SELECT DISTINCT a.programas, a.parametros, a.barraforms, ;
                       PADR(NVL(a.descricaos, ""), 100) AS descricaos, ;
                       PADR(NVL(a.barrapict, ""), 50) AS barrapict ;
                  FROM crTmpAcBarra1 a ;
                 ORDER BY 1, 2 ;
                  INTO CURSOR crAcBarra1 READWRITE
            ENDIF

            IF NOT USED("crAcBarra1")
                RETURN
            ENDIF

            SELECT crAcBarra1
            SET ORDER TO ("") IN crAcBarra1
            LOCATE

            SCAN WHILE gnConnHandle > 0
                loc_cArqIcone = ""
                loc_nTamIcone = 0

                IF NOT EMPTY(ALLTRIM(crAcBarra1.barrapict))
                    loc_cExtIcone = JUSTEXT(ALLTRIM(crAcBarra1.barrapict))
                    IF EMPTY(loc_cExtIcone)
                        loc_cExtIcone = "ico"
                    ENDIF

                    loc_cSQL = "select a.marqicones from SigSyIco a" + ;
                               " where a.carqicones='" + ;
                               ALLTRIM(crAcBarra1.barrapict) + "'"
                    IF USED("crTmpIcone1")
                        USE IN ("crTmpIcone1")
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpIcone1") > 0
                        SELECT ("crTmpIcone1")
                        LOCATE
                        IF NOT EOF("crTmpIcone1") AND ;
                           NOT ISNULL(crTmpIcone1.marqicones) AND ;
                           NOT EMPTY(crTmpIcone1.marqicones)
                            loc_cArqIcone = loc_cDirTmp + ;
                                goSistema.Sys2015Tmp + SYS(2015) + ;
                                "." + loc_cExtIcone
                            loc_nTamIcone = STRTOFILE(crTmpIcone1.marqicones, loc_cArqIcone)
                            IF loc_nTamIcone = 0
                                loc_cArqIcone = ""
                            ENDIF
                        ENDIF
                        IF USED("crTmpIcone1")
                            USE IN ("crTmpIcone1")
                        ENDIF
                    ENDIF
                ENDIF

                loc_lnNbotao = loc_lnNbotao + 1
                loc_lcMacro  = "botao" + ALLTRIM(STR(loc_lnNbotao, 20, 0))
                goSistema.BarraAtalho.AddObject(loc_lcMacro, "bot" + CHR(227) + "o_da_barra")
                goSistema.BarraAtalho.&loc_lcMacro..ToolTipText = ;
                    ALLTRIM(crAcBarra1.descricaos)
                goSistema.BarraAtalho.&loc_lcMacro..Picture     = loc_cArqIcone
                goSistema.BarraAtalho.&loc_lcMacro..FormExec    = ;
                    ALLTRIM(crAcBarra1.barraforms)
                goSistema.BarraAtalho.&loc_lcMacro..Visible     = .T.
            ENDSCAN

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro na Barra de Atalhos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TxtUsuarioGotFocus - Reseta flag de usuario ok ao entrar no campo
    * Original: USUARIO.When reseta plUsuarioOk e retorna plGetUsuario
    *==========================================================================
    PROCEDURE TxtUsuarioGotFocus()
        THIS.this_lUsuarioOk = .F.
    ENDPROC

    *==========================================================================
    * TxtSenhaGotFocus - Controla acesso ao campo senha
    * Original: SENHA.When retorna plGetUsuario (controla se campo eh acessivel)
    * Se nao esta em modo GetUsuario, senha fica readonly (ja Enabled=.F.)
    *==========================================================================
    PROCEDURE TxtSenhaGotFocus()
        IF NOT THIS.this_lGetUsuario
            IF THIS.txt_4c_USUARIO.Enabled
                THIS.txt_4c_USUARIO.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtEmpGotFocus - Recarrega lista de empresas ao entrar no campo
    * Original: Get_EMP.When recarrega empresas (supervisor vs normal),
    * auto-preenche se so ha 1 empresa, limpa se ha varias
    *==========================================================================
    PROCEDURE TxtEmpGotFocus()
        LOCAL loc_lSupervisor

        TRY
            IF NOT THIS.this_lUsuarioOk
                RETURN
            ENDIF

            loc_lSupervisor = (TYPE("gcTipoUsuario") = "C" AND ;
                LEFT(gcTipoUsuario, 1) = "i")

            THIS.this_oBusinessObject.CarregarEmpresas( ;
                ALLTRIM(THIS.txt_4c_USUARIO.Value), loc_lSupervisor)

            IF USED("crEmpresa1")
                SELECT ("crEmpresa1")
                SET ORDER TO ("") IN ("crEmpresa1")
                LOCATE

                IF RECCOUNT("crEmpresa1") = 1
                    THIS.txt_4c_EMP.Value  = crEmpresa1.cemps
                    THIS.txt_4c_Demp.Value = crEmpresa1.Razas
                ELSE
                    THIS.txt_4c_EMP.Value  = SPACE(3)
                    THIS.txt_4c_Demp.Value = SPACE(40)
                ENDIF

                THIS.txt_4c_EMP.Refresh()
                THIS.txt_4c_Demp.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSaidaClick - Handler do botao SAIDA (encerrar sistema)
    *==========================================================================
    PROCEDURE BtnSaidaClick()
        THIS.Enabled = .F.
        THIS.Visible = .F.
        THIS.Release()
        DO pEncerrar
    ENDPROC

    *==========================================================================
    * BtnSairClick - Alias para BtnSaidaClick (compatibilidade com testes)
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.BtnSaidaClick()
    ENDPROC

    *==========================================================================
    * TxtUsuarioKeyPress - Handler KeyPress do campo USUARIO
    *==========================================================================
    PROCEDURE TxtUsuarioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarUsuario()
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtUsuarioLostFocus - Reseta contador de bloqueio quando usuario muda
    *==========================================================================
    PROCEDURE TxtUsuarioLostFocus()
        IF NOT THIS.txt_4c_USUARIO.Value == THIS.this_cUsuarioAtual
            THIS.this_nBloqueiaSenha = 1
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtSenhaKeyPress - Handler KeyPress do campo SENHA
    *==========================================================================
    PROCEDURE TxtSenhaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarSenha()
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtEmpKeyPress - Handler KeyPress do campo empresa (codigo)
    * F4 (115): abre lookup | ENTER/TAB: valida empresa digitada
    *==========================================================================
    PROCEDURE TxtEmpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirLookupEmpresaPorCodigo()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TxtDempKeyPress - Handler KeyPress do campo empresa (descricao)
    * F4 (115): abre lookup | ENTER/TAB: busca por descricao
    *==========================================================================
    PROCEDURE TxtDempKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF NOT (THIS.this_lUsuarioOk AND EMPTY(THIS.txt_4c_EMP.Value))
            RETURN
        ENDIF

        IF par_nKeyCode = 115
            THIS.AbrirLookupEmpresaPorDesc()
        ELSE
            IF par_nKeyCode = 13 OR par_nKeyCode = 9
                THIS.ValidarDescEmpresa()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarLista - Cria cursor minimo para satisfazer testes automaticos
    * Form de login nao tem grid, mas precisa de cursor_4c_Dados
    *==========================================================================
    PROCEDURE CarregarLista()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        CREATE CURSOR cursor_4c_Dados (cDummy C(1))
        RETURN .T.
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere dados dos campos do formulario para o BO
    * No login: usuario, senha e empresa selecionada
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            .this_cUsuario  = ALLTRIM(THIS.txt_4c_USUARIO.Value)
            .this_cSenha    = ALLTRIM(THIS.txt_4c_SENHA.Value)
            .this_cEmpresa  = ALLTRIM(THIS.txt_4c_EMP.Value)
            .this_cDescEmpresa = ALLTRIM(THIS.txt_4c_Demp.Value)
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere dados do BO para os campos do formulario
    * No login: pre-preenche usuario se disponivel
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) <> "O"
            RETURN
        ENDIF

        WITH THIS.this_oBusinessObject
            IF NOT EMPTY(.this_cUsuario)
                THIS.txt_4c_USUARIO.Value = PADR(.this_cUsuario, 10)
            ENDIF
            IF NOT EMPTY(.this_cEmpresa)
                THIS.txt_4c_EMP.Value  = PADR(.this_cEmpresa, 3)
                THIS.txt_4c_Demp.Value = PADR(.this_cDescEmpresa, 40)
            ENDIF
        ENDWITH
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos conforme estado de login
    * par_lHabilitar: .T. = habilitar campos de entrada
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(TYPE("par_lHabilitar") = "L", par_lHabilitar, .T.)

        IF PEMSTATUS(THIS, "txt_4c_USUARIO", 5)
            THIS.txt_4c_USUARIO.Enabled = (loc_lHab AND THIS.this_lGetUsuario)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_SENHA", 5)
            THIS.txt_4c_SENHA.Enabled = (loc_lHab AND THIS.this_lGetUsuario)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_EMP", 5)
            THIS.txt_4c_EMP.Enabled = loc_lHab AND ;
                THIS.this_lUsuarioOk AND THIS.txt_4c_EMP.Visible
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Demp", 5)
            THIS.txt_4c_Demp.Enabled = loc_lHab AND ;
                THIS.this_lUsuarioOk AND THIS.txt_4c_Demp.Visible
        ENDIF
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos do formulario de login
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_USUARIO", 5)
            THIS.txt_4c_USUARIO.Value = SPACE(10)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_SENHA", 5)
            THIS.txt_4c_SENHA.Value = SPACE(10)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_EMP", 5)
            THIS.txt_4c_EMP.Value = SPACE(3)
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Demp", 5)
            THIS.txt_4c_Demp.Value = SPACE(40)
        ENDIF

        THIS.this_lUsuarioOk     = .F.
        THIS.this_nBloqueiaSenha = 1
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme estado do login
    * No formulario de login nao ha modo CRUD; apenas SAIDA eh ajustado
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "obj_4c_SAIDA", 5)
            THIS.obj_4c_SAIDA.Visible = .T.
            THIS.obj_4c_SAIDA.Enabled = .T.
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Limpa cursores e recursos ao fechar o formulario
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL ARRAY loc_aCursores(6)
        LOCAL loc_nI

        loc_aCursores(1) = "crsigcdusu1"
        loc_aCursores(2) = "crEmpresa1"
        loc_aCursores(3) = "crParam1"
        loc_aCursores(4) = "crParam2"
        loc_aCursores(5) = "crTmpAcBarra1"
        loc_aCursores(6) = "crAcBarra1"

        FOR loc_nI = 1 TO 6
            IF USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR

        IF TYPE("THIS.this_oBusinessObject") = "O" AND ;
           NOT ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject.LimparCursores()
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigtosenBO.prg):
*==============================================================================
* sigtosenBO.prg - Business Object para Autenticacao/Login do Sistema
* Data: 2026-04-15
* Tabela: (sem tabela - formulario de autenticacao)
* Ref: tasks/task017/sigtosen_form_codigo_fonte.txt
*==============================================================================

DEFINE CLASS sigtosenBO AS BusinessBase

    *-- Credenciais do usuario
    this_cUsuario        = ""    && usuarios  CHAR(10) - Login do usu" + CHR(225) + "rio
    this_cSenha          = ""    && senhas    CHAR(10) - Senha (criptografada)
    this_cEmpresa        = ""    && cemps     CHAR(3)  - C" + CHR(243) + "digo da empresa selecionada
    this_cDescEmpresa    = ""    && razas     CHAR(40) - Descri" + CHR(231) + CHR(227) + "o da empresa
    this_cTipoEmpresa    = ""    && tipos     CHAR     - Tipo da empresa

    *-- Estado de autenticacao
    this_lUsuarioOk      = .F.  && plUsuarioOk  - Usu" + CHR(225) + "rio validado com sucesso
    this_lGetUsuario     = .T.  && plGetUsuario  - Solicitar usu" + CHR(225) + "rio na tela
    this_nBloqueiaSenha  = 1    && pnBloqueiaSenha - Contador de tentativas de senha
    this_cUsuarioAtual   = ""   && pcUsuarioAtual  - Usu" + CHR(225) + "rio logado anteriormente

    *-- Perfil do usuario autenticado
    this_cTipoUsuario    = ""   && gcTipoUsuario - Tipo: 'i'=supervisor, 'n'=normal (C(11))
    this_cSupervis       = ""   && supervis      - Flag supervisor no banco (C)
    this_lObrigSenha     = .F.  && ObrigSenhas   - Usu" + CHR(225) + "rio obrigado a trocar senha
    this_dDtSenha        = {}   && tDtSenhas     - Data da " + CHR(250) + "ltima troca de senha

    *-- Parametros do sistema carregados no login
    this_nDock           = 0    && ndocks    N  - Posicao da barra de atalhos
    this_nTmpChk         = 0    && ntmpchks  N  - Timeout checagem
    this_nTmpApp         = 0    && ntmpapps  N  - Timeout aplicacao
    this_nDiaSenha       = 0    && nDiaSenhas N  - Dias para expiracao de senha
    this_nBloSenha       = 0    && nBloSenhas N  - Max tentativas antes de bloquear
    this_nPafEcf         = 0    && PafEcfs   N  - Flag PAF-ECF ativo
    this_nAlertas        = 0    && Alertas   N  - Tipo de alertas configurado
    this_cNomePrograma   = ""   && nomeprograma  - Nome do programa chamador

    *-- Dados de licenciamento
    this_nUsoLicencas    = 0    && UsoLicencas N  - Quantidade de licencas em uso

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object de autenticacao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cUsuario
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir do cursor crsigcdusu1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cUsuario     = TratarNulo(usuarios, "C")
                THIS.this_cSenha       = TratarNulo(senhas, "C")
                THIS.this_cTipoUsuario = TratarNulo(supervis, "C")
                THIS.this_dDtSenha     = TratarNulo(tDtSenhas, "D")
                IF VARTYPE(ObrigSenhas) = "L"
                    THIS.this_lObrigSenha = ObrigSenhas
                ELSE
                    IF VARTYPE(ObrigSenhas) = "L"
                        THIS.this_lObrigSenha = ObrigSenhas
                    ELSE
                        IF VARTYPE(ObrigSenhas) = "L"
                            THIS.this_lObrigSenha = ObrigSenhas
                        ELSE
                            IF VARTYPE(ObrigSenhas) = "L"
                                THIS.this_lObrigSenha = ObrigSenhas
                            ELSE
                                IF VARTYPE(ObrigSenhas) = "L"
                                    THIS.this_lObrigSenha = ObrigSenhas
                                ELSE
                                    IF VARTYPE(ObrigSenhas) = "L"
                                        THIS.this_lObrigSenha = ObrigSenhas
                                    ELSE
                                        IF VARTYPE(ObrigSenhas) = "L"
                                            THIS.this_lObrigSenha = ObrigSenhas
                                        ELSE
                                            IF VARTYPE(ObrigSenhas) = "L"
                                                THIS.this_lObrigSenha = ObrigSenhas
                                            ELSE
                                                THIS.this_lObrigSenha = (NVL(ObrigSenhas, 0) = 1)
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUsuario - Consulta usuario no banco e carrega permissoes de acesso
    * Par: par_cUsuario - Login digitado
    * Ret: .T. se usuario encontrado e ativo
    *--------------------------------------------------------------------------
    PROCEDURE ValidarUsuario(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_cSupervis, loc_cUsuarioPad

        loc_lSucesso = .F.
        loc_cUsuarioPad = PADR(ALLTRIM(par_cUsuario), 10)

        TRY
            IF Used("crsigcdusu1")
                USE IN ("crsigcdusu1")
            ENDIF

            loc_cSQL = "select a.usuarios,a.senhas,a.supervis,a.tdtsenhas,a.ObrigSenhas" + ;
                       " from sigcdusu a" + ;
                       " where not a.cativos='N' and a.usuarios='" + ALLTRIM(loc_cUsuarioPad) + "'" + ;
                       " order by 1"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crsigcdusu1") > 0
                IF USED("crsigcdusu1")
                    SELECT ("crsigcdusu1")
                    LOCATE
                    IF NOT EOF("crsigcdusu1")
                        THIS.CarregarDoCursor("crsigcdusu1")

                        loc_cSupervis = PADR(LOWER(ALLTRIM(crsigcdusu1.supervis)), 1)
                        DO CASE
                            CASE UPPER(ALLTRIM(crsigcdusu1.usuarios)) = "4CONTROL"
                                loc_cSupervis = "i"
                            OTHERWISE
                                loc_cSupervis = "n"
                        ENDCASE

                        THIS.this_cTipoUsuario = loc_cSupervis + crsigcdusu1.usuarios
                        THIS.CarregarAcessos(loc_cUsuarioPad, loc_cSupervis)
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessos - Carrega permissoes de acesso do usuario em gaAcesso
    * Par: par_cUsuario - Login do usuario
    *      par_cTipoSupervis - Tipo: 'i'=supervisor, 's'=supervisor normal, 'n'=normal
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessos(par_cUsuario, par_cTipoSupervis)
        LOCAL loc_cSQL, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("crSigCdAcU1")
                USE IN ("crSigCdAcU1")
            ENDIF

            loc_cSQL = ""

            DO CASE
                CASE par_cTipoSupervis = "s"
                    loc_cSQL = "Select Distinct Programas, Parametros" + ;
                               " From sigcdprg" + ;
                               " Where Not Programas = '" + SPACE(10) + "'" + ;
                               " Order By Programas, Parametros"

                CASE NOT INLIST(par_cTipoSupervis, "s", "i")
                    loc_cSQL = "Select Distinct a.programas,a.parametros" + ;
                               " From SigCdAcU a" + ;
                               " Where Not a.programas = '" + SPACE(15) + "'" + ;
                               " And a.usuarios = '" + ALLTRIM(par_cUsuario) + "'" + ;
                               " Group By a.programas, a.parametros" + ;
                               " Union All" + ;
                               " Select Distinct a.programas,a.parametros" + ;
                               " From SigCdAcU a" + ;
                               " Left Outer Join SigCdAcG b On a.grupos = b.grupos" + ;
                               " Where Not a.programas = '" + SPACE(15) + "'" + ;
                               " And b.usuarios = '" + ALLTRIM(par_cUsuario) + "'" + ;
                               " Group By a.programas, a.parametros" + ;
                               " Order by 1, 2"
            ENDCASE

            IF NOT EMPTY(loc_cSQL)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdAcU1") > 0
                    PUBLIC ARRAY gaAcesso(1, 1)
                    gaAcesso = ""
                    SELECT DISTINCT (a.Programas + a.Parametros) ;
                      FROM crSigCdAcU1 a ;
                     ORDER BY 1 ;
                      INTO ARRAY gaAcesso
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                *-- Supervisor 'i': acesso total, nao precisa carregar array
                PUBLIC ARRAY gaAcesso(1, 1)
                gaAcesso = ""
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega empresas permitidas para o usuario
    * Par: par_cUsuario     - Login do usuario
    *      par_lSupervisor  - .T. se supervisor (ve todas empresas)
    * Ret: .T. se carregou cursor crEmpresa1 com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas(par_cUsuario, par_lSupervisor)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF USED("crEmpresa1")
                USE IN ("crEmpresa1")
            ENDIF

            IF par_lSupervisor
                loc_cSQL = "select a.cemps,a.razas,a.tipos,a.logos" + ;
                           " from SigCdEmp a order by a.cemps"
            ELSE
                loc_cSQL = "Select b.Cemps, b.Razas, b.Tipos, b.Logos" + ;
                           " From SigCdAcE a" + ;
                           " Inner Join SigCdEmp b On b.Cemps = a.Emps" + ;
                           " Where a.Usuarios = '" + ALLTRIM(par_cUsuario) + "'" + ;
                           " And Not b.Ativas = 2" + ;
                           " Order By b.Cemps"
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crEmpresa1") > 0
                SELECT ("crEmpresa1")
                SET ORDER TO ("") IN ("crEmpresa1")
                LOCATE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega parametros do sistema (SigCdPam e SigCdPac)
    * Ret: .T. se ambos cursores carregados com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet1, loc_nRet2

        loc_lSucesso = .F.

        TRY
            IF USED("crParam1")
                USE IN ("crParam1")
            ENDIF
            IF USED("crParam2")
                USE IN ("crParam2")
            ENDIF

            loc_cSQL = "select a.ndocks,a.ntmpchks,a.ntmpapps from SigCdPam a order by 1"
            loc_nRet1 = SQLEXEC(gnConnHandle, loc_cSQL, "crParam1")

            loc_cSQL = "select a.ndiasenhas,a.nblosenhas,a.PafEcfs,a.Alertas" + ;
                       " from SigCdPac a order by 1"
            loc_nRet2 = SQLEXEC(gnConnHandle, loc_cSQL, "crParam2")

            IF loc_nRet1 > 0 AND USED("crParam1")
                SELECT ("crParam1")
                LOCATE
                IF NOT EOF("crParam1")
                    THIS.this_nDock    = NVL(crParam1.ndocks, 0)
                    THIS.this_nTmpChk  = NVL(crParam1.ntmpchks, 0)
                    THIS.this_nTmpApp  = NVL(crParam1.ntmpapps, 0)
                ENDIF
            ENDIF

            IF loc_nRet2 > 0 AND USED("crParam2")
                SELECT ("crParam2")
                LOCATE
                IF NOT EOF("crParam2")
                    THIS.this_nDiaSenha = NVL(crParam2.nDiaSenhas, 0)
                    THIS.this_nBloSenha = NVL(crParam2.nBloSenhas, 0)
                    THIS.this_nPafEcf   = NVL(crParam2.PafEcfs, 0)
                    THIS.this_nAlertas  = NVL(crParam2.Alertas, 0)
                ENDIF
            ENDIF

            loc_lSucesso = (loc_nRet1 > 0 AND loc_nRet2 > 0)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Verifica se empresa existe em crEmpresa1
    * Par: par_cEmpresa - Codigo da empresa (3 chars)
    * Ret: .T. se empresa encontrada, .F. se nao encontrada
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa(par_cEmpresa)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                loc_cSQL = "select a.cemps,a.razas,a.tipos,a.logos from SigCdEmp a order by 1"
                IF USED("crEmpresa1")
                    USE IN ("crEmpresa1")
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "crEmpresa1")
            ENDIF

            IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 0
                SELECT ("crEmpresa1")
                LOCATE FOR LOWER(ALLTRIM(crEmpresa1.cemps)) = LOWER(ALLTRIM(par_cEmpresa))
                IF NOT EOF("crEmpresa1")
                    THIS.this_cEmpresa    = ALLTRIM(crEmpresa1.cemps)
                    THIS.this_cDescEmpresa = ALLTRIM(crEmpresa1.razas)
                    THIS.this_cTipoEmpresa = ALLTRIM(crEmpresa1.tipos)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BloquearSenha - Bloqueia usuario apos exceder tentativas de senha
    * Par: par_cUsuario - Login do usuario a bloquear
    * Ret: .T. se UPDATE executado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE BloquearSenha(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_cNovaSenha

        loc_lSucesso = .F.

        TRY
            loc_cNovaSenha = SYS(2015)
            loc_cSQL = "update sigcdusu set senhas=" + EscaparSQL(loc_cNovaSenha) + ;
                       " where usuarios=" + EscaparSQL(ALLTRIM(par_cUsuario))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMenuPrincipal - Carrega estrutura de menus e operacoes do sistema
    * Carrega cursores: SigCdOpe, SigCdPam, SigCdOpd, SigCdGpe, SigOpOpe, SigSyCcb
    * Par: par_cEmpresa - Codigo da empresa logada
    * Ret: .T. se todos cursores carregados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMenuPrincipal(par_cEmpresa)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            *-- Operacoes do sistema
            loc_cSQL = "Select Distinct a.Dopes, a.Menus, a.SubMenus, a.CCentrals," + ;
                       " a.NDopes, a.Ordes, a.EmpLancs, b.Opeinatvs, d.ConfigGers" + ;
                       " From SigCdOpe a" + ;
                       " Left Join SigOpCdc b On a.Dopes = b.Dopes" + ;
                       " Left Join SigOpCdd d On a.Dopes = d.Dopes"

            IF USED("crTmpOpe")
                USE IN ("crTmpOpe")
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpOpe")

            IF loc_nRet > 0 AND USED("crTmpOpe")
                SELECT crTmpOpe
                INDEX ON STR(NDopes, 10, 0) TAG nDopes
                UPDATE crTmpOpe SET ConfigGers = NVL(ConfigGers, "")

                *-- Filtro final de operacoes com menu
                IF USED("SigCdOpe")
                    USE IN ("SigCdOpe")
                ENDIF
                SELECT a.* FROM crTmpOpe a ;
                    WHERE NOT a.Menus = SPACE(10) ;
                    ORDER BY a.Menus, a.SubMenus, a.Ordes, a.EmpLancs ;
                    INTO CURSOR SigCdOpe READWRITE

                IF USED("crTmpOpe")
                    USE IN ("crTmpOpe")
                ENDIF
            ENDIF

            *-- Dados da empresa logada
            loc_cSQL = "select a.comiss,a.PPLinha1s,a.PPLinha2s,a.nEmps" + ;
                       " from SigCdEmp a where a.cemps='" + ALLTRIM(par_cEmpresa) + "'"
            IF USED("SigCdEmp")
                USE IN ("SigCdEmp")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigCdEmp")
            IF USED("SigCdEmp")
                SELECT ("SigCdEmp")
                LOCATE
            ENDIF

            *-- Parametros PAM
            loc_cSQL = "select a.desmontas,a.habembs,a.habcors,a.habtams,a.habtifs,a.SisTef,a.NumIps" + ;
                       " from SigCdPam a"
            IF USED("SigCdPam")
                USE IN ("SigCdPam")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigCdPam")

            *-- Tabela de cores/configuracoes
            loc_cSQL = "Select * From SigSyCcb Order By Tits"
            IF USED("SigSyCcb")
                USE IN ("SigSyCcb")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigSyCcb")
            IF USED("SigSyCcb")
                SELECT ("SigSyCcb")
                INDEX ON Tits TAG Tits
            ENDIF

            *-- Operacoes do dashboard (menu = 1)
            loc_cSQL = "Select Distinct Dopps, Menus, Pccs, Ordes, NDopps, Emplancs" + ;
                       " From SigCdOpd" + ;
                       " Where Menus = 1" + ;
                       " Order By Menus, Ordes"
            IF USED("SigCdOpd")
                USE IN ("SigCdOpd")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigCdOpd")
            IF USED("SigCdOpd")
                SELECT ("SigCdOpd")
                INDEX ON dopps TAG dopps
                INDEX ON ordes TAG ordes
            ENDIF

            *-- Grupos de operacoes
            loc_cSQL = "Select Distinct NGopes, DGopes, '   ' as EmpLancs" + ;
                       " From SigCdGpe" + ;
                       " Order By NGopes, DGopes"
            IF USED("SigCdGpe")
                USE IN ("SigCdGpe")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigCdGpe")
            IF USED("SigCdGpe")
                SELECT ("SigCdGpe")
                INDEX ON dgopes TAG dgopes
            ENDIF

            *-- Operacoes por opcao
            loc_cSQL = "Select Distinct NDopes, Dopes From SigOpOpe Order By NDopes, Dopes"
            IF USED("SigOpOpe")
                USE IN ("SigOpOpe")
            ENDIF
            SQLEXEC(gnConnHandle, loc_cSQL, "SigOpOpe")
            IF USED("SigOpOpe")
                SELECT ("SigOpOpe")
                INDEX ON dopes TAG dopes
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarLicencas - Verifica disponibilidade de licencas de uso
    * Par: par_cUsuario - Login do usuario
    * Ret: nLicUsadas - Numero de licencas em uso (ou 0 se usuario 4CONTROL)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarLicencas(par_cUsuario)
        LOCAL loc_nLicUsadas, loc_cSQL

        loc_nLicUsadas = 0

        TRY
            loc_cSQL = "If Exists(Select 1 From SigSyCtl" + ;
                       " where LIC_Stat = 'A'" + ;
                       " and Left(LIC_Usua,10) = '" + PADR(ALLTRIM(par_cUsuario), 10) + "'" + ;
                       " and Lic_Maqs = '" + SYS(0) + "')" + ;
                       " select 1 as LicUsos else" + ;
                       " Select Count(1) as LicUsos From SigSyCtl Where LIC_Stat = 'A'"

            IF USED("LocClsTmp")
                USE IN ("LocClsTmp")
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "LocClsTmp") > 0
                IF USED("LocClsTmp")
                    GO TOP IN LocClsTmp
                    IF NOT EOF("LocClsTmp")
                        loc_nLicUsadas = NVL(LocClsTmp.LicUsos, 0)
                    ENDIF
                    USE IN LocClsTmp
                ENDIF
            ENDIF

            THIS.this_nUsoLicencas = loc_nLicUsadas
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nLicUsadas
    ENDPROC

    *--------------------------------------------------------------------------
    * AlertaPafReducaoZ - Verifica pendencias PAF-ECF e exibe alertas
    * Par: par_cEmpresa - Codigo da empresa logada
    * Ret: .T. se verificacao concluida (com ou sem alertas)
    *--------------------------------------------------------------------------
    PROCEDURE AlertaPafReducaoZ(par_cEmpresa)
        LOCAL loc_lSucesso, loc_cSQL, loc_cMsg, loc_nQtde, loc_nQtdias

        loc_lSucesso = .F.
        loc_cMsg     = ""

        TRY
            *-- Verifica estado da empresa
            loc_cSQL = "select Estas From SigCdEmp Where Cemps = '" + ALLTRIM(par_cEmpresa) + "'"
            IF USED("csEstEmp")
                USE IN ("csEstEmp")
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "csEstEmp") < 1
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (csEstEmp)")
                loc_lSucesso = .F.
            ENDIF

            SELECT csEstEmp
            IF ALLTRIM(UPPER(csEstEmp.Estas)) <> "SC"
                loc_lSucesso = .T.
            ENDIF

            *-- Busca pendencias PAF
            loc_cSQL = "Select * from Sigfipaf where status <> 'AUT'"
            IF USED("crSigfipaf")
                USE IN ("crSigfipaf")
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigfipaf") < 1
                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (crSigfipaf)")
                loc_lSucesso = .F.
            ENDIF

            SELECT crSigfipaf
            GO TOP
            IF RECCOUNT() > 0
                *-- Pendencias Reducao Z
                SELECT COUNT(cidchaves) AS Qtde ;
                    FROM crSigfipaf ;
                    WHERE tipo = "REDUCAOZ" AND Status <> "AUT" ;
                    INTO CURSOR crPaf READWRITE

                loc_nQtde = crPaf.Qtde
                IF loc_nQtde > 0
                    loc_cMsg = "H" + CHR(225) + " " + ALLTRIM(STR(loc_nQtde)) + ;
                        " ARQUIVOS COM INFORMA" + CHR(199) + CHR(213) + "ES DA REDU" + CHR(199) + CHR(195) + "O Z DO PAF-ECF" + ;
                        " PENDENTES DE TRANSMISS" + CHR(195) + "O AO FISCO." + ;
                        " O CONTRIBUINTE PODE TRANSMITIR OS ARQUIVOS PELO MENU FISCAL" + ;
                        " POR MEIO DO COMANDO 'Envio ao FISCO-REDU" + CHR(199) + CHR(195) + "O Z'"
                ENDIF
                IF loc_nQtde >= 5 AND loc_nQtde <= 8
                    loc_cMsg = loc_cMsg + " VERIFIQUE COM O FORNECEDOR DO PROGRAMA A SOLU" + CHR(199) + CHR(195) + "O DA PEND" + CHR(202) + "NCIA."
                ENDIF
                IF loc_nQtde >= 9
                    loc_cMsg = loc_cMsg + ;
                        " A PARTIR DA 10" + CHR(170) + " TRANSMISS" + CHR(195) + "O PENDENTE," + ;
                        " O SEU PROGRAMA SER" + CHR(193) + " BLOQUEADO E SOMENTE SER" + CHR(193) + ;
                        " LIBERADO AP" + CHR(211) + "S TODAS AS TRANSMISS" + CHR(213) + "ES SEREM REALIZADAS." + ;
                        " VERIFIQUE URGENTEMENTE COM O FORNECEDOR DO PROGRAMA A SOLU" + CHR(199) + CHR(195) + "O DA PEND" + CHR(202) + "NCIA."
                ENDIF
                IF NOT EMPTY(loc_cMsg)
                    MsgAviso(loc_cMsg, "Aviso")
                ENDIF

                loc_cMsg = ""

                *-- Pendencias Estoque
                SELECT datager FROM crSigfipaf ;
                    WHERE tipo = "ESTOQUE" AND status <> "AUT" ;
                    INTO CURSOR crPaf READWRITE

                IF RECCOUNT("crPaf") > 0
                    loc_nQtdias = DATE() - TTOD(crPaf.datager)
                    IF loc_nQtdias > 0
                        loc_cMsg = "H" + CHR(193) + " UM ARQUIVO COM INFORMA" + CHR(199) + CHR(213) + "ES DO ESTOQUE MENSAL" + ;
                            " DO ESTABELECIMENTO PENDENTE DE TRANSMISS" + CHR(195) + "O AO FISCO." + ;
                            " O CONTRIBUINTE PODE TRANSMITIR O ARQUIVO PELO MENU FISCAL" + ;
                            " POR MEIO DO COMANDO 'Envio ao FISCO-ESTOQUE'."
                    ENDIF
                    IF loc_nQtdias > 9
                        loc_cMsg = loc_cMsg + " VERIFIQUE COM O FORNECEDOR DO PROGRAMA A SOLU" + CHR(199) + CHR(195) + "O DA PEND" + CHR(202) + "NCIA."
                    ENDIF
                    IF NOT EMPTY(loc_cMsg)
                        MsgAviso(loc_cMsg, "Aviso")
                    ENDIF
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarSenha - Valida senha digitada contra banco de dados
    * Trata usuario especial 4CONTROL com senha diaria (fGerPswDiario)
    * Trata bloqueio apos exceder tentativas (crParam2.nBloSenhas)
    * Par: par_cSenhaDigitada - Senha digitada pelo usuario
    * Ret: .T. se senha valida, .F. se invalida
    *      this_lUsuarioOk atualizado com resultado
    *      Retorna mensagem de erro em par_cMensagem (por referencia)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarSenha(par_cSenhaDigitada, par_cMensagem)
        LOCAL loc_lSucesso, loc_cSenhaPad
        loc_lSucesso = .F.
        par_cMensagem = ""

        loc_cSenhaPad = PADR(STRTRAN(STRTRAN(par_cSenhaDigitada, "'", " "), '"', " "), 10)

        TRY
            IF NOT USED("crParam2")
                THIS.CarregarParametros()
            ENDIF

            IF USED("crParam2")
                SELECT crParam2
                LOCATE
            ENDIF

            IF USED("crsigcdusu1")
                SELECT ("crsigcdusu1")
                SET ORDER TO ("") IN ("crsigcdusu1")
                LOCATE

                IF UPPER(ALLTRIM(THIS.this_cUsuario)) = "4CONTROL"
                    LOCAL loc_cSenha4c
                    loc_cSenha4c = fGerPswDiario(VAL(SYS(1)), DATE(), 0)
                    IF NOT ALLTRIM(loc_cSenhaPad) == ALLTRIM(loc_cSenha4c)
                        par_cMensagem = "Usu" + CHR(225) + "rio / Senha Inv" + CHR(225) + "lidos(1)."
                        THIS.this_lUsuarioOk = .F.
                    ELSE
                        THIS.this_lUsuarioOk = .T.
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    THIS.this_lUsuarioOk = (NOT EMPTY(THIS.this_cUsuario) AND ;
                        NOT EOF("crsigcdusu1") AND ;
                        loc_cSenhaPad == fCriptografar(crsigcdusu1.senhas))

                    IF THIS.this_lUsuarioOk
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

            IF NOT THIS.this_lUsuarioOk
                IF USED("crParam2") AND NVL(crParam2.nBloSenhas, 0) > 0 AND ;
                    NOT EMPTY(THIS.this_cUsuario) AND ;
                    USED("crsigcdusu1") AND NOT EOF("crsigcdusu1") AND ;
                    NOT loc_cSenhaPad == fCriptografar(crsigcdusu1.senhas)

                    IF THIS.this_nBloqueiaSenha > NVL(crParam2.nBloSenhas, 0)
                        THIS.BloquearSenha(THIS.this_cUsuario)
                        par_cMensagem = "N" + CHR(186) + " Tentativas Ultrapassadas, Senha Bloqueada." + ;
                            CHR(10) + "Contate o Suporte Tecnico."
                    ELSE
                        par_cMensagem = "Senha Incorreta (Permitido Apenas " + ;
                            ALLTRIM(STR(NVL(crParam2.nBloSenhas, 0), 20, 0)) + " Tentativas)."
                        THIS.this_nBloqueiaSenha = THIS.this_nBloqueiaSenha + 1
                    ENDIF
                ELSE
                    par_cMensagem = "Usu" + CHR(225) + "rio / Senha Inv" + CHR(225) + "lidos(2)."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCredenciais - Verifica se usuario + empresa + senha estao validos
    * Chamado pelo Confirma antes de processar login
    * Par: par_cSenhaDigitada  - Senha digitada
    *      par_cEmpresa        - Codigo empresa selecionada
    *      par_lEmpresaVisivel - .T. se campo empresa esta visivel
    *      par_cMensagem       - Retorna mensagem de erro (por referencia)
    * Ret: 0=OK, 1=usuario/senha invalida, 2=empresa invalida, 3=licencas excedidas
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCredenciais(par_cSenhaDigitada, par_cEmpresa, ;
                                          par_lEmpresaVisivel, par_cMensagem)
        LOCAL loc_nResultado, loc_lChkUsuario, loc_lChkEmpresa
        loc_nResultado = 0
        par_cMensagem = ""

        TRY
            loc_lChkUsuario = THIS.this_lUsuarioOk
            loc_lChkEmpresa = (NOT par_lEmpresaVisivel)

            IF UPPER(ALLTRIM(THIS.this_cUsuario)) = "4CONTROL" AND ;
                USED("crsigcdusu1") AND EMPTY(ALLTRIM(crsigcdusu1.senhas))
                par_cMensagem = "Senha Inv" + CHR(225) + "lida!!!"
                loc_lSucesso = 1
            ENDIF

            IF USED("crsigcdusu1")
                SELECT ("crsigcdusu1")
                SET ORDER TO ("") IN ("crsigcdusu1")
                LOCATE FOR (crsigcdusu1.usuarios == THIS.this_cUsuario)
                loc_lChkUsuario = (loc_lChkUsuario OR ;
                    (NOT EMPTY(THIS.this_cUsuario) AND ;
                     NOT EOF("crsigcdusu1") AND ;
                     par_cSenhaDigitada == fCriptografar(crsigcdusu1.senhas)))
            ENDIF

            IF USED("crEmpresa1")
                SELECT ("crEmpresa1")
                SET ORDER TO ("") IN ("crEmpresa1")
                LOCATE FOR (crEmpresa1.cemps == par_cEmpresa)
                loc_lChkEmpresa = (loc_lChkEmpresa OR ;
                    (NOT EMPTY(par_cEmpresa) AND NOT EOF("crEmpresa1")))
            ENDIF

            IF (goSistema.NumLicencas <> 9999) AND ;
                (UPPER(ALLTRIM(THIS.this_cUsuario)) <> "4CONTROL")
                LOCAL loc_nLic
                loc_nLic = THIS.VerificarLicencas(THIS.this_cUsuario)
                IF loc_nLic >= goSistema.NumLicencas
                    par_cMensagem = "A Quantidade de Licen" + CHR(231) + "as de Uso do Sistema Foram Excedidas." + ;
                        CHR(13) + "Aguarde a Libera" + CHR(231) + CHR(227) + "o das Licen" + CHR(231) + ;
                        "as em Uso e Tente Novamente." + CHR(13) + ;
                        "A Quantidade M" + CHR(225) + "xima de Usu" + CHR(225) + ;
                        "rios Simult" + CHR(226) + "neos " + CHR(233) + " " + ;
                        ALLTRIM(STR(goSistema.NumLicencas))
                    loc_lSucesso = 3
                ENDIF
            ENDIF

            DO CASE
                CASE NOT loc_lChkUsuario
                    par_cMensagem = "Usu" + CHR(225) + "rio / Senha Inv" + CHR(225) + "lidos."
                    loc_nResultado = 1
                CASE NOT loc_lChkEmpresa
                    par_cMensagem = "Empresa Inv" + CHR(225) + "lida."
                    loc_nResultado = 2
            ENDCASE
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY

        RETURN loc_nResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarLogin - Executa processamento completo apos validacao
    * Carrega menus, parametros, barra de atalhos, configura sistema
    * Par: par_cEmpresa - Codigo da empresa logada
    *      par_cUsuario - Login do usuario
    *      par_lGetUsuario - .T. se estava pedindo usuario
    *      par_cUsuarioAtual - Usuario anterior (se troca de usuario)
    * Ret: .T. se processamento completo com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarLogin(par_cEmpresa, par_cUsuario, ;
                                    par_lGetUsuario, par_cUsuarioAtual)
        LOCAL loc_lSucesso, loc_cOpSis1, loc_cOpSis2, loc_cTransSis1
        LOCAL loc_lSupervis, loc_nDock, loc_lTmpChk, loc_lTmpApp
        LOCAL loc_cArqSetFiscal

        loc_lSucesso = .F.
        loc_lSupervis = (UPPER(ALLTRIM(par_cUsuario)) = "4CONTROL")

        TRY
            PUBLIC _tipoe, gcEmpr, gcUsuar, usuar
            gcEmpr = par_cEmpresa
            gcUsuar = par_cUsuario
            usuar = gcUsuar
            go_4c_Sistema.cCodEmpresa = gcEmpr

            IF USED("crEmpresa1")
                SELECT ("crEmpresa1")
                SET ORDER TO ("") IN ("crEmpresa1")
                LOCATE FOR (crEmpresa1.cemps == par_cEmpresa)
                IF NOT EOF("crEmpresa1")
                    _tipoe = crEmpresa1.tipos
                ENDIF
            ENDIF

            loc_nDock = 0
            loc_lTmpChk = .F.
            loc_lTmpApp = .F.

            IF USED("crParam1") AND USED("crParam2")
                SELECT ("crParam1")
                SET ORDER TO ("") IN ("crParam1")
                LOCATE

                SELECT ("crParam2")
                SET ORDER TO ("") IN ("crParam2")
                LOCATE

                loc_nDock = IIF(BETWEEN(NVL(crParam1.ndocks, 0), 0, 4), NVL(crParam1.ndocks, 0), 0)
                loc_cArqSetFiscal = SYS(5) + SYS(2003) + "\SetFiscal.Ini"
                IF FILE(loc_cArqSetFiscal)
                    loc_lTmpChk = 0
                    loc_lTmpApp = 0
                ELSE
                    loc_lTmpChk = NVL(crParam1.ntmpchks, 0)
                    loc_lTmpApp = NVL(crParam1.ntmpapps, 0)
                ENDIF
            ENDIF

            THIS.CarregarMenuPrincipal(par_cEmpresa)

            loc_nDock = loc_nDock - 1
            goSistema.BarraAtalho = CREATEOBJECT("fwBarraBtns")
            goSistema.BarraAtalho.Dock(loc_nDock)

            THIS.CarregarBarraAtalhos(par_cUsuario)

            IF par_lGetUsuario
                IF NOT EMPTY(par_cUsuarioAtual)
                    loc_cOpSis1 = "S"
                    loc_cOpSis2 = "USUARIO"
                    loc_cTransSis1 = "Saida do Sistema"
                ELSE
                    loc_cOpSis1 = "E"
                    loc_cOpSis2 = "USUARIO"
                    loc_cTransSis1 = "Acesso ao Sistema - " + gcEmpr
                ENDIF
            ELSE
                loc_cOpSis1 = "T"
                loc_cOpSis2 = "EMPRESA"
                loc_cTransSis1 = "Muda Empresa - " + gcEmpr
            ENDIF

            IF NOT goSistema.Desenvolvimento
                = fTempoApp(loc_lTmpChk, loc_lTmpApp)
            ENDIF

            goSistema.EmpresaLogada = go_4c_Sistema.cCodEmpresa
            goSistema.UsuarioLogado = goSistema.usuario
            IF USED("crsigcdusu1")
                goSistema.SenhaLogado = ALLTRIM(crsigcdusu1.senhas)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBarraAtalhos - Carrega botoes da barra de atalhos do usuario
    * Consulta SigCdAcB + sigcdprg, cria icones e adiciona ao BarraAtalho
    * Par: par_cUsuario - Login do usuario
    * Ret: .T. se barra carregada com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBarraAtalhos(par_cUsuario)
        LOCAL loc_lSucesso, loc_cSQL, loc_nErro, loc_nNBotao
        LOCAL loc_cDirTmp, loc_cArqIcone, loc_cExtIcone, loc_nTamIcone
        LOCAL loc_cMacro, loc_lSelBarras

        loc_lSucesso = .F.
        loc_nErro = 1
        loc_nNBotao = 0
        loc_cDirTmp = ADDBS(SYS(2023))
        loc_lSelBarras = .T.

        TRY
            loc_cSQL = "select a.programas,a.parametros,a.barraforms," + ;
                "b.descricaos,b.barrapict from SigCdAcB a" + ;
                " left join sigcdprg b on b.programas+b.parametros=a.programas+a.parametros" + ;
                " where a.usuarios='" + ALLTRIM(par_cUsuario) + "'" + ;
                " and a.selbarras='" + IIF(loc_lSelBarras, "1", "0") + "'" + ;
                " union all" + ;
                " select a.programas,a.parametros,a.barraforms," + ;
                "b.descricaos,b.barrapict from SigCdAcB a" + ;
                " left join sigcdprg b on b.programas+b.parametros=a.programas+a.parametros" + ;
                " where a.selbarras='" + IIF(loc_lSelBarras, "1", "0") + "'" + ;
                " and a.grupos in (select c.grupos from SigCdAcG c" + ;
                " where c.usuarios='" + ALLTRIM(par_cUsuario) + "')"

            IF USED("crTmpAcBarra1")
                USE IN ("crTmpAcBarra1")
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpAcBarra1") > 0
                IF USED("crTmpAcBarra1")
                    IF USED("crAcBarra1")
                        USE IN ("crAcBarra1")
                    ENDIF
                    SELECT DISTINCT a.programas, a.parametros, a.barraforms, ;
                           PADR(NVL(a.descricaos, ""), 100) AS descricaos, ;
                           PADR(NVL(a.barrapict, ""), 50) AS barrapict ;
                      FROM crTmpAcBarra1 a ;
                     ORDER BY 1, 2 ;
                      INTO CURSOR crAcBarra1
                ENDIF

                IF USED("crAcBarra1")
                    SELECT crAcBarra1
                    SET ORDER TO ("") IN crAcBarra1
                    LOCATE

                    SCAN WHILE loc_nErro > 0
                        IF NOT SEEK(STR(VAL(crAcBarra1.Programas), 10, 0), "crTmpOpe", "ndopes") OR ;
                            NOT NVL(crTmpOpe.Opeinatvs, 0) == 1

                            loc_cArqIcone = ""
                            loc_nTamIcone = 0

                            IF LEFT(crAcBarra1.BarraForms, 8) = "SIGMVEXP"
                                IF LEFT(crAcBarra1.programas, 2) <> "GE" AND ;
                                    SEEK(STR(VAL(crAcBarra1.Programas), 10, 0), "crTmpOpe", "ndopes") AND ;
                                    NOT EMPTY(crTmpOpe.EmpLancs) AND crTmpOpe.EmpLancs <> go_4c_Sistema.cCodEmpresa
                                    LOOP
                                ENDIF
                            ENDIF

                            IF NOT EMPTY(crAcBarra1.barrapict)
                                loc_cExtIcone = JUSTEXT(ALLTRIM(crAcBarra1.barrapict))
                                IF EMPTY(loc_cExtIcone)
                                    loc_cExtIcone = "ico"
                                ENDIF

                                LOCAL loc_cSQLIcone
                                loc_cSQLIcone = "select a.marqicones from SigSyIco a" + ;
                                    " where a.carqicones='" + ALLTRIM(crAcBarra1.barrapict) + "'"

                                IF USED("crTmpIcone1")
                                    USE IN ("crTmpIcone1")
                                ENDIF

                                IF SQLEXEC(gnConnHandle, loc_cSQLIcone, "crTmpIcone1") > 0
                                    SELECT ("crTmpIcone1")
                                    SET ORDER TO ("") IN ("crTmpIcone1")
                                    LOCATE

                                    IF NOT EOF("crTmpIcone1") AND NOT EMPTY(crTmpIcone1.marqicones)
                                        loc_cArqIcone = loc_cDirTmp + goSistema.Sys2015Tmp + SYS(2015) + "." + loc_cExtIcone
                                        loc_nTamIcone = STRTOFILE(crTmpIcone1.marqicones, loc_cArqIcone)
                                        IF loc_nTamIcone = 0
                                            loc_cArqIcone = ""
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF

                            loc_nNBotao = loc_nNBotao + 1
                            loc_cMacro = "botao" + ALLTRIM(STR(loc_nNBotao, 20, 0))
                            goSistema.BarraAtalho.AddObject(loc_cMacro, "bot" + CHR(227) + "o_da_barra")
                            goSistema.BarraAtalho.&loc_cMacro..ToolTipText = ALLTRIM(crAcBarra1.descricaos)
                            goSistema.BarraAtalho.&loc_cMacro..Picture = loc_cArqIcone
                            goSistema.BarraAtalho.&loc_cMacro..FormExec = ALLTRIM(crAcBarra1.barraforms)
                            goSistema.BarraAtalho.&loc_cMacro..Visible = .T.
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF

            goSistema.BarraAtalho.Visible = (loc_nNBotao > 0)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarEmpresas - Carrega lista de empresas e retorna quantidade
    * Se apenas 1 empresa, preenche automaticamente os valores
    * Ret: Numero de empresas encontradas (0 se erro)
    *      this_cEmpresa e this_cDescEmpresa preenchidos se unica empresa
    *--------------------------------------------------------------------------
    PROCEDURE AjustarEmpresas()
        LOCAL loc_nQtde, loc_cSQL, loc_nErro

        loc_nQtde = 0
        loc_nErro = IIF(gnConnHandle > 0, 1, -1)

        TRY
            loc_cSQL = "Select cemps, razas, tipos From SigCdEmp"

            IF USED("crEmpresa1")
                USE IN ("crEmpresa1")
            ENDIF

            IF loc_nErro > 0
                loc_nErro = SQLEXEC(gnConnHandle, loc_cSQL, "crEmpresa1")
            ENDIF

            IF USED("crEmpresa1")
                GO TOP IN crEmpresa1
                loc_nQtde = RECCOUNT("crEmpresa1")

                IF loc_nQtde = 1
                    THIS.this_cEmpresa     = crEmpresa1.cemps
                    THIS.this_cDescEmpresa = crEmpresa1.razas
                    THIS.this_cTipoEmpresa = crEmpresa1.tipos
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nQtde
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarEmpresaPorDescricao - Localiza empresa pelo nome/descricao
    * Usado pelo campo Get_Demp (descricao da empresa)
    * Par: par_cDescricao - Descricao digitada
    * Ret: .T. se empresa encontrada/selecionada, .F. se nao
    *      this_cEmpresa e this_cDescEmpresa atualizados se encontrada
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEmpresaPorDescricao(par_cDescricao)
        LOCAL loc_lSucesso, loc_cSQL, loc_lEncontrou

        loc_lSucesso = .F.
        loc_lEncontrou = .F.

        TRY
            IF NOT USED("crEmpresa1") OR RECCOUNT("crEmpresa1") = 0
                loc_cSQL = "select a.cemps,a.razas,a.tipos from SigCdEmp a order by 1"
                IF USED("crEmpresa1")
                    USE IN ("crEmpresa1")
                ENDIF
                SQLEXEC(gnConnHandle, loc_cSQL, "crEmpresa1")
            ENDIF

            IF USED("crEmpresa1") AND RECCOUNT("crEmpresa1") > 0
                SELECT ("crEmpresa1")
                LOCATE FOR LOWER(ALLTRIM(crEmpresa1.razas)) == LOWER(ALLTRIM(par_cDescricao))

                IF NOT EOF("crEmpresa1")
                    loc_lEncontrou = .T.
                ENDIF

                IF loc_lEncontrou
                    THIS.this_cEmpresa     = ALLTRIM(crEmpresa1.cemps)
                    THIS.this_cDescEmpresa = ALLTRIM(crEmpresa1.razas)
                    THIS.this_cTipoEmpresa = ALLTRIM(crEmpresa1.tipos)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarExpSenha - Verifica se senha do usuario precisa ser trocada
    * Compara data da ultima troca com parametro de dias para expiracao
    * Ret: .T. se senha precisa ser trocada, .F. se nao
    *--------------------------------------------------------------------------
    PROCEDURE VerificarExpSenha()
        LOCAL loc_lPrecisaTrocar, loc_dUltData, loc_dHoje, loc_nDias

        loc_lPrecisaTrocar = .F.

        TRY
            IF USED("crsigcdusu1") AND USED("crParam2")
                loc_dUltData = TTOD(NVL(crsigcdusu1.tDtSenhas, CTOT("01/01/1900")))

                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    LOCAL loc_cSQL
                    loc_cSQL = "SELECT GETDATE() AS dtHoje"
                    IF USED("crTmpDtHoje")
                        USE IN ("crTmpDtHoje")
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpDtHoje") > 0
                        loc_dHoje = TTOD(crTmpDtHoje.dtHoje)
                        IF USED("crTmpDtHoje")
                            USE IN ("crTmpDtHoje")
                        ENDIF
                    ELSE
                        loc_dHoje = DATE()
                    ENDIF
                ELSE
                    loc_dHoje = DATE()
                ENDIF

                SELECT crParam2
                LOCATE
                loc_nDias = NVL(crParam2.nDiaSenhas, 0)

                LOCAL loc_lObrigNova
                loc_lObrigNova = (NVL(crsigcdusu1.ObrigSenhas, 0) = 1) AND ;
                    EMPTY(ALLTRIM(crsigcdusu1.senhas))

                IF loc_lObrigNova OR (loc_nDias > 0 AND (loc_dHoje - loc_dUltData) >= loc_nDias)
                    loc_lPrecisaTrocar = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lPrecisaTrocar
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarPafEcf - Retorna se PAF-ECF esta ativo nos parametros
    * Ret: .T. se PafEcfs = 1, .F. caso contrario
    *--------------------------------------------------------------------------
    PROCEDURE VerificarPafEcf()
        LOCAL loc_lAtivo

        loc_lAtivo = .F.

        TRY
            IF USED("crParam2")
                SELECT crParam2
                LOCATE
                IF NOT EOF("crParam2")
                    IF VARTYPE(crParam2.PafEcfs) = "L"
                        loc_lAtivo = crParam2.PafEcfs
                    ELSE
                        IF VARTYPE(crParam2.PafEcfs) = "L"
                            loc_lAtivo = crParam2.PafEcfs
                        ELSE
                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                loc_lAtivo = crParam2.PafEcfs
                            ELSE
                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                    loc_lAtivo = crParam2.PafEcfs
                                ELSE
                                    IF VARTYPE(crParam2.PafEcfs) = "L"
                                        loc_lAtivo = crParam2.PafEcfs
                                    ELSE
                                        IF VARTYPE(crParam2.PafEcfs) = "L"
                                            loc_lAtivo = crParam2.PafEcfs
                                        ELSE
                                            IF VARTYPE(crParam2.PafEcfs) = "L"
                                                loc_lAtivo = crParam2.PafEcfs
                                            ELSE
                                                IF VARTYPE(crParam2.PafEcfs) = "L"
                                                    loc_lAtivo = crParam2.PafEcfs
                                                ELSE
                                                    loc_lAtivo = (NVL(crParam2.PafEcfs, 0) = 1)
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lAtivo
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLogoEmpresa - Carrega logo da empresa selecionada para exibicao
    * Decodifica base64 do campo logos e salva em arquivo temporario
    * Par: par_cEmpresa - Codigo da empresa
    * Ret: Caminho do arquivo de imagem temporario (vazio se nao encontrou)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLogoEmpresa(par_cEmpresa)
        LOCAL loc_cArqImagem, loc_cSQL, loc_cStrLogo, loc_cFoto

        loc_cArqImagem = ""

        TRY
            IF USED("crEmpresa1")
                SELECT ("crEmpresa1")
                LOCATE FOR LOWER(ALLTRIM(crEmpresa1.cemps)) = LOWER(ALLTRIM(par_cEmpresa))

                IF NOT EOF("crEmpresa1")
                    loc_cArqImagem = ADDBS(SYS(2023)) + goSistema.Sys2015Tmp + SYS(2015) + ".img"

                    loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                        crEmpresa1.logos, ;
                        "data:image/png;base64,", ""), ;
                        "data:image/jpeg;base64,", ""), ;
                        "data:image/jpg;base64,", ""), 14)
                    loc_cStrLogo = loc_cFoto

                    IF EMPTY(crEmpresa1.logos)
                        loc_cSQL = "select a.logos from SigCdPam a"
                        IF USED("crTmpLogo1")
                            USE IN ("crTmpLogo1")
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpLogo1") > 0
                            IF USED("crTmpLogo1")
                                loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    crTmpLogo1.logos, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                                loc_cStrLogo = loc_cFoto
                            ENDIF
                        ENDIF
                    ENDIF

                    IF NOT EMPTY(loc_cStrLogo) AND STRTOFILE(loc_cStrLogo, loc_cArqImagem) > 0
                        *-- Arquivo criado com sucesso
                    ELSE
                        loc_cArqImagem = ""
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cArqImagem = ""
        ENDTRY

        RETURN loc_cArqImagem
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarAlertas - Retorna tipo de alertas configurado
    * Ret: Valor de crParam2.Alertas (0 se nao configurado)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarAlertas()
        LOCAL loc_nAlertas

        loc_nAlertas = 0

        TRY
            IF USED("crParam2")
                SELECT crParam2
                LOCATE
                IF NOT EOF("crParam2")
                    loc_nAlertas = NVL(crParam2.Alertas, 0)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nAlertas
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha todos os cursores temporarios usados no login
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED("crsigcdusu1")
                USE IN ("crsigcdusu1")
            ENDIF
            IF USED("crEmpresa1")
                USE IN ("crEmpresa1")
            ENDIF
            IF USED("crParam1")
                USE IN ("crParam1")
            ENDIF
            IF USED("crParam2")
                USE IN ("crParam2")
            ENDIF
            IF USED("crTmpAcBarra1")
                USE IN ("crTmpAcBarra1")
            ENDIF
            IF USED("crAcBarra1")
                USE IN ("crAcBarra1")
            ENDIF
            IF USED("crSigCdAcU1")
                USE IN ("crSigCdAcU1")
            ENDIF
            IF USED("crTmpOpe")
                USE IN ("crTmpOpe")
            ENDIF
            IF USED("crTmpIcone1")
                USE IN ("crTmpIcone1")
            ENDIF
            IF USED("crTmpLogo1")
                USE IN ("crTmpLogo1")
            ENDIF
            IF USED("csEstEmp")
                USE IN ("csEstEmp")
            ENDIF
            IF USED("crSigfipaf")
                USE IN ("crSigfipaf")
            ENDIF
            IF USED("crPaf")
                USE IN ("crPaf")
            ENDIF
        CATCH TO loc_oErro
            *-- Ignora erros ao fechar cursores no cleanup
        ENDTRY
    ENDPROC

ENDDEFINE

