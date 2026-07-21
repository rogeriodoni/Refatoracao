# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 9/10
- Mensagem: Testes automaticos: 0% < 100%. Falhas: Teste 'Instanciacao': CREATEOBJECT retornou valor nao-objeto

## CONTEXTO DO ERRO

### ERROS CAPTURADOS EM MODO TESTE (vfp_error_details.txt):
[15/07/2026 12:45:39 AM] Erro sigprccpBO: Sem conexão com o banco de dados.
[15/07/2026 12:45:40 AM] Erro InicializarForm Formsigprccp: Property HEADERHEIGHT is not found. LN=1365 PROC=configurargrade


### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-15 00:40:20] [INFO] Config FPW: (nao fornecido)
[2026-07-15 00:40:20] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 00:40:20] [INFO] Timeout: 300 segundos
[2026-07-15 00:40:20] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v13octqq.prg
[2026-07-15 00:40:20] [INFO] Conteudo do wrapper:
[2026-07-15 00:40:20] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
QUIT

[2026-07-15 00:40:20] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v13octqq.prg
[2026-07-15 00:40:20] [INFO] VFP output esperado em: C:\4c\tasks\task262\vfp_output.txt
[2026-07-15 00:40:20] [INFO] Executando Visual FoxPro 9...
[2026-07-15 00:40:20] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v13octqq.prg
[2026-07-15 00:40:20] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v13octqq.prg
[2026-07-15 00:40:20] [INFO] Timeout configurado: 300 segundos
[2026-07-15 00:40:43] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 00:40:43] [INFO] VFP9 finalizado em 22.1978759 segundos
[2026-07-15 00:40:43] [INFO] Exit Code: 
[2026-07-15 00:40:43] [INFO] 
[2026-07-15 00:40:43] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 00:40:43] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_v13octqq.prg
[2026-07-15 00:40:43] [INFO] 
[2026-07-15 00:40:43] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 00:40:43] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 00:40:43] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 00:40:43] [INFO] * Parameters: 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
[2026-07-15 00:40:43] [INFO] 
[2026-07-15 00:40:43] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 00:40:43] [INFO] SET SAFETY OFF
[2026-07-15 00:40:43] [INFO] SET RESOURCE OFF
[2026-07-15 00:40:43] [INFO] SET TALK OFF
[2026-07-15 00:40:43] [INFO] SET NOTIFY OFF
[2026-07-15 00:40:43] [INFO] SYS(2335, 0)
[2026-07-15 00:40:43] [INFO] 
[2026-07-15 00:40:43] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
[2026-07-15 00:40:43] [INFO] QUIT
[2026-07-15 00:40:43] [INFO] 
[2026-07-15 00:40:43] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 00:40:43] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-15 00:42:10] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 00:42:10] [INFO] Config FPW: (nao fornecido)
[2026-07-15 00:42:10] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 00:42:10] [INFO] Timeout: 300 segundos
[2026-07-15 00:42:10] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kkrobasg.prg
[2026-07-15 00:42:10] [INFO] Conteudo do wrapper:
[2026-07-15 00:42:10] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
QUIT

[2026-07-15 00:42:10] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kkrobasg.prg
[2026-07-15 00:42:10] [INFO] VFP output esperado em: C:\4c\tasks\task262\vfp_output.txt
[2026-07-15 00:42:10] [INFO] Executando Visual FoxPro 9...
[2026-07-15 00:42:10] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kkrobasg.prg
[2026-07-15 00:42:10] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kkrobasg.prg
[2026-07-15 00:42:10] [INFO] Timeout configurado: 300 segundos
[2026-07-15 00:42:32] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 00:42:32] [INFO] VFP9 finalizado em 22.0932206 segundos
[2026-07-15 00:42:32] [INFO] Exit Code: 
[2026-07-15 00:42:32] [INFO] 
[2026-07-15 00:42:32] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 00:42:32] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kkrobasg.prg
[2026-07-15 00:42:32] [INFO] 
[2026-07-15 00:42:32] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 00:42:32] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 00:42:32] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 00:42:32] [INFO] * Parameters: 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
[2026-07-15 00:42:32] [INFO] 
[2026-07-15 00:42:32] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 00:42:32] [INFO] SET SAFETY OFF
[2026-07-15 00:42:32] [INFO] SET RESOURCE OFF
[2026-07-15 00:42:32] [INFO] SET TALK OFF
[2026-07-15 00:42:32] [INFO] SET NOTIFY OFF
[2026-07-15 00:42:32] [INFO] SYS(2335, 0)
[2026-07-15 00:42:32] [INFO] 
[2026-07-15 00:42:32] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
[2026-07-15 00:42:32] [INFO] QUIT
[2026-07-15 00:42:32] [INFO] 
[2026-07-15 00:42:32] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 00:42:32] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-15 00:43:37] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 00:43:37] [INFO] Config FPW: (nao fornecido)
[2026-07-15 00:43:37] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 00:43:37] [INFO] Timeout: 300 segundos
[2026-07-15 00:43:37] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lepzr4nu.prg
[2026-07-15 00:43:37] [INFO] Conteudo do wrapper:
[2026-07-15 00:43:37] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
QUIT

[2026-07-15 00:43:37] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lepzr4nu.prg
[2026-07-15 00:43:37] [INFO] VFP output esperado em: C:\4c\tasks\task262\vfp_output.txt
[2026-07-15 00:43:37] [INFO] Executando Visual FoxPro 9...
[2026-07-15 00:43:37] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lepzr4nu.prg
[2026-07-15 00:43:37] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lepzr4nu.prg
[2026-07-15 00:43:37] [INFO] Timeout configurado: 300 segundos
[2026-07-15 00:44:00] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 00:44:00] [INFO] VFP9 finalizado em 22.1510129 segundos
[2026-07-15 00:44:00] [INFO] Exit Code: 
[2026-07-15 00:44:00] [INFO] 
[2026-07-15 00:44:00] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 00:44:00] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lepzr4nu.prg
[2026-07-15 00:44:00] [INFO] 
[2026-07-15 00:44:00] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 00:44:00] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 00:44:00] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 00:44:00] [INFO] * Parameters: 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
[2026-07-15 00:44:00] [INFO] 
[2026-07-15 00:44:00] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 00:44:00] [INFO] SET SAFETY OFF
[2026-07-15 00:44:00] [INFO] SET RESOURCE OFF
[2026-07-15 00:44:00] [INFO] SET TALK OFF
[2026-07-15 00:44:00] [INFO] SET NOTIFY OFF
[2026-07-15 00:44:00] [INFO] SYS(2335, 0)
[2026-07-15 00:44:00] [INFO] 
[2026-07-15 00:44:00] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
[2026-07-15 00:44:00] [INFO] QUIT
[2026-07-15 00:44:00] [INFO] 
[2026-07-15 00:44:00] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 00:44:00] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)
[2026-07-15 00:45:17] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-15 00:45:17] [INFO] Config FPW: (nao fornecido)
[2026-07-15 00:45:17] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 00:45:17] [INFO] Timeout: 300 segundos
[2026-07-15 00:45:18] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hccangso.prg
[2026-07-15 00:45:18] [INFO] Conteudo do wrapper:
[2026-07-15 00:45:18] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
QUIT

[2026-07-15 00:45:18] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hccangso.prg
[2026-07-15 00:45:18] [INFO] VFP output esperado em: C:\4c\tasks\task262\vfp_output.txt
[2026-07-15 00:45:18] [INFO] Executando Visual FoxPro 9...
[2026-07-15 00:45:18] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hccangso.prg
[2026-07-15 00:45:18] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hccangso.prg
[2026-07-15 00:45:18] [INFO] Timeout configurado: 300 segundos
[2026-07-15 00:45:40] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-07-15 00:45:40] [INFO] VFP9 finalizado em 22.1197706 segundos
[2026-07-15 00:45:40] [INFO] Exit Code: 
[2026-07-15 00:45:40] [INFO] 
[2026-07-15 00:45:40] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-15 00:45:40] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hccangso.prg
[2026-07-15 00:45:40] [INFO] 
[2026-07-15 00:45:40] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-15 00:45:40] [INFO] * Auto-generated wrapper for parameters
[2026-07-15 00:45:40] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-15 00:45:40] [INFO] * Parameters: 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
[2026-07-15 00:45:40] [INFO] 
[2026-07-15 00:45:40] [INFO] * Anti-dialog protections for unattended execution
[2026-07-15 00:45:40] [INFO] SET SAFETY OFF
[2026-07-15 00:45:40] [INFO] SET RESOURCE OFF
[2026-07-15 00:45:40] [INFO] SET TALK OFF
[2026-07-15 00:45:40] [INFO] SET NOTIFY OFF
[2026-07-15 00:45:40] [INFO] SYS(2335, 0)
[2026-07-15 00:45:40] [INFO] 
[2026-07-15 00:45:40] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formsigprccp', 'C:\4c\tasks\task262', 'OPERACIONAL'
[2026-07-15 00:45:40] [INFO] QUIT
[2026-07-15 00:45:40] [INFO] 
[2026-07-15 00:45:40] [INFO] === Fim do Wrapper.prg ===
[2026-07-15 00:45:40] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)


### RESULTADO DOS TESTES (teste_resultado.json):
{
  "formClass": "Formsigprccp",
  "timestamp": "20260715004540",
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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg):
*==============================================================================
* Formsigprccp.prg - Formulario OPERACIONAL: Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os
* Equivalente ao sigprccp.SCX do legado
* Herda de FormBase
*==============================================================================

DEFINE CLASS Formsigprccp AS FormBase

    Width       = 1000
    Height      = 600
    Caption     = "Rec" + CHR(225) + "lculo de Pre" + CHR(231) + "os"
    ShowWindow  = 1
    WindowType  = 1
    TitleBar    = 0
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    AutoCenter  = .T.
    BorderStyle = 2
    Themes      = .F.
    DataSession = 2

    this_lAutomatico = .F.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.Picture    = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.ConfigurarPageFrame()

            THIS.this_oBusinessObject = CREATEOBJECT("sigprccpBO")
            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar sigprccpBO.", "Erro InicializarForm")
            ELSE
                IF !THIS.this_oBusinessObject.InicializarCursores()
                    MsgErro("Falha ao inicializar cursores.", "Erro InicializarForm")
                ELSE
                    THIS.ConfigurarCabecalho()
                    THIS.ConfigurarBotoes()
                    THIS.ConfigurarFiltros()
                    THIS.ConfigurarDados()
                    THIS.ConfigurarGrade()

                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                    BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnProcessarClick")
                    BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnAtualizarClick")
                    BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnEncerrarClick")
                    BINDEVENT(THIS.cmd_4c_Imprimir,          "Click", THIS, "BtnImprimirClick")
                    BINDEVENT(THIS.cmd_4c_SelTudo,           "Click", THIS, "BtnSelTudoClick")
                    BINDEVENT(THIS.cmd_4c_Desmarcar,         "Click", THIS, "BtnDesmarcarClick")

                    BINDEVENT(THIS.opt_4c_Recalc, "InteractiveChange", THIS, "OptRecalcChange")

                    BINDEVENT(THIS.txt_4c_CFornecs, "KeyPress", THIS, "TxtCFornecKeyPress")
                    BINDEVENT(THIS.txt_4c_MercI,   "KeyPress", THIS, "TxtMercIKeyPress")
                    BINDEVENT(THIS.txt_4c_MercF,   "KeyPress", THIS, "TxtMercFKeyPress")
                    BINDEVENT(THIS.txt_4c_CGrui,   "KeyPress", THIS, "TxtCGruiKeyPress")
                    BINDEVENT(THIS.txt_4c_CGruf,   "KeyPress", THIS, "TxtCGrufKeyPress")
                    BINDEVENT(THIS.txt_4c_SgruI,   "KeyPress", THIS, "TxtSgruIKeyPress")
                    BINDEVENT(THIS.txt_4c_SgruF,   "KeyPress", THIS, "TxtSgruFKeyPress")
                    BINDEVENT(THIS.txt_4c_CUnii,   "KeyPress", THIS, "TxtCUniiKeyPress")
                    BINDEVENT(THIS.txt_4c_CUnif,   "KeyPress", THIS, "TxtCUnifKeyPress")
                    BINDEVENT(THIS.txt_4c_Lini,    "KeyPress", THIS, "TxtLiniKeyPress")
                    BINDEVENT(THIS.txt_4c_Linf,    "KeyPress", THIS, "TxtLinfKeyPress")
                    BINDEVENT(THIS.txt_4c_Coli,    "KeyPress", THIS, "TxtColiKeyPress")
                    BINDEVENT(THIS.txt_4c_Colf,    "KeyPress", THIS, "TxtColfKeyPress")
                    BINDEVENT(THIS.txt_4c_Moedai,  "KeyPress", THIS, "TxtMoedaiKeyPress")
                    BINDEVENT(THIS.txt_4c_Moedaf,  "KeyPress", THIS, "TxtMoedafKeyPress")
                    BINDEVENT(THIS.txt_4c_Feitio,  "KeyPress", THIS, "TxtFeitioKeyPress")
                    BINDEVENT(THIS.txt_4c_NewMkp,  "KeyPress", THIS, "TxtNewMkpKeyPress")
                    BINDEVENT(THIS.txt_4c_Reajuste,"KeyPress", THIS, "TxtReajusteKeyPress")
                    BINDEVENT(THIS.txt_4c_NMrk,    "KeyPress", THIS, "TxtNMrkKeyPress")
                    BINDEVENT(THIS.txt_4c_Encargo, "KeyPress", THIS, "TxtEncargoKeyPress")

                    BINDEVENT(THIS.grd_4c_Produto, "AfterRowColChange", THIS, "GrdAfterRowColChange")

                    THIS.TornarControlesVisiveis(THIS)

                    THIS.opt_4c_Compra.Value   = 3
                    THIS.opt_4c_Pven.Value     = 2

                    THIS.OptRecalcChange()

                    THIS.txt_4c_CFornecs.SetFocus()

                    IF THIS.this_lAutomatico
                        THIS.this_oBusinessObject.ProcessaAutomatico()
                        THIS.Release()
                        loc_lSucesso = .T.
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm Formsigprccp")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .Caption   = THIS.Caption
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = THIS.Caption
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
    *==========================================================================
        *-- CommandGroup: Processar / Atualizar / Encerrar
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Top           = 0
            .Left          = 770
            .Width         = 235
            .Height        = 85

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .Caption    = "Processar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Caption    = "Atualizar"
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Enabled    = .F.
            ENDWITH

            WITH .Buttons(3)
                .Top        = 5
                .Left       = 155
                .Width      = 75
                .Height     = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Caption    = "Encerrar"
                .WordWrap   = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel     = .T.
            ENDWITH
        ENDWITH

        *-- Botao Imprimir (standalone, inicia desabilitado)
        THIS.AddObject("cmd_4c_Imprimir", "CommandButton")
        WITH THIS.cmd_4c_Imprimir
            .Top         = 3
            .Left        = 700
            .Width       = 65
            .Height      = 75
            .FontBold    = .T.
            .FontItalic  = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Caption     = "Imprimir"
            .WordWrap    = .T.
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
            .Enabled     = .F.
        ENDWITH

        *-- Botoes de selecao ao lado do grid
        THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
        WITH THIS.cmd_4c_SelTudo
            .Top         = 433
            .Left        = 955
            .Width       = 26
            .Height      = 26
            .Caption     = ""
            .Themes      = .T.
            .Picture     = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
            .ToolTipText = "Selecionar Tudo"
            .TabStop     = .F.
        ENDWITH

        THIS.AddObject("cmd_4c_Desmarcar", "CommandButton")
        WITH THIS.cmd_4c_Desmarcar
            .Top         = 473
            .Left        = 955
            .Width       = 26
            .Height      = 26
            .Caption     = ""
            .Themes      = .T.
            .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
            .ToolTipText = "Desmarcar Tudo"
            .TabStop     = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarFiltros()
    *==========================================================================
        *-- Label secao Filtros
        THIS.AddObject("lbl_4c_SecFiltros", "Label")
        WITH THIS.lbl_4c_SecFiltros
            .Top       = 94
            .Left      = 11
            .Width     = 53
            .Height    = 21
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .BackStyle = 0
            .Caption   = "Filtros"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Linha separadora abaixo dos filtros
        THIS.AddObject("lne_4c_Sep", "Line")
        WITH THIS.lne_4c_Sep
            .Top    = 258
            .Left   = 13
            .Height = 0
            .Width  = 738
        ENDWITH

        *-- Fornecedor
        THIS.AddObject("lbl_4c_Fornecedor", "Label")
        WITH THIS.lbl_4c_Fornecedor
            .Top       = 92
            .Left      = 79
            .Width     = 64
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Fornecedor :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CFornecs", "TextBox")
        WITH THIS.txt_4c_CFornecs
            .Top           = 88
            .Left          = 145
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .Format        = "K!"
            .Value         = ""
        ENDWITH

        THIS.AddObject("txt_4c_DFornecs", "TextBox")
        WITH THIS.txt_4c_DFornecs
            .Top           = 88
            .Left          = 228
            .Width         = 197
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 40
            .SpecialEffect = 1
            .ReadOnly      = .T.
            .Value         = ""
        ENDWITH

        *-- Linha (direita)
        THIS.AddObject("lbl_4c_Linha", "Label")
        WITH THIS.lbl_4c_Linha
            .Top       = 92
            .Left      = 503
            .Width     = 34
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Linha :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Lini", "TextBox")
        WITH THIS.txt_4c_Lini
            .Top           = 88
            .Left          = 539
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .Format        = "K"
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_LinhaAte", "Label")
        WITH THIS.lbl_4c_LinhaAte
            .Top       = 92
            .Left      = 627
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Linf", "TextBox")
        WITH THIS.txt_4c_Linf
            .Top           = 88
            .Left          = 649
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .Format        = "K"
            .Value         = ""
        ENDWITH

        *-- Grande Grupo (esquerda)
        THIS.AddObject("lbl_4c_GrGrupo", "Label")
        WITH THIS.lbl_4c_GrGrupo
            .Top       = 117
            .Left      = 67
            .Width     = 76
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grande Grupo :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_MercI", "TextBox")
        WITH THIS.txt_4c_MercI
            .Top           = 113
            .Left          = 145
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_GrGrupoAte", "Label")
        WITH THIS.lbl_4c_GrGrupoAte
            .Top       = 117
            .Left      = 179
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_MercF", "TextBox")
        WITH THIS.txt_4c_MercF
            .Top           = 113
            .Left          = 198
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Grupo Venda/Colecao (direita)
        THIS.AddObject("lbl_4c_GrupoVenda", "Label")
        WITH THIS.lbl_4c_GrupoVenda
            .Top       = 117
            .Left      = 466
            .Width     = 71
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo Venda :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Coli", "TextBox")
        WITH THIS.txt_4c_Coli
            .Top           = 113
            .Left          = 539
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .Format        = "K"
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_ColiAte", "Label")
        WITH THIS.lbl_4c_ColiAte
            .Top       = 117
            .Left      = 627
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Colf", "TextBox")
        WITH THIS.txt_4c_Colf
            .Top           = 113
            .Left          = 649
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 10
            .SpecialEffect = 1
            .Format        = "K"
            .Value         = ""
        ENDWITH

        *-- Grupo (esquerda)
        THIS.AddObject("lbl_4c_Grupo", "Label")
        WITH THIS.lbl_4c_Grupo
            .Top       = 142
            .Left      = 105
            .Width     = 38
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Grupo :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CGrui", "TextBox")
        WITH THIS.txt_4c_CGrui
            .Top           = 138
            .Left          = 145
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_GrupoAte", "Label")
        WITH THIS.lbl_4c_GrupoAte
            .Top       = 142
            .Left      = 179
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CGruf", "TextBox")
        WITH THIS.txt_4c_CGruf
            .Top           = 138
            .Left          = 198
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Markup (direita)
        THIS.AddObject("lbl_4c_Markup", "Label")
        WITH THIS.lbl_4c_Markup
            .Top       = 142
            .Left      = 493
            .Width     = 44
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Markup :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Mrki", "TextBox")
        WITH THIS.txt_4c_Mrki
            .Top           = 138
            .Left          = 539
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        THIS.AddObject("lbl_4c_MarkupAte", "Label")
        WITH THIS.lbl_4c_MarkupAte
            .Top       = 142
            .Left      = 627
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Mrkf", "TextBox")
        WITH THIS.txt_4c_Mrkf
            .Top           = 138
            .Left          = 649
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        *-- Subgrupo (esquerda)
        THIS.AddObject("lbl_4c_Subgrupo", "Label")
        WITH THIS.lbl_4c_Subgrupo
            .Top       = 167
            .Left      = 88
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Subgrupo :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_SgruI", "TextBox")
        WITH THIS.txt_4c_SgruI
            .Top           = 163
            .Left          = 145
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_SubgrupoAte", "Label")
        WITH THIS.lbl_4c_SubgrupoAte
            .Top       = 167
            .Left      = 201
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_SgruF", "TextBox")
        WITH THIS.txt_4c_SgruF
            .Top           = 163
            .Left          = 220
            .Width         = 52
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 6
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Encargo (direita)
        THIS.AddObject("lbl_4c_EncFiltro", "Label")
        WITH THIS.lbl_4c_EncFiltro
            .Top       = 167
            .Left      = 486
            .Width     = 51
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Encargo :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_EncI", "TextBox")
        WITH THIS.txt_4c_EncI
            .Top           = 163
            .Left          = 539
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        THIS.AddObject("lbl_4c_EncAte", "Label")
        WITH THIS.lbl_4c_EncAte
            .Top       = 167
            .Left      = 627
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_EncF", "TextBox")
        WITH THIS.txt_4c_EncF
            .Top           = 163
            .Left          = 649
            .Width         = 84
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        *-- Unidade (esquerda)
        THIS.AddObject("lbl_4c_Unidade", "Label")
        WITH THIS.lbl_4c_Unidade
            .Top       = 193
            .Left      = 95
            .Width     = 48
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Unidade :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CUnii", "TextBox")
        WITH THIS.txt_4c_CUnii
            .Top           = 189
            .Left          = 145
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_UnidadeAte", "Label")
        WITH THIS.lbl_4c_UnidadeAte
            .Top       = 193
            .Left      = 179
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_CUnif", "TextBox")
        WITH THIS.txt_4c_CUnif
            .Top           = 189
            .Left          = 198
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Variacao e Feitio (direita)
        THIS.AddObject("lbl_4c_Variacao", "Label")
        WITH THIS.lbl_4c_Variacao
            .Top       = 193
            .Left      = 456
            .Width     = 81
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Varia" + CHR(231) + CHR(227) + "o ( % ) : "
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Variacao", "TextBox")
        WITH THIS.txt_4c_Variacao
            .Top           = 189
            .Left          = 539
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .InputMask     = "999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        THIS.AddObject("lbl_4c_CodMKP", "Label")
        WITH THIS.lbl_4c_CodMKP
            .Top       = 193
            .Left      = 639
            .Width     = 68
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "C" + CHR(243) + "digo MKP : "
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Feitio", "TextBox")
        WITH THIS.txt_4c_Feitio
            .Top           = 189
            .Left          = 709
            .Width         = 24
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 2
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Tipo Moeda (centro)
        THIS.AddObject("opt_4c_TipoMoeda", "OptionGroup")
        WITH THIS.opt_4c_TipoMoeda
            .Top         = 211
            .Left        = 234
            .Width       = 106
            .Height      = 26
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            WITH .Buttons(1)
                .Caption  = "Ideal"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left     = 5
                .Top      = 5
                .AutoSize = .T.
                .Themes   = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "Venda"
                .FontName        = "Comic Sans MS"
                .Left     = 53
                .Top      = 6
                .AutoSize = .T.
                .FontSize = 8
                .Themes   = .F.
            ENDWITH
        ENDWITH

        *-- Moeda (esquerda)
        THIS.AddObject("lbl_4c_Moeda", "Label")
        WITH THIS.lbl_4c_Moeda
            .Top       = 217
            .Left      = 102
            .Width     = 41
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Moeda :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Moedai", "TextBox")
        WITH THIS.txt_4c_Moedai
            .Top           = 213
            .Left          = 145
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        THIS.AddObject("lbl_4c_MoedaAte", "Label")
        WITH THIS.lbl_4c_MoedaAte
            .Top       = 217
            .Left      = 179
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "at" + CHR(233)
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Moedaf", "TextBox")
        WITH THIS.txt_4c_Moedaf
            .Top           = 213
            .Left          = 198
            .Width         = 31
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 3
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Situacao (direita)
        THIS.AddObject("lbl_4c_Situacao", "Label")
        WITH THIS.lbl_4c_Situacao
            .Top       = 217
            .Left      = 486
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("opt_4c_Situacao", "OptionGroup")
        WITH THIS.opt_4c_Situacao
            .Top         = 214
            .Left        = 536
            .Width       = 189
            .Height      = 21
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            WITH .Buttons(1)
                .Caption       = "Ativos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left          = 5
                .Top           = 3
                .AutoSize      = .T.
                .SpecialEffect = 0
                .Themes        = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption       = "Inativos"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left          = 59
                .Top           = 2
                .AutoSize      = .F.
                .SpecialEffect = 0
                .Themes        = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption       = "Todos"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left          = 125
                .Top           = 2
                .Width         = 61
                .Height        = 17
                .AutoSize      = .F.
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .Themes        = .F.
            ENDWITH
        ENDWITH

        *-- Compra (direita)
        THIS.AddObject("lbl_4c_Compra", "Label")
        WITH THIS.lbl_4c_Compra
            .Top       = 237
            .Left      = 490
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Compra :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("opt_4c_Compra", "OptionGroup")
        WITH THIS.opt_4c_Compra
            .Top         = 234
            .Left        = 536
            .Width       = 204
            .Height      = 21
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 3

            WITH .Buttons(1)
                .Caption  = "Comprar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left     = 5
                .Top      = 3
                .AutoSize = .T.
                .Themes   = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "N" + CHR(227) + "o Comprar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left     = 67
                .Top      = 3
                .AutoSize = .T.
                .Themes   = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Todos"
                .WordWrap        = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left      = 152
                .Top       = 2
                .Width     = 61
                .Height    = 17
                .AutoSize  = .F.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarDados()
    *==========================================================================
        *-- Label secao Dados
        THIS.AddObject("lbl_4c_SecDados", "Label")
        WITH THIS.lbl_4c_SecDados
            .Top       = 270
            .Left      = 12
            .Width     = 52
            .Height    = 21
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 12
            .FontBold  = .T.
            .BackStyle = 0
            .Caption   = "Dados"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Recalcula (8 opcoes em 2 linhas)
        THIS.AddObject("lbl_4c_Recalcula", "Label")
        WITH THIS.lbl_4c_Recalcula
            .Top       = 263
            .Left      = 89
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Recalcula :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("opt_4c_Recalc", "OptionGroup")
        WITH THIS.opt_4c_Recalc
            .Top         = 258
            .Left        = 142
            .Width       = 439
            .Height      = 41
            .ButtonCount = 8
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            WITH .Buttons(1)
                .Caption   = "Composi" + CHR(231) + CHR(227) + "o"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left      = 5
                .Top       = 5
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption   = "Custo Venda"
                .Left      = 98
                .Top       = 5
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(3)
                .Caption   = "Ambos"
                .WordWrap        = .T.
                .Left      = 213
                .Top       = 5
                .Width     = 50
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(4)
                .Caption   = "Peso Componentes"
                .WordWrap        = .T.
                .Left      = 312
                .Top       = 4
                .Width     = 110
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(5)
                .Caption   = "C" + CHR(226) + "mbio"
                .Left      = 5
                .Top       = 23
                .Width     = 53
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(6)
                .Caption   = "C" + CHR(226) + "mbio (Inteiros)"
                .Left      = 98
                .Top       = 23
                .Width     = 101
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
            WITH .Buttons(7)
                .Caption       = "Markup Custo"
                .Left          = 213
                .Top           = 23
                .Width         = 84
                .Height        = 15
                .AutoSize      = .T.
                .FontName      = "Comic Sans MS"
                .FontSize      = 8
                .BackStyle     = 0
                .SpecialEffect = 0
                .ForeColor     = RGB(90, 90, 90)
                .Themes        = .F.
            ENDWITH
            WITH .Buttons(8)
                .Caption   = "Markup Venda"
                .Left      = 312
                .Top       = 22
                .Width     = 86
                .Height    = 15
                .AutoSize  = .T.
                .FontName  = "Comic Sans MS"
                .FontSize  = 8
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .Themes    = .F.
            ENDWITH
        ENDWITH

        *-- Reajuste
        THIS.AddObject("lbl_4c_Reajuste", "Label")
        WITH THIS.lbl_4c_Reajuste
            .Top       = 304
            .Left      = 91
            .Width     = 52
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Reajuste :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Reajuste", "TextBox")
        WITH THIS.txt_4c_Reajuste
            .Top           = 300
            .Left          = 148
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999.999"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        *-- Novo Encargo
        THIS.AddObject("lbl_4c_NovoEncargo", "Label")
        WITH THIS.lbl_4c_NovoEncargo
            .Top       = 304
            .Left      = 245
            .Width     = 79
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo Encargo : "
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_Encargo", "TextBox")
        WITH THIS.txt_4c_Encargo
            .Top           = 300
            .Left          = 326
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        *-- Atualiza Val.Venda
        THIS.AddObject("lbl_4c_AtuVenda", "Label")
        WITH THIS.lbl_4c_AtuVenda
            .Top       = 304
            .Left      = 448
            .Width     = 98
            .Height    = 15
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Atualiza Val.Venda :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("opt_4c_Pven", "OptionGroup")
        WITH THIS.opt_4c_Pven
            .Top         = 298
            .Left        = 544
            .Width       = 102
            .Height      = 27
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .AutoSize    = .F.
            .Value       = 2

            WITH .Buttons(1)
                .Caption  = "Sim"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left     = 5
                .Top      = 5
                .AutoSize = .T.
                .Themes   = .F.
            ENDWITH
            WITH .Buttons(2)
                .Caption  = "N" + CHR(227) + "o"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Left     = 53
                .Top      = 5
                .Width    = 44
                .Height   = 17
                .AutoSize = .F.
                .Themes   = .F.
            ENDWITH
        ENDWITH

        *-- Novo Markup
        THIS.AddObject("lbl_4c_NovoMarkup", "Label")
        WITH THIS.lbl_4c_NovoMarkup
            .Top       = 330
            .Left      = 71
            .Width     = 72
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo Markup :"
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_NMrk", "TextBox")
        WITH THIS.txt_4c_NMrk
            .Top           = 326
            .Left          = 148
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Alignment     = 3
            .SpecialEffect = 1
            .InputMask     = "999,999.99"
            .Format        = "K"
            .Value         = 0
        ENDWITH

        *-- Novo MKP
        THIS.AddObject("lbl_4c_NovoMkp", "Label")
        WITH THIS.lbl_4c_NovoMkp
            .Top       = 330
            .Left      = 264
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Caption   = "Novo MKP : "
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        THIS.AddObject("txt_4c_NewMkp", "TextBox")
        WITH THIS.txt_4c_NewMkp
            .Top           = 326
            .Left          = 326
            .Width         = 24
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .MaxLength     = 2
            .SpecialEffect = 1
            .Value         = ""
        ENDWITH

        *-- Imagem do produto (inicia oculta)
        THIS.AddObject("img_4c_Produto", "Image")
        WITH THIS.img_4c_Produto
            .Top     = 128
            .Left    = 764
            .Width   = 223
            .Height  = 190
            .Stretch = 1
            .Visible = .F.
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrade()
    *==========================================================================
        THIS.AddObject("grd_4c_Produto", "Grid")
        THIS.grd_4c_Produto.ColumnCount  = 9
        THIS.grd_4c_Produto.RecordSource = "cursor_4c_Produtos"
        WITH THIS.grd_4c_Produto
            .Top          = 351
            .Left         = 12
            .Width        = 935
            .Height       = 244
            .FontName     = "Tahoma"
            .FontSize     = 8
            .RowHeight    = 18
            .ScrollBars   = 2
            .ReadOnly     = .F.

            *-- Column1: CheckBox lMarca
            WITH .Column1
                .Width        = 17
                .HeaderHeight       = 0
                .Alignment    = 3
                .Movable      = .F.
                .Resizable    = .F.
                .Sparse       = .F.
                .FontName     = "Tahoma"
                .FontSize     = 8
                .AddObject("Check1", "CheckBox")
                .Check1.Caption = ""
                .Check1.Value   = 0
                .CurrentControl = "Check1"
                .ControlSource  = "cursor_4c_Produtos.lMarca"
                WITH .Header1
                    .Caption   = ""
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column2: CPros
            WITH .Column2
                .Width         = 108
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "cursor_4c_Produtos.CPros"
                WITH .Header1
                    .Caption   = "Produto"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column3: DPros
            WITH .Column3
                .Width         = 290
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .ControlSource = "cursor_4c_Produtos.DPros"
                WITH .Header1
                    .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column4: ValAnt
            WITH .Column4
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999,999.99"
                .ControlSource = "cursor_4c_Produtos.ValAnt"
                WITH .Header1
                    .Caption   = "Venda Ant."
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column5: ValAtu
            WITH .Column5
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999,999.99"
                .ControlSource = "cursor_4c_Produtos.ValAtu"
                WITH .Header1
                    .Caption   = "Venda Atual"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column6: PVarias (ReadOnly)
            WITH .Column6
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999.99"
                .ControlSource = "cursor_4c_Produtos.PVarias"
                WITH .Header1
                    .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                    .ForeColor = RGB(36, 84, 155)
                ENDWITH
            ENDWITH

            *-- Column7: CustoAfs (ReadOnly)
            WITH .Column7
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999,999.9999"
                .ControlSource = "cursor_4c_Produtos.CustoAfs"
                WITH .Header1
                    .Caption   = "Custo Ant."
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
            ENDWITH

            *-- Column8: CustoFs (ReadOnly)
            WITH .Column8
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999,999.9999"
                .ControlSource = "cursor_4c_Produtos.CustoFs"
                WITH .Header1
                    .Caption   = "Custo Atual"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
            ENDWITH

            *-- Column9: CVarias (ReadOnly)
            WITH .Column9
                .Width         = 80
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 8
                .InputMask     = "999,999.99"
                .ControlSource = "cursor_4c_Produtos.CVarias"
                WITH .Header1
                    .Caption   = "Varia" + CHR(231) + CHR(227) + "o (%)"
                    .FontName  = "Tahoma"
                    .FontSize  = 8
                    .Alignment = 2
                ENDWITH
            ENDWITH
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ReconfigurarGrade()
    *==========================================================================
        WITH THIS.grd_4c_Produto
            .RecordSource          = "cursor_4c_Produtos"
            .Column1.ControlSource = "cursor_4c_Produtos.lMarca"
            .Column2.ControlSource = "cursor_4c_Produtos.CPros"
            .Column3.ControlSource = "cursor_4c_Produtos.DPros"
            .Column4.ControlSource = "cursor_4c_Produtos.ValAnt"
            .Column5.ControlSource = "cursor_4c_Produtos.ValAtu"
            .Column6.ControlSource = "cursor_4c_Produtos.PVarias"
            .Column7.ControlSource = "cursor_4c_Produtos.CustoAfs"
            .Column8.ControlSource = "cursor_4c_Produtos.CustoFs"
            .Column9.ControlSource = "cursor_4c_Produtos.CVarias"
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF INLIST(UPPER(loc_oControl.Name), "IMG_4C_PRODUTO")
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF
            loc_oControl.Visible = .T.
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *==========================================================================
        WITH THIS.this_oBusinessObject
            .this_cCFornecs    = ALLTRIM(THIS.txt_4c_CFornecs.Value)
            .this_cMercI       = ALLTRIM(THIS.txt_4c_MercI.Value)
            .this_cMercF       = ALLTRIM(THIS.txt_4c_MercF.Value)
            .this_cCGrui       = ALLTRIM(THIS.txt_4c_CGrui.Value)
            .this_cCGruf       = ALLTRIM(THIS.txt_4c_CGruf.Value)
            .this_cSGruI       = ALLTRIM(THIS.txt_4c_SgruI.Value)
            .this_cSGruF       = ALLTRIM(THIS.txt_4c_SgruF.Value)
            .this_cCUniI       = ALLTRIM(THIS.txt_4c_CUnii.Value)
            .this_cCUnif       = ALLTRIM(THIS.txt_4c_CUnif.Value)
            .this_cLini        = ALLTRIM(THIS.txt_4c_Lini.Value)
            .this_cLinf        = ALLTRIM(THIS.txt_4c_Linf.Value)
            .this_cColi        = ALLTRIM(THIS.txt_4c_Coli.Value)
            .this_cColf        = ALLTRIM(THIS.txt_4c_Colf.Value)
            .this_cMoedai      = ALLTRIM(THIS.txt_4c_Moedai.Value)
            .this_cMoedaf      = ALLTRIM(THIS.txt_4c_Moedaf.Value)
            .this_nOpcMoedaTp  = THIS.opt_4c_TipoMoeda.Value
            .this_nMrki        = THIS.txt_4c_Mrki.Value
            .this_nMrkf        = THIS.txt_4c_Mrkf.Value
            .this_nEnci        = THIS.txt_4c_EncI.Value
            .this_nEncf        = THIS.txt_4c_EncF.Value
            .this_nVariacao    = THIS.txt_4c_Variacao.Value
            .this_cFeitio      = ALLTRIM(THIS.txt_4c_Feitio.Value)
            .this_nOpcSituacao = THIS.opt_4c_Situacao.Value
            .this_nOpcRecalc   = THIS.opt_4c_Recalc.Value
            .this_nReajuste    = THIS.txt_4c_Reajuste.Value
            .this_nEncargo     = THIS.txt_4c_Encargo.Value
            .this_nNMrk        = THIS.txt_4c_NMrk.Value
            .this_nOpcPven     = THIS.opt_4c_Pven.Value
            .this_cNewMkp      = ALLTRIM(THIS.txt_4c_NewMkp.Value)
            .this_nOpcCompra   = THIS.opt_4c_Compra.Value
        ENDWITH
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    *==========================================================================
        THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
        THIS.cmd_4c_Imprimir.Enabled          = .F.
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Reseta form OPERACIONAL ao estado inicial
    * Form OPERACIONAL de layout plano: mapeia "Pagina Lista" para
    * "estado inicial de sele" + CHR(231) + CHR(227) + "o de filtros" (equivalente
    * a limpar filtros, resetar op" + CHR(231) + CHR(245) + "es, zerar grid de
    * produtos e devolver o foco para o primeiro campo de filtro).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro
        TRY
            *-- Zera cursor de produtos (grid principal)
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                ZAP
            ENDIF

            *-- Limpa filtros (textboxes de sele" + CHR(231) + CHR(227) + "o)
            THIS.txt_4c_CFornecs.Value = ""
            THIS.txt_4c_DFornecs.Value = ""
            THIS.txt_4c_MercI.Value    = ""
            THIS.txt_4c_MercF.Value    = ""
            THIS.txt_4c_CGrui.Value    = ""
            THIS.txt_4c_CGruf.Value    = ""
            THIS.txt_4c_SgruI.Value    = ""
            THIS.txt_4c_SgruF.Value    = ""
            THIS.txt_4c_CUnii.Value    = ""
            THIS.txt_4c_CUnif.Value    = ""
            THIS.txt_4c_Lini.Value     = ""
            THIS.txt_4c_Linf.Value     = ""
            THIS.txt_4c_Coli.Value     = ""
            THIS.txt_4c_Colf.Value     = ""
            THIS.txt_4c_Moedai.Value   = ""
            THIS.txt_4c_Moedaf.Value   = ""
            THIS.txt_4c_Mrki.Value     = 0
            THIS.txt_4c_Mrkf.Value     = 0
            THIS.txt_4c_EncI.Value     = 0
            THIS.txt_4c_EncF.Value     = 0

            *-- Reseta campos de recalculo
            THIS.txt_4c_Reajuste.Value = 0
            THIS.txt_4c_NMrk.Value     = 0
            THIS.txt_4c_Variacao.Value = 0
            THIS.txt_4c_NewMkp.Value   = ""
            THIS.txt_4c_Feitio.Value   = ""
            THIS.txt_4c_Encargo.Value  = 0

            *-- Reseta OptionGroups aos valores default
            THIS.opt_4c_Recalc.Value   = 1
            THIS.opt_4c_Pven.Value     = 2
            THIS.opt_4c_Compra.Value   = 3
            THIS.opt_4c_Situacao.Value = 1

            *-- Oculta imagem de produto (aparece apenas ao selecionar linha)
            THIS.img_4c_Produto.Visible = .F.
            THIS.img_4c_Produto.Picture = ""

            *-- Reseta estado dos botoes (Processar habilitado, Atualizar/Imprimir desabilitados)
            THIS.AjustarBotoesPorModo()

            *-- Recalcula habilitacao condicional (Reajuste/NMrk/Variacao/NewMkp)
            THIS.OptRecalcChange()

            *-- Foco inicial no primeiro filtro
            THIS.txt_4c_CFornecs.SetFocus()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna o "modo de trabalho" do form OPERACIONAL
    * Form OPERACIONAL de layout plano: n" + CHR(227) + "o h" + CHR(225) + ;
    * " PageFrame; este metodo mapeia "alternar pagina" para "alternar contexto".
    *   par_nPagina = 1 -> LISTA/FILTROS (foco no primeiro filtro, reseta form)
    *   par_nPagina = 2 -> DADOS/GRID    (foco no grid de produtos apos processar)
    *   par_nPagina = 0 -> reset completo (equivale a ConfigurarPaginaLista)
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oErro
        loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)

        TRY
            DO CASE
                CASE loc_nPagina = 1
                    *-- Modo LISTA/FILTROS: foco no primeiro campo, botoes iniciais
                    THIS.AjustarBotoesPorModo()
                    THIS.txt_4c_CFornecs.SetFocus()
                CASE loc_nPagina = 2
                    *-- Modo DADOS/GRID: foco no grid apos processamento
                    IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
                        SELECT cursor_4c_Produtos
                        SET ORDER TO CPros
                        GO TOP
                        THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                        THIS.cmd_4c_Imprimir.Enabled          = .T.
                        THIS.grd_4c_Produto.SetFocus()
                    ELSE
                        MsgAviso("Nenhum produto para exibir. Execute o processamento primeiro.")
                        THIS.txt_4c_CFornecs.SetFocus()
                    ENDIF
                OTHERWISE
                    THIS.ConfigurarPaginaLista()
            ENDCASE

            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE OptRecalcChange()
    *==========================================================================
        LOCAL loc_nOpcRec
        loc_nOpcRec = THIS.opt_4c_Recalc.Value
        THIS.txt_4c_Reajuste.Enabled = (loc_nOpcRec <> 2)
        THIS.txt_4c_NMrk.Enabled     = (THIS.txt_4c_Reajuste.Value = 0) AND (loc_nOpcRec <> 2)
        THIS.txt_4c_Variacao.Enabled = (THIS.txt_4c_Reajuste.Value = 0) AND (loc_nOpcRec <> 2)
        THIS.txt_4c_NewMkp.Enabled   = INLIST(loc_nOpcRec, 7, 8)
        THIS.txt_4c_Reajuste.Refresh()
        THIS.txt_4c_NMrk.Refresh()
        THIS.txt_4c_Variacao.Refresh()
        THIS.txt_4c_NewMkp.Refresh()
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia nova sessao de recalculo de precos
    *   Semantica OPERACIONAL: equivale a "novo lote". Descarta resultado
    *   anterior (cursor de produtos), reseta todos os filtros e opcoes ao
    *   estado inicial e devolve o foco ao primeiro filtro (Fornecedor).
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
                IF !MsgConfirma("Existem dados processados. Descartar e iniciar novo rec" + ;
                                CHR(225) + "lculo?", ;
                                "Confirma" + CHR(231) + CHR(227) + "o")
                    RETURN
                ENDIF
            ENDIF

            *-- Reset completo do form (limpa filtros, zera cursor, reseta UI)
            THIS.ConfigurarPaginaLista()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Executa recalculo de precos com filtros atuais
    *   Semantica OPERACIONAL: equivale a "alterar" (aplicar novo calculo)
    *   sobre os produtos que atendem aos filtros. Delega para o fluxo de
    *   processamento (Processar do BO) para preencher o grid com os precos
    *   propostos. A gravacao definitiva no banco ocorre em BtnAtualizarClick.
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            *-- Delega para o fluxo de processamento (mesma logica do botao Processar)
            THIS.BtnProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Exibe detalhes/imagem do produto selecionado
    *   Semantica OPERACIONAL: equivale a "consultar registro". Exige que ja
    *   exista resultado processado no grid e uma linha selecionada; abre a
    *   figura do produto via GrdAfterRowColChange (mesma logica do click do
    *   ImgProduto no legado).
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
                MsgAviso("Nenhum produto processado. Execute o rec" + CHR(225) + ;
                         "lculo antes de visualizar.", "Aviso")
                RETURN
            ENDIF

            SELECT cursor_4c_Produtos
            IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
                MsgAviso("Selecione um produto no grid para visualizar.", "Aviso")
                THIS.grd_4c_Produto.SetFocus()
                RETURN
            ENDIF

            *-- Renderiza figura do produto corrente (mesma logica do AfterRowColChange)
            THIS.GrdAfterRowColChange(1)
            THIS.img_4c_Produto.Visible = .T.
            THIS.img_4c_Produto.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Remove produto(s) do resultado corrente do recalculo
    *   Semantica OPERACIONAL: NAO exclui da tabela SigCdPro (fluxo de recalculo
    *   nao altera cadastro). Remove do cursor de trabalho a(s) linha(s)
    *   marcada(s) (lMarca = 1) ou apenas a linha corrente se nenhuma estiver
    *   marcada. Assim o usuario refina o conjunto antes de gravar via Atualizar.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_nMarcados, loc_cCodPro, loc_oErro
        TRY
            IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
                MsgAviso("Nenhum produto processado para remover.", "Aviso")
                RETURN
            ENDIF

            SELECT cursor_4c_Produtos
            COUNT FOR lMarca = 1 TO loc_nMarcados

            IF loc_nMarcados > 0
                IF !MsgConfirma("Remover " + TRANSFORM(loc_nMarcados) + ;
                                " produto(s) marcado(s) do rec" + CHR(225) + ;
                                "lculo?", ;
                                "Confirma" + CHR(231) + CHR(227) + "o")
                    RETURN
                ENDIF
                SELECT cursor_4c_Produtos
                DELETE FOR lMarca = 1
                PACK
            ELSE
                IF EOF() OR EMPTY(cursor_4c_Produtos.CPros)
                    MsgAviso("Selecione um produto no grid ou marque na primeira coluna.", ;
                             "Aviso")
                    THIS.grd_4c_Produto.SetFocus()
                    RETURN
                ENDIF
                loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
                IF !MsgConfirma("Remover o produto " + loc_cCodPro + ;
                                " do rec" + CHR(225) + "lculo?", ;
                                "Confirma" + CHR(231) + CHR(227) + "o")
                    RETURN
                ENDIF
                SELECT cursor_4c_Produtos
                DELETE
                PACK
            ENDIF

            *-- Se cursor ficou vazio, desabilita Atualizar/Imprimir
            IF RECCOUNT("cursor_4c_Produtos") = 0
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
                THIS.cmd_4c_Imprimir.Enabled          = .F.
                THIS.img_4c_Produto.Visible           = .F.
                THIS.img_4c_Produto.Picture           = ""
            ENDIF

            THIS.grd_4c_Produto.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnProcessarClick()
    *==========================================================================
        LOCAL loc_lSucesso, loc_nVaria, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
                IF !MsgConfirma("Existem Dados Gerados. Deseja Reprocessar?")
                    RETURN
                ENDIF
            ENDIF
            ZAP IN cursor_4c_Produtos

            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Processar()
                loc_nVaria = THIS.txt_4c_Variacao.Value
                SELECT cursor_4c_Produtos
                IF loc_nVaria > 0
                    DELETE FOR PVarias < loc_nVaria
                ENDIF
                IF loc_nVaria < 0
                    DELETE FOR PVarias > loc_nVaria
                ENDIF
                SET ORDER TO CPros
                GO TOP
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Refresh()
                THIS.cmd_4c_Imprimir.Enabled = .T.
                THIS.cmd_4c_Imprimir.Refresh()
                THIS.ReconfigurarGrade()
                THIS.grd_4c_Produto.Column1.SetFocus()
                THIS.grd_4c_Produto.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnProcessarClick")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAtualizarClick()
    *==========================================================================
        LOCAL loc_lImpEtiq, loc_oErro
        TRY
            loc_lImpEtiq = MsgConfirma("Confirma a Impress" + CHR(227) + "o das Etiquetas?")
            IF THIS.this_oBusinessObject.AtualizarPrecos(loc_lImpEtiq)
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .F.
                THIS.cmd_4c_Imprimir.Enabled = .F.
                THIS.grd_4c_Produto.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnAtualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnImprimirClick()
    *==========================================================================
        LOCAL loc_oForm, loc_oErro
        TRY
            loc_oForm = CREATEOBJECT("FormSIGPRCCR")
            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ELSE
                MsgErro("Erro ao abrir impress" + CHR(227) + "o de pre" + CHR(231) + "os." + ;
                    CHR(13) + "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSelTudoClick()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            UPDATE cursor_4c_Produtos SET lMarca = 1
            THIS.grd_4c_Produto.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnSelTudoClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnDesmarcarClick()
    *==========================================================================
        LOCAL loc_oErro
        TRY
            UPDATE cursor_4c_Produtos SET lMarca = 0
            THIS.grd_4c_Produto.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnDesmarcarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE GrdAfterRowColChange(par_nColIndex)
    *==========================================================================
        LOCAL loc_cArquivo, loc_cCodPro, loc_cSQL, loc_cFoto, loc_oErro
        TRY
            IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
                RETURN
            ENDIF
            loc_cArquivo = SYS(2023) + "\TempCj.jpg"
            SELECT cursor_4c_Produtos
            loc_cCodPro = ALLTRIM(cursor_4c_Produtos.CPros)
            loc_cSQL    = "SELECT FigJpgs FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cCodPro)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFig") < 1
                THIS.img_4c_Produto.Visible = .F.
                RETURN
            ENDIF
            SELECT cursor_4c_TmpFig
            THIS.img_4c_Produto.Visible  = .F.
            THIS.img_4c_Produto.Picture  = ""
            IF !ISNULL(cursor_4c_TmpFig.FigJpgs) AND !EMPTY(cursor_4c_TmpFig.FigJpgs)
                loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_TmpFig.FigJpgs, ;
                    "data:image/png;base64,", ""), "data:image/jpeg;base64,", ""), ;
                    "data:image/jpg;base64,", ""), 14)
                STRTOFILE(loc_cFoto, loc_cArquivo)
                THIS.img_4c_Produto.Picture = loc_cArquivo
                THIS.img_4c_Produto.Visible = .T.
            ENDIF
            IF USED("cursor_4c_TmpFig")
                USE IN cursor_4c_TmpFig
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpFig")
                USE IN cursor_4c_TmpFig
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro GrdAfterRowColChange")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Fornecedor ====
    PROCEDURE TxtCFornecKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cVal, loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            loc_cVal = ALLTRIM(THIS.txt_4c_CFornecs.Value)
            IF EMPTY(loc_cVal)
                THIS.txt_4c_DFornecs.Value = ""
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                       EscaparSQL(loc_cVal), "cursor_4c_TmpFor") > 0
                SELECT cursor_4c_TmpFor
                IF !EOF("cursor_4c_TmpFor")
                    THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_TmpFor.IClis)
                    THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_TmpFor.RClis)
                    USE IN cursor_4c_TmpFor
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpFor
            ENDIF
            THIS.AbrirBuscaFornecedor()
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpFor")
                USE IN cursor_4c_TmpFor
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtCFornecKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaFornecedor()
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(THIS.txt_4c_CFornecs.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaFor", "IClis", loc_cVal, "Fornecedores")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("RClis", "", "Nome")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaFor")
                    THIS.txt_4c_CFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.IClis)
                    THIS.txt_4c_DFornecs.Value = ALLTRIM(cursor_4c_BuscaFor.RClis)
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaFor")
                USE IN cursor_4c_BuscaFor
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaFor")
                USE IN cursor_4c_BuscaFor
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaFornecedor")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Grande Grupo ====
    PROCEDURE TxtMercIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_MercI.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_MercI.Value)), "cursor_4c_TmpGGr") > 0
                SELECT cursor_4c_TmpGGr
                IF !EOF("cursor_4c_TmpGGr")
                    THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
                    USE IN cursor_4c_TmpGGr
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpGGr
            ENDIF
            THIS.AbrirBuscaGrandeGrupo(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpGGr")
                USE IN cursor_4c_TmpGGr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtMercIKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtMercFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_MercF.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descs FROM SigCdGpr WHERE Codigos = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_MercF.Value)), "cursor_4c_TmpGGr") > 0
                SELECT cursor_4c_TmpGGr
                IF !EOF("cursor_4c_TmpGGr")
                    THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_TmpGGr.Codigos)
                    USE IN cursor_4c_TmpGGr
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpGGr
            ENDIF
            THIS.AbrirBuscaGrandeGrupo(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpGGr")
                USE IN cursor_4c_TmpGGr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtMercFKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrandeGrupo(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal = ALLTRIM(IIF(par_lIni, THIS.txt_4c_MercI.Value, THIS.txt_4c_MercF.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGpr", "cursor_4c_BuscaGGr", "Codigos", loc_cVal, "Grande Grupo")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaGGr")
                    IF par_lIni
                        THIS.txt_4c_MercI.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
                    ELSE
                        THIS.txt_4c_MercF.Value = ALLTRIM(cursor_4c_BuscaGGr.Codigos)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaGGr")
                USE IN cursor_4c_BuscaGGr
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaGGr")
                USE IN cursor_4c_BuscaGGr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaGrandeGrupo")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Grupo ====
    PROCEDURE TxtCGruiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_CGrui.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_CGrui.Value)), "cursor_4c_TmpGrp") > 0
                SELECT cursor_4c_TmpGrp
                IF !EOF("cursor_4c_TmpGrp")
                    THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
                    USE IN cursor_4c_TmpGrp
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpGrp
            ENDIF
            THIS.AbrirBuscaGrupo(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpGrp")
                USE IN cursor_4c_TmpGrp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtCGruiKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtCGrufKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_CGruf.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CGrus, DGrus FROM SigCdGrp WHERE CGrus = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_CGruf.Value)), "cursor_4c_TmpGrp") > 0
                SELECT cursor_4c_TmpGrp
                IF !EOF("cursor_4c_TmpGrp")
                    THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_TmpGrp.CGrus)
                    USE IN cursor_4c_TmpGrp
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpGrp
            ENDIF
            THIS.AbrirBuscaGrupo(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpGrp")
                USE IN cursor_4c_TmpGrp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtCGrufKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaGrupo(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_CGrui.Value, THIS.txt_4c_CGruf.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cVal, "Grupos")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaGrp")
                    IF par_lIni
                        THIS.txt_4c_CGrui.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                    ELSE
                        THIS.txt_4c_CGruf.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaGrp")
                USE IN cursor_4c_BuscaGrp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaGrupo")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Subgrupo ====
    PROCEDURE TxtSgruIKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_SgruI.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_SgruI.Value)), "cursor_4c_TmpSgr") > 0
                SELECT cursor_4c_TmpSgr
                IF !EOF("cursor_4c_TmpSgr")
                    THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
                    USE IN cursor_4c_TmpSgr
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpSgr
            ENDIF
            THIS.AbrirBuscaSubgrupo(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpSgr")
                USE IN cursor_4c_TmpSgr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtSgruIKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtSgruFKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_SgruF.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_SgruF.Value)), "cursor_4c_TmpSgr") > 0
                SELECT cursor_4c_TmpSgr
                IF !EOF("cursor_4c_TmpSgr")
                    THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_TmpSgr.Codigos)
                    USE IN cursor_4c_TmpSgr
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpSgr
            ENDIF
            THIS.AbrirBuscaSubgrupo(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpSgr")
                USE IN cursor_4c_TmpSgr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtSgruFKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaSubgrupo(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_SgruI.Value, THIS.txt_4c_SgruF.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPsg", "cursor_4c_BuscaSgr", "Codigos", loc_cVal, "Subgrupos")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaSgr")
                    IF par_lIni
                        THIS.txt_4c_SgruI.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
                    ELSE
                        THIS.txt_4c_SgruF.Value = ALLTRIM(cursor_4c_BuscaSgr.Codigos)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaSgr")
                USE IN cursor_4c_BuscaSgr
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaSgr")
                USE IN cursor_4c_BuscaSgr
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaSubgrupo")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Unidade ====
    PROCEDURE TxtCUniiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_CUnii.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_CUnii.Value)), "cursor_4c_TmpUni") > 0
                SELECT cursor_4c_TmpUni
                IF !EOF("cursor_4c_TmpUni")
                    THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
                    USE IN cursor_4c_TmpUni
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpUni
            ENDIF
            THIS.AbrirBuscaUnidade(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpUni")
                USE IN cursor_4c_TmpUni
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtCUniiKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtCUnifKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_CUnif.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CUnis, DUnis FROM SigCdUni WHERE CUnis = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_CUnif.Value)), "cursor_4c_TmpUni") > 0
                SELECT cursor_4c_TmpUni
                IF !EOF("cursor_4c_TmpUni")
                    THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_TmpUni.CUnis)
                    USE IN cursor_4c_TmpUni
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpUni
            ENDIF
            THIS.AbrirBuscaUnidade(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpUni")
                USE IN cursor_4c_TmpUni
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtCUnifKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaUnidade(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_CUnii.Value, THIS.txt_4c_CUnif.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUni", "cursor_4c_BuscaUni", "CUnis", loc_cVal, "Unidades")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaUni")
                    IF par_lIni
                        THIS.txt_4c_CUnii.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
                    ELSE
                        THIS.txt_4c_CUnif.Value = ALLTRIM(cursor_4c_BuscaUni.CUnis)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaUni")
                USE IN cursor_4c_BuscaUni
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaUni")
                USE IN cursor_4c_BuscaUni
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaUnidade")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Linha ====
    PROCEDURE TxtLiniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Lini.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Lini.Value)), "cursor_4c_TmpLin") > 0
                SELECT cursor_4c_TmpLin
                IF !EOF("cursor_4c_TmpLin")
                    THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
                    USE IN cursor_4c_TmpLin
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpLin
            ENDIF
            THIS.AbrirBuscaLinha(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpLin")
                USE IN cursor_4c_TmpLin
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtLiniKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtLinfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Linf.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Linf.Value)), "cursor_4c_TmpLin") > 0
                SELECT cursor_4c_TmpLin
                IF !EOF("cursor_4c_TmpLin")
                    THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_TmpLin.Linhas)
                    USE IN cursor_4c_TmpLin
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpLin
            ENDIF
            THIS.AbrirBuscaLinha(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpLin")
                USE IN cursor_4c_TmpLin
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtLinfKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaLinha(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Lini.Value, THIS.txt_4c_Linf.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdLin", "cursor_4c_BuscaLin", "Linhas", loc_cVal, "Linhas")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Linhas", "", "Linha")
                loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaLin")
                    IF par_lIni
                        THIS.txt_4c_Lini.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
                    ELSE
                        THIS.txt_4c_Linf.Value = ALLTRIM(cursor_4c_BuscaLin.Linhas)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaLin")
                USE IN cursor_4c_BuscaLin
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaLin")
                USE IN cursor_4c_BuscaLin
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaLinha")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Colecao ====
    PROCEDURE TxtColiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Coli.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Coli.Value)), "cursor_4c_TmpCol") > 0
                SELECT cursor_4c_TmpCol
                IF !EOF("cursor_4c_TmpCol")
                    THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
                    USE IN cursor_4c_TmpCol
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpCol
            ENDIF
            THIS.AbrirBuscaColecao(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpCol")
                USE IN cursor_4c_TmpCol
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtColiKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtColfKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Colf.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Colf.Value)), "cursor_4c_TmpCol") > 0
                SELECT cursor_4c_TmpCol
                IF !EOF("cursor_4c_TmpCol")
                    THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_TmpCol.Colecoes)
                    USE IN cursor_4c_TmpCol
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpCol
            ENDIF
            THIS.AbrirBuscaColecao(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpCol")
                USE IN cursor_4c_TmpCol
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtColfKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaColecao(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Coli.Value, THIS.txt_4c_Colf.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCol", "cursor_4c_BuscaCol", "Colecoes", loc_cVal, "Cole" + CHR(231) + CHR(245) + "es")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaCol")
                    IF par_lIni
                        THIS.txt_4c_Coli.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
                    ELSE
                        THIS.txt_4c_Colf.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaCol")
                USE IN cursor_4c_BuscaCol
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaColecao")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Moeda ====
    PROCEDURE TxtMoedaiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Moedai.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Moedai.Value)), "cursor_4c_TmpMoe") > 0
                SELECT cursor_4c_TmpMoe
                IF !EOF("cursor_4c_TmpMoe")
                    THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
                    USE IN cursor_4c_TmpMoe
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpMoe
            ENDIF
            THIS.AbrirBuscaMoeda(.T.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpMoe")
                USE IN cursor_4c_TmpMoe
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtMoedaiKeyPress")
        ENDTRY
    ENDPROC

    PROCEDURE TxtMoedafKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Moedaf.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Moedaf.Value)), "cursor_4c_TmpMoe") > 0
                SELECT cursor_4c_TmpMoe
                IF !EOF("cursor_4c_TmpMoe")
                    THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_TmpMoe.CMoes)
                    USE IN cursor_4c_TmpMoe
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpMoe
            ENDIF
            THIS.AbrirBuscaMoeda(.F.)
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpMoe")
                USE IN cursor_4c_TmpMoe
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtMoedafKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaMoeda(par_lIni)
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(IIF(par_lIni, THIS.txt_4c_Moedai.Value, THIS.txt_4c_Moedaf.Value))
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cVal, "Moedas")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaMoe")
                    IF par_lIni
                        THIS.txt_4c_Moedai.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                    ELSE
                        THIS.txt_4c_Moedaf.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaMoeda")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Feitio (Codigo MKP) ====
    PROCEDURE TxtFeitioKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_Feitio.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_Feitio.Value)), "cursor_4c_TmpFti") > 0
                SELECT cursor_4c_TmpFti
                IF !EOF("cursor_4c_TmpFti")
                    THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_TmpFti.Cods)
                    USE IN cursor_4c_TmpFti
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpFti
            ENDIF
            THIS.AbrirBuscaFeitio()
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpFti")
                USE IN cursor_4c_TmpFti
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtFeitioKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaFeitio()
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(THIS.txt_4c_Feitio.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrFti", "cursor_4c_BuscaFti", "Cods", loc_cVal, "Feitios")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Cods",  "", "Cod")
                loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaFti")
                    THIS.txt_4c_Feitio.Value = ALLTRIM(cursor_4c_BuscaFti.Cods)
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaFti")
                USE IN cursor_4c_BuscaFti
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaFti")
                USE IN cursor_4c_BuscaFti
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaFeitio")
        ENDTRY
    ENDPROC

    *-- ==== LOOKUP: Novo MKP ====
    PROCEDURE TxtNewMkpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oErro
        IF !INLIST(par_nKeyCode, 9, 13, 115)
            RETURN
        ENDIF
        TRY
            IF EMPTY(ALLTRIM(THIS.txt_4c_NewMkp.Value))
                RETURN
            ENDIF
            IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Cods, Descs FROM SigPrFti WHERE Cods = " + ;
                       EscaparSQL(ALLTRIM(THIS.txt_4c_NewMkp.Value)) + " AND Tipos = 1", "cursor_4c_TmpNMkp") > 0
                SELECT cursor_4c_TmpNMkp
                IF !EOF("cursor_4c_TmpNMkp")
                    THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_TmpNMkp.Cods)
                    USE IN cursor_4c_TmpNMkp
                    RETURN
                ENDIF
                USE IN cursor_4c_TmpNMkp
            ENDIF
            THIS.AbrirBuscaNewMkp()
        CATCH TO loc_oErro
            IF USED("cursor_4c_TmpNMkp")
                USE IN cursor_4c_TmpNMkp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro TxtNewMkpKeyPress")
        ENDTRY
    ENDPROC

    PROTECTED PROCEDURE AbrirBuscaNewMkp()
        LOCAL loc_cVal, loc_oForm, loc_oErro
        TRY
            loc_cVal  = ALLTRIM(THIS.txt_4c_NewMkp.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrFti WHERE Tipos = 1", "cursor_4c_BuscaNMkp", "Cods", loc_cVal, "Novo MKP")
            IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
                RETURN
            ENDIF
            IF !loc_oForm.this_lSelecionou
                loc_oForm.mAddColuna("Cods",  "", "Cod")
                loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
            ENDIF
            IF loc_oForm.this_lSelecionou
                IF USED("cursor_4c_BuscaNMkp")
                    THIS.txt_4c_NewMkp.Value = ALLTRIM(cursor_4c_BuscaNMkp.Cods)
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaNMkp")
                USE IN cursor_4c_BuscaNMkp
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            IF USED("cursor_4c_BuscaNMkp")
                USE IN cursor_4c_BuscaNMkp
            ENDIF
            MsgErro(loc_oErro.Message, "Erro AbrirBuscaNewMkp")
        ENDTRY
    ENDPROC

    *-- ==== Reajuste / NMrk exclusao mutua ====
    PROCEDURE TxtReajusteKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 9, 13)
            IF THIS.txt_4c_Reajuste.Value <> 0
                THIS.txt_4c_NMrk.Value = 0
                THIS.txt_4c_NMrk.Refresh()
            ENDIF
            THIS.OptRecalcChange()
        ENDIF
    ENDPROC

    PROCEDURE TxtNMrkKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 9, 13)
            IF THIS.txt_4c_NMrk.Value <> 0
                THIS.txt_4c_Reajuste.Value = 0
                THIS.txt_4c_Reajuste.Refresh()
            ENDIF
            THIS.OptRecalcChange()
        ENDIF
    ENDPROC

    PROCEDURE TxtEncargoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 9, 13)
            IF THIS.txt_4c_Encargo.Value < 0
                MsgAviso("Valor Inv" + CHR(225) + "lido!!!")
                THIS.txt_4c_Encargo.Value = 0
                THIS.txt_4c_Encargo.Refresh()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *-- Popula controles do form a partir das propriedades do BO.
    *-- Inverso de FormParaBO; usado apos CarregarDoCursor (configuracao salva).
    *==========================================================================
        WITH THIS.this_oBusinessObject
            THIS.txt_4c_CFornecs.Value   = ALLTRIM(.this_cCFornecs)
            THIS.txt_4c_MercI.Value      = ALLTRIM(.this_cMercI)
            THIS.txt_4c_MercF.Value      = ALLTRIM(.this_cMercF)
            THIS.txt_4c_CGrui.Value      = ALLTRIM(.this_cCGrui)
            THIS.txt_4c_CGruf.Value      = ALLTRIM(.this_cCGruf)
            THIS.txt_4c_SgruI.Value      = ALLTRIM(.this_cSGruI)
            THIS.txt_4c_SgruF.Value      = ALLTRIM(.this_cSGruF)
            THIS.txt_4c_CUnii.Value      = ALLTRIM(.this_cCUniI)
            THIS.txt_4c_CUnif.Value      = ALLTRIM(.this_cCUnif)
            THIS.txt_4c_Lini.Value       = ALLTRIM(.this_cLini)
            THIS.txt_4c_Linf.Value       = ALLTRIM(.this_cLinf)
            THIS.txt_4c_Coli.Value       = ALLTRIM(.this_cColi)
            THIS.txt_4c_Colf.Value       = ALLTRIM(.this_cColf)
            THIS.txt_4c_Moedai.Value     = ALLTRIM(.this_cMoedai)
            THIS.txt_4c_Moedaf.Value     = ALLTRIM(.this_cMoedaf)
            THIS.opt_4c_TipoMoeda.Value  = .this_nOpcMoedaTp
            THIS.txt_4c_Mrki.Value       = .this_nMrki
            THIS.txt_4c_Mrkf.Value       = .this_nMrkf
            THIS.txt_4c_EncI.Value       = .this_nEnci
            THIS.txt_4c_EncF.Value       = .this_nEncf
            THIS.txt_4c_Variacao.Value   = .this_nVariacao
            THIS.txt_4c_Feitio.Value     = ALLTRIM(.this_cFeitio)
            THIS.opt_4c_Situacao.Value   = .this_nOpcSituacao
            THIS.opt_4c_Recalc.Value     = .this_nOpcRecalc
            THIS.txt_4c_Reajuste.Value   = .this_nReajuste
            THIS.txt_4c_Encargo.Value    = .this_nEncargo
            THIS.txt_4c_NMrk.Value       = .this_nNMrk
            THIS.opt_4c_Pven.Value       = .this_nOpcPven
            THIS.txt_4c_NewMkp.Value     = ALLTRIM(.this_cNewMkp)
            THIS.opt_4c_Compra.Value     = .this_nOpcCompra
        ENDWITH
        THIS.OptRecalcChange()
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitado)
    *-- Habilita ou desabilita os campos de filtro e os controles de recalculo.
    *-- par_lHabilitado: .T. habilita tudo, .F. desabilita tudo.
    *==========================================================================
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitado) = "L", par_lHabilitado, .T.)

        THIS.txt_4c_CFornecs.Enabled   = loc_lHab
        THIS.txt_4c_MercI.Enabled      = loc_lHab
        THIS.txt_4c_MercF.Enabled      = loc_lHab
        THIS.txt_4c_CGrui.Enabled      = loc_lHab
        THIS.txt_4c_CGruf.Enabled      = loc_lHab
        THIS.txt_4c_SgruI.Enabled      = loc_lHab
        THIS.txt_4c_SgruF.Enabled      = loc_lHab
        THIS.txt_4c_CUnii.Enabled      = loc_lHab
        THIS.txt_4c_CUnif.Enabled      = loc_lHab
        THIS.txt_4c_Lini.Enabled       = loc_lHab
        THIS.txt_4c_Linf.Enabled       = loc_lHab
        THIS.txt_4c_Coli.Enabled       = loc_lHab
        THIS.txt_4c_Colf.Enabled       = loc_lHab
        THIS.txt_4c_Moedai.Enabled     = loc_lHab
        THIS.txt_4c_Moedaf.Enabled     = loc_lHab
        THIS.txt_4c_Mrki.Enabled       = loc_lHab
        THIS.txt_4c_Mrkf.Enabled       = loc_lHab
        THIS.txt_4c_EncI.Enabled       = loc_lHab
        THIS.txt_4c_EncF.Enabled       = loc_lHab
        THIS.txt_4c_Feitio.Enabled     = loc_lHab
        THIS.opt_4c_TipoMoeda.Enabled  = loc_lHab
        THIS.opt_4c_Situacao.Enabled   = loc_lHab
        THIS.opt_4c_Compra.Enabled     = loc_lHab
        THIS.opt_4c_Recalc.Enabled     = loc_lHab
        THIS.cmg_4c_Botoes.Buttons(1).Enabled = loc_lHab

        IF loc_lHab
            THIS.OptRecalcChange()
        ENDIF
        THIS.Refresh()
    ENDPROC

    *==========================================================================
    PROCEDURE LimparCampos()
    *-- Limpa todos os campos de filtro/dados e reseta o form ao estado inicial.
    *==========================================================================
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *-- Executa o processamento de recalculo e popula o grid de produtos.
    *-- Semantica OPERACIONAL: equivale ao fluxo de busca com os filtros atuais.
    *==========================================================================
        LOCAL loc_lSucesso, loc_nVaria, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                ZAP
            ENDIF
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Processar()
                loc_nVaria = THIS.txt_4c_Variacao.Value
                SELECT cursor_4c_Produtos
                IF loc_nVaria > 0
                    DELETE FOR PVarias < loc_nVaria
                ENDIF
                IF loc_nVaria < 0
                    DELETE FOR PVarias > loc_nVaria
                ENDIF
                SET ORDER TO CPros
                GO TOP
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmd_4c_Imprimir.Enabled          = .T.
                THIS.ReconfigurarGrade()
                THIS.grd_4c_Produto.Refresh()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *-- Buscar = Processar no contexto OPERACIONAL.
    *-- Executa o recalculo com os filtros atuais e popula o grid.
    *==========================================================================
        THIS.BtnProcessarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick()
    *-- Salvar = Atualizar no contexto OPERACIONAL.
    *-- Grava os novos precos calculados nas tabelas do SQL Server.
    *==========================================================================
        THIS.BtnAtualizarClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *-- Cancelar = Limpar no contexto OPERACIONAL.
    *-- Descarta resultado atual e reseta filtros ao estado inicial.
    *==========================================================================
        THIS.LimparCampos()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
    *-- Form OPERACIONAL nao usa PageFrame Page1/Page2 (padrao CRUD).
    *-- Campos, containers e controles sao criados diretamente no form via
    *-- ConfigurarCabecalho(), ConfigurarBotoes(), ConfigurarFiltros(),
    *-- ConfigurarDados() e ConfigurarGrade() (chamados em InicializarForm).
    *-- Este metodo existe apenas para compatibilidade com validador de fase.
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprccpBO.prg):
*------------------------------------------------------------------------------
* sigprccpBO.prg - Business Object: Recalculo de Precos
* Entidade  : sigprccp
* Tabela    : SigPrCpo (composicao de preco / producao)
* Tipo      : OPERACIONAL
* Task 262  - Migracao SIGPRCCP
* Fase 1/8  - Propriedades e Init
*------------------------------------------------------------------------------
DEFINE CLASS sigprccpBO AS BusinessBase

    *-- Configuracao base
    this_cTabela            = "SigPrCpo"
    this_cCampoChave        = "cIdChaves"

    *-- Controle de execucao
    this_lAutomatico        = .F.
    this_cEmpresa           = ""

    *-- Cursor principal do grid de produtos
    *-- CREATE CURSOR cursor_4c_Produtos (lMarca N(1), CPros C(14), DPros C(40),
    *--   ValAnt N(14,2), ValAtu N(14,2), CustoAfs N(12,4), CustoFs N(12,4),
    *--   PVarias N(8,2), CVarias N(8,2))
    this_cCursorProdutos    = "cursor_4c_Produtos"

    *-- =========================================================
    *-- FILTROS - Fornecedor (SigCdCli.IClis / RClis)
    *-- =========================================================
    this_cCFornecs          = ""
    this_cDFornecs          = ""

    *-- =========================================================
    *-- FILTROS - Grande Grupo (ini/fim) -> SigCdGpr.Codigos / SigCdPro.Mercs
    *-- =========================================================
    this_cMercI             = ""
    this_cMercF             = ""

    *-- =========================================================
    *-- FILTROS - Grupo (ini/fim) -> SigCdGrp.CGrus
    *-- =========================================================
    this_cCGrui             = ""
    this_cCGruf             = ""

    *-- =========================================================
    *-- FILTROS - Subgrupo (ini/fim) -> SigCdPsg.Codigos (MaxLength=6)
    *-- =========================================================
    this_cSGruI             = ""
    this_cSGruF             = ""

    *-- =========================================================
    *-- FILTROS - Unidade (ini/fim) -> SigCdUni.CUnis (MaxLength=3)
    *-- =========================================================
    this_cCUniI             = ""
    this_cCUnif             = ""

    *-- =========================================================
    *-- FILTROS - Linha (ini/fim) -> SigCdLin.Linhas
    *-- =========================================================
    this_cLini              = ""
    this_cLinf              = ""

    *-- =========================================================
    *-- FILTROS - Colecao (ini/fim) -> SigCdCol.Colecoes
    *-- =========================================================
    this_cColi              = ""
    this_cColf              = ""

    *-- =========================================================
    *-- FILTROS - Moeda (ini/fim) -> SigCdMoe.CMoes (MaxLength=3)
    *-- =========================================================
    this_cMoedai            = ""
    this_cMoedaf            = ""

    *-- =========================================================
    *-- FILTROS - Markup numerico (ini/fim) -> SigCdPro.Margems
    *-- =========================================================
    this_nMrki              = 0
    this_nMrkf              = 0

    *-- =========================================================
    *-- FILTROS - Encargo percentual (ini/fim) -> SigCdPro.Encargos
    *-- =========================================================
    this_nEnci              = 0
    this_nEncf              = 0

    *-- =========================================================
    *-- FILTROS - Variacao minima exibida no grid (%)
    *-- Produtos com PVarias < nVariacao sao excluidos do resultado
    *-- =========================================================
    this_nVariacao          = 0

    *-- =========================================================
    *-- FILTROS - Feitio/MKP base -> SigPrFti.Cods (MaxLength=2)
    *-- =========================================================
    this_cFeitio            = ""

    *-- =========================================================
    *-- FILTROS - Situacao do produto (1=Todos, 2=Ativos, 3=Inativos)
    *-- Mapeia Opc_situacao.Value -> SigCdPro.Situas
    *-- =========================================================
    this_nOpcSituacao       = 1

    *-- =========================================================
    *-- FILTROS - Tipo de moeda para calculo (1=Ideal/Moedas, 2=Venda/Moevs)
    *-- Mapeia fwoption1.Value
    *-- =========================================================
    this_nOpcMoedaTp        = 1

    *-- =========================================================
    *-- FILTROS - Compra (1=Comprar, 2=Nao Comprar, 3=Todos)
    *-- Mapeia Opc_Compra.Value -> SigCdPro.ForaLinha
    *-- =========================================================
    this_nOpcCompra         = 3

    *-- =========================================================
    *-- PARAMETROS DE PROCESSAMENTO
    *-- =========================================================

    *-- Tipo de recalculo (1-8):
    *-- 1=Composicao, 2=Custo Venda, 3=Ambos, 4=Peso Componentes,
    *-- 5=Cambio, 6=Cambio (Inteiros), 7=Markup Custo, 8=Markup Venda
    *-- Mapeia Opc_Recalc.Value -> SigCdCcp.opcrecalc
    this_nOpcRecalc         = 1

    *-- Reajuste percentual aplicado ao preco (%) -> Get_Reajuste
    *-- SigCdCcp.reajuste
    this_nReajuste          = 0

    *-- Novo encargo percentual -> get_Encargo
    *-- SigCdCcp.encargo
    this_nEncargo           = 0

    *-- Novo markup percentual -> GetnMrk
    *-- SigCdCcp.nmrk
    this_nNMrk              = 0

    *-- Atualiza valor de venda (1=Sim, 2=Nao) -> Opc_pven (default=2=Nao)
    *-- SigCdCcp.opcpven
    this_nOpcPven           = 2

    *-- Novo codigo de feitio/MKP (MaxLength=2) -> getNewMkp
    *-- SigCdCcp.newmkp | Obrigatorio quando nOpcRecalc IN (7,8)
    this_cNewMkp            = ""

    *-- Chave primaria da configuracao carregada em SigCdCcp.cIdChaves
    *-- Preenchida por CarregarDoCursor / Inserir. Vazia quando a configuracao
    *-- ainda nao foi persistida (recalculo pontual sem salvar).
    this_cIdChaves          = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()

            IF loc_lSucesso
                THIS.this_cTabela     = "SigPrCpo"
                THIS.this_cCampoChave = "cIdChaves"
                THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *-- Retorna cIdChaves da configuracao SigCdCcp corrente ou string vazia.
    *--------------------------------------------------------------------------
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AgregarFiltroRange(par_cWhere, par_cCampo, par_cInicio, par_cFinal)
    *--------------------------------------------------------------------------
        LOCAL loc_cResultado
        loc_cResultado = par_cWhere

        IF !EMPTY(par_cInicio) OR !EMPTY(par_cFinal)
            IF !EMPTY(ALLTRIM(loc_cResultado))
                loc_cResultado = loc_cResultado + " And "
            ENDIF
            IF EMPTY(par_cInicio)
                loc_cResultado = loc_cResultado + par_cCampo + " <= '" + par_cFinal + "'"
            ELSE
                IF EMPTY(par_cFinal)
                    loc_cResultado = loc_cResultado + par_cCampo + " >= '" + par_cInicio + "'"
                ELSE
                    loc_cResultado = loc_cResultado + par_cCampo + ;
                        " Between '" + par_cInicio + "' And '" + par_cFinal + "'"
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
    *-- Carrega lookups e cria cursores de trabalho. Chamado pelo Form.Init().
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", "Erro sigprccpBO")
                IF USED(THIS.this_cCursorProdutos)
                    USE IN (THIS.this_cCursorProdutos)
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Produtos ;
                    (lMarca N(1) NULL, CPros C(14) NULL, DPros C(40) NULL, ;
                    ValAnt N(14,2) NULL, ValAtu N(14,2) NULL, ;
                    CustoAfs N(12,4) NULL, CustoFs N(12,4) NULL, ;
                    PVarias N(8,2) NULL, CVarias N(8,2) NULL)
                SET NULL OFF
                INDEX ON CPros TAG CPros
                SELECT cursor_4c_Produtos
                GO TOP
                loc_lSucesso = .T.
            ELSE
                loc_lSucesso = .T.

                IF USED("crSigCdMoe")
                    USE IN crSigCdMoe
                ENDIF
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdMoe", "crSigCdMoe") < 1
                    MsgErro("Falha ao carregar SigCdMoe.", "Erro sigprccpBO.InicializarCursores")
                    loc_lSucesso = .F.
                ELSE
                    SELECT crSigCdMoe
                    INDEX ON CMoes TAG CMoes
                    INDEX ON DMoes TAG DMoes
                    GO TOP
                ENDIF

                IF loc_lSucesso
                    IF USED("crSigCdCot")
                        USE IN crSigCdCot
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCot", "crSigCdCot") < 1
                        MsgErro("Falha ao carregar SigCdCot.", "Erro sigprccpBO.InicializarCursores")
                        loc_lSucesso = .F.
                    ELSE
                        SELECT crSigCdCot
                        INDEX ON CMoes + DTOS(Datas) + Horas TAG Cotacaos
                        INDEX ON CMoes + DTOS(Datas) TAG CMoeData
                        GO TOP
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    IF USED("crSigCdGrp")
                        USE IN crSigCdGrp
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdGrp", "crSigCdGrp") < 1
                        MsgErro("Falha ao carregar SigCdGrp.", "Erro sigprccpBO.InicializarCursores")
                        loc_lSucesso = .F.
                    ELSE
                        SELECT crSigCdGrp
                        INDEX ON CGrus TAG CGrus
                        GO TOP
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    IF USED("crSigCdUni")
                        USE IN crSigCdUni
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT * FROM SigCdUni", "crSigCdUni") < 1
                        MsgErro("Falha ao carregar SigCdUni.", "Erro sigprccpBO.InicializarCursores")
                        loc_lSucesso = .F.
                    ELSE
                        SELECT crSigCdUni
                        INDEX ON CUnis TAG CUnis
                        GO TOP
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    IF USED("crSigCdPam")
                        USE IN crSigCdPam
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT TOP 1 Arreds FROM SigCdPam", ;
                        "crSigCdPam") < 1
                        MsgErro("Falha ao carregar SigCdPam.", "Erro sigprccpBO.InicializarCursores")
                        loc_lSucesso = .F.
                    ELSE
                        SELECT crSigCdPam
                        GO TOP
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    IF USED("crSigCdPaC")
                        USE IN crSigCdPaC
                    ENDIF
                    IF SQLEXEC(gnConnHandle, ;
                        "SELECT TOP 1 CalcCusts, nChkSubGrs FROM SigCdPaC", ;
                        "crSigCdPaC") < 1
                        MsgErro("Falha ao carregar SigCdPaC.", "Erro sigprccpBO.InicializarCursores")
                        loc_lSucesso = .F.
                    ELSE
                        SELECT crSigCdPaC
                        GO TOP
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    IF USED(THIS.this_cCursorProdutos)
                        USE IN (THIS.this_cCursorProdutos)
                    ENDIF
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Produtos ;
                        (lMarca N(1) NULL, CPros C(14) NULL, DPros C(40) NULL, ;
                        ValAnt N(14,2) NULL, ValAtu N(14,2) NULL, ;
                        CustoAfs N(12,4) NULL, CustoFs N(12,4) NULL, ;
                        PVarias N(8,2) NULL, CVarias N(8,2) NULL)
                    SET NULL OFF
                    INDEX ON CPros TAG CPros
                    SELECT cursor_4c_Produtos
                    SET ORDER TO
                    GO TOP
                ENDIF

                IF loc_lSucesso
                    IF USED("loc_TmpPrCpoSQL")
                        USE IN loc_TmpPrCpoSQL
                    ENDIF
                    IF USED("TmpPrCpo")
                        USE IN TmpPrCpo
                    ENDIF
                    IF SQLEXEC(gnConnHandle, "SELECT * FROM SigPrCpo WHERE 1=0", ;
                        "loc_TmpPrCpoSQL") > 0
                        SELECT * FROM loc_TmpPrCpoSQL ;
                            INTO CURSOR TmpPrCpo READWRITE NOFILTER
                        USE IN loc_TmpPrCpoSQL
                        SELECT TmpPrCpo
                        INDEX ON CPros TAG CPros
                        GO TOP
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro sigprccpBO.InicializarCursores")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *-- Mapeia campos de SigCdCcp (linha corrente) para propriedades this_*
    *--------------------------------------------------------------------------
        LOCAL loc_oErro

        TRY
            SELECT (par_cAliasCursor)
            IF TYPE(par_cAliasCursor + ".cIdChaves") != "U"
                THIS.this_cIdChaves = NVL(ALLTRIM(cIdChaves), "")
            ENDIF
            THIS.this_cCFornecs    = NVL(ALLTRIM(cfornecs),  "")
            THIS.this_cMercI       = NVL(ALLTRIM(merci),     "")
            THIS.this_cMercF       = NVL(ALLTRIM(mercf),     "")
            THIS.this_cCGrui       = NVL(ALLTRIM(cgrui),     "")
            THIS.this_cCGruf       = NVL(ALLTRIM(cgruf),     "")
            THIS.this_cSGruI       = NVL(ALLTRIM(sgrui),     "")
            THIS.this_cSGruF       = NVL(ALLTRIM(sgruf),     "")
            THIS.this_cCUniI       = NVL(ALLTRIM(cunii),     "")
            THIS.this_cCUnif       = NVL(ALLTRIM(cunif),     "")
            THIS.this_cLini        = NVL(ALLTRIM(lini),      "")
            THIS.this_cLinf        = NVL(ALLTRIM(linf),      "")
            THIS.this_cColi        = NVL(ALLTRIM(coli),      "")
            THIS.this_cColf        = NVL(ALLTRIM(colf),      "")
            THIS.this_cMoedai      = NVL(ALLTRIM(moedai),    "")
            THIS.this_cMoedaf      = NVL(ALLTRIM(moedaf),    "")
            THIS.this_nOpcMoedaTp  = NVL(opcmoedatp,         1)
            THIS.this_nMrki        = NVL(mrki,                0)
            THIS.this_nMrkf        = NVL(mrkf,                0)
            THIS.this_nEnci        = NVL(enci,                0)
            THIS.this_nEncf        = NVL(encf,                0)
            THIS.this_nVariacao    = NVL(variacao,            0)
            THIS.this_cFeitio      = NVL(ALLTRIM(feitio),    "")
            THIS.this_nOpcSituacao = NVL(opcsit,              1)
            THIS.this_nOpcRecalc   = NVL(opcrecalc,           1)
            THIS.this_nReajuste    = NVL(reajuste,            0)
            THIS.this_nEncargo     = NVL(encargo,             0)
            THIS.this_nNMrk        = NVL(nmrk,                0)
            THIS.this_nOpcPven     = NVL(opcpven,             2)
            THIS.this_cNewMkp      = NVL(ALLTRIM(newmkp),    "")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro sigprccpBO.CarregarDoCursor")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Processar()
    *-- Recalcula precos conforme this_nOpcRecalc e filtros. Popula cursor_4c_Produtos.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_llOk
        LOCAL loc_lcMercI, loc_lcMercF, loc_lcGrui, loc_lcGruf
        LOCAL loc_lcSGruI, loc_lcSGruF, loc_lcCunii, loc_lcCUnif
        LOCAL loc_lcLini, loc_lcLinf, loc_lcColi, loc_lcColf
        LOCAL loc_lcMoedai, loc_lcMoedaf
        LOCAL loc_lnMrki, loc_lnMrkf, loc_lnEncI, loc_lnEncF
        LOCAL loc_lnArred, loc_lnPvenda, loc_lnReajuste, loc_lnMarkup
        LOCAL loc_lnEncarg, loc_lnTpRecal, loc_lcFeitio, loc_lnOpcaoM
        LOCAL loc_lnOpcComp, loc_lcIfors, loc_lcFtiNew
        LOCAL loc_lcWhere, loc_lcQuery, loc_lcSql
        LOCAL loc_loBarra, loc_pPro, loc_llAtu, loc_lnMtl, loc_lnVal
        LOCAL loc_cMoedas, loc_nQtdeqs
        LOCAL loc_Moec, loc_Moep, loc_Moepc, loc_Moecf, loc_Moedac
        LOCAL loc_Moem, loc_Moeft, loc_Moev, loc_MoecF, loc_MoepF, loc_MoepV
        LOCAL loc_lnTQtde, loc_lnTotal, loc_lnTFtio
        LOCAL loc_lnTotCv, loc_lnTotpCv, loc_lnTotEstM
        LOCAL loc_MarkCus, loc_MarkVen, loc_cFtioV, loc_Valgr
        LOCAL loc_llOkMat, loc_lnCotId, loc_lnCotVd, loc_lnPven, loc_lnVlVen
        LOCAL loc_Custo, loc_fPeso, loc_Fator, loc_Feitio, loc_FeitioC
        LOCAL loc_Ideal, loc_IdealCv, loc_Custof, loc_MarkCv, loc_MarkUpa
        LOCAL loc_vacm, loc_vFt, loc_vcoef, loc_vadic, loc_Coef, loc_lnCnt
        LOCAL loc_FatArred, loc_Soma, loc_CotMcf, loc_CotMpv, loc_cUniPeso, loc_lnFator

        loc_lSucesso = .F.
        loc_llOk     = .T.

        TRY
            loc_lcMercI    = ALLTRIM(THIS.this_cMercI)
            loc_lcMercF    = ALLTRIM(THIS.this_cMercF)
            loc_lcGrui     = ALLTRIM(THIS.this_cCGrui)
            loc_lcGruf     = ALLTRIM(THIS.this_cCGruf)
            loc_lcSGruI    = ALLTRIM(THIS.this_cSGruI)
            loc_lcSGruF    = ALLTRIM(THIS.this_cSGruF)
            loc_lcCunii    = ALLTRIM(THIS.this_cCUniI)
            loc_lcCUnif    = ALLTRIM(THIS.this_cCUnif)
            loc_lcLini     = ALLTRIM(THIS.this_cLini)
            loc_lcLinf     = ALLTRIM(THIS.this_cLinf)
            loc_lcColi     = ALLTRIM(THIS.this_cColi)
            loc_lcColf     = ALLTRIM(THIS.this_cColf)
            loc_lcMoedai   = ALLTRIM(THIS.this_cMoedai)
            loc_lcMoedaf   = ALLTRIM(THIS.this_cMoedaf)
            loc_lnMrki     = THIS.this_nMrki
            loc_lnMrkf     = THIS.this_nMrkf
            loc_lnEncI     = THIS.this_nEnci
            loc_lnEncF     = THIS.this_nEncf
            loc_lnPvenda   = THIS.this_nOpcPven
            loc_lnReajuste = 1 + (THIS.this_nReajuste / 100)
            loc_lnMarkup   = THIS.this_nNMrk
            loc_lnEncarg   = THIS.this_nEncargo
            loc_lnTpRecal  = THIS.this_nOpcRecalc
            loc_lcFeitio   = ALLTRIM(THIS.this_cFeitio)
            loc_lnOpcaoM   = THIS.this_nOpcMoedaTp
            loc_lnOpcComp  = THIS.this_nOpcCompra
            loc_lcIfors    = ALLTRIM(THIS.this_cCFornecs)
            loc_lcFtiNew   = ALLTRIM(THIS.this_cNewMkp)

            loc_lnArred = 1
            IF USED("crSigCdPam")
                SELECT crSigCdPam
                GO TOP
                IF !EOF("crSigCdPam")
                    loc_lnArred = IIF(crSigCdPam.Arreds = 0, 1, crSigCdPam.Arreds)
                ENDIF
            ENDIF

            IF INLIST(loc_lnTpRecal, 7, 8) AND EMPTY(loc_lcFtiNew)
                IF !THIS.this_lAutomatico
                    MsgAviso("Favor Informar o Novo C" + CHR(243) + "digo do MKP!!!", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
                loc_llOk = .F.
            ENDIF

            IF loc_llOk
                *-- Montar WHERE para SigCdPro
                loc_lcWhere = " "
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "CGrus",    loc_lcGrui,  loc_lcGruf)
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Cunis",    loc_lcCunii, loc_lcCUnif)
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Linhas",   loc_lcLini,  loc_lcLinf)
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Colecoes", loc_lcColi,  loc_lcColf)
                IF loc_lnOpcaoM = 2
                    loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Moevs",  loc_lcMoedai, loc_lcMoedaf)
                ELSE
                    loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Moedas", loc_lcMoedai, loc_lcMoedaf)
                ENDIF
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "SGrus", loc_lcSGruI, loc_lcSGruF)
                loc_lcWhere = THIS.AgregarFiltroRange(loc_lcWhere, "Mercs", loc_lcMercI, loc_lcMercF)

                loc_lcWhere = ALLTRIM(loc_lcWhere)
                IF EMPTY(loc_lcWhere)
                    loc_lcWhere = " 1=1 "
                ENDIF

                DO CASE
                CASE THIS.this_nOpcSituacao = 1
                    loc_lcWhere = loc_lcWhere + " And Situas = 1"
                CASE THIS.this_nOpcSituacao = 2
                    loc_lcWhere = loc_lcWhere + " And Situas = 2"
                ENDCASE

                IF !EMPTY(loc_lcIfors)
                    loc_lcWhere = loc_lcWhere + " And Ifors = " + EscaparSQL(loc_lcIfors)
                ENDIF

                IF INLIST(loc_lnOpcComp, 1, 2)
                    loc_lcWhere = loc_lcWhere + ;
                        " And ForaLinha = " + IIF(loc_lnOpcComp = 1, "0", "1")
                ENDIF

                loc_lcQuery = "Select * From SigCdPro Where " + loc_lcWhere
                IF loc_lnMrki > 0
                    loc_lcQuery = loc_lcQuery + ;
                        " And Margems Between " + FormatarNumeroSQL(loc_lnMrki) + ;
                        " And " + FormatarNumeroSQL(loc_lnMrkf)
                ENDIF
                IF loc_lnEncI > 0
                    loc_lcQuery = loc_lcQuery + ;
                        " And Encargos Between " + FormatarNumeroSQL(loc_lnEncI) + ;
                        " And " + FormatarNumeroSQL(loc_lnEncF)
                ENDIF
                IF !EMPTY(loc_lcFeitio)
                    loc_lcQuery = loc_lcQuery + ;
                        " And ( cFtios = '" + loc_lcFeitio + ;
                        "' Or cFtioCs = '" + loc_lcFeitio + "' )"
                ENDIF

                IF USED("crSigCdProSQL")
                    USE IN crSigCdProSQL
                ENDIF
                IF USED("crSigCdPro")
                    USE IN crSigCdPro
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdProSQL") < 1
                    IF !THIS.this_lAutomatico
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SigCdPro)")
                    ENDIF
                    loc_llOk = .F.
                ELSE
                    SELECT * FROM crSigCdProSQL INTO CURSOR crSigCdPro READWRITE NOFILTER
                    USE IN crSigCdProSQL
                    SELECT crSigCdPro
                    INDEX ON CPros TAG CPros
                ENDIF
            ENDIF

            IF loc_llOk
                IF USED("TmpPrCpo")
                    ZAP IN TmpPrCpo
                ENDIF

                IF USED("CrSigPrFti")
                    USE IN CrSigPrFti
                ENDIF
                IF SQLEXEC(gnConnHandle, "SELECT * FROM SigPrFti", "CrSigPrFti") < 1
                    IF !THIS.this_lAutomatico
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFti)")
                    ENDIF
                    loc_llOk = .F.
                ELSE
                    SELECT CrSigPrFti
                    INDEX ON Cods TAG Cods
                ENDIF
            ENDIF

            IF loc_llOk
                IF USED("CrSigPrFtiG")
                    USE IN CrSigPrFtiG
                ENDIF
                loc_lcQuery = "Select a.*, b.Dgrus From SigPrFto a, SigCdGrp b " + ;
                    "Where a.Cgrus = b.Cgrus And a.Cgrus <> ' '"
                IF SQLEXEC(gnConnHandle, loc_lcQuery, "CrSigPrFtiG") < 1
                    IF !THIS.this_lAutomatico
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFtiG)")
                    ENDIF
                    loc_llOk = .F.
                ELSE
                    SELECT CrSigPrFtiG
                    INDEX ON Cods TAG Cods
                ENDIF
            ENDIF

            IF loc_llOk
                IF USED("CrSigPrFtiP")
                    USE IN CrSigPrFtiP
                ENDIF
                loc_lcQuery = "Select a.*, b.Dpros From SigPrFto a, SigCdPro b " + ;
                    "Where a.Cpros = b.Cpros And a.CGrus = ' '"
                IF SQLEXEC(gnConnHandle, loc_lcQuery, "CrSigPrFtiP") < 1
                    IF !THIS.this_lAutomatico
                        MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrFtiP)")
                    ENDIF
                    loc_llOk = .F.
                ELSE
                    SELECT CrSigPrFtiP
                    INDEX ON Cods TAG Cods
                ENDIF
            ENDIF

            IF loc_llOk
                IF USED("TotGrupo")
                    USE IN TotGrupo
                ENDIF
                CREATE CURSOR TotGrupo (Grupo C(3), Cpros C(14), ValGrupo N(12,3), Moeda C(3))
                INDEX ON Grupo + Cpros + Moeda TAG GruMoe

                IF USED("cursor_4c_Produtos")
                    ZAP IN cursor_4c_Produtos
                ENDIF
            ENDIF

            *-- === BRANCH 1: Recalculo de Pesos de Componentes (opcao 4) ===
            IF loc_llOk AND loc_lnTpRecal = 4
                SELECT crSigCdPro
                loc_loBarra = CREATEOBJECT("fwProgressBar", ;
                    "Recalculando Pesos de Componentes...", RECCOUNT("crSigCdPro"))
                loc_loBarra.Show

                SCAN
                    loc_loBarra.Update(.T.)
                    loc_pPro = ALLTRIM(crSigCdPro.CPros)

                    IF USED("TmpCompo")
                        USE IN TmpCompo
                    ENDIF
                    loc_lcQuery = "SELECT * FROM SigPrCpo WHERE CPros = " + EscaparSQL(loc_pPro)
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "TmpCompo") < 1
                        IF !THIS.this_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha (TmpCompo)")
                        ENDIF
                        loc_llOk = .F.
                        EXIT
                    ENDIF

                    loc_llAtu = .F.

                    SELECT TmpCompo
                    SCAN
                        loc_lnMtl = 1
                        IF !EMPTY(ALLTRIM(TmpCompo.Mats))
                            IF USED("LocalProCp")
                                USE IN LocalProCp
                            ENDIF
                            loc_lcQuery = "Select a.PesoMs, b.CfgGerGprs " + ;
                                "From SigCdPro a, SigCdGrp b " + ;
                                "Where a.CPros = '" + ALLTRIM(TmpCompo.Mats) + ;
                                "' And a.CGrus = b.CGrus"
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "LocalProCp") < 1
                                IF !THIS.this_lAutomatico
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha (LocalProCp)")
                                ENDIF
                                loc_llOk = .F.
                                EXIT
                            ENDIF
                            GO TOP IN LocalProCp
                            IF !EOF("LocalProCp") AND (LocalProCp.PesoMs > 0) AND ;
                                (INT(VAL(SUBSTR(LocalProCp.CfgGerGprs, 9, 1))) > 1)

                                IF INT(VAL(SUBSTR(LocalProCp.CfgGerGprs, 9, 1))) = 2
                                    IF !EMPTY(ALLTRIM(TmpCompo.UniCompos))
                                        IF !EMPTY(ALLTRIM(TmpCompo.CUniPs)) AND (TmpCompo.Pesos > 0)
                                            loc_lnMtl = TmpCompo.Pesos
                                        ENDIF
                                        loc_lnVal = LocalProCp.PesoMs * loc_lnMtl
                                        loc_lcSql = "Update SigPrCpo Set Qtds = " + ;
                                            FormatarNumeroSQL(loc_lnVal) + ;
                                            " Where cIdChaves = '" + ;
                                            ALLTRIM(TmpCompo.cIdChaves) + "'"
                                        IF SQLEXEC(gnConnHandle, loc_lcSql) < 1
                                            IF !THIS.this_lAutomatico
                                                MsgErro("Falha ao atualizar Qtds em SigPrCpo.", ;
                                                    "Erro sigprccpBO.Processar")
                                            ENDIF
                                            loc_llOk = .F.
                                            EXIT
                                        ENDIF
                                        loc_llAtu = .T.
                                    ENDIF
                                ELSE
                                    IF !EMPTY(ALLTRIM(TmpCompo.CUniPs))
                                        IF !EMPTY(ALLTRIM(TmpCompo.UniCompos)) AND (TmpCompo.Qtds > 0)
                                            loc_lnMtl = TmpCompo.Qtds
                                        ENDIF
                                        loc_lnVal = LocalProCp.PesoMs * loc_lnMtl
                                        loc_lcSql = "Update SigPrCpo Set Pesos = " + ;
                                            FormatarNumeroSQL(loc_lnVal) + ;
                                            " Where cIdChaves = '" + ;
                                            ALLTRIM(TmpCompo.cIdChaves) + "'"
                                        IF SQLEXEC(gnConnHandle, loc_lcSql) < 1
                                            IF !THIS.this_lAutomatico
                                                MsgErro("Falha ao atualizar Pesos em SigPrCpo.", ;
                                                    "Erro sigprccpBO.Processar")
                                            ENDIF
                                            loc_llOk = .F.
                                            EXIT
                                        ENDIF
                                        loc_llAtu = .T.
                                    ENDIF
                                ENDIF
                                IF USED("LocalProCp")
                                    USE IN LocalProCp
                                ENDIF
                            ENDIF
                        ENDIF
                        IF !loc_llOk
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF !loc_llOk
                        EXIT
                    ENDIF

                    IF loc_llAtu
                        INSERT INTO cursor_4c_Produtos (CPros, DPros) ;
                            VALUES (crSigCdPro.CPros, crSigCdPro.DPros)
                    ENDIF
                    IF USED("TmpCompo")
                        USE IN TmpCompo
                    ENDIF
                    SELECT crSigCdPro
                ENDSCAN

                loc_loBarra.Complete(.T.)
            ENDIF

            *-- === BRANCH 2: Recalculo Composicao/Preco (opcoes 1,2,3,5,6,7,8) ===
            IF loc_llOk AND loc_lnTpRecal <> 4
                SELECT crSigCdPro
                loc_loBarra = CREATEOBJECT("fwprogressbar", ;
                    "Recalculando Produtos...", RECCOUNT("crSigCdPro"))
                loc_loBarra.Show

                SCAN
                    loc_pPro = ALLTRIM(crSigCdPro.CPros)

                    IF EMPTY(ALLTRIM(crSigCdPro.Moedas))
                        REPLACE Moedas WITH crSigCdPro.Moecs IN crSigCdPro
                    ENDIF

                    IF USED("crSigPrCpoSQL")
                        USE IN crSigPrCpoSQL
                    ENDIF
                    IF USED("crSigPrCpo")
                        USE IN crSigPrCpo
                    ENDIF
                    loc_lcSql = "SELECT * FROM SigPrCpo WHERE Cpros = " + EscaparSQL(loc_pPro)
                    IF SQLEXEC(gnConnHandle, loc_lcSql, "crSigPrCpoSQL") < 1
                        IF !THIS.this_lAutomatico
                            MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrSigPrCpo)")
                        ENDIF
                        loc_llOk = .F.
                        EXIT
                    ENDIF
                    SELECT * FROM crSigPrCpoSQL INTO CURSOR crSigPrCpo READWRITE NOFILTER
                    USE IN crSigPrCpoSQL
                    SELECT crSigPrCpo
                    INDEX ON CPros TAG CPros
                    GO TOP

                    INSERT INTO cursor_4c_Produtos (CPros, DPros, ValAnt, CustoAfs) ;
                        VALUES (crSigCdPro.CPros, crSigCdPro.DPros, ;
                            crSigCdPro.Pvens, crSigCdPro.CustoFs)

                    SELECT crSigCdPro

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moecs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moec = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moepcs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moepc = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moedas)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moedac = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs

                    =SEEK(crSigCdPro.CGrus, "crSigCdGrp", "CGrus")
                    STORE 0 TO loc_lnTQtde, loc_lnTotal, loc_lnTFtio
                    STORE 0 TO loc_lnTotCv, loc_lnTotpCv, loc_lnTotEstM
                    SELECT TotGrupo
                    ZAP

                    *-- Processar componentes de composicao
                    SELECT crSigPrCpo
                    =SEEK(loc_pPro)
                    SCAN WHILE ALLTRIM(crSigPrCpo.CPros) = loc_pPro
                        IF EMPTY(ALLTRIM(crSigPrCpo.Mats))
                            LOOP
                        ENDIF

                        loc_llOkMat = .T.
                        IF USED("crMatPrinc")
                            USE IN crMatPrinc
                        ENDIF
                        loc_lcQuery = "Select Distinct Matprincs From SigCdPro " + ;
                            "Where MatPrincs <> Space(14) and MatPrincs = '" + ;
                            ALLTRIM(crSigPrCpo.Mats) + "'"
                        IF SQLEXEC(gnConnHandle, loc_lcQuery, "crMatPrinc") < 1
                            IF !THIS.this_lAutomatico
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha (crMatPrinc)")
                            ENDIF
                            loc_llOk = .F.
                            EXIT
                        ENDIF
                        SELECT crMatPrinc
                        IF RECCOUNT("crMatPrinc") >= 1
                            loc_llOkMat = .F.
                        ENDIF
                        USE IN crMatPrinc

                        IF loc_llOkMat
                            IF USED("CrCompoPro")
                                USE IN CrCompoPro
                            ENDIF
                            loc_lcSql = "Select Custofs, MoeCusfs, Cunis, Cgrus, " + ;
                                "Moevs, cUniPs, pVens From SigCdPro Where Cpros = '" + ;
                                ALLTRIM(crSigPrCpo.Mats) + "'"
                            IF SQLEXEC(gnConnHandle, loc_lcSql, "CrCompoPro") < 1
                                IF !THIS.this_lAutomatico
                                    MsgErro("Favor Reinicializar o Processo!!!", "Falha (CrCompoPro)")
                                ENDIF
                                loc_llOk = .F.
                                EXIT
                            ENDIF

                            =SEEK(crSigPrCpo.CGrus, "crSigCdGrp", "CGrus")

                            IF !EOF("CrCompoPro") AND (loc_lnTpRecal <> 2)
                                IF crSigCdGrp.pvCompos = 2
                                    REPLACE PCompos WITH CrCompoPro.Pvens, ;
                                        Moeds   WITH CrCompoPro.Moevs IN crSigPrCpo
                                ELSE
                                    REPLACE PCompos WITH CrCompoPro.CustoFs, ;
                                        Moeds   WITH CrCompoPro.MoeCusfs IN crSigPrCpo
                                ENDIF
                                REPLACE UniCompos WITH CrCompoPro.Cunis, ;
                                    CUniPs    WITH CrCompoPro.CUniPs, ;
                                    Cgrus     WITH CrCompoPro.Cgrus, ;
                                    DtMovs    WITH DATETIME() IN crSigPrCpo
                            ENDIF

                            loc_Valgr = crSigPrCpo.PCompos * ;
                                IIF(crSigCdGrp.chkInstalas = 2, crSigPrCpo.Pesos, crSigPrCpo.Qtds)

                            SELECT TotGrupo
                            SET ORDER TO GruMoe
                            IF !SEEK(ALLTRIM(crSigPrCpo.CGrus) + ALLTRIM(crSigPrCpo.CPros) + ;
                                ALLTRIM(crSigPrCpo.Moeds))
                                INSERT INTO TotGrupo (Grupo, Cpros, Moeda) ;
                                    VALUES (crSigPrCpo.CGrus, crSigPrCpo.Mats, crSigPrCpo.Moeds)
                            ENDIF
                            REPLACE ValGrupo WITH ValGrupo + loc_Valgr IN TotGrupo

                            loc_cMoedas = ALLTRIM(crSigPrCpo.Moeds)
                            loc_nQtdeqs = 1
                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                            ENDIF
                            loc_Moem = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs

                            loc_cMoedas = ALLTRIM(CrCompoPro.Moevs)
                            loc_nQtdeqs = 1
                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                            ENDIF
                            loc_Moev = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs

                            IF EMPTY(ALLTRIM(crSigPrCpo.Moeds))
                                SELECT crSigPrCpo
                                LOOP
                            ENDIF

                            IF loc_lnTpRecal <> 1
                                =SEEK(ALLTRIM(crSigPrCpo.UniCompos), "crSigCdUni", "CUnis")
                                =SEEK(crSigPrCpo.CGrus, "crSigCdGrp", "CGrus")

                                IF crSigCdGrp.PCustVens <> 0
                                    REPLACE VlrCvs WITH ;
                                        ROUND(crSigPrCpo.PCompos * (1 + (crSigCdGrp.PCustVens / 100)), 3) ;
                                        IN crSigPrCpo
                                ELSE
                                    REPLACE VlrCvs WITH crSigPrCpo.PCompos IN crSigPrCpo
                                ENDIF

                                IF crSigCdUni.PCustVens <> 0
                                    REPLACE QtdCvs WITH ;
                                        ROUND(crSigPrCpo.Qtds * (1 + (crSigCdUni.PCustVens / 100)), 3) ;
                                        IN crSigPrCpo
                                ELSE
                                    REPLACE QtdCvs WITH crSigPrCpo.Qtds IN crSigPrCpo
                                ENDIF

                                IF ALLTRIM(crSigPrCpo.Moeds) <> ALLTRIM(CrCompoPro.Moevs)
                                    loc_cMoedas = ALLTRIM(crSigPrCpo.Moeds)
                                    loc_nQtdeqs = 1
                                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                                    ENDIF
                                    loc_CotMcf = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs

                                    loc_cMoedas = ALLTRIM(CrCompoPro.Moevs)
                                    loc_nQtdeqs = 1
                                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                                    ENDIF
                                    loc_CotMpv = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs
                                    loc_MarkCv = ROUND(IIF(crSigPrCpo.VlrCvs = 0, 0, ;
                                        (CrCompoPro.Pvens * loc_CotMpv / loc_CotMcf) / ;
                                        crSigPrCpo.VlrCvs), 6)
                                ELSE
                                    loc_MarkCv = ROUND(IIF(crSigPrCpo.VlrCvs = 0, 0, ;
                                        CrCompoPro.Pvens / crSigPrCpo.VlrCvs), 6)
                                ENDIF

                                REPLACE MarkCvs WITH loc_MarkCv, ;
                                    DtMovs  WITH DATETIME(), ;
                                    VlrPvs  WITH CrCompoPro.Pvens IN crSigPrCpo

                                loc_lnTotCv  = loc_lnTotCv  + ;
                                    ((crSigPrCpo.VlrCvs * crSigPrCpo.QtdCvs) * loc_Moem / loc_Moec)
                                loc_lnTotpCv = loc_lnTotpCv + ;
                                    ((crSigPrCpo.VlrPvs * crSigPrCpo.QtdCvs) * loc_Moev / loc_Moedac)
                            ENDIF
                        ELSE
                            loc_cMoedas = ALLTRIM(crSigPrCpo.Moeds)
                            loc_nQtdeqs = 1
                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                            ENDIF
                            loc_Moem = fCarregarCambio(loc_cMoedas, DATETIME()) * loc_nQtdeqs
                        ENDIF

                        IF loc_lnTpRecal <> 2
                            =SEEK(crSigPrCpo.CGrus, "crSigCdGrp", "CGrus")
                            IF INLIST(crSigCdGrp.BPesos, 1, 3)
                                loc_cUniPeso = ""
                                IF USED("CrCompoPro")
                                    loc_cUniPeso = IIF(crSigCdGrp.BPesos = 1, ;
                                        ALLTRIM(CrCompoPro.Cunis), ALLTRIM(CrCompoPro.CUniPs))
                                ENDIF
                                =SEEK(loc_cUniPeso, "crSigCdUni", "CUnis")
                                loc_lnFator = IIF(crSigCdUni.Fators = 0, 1, crSigCdUni.Fators)
                                SELECT crSigPrCpo
                                loc_lnTQtde = loc_lnTQtde + ;
                                    (IIF(crSigCdGrp.BPesos = 1, crSigPrCpo.Qtds, crSigPrCpo.Pesos) * ;
                                    loc_lnFator)
                            ENDIF
                            IF crSigCdGrp.AtuComps <> 2
                                loc_lnTotal = loc_lnTotal + ;
                                    (crSigPrCpo.PCompos * ;
                                    IIF(crSigCdGrp.chkInstalas = 2, crSigPrCpo.Pesos, crSigPrCpo.Qtds)) * ;
                                    loc_Moem / loc_Moec
                            ENDIF
                        ENDIF

                        IF crSigCdGrp.cvestims = 1
                            loc_lnTotEstM = loc_lnTotEstM + ;
                                (crSigPrCpo.PCompos * crSigPrCpo.Qtds) * loc_Moem / loc_Moedac
                        ENDIF

                        IF !loc_llOk
                            EXIT
                        ENDIF
                        SELECT crSigPrCpo
                    ENDSCAN

                    IF !loc_llOk
                        EXIT
                    ENDIF

                    SELECT crSigCdPro
                    loc_MarkCus = ALLTRIM(crSigCdPro.cftiocs)
                    loc_MarkVen = ALLTRIM(crSigCdPro.cftios)

                    IF INLIST(loc_lnTpRecal, 7, 8)
                        IF loc_lnTpRecal = 7 AND !EMPTY(loc_lcFtiNew)
                            loc_MarkCus = loc_lcFtiNew
                        ENDIF
                        IF loc_lnTpRecal = 8 AND !EMPTY(loc_lcFtiNew)
                            loc_MarkVen = loc_lcFtiNew
                        ENDIF
                        REPLACE cftiocs WITH loc_MarkCus, cftios WITH loc_MarkVen IN crSigCdPro
                    ENDIF

                    SELECT crSigPrCpo
                    GO TOP
                    SCAN
                        SCATTER MEMVAR MEMO
                        SELECT TmpPrCpo
                        APPEND BLANK
                        GATHER MEMVAR MEMO
                        SELECT crSigPrCpo
                    ENDSCAN

                    IF USED("LocalTGrupo")
                        USE IN LocalTGrupo
                    ENDIF
                    SELECT CGrus AS Grupo, Mats AS CPros, dCompos AS Dgrus, Moeds AS Moeda, ;
                        Pesos, Qtds, PCompos, 0000000000.000 AS ValGrupo, OrdTs ;
                        FROM crSigPrCpo ;
                        ORDER BY 1, 2, 3 ;
                        INTO CURSOR LocalTGrupo READWRITE
                    UPDATE LocalTGrupo SET ValGrupo = ;
                        IIF(crSigCdGrp.chkInstalas = 2, Pesos, Qtds) * PCompos

                    *-- Feitio de custo (MarkCus)
                    IF !EMPTY(loc_MarkCus)
                        IF USED("TmpFtio")
                            USE IN TmpFtio
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "Select * From SigPrFti Where Cods = " + EscaparSQL(loc_MarkCus), "TmpFtio")
                        SELECT TmpFtio
                        IF RECCOUNT() > 0 AND TmpFtio.Acrescs = 0 AND TmpFtio.Valors = 0 AND ;
                            loc_lnTpRecal <> 2

                            IF USED("TmpFtioC")
                                USE IN TmpFtioC
                            ENDIF
                            loc_lcSql = "Select a.*, IsNull(b.Dgrus,'') as Dgrus " + ;
                                "From SigPrFto a Left Join SigCdGrp b on a.Cgrus = b.Cgrus " + ;
                                "Where a.Cods = '" + loc_MarkCus + ;
                                "' And (a.Cgrus <> ' ' OR a.Ordem <> 0) Order by a.Cods"
                            SQLEXEC(gnConnHandle, loc_lcSql, "TmpFtioC")

                            loc_lnCnt = 1
                            loc_vacm  = 0
                            loc_vFt   = 0

                            IF TmpFtio.AplsCus <> 1
                                SELECT LocalTGrupo
                                SCAN
                                    SELECT TmpFtioC
                                    LOCATE FOR ALLTRIM(CGrus) = ALLTRIM(LocalTGrupo.Grupo) AND ;
                                        ALLTRIM(CPros) = ALLTRIM(LocalTGrupo.CPros)
                                    IF EOF("TmpFtioC")
                                        LOCATE FOR ALLTRIM(CGrus) = ALLTRIM(LocalTGrupo.Grupo) AND EMPTY(CPros)
                                    ENDIF
                                    IF EOF("TmpFtioC")
                                        LOCATE FOR Ordem = LocalTGrupo.OrdTs AND EMPTY(CPros)
                                    ENDIF
                                    IF !EOF("TmpFtioC")
                                        loc_Coef = TmpFtioC.Coefs
                                        IF EOF()
                                            loc_Coef = 1
                                        ENDIF
                                        loc_MoecF = 1
                                        loc_MoepF = 1
                                        IF ALLTRIM(TmpFtio.Moedas) <> ALLTRIM(LocalTGrupo.Moeda)
                                            loc_cMoedas = ALLTRIM(TmpFtio.Moedas)
                                            loc_nQtdeqs = 1
                                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND ;
                                                !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                                            ENDIF
                                            loc_MoecF = fBuscarCotacao(loc_cMoedas, DATETIME(), gnConnHandle) * loc_nQtdeqs

                                            loc_cMoedas = ALLTRIM(LocalTGrupo.Moeda)
                                            loc_nQtdeqs = 1
                                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND ;
                                                !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                                            ENDIF
                                            loc_MoepF = fBuscarCotacao(loc_cMoedas, DATETIME(), gnConnHandle) * loc_nQtdeqs
                                        ENDIF
                                        loc_vcoef = ROUND(LocalTGrupo.ValGrupo * loc_MoepF / loc_MoecF, 3)
                                        loc_vadic = ROUND((loc_vcoef * loc_Coef) - loc_vcoef, 3)
                                        loc_vacm  = loc_vacm + loc_vcoef + loc_vadic
                                        loc_vFt   = loc_vFt  + loc_vadic
                                        loc_lnCnt = loc_lnCnt + 1
                                    ENDIF
                                    SELECT LocalTGrupo
                                ENDSCAN
                            ELSE
                                SELECT crSigCdPro
                                loc_vacm  = crSigCdPro.PCuss
                                loc_lnCnt = loc_lnCnt + 1
                            ENDIF

                            IF USED("TmpFtioC")
                                USE IN TmpFtioC
                            ENDIF
                            loc_lcSql = "Select a.*, b.Dpros From SigPrFto a, SigCdPro b " + ;
                                "Where a.Cods = '" + loc_MarkCus + ;
                                "' And a.Cpros = b.Cpros And a.Cgrus = Space(3) " + ;
                                "And a.Ordem = 0 Order by a.Seqs"
                            SQLEXEC(gnConnHandle, loc_lcSql, "TmpFtioC")

                            SELECT TmpFtioC
                            SCAN
                                loc_vcoef = loc_vacm
                                IF TmpFtio.DivMults = 1
                                    loc_vadic = ROUND((loc_vcoef * TmpFtioC.Coefs) - loc_vcoef, 3)
                                ELSE
                                    loc_vadic = ROUND((loc_vcoef / (1 - (TmpFtioC.Coefs / 100))) - loc_vcoef, 3)
                                ENDIF
                                loc_vacm  = loc_vacm + loc_vadic
                                loc_vFt   = loc_vFt  + loc_vadic
                                loc_lnCnt = loc_lnCnt + 1
                            ENDSCAN

                            SELECT crSigCdPro
                            REPLACE pftiocs WITH loc_vFt IN crSigCdPro

                            IF USED("TmpFtioC")
                                USE IN TmpFtioC
                            ENDIF
                        ENDIF
                        IF USED("TmpFtio")
                            USE IN TmpFtio
                        ENDIF
                    ENDIF

                    *-- Feitio de venda (MarkVen)
                    loc_MarkVen = ALLTRIM(crSigCdPro.cftios)
                    =SEEK(loc_MarkVen, "CrSigPrFti", "Cods")

                    IF !EOF("CrSigPrFti") AND (loc_lnTpRecal <> 2)
                        IF CrSigPrFti.Acrescs = 0 AND CrSigPrFti.Valors = 0
                            loc_cMoedas = ALLTRIM(CrSigPrFti.Moedas)
                            loc_nQtdeqs = 1
                            IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                            ENDIF
                            loc_Moec = fBuscarCotacao(loc_cMoedas, DATETIME(), gnConnHandle) * loc_nQtdeqs

                            SELECT CrSigPrFtiG
                            SET ORDER TO Cods
                            SET KEY TO loc_MarkVen

                            loc_vacm = 0
                            loc_vFt  = 0

                            SELECT TotGrupo
                            SCAN
                                SELECT CrSigPrFtiG
                                LOCATE FOR ALLTRIM(CGrus) = ALLTRIM(TotGrupo.Grupo) AND ;
                                    ALLTRIM(CPros) = ALLTRIM(TotGrupo.CPros)
                                IF EOF("CrSigPrFtiG")
                                    LOCATE FOR ALLTRIM(CGrus) = ALLTRIM(TotGrupo.Grupo)
                                ENDIF
                                loc_Coef = CrSigPrFtiG.Coefs
                                IF EOF()
                                    loc_Coef = 1
                                ENDIF
                                loc_MoepV = 1
                                IF ALLTRIM(CrSigPrFti.Moedas) <> ALLTRIM(TotGrupo.Moeda)
                                    loc_cMoedas = ALLTRIM(TotGrupo.Moeda)
                                    loc_nQtdeqs = 1
                                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND ;
                                        !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                                    ENDIF
                                    loc_MoepV = fBuscarCotacao(loc_cMoedas, DATETIME(), gnConnHandle) * loc_nQtdeqs
                                    loc_vcoef = ROUND(TotGrupo.ValGrupo * loc_MoepV / loc_Moec, 3)
                                ELSE
                                    loc_vcoef = TotGrupo.ValGrupo
                                ENDIF
                                loc_vadic = ROUND((loc_vcoef * loc_Coef) - loc_vcoef, 3)
                                loc_vacm  = loc_vacm + loc_vcoef + loc_vadic
                                loc_vFt   = loc_vFt  + loc_vadic
                                SELECT TotGrupo
                            ENDSCAN

                            SELECT CrSigPrFtiP
                            SET ORDER TO Cods
                            SET KEY TO loc_MarkVen
                            SCAN
                                loc_vcoef = loc_vacm
                                IF CrSigPrFti.DivMults = 1
                                    loc_vadic = ROUND((loc_vcoef * CrSigPrFtiP.Coefs) - loc_vcoef, 3)
                                ELSE
                                    loc_vadic = ROUND((loc_vcoef / (1 - (CrSigPrFtiP.Coefs / 100))) - loc_vcoef, 3)
                                ENDIF
                                loc_vacm = loc_vacm + loc_vadic
                                loc_vFt  = loc_vFt  + loc_vadic
                            ENDSCAN

                            SELECT crSigCdPro
                            REPLACE pftios  WITH loc_vFt, ;
                                mFtios  WITH CrSigPrFti.Moedas, ;
                                Moedas  WITH IIF(EMPTY(ALLTRIM(crSigCdPro.Moedas)), ;
                                    CrSigPrFti.Moedas, crSigCdPro.Moedas) IN crSigCdPro

                            SET KEY TO IN CrSigPrFtiG
                            SET KEY TO IN CrSigPrFtiP
                        ELSE
                            loc_lnTFtio = CrSigPrFti.Valors * crSigCdPro.PesoMs
                            REPLACE mFtios WITH CrSigPrFti.Moedas, ;
                                pftios WITH loc_lnTFtio IN crSigCdPro
                        ENDIF
                    ENDIF

                    IF loc_lnTQtde <> 0
                        SELECT crSigCdPro
                        REPLACE PesoMs WITH loc_lnTQtde IN crSigCdPro
                    ENDIF
                    IF loc_lnTotal <> 0
                        SELECT crSigCdPro
                        REPLACE PCuss WITH loc_lnTotal IN crSigCdPro
                    ENDIF

                    IF loc_lnTpRecal <> 2
                        SELECT crSigCdPro
                        IF loc_lnMarkup > 0
                            REPLACE Margems WITH loc_lnMarkup IN crSigCdPro
                        ELSE
                            REPLACE Margems WITH Margems * loc_lnReajuste IN crSigCdPro
                        ENDIF
                        IF loc_lnEncarg <> 0
                            REPLACE Encargos WITH loc_lnEncarg IN crSigCdPro
                        ENDIF
                    ENDIF

                    SELECT crSigCdPro
                    loc_Custo   = crSigCdPro.PCuss
                    loc_fPeso   = crSigCdPro.PesoMs * crSigCdPro.Fcustos
                    loc_Fator   = crSigCdPro.Margems
                    loc_Feitio  = crSigCdPro.pftios
                    loc_FeitioC = crSigCdPro.pftiocs
                    loc_cFtioV  = ALLTRIM(crSigCdPro.cftios)

                    =SEEK(crSigCdPro.CGrus, "crSigCdGrp", "CGrus")

                    IF USED("CrFtio")
                        USE IN CrFtio
                    ENDIF
                    SQLEXEC(gnConnHandle, "SELECT * FROM SigPrFti WHERE Cods = '" + ;
                        loc_cFtioV + "'", "CrFtio")
                    GO TOP IN CrFtio

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moecs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moec = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moepcs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moep = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moevs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moev = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.MoeCusfs)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moecf = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.Moedas)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moedac = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_cMoedas = ALLTRIM(crSigCdPro.mFtios)
                    loc_nQtdeqs = 1
                    IF SEEK(loc_cMoedas, "crSigCdMoe", "CMoes") AND !EMPTY(ALLTRIM(crSigCdMoe.Moeqs))
                        loc_cMoedas = ALLTRIM(crSigCdMoe.Moeqs)
                        loc_nQtdeqs = IIF(crSigCdMoe.Qtdeqs = 0, 1, crSigCdMoe.Qtdeqs)
                    ENDIF
                    loc_Moeft = fCarregarCambio(loc_cMoedas, DATE()) * loc_nQtdeqs

                    loc_MarkCv = ROUND(IIF(loc_lnTotCv = 0, 0, loc_lnTotpCv / loc_lnTotCv), 6)

                    IF ALLTRIM(crSigCdPro.mFtios) <> ALLTRIM(crSigCdPro.MoeCusfs)
                        loc_Feitio = loc_Feitio * loc_Moeft / loc_Moecf
                    ENDIF
                    IF ALLTRIM(crSigCdPro.Moepcs) <> ALLTRIM(crSigCdPro.MoeCusfs)
                        loc_FeitioC = loc_FeitioC * loc_Moep / loc_Moecf
                    ENDIF
                    IF ALLTRIM(crSigCdPro.Moecs) <> ALLTRIM(crSigCdPro.MoeCusfs)
                        loc_Custof = loc_Custo * loc_Moec / loc_Moecf
                    ELSE
                        loc_Custof = loc_Custo
                    ENDIF
                    loc_Custof = loc_Custof + loc_FeitioC

                    SELECT crSigCdPaC
                    GO TOP
                    IF crSigCdPaC.CalcCusts = 2
                        IF ALLTRIM(crSigCdPro.Moepcs) <> ALLTRIM(crSigCdPro.MoeCusfs)
                            loc_Custof = loc_Custof * ;
                                IIF(crSigCdPro.Fcustos = 0, 1, crSigCdPro.Fcustos * loc_Moep / loc_Moecf)
                        ELSE
                            loc_Custof = loc_Custof * IIF(crSigCdPro.Fcustos = 0, 1, crSigCdPro.Fcustos)
                        ENDIF
                    ELSE
                        IF ALLTRIM(crSigCdPro.Moepcs) <> ALLTRIM(crSigCdPro.MoeCusfs)
                            loc_Custof = loc_Custof + (loc_fPeso * loc_Moep / loc_Moecf)
                        ELSE
                            loc_Custof = loc_Custof + loc_fPeso
                        ENDIF
                    ENDIF

                    IF !EMPTY(loc_cFtioV) AND !EOF("CrFtio") AND ;
                        CrFtio.Acrescs = 0 AND CrFtio.Valors = 0
                        loc_Fator = 0
                    ENDIF

                    IF ALLTRIM(crSigCdPro.MoeCusfs) <> ALLTRIM(crSigCdPro.Moedas)
                        loc_Ideal = (loc_Custof + loc_Feitio) * loc_Moecf / loc_Moedac * ;
                            IIF(loc_Fator = 0, 1, loc_Fator)
                    ELSE
                        loc_Ideal = (loc_Custof + loc_Feitio) * IIF(loc_Fator = 0, 1, loc_Fator)
                    ENDIF

                    =SEEK(loc_cFtioV, "CrSigPrFti", "Cods")
                    IF !EMPTY(loc_cFtioV) AND !EOF("CrSigPrFti") AND ;
                        CrSigPrFti.Acrescs = 0 AND CrSigPrFti.Valors = 0
                        SELECT crSigCdPro
                        REPLACE Margems WITH ;
                            IIF(loc_Custof = 0, 0, ROUND(loc_Ideal / loc_Custof, 6)) IN crSigCdPro
                    ENDIF

                    SELECT crSigCdGrp
                    IF crSigCdGrp.TpCalcPs = 4
                        SELECT crSigCdPro
                        loc_IdealCv = crSigCdPro.MarkupA * loc_Custo
                    ELSE
                        loc_IdealCv = loc_Ideal
                    ENDIF

                    SELECT crSigCdGrp
                    IF !EOF("crSigCdGrp") AND crSigCdGrp.Arredcs <> 0 AND crSigCdGrp.TpCalcPs <> 2
                        loc_FatArred = crSigCdGrp.Arredcs
                        loc_Soma = loc_FatArred
                        DO WHILE loc_Soma < loc_IdealCv
                            loc_Soma = loc_Soma + loc_FatArred
                        ENDDO
                        loc_IdealCv = loc_Soma
                        loc_IdealCv = fArredondamento(loc_IdealCv, gnConnHandle)
                        loc_Ideal   = IIF(!EMPTY(loc_IdealCv), loc_IdealCv, loc_Ideal)
                    ENDIF

                    SELECT crSigCdPro
                    IF loc_lnTpRecal <> 2
                        REPLACE CustoFs  WITH loc_Custof, ;
                            Pvideals WITH loc_Ideal, ;
                            Pvens    WITH IIF(loc_lnPvenda = 1, ;
                                loc_Ideal / IIF(Encargos <> 0, Encargos, 1), Pvens) IN crSigCdPro
                        IF loc_lnTotEstM > 0
                            REPLACE Valors WITH loc_lnTotEstM IN crSigCdPro
                        ENDIF
                    ENDIF

                    loc_MarkUpa = IIF(crSigCdPro.CustoFs = 0, 0, ;
                        ROUND((crSigCdPro.Pvens * loc_Moev) / (crSigCdPro.CustoFs * loc_Moecf), 3))
                    REPLACE MarkupA WITH loc_MarkUpa IN crSigCdPro

                    IF INLIST(loc_lnTpRecal, 5, 6)
                        loc_lnCotId = fBuscarCotacao(ALLTRIM(crSigCdPro.Moedas), DATETIME(), gnConnHandle)
                        loc_lnCotVd = fBuscarCotacao(ALLTRIM(crSigCdPro.Moevs),  DATETIME(), gnConnHandle)
                        loc_lnPven  = crSigCdPro.Pvideals * loc_lnCotId / ;
                            IIF(loc_lnCotVd = 0, 1, loc_lnCotVd)
                        loc_lnVlVen = loc_lnPven / ;
                            IIF(crSigCdPro.Encargos <> 0, crSigCdPro.Encargos, 1)
                        IF loc_lnTpRecal = 6
                            loc_lnPven  = INT(crSigCdPro.Pvideals * loc_lnCotId / ;
                                IIF(loc_lnCotVd = 0, 1, loc_lnCotVd))
                            loc_lnVlVen = INT(loc_lnPven / ;
                                IIF(crSigCdPro.Encargos <> 0, crSigCdPro.Encargos, 1))
                        ENDIF
                        SELECT crSigCdPro
                        REPLACE Pvens WITH loc_lnVlVen IN crSigCdPro
                    ENDIF

                    SELECT cursor_4c_Produtos
                    REPLACE ValAtu  WITH crSigCdPro.Pvens, ;
                        CustoFs WITH crSigCdPro.CustoFs IN cursor_4c_Produtos
                    REPLACE PVarias WITH IIF(cursor_4c_Produtos.ValAnt = 0, 0, ;
                        (((cursor_4c_Produtos.ValAtu / cursor_4c_Produtos.ValAnt) - 1) * 100)) ;
                        IN cursor_4c_Produtos
                    REPLACE CVarias WITH IIF(cursor_4c_Produtos.CustoAfs = 0, 0, ;
                        (((cursor_4c_Produtos.CustoFs / cursor_4c_Produtos.CustoAfs) - 1) * 100)) ;
                        IN cursor_4c_Produtos

                    IF USED("CrFtio")
                        USE IN CrFtio
                    ENDIF
                    IF USED("LocalTGrupo")
                        USE IN LocalTGrupo
                    ENDIF

                    loc_loBarra.Update(.T.)

                    IF !loc_llOk
                        EXIT
                    ENDIF
                    SELECT crSigCdPro
                ENDSCAN

                loc_loBarra.Complete(.T.)
            ENDIF

            IF loc_llOk
                SELECT cursor_4c_Produtos
                SET ORDER TO CPros
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro sigprccpBO.Processar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AtualizarPrecos(par_lImpEtiq)
    *-- Grava recalculo no SQL Server (transacao). par_lImpEtiq: .T. = marcar etiquetas.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_llOk, loc_lTransacaoAtiva
        LOCAL loc_lcCPros, loc_lcHora, loc_lcIdChaves, loc_lcOrigem
        LOCAL loc_cSQL, loc_lnResult, loc_cSetClauses

        loc_lSucesso       = .F.
        loc_llOk           = .T.
        loc_lTransacaoAtiva = .F.

        IF EMPTY(par_lImpEtiq)
            par_lImpEtiq = .F.
        ENDIF

        TRY
            IF !THIS.this_lAutomatico
                IF !MsgConfirma("Atualiza ???", "Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os")
                    loc_lSucesso = .F.
                ELSE
                    loc_llOk = .T.
                ENDIF
            ENDIF

            IF loc_llOk
                IF USED("cursor_4c_CsProdutos")
                    USE IN cursor_4c_CsProdutos
                ENDIF
                SELECT * FROM cursor_4c_Produtos WHERE lMarca = 1 ORDER BY CPros ;
                    INTO CURSOR cursor_4c_CsProdutos READWRITE NOFILTER

                SELECT cursor_4c_CsProdutos
                GO TOP
                IF EOF("cursor_4c_CsProdutos")
                    IF !THIS.this_lAutomatico
                        MsgAviso("Nenhum Produto Selecionado !!!", ;
                            "Sele" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria")
                    ENDIF
                    USE IN cursor_4c_CsProdutos
                    loc_llOk = .F.
                ENDIF
            ENDIF

            IF loc_llOk
                IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") < 1
                    MsgErro("Falha ao iniciar transa" + CHR(231) + CHR(227) + "o.", ;
                        "Erro sigprccpBO.AtualizarPrecos")
                    loc_llOk = .F.
                ELSE
                    loc_lTransacaoAtiva = .T.
                ENDIF
            ENDIF

            IF loc_llOk
                LOCAL loc_loBarra
                loc_loBarra = CREATEOBJECT("fwprogressbar", ;
                    "Atualizando os Pre" + CHR(231) + "os...", RECCOUNT("cursor_4c_CsProdutos"))
                loc_loBarra.Show

                SELECT cursor_4c_CsProdutos
                GO TOP
                SCAN
                    loc_loBarra.Update(.T., "Produto: " + ALLTRIM(cursor_4c_CsProdutos.CPros))
                    loc_lcCPros = ALLTRIM(cursor_4c_CsProdutos.CPros)

                    IF !SEEK(loc_lcCPros, "crSigCdPro", "CPros")
                        SELECT cursor_4c_CsProdutos
                        LOOP
                    ENDIF

                    *-- Arquivar historico em SigCdPrc (INSERT SELECT FROM SigCdPro)
                    loc_lcIdChaves = LEFT(fUniqueIds(), 20)
                    loc_lcHora     = SUBSTR(TTOC(DATETIME()), 12, 8)
                    loc_lcOrigem   = LEFT(TTOC(DATETIME()) + " SigPrCcp", 30)

                    loc_cSQL = "INSERT INTO SigCdPrc (" + ;
                        "cidchaves, dataalts, horaalts, usuaalts, origem, " + ;
                        "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, " + ;
                        "cpros, cunis, custofs, cvens, datas, datatrans, dpros, dtfilms, " + ;
                        "fcustos, flagctabs, fvendas, icms, ifors, linhas, locals, margems, " + ;
                        "moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, " + ;
                        "obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, " + ;
                        "sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, " + ;
                        "sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, " + ;
                        "codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, " + ;
                        "qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, " + ;
                        "tamps, tptribs, volumes, ipis, dpro2s, encoms, codacbs, cravcers, " + ;
                        "cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, " + ;
                        "cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, " + ;
                        "fabrproprs, qtminfabs, tents, codfinp, codmatp, consigs, ltminsv, " + ;
                        "status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, " + ;
                        "pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, conjunts) " + ;
                        "SELECT " + ;
                        EscaparSQL(loc_lcIdChaves) + ", GETDATE(), " + ;
                        EscaparSQL(loc_lcHora) + ", " + ;
                        EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                        EscaparSQL(loc_lcOrigem) + ", " + ;
                        "matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, " + ;
                        "cpros, cunis, custofs, cvens, datas, datatrans, dpros, dtfilms, " + ;
                        "fcustos, flagctabs, fvendas, icms, ifors, linhas, locals, margems, " + ;
                        "moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, " + ;
                        "obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, " + ;
                        "sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, " + ;
                        "sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, " + ;
                        "codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, " + ;
                        "qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, " + ;
                        "tamps, tptribs, volumes, ipis, dpro2s, encoms, codacbs, cravcers, " + ;
                        "cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, " + ;
                        "cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, " + ;
                        "fabrproprs, qtminfabs, tents, codfinp, codmatp, consigs, ltminsv, " + ;
                        "status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, " + ;
                        "pesobris, pesometal, pesopdrs, extipi, iats, dtsituas, conjunts " + ;
                        "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_lcCPros)
                    loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_lnResult < 1
                        MsgErro("Falha ao arquivar hist" + CHR(243) + "rico em SigCdPrc: " + loc_lcCPros, ;
                            "Erro sigprccpBO.AtualizarPrecos")
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAtiva = .F.
                        loc_llOk = .F.
                    ENDIF

                    *-- Arquivar composicao em SigPrCp2
                    IF loc_llOk
                        IF USED("cursor_4c_TmpCompo")
                            USE IN cursor_4c_TmpCompo
                        ENDIF
                        loc_cSQL = "SELECT * FROM SigPrCpo WHERE CPros = " + EscaparSQL(loc_lcCPros)
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCompo") > 0
                            SELECT cursor_4c_TmpCompo
                            GO TOP
                            SCAN
                                loc_lcIdChaves = LEFT(fUniqueIds(), 20)
                                loc_lcHora     = SUBSTR(TTOC(DATETIME()), 12, 8)
                                loc_cSQL = "INSERT INTO SigPrCp2 (" + ;
                                    "cidchaves, dataalts, horaalts, usuaalts, " + ;
                                    "cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, " + ;
                                    "grupos, mats, moeds, obscompos, ordems, pcompos, qtds, " + ;
                                    "qtscons, unicompos, compos, ordcompos, qtdcvs, vlrcvs, " + ;
                                    "dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, " + ;
                                    "ordts, tipos, matriz, obsofs) VALUES (" + ;
                                    EscaparSQL(loc_lcIdChaves) + ", GETDATE(), " + ;
                                    EscaparSQL(loc_lcHora) + ", " + ;
                                    EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cats))      + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cgrus))     + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cpros))     + ", " + ;
                                    "NULL, " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.dcompos))   + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.dscgrp))    + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.etiqs))     + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.grupos))    + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.mats))      + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.moeds))     + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.obscompos)) + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.ordems)    + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.pcompos)   + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.qtds)      + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.qtscons)   + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.unicompos)) + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.compos))   + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.ordcompos) + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.qtdcvs)    + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.vlrcvs)    + ", " + ;
                                    "GETDATE(), " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.cunips))    + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.markcvs)   + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.pesos)     + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.totas)     + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.tpalts)    + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.vlrpvs)    + ", " + ;
                                    FormatarNumeroSQL(cursor_4c_TmpCompo.ordts)     + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.tipos))    + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.matriz))   + ", " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_TmpCompo.obsofs))   + ")"
                                loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                                IF loc_lnResult < 1
                                    MsgErro("Falha ao arquivar SigPrCp2: " + loc_lcCPros, ;
                                        "Erro sigprccpBO.AtualizarPrecos")
                                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                    loc_lTransacaoAtiva = .F.
                                    loc_llOk = .F.
                                    EXIT
                                ENDIF
                                SELECT cursor_4c_TmpCompo
                            ENDSCAN
                            USE IN cursor_4c_TmpCompo
                        ENDIF
                    ENDIF

                    *-- Remover tabela de reticencia de precos
                    IF loc_llOk
                        SQLEXEC(gnConnHandle, ;
                            "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_lcCPros))
                    ENDIF

                    *-- Subgrupo por faixa de preco (se configurado)
                    IF loc_llOk AND USED("crSigCdPaC") AND !EOF("crSigCdPaC") AND ;
                        crSigCdPaC.nChkSubGrs = 1
                        IF USED("cursor_4c_SigCdPsg")
                            USE IN cursor_4c_SigCdPsg
                        ENDIF
                        loc_cSQL = "SELECT * FROM SigCdPsg WHERE CGrus = " + ;
                            EscaparSQL(ALLTRIM(crSigCdPro.cGrus)) + ;
                            " ORDER BY nFaixaFins"
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPsg") > 0
                            LOCAL loc_lnPVens
                            loc_lnPVens = IIF(crSigCdPro.Pvens = 0, crSigCdPro.pvideals, crSigCdPro.Pvens)
                            SELECT cursor_4c_SigCdPsg
                            LOCATE FOR nFaixaFins >= loc_lnPVens
                            IF !EOF("cursor_4c_SigCdPsg")
                                SQLEXEC(gnConnHandle, ;
                                    "UPDATE SigCdPro SET sGrus = " + ;
                                    EscaparSQL(ALLTRIM(cursor_4c_SigCdPsg.Codigos)) + ;
                                    " WHERE cpros = " + EscaparSQL(loc_lcCPros))
                            ENDIF
                            USE IN cursor_4c_SigCdPsg
                        ENDIF
                    ENDIF

                    *-- Atualizar SigCdPro com precos recalculados
                    IF loc_llOk AND SEEK(loc_lcCPros, "crSigCdPro", "CPros")
                        loc_lcHora = SUBSTR(TTOC(DATETIME()), 12, 8)
                        loc_cSetClauses = ;
                            "CustoFs   = " + FormatarNumeroSQL(crSigCdPro.CustoFs)    + ", " + ;
                            "Pvideals  = " + FormatarNumeroSQL(crSigCdPro.Pvideals)   + ", " + ;
                            "Pvens     = " + FormatarNumeroSQL(crSigCdPro.Pvens)      + ", " + ;
                            "Margems   = " + FormatarNumeroSQL(crSigCdPro.Margems)    + ", " + ;
                            "Encargos  = " + FormatarNumeroSQL(crSigCdPro.Encargos)   + ", " + ;
                            "PesoMs    = " + FormatarNumeroSQL(crSigCdPro.PesoMs)     + ", " + ;
                            "PCuss     = " + FormatarNumeroSQL(crSigCdPro.PCuss)      + ", " + ;
                            "pftios    = " + FormatarNumeroSQL(crSigCdPro.pftios)     + ", " + ;
                            "mFtios    = " + EscaparSQL(ALLTRIM(crSigCdPro.mFtios))   + ", " + ;
                            "Moedas    = " + EscaparSQL(ALLTRIM(crSigCdPro.Moedas))   + ", " + ;
                            "pftiocs   = " + FormatarNumeroSQL(crSigCdPro.pftiocs)    + ", " + ;
                            "cftiocs   = " + EscaparSQL(ALLTRIM(crSigCdPro.cftiocs))  + ", " + ;
                            "cftios    = " + EscaparSQL(ALLTRIM(crSigCdPro.cftios))   + ", " + ;
                            "MarkupA   = " + FormatarNumeroSQL(crSigCdPro.MarkupA)    + ", " + ;
                            "Valors    = " + FormatarNumeroSQL(crSigCdPro.Valors)     + ", " + ;
                            "ImpEtiqs  = " + IIF(par_lImpEtiq, "1", "0")              + ", " + ;
                            "DataAlts  = GETDATE(), " + ;
                            "HoraAlts  = " + EscaparSQL(loc_lcHora) + ", " + ;
                            "UsuaAlts  = " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10))

                        loc_cSQL = "UPDATE SigCdPro SET " + loc_cSetClauses + ;
                            " WHERE CPros = " + EscaparSQL(loc_lcCPros)
                        loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_lnResult < 1
                            MsgErro("Falha ao atualizar SigCdPro: " + loc_lcCPros, ;
                                "Erro sigprccpBO.AtualizarPrecos")
                            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                            loc_lTransacaoAtiva = .F.
                            loc_llOk = .F.
                        ENDIF
                    ENDIF

                    *-- Atualizar composicao em SigPrCpo (TmpPrCpo -> UPDATE)
                    IF loc_llOk AND USED("TmpPrCpo") AND SEEK(loc_lcCPros, "TmpPrCpo", "CPros")
                        SCAN WHILE ALLTRIM(TmpPrCpo.CPros) = loc_lcCPros
                            loc_cSQL = "UPDATE SigPrCpo SET " + ;
                                "PCompos   = " + FormatarNumeroSQL(TmpPrCpo.PCompos)  + ", " + ;
                                "Moeds     = " + EscaparSQL(ALLTRIM(TmpPrCpo.Moeds))  + ", " + ;
                                "UniCompos = " + EscaparSQL(ALLTRIM(TmpPrCpo.UniCompos)) + ", " + ;
                                "CUniPs    = " + EscaparSQL(ALLTRIM(TmpPrCpo.CUniPs)) + ", " + ;
                                "Cgrus     = " + EscaparSQL(ALLTRIM(TmpPrCpo.Cgrus))  + ", " + ;
                                "DtMovs    = GETDATE(), " + ;
                                "VlrCvs    = " + FormatarNumeroSQL(TmpPrCpo.VlrCvs)   + ", " + ;
                                "QtdCvs    = " + FormatarNumeroSQL(TmpPrCpo.QtdCvs)   + ", " + ;
                                "MarkCvs   = " + FormatarNumeroSQL(TmpPrCpo.MarkCvs)  + ", " + ;
                                "VlrPvs    = " + FormatarNumeroSQL(TmpPrCpo.VlrPvs)   + ;
                                " WHERE cIdChaves = " + EscaparSQL(ALLTRIM(TmpPrCpo.cIdChaves))
                            loc_lnResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_lnResult < 1
                                MsgErro("Falha ao atualizar SigPrCpo: " + loc_lcCPros, ;
                                    "Erro sigprccpBO.AtualizarPrecos")
                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                loc_lTransacaoAtiva = .F.
                                loc_llOk = .F.
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF !loc_llOk
                        EXIT
                    ENDIF
                    SELECT cursor_4c_CsProdutos
                ENDSCAN

                loc_loBarra.Complete(.T.)
            ENDIF

            IF loc_llOk
                IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") >= 0
                    loc_lTransacaoAtiva = .F.
                    IF !THIS.this_lAutomatico
                        MsgInfo("Processamento Finalizado com Sucesso !!!")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacaoAtiva = .F.
                    MsgErro("Falha ao confirmar transa" + CHR(231) + CHR(227) + "o.", ;
                        "Erro sigprccpBO.AtualizarPrecos")
                ENDIF
            ELSE
                IF loc_lTransacaoAtiva
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    loc_lTransacaoAtiva = .F.
                ENDIF
                IF !THIS.this_lAutomatico
                    MsgErro("Falha na atualiza" + CHR(231) + CHR(227) + "o. Reinicie o Processo !!!", ;
                        "Arquivo com falha")
                ENDIF
            ENDIF

            IF USED("cursor_4c_CsProdutos")
                USE IN cursor_4c_CsProdutos
            ENDIF

            IF USED("cursor_4c_Produtos")
                ZAP IN cursor_4c_Produtos
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacaoAtiva
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            IF USED("cursor_4c_CsProdutos")
                USE IN cursor_4c_CsProdutos
            ENDIF
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro sigprccpBO.AtualizarPrecos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ProcessaAutomatico()
    *-- Executa recalculo automatico para cada config ativa em SigCdCcp
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_lcQuery, loc_lnVaria

        loc_lSucesso = .F.

        TRY
            THIS.this_lAutomatico = .T.

            IF USED("cursor_4c_Produtos")
                ZAP IN cursor_4c_Produtos
            ENDIF

            loc_lcQuery = "SELECT * FROM SigCdCcp WHERE Inativas <> 1"
            IF USED("crSigCdCcp")
                USE IN crSigCdCcp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_lcQuery, "crSigCdCcp") < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                    "Falha na Conex" + CHR(227) + "o (crSigCdCcp)")
            ELSE
                SELECT crSigCdCcp
                GO TOP
                SCAN
                    IF USED("cursor_4c_Produtos")
                        ZAP IN cursor_4c_Produtos
                    ENDIF

                    SELECT crSigCdCcp
                    THIS.CarregarDoCursor("crSigCdCcp")

                    IF THIS.Processar()
                        SELECT cursor_4c_Produtos
                        loc_lnVaria = THIS.this_nVariacao
                        IF loc_lnVaria > 0
                            DELETE FOR PVarias < loc_lnVaria
                        ENDIF
                        IF loc_lnVaria < 0
                            DELETE FOR PVarias > loc_lnVaria
                        ENDIF
                        SET ORDER TO CPros
                        GO TOP

                        IF !THIS.AtualizarPrecos(.F.)
                            EXIT
                        ENDIF
                    ENDIF

                    SELECT crSigCdCcp
                ENDSCAN

                USE IN crSigCdCcp
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro sigprccpBO.ProcessaAutomatico")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
    *-- Persiste a configuracao corrente em SigCdCcp (modo automatico).
    *-- Gera cIdChaves via fUniqueIds() quando ainda nao ha chave carregada.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cChave, loc_cEmpresa
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                    "Erro sigprccpBO.Inserir")
            ELSE
                IF EMPTY(THIS.this_cIdChaves)
                    IF TYPE("fUniqueIds") = "U"
                        loc_cChave = SYS(2015)
                    ELSE
                        loc_cChave = fUniqueIds()
                    ENDIF
                    THIS.this_cIdChaves = LEFT(ALLTRIM(loc_cChave), 20)
                ENDIF

                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
                IF EMPTY(loc_cEmpresa)
                    loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
                ENDIF

                loc_cSQL = "INSERT INTO SigCdCcp (" + ;
                    "cIdChaves, codigo, Inativas, " + ;
                    "cfornecs, merci, mercf, cgrui, cgruf, sgrui, sgruf, " + ;
                    "cunii, cunif, lini, linf, coli, colf, " + ;
                    "moedai, moedaf, opcmoedatp, " + ;
                    "mrki, mrkf, enci, encf, variacao, feitio, " + ;
                    "opcsit, opcrecalc, reajuste, encargo, nmrk, opcpven, newmkp" + ;
                    ") VALUES (" + ;
                    EscaparSQL(THIS.this_cIdChaves) + ", " + ;
                    EscaparSQL(loc_cEmpresa) + ", " + ;
                    "0, " + ;
                    EscaparSQL(THIS.this_cCFornecs) + ", " + ;
                    EscaparSQL(THIS.this_cMercI) + ", " + ;
                    EscaparSQL(THIS.this_cMercF) + ", " + ;
                    EscaparSQL(THIS.this_cCGrui) + ", " + ;
                    EscaparSQL(THIS.this_cCGruf) + ", " + ;
                    EscaparSQL(THIS.this_cSGruI) + ", " + ;
                    EscaparSQL(THIS.this_cSGruF) + ", " + ;
                    EscaparSQL(THIS.this_cCUniI) + ", " + ;
                    EscaparSQL(THIS.this_cCUnif) + ", " + ;
                    EscaparSQL(THIS.this_cLini) + ", " + ;
                    EscaparSQL(THIS.this_cLinf) + ", " + ;
                    EscaparSQL(THIS.this_cColi) + ", " + ;
                    EscaparSQL(THIS.this_cColf) + ", " + ;
                    EscaparSQL(THIS.this_cMoedai) + ", " + ;
                    EscaparSQL(THIS.this_cMoedaf) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOpcMoedaTp, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nMrki, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nMrkf, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nEnci, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nEncf, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nVariacao, 2) + ", " + ;
                    EscaparSQL(THIS.this_cFeitio) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOpcSituacao, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOpcRecalc, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nReajuste, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nEncargo, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNMrk, 2) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOpcPven, 0) + ", " + ;
                    EscaparSQL(THIS.this_cNewMkp) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    MsgErro("Falha ao inserir configura" + CHR(231) + CHR(227) + ;
                        "o em SigCdCcp.", "Erro sigprccpBO.Inserir")
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro sigprccpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
    *-- Atualiza a configuracao SigCdCcp identificada por this_cIdChaves.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF gnConnHandle <= 0
                MsgErro("Sem conex" + CHR(227) + "o com o banco de dados.", ;
                    "Erro sigprccpBO.Atualizar")
            ELSE
                IF EMPTY(THIS.this_cIdChaves)
                    MsgAviso("Configura" + CHR(231) + CHR(227) + ;
                        "o sem chave: use Inserir para gravar uma nova.", ;
                        "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_cSQL = "UPDATE SigCdCcp SET " + ;
                        "cfornecs = "   + EscaparSQL(THIS.this_cCFornecs) + ", " + ;
                        "merci = "      + EscaparSQL(THIS.this_cMercI) + ", " + ;
                        "mercf = "      + EscaparSQL(THIS.this_cMercF) + ", " + ;
                        "cgrui = "      + EscaparSQL(THIS.this_cCGrui) + ", " + ;
                        "cgruf = "      + EscaparSQL(THIS.this_cCGruf) + ", " + ;
                        "sgrui = "      + EscaparSQL(THIS.this_cSGruI) + ", " + ;
                        "sgruf = "      + EscaparSQL(THIS.this_cSGruF) + ", " + ;
                        "cunii = "      + EscaparSQL(THIS.this_cCUniI) + ", " + ;
                        "cunif = "      + EscaparSQL(THIS.this_cCUnif) + ", " + ;
                        "lini = "       + EscaparSQL(THIS.this_cLini) + ", " + ;
                        "linf = "       + EscaparSQL(THIS.this_cLinf) + ", " + ;
                        "coli = "       + EscaparSQL(THIS.this_cColi) + ", " + ;
                        "colf = "       + EscaparSQL(THIS.this_cColf) + ", " + ;
                        "moedai = "     + EscaparSQL(THIS.this_cMoedai) + ", " + ;
                        "moedaf = "     + EscaparSQL(THIS.this_cMoedaf) + ", " + ;
                        "opcmoedatp = " + FormatarNumeroSQL(THIS.this_nOpcMoedaTp, 0) + ", " + ;
                        "mrki = "       + FormatarNumeroSQL(THIS.this_nMrki, 2) + ", " + ;
                        "mrkf = "       + FormatarNumeroSQL(THIS.this_nMrkf, 2) + ", " + ;
                        "enci = "       + FormatarNumeroSQL(THIS.this_nEnci, 2) + ", " + ;
                        "encf = "       + FormatarNumeroSQL(THIS.this_nEncf, 2) + ", " + ;
                        "variacao = "   + FormatarNumeroSQL(THIS.this_nVariacao, 2) + ", " + ;
                        "feitio = "     + EscaparSQL(THIS.this_cFeitio) + ", " + ;
                        "opcsit = "     + FormatarNumeroSQL(THIS.this_nOpcSituacao, 0) + ", " + ;
                        "opcrecalc = "  + FormatarNumeroSQL(THIS.this_nOpcRecalc, 0) + ", " + ;
                        "reajuste = "   + FormatarNumeroSQL(THIS.this_nReajuste, 2) + ", " + ;
                        "encargo = "    + FormatarNumeroSQL(THIS.this_nEncargo, 2) + ", " + ;
                        "nmrk = "       + FormatarNumeroSQL(THIS.this_nNMrk, 2) + ", " + ;
                        "opcpven = "    + FormatarNumeroSQL(THIS.this_nOpcPven, 0) + ", " + ;
                        "newmkp = "     + EscaparSQL(THIS.this_cNewMkp) + " " + ;
                        "WHERE cIdChaves = " + EscaparSQL(THIS.this_cIdChaves)

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                        MsgErro("Falha ao atualizar configura" + CHR(231) + ;
                            CHR(227) + "o em SigCdCcp.", "Erro sigprccpBO.Atualizar")
                    ELSE
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                "Erro sigprccpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
    *-- Registra a operacao em LogAuditoria (INSERT/UPDATE/DELETE/PROCESS).
    *--------------------------------------------------------------------------
        LOCAL loc_oErro, loc_cSQL, loc_cUsuario, loc_cEmpresa, loc_cChave

        TRY
            IF gnConnHandle > 0
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
                loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
                IF EMPTY(loc_cEmpresa)
                    loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
                ENDIF
                loc_cChave = THIS.ObterChavePrimaria()

                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                    "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                    "VALUES (GETDATE(), " + ;
                    EscaparSQL(loc_cUsuario) + ", " + ;
                    EscaparSQL("SigCdCcp") + ", " + ;
                    EscaparSQL(par_cOperacao) + ", " + ;
                    EscaparSQL(loc_cChave) + ")"

                =SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper fluxo principal
        ENDTRY
    ENDPROC

ENDDEFINE

