# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 1/10
- Mensagem: TIMEOUT: VFP9 travou durante teste de formulario (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-07-16 14:12:47] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-16 14:12:47] [INFO] Config FPW: (nao fornecido)
[2026-07-16 14:12:47] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-07-16 14:12:47] [INFO] Timeout: 300 segundos
[2026-07-16 14:12:47] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kqfnglx0.prg
[2026-07-16 14:12:47] [INFO] Conteudo do wrapper:
[2026-07-16 14:12:47] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigPrGf2', 'C:\4c\tasks\task288\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGf2', 'C:\4c\tasks\task288\logs\06_testForm.log'
QUIT

[2026-07-16 14:12:47] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kqfnglx0.prg
[2026-07-16 14:12:47] [INFO] VFP output esperado em: C:\4c\tasks\task288\vfp_output.txt
[2026-07-16 14:12:47] [INFO] Executando Visual FoxPro 9...
[2026-07-16 14:12:47] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kqfnglx0.prg
[2026-07-16 14:12:47] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kqfnglx0.prg
[2026-07-16 14:12:47] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigPrGf2
Inicio: 16/07/2026 14:12:48

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
OK - Conectado ao banco (Handle: 1)

[ETAPA 2] Criando objeto do formulario...
[2026-07-16 14:17:47] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 12464)...
[2026-07-16 14:17:49] [WARN] Encerrando 1 processo(s) VFP9 residual(is)...
[2026-07-16 14:17:51] [INFO] VFP9 finalizado em 303.1074677 segundos
[2026-07-16 14:17:51] [INFO] Exit Code: 4
[2026-07-16 14:17:51] [INFO] 
[2026-07-16 14:17:51] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-16 14:17:51] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_kqfnglx0.prg
[2026-07-16 14:17:51] [INFO] 
[2026-07-16 14:17:51] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-16 14:17:51] [INFO] * Auto-generated wrapper for parameters
[2026-07-16 14:17:51] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-07-16 14:17:51] [INFO] * Parameters: 'FormSigPrGf2', 'C:\4c\tasks\task288\logs\06_testForm.log'
[2026-07-16 14:17:51] [INFO] 
[2026-07-16 14:17:51] [INFO] * Anti-dialog protections for unattended execution
[2026-07-16 14:17:51] [INFO] SET SAFETY OFF
[2026-07-16 14:17:51] [INFO] SET RESOURCE OFF
[2026-07-16 14:17:51] [INFO] SET TALK OFF
[2026-07-16 14:17:51] [INFO] SET NOTIFY OFF
[2026-07-16 14:17:51] [INFO] SYS(2335, 0)
[2026-07-16 14:17:51] [INFO] 
[2026-07-16 14:17:51] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigPrGf2', 'C:\4c\tasks\task288\logs\06_testForm.log'
[2026-07-16 14:17:51] [INFO] QUIT
[2026-07-16 14:17:51] [INFO] 
[2026-07-16 14:17:51] [INFO] === Fim do Wrapper.prg ===
[2026-07-16 14:17:51] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf2.prg):
*==============================================================================
* FormSigPrGf2.prg - Gr??fico de Falha X Recupera????o Mensal
* Tipo: OPERACIONAL - Visualiza????o de gr??fico OLE (MSGraph)
* Fase 8/8 - COMPLETO
*==============================================================================

DEFINE CLASS FormSigPrGf2 AS FormBase

    *-- Propriedades do legado (CLASSINFO: poform1, pnnumgrf)
    poform1  = .NULL.
    pnnumgrf = 0

    *-- Propriedades do novo sistema
    this_oBusinessObject = .NULL.
    this_cModoAtual      = "OPERACIONAL"

    *-- Configura????es visuais (classe-level - iguais ao legado PILAR 1)
    Width       = 800
    Height      = 600
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    WindowType  = 0
    DataSession = 2

    *--------------------------------------------------------------------------
    * Init - Recebe ref do form pai, compartilha datasession e inicializa
    * DataSessionId ?? compartilhado ANTES do DODEFAULT para que
    * InicializarForm acesse crRel1 (cursor populado pelo form pai)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_loForm1)
        IF VARTYPE(par_loForm1) = "O"
            THIS.poform1       = par_loForm1
            THIS.DataSessionId = par_loForm1.DataSessionId
        ELSE
            THIS.poform1 = THIS
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura form, cria containers e prepara exibi????o
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrGf2BO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Propriedades visuais do form
                THIS.Caption = "Gr" + CHR(225) + "fico de Falha X Recupera" + ;
                               CHR(231) + CHR(227) + "o Mensal"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- Inicializar cursor de cache do gr??fico (via BO)
                THIS.this_oBusinessObject.InicializarCursorGrafico()

                *-- Criar containers do layout
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()

                *-- Sincronizar caption do cabecalho com o form
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Estado inicial: aguarde visivel, grafico oculto
                THIS.AlternarPagina("AGUARDE")

                *-- Exibir form com aguarde enquanto carrega o grafico
                THIS.Refresh()
                THIS.Show()

                *-- Gerar grafico inicial (popula combo + gera chart para item 1)
                THIS.LockScreen = .T.
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
                THIS.GerarGrafico(1)

                *-- Transicionar para estado de exibicao do grafico
                THIS.AlternarPagina("GRAFICO")
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
                THIS.LockScreen = .F.

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar SigPrGf2BO. " + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro InicializarForm")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Cria containers e controles do form
    * Form OPERACIONAL sem PageFrame: nome mantido por convencao do pipeline;
    * o layout eh custom (cabecalho + grafico OLE + controles inferiores).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        *-- === Cabe??alho cinza escuro (cntSombra do legado) ===
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(0, 0, 0)
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .WordWrap  = .T.
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- === CommandGroup: Imprimir + Encerrar (bot??es configurados na fase 4) ===
        THIS.AddObject("obj_4c_CmdgGrafico", "CommandGroup")
        WITH THIS.obj_4c_CmdgGrafico
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Top           = -3
            .Left          = 644
            .Width         = 160
            .Height        = 85
            .Visible       = .T.
        ENDWITH

        *-- === Container do gr??fico OLE (oleGrafico1 adicionado na fase 4) ===
        THIS.AddObject("cnt_4c_Grf1", "Container")
        WITH THIS.cnt_4c_Grf1
            .Top           = 120
            .Left          = 17
            .Width         = 770
            .Height        = 429
            .BackColor     = RGB(255, 255, 255)
            .BackStyle     = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH

        *-- === Container de espera (vis??vel durante inicializa????o e processamento) ===
        THIS.AddObject("cnt_4c_Aguarde", "Container")
        WITH THIS.cnt_4c_Aguarde
            .Top           = 288
            .Left          = 312
            .Width         = 207
            .Height        = 49
            .BackColor     = RGB(255, 255, 255)
            .BackStyle     = 1
            .BorderWidth   = 5
            .SpecialEffect = 0
            .Visible       = .T.

            .AddObject("lbl_4c_Label1", "Label")
            WITH .lbl_4c_Label1
                .Top       = 7
                .Left      = 69
                .Width     = 78
                .Height    = 18
                .FontName  = "Verdana"
                .FontSize  = 10
                .FontBold  = .T.
                .BackStyle = 0
                .ForeColor = RGB(255, 0, 0)
                .Caption   = "Aguarde..."
                .AutoSize  = .T.
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Label2", "Label")
            WITH .lbl_4c_Label2
                .Top       = 24
                .Left      = 34
                .Width     = 159
                .Height    = 18
                .FontName  = "Verdana"
                .FontSize  = 10
                .FontBold  = .T.
                .BackStyle = 0
                .Caption   = "Processando Dados..."
                .AutoSize  = .F.
                .Visible   = .T.
            ENDWITH
        ENDWITH

        *-- === Container inferior: Label + ComboBox (conte??do adicionado na fase 5) ===
        THIS.AddObject("cnt_4c_Grf2", "Container")
        WITH THIS.cnt_4c_Grf2
            .Top           = 558
            .Left          = 559
            .Width         = 228
            .Height        = 35
            .BackColor     = RGB(255, 255, 255)
            .BackStyle     = 1
            .SpecialEffect = 0
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos ao fechar o form
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            *-- Limpar cursor de cache do gr??fico
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparCursorGrafico()
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            *-- Reabilitar form pai (form era modeless e desabilitava o pai)
            IF VARTYPE(THIS.poform1) = "O" AND THIS.poform1 != THIS
                THIS.poform1.LockScreen = .T.
                THIS.poform1.Enabled   = .T.
                THIS.poform1.LockScreen = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Destroy FormSigPrGf2")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Adiciona OLE e configura botoes do CommandGroup
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- OLE Bound Control para exibicao do grafico (oleGrafico1 do legado)
        THIS.cnt_4c_Grf1.AddObject("obj_4c_OleGrafico1", "OLEBoundControl")
        WITH THIS.cnt_4c_Grf1.obj_4c_OleGrafico1
            .Top     = 19
            .Left    = 5
            .Height  = 390
            .Width   = 760
            .Visible = .T.
        ENDWITH

        *-- Botao 1: Grafico (geral_grafico_pizza_60.jpg - icone do legado)
        WITH THIS.obj_4c_CmdgGrafico
            WITH .Buttons(1)
                .Caption         = "Gr" + CHR(225) + "fico"
                .Left            = 5
                .Top             = 5
                .Width           = 75
                .Height          = 75
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "geral_grafico_pizza_60.jpg"
                .WordWrap        = .T.
                .MousePointer    = 15
            ENDWITH
            WITH .Buttons(2)
                .Caption         = "Encerrar"
                .Left            = 80
                .Top             = 5
                .Width           = 75
                .Height          = 75
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .SpecialEffect   = 0
                .PicturePosition = 13
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .WordWrap        = .T.
                .MousePointer    = 15
            ENDWITH
        ENDWITH

        *-- BINDEVENT: CommandGroup Click -> CmdGraficoClick (PUBLIC)
        BINDEVENT(THIS.obj_4c_CmdgGrafico, "Click", THIS, "CmdGraficoClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Popula cnt_4c_Grf2 com Label e ComboBox
    * (cntGrf2.lblChave1 + cntGrf2.cmbChave1 do legado)
    * Items do combo sao populados em GerarGrafico() na primeira chamada.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oGrf2
        loc_oGrf2 = THIS.cnt_4c_Grf2

        *-- Label "Grupo / Vendedor :" (lblChave1 do legado)
        loc_oGrf2.AddObject("lbl_4c_LblChave1", "Label")
        WITH loc_oGrf2.lbl_4c_LblChave1
            .Top       = 9
            .Left      = 7
            .Width     = 94
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Grupo / Vendedor :"
            .AutoSize  = .T.
            .Visible   = .T.
        ENDWITH

        *-- ComboBox de selecao de grupo/vendedor (cmbChave1 do legado)
        *-- Items populados em GerarGrafico() ao inicializar
        loc_oGrf2.AddObject("cbo_4c_CmbChave1", "ComboBox")
        WITH loc_oGrf2.cbo_4c_CmbChave1
            .Top               = 4
            .Left              = 129
            .Width             = 86
            .Height            = 25
            .FontName          = "Courier New"
            .FontSize          = 9
            .ColumnCount       = 1
            .ColumnLines       = .F.
            .IncrementalSearch = .T.
            .Style             = 2
            .ReadOnly          = .T.
            .Format            = "K"
            .Sorted            = .F.
            .SpecialEffect     = 0
            .Alignment         = 0
            .Visible           = .T.
        ENDWITH

        *-- BINDEVENTs: Click e GotFocus no ComboBox (PUBLIC handlers exigidos)
        BINDEVENT(loc_oGrf2.cbo_4c_CmbChave1, "Click",    THIS, "CboChave1Click")
        BINDEVENT(loc_oGrf2.cbo_4c_CmbChave1, "GotFocus", THIS, "CboChave1GotFocus")
    ENDPROC

    *--------------------------------------------------------------------------
    * CboChave1Click - Regera grafico para grupo/vendedor selecionado no combo
    *--------------------------------------------------------------------------
    PROCEDURE CboChave1Click()
        LOCAL loc_oErro

        TRY
            THIS.cnt_4c_Aguarde.Visible = .T.
            THIS.Refresh()
            THIS.LockScreen = .T.
            THIS.SetAll("Enabled", .F., "OLEBoundControl")

            THIS.GerarGrafico(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex)

            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
            THIS.cnt_4c_Aguarde.Visible = .F.
            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro CboChave1Click")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CboChave1GotFocus - Desabilita controles OLE quando combo recebe foco
    *--------------------------------------------------------------------------
    PROCEDURE CboChave1GotFocus()
        THIS.SetAll("Enabled", .F., "OLEBoundControl")
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre estado de espera e exibicao do grafico
    * par_cEstado: "AGUARDE" ou "GRAFICO"
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_cEstado)
        LOCAL loc_cEstado
        loc_cEstado = UPPER(ALLTRIM(IIF(VARTYPE(par_cEstado) = "C", par_cEstado, "AGUARDE")))

        DO CASE
        CASE loc_cEstado = "AGUARDE"
            THIS.cnt_4c_Aguarde.Visible     = .T.
            THIS.cnt_4c_Grf1.Visible        = .F.
            THIS.cnt_4c_Grf2.Visible        = .F.
            THIS.obj_4c_CmdgGrafico.Visible = .F.
        CASE loc_cEstado = "GRAFICO"
            THIS.cnt_4c_Aguarde.Visible     = .F.
            THIS.cnt_4c_Grf1.Visible        = .T.
            THIS.cnt_4c_Grf2.Visible        = .T.
            THIS.obj_4c_CmdgGrafico.Visible = .T.
        ENDCASE

        THIS.Refresh()
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdGraficoClick - Handler do CommandGroup (despachante por .Value)
    *--------------------------------------------------------------------------
    PROCEDURE CmdGraficoClick()
        DO CASE
        CASE THIS.obj_4c_CmdgGrafico.Value = 1
            THIS.BtnGraficoClick()
        CASE THIS.obj_4c_CmdgGrafico.Value = 2
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGraficoClick - Imprime grafico atual na impressora via SigPrGf1.frx
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnGraficoClick()
        LOCAL loc_oErro, loc_cRelatorio, loc_nRecno
        LOCAL loc_cPoint, loc_cSep

        TRY
            THIS.LockScreen = .T.

            loc_cRelatorio = FULLPATH(gc_4c_CaminhoReports + "SigPrGf1.frx")

            IF NOT FILE(loc_cRelatorio)
                MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
                        CHR(13) + loc_cRelatorio, ;
                        "Gr" + CHR(225) + "fico")
            ELSE
                IF USED("crGrafico1") AND RECCOUNT("crGrafico1") > 0
                    loc_nRecno = RECNO("crGrafico1")
                    loc_cPoint = SET("POINT")
                    loc_cSep   = SET("SEPARATOR")

                    SET POINT TO "."
                    SET SEPARATOR TO ","
                    SET REPORTBEHAVIOR 80

                    SELECT crGrafico1
                    REPORT FORM (FULLPATH(gc_4c_CaminhoReports + "SigPrGf1")) ;
                        NEXT 1 TO PRINTER PROMPT NOCONSOLE

                    SET POINT TO (loc_cPoint)
                    SET SEPARATOR TO (loc_cSep)
                    SET REPORTBEHAVIOR 90

                    IF BETWEEN(loc_nRecno, 1, RECCOUNT("crGrafico1"))
                        GOTO loc_nRecno IN crGrafico1
                    ENDIF

                    THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
                ELSE
                    MsgAviso("Nenhum gr" + CHR(225) + "fico dispon" + CHR(237) + ;
                             "vel para impress" + CHR(227) + "o.", ;
                             "Impress" + CHR(227) + "o")
                ENDIF
            ENDIF

            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnGraficoClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Limpa OLE, fecha cursor de cache e libera o form
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BtnEncerrarClick()
        LOCAL loc_oErro

        TRY
            THIS.LockScreen = .T.

            IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
                THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
            ENDIF

            IF USED("crGrafico1")
                USE IN crGrafico1
            ENDIF

            THIS.Release()

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro BtnEncerrarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarGrafico - Gera/exibe grafico OLE para o grupo/vendedor selecionado
    *   par_nLinha - Indice 1-based no ComboBox (0 ou omitido = usar primeiro)
    *   Equivale ao mgeragrafico do legado: popula combo na 1a chamada,
    *   gera dados via BO, configura objeto MSGraph.Chart no OLE Bound Control.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarGrafico(par_nLinha)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nLinha, loc_cChave1
        LOCAL loc_nCount, loc_nTmStr
        LOCAL loc_lCacheMiss
        LOCAL loc_cPoint, loc_cSep
        LOCAL loc_i, loc_nGrupo, loc_nMes
        LOCAL loc_oOle
        LOCAL ARRAY loc_aChaves(1)

        loc_lSucesso  = .F.
        loc_lCacheMiss = .F.

        *-- Salvar locale antes de qualquer RETURN/CATCH
        loc_cPoint = SET("POINT")
        loc_cSep   = SET("SEPARATOR")
        SET POINT TO ","
        SET SEPARATOR TO "."

        TRY
            loc_nLinha = IIF(VARTYPE(par_nLinha) = "N" .AND. par_nLinha > 0, par_nLinha, 1)

            *-- === 1. Populacao inicial do ComboBox (apenas na primeira chamada) ===
            IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount = 0
                DIMENSION loc_aChaves(1)
                loc_nCount = THIS.this_oBusinessObject.ObterChavesGrafico(@loc_aChaves)

                IF loc_nCount > 0
                    loc_nTmStr = LEN(ALLTRIM(loc_aChaves(1)))

                    WITH THIS.cnt_4c_Grf2.cbo_4c_CmbChave1
                        .Clear()
                        .RowSourceType = 0
                        .RowSource     = ""
                        .Width         = (loc_nTmStr * 7 + 9) + 20
                        .Height        = 25
                        .Top           = 5
                        .Left          = 5 + THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width
                        FOR loc_i = 1 TO loc_nCount
                            .AddItem(PADR(loc_aChaves(loc_i), loc_nTmStr))
                        ENDFOR
                    ENDWITH

                    WITH THIS.cnt_4c_Grf2
                        .Height = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Height + 10
                        .Width  = THIS.cnt_4c_Grf2.lbl_4c_LblChave1.Width + ;
                                  THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Width + 10
                        .Visible     = .T.
                    ENDWITH
                ENDIF
            ENDIF

            *-- === 2. Gerar grafico se ha itens no combo ===
            IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
                *-- Obter chave selecionada do combo
                loc_cChave1 = ALLTRIM(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(loc_nLinha))

                *-- Montar array de 1 elemento para passar ao BO
                DIMENSION loc_aChaves(1)
                loc_aChaves(1) = loc_cChave1

                *-- Verificar cache ANTES de chamar BO (para saber se precisa configurar OLE)
                IF USED("crGrafico1")
                    SELECT crGrafico1
                    LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave1, 100)
                    loc_lCacheMiss = EOF("crGrafico1")
                ELSE
                    loc_lCacheMiss = .T.
                ENDIF

                *-- BO: cache miss -> INSERT + APPEND GENERAL; cache hit -> apenas posiciona
                IF THIS.this_oBusinessObject.CarregarDadosGrafico(1, @loc_aChaves)
                    loc_oOle = THIS.cnt_4c_Grf1.obj_4c_OleGrafico1

                    IF loc_lCacheMiss
                        *-- Cache miss: configurar propriedades do grafico OLE
                        TRY
                            WITH loc_oOle
                                .ControlSource   = "crGrafico1.gGrafico1s"
                                .AutoActivate    = 0
                                .AutoSize        = .T.
                                .Sizable         = .T.
                                .Stretch         = 2
                                .HasLegend       = .T.
                                .HasTitle        = .T.
                                .DisplayBlanksAs = 1
                                .HasAxis(2)      = .T.
                                .Type            = -4100
                                .SubType         = 1

                                WITH .ChartArea
                                    .Font.Name        = "Arial"
                                    .Font.Size        = 8
                                    .Font.Bold        = .T.
                                    .Font.Italic      = .F.
                                    .Interior.Color   = RGB(255, 255, 255)
                                    .Border.Color     = RGB(0, 0, 0)
                                    .Border.LineStyle = 1
                                    .Border.Weight    = 2
                                    .Shadow           = .T.
                                ENDWITH

                                WITH .PlotArea
                                    .Interior.Color = RGB(255, 255, 255)
                                    .Border.Color   = RGB(0, 0, 0)
                                ENDWITH

                                WITH .ChartTitle
                                    .Font.Name   = "Arial"
                                    .Font.Size   = 9
                                    .Font.Bold   = .T.
                                    .Font.Italic = .F.
                                    .Text        = THIS.this_oBusinessObject.this_cTitulo1
                                ENDWITH

                                WITH .Legend
                                    .Font.Name   = "Arial"
                                    .Font.Size   = 8
                                    .Font.Bold   = .T.
                                    .Font.Italic = .F.
                                    .Position    = 1
                                    .Shadow      = .T.
                                ENDWITH

                                WITH .Axes(1)
                                    .HasTitle               = .T.
                                    .AxisTitle.Caption      = "Meses"
                                    .AxisTitle.Font.Name    = "Arial"
                                    .AxisTitle.Font.Size    = 8
                                    .AxisTitle.Font.Bold    = .T.
                                    .AxisTitle.Font.Italic  = .F.
                                    .AxisTitle.Orientation  = 0
                                    .ReversePlotOrder       = .F.
                                    .TickLabels.Orientation = 0
                                    WITH .TickLabels.Font
                                        .Name          = "Small Fonts"
                                        .Bold          = .F.
                                        .Size          = 7
                                        .Strikethrough = .F.
                                        .Superscript   = .F.
                                        .Subscript     = .F.
                                        .OutlineFont   = .F.
                                        .Shadow        = .F.
                                    ENDWITH
                                ENDWITH

                                WITH .Axes(2)
                                    .HasTitle               = .F.
                                    .ReversePlotOrder       = .F.
                                    .HasMajorGridLines      = .T.
                                    .HasMinorGridlines      = .F.
                                    .MinimumScaleIsAuto     = .T.
                                    .MaximumScaleIsAuto     = .T.
                                    .TickLabels.Orientation  = 0
                                    .TickLabels.NumberFormat = "###,###,##0.00"
                                    WITH .TickLabels.Font
                                        .Name          = "Arial"
                                        .Bold          = .T.
                                        .Size          = 8
                                        .Strikethrough = .F.
                                        .Superscript   = .F.
                                        .Subscript     = .F.
                                        .OutlineFont   = .F.
                                        .Shadow        = .F.
                                    ENDWITH
                                ENDWITH

                                WITH .ChartGroups(1)
                                    .HasSeriesLines = .F.
                                    .GapWidth       = 10
                                    .Overlap        = (.GapWidth / 2 * -1)

                                    FOR loc_nGrupo = 1 TO THIS.this_oBusinessObject.this_nNgrupos
                                        IF TYPE("THIS.cnt_4c_Grf1.obj_4c_OleGrafico1" + ;
                                                ".ChartGroups(1).SeriesCollection(" + ;
                                                TRANSFORM(loc_nGrupo) + ")") = "O"
                                            WITH .SeriesCollection(loc_nGrupo)
                                                .ApplyDataLabels      = .T.
                                                .ApplyDataLabels.Type = 2
                                                FOR loc_nMes = 1 TO THIS.this_oBusinessObject.this_nNmeses
                                                    IF TYPE("THIS.cnt_4c_Grf1.obj_4c_OleGrafico1" + ;
                                                            ".ChartGroups(1).SeriesCollection(" + ;
                                                            TRANSFORM(loc_nGrupo) + ").Points(" + ;
                                                            TRANSFORM(loc_nMes) + ").DataLabel") = "O"
                                                        WITH .PointsDataLabel
                                                            .Top          = (.Top - 10)
                                                            .NumberFormat = "###,###,##0.00"
                                                            .Font.Name    = "Arial"
                                                            .Font.Size    = 8
                                                            .Font.Bold    = .T.
                                                            .Font.Shadow  = .F.
                                                        ENDWITH
                                                    ENDIF
                                                ENDFOR
                                            ENDWITH
                                        ENDIF
                                    ENDFOR
                                ENDWITH

                                .Refresh()
                            ENDWITH
                        CATCH TO loc_oErro
                            *-- Erros OLE nao sao fatais; grafico pode exibir parcialmente
                        ENDTRY
                    ELSE
                        *-- Cache hit: cursor ja posicionado, reforcar ControlSource e refresh
                        TRY
                            loc_oOle.ControlSource = "crGrafico1.gGrafico1s"
                            loc_oOle.Refresh()
                        CATCH TO loc_oErro
                            *-- Erros OLE nao sao fatais
                        ENDTRY
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro GerarGrafico")
        ENDTRY

        SET POINT TO (loc_cPoint)
        SET SEPARATOR TO (loc_cSep)

        THIS.Refresh()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Reseta a selecao do combo para o primeiro item e
    * regenera o grafico. Em SigPrGf2 (form OPERACIONAL de visualizacao de
    * grafico MSGraph) nao ha INSERT persistente ??? "Incluir" corresponde a
    * "nova consulta/processamento" do grafico com a chave inicial.
    * Existe para atender ao contrato da pipeline.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro

        TRY
            THIS.cnt_4c_Aguarde.Visible = .T.
            THIS.Refresh()
            THIS.LockScreen = .T.
            THIS.SetAll("Enabled", .F., "OLEBoundControl")

            *-- Regenera o grafico a partir do primeiro item do combo
            THIS.GerarGrafico(1)

            IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex = 1
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
            ENDIF

            THIS.cnt_4c_Aguarde.Visible = .F.
            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Habilita edicao interativa da chave: garante que o
    * ComboBox esteja habilitado e devolve foco ao combo para permitir troca
    * do grupo/vendedor. Nao ha UPDATE persistente em SigPrGf2 (form
    * OPERACIONAL sem entidade CRUD). Existe para atender ao contrato da
    * pipeline e como atalho equivalente a "editar selecao".
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled  = .T.
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ReadOnly = .F.

                IF THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListCount > 0
                    THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.SetFocus()
                ENDIF
            ENDIF

            THIS.Refresh()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Executa a regeracao/exibicao do grafico para a
    * chave atualmente selecionada no combo. Em forms OPERACIONAIS de
    * consulta/relatorio, "Visualizar" corresponde a executar a consulta e
    * exibir o resultado ??? delegamos para CboChave1Click para reaproveitar
    * o indicador cnt_4c_Aguarde, a chamada a GerarGrafico e o tratamento
    * de erros.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        THIS.CboChave1Click()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Limpa o cache do grafico e reseta o OLE Bound Control:
    * apaga registros do cursor crGrafico1, desvincula a ControlSource do OLE
    * e sinaliza o container de espera. Nao existe DELETE em SigPrGf2 (form
    * OPERACIONAL sem entidade persistida) ??? este evento existe para atender
    * ao contrato da pipeline e como atalho equivalente a "limpar consulta".
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro

        TRY
            THIS.LockScreen = .T.

            *-- Desvincula o OLE Bound Control (para o grafico deixar de refletir cache)
            IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
                TRY
                    THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
                CATCH TO loc_oErro
                    *-- Erros OLE nao sao fatais aqui
                ENDTRY
            ENDIF

            *-- Limpa cache do BO (ZAP em crGrafico1)
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparCursorGrafico()
                THIS.this_oBusinessObject.InicializarCursorGrafico()
            ENDIF

            *-- Estado de espera: grafico oculto, combo mantido para reselecao
            THIS.cnt_4c_Grf1.Visible    = .F.
            THIS.cnt_4c_Aguarde.Visible = .T.

            THIS.Refresh()
            THIS.LockScreen = .F.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Regenera grafico OLE para o item atualmente selecionado
    * no ComboBox. Em form OPERACIONAL de visualizacao de grafico, nao ha lista
    * de registros para carregar ??? "CarregarLista" equivale a "regenerar grafico".
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_nIdx
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
                loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
                IF loc_nIdx < 1
                    loc_nIdx = 1
                ENDIF
                loc_lSucesso = THIS.GerarGrafico(loc_nIdx)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Copia o estado atual do form (selecao do combo) para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_nIdx, loc_cChave

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        loc_cChave = ""

        IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
           PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
            loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
            IF loc_nIdx > 0
                loc_cChave = ALLTRIM(THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.List(loc_nIdx))
            ENDIF
        ENDIF

        THIS.this_oBusinessObject.this_cChave1 = loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Atualiza o form a partir do estado do BO
    * Sincroniza titulo do cabecalho com this_cCaption do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        IF !EMPTY(THIS.this_oBusinessObject.this_cCaption)
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.this_oBusinessObject.this_cCaption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.this_oBusinessObject.this_cCaption
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles do form
    * par_lHabilitar: .T. = habilitar, .F. = desabilitar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar
        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
           PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Enabled  = loc_lHabilitar
            THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ReadOnly = !loc_lHabilitar
        ENDIF

        IF VARTYPE(THIS.obj_4c_CmdgGrafico) = "O"
            THIS.obj_4c_CmdgGrafico.Enabled = loc_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta combo, limpa cache do grafico e volta ao estado
    * de espera (cnt_4c_Aguarde). Equivalente a "limpar consulta".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        LOCAL loc_oErro

        TRY
            *-- Desvincula o OLE antes de zerar cursor (evita acesso a dados liberados)
            IF VARTYPE(THIS.cnt_4c_Grf1) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf1, "obj_4c_OleGrafico1", 5)
                TRY
                    THIS.cnt_4c_Grf1.obj_4c_OleGrafico1.ControlSource = ""
                CATCH
                ENDTRY
            ENDIF

            *-- Limpa e recria cursor de cache via BO
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.LimparCursorGrafico()
                THIS.this_oBusinessObject.InicializarCursorGrafico()
            ENDIF

            *-- Resetar combo
            IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
                THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.Clear()
            ENDIF

            *-- Exibir estado de espera
            THIS.AlternarPagina("AGUARDE")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta visibilidade do CommandGroup conforme estado
    * Form OPERACIONAL sem modo CRUD: apenas garante que o CmdGroup esta visivel
    * quando o grafico foi gerado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lTemGrafico
        loc_lTemGrafico = USED("crGrafico1") AND RECCOUNT("crGrafico1") > 0

        IF VARTYPE(THIS.obj_4c_CmdgGrafico) = "O"
            THIS.obj_4c_CmdgGrafico.Visible = loc_lTemGrafico
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Dispara geracao/atualizacao do grafico para a selecao
    * atual do ComboBox. Em form OPERACIONAL de grafico, "Buscar" equivale a
    * "visualizar grafico para chave selecionada".
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CboChave1Click()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Form OPERACIONAL sem persistencia em banco de dados.
    * Dados sao gerados dinamicamente a partir do cursor crRel1 do form pai
    * e mantidos em memoria (crGrafico1). Nao ha operacao de salvamento.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        LOCAL loc_oErro, loc_nIdx
        loc_nIdx = 1

        TRY
            IF VARTYPE(THIS.cnt_4c_Grf2) = "O" AND ;
               PEMSTATUS(THIS.cnt_4c_Grf2, "cbo_4c_CmbChave1", 5)
                loc_nIdx = THIS.cnt_4c_Grf2.cbo_4c_CmbChave1.ListIndex
                IF loc_nIdx < 1
                    loc_nIdx = 1
                ENDIF
            ENDIF

            THIS.GerarGrafico(loc_nIdx)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Encerra o form (equivalente a Encerrar para este
    * form OPERACIONAL que nao tem estado editavel a cancelar).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.BtnEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * Percorre Controls e sub-containers. Estado de exibicao dos containers
    * principais (cnt_4c_Grf1/Grf2/CmdgGrafico) e gerenciado por AlternarPagina,
    * portanto este metodo e chamado antes da primeira chamada a AlternarPagina.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_CABECALHO")
                    LOOP
                ENDIF

                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
                   loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGf2BO.prg):
*==============================================================================
* SigPrGf2BO.prg - Business Object: Grafico de Falha X Recuperacao Mensal
* Herda de: BusinessBase
* Tipo: OPERACIONAL - Visualizacao de grafico OLE (MSGraph)
* Sem tabela de banco - dados vem do cursor crRel1 do form pai
*==============================================================================
DEFINE CLASS SigPrGf2BO AS BusinessBase

    *-- Identificacao da entidade (sem tabela CRUD)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Cursores utilizados
    this_cCursorOrigem  = "crRel1"      && Cursor com dados do form pai
    this_cCursorGrafico = "crGrafico1"  && Cursor de cache do grafico OLE

    *-- Configuracao do grafico
    this_nNumGrafico = 0    && Numero do grafico (pnnumgrf)
    this_cCaption    = ""   && Titulo exibido no cabecalho e no grafico

    *-- Chave de selecao atual (cmbChave1 - Grupo/Vendedor)
    this_cChave1 = ""       && Valor selecionado no ComboBox (cEmps)

    *-- Dados de titulo extraidos de crRel1
    this_cTitulo1   = ""    && Titulo linha 1 (crRel1.cTitulo1s)
    this_cTitulo2   = ""    && Titulo linha 2 (crRel1.cTitulo2s)
    this_cEmpresa   = ""    && Nome da empresa (crRel1.cEmpresas)

    *-- Series de dados (strings TAB-delimitadas para MSGraph)
    this_cStranomes  = ""   && Nomes dos meses (crRel1.cStranomes, TAB-sep)
    this_cStrFalhas  = ""   && Contagem de falhas (crRel1.nFalhas, TAB-sep)
    this_cStrPesoccb = ""   && Contagem de recuperacoes (crRel1.nPesoccbs, TAB-sep)

    *-- Dimensoes das series
    this_nNmeses  = 0       && Numero de periodos/meses encontrados
    this_nNgrupos = 2       && Numero de series no grafico (Falha + Recuperacao)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            this_cTabela     = ""
            this_cCampoChave = ""
            this_cCaption    = "Gr" + CHR(225) + "fico de Falha X Recupera" + CHR(231) + CHR(227) + "o Mensal"
            this_nNgrupos    = 2

            loc_lResultado = DODEFAULT()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave do grafico (cEmps do vendedor/grupo)
    * Sem tabela SQL persistente: chave logica eh o valor selecionado no ComboBox
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChave1)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *   par_cAliasCursor - Nome do alias (crRel1 ou crGrafico1)
    *   Se omitido, usa this_cCursorOrigem (crRel1)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_cAlias
        loc_lResultado = .F.

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         par_cAliasCursor, THIS.this_cCursorOrigem)

        TRY
            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto"
            ELSE
                SELECT (loc_cAlias)

                DO CASE
                CASE UPPER(loc_cAlias) == UPPER(THIS.this_cCursorOrigem)
                    *-- Mapeia crRel1 (cursor do form pai)
                    IF TYPE(loc_cAlias + ".cEmps") != "U"
                        THIS.this_cChave1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cEmps"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cTitulo1s") != "U"
                        THIS.this_cTitulo1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cTitulo1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cTitulo2s") != "U"
                        THIS.this_cTitulo2 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cTitulo2s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cEmpresas") != "U"
                        THIS.this_cEmpresa = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cEmpresas"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cStranomes") != "U"
                        THIS.this_cStranomes = NVL(EVALUATE(loc_cAlias + ".cStranomes"), "")
                    ENDIF
                    loc_lResultado = .T.
                CASE UPPER(loc_cAlias) == UPPER(THIS.this_cCursorGrafico)
                    *-- Mapeia crGrafico1 (cursor de cache do grafico OLE)
                    IF TYPE(loc_cAlias + ".cChave1s") != "U"
                        THIS.this_cChave1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cChave1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".ctitulo1s") != "U"
                        THIS.this_cTitulo1 = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".ctitulo1s"), ""))
                    ENDIF
                    IF TYPE(loc_cAlias + ".cempresas") != "U"
                        THIS.this_cEmpresa = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cempresas"), ""))
                    ENDIF
                    loc_lResultado = .T.
                OTHERWISE
                    THIS.this_cMensagemErro = "Alias n" + CHR(227) + "o suportado: " + loc_cAlias
                ENDCASE
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar cursor: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere registro de cache no cursor crGrafico1
    * Nao ha tabela persistente em SQL Server: cache eh mantido em memoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave = ALLTRIM(THIS.this_cChave1)

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave do gr" + CHR(225) + "fico n" + CHR(227) + "o informada"
            ELSE
                THIS.InicializarCursorGrafico()

                SELECT crGrafico1
                LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave, 100)

                IF !EOF("crGrafico1")
                    THIS.this_cMensagemErro = "Cache do gr" + CHR(225) + "fico j" + CHR(225) + " existe: " + loc_cChave
                ELSE
                    INSERT INTO crGrafico1 (cChave1s, ctitulo1s, cempresas) ;
                        VALUES (PADR(loc_cChave, 100), ;
                                PADR(THIS.this_cTitulo1, 128), ;
                                PADR(THIS.this_cEmpresa, 254))

                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir cache do gr" + CHR(225) + "fico: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro de cache do grafico
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave = ALLTRIM(THIS.this_cChave1)

            DO CASE
            CASE EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "Chave do gr" + CHR(225) + "fico n" + CHR(227) + "o informada"
            CASE !USED("crGrafico1")
                THIS.this_cMensagemErro = "Cursor crGrafico1 n" + CHR(227) + "o est" + CHR(225) + " aberto"
            OTHERWISE
                SELECT crGrafico1
                LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave, 100)

                IF EOF("crGrafico1")
                    THIS.this_cMensagemErro = "Cache do gr" + CHR(225) + "fico n" + CHR(227) + "o encontrado: " + loc_cChave
                ELSE
                    REPLACE crGrafico1.ctitulo1s WITH PADR(THIS.this_cTitulo1, 128), ;
                            crGrafico1.cempresas  WITH PADR(THIS.this_cEmpresa, 254)

                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar cache do gr" + CHR(225) + "fico: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra visualizacao do grafico em LogAuditoria
    *   par_cOperacao - "INSERT", "UPDATE" ou "VIEW"
    * Grafico OLE nao possui tabela persistente; auditoria usa "SigPrGf2" como
    *   tabela virtual e a chave selecionada como ChaveRegistro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()

            DO CASE
            CASE EMPTY(loc_cChave)
                *-- Sem chave: nao ha o que auditar
            CASE TYPE("gnConnHandle") != "N" OR gnConnHandle < 0
                *-- Sem conexao ativa: pula auditoria silenciosamente
            OTHERWISE
                loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

                loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                           "VALUES (" + EscaparSQL("SigPrGf2") + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL(loc_cChave) + ", " + ;
                           EscaparSQL(loc_cUsuario) + ", GETDATE())"

                SQLEXEC(gnConnHandle, loc_cSQL)
                loc_lResultado = .T.
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao registrar auditoria: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursorGrafico - Cria cursor crGrafico1 se nao existir
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursorGrafico()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF !USED("crGrafico1")
                SET NULL ON
                CREATE CURSOR crGrafico1 ;
                    (gGrafico1s G(4), cChave1s C(100), cempresas C(254), ctitulo1s C(128))
                SET NULL OFF
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavesGrafico - Retorna array de valores distintos de cEmps no crRel1
    *   par_aChaves - array BYREF que recebera as chaves
    *   Retorna: numero de chaves encontradas (0 se falhar)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavesGrafico(par_aChaves)
        LOCAL loc_nCount
        loc_nCount = 0

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                loc_lResultado = 0
            ENDIF

            DIMENSION par_aChaves(1)
            par_aChaves = .F.

            SELECT DISTINCT cEmps ;
                FROM (THIS.this_cCursorOrigem) ;
                ORDER BY 1 ;
                INTO ARRAY par_aChaves

            loc_nCount = ALEN(par_aChaves, 1)

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_nCount = 0
        ENDTRY

        RETURN loc_nCount
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosGrafico - Prepara crGrafico1 para a chave selecionada
    *   par_nLinha    - Indice (1-based) da chave no array de chaves
    *   par_aChaves   - Array com os valores de cEmps disponiveis
    *   Retorna .T. se os dados foram preparados com sucesso
    *   Efeito colateral: popula this_cChave1, this_cTitulo1, this_cEmpresa,
    *     this_cStranomes, this_cStrFalhas, this_cStrPesoccb, this_nNmeses
    *     e insere/garante registro em crGrafico1 (APPEND GENERAL gGrafico1s)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosGrafico(par_nLinha, par_aChaves)
        LOCAL loc_lResultado, loc_nLinha, loc_cChave1
        LOCAL loc_cTitulo1, loc_cEmpresa
        LOCAL loc_cStrg1, loc_cStrg2, loc_cStrg3, loc_nNmeses
        LOCAL loc_cTAB, loc_cCRLF

        loc_lResultado = .F.
        loc_cTAB  = CHR(9)
        loc_cCRLF = CHR(13) + CHR(10)

        TRY
            IF !USED(THIS.this_cCursorOrigem)
                loc_lResultado = .F.
            ENDIF

            loc_nLinha = IIF(VARTYPE(par_nLinha) = "N" .AND. par_nLinha > 0, par_nLinha, 1)

            IF VARTYPE(par_aChaves) != "A" OR ALEN(par_aChaves, 1) < loc_nLinha
                loc_lResultado = .F.
            ENDIF

            loc_cChave1 = ALLTRIM(par_aChaves(loc_nLinha))

            THIS.InicializarCursorGrafico()

            *-- Verificar cache
            SELECT crGrafico1
            LOCATE FOR crGrafico1.cChave1s == PADR(loc_cChave1, 100)

            IF EOF("crGrafico1")
                *-- Preparar series de dados a partir do cursor de origem
                loc_nNmeses = 0
                loc_cStrg2  = "Falha"
                loc_cStrg3  = "Recupera" + CHR(231) + CHR(227) + "o"
                loc_cStrg1  = ""
                loc_cTitulo1 = ""
                loc_cEmpresa = ""

                SELECT crRel1
                SET ORDER TO ("") IN crRel1
                LOCATE FOR crRel1.cEmps == loc_cChave1

                IF !EOF("crRel1")
                    loc_cTitulo1 = ALLTRIM(crRel1.cTitulo1s) + CHR(13) + ALLTRIM(crRel1.cTitulo2s)
                    loc_cEmpresa = crRel1.cEmpresas

                    SCAN WHILE crRel1.cEmps == loc_cChave1
                        loc_nNmeses = loc_nNmeses + 1
                        loc_cStrg1  = loc_cStrg1 + loc_cTAB + ALLTRIM(crRel1.cStranomes)
                        loc_cStrg2  = loc_cStrg2 + loc_cTAB + ;
                            ALLTRIM(TRANSFORM(crRel1.nFalhas, "999,999,999.99"))
                        loc_cStrg3  = loc_cStrg3 + loc_cTAB + ;
                            ALLTRIM(TRANSFORM(crRel1.nPesoccbs, "999,999,999.99"))
                    ENDSCAN
                ENDIF

                *-- Inserir no cache e gravar objeto OLE do grafico
                SELECT crGrafico1
                INSERT INTO crGrafico1 (cChave1s, ctitulo1s, cempresas) ;
                    VALUES (loc_cChave1, loc_cTitulo1, loc_cEmpresa)
                APPEND GENERAL gGrafico1s CLASS "MSGraph.Chart" ;
                    DATA (loc_cStrg1 + loc_cCRLF + loc_cStrg2 + loc_cCRLF + loc_cStrg3)

                *-- Atualizar propriedades do BO
                THIS.this_cChave1     = loc_cChave1
                THIS.this_cEmpresa    = loc_cEmpresa
                THIS.this_cTitulo1    = loc_cTitulo1
                THIS.this_cStranomes  = loc_cStrg1
                THIS.this_cStrFalhas  = loc_cStrg2
                THIS.this_cStrPesoccb = loc_cStrg3
                THIS.this_nNmeses     = loc_nNmeses
            ELSE
                *-- Recuperar titulo/empresa do cache
                THIS.this_cChave1  = ALLTRIM(crGrafico1.cChave1s)
                THIS.this_cTitulo1 = ALLTRIM(crGrafico1.ctitulo1s)
                THIS.this_cEmpresa = ALLTRIM(crGrafico1.cempresas)
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursorGrafico - Fecha cursor de cache do grafico
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursorGrafico()
        IF USED("crGrafico1")
            USE IN crGrafico1
        ENDIF
    ENDPROC

ENDDEFINE

