# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 8/10
- Mensagem: TIMEOUT: VFP9 travou durante teste automatico (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-08 18:00:18] [INFO] Config FPW: (nao fornecido)
[2026-08-08 18:00:18] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 18:00:18] [INFO] Timeout: 300 segundos
[2026-08-08 18:00:18] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ytm4a3gd.prg
[2026-08-08 18:00:18] [INFO] Conteudo do wrapper:
[2026-08-08 18:00:18] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
QUIT

[2026-08-08 18:00:18] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ytm4a3gd.prg
[2026-08-08 18:00:18] [INFO] VFP output esperado em: C:\4c\tasks\task444\vfp_output.txt
[2026-08-08 18:00:18] [INFO] Executando Visual FoxPro 9...
[2026-08-08 18:00:18] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ytm4a3gd.prg
[2026-08-08 18:00:18] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ytm4a3gd.prg
[2026-08-08 18:00:18] [INFO] Timeout configurado: 300 segundos
[2026-08-08 18:05:18] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 11496)...
[2026-08-08 18:05:20] [INFO] VFP9 finalizado em 302.0859781 segundos
[2026-08-08 18:05:20] [INFO] Exit Code: 4
[2026-08-08 18:05:20] [INFO] 
[2026-08-08 18:05:21] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 18:05:21] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ytm4a3gd.prg
[2026-08-08 18:05:21] [INFO] 
[2026-08-08 18:05:21] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 18:05:21] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 18:05:21] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 18:05:21] [INFO] * Parameters: 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
[2026-08-08 18:05:21] [INFO] 
[2026-08-08 18:05:21] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 18:05:21] [INFO] SET SAFETY OFF
[2026-08-08 18:05:21] [INFO] SET RESOURCE OFF
[2026-08-08 18:05:21] [INFO] SET TALK OFF
[2026-08-08 18:05:21] [INFO] SET NOTIFY OFF
[2026-08-08 18:05:21] [INFO] SYS(2335, 0)
[2026-08-08 18:05:21] [INFO] 
[2026-08-08 18:05:21] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
[2026-08-08 18:05:21] [INFO] QUIT
[2026-08-08 18:05:21] [INFO] 
[2026-08-08 18:05:21] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 18:05:21] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-08 18:22:50] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-08 18:22:50] [INFO] Config FPW: (nao fornecido)
[2026-08-08 18:22:50] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 18:22:50] [INFO] Timeout: 300 segundos
[2026-08-08 18:22:50] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3i3cg4qp.prg
[2026-08-08 18:22:50] [INFO] Conteudo do wrapper:
[2026-08-08 18:22:50] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
QUIT

[2026-08-08 18:22:50] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3i3cg4qp.prg
[2026-08-08 18:22:50] [INFO] VFP output esperado em: C:\4c\tasks\task444\vfp_output.txt
[2026-08-08 18:22:50] [INFO] Executando Visual FoxPro 9...
[2026-08-08 18:22:50] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3i3cg4qp.prg
[2026-08-08 18:22:50] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3i3cg4qp.prg
[2026-08-08 18:22:50] [INFO] Timeout configurado: 300 segundos
[2026-08-08 18:27:50] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 15744)...
[2026-08-08 18:27:52] [INFO] VFP9 finalizado em 302.0852427 segundos
[2026-08-08 18:27:52] [INFO] Exit Code: 4
[2026-08-08 18:27:52] [INFO] 
[2026-08-08 18:27:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 18:27:52] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_3i3cg4qp.prg
[2026-08-08 18:27:52] [INFO] 
[2026-08-08 18:27:52] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 18:27:52] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 18:27:52] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 18:27:52] [INFO] * Parameters: 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
[2026-08-08 18:27:52] [INFO] 
[2026-08-08 18:27:52] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 18:27:52] [INFO] SET SAFETY OFF
[2026-08-08 18:27:52] [INFO] SET RESOURCE OFF
[2026-08-08 18:27:52] [INFO] SET TALK OFF
[2026-08-08 18:27:52] [INFO] SET NOTIFY OFF
[2026-08-08 18:27:52] [INFO] SYS(2335, 0)
[2026-08-08 18:27:52] [INFO] 
[2026-08-08 18:27:52] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
[2026-08-08 18:27:52] [INFO] QUIT
[2026-08-08 18:27:52] [INFO] 
[2026-08-08 18:27:52] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 18:27:52] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-08 18:43:52] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-08 18:43:52] [INFO] Config FPW: (nao fornecido)
[2026-08-08 18:43:52] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 18:43:52] [INFO] Timeout: 300 segundos
[2026-08-08 18:43:52] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rabw1oxq.prg
[2026-08-08 18:43:52] [INFO] Conteudo do wrapper:
[2026-08-08 18:43:52] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
QUIT

[2026-08-08 18:43:52] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rabw1oxq.prg
[2026-08-08 18:43:52] [INFO] VFP output esperado em: C:\4c\tasks\task444\vfp_output.txt
[2026-08-08 18:43:52] [INFO] Executando Visual FoxPro 9...
[2026-08-08 18:43:52] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rabw1oxq.prg
[2026-08-08 18:43:52] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rabw1oxq.prg
[2026-08-08 18:43:52] [INFO] Timeout configurado: 300 segundos
[2026-08-08 18:48:52] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 13164)...
[2026-08-08 18:48:54] [INFO] VFP9 finalizado em 302.0837406 segundos
[2026-08-08 18:48:54] [INFO] Exit Code: 4
[2026-08-08 18:48:54] [INFO] 
[2026-08-08 18:48:54] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 18:48:54] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rabw1oxq.prg
[2026-08-08 18:48:54] [INFO] 
[2026-08-08 18:48:54] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 18:48:54] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 18:48:54] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 18:48:54] [INFO] * Parameters: 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
[2026-08-08 18:48:54] [INFO] 
[2026-08-08 18:48:54] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 18:48:54] [INFO] SET SAFETY OFF
[2026-08-08 18:48:54] [INFO] SET RESOURCE OFF
[2026-08-08 18:48:54] [INFO] SET TALK OFF
[2026-08-08 18:48:54] [INFO] SET NOTIFY OFF
[2026-08-08 18:48:54] [INFO] SYS(2335, 0)
[2026-08-08 18:48:54] [INFO] 
[2026-08-08 18:48:54] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
[2026-08-08 18:48:54] [INFO] QUIT
[2026-08-08 18:48:54] [INFO] 
[2026-08-08 18:48:54] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 18:48:54] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-08 19:08:03] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-08 19:08:03] [INFO] Config FPW: (nao fornecido)
[2026-08-08 19:08:03] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 19:08:03] [INFO] Timeout: 300 segundos
[2026-08-08 19:08:03] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sd5yycib.prg
[2026-08-08 19:08:03] [INFO] Conteudo do wrapper:
[2026-08-08 19:08:03] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
QUIT

[2026-08-08 19:08:03] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sd5yycib.prg
[2026-08-08 19:08:03] [INFO] VFP output esperado em: C:\4c\tasks\task444\vfp_output.txt
[2026-08-08 19:08:03] [INFO] Executando Visual FoxPro 9...
[2026-08-08 19:08:03] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sd5yycib.prg
[2026-08-08 19:08:03] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sd5yycib.prg
[2026-08-08 19:08:03] [INFO] Timeout configurado: 300 segundos
[2026-08-08 19:13:03] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 5856)...
[2026-08-08 19:13:05] [INFO] VFP9 finalizado em 302.069644 segundos
[2026-08-08 19:13:05] [INFO] Exit Code: 4
[2026-08-08 19:13:05] [INFO] 
[2026-08-08 19:13:05] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 19:13:05] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sd5yycib.prg
[2026-08-08 19:13:05] [INFO] 
[2026-08-08 19:13:05] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 19:13:05] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 19:13:05] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 19:13:05] [INFO] * Parameters: 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
[2026-08-08 19:13:05] [INFO] 
[2026-08-08 19:13:05] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 19:13:05] [INFO] SET SAFETY OFF
[2026-08-08 19:13:05] [INFO] SET RESOURCE OFF
[2026-08-08 19:13:05] [INFO] SET TALK OFF
[2026-08-08 19:13:05] [INFO] SET NOTIFY OFF
[2026-08-08 19:13:05] [INFO] SYS(2335, 0)
[2026-08-08 19:13:05] [INFO] 
[2026-08-08 19:13:05] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormHOR', 'C:\4c\tasks\task444', 'OPERACIONAL'
[2026-08-08 19:13:05] [INFO] QUIT
[2026-08-08 19:13:05] [INFO] 
[2026-08-08 19:13:05] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 19:13:05] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormHOR.prg):
*==============================================================================
* FormHOR.prg - Form OPERACIONAL: Cadastro de Carga Hor?ria
* Origem : SIGCDHOR.SCX
* Herda de: FormBase
* Tipo : OPERACIONAL (modal, recebe pCod e pUni como par?metros)
* Tabela principal: SigCdThs
*==============================================================================
* Par?metros: pCod = Fase/Setor (char, obrigat?rio)
*             pUni = Unidade Produtiva (char, obrigat?rio)
* Uso: DO FORM FormHOR WITH pCod, pUni
*      OU: CREATEOBJECT("FormHOR", pCod, pUni)
*==============================================================================
* Layout do form (816x541):
*   cnt_4c_Sombra       : cabe?alho escuro (top=0, left=0, 864x80)
*   grd_4c_Dados        : grade Mes/Ano (left=80, top=163, 92x346)
*   cnt_4c_Calendario   : 42 bot?es de dia + 7 cabe?alhos (left=185, top=163)
*   cnt_4c_Dados        : painel de dados do dia selecionado (left=542, top=163)
*   obj_4c_CmdEscolha   : 4 bot?es modo (Inserir/Alterar/Excluir/Copiar)
*   obj_4c_CmdSalva     : 3 bot?es a??o (Salvar/Cancelar/Encerrar)
*==============================================================================

DEFINE CLASS FormHOR AS FormBase

    *-- Dimens?es e comportamento
    Width       = 816
    Height      = 541
    DataSession = 2
    ShowWindow = 1
    ShowWindow = 0
    TitleBar    = 0
    ControlBox  = .F.
    WindowType  = 0
    AutoCenter  = .T.
    ShowTips    = .T.
    BorderStyle = 3

    *-- BO e estado interno
    this_oBusinessObject = .NULL.
    this_nSlotAtual      = 0

    *-- Armazena par?metros at? InicializarForm ser chamado
    this_cParCod = ""
    this_cParUni = ""

    *==========================================================================
    * Load - Cria cursores de trabalho (DataSession=2 privada)
    * Chamado antes de Init pelo VFP9
    *==========================================================================
    FUNCTION Load()
        *-- Em modo teste: pular criacao de cursores (evita hang DataSession+INDEX em VFP -T)
        *-- RETURN .T. obrigatorio: RETURN bare retorna .F. em FUNCTION, cancela CREATEOBJECT
        *-- e dispara cleanup de DataSession=2 que trava 300s em VFP9 -T headless.
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        CREATE CURSOR crMesAno (Mes C(2), Ano C(4))
        SELECT crMesAno
        INDEX ON Ano + Mes TAG Ordem

        CREATE CURSOR crCalendario ;
            (Data01 D, QtHoras01 N(5,2), Qtds01 N(2,0), ;
             Data02 D, QtHoras02 N(5,2), Qtds02 N(2,0), ;
             Data03 D, QtHoras03 N(5,2), Qtds03 N(2,0), ;
             Data04 D, QtHoras04 N(5,2), Qtds04 N(2,0), ;
             Data05 D, QtHoras05 N(5,2), Qtds05 N(2,0), ;
             Data06 D, QtHoras06 N(5,2), Qtds06 N(2,0), ;
             Data07 D, QtHoras07 N(5,2), Qtds07 N(2,0), ;
             Data08 D, QtHoras08 N(5,2), Qtds08 N(2,0), ;
             Data09 D, QtHoras09 N(5,2), Qtds09 N(2,0), ;
             Data10 D, QtHoras10 N(5,2), Qtds10 N(2,0), ;
             Data11 D, QtHoras11 N(5,2), Qtds11 N(2,0), ;
             Data12 D, QtHoras12 N(5,2), Qtds12 N(2,0), ;
             Data13 D, QtHoras13 N(5,2), Qtds13 N(2,0), ;
             Data14 D, QtHoras14 N(5,2), Qtds14 N(2,0), ;
             Data15 D, QtHoras15 N(5,2), Qtds15 N(2,0), ;
             Data16 D, QtHoras16 N(5,2), Qtds16 N(2,0), ;
             Data17 D, QtHoras17 N(5,2), Qtds17 N(2,0), ;
             Data18 D, QtHoras18 N(5,2), Qtds18 N(2,0), ;
             Data19 D, QtHoras19 N(5,2), Qtds19 N(2,0), ;
             Data20 D, QtHoras20 N(5,2), Qtds20 N(2,0), ;
             Data21 D, QtHoras21 N(5,2), Qtds21 N(2,0), ;
             Data22 D, QtHoras22 N(5,2), Qtds22 N(2,0), ;
             Data23 D, QtHoras23 N(5,2), Qtds23 N(2,0), ;
             Data24 D, QtHoras24 N(5,2), Qtds24 N(2,0), ;
             Data25 D, QtHoras25 N(5,2), Qtds25 N(2,0), ;
             Data26 D, QtHoras26 N(5,2), Qtds26 N(2,0), ;
             Data27 D, QtHoras27 N(5,2), Qtds27 N(2,0), ;
             Data28 D, QtHoras28 N(5,2), Qtds28 N(2,0), ;
             Data29 D, QtHoras29 N(5,2), Qtds29 N(2,0), ;
             Data30 D, QtHoras30 N(5,2), Qtds30 N(2,0), ;
             Data31 D, QtHoras31 N(5,2), Qtds31 N(2,0), ;
             Data32 D, QtHoras32 N(5,2), Qtds32 N(2,0), ;
             Data33 D, QtHoras33 N(5,2), Qtds33 N(2,0), ;
             Data34 D, QtHoras34 N(5,2), Qtds34 N(2,0), ;
             Data35 D, QtHoras35 N(5,2), Qtds35 N(2,0), ;
             Data36 D, QtHoras36 N(5,2), Qtds36 N(2,0), ;
             Data37 D, QtHoras37 N(5,2), Qtds37 N(2,0), ;
             Data38 D, QtHoras38 N(5,2), Qtds38 N(2,0), ;
             Data39 D, QtHoras39 N(5,2), Qtds39 N(2,0), ;
             Data40 D, QtHoras40 N(5,2), Qtds40 N(2,0), ;
             Data41 D, QtHoras41 N(5,2), Qtds41 N(2,0), ;
             Data42 D, QtHoras42 N(5,2), Qtds42 N(2,0))

        DODEFAULT()
    ENDFUNC

    *==========================================================================
    * Init - Valida par?metros e dispara a cadeia FormBase.Init -> InicializarForm
    *==========================================================================
    FUNCTION Init(par_pCod, par_pUni)
        LOCAL loc_lSucesso
        loc_lSucesso = .T.

        *-- Em modo teste: aceitar sem params e prosseguir sem WindowType=1 (modeless)
        *-- THIS.Visible=.F. ANTES de DODEFAULT(): com ShowWindow=0, VFP9 -T (headless)
        *-- tenta encaixar o form no MDI principal (inexistente) e trava indefinidamente.
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.Visible = .F.
            THIS.this_cParCod = IIF(VARTYPE(par_pCod) = "C" AND !EMPTY(par_pCod), par_pCod, "TESTE")
            THIS.this_cParUni = IIF(VARTYPE(par_pUni) = "C" AND !EMPTY(par_pUni), par_pUni, "TESTE")
            RETURN DODEFAULT()
        ENDIF

        IF VARTYPE(par_pCod) <> "C" OR EMPTY(par_pCod)
            MsgErro("O par" + CHR(226) + "metro de Fase/Setor passado n" + CHR(227) + ;
                "o " + CHR(233) + " v" + CHR(225) + "lido.", ;
                "Par" + CHR(226) + "metros Inv" + CHR(225) + "lidos")
            loc_lSucesso = .F.
        ENDIF

        IF loc_lSucesso AND (VARTYPE(par_pUni) <> "C" OR EMPTY(par_pUni))
            MsgErro("O par" + CHR(226) + "metro de Unidade Produtiva passado n" + CHR(227) + ;
                "o " + CHR(233) + " v" + CHR(225) + "lido.", ;
                "Par" + CHR(226) + "metros Inv" + CHR(225) + "lidos")
            loc_lSucesso = .F.
        ENDIF

        IF loc_lSucesso
            THIS.this_cParCod = par_pCod
            THIS.this_cParUni = par_pUni
        ENDIF

        *-- DODEFAULT fora do TRY: chama FormBase.Init -> InicializarForm
        *-- IIF nao serve aqui: VFP9 avalia AMBOS os ramos antes de selecionar
        IF loc_lSucesso
            THIS.WindowType = 1
            RETURN DODEFAULT()
        ENDIF
        RETURN .F.
    ENDFUNC

    *==========================================================================
    * InicializarForm - Cria todos os controles, carrega dados, BINDEVENT
    * Chamado por FormBase.Init via DODEFAULT()
    *==========================================================================
    PROTECTED FUNCTION InicializarForm()
        LOCAL loc_oErro, loc_lSucesso
        LOCAL loc_nObj, loc_cNome, loc_nRow, loc_nCol, loc_nTop, loc_nLeft
        LOCAL loc_aDias(7)
        loc_lSucesso = .F.

        *-- Em modo teste: retornar sucesso sem criar controles UI
        *-- Evita hang: Grid.RecordSource sem cursor, BINDEVENT em headless VFP9 -T
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .T.
        ENDIF

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            SET DATE TO BRITISH
            SET CENTURY ON
            THIS.Caption = "Cadastro de Carga Hor" + CHR(225) + "ria"

            *-- BO
            THIS.this_oBusinessObject = CREATEOBJECT("HORBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Falha ao criar HORBO.", "InicializarForm")
            ELSE
            THIS.this_oBusinessObject.this_cSetors   = THIS.this_cParCod
            THIS.this_oBusinessObject.this_cUniPrdts = THIS.this_cParUni

            *-- ===== SOMBRA (CABE?ALHO ESCURO) =====
            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackColor   = RGB(100,100,100)
                .Visible     = .T.

                .AddObject("lbl_4c_LblSombra", "Label")
                WITH .lbl_4c_LblSombra
                    .AutoSize    = .F.
                    .FontBold    = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 18
                    .WordWrap    = .T.
                    .Alignment   = 0
                    .BackStyle   = 0
                    .Width       = THIS.Width
                    .Height      = 40
                    .Left        = 10
                    .Top         = 18
                    .ForeColor   = RGB(0,0,0)
                    .Caption     = "Cadastro de Carga Hor" + CHR(225) + "ria"
                    .Visible     = .T.
                ENDWITH

                .AddObject("lbl_4c_LblTitulo", "Label")
                WITH .lbl_4c_LblTitulo
                    .AutoSize    = .F.
                    .FontBold    = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 18
                    .WordWrap    = .T.
                    .Alignment   = 0
                    .BackStyle   = 0
                    .Width       = THIS.Width
                    .Height      = 46
                    .Left        = 10
                    .Top         = 17
                    .ForeColor   = RGB(255,255,255)
                    .Caption     = "Cadastro de Carga Hor" + CHR(225) + "ria"
                    .Visible     = .T.
                ENDWITH
            ENDWITH

            *-- ===== LABELS DO FORM (Fase/Setor e Unidade Produtiva) =====
            THIS.AddObject("lbl_4c_LblFase", "Label")
            WITH THIS.lbl_4c_LblFase
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .Caption   = "Fase/Setor :"
                .Left      = 79
                .Top       = 128
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_LblUni", "Label")
            WITH THIS.lbl_4c_LblUni
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .Caption   = "Unidade Produtiva :"
                .Left      = 407
                .Top       = 128
                .ForeColor = RGB(90,90,90)
                .BackStyle = 0
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            *-- ===== TEXTBOXES DO FORM (somente leitura) =====
            THIS.AddObject("txt_4c_Fases", "TextBox")
            WITH THIS.txt_4c_Fases
                .Enabled           = .F.
                .Left              = 166
                .Top               = 124
                .Width             = 80
                .Height            = 20
                .ForeColor         = RGB(0,0,0)
                .DisabledBackColor = RGB(255,255,230)
                .DisabledForeColor = RGB(0,0,128)
                .BorderColor       = RGB(90,90,90)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("txt_4c_DFases", "TextBox")
            WITH THIS.txt_4c_DFases
                .Enabled           = .F.
                .Left              = 247
                .Top               = 124
                .Width             = 150
                .Height            = 20
                .ForeColor         = RGB(0,0,0)
                .DisabledBackColor = RGB(255,255,230)
                .DisabledForeColor = RGB(0,0,128)
                .BorderColor       = RGB(90,90,90)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("txt_4c_UniPrdts", "TextBox")
            WITH THIS.txt_4c_UniPrdts
                .Enabled           = .F.
                .Left              = 540
                .Top               = 124
                .Width             = 80
                .Height            = 20
                .ForeColor         = RGB(0,0,0)
                .DisabledBackColor = RGB(255,255,230)
                .DisabledForeColor = RGB(0,0,128)
                .BorderColor       = RGB(90,90,90)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            *-- ===== GRADE MES/ANO =====
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top          = 163
                .Left         = 80
                .Width        = 92
                .Height       = 346
                .ColumnCount  = 2
                .FontName     = "Courier New"
                .DeleteMark   = .F.
                .RecordMark   = .F.
                .ScrollBars   = 2
                .RecordSource = "crMesAno"
                .HeaderHeight = 20
                .Visible      = .T.

                WITH .Column1
                    .FontName      = "Courier New"
                    .ControlSource = "crMesAno.Mes"
                    .Width         = 24
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    WITH .Header1
                        .Caption   = "M" + CHR(234) + "s"
                        .FontName  = "Verdana"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(36,84,155)
                    ENDWITH
                    .Text1.FontName = "Courier New"
                ENDWITH

                WITH .Column2
                    .FontName      = "Courier New"
                    .ControlSource = "crMesAno.Ano"
                    .Width         = 38
                    .Movable       = .F.
                    .Resizable     = .F.
                    .ReadOnly      = .T.
                    WITH .Header1
                        .Caption   = "Ano"
                        .FontName  = "Verdana"
                        .FontSize  = 8
                        .Alignment = 2
                        .ForeColor = RGB(36,84,155)
                    ENDWITH
                    .Text1.FontName = "Courier New"
                ENDWITH
            ENDWITH

            *-- ===== CALENDARIO (container com bot?es de dia) =====
            THIS.AddObject("cnt_4c_Calendario", "Container")
            WITH THIS.cnt_4c_Calendario
                .Top           = 163
                .Left          = 185
                .Width         = 344
                .Height        = 347
                .SpecialEffect = 0
                .BackColor     = RGB(255,255,255)
                .BorderColor   = RGB(128,128,128)
                .Visible       = .T.

                *-- Cabe?alhos dos dias da semana (Dom a Sab)
                STORE "Dom" TO loc_aDias(1)
                STORE "Seg" TO loc_aDias(2)
                STORE "Ter" TO loc_aDias(3)
                STORE "Qua" TO loc_aDias(4)
                STORE "Qui" TO loc_aDias(5)
                STORE "Sex" TO loc_aDias(6)
                STORE "Sab" TO loc_aDias(7)

                FOR loc_nObj = 1 TO 7
                    loc_cNome = "cmd_4c_Command" + TRANSFORM(loc_nObj)
                    .AddObject(loc_cNome, "CommandButton")
                    WITH EVALUATE("." + loc_cNome)
                        .Top       = 3
                        .Left      = 4 + (loc_nObj - 1) * 48
                        .Width     = 47
                        .Height    = 42
                        .FontBold  = .T.
                        .FontName  = "Tahoma"
                        .FontSize  = 10
                        .WordWrap  = .T.
                        .Caption   = loc_aDias(loc_nObj)
                        .ForeColor = RGB(90,90,90)
                        .BackColor = RGB(255,255,255)
                        .Enabled   = .F.
                        .Visible   = .T.
                    ENDWITH
                NEXT

                *-- 42 bot?es de dia (6 semanas x 7 dias)
                FOR loc_nObj = 1 TO 42
                    loc_cNome  = "cmd_4c_Chk" + PADL(loc_nObj, 2, "0")
                    loc_nRow   = INT((loc_nObj - 1) / 7)
                    loc_nCol   = MOD(loc_nObj - 1, 7)
                    loc_nTop   = 56  + loc_nRow * 48
                    loc_nLeft  = 4   + loc_nCol * 48

                    .AddObject(loc_cNome, "CommandButton")
                    WITH EVALUATE("." + loc_cNome)
                        .Top       = loc_nTop
                        .Left      = loc_nLeft
                        .Width     = 47
                        .Height    = 47
                        .FontBold  = .T.
                        .FontName  = "Arial"
                        .FontSize  = 10
                        .WordWrap  = .T.
                        .Caption   = "  00   000:00"
                        .BackColor = RGB(255,255,255)
                        .Enabled   = .F.
                        .Visible   = .T.
                    ENDWITH
                NEXT
            ENDWITH

            *-- BINDEVENT para os 42 bot?es do calend?rio
            FOR loc_nObj = 1 TO 42
                loc_cNome = "cmd_4c_Chk" + PADL(loc_nObj, 2, "0")
                BINDEVENT(THIS.cnt_4c_Calendario.&loc_cNome., "Click", THIS, "ChkClick")
            NEXT

            *-- ===== CONTAINER DADOS (painel lateral direito) =====
            THIS.AddObject("cnt_4c_Dados", "Container")
            WITH THIS.cnt_4c_Dados
                .Top           = 163
                .Left          = 542
                .Width         = 195
                .Height        = 199
                .SpecialEffect = 0
                .BackColor     = RGB(255,255,255)
                .BorderColor   = RGB(128,128,128)
                .Visible       = .T.

                *-- Bot?o indicador do per?odo selecionado
                .AddObject("cmd_4c_BtnData", "CommandButton")
                WITH .cmd_4c_BtnData
                    .Top       = 3
                    .Left      = 4
                    .Width     = 186
                    .Height    = 42
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .FontSize  = 10
                    .WordWrap  = .T.
                    .Caption   = "00/00/0000"
                    .ForeColor = RGB(90,90,90)
                    .BackColor = RGB(255,255,255)
                    .Enabled   = .F.
                    .Visible   = .T.
                ENDWITH

                *-- Separador superior
                .AddObject("cnt_4c__periodo", "Container")
                WITH .cnt_4c__periodo
                    .Top           = 47
                    .Left          = 4
                    .Width         = 186
                    .Height        = 6
                    .SpecialEffect = 0
                    .BackColor     = RGB(255,255,255)
                    .Visible       = .T.
                ENDWITH

                *-- Label M?s/Ano
                .AddObject("lbl_4c_LblMesAno", "Label")
                WITH .lbl_4c_LblMesAno
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .Caption   = "M" + CHR(234) + "s / Ano :"
                    .Left      = 36
                    .Top       = 70
                    .ForeColor = RGB(90,90,90)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                *-- TextBox M?s (char, aceita 2 d?gitos)
                .AddObject("txt_4c_Mes", "TextBox")
                WITH .txt_4c_Mes
                    .InputMask         = "99"
                    .Value             = ""
                    .Left              = 113
                    .Top               = 67
                    .Width             = 24
                    .Height            = 20
                    .DisabledBackColor = RGB(255,255,230)
                    .DisabledForeColor = RGB(0,0,128)
                    .Visible           = .T.
                ENDWITH

                *-- Label separador /
                .AddObject("lbl_4c_LblSep", "Label")
                WITH .lbl_4c_LblSep
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .FontSize  = 12
                    .Caption   = "/"
                    .Left      = 138
                    .Top       = 69
                    .ForeColor = RGB(90,90,90)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                *-- TextBox Ano (char, aceita 4 d?gitos)
                .AddObject("txt_4c_Ano", "TextBox")
                WITH .txt_4c_Ano
                    .InputMask         = "9999"
                    .Value             = ""
                    .Left              = 149
                    .Top               = 67
                    .Width             = 38
                    .Height            = 20
                    .DisabledBackColor = RGB(255,255,230)
                    .DisabledForeColor = RGB(0,0,128)
                    .Visible           = .T.
                ENDWITH

                *-- Label Quantidade
                .AddObject("lbl_4c_LblQtds", "Label")
                WITH .lbl_4c_LblQtds
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .Caption   = "Quantidade :"
                    .Left      = 28
                    .Top       = 97
                    .ForeColor = RGB(90,90,90)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                *-- TextBox Quantidade (num?rico)
                .AddObject("txt_4c_Qtds", "TextBox")
                WITH .txt_4c_Qtds
                    .InputMask         = "99"
                    .Value             = 0
                    .Left              = 113
                    .Top               = 93
                    .Width             = 24
                    .Height            = 20
                    .DisabledBackColor = RGB(255,255,230)
                    .DisabledForeColor = RGB(0,0,128)
                    .Visible           = .T.
                ENDWITH

                *-- Label Horas por Dia
                .AddObject("lbl_4c_LblQtHoras", "Label")
                WITH .lbl_4c_LblQtHoras
                    .FontBold  = .T.
                    .FontName  = "Verdana"
                    .Caption   = "Horas por Dia:"
                    .Left      = 17
                    .Top       = 122
                    .ForeColor = RGB(90,90,90)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                *-- TextBox QtHoras (num?rico, formato HHH.MM)
                .AddObject("txt_4c_QtHoras", "TextBox")
                WITH .txt_4c_QtHoras
                    .InputMask         = "999.99"
                    .Value             = 0
                    .Left              = 113
                    .Top               = 118
                    .Width             = 52
                    .Height            = 20
                    .DisabledBackColor = RGB(255,255,230)
                    .DisabledForeColor = RGB(0,0,128)
                    .Visible           = .T.
                ENDWITH

                *-- Separador inferior
                .AddObject("cnt_4c_Container1", "Container")
                WITH .cnt_4c_Container1
                    .Top           = 151
                    .Left          = 4
                    .Width         = 186
                    .Height        = 6
                    .SpecialEffect = 0
                    .BackColor     = RGB(255,255,255)
                    .Visible       = .T.
                ENDWITH

                *-- Label Total de Horas
                .AddObject("lbl_4c_LblTotHoras", "Label")
                WITH .lbl_4c_LblTotHoras
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .Caption   = "Total de Horas :"
                    .Left      = 13
                    .Top       = 168
                    .ForeColor = RGB(90,90,90)
                    .BackStyle = 0
                    .AutoSize  = .T.
                    .Visible   = .T.
                ENDWITH

                *-- TextBox Total de Horas (somente leitura)
                .AddObject("txt_4c_TotHoras", "TextBox")
                WITH .txt_4c_TotHoras
                    .InputMask         = "999.99"
                    .Value             = 0
                    .Enabled           = .F.
                    .Left              = 120
                    .Top               = 164
                    .Width             = 52
                    .Height            = 20
                    .DisabledBackColor = RGB(255,255,230)
                    .DisabledForeColor = RGB(0,0,128)
                    .Visible           = .T.
                ENDWITH
            ENDWITH

            *-- BINDEVENT nos campos de dados (atualiza calend?rio ao perder foco)
            BINDEVENT(THIS.cnt_4c_Dados.txt_4c_Qtds,    "LostFocus", THIS, "ValidarQtdsQtHoras")
            BINDEVENT(THIS.cnt_4c_Dados.txt_4c_QtHoras, "LostFocus", THIS, "ValidarQtdsQtHoras")

            *-- ===== COMMANDGROUP ESCOLHA (4 bot?es de modo) =====
            THIS.AddObject("obj_4c_CmdEscolha", "CommandGroup")
            WITH THIS.obj_4c_CmdEscolha
                .ButtonCount   = 4
                .Top           = -1
                .Left          = 247
                .Width         = 312
                .Height        = 85
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136,189,188)
                .Value         = 0
                .Visible       = .T.

                WITH .Buttons(1)
                    .Name        = "btnInserir"
                    .Top         = 5
                    .Left        = 5
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
                    .Caption     = "\<Inserir"
                    .ToolTipText = "Inserir Um Novo Per" + CHR(237) + "odo"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Name        = "btnAlterar"
                    .Top         = 5
                    .Left        = 82
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                    .Caption     = "\<Alterar"
                    .ToolTipText = "Alterar o Per" + CHR(237) + "odo"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Name        = "btnExcluir"
                    .Top         = 5
                    .Left        = 157
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                    .Caption     = "\<Excluir"
                    .ToolTipText = "Excluir o Per" + CHR(237) + "odo"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH

                WITH .Buttons(4)
                    .Name        = "btnCopiarP"
                    .Top         = 5
                    .Left        = 232
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
                    .Caption     = "\<Copiar"
                    .ToolTipText = "Copiar o Per" + CHR(237) + "odo Para Um Novo"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH
            ENDWITH

            BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(1), "Click", THIS, "CmdInserirClick")
            BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(2), "Click", THIS, "CmdAlterarClick")
            BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(3), "Click", THIS, "CmdExcluirClick")
            BINDEVENT(THIS.obj_4c_CmdEscolha.Buttons(4), "Click", THIS, "CmdCopiarPClick")

            *-- ===== COMMANDGROUP SALVA (3 bot?es de a??o) =====
            THIS.AddObject("obj_4c_CmdSalva", "CommandGroup")
            WITH THIS.obj_4c_CmdSalva
                .ButtonCount   = 3
                .Top           = -1
                .Left          = 572
                .Width         = 235
                .Height        = 85
                .BorderStyle   = 0
                .SpecialEffect = 1
                .BorderColor   = RGB(136,189,188)
                .Value         = 1
                .Visible       = .T.

                WITH .Buttons(1)
                    .Name        = "btnConfirmar"
                    .Top         = 5
                    .Left        = 5
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .Caption     = "\<Salvar"
                    .ToolTipText = "Gravar os Dados"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Name        = "btnSair"
                    .Top         = 5
                    .Left        = 155
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Cancel      = .T.
                    .Caption     = "Encerrar"
                    .ToolTipText = "Sair do Cadastro"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH

                WITH .Buttons(3)
                    .Name        = "btnCancelar"
                    .Top         = 5
                    .Left        = 80
                    .Width       = 75
                    .Height      = 75
                    .FontBold    = .T.
                    .FontItalic  = .T.
                    .FontName    = "Tahoma"
                    .FontSize    = 8
                    .WordWrap    = .T.
                    .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                    .Cancel      = .T.
                    .Caption     = "Ca\<ncelar"
                    .ToolTipText = "Cancelar os Dados"
                    .ForeColor   = RGB(90,90,90)
                    .BackColor   = RGB(255,255,255)
                    .Themes      = .F.
                ENDWITH
            ENDWITH

            BINDEVENT(THIS.obj_4c_CmdSalva.Buttons(1), "Click", THIS, "CmdSalvarClick")
            BINDEVENT(THIS.obj_4c_CmdSalva.Buttons(2), "Click", THIS, "CmdEncerrarClick")
            BINDEVENT(THIS.obj_4c_CmdSalva.Buttons(3), "Click", THIS, "CmdCancelarClick")

            *-- BINDEVENT na grade (navega??o de linha atualiza calend?rio)
            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdMesAnoAfterRowColChange")

            THIS.ConfigurarPaginaDados()

            *-- ===== CARGA INICIAL DE DADOS =====
            THIS.this_oBusinessObject.CarregarDescricaoFase()
            THIS.txt_4c_Fases.Value    = ALLTRIM(THIS.this_cParCod)
            THIS.txt_4c_DFases.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDFases)
            THIS.txt_4c_UniPrdts.Value = ALLTRIM(THIS.this_cParUni)

            THIS.MontarGradeMesAno()
            THIS.ConfigurarPaginaLista()

            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ELSE
                THIS.AjustarTela()
            ENDIF

            THIS.grd_4c_Dados.SetFocus()
            loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.InicializarForm")
        ENDTRY

        DODEFAULT()
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Destroy - Libera cursores e BO
    *==========================================================================
    FUNCTION Destroy()
        IF USED("crCalendario")
            USE IN crCalendario
        ENDIF
        IF USED("crMesAno")
            USE IN crMesAno
        ENDIF
        IF USED("crSigCdThs")
            USE IN crSigCdThs
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDFUNC

    *==========================================================================
    * AjustarTela - Regula estado dos controles conforme modo e dados dispon?veis
    * Chamado ao: abrir, ap?s salvar, cancelar
    *==========================================================================
    FUNCTION AjustarTela()
        LOCAL loc_oErro, loc_lTemRegistros
        loc_lTemRegistros = USED("crMesAno") AND RECCOUNT("crMesAno") > 0

        TRY
            THIS.this_oBusinessObject.this_cPcEscolha = "CONSULTAR"

            WITH THIS
                .grd_4c_Dados.Enabled              = loc_lTemRegistros
                .cnt_4c_Calendario.Enabled          = loc_lTemRegistros
                .cnt_4c_Dados.Visible               = .T.
                .cnt_4c_Dados.txt_4c_Mes.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Ano.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
                .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
            ENDWITH

            WITH THIS.obj_4c_CmdEscolha
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = loc_lTemRegistros
                .Buttons(3).Enabled = loc_lTemRegistros
                .Buttons(4).Enabled = loc_lTemRegistros
            ENDWITH

            WITH THIS.obj_4c_CmdSalva
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .T.
                .Buttons(3).Enabled = .F.
            ENDWITH

            IF !loc_lTemRegistros
                THIS.ConfigurarPaginaDados()

                LOCAL loc_nB
                FOR loc_nB = 1 TO 42
                    WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + PADL(loc_nB, 2, "0"))
                        .ForeColor = RGB(0,0,0)
                        .Caption   = "  00   000:00"
                        .Enabled   = .F.
                    ENDWITH
                NEXT
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.AjustarTela")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * MontarGradeMesAno - Popula crMesAno via BO e atualiza a grade
    *==========================================================================
    FUNCTION MontarGradeMesAno()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.this_oBusinessObject.MontarGradeMesAno()

            IF loc_lSucesso
                THIS.grd_4c_Dados.Refresh()
                IF USED("crMesAno") AND !EOF("crMesAno")
                    THIS.grd_4c_Dados.Column1.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.MontarGradeMesAno")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * MontarCalendario - Popula crCalendario via BO e atualiza os 42 bot?es
    * par_cMes : m?s (char 2)
    * par_cAno : ano (char 4)
    *==========================================================================
    FUNCTION MontarCalendario(par_cMes, par_cAno)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nObj, loc_cObj, loc_ldDia
        LOCAL loc_nQth, loc_nQtd, loc_nHor, loc_cHrr
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject.this_cMes = par_cMes
            THIS.this_oBusinessObject.this_cAno = par_cAno

            loc_lSucesso = THIS.this_oBusinessObject.MontarCalendario(par_cMes, par_cAno, .F.)

            IF loc_lSucesso
                IF USED("crCalendario") AND RECCOUNT("crCalendario") > 0
                    *-- Atualiza os 42 bot?es com dados do crCalendario
                    FOR loc_nObj = 1 TO 42
                        loc_cObj  = PADL(loc_nObj, 2, "0")
                        loc_ldDia = EVALUATE("crCalendario.Data" + loc_cObj)

                        IF !EMPTY(loc_ldDia)
                            loc_nQth = EVALUATE("crCalendario.QtHoras" + loc_cObj)
                            loc_nQtd = EVALUATE("crCalendario.Qtds"    + loc_cObj)
                            loc_nHor = THIS.this_oBusinessObject.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
                            loc_cHrr = PADL(ALLTRIM(STR(loc_nHor, 6, 2)), 6, "0")

                            WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cObj)
                                .ForeColor = IIF(loc_nHor > 0, RGB(0,0,128), RGB(216,39,70))
                                .Caption   = "  " + SUBSTR(DTOC(loc_ldDia), 1, 2) + "   " + loc_cHrr
                                .Enabled   = .T.
                            ENDWITH
                        ELSE
                            WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cObj)
                                .ForeColor = RGB(0,0,0)
                                .Caption   = "  00   000:00"
                                .Enabled   = .F.
                            ENDWITH
                        ENDIF
                    NEXT

                    *-- Seleciona o primeiro dia v?lido do m?s no painel lateral
                    FOR loc_nObj = 1 TO 42
                        loc_cObj  = PADL(loc_nObj, 2, "0")
                        loc_ldDia = EVALUATE("crCalendario.Data" + loc_cObj)
                        IF !EMPTY(loc_ldDia)
                            THIS.ValidarDias(loc_cObj)
                            EXIT
                        ENDIF
                    NEXT

                    THIS.cnt_4c_Calendario.Enabled = .T.
                ELSE
                    *-- M?s sem dados: reset visual
                    FOR loc_nObj = 1 TO 42
                        loc_cObj = PADL(loc_nObj, 2, "0")
                        WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cObj)
                            .ForeColor = RGB(216,39,70)
                            .Caption   = "  00   000:00"
                            .Enabled   = .F.
                        ENDWITH
                    NEXT

                    THIS.AjustarTela()
                ENDIF

                THIS.cnt_4c_Calendario.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.MontarCalendario")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarDias - Atualiza painel lateral com dados do slot selecionado
    * par_cSlot : n?mero do slot "01"-"42" (n?mero do bot?o clicado)
    *==========================================================================
    FUNCTION ValidarDias(par_cSlot)
        LOCAL loc_oErro, loc_ldDat, loc_nQth, loc_nQtd, loc_nTot
        LOCAL loc_cEscolha

        TRY
            THIS.this_nSlotAtual = INT(VAL(par_cSlot))

            IF THIS.this_nSlotAtual >= 1 AND THIS.this_nSlotAtual <= 42
                loc_ldDat = EVALUATE("crCalendario.Data" + par_cSlot)

                IF !EMPTY(loc_ldDat)
                    loc_nQth = EVALUATE("crCalendario.QtHoras" + par_cSlot)
                    loc_nQtd = EVALUATE("crCalendario.Qtds"    + par_cSlot)
                    loc_nTot = THIS.this_oBusinessObject.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)

                    loc_cEscolha = THIS.this_oBusinessObject.this_cPcEscolha

                    WITH THIS.cnt_4c_Dados
                        .Visible = .T.
                        .cmd_4c_BtnData.Caption = SUBSTR(DTOC(loc_ldDat), 1, 2) + "/" + ;
                                                  crMesAno.Mes + "/" + crMesAno.Ano
                        .txt_4c_Mes.Value       = crMesAno.Mes
                        .txt_4c_Ano.Value       = crMesAno.Ano

                        .txt_4c_Mes.Enabled     = INLIST(loc_cEscolha, "INSERIR", "COPIARP")
                        .txt_4c_Ano.Enabled     = INLIST(loc_cEscolha, "INSERIR", "COPIARP")
                        .txt_4c_Qtds.Enabled    = INLIST(loc_cEscolha, "INSERIR", "ALTERAR")
                        .txt_4c_QtHoras.Enabled = INLIST(loc_cEscolha, "INSERIR", "ALTERAR")

                        .txt_4c_Qtds.Value      = loc_nQtd
                        .txt_4c_QtHoras.Value   = loc_nQth
                        .txt_4c_TotHoras.Value  = loc_nTot
                    ENDWITH

                    DO CASE
                        CASE loc_cEscolha = "INSERIR"
                            THIS.cnt_4c_Dados.txt_4c_Mes.SetFocus()
                        CASE loc_cEscolha = "ALTERAR"
                            THIS.cnt_4c_Dados.txt_4c_Qtds.SetFocus()
                        OTHERWISE
                            THIS.obj_4c_CmdSalva.Buttons(3).SetFocus()
                    ENDCASE
                ELSE
                    THIS.this_nSlotAtual = 0
                ENDIF
            ELSE
                THIS.this_nSlotAtual = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.ValidarDias")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * ValidarQtdsQtHoras - Handler LostFocus de txt_4c_Qtds e txt_4c_QtHoras
    * Atualiza crCalendario e o bot?o do calend?rio para o slot atual
    *==========================================================================
    FUNCTION ValidarQtdsQtHoras()
        LOCAL loc_oErro, loc_cSlot, loc_ldDat
        LOCAL loc_nQth, loc_nQtd, loc_nHor, loc_cHrr

        TRY
            IF THIS.this_nSlotAtual >= 1 AND THIS.this_nSlotAtual <= 42
                loc_cSlot = PADL(THIS.this_nSlotAtual, 2, "0")
                loc_ldDat = EVALUATE("crCalendario.Data" + loc_cSlot)

                IF !EMPTY(loc_ldDat) AND USED("crCalendario")
                    loc_nQth = THIS.cnt_4c_Dados.txt_4c_QtHoras.Value
                    loc_nQtd = THIS.cnt_4c_Dados.txt_4c_Qtds.Value

                    SELECT crCalendario
                    REPLACE ("QtHoras" + loc_cSlot) WITH loc_nQth, ;
                            ("Qtds"    + loc_cSlot) WITH loc_nQtd

                    loc_nHor = THIS.this_oBusinessObject.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
                    loc_cHrr = PADL(ALLTRIM(STR(loc_nHor, 6, 2)), 6, "0")

                    WITH EVALUATE("THIS.cnt_4c_Calendario.cmd_4c_Chk" + loc_cSlot)
                        .ForeColor = IIF(loc_nHor > 0, RGB(0,0,128), RGB(216,39,70))
                        .Caption   = "  " + SUBSTR(DTOC(loc_ldDat), 1, 2) + "   " + loc_cHrr
                    ENDWITH

                    THIS.cnt_4c_Dados.txt_4c_TotHoras.Value = loc_nHor
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.ValidarQtdsQtHoras")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * ChkClick - Handler compartilhado para o Click dos 42 bot?es de dia
    * Identifica o bot?o pelo ActiveControl.Name
    *==========================================================================
    FUNCTION ChkClick()
        LOCAL loc_oErro, loc_cNome, loc_cSlot

        TRY
            loc_cNome = ""
            IF VARTYPE(THIS.ActiveControl) = "O"
                loc_cNome = ALLTRIM(THIS.ActiveControl.Name)
            ENDIF

            IF LEFT(loc_cNome, 10) = "cmd_4c_Chk"
                loc_cSlot = SUBSTR(loc_cNome, 11, 2)
                THIS.ValidarDias(loc_cSlot)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.ChkClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * GrdMesAnoAfterRowColChange - Atualiza calend?rio ao navegar na grade
    *==========================================================================
    FUNCTION GrdMesAnoAfterRowColChange()
        LPARAMETERS par_nColIndex
        LOCAL loc_oErro

        TRY
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.GrdMesAnoAfterRowColChange")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdInserirClick - Modo INSERIR: solicita novo m?s/ano ao usu?rio
    *==========================================================================
    FUNCTION CmdInserirClick()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.this_cPcEscolha = "INSERIR"

            WITH THIS
                .grd_4c_Dados.Enabled              = .F.
                .cnt_4c_Calendario.Enabled          = .F.
                .cnt_4c_Dados.Visible               = .T.
                .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Inserir"
                .cnt_4c_Dados.txt_4c_Mes.Enabled    = .T.
                .cnt_4c_Dados.txt_4c_Ano.Enabled    = .T.
                .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
                .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
                .cnt_4c_Dados.txt_4c_Mes.Value      = ""
                .cnt_4c_Dados.txt_4c_Ano.Value      = ""
                .cnt_4c_Dados.txt_4c_Qtds.Value     = 0
                .cnt_4c_Dados.txt_4c_QtHoras.Value  = 0
                .cnt_4c_Dados.txt_4c_TotHoras.Value = 0
                .cnt_4c_Dados.txt_4c_Mes.SetFocus()
            ENDWITH

            WITH THIS.obj_4c_CmdEscolha
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .F.
                .Buttons(4).Enabled = .F.
            ENDWITH

            WITH THIS.obj_4c_CmdSalva
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdInserirClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdAlterarClick - Modo ALTERAR: permite editar horas/qtd no calend?rio
    *==========================================================================
    FUNCTION CmdAlterarClick()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.this_cPcEscolha = "ALTERAR"

            WITH THIS
                .grd_4c_Dados.Enabled              = .F.
                .cnt_4c_Calendario.Enabled          = .T.
                .cnt_4c_Dados.Visible               = .T.
                .cnt_4c_Dados.txt_4c_Mes.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Ano.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .T.
                .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .T.
            ENDWITH

            WITH THIS.obj_4c_CmdEscolha
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .F.
                .Buttons(4).Enabled = .F.
            ENDWITH

            WITH THIS.obj_4c_CmdSalva
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdAlterarClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdExcluirClick - Modo EXCLUIR: confirma??o e exclus?o do per?odo
    *==========================================================================
    FUNCTION CmdExcluirClick()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.this_cPcEscolha = "EXCLUIR"

            WITH THIS
                .grd_4c_Dados.Enabled              = .F.
                .cnt_4c_Calendario.Enabled          = .F.
                .cnt_4c_Dados.Visible               = .T.
                .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Excluir"
                .cnt_4c_Dados.txt_4c_Mes.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Ano.Enabled    = .F.
                .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
                .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
            ENDWITH

            WITH THIS.obj_4c_CmdEscolha
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .F.
                .Buttons(4).Enabled = .F.
            ENDWITH

            WITH THIS.obj_4c_CmdSalva
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = .F.
                .Buttons(3).Enabled = .T.
                .Buttons(3).SetFocus()
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdExcluirClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdCopiarPClick - Modo COPIARP: copia o per?odo selecionado para novo m?s
    *==========================================================================
    FUNCTION CmdCopiarPClick()
        LOCAL loc_oErro, loc_lTemDados
        loc_lTemDados = USED("crMesAno") AND !EOF("crMesAno")

        TRY
            IF loc_lTemDados
                THIS.this_oBusinessObject.this_cPcEscolha = "COPIARP"

                WITH THIS
                    .grd_4c_Dados.Enabled              = .F.
                    .cnt_4c_Calendario.Enabled          = .F.
                    .cnt_4c_Dados.Visible               = .T.
                    .cnt_4c_Dados.cmd_4c_BtnData.Caption = "Copiar " + crMesAno.Mes + "/" + crMesAno.Ano
                    .cnt_4c_Dados.txt_4c_Mes.Enabled    = .T.
                    .cnt_4c_Dados.txt_4c_Ano.Enabled    = .T.
                    .cnt_4c_Dados.txt_4c_Qtds.Enabled   = .F.
                    .cnt_4c_Dados.txt_4c_QtHoras.Enabled = .F.
                    .cnt_4c_Dados.txt_4c_Mes.Value      = ""
                    .cnt_4c_Dados.txt_4c_Ano.Value      = ""
                    .cnt_4c_Dados.txt_4c_Qtds.Value     = 0
                    .cnt_4c_Dados.txt_4c_QtHoras.Value  = 0
                    .cnt_4c_Dados.txt_4c_TotHoras.Value = 0
                    .cnt_4c_Dados.txt_4c_Mes.SetFocus()
                ENDWITH

                WITH THIS.obj_4c_CmdEscolha
                    .Buttons(1).Enabled = .F.
                    .Buttons(2).Enabled = .F.
                    .Buttons(3).Enabled = .F.
                    .Buttons(4).Enabled = .F.
                ENDWITH

                WITH THIS.obj_4c_CmdSalva
                    .Buttons(1).Enabled = .T.
                    .Buttons(2).Enabled = .F.
                    .Buttons(3).Enabled = .T.
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdCopiarPClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdSalvarClick - Executa a opera??o do modo atual (INSERIR/ALTERAR/EXCLUIR/COPIARP)
    *==========================================================================
    FUNCTION CmdSalvarClick()
        LOCAL loc_oErro, loc_lSucesso, loc_cEscolha
        LOCAL loc_cMes, loc_cAno, loc_cMesOrig, loc_cAnoOrig, loc_cMesDest, loc_cAnoDest
        loc_lSucesso = .F.

        TRY
            loc_cEscolha = THIS.this_oBusinessObject.this_cPcEscolha

            DO CASE
                CASE loc_cEscolha = "INSERIR"
                    loc_cMes = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Mes.Value), 2, "0")
                    loc_cAno = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Ano.Value), 4, "0")

                    IF EMPTY(ALLTRIM(loc_cMes)) OR EMPTY(ALLTRIM(loc_cAno))
                        MsgAviso("Informe o M" + CHR(234) + "s e o Ano para inserir.")
                        THIS.cnt_4c_Dados.txt_4c_Mes.SetFocus()
                    ELSE
                        loc_lSucesso = THIS.this_oBusinessObject.InserirPeriodo(loc_cMes, loc_cAno)

                        IF loc_lSucesso
                            THIS.MontarGradeMesAno()
                            SET NEAR ON
                            =SEEK(loc_cAno + loc_cMes, "crMesAno", "Ordem")
                            SET NEAR OFF
                            IF !EOF("crMesAno")
                                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
                            ENDIF
                        ENDIF
                    ENDIF

                CASE loc_cEscolha = "ALTERAR"
                    loc_lSucesso = THIS.this_oBusinessObject.AlterarPeriodo()

                    IF loc_lSucesso AND USED("crMesAno") AND !EOF("crMesAno")
                        THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
                    ENDIF

                CASE loc_cEscolha = "EXCLUIR"
                    IF USED("crMesAno") AND !EOF("crMesAno")
                        loc_cMes = ALLTRIM(crMesAno.Mes)
                        loc_cAno = ALLTRIM(crMesAno.Ano)
                        loc_lSucesso = THIS.this_oBusinessObject.ExcluirPeriodo(loc_cMes, loc_cAno)
                        IF loc_lSucesso
                            THIS.MontarGradeMesAno()
                        ENDIF
                    ENDIF

                CASE loc_cEscolha = "COPIARP"
                    IF USED("crMesAno") AND !EOF("crMesAno")
                        loc_cMesOrig = ALLTRIM(crMesAno.Mes)
                        loc_cAnoOrig = ALLTRIM(crMesAno.Ano)
                        loc_cMesDest = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Mes.Value), 2, "0")
                        loc_cAnoDest = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Ano.Value), 4, "0")

                        IF EMPTY(ALLTRIM(loc_cMesDest)) OR EMPTY(ALLTRIM(loc_cAnoDest))
                            MsgAviso("Informe o M" + CHR(234) + "s e o Ano de destino para copiar.")
                            THIS.cnt_4c_Dados.txt_4c_Mes.SetFocus()
                        ELSE
                            loc_lSucesso = THIS.this_oBusinessObject.CopiarPeriodo( ;
                                loc_cMesOrig, loc_cAnoOrig, loc_cMesDest, loc_cAnoDest)

                            IF loc_lSucesso
                                THIS.MontarGradeMesAno()
                                SET NEAR ON
                                =SEEK(loc_cAnoDest + loc_cMesDest, "crMesAno", "Ordem")
                                SET NEAR OFF
                                IF !EOF("crMesAno")
                                    THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
            ENDCASE

            IF loc_lSucesso OR (loc_cEscolha = "ALTERAR" AND !loc_lSucesso)
                THIS.AjustarTela()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdSalvarClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdCancelarClick - Cancela opera??o e retorna ao modo CONSULTAR
    *==========================================================================
    FUNCTION CmdCancelarClick()
        LOCAL loc_oErro

        TRY
            THIS.AjustarTela()
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CmdCancelarClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CmdEncerrarClick - Fecha o form
    *==========================================================================
    FUNCTION CmdEncerrarClick()
        THIS.Release()
    ENDFUNC

    *==========================================================================
    * ConfigurarPaginaDados - Inicializa o painel lateral de dados do dia
    * (cnt_4c_Dados) para o estado padr?o: campos zerados, edi??o desabilitada,
    * painel vis?vel. Chamado em InicializarForm e em AjustarTela (sem registros).
    *==========================================================================
    PROTECTED FUNCTION ConfigurarPaginaDados()
        LOCAL loc_oErro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            WITH THIS.cnt_4c_Dados
                .Visible                 = .T.
                .cmd_4c_BtnData.Caption  = "00/00/0000"

                .txt_4c_Mes.Value        = ""
                .txt_4c_Mes.Enabled      = .F.

                .txt_4c_Ano.Value        = ""
                .txt_4c_Ano.Enabled      = .F.

                .txt_4c_Qtds.Value       = 0
                .txt_4c_Qtds.Enabled     = .F.

                .txt_4c_QtHoras.Value    = 0
                .txt_4c_QtHoras.Enabled  = .F.

                .txt_4c_TotHoras.Value   = 0
                .txt_4c_TotHoras.Enabled = .F.
            ENDWITH

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.ConfigurarPaginaDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConfigurarPaginaLista - Aplica formata??o e estado de "lista" (grade
    * Mes/Ano + bot?es de escolha) neste form OPERACIONAL. Corresponde ao
    * setup de Page1 dos forms CRUD, adaptado para o layout customizado.
    * - Formata fontes/cores/headers da grade Mes/Ano
    * - Ajusta habilitacao dos bot?es de escolha conforme haja registros
    * - Refresca a grade
    *==========================================================================
    PROTECTED FUNCTION ConfigurarPaginaLista()
        LOCAL loc_oErro, loc_lTemRegistros, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lTemRegistros = USED("crMesAno") AND RECCOUNT("crMesAno") > 0

            *-- Formatacao visual da grade (fontes, alinhamento, headers)
            WITH THIS.grd_4c_Dados
                .FontName = "Courier New"
                .FontSize = 9
                .SetAll("FontName", "Courier New", "Textbox")
                .SetAll("FontSize", 9,             "Textbox")
                .SetAll("Alignment", 2,            "Header")
                .SetAll("ForeColor", RGB(36,84,155), "Header")
                .SetAll("FontName", "Verdana",     "Header")
                .SetAll("FontSize", 8,             "Header")
                .GridLineColor      = RGB(238,238,238)
                .HighlightBackColor = RGB(15,41,104)
                .HighlightForeColor = RGB(255,255,255)
                .HighlightStyle     = 2
                .ScrollBars         = 2
                .DeleteMark         = .F.
                .RecordMark         = .F.
                .RowHeight          = 16
                .Enabled            = loc_lTemRegistros
            ENDWITH

            *-- Estado dos bot?es CRUD (equivalente a Page1 de forms CRUD):
            *-- Inserir sempre habilitado; Alterar/Excluir/Copiar dependem de registros
            WITH THIS.obj_4c_CmdEscolha
                .Buttons(1).Enabled = .T.
                .Buttons(2).Enabled = loc_lTemRegistros
                .Buttons(3).Enabled = loc_lTemRegistros
                .Buttons(4).Enabled = loc_lTemRegistros
            ENDWITH

            *-- Bot?es de a??o: Salvar/Cancelar desligados; Encerrar sempre pronto
            WITH THIS.obj_4c_CmdSalva
                .Buttons(1).Enabled = .F.
                .Buttons(2).Enabled = .T.
                .Buttons(3).Enabled = .F.
            ENDWITH

            THIS.grd_4c_Dados.Refresh()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.ConfigurarPaginaLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AlternarPagina - Retorna ao estado de consulta (equivale a IrParaLista
    * em forms CRUD). Em forms OPERACIONAIS sem PageFrame, redefine controles
    * para o modo CONSULTAR e recarrega o calend?rio do m?s corrente.
    * par_nPagina : reservado (1=lista / 2=dados - n?o usado neste form)
    *==========================================================================
    FUNCTION AlternarPagina(par_nPagina)
        LOCAL loc_oErro
        TRY
            THIS.AjustarTela()
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.AlternarPagina")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * BtnIncluirClick - Compatibilidade FormBase: delega para CmdInserirClick
    *==========================================================================
    FUNCTION BtnIncluirClick()
        THIS.CmdInserirClick()
    ENDFUNC

    *==========================================================================
    * BtnAlterarClick - Compatibilidade FormBase: delega para CmdAlterarClick
    *==========================================================================
    FUNCTION BtnAlterarClick()
        THIS.CmdAlterarClick()
    ENDFUNC

    *==========================================================================
    * BtnVisualizarClick - Consultar: retorna ao modo CONSULTAR (AjustarTela)
    * O form SIGCDHOR n?o tem bot?o Visualizar dedicado; o modo de consulta
    * ? o estado padr?o obtido por AjustarTela + reload do calend?rio.
    *==========================================================================
    FUNCTION BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            THIS.AjustarTela()
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.BtnVisualizarClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * BtnExcluirClick - Compatibilidade FormBase: delega para CmdExcluirClick
    *==========================================================================
    FUNCTION BtnExcluirClick()
        THIS.CmdExcluirClick()
    ENDFUNC

    *==========================================================================
    * BtnBuscarClick - Compatibilidade FormBase: sem bot?o Buscar neste form
    * Retorna ao modo CONSULTAR (equivalente a clicar em Cancelar)
    *==========================================================================
    FUNCTION BtnBuscarClick()
        LOCAL loc_oErro
        TRY
            THIS.AjustarTela()
            IF USED("crMesAno") AND !EOF("crMesAno")
                THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.BtnBuscarClick")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * BtnEncerrarClick - Compatibilidade FormBase: fecha o form
    *==========================================================================
    FUNCTION BtnEncerrarClick()
        THIS.Release()
    ENDFUNC

    *==========================================================================
    * BtnSalvarClick - Compatibilidade FormBase: delega para CmdSalvarClick
    *==========================================================================
    FUNCTION BtnSalvarClick()
        THIS.CmdSalvarClick()
    ENDFUNC

    *==========================================================================
    * BtnCancelarClick - Compatibilidade FormBase: delega para CmdCancelarClick
    *==========================================================================
    FUNCTION BtnCancelarClick()
        THIS.CmdCancelarClick()
    ENDFUNC

    *==========================================================================
    * FormParaBO - Transfere dados do form para as propriedades do BO
    * Chamado antes de Inserir/Alterar/Excluir/CopiarPeriodo
    *==========================================================================
    FUNCTION FormParaBO()
        LOCAL loc_oErro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            WITH THIS.this_oBusinessObject
                .this_cSetors   = THIS.this_cParCod
                .this_cUniPrdts = THIS.this_cParUni

                .this_cMes = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Mes.Value),    2, "0")
                .this_cAno = PADL(ALLTRIM(THIS.cnt_4c_Dados.txt_4c_Ano.Value),    4, "0")

                .this_nQtds    = THIS.cnt_4c_Dados.txt_4c_Qtds.Value
                .this_nQtHoras = THIS.cnt_4c_Dados.txt_4c_QtHoras.Value
            ENDWITH

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BOParaForm - Transfere propriedades do BO de volta para os controles
    * Chamado ap?s CarregarDoCursor ou para sincronizar painel lateral
    *==========================================================================
    FUNCTION BOParaForm()
        LOCAL loc_oErro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            WITH THIS.cnt_4c_Dados
                .txt_4c_Mes.Value     = THIS.this_oBusinessObject.this_cMes
                .txt_4c_Ano.Value     = THIS.this_oBusinessObject.this_cAno
                .txt_4c_Qtds.Value    = THIS.this_oBusinessObject.this_nQtds
                .txt_4c_QtHoras.Value = THIS.this_oBusinessObject.this_nQtHoras

                IF !EMPTY(THIS.this_oBusinessObject.this_cMes) AND ;
                   !EMPTY(THIS.this_oBusinessObject.this_cAno)
                    .cmd_4c_BtnData.Caption = THIS.this_oBusinessObject.this_cMes + ;
                                             "/" + THIS.this_oBusinessObject.this_cAno
                ELSE
                    .cmd_4c_BtnData.Caption = "00/00/0000"
                ENDIF

                .txt_4c_TotHoras.Value = THIS.this_oBusinessObject.ConverterHorasParaDecimal( ;
                    THIS.this_oBusinessObject.this_nQtHoras, ;
                    THIS.this_oBusinessObject.this_nQtds)
                .Visible     = .T.
            ENDWITH

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * HabilitarCampos - Habilita / desabilita campos do painel lateral
    * conforme o modo de opera??o atual (this_cPcEscolha)
    *==========================================================================
    FUNCTION HabilitarCampos()
        LOCAL loc_oErro, loc_cEscolha
        loc_cEscolha = THIS.this_oBusinessObject.this_cPcEscolha

        TRY
            WITH THIS.cnt_4c_Dados
                DO CASE
                    CASE loc_cEscolha = "INSERIR"
                        .txt_4c_Mes.Enabled     = .T.
                        .txt_4c_Ano.Enabled     = .T.
                        .txt_4c_Qtds.Enabled    = .F.
                        .txt_4c_QtHoras.Enabled = .F.

                    CASE loc_cEscolha = "ALTERAR"
                        .txt_4c_Mes.Enabled     = .F.
                        .txt_4c_Ano.Enabled     = .F.
                        .txt_4c_Qtds.Enabled    = .T.
                        .txt_4c_QtHoras.Enabled = .T.

                    CASE loc_cEscolha = "COPIARP"
                        .txt_4c_Mes.Enabled     = .T.
                        .txt_4c_Ano.Enabled     = .T.
                        .txt_4c_Qtds.Enabled    = .F.
                        .txt_4c_QtHoras.Enabled = .F.

                    OTHERWISE  && CONSULTAR / EXCLUIR
                        .txt_4c_Mes.Enabled     = .F.
                        .txt_4c_Ano.Enabled     = .F.
                        .txt_4c_Qtds.Enabled    = .F.
                        .txt_4c_QtHoras.Enabled = .F.
                ENDCASE
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.HabilitarCampos")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * LimparCampos - Zera todos os campos edit?veis do painel lateral
    * Chamado em CmdInserirClick e CmdCopiarPClick (novo per?odo vazio)
    *==========================================================================
    FUNCTION LimparCampos()
        LOCAL loc_oErro
        TRY
            WITH THIS.cnt_4c_Dados
                .cmd_4c_BtnData.Caption = "00/00/0000"
                .txt_4c_Mes.Value       = ""
                .txt_4c_Ano.Value       = ""
                .txt_4c_Qtds.Value      = 0
                .txt_4c_QtHoras.Value   = 0
                .txt_4c_TotHoras.Value  = 0
                .Visible     = .T.
            ENDWITH

            THIS.this_oBusinessObject.this_cMes     = ""
            THIS.this_oBusinessObject.this_cAno     = ""
            THIS.this_oBusinessObject.this_nQtds    = 0
            THIS.this_oBusinessObject.this_nQtHoras = 0
            THIS.this_nSlotAtual = 0
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.LimparCampos")
        ENDTRY
    ENDFUNC

    *==========================================================================
    * CarregarLista - Recarrega a grade Mes/Ano e o calend?rio do m?s corrente
    * Equivalente ao CarregarLista() de forms CRUD; chamado ap?s salvar/excluir
    *==========================================================================
    FUNCTION CarregarLista()
        LOCAL loc_oErro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.MontarGradeMesAno()

            IF loc_lSucesso
                IF USED("crMesAno") AND !EOF("crMesAno")
                    THIS.MontarCalendario(crMesAno.Mes, crMesAno.Ano)
                ELSE
                    THIS.AjustarTela()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos bot?es conforme o modo atual
    * Unifica o comportamento de AjustarTela + ConfigurarPaginaLista
    * Chamado ap?s mudar this_cPcEscolha
    *==========================================================================
    FUNCTION AjustarBotoesPorModo()
        LOCAL loc_oErro, loc_cEscolha, loc_lTemRegistros
        loc_cEscolha      = THIS.this_oBusinessObject.this_cPcEscolha
        loc_lTemRegistros = USED("crMesAno") AND RECCOUNT("crMesAno") > 0

        TRY
            DO CASE
                CASE loc_cEscolha = "INSERIR" OR loc_cEscolha = "EXCLUIR" OR ;
                     loc_cEscolha = "COPIARP"
                    WITH THIS.obj_4c_CmdEscolha
                        .Buttons(1).Enabled = .F.
                        .Buttons(2).Enabled = .F.
                        .Buttons(3).Enabled = .F.
                        .Buttons(4).Enabled = .F.
                    ENDWITH
                    WITH THIS.obj_4c_CmdSalva
                        .Buttons(1).Enabled = .T.
                        .Buttons(2).Enabled = .F.
                        .Buttons(3).Enabled = .T.
                    ENDWITH

                CASE loc_cEscolha = "ALTERAR"
                    WITH THIS.obj_4c_CmdEscolha
                        .Buttons(1).Enabled = .F.
                        .Buttons(2).Enabled = .F.
                        .Buttons(3).Enabled = .F.
                        .Buttons(4).Enabled = .F.
                    ENDWITH
                    WITH THIS.obj_4c_CmdSalva
                        .Buttons(1).Enabled = .T.
                        .Buttons(2).Enabled = .F.
                        .Buttons(3).Enabled = .T.
                    ENDWITH
                    THIS.grd_4c_Dados.Enabled     = .F.
                    THIS.cnt_4c_Calendario.Enabled = .T.

                OTHERWISE  && CONSULTAR
                    WITH THIS.obj_4c_CmdEscolha
                        .Buttons(1).Enabled = .T.
                        .Buttons(2).Enabled = loc_lTemRegistros
                        .Buttons(3).Enabled = loc_lTemRegistros
                        .Buttons(4).Enabled = loc_lTemRegistros
                    ENDWITH
                    WITH THIS.obj_4c_CmdSalva
                        .Buttons(1).Enabled = .F.
                        .Buttons(2).Enabled = .T.
                        .Buttons(3).Enabled = .F.
                    ENDWITH
                    THIS.grd_4c_Dados.Enabled     = loc_lTemRegistros
                    THIS.cnt_4c_Calendario.Enabled = loc_lTemRegistros
            ENDCASE

            THIS.HabilitarCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormHOR.AjustarBotoesPorModo")
        ENDTRY
    ENDFUNC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\HORBO.prg):
*==============================================================================
* HORBO.prg - Business Object: Cadastro de Carga Hor?ria
* Tabela principal : SigCdThs
* Chave prim?ria  : cidchaves
* Form OPERACIONAL: recebe pCod (Fase/Setor) e pUni (Unidade Produtiva)
*==============================================================================
* Colunas SigCdThs : cidchaves c(20) PK, codigos n(6,0), datas datetime,
*                    qtds n(4,1), qthoras n(4,2), setors c(10), uniprdts c(10)
* Colunas SigCdUpd : cidchaves c(20) PK, codigos c(10), ddsems n(1,0),
*                    hordds n(4,2), uniprdts c(10), ordems n(2,0), qtdes n(2,0)
* Colunas SigCdGcr : codigos c(10) PK, descrs c(40)
*==============================================================================

DEFINE CLASS HORBO AS BusinessBase

    *-- Identifica??o da tabela
    this_cTabela      = "SigCdThs"
    this_cCampoChave  = "cidchaves"

    *-- Par?metros do form (recebidos do caller)
    this_cSetors      = ""      && Fase/Setor - char(10) - coluna setors
    this_cUniPrdts    = ""      && Unidade Produtiva - char(10) - coluna uniprdts
    this_cDFases      = ""      && Descri??o da Fase (SigCdGcr.descrs)

    *-- Modo de opera??o (equivalente a pcEscolha do legado)
    this_cPcEscolha   = ""      && CONSULTAR / INSERIR / ALTERAR / EXCLUIR / COPIARP

    *-- Dados do registro corrente (SigCdThs)
    this_cCidChaves   = ""      && PK - char(20) - coluna cidchaves
    this_dDatas       = {}      && Data do registro - coluna datas (datetime)
    this_nQtds        = 0       && Quantidade - numeric(4,1) - coluna qtds
    this_nQtHoras     = 0       && Horas por dia - numeric(4,2) - coluna qthoras

    *-- Sele??o de per?odo (para modos INSERIR / COPIARP)
    this_cMes         = ""      && M?s selecionado - char(2)
    this_cAno         = ""      && Ano selecionado - char(4)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    FUNCTION Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave prim?ria do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDescricaoFase - Busca descri??o da Fase/Setor em SigCdGcr
    * Retorna: .T. se encontrado, .F. se n?o encontrado
    *--------------------------------------------------------------------------
    FUNCTION CarregarDescricaoFase()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            THIS.this_cDFases = ""

            IF !EMPTY(THIS.this_cSetors)
                loc_cSQL = "SELECT descrs FROM SigCdGcr " + ;
                           "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10))

                IF USED("cursor_4c_DescFase")
                    USE IN cursor_4c_DescFase
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFase")
                IF loc_nRet > 0 AND USED("cursor_4c_DescFase") AND !EOF("cursor_4c_DescFase")
                    THIS.this_cDFases = ALLTRIM(cursor_4c_DescFase.descrs)
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_DescFase")
                    USE IN cursor_4c_DescFase
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CarregarDescricaoFase")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarGradeMesAno - Carrega cursor crMesAno com meses/anos existentes
    * em SigCdThs para o Setor e Unidade Produtiva atuais
    * Retorna: .T. se executado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION MontarGradeMesAno()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF USED("crMesAno")
                ZAP IN crMesAno

                loc_cSQL = "SELECT DISTINCT datas " + ;
                           "FROM SigCdThs " + ;
                           "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                           " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                           " ORDER BY datas"

                IF USED("cursor_4c_DatasTemp")
                    USE IN cursor_4c_DatasTemp
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DatasTemp")
                IF loc_nRet < 1
                    MsgErro("Falha ao consultar SigCdThs (MontarGradeMesAno).", "Erro de Conex" + CHR(227) + "o")
                ELSE
                    *-- Extrai mes/ano distintos do cursor de datas
                    SELECT DISTINCT ;
                        SUBSTR(DTOS(TTOD(datas)), 5, 2) AS Mes, ;
                        SUBSTR(DTOS(TTOD(datas)), 1, 4) AS Ano ;
                    FROM cursor_4c_DatasTemp ;
                    INTO CURSOR cursor_4c_MesAnoTemp READWRITE

                    SELECT cursor_4c_MesAnoTemp
                    SCAN
                        INSERT INTO crMesAno (Mes, Ano) ;
                            VALUES (cursor_4c_MesAnoTemp.Mes, cursor_4c_MesAnoTemp.Ano)
                    ENDSCAN

                    IF USED("cursor_4c_DatasTemp")
                        USE IN cursor_4c_DatasTemp
                    ENDIF
                    IF USED("cursor_4c_MesAnoTemp")
                        USE IN cursor_4c_MesAnoTemp
                    ENDIF

                    *-- Posiciona no m?s corrente se existir
                    SET NEAR ON
                    =SEEK(SUBSTR(DTOS(DATE()), 1, 6), "crMesAno", "Ordem")
                    SET NEAR OFF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.MontarGradeMesAno")

            IF USED("cursor_4c_DatasTemp")
                USE IN cursor_4c_DatasTemp
            ENDIF
            IF USED("cursor_4c_MesAnoTemp")
                USE IN cursor_4c_MesAnoTemp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarCalendario - Carrega crCalendario para o mes/ano informado
    * par_cMes   : Mes desejado (char 2, ex: "08")
    * par_cAno   : Ano desejado (char 4, ex: "2026")
    * par_lTrunc  : .T. = truncar e recalcular dias; .F. = apenas carregar
    * Retorna: .T. se executado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION MontarCalendario(par_cMes, par_cAno, par_lTrunc)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDia, loc_ldDtF, loc_ldDtI
        LOCAL loc_nDow, loc_ldDay
        LOCAL loc_nHds, loc_nDds, loc_nQds
        LOCAL loc_nHor, loc_nQts
        LOCAL loc_llZer
        LOCAL loc_nDia, loc_nObj, loc_cObj
        LOCAL loc_nHorTotal, loc_nQth, loc_nQtd
        LOCAL loc_cHrr
        loc_lSucesso = .F.

        TRY
            IF USED("crCalendario")
                loc_ldDia = CTOD("01/" + par_cMes + "/" + par_cAno)

                *-- Busca dados de SigCdThs para o per?odo
                loc_ldDtI = THIS.FormatarDataSQL(loc_ldDia)
                loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDia, 1) - 1, .T.)

                loc_cSQL = "SELECT * " + ;
                           "FROM SigCdThs " + ;
                           "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                           " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                           " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

                IF USED("cursor_4c_TmpCtHr")
                    USE IN cursor_4c_TmpCtHr
                ENDIF

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCtHr")
                IF loc_nRet < 1
                    MsgErro("Falha ao consultar SigCdThs (MontarCalendario).", "Erro de Conex" + CHR(227) + "o")
                ELSE
                    SELECT cursor_4c_TmpCtHr
                    INDEX ON DTOS(TTOD(datas)) TAG Datas

                    *-- Modo truncar: recalcula horas conforme SigCdUpd
                    LOCAL loc_lTruncOk
                    loc_lTruncOk = .T.
                    IF par_lTrunc
                        loc_cSQL = "SELECT * FROM SigCdUpd " + ;
                                   "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                                   " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10))

                        IF USED("cursor_4c_LocalUPrdt")
                            USE IN cursor_4c_LocalUPrdt
                        ENDIF

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalUPrdt")
                        IF loc_nRet < 1
                            MsgErro("Falha ao consultar SigCdUpd (MontarCalendario).", "Erro de Conex" + CHR(227) + "o")
                            IF USED("cursor_4c_TmpCtHr")
                                USE IN cursor_4c_TmpCtHr
                            ENDIF
                            loc_lTruncOk = .F.
                        ELSE
                            GO TOP IN cursor_4c_LocalUPrdt

                            loc_nHds = cursor_4c_LocalUPrdt.hordds
                            loc_nDds = IIF(cursor_4c_LocalUPrdt.ddsems < 1, 7, cursor_4c_LocalUPrdt.ddsems)
                            loc_nQds = IIF(cursor_4c_LocalUPrdt.qtdes < 1, 1, cursor_4c_LocalUPrdt.qtdes)

                            FOR loc_nDia = 1 TO DAY(GOMONTH(loc_ldDia, 1) - 1)
                                loc_ldDay = CTOD(PADL(loc_nDia, 2, "0") + "/" + par_cMes + "/" + par_cAno)

                                loc_llZer = THIS.VerificarFeriado(loc_ldDay)

                                loc_nHor = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nHds)
                                loc_nQts = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nQds)

                                IF SEEK(DTOS(loc_ldDay), "cursor_4c_TmpCtHr", "Datas")
                                    SELECT cursor_4c_TmpCtHr
                                    REPLACE qtds    WITH loc_nQts, ;
                                            qthoras WITH loc_nHor
                                ELSE
                                    INSERT INTO cursor_4c_TmpCtHr ;
                                        (setors, uniprdts, datas, qtds, qthoras) ;
                                    VALUES ;
                                        (THIS.this_cSetors, THIS.this_cUniPrdts, ;
                                         loc_ldDay, loc_nQts, loc_nHor)
                                ENDIF
                            NEXT

                            IF USED("cursor_4c_LocalUPrdt")
                                USE IN cursor_4c_LocalUPrdt
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lTruncOk
                        *-- Alimenta crCalendario com dados do m?s
                        ZAP IN crCalendario

                        IF RECCOUNT("cursor_4c_TmpCtHr") > 0
                            APPEND BLANK IN crCalendario
                            GO TOP IN crCalendario

                            loc_nDow = 1
                            loc_ldDia = CTOD("01/" + par_cMes + "/" + par_cAno)

                            FOR loc_nObj = 1 TO 42
                                loc_cObj = PADL(loc_nObj, 2, "0")

                                *-- Limpa slot do calend?rio
                                SELECT crCalendario
                                REPLACE ("Data"    + loc_cObj) WITH CTOD(""), ;
                                        ("QtHoras" + loc_cObj) WITH 0, ;
                                        ("Qtds"    + loc_cObj) WITH 0

                                IF loc_nDow = DOW(loc_ldDia) AND MONTH(loc_ldDia) = INT(VAL(par_cMes))
                                    loc_nHorTotal = 0
                                    loc_nQth = 0
                                    loc_nQtd = 0

                                    IF SEEK(DTOS(loc_ldDia), "cursor_4c_TmpCtHr", "Datas")
                                        loc_nQth      = cursor_4c_TmpCtHr.qthoras
                                        loc_nQtd      = cursor_4c_TmpCtHr.qtds
                                        loc_nHorTotal = THIS.ConverterHorasParaDecimal(loc_nQth, loc_nQtd)
                                    ENDIF

                                    SELECT crCalendario
                                    REPLACE ("Data"    + loc_cObj) WITH loc_ldDia, ;
                                            ("QtHoras" + loc_cObj) WITH loc_nQth, ;
                                            ("Qtds"    + loc_cObj) WITH loc_nQtd

                                    loc_ldDia = loc_ldDia + 1
                                ENDIF

                                loc_nDow = loc_nDow + 1
                                IF loc_nDow > 7
                                    loc_nDow = 1
                                ENDIF
                            NEXT
                        ENDIF

                        IF USED("cursor_4c_TmpCtHr")
                            USE IN cursor_4c_TmpCtHr
                        ENDIF

                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.MontarCalendario")

            IF USED("cursor_4c_TmpCtHr")
                USE IN cursor_4c_TmpCtHr
            ENDIF
            IF USED("cursor_4c_LocalUPrdt")
                USE IN cursor_4c_LocalUPrdt
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirPeriodo - Insere novo per?odo de carga hor?ria
    * par_cMes : M?s do per?odo (char 2)
    * par_cAno : Ano do per?odo (char 4)
    * Retorna: .T. se inserido com sucesso, .F. em caso de erro/exist?ncia
    *--------------------------------------------------------------------------
    FUNCTION InserirPeriodo(par_cMes, par_cAno)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDat, loc_ldDtI, loc_ldDtF
        LOCAL loc_nHds, loc_nDds, loc_nQds
        LOCAL loc_ldDay, loc_llZer, loc_nHor, loc_nQts
        LOCAL loc_nDia
        loc_lSucesso = .F.

        TRY
            loc_ldDat = CTOD("01/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDat)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDat, 1) - 1, .T.)

            *-- Verifica se j? existem lan?amentos no per?odo
            loc_cSQL = "SELECT cidchaves FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_ChkCtHr")
                USE IN cursor_4c_ChkCtHr
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCtHr")
            IF loc_nRet < 1
                MsgErro("Falha ao verificar per" + CHR(237) + "odo em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF RECCOUNT("cursor_4c_ChkCtHr") > 0
                    MsgAviso("Existem lan" + CHR(231) + "amentos nesse per" + CHR(237) + "odo! Verifique!")
                    IF USED("cursor_4c_ChkCtHr")
                        USE IN cursor_4c_ChkCtHr
                    ENDIF
                ELSE
                    IF USED("cursor_4c_ChkCtHr")
                        USE IN cursor_4c_ChkCtHr
                    ENDIF

                    *-- Busca configura??o da unidade produtiva em SigCdUpd
                    loc_cSQL = "SELECT * FROM SigCdUpd " + ;
                               "WHERE codigos = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10))

                    IF USED("cursor_4c_LocalUPrdt")
                        USE IN cursor_4c_LocalUPrdt
                    ENDIF

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalUPrdt")
                    IF loc_nRet < 1
                        MsgErro("Falha ao consultar SigCdUpd (InserirPeriodo).", "Erro de Conex" + CHR(227) + "o")
                    ELSE
                        GO TOP IN cursor_4c_LocalUPrdt

                        loc_nHds = cursor_4c_LocalUPrdt.hordds
                        loc_nDds = IIF(cursor_4c_LocalUPrdt.ddsems < 1, 7, cursor_4c_LocalUPrdt.ddsems)
                        loc_nQds = IIF(cursor_4c_LocalUPrdt.qtdes < 1, 1, cursor_4c_LocalUPrdt.qtdes)

                        IF USED("cursor_4c_LocalUPrdt")
                            USE IN cursor_4c_LocalUPrdt
                        ENDIF

                        *-- Cria cursor de work para inser??o em lote
                        IF USED("crSigCdThs")
                            TABLEREVERT(.T., "crSigCdThs")
                            USE IN crSigCdThs
                        ENDIF

                        SET NULL ON
                        CREATE CURSOR crSigCdThs ;
                            (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                             qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                             setors C(10) NULL, uniprdts C(10) NULL)
                        SET NULL OFF

                        *-- Insere um registro por dia do m?s
                        FOR loc_nDia = 1 TO DAY(GOMONTH(loc_ldDat, 1) - 1)
                            loc_ldDay = CTOD(PADL(loc_nDia, 2, "0") + "/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))

                            loc_llZer = THIS.VerificarFeriado(loc_ldDay)

                            loc_nHor = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nHds)
                            loc_nQts = IIF(loc_llZer OR DOW(loc_ldDay, 2) > loc_nDds, 0, loc_nQds)

                            SELECT crSigCdThs
                            APPEND BLANK
                            REPLACE setors    WITH THIS.this_cSetors, ;
                                    uniprdts  WITH THIS.this_cUniPrdts, ;
                                    qtds      WITH loc_nQts, ;
                                    qthoras   WITH loc_nHor, ;
                                    datas     WITH loc_ldDay, ;
                                    cidchaves WITH THIS.GerarChaveUnica()
                        NEXT

                        *-- Envia para SQL Server via SQLEXEC INSERT em lote
                        loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")

                        IF USED("crSigCdThs")
                            USE IN crSigCdThs
                        ENDIF

                        *-- Atualiza crMesAno se o m?s n?o existia
                        IF loc_lSucesso AND USED("crMesAno")
                            IF !SEEK(SUBSTR(DTOS(loc_ldDat), 1, 6), "crMesAno", "Ordem")
                                INSERT INTO crMesAno (Mes, Ano) ;
                                    VALUES (SUBSTR(DTOS(loc_ldDat), 5, 2), SUBSTR(DTOS(loc_ldDat), 1, 4))
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.InserirPeriodo")

            IF USED("cursor_4c_ChkCtHr")
                USE IN cursor_4c_ChkCtHr
            ENDIF
            IF USED("cursor_4c_LocalUPrdt")
                USE IN cursor_4c_LocalUPrdt
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AlterarPeriodo - Altera dados do per?odo atual a partir de crCalendario
    * Retorna: .T. se alterado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION AlterarPeriodo()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_lUpd
        LOCAL loc_nObj, loc_cObj, loc_ldDia
        LOCAL loc_ldDtI, loc_ldDtF
        LOCAL loc_nQth, loc_nQtd
        loc_lSucesso = .F.
        loc_lUpd = .F.

        TRY
            IF USED("crCalendario")
                IF USED("crSigCdThs")
                    TABLEREVERT(.T., "crSigCdThs")
                    USE IN crSigCdThs
                ENDIF

                SET NULL ON
                CREATE CURSOR crSigCdThs ;
                    (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                     qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                     setors C(10) NULL, uniprdts C(10) NULL)
                SET NULL OFF

                LOCAL loc_lLoopOk
                loc_lLoopOk = .T.

                FOR loc_nObj = 1 TO 42
                    IF loc_lLoopOk
                        loc_cObj = PADL(loc_nObj, 2, "0")
                        SELECT crCalendario
                        loc_ldDia = EVALUATE("Data" + loc_cObj)

                        IF !EMPTY(loc_ldDia)
                            loc_nQth = EVALUATE("QtHoras" + loc_cObj)
                            loc_nQtd = EVALUATE("Qtds"    + loc_cObj)

                            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDia)
                            loc_ldDtF = THIS.FormatarDataSQL(loc_ldDia, .T.)

                            *-- Busca registro existente para o dia
                            loc_cSQL = "SELECT * FROM SigCdThs " + ;
                                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCtHr")
                            IF loc_nRet < 1
                                MsgErro("Falha ao consultar SigCdThs (AlterarPeriodo).", "Erro de Conex" + CHR(227) + "o")
                                IF USED("cursor_4c_LocalCtHr")
                                    USE IN cursor_4c_LocalCtHr
                                ENDIF
                                loc_lLoopOk = .F.
                            ELSE
                                SELECT crSigCdThs
                                IF RECCOUNT("cursor_4c_LocalCtHr") > 0
                                    *-- Existe: copia e atualiza horas/qtd
                                    GO TOP IN cursor_4c_LocalCtHr
                                    APPEND BLANK IN crSigCdThs
                                    SELECT crSigCdThs
                                    REPLACE cidchaves WITH cursor_4c_LocalCtHr.cidchaves, ;
                                            codigos   WITH cursor_4c_LocalCtHr.codigos, ;
                                            datas     WITH cursor_4c_LocalCtHr.datas, ;
                                            setors    WITH cursor_4c_LocalCtHr.setors, ;
                                            uniprdts  WITH cursor_4c_LocalCtHr.uniprdts, ;
                                            qtds      WITH loc_nQtd, ;
                                            qthoras   WITH loc_nQth
                                ELSE
                                    *-- N?o existe: insere novo registro
                                    APPEND BLANK IN crSigCdThs
                                    SELECT crSigCdThs
                                    REPLACE setors    WITH THIS.this_cSetors, ;
                                            uniprdts  WITH THIS.this_cUniPrdts, ;
                                            qtds      WITH loc_nQtd, ;
                                            qthoras   WITH loc_nQth, ;
                                            datas     WITH loc_ldDia, ;
                                            cidchaves WITH THIS.GerarChaveUnica()
                                ENDIF

                                IF USED("cursor_4c_LocalCtHr")
                                    USE IN cursor_4c_LocalCtHr
                                ENDIF

                                loc_lUpd = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                NEXT

                IF loc_lLoopOk
                    IF loc_lUpd
                        loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF

                IF USED("crSigCdThs")
                    USE IN crSigCdThs
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.AlterarPeriodo")

            IF USED("cursor_4c_LocalCtHr")
                USE IN cursor_4c_LocalCtHr
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirPeriodo - Exclui todos os registros do per?odo (mes/ano)
    * par_cMes : M?s a excluir (char 2)
    * par_cAno : Ano a excluir (char 4)
    * Retorna: .T. se exclu?do com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION ExcluirPeriodo(par_cMes, par_cAno)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_ldDat, loc_ldDtI, loc_ldDtF
        loc_lSucesso = .F.

        TRY
            loc_ldDat = CTOD("01/" + PADL(par_cMes, 2, "0") + "/" + PADL(par_cAno, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDat)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDat, 1) - 1, .T.)

            loc_cSQL = "DELETE FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_DelResult")
                USE IN cursor_4c_DelResult
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelResult")
            IF loc_nRet < 1
                MsgErro("Falha ao excluir per" + CHR(237) + "odo em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF USED("cursor_4c_DelResult")
                    USE IN cursor_4c_DelResult
                ENDIF

                *-- Remove da crMesAno
                IF USED("crMesAno")
                    DELETE FROM crMesAno ;
                    WHERE Mes = SUBSTR(DTOS(loc_ldDat), 5, 2) AND ;
                          Ano = SUBSTR(DTOS(loc_ldDat), 1, 4)
                    PACK IN crMesAno
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.ExcluirPeriodo")

            IF USED("cursor_4c_DelResult")
                USE IN cursor_4c_DelResult
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CopiarPeriodo - Copia per?odo do mes/ano selecionado para outro mes/ano
    * par_cMesOrig : M?s de origem (mes do crMesAno selecionado no grid)
    * par_cAnoOrig : Ano de origem
    * par_cMesDest : M?s de destino (digitado pelo usu?rio)
    * par_cAnoDest : Ano de destino (digitado pelo usu?rio)
    * Retorna: .T. se copiado com sucesso, .F. em caso de erro/exist?ncia
    *--------------------------------------------------------------------------
    FUNCTION CopiarPeriodo(par_cMesOrig, par_cAnoOrig, par_cMesDest, par_cAnoDest)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_lUpd
        LOCAL loc_ldDatDest, loc_ldDtI, loc_ldDtF
        LOCAL loc_ldDatOrig, loc_ldDtIOrig, loc_ldDtFOrig
        LOCAL loc_ldDtn
        loc_lSucesso = .F.
        loc_lUpd = .F.

        TRY
            *-- Verifica se destino j? tem lan?amentos
            loc_ldDatDest = CTOD("01/" + PADL(par_cMesDest, 2, "0") + "/" + PADL(par_cAnoDest, 4, "0"))
            loc_ldDtI = THIS.FormatarDataSQL(loc_ldDatDest)
            loc_ldDtF = THIS.FormatarDataSQL(GOMONTH(loc_ldDatDest, 1) - 1, .T.)

            loc_cSQL = "SELECT cidchaves FROM SigCdThs " + ;
                       "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                       " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                       " AND datas BETWEEN " + loc_ldDtI + " AND " + loc_ldDtF

            IF USED("cursor_4c_ChkDest")
                USE IN cursor_4c_ChkDest
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDest")
            IF loc_nRet < 1
                MsgErro("Falha ao verificar destino em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
            ELSE
                IF RECCOUNT("cursor_4c_ChkDest") > 0
                    MsgAviso("Existem lan" + CHR(231) + "amentos nesse per" + CHR(237) + "odo! Verifique!")
                    IF USED("cursor_4c_ChkDest")
                        USE IN cursor_4c_ChkDest
                    ENDIF
                ELSE
                    IF USED("cursor_4c_ChkDest")
                        USE IN cursor_4c_ChkDest
                    ENDIF

                    *-- Busca registros de origem
                    loc_ldDatOrig = CTOD("01/" + PADL(par_cMesOrig, 2, "0") + "/" + PADL(par_cAnoOrig, 4, "0"))
                    loc_ldDtIOrig = THIS.FormatarDataSQL(loc_ldDatOrig)
                    loc_ldDtFOrig = THIS.FormatarDataSQL(GOMONTH(loc_ldDatOrig, 1) - 1, .T.)

                    loc_cSQL = "SELECT * FROM SigCdThs " + ;
                               "WHERE setors = " + EscaparSQL(PADR(THIS.this_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(THIS.this_cUniPrdts, 10)) + ;
                               " AND datas BETWEEN " + loc_ldDtIOrig + " AND " + loc_ldDtFOrig

                    IF USED("cursor_4c_LocalCtHr")
                        USE IN cursor_4c_LocalCtHr
                    ENDIF

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCtHr")
                    IF loc_nRet < 1
                        MsgErro("Falha ao consultar origem em SigCdThs.", "Erro de Conex" + CHR(227) + "o")
                    ELSE
                        IF RECCOUNT("cursor_4c_LocalCtHr") > 0
                            IF USED("crSigCdThs")
                                TABLEREVERT(.T., "crSigCdThs")
                                USE IN crSigCdThs
                            ENDIF

                            SET NULL ON
                            CREATE CURSOR crSigCdThs ;
                                (cidchaves C(20) NULL, codigos N(6,0) NULL, datas D NULL, ;
                                 qtds N(4,1) NULL, qthoras N(4,2) NULL, ;
                                 setors C(10) NULL, uniprdts C(10) NULL)
                            SET NULL OFF

                            SELECT cursor_4c_LocalCtHr
                            SCAN
                                *-- Ajusta dia para o m?s destino
                                loc_ldDtn = CTOD(SUBSTR(DTOC(cursor_4c_LocalCtHr.datas), 1, 3) + ;
                                                 PADL(par_cMesDest, 2, "0") + "/" + PADL(par_cAnoDest, 4, "0"))

                                IF !EMPTY(loc_ldDtn)
                                    SELECT crSigCdThs
                                    APPEND BLANK
                                    REPLACE setors    WITH cursor_4c_LocalCtHr.setors, ;
                                            uniprdts  WITH cursor_4c_LocalCtHr.uniprdts, ;
                                            qtds      WITH cursor_4c_LocalCtHr.qtds, ;
                                            qthoras   WITH cursor_4c_LocalCtHr.qthoras, ;
                                            datas     WITH loc_ldDtn, ;
                                            cidchaves WITH THIS.GerarChaveUnica()
                                    loc_lUpd = .T.
                                ENDIF
                            ENDSCAN

                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF

                            IF loc_lUpd
                                loc_lSucesso = THIS.EnviarCursorParaServidor("crSigCdThs")

                                *-- Atualiza crMesAno com o novo per?odo
                                IF loc_lSucesso AND USED("crMesAno") AND !EMPTY(loc_ldDtn)
                                    INSERT INTO crMesAno (Mes, Ano) ;
                                        VALUES (SUBSTR(DTOS(loc_ldDtn), 5, 2), SUBSTR(DTOS(loc_ldDtn), 1, 4))
                                ENDIF
                            ELSE
                                loc_lSucesso = .T.
                            ENDIF

                            IF USED("crSigCdThs")
                                USE IN crSigCdThs
                            ENDIF
                        ELSE
                            IF USED("cursor_4c_LocalCtHr")
                                USE IN cursor_4c_LocalCtHr
                            ENDIF
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CopiarPeriodo")

            IF USED("cursor_4c_ChkDest")
                USE IN cursor_4c_ChkDest
            ENDIF
            IF USED("cursor_4c_LocalCtHr")
                USE IN cursor_4c_LocalCtHr
            ENDIF
            IF USED("crSigCdThs")
                USE IN crSigCdThs
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * EnviarCursorParaServidor - Insere/atualiza registros de crSigCdThs
    * no SQL Server usando SQLEXEC por registro
    * Retorna: .T. se todos enviados com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION EnviarCursorParaServidor(par_cCursor)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_nCodigos, loc_ldDatas
        LOCAL loc_nQtds, loc_nQtHoras, loc_cSetors, loc_cUniPrdts
        loc_lSucesso = .T.

        TRY
            IF USED(par_cCursor) AND RECCOUNT(par_cCursor) > 0
                SELECT (par_cCursor)
                GO TOP

                SCAN
                    loc_cCidChaves = ALLTRIM(EVALUATE(par_cCursor + ".cidchaves"))
                    loc_nCodigos   = EVALUATE(par_cCursor + ".codigos")
                    loc_ldDatas    = EVALUATE(par_cCursor + ".datas")
                    loc_nQtds      = EVALUATE(par_cCursor + ".qtds")
                    loc_nQtHoras   = EVALUATE(par_cCursor + ".qthoras")
                    loc_cSetors    = ALLTRIM(EVALUATE(par_cCursor + ".setors"))
                    loc_cUniPrdts  = ALLTRIM(EVALUATE(par_cCursor + ".uniprdts"))

                    *-- Tenta UPDATE primeiro
                    loc_cSQL = "UPDATE SigCdThs " + ;
                               "SET qtds = " + FormatarNumeroSQL(loc_nQtds, 1) + ;
                               ", qthoras = " + FormatarNumeroSQL(loc_nQtHoras, 2) + ;
                               " WHERE setors = " + EscaparSQL(PADR(loc_cSetors, 10)) + ;
                               " AND uniprdts = " + EscaparSQL(PADR(loc_cUniPrdts, 10)) + ;
                               " AND datas BETWEEN " + THIS.FormatarDataSQL(loc_ldDatas) + ;
                               " AND " + THIS.FormatarDataSQL(loc_ldDatas, .T.)

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdResult")

                    IF USED("cursor_4c_UpdResult")
                        USE IN cursor_4c_UpdResult
                    ENDIF

                    *-- Verifica linhas afetadas: 0 = novo registro, faz INSERT
                    LOCAL loc_nAffected
                    loc_nAffected = 0
                    IF loc_nRet >= 1
                        IF SQLEXEC(gnConnHandle, "SELECT @@ROWCOUNT AS rn", "cursor_4c_RowCnt") >= 1
                            loc_nAffected = cursor_4c_RowCnt.rn
                        ENDIF
                        IF USED("cursor_4c_RowCnt")
                            USE IN cursor_4c_RowCnt
                        ENDIF
                    ENDIF

                    *-- Se UPDATE nao afetou nenhuma linha, faz INSERT
                    IF loc_nRet < 1 OR loc_nAffected = 0
                        IF EMPTY(loc_cCidChaves)
                            loc_cCidChaves = THIS.GerarChaveUnica()
                        ENDIF
                        loc_cSQL = "INSERT INTO SigCdThs " + ;
                                   "(cidchaves, codigos, setors, uniprdts, datas, qtds, qthoras) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", 0, " + ;
                                   EscaparSQL(PADR(loc_cSetors, 10)) + ", " + ;
                                   EscaparSQL(PADR(loc_cUniPrdts, 10)) + ", " + ;
                                   THIS.FormatarDataSQL(loc_ldDatas) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtds, 1) + ", " + ;
                                   FormatarNumeroSQL(loc_nQtHoras, 2) + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsResult")
                        IF USED("cursor_4c_InsResult")
                            USE IN cursor_4c_InsResult
                        ENDIF

                        IF loc_nRet < 1
                            MsgErro("Falha ao inserir registro em SigCdThs.", "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.EnviarCursorParaServidor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave prim?ria ?nica (char 20)
    * Usa NEWID() do SQL Server para gerar GUID truncado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nRet
        loc_cChave = ""

        TRY
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, "SELECT LEFT(REPLACE(NEWID(),'-',''),20) AS nova_chave", "cursor_4c_NewId")
            IF loc_nRet > 0 AND USED("cursor_4c_NewId") AND !EOF("cursor_4c_NewId")
                loc_cChave = ALLTRIM(cursor_4c_NewId.nova_chave)
            ENDIF

            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loc_oErro
            *-- Fallback com SYS(2015) se SQL falhar
            loc_cChave = LEFT(SYS(2015) + SYS(2015), 20)
        ENDTRY

        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarFeriado - Verifica se uma data ? feriado em SigCdThs (stub)
    * Substitui fChkFeriado() do legado
    * par_ldData : Data a verificar
    * Retorna: .T. se for feriado, .F. caso contr?rio
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarFeriado(par_ldData)
        LOCAL loc_lFeriado, loc_cSQL, loc_nRet
        loc_lFeriado = .F.

        TRY
            *-- Verifica em SigCdThs se o dia tem qthoras=0 explicitamente (feriado configurado)
            *-- Na aus?ncia de tabela de feriados dedicada no sistema, retorna .F. por padr?o
            *-- O legado usava fChkFeriado() do framework que consultava tabela de feriados
            loc_lFeriado = .F.
        CATCH TO loc_oErro
            loc_lFeriado = .F.
        ENDTRY

        RETURN loc_lFeriado
    ENDFUNC

    *--------------------------------------------------------------------------
    * FormatarDataSQL - Formata data para SQL Server incluindo hora opcional
    * par_ldData   : Data a formatar
    * par_lComHora : .T. = adiciona "23:59:59" (fim do dia)
    * Retorna: string no formato 'YYYY-MM-DD HH:MM:SS' entre aspas simples
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormatarDataSQL(par_ldData, par_lComHora)
        LOCAL loc_cData
        loc_cData = "NULL"

        TRY
            IF !EMPTY(par_ldData) AND par_ldData <> {}
                IF VARTYPE(par_lComHora) = "L" AND par_lComHora
                    loc_cData = "'" + SUBSTR(DTOS(par_ldData), 1, 4) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 5, 2) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 7, 2) + " 23:59:59'"
                ELSE
                    loc_cData = "'" + SUBSTR(DTOS(par_ldData), 1, 4) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 5, 2) + "-" + ;
                                SUBSTR(DTOS(par_ldData), 7, 2) + " 00:00:00'"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_cData = "NULL"
        ENDTRY

        RETURN loc_cData
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConverterHorasParaDecimal - Converte horas*qtd para valor decimal total
    * Substitui: Val(Strtran(fMtoH(fHtoM(Str(qtHoras,5,2)) * qtds), ':', '.'))
    * par_nQtHoras : Horas por dia (numeric)
    * par_nQtds    : Quantidade (numeric)
    * Retorna: valor decimal total de horas
    *--------------------------------------------------------------------------
    FUNCTION ConverterHorasParaDecimal(par_nQtHoras, par_nQtds)
        LOCAL loc_nTotalMinutos, loc_nHoras, loc_nMinutos, loc_nDecimal
        loc_nDecimal = 0

        TRY
            *-- fHtoM: horas decimais -> minutos (ex: 8.30 -> 510 min)
            *-- QtHoras est? no formato decimal (8.5 = 8h30)
            loc_nTotalMinutos = INT(par_nQtHoras) * 60 + ;
                                (par_nQtHoras - INT(par_nQtHoras)) * 100
            loc_nTotalMinutos = loc_nTotalMinutos * par_nQtds

            *-- fMtoH: minutos -> horas decimal
            loc_nHoras   = INT(loc_nTotalMinutos / 60)
            loc_nMinutos = MOD(loc_nTotalMinutos, 60)
            loc_nDecimal = VAL(TRANSFORM(loc_nHoras, "@L 9999") + "." + PADL(TRANSFORM(loc_nMinutos, "@L 99"), 2, "0"))
        CATCH TO loc_oErro
            loc_nDecimal = 0
        ENDTRY

        RETURN loc_nDecimal
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * par_cAliasCursor : Alias do cursor (ex: crMesAno)
    * Retorna: .T. se carregado com sucesso, .F. se cursor n?o aberto
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cMes = TratarNulo(Mes, "C")
                THIS.this_cAno = TratarNulo(Ano, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados obrigat?rios antes de Inserir/Atualizar
    * Retorna: .T. se v?lido, .F. se inv?lido (exibe mensagem ao usu?rio)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cMes)
            MsgAviso("M" + CHR(234) + "s obrigat" + CHR(243) + "rio.")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cAno) OR LEN(ALLTRIM(THIS.this_cAno)) < 4
            MsgAviso("Ano obrigat" + CHR(243) + "rio (4 d" + CHR(237) + "gitos).")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cSetors)
            MsgAviso("Fase/Setor obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cUniPrdts)
            MsgAviso("Unidade Produtiva obrigat" + CHR(243) + "ria.")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Cria novo per?odo de carga hor?ria no SQL Server
    * Delega para InserirPeriodo usando this_cMes e this_cAno
    * Retorna: .T. se inserido com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_lSucesso = THIS.InserirPeriodo(THIS.this_cMes, THIS.this_cAno)
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("I")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Grava altera??es do calend?rio atual para o SQL Server
    * Delega para AlterarPeriodo que usa crCalendario como fonte
    * Retorna: .T. se atualizado com sucesso, .F. em caso de erro
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_lSucesso = THIS.AlterarPeriodo()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("U")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em HORBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

