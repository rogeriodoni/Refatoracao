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
[2026-03-30 10:20:15] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-03-30 10:20:15] [INFO] Timeout: 300 segundos
[2026-03-30 10:20:15] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_g2wpgvpj.prg
[2026-03-30 10:20:15] [INFO] Conteudo do wrapper:
[2026-03-30 10:20:15] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
QUIT

[2026-03-30 10:20:15] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_g2wpgvpj.prg
[2026-03-30 10:20:15] [INFO] VFP output esperado em: C:\4c\tasks\task001\vfp_output.txt
[2026-03-30 10:20:15] [INFO] Executando Visual FoxPro 9...
[2026-03-30 10:20:15] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_g2wpgvpj.prg
[2026-03-30 10:20:15] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_g2wpgvpj.prg
[2026-03-30 10:20:15] [INFO] Timeout configurado: 300 segundos
[2026-03-30 10:25:15] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 28848)...
[2026-03-30 10:25:17] [INFO] VFP9 finalizado em 302.0534947 segundos
[2026-03-30 10:25:17] [INFO] Exit Code: 4
[2026-03-30 10:25:17] [INFO] 
[2026-03-30 10:25:17] [INFO] Arquivos temporarios preservados para inspecao:
[2026-03-30 10:25:17] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_g2wpgvpj.prg
[2026-03-30 10:25:17] [INFO] 
[2026-03-30 10:25:17] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-03-30 10:25:17] [INFO] * Auto-generated wrapper for parameters
[2026-03-30 10:25:17] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-03-30 10:25:17] [INFO] * Parameters: 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
[2026-03-30 10:25:17] [INFO] 
[2026-03-30 10:25:17] [INFO] * Anti-dialog protections for unattended execution
[2026-03-30 10:25:17] [INFO] SET SAFETY OFF
[2026-03-30 10:25:17] [INFO] SET RESOURCE OFF
[2026-03-30 10:25:17] [INFO] SET TALK OFF
[2026-03-30 10:25:17] [INFO] SET NOTIFY OFF
[2026-03-30 10:25:17] [INFO] SYS(2335, 0)
[2026-03-30 10:25:17] [INFO] 
[2026-03-30 10:25:17] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
[2026-03-30 10:25:17] [INFO] QUIT
[2026-03-30 10:25:17] [INFO] 
[2026-03-30 10:25:17] [INFO] === Fim do Wrapper.prg ===
[2026-03-30 10:25:17] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-03-30 10:43:40] [INFO] === VFP EXECUTOR v2.0 ===
[2026-03-30 10:43:40] [INFO] Config FPW: (nao fornecido)
[2026-03-30 10:43:40] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-03-30 10:43:40] [INFO] Timeout: 300 segundos
[2026-03-30 10:43:40] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_upwhbevo.prg
[2026-03-30 10:43:40] [INFO] Conteudo do wrapper:
[2026-03-30 10:43:40] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
QUIT

[2026-03-30 10:43:40] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_upwhbevo.prg
[2026-03-30 10:43:40] [INFO] VFP output esperado em: C:\4c\tasks\task001\vfp_output.txt
[2026-03-30 10:43:40] [INFO] Executando Visual FoxPro 9...
[2026-03-30 10:43:40] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_upwhbevo.prg
[2026-03-30 10:43:40] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_upwhbevo.prg
[2026-03-30 10:43:40] [INFO] Timeout configurado: 300 segundos
[2026-03-30 10:48:40] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 5728)...
[2026-03-30 10:48:42] [INFO] VFP9 finalizado em 302.0422039 segundos
[2026-03-30 10:48:42] [INFO] Exit Code: 4
[2026-03-30 10:48:42] [INFO] 
[2026-03-30 10:48:42] [INFO] Arquivos temporarios preservados para inspecao:
[2026-03-30 10:48:42] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_upwhbevo.prg
[2026-03-30 10:48:42] [INFO] 
[2026-03-30 10:48:42] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-03-30 10:48:42] [INFO] * Auto-generated wrapper for parameters
[2026-03-30 10:48:42] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-03-30 10:48:42] [INFO] * Parameters: 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
[2026-03-30 10:48:42] [INFO] 
[2026-03-30 10:48:42] [INFO] * Anti-dialog protections for unattended execution
[2026-03-30 10:48:42] [INFO] SET SAFETY OFF
[2026-03-30 10:48:42] [INFO] SET RESOURCE OFF
[2026-03-30 10:48:42] [INFO] SET TALK OFF
[2026-03-30 10:48:42] [INFO] SET NOTIFY OFF
[2026-03-30 10:48:42] [INFO] SYS(2335, 0)
[2026-03-30 10:48:42] [INFO] 
[2026-03-30 10:48:42] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
[2026-03-30 10:48:42] [INFO] QUIT
[2026-03-30 10:48:42] [INFO] 
[2026-03-30 10:48:42] [INFO] === Fim do Wrapper.prg ===
[2026-03-30 10:48:42] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-03-30 11:18:07] [INFO] === VFP EXECUTOR v2.0 ===
[2026-03-30 11:18:07] [INFO] Config FPW: (nao fornecido)
[2026-03-30 11:18:07] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-03-30 11:18:07] [INFO] Timeout: 300 segundos
[2026-03-30 11:18:07] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_aivxazjw.prg
[2026-03-30 11:18:07] [INFO] Conteudo do wrapper:
[2026-03-30 11:18:07] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
QUIT

[2026-03-30 11:18:07] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_aivxazjw.prg
[2026-03-30 11:18:07] [INFO] VFP output esperado em: C:\4c\tasks\task001\vfp_output.txt
[2026-03-30 11:18:07] [INFO] Executando Visual FoxPro 9...
[2026-03-30 11:18:07] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_aivxazjw.prg
[2026-03-30 11:18:07] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_aivxazjw.prg
[2026-03-30 11:18:07] [INFO] Timeout configurado: 300 segundos
[2026-03-30 11:23:07] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 19200)...
[2026-03-30 11:23:10] [WARN] Encerrando 1 processo(s) VFP9 residual(is)...
[2026-03-30 11:23:11] [INFO] VFP9 finalizado em 303.0628258 segundos
[2026-03-30 11:23:11] [INFO] Exit Code: 4
[2026-03-30 11:23:11] [INFO] 
[2026-03-30 11:23:11] [INFO] Arquivos temporarios preservados para inspecao:
[2026-03-30 11:23:11] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_aivxazjw.prg
[2026-03-30 11:23:11] [INFO] 
[2026-03-30 11:23:11] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-03-30 11:23:11] [INFO] * Auto-generated wrapper for parameters
[2026-03-30 11:23:11] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-03-30 11:23:11] [INFO] * Parameters: 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
[2026-03-30 11:23:11] [INFO] 
[2026-03-30 11:23:11] [INFO] * Anti-dialog protections for unattended execution
[2026-03-30 11:23:11] [INFO] SET SAFETY OFF
[2026-03-30 11:23:11] [INFO] SET RESOURCE OFF
[2026-03-30 11:23:11] [INFO] SET TALK OFF
[2026-03-30 11:23:11] [INFO] SET NOTIFY OFF
[2026-03-30 11:23:11] [INFO] SYS(2335, 0)
[2026-03-30 11:23:11] [INFO] 
[2026-03-30 11:23:11] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
[2026-03-30 11:23:11] [INFO] QUIT
[2026-03-30 11:23:11] [INFO] 
[2026-03-30 11:23:11] [INFO] === Fim do Wrapper.prg ===
[2026-03-30 11:23:11] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-03-30 11:41:25] [INFO] === VFP EXECUTOR v2.0 ===
[2026-03-30 11:41:25] [INFO] Config FPW: (nao fornecido)
[2026-03-30 11:41:25] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-03-30 11:41:25] [INFO] Timeout: 300 segundos
[2026-03-30 11:41:25] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_twiwgnpv.prg
[2026-03-30 11:41:25] [INFO] Conteudo do wrapper:
[2026-03-30 11:41:25] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
QUIT

[2026-03-30 11:41:25] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_twiwgnpv.prg
[2026-03-30 11:41:25] [INFO] VFP output esperado em: C:\4c\tasks\task001\vfp_output.txt
[2026-03-30 11:41:25] [INFO] Executando Visual FoxPro 9...
[2026-03-30 11:41:25] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_twiwgnpv.prg
[2026-03-30 11:41:25] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_twiwgnpv.prg
[2026-03-30 11:41:25] [INFO] Timeout configurado: 300 segundos
[2026-03-30 11:46:25] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 13216)...
[2026-03-30 11:46:27] [INFO] VFP9 finalizado em 302.0537 segundos
[2026-03-30 11:46:27] [INFO] Exit Code: 4
[2026-03-30 11:46:27] [INFO] 
[2026-03-30 11:46:27] [INFO] Arquivos temporarios preservados para inspecao:
[2026-03-30 11:46:27] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_twiwgnpv.prg
[2026-03-30 11:46:27] [INFO] 
[2026-03-30 11:46:27] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-03-30 11:46:27] [INFO] * Auto-generated wrapper for parameters
[2026-03-30 11:46:27] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-03-30 11:46:27] [INFO] * Parameters: 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
[2026-03-30 11:46:27] [INFO] 
[2026-03-30 11:46:27] [INFO] * Anti-dialog protections for unattended execution
[2026-03-30 11:46:27] [INFO] SET SAFETY OFF
[2026-03-30 11:46:27] [INFO] SET RESOURCE OFF
[2026-03-30 11:46:27] [INFO] SET TALK OFF
[2026-03-30 11:46:27] [INFO] SET NOTIFY OFF
[2026-03-30 11:46:27] [INFO] SYS(2335, 0)
[2026-03-30 11:46:27] [INFO] 
[2026-03-30 11:46:27] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormDepartamento', 'C:\4c\tasks\task001', 'CRUD'
[2026-03-30 11:46:27] [INFO] QUIT
[2026-03-30 11:46:27] [INFO] 
[2026-03-30 11:46:27] [INFO] === Fim do Wrapper.prg ===
[2026-03-30 11:46:27] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDepartamento.prg):
*==============================================================================
* FormDepartamento.prg - Formulario de Cadastro de Departamentos
* Tabela: SigCdDpt | PK: codigos
* Legado: SIGCDDPT.SCX (frmcadastro)
* Gerado em fase 3/8 - Estrutura Base
*==============================================================================

DEFINE CLASS FormDepartamento AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro de Departamentos"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    Themes      = .F.
    BorderStyle = 2
    FontName    = "Tahoma"
    ForeColor   = RGB(90, 90, 90)

    *-- Propriedades do formulario
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *-- Guard para LostFocus de lookup do Diretor
    this_cUltimoDiretorValidado = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        *-- Em modo teste, ocultar form ANTES do DODEFAULT para evitar modal event loop.
        *-- WindowType=1 + Visible=.T. (padrao Form base) = VFP entra em READ EVENTS ao
        *-- definir ActivePage, travando o processo por 300s.
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            THIS.Visible = .F.
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configuracao inicial do formulario
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("DepartamentoBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar Business Object DepartamentoBO", "Erro Cr" + CHR(237) + "tico")
            ELSE
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Pula CarregarLista() em modo de validacao UI (sem conexao SQL)
                IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                    IF !THIS.CarregarLista()
                        *-- Falha nao impede abertura
                    ENDIF
                ENDIF

                *-- Em modo teste, PageFrame DEVE estar oculto ao definir ActivePage.
                *-- ConfigurarPageFrame() ja setou Visible=.T. (necessario para uso real).
                *-- Com form modal (WindowType=1) + PageFrame visivel + ActivePage fora
                *-- do loop DO FORM = VFP9 entra em READ EVENTS e trava 300s.
                IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                    THIS.pgf_4c_Paginas.Visible = .F.
                ELSE
                    THIS.pgf_4c_Paginas.Visible = .T.
                ENDIF
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao inicializar FormDepartamento:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Configura PageFrame principal
    * Legado: pagina.Width=1003, Top=-29 (oculta abas)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .Top       = -29
            .Left      = 0
            .Width     = 1003
            .Height    = 600
            .PageCount = 2
            .Tabs      = .F.
            .Visible   = .T.
        ENDWITH

        THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
        THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)

        THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
        THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Configura Page1 (Lista)
    * Compensacao +29: grupo_op.Top=0 -> 29, cntSombra.Top=2 -> 31
    * Grade: Left=30, Top=107+29=136, Width=941, Height=470
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Container de cabecalho (cntSombra: Top=2 -> 31 com compensacao)
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
            .Left        = 0
            .Width       = 1003
            .Height      = 80
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Caption   = "Cadastro de Departamentos"
            .Top       = 20
            .Left      = 20
            .Width     = 300
            .Height    = 30
            .FontName  = "Tahoma"
            .FontSize  = 14
            .FontBold  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Container de botoes CRUD (grupo_op: Left=544, Top=0 -> 29)
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 29
            .Left        = 544
            .Width       = 460
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Incluir (Left=5)
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Botao Visualizar (Left=82)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 82
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Botao Alterar (Left=159)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 159
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Botao Excluir (Left=236)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 236
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Botao Buscar (Left=313)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 313
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *-- Botao Encerrar (Left=390)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 390
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *-- Grid de listagem (Grade: Top=107+29=136, Left=30, Width=941, Height=470)
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.ColumnCount = 3

        WITH loc_oGrid
            .Top           = 136
            .Left          = 30
            .Width         = 941
            .Height        = 470
            .GridLines     = 3
            .GridLineWidth = 1
            .GridLineColor = RGB(200, 200, 200)
            .DeleteMark    = .F.
            .RecordMark    = .F.
            .ReadOnly      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .Visible       = .T.

            .Column1.Width           = 80
            .Column1.ReadOnly        = .T.
            .Column1.Header1.Caption = "C" + CHR(243) + "digo"

            .Column2.Width           = 290
            .Column2.ReadOnly        = .T.
            .Column2.Header1.Caption = "Departamento"

            .Column3.Width           = 80
            .Column3.ReadOnly        = .T.
            .Column3.Header1.Caption = "Diretor"
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 (Dados)
    * Compensacao +29: grupo_salva.Top=4 -> 33
    * Fase 5/8: Container botoes + Codigo + Descricao + Diretores (50% dos campos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Container de botoes Confirmar/Cancelar (grupo_salva: Left=834, Top=4 -> 33)
        loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
        WITH loc_oPagina.cnt_4c_BotoesDados
            .Top         = 33
            .Left        = 834
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Botao Salvar
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
            .Caption         = "Salvar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")

        *-- Botao Cancelar
        loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
            .Caption         = "Cancelar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
            .PicturePosition = 13
            .Top             = 5
            .Left            = 82
            .Width           = 75
            .Height          = 75
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .Themes          = .F.
            .SpecialEffect   = 0
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        *-- Grupo 1: Codigo
        *-- Label1: top=158+29=187, left=377, width=42, height=15
        *-- getcodigos: top=152+29=181, left=421, width=80
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label1", "Label")
        WITH loc_oPagina.lbl_4c_Label1
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 187
            .Left      = 377
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
        WITH loc_oPagina.txt_4c_Codigos
            .Value         = ""
            .Top           = 181
            .Left          = 421
            .Width         = 80
            .Height        = 21
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grupo 2: Descricao
        *-- Label2: top=181+29=210, left=364, width=55, height=15
        *-- getDescricaos: top=177+29=206, left=421, width=290, height=23
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label2", "Label")
        WITH loc_oPagina.lbl_4c_Label2
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 210
            .Left      = 364
            .Width     = 55
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Descricaos", "TextBox")
        WITH loc_oPagina.txt_4c_Descricaos
            .Value         = ""
            .Top           = 206
            .Left          = 421
            .Width         = 290
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 0
            .MaxLength     = 40
            .Visible       = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grupo 3: Diretores (com lookup SigCdUsu via LostFocus)
        *-- Label3: top=206+29=235, left=377, width=42, height=15
        *-- getDiretores: top=202+29=231, left=421, width=80, height=23
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label3", "Label")
        WITH loc_oPagina.lbl_4c_Label3
            .Caption   = "Diretor :"
            .Top       = 235
            .Left      = 377
            .Width     = 42
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Diretores", "TextBox")
        WITH loc_oPagina.txt_4c_Diretores
            .Value         = ""
            .Top           = 231
            .Left          = 421
            .Width         = 80
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .BackColor     = RGB(255, 255, 255)
            .ForeColor     = RGB(90, 90, 90)
            .SpecialEffect = 0
            .MaxLength     = 10
            .Visible       = .T.
        ENDWITH
        *-- Legado: getDiretores.Valid abre fwBuscaExt ao sair do campo
        BINDEVENT(loc_oPagina.txt_4c_Diretores, "LostFocus", THIS, "ValidarDiretor")

        *----------------------------------------------------------------------
        *-- Grupo 4: ObrigaSubclasse (Optiongroup1 - nChkSubs)
        *-- Label4: top=231+29=260, left=265, width=154, height=15
        *-- Optiongroup1: top=228+29=257, left=416, width=109, height=24
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label4", "Label")
        WITH loc_oPagina.lbl_4c_Label4
            .Caption   = "Obriga Subclas. Encerramento :"
            .Top       = 260
            .Left      = 265
            .Width     = 154
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_ObrigaSubclasse", "OptionGroup")
        WITH loc_oPagina.opt_4c_ObrigaSubclasse
            .ButtonCount = 2
            .BorderStyle = 0
            .Value       = 1
            .Top         = 257
            .Left        = 416
            .Width       = 109
            .Height      = 24
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_ObrigaSubclasse.Buttons(1)
            .Caption   = "Sim"
            .Value     = 1
            .Left      = 5
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_ObrigaSubclasse.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 61
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grupo 5: Tipo (Optiongroup2 - nChkTipos)
        *-- Label5: top=249+29=278, left=390, width=29, height=15
        *-- Optiongroup2: top=246+29=275, left=416, width=109, height=24
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label5", "Label")
        WITH loc_oPagina.lbl_4c_Label5
            .Caption   = "Tipo :"
            .Top       = 278
            .Left      = 390
            .Width     = 29
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
        WITH loc_oPagina.opt_4c_Tipo
            .ButtonCount = 2
            .BorderStyle = 0
            .Value       = 1
            .Top         = 275
            .Left        = 416
            .Width       = 109
            .Height      = 24
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Tipo.Buttons(1)
            .Caption   = "Sim"
            .Value     = 1
            .Left      = 5
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Tipo.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Left      = 61
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
        ENDWITH

        *----------------------------------------------------------------------
        *-- Grupo 6: Automatico (optAutos - nAutos)
        *-- Label6: top=267+29=296, left=359, width=60, height=15
        *-- optAutos: top=264+29=293, left=416, width=109, height=24, value=2
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_Label6", "Label")
        WITH loc_oPagina.lbl_4c_Label6
            .Caption   = "Autom" + CHR(225) + "tico:"
            .Top       = 296
            .Left      = 359
            .Width     = 60
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("opt_4c_Autos", "OptionGroup")
        WITH loc_oPagina.opt_4c_Autos
            .ButtonCount = 2
            .BorderStyle = 0
            .Value       = 2
            .Top         = 293
            .Left        = 416
            .Width       = 109
            .Height      = 24
            .Visible     = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Autos.Buttons(1)
            .Caption   = "Sim"
            .Value     = 0
            .Left      = 5
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
        ENDWITH
        WITH loc_oPagina.opt_4c_Autos.Buttons(2)
            .Caption   = "N" + CHR(227) + "o"
            .Value     = 1
            .Left      = 61
            .Top       = 3
            .Width     = 61
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .AutoSize  = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Carrega dados no Grid da Page1
    * NOTA: Grid sera criado na Fase 4 - metodo preparado para receber implementacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF !USED("cursor_4c_Dados")
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(40), diretors C(10))
                ENDIF
                loc_lResultado = .T.
            ELSE
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
                    IF THIS.this_oBusinessObject.Buscar("")
                        LOCAL loc_oGrid
                        loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                        loc_oGrid.RecordSource = "cursor_4c_Dados"
                        loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
                        loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
                        loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.diretors"
                        loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
                        loc_oGrid.Column2.Header1.Caption = "Departamento"
                        loc_oGrid.Column3.Header1.Caption = "Diretor"
                        THIS.FormatarGridLista(loc_oGrid)
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Linha: " + TRANSFORM(loException.LineNo) + " - " + loException.Message
            MostrarErro("Erro ao carregar lista:" + CHR(13) + THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    * REGRA: Itera Pages DE PageFrames e Controls de Containers
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        *-- Trata PageFrame - itera Pages
        IF PEMSTATUS(par_oContainer, "PageCount", 5)
            LOCAL loc_nP
            FOR loc_nP = 1 TO par_oContainer.PageCount
                THIS.TornarControlesVisiveis(par_oContainer.Pages(loc_nP))
            ENDFOR
        ENDIF

        *-- Trata Controls
        IF PEMSTATUS(par_oContainer, "ControlCount", 5)
            FOR loc_nI = 1 TO par_oContainer.ControlCount
                loc_oObjeto = par_oContainer.Controls(loc_nI)

                IF VARTYPE(loc_oObjeto) = "O"
                    IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                        loc_oObjeto.Visible = .T.
                    ENDIF

                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDFOR
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarGridLista - Aplica formatacao visual ao grid (chamado apos CarregarLista)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
            RETURN .F.
        ENDIF

        THIS.pgf_4c_Paginas.ActivePage = par_nPagina

        IF par_nPagina = 1
            THIS.this_cModoAtual = "LISTA"
            THIS.CarregarLista()
        ENDIF

        loc_lResultado = .T.
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Incluir novo registro
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.AlternarPagina(2)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MostrarErro("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MostrarErro("Erro ao carregar registro selecionado.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Alterar registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCodigo
        loc_cCodigo = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MostrarErro("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.AlternarPagina(2)
        ELSE
            MostrarErro("Erro ao carregar registro selecionado.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Excluir registro selecionado
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCodigo, loc_cDescricao, loc_lConfirma
        loc_cCodigo    = ""
        loc_cDescricao = ""
        loc_lConfirma  = .F.

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigos)
            loc_cDescricao = ALLTRIM(cursor_4c_Dados.descricaos)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MostrarErro("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do departamento:" + CHR(13) + ;
            loc_cDescricao + " (" + loc_cCodigo + ")?", ;
            "Confirmar Exclus" + CHR(227) + "o")

        IF !loc_lConfirma
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
            IF THIS.this_oBusinessObject.Excluir()
                MsgSucesso("Departamento exclu" + CHR(237) + "do com sucesso!")
                THIS.CarregarLista()
            ELSE
                MostrarErro("Erro ao excluir departamento.", "Erro")
            ENDIF
        ELSE
            MostrarErro("Erro ao localizar registro para exclus" + CHR(227) + "o.", "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Buscar registro via FormBuscaAuxiliar
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        *-- Em modo teste, nao abrir dialogo modal de busca (bloqueia pipeline)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oBusca, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdDpt", "cursor_4c_BuscaDpt", "codigos", "", ;
                "Buscar Departamento")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descricaos", "", "Departamento")
                loc_oBusca.mAddColuna("diretors",   "", "Diretor")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDpt")
                    SELECT cursor_4c_BuscaDpt
                    loc_cCodigo = ALLTRIM(cursor_4c_BuscaDpt.codigos)
                ENDIF

                loc_oBusca.Release()
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaDpt")
            USE IN cursor_4c_BuscaDpt
        ENDIF

        IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            LOCATE FOR ALLTRIM(codigos) = loc_cCodigo
            THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fechar o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita campos de edicao (Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Codigos", 5)
            *-- Codigo editavel apenas no modo INCLUIR
            loc_oPagina2.txt_4c_Codigos.Enabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Descricaos", 5)
            loc_oPagina2.txt_4c_Descricaos.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Diretores", 5)
            loc_oPagina2.txt_4c_Diretores.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_ObrigaSubclasse", 5)
            loc_oPagina2.opt_4c_ObrigaSubclasse.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_Tipo", 5)
            loc_oPagina2.opt_4c_Tipo.Enabled = par_lHabilitar
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_Autos", 5)
            loc_oPagina2.opt_4c_Autos.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campos de edicao (Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina2
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Codigos", 5)
            loc_oPagina2.txt_4c_Codigos.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Descricaos", 5)
            loc_oPagina2.txt_4c_Descricaos.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Diretores", 5)
            loc_oPagina2.txt_4c_Diretores.Value = ""
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_ObrigaSubclasse", 5)
            loc_oPagina2.opt_4c_ObrigaSubclasse.Value = 2
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_Tipo", 5)
            loc_oPagina2.opt_4c_Tipo.Value = 2
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_Autos", 5)
            loc_oPagina2.opt_4c_Autos.Value = 2
        ENDIF

        THIS.this_cUltimoDiretorValidado = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta visibilidade dos botoes de Page2 por modo
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina2, loc_lEdicao
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        IF PEMSTATUS(loc_oPagina2, "cnt_4c_BotoesDados", 5)
            IF PEMSTATUS(loc_oPagina2.cnt_4c_BotoesDados, "cmd_4c_Salvar", 5)
                loc_oPagina2.cnt_4c_BotoesDados.cmd_4c_Salvar.Enabled = loc_lEdicao
            ENDIF
            IF PEMSTATUS(loc_oPagina2.cnt_4c_BotoesDados, "cmd_4c_Cancelar", 5)
                loc_oPagina2.cnt_4c_BotoesDados.cmd_4c_Cancelar.Enabled = .T.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere dados do BO para os campos do formulario (Page2)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPagina2, loc_oBO
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO      = THIS.this_oBusinessObject

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Codigos", 5)
            loc_oPagina2.txt_4c_Codigos.Value = ALLTRIM(loc_oBO.this_cCodigo)
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Descricaos", 5)
            loc_oPagina2.txt_4c_Descricaos.Value = ALLTRIM(loc_oBO.this_cDescricao)
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Diretores", 5)
            loc_oPagina2.txt_4c_Diretores.Value  = ALLTRIM(loc_oBO.this_cDiretor)
            THIS.this_cUltimoDiretorValidado     = ALLTRIM(loc_oBO.this_cDiretor)
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_ObrigaSubclasse", 5)
            loc_oPagina2.opt_4c_ObrigaSubclasse.Value = loc_oBO.this_nChkSubs
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_Tipo", 5)
            loc_oPagina2.opt_4c_Tipo.Value = loc_oBO.this_nChkTipos
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_Autos", 5)
            loc_oPagina2.opt_4c_Autos.Value = loc_oBO.this_nAutos
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere dados dos campos do formulario para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPagina2, loc_oBO
        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2
        loc_oBO      = THIS.this_oBusinessObject

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Codigos", 5)
            loc_oBO.this_cCodigo = ALLTRIM(loc_oPagina2.txt_4c_Codigos.Value)
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Descricaos", 5)
            loc_oBO.this_cDescricao = ALLTRIM(loc_oPagina2.txt_4c_Descricaos.Value)
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "txt_4c_Diretores", 5)
            loc_oBO.this_cDiretor = ALLTRIM(loc_oPagina2.txt_4c_Diretores.Value)
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_ObrigaSubclasse", 5)
            loc_oBO.this_nChkSubs = loc_oPagina2.opt_4c_ObrigaSubclasse.Value
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_Tipo", 5)
            loc_oBO.this_nChkTipos = loc_oPagina2.opt_4c_Tipo.Value
        ENDIF

        IF PEMSTATUS(loc_oPagina2, "opt_4c_Autos", 5)
            loc_oBO.this_nAutos = loc_oPagina2.opt_4c_Autos.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Valida campos e salva (Inserir ou Atualizar via BO)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oPagina2, loc_cCodigo, loc_cDescricao

        loc_oPagina2 = THIS.pgf_4c_Paginas.Page2

        *-- Validacao campos obrigatorios (FORA do TRY)
        loc_cCodigo = ""
        IF PEMSTATUS(loc_oPagina2, "txt_4c_Codigos", 5)
            loc_cCodigo = ALLTRIM(loc_oPagina2.txt_4c_Codigos.Value)
        ENDIF

        IF EMPTY(loc_cCodigo)
            MostrarErro("O C" + CHR(243) + "digo precisa ser informado.", "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPagina2, "txt_4c_Codigos", 5)
                loc_oPagina2.txt_4c_Codigos.SetFocus()
            ENDIF
            RETURN
        ENDIF

        loc_cDescricao = ""
        IF PEMSTATUS(loc_oPagina2, "txt_4c_Descricaos", 5)
            loc_cDescricao = ALLTRIM(loc_oPagina2.txt_4c_Descricaos.Value)
        ENDIF

        IF EMPTY(loc_cDescricao)
            MostrarErro("A Descri" + CHR(231) + CHR(227) + "o precisa ser informada.", "Aten" + CHR(231) + CHR(227) + "o")
            IF PEMSTATUS(loc_oPagina2, "txt_4c_Descricaos", 5)
                loc_oPagina2.txt_4c_Descricaos.SetFocus()
            ENDIF
            RETURN
        ENDIF

        THIS.FormParaBO()

        IF THIS.this_oBusinessObject.Salvar()
            MsgSucesso("Departamento salvo com sucesso!")
            THIS.this_cModoAtual = "LISTA"
            THIS.AlternarPagina(1)
        ELSE
            MostrarErro("Erro ao salvar departamento:" + CHR(13) + ;
                THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela edicao e volta para a lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDiretor - Valida campo Diretor via lookup SigCdUsu (LostFocus)
    * Legado: getDiretores.Valid - fwBuscaExt SigCdUsu, campo Usuarios/NComps
    * Filtro original: [Not cAtivos='N']
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDiretor()
        LOCAL loc_cDiretor, loc_oBusca, loc_lSucesso, loc_nRet, loc_cSQL

        *-- Pula validacao em modo de validacao UI (evita SQLEXEC e dialogs modais)
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF

        loc_cDiretor = ""
        IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Diretores", 5)
            loc_cDiretor = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Diretores.Value)
        ENDIF

        *-- Valor nao mudou - nao revalidar (guarda para evitar abrir busca repetidamente)
        IF loc_cDiretor == THIS.this_cUltimoDiretorValidado
            RETURN
        ENDIF

        THIS.this_cUltimoDiretorValidado = loc_cDiretor

        *-- Campo vazio - aceitar (diretor e opcional)
        IF EMPTY(loc_cDiretor)
            RETURN
        ENDIF

        *-- Verificar se usuario existe exatamente em SigCdUsu
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT Usuarios FROM SigCdUsu WHERE Usuarios = " + ;
                EscaparSQL(loc_cDiretor) + " AND cAtivos <> 'N'"
            IF USED("cursor_4c_ValidaUsu")
                USE IN cursor_4c_ValidaUsu
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaUsu")
            IF loc_nRet > 0 AND !EOF("cursor_4c_ValidaUsu")
                *-- Encontrado exatamente - ok
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_ValidaUsu")
                USE IN cursor_4c_ValidaUsu
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar diretor:" + CHR(13) + loException.Message, "Erro")
            IF USED("cursor_4c_ValidaUsu")
                USE IN cursor_4c_ValidaUsu
            ENDIF
        ENDTRY

        IF loc_lSucesso
            RETURN
        ENDIF

        *-- Nao encontrado exatamente - abrir busca para selecao
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cDiretor, ;
                "Selecionar Diretor")

            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Usuarios", "", "Diretor")
                loc_oBusca.mAddColuna("NComps",   "", "Nome")
                loc_oBusca.Show()

                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                    SELECT cursor_4c_BuscaUsu
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Diretores.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                    THIS.this_cUltimoDiretorValidado = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                ELSE
                    *-- Usuario pressionou ESC - limpar campo (comportamento legado)
                    THIS.pgf_4c_Paginas.Page2.txt_4c_Diretores.Value = ""
                    THIS.this_cUltimoDiretorValidado = ""
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao abrir busca de diretores:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\DepartamentoBO.prg):
*==============================================================================
* DepartamentoBO.prg - Business Object para Cadastro de Departamentos
* Tabela: SigCdDpt
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS DepartamentoBO AS BusinessBase

    *-- Chave primaria
    this_cCodigo     = ""     && codigos C(10)

    *-- Campos descritivos
    this_cDescricao  = ""     && Descricaos C(40)
    this_cDiretor    = ""     && Diretors C(10) - FK SigCdUsu.Usuarios

    *-- Campos numericos (OptionGroups: 1=Sim, 2=Nao)
    this_nChkSubs    = 2      && nChkSubs N - Obriga Subclas. Encerramento
    this_nChkTipos   = 2      && nChkTipos N - Tipo
    this_nAutos      = 2      && autos N - Automatico

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdDpt"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna PK para auditoria
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta todas as propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCodigo    = ""
        THIS.this_cDescricao = ""
        THIS.this_cDiretor   = ""
        THIS.this_nChkSubs   = 2
        THIS.this_nChkTipos  = 2
        THIS.this_nAutos     = 2
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cDescricao))
            THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Popula propriedades a partir de cursor
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cCodigo    = ALLTRIM(NVL(codigos,    ""))
        THIS.this_cDescricao = ALLTRIM(NVL(descricaos, ""))
        THIS.this_cDiretor   = ALLTRIM(NVL(diretors,   ""))
        THIS.this_nChkSubs   = NVL(nchksubs,  2)
        THIS.this_nChkTipos  = NVL(nchktipos, 2)
        THIS.this_nAutos     = NVL(autos,     2)
        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro por PK
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT codigos, descricaos, diretors, nchksubs, nchktipos, autos" + ;
                       " FROM SigCdDpt WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            IF USED("cursor_4c_DptLoad")
                USE IN cursor_4c_DptLoad
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DptLoad")
            IF loc_nRet > 0
                IF !EOF("cursor_4c_DptLoad")
                    THIS.CarregarDoCursor("cursor_4c_DptLoad")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Departamento n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCodigo)
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro SQLEXEC ao carregar departamento: " + TRANSFORM(loc_nRet)
            ENDIF
            IF USED("cursor_4c_DptLoad")
                USE IN cursor_4c_DptLoad
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
            IF USED("cursor_4c_DptLoad")
                USE IN cursor_4c_DptLoad
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Popula cursor_4c_Dados com lista de departamentos
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL, loc_cWhere
        loc_lSucesso = .F.
        TRY
            IF !USED("cursor_4c_Dados")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(40), diretors C(10))
                SET NULL OFF
            ENDIF

            loc_cWhere = ""
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE codigos LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = "SELECT codigos, descricaos, diretors FROM SigCdDpt" + ;
                       loc_cWhere + " ORDER BY codigos"
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")
            IF loc_nRet > 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    APPEND FROM DBF("cursor_4c_DadosTemp")
                ELSE
                    SET NULL ON
                    SELECT * FROM cursor_4c_DadosTemp INTO CURSOR cursor_4c_Dados READWRITE
                    SET NULL OFF
                ENDIF
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar departamentos"
                IF USED("cursor_4c_DadosTemp")
                    USE IN cursor_4c_DadosTemp
                ENDIF
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - INSERT INTO SigCdDpt
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdDpt (codigos, descricaos, diretors, nchksubs, nchktipos, autos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       EscaparSQL(THIS.this_cDiretor) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkSubs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkTipos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutos) + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("I")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir departamento no banco de dados"
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE SigCdDpt
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdDpt SET " + ;
                       "descricaos = " + EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       "diretors = "   + EscaparSQL(THIS.this_cDiretor) + ", " + ;
                       "nchksubs = "   + FormatarNumeroSQL(THIS.this_nChkSubs) + ", " + ;
                       "nchktipos = "  + FormatarNumeroSQL(THIS.this_nChkTipos) + ", " + ;
                       "autos = "      + FormatarNumeroSQL(THIS.this_nAutos) + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet >= 0
                THIS.RegistrarAuditoria("A")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar departamento no banco de dados"
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE FROM SigCdDpt
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_nRet, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdDpt WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("E")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir departamento do banco de dados"
            ENDIF
        CATCH TO loEx
            THIS.this_cMensagemErro = "Linha " + TRANSFORM(loEx.LineNo) + ": " + loEx.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

