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
[2026-08-09 15:57:56] [INFO] Config FPW: (nao fornecido)
[2026-08-09 15:57:56] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 15:57:56] [INFO] Timeout: 300 segundos
[2026-08-09 15:57:56] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zvcmt0po.prg
[2026-08-09 15:57:56] [INFO] Conteudo do wrapper:
[2026-08-09 15:57:56] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormIct', 'C:\4c\tasks\task450', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
QUIT

[2026-08-09 15:57:56] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zvcmt0po.prg
[2026-08-09 15:57:56] [INFO] VFP output esperado em: C:\4c\tasks\task450\vfp_output.txt
[2026-08-09 15:57:56] [INFO] Executando Visual FoxPro 9...
[2026-08-09 15:57:56] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zvcmt0po.prg
[2026-08-09 15:57:56] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zvcmt0po.prg
[2026-08-09 15:57:56] [INFO] Timeout configurado: 300 segundos
[2026-08-09 16:02:56] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 11416)...
[2026-08-09 16:02:58] [INFO] VFP9 finalizado em 302.0696208 segundos
[2026-08-09 16:02:58] [INFO] Exit Code: 4
[2026-08-09 16:02:58] [INFO] 
[2026-08-09 16:02:58] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 16:02:58] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zvcmt0po.prg
[2026-08-09 16:02:58] [INFO] 
[2026-08-09 16:02:58] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 16:02:58] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 16:02:58] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 16:02:58] [INFO] * Parameters: 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
[2026-08-09 16:02:58] [INFO] 
[2026-08-09 16:02:58] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 16:02:58] [INFO] SET SAFETY OFF
[2026-08-09 16:02:58] [INFO] SET RESOURCE OFF
[2026-08-09 16:02:58] [INFO] SET TALK OFF
[2026-08-09 16:02:58] [INFO] SET NOTIFY OFF
[2026-08-09 16:02:58] [INFO] SYS(2335, 0)
[2026-08-09 16:02:58] [INFO] 
[2026-08-09 16:02:58] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
[2026-08-09 16:02:58] [INFO] QUIT
[2026-08-09 16:02:58] [INFO] 
[2026-08-09 16:02:58] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 16:02:58] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 16:34:41] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 16:34:41] [INFO] Config FPW: (nao fornecido)
[2026-08-09 16:34:41] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 16:34:41] [INFO] Timeout: 300 segundos
[2026-08-09 16:34:41] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kvvldob.prg
[2026-08-09 16:34:42] [INFO] Conteudo do wrapper:
[2026-08-09 16:34:42] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormIct', 'C:\4c\tasks\task450', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
QUIT

[2026-08-09 16:34:42] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kvvldob.prg
[2026-08-09 16:34:42] [INFO] VFP output esperado em: C:\4c\tasks\task450\vfp_output.txt
[2026-08-09 16:34:42] [INFO] Executando Visual FoxPro 9...
[2026-08-09 16:34:42] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kvvldob.prg
[2026-08-09 16:34:42] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kvvldob.prg
[2026-08-09 16:34:42] [INFO] Timeout configurado: 300 segundos
[2026-08-09 16:39:42] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 19656)...
[2026-08-09 16:39:44] [INFO] VFP9 finalizado em 302.0698559 segundos
[2026-08-09 16:39:44] [INFO] Exit Code: 4
[2026-08-09 16:39:44] [INFO] 
[2026-08-09 16:39:44] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 16:39:44] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_0kvvldob.prg
[2026-08-09 16:39:44] [INFO] 
[2026-08-09 16:39:44] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 16:39:44] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 16:39:44] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 16:39:44] [INFO] * Parameters: 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
[2026-08-09 16:39:44] [INFO] 
[2026-08-09 16:39:44] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 16:39:44] [INFO] SET SAFETY OFF
[2026-08-09 16:39:44] [INFO] SET RESOURCE OFF
[2026-08-09 16:39:44] [INFO] SET TALK OFF
[2026-08-09 16:39:44] [INFO] SET NOTIFY OFF
[2026-08-09 16:39:44] [INFO] SYS(2335, 0)
[2026-08-09 16:39:44] [INFO] 
[2026-08-09 16:39:44] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
[2026-08-09 16:39:44] [INFO] QUIT
[2026-08-09 16:39:44] [INFO] 
[2026-08-09 16:39:44] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 16:39:44] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 16:58:58] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 16:58:58] [INFO] Config FPW: (nao fornecido)
[2026-08-09 16:58:58] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 16:58:58] [INFO] Timeout: 300 segundos
[2026-08-09 16:58:58] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q35eza14.prg
[2026-08-09 16:58:58] [INFO] Conteudo do wrapper:
[2026-08-09 16:58:58] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormIct', 'C:\4c\tasks\task450', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
QUIT

[2026-08-09 16:58:58] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q35eza14.prg
[2026-08-09 16:58:58] [INFO] VFP output esperado em: C:\4c\tasks\task450\vfp_output.txt
[2026-08-09 16:58:58] [INFO] Executando Visual FoxPro 9...
[2026-08-09 16:58:58] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q35eza14.prg
[2026-08-09 16:58:58] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q35eza14.prg
[2026-08-09 16:58:58] [INFO] Timeout configurado: 300 segundos
[2026-08-09 17:03:58] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 14748)...
[2026-08-09 17:04:00] [INFO] VFP9 finalizado em 302.0855441 segundos
[2026-08-09 17:04:00] [INFO] Exit Code: 4
[2026-08-09 17:04:00] [INFO] 
[2026-08-09 17:04:00] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 17:04:00] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q35eza14.prg
[2026-08-09 17:04:01] [INFO] 
[2026-08-09 17:04:01] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 17:04:01] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 17:04:01] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 17:04:01] [INFO] * Parameters: 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
[2026-08-09 17:04:01] [INFO] 
[2026-08-09 17:04:01] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 17:04:01] [INFO] SET SAFETY OFF
[2026-08-09 17:04:01] [INFO] SET RESOURCE OFF
[2026-08-09 17:04:01] [INFO] SET TALK OFF
[2026-08-09 17:04:01] [INFO] SET NOTIFY OFF
[2026-08-09 17:04:01] [INFO] SYS(2335, 0)
[2026-08-09 17:04:01] [INFO] 
[2026-08-09 17:04:01] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
[2026-08-09 17:04:01] [INFO] QUIT
[2026-08-09 17:04:01] [INFO] 
[2026-08-09 17:04:01] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 17:04:01] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 17:23:44] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 17:23:44] [INFO] Config FPW: (nao fornecido)
[2026-08-09 17:23:44] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 17:23:44] [INFO] Timeout: 300 segundos
[2026-08-09 17:23:44] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jibfpomb.prg
[2026-08-09 17:23:44] [INFO] Conteudo do wrapper:
[2026-08-09 17:23:44] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormIct', 'C:\4c\tasks\task450', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
QUIT

[2026-08-09 17:23:44] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jibfpomb.prg
[2026-08-09 17:23:44] [INFO] VFP output esperado em: C:\4c\tasks\task450\vfp_output.txt
[2026-08-09 17:23:44] [INFO] Executando Visual FoxPro 9...
[2026-08-09 17:23:44] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jibfpomb.prg
[2026-08-09 17:23:44] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jibfpomb.prg
[2026-08-09 17:23:44] [INFO] Timeout configurado: 300 segundos
[2026-08-09 17:28:44] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 12900)...
[2026-08-09 17:28:46] [INFO] VFP9 finalizado em 302.07015 segundos
[2026-08-09 17:28:46] [INFO] Exit Code: 4
[2026-08-09 17:28:46] [INFO] 
[2026-08-09 17:28:46] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 17:28:46] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_jibfpomb.prg
[2026-08-09 17:28:46] [INFO] 
[2026-08-09 17:28:46] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 17:28:46] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 17:28:46] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 17:28:46] [INFO] * Parameters: 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
[2026-08-09 17:28:46] [INFO] 
[2026-08-09 17:28:46] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 17:28:46] [INFO] SET SAFETY OFF
[2026-08-09 17:28:46] [INFO] SET RESOURCE OFF
[2026-08-09 17:28:46] [INFO] SET TALK OFF
[2026-08-09 17:28:46] [INFO] SET NOTIFY OFF
[2026-08-09 17:28:46] [INFO] SYS(2335, 0)
[2026-08-09 17:28:46] [INFO] 
[2026-08-09 17:28:46] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIct', 'C:\4c\tasks\task450', 'CRUD'
[2026-08-09 17:28:46] [INFO] QUIT
[2026-08-09 17:28:46] [INFO] 
[2026-08-09 17:28:46] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 17:28:46] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\cadastros\FormIct.prg):
*====================================================================
* FormIct.prg
*
* Formulario de Cadastro - Tipo de Tributacao do ICMS
* Tabela: SigPrTri
* Herda de: FormBase
* Legado: SIGCDICT.SCX (SigCdIct)
*====================================================================

DEFINE CLASS FormIct AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height       = 600
    Width        = 1000
    Caption      = "Tipo de Tributacao do ICMS"
    AutoCenter   = .T.
    ShowWindow   = 1
    WindowType   = 1
    DataSession  = 2
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    TitleBar     = 0
    ClipControls = .F.
    Themes       = .F.
    BorderStyle  = 2

    *-- Propriedades do form
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *====================================================================
    * Init - APENAS DODEFAULT (FormBase chama InicializarForm)
    *====================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *====================================================================
    * InicializarForm - Inicializa BO e monta estrutura visual
    *====================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.Caption = "Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS"

            THIS.this_oBusinessObject = CREATEOBJECT("IctBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar IctBO", "FormIct.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inicializar FormIct:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ConfigurarPageFrame - PageFrame principal com 2 paginas
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH
        THIS.pgf_4c_Paginas.Page1.Caption = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.pgf_4c_Paginas.Page2.Caption = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *====================================================================
    * ConfigurarPaginaLista - Page1: cabecalho, grid, botoes CRUD
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (cntSombra legado) Top=1+29=30
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 30
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS"
                .Top       = 15
                .Left      = 10
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
                .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS"
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

        *-- Grid principal (Grade legado) Top=88+29=117
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 13
        WITH loc_oPagina.grd_4c_Lista
            .Top                = 117
            .Left               = 11
            .Width              = 956
            .Height             = 498
            .FontName           = "Verdana"
            .FontSize           = 8
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .GridLines          = 3
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .RowHeight          = 16
            .ScrollBars         = 2
            .ReadOnly           = .T.
            .Visible            = .T.

            .Column1.Width            = 50
            .Column1.Header1.Caption  = "Tipo"
            .Column2.Width            = 90
            .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
            .Column3.Width            = 35
            .Column3.Header1.Caption  = "Mov"
            .Column4.Width            = 60
            .Column4.Header1.Caption  = "CFOP"
            .Column5.Width            = 160
            .Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o CFOP"
            .Column6.Width            = 35
            .Column6.Header1.Caption  = "Orig"
            .Column7.Width            = 100
            .Column7.Header1.Caption  = "Estado Origem"
            .Column8.Width            = 35
            .Column8.Header1.Caption  = "Dest"
            .Column9.Width            = 100
            .Column9.Header1.Caption  = "Estado Destino"
            .Column10.Width           = 65
            .Column10.Header1.Caption = "Al" + CHR(237) + "quota"
            .Column10.Alignment       = 1
            .Column11.Width           = 55
            .Column11.Header1.Caption = "Base Red."
            .Column11.Alignment       = 1
            .Column12.Width           = 60
            .Column12.Header1.Caption = "Al. Red."
            .Column12.Alignment       = 1
            .Column13.Width           = 65
            .Column13.Header1.Caption = "Al. Subst."
            .Column13.Alignment       = 1
        ENDWITH

        *-- Botao Copiar standalone (Command1 legado - abre copia como novo registro)
        *-- Top=4+29=33; Left=430 (imediatamente antes do bloco cnt_4c_Botoes)
        loc_oPagina.AddObject("cmd_4c_Copiar", "CommandButton")
        WITH loc_oPagina.cmd_4c_Copiar
            .Caption         = "Copiar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top             = 33
            .Left            = 430
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
            .Visible         = .T.
        ENDWITH

        *-- Container botoes CRUD (grupo_op legado) Top=-1+29=28; Left=512
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 414
            .Height      = 85
            .BackColor   = RGB(53, 53, 53)
            .BackStyle   = 1
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Container Saida canonico Left=917, Width=90
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cmd_4c_Copiar,                    "Click", THIS, "BtnCopiarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *====================================================================
    * ConfigurarPaginaDados - Page2: botoes Salvar/Cancelar e container dados
    *====================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oCnt
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salvar/Cancelar (grupo_salva legado) Top=-4+29=25
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 25
            .Left        = 837
            .Width       = 161
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
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
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 81
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
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Container principal dos dados (Container1 legado) Top=49+29=78
        loc_oPagina.AddObject("cnt_4c_Container1", "Container")
        WITH loc_oPagina.cnt_4c_Container1
            .Top           = 78
            .Left          = 119
            .Width         = 732
            .Height        = 420
            .BackStyle     = 0
            .BorderWidth   = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        loc_oCnt = loc_oPagina.cnt_4c_Container1

        *-- Labels (Say1-Say11)
        loc_oCnt.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oCnt.lbl_4c_Label1
            .Caption   = "Tipo :"
            .Top       = 84
            .Left      = 156
            .AutoSize  = .T.
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oCnt.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 110
            .Left      = 130
            .AutoSize  = .T.
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oCnt.lbl_4c_Label3
            .Caption   = "C.F.O.P. :"
            .Top       = 136
            .Left      = 133
            .AutoSize  = .T.
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oCnt.lbl_4c_Label4
            .Caption   = "Estado Origem :"
            .Top       = 162
            .Left      = 106
            .AutoSize  = .T.
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oCnt.lbl_4c_Label5
            .Caption   = "Estado Destino :"
            .Top       = 188
            .Left      = 104
            .AutoSize  = .T.
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label9", "Label")
        WITH loc_oCnt.lbl_4c_Label9
            .Caption   = "Tipo de Movimento :"
            .Top       = 213
            .Left      = 86
            .AutoSize  = .T.
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label10", "Label")
        WITH loc_oCnt.lbl_4c_Label10
            .Caption   = "[E]ntrada / [S]a" + CHR(237) + "da"
            .Top       = 215
            .Left      = 223
            .AutoSize  = .T.
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oCnt.lbl_4c_Label6
            .Caption   = "Al" + CHR(237) + "quota :"
            .Top       = 240
            .Left      = 137
            .AutoSize  = .T.
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oCnt.lbl_4c_Label7
            .Caption   = "Base Reduzida :"
            .Top       = 266
            .Left      = 106
            .AutoSize  = .T.
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label8", "Label")
        WITH loc_oCnt.lbl_4c_Label8
            .Caption   = "Al" + CHR(237) + "quota Reduzida :"
            .Top       = 292
            .Left      = 90
            .AutoSize  = .T.
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_Label11", "Label")
        WITH loc_oCnt.lbl_4c_Label11
            .Caption   = "Al" + CHR(237) + "quota Substitui" + CHR(231) + CHR(227) + "o :"
            .Top       = 318
            .Left      = 76
            .AutoSize  = .T.
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- TextBoxes
        loc_oCnt.AddObject("txt_4c_Tipo", "TextBox")
        WITH loc_oCnt.txt_4c_Tipo
            .Value     = ""
            .Top       = 81
            .Left      = 190
            .Width     = 40
            .Height    = 23
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .MaxLength = 4
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oCnt.txt_4c_Desc
            .Value     = ""
            .Top       = 107
            .Left      = 190
            .Width     = 184
            .Height    = 23
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .MaxLength = 20
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_CFOP", "TextBox")
        WITH loc_oCnt.txt_4c_CFOP
            .Value     = ""
            .Top       = 133
            .Left      = 190
            .Width     = 92
            .Height    = 23
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .MaxLength = 10
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DCFOP", "TextBox")
        WITH loc_oCnt.txt_4c_DCFOP
            .Value     = ""
            .Top       = 133
            .Left      = 287
            .Width     = 386
            .Height    = 23
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .MaxLength = 60
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Origem", "TextBox")
        WITH loc_oCnt.txt_4c_Origem
            .Value     = ""
            .Top       = 159
            .Left      = 190
            .Width     = 26
            .Height    = 23
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .MaxLength = 2
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DOrigem", "TextBox")
        WITH loc_oCnt.txt_4c_DOrigem
            .Value     = ""
            .Top       = 159
            .Left      = 219
            .Width     = 185
            .Height    = 23
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .MaxLength = 50
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Destino", "TextBox")
        WITH loc_oCnt.txt_4c_Destino
            .Value     = ""
            .Top       = 185
            .Left      = 190
            .Width     = 26
            .Height    = 23
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .MaxLength = 2
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_DDestino", "TextBox")
        WITH loc_oCnt.txt_4c_DDestino
            .Value     = ""
            .Top       = 185
            .Left      = 219
            .Width     = 185
            .Height    = 23
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .MaxLength = 50
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Movs", "TextBox")
        WITH loc_oCnt.txt_4c_Movs
            .Value     = ""
            .Top       = 211
            .Left      = 190
            .Width     = 26
            .Height    = 23
            .FontName  = "MS Sans Serif"
            .FontSize  = 8
            .MaxLength = 1
            .ReadOnly  = .T.
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Aliquota", "TextBox")
        WITH loc_oCnt.txt_4c_Aliquota
            .Value    = 0
            .Top      = 237
            .Left     = 190
            .Width    = 75
            .Height   = 23
            .FontName = "MS Sans Serif"
            .FontSize = 8
            .Format   = "N"
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Base", "TextBox")
        WITH loc_oCnt.txt_4c_Base
            .Value    = 0
            .Top      = 263
            .Left     = 190
            .Width    = 75
            .Height   = 23
            .FontName = "MS Sans Serif"
            .FontSize = 8
            .Format   = "N"
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Reduz", "TextBox")
        WITH loc_oCnt.txt_4c_Reduz
            .Value    = 0
            .Top      = 289
            .Left     = 190
            .Width    = 75
            .Height   = 23
            .FontName = "MS Sans Serif"
            .FontSize = 8
            .Format   = "N"
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Subst", "TextBox")
        WITH loc_oCnt.txt_4c_Subst
            .Value    = 0
            .Top      = 315
            .Left     = 190
            .Width    = 75
            .Height   = 23
            .FontName = "MS Sans Serif"
            .FontSize = 8
            .Format   = "N"
            .ReadOnly = .T.
            .Visible  = .T.
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Lookups: F4 e DblClick para campos com busca auxiliar
        BINDEVENT(loc_oCnt.txt_4c_CFOP,     "KeyPress", THIS, "CFOPKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_CFOP,     "DblClick",  THIS, "CFOPDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DCFOP,    "KeyPress", THIS, "DCFOPKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DCFOP,    "DblClick",  THIS, "DCFOPDblClick")
        BINDEVENT(loc_oCnt.txt_4c_Origem,   "KeyPress", THIS, "OrigemKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Origem,   "DblClick",  THIS, "OrigemDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DOrigem,  "KeyPress", THIS, "DOrigemKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DOrigem,  "DblClick",  THIS, "DOrigemDblClick")
        BINDEVENT(loc_oCnt.txt_4c_Destino,  "KeyPress", THIS, "DestinoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Destino,  "DblClick",  THIS, "DestinoDblClick")
        BINDEVENT(loc_oCnt.txt_4c_DDestino, "KeyPress", THIS, "DDestinoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_DDestino, "DblClick",  THIS, "DDestinoDblClick")
        BINDEVENT(loc_oCnt.txt_4c_Movs,     "KeyPress", THIS, "ValidarMovs")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *====================================================================
    * CarregarLista - Busca registros e vincula ao Grid
    *====================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 13
                    loc_oGrid.RecordSource = "cursor_4c_Dados"

                    loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.Tipos"
                    loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.Descs"
                    loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.Movs"
                    loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.CFOPs"
                    loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.CFOPd"
                    loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.Origems"
                    loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.Origemd"
                    loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.Destinos"
                    loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.Destinod"
                    loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.Aliquotas"
                    loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.Bases"
                    loc_oGrid.Column12.ControlSource = "cursor_4c_Dados.Reduzidas"
                    loc_oGrid.Column13.ControlSource = "cursor_4c_Dados.aliqicmsts"

                    *-- Reconfirmar headers e widths apos RecordSource (auto-bind reseta)
                    loc_oGrid.Column1.Width            = 50
                    loc_oGrid.Column1.Header1.Caption  = "Tipo"
                    loc_oGrid.Column2.Width            = 90
                    loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column3.Width            = 35
                    loc_oGrid.Column3.Header1.Caption  = "Mov"
                    loc_oGrid.Column4.Width            = 60
                    loc_oGrid.Column4.Header1.Caption  = "CFOP"
                    loc_oGrid.Column5.Width            = 160
                    loc_oGrid.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o CFOP"
                    loc_oGrid.Column6.Width            = 35
                    loc_oGrid.Column6.Header1.Caption  = "Orig"
                    loc_oGrid.Column7.Width            = 100
                    loc_oGrid.Column7.Header1.Caption  = "Estado Origem"
                    loc_oGrid.Column8.Width            = 35
                    loc_oGrid.Column8.Header1.Caption  = "Dest"
                    loc_oGrid.Column9.Width            = 100
                    loc_oGrid.Column9.Header1.Caption  = "Estado Destino"
                    loc_oGrid.Column10.Width           = 65
                    loc_oGrid.Column10.Header1.Caption = "Al" + CHR(237) + "quota"
                    loc_oGrid.Column10.Alignment       = 1
                    loc_oGrid.Column11.Width           = 55
                    loc_oGrid.Column11.Header1.Caption = "Base Red."
                    loc_oGrid.Column11.Alignment       = 1
                    loc_oGrid.Column12.Width           = 60
                    loc_oGrid.Column12.Header1.Caption = "Al. Red."
                    loc_oGrid.Column12.Alignment       = 1
                    loc_oGrid.Column13.Width           = 65
                    loc_oGrid.Column13.Header1.Caption = "Al. Subst."
                    loc_oGrid.Column13.Alignment       = 1

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                "FormIct.CarregarLista")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * AlternarPagina - Alterna entre Page1 (1) e Page2 (2)
    *====================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
                loException.Message, "FormIct.AlternarPagina")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BtnIncluirClick
    *====================================================================
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.this_oBusinessObject.NovoRegistro()
            THIS.LimparCampos()
            THIS.this_cModoAtual = "INCLUIR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        CATCH TO loException
            MostrarErro("Erro ao incluir:" + CHR(13) + loException.Message, ;
                "FormIct.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * BtnVisualizarClick
    *====================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidChaves
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar!")
            RETURN
        ENDIF
        TRY
            SELECT cursor_4c_Dados
            loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                THIS.this_cModoAtual = "VISUALIZAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.F.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, ;
                "FormIct.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * BtnAlterarClick
    *====================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidChaves
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar!")
            RETURN
        ENDIF
        TRY
            SELECT cursor_4c_Dados
            loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                THIS.this_oBusinessObject.EditarRegistro()
                THIS.this_cModoAtual = "ALTERAR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, ;
                "FormIct.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * BtnExcluirClick
    *====================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidChaves, loc_lConfirmado
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir!")
            RETURN
        ENDIF
        TRY
            SELECT cursor_4c_Dados
            loc_cCidChaves  = ALLTRIM(cursor_4c_Dados.cidchaves)
            loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
                "Excluir Tributa" + CHR(231) + CHR(227) + "o ICMS")
            IF loc_lConfirmado
                IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                    IF THIS.this_oBusinessObject.Excluir()
                        MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                "FormIct.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * BtnBuscarClick
    *====================================================================
    PROCEDURE BtnBuscarClick()
        TRY
            THIS.LimparCampos()
            THIS.this_cModoAtual = "BUSCAR"
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        CATCH TO loException
            MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
                "FormIct.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * BtnCopiarClick - Copia registro selecionado como novo (Command1 legado)
    *====================================================================
    PROCEDURE BtnCopiarClick()
        LOCAL loc_cCidChaves
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para copiar!")
            RETURN
        ENDIF
        TRY
            SELECT cursor_4c_Dados
            loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                THIS.this_oBusinessObject.NovoRegistro()
                THIS.this_cModoAtual = "INCLUIR"
                THIS.BOParaForm()
                THIS.HabilitarCampos(.T.)
                THIS.AjustarBotoesPorModo()
                THIS.AlternarPagina(2)
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao copiar:" + CHR(13) + loException.Message, ;
                "FormIct.BtnCopiarClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * BtnEncerrarClick
    *====================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *====================================================================
    * BtnSalvarClick
    *====================================================================
    PROCEDURE BtnSalvarClick()
        TRY
            IF THIS.this_cModoAtual = "BUSCAR"
                THIS.FormParaBO()
                THIS.ExecutarBusca()
            ELSE
                IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
                IF THIS.FormParaBO()
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Registro salvo com sucesso!")
                        THIS.AlternarPagina(1)
                    ENDIF
                ENDIF
            ELSE
                THIS.AlternarPagina(1)
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao confirmar:" + CHR(13) + loException.Message, ;
                "FormIct.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *====================================================================
    * BtnCancelarClick - Volta para Page1
    *====================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.AlternarPagina(1)
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, ;
                "FormIct.BtnCancelarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * FormParaBO - Transfere Form -> BO
    *====================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oCnt
        loc_lResultado = .F.
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
            WITH THIS.this_oBusinessObject
                .this_cTipos      = UPPER(ALLTRIM(loc_oCnt.txt_4c_Tipo.Value))
                .this_cDescs      = ALLTRIM(loc_oCnt.txt_4c_Desc.Value)
                .this_cCfops      = ALLTRIM(loc_oCnt.txt_4c_CFOP.Value)
                .this_cCfopd      = ALLTRIM(loc_oCnt.txt_4c_DCFOP.Value)
                .this_cOrigems    = UPPER(ALLTRIM(loc_oCnt.txt_4c_Origem.Value))
                .this_cOrigemd    = ALLTRIM(loc_oCnt.txt_4c_DOrigem.Value)
                .this_cDestinos   = UPPER(ALLTRIM(loc_oCnt.txt_4c_Destino.Value))
                .this_cDestinoD   = ALLTRIM(loc_oCnt.txt_4c_DDestino.Value)
                .this_cMovs       = UPPER(ALLTRIM(loc_oCnt.txt_4c_Movs.Value))
                .this_nAliquotas  = loc_oCnt.txt_4c_Aliquota.Value
                .this_nBases      = loc_oCnt.txt_4c_Base.Value
                .this_nReduzidas  = loc_oCnt.txt_4c_Reduz.Value
                .this_nAliqicmsts = loc_oCnt.txt_4c_Subst.Value
            ENDWITH
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao transferir dados:" + CHR(13) + loException.Message, ;
                "FormIct.FormParaBO")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * BOParaForm - Transfere BO -> Form
    *====================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oCnt
        loc_lResultado = .F.
        TRY
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
            WITH THIS.this_oBusinessObject
                loc_oCnt.txt_4c_Tipo.Value     = ALLTRIM(.this_cTipos)
                loc_oCnt.txt_4c_Desc.Value     = ALLTRIM(.this_cDescs)
                loc_oCnt.txt_4c_CFOP.Value     = ALLTRIM(.this_cCfops)
                loc_oCnt.txt_4c_DCFOP.Value    = ALLTRIM(.this_cCfopd)
                loc_oCnt.txt_4c_Origem.Value   = ALLTRIM(.this_cOrigems)
                loc_oCnt.txt_4c_DOrigem.Value  = ALLTRIM(.this_cOrigemd)
                loc_oCnt.txt_4c_Destino.Value  = ALLTRIM(.this_cDestinos)
                loc_oCnt.txt_4c_DDestino.Value = ALLTRIM(.this_cDestinoD)
                loc_oCnt.txt_4c_Movs.Value     = ALLTRIM(.this_cMovs)
                loc_oCnt.txt_4c_Aliquota.Value = .this_nAliquotas
                loc_oCnt.txt_4c_Base.Value     = .this_nBases
                loc_oCnt.txt_4c_Reduz.Value    = .this_nReduzidas
                loc_oCnt.txt_4c_Subst.Value    = .this_nAliqicmsts
            ENDWITH
            loc_lResultado = .T.
        CATCH TO loException
            MostrarErro("Erro ao popular campos:" + CHR(13) + loException.Message, ;
                "FormIct.BOParaForm")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExecutarBusca - Executa busca com filtro construido dos campos BO
    *====================================================================
    PROTECTED PROCEDURE ExecutarBusca()
        LOCAL loc_cFiltro, loc_cTipos, loc_cDescs, loc_cCfops, loc_cOrigems, loc_cDestinos
        loc_cFiltro   = ""
        loc_cTipos    = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
        loc_cDescs    = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
        loc_cCfops    = ALLTRIM(THIS.this_oBusinessObject.this_cCfops)
        loc_cOrigems  = ALLTRIM(THIS.this_oBusinessObject.this_cOrigems)
        loc_cDestinos = ALLTRIM(THIS.this_oBusinessObject.this_cDestinos)

        TRY
            IF !EMPTY(loc_cTipos)
                loc_cFiltro = loc_cFiltro + IIF(EMPTY(loc_cFiltro),"","AND ") + ;
                    "a.Tipos = " + EscaparSQL(loc_cTipos)
            ENDIF
            IF !EMPTY(loc_cDescs)
                loc_cFiltro = loc_cFiltro + IIF(EMPTY(loc_cFiltro),"","AND ") + ;
                    "a.Descs LIKE " + EscaparSQL("%" + loc_cDescs + "%")
            ENDIF
            IF !EMPTY(loc_cCfops)
                loc_cFiltro = loc_cFiltro + IIF(EMPTY(loc_cFiltro),"","AND ") + ;
                    "a.CFOPs = " + EscaparSQL(loc_cCfops)
            ENDIF
            IF !EMPTY(loc_cOrigems)
                loc_cFiltro = loc_cFiltro + IIF(EMPTY(loc_cFiltro),"","AND ") + ;
                    "a.Origems = " + EscaparSQL(loc_cOrigems)
            ENDIF
            IF !EMPTY(loc_cDestinos)
                loc_cFiltro = loc_cFiltro + IIF(EMPTY(loc_cFiltro),"","AND ") + ;
                    "a.Destinos = " + EscaparSQL(loc_cDestinos)
            ENDIF
            IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao executar busca:" + CHR(13) + loException.Message, ;
                "FormIct.ExecutarBusca")
        ENDTRY
    ENDPROC

    *====================================================================
    * HabilitarCampos - Controle ReadOnly por campo conforme modo
    * INCLUIR:     PK + desc + numericos editaveis
    * ALTERAR:     apenas numericos editaveis (PK e desc bloqueados)
    * BUSCAR:      PK + desc + numericos editaveis, exceto Movs (only INSERIR legado)
    * VISUALIZAR:  todos ReadOnly
    *====================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_oCnt, loc_lIncluir, loc_lAlterar, loc_lBuscar
        TRY
            loc_oPg2    = THIS.pgf_4c_Paginas.Page2
            loc_oCnt    = loc_oPg2.cnt_4c_Container1
            loc_lIncluir = par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR"
            loc_lAlterar = par_lHabilitar AND THIS.this_cModoAtual = "ALTERAR"
            loc_lBuscar  = par_lHabilitar AND THIS.this_cModoAtual = "BUSCAR"

            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar

            *-- Campos PK: editaveis em INCLUIR e BUSCAR (exceto Movs que e so INCLUIR)
            loc_oCnt.txt_4c_Tipo.ReadOnly    = !(loc_lIncluir OR loc_lBuscar)
            loc_oCnt.txt_4c_CFOP.ReadOnly    = !(loc_lIncluir OR loc_lBuscar)
            loc_oCnt.txt_4c_Origem.ReadOnly  = !(loc_lIncluir OR loc_lBuscar)
            loc_oCnt.txt_4c_Destino.ReadOnly = !(loc_lIncluir OR loc_lBuscar)
            loc_oCnt.txt_4c_Movs.ReadOnly    = !loc_lIncluir

            *-- Desc: legado When = INSERIR|PROCURAR (lock em ALTERAR)
            loc_oCnt.txt_4c_Desc.ReadOnly    = !(loc_lIncluir OR loc_lBuscar)

            *-- Numericos: sem When no legado - editaveis em qualquer modo de edicao
            loc_oCnt.txt_4c_Aliquota.ReadOnly = !par_lHabilitar
            loc_oCnt.txt_4c_Base.ReadOnly     = !par_lHabilitar
            loc_oCnt.txt_4c_Reduz.ReadOnly    = !par_lHabilitar
            loc_oCnt.txt_4c_Subst.ReadOnly    = !par_lHabilitar

            *-- Campos desc de lookup: editaveis em INCLUIR (When legado = INSERIR AND Empty(codigo))
            loc_oCnt.txt_4c_DCFOP.ReadOnly    = !loc_lIncluir
            loc_oCnt.txt_4c_DOrigem.ReadOnly  = !loc_lIncluir
            loc_oCnt.txt_4c_DDestino.ReadOnly = !loc_lIncluir
        CATCH TO loException
            MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
                "FormIct.HabilitarCampos")
        ENDTRY
    ENDPROC

    *====================================================================
    * LimparCampos - Zera propriedades do BO e campos visuais de Page2
    *====================================================================
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt
        TRY
            WITH THIS.this_oBusinessObject
                .this_cCidChaves  = ""
                .this_cTipos      = ""
                .this_cDescs      = ""
                .this_cCfops      = ""
                .this_cOrigems    = ""
                .this_cDestinos   = ""
                .this_cMovs       = ""
                .this_nAliquotas  = 0
                .this_nBases      = 0
                .this_nReduzidas  = 0
                .this_nAliqicmsts = 0
                .this_cOrigemd    = ""
                .this_cDestinoD   = ""
                .this_cCfopd      = ""
            ENDWITH
            loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
            loc_oCnt.txt_4c_Tipo.Value     = ""
            loc_oCnt.txt_4c_Desc.Value     = ""
            loc_oCnt.txt_4c_CFOP.Value     = ""
            loc_oCnt.txt_4c_DCFOP.Value    = ""
            loc_oCnt.txt_4c_Origem.Value   = ""
            loc_oCnt.txt_4c_DOrigem.Value  = ""
            loc_oCnt.txt_4c_Destino.Value  = ""
            loc_oCnt.txt_4c_DDestino.Value = ""
            loc_oCnt.txt_4c_Movs.Value     = ""
            loc_oCnt.txt_4c_Aliquota.Value = 0
            loc_oCnt.txt_4c_Base.Value     = 0
            loc_oCnt.txt_4c_Reduz.Value    = 0
            loc_oCnt.txt_4c_Subst.Value    = 0
        CATCH TO loException
            MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, ;
                "FormIct.LimparCampos")
        ENDTRY
    ENDPROC

    *====================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *====================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lEditar
        TRY
            loc_oPg2    = THIS.pgf_4c_Paginas.Page2
            loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")

            WITH loc_oPg2.cnt_4c_Salva
                .cmd_4c_Confirmar.Enabled = loc_lEditar
                .cmd_4c_Cancelar.Enabled  = .T.
                .Visible     = .T.
            ENDWITH
        CATCH TO loException
            MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + ;
                loException.Message, "FormIct.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *====================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *====================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

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
                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * FormatarGridLista - Aplica formatacao visual ao Grid
    *====================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        IF VARTYPE(par_oGrid) != "O"
            RETURN
        ENDIF
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *====================================================================
    * Destroy - Libera recursos
    *====================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message, "FormIct.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

    *====================================================================
    * CFOPKeyPress / CFOPDblClick - F4 ou duplo-clique em CFOP (codigo)
    *====================================================================
    PROCEDURE CFOPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupCFOP()
        ENDIF
    ENDPROC

    PROCEDURE CFOPDblClick()
        THIS.AbrirLookupCFOP()
    ENDPROC

    *====================================================================
    * AbrirLookupCFOP - Busca por codigo em SigCdCfo
    * Preenche txt_4c_CFOP (Codigos) e txt_4c_DCFOP (Descricaos)
    *====================================================================
    PROCEDURE AbrirLookupCFOP()
        LOCAL loc_oCnt, loc_oBusca, loc_cCodigo, loc_cDescricao
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        IF loc_oCnt.txt_4c_CFOP.ReadOnly
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCfo", "cursor_4c_BuscaCFOP", "Codigos", ;
            ALLTRIM(loc_oCnt.txt_4c_CFOP.Value), ;
            "Buscar C.F.O.P.")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCFOP")
                loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCFOP.Codigos)
                loc_cDescricao = ALLTRIM(cursor_4c_BuscaCFOP.Descricaos)
                loc_oCnt.txt_4c_CFOP.Value  = loc_cCodigo
                loc_oCnt.txt_4c_DCFOP.Value = loc_cDescricao
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaCFOP")
            USE IN cursor_4c_BuscaCFOP
        ENDIF
    ENDPROC

    *====================================================================
    * DCFOPKeyPress / DCFOPDblClick - F4 ou duplo-clique em DCFOP (descricao)
    * Ativo apenas em INCLUIR quando CFOP estiver vazio (When legado)
    *====================================================================
    PROCEDURE DCFOPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupDCFOP()
        ENDIF
    ENDPROC

    PROCEDURE DCFOPDblClick()
        THIS.AbrirLookupDCFOP()
    ENDPROC

    *====================================================================
    * AbrirLookupDCFOP - Busca por descricao em SigCdCfo
    * Ativo apenas em INCLUIR e com CFOP vazio (When legado)
    * Preenche txt_4c_CFOP (Codigos) e txt_4c_DCFOP (Descricaos)
    *====================================================================
    PROCEDURE AbrirLookupDCFOP()
        LOCAL loc_oCnt, loc_oBusca, loc_cCodigo, loc_cDescricao
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        IF loc_oCnt.txt_4c_DCFOP.ReadOnly
            RETURN
        ENDIF
        *-- Guardia: When legado = INSERIR AND Empty(GetCFOP)
        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_CFOP.Value))
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCfo", "cursor_4c_BuscaCFOP", "Descricaos", ;
            ALLTRIM(loc_oCnt.txt_4c_DCFOP.Value), ;
            "Buscar C.F.O.P. por Descri" + CHR(231) + CHR(227) + "o")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCFOP")
                loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCFOP.Codigos)
                loc_cDescricao = ALLTRIM(cursor_4c_BuscaCFOP.Descricaos)
                loc_oCnt.txt_4c_CFOP.Value  = loc_cCodigo
                loc_oCnt.txt_4c_DCFOP.Value = loc_cDescricao
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaCFOP")
            USE IN cursor_4c_BuscaCFOP
        ENDIF
    ENDPROC

    *====================================================================
    * OrigemKeyPress / OrigemDblClick - F4 ou duplo-clique em Origem (codigo UF)
    *====================================================================
    PROCEDURE OrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupOrigem()
        ENDIF
    ENDPROC

    PROCEDURE OrigemDblClick()
        THIS.AbrirLookupOrigem()
    ENDPROC

    *====================================================================
    * AbrirLookupOrigem - Busca por codigo de UF em SigCdUfs
    * Preenche txt_4c_Origem (Estados) e txt_4c_DOrigem (Descrs)
    *====================================================================
    PROCEDURE AbrirLookupOrigem()
        LOCAL loc_oCnt, loc_oBusca, loc_cEstado, loc_cDescricao
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        IF loc_oCnt.txt_4c_Origem.ReadOnly
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUfs", "cursor_4c_BuscaUF", "Estados", ;
            ALLTRIM(loc_oCnt.txt_4c_Origem.Value), ;
            "Estado Origem")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Estados", "", "UF")
            loc_oBusca.mAddColuna("Descrs",  "", "Estado")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUF")
                loc_cEstado    = ALLTRIM(cursor_4c_BuscaUF.Estados)
                loc_cDescricao = ALLTRIM(cursor_4c_BuscaUF.Descrs)
                loc_oCnt.txt_4c_Origem.Value  = loc_cEstado
                loc_oCnt.txt_4c_DOrigem.Value = loc_cDescricao
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaUF")
            USE IN cursor_4c_BuscaUF
        ENDIF
    ENDPROC

    *====================================================================
    * DOrigemKeyPress / DOrigemDblClick - F4 ou duplo-clique em DOrigem (nome do estado)
    * Ativo apenas em INCLUIR quando Origem estiver vazio (When legado)
    *====================================================================
    PROCEDURE DOrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupDOrigem()
        ENDIF
    ENDPROC

    PROCEDURE DOrigemDblClick()
        THIS.AbrirLookupDOrigem()
    ENDPROC

    *====================================================================
    * AbrirLookupDOrigem - Busca por nome de estado em SigCdUfs
    * Ativo apenas em INCLUIR e com Origem vazio (When legado)
    * Preenche txt_4c_Origem (Estados) e txt_4c_DOrigem (Descrs)
    *====================================================================
    PROCEDURE AbrirLookupDOrigem()
        LOCAL loc_oCnt, loc_oBusca, loc_cEstado, loc_cDescricao
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        IF loc_oCnt.txt_4c_DOrigem.ReadOnly
            RETURN
        ENDIF
        *-- Guardia: When legado = INSERIR AND Empty(GetOrigem)
        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Origem.Value))
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUfs", "cursor_4c_BuscaUF", "Descrs", ;
            ALLTRIM(loc_oCnt.txt_4c_DOrigem.Value), ;
            "Estado Origem por Nome")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Descrs",  "", "Estado")
            loc_oBusca.mAddColuna("Estados", "", "UF")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUF")
                loc_cEstado    = ALLTRIM(cursor_4c_BuscaUF.Estados)
                loc_cDescricao = ALLTRIM(cursor_4c_BuscaUF.Descrs)
                loc_oCnt.txt_4c_Origem.Value  = loc_cEstado
                loc_oCnt.txt_4c_DOrigem.Value = loc_cDescricao
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaUF")
            USE IN cursor_4c_BuscaUF
        ENDIF
    ENDPROC

    *====================================================================
    * DestinoKeyPress / DestinoDblClick - F4 ou duplo-clique em Destino (codigo UF)
    *====================================================================
    PROCEDURE DestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupDestino()
        ENDIF
    ENDPROC

    PROCEDURE DestinoDblClick()
        THIS.AbrirLookupDestino()
    ENDPROC

    *====================================================================
    * AbrirLookupDestino - Busca por codigo de UF em SigCdUfs
    * Preenche txt_4c_Destino (Estados) e txt_4c_DDestino (Descrs)
    *====================================================================
    PROCEDURE AbrirLookupDestino()
        LOCAL loc_oCnt, loc_oBusca, loc_cEstado, loc_cDescricao
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        IF loc_oCnt.txt_4c_Destino.ReadOnly
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUfs", "cursor_4c_BuscaUF", "Estados", ;
            ALLTRIM(loc_oCnt.txt_4c_Destino.Value), ;
            "Estado Destino")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Estados", "", "UF")
            loc_oBusca.mAddColuna("Descrs",  "", "Estado")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUF")
                loc_cEstado    = ALLTRIM(cursor_4c_BuscaUF.Estados)
                loc_cDescricao = ALLTRIM(cursor_4c_BuscaUF.Descrs)
                loc_oCnt.txt_4c_Destino.Value  = loc_cEstado
                loc_oCnt.txt_4c_DDestino.Value = loc_cDescricao
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaUF")
            USE IN cursor_4c_BuscaUF
        ENDIF
    ENDPROC

    *====================================================================
    * DDestinoKeyPress / DDestinoDblClick - F4 ou duplo-clique em DDestino (nome estado)
    * Ativo apenas em INCLUIR quando Destino estiver vazio (When legado)
    *====================================================================
    PROCEDURE DDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28
            THIS.AbrirLookupDDestino()
        ENDIF
    ENDPROC

    PROCEDURE DDestinoDblClick()
        THIS.AbrirLookupDDestino()
    ENDPROC

    *====================================================================
    * AbrirLookupDDestino - Busca por nome de estado em SigCdUfs
    * Ativo apenas em INCLUIR e com Destino vazio (When legado)
    * Preenche txt_4c_Destino (Estados) e txt_4c_DDestino (Descrs)
    *====================================================================
    PROCEDURE AbrirLookupDDestino()
        LOCAL loc_oCnt, loc_oBusca, loc_cEstado, loc_cDescricao
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        IF loc_oCnt.txt_4c_DDestino.ReadOnly
            RETURN
        ENDIF
        *-- Guardia: When legado = INSERIR AND Empty(GetDestino)
        IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Destino.Value))
            RETURN
        ENDIF

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUfs", "cursor_4c_BuscaUF", "Descrs", ;
            ALLTRIM(loc_oCnt.txt_4c_DDestino.Value), ;
            "Estado Destino por Nome")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("Descrs",  "", "Estado")
            loc_oBusca.mAddColuna("Estados", "", "UF")
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUF")
                loc_cEstado    = ALLTRIM(cursor_4c_BuscaUF.Estados)
                loc_cDescricao = ALLTRIM(cursor_4c_BuscaUF.Descrs)
                loc_oCnt.txt_4c_Destino.Value  = loc_cEstado
                loc_oCnt.txt_4c_DDestino.Value = loc_cDescricao
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_BuscaUF")
            USE IN cursor_4c_BuscaUF
        ENDIF
    ENDPROC

    *====================================================================
    * ValidarMovs - Valida campo Tipo de Movimento (E=Entrada / S=Saida)
    * Equivale ao GetMovs.Valid do legado
    *====================================================================
    PROCEDURE ValidarMovs(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oCnt, loc_cMovs
        loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
        IF VARTYPE(loc_oCnt) != "O"
            RETURN
        ENDIF
        IF loc_oCnt.txt_4c_Movs.ReadOnly
            RETURN
        ENDIF
        loc_cMovs = UPPER(ALLTRIM(loc_oCnt.txt_4c_Movs.Value))
        IF !EMPTY(loc_cMovs) AND !INLIST(loc_cMovs, "E", "S")
            MsgAviso("Tipo de Movimento inv" + CHR(225) + "lido." + CHR(13) + ;
                "Use E=Entrada ou S=Sa" + CHR(237) + "da.")
            loc_oCnt.txt_4c_Movs.Value = ""
        ENDIF
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\IctBO.prg):
*====================================================================
* IctBO.prg
*
* Business Object para Cadastro de Tipo de Tributa??o do ICMS
* Tabela: SigPrTri
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS IctBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTri)
    this_cCidChaves   = ""    && cidchaves char(20) - PK composta (gerada)
    this_cTipos       = ""    && tipos     char(4)
    this_cDescs       = ""    && descs     char(20)
    this_cCfops       = ""    && cfops     char(10)
    this_cOrigems     = ""    && origems   char(2)
    this_cDestinos    = ""    && destinos  char(2)
    this_cMovs        = ""    && movs      char(1)
    this_nAliquotas   = 0     && aliquotas numeric(5,2)
    this_nBases       = 0     && bases     numeric(5,2)
    this_nReduzidas   = 0     && reduzidas numeric(5,2)
    this_nAliqicmsts  = 0     && aliqicmsts numeric(5,2) - Aliq. Substitui??o

    *-- Propriedades auxiliares de exibi??o (vem de JOINs, n?o s?o colunas de SigPrTri)
    this_cOrigemd     = ""    && SigCdUfs.Descrs para Origems (display)
    this_cDestinoD    = ""    && SigCdUfs.Descrs para Destinos (display)
    this_cCfopd       = ""    && SigCdCfo.Descricaos para Cfops (display)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTri"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException.Message, "IctBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    * cidchaves = tipos(4) + cfops(10) + movs(1) + origems(2) + "/" + destinos(2) = 20 chars
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * GerarCidChaves - Computa a PK composta a partir dos campos-chave
    *====================================================================
    PROTECTED FUNCTION GerarCidChaves()
        RETURN PADR(ALLTRIM(THIS.this_cTipos),  4) + ;
               PADR(ALLTRIM(THIS.this_cCfops), 10) + ;
               LEFT(ALLTRIM(THIS.this_cMovs) + " ", 1) + ;
               PADR(ALLTRIM(THIS.this_cOrigems), 2) + ;
               "/" + ;
               PADR(ALLTRIM(THIS.this_cDestinos), 2)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,   "C")
                THIS.this_cTipos      = TratarNulo(Tipos,       "C")
                THIS.this_cDescs      = TratarNulo(Descs,       "C")
                THIS.this_cCfops      = TratarNulo(CFOPs,       "C")
                THIS.this_cOrigems    = TratarNulo(Origems,     "C")
                THIS.this_cDestinos   = TratarNulo(Destinos,    "C")
                THIS.this_cMovs       = TratarNulo(Movs,        "C")
                THIS.this_nAliquotas  = TratarNulo(Aliquotas,   "N")
                THIS.this_nBases      = TratarNulo(Bases,       "N")
                THIS.this_nReduzidas  = TratarNulo(Reduzidas,   "N")
                THIS.this_nAliqicmsts = TratarNulo(aliqicmsts,  "N")
                IF FCOUNT() > 11
                    THIS.this_cOrigemd  = TratarNulo(Origemd,   "C")
                    THIS.this_cDestinoD = TratarNulo(Destinod,  "C")
                    THIS.this_cCfopd    = TratarNulo(CFOPd,     "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, ;
                "IctBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cTipos))
            MsgAviso("Tipo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cCfops))
            MsgAviso("C.F.O.P. obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cMovs))
            MsgAviso("Tipo de Movimento obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ELSE
            IF !INLIST(UPPER(ALLTRIM(THIS.this_cMovs)), "E", "S")
            MsgAviso("Tipo de Movimento inv" + CHR(225) + "lido. Use E=Entrada ou S=Sa" + CHR(237) + "da.")
            loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Buscar - Busca registros na tabela SigPrTri com JOINs de display
    * par_cFiltro: condicao SQL sem WHERE (vazio = todos)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), Tipos C(4), ;
                        Descs C(20), CFOPs C(10), Origems C(2), Destinos C(2), ;
                        Movs C(1), Aliquotas N(5,2), Bases N(5,2), Reduzidas N(5,2), ;
                        aliqicmsts N(5,2), Origemd C(50), Destinod C(50), CFOPd C(60))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.cidchaves, a.Tipos, a.Descs, a.CFOPs," + ;
                    " a.Origems, a.Destinos, a.Movs, a.Aliquotas, a.Bases," + ;
                    " a.Reduzidas, a.aliqicmsts," + ;
                    " b.Descrs AS Origemd, c.Descrs AS Destinod, d.Descricaos AS CFOPd" + ;
                    " FROM SigPrTri a" + ;
                    " LEFT JOIN SigCdUfs b ON a.Origems = b.Estados" + ;
                    " LEFT JOIN SigCdUfs c ON a.Destinos = c.Estados" + ;
                    " LEFT JOIN SigCdCfo d ON a.CFOPs = d.Codigos"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Tipos, a.CFOPs, a.Movs, a.Origems, a.Destinos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "IctBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.Tipos, a.Descs, a.CFOPs," + ;
                " a.Origems, a.Destinos, a.Movs, a.Aliquotas, a.Bases," + ;
                " a.Reduzidas, a.aliqicmsts," + ;
                " b.Descrs AS Origemd, c.Descrs AS Destinod, d.Descricaos AS CFOPd" + ;
                " FROM SigPrTri a" + ;
                " LEFT JOIN SigCdUfs b ON a.Origems = b.Estados" + ;
                " LEFT JOIN SigCdUfs c ON a.Destinos = c.Estados" + ;
                " LEFT JOIN SigCdCfo d ON a.CFOPs = d.Codigos" + ;
                " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado!")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "IctBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigPrTri (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarCidChaves()

            loc_cSQL = "INSERT INTO SigPrTri" + ;
                " (cidchaves, Tipos, Descs, CFOPs, Origems, Destinos," + ;
                " Movs, Aliquotas, Bases, Reduzidas, aliqicmsts)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(THIS.this_cTipos)     + ", " + ;
                EscaparSQL(THIS.this_cDescs)     + ", " + ;
                EscaparSQL(THIS.this_cCfops)     + ", " + ;
                EscaparSQL(THIS.this_cOrigems)   + ", " + ;
                EscaparSQL(THIS.this_cDestinos)  + ", " + ;
                EscaparSQL(THIS.this_cMovs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotas,  2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBases,      2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nReduzidas,  2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqicmsts, 2) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "IctBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigPrTri (PROTECTED)
    * Apenas campos editaveis em modo ALTERAR (nao atualiza chave composta)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrTri SET" + ;
                " Descs = "      + EscaparSQL(THIS.this_cDescs)             + ", " + ;
                " Aliquotas = "  + FormatarNumeroSQL(THIS.this_nAliquotas,  2) + ", " + ;
                " Bases = "      + FormatarNumeroSQL(THIS.this_nBases,      2) + ", " + ;
                " Reduzidas = "  + FormatarNumeroSQL(THIS.this_nReduzidas,  2) + ", " + ;
                " aliqicmsts = " + FormatarNumeroSQL(THIS.this_nAliqicmsts, 2) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "IctBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro de SigPrTri (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTri WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "IctBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

