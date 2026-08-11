# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 4/10
- Mensagem: TIMEOUT: VFP9 travou durante teste automatico (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-09 21:52:20] [INFO] Config FPW: (nao fornecido)
[2026-08-09 21:52:20] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 21:52:20] [INFO] Timeout: 300 segundos
[2026-08-09 21:52:20] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ja5dcobl.prg
[2026-08-09 21:52:20] [INFO] Conteudo do wrapper:
[2026-08-09 21:52:20] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormImp', 'C:\4c\tasks\task451', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
QUIT

[2026-08-09 21:52:20] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ja5dcobl.prg
[2026-08-09 21:52:20] [INFO] VFP output esperado em: C:\4c\tasks\task451\vfp_output.txt
[2026-08-09 21:52:20] [INFO] Executando Visual FoxPro 9...
[2026-08-09 21:52:20] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ja5dcobl.prg
[2026-08-09 21:52:20] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ja5dcobl.prg
[2026-08-09 21:52:20] [INFO] Timeout configurado: 300 segundos
[2026-08-09 21:57:20] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 18644)...
[2026-08-09 21:57:22] [INFO] VFP9 finalizado em 302.0592201 segundos
[2026-08-09 21:57:22] [INFO] Exit Code: 4
[2026-08-09 21:57:22] [INFO] 
[2026-08-09 21:57:22] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 21:57:22] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ja5dcobl.prg
[2026-08-09 21:57:22] [INFO] 
[2026-08-09 21:57:22] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 21:57:22] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 21:57:22] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 21:57:22] [INFO] * Parameters: 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
[2026-08-09 21:57:22] [INFO] 
[2026-08-09 21:57:22] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 21:57:22] [INFO] SET SAFETY OFF
[2026-08-09 21:57:22] [INFO] SET RESOURCE OFF
[2026-08-09 21:57:22] [INFO] SET TALK OFF
[2026-08-09 21:57:22] [INFO] SET NOTIFY OFF
[2026-08-09 21:57:22] [INFO] SYS(2335, 0)
[2026-08-09 21:57:22] [INFO] 
[2026-08-09 21:57:22] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
[2026-08-09 21:57:22] [INFO] QUIT
[2026-08-09 21:57:22] [INFO] 
[2026-08-09 21:57:22] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 21:57:22] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 22:06:31] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 22:06:31] [INFO] Config FPW: (nao fornecido)
[2026-08-09 22:06:31] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 22:06:31] [INFO] Timeout: 300 segundos
[2026-08-09 22:06:31] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ey3tyvkh.prg
[2026-08-09 22:06:31] [INFO] Conteudo do wrapper:
[2026-08-09 22:06:31] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormImp', 'C:\4c\tasks\task451', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
QUIT

[2026-08-09 22:06:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ey3tyvkh.prg
[2026-08-09 22:06:31] [INFO] VFP output esperado em: C:\4c\tasks\task451\vfp_output.txt
[2026-08-09 22:06:31] [INFO] Executando Visual FoxPro 9...
[2026-08-09 22:06:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ey3tyvkh.prg
[2026-08-09 22:06:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ey3tyvkh.prg
[2026-08-09 22:06:31] [INFO] Timeout configurado: 300 segundos
[2026-08-09 22:11:31] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 19448)...
[2026-08-09 22:11:33] [INFO] VFP9 finalizado em 302.0599261 segundos
[2026-08-09 22:11:33] [INFO] Exit Code: 4
[2026-08-09 22:11:33] [INFO] 
[2026-08-09 22:11:33] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 22:11:33] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ey3tyvkh.prg
[2026-08-09 22:11:33] [INFO] 
[2026-08-09 22:11:33] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 22:11:33] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 22:11:33] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 22:11:33] [INFO] * Parameters: 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
[2026-08-09 22:11:33] [INFO] 
[2026-08-09 22:11:33] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 22:11:33] [INFO] SET SAFETY OFF
[2026-08-09 22:11:33] [INFO] SET RESOURCE OFF
[2026-08-09 22:11:33] [INFO] SET TALK OFF
[2026-08-09 22:11:33] [INFO] SET NOTIFY OFF
[2026-08-09 22:11:33] [INFO] SYS(2335, 0)
[2026-08-09 22:11:33] [INFO] 
[2026-08-09 22:11:33] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
[2026-08-09 22:11:33] [INFO] QUIT
[2026-08-09 22:11:33] [INFO] 
[2026-08-09 22:11:33] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 22:11:33] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 22:13:50] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 22:13:50] [INFO] Config FPW: (nao fornecido)
[2026-08-09 22:13:50] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 22:13:50] [INFO] Timeout: 300 segundos
[2026-08-09 22:13:50] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xw15i512.prg
[2026-08-09 22:13:50] [INFO] Conteudo do wrapper:
[2026-08-09 22:13:50] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormImp', 'C:\4c\tasks\task451', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
QUIT

[2026-08-09 22:13:50] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xw15i512.prg
[2026-08-09 22:13:50] [INFO] VFP output esperado em: C:\4c\tasks\task451\vfp_output.txt
[2026-08-09 22:13:50] [INFO] Executando Visual FoxPro 9...
[2026-08-09 22:13:50] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xw15i512.prg
[2026-08-09 22:13:50] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xw15i512.prg
[2026-08-09 22:13:50] [INFO] Timeout configurado: 300 segundos
[2026-08-09 22:18:50] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 18448)...
[2026-08-09 22:18:52] [INFO] VFP9 finalizado em 302.0592713 segundos
[2026-08-09 22:18:52] [INFO] Exit Code: 4
[2026-08-09 22:18:52] [INFO] 
[2026-08-09 22:18:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 22:18:52] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_xw15i512.prg
[2026-08-09 22:18:52] [INFO] 
[2026-08-09 22:18:52] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 22:18:53] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 22:18:53] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 22:18:53] [INFO] * Parameters: 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
[2026-08-09 22:18:53] [INFO] 
[2026-08-09 22:18:53] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 22:18:53] [INFO] SET SAFETY OFF
[2026-08-09 22:18:53] [INFO] SET RESOURCE OFF
[2026-08-09 22:18:53] [INFO] SET TALK OFF
[2026-08-09 22:18:53] [INFO] SET NOTIFY OFF
[2026-08-09 22:18:53] [INFO] SYS(2335, 0)
[2026-08-09 22:18:53] [INFO] 
[2026-08-09 22:18:53] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
[2026-08-09 22:18:53] [INFO] QUIT
[2026-08-09 22:18:53] [INFO] 
[2026-08-09 22:18:53] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 22:18:53] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 23:16:23] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 23:16:23] [INFO] Config FPW: (nao fornecido)
[2026-08-09 23:16:23] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 23:16:23] [INFO] Timeout: 300 segundos
[2026-08-09 23:16:23] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qgyg3gyt.prg
[2026-08-09 23:16:23] [INFO] Conteudo do wrapper:
[2026-08-09 23:16:23] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormImp', 'C:\4c\tasks\task451', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
QUIT

[2026-08-09 23:16:23] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qgyg3gyt.prg
[2026-08-09 23:16:23] [INFO] VFP output esperado em: C:\4c\tasks\task451\vfp_output.txt
[2026-08-09 23:16:23] [INFO] Executando Visual FoxPro 9...
[2026-08-09 23:16:23] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qgyg3gyt.prg
[2026-08-09 23:16:23] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qgyg3gyt.prg
[2026-08-09 23:16:23] [INFO] Timeout configurado: 300 segundos
[2026-08-09 23:21:23] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 5708)...
[2026-08-09 23:21:25] [INFO] VFP9 finalizado em 302.0758833 segundos
[2026-08-09 23:21:25] [INFO] Exit Code: 4
[2026-08-09 23:21:25] [INFO] 
[2026-08-09 23:21:26] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 23:21:26] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_qgyg3gyt.prg
[2026-08-09 23:21:26] [INFO] 
[2026-08-09 23:21:26] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 23:21:26] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 23:21:26] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 23:21:26] [INFO] * Parameters: 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
[2026-08-09 23:21:26] [INFO] 
[2026-08-09 23:21:26] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 23:21:26] [INFO] SET SAFETY OFF
[2026-08-09 23:21:26] [INFO] SET RESOURCE OFF
[2026-08-09 23:21:26] [INFO] SET TALK OFF
[2026-08-09 23:21:26] [INFO] SET NOTIFY OFF
[2026-08-09 23:21:26] [INFO] SYS(2335, 0)
[2026-08-09 23:21:26] [INFO] 
[2026-08-09 23:21:26] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormImp', 'C:\4c\tasks\task451', 'CRUD'
[2026-08-09 23:21:26] [INFO] QUIT
[2026-08-09 23:21:26] [INFO] 
[2026-08-09 23:21:26] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 23:21:26] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\cadastros\FormImp.prg):
*==============================================================================
* FormImp.prg - Formulario Cadastro de Impressoras
* Tabela: SigCdmp
* Migrado de: SIGCDIMP.SCX (frmcadastro)
*
* Estrutura (outer):
*   pgf_4c_Paginas (Top=-29, Tabs=.F.)
*     Page1 (Lista): grid + botoes CRUD + cabecalho + Encerrar
*     Page2 (Dados): cnt_4c_Salva + pgf_4c_Dados (inner)
*       pgf_4c_Dados (Top=152, Tabs=.T., 2 pages)
*         Page1: Dados Principais (campos config impressora)
*         Page2: Cheques em Formulario Continuo (inicia desabilitada)
*==============================================================================

DEFINE CLASS FormImp AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Impressoras"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2
    DataSession = 2

    *-- Estado interno
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormImp.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("ImpBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CarregarTiposEtiqueta()
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar lista inicial (pular se validando UI sem conexao)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao criar ImpBO", "FormImp.InicializarForm")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormImp.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .PageCount = 2
            .Tabs      = .F.
            .TabStop   = .F.
            .Visible   = .T.
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page1
            .Caption   = "Lista"
            .BackColor = RGB(255, 255, 255)
            .Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page2
            .Caption   = "Dados"
            .BackColor = RGB(255, 255, 255)
            .Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCnt, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza com titulo
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 2
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Caption   = THIS.Caption
                .Top       = 15
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Caption   = THIS.Caption
                .Top       = 12
                .Left      = 8
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 16
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- Container botoes CRUD (lado direito, canonico)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Incluir
            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top    = 5
                .Left   =  542
                .Width  = 75
                .Height = 75
                .BackColor   = RGB(255, 255, 255)
                .ForeColor   = RGB(90, 90, 90)
                .FontName    = "Tahoma"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .SpecialEffect = 0
                .MousePointer  = 15
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Visible     = .T.
            ENDWITH

            *-- Visualizar
            .AddObject("cmd_4c_Visualizar", "CommandButton")
            WITH .cmd_4c_Visualizar
                .Caption         = "Visualizar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
                .PicturePosition = 13
                .Top    = 5
                .Left   =  542
                .Width  = 75
                .Height = 75
                .BackColor   = RGB(255, 255, 255)
                .ForeColor   = RGB(90, 90, 90)
                .FontName    = "Tahoma"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .Themes      = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Visible     = .T.
            ENDWITH

            *-- Alterar
            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
                .PicturePosition = 13
                .Top    = 5
                .Left   =  542
                .Width  = 75
                .Height = 75
                .BackColor   = RGB(255, 255, 255)
                .ForeColor   = RGB(90, 90, 90)
                .FontName    = "Tahoma"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .Themes      = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Visible     = .T.
            ENDWITH

            *-- Excluir
            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
                .PicturePosition = 13
                .Top    = 5
                .Left   =  542
                .Width  = 75
                .Height = 75
                .BackColor   = RGB(255, 255, 255)
                .ForeColor   = RGB(90, 90, 90)
                .FontName    = "Tahoma"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .Themes      = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Visible     = .T.
            ENDWITH

            *-- Buscar
            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
                .PicturePosition = 13
                .Top    = 5
                .Left   =  542
                .Width  = 75
                .Height = 75
                .BackColor   = RGB(255, 255, 255)
                .ForeColor   = RGB(90, 90, 90)
                .FontName    = "Tahoma"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .Themes      = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Visible     = .T.
            ENDWITH
        ENDWITH

        *-- Encerrar (posicao canonica - CLAUDE.md regra #10 prevalece sobre legado)
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
                .Top    = 5
                .Left   = 917
                .Width  = 90
                .Height = 75
                .BackColor   = RGB(255, 255, 255)
                .ForeColor   = RGB(90, 90, 90)
                .FontName    = "Tahoma"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .SpecialEffect = 0
                .MousePointer  = 15
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Visible     = .T.
            ENDWITH
        ENDWITH

        *-- Grid da lista (2 colunas: Impres, MaxCols)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.RecordSource = ""
        loc_oPagina.grd_4c_Lista.ColumnCount  = 2

        WITH loc_oPagina.grd_4c_Lista
            .Top              = 117
            .Left             = 26
            .Width            = 890
            .Height           = 498
            .FontName         = "Tahoma"
            .FontSize         = 8
            .RowHeight        = 16
            .ForeColor        = RGB(90, 90, 90)
            .BackColor        = RGB(255, 255, 255)
            .GridLineColor    = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle   = 2
            .DeleteMark       = .F.
            .RecordMark       = .F.
            .ScrollBars       = 2
            .GridLines        = 3
            .Visible          = .T.

            .Column1.Width           = 280
            .Column1.Header1.Caption = "Impressoras"
            .Column2.Width           = 130
            .Column2.Header1.Caption = "M" + CHR(225) + "ximo de Colunas"
        ENDWITH

        *-- BINDEVENTs (metodos PUBLIC nao PROTECTED - CLAUDE.md regra)
        loc_oCnt = loc_oPagina.cnt_4c_Botoes
        BINDEVENT(loc_oCnt.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oCnt.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oCnt.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oCnt.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Confirmar/Cancelar (Grupo_Salva no legado)
        *-- Top = 4 (legado) + 29 (compensacao outer PF) = 33
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.

            *-- Confirmar (Salva no legado)
            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
                .Caption         = "Confirmar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .PicturePosition = 13
                .Top    = 5
                .Left   = 5
                .Width  = 75
                .Height = 75
                .BackColor   = RGB(255, 255, 255)
                .ForeColor   = RGB(90, 90, 90)
                .FontName    = "Tahoma"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .SpecialEffect = 0
                .MousePointer  = 15
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Visible     = .T.
            ENDWITH

            *-- Cancelar
            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .PicturePosition = 13
                .Top    = 5
                .Left   = 80
                .Width  = 75
                .Height = 75
                .BackColor   = RGB(255, 255, 255)
                .ForeColor   = RGB(90, 90, 90)
                .FontName    = "Tahoma"
                .FontSize    = 8
                .FontBold    = .T.
                .FontItalic  = .T.
                .Themes      = .F.
                .SpecialEffect = 0
                .MousePointer  = 15
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Visible     = .T.
            ENDWITH
        ENDWITH

        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        *-- Inner PageFrame (pgfDados no legado)
        *-- Top = 123 (legado) + 29 (compensacao outer PF) = 152
        *-- Tabs = .T.: abas visiveis para usuario alternar entre Dados/Cheques
        loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
        WITH loc_oPagina.pgf_4c_Dados
            .Top       = 152
            .Left      = 29
            .Width     = 741
            .Height    = 464
            .PageCount = 2
            .Tabs      = .T.
            .Visible   = .T.
        ENDWITH

        WITH loc_oPagina.pgf_4c_Dados.Page1
            .Caption   = "Dados Principais"
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
        ENDWITH

        *-- Pg2 comeca desabilitada: so habilita quando chkChqf = 1
        WITH loc_oPagina.pgf_4c_Dados.Page2
            .Caption   = "Cheques em Formul" + CHR(225) + "rio Cont" + CHR(237) + "nuo"
            .BackColor = RGB(255, 255, 255)
            .ForeColor = RGB(90, 90, 90)
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Enabled   = .F.
        ENDWITH

        THIS.ConfigurarPg1DadosPrincipais()
        THIS.ConfigurarPg2Cheques()
        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPg1DadosPrincipais()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *-- 1/2. lbl_4c_Impres + txt_4c_Impres
        loc_oPg1.AddObject("lbl_4c_Impres", "Label")
        WITH loc_oPg1.lbl_4c_Impres
            .Caption   = "Impressora :"
            .Top       = 12
            .Left      = 83
            .Width     = 63
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Impres", "TextBox")
        WITH loc_oPg1.txt_4c_Impres
            .Top           = 9
            .Left          = 151
            .Width         = 280
            .Height        = 23
            .MaxLength     = 30
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- 3/4. lbl_4c_Titulos + txt_4c_Titulos
        loc_oPg1.AddObject("lbl_4c_Titulos", "Label")
        WITH loc_oPg1.lbl_4c_Titulos
            .Caption   = "T" + CHR(237) + "tulo :"
            .Top       = 37
            .Left      = 111
            .Width     = 35
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Titulos", "TextBox")
        WITH loc_oPg1.txt_4c_Titulos
            .Top           = 34
            .Left          = 151
            .Width         = 26
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 5. chk_4c_Chqf (Cheque Formulario Continuo)
        loc_oPg1.AddObject("chk_4c_Chqf", "CheckBox")
        WITH loc_oPg1.chk_4c_Chqf
            .Caption   = "Cheque Form. Cont" + CHR(237) + "nuo"
            .Top       = 37
            .Left      = 207
            .Width     = 164
            .Height    = 16
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(loc_oPg1.chk_4c_Chqf, "Click", THIS, "ChkChqfChanged")

        *-- 6/7. lbl_4c_Rates + txt_4c_Rates
        loc_oPg1.AddObject("lbl_4c_Rates", "Label")
        WITH loc_oPg1.lbl_4c_Rates
            .Caption   = "Rate :"
            .Top       = 63
            .Left      = 114
            .Width     = 32
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Rates", "TextBox")
        WITH loc_oPg1.txt_4c_Rates
            .Top           = 59
            .Left          = 151
            .Width         = 51
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 8. chk_4c_Exps (Expandido)
        loc_oPg1.AddObject("chk_4c_Exps", "CheckBox")
        WITH loc_oPg1.chk_4c_Exps
            .Caption   = "Expandido "
            .Top       = 62
            .Left      = 207
            .Width     = 95
            .Height    = 16
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- 9/10. lbl_4c_Barras + txt_4c_Barras
        loc_oPg1.AddObject("lbl_4c_Barras", "Label")
        WITH loc_oPg1.lbl_4c_Barras
            .Caption   = "Barra :"
            .Top       = 88
            .Left      = 111
            .Width     = 35
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Barras", "TextBox")
        WITH loc_oPg1.txt_4c_Barras
            .Top           = 84
            .Left          = 151
            .Width         = 26
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 11/12. lbl_4c_Maxcols + txt_4c_Maxcols
        loc_oPg1.AddObject("lbl_4c_Maxcols", "Label")
        WITH loc_oPg1.lbl_4c_Maxcols
            .Caption   = "M" + CHR(225) + "ximo de Colunas :"
            .Top       = 113
            .Left      = 45
            .Width     = 101
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("txt_4c_Maxcols", "TextBox")
        WITH loc_oPg1.txt_4c_Maxcols
            .Top           = 109
            .Left          = 151
            .Width         = 26
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 13/14. lbl_4c_Tipos + cbo_4c_Tipos (Tipo de Grafico - value list)
        loc_oPg1.AddObject("lbl_4c_Tipos", "Label")
        WITH loc_oPg1.lbl_4c_Tipos
            .Caption   = "Tipo de Gr" + CHR(225) + "fico :"
            .Top       = 138
            .Left      = 65
            .Width     = 81
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("cbo_4c_Tipos", "ComboBox")
        WITH loc_oPg1.cbo_4c_Tipos
            .RowSourceType = 1
            .RowSource     = "Epson Esc K,Epson Esc * m n,Mecaf"
            .Style         = 2
            .Top           = 134
            .Left          = 151
            .Width         = 155
            .Height        = 23
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- 15. chk_4c_Graficos
        loc_oPg1.AddObject("chk_4c_Graficos", "CheckBox")
        WITH loc_oPg1.chk_4c_Graficos
            .Caption   = "Gr" + CHR(225) + "ficos "
            .Top       = 137
            .Left      = 312
            .Width     = 63
            .Height    = 16
            .AutoSize  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH

        *-- 16. lbl_4c_TpImpres ("Tipo de Impressora")
        loc_oPg1.AddObject("lbl_4c_TpImpres", "Label")
        WITH loc_oPg1.lbl_4c_TpImpres
            .Caption   = "Tipo de Impressora : "
            .Top       = 164
            .Left      = 44
            .Width     = 102
            .AutoSize  = .F.
            .WordWrap  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- 17. opt_4c_TpImpres (4 botoes: Boleto/Etiqueta/Boleto Zebra/Padrao)
        loc_oPg1.AddObject("opt_4c_TpImpres", "OptionGroup")
        WITH loc_oPg1.opt_4c_TpImpres
            .ButtonCount = 4
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 158
            .Left        = 147
            .Width       = 317
            .Height      = 27
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg1.opt_4c_TpImpres.Buttons(1)
            .Caption   = "Boleto"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg1.opt_4c_TpImpres.Buttons(2)
            .Caption   = "Etiqueta"
            .Left      = 66
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg1.opt_4c_TpImpres.Buttons(3)
            .Caption   = "Boleto Zebra"
            .Left      = 145
            .Top       = 5
            .Height    = 15
            .Width     = 79
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg1.opt_4c_TpImpres.Buttons(4)
            .Caption   = "Padr" + CHR(227) + "o"
            .Left      = 246
            .Top       = 5
            .Height    = 15
            .Width     = 61
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Themes    = .F.
        ENDWITH

        *-- 18. lbl_4c_Etiquetas ("Etiquetas:")
        loc_oPg1.AddObject("lbl_4c_Etiquetas", "Label")
        WITH loc_oPg1.lbl_4c_Etiquetas
            .Caption   = "Etiquetas :"
            .Top       = 190
            .Left      = 92
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- 19. opt_4c_ImpEtis (3 botoes: Allegro/Zebra ZPL/Zebra EPL)
        loc_oPg1.AddObject("opt_4c_ImpEtis", "OptionGroup")
        WITH loc_oPg1.opt_4c_ImpEtis
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Top         = 184
            .Left        = 147
            .Width       = 244
            .Height      = 27
            .Value       = 1
            .Visible     = .T.
        ENDWITH
        WITH loc_oPg1.opt_4c_ImpEtis.Buttons(1)
            .Caption   = "Allegro"
            .Left      = 5
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg1.opt_4c_ImpEtis.Buttons(2)
            .Caption   = "Zebra ZPL"
            .Left      = 66
            .Top       = 5
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH
        WITH loc_oPg1.opt_4c_ImpEtis.Buttons(3)
            .Caption   = "Zebra EPL"
            .Left      = 145
            .Top       = 5
            .Height    = 15
            .Width     = 66
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- 20/21. lbl_4c_Cetiquetas + cbo_4c_Cetiquetas (cursor crSigCdTpe)
        loc_oPg1.AddObject("lbl_4c_Cetiquetas", "Label")
        WITH loc_oPg1.lbl_4c_Cetiquetas
            .Caption   = "Etiqueta Padr" + CHR(227) + "o :"
            .Top       = 216
            .Left      = 60
            .Width     = 86
            .Height    = 15
            .AutoSize  = .F.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("cbo_4c_Cetiquetas", "ComboBox")
        WITH loc_oPg1.cbo_4c_Cetiquetas
            .RowSourceType    = 6
            .RowSource        = "crSigCdTpe.Cetiquetas,nTipos"
            .BoundColumn      = 1
            .ColumnCount      = 1
            .ColumnWidths     = "120"
            .FirstElement     = 1
            .BoundTo          = .T.
            .Style            = 2
            .Top              = 212
            .Left             = 151
            .Width            = 155
            .Height           = 23
            .SpecialEffect    = 1
            .FontName         = "Tahoma"
            .FontSize         = 8
            .Value            = ""
            .Visible          = .T.
        ENDWITH

        *-- 22. lbl_4c_ComandoPara ("Comando Para :" - cabecalho da secao abaixo, Top=245)
        loc_oPg1.AddObject("lbl_4c_ComandoPara", "Label")
        WITH loc_oPg1.lbl_4c_ComandoPara
            .Caption   = "Comando Para :"
            .Top       = 245
            .Left      = 8
            .Width     = 90
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- 23. lin_4c_Linha1 (separador visual, Top=262)
        loc_oPg1.AddObject("lin_4c_Linha1", "Line")
        WITH loc_oPg1.lin_4c_Linha1
            .Top         = 262
            .Left        = 8
            .Width       = 720
            .Height      = 0
            .BorderWidth = 2
            .Visible     = .T.
        ENDWITH

        *-- 24. lbl_4c_Expds + edt_4c_Expds (Desativar Negrito, Top=270, col esquerda)
        loc_oPg1.AddObject("lbl_4c_Expds", "Label")
        WITH loc_oPg1.lbl_4c_Expds
            .Caption   = "Desativar Negrito :"
            .Top       = 270
            .Left      = 56
            .Width     = 93
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("edt_4c_Expds", "EditBox")
        WITH loc_oPg1.edt_4c_Expds
            .Top           = 270
            .Left          = 151
            .Width         = 220
            .Height        = 35
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- 25. lbl_4c_Barcmds + edt_4c_Barcmds (Codigo de Barras, Top=270, col direita)
        loc_oPg1.AddObject("lbl_4c_Barcmds", "Label")
        WITH loc_oPg1.lbl_4c_Barcmds
            .Caption   = "C" + CHR(243) + "digo de Barras :"
            .Top       = 270
            .Left      = 415
            .Width     = 91
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("edt_4c_Barcmds", "EditBox")
        WITH loc_oPg1.edt_4c_Barcmds
            .Top           = 270
            .Left          = 509
            .Width         = 220
            .Height        = 49
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- 26. lbl_4c_Expas + edt_4c_Expas (Ativar Negrito, Top=308)
        loc_oPg1.AddObject("lbl_4c_Expas", "Label")
        WITH loc_oPg1.lbl_4c_Expas
            .Caption   = "Ativar Negrito :"
            .Top       = 308
            .Left      = 73
            .Width     = 76
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("edt_4c_Expas", "EditBox")
        WITH loc_oPg1.edt_4c_Expas
            .Top           = 308
            .Left          = 151
            .Width         = 220
            .Height        = 35
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- 27. lbl_4c_Fontes + edt_4c_Fontes (Inicializacao, Top=322, col direita)
        loc_oPg1.AddObject("lbl_4c_Fontes", "Label")
        WITH loc_oPg1.lbl_4c_Fontes
            .Caption   = "Inicializa" + CHR(231) + CHR(227) + "o :"
            .Top       = 322
            .Left      = 440
            .Width     = 66
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("edt_4c_Fontes", "EditBox")
        WITH loc_oPg1.edt_4c_Fontes
            .Top           = 322
            .Left          = 509
            .Width         = 220
            .Height        = 49
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- 28. lbl_4c_FontePeq + edt_4c_Fonte2s (Ativar Fonte Pequena, Top=348)
        loc_oPg1.AddObject("lbl_4c_FontePeq", "Label")
        WITH loc_oPg1.lbl_4c_FontePeq
            .Caption   = "Ativar Fonte Pequena :"
            .Top       = 348
            .Left      = 35
            .Width     = 114
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("edt_4c_Fonte2s", "EditBox")
        WITH loc_oPg1.edt_4c_Fonte2s
            .Top           = 348
            .Left          = 151
            .Width         = 220
            .Height        = 35
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- 29. shp_4c_Ajuste (shape contorno area ajustes etiqueta, col direita Top=373)
        loc_oPg1.AddObject("shp_4c_Ajuste", "Shape")
        WITH loc_oPg1.shp_4c_Ajuste
            .Top       = 373
            .Left      = 509
            .Width     = 220
            .Height    = 49
            .BackStyle = 0
            .Visible   = .T.
        ENDWITH

        *-- 30. lbl_4c_Ajustes + labels Vertical/Horizontal/Densidade/Velocidade
        loc_oPg1.AddObject("lbl_4c_Ajustes", "Label")
        WITH loc_oPg1.lbl_4c_Ajustes
            .Caption   = "Ajustes :"
            .Top       = 373
            .Left      = 461
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_SayVert", "Label")
        WITH loc_oPg1.lbl_4c_SayVert
            .Caption   = "Vertical"
            .Top       = 380
            .Left      = 512
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_SayHoriz", "Label")
        WITH loc_oPg1.lbl_4c_SayHoriz
            .Caption   = "Horizontal"
            .Top       = 380
            .Left      = 556
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_SayDens", "Label")
        WITH loc_oPg1.lbl_4c_SayDens
            .Caption   = "Densidade"
            .Top       = 380
            .Left      = 612
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("lbl_4c_SayVelo", "Label")
        WITH loc_oPg1.lbl_4c_SayVelo
            .Caption   = "Velocidade"
            .Top       = 379
            .Left      = 673
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- 31. spn_4c_AjVerts (TextBox c/ InputMask = Get_vert original, Top=392)
        loc_oPg1.AddObject("spn_4c_AjVerts", "TextBox")
        WITH loc_oPg1.spn_4c_AjVerts
            .Top           = 392
            .Left          = 516
            .Width         = 31
            .Height        = 23
            .InputMask     = "999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 32. spn_4c_AjHorzs (TextBox c/ InputMask = Get_horiz original, Top=392)
        loc_oPg1.AddObject("spn_4c_AjHorzs", "TextBox")
        WITH loc_oPg1.spn_4c_AjHorzs
            .Top           = 392
            .Left          = 564
            .Width         = 37
            .Height        = 23
            .InputMask     = "9999"
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 33. spn_4c_AjDens (Spinner densidade, range 10-20)
        loc_oPg1.AddObject("spn_4c_AjDens", "Spinner")
        WITH loc_oPg1.spn_4c_AjDens
            .Top               = 391
            .Left              = 612
            .Width             = 45
            .Height            = 26
            .KeyboardHighValue = 20
            .KeyboardLowValue  = 10
            .SpinnerHighValue  = 20
            .SpinnerLowValue   = 10
            .SpecialEffect     = 1
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .Value             = 20
            .Visible           = .T.
        ENDWITH

        *-- 34. spn_4c_AjVelos (Spinner velocidade, range 1-3)
        loc_oPg1.AddObject("spn_4c_AjVelos", "Spinner")
        WITH loc_oPg1.spn_4c_AjVelos
            .Top               = 391
            .Left              = 673
            .Width             = 49
            .Height            = 26
            .KeyboardHighValue = 3
            .KeyboardLowValue  = 1
            .SpinnerHighValue  = 3
            .SpinnerLowValue   = 1
            .SpecialEffect     = 1
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .Value             = 3
            .Visible           = .T.
        ENDWITH

        *-- 35. lbl_4c_Guilhotina + edt_4c_Fontemp1s (Aciona Guilhotina, Top=388)
        loc_oPg1.AddObject("lbl_4c_Guilhotina", "Label")
        WITH loc_oPg1.lbl_4c_Guilhotina
            .Caption   = "Aciona Guilhotina :"
            .Top       = 388
            .Left      = 58
            .Width     = 91
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg1.AddObject("edt_4c_Fontemp1s", "EditBox")
        WITH loc_oPg1.edt_4c_Fontemp1s
            .Top           = 388
            .Left          = 151
            .Width         = 220
            .Height        = 35
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- GotFocus no campo Guilhotina exibe ajuda de codigos de controle
        BINDEVENT(loc_oPg1.edt_4c_Fontemp1s, "GotFocus", THIS, "EdtGuiGotFocus")
    ENDPROC

    *==========================================================================
    PROCEDURE ChkChqfChanged()
        THIS.LockScreen = .T.
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Enabled = ;
            (THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.chk_4c_Chqf.Value = 1)
        THIS.LockScreen = .F.
    ENDPROC

    *==========================================================================
    PROCEDURE EdtGuiGotFocus()
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN
        ENDIF
        MESSAGEBOX("Ativar modo condensado (letra pequena)" + CHR(13) + CHR(10) + ;
            "DARUMA=CHR(15)" + CHR(13) + CHR(10) + ;
            "EPSON= CHR(27)+CHR(33)+CHR(1)" + CHR(13) + CHR(10) + ;
            "BEMATECH=CHR(15)" + CHR(13) + CHR(10) + ;
            "SWEDA= CHR(27)+CHR(33)+CHR(1)" + CHR(13) + CHR(10) + ;
            "DIEBOLD= CHR(15)" + CHR(13) + CHR(10) + ;
            "" + CHR(13) + CHR(10) + ;
            "Desativar modo condensado (letra pequena)" + CHR(13) + CHR(10) + ;
            "DARUMA=CHR(18)" + CHR(13) + CHR(10) + ;
            "EPSON= CHR(27)+CHR(33)+CHR(0)" + CHR(13) + CHR(10) + ;
            "BEMATECH=CHR(18)" + CHR(13) + CHR(10) + ;
            "SWEDA= CHR(27)+CHR(33)+CHR(0)" + CHR(13) + CHR(10) + ;
            "DIEBOLD= CHR(27)+CHR(18)" + CHR(13) + CHR(10) + ;
            "" + CHR(13) + CHR(10) + ;
            "Ativar negrito" + CHR(13) + CHR(10) + ;
            "DARUMA= CHR(17)" + CHR(13) + CHR(10) + ;
            "EPSON= CHR(27)+CHR(69)+CHR(1)" + CHR(13) + CHR(10) + ;
            "BEMATECH= CHR(17)" + CHR(13) + CHR(10) + ;
            "SWEDA= CHR(27)+CHR(69)+CHR(1)" + CHR(13) + CHR(10) + ;
            "DIEBOLD= CHR(27)+CHR(69)" + CHR(13) + CHR(10) + ;
            "" + CHR(13) + CHR(10) + ;
            "Desativar negrito" + CHR(13) + CHR(10) + ;
            "DARUMA=CHR(19)" + CHR(13) + CHR(10) + ;
            "EPSON=CHR(27)+CHR(69)+CHR(0)" + CHR(13) + CHR(10) + ;
            "BEMATECH=CHR(19)" + CHR(13) + CHR(10) + ;
            "SWEDA=CHR(27)+CHR(69)+CHR(0)" + CHR(13) + CHR(10) + ;
            "DIEBOLD=CHR(27)+CHR(70)" + CHR(13) + CHR(10) + ;
            "" + CHR(13) + CHR(10) + ;
            "Aciona guilhotina" + CHR(13) + CHR(10) + ;
            "DARUMA=" + CHR(13) + CHR(10) + ;
            "EPSON=CHR(29)+CHR(86)+CHR(1)" + CHR(13) + CHR(10) + ;
            "BEMATECH=CHR(27)+CHR(119)" + CHR(13) + CHR(10) + ;
            "SWEDA= CHR(29)+CHR(86)+CHR(1)" + CHR(13) + CHR(10) + ;
            "DIEBOLD=CHR(17)", ;
            0, "C" + CHR(243) + "digos de Controle da Impressora")
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPg2Cheques()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        *======== COLUNA ESQUERDA ========

        *-- 1. Valor em Numeros: lbl + txt_4c_Nlivl1s + x + txt_4c_Nclvl1s
        loc_oPg2.AddObject("lbl_4c_Valnums", "Label")
        WITH loc_oPg2.lbl_4c_Valnums
            .Caption   = "Valor em N" + CHR(250) + "meros"
            .Top       = 78
            .Left      = 184
            .Width     = 80
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nlivl1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nlivl1s
            .Top           = 90
            .Left          = 184
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_XValNum", "Label")
        WITH loc_oPg2.lbl_4c_XValNum
            .Caption   = "x"
            .Top       = 92
            .Left      = 228
            .Width     = 6
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nclvl1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nclvl1s
            .Top           = 90
            .Left          = 233
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 2. Valor por Extenso (1a Linha)
        loc_oPg2.AddObject("lbl_4c_Valext1", "Label")
        WITH loc_oPg2.lbl_4c_Valext1
            .Caption   = "Valor por Extenso (1" + CHR(170) + " Linha)"
            .Top       = 110
            .Left      = 184
            .Width     = 119
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nlivext1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nlivext1s
            .Top           = 121
            .Left          = 184
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_XVExt1", "Label")
        WITH loc_oPg2.lbl_4c_XVExt1
            .Caption   = "x"
            .Top       = 123
            .Left      = 228
            .Width     = 6
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nclvext1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nclvext1s
            .Top           = 121
            .Left          = 233
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 3. Valor por Extenso (2a Linha)
        loc_oPg2.AddObject("lbl_4c_Valext2", "Label")
        WITH loc_oPg2.lbl_4c_Valext2
            .Caption   = "Valor por Extenso (2" + CHR(170) + " Linha)"
            .Top       = 144
            .Left      = 184
            .Width     = 119
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nlivext2s", "TextBox")
        WITH loc_oPg2.txt_4c_Nlivext2s
            .Top           = 156
            .Left          = 184
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_XVExt2", "Label")
        WITH loc_oPg2.lbl_4c_XVExt2
            .Caption   = "x"
            .Top       = 158
            .Left      = 228
            .Width     = 6
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nclvext2s", "TextBox")
        WITH loc_oPg2.txt_4c_Nclvext2s
            .Top           = 156
            .Left          = 233
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 4. Favorecido
        loc_oPg2.AddObject("lbl_4c_Favorecido", "Label")
        WITH loc_oPg2.lbl_4c_Favorecido
            .Caption   = "Favorecido"
            .Top       = 180
            .Left      = 184
            .Width     = 48
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nlinom1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nlinom1s
            .Top           = 192
            .Left          = 184
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_XFavor", "Label")
        WITH loc_oPg2.lbl_4c_XFavor
            .Caption   = "x"
            .Top       = 194
            .Left      = 228
            .Width     = 6
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nclnom1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nclnom1s
            .Top           = 192
            .Left          = 233
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *======== COLUNA DIREITA ========

        *-- 5. Cidade
        loc_oPg2.AddObject("lbl_4c_Cidade", "Label")
        WITH loc_oPg2.lbl_4c_Cidade
            .Caption   = "Cidade"
            .Top       = 78
            .Left      = 349
            .Width     = 31
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nlicid1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nlicid1s
            .Top           = 90
            .Left          = 349
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_XCidad", "Label")
        WITH loc_oPg2.lbl_4c_XCidad
            .Caption   = "x"
            .Top       = 92
            .Left      = 393
            .Width     = 6
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nclcid1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nclcid1s
            .Top           = 90
            .Left          = 398
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 6. Dia
        loc_oPg2.AddObject("lbl_4c_Dia", "Label")
        WITH loc_oPg2.lbl_4c_Dia
            .Caption   = "Dia"
            .Top       = 110
            .Left      = 348
            .Width     = 16
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nlidia1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nlidia1s
            .Top           = 121
            .Left          = 349
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_XDia", "Label")
        WITH loc_oPg2.lbl_4c_XDia
            .Caption   = "x"
            .Top       = 123
            .Left      = 393
            .Width     = 6
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Ncldia1s", "TextBox")
        WITH loc_oPg2.txt_4c_Ncldia1s
            .Top           = 121
            .Left          = 398
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 7. Mes
        loc_oPg2.AddObject("lbl_4c_Mes", "Label")
        WITH loc_oPg2.lbl_4c_Mes
            .Caption   = "M" + CHR(234) + "s"
            .Top       = 144
            .Left      = 349
            .Width     = 19
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nlimes1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nlimes1s
            .Top           = 156
            .Left          = 349
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_XMes", "Label")
        WITH loc_oPg2.lbl_4c_XMes
            .Caption   = "x"
            .Top       = 158
            .Left      = 393
            .Width     = 6
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nclmes1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nclmes1s
            .Top           = 156
            .Left          = 398
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- 8. Ano
        loc_oPg2.AddObject("lbl_4c_Ano", "Label")
        WITH loc_oPg2.lbl_4c_Ano
            .Caption   = "Ano"
            .Top       = 180
            .Left      = 349
            .Width     = 19
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nliano1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nliano1s
            .Top           = 192
            .Left          = 349
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        loc_oPg2.AddObject("lbl_4c_XAno", "Label")
        WITH loc_oPg2.lbl_4c_XAno
            .Caption   = "x"
            .Top       = 194
            .Left      = 393
            .Width     = 6
            .Height    = 13
            .AutoSize  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 7
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPg2.AddObject("txt_4c_Nclano1s", "TextBox")
        WITH loc_oPg2.txt_4c_Nclano1s
            .Top           = 192
            .Left          = 400
            .Width         = 41
            .Height        = 18
            .BackStyle     = 0
            .SpecialEffect = 1
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Format        = "K"
            .InputMask     = "999.99"
            .Margin        = 0
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPg2)
    ENDPROC

    *==========================================================================
    * CarregarLista - Carrega dados no cursor_4c_Dados e vincula ao grid
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            IF !THIS.this_oBusinessObject.Buscar("")
                loc_lSucesso = .F.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                *-- RecordSource e ColumnCount FORA do WITH (Problema 36)
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                *-- ControlSources APOS RecordSource (Problema 32 - headers resetados)
                loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.impres"
                loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.maxcols"

                *-- Larguras e headers APOS ControlSource (OBRIGATORIO)
                loc_oGrid.Column1.Width           = 280
                loc_oGrid.Column1.Header1.Caption = "Impressoras"
                loc_oGrid.Column2.Width           = 130
                loc_oGrid.Column2.Header1.Caption = "M" + CHR(225) + "ximo de Colunas"

                THIS.FormatarGridLista(loc_oGrid)
                loc_oGrid.Refresh()
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormImp.CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lSucesso = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina

                IF par_nPagina = 1
                    THIS.this_cModoAtual = "LISTA"
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormImp.AlternarPagina")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Handlers dos botoes da Page1 (PUBLIC - BINDEVENT exige PUBLIC)
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2
        THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cImpres
        loc_cImpres = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cImpres = ALLTRIM(cursor_4c_Dados.impres)
        ENDIF

        IF EMPTY(loc_cImpres)
            MsgAviso("Selecione uma impressora na lista.", "Visualizar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImpres)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Visualizar")
        ENDIF
    ENDPROC

    PROCEDURE BtnAlterarClick()
        LOCAL loc_cImpres
        loc_cImpres = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cImpres = ALLTRIM(cursor_4c_Dados.impres)
        ENDIF

        IF EMPTY(loc_cImpres)
            MsgAviso("Selecione uma impressora na lista.", "Alterar")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImpres)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
        ELSE
            MsgAviso("Registro n" + CHR(227) + "o encontrado.", "Alterar")
        ENDIF
    ENDPROC

    PROCEDURE BtnExcluirClick()
        LOCAL loc_cImpres, loc_lConfirmado
        loc_cImpres     = ""
        loc_lConfirmado = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cImpres = ALLTRIM(cursor_4c_Dados.impres)
        ENDIF

        IF EMPTY(loc_cImpres)
            MsgAviso("Selecione uma impressora na lista.", "Excluir")
            RETURN
        ENDIF

        loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o da impressora '" + ;
            loc_cImpres + "'?", "Excluir")

        IF loc_lConfirmado
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImpres)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Impressora exclu" + CHR(237) + "da com sucesso.", "Excluir")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cImpres
        loc_cImpres = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdmp", "cursor_4c_BuscaImp", "impres", "", ;
                "Buscar Impressora")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("impres",  "", "Impressora")
                loc_oBusca.mAddColuna("maxcols", "", "M" + CHR(225) + "x.Colunas")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaImp")
                    SELECT cursor_4c_BuscaImp
                    loc_cImpres = ALLTRIM(cursor_4c_BuscaImp.impres)
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormImp.BtnBuscarClick")
        ENDTRY

        IF USED("cursor_4c_BuscaImp")
            USE IN cursor_4c_BuscaImp
        ENDIF

        *-- Recarregar lista com filtro (ou sem filtro se nada selecionado)
        IF !EMPTY(loc_cImpres)
            THIS.this_oBusinessObject.Buscar("impres = " + EscaparSQL(loc_cImpres))
            THIS.CarregarLista()
        ENDIF
    ENDPROC

    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * Handlers dos botoes da Page2 (PUBLIC - BINDEVENT exige PUBLIC)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPg1
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *-- Validacoes FORA do TRY (RETURN funciona fora de TRY - CLAUDE.md regra)
        IF EMPTY(ALLTRIM(loc_oPg1.txt_4c_Impres.Value))
            MsgAviso("Impressora inv" + CHR(225) + "lida. Informe o nome da impressora.", "Salvar")
            loc_oPg1.txt_4c_Impres.SetFocus
            RETURN
        ENDIF

        *-- Verificar duplicata somente no modo INCLUIR
        IF THIS.this_cModoAtual = "INCLUIR"
            IF THIS.this_oBusinessObject.VerificarImpressoraExistente(;
                    ALLTRIM(loc_oPg1.txt_4c_Impres.Value))
                MsgAviso("Impressora j" + CHR(225) + " cadastrada!", "Salvar")
                loc_oPg1.txt_4c_Impres.SetFocus
                RETURN
            ENDIF
        ENDIF

        *-- Se cheque desabilitado, zerar campos de posicionamento (logica Salva.Click legado)
        IF loc_oPg1.chk_4c_Chqf.Value = 0
            LOCAL loc_oPg2
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
            loc_oPg2.txt_4c_Nlivl1s.Value   = 0
            loc_oPg2.txt_4c_Nclvl1s.Value   = 0
            loc_oPg2.txt_4c_Nlivext1s.Value = 0
            loc_oPg2.txt_4c_Nclvext1s.Value = 0
            loc_oPg2.txt_4c_Nlivext2s.Value = 0
            loc_oPg2.txt_4c_Nclvext2s.Value = 0
            loc_oPg2.txt_4c_Nlinom1s.Value  = 0
            loc_oPg2.txt_4c_Nclnom1s.Value  = 0
            loc_oPg2.txt_4c_Nlicid1s.Value  = 0
            loc_oPg2.txt_4c_Nclcid1s.Value  = 0
            loc_oPg2.txt_4c_Nlidia1s.Value  = 0
            loc_oPg2.txt_4c_Ncldia1s.Value  = 0
            loc_oPg2.txt_4c_Nlimes1s.Value  = 0
            loc_oPg2.txt_4c_Nclmes1s.Value  = 0
            loc_oPg2.txt_4c_Nliano1s.Value  = 0
            loc_oPg2.txt_4c_Nclano1s.Value  = 0
        ENDIF

        TRY
            THIS.FormParaBO()

            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Salvar")
                THIS.AlternarPagina(1)
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormImp.BtnSalvarClick")
        ENDTRY
    ENDPROC

    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere valores dos controles do form para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg1, loc_oPg2
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        WITH THIS.this_oBusinessObject
            *-- Page1: Dados Principais
            .this_cImpres     = ALLTRIM(loc_oPg1.txt_4c_Impres.Value)
            .this_nMaxcols    = loc_oPg1.txt_4c_Maxcols.Value
            .this_nTitulos    = loc_oPg1.txt_4c_Titulos.Value
            .this_nBarras     = loc_oPg1.txt_4c_Barras.Value
            .this_nRates      = loc_oPg1.txt_4c_Rates.Value
            .this_lGraficos   = (loc_oPg1.chk_4c_Graficos.Value = 1)
            .this_cTipos      = ALLTRIM(loc_oPg1.cbo_4c_Tipos.Value)
            .this_nTpImpres   = loc_oPg1.opt_4c_TpImpres.Value
            .this_cExpds      = loc_oPg1.edt_4c_Expds.Value
            .this_cExpas      = loc_oPg1.edt_4c_Expas.Value
            .this_cFontes     = loc_oPg1.edt_4c_Fontes.Value
            .this_cFonte2s    = loc_oPg1.edt_4c_Fonte2s.Value
            .this_cBarcmds    = loc_oPg1.edt_4c_Barcmds.Value
            .this_cFontemp1s  = loc_oPg1.edt_4c_Fontemp1s.Value
            .this_lChkChqf    = (loc_oPg1.chk_4c_Chqf.Value = 1)
            .this_nImpEtis    = loc_oPg1.opt_4c_ImpEtis.Value
            .this_cCetiquetas = ALLTRIM(loc_oPg1.cbo_4c_Cetiquetas.Value)
            .this_lExps       = (loc_oPg1.chk_4c_Exps.Value = 1)
            .this_nAjVerts    = loc_oPg1.spn_4c_AjVerts.Value
            .this_nAjHorzs    = loc_oPg1.spn_4c_AjHorzs.Value
            .this_nAjDens     = loc_oPg1.spn_4c_AjDens.Value
            .this_nAjVelos    = loc_oPg1.spn_4c_AjVelos.Value

            *-- Page2: Posicoes de cheque
            .this_nNlivl1s    = loc_oPg2.txt_4c_Nlivl1s.Value
            .this_nNclvl1s    = loc_oPg2.txt_4c_Nclvl1s.Value
            .this_nNlivext1s  = loc_oPg2.txt_4c_Nlivext1s.Value
            .this_nNclvext1s  = loc_oPg2.txt_4c_Nclvext1s.Value
            .this_nNlivext2s  = loc_oPg2.txt_4c_Nlivext2s.Value
            .this_nNclvext2s  = loc_oPg2.txt_4c_Nclvext2s.Value
            .this_nNlinom1s   = loc_oPg2.txt_4c_Nlinom1s.Value
            .this_nNclnom1s   = loc_oPg2.txt_4c_Nclnom1s.Value
            .this_nNlicid1s   = loc_oPg2.txt_4c_Nlicid1s.Value
            .this_nNclcid1s   = loc_oPg2.txt_4c_Nclcid1s.Value
            .this_nNlidia1s   = loc_oPg2.txt_4c_Nlidia1s.Value
            .this_nNcldia1s   = loc_oPg2.txt_4c_Ncldia1s.Value
            .this_nNlimes1s   = loc_oPg2.txt_4c_Nlimes1s.Value
            .this_nNclmes1s   = loc_oPg2.txt_4c_Nclmes1s.Value
            .this_nNliano1s   = loc_oPg2.txt_4c_Nliano1s.Value
            .this_nNclano1s   = loc_oPg2.txt_4c_Nclano1s.Value
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere valores do BO para os controles do form
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg1, loc_oPg2
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        WITH THIS.this_oBusinessObject
            *-- Page1: Dados Principais
            loc_oPg1.txt_4c_Impres.Value     = .this_cImpres
            loc_oPg1.txt_4c_Maxcols.Value    = .this_nMaxcols
            loc_oPg1.txt_4c_Titulos.Value    = .this_nTitulos
            loc_oPg1.txt_4c_Barras.Value     = .this_nBarras
            loc_oPg1.txt_4c_Rates.Value      = .this_nRates
            loc_oPg1.chk_4c_Graficos.Value   = IIF(.this_lGraficos, 1, 0)
            loc_oPg1.cbo_4c_Tipos.Value      = .this_cTipos
            loc_oPg1.opt_4c_TpImpres.Value   = IIF(.this_nTpImpres > 0, .this_nTpImpres, 1)
            loc_oPg1.edt_4c_Expds.Value      = .this_cExpds
            loc_oPg1.edt_4c_Expas.Value      = .this_cExpas
            loc_oPg1.edt_4c_Fontes.Value     = .this_cFontes
            loc_oPg1.edt_4c_Fonte2s.Value    = .this_cFonte2s
            loc_oPg1.edt_4c_Barcmds.Value    = .this_cBarcmds
            loc_oPg1.edt_4c_Fontemp1s.Value  = .this_cFontemp1s
            loc_oPg1.chk_4c_Chqf.Value       = IIF(.this_lChkChqf, 1, 0)
            loc_oPg1.opt_4c_ImpEtis.Value    = IIF(.this_nImpEtis > 0, .this_nImpEtis, 1)
            loc_oPg1.cbo_4c_Cetiquetas.Value = .this_cCetiquetas
            loc_oPg1.chk_4c_Exps.Value       = IIF(.this_lExps, 1, 0)
            loc_oPg1.spn_4c_AjVerts.Value    = .this_nAjVerts
            loc_oPg1.spn_4c_AjHorzs.Value    = .this_nAjHorzs
            loc_oPg1.spn_4c_AjDens.Value     = .this_nAjDens
            loc_oPg1.spn_4c_AjVelos.Value    = .this_nAjVelos

            *-- Habilitar Page2 apenas se chkChqf=1 E estamos em modo de edicao
            THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Enabled = ;
                .this_lChkChqf AND INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

            *-- Page2: Posicoes de cheque
            loc_oPg2.txt_4c_Nlivl1s.Value    = .this_nNlivl1s
            loc_oPg2.txt_4c_Nclvl1s.Value    = .this_nNclvl1s
            loc_oPg2.txt_4c_Nlivext1s.Value  = .this_nNlivext1s
            loc_oPg2.txt_4c_Nclvext1s.Value  = .this_nNclvext1s
            loc_oPg2.txt_4c_Nlivext2s.Value  = .this_nNlivext2s
            loc_oPg2.txt_4c_Nclvext2s.Value  = .this_nNclvext2s
            loc_oPg2.txt_4c_Nlinom1s.Value   = .this_nNlinom1s
            loc_oPg2.txt_4c_Nclnom1s.Value   = .this_nNclnom1s
            loc_oPg2.txt_4c_Nlicid1s.Value   = .this_nNlicid1s
            loc_oPg2.txt_4c_Nclcid1s.Value   = .this_nNclcid1s
            loc_oPg2.txt_4c_Nlidia1s.Value   = .this_nNlidia1s
            loc_oPg2.txt_4c_Ncldia1s.Value   = .this_nNcldia1s
            loc_oPg2.txt_4c_Nlimes1s.Value   = .this_nNlimes1s
            loc_oPg2.txt_4c_Nclmes1s.Value   = .this_nNclmes1s
            loc_oPg2.txt_4c_Nliano1s.Value   = .this_nNliano1s
            loc_oPg2.txt_4c_Nclano1s.Value   = .this_nNclano1s
        ENDWITH
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos do formulario (modo INCLUIR)
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg1, loc_oPg2
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2

        *-- Page1
        loc_oPg1.txt_4c_Impres.Value     = ""
        loc_oPg1.txt_4c_Maxcols.Value    = 0
        loc_oPg1.txt_4c_Titulos.Value    = 0
        loc_oPg1.txt_4c_Barras.Value     = 0
        loc_oPg1.txt_4c_Rates.Value      = 0
        loc_oPg1.chk_4c_Graficos.Value   = 0
        loc_oPg1.cbo_4c_Tipos.Value      = ""
        loc_oPg1.opt_4c_TpImpres.Value   = 1
        loc_oPg1.edt_4c_Expds.Value      = ""
        loc_oPg1.edt_4c_Expas.Value      = ""
        loc_oPg1.edt_4c_Fontes.Value     = ""
        loc_oPg1.edt_4c_Fonte2s.Value    = ""
        loc_oPg1.edt_4c_Barcmds.Value    = ""
        loc_oPg1.edt_4c_Fontemp1s.Value  = ""
        loc_oPg1.chk_4c_Chqf.Value       = 0
        loc_oPg1.opt_4c_ImpEtis.Value    = 1
        loc_oPg1.cbo_4c_Cetiquetas.Value = ""
        loc_oPg1.chk_4c_Exps.Value       = 0
        loc_oPg1.spn_4c_AjVerts.Value    = 0
        loc_oPg1.spn_4c_AjHorzs.Value    = 0
        loc_oPg1.spn_4c_AjDens.Value     = 0
        loc_oPg1.spn_4c_AjVelos.Value    = 0

        THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Enabled = .F.

        *-- Page2
        loc_oPg2.txt_4c_Nlivl1s.Value    = 0
        loc_oPg2.txt_4c_Nclvl1s.Value    = 0
        loc_oPg2.txt_4c_Nlivext1s.Value  = 0
        loc_oPg2.txt_4c_Nclvext1s.Value  = 0
        loc_oPg2.txt_4c_Nlivext2s.Value  = 0
        loc_oPg2.txt_4c_Nclvext2s.Value  = 0
        loc_oPg2.txt_4c_Nlinom1s.Value   = 0
        loc_oPg2.txt_4c_Nclnom1s.Value   = 0
        loc_oPg2.txt_4c_Nlicid1s.Value   = 0
        loc_oPg2.txt_4c_Nclcid1s.Value   = 0
        loc_oPg2.txt_4c_Nlidia1s.Value   = 0
        loc_oPg2.txt_4c_Ncldia1s.Value   = 0
        loc_oPg2.txt_4c_Nlimes1s.Value   = 0
        loc_oPg2.txt_4c_Nclmes1s.Value   = 0
        loc_oPg2.txt_4c_Nliano1s.Value   = 0
        loc_oPg2.txt_4c_Nclano1s.Value   = 0
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita campos conforme modo
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg1, loc_lEditavel
        loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1

        *-- txtImpres: editavel apenas em INSERIR/PROCURAR (nao em ALTERAR/VISUALIZAR)
        loc_lEditavel = (THIS.this_cModoAtual = "INCLUIR")
        loc_oPg1.txt_4c_Impres.Enabled    = loc_lEditavel

        *-- Demais campos: editaveis se par_lHabilitar (INCLUIR/ALTERAR)
        loc_oPg1.txt_4c_Maxcols.Enabled   = par_lHabilitar
        loc_oPg1.txt_4c_Titulos.Enabled   = par_lHabilitar
        loc_oPg1.txt_4c_Barras.Enabled    = par_lHabilitar
        loc_oPg1.txt_4c_Rates.Enabled     = par_lHabilitar
        loc_oPg1.chk_4c_Graficos.Enabled  = par_lHabilitar
        loc_oPg1.cbo_4c_Tipos.Enabled     = par_lHabilitar
        loc_oPg1.opt_4c_TpImpres.Enabled  = par_lHabilitar
        loc_oPg1.edt_4c_Expds.Enabled     = par_lHabilitar
        loc_oPg1.edt_4c_Expas.Enabled     = par_lHabilitar
        loc_oPg1.edt_4c_Fontes.Enabled    = par_lHabilitar
        loc_oPg1.edt_4c_Fonte2s.Enabled   = par_lHabilitar
        loc_oPg1.edt_4c_Barcmds.Enabled   = par_lHabilitar
        loc_oPg1.edt_4c_Fontemp1s.Enabled = par_lHabilitar
        loc_oPg1.chk_4c_Chqf.Enabled      = par_lHabilitar
        loc_oPg1.opt_4c_ImpEtis.Enabled   = par_lHabilitar
        loc_oPg1.cbo_4c_Cetiquetas.Enabled = par_lHabilitar
        loc_oPg1.chk_4c_Exps.Enabled      = par_lHabilitar
        loc_oPg1.spn_4c_AjVerts.Enabled   = par_lHabilitar
        loc_oPg1.spn_4c_AjHorzs.Enabled   = par_lHabilitar
        loc_oPg1.spn_4c_AjDens.Enabled    = par_lHabilitar
        loc_oPg1.spn_4c_AjVelos.Enabled   = par_lHabilitar
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 conforme modo
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oCnt, loc_lEditando
        loc_oCnt     = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
        loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lEditando
        loc_oCnt.cmd_4c_Cancelar.Enabled  = .T.
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
            IF USED("cursor_4c_BuscaImp")
                USE IN cursor_4c_BuscaImp
            ENDIF
            IF USED("crSigCdTpe")
                USE IN crSigCdTpe
            ENDIF
            DODEFAULT()
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "FormImp.Destroy")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    *==========================================================================
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

    *==========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ImpBO.prg):
*==============================================================================
* ImpBO.prg - Business Object para Cadastro de Impressoras
* Tabela: SigCdmp
* Migrado de: SIGCDIMP.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS ImpBO AS BusinessBase

    *-- Identificacao
    this_cImpres    = ""    && Impressora (C30) - PK visivel
    this_cIdChaves  = ""    && Chave interna do framework (C)

    *-- Dados principais (pg1)
    this_nRates     = 0     && Rate
    this_nTitulos   = 0     && Titulo (linhas por pagina)
    this_nBarras    = 0     && Barra (cpi)
    this_nMaxcols   = 0     && Maximo de Colunas

    *-- Checkboxes
    this_lExps      = .F.   && Expandido
    this_lGraficos  = .F.   && Graficos habilitado
    this_lChkChqf   = .F.   && Cheque Formulario Continuo

    *-- OptionGroups
    this_nTpImpres  = 0     && Tipo de Impressora (1=Boleto, 2=Etiqueta, 3=Boleto Zebra, 4=Padrao)
    this_nImpEtis   = 0     && Tipo Etiqueta (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)

    *-- Tipo grafico e etiqueta padrao
    this_cTipos         = ""    && Tipo de Grafico (C - dropdown: Epson Esc K, Epson Esc * m n, Mecaf)
    this_cCetiquetas    = ""    && Etiqueta Padrao (C - vem de SigCdTpe.Cetiquetas)

    *-- Ajustes de etiqueta
    this_nAjVerts   = 0     && Ajuste Vertical (0-999)
    this_nAjHorzs   = 0     && Ajuste Horizontal (0-9999)
    this_nAjVelos   = 3     && Velocidade (1-3, default 3)
    this_nAjDens    = 20    && Densidade (10-20, default 20)

    *-- Comandos de controle (M - memo/editbox)
    this_cExpds     = ""    && Desativar Negrito
    this_cExpas     = ""    && Ativar Negrito
    this_cBarcmds   = ""    && Codigo de Barras
    this_cFontes    = ""    && Inicializacao
    this_cFonte2s   = ""    && Ativar Fonte Pequena
    this_cFontemp1s = ""    && Aciona Guilhotina

    *-- Posicionamento cheque (pg2) - coordenadas linha/coluna
    *-- Valor em Numeros
    this_nNlivl1s   = 0     && Linha
    this_nNclvl1s   = 0     && Coluna

    *-- Valor por Extenso (1a Linha)
    this_nNlivext1s = 0     && Linha
    this_nNclvext1s = 0     && Coluna

    *-- Valor por Extenso (2a Linha)
    this_nNlivext2s = 0     && Linha
    this_nNclvext2s = 0     && Coluna

    *-- Favorecido
    this_nNlinom1s  = 0     && Linha
    this_nNclnom1s  = 0     && Coluna

    *-- Cidade
    this_nNlicid1s  = 0     && Linha
    this_nNclcid1s  = 0     && Coluna

    *-- Dia
    this_nNlidia1s  = 0     && Linha
    this_nNcldia1s  = 0     && Coluna

    *-- Mes
    this_nNlimes1s  = 0     && Linha
    this_nNclmes1s  = 0     && Coluna

    *-- Ano
    this_nNliano1s  = 0     && Linha
    this_nNclano1s  = 0     && Coluna

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdmp"
        THIS.this_cCampoChave  = "Impres"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cImpres
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cImpres      = TratarNulo(impres,     "C")
                THIS.this_cIdChaves    = TratarNulo(cIdChaves,  "C")
                THIS.this_nRates       = TratarNulo(rates,      "N")
                THIS.this_nTitulos     = TratarNulo(titulos,    "N")
                THIS.this_nBarras      = TratarNulo(barras,     "N")
                THIS.this_nMaxcols     = TratarNulo(maxcols,    "N")
                THIS.this_lExps        = (TratarNulo(exps,      "N") = 1)
                THIS.this_lGraficos    = (TratarNulo(graficos,  "N") = 1)
                THIS.this_lChkChqf     = (TratarNulo(nchqfs,    "N") = 1)
                THIS.this_nTpImpres    = TratarNulo(nTpImpres,  "N")
                THIS.this_nImpEtis     = TratarNulo(ImpEtis,    "N")
                THIS.this_cTipos       = TratarNulo(Tipos,      "C")
                THIS.this_cCetiquetas  = TratarNulo(cetiquetas, "C")
                THIS.this_nAjVerts     = TratarNulo(AjVerts,    "N")
                THIS.this_nAjHorzs     = TratarNulo(AjHorzs,    "N")
                THIS.this_nAjVelos     = TratarNulo(AjVelos,    "N")
                THIS.this_nAjDens      = TratarNulo(AjDens,     "N")
                THIS.this_cExpds       = TratarNulo(expds,      "C")
                THIS.this_cExpas       = TratarNulo(expas,      "C")
                THIS.this_cBarcmds     = TratarNulo(barcmds,    "C")
                THIS.this_cFontes      = TratarNulo(fontes,     "C")
                THIS.this_cFonte2s     = TratarNulo(fonte2s,    "C")
                THIS.this_cFontemp1s   = TratarNulo(fontemp1s,  "C")
                THIS.this_nNlivl1s     = TratarNulo(nlivl1s,    "N")
                THIS.this_nNclvl1s     = TratarNulo(nclvl1s,    "N")
                THIS.this_nNlivext1s   = TratarNulo(nlivext1s,  "N")
                THIS.this_nNclvext1s   = TratarNulo(nclvext1s,  "N")
                THIS.this_nNlivext2s   = TratarNulo(nlivext2s,  "N")
                THIS.this_nNclvext2s   = TratarNulo(nclvext2s,  "N")
                THIS.this_nNlinom1s    = TratarNulo(nlinom1s,   "N")
                THIS.this_nNclnom1s    = TratarNulo(nclnom1s,   "N")
                THIS.this_nNlicid1s    = TratarNulo(nlicid1s,   "N")
                THIS.this_nNclcid1s    = TratarNulo(nclcid1s,   "N")
                THIS.this_nNlidia1s    = TratarNulo(nlidia1s,   "N")
                THIS.this_nNcldia1s    = TratarNulo(ncldia1s,   "N")
                THIS.this_nNlimes1s    = TratarNulo(nlimes1s,   "N")
                THIS.this_nNclmes1s    = TratarNulo(nclmes1s,   "N")
                THIS.this_nNliano1s    = TratarNulo(nliano1s,   "N")
                THIS.this_nNclano1s    = TratarNulo(nclano1s,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "ImpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cImpres))
            MsgAviso("Impressora n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarImpressoraExistente(THIS.this_cImpres)
                MsgAviso("Impressora j" + CHR(225) + " cadastrada!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarImpressoraExistente - Verifica se Impres ja existe
    *====================================================================
    PROCEDURE VerificarImpressoraExistente(par_cImpres)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdmp WHERE impres = " + ;
                EscaparSQL(par_cImpres)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkImp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkImp")
                SELECT cursor_4c_ChkImp
                loc_lExiste = (cursor_4c_ChkImp.qtd > 0)
                USE IN cursor_4c_ChkImp
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar impressora:" + CHR(13) + loException.Message, "ImpBO.VerificarImpressoraExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdmp
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChave
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cChave = fUniqueIds()
            THIS.this_cIdChaves = loc_cChave

            loc_cSQL = "INSERT INTO SigCdmp (impres, cIdChaves, rates, titulos, barras, maxcols," + ;
                " exps, graficos, nchqfs, nTpImpres, ImpEtis, Tipos, cetiquetas," + ;
                " AjVerts, AjHorzs, AjVelos, AjDens," + ;
                " expds, expas, barcmds, fontes, fonte2s, fontemp1s," + ;
                " nlivl1s, nclvl1s, nlivext1s, nclvext1s, nlivext2s, nclvext2s," + ;
                " nlinom1s, nclnom1s, nlicid1s, nclcid1s," + ;
                " nlidia1s, ncldia1s, nlimes1s, nclmes1s, nliano1s, nclano1s)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cImpres) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRates,   0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTitulos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBarras,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMaxcols, 0) + ", " + ;
                IIF(THIS.this_lExps,     "1", "0") + ", " + ;
                IIF(THIS.this_lGraficos, "1", "0") + ", " + ;
                IIF(THIS.this_lChkChqf,  "1", "0") + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpImpres, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpEtis,   0) + ", " + ;
                EscaparSQL(THIS.this_cTipos) + ", " + ;
                EscaparSQL(THIS.this_cCetiquetas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjVerts, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjHorzs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjVelos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjDens,  0) + ", " + ;
                EscaparSQL(THIS.this_cExpds) + ", " + ;
                EscaparSQL(THIS.this_cExpas) + ", " + ;
                EscaparSQL(THIS.this_cBarcmds) + ", " + ;
                EscaparSQL(THIS.this_cFontes) + ", " + ;
                EscaparSQL(THIS.this_cFonte2s) + ", " + ;
                EscaparSQL(THIS.this_cFontemp1s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlivl1s,   0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclvl1s,   0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlivext1s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclvext1s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlivext2s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclvext2s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlinom1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclnom1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlicid1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclcid1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlidia1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcldia1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlimes1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclmes1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNliano1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclano1s,  0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "ImpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdmp
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdmp SET" + ;
                " rates    = " + FormatarNumeroSQL(THIS.this_nRates,   0) + "," + ;
                " titulos  = " + FormatarNumeroSQL(THIS.this_nTitulos, 0) + "," + ;
                " barras   = " + FormatarNumeroSQL(THIS.this_nBarras,  0) + "," + ;
                " maxcols  = " + FormatarNumeroSQL(THIS.this_nMaxcols, 0) + "," + ;
                " exps     = " + IIF(THIS.this_lExps,     "1", "0") + "," + ;
                " graficos = " + IIF(THIS.this_lGraficos, "1", "0") + "," + ;
                " nchqfs   = " + IIF(THIS.this_lChkChqf,  "1", "0") + "," + ;
                " nTpImpres = " + FormatarNumeroSQL(THIS.this_nTpImpres, 0) + "," + ;
                " ImpEtis  = " + FormatarNumeroSQL(THIS.this_nImpEtis,   0) + "," + ;
                " Tipos    = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                " cetiquetas = " + EscaparSQL(THIS.this_cCetiquetas) + "," + ;
                " AjVerts  = " + FormatarNumeroSQL(THIS.this_nAjVerts, 0) + "," + ;
                " AjHorzs  = " + FormatarNumeroSQL(THIS.this_nAjHorzs, 0) + "," + ;
                " AjVelos  = " + FormatarNumeroSQL(THIS.this_nAjVelos, 0) + "," + ;
                " AjDens   = " + FormatarNumeroSQL(THIS.this_nAjDens,  0) + "," + ;
                " expds    = " + EscaparSQL(THIS.this_cExpds) + "," + ;
                " expas    = " + EscaparSQL(THIS.this_cExpas) + "," + ;
                " barcmds  = " + EscaparSQL(THIS.this_cBarcmds) + "," + ;
                " fontes   = " + EscaparSQL(THIS.this_cFontes) + "," + ;
                " fonte2s  = " + EscaparSQL(THIS.this_cFonte2s) + "," + ;
                " fontemp1s = " + EscaparSQL(THIS.this_cFontemp1s) + "," + ;
                " nlivl1s  = " + FormatarNumeroSQL(THIS.this_nNlivl1s,   0) + "," + ;
                " nclvl1s  = " + FormatarNumeroSQL(THIS.this_nNclvl1s,   0) + "," + ;
                " nlivext1s = " + FormatarNumeroSQL(THIS.this_nNlivext1s, 0) + "," + ;
                " nclvext1s = " + FormatarNumeroSQL(THIS.this_nNclvext1s, 0) + "," + ;
                " nlivext2s = " + FormatarNumeroSQL(THIS.this_nNlivext2s, 0) + "," + ;
                " nclvext2s = " + FormatarNumeroSQL(THIS.this_nNclvext2s, 0) + "," + ;
                " nlinom1s = " + FormatarNumeroSQL(THIS.this_nNlinom1s,  0) + "," + ;
                " nclnom1s = " + FormatarNumeroSQL(THIS.this_nNclnom1s,  0) + "," + ;
                " nlicid1s = " + FormatarNumeroSQL(THIS.this_nNlicid1s,  0) + "," + ;
                " nclcid1s = " + FormatarNumeroSQL(THIS.this_nNclcid1s,  0) + "," + ;
                " nlidia1s = " + FormatarNumeroSQL(THIS.this_nNlidia1s,  0) + "," + ;
                " ncldia1s = " + FormatarNumeroSQL(THIS.this_nNcldia1s,  0) + "," + ;
                " nlimes1s = " + FormatarNumeroSQL(THIS.this_nNlimes1s,  0) + "," + ;
                " nclmes1s = " + FormatarNumeroSQL(THIS.this_nNclmes1s,  0) + "," + ;
                " nliano1s = " + FormatarNumeroSQL(THIS.this_nNliano1s,  0) + "," + ;
                " nclano1s = " + FormatarNumeroSQL(THIS.this_nNclano1s,  0) + ;
                " WHERE impres = " + EscaparSQL(THIS.this_cImpres)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "ImpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdmp
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCdmp WHERE impres = " + EscaparSQL(THIS.this_cImpres)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "ImpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros para o grid da lista
    * Retorna cursor_4c_Dados com impres e maxcols
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (impres C(40), maxcols N(5,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT impres, maxcols FROM SigCdmp"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY impres"

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
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar impressoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar impressoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "ImpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro completo pela chave primaria
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cImpres)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT impres, cIdChaves, rates, titulos, barras, maxcols," + ;
                " exps, graficos, nchqfs, nTpImpres, ImpEtis, Tipos, cetiquetas," + ;
                " AjVerts, AjHorzs, AjVelos, AjDens," + ;
                " expds, expas, barcmds, fontes, fonte2s, fontemp1s," + ;
                " nlivl1s, nclvl1s, nlivext1s, nclvext1s, nlivext2s, nclvext2s," + ;
                " nlinom1s, nclnom1s, nlicid1s, nclcid1s," + ;
                " nlidia1s, ncldia1s, nlimes1s, nclmes1s, nliano1s, nclano1s" + ;
                " FROM SigCdmp WHERE impres = " + EscaparSQL(par_cImpres)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Impressora n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "ImpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarTiposEtiqueta - Carrega cursor crSigCdTpe (writable) para combo etiqueta
    * Fonte: SigCdTpe WHERE nSituas=1, acrescenta linha em branco no topo
    *====================================================================
    PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("crSigCdTpe")
                USE IN crSigCdTpe
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                CREATE CURSOR crSigCdTpe (Cetiquetas C(100), nTipos N(5,0))
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT Cetiquetas, nTipos FROM SigCdTpe WHERE nSituas = 1"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdTpeTmp")

                IF loc_nResultado >= 0
                    CREATE CURSOR crSigCdTpe (Cetiquetas C(100), nTipos N(5,0))
                    IF USED("crSigCdTpeTmp")
                        APPEND FROM DBF("crSigCdTpeTmp")
                        USE IN crSigCdTpeTmp
                    ENDIF
                    APPEND BLANK
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao carregar tipos de etiqueta:" + CHR(13) + CapturarErroSQL(), "ImpBO.CarregarTiposEtiqueta")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar tipos de etiqueta:" + CHR(13) + loException.Message, "ImpBO.CarregarTiposEtiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

