# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06b_testeAutomatico
- Tentativa: 1/10
- Mensagem: TIMEOUT: VFP9 travou durante teste automatico (300s). Possivel erro de runtime (Property not found, dialog modal).

## CONTEXTO DO ERRO

### LOG DA ETAPA (06b_testeAutomatico):
[2026-07-02 17:45:18] [INFO] === VFP EXECUTOR v2.0 ===
[2026-07-02 17:45:18] [INFO] Config FPW: (nao fornecido)
[2026-07-02 17:45:18] [INFO] Script PRG: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 17:45:18] [INFO] Timeout: 300 segundos
[2026-07-02 17:45:18] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sjvaszzu.prg
[2026-07-02 17:45:18] [INFO] Conteudo do wrapper:
[2026-07-02 17:45:18] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
* Parameters: 'FormSIGPRCPR', 'C:\4c\tasks\task168', 'OPERACIONAL'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRCPR', 'C:\4c\tasks\task168', 'OPERACIONAL'
QUIT

[2026-07-02 17:45:18] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sjvaszzu.prg
[2026-07-02 17:45:18] [INFO] VFP output esperado em: C:\4c\tasks\task168\vfp_output.txt
[2026-07-02 17:45:18] [INFO] Executando Visual FoxPro 9...
[2026-07-02 17:45:18] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sjvaszzu.prg
[2026-07-02 17:45:18] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sjvaszzu.prg
[2026-07-02 17:45:18] [INFO] Timeout configurado: 300 segundos
[2026-07-02 17:50:18] [ERROR] TIMEOUT: VFP9 nao finalizou em 300 segundos. Encerrando processo (PID: 7396)...
[2026-07-02 17:50:20] [WARN] Encerrando 2 processo(s) VFP9 residual(is)...
[2026-07-02 17:50:21] [INFO] VFP9 finalizado em 303.1045078 segundos
[2026-07-02 17:50:21] [INFO] Exit Code: 4
[2026-07-02 17:50:21] [INFO] 
[2026-07-02 17:50:21] [INFO] Arquivos temporarios preservados para inspecao:
[2026-07-02 17:50:21] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_sjvaszzu.prg
[2026-07-02 17:50:21] [INFO] 
[2026-07-02 17:50:21] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-07-02 17:50:21] [INFO] * Auto-generated wrapper for parameters
[2026-07-02 17:50:21] [INFO] * Script: C:\4c\projeto\app\utils\TesteAutomatico.prg
[2026-07-02 17:50:21] [INFO] * Parameters: 'FormSIGPRCPR', 'C:\4c\tasks\task168', 'OPERACIONAL'
[2026-07-02 17:50:21] [INFO] 
[2026-07-02 17:50:21] [INFO] * Anti-dialog protections for unattended execution
[2026-07-02 17:50:21] [INFO] SET SAFETY OFF
[2026-07-02 17:50:21] [INFO] SET RESOURCE OFF
[2026-07-02 17:50:21] [INFO] SET TALK OFF
[2026-07-02 17:50:21] [INFO] SET NOTIFY OFF
[2026-07-02 17:50:21] [INFO] SYS(2335, 0)
[2026-07-02 17:50:21] [INFO] 
[2026-07-02 17:50:21] [INFO] DO "C:\4c\projeto\app\utils\TesteAutomatico" WITH 'FormSIGPRCPR', 'C:\4c\tasks\task168', 'OPERACIONAL'
[2026-07-02 17:50:21] [INFO] QUIT
[2026-07-02 17:50:21] [INFO] 
[2026-07-02 17:50:21] [INFO] === Fim do Wrapper.prg ===
[2026-07-02 17:50:21] [ERROR] TIMEOUT: VFP9 excedeu o tempo limite de 300 segundos e foi encerrado forcadamente



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRCPR.prg):
*==============================================================================
* FormSIGPRCPR.prg - Conferencia e Reserva de Producao
* Data: 2026-07-02
* Tipo: OPERACIONAL (form plano, sem padrao CRUD/PageFrame)
* Chamado por: form pai que passa cursor_4c_TmpEnc e parametros de configuracao
*
* Filosofia 3 Pilares:
*   UX     -> layout do SCX legado (800x400 escalado para 1000x600)
*   BANCO  -> opera sobre SigOpEtq, SigMvCab, SigMvItn, SigMvHst (via BO)
*   CODE   -> arquitetura em camadas (FormBase / SIGPRCPRBO), sufixo _4c_
*
* Heranca DataSession:
*   DataSession=2 no form; InicializarForm copia DataSessionId do form pai,
*   tornando cursor_4c_TmpEnc (criado pelo pai) visivel nesta sessao.
*==============================================================================

DEFINE CLASS FormSIGPRCPR AS FormBase

    *-- Dimensoes e propriedades visuais (SCX legado 800x400 escalado para 1000x600)
    Width        = 1000
    Height       = 600
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .F.
    BorderStyle  = 2
    DataSession  = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Referencia ao form pai (para herdar datasession e habilitar ao fechar)
    this_oFormPai        = .NULL.

    *-- Data de referencia recebida do form pai
    this_dData           = {}

    *-- SigKey da sessao (CrSigCdPac.SigKeys do form pai)
    this_cSigKey         = ""

    *-- Parametros de configuracao vindos de crSigCdPam do form pai
    this_cDopeCit        = ""
    this_cDopTransf      = ""
    this_cGruConfs       = ""
    this_cConConfs       = ""
    this_cGruReservs     = ""
    this_cConReservs     = ""
    this_cGrupoEsts      = ""
    this_cContaEsts      = ""

    *-- Estado interno da grade (Grade.Visible inicia .F. no legado)
    this_lGradeVisivel   = .F.

    *--------------------------------------------------------------------------
    * Init - Captura form pai ANTES de DODEFAULT para que InicializarForm
    * encontre this_oFormPai ao ser chamado por FormBase.Init
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai)
        IF TYPE("par_oFormPai") = "O"
            THIS.this_oFormPai = par_oFormPai

            *-- Data do form pai
            IF PEMSTATUS(par_oFormPai, "txt_4c_Data", 5)
                THIS.this_dData = par_oFormPai.txt_4c_Data.Value
            ENDIF

            *-- SigKey do form pai
            IF PEMSTATUS(par_oFormPai, "this_cSigKey", 5)
                THIS.this_cSigKey = par_oFormPai.this_cSigKey
            ENDIF

            *-- Parametros de configuracao do form pai
            IF PEMSTATUS(par_oFormPai, "this_cDopeCit", 5)
                THIS.this_cDopeCit    = par_oFormPai.this_cDopeCit
                THIS.this_cDopTransf  = par_oFormPai.this_cDopTransf
                THIS.this_cGruConfs   = par_oFormPai.this_cGruConfs
                THIS.this_cConConfs   = par_oFormPai.this_cConConfs
                THIS.this_cGruReservs = par_oFormPai.this_cGruReservs
                THIS.this_cConReservs = par_oFormPai.this_cConReservs
                THIS.this_cGrupoEsts  = par_oFormPai.this_cGrupoEsts
                THIS.this_cContaEsts  = par_oFormPai.this_cContaEsts
            ENDIF
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    * Herda datasession do pai, cria cursores, configura form e monta layout
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Herdar datasession do form pai para acessar cursor_4c_TmpEnc
            *-- (equivalente ao legado: DataSessionId = ParentForm.DataSessionId)
            IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
                THIS.DataSessionId = THIS.this_oFormPai.DataSessionId
            ENDIF

            *-- Caption com acentos via CHR
            THIS.Caption = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"

            *-- Imagem de fundo (equivalente ao legado new_background.jpg)
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Criar Business Object e propagar parametros
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRCPRBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar SIGPRCPRBO", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Propagar parametros de configuracao para o BO
            THIS.PropagararParametrosBO()

            *-- Criar cursor de trabalho cursor_4c_TmpBaixa
            THIS.CriarCursorTmpBaixa()

            *-- Construcao do layout do form
            THIS.LockScreen = .T.
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaLista()
            THIS.ConfigurarPaginaDados()
            THIS.TornarControlesVisiveis(THIS)
            THIS.LockScreen = .F.

            *-- Carregar dados SE nao estiver em modo de validacao de UI
            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                THIS.CarregarBaixas()
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.LockScreen = .F.
            MsgErro(loc_oErro.Message, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PropagararParametrosBO - Transfere parametros de configuracao para o BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PropagararParametrosBO()
        IF VARTYPE(THIS.this_oBusinessObject) # "O"
            RETURN
        ENDIF

        THIS.this_oBusinessObject.this_dData       = THIS.this_dData
        THIS.this_oBusinessObject.this_cSigKey     = THIS.this_cSigKey
        THIS.this_oBusinessObject.this_cDopeCit    = THIS.this_cDopeCit
        THIS.this_oBusinessObject.this_cDopTransf  = THIS.this_cDopTransf
        THIS.this_oBusinessObject.this_cGruConfs   = THIS.this_cGruConfs
        THIS.this_oBusinessObject.this_cConConfs   = THIS.this_cConConfs
        THIS.this_oBusinessObject.this_cGruReservs = THIS.this_cGruReservs
        THIS.this_oBusinessObject.this_cConReservs = THIS.this_cConReservs
        THIS.this_oBusinessObject.this_cGrupoEsts  = THIS.this_cGrupoEsts
        THIS.this_oBusinessObject.this_cContaEsts  = THIS.this_cContaEsts
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorTmpBaixa - Cria cursor local de trabalho para as etiquetas
    * cursor_4c_TmpEnc deve ja existir (criado pelo form pai na datasession compartilhada)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorTmpBaixa()
        IF USED("cursor_4c_TmpBaixa")
            TABLEREVERT(.T., "cursor_4c_TmpBaixa")
            USE IN cursor_4c_TmpBaixa
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_TmpBaixa ;
            (CodBarra C(20) NULL, ;
             CPros    C(14) NULL, ;
             Dopes    C(20) NULL, ;
             Numes    N(6,0) NULL, ;
             Qtde     N(12,3) NULL, ;
             QtdeLido N(12,3) NULL, ;
             Nops     N(6,0) NULL, ;
             Grupods  C(10) NULL, ;
             Contads  C(10) NULL)
        SET NULL OFF

        INDEX ON CodBarra           TAG CodBarra
        INDEX ON ALLTRIM(Grupods) + ALLTRIM(Contads) TAG GruConta
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Cria container cinza do header (equivalente cntSombra)
    * Width = 1000 (escala de 800 do legado)
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
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .AutoSize      = .F.
                .Top           = 18
                .Left          = 10
                .Width         = loc_oCab.Width
                .Height        = 40
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .ForeColor     = RGB(0, 0, 0)
                .Caption       = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .AutoSize  = .F.
                .Top       = 17
                .Left      = 10
                .Width     = loc_oCab.Width
                .Height    = 46
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .FontUnderline = .F.
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Confer" + CHR(234) + "ncia e Reserva de Produ" + CHR(231) + CHR(227) + "o"
            ENDWITH
        ENDWITH

        loc_oCab.Visible = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Constroi pgf_4c_Paginas com Page1 (area principal
    * do dialog: campo Data, botoes e Grade) e Page2 (reservada para expansao).
    *
    * OPERACIONAL: Page1 concentra todo o layout original do SCX (Get_Data,
    * botoes Sair/Ok/Conferencia, Get_Leitura, Grade). Page2 fica vazia mas
    * eh criada para manter consistencia arquitetural com os demais forms.
    *
    * Os controles concretos (grid, botoes, textboxes) sao adicionados a Page1
    * nas fases seguintes (4-8) pelos metodos ConfigurarPaginaLista(),
    * ConfigurarPaginaDados(), ConfigurarBotoes(), ConfigurarGrade().
    *
    * PageFrame ocupa area abaixo do cabecalho (Top=80) ate o rodape do form.
    * Tabs=.F. porque o SCX legado nao possui abas visiveis.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oPgf

        THIS.AddObject("pgf_4c_Paginas", "PageFrame")
        loc_oPgf = THIS.pgf_4c_Paginas

        WITH loc_oPgf
            .PageCount = 2
            .Top       = 80
            .Left      = 0
            .Width     = THIS.Width
            .Height    = THIS.Height - 80
            .TabIndex  = 1
            .Tabs      = .F.
            .BorderWidth = 0
        ENDWITH

        loc_oPgf.Page1.Caption = "Lista"
        loc_oPgf.Page2.Caption = "Dados"

        *-- Containers principais da Page1 (serao populados nas fases seguintes)
        loc_oPgf.Page1.AddObject("cnt_4c_Botoes", "Container")
        WITH loc_oPgf.Page1.cnt_4c_Botoes
            .Top         = 3
            .Left        =  542
            .Width       = 300
            .Height      = 40
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPgf.Page1.AddObject("cnt_4c_BotoesAcao", "Container")
        WITH loc_oPgf.Page1.cnt_4c_BotoesAcao
            .Top         = 3
            .Left        = 725
            .Width       = 90
            .Height      = 40
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oPgf.Visible    = .T.
        loc_oPgf.ActivePage = 1
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBaixas - Chama BO para carregar etiquetas em cursor_4c_TmpBaixa
    * cursor_4c_TmpEnc deve estar populado pelo form pai na datasession
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarBaixas()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_TmpEnc")
                MsgAviso("cursor_4c_TmpEnc n" + CHR(227) + "o encontrado. " + ;
                         "O form pai deve criar este cursor antes de abrir este formul" + ;
                         CHR(225) + "rio.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.this_oBusinessObject.CarregarBaixas()

            IF loc_lSucesso
                THIS.AtualizarGrade()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarBaixas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * SKIP: Grade (Visible=.F. inicial, controlado por CarregarBaixas)
    *        txt_4c_Leitura e lbl_4c_Txt_Leitura (Visible=.F. inicial)
    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                *-- Containers/controles que devem permanecer ocultos inicialmente
                IF INLIST(UPPER(loc_oControl.Name), ;
                          "GRD_4C_DADOS", ;
                          "TXT_4C_LEITURA", ;
                          "LBL_4C_TXT_LEITURA", ;
                          "CNT_4C_CABECALHO")
                    *-- Recursao nos filhos mesmo com LOOP (filhos ficam .T.)
                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                    LOOP
                ENDIF

                loc_oControl.Visible = .T.

                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos, habilita form pai e chama DODEFAULT
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_oErro

        TRY
            *-- Liberar cursores locais
            IF USED("cursor_4c_TmpBaixa")
                USE IN cursor_4c_TmpBaixa
            ENDIF

            *-- Liberar BO
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF

            *-- Habilitar form pai (equivalente ao legado ParentForm.Enabled = .T.)
            IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
                THIS.this_oFormPai.Enabled = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Destroy")
        ENDTRY

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Popula Page1 com controles operacionais:
    * botoes de acao, campo Data, Grid de etiquetas, campo de leitura de codigo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oPagina, loc_oCntBotoes, loc_oCntBotoesAcao, loc_oGrd, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            *-- Redimensionar e popular cnt_4c_Botoes (Conf.Auto + Ok)
            loc_oCntBotoes = loc_oPagina.cnt_4c_Botoes
            WITH loc_oCntBotoes
                .Left   = 720
                .Width  = 165
                .Height = 85

                .AddObject("cmd_4c_Conferencia", "CommandButton")
                WITH .cmd_4c_Conferencia
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Caption         = "Conf. Auto"
                    .Picture         = gc_4c_CaminhoIcones + "geral_servicos_60.jpg"
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .PicturePosition = 13
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .F.
                ENDWITH

                .AddObject("cmd_4c_Ok", "CommandButton")
                WITH .cmd_4c_Ok
                    .Top             = 5
                    .Left            = 85
                    .Width           = 75
                    .Height          = 75
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Caption         = "Ok"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .PicturePosition = 13
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                    .Visible         = .F.
                ENDWITH
            ENDWITH

            *-- Redimensionar e popular cnt_4c_BotoesAcao (Encerrar)
            loc_oCntBotoesAcao = loc_oPagina.cnt_4c_BotoesAcao
            WITH loc_oCntBotoesAcao
                .Left   = 895
                .Width  = 90
                .Height = 85

                .AddObject("cmd_4c_Sair", "CommandButton")
                WITH .cmd_4c_Sair
                    .Top             = 5
                    .Left            = 5
                    .Width           = 75
                    .Height          = 75
                    .Cancel          = .T.
                    .FontBold        = .T.
                    .FontItalic      = .T.
                    .FontName        = "Tahoma"
                    .FontSize        = 8
                    .ForeColor       = RGB(90, 90, 90)
                    .BackColor       = RGB(255, 255, 255)
                    .Caption         = "Encerrar"
                    .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Themes          = .F.
                    .SpecialEffect   = 0
                    .PicturePosition = 13
                    .MousePointer    = 15
                    .WordWrap        = .T.
                    .AutoSize        = .F.
                ENDWITH
            ENDWITH

            *-- Label "Data :"
            loc_oPagina.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oPagina.lbl_4c_Label2
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Data : "
                .Height    = 15
                .Left      = 133
                .Top       = 110
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *-- TextBox Data (somente leitura, exibe data do form pai)
            loc_oPagina.AddObject("txt_4c_Data", "TextBox")
            WITH loc_oPagina.txt_4c_Data
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Alignment         = 3
                .Value             = THIS.this_dData
                .Height            = 23
                .Left              = 60
                .Top               = 44
                .Width             = 100
                .ReadOnly          = .T.
                .SpecialEffect     = 1
                .DisabledBackColor = RGB(255, 255, 255)
                .BorderColor       = RGB(100, 100, 100)
            ENDWITH

            *-- Label "Codigo de barra :" (Visible=.F. ate CarregarBaixas encontrar registros)
            loc_oPagina.AddObject("lbl_4c_Txt_Leitura", "Label")
            WITH loc_oPagina.lbl_4c_Txt_Leitura
                .AutoSize  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "C" + CHR(243) + "digo de barra :"
                .Height    = 15
                .Left      = 133
                .Top       = 359
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .F.
            ENDWITH

            *-- TextBox leitura de codigo de barras (Visible=.F. inicial)
            loc_oPagina.AddObject("txt_4c_Leitura", "TextBox")
            WITH loc_oPagina.txt_4c_Leitura
                .FontName    = "Tahoma"
                .FontSize    = 8
                .Height      = 23
                .InputMask   = "99999999999999"
                .Left        = 130
                .Top         = 451
                .Width       = 135
                .Value       = 0
                .BorderColor = RGB(100, 100, 100)
                .Visible     = .F.
            ENDWITH

            *-- Grid de etiquetas (Visible=.F. inicial, torna visivel apos CarregarBaixas)
            loc_oPagina.AddObject("grd_4c_Dados", "Grid")
            loc_oGrd = loc_oPagina.grd_4c_Dados
            loc_oGrd.ColumnCount = 3
            loc_oGrd.RecordSource = "cursor_4c_TmpBaixa"
            loc_oGrd.ColumnCount  = 5
            WITH loc_oGrd
                *-- ControlSource redefinido imediatamente apos RecordSource (evita auto-bind por posicao)
                .Column1.ControlSource = "cursor_4c_TmpBaixa.CodBarra"
                .Column2.ControlSource = "cursor_4c_TmpBaixa.CPros"
                .Column3.ControlSource = "cursor_4c_TmpBaixa.Dopes"
                .Column4.ControlSource = "cursor_4c_TmpBaixa.Numes"
                .Column5.ControlSource = "cursor_4c_TmpBaixa.QtdeLido"

                .FontName          = "Verdana"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .Height            = 336
                .Left              = 12
                .ReadOnly          = .T.
                .RowHeight         = 17
                .ScrollBars        = 2
                .Top               = 98
                .Width             = 940
                .Panel             = 1
                .Visible           = .F.

                *-- Propriedades visuais das colunas
                .Column1.Width = 135
                .Column1.Movable = .F.
                .Column1.Resizable = .F.
                .Column1.ReadOnly = .T.
                .Column1.DynamicForeColor = "IIF(cursor_4c_TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
                .Column2.Width = 135
                .Column2.Movable = .F.
                .Column2.Resizable = .F.
                .Column2.ReadOnly = .T.
                .Column2.DynamicForeColor = "IIF(cursor_4c_TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
                .Column3.Width = 193
                .Column3.Movable = .F.
                .Column3.Resizable = .F.
                .Column3.ReadOnly = .T.
                .Column3.DynamicForeColor = "IIF(cursor_4c_TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
                .Column4.Width = 76
                .Column4.Movable = .F.
                .Column4.Resizable = .F.
                .Column4.ReadOnly = .T.
                .Column4.DynamicForeColor = "IIF(cursor_4c_TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"
                .Column5.Width = 94
                .Column5.Movable = .F.
                .Column5.Resizable = .F.
                .Column5.ReadOnly = .T.
                .Column5.DynamicForeColor = "IIF(cursor_4c_TmpBaixa.QtdeLido#0,RGB(0,0,255),RGB(0,0,0))"

                *-- Headers (reconfigurar apos RecordSource pois VFP9 os reseta)
                .Column1.Header1.Caption   = "C" + CHR(243) + "d. Barra"
                .Column1.Header1.FontName  = "Tahoma"
                .Column1.Header1.FontSize  = 8
                .Column1.Header1.Alignment = 2
                .Column2.Header1.Caption   = "Produto"
                .Column2.Header1.FontName  = "Tahoma"
                .Column2.Header1.FontSize  = 8
                .Column2.Header1.Alignment = 2
                .Column3.Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
                .Column3.Header1.FontName  = "Tahoma"
                .Column3.Header1.FontSize  = 8
                .Column3.Header1.Alignment = 2
                .Column4.Header1.Caption   = "N" + CHR(250) + "mero"
                .Column4.Header1.FontName  = "Tahoma"
                .Column4.Header1.FontSize  = 8
                .Column4.Header1.Alignment = 2
                .Column5.Header1.Caption   = "Qtde."
                .Column5.Header1.FontName  = "Tahoma"
                .Column5.Header1.FontSize  = 8
                .Column5.Header1.Alignment = 2
            ENDWITH

            *-- BINDEVENTs (metodos PUBLIC por default em DEFINE CLASS)
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia, "Click", THIS, "CmdConferenciaClick")
            BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
            BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Sair, "Click", THIS, "CmdSairClick")
            BINDEVENT(loc_oPagina.txt_4c_Leitura, "KeyPress", THIS, "TxtLeituraKeyPress")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna a pagina ativa do PageFrame
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
            THIS.pgf_4c_Paginas.ActivePage = par_nPagina
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarGrade - Atualiza visibilidade dos controles conforme registros em
    * cursor_4c_TmpBaixa (equivalente ao bloco final do legado carregabars)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarGrade()
        LOCAL loc_lTemDados, loc_oPagina, loc_oErro

        TRY
            IF !USED("cursor_4c_TmpBaixa")
                RETURN
            ENDIF

            SELECT cursor_4c_TmpBaixa
            GO TOP
            loc_lTemDados = !EOF()

            loc_oPagina = THIS.pgf_4c_Paginas.Page1

            loc_oPagina.grd_4c_Dados.Visible                    = loc_lTemDados
            loc_oPagina.txt_4c_Leitura.Visible                   = loc_lTemDados
            loc_oPagina.lbl_4c_Txt_Leitura.Visible               = loc_lTemDados
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok.Visible          = loc_lTemDados
            loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia.Visible = loc_lTemDados

            IF loc_lTemDados
                loc_oPagina.grd_4c_Dados.Refresh()
                loc_oPagina.txt_4c_Leitura.SetFocus()
            ELSE
                MsgAviso("Nenhuma Etiqueta Selecionada Nesta Opera" + ;
                         CHR(231) + CHR(227) + "o!!!", "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro AtualizarGrade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdConferenciaClick - Conf. Auto: marca todas etiquetas como lidas e
    * atualiza grid (equivalente ao legado Conferencia.Click)
    *--------------------------------------------------------------------------
    PROCEDURE CmdConferenciaClick()
        LOCAL loc_oErro

        TRY
            THIS.this_oBusinessObject.MarcarTodasLidas()
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CmdConferenciaClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdOkClick - Confirma conferencia, grava movimentacoes e encerra form
    * (equivalente ao legado Ok.Click)
    *--------------------------------------------------------------------------
    PROCEDURE CmdOkClick()
        LOCAL loc_lSucesso, loc_oErro

        TRY
            IF !MsgConfirma("Confirma a Confer" + CHR(234) + "ncia das Etiquetas?", "Confirmar")
                THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()
                RETURN
            ENDIF

            loc_lSucesso = THIS.this_oBusinessObject.ProcessarConferencia()

            IF loc_lSucesso
                IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
                    THIS.this_oFormPai.Enabled = .T.
                ENDIF
                THIS.Release()
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CmdOkClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdSairClick - Habilita form pai e fecha este form
    * (equivalente ao legado Sair.Click)
    *--------------------------------------------------------------------------
    PROCEDURE CmdSairClick()
        IF VARTYPE(THIS.this_oFormPai) = "O" AND THIS.this_oFormPai != THIS
            THIS.this_oFormPai.Enabled = .T.
        ENDIF
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Configura Page2 do PageFrame
    * Este form OPERACIONAL nao possui controles interativos em Page2.
    * O layout completo (campo Data, grid, leitura de codigo) esta em Page1.
    * Page2 recebe apenas a imagem de fundo para consistencia visual do sistema.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oPagina, loc_oErro

        TRY
            loc_oPagina = THIS.pgf_4c_Paginas.Page2
            loc_oPagina.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TxtLeituraKeyPress - Processa leitura de codigo de barras
    * Simula Valid do legado via KeyPress (ENTER=13 ou TAB=9)
    * BINDEVENT "Valid" nao funciona em TextBox no VFP9
    *--------------------------------------------------------------------------
    PROCEDURE TxtLeituraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_oTxt, loc_oGrd, loc_cCodBarra, loc_oErro

        IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
            RETURN
        ENDIF

        TRY
            loc_oTxt      = THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura
            loc_oGrd      = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
            loc_cCodBarra = ALLTRIM(TRANSFORM(loc_oTxt.Value))

            IF !EMPTY(loc_cCodBarra) AND loc_cCodBarra <> "0"
                THIS.this_oBusinessObject.RegistrarLeitura(loc_cCodBarra)

                *-- Posicionar cursor no registro lido para atualizar highlighting
                IF USED("cursor_4c_TmpBaixa")
                    SELECT cursor_4c_TmpBaixa
                    SET ORDER TO TAG CodBarra
                    SEEK loc_cCodBarra
                ENDIF
            ENDIF

            loc_oTxt.Value = 0
            loc_oGrd.Refresh()
            loc_oTxt.SetFocus()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro TxtLeituraKeyPress")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia nova leitura de codigo de barras
    * Form OPERACIONAL: "Incluir" = adicionar nova leitura (foco no reader)
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oTxt, loc_oErro

        TRY
            loc_oTxt = THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura
            loc_oTxt.Value = 0
            loc_oTxt.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Marca todas etiquetas como conferidas (Conf. Auto)
    * Form OPERACIONAL: "Alterar" = alterar estado de todas para conferido
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_TmpBaixa") OR RECCOUNT("cursor_4c_TmpBaixa") = 0
                MsgAviso("Nenhuma etiqueta dispon" + CHR(237) + "vel para conferir.", "Aviso")
                RETURN
            ENDIF

            THIS.this_oBusinessObject.MarcarTodasLidas()
            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Atualiza visualizacao da grade
    * Form OPERACIONAL: "Visualizar" = refresh grade e reposicionar
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oGrd, loc_oErro

        TRY
            loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados

            IF USED("cursor_4c_TmpBaixa")
                SELECT cursor_4c_TmpBaixa
                GO TOP
            ENDIF

            loc_oGrd.Refresh()
            loc_oGrd.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Limpa leituras da etiqueta corrente do grid
    * Form OPERACIONAL: "Excluir" = zerar QtdeLido do registro corrente
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro

        TRY
            IF !USED("cursor_4c_TmpBaixa") OR RECCOUNT("cursor_4c_TmpBaixa") = 0
                MsgAviso("Nenhuma etiqueta dispon" + CHR(237) + "vel para excluir leitura.", "Aviso")
                RETURN
            ENDIF

            SELECT cursor_4c_TmpBaixa

            IF EOF() OR BOF()
                MsgAviso("Selecione uma etiqueta na grade para excluir a leitura.", "Aviso")
                RETURN
            ENDIF

            IF NVL(cursor_4c_TmpBaixa.QtdeLido, 0) = 0
                MsgAviso("Esta etiqueta ainda n" + CHR(227) + "o foi lida.", "Aviso")
                RETURN
            ENDIF

            IF !MsgConfirma("Confirma limpar a leitura desta etiqueta?", "Confirmar")
                RETURN
            ENDIF

            REPLACE QtdeLido WITH 0 IN cursor_4c_TmpBaixa

            THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
            THIS.pgf_4c_Paginas.Page1.txt_4c_Leitura.SetFocus()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - Recarrega etiquetas (refresh completo das baixas)
    * Form OPERACIONAL: "Buscar" = reprocessar etiquetas do cursor_4c_TmpEnc
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_oErro

        TRY
            THIS.CarregarBaixas()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Habilita form pai e fecha este form
    * Form OPERACIONAL: equivalente ao botao Encerrar/Sair
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.CmdSairClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirma a conferencia das etiquetas e fecha form
    * Form OPERACIONAL: equivalente ao botao Ok
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdOkClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela leitura atual (limpa campo de codigo de barras)
    * Form OPERACIONAL: "Cancelar" = reiniciar leitura sem perder dados da grade
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro

        TRY
            THIS.LimparCampos()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transfere valores atuais do form para o BO
    * Form OPERACIONAL: sincroniza data e propaga parametros de configuracao
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF

            *-- Capturar data atual do campo (pode ter sido alterada pelo pai)
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Data", 5)
                    THIS.this_dData = THIS.pgf_4c_Paginas.Page1.txt_4c_Data.Value
                ENDIF
            ENDIF

            *-- Propagar todos os parametros de configuracao para o BO
            THIS.PropagararParametrosBO()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transfere valores do BO para os controles do form
    * Form OPERACIONAL: atualiza campo de data com valor do BO
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                RETURN
            ENDIF

            *-- Sincronizar campo de data com valor do BO
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_Data", 5)
                    THIS.pgf_4c_Paginas.Page1.txt_4c_Data.Value = THIS.this_oBusinessObject.this_dData
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita controles conforme presenca de dados
    * Form OPERACIONAL: campo de leitura e botoes Ok/Conf.Auto ativam so com dados
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos()
        LOCAL loc_lTemDados, loc_oPagina, loc_oErro

        TRY
            loc_lTemDados = USED("cursor_4c_TmpBaixa") AND RECCOUNT("cursor_4c_TmpBaixa") > 0

            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPagina = THIS.pgf_4c_Paginas.Page1

                IF PEMSTATUS(loc_oPagina, "txt_4c_Leitura", 5)
                    loc_oPagina.txt_4c_Leitura.Enabled  = loc_lTemDados
                    loc_oPagina.txt_4c_Leitura.Visible  = loc_lTemDados
                ENDIF

                IF PEMSTATUS(loc_oPagina, "lbl_4c_Txt_Leitura", 5)
                    loc_oPagina.lbl_4c_Txt_Leitura.Visible = loc_lTemDados
                ENDIF

                IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
                    IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Ok", 5)
                        loc_oPagina.cnt_4c_Botoes.cmd_4c_Ok.Visible = loc_lTemDados
                    ENDIF
                    IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Conferencia", 5)
                        loc_oPagina.cnt_4c_Botoes.cmd_4c_Conferencia.Visible = loc_lTemDados
                    ENDIF
                ENDIF

                IF PEMSTATUS(loc_oPagina, "grd_4c_Dados", 5)
                    loc_oPagina.grd_4c_Dados.Visible = loc_lTemDados
                    IF loc_lTemDados
                        loc_oPagina.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Limpa campo de leitura de codigo de barras
    * Form OPERACIONAL: reinicia leitura sem alterar dados da grade
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        LOCAL loc_oPagina, loc_oErro

        TRY
            IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
                loc_oPagina = THIS.pgf_4c_Paginas.Page1

                IF PEMSTATUS(loc_oPagina, "txt_4c_Leitura", 5)
                    loc_oPagina.txt_4c_Leitura.Value = 0
                    IF loc_oPagina.txt_4c_Leitura.Visible
                        loc_oPagina.txt_4c_Leitura.SetFocus()
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Wrapper sobre CarregarBaixas para conformidade com FormBase
    * Form OPERACIONAL: reprocessa etiquetas do cursor_4c_TmpEnc
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        RETURN THIS.CarregarBaixas()
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta visibilidade dos botoes conforme estado dos dados
    * Form OPERACIONAL: delega para AtualizarGrade que gerencia visibilidade
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        THIS.AtualizarGrade()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRCPRBO.prg):
*==============================================================================
* SIGPRCPRBO.prg - Business Object para Conferencia e Reserva de Producao
* Herda de: BusinessBase
* Tabela principal: SigOpEtq (etiquetas de producao)
*==============================================================================

DEFINE CLASS SIGPRCPRBO AS BusinessBase

    *-- Chave e tabela principal
    this_cTabela      = "SigOpEtq"
    this_cCampoChave  = "CBars"

    *-- Data de referencia (Get_Data do form pai)
    this_dData        = {}

    *-- Chave unica da sessao (CrSigCdPac.SigKeys)
    this_cSigKey      = ""

    *-- Parametros vindos de crSigCdPam
    this_cDopeCit     = ""
    this_cDopTransf   = ""
    this_cGruConfs    = ""
    this_cConConfs    = ""
    this_cGruReservs  = ""
    this_cConReservs  = ""
    this_cGrupoEsts   = ""
    this_cContaEsts   = ""

    *-- Campos do cursor cursor_4c_TmpBaixa (linha corrente)
    this_cCodBarra    = ""
    this_cCPros       = ""
    this_cDopes       = ""
    this_nNumes       = 0
    this_nQtde        = 0
    this_nQtdeLido    = 0
    this_nNops        = 0
    this_cGrupods     = ""
    this_cContads     = ""

    *-- Estado interno
    this_lGradeVisivel = .F.
    this_nSeqContador  = 0

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        TRY
            DODEFAULT()
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades this_
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodBarra  = TratarNulo(CodBarra,  "C")
                THIS.this_cCPros     = TratarNulo(CPros,     "C")
                THIS.this_cDopes     = TratarNulo(Dopes,     "C")
                THIS.this_nNumes     = TratarNulo(Numes,     "N")
                THIS.this_nQtde      = TratarNulo(Qtde,      "N")
                THIS.this_nQtdeLido  = TratarNulo(QtdeLido,  "N")
                THIS.this_nNops      = TratarNulo(Nops,      "N")
                THIS.this_cGrupods   = TratarNulo(Grupods,   "C")
                THIS.this_cContads   = TratarNulo(Contads,   "C")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBaixas - Carrega etiquetas de producao em cursor_4c_TmpBaixa
    * Equivalente ao legado carregabars.
    * Pre-requisito: cursor_4c_TmpEnc deve existir (Dopps C, Numps N)
    * cursor_4c_TmpBaixa deve existir com tags CodBarra e GruConta
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBaixas()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL
        LOCAL loc_cDopps, loc_nNumps, loc_cChave
        LOCAL loc_cGruConfs, loc_cConConfs
        LOCAL loc_cGruReservs, loc_cConReservs
        LOCAL loc_cGrupoEsts, loc_cContaEsts, loc_cDopeCit
        LOCAL loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs
        LOCAL loc_nNops, loc_cEmpos, loc_cCodCors, loc_cCodTams
        LOCAL loc_nQtEti, loc_nQtCit, loc_nBaixa, loc_nPendente, loc_nPVal
        LOCAL loc_llBaixa, loc_cTGrupo, loc_cTConta, loc_cGrupo, loc_cConta
        LOCAL loc_cEmpDopNumsCit

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_TmpBaixa")
                MsgErro("cursor_4c_TmpBaixa n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_TmpEnc")
                MsgErro("cursor_4c_TmpEnc n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Limpar TmpBaixa
            SELECT cursor_4c_TmpBaixa
            ZAP

            loc_cGruConfs   = ALLTRIM(THIS.this_cGruConfs)
            loc_cConConfs   = ALLTRIM(THIS.this_cConConfs)
            loc_cGruReservs = ALLTRIM(THIS.this_cGruReservs)
            loc_cConReservs = ALLTRIM(THIS.this_cConReservs)
            loc_cGrupoEsts  = ALLTRIM(THIS.this_cGrupoEsts)
            loc_cContaEsts  = ALLTRIM(THIS.this_cContaEsts)
            loc_cDopeCit    = ALLTRIM(THIS.this_cDopeCit)

            SELECT cursor_4c_TmpEnc
            GO TOP

            SCAN FOR !EMPTY(Dopps) AND !EMPTY(Numps)
                loc_cDopps = ALLTRIM(cursor_4c_TmpEnc.Dopps)
                loc_nNumps = cursor_4c_TmpEnc.Numps
                loc_cChave = go_4c_Sistema.cCodEmpresa + loc_cDopps + STR(loc_nNumps, 6)

                *-- Buscar etiquetas desta OS
                loc_cSQL = "SELECT e.CBars, e.CPros, e.DopeOs, e.NumeOs, e.Qtds, e.Nops, " + ;
                           "e.Empos, e.CodCors, e.CodTams, e.Grupos, e.Contas " + ;
                           "FROM SigOpEtq e " + ;
                           "WHERE e.EmpDopNums = " + EscaparSQL(loc_cChave)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpEtqBx") > 0
                    SELECT cursor_4c_SigOpEtqBx
                    SCAN
                        *-- Verificar se etiqueta pertence ao grupo/conta de conferencia
                        IF ALLTRIM(cursor_4c_SigOpEtqBx.Grupos) + ALLTRIM(cursor_4c_SigOpEtqBx.Contas) <> ;
                           loc_cGruConfs + loc_cConConfs
                            LOOP
                        ENDIF

                        loc_cCBars   = ALLTRIM(cursor_4c_SigOpEtqBx.CBars)
                        loc_cCPros   = ALLTRIM(cursor_4c_SigOpEtqBx.CPros)
                        loc_cDopeOs  = ALLTRIM(cursor_4c_SigOpEtqBx.DopeOs)
                        loc_nNumeOs  = cursor_4c_SigOpEtqBx.NumeOs
                        loc_nNops    = cursor_4c_SigOpEtqBx.Nops
                        loc_cEmpos   = ALLTRIM(cursor_4c_SigOpEtqBx.Empos)
                        loc_cCodCors = ALLTRIM(cursor_4c_SigOpEtqBx.CodCors)
                        loc_cCodTams = ALLTRIM(cursor_4c_SigOpEtqBx.CodTams)
                        loc_nQtEti   = cursor_4c_SigOpEtqBx.Qtds
                        loc_nQtCit   = 0

                        *-- Buscar movimento origem para determinar grupos/contas
                        loc_cSQL = "SELECT TOP 1 m.Dopes, m.Grupoos, m.Contaos, m.Grupods, m.Contads " + ;
                                   "FROM SigMvCab m " + ;
                                   "WHERE m.EmpDopNums = " + EscaparSQL(loc_cEmpos + loc_cDopeOs + STR(loc_nNumeOs, 6))

                        IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCabBx") > 0
                            SELECT cursor_4c_MvCabBx
                            IF !EOF()
                                *-- Verificar tipo de operacao (Globalizas/Servicos)
                                loc_cSQL = "SELECT TOP 1 Globalizas, Servicos FROM SigCdOpe " + ;
                                           "WHERE Dopes = " + EscaparSQL(ALLTRIM(cursor_4c_MvCabBx.Dopes))

                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpeBx") > 0
                                    SELECT cursor_4c_SigCdOpeBx
                                    IF !EOF() AND (NVL(cursor_4c_SigCdOpeBx.Globalizas, 0) = 1 OR ;
                                                   NVL(cursor_4c_SigCdOpeBx.Servicos, 0) = 1)
                                        loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupoos)
                                        loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contaos)
                                    ELSE
                                        loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupods)
                                        loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contads)
                                    ENDIF
                                    IF USED("cursor_4c_SigCdOpeBx")
                                        USE IN cursor_4c_SigCdOpeBx
                                    ENDIF
                                ELSE
                                    loc_cTGrupo = ALLTRIM(cursor_4c_MvCabBx.Grupods)
                                    loc_cTConta = ALLTRIM(cursor_4c_MvCabBx.Contads)
                                ENDIF

                                *-- Aplicar override de GruReservs/ConReservs
                                loc_cGrupo = IIF(EMPTY(loc_cGruReservs), loc_cTGrupo, loc_cGruReservs)
                                loc_cConta = IIF(EMPTY(loc_cConReservs), loc_cTConta, loc_cConReservs)

                                *-- Processar operacao de citacao (DopeCit) se configurada
                                IF !EMPTY(loc_cDopeCit)
                                    loc_cEmpDopNumsCit = loc_cEmpos + loc_cDopeCit + STR(loc_nNumeOs, 6)
                                    loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigMvCab " + ;
                                               "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit)
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCit") > 0
                                        SELECT cursor_4c_ChkCit
                                        IF !EOF() AND NVL(cursor_4c_ChkCit.nExiste, 0) > 0
                                            loc_nBaixa = loc_nQtEti

                                                *-- Baixar SigMvItn (itens simples por produto)
                                                loc_cSQL = "SELECT cIdChaves, QtBaixas, Qtds " + ;
                                                           "FROM SigMvItn " + ;
                                                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit) + ;
                                                           " AND CPros = " + EscaparSQL(loc_cCPros)
                                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnCit") > 0
                                                    SELECT cursor_4c_ItnCit
                                                    GO TOP
                                                    SCAN WHILE !EOF("cursor_4c_ItnCit") AND loc_nBaixa > 0
                                                        IF (cursor_4c_ItnCit.Qtds - cursor_4c_ItnCit.QtBaixas) <> 0
                                                            loc_nPendente = cursor_4c_ItnCit.Qtds - cursor_4c_ItnCit.QtBaixas
                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nPVal  = loc_nBaixa
                                                                loc_nBaixa = 0
                                                            ELSE
                                                                loc_nPVal  = loc_nPendente
                                                                loc_nBaixa = loc_nBaixa - loc_nPendente
                                                            ENDIF
                                                            loc_llBaixa = IIF(cursor_4c_ItnCit.QtBaixas + loc_nPVal = cursor_4c_ItnCit.Qtds, 1, 0)
                                                            loc_cSQL = "UPDATE SigMvItn " + ;
                                                                       "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                       "ChkSubn = " + TRANSFORM(loc_llBaixa) + ", " + ;
                                                                       "DtAlts = GETDATE() " + ;
                                                                       "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItnCit.cIdChaves))
                                                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdItn")
                                                            IF USED("cursor_4c_UpdItn")
                                                                USE IN cursor_4c_UpdItn
                                                            ENDIF
                                                        ENDIF
                                                        SELECT cursor_4c_ItnCit
                                                    ENDSCAN
                                                    IF USED("cursor_4c_ItnCit")
                                                        USE IN cursor_4c_ItnCit
                                                    ENDIF
                                                ENDIF
                                                *-- Baixar SigMvIts (itens com cor/tamanho)
                                                loc_cSQL = "SELECT cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds " + ;
                                                           "FROM SigMvIts " + ;
                                                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNumsCit) + ;
                                                           " AND CPros = " + EscaparSQL(loc_cCPros) + ;
                                                           " AND CodCors = " + EscaparSQL(loc_cCodCors) + ;
                                                           " AND CodTams = " + EscaparSQL(loc_cCodTams)
                                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItsCit") > 0
                                                    SELECT cursor_4c_ItsCit
                                                    SCAN WHILE !EOF("cursor_4c_ItsCit") AND loc_nBaixa > 0
                                                        loc_nPendente = cursor_4c_ItsCit.Qtds - cursor_4c_ItsCit.QtBaixas
                                                        IF loc_nPendente <> 0
                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nPVal = loc_nBaixa
                                                            ELSE
                                                                loc_nPVal = loc_nPendente
                                                            ENDIF
                                                            loc_llBaixa = IIF(cursor_4c_ItsCit.QtBaixas + loc_nPVal = cursor_4c_ItsCit.Qtds, 1, 0)

                                                            loc_cSQL = "UPDATE SigMvIts " + ;
                                                                       "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                       "ChkSubn = " + TRANSFORM(loc_llBaixa) + " " + ;
                                                                       "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItsCit.cIdChaves))
                                                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdIts")
                                                            IF USED("cursor_4c_UpdIts")
                                                                USE IN cursor_4c_UpdIts
                                                            ENDIF

                                                            *-- Atualizar SigMvItn correspondente ao item
                                                            loc_cSQL = "SELECT cIdChaves FROM SigMvItn " + ;
                                                                       "WHERE EmpDopNums = " + EscaparSQL(ALLTRIM(cursor_4c_ItsCit.EmpDopNums)) + ;
                                                                       " AND CItens = " + TRANSFORM(cursor_4c_ItsCit.CItens)
                                                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnCorr") > 0
                                                                SELECT cursor_4c_ItnCorr
                                                                IF !EOF()
                                                                    loc_cSQL = "UPDATE SigMvItn " + ;
                                                                               "SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nPVal) + ", " + ;
                                                                               "DtAlts = GETDATE() " + ;
                                                                               "WHERE cIdChaves = " + EscaparSQL(ALLTRIM(cursor_4c_ItnCorr.cIdChaves))
                                                                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdItnC")
                                                                    IF USED("cursor_4c_UpdItnC")
                                                                        USE IN cursor_4c_UpdItnC
                                                                    ENDIF
                                                                ENDIF
                                                                IF USED("cursor_4c_ItnCorr")
                                                                    USE IN cursor_4c_ItnCorr
                                                                ENDIF
                                                            ENDIF

                                                            IF loc_nPendente > loc_nBaixa
                                                                loc_nBaixa = 0
                                                            ELSE
                                                                loc_nBaixa = loc_nBaixa - loc_nPendente
                                                            ENDIF
                                                        ENDIF
                                                        SELECT cursor_4c_ItsCit
                                                    ENDSCAN
                                                    IF USED("cursor_4c_ItsCit")
                                                        USE IN cursor_4c_ItsCit
                                                    ENDIF
                                                ENDIF

                                            loc_nQtCit = loc_nQtEti - loc_nBaixa
                                        ENDIF
                                        IF USED("cursor_4c_ChkCit")
                                            USE IN cursor_4c_ChkCit
                                        ENDIF
                                    ENDIF
                                ENDIF

                                *-- Calcular quantidade que vai para TmpBaixa
                                loc_nQtEti = cursor_4c_SigOpEtqBx.Qtds - loc_nQtCit

                                *-- Inserir na TmpBaixa (quantidade principal -> grupo/conta destino)
                                IF loc_nQtEti <> 0
                                    INSERT INTO cursor_4c_TmpBaixa ;
                                        (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                        VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                                loc_nQtEti, 0, loc_nNops, loc_cGrupo, loc_cConta)
                                ENDIF

                                *-- Inserir na TmpBaixa (quantidade citacao -> grupo/conta estoque)
                                IF loc_nQtCit <> 0
                                    INSERT INTO cursor_4c_TmpBaixa ;
                                        (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                        VALUES (loc_cCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, ;
                                                loc_nQtCit, 0, loc_nNops, loc_cGrupoEsts, loc_cContaEsts)
                                ENDIF
                            ENDIF
                            IF USED("cursor_4c_MvCabBx")
                                USE IN cursor_4c_MvCabBx
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_SigOpEtqBx
                    ENDSCAN

                    IF USED("cursor_4c_SigOpEtqBx")
                        USE IN cursor_4c_SigOpEtqBx
                    ENDIF
                ENDIF

                SELECT cursor_4c_TmpEnc
            ENDSCAN

            *-- Posicionar no inicio da TmpBaixa
            IF USED("cursor_4c_TmpBaixa")
                SELECT cursor_4c_TmpBaixa
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarLeitura - Marca codigo de barras como lido na cursor_4c_TmpBaixa
    * Equivalente ao legado Get_Leitura.Valid
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarLeitura(par_cCodBarra)
        LOCAL loc_lSucesso, loc_oErro, loc_cCodBarra

        loc_lSucesso = .F.
        loc_cCodBarra = ALLTRIM(par_cCodBarra)

        TRY
            IF EMPTY(loc_cCodBarra) OR !USED("cursor_4c_TmpBaixa")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_TmpBaixa
            SET ORDER TO TAG CodBarra

            IF SEEK(loc_cCodBarra)
                IF cursor_4c_TmpBaixa.QtdeLido = 0
                    REPLACE QtdeLido WITH cursor_4c_TmpBaixa.Qtde IN cursor_4c_TmpBaixa
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("C" + CHR(243) + "digo de Barras J" + CHR(225) + " Foi Lido!!!", "Aviso")
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                MsgAviso("C" + CHR(243) + "digo de Barras N" + CHR(227) + "o Cadastrado!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasLidas - Marca todas etiquetas como lidas (Conferencia Auto)
    * Equivalente ao legado Conferencia.Click
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodasLidas()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpBaixa")
                SELECT cursor_4c_TmpBaixa
                SET ORDER TO TAG CodBarra
                REPLACE ALL QtdeLido WITH Qtde IN cursor_4c_TmpBaixa
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarConferencia - Processa confirmacao da conferencia (equivalente Ok.Click)
    * Cria SigMvCab + SigMvItn + SigMvHst e atualiza SigOpEtq para cada item lido
    * Pre-requisito: this_cDopTransf, this_cGruConfs, this_cConConfs, this_cSigKey devem estar setados
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarConferencia()
        LOCAL loc_lSucesso, loc_oErro, loc_llTaOk
        LOCAL loc_cSQL, loc_nNume, loc_cDopTransf
        LOCAL loc_cGruConfs, loc_cConConfs
        LOCAL loc_nItem, loc_cPCidC, loc_nPSeq
        LOCAL loc_cGrupods, loc_cContads, loc_cEmpDopNums
        LOCAL loc_cCPros, loc_cCodBarra, loc_nQtdeLido
        LOCAL loc_cDPros, loc_cCUnis
        LOCAL loc_cEmposItm, loc_cCodCors2, loc_cCodTams2

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_TmpBaixa")
                MsgErro("cursor_4c_TmpBaixa n" + CHR(227) + "o encontrado!", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_cDopTransf = ALLTRIM(THIS.this_cDopTransf)
            loc_cGruConfs  = ALLTRIM(THIS.this_cGruConfs)
            loc_cConConfs  = ALLTRIM(THIS.this_cConConfs)

            *-- Iniciar transacao
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trans")
            IF USED("cursor_4c_Trans")
                USE IN cursor_4c_Trans
            ENDIF

            loc_llTaOk = .T.

            *-- Obter grupos/contas distintos com itens lidos
            SELECT DISTINCT Grupods, Contads FROM cursor_4c_TmpBaixa ;
                WHERE QtdeLido <> 0 ;
                INTO CURSOR cursor_4c_xCabec READWRITE

            SELECT cursor_4c_xCabec
            GO TOP

            SCAN WHILE !EOF("cursor_4c_xCabec") AND loc_llTaOk
                loc_cGrupods = ALLTRIM(cursor_4c_xCabec.Grupods)
                loc_cContads = ALLTRIM(cursor_4c_xCabec.Contads)

                *-- Gerar numero unico do movimento
                loc_nNume      = THIS.GerarChaveUnica(go_4c_Sistema.cCodEmpresa + loc_cDopTransf)
                loc_cEmpDopNums = go_4c_Sistema.cCodEmpresa + loc_cDopTransf + STR(loc_nNume, 6)

                *-- Inserir cabecalho SigMvCab
                loc_cSQL = "INSERT INTO SigMvCab " + ;
                           "(Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, " + ;
                           "Grupoos, Contaos, Grupods, Contads, EmpDopNums, cIdChaves, DtAlts, EmpGopNums) " + ;
                           "VALUES (" + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                           EscaparSQL(loc_cDopTransf) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           EscaparSQL(THIS.GerarMascara(loc_nNume)) + ", " + ;
                           "GETDATE(), GETDATE(), " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           EscaparSQL(loc_cGruConfs) + ", " + ;
                           EscaparSQL(loc_cConConfs) + ", " + ;
                           EscaparSQL(loc_cGrupods) + ", " + ;
                           EscaparSQL(loc_cContads) + ", " + ;
                           EscaparSQL(loc_cEmpDopNums) + ", " + ;
                           EscaparSQL(THIS.GerarIdUnico()) + ", " + ;
                           "GETDATE(), " + ;
                           EscaparSQL(go_4c_Sistema.cCodEmpresa + SPACE(20) + STR(0, 6)) + ")"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResCab") < 1
                    MsgErro("Falha ao inserir SigMvCab!", "Erro")
                    loc_llTaOk = .F.
                    EXIT
                ENDIF
                IF USED("cursor_4c_ResCab")
                    USE IN cursor_4c_ResCab
                ENDIF

                *-- Iterar itens deste grupo/conta
                loc_nItem = 0
                SELECT cursor_4c_TmpBaixa
                SET ORDER TO TAG GruConta
                SEEK loc_cGrupods + loc_cContads

                SCAN WHILE ALLTRIM(Grupods) + ALLTRIM(Contads) = loc_cGrupods + loc_cContads ;
                      FOR QtdeLido <> 0

                    loc_nItem     = loc_nItem + 1
                    loc_cCPros    = ALLTRIM(cursor_4c_TmpBaixa.CPros)
                    loc_cCodBarra = ALLTRIM(cursor_4c_TmpBaixa.CodBarra)
                    loc_nQtdeLido = cursor_4c_TmpBaixa.QtdeLido

                    *-- Buscar dados do produto (descricao e unidade)
                    loc_cDPros = ""
                    loc_cCUnis = ""
                    loc_cSQL = "SELECT DPros, CUnis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProItm") > 0
                        SELECT cursor_4c_ProItm
                        IF !EOF()
                            loc_cDPros = ALLTRIM(DPros)
                            loc_cCUnis = ALLTRIM(CUnis)
                        ENDIF
                        IF USED("cursor_4c_ProItm")
                            USE IN cursor_4c_ProItm
                        ENDIF
                    ENDIF

                    *-- Buscar dados da etiqueta (cor, tamanho, empresa origem)
                    loc_cCodCors2 = ""
                    loc_cCodTams2 = ""
                    loc_cEmposItm = go_4c_Sistema.cCodEmpresa
                    loc_cSQL = "SELECT CodCors, CodTams, Empos FROM SigOpEtq WHERE CBars = " + EscaparSQL(loc_cCodBarra)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EtqItm") > 0
                        SELECT cursor_4c_EtqItm
                        IF !EOF()
                            loc_cCodCors2 = ALLTRIM(CodCors)
                            loc_cCodTams2 = ALLTRIM(CodTams)
                            loc_cEmposItm = ALLTRIM(Empos)
                        ENDIF
                        IF USED("cursor_4c_EtqItm")
                            USE IN cursor_4c_EtqItm
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_TmpBaixa

                    *-- Inserir item SigMvItn
                    loc_cSQL = "INSERT INTO SigMvItn " + ;
                               "(CItens, Emps, Dopes, Numes, CPros, Qtds, CUnis, DPros, Opers, " + ;
                               "CodBarras, EmpDopNums, cIdChaves, DtAlts) " + ;
                               "VALUES (" + ;
                               TRANSFORM(loc_nItem) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               EscaparSQL(loc_cCUnis) + ", " + ;
                               EscaparSQL(loc_cDPros) + ", " + ;
                               "'S', " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               EscaparSQL(THIS.GerarIdUnico()) + ", " + ;
                               "GETDATE())"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResItn") < 1
                        MsgErro("Falha ao inserir SigMvItn!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResItn")
                        USE IN cursor_4c_ResItn
                    ENDIF

                    *-- Historico de saida do grupo conferencia (S)
                    loc_cPCidC = DTOS(DATE()) + "S" + ;
                                 TRANSFORM(THIS.GerarChaveUnica(DTOS(DATE())), "@L 999999") + ;
                                 ALLTRIM(THIS.this_cSigKey)
                    loc_nPSeq = THIS.GerarChaveUnica("HISTBAR")

                    loc_cSQL = "INSERT INTO SigMvHst " + ;
                               "(Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, CPros, Qtds, Opers, " + ;
                               "Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves, EmpDopNums, " + ;
                               "EmpGruEsts, OriDopNums, Seqs) " + ;
                               "VALUES (" + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               "GETDATE(), GETDATE(), " + ;
                               EscaparSQL(loc_cEmposItm) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               "'S', " + ;
                               EscaparSQL(loc_cGruConfs) + ", " + ;
                               EscaparSQL(loc_cConConfs) + ", " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cCodCors2) + ", " + ;
                               EscaparSQL(loc_cCodTams2) + ", " + ;
                               EscaparSQL(loc_cPCidC) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cDopTransf + STR(loc_nNume, 6)) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cGruConfs + loc_cConConfs) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               FormatarNumeroSQL(loc_nPSeq) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResHstS") < 1
                        MsgErro("Falha ao inserir SigMvHst (S)!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResHstS")
                        USE IN cursor_4c_ResHstS
                    ENDIF

                    THIS.RecalcularPositivo(loc_cEmposItm, loc_cGruConfs, loc_cConConfs, ;
                                            loc_cCPros, loc_cCodCors2, loc_cCodTams2)
                    THIS.RecalcularCusto(loc_cEmposItm, loc_cCPros)

                    *-- Historico de entrada no grupo destino (E)
                    loc_cPCidC = DTOS(DATE()) + "E" + ;
                                 TRANSFORM(THIS.GerarChaveUnica(DTOS(DATE())), "@L 999999") + ;
                                 ALLTRIM(THIS.this_cSigKey)
                    loc_nPSeq = THIS.GerarChaveUnica("HISTBAR")

                    loc_cSQL = "INSERT INTO SigMvHst " + ;
                               "(Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, CPros, Qtds, Opers, " + ;
                               "Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves, EmpDopNums, " + ;
                               "EmpGruEsts, OriDopNums, Seqs) " + ;
                               "VALUES (" + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                               "GETDATE(), GETDATE(), " + ;
                               EscaparSQL(loc_cEmposItm) + ", " + ;
                               EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                               EscaparSQL(loc_cDopTransf) + ", " + ;
                               FormatarNumeroSQL(loc_nNume) + ", " + ;
                               EscaparSQL(loc_cCPros) + ", " + ;
                               FormatarNumeroSQL(loc_nQtdeLido) + ", " + ;
                               "'E', " + ;
                               EscaparSQL(loc_cGrupods) + ", " + ;
                               EscaparSQL(loc_cContads) + ", " + ;
                               EscaparSQL(loc_cCodBarra) + ", " + ;
                               EscaparSQL(loc_cCodCors2) + ", " + ;
                               EscaparSQL(loc_cCodTams2) + ", " + ;
                               EscaparSQL(loc_cPCidC) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cDopTransf + STR(loc_nNume, 6)) + ", " + ;
                               EscaparSQL(loc_cEmposItm + loc_cGrupods + loc_cContads) + ", " + ;
                               EscaparSQL(loc_cEmpDopNums) + ", " + ;
                               FormatarNumeroSQL(loc_nPSeq) + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResHstE") < 1
                        MsgErro("Falha ao inserir SigMvHst (E)!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResHstE")
                        USE IN cursor_4c_ResHstE
                    ENDIF

                    THIS.RecalcularPositivo(loc_cEmposItm, loc_cGrupods, loc_cContads, ;
                                            loc_cCPros, loc_cCodCors2, loc_cCodTams2)
                    THIS.RecalcularCusto(loc_cEmposItm, loc_cCPros)

                    *-- Atualizar SigOpEtq com grupo/conta destino
                    loc_cSQL = "UPDATE SigOpEtq " + ;
                               "SET Grupos = " + EscaparSQL(loc_cGrupods) + ", " + ;
                               "Contas = " + EscaparSQL(loc_cContads) + ", " + ;
                               "DtMovs = GETDATE() " + ;
                               "WHERE CBars = " + EscaparSQL(loc_cCodBarra)

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResEtq") < 1
                        MsgErro("Falha ao atualizar SigOpEtq!", "Erro")
                        loc_llTaOk = .F.
                        EXIT
                    ENDIF
                    IF USED("cursor_4c_ResEtq")
                        USE IN cursor_4c_ResEtq
                    ENDIF

                    SELECT cursor_4c_TmpBaixa
                ENDSCAN

                IF !loc_llTaOk
                    EXIT
                ENDIF

                SELECT cursor_4c_xCabec
            ENDSCAN

            IF USED("cursor_4c_xCabec")
                USE IN cursor_4c_xCabec
            ENDIF

            *-- Confirmar ou reverter transacao
            IF loc_llTaOk
                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_TransR")
                IF USED("cursor_4c_TransR")
                    USE IN cursor_4c_TransR
                ENDIF
                THIS.RegistrarAuditoria("CONFERENCIA")
                loc_lSucesso = .T.
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_TransR")
                IF USED("cursor_4c_TransR")
                    USE IN cursor_4c_TransR
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_TransR")
            IF USED("cursor_4c_TransR")
                USE IN cursor_4c_TransR
            ENDIF
            IF USED("cursor_4c_xCabec")
                USE IN cursor_4c_xCabec
            ENDIF
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Processa a conferencia das etiquetas (wrapper)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ProcessarConferencia()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Registra leitura de codigo de barras (wrapper)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_cCodBarra)
        LOCAL loc_cCodBarra
        loc_cCodBarra = IIF(PCOUNT() > 0, par_cCodBarra, THIS.this_cCodBarra)
        RETURN THIS.RegistrarLeitura(loc_cCodBarra)
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodBarra)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao no log de auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cTabela) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Audit")
            IF USED("cursor_4c_Audit")
                USE IN cursor_4c_Audit
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve bloquear operacao principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera numero sequencial unico por prefixo
    * Prefixo de movimento (Emps+Dopes, >8 chars): usa MAX(Numes)+1 de SigMvCab
    * Prefixo curto (data YYYYMMDD ou HISTBAR): usa contador interno this_nSeqContador
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarChaveUnica(par_cPrefixo)
        LOCAL loc_nChave, loc_cSQL, loc_cPref, loc_oErro

        loc_nChave = 1
        loc_cPref  = ALLTRIM(par_cPrefixo)

        TRY
            IF LEN(loc_cPref) > 8
                *-- Prefixo de movimento: Emps + Dopes
                loc_cSQL = "SELECT ISNULL(MAX(Numes), 0) + 1 AS Proximo " + ;
                           "FROM SigMvCab " + ;
                           "WHERE LEFT(EmpDopNums, " + TRANSFORM(LEN(loc_cPref)) + ") = " + EscaparSQL(loc_cPref)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SeqMv") > 0
                    SELECT cursor_4c_SeqMv
                    IF !EOF()
                        loc_nChave = NVL(cursor_4c_SeqMv.Proximo, 1)
                    ENDIF
                    IF USED("cursor_4c_SeqMv")
                        USE IN cursor_4c_SeqMv
                    ENDIF
                ENDIF
            ELSE
                *-- Prefixo curto (data ou HISTBAR): contador interno da sessao
                THIS.this_nSeqContador = THIS.this_nSeqContador + 1
                loc_nChave = THIS.this_nSeqContador
            ENDIF

        CATCH TO loc_oErro
            THIS.this_nSeqContador = THIS.this_nSeqContador + 1
            loc_nChave = THIS.this_nSeqContador
        ENDTRY

        RETURN loc_nChave
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarIdUnico - Gera string ID unico para cIdChaves
    * Equivalente ao legado fUniqueIds()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarIdUnico()
        THIS.this_nSeqContador = THIS.this_nSeqContador + 1
        RETURN SYS(2015) + TRANSFORM(THIS.this_nSeqContador, "@L 99999")
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarMascara - Formata numero como string mascarada
    * Equivalente ao legado fGerMascara()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarMascara(par_nNumero)
        RETURN ALLTRIM(TRANSFORM(par_nNumero, "@L 999999"))
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularPositivo - Recalcula posicao de estoque via stored procedure
    * Equivalente ao legado fRecalculaP por registro (SigOpClP)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularPositivo(par_cEmps, par_cGrupos, par_cEstos, par_cCPros, par_cCodCors, par_cCodTams)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "EXEC SigOpClP " + ;
                       "@Emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ", " + ;
                       "@Grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ", " + ;
                       "@Estos = " + EscaparSQL(ALLTRIM(par_cEstos)) + ", " + ;
                       "@CPros = " + EscaparSQL(ALLTRIM(par_cCPros)) + ", " + ;
                       "@CodCors = " + EscaparSQL(ALLTRIM(par_cCodCors)) + ", " + ;
                       "@CodTams = " + EscaparSQL(ALLTRIM(par_cCodTams))
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResRecP")
            IF USED("cursor_4c_ResRecP")
                USE IN cursor_4c_ResRecP
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao recalcular posi" + CHR(231) + CHR(227) + "o de estoque: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RecalcularCusto - Recalcula custo do produto via stored procedure
    * Equivalente ao legado fRecalculaC por registro (SigOpClC)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularCusto(par_cEmps, par_cCPros)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "EXEC SigOpClC " + ;
                       "@Emps = " + EscaparSQL(ALLTRIM(par_cEmps)) + ", " + ;
                       "@CPros = " + EscaparSQL(ALLTRIM(par_cCPros))
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ResRecC")
            IF USED("cursor_4c_ResRecC")
                USE IN cursor_4c_ResRecC
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao recalcular custo: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

