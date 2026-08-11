# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 6/10
- Mensagem: TIMEOUT: VFP9 travou durante teste automatico (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-09 05:25:48] [INFO] Config FPW: (nao fornecido)
[2026-08-09 05:25:48] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 05:25:48] [INFO] Timeout: 300 segundos
[2026-08-09 05:25:48] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1gy3opow.prg
[2026-08-09 05:25:48] [INFO] Conteudo do wrapper:
[2026-08-09 05:25:48] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICM', 'C:\4c\tasks\task447', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
QUIT

[2026-08-09 05:25:48] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1gy3opow.prg
[2026-08-09 05:25:48] [INFO] VFP output esperado em: C:\4c\tasks\task447\vfp_output.txt
[2026-08-09 05:25:48] [INFO] Executando Visual FoxPro 9...
[2026-08-09 05:25:48] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1gy3opow.prg
[2026-08-09 05:25:48] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1gy3opow.prg
[2026-08-09 05:25:48] [INFO] Timeout configurado: 300 segundos
[2026-08-09 05:30:48] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 14704)...
[2026-08-09 05:30:50] [INFO] VFP9 finalizado em 302.0698562 segundos
[2026-08-09 05:30:50] [INFO] Exit Code: 4
[2026-08-09 05:30:50] [INFO] 
[2026-08-09 05:30:50] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 05:30:50] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_1gy3opow.prg
[2026-08-09 05:30:50] [INFO] 
[2026-08-09 05:30:50] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 05:30:50] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 05:30:50] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 05:30:50] [INFO] * Parameters: 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
[2026-08-09 05:30:50] [INFO] 
[2026-08-09 05:30:50] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 05:30:50] [INFO] SET SAFETY OFF
[2026-08-09 05:30:50] [INFO] SET RESOURCE OFF
[2026-08-09 05:30:50] [INFO] SET TALK OFF
[2026-08-09 05:30:50] [INFO] SET NOTIFY OFF
[2026-08-09 05:30:50] [INFO] SYS(2335, 0)
[2026-08-09 05:30:50] [INFO] 
[2026-08-09 05:30:50] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
[2026-08-09 05:30:50] [INFO] QUIT
[2026-08-09 05:30:50] [INFO] 
[2026-08-09 05:30:50] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 05:30:50] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 05:31:59] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 05:31:59] [INFO] Config FPW: (nao fornecido)
[2026-08-09 05:31:59] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 05:31:59] [INFO] Timeout: 300 segundos
[2026-08-09 05:31:59] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q1rqhzaa.prg
[2026-08-09 05:31:59] [INFO] Conteudo do wrapper:
[2026-08-09 05:31:59] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICM', 'C:\4c\tasks\task447', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
QUIT

[2026-08-09 05:31:59] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q1rqhzaa.prg
[2026-08-09 05:31:59] [INFO] VFP output esperado em: C:\4c\tasks\task447\vfp_output.txt
[2026-08-09 05:31:59] [INFO] Executando Visual FoxPro 9...
[2026-08-09 05:31:59] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q1rqhzaa.prg
[2026-08-09 05:31:59] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q1rqhzaa.prg
[2026-08-09 05:31:59] [INFO] Timeout configurado: 300 segundos
[2026-08-09 05:36:59] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 9684)...
[2026-08-09 05:37:01] [INFO] VFP9 finalizado em 302.0697316 segundos
[2026-08-09 05:37:01] [INFO] Exit Code: 4
[2026-08-09 05:37:01] [INFO] 
[2026-08-09 05:37:01] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 05:37:01] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_q1rqhzaa.prg
[2026-08-09 05:37:01] [INFO] 
[2026-08-09 05:37:01] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 05:37:01] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 05:37:01] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 05:37:01] [INFO] * Parameters: 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
[2026-08-09 05:37:01] [INFO] 
[2026-08-09 05:37:01] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 05:37:01] [INFO] SET SAFETY OFF
[2026-08-09 05:37:01] [INFO] SET RESOURCE OFF
[2026-08-09 05:37:01] [INFO] SET TALK OFF
[2026-08-09 05:37:01] [INFO] SET NOTIFY OFF
[2026-08-09 05:37:01] [INFO] SYS(2335, 0)
[2026-08-09 05:37:01] [INFO] 
[2026-08-09 05:37:01] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
[2026-08-09 05:37:01] [INFO] QUIT
[2026-08-09 05:37:01] [INFO] 
[2026-08-09 05:37:01] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 05:37:01] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 05:38:29] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 05:38:29] [INFO] Config FPW: (nao fornecido)
[2026-08-09 05:38:29] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 05:38:29] [INFO] Timeout: 300 segundos
[2026-08-09 05:38:29] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h2roditc.prg
[2026-08-09 05:38:29] [INFO] Conteudo do wrapper:
[2026-08-09 05:38:29] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICM', 'C:\4c\tasks\task447', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
QUIT

[2026-08-09 05:38:29] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h2roditc.prg
[2026-08-09 05:38:29] [INFO] VFP output esperado em: C:\4c\tasks\task447\vfp_output.txt
[2026-08-09 05:38:29] [INFO] Executando Visual FoxPro 9...
[2026-08-09 05:38:29] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h2roditc.prg
[2026-08-09 05:38:29] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h2roditc.prg
[2026-08-09 05:38:29] [INFO] Timeout configurado: 300 segundos
[2026-08-09 05:43:29] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 19424)...
[2026-08-09 05:43:31] [INFO] VFP9 finalizado em 302.0536805 segundos
[2026-08-09 05:43:31] [INFO] Exit Code: 4
[2026-08-09 05:43:31] [INFO] 
[2026-08-09 05:43:31] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 05:43:31] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_h2roditc.prg
[2026-08-09 05:43:31] [INFO] 
[2026-08-09 05:43:31] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 05:43:31] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 05:43:31] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 05:43:31] [INFO] * Parameters: 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
[2026-08-09 05:43:31] [INFO] 
[2026-08-09 05:43:31] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 05:43:31] [INFO] SET SAFETY OFF
[2026-08-09 05:43:31] [INFO] SET RESOURCE OFF
[2026-08-09 05:43:31] [INFO] SET TALK OFF
[2026-08-09 05:43:31] [INFO] SET NOTIFY OFF
[2026-08-09 05:43:31] [INFO] SYS(2335, 0)
[2026-08-09 05:43:31] [INFO] 
[2026-08-09 05:43:31] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
[2026-08-09 05:43:31] [INFO] QUIT
[2026-08-09 05:43:31] [INFO] 
[2026-08-09 05:43:31] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 05:43:31] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 05:44:29] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 05:44:29] [INFO] Config FPW: (nao fornecido)
[2026-08-09 05:44:29] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 05:44:29] [INFO] Timeout: 300 segundos
[2026-08-09 05:44:29] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uvlwwthw.prg
[2026-08-09 05:44:29] [INFO] Conteudo do wrapper:
[2026-08-09 05:44:29] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICM', 'C:\4c\tasks\task447', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
QUIT

[2026-08-09 05:44:29] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uvlwwthw.prg
[2026-08-09 05:44:29] [INFO] VFP output esperado em: C:\4c\tasks\task447\vfp_output.txt
[2026-08-09 05:44:29] [INFO] Executando Visual FoxPro 9...
[2026-08-09 05:44:29] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uvlwwthw.prg
[2026-08-09 05:44:29] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uvlwwthw.prg
[2026-08-09 05:44:29] [INFO] Timeout configurado: 300 segundos
[2026-08-09 05:49:29] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 4540)...
[2026-08-09 05:49:31] [INFO] VFP9 finalizado em 302.0697843 segundos
[2026-08-09 05:49:31] [INFO] Exit Code: 4
[2026-08-09 05:49:31] [INFO] 
[2026-08-09 05:49:31] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 05:49:31] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_uvlwwthw.prg
[2026-08-09 05:49:31] [INFO] 
[2026-08-09 05:49:31] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 05:49:31] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 05:49:31] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 05:49:31] [INFO] * Parameters: 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
[2026-08-09 05:49:31] [INFO] 
[2026-08-09 05:49:31] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 05:49:31] [INFO] SET SAFETY OFF
[2026-08-09 05:49:31] [INFO] SET RESOURCE OFF
[2026-08-09 05:49:31] [INFO] SET TALK OFF
[2026-08-09 05:49:31] [INFO] SET NOTIFY OFF
[2026-08-09 05:49:31] [INFO] SYS(2335, 0)
[2026-08-09 05:49:31] [INFO] 
[2026-08-09 05:49:31] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICM', 'C:\4c\tasks\task447', 'CRUD'
[2026-08-09 05:49:31] [INFO] QUIT
[2026-08-09 05:49:31] [INFO] 
[2026-08-09 05:49:31] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 05:49:31] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\cadastros\FormICM.prg):
*==============================================================================
* FormICM.prg - Formulario de Cadastro de Indices de Comissao
* Migrado de: SIGCDICM.SCX
* Tabela: SigCdCmi
* Tipo: CRUD (frmcadastro)
*==============================================================================

DEFINE CLASS FormICM AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX Fidelity)
    Height      = 600
    Width       = 1000
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Estado interno
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            THIS.Caption = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
            loc_lResultado = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- Criar BO
            THIS.this_oBusinessObject = CREATEOBJECT("ICMBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar ICMBO", "FormICM.InicializarForm")
            ELSE
                *-- Estrutura PageFrame + Containers
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Carregar lista inicial (pular se validando UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "FormICM.InicializarForm")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        THIS.pgf_4c_Paginas.Top       = -29
        THIS.pgf_4c_Paginas.Left      = 0
        THIS.pgf_4c_Paginas.Width     = THIS.Width
        THIS.pgf_4c_Paginas.Height    = THIS.Height + 29
        THIS.pgf_4c_Paginas.PageCount = 2
        THIS.pgf_4c_Paginas.Tabs      = .F.
        THIS.pgf_4c_Paginas.Visible   = .T.

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(100, 100, 100)
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(100, 100, 100)
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro com titulo (cntSombra no legado)
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
            .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
            .Top       = 15
            .Left      = 10
            .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
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
            .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
            .Top       = 18
            .Left      = 10
            .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes CRUD (Grupo_op no legado)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Incluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 5
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Visualizar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 80
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 155
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 230
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Buscar
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top = 5
            .Left = 305
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Container Encerrar (padrao canonico)
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
            .Top = 5
            .Left = 5
            .Width = 75
            .Height = 75
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .FontName    = "Tahoma"
            .FontSize    = 8
            .FontBold    = .T.
            .FontItalic  = .T.
            .Themes      = .F.
            .SpecialEffect = 0
            .WordWrap    = .T.
            .AutoSize    = .F.
            .MousePointer = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Grade no legado): Top=88+29, Left=12, Width=940
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.Top              = 117
        loc_oGrid.Left             = 12
        loc_oGrid.Width            = 940
        loc_oGrid.Height           = 470
        loc_oGrid.ColumnCount      = 9
        loc_oGrid.FontName         = "Verdana"
        loc_oGrid.FontSize         = 8
        loc_oGrid.ForeColor        = RGB(90, 90, 90)
        loc_oGrid.BackColor        = RGB(255, 255, 255)
        loc_oGrid.GridLineColor    = RGB(238, 238, 238)
        loc_oGrid.GridLines        = 3
        loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
        loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
        loc_oGrid.HighlightStyle   = 2
        loc_oGrid.DeleteMark       = .F.
        loc_oGrid.RecordMark       = .F.
        loc_oGrid.RowHeight        = 16
        loc_oGrid.ScrollBars       = 2
        loc_oGrid.ReadOnly         = .T.
        loc_oGrid.Visible          = .T.

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho escuro (igual Page1)
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
            .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
            .Top       = 15
            .Left      = 10
            .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
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
            .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
            .Top       = 18
            .Left      = 10
            .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 16
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 33   && 4 + 29
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Confirmar (Salvar)
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
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        *-- Cancelar
        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 80
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .Themes          = .F.
            .SpecialEffect   = 0
            .WordWrap        = .T.
            .AutoSize        = .F.
            .MousePointer    = 15
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *--------------------------------------------------------------------------
        *-- CAMPOS PARTE 1: Empresa, Tabela de Desconto, Cargo
        *--------------------------------------------------------------------------

        *-- [Empresa] Label
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Empresa :"
            .Top       = 206   && 177 + 29
            .Left      = 145
            .Width     = 60
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- [Empresa] Codigo (Emps)
        loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
        WITH loc_oPagina.txt_4c_Empresa
            .Value       = ""
            .Top         = 203   && 174 + 29
            .Left        = 207
            .Width       = 31
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 3
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Empresa] Descricao (RazaoSocial via SigCdEmp - somente leitura)
        loc_oPagina.AddObject("txt_4c_DEmpresa", "TextBox")
        WITH loc_oPagina.txt_4c_DEmpresa
            .Value       = ""
            .Top         = 203   && 174 + 29
            .Left        = 240
            .Width       = 290
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 60
            .BackColor   = RGB(220, 220, 220)
            .ForeColor   = RGB(0, 0, 0)
            .ReadOnly    = .T.
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Tabela de Desconto] Label
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Tabela de Desconto :"
            .Top       = 231   && 202 + 29
            .Left      = 91
            .Width     = 115
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- [Tabela de Desconto] Codigo (TabDes via SigOpTdz)
        loc_oPagina.AddObject("txt_4c_TabDes", "TextBox")
        WITH loc_oPagina.txt_4c_TabDes
            .Value       = ""
            .Top         = 228   && 199 + 29
            .Left        = 207
            .Width       = 80
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 10
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Tabela de Desconto] Descricao (Descrs via SigOpTdz - somente leitura)
        loc_oPagina.AddObject("txt_4c_DTabDes", "TextBox")
        WITH loc_oPagina.txt_4c_DTabDes
            .Value       = ""
            .Top         = 228   && 199 + 29
            .Left        = 289
            .Width       = 220
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 40
            .BackColor   = RGB(220, 220, 220)
            .ForeColor   = RGB(0, 0, 0)
            .ReadOnly    = .T.
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Cargo] Label
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Cargo :"
            .Top       = 256   && 227 + 29
            .Left      = 157
            .Width     = 49
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- [Cargo] Codigo (CCargs via SigCdCrg)
        loc_oPagina.AddObject("txt_4c_Cargo", "TextBox")
        WITH loc_oPagina.txt_4c_Cargo
            .Value       = ""
            .Top         = 253   && 224 + 29
            .Left        = 207
            .Width       = 80
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 10
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Cargo] Descricao (DCargs via SigCdCrg - somente leitura)
        loc_oPagina.AddObject("txt_4c_DCargo", "TextBox")
        WITH loc_oPagina.txt_4c_DCargo
            .Value       = ""
            .Top         = 253   && 224 + 29
            .Left        = 289
            .Width       = 150
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 40
            .BackColor   = RGB(220, 220, 220)
            .ForeColor   = RGB(0, 0, 0)
            .ReadOnly    = .T.
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Condição] Label
        loc_oPagina.AddObject("lbl_4c_Label7", "Label")
        WITH loc_oPagina.lbl_4c_Label7
            .Caption   = "Condi" + CHR(231) + CHR(227) + "o :"
            .Top       = 281   && 252 + 29
            .Left      = 142
            .Width     = 64
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- [Condição] Codigo (FPags via SigOpFp)
        loc_oPagina.AddObject("txt_4c_FPags", "TextBox")
        WITH loc_oPagina.txt_4c_FPags
            .Value       = ""
            .Top         = 278   && 249 + 29
            .Left        = 207
            .Width       = 94
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .MaxLength   = 12
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Comissão] Label
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Comiss" + CHR(227) + "o :"
            .Top       = 318   && 289 + 29
            .Left      = 141
            .Width     = 65
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        *-- [Período] Label
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "Per" + CHR(237) + "odo :"
            .Top       = 318   && 289 + 29
            .Left      = 285
            .Width     = 55
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- [à] Separador periodo
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = CHR(224)
            .Top       = 318   && 289 + 29
            .Left      = 430
            .Width     = 15
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Visible   = .T.
        ENDWITH

        *-- [Comissão] Percentual (comiss, InputMask="99.99")
        loc_oPagina.AddObject("txt_4c_Comiss", "TextBox")
        WITH loc_oPagina.txt_4c_Comiss
            .Value       = 0
            .Top         = 315   && 286 + 29
            .Left        = 207
            .Width       = 45
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .InputMask   = "99.99"
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 2
            .Visible     = .T.
        ENDWITH

        *-- [Período] Data Inicial (dtinis)
        loc_oPagina.AddObject("txt_4c_DtIni", "TextBox")
        WITH loc_oPagina.txt_4c_DtIni
            .Value       = {}
            .Top         = 315   && 286 + 29
            .Left        = 340
            .Width       = 80
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- [Período] Data Final (dtfins)
        loc_oPagina.AddObject("txt_4c_DtFin", "TextBox")
        WITH loc_oPagina.txt_4c_DtFin
            .Value       = {}
            .Top         = 315   && 286 + 29
            .Left        = 450
            .Width       = 80
            .Height      = 20
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(0, 0, 0)
            .Alignment   = 0
            .Visible     = .T.
        ENDWITH

        *-- BINDEVENTs para lookups (F4 = nKeyCode 28 em TextBox padrao)
        BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "EmpresaLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Empresa, "DblClick", THIS, "EmpresaLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_TabDes,  "KeyPress", THIS, "TabDesLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_TabDes,  "DblClick", THIS, "TabDesLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_Cargo,   "KeyPress", THIS, "CargoLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_Cargo,   "DblClick", THIS, "CargoLookupDblClick")
        BINDEVENT(loc_oPagina.txt_4c_FPags,   "KeyPress", THIS, "FPagsLookupKeyPress")
        BINDEVENT(loc_oPagina.txt_4c_FPags,   "DblClick", THIS, "FPagsLookupDblClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *==========================================================================
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.
        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 9
                    loc_oGrid.RecordSource       = "cursor_4c_Dados"
                    loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.emps"
                    loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.razas"
                    loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tabdes"
                    loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.descrs_tabdes"
                    loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cargos"
                    loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.fpags"
                    loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.dtinis"
                    loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.dtfins"
                    loc_oGrid.Column9.ControlSource = "cursor_4c_Dados.comiss"
                    loc_oGrid.Column1.Width      = 35
                    loc_oGrid.Column2.Width      = 160
                    loc_oGrid.Column3.Width      = 75
                    loc_oGrid.Column4.Width      = 140
                    loc_oGrid.Column5.Width      = 80
                    loc_oGrid.Column6.Width      = 90
                    loc_oGrid.Column7.Width      = 80
                    loc_oGrid.Column8.Width      = 80
                    loc_oGrid.Column9.Width      = 55
                    loc_oGrid.Column9.Alignment  = 2
                    loc_oGrid.Column1.Header1.Caption = "Emp"
                    loc_oGrid.Column2.Header1.Caption = "Empresa"
                    loc_oGrid.Column3.Header1.Caption = "Tb.Desconto"
                    loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Tabela"
                    loc_oGrid.Column5.Header1.Caption = "Cargo"
                    loc_oGrid.Column6.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o"
                    loc_oGrid.Column7.Header1.Caption = "Data Inicial"
                    loc_oGrid.Column8.Header1.Caption = "Data Final"
                    loc_oGrid.Column9.Header1.Caption = "Comiss.%"
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.CarregarLista")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
    *==========================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF
        TRY
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            IF par_nPagina = 1
                THIS.CarregarLista()
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.AlternarPagina")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
    *==========================================================================
        WITH par_oGrid
            .FontName = "Verdana"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *==========================================================================
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.AjustarBotoesPorModo()
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *==========================================================================
        LOCAL loc_cId
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para visualizar.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cId = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.AjustarBotoesPorModo()
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *==========================================================================
        LOCAL loc_cId
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para alterar.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cId = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.AjustarBotoesPorModo()
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AlternarPagina(2)
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *==========================================================================
        LOCAL loc_cId
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            MsgAviso("Selecione um registro para excluir.", "")
            RETURN
        ENDIF
        SELECT cursor_4c_Dados
        loc_cId = ALLTRIM(cursor_4c_Dados.cidchaves)
        IF MsgConfirma("Deseja excluir este " + CHR(237) + "ndice de comiss" + CHR(227) + "o?", ;
                       "Confirmar Exclus" + CHR(227) + "o")
            IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cId)
                IF THIS.this_oBusinessObject.Excluir()
                    MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
                    THIS.CarregarLista()
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *==========================================================================
        THIS.CarregarLista()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
        THIS.Release()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
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
    PROCEDURE BtnSalvarClick()
    *==========================================================================
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.

        IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
            RETURN loc_lResultado
        ENDIF

        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_TabDes.Value))
            MsgAviso("Tabela de Descontos Inv" + CHR(225) + "lida!!!", "")
            RETURN loc_lResultado
        ENDIF

        IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Cargo.Value))
            MsgAviso("Cargo Inv" + CHR(225) + "lido!!!", "")
            RETURN loc_lResultado
        ENDIF

        IF loc_oPg2.txt_4c_Comiss.Value <= 0
            MsgAviso("Comiss" + CHR(227) + "o Inv" + CHR(225) + "lida!!!", "")
            RETURN loc_lResultado
        ENDIF

        IF EMPTY(loc_oPg2.txt_4c_DtIni.Value)
            MsgAviso("Data Inicial Inv" + CHR(225) + "lida!!!", "")
            RETURN loc_lResultado
        ENDIF

        IF EMPTY(loc_oPg2.txt_4c_DtFin.Value)
            MsgAviso("Data Final Inv" + CHR(225) + "lida!!!", "")
            RETURN loc_lResultado
        ENDIF

        IF loc_oPg2.txt_4c_DtIni.Value > loc_oPg2.txt_4c_DtFin.Value
            MsgAviso("Data Inicial N" + CHR(227) + "o Pode Ser Maior do Que a Final!!!", "")
            RETURN loc_lResultado
        ENDIF

        TRY
            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Registro salvo com sucesso!", "")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AjustarBotoesPorModo()
                    THIS.AlternarPagina(1)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.BtnSalvarClick")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *==========================================================================
        THIS.this_cModoAtual = "LISTA"
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
    *==========================================================================
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2
        loc_oPg2.txt_4c_Empresa.Value  = ""
        loc_oPg2.txt_4c_DEmpresa.Value = ""
        loc_oPg2.txt_4c_TabDes.Value   = ""
        loc_oPg2.txt_4c_DTabDes.Value  = ""
        loc_oPg2.txt_4c_Cargo.Value    = ""
        loc_oPg2.txt_4c_DCargo.Value   = ""
        loc_oPg2.txt_4c_FPags.Value    = ""
        loc_oPg2.txt_4c_Comiss.Value   = 0
        loc_oPg2.txt_4c_DtIni.Value    = {}
        loc_oPg2.txt_4c_DtFin.Value    = {}
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
    *==========================================================================
        LOCAL loc_oPg2, loc_nBackEd, loc_nBackRo
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_nBackEd = RGB(255, 255, 255)
        loc_nBackRo = RGB(220, 220, 220)

        loc_oPg2.txt_4c_Empresa.ReadOnly  = !par_lHabilitar
        loc_oPg2.txt_4c_TabDes.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_Cargo.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_FPags.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_Comiss.ReadOnly   = !par_lHabilitar
        loc_oPg2.txt_4c_DtIni.ReadOnly    = !par_lHabilitar
        loc_oPg2.txt_4c_DtFin.ReadOnly    = !par_lHabilitar

        loc_oPg2.txt_4c_Empresa.BackColor  = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_TabDes.BackColor   = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_Cargo.BackColor    = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_FPags.BackColor    = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_Comiss.BackColor   = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_DtIni.BackColor    = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)
        loc_oPg2.txt_4c_DtFin.BackColor    = IIF(par_lHabilitar, loc_nBackEd, loc_nBackRo)

        *-- Campos de descricao: sempre somente leitura
        loc_oPg2.txt_4c_DEmpresa.ReadOnly = .T.
        loc_oPg2.txt_4c_DTabDes.ReadOnly  = .T.
        loc_oPg2.txt_4c_DCargo.ReadOnly   = .T.

        *-- Botao Confirmar: habilitado somente em INCLUIR/ALTERAR
        loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *==========================================================================
        LOCAL loc_oPg2
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            loc_oPg2.txt_4c_Empresa.Value  = THIS.this_oBusinessObject.this_cEmps
            loc_oPg2.txt_4c_DEmpresa.Value = THIS.this_oBusinessObject.this_cDEmpresa
            loc_oPg2.txt_4c_TabDes.Value   = THIS.this_oBusinessObject.this_cTabDes
            loc_oPg2.txt_4c_DTabDes.Value  = THIS.this_oBusinessObject.this_cDTabDes
            loc_oPg2.txt_4c_Cargo.Value    = THIS.this_oBusinessObject.this_cCargos
            loc_oPg2.txt_4c_DCargo.Value   = THIS.this_oBusinessObject.this_cDCargo
            loc_oPg2.txt_4c_FPags.Value    = THIS.this_oBusinessObject.this_cFPags
            loc_oPg2.txt_4c_Comiss.Value   = THIS.this_oBusinessObject.this_nComiss
            loc_oPg2.txt_4c_DtIni.Value    = THIS.this_oBusinessObject.this_dDtInis
            loc_oPg2.txt_4c_DtFin.Value    = THIS.this_oBusinessObject.this_dDtFins
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
    *==========================================================================
        LOCAL loc_lResultado, loc_oPg2
        loc_lResultado = .F.
        TRY
            loc_oPg2 = THIS.pgf_4c_Paginas.Page2
            THIS.this_oBusinessObject.this_cEmps    = ALLTRIM(loc_oPg2.txt_4c_Empresa.Value)
            THIS.this_oBusinessObject.this_cTabDes   = ALLTRIM(loc_oPg2.txt_4c_TabDes.Value)
            THIS.this_oBusinessObject.this_cCargos   = ALLTRIM(loc_oPg2.txt_4c_Cargo.Value)
            THIS.this_oBusinessObject.this_cFPags    = ALLTRIM(loc_oPg2.txt_4c_FPags.Value)
            THIS.this_oBusinessObject.this_nComiss   = loc_oPg2.txt_4c_Comiss.Value
            THIS.this_oBusinessObject.this_dDtInis   = loc_oPg2.txt_4c_DtIni.Value
            THIS.this_oBusinessObject.this_dDtFins   = loc_oPg2.txt_4c_DtFin.Value
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.FormParaBO")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Lookup Empresa (SigCdEmp: Cemps / Razas)
    *==========================================================================
    PROCEDURE EmpresaLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupEmpresa()
        ENDIF
    ENDPROC

    PROCEDURE EmpresaLookupDblClick()
        THIS.AbrirLookupEmpresa()
    ENDPROC

    PROCEDURE AbrirLookupEmpresa()
        LOCAL loc_oBusca, loc_oPg2
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_Empresa.ReadOnly
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdEmp", ;
            "cursor_4c_BuscaEmpresa", ;
            "Cemps", ;
            ALLTRIM(loc_oPg2.txt_4c_Empresa.Value), ;
            "Selecionar Empresa")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaEmpresa")
                    loc_oPg2.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
                    loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "d.")
                loc_oBusca.mAddColuna("Razas", "", "Empresa")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
                    loc_oPg2.txt_4c_Empresa.Value  = ALLTRIM(cursor_4c_BuscaEmpresa.Cemps)
                    loc_oPg2.txt_4c_DEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmpresa.Razas)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaEmpresa")
                USE IN cursor_4c_BuscaEmpresa
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookup Tabela de Desconto (SigOpTdz: Codigos / Descrs)
    *==========================================================================
    PROCEDURE TabDesLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupTabDes()
        ENDIF
    ENDPROC

    PROCEDURE TabDesLookupDblClick()
        THIS.AbrirLookupTabDes()
    ENDPROC

    PROCEDURE AbrirLookupTabDes()
        LOCAL loc_oBusca, loc_oPg2
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_TabDes.ReadOnly
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpTdz", ;
            "cursor_4c_BuscaTabDes", ;
            "Codigos", ;
            ALLTRIM(loc_oPg2.txt_4c_TabDes.Value), ;
            "Selecionar Tabela de Desconto")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaTabDes")
                    loc_oPg2.txt_4c_TabDes.Value  = ALLTRIM(cursor_4c_BuscaTabDes.Codigos)
                    loc_oPg2.txt_4c_DTabDes.Value = ALLTRIM(cursor_4c_BuscaTabDes.Descrs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTabDes")
                    loc_oPg2.txt_4c_TabDes.Value  = ALLTRIM(cursor_4c_BuscaTabDes.Codigos)
                    loc_oPg2.txt_4c_DTabDes.Value = ALLTRIM(cursor_4c_BuscaTabDes.Descrs)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaTabDes")
                USE IN cursor_4c_BuscaTabDes
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookup Cargo (SigCdCrg: CCargs / DCargs)
    *==========================================================================
    PROCEDURE CargoLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupCargo()
        ENDIF
    ENDPROC

    PROCEDURE CargoLookupDblClick()
        THIS.AbrirLookupCargo()
    ENDPROC

    PROCEDURE AbrirLookupCargo()
        LOCAL loc_oBusca, loc_oPg2
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_Cargo.ReadOnly
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdCrg", ;
            "cursor_4c_BuscaCargo", ;
            "CCargs", ;
            ALLTRIM(loc_oPg2.txt_4c_Cargo.Value), ;
            "Selecionar Cargo")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaCargo")
                    loc_oPg2.txt_4c_Cargo.Value  = ALLTRIM(cursor_4c_BuscaCargo.CCargs)
                    loc_oPg2.txt_4c_DCargo.Value = ALLTRIM(cursor_4c_BuscaCargo.DCargs)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("CCargs", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("DCargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCargo")
                    loc_oPg2.txt_4c_Cargo.Value  = ALLTRIM(cursor_4c_BuscaCargo.CCargs)
                    loc_oPg2.txt_4c_DCargo.Value = ALLTRIM(cursor_4c_BuscaCargo.DCargs)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaCargo")
                USE IN cursor_4c_BuscaCargo
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookup Condição de Pagamento (SigOpFp: FPags)
    *==========================================================================
    PROCEDURE FPagsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 28  && F4
            THIS.AbrirLookupFPags()
        ENDIF
    ENDPROC

    PROCEDURE FPagsLookupDblClick()
        THIS.AbrirLookupFPags()
    ENDPROC

    PROCEDURE AbrirLookupFPags()
        LOCAL loc_oBusca, loc_oPg2
        IF THIS.pgf_4c_Paginas.Page2.txt_4c_FPags.ReadOnly
            RETURN
        ENDIF
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigOpFp", ;
            "cursor_4c_BuscaFPags", ;
            "FPags", ;
            ALLTRIM(loc_oPg2.txt_4c_FPags.Value), ;
            "Selecionar Condi" + CHR(231) + CHR(227) + "o de Pagamento")

        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                IF USED("cursor_4c_BuscaFPags")
                    loc_oPg2.txt_4c_FPags.Value = ALLTRIM(cursor_4c_BuscaFPags.FPags)
                ENDIF
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                loc_oBusca.mAddColuna("FPags", "", "Condi" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFPags")
                    loc_oPg2.txt_4c_FPags.Value = ALLTRIM(cursor_4c_BuscaFPags.FPags)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaFPags")
                USE IN cursor_4c_BuscaFPags
            ENDIF
            loc_oBusca.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
    *==========================================================================
        LOCAL loc_oPg1, loc_lEmLista
        TRY
            loc_oPg1     = THIS.pgf_4c_Paginas.Page1
            loc_lEmLista = (THIS.this_cModoAtual = "LISTA")
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEmLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEmLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEmLista
            loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEmLista
            loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lEmLista
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ICMBO.prg):
*==============================================================================
* ICMBO.prg - Business Object: Cadastro de Indices de Comissao
* Tabela: SigCdCmi
* PK: cidchaves (char 20, gerado via fUniqueIds)
*==============================================================================

DEFINE CLASS ICMBO AS BusinessBase

    *-- Campos da tabela SigCdCmi
    this_cEmps      = ""    && char(3)  - Empresa
    this_cCargos    = ""    && char(10) - Cargo
    this_cFPags     = ""    && char(12) - Condicao de Pagamento
    this_cTabDes    = ""    && char(10) - Tabela de Desconto
    this_dDtInis    = {}    && datetime - Data Inicial do Periodo
    this_dDtFins    = {}    && datetime - Data Final do Periodo
    this_nComiss    = 0     && numeric(4,2) - Percentual de Comissao
    this_cIdChaves  = ""    && char(20) - Chave unica (PK, gerado por fUniqueIds)
    this_tDtAlts    = {}    && datetime - Data/hora ultima alteracao

    *-- Campos descricao (lookup, nao armazenados no banco)
    this_cDEmpresa  = ""    && Razao social da empresa (SigCdEmp.Razas)
    this_cDCargo    = ""    && Descricao do cargo (SigCdCrg.DCargs)
    this_cDTabDes   = ""    && Descricao da tabela de desconto (SigOpTdz.Descrs)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCmi"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ICMBO.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.emps, a.tabdes, a.cargos, a.fpags," + ;
                       " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
                       " ISNULL(b.razas, '') AS razas," + ;
                       " ISNULL(c.dcargs, '') AS dcargs," + ;
                       " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
                       " FROM SigCdCmi a" + ;
                       " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
                       " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
                       " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
                       loc_cWhere + ;
                       " ORDER BY a.emps, a.tabdes, a.cargos, a.fpags"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                GO TOP IN cursor_4c_Dados
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar " + CHR(237) + "ndices de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.tabdes, a.cargos, a.fpags," + ;
                       " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
                       " ISNULL(b.razas, '') AS razas," + ;
                       " ISNULL(c.dcargs, '') AS dcargs," + ;
                       " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
                       " FROM SigCdCmi a" + ;
                       " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
                       " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
                       " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cIdChaves))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "ICMBO.CarregarPorCodigo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = ALLTRIM(TratarNulo(cidchaves,  "C"))
            THIS.this_cEmps      = ALLTRIM(TratarNulo(emps,       "C"))
            THIS.this_cTabDes    = ALLTRIM(TratarNulo(tabdes,     "C"))
            THIS.this_cCargos    = ALLTRIM(TratarNulo(cargos,     "C"))
            THIS.this_cFPags     = ALLTRIM(TratarNulo(fpags,      "C"))
            THIS.this_dDtInis    = TratarNulo(dtinis, "D")
            THIS.this_dDtFins    = TratarNulo(dtfins, "D")
            THIS.this_nComiss    = TratarNulo(comiss, "N")
            THIS.this_tDtAlts    = TratarNulo(dtalts, "D")
            IF TYPE(par_cAliasCursor + ".razas") != "U"
                THIS.this_cDEmpresa = ALLTRIM(TratarNulo(razas,         "C"))
                THIS.this_cDCargo   = ALLTRIM(TratarNulo(dcargs,        "C"))
                THIS.this_cDTabDes  = ALLTRIM(TratarNulo(descrs_tabdes, "C"))
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cId
        LOCAL loc_nResultDup, loc_cSQLDup, loc_lDuplicado
        loc_lResultado = .F.
        loc_lDuplicado = .F.

        TRY
            *-- Verificar duplicidade (Emps+Cargos+FPags+TabDes+DtInis+DtFins)
            loc_cSQLDup = "SELECT cidchaves FROM SigCdCmi" + ;
                          " WHERE emps = "   + EscaparSQL(THIS.this_cEmps)   + ;
                          " AND cargos = "   + EscaparSQL(THIS.this_cCargos) + ;
                          " AND fpags = "    + EscaparSQL(THIS.this_cFPags)  + ;
                          " AND tabdes = "   + EscaparSQL(THIS.this_cTabDes) + ;
                          " AND dtinis = "   + FormatarDataSQL(THIS.this_dDtInis) + ;
                          " AND dtfins = "   + FormatarDataSQL(THIS.this_dDtFins)

            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
            loc_nResultDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupVerif")
            IF loc_nResultDup > 0 AND RECCOUNT("cursor_4c_DupVerif") > 0
                loc_lDuplicado = .T.
                MsgAviso("Dados j" + CHR(225) + " cadastrados para esta combina" + CHR(231) + CHR(227) + "o!", "")
            ENDIF
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF

            IF !loc_lDuplicado
                *-- Gerar chave unica
                loc_cId = fUniqueIds()
                THIS.this_cIdChaves = loc_cId

                loc_cSQL = "INSERT INTO SigCdCmi (cidchaves, emps, tabdes, cargos, fpags," + ;
                           " dtinis, dtfins, comiss, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cId) + ", " + ;
                           EscaparSQL(THIS.this_cEmps)   + ", " + ;
                           EscaparSQL(THIS.this_cTabDes)  + ", " + ;
                           EscaparSQL(THIS.this_cCargos)  + ", " + ;
                           EscaparSQL(THIS.this_cFPags)   + ", " + ;
                           FormatarDataSQL(THIS.this_dDtInis) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtFins) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                           "GETDATE())"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Ins")
                    TABLEREVERT(.T., "cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                IF loc_nResult > 0
                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                    MsgErro("Erro ao inserir " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCmi SET" + ;
                       " emps = "   + EscaparSQL(THIS.this_cEmps)   + ", " + ;
                       " tabdes = " + EscaparSQL(THIS.this_cTabDes)  + ", " + ;
                       " cargos = " + EscaparSQL(THIS.this_cCargos)  + ", " + ;
                       " fpags = "  + EscaparSQL(THIS.this_cFPags)   + ", " + ;
                       " dtinis = " + FormatarDataSQL(THIS.this_dDtInis) + ", " + ;
                       " dtfins = " + FormatarDataSQL(THIS.this_dDtFins) + ", " + ;
                       " comiss = " + FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       " dtalts = GETDATE()" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult > 0
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                MsgErro("Erro ao atualizar " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmi WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cIdChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF loc_nResult > 0
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
                MsgErro("Erro ao excluir " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

