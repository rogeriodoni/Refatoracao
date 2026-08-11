# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 3/10
- Mensagem: TIMEOUT: VFP9 travou durante teste automatico (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-09 07:12:06] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 07:12:06] [INFO] Config FPW: (nao fornecido)
[2026-08-09 07:12:06] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 07:12:06] [INFO] Timeout: 300 segundos
[2026-08-09 07:12:06] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rdio4jvr.prg
[2026-08-09 07:12:06] [INFO] Conteudo do wrapper:
[2026-08-09 07:12:06] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'
QUIT

[2026-08-09 07:12:06] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rdio4jvr.prg
[2026-08-09 07:12:06] [INFO] VFP output esperado em: C:\4c\tasks\task448\vfp_output.txt
[2026-08-09 07:12:06] [INFO] Executando Visual FoxPro 9...
[2026-08-09 07:12:06] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rdio4jvr.prg
[2026-08-09 07:12:06] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rdio4jvr.prg
[2026-08-09 07:12:06] [INFO] Timeout configurado: 300 segundos
[2026-08-09 07:17:06] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 8312)...
[2026-08-09 07:17:08] [INFO] VFP9 finalizado em 302.0702001 segundos
[2026-08-09 07:17:08] [INFO] Exit Code: 4
[2026-08-09 07:17:08] [INFO] 
[2026-08-09 07:17:08] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 07:17:08] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_rdio4jvr.prg
[2026-08-09 07:17:08] [INFO] 
[2026-08-09 07:17:09] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 07:17:09] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 07:17:09] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 07:17:09] [INFO] * Parameters: 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'
[2026-08-09 07:17:09] [INFO] 
[2026-08-09 07:17:09] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 07:17:09] [INFO] SET SAFETY OFF
[2026-08-09 07:17:09] [INFO] SET RESOURCE OFF
[2026-08-09 07:17:09] [INFO] SET TALK OFF
[2026-08-09 07:17:09] [INFO] SET NOTIFY OFF
[2026-08-09 07:17:09] [INFO] SYS(2335, 0)
[2026-08-09 07:17:09] [INFO] 
[2026-08-09 07:17:09] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'
[2026-08-09 07:17:09] [INFO] QUIT
[2026-08-09 07:17:09] [INFO] 
[2026-08-09 07:17:09] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 07:17:09] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 07:18:36] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 07:18:36] [INFO] Config FPW: (nao fornecido)
[2026-08-09 07:18:36] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 07:18:36] [INFO] Timeout: 300 segundos
[2026-08-09 07:18:36] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dws3nhcd.prg
[2026-08-09 07:18:36] [INFO] Conteudo do wrapper:
[2026-08-09 07:18:36] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'
QUIT

[2026-08-09 07:18:36] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dws3nhcd.prg
[2026-08-09 07:18:36] [INFO] VFP output esperado em: C:\4c\tasks\task448\vfp_output.txt
[2026-08-09 07:18:36] [INFO] Executando Visual FoxPro 9...
[2026-08-09 07:18:36] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dws3nhcd.prg
[2026-08-09 07:18:36] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dws3nhcd.prg
[2026-08-09 07:18:36] [INFO] Timeout configurado: 300 segundos
[2026-08-09 07:23:36] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 4940)...
[2026-08-09 07:23:38] [INFO] VFP9 finalizado em 302.0229654 segundos
[2026-08-09 07:23:38] [INFO] Exit Code: 4
[2026-08-09 07:23:38] [INFO] 
[2026-08-09 07:23:38] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 07:23:38] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_dws3nhcd.prg
[2026-08-09 07:23:38] [INFO] 
[2026-08-09 07:23:38] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 07:23:38] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 07:23:38] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 07:23:38] [INFO] * Parameters: 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'
[2026-08-09 07:23:38] [INFO] 
[2026-08-09 07:23:38] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 07:23:38] [INFO] SET SAFETY OFF
[2026-08-09 07:23:38] [INFO] SET RESOURCE OFF
[2026-08-09 07:23:38] [INFO] SET TALK OFF
[2026-08-09 07:23:38] [INFO] SET NOTIFY OFF
[2026-08-09 07:23:38] [INFO] SYS(2335, 0)
[2026-08-09 07:23:38] [INFO] 
[2026-08-09 07:23:38] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'
[2026-08-09 07:23:38] [INFO] QUIT
[2026-08-09 07:23:38] [INFO] 
[2026-08-09 07:23:38] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 07:23:38] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 07:34:44] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 07:34:44] [INFO] Config FPW: (nao fornecido)
[2026-08-09 07:34:44] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 07:34:44] [INFO] Timeout: 300 segundos
[2026-08-09 07:34:44] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ajdumr5r.prg
[2026-08-09 07:34:44] [INFO] Conteudo do wrapper:
[2026-08-09 07:34:44] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'
QUIT

[2026-08-09 07:34:44] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ajdumr5r.prg
[2026-08-09 07:34:44] [INFO] VFP output esperado em: C:\4c\tasks\task448\vfp_output.txt
[2026-08-09 07:34:44] [INFO] Executando Visual FoxPro 9...
[2026-08-09 07:34:44] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ajdumr5r.prg
[2026-08-09 07:34:44] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ajdumr5r.prg
[2026-08-09 07:34:44] [INFO] Timeout configurado: 300 segundos
[2026-08-09 07:39:44] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 7268)...
[2026-08-09 07:39:46] [INFO] VFP9 finalizado em 302.0851355 segundos
[2026-08-09 07:39:46] [INFO] Exit Code: 4
[2026-08-09 07:39:46] [INFO] 
[2026-08-09 07:39:46] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 07:39:46] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_ajdumr5r.prg
[2026-08-09 07:39:46] [INFO] 
[2026-08-09 07:39:46] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 07:39:46] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 07:39:46] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 07:39:46] [INFO] * Parameters: 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'
[2026-08-09 07:39:46] [INFO] 
[2026-08-09 07:39:46] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 07:39:46] [INFO] SET SAFETY OFF
[2026-08-09 07:39:46] [INFO] SET RESOURCE OFF
[2026-08-09 07:39:46] [INFO] SET TALK OFF
[2026-08-09 07:39:46] [INFO] SET NOTIFY OFF
[2026-08-09 07:39:46] [INFO] SYS(2335, 0)
[2026-08-09 07:39:46] [INFO] 
[2026-08-09 07:39:46] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICN', 'C:\4c\tasks\task448', 'OPERACIONAL'
[2026-08-09 07:39:46] [INFO] QUIT
[2026-08-09 07:39:46] [INFO] 
[2026-08-09 07:39:46] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 07:39:46] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormICN.prg):
*==============================================================================
* FormICN.prg - Form OPERACIONAL: Icones de Acesso (sigcdprg)
* Herda de: FormBase
* Migrado de: SIGCDICN.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (1000x600, cabecalho cinza, grid 2 col)
*   BD   -> sigcdprg via ICNBO (CarregarProgramas / SalvarAlteracoes)
*   CODE -> FormBase + ICNBO (flat OPERACIONAL, sem PageFrame CRUD)
*
* Estrutura original: cntSombra (header) + Grid1 (2 colunas) + Botao_okcancel
* Acoes: DblClick/ENTER em celula do grid abre FormSIGPRCIC para escolha de icone
*        Botao Ok percorre cursor e persiste via ICNBO.SalvarAlteracoes()
*        Botao Encerrar cancela e fecha sem salvar
*==============================================================================
DEFINE CLASS FormICN AS FormBase

    *-- Propriedades visuais (legado 800x578, escalado para 1000x600)
    Width       = 1000
    Height      = 600
    AutoCenter  = .T.
    ShowTips    = .T.
    BorderStyle = 2
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    DataSession = 2

    *-- Referencia ao Business Object
    this_oBusinessObject = .NULL.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Instanciar BO
            THIS.this_oBusinessObject = CREATEOBJECT("ICNBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar ICNBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em FormICN.InicializarForm")
            ELSE
                *-- Caption via Prompt() (item de menu chamador), como no legado
                LOCAL loc_cCaption
                loc_cCaption = ALLTRIM(PROMPT())
                IF EMPTY(loc_cCaption)
                    loc_cCaption = CHR(205) + "cones de Acesso"
                ENDIF
                THIS.Caption = loc_cCaption

                *-- Compor layout (flat OPERACIONAL, sem PageFrame CRUD)
                THIS.ConfigurarPageFrame()

                *-- Ecoar Caption nas labels do cabecalho (apos ConfigurarPageFrame)
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
                THIS.TornarControlesVisiveis()

                *-- Carregar dados do banco (apenas com conexao real)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    THIS.CarregarDados()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *==========================================================================
    * OPERACIONAL flat layout - o legado SIGCDICN nao usa PageFrame; controles
    * ficam diretamente sobre o Form. Este metodo orquestra a composicao das
    * 3 regioes: cabecalho cinza (cntSombra), area de listagem (Grid1) e
    * area de dados/acoes (CommandGroup Ok/Encerrar do legado Botao_okcancel).
    *==========================================================================
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *==========================================================================
    * OPERACIONAL flat: nao existe PageFrame com Page1(Lista)/Page2(Dados).
    * Este metodo compoe a area de listagem (unica "lista" do form): o Grid1
    * legado com 2 colunas (Programa + Icone). Nome preservado para
    * compatibilidade com o pipeline de migracao multi-fase.
    *==========================================================================
        THIS.ConfigurarGrid()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *==========================================================================
    * OPERACIONAL flat: nao existe PageFrame com Page2(Dados) de entrada de
    * campos. A "area de dados" do SIGCDICN legado eh o CommandGroup
    * Botao_okcancel: botao Ok persiste as alteracoes acumuladas no cursor
    * do grid (via ICNBO.SalvarAlteracoes) e botao Encerrar cancela sem
    * persistir. Estas sao as unicas acoes de escrita sobre os dados no form.
    * Nome preservado para compatibilidade com o pipeline de migracao.
    *==========================================================================
        THIS.ConfigurarBotoesAcao()
    ENDPROC

    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
    *==========================================================================
    * OPERACIONAL flat: form nao possui multiplas paginas para alternar.
    * O legado SIGCDICN opera em unica tela (grid + Botao_okcancel). Este
    * metodo eh mantido por compatibilidade com o pipeline de migracao e,
    * quando invocado, executa refresh do grid principal e devolve foco -
    * comportamento equivalente a "voltar para a lista" em forms CRUD.
    *==========================================================================
        TRY
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND ;
               VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *==========================================================================
    * Cria cnt_4c_Cabecalho com lbl_4c_Sombra (sombra preta) e lbl_4c_Titulo
    * (texto branco) - replica cntSombra/lblSombra/lblTitulo do legado
    *==========================================================================
        LOCAL loc_oCab
        TRY
            THIS.AddObject("cnt_4c_Cabecalho", "Container")
            loc_oCab = THIS.cnt_4c_Cabecalho
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            loc_oCab.AddObject("lbl_4c_Sombra", "Label")
            WITH loc_oCab.lbl_4c_Sombra
                .AutoSize   = .F.
                .Top        = 18
                .Left       = 10
                .Width      = loc_oCab.Width - 20
                .Height     = 40
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .FontItalic = .F.
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .ForeColor  = RGB(0, 0, 0)
                .Caption    = ""
                .Visible    = .T.
            ENDWITH

            loc_oCab.AddObject("lbl_4c_Titulo", "Label")
            WITH loc_oCab.lbl_4c_Titulo
                .AutoSize   = .F.
                .Top        = 17
                .Left       = 10
                .Width      = loc_oCab.Width - 20
                .Height     = 46
                .FontBold   = .T.
                .FontName   = "Tahoma"
                .FontSize   = 18
                .FontItalic = .F.
                .WordWrap   = .T.
                .Alignment  = 0
                .BackStyle  = 0
                .ForeColor  = RGB(255, 255, 255)
                .Caption    = ""
                .Visible    = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarGrid()
    *==========================================================================
    * Cria grd_4c_Dados com 2 colunas: Programa (descricaos) e Icone (barrapict)
    * ReadOnly=.T. - edicao ocorre via FormSIGPRCIC aberto por DblClick/ENTER
    * Largura colunas: 661 (descricaos) + 238 (barrapict) + scroll = 941px total
    *==========================================================================
        LOCAL loc_oGrid
        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            loc_oGrid = THIS.grd_4c_Dados
            WITH loc_oGrid
                .Top               = 114
                .Left              = 30
                .Width             = 941
                .Height            = 432
                .ColumnCount       = 2
                .FontName          = "Tahoma"
                .FontSize          = 8
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .GridLineColor     = RGB(238, 238, 238)
                .RowHeight         = 15
                .HeaderHeight      = 15
                .ScrollBars        = 2
                .ReadOnly          = .T.
                .LinkMaster        = ""
                .RelationalExpr    = ""
            ENDWITH

            WITH loc_oGrid.Column1
                .Width     = 661
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
            ENDWITH
            WITH loc_oGrid.Column1.Header1
                .Caption   = "Programa"
                .FontName  = "Arial"
                .FontSize  = 8
                .Alignment = 2
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH loc_oGrid.Column1.Text1
                .FontName    = "Courier New"
                .FontSize    = 9
                .BorderStyle = 0
                .Margin      = 0
                .Format      = "K"
                .ReadOnly    = .T.
                .Alignment   = 3
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
                .Visible     = .T.
            ENDWITH

            WITH loc_oGrid.Column2
                .Width     = 238
                .Movable   = .F.
                .Resizable = .F.
                .ReadOnly  = .T.
            ENDWITH
            WITH loc_oGrid.Column2.Header1
                .Caption   = CHR(205) + "cone"
                .FontName  = "Arial"
                .FontSize  = 8
                .Alignment = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
            WITH loc_oGrid.Column2.Text1
                .FontName    = "Courier New"
                .FontSize    = 9
                .BorderStyle = 0
                .Margin      = 0
                .Format      = "K"
                .ReadOnly    = .T.
                .Alignment   = 3
                .ForeColor   = RGB(0, 0, 0)
                .BackColor   = RGB(255, 255, 255)
                .Visible     = .T.
            ENDWITH

            *-- Eventos: DblClick e ENTER em qualquer celula abrem FormSIGPRCIC
            BINDEVENT(loc_oGrid.Column1.Text1, "DblClick", THIS, "GrdDadosDblClick")
            BINDEVENT(loc_oGrid.Column1.Text1, "KeyPress", THIS, "GrdDadosKeyPress")
            BINDEVENT(loc_oGrid.Column2.Text1, "DblClick", THIS, "GrdDadosDblClick")
            BINDEVENT(loc_oGrid.Column2.Text1, "KeyPress", THIS, "GrdDadosKeyPress")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.ConfigurarGrid")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
    *==========================================================================
    * Cria cmg_4c_BotoesAcao (replica Botao_okcancel do legado):
    *   Buttons(1) = Ok  -> SalvarAlteracoes + Release
    *   Buttons(2) = Encerrar -> confirmar cancelamento + Release
    * Posicao: Top=0, Left=833 (mesmo Right margin do legado em 800px)
    *==========================================================================
        LOCAL loc_oCmg
        TRY
            THIS.AddObject("cmg_4c_BotoesAcao", "CommandGroup")
            loc_oCmg = THIS.cmg_4c_BotoesAcao
            WITH loc_oCmg
                .ButtonCount  = 2
                .BackStyle    = 0
                .BorderStyle  = 0
                .SpecialEffect = 1
                .Height       = 85
                .Left         = 833
                .Top          = 0
                .Width        = 160
            ENDWITH

            WITH loc_oCmg.Buttons(1)
                .Top         = 5
                .Left        = 5
                .Height      = 75
                .Width       = 75
                .Caption     = "\<Ok"
                .ToolTipText = "Confirmar"
                .Picture     = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .WordWrap    = .T.
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            WITH loc_oCmg.Buttons(2)
                .Top         = 5
                .Left        = 80
                .Height      = 75
                .Width       = 75
                .Caption     = "Encerrar"
                .ToolTipText = "[ESC] Cancelar"
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel      = .T.
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Tahoma"
                .FontSize    = 8
                .WordWrap    = .T.
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH

            BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnOkClick")
            BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarDados()
    *==========================================================================
    * Chama ICNBO.InicializarDados() e vincula cursor_4c_ProgFiltrado ao grid
    * Replicas: RecordSource + ControlSource das colunas + Refresh
    *==========================================================================
        LOCAL loc_oGrid, loc_cCursor
        TRY
            *-- Sem conexao ativa (testes automatizados com gnConnHandle=0),
            *-- SQLEXEC tentaria nova conexao TCP bloqueando 300s (TCP timeout SO)
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                RETURN
            ENDIF
            IF NOT THIS.this_oBusinessObject.InicializarDados()
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar dados de " + ;
                         CHR(237) + "cones.", "Aviso")
            ELSE
                loc_cCursor = THIS.this_oBusinessObject.this_cCursorProgFiltrado
                loc_oGrid   = THIS.grd_4c_Dados
                loc_oGrid.ColumnCount = 2
                loc_oGrid.RecordSource = loc_cCursor
                WITH loc_oGrid
                    .Column1.ControlSource    = loc_cCursor + ".descricaos"
                    .Column2.ControlSource    = loc_cCursor + ".barrapict"
                    .Column1.Header1.Caption  = "Programa"
                    .Column2.Header1.Caption  = CHR(205) + "cone"
                    .Visible                  = .T.
                    .Refresh()
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.CarregarDados")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE GrdDadosDblClick()
    *==========================================================================
    * Handler DblClick em qualquer coluna do grid -> abre FormSIGPRCIC para
    * escolha de icone do programa corrente
    *==========================================================================
        LOCAL loc_cCursorIcones, loc_cCursor, loc_cPkChaves, loc_oFormPic
        TRY
            loc_cCursorIcones = THIS.this_oBusinessObject.this_cCursorIcones
            IF NOT USED(loc_cCursorIcones) OR RECCOUNT(loc_cCursorIcones) = 0
                MsgAviso("Nenhum registro de " + CHR(237) + "cone encontrado.", "Aviso")
            ELSE
                loc_cCursor   = THIS.this_oBusinessObject.this_cCursorProgFiltrado
                loc_cPkChaves = ""
                IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                    SELECT (loc_cCursor)
                    loc_cPkChaves = ALLTRIM(pkChaves)
                ENDIF
                IF NOT EMPTY(loc_cPkChaves)
                    loc_oFormPic = CREATEOBJECT("FormSIGPRCIC", THIS, loc_cPkChaves)
                    IF VARTYPE(loc_oFormPic) = "O"
                        loc_oFormPic.Show()
                    ELSE
                        MsgErro("Falha ao criar FormSIGPRCIC." + CHR(13) + ;
                                "VARTYPE retornou: " + VARTYPE(loc_oFormPic), ;
                                "Erro em GrdDadosDblClick")
                    ENDIF
                    *-- Atualizar grid apos retorno de FormSIGPRCIC
                    IF USED(loc_cCursor)
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.GrdDadosDblClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE GrdDadosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
    *==========================================================================
    * Handler KeyPress nas TextBoxes do grid: ENTER (13) abre FormSIGPRCIC
    *==========================================================================
        IF par_nKeyCode = 13
            THIS.GrdDadosDblClick()
        ENDIF
    ENDPROC

    *==========================================================================
    PROCEDURE BtnIncluirClick()
    *==========================================================================
    * OPERACIONAL: nao ha "inserir novo registro" - a lista de programas em
    * sigcdprg eh fixa. "Incluir" neste contexto significa atribuir um icone
    * a um programa que ainda nao tem (barrapict vazio). Delega para o mesmo
    * fluxo do DblClick: abre FormSIGPRCIC para escolha do icone do programa
    * selecionado na linha corrente do grid.
    *==========================================================================
        TRY
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
            THIS.GrdDadosDblClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnAlterarClick()
    *==========================================================================
    * OPERACIONAL: "alterar" no contexto de icones = trocar o icone atribuido
    * ao programa selecionado. Delega para GrdDadosDblClick, que abre
    * FormSIGPRCIC com o pkchaves do registro corrente do grid.
    *==========================================================================
        TRY
            IF VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
            THIS.GrdDadosDblClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnVisualizarClick()
    *==========================================================================
    * OPERACIONAL: exibe informacoes do icone atribuido ao programa corrente
    * no grid (nome do arquivo em barrapict). Nao abre editor - apenas mostra
    * o valor atual. Se nao ha registro selecionado, avisa o usuario.
    *==========================================================================
        LOCAL loc_cCursor, loc_cPrograma, loc_cIcone, loc_cMsg
        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorProgFiltrado
            IF NOT USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                MsgAviso("Nenhum registro carregado no grid.", "Visualizar")
            ELSE
                SELECT (loc_cCursor)
                loc_cPrograma = ALLTRIM(descricaos)
                loc_cIcone    = ALLTRIM(barrapict)
                IF EMPTY(loc_cIcone)
                    loc_cMsg = "Programa: " + loc_cPrograma + CHR(13) + ;
                               CHR(205) + "cone: (nenhum atribu" + CHR(237) + "do)"
                ELSE
                    loc_cMsg = "Programa: " + loc_cPrograma + CHR(13) + ;
                               CHR(205) + "cone: " + loc_cIcone
                ENDIF
                MsgInfo(loc_cMsg, "Visualizar " + CHR(205) + "cone")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnExcluirClick()
    *==========================================================================
    * OPERACIONAL: "excluir" no contexto de icones = remover a atribuicao
    * do icone do programa selecionado (limpar barrapict/barraforms no
    * cursor). A persistencia ocorre ao clicar Ok. Nao remove o registro
    * de sigcdprg (a lista de programas eh fixa).
    *==========================================================================
        LOCAL loc_cCursor, loc_cPrograma, loc_cIcone, loc_lConfirma
        TRY
            loc_cCursor = THIS.this_oBusinessObject.this_cCursorProgFiltrado
            IF NOT USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                MsgAviso("Nenhum registro carregado no grid.", "Excluir")
            ELSE
                SELECT (loc_cCursor)
                loc_cPrograma = ALLTRIM(descricaos)
                loc_cIcone    = ALLTRIM(barrapict)
                IF EMPTY(loc_cIcone)
                    MsgAviso("O programa " + CHR(34) + loc_cPrograma + CHR(34) + ;
                             " n" + CHR(227) + "o possui " + CHR(237) + ;
                             "cone atribu" + CHR(237) + "do.", ;
                             "Excluir")
                ELSE
                    loc_lConfirma = MsgConfirma("Remover o " + CHR(237) + "cone " + CHR(34) + ;
                                                loc_cIcone + CHR(34) + " do programa " + CHR(34) + ;
                                                loc_cPrograma + CHR(34) + "?", ;
                                                "Confirmar Exclus" + CHR(227) + "o")
                    IF loc_lConfirma
                        REPLACE barrapict  WITH "" IN (loc_cCursor)
                        REPLACE barraforms WITH "" IN (loc_cCursor)
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnOkClick()
    *==========================================================================
    * Persiste todas as alteracoes de icones via ICNBO.SalvarAlteracoes()
    * e fecha o form. Se falhar, permanece aberto (usuario pode tentar de novo)
    *==========================================================================
        LOCAL loc_lSucesso
        TRY
            IF THIS.this_oBusinessObject.SalvarAlteracoes()
                THIS.Release()
            ELSE
                MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + ;
                         "vel salvar as altera" + CHR(231) + CHR(245) + "es.", "Aviso")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.BtnOkClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnEncerrarClick()
    *==========================================================================
    * Confirma cancelamento (mesmo comportamento do legado) e fecha sem salvar
    *==========================================================================
        LOCAL loc_lConfirma
        TRY
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lConfirma = .T.
            ELSE
                loc_lConfirma = MsgConfirma("Confirma o cancelamento?", "Cancelamento")
            ENDIF
            IF loc_lConfirma
                THIS.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *==========================================================================
    * Torna visiveis todos os controles recursivamente.
    * Sem filtro de containers ocultos - este form nao usa containers flutuantes.
    *==========================================================================
        LOCAL loc_nI, loc_oControl, loc_nP
        IF VARTYPE(par_oContainer) != "O"
            par_oContainer = THIS
        ENDIF
        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
    * Limpa arquivos temporarios de icones e libera o BO antes de fechar
    *==========================================================================
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparArquivosTemp()
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarLista()
    *==========================================================================
    * Pipeline alias: delega para CarregarDados() (unica "lista" do form flat)
    *==========================================================================
        THIS.CarregarDados()
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
    *==========================================================================
    * Carrega propriedades do BO a partir do registro corrente do cursor do grid.
    * Neste form OPERACIONAL a "edicao" ocorre via FormSIGPRCIC (DblClick/ENTER);
    * este metodo sincroniza o BO com o estado atual do cursor para auditoria.
    *==========================================================================
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.CarregarDoCursor( ;
                    THIS.this_oBusinessObject.this_cCursorProgFiltrado)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.FormParaBO")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
    *==========================================================================
    * Grid esta vinculado diretamente ao cursor; refresh propaga qualquer
    * alteracao do BO de volta para a exibicao.
    *==========================================================================
        TRY
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND ;
               VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Refresh()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE HabilitarCampos(par_cModo)
    *==========================================================================
    * OPERACIONAL: grid e ReadOnly; edicao exclusivamente via FormSIGPRCIC.
    * Garante apenas que grid e botoes de acao estejam habilitados/visiveis.
    *==========================================================================
        TRY
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND ;
               VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.Enabled = .T.
            ENDIF
            IF PEMSTATUS(THIS, "cmg_4c_BotoesAcao", 5) AND ;
               VARTYPE(THIS.cmg_4c_BotoesAcao) = "O"
                WITH THIS.cmg_4c_BotoesAcao
                    .Buttons(1).Enabled = .T.
                    .Buttons(2).Enabled = .T.
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.HabilitarCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE LimparCampos()
    *==========================================================================
    * Recarrega os dados do banco, descartando alteracoes nao salvas no cursor.
    *==========================================================================
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.CarregarDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.LimparCampos")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE AjustarBotoesPorModo(par_cModo)
    *==========================================================================
    * OPERACIONAL: sem modos CRUD. Garante botoes Ok/Encerrar habilitados.
    *==========================================================================
        TRY
            IF PEMSTATUS(THIS, "cmg_4c_BotoesAcao", 5) AND ;
               VARTYPE(THIS.cmg_4c_BotoesAcao) = "O"
                WITH THIS.cmg_4c_BotoesAcao
                    .Buttons(1).Enabled = .T.
                    .Buttons(2).Enabled = .T.
                    .Visible = .T.
                ENDWITH
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnBuscarClick()
    *==========================================================================
    * OPERACIONAL: form nao tem botao Buscar dedicado. Recarrega a lista de
    * programas do banco (equivalente a "atualizar"), devolvendo foco ao grid.
    *==========================================================================
        TRY
            THIS.CarregarDados()
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND ;
               VARTYPE(THIS.grd_4c_Dados) = "O"
                THIS.grd_4c_Dados.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormICN.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROCEDURE BtnSalvarClick()
    *==========================================================================
    * Alias de pipeline: delega para BtnOkClick (persistir + fechar).
    *==========================================================================
        THIS.BtnOkClick()
    ENDPROC

    *==========================================================================
    PROCEDURE BtnCancelarClick()
    *==========================================================================
    * Alias de pipeline: delega para BtnEncerrarClick (confirmar cancelamento).
    *==========================================================================
        THIS.BtnEncerrarClick()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ICNBO.prg):
*==============================================================================
* ICNBO.prg - Business Object para Icones de Acesso (sigcdprg)
* Form OPERACIONAL: gerencia atribuicao de icones aos programas do sistema
* Herda de: BusinessBase
* Tabela: sigcdprg | PK: pkchaves
*==============================================================================
DEFINE CLASS ICNBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela     = "sigcdprg"
    this_cCampoChave = "pkchaves"

    *-- Cursores utilizados pelo form
    this_cCursorProg         = "cursor_4c_Prog"
    this_cCursorProgFiltrado = "cursor_4c_ProgFiltrado"
    this_cCursorIcones       = "cursor_4c_Icones"

    *-- Diretorio temporario para arquivos .ico extraidos de SigSyIco.marqicones
    this_cDirTmp = ""

    *-- Indica se as alteracoes foram confirmadas pelo usuario
    this_lSalvo = .F.

    *-- Propriedades do registro corrente (CarregarDoCursor / ObterChavePrimaria)
    this_cDescricaos = ""
    this_cProgramas  = ""
    this_cBarrapict  = ""
    this_cBarraforms = ""
    this_cParametros = ""
    this_cPkChaves   = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE InicializarDados()
    *==========================================================================
    * Carrega programas e icones do banco para os cursores de trabalho
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.CarregarProgramas()
                loc_lSucesso = THIS.CarregarIcones()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarProgramas()
    *==========================================================================
    * Busca sigcdprg e cria cursor_4c_Prog (todos) e cursor_4c_ProgFiltrado
    * (apenas registros com descricaos preenchida, exibido no Grid)
    *==========================================================================
        LOCAL loc_cSQL, loc_lSucesso, loc_nRet, loc_cCursorSrc, loc_cCursorDst
        loc_lSucesso  = .F.
        loc_cCursorSrc = THIS.this_cCursorProg
        loc_cCursorDst = THIS.this_cCursorProgFiltrado
        TRY
            IF USED(THIS.this_cCursorProg)
                USE IN (THIS.this_cCursorProg)
            ENDIF
            IF USED(THIS.this_cCursorProgFiltrado)
                USE IN (THIS.this_cCursorProgFiltrado)
            ENDIF

            loc_cSQL = "SELECT a.descricaos, a.programas, a.barrapict, " + ;
                       "a.barraforms, a.pkChaves " + ;
                       "FROM sigcdprg a " + ;
                       "ORDER BY a.descricaos"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProg)

            IF loc_nRet > 0 AND USED(THIS.this_cCursorProg)
                SELECT (THIS.this_cCursorProg)
                INDEX ON pkChaves TAG pkChaves
                REPLACE ALL barrapict WITH LOWER(ALLTRIM(JUSTFNAME(barrapict)))
                SET ORDER TO ""
                GO TOP

                SELECT a.descricaos, a.programas, a.barrapict, a.barraforms, a.pkChaves ;
                    FROM (loc_cCursorSrc) a ;
                    WHERE NOT EMPTY(a.descricaos) ;
                    ORDER BY a.descricaos ;
                    INTO CURSOR (loc_cCursorDst) READWRITE
                INDEX ON pkChaves TAG pkChaves
                SET ORDER TO ""
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de programas do sistema.", ;
                        "Erro em CarregarProgramas")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarProgramas")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarIcones()
    *==========================================================================
    * Busca SigSyIco e extrai cada icone para arquivo .ico em diretorio temp
    *==========================================================================
        LOCAL loc_cSQL, loc_lSucesso, loc_nRet, loc_cArqIcone, loc_nTamIcone
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorIcones)
                USE IN (THIS.this_cCursorIcones)
            ENDIF

            THIS.this_cDirTmp = ADDBS(SYS(2023))

            loc_cSQL = "SELECT a.carqicones, a.marqicones, " + ;
                       "SPACE(255) AS ctmpicones " + ;
                       "FROM SigSyIco a " + ;
                       "ORDER BY a.carqicones"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorIcones)

            IF loc_nRet > 0 AND USED(THIS.this_cCursorIcones)
                SELECT (THIS.this_cCursorIcones)
                INDEX ON carqicones TAG carqicones
                SET ORDER TO ""
                GO TOP

                IF NOT EOF(THIS.this_cCursorIcones)
                    INSERT INTO (THIS.this_cCursorIcones) (carqicones) VALUES (' < Nenhum >')
                ENDIF
                GO TOP IN (THIS.this_cCursorIcones)

                SELECT (THIS.this_cCursorIcones)
                SCAN
                    IF NOT EMPTY(ALLTRIM(carqicones))
                        loc_cArqIcone  = THIS.this_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
                        loc_nTamIcone = STRTOFILE(marqicones, loc_cArqIcone)
                        IF loc_nTamIcone > 0
                            REPLACE ctmpicones WITH loc_cArqIcone IN (THIS.this_cCursorIcones)
                        ENDIF
                    ENDIF
                ENDSCAN

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de " + CHR(237) + "cones do sistema.", ;
                        "Erro em CarregarIcones")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarIcones")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE SalvarAlteracoes()
    *==========================================================================
    * Persiste todas as alteracoes de icones em sigcdprg (UPDATE em massa)
    * Itera por todos os registros de cursor_4c_Prog e chama THIS.Atualizar()
    * para cada linha, dentro de uma transacao unica
    *==========================================================================
        LOCAL loc_lSucesso, loc_lTransacaoAberta, loc_lErroScan
        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroScan        = .F.
        TRY
            IF NOT USED(THIS.this_cCursorProg)
                MsgErro("Cursor de programas n" + CHR(227) + "o inicializado.", ;
                        "Erro em SalvarAlteracoes")
            ELSE
                SQLSETPROP(gnConnHandle, "Transactions", 2)
                loc_lTransacaoAberta = .T.

                SELECT (THIS.this_cCursorProg)
                SET ORDER TO ""
                GO TOP

                SCAN
                    IF NOT THIS.CarregarDoCursor(THIS.this_cCursorProg)
                        loc_lErroScan = .T.
                        EXIT
                    ENDIF
                    IF NOT THIS.Atualizar()
                        loc_lErroScan = .T.
                        MsgErro("Erro ao salvar programa " + ALLTRIM(THIS.this_cDescricaos) + ;
                                " (chave: " + ALLTRIM(THIS.this_cPkChaves) + ")" + CHR(13) + ;
                                THIS.this_cMensagemErro, ;
                                "Erro em SalvarAlteracoes")
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_lErroScan
                    SQLTRANSACT(gnConnHandle, "ROLLBACK")
                ELSE
                    SQLTRANSACT(gnConnHandle, "COMMIT")
                    THIS.this_lSalvo = .T.
                    loc_lSucesso = .T.
                ENDIF
                SQLSETPROP(gnConnHandle, "Transactions", 1)
                loc_lTransacaoAberta = .F.
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
                SQLSETPROP(gnConnHandle, "Transactions", 1)
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SalvarAlteracoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
    * INSERT em sigcdprg com propriedades correntes (this_cPkChaves,
    * this_cDescricaos, this_cProgramas, this_cBarrapict, this_cBarraforms,
    * this_cParametros). Todas as colunas da tabela sao NOT NULL char.
    *==========================================================================
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria " + ;
                    "(pkChaves) obrigat" + CHR(243) + "ria para inserir."
            ELSE
                loc_cSQL = "INSERT INTO sigcdprg " + ;
                           "(barraforms, barrapict, descricaos, parametros, programas, pkchaves) " + ;
                           "VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cBarraforms)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cBarrapict))  + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDescricaos)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cParametros)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cProgramas))  + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cPkChaves))   + ")"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao inserir registro em sigcdprg."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
    * UPDATE em sigcdprg (barrapict, barraforms) filtrado por pkChaves.
    * Usado individualmente pelo form (SalvarAlteracoes itera cursor e chama)
    *==========================================================================
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria " + ;
                    "(pkChaves) obrigat" + CHR(243) + "ria para atualizar."
            ELSE
                loc_cSQL = "UPDATE sigcdprg SET " + ;
                           "barrapict = "  + EscaparSQL(ALLTRIM(THIS.this_cBarrapict))  + ", " + ;
                           "barraforms = " + EscaparSQL(ALLTRIM(THIS.this_cBarraforms)) + " " + ;
                           "WHERE pkchaves = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar registro em sigcdprg."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    * Carrega propriedades do BO a partir do registro corrente de um cursor
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDescricaos = TratarNulo(descricaos, "C")
                THIS.this_cProgramas  = TratarNulo(programas,  "C")
                THIS.this_cBarrapict  = TratarNulo(barrapict,  "C")
                THIS.this_cBarraforms = TratarNulo(barraforms,  "C")
                THIS.this_cPkChaves   = TratarNulo(pkChaves,   "C")
                IF TYPE(par_cAliasCursor + ".parametros") == "C"
                    THIS.this_cParametros = TratarNulo(EVALUATE(par_cAliasCursor + ".parametros"), "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE LimparArquivosTemp()
    *==========================================================================
    * Remove arquivos .ico temporarios criados durante o carregamento de icones
    *==========================================================================
        LOCAL loc_cArqIcone
        TRY
            IF USED(THIS.this_cCursorIcones)
                SELECT (THIS.this_cCursorIcones)
                SET ORDER TO ""
                GO TOP
                SCAN
                    loc_cArqIcone = ALLTRIM(ctmpicones)
                    IF NOT EMPTY(loc_cArqIcone) AND FILE(loc_cArqIcone)
                        DELETE FILE (loc_cArqIcone)
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em LimparArquivosTemp")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        TRY
            THIS.LimparArquivosTemp()
            IF USED(THIS.this_cCursorIcones)
                USE IN (THIS.this_cCursorIcones)
            ENDIF
            IF USED(THIS.this_cCursorProgFiltrado)
                USE IN (THIS.this_cCursorProgFiltrado)
            ENDIF
            IF USED(THIS.this_cCursorProg)
                USE IN (THIS.this_cCursorProg)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE

