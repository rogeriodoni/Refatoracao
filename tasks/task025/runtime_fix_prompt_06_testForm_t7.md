# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 7/10
- Mensagem: TIMEOUT: VFP9 travou durante teste de formulario (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[ETAPA 1B] Conectando ao banco de dados...
[2026-05-15 20:30:56] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 8072)...
[2026-05-15 20:30:58] [INFO] VFP9 finalizado em 302.0415738 segundos
[2026-05-15 20:30:58] [INFO] Exit Code: 4
[2026-05-15 20:30:58] [INFO] 
[2026-05-15 20:30:58] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-15 20:30:58] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_ajuisin5.prg
[2026-05-15 20:30:58] [INFO] 
[2026-05-15 20:30:58] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-15 20:30:58] [INFO] * Auto-generated wrapper for parameters
[2026-05-15 20:30:58] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-05-15 20:30:58] [INFO] * Parameters: 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'
[2026-05-15 20:30:58] [INFO] 
[2026-05-15 20:30:58] [INFO] * Anti-dialog protections for unattended execution
[2026-05-15 20:30:58] [INFO] SET SAFETY OFF
[2026-05-15 20:30:58] [INFO] SET RESOURCE OFF
[2026-05-15 20:30:58] [INFO] SET TALK OFF
[2026-05-15 20:30:58] [INFO] SET NOTIFY OFF
[2026-05-15 20:30:58] [INFO] SYS(2335, 0)
[2026-05-15 20:30:58] [INFO] 
[2026-05-15 20:30:58] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'
[2026-05-15 20:30:58] [INFO] QUIT
[2026-05-15 20:30:58] [INFO] 
[2026-05-15 20:30:58] [INFO] === Fim do Wrapper.prg ===
[2026-05-15 20:30:58] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-05-15 20:37:58] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-15 20:37:58] [INFO] Config FPW: (nao fornecido)
[2026-05-15 20:37:58] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-05-15 20:37:58] [INFO] Timeout: 300 segundos
[2026-05-15 20:37:58] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_ttzqn31i.prg
[2026-05-15 20:37:58] [INFO] Conteudo do wrapper:
[2026-05-15 20:37:58] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'
QUIT

[2026-05-15 20:37:59] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_ttzqn31i.prg
[2026-05-15 20:37:59] [INFO] VFP output esperado em: C:\4c\tasks\task025\vfp_output.txt
[2026-05-15 20:37:59] [INFO] Executando Visual FoxPro 9...
[2026-05-15 20:37:59] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_ttzqn31i.prg
[2026-05-15 20:37:59] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_ttzqn31i.prg
[2026-05-15 20:37:59] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigReAac
Inicio: 15/05/26 08:37:59 PM

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
[2026-05-15 20:42:59] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 28444)...
[2026-05-15 20:43:01] [INFO] VFP9 finalizado em 302.0582811 segundos
[2026-05-15 20:43:01] [INFO] Exit Code: 4
[2026-05-15 20:43:01] [INFO] 
[2026-05-15 20:43:01] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-15 20:43:01] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_ttzqn31i.prg
[2026-05-15 20:43:01] [INFO] 
[2026-05-15 20:43:01] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-15 20:43:01] [INFO] * Auto-generated wrapper for parameters
[2026-05-15 20:43:01] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-05-15 20:43:01] [INFO] * Parameters: 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'
[2026-05-15 20:43:01] [INFO] 
[2026-05-15 20:43:01] [INFO] * Anti-dialog protections for unattended execution
[2026-05-15 20:43:01] [INFO] SET SAFETY OFF
[2026-05-15 20:43:01] [INFO] SET RESOURCE OFF
[2026-05-15 20:43:01] [INFO] SET TALK OFF
[2026-05-15 20:43:01] [INFO] SET NOTIFY OFF
[2026-05-15 20:43:01] [INFO] SYS(2335, 0)
[2026-05-15 20:43:01] [INFO] 
[2026-05-15 20:43:01] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'
[2026-05-15 20:43:01] [INFO] QUIT
[2026-05-15 20:43:01] [INFO] 
[2026-05-15 20:43:01] [INFO] === Fim do Wrapper.prg ===
[2026-05-15 20:43:01] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-05-15 20:57:33] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-15 20:57:33] [INFO] Config FPW: (nao fornecido)
[2026-05-15 20:57:33] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-05-15 20:57:33] [INFO] Timeout: 300 segundos
[2026-05-15 20:57:33] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_kqo4ouzg.prg
[2026-05-15 20:57:33] [INFO] Conteudo do wrapper:
[2026-05-15 20:57:33] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'
QUIT

[2026-05-15 20:57:33] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_kqo4ouzg.prg
[2026-05-15 20:57:33] [INFO] VFP output esperado em: C:\4c\tasks\task025\vfp_output.txt
[2026-05-15 20:57:33] [INFO] Executando Visual FoxPro 9...
[2026-05-15 20:57:33] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_kqo4ouzg.prg
[2026-05-15 20:57:33] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_kqo4ouzg.prg
[2026-05-15 20:57:33] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigReAac
Inicio: 15/05/26 08:57:33 PM

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
[2026-05-15 21:02:33] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 30792)...
[2026-05-15 21:02:35] [INFO] VFP9 finalizado em 302.0462001 segundos
[2026-05-15 21:02:35] [INFO] Exit Code: 4
[2026-05-15 21:02:35] [INFO] 
[2026-05-15 21:02:35] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-15 21:02:35] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_kqo4ouzg.prg
[2026-05-15 21:02:35] [INFO] 
[2026-05-15 21:02:35] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-15 21:02:35] [INFO] * Auto-generated wrapper for parameters
[2026-05-15 21:02:35] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-05-15 21:02:35] [INFO] * Parameters: 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'
[2026-05-15 21:02:35] [INFO] 
[2026-05-15 21:02:35] [INFO] * Anti-dialog protections for unattended execution
[2026-05-15 21:02:35] [INFO] SET SAFETY OFF
[2026-05-15 21:02:35] [INFO] SET RESOURCE OFF
[2026-05-15 21:02:35] [INFO] SET TALK OFF
[2026-05-15 21:02:35] [INFO] SET NOTIFY OFF
[2026-05-15 21:02:35] [INFO] SYS(2335, 0)
[2026-05-15 21:02:35] [INFO] 
[2026-05-15 21:02:35] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'
[2026-05-15 21:02:35] [INFO] QUIT
[2026-05-15 21:02:35] [INFO] 
[2026-05-15 21:02:35] [INFO] === Fim do Wrapper.prg ===
[2026-05-15 21:02:35] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-05-15 21:23:33] [INFO] === VFP EXECUTOR v2.0 ===
[2026-05-15 21:23:33] [INFO] Config FPW: (nao fornecido)
[2026-05-15 21:23:33] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-05-15 21:23:33] [INFO] Timeout: 300 segundos
[2026-05-15 21:23:34] [INFO] Wrapper PRG criado para parametros: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_3g4uypyt.prg
[2026-05-15 21:23:34] [INFO] Conteudo do wrapper:
[2026-05-15 21:23:34] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'
QUIT

[2026-05-15 21:23:34] [INFO] Comando VFP: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_3g4uypyt.prg
[2026-05-15 21:23:34] [INFO] VFP output esperado em: C:\4c\tasks\task025\vfp_output.txt
[2026-05-15 21:23:34] [INFO] Executando Visual FoxPro 9...
[2026-05-15 21:23:34] [INFO] Comando completo: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_3g4uypyt.prg
[2026-05-15 21:23:34] [INFO] Executando: VFP9.EXE -T C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_3g4uypyt.prg
[2026-05-15 21:23:34] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigReAac
Inicio: 15/05/26 09:23:34 PM

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
[2026-05-15 21:28:34] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 28344)...
[2026-05-15 21:28:36] [INFO] VFP9 finalizado em 302.0432634 segundos
[2026-05-15 21:28:36] [INFO] Exit Code: 4
[2026-05-15 21:28:36] [INFO] 
[2026-05-15 21:28:36] [INFO] Arquivos temporarios preservados para inspecao:
[2026-05-15 21:28:36] [INFO]   Wrapper.prg: C:\Users\rafae\AppData\Local\Temp\vfp_wrapper_3g4uypyt.prg
[2026-05-15 21:28:36] [INFO] 
[2026-05-15 21:28:36] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-05-15 21:28:36] [INFO] * Auto-generated wrapper for parameters
[2026-05-15 21:28:36] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-05-15 21:28:36] [INFO] * Parameters: 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'
[2026-05-15 21:28:36] [INFO] 
[2026-05-15 21:28:36] [INFO] * Anti-dialog protections for unattended execution
[2026-05-15 21:28:36] [INFO] SET SAFETY OFF
[2026-05-15 21:28:36] [INFO] SET RESOURCE OFF
[2026-05-15 21:28:36] [INFO] SET TALK OFF
[2026-05-15 21:28:36] [INFO] SET NOTIFY OFF
[2026-05-15 21:28:36] [INFO] SYS(2335, 0)
[2026-05-15 21:28:36] [INFO] 
[2026-05-15 21:28:36] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigReAac', 'C:\4c\tasks\task025\logs\06_testForm.log'
[2026-05-15 21:28:36] [INFO] QUIT
[2026-05-15 21:28:36] [INFO] 
[2026-05-15 21:28:36] [INFO] === Fim do Wrapper.prg ===
[2026-05-15 21:28:36] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReAac.prg):
*==============================================================================
* FORMSIGREAAC.PRG
* Relatorio do Log de Acessos - Formulario de Filtros
* Tipo: REPORT (herda FormBase, BO herda RelatorioBase)
* Migrado de: SIGREAAC.SCX (frmrelatorio)
*
* Filtros (mutuamente exclusivos):
*   - Usuario : Codigo (SigCdUsu.Usuarios) + Nome (SigCdUsu.NComps)
*   - Grupo   : Codigo (SigCdGrA.Grupos)  + Nome (SigCdGrA.NComps)
*
* Regra de exclusao mutua (replicada dos eventos When do legado):
*   - txt_4c_CUsuario: editavel apenas quando CGrupo esta vazio
*   - txt_4c_DUsuario: editavel apenas quando CUsuario E CGrupo estao vazios
*   - txt_4c_CGrupo  : editavel apenas quando CUsuario esta vazio
*   - txt_4c_DGrupo  : editavel apenas quando CUsuario E CGrupo estao vazios
*==============================================================================

DEFINE CLASS FormSigReAac AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=149)
    Height      = 149
    Width       = 800
    DataSession = 2
    ShowWindow  = 1
    WindowType  = 1
    AutoCenter  = .T.
    BorderStyle = 2
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    ShowTips    = .T.

    *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
    this_oRelatorio    = .NULL.
    this_cMensagemErro = ""

    *--------------------------------------------------------------------------
    * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria estrutura visual do formulario de relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            THIS.Caption = "Relat" + CHR(243) + "rio do Log de Acessos"

            IF TYPE("gc_4c_CaminhoIcones") = "U"
                gc_4c_CaminhoIcones = ""
            ENDIF
            IF TYPE("gc_4c_CaminhoReports") = "U"
                gc_4c_CaminhoReports = ""
            ENDIF
            THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

            *-- Instanciar BO de relatorio
            THIS.this_oRelatorio = CREATEOBJECT("SigReAacBO")
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("Erro ao criar SigReAacBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Vincular eventos Click dos botoes do relatorio
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
                BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")

                THIS.LimparCampos()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura total do form (Width) para cobrir toda a faixa superior.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio do Log de Acessos"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Relat" + CHR(243) + "rio do Log de Acessos"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
    *   Geometria EXATA do framework frmrelatorio:
    *     Top=0, Left=529, Width=273, Height=80, ButtonCount=4
    *   Botoes: Visualizar/Imprimir/Excel/Encerrar (Left=5/71/137/203)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Visible       = .T.

            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 65
                .Height          = 70
                .Caption         = "Visualizar"
                .FontBold        = .T.
                .FontItalic      = .T.
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(2)
                .Top             = 5
                .Left            = 71
                .Width           = 65
                .Height          = 70
                .Caption         = "Imprimir"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Enviar o Relat" + CHR(243) + "rio Para Impressora"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(3)
                .Top             = 5
                .Left            = 137
                .Width           = 65
                .Height          = 70
                .Caption         = "Excel"
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "Exportar para Excel"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH

            WITH .Buttons(4)
                .Top             = 5
                .Left            = 203
                .Width           = 65
                .Height          = 70
                .Caption         = "Encerrar"
                .Cancel          = .T.
                .FontName        = "Tahoma"
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontSize        = 8
                .BackColor       = RGB(255, 255, 255)
                .ForeColor       = RGB(90, 90, 90)
                .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
                .PicturePosition = 13
                .SpecialEffect   = 0
                .MousePointer    = 15
                .ToolTipText     = "[Esc] Encerrar"
                .Themes          = .F.
                .Visible         = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
    *   Posicionado abaixo do cabecalho (Top=85) ate o fim do form (Height=64px)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
        loc_oPgf.PageCount = 1

        loc_oPgf.Top    = 85
        loc_oPgf.Left   = -1
        loc_oPgf.Width  = THIS.Width + 2
        loc_oPgf.Height = THIS.Height - 85
        loc_oPgf.Tabs   = .F.

        loc_oPgf.Page1.Caption   = "Filtros"
        loc_oPgf.Page1.FontName  = "Tahoma"
        loc_oPgf.Page1.FontSize  = 8
        loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
        loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
        loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona controles do bloco USUARIO na Page1
    *
    * Forms REPORT (frmrelatorio) tem layout FLAT: PageFrame com apenas Page1
    * (Filtros). Os filtros sao agrupados em dois blocos:
    *   - Bloco USUARIO : Codigo + Nome do usuario  (este metodo)
    *   - Bloco GRUPO   : Codigo + Nome do grupo    (ConfigurarPaginaDados)
    *
    * Posicoes ajustadas relativas ao PageFrame.Top=85:
    *   Linha Usuario : Top_original=86 -> Page1.Top=1
    *   Label Usuario : Top_original=90 -> Page1.Top=5
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Usuario :"
        loc_oPg.AddObject("lbl_4c_LblUsuario", "Label")
        WITH loc_oPg.lbl_4c_LblUsuario
            .Top       = 5
            .Left      = 57
            .Width     = 45
            .Height    = 15
            .Caption   = "Usu" + CHR(225) + "rio :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Usuario (SigCdUsu.Usuarios, MaxLength=10)
        loc_oPg.AddObject("txt_4c_CUsuario", "TextBox")
        WITH loc_oPg.txt_4c_CUsuario
            .Top         = 1
            .Left        = 105
            .Width       = 80
            .Height      = 25
            .MaxLength   = 10
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Nome do Usuario (SigCdUsu.NComps, MaxLength=30)
        loc_oPg.AddObject("txt_4c_DUsuario", "TextBox")
        WITH loc_oPg.txt_4c_DUsuario
            .Top         = 1
            .Left        = 187
            .Width       = 301
            .Height      = 25
            .MaxLength   = 30
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- KeyPress: F4=lookup direto, ENTER/TAB=validar codigo/nome digitado
        BINDEVENT(loc_oPg.txt_4c_CUsuario, "KeyPress", THIS, "TeclaCUsuario")
        BINDEVENT(loc_oPg.txt_4c_DUsuario, "KeyPress", THIS, "TeclaDUsuario")

        *-- DblClick: abre lookup diretamente (equivalente ao F4)
        BINDEVENT(loc_oPg.txt_4c_CUsuario, "DblClick", THIS, "AbrirBuscaCUsuario")
        BINDEVENT(loc_oPg.txt_4c_DUsuario, "DblClick", THIS, "AbrirBuscaDUsuario")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Adiciona controles do bloco GRUPO na Page1
    *
    * Em forms REPORT FLAT a unica Page (Page1) hospeda TODOS os filtros, mas
    * separamos a montagem em dois metodos para manter o contrato esperado
    * pelo pipeline de migracao (ConfigurarPaginaLista + ConfigurarPaginaDados).
    *
    * Posicoes ajustadas relativas ao PageFrame.Top=85:
    *   Linha Grupo : Top_original=113 -> Page1.Top=28
    *   Label Grupo : Top_original=117 -> Page1.Top=32
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1

        *-- Label "Grupo :"
        loc_oPg.AddObject("lbl_4c_LblGrupo", "Label")
        WITH loc_oPg.lbl_4c_LblGrupo
            .Top       = 32
            .Left      = 64
            .Width     = 38
            .Height    = 15
            .Caption   = "Grupo :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .BackStyle = 0
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- Codigo do Grupo (SigCdGrA.Grupos, MaxLength=10)
        loc_oPg.AddObject("txt_4c_CGrupo", "TextBox")
        WITH loc_oPg.txt_4c_CGrupo
            .Top         = 28
            .Left        = 105
            .Width       = 80
            .Height      = 25
            .MaxLength   = 10
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- Nome do Grupo (SigCdGrA.NComps, MaxLength=30)
        loc_oPg.AddObject("txt_4c_DGrupo", "TextBox")
        WITH loc_oPg.txt_4c_DGrupo
            .Top         = 28
            .Left        = 187
            .Width       = 301
            .Height      = 25
            .MaxLength   = 30
            .Value       = ""
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackColor   = RGB(255, 255, 255)
            .ForeColor   = RGB(90, 90, 90)
            .BorderStyle = 1
            .Visible     = .T.
        ENDWITH

        *-- KeyPress: F4=lookup direto, ENTER/TAB=validar codigo/nome digitado
        BINDEVENT(loc_oPg.txt_4c_CGrupo, "KeyPress", THIS, "TeclaCGrupo")
        BINDEVENT(loc_oPg.txt_4c_DGrupo, "KeyPress", THIS, "TeclaDGrupo")

        *-- DblClick: abre lookup diretamente (equivalente ao F4)
        BINDEVENT(loc_oPg.txt_4c_CGrupo, "DblClick", THIS, "AbrirBuscaCGrupo")
        BINDEVENT(loc_oPg.txt_4c_DGrupo, "DblClick", THIS, "AbrirBuscaDGrupo")
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura todos os filtros para valores padrao (vazios)
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPg
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            loc_oPg.txt_4c_CUsuario.Value = ""
            loc_oPg.txt_4c_DUsuario.Value = ""
            loc_oPg.txt_4c_CGrupo.Value   = ""
            loc_oPg.txt_4c_DGrupo.Value   = ""
            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Copia valores dos controles para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oPg
        loc_oPg = THIS.pgf_4c_Paginas.Page1
        WITH THIS.this_oRelatorio
            .this_cCUsuario = ALLTRIM(loc_oPg.txt_4c_CUsuario.Value)
            .this_cDUsuario = ALLTRIM(loc_oPg.txt_4c_DUsuario.Value)
            .this_cCGrupo   = ALLTRIM(loc_oPg.txt_4c_CGrupo.Value)
            .this_cDGrupo   = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoCampos - Aplica regra de exclusao mutua (legado: When events)
    *
    *   GetCUsuario.When = Empty(GetCGrupo.Value)
    *   GetDUsuario.When = Empty(GetCUsuario.Value) And Empty(GetCGrupo.Value)
    *   GetCGrupo.When   = Empty(GetCUsuario.Value)
    *   GetDGrupo.When   = Empty(GetCUsuario.Value) And Empty(GetCGrupo.Value)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoCampos()
        LOCAL loc_oPg, loc_lGrupoVazio, loc_lUsuarioVazio, loc_lAmbosVazios
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPg, "txt_4c_CUsuario", 5)
                loc_lGrupoVazio   = EMPTY(ALLTRIM(loc_oPg.txt_4c_CGrupo.Value))
                loc_lUsuarioVazio = EMPTY(ALLTRIM(loc_oPg.txt_4c_CUsuario.Value))
                loc_lAmbosVazios  = loc_lGrupoVazio AND loc_lUsuarioVazio

                loc_oPg.txt_4c_CUsuario.ReadOnly = !loc_lGrupoVazio
                loc_oPg.txt_4c_DUsuario.ReadOnly = !loc_lAmbosVazios
                loc_oPg.txt_4c_CGrupo.ReadOnly   = !loc_lUsuarioVazio
                loc_oPg.txt_4c_DGrupo.ReadOnly   = !loc_lAmbosVazios
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Ativa pagina no PageFrame
    *
    *   Forms REPORT (frmrelatorio) possuem APENAS 1 pagina (Filtros), ao
    *   contrario dos forms CRUD que alternam entre Page1 (Lista) e Page2
    *   (Dados). Este metodo garante que a unica pagina existente permaneca
    *   ativa e devolve o foco para o primeiro campo de filtro, mantendo
    *   compatibilidade com o contrato esperado pelo pipeline de migracao.
    *
    *   par_nPagina  - Indice da pagina (1 = Filtros). Valores invalidos
    *                  sao normalizados para 1, pois o form so tem 1 Page.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nPagina, loc_oPg
        TRY
            loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
            IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
                loc_nPagina = 1
            ENDIF
            THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF PEMSTATUS(loc_oPg, "txt_4c_CUsuario", 5)
                IF !loc_oPg.txt_4c_CUsuario.ReadOnly
                    loc_oPg.txt_4c_CUsuario.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * HANDLERS DE TECLADO (PUBLIC - contrato BINDEVENT)
    * F4=115, ENTER=13, TAB=9, ESC=27
    *==========================================================================

    PROCEDURE TeclaCUsuario(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCUsuario()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCUsuario()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_CUsuario.Value = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DUsuario.Value = ""
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDUsuario(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDUsuario()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDUsuario()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_CUsuario.Value = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DUsuario.Value = ""
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    PROCEDURE TeclaCGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaCGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarCGrupo()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_CGrupo.Value = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    PROCEDURE TeclaDGrupo(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 115
            THIS.AbrirBuscaDGrupo()
        ENDIF
        IF par_nKeyCode = 13 OR par_nKeyCode = 9
            THIS.ValidarDGrupo()
        ENDIF
        IF par_nKeyCode = 27
            THIS.pgf_4c_Paginas.Page1.txt_4c_CGrupo.Value = ""
            THIS.pgf_4c_Paginas.Page1.txt_4c_DGrupo.Value = ""
            THIS.AtualizarEstadoCampos()
        ENDIF
    ENDPROC

    *==========================================================================
    * VALIDACAO (ENTER/TAB em campo de codigo ou nome)
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarCUsuario - Busca usuario pelo codigo digitado (SigCdUsu.Usuarios)
    *   Replica GetCUsuario.Valid do original: lookup exato por campo Usuarios
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCUsuario()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_CUsuario.Value)
        IF EMPTY(loc_cCodigo)
            loc_oPg.txt_4c_DUsuario.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Usuarios, NComps FROM SigCdUsu WHERE Usuarios = " + ;
                   EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuVal")
        IF loc_nResult > 0
            SELECT cursor_4c_UsuVal
            IF !EOF()
                loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(Usuarios)
                loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(NComps)
            ELSE
                THIS.AbrirBuscaCUsuario()
            ENDIF
            USE IN cursor_4c_UsuVal
        ELSE
            THIS.AbrirBuscaCUsuario()
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDUsuario - Busca usuario pelo nome digitado (SigCdUsu.NComps)
    *   Replica GetDUsuario.Valid do original: lookup por NComps (LIKE prefixo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDUsuario()
        LOCAL loc_oPg, loc_cNome, loc_cSQL, loc_nResult
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cNome = ALLTRIM(loc_oPg.txt_4c_DUsuario.Value)
        IF EMPTY(loc_cNome)
            loc_oPg.txt_4c_CUsuario.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Usuarios, NComps FROM SigCdUsu WHERE NComps LIKE " + ;
                   EscaparSQL(loc_cNome + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuNomVal")
        IF loc_nResult > 0
            SELECT cursor_4c_UsuNomVal
            IF !EOF()
                loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(Usuarios)
                loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(NComps)
            ELSE
                THIS.AbrirBuscaDUsuario()
            ENDIF
            USE IN cursor_4c_UsuNomVal
        ELSE
            THIS.AbrirBuscaDUsuario()
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCGrupo - Busca grupo pelo codigo digitado (SigCdGrA.Grupos)
    *   Replica GetCGrupo.Valid do original: lookup exato por campo Grupos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarCGrupo()
        LOCAL loc_oPg, loc_cCodigo, loc_cSQL, loc_nResult
        loc_oPg     = THIS.pgf_4c_Paginas.Page1
        loc_cCodigo = ALLTRIM(loc_oPg.txt_4c_CGrupo.Value)
        IF EMPTY(loc_cCodigo)
            loc_oPg.txt_4c_DGrupo.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Grupos, NComps FROM SigCdGrA WHERE Grupos = " + ;
                   EscaparSQL(loc_cCodigo)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrAVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GrAVal
            IF !EOF()
                loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(Grupos)
                loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(NComps)
            ELSE
                THIS.AbrirBuscaCGrupo()
            ENDIF
            USE IN cursor_4c_GrAVal
        ELSE
            THIS.AbrirBuscaCGrupo()
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDGrupo - Busca grupo pelo nome digitado (SigCdGrA.NComps)
    *   Replica GetDGrupo.Valid do original: lookup por NComps (LIKE prefixo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDGrupo()
        LOCAL loc_oPg, loc_cNome, loc_cSQL, loc_nResult
        loc_oPg   = THIS.pgf_4c_Paginas.Page1
        loc_cNome = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
        IF EMPTY(loc_cNome)
            loc_oPg.txt_4c_CGrupo.Value = ""
            THIS.AtualizarEstadoCampos()
            RETURN
        ENDIF
        loc_cSQL = "SELECT Grupos, NComps FROM SigCdGrA WHERE NComps LIKE " + ;
                   EscaparSQL(loc_cNome + "%")
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrANomVal")
        IF loc_nResult > 0
            SELECT cursor_4c_GrANomVal
            IF !EOF()
                loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(Grupos)
                loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(NComps)
            ELSE
                THIS.AbrirBuscaDGrupo()
            ENDIF
            USE IN cursor_4c_GrANomVal
        ELSE
            THIS.AbrirBuscaDGrupo()
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * LOOKUPS FormBuscaAuxiliar (PUBLIC - contrato BINDEVENT DblClick)
    *==========================================================================

    *--------------------------------------------------------------------------
    * AbrirBuscaCUsuario - Lookup de usuario pelo codigo (SigCdUsu.Usuarios)
    *   Replica GetCUsuario.Valid do original: fwBuscaExt por campo Usuarios
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCUsuario()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.txt_4c_CUsuario.ReadOnly
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CUsuario.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Usu" + CHR(225) + "rio", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.NComps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Usuarios", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("NComps", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                        loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                        loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.NComps)
                    ELSE
                        loc_oPg.txt_4c_CUsuario.Value = ""
                        loc_oPg.txt_4c_DUsuario.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDUsuario - Lookup de usuario pelo nome (SigCdUsu.NComps)
    *   Replica GetDUsuario.Valid do original: fwBuscaExt por campo NComps
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDUsuario()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.txt_4c_DUsuario.ReadOnly
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DUsuario.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdUsu", "cursor_4c_BuscaUsu", "NComps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Usu" + CHR(225) + "rio", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.NComps)
                loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("NComps", "", "Nome")
                    loc_oBusca.mAddColuna("Usuarios", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUsu")
                        loc_oPg.txt_4c_DUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.NComps)
                        loc_oPg.txt_4c_CUsuario.Value = ALLTRIM(cursor_4c_BuscaUsu.Usuarios)
                    ELSE
                        loc_oPg.txt_4c_CUsuario.Value = ""
                        loc_oPg.txt_4c_DUsuario.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaUsu")
            USE IN cursor_4c_BuscaUsu
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaCGrupo - Lookup de grupo pelo codigo (SigCdGrA.Grupos)
    *   Replica GetCGrupo.Valid do original: fwBuscaExt por campo Grupos
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaCGrupo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.txt_4c_CGrupo.ReadOnly
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_CGrupo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrA", "cursor_4c_BuscaGrA", "Grupos", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo de Acesso", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.Grupos)
                loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.NComps)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("Grupos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.mAddColuna("NComps", "", "Nome")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrA")
                        loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.Grupos)
                        loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.NComps)
                    ELSE
                        loc_oPg.txt_4c_CGrupo.Value = ""
                        loc_oPg.txt_4c_DGrupo.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGrA")
            USE IN cursor_4c_BuscaGrA
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirBuscaDGrupo - Lookup de grupo pelo nome (SigCdGrA.NComps)
    *   Replica GetDGrupo.Valid do original: fwBuscaExt por campo NComps
    *--------------------------------------------------------------------------
    PROCEDURE AbrirBuscaDGrupo()
        LOCAL loc_cValor, loc_oBusca, loc_oPg
        loc_oPg    = THIS.pgf_4c_Paginas.Page1
        IF loc_oPg.txt_4c_DGrupo.ReadOnly
            RETURN
        ENDIF
        loc_cValor = ALLTRIM(loc_oPg.txt_4c_DGrupo.Value)
        loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
            "SigCdGrA", "cursor_4c_BuscaGrA", "NComps", loc_cValor, ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo de Acesso", ;
            .F., .T., "")
        IF VARTYPE(loc_oBusca) = "O"
            IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
                loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.NComps)
                loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.Grupos)
            ELSE
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna("NComps", "", "Nome")
                    loc_oBusca.mAddColuna("Grupos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
                    loc_oBusca.Show()
                    IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrA")
                        loc_oPg.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.NComps)
                        loc_oPg.txt_4c_CGrupo.Value = ALLTRIM(cursor_4c_BuscaGrA.Grupos)
                    ELSE
                        loc_oPg.txt_4c_CGrupo.Value = ""
                        loc_oPg.txt_4c_DGrupo.Value = ""
                    ENDIF
                ENDIF
            ENDIF
            loc_oBusca.Release()
        ENDIF
        IF USED("cursor_4c_BuscaGrA")
            USE IN cursor_4c_BuscaGrA
        ENDIF
        THIS.AtualizarEstadoCampos()
    ENDPROC

    *==========================================================================
    * ACOES DOS BOTOES DO RELATORIO
    *==========================================================================

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica se pelo menos um filtro esta preenchido
    *   Replica a validacao explicita do form original antes de processar:
    *   "If Empty(GetCGrupo.Value) And Empty(GetCUsuario.Value)"
    *   Retorna .T. se ao menos um filtro (usuario OU grupo) esta preenchido.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        LOCAL loc_oPg, loc_lValido
        loc_lValido = .F.
        TRY
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF !EMPTY(ALLTRIM(loc_oPg.txt_4c_CUsuario.Value)) OR ;
               !EMPTY(ALLTRIM(loc_oPg.txt_4c_CGrupo.Value))
                loc_lValido = .T.
            ELSE
                MsgInfo("Sele" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                         "o Realizada !!!", ;
                         "Filtro Obrigat" + CHR(243) + "rio")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Visualizar()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("VISUALIZAR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnImprimirClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.Imprimir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("IMPRIMIR")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnExcelClick()
        LOCAL loc_lValido
        loc_lValido = .F.
        TRY
            loc_lValido = THIS.ValidarFiltros()
            IF loc_lValido
                THIS.FormParaRelatorio()
                IF !THIS.this_oRelatorio.ExportarExcel()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
                ELSE
                    THIS.this_oRelatorio.RegistrarAuditoria("EXCEL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
        ENDTRY
    ENDPROC

    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * MAPEAMENTO CRUD -> REPORT
    * Aliases para compatibilidade com pipeline que espera metodos CRUD.
    * Forms REPORT (frmrelatorio) nao tem operacoes CRUD - apenas geram saidas
    * a partir de filtros. Os metodos abaixo replicam o contrato BtnXxxClick
    * delegando para o equivalente semantico em relatorios.
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnIncluirClick - "Nova consulta" em form de relatorio
    *   Em CRUD: prepara form para inserir novo registro.
    *   Em REPORT: nao existe "incluir registro". O equivalente semantico eh
    *   limpar todos os filtros para iniciar uma nova consulta a partir do
    *   zero, devolvendo o foco ao primeiro campo de filtro.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oPg
        TRY
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_CUsuario", 5)
                IF !loc_oPg.txt_4c_CUsuario.ReadOnly
                    loc_oPg.txt_4c_CUsuario.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - "Gerar relatorio" em form de relatorio
    *   Em CRUD: prepara form para alteracao do registro selecionado.
    *   Em REPORT: equivale a gerar o relatorio (visualizar preview) com os
    *   filtros atuais. Delega para BtnVisualizarClick que ja faz validacao
    *   de filtros, FormParaRelatorio, PrepararDados e REPORT FORM PREVIEW.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Operacao invalida em form de relatorio
    *   Em CRUD: exclui o registro selecionado apos confirmacao.
    *   Em REPORT: nao ha registros para excluir (apenas filtros e cursores
    *   temporarios). Informa o usuario que a operacao nao se aplica neste
    *   contexto e sugere o uso de Visualizar/Imprimir.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        MsgInfo("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + ;
            CHR(237) + "vel em relat" + CHR(243) + "rios." + CHR(13) + ;
            "Use Visualizar ou Imprimir para gerar o relat" + CHR(243) + "rio.", ;
            "Aten" + CHR(231) + CHR(227) + "o")
    ENDPROC

    *==========================================================================
    * METODOS COMPLEMENTARES - FASE 8
    * Contratos exigidos pelo pipeline de migracao para forms de qualquer tipo
    *==========================================================================

    *--------------------------------------------------------------------------
    * BtnBuscarClick - "Buscar/Consultar" em form de relatorio
    *   Em CRUD: abre form de consulta para um registro existente.
    *   Em REPORT: semanticamente equivale a visualizar o relatorio com os
    *   filtros atuais (preview na tela), permitindo "buscar" os dados.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *   Alias para BtnSairClick. Mapeia o contrato de encerramento do
    *   pipeline para o metodo especifico deste form de relatorio.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - "Salvar/Confirmar" em form de relatorio
    *   Em CRUD: persiste alteracoes do registro no banco de dados.
    *   Em REPORT: semanticamente equivale a imprimir/gerar o relatorio
    *   (acao principal de "confirmar" a selecao de filtros e produzir saida).
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnImprimirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - "Cancelar" em form de relatorio
    *   Em CRUD: descarta alteracoes e retorna para a lista.
    *   Em REPORT: limpa todos os filtros preenchidos, permitindo ao usuario
    *   recomecar a selecao sem fechar o formulario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oPg
        TRY
            THIS.LimparCampos()
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O" AND PEMSTATUS(loc_oPg, "txt_4c_CUsuario", 5)
                IF !loc_oPg.txt_4c_CUsuario.ReadOnly
                    loc_oPg.txt_4c_CUsuario.SetFocus()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias para FormParaRelatorio
    *   Garante compatibilidade com o contrato CRUD do pipeline de migracao.
    *   Forms REPORT nao tem BO de cadastro; FormParaRelatorio copia os
    *   valores dos controles de filtro para as propriedades do BO de relatorio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Carrega valores do BO de relatorio de volta para os controles
    *   Em CRUD: preenche os controles com os dados do registro carregado.
    *   Em REPORT: o BO de relatorio nao tem "registro" para exibir; apenas
    *   repoe os filtros armazenados nas propriedades do BO nos controles,
    *   util para restaurar o estado de filtros apos PrepararDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oPg
        TRY
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                RETURN
            ENDIF
            loc_oPg = THIS.pgf_4c_Paginas.Page1
            WITH THIS.this_oRelatorio
                loc_oPg.txt_4c_CUsuario.Value = NVL(.this_cCUsuario, "")
                loc_oPg.txt_4c_DUsuario.Value = NVL(.this_cDUsuario, "")
                loc_oPg.txt_4c_CGrupo.Value   = NVL(.this_cCGrupo, "")
                loc_oPg.txt_4c_DGrupo.Value   = NVL(.this_cDGrupo, "")
            ENDWITH
            THIS.AtualizarEstadoCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles de filtro
    *   Em CRUD: habilita/desabilita campos conforme modo INCLUIR/ALTERAR/VISUALIZAR.
    *   Em REPORT: a habilitacao e controlada pela regra de exclusao mutua
    *   (AtualizarEstadoCampos). Este metodo aplica o estado base e depois
    *   chama AtualizarEstadoCampos para refinar conforme as regras do legado.
    *   par_lHabilitar = .T. -> habilita todos (ReadOnly=.F.)
    *   par_lHabilitar = .F. -> desabilita todos (ReadOnly=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oPg, loc_lHab
        TRY
            loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
            loc_oPg  = THIS.pgf_4c_Paginas.Page1
            IF VARTYPE(loc_oPg) = "O"
                IF PEMSTATUS(loc_oPg, "txt_4c_CUsuario", 5)
                    loc_oPg.txt_4c_CUsuario.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DUsuario", 5)
                    loc_oPg.txt_4c_DUsuario.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_CGrupo", 5)
                    loc_oPg.txt_4c_CGrupo.ReadOnly = !loc_lHab
                ENDIF
                IF PEMSTATUS(loc_oPg, "txt_4c_DGrupo", 5)
                    loc_oPg.txt_4c_DGrupo.ReadOnly = !loc_lHab
                ENDIF
            ENDIF
            IF loc_lHab
                THIS.AtualizarEstadoCampos()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega a lista de registros (contrato CRUD)
    *   Em CRUD: executa query e popula o grid da Page1 com os registros.
    *   Em REPORT: forms de relatorio nao tem lista de registros nem grid.
    *   Retorna .T. para indicar sucesso ao pipeline (nao ha dados para carregar).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    *   Em CRUD: habilita/desabilita botoes CRUD de acordo com o modo
    *   (LISTA, INCLUIR, ALTERAR, VISUALIZAR).
    *   Em REPORT: nao ha modos CRUD; os 4 botoes do CommandGroup permanecem
    *   sempre habilitados (Visualizar/Imprimir/Excel/Encerrar). Nao ha
    *   estado de modo a gerenciar neste tipo de formulario.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        TRY
            IF VARTYPE(THIS.cmg_4c_Botoes) = "O"
                THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(2).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(3).Enabled = .T.
                THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencia ao BO
    *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigReAacBO.prg):
*==============================================================================
* SIGREAACBO.PRG
* Business Object para Relatorio do Log de Acessos
* Herda de RelatorioBase
*
* Tabelas: SigOpLog (dados), SigCdEmp (cabecalho),
*          SigCdUsu (lookup usuario), SigCdGrA (lookup grupo)
* Filtros: Codigo/Nome do Usuario OU Codigo/Nome do Grupo
*==============================================================================

DEFINE CLASS SigReAacBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cCUsuario          = ""
    this_cDUsuario          = ""
    this_cCGrupo            = ""
    this_cDGrupo            = ""

    *-- Cursores utilizados
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"

    *-- Configuracao do relatorio
    this_cFRXPath           = ""
    this_cTituloRel         = ""
    this_cSubTitulo         = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                IF TYPE("gc_4c_CaminhoReports") = "U"
                    gc_4c_CaminhoReports = ""
                ENDIF
                THIS.this_cFRXPath   = gc_4c_CaminhoReports + "RelSigReAac.frx"
                THIS.this_cTituloRel = "Relat" + CHR(243) + "rio do Log de Acessos"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores de cabecalho e dados para o relatorio
    *
    * Logica original (processamento):
    *   1. Valida pelo menos um filtro ativo (grupo OU usuario)
    *   2. Obtem razao social da empresa em SigCdEmp
    *   3. Cria cursor de cabecalho com titulo/subtitulo/empresa
    *   4. Filtro GRUPO: SigOpLog WHERE Transacaos LIKE grupo
    *      AND Progs IN ('CADGRU','CADUSU')
    *   5. Filtro USUARIO: SigOpLog WHERE Transacaos LIKE usuario
    *      AND Progs IN ('CADUSU','CADGRU'), depois enriquece cursor com
    *      registros de grupo associados ao usuario que ainda nao constam
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_lContinuar
        LOCAL loc_cEmpDesc, loc_nRegs, loc_nI, loc_cGrupo
        LOCAL loc_cCUsuarioEsc, loc_cCGrupoEsc, loc_cGrupoEsc
        loc_lSucesso  = .F.
        loc_lContinuar = .T.
        TRY
            *-- Validar: pelo menos um filtro obrigatorio
            IF EMPTY(THIS.this_cCGrupo) AND EMPTY(THIS.this_cCUsuario)
                THIS.this_cMensagemErro = "Sele" + CHR(231) + CHR(227) + ;
                                          "o n" + CHR(227) + "o Realizada !!!"
                loc_lContinuar = .F.
            ENDIF

            *-- Obter razao social da empresa
            IF loc_lContinuar
                loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE cEmps = " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRaz")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao obter dados da empresa"
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Montar descricao da empresa para o cabecalho
            IF loc_lContinuar
                IF USED("cursor_4c_EmpRaz") AND RECCOUNT("cursor_4c_EmpRaz") > 0
                    SELECT cursor_4c_EmpRaz
                    loc_cEmpDesc = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ALLTRIM(Razas)
                ELSE
                    loc_cEmpDesc = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                ENDIF
                IF USED("cursor_4c_EmpRaz")
                    USE IN cursor_4c_EmpRaz
                ENDIF
            ENDIF

            *-- Recriar cursor de cabecalho
            IF loc_lContinuar
                IF USED(THIS.this_cCursorCabecalho)
                    USE IN (THIS.this_cCursorCabecalho)
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_Cabecalho (cTitulos C(80), cSubTitulos C(80), Empresa C(80))
                SET NULL OFF
                SELECT cursor_4c_Cabecalho
                APPEND BLANK
                REPLACE Empresa WITH loc_cEmpDesc
            ENDIF

            *-- FILTRO POR GRUPO
            IF loc_lContinuar AND !EMPTY(THIS.this_cCGrupo)
                SELECT cursor_4c_Cabecalho
                REPLACE cTitulos WITH "RELATORIO DO LOG DE ALTERA" + ;
                                      CHR(199) + CHR(195) + "O GRUPOS DE ACESSOS"
                REPLACE cSubTitulos WITH "Grupo : " + ;
                                         ALLTRIM(THIS.this_cCGrupo) + " - " + ;
                                         ALLTRIM(THIS.this_cDGrupo)

                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                loc_cCGrupoEsc = STRTRAN(ALLTRIM(THIS.this_cCGrupo), "'", "''")
                loc_cSQL = "SELECT * FROM SigOpLog" + ;
                           " WHERE Transacaos LIKE '%" + loc_cCGrupoEsc + "%'" + ;
                           " AND (Progs = 'CADGRU' OR Progs = 'CADUSU')" + ;
                           " ORDER BY Datars"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar dados do log por grupo"
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- FILTRO POR USUARIO
            IF loc_lContinuar AND !EMPTY(THIS.this_cCUsuario)
                SELECT cursor_4c_Cabecalho
                REPLACE cTitulos WITH "RELATORIO DO LOG DE ALTERA" + ;
                                      CHR(199) + CHR(195) + "O DE ACESSOS DE USUARIOS"
                REPLACE cSubTitulos WITH "Usu" + CHR(225) + "rio : " + ;
                                         ALLTRIM(THIS.this_cCUsuario) + " - " + ;
                                         ALLTRIM(THIS.this_cDUsuario)

                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                loc_cCUsuarioEsc = STRTRAN(ALLTRIM(THIS.this_cCUsuario), "'", "''")
                loc_cSQL = "SELECT * FROM SigOpLog" + ;
                           " WHERE Transacaos LIKE '%" + loc_cCUsuarioEsc + "%'" + ;
                           " AND (Progs = 'CADUSU' OR Progs = 'CADGRU')" + ;
                           " ORDER BY Datars"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar dados do log por usu" + CHR(225) + "rio"
                    loc_lContinuar = .F.
                ENDIF

                *-- Enriquecer: para cada registro que referencia GRUPO,
                *   buscar registros de grupo nao presentes no cursor principal
                IF loc_lContinuar
                    SELECT cursor_4c_Dados
                    GO TOP
                    loc_nRegs = RECCOUNT()
                    loc_nI = 0
                    DO WHILE loc_nI < loc_nRegs
                        loc_nI = loc_nI + 1
                        SELECT cursor_4c_Dados
                        GO loc_nI
                        IF AT('GRUPO : ', UPPER(Transacaos)) > 0
                            loc_cGrupo    = ALLTRIM(SUBSTR(Transacaos, 9, 10))
                            loc_cGrupoEsc = STRTRAN(loc_cGrupo, "'", "''")
                            loc_cSQL = "SELECT * FROM SigOpLog" + ;
                                       " WHERE Transacaos LIKE '%" + loc_cGrupoEsc + "%'" + ;
                                       " AND Transacaos LIKE '%PROG :%'" + ;
                                       " AND Progs = 'CADGRU'" + ;
                                       " ORDER BY Datars"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruAux")
                            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruAux") > 0
                                SELECT * FROM cursor_4c_GruAux ;
                                    WHERE cIdChaves NOT IN ;
                                        (SELECT cIdChaves FROM cursor_4c_Dados) ;
                                    INTO CURSOR cursor_4c_Ins
                                IF RECCOUNT("cursor_4c_Ins") > 0
                                    SELECT cursor_4c_Dados
                                    APPEND FROM DBF("cursor_4c_Ins")
                                    SELECT cursor_4c_Dados
                                    GO loc_nI
                                ENDIF
                                IF USED("cursor_4c_Ins")
                                    USE IN cursor_4c_Ins
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_GruAux")
                                USE IN cursor_4c_GruAux
                            ENDIF
                        ENDIF
                    ENDDO
                ENDIF
            ENDIF

            *-- Posicionar no inicio dos dados
            IF loc_lContinuar
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia relatorio para impressora (com dialogo de selecao)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) NOCONSOLE TO PRINTER PROMPT
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cFRXPath) NOCONSOLE PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Exporta relatorio para arquivo Excel
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = FORCEPATH("RelLogAcessos_" + ;
                               TRANSFORM(DATE(), "@YMD") + ".xls", ;
                               SYS(5) + CURDIR())
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    COPY TO (loc_cArquivo) TYPE XL5
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo exportado:" + CHR(13) + loc_cArquivo, "Excel")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Cursor de dados n" + CHR(227) + ;
                                              "o dispon" + CHR(237) + "vel"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ExportarExcel")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna descricao do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores dos filtros a partir de um cursor
    *
    * Permite recuperar uma configuracao de filtros previamente salva (por
    * exemplo, um conjunto de filtros pre-definidos exibidos em historico de
    * relatorios). Mapeia colunas do cursor para as propriedades de filtro
    * deste BO.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                                      "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            IF !EOF() AND !BOF()
                IF TYPE("CUsuario") = "C"
                    THIS.this_cCUsuario = ALLTRIM(NVL(EVALUATE("CUsuario"), ""))
                ENDIF
                IF TYPE("DUsuario") = "C"
                    THIS.this_cDUsuario = ALLTRIM(NVL(EVALUATE("DUsuario"), ""))
                ENDIF
                IF TYPE("CGrupo") = "C"
                    THIS.this_cCGrupo = ALLTRIM(NVL(EVALUATE("CGrupo"), ""))
                ENDIF
                IF TYPE("DGrupo") = "C"
                    THIS.this_cDGrupo = ALLTRIM(NVL(EVALUATE("DGrupo"), ""))
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de filtros est" + CHR(225) + " vazio"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva. Caso seja invocado indevidamente pelo Form, o
    * chamador recebera feedback claro.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de inser" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir(), Visualizar() ou " + ;
                                  "ExportarExcel()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "Inserir")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel para Business Object de relatorio
    *
    * Relatorios nao gravam registros - apenas leem dados para impressao.
    * Implementado por contrato de interface, retorna .F. e seta mensagem
    * de erro descritiva. Caso seja invocado indevidamente pelo Form, o
    * chamador recebera feedback claro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o de atualiza" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o " + CHR(233) + ;
                                  " suportada em relat" + CHR(243) + "rios. " + ;
                                  "Utilize Imprimir(), Visualizar() ou " + ;
                                  "ExportarExcel()."
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .F.
        ENDIF
        MsgErro(THIS.this_cMensagemErro, "Atualizar")
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificacao da configuracao atual
    *
    * Como nao ha registro persistido, retorna concatenacao dos filtros
    * atualmente carregados (usado para auditoria/log de execucoes do
    * relatorio).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF !EMPTY(THIS.this_cCGrupo)
            loc_cChave = "GRUPO=" + ALLTRIM(THIS.this_cCGrupo)
        ENDIF
        IF !EMPTY(THIS.this_cCUsuario)
            IF !EMPTY(loc_cChave)
                loc_cChave = loc_cChave + "|"
            ENDIF
            loc_cChave = loc_cChave + "USUARIO=" + ALLTRIM(THIS.this_cCUsuario)
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    *
    * Reaproveita a estrutura padrao de auditoria do sistema para gravar
    * eventos de impressao/visualizacao do relatorio, possibilitando
    * rastreabilidade de quem consultou o Log de Acessos e com quais filtros.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_nResult, loc_cChave, loc_cUsuario, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF
            IF EMPTY(loc_cUsuario)
                loc_cUsuario = "SISTEMA"
            ENDIF

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChaveRegistro, DadosNovos) " + ;
                       "VALUES (" + ;
                       FormatarDataSQL(DATETIME()) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL(NVL(par_cOperacao, "RELATORIO")) + ", " + ;
                       EscaparSQL("SigOpLog") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL("Relat" + CHR(243) + "rio do Log de Acessos") + ;
                       ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "RegistrarAuditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_EmpRaz")
            USE IN cursor_4c_EmpRaz
        ENDIF
        IF USED("cursor_4c_GruAux")
            USE IN cursor_4c_GruAux
        ENDIF
        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

