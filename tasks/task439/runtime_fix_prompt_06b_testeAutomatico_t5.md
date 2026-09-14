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
[2026-08-07 18:33:30] [INFO] Config FPW: (nao fornecido)
[2026-08-07 18:33:31] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-07 18:33:31] [INFO] Timeout: 300 segundos
[2026-08-07 18:33:31] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2al2gwpj.prg
[2026-08-07 18:33:31] [INFO] Conteudo do wrapper:
[2026-08-07 18:33:31] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
QUIT

[2026-08-07 18:33:31] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2al2gwpj.prg
[2026-08-07 18:33:31] [INFO] VFP output esperado em: C:\4c\tasks\task439\vfp_output.txt
[2026-08-07 18:33:31] [INFO] Executando Visual FoxPro 9...
[2026-08-07 18:33:31] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2al2gwpj.prg
[2026-08-07 18:33:31] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2al2gwpj.prg
[2026-08-07 18:33:31] [INFO] Timeout configurado: 300 segundos
[2026-08-07 18:38:31] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 12408)...
[2026-08-07 18:38:33] [INFO] VFP9 finalizado em 302.0700832 segundos
[2026-08-07 18:38:33] [INFO] Exit Code: 4
[2026-08-07 18:38:33] [INFO] 
[2026-08-07 18:38:33] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-07 18:38:33] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2al2gwpj.prg
[2026-08-07 18:38:33] [INFO] 
[2026-08-07 18:38:33] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-07 18:38:33] [INFO] * Auto-generated wrapper for parameters
[2026-08-07 18:38:33] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-07 18:38:33] [INFO] * Parameters: 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
[2026-08-07 18:38:33] [INFO] 
[2026-08-07 18:38:33] [INFO] * Anti-dialog protections for unattended execution
[2026-08-07 18:38:33] [INFO] SET SAFETY OFF
[2026-08-07 18:38:33] [INFO] SET RESOURCE OFF
[2026-08-07 18:38:33] [INFO] SET TALK OFF
[2026-08-07 18:38:33] [INFO] SET NOTIFY OFF
[2026-08-07 18:38:33] [INFO] SYS(2335, 0)
[2026-08-07 18:38:33] [INFO] 
[2026-08-07 18:38:33] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
[2026-08-07 18:38:33] [INFO] QUIT
[2026-08-07 18:38:33] [INFO] 
[2026-08-07 18:38:33] [INFO] === Fim do Wrapper.prg ===
[2026-08-07 18:38:33] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-07 19:35:20] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-07 19:35:20] [INFO] Config FPW: (nao fornecido)
[2026-08-07 19:35:20] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-07 19:35:20] [INFO] Timeout: 300 segundos
[2026-08-07 19:35:20] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_polexjxm.prg
[2026-08-07 19:35:20] [INFO] Conteudo do wrapper:
[2026-08-07 19:35:20] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
QUIT

[2026-08-07 19:35:20] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_polexjxm.prg
[2026-08-07 19:35:20] [INFO] VFP output esperado em: C:\4c\tasks\task439\vfp_output.txt
[2026-08-07 19:35:20] [INFO] Executando Visual FoxPro 9...
[2026-08-07 19:35:21] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_polexjxm.prg
[2026-08-07 19:35:21] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_polexjxm.prg
[2026-08-07 19:35:21] [INFO] Timeout configurado: 300 segundos
[2026-08-07 19:40:21] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 2188)...
[2026-08-07 19:40:23] [INFO] VFP9 finalizado em 302.0856315 segundos
[2026-08-07 19:40:23] [INFO] Exit Code: 4
[2026-08-07 19:40:23] [INFO] 
[2026-08-07 19:40:23] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-07 19:40:23] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_polexjxm.prg
[2026-08-07 19:40:23] [INFO] 
[2026-08-07 19:40:23] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-07 19:40:23] [INFO] * Auto-generated wrapper for parameters
[2026-08-07 19:40:23] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-07 19:40:23] [INFO] * Parameters: 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
[2026-08-07 19:40:23] [INFO] 
[2026-08-07 19:40:23] [INFO] * Anti-dialog protections for unattended execution
[2026-08-07 19:40:23] [INFO] SET SAFETY OFF
[2026-08-07 19:40:23] [INFO] SET RESOURCE OFF
[2026-08-07 19:40:23] [INFO] SET TALK OFF
[2026-08-07 19:40:23] [INFO] SET NOTIFY OFF
[2026-08-07 19:40:23] [INFO] SYS(2335, 0)
[2026-08-07 19:40:23] [INFO] 
[2026-08-07 19:40:23] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
[2026-08-07 19:40:23] [INFO] QUIT
[2026-08-07 19:40:23] [INFO] 
[2026-08-07 19:40:23] [INFO] === Fim do Wrapper.prg ===
[2026-08-07 19:40:23] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-07 19:53:53] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-07 19:53:53] [INFO] Config FPW: (nao fornecido)
[2026-08-07 19:53:53] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-07 19:53:53] [INFO] Timeout: 300 segundos
[2026-08-07 19:53:53] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ucsva01f.prg
[2026-08-07 19:53:53] [INFO] Conteudo do wrapper:
[2026-08-07 19:53:53] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
QUIT

[2026-08-07 19:53:53] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ucsva01f.prg
[2026-08-07 19:53:53] [INFO] VFP output esperado em: C:\4c\tasks\task439\vfp_output.txt
[2026-08-07 19:53:53] [INFO] Executando Visual FoxPro 9...
[2026-08-07 19:53:53] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ucsva01f.prg
[2026-08-07 19:53:53] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ucsva01f.prg
[2026-08-07 19:53:53] [INFO] Timeout configurado: 300 segundos
[2026-08-07 19:58:54] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 3440)...
[2026-08-07 19:58:56] [INFO] VFP9 finalizado em 302.1008306 segundos
[2026-08-07 19:58:56] [INFO] Exit Code: 4
[2026-08-07 19:58:56] [INFO] 
[2026-08-07 19:58:56] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-07 19:58:56] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ucsva01f.prg
[2026-08-07 19:58:56] [INFO] 
[2026-08-07 19:58:56] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-07 19:58:56] [INFO] * Auto-generated wrapper for parameters
[2026-08-07 19:58:56] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-07 19:58:56] [INFO] * Parameters: 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
[2026-08-07 19:58:56] [INFO] 
[2026-08-07 19:58:56] [INFO] * Anti-dialog protections for unattended execution
[2026-08-07 19:58:56] [INFO] SET SAFETY OFF
[2026-08-07 19:58:56] [INFO] SET RESOURCE OFF
[2026-08-07 19:58:56] [INFO] SET TALK OFF
[2026-08-07 19:58:56] [INFO] SET NOTIFY OFF
[2026-08-07 19:58:56] [INFO] SYS(2335, 0)
[2026-08-07 19:58:56] [INFO] 
[2026-08-07 19:58:56] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
[2026-08-07 19:58:56] [INFO] QUIT
[2026-08-07 19:58:56] [INFO] 
[2026-08-07 19:58:56] [INFO] === Fim do Wrapper.prg ===
[2026-08-07 19:58:56] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-07 20:04:36] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-07 20:04:36] [INFO] Config FPW: (nao fornecido)
[2026-08-07 20:04:36] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-07 20:04:36] [INFO] Timeout: 300 segundos
[2026-08-07 20:04:36] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pnv314pk.prg
[2026-08-07 20:04:36] [INFO] Conteudo do wrapper:
[2026-08-07 20:04:36] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
QUIT

[2026-08-07 20:04:36] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pnv314pk.prg
[2026-08-07 20:04:36] [INFO] VFP output esperado em: C:\4c\tasks\task439\vfp_output.txt
[2026-08-07 20:04:36] [INFO] Executando Visual FoxPro 9...
[2026-08-07 20:04:36] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pnv314pk.prg
[2026-08-07 20:04:36] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pnv314pk.prg
[2026-08-07 20:04:36] [INFO] Timeout configurado: 300 segundos
[2026-08-07 20:09:36] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 10084)...
[2026-08-07 20:09:38] [INFO] VFP9 finalizado em 302.0852672 segundos
[2026-08-07 20:09:38] [INFO] Exit Code: 4
[2026-08-07 20:09:38] [INFO] 
[2026-08-07 20:09:38] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-07 20:09:38] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pnv314pk.prg
[2026-08-07 20:09:38] [INFO] 
[2026-08-07 20:09:38] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-07 20:09:38] [INFO] * Auto-generated wrapper for parameters
[2026-08-07 20:09:38] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-07 20:09:38] [INFO] * Parameters: 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
[2026-08-07 20:09:38] [INFO] 
[2026-08-07 20:09:38] [INFO] * Anti-dialog protections for unattended execution
[2026-08-07 20:09:38] [INFO] SET SAFETY OFF
[2026-08-07 20:09:38] [INFO] SET RESOURCE OFF
[2026-08-07 20:09:38] [INFO] SET TALK OFF
[2026-08-07 20:09:38] [INFO] SET NOTIFY OFF
[2026-08-07 20:09:38] [INFO] SYS(2335, 0)
[2026-08-07 20:09:38] [INFO] 
[2026-08-07 20:09:38] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormGpe', 'C:\4c\tasks\task439', 'CRUD'
[2026-08-07 20:09:38] [INFO] QUIT
[2026-08-07 20:09:38] [INFO] 
[2026-08-07 20:09:38] [INFO] === Fim do Wrapper.prg ===
[2026-08-07 20:09:38] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\cadastros\FormGpe.prg):
* FormGpe.prg - Cadastro de Grupos Operacionais
* Migrado de: SIGCDGPE.SCX
* Tabela: SigCdGpe | PK: dgopes
* Tipo: CRUD (frmcadastro)

DEFINE CLASS FormGpe AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    Caption     = "Grupos Operacionais"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Estado atual do formulario
    this_cModoAtual = "LISTA"

    *--------------------------------------------------------------------------
    * Init - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro FormGpe.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Criacao da estrutura completa do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("GpeBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar GpeBO", "Erro")
                loc_lResultado = .F.
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .Tabs       = .F.
            .Visible    = .T.
        ENDWITH
        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista de registros)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container cabecalho cinza superior
        loc_oPagina.AddObject("cnt_4c_Sombra", "Container")
        WITH loc_oPagina.cnt_4c_Sombra
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
                .Top       = 18
                .Left      = 10
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

        *-- Container botoes CRUD (direito, fundo escuro)
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

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
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
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Alterar", "CommandButton")
            WITH .cmd_4c_Alterar
                .Caption         = "Alterar"
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
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
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Excluir", "CommandButton")
            WITH .cmd_4c_Excluir
                .Caption         = "Excluir"
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
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
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH

            .AddObject("cmd_4c_Buscar", "CommandButton")
            WITH .cmd_4c_Buscar
                .Caption         = "Buscar"
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
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
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Container saida (Encerrar) - padrao canonico
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
                .Top             = 5
                .Left            = 917
                .Width           = 90
                .Height          = 75
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .PicturePosition = 13
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Botoes auxiliares do legado: MontaLista, ImpXML, ExpXML
        *-- top=85 no legado + compensacao +29 = 114 na nova arquitetura
        loc_oPagina.AddObject("cmd_4c_MontaLista", "CommandButton")
        WITH loc_oPagina.cmd_4c_MontaLista
            .Caption         = ""
            .ToolTipText     = "Monta Lista"
            .Top             = 114
            .Left            = 587
            .Width           = 45
            .Height          = 45
            .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .PicturePosition = 4
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnImpXML
            .Caption         = ""
            .ToolTipText     = "Importar XML"
            .Top             = 114
            .Left            = 632
            .Width           = 45
            .Height          = 45
            .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .PicturePosition = 4
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnExpXML
            .Caption         = ""
            .ToolTipText     = "Exportar XML"
            .Top             = 114
            .Left            = 677
            .Width           = 45
            .Height          = 45
            .Picture         = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_32.jpg"
            .PicturePosition = 4
            .Themes          = .T.
            .Visible         = .T.
        ENDWITH

        *-- Grid de lista principal (2 colunas: dgopes, ngopes)
        *-- RecordSource e ColumnCount ANTES do WITH para garantir criacao das colunas
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oPagina.grd_4c_Lista.ColumnCount = 2
        loc_oPagina.grd_4c_Lista.RecordSource = ""

        WITH loc_oPagina.grd_4c_Lista
            .Top                = 162
            .Left               = 26
            .Width              = 880
            .Height             = 433
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

            .Column1.Width           = 750
            .Column1.Resizable       = .T.
            .Column1.Header1.Caption = "Grupo Operacional"

            .Column2.Width           = 100
            .Column2.Resizable       = .T.
            .Column2.Alignment       = 1
            .Column2.Header1.Caption = "N" + CHR(186)
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- BINDEVENTs dos botoes da Page1
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_MontaLista,               "Click", THIS, "BtnMontaListaClick")
        BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML,                "Click", THIS, "BtnImpXMLClick")
        BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML,                "Click", THIS, "BtnExpXMLClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados do registro)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container botoes Confirmar/Cancelar (topo direito)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("cmd_4c_Confirmar", "CommandButton")
            WITH .cmd_4c_Confirmar
                .Caption         = "Confirmar"
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .PicturePosition = 13
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
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
                .MousePointer    = 15
                .WordWrap        = .T.
                .Visible         = .T.
            ENDWITH
        ENDWITH

        *-- Label + TextBox: Grupo Operacional (dgopes) - Top=98+29=127
        loc_oPagina.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPagina.lbl_4c_LblGrupo
            .Caption   = "Grupo Operacional : "
            .Top       = 130
            .Left      = 69
            .Width     = 115
            .Height    = 15
            .FontBold  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Dgope", "TextBox")
        WITH loc_oPagina.txt_4c_Dgope
            .Top         = 127
            .Left        = 184
            .Width       = 150
            .Height      = 23
            .MaxLength   = 20
            .Format      = "K!"
            .FontName    = "Tahoma"
            .FontSize    = 8
            .Visible     = .T.
        ENDWITH

        *-- Label + TextBox: N° Grupo Operacional (ngopes) - readonly
        loc_oPagina.AddObject("lbl_4c_LblNumero", "Label")
        WITH loc_oPagina.lbl_4c_LblNumero
            .Caption   = "N" + CHR(176) + " Grupo Operacional : "
            .Top       = 130
            .Left      = 370
            .Width     = 131
            .Height    = 15
            .FontBold  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ngope", "TextBox")
        WITH loc_oPagina.txt_4c_Ngope
            .Top         = 127
            .Left        = 503
            .Width       = 52
            .Height      = 23
            .InputMask   = "999999"
            .ReadOnly    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(240, 240, 240)
            .Visible     = .T.
        ENDWITH

        *-- Sub-PageFrame: Configuracoes e Complementos
        *-- Top=127+29=156 (pgfDados original Top=127 + compensacao +29)
        loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
        WITH loc_oPagina.pgf_4c_Dados
            .PageCount  = 2
            .Top        = 156
            .Left       = 0
            .Width      = THIS.Width
            .Height     = 448
            .Tabs       = .T.
            .Visible    = .T.
        ENDWITH
        loc_oPagina.pgf_4c_Dados.Page1.Caption   = "Configura" + CHR(231) + CHR(245) + "es"
        loc_oPagina.pgf_4c_Dados.Page1.FontName  = "Tahoma"
        loc_oPagina.pgf_4c_Dados.Page1.FontSize  = 8
        loc_oPagina.pgf_4c_Dados.Page1.BackColor = RGB(255, 255, 255)
        loc_oPagina.pgf_4c_Dados.Page1.ForeColor = RGB(90, 90, 90)
        loc_oPagina.pgf_4c_Dados.Page2.Caption   = "Complementos"
        loc_oPagina.pgf_4c_Dados.Page2.FontName  = "Tahoma"
        loc_oPagina.pgf_4c_Dados.Page2.FontSize  = 8
        loc_oPagina.pgf_4c_Dados.Page2.BackColor = RGB(255, 255, 255)
        loc_oPagina.pgf_4c_Dados.Page2.ForeColor = RGB(90, 90, 90)

        THIS.ConfigurarPgConfig(loc_oPagina.pgf_4c_Dados.Page1)
        THIS.ConfigurarPgCompls(loc_oPagina.pgf_4c_Dados.Page2)

        THIS.TornarControlesVisiveis(loc_oPagina)

        *-- BINDEVENTs dos botoes da Page2
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
        BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.cmd_4c_Icone,    "Click", THIS, "BtnIconeClick")

        *-- BINDEVENTs para lookup dos campos de texto (Enter/Tab/F4 abre picker)
        BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Subncrs, ;
            "KeyPress", THIS, "TxtSubncrsKeyPress")
        BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Locals, ;
            "KeyPress", THIS, "TxtLocalsKeyPress")
        BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Codsegs, ;
            "KeyPress", THIS, "TxtCodegsKeyPress")

        BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Subncrs, ;
            "DblClick", THIS, "TxtSubncrsDblClick")
        BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Locals, ;
            "DblClick", THIS, "TxtLocalsDblClick")
        BINDEVENT(loc_oPagina.pgf_4c_Dados.Page2.txt_4c_Codsegs, ;
            "DblClick", THIS, "TxtCodegsDblClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgConfig - Configura aba Configuracoes (pgf_4c_Dados.Page1)
    * Coordenadas relativas a pagina (sem compensacao +29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgConfig(par_oPg)

        *-- COLUNA ESQUERDA: OptionGroups e labels (Left=167, Width=247)

        *-- Numeracao da Operacao (numopers)
        par_oPg.AddObject("lbl_4c_NumOper", "Label")
        WITH par_oPg.lbl_4c_NumOper
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Numera" + CHR(231) + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 13
            .Left      = 36
            .Width     = 128
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_NumOper", "OptionGroup")
        WITH par_oPg.opt_4c_NumOper
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 21
            .Left        = 167
            .Top         = 8
            .Width       = 247
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "No. Controle"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 79
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Caption   = "Autom" + CHR(225) + "tica"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 72
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Caption   = "Oper + No.Ctrl"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).Left      = 159
            .Buttons(3).Top       = 3
            .Buttons(3).Width     = 90
            .Buttons(3).AutoSize  = .T.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Tipo do No de Controle (ncontroles)
        par_oPg.AddObject("lbl_4c_Controle", "Label")
        WITH par_oPg.lbl_4c_Controle
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Tipo do N" + CHR(176) + " de Controle :"
            .Top       = 33
            .Left      = 46
            .Width     = 118
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Controle", "OptionGroup")
        WITH par_oPg.opt_4c_Controle
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 29
            .Width       = 247
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption      = "Empresa"
            .Buttons(1).ToolTipText  = "Tipo Espelho ( EEENNNNNN )"
            .Buttons(1).FontSize     = 8
            .Buttons(1).BackStyle    = 0
            .Buttons(1).Left         = 3
            .Buttons(1).Top          = 3
            .Buttons(1).Width        = 59
            .Buttons(1).AutoSize     = .T.
            .Buttons(1).ForeColor    = RGB(90, 90, 90)
            .Buttons(2).Caption      = "Opera" + CHR(231) + CHR(227) + "o"
            .Buttons(2).ToolTipText  = "Tipo Boleto ( OONNNNNN )"
            .Buttons(2).FontSize     = 8
            .Buttons(2).BackStyle    = 0
            .Buttons(2).Left         = 82
            .Buttons(2).Top          = 3
            .Buttons(2).Width        = 65
            .Buttons(2).AutoSize     = .T.
            .Buttons(2).ForeColor    = RGB(90, 90, 90)
            .Buttons(3).Caption      = "Manual"
            .Buttons(3).ToolTipText  = "Tipo Manual ( NNNNNN )"
            .Buttons(3).FontSize     = 8
            .Buttons(3).BackStyle    = 0
            .Buttons(3).Left         = 159
            .Buttons(3).Top          = 3
            .Buttons(3).Width        = 61
            .Buttons(3).AutoSize     = .T.
            .Buttons(3).ForeColor    = RGB(90, 90, 90)
        ENDWITH

        *-- Fonte da Numeracao (fontnums)
        par_oPg.AddObject("lbl_4c_FonNum", "Label")
        WITH par_oPg.lbl_4c_FonNum
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Fonte da Numera" + CHR(231) + CHR(227) + "o :"
            .Top       = 55
            .Left      = 55
            .Width     = 109
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_FonNum", "OptionGroup")
        WITH par_oPg.opt_4c_FonNum
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 21
            .Left        = 167
            .Top         = 51
            .Width       = 247
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Grupo"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 47
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Caption   = "Opera" + CHR(231) + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 65
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Situacao das Operacoes (utilizas)
        par_oPg.AddObject("lbl_4c_Utilizas", "Label")
        WITH par_oPg.lbl_4c_Utilizas
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o das Opera" + CHR(231) + CHR(245) + "es:"
            .Top       = 75
            .Left      = 42
            .Width     = 122
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Utilizas", "OptionGroup")
        WITH par_oPg.opt_4c_Utilizas
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 72
            .Width       = 247
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Todas"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 47
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Caption   = "Utilizadas"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 63
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Caption   = "N" + CHR(227) + "o Utilizadas"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).Left      = 159
            .Buttons(3).Top       = 3
            .Buttons(3).Width     = 73
            .Buttons(3).AutoSize  = .T.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Situacao dos Subniveis (subniveis)
        par_oPg.AddObject("lbl_4c_Subniveis", "Label")
        WITH par_oPg.lbl_4c_Subniveis
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Situa" + CHR(231) + CHR(227) + "o dos Subn" + CHR(237) + "veis :"
            .Top       = 97
            .Left      = 46
            .Width     = 118
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Subniveis", "OptionGroup")
        WITH par_oPg.opt_4c_Subniveis
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 94
            .Width       = 247
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Todos"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 47
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Caption   = "Pendentes"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 69
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Caption   = "Baixados"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).Left      = 159
            .Buttons(3).Top       = 3
            .Buttons(3).Width     = 61
            .Buttons(3).AutoSize  = .T.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Ordem de Producao (prods)
        par_oPg.AddObject("lbl_4c_Prods", "Label")
        WITH par_oPg.lbl_4c_Prods
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Ordem de Produ" + CHR(231) + CHR(227) + "o :"
            .Top       = 119
            .Left      = 60
            .Width     = 104
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Prods", "OptionGroup")
        WITH par_oPg.opt_4c_Prods
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 116
            .Width       = 247
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Todas"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 47
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Caption   = "Com OP"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 56
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Caption   = "Sem OP"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).Left      = 159
            .Buttons(3).Top       = 3
            .Buttons(3).Width     = 55
            .Buttons(3).AutoSize  = .T.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Desagendar Utilizados (desutils)
        par_oPg.AddObject("lbl_4c_Desutils", "Label")
        WITH par_oPg.lbl_4c_Desutils
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Desagendar Utilizados:"
            .Top       = 141
            .Left      = 52
            .Width     = 112
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Desutils", "OptionGroup")
        WITH par_oPg.opt_4c_Desutils
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 138
            .Width       = 247
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Exibir botao F8 - AGENDA (iniagenda)
        par_oPg.AddObject("lbl_4c_Iniagenda", "Label")
        WITH par_oPg.lbl_4c_Iniagenda
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Exibir bot" + CHR(227) + "o F8 - AGENDA:"
            .Top       = 163
            .Left      = 35
            .Width     = 129
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Iniagenda", "OptionGroup")
        WITH par_oPg.opt_4c_Iniagenda
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 160
            .Width       = 247
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Ignorar Grupo Operacional (qualquer)
        par_oPg.AddObject("lbl_4c_Qualquer", "Label")
        WITH par_oPg.lbl_4c_Qualquer
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Ignorar Grupo Operacional :"
            .Top       = 185
            .Left      = 27
            .Width     = 137
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Qualquer", "OptionGroup")
        WITH par_oPg.opt_4c_Qualquer
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 182
            .Width       = 247
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Apenas Consulta (consulta)
        par_oPg.AddObject("lbl_4c_Consulta", "Label")
        WITH par_oPg.lbl_4c_Consulta
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Apenas Consulta :"
            .Top       = 207
            .Left      = 74
            .Width     = 90
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Consulta", "OptionGroup")
        WITH par_oPg.opt_4c_Consulta
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 204
            .Width       = 247
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Produtos Com Montagem (montagem)
        par_oPg.AddObject("lbl_4c_Montagem", "Label")
        WITH par_oPg.lbl_4c_Montagem
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Produtos Com Montagem :"
            .Top       = 229
            .Left      = 35
            .Width     = 129
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Montagem", "OptionGroup")
        WITH par_oPg.opt_4c_Montagem
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 226
            .Width       = 247
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Caption   = "Ambos"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).Left      = 159
            .Buttons(3).Top       = 3
            .Buttons(3).Width     = 61
            .Buttons(3).AutoSize  = .T.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Checar Mercadorias (chkmercs)
        par_oPg.AddObject("lbl_4c_Chkmercs", "Label")
        WITH par_oPg.lbl_4c_Chkmercs
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Checar Mercadorias :"
            .Top       = 251
            .Left      = 60
            .Width     = 104
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Chkmercs", "OptionGroup")
        WITH par_oPg.opt_4c_Chkmercs
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 248
            .Width       = 247
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Operacoes Utilizadas (oputiliza)
        par_oPg.AddObject("lbl_4c_Oputiliza", "Label")
        WITH par_oPg.lbl_4c_Oputiliza
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Opera" + CHR(231) + CHR(245) + "es Utilizadas :"
            .Top       = 273
            .Left      = 55
            .Width     = 109
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Oputiliza", "OptionGroup")
        WITH par_oPg.opt_4c_Oputiliza
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 270
            .Width       = 247
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Caption   = "Ambas"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).Left      = 159
            .Buttons(3).Top       = 3
            .Buttons(3).Width     = 61
            .Buttons(3).AutoSize  = .T.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Operacoes Pagas (filpagas)
        par_oPg.AddObject("lbl_4c_Filpagas", "Label")
        WITH par_oPg.lbl_4c_Filpagas
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Opera" + CHR(231) + CHR(245) + "es Pagas :"
            .Top       = 295
            .Left      = 71
            .Width     = 93
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Filpagas", "OptionGroup")
        WITH par_oPg.opt_4c_Filpagas
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 292
            .Width       = 247
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Caption   = "Ambas"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).Left      = 159
            .Buttons(3).Top       = 3
            .Buttons(3).Width     = 61
            .Buttons(3).AutoSize  = .T.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Operacoes Baixadas (filbaixas)
        par_oPg.AddObject("lbl_4c_Filbaixas", "Label")
        WITH par_oPg.lbl_4c_Filbaixas
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Opera" + CHR(231) + CHR(245) + "es Baixadas :"
            .Top       = 317
            .Left      = 57
            .Width     = 107
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Filbaixas", "OptionGroup")
        WITH par_oPg.opt_4c_Filbaixas
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 167
            .Top         = 314
            .Width       = 247
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 82
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Caption   = "Ambas"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).Left      = 159
            .Buttons(3).Top       = 3
            .Buttons(3).Width     = 61
            .Buttons(3).AutoSize  = .T.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Limite Diario (limdia)
        par_oPg.AddObject("lbl_4c_Limdia", "Label")
        WITH par_oPg.lbl_4c_Limdia
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Limite di" + CHR(225) + "rio :"
            .Top       = 341
            .Left      = 99
            .Width     = 65
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c_Limdia", "TextBox")
        WITH par_oPg.txt_4c_Limdia
            .Top       = 338
            .Left      = 168
            .Width     = 52
            .Height    = 23
            .MaxLength = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- COLUNA DIREITA: Auditoria (9 opcoes) - Left=424
        par_oPg.AddObject("opt_4c_Audits", "OptionGroup")
        WITH par_oPg.opt_4c_Audits
            .ButtonCount = 9
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 112
            .Left        = 424
            .Top         = 8
            .Width       = 301
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 4
            .Buttons(1).Top       = 6
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 151
            .Buttons(2).Top       = 6
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Caption   = "Agendamento Pago"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).Left      = 4
            .Buttons(3).Top       = 27
            .Buttons(3).Width     = 112
            .Buttons(3).AutoSize  = .T.
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(4).Caption   = "Agendamento N" + CHR(227) + "o Pago"
            .Buttons(4).FontSize  = 8
            .Buttons(4).BackStyle = 0
            .Buttons(4).Left      = 151
            .Buttons(4).Top       = 27
            .Buttons(4).Width     = 134
            .Buttons(4).AutoSize  = .T.
            .Buttons(4).ForeColor = RGB(90, 90, 90)
            .Buttons(5).Caption   = "Subniveis N" + CHR(227) + "o Utilizados"
            .Buttons(5).FontSize  = 8
            .Buttons(5).BackStyle = 0
            .Buttons(5).Left      = 4
            .Buttons(5).Top       = 48
            .Buttons(5).Width     = 133
            .Buttons(5).AutoSize  = .T.
            .Buttons(5).ForeColor = RGB(90, 90, 90)
            .Buttons(6).Caption   = "Certificado de Cr" + CHR(233) + "dito"
            .Buttons(6).FontSize  = 8
            .Buttons(6).BackStyle = 0
            .Buttons(6).Left      = 151
            .Buttons(6).Top       = 48
            .Buttons(6).Width     = 123
            .Buttons(6).AutoSize  = .T.
            .Buttons(6).ForeColor = RGB(90, 90, 90)
            .Buttons(7).Caption   = "Subniveis Pagos"
            .Buttons(7).FontSize  = 8
            .Buttons(7).BackStyle = 0
            .Buttons(7).Left      = 4
            .Buttons(7).Top       = 69
            .Buttons(7).Width     = 95
            .Buttons(7).AutoSize  = .T.
            .Buttons(7).ForeColor = RGB(90, 90, 90)
            .Buttons(8).Caption   = "N" + CHR(227) + "o Pagos"
            .Buttons(8).FontSize  = 8
            .Buttons(8).BackStyle = 0
            .Buttons(8).Left      = 151
            .Buttons(8).Top       = 69
            .Buttons(8).Width     = 69
            .Buttons(8).AutoSize  = .T.
            .Buttons(8).ForeColor = RGB(90, 90, 90)
            .Buttons(9).Caption   = "Agendamento Geral"
            .Buttons(9).FontSize  = 8
            .Buttons(9).BackStyle = 0
            .Buttons(9).Left      = 4
            .Buttons(9).Top       = 90
            .Buttons(9).Width     = 113
            .Buttons(9).AutoSize  = .T.
            .Buttons(9).ForeColor = RGB(90, 90, 90)
        ENDWITH

        *-- Grade de Operacoes (SigCdGpo: dopers + confops)
        *-- ColumnCount e RecordSource ANTES do WITH
        par_oPg.AddObject("grd_4c_GradeOpe", "Grid")
        par_oPg.grd_4c_GradeOpe.ColumnCount = 2
        par_oPg.grd_4c_GradeOpe.RecordSource = ""

        WITH par_oPg.grd_4c_GradeOpe
            .HeaderHeight = 17
            .Height       = 171
            .Left         = 424
            .RecordMark   = .F.
            .DeleteMark   = .F.
            .RowHeight    = 17
            .Top          = 121
            .Width        = 301
            .ReadOnly     = .F.
            .ScrollBars   = 2
            .Visible      = .T.

            .Column1.Width    = 140
            .Column1.Movable  = .F.
            .Column1.Resizable = .F.
            .Column1.FontName = "Courier New"
            .Column1.FontSize = 8

            .Column2.Width    = 140
            .Column2.Movable  = .F.
            .Column2.Resizable = .F.
            .Column2.FontName = "Courier New"
            .Column2.FontSize = 8
        ENDWITH

        *-- Headers da grade: reconfigurar apos RecordSource (VFP9 reseta headers)
        WITH par_oPg.grd_4c_GradeOpe
            .Column1.Header1.FontName  = "Verdana"
            .Column1.Header1.FontSize  = 8
            .Column1.Header1.Alignment = 2
            .Column1.Header1.Caption   = "Opera" + CHR(231) + CHR(245) + "es Poss" + CHR(237) + "veis"

            .Column2.Header1.FontName  = "Verdana"
            .Column2.Header1.FontSize  = 8
            .Column2.Header1.Alignment = 2
            .Column2.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPgCompls - Configura aba Complementos (pgf_4c_Dados.Page2)
    * Coordenadas relativas a pagina (sem compensacao +29)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPgCompls(par_oPg)

        *-- Bordas decorativas (Shape) - agrupamento visual de secoes

        par_oPg.AddObject("shp_4c_Shape2", "Shape")
        WITH par_oPg.shp_4c_Shape2
            .Top           = 10
            .Left          = 515
            .Height        = 61
            .Width         = 215
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("shp_4c_Shape6", "Shape")
        WITH par_oPg.shp_4c_Shape6
            .Top           = 73
            .Left          = 515
            .Height        = 56
            .Width         = 215
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("shp_4c_Shape1", "Shape")
        WITH par_oPg.shp_4c_Shape1
            .Top           = 246
            .Left          = 275
            .Height        = 79
            .Width         = 264
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("shp_4c_Shape3", "Shape")
        WITH par_oPg.shp_4c_Shape3
            .Top           = 246
            .Left          = 5
            .Height        = 124
            .Width         = 264
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("shp_4c_Shape4", "Shape")
        WITH par_oPg.shp_4c_Shape4
            .Top           = 331
            .Left          = 275
            .Height        = 39
            .Width         = 264
            .BackStyle     = 0
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- Icone diamante - tooltip consulta generica de produtos (Image1)
        par_oPg.AddObject("img_4c_Image1", "Image")
        WITH par_oPg.img_4c_Image1
            .Picture     = gc_4c_CaminhoIcones + "a_diamd1.bmp"
            .Top         = 263
            .Left        = 244
            .Height      = 20
            .Width       = 20
            .ToolTipText = "Esta Configura" + CHR(231) + CHR(227) + "o " + CHR(233) + " Utilizada Na Consulta Gen" + CHR(233) + "rica de Produtos"
            .Visible     = .T.
        ENDWITH

        *-- COLUNA ESQUERDA: OptionGroups Sim/Nao (Left=173, Width=86, H=20)

        *-- Utilizar Data Atual (dtatuals)
        par_oPg.AddObject("lbl_4c_DtAtuals", "Label")
        WITH par_oPg.lbl_4c_DtAtuals
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Utilizar Data Atual :"
            .Top       = 6
            .Left      = 79
            .Width     = 95
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Dtatuals", "OptionGroup")
        WITH par_oPg.opt_4c_Dtatuals
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 2
            .Width       = 86
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Bloqueia Alt. Data (blqadts)
        par_oPg.AddObject("lbl_4c_BlqAdts", "Label")
        WITH par_oPg.lbl_4c_BlqAdts
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Bloqueia Alt. Data :"
            .Top       = 25
            .Left      = 79
            .Width     = 95
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Blqadts", "OptionGroup")
        WITH par_oPg.opt_4c_Blqadts
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 21
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Inibir Botao Ocorrencia (inibocors)
        par_oPg.AddObject("lbl_4c_InibOcors", "Label")
        WITH par_oPg.lbl_4c_InibOcors
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Inibir Bot" + CHR(227) + "o Ocorr" + CHR(234) + "ncia :"
            .Top       = 44
            .Left      = 55
            .Width     = 119
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Inibocors", "OptionGroup")
        WITH par_oPg.opt_4c_Inibocors
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 40
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Inibir Botao Fechamento (inibfecs)
        par_oPg.AddObject("lbl_4c_InibFecs", "Label")
        WITH par_oPg.lbl_4c_InibFecs
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Inibir Bot" + CHR(227) + "o Fechamento :"
            .Top       = 63
            .Left      = 48
            .Width     = 126
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Inibfecs", "OptionGroup")
        WITH par_oPg.opt_4c_Inibfecs
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 59
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Permitir Alteracao (alterar)
        par_oPg.AddObject("lbl_4c_Alterar", "Label")
        WITH par_oPg.lbl_4c_Alterar
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Permitir Altera" + CHR(231) + CHR(227) + "o :"
            .Top       = 82
            .Left      = 80
            .Width     = 94
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Alterar", "OptionGroup")
        WITH par_oPg.opt_4c_Alterar
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 78
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Utiliza Periodo Configuracao (periodos)
        par_oPg.AddObject("lbl_4c_Periodos", "Label")
        WITH par_oPg.lbl_4c_Periodos
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Utiliza Per" + CHR(237) + "odo Configura" + CHR(231) + CHR(227) + "o :"
            .Top       = 101
            .Left      = 31
            .Width     = 143
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Periodos", "OptionGroup")
        WITH par_oPg.opt_4c_Periodos
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 97
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Utiliza Periodo Entrega (entregas)
        par_oPg.AddObject("lbl_4c_Entregas", "Label")
        WITH par_oPg.lbl_4c_Entregas
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Utiliza Per" + CHR(237) + "odo Entrega :"
            .Top       = 121
            .Left      = 57
            .Width     = 117
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Entregas", "OptionGroup")
        WITH par_oPg.opt_4c_Entregas
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 117
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Utiliza Periodo Operacao (operacoes)
        par_oPg.AddObject("lbl_4c_Operacoes", "Label")
        WITH par_oPg.lbl_4c_Operacoes
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Utiliza Per" + CHR(237) + "odo Opera" + CHR(231) + CHR(227) + "o :"
            .Top       = 140
            .Left      = 48
            .Width     = 126
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Operacoes", "OptionGroup")
        WITH par_oPg.opt_4c_Operacoes
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 136
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Senha por Responsavel (vends)
        par_oPg.AddObject("lbl_4c_Vends", "Label")
        WITH par_oPg.lbl_4c_Vends
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Senha por Respons" + CHR(225) + "vel :"
            .Top       = 159
            .Left      = 52
            .Width     = 122
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Vends", "OptionGroup")
        WITH par_oPg.opt_4c_Vends
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 155
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Checar SAC (sacs)
        par_oPg.AddObject("lbl_4c_Sacs", "Label")
        WITH par_oPg.lbl_4c_Sacs
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Checar SAC :"
            .Top       = 178
            .Left      = 108
            .Width     = 66
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Sacs", "OptionGroup")
        WITH par_oPg.opt_4c_Sacs
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 174
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Utiliza Empresa (empresas)
        par_oPg.AddObject("lbl_4c_Empresas", "Label")
        WITH par_oPg.lbl_4c_Empresas
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Utiliza Empresa :"
            .Top       = 198
            .Left      = 93
            .Width     = 81
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Empresas", "OptionGroup")
        WITH par_oPg.opt_4c_Empresas
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 193
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Controlar Acesso por Usuario (ctacusus)
        par_oPg.AddObject("lbl_4c_Ctacusus", "Label")
        WITH par_oPg.lbl_4c_Ctacusus
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Controlar Acesso por Usu" + CHR(225) + "rio :"
            .Top       = 217
            .Left      = 25
            .Width     = 149
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Ctacusus", "OptionGroup")
        WITH par_oPg.opt_4c_Ctacusus
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 173
            .Top         = 214
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 4
            .Buttons(1).Top       = 2
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 43
            .Buttons(2).Top       = 2
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- SECAO "Padrao de Configuracao" - header Bold
        par_oPg.AddObject("lbl_4c_PadrConf", "Label")
        WITH par_oPg.lbl_4c_PadrConf
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = " Padr" + CHR(227) + "o de Configura" + CHR(231) + CHR(227) + "o "
            .Top       = 247
            .Left      = 7
            .Width     = 142
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- OptionGroups para filtro de operacoes (Left=3, Width=216)
        par_oPg.AddObject("opt_4c_Oppends", "OptionGroup")
        WITH par_oPg.opt_4c_Oppends
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 3
            .Top         = 261
            .Width       = 216
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Todas"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 47
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "Pendentes"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Left      = 57
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 69
            .Buttons(2).AutoSize  = .T.
            .Buttons(3).Caption   = "Baixadas"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Left      = 140
            .Buttons(3).Top       = 3
            .Buttons(3).Width     = 61
            .Buttons(3).AutoSize  = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Opagends", "OptionGroup")
        WITH par_oPg.opt_4c_Opagends
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 3
            .Top         = 278
            .Width       = 216
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Todas"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 47
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o Agendadas"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Left      = 57
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 82
            .Buttons(2).AutoSize  = .T.
            .Buttons(3).Caption   = "Agendadas"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Left      = 140
            .Buttons(3).Top       = 3
            .Buttons(3).Width     = 72
            .Buttons(3).AutoSize  = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Oppagas", "OptionGroup")
        WITH par_oPg.opt_4c_Oppagas
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 22
            .Left        = 3
            .Top         = 296
            .Width       = 216
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Todas"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).ForeColor = RGB(90, 90, 90)
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 47
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o Pagas"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).ForeColor = RGB(90, 90, 90)
            .Buttons(2).Left      = 57
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 57
            .Buttons(2).AutoSize  = .T.
            .Buttons(3).Caption   = "Pagas"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).ForeColor = RGB(90, 90, 90)
            .Buttons(3).Left      = 140
            .Buttons(3).Top       = 3
            .Buttons(3).Width     = 47
            .Buttons(3).AutoSize  = .T.
        ENDWITH

        *-- CheckBoxes para travar ordenacao (Fixa*)
        par_oPg.AddObject("chk_4c_Fixaps", "CheckBox")
        WITH par_oPg.chk_4c_Fixaps
            .Top           = 261
            .Left          = 221
            .Height        = 20
            .Width         = 20
            .Caption       = ""
            .Alignment     = 0
            .SpecialEffect = 0
            .Style         = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("chk_4c_Fixaas", "CheckBox")
        WITH par_oPg.chk_4c_Fixaas
            .Top           = 279
            .Left          = 221
            .Height        = 20
            .Width         = 20
            .Caption       = ""
            .Alignment     = 0
            .SpecialEffect = 0
            .Style         = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("chk_4c_Fixags", "CheckBox")
        WITH par_oPg.chk_4c_Fixags
            .Top           = 297
            .Left          = 221
            .Height        = 20
            .Width         = 20
            .Caption       = ""
            .Alignment     = 0
            .SpecialEffect = 0
            .Style         = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("chk_4c_Fixals", "CheckBox")
        WITH par_oPg.chk_4c_Fixals
            .Top           = 317
            .Left          = 221
            .Height        = 20
            .Width         = 20
            .Caption       = ""
            .Alignment     = 0
            .SpecialEffect = 0
            .Style         = 1
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("chk_4c_Fixass", "CheckBox")
        WITH par_oPg.chk_4c_Fixass
            .Top           = 339
            .Left          = 221
            .Height        = 20
            .Width         = 20
            .Caption       = ""
            .Alignment     = 0
            .SpecialEffect = 0
            .Style         = 1
            .Visible       = .T.
        ENDWITH

        *-- Localizacao Padrao (locals - lookup SigPrLcl)
        par_oPg.AddObject("lbl_4c_Local", "Label")
        WITH par_oPg.lbl_4c_Local
            .FontSize  = 8
            .Caption   = "Localiza" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :"
            .Top       = 320
            .Left      = 16
            .Width     = 100
            .Height    = 15
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c_Locals", "TextBox")
        WITH par_oPg.txt_4c_Locals
            .Top       = 317
            .Left      = 139
            .Width     = 80
            .Height    = 22
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Segmento Padrao (codsegs - lookup SigCdSct)
        par_oPg.AddObject("lbl_4c_Seg", "Label")
        WITH par_oPg.lbl_4c_Seg
            .FontSize  = 8
            .Caption   = "Segmento Padr" + CHR(227) + "o :"
            .Top       = 342
            .Left      = 23
            .Width     = 94
            .Height    = 15
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("txt_4c_Codsegs", "TextBox")
        WITH par_oPg.txt_4c_Codsegs
            .Top       = 339
            .Left      = 139
            .Width     = 80
            .Height    = 22
            .MaxLength = 10
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- SECAO "Ordem da Grade" (header Bold)
        par_oPg.AddObject("lbl_4c_OrdGrade", "Label")
        WITH par_oPg.lbl_4c_OrdGrade
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = " Ordem da Grade "
            .Top       = 246
            .Left      = 274
            .Width     = 100
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("lbl_4c_Todas", "Label")
        WITH par_oPg.lbl_4c_Todas
            .FontSize  = 8
            .Caption   = "Todas :"
            .Top       = 261
            .Left      = 315
            .Width     = 38
            .Height    = 15
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("lbl_4c_NAgen", "Label")
        WITH par_oPg.lbl_4c_NAgen
            .FontSize  = 8
            .Caption   = "N" + CHR(227) + "o Agendadas :"
            .Top       = 282
            .Left      = 279
            .Width     = 73
            .Height    = 15
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("lbl_4c_Agen", "Label")
        WITH par_oPg.lbl_4c_Agen
            .FontSize  = 8
            .Caption   = "Agendadas :"
            .Top       = 303
            .Left      = 289
            .Width     = 63
            .Height    = 15
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- ComboBoxes para ordem (RowSourceType=1: lista fixa)
        par_oPg.AddObject("cmb_4c_Ordems", "ComboBox")
        WITH par_oPg.cmb_4c_Ordems
            .FontName      = "Courier New"
            .RowSourceType = 1
            .RowSource     = "Opera" + CHR(231) + CHR(227) + "o,Data Opera" + CHR(231) + CHR(227) + "o,Documento,Data Entrega,Data Agenda/Auditoria,Conta"
            .Height        = 21
            .Left          = 353
            .Style         = 2
            .ToolTipText   = "Ordem de Apresenta" + CHR(231) + CHR(227) + "o Quando Selecionado o Flag Todas"
            .Top           = 258
            .Width         = 182
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("cmb_4c_Ordemns", "ComboBox")
        WITH par_oPg.cmb_4c_Ordemns
            .FontName      = "Courier New"
            .RowSourceType = 1
            .RowSource     = "Opera" + CHR(231) + CHR(227) + "o,Data Opera" + CHR(231) + CHR(227) + "o,Documento,Data Entrega,Data Agenda/Auditoria,Conta"
            .Height        = 21
            .Left          = 353
            .Style         = 2
            .ToolTipText   = "Ordem de Apresenta" + CHR(231) + CHR(227) + "o Quando Selecionado o Flag N" + CHR(227) + "o Agendadas"
            .Top           = 279
            .Width         = 182
            .Visible       = .T.
        ENDWITH

        par_oPg.AddObject("cmb_4c_Ordemas", "ComboBox")
        WITH par_oPg.cmb_4c_Ordemas
            .FontName      = "Courier New"
            .RowSourceType = 1
            .RowSource     = "Opera" + CHR(231) + CHR(227) + "o,Data Opera" + CHR(231) + CHR(227) + "o,Documento,Data Entrega,Data Agenda/Auditoria,Conta"
            .Height        = 21
            .Left          = 353
            .Style         = 2
            .ToolTipText   = "Ordem de Apresenta" + CHR(231) + CHR(227) + "o Quando Selecionado o Flag Agendadas"
            .Top           = 300
            .Width         = 182
            .Visible       = .T.
        ENDWITH

        *-- COLUNA DIREITA: OptionGroups Sim/Nao (Left=431, Width=86)

        *-- Analisar C.Pagto Fx.Cx (anacps)
        par_oPg.AddObject("lbl_4c_Anacps", "Label")
        WITH par_oPg.lbl_4c_Anacps
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Analisar C.Pagto Fx. Cx :"
            .Top       = 7
            .Left      = 310
            .Width     = 124
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Anacps", "OptionGroup")
        WITH par_oPg.opt_4c_Anacps
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 431
            .Top         = 3
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Gera Controle de Volumes / ChkReserva (chkreserva)
        par_oPg.AddObject("lbl_4c_Chkreserva", "Label")
        WITH par_oPg.lbl_4c_Chkreserva
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Gera Controle de Volumes :"
            .Top       = 26
            .Left      = 301
            .Width     = 133
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Chkreserva", "OptionGroup")
        WITH par_oPg.opt_4c_Chkreserva
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 431
            .Top         = 22
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Utiliza Responsavel (resps)
        par_oPg.AddObject("lbl_4c_Resps", "Label")
        WITH par_oPg.lbl_4c_Resps
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Utiliza Respons" + CHR(225) + "vel :"
            .Top       = 45
            .Left      = 333
            .Width     = 101
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Resps", "OptionGroup")
        WITH par_oPg.opt_4c_Resps
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 431
            .Top         = 41
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Estoque Disponivel (estdisps)
        par_oPg.AddObject("lbl_4c_Estdisps", "Label")
        WITH par_oPg.lbl_4c_Estdisps
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Estoque Dispon" + CHR(237) + "vel :"
            .Top       = 64
            .Left      = 335
            .Width     = 99
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Estdisps", "OptionGroup")
        WITH par_oPg.opt_4c_Estdisps
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 431
            .Top         = 60
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Quantidade de Volumes (volumes)
        par_oPg.AddObject("lbl_4c_Volumes", "Label")
        WITH par_oPg.lbl_4c_Volumes
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Quantidade de Volumes :"
            .Top       = 83
            .Left      = 312
            .Width     = 122
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Volumes", "OptionGroup")
        WITH par_oPg.opt_4c_Volumes
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 431
            .Top         = 79
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Checa Acesso Muda Empresa (acmemps)
        par_oPg.AddObject("lbl_4c_Acmemps", "Label")
        WITH par_oPg.lbl_4c_Acmemps
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Checa Acesso Muda Empresa :"
            .Top       = 103
            .Left      = 285
            .Width     = 149
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Acmemps", "OptionGroup")
        WITH par_oPg.opt_4c_Acmemps
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 431
            .Top         = 99
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Solicita Senha Responsavel (senresps)
        par_oPg.AddObject("lbl_4c_Senresps", "Label")
        WITH par_oPg.lbl_4c_Senresps
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Solicita Senha Respons" + CHR(225) + "vel :"
            .Top       = 122
            .Left      = 295
            .Width     = 139
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Senresps", "OptionGroup")
        WITH par_oPg.opt_4c_Senresps
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 431
            .Top         = 118
            .Width       = 86
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Checar Data de Entrega (chdtentrs)
        par_oPg.AddObject("lbl_4c_Chdtentrs", "Label")
        WITH par_oPg.lbl_4c_Chdtentrs
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Checar Data de Entrega :"
            .Top       = 141
            .Left      = 309
            .Width     = 125
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Chdtentrs", "OptionGroup")
        WITH par_oPg.opt_4c_Chdtentrs
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 431
            .Top         = 137
            .Width       = 86
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Imprime Documentos (multiimps)
        par_oPg.AddObject("lbl_4c_Multiimps", "Label")
        WITH par_oPg.lbl_4c_Multiimps
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Imprime Documentos :"
            .Top       = 160
            .Left      = 325
            .Width     = 109
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Multiimps", "OptionGroup")
        WITH par_oPg.opt_4c_Multiimps
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 431
            .Top         = 156
            .Width       = 86
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- Utiliza Conta (contas)
        par_oPg.AddObject("lbl_4c_Contas", "Label")
        WITH par_oPg.lbl_4c_Contas
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Utiliza Conta :"
            .Top       = 179
            .Left      = 365
            .Width     = 69
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("opt_4c_Contas", "OptionGroup")
        WITH par_oPg.opt_4c_Contas
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 431
            .Top         = 175
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        *-- SECAO "Credito / Bonus" (header Bold, Left=524)
        par_oPg.AddObject("lbl_4c_CrBonus", "Label")
        WITH par_oPg.lbl_4c_CrBonus
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = "Cr" + CHR(233) + "dito / B" + CHR(244) + "nus"
            .Top       = 10
            .Left      = 524
            .Width     = 89
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("lbl_4c_Gerar", "Label")
        WITH par_oPg.lbl_4c_Gerar
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Gerar :"
            .Top       = 27
            .Left      = 543
            .Width     = 36
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Gera Controle de Subniveis (geracrs)
        par_oPg.AddObject("opt_4c_Geracrs", "OptionGroup")
        WITH par_oPg.opt_4c_Geracrs
            .ButtonCount = 2
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 20
            .Left        = 572
            .Top         = 22
            .Width       = 86
            .Value       = 2
            .Visible     = .T.
            .Buttons(1).Caption   = "Sim"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 5
            .Buttons(1).Top       = 3
            .Buttons(1).Width     = 34
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "N" + CHR(227) + "o"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 45
            .Buttons(2).Top       = 3
            .Buttons(2).Width     = 37
            .Buttons(2).AutoSize  = .T.
        ENDWITH

        par_oPg.AddObject("lbl_4c_Subnivel", "Label")
        WITH par_oPg.lbl_4c_Subnivel
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Subn" + CHR(237) + "vel :"
            .Top       = 47
            .Left      = 530
            .Width     = 49
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Subnivel Padrao (subncrs - lookup SigCdOpe)
        par_oPg.AddObject("txt_4c_Subncrs", "TextBox")
        WITH par_oPg.txt_4c_Subncrs
            .Top       = 45
            .Left      = 576
            .Width     = 150
            .Height    = 21
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- SECAO "Bloqueio" (header Bold, Left=524)
        par_oPg.AddObject("lbl_4c_Bloqueio", "Label")
        WITH par_oPg.lbl_4c_Bloqueio
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = "Bloqueio"
            .Top       = 73
            .Left      = 524
            .Width     = 50
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        par_oPg.AddObject("lbl_4c_Por", "Label")
        WITH par_oPg.lbl_4c_Por
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "por :"
            .Top       = 93
            .Left      = 554
            .Width     = 25
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Tipo de Bloqueio (tpbloqueio) - 3 opcoes verticais
        par_oPg.AddObject("opt_4c_Tpbloqueio", "OptionGroup")
        WITH par_oPg.opt_4c_Tpbloqueio
            .ButtonCount = 3
            .AutoSize    = .F.
            .BackStyle   = 0
            .BorderStyle = 0
            .Height      = 48
            .Left        = 585
            .Top         = 77
            .Width       = 244
            .Value       = 1
            .Visible     = .T.
            .Buttons(1).Caption   = "Per" + CHR(237) + "odo"
            .Buttons(1).FontSize  = 8
            .Buttons(1).BackStyle = 0
            .Buttons(1).Left      = 3
            .Buttons(1).Top       = 1
            .Buttons(1).Width     = 54
            .Buttons(1).AutoSize  = .T.
            .Buttons(2).Caption   = "Limite M" + CHR(237) + "nimo"
            .Buttons(2).FontSize  = 8
            .Buttons(2).BackStyle = 0
            .Buttons(2).Left      = 3
            .Buttons(2).Top       = 15
            .Buttons(2).Width     = 80
            .Buttons(2).AutoSize  = .T.
            .Buttons(3).Caption   = "N" + CHR(227) + "o Bloqueia"
            .Buttons(3).FontSize  = 8
            .Buttons(3).BackStyle = 0
            .Buttons(3).Left      = 3
            .Buttons(3).Top       = 29
            .Buttons(3).Width     = 81
            .Buttons(3).AutoSize  = .T.
        ENDWITH

        *-- SECAO "Icone Para Barra de Acesso" (header Bold)
        par_oPg.AddObject("lbl_4c_IcoBarra", "Label")
        WITH par_oPg.lbl_4c_IcoBarra
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .Caption   = " " + CHR(205) + "cone Para Barra de Acesso "
            .Top       = 331
            .Left      = 278
            .Width     = 163
            .Height    = 15
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Arquivo de icone (carqicones)
        par_oPg.AddObject("txt_4c_Carqicones", "TextBox")
        WITH par_oPg.txt_4c_Carqicones
            .Top       = 345
            .Left      = 278
            .Width     = 204
            .Height    = 21
            .MaxLength = 64
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Visible   = .T.
        ENDWITH

        *-- Botao para abrir file picker de icone
        par_oPg.AddObject("cmd_4c_Icone", "CommandButton")
        WITH par_oPg.cmd_4c_Icone
            .Caption  = "..."
            .Top      = 344
            .Left     = 482
            .Height   = 22
            .Width    = 22
            .FontBold = .T.
            .Visible  = .T.
        ENDWITH

        *-- Imagem do icone selecionado
        par_oPg.AddObject("img_4c_Icone", "Image")
        WITH par_oPg.img_4c_Icone
            .Top     = 334
            .Left    = 504
            .Height  = 32
            .Width   = 32
            .Visible = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados do grid da Page1
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                CREATE CURSOR cursor_4c_Dados (dgopes C(20), ngopes N(6,0))
                loc_lResultado = .T.
            ELSE
                loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                IF VARTYPE(loc_oGrid) = "O" AND THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid.ColumnCount = 2
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.dgopes"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.ngopes"

                    *-- Reconfigurar headers APOS RecordSource (VFP9 reseta headers)
                    loc_oGrid.Column1.Header1.Caption = "Grupo Operacional"
                    loc_oGrid.Column2.Header1.Caption = "N" + CHR(186)
                    loc_oGrid.Column2.Alignment       = 1

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro CarregarLista")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Navega entre Page1 (Lista) e Page2 (Dados)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                loc_lResultado = .F.
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AlternarPagina")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores do Form para o BO
    * Fase 6: campos detalhados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lResultado, loc_oPg2, loc_oPg1, loc_oPgC
        loc_lResultado = .F.

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg1 = loc_oPg2.pgf_4c_Dados.Page1
            loc_oPgC = loc_oPg2.pgf_4c_Dados.Page2

            WITH THIS.this_oBusinessObject
                *-- Identificacao (Page2 direto)
                .this_cDgopes = ALLTRIM(loc_oPg2.txt_4c_Dgope.Value)

                *-- pgConfig: OptionGroups e TextBox
                .this_nNumopers   = loc_oPg1.opt_4c_NumOper.Value
                .this_nNcontroles = loc_oPg1.opt_4c_Controle.Value
                .this_nFontnums   = loc_oPg1.opt_4c_FonNum.Value
                .this_nUtilizas   = loc_oPg1.opt_4c_Utilizas.Value
                .this_nSubniveis  = loc_oPg1.opt_4c_Subniveis.Value
                .this_nProds      = loc_oPg1.opt_4c_Prods.Value
                .this_nDesutils   = loc_oPg1.opt_4c_Desutils.Value
                .this_nIniagenda  = loc_oPg1.opt_4c_Iniagenda.Value
                .this_nQualquer   = loc_oPg1.opt_4c_Qualquer.Value
                .this_nConsulta   = loc_oPg1.opt_4c_Consulta.Value
                .this_nMontagem   = loc_oPg1.opt_4c_Montagem.Value
                .this_nChkmercs   = loc_oPg1.opt_4c_Chkmercs.Value
                .this_nOputiliza  = loc_oPg1.opt_4c_Oputiliza.Value
                .this_nFilpagas   = loc_oPg1.opt_4c_Filpagas.Value
                .this_nFilbaixas  = loc_oPg1.opt_4c_Filbaixas.Value
                .this_nAudits     = loc_oPg1.opt_4c_Audits.Value
                .this_nLimdia     = INT(VAL(TRANSFORM(loc_oPg1.txt_4c_Limdia.Value)))

                *-- pgCompls: OptionGroups
                .this_nDtatuals   = loc_oPgC.opt_4c_Dtatuals.Value
                .this_nBlqadts    = loc_oPgC.opt_4c_Blqadts.Value
                .this_nInibocors  = loc_oPgC.opt_4c_Inibocors.Value
                .this_nInibfecs   = loc_oPgC.opt_4c_Inibfecs.Value
                .this_nAlterar    = loc_oPgC.opt_4c_Alterar.Value
                .this_nPeriodos   = loc_oPgC.opt_4c_Periodos.Value
                .this_nEntregas   = loc_oPgC.opt_4c_Entregas.Value
                .this_nOperacoes  = loc_oPgC.opt_4c_Operacoes.Value
                .this_nVends      = loc_oPgC.opt_4c_Vends.Value
                .this_nSacs       = loc_oPgC.opt_4c_Sacs.Value
                .this_nEmpresas   = loc_oPgC.opt_4c_Empresas.Value
                .this_nCtacusus   = loc_oPgC.opt_4c_Ctacusus.Value
                .this_nOppends    = loc_oPgC.opt_4c_Oppends.Value
                .this_nOpagends   = loc_oPgC.opt_4c_Opagends.Value
                .this_nOppagas    = loc_oPgC.opt_4c_Oppagas.Value
                .this_nAnacps     = loc_oPgC.opt_4c_Anacps.Value
                .this_nChkreserva = loc_oPgC.opt_4c_Chkreserva.Value
                .this_nResps      = loc_oPgC.opt_4c_Resps.Value
                .this_nEstdisps   = loc_oPgC.opt_4c_Estdisps.Value
                .this_nVolumes    = loc_oPgC.opt_4c_Volumes.Value
                .this_nAcmemps    = loc_oPgC.opt_4c_Acmemps.Value
                .this_nSenresps   = loc_oPgC.opt_4c_Senresps.Value
                .this_nChdtentrs  = loc_oPgC.opt_4c_Chdtentrs.Value
                .this_nMultiimps  = loc_oPgC.opt_4c_Multiimps.Value
                .this_nContas     = loc_oPgC.opt_4c_Contas.Value
                .this_nGeracrs    = loc_oPgC.opt_4c_Geracrs.Value
                .this_nTpbloqueio = loc_oPgC.opt_4c_Tpbloqueio.Value

                *-- pgCompls: CheckBoxes (0/1 numeric)
                .this_nFixaps  = loc_oPgC.chk_4c_Fixaps.Value
                .this_nFixaas  = loc_oPgC.chk_4c_Fixaas.Value
                .this_nFixags  = loc_oPgC.chk_4c_Fixags.Value
                .this_nFixals  = loc_oPgC.chk_4c_Fixals.Value
                .this_nFixass  = loc_oPgC.chk_4c_Fixass.Value

                *-- pgCompls: ComboBoxes (ListIndex 1-based = DB value)
                .this_nOrdems  = IIF(loc_oPgC.cmb_4c_Ordems.ListIndex  >= 1, ;
                                     loc_oPgC.cmb_4c_Ordems.ListIndex,  1)
                .this_nOrdemns = IIF(loc_oPgC.cmb_4c_Ordemns.ListIndex >= 1, ;
                                     loc_oPgC.cmb_4c_Ordemns.ListIndex, 1)
                .this_nOrdemas = IIF(loc_oPgC.cmb_4c_Ordemas.ListIndex >= 1, ;
                                     loc_oPgC.cmb_4c_Ordemas.ListIndex, 1)

                *-- pgCompls: TextBoxes de lookup
                .this_cSubncrs    = ALLTRIM(loc_oPgC.txt_4c_Subncrs.Value)
                .this_cLocals     = ALLTRIM(loc_oPgC.txt_4c_Locals.Value)
                .this_cCodsegs    = ALLTRIM(loc_oPgC.txt_4c_Codsegs.Value)
                .this_cCarqicones = ALLTRIM(loc_oPgC.txt_4c_Carqicones.Value)
            ENDWITH

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro FormParaBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para o Form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lResultado, loc_oPg2, loc_oPg1, loc_oPgC, loc_oBO
        loc_lResultado = .F.

        TRY
            loc_oBO  = THIS.this_oBusinessObject
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg1 = loc_oPg2.pgf_4c_Dados.Page1
            loc_oPgC = loc_oPg2.pgf_4c_Dados.Page2

            *-- Identificacao (Page2 direto)
            loc_oPg2.txt_4c_Dgope.Value = ALLTRIM(loc_oBO.this_cDgopes)
            loc_oPg2.txt_4c_Ngope.Value = loc_oBO.this_nNgopes

            *-- pgConfig: OptionGroups (IIF guard: val=0 usa botao 1)
            loc_oPg1.opt_4c_NumOper.Value   = IIF(loc_oBO.this_nNumopers   >= 1, loc_oBO.this_nNumopers,   1)
            loc_oPg1.opt_4c_Controle.Value  = IIF(loc_oBO.this_nNcontroles >= 1, loc_oBO.this_nNcontroles, 1)
            loc_oPg1.opt_4c_FonNum.Value    = IIF(loc_oBO.this_nFontnums   >= 1, loc_oBO.this_nFontnums,   1)
            loc_oPg1.opt_4c_Utilizas.Value  = IIF(loc_oBO.this_nUtilizas   >= 1, loc_oBO.this_nUtilizas,   1)
            loc_oPg1.opt_4c_Subniveis.Value = IIF(loc_oBO.this_nSubniveis  >= 1, loc_oBO.this_nSubniveis,  1)
            loc_oPg1.opt_4c_Prods.Value     = IIF(loc_oBO.this_nProds      >= 1, loc_oBO.this_nProds,      1)
            loc_oPg1.opt_4c_Desutils.Value  = IIF(loc_oBO.this_nDesutils   >= 1, loc_oBO.this_nDesutils,   1)
            loc_oPg1.opt_4c_Iniagenda.Value = IIF(loc_oBO.this_nIniagenda  >= 1, loc_oBO.this_nIniagenda,  1)
            loc_oPg1.opt_4c_Qualquer.Value  = IIF(loc_oBO.this_nQualquer   >= 1, loc_oBO.this_nQualquer,   1)
            loc_oPg1.opt_4c_Consulta.Value  = IIF(loc_oBO.this_nConsulta   >= 1, loc_oBO.this_nConsulta,   1)
            loc_oPg1.opt_4c_Montagem.Value  = IIF(loc_oBO.this_nMontagem   >= 1, loc_oBO.this_nMontagem,   1)
            loc_oPg1.opt_4c_Chkmercs.Value  = IIF(loc_oBO.this_nChkmercs   >= 1, loc_oBO.this_nChkmercs,   1)
            loc_oPg1.opt_4c_Oputiliza.Value = IIF(loc_oBO.this_nOputiliza  >= 1, loc_oBO.this_nOputiliza,  1)
            loc_oPg1.opt_4c_Filpagas.Value  = IIF(loc_oBO.this_nFilpagas   >= 1, loc_oBO.this_nFilpagas,   1)
            loc_oPg1.opt_4c_Filbaixas.Value = IIF(loc_oBO.this_nFilbaixas  >= 1, loc_oBO.this_nFilbaixas,  1)
            loc_oPg1.opt_4c_Audits.Value    = IIF(loc_oBO.this_nAudits     >= 1, loc_oBO.this_nAudits,     1)
            loc_oPg1.txt_4c_Limdia.Value    = loc_oBO.this_nLimdia

            *-- pgCompls: OptionGroups
            loc_oPgC.opt_4c_Dtatuals.Value   = IIF(loc_oBO.this_nDtatuals   >= 1, loc_oBO.this_nDtatuals,   1)
            loc_oPgC.opt_4c_Blqadts.Value    = IIF(loc_oBO.this_nBlqadts    >= 1, loc_oBO.this_nBlqadts,    1)
            loc_oPgC.opt_4c_Inibocors.Value  = IIF(loc_oBO.this_nInibocors  >= 1, loc_oBO.this_nInibocors,  1)
            loc_oPgC.opt_4c_Inibfecs.Value   = IIF(loc_oBO.this_nInibfecs   >= 1, loc_oBO.this_nInibfecs,   1)
            loc_oPgC.opt_4c_Alterar.Value    = IIF(loc_oBO.this_nAlterar    >= 1, loc_oBO.this_nAlterar,    1)
            loc_oPgC.opt_4c_Periodos.Value   = IIF(loc_oBO.this_nPeriodos   >= 1, loc_oBO.this_nPeriodos,   1)
            loc_oPgC.opt_4c_Entregas.Value   = IIF(loc_oBO.this_nEntregas   >= 1, loc_oBO.this_nEntregas,   1)
            loc_oPgC.opt_4c_Operacoes.Value  = IIF(loc_oBO.this_nOperacoes  >= 1, loc_oBO.this_nOperacoes,  1)
            loc_oPgC.opt_4c_Vends.Value      = IIF(loc_oBO.this_nVends      >= 1, loc_oBO.this_nVends,      1)
            loc_oPgC.opt_4c_Sacs.Value       = IIF(loc_oBO.this_nSacs       >= 1, loc_oBO.this_nSacs,       1)
            loc_oPgC.opt_4c_Empresas.Value   = IIF(loc_oBO.this_nEmpresas   >= 1, loc_oBO.this_nEmpresas,   1)
            loc_oPgC.opt_4c_Ctacusus.Value   = IIF(loc_oBO.this_nCtacusus   >= 1, loc_oBO.this_nCtacusus,   1)
            loc_oPgC.opt_4c_Oppends.Value    = IIF(loc_oBO.this_nOppends    >= 1, loc_oBO.this_nOppends,    1)
            loc_oPgC.opt_4c_Opagends.Value   = IIF(loc_oBO.this_nOpagends   >= 1, loc_oBO.this_nOpagends,   1)
            loc_oPgC.opt_4c_Oppagas.Value    = IIF(loc_oBO.this_nOppagas    >= 1, loc_oBO.this_nOppagas,    1)
            loc_oPgC.opt_4c_Anacps.Value     = IIF(loc_oBO.this_nAnacps     >= 1, loc_oBO.this_nAnacps,     1)
            loc_oPgC.opt_4c_Chkreserva.Value = IIF(loc_oBO.this_nChkreserva >= 1, loc_oBO.this_nChkreserva, 1)
            loc_oPgC.opt_4c_Resps.Value      = IIF(loc_oBO.this_nResps      >= 1, loc_oBO.this_nResps,      1)
            loc_oPgC.opt_4c_Estdisps.Value   = IIF(loc_oBO.this_nEstdisps   >= 1, loc_oBO.this_nEstdisps,   1)
            loc_oPgC.opt_4c_Volumes.Value    = IIF(loc_oBO.this_nVolumes    >= 1, loc_oBO.this_nVolumes,    1)
            loc_oPgC.opt_4c_Acmemps.Value    = IIF(loc_oBO.this_nAcmemps    >= 1, loc_oBO.this_nAcmemps,    1)
            loc_oPgC.opt_4c_Senresps.Value   = IIF(loc_oBO.this_nSenresps   >= 1, loc_oBO.this_nSenresps,   1)
            loc_oPgC.opt_4c_Chdtentrs.Value  = IIF(loc_oBO.this_nChdtentrs  >= 1, loc_oBO.this_nChdtentrs,  1)
            loc_oPgC.opt_4c_Multiimps.Value  = IIF(loc_oBO.this_nMultiimps  >= 1, loc_oBO.this_nMultiimps,  1)
            loc_oPgC.opt_4c_Contas.Value     = IIF(loc_oBO.this_nContas     >= 1, loc_oBO.this_nContas,     1)
            loc_oPgC.opt_4c_Geracrs.Value    = IIF(loc_oBO.this_nGeracrs    >= 1, loc_oBO.this_nGeracrs,    1)
            loc_oPgC.opt_4c_Tpbloqueio.Value = IIF(loc_oBO.this_nTpbloqueio >= 1, loc_oBO.this_nTpbloqueio, 1)

            *-- pgCompls: CheckBoxes (0/1)
            loc_oPgC.chk_4c_Fixaps.Value = loc_oBO.this_nFixaps
            loc_oPgC.chk_4c_Fixaas.Value = loc_oBO.this_nFixaas
            loc_oPgC.chk_4c_Fixags.Value = loc_oBO.this_nFixags
            loc_oPgC.chk_4c_Fixals.Value = loc_oBO.this_nFixals
            loc_oPgC.chk_4c_Fixass.Value = loc_oBO.this_nFixass

            *-- pgCompls: ComboBoxes (ListIndex 1-based = DB value)
            loc_oPgC.cmb_4c_Ordems.ListIndex  = IIF(loc_oBO.this_nOrdems  >= 1, loc_oBO.this_nOrdems,  1)
            loc_oPgC.cmb_4c_Ordemns.ListIndex = IIF(loc_oBO.this_nOrdemns >= 1, loc_oBO.this_nOrdemns, 1)
            loc_oPgC.cmb_4c_Ordemas.ListIndex = IIF(loc_oBO.this_nOrdemas >= 1, loc_oBO.this_nOrdemas, 1)

            *-- pgCompls: TextBoxes de lookup
            loc_oPgC.txt_4c_Subncrs.Value    = ALLTRIM(loc_oBO.this_cSubncrs)
            loc_oPgC.txt_4c_Locals.Value     = ALLTRIM(loc_oBO.this_cLocals)
            loc_oPgC.txt_4c_Codsegs.Value    = ALLTRIM(loc_oBO.this_cCodsegs)
            loc_oPgC.txt_4c_Carqicones.Value = ALLTRIM(loc_oBO.this_cCarqicones)

            *-- Image: atualizar icone se carqicones preenchido
            IF !EMPTY(ALLTRIM(loc_oBO.this_cCarqicones)) AND ;
                    FILE(ALLTRIM(loc_oBO.this_cCarqicones))
                loc_oPgC.img_4c_Icone.Picture = ALLTRIM(loc_oBO.this_cCarqicones)
                loc_oPgC.img_4c_Icone.Visible = .T.
            ELSE
                loc_oPgC.img_4c_Icone.Visible = .F.
            ENDIF

            *-- Grid de Operacoes: carregar cursor_4c_Operacoes
            IF loc_oBO.BuscarOperacoes(ALLTRIM(loc_oBO.this_cDgopes))
                loc_oPg1.grd_4c_GradeOpe.ColumnCount = 2
                loc_oPg1.grd_4c_GradeOpe.RecordSource          = "cursor_4c_Operacoes"
                loc_oPg1.grd_4c_GradeOpe.Column1.ControlSource = "cursor_4c_Operacoes.dopers"
                loc_oPg1.grd_4c_GradeOpe.Column2.ControlSource = "cursor_4c_Operacoes.confops"
                loc_oPg1.grd_4c_GradeOpe.Column1.Header1.Caption = ;
                    "Opera" + CHR(231) + CHR(245) + "es Poss" + CHR(237) + "veis"
                loc_oPg1.grd_4c_GradeOpe.Column2.Header1.Caption = ;
                    "Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia"
                loc_oPg1.grd_4c_GradeOpe.Refresh()
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro BOParaForm")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos editaveis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_oPg1, loc_oPgC, loc_lSoLeitura

        TRY
            loc_oPg2       = THIS.pgf_4c_Paginas.Page2
            loc_oPg1       = loc_oPg2.pgf_4c_Dados.Page1
            loc_oPgC       = loc_oPg2.pgf_4c_Dados.Page2
            loc_lSoLeitura = !par_lHabilitar

            *-- Codigo do grupo: editavel apenas em INCLUIR (e PK)
            loc_oPg2.txt_4c_Dgope.ReadOnly = !(THIS.this_cModoAtual = "INCLUIR")

            *-- pgConfig: OptionGroups e campos
            loc_oPg1.opt_4c_NumOper.Enabled   = par_lHabilitar
            loc_oPg1.opt_4c_Controle.Enabled  = par_lHabilitar
            loc_oPg1.opt_4c_FonNum.Enabled    = par_lHabilitar
            loc_oPg1.opt_4c_Utilizas.Enabled  = par_lHabilitar
            loc_oPg1.opt_4c_Subniveis.Enabled = par_lHabilitar
            loc_oPg1.opt_4c_Prods.Enabled     = par_lHabilitar
            loc_oPg1.opt_4c_Desutils.Enabled  = par_lHabilitar
            loc_oPg1.opt_4c_Iniagenda.Enabled = par_lHabilitar
            loc_oPg1.opt_4c_Qualquer.Enabled  = par_lHabilitar
            loc_oPg1.opt_4c_Consulta.Enabled  = par_lHabilitar
            loc_oPg1.opt_4c_Montagem.Enabled  = par_lHabilitar
            loc_oPg1.opt_4c_Chkmercs.Enabled  = par_lHabilitar
            loc_oPg1.opt_4c_Oputiliza.Enabled = par_lHabilitar
            loc_oPg1.opt_4c_Filpagas.Enabled  = par_lHabilitar
            loc_oPg1.opt_4c_Filbaixas.Enabled = par_lHabilitar
            loc_oPg1.opt_4c_Audits.Enabled    = par_lHabilitar
            loc_oPg1.txt_4c_Limdia.ReadOnly   = loc_lSoLeitura
            loc_oPg1.grd_4c_GradeOpe.ReadOnly = loc_lSoLeitura

            *-- pgCompls: OptionGroups
            loc_oPgC.opt_4c_Dtatuals.Enabled   = par_lHabilitar
            loc_oPgC.opt_4c_Blqadts.Enabled    = par_lHabilitar
            loc_oPgC.opt_4c_Inibocors.Enabled  = par_lHabilitar
            loc_oPgC.opt_4c_Inibfecs.Enabled   = par_lHabilitar
            loc_oPgC.opt_4c_Alterar.Enabled    = par_lHabilitar
            loc_oPgC.opt_4c_Periodos.Enabled   = par_lHabilitar
            loc_oPgC.opt_4c_Entregas.Enabled   = par_lHabilitar
            loc_oPgC.opt_4c_Operacoes.Enabled  = par_lHabilitar
            loc_oPgC.opt_4c_Vends.Enabled      = par_lHabilitar
            loc_oPgC.opt_4c_Sacs.Enabled       = par_lHabilitar
            loc_oPgC.opt_4c_Empresas.Enabled   = par_lHabilitar
            loc_oPgC.opt_4c_Ctacusus.Enabled   = par_lHabilitar
            loc_oPgC.opt_4c_Oppends.Enabled    = par_lHabilitar
            loc_oPgC.opt_4c_Opagends.Enabled   = par_lHabilitar
            loc_oPgC.opt_4c_Oppagas.Enabled    = par_lHabilitar
            loc_oPgC.opt_4c_Anacps.Enabled     = par_lHabilitar
            loc_oPgC.opt_4c_Chkreserva.Enabled = par_lHabilitar
            loc_oPgC.opt_4c_Resps.Enabled      = par_lHabilitar
            loc_oPgC.opt_4c_Estdisps.Enabled   = par_lHabilitar
            loc_oPgC.opt_4c_Volumes.Enabled    = par_lHabilitar
            loc_oPgC.opt_4c_Acmemps.Enabled    = par_lHabilitar
            loc_oPgC.opt_4c_Senresps.Enabled   = par_lHabilitar
            loc_oPgC.opt_4c_Chdtentrs.Enabled  = par_lHabilitar
            loc_oPgC.opt_4c_Multiimps.Enabled  = par_lHabilitar
            loc_oPgC.opt_4c_Contas.Enabled     = par_lHabilitar
            loc_oPgC.opt_4c_Geracrs.Enabled    = par_lHabilitar
            loc_oPgC.opt_4c_Tpbloqueio.Enabled = par_lHabilitar

            *-- pgCompls: CheckBoxes
            loc_oPgC.chk_4c_Fixaps.Enabled = par_lHabilitar
            loc_oPgC.chk_4c_Fixaas.Enabled = par_lHabilitar
            loc_oPgC.chk_4c_Fixags.Enabled = par_lHabilitar
            loc_oPgC.chk_4c_Fixals.Enabled = par_lHabilitar
            loc_oPgC.chk_4c_Fixass.Enabled = par_lHabilitar

            *-- pgCompls: ComboBoxes
            loc_oPgC.cmb_4c_Ordems.Enabled  = par_lHabilitar
            loc_oPgC.cmb_4c_Ordemns.Enabled = par_lHabilitar
            loc_oPgC.cmb_4c_Ordemas.Enabled = par_lHabilitar

            *-- pgCompls: TextBoxes de lookup e botao icone
            loc_oPgC.txt_4c_Subncrs.ReadOnly    = loc_lSoLeitura
            loc_oPgC.txt_4c_Locals.ReadOnly      = loc_lSoLeitura
            loc_oPgC.txt_4c_Codsegs.ReadOnly     = loc_lSoLeitura
            loc_oPgC.txt_4c_Carqicones.ReadOnly  = loc_lSoLeitura
            loc_oPgC.cmd_4c_Icone.Enabled        = par_lHabilitar

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa valores dos campos da Page2 (para novo registro)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2, loc_oPg1, loc_oPgC

        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg1 = loc_oPg2.pgf_4c_Dados.Page1
            loc_oPgC = loc_oPg2.pgf_4c_Dados.Page2

            *-- Identificacao
            loc_oPg2.txt_4c_Dgope.Value = ""
            loc_oPg2.txt_4c_Ngope.Value = 0

            *-- pgConfig: OptionGroups → todos Value=1 (primeiro botao)
            loc_oPg1.opt_4c_NumOper.Value   = 1
            loc_oPg1.opt_4c_Controle.Value  = 1
            loc_oPg1.opt_4c_FonNum.Value    = 1
            loc_oPg1.opt_4c_Utilizas.Value  = 1
            loc_oPg1.opt_4c_Subniveis.Value = 1
            loc_oPg1.opt_4c_Prods.Value     = 1
            loc_oPg1.opt_4c_Desutils.Value  = 1
            loc_oPg1.opt_4c_Iniagenda.Value = 1
            loc_oPg1.opt_4c_Qualquer.Value  = 1
            loc_oPg1.opt_4c_Consulta.Value  = 1
            loc_oPg1.opt_4c_Montagem.Value  = 1
            loc_oPg1.opt_4c_Chkmercs.Value  = 1
            loc_oPg1.opt_4c_Oputiliza.Value = 1
            loc_oPg1.opt_4c_Filpagas.Value  = 1
            loc_oPg1.opt_4c_Filbaixas.Value = 1
            loc_oPg1.opt_4c_Audits.Value    = 1
            loc_oPg1.txt_4c_Limdia.Value    = 0

            *-- pgConfig: Grid → cursor vazio editavel
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Operacoes (dopers C(20), confops C(20), cidchaves C(20))
            SET NULL OFF
            loc_oPg1.grd_4c_GradeOpe.ColumnCount = 2
            loc_oPg1.grd_4c_GradeOpe.RecordSource          = "cursor_4c_Operacoes"
            loc_oPg1.grd_4c_GradeOpe.Column1.ControlSource = "cursor_4c_Operacoes.dopers"
            loc_oPg1.grd_4c_GradeOpe.Column2.ControlSource = "cursor_4c_Operacoes.confops"
            loc_oPg1.grd_4c_GradeOpe.Column1.Header1.Caption = ;
                "Opera" + CHR(231) + CHR(245) + "es Poss" + CHR(237) + "veis"
            loc_oPg1.grd_4c_GradeOpe.Column2.Header1.Caption = ;
                "Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia"
            loc_oPg1.grd_4c_GradeOpe.Refresh()

            *-- pgCompls: OptionGroups → todos Value=1
            loc_oPgC.opt_4c_Dtatuals.Value   = 1
            loc_oPgC.opt_4c_Blqadts.Value    = 1
            loc_oPgC.opt_4c_Inibocors.Value  = 1
            loc_oPgC.opt_4c_Inibfecs.Value   = 1
            loc_oPgC.opt_4c_Alterar.Value    = 1
            loc_oPgC.opt_4c_Periodos.Value   = 1
            loc_oPgC.opt_4c_Entregas.Value   = 1
            loc_oPgC.opt_4c_Operacoes.Value  = 1
            loc_oPgC.opt_4c_Vends.Value      = 1
            loc_oPgC.opt_4c_Sacs.Value       = 1
            loc_oPgC.opt_4c_Empresas.Value   = 1
            loc_oPgC.opt_4c_Ctacusus.Value   = 1
            loc_oPgC.opt_4c_Oppends.Value    = 1
            loc_oPgC.opt_4c_Opagends.Value   = 1
            loc_oPgC.opt_4c_Oppagas.Value    = 1
            loc_oPgC.opt_4c_Anacps.Value     = 1
            loc_oPgC.opt_4c_Chkreserva.Value = 1
            loc_oPgC.opt_4c_Resps.Value      = 1
            loc_oPgC.opt_4c_Estdisps.Value   = 1
            loc_oPgC.opt_4c_Volumes.Value    = 1
            loc_oPgC.opt_4c_Acmemps.Value    = 1
            loc_oPgC.opt_4c_Senresps.Value   = 1
            loc_oPgC.opt_4c_Chdtentrs.Value  = 1
            loc_oPgC.opt_4c_Multiimps.Value  = 1
            loc_oPgC.opt_4c_Contas.Value     = 1
            loc_oPgC.opt_4c_Geracrs.Value    = 1
            loc_oPgC.opt_4c_Tpbloqueio.Value = 1

            *-- pgCompls: CheckBoxes
            loc_oPgC.chk_4c_Fixaps.Value = 0
            loc_oPgC.chk_4c_Fixaas.Value = 0
            loc_oPgC.chk_4c_Fixags.Value = 0
            loc_oPgC.chk_4c_Fixals.Value = 0
            loc_oPgC.chk_4c_Fixass.Value = 0

            *-- pgCompls: ComboBoxes → primeira opcao
            loc_oPgC.cmb_4c_Ordems.ListIndex  = 1
            loc_oPgC.cmb_4c_Ordemns.ListIndex = 1
            loc_oPgC.cmb_4c_Ordemas.ListIndex = 1

            *-- pgCompls: TextBoxes e imagem
            loc_oPgC.txt_4c_Subncrs.Value    = ""
            loc_oPgC.txt_4c_Locals.Value     = ""
            loc_oPgC.txt_4c_Codsegs.Value    = ""
            loc_oPgC.txt_4c_Carqicones.Value = ""
            loc_oPgC.img_4c_Icone.Visible    = .F.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oBotoes, loc_lTemRegistro

        TRY
            loc_oBotoes     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
            loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
                               !EOF("cursor_4c_Dados") AND ;
                               RECCOUNT("cursor_4c_Dados") > 0

            IF VARTYPE(loc_oBotoes) = "O"
                loc_oBotoes.cmd_4c_Incluir.Enabled    = .T.
                loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
                loc_oBotoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
                loc_oBotoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
                loc_oBotoes.cmd_4c_Buscar.Enabled     = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Prepara formulario para inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cDgopes
        loc_cDgopes = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "")
            RETURN
        ENDIF

        loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDgopes)
            THIS.BOParaForm()
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.HabilitarCampos(.F.)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Carrega registro selecionado para edicao
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cDgopes
        loc_cDgopes = ""

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "")
            RETURN
        ENDIF

        loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDgopes)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.BOParaForm()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.HabilitarCampos(.T.)
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui registro selecionado apos confirmacao
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cDgopes

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "")
            RETURN
        ENDIF

        loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)

        IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo operacional:" + ;
                CHR(13) + loc_cDgopes + "?", "Excluir")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cDgopes)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Grupo operacional exclu" + CHR(237) + "do com sucesso!", "")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Abre lookup para localizar grupo na lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oBusca, loc_cDgopes

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGpe", "cursor_4c_Busca", "dgopes", "", ;
            "Buscar Grupo Operacional")

        IF VARTYPE(loc_oBusca) = "O"
            loc_oBusca.mAddColuna("dgopes", "", "Grupo Operacional")
            loc_oBusca.mAddColuna("ngopes", "", "N" + CHR(186))
            loc_oBusca.Show()

            IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
                loc_cDgopes = ALLTRIM(cursor_4c_Busca.dgopes)
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    LOCATE FOR ALLTRIM(dgopes) = loc_cDgopes
                ENDIF
            ENDIF

            loc_oBusca.Release()
        ENDIF

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - Salva o registro atual (Inserir ou Atualizar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lResultado, loc_cDgopes
        loc_lResultado = .F.
        loc_cDgopes    = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Dgope.Value)

        IF EMPTY(loc_cDgopes)
            MsgAviso("Informe o Grupo Operacional.", "")
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            THIS.this_oBusinessObject.SalvarOperacoes(;
                THIS.this_oBusinessObject.this_cDgopes, "cursor_4c_Operacoes")
            MsgInfo("Registro salvo com sucesso!", "")
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
            THIS.AlternarPagina(1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnMontaListaClick - Lista operacoes do grupo selecionado (equivalente SigLlOpe)
    *--------------------------------------------------------------------------
    PROCEDURE BtnMontaListaClick()
        LOCAL loc_cDgopes, loc_cTexto, loc_cArqTmp, loc_nCount

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR ;
                RECCOUNT("cursor_4c_Dados") = 0
            MsgAviso("Selecione um grupo operacional na lista.", "")
            RETURN
        ENDIF

        loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)

        TRY
            IF THIS.this_oBusinessObject.BuscarOperacoes(loc_cDgopes)
                loc_nCount = RECCOUNT("cursor_4c_Operacoes")
                IF loc_nCount = 0
                    MsgInfo("O grupo [" + loc_cDgopes + ;
                        "] n" + CHR(227) + "o possui opera" + CHR(231) + CHR(245) + ;
                        "es cadastradas.", ;
                        "Listagem de Opera" + CHR(231) + CHR(245) + "es")
                ELSE
                    loc_cTexto = "LISTAGEM DE OPERA" + CHR(199) + CHR(213) + "ES" + CHR(13) + CHR(10) + ;
                        "Grupo Operacional: " + loc_cDgopes + CHR(13) + CHR(10) + ;
                        "Total: " + TRANSFORM(loc_nCount) + " registro(s)" + CHR(13) + CHR(10) + ;
                        REPLICATE("=", 60) + CHR(13) + CHR(10) + ;
                        PADR("Opera" + CHR(231) + CHR(227) + "o Poss" + CHR(237) + "vel", 22) + ;
                        PADR("Opera" + CHR(231) + CHR(227) + "o Confer" + CHR(234) + "ncia", 22) + ;
                        CHR(13) + CHR(10) + REPLICATE("-", 60) + CHR(13) + CHR(10)

                    SELECT cursor_4c_Operacoes
                    GO TOP
                    SCAN
                        loc_cTexto = loc_cTexto + ;
                            PADR(ALLTRIM(cursor_4c_Operacoes.dopers),  22) + ;
                            PADR(ALLTRIM(cursor_4c_Operacoes.confops), 22) + ;
                            CHR(13) + CHR(10)
                    ENDSCAN

                    loc_cArqTmp = ADDBS(SYS(2023)) + "ListaOps_" + loc_cDgopes + "_" + ;
                        SYS(2015) + ".txt"
                    STRTOFILE(loc_cTexto, loc_cArqTmp)

                    IF FILE(loc_cArqTmp)
                        RUN /N NOTEPAD.EXE "&loc_cArqTmp"
                    ELSE
                        MsgErro("Falha ao gerar arquivo de listagem.", "Erro")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro BtnMontaListaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImpXMLClick - Importa XML de grupo operacional (equivalente SigOpXml modo I)
    *--------------------------------------------------------------------------
    PROCEDURE BtnImpXMLClick()
        LOCAL loc_cArquivo, loc_cXML, loc_cDgopes, loc_nResultado, loc_cSQL
        LOCAL loc_lProsseguir, loc_lJaExiste

        loc_cArquivo = GETFILE("XML", "Selecionar XML para importar", "Abrir")
        IF EMPTY(loc_cArquivo) OR !FILE(loc_cArquivo)
            RETURN
        ENDIF

        TRY
            loc_lProsseguir = .T.
            loc_cXML        = FILETOSTR(loc_cArquivo)

            IF EMPTY(loc_cXML)
                MsgErro("Arquivo XML vazio ou ileg" + CHR(237) + "vel.", "Erro")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF USED("cursor_4c_XMLImp")
                    USE IN cursor_4c_XMLImp
                ENDIF
                XMLTOCURSOR(loc_cXML, "cursor_4c_XMLImp")

                IF !USED("cursor_4c_XMLImp") OR RECCOUNT("cursor_4c_XMLImp") = 0
                    MsgErro("XML inv" + CHR(225) + "lido ou vazio.", "Erro")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_XMLImp
                GO TOP

                IF TYPE("cursor_4c_XMLImp.dgopes") = "U"
                    MsgErro("XML n" + CHR(227) + "o possui a coluna 'dgopes'.", "Erro")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_cDgopes = ALLTRIM(cursor_4c_XMLImp.dgopes)
                IF EMPTY(loc_cDgopes)
                    MsgErro("Grupo operacional vazio no XML.", "Erro")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Verificar se ja existe
                loc_cSQL = "SELECT dgopes FROM SigCdGpe WHERE dgopes = " + ;
                    EscaparSQL(loc_cDgopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_XMLChk")
                loc_lJaExiste  = (loc_nResultado >= 0 AND USED("cursor_4c_XMLChk") AND ;
                                  RECCOUNT("cursor_4c_XMLChk") > 0)

                IF loc_lJaExiste
                    IF MsgConfirma("Grupo [" + loc_cDgopes + ;
                            "] j" + CHR(225) + " existe. Substituir?", ;
                            "Confirma" + CHR(231) + CHR(227) + "o")
                        loc_cSQL = "DELETE FROM SigCdGpe WHERE dgopes = " + ;
                            EscaparSQL(loc_cDgopes)
                        SQLEXEC(gnConnHandle, loc_cSQL)
                    ELSE
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_XMLChk")
                    USE IN cursor_4c_XMLChk
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Inserir usando o BO (via CarregarDoCursor + Salvar)
                IF THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_XMLImp")
                    THIS.this_oBusinessObject.NovoRegistro()
                    THIS.this_oBusinessObject.this_cDgopes = loc_cDgopes
                    IF THIS.this_oBusinessObject.Salvar()
                        MsgInfo("Grupo [" + loc_cDgopes + ;
                            "] importado com sucesso!", ;
                            "Importa" + CHR(231) + CHR(227) + "o")
                        THIS.CarregarLista()
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_XMLImp")
                USE IN cursor_4c_XMLImp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro BtnImpXMLClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExpXMLClick - Exporta grupo selecionado em XML (equivalente SigOpXml modo E)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExpXMLClick()
        LOCAL loc_cDgopes, loc_cArquivo, loc_cXML, loc_cSQL, loc_nResultado
        LOCAL loc_lProsseguir

        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro na lista.", "")
            RETURN
        ENDIF

        loc_cDgopes = ALLTRIM(cursor_4c_Dados.dgopes)
        IF EMPTY(loc_cDgopes)
            MsgAviso("Grupo operacional inv" + CHR(225) + "lido.", "")
            RETURN
        ENDIF

        loc_cArquivo = PUTFILE("Salvar como", ;
            "GrupoOper_" + loc_cDgopes + ".xml", "XML")
        IF EMPTY(loc_cArquivo)
            RETURN
        ENDIF

        TRY
            loc_lProsseguir = .T.
            loc_cSQL        = "SELECT * FROM SigCdGpe WHERE dgopes = " + ;
                EscaparSQL(loc_cDgopes)
            loc_nResultado  = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_XMLExp")

            IF loc_nResultado < 0 OR !USED("cursor_4c_XMLExp") OR ;
                    RECCOUNT("cursor_4c_XMLExp") = 0
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o grupo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro")
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_cXML = ""
                CURSORTOXML("cursor_4c_XMLExp", "loc_cXML", 1, 512, 0, "1")

                IF EMPTY(loc_cXML)
                    MsgErro("Falha ao gerar XML.", "Erro")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                STRTOFILE(loc_cXML, loc_cArquivo)

                IF FILE(loc_cArquivo)
                    MsgInfo("Grupo [" + loc_cDgopes + ;
                        "] exportado para:" + CHR(13) + loc_cArquivo, ;
                        "Exporta" + CHR(231) + CHR(227) + "o")
                ELSE
                    MsgErro("Falha ao gravar arquivo XML.", "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro BtnExpXMLClick")
        ENDTRY

        IF USED("cursor_4c_XMLExp")
            USE IN cursor_4c_XMLExp
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIconeClick - Abre seletor de arquivo .ico para o grupo
    *--------------------------------------------------------------------------
    PROCEDURE BtnIconeClick()
        LOCAL loc_cArquivo, loc_txt, loc_img

        TRY
            loc_cArquivo = GetFile("ico;bmp;jpg;png", "Selecionar " + CHR(205) + "cone", "Selecionar")
            IF !EMPTY(loc_cArquivo)
                loc_txt = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Carqicones
                loc_img = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.img_4c_Icone
                IF VARTYPE(loc_txt) = "O"
                    loc_txt.Value = loc_cArquivo
                ENDIF
                IF VARTYPE(loc_img) = "O"
                    loc_img.Picture = loc_cArquivo
                    loc_img.Visible = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIconeClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Formata visual do grid da lista
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_SOMBRA")
                    IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                        THIS.TornarControlesVisiveis(loc_oObjeto)
                    ENDIF
                    LOOP
                ENDIF

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

    *--------------------------------------------------------------------------
    * Destroy - Limpeza ao fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF

        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF

        IF USED("cursor_4c_BuscaSub")
            USE IN cursor_4c_BuscaSub
        ENDIF

        IF USED("cursor_4c_BuscaLcl")
            USE IN cursor_4c_BuscaLcl
        ENDIF

        IF USED("cursor_4c_BuscaSct")
            USE IN cursor_4c_BuscaSct
        ENDIF

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtSubncrsKeyPress - Enter/Tab/F4 abre lookup SigCdOpe
    *--------------------------------------------------------------------------
    PROCEDURE TxtSubncrsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupSubncrs()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtLocalsKeyPress - Enter/Tab/F4 abre lookup SigPrLcl
    *--------------------------------------------------------------------------
    PROCEDURE TxtLocalsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupLocals()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodegsKeyPress - Enter/Tab/F4 abre lookup SigCdSct
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodegsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 9, 115)
            THIS.AbrirLookupCodsegs()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupSubncrs - FormBuscaAuxiliar em SigCdOpe (campo subncrs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupSubncrs()
        LOCAL loc_oBusca, loc_cValor, loc_oTxt
        loc_cValor = ""
        loc_oTxt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Subncrs

        IF VARTYPE(loc_oTxt) = "O"
            loc_cValor = ALLTRIM(loc_oTxt.Value)
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpe", "cursor_4c_BuscaSub", "Dopes", loc_cValor, ;
                "Buscar Subn" + CHR(237) + "vel")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSub")
                    IF VARTYPE(loc_oTxt) = "O"
                        loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaSub.Dopes)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirLookupSubncrs")
        ENDTRY

        IF USED("cursor_4c_BuscaSub")
            USE IN cursor_4c_BuscaSub
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupLocals - FormBuscaAuxiliar em SigPrLcl (campo locals)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupLocals()
        LOCAL loc_oBusca, loc_cValor, loc_oTxt
        loc_cValor = ""
        loc_oTxt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Locals

        IF VARTYPE(loc_oTxt) = "O"
            loc_cValor = ALLTRIM(loc_oTxt.Value)
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigPrLcl", "cursor_4c_BuscaLcl", "Codigos", loc_cValor, ;
                "Buscar Localiza" + CHR(231) + CHR(227) + "o", .F., .T., "Tipos = 2")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLcl")
                    IF VARTYPE(loc_oTxt) = "O"
                        loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaLcl.Codigos)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirLookupLocals")
        ENDTRY

        IF USED("cursor_4c_BuscaLcl")
            USE IN cursor_4c_BuscaLcl
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCodsegs - FormBuscaAuxiliar em SigCdSct (campo codsegs)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCodsegs()
        LOCAL loc_oBusca, loc_cValor, loc_oTxt
        loc_cValor = ""
        loc_oTxt   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.txt_4c_Codsegs

        IF VARTYPE(loc_oTxt) = "O"
            loc_cValor = ALLTRIM(loc_oTxt.Value)
        ENDIF

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdSct", "cursor_4c_BuscaSct", "Codigos", loc_cValor, ;
                "Buscar Segmento")

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSct")
                    IF VARTYPE(loc_oTxt) = "O"
                        loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaSct.Codigos)
                    ENDIF
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AbrirLookupCodsegs")
        ENDTRY

        IF USED("cursor_4c_BuscaSct")
            USE IN cursor_4c_BuscaSct
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtSubncrsDblClick - DblClick abre lookup SigCdOpe
    *--------------------------------------------------------------------------
    PROCEDURE TxtSubncrsDblClick()
        THIS.AbrirLookupSubncrs()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtLocalsDblClick - DblClick abre lookup SigPrLcl
    *--------------------------------------------------------------------------
    PROCEDURE TxtLocalsDblClick()
        THIS.AbrirLookupLocals()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtCodegsDblClick - DblClick abre lookup SigCdSct
    *--------------------------------------------------------------------------
    PROCEDURE TxtCodegsDblClick()
        THIS.AbrirLookupCodsegs()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\GpeBO.prg):
* GpeBO.prg - Business Object para Cadastro de Grupos Operacionais
* Tabela principal: SigCdGpe | PK: dgopes
* Tabela filha: SigCdGpo (grid operacoes: dopers + confops)

DEFINE CLASS GpeBO AS BusinessBase

    *-- SigCdGpe: Identificacao
    this_cDgopes            = ""   && dgopes char(20) - PK Grupo Operacional
    this_nNgopes            = 0    && ngopes numeric(6,0) - Nro interno (fGerUniqueKey)

    *-- SigCdGpe: Numeracao e Controle
    this_nNumopers          = 0    && numopers numeric(1,0) - Numeracao da Operacao
    this_nNcontroles        = 0    && ncontroles numeric(1,0) - Tipo do Nro de Controle
    this_nFontnums          = 0    && fontnums numeric(1,0) - Fonte da Numeracao
    this_nLimdia            = 0    && limdia numeric(6,0) - Limite diario

    *-- SigCdGpe: Auditoria e Acesso
    this_nAudits            = 0    && audits numeric(1,0) - Auditoria (9 opcoes)
    this_nBlqadts           = 0    && blqadts numeric(1,0) - Bloqueia Alt. Data
    this_nInibfecs          = 0    && inibfecs numeric(1,0) - Inibir Botao Fechamento
    this_nInibocors         = 0    && inibocors numeric(1,0) - Inibir Botao Ocorrencia
    this_nAlterar           = 0    && alterar numeric(1,0) - Permitir Alteracao
    this_nConsulta          = 0    && consulta numeric(1,0) - Apenas Consulta
    this_nCtacusus          = 0    && ctacusus numeric(1,0) - Controlar Acesso por Usuario
    this_nSenresps          = 0    && senresps numeric(1,0) - Senha por Responsavel
    this_nAcmemps           = 0    && acmemps numeric(1,0) - Checar Acesso Muda Empresa
    this_nAnacps            = 0    && anacps numeric(1,0) - Analisar C.Pagto Fx.Cx

    *-- SigCdGpe: Situacoes (tristate)
    this_nSubniveis         = 0    && subniveis numeric(1,0) - Situacao dos Subniveis
    this_nUtilizas          = 0    && utilizas numeric(1,0) - Situacao das Operacoes
    this_nFilpagas          = 0    && filpagas numeric(1,0) - Filtro Operacoes Pagas
    this_nFilbaixas         = 0    && filbaixas numeric(1,0) - Filtro Operacoes Baixadas
    this_nOputiliza         = 0    && oputiliza numeric(1,0) - Operacoes Utilizadas
    this_nMontagem          = 0    && montagem numeric(1,0) - Produtos Com Montagem
    this_nQualquer          = 0    && qualquer numeric(1,0) - Ignorar Grupo Operacional
    this_nChkmercs          = 0    && chkmercs numeric(1,0) - Checar Mercadorias
    this_nProds             = 0    && prods numeric(1,0) - Ordem de Producao
    this_nDesutils          = 0    && desutils numeric(1,0) - Desagendar Utilizados
    this_nIniagenda         = 0    && iniagenda numeric(1,0) - Exibir botao F8 - AGENDA

    *-- SigCdGpe: Operacoes em filtro (ordem grade)
    this_nOpagends          = 0    && opagends numeric(1,0) - Operacoes Agendadas (filtro lista)
    this_nOppagas           = 0    && oppagas numeric(1,0) - Operacoes Pagas (filtro lista)
    this_nOppends           = 0    && oppends numeric(1,0) - Operacoes Todas/Agend./Nao-Agend.
    this_nOrdemas           = 0    && ordemas numeric(1,0) - Ordem das Agendadas (combobox)
    this_nOrdemns           = 0    && ordemns numeric(1,0) - Ordem das Nao-Agendadas (combobox)
    this_nOrdems            = 0    && ordems numeric(1,0) - Ordem de Todas (combobox)

    *-- SigCdGpe: Fixar ordenacao
    this_nFixaps            = 0    && fixaps numeric(1,0) - Fixa Pagas (checkbox)
    this_nFixaas            = 0    && fixaas numeric(1,0) - Fixa Agendadas (checkbox)
    this_nFixals            = 0    && fixals numeric(1,0) - Fixa Livres (checkbox Check1)
    this_nFixags            = 0    && fixags numeric(1,0) - Fixa Geral (checkbox)
    this_nFixass            = 0    && fixass numeric(1,0) - Fixa Sessao (checkbox Check2)

    *-- SigCdGpe: Utilizar recursos
    this_nResps             = 0    && resps numeric(1,0) - Utiliza Responsavel
    this_nContas            = 0    && contas numeric(1,0) - Utiliza Conta
    this_nEmpresas          = 0    && empresas numeric(1,0) - Utiliza Empresa
    this_nVends             = 0    && vends numeric(1,0) - Senha por Responsavel (Vendas)
    this_nSacs              = 0    && sacs numeric(1,0) - Checar SAC
    this_nVolumes           = 0    && volumes numeric(1,0) - Quantidade de Volumes
    this_nPeriodos          = 0    && periodos numeric(1,0) - Utiliza Periodo Configuracao
    this_nEntregas          = 0    && entregas numeric(1,0) - Utiliza Periodo Entrega
    this_nOperacoes         = 0    && operacoes numeric(1,0) - Utiliza Periodo Operacao
    this_nEstdisps          = 0    && estdisps numeric(1,0) - Estoque Disponivel
    this_nDtatuals          = 0    && dtatuals numeric(1,0) - Utilizar Data Atual
    this_nGeracrs           = 0    && geracrs numeric(1,0) - Gera Controle de Subniveis
    this_nChkreserva        = 0    && chkreserva numeric(1,0) - Credito/Bonus (optReserva)
    this_nMultiimps         = 0    && multiimps numeric(1,0) - Imprime Documentos
    this_nRoadshows         = 0    && roadshows numeric(1,0)
    this_nTpbloqueio        = 0    && tpbloqueio numeric(1,0) - Tipo de Bloqueio
    this_nChdtentrs         = 0    && chdtentrs numeric(1,0) - Checar Data de Entrega

    *-- SigCdGpe: Campos texto
    this_cSubncrs           = ""   && subncrs char(20) - Subnivel (lookup SigCdOpe)
    this_cLocals            = ""   && locals char(10) - Localizacao Padrao
    this_cCodsegs           = ""   && codsegs char(10) - Segmento Padrao (lookup SigCdSct)
    this_cCarqicones        = ""   && carqicones char(64) - Arquivo de icone
    this_cDopes             = ""   && dopes char(20) - Operacao Padrao (lookup SigCdOpe)
    this_cTproads           = ""   && tproads char(15)

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGpe"
        THIS.this_cCampoChave = "dgopes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cDgopes
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista SigCdGpe em cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dgopes, ngopes FROM SigCdGpe"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY dgopes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos operacionais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega SigCdGpe pelo codigo do grupo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cDgopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dgopes, ngopes, numopers, ncontroles, fontnums, limdia," + ;
                " audits, blqadts, inibfecs, inibocors, alterar, consulta, ctacusus," + ;
                " senresps, acmemps, anacps, subniveis, utilizas, filpagas, filbaixas," + ;
                " oputiliza, montagem, qualquer, chkmercs, prods, desutils, iniagenda," + ;
                " opagends, oppagas, oppends, ordemas, ordemns, ordems," + ;
                " fixaps, fixaas, fixals, fixags, fixass," + ;
                " resps, contas, empresas, vends, sacs, volumes, periodos, entregas," + ;
                " operacoes, estdisps, dtatuals, geracrs, chkreserva, multiimps," + ;
                " roadshows, tpbloqueio, chdtentrs," + ;
                " subncrs, locals, codsegs, carqicones, dopes, tproads" + ;
                " FROM SigCdGpe WHERE dgopes = " + EscaparSQL(par_cDgopes)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar grupo operacional:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    * OBRIGATORIO: SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cDgopes       = TratarNulo(dgopes, "C")
            THIS.this_nNgopes       = TratarNulo(ngopes, "N")
            THIS.this_nNumopers     = TratarNulo(numopers, "N")
            THIS.this_nNcontroles   = TratarNulo(ncontroles, "N")
            THIS.this_nFontnums     = TratarNulo(fontnums, "N")
            THIS.this_nLimdia       = TratarNulo(limdia, "N")
            THIS.this_nAudits       = TratarNulo(audits, "N")
            THIS.this_nBlqadts      = TratarNulo(blqadts, "N")
            THIS.this_nInibfecs     = TratarNulo(inibfecs, "N")
            THIS.this_nInibocors    = TratarNulo(inibocors, "N")
            THIS.this_nAlterar      = TratarNulo(alterar, "N")
            THIS.this_nConsulta     = TratarNulo(consulta, "N")
            THIS.this_nCtacusus     = TratarNulo(ctacusus, "N")
            THIS.this_nSenresps     = TratarNulo(senresps, "N")
            THIS.this_nAcmemps      = TratarNulo(acmemps, "N")
            THIS.this_nAnacps       = TratarNulo(anacps, "N")
            THIS.this_nSubniveis    = TratarNulo(subniveis, "N")
            THIS.this_nUtilizas     = TratarNulo(utilizas, "N")
            THIS.this_nFilpagas     = TratarNulo(filpagas, "N")
            THIS.this_nFilbaixas    = TratarNulo(filbaixas, "N")
            THIS.this_nOputiliza    = TratarNulo(oputiliza, "N")
            THIS.this_nMontagem     = TratarNulo(montagem, "N")
            THIS.this_nQualquer     = TratarNulo(qualquer, "N")
            THIS.this_nChkmercs     = TratarNulo(chkmercs, "N")
            THIS.this_nProds        = TratarNulo(prods, "N")
            THIS.this_nDesutils     = TratarNulo(desutils, "N")
            THIS.this_nIniagenda    = TratarNulo(iniagenda, "N")
            THIS.this_nOpagends     = TratarNulo(opagends, "N")
            THIS.this_nOppagas      = TratarNulo(oppagas, "N")
            THIS.this_nOppends      = TratarNulo(oppends, "N")
            THIS.this_nOrdemas      = TratarNulo(ordemas, "N")
            THIS.this_nOrdemns      = TratarNulo(ordemns, "N")
            THIS.this_nOrdems       = TratarNulo(ordems, "N")
            THIS.this_nFixaps       = TratarNulo(fixaps, "N")
            THIS.this_nFixaas       = TratarNulo(fixaas, "N")
            THIS.this_nFixals       = TratarNulo(fixals, "N")
            THIS.this_nFixags       = TratarNulo(fixags, "N")
            THIS.this_nFixass       = TratarNulo(fixass, "N")
            THIS.this_nResps        = TratarNulo(resps, "N")
            THIS.this_nContas       = TratarNulo(contas, "N")
            THIS.this_nEmpresas     = TratarNulo(empresas, "N")
            THIS.this_nVends        = TratarNulo(vends, "N")
            THIS.this_nSacs         = TratarNulo(sacs, "N")
            THIS.this_nVolumes      = TratarNulo(volumes, "N")
            THIS.this_nPeriodos     = TratarNulo(periodos, "N")
            THIS.this_nEntregas     = TratarNulo(entregas, "N")
            THIS.this_nOperacoes    = TratarNulo(operacoes, "N")
            THIS.this_nEstdisps     = TratarNulo(estdisps, "N")
            THIS.this_nDtatuals     = TratarNulo(dtatuals, "N")
            THIS.this_nGeracrs      = TratarNulo(geracrs, "N")
            THIS.this_nChkreserva   = TratarNulo(chkreserva, "N")
            THIS.this_nMultiimps    = TratarNulo(multiimps, "N")
            THIS.this_nRoadshows    = TratarNulo(roadshows, "N")
            THIS.this_nTpbloqueio   = TratarNulo(tpbloqueio, "N")
            THIS.this_nChdtentrs    = TratarNulo(chdtentrs, "N")
            THIS.this_cSubncrs      = TratarNulo(subncrs, "C")
            THIS.this_cLocals       = TratarNulo(locals, "C")
            THIS.this_cCodsegs      = TratarNulo(codsegs, "C")
            THIS.this_cCarqicones   = TratarNulo(carqicones, "C")
            THIS.this_cDopes        = TratarNulo(dopes, "C")
            THIS.this_cTproads      = TratarNulo(tproads, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdGpe
    * ngopes gerado via fGerUniqueKey("SigCdGpe")
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.this_nNgopes = fGerUniqueKey("SigCdGpe")

            loc_cSQL = "INSERT INTO SigCdGpe (" + ;
                "dgopes, ngopes, numopers, ncontroles, fontnums, limdia," + ;
                " audits, blqadts, inibfecs, inibocors, alterar, consulta, ctacusus," + ;
                " senresps, acmemps, anacps, subniveis, utilizas, filpagas, filbaixas," + ;
                " oputiliza, montagem, qualquer, chkmercs, prods, desutils, iniagenda," + ;
                " opagends, oppagas, oppends, ordemas, ordemns, ordems," + ;
                " fixaps, fixaas, fixals, fixags, fixass," + ;
                " resps, contas, empresas, vends, sacs, volumes, periodos, entregas," + ;
                " operacoes, estdisps, dtatuals, geracrs, chkreserva, multiimps," + ;
                " roadshows, tpbloqueio, chdtentrs," + ;
                " subncrs, locals, codsegs, carqicones, dopes, tproads" + ;
                ") VALUES (" + ;
                EscaparSQL(THIS.this_cDgopes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNgopes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumopers) + "," + ;
                FormatarNumeroSQL(THIS.this_nNcontroles) + "," + ;
                FormatarNumeroSQL(THIS.this_nFontnums) + "," + ;
                FormatarNumeroSQL(THIS.this_nLimdia) + "," + ;
                FormatarNumeroSQL(THIS.this_nAudits) + "," + ;
                FormatarNumeroSQL(THIS.this_nBlqadts) + "," + ;
                FormatarNumeroSQL(THIS.this_nInibfecs) + "," + ;
                FormatarNumeroSQL(THIS.this_nInibocors) + "," + ;
                FormatarNumeroSQL(THIS.this_nAlterar) + "," + ;
                FormatarNumeroSQL(THIS.this_nConsulta) + "," + ;
                FormatarNumeroSQL(THIS.this_nCtacusus) + "," + ;
                FormatarNumeroSQL(THIS.this_nSenresps) + "," + ;
                FormatarNumeroSQL(THIS.this_nAcmemps) + "," + ;
                FormatarNumeroSQL(THIS.this_nAnacps) + "," + ;
                FormatarNumeroSQL(THIS.this_nSubniveis) + "," + ;
                FormatarNumeroSQL(THIS.this_nUtilizas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFilpagas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFilbaixas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOputiliza) + "," + ;
                FormatarNumeroSQL(THIS.this_nMontagem) + "," + ;
                FormatarNumeroSQL(THIS.this_nQualquer) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkmercs) + "," + ;
                FormatarNumeroSQL(THIS.this_nProds) + "," + ;
                FormatarNumeroSQL(THIS.this_nDesutils) + "," + ;
                FormatarNumeroSQL(THIS.this_nIniagenda) + "," + ;
                FormatarNumeroSQL(THIS.this_nOpagends) + "," + ;
                FormatarNumeroSQL(THIS.this_nOppagas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOppends) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdemas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdemns) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdems) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixaps) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixaas) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixals) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixags) + "," + ;
                FormatarNumeroSQL(THIS.this_nFixass) + "," + ;
                FormatarNumeroSQL(THIS.this_nResps) + "," + ;
                FormatarNumeroSQL(THIS.this_nContas) + "," + ;
                FormatarNumeroSQL(THIS.this_nEmpresas) + "," + ;
                FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                FormatarNumeroSQL(THIS.this_nSacs) + "," + ;
                FormatarNumeroSQL(THIS.this_nVolumes) + "," + ;
                FormatarNumeroSQL(THIS.this_nPeriodos) + "," + ;
                FormatarNumeroSQL(THIS.this_nEntregas) + "," + ;
                FormatarNumeroSQL(THIS.this_nOperacoes) + "," + ;
                FormatarNumeroSQL(THIS.this_nEstdisps) + "," + ;
                FormatarNumeroSQL(THIS.this_nDtatuals) + "," + ;
                FormatarNumeroSQL(THIS.this_nGeracrs) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkreserva) + "," + ;
                FormatarNumeroSQL(THIS.this_nMultiimps) + "," + ;
                FormatarNumeroSQL(THIS.this_nRoadshows) + "," + ;
                FormatarNumeroSQL(THIS.this_nTpbloqueio) + "," + ;
                FormatarNumeroSQL(THIS.this_nChdtentrs) + "," + ;
                EscaparSQL(THIS.this_cSubncrs) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cCodsegs) + "," + ;
                EscaparSQL(THIS.this_cCarqicones) + "," + ;
                EscaparSQL(THIS.this_cDopes) + "," + ;
                EscaparSQL(THIS.this_cTproads) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir grupo operacional:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdGpe (nao atualiza dgopes/ngopes - sao PK/chave)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGpe SET" + ;
                " numopers = " + FormatarNumeroSQL(THIS.this_nNumopers) + ;
                ", ncontroles = " + FormatarNumeroSQL(THIS.this_nNcontroles) + ;
                ", fontnums = " + FormatarNumeroSQL(THIS.this_nFontnums) + ;
                ", limdia = " + FormatarNumeroSQL(THIS.this_nLimdia) + ;
                ", audits = " + FormatarNumeroSQL(THIS.this_nAudits) + ;
                ", blqadts = " + FormatarNumeroSQL(THIS.this_nBlqadts) + ;
                ", inibfecs = " + FormatarNumeroSQL(THIS.this_nInibfecs) + ;
                ", inibocors = " + FormatarNumeroSQL(THIS.this_nInibocors) + ;
                ", alterar = " + FormatarNumeroSQL(THIS.this_nAlterar) + ;
                ", consulta = " + FormatarNumeroSQL(THIS.this_nConsulta) + ;
                ", ctacusus = " + FormatarNumeroSQL(THIS.this_nCtacusus) + ;
                ", senresps = " + FormatarNumeroSQL(THIS.this_nSenresps) + ;
                ", acmemps = " + FormatarNumeroSQL(THIS.this_nAcmemps) + ;
                ", anacps = " + FormatarNumeroSQL(THIS.this_nAnacps) + ;
                ", subniveis = " + FormatarNumeroSQL(THIS.this_nSubniveis) + ;
                ", utilizas = " + FormatarNumeroSQL(THIS.this_nUtilizas) + ;
                ", filpagas = " + FormatarNumeroSQL(THIS.this_nFilpagas) + ;
                ", filbaixas = " + FormatarNumeroSQL(THIS.this_nFilbaixas) + ;
                ", oputiliza = " + FormatarNumeroSQL(THIS.this_nOputiliza) + ;
                ", montagem = " + FormatarNumeroSQL(THIS.this_nMontagem) + ;
                ", qualquer = " + FormatarNumeroSQL(THIS.this_nQualquer) + ;
                ", chkmercs = " + FormatarNumeroSQL(THIS.this_nChkmercs) + ;
                ", prods = " + FormatarNumeroSQL(THIS.this_nProds) + ;
                ", desutils = " + FormatarNumeroSQL(THIS.this_nDesutils) + ;
                ", iniagenda = " + FormatarNumeroSQL(THIS.this_nIniagenda) + ;
                ", opagends = " + FormatarNumeroSQL(THIS.this_nOpagends) + ;
                ", oppagas = " + FormatarNumeroSQL(THIS.this_nOppagas) + ;
                ", oppends = " + FormatarNumeroSQL(THIS.this_nOppends) + ;
                ", ordemas = " + FormatarNumeroSQL(THIS.this_nOrdemas) + ;
                ", ordemns = " + FormatarNumeroSQL(THIS.this_nOrdemns) + ;
                ", ordems = " + FormatarNumeroSQL(THIS.this_nOrdems) + ;
                ", fixaps = " + FormatarNumeroSQL(THIS.this_nFixaps) + ;
                ", fixaas = " + FormatarNumeroSQL(THIS.this_nFixaas) + ;
                ", fixals = " + FormatarNumeroSQL(THIS.this_nFixals) + ;
                ", fixags = " + FormatarNumeroSQL(THIS.this_nFixags) + ;
                ", fixass = " + FormatarNumeroSQL(THIS.this_nFixass) + ;
                ", resps = " + FormatarNumeroSQL(THIS.this_nResps) + ;
                ", contas = " + FormatarNumeroSQL(THIS.this_nContas) + ;
                ", empresas = " + FormatarNumeroSQL(THIS.this_nEmpresas) + ;
                ", vends = " + FormatarNumeroSQL(THIS.this_nVends) + ;
                ", sacs = " + FormatarNumeroSQL(THIS.this_nSacs) + ;
                ", volumes = " + FormatarNumeroSQL(THIS.this_nVolumes) + ;
                ", periodos = " + FormatarNumeroSQL(THIS.this_nPeriodos) + ;
                ", entregas = " + FormatarNumeroSQL(THIS.this_nEntregas) + ;
                ", operacoes = " + FormatarNumeroSQL(THIS.this_nOperacoes) + ;
                ", estdisps = " + FormatarNumeroSQL(THIS.this_nEstdisps) + ;
                ", dtatuals = " + FormatarNumeroSQL(THIS.this_nDtatuals) + ;
                ", geracrs = " + FormatarNumeroSQL(THIS.this_nGeracrs) + ;
                ", chkreserva = " + FormatarNumeroSQL(THIS.this_nChkreserva) + ;
                ", multiimps = " + FormatarNumeroSQL(THIS.this_nMultiimps) + ;
                ", roadshows = " + FormatarNumeroSQL(THIS.this_nRoadshows) + ;
                ", tpbloqueio = " + FormatarNumeroSQL(THIS.this_nTpbloqueio) + ;
                ", chdtentrs = " + FormatarNumeroSQL(THIS.this_nChdtentrs) + ;
                ", subncrs = " + EscaparSQL(THIS.this_cSubncrs) + ;
                ", locals = " + EscaparSQL(THIS.this_cLocals) + ;
                ", codsegs = " + EscaparSQL(THIS.this_cCodsegs) + ;
                ", carqicones = " + EscaparSQL(THIS.this_cCarqicones) + ;
                ", dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                ", tproads = " + EscaparSQL(THIS.this_cTproads) + ;
                " WHERE dgopes = " + EscaparSQL(THIS.this_cDgopes)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo operacional:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdGpe e registros filhos SigCdGpo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- Excluir operacoes filhas em SigCdGpo
            loc_cSQL = "DELETE FROM SigCdGpo WHERE dgopes = " + ;
                EscaparSQL(THIS.this_cDgopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es do grupo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir registro principal
                loc_cSQL = "DELETE FROM SigCdGpe WHERE dgopes = " + ;
                    EscaparSQL(THIS.this_cDgopes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir grupo operacional:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega SigCdGpo (grid de operacoes) em cursor_4c_Operacoes
    * SigCdGpo: dgopes(FK), dopers(op. possivel), confops(op. conferencia), cidchaves(PK)
    *--------------------------------------------------------------------------
    FUNCTION BuscarOperacoes(par_cDgopes)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT dopers, confops, cidchaves FROM SigCdGpo" + ;
                " WHERE dgopes = " + EscaparSQL(par_cDgopes) + ;
                " ORDER BY cidchaves"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Operacoes")
                TABLEREVERT(.T., "cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarOperacoes - Persiste grid de operacoes (SigCdGpo) do grupo
    * par_cDgopes: codigo do grupo
    * par_cCursorOps: nome do cursor com linhas editadas (campos: dopers, confops)
    * Estrategia: DELETE todas + INSERT das linhas nao vazias
    *--------------------------------------------------------------------------
    FUNCTION SalvarOperacoes(par_cDgopes, par_cCursorOps)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_nLinha, loc_cChave
        LOCAL loc_cDopers, loc_cConfops
        loc_lResultado = .F.

        TRY
            *-- Excluir todas as operacoes do grupo
            loc_cSQL = "DELETE FROM SigCdGpo WHERE dgopes = " + EscaparSQL(par_cDgopes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar opera" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
                IF USED(par_cCursorOps) AND RECCOUNT(par_cCursorOps) > 0
                    SELECT (par_cCursorOps)
                    GO TOP
                    loc_nLinha = 0
                    DO WHILE !EOF() AND loc_lResultado
                        loc_cDopers  = ALLTRIM(dopers)
                        loc_cConfops = ALLTRIM(confops)
                        IF !EMPTY(loc_cDopers)
                            loc_nLinha = loc_nLinha + 1
                            loc_cChave = LEFT(ALLTRIM(par_cDgopes) + ;
                                STR(loc_nLinha, 6), 20)
                            loc_cSQL = "INSERT INTO SigCdGpo" + ;
                                " (dgopes, dopers, confops, cidchaves) VALUES (" + ;
                                EscaparSQL(par_cDgopes) + "," + ;
                                EscaparSQL(loc_cDopers) + "," + ;
                                EscaparSQL(loc_cConfops) + "," + ;
                                EscaparSQL(loc_cChave) + ")"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + ;
                                    "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lResultado = .F.
                            ENDIF
                        ENDIF
                        SKIP
                    ENDDO
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

