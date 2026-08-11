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
[2026-08-10 17:48:50] [INFO] Config FPW: (nao fornecido)
[2026-08-10 17:48:50] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 17:48:50] [INFO] Timeout: 300 segundos
[2026-08-10 17:48:50] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wfg0pgrp.prg
[2026-08-10 17:48:50] [INFO] Conteudo do wrapper:
[2026-08-10 17:48:50] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
QUIT

[2026-08-10 17:48:50] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wfg0pgrp.prg
[2026-08-10 17:48:50] [INFO] VFP output esperado em: C:\4c\tasks\task454\vfp_output.txt
[2026-08-10 17:48:50] [INFO] Executando Visual FoxPro 9...
[2026-08-10 17:48:50] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wfg0pgrp.prg
[2026-08-10 17:48:50] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wfg0pgrp.prg
[2026-08-10 17:48:50] [INFO] Timeout configurado: 300 segundos
[2026-08-10 17:53:50] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 6796)...
[2026-08-10 17:53:52] [INFO] VFP9 finalizado em 302.0585377 segundos
[2026-08-10 17:53:52] [INFO] Exit Code: 4
[2026-08-10 17:53:52] [INFO] 
[2026-08-10 17:53:52] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-10 17:53:52] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_wfg0pgrp.prg
[2026-08-10 17:53:52] [INFO] 
[2026-08-10 17:53:52] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-10 17:53:52] [INFO] * Auto-generated wrapper for parameters
[2026-08-10 17:53:52] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 17:53:52] [INFO] * Parameters: 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
[2026-08-10 17:53:52] [INFO] 
[2026-08-10 17:53:52] [INFO] * Anti-dialog protections for unattended execution
[2026-08-10 17:53:52] [INFO] SET SAFETY OFF
[2026-08-10 17:53:52] [INFO] SET RESOURCE OFF
[2026-08-10 17:53:52] [INFO] SET TALK OFF
[2026-08-10 17:53:52] [INFO] SET NOTIFY OFF
[2026-08-10 17:53:52] [INFO] SYS(2335, 0)
[2026-08-10 17:53:52] [INFO] 
[2026-08-10 17:53:52] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
[2026-08-10 17:53:52] [INFO] QUIT
[2026-08-10 17:53:52] [INFO] 
[2026-08-10 17:53:52] [INFO] === Fim do Wrapper.prg ===
[2026-08-10 17:53:52] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-10 18:12:58] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-10 18:12:58] [INFO] Config FPW: (nao fornecido)
[2026-08-10 18:12:58] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 18:12:58] [INFO] Timeout: 300 segundos
[2026-08-10 18:12:58] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_j3q45wh5.prg
[2026-08-10 18:12:58] [INFO] Conteudo do wrapper:
[2026-08-10 18:12:58] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
QUIT

[2026-08-10 18:12:58] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_j3q45wh5.prg
[2026-08-10 18:12:58] [INFO] VFP output esperado em: C:\4c\tasks\task454\vfp_output.txt
[2026-08-10 18:12:58] [INFO] Executando Visual FoxPro 9...
[2026-08-10 18:12:58] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_j3q45wh5.prg
[2026-08-10 18:12:58] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_j3q45wh5.prg
[2026-08-10 18:12:58] [INFO] Timeout configurado: 300 segundos
[2026-08-10 18:17:58] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 19324)...
[2026-08-10 18:18:00] [INFO] VFP9 finalizado em 302.0754095 segundos
[2026-08-10 18:18:00] [INFO] Exit Code: 4
[2026-08-10 18:18:00] [INFO] 
[2026-08-10 18:18:00] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-10 18:18:00] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_j3q45wh5.prg
[2026-08-10 18:18:00] [INFO] 
[2026-08-10 18:18:00] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-10 18:18:00] [INFO] * Auto-generated wrapper for parameters
[2026-08-10 18:18:00] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 18:18:00] [INFO] * Parameters: 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
[2026-08-10 18:18:00] [INFO] 
[2026-08-10 18:18:00] [INFO] * Anti-dialog protections for unattended execution
[2026-08-10 18:18:00] [INFO] SET SAFETY OFF
[2026-08-10 18:18:00] [INFO] SET RESOURCE OFF
[2026-08-10 18:18:00] [INFO] SET TALK OFF
[2026-08-10 18:18:00] [INFO] SET NOTIFY OFF
[2026-08-10 18:18:00] [INFO] SYS(2335, 0)
[2026-08-10 18:18:00] [INFO] 
[2026-08-10 18:18:00] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
[2026-08-10 18:18:00] [INFO] QUIT
[2026-08-10 18:18:00] [INFO] 
[2026-08-10 18:18:00] [INFO] === Fim do Wrapper.prg ===
[2026-08-10 18:18:00] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-10 18:36:04] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-10 18:36:04] [INFO] Config FPW: (nao fornecido)
[2026-08-10 18:36:04] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 18:36:04] [INFO] Timeout: 300 segundos
[2026-08-10 18:36:04] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fheouqia.prg
[2026-08-10 18:36:04] [INFO] Conteudo do wrapper:
[2026-08-10 18:36:04] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
QUIT

[2026-08-10 18:36:04] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fheouqia.prg
[2026-08-10 18:36:04] [INFO] VFP output esperado em: C:\4c\tasks\task454\vfp_output.txt
[2026-08-10 18:36:04] [INFO] Executando Visual FoxPro 9...
[2026-08-10 18:36:05] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fheouqia.prg
[2026-08-10 18:36:05] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fheouqia.prg
[2026-08-10 18:36:05] [INFO] Timeout configurado: 300 segundos
[2026-08-10 18:41:05] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 17192)...
[2026-08-10 18:41:07] [INFO] VFP9 finalizado em 302.0562585 segundos
[2026-08-10 18:41:07] [INFO] Exit Code: 4
[2026-08-10 18:41:07] [INFO] 
[2026-08-10 18:41:07] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-10 18:41:07] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fheouqia.prg
[2026-08-10 18:41:07] [INFO] 
[2026-08-10 18:41:07] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-10 18:41:07] [INFO] * Auto-generated wrapper for parameters
[2026-08-10 18:41:07] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 18:41:07] [INFO] * Parameters: 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
[2026-08-10 18:41:07] [INFO] 
[2026-08-10 18:41:07] [INFO] * Anti-dialog protections for unattended execution
[2026-08-10 18:41:07] [INFO] SET SAFETY OFF
[2026-08-10 18:41:07] [INFO] SET RESOURCE OFF
[2026-08-10 18:41:07] [INFO] SET TALK OFF
[2026-08-10 18:41:07] [INFO] SET NOTIFY OFF
[2026-08-10 18:41:07] [INFO] SYS(2335, 0)
[2026-08-10 18:41:07] [INFO] 
[2026-08-10 18:41:07] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
[2026-08-10 18:41:07] [INFO] QUIT
[2026-08-10 18:41:07] [INFO] 
[2026-08-10 18:41:07] [INFO] === Fim do Wrapper.prg ===
[2026-08-10 18:41:07] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-10 19:01:03] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-10 19:01:03] [INFO] Config FPW: (nao fornecido)
[2026-08-10 19:01:03] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 19:01:03] [INFO] Timeout: 300 segundos
[2026-08-10 19:01:03] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_heioxvgp.prg
[2026-08-10 19:01:03] [INFO] Conteudo do wrapper:
[2026-08-10 19:01:03] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
QUIT

[2026-08-10 19:01:03] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_heioxvgp.prg
[2026-08-10 19:01:03] [INFO] VFP output esperado em: C:\4c\tasks\task454\vfp_output.txt
[2026-08-10 19:01:03] [INFO] Executando Visual FoxPro 9...
[2026-08-10 19:01:03] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_heioxvgp.prg
[2026-08-10 19:01:03] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_heioxvgp.prg
[2026-08-10 19:01:03] [INFO] Timeout configurado: 300 segundos
[2026-08-10 19:06:03] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 8420)...
[2026-08-10 19:06:05] [INFO] VFP9 finalizado em 302.0578243 segundos
[2026-08-10 19:06:05] [INFO] Exit Code: 4
[2026-08-10 19:06:05] [INFO] 
[2026-08-10 19:06:05] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-10 19:06:05] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_heioxvgp.prg
[2026-08-10 19:06:05] [INFO] 
[2026-08-10 19:06:05] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-10 19:06:05] [INFO] * Auto-generated wrapper for parameters
[2026-08-10 19:06:05] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-10 19:06:05] [INFO] * Parameters: 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
[2026-08-10 19:06:05] [INFO] 
[2026-08-10 19:06:05] [INFO] * Anti-dialog protections for unattended execution
[2026-08-10 19:06:05] [INFO] SET SAFETY OFF
[2026-08-10 19:06:05] [INFO] SET RESOURCE OFF
[2026-08-10 19:06:05] [INFO] SET TALK OFF
[2026-08-10 19:06:05] [INFO] SET NOTIFY OFF
[2026-08-10 19:06:05] [INFO] SYS(2335, 0)
[2026-08-10 19:06:05] [INFO] 
[2026-08-10 19:06:05] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormJrn', 'C:\4c\tasks\task454', 'CRUD'
[2026-08-10 19:06:05] [INFO] QUIT
[2026-08-10 19:06:05] [INFO] 
[2026-08-10 19:06:05] [INFO] === Fim do Wrapper.prg ===
[2026-08-10 19:06:05] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\cadastros\FormJrn.prg):
*==============================================================================
* FormJrn.prg - Cadastro de Jornadas de Trabalho
* Herda de FormBase
* Tabela: SigCdJrn | BO: JrnBO
* Migrado de: SIGCDJRN.SCX (frmcadastro)
* Fase 8/8: COMPLETO - todos os metodos implementados
*==============================================================================

DEFINE CLASS FormJrn AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades visuais (PILAR 1 - UX Fidelity)
    * Original: Width=834, Height=602 -> novo sistema padrao: 1000x600
    *--------------------------------------------------------------------------
    Height      = 600
    Width       = 1000
    Caption     = "Jornadas de Trabalho"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *--------------------------------------------------------------------------
    * Business Object e estado do formulario
    *--------------------------------------------------------------------------
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *-- Contexto do registro selecionado (anoatu/mesatu no legado)
    this_cAnoAtual = ""
    this_cMesAtual = ""

    *==========================================================================
    * Init - FormBase.Init() ja chama InicializarForm() automaticamente
    *==========================================================================
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Configura estrutura completa (chamado por FormBase)
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("JrnBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                THIS.pgf_4c_Paginas.Visible = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual = "LISTA"
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar JrnBO." + CHR(13) + ;
                        "VARTYPE: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.InicializarForm:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - PageFrame Top=-29 oculta abas (compensar +29 no Top)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount  = 2
            .Top        = -29
            .Left       = 0
            .Width      = THIS.Width
            .Height     = THIS.Height + 29
            .Tabs       = .F.
            .TabStretch = 1
            .Visible    = .T.
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page1
            .Caption   = "Lista"
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        WITH THIS.pgf_4c_Paginas.Page2
            .Caption   = "Dados"
            .BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Page1 com cabecalho, botoes CRUD e Grid
    *
    * Referencia legado (SIGCDJRN 834px):
    *   cntSombra   : Top=1,  Left=-1, Width=840, Height=80
    *   Grupo_Op    : Top=-1, Left=375 (Width~390)  -> canonico Left=542
    *   Grupo_Saida : Top=-1, Left=750               -> canonico Left=917
    *   Command1    : Top=4,  Left=305 ("Copia Mes") -> Left=462 (proporcional)
    *   Grade       : Top=96, Left=32, Width=783, Height=470
    * Compensacao PageFrame (+29): grade.Top = 96+29 = 125
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Cabecalho cinza (cntSombra.Top=1 -> 1+29=30)
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
            .Caption   = "Jornadas de Trabalho"
            .Top       = 15
            .Left      = 11
            .Width     = THIS.Width - 20
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
            .Caption   = "Jornadas de Trabalho"
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
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
        * Container botoes CRUD (canonico: Left=542, Top=28)
        * Grupo_Op original: Left=375, Top=-1 -> novo: 542, -1+29=28
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        = 542
            .Width       = 390
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        *-- Incluir (Inserir.Left=5)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
            .Caption         = "Incluir"
            .Top             = 5
            .Left            = 5
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")

        *-- Visualizar (Consultar.Left=80)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
            .Caption         = "Visualizar"
            .Top             = 5
            .Left            = 80
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")

        *-- Alterar (Left=155)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
            .Caption         = "Alterar"
            .Top             = 5
            .Left            = 155
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")

        *-- Excluir (Left=230)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
            .Caption         = "Excluir"
            .Top             = 5
            .Left            = 230
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")

        *-- Buscar (Procurar.Left=305)
        loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
        WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
            .Caption         = "Buscar"
            .Top             = 5
            .Left            = 305
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")

        *----------------------------------------------------------------------
        * Container saida - padrao canonico CLAUDE.md #10
        * Grupo_Saida.Left=750, Top=-1 -> canonico Left=917, Top=28
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
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
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")

        *----------------------------------------------------------------------
        * Botao "Copia Mes" (Command1 standalone no legado)
        * Original: Top=4, Left=305 em form 834px
        * Novo:     Top=4+29=33, Left proporcional ~462 (a esquerda de 542)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cmd_4c_CopiarMes", "CommandButton")
        WITH loc_oPagina.cmd_4c_CopiarMes
            .Caption         = "Copia M" + CHR(234) + "s"
            .Top             = 33
            .Left            = 462
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cmd_4c_CopiarMes, "Click", THIS, "BtnCopiarMesClick")

        *----------------------------------------------------------------------
        * Grid (Grade no legado: Top=96, Left=32, Width=783, Height=470)
        * Novo: Top=96+29=125, Left=32, Width=880 (ate cnt_4c_Saida.Left=917)
        * 14 colunas: iclis, cargos, refers, hora01-04, cDom-cSab
        *
        * ColumnCount FORA do WITH (Problema 36: nao criar colunas dentro de WITH)
        * ControlSource redefinido em CarregarLista apos RecordSource (Problema 48)
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista

        loc_oGrid.ColumnCount = 14

        WITH loc_oGrid
            .Top                = 125
            .Left               = 32
            .Width              = 880
            .Height             = 470
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
            .Visible            = .T.

            .Column1.Width           = 80
            .Column1.Alignment       = 0
            .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"

            .Column2.Width           = 80
            .Column2.Alignment       = 0
            .Column2.Header1.Caption = "Cargo"

            .Column3.Width           = 52
            .Column3.Alignment       = 0
            .Column3.Header1.Caption = "Ano/M" + CHR(234) + "s"

            .Column4.Width           = 45
            .Column4.Alignment       = 0
            .Column4.Header1.Caption = "Inicio"

            .Column5.Width           = 45
            .Column5.Alignment       = 0
            .Column5.Header1.Caption = "Intervalo"

            .Column6.Width           = 45
            .Column6.Alignment       = 0
            .Column6.Header1.Caption = "Intervalo"

            .Column7.Width           = 45
            .Column7.Alignment       = 0
            .Column7.Header1.Caption = "Fim"

            .Column8.Width            = 20
            .Column8.Alignment        = 2
            .Column8.Header1.Caption  = "Dom"

            .Column9.Width            = 20
            .Column9.Alignment        = 2
            .Column9.Header1.Caption  = "Seg"

            .Column10.Width           = 20
            .Column10.Alignment       = 2
            .Column10.Header1.Caption = "Ter"

            .Column11.Width           = 20
            .Column11.Alignment       = 2
            .Column11.Header1.Caption = "Qua"

            .Column12.Width           = 20
            .Column12.Alignment       = 2
            .Column12.Header1.Caption = "Qui"

            .Column13.Width           = 20
            .Column13.Alignment       = 2
            .Column13.Header1.Caption = "Sex"

            .Column14.Width           = 20
            .Column14.Alignment       = 2
            .Column14.Header1.Caption = "S" + CHR(225) + "b"
        ENDWITH

        *----------------------------------------------------------------------
        * Painel flutuante "Copiar Jornada do Mes" (Problema 26: iniciar oculto)
        * Original cntCopiaMes: Top=233, Left=280, Width=273, Height=136
        * Com compensacao PageFrame +29: Top=262
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_CopiaMes", "Container")
        WITH loc_oPagina.cnt_4c_CopiaMes
            .Top         = 262
            .Left        = 280
            .Width       = 273
            .Height      = 136
            .BackStyle   = 1
            .BackColor   = RGB(240, 240, 240)
            .BorderColor = RGB(100, 100, 100)
            .Visible     = .F.
        ENDWITH

        loc_oPagina.cnt_4c_CopiaMes.AddObject("shp_4c_HeaderCopia", "Shape")
        WITH loc_oPagina.cnt_4c_CopiaMes.shp_4c_HeaderCopia
            .Top         = 0
            .Left        = 0
            .Width       = 274
            .Height      = 25
            .BackStyle   = 1
            .BackColor   = RGB(53, 53, 53)
            .BorderStyle = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_CopiaMes.AddObject("lbl_4c_TituloCopiaMes", "Label")
        WITH loc_oPagina.cnt_4c_CopiaMes.lbl_4c_TituloCopiaMes
            .Caption   = "  Copiar Jornada do M" + CHR(234) + "s"
            .Top       = 4
            .Left      = 2
            .Width     = 197
            .Height    = 21
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .BackStyle = 0
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_CopiaMes.AddObject("lbl_4c_De", "Label")
        WITH loc_oPagina.cnt_4c_CopiaMes.lbl_4c_De
            .Caption   = "De :"
            .Top       = 57
            .Left      = 44
            .Height    = 15
            .Width     = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_CopiaMes.AddObject("cbo_4c_De", "ComboBox")
        WITH loc_oPagina.cnt_4c_CopiaMes.cbo_4c_De
            .Top           = 53
            .Left          = 71
            .Width         = 100
            .Height        = 24
            .ColumnCount   = 2
            .ColumnWidths  = "95,0"
            .BoundColumn   = 2
            .RowSourceType = 1
            .RowSource     = ""
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        loc_oPagina.cnt_4c_CopiaMes.AddObject("lbl_4c_Para", "Label")
        WITH loc_oPagina.cnt_4c_CopiaMes.lbl_4c_Para
            .Caption   = "Para :"
            .Top       = 87
            .Left      = 31
            .Height    = 15
            .Width     = 35
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 0, 0)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.cnt_4c_CopiaMes.AddObject("cbo_4c_Para", "ComboBox")
        WITH loc_oPagina.cnt_4c_CopiaMes.cbo_4c_Para
            .Top           = 82
            .Left          = 71
            .Width         = 100
            .Height        = 24
            .ColumnCount   = 2
            .ColumnWidths  = "95,0"
            .BoundColumn   = 2
            .RowSourceType = 1
            .RowSource     = ""
            .Style         = 2
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Visible       = .T.
        ENDWITH

        *-- Botao Confirmar (Command2 no legado: Top=39, Left=213, Width=40, Height=40)
        loc_oPagina.cnt_4c_CopiaMes.AddObject("cmd_4c_CopiarMesOK", "CommandButton")
        WITH loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesOK
            .Caption       = "OK"
            .Top           = 39
            .Left          = 213
            .Width         = 40
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(0, 100, 0)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesOK, "Click", THIS, "CopiaMesConfirmarClick")

        *-- Botao Cancelar (Command1 no legado: Top=80, Left=213, Width=40, Height=40)
        loc_oPagina.cnt_4c_CopiaMes.AddObject("cmd_4c_CopiarMesX", "CommandButton")
        WITH loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesX
            .Caption       = "X"
            .Top           = 80
            .Left          = 213
            .Width         = 40
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 8
            .FontBold      = .T.
            .ForeColor     = RGB(180, 0, 0)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesX, "Click", THIS, "CopiaMesCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Page2 completa com todos os campos
    *
    * Referencia legado (834px, sem compensacao +29):
    *   Grupo_Salva : Left=635, Top=13  -> novo: Left=760, Top=42 (13+29)
    *   getCodCli   : Left=148, Top=163 -> Top=192 (+29)
    *   getDesCli   : Left=232, Top=163 -> Top=192 (+29), Width=360
    *   getCodCgo   : Left=148, Top=189 -> Top=218 (+29)
    *   cboMes/Ano  : Left=148/232, Top=136 -> Top=165 (+29)
    *   getHora01-04: Top=246 -> Top=275 (+29)
    *   checkboxes  : Top=295/318 -> Top=324/347 (+29)
    *   Shape(dias) : Top=287  -> Top=316 (+29), Width=433, Height=57
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_cAnos, loc_n, loc_cRowMes
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cAnos   = ""
        loc_cRowMes = "Janeiro,01,Fevereiro,02,Mar" + CHR(231) + "o,03,Abril,04,Maio,05," + ;
                      "Junho,06,Julho,07,Agosto,08,Setembro,09,Outubro,10," + ;
                      "Novembro,11,Dezembro,12"

        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Anos: lista dinamica (ano-5 ate ano+5)
        FOR loc_n = YEAR(DATE()) - 5 TO YEAR(DATE()) + 5
            IF !EMPTY(loc_cAnos)
                loc_cAnos = loc_cAnos + ","
            ENDIF
            loc_cAnos = loc_cAnos + STR(loc_n, 4)
        ENDFOR

        *----------------------------------------------------------------------
        * Container botoes acao (Grupo_Salva: Left=635->760, Top=13->42)
        * Confirmar.Left=5, Cancelar.Left=85, ambos Width=75, Height=75
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPagina.cnt_4c_BotoesAcao
            .Top         = 42
            .Left        = 760
            .Width       = 165
            .Height      = 85
            .BackStyle = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
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
            .Themes          = .F.
            .SpecialEffect   = 0
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")

        loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
        WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 85
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
            .AutoSize        = .F.
            .Visible         = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")

        *----------------------------------------------------------------------
        * Referencia: label + combo Mes + combo Ano
        * Label8 "Referencia :" Left=83, Top=139 -> Top=168
        * cboMes: Left=148, Top=136 -> Top=165
        * cboAno: Left=232, Top=136 -> Top=165
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_LblReferencia", "Label")
        WITH loc_oPagina.lbl_4c_LblReferencia
            .Caption   = "Refer" + CHR(234) + "ncia :"
            .Top       = 168
            .Left      = 83
            .Height    = 15
            .Width     = 65
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("cbo_4c_CboMes", "ComboBox")
        WITH loc_oPagina.cbo_4c_CboMes
            .Top             = 165
            .Left            = 148
            .Width           = 80
            .Height          = 24
            .BoundColumn     = 2
            .ColumnCount     = 2
            .ColumnWidths    = "0,70"
            .RowSourceType   = 1
            .RowSource       = loc_cRowMes
            .Style           = 2
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Visible         = .T.
        ENDWITH

        loc_oPagina.AddObject("cbo_4c_CboAno", "ComboBox")
        WITH loc_oPagina.cbo_4c_CboAno
            .Top             = 165
            .Left            = 232
            .Width           = 60
            .Height          = 24
            .ColumnCount     = 1
            .ColumnWidths    = "55"
            .RowSourceType   = 1
            .RowSource       = loc_cAnos
            .Style           = 2
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Visible         = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Funcionario: label + codigo + nome
        * Label2 "Funcionario :" Left=80, Top=166 -> Top=195
        * getCodCli: Left=148, Top=163 -> Top=192, Width=80
        * getDesCli: Left=232, Top=163 -> Top=192, Width=360
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_LblFuncionario", "Label")
        WITH loc_oPagina.lbl_4c_LblFuncionario
            .Caption   = "Funcion" + CHR(225) + "rio :"
            .Top       = 195
            .Left      = 80
            .Height    = 15
            .Width     = 68
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CodCli", "TextBox")
        WITH loc_oPagina.txt_4c_CodCli
            .Top                 = 192
            .Left                = 148
            .Width               = 80
            .Height              = 23
            .Value               = ""
            .FontName            = "Tahoma"
            .FontSize            = 8
            .DisabledBackColor   = RGB(255, 255, 255)
            .BackColor           = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CodCli, "KeyPress", THIS, "ValidarCodCli")
        BINDEVENT(loc_oPagina.txt_4c_CodCli, "KeyPress",  THIS, "TeclaLookupCodCli")

        loc_oPagina.AddObject("txt_4c_DesCli", "TextBox")
        WITH loc_oPagina.txt_4c_DesCli
            .Top                 = 192
            .Left                = 232
            .Width               = 360
            .Height              = 23
            .Value               = ""
            .Alignment           = 0
            .FontName            = "Tahoma"
            .FontSize            = 8
            .DisabledBackColor   = RGB(255, 255, 255)
            .BackColor           = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_DesCli, "KeyPress", THIS, "ValidarDesCli")
        BINDEVENT(loc_oPagina.txt_4c_DesCli, "KeyPress",  THIS, "TeclaLookupDesCli")

        *----------------------------------------------------------------------
        * Cargo: label + codigo
        * Label3 "Cargo :" Left=106, Top=192 -> Top=221
        * getCodCgo: Left=148, Top=189 -> Top=218, Width=80, Height=23
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_LblCargo", "Label")
        WITH loc_oPagina.lbl_4c_LblCargo
            .Caption   = "Cargo :"
            .Top       = 221
            .Left      = 106
            .Height    = 15
            .Width     = 40
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_CodCgo", "TextBox")
        WITH loc_oPagina.txt_4c_CodCgo
            .Top                 = 218
            .Left                = 148
            .Width               = 80
            .Height              = 23
            .Value               = ""
            .FontName            = "Tahoma"
            .FontSize            = 8
            .DisabledBackColor   = RGB(255, 255, 255)
            .BackColor           = RGB(255, 255, 255)
            .Visible             = .T.
        ENDWITH
        BINDEVENT(loc_oPagina.txt_4c_CodCgo, "KeyPress", THIS, "ValidarCodCgo")
        BINDEVENT(loc_oPagina.txt_4c_CodCgo, "KeyPress",  THIS, "TeclaLookupCodCgo")

        *----------------------------------------------------------------------
        * Horarios: labels + 4 campos HH:MM
        * Label7 "Horarios :" Left=95, Top=249 -> Top=278
        * Labels Inicio/Intervalo/Fim: Top=225 -> Top=254
        * getHora01-04: Top=246 -> Top=275, Width=45
        *   Left: 148 / 205 / 262 / 320
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_LblHorarios", "Label")
        WITH loc_oPagina.lbl_4c_LblHorarios
            .Caption   = "Hor" + CHR(225) + "rios :"
            .Top       = 278
            .Left      = 95
            .Height    = 15
            .Width     = 52
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblInicio", "Label")
        WITH loc_oPagina.lbl_4c_LblInicio
            .Caption   = "In" + CHR(237) + "cio"
            .Top       = 254
            .Left      = 155
            .Height    = 15
            .Width     = 30
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblIntervalo", "Label")
        WITH loc_oPagina.lbl_4c_LblIntervalo
            .Caption   = "Intervalo"
            .Top       = 254
            .Left      = 205
            .Height    = 15
            .Width     = 52
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_LblFim", "Label")
        WITH loc_oPagina.lbl_4c_LblFim
            .Caption   = "Fim"
            .Top       = 254
            .Left      = 331
            .Height    = 15
            .Width     = 25
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Hora01", "TextBox")
        WITH loc_oPagina.txt_4c_Hora01
            .Top       = 275
            .Left      = 148
            .Width     = 45
            .Height    = 23
            .Value     = ""
            .InputMask = "99:99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Hora02", "TextBox")
        WITH loc_oPagina.txt_4c_Hora02
            .Top       = 275
            .Left      = 205
            .Width     = 45
            .Height    = 23
            .Value     = ""
            .InputMask = "99:99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Hora03", "TextBox")
        WITH loc_oPagina.txt_4c_Hora03
            .Top       = 275
            .Left      = 262
            .Width     = 45
            .Height    = 23
            .Value     = ""
            .InputMask = "99:99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Hora04", "TextBox")
        WITH loc_oPagina.txt_4c_Hora04
            .Top       = 275
            .Left      = 320
            .Width     = 45
            .Height    = 23
            .Value     = ""
            .InputMask = "99:99"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *----------------------------------------------------------------------
        * Dias: label + shape (moldura) + 7 checkboxes
        * Label1 "Dias :" Left=115, Top=293 -> Top=322
        * Shape: Left=148, Top=287 -> Top=316, Width=433, Height=57
        * CheckBoxes (posicoes originais com +29):
        *   Dom/Seg: Left=160, Top=295/318 -> 324/347
        *   Ter/Qua: Left=267, Top=295/318 -> 324/347
        *   Qui/Sex: Left=392, Top=295/318 -> 324/347
        *   Sab:     Left=508, Top=295     -> 324
        *----------------------------------------------------------------------
        loc_oPagina.AddObject("lbl_4c_LblDias", "Label")
        WITH loc_oPagina.lbl_4c_LblDias
            .Caption   = "Dias :"
            .Top       = 322
            .Left      = 115
            .Height    = 15
            .Width     = 32
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(0, 90, 90)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Shape decorativo ao redor dos checkboxes (adicionado ANTES dos chks)
        loc_oPagina.AddObject("shp_4c_DiasBox", "Shape")
        WITH loc_oPagina.shp_4c_DiasBox
            .Top         = 316
            .Left        = 148
            .Width       = 433
            .Height      = 57
            .BackStyle   = 0
            .BorderStyle = 1
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- Dom: Left=160, Top=324
        loc_oPagina.AddObject("chk_4c_ChkDom", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkDom
            .Caption   = "Domingo"
            .Top       = 324
            .Left      = 160
            .Height    = 17
            .Width     = 60
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Seg: Left=160, Top=347
        loc_oPagina.AddObject("chk_4c_ChkSeg", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkSeg
            .Caption   = "Segunda"
            .Top       = 347
            .Left      = 160
            .Height    = 17
            .Width     = 60
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Ter: Left=267, Top=324
        loc_oPagina.AddObject("chk_4c_ChkTer", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkTer
            .Caption   = "Ter" + CHR(231) + "a"
            .Top       = 324
            .Left      = 267
            .Height    = 17
            .Width     = 50
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Qua: Left=267, Top=347
        loc_oPagina.AddObject("chk_4c_ChkQua", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkQua
            .Caption   = "Quarta"
            .Top       = 347
            .Left      = 267
            .Height    = 17
            .Width     = 55
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Qui: Left=392, Top=324
        loc_oPagina.AddObject("chk_4c_ChkQui", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkQui
            .Caption   = "Quinta"
            .Top       = 324
            .Left      = 392
            .Height    = 17
            .Width     = 55
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Sex: Left=392, Top=347
        loc_oPagina.AddObject("chk_4c_ChkSex", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkSex
            .Caption   = "Sexta"
            .Top       = 347
            .Left      = 392
            .Height    = 17
            .Width     = 50
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        *-- Sab: Left=508, Top=324
        loc_oPagina.AddObject("chk_4c_ChkSab", "CheckBox")
        WITH loc_oPagina.chk_4c_ChkSab
            .Caption   = "S" + CHR(225) + "bado"
            .Top       = 324
            .Left      = 508
            .Height    = 17
            .Width     = 55
            .Value     = 0
            .Alignment = 0
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .AutoSize  = .F.
            .Visible   = .T.
        ENDWITH

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *==========================================================================
    * CarregarLista - Busca dados no BO e vincula ao grid
    * Sequencia obrigatoria: Buscar -> RecordSource (fora WITH) -> AtualizarBinding
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oGrid
        loc_lSucesso = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- RecordSource e ColumnCount FORA do WITH (Problema 36/48)
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 14

                    *-- Redefine ControlSource + Headers apos RecordSource (Problema 48)
                    THIS.AtualizarBindingGrid(loc_oGrid)
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * AtualizarBindingGrid - Redefine ControlSource, Width e Header das 14 colunas
    * Chamado apos RecordSource (Problema 48: auto-bind reseta ControlSource)
    *==========================================================================
    PROTECTED PROCEDURE AtualizarBindingGrid(par_oGrid)
        WITH par_oGrid
            .Column1.ControlSource   = "cursor_4c_Dados.iclis"
            .Column1.Width           = 80
            .Column1.Alignment       = 0
            .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"

            .Column2.ControlSource   = "cursor_4c_Dados.cargos"
            .Column2.Width           = 80
            .Column2.Alignment       = 0
            .Column2.Header1.Caption = "Cargo"

            .Column3.ControlSource   = "cursor_4c_Dados.refers"
            .Column3.Width           = 52
            .Column3.Alignment       = 0
            .Column3.Header1.Caption = "Ano/M" + CHR(234) + "s"

            .Column4.ControlSource   = "cursor_4c_Dados.hora01"
            .Column4.Width           = 45
            .Column4.Alignment       = 0
            .Column4.Header1.Caption = "Inicio"

            .Column5.ControlSource   = "cursor_4c_Dados.hora02"
            .Column5.Width           = 45
            .Column5.Alignment       = 0
            .Column5.Header1.Caption = "Intervalo"

            .Column6.ControlSource   = "cursor_4c_Dados.hora03"
            .Column6.Width           = 45
            .Column6.Alignment       = 0
            .Column6.Header1.Caption = "Intervalo"

            .Column7.ControlSource   = "cursor_4c_Dados.hora04"
            .Column7.Width           = 45
            .Column7.Alignment       = 0
            .Column7.Header1.Caption = "Fim"

            .Column8.ControlSource   = "cursor_4c_Dados.cDom"
            .Column8.Width           = 20
            .Column8.Alignment       = 2
            .Column8.Header1.Caption = "Dom"

            .Column9.ControlSource   = "cursor_4c_Dados.cSeg"
            .Column9.Width           = 20
            .Column9.Alignment       = 2
            .Column9.Header1.Caption = "Seg"

            .Column10.ControlSource  = "cursor_4c_Dados.cTer"
            .Column10.Width          = 20
            .Column10.Alignment      = 2
            .Column10.Header1.Caption = "Ter"

            .Column11.ControlSource  = "cursor_4c_Dados.cQua"
            .Column11.Width          = 20
            .Column11.Alignment      = 2
            .Column11.Header1.Caption = "Qua"

            .Column12.ControlSource  = "cursor_4c_Dados.cQui"
            .Column12.Width          = 20
            .Column12.Alignment      = 2
            .Column12.Header1.Caption = "Qui"

            .Column13.ControlSource  = "cursor_4c_Dados.cSex"
            .Column13.Width          = 20
            .Column13.Alignment      = 2
            .Column13.Header1.Caption = "Sex"

            .Column14.ControlSource  = "cursor_4c_Dados.cSab"
            .Column14.Width          = 20
            .Column14.Alignment      = 2
            .Column14.Header1.Caption = "S" + CHR(225) + "b"
        ENDWITH
    ENDPROC

    *==========================================================================
    * FormatarGridLista - Padroniza fonte de todas as colunas
    *==========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Copia propriedades do BO para os controles de Page2
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oPagina
        loc_lSucesso = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Referencia: extrai ano (4) e mes (2) da string refers
            IF LEN(ALLTRIM(THIS.this_oBusinessObject.this_cRefers)) = 6
                loc_oPagina.cbo_4c_CboAno.Value = SUBSTR(ALLTRIM(THIS.this_oBusinessObject.this_cRefers), 1, 4)
                loc_oPagina.cbo_4c_CboMes.Value = SUBSTR(ALLTRIM(THIS.this_oBusinessObject.this_cRefers), 5, 2)
            ELSE
                loc_oPagina.cbo_4c_CboAno.Value = STR(YEAR(DATE()), 4)
                loc_oPagina.cbo_4c_CboMes.Value = PADL(LTRIM(STR(MONTH(DATE()))), 2, "0")
            ENDIF

            *-- Funcionario
            loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(THIS.this_oBusinessObject.this_cIclis)
            loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescri)

            *-- Cargo
            loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCargos)

            *-- Horarios
            loc_oPagina.txt_4c_Hora01.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora01)
            loc_oPagina.txt_4c_Hora02.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora02)
            loc_oPagina.txt_4c_Hora03.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora03)
            loc_oPagina.txt_4c_Hora04.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora04)

            *-- Dias da semana (BO = logical, CheckBox.Value = numeric 0/1)
            loc_oPagina.chk_4c_ChkDom.Value = IIF(THIS.this_oBusinessObject.this_lDom, 1, 0)
            loc_oPagina.chk_4c_ChkSeg.Value = IIF(THIS.this_oBusinessObject.this_lSeg, 1, 0)
            loc_oPagina.chk_4c_ChkTer.Value = IIF(THIS.this_oBusinessObject.this_lTer, 1, 0)
            loc_oPagina.chk_4c_ChkQua.Value = IIF(THIS.this_oBusinessObject.this_lQua, 1, 0)
            loc_oPagina.chk_4c_ChkQui.Value = IIF(THIS.this_oBusinessObject.this_lQui, 1, 0)
            loc_oPagina.chk_4c_ChkSex.Value = IIF(THIS.this_oBusinessObject.this_lSex, 1, 0)
            loc_oPagina.chk_4c_ChkSab.Value = IIF(THIS.this_oBusinessObject.this_lSab, 1, 0)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia valores dos controles de Page2 para o BO
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oPagina, loc_cAno, loc_cMes
        loc_lSucesso = .F.

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2

            *-- Referencia: combina ano e mes
            loc_cAno = ALLTRIM(NVL(loc_oPagina.cbo_4c_CboAno.Value, ""))
            loc_cMes = ALLTRIM(NVL(loc_oPagina.cbo_4c_CboMes.Value, ""))
            THIS.this_oBusinessObject.this_cRefers = loc_cAno + loc_cMes

            *-- Funcionario
            THIS.this_oBusinessObject.this_cIclis  = ALLTRIM(loc_oPagina.txt_4c_CodCli.Value)
            THIS.this_oBusinessObject.this_cDescri = ALLTRIM(loc_oPagina.txt_4c_DesCli.Value)

            *-- Cargo
            THIS.this_oBusinessObject.this_cCargos = ALLTRIM(loc_oPagina.txt_4c_CodCgo.Value)

            *-- Horarios
            THIS.this_oBusinessObject.this_cHora01 = ALLTRIM(loc_oPagina.txt_4c_Hora01.Value)
            THIS.this_oBusinessObject.this_cHora02 = ALLTRIM(loc_oPagina.txt_4c_Hora02.Value)
            THIS.this_oBusinessObject.this_cHora03 = ALLTRIM(loc_oPagina.txt_4c_Hora03.Value)
            THIS.this_oBusinessObject.this_cHora04 = ALLTRIM(loc_oPagina.txt_4c_Hora04.Value)

            *-- Dias da semana (CheckBox.Value = 0/1 numeric -> logical via comparacao)
            THIS.this_oBusinessObject.this_lDom = (loc_oPagina.chk_4c_ChkDom.Value = 1)
            THIS.this_oBusinessObject.this_lSeg = (loc_oPagina.chk_4c_ChkSeg.Value = 1)
            THIS.this_oBusinessObject.this_lTer = (loc_oPagina.chk_4c_ChkTer.Value = 1)
            THIS.this_oBusinessObject.this_lQua = (loc_oPagina.chk_4c_ChkQua.Value = 1)
            THIS.this_oBusinessObject.this_lQui = (loc_oPagina.chk_4c_ChkQui.Value = 1)
            THIS.this_oBusinessObject.this_lSex = (loc_oPagina.chk_4c_ChkSex.Value = 1)
            THIS.this_oBusinessObject.this_lSab = (loc_oPagina.chk_4c_ChkSab.Value = 1)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa todos os campos de Page2 para novo registro
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_cMesAtual, loc_cAnoAtual

        TRY
            loc_oPagina   = THIS.pgf_4c_Paginas.Page2
            loc_cMesAtual = PADL(LTRIM(STR(MONTH(DATE()))), 2, "0")
            loc_cAnoAtual = STR(YEAR(DATE()), 4)

            loc_oPagina.cbo_4c_CboMes.Value    = loc_cMesAtual
            loc_oPagina.cbo_4c_CboAno.Value    = loc_cAnoAtual
            loc_oPagina.txt_4c_CodCli.Value    = ""
            loc_oPagina.txt_4c_DesCli.Value    = ""
            loc_oPagina.txt_4c_CodCgo.Value    = ""
            loc_oPagina.txt_4c_Hora01.Value    = ""
            loc_oPagina.txt_4c_Hora02.Value    = ""
            loc_oPagina.txt_4c_Hora03.Value    = ""
            loc_oPagina.txt_4c_Hora04.Value    = ""
            loc_oPagina.chk_4c_ChkDom.Value   = 0
            loc_oPagina.chk_4c_ChkSeg.Value   = 0
            loc_oPagina.chk_4c_ChkTer.Value   = 0
            loc_oPagina.chk_4c_ChkQua.Value   = 0
            loc_oPagina.chk_4c_ChkQui.Value   = 0
            loc_oPagina.chk_4c_ChkSex.Value   = 0
            loc_oPagina.chk_4c_ChkSab.Value   = 0
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita campos de edicao em Page2
    * par_lHabilitar = .T.: INCLUIR/ALTERAR | .F.: VISUALIZAR
    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPagina, loc_lReadOnly

        TRY
            loc_oPagina   = THIS.pgf_4c_Paginas.Page2
            loc_lReadOnly = !par_lHabilitar

            loc_oPagina.cbo_4c_CboMes.Enabled   = par_lHabilitar
            loc_oPagina.cbo_4c_CboAno.Enabled   = par_lHabilitar
            loc_oPagina.txt_4c_CodCli.ReadOnly  = loc_lReadOnly
            loc_oPagina.txt_4c_DesCli.ReadOnly  = loc_lReadOnly
            loc_oPagina.txt_4c_CodCgo.ReadOnly  = loc_lReadOnly
            loc_oPagina.txt_4c_Hora01.ReadOnly  = loc_lReadOnly
            loc_oPagina.txt_4c_Hora02.ReadOnly  = loc_lReadOnly
            loc_oPagina.txt_4c_Hora03.ReadOnly  = loc_lReadOnly
            loc_oPagina.txt_4c_Hora04.ReadOnly  = loc_lReadOnly
            loc_oPagina.chk_4c_ChkDom.Enabled  = par_lHabilitar
            loc_oPagina.chk_4c_ChkSeg.Enabled  = par_lHabilitar
            loc_oPagina.chk_4c_ChkTer.Enabled  = par_lHabilitar
            loc_oPagina.chk_4c_ChkQua.Enabled  = par_lHabilitar
            loc_oPagina.chk_4c_ChkQui.Enabled  = par_lHabilitar
            loc_oPagina.chk_4c_ChkSex.Enabled  = par_lHabilitar
            loc_oPagina.chk_4c_ChkSab.Enabled  = par_lHabilitar
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Inicia inclusao de novo registro
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.LimparCampos()
        THIS.HabilitarCampos(.T.)
        THIS.AjustarBotoesPorModo()
        THIS.pgf_4c_Paginas.ActivePage = 2
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Abre registro selecionado em modo leitura
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cPkChave
        loc_cPkChave = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
        ENDIF

        IF EMPTY(loc_cPkChave)
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
            THIS.this_cModoAtual = "VISUALIZAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.F.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Abre registro selecionado em modo edicao
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cPkChave
        loc_cPkChave = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
        ENDIF

        IF EMPTY(loc_cPkChave)
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
            THIS.this_oBusinessObject.EditarRegistro()
            THIS.this_cModoAtual = "ALTERAR"
            THIS.BOParaForm()
            THIS.HabilitarCampos(.T.)
            THIS.AjustarBotoesPorModo()
            THIS.pgf_4c_Paginas.ActivePage = 2
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cPkChave
        loc_cPkChave = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
        ENDIF

        IF EMPTY(loc_cPkChave)
            MsgAviso("Selecione um registro na lista.")
            RETURN
        ENDIF

        IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
            IF THIS.this_oBusinessObject.Excluir()
                MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Filtra lista por funcionario, cargo ou referencia
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cBusca, loc_cFiltro, loc_oGrid
        loc_cBusca  = ""
        loc_cFiltro = ""

        TRY
            loc_cBusca = INPUTBOX("Buscar por funcion" + CHR(225) + ;
                                  "rio, cargo ou refer" + CHR(234) + "ncia (AAAAMM):", ;
                                  "Buscar Jornadas", "")

            IF VARTYPE(loc_cBusca) = "C"
                loc_cBusca = ALLTRIM(CHRTRAN(loc_cBusca, "'", ""))

                IF !EMPTY(loc_cBusca)
                    loc_cFiltro = "(a.iclis LIKE '%" + loc_cBusca + "%'" + ;
                                  " OR a.cargos LIKE '%" + loc_cBusca + "%'" + ;
                                  " OR a.refers LIKE '%" + loc_cBusca + "%'" + ;
                                  " OR b.rclis LIKE '%" + loc_cBusca + "%')"
                ENDIF

                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 14
                    THIS.AtualizarBindingGrid(loc_oGrid)
                    THIS.FormatarGridLista(loc_oGrid)
                    loc_oGrid.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.this_oBusinessObject.CancelarEdicao()
        THIS.this_cModoAtual = "LISTA"
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Salva o registro atual (Confirmar em Page2)
    * Chama FormParaBO() + BO.Salvar() (que ja valida internamente)
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        TRY
            IF THIS.FormParaBO()
                IF THIS.this_oBusinessObject.Salvar()
                    MsgInfo("Registro salvo com sucesso!", "Sucesso")
                    THIS.this_cModoAtual = "LISTA"
                    THIS.AlternarPagina(1)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.BtnSalvarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnCopiarMesClick - Prepara painel de copia de jornada para outro mes
    * Equivale ao Command1.Click na Page.Lista do legado
    * Captura ano/mes do registro selecionado e exibe cnt_4c_CopiaMes
    *==========================================================================
    PROCEDURE BtnCopiarMesClick()
        LOCAL loc_cRefers, loc_cIclis, loc_cCargos, loc_cPkChave, loc_oPagina
        loc_cRefers  = ""
        loc_cIclis   = ""
        loc_cCargos  = ""
        loc_cPkChave = ""

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            SELECT cursor_4c_Dados
            loc_cRefers  = ALLTRIM(cursor_4c_Dados.refers)
            loc_cIclis   = ALLTRIM(cursor_4c_Dados.iclis)
            loc_cCargos  = ALLTRIM(cursor_4c_Dados.cargos)
            loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
        ENDIF

        IF EMPTY(loc_cRefers)
            MsgAviso("Selecione um registro na lista para copiar.")
            RETURN
        ENDIF

        *-- Carregar BO com o registro selecionado (CopiarParaMes precisa dos dados do BO)
        IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
            RETURN
        ENDIF

        THIS.this_cAnoAtual = SUBSTR(loc_cRefers, 1, 4)
        THIS.this_cMesAtual = SUBSTR(loc_cRefers, 5, 2)

        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        THIS.this_oBusinessObject.BuscarMesesDisponiveis(loc_cIclis, loc_cCargos)
        THIS.PopularCombosCopiaMes()

        loc_oPagina.cmd_4c_CopiarMes.Enabled = .F.
        loc_oPagina.cnt_4c_Saida.Enabled     = .F.
        loc_oPagina.cnt_4c_Botoes.Enabled    = .F.
        loc_oPagina.grd_4c_Lista.Enabled     = .F.
        loc_oPagina.cnt_4c_CopiaMes.Visible  = .T.
        loc_oPagina.cnt_4c_CopiaMes.SetFocus()
    ENDPROC

    *==========================================================================
    * Lookup Cargo (txt_4c_CodCgo -> SigCdCrg)
    *==========================================================================
    PROCEDURE AbrirLookupCargo()
        LOCAL loc_oPagina, loc_cValor, loc_oForm
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CodCgo.Value)

        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCrg", "cursor_4c_Busca", "ccargs", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Cargos")

            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
                ELSE
                    IF !loc_oForm.this_lAchouRegistro
                    loc_oForm.mAddColuna("ccargs", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou
                        loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Busca")
                    USE IN cursor_4c_Busca
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.AbrirLookupCargo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarCodCgo(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN
        ENDIF
        LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_CodCgo.Value))

        IF EMPTY(loc_cValor)
            RETURN
        ENDIF

        TRY
            loc_cSQL    = "SELECT ccargs FROM SigCdCrg WHERE ccargs = " + EscaparSQL(loc_cValor)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCgo")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCgo") > 0
                loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_ValCgo.ccargs)
            ELSE
                MsgAviso("Cargo n" + CHR(227) + "o encontrado.")
                loc_oPagina.txt_4c_CodCgo.Value = ""
                THIS.AbrirLookupCargo()
            ENDIF

            IF USED("cursor_4c_ValCgo")
                USE IN cursor_4c_ValCgo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.ValidarCodCgo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValCgo")
                USE IN cursor_4c_ValCgo
            ENDIF
        ENDTRY
    ENDPROC

    PROCEDURE TeclaLookupCodCgo(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupCargo()
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookup Funcionario por codigo (txt_4c_CodCli -> SigCdCli.iclis)
    *==========================================================================
    PROCEDURE AbrirLookupFuncionario()
        LOCAL loc_oPagina, loc_cValor, loc_oForm
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CodCli.Value)

        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "iclis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Funcion" + CHR(225) + "rios")

            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
                    loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
                ELSE
                    IF !loc_oForm.this_lAchouRegistro
                    loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oForm.mAddColuna("rclis", "", "Nome")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou
                        loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
                        loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.AbrirLookupFuncionario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarCodCli(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN
        ENDIF
        LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_CodCli.Value))

        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_DesCli.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCli")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCli") > 0
                loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_ValCli.iclis)
                loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_ValCli.rclis)
            ELSE
                MsgAviso("Funcion" + CHR(225) + "rio n" + CHR(227) + "o encontrado.")
                loc_oPagina.txt_4c_CodCli.Value = ""
                loc_oPagina.txt_4c_DesCli.Value = ""
                THIS.AbrirLookupFuncionario()
            ENDIF

            IF USED("cursor_4c_ValCli")
                USE IN cursor_4c_ValCli
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.ValidarCodCli:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValCli")
                USE IN cursor_4c_ValCli
            ENDIF
        ENDTRY
    ENDPROC

    PROCEDURE TeclaLookupCodCli(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupFuncionario()
        ENDIF
    ENDPROC

    *==========================================================================
    * Lookup Funcionario por nome (txt_4c_DesCli -> SigCdCli.rclis)
    *==========================================================================
    PROCEDURE AbrirLookupFuncionarioPorNome()
        LOCAL loc_oPagina, loc_cValor, loc_oForm
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DesCli.Value)

        TRY
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "rclis", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Funcion" + CHR(225) + "rios")

            IF VARTYPE(loc_oForm) = "O"
                IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                    loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
                    loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
                ELSE
                    IF !loc_oForm.this_lAchouRegistro
                    loc_oForm.mAddColuna("rclis", "", "Nome")
                    loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
                    loc_oForm.Show()
                    IF loc_oForm.this_lSelecionou
                        loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
                        loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
                    ENDIF
                    ENDIF
                ENDIF
                IF USED("cursor_4c_BuscaCli")
                    USE IN cursor_4c_BuscaCli
                ENDIF
                loc_oForm.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.AbrirLookupFuncionarioPorNome:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    PROCEDURE ValidarDesCli(par_nKeyCode, par_nShiftAltCtrl)
        IF !INLIST(par_nKeyCode, 13, 9)
            RETURN
        ENDIF
        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN
        ENDIF
        LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DesCli.Value)

        IF EMPTY(loc_cValor)
            loc_oPagina.txt_4c_CodCli.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL    = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE rclis LIKE " + ;
                          EscaparSQL(loc_cValor + "%") + " ORDER BY rclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValDes")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValDes") > 0
                loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_ValDes.iclis)
                loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_ValDes.rclis)
            ELSE
                MsgAviso("Funcion" + CHR(225) + "rio n" + CHR(227) + "o encontrado.")
                loc_oPagina.txt_4c_DesCli.Value = ""
                loc_oPagina.txt_4c_CodCli.Value = ""
                THIS.AbrirLookupFuncionarioPorNome()
            ENDIF

            IF USED("cursor_4c_ValDes")
                USE IN cursor_4c_ValDes
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.ValidarDesCli:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValDes")
                USE IN cursor_4c_ValDes
            ENDIF
        ENDTRY
    ENDPROC

    PROCEDURE TeclaLookupDesCli(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 115, 116)
            THIS.AbrirLookupFuncionarioPorNome()
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
    * Necessario pois AddObject() cria controles com Visible=.F. por padrao
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oObjeto, loc_p, loc_cNome

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- Containers com visibilidade gerenciada externamente: recursao nos filhos mas
                *-- nao forcamos Visible=.T. neste nivel (evita sobrescrever estado gerenciado)
                IF INLIST(loc_cNome, "CNT_4C_COPIAMES", "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_p))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * PopularCombosCopiaMes - Popula combos De/Para a partir de cursor_4c_Meses
    * Cursor deve ser criado por JrnBO.BuscarMesesDisponiveis antes de chamar
    *==========================================================================
    PROTECTED PROCEDURE PopularCombosCopiaMes()
        LOCAL loc_oCnt, loc_cMesCombo, loc_cMesRef, loc_cNomeMes
        loc_oCnt      = THIS.pgf_4c_Paginas.Page1.cnt_4c_CopiaMes
        loc_cMesCombo = ""
        loc_cNomeMes  = ""

        TRY
            IF USED("cursor_4c_Meses") AND RECCOUNT("cursor_4c_Meses") > 0
                SELECT cursor_4c_Meses
                GO TOP
                SCAN
                    loc_cMesRef = SUBSTR(ALLTRIM(refers), 5, 2)
                    DO CASE
                        CASE loc_cMesRef = "01"
                            loc_cNomeMes = "Janeiro"
                        CASE loc_cMesRef = "02"
                            loc_cNomeMes = "Fevereiro"
                        CASE loc_cMesRef = "03"
                            loc_cNomeMes = "Mar" + CHR(231) + "o"
                        CASE loc_cMesRef = "04"
                            loc_cNomeMes = "Abril"
                        CASE loc_cMesRef = "05"
                            loc_cNomeMes = "Maio"
                        CASE loc_cMesRef = "06"
                            loc_cNomeMes = "Junho"
                        CASE loc_cMesRef = "07"
                            loc_cNomeMes = "Julho"
                        CASE loc_cMesRef = "08"
                            loc_cNomeMes = "Agosto"
                        CASE loc_cMesRef = "09"
                            loc_cNomeMes = "Setembro"
                        CASE loc_cMesRef = "10"
                            loc_cNomeMes = "Outubro"
                        CASE loc_cMesRef = "11"
                            loc_cNomeMes = "Novembro"
                        CASE loc_cMesRef = "12"
                            loc_cNomeMes = "Dezembro"
                        OTHERWISE
                            loc_cNomeMes = "M" + CHR(234) + "s " + loc_cMesRef
                    ENDCASE
                    IF !EMPTY(loc_cMesCombo)
                        loc_cMesCombo = loc_cMesCombo + ","
                    ENDIF
                    loc_cMesCombo = loc_cMesCombo + loc_cNomeMes + "," + loc_cMesRef
                ENDSCAN
            ENDIF

            loc_oCnt.cbo_4c_De.RowSource   = loc_cMesCombo
            loc_oCnt.cbo_4c_Para.RowSource = loc_cMesCombo

            *-- Preselecionar "De" com o mes atual (mes de origem do registro)
            IF !EMPTY(THIS.this_cMesAtual)
                loc_oCnt.cbo_4c_De.Value = THIS.this_cMesAtual
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.PopularCombosCopiaMes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CopiaMesCancelarClick - Fecha painel CopiaMes e reabilita controles da lista
    * Equivale ao Command1.Click de cntCopiaMes no legado
    *==========================================================================
    PROCEDURE CopiaMesCancelarClick()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        TRY
            loc_oPagina.cnt_4c_CopiaMes.Visible  = .F.
            loc_oPagina.cmd_4c_CopiarMes.Enabled = .T.
            loc_oPagina.cnt_4c_Saida.Enabled     = .T.
            loc_oPagina.cnt_4c_Botoes.Enabled    = .T.
            loc_oPagina.grd_4c_Lista.Enabled     = .T.
            loc_oPagina.grd_4c_Lista.SetFocus()
            loc_oPagina.grd_4c_Lista.Refresh()
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.CopiaMesCancelarClick:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CopiaMesConfirmarClick - Executa copia da jornada para o mes selecionado
    * Equivale ao Command2.Click de cntCopiaMes no legado
    * Usa JrnBO.CopiarParaMes(ano, mes) com o registro carregado em BtnCopiarMesClick
    *==========================================================================
    PROCEDURE CopiaMesConfirmarClick()
        LOCAL loc_oPagina, loc_cMesPara, loc_cRefsDest
        loc_oPagina  = THIS.pgf_4c_Paginas.Page1
        loc_cMesPara = ALLTRIM(NVL(loc_oPagina.cnt_4c_CopiaMes.cbo_4c_Para.Value, ""))

        IF EMPTY(loc_cMesPara)
            MsgAviso("Selecione o m" + CHR(234) + "s destino.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_cRefsDest = THIS.this_cAnoAtual + loc_cMesPara

        IF loc_cRefsDest == THIS.this_cAnoAtual + THIS.this_cMesAtual
            MsgErro("O m" + CHR(234) + "s destino " + CHR(233) + " igual ao de origem.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        IF MsgConfirma("Confirma c" + CHR(243) + "pia da jornada para " + ;
                       SUBSTR(loc_cRefsDest, 5, 2) + "/" + SUBSTR(loc_cRefsDest, 1, 4) + "?", ;
                       "Copiar Jornada")
            IF THIS.this_oBusinessObject.CopiarParaMes(THIS.this_cAnoAtual, loc_cMesPara)
                MsgInfo("Jornada copiada com sucesso!", "Sucesso")
                THIS.CopiaMesCancelarClick()
                THIS.CarregarLista()
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta habilitacao dos botoes conforme this_cModoAtual
    * LISTA    : sem efeito (Page1 visivel)
    * INCLUIR  : Confirmar=habilitado, Cancelar=habilitado
    * ALTERAR  : Confirmar=habilitado, Cancelar=habilitado
    * VISUALIZAR: Confirmar=desabilitado, Cancelar=habilitado
    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPagina, loc_lEdicao
        loc_oPagina = THIS.pgf_4c_Paginas.Page2
        loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

        TRY
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
            loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em FormJrn.AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera recursos do formulario
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Meses")
            USE IN cursor_4c_Meses
        ENDIF
        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\JrnBO.prg):
*==============================================================================
* JrnBO.prg - Business Object para Cadastro de Jornadas (SigCdJrn)
* Herda de BusinessBase
* Tabela: SigCdJrn
* PK: pkchave (composto: refers + cargos_padded + iclis_padded)
*==============================================================================

DEFINE CLASS JrnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdJrn
    *--------------------------------------------------------------------------

    *-- Chave primaria composta (calculada)
    this_cPkChave    = ""  && pkchave  char - refers + cargos(0pad) + iclis(0pad)

    *-- Campos de identificacao do registro
    this_cRefers     = ""  && refers   char(6)  - periodo referencia (YYYYMM)
    this_cIclis      = ""  && iclis    char     - codigo do funcionario (FK SigCdCli)
    this_cCargos     = ""  && cargos   char     - codigo do cargo (FK SigCdCrg.ccargs)

    *-- Campo dias (string 7 chars: dom/seg/ter/qua/qui/sex/sab = 'X' ou ' ')
    this_cDias       = "       "  && dias  char(7)

    *-- Horarios (formato HH:MM)
    this_cHora01     = ""  && hora01  char(5) - inicio
    this_cHora02     = ""  && hora02  char(5) - inicio intervalo
    this_cHora03     = ""  && hora03  char(5) - fim intervalo
    this_cHora04     = ""  && hora04  char(5) - fim

    *-- Flags de dias da semana (computados de this_cDias)
    this_lDom        = .F.  && Domingo    (posicao 1 de dias)
    this_lSeg        = .F.  && Segunda    (posicao 2 de dias)
    this_lTer        = .F.  && Terca      (posicao 3 de dias)
    this_lQua        = .F.  && Quarta     (posicao 4 de dias)
    this_lQui        = .F.  && Quinta     (posicao 5 de dias)
    this_lSex        = .F.  && Sexta      (posicao 6 de dias)
    this_lSab        = .F.  && Sabado     (posicao 7 de dias)

    *-- Auditoria de criacao
    this_dDatas      = {}   && datas   datetime - data/hora de inclusao
    this_cUsuars     = ""   && usuars  char     - usuario que incluiu

    *-- Auditoria de alteracao
    this_dDtalts     = {}   && dtalts  datetime - data/hora da ultima alteracao
    this_cUsualts    = ""   && usualts char     - usuario da ultima alteracao

    *-- Descricao do funcionario (calculada via JOIN com SigCdCli)
    this_cDescri     = ""   && descri  char - rclis do funcionario (nao eh campo fisico)

    *--------------------------------------------------------------------------
    * Configuracao da classe
    *--------------------------------------------------------------------------

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdJrn"
        THIS.this_cCampoChave = "pkchave"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CalcularPkChave - constroi a PK composta a partir dos campos
    * refers(6) + cargos(substituindo espacos por "0") + iclis(idem)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CalcularPkChave()
        LOCAL loc_cPk
        loc_cPk = ALLTRIM(THIS.this_cRefers) + ;
                  STRTRAN(THIS.this_cCargos, " ", "0") + ;
                  STRTRAN(THIS.this_cIclis,  " ", "0")
        RETURN loc_cPk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConstruirDias - constroi string dias (7 chars) a partir dos flags logicos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConstruirDias()
        LOCAL loc_cDias
        loc_cDias = IIF(THIS.this_lDom, "X", " ") + ;
                    IIF(THIS.this_lSeg, "X", " ") + ;
                    IIF(THIS.this_lTer, "X", " ") + ;
                    IIF(THIS.this_lQua, "X", " ") + ;
                    IIF(THIS.this_lQui, "X", " ") + ;
                    IIF(THIS.this_lSex, "X", " ") + ;
                    IIF(THIS.this_lSab, "X", " ")
        RETURN loc_cDias
    ENDFUNC

    *--------------------------------------------------------------------------
    * ParsearDias - converte string dias para flags logicos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ParsearDias(par_cDias)
        LOCAL loc_cStr
        loc_cStr = PADR(NVL(par_cDias, "       "), 7)
        THIS.this_lDom = (SUBSTR(loc_cStr, 1, 1) == "X")
        THIS.this_lSeg = (SUBSTR(loc_cStr, 2, 1) == "X")
        THIS.this_lTer = (SUBSTR(loc_cStr, 3, 1) == "X")
        THIS.this_lQua = (SUBSTR(loc_cStr, 4, 1) == "X")
        THIS.this_lQui = (SUBSTR(loc_cStr, 5, 1) == "X")
        THIS.this_lSex = (SUBSTR(loc_cStr, 6, 1) == "X")
        THIS.this_lSab = (SUBSTR(loc_cStr, 7, 1) == "X")
        THIS.this_cDias = loc_cStr
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChave   = TratarNulo(pkchave, "C")
            THIS.this_cRefers    = TratarNulo(refers,  "C")
            THIS.this_cIclis     = TratarNulo(iclis,   "C")
            THIS.this_cCargos    = TratarNulo(cargos,  "C")
            THIS.this_cHora01    = TratarNulo(hora01,  "C")
            THIS.this_cHora02    = TratarNulo(hora02,  "C")
            THIS.this_cHora03    = TratarNulo(hora03,  "C")
            THIS.this_cHora04    = TratarNulo(hora04,  "C")
            THIS.this_dDatas     = TratarNulo(datas,   "D")
            THIS.this_cUsuars    = TratarNulo(usuars,  "C")
            THIS.this_dDtalts    = TratarNulo(dtalts,  "D")
            THIS.this_cUsualts   = TratarNulo(usualts, "C")
            THIS.ParsearDias(TratarNulo(dias, "C"))
            *-- descri eh calculado via JOIN - carrega se existir no cursor
            IF TYPE("descri") != "U"
                THIS.this_cDescri = TratarNulo(descri, "C")
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT geral com JOIN para descricao do funcionario
    * par_cFiltro: condicao WHERE adicional (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.pkchave, a.refers, a.iclis, a.cargos," + ;
                       " a.dias, a.hora01, a.hora02, a.hora03, a.hora04," + ;
                       " a.datas, a.usuars, a.dtalts, a.usualts," + ;
                       " ISNULL(b.rclis, '') AS descri," + ;
                       " SUBSTRING(a.dias,1,1) AS cDom," + ;
                       " CASE WHEN SUBSTRING(a.dias,1,1)='X' THEN 1 ELSE 0 END AS dom," + ;
                       " SUBSTRING(a.dias,2,1) AS cSeg," + ;
                       " CASE WHEN SUBSTRING(a.dias,2,1)='X' THEN 1 ELSE 0 END AS seg," + ;
                       " SUBSTRING(a.dias,3,1) AS cTer," + ;
                       " CASE WHEN SUBSTRING(a.dias,3,1)='X' THEN 1 ELSE 0 END AS ter," + ;
                       " SUBSTRING(a.dias,4,1) AS cQua," + ;
                       " CASE WHEN SUBSTRING(a.dias,4,1)='X' THEN 1 ELSE 0 END AS qua," + ;
                       " SUBSTRING(a.dias,5,1) AS cQui," + ;
                       " CASE WHEN SUBSTRING(a.dias,5,1)='X' THEN 1 ELSE 0 END AS qui," + ;
                       " SUBSTRING(a.dias,6,1) AS cSex," + ;
                       " CASE WHEN SUBSTRING(a.dias,6,1)='X' THEN 1 ELSE 0 END AS sex," + ;
                       " SUBSTRING(a.dias,7,1) AS cSab," + ;
                       " CASE WHEN SUBSTRING(a.dias,7,1)='X' THEN 1 ELSE 0 END AS sab" + ;
                       " FROM SigCdJrn a" + ;
                       " LEFT JOIN SigCdCli b ON b.iclis = a.iclis" + ;
                       loc_cWhere + ;
                       " ORDER BY a.pkchave"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar jornadas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - carrega registro pelo pkchave
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChave)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.pkchave, a.refers, a.iclis, a.cargos," + ;
                       " a.dias, a.hora01, a.hora02, a.hora03, a.hora04," + ;
                       " a.datas, a.usuars, a.dtalts, a.usualts," + ;
                       " ISNULL(b.rclis, '') AS descri" + ;
                       " FROM SigCdJrn a" + ;
                       " LEFT JOIN SigCdCli b ON b.iclis = a.iclis" + ;
                       " WHERE a.pkchave = " + EscaparSQL(par_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                IF loc_nResult <= 0
                    MsgErro("Erro ao carregar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdJrn
    * Constroi pkchave composto e registra auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cPkChave, loc_cDias
        loc_lSucesso = .F.

        TRY
            loc_cPkChave = THIS.CalcularPkChave()
            loc_cDias    = THIS.ConstruirDias()

            loc_cSQL = "INSERT INTO SigCdJrn" + ;
                       " (pkchave, refers, iclis, cargos, dias," + ;
                       "  hora01, hora02, hora03, hora04," + ;
                       "  datas, usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cPkChave) + ", " + ;
                       EscaparSQL(THIS.this_cRefers) + ", " + ;
                       EscaparSQL(THIS.this_cIclis) + ", " + ;
                       EscaparSQL(THIS.this_cCargos) + ", " + ;
                       EscaparSQL(loc_cDias) + ", " + ;
                       EscaparSQL(THIS.this_cHora01) + ", " + ;
                       EscaparSQL(THIS.this_cHora02) + ", " + ;
                       EscaparSQL(THIS.this_cHora03) + ", " + ;
                       EscaparSQL(THIS.this_cHora04) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.this_cPkChave = loc_cPkChave
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao incluir jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdJrn
    * Altera apenas: dias, refers, dtalts, usualts (conforme logica original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDias
        loc_lSucesso = .F.

        TRY
            loc_cDias = THIS.ConstruirDias()

            loc_cSQL = "UPDATE SigCdJrn SET" + ;
                       " refers  = " + EscaparSQL(THIS.this_cRefers) + "," + ;
                       " dias    = " + EscaparSQL(loc_cDias) + "," + ;
                       " hora01  = " + EscaparSQL(THIS.this_cHora01) + "," + ;
                       " hora02  = " + EscaparSQL(THIS.this_cHora02) + "," + ;
                       " hora03  = " + EscaparSQL(THIS.this_cHora03) + "," + ;
                       " hora04  = " + EscaparSQL(THIS.this_cHora04) + "," + ;
                       " dtalts  = GETDATE()," + ;
                       " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao alterar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdJrn
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdJrn" + ;
                       " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarParaMes - copia a jornada do registro atual para outro mes/ano
    * par_cAno:  ano destino (4 chars, ex: "2025")
    * par_cMes:  mes destino (2 chars, ex: "03")
    * Retorna .T. se copiou com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CopiarParaMes(par_cAno, par_cMes)
        LOCAL loc_cNovoRefers, loc_cNovoPk, loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cAno)) OR EMPTY(ALLTRIM(par_cMes))
                MsgErro("Ano e m" + CHR(234) + "s s" + CHR(227) + "o obrigat" + ;
                        CHR(243) + "rios para copiar jornada.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ELSE

            loc_cNovoRefers = ALLTRIM(par_cAno) + ALLTRIM(par_cMes)
            loc_cNovoPk     = loc_cNovoRefers + ;
                              STRTRAN(THIS.this_cCargos, " ", "0") + ;
                              STRTRAN(THIS.this_cIclis,  " ", "0")

            *-- Verifica se ja existe registro para o mes destino
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdJrn WHERE pkchave = " + ;
                       EscaparSQL(loc_cNovoPk)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCopia") > 0
                SELECT cursor_4c_ChkCopia
                IF cursor_4c_ChkCopia.qtd > 0
                    *-- Registro existente: UPDATE
                    loc_cSQL = "UPDATE SigCdJrn SET" + ;
                               " refers  = " + EscaparSQL(loc_cNovoRefers) + "," + ;
                               " dias    = " + EscaparSQL(THIS.ConstruirDias()) + "," + ;
                               " hora01  = " + EscaparSQL(THIS.this_cHora01) + "," + ;
                               " hora02  = " + EscaparSQL(THIS.this_cHora02) + "," + ;
                               " hora03  = " + EscaparSQL(THIS.this_cHora03) + "," + ;
                               " hora04  = " + EscaparSQL(THIS.this_cHora04) + "," + ;
                               " dtalts  = GETDATE()," + ;
                               " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                               " WHERE pkchave = " + EscaparSQL(loc_cNovoPk)
                ELSE
                    *-- Registro novo: INSERT
                    loc_cSQL = "INSERT INTO SigCdJrn" + ;
                               " (pkchave, refers, iclis, cargos, dias," + ;
                               "  hora01, hora02, hora03, hora04," + ;
                               "  datas, usuars)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cNovoPk) + ", " + ;
                               EscaparSQL(loc_cNovoRefers) + ", " + ;
                               EscaparSQL(THIS.this_cIclis) + ", " + ;
                               EscaparSQL(THIS.this_cCargos) + ", " + ;
                               EscaparSQL(THIS.ConstruirDias()) + ", " + ;
                               EscaparSQL(THIS.this_cHora01) + ", " + ;
                               EscaparSQL(THIS.this_cHora02) + ", " + ;
                               EscaparSQL(THIS.this_cHora03) + ", " + ;
                               EscaparSQL(THIS.this_cHora04) + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ")"
                ENDIF
                USE IN cursor_4c_ChkCopia
            ELSE
                MsgErro("Erro ao verificar registro destino:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ChkCopia")
                    USE IN cursor_4c_ChkCopia
                ENDIF
                loc_lSucesso = .F.
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao copiar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
            ENDIF && ELSE validacao
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.CopiarParaMes:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCopia")
                USE IN cursor_4c_ChkCopia
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMesesDisponiveis - retorna cursor com meses existentes para
    * funcionario/cargo especificados (para o painel Copiar Mes)
    * par_cIclis:  codigo do funcionario (pode ser vazio = todos)
    * par_cCargos: codigo do cargo (pode ser vazio = todos)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarMesesDisponiveis(par_cIclis, par_cCargos)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Meses")
                USE IN cursor_4c_Meses
            ENDIF

            loc_cWhere = " WHERE (iclis = " + EscaparSQL(par_cIclis) + ;
                         " OR " + EscaparSQL(par_cIclis) + " = '')" + ;
                         " AND (cargos = " + EscaparSQL(par_cCargos) + ;
                         " OR " + EscaparSQL(par_cCargos) + " = '')"

            loc_cSQL = "SELECT refers FROM SigCdJrn" + ;
                       loc_cWhere + ;
                       " ORDER BY refers ASC"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Meses")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar meses:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.BuscarMesesDisponiveis:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cRefers))
            MsgErro("Refer" + CHR(234) + "ncia (Ano/M" + CHR(234) + "s) " + ;
                    CHR(233) + " obrigat" + CHR(243) + "ria.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cIclis)) AND EMPTY(ALLTRIM(THIS.this_cCargos))
            MsgAviso("Informe o Funcion" + CHR(225) + "rio ou o Cargo.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            IF EMPTY(ALLTRIM(THIS.this_cHora01)) OR EMPTY(ALLTRIM(THIS.this_cHora02)) OR ;
               EMPTY(ALLTRIM(THIS.this_cHora03)) OR EMPTY(ALLTRIM(THIS.this_cHora04))
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o!! Todos os hor" + CHR(225) + ;
                        "rios devem ser preenchidos.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - limpeza de cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Meses")
            USE IN cursor_4c_Meses
        ENDIF
        IF USED("cursor_4c_ChkCopia")
            USE IN cursor_4c_ChkCopia
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

