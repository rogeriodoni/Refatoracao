# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 5/10
- Mensagem: TIMEOUT: VFP9 travou durante teste automatico (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-08 09:07:03] [INFO] Config FPW: (nao fornecido)
[2026-08-08 09:07:03] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 09:07:03] [INFO] Timeout: 300 segundos
[2026-08-08 09:07:03] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bp1iu22c.prg
[2026-08-08 09:07:03] [INFO] Conteudo do wrapper:
[2026-08-08 09:07:03] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
QUIT

[2026-08-08 09:07:03] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bp1iu22c.prg
[2026-08-08 09:07:03] [INFO] VFP output esperado em: C:\4c\tasks\task442\vfp_output.txt
[2026-08-08 09:07:03] [INFO] Executando Visual FoxPro 9...
[2026-08-08 09:07:03] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bp1iu22c.prg
[2026-08-08 09:07:03] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bp1iu22c.prg
[2026-08-08 09:07:03] [INFO] Timeout configurado: 300 segundos
[2026-08-08 09:12:03] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 7228)...
[2026-08-08 09:12:05] [INFO] VFP9 finalizado em 302.0386244 segundos
[2026-08-08 09:12:05] [INFO] Exit Code: 4
[2026-08-08 09:12:05] [INFO] 
[2026-08-08 09:12:05] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 09:12:05] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_bp1iu22c.prg
[2026-08-08 09:12:05] [INFO] 
[2026-08-08 09:12:05] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 09:12:05] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 09:12:05] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 09:12:05] [INFO] * Parameters: 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
[2026-08-08 09:12:05] [INFO] 
[2026-08-08 09:12:05] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 09:12:05] [INFO] SET SAFETY OFF
[2026-08-08 09:12:05] [INFO] SET RESOURCE OFF
[2026-08-08 09:12:05] [INFO] SET TALK OFF
[2026-08-08 09:12:05] [INFO] SET NOTIFY OFF
[2026-08-08 09:12:05] [INFO] SYS(2335, 0)
[2026-08-08 09:12:05] [INFO] 
[2026-08-08 09:12:05] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
[2026-08-08 09:12:05] [INFO] QUIT
[2026-08-08 09:12:05] [INFO] 
[2026-08-08 09:12:05] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 09:12:05] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-08 09:40:02] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-08 09:40:02] [INFO] Config FPW: (nao fornecido)
[2026-08-08 09:40:02] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 09:40:02] [INFO] Timeout: 300 segundos
[2026-08-08 09:40:02] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uedmseod.prg
[2026-08-08 09:40:02] [INFO] Conteudo do wrapper:
[2026-08-08 09:40:02] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
QUIT

[2026-08-08 09:40:02] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uedmseod.prg
[2026-08-08 09:40:02] [INFO] VFP output esperado em: C:\4c\tasks\task442\vfp_output.txt
[2026-08-08 09:40:02] [INFO] Executando Visual FoxPro 9...
[2026-08-08 09:40:02] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uedmseod.prg
[2026-08-08 09:40:02] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uedmseod.prg
[2026-08-08 09:40:02] [INFO] Timeout configurado: 300 segundos
[2026-08-08 09:45:02] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 3840)...
[2026-08-08 09:45:04] [INFO] VFP9 finalizado em 302.041909 segundos
[2026-08-08 09:45:04] [INFO] Exit Code: 4
[2026-08-08 09:45:04] [INFO] 
[2026-08-08 09:45:04] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 09:45:04] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uedmseod.prg
[2026-08-08 09:45:04] [INFO] 
[2026-08-08 09:45:04] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 09:45:04] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 09:45:04] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 09:45:04] [INFO] * Parameters: 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
[2026-08-08 09:45:04] [INFO] 
[2026-08-08 09:45:04] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 09:45:04] [INFO] SET SAFETY OFF
[2026-08-08 09:45:04] [INFO] SET RESOURCE OFF
[2026-08-08 09:45:04] [INFO] SET TALK OFF
[2026-08-08 09:45:04] [INFO] SET NOTIFY OFF
[2026-08-08 09:45:04] [INFO] SYS(2335, 0)
[2026-08-08 09:45:04] [INFO] 
[2026-08-08 09:45:04] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
[2026-08-08 09:45:04] [INFO] QUIT
[2026-08-08 09:45:04] [INFO] 
[2026-08-08 09:45:04] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 09:45:04] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-08 09:52:13] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-08 09:52:13] [INFO] Config FPW: (nao fornecido)
[2026-08-08 09:52:13] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 09:52:13] [INFO] Timeout: 300 segundos
[2026-08-08 09:52:13] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yfqv5fqn.prg
[2026-08-08 09:52:13] [INFO] Conteudo do wrapper:
[2026-08-08 09:52:13] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
QUIT

[2026-08-08 09:52:13] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yfqv5fqn.prg
[2026-08-08 09:52:13] [INFO] VFP output esperado em: C:\4c\tasks\task442\vfp_output.txt
[2026-08-08 09:52:13] [INFO] Executando Visual FoxPro 9...
[2026-08-08 09:52:13] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yfqv5fqn.prg
[2026-08-08 09:52:13] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yfqv5fqn.prg
[2026-08-08 09:52:13] [INFO] Timeout configurado: 300 segundos
[2026-08-08 09:57:13] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 18248)...
[2026-08-08 09:57:15] [INFO] VFP9 finalizado em 302.0698132 segundos
[2026-08-08 09:57:15] [INFO] Exit Code: 4
[2026-08-08 09:57:15] [INFO] 
[2026-08-08 09:57:15] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 09:57:15] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_yfqv5fqn.prg
[2026-08-08 09:57:15] [INFO] 
[2026-08-08 09:57:15] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 09:57:15] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 09:57:15] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 09:57:15] [INFO] * Parameters: 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
[2026-08-08 09:57:15] [INFO] 
[2026-08-08 09:57:15] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 09:57:15] [INFO] SET SAFETY OFF
[2026-08-08 09:57:15] [INFO] SET RESOURCE OFF
[2026-08-08 09:57:15] [INFO] SET TALK OFF
[2026-08-08 09:57:15] [INFO] SET NOTIFY OFF
[2026-08-08 09:57:15] [INFO] SYS(2335, 0)
[2026-08-08 09:57:15] [INFO] 
[2026-08-08 09:57:15] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
[2026-08-08 09:57:15] [INFO] QUIT
[2026-08-08 09:57:15] [INFO] 
[2026-08-08 09:57:15] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 09:57:15] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-08 09:59:54] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-08 09:59:54] [INFO] Config FPW: (nao fornecido)
[2026-08-08 09:59:54] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 09:59:54] [INFO] Timeout: 300 segundos
[2026-08-08 09:59:54] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aymedyol.prg
[2026-08-08 09:59:54] [INFO] Conteudo do wrapper:
[2026-08-08 09:59:54] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
QUIT

[2026-08-08 09:59:54] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aymedyol.prg
[2026-08-08 09:59:54] [INFO] VFP output esperado em: C:\4c\tasks\task442\vfp_output.txt
[2026-08-08 09:59:54] [INFO] Executando Visual FoxPro 9...
[2026-08-08 09:59:54] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aymedyol.prg
[2026-08-08 09:59:54] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aymedyol.prg
[2026-08-08 09:59:54] [INFO] Timeout configurado: 300 segundos
[2026-08-08 10:04:54] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 17788)...
[2026-08-08 10:04:56] [INFO] VFP9 finalizado em 302.0545583 segundos
[2026-08-08 10:04:56] [INFO] Exit Code: 4
[2026-08-08 10:04:56] [INFO] 
[2026-08-08 10:04:56] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 10:04:56] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_aymedyol.prg
[2026-08-08 10:04:56] [INFO] 
[2026-08-08 10:04:56] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 10:04:56] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 10:04:56] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 10:04:56] [INFO] * Parameters: 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
[2026-08-08 10:04:56] [INFO] 
[2026-08-08 10:04:56] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 10:04:56] [INFO] SET SAFETY OFF
[2026-08-08 10:04:56] [INFO] SET RESOURCE OFF
[2026-08-08 10:04:56] [INFO] SET TALK OFF
[2026-08-08 10:04:56] [INFO] SET NOTIFY OFF
[2026-08-08 10:04:56] [INFO] SYS(2335, 0)
[2026-08-08 10:04:56] [INFO] 
[2026-08-08 10:04:56] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGr1', 'C:\4c\tasks\task442', 'OPERACIONAL'
[2026-08-08 10:04:56] [INFO] QUIT
[2026-08-08 10:04:56] [INFO] 
[2026-08-08 10:04:56] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 10:04:56] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormGr1.prg):
*==============================================================================
* FormGr1.prg - Form OPERACIONAL: Geracao de Grupos de Acesso
* Equivale a: SigCdGr1.SCX (SIGCDGR1)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - form utilitario de geração de grupos
*==============================================================================
DEFINE CLASS FormGr1 AS FormBase

    Width       = 1000
    Height      = 600
    Caption     = ""
    TitleBar    = 0
    ShowWindow  = 0
    ShowWindow = 1
    ControlBox  = .F.
    WindowType  = 1
    DataSession = 2
    BorderStyle = 2
    AutoCenter  = .T.

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Usuario selecionado (GetCodigo / GetDescri)
    this_cUsuarios = ""
    this_cNComps   = ""

    *-- Novo grupo a criar (GetGrupo)
    this_cGrupos   = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- WindowType=1 + ShowWindow=1 causa loop modal apos CREATEOBJECT().
        *-- Em modo teste sem READ EVENTS externo isso trava 300s (timeout).
        *-- WindowType=0 + ShowWindow=0 suprimem o loop; Visible=.F. evita exibicao.
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            THIS.Visible    = .F.
            THIS.WindowType = 0
            THIS.ShowWindow = 0
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura base do form
    * Chamado automaticamente por FormBase.Init() via DODEFAULT()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("Gr1BO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar Business Object Gr1BO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro")
            ELSE
                IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
                    THIS.Caption = "Gera" + CHR(231) + CHR(227) + "o de Grupos"
                    THIS.ConfigurarPageFrame()
                    THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                    THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                    THIS.TornarControlesVisiveis(THIS)
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de layout base
    * SIGCDGR1 original eh flat OPERACIONAL (sem PageFrame nativo).
    * Este metodo agrupa a montagem do layout base: cabecalho + botoes acao.
    * Fases seguintes adicionam grid, textboxes e handlers.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria header cinza com titulo e botoes de acao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        *-- Container de fundo cinza escuro (cntSombra do legado)
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top       = 18
            .Left      = 10
            .Width     = 769
            .Height    = 40
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .T.
            .Alignment = 0
            .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Grupos"
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .T.
            .Alignment = 0
            .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Grupos"
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
        ENDWITH

        *-- CommandGroup "Remove" (1 botao - remove acesso selecionado da lista)
        *-- Posicionado diretamente no form sobre o cabecalho (z-order superior)
        THIS.AddObject("cmg_4c_Remove", "CommandGroup")
        WITH THIS.cmg_4c_Remove
            .Top         = 0
            .Left        = 750
            .Width       = 85
            .Height      = 80
            .ButtonCount = 1
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 0

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .Caption    = "\<Remove"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH

        *-- CommandGroup principal: Salvar + Sair
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top         = 0
            .Left        = 840
            .Width       = 160
            .Height      = 80
            .ButtonCount = 2
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 1

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .Caption    = "\<Salvar"
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .Caption    = "<Esc>Sair"
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_32.jpg"
                .Cancel     = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Cria area de dados: labels, textboxes e grid
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oGrid

        *-- Cursor placeholder para o grid (estrutura identica ao BO.BuscarAcessosPorUsuario)
        IF USED("cursor_4c_Acessos")
            USE IN cursor_4c_Acessos
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_Acessos ;
            (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
        SET NULL OFF

        *-- Shape borda da area de dados (Shape1 do legado)
        THIS.AddObject("shp_4c_Area", "Shape")
        WITH THIS.shp_4c_Area
            .Top           = 83
            .Left          = 3
            .Width         = 960
            .Height        = 507
            .BackStyle     = 0
            .SpecialEffect = 0
        ENDWITH

        *-- Label "Usu CHR(225) rio :" (Label1 do legado)
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 91
            .Left      = 23
            .Width     = 62
            .Height    = 16
            .AutoSize  = .F.
            .Caption   = "Usu" + CHR(225) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox codigo do usuario (GetCodigo do legado)
        THIS.AddObject("txt_4c_Codigo", "TextBox")
        WITH THIS.txt_4c_Codigo
            .Top       = 89
            .Left      = 76
            .Width     = 80
            .Height    = 22
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox nome do usuario (GetDescri do legado)
        THIS.AddObject("txt_4c_Descri", "TextBox")
        WITH THIS.txt_4c_Descri
            .Top       = 89
            .Left      = 157
            .Width     = 248
            .Height    = 22
            .MaxLength = 30
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Grid de acessos (Grid1 do legado)
        THIS.AddObject("grd_4c_Dados", "Grid")
        loc_oGrid = THIS.grd_4c_Dados
        WITH loc_oGrid
            .Top                = 118
            .Left               = 9
            .Width              = 950
            .Height             = 472
            .ColumnCount        = 1
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ReadOnly           = .T.
            .ScrollBars         = 2
            .GridLineColor      = RGB(238, 238, 238)
            .FontName           = "Verdana"
            .FontSize           = 8
            .HighlightStyle     = 2
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .RowHeight          = 16

            WITH .Column1
                .Width         = 924
                .Movable       = .F.
                .Resizable     = .F.
                .ReadOnly      = .T.
                .ControlSource = "cursor_4c_Acessos.Descricaos"
            ENDWITH

            .RecordSource = "cursor_4c_Acessos"
        ENDWITH

        *-- ControlSource redefinido apos RecordSource para evitar auto-bind por ordem de campos
        loc_oGrid.Column1.ControlSource     = "cursor_4c_Acessos.Descricaos"

        *-- Header1: fora do WITH aninhado para evitar silently-ignored props
        loc_oGrid.Column1.Header1.Caption   = "Acessos"
        loc_oGrid.Column1.Header1.FontName  = "Tahoma"
        loc_oGrid.Column1.Header1.Alignment = 2
        loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)

        *-- Text1 (celula de dados): Courier New conforme legado
        loc_oGrid.Column1.Text1.FontName    = "Courier New"
        loc_oGrid.Column1.Text1.FontSize    = 8
        loc_oGrid.Column1.Text1.BorderStyle = 0
        loc_oGrid.Column1.Text1.ReadOnly    = .T.
        loc_oGrid.Column1.Text1.ForeColor   = RGB(0, 0, 0)
        loc_oGrid.Column1.Text1.BackColor   = RGB(255, 255, 255)

        *-- BINDEVENTs: campos de usuario (grupo eh vinculado em ConfigurarPaginaDados)
        BINDEVENT(THIS.txt_4c_Codigo, "GotFocus", THIS, "TxtCodigoGotFocus")
        BINDEVENT(THIS.txt_4c_Codigo, "KeyPress", THIS, "TxtCodigoKeyPress")
        BINDEVENT(THIS.txt_4c_Descri, "KeyPress", THIS, "TxtDescriKeyPress")

        *-- BINDEVENTs: botoes do cabecalho (criados em ConfigurarCabecalho)
        BINDEVENT(THIS.cmg_4c_Remove.Buttons(1), "Click", THIS, "CmgRemoveClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "CmgSalvarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "CmgSairClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria area de entrada do novo grupo a ser gerado
    * Form OPERACIONAL flat: separa area de dados de entrada (novo grupo)
    * da area de consulta/lista (usuario + grid de acessos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Label "Novo Grupo :" (Label2 do legado)
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 91
            .Left      = 484
            .Width     = 88
            .Height    = 16
            .AutoSize  = .F.
            .Caption   = "Novo Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- TextBox novo grupo (GetGrupo do legado)
        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .Top       = 89
            .Left      = 510
            .Width     = 102
            .Height    = 23
            .MaxLength = 10
            .Value     = ""
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Estado inicial: propriedade do form sincronizada com o TextBox
        THIS.this_cGrupos = ""

        *-- BINDEVENT: valida duplicidade em ENTER/TAB
        BINDEVENT(THIS.txt_4c_Grupo, "KeyPress", THIS, "TxtGrupoKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Stub: form flat nao tem PageFrame para alternar
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        RETURN par_nPagina
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessos - Recarrega o grid com acessos do usuario selecionado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarAcessos()
        LOCAL loc_oErro

        TRY
            *-- Limpa RecordSource para evitar uncommitted changes
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.RecordSource = ""
            ENDIF

            THIS.this_oBusinessObject.BuscarAcessosPorUsuario(THIS.this_cUsuarios)

            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.ColumnCount  = 1
                THIS.grd_4c_Dados.RecordSource = "cursor_4c_Acessos"
                THIS.grd_4c_Dados.Column1.ControlSource        = "cursor_4c_Acessos.Descricaos"
                THIS.grd_4c_Dados.Column1.Header1.Caption      = "Acessos"
                THIS.grd_4c_Dados.Column1.Header1.FontName     = "Tahoma"
                THIS.grd_4c_Dados.Column1.Header1.Alignment    = 2
                THIS.grd_4c_Dados.Column1.Header1.ForeColor    = RGB(90, 90, 90)
                THIS.grd_4c_Dados.Refresh()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarAcessos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaUsuarioPorCodigo - Picker FormBuscaAuxiliar buscando por Usuarios
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaUsuarioPorCodigo()
        LOCAL loc_oLookup, loc_cValor, loc_oErro

        TRY
            loc_cValor  = ALLTRIM(THIS.txt_4c_Codigo.Value)

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cValor, ;
                "Usu" + CHR(225) + "rios", .T., .T., "NOT cAtivos = 'N'")

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("Usuarios", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("NComps", "", "Nome")
                loc_oLookup.Show()

                IF USED("cursor_4c_BuscaUsu") AND !EOF("cursor_4c_BuscaUsu") AND ;
                   loc_oLookup.this_lSelecionou
                    SELECT cursor_4c_BuscaUsu
                    THIS.txt_4c_Codigo.Value    = ALLTRIM(Usuarios)
                    THIS.txt_4c_Descri.Value    = ALLTRIM(NComps)
                    THIS.txt_4c_Descri.ReadOnly = .T.
                    THIS.this_cUsuarios          = ALLTRIM(Usuarios)
                    THIS.this_cNComps            = ALLTRIM(NComps)
                    USE IN cursor_4c_BuscaUsu
                    THIS.CarregarAcessos()
                ELSE
                    IF USED("cursor_4c_BuscaUsu")
                        USE IN cursor_4c_BuscaUsu
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaUsuarioPorCodigo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaUsuarioPorNome - Picker FormBuscaAuxiliar buscando por NComps
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirBuscaUsuarioPorNome()
        LOCAL loc_oLookup, loc_cValor, loc_oErro

        TRY
            loc_cValor  = ALLTRIM(THIS.txt_4c_Descri.Value)

            loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaUsu", "NComps", loc_cValor, ;
                "Usu" + CHR(225) + "rios", .T., .T., "NOT cAtivos = 'N'")

            IF VARTYPE(loc_oLookup) = "O"
                loc_oLookup.mAddColuna("Usuarios", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                loc_oLookup.mAddColuna("NComps", "", "Nome")
                loc_oLookup.Show()

                IF USED("cursor_4c_BuscaUsu") AND !EOF("cursor_4c_BuscaUsu") AND ;
                   loc_oLookup.this_lSelecionou
                    SELECT cursor_4c_BuscaUsu
                    THIS.txt_4c_Codigo.Value    = ALLTRIM(Usuarios)
                    THIS.txt_4c_Descri.Value    = ALLTRIM(NComps)
                    THIS.txt_4c_Descri.ReadOnly = .T.
                    THIS.this_cUsuarios          = ALLTRIM(Usuarios)
                    THIS.this_cNComps            = ALLTRIM(NComps)
                    USE IN cursor_4c_BuscaUsu
                    THIS.CarregarAcessos()
                ELSE
                    IF USED("cursor_4c_BuscaUsu")
                        USE IN cursor_4c_BuscaUsu
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em AbrirBuscaUsuarioPorNome")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodigoKeyPress - ENTER/TAB/F4 no campo codigo do usuario
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodigoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        LOCAL loc_cCodigo, loc_cNome, loc_oErro

        TRY
            loc_cCodigo = ALLTRIM(THIS.txt_4c_Codigo.Value)

            IF EMPTY(loc_cCodigo)
                THIS.txt_4c_Descri.Value    = ""
                THIS.txt_4c_Descri.ReadOnly = .F.
                THIS.this_cUsuarios          = ""
                THIS.this_cNComps            = ""
            ELSE
                loc_cNome = THIS.this_oBusinessObject.BuscarUsuarioPorCodigo(loc_cCodigo)

                IF !EMPTY(loc_cNome)
                    THIS.txt_4c_Descri.Value    = loc_cNome
                    THIS.txt_4c_Descri.ReadOnly = .T.
                    THIS.this_cUsuarios          = loc_cCodigo
                    THIS.this_cNComps            = loc_cNome
                    THIS.CarregarAcessos()
                ELSE
                    THIS.AbrirBuscaUsuarioPorCodigo()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em TxtCodigoKeyPress")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDescriKeyPress - ENTER/TAB/F4 no campo nome do usuario
    *--------------------------------------------------------------------------
    PROCEDURE TxtDescriKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF

        LOCAL loc_cNome, loc_cCodigo, loc_oErro

        TRY
            loc_cNome = ALLTRIM(THIS.txt_4c_Descri.Value)

            IF EMPTY(loc_cNome)
                THIS.txt_4c_Codigo.Value    = ""
                THIS.txt_4c_Descri.ReadOnly = .F.
                THIS.this_cUsuarios          = ""
                THIS.this_cNComps            = ""
            ELSE
                loc_cCodigo = THIS.this_oBusinessObject.BuscarUsuarioPorNome(loc_cNome)

                IF !EMPTY(loc_cCodigo)
                    THIS.txt_4c_Codigo.Value    = loc_cCodigo
                    THIS.txt_4c_Descri.ReadOnly = .T.
                    THIS.this_cUsuarios          = loc_cCodigo
                    THIS.this_cNComps            = loc_cNome
                    THIS.CarregarAcessos()
                ELSE
                    THIS.AbrirBuscaUsuarioPorNome()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em TxtDescriKeyPress")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodigoGotFocus - Limpa buffer de teclado ao entrar no campo codigo
    * Equivale ao GetCodigo.GotFocus do legado (Clear Typeahead)
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodigoGotFocus()
        CLEAR TYPEAHEAD
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtGrupoKeyPress - ENTER/TAB no campo novo grupo (valida duplicidade)
    *--------------------------------------------------------------------------
    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9
            RETURN
        ENDIF

        LOCAL loc_cGrupo, loc_oErro

        TRY
            loc_cGrupo = ALLTRIM(THIS.txt_4c_Grupo.Value)

            IF !EMPTY(loc_cGrupo) AND ;
               THIS.this_oBusinessObject.ValidarGrupoExistente(loc_cGrupo)
                MsgAviso("Grupo j" + CHR(225) + " cadastrado!", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_Grupo.SetFocus()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em TxtGrupoKeyPress")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgRemoveClick - Remove acesso selecionado do cursor local
    *--------------------------------------------------------------------------
    PROCEDURE CmgRemoveClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_Acessos") OR ;
               EOF("cursor_4c_Acessos") OR BOF("cursor_4c_Acessos")
                MsgAviso("Nenhum acesso selecionado.", "Remover")
            ELSE
                IF THIS.this_oBusinessObject.RemoverAcessoLocal()
                    IF VARTYPE(THIS.grd_4c_Dados) = "O"
                        THIS.grd_4c_Dados.Refresh()
                        THIS.grd_4c_Dados.SetFocus()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CmgRemoveClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgSalvarClick - Valida e grava o novo grupo com os acessos exibidos
    *--------------------------------------------------------------------------
    PROCEDURE CmgSalvarClick()
        LOCAL loc_cUsuarios, loc_cGrupo, loc_oErro

        TRY
            loc_cUsuarios = ALLTRIM(THIS.txt_4c_Codigo.Value)
            loc_cGrupo    = ALLTRIM(THIS.txt_4c_Grupo.Value)

            IF EMPTY(loc_cUsuarios)
                MsgAviso("Usu" + CHR(225) + "rio inv" + CHR(225) + "lido.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_Codigo.SetFocus()
            ELSE
                IF EMPTY(loc_cGrupo)
                    MsgAviso("Grupo inv" + CHR(225) + "lido.", ;
                             "Valida" + CHR(231) + CHR(227) + "o")
                    THIS.txt_4c_Grupo.SetFocus()
                ELSE
                    IF THIS.this_oBusinessObject.SalvarGrupo(loc_cUsuarios, loc_cGrupo)
                        THIS.Release()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CmgSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmgSairClick - Fecha o formulario sem salvar
    *--------------------------------------------------------------------------
    PROCEDURE CmgSairClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Grava novo grupo com os acessos do usuario selecionado
    * Form OPERACIONAL "Gera" + CHR(231) + CHR(227) + "o de Grupos": incluir
    * significa gerar um novo registro em SigCdGrA (SalvarGrupo faz DELETE+INSERT
    * em transacao, garantindo idempotencia caso o grupo ja exista).
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cUsuarios, loc_cGrupo, loc_oErro

        TRY
            loc_cUsuarios = ALLTRIM(THIS.txt_4c_Codigo.Value)
            loc_cGrupo    = ALLTRIM(THIS.txt_4c_Grupo.Value)

            IF EMPTY(loc_cUsuarios)
                MsgAviso("Usu" + CHR(225) + "rio inv" + CHR(225) + "lido.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_Codigo.SetFocus()
            ELSE
                IF EMPTY(loc_cGrupo)
                    MsgAviso("Grupo inv" + CHR(225) + "lido.", ;
                             "Valida" + CHR(231) + CHR(227) + "o")
                    THIS.txt_4c_Grupo.SetFocus()
                ELSE
                    IF THIS.this_oBusinessObject.ValidarGrupoExistente(loc_cGrupo)
                        MsgAviso("Grupo j" + CHR(225) + " cadastrado! Use Alterar para " + ;
                                 "regravar o grupo existente.", ;
                                 "Valida" + CHR(231) + CHR(227) + "o")
                        THIS.txt_4c_Grupo.SetFocus()
                    ELSE
                        IF THIS.this_oBusinessObject.SalvarGrupo(loc_cUsuarios, loc_cGrupo)
                            MsgInfo("Grupo '" + loc_cGrupo + "' criado com sucesso.", ;
                                    "Inclus" + CHR(227) + "o")
                            THIS.Release()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Regrava grupo existente com os acessos ajustados no grid
    * Regrava o grupo apenas se ja existir. SalvarGrupo faz DELETE dos registros
    * antigos em SigCdGrA e INSERT dos atuais do cursor local, sob transacao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cUsuarios, loc_cGrupo, loc_lResp, loc_oErro

        TRY
            loc_cUsuarios = ALLTRIM(THIS.txt_4c_Codigo.Value)
            loc_cGrupo    = ALLTRIM(THIS.txt_4c_Grupo.Value)

            IF EMPTY(loc_cUsuarios)
                MsgAviso("Usu" + CHR(225) + "rio inv" + CHR(225) + "lido.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_Codigo.SetFocus()
            ELSE
                IF EMPTY(loc_cGrupo)
                    MsgAviso("Grupo inv" + CHR(225) + "lido.", ;
                             "Valida" + CHR(231) + CHR(227) + "o")
                    THIS.txt_4c_Grupo.SetFocus()
                ELSE
                    IF !THIS.this_oBusinessObject.ValidarGrupoExistente(loc_cGrupo)
                        MsgAviso("Grupo n" + CHR(227) + "o cadastrado. Use Incluir para " + ;
                                 "criar novo grupo.", ;
                                 "Valida" + CHR(231) + CHR(227) + "o")
                        THIS.txt_4c_Grupo.SetFocus()
                    ELSE
                        loc_lResp = MsgConfirma("Regravar acessos do grupo '" + loc_cGrupo + ;
                                                "' com os itens exibidos no grid?", ;
                                                "Confirma" + CHR(231) + CHR(227) + "o")

                        IF loc_lResp
                            IF THIS.this_oBusinessObject.SalvarGrupo(loc_cUsuarios, loc_cGrupo)
                                MsgInfo("Grupo '" + loc_cGrupo + "' regravado com sucesso.", ;
                                        "Altera" + CHR(231) + CHR(227) + "o")
                                THIS.Release()
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Recarrega os acessos do usuario selecionado no grid
    * Equivalente a "consultar" (F5): repopula cursor_4c_Acessos via SQL fresh
    * e da foco no grid para navegacao.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cUsuarios, loc_oErro

        TRY
            loc_cUsuarios = ALLTRIM(THIS.txt_4c_Codigo.Value)

            IF EMPTY(loc_cUsuarios)
                MsgAviso("Selecione um usu" + CHR(225) + "rio antes de visualizar " + ;
                         "os acessos.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                THIS.txt_4c_Codigo.SetFocus()
            ELSE
                THIS.this_cUsuarios = loc_cUsuarios
                THIS.CarregarAcessos()

                IF VARTYPE(THIS.grd_4c_Dados) = "O"
                    THIS.grd_4c_Dados.SetFocus()
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Remove acesso selecionado do cursor local (pre-save)
    * Nao afeta SigCdGrA ate o Salvar. Exige registro corrente no grid.
    * Equivale ao Commandgroup2.Click do legado (Delete + Count + SetFocus).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lResp, loc_oErro

        TRY
            IF !USED("cursor_4c_Acessos") OR ;
               EOF("cursor_4c_Acessos") OR BOF("cursor_4c_Acessos")
                MsgAviso("Nenhum acesso selecionado.", ;
                         "Exclus" + CHR(227) + "o")
            ELSE
                loc_lResp = MsgConfirma("Remover o acesso selecionado da lista?", ;
                                        "Confirma" + CHR(231) + CHR(227) + "o")

                IF loc_lResp
                    IF THIS.this_oBusinessObject.RemoverAcessoLocal()
                        IF VARTYPE(THIS.grd_4c_Dados) = "O"
                            THIS.grd_4c_Dados.Refresh()
                            THIS.grd_4c_Dados.SetFocus()
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia valores do form para o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.this_oBusinessObject.this_cUsuarios      = ALLTRIM(THIS.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cNComps        = ALLTRIM(THIS.txt_4c_Descri.Value)
        THIS.this_oBusinessObject.this_cGrupos        = ALLTRIM(THIS.txt_4c_Grupo.Value)
        THIS.this_oBusinessObject.this_cGrupoNComps   = ALLTRIM(THIS.txt_4c_Grupo.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Copia valores do Business Object para o form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        THIS.txt_4c_Codigo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cUsuarios)
        THIS.txt_4c_Descri.Value = ALLTRIM(THIS.this_oBusinessObject.this_cNComps)
        THIS.txt_4c_Grupo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
        THIS.this_cUsuarios      = ALLTRIM(THIS.this_oBusinessObject.this_cUsuarios)
        THIS.this_cNComps        = ALLTRIM(THIS.this_oBusinessObject.this_cNComps)
        THIS.this_cGrupos        = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta todos os campos e o grid para estado inicial
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        THIS.txt_4c_Codigo.Value    = ""
        THIS.txt_4c_Descri.Value    = ""
        THIS.txt_4c_Descri.ReadOnly = .F.
        THIS.txt_4c_Grupo.Value     = ""
        THIS.this_cUsuarios          = ""
        THIS.this_cNComps            = ""
        THIS.this_cGrupos            = ""

        *-- Limpa grid: desvincula RecordSource, recria cursor vazio
        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.RecordSource = ""
        ENDIF

        IF USED("cursor_4c_Acessos")
            USE IN cursor_4c_Acessos
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Acessos ;
            (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
        SET NULL OFF

        IF VARTYPE(THIS.grd_4c_Dados) = "O"
            THIS.grd_4c_Dados.ColumnCount  = 1
            THIS.grd_4c_Dados.RecordSource = "cursor_4c_Acessos"
            THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Acessos.Descricaos"
            THIS.grd_4c_Dados.Refresh()
        ENDIF

        THIS.txt_4c_Codigo.SetFocus()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega dados do usuario corrente (alias de CarregarAcessos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF !EMPTY(THIS.this_cUsuarios)
            THIS.CarregarAcessos()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Controla estado de edicao dos campos
    * OPERACIONAL: campos sempre habilitados (sem modo VISUALIZAR/ALTERAR)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF VARTYPE(THIS.txt_4c_Codigo) = "O"
            THIS.txt_4c_Codigo.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.txt_4c_Grupo) = "O"
            THIS.txt_4c_Grupo.Enabled  = loc_lHab
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Stub OPERACIONAL (sem modo CRUD alternado)
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (alias canonico de CmgSairClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida e grava o grupo (alias de CmgSalvarClick)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmgSalvarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela a operacao e fecha o form
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega acessos do usuario selecionado
    * OPERACIONAL: equivale a consultar/refresh do grid
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Acessos")
            USE IN cursor_4c_Acessos
        ENDIF
        IF USED("cursor_4c_Barra")
            USE IN cursor_4c_Barra
        ENDIF
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\Gr1BO.prg):
*==============================================================================
* Gr1BO.prg - Business Object: Geracao de Grupos de Acesso
* Tabela principal: SigCdGrA (grupos)
* Tabelas auxiliares: SigCdAcU (acessos por usuario), SigCdAcB (acessos do grupo)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS Gr1BO AS BusinessBase

    this_cTabela          = "SigCdGrA"
    this_cCampoChave      = "Grupos"

    *-- Dados do usuario selecionado (SigCdUsu)
    this_cUsuarios        = ""
    this_cNComps          = ""

    *-- Dados do novo grupo a criar (SigCdGrA)
    this_cGrupos          = ""
    this_cGrupoNComps     = ""

    *-- Cursores de trabalho
    this_cCursorAcessos   = "cursor_4c_Acessos"
    this_cCursorBarra     = "cursor_4c_Barra"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdGrA"
        THIS.this_cCampoChave = "Grupos"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos      = TratarNulo(Grupos, "C")
            THIS.this_cGrupoNComps = TratarNulo(nComps, "C")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios antes de gravar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cGrupos))
            MsgAviso("Informe o c" + CHR(243) + "digo do grupo.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cGrupoNComps))
            MsgAviso("Informe o nome do grupo.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "INSERT INTO SigCdGrA (Grupos, nComps) VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupoNComps)) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir grupo no banco de dados.", ;
                            "Erro de Inser" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            IF THIS.ValidarDados()
                loc_cSQL = "UPDATE SigCdGrA SET nComps = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupoNComps)) + ;
                           " WHERE Grupos = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cGrupos))

                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("U")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao atualizar grupo no banco de dados.", ;
                            "Erro de Atualiza" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove registro de SigCdGrA
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGrA WHERE Grupos = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("D")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir grupo.", ;
                        "Erro de Exclus" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarAcessosPorUsuario - Carrega cursor_4c_Acessos para o grid
    * Equivale ao Valid de GetCodigo/GetDescri no legado
    *--------------------------------------------------------------------------
    FUNCTION BuscarAcessosPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuarios
        LOCAL loc_cProgram, loc_cParam, loc_cDescricao

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorAcessos)
                USE IN (THIS.this_cCursorAcessos)
            ENDIF
            IF USED("cursor_4c_AcessosTemp")
                USE IN cursor_4c_AcessosTemp
            ENDIF
            IF USED("cursor_4c_PrgDesc")
                USE IN cursor_4c_PrgDesc
            ENDIF

            loc_cUsuarios = EscaparSQL(ALLTRIM(par_cUsuarios))

            *-- Acessos diretos do usuario + via grupos aos quais pertence
            loc_cSQL = "SELECT DISTINCT a.Programas, a.Parametros, " + ;
                       "CAST('' AS VARCHAR(150)) AS Descricaos " + ;
                       "FROM SigCdAcU a " + ;
                       "LEFT OUTER JOIN SigCdAcG b ON a.Grupos = b.Grupos " + ;
                       "WHERE NOT a.Programas = SPACE(10) AND " + ;
                       "(a.Usuarios = " + loc_cUsuarios + ;
                       " OR b.Usuarios = " + loc_cUsuarios + ") " + ;
                       "ORDER BY a.Programas, a.Parametros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcessosTemp") > 0

                SET NULL ON
                CREATE CURSOR cursor_4c_Acessos ;
                    (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
                SET NULL OFF

                SELECT cursor_4c_AcessosTemp
                SCAN
                    loc_cProgram   = ALLTRIM(cursor_4c_AcessosTemp.Programas)
                    loc_cParam     = ALLTRIM(cursor_4c_AcessosTemp.Parametros)
                    loc_cDescricao = loc_cProgram + " / " + loc_cParam

                    loc_cSQL = "SELECT descricaos FROM SigCdPrg " + ;
                               "WHERE programas = " + EscaparSQL(loc_cProgram) + ;
                               " AND Parametros = " + EscaparSQL(loc_cParam)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrgDesc") > 0
                        IF !EOF("cursor_4c_PrgDesc")
                            loc_cDescricao = ALLTRIM(cursor_4c_PrgDesc.descricaos)
                        ENDIF
                        IF USED("cursor_4c_PrgDesc")
                            USE IN cursor_4c_PrgDesc
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_Acessos
                    INSERT INTO cursor_4c_Acessos VALUES ;
                        (cursor_4c_AcessosTemp.Programas, ;
                         cursor_4c_AcessosTemp.Parametros, ;
                         loc_cDescricao)
                ENDSCAN

                IF USED("cursor_4c_AcessosTemp")
                    USE IN cursor_4c_AcessosTemp
                ENDIF

                SELECT cursor_4c_Acessos
                GO TOP

                *-- Carrega tambem barras para uso no SalvarGrupo
                THIS.CarregarBarrasDoUsuario(par_cUsuarios)

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarAcessosPorUsuario")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarBarrasDoUsuario - Carrega cursor_4c_Barra (dados para SigCdAcB)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarBarrasDoUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuarios

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorBarra)
                USE IN (THIS.this_cCursorBarra)
            ENDIF

            loc_cUsuarios = EscaparSQL(ALLTRIM(par_cUsuarios))

            loc_cSQL = "SELECT a.grupos, a.usuarios, a.descricaos, a.barraforms, " + ;
                       "a.barraordem, a.programas, a.parametros, a.selbarras " + ;
                       "FROM SigCdAcB a " + ;
                       "LEFT JOIN SigCdPrg b " + ;
                       "ON b.programas + b.parametros = a.programas + a.parametros " + ;
                       "WHERE a.usuarios = " + loc_cUsuarios + ;
                       " UNION ALL " + ;
                       "SELECT a.grupos, a.usuarios, a.descricaos, a.barraforms, " + ;
                       "a.barraordem, a.programas, a.parametros, a.selbarras " + ;
                       "FROM SigCdAcB a " + ;
                       "LEFT JOIN SigCdPrg b " + ;
                       "ON b.programas + b.parametros = a.programas + a.parametros " + ;
                       "WHERE a.grupos IN " + ;
                       "(SELECT c.grupos FROM SigCdAcG c WHERE c.usuarios = " + loc_cUsuarios + ") " + ;
                       "ORDER BY 1, 2"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Barra") > 0
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarBarrasDoUsuario")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGrupoExistente - Verifica se codigo de grupo ja existe em SigCdGrA
    *--------------------------------------------------------------------------
    FUNCTION ValidarGrupoExistente(par_cGrupo)
        LOCAL loc_lExiste, loc_oErro, loc_cSQL

        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT Grupos FROM SigCdGrA " + ;
                       "WHERE Grupos = " + EscaparSQL(ALLTRIM(par_cGrupo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpCheck") > 0
                loc_lExiste = !EOF("cursor_4c_GrpCheck")
                IF USED("cursor_4c_GrpCheck")
                    USE IN cursor_4c_GrpCheck
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ValidarGrupoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * RemoverAcessoLocal - Remove registro corrente do cursor_4c_Acessos (local)
    *--------------------------------------------------------------------------
    FUNCTION RemoverAcessoLocal()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorAcessos) AND !EOF(THIS.this_cCursorAcessos)
                SELECT (THIS.this_cCursorAcessos)
                DELETE
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RemoverAcessoLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupo - Cria novo grupo copiando acessos do usuario
    * Orquestra INSERT em SigCdGrA, SigCdAcU e SigCdAcB via transacao
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupo(par_cUsuarios, par_cGrupo)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cGrupo, loc_cPkChave
        LOCAL loc_lTransacaoAberta, loc_lErroBanco

        loc_lSucesso        = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroBanco      = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cUsuarios))
                MsgAviso("Usu" + CHR(225) + "rio inv" + CHR(225) + "lido.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(ALLTRIM(par_cGrupo))
                MsgAviso("Grupo inv" + CHR(225) + "lido.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
            ELSE
                loc_cGrupo = EscaparSQL(ALLTRIM(par_cGrupo))

                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                loc_lTransacaoAberta = .T.

                *-- 1. Insere o novo grupo em SigCdGrA
                loc_cSQL = "INSERT INTO SigCdGrA (Grupos, nComps) VALUES (" + ;
                           loc_cGrupo + ", " + loc_cGrupo + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                    loc_lErroBanco = .T.
                ENDIF

                *-- 2. Para cada acesso nao-deletado em cursor_4c_Acessos,
                *--    insere em SigCdAcU associado ao novo grupo
                IF !loc_lErroBanco AND USED(THIS.this_cCursorAcessos)
                    SELECT (THIS.this_cCursorAcessos)
                    SCAN FOR !DELETED() AND !loc_lErroBanco
                        loc_cPkChave = EscaparSQL(SYS(2015) + SYS(2015))
                        loc_cSQL = "INSERT INTO SigCdAcU " + ;
                                   "(pkChaves, Programas, Parametros, Grupos, Usuarios) " + ;
                                   "VALUES (" + ;
                                   loc_cPkChave + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Acessos.Programas)) + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Acessos.Parametros)) + ", " + ;
                                   loc_cGrupo + ", '')"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            loc_lErroBanco = .T.
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- 3. Para cada barra em cursor_4c_Barra,
                *--    insere em SigCdAcB com grupo=NovoGrupo e usuario=vazio
                IF !loc_lErroBanco AND USED(THIS.this_cCursorBarra)
                    SELECT (THIS.this_cCursorBarra)
                    SCAN FOR !loc_lErroBanco
                        loc_cPkChave = EscaparSQL(SYS(2015) + SYS(2015))
                        loc_cSQL = "INSERT INTO SigCdAcB " + ;
                                   "(pkChaves, grupos, usuarios, descricaos, " + ;
                                   "barraforms, barraordem, programas, parametros, selbarras) " + ;
                                   "VALUES (" + ;
                                   loc_cPkChave + ", " + ;
                                   loc_cGrupo + ", " + ;
                                   "'', " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.descricaos, "")), 73)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.barraforms, "")), 50)) + ", " + ;
                                   FormatarNumeroSQL(NVL(cursor_4c_Barra.barraordem, 0), 0) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.programas, "")), 15)) + ", " + ;
                                   EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_Barra.parametros, "")), 10)) + ", " + ;
                                   FormatarNumeroSQL(IIF(NVL(cursor_4c_Barra.selbarras, .F.), 1, 0), 0) + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) <= 0
                            loc_lErroBanco = .T.
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_lErroBanco
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacaoAberta = .F.
                    MsgErro("Erro na grava" + CHR(231) + CHR(227) + "o dos dados. " + ;
                            "Favor tentar novamente.", "Erro de Grava" + CHR(231) + CHR(227) + "o")
                ELSE
                    SQLEXEC(gnConnHandle, "COMMIT")
                    loc_lTransacaoAberta = .F.
                    THIS.this_cGrupos      = ALLTRIM(par_cGrupo)
                    THIS.this_cGrupoNComps = ALLTRIM(par_cGrupo)
                    THIS.RegistrarAuditoria("I")
                    loc_lSucesso = .T.
                ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarGrupo")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarUsuarioPorCodigo - Retorna nome do usuario dado seu codigo
    *--------------------------------------------------------------------------
    FUNCTION BuscarUsuarioPorCodigo(par_cCodigo)
        LOCAL loc_cNome, loc_oErro, loc_cSQL

        loc_cNome = ""

        TRY
            loc_cSQL = "SELECT NComps FROM SigCdUsu " + ;
                       "WHERE Usuarios = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuBuscaCod") > 0
                IF !EOF("cursor_4c_UsuBuscaCod")
                    loc_cNome = ALLTRIM(cursor_4c_UsuBuscaCod.NComps)
                ENDIF
                IF USED("cursor_4c_UsuBuscaCod")
                    USE IN cursor_4c_UsuBuscaCod
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarUsuarioPorCodigo")
        ENDTRY

        RETURN loc_cNome
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarUsuarioPorNome - Retorna codigo do usuario dado seu nome
    *--------------------------------------------------------------------------
    FUNCTION BuscarUsuarioPorNome(par_cNome)
        RETURN ""
    ENDFUNC

ENDDEFINE

