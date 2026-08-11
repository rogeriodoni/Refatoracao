# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 2/10
- Mensagem: TIMEOUT: VFP9 travou durante teste automatico (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-08-09 10:42:11] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 10:42:11] [INFO] Config FPW: (nao fornecido)
[2026-08-09 10:42:11] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 10:42:11] [INFO] Timeout: 300 segundos
[2026-08-09 10:42:11] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mrgnhwju.prg
[2026-08-09 10:42:11] [INFO] Conteudo do wrapper:
[2026-08-09 10:42:11] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICO', 'C:\4c\tasks\task449', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICO', 'C:\4c\tasks\task449', 'OPERACIONAL'
QUIT

[2026-08-09 10:42:11] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mrgnhwju.prg
[2026-08-09 10:42:11] [INFO] VFP output esperado em: C:\4c\tasks\task449\vfp_output.txt
[2026-08-09 10:42:11] [INFO] Executando Visual FoxPro 9...
[2026-08-09 10:42:11] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mrgnhwju.prg
[2026-08-09 10:42:11] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mrgnhwju.prg
[2026-08-09 10:42:11] [INFO] Timeout configurado: 300 segundos
[2026-08-09 10:47:11] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 9268)...
[2026-08-09 10:47:13] [INFO] VFP9 finalizado em 302.054818 segundos
[2026-08-09 10:47:13] [INFO] Exit Code: 4
[2026-08-09 10:47:13] [INFO] 
[2026-08-09 10:47:13] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 10:47:13] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_mrgnhwju.prg
[2026-08-09 10:47:13] [INFO] 
[2026-08-09 10:47:13] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 10:47:13] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 10:47:14] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 10:47:14] [INFO] * Parameters: 'FormICO', 'C:\4c\tasks\task449', 'OPERACIONAL'
[2026-08-09 10:47:14] [INFO] 
[2026-08-09 10:47:14] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 10:47:14] [INFO] SET SAFETY OFF
[2026-08-09 10:47:14] [INFO] SET RESOURCE OFF
[2026-08-09 10:47:14] [INFO] SET TALK OFF
[2026-08-09 10:47:14] [INFO] SET NOTIFY OFF
[2026-08-09 10:47:14] [INFO] SYS(2335, 0)
[2026-08-09 10:47:14] [INFO] 
[2026-08-09 10:47:14] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICO', 'C:\4c\tasks\task449', 'OPERACIONAL'
[2026-08-09 10:47:14] [INFO] QUIT
[2026-08-09 10:47:14] [INFO] 
[2026-08-09 10:47:14] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 10:47:14] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente
[2026-08-09 10:51:16] [INFO] === VFP EXECUTOR v2.0 ===
[2026-08-09 10:51:16] [INFO] Config FPW: (nao fornecido)
[2026-08-09 10:51:16] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 10:51:16] [INFO] Timeout: 300 segundos
[2026-08-09 10:51:16] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4ubrqjc2.prg
[2026-08-09 10:51:16] [INFO] Conteudo do wrapper:
[2026-08-09 10:51:16] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormICO', 'C:\4c\tasks\task449', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICO', 'C:\4c\tasks\task449', 'OPERACIONAL'
QUIT

[2026-08-09 10:51:16] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4ubrqjc2.prg
[2026-08-09 10:51:16] [INFO] VFP output esperado em: C:\4c\tasks\task449\vfp_output.txt
[2026-08-09 10:51:16] [INFO] Executando Visual FoxPro 9...
[2026-08-09 10:51:16] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4ubrqjc2.prg
[2026-08-09 10:51:16] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4ubrqjc2.prg
[2026-08-09 10:51:16] [INFO] Timeout configurado: 300 segundos
[2026-08-09 10:56:16] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 1436)...
[2026-08-09 10:56:18] [INFO] VFP9 finalizado em 302.0543807 segundos
[2026-08-09 10:56:18] [INFO] Exit Code: 4
[2026-08-09 10:56:18] [INFO] 
[2026-08-09 10:56:18] [INFO] Arquivos temporarios preservados para inspecao:
[2026-08-09 10:56:18] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_4ubrqjc2.prg
[2026-08-09 10:56:18] [INFO] 
[2026-08-09 10:56:18] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-08-09 10:56:18] [INFO] * Auto-generated wrapper for parameters
[2026-08-09 10:56:18] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-08-09 10:56:18] [INFO] * Parameters: 'FormICO', 'C:\4c\tasks\task449', 'OPERACIONAL'
[2026-08-09 10:56:18] [INFO] 
[2026-08-09 10:56:18] [INFO] * Anti-dialog protections for unattended execution
[2026-08-09 10:56:18] [INFO] SET SAFETY OFF
[2026-08-09 10:56:18] [INFO] SET RESOURCE OFF
[2026-08-09 10:56:18] [INFO] SET TALK OFF
[2026-08-09 10:56:18] [INFO] SET NOTIFY OFF
[2026-08-09 10:56:18] [INFO] SYS(2335, 0)
[2026-08-09 10:56:18] [INFO] 
[2026-08-09 10:56:18] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormICO', 'C:\4c\tasks\task449', 'OPERACIONAL'
[2026-08-09 10:56:18] [INFO] QUIT
[2026-08-09 10:56:18] [INFO] 
[2026-08-09 10:56:18] [INFO] === Fim do Wrapper.prg ===
[2026-08-09 10:56:18] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormICO.prg):
*==============================================================================
* FormICO.prg - Cadastro de Icones (SigSyIco)
* Form OPERACIONAL - Grid de icones + preview da imagem selecionada
* Herda de: FormBase
* Legado: SIGCDICO.SCX
*==============================================================================
DEFINE CLASS FormICO AS FormBase

    Width        = 800
    Height       = 620
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .T.
    ShowTips     = .T.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Diretorio temporario para arquivos de icone extraidos do banco
    this_cDirTemp = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("ICOBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar ICOBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Propriedades dinamicas do form (Caption e Picture requerem CHR/FILE)
            THIS.Caption = "Cadastro de " + CHR(205) + "cones"
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.LockScreen = .T.

            *-- Orquestra a composicao do layout (cabecalho + area de lista + area de acoes)
            THIS.ConfigurarPageFrame()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

            *-- Carregar icones do SQL Server para cursor crTmpcdico
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                THIS.this_cDirTemp = ADDBS(SYS(2023))
                THIS.this_oBusinessObject.CarregarIcones(THIS.this_cDirTemp)
                IF USED("crTmpcdico")
                    THIS.grd_4c_Dados.ColumnCount              = 1
                    THIS.grd_4c_Dados.RecordSource             = "crTmpcdico"
                    THIS.grd_4c_Dados.Column1.ControlSource    = "crTmpcdico.carqicones"
                    THIS.grd_4c_Dados.Column1.Header1.Caption  = CHR(205) + "cones"
                    THIS.grd_4c_Dados.Visible = .T.
                    THIS.grd_4c_Dados.Refresh()
                    THIS.AtualizarPreview()
                    THIS.grd_4c_Dados.SetFocus()
                ENDIF
            ENDIF

            THIS.LockScreen = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Inicializar FormICO")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *--------------------------------------------------------------------------
    * OPERACIONAL flat layout - o legado SIGCDICO nao usa PageFrame; controles
    * (Grid1 de icones, Icone/Image de preview, Commandgroup1 de acoes) ficam
    * diretamente sobre o Form. Este metodo orquestra a composicao das regioes:
    * cabecalho cinza (cntSombra), area de listagem (Grid1 + Image), area de
    * acoes (CommandGroup Novo/Excluir/Fechar). Nome preservado para
    * compatibilidade com o pipeline de migracao multi-fase.
    *--------------------------------------------------------------------------
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = -1
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = "Cadastro de " + CHR(205) + "cones"
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
        WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = 769
            .Height    = 46
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Cadastro de " + CHR(205) + "cones"
            .ForeColor = RGB(255, 255, 255)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        IF USED("crTmpcdico")
            USE IN crTmpcdico
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *--------------------------------------------------------------------------
        *-- Grid de icones (grd_4c_Dados) - Grid1 do legado
        THIS.AddObject("grd_4c_Dados", "Grid")
        THIS.grd_4c_Dados.ColumnCount = 1
        WITH THIS.grd_4c_Dados
            .Top               = 85
            .Left              = 30
            .Width             = 414
            .Height            = 526
            .ReadOnly          = .T.
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .ScrollBars        = 2
            .HeaderHeight      = 15
            .RowHeight         = 15

            .FontName = "Courier New"
            .SetAll("FontName",    "Verdana",           "Header")
            .SetAll("FontName",    "Courier New",       "TextBox")
            .FontSize = 9
            .SetAll("FontSize",    8,                   "Header")
            .SetAll("FontSize",    9,                   "TextBox")
            .SetAll("Format",      "K",                 "Column")
            .SetAll("Format",      "K",                 "TextBox")
            .SetAll("Movable",     .F.,                 "Column")
            .SetAll("ReadOnly",    .T.,                 "Column")
            .SetAll("ReadOnly",    .T.,                 "TextBox")
            .SetAll("Resizable",   .F.,                 "Column")
            .SetAll("Alignment",   3,                   "Column")
            .SetAll("Alignment",   3,                   "TextBox")
            .SetAll("Alignment",   2,                   "Header")
            .SetAll("BorderStyle", 0,                   "TextBox")
            .SetAll("Margin",      0,                   "TextBox")
            .SetAll("Visible",     .T.,                 "TextBox")
            .SetAll("ForeColor",   RGB(36, 84, 155),   "Header")

            .Column1.Width = 383
        ENDWITH

        *-- Imagem de preview do icone selecionado (img_4c_Icone) - "Icone" do legado
        THIS.AddObject("img_4c_Icone", "Image")
        WITH THIS.img_4c_Icone
            .Top         = 220
            .Left        = 456
            .Width       = 305
            .Height      = 247
            .Stretch     = 1
            .BackStyle   = 1
            .BorderStyle = 1
            .Visible     = .F.
        ENDWITH

        *-- CommandGroup de acoes (obj_4c_Commandgroup1) - Commandgroup1 do legado
        THIS.AddObject("obj_4c_Commandgroup1", "CommandGroup")
        WITH THIS.obj_4c_Commandgroup1
            .Top           = -2
            .Left          = 567
            .Width         = 237
            .Height        = 85
            .ButtonCount   = 3
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Visible       = .T.
        ENDWITH

        WITH THIS.obj_4c_Commandgroup1.Buttons(1)
            .AutoSize        = .F.
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .Caption         = "Incluir"
            .ToolTipText     = "Inserir"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
        ENDWITH

        WITH THIS.obj_4c_Commandgroup1.Buttons(2)
            .AutoSize        = .F.
            .Top             = 5
            .Left            = 81
            .Width           = 75
            .Height          = 75
            .Caption         = "Excluir"
            .ToolTipText     = "Excluir"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
        ENDWITH

        WITH THIS.obj_4c_Commandgroup1.Buttons(3)
            .Top             = 5
            .Left            = 157
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .ToolTipText     = "[ESC] Sair"
            .Cancel          = .T.
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .WordWrap        = .T.
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .PicturePosition = 13
        ENDWITH

        *-- BINDEVENTs para eventos do grid (atualizar preview ao navegar)
        BINDEVENT(THIS.grd_4c_Dados, "Scrolled",           THIS, "GrdDadosScrolled")
        BINDEVENT(THIS.grd_4c_Dados, "BeforeRowColChange",  THIS, "GrdDadosBeforeRowColChange")
        BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange",   THIS, "GrdDadosAfterRowColChange")

        *-- BINDEVENTs para botoes de acao
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(1), "Click", THIS, "BtnIncluirClick")
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(2), "Click", THIS, "BtnExcluirClick")
        BINDEVENT(THIS.obj_4c_Commandgroup1.Buttons(3), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
    *--------------------------------------------------------------------------
        RETURN
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarPreview()
    *--------------------------------------------------------------------------
        LOCAL loc_cArquivo, loc_cNomeArq
        loc_cArquivo = ""
        loc_cNomeArq = ""
        IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
            SELECT crTmpcdico
            loc_cArquivo = ALLTRIM(crTmpcdico.ctmpicones)
            loc_cNomeArq = ALLTRIM(crTmpcdico.carqicones)
        ENDIF
        IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
            THIS.img_4c_Icone.Picture = loc_cArquivo
            THIS.img_4c_Icone.Visible = .T.
        ELSE
            THIS.img_4c_Icone.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
            THIS.lbl_4c_NomeIcone.Caption = loc_cNomeArq
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosScrolled - Atualiza preview ao rolar o grid (Grid1.Scrolled do legado)
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosScrolled(par_nDirection)
        THIS.AtualizarPreview()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosBeforeRowColChange - Atualiza preview antes de mudar linha
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosBeforeRowColChange(par_nColIndex)
        THIS.AtualizarPreview()
    ENDPROC

    *--------------------------------------------------------------------------
    * GrdDadosAfterRowColChange - Atualiza preview apos mudar linha
    *--------------------------------------------------------------------------
    PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
        THIS.AtualizarPreview()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inclui novo icone via seletor de arquivo (cmdInserir.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_cArqIcone, loc_oErro
        loc_cArqIcone = ""
        TRY
            loc_cArqIcone = GETPICT("ico;gif;jpg;bmp;pic", "", "OK")

            IF EMPTY(loc_cArqIcone)
                RETURN
            ENDIF

            IF !FILE(loc_cArqIcone)
                MsgAviso("Nome do arquivo inv" + CHR(225) + "lido.", "Aviso")
                RETURN
            ENDIF

            THIS.LockScreen = .T.

            LOCAL loc_cDirTmp, loc_cArqTemp, loc_cNomeArq
            loc_cDirTmp  = ADDBS(SYS(2023))
            loc_cArqTemp = loc_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
            loc_cNomeArq = LOWER(JUSTFNAME(loc_cArqIcone))

            LOCAL loc_lExiste
            loc_lExiste = .F.
            IF USED("crTmpcdico")
                SELECT crTmpcdico
                LOCATE FOR ALLTRIM(carqicones) == loc_cNomeArq
                loc_lExiste = FOUND()
            ENDIF

            IF !loc_lExiste
                SELECT crTmpcdico
                APPEND BLANK
            ELSE
                SELECT crTmpcdico
            ENDIF

            REPLACE carqicones WITH loc_cNomeArq
            REPLACE marqicones WITH FILETOSTR(loc_cArqIcone)
            REPLACE ctmpicones WITH loc_cArqTemp

            LOCAL loc_nBytes
            loc_nBytes = STRTOFILE(crTmpcdico.marqicones, loc_cArqTemp)

            THIS.this_oBusinessObject.this_cCarqIcones = loc_cNomeArq
            THIS.this_oBusinessObject.this_cMarqIcones = crTmpcdico.marqicones

            LOCAL loc_lSucesso
            IF !loc_lExiste
                loc_lSucesso = THIS.this_oBusinessObject.Inserir()
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            SELECT crTmpcdico
            GO TOP
            LOCATE FOR carqicones == loc_cNomeArq
            THIS.AtualizarPreview()
            THIS.Refresh()
            THIS.LockScreen = .F.
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Incluir " + CHR(205) + "cone")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Exclui icone selecionado (cmdExcluir.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
                RETURN
            ENDIF

            SELECT crTmpcdico
            LOCAL loc_cRegistro
            loc_cRegistro = ALLTRIM(crTmpcdico.carqicones)

            IF EMPTY(loc_cRegistro)
                RETURN
            ENDIF

            IF !MsgConfirma("Tem certeza que deseja Excluir?", "Excluir")
                RETURN
            ENDIF

            THIS.LockScreen = .T.

            IF THIS.this_oBusinessObject.VerificarUsoIcone(loc_cRegistro)
                MsgAviso("Existem " + CHR(237) + "tens cadastrados que est" + CHR(227) + ;
                    "o utilizando esse Registro!", ;
                    "Exclus" + CHR(227) + "o n" + CHR(227) + "o permitida")
                THIS.LockScreen = .F.
                RETURN
            ENDIF

            THIS.this_oBusinessObject.this_cCarqIcones = loc_cRegistro
            IF THIS.this_oBusinessObject.Excluir()
                DELETE FROM crTmpcdico WHERE ALLTRIM(carqicones) = loc_cRegistro
                THIS.grd_4c_Dados.Refresh()
                SELECT crTmpcdico
                GO TOP
                LOCATE FOR carqicones > loc_cRegistro
                IF EOF()
                    GO BOTTOM
                ENDIF
                THIS.AtualizarPreview()
                THIS.Refresh()
                THIS.grd_4c_Dados.SetFocus()
            ENDIF

            THIS.LockScreen = .F.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Excluir " + CHR(205) + "cone")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario (cmdSair.Click do legado)
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Substitui o conteudo binario do icone selecionado por
    * um novo arquivo (mantem o carqicones/PK, atualiza marqicones/ctmpicones).
    * O legado nao expoe botao Alterar; a semantica adotada segue o mesmo
    * fluxo de Incluir quando SEEK() encontra o registro (chama Atualizar()).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_cArqIcone, loc_oErro
        loc_cArqIcone = ""
        TRY
            IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " " + CHR(237) + ;
                    "cones cadastrados para alterar.", "Aviso")
                RETURN
            ENDIF

            SELECT crTmpcdico
            LOCAL loc_cNomeAtual
            loc_cNomeAtual = ALLTRIM(crTmpcdico.carqicones)

            IF EMPTY(loc_cNomeAtual)
                MsgAviso("Selecione um " + CHR(237) + "cone na lista para alterar.", "Aviso")
                RETURN
            ENDIF

            loc_cArqIcone = GETPICT("ico;gif;jpg;bmp;pic", "", "OK")

            IF EMPTY(loc_cArqIcone)
                RETURN
            ENDIF

            IF !FILE(loc_cArqIcone)
                MsgAviso("Nome do arquivo inv" + CHR(225) + "lido.", "Aviso")
                RETURN
            ENDIF

            IF !MsgConfirma("Substituir o conte" + CHR(250) + "do do " + CHR(237) + ;
                    "cone selecionado?", "Alterar")
                RETURN
            ENDIF

            THIS.LockScreen = .T.

            LOCAL loc_cDirTmp, loc_cArqTemp, loc_mConteudo
            loc_cDirTmp   = ADDBS(SYS(2023))
            loc_cArqTemp  = loc_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
            loc_mConteudo = FILETOSTR(loc_cArqIcone)

            SELECT crTmpcdico
            REPLACE marqicones WITH loc_mConteudo
            REPLACE ctmpicones WITH loc_cArqTemp

            STRTOFILE(loc_mConteudo, loc_cArqTemp)

            THIS.this_oBusinessObject.this_cCarqIcones = loc_cNomeAtual
            THIS.this_oBusinessObject.this_cMarqIcones = loc_mConteudo

            LOCAL loc_lSucesso
            loc_lSucesso = THIS.this_oBusinessObject.Atualizar()

            THIS.grd_4c_Dados.Refresh()
            SELECT crTmpcdico
            LOCATE FOR ALLTRIM(carqicones) == loc_cNomeAtual
            THIS.AtualizarPreview()
            THIS.Refresh()
            THIS.LockScreen = .F.
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Alterar " + CHR(205) + "cone")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Reforca a exibicao da imagem do icone selecionado
    * no painel de preview (img_4c_Icone) e devolve o foco ao grid. Espelha o
    * comportamento de navegacao do legado (Grid1.Scrolled/AfterRowColChange)
    * quando invocado explicitamente pelo usuario.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oErro
        TRY
            IF !USED("crTmpcdico") OR RECCOUNT("crTmpcdico") = 0
                MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " " + CHR(237) + ;
                    "cones cadastrados para visualizar.", "Aviso")
                RETURN
            ENDIF

            SELECT crTmpcdico
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(crTmpcdico.carqicones)

            IF EMPTY(loc_cNome)
                MsgAviso("Selecione um " + CHR(237) + "cone na lista para visualizar.", "Aviso")
                RETURN
            ENDIF

            *-- Se o arquivo temporario foi removido, regenerar a partir do MEMO
            LOCAL loc_cArqTemp
            loc_cArqTemp = ALLTRIM(crTmpcdico.ctmpicones)
            IF EMPTY(loc_cArqTemp) OR !FILE(loc_cArqTemp)
                loc_cArqTemp = ADDBS(SYS(2023)) + "ArqIcone" + SYS(2015) + ".ico"
                IF !EMPTY(crTmpcdico.marqicones)
                    STRTOFILE(crTmpcdico.marqicones, loc_cArqTemp)
                    REPLACE ctmpicones WITH loc_cArqTemp
                ELSE
                    loc_cArqTemp = ""
                ENDIF
            ENDIF

            THIS.AtualizarPreview()
            THIS.Refresh()
            THIS.grd_4c_Dados.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Visualizar " + CHR(205) + "cone")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *--------------------------------------------------------------------------
    * Painel direito do form (x=456+): labels informativos acima da preview
    * Area entre cabecalho (bottom=79) e imagem (top=220) ~ 140px disponiveis
    *--------------------------------------------------------------------------
        *-- Instrucao: orienta o usuario a selecionar um icone na lista
        THIS.AddObject("lbl_4c_Instrucao", "Label")
        WITH THIS.lbl_4c_Instrucao
            .Top       = 95
            .Left      = 456
            .Width     = 320
            .Height    = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Selecione um " + CHR(237) + "cone da lista:"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- Exibe o nome do arquivo do icone correntemente selecionado no grid
        THIS.AddObject("lbl_4c_NomeIcone", "Label")
        WITH THIS.lbl_4c_NomeIcone
            .Top       = 120
            .Left      = 456
            .Width     = 320
            .Height    = 75
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .WordWrap  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = ""
            .ForeColor = RGB(36, 84, 155)
            .Visible   = .T.
        ENDWITH

        *-- Titulo da secao de preview (imagem do icone selecionado)
        THIS.AddObject("lbl_4c_Preview", "Label")
        WITH THIS.lbl_4c_Preview
            .Top       = 200
            .Left      = 456
            .Width     = 320
            .Height    = 18
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .T.
            .BackStyle = 0
            .AutoSize  = .F.
            .Caption   = "Pr" + CHR(233) + "via:"
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Recarrega a lista de icones do SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
            RETURN
        ENDIF
        LOCAL loc_oErro
        TRY
            THIS.LockScreen = .T.
            THIS.this_oBusinessObject.CarregarIcones(THIS.this_cDirTemp)
            IF USED("crTmpcdico")
                THIS.grd_4c_Dados.ColumnCount             = 1
                THIS.grd_4c_Dados.RecordSource            = "crTmpcdico"
                THIS.grd_4c_Dados.Column1.ControlSource   = "crTmpcdico.carqicones"
                THIS.grd_4c_Dados.Column1.Header1.Caption = CHR(205) + "cones"
                THIS.grd_4c_Dados.Visible = .T.
                THIS.grd_4c_Dados.Refresh()
                THIS.AtualizarPreview()
                THIS.HabilitarCampos()
            ENDIF
            THIS.LockScreen = .F.
        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao Carregar Lista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega a lista de icones (refresh)
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CarregarLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Form OPERACIONAL: delega ao fluxo de Incluir
    * (nao ha modo de edicao separado; o Incluir ja persiste diretamente)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Limpa preview e volta ao topo da lista
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.LimparCampos()
        IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
            SELECT crTmpcdico
            GO TOP
            THIS.AtualizarPreview()
        ENDIF
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza o registro selecionado no grid com o BO
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
            SELECT crTmpcdico
            THIS.this_oBusinessObject.this_cCarqIcones = ALLTRIM(crTmpcdico.carqicones)
            THIS.this_oBusinessObject.this_cMarqIcones = crTmpcdico.marqicones
            IF TYPE("crTmpcdico.ctmpicones") != "U"
                THIS.this_oBusinessObject.this_cCtmpIcones = ALLTRIM(crTmpcdico.ctmpicones)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza o BO com a area de preview e label de nome
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
            THIS.lbl_4c_NomeIcone.Caption = ALLTRIM(THIS.this_oBusinessObject.this_cCarqIcones)
        ENDIF
        IF PEMSTATUS(THIS, "img_4c_Icone", 5)
            LOCAL loc_cArq
            loc_cArq = ALLTRIM(THIS.this_oBusinessObject.this_cCtmpIcones)
            IF !EMPTY(loc_cArq) AND FILE(loc_cArq)
                THIS.img_4c_Icone.Picture = loc_cArq
                THIS.img_4c_Icone.Visible = .T.
            ELSE
                THIS.img_4c_Icone.Visible = .F.
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita botoes conforme disponibilidade de dados
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_lTemRegistros
        loc_lTemRegistros = USED("crTmpcdico") AND RECCOUNT("crTmpcdico") > 0
        IF PEMSTATUS(THIS, "obj_4c_Commandgroup1", 5)
            THIS.obj_4c_Commandgroup1.Buttons(2).Enabled = loc_lTemRegistros
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa a area de preview e o label de nome do icone
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "img_4c_Icone", 5)
            THIS.img_4c_Icone.Picture = ""
            THIS.img_4c_Icone.Visible = .F.
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_NomeIcone", 5)
            THIS.lbl_4c_NomeIcone.Caption = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Form OPERACIONAL flat: delega para HabilitarCampos
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles de um container visiveis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    IF !INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO")
                        loc_oControl.Visible = .T.
                    ENDIF
                ENDIF
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\ICOBO.prg):
*==============================================================================
* ICOBO.prg - Business Object: Cadastro de Icones (SigSyIco)
* Herda de: BusinessBase
*==============================================================================
DEFINE CLASS ICOBO AS BusinessBase

    *-- Cursor de dados exibido no grid
    this_cCursorDados   = "crTmpcdico"

    *-- Nome do arquivo de icone selecionado/atual
    this_cCarqIcones    = ""

    *-- Conteudo binario do icone (MEMO)
    this_cMarqIcones    = ""

    *-- Caminho temporario do arquivo extraido para exibicao
    this_cCtmpIcones    = ""

    *-- Diretorio temporario usado para extracao dos icones
    this_cDirTemp       = ""

    *-- Indica se os icones ja foram carregados no cursor
    this_lCarregado     = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela      = "SigSyIco"
        THIS.this_cCampoChave  = "carqicones"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave primaria atual
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCarqIcones)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCarqIcones = TratarNulo(carqicones, "C")
            THIS.this_cMarqIcones = NVL(marqicones, "")
            IF TYPE("ctmpicones") != "U"
                THIS.this_cCtmpIcones = ALLTRIM(ctmpicones)
            ENDIF
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarIcones - Carrega todos os icones do SQL Server para crTmpcdico
    *   par_cDirTemp: diretorio temporario para extrair arquivos de icone
    *--------------------------------------------------------------------------
    FUNCTION CarregarIcones(par_cDirTemp)
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            THIS.this_cDirTemp = ADDBS(par_cDirTemp)

            *-- Fechar cursores anteriores
            IF USED("crTmpcdico_Temp")
                USE IN crTmpcdico_Temp
            ENDIF
            IF USED("crTmpcdico")
                USE IN crTmpcdico
            ENDIF

            *-- Criar cursor principal com estrutura identica ao legado
            SET NULL ON
            CREATE CURSOR crTmpcdico ( ;
                carqicones  C(128) NULL, ;
                marqicones  M NULL, ;
                ctmpicones  C(255) NULL ;
            )
            SET NULL OFF

            *-- Carregar dados do SQL Server
            LOCAL loc_cSQL
            loc_cSQL = "SELECT carqicones, marqicones FROM SigSyIco ORDER BY carqicones"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpcdico_Temp")
            IF loc_nResult > 0
                *-- Declarar variaveis do SCAN antes do loop
                LOCAL loc_cNome, loc_cArqTemp, loc_nTam
                loc_cNome    = ""
                loc_cArqTemp = ""
                loc_nTam     = 0

                IF USED("crTmpcdico_Temp") AND RECCOUNT("crTmpcdico_Temp") > 0
                    SELECT crTmpcdico_Temp
                    SCAN
                        loc_cNome    = ALLTRIM(crTmpcdico_Temp.carqicones)
                        loc_cArqTemp = ""

                        *-- Extrair conteudo binario para arquivo temporario
                        IF !EMPTY(crTmpcdico_Temp.marqicones)
                            loc_cArqTemp = THIS.this_cDirTemp + "ArqIcone" + SYS(2015) + ".ico"
                            loc_nTam = STRTOFILE(crTmpcdico_Temp.marqicones, loc_cArqTemp)
                            IF loc_nTam > 0
                                loc_cArqTemp = LOWER(loc_cArqTemp)
                            ELSE
                                loc_cArqTemp = ""
                            ENDIF
                        ENDIF

                        *-- Popular cursor principal
                        SELECT crTmpcdico
                        APPEND BLANK
                        REPLACE carqicones WITH loc_cNome
                        REPLACE marqicones WITH crTmpcdico_Temp.marqicones
                        REPLACE ctmpicones WITH loc_cArqTemp
                        SELECT crTmpcdico_Temp
                    ENDSCAN
                ENDIF

                IF USED("crTmpcdico_Temp")
                    USE IN crTmpcdico_Temp
                ENDIF

                *-- Posicionar no inicio (SELECT ja tem ORDER BY carqicones)
                SELECT crTmpcdico
                GO TOP IN crTmpcdico

                THIS.this_lCarregado = .T.
                loc_lResultado = .T.
            ELSE
                IF USED("crTmpcdico_Temp")
                    USE IN crTmpcdico_Temp
                ENDIF
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao carregar " + CHR(237) + "cones: " + loc_aErros[1,2], "Erro")
            ENDIF
        CATCH TO loc_oErro
            IF USED("crTmpcdico_Temp")
                USE IN crTmpcdico_Temp
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar " + CHR(205) + "cones")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo icone no SQL Server
    *   Requer this_cCarqIcones e this_cMarqIcones populados
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                MsgAviso("Nome do arquivo do " + CHR(237) + "cone n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_mConteudo
            loc_mConteudo = THIS.this_cMarqIcones

            LOCAL loc_cSQL
            loc_cSQL = "INSERT INTO SigSyIco (carqicones, marqicones) VALUES (?loc_cNome, ?loc_mConteudo)"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INCLUIR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao inserir " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Inserir " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza icone existente no SQL Server
    *   Requer this_cCarqIcones e this_cMarqIcones populados
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                MsgAviso("Nome do arquivo do " + CHR(237) + "cone n" + CHR(227) + "o informado.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_mConteudo
            loc_mConteudo = THIS.this_cMarqIcones

            LOCAL loc_cSQL
            loc_cSQL = "UPDATE SigSyIco SET marqicones = ?loc_mConteudo WHERE carqicones = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao atualizar " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Atualizar " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui icone do SQL Server (chamado por Excluir())
    *   Requer this_cCarqIcones populado
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(THIS.this_cCarqIcones)

            IF EMPTY(loc_cNome)
                loc_lResultado = .F.
            ENDIF

            LOCAL loc_cSQL
            loc_cSQL = "DELETE FROM SigSyIco WHERE carqicones = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros[1]
                AERROR(loc_aErros)
                MsgErro("Erro ao excluir " + CHR(237) + "cone." + CHR(13) + loc_aErros[1,2], "Erro ao Excluir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Excluir " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarUsoIcone - Verifica se icone esta referenciado em SigCdPrg.barrapict
    *   par_cNomeIcone: nome do arquivo (carqicones)
    *   Retorna .T. se em uso (nao pode excluir)
    *--------------------------------------------------------------------------
    FUNCTION VerificarUsoIcone(par_cNomeIcone)
        LOCAL loc_lEmUso, loc_oErro
        loc_lEmUso = .F.
        TRY
            LOCAL loc_cNome
            loc_cNome = ALLTRIM(par_cNomeIcone)

            LOCAL loc_cSQL
            loc_cSQL = "SELECT COUNT(*) AS nQtd FROM SigCdPrg WHERE barrapict = ?loc_cNome"

            LOCAL loc_nResult
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVerificaUsoIco")
            IF loc_nResult > 0
                IF USED("crVerificaUsoIco")
                    loc_lEmUso = (NVL(crVerificaUsoIco.nQtd, 0) > 0)
                    USE IN crVerificaUsoIco
                ENDIF
            ELSE
                IF USED("crVerificaUsoIco")
                    USE IN crVerificaUsoIco
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("crVerificaUsoIco")
                USE IN crVerificaUsoIco
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro ao Verificar Uso do " + CHR(205) + "cone")
        ENDTRY
        RETURN loc_lEmUso
    ENDFUNC

ENDDEFINE

