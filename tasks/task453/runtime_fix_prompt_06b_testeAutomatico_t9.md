# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 9/10
- Mensagem: TIMEOUT: VFP9 travou durante teste automatico (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-10 14:15:23] [INFO] Config FPW: (nao fornecido)
[2026-08-10 14:15:23] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 14:15:23] [INFO] Timeout: 300 segundos
[2026-08-10 14:15:23] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k3oc3uw1.prg
[2026-08-10 14:15:23] [INFO] Conteudo do wrapper:
[2026-08-10 14:15:23] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formint', 'C:\4c\tasks\task453', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formint', 'C:\4c\tasks\task453', 'CRUD'
QUIT

[2026-08-10 14:15:23] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k3oc3uw1.prg
[2026-08-10 14:15:23] [INFO] VFP output esperado em: C:\4c\tasks\task453\vfp_output.txt
[2026-08-10 14:15:23] [INFO] Executando Visual FoxPro 9...
[2026-08-10 14:15:23] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k3oc3uw1.prg
[2026-08-10 14:15:23] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k3oc3uw1.prg
[2026-08-10 14:15:23] [INFO] Timeout configurado: 300 segundos
[2026-08-10 14:20:23] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 12988)...
[2026-08-10 14:20:25] [INFO] VFP9 finalizado em 302.0741927 segundos
[2026-08-10 14:20:25] [INFO] Exit Code: 4
[2026-08-10 14:20:25] [INFO] 
[2026-08-10 14:20:25] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-10 14:20:25] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_k3oc3uw1.prg
[2026-08-10 14:20:25] [INFO] 
[2026-08-10 14:20:25] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-10 14:20:25] [INFO] * Auto-generated wrapper for parameters
[2026-08-10 14:20:25] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 14:20:25] [INFO] * Parameters: 'Formint', 'C:\4c\tasks\task453', 'CRUD'
[2026-08-10 14:20:25] [INFO] 
[2026-08-10 14:20:25] [INFO] * Anti-dialog protections for unattended execution
[2026-08-10 14:20:25] [INFO] SET SAFETY OFF
[2026-08-10 14:20:25] [INFO] SET RESOURCE OFF
[2026-08-10 14:20:25] [INFO] SET TALK OFF
[2026-08-10 14:20:25] [INFO] SET NOTIFY OFF
[2026-08-10 14:20:25] [INFO] SYS(2335, 0)
[2026-08-10 14:20:25] [INFO] 
[2026-08-10 14:20:25] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formint', 'C:\4c\tasks\task453', 'CRUD'
[2026-08-10 14:20:25] [INFO] QUIT
[2026-08-10 14:20:25] [INFO] 
[2026-08-10 14:20:25] [INFO] === Fim do Wrapper.prg ===
[2026-08-10 14:20:25] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-10 14:25:56] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-10 14:25:56] [INFO] Config FPW: (nao fornecido)
[2026-08-10 14:25:56] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 14:25:56] [INFO] Timeout: 300 segundos
[2026-08-10 14:25:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0uj5nnmw.prg
[2026-08-10 14:25:56] [INFO] Conteudo do wrapper:
[2026-08-10 14:25:56] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formint', 'C:\4c\tasks\task453', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formint', 'C:\4c\tasks\task453', 'CRUD'
QUIT

[2026-08-10 14:25:56] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0uj5nnmw.prg
[2026-08-10 14:25:56] [INFO] VFP output esperado em: C:\4c\tasks\task453\vfp_output.txt
[2026-08-10 14:25:56] [INFO] Executando Visual FoxPro 9...
[2026-08-10 14:25:56] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0uj5nnmw.prg
[2026-08-10 14:25:56] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0uj5nnmw.prg
[2026-08-10 14:25:56] [INFO] Timeout configurado: 300 segundos
[2026-08-10 14:30:56] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 18856)...
[2026-08-10 14:30:58] [INFO] VFP9 finalizado em 302.0266316 segundos
[2026-08-10 14:30:58] [INFO] Exit Code: 4
[2026-08-10 14:30:58] [INFO] 
[2026-08-10 14:30:58] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-10 14:30:58] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0uj5nnmw.prg
[2026-08-10 14:30:58] [INFO] 
[2026-08-10 14:30:58] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-10 14:30:58] [INFO] * Auto-generated wrapper for parameters
[2026-08-10 14:30:58] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 14:30:58] [INFO] * Parameters: 'Formint', 'C:\4c\tasks\task453', 'CRUD'
[2026-08-10 14:30:58] [INFO] 
[2026-08-10 14:30:58] [INFO] * Anti-dialog protections for unattended execution
[2026-08-10 14:30:58] [INFO] SET SAFETY OFF
[2026-08-10 14:30:58] [INFO] SET RESOURCE OFF
[2026-08-10 14:30:58] [INFO] SET TALK OFF
[2026-08-10 14:30:58] [INFO] SET NOTIFY OFF
[2026-08-10 14:30:58] [INFO] SYS(2335, 0)
[2026-08-10 14:30:58] [INFO] 
[2026-08-10 14:30:58] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formint', 'C:\4c\tasks\task453', 'CRUD'
[2026-08-10 14:30:58] [INFO] QUIT
[2026-08-10 14:30:58] [INFO] 
[2026-08-10 14:30:58] [INFO] === Fim do Wrapper.prg ===
[2026-08-10 14:30:58] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-10 14:55:54] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-10 14:55:54] [INFO] Config FPW: (nao fornecido)
[2026-08-10 14:55:54] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 14:55:54] [INFO] Timeout: 300 segundos
[2026-08-10 14:55:54] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cbpa5nhw.prg
[2026-08-10 14:55:54] [INFO] Conteudo do wrapper:
[2026-08-10 14:55:54] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formint', 'C:\4c\tasks\task453', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formint', 'C:\4c\tasks\task453', 'CRUD'
QUIT

[2026-08-10 14:55:54] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cbpa5nhw.prg
[2026-08-10 14:55:54] [INFO] VFP output esperado em: C:\4c\tasks\task453\vfp_output.txt
[2026-08-10 14:55:54] [INFO] Executando Visual FoxPro 9...
[2026-08-10 14:55:54] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cbpa5nhw.prg
[2026-08-10 14:55:54] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cbpa5nhw.prg
[2026-08-10 14:55:54] [INFO] Timeout configurado: 300 segundos
[2026-08-10 15:00:54] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 11960)...
[2026-08-10 15:00:56] [INFO] VFP9 finalizado em 302.0576451 segundos
[2026-08-10 15:00:56] [INFO] Exit Code: 4
[2026-08-10 15:00:56] [INFO] 
[2026-08-10 15:00:56] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-10 15:00:56] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_cbpa5nhw.prg
[2026-08-10 15:00:56] [INFO] 
[2026-08-10 15:00:56] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-10 15:00:56] [INFO] * Auto-generated wrapper for parameters
[2026-08-10 15:00:56] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 15:00:56] [INFO] * Parameters: 'Formint', 'C:\4c\tasks\task453', 'CRUD'
[2026-08-10 15:00:56] [INFO] 
[2026-08-10 15:00:56] [INFO] * Anti-dialog protections for unattended execution
[2026-08-10 15:00:56] [INFO] SET SAFETY OFF
[2026-08-10 15:00:56] [INFO] SET RESOURCE OFF
[2026-08-10 15:00:56] [INFO] SET TALK OFF
[2026-08-10 15:00:56] [INFO] SET NOTIFY OFF
[2026-08-10 15:00:56] [INFO] SYS(2335, 0)
[2026-08-10 15:00:56] [INFO] 
[2026-08-10 15:00:56] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formint', 'C:\4c\tasks\task453', 'CRUD'
[2026-08-10 15:00:56] [INFO] QUIT
[2026-08-10 15:00:56] [INFO] 
[2026-08-10 15:00:56] [INFO] === Fim do Wrapper.prg ===
[2026-08-10 15:00:56] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-10 15:27:57] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-10 15:27:57] [INFO] Config FPW: (nao fornecido)
[2026-08-10 15:27:57] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 15:27:57] [INFO] Timeout: 300 segundos
[2026-08-10 15:27:57] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_thcxkg5u.prg
[2026-08-10 15:27:57] [INFO] Conteudo do wrapper:
[2026-08-10 15:27:57] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'Formint', 'C:\4c\tasks\task453', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formint', 'C:\4c\tasks\task453', 'CRUD'
QUIT

[2026-08-10 15:27:57] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_thcxkg5u.prg
[2026-08-10 15:27:57] [INFO] VFP output esperado em: C:\4c\tasks\task453\vfp_output.txt
[2026-08-10 15:27:57] [INFO] Executando Visual FoxPro 9...
[2026-08-10 15:27:57] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_thcxkg5u.prg
[2026-08-10 15:27:57] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_thcxkg5u.prg
[2026-08-10 15:27:57] [INFO] Timeout configurado: 300 segundos
[2026-08-10 15:32:57] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 4112)...
[2026-08-10 15:32:59] [INFO] VFP9 finalizado em 302.0893132 segundos
[2026-08-10 15:32:59] [INFO] Exit Code: 4
[2026-08-10 15:32:59] [INFO] 
[2026-08-10 15:32:59] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-10 15:32:59] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_thcxkg5u.prg
[2026-08-10 15:32:59] [INFO] 
[2026-08-10 15:32:59] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-10 15:32:59] [INFO] * Auto-generated wrapper for parameters
[2026-08-10 15:32:59] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 15:33:00] [INFO] * Parameters: 'Formint', 'C:\4c\tasks\task453', 'CRUD'
[2026-08-10 15:33:00] [INFO] 
[2026-08-10 15:33:00] [INFO] * Anti-dialog protections for unattended execution
[2026-08-10 15:33:00] [INFO] SET SAFETY OFF
[2026-08-10 15:33:00] [INFO] SET RESOURCE OFF
[2026-08-10 15:33:00] [INFO] SET TALK OFF
[2026-08-10 15:33:00] [INFO] SET NOTIFY OFF
[2026-08-10 15:33:00] [INFO] SYS(2335, 0)
[2026-08-10 15:33:00] [INFO] 
[2026-08-10 15:33:00] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'Formint', 'C:\4c\tasks\task453', 'CRUD'
[2026-08-10 15:33:00] [INFO] QUIT
[2026-08-10 15:33:00] [INFO] 
[2026-08-10 15:33:00] [INFO] === Fim do Wrapper.prg ===
[2026-08-10 15:33:00] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\cadastros\Formint.prg):
*==============================================================================
* Formint.prg - Formulario Operacional Tratamento de Inventario
* Migrado de: SIGCDINT.SCX (frmcadastro)
* Tabela principal: SigCdBal
* 3 paginas: Lista (inventarios), Dados (filtros), Tratamento (grade itens)
*==============================================================================

DEFINE CLASS Formint AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: EXATAS do original)
    Height      = 600
    Width       = 1000
    Caption     = ""
    AutoCenter  = .T.
    ShowWindow   = 0
    WindowType   = 0
    ShowWindow = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Estado do inventario selecionado
    this_nCodigoSel      = 0
    this_cCIdChavesSel   = ""

    *-- Estado de exibicao da grade de tratamento
    this_cOldValue       = ""
    this_nCItens         = 0
    this_cObsAnterior    = ""

    *-- Controle de ultimo valor validado (guarda LOSTFOCUS duplicado)
    this_cUltimoGetJustifValid          = ""
    this_cUltimoGetTOcorCntTratValid    = ""
    this_cUltimoGetTOcorBaixaAutoValid  = ""
    this_cUltimoGetIOcorValid           = ""

    *===========================================================================
    * Init - Inicializa o formulario
    * REGRA CRITICA: Apenas RETURN DODEFAULT()
    * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
    *===========================================================================
    PROCEDURE Init()
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
            *-- Fix DataSession=2: reseta SET DATE/CENTURY (CLAUDE.md regra 9.4)
            SET DATE TO BRITISH
            SET CENTURY ON

            *-- Criar BO
            THIS.this_oBusinessObject = CREATEOBJECT("intBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar intBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formint.InicializarForm")
            ELSE
                *-- Caption com acento (CHR obrigatorio - CLAUDE.md regra 4)
                THIS.Caption = "Tratamento de Invent" + CHR(225) + "rio"

                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MsgErro("Erro ao inicializar Formint:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com 3 paginas
    * PageCount=3: Page1=Lista, Page2=Dados, Page3=Tratamento
    * Top=-29 esconde abas; compensar +29 em todos os controles internos
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 3
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.BackColor = RGB(255, 255, 255)
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"

            .Page2.Caption   = "Dados"
            .Page2.BackColor = RGB(255, 255, 255)
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"

            .Page3.Caption   = "Tratamento"
            .Page3.BackColor = RGB(255, 255, 255)
            .Page3.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarPaginaTratamento()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1 (Lista de inventarios)
    * Original: cntSombra.Top=1 -> +29 = 30
    *           Grupo_op.Left=543, Top=-1 -> +29 = 28
    *           Grupo_Saida.Left=918 -> canonico Left=917
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container Cabecalho (cntSombra no legado)
        * Original: Top=1, Left=-1, Width=1004, Height=80
        * Com compensacao +29: Top=30
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
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

        *----------------------------------------------------------------------
        * Container Botoes CRUD (Grupo_op no legado)
        * Original: Left=543, Top=-1, Width=385, Height=85
        * Com compensacao +29: Top=28; Left=543 mantido (proximo do canonico 542)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Balanco (Balan?o - relatorio de inventario)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Balanco", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Balanco
            .Caption         = "Balan" + CHR(231) + "o"
            .Picture         = gc_4c_CaminhoIcones + "geral_balanca_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Balanco, "Click", THIS, "BtnBalancoClick")

        *-- Botao BaixaAuto (Baixa Automatica por ocorrencia)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_BaixaAuto", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_BaixaAuto
            .Caption         = "Bx.Aut."
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_BaixaAuto, "Click", THIS, "BtnBaixaAutoClick")

        *-- Botao Tratamento (Iniciar tratamento de inventario)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Tratamento", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Tratamento
            .Caption         = "Tratar"
            .Picture         = gc_4c_CaminhoIcones + "geral_empilha_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Tratamento, "Click", THIS, "BtnTratamentoClick")

        *-- Botao Fechar (Fechar/Encerrar o inventario - operacao de encerramento)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Fechar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Fechar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Fechar, "Click", THIS, "BtnFecharClick")

        *-- Botao Procurar (Navega para Page2 para entrada de filtros)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Procurar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar
            .Caption         = "Procurar"
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
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Procurar, "Click", THIS, "BtnProcurarClick")

        *----------------------------------------------------------------------
        * Container Saida - PADRAO CANONICO (CLAUDE.md regra #10)
        * Left=917, Width=90, Height=85 - prevalece sobre original (Left=918)
        * Top=29 canonico; BackStyle=0 (transparente)
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

        *-- Botao Encerrar (canonico CLAUDE.md)
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

        *----------------------------------------------------------------------
        * Botoes de cabecalho de coluna (sort/foco no grid)
        * Top=124+29=153; Height=20 (visual de header de coluna)
        * Posicoes e larguras do layout.json
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cmd_4c_Processo", "CommandButton")
        WITH loc_oPagina.cmd_4c_Processo
            .Caption       = "Processo"
            .Top           = 153
            .Left          = 12
            .Width         = 62
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(192, 192, 192)
            .SpecialEffect = 1
            .Themes        = .F.
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Processo, "Click", THIS, "CmdProcessoClick")

        loc_oPagina.AddObject("cmd_4c_Periodo", "CommandButton")
        WITH loc_oPagina.cmd_4c_Periodo
            .Caption       = "Per" + CHR(237) + "odo"
            .Top           = 153
            .Left          = 73
            .Width         = 153
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(192, 192, 192)
            .SpecialEffect = 1
            .Themes        = .F.
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Periodo, "Click", THIS, "CmdPeriodoClick")

        loc_oPagina.AddObject("cmd_4c_Estoque", "CommandButton")
        WITH loc_oPagina.cmd_4c_Estoque
            .Caption       = "Estoque"
            .Top           = 153
            .Left          = 225
            .Width         = 143
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(192, 192, 192)
            .SpecialEffect = 1
            .Themes        = .F.
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Estoque, "Click", THIS, "CmdEstoqueClick")

        loc_oPagina.AddObject("cmd_4c_Local", "CommandButton")
        WITH loc_oPagina.cmd_4c_Local
            .Caption       = "Local"
            .Top           = 153
            .Left          = 367
            .Width         = 163
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(192, 192, 192)
            .SpecialEffect = 1
            .Themes        = .F.
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Local, "Click", THIS, "CmdLocalClick")

        loc_oPagina.AddObject("cmd_4c_Grupo", "CommandButton")
        WITH loc_oPagina.cmd_4c_Grupo
            .Caption       = "Grupo"
            .Top           = 153
            .Left          = 529
            .Width         = 69
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(192, 192, 192)
            .SpecialEffect = 1
            .Themes        = .F.
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Grupo, "Click", THIS, "CmdGrupoClick")

        loc_oPagina.AddObject("cmd_4c_GGrupo", "CommandButton")
        WITH loc_oPagina.cmd_4c_GGrupo
            .Caption       = "GGrupo"
            .Top           = 153
            .Left          = 597
            .Width         = 69
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(192, 192, 192)
            .SpecialEffect = 1
            .Themes        = .F.
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_GGrupo, "Click", THIS, "CmdGGrupoClick")

        loc_oPagina.AddObject("cmd_4c_Usuario", "CommandButton")
        WITH loc_oPagina.cmd_4c_Usuario
            .Caption       = "Usu" + CHR(225) + "rio"
            .Top           = 153
            .Left          = 665
            .Width         = 78
            .Height        = 20
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(0, 0, 0)
            .BackColor     = RGB(192, 192, 192)
            .SpecialEffect = 1
            .Themes        = .F.
            .MousePointer  = 15
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_Usuario, "Click", THIS, "CmdUsuarioClick")

        *----------------------------------------------------------------------
        * Grid principal de inventarios
        * Original: Top=145, Left=12, Width=934, Height=446
        * Compensacao +29: Top=174
        * Width=905 (12+905=917=cnt_4c_Saida.Left - sem sobreposicao)
        * HeaderHeight=0: botoes acima servem como cabecalhos visuais
        * ColumnCount FORA do WITH (Problem 36)
        * ControlSource/DynamicBackColor: vinculados em CarregarLista() (Problem 32)
        * Colunas: codigos/datainis/datafims/contas/localis/localfs/grupos/cggruis/usuars/encerras
        * Larguras: 62+78+75+143+81+82+69+69+78+168 = 905
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oPagina.grd_4c_Dados.ColumnCount = 10
        WITH loc_oPagina.grd_4c_Dados
            .Top           = 174
            .Left          = 12
            .Width         = 905
            .Height        = 446
            .RecordSource  = ""
            .ReadOnly      = .T.
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .GridLines     = 1
            .GridLineWidth = 1
            .GridLineColor = RGB(200, 200, 200)
            .HeaderHeight  = 0
            .RowHeight     = 20
            .FontName      = "Tahoma"
            .FontSize      = 9
            .ScrollBars    = 2
            .Visible       = .T.
            WITH .Column1
                .Width     = 62
                .Resizable = .F.
                .Alignment = 0
            ENDWITH
            WITH .Column2
                .Width     = 78
                .Resizable = .F.
                .Alignment = 0
            ENDWITH
            WITH .Column3
                .Width     = 75
                .Resizable = .F.
                .Alignment = 0
            ENDWITH
            WITH .Column4
                .Width     = 143
                .Resizable = .F.
                .Alignment = 0
            ENDWITH
            WITH .Column5
                .Width     = 81
                .Resizable = .F.
                .Alignment = 0
            ENDWITH
            WITH .Column6
                .Width     = 82
                .Resizable = .F.
                .Alignment = 0
            ENDWITH
            WITH .Column7
                .Width     = 69
                .Resizable = .F.
                .Alignment = 0
            ENDWITH
            WITH .Column8
                .Width     = 69
                .Resizable = .F.
                .Alignment = 0
            ENDWITH
            WITH .Column9
                .Width     = 78
                .Resizable = .F.
                .Alignment = 0
            ENDWITH
            WITH .Column10
                .Width     = 168
                .Resizable = .F.
                .Alignment = 0
            ENDWITH
        ENDWITH
        BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 (Filtros para selecao do inventario)
    * Original: Grupo_Salva.Left=821, Top=10, Width=160, Height=85
    * Com compensacao +29: Top=39
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *----------------------------------------------------------------------
        * Container Botoes Acao (Grupo_Salva no legado: Salva + Cancelar)
        * Original: Left=821, Top=10, Width=160, Height=85 -> Top=10+29=39
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 39
            .Left        = 821
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Confirmar (Salva no legado: Left=5, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")

        *-- Botao Cancelar (Left=80, Top=5)
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
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
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * FASE 5/8 - CAMPOS PRINCIPAIS PARTE 1
        * Primeira metade dos campos da Page2 (filtros/dados do inventario)
        * Compensacao +29 aplicada em todos os Top (PageFrame.Top = -29)
        *
        * Campos leitura-only: BackColor cinza (230,230,230) + ReadOnly=.T.
        * Apenas txt_4c_Codigo eh editavel (para busca por codigo)
        *----------------------------------------------------------------------

        *-- txt_4c_Codigo (Get_Codigo: Top=157, Left=303, Width=44 -> +29=186)
        *-- Editavel SOMENTE ao procurar (unico campo de entrada na Page2)
        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value       = ""
            .Top         = 186
            .Left        = 303
            .Width       = 44
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Label3 (Say3 "Codigo": Top=161, Left=252, Width=42 -> +29=190)
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 190
            .Left      = 252
            .Width     = 42
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_Grupo (Get_Grupo: Top=182, Left=303, Width=81 -> +29=211)
        *-- Leitura-only: exibe grupo do inventario selecionado
        loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
        WITH loc_oPagina.txt_4c_Grupo
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 211
            .Left        = 303
            .Width       = 81
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Lbl_Grupos (lbl_grupos "Grupo": Top=186, Left=256, Width=38 -> +29=215)
        loc_oPagina.AddObject("lbl_4c_Lbl_Grupos", "Label")
        WITH loc_oPagina.lbl_4c_Lbl_Grupos
            .Caption   = "Grupo :"
            .Top       = 215
            .Left      = 256
            .Width     = 38
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DGrupo (Get_DGrupo: Top=182, Left=386, Width=316 -> +29=211)
        *-- Leitura-only: descricao do grupo
        loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPagina.txt_4c_DGrupo
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 211
            .Left        = 386
            .Width       = 316
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- txt_4c_Conta (Get_Conta "Estoque": Top=207, Left=303, Width=81 -> +29=236)
        *-- Leitura-only: estoque/conta do inventario
        loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
        WITH loc_oPagina.txt_4c_Conta
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 236
            .Left        = 303
            .Width       = 81
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Label12 (Say12 "Estoque": Top=211, Left=246, Width=48 -> +29=240)
        loc_oPagina.AddObject("lbl_4c_Label12", "Label")
        WITH loc_oPagina.lbl_4c_Label12
            .Caption   = "Estoque :"
            .Top       = 240
            .Left      = 246
            .Width     = 48
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_DConta (Get_DConta: Top=207, Left=386, Width=316 -> +29=236)
        *-- Leitura-only: descricao do estoque/conta
        loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
        WITH loc_oPagina.txt_4c_DConta
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 236
            .Left        = 386
            .Width       = 316
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- txt_4c_DataInicial (Get_DataInicial: Top=232, Left=303, Width=81 -> +29=261)
        *-- Leitura-only: data inicial do inventario
        loc_oPagina.AddObject("txt_4c_DataInicial", "TextBox")
        WITH loc_oPagina.txt_4c_DataInicial
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 261
            .Left        = 303
            .Width       = 81
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- txt_4c_DataFinal (Get_DataFinal: Top=232, Left=406, Width=81 -> +29=261)
        *-- Leitura-only: data final do inventario
        loc_oPagina.AddObject("txt_4c_DataFinal", "TextBox")
        WITH loc_oPagina.txt_4c_DataFinal
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 261
            .Left        = 406
            .Width       = 81
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Label1 (Say1 "Periodo": Top=236, Left=249, Width=45 -> +29=265)
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 265
            .Left      = 249
            .Width     = 45
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label4 (Say4 separador periodo: Top=236, Left=387, Width=14 -> +29=265)
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = " - "
            .Top       = 265
            .Left      = 387
            .Width     = 14
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_LocalInicial (Get_LocalInicial: Top=232, Left=569, Width=56 -> +29=261)
        *-- Leitura-only: local inicial do inventario
        loc_oPagina.AddObject("txt_4c_LocalInicial", "TextBox")
        WITH loc_oPagina.txt_4c_LocalInicial
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 261
            .Left        = 569
            .Width       = 56
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- txt_4c_LocalFinal (Get_LocalFinal: Top=232, Left=646, Width=56 -> +29=261)
        *-- Leitura-only: local final do inventario
        loc_oPagina.AddObject("txt_4c_LocalFinal", "TextBox")
        WITH loc_oPagina.txt_4c_LocalFinal
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 261
            .Left        = 646
            .Width       = 56
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Label2 (Say2 "Local": Top=236, Left=527, Width=33 -> +29=265)
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Local :"
            .Top       = 265
            .Left      = 527
            .Width     = 33
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label5 (Say5 separador local: Top=236, Left=626, Width=14 -> +29=265)
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = " - "
            .Top       = 265
            .Left      = 626
            .Width     = 14
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * FASE 6/8 - CAMPOS RESTANTES (segunda metade da Page2)
        * Fornecedor, Grupo range, GGrupo range, Preco range
        * Todos read-only (When=Return(.F.) no original)
        * Compensacao +29 aplicada em todos os Top
        *----------------------------------------------------------------------

        *-- txt_4c_FornecInicial (Get_FornecInicial: Top=257, Left=303, Width=81 -> +29=286)
        loc_oPagina.AddObject("txt_4c_FornecInicial", "TextBox")
        WITH loc_oPagina.txt_4c_FornecInicial
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 286
            .Left        = 303
            .Width       = 81
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- txt_4c_FornecFinal (Get_FornecFinal: Top=257, Left=406, Width=81 -> +29=286)
        loc_oPagina.AddObject("txt_4c_FornecFinal", "TextBox")
        WITH loc_oPagina.txt_4c_FornecFinal
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 286
            .Left        = 406
            .Width       = 81
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Label6 (Say6 "Fornecedor": Top=261, Left=230, Width=64, Height=15 -> +29=290)
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Fornecedor :"
            .Top       = 290
            .Left      = 230
            .Width     = 64
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label7 (Say7 separador fornecedor: Top=261, Left=387, Width=14 -> +29=290)
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = " - "
            .Top       = 290
            .Left      = 387
            .Width     = 14
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_GrupoInicial (Get_GrupoInicial: Top=124, Left=529, Width=34 -> +29=153)
        loc_oPagina.AddObject("txt_4c_GrupoInicial", "TextBox")
        WITH loc_oPagina.txt_4c_GrupoInicial
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 153
            .Left        = 529
            .Width       = 34
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- txt_4c_GrupoFinal (Get_GrupoFinal: Top=257, Left=646, Width=34 -> +29=286)
        loc_oPagina.AddObject("txt_4c_GrupoFinal", "TextBox")
        WITH loc_oPagina.txt_4c_GrupoFinal
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 286
            .Left        = 646
            .Width       = 34
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Label8 (Say8 "Grupo": Top=261, Left=521, Width=38 -> +29=290)
        loc_oPagina.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oPagina.lbl_4c_Label8
            .Caption   = "Grupo :"
            .Top       = 290
            .Left      = 521
            .Width     = 38
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label9 (Say9 separador grupo: Top=261, Left=626, Width=14 -> +29=290)
        loc_oPagina.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oPagina.lbl_4c_Label9
            .Caption   = " - "
            .Top       = 290
            .Left      = 626
            .Width     = 14
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_PrecoInicial (Get_PrecoInicial: Top=282, Left=303, Width=81 -> +29=311)
        loc_oPagina.AddObject("txt_4c_PrecoInicial", "TextBox")
        WITH loc_oPagina.txt_4c_PrecoInicial
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 311
            .Left        = 303
            .Width       = 81
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- txt_4c_PrecoFinal (Get_PrecoFinal: Top=282, Left=406, Width=81 -> +29=311)
        loc_oPagina.AddObject("txt_4c_PrecoFinal", "TextBox")
        WITH loc_oPagina.txt_4c_PrecoFinal
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 311
            .Left        = 406
            .Width       = 81
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Label10 (Say10 "Valor": Top=286, Left=261, Width=33 -> +29=315)
        loc_oPagina.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oPagina.lbl_4c_Label10
            .Caption   = "Valor :"
            .Top       = 315
            .Left      = 261
            .Width     = 33
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label11 (Say11 separador preco: Top=286, Left=387, Width=14 -> +29=315)
        loc_oPagina.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oPagina.lbl_4c_Label11
            .Caption   = " - "
            .Top       = 315
            .Left      = 387
            .Width     = 14
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- txt_4c_GGrupoInicial (Get_GGrupoInicial: Top=282, Left=569, Width=34 -> +29=311)
        loc_oPagina.AddObject("txt_4c_GGrupoInicial", "TextBox")
        WITH loc_oPagina.txt_4c_GGrupoInicial
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 311
            .Left        = 569
            .Width       = 34
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- txt_4c_GGrupoFinal (Get_GGrupoFinal: Top=282, Left=646, Width=34 -> +29=311)
        loc_oPagina.AddObject("txt_4c_GGrupoFinal", "TextBox")
        WITH loc_oPagina.txt_4c_GGrupoFinal
            .Value       = ""
            .ReadOnly    = .T.
            .Top         = 311
            .Left        = 646
            .Width       = 34
            .Height      = 23
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(230, 230, 230)
            .ForeColor   = RGB(0, 0, 0)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- lbl_4c_Label13 (Say13 "Gde.Grupo": Top=286, Left=494, Width=61 -> +29=315)
        loc_oPagina.AddObject("lbl_4c_Label13", "Label")
        WITH loc_oPagina.lbl_4c_Label13
            .Caption   = "Gde.Grupo :"
            .Top       = 315
            .Left      = 494
            .Width     = 61
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- lbl_4c_Label14 (Say14 separador ggrup: Top=286, Left=626, Width=14 -> +29=315)
        loc_oPagina.AddObject("lbl_4c_Label14", "Label")
        WITH loc_oPagina.lbl_4c_Label14
            .Caption   = " - "
            .Top       = 315
            .Left      = 626
            .Width     = 14
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaTratamento - Configura Page3 (Grade de tratamento de itens)
    * Fase 6: implementacao completa com todos os containers flutuantes e grid
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaTratamento()
        LOCAL loc_oPagina, loc_oCnt, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page3

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *==========================================================================
        *-- cnt_4c__CCusto1 (painel superior de controles): Top=0+29=29
        *-- Fica visivel apos selecionar linha no grid (GrdBalancoAfterRowColChange)
        *==========================================================================
        loc_oPagina.AddObject("cnt_4c__CCusto1", "Container")
        WITH loc_oPagina.cnt_4c__CCusto1
            .Top        = 29
            .Left       = 0
            .Width      = 1000
            .Height     = 197
            .Visible    = .F.
            .BackColor  = RGB(240, 240, 240)
            .BorderWidth = 1
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c__CCusto1

        *-- Botoes do painel superior
        loc_oCnt.AddObject("cmd_4c_Sobra", "CommandButton")
        WITH loc_oCnt.cmd_4c_Sobra
            .Top = 5
            .Left = 12
            .Width = 75
            .Height = 75
            .Caption = "\<Sobra"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("chk_4c_RepeteObs", "CheckBox")
        WITH loc_oCnt.chk_4c_RepeteObs
            .Top = 12
            .Left = 88
            .Width = 75
            .Height = 75
            .Caption = "\<Repete Obs"
            .Value = 0
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_Procurar", "CommandButton")
        WITH loc_oCnt.cmd_4c_Procurar
            .Top = 5
            .Left = 163
            .Width = 75
            .Height = 75
            .Caption = "Procurar"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_BarraNovo", "CommandButton")
        WITH loc_oCnt.cmd_4c_BarraNovo
            .Top = 5
            .Left = 238
            .Width = 75
            .Height = 75
            .Caption = "Novo \<Barra"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .F.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_CancelaCnt", "CommandButton")
        WITH loc_oCnt.cmd_4c_CancelaCnt
            .Top = 5
            .Left = 831
            .Width = 75
            .Height = 75
            .Caption = "\<Cancela"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .F.
        ENDWITH

        loc_oCnt.AddObject("cmd_4c_SairCnt", "CommandButton")
        WITH loc_oCnt.cmd_4c_SairCnt
            .Top = 5
            .Left = 906
            .Width = 75
            .Height = 75
            .Caption = "OK"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .T.
        ENDWITH

        *-- Indicador de tipo
        loc_oCnt.AddObject("lbl_4c_Tp", "Label")
        WITH loc_oCnt.lbl_4c_Tp
            .Caption   = "[L]idos, [N]" + CHR(227) + "o lidos, [S]aldos"
            .Top = 32
            .Left = 340
            .Width = 220
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 128)
            .Visible = .T.
        ENDWITH

        *-- Sub-container cnt_4c__Total (contadores de ocorrencias)
        loc_oCnt.AddObject("cnt_4c__Total", "Container")
        WITH loc_oCnt.cnt_4c__Total
            .Top = 52
            .Left = 340
            .Width = 194
            .Height = 58
            .BackColor = RGB(220, 220, 220)
            .BorderWidth = 1
            .Visible = .T.
        ENDWITH

        loc_oCnt.cnt_4c__Total.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.cnt_4c__Total.lbl_4c_Label1
            .Caption = "Ocorr" + CHR(234) + "ncias :"
            .Top = 9
            .Left = 49
            .Width = 66
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.cnt_4c__Total.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.cnt_4c__Total.lbl_4c_Label2
            .Caption = "Sem Ocorr" + CHR(234) + "ncias :"
            .Top = 32
            .Left = 26
            .Width = 89
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.cnt_4c__Total.AddObject("txt_4c_TotCOc", "TextBox")
        WITH loc_oCnt.cnt_4c__Total.txt_4c_TotCOc
            .Value = 0
            .ReadOnly = .T.
            .Top = 6
            .Left = 117
            .Width = 71
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .BackColor = RGB(255, 255, 200)
            .Visible = .T.
        ENDWITH

        loc_oCnt.cnt_4c__Total.AddObject("txt_4c_TotSOc", "TextBox")
        WITH loc_oCnt.cnt_4c__Total.txt_4c_TotSOc
            .Value = 0
            .ReadOnly = .T.
            .Top = 29
            .Left = 117
            .Width = 71
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .BackColor = RGB(255, 255, 200)
            .Visible = .T.
        ENDWITH

        *-- Labels do painel superior
        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .Caption = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top = 126
            .Left = 19
            .Width = 55
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .Caption = "C. Custo :"
            .Top = 151
            .Left = 25
            .Width = 51
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .Caption = "C. Custo2 :"
            .Top = 149
            .Left = 171
            .Width = 57
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oCnt.lbl_4c_Label6
            .Caption = "Diferen" + CHR(231) + "a :"
            .Top = 149
            .Left = 327
            .Width = 55
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Caption = "Peso Real :"
            .Top = 176
            .Left = 19
            .Width = 56
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oCnt.lbl_4c_Label7
            .Caption = "Peso :"
            .Top = 174
            .Left = 201
            .Width = 32
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oCnt.lbl_4c_Label8
            .Caption = "Usu" + CHR(225) + "rio :"
            .Top = 174
            .Left = 339
            .Width = 45
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        *-- Campos de dados do produto selecionado
        loc_oCnt.AddObject("txt_4c_DPro", "TextBox")
        WITH loc_oCnt.txt_4c_DPro
            .Value = ""
            .ReadOnly = .F.
            .Top = 121
            .Left = 87
            .Width = 389
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CCusto", "TextBox")
        WITH loc_oCnt.txt_4c_CCusto
            .Value = ""
            .ReadOnly = .T.
            .Top = 146
            .Left = 87
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .BackColor = RGB(230, 230, 230)
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CCusto2", "TextBox")
        WITH loc_oCnt.txt_4c_CCusto2
            .Value = ""
            .ReadOnly = .T.
            .Top = 146
            .Left = 240
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .BackColor = RGB(230, 230, 230)
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Dif", "TextBox")
        WITH loc_oCnt.txt_4c_Dif
            .Value = 0
            .ReadOnly = .T.
            .Top = 146
            .Left = 395
            .Width = 81
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .BackColor = RGB(230, 230, 230)
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_PesReal", "TextBox")
        WITH loc_oCnt.txt_4c_PesReal
            .Value = 0
            .ReadOnly = .T.
            .Top = 171
            .Left = 87
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .BackColor = RGB(230, 230, 230)
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Peso", "TextBox")
        WITH loc_oCnt.txt_4c_Peso
            .Value = 0
            .ReadOnly = .T.
            .Top = 171
            .Left = 240
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .BackColor = RGB(230, 230, 230)
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Usuars", "TextBox")
        WITH loc_oCnt.txt_4c_Usuars
            .Value = ""
            .ReadOnly = .T.
            .Top = 171
            .Left = 395
            .Width = 81
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .BackColor = RGB(230, 230, 230)
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("edt_4c_ObsCnt1", "EditBox")
        WITH loc_oCnt.edt_4c_ObsCnt1
            .Value = ""
            .Top = 121
            .Left = 484
            .Width = 507
            .Height = 73
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        *-- BINDEVENTS cnt_4c__CCusto1
        BINDEVENT(loc_oCnt.cmd_4c_Sobra,      "Click",     THIS, "BtnSobraClick")
        BINDEVENT(loc_oCnt.cmd_4c_Procurar,   "Click",     THIS, "BtnProcurarCntClick")
        BINDEVENT(loc_oCnt.cmd_4c_BarraNovo,  "Click",     THIS, "BtnBarraNovoCntClick")
        BINDEVENT(loc_oCnt.cmd_4c_CancelaCnt, "Click",     THIS, "BtnCancelaCntClick")
        BINDEVENT(loc_oCnt.cmd_4c_SairCnt,    "Click",     THIS, "BtnSairCntClick")
        BINDEVENT(loc_oCnt.txt_4c_DPro,       "KeyPress", THIS, "GetDProLostFocus")

        *==========================================================================
        *-- grd_4c_Dados (GrdBalanco): Top=210+29=239, Left=17, W=972, H=364
        *-- RecordSource definido fora do WITH (evita "Unknown member COLUMN1")
        *==========================================================================
        loc_oPagina.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Dados
        loc_oGrid.RecordSource = ""
        loc_oGrid.ColumnCount  = 10

        WITH loc_oGrid
            .Top         = 239
            .Left        = 17
            .Width       = 972
            .Height      = 364
            .Visible     = .F.
            .ReadOnly    = .F.
            .FontName    = "Tahoma"
            .FontSize    = 9
            .GridLines   = 1
            .DeleteMark  = .F.
            .RecordMark  = .F.
            .HeaderHeight = 21
            .RowHeight    = 20
        ENDWITH

        WITH loc_oGrid.Column1
            .Width = 120
            .ReadOnly = .T.
            .Header1.Caption = "Produto"
        ENDWITH
        WITH loc_oGrid.Column2
            .Width = 80 
            .ReadOnly = .T.
            .Header1.Caption = "Data"
        ENDWITH
        WITH loc_oGrid.Column3
            .Width = 100
            .ReadOnly = .T.
            .Header1.Caption = "Barra"
        ENDWITH
        WITH loc_oGrid.Column4
            .Width = 80 
            .ReadOnly = .T.
            .Header1.Caption = "Barra Novo"
        ENDWITH
        WITH loc_oGrid.Column5
            .Width = 65 
            .ReadOnly = .T.
            .Header1.Caption = "Apurado"
        ENDWITH
        WITH loc_oGrid.Column6
            .Width = 65 
            .ReadOnly = .T.
            .Header1.Caption = "Estoque"
        ENDWITH
        WITH loc_oGrid.Column7
            .Width = 65 
            .ReadOnly = .T.
            .Header1.Caption = "Diferen" + CHR(231) + "a"
        ENDWITH
        WITH loc_oGrid.Column8
            .Width = 80 
            .ReadOnly = .F.
            .Sparse = .F.
            .Header1.Caption = "Ocorrencia"
        ENDWITH
        WITH loc_oGrid.Column9
            .Width = 20 
            .ReadOnly = .T.
            .Header1.Caption = "T"
        ENDWITH
        WITH loc_oGrid.Column10
            .Width = 70
            .ReadOnly = .T.
            .Header1.Caption = "Dif. Peso"
        ENDWITH

        BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GrdBalancoAfterRowColChange")
        BINDEVENT(loc_oGrid.Column8.Text1, "When",      THIS, "GrdColOcorWhen")
        BINDEVENT(loc_oGrid.Column8.Text1, "Valid",     THIS, "GrdColOcorValid")
        BINDEVENT(loc_oGrid.Column8.Text1, "KeyPress", THIS, "GrdColOcorLostFocus")

        *==========================================================================
        *-- cnt_4c__Custo2 (painel Novo Barra): Top=210+29=239
        *==========================================================================
        loc_oPagina.AddObject("cnt_4c__Custo2", "Container")
        WITH loc_oPagina.cnt_4c__Custo2
            .Top = 239
            .Left = 17
            .Width = 972
            .Height = 364
            .Visible = .F.
            .BackColor = RGB(240, 240, 240)
            .BorderWidth = 1
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c__Custo2

        loc_oCnt.AddObject("lbl_4c_label42", "Label")
        WITH loc_oCnt.lbl_4c_label42
            .Caption = "Barra Novo :"
            .Top = 18
            .Left = 270
            .Width = 63
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label32", "Label")
        WITH loc_oCnt.lbl_4c_label32
            .Caption = "Centro de Custo :"
            .Top = 43
            .Left = 245
            .Width = 88
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label22", "Label")
        WITH loc_oCnt.lbl_4c_label22
            .Caption = "Peso :"
            .Top = 68
            .Left = 301
            .Width = 32
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label52", "Label")
        WITH loc_oCnt.lbl_4c_label52
            .Caption = "C" + CHR(243) + "digo Justificativa :"
            .Top = 92
            .Left = 231
            .Width = 102
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Caption = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top = 115
            .Left = 266
            .Width = 67
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_GetBarNovo", "TextBox")
        WITH loc_oCnt.txt_4c_GetBarNovo
            .Value = ""
            .Top = 14
            .Left = 339
            .Width = 108
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_BNCCusto", "TextBox")
        WITH loc_oCnt.txt_4c_BNCCusto
            .Value = ""
            .ReadOnly = .T.
            .Top = 39
            .Left = 339
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .BackColor = RGB(230, 230, 230)
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_BNPesReal", "TextBox")
        WITH loc_oCnt.txt_4c_BNPesReal
            .Value = 0
            .ReadOnly = .T.
            .Top = 64
            .Left = 339
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .BackColor = RGB(230, 230, 230)
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_GetJustif", "TextBox")
        WITH loc_oCnt.txt_4c_GetJustif
            .Value = ""
            .Top = 89
            .Left = 339
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("edt_4c_BNObs", "EditBox")
        WITH loc_oCnt.edt_4c_BNObs
            .Value = ""
            .Top = 112
            .Left = 339
            .Width = 390
            .Height = 101
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("cmd_4c_BNCancela", "CommandButton")
        WITH loc_oCnt.cmd_4c_BNCancela
            .Top = 5
            .Left = 570
            .Width = 75
            .Height = 75
            .Caption = "Cancelar"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("cmd_4c_BNSair", "CommandButton")
        WITH loc_oCnt.cmd_4c_BNSair
            .Top = 5
            .Left = 645
            .Width = 75
            .Height = 75
            .Caption = "OK"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oCnt.txt_4c_GetJustif, "LostFocus", THIS, "GetJustifValid")
        BINDEVENT(loc_oCnt.cmd_4c_BNCancela, "Click", THIS, "BtnBNCancelaClick")
        BINDEVENT(loc_oCnt.cmd_4c_BNSair,    "Click", THIS, "BtnBNSairClick")

        *==========================================================================
        *-- cnt_4c_TratOcor (Tratamento por Ocorrencia): Top=210+29=239
        *==========================================================================
        loc_oPagina.AddObject("cnt_4c_TratOcor", "Container")
        WITH loc_oPagina.cnt_4c_TratOcor
            .Top = 239
            .Left = 17
            .Width = 972
            .Height = 364
            .Visible = .F.
            .BackColor = RGB(240, 240, 240)
            .BorderWidth = 1
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c_TratOcor

        loc_oCnt.AddObject("lbl_4c_label33", "Label")
        WITH loc_oCnt.lbl_4c_label33
            .Caption = "Tratamento Por Ocorr" + CHR(234) + "ncia"
            .Top = 7
            .Left = 16
            .Width = 200
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label53", "Label")
        WITH loc_oCnt.lbl_4c_label53
            .Caption = "Tipo Ocorr" + CHR(234) + "ncia :"
            .Top = 46
            .Left = 294
            .Width = 84
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label43", "Label")
        WITH loc_oCnt.lbl_4c_label43
            .Caption = "Ocorr" + CHR(234) + "ncia :"
            .Top = 68
            .Left = 317
            .Width = 61
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label72", "Label")
        WITH loc_oCnt.lbl_4c_label72
            .Caption = "Tipos :"
            .Top = 123
            .Left = 344
            .Width = 34
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label82", "Label")
        WITH loc_oCnt.lbl_4c_label82
            .Caption = "Ordem :"
            .Top = 149
            .Left = 337
            .Width = 41
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_TOcor", "TextBox")
        WITH loc_oCnt.txt_4c_TOcor
            .Value = ""
            .Top = 43
            .Left = 383
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("opt_4c_SemOcor", "OptionGroup")
        WITH loc_oCnt.opt_4c_SemOcor
            .Top = 66
            .Left = 379
            .Width = 114
            .Height = 49
            .ButtonCount = 3
            .Value = 1
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        WITH loc_oCnt.opt_4c_SemOcor
            .Buttons(1).Caption = "Lidos"
            .Buttons(1).Top = 0
            .Buttons(1).Left = 0
            .Buttons(1).Width = 55
            .Buttons(1).Height = 17
            .Buttons(2).Caption = "N" + CHR(227) + "o Lidos"
            .Buttons(2).Top = 16
            .Buttons(2).Left = 0
            .Buttons(2).Width = 55
            .Buttons(2).Height = 17
            .Buttons(3).Caption = "Saldos"
            .Buttons(3).Top = 32
            .Buttons(3).Left = 0
            .Buttons(3).Width = 55
            .Buttons(3).Height = 17
        ENDWITH

        loc_oCnt.AddObject("cmb_4c_Tipos", "ComboBox")
        WITH loc_oCnt.cmb_4c_Tipos
            .Top = 118
            .Left = 383
            .Width = 115
            .Height = 24
            .Style = 2
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH
        loc_oCnt.cmb_4c_Tipos.AddItem("Entrada")
        loc_oCnt.cmb_4c_Tipos.AddItem("Sa" + CHR(237) + "da")
        loc_oCnt.cmb_4c_Tipos.AddItem("Todos")
        loc_oCnt.cmb_4c_Tipos.Value = "Todos"

        loc_oCnt.AddObject("cmb_4c_Ordem", "ComboBox")
        WITH loc_oCnt.cmb_4c_Ordem
            .Top = 144
            .Left = 383
            .Width = 115
            .Height = 24
            .Style = 2
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH
        loc_oCnt.cmb_4c_Ordem.AddItem("Barra")
        loc_oCnt.cmb_4c_Ordem.AddItem("Produto")
        loc_oCnt.cmb_4c_Ordem.Value = "Barra"

        loc_oCnt.AddObject("cmd_4c_BtnTratOcor", "CommandButton")
        WITH loc_oCnt.cmd_4c_BtnTratOcor
            .Top = 45
            .Left = 582
            .Width = 75
            .Height = 75
            .Caption = "OK"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("cmd_4c_TOCancela", "CommandButton")
        WITH loc_oCnt.cmd_4c_TOCancela
            .Top = 45
            .Left = 507
            .Width = 75
            .Height = 75
            .Caption = "Cancelar"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oCnt.txt_4c_TOcor,       "LostFocus", THIS, "GetTOcorCntTratValid")
        BINDEVENT(loc_oCnt.cmd_4c_BtnTratOcor, "Click", THIS, "BtnTratOcorClick")
        BINDEVENT(loc_oCnt.cmd_4c_TOCancela,   "Click", THIS, "BtnTOCancelaClick")

        *==========================================================================
        *-- cnt_4c_BaixaAuto (Baixa Automatica por Ocorrencia): Top=210+29=239
        *==========================================================================
        loc_oPagina.AddObject("cnt_4c_BaixaAuto", "Container")
        WITH loc_oPagina.cnt_4c_BaixaAuto
            .Top = 239
            .Left = 17
            .Width = 972
            .Height = 364
            .Visible = .F.
            .BackColor = RGB(240, 240, 240)
            .BorderWidth = 1
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c_BaixaAuto

        loc_oCnt.AddObject("lbl_4c_label34", "Label")
        WITH loc_oCnt.lbl_4c_label34
            .Caption = "Baixa Autom" + CHR(225) + "tica por Ocorr" + CHR(234) + "ncia"
            .Top = 7
            .Left = 14
            .Width = 250
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 10
            .FontBold = .T.
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label54", "Label")
        WITH loc_oCnt.lbl_4c_label54
            .Caption = "Ocorr" + CHR(234) + "ncia :"
            .Top = 48
            .Left = 294
            .Width = 61
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label12", "Label")
        WITH loc_oCnt.lbl_4c_label12
            .Caption = "Per" + CHR(237) + "odo :"
            .Top = 71
            .Left = 310
            .Width = 45
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label44", "Label")
        WITH loc_oCnt.lbl_4c_label44
            .Caption = " - "
            .Top = 70
            .Left = 444
            .Width = 14
            .Height = 17
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_BATOcor", "TextBox")
        WITH loc_oCnt.txt_4c_BATOcor
            .Value = ""
            .Top = 45
            .Left = 360
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_BAData", "TextBox")
        WITH loc_oCnt.txt_4c_BAData
            .Value = {}
            .Top = 68
            .Left = 360
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Format = "D"
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_BADataF", "TextBox")
        WITH loc_oCnt.txt_4c_BADataF
            .Value = {}
            .Top = 68
            .Left = 454
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Format = "D"
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("cmd_4c_OkBaixaAuto", "CommandButton")
        WITH loc_oCnt.cmd_4c_OkBaixaAuto
            .Top = 45
            .Left = 626
            .Width = 75
            .Height = 75
            .Caption = "OK"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("cmd_4c_BACancela", "CommandButton")
        WITH loc_oCnt.cmd_4c_BACancela
            .Top = 45
            .Left = 551
            .Width = 75
            .Height = 75
            .Caption = "Cancelar"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oCnt.txt_4c_BATOcor,    "LostFocus", THIS, "GetTOcorBaixaAutoValid")
        BINDEVENT(loc_oCnt.cmd_4c_OkBaixaAuto,"Click", THIS, "OkBaixaAutoClick")
        BINDEVENT(loc_oCnt.cmd_4c_BACancela,  "Click", THIS, "BtnBACancelaClick")

        *==========================================================================
        *-- cnt_4c__Inserir (painel Inserir item de sobra): Top=210+29=239
        *==========================================================================
        loc_oPagina.AddObject("cnt_4c__Inserir", "Container")
        WITH loc_oPagina.cnt_4c__Inserir
            .Top = 239
            .Left = 17
            .Width = 972
            .Height = 364
            .Visible = .F.
            .BackColor = RGB(240, 240, 240)
            .BorderWidth = 1
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c__Inserir

        loc_oCnt.AddObject("lbl_4c_label45", "Label")
        WITH loc_oCnt.lbl_4c_label45
            .Caption = "Barra :"
            .Top = 25
            .Left = 289
            .Width = 35
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label35", "Label")
        WITH loc_oCnt.lbl_4c_label35
            .Caption = "C. Custo :"
            .Top = 50
            .Left = 273
            .Width = 51
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label55", "Label")
        WITH loc_oCnt.lbl_4c_label55
            .Caption = "Ocorr" + CHR(234) + "ncia :"
            .Top = 74
            .Left = 263
            .Width = 61
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("lbl_4c_label13", "Label")
        WITH loc_oCnt.lbl_4c_label13
            .Caption = "Observa" + CHR(231) + CHR(227) + "o :"
            .Top = 97
            .Left = 257
            .Width = 67
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_IBarra", "TextBox")
        WITH loc_oCnt.txt_4c_IBarra
            .Value = ""
            .Top = 21
            .Left = 329
            .Width = 108
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_ICCusto", "TextBox")
        WITH loc_oCnt.txt_4c_ICCusto
            .Value = ""
            .ReadOnly = .T.
            .Top = 46
            .Left = 329
            .Width = 80
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .BackColor = RGB(230, 230, 230)
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_IOcor", "TextBox")
        WITH loc_oCnt.txt_4c_IOcor
            .Value = ""
            .Top = 71
            .Left = 329
            .Width = 80
            .Height = 21
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("edt_4c_IBObs", "EditBox")
        WITH loc_oCnt.edt_4c_IBObs
            .Value = ""
            .Top = 94
            .Left = 329
            .Width = 220
            .Height = 101
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("cmd_4c_CntInsere", "CommandButton")
        WITH loc_oCnt.cmd_4c_CntInsere
            .Top = 21
            .Left = 562
            .Width = 75
            .Height = 75
            .Caption = "Inserir"
            .FontName = "Tahoma"
            .FontSize = 9
            .Enabled = .F.
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("cmd_4c_CntSairIns", "CommandButton")
        WITH loc_oCnt.cmd_4c_CntSairIns
            .Top = 21
            .Left = 637
            .Width = 75
            .Height = 75
            .Caption = "OK"
            .FontName = "Tahoma"
            .FontSize = 9
            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oCnt.txt_4c_IBarra,     "LostFocus", THIS, "GetIBarraValid")
        BINDEVENT(loc_oCnt.txt_4c_IOcor,      "LostFocus", THIS, "GetIOcorValid")
        BINDEVENT(loc_oCnt.cmd_4c_CntInsere,  "Click", THIS, "CntInsereClick")
        BINDEVENT(loc_oCnt.cmd_4c_CntSairIns, "Click", THIS, "CntSairInsClick")

        *==========================================================================
        *-- cnt_4c__Procurar (painel Procurar por Barra): Top=210+29=239
        *==========================================================================
        loc_oPagina.AddObject("cnt_4c__Procurar", "Container")
        WITH loc_oPagina.cnt_4c__Procurar
            .Top = 239
            .Left = 17
            .Width = 972
            .Height = 364
            .Visible = .F.
            .BackColor = RGB(240, 240, 240)
            .BorderWidth = 1
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c__Procurar

        loc_oCnt.AddObject("lbl_4c_label46", "Label")
        WITH loc_oCnt.lbl_4c_label46
            .Caption = "Barra :"
            .Top = 22
            .Left = 27
            .Width = 35
            .Height = 15
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
            .Visible = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_GetBusca", "TextBox")
        WITH loc_oCnt.txt_4c_GetBusca
            .Value = ""
            .Top = 18
            .Left = 71
            .Width = 108
            .Height = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .Visible = .T.
        ENDWITH

        BINDEVENT(loc_oCnt.txt_4c_GetBusca, "KeyPress", THIS, "GetBuscaValid")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega lista de inventarios da empresa atual
    * Fase 3: chama BO.Buscar() sem ainda vincular ao grid (Fase 4)
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (codigos N(4,0), cidchaves C(20), emps C(3), ;
                        grupos C(10), contas C(10), datainis D, datafims D, ;
                        localis C(10), localfs C(10), cggruis C(3), usuars C(10), ;
                        encerras L, trtporpeso N(1,0))
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF !THIS.this_oBusinessObject.Buscar("")
                    MsgErro("Erro ao carregar invent" + CHR(225) + "rios", ;
                        "Formint.CarregarLista")
                ELSE
                    LOCAL loc_oGrid
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                    *-- Vincular cursor ao grid (Problem 32: ControlSource apos RecordSource)
                    loc_oGrid.ColumnCount = 10
                    loc_oGrid.RecordSource           = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.codigos"
                    loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.datainis"
                    loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.datafims"
                    loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.contas"
                    loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.localis"
                    loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.localfs"
                    loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.grupos"
                    loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.cggruis"
                    loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.usuars"
                    loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.encerras"
                    *-- Problem 6/32: Headers DEVEM ser redefinidos apos RecordSource
                    loc_oGrid.Column1.Header1.Caption  = "Produto"
                    loc_oGrid.Column2.Header1.Caption  = "Data"
                    loc_oGrid.Column3.Header1.Caption  = "Barra"
                    loc_oGrid.Column4.Header1.Caption  = "Barra Novo"
                    loc_oGrid.Column5.Header1.Caption  = "Apurado"
                    loc_oGrid.Column6.Header1.Caption  = "Estoque"
                    loc_oGrid.Column7.Header1.Caption  = "Diferen" + CHR(231) + "a"
                    loc_oGrid.Column8.Header1.Caption  = "Ocorrencia"
                    loc_oGrid.Column9.Header1.Caption  = "T"
                    loc_oGrid.Column10.Header1.Caption = "Dif. Peso"
                    *-- Larguras aproximadas do original
                    loc_oGrid.Column1.Width  = 60
                    loc_oGrid.Column2.Width  = 75
                    loc_oGrid.Column3.Width  = 75
                    loc_oGrid.Column4.Width  = 70
                    loc_oGrid.Column5.Width  = 80
                    loc_oGrid.Column6.Width  = 80
                    loc_oGrid.Column7.Width  = 70
                    loc_oGrid.Column8.Width  = 66
                    loc_oGrid.Column9.Width  = 78
                    loc_oGrid.Column10.Width = 70
                    THIS.FormatarGridLista(loc_oGrid)
                    *-- Capturar selecao inicial (primeiro registro)
                    IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                        GO TOP IN cursor_4c_Dados
                        THIS.this_nCodigoSel    = cursor_4c_Dados.codigos
                        THIS.this_cCIdChavesSel = ALLTRIM(cursor_4c_Dados.cidchaves)
                    ENDIF
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarLista:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *===========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *===========================================================================
    * BtnConfirmarClick - Executa acao conforme modo atual:
    *   INCLUIR/ALTERAR: salva SigCdBal via BO.Salvar() e retorna para lista
    *   PROCURAR/TRATAMENTO: navega para Page3 com inventario selecionado
    *===========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_oPg2, loc_cCodigo, loc_lResultado
        loc_lResultado = .F.
        loc_oPg2       = THIS.pgf_4c_Paginas.Page2

        TRY
            IF THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    THIS.pgf_4c_Paginas.ActivePage = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                    loc_lResultado = .T.
                ELSE
                    THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Invent" + CHR(225) + "rio " + ;
                            IIF(THIS.this_cModoAtual = "INCLUIR", "inclu" + CHR(237) + "do", "alterado") + ;
                            " com sucesso!", "Sucesso")
                        THIS.pgf_4c_Paginas.ActivePage = 1
                        THIS.this_cModoAtual = "LISTA"
                        THIS.CarregarLista()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ELSE
                loc_cCodigo = ALLTRIM(TRANSFORM(loc_oPg2.txt_4c_Codigo.Value))
                IF EMPTY(loc_cCodigo)
                    MsgAviso("Informe o C" + CHR(243) + "digo do Invent" + CHR(225) + "rio!", ;
                        "Campo Obrigat" + CHR(243) + "rio")
                ELSE
                    THIS.this_nCodigoSel = VAL(loc_cCodigo)
                    THIS.pgf_4c_Paginas.ActivePage = 3
                    THIS.this_cModoAtual = "TRATAMENTO"
                    THIS.CarregarGradeTratamento()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Confirmar:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.BtnConfirmarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela filtros e retorna para Page1 (Lista)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.pgf_4c_Paginas.ActivePage = 1
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere campos Page2 para propriedades do BO
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            .this_cGrupos   = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
            .this_cContas   = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
            .this_dDataInis = loc_oPg2.txt_4c_DataInicial.Value
            .this_dDataFims = loc_oPg2.txt_4c_DataFinal.Value
            .this_cLocalis  = ALLTRIM(loc_oPg2.txt_4c_LocalInicial.Value)
            .this_cLocalfs  = ALLTRIM(loc_oPg2.txt_4c_LocalFinal.Value)
            .this_cIforis   = ALLTRIM(loc_oPg2.txt_4c_FornecInicial.Value)
            .this_cIforfs   = ALLTRIM(loc_oPg2.txt_4c_FornecFinal.Value)
            .this_cCgruis   = ALLTRIM(loc_oPg2.txt_4c_GrupoInicial.Value)
            .this_cCgrufs   = ALLTRIM(loc_oPg2.txt_4c_GrupoFinal.Value)
            .this_cCggruis  = ALLTRIM(loc_oPg2.txt_4c_GGrupoInicial.Value)
            .this_cCggrufs  = ALLTRIM(loc_oPg2.txt_4c_GGrupoFinal.Value)
            .this_nPrecois  = TRANSFORM(loc_oPg2.txt_4c_PrecoInicial.Value)
            .this_nPrecofs  = TRANSFORM(loc_oPg2.txt_4c_PrecoFinal.Value)
            .this_cEmps     = ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ENDWITH
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do BO para campos Page2
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        WITH THIS.this_oBusinessObject
            loc_oPg2.txt_4c_Codigo.Value         = TRANSFORM(.this_nCodigos)
            loc_oPg2.txt_4c_Grupo.Value          = ALLTRIM(.this_cGrupos)
            loc_oPg2.txt_4c_DGrupo.Value         = ""
            loc_oPg2.txt_4c_Conta.Value          = ALLTRIM(.this_cContas)
            loc_oPg2.txt_4c_DConta.Value         = ""
            loc_oPg2.txt_4c_DataInicial.Value    = .this_dDataInis
            loc_oPg2.txt_4c_DataFinal.Value      = .this_dDataFims
            loc_oPg2.txt_4c_LocalInicial.Value   = ALLTRIM(.this_cLocalis)
            loc_oPg2.txt_4c_LocalFinal.Value     = ALLTRIM(.this_cLocalfs)
            loc_oPg2.txt_4c_FornecInicial.Value  = ALLTRIM(.this_cIforis)
            loc_oPg2.txt_4c_FornecFinal.Value    = ALLTRIM(.this_cIforfs)
            loc_oPg2.txt_4c_GrupoInicial.Value   = ALLTRIM(.this_cCgruis)
            loc_oPg2.txt_4c_GrupoFinal.Value     = ALLTRIM(.this_cCgrufs)
            loc_oPg2.txt_4c_GGrupoInicial.Value  = ALLTRIM(.this_cCggruis)
            loc_oPg2.txt_4c_GGrupoFinal.Value    = ALLTRIM(.this_cCggrufs)
            loc_oPg2.txt_4c_PrecoInicial.Value   = .this_nPrecois
            loc_oPg2.txt_4c_PrecoFinal.Value     = .this_nPrecofs
        ENDWITH
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa todos os campos de entrada da Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Codigo.Value        = ""
        loc_oPg2.txt_4c_Grupo.Value         = ""
        loc_oPg2.txt_4c_DGrupo.Value        = ""
        loc_oPg2.txt_4c_Conta.Value         = ""
        loc_oPg2.txt_4c_DConta.Value        = ""
        loc_oPg2.txt_4c_DataInicial.Value   = {}
        loc_oPg2.txt_4c_DataFinal.Value     = {}
        loc_oPg2.txt_4c_LocalInicial.Value  = ""
        loc_oPg2.txt_4c_LocalFinal.Value    = ""
        loc_oPg2.txt_4c_FornecInicial.Value = ""
        loc_oPg2.txt_4c_FornecFinal.Value   = ""
        loc_oPg2.txt_4c_GrupoInicial.Value  = ""
        loc_oPg2.txt_4c_GrupoFinal.Value    = ""
        loc_oPg2.txt_4c_GGrupoInicial.Value = ""
        loc_oPg2.txt_4c_GGrupoFinal.Value   = ""
        loc_oPg2.txt_4c_PrecoInicial.Value  = 0
        loc_oPg2.txt_4c_PrecoFinal.Value    = 0
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Grupo.ReadOnly         = !par_lHabilitar
        loc_oPg2.txt_4c_Conta.ReadOnly         = !par_lHabilitar
        loc_oPg2.txt_4c_DataInicial.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_DataFinal.ReadOnly     = !par_lHabilitar
        loc_oPg2.txt_4c_LocalInicial.ReadOnly  = !par_lHabilitar
        loc_oPg2.txt_4c_LocalFinal.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_FornecInicial.ReadOnly = !par_lHabilitar
        loc_oPg2.txt_4c_FornecFinal.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_GrupoInicial.ReadOnly  = !par_lHabilitar
        loc_oPg2.txt_4c_GrupoFinal.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_GGrupoInicial.ReadOnly = !par_lHabilitar
        loc_oPg2.txt_4c_GGrupoFinal.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_PrecoInicial.ReadOnly  = !par_lHabilitar
        loc_oPg2.txt_4c_PrecoFinal.ReadOnly    = !par_lHabilitar
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Prepara Page2 para inclusao de novo inventario
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.pgf_4c_Paginas.ActivePage = 2
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao incluir:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.BtnIncluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega inventario selecionado na Page2 para alteracao
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF THIS.this_nCodigoSel <= 0 OR EMPTY(THIS.this_cCIdChavesSel)
                MsgAviso("Selecione um invent" + CHR(225) + "rio para alterar.", ;
                    "Sele" + CHR(231) + CHR(227) + "o Necess" + CHR(225) + "ria")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao alterar:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.BtnAlterarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Exibe inventario selecionado na Page2 (somente leitura)
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF THIS.this_nCodigoSel <= 0 OR EMPTY(THIS.this_cCIdChavesSel)
                MsgAviso("Selecione um invent" + CHR(225) + "rio para visualizar.", ;
                    "Sele" + CHR(231) + CHR(227) + "o Necess" + CHR(225) + "ria")
            ELSE
                IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.pgf_4c_Paginas.ActivePage = 2
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao visualizar:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.BtnVisualizarClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Exclui o inventario selecionado apos confirmacao
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResultado, loc_lConfirmou
        loc_lResultado = .F.

        TRY
            IF THIS.this_nCodigoSel <= 0 OR EMPTY(THIS.this_cCIdChavesSel)
                MsgAviso("Selecione um invent" + CHR(225) + "rio para excluir.", ;
                    "Sele" + CHR(231) + CHR(227) + "o Necess" + CHR(225) + "ria")
            ELSE
                loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o do" + ;
                    " invent" + CHR(225) + "rio " + ;
                    TRANSFORM(THIS.this_nCodigoSel) + "?", ;
                    "Confirmar Exclus" + CHR(227) + "o")

                IF loc_lConfirmou
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
                        IF THIS.this_oBusinessObject.Excluir()
                            THIS.this_nCodigoSel   = 0
                            THIS.this_cCIdChavesSel = ""
                            THIS.CarregarLista()
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.BtnExcluirClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * CarregarGradeTratamento - Carrega grade de itens do inventario selecionado
    *===========================================================================
    PROTECTED PROCEDURE CarregarGradeTratamento()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_oGrid, loc_oPg3
        LOCAL loc_nTotCOc, loc_nTotSOc
        loc_lResultado = .F.

        TRY
            IF THIS.this_nCodigoSel <= 0
                MsgAviso("Nenhum invent" + CHR(225) + "rio selecionado", ;
                    "Formint.CarregarGradeTratamento")
            ELSE
                loc_cSQL = "SELECT a.Produto, a.Datatrans AS Datas, a.Barras, a.Barra2s AS BarraNovos," + ;
                    " a.Apurado, a.Estoque, a.Falta AS Faltas, a.Ocorrencia," + ;
                    " a.Tipos, a.PesReals, a.CCustos, a.Obs, a.Obs2s," + ;
                    " a.Usuars, a.CIdChaves, a.Emps, a.Codigos" + ;
                    " FROM SigIvTrT a" + ;
                    " WHERE a.Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
                    " AND a.Codigos = " + TRANSFORM(THIS.this_nCodigoSel) + ;
                    " ORDER BY a.Barras"

                *-- Fechar cursor temporario de chamada anterior, se existir
                IF USED("cursor_4c_TratamentoTemp")
                    USE IN cursor_4c_TratamentoTemp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TratamentoTemp")

                IF loc_nResult < 0
                    MsgErro("Erro ao carregar itens:" + CHR(13) + ;
                        CapturarErroSQL(), "Formint.CarregarGradeTratamento")
                ELSE
                    loc_oPg3  = THIS.pgf_4c_Paginas.Page3
                    loc_oGrid = loc_oPg3.grd_4c_Dados

                    IF USED("cursor_4c_Tratamento")
                        *-- Grid ja vinculado: repopular sem fechar o RecordSource cursor
                        SELECT cursor_4c_Tratamento
                        ZAP
                        APPEND FROM DBF(DBF("cursor_4c_TratamentoTemp"))
                        USE IN cursor_4c_TratamentoTemp
                        SELECT cursor_4c_Tratamento
                        GO TOP
                        loc_oGrid.Refresh()
                    ELSE
                        *-- Primeira carga: copiar via SELECT para evitar SQLEXEC direto ao cursor do Grid
                        SELECT * FROM cursor_4c_TratamentoTemp INTO CURSOR cursor_4c_Tratamento READWRITE
                        USE IN cursor_4c_TratamentoTemp
                        SELECT cursor_4c_Tratamento
                        GO TOP
                        *-- Vincular cursor ao grid (somente na primeira carga)
                        loc_oGrid.ColumnCount = 10
                        loc_oGrid.RecordSource = "cursor_4c_Tratamento"
                        loc_oGrid.Column1.ControlSource  = "cursor_4c_Tratamento.Produto"
                        loc_oGrid.Column2.ControlSource  = "cursor_4c_Tratamento.Datas"
                        loc_oGrid.Column3.ControlSource  = "cursor_4c_Tratamento.Barras"
                        loc_oGrid.Column4.ControlSource  = "cursor_4c_Tratamento.BarraNovos"
                        loc_oGrid.Column5.ControlSource  = "cursor_4c_Tratamento.Apurado"
                        loc_oGrid.Column6.ControlSource  = "cursor_4c_Tratamento.Estoque"
                        loc_oGrid.Column7.ControlSource  = "cursor_4c_Tratamento.Faltas"
                        loc_oGrid.Column8.ControlSource  = "cursor_4c_Tratamento.Ocorrencia"
                        loc_oGrid.Column9.ControlSource  = "cursor_4c_Tratamento.Tipos"
                        loc_oGrid.Column10.ControlSource = "cursor_4c_Tratamento.PesReals"

                        *-- Headers DEVEM ser redefinidos apos RecordSource (VFP9 reseta para nome do campo)
                        loc_oGrid.Column1.Header1.Caption  = "Produto"
                        loc_oGrid.Column2.Header1.Caption  = "Data"
                        loc_oGrid.Column3.Header1.Caption  = "Barra"
                        loc_oGrid.Column4.Header1.Caption  = "Barra Novo"
                        loc_oGrid.Column5.Header1.Caption  = "Apurado"
                        loc_oGrid.Column6.Header1.Caption  = "Estoque"
                        loc_oGrid.Column7.Header1.Caption  = "Diferen" + CHR(231) + "a"
                        loc_oGrid.Column8.Header1.Caption  = "Ocorrencia"
                        loc_oGrid.Column9.Header1.Caption  = "T"
                        loc_oGrid.Column10.Header1.Caption = "Dif. Peso"
                    ENDIF

                    IF loc_nResult >= 0
                        *-- Ajuste dinamico da coluna Dif. Peso (trtporpeso)
                        LOCAL loc_nTrtPeso
                        loc_nTrtPeso = 0
                        IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                            loc_nTrtPeso = TratarNulo(cursor_4c_Dados.trtporpeso, "N")
                        ENDIF
                        IF loc_nTrtPeso = 1
                            loc_oGrid.Column10.Width = 70
                        ELSE
                            loc_oGrid.Column10.Width = 0
                        ENDIF

                        *-- Calcular totais iniciais de ocorrencias
                        loc_nTotCOc = 0
                        loc_nTotSOc = 0
                        IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
                            SELECT cursor_4c_Tratamento
                            GO TOP
                            SCAN
                                IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia))
                                    loc_nTotCOc = loc_nTotCOc + 1
                                ELSE
                                    loc_nTotSOc = loc_nTotSOc + 1
                                ENDIF
                            ENDSCAN
                        ENDIF

                        WITH loc_oPg3.cnt_4c__CCusto1.cnt_4c__Total
                            .txt_4c_TotCOc.Value = loc_nTotCOc
                            .txt_4c_TotSOc.Value = loc_nTotSOc
                            .Visible     = .T.
                        ENDWITH

                        *-- Exibir grid e painel de controles
                        loc_oPg3.cnt_4c__CCusto1.Visible = .T.
                        loc_oGrid.Visible = .T.
                        loc_oGrid.Refresh()
                        loc_oGrid.SetFocus()

                        *-- Resetar caption do botao Sair
                        loc_oPg3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "OK"
                        loc_oPg3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .F.

                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarGradeTratamento:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.CarregarGradeTratamento")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre paginas do PageFrame
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 3
                MsgErro("Pagina invalida: " + TRANSFORM(par_nPagina), ;
                    "Formint.AlternarPagina")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                DO CASE
                CASE par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AjustarBotoesPorModo()
                    THIS.CarregarLista()
                CASE par_nPagina = 2
                    THIS.this_cModoAtual = "DADOS"
                    THIS.AjustarBotoesPorModo()
                CASE par_nPagina = 3
                    THIS.this_cModoAtual = "TRATAMENTO"
                    THIS.AjustarBotoesPorModo()
                ENDCASE

                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em AlternarPagina:" + CHR(13) + ;
                loException.Message, "Formint.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * NAO tornar visiveis: containers flutuantes (iniciam ocultos e aparecem via click)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- Grid de tratamento: pular totalmente (Sparse=.F. em Column8
                *-- dispara When/Valid ao ativar filhos, causando modal em headless)
                IF loc_cNome = "GRD_4C_DADOS"
                    LOOP
                ENDIF

                *-- Containers flutuantes: NAO visibilizar o container, mas visibilizar filhos
                *-- (aparecem ao clicar botoes de acao do Tratamento)
                IF INLIST(loc_cNome, ;
                    "CNT_4C__CUSTO2", ;
                    "CNT_4C_TRATOCOR", ;
                    "CNT_4C_BAIXAAUTO", ;
                    "CNT_4C__INSERIR", ;
                    "CNT_4C__CCUSTO1", ;
                    "CNT_4C__PROCURAR")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
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
    * GrdDadosAfterRowColChange - Atualiza selecao ao navegar no grid
    *===========================================================================
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        TRY
            IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
                SELECT cursor_4c_Dados
                THIS.this_nCodigoSel    = cursor_4c_Dados.codigos
                THIS.this_cCIdChavesSel = ALLTRIM(cursor_4c_Dados.cidchaves)
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GrdDadosAfterRowColChange:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.GrdDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * FormatarGridLista - Aplica formatacao visual ao grid da lista
    *===========================================================================
    PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) = "O"
            par_oGrid.FontName = "Tahoma"
            par_oGrid.FontSize = 9
            par_oGrid.SetAll("DynamicBackColor", ;
                "IIF(MOD(RECNO('cursor_4c_Dados'),2)=0,RGB(240,245,255),RGB(255,255,255))", ;
                "Column")
        ENDIF
    ENDPROC

    *===========================================================================
    * BtnBalancoClick - Abre relatorio de balanco do inventario selecionado
    * Original: If GesInd=1 -> SigReInr (Nota Retorno); Else -> SigReIr1 (Relatorio)
    *===========================================================================
    PROCEDURE BtnBalancoClick()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_nGesInd, loc_cFormPath
        loc_lResultado = .F.
        loc_nGesInd    = 0

        TRY
            IF EMPTY(THIS.this_cCIdChavesSel)
                MsgAviso("Selecione um invent" + CHR(225) + "rio na lista.", ;
                    "Sele" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cSQL = "SELECT TOP 1 GesInd FROM SigCdPam" + ;
                           " WHERE emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    loc_nGesInd = TratarNulo(GesInd, "N")
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF

                IF loc_nGesInd = 1
                    loc_cFormPath = gc_4c_CaminhoForms + "relatorios\FormSigReInr.prg"
                ELSE
                    loc_cFormPath = gc_4c_CaminhoForms + "relatorios\FormSigReIr1.prg"
                ENDIF

                IF FILE(loc_cFormPath)
                    DO FORM (loc_cFormPath) WITH THIS.this_nCodigoSel
                ELSE
                    MsgAviso("Relat" + CHR(243) + "rio de Balan" + CHR(231) + CHR(231) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel.", ;
                        "Informa" + CHR(231) + CHR(227) + "o")
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Balan" + CHR(231) + CHR(231) + "o:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.BtnBalancoClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnBaixaAutoClick - Baixa automatica de inventario
    * Inventario deve estar encerrado e nao tratado
    *===========================================================================
    PROCEDURE BtnBaixaAutoClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCIdChavesSel)
                MsgAviso("Selecione um invent" + CHR(225) + "rio na lista.", ;
                    "Sele" + CHR(231) + CHR(227) + "o")
            ELSE
                IF !THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
                    MsgErro("Erro ao carregar dados do invent" + CHR(225) + "rio.", ;
                        "Formint.BtnBaixaAutoClick")
                ELSE
                    IF !THIS.this_oBusinessObject.this_lEncerras
                        MsgAviso("O invent" + CHR(225) + "rio deve estar ENCERRADO para Baixa Autom" + CHR(225) + "tica.", ;
                            "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
                    ELSE
                        IF THIS.this_oBusinessObject.this_lTratas
                        MsgAviso("O invent" + CHR(225) + "rio j" + CHR(225) + " foi TRATADO.", ;
                            "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
                    ELSE
                        THIS.pgf_4c_Paginas.ActivePage = 3
                        THIS.this_cModoAtual = "BAIXAAUTO"
                        THIS.CarregarGradeTratamento()
                        loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Baixa Autom" + CHR(225) + "tica:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.BtnBaixaAutoClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnTratamentoClick - Inicia tratamento manual do inventario
    * Inventario deve estar encerrado e nao tratado
    *===========================================================================
    PROCEDURE BtnTratamentoClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCIdChavesSel)
                MsgAviso("Selecione um invent" + CHR(225) + "rio na lista.", ;
                    "Sele" + CHR(231) + CHR(227) + "o")
            ELSE
                IF !THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
                    MsgErro("Erro ao carregar dados do invent" + CHR(225) + "rio.", ;
                        "Formint.BtnTratamentoClick")
                ELSE
                    IF !THIS.this_oBusinessObject.this_lEncerras
                        MsgAviso("O invent" + CHR(225) + "rio deve estar ENCERRADO para Tratamento.", ;
                            "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
                    ELSE
                        IF THIS.this_oBusinessObject.this_lTratas
                        MsgAviso("O invent" + CHR(225) + "rio j" + CHR(225) + " foi TRATADO.", ;
                            "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
                    ELSE
                        THIS.pgf_4c_Paginas.ActivePage = 3
                        THIS.this_cModoAtual = "TRATAMENTO"
                        THIS.CarregarGradeTratamento()
                        loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Tratamento:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.BtnTratamentoClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnFecharClick - Encerra (fecha) o inventario selecionado
    * Chama BO.AtualizarEncerramento(.T., DATETIME())
    *===========================================================================
    PROCEDURE BtnFecharClick()
        LOCAL loc_lResultado, loc_lConfirmar
        loc_lResultado = .F.
        loc_lConfirmar = .F.

        TRY
            IF EMPTY(THIS.this_cCIdChavesSel)
                MsgAviso("Selecione um invent" + CHR(225) + "rio na lista.", ;
                    "Sele" + CHR(231) + CHR(227) + "o")
            ELSE
                IF !THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCIdChavesSel)
                    MsgErro("Erro ao carregar dados do invent" + CHR(225) + "rio.", ;
                        "Formint.BtnFecharClick")
                ELSE
                    IF THIS.this_oBusinessObject.this_lEncerras
                        MsgAviso("O invent" + CHR(225) + "rio j" + CHR(225) + " est" + CHR(225) + " ENCERRADO.", ;
                            "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
                    ELSE
                        loc_lConfirmar = MsgConfirma( ;
                            "Confirma o ENCERRAMENTO do Invent" + CHR(225) + "rio " + ;
                            TRANSFORM(THIS.this_nCodigoSel) + "?" + CHR(13) + ;
                            "Esta opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser desfeita.", ;
                            "Confirmar Encerramento")
                        IF loc_lConfirmar
                            IF THIS.this_oBusinessObject.AtualizarEncerramento(.T., DATETIME())
                                MsgInfo("Invent" + CHR(225) + "rio encerrado com sucesso!", ;
                                    "Encerramento")
                                THIS.CarregarLista()
                                loc_lResultado = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.BtnFecharClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnProcurarClick - Navega para Page2 (filtros de busca)
    *===========================================================================
    PROCEDURE BtnProcurarClick()
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.this_cModoAtual = "DADOS"
    ENDPROC

    *===========================================================================
    * CmdProcessoClick - Ordena grid por numero do processo (codigos)
    *===========================================================================
    PROCEDURE CmdProcessoClick()
        LOCAL loc_oGrid
        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                INDEX ON codigos TAG _proc
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_oGrid.SetFocus()
                loc_oGrid.ActiveColumn = 1
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao ordenar por processo:" + CHR(13) + loException.Message, ;
                "Formint.CmdProcessoClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CmdPeriodoClick - Ordena grid por periodo (datainis)
    *===========================================================================
    PROCEDURE CmdPeriodoClick()
        LOCAL loc_oGrid
        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                INDEX ON DTOS(datainis) TAG _perio
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_oGrid.SetFocus()
                loc_oGrid.ActiveColumn = 2
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao ordenar por per" + CHR(237) + "odo:" + CHR(13) + loException.Message, ;
                "Formint.CmdPeriodoClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CmdEstoqueClick - Ordena grid por estoque (contas)
    *===========================================================================
    PROCEDURE CmdEstoqueClick()
        LOCAL loc_oGrid
        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                INDEX ON ALLTRIM(contas) TAG _esto
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_oGrid.SetFocus()
                loc_oGrid.ActiveColumn = 4
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao ordenar por estoque:" + CHR(13) + loException.Message, ;
                "Formint.CmdEstoqueClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CmdLocalClick - Ordena grid por local inicial (localis)
    *===========================================================================
    PROCEDURE CmdLocalClick()
        LOCAL loc_oGrid
        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                INDEX ON ALLTRIM(localis) TAG _loca
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_oGrid.SetFocus()
                loc_oGrid.ActiveColumn = 5
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao ordenar por local:" + CHR(13) + loException.Message, ;
                "Formint.CmdLocalClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CmdGrupoClick - Ordena grid por grupo (grupos)
    *===========================================================================
    PROCEDURE CmdGrupoClick()
        LOCAL loc_oGrid
        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                INDEX ON ALLTRIM(grupos) TAG _gru
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_oGrid.SetFocus()
                loc_oGrid.ActiveColumn = 7
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao ordenar por grupo:" + CHR(13) + loException.Message, ;
                "Formint.CmdGrupoClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CmdGGrupoClick - Ordena grid por grande grupo (cggruis)
    *===========================================================================
    PROCEDURE CmdGGrupoClick()
        LOCAL loc_oGrid
        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                INDEX ON ALLTRIM(cggruis) TAG _ggru
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_oGrid.SetFocus()
                loc_oGrid.ActiveColumn = 8
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao ordenar por grande grupo:" + CHR(13) + loException.Message, ;
                "Formint.CmdGGrupoClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * CmdUsuarioClick - Ordena grid por usuario (usuars)
    *===========================================================================
    PROCEDURE CmdUsuarioClick()
        LOCAL loc_oGrid
        TRY
            IF USED("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                INDEX ON ALLTRIM(usuars) TAG _usu
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
                loc_oGrid.SetFocus()
                loc_oGrid.ActiveColumn = 9
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao ordenar por usu" + CHR(225) + "rio:" + CHR(13) + loException.Message, ;
                "Formint.CmdUsuarioClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos ao fechar
    *===========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Tratamento")
            USE IN cursor_4c_Tratamento
        ENDIF
        IF USED("cursor_4c_TratamentoTemp")
            USE IN cursor_4c_TratamentoTemp
        ENDIF
        IF USED("cursor_4c_Ocorr")
            USE IN cursor_4c_Ocorr
        ENDIF
        IF USED("CrSigCdBal")
            USE IN CrSigCdBal
        ENDIF
        IF USED("CsTratamento")
            USE IN CsTratamento
        ENDIF

        DODEFAULT()
    ENDPROC

    *===========================================================================
    * GrdBalancoAfterRowColChange - Exibe painel de controles com dados do item
    *===========================================================================
    PROCEDURE GrdBalancoAfterRowColChange(par_nColIndex)
        LOCAL loc_oCnt
        TRY
            IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
                SELECT cursor_4c_Tratamento

                loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
                WITH loc_oCnt
                    .Visible             = .T.
                    .txt_4c_DPro.Value   = TratarNulo(cursor_4c_Tratamento.Produto,  "C")
                    .txt_4c_CCusto.Value = TratarNulo(cursor_4c_Tratamento.CCustos,  "C")
                    .txt_4c_Dif.Value    = TratarNulo(cursor_4c_Tratamento.Faltas,   "N")
                    .txt_4c_Usuars.Value = TratarNulo(cursor_4c_Tratamento.Usuars,   "C")
                    .txt_4c_PesReal.Value = TratarNulo(cursor_4c_Tratamento.PesReals, "N")
                    .edt_4c_ObsCnt1.Value = TratarNulo(cursor_4c_Tratamento.Obs, "C")
                    .Refresh()
                ENDWITH

                WITH THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
                    .Column8.ReadOnly       = .F.
                    .Column8.Text1.ReadOnly = .F.
                    .Refresh()
                ENDWITH
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GrdBalancoAfterRowColChange:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.GrdBalancoAfterRowColChange")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GrdColOcorWhen - Salva valor atual antes da edicao (Column8)
    *===========================================================================
    PROCEDURE GrdColOcorWhen()
        TRY
            IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
                THIS.this_cOldValue = ALLTRIM(TratarNulo(cursor_4c_Tratamento.Ocorrencia, "C"))
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GrdColOcorWhen:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.GrdColOcorWhen")
        ENDTRY
        RETURN .T.
    ENDPROC

    *===========================================================================
    * GrdColOcorValid - Valida e abre lookup de Ocorrencia (Column8)
    *===========================================================================
    PROCEDURE GrdColOcorValid()
        LOCAL loc_lResultado, loc_oGrid, loc_cOcor
        loc_lResultado = .T.

        TRY
            loc_oGrid = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
            loc_cOcor = ALLTRIM(loc_oGrid.Column8.Text1.Value)

            WITH THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1
                .cmd_4c_BarraNovo.Visible = .F.
            ENDWITH

            IF !EMPTY(loc_cOcor) AND loc_cOcor != THIS.this_cOldValue
                loc_lResultado = THIS.AbrirLookupOcorrencia("O", "<>", loc_cOcor, ;
                    THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1)
            ENDIF

            *-- Atualizar usuario no painel
            IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
                THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.txt_4c_Usuars.Value = ;
                    ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GrdColOcorValid:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.GrdColOcorValid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * GrdColOcorLostFocus - Atualiza contadores apos saida do campo (Column8)
    *===========================================================================
    PROCEDURE GrdColOcorLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_cNovo, loc_oTotal, loc_nCOc, loc_nSOc

        TRY
            IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
                loc_cNovo  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.Value)
                loc_oTotal = THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cnt_4c__Total
                loc_nCOc   = loc_oTotal.txt_4c_TotCOc.Value
                loc_nSOc   = loc_oTotal.txt_4c_TotSOc.Value

                IF !EMPTY(THIS.this_cOldValue) AND EMPTY(loc_cNovo)
                    loc_nCOc = loc_nCOc - 1
                    loc_nSOc = loc_nSOc + 1
                ELSE
                    IF EMPTY(THIS.this_cOldValue) AND !EMPTY(loc_cNovo)
                        loc_nCOc = loc_nCOc + 1
                        loc_nSOc = loc_nSOc - 1
                    ENDIF
                ENDIF

                loc_oTotal.txt_4c_TotCOc.Value = MAX(0, loc_nCOc)
                loc_oTotal.txt_4c_TotSOc.Value = MAX(0, loc_nSOc)
                loc_oTotal.Refresh()

                *-- Se RepeteObs marcado, copiar observacao anterior para proximo
                IF THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.chk_4c_RepeteObs.Value = 1
                    LOCAL loc_cObsAtual
                    loc_cObsAtual = ALLTRIM(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.edt_4c_ObsCnt1.Value)
                    IF !EMPTY(loc_cObsAtual)
                        THIS.this_cObsAnterior = loc_cObsAtual
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GrdColOcorLostFocus:" + CHR(13) + loException.Message, ;
                "Formint.GrdColOcorLostFocus")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GetDProLostFocus - Apos editar descricao, volta o foco ao grid
    *===========================================================================
    PROCEDURE GetDProLostFocus(par_nKeyCode, par_nShiftAltCtrl)
        IF !EMPTY(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.edt_4c_ObsCnt1.Value)
            THIS.this_cObsAnterior = ALLTRIM(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.edt_4c_ObsCnt1.Value)
        ENDIF
        THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
        THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
    ENDPROC

    *===========================================================================
    * BtnSobraClick - Exibe painel de insercao de item de sobra
    *===========================================================================
    PROCEDURE BtnSobraClick()
        LOCAL loc_oCnt
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir
            WITH loc_oCnt
                .Visible = .T.
                .cmd_4c_CntInsere.Enabled = .F.
                .txt_4c_IBarra.Value = ""
                .txt_4c_ICCusto.Value = ""
                .txt_4c_IOcor.Value = ""
                .edt_4c_IBObs.Value = ""
                .Refresh()
                .txt_4c_IBarra.SetFocus()
            ENDWITH
        CATCH TO loException
            MsgErro("Erro em BtnSobraClick:" + CHR(13) + loException.Message, ;
                "Formint.BtnSobraClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnProcurarCntClick - Exibe painel de busca por barra
    *===========================================================================
    PROCEDURE BtnProcurarCntClick()
        LOCAL loc_oPg3
        TRY
            loc_oPg3 = THIS.pgf_4c_Paginas.Page3
            WITH loc_oPg3
                .cnt_4c__CCusto1.Visible   = .F.
                .grd_4c_Dados.Visible      = .F.
                .cnt_4c__Procurar.Visible  = .T.
                .cnt_4c__Procurar.Refresh()
                .cnt_4c__Procurar.txt_4c_GetBusca.Value = ""
                .cnt_4c__Procurar.txt_4c_GetBusca.SetFocus()
            ENDWITH
        CATCH TO loException
            MsgErro("Erro em BtnProcurarCntClick:" + CHR(13) + loException.Message, ;
                "Formint.BtnProcurarCntClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBarraNovoCntClick - Exibe painel de novo barra
    *===========================================================================
    PROCEDURE BtnBarraNovoCntClick()
        LOCAL loc_oCnt
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2
            WITH loc_oCnt
                .Visible = .T.
                .txt_4c_GetBarNovo.Value = ""
                .txt_4c_BNCCusto.Value = ""
                .txt_4c_BNPesReal.Value = 0
                .txt_4c_GetJustif.Value = ""
                .edt_4c_BNObs.Value = ""
                .Refresh()
                .txt_4c_GetBarNovo.SetFocus()
            ENDWITH
        CATCH TO loException
            MsgErro("Erro em BtnBarraNovoCntClick:" + CHR(13) + loException.Message, ;
                "Formint.BtnBarraNovoCntClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelaCntClick - Confirma cancelamento e volta para Page1
    *===========================================================================
    PROCEDURE BtnCancelaCntClick()
        LOCAL loc_lConfirmar
        loc_lConfirmar = .F.

        TRY
            loc_lConfirmar = MsgConfirma("Deseja Cancelar?" + CHR(13) + ;
                "Altera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o salvas ser" + CHR(227) + "o perdidas.", ;
                "Cancelar Tratamento")

            IF loc_lConfirmar
                THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible  = .F.
                THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible      = .F.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnCancelaCntClick:" + CHR(13) + loException.Message, ;
                "Formint.BtnCancelaCntClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSairCntClick - Salva tratamento (se Caption="Grava") ou volta para Page1
    *===========================================================================
    PROCEDURE BtnSairCntClick()
        LOCAL loc_lResultado, loc_cCaption, loc_cSQL, loc_nResult, loc_lValido
        loc_lResultado = .F.
        loc_lValido    = .T.

        TRY
            loc_cCaption = ALLTRIM(THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption)

            IF loc_cCaption = "\<Grava" OR loc_cCaption = "Grava"
                *-- Validar: todo lancamento com Ocorrencia deve ter Obs
                IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
                    SELECT cursor_4c_Tratamento
                    GO TOP
                    SCAN
                        IF !EMPTY(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) AND ;
                           EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs)) AND ;
                           EMPTY(ALLTRIM(cursor_4c_Tratamento.Obs2s))
                            MsgAviso("Existem lan" + CHR(231) + "amentos com Ocorr" + CHR(234) + ;
                                "ncia sem Observa" + CHR(231) + CHR(227) + "o !!!", ;
                                "Valida" + CHR(231) + CHR(227) + "o")
                            THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
                            loc_lValido = .F.
                            EXIT
                        ENDIF
                    ENDSCAN

                    IF loc_lValido
                        *-- Gravar cada linha na tabela SigIvTrT
                        SELECT cursor_4c_Tratamento
                        GO TOP
                        SCAN
                            loc_cSQL = "UPDATE SigIvTrT SET" + ;
                                " Ocorrencia = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Ocorrencia)) + ;
                                ", Obs = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs)) + ;
                                ", Obs2s = " + EscaparSQL(ALLTRIM(cursor_4c_Tratamento.Obs2s)) + ;
                                ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                                " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
                                " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel) + ;
                                " AND Barras = " + TRANSFORM(cursor_4c_Tratamento.Barras)
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResult < 0
                                MsgErro("Erro ao gravar item:" + CHR(13) + ;
                                    CapturarErroSQL(), "Formint.BtnSairCntClick")
                                loc_lValido = .F.
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF loc_lValido
                    *-- Marcar inventario como tratado
                    loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
                        " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
                        " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
                    SQLEXEC(gnConnHandle, loc_cSQL)

                    MsgInfo("Tratamento gravado com sucesso!", "Tratamento")
                    loc_lResultado = .T.
                    ENDIF
                ENDIF
            ELSE
                loc_lResultado = .T.
            ENDIF

            IF loc_lResultado
                THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .F.
                THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible     = .F.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                THIS.CarregarLista()
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnSairCntClick:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.BtnSairCntClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * GetJustifValid - Lookup de Justificativa (SigBaOco Tipos='J')
    *===========================================================================
    PROCEDURE GetJustifValid()
        LOCAL loc_lResultado, loc_oTxt, loc_cValor, loc_lIgnorar
        loc_lResultado = .T.
        loc_lIgnorar   = .F.

        TRY
            loc_oTxt   = THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2.txt_4c_GetJustif
            loc_cValor = ALLTRIM(loc_oTxt.Value)

            IF loc_cValor == THIS.this_cUltimoGetJustifValid
                loc_lIgnorar = .T.
            ENDIF

            IF !loc_lIgnorar AND !EMPTY(loc_cValor)
                loc_lResultado = THIS.AbrirLookupOcorrencia("J", "", loc_cValor, loc_oTxt)
                IF loc_lResultado
                    THIS.this_cUltimoGetJustifValid = ALLTRIM(loc_oTxt.Value)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GetJustifValid:" + CHR(13) + loException.Message, ;
                "Formint.GetJustifValid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnBNCancelaClick - Cancela painel Novo Barra
    *===========================================================================
    PROCEDURE BtnBNCancelaClick()
        THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2.Visible = .F.
        THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
    ENDPROC

    *===========================================================================
    * BtnBNSairClick - Confirma novo barra e habilita botao Grava
    *===========================================================================
    PROCEDURE BtnBNSairClick()
        LOCAL loc_oCnt2, loc_cObs2s
        TRY
            loc_oCnt2 = THIS.pgf_4c_Paginas.Page3.cnt_4c__Custo2
            loc_cObs2s = ALLTRIM(loc_oCnt2.edt_4c_BNObs.Value)

            IF !EMPTY(loc_cObs2s) AND USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
                SELECT cursor_4c_Tratamento
                REPLACE cursor_4c_Tratamento.Obs2s WITH loc_cObs2s
                REPLACE cursor_4c_Tratamento.BarraNovos WITH ALLTRIM(loc_oCnt2.txt_4c_GetBarNovo.Value)
            ENDIF

            loc_oCnt2.Visible = .F.
            THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
            THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
            THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
            THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
        CATCH TO loException
            MsgErro("Erro em BtnBNSairClick:" + CHR(13) + loException.Message, ;
                "Formint.BtnBNSairClick")
        ENDTRY
    ENDPROC

    *===========================================================================
    * GetTOcorCntTratValid - Lookup de Ocorrencia no painel TratOcor (Tipos='O')
    *===========================================================================
    PROCEDURE GetTOcorCntTratValid()
        LOCAL loc_lResultado, loc_oTxt, loc_cValor, loc_lIgnorar
        loc_lResultado = .T.
        loc_lIgnorar   = .F.

        TRY
            loc_oTxt   = THIS.pgf_4c_Paginas.Page3.cnt_4c_TratOcor.txt_4c_TOcor
            loc_cValor = ALLTRIM(loc_oTxt.Value)

            IF loc_cValor == THIS.this_cUltimoGetTOcorCntTratValid
                loc_lIgnorar = .T.
            ENDIF

            IF !loc_lIgnorar AND !EMPTY(loc_cValor)
                loc_lResultado = THIS.AbrirLookupOcorrencia("O", "", loc_cValor, loc_oTxt)
                IF loc_lResultado
                    THIS.this_cUltimoGetTOcorCntTratValid = ALLTRIM(loc_oTxt.Value)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GetTOcorCntTratValid:" + CHR(13) + loException.Message, ;
                "Formint.GetTOcorCntTratValid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnTratOcorClick - Aplica ocorrencia a todos os registros do tipo selecionado
    *===========================================================================
    PROCEDURE BtnTratOcorClick()
        LOCAL loc_lResultado, loc_oCnt, loc_cOcor, loc_nSemOcor
        LOCAL loc_cTipos, loc_cOrdem, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_oCnt    = THIS.pgf_4c_Paginas.Page3.cnt_4c_TratOcor
            loc_cOcor   = ALLTRIM(loc_oCnt.txt_4c_TOcor.Value)
            loc_nSemOcor = loc_oCnt.opt_4c_SemOcor.Value
            loc_cTipos  = ALLTRIM(loc_oCnt.cmb_4c_Tipos.Value)

            IF EMPTY(loc_cOcor)
                MsgAviso("Informe a Ocorr" + CHR(234) + "ncia para o Tratamento.", ;
                    "Campo Obrigat" + CHR(243) + "rio")
            ELSE
                IF !USED("cursor_4c_Tratamento") OR RECCOUNT("cursor_4c_Tratamento") = 0
                    MsgAviso("Nenhum item para tratar.", "Tratamento")
                ELSE
                    SELECT cursor_4c_Tratamento
                    GO TOP
                    SCAN
                        LOCAL loc_lAplicar
                        loc_lAplicar = .F.

                        DO CASE
                        CASE loc_nSemOcor = 1   && Lidos
                            loc_lAplicar = (cursor_4c_Tratamento.Tipos = "L")
                        CASE loc_nSemOcor = 2   && Nao lidos
                            loc_lAplicar = (cursor_4c_Tratamento.Tipos = "N")
                        CASE loc_nSemOcor = 3   && Saldos
                            loc_lAplicar = (cursor_4c_Tratamento.Tipos = "S")
                        OTHERWISE
                            loc_lAplicar = .T.
                        ENDCASE

                        IF loc_cTipos = "Entrada"
                            loc_lAplicar = loc_lAplicar AND (cursor_4c_Tratamento.Faltas < 0)
                        ELSE
                            IF loc_cTipos = "Sa" + CHR(237) + "da"
                                loc_lAplicar = loc_lAplicar AND (cursor_4c_Tratamento.Faltas > 0)
                            ENDIF
                        ENDIF

                        IF loc_lAplicar
                            REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
                            REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)
                        ENDIF
                    ENDSCAN

                    loc_oCnt.Visible = .F.
                    THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_CancelaCnt.Visible = .T.
                    THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.cmd_4c_SairCnt.Caption    = "\<Grava"
                    THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BtnTratOcorClick:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.BtnTratOcorClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnTOCancelaClick - Cancela painel TratOcor e volta para Page1
    *===========================================================================
    PROCEDURE BtnTOCancelaClick()
        THIS.pgf_4c_Paginas.Page3.cnt_4c_TratOcor.Visible = .F.
        THIS.pgf_4c_Paginas.ActivePage = 1
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * GetTOcorBaixaAutoValid - Lookup Ocorrencia BaixaAuto (Tipos='O', Autos='S')
    *===========================================================================
    PROCEDURE GetTOcorBaixaAutoValid()
        LOCAL loc_lResultado, loc_oTxt, loc_cValor, loc_lIgnorar
        loc_lResultado = .T.
        loc_lIgnorar   = .F.

        TRY
            loc_oTxt   = THIS.pgf_4c_Paginas.Page3.cnt_4c_BaixaAuto.txt_4c_BATOcor
            loc_cValor = ALLTRIM(loc_oTxt.Value)

            IF loc_cValor == THIS.this_cUltimoGetTOcorBaixaAutoValid
                loc_lIgnorar = .T.
            ENDIF

            IF !loc_lIgnorar AND !EMPTY(loc_cValor)
                loc_lResultado = THIS.AbrirLookupOcorrenciaBaixaAuto(loc_cValor, loc_oTxt)
                IF loc_lResultado
                    THIS.this_cUltimoGetTOcorBaixaAutoValid = ALLTRIM(loc_oTxt.Value)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GetTOcorBaixaAutoValid:" + CHR(13) + loException.Message, ;
                "Formint.GetTOcorBaixaAutoValid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * OkBaixaAutoClick - Processa baixa automatica por ocorrencia
    *===========================================================================
    PROCEDURE OkBaixaAutoClick()
        LOCAL loc_lResultado, loc_oCnt, loc_cOcor, loc_dIni, loc_dFim
        LOCAL loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_oCnt  = THIS.pgf_4c_Paginas.Page3.cnt_4c_BaixaAuto
            loc_cOcor = ALLTRIM(loc_oCnt.txt_4c_BATOcor.Value)
            loc_dIni  = loc_oCnt.txt_4c_BAData.Value
            loc_dFim  = loc_oCnt.txt_4c_BADataF.Value

            IF EMPTY(loc_cOcor)
                MsgAviso("Informe a Ocorr" + CHR(234) + "ncia para Baixa Autom" + CHR(225) + "tica.", ;
                    "Campo Obrigat" + CHR(243) + "rio")
            ELSE
                LOCAL loc_lConfirmar
                loc_lConfirmar = MsgConfirma("Confirma a Baixa Autom" + CHR(225) + ;
                    "tica da Ocorr" + CHR(234) + "ncia [" + loc_cOcor + "]?" + CHR(13) + ;
                    "Esta opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ser desfeita.", ;
                    "Confirmar Baixa Autom" + CHR(225) + "tica")

                IF loc_lConfirmar
                    *-- Verificar operacao da ocorrencia na SigBaOco
                    loc_cSQL = "SELECT TOP 1 Operacaos FROM SigBaOco" + ;
                        " WHERE Tipos = 'O' AND Autos = 'S'" + ;
                        " AND Codigos = " + EscaparSQL(loc_cOcor)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")

                    IF USED("cursor_4c_Tratamento") AND RECCOUNT("cursor_4c_Tratamento") > 0
                        SELECT cursor_4c_Tratamento
                        GO TOP
                        SCAN
                            LOCAL loc_cCidChave, loc_cBarras
                            loc_cCidChave = ALLTRIM(cursor_4c_Tratamento.CIdChaves)
                            loc_cBarras   = ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras))

                            *-- Aplicar ocorrencia no cursor local
                            REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
                            REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)

                            *-- Gravar na tabela SigIvTrT
                            loc_cSQL = "UPDATE SigIvTrT SET" + ;
                                " Ocorrencia = " + EscaparSQL(loc_cOcor) + ;
                                ", Usuars = " + EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado)) + ;
                                " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
                                " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel) + ;
                                " AND Barras = " + TRANSFORM(cursor_4c_Tratamento.Barras)
                            SQLEXEC(gnConnHandle, loc_cSQL)
                        ENDSCAN

                        *-- Marcar inventario como tratado
                        loc_cSQL = "UPDATE SigCdBal SET Tratas = 1" + ;
                            " WHERE Emps = " + EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa)) + ;
                            " AND Codigos = " + TRANSFORM(THIS.this_nCodigoSel)
                        SQLEXEC(gnConnHandle, loc_cSQL)

                        IF USED("cursor_4c_Ocorr")
                            USE IN cursor_4c_Ocorr
                        ENDIF

                        MsgInfo("Baixa Autom" + CHR(225) + "tica aplicada com sucesso!", ;
                            "Baixa Autom" + CHR(225) + "tica")

                        loc_oCnt.Visible = .F.
                        THIS.pgf_4c_Paginas.ActivePage = 1
                        THIS.this_cModoAtual = "LISTA"
                        THIS.CarregarLista()
                        loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            IF USED("cursor_4c_Ocorr")
                USE IN cursor_4c_Ocorr
            ENDIF
            MsgErro("Erro em OkBaixaAutoClick:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.OkBaixaAutoClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnBACancelaClick - Cancela painel BaixaAuto e volta para Page1
    *===========================================================================
    PROCEDURE BtnBACancelaClick()
        THIS.pgf_4c_Paginas.Page3.cnt_4c_BaixaAuto.Visible = .F.
        THIS.pgf_4c_Paginas.ActivePage = 1
        THIS.this_cModoAtual = "LISTA"
        THIS.CarregarLista()
    ENDPROC

    *===========================================================================
    * GetIBarraValid - Valida codigo de barra no painel Inserir
    *===========================================================================
    PROCEDURE GetIBarraValid()
        LOCAL loc_lResultado, loc_oTxt, loc_cBarra, loc_cSQL, loc_nResult
        loc_lResultado = .T.

        TRY
            loc_oTxt  = THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.txt_4c_IBarra
            loc_cBarra = ALLTRIM(loc_oTxt.Value)

            IF !EMPTY(loc_cBarra)
                IF USED("cursor_4c_Ocorr")
                    USE IN cursor_4c_Ocorr
                ENDIF

                loc_cSQL = "SELECT TOP 1 CBars, CPros, Pesos FROM SigOpEtq" + ;
                    " WHERE CBars = " + EscaparSQL(loc_cBarra)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorr")

                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Ocorr") > 0
                    SELECT cursor_4c_Ocorr
                    THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.txt_4c_IBarra.Value = ;
                        ALLTRIM(cursor_4c_Ocorr.CBars)
                    THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.cmd_4c_CntInsere.Enabled = .T.
                ELSE
                    MsgAviso("C" + CHR(243) + "digo de Barra n" + CHR(227) + "o encontrado!", ;
                        "Barra Inv" + CHR(225) + "lida")
                    loc_lResultado = .F.
                ENDIF

                IF USED("cursor_4c_Ocorr")
                    USE IN cursor_4c_Ocorr
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GetIBarraValid:" + CHR(13) + loException.Message, ;
                "Formint.GetIBarraValid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * GetIOcorValid - Lookup de Ocorrencia no painel Inserir (Tipos='O')
    *===========================================================================
    PROCEDURE GetIOcorValid()
        LOCAL loc_lResultado, loc_oTxt, loc_cValor, loc_lIgnorar
        loc_lResultado = .T.
        loc_lIgnorar   = .F.

        TRY
            loc_oTxt   = THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.txt_4c_IOcor
            loc_cValor = ALLTRIM(loc_oTxt.Value)

            IF loc_cValor == THIS.this_cUltimoGetIOcorValid
                loc_lIgnorar = .T.
            ENDIF

            IF !loc_lIgnorar AND !EMPTY(loc_cValor)
                loc_lResultado = THIS.AbrirLookupOcorrencia("O", "", loc_cValor, loc_oTxt)
                IF loc_lResultado
                    THIS.this_cUltimoGetIOcorValid = ALLTRIM(loc_oTxt.Value)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GetIOcorValid:" + CHR(13) + loException.Message, ;
                "Formint.GetIOcorValid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * CntInsereClick - Insere novo item de sobra no cursor de tratamento
    *===========================================================================
    PROCEDURE CntInsereClick()
        LOCAL loc_lResultado, loc_oCnt, loc_cBarra, loc_cOcor, loc_cObs
        LOCAL loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_oCnt  = THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir
            loc_cBarra = ALLTRIM(loc_oCnt.txt_4c_IBarra.Value)
            loc_cOcor  = ALLTRIM(loc_oCnt.txt_4c_IOcor.Value)
            loc_cObs   = ALLTRIM(loc_oCnt.edt_4c_IBObs.Value)

            IF EMPTY(loc_cBarra)
                MsgAviso("Informe o C" + CHR(243) + "digo de Barra.", "Campo Obrigat" + CHR(243) + "rio")
            ELSE
                *-- Inserir no cursor local (ReadWrite permite APPEND BLANK)
                IF USED("cursor_4c_Tratamento")
                    SELECT cursor_4c_Tratamento
                    APPEND BLANK
                    REPLACE cursor_4c_Tratamento.Emps       WITH ALLTRIM(go_4c_Sistema.cCodEmpresa)
                    REPLACE cursor_4c_Tratamento.Codigos    WITH THIS.this_nCodigoSel
                    REPLACE cursor_4c_Tratamento.Barras     WITH VAL(loc_cBarra)
                    REPLACE cursor_4c_Tratamento.Ocorrencia WITH loc_cOcor
                    REPLACE cursor_4c_Tratamento.Obs        WITH loc_cObs
                    REPLACE cursor_4c_Tratamento.Tipos      WITH "L"
                    REPLACE cursor_4c_Tratamento.Apurado    WITH 1
                    REPLACE cursor_4c_Tratamento.Estoque    WITH 0
                    REPLACE cursor_4c_Tratamento.Usuars     WITH ALLTRIM(gc_4c_UsuarioLogado)

                    THIS.this_nCItens = THIS.this_nCItens + 1

                    *-- Limpar campos para proximo item
                    loc_oCnt.txt_4c_IBarra.Value = ""
                    loc_oCnt.txt_4c_IOcor.Value  = ""
                    loc_oCnt.edt_4c_IBObs.Value  = ""
                    loc_oCnt.cmd_4c_CntInsere.Enabled = .F.
                    loc_oCnt.txt_4c_IBarra.SetFocus()

                    THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CntInsereClick:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "Formint.CntInsereClick")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * CntSairInsClick - Fecha painel Inserir e volta ao grid
    *===========================================================================
    PROCEDURE CntSairInsClick()
        THIS.pgf_4c_Paginas.Page3.cnt_4c__Inserir.Visible = .F.
        THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
        THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Column8.Text1.SetFocus()
    ENDPROC

    *===========================================================================
    * GetBuscaValid - Busca item por barra no grid de tratamento
    *===========================================================================
    PROCEDURE GetBuscaValid(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lResultado, loc_cBarra, loc_oPr
        loc_lResultado = .T.

        TRY
            loc_oPr    = THIS.pgf_4c_Paginas.Page3.cnt_4c__Procurar
            loc_cBarra = ALLTRIM(loc_oPr.txt_4c_GetBusca.Value)

            IF !EMPTY(loc_cBarra) AND USED("cursor_4c_Tratamento")
                SELECT cursor_4c_Tratamento
                GO TOP
                LOCATE FOR ALLTRIM(TRANSFORM(cursor_4c_Tratamento.Barras)) = loc_cBarra
                IF FOUND()
                    *-- Mostrar grid e painel, ocultar procurar
                    loc_oPr.Visible = .F.
                    THIS.pgf_4c_Paginas.Page3.cnt_4c__CCusto1.Visible = .T.
                    THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Visible    = .T.
                    THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.Refresh()
                    THIS.pgf_4c_Paginas.Page3.grd_4c_Dados.SetFocus()
                ELSE
                    MsgAviso("Barra '" + loc_cBarra + "' n" + CHR(227) + "o encontrada.", ;
                        "Busca")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GetBuscaValid:" + CHR(13) + loException.Message, ;
                "Formint.GetBuscaValid")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AbrirLookupOcorrencia - Lookup padrao FormBuscaAuxiliar para SigBaOco
    * par_cTipos:  Tipos = 'O' ou 'J'
    * par_cAutos:  "" = sem filtro Autos; "<>" = Autos <> 'S'
    * par_cAtual:  valor atual do campo (prefixo de busca)
    * par_oTxt:    objeto TextBox para receber o valor selecionado
    *===========================================================================
    PROTECTED PROCEDURE AbrirLookupOcorrencia(par_cTipos, par_cAutos, par_cAtual, par_oTxt)
        LOCAL loc_lResultado, loc_oLookup, loc_cFiltro
        loc_lResultado = .T.

        TRY
            loc_cFiltro = "Tipos = '" + par_cTipos + "'"

            IF par_cAutos = "<>"
                loc_cFiltro = loc_cFiltro + " AND Autos <> 'S'"
            ENDIF

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SigBaOco",             ;   && Tabela
                "Codigos",              ;   && Campo chave
                par_cAtual,             ;   && Valor inicial
                "Ocorr" + CHR(234) + "ncias", ;   && Titulo
                .T.,                    ;   && Modal
                "",                     ;   && Ordenacao
                "",                     ;   && Campo descricao (OBSOLETO)
                gnConnHandle,           ;   && Handle conexao
                loc_cFiltro)            ;   && Filtro (sem WHERE)

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")

                IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
                    loc_lResultado = .F.
                ELSE
                    loc_oLookup.Show()

                    IF loc_oLookup.this_lSelecionou
                        par_oTxt.Value = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                        par_oTxt.Refresh()
                    ELSE
                        loc_lResultado = .F.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_BuscaOcorr")
                    USE IN cursor_4c_BuscaOcorr
                ENDIF
                loc_oLookup = .NULL.
            ELSE
                MsgErro("Erro ao criar FormBuscaAuxiliar.", "Formint.AbrirLookupOcorrencia")
                loc_lResultado = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em AbrirLookupOcorrencia:" + CHR(13) + loException.Message, ;
                "Formint.AbrirLookupOcorrencia")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AbrirLookupOcorrenciaBaixaAuto - Lookup SigBaOco (Tipos='O', Autos='S')
    *===========================================================================
    PROTECTED PROCEDURE AbrirLookupOcorrenciaBaixaAuto(par_cAtual, par_oTxt)
        LOCAL loc_lResultado, loc_oLookup
        loc_lResultado = .T.

        TRY
            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
                "SigBaOco",             ;
                "Codigos",              ;
                par_cAtual,             ;
                "Ocorr" + CHR(234) + "ncias Autom" + CHR(225) + "ticas", ;
                .T.,                    ;
                "",                     ;
                "",                     ;
                gnConnHandle,           ;
                "Tipos = 'O' AND Autos = 'S'")

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("Descrs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")

                IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
                    loc_lResultado = .F.
                ELSE
                    loc_oLookup.Show()

                    IF loc_oLookup.this_lSelecionou
                        par_oTxt.Value = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
                        par_oTxt.Refresh()
                    ELSE
                        loc_lResultado = .F.
                    ENDIF
                ENDIF

                loc_oLookup = .NULL.
            ELSE
                MsgErro("Erro ao criar FormBuscaAuxiliar.", "Formint.AbrirLookupOcorrenciaBaixaAuto")
                loc_lResultado = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em AbrirLookupOcorrenciaBaixaAuto:" + CHR(13) + loException.Message, ;
                "Formint.AbrirLookupOcorrenciaBaixaAuto")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Alias canonico para BtnConfirmarClick
    * O botao "Confirmar" da Page2 no legado desempenha a mesma funcao do
    * "Salvar" nos forms CRUD do novo padrao. Mantemos os dois nomes para
    * atender ao contrato do FormBase (BtnSalvarClick) e do SCX (Confirmar).
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        RETURN THIS.BtnConfirmarClick()
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Alias canonico para BtnProcurarClick
    * Ativa modo PROCURAR na Page2 para localizar inventario por codigo.
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        RETURN THIS.BtnProcurarClick()
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD por modo atual
    * Chamado em AlternarPagina/CarregarLista para refletir estado do form.
    * Modos: LISTA (todos habilitados), INCLUIR/ALTERAR (Confirmar habilitado,
    * Cancelar habilitado), VISUALIZAR (apenas Cancelar habilitado),
    * PROCURAR (Confirmar+Cancelar habilitados), TRATAMENTO (apenas Encerrar).
    *===========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg1, loc_oCntBot, loc_oCntSaida, loc_cModo
        loc_cModo = UPPER(ALLTRIM(THIS.this_cModoAtual))

        TRY
            loc_oPg1 = THIS.pgf_4c_Paginas.Page1

            *-- Container dos botoes CRUD principais (Incluir/Alterar/Visualizar/Excluir/Buscar)
            IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
                loc_oCntBot = loc_oPg1.cnt_4c_Botoes

                IF PEMSTATUS(loc_oCntBot, "cmd_4c_Incluir", 5)
                    loc_oCntBot.cmd_4c_Incluir.Enabled = (loc_cModo = "LISTA")
                ENDIF
                IF PEMSTATUS(loc_oCntBot, "cmd_4c_Alterar", 5)
                    loc_oCntBot.cmd_4c_Alterar.Enabled = ;
                        (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
                ENDIF
                IF PEMSTATUS(loc_oCntBot, "cmd_4c_Visualizar", 5)
                    loc_oCntBot.cmd_4c_Visualizar.Enabled = ;
                        (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
                ENDIF
                IF PEMSTATUS(loc_oCntBot, "cmd_4c_Excluir", 5)
                    loc_oCntBot.cmd_4c_Excluir.Enabled = ;
                        (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
                ENDIF
                IF PEMSTATUS(loc_oCntBot, "cmd_4c_Buscar", 5)
                    loc_oCntBot.cmd_4c_Buscar.Enabled = (loc_cModo = "LISTA")
                ENDIF
            ENDIF

            *-- Container de saida sempre habilitado (permite fechar em qualquer modo)
            IF PEMSTATUS(loc_oPg1, "cnt_4c_Saida", 5)
                loc_oCntSaida = loc_oPg1.cnt_4c_Saida
                IF PEMSTATUS(loc_oCntSaida, "cmd_4c_Encerrar", 5)
                    loc_oCntSaida.cmd_4c_Encerrar.Enabled = .T.
                ENDIF
            ENDIF

            *-- Botoes operacionais especificos da Page1 (Balanco/BaixaAuto/Tratamento/Fechar)
            IF PEMSTATUS(loc_oPg1, "cmd_4c_BtnBalanco", 5)
                loc_oPg1.cmd_4c_BtnBalanco.Enabled    = (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "cmd_4c_BtnBaixaAuto", 5)
                loc_oPg1.cmd_4c_BtnBaixaAuto.Enabled  = (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "cmd_4c_BtnTratamento", 5)
                loc_oPg1.cmd_4c_BtnTratamento.Enabled = (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
            ENDIF
            IF PEMSTATUS(loc_oPg1, "cmd_4c_BtnFechar", 5)
                loc_oPg1.cmd_4c_BtnFechar.Enabled     = (loc_cModo = "LISTA") AND (THIS.this_nCodigoSel > 0)
            ENDIF
        CATCH TO loException
            *-- Silenciar apenas erros de acesso a propriedades (form pode estar em construcao);
            *-- demais erros seguem para o log para nao mascarar defeitos.
            IF !("Property" $ loException.Message)
                MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + ;
                    loException.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loException.LineNo), ;
                    "Formint.AjustarBotoesPorModo")
            ENDIF
        ENDTRY
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\intBO.prg):
*==============================================================================
* intBO.prg - Business Object para Tratamento de Invent?rio (SIGCDBAL)
* Herda de: BusinessBase
* Tabela principal: SIGCDBAL
* PK: cidchaves (char 20)
*==============================================================================
DEFINE CLASS intBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SIGCDBAL
    *--------------------------------------------------------------------------
    this_cCIdChaves  = ""    && cidchaves char(20) - chave prim?ria
    this_nCodigos    = 0     && codigos numeric(4,0) - c?digo do invent?rio
    this_cEmps       = ""    && emps char(3) - empresa
    this_dDataInis   = {}    && datainis datetime - data inicial do invent?rio
    this_dDataFims   = {}    && datafims datetime - data final do invent?rio
    this_dDataTrans  = {}    && datatrans datetime - data da transa??o
    this_dDtBases    = {}    && dtbases datetime - data base
    this_cGrupos     = ""    && grupos char(10) - grupo principal
    this_cLocalis    = ""    && localis char(10) - local inicial
    this_cLocalfs    = ""    && localfs char(10) - local final
    this_cLocals     = ""    && locals char(10) - local
    this_cIforis     = ""    && iforis char(10) - fornecedor inicial
    this_cIforfs     = ""    && iforfs char(10) - fornecedor final
    this_cCgruis     = ""    && cgruis char(3) - c?digo grupo inicial
    this_cCgrufs     = ""    && cgrufs char(3) - c?digo grupo final
    this_cCggruis    = ""    && cggruis char(3) - c?digo grande grupo inicial
    this_cCggrufs    = ""    && cggrufs char(3) - c?digo grande grupo final
    this_nPrecois    = 0     && precois numeric(8,2) - pre?o inicial
    this_nPrecofs    = 0     && precofs numeric(8,2) - pre?o final
    this_cContas     = ""    && contas char(10) - conta
    this_cUsuars     = ""    && usuars char(10) - usu?rio
    this_cColecoesi  = ""    && colecoesi char(10) - cole??o inicial
    this_cColecoesf  = ""    && colecoesf char(10) - cole??o final
    this_cCprosi     = ""    && cprosi char(14) - produto inicial (barra)
    this_cCprosf     = ""    && cprosf char(14) - produto final (barra)
    this_cSgrusi     = ""    && sgrusi char(6) - sub-grupo inicial
    this_cSgrusf     = ""    && sgrusf char(6) - sub-grupo final
    this_cCfinpsi    = ""    && cfinpsi char(3) - fin press inicial
    this_cCfinpsf    = ""    && cfinpsf char(3) - fin press final
    this_nNTrans     = 0     && ntrans numeric(6,0) - n?mero da transa??o
    this_nAgrupas    = 0     && agrupas numeric(1,0) - agrupar
    this_nSepEstqs   = 0     && sepestqs numeric(1,0) - separar estoques
    this_nTrtPorPeso = 0     && trtporpeso numeric(1,0) - tratamento por peso
    this_nLeitGructa = 0     && leitgructa numeric(1,0) - leitura por grupo conta
    this_nFilBarras  = 0     && filbarras numeric(1,0) - filtrar por barras
    this_cMFilGGrp   = ""    && mfilggrp memo - filtro grande grupos
    this_cMFilGrupo  = ""    && mfilgrupo memo - filtro grupos
    this_cObs        = ""    && obs memo - observa??o

    *-- Campos calculados / controle
    this_lEncerras   = .F.   && encerras bit - invent?rio encerrado
    this_lTratas     = .F.   && tratas bit - invent?rio tratado

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDBAL"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCIdChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista inventarios da empresa atual
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmp
        loc_lSucesso = .F.
        loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                           " FROM SIGCDBAL" + ;
                           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
                           " ORDER BY codigos, cidchaves"
            ELSE
                loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                           " FROM SIGCDBAL" + ;
                           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
                           " AND codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
                           " ORDER BY codigos, cidchaves"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega inventario pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                       " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                       " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                       " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                       " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                       " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
                       " mfilggrp, mfilgrupo, obs" + ;
                       " FROM SIGCDBAL" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCidchaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorNumero - Carrega inventario pelo codigos + empresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorNumero(par_nCodigos, par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
                       " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
                       " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                       " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                       " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                       " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
                       " mfilggrp, mfilgrupo, obs" + ;
                       " FROM SIGCDBAL" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
                       " AND emps = " + EscaparSQL(par_cEmps)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
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
            THIS.this_cCIdChaves   = TratarNulo(cidchaves,    "C")
            THIS.this_nCodigos     = TratarNulo(codigos,      "N")
            THIS.this_cEmps        = TratarNulo(emps,         "C")
            THIS.this_cGrupos      = TratarNulo(grupos,       "C")
            THIS.this_cContas      = TratarNulo(contas,       "C")
            THIS.this_dDtBases     = TratarNulo(dtbases,      "D")
            THIS.this_dDataInis    = TratarNulo(datainis,     "D")
            THIS.this_dDataFims    = TratarNulo(datafims,     "D")
            THIS.this_dDataTrans   = TratarNulo(datatrans,    "D")
            THIS.this_lEncerras    = (TratarNulo(encerras,    "N") = 1)
            THIS.this_lTratas      = (TratarNulo(tratas,      "N") = 1)
            THIS.this_nAgrupas     = TratarNulo(agrupas,      "N")
            THIS.this_nSepEstqs    = TratarNulo(sepestqs,     "N")
            THIS.this_nTrtPorPeso  = TratarNulo(trtporpeso,   "N")
            THIS.this_nLeitGructa  = TratarNulo(leitgructa,   "N")
            THIS.this_nFilBarras   = TratarNulo(filbarras,    "N")
            THIS.this_cLocalis     = TratarNulo(localis,      "C")
            THIS.this_cLocalfs     = TratarNulo(localfs,      "C")
            THIS.this_cLocals      = TratarNulo(locals,       "C")
            THIS.this_cIforis      = TratarNulo(iforis,       "C")
            THIS.this_cIforfs      = TratarNulo(iforfs,       "C")
            THIS.this_cCgruis      = TratarNulo(cgruis,       "C")
            THIS.this_cCgrufs      = TratarNulo(cgrufs,       "C")
            THIS.this_cCggruis     = TratarNulo(cggruis,      "C")
            THIS.this_cCggrufs     = TratarNulo(cggrufs,      "C")
            THIS.this_cColecoesi   = TratarNulo(colecoesi,    "C")
            THIS.this_cColecoesf   = TratarNulo(colecoesf,    "C")
            THIS.this_cCprosi      = TratarNulo(cprosi,       "C")
            THIS.this_cCprosf      = TratarNulo(cprosf,       "C")
            THIS.this_cSgrusi      = TratarNulo(sgrusi,       "C")
            THIS.this_cSgrusf      = TratarNulo(sgrusf,       "C")
            THIS.this_cCfinpsi     = TratarNulo(cfinpsi,      "C")
            THIS.this_cCfinpsf     = TratarNulo(cfinpsf,      "C")
            THIS.this_nPrecois     = TratarNulo(precois,      "N")
            THIS.this_nPrecofs     = TratarNulo(precofs,      "N")
            THIS.this_nNTrans      = TratarNulo(ntrans,       "N")
            THIS.this_cUsuars      = TratarNulo(usuars,       "C")
            *-- Campos TEXT/memo (podem nao estar no cursor de listagem)
            IF !EMPTY(FIELD("mfilggrp", par_cAliasCursor))
                THIS.this_cMFilGGrp  = TratarNulo(mfilggrp,  "C")
                THIS.this_cMFilGrupo = TratarNulo(mfilgrupo, "C")
                THIS.this_cObs       = TratarNulo(obs,       "C")
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarProximoCodigo - Obtem proximo codigo disponivel para a empresa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarProximoCodigo(par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_nCodigo
        loc_nCodigo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox_cod" + ;
                       " FROM SIGCDBAL WHERE emps = " + EscaparSQL(par_cEmps)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nCodigo = cursor_4c_ProxCod.prox_cod
            ENDIF

            IF USED("cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ProxCod")
                USE IN cursor_4c_ProxCod
            ENDIF
        ENDTRY

        RETURN loc_nCodigo
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SIGCDBAL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigo, loc_cEmp
        loc_lSucesso = .F.
        loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

        TRY
            *-- Gerar chave UUID e proximo codigo sequencial
            THIS.this_cCIdChaves = ""
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCIdChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCIdChaves)
                MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_nCodigo = THIS.GerarProximoCodigo(loc_cEmp)
                IF loc_nCodigo = 0
                    MsgErro("Erro ao gerar c" + CHR(243) + "digo do invent" + CHR(225) + "rio.", "Erro")
                    loc_lSucesso = .F.
                ELSE
                    THIS.this_nCodigos = loc_nCodigo
                    THIS.this_cEmps    = loc_cEmp
                    THIS.this_cUsuars  = ALLTRIM(gc_4c_UsuarioLogado)

                    loc_cSQL = "INSERT INTO SIGCDBAL (" + ;
                               " cidchaves, codigos, emps, grupos, contas, dtbases," + ;
                               " datainis, datafims, encerras, tratas, agrupas, sepestqs," + ;
                               " trtporpeso, leitgructa, filbarras, localis, localfs," + ;
                               " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
                               " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
                               " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
                               ") VALUES (" + ;
                               EscaparSQL(THIS.this_cCIdChaves) + "," + ;
                               FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
                               EscaparSQL(THIS.this_cEmps) + "," + ;
                               EscaparSQL(THIS.this_cGrupos) + "," + ;
                               EscaparSQL(THIS.this_cContas) + "," + ;
                               FormatarDataSQL(THIS.this_dDtBases) + "," + ;
                               FormatarDataSQL(THIS.this_dDataInis) + "," + ;
                               FormatarDataSQL(THIS.this_dDataFims) + "," + ;
                               IIF(THIS.this_lEncerras, "1", "0") + "," + ;
                               IIF(THIS.this_lTratas, "1", "0") + "," + ;
                               FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
                               FormatarNumeroSQL(THIS.this_nSepEstqs) + "," + ;
                               FormatarNumeroSQL(THIS.this_nTrtPorPeso) + "," + ;
                               FormatarNumeroSQL(THIS.this_nLeitGructa) + "," + ;
                               FormatarNumeroSQL(THIS.this_nFilBarras) + "," + ;
                               EscaparSQL(THIS.this_cLocalis) + "," + ;
                               EscaparSQL(THIS.this_cLocalfs) + "," + ;
                               EscaparSQL(THIS.this_cIforis) + "," + ;
                               EscaparSQL(THIS.this_cIforfs) + "," + ;
                               EscaparSQL(THIS.this_cCgruis) + "," + ;
                               EscaparSQL(THIS.this_cCgrufs) + "," + ;
                               EscaparSQL(THIS.this_cCggruis) + "," + ;
                               EscaparSQL(THIS.this_cCggrufs) + "," + ;
                               EscaparSQL(THIS.this_cColecoesi) + "," + ;
                               EscaparSQL(THIS.this_cColecoesf) + "," + ;
                               EscaparSQL(THIS.this_cCprosi) + "," + ;
                               EscaparSQL(THIS.this_cCprosf) + "," + ;
                               EscaparSQL(THIS.this_cSgrusi) + "," + ;
                               EscaparSQL(THIS.this_cSgrusf) + "," + ;
                               EscaparSQL(THIS.this_cCfinpsi) + "," + ;
                               EscaparSQL(THIS.this_cCfinpsf) + "," + ;
                               FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
                               FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
                               FormatarNumeroSQL(THIS.this_nNTrans) + "," + ;
                               EscaparSQL(THIS.this_cLocals) + "," + ;
                               EscaparSQL(THIS.this_cUsuars) + ;
                               ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SIGCDBAL
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " dtbases = " + FormatarDataSQL(THIS.this_dDtBases) + "," + ;
                       " datainis = " + FormatarDataSQL(THIS.this_dDataInis) + "," + ;
                       " datafims = " + FormatarDataSQL(THIS.this_dDataFims) + "," + ;
                       " encerras = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
                       " tratas = " + IIF(THIS.this_lTratas, "1", "0") + "," + ;
                       " agrupas = " + FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
                       " sepestqs = " + FormatarNumeroSQL(THIS.this_nSepEstqs) + "," + ;
                       " trtporpeso = " + FormatarNumeroSQL(THIS.this_nTrtPorPeso) + "," + ;
                       " leitgructa = " + FormatarNumeroSQL(THIS.this_nLeitGructa) + "," + ;
                       " filbarras = " + FormatarNumeroSQL(THIS.this_nFilBarras) + "," + ;
                       " localis = " + EscaparSQL(THIS.this_cLocalis) + "," + ;
                       " localfs = " + EscaparSQL(THIS.this_cLocalfs) + "," + ;
                       " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                       " iforis = " + EscaparSQL(THIS.this_cIforis) + "," + ;
                       " iforfs = " + EscaparSQL(THIS.this_cIforfs) + "," + ;
                       " cgruis = " + EscaparSQL(THIS.this_cCgruis) + "," + ;
                       " cgrufs = " + EscaparSQL(THIS.this_cCgrufs) + "," + ;
                       " cggruis = " + EscaparSQL(THIS.this_cCggruis) + "," + ;
                       " cggrufs = " + EscaparSQL(THIS.this_cCggrufs) + "," + ;
                       " colecoesi = " + EscaparSQL(THIS.this_cColecoesi) + "," + ;
                       " colecoesf = " + EscaparSQL(THIS.this_cColecoesf) + "," + ;
                       " cprosi = " + EscaparSQL(THIS.this_cCprosi) + "," + ;
                       " cprosf = " + EscaparSQL(THIS.this_cCprosf) + "," + ;
                       " sgrusi = " + EscaparSQL(THIS.this_cSgrusi) + "," + ;
                       " sgrusf = " + EscaparSQL(THIS.this_cSgrusf) + "," + ;
                       " cfinpsi = " + EscaparSQL(THIS.this_cCfinpsi) + "," + ;
                       " cfinpsf = " + EscaparSQL(THIS.this_cCfinpsf) + "," + ;
                       " precois = " + FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
                       " precofs = " + FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
                       " usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE do inventario e registros filhos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigos, loc_cEmps
        loc_lSucesso = .F.
        loc_nCodigos = THIS.this_nCodigos
        loc_cEmps    = ALLTRIM(THIS.this_cEmps)

        TRY
            *-- Remover registros filhos: SigIvTrB (itens do balanco)
            loc_cSQL = "DELETE FROM SigIvTrB" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover registros filhos: SigIvTrH (historico de leitura)
            loc_cSQL = "DELETE FROM SigIvTrH" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover registros filhos: SigIvTrE (etiquetas)
            loc_cSQL = "DELETE FROM SigIvTrE" + ;
                       " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Remover o inventario principal
            loc_cSQL = "DELETE FROM SIGCDBAL" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEncerramento - Marca/desmarca inventario como encerrado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEncerramento(par_lEncerrar, par_dDatafim)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " encerras = " + IIF(par_lEncerrar, "1", "0") + "," + ;
                       " datafims = " + FormatarDataSQL(par_dDatafim) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.this_lEncerras = par_lEncerrar
                THIS.this_dDataFims = par_dDatafim
                THIS.RegistrarAuditoria("ENCERRAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTratamento - Marca inventario como tratado
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTratamento(par_lTratar)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDBAL SET" + ;
                       " tratas = " + IIF(par_lTratar, "1", "0") + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCIdChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.this_lTratas = par_lTratar
                THIS.RegistrarAuditoria("TRATAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao marcar tratamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao marcar tratamento:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Obtem cotacao de cambio para uma moeda
    * Substitui fCarregarCambio() do legado (nao portada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCambio(par_nValor, par_cMoeda)
        LOCAL loc_cSQL, loc_nResultado, loc_nCotacao, loc_nValorConv
        loc_nCotacao  = 1
        loc_nValorConv = par_nValor

        TRY
            IF !EMPTY(ALLTRIM(par_cMoeda)) AND ALLTRIM(par_cMoeda) <> "RS" AND ALLTRIM(par_cMoeda) <> "BRL"
                loc_cSQL = "SELECT a.CMoes, a.Valos FROM SigCdCot a ORDER BY a.Datas DESC"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cambio")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Cambio") > 0
                    SELECT cursor_4c_Cambio
                    LOCATE FOR ALLTRIM(CMoes) = ALLTRIM(par_cMoeda)
                    IF FOUND()
                        loc_nCotacao = TratarNulo(Valos, "N")
                        IF loc_nCotacao > 0
                            loc_nValorConv = par_nValor * loc_nCotacao
                        ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Cambio")
                    USE IN cursor_4c_Cambio
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar c" + CHR(226) + "mbio:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Cambio")
                USE IN cursor_4c_Cambio
            ENDIF
        ENDTRY

        RETURN loc_nValorConv
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Verifica se grupo de estoque eh valido
    *--------------------------------------------------------------------------
    PROCEDURE ValidarGrupo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lValido
        loc_lValido = .F.

        TRY
            IF !EMPTY(ALLTRIM(par_cGrupos))
                loc_cSQL = "SELECT TOP 1 Codigos FROM SigCdGcr" + ;
                           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cGrupos))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGru")
                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValGru") > 0
                    loc_lValido = .T.
                ENDIF

                IF USED("cursor_4c_ValGru")
                    USE IN cursor_4c_ValGru
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValGru")
                USE IN cursor_4c_ValGru
            ENDIF
        ENDTRY

        RETURN loc_lValido
    ENDPROC

ENDDEFINE

