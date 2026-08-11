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
[2026-08-08 21:22:22] [INFO] Config FPW: (nao fornecido)
[2026-08-08 21:22:22] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 21:22:22] [INFO] Timeout: 300 segundos
[2026-08-08 21:22:22] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zeimyv1b.prg
[2026-08-08 21:22:22] [INFO] Conteudo do wrapper:
[2026-08-08 21:22:22] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
QUIT

[2026-08-08 21:22:22] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zeimyv1b.prg
[2026-08-08 21:22:22] [INFO] VFP output esperado em: C:\4c\tasks\task445\vfp_output.txt
[2026-08-08 21:22:22] [INFO] Executando Visual FoxPro 9...
[2026-08-08 21:22:22] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zeimyv1b.prg
[2026-08-08 21:22:22] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zeimyv1b.prg
[2026-08-08 21:22:22] [INFO] Timeout configurado: 300 segundos
[2026-08-08 21:27:22] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 10720)...
[2026-08-08 21:27:24] [INFO] VFP9 finalizado em 302.0861692 segundos
[2026-08-08 21:27:24] [INFO] Exit Code: 4
[2026-08-08 21:27:24] [INFO] 
[2026-08-08 21:27:24] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 21:27:24] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_zeimyv1b.prg
[2026-08-08 21:27:24] [INFO] 
[2026-08-08 21:27:24] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 21:27:24] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 21:27:24] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 21:27:24] [INFO] * Parameters: 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
[2026-08-08 21:27:24] [INFO] 
[2026-08-08 21:27:24] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 21:27:24] [INFO] SET SAFETY OFF
[2026-08-08 21:27:24] [INFO] SET RESOURCE OFF
[2026-08-08 21:27:24] [INFO] SET TALK OFF
[2026-08-08 21:27:24] [INFO] SET NOTIFY OFF
[2026-08-08 21:27:24] [INFO] SYS(2335, 0)
[2026-08-08 21:27:24] [INFO] 
[2026-08-08 21:27:24] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
[2026-08-08 21:27:24] [INFO] QUIT
[2026-08-08 21:27:24] [INFO] 
[2026-08-08 21:27:24] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 21:27:24] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-08 21:49:17] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-08 21:49:17] [INFO] Config FPW: (nao fornecido)
[2026-08-08 21:49:17] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 21:49:17] [INFO] Timeout: 300 segundos
[2026-08-08 21:49:17] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5chvwxcl.prg
[2026-08-08 21:49:17] [INFO] Conteudo do wrapper:
[2026-08-08 21:49:17] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
QUIT

[2026-08-08 21:49:17] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5chvwxcl.prg
[2026-08-08 21:49:17] [INFO] VFP output esperado em: C:\4c\tasks\task445\vfp_output.txt
[2026-08-08 21:49:17] [INFO] Executando Visual FoxPro 9...
[2026-08-08 21:49:17] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5chvwxcl.prg
[2026-08-08 21:49:17] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5chvwxcl.prg
[2026-08-08 21:49:17] [INFO] Timeout configurado: 300 segundos
[2026-08-08 21:54:17] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 14980)...
[2026-08-08 21:54:19] [INFO] VFP9 finalizado em 302.0618122 segundos
[2026-08-08 21:54:19] [INFO] Exit Code: 4
[2026-08-08 21:54:19] [INFO] 
[2026-08-08 21:54:19] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 21:54:19] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5chvwxcl.prg
[2026-08-08 21:54:19] [INFO] 
[2026-08-08 21:54:19] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 21:54:19] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 21:54:19] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 21:54:19] [INFO] * Parameters: 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
[2026-08-08 21:54:19] [INFO] 
[2026-08-08 21:54:19] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 21:54:19] [INFO] SET SAFETY OFF
[2026-08-08 21:54:19] [INFO] SET RESOURCE OFF
[2026-08-08 21:54:19] [INFO] SET TALK OFF
[2026-08-08 21:54:19] [INFO] SET NOTIFY OFF
[2026-08-08 21:54:19] [INFO] SYS(2335, 0)
[2026-08-08 21:54:19] [INFO] 
[2026-08-08 21:54:19] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
[2026-08-08 21:54:19] [INFO] QUIT
[2026-08-08 21:54:19] [INFO] 
[2026-08-08 21:54:19] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 21:54:19] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-08 21:57:33] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-08 21:57:33] [INFO] Config FPW: (nao fornecido)
[2026-08-08 21:57:33] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 21:57:33] [INFO] Timeout: 300 segundos
[2026-08-08 21:57:33] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hlofgj1d.prg
[2026-08-08 21:57:33] [INFO] Conteudo do wrapper:
[2026-08-08 21:57:33] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
QUIT

[2026-08-08 21:57:33] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hlofgj1d.prg
[2026-08-08 21:57:33] [INFO] VFP output esperado em: C:\4c\tasks\task445\vfp_output.txt
[2026-08-08 21:57:33] [INFO] Executando Visual FoxPro 9...
[2026-08-08 21:57:33] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hlofgj1d.prg
[2026-08-08 21:57:33] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hlofgj1d.prg
[2026-08-08 21:57:33] [INFO] Timeout configurado: 300 segundos
[2026-08-08 22:02:33] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 1884)...
[2026-08-08 22:02:35] [INFO] VFP9 finalizado em 302.0714725 segundos
[2026-08-08 22:02:35] [INFO] Exit Code: 4
[2026-08-08 22:02:35] [INFO] 
[2026-08-08 22:02:35] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 22:02:35] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_hlofgj1d.prg
[2026-08-08 22:02:35] [INFO] 
[2026-08-08 22:02:35] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 22:02:35] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 22:02:35] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 22:02:35] [INFO] * Parameters: 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
[2026-08-08 22:02:35] [INFO] 
[2026-08-08 22:02:35] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 22:02:35] [INFO] SET SAFETY OFF
[2026-08-08 22:02:35] [INFO] SET RESOURCE OFF
[2026-08-08 22:02:35] [INFO] SET TALK OFF
[2026-08-08 22:02:35] [INFO] SET NOTIFY OFF
[2026-08-08 22:02:35] [INFO] SYS(2335, 0)
[2026-08-08 22:02:35] [INFO] 
[2026-08-08 22:02:35] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
[2026-08-08 22:02:35] [INFO] QUIT
[2026-08-08 22:02:35] [INFO] 
[2026-08-08 22:02:35] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 22:02:35] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-08 22:39:17] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-08 22:39:17] [INFO] Config FPW: (nao fornecido)
[2026-08-08 22:39:17] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 22:39:17] [INFO] Timeout: 300 segundos
[2026-08-08 22:39:17] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2trxheak.prg
[2026-08-08 22:39:17] [INFO] Conteudo do wrapper:
[2026-08-08 22:39:17] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
QUIT

[2026-08-08 22:39:17] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2trxheak.prg
[2026-08-08 22:39:17] [INFO] VFP output esperado em: C:\4c\tasks\task445\vfp_output.txt
[2026-08-08 22:39:17] [INFO] Executando Visual FoxPro 9...
[2026-08-08 22:39:17] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2trxheak.prg
[2026-08-08 22:39:17] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2trxheak.prg
[2026-08-08 22:39:17] [INFO] Timeout configurado: 300 segundos
[2026-08-08 22:44:17] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 13616)...
[2026-08-08 22:44:19] [INFO] VFP9 finalizado em 302.1008721 segundos
[2026-08-08 22:44:19] [INFO] Exit Code: 4
[2026-08-08 22:44:19] [INFO] 
[2026-08-08 22:44:19] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-08 22:44:19] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_2trxheak.prg
[2026-08-08 22:44:19] [INFO] 
[2026-08-08 22:44:19] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-08 22:44:19] [INFO] * Auto-generated wrapper for parameters
[2026-08-08 22:44:19] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-08 22:44:19] [INFO] * Parameters: 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
[2026-08-08 22:44:19] [INFO] 
[2026-08-08 22:44:19] [INFO] * Anti-dialog protections for unattended execution
[2026-08-08 22:44:19] [INFO] SET SAFETY OFF
[2026-08-08 22:44:19] [INFO] SET RESOURCE OFF
[2026-08-08 22:44:19] [INFO] SET TALK OFF
[2026-08-08 22:44:19] [INFO] SET NOTIFY OFF
[2026-08-08 22:44:19] [INFO] SYS(2335, 0)
[2026-08-08 22:44:19] [INFO] 
[2026-08-08 22:44:19] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormIBP', 'C:\4c\tasks\task445', 'CRUD'
[2026-08-08 22:44:19] [INFO] QUIT
[2026-08-08 22:44:19] [INFO] 
[2026-08-08 22:44:19] [INFO] === Fim do Wrapper.prg ===
[2026-08-08 22:44:19] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\cadastros\FormIBP.prg):
*==============================================================================
* FormIBP.prg - Formulario de Cadastro IBPT
* Migrado de: SIGCDIBP.SCX (frmcadastro)
* Tabela: SigCdIbp / PK: cidchaves
* FASE 8/8: COMPLETO - todos os metodos implementados
*==============================================================================

DEFINE CLASS FormIBP AS FormBase

    *-- Propriedades visuais (PILAR 1 - UX FIDELITY: exatos do original)
    Height      = 600
    Width       = 1000
    Caption     = "Cadastro do IBPT"
    AutoCenter  = .T.
    ShowWindow  = 1
    WindowType  = 1
    ControlBox  = .F.
    TitleBar    = 0
    Themes      = .F.
    BorderStyle = 2

    *-- Propriedades de estado
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "LISTA"

    *===========================================================================
    * Init - REGRA CRITICA: apenas RETURN DODEFAULT()
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
            THIS.this_oBusinessObject = CREATEOBJECT("IBPBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MostrarErro("Erro ao criar IBPBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "FormIBP.InicializarForm")
            ELSE
                THIS.ConfigurarPageFrame()

                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                THIS.pgf_4c_Paginas.Visible   = .T.
                THIS.pgf_4c_Paginas.ActivePage = 1
                THIS.this_cModoAtual           = "LISTA"

                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inicializar FormIBP:" + CHR(13) + ;
                loException.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loException.LineNo), ;
                "FormIBP.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
    * Top=-29 para esconder abas; controles compensam +29 no Top
    * Background: new_background.jpg (original: ..\framework\imagens\new_background.jpg)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("pgf_4c_Paginas", "PageFrame")

        WITH THIS.pgf_4c_Paginas
            .PageCount = 2
            .Top       = -29
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height + 29
            .Tabs      = .F.
            .Visible   = .T.

            .Page1.Caption   = "Lista"
            .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page1.BackColor = RGB(255, 255, 255)

            .Page2.Caption   = "Dados"
            .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
            .Page2.BackColor = RGB(255, 255, 255)
        ENDWITH

        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaLista - Configura Page1 com Grid e botoes
    * IBPT: cnt_4c_Botoes fica OCULTO/DESABILITADO (Grupo_op.Visible=.F. original)
    * cmd_4c_BtnCarregar eh o botao principal (btncarregar do legado)
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oGrid
        loc_oPagina = THIS.pgf_4c_Paginas.Page1

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Cabecalho (cntSombra no legado)
        *-- Original: cntSombra.Top=1. Com compensacao +29: Top=31
        loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
        WITH loc_oPagina.cnt_4c_Cabecalho
            .Top         = 31
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

        *-- Container Botoes CRUD (Grupo_op no legado)
        *-- ESCONDIDO/DESABILITADO: comportamento original do SIGCDIBP
        *-- Original: Left=544, Top=-1. Com compensacao +29: Top=28
        loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPagina.cnt_4c_Botoes
            .Top         = 28
            .Left        =  542
            .Width       = 385
            .Height      = 85
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .F.
            .Enabled     = .F.

            .AddObject("cmd_4c_Incluir", "CommandButton")
            WITH .cmd_4c_Incluir
                .Caption         = "Incluir"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            =  542
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
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
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
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
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
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
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
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
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
            ENDWITH
        ENDWITH

        *-- Container Saida - padrao canonico (CLAUDE.md Regra #10)
        *-- Left=917, Width=90, cmd_4c_Encerrar Width=75, Caption="Encerrar"
        loc_oPagina.AddObject("cnt_4c_Saida", "Container")
        WITH loc_oPagina.cnt_4c_Saida
            .Top         = 28
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
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
            ENDWITH
        ENDWITH

        *-- Botao Carregar IBPT (btncarregar no legado)
        *-- Original: Top=10 direto no form; +29 de compensacao em Page1 -> Top=39
        *-- Original: Left=475, Width=75, Height=75
        loc_oPagina.AddObject("cmd_4c_BtnCarregar", "CommandButton")
        WITH loc_oPagina.cmd_4c_BtnCarregar
            .Caption         = "Carrega ibpt"
            .Picture         = gc_4c_CaminhoIcones + "Arrowdown.ico"
            .PicturePosition = 13
            .Top             = 39
            .Left            = 475
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
            .MousePointer    = 15
            .WordWrap        = .T.
            .ToolTipText     = "Carregar Cadastro"
            .Visible         = .T.
        ENDWITH

        *-- Grid (Grade no legado)
        *-- Original: Top=133, Left=12, Width=940, Height=458. Com compensacao: Top=162
        *-- Problema 36: RecordSource e ColumnCount FORA do WITH
        loc_oPagina.AddObject("grd_4c_Lista", "Grid")
        loc_oGrid = loc_oPagina.grd_4c_Lista
        loc_oGrid.ColumnCount = 9

        WITH loc_oGrid
            .Top                = 162
            .Left               = 12
            .Width              = 940
            .Height             = 458
            .RowHeight          = 16
            .ForeColor          = RGB(90, 90, 90)
            .BackColor          = RGB(255, 255, 255)
            .GridLineColor      = RGB(238, 238, 238)
            .HighlightBackColor = RGB(255, 255, 255)
            .HighlightForeColor = RGB(15, 41, 104)
            .HighlightStyle     = 2
            .DeleteMark         = .F.
            .RecordMark         = .F.
            .ScrollBars         = 2
            .GridLines          = 3

            .Column1.Width  = 75
            .Column2.Width  = 100
            .Column3.Width  = 75
            .Column4.Width  = 75
            .Column5.Width  = 75
            .Column6.Width  = 75
            .Column7.Width  = 75
            .Column8.Width  = 75
            .Column9.Width  = 75

            .Column1.Header1.Caption = "Estado"
            .Column2.Header1.Caption = "Codigo"
            .Column3.Header1.Caption = "Data Ini"
            .Column4.Header1.Caption = "Data Fim"
            .Column5.Header1.Caption = "Aliq Nac Fed"
            .Column6.Header1.Caption = "Aliq Imp Fed"
            .Column7.Header1.Caption = "Aliq Estadual"
            .Column8.Header1.Caption = "Aliq Municipal"
            .Column9.Header1.Caption = "Versao"

            .Column1.Alignment = 0
            .Column2.Alignment = 0
            .Column3.Alignment = 0
            .Column4.Alignment = 0
            .Column5.Alignment = 2
            .Column6.Alignment = 2
            .Column7.Alignment = 2
            .Column8.Alignment = 2
            .Column9.Alignment = 2
        ENDWITH

        *-- BINDEVENT para botoes (Problema 17: handlers devem ser PUBLIC)
        BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,          "Click", THIS, "BtnEncerrarClick")
        BINDEVENT(loc_oPagina.cmd_4c_BtnCarregar,                    "Click", THIS, "BtnCarregarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,          "Click", THIS, "BtnIncluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,          "Click", THIS, "BtnAlterarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,       "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,          "Click", THIS, "BtnExcluirClick")
        BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,           "Click", THIS, "BtnBuscarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * ConfigurarPaginaDados - Configura Page2 com containers de edicao
    * Campos de dados adicionados nas Fases 5-6
    *===========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina
        loc_oPagina = THIS.pgf_4c_Paginas.Page2

        *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
        loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

        *-- Container Salva/Cancelar (Grupo_Salva no legado)
        *-- Original: Left=819, Top=9. Com compensacao +29: Top=38
        loc_oPagina.AddObject("cnt_4c_Salva", "Container")
        WITH loc_oPagina.cnt_4c_Salva
            .Top         = 38
            .Left        = 842
            .Width       = 160
            .Height      = 85
            .BackStyle   = 0
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
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
            ENDWITH

            .AddObject("cmd_4c_Cancelar", "CommandButton")
            WITH .cmd_4c_Cancelar
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
                .PicturePosition = 13
                .Top             = 5
                .Left            = 80
                .Width           = 75
                .Height          = 75
                .BackColor       = RGB(255,255,255)
                .ForeColor       = RGB(90,90,90)
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .Themes          = .F.
                .SpecialEffect   = 0
                .MousePointer    = 15
                .WordWrap        = .T.
            ENDWITH
        ENDWITH

        *-- Campo UFS (Estado) - char(2)
        loc_oPagina.AddObject("lbl_4c_Ufs", "Label")
        WITH loc_oPagina.lbl_4c_Ufs
            .Caption   = "Estado :"
            .Top       = 138
            .Left      = 10
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ufs", "TextBox")
        WITH loc_oPagina.txt_4c_Ufs
            .Value     = ""
            .Top       = 135
            .Left      = 115
            .Width     = 45
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .MaxLength = 2
            .Visible   = .T.
        ENDWITH

        *-- Campo Codigo - char(10)
        loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
        WITH loc_oPagina.lbl_4c_Codigo
            .Caption   = "C" + CHR(243) + "digo :"
            .Top       = 163
            .Left      = 10
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
        WITH loc_oPagina.txt_4c_Codigo
            .Value     = ""
            .Top       = 160
            .Left      = 115
            .Width     = 120
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .MaxLength = 10
            .Visible   = .T.
        ENDWITH

        *-- Campo Ex - char(3)
        loc_oPagina.AddObject("lbl_4c_Ex", "Label")
        WITH loc_oPagina.lbl_4c_Ex
            .Caption   = "Ex :"
            .Top       = 188
            .Left      = 10
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Ex", "TextBox")
        WITH loc_oPagina.txt_4c_Ex
            .Value     = ""
            .Top       = 185
            .Left      = 115
            .Width     = 45
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .MaxLength = 3
            .Visible   = .T.
        ENDWITH

        *-- Campo Tipo - numeric(3,0)
        loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
        WITH loc_oPagina.lbl_4c_Tipo
            .Caption   = "Tipo :"
            .Top       = 213
            .Left      = 10
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Tipo", "TextBox")
        WITH loc_oPagina.txt_4c_Tipo
            .Value     = 0
            .Top       = 210
            .Left      = 115
            .Width     = 60
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .InputMask = "999"
            .Visible   = .T.
        ENDWITH

        *-- Campo Descricao - text/memo (EditBox)
        loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
        WITH loc_oPagina.lbl_4c_Descricao
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
            .Top       = 238
            .Left      = 10
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("edt_4c_Descricao", "EditBox")
        WITH loc_oPagina.edt_4c_Descricao
            .Value     = ""
            .Top       = 235
            .Left      = 115
            .Width     = 600
            .Height    = 55
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Campo Data Ini - datetime
        loc_oPagina.AddObject("lbl_4c_DatIni", "Label")
        WITH loc_oPagina.lbl_4c_DatIni
            .Caption   = "Data Ini :"
            .Top       = 298
            .Left      = 10
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DatIni", "TextBox")
        WITH loc_oPagina.txt_4c_DatIni
            .Value     = {}
            .Top       = 295
            .Left      = 115
            .Width     = 130
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Campo Data Fim - datetime
        loc_oPagina.AddObject("lbl_4c_DatFin", "Label")
        WITH loc_oPagina.lbl_4c_DatFin
            .Caption   = "Data Fim :"
            .Top       = 323
            .Left      = 10
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_DatFin", "TextBox")
        WITH loc_oPagina.txt_4c_DatFin
            .Value     = {}
            .Top       = 320
            .Left      = 115
            .Width     = 130
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH

        *-- Coluna 2: Aliquotas (nacfederal, impfederal, estadual, municipal)
        loc_oPagina.AddObject("lbl_4c_NacFederal", "Label")
        WITH loc_oPagina.lbl_4c_NacFederal
            .Caption   = "Aliq Nac Fed :"
            .Top       = 138
            .Left      = 360
            .Width     = 105
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_NacFederal", "TextBox")
        WITH loc_oPagina.txt_4c_NacFederal
            .Value     = 0
            .Top       = 135
            .Left      = 470
            .Width     = 80
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .InputMask = "99.99"
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_ImpFederal", "Label")
        WITH loc_oPagina.lbl_4c_ImpFederal
            .Caption   = "Aliq Imp Fed :"
            .Top       = 163
            .Left      = 360
            .Width     = 105
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_ImpFederal", "TextBox")
        WITH loc_oPagina.txt_4c_ImpFederal
            .Value     = 0
            .Top       = 160
            .Left      = 470
            .Width     = 80
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .InputMask = "99.99"
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Estadual", "Label")
        WITH loc_oPagina.lbl_4c_Estadual
            .Caption   = "Aliq Estadual :"
            .Top       = 188
            .Left      = 360
            .Width     = 105
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Estadual", "TextBox")
        WITH loc_oPagina.txt_4c_Estadual
            .Value     = 0
            .Top       = 185
            .Left      = 470
            .Width     = 80
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .InputMask = "99.99"
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Municipal", "Label")
        WITH loc_oPagina.lbl_4c_Municipal
            .Caption   = "Aliq Municipal :"
            .Top       = 213
            .Left      = 360
            .Width     = 105
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Municipal", "TextBox")
        WITH loc_oPagina.txt_4c_Municipal
            .Value     = 0
            .Top       = 210
            .Left      = 470
            .Width     = 80
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .InputMask = "99.99"
            .Visible   = .T.
        ENDWITH

        *-- Coluna 1 (continuacao apos datfin): chave, versao, fonte
        loc_oPagina.AddObject("lbl_4c_Chave", "Label")
        WITH loc_oPagina.lbl_4c_Chave
            .Caption   = "Chave :"
            .Top       = 348
            .Left      = 10
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Chave", "TextBox")
        WITH loc_oPagina.txt_4c_Chave
            .Value     = ""
            .Top       = 345
            .Left      = 115
            .Width     = 120
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .MaxLength = 10
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Versao", "Label")
        WITH loc_oPagina.lbl_4c_Versao
            .Caption   = "Vers" + CHR(227) + "o :"
            .Top       = 373
            .Left      = 10
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Versao", "TextBox")
        WITH loc_oPagina.txt_4c_Versao
            .Value     = ""
            .Top       = 370
            .Left      = 115
            .Width     = 120
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .MaxLength = 10
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("lbl_4c_Fonte", "Label")
        WITH loc_oPagina.lbl_4c_Fonte
            .Caption   = "Fonte :"
            .Top       = 398
            .Left      = 10
            .Width     = 100
            .Height    = 17
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .Alignment = 1
            .Visible   = .T.
        ENDWITH

        loc_oPagina.AddObject("txt_4c_Fonte", "TextBox")
        WITH loc_oPagina.txt_4c_Fonte
            .Value     = ""
            .Top       = 395
            .Left      = 115
            .Width     = 120
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .BackColor = RGB(255, 255, 255)
            .MaxLength = 10
            .Visible   = .T.
        ENDWITH

        *-- BINDEVENT para botoes de Page2
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
        BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")

        THIS.TornarControlesVisiveis(loc_oPagina)
    ENDPROC

    *===========================================================================
    * CarregarLista - Carrega cursor_4c_Dados e vincula ao grid
    *===========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_lResultado, loc_oGrid
        loc_lResultado = .F.

        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                CREATE CURSOR cursor_4c_Dados (cidchaves C(20), ufs C(2), ;
                    codigo C(10), datini T, datfin T, ;
                    nacfederal N(5,2), impfederal N(5,2), ;
                    estadual N(5,2), municipal N(5,2), versao C(10))
                loc_lResultado = .T.
            ELSE
                IF THIS.this_oBusinessObject.Buscar("")
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    *-- Problema 36: RecordSource e ColumnCount FORA do WITH
                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 9

                    *-- Problema 48: ControlSource e Headers APOS RecordSource
                    WITH loc_oGrid
                        .Column1.ControlSource = "cursor_4c_Dados.ufs"
                        .Column2.ControlSource = "cursor_4c_Dados.codigo"
                        .Column3.ControlSource = "cursor_4c_Dados.datini"
                        .Column4.ControlSource = "cursor_4c_Dados.datfin"
                        .Column5.ControlSource = "cursor_4c_Dados.nacfederal"
                        .Column6.ControlSource = "cursor_4c_Dados.impfederal"
                        .Column7.ControlSource = "cursor_4c_Dados.estadual"
                        .Column8.ControlSource = "cursor_4c_Dados.municipal"
                        .Column9.ControlSource = "cursor_4c_Dados.versao"

                        *-- Problema 32: Reconfigurar Headers APOS RecordSource
                        .Column1.Header1.Caption = "Estado"
                        .Column2.Header1.Caption = "Codigo"
                        .Column3.Header1.Caption = "Data Ini"
                        .Column4.Header1.Caption = "Data Fim"
                        .Column5.Header1.Caption = "Aliq Nac Fed"
                        .Column6.Header1.Caption = "Aliq Imp Fed"
                        .Column7.Header1.Caption = "Aliq Estadual"
                        .Column8.Header1.Caption = "Aliq Municipal"
                        .Column9.Header1.Caption = "Versao"

                        .Column1.Width = 75
                        .Column2.Width = 100
                        .Column3.Width = 75
                        .Column4.Width = 75
                        .Column5.Width = 75
                        .Column6.Width = 75
                        .Column7.Width = 75
                        .Column8.Width = 75
                        .Column9.Width = 75

                        .Column1.Alignment = 0
                        .Column2.Alignment = 0
                        .Column3.Alignment = 0
                        .Column4.Alignment = 0
                        .Column5.Alignment = 2
                        .Column6.Alignment = 2
                        .Column7.Alignment = 2
                        .Column8.Alignment = 2
                        .Column9.Alignment = 2
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormIBP.CarregarLista:" + CHR(13) + ;
                loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
    *===========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
                MsgErro("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
                    TRANSFORM(par_nPagina), "FormIBP.AlternarPagina")
            ELSE
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
                IF par_nPagina = 1
                    THIS.CarregarLista()
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormIBP.AlternarPagina:" + CHR(13) + ;
                loException.Message, "Erro")
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
    * BtnCarregarClick - Importa planilha CSV de IBPT via IBPBO.ImportarPlanilha
    * Original: btncarregar.Click -> thisform.ImportaPlan()
    *===========================================================================
    PROCEDURE BtnCarregarClick()
        IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
           (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            RETURN
        ENDIF
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_lResultado = THIS.this_oBusinessObject.ImportarPlanilha()
            IF loc_lResultado
                MsgInfo("Planilha importada com sucesso.", "Aviso")
                THIS.CarregarLista()
            ELSE
                MsgAviso("A Planilha n" + CHR(227) + "o foi importada.", "Aviso")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormIBP.BtnCarregarClick:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnSalvarClick - Salva registro (Page2)
    *===========================================================================
    PROCEDURE BtnSalvarClick()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.FormParaBO()
            IF THIS.this_oBusinessObject.Salvar()
                MsgInfo("Registro salvo com sucesso!", "Sucesso")
                THIS.AlternarPagina(1)
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormIBP.BtnSalvarClick:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnCancelarClick - Cancela edicao e volta para lista (Page2 -> Page1)
    *===========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.AlternarPagina(1)
        THIS.this_cModoAtual = "LISTA"
    ENDPROC

    *===========================================================================
    * FormParaBO - Transfere campos do Form (Page2) para o Business Object
    * Campos: todos os 14 campos da tabela SigCdIbp
    *===========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        THIS.this_oBusinessObject.this_cUfs        = ALLTRIM(loc_oPg2.txt_4c_Ufs.Value)
        THIS.this_oBusinessObject.this_cCodigo     = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
        THIS.this_oBusinessObject.this_cEx         = ALLTRIM(loc_oPg2.txt_4c_Ex.Value)
        THIS.this_oBusinessObject.this_nTipo       = loc_oPg2.txt_4c_Tipo.Value
        THIS.this_oBusinessObject.this_cDescricao  = ALLTRIM(loc_oPg2.edt_4c_Descricao.Value)
        THIS.this_oBusinessObject.this_dDatIni     = loc_oPg2.txt_4c_DatIni.Value
        THIS.this_oBusinessObject.this_dDatFin     = loc_oPg2.txt_4c_DatFin.Value
        THIS.this_oBusinessObject.this_nNacFederal = loc_oPg2.txt_4c_NacFederal.Value
        THIS.this_oBusinessObject.this_nImpFederal = loc_oPg2.txt_4c_ImpFederal.Value
        THIS.this_oBusinessObject.this_nEstadual   = loc_oPg2.txt_4c_Estadual.Value
        THIS.this_oBusinessObject.this_nMunicipal  = loc_oPg2.txt_4c_Municipal.Value
        THIS.this_oBusinessObject.this_cChave      = ALLTRIM(loc_oPg2.txt_4c_Chave.Value)
        THIS.this_oBusinessObject.this_cVersao     = ALLTRIM(loc_oPg2.txt_4c_Versao.Value)
        THIS.this_oBusinessObject.this_cFonte      = ALLTRIM(loc_oPg2.txt_4c_Fonte.Value)
    ENDPROC

    *===========================================================================
    * BOParaForm - Transfere propriedades do Business Object para os campos do Form
    * Campos: todos os 14 campos da tabela SigCdIbp
    *===========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Ufs.Value        = ALLTRIM(THIS.this_oBusinessObject.this_cUfs)
        loc_oPg2.txt_4c_Codigo.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
        loc_oPg2.txt_4c_Ex.Value         = ALLTRIM(THIS.this_oBusinessObject.this_cEx)
        loc_oPg2.txt_4c_Tipo.Value       = THIS.this_oBusinessObject.this_nTipo
        loc_oPg2.edt_4c_Descricao.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
        loc_oPg2.txt_4c_DatIni.Value     = THIS.this_oBusinessObject.this_dDatIni
        loc_oPg2.txt_4c_DatFin.Value     = THIS.this_oBusinessObject.this_dDatFin
        loc_oPg2.txt_4c_NacFederal.Value = THIS.this_oBusinessObject.this_nNacFederal
        loc_oPg2.txt_4c_ImpFederal.Value = THIS.this_oBusinessObject.this_nImpFederal
        loc_oPg2.txt_4c_Estadual.Value   = THIS.this_oBusinessObject.this_nEstadual
        loc_oPg2.txt_4c_Municipal.Value  = THIS.this_oBusinessObject.this_nMunicipal
        loc_oPg2.txt_4c_Chave.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cChave)
        loc_oPg2.txt_4c_Versao.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cVersao)
        loc_oPg2.txt_4c_Fonte.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cFonte)
    ENDPROC

    *===========================================================================
    * LimparCampos - Limpa valores dos campos da Page2
    *===========================================================================
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oPg2
        loc_oPg2 = THIS.pgf_4c_Paginas.Page2

        loc_oPg2.txt_4c_Ufs.Value        = ""
        loc_oPg2.txt_4c_Codigo.Value     = ""
        loc_oPg2.txt_4c_Ex.Value         = ""
        loc_oPg2.txt_4c_Tipo.Value       = 0
        loc_oPg2.edt_4c_Descricao.Value  = ""
        loc_oPg2.txt_4c_DatIni.Value     = {}
        loc_oPg2.txt_4c_DatFin.Value     = {}
        loc_oPg2.txt_4c_NacFederal.Value = 0
        loc_oPg2.txt_4c_ImpFederal.Value = 0
        loc_oPg2.txt_4c_Estadual.Value   = 0
        loc_oPg2.txt_4c_Municipal.Value  = 0
        loc_oPg2.txt_4c_Chave.Value      = ""
        loc_oPg2.txt_4c_Versao.Value     = ""
        loc_oPg2.txt_4c_Fonte.Value      = ""
    ENDPROC

    *===========================================================================
    * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
    * ufs e codigo somente editaveis em INCLUIR (componentes da chave natural)
    *===========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg2, loc_lEnabled, loc_lIncluir
        loc_oPg2    = THIS.pgf_4c_Paginas.Page2
        loc_lEnabled = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar = .T.)
        loc_lIncluir = (THIS.this_cModoAtual = "INCLUIR")

        loc_oPg2.txt_4c_Ufs.Enabled        = (loc_lEnabled AND loc_lIncluir)
        loc_oPg2.txt_4c_Codigo.Enabled     = (loc_lEnabled AND loc_lIncluir)
        loc_oPg2.txt_4c_Ex.Enabled         = loc_lEnabled
        loc_oPg2.txt_4c_Tipo.Enabled       = loc_lEnabled
        loc_oPg2.edt_4c_Descricao.Enabled  = loc_lEnabled
        loc_oPg2.txt_4c_DatIni.Enabled     = loc_lEnabled
        loc_oPg2.txt_4c_DatFin.Enabled     = loc_lEnabled
        loc_oPg2.txt_4c_NacFederal.Enabled = loc_lEnabled
        loc_oPg2.txt_4c_ImpFederal.Enabled = loc_lEnabled
        loc_oPg2.txt_4c_Estadual.Enabled   = loc_lEnabled
        loc_oPg2.txt_4c_Municipal.Enabled  = loc_lEnabled
        loc_oPg2.txt_4c_Chave.Enabled      = (loc_lEnabled AND loc_lIncluir)
        loc_oPg2.txt_4c_Versao.Enabled     = (loc_lEnabled AND loc_lIncluir)
        loc_oPg2.txt_4c_Fonte.Enabled      = loc_lEnabled
    ENDPROC

    *===========================================================================
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Filtra cnt_4c_Botoes (deve permanecer oculto) e cnt_4c_Cabecalho
    * (Visible=.F. em Page2 - nao forcar .T.)
    *===========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                loc_cNome = UPPER(loc_oObjeto.Name)

                *-- cnt_4c_Botoes permanece oculto (CRUD escondido no SIGCDIBP)
                *-- cnt_4c_Cabecalho: preservar Visible original (pode ser .F. em Page2)
                IF INLIST(loc_cNome, "CNT_4C_BOTOES", "CNT_4C_CABECALHO")
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

    *===========================================================================
    * FormatarGridLista - Formata visual do grid da lista
    *===========================================================================
    PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
        WITH par_oGrid
            .FontName = "Tahoma"
            .FontSize = 8
        ENDWITH
    ENDPROC

    *===========================================================================
    * BtnIncluirClick - Abre Page2 em modo INCLUIR
    * Problema 18: NovoRegistro() prepara BO para INSERT
    * Problema 19: this_cModoAtual ANTES de HabilitarCampos
    *===========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.this_oBusinessObject.NovoRegistro()
        THIS.LimparCampos()
        THIS.this_cModoAtual = "INCLUIR"
        THIS.HabilitarCampos(.T.)
        THIS.AlternarPagina(2)
    ENDPROC

    *===========================================================================
    * BtnAlterarClick - Carrega registro selecionado e abre Page2 em modo ALTERAR
    * Problema 18: EditarRegistro() prepara BO para UPDATE
    *===========================================================================
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cCidChaves, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Alterar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
                IF EMPTY(loc_cCidChaves)
                    MsgAviso("Nenhum registro selecionado.", "Alterar")
                ELSE
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                    THIS.this_oBusinessObject.EditarRegistro()
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "ALTERAR"
                    THIS.HabilitarCampos(.T.)
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormIBP.BtnAlterarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnVisualizarClick - Carrega registro selecionado e abre Page2 somente leitura
    *===========================================================================
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cCidChaves, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Visualizar")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
                IF EMPTY(loc_cCidChaves)
                    MsgAviso("Nenhum registro selecionado.", "Visualizar")
                ELSE
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                    THIS.BOParaForm()
                    THIS.this_cModoAtual = "VISUALIZAR"
                    THIS.HabilitarCampos(.F.)
                    THIS.AlternarPagina(2)
                    loc_lResultado = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormIBP.BtnVisualizarClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnExcluirClick - Confirma e exclui registro selecionado do grid
    * Form chama Excluir() (PUBLIC); BO executa ExecutarExclusao() (PROTECTED)
    *===========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_cCidChaves

        TRY
            IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
                MsgAviso("Nenhum registro selecionado.", "Excluir")
            ELSE
                SELECT cursor_4c_Dados
                loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
                IF EMPTY(loc_cCidChaves)
                    MsgAviso("Nenhum registro selecionado.", "Excluir")
                ELSE
                    IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro de IBPT?", "Excluir")
                    IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
                        IF THIS.this_oBusinessObject.Excluir()
                            MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
                            THIS.CarregarLista()
                        ENDIF
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormIBP.BtnExcluirClick:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * BtnBuscarClick - Filtra registros da lista por UFS ou Codigo
    * cnt_4c_Botoes fica oculto no SIGCDIBP; metodo implementado para completude
    *===========================================================================
    PROCEDURE BtnBuscarClick()
        LOCAL loc_cFiltro, loc_lResultado
        loc_cFiltro    = ""
        loc_lResultado = .F.

        IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
           (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            RETURN
        ENDIF

        TRY
            loc_cFiltro = ALLTRIM(INPUTBOX("Digite UFS ou C" + CHR(243) + "digo para filtrar:", ;
                "Buscar IBPT", ""))

            IF EMPTY(loc_cFiltro)
                THIS.CarregarLista()
            ELSE
                IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
                    LOCAL loc_oGrid
                    loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista

                    loc_oGrid.ColumnCount = 3
                    loc_oGrid.RecordSource = "cursor_4c_Dados"
                    loc_oGrid.ColumnCount  = 9

                    WITH loc_oGrid
                        .Column1.ControlSource = "cursor_4c_Dados.ufs"
                        .Column2.ControlSource = "cursor_4c_Dados.codigo"
                        .Column3.ControlSource = "cursor_4c_Dados.datini"
                        .Column4.ControlSource = "cursor_4c_Dados.datfin"
                        .Column5.ControlSource = "cursor_4c_Dados.nacfederal"
                        .Column6.ControlSource = "cursor_4c_Dados.impfederal"
                        .Column7.ControlSource = "cursor_4c_Dados.estadual"
                        .Column8.ControlSource = "cursor_4c_Dados.municipal"
                        .Column9.ControlSource = "cursor_4c_Dados.versao"

                        .Column1.Header1.Caption = "Estado"
                        .Column2.Header1.Caption = "Codigo"
                        .Column3.Header1.Caption = "Data Ini"
                        .Column4.Header1.Caption = "Data Fim"
                        .Column5.Header1.Caption = "Aliq Nac Fed"
                        .Column6.Header1.Caption = "Aliq Imp Fed"
                        .Column7.Header1.Caption = "Aliq Estadual"
                        .Column8.Header1.Caption = "Aliq Municipal"
                        .Column9.Header1.Caption = "Versao"

                        .Column1.Width = 75
                        .Column2.Width = 100
                        .Column3.Width = 75
                        .Column4.Width = 75
                        .Column5.Width = 75
                        .Column6.Width = 75
                        .Column7.Width = 75
                        .Column8.Width = 75
                        .Column9.Width = 75
                    ENDWITH

                    THIS.FormatarGridLista(loc_oGrid)
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormIBP.BtnBuscarClick:" + CHR(13) + ;
                loException.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
    * Modos: LISTA, INCLUIR, ALTERAR, VISUALIZAR
    *===========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_oPg2, loc_lModoEdicao, loc_lModoVisualizacao
        loc_oPg2               = THIS.pgf_4c_Paginas.Page2
        loc_lModoEdicao        = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
        loc_lModoVisualizacao  = (THIS.this_cModoAtual = "VISUALIZAR")

        *-- Botao Confirmar: habilitado apenas em edicao
        IF PEMSTATUS(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar, "Enabled", 5)
            loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lModoEdicao
        ENDIF

        *-- Botao Cancelar: habilitado em edicao e visualizacao
        IF PEMSTATUS(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar, "Enabled", 5)
            loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = (loc_lModoEdicao OR loc_lModoVisualizacao)
        ENDIF

        *-- Botao BtnCarregar: habilitado apenas na lista
        IF VARTYPE(THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnCarregar) = "O"
            THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnCarregar.Enabled = (THIS.this_cModoAtual = "LISTA")
        ENDIF
    ENDPROC

    *===========================================================================
    * Destroy - Libera recursos
    *===========================================================================
    PROCEDURE Destroy()
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FormIBP.Destroy:" + CHR(13) + loException.Message, "Erro")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\IBPBO.prg):
*------------------------------------------------------------------------------
* IBPBO.prg - Business Object para SigCdIbp (Cadastro IBPT)
* Herda de BusinessBase
* Tabela: SigCdIbp / PK: cidchaves
*------------------------------------------------------------------------------

DEFINE CLASS IBPBO AS BusinessBase

    *-- Chave primaria
    this_cCidChaves  = ""   && char(20) NOT NULL

    *-- Campos da tabela SigCdIbp
    this_cUfs        = ""   && char(2)
    this_cCodigo     = ""   && char(10)
    this_cEx         = ""   && char(3)
    this_nTipo       = 0    && numeric(3,0)
    this_cDescricao  = ""   && text (memo)
    this_dDatIni     = {}   && datetime
    this_dDatFin     = {}   && datetime
    this_nNacFederal = 0    && numeric(5,2)
    this_nImpFederal = 0    && numeric(5,2)
    this_nEstadual   = 0    && numeric(5,2)
    this_nMunicipal  = 0    && numeric(5,2)
    this_cChave      = ""   && char(10)
    this_cVersao     = ""   && char(10)
    this_cFonte      = ""   && char(10)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdIbp"
        THIS.this_cCampoChave  = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtro opcional; cursor_4c_Dados para o grid
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("par_cFiltro") = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ELSE
                loc_cWhere = ""
            ENDIF

            loc_cSQL = "SELECT cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       " datini, datfin, nacfederal, impfederal, estadual," + ;
                       " municipal, chave, versao, fonte" + ;
                       " FROM SigCdIbp" + ;
                       loc_cWhere + ;
                       " ORDER BY ufs, codigo, versao"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT por cidchaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       " datini, datfin, nacfederal, impfederal, estadual," + ;
                       " municipal, chave, versao, fonte" + ;
                       " FROM SigCdIbp" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            TRY
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cUfs        = TratarNulo(ufs,        "C")
                THIS.this_cCodigo     = TratarNulo(codigo,     "C")
                THIS.this_cEx         = TratarNulo(ex,         "C")
                THIS.this_nTipo       = TratarNulo(tipo,       "N")
                THIS.this_cDescricao  = TratarNulo(descricao,  "C")
                THIS.this_dDatIni     = TratarNulo(datini,     "D")
                THIS.this_dDatFin     = TratarNulo(datfin,     "D")
                THIS.this_nNacFederal = TratarNulo(nacfederal, "N")
                THIS.this_nImpFederal = TratarNulo(impfederal, "N")
                THIS.this_nEstadual   = TratarNulo(estadual,   "N")
                THIS.this_nMunicipal  = TratarNulo(municipal,  "N")
                THIS.this_cChave      = TratarNulo(chave,      "C")
                THIS.this_cVersao     = TratarNulo(versao,     "C")
                THIS.this_cFonte      = TratarNulo(fonte,      "C")
                loc_lSucesso = .T.
            CATCH TO loException
                MsgErro("Erro em IBPBO.CarregarDoCursor:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro via CRUD standard
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdIbp" + ;
                       " (cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       "  datini, datfin, nacfederal, impfederal," + ;
                       "  estadual, municipal, chave, versao, fonte)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cUfs) + "," + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cEx) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       FormatarDataSQL(THIS.this_dDatIni) + "," + ;
                       FormatarDataSQL(THIS.this_dDatFin) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNacFederal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nImpFederal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEstadual) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMunicipal) + "," + ;
                       EscaparSQL(THIS.this_cChave) + "," + ;
                       EscaparSQL(THIS.this_cVersao) + "," + ;
                       EscaparSQL(THIS.this_cFonte) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdIbp SET" + ;
                       " ufs        = " + EscaparSQL(THIS.this_cUfs) + "," + ;
                       " codigo     = " + EscaparSQL(THIS.this_cCodigo) + "," + ;
                       " ex         = " + EscaparSQL(THIS.this_cEx) + "," + ;
                       " tipo       = " + FormatarNumeroSQL(THIS.this_nTipo) + "," + ;
                       " descricao  = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " datini     = " + FormatarDataSQL(THIS.this_dDatIni) + "," + ;
                       " datfin     = " + FormatarDataSQL(THIS.this_dDatFin) + "," + ;
                       " nacfederal = " + FormatarNumeroSQL(THIS.this_nNacFederal) + "," + ;
                       " impfederal = " + FormatarNumeroSQL(THIS.this_nImpFederal) + "," + ;
                       " estadual   = " + FormatarNumeroSQL(THIS.this_nEstadual) + "," + ;
                       " municipal  = " + FormatarNumeroSQL(THIS.this_nMunicipal) + "," + ;
                       " chave      = " + EscaparSQL(THIS.this_cChave) + "," + ;
                       " versao     = " + EscaparSQL(THIS.this_cVersao) + "," + ;
                       " fonte      = " + EscaparSQL(THIS.this_cFonte) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdIbp" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarPlanilha - Importa dados IBPT de arquivos CSV de uma pasta
    * Portado de SIGCDIBP.importaplan
    * CSV: c1=codigo, c2=ex(skip se !empty), c4=descricao, c5=nacfed, c6=impfed,
    *       c7=estadual, c8=municipal, c9=datini, c10=datfin, c11=chave,
    *       c12=versao, c13=fonte. UF extraida do nome do arquivo (pos 13-14).
    *--------------------------------------------------------------------------
    FUNCTION ImportarPlanilha()
        IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
           (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            RETURN .F.
        ENDIF
        LOCAL loc_lSucesso, loc_lOk, loc_lcDir, loc_nQtdArq
        LOCAL loc_lcArq, loc_lcUf, loc_lcCodigo, loc_lcDesc
        LOCAL loc_lnAliq5, loc_lnAliq6, loc_lnAliq7, loc_lnAliq8
        LOCAL loc_ldDatIni, loc_ldDatFin
        LOCAL loc_lcChave, loc_lcVersao, loc_lcFonte
        LOCAL loc_lcCidChaves, loc_lcQuery, loc_nResult, loc_i
        loc_lSucesso = .F.
        loc_lOk      = .F.

        *-- Selecionar pasta (fora do TRY - RETURN .F. e valido aqui)
        loc_lcDir = GETDIR([], "Selecione a Pasta com os Arquivos CSV do IBPT", ;
                           "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rios", 2)
        IF EMPTY(loc_lcDir)
            RETURN .F.
        ENDIF

        DIMENSION loc_laArqs[1, 5]
        loc_nQtdArq = ADIR(loc_laArqs, loc_lcDir + "*.csv")
        IF loc_nQtdArq = 0
            MsgAviso("Nenhum arquivo CSV encontrado na pasta selecionada.", "Aviso")
            RETURN .F.
        ENDIF

        loc_lOk = .T.

        TRY
            CREATE CURSOR localIbpt (c1 c(10), c2 c(50), c3 c(50), c4 c(100), ;
                c5 c(50), c6 c(50), c7 c(50), c8 c(50), ;
                c9 c(50), c10 c(50), c11 c(50), c12 c(50), c13 c(50))

            FOR loc_i = 1 TO loc_nQtdArq
                loc_lcArq = loc_lcDir + loc_laArqs[loc_i, 1]
                IF EMPTY(loc_lcArq)
                    LOOP
                ENDIF

                *-- UF extraida do nome do arquivo (posicoes 13-14 do nome original)
                loc_lcUf = SUBSTR(ALLTRIM(loc_laArqs[loc_i, 1]), 13, 2)

                SELECT localIbpt
                ZAP
                APPEND FROM (loc_lcArq) DELIMITED WITH CHARACTER ";"
                GO TOP
                DELETE
                DELETE ALL FOR !EMPTY(c2)
                GO TOP

                SCAN
                    loc_lcCodigo = ALLTRIM(c1)
                    loc_lcDesc   = ALLTRIM(c4)
                    loc_lnAliq5  = VAL(ALLTRIM(c5))
                    loc_lnAliq6  = VAL(ALLTRIM(c6))
                    loc_lnAliq7  = VAL(ALLTRIM(c7))
                    loc_lnAliq8  = VAL(ALLTRIM(c8))
                    loc_ldDatIni = DTOT(CTOD(ALLTRIM(c9)))
                    loc_ldDatFin = DTOT(CTOD(ALLTRIM(c10)))
                    loc_lcChave  = ALLTRIM(c11)
                    loc_lcVersao = ALLTRIM(c12)
                    loc_lcFonte  = ALLTRIM(c13)

                    loc_lcQuery = "SELECT cidchaves FROM SigCdIbp" + ;
                                  " WHERE ufs    = " + EscaparSQL(loc_lcUf) + ;
                                  " AND   codigo = " + EscaparSQL(loc_lcCodigo) + ;
                                  " AND   chave  = " + EscaparSQL(loc_lcChave) + ;
                                  " AND   versao = " + EscaparSQL(loc_lcVersao)

                    *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                    IF USED("cursor_4c_AuxIbp")
                        TABLEREVERT(.T., "cursor_4c_AuxIbp")
                        USE IN cursor_4c_AuxIbp
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_AuxIbp")
                    IF loc_nResult < 0
                        MsgErro("Imposs" + CHR(237) + "vel conectar ao servidor de banco de dados.", "Erro")
                        loc_lOk = .F.
                        IF USED("cursor_4c_AuxIbp")
                            USE IN cursor_4c_AuxIbp
                        ENDIF
                        EXIT
                    ENDIF

                    IF RECCOUNT("cursor_4c_AuxIbp") = 0
                        *-- Novo registro
                        loc_lcCidChaves = LEFT(fUniqueIds(), 20)
                        loc_lcQuery = "INSERT INTO SigCdIbp" + ;
                                      " (cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                                      "  datini, datfin, nacfederal, impfederal," + ;
                                      "  estadual, municipal, chave, versao, fonte)" + ;
                                      " VALUES (" + ;
                                      EscaparSQL(loc_lcCidChaves) + "," + ;
                                      EscaparSQL(loc_lcUf) + "," + ;
                                      EscaparSQL(loc_lcCodigo) + "," + ;
                                      EscaparSQL("") + "," + ;
                                      "0," + ;
                                      EscaparSQL(loc_lcDesc) + "," + ;
                                      FormatarDataSQL(loc_ldDatIni) + "," + ;
                                      FormatarDataSQL(loc_ldDatFin) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq5) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq6) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq7) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq8) + "," + ;
                                      EscaparSQL(loc_lcChave) + "," + ;
                                      EscaparSQL(loc_lcVersao) + "," + ;
                                      EscaparSQL(loc_lcFonte) + ;
                                      ")"
                    ELSE
                        *-- Registro existente - atualizar aliquotas e datas
                        SELECT cursor_4c_AuxIbp
                        loc_lcCidChaves = ALLTRIM(cursor_4c_AuxIbp.cidchaves)
                        loc_lcQuery = "UPDATE SigCdIbp SET" + ;
                                      " descricao  = " + EscaparSQL(loc_lcDesc) + "," + ;
                                      " datini     = " + FormatarDataSQL(loc_ldDatIni) + "," + ;
                                      " datfin     = " + FormatarDataSQL(loc_ldDatFin) + "," + ;
                                      " nacfederal = " + FormatarNumeroSQL(loc_lnAliq5) + "," + ;
                                      " impfederal = " + FormatarNumeroSQL(loc_lnAliq6) + "," + ;
                                      " estadual   = " + FormatarNumeroSQL(loc_lnAliq7) + "," + ;
                                      " municipal  = " + FormatarNumeroSQL(loc_lnAliq8) + "," + ;
                                      " fonte      = " + EscaparSQL(loc_lcFonte) + ;
                                      " WHERE cidchaves = " + EscaparSQL(loc_lcCidChaves)
                    ENDIF

                    IF USED("cursor_4c_AuxIbp")
                        USE IN cursor_4c_AuxIbp
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery)
                    IF loc_nResult < 0
                        MsgErro("Erro ao importar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lOk = .F.
                        EXIT
                    ENDIF

                    SELECT localIbpt
                ENDSCAN

                IF !loc_lOk
                    EXIT
                ENDIF
            ENDFOR

            IF USED("localIbpt")
                USE IN localIbpt
            ENDIF

            loc_lSucesso = loc_lOk
        CATCH TO loException
            MsgErro("Erro em IBPBO.ImportarPlanilha:" + CHR(13) + loException.Message, "Erro")
            IF USED("localIbpt")
                USE IN localIbpt
            ENDIF
            IF USED("cursor_4c_AuxIbp")
                USE IN cursor_4c_AuxIbp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

