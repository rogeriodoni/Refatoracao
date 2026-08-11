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
[2026-08-09 02:08:49] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 02:08:49] [INFO] Config FPW: (nao fornecido)
[2026-08-09 02:08:49] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 02:08:49] [INFO] Timeout: 300 segundos
[2026-08-09 02:08:49] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5cl0vxmv.prg
[2026-08-09 02:08:49] [INFO] Conteudo do wrapper:
[2026-08-09 02:08:49] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'
QUIT

[2026-08-09 02:08:49] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5cl0vxmv.prg
[2026-08-09 02:08:49] [INFO] VFP output esperado em: C:\4c\tasks\task446\vfp_output.txt
[2026-08-09 02:08:49] [INFO] Executando Visual FoxPro 9...
[2026-08-09 02:08:49] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5cl0vxmv.prg
[2026-08-09 02:08:49] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5cl0vxmv.prg
[2026-08-09 02:08:49] [INFO] Timeout configurado: 300 segundos
[2026-08-09 02:13:49] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 10236)...
[2026-08-09 02:13:51] [INFO] VFP9 finalizado em 302.0540998 segundos
[2026-08-09 02:13:51] [INFO] Exit Code: 4
[2026-08-09 02:13:51] [INFO] 
[2026-08-09 02:13:51] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 02:13:51] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5cl0vxmv.prg
[2026-08-09 02:13:51] [INFO] 
[2026-08-09 02:13:51] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 02:13:51] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 02:13:51] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 02:13:51] [INFO] * Parameters: 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'
[2026-08-09 02:13:51] [INFO] 
[2026-08-09 02:13:51] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 02:13:51] [INFO] SET SAFETY OFF
[2026-08-09 02:13:51] [INFO] SET RESOURCE OFF
[2026-08-09 02:13:51] [INFO] SET TALK OFF
[2026-08-09 02:13:51] [INFO] SET NOTIFY OFF
[2026-08-09 02:13:51] [INFO] SYS(2335, 0)
[2026-08-09 02:13:51] [INFO] 
[2026-08-09 02:13:51] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'
[2026-08-09 02:13:51] [INFO] QUIT
[2026-08-09 02:13:51] [INFO] 
[2026-08-09 02:13:51] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 02:13:51] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 02:48:00] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 02:48:00] [INFO] Config FPW: (nao fornecido)
[2026-08-09 02:48:00] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 02:48:00] [INFO] Timeout: 300 segundos
[2026-08-09 02:48:00] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5totlpwu.prg
[2026-08-09 02:48:00] [INFO] Conteudo do wrapper:
[2026-08-09 02:48:00] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'
QUIT

[2026-08-09 02:48:00] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5totlpwu.prg
[2026-08-09 02:48:00] [INFO] VFP output esperado em: C:\4c\tasks\task446\vfp_output.txt
[2026-08-09 02:48:00] [INFO] Executando Visual FoxPro 9...
[2026-08-09 02:48:00] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5totlpwu.prg
[2026-08-09 02:48:00] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5totlpwu.prg
[2026-08-09 02:48:00] [INFO] Timeout configurado: 300 segundos
[2026-08-09 02:53:00] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 1056)...
[2026-08-09 02:53:02] [INFO] VFP9 finalizado em 302.0701603 segundos
[2026-08-09 02:53:02] [INFO] Exit Code: 4
[2026-08-09 02:53:02] [INFO] 
[2026-08-09 02:53:02] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 02:53:02] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_5totlpwu.prg
[2026-08-09 02:53:02] [INFO] 
[2026-08-09 02:53:02] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 02:53:02] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 02:53:02] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 02:53:02] [INFO] * Parameters: 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'
[2026-08-09 02:53:02] [INFO] 
[2026-08-09 02:53:02] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 02:53:02] [INFO] SET SAFETY OFF
[2026-08-09 02:53:02] [INFO] SET RESOURCE OFF
[2026-08-09 02:53:02] [INFO] SET TALK OFF
[2026-08-09 02:53:02] [INFO] SET NOTIFY OFF
[2026-08-09 02:53:02] [INFO] SYS(2335, 0)
[2026-08-09 02:53:02] [INFO] 
[2026-08-09 02:53:02] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'
[2026-08-09 02:53:02] [INFO] QUIT
[2026-08-09 02:53:02] [INFO] 
[2026-08-09 02:53:02] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 02:53:02] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 03:08:29] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 03:08:29] [INFO] Config FPW: (nao fornecido)
[2026-08-09 03:08:29] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 03:08:29] [INFO] Timeout: 300 segundos
[2026-08-09 03:08:29] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fi4nq0l1.prg
[2026-08-09 03:08:29] [INFO] Conteudo do wrapper:
[2026-08-09 03:08:29] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'
QUIT

[2026-08-09 03:08:29] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fi4nq0l1.prg
[2026-08-09 03:08:29] [INFO] VFP output esperado em: C:\4c\tasks\task446\vfp_output.txt
[2026-08-09 03:08:29] [INFO] Executando Visual FoxPro 9...
[2026-08-09 03:08:29] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fi4nq0l1.prg
[2026-08-09 03:08:29] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fi4nq0l1.prg
[2026-08-09 03:08:29] [INFO] Timeout configurado: 300 segundos
[2026-08-09 03:13:29] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 14424)...
[2026-08-09 03:13:31] [INFO] VFP9 finalizado em 302.0699438 segundos
[2026-08-09 03:13:31] [INFO] Exit Code: 4
[2026-08-09 03:13:31] [INFO] 
[2026-08-09 03:13:31] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 03:13:31] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_fi4nq0l1.prg
[2026-08-09 03:13:31] [INFO] 
[2026-08-09 03:13:31] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 03:13:31] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 03:13:31] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 03:13:31] [INFO] * Parameters: 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'
[2026-08-09 03:13:31] [INFO] 
[2026-08-09 03:13:31] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 03:13:31] [INFO] SET SAFETY OFF
[2026-08-09 03:13:31] [INFO] SET RESOURCE OFF
[2026-08-09 03:13:31] [INFO] SET TALK OFF
[2026-08-09 03:13:31] [INFO] SET NOTIFY OFF
[2026-08-09 03:13:31] [INFO] SYS(2335, 0)
[2026-08-09 03:13:31] [INFO] 
[2026-08-09 03:13:31] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICD', 'C:\4c\tasks\task446', 'OPERACIONAL'
[2026-08-09 03:13:31] [INFO] QUIT
[2026-08-09 03:13:31] [INFO] 
[2026-08-09 03:13:31] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 03:13:31] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormICD.prg):
*------------------------------------------------------------------------------
* FormICD.prg - Form Operacional: Duplicacao dos Tipo de Tributacao
* Migrado de: tasks/task446/SIGCDICD.SCX
* Tabela principal: SigPrTri
*------------------------------------------------------------------------------

DEFINE CLASS FormICD AS FormBase

    Height      = 262
    Width       = 443
    AutoCenter  = .T.
    BorderStyle = 2
    ShowWindow  = 0
    ShowWindow = 1
    ControlBox  = .F.
    Closable    = .F.
    FontName    = "Verdana"
    FontSize    = 8
    MaxButton   = .F.
    TitleBar    = 0
    WindowType  = 0
    ForeColor   = RGB(36,84,155)
    Themes      = .F.

    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    * Init - define Caption com CHR() antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.Caption = "Duplica" + CHR(231) + CHR(227) + "o dos Tipo de Tributa" + CHR(231) + CHR(227) + "o"
        *-- WindowType=1 na classe causaria TIMEOUT em VFP9 -T mode (teste automatico);
        *-- classe definida com 0 e restaurada para 1 (modal) apenas em producao.
        IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta estrutura base do form operacional
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN .T.
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("ICDBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio ICDBO.", ;
                        "Erro em InicializarForm")
                loc_lSucesso = .F.
            ENDIF

            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            THIS.ConfigurarPageFrame()

            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            THIS.TornarControlesVisiveis(THIS)
            THIS.RegistrarEventos()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra montagem visual do form OPERACIONAL
    * Nao ha PageFrame real (form nao tem Lista/Dados como CRUD); metodo delega
    * para os configuradores especificos: cabecalho escuro, campos e botoes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarCampos()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - cria container escuro superior com labels de titulo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        loc_oCab = THIS.cnt_4c_Cabecalho
        WITH loc_oCab
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100,100,100)
            .BackStyle   = 1
            .BorderWidth = 0
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 10
            .Height        = 40
            .Top           = 18
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(0,0,0)
            .Caption       = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .AutoSize      = .F.
            .Width         = loc_oCab.Width - 10
            .Height        = 46
            .Top           = 17
            .Left          = 10
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .WordWrap      = .T.
            .ForeColor     = RGB(255,255,255)
            .Caption       = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - cria container branco dos campos de entrada
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oCnt

        *-- Shape decorativo ao redor do container (top=79, left=103, w=173, h=110)
        THIS.AddObject("shp_4c_Borda", "Shape")
        WITH THIS.shp_4c_Borda
            .Top           = 79
            .Left          = 103
            .Height        = 110
            .Width         = 173
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136,189,188)
        ENDWITH

        *-- Container principal dos campos (Tipo: e Novo:)
        THIS.AddObject("cnt_4c_Container1", "Container")
        loc_oCnt = THIS.cnt_4c_Container1
        WITH loc_oCnt
            .Top           = 132
            .Left          = 84
            .Width         = 279
            .Height        = 59
            .SpecialEffect = 0
            .BackColor     = RGB(255,255,255)
            .BackStyle     = 1
            .BorderWidth   = 0
        ENDWITH

        *-- Labels "Tipo :" e "Novo :"
        loc_oCnt.AddObject("lbl_4c_RotTipo", "Label")
        WITH loc_oCnt.lbl_4c_RotTipo
            .Caption  = "Tipo :"
            .Left     = 9
            .Top      = 8
            .AutoSize = .T.
            .TabIndex = 5
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_RotNovo", "Label")
        WITH loc_oCnt.lbl_4c_RotNovo
            .Caption  = "Novo :"
            .Left     = 6
            .Top      = 34
            .AutoSize = .T.
            .TabIndex = 6
        ENDWITH

        *-- TextBoxes: linha 1 = tipo existente (Tipo + Desc)
        loc_oCnt.AddObject("txt_4c_Tipo", "TextBox")
        WITH loc_oCnt.txt_4c_Tipo
            .Value     = ""
            .MaxLength = 4
            .Height    = 23
            .Width     = 40
            .Left      = 46
            .Top       = 4
            .TabIndex  = 1
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Desc", "TextBox")
        WITH loc_oCnt.txt_4c_Desc
            .Value     = ""
            .MaxLength = 20
            .Height    = 23
            .Width     = 184
            .Left      = 90
            .Top       = 4
            .TabIndex  = 2
        ENDWITH

        *-- TextBoxes: linha 2 = novo tipo (NovoTipo + NovaDesc)
        loc_oCnt.AddObject("txt_4c_NovoTipo", "TextBox")
        WITH loc_oCnt.txt_4c_NovoTipo
            .Value     = ""
            .MaxLength = 4
            .Height    = 23
            .Width     = 40
            .Left      = 46
            .Top       = 30
            .TabIndex  = 3
        ENDWITH

        loc_oCnt.AddObject("txt_4c_NovaDesc", "TextBox")
        WITH loc_oCnt.txt_4c_NovaDesc
            .Value     = ""
            .MaxLength = 20
            .Height    = 23
            .Width     = 184
            .Left      = 90
            .Top       = 30
            .TabIndex  = 4
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cria botoes Duplicar e Encerrar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmd_4c_Duplicar", "CommandButton")
        WITH THIS.cmd_4c_Duplicar
            .Top             = 2
            .Left            = 294
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Duplicar"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .Picture         = gc_4c_CaminhoIcones + "geral_chaves_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_chaves_26.jpg"
        ENDWITH

        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 2
            .Left            = 367
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Caption         = "Encerrar"
            .ForeColor       = RGB(90,90,90)
            .BackColor       = RGB(255,255,255)
            .Themes          = .T.
            .Cancel          = .T.
            .Picture         = gc_4c_CaminhoIcones + "simbolosl_erro_26.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "simbolosl_erro_26.jpg"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - form OPERACIONAL dialogo (443x262) sem PageFrame
    * SIGCDICD eh dialogo modal de duplicacao (Tipo origem + Novo tipo),
    * NAO tem estrutura Page1=Lista/Page2=Dados nem grid de registros.
    * Layout completo esta em ConfigurarCampos() / ConfigurarBotoes().
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - form OPERACIONAL dialogo (443x262) sem PageFrame
    * SIGCDICD eh dialogo modal de duplicacao; nao tem Page2 Dados separada.
    * Todos os campos estao em ConfigurarCampos(). Metodo mantido apenas para
    * conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - form OPERACIONAL dialogo sem PageFrame; nao ha alternancia
    * entre paginas. par_nPagina eh ignorado.
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - form OPERACIONAL dialogo de duplicacao; NAO eh CRUD.
    * Nao ha botao Incluir no layout (SCX legado tem apenas Command1=Duplicar
    * e Command2=Encerrar). A acao de "incluir" nova tributacao eh feita pelo
    * CmdDuplicarClick (duplica registro origem em novo codigo).
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - form OPERACIONAL dialogo de duplicacao; NAO eh CRUD.
    * Nao ha botao Alterar no layout do SCX legado.
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - form OPERACIONAL dialogo de duplicacao; NAO eh CRUD.
    * Nao ha botao Visualizar no layout do SCX legado.
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - form OPERACIONAL dialogo de duplicacao; NAO eh CRUD.
    * Nao ha botao Excluir no layout do SCX legado.
    * Metodo mantido apenas para conformidade com contrato do pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis recursivamente
    * FILTRO: nenhum container flutuante neste form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdDuplicarClick - valida e executa duplicacao do tipo de tributacao
    *--------------------------------------------------------------------------
    PROCEDURE CmdDuplicarClick()
        LOCAL loc_cTipoOrig, loc_cNovoTipo, loc_cNovaDesc

        loc_cTipoOrig  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Tipo.Value)
        loc_cNovoTipo  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_NovoTipo.Value)
        loc_cNovaDesc  = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value)

        IF EMPTY(loc_cTipoOrig)
            MsgAviso("Informe o Tipo de origem.", "Aviso")
            THIS.cnt_4c_Container1.txt_4c_Tipo.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(loc_cNovoTipo)
            MsgAviso("Informe o novo c" + CHR(243) + "digo do Tipo.", "Aviso")
            THIS.cnt_4c_Container1.txt_4c_NovoTipo.SetFocus()
            RETURN
        ENDIF

        IF THIS.this_oBusinessObject.DuplicarTipo(loc_cTipoOrig, loc_cNovoTipo, loc_cNovaDesc)
            THIS.Release()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - fecha o form sem executar duplicacao
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTipoKeyPress - lookup de tipo existente em SigPrTri
    *--------------------------------------------------------------------------
    PROCEDURE TxtTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.ValidarTipo()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTipo - busca Tipos digitado e preenche Desc; abre lookup se nao achou
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarTipo()
        LOCAL loc_cTipo, loc_cSQL, loc_oErro

        loc_cTipo = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Tipo.Value)
        IF EMPTY(loc_cTipo)
            THIS.cnt_4c_Container1.txt_4c_Desc.Value = ""
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Tipos, Descs FROM SigPrTri " + ;
                       "WHERE tipos = " + EscaparSQL(loc_cTipo)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LkpTipo") > 0
                SELECT cursor_4c_LkpTipo
                IF !EOF()
                    THIS.cnt_4c_Container1.txt_4c_Tipo.Value    = ALLTRIM(Tipos)
                    THIS.cnt_4c_Container1.txt_4c_Desc.Value    = ALLTRIM(Descs)
                    THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value = ALLTRIM(Descs)
                    USE IN cursor_4c_LkpTipo
                    RETURN
                ENDIF
                USE IN cursor_4c_LkpTipo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ValidarTipo")
            RETURN
        ENDTRY

        THIS.AbrirLookupTipo()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupTipo - abre FormBuscaAuxiliar para SigPrTri por Tipos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupTipo()
        LOCAL loc_oLookup, loc_cValor

        loc_cValor = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Tipo.Value)

        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", ;
                                   "cursor_4c_LkpTipo", "Tipos", loc_cValor, ;
                                   "Sele" + CHR(231) + CHR(227) + "o de Tipo", .F., .T., "")
        IF VARTYPE(loc_oLookup) = "O"
            loc_oLookup.mAddColuna("Tipos", "XXXX", "Tipo")
            loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oLookup.Show()
            IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LkpTipo")
                SELECT cursor_4c_LkpTipo
                THIS.cnt_4c_Container1.txt_4c_Tipo.Value     = ALLTRIM(Tipos)
                THIS.cnt_4c_Container1.txt_4c_Desc.Value     = ALLTRIM(Descs)
                THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value = ALLTRIM(Descs)
                USE IN cursor_4c_LkpTipo
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtTipoDblClick - abre lookup de SigPrTri por Tipos via duplo clique
    *--------------------------------------------------------------------------
    PROCEDURE TxtTipoDblClick()
        THIS.AbrirLookupTipo()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDescKeyPress - lookup de tipo existente em SigPrTri por descricao
    *--------------------------------------------------------------------------
    PROCEDURE TxtDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        *-- Busca por descricao permitida apenas quando Tipo ainda nao foi preenchido
        *-- (replica comportamento do When: Empty(GetTipo.Value) = .T. -> foco permitido)
        IF !EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Tipo.Value))
            RETURN
        ENDIF
        THIS.ValidarDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDesc - busca Descs digitado e preenche Tipo; abre lookup se nao achou
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDesc()
        LOCAL loc_cDesc

        loc_cDesc = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Desc.Value)
        IF EMPTY(loc_cDesc)
            RETURN
        ENDIF

        THIS.AbrirLookupDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtDescDblClick - abre lookup de SigPrTri por Descs via duplo clique
    * Respeita comportamento When: ativo apenas quando Tipo ainda nao preenchido
    *--------------------------------------------------------------------------
    PROCEDURE TxtDescDblClick()
        IF !EMPTY(ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Tipo.Value))
            RETURN
        ENDIF
        THIS.AbrirLookupDesc()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupDesc - abre FormBuscaAuxiliar para SigPrTri por Descs
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupDesc()
        LOCAL loc_oLookup, loc_cValor

        loc_cValor = ALLTRIM(THIS.cnt_4c_Container1.txt_4c_Desc.Value)

        loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", ;
                                   "cursor_4c_LkpDesc", "Descs", loc_cValor, ;
                                   "Sele" + CHR(231) + CHR(227) + "o de Tipo", .F., .T., "")
        IF VARTYPE(loc_oLookup) = "O"
            loc_oLookup.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
            loc_oLookup.mAddColuna("Tipos", "XXXX", "Tipo")
            loc_oLookup.Show()
            IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_LkpDesc")
                SELECT cursor_4c_LkpDesc
                THIS.cnt_4c_Container1.txt_4c_Tipo.Value     = ALLTRIM(Tipos)
                THIS.cnt_4c_Container1.txt_4c_Desc.Value     = ALLTRIM(Descs)
                THIS.cnt_4c_Container1.txt_4c_NovaDesc.Value = ALLTRIM(Descs)
                USE IN cursor_4c_LkpDesc
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarEventos - vincula eventos dos controles via BINDEVENT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarEventos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1

        BINDEVENT(loc_oCnt.txt_4c_Tipo,  "KeyPress", THIS, "TxtTipoKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Tipo,  "DblClick", THIS, "TxtTipoDblClick")
        BINDEVENT(loc_oCnt.txt_4c_Desc,  "KeyPress", THIS, "TxtDescKeyPress")
        BINDEVENT(loc_oCnt.txt_4c_Desc,  "DblClick", THIS, "TxtDescDblClick")
        BINDEVENT(THIS.cmd_4c_Duplicar,  "Click",    THIS, "CmdDuplicarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,  "Click",    THIS, "CmdEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - popula propriedades do BO com valores dos campos do form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        THIS.this_oBusinessObject.this_cTipos     = ALLTRIM(loc_oCnt.txt_4c_Tipo.Value)
        THIS.this_oBusinessObject.this_cDescs     = ALLTRIM(loc_oCnt.txt_4c_Desc.Value)
        THIS.this_oBusinessObject.this_cNovoTipos = ALLTRIM(loc_oCnt.txt_4c_NovoTipo.Value)
        THIS.this_oBusinessObject.this_cNovaDescs = ALLTRIM(loc_oCnt.txt_4c_NovaDesc.Value)
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - popula campos do form com propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oCnt.txt_4c_Tipo.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
        loc_oCnt.txt_4c_Desc.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
        loc_oCnt.txt_4c_NovoTipo.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cNovoTipos)
        loc_oCnt.txt_4c_NovaDesc.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cNovaDescs)
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - habilita ou desabilita os campos de entrada
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oCnt.txt_4c_Tipo.Enabled      = par_lHabilitar
        loc_oCnt.txt_4c_Desc.Enabled      = par_lHabilitar
        loc_oCnt.txt_4c_NovoTipo.Enabled  = par_lHabilitar
        loc_oCnt.txt_4c_NovaDesc.Enabled  = par_lHabilitar
        THIS.cmd_4c_Duplicar.Enabled      = par_lHabilitar
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - limpa todos os campos de entrada
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_Container1
        loc_oCnt.txt_4c_Tipo.Value     = ""
        loc_oCnt.txt_4c_Desc.Value     = ""
        loc_oCnt.txt_4c_NovoTipo.Value = ""
        loc_oCnt.txt_4c_NovaDesc.Value = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - form OPERACIONAL dialogo sem lista de registros; contrato
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - form OPERACIONAL sem modos CRUD; contrato pipeline
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - contrato do pipeline; delega para CmdEncerrarClick
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - form OPERACIONAL dialogo sem botao Buscar; contrato
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - acao principal deste dialogo eh Duplicar; contrato
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdDuplicarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - form OPERACIONAL dialogo; contrato do pipeline
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        IF USED("cnSigPrTri")
            USE IN cnSigPrTri
        ENDIF
        IF USED("cursor_4c_CheckTipo")
            USE IN cursor_4c_CheckTipo
        ENDIF
        IF USED("cursor_4c_LkpTipo")
            USE IN cursor_4c_LkpTipo
        ENDIF
        IF USED("cursor_4c_LkpDesc")
            USE IN cursor_4c_LkpDesc
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ICDBO.prg):
*------------------------------------------------------------------------------
* ICDBO.prg - Business Object para Duplicacao de Tipo de Tributacao
* Tabela: SigPrTri
* PK: cIdChaves (char 20)
* Form associado: FormICD.prg (operacionais\)
*------------------------------------------------------------------------------

DEFINE CLASS ICDBO AS BusinessBase

    *-- Tipo de origem (registro a ser duplicado)
    this_cTipos    = ""   && char(4)  - codigo do tipo existente
    this_cDescs    = ""   && char(20) - descricao do tipo existente

    *-- Novo tipo (destino da duplicacao)
    this_cNovoTipos  = ""  && char(4)  - novo codigo do tipo
    this_cNovaDescs  = ""  && char(20) - nova descricao

    *-- Chave primaria do registro carregado (para auditoria)
    this_cCidChaves  = ""  && char(20) - PK cIdChaves

    *-- Demais campos da SigPrTri (copiados integralmente no INSERT)
    this_nAliquotas  = 0   && numeric(5,2)
    this_nBases      = 0   && numeric(5,2)
    this_cCfops      = ""  && char(10)
    this_cDestinos   = ""  && char(2)
    this_cMovs       = ""  && char(1)
    this_cOrigems    = ""  && char(2)
    this_nReduzidas  = 0   && numeric(5,2)
    this_nAliqIcmsts = 0   && numeric(5,2) - aliqicmsts (presente no schema, ausente na Fase 1)

    *-- Cursor principal
    this_cCursorDados = "cnSigPrTri"

    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrTri"
        THIS.this_cCampoChave = "cIdChaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna valor da chave primaria (requerido por BusinessBase)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves   = TratarNulo(cIdChaves,  "C")
            THIS.this_cTipos       = TratarNulo(Tipos,      "C")
            THIS.this_cDescs       = TratarNulo(Descs,      "C")
            THIS.this_nAliquotas   = TratarNulo(Aliquotas,  "N")
            THIS.this_nBases       = TratarNulo(Bases,      "N")
            THIS.this_cCfops       = TratarNulo(Cfops,      "C")
            THIS.this_cDestinos    = TratarNulo(Destinos,   "C")
            THIS.this_cMovs        = TratarNulo(Movs,       "C")
            THIS.this_cOrigems     = TratarNulo(Origems,    "C")
            THIS.this_nReduzidas   = TratarNulo(Reduzidas,  "N")
            THIS.this_nAliqIcmsts  = TratarNulo(Aliqicmsts, "N")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - carrega cursor cnSigPrTri com todos os tipos de tributacao
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cnSigPrTri")
                TABLEREVERT(.T., "cnSigPrTri")
                USE IN cnSigPrTri
            ENDIF
            loc_cSQL = "SELECT cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                       "destinos, movs, origems, reduzidas, aliqicmsts " + ;
                       "FROM SigPrTri "
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + "WHERE " + par_cFiltro + " "
            ENDIF
            loc_cSQL = loc_cSQL + "ORDER BY tipos"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cnSigPrTri") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro(CapturarErroSQL(gnConnHandle), ;
                        "Erro ao buscar tipos de tributa" + CHR(231) + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Buscar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorTipo - carrega cursor cnSigPrTri filtrado por codigo de tipo
    *               e popula propriedades do BO com os dados encontrados
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorTipo(par_cTipos)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cnSigPrTri")
                TABLEREVERT(.T., "cnSigPrTri")
                USE IN cnSigPrTri
            ENDIF
            loc_cSQL = "SELECT cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                       "destinos, movs, origems, reduzidas, aliqicmsts " + ;
                       "FROM SigPrTri " + ;
                       "WHERE tipos = " + EscaparSQL(ALLTRIM(par_cTipos))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cnSigPrTri") > 0
                SELECT cnSigPrTri
                IF !EOF()
                    THIS.CarregarDoCursor("cnSigPrTri")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao buscar tipo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em BuscarPorTipo")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarTipoExistente - retorna .T. se o tipo ja existe na SigPrTri
    *--------------------------------------------------------------------------
    FUNCTION VerificarTipoExistente(par_cTipos)
        LOCAL loc_cSQL, loc_lExiste, loc_oErro
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigPrTri " + ;
                       "WHERE tipos = " + EscaparSQL(ALLTRIM(par_cTipos))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CheckTipo") > 0
                SELECT cursor_4c_CheckTipo
                loc_lExiste = (NVL(nExiste, 0) > 0)
                USE IN cursor_4c_CheckTipo
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em VerificarTipoExistente")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * DuplicarTipo - duplica registro SigPrTri com novo codigo e descricao
    *               Logica original (Command1.Click): Requery cnSigPrTri com
    *               o tipo de origem, REPLACE ALL com novos valores + UpDate
    *               Equivalente novo: SELECT origem, INSERT com novos tipos/descs/cIdChaves
    *--------------------------------------------------------------------------
    FUNCTION DuplicarTipo(par_cTipoOrigem, par_cNovoTipo, par_cNovaDesc)
        LOCAL loc_lSucesso, loc_cSQL, loc_cNovaChave, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Validar parametros e prosseguir apenas se todos OK (sem RETURN em TRY)
            IF EMPTY(ALLTRIM(par_cTipoOrigem))
                MsgAviso("Informe o Tipo de origem para duplicar.", "Aviso")
            ELSE
                IF EMPTY(ALLTRIM(par_cNovoTipo))
                MsgAviso("Informe o novo c" + CHR(243) + "digo do Tipo.", "Aviso")
            ELSE
                IF THIS.VerificarTipoExistente(par_cNovoTipo)
                MsgAviso("Novo Tipo J" + CHR(225) + " Cadastrado.", "Aviso")
            ELSE
                IF !THIS.BuscarPorTipo(par_cTipoOrigem)
                MsgAviso("Tipo de origem n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cTipoOrigem), "Aviso")
            ELSE
                *-- Gerar nova chave primaria unica (equivalente ao fUniqueIds() do REPLACE ALL)
                loc_cNovaChave = LEFT(fUniqueIds(), 20)
                *-- INSERT do novo registro copiando todos os campos + novos tipos/descs/cIdChaves
                loc_cSQL = "INSERT INTO SigPrTri " + ;
                           "(cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                           "destinos, movs, origems, reduzidas, aliqicmsts) " + ;
                           "VALUES (" + ;
                           EscaparSQL(loc_cNovaChave) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(par_cNovoTipo), 4)) + ", " + ;
                           EscaparSQL(LEFT(ALLTRIM(par_cNovaDesc), 20)) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nAliquotas, 2) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nBases, 2) + ", " + ;
                           EscaparSQL(THIS.this_cCfops) + ", " + ;
                           EscaparSQL(THIS.this_cDestinos) + ", " + ;
                           EscaparSQL(THIS.this_cMovs) + ", " + ;
                           EscaparSQL(THIS.this_cOrigems) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nReduzidas, 2) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nAliqIcmsts, 2) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.this_cCidChaves = loc_cNovaChave
                    THIS.this_cNovoTipos = LEFT(ALLTRIM(par_cNovoTipo), 4)
                    THIS.this_cNovaDescs = LEFT(ALLTRIM(par_cNovaDesc), 20)
                    THIS.RegistrarAuditoria("DUPLICAR")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao duplicar tipo")
                ENDIF
                ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em DuplicarTipo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrTri com todos os campos populados nas
    *          propriedades this_*. Gera cIdChaves via fUniqueIds se vazio.
    *          Verifica duplicidade de Tipos antes do INSERT.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cNovaChave, loc_cTipoDestino, loc_cDescDestino, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cTipoDestino = ALLTRIM(THIS.this_cNovoTipos)
            IF EMPTY(loc_cTipoDestino)
                loc_cTipoDestino = ALLTRIM(THIS.this_cTipos)
            ENDIF
            loc_cDescDestino = ALLTRIM(THIS.this_cNovaDescs)
            IF EMPTY(loc_cDescDestino)
                loc_cDescDestino = ALLTRIM(THIS.this_cDescs)
            ENDIF
            IF EMPTY(loc_cTipoDestino)
                MsgAviso("Informe o c" + CHR(243) + "digo do Tipo.", "Aviso")
            ELSE
                IF THIS.VerificarTipoExistente(loc_cTipoDestino)
                    MsgAviso("Tipo J" + CHR(225) + " Cadastrado: " + loc_cTipoDestino, "Aviso")
                ELSE
                    loc_cNovaChave = ALLTRIM(THIS.this_cCidChaves)
                    IF EMPTY(loc_cNovaChave)
                        loc_cNovaChave = LEFT(fUniqueIds(), 20)
                    ENDIF
                    loc_cSQL = "INSERT INTO SigPrTri " + ;
                               "(cidchaves, tipos, descs, aliquotas, bases, cfops, " + ;
                               "destinos, movs, origems, reduzidas, aliqicmsts) " + ;
                               "VALUES (" + ;
                               EscaparSQL(loc_cNovaChave) + ", " + ;
                               EscaparSQL(LEFT(loc_cTipoDestino, 4)) + ", " + ;
                               EscaparSQL(LEFT(loc_cDescDestino, 20)) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nAliquotas, 2) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nBases, 2) + ", " + ;
                               EscaparSQL(THIS.this_cCfops) + ", " + ;
                               EscaparSQL(THIS.this_cDestinos) + ", " + ;
                               EscaparSQL(THIS.this_cMovs) + ", " + ;
                               EscaparSQL(THIS.this_cOrigems) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nReduzidas, 2) + ", " + ;
                               FormatarNumeroSQL(THIS.this_nAliqIcmsts, 2) + ;
                               ")"
                    IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                        THIS.this_cCidChaves = loc_cNovaChave
                        THIS.this_cTipos     = LEFT(loc_cTipoDestino, 4)
                        THIS.this_cDescs     = LEFT(loc_cDescDestino, 20)
                        THIS.RegistrarAuditoria("INCLUSAO")
                        loc_lSucesso = .T.
                    ELSE
                        MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao inserir tipo de tributa" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrTri para o registro identificado por
    *            this_cCidChaves (PK). Usado quando o BO precisa persistir
    *            alteracoes em um registro previamente carregado.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                MsgAviso("Nenhum registro carregado para atualizar.", "Aviso")
            ELSE
                loc_cSQL = "UPDATE SigPrTri SET " + ;
                           "tipos = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipos), 4)) + ", " + ;
                           "descs = "      + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 20)) + ", " + ;
                           "aliquotas = "  + FormatarNumeroSQL(THIS.this_nAliquotas, 2) + ", " + ;
                           "bases = "      + FormatarNumeroSQL(THIS.this_nBases, 2) + ", " + ;
                           "cfops = "      + EscaparSQL(THIS.this_cCfops) + ", " + ;
                           "destinos = "   + EscaparSQL(THIS.this_cDestinos) + ", " + ;
                           "movs = "       + EscaparSQL(THIS.this_cMovs) + ", " + ;
                           "origems = "    + EscaparSQL(THIS.this_cOrigems) + ", " + ;
                           "reduzidas = "  + FormatarNumeroSQL(THIS.this_nReduzidas, 2) + ", " + ;
                           "aliqicmsts = " + FormatarNumeroSQL(THIS.this_nAliqIcmsts, 2) + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    THIS.RegistrarAuditoria("ALTERACAO")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro(CapturarErroSQL(gnConnHandle), "Erro ao atualizar tipo de tributa" + CHR(231) + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                    CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

