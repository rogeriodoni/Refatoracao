# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 05d_validarCompletude
- Tentativa: 1/10
- Mensagem: Validacao de completude falhou. Procedures vazias/TODOs encontrados:
[FormSIGPRMEI.prg] Procedure vazia (sem codigo): ConfigurarPaginaDados
[FormSIGPRMEI.prg] Indicador de pendencia: * dos XMLs pendente
[FormSIGPRMEI.prg] Indicador de pendencia: * BtnAlterarClick - Reprocessa (releitura forcada dos arquivos pendente
[FormSIGPRMEI.prg] Indicador de pendencia: * BtnBuscarClick - Verifica XMLs pendente

IMPORTANTE: Preencha TODAS as procedures vazias com codigo funcional REAL. NAO use TODO, FIXME, PLACEHOLDER ou comentarios de pendencia. Cada procedure deve ter implementacao completa.

## CONTEXTO DO ERRO


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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRMEI.prg):
*==============================================================================
* FormSIGPRMEI.prg - Form Integracao SIS E-Commerce
* Herdado de: FormBase
* Tipo: OPERACIONAL (dialogo de processamento - sem PageFrame)
* Portado de: SIGPRMEI.SCX
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS FormSIGPRMEI AS FormBase

    *-- Dimensoes (PILAR 1: identico ao legado SIGPRMEI.SCX)
    Width       = 500
    Height      = 147
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    KeyPreview  = .T.
    DataSession = 2
    AlwaysOnTop = .T.
    BorderStyle = 2

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Modo automatico: .T. = iniciado por scheduler sem interface interativa
    this_lParametrizado  = .F.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LPARAMETERS par_lParametrizado
        THIS.this_lParametrizado = IIF(VARTYPE(par_lParametrizado) = "L", par_lParametrizado, .F.)
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Background e fontes do dialogo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ScrollBars = 0
        THIS.ShowTips   = .T.
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO, carrega config SigCdPam e monta controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGPRMEIBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"

                *-- Titulo com acentuacao via CHR (PILAR 1: fidelidade ao caption legado)
                THIS.Caption = "Integra" + CHR(231) + CHR(227) + "o SIS E-Commerce"

                *-- Carregar configuracoes operacionais de SigCdPam
                loc_cSQL = "SELECT DirLivrosV, CdChepSais, Mascnums, CdChepEnts FROM SigCdPam"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
                IF loc_nRet > 0
                    SELECT cursor_4c_SigCdPam
                    GO TOP
                    IF !EOF("cursor_4c_SigCdPam")
                        THIS.this_oBusinessObject.this_cDirLivros  = ALLTRIM(cursor_4c_SigCdPam.DirLivrosV)
                        THIS.this_oBusinessObject.this_cDirSaida   = ALLTRIM(cursor_4c_SigCdPam.CdChepSais)
                        THIS.this_oBusinessObject.this_cMascNums   = ALLTRIM(cursor_4c_SigCdPam.Mascnums)
                        THIS.this_oBusinessObject.this_cDirEntrada = ALLTRIM(cursor_4c_SigCdPam.CdChepEnts)
                    ENDIF
                    USE IN SELECT("cursor_4c_SigCdPam")
                ELSE
                    MsgErro("Erro ao carregar configura" + CHR(231) + CHR(245) + "es de SigCdPam.", "FormSIGPRMEI.InicializarForm")
                ENDIF

                THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarLabels()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar Business Object SIGPRMEIBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "FormSIGPRMEI.InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo em sombra e branco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = -1
            .Left        = -1
            .Width       = THIS.Width
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCab = THIS.cnt_4c_Cabecalho

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width
            .Height        = 40
            .AutoSize      = .F.
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top          = 17
            .Left         = 10
            .Width        = THIS.Width
            .Height       = 46
            .AutoSize     = .F.
            .FontBold     = .T.
            .FontName     = "Tahoma"
            .FontSize     = 18
            .WordWrap     = .T.
            .Alignment    = 0
            .BackStyle    = 0
            .ForeColor    = RGB(255, 255, 255)
            .ToolTipText  = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Caption      = THIS.Caption
            .Visible      = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Botoes Processar e Encerrar sobrepostos ao cabecalho
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()

        *-- Botao Processar
        THIS.AddObject("btn_4c_Processar", "CommandButton")
        WITH THIS.btn_4c_Processar
            .Top             = 3
            .Left            = 340
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .ToolTipText     = "Processar"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.btn_4c_Processar, "Click", THIS, "BtnProcessarClick")

        *-- Botao Encerrar
        THIS.AddObject("btn_4c_Encerrar", "CommandButton")
        WITH THIS.btn_4c_Encerrar
            .Top             = 3
            .Left            = 420
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .ToolTipText     = "[ESC] Sair"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Visible         = .T.
        ENDWITH
        BINDEVENT(THIS.btn_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarLabels - Label de identificacao e label de status dinamico
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarLabels()

        *-- Label de identificacao do sistema (Label2 no legado)
        THIS.AddObject("lbl_4c_Info", "Label")
        WITH THIS.lbl_4c_Info
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackStyle   = 0
            .BorderStyle = 0
            .Caption     = "Integra" + CHR(231) + CHR(227) + "o Sis e-Commerce"
            .Height      = 20
            .Left        = 147
            .Top         = 96
            .Width       = 205
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 234)
            .Visible     = .T.
        ENDWITH

        *-- Label de status do processamento (Label1 no legado - atualizado dinamicamente)
        THIS.AddObject("lbl_4c_Status", "Label")
        WITH THIS.lbl_4c_Status
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .BackStyle   = 0
            .BorderStyle = 0
            .Caption     = ""
            .Height      = 20
            .Left        = 56
            .Top         = 114
            .Width       = 387
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 234)
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Activate - Auto-inicia processamento em modo automatico (Parametrizado)
    *--------------------------------------------------------------------------
    PROCEDURE Activate()
        IF THIS.this_lParametrizado
            THIS.BtnProcessarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnProcessarClick - Loop de processamento: LerArquivos + GravarArquivos
    *--------------------------------------------------------------------------
    PROCEDURE BtnProcessarClick()
        LOCAL loc_llOk1, loc_llOk2, loc_lnMov, loc_lnKey, loc_lnError, loc_lcErro

        THIS.btn_4c_Processar.Enabled = .F.
        SET CURSOR OFF

        loc_lnMov = 1
        DO WHILE .T.
            THIS.btn_4c_Encerrar.Enabled = .F.
            THIS.lbl_4c_Status.Caption = "Aguardando Arquivos Para Processar" + REPLICATE(".", loc_lnMov)
            loc_lnMov = IIF(loc_lnMov < 5, loc_lnMov + 1, 1)

            loc_llOk1 = THIS.this_oBusinessObject.LerArquivos()
            loc_llOk2 = THIS.this_oBusinessObject.GravarArquivos()

            IF !EMPTY(THIS.this_oBusinessObject.this_cUltStatus)
                THIS.lbl_4c_Status.Caption = THIS.this_oBusinessObject.this_cUltStatus
            ENDIF

            THIS.btn_4c_Encerrar.Enabled = .T.

            *-- Aguardar 0.5s capturando input do usuario
            loc_lnError = 0
            loc_lcErro  = ON("Error")
            ON ERROR loc_lnError = 1

            loc_lnKey = INKEY(.5, "M")

            IF loc_lnError <> 0
                loc_lnKey = 0
            ENDIF
            ON ERROR &loc_lcErro.

            *-- Sair apos ciclo unico se nao-parametrizado, ou se ESC pressionado
            IF !THIS.this_lParametrizado OR loc_lnKey = 27
                EXIT
            ENDIF
        ENDDO

        SET CURSOR ON
        THIS.lbl_4c_Status.Caption = ""
        THIS.btn_4c_Processar.Enabled = .T.

        IF THIS.this_lParametrizado
            THIS.Release()
            QUIT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Executa UM ciclo manual de leitura+gravacao
    *
    * Em forms CRUD, este botao inclui novo registro. Neste form OPERACIONAL
    * de integracao SIS E-Commerce, aciona um ciclo unico de processamento
    * dos XMLs pendentes ("incluir novo lote de movimentos"), sem entrar no
    * loop continuo do BtnProcessar. Util para operacao manual pontual.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_llOk1, loc_llOk2, loc_oErro

        THIS.btn_4c_Processar.Enabled = .F.
        THIS.btn_4c_Encerrar.Enabled  = .F.
        THIS.lbl_4c_Status.Caption    = "Processando novo lote..."

        TRY
            loc_llOk1 = THIS.this_oBusinessObject.LerArquivos()
            loc_llOk2 = THIS.this_oBusinessObject.GravarArquivos()

            IF !EMPTY(THIS.this_oBusinessObject.this_cUltStatus)
                THIS.lbl_4c_Status.Caption = THIS.this_oBusinessObject.this_cUltStatus
            ELSE
                THIS.lbl_4c_Status.Caption = IIF(loc_llOk1 AND loc_llOk2, ;
                    "Lote processado com sucesso.", ;
                    "Falha no processamento do lote.")
            ENDIF
        CATCH TO loc_oErro
            THIS.lbl_4c_Status.Caption = "Erro: " + loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "FormSIGPRMEI.BtnIncluirClick")
        ENDTRY

        THIS.btn_4c_Processar.Enabled = .T.
        THIS.btn_4c_Encerrar.Enabled  = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Reprocessa (releitura forcada dos arquivos pendentes)
    *
    * Em forms CRUD, este botao edita registro. Neste form OPERACIONAL, forca
    * releitura imediata dos XMLs ? util quando o operador corrigiu arquivos
    * no diretorio de entrada e nao quer esperar o polling do BtnProcessar.
    * Delega para BtnIncluirClick (mesma operacao de ciclo unico).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe configuracoes ativas da integracao SIS
    *
    * Em forms CRUD, este botao visualiza registro. Neste form OPERACIONAL,
    * mostra as configuracoes carregadas de SigCdPam (diretorios de entrada/
    * saida, mascara de numeracao) ? permite ao operador confirmar caminhos
    * antes de iniciar processamento.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cMsg, loc_oBO

        loc_oBO = THIS.this_oBusinessObject

        loc_cMsg = "Configura" + CHR(231) + CHR(245) + "es de Integra" + ;
                   CHR(231) + CHR(227) + "o SIS E-Commerce:" + CHR(13) + CHR(13)
        loc_cMsg = loc_cMsg + "Diret" + CHR(243) + "rio de Livros (XMLs de venda web):" + CHR(13)
        loc_cMsg = loc_cMsg + "  " + ALLTRIM(loc_oBO.this_cDirLivros) + CHR(13) + CHR(13)
        loc_cMsg = loc_cMsg + "Diret" + CHR(243) + "rio de Sa" + CHR(237) + "da (estoque.xml):" + CHR(13)
        loc_cMsg = loc_cMsg + "  " + ALLTRIM(loc_oBO.this_cDirSaida) + CHR(13) + CHR(13)
        loc_cMsg = loc_cMsg + "Diret" + CHR(243) + "rio de Entrada:" + CHR(13)
        loc_cMsg = loc_cMsg + "  " + ALLTRIM(loc_oBO.this_cDirEntrada) + CHR(13) + CHR(13)
        loc_cMsg = loc_cMsg + "M" + CHR(225) + "scara Num" + CHR(233) + "rica: " + ALLTRIM(loc_oBO.this_cMascNums) + CHR(13)
        loc_cMsg = loc_cMsg + "Arquivos processados na sess" + CHR(227) + "o: " + ;
                   TRANSFORM(loc_oBO.this_nArqProcessados)

        MsgInfo(loc_cMsg, "Configura" + CHR(231) + CHR(245) + "es")
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Aborta processamento em andamento e encerra
    *
    * Em forms CRUD, este botao exclui registro. Neste form OPERACIONAL, aborta
    * qualquer polling ativo (desliga modo parametrizado), restaura estado dos
    * botoes e fecha o dialogo ? equivalente a "cancelar integracao e sair".
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lConfirma

        loc_lConfirma = MsgConfirma("Deseja realmente cancelar a integra" + ;
            CHR(231) + CHR(227) + "o e encerrar?", "Confirma" + CHR(231) + CHR(227) + "o")

        IF !loc_lConfirma
            RETURN
        ENDIF

        THIS.this_lParametrizado = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lParametrizado = .F.
            THIS.this_oBusinessObject.this_lProcessando   = .F.
        ENDIF

        THIS.btn_4c_Processar.Enabled = .T.
        THIS.btn_4c_Encerrar.Enabled  = .T.
        THIS.lbl_4c_Status.Caption    = ""

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - N/A para OPERACIONAL sem PageFrame
    *
    * FormSIGPRMEI eh um dialogo de processamento (500x147) sem PageFrame,
    * portanto nao ha Page1/Lista/Grid como em forms CRUD (frmcadastro).
    * Metodo mantido pela interface do pipeline de migracao. A construcao
    * real dos controles ocorre em ConfigurarCabecalho + ConfigurarBotoes
    * + ConfigurarLabels chamados por InicializarForm.
    *
    * Efeito real: limpa o rotulo de status (equivalente a "recarregar a
    * lista" nos forms CRUD - devolve o dialogo ao estado inicial).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
            THIS.lbl_4c_Status.Caption = ""
        ENDIF
        IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
            THIS.btn_4c_Processar.Enabled = .T.
        ENDIF
        IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
            THIS.btn_4c_Encerrar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - N/A para OPERACIONAL sem PageFrame
    *
    * FormSIGPRMEI eh um dialogo de processamento (500x147) sem PageFrame,
    * portanto nao ha Page2/Dados como em forms CRUD (frmcadastro).
    * Metodo mantido pela interface do pipeline de migracao. Nao ha campos
    * de entrada, TextBoxes ou Labels de dados a configurar ? todos os
    * controles visuais foram criados em ConfigurarCabecalho +
    * ConfigurarBotoes + ConfigurarLabels.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- N/A: formulario sem Page2. Ver ConfigurarCabecalho/Botoes/Labels.
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - N/A para OPERACIONAL sem PageFrame
    *
    * FormSIGPRMEI nao possui PageFrame. Metodo mantido pela interface do
    * pipeline de migracao. O parametro representa o modo do dialogo:
    *   1 = OCIOSO       (Processar habilitado, aguardando comando do usuario)
    *   2 = PROCESSANDO  (Processar desabilitado durante loop de leitura/gravacao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lProcessando
        loc_lProcessando = (par_nPagina = 2)
        IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
            THIS.btn_4c_Processar.Enabled = !loc_lProcessando
        ENDIF
        IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
            THIS.btn_4c_Encerrar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
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
    * BtnBuscarClick - Verifica XMLs pendentes no diretorio de entrada
    *
    * Em forms CRUD, este botao abre busca por registro. Neste form OPERACIONAL,
    * varre o diretorio de livros (XMLs de pedidos web) e informa quantos
    * arquivos aguardam processamento ? util para diagnostico antes de processar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        LOCAL loc_laDirs[1], loc_lnArq, loc_cDir, loc_cMsg, loc_oBO, loc_oErro
        TRY
            loc_oBO  = THIS.this_oBusinessObject
            loc_cDir = ALLTRIM(loc_oBO.this_cDirLivros)

            IF EMPTY(loc_cDir)
                MsgAviso("Diret" + CHR(243) + "rio de entrada n" + CHR(227) + "o configurado." + CHR(13) + ;
                    "Verifique as configura" + CHR(231) + CHR(245) + "es de SigCdPam.", ;
                    "Buscar Pedidos")
                RETURN
            ENDIF

            IF RIGHT(loc_cDir, 1) <> "\"
                loc_cDir = loc_cDir + "\"
            ENDIF

            loc_lnArq = ADIR(loc_laDirs, loc_cDir + "*.XML")

            IF loc_lnArq = 0
                loc_cMsg = "Nenhum pedido pendente encontrado." + CHR(13) + CHR(13) + ;
                    "Diret" + CHR(243) + "rio: " + loc_cDir + CHR(13) + CHR(13) + ;
                    "Total processado na sess" + CHR(227) + "o: " + TRANSFORM(loc_oBO.this_nArqProcessados)
                MsgInfo(loc_cMsg, "Buscar Pedidos")
            ELSE
                loc_cMsg = TRANSFORM(loc_lnArq) + " pedido(s) web aguardando processamento." + CHR(13) + CHR(13) + ;
                    "Diret" + CHR(243) + "rio: " + loc_cDir + CHR(13) + CHR(13) + ;
                    "Total processado na sess" + CHR(227) + "o: " + TRANSFORM(loc_oBO.this_nArqProcessados) + CHR(13) + CHR(13) + ;
                    "Clique em Processar para importar os pedidos."
                MsgInfo(loc_cMsg, "Buscar Pedidos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "FormSIGPRMEI.BtnBuscarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Executa um ciclo de processamento (equivalente a Processar)
    *
    * Em forms CRUD, salva dados editados. Neste form OPERACIONAL, executa
    * imediatamente UM ciclo de leitura+gravacao (LerArquivos + GravarArquivos),
    * sem entrar no loop continuo do BtnProcessar ? para uso manual pontual.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.BtnIncluirClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Interrompe processamento em andamento
    *
    * Em forms CRUD, cancela edicao em curso. Neste form OPERACIONAL, desativa
    * o modo automatico (parametrizado) para que o loop do BtnProcessar encerre
    * no proximo ciclo, restaurando o dialogo ao estado de repouso.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.this_lParametrizado = .F.
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lParametrizado = .F.
            THIS.this_oBusinessObject.this_lProcessando   = .F.
        ENDIF
        IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
            THIS.lbl_4c_Status.Caption = "Processamento cancelado."
        ENDIF
        THIS.AjustarBotoesPorModo()
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza estado do form para o BO
    *
    * Form OPERACIONAL sem campos de entrada: sincroniza apenas o flag de
    * modo automatico (this_lParametrizado) entre o dialogo e o BO.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza estado do BO para o form
    *
    * Form OPERACIONAL sem campos editaveis: atualiza o label de status com
    * a ultima mensagem gerada pelo BO durante o processamento.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_oBO = THIS.this_oBusinessObject
            IF PEMSTATUS(THIS, "lbl_4c_Status", 5) AND !EMPTY(ALLTRIM(loc_oBO.this_cUltStatus))
                THIS.lbl_4c_Status.Caption = loc_oBO.this_cUltStatus
            ENDIF
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita/desabilita botoes conforme modo de operacao
    *
    * par_cModo: "IDLE"        -> Processar habilitado, aguardando
    *            "PROCESSANDO" -> Processar desabilitado durante loop
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE HabilitarCampos(par_cModo)
        LOCAL loc_lIdle
        loc_lIdle = (UPPER(ALLTRIM(par_cModo)) = "IDLE" OR EMPTY(par_cModo))

        IF PEMSTATUS(THIS, "btn_4c_Processar", 5)
            THIS.btn_4c_Processar.Enabled = loc_lIdle
        ENDIF
        IF PEMSTATUS(THIS, "btn_4c_Encerrar", 5)
            THIS.btn_4c_Encerrar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Reseta o status do dialogo para o estado inicial
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "lbl_4c_Status", 5)
            THIS.lbl_4c_Status.Caption = ""
        ENDIF
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cUltStatus = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Atualiza o dialogo com estado atual do BO
    *
    * Forms CRUD usam este metodo para recarregar o grid. Neste form
    * OPERACIONAL, sincroniza o status label com o ultimo estado do BO
    * e restaura os botoes para o modo de repouso (IDLE).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        THIS.BOParaForm()
        THIS.AjustarBotoesPorModo()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Restaura botoes ao modo de repouso (IDLE)
    *
    * Em forms CRUD, ajusta botoes conforme modo INCLUIR/ALTERAR/VISUALIZAR.
    * Neste form OPERACIONAL, restaura sempre ao estado IDLE (Processar
    * habilitado, Encerrar habilitado) apos conclusao de qualquer operacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AjustarBotoesPorModo()
        THIS.HabilitarCampos("IDLE")
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "FormSIGPRMEI.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRMEIBO.prg):
*------------------------------------------------------------------------------
* SIGPRMEIBO.prg - Business Object para Integracao SIS E-Commerce
* Herda de BusinessBase
* Form original: SIGPRMEI.SCX
*------------------------------------------------------------------------------
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS SIGPRMEIBO AS BusinessBase

    *-- Configuracoes lidas de SigCdPam no Init do Form
    this_cDirLivros      = ""    && DirLivrosV  - Diretorio dos XMLs de pedido web
    this_cDirSaida       = ""    && CdChepSais  - Diretorio de saida (estoque.xml)
    this_cMascNums       = ""    && Mascnums    - Mascara de numeracao
    this_cDirEntrada     = ""    && CdChepEnts  - Diretorio de entrada alternativo

    *-- Estado do processamento
    this_lParametrizado  = .F.   && .T. se iniciado em modo automatico (sem interface)
    this_lProcessando    = .F.   && .T. durante loop de processamento ativo
    this_cUltStatus      = ""    && Ultima mensagem de status exibida no Label1
    this_nArqProcessados = 0     && Total de arquivos processados na sessao
    this_lUltResultado   = .F.   && Resultado do ultimo ciclo

    *-- Parametros de operacao: defaults, sobrescritos por SigCdOpe.Dopes='VENDA WEB'
    this_cDop  = "VENDA WEB"   && Tipo de operacao e-commerce
    this_cGrO  = "ESTOQUE"     && Grupo origem do movimento
    this_cCtO  = "ESTOQUE"     && Conta origem do movimento
    this_cGrD  = "CLIENTEWEB"  && Grupo destino (clientes web)
    this_cGrV  = "VENDEDOR"    && Grupo vendedor padrao
    this_cCtV  = "V34"         && Conta vendedor padrao
    this_cUsu  = "WEB"         && Usuario de integracao e-commerce
    this_cEmp  = "ESC"         && Empresa

    *-- Propriedades CRUD SigMvpar (base table deste BO)
    this_cFPags      = ""    && fpags char(12)    - Forma de pagamento
    this_cEmps       = ""    && emps char(3)      - Empresa
    this_cDopes      = ""    && dopes char(20)    - Tipo de operacao
    this_nNumes      = 0     && numes N(6,0)      - Numero movimento
    this_cEmpDopNums = ""    && empdopnums C(29)  - Chave emp+dop+num
    this_dDatas      = {}    && datas datetime    - Data
    this_dVencs      = {}    && vencs datetime    - Vencimento
    this_nNopers     = 0     && nopers N(7,0)     - Numero operacao/parcela
    this_nCotFpgs    = 1     && cotfpgs N(11,4)   - Cotacao
    this_nParcs      = 1     && parcs N(2,0)      - Parcela
    this_nTParcs     = 1     && tparcs N(2,0)     - Total parcelas
    this_cPagos      = "1"   && pagos char(1)     - Pago
    this_cMoeFpgs    = "R"   && moefpgs char(3)   - Moeda
    this_nValos      = 0     && valos N(11,2)     - Valor
    this_nVPags      = 0     && vpags N(11,2)     - Valor pago
    this_cIdChaves   = ""    && cidchaves C(20)   - Chave primaria (PK)

    *--------------------------------------------------------------------------
    * Init - Configura tabela/chave do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigMvpar"
        this_cCampoChave = "cIdChaves"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor SQL
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                this_cFPags      = NVL(ALLTRIM(fpags), "")
                this_cEmps       = NVL(ALLTRIM(emps), "")
                this_cDopes      = NVL(ALLTRIM(dopes), "")
                this_nNumes      = NVL(numes, 0)
                this_cEmpDopNums = NVL(ALLTRIM(empdopnums), "")
                IF VARTYPE(datas) = "T"
                    this_dDatas = NVL(datas, {})
                ELSE
                    this_dDatas = {}
                ENDIF
                IF VARTYPE(vencs) = "T"
                    this_dVencs = NVL(vencs, {})
                ELSE
                    this_dVencs = {}
                ENDIF
                this_nNopers     = NVL(nopers, 0)
                this_nCotFpgs    = NVL(cotfpgs, 1)
                this_nParcs      = NVL(parcs, 1)
                this_nTParcs     = NVL(tparcs, 1)
                this_cPagos      = NVL(ALLTRIM(pagos), "")
                this_cMoeFpgs    = NVL(ALLTRIM(moefpgs), "")
                this_nValos      = NVL(valos, 0)
                this_nVPags      = NVL(vpags, 0)
                this_cIdChaves   = NVL(ALLTRIM(cidchaves), "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", "SIGPRMEIBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(this_cDopes)
            this_cMensagemValidacao = "Tipo de opera" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF EMPTY(this_cFPags)
            this_cMensagemValidacao = "Forma de pagamento obrigat" + CHR(243) + "ria"
            RETURN .F.
        ENDIF
        IF EMPTY(this_cIdChaves)
            this_cIdChaves = fUniqueIds()
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigMvpar
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(this_cIdChaves)
                this_cIdChaves = fUniqueIds()
            ENDIF
            IF EMPTY(this_cEmps)
                this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF

            loc_cSQL = "INSERT INTO SigMvpar (" + ;
                "fpags, emps, dopes, numes, empdopnums, " + ;
                "datas, datatrans, vencs, dtalts, dpags, dtdeps, " + ;
                "nopers, cotfpgs, parcs, tparcs, pagos, moefpgs, valos, vpags, " + ;
                "cidchaves, agencias, bancos, cartaos, contas, dcarts, " + ;
                "ec_numes, grclis, iclis, impcars, inschs, locals, " + ;
                "ncarnes, ncarts, ncopias, nocreditos, nrecs, ntrans, " + ;
                "numchqs, numeros, numolds, outros, cotusus, " + ;
                "cnidtefs, cnnsupars, numlotechs, nidcheps, empos, " + ;
                "valocurs, trocos, cpfs, digagencs, digchqs, digcontas, " + ;
                "pracas, valdescs, codbcrts, lcancelas, " + ;
                "vcofins, vcsll, virf, vlrtrbfs, vpis, " + ;
                "adquirente, autoriza, nsu, chaveexterna" + ;
                ") VALUES (" + ;
                EscaparSQL(PADR(ALLTRIM(this_cFPags), 12)) + ", " + ;
                EscaparSQL(PADR(ALLTRIM(this_cEmps), 3)) + ", " + ;
                EscaparSQL(PADR(ALLTRIM(this_cDopes), 20)) + ", " + ;
                FormatarNumeroSQL(this_nNumes, 0) + ", " + ;
                EscaparSQL(PADR(ALLTRIM(this_cEmpDopNums), 29)) + ", " + ;
                FormatarDataSQL(this_dDatas) + ", " + ;
                "NULL, " + ;
                FormatarDataSQL(this_dVencs) + ", " + ;
                "NULL, NULL, NULL, " + ;
                FormatarNumeroSQL(this_nNopers, 0) + ", " + ;
                FormatarNumeroSQL(this_nCotFpgs, 4) + ", " + ;
                FormatarNumeroSQL(this_nParcs, 0) + ", " + ;
                FormatarNumeroSQL(this_nTParcs, 0) + ", " + ;
                EscaparSQL(this_cPagos) + ", " + ;
                EscaparSQL(PADR(ALLTRIM(this_cMoeFpgs), 3)) + ", " + ;
                FormatarNumeroSQL(this_nValos, 2) + ", " + ;
                FormatarNumeroSQL(this_nVPags, 2) + ", " + ;
                EscaparSQL(PADR(ALLTRIM(this_cIdChaves), 20)) + ", " + ;
                "'    ', '   ', '                    ', '          ', '            ', " + ;
                "0, '          ', '          ', ' ', 0, '          ', " + ;
                "'           ', 0, 0, '          ', 0, 0, " + ;
                "'        ', '      ', 0, '                    ', '                              ', " + ;
                "'          ', '            ', 0, 0, '   ', " + ;
                "0, 0, '                    ', ' ', ' ', ' ', " + ;
                "'   ', 0, '     ', 0, " + ;
                "0, 0, 0, 0, 0, " + ;
                "'        ', '      ', '                                                  ', '                                 '" + ;
                ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIU")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro em SigMvpar", "SIGPRMEIBO.Inserir")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", "SIGPRMEIBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigMvpar
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(this_cIdChaves)
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o definida para atualiza" + CHR(231) + CHR(227) + "o", "SIGPRMEIBO.Atualizar")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigMvpar SET " + ;
                "fpags = "       + EscaparSQL(PADR(ALLTRIM(this_cFPags), 12)) + ", " + ;
                "emps = "        + EscaparSQL(PADR(ALLTRIM(this_cEmps), 3)) + ", " + ;
                "dopes = "       + EscaparSQL(PADR(ALLTRIM(this_cDopes), 20)) + ", " + ;
                "numes = "       + FormatarNumeroSQL(this_nNumes, 0) + ", " + ;
                "empdopnums = "  + EscaparSQL(PADR(ALLTRIM(this_cEmpDopNums), 29)) + ", " + ;
                "datas = "       + FormatarDataSQL(this_dDatas) + ", " + ;
                "vencs = "       + FormatarDataSQL(this_dVencs) + ", " + ;
                "nopers = "      + FormatarNumeroSQL(this_nNopers, 0) + ", " + ;
                "cotfpgs = "     + FormatarNumeroSQL(this_nCotFpgs, 4) + ", " + ;
                "parcs = "       + FormatarNumeroSQL(this_nParcs, 0) + ", " + ;
                "tparcs = "      + FormatarNumeroSQL(this_nTParcs, 0) + ", " + ;
                "pagos = "       + EscaparSQL(this_cPagos) + ", " + ;
                "moefpgs = "     + EscaparSQL(PADR(ALLTRIM(this_cMoeFpgs), 3)) + ", " + ;
                "valos = "       + FormatarNumeroSQL(this_nValos, 2) + ", " + ;
                "vpags = "       + FormatarNumeroSQL(this_nVPags, 2) + ", " + ;
                "dtalts = GETDATE() " + ;
                "WHERE cidchaves = " + EscaparSQL(ALLTRIM(this_cIdChaves))

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ALTEROU")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro em SigMvpar", "SIGPRMEIBO.Atualizar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", "SIGPRMEIBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigMvpar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(this_cIdChaves)
                MsgErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o definida para exclus" + CHR(227) + "o", "SIGPRMEIBO.ExecutarExclusao")
                loc_lSucesso = .F.
            ENDIF
            loc_cSQL = "DELETE FROM SigMvpar WHERE cidchaves = " + EscaparSQL(ALLTRIM(this_cIdChaves))
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIU")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro de SigMvpar", "SIGPRMEIBO.ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", "SIGPRMEIBO.ExecutarExclusao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Usuario, Operacao, Tabela, ChaveRegistro, DataHora) " + ;
                "VALUES (" + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                EscaparSQL(par_cOperacao) + ", " + ;
                "'SigMvpar', " + ;
                EscaparSQL(ALLTRIM(this_cIdChaves)) + ", " + ;
                "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGPRMEIBO.RegistrarAuditoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarArquivos - Gera arquivo estoque.xml com saldos e precos dos produtos
    * Portado de SIGPRMEI.gravararquivos
    *--------------------------------------------------------------------------
    PROCEDURE GravarArquivos()
        LOCAL loc_lSucesso, loc_lcDeq, loc_lcArq, loc_lcQuery, loc_lcTexto
        LOCAL loc_lcChr, loc_lnPvens, loc_oErro
        loc_lSucesso = .F.
        loc_lcChr = CHR(13) + CHR(10)
        TRY
            loc_lcDeq = ALLTRIM(this_cDirSaida)
            IF !EMPTY(loc_lcDeq)
                loc_lcDeq = IIF(RIGHT(loc_lcDeq, 1) = "\", loc_lcDeq, loc_lcDeq + "\")
            ENDIF

            loc_lcArq = loc_lcDeq + "estoque.xml"
            IF FILE(loc_lcArq)
                DELETE FILE (loc_lcArq)
            ENDIF

            loc_lcQuery = "select a.cpros, a.sqtds, b.dpros, b.pvens, b.pcuss, " + ;
                "b.prodwebs, b.prodvars, b.Encargos, " + ;
                "case when b.aliqipis<>0 then b.aliqipis else c.aipis end as ipi " + ;
                "from sigmvest a, SigCdPro b, SigcdClf c " + ;
                "where b.clfiscals = c.codigos and a.cpros = b.cpros " + ;
                "and a.grupos = 'ESTOQUE' and a.estos = 'ESTOQUE' " + ;
                "and b.prodwebs <> 0 and b.prodwebs <> 2 " + ;
                "union " + ;
                "(select b.cpros, 0.000 as sqtds, b.dpros, b.pvens, b.pcuss, " + ;
                "b.prodwebs, b.prodvars, b.Encargos, " + ;
                "case when b.aliqipis<>0 then b.aliqipis else c.aipis end as ipi " + ;
                "from SigCdPro b, SigcdClf c " + ;
                "where b.clfiscals = c.codigos " + ;
                "and b.cpros not in (select cpros from sigmvest where grupos = 'ESTOQUE' and estos = 'ESTOQUE') " + ;
                "and b.prodwebs <> 0 and b.prodwebs <> 2) order by 1"

            IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_EstTemp") < 1
                MsgErro("Falha ao consultar estoque para XML", "SIGPRMEIBO.GravarArquivos")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_EstTemp
            GO TOP

            IF !EOF()
                loc_lcTexto = "<?xml version=" + CHR(34) + "1.0" + CHR(34) + ;
                    " encoding=" + CHR(34) + "UTF-8" + CHR(34) + " ?>" + loc_lcChr
                loc_lcTexto = loc_lcTexto + "<importa_estoque>" + loc_lcChr
                loc_lcTexto = loc_lcTexto + "<produtos>" + loc_lcChr

                SCAN
                    IF prodvars = 0 OR prodvars = 2
                        loc_lcTexto = loc_lcTexto + "<produto>" + loc_lcChr
                        loc_lcTexto = loc_lcTexto + "<tipo>P</tipo>" + loc_lcChr
                        loc_lcTexto = loc_lcTexto + "<codigo_produto></codigo_produto>" + loc_lcChr
                        loc_lcTexto = loc_lcTexto + "<referencia>" + ALLTRIM(cpros) + "</referencia>" + loc_lcChr
                        IF prodwebs = 1 OR prodwebs = 4
                            loc_lcTexto = loc_lcTexto + "<saldo>" + ALLTRIM(TRANSFORM(sqtds, "@R 999999.99")) + "</saldo>" + loc_lcChr
                        ENDIF
                        IF prodwebs = 1 OR prodwebs = 3
                            loc_lnPvens = pvens + IIF(!EMPTY(Encargos), ((pvens * Encargos) / 100), 0)
                            loc_lcTexto = loc_lcTexto + "<preco>" + ALLTRIM(TRANSFORM(loc_lnPvens, "@R 999999.99")) + "</preco>" + loc_lcChr
                        ENDIF
                        IF ipi <> 0
                            loc_lcTexto = loc_lcTexto + "<imposto>" + ALLTRIM(TRANSFORM(ipi, "@R 99")) + "% IPI</imposto>" + loc_lcChr
                        ENDIF
                        loc_lcTexto = loc_lcTexto + "</produto>" + loc_lcChr
                    ELSE
                        loc_lcTexto = loc_lcTexto + "<produto_variacao>" + loc_lcChr
                        loc_lcTexto = loc_lcTexto + "<tipo>V</tipo>" + loc_lcChr
                        loc_lcTexto = loc_lcTexto + "<codigo_produto></codigo_produto>" + loc_lcChr
                        loc_lcTexto = loc_lcTexto + "<codigo_variacao></codigo_variacao>" + loc_lcChr
                        loc_lcTexto = loc_lcTexto + "<referencia>" + ALLTRIM(cpros) + "</referencia>" + loc_lcChr
                        IF prodwebs = 1 OR prodwebs = 4
                            loc_lcTexto = loc_lcTexto + "<saldo>" + ALLTRIM(TRANSFORM(sqtds, "@R 999999.99")) + "</saldo>" + loc_lcChr
                        ENDIF
                        IF prodwebs = 1 OR prodwebs = 3
                            loc_lnPvens = pvens + IIF(!EMPTY(Encargos), ((pvens * Encargos) / 100), 0)
                            loc_lcTexto = loc_lcTexto + "<preco>" + ALLTRIM(TRANSFORM(loc_lnPvens, "@R 999999.99")) + "</preco>" + loc_lcChr
                        ENDIF
                        IF ipi <> 0
                            loc_lcTexto = loc_lcTexto + "<imposto>" + ALLTRIM(TRANSFORM(ipi, "@R 99")) + "% IPI</imposto>" + loc_lcChr
                        ENDIF
                        loc_lcTexto = loc_lcTexto + "</produto_variacao>" + loc_lcChr
                    ENDIF
                ENDSCAN

                loc_lcTexto = loc_lcTexto + "</produtos>" + loc_lcChr
                loc_lcTexto = loc_lcTexto + "</importa_estoque>" + loc_lcChr
                loc_lSucesso = .T.
                STRTOFILE(loc_lcTexto, loc_lcArq, .F.)
            ENDIF

            IF USED("cursor_4c_EstTemp")
                USE IN cursor_4c_EstTemp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", "SIGPRMEIBO.GravarArquivos")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LerArquivos - Le XMLs de pedidos web e insere movimentos no banco
    * Portado de SIGPRMEI.lerarquivos
    *--------------------------------------------------------------------------
    PROCEDURE LerArquivos()
        LOCAL loc_lSucesso, loc_laArq[1], loc_lnArq, loc_lcDpd, loc_lcDeq
        LOCAL loc_lcDop, loc_lcGrO, loc_lcCtO, loc_lcGrD, loc_lcGrV, loc_lcCtV
        LOCAL loc_lcUsu, loc_lcEmp, loc_lcQuery, loc_lcDadA, loc_lcArq
        LOCAL loc_lnNum, loc_lcEdn, loc_lcEgn, loc_lcIdCab, loc_lcCtD
        LOCAL loc_lnTit, loc_lnItn, loc_lnBus, loc_lcBus, loc_lcDad, loc_lcFim
        LOCAL loc_lnTps, loc_lcCPF, loc_lcCww, loc_lnCdC, loc_lcFpg, loc_lnVal
        LOCAL loc_lnNop, loc_lcAtu, loc_lcCep, loc_lcArqTo, loc_lcDst, loc_lcOK1
        LOCAL loc_lnPrc, loc_lcCod, loc_lcMascNum, loc_lnPvens, loc_oErro
        LOCAL loc_lcObsesCab, loc_lcNotasCab, loc_lcContaDs, loc_lcDat
        LOCAL loc_lnValVars, loc_lnValInis, loc_lnValos
        LOCAL loc_lcCPros, loc_lcDPros, loc_lcCUnis, loc_lcObsItn
        LOCAL loc_lnQtds, loc_lnUnits, loc_lnTotas
        LOCAL loc_lcIdPar, loc_lcIdItn, loc_lnEncargos
        LOCAL loc_lcSQLCab, loc_lcSQLPar, loc_lcSQLItn
        LOCAL loc_lTransAberta

        loc_lSucesso = .T.
        loc_lTransAberta = .F.

        TRY
            *-- Parametros de operacao
            loc_lcDop = ALLTRIM(this_cDop)
            loc_lcGrO = ALLTRIM(this_cGrO)
            loc_lcCtO = ALLTRIM(this_cCtO)
            loc_lcGrD = ALLTRIM(this_cGrD)
            loc_lcGrV = ALLTRIM(this_cGrV)
            loc_lcCtV = ALLTRIM(this_cCtV)
            loc_lcUsu = ALLTRIM(this_cUsu)
            loc_lcEmp = ALLTRIM(this_cEmp)

            *-- Diretorios
            loc_lcDpd = ALLTRIM(this_cDirLivros)
            IF !EMPTY(loc_lcDpd)
                loc_lcDpd = IIF(RIGHT(loc_lcDpd, 1) = "\", loc_lcDpd, loc_lcDpd + "\")
            ENDIF
            loc_lcDeq = ALLTRIM(this_cDirSaida)
            IF !EMPTY(loc_lcDeq)
                loc_lcDeq = IIF(RIGHT(loc_lcDeq, 1) = "\", loc_lcDeq, loc_lcDeq + "\")
            ENDIF

            *-- Buscar config de SigCdOpe
            loc_lcQuery = "Select GruOrigs, ConOrigs, GruDests, GrVends " + ;
                "From SigCdOpe " + ;
                "Where Dopes = '" + PADR(loc_lcDop, 20) + "'"

            IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_LerOpe") > 0
                SELECT cursor_4c_LerOpe
                GO TOP
                IF !EOF()
                    loc_lcGrO = IIF(EMPTY(cursor_4c_LerOpe.GruOrigs), loc_lcGrO, ALLTRIM(cursor_4c_LerOpe.GruOrigs))
                    loc_lcCtO = IIF(EMPTY(cursor_4c_LerOpe.ConOrigs), loc_lcGrO, ALLTRIM(cursor_4c_LerOpe.ConOrigs))
                    loc_lcGrD = IIF(EMPTY(cursor_4c_LerOpe.GruDests), loc_lcGrD, ALLTRIM(cursor_4c_LerOpe.GruDests))
                    loc_lcGrV = IIF(EMPTY(LEFT(cursor_4c_LerOpe.GrVends, 10)), loc_lcGrV, ALLTRIM(LEFT(cursor_4c_LerOpe.GrVends, 10)))
                ENDIF
                USE IN cursor_4c_LerOpe
            ELSE
                MsgErro("Falha ao buscar configura" + CHR(231) + CHR(227) + "o de SigCdOpe", "SIGPRMEIBO.LerArquivos")
                loc_lSucesso = .F.
            ENDIF

            *-- Listar arquivos XML
            loc_lnArq = ADIR(loc_laArq, loc_lcDpd + "*.XML")

            IF loc_lnArq > 0 AND loc_lSucesso
                FOR loc_lnPrc = 1 TO loc_lnArq
                    this_cUltStatus = "Processando Pedido " + ALLTRIM(STR(loc_lnPrc)) + " de " + ALLTRIM(STR(loc_lnArq))

                    loc_lcArq = loc_lcDpd + ALLTRIM(loc_laArq(loc_lnPrc, 1))
                    loc_lcDadA = FILETOSTR(loc_lcArq)
                    loc_lcDadA = ALLTRIM(UPPER(loc_lcDadA))

                    IF !EMPTY(loc_lcDadA)

                        *-- Validar CEP se presente
                        IF "<CLIENTE_CEP>" $ loc_lcDadA
                            loc_lcAtu = ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_CEP>", "</CLIENTE_CEP>"))
                            loc_lcCep = PADL(STRTRAN(loc_lcAtu, "-", ""), 8, "0")
                            loc_lcCep = LEFT(loc_lcCep, 5) + "-" + RIGHT(loc_lcCep, 3)

                            loc_lcQuery = "Select ceps From cep Where ceps = '" + loc_lcCep + "'"
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_Cep") > 0
                                IF RECCOUNT("cursor_4c_Cep") = 0
                                    loc_lcArqTo = SUBSTR(loc_lcArq, 1, LEN(loc_lcArq) - 3) + "TXT"
                                    IF FILE(loc_lcArq)
                                        RENAME (loc_lcArq) TO (loc_lcArqTo)
                                    ENDIF
                                    IF USED("cursor_4c_Cep")
                                        USE IN cursor_4c_Cep
                                    ENDIF
                                    LOOP
                                ENDIF
                                IF USED("cursor_4c_Cep")
                                    USE IN cursor_4c_Cep
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Sanitizar XML: remover caracteres problematicos
                        loc_lcDadA = CHRTRAN(loc_lcDadA, ",", ".")
                        loc_lcDadA = CHRTRAN(loc_lcDadA, CHR(34) + "'", "  ")
                        loc_lcDadA = CHRTRAN(loc_lcDadA, "[]", "  ")
                        loc_lcDadA = CHRTRAN(loc_lcDadA, CHR(9), "")

                        *-- Gerar identificadores do movimento
                        loc_lnNum    = fGerUniqueKey(loc_lcDop + loc_lcEmp)
                        loc_lcMascNum = fGerMascara(loc_lnNum)
                        loc_lcEdn    = PADR(loc_lcEmp, 3) + PADR(loc_lcDop, 20) + STR(loc_lnNum, 6)
                        loc_lcEgn    = PADR(loc_lcEmp, 3) + SPACE(20) + STR(loc_lnNum, 6)
                        loc_lcIdCab  = fUniqueIds()

                        *-- Inicializar variaveis do cabecalho
                        loc_lcObsesCab  = ""
                        loc_lcNotasCab  = ""
                        loc_lcContaDs   = ""
                        loc_lcDat       = ""
                        loc_lnValVars   = 0
                        loc_lnValInis   = 0
                        loc_lnValos     = 0
                        loc_lnTit       = 0
                        loc_lnTps       = 1
                        loc_lcCPF       = ""
                        loc_lcFpg       = ""
                        loc_lnVal       = 0
                        loc_lcIdPar     = ""

                        *-- Processar campos do cabecalho XML
                        FOR loc_lnBus = 1 TO 12
                            DO CASE
                                CASE loc_lnBus = 1 && Codigo do pedido
                                    loc_lcBus = "<PEDIDO_CODIGO>"
                                CASE loc_lnBus = 2 && Status codigo
                                    loc_lcBus = "<PEDIDO_STATUS_CODIGO>"
                                CASE loc_lnBus = 3 && Status descricao
                                    loc_lcBus = "<PEDIDO_STATUS>"
                                CASE loc_lnBus = 4 && Data/hora
                                    loc_lcBus = "<PEDIDO_DATA_HORA>"
                                CASE loc_lnBus = 5 && Tipo documento cliente
                                    loc_lcBus = "<CLIENTE_TIPO_DOCUMENTO>"
                                CASE loc_lnBus = 6 && Codigo frete
                                    loc_lcBus = "<PEDIDO_FRETE_CODIGO>"
                                CASE loc_lnBus = 7 && Forma frete
                                    loc_lcBus = "<PEDIDO_FRETE_FORMA>"
                                CASE loc_lnBus = 8 && Valor frete
                                    loc_lcBus = "<PEDIDO_FRETE_VALOR>"
                                CASE loc_lnBus = 9 && Codigo pagamento
                                    loc_lcBus = "<PEDIDO_PAGAMENTO_CODIGO>"
                                CASE loc_lnBus = 10 && Obs cliente
                                    loc_lcBus = "<PEDIDO_INFO_OBS_CLIENTE>"
                                CASE loc_lnBus = 11 && Obs loja
                                    loc_lcBus = "<PEDIDO_INFO_OBS_LOJA>"
                                OTHERWISE && Quantidade produtos
                                    loc_lcBus = "<PEDIDO_INFO_QUANTIDADE_PRODUTOS>"
                            ENDCASE

                            loc_lcFim = "</" + SUBSTR(loc_lcBus, 2)

                            IF loc_lcBus $ loc_lcDadA
                                loc_lcDad = ALLTRIM(STREXTRACT(loc_lcDadA, loc_lcBus, loc_lcFim))

                                DO CASE
                                    CASE loc_lnBus = 1
                                        loc_lcNotasCab = LEFT(SUBSTR(loc_lcDad, 4), 6)
                                        loc_lcObsesCab = loc_lcObsesCab + "-" + loc_lcDad + CHR(13)

                                    CASE loc_lnBus = 2 AND !EMPTY(loc_lcDad)
                                        loc_lcObsesCab = loc_lcObsesCab + "STATUS: " + loc_lcDad

                                    CASE loc_lnBus = 3 AND !EMPTY(loc_lcDad)
                                        loc_lcObsesCab = loc_lcObsesCab + "-" + loc_lcDad + CHR(13)

                                    CASE loc_lnBus = 4
                                        *-- Data vem invertida: YYYY-MM-DD HH:MM:SS -> DD/MM/YYYY HH:MM:SS
                                        loc_lcDat = SUBSTR(loc_lcDad, 9, 2) + "/" + SUBSTR(loc_lcDad, 6, 2) + "/" + SUBSTR(loc_lcDad, 1, 4) + " " + SUBSTR(loc_lcDad, 12)

                                    CASE loc_lnBus = 5
                                        loc_lnTps = 1 && Pessoa Fisica
                                        IF "<CLIENTE_DOCUMENTO>" $ loc_lcDadA
                                            loc_lcCPF = ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_DOCUMENTO>", "</CLIENTE_DOCUMENTO>"))
                                            IF !(loc_lcDad = "CPF" OR LEN(ALLTRIM(loc_lcCPF)) = 14)
                                                loc_lnTps = 2 && Pessoa Juridica
                                            ENDIF

                                            *-- Verificar se cliente ja existe
                                            loc_lcQuery = "Select IClis From SigCdCli Where Cpfs = '" + PADR(loc_lcCPF, 20) + "'"
                                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_CliChk") > 0
                                                SELECT cursor_4c_CliChk
                                                GO TOP
                                                IF EOF()
                                                    *-- Novo cliente: gerar codigo
                                                    loc_lnCdC = fGerUniqueKey(ALLTRIM(loc_lcGrD) + loc_lcEmp)
                                                    loc_lcCtD = "CW" + loc_lcEmp + PADL(ALLTRIM(STR(loc_lnCdC)), 5, "0")
                                                ELSE
                                                    loc_lcCtD = ALLTRIM(cursor_4c_CliChk.IClis)
                                                ENDIF
                                                USE IN cursor_4c_CliChk
                                                loc_lcContaDs = loc_lcCtD
                                            ELSE
                                                MsgErro("Falha ao verificar cliente CPF: " + loc_lcCPF, "SIGPRMEIBO.LerArquivos")
                                            ENDIF
                                        ENDIF

                                    CASE loc_lnBus = 6 AND !EMPTY(loc_lcDad)
                                        loc_lcObsesCab = loc_lcObsesCab + "FRETE: " + loc_lcDad

                                    CASE loc_lnBus = 7 AND !EMPTY(loc_lcDad)
                                        loc_lcObsesCab = loc_lcObsesCab + "-" + loc_lcDad + CHR(13)

                                    CASE loc_lnBus = 8 AND !EMPTY(loc_lcDad)
                                        loc_lcObsesCab = loc_lcObsesCab + "VALOR FRETE: R$" + loc_lcDad + CHR(13)
                                        loc_lnValVars = VAL(loc_lcDad)

                                    CASE loc_lnBus = 9 AND !EMPTY(loc_lcDad)
                                        loc_lcFpg = "WEB " + loc_lcDad
                                        loc_lnVal = 0
                                        IF "<PEDIDO_PAGAMENTO_VALOR>" $ loc_lcDadA
                                            loc_lnVal = VAL(ALLTRIM(STREXTRACT(loc_lcDadA, "<PEDIDO_PAGAMENTO_VALOR>", "</PEDIDO_PAGAMENTO_VALOR>")))
                                        ENDIF
                                        loc_lnValInis = loc_lnVal
                                        loc_lnValos   = loc_lnVal

                                    CASE loc_lnBus = 10 AND !EMPTY(loc_lcDad)
                                        loc_lcObsesCab = loc_lcObsesCab + "OBS. CLIENTE: " + loc_lcDad + CHR(13)

                                    CASE loc_lnBus = 11 AND !EMPTY(loc_lcDad)
                                        loc_lcObsesCab = loc_lcObsesCab + "OBS. LOJA: " + loc_lcDad + CHR(13)

                                    CASE loc_lnBus = 12 AND !EMPTY(loc_lcDad)
                                        loc_lnTit = VAL(loc_lcDad)

                                ENDCASE
                            ENDIF
                        NEXT

                        *-- Iniciar transacao
                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                        loc_lTransAberta = .T.
                        loc_lSucesso = .T.

                        *-- INSERT/UPDATE cliente
                        IF loc_lSucesso AND !EMPTY(loc_lcContaDs)
                            *-- Verificar se novo (INSERT) ou existente (UPDATE)
                            loc_lcQuery = "Select COUNT(*) AS nExiste From SigCdCli Where IClis = '" + loc_lcContaDs + "'"
                            IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_CliExiste") > 0
                                SELECT cursor_4c_CliExiste
                                GO TOP
                                IF NVL(cursor_4c_CliExiste.nExiste, 0) = 0
                                    *-- Novo cliente: INSERT
                                    loc_lcSQLCab = "INSERT INTO SigCdCli " + ;
                                        "(Grupos, IClis, TpClis, Cpfs, Paises, Usuars, DataIncs, Emps, ContaVens) " + ;
                                        "VALUES (" + ;
                                        EscaparSQL(PADR(loc_lcGrD, 10)) + ", " + ;
                                        EscaparSQL(PADR(loc_lcContaDs, 10)) + ", " + ;
                                        FormatarNumeroSQL(loc_lnTps, 0) + ", " + ;
                                        EscaparSQL(PADR(loc_lcCPF, 20)) + ", " + ;
                                        "'BRASIL     ', " + ;
                                        EscaparSQL(PADR(loc_lcUsu, 10)) + ", " + ;
                                        "GETDATE(), " + ;
                                        EscaparSQL(PADR(loc_lcEmp, 3)) + ", " + ;
                                        EscaparSQL(PADR(loc_lcCtV, 10)) + ;
                                        ")"
                                    IF SQLEXEC(gnConnHandle, loc_lcSQLCab) < 1
                                        MsgErro("Falha ao inserir cliente: " + loc_lcContaDs, "SIGPRMEIBO.LerArquivos")
                                        loc_lSucesso = .F.
                                    ENDIF

                                    *-- Codigo web no obs
                                    IF loc_lSucesso AND "<CLIENTE_CODIGO>" $ loc_lcDadA
                                        loc_lcCww = ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_CODIGO>", "</CLIENTE_CODIGO>"))
                                        IF !EMPTY(loc_lcCww)
                                            SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Obs = ISNULL(CAST(Obs AS VARCHAR(MAX)), '') + 'CODIGO WEB: " + loc_lcCww + CHR(13) + "' WHERE IClis = " + EscaparSQL(loc_lcContaDs))
                                        ENDIF
                                    ENDIF
                                ENDIF
                                USE IN cursor_4c_CliExiste
                            ENDIF

                            *-- Atualizar dados de contato do cliente
                            IF loc_lSucesso
                                IF "<CLIENTE_EMAIL>" $ loc_lcDadA
                                    loc_lcAtu = ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_EMAIL>", "</CLIENTE_EMAIL>"))
                                    IF !EMPTY(loc_lcAtu)
                                        SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Emails = " + EscaparSQL(LEFT(loc_lcAtu, 60)) + " WHERE IClis = " + EscaparSQL(loc_lcContaDs) + " AND (RTRIM(ISNULL(Emails,'')) = '' OR RTRIM(Emails) <> " + EscaparSQL(ALLTRIM(loc_lcAtu)) + ")")
                                    ENDIF
                                ENDIF
                                IF "<CLIENTE_NOME>" $ loc_lcDadA
                                    loc_lcAtu = THIS.TiraAcima128(fLimpaTexto(ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_NOME>", "</CLIENTE_NOME>"))))
                                    IF !EMPTY(loc_lcAtu)
                                        SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET RClis = " + EscaparSQL(LEFT(loc_lcAtu, 40)) + ", Razaos = CASE WHEN RTRIM(ISNULL(Razaos,''))='' THEN " + EscaparSQL(LEFT(loc_lcAtu, 40)) + " ELSE Razaos END WHERE IClis = " + EscaparSQL(loc_lcContaDs))
                                    ENDIF
                                ENDIF
                                IF "<CLIENTE_ENDERECO>" $ loc_lcDadA
                                    loc_lcAtu = THIS.TiraAcima128(fLimpaTexto(ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_ENDERECO>", "</CLIENTE_ENDERECO>"))))
                                    IF !EMPTY(loc_lcAtu)
                                        SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Endes = " + EscaparSQL(LEFT(loc_lcAtu, 40)) + " WHERE IClis = " + EscaparSQL(loc_lcContaDs) + " AND (RTRIM(ISNULL(Endes,'')) = '' OR RTRIM(Endes) <> " + EscaparSQL(LEFT(loc_lcAtu, 40)) + ")")
                                    ENDIF
                                ENDIF
                                IF "<CLIENTE_NUMERO>" $ loc_lcDadA
                                    loc_lcAtu = ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_NUMERO>", "</CLIENTE_NUMERO>"))
                                    IF !EMPTY(loc_lcAtu)
                                        SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Nums = " + EscaparSQL(LEFT(loc_lcAtu, 10)) + " WHERE IClis = " + EscaparSQL(loc_lcContaDs) + " AND (RTRIM(ISNULL(Nums,'')) = '' OR RTRIM(Nums) <> " + EscaparSQL(LEFT(loc_lcAtu, 10)) + ")")
                                    ENDIF
                                ENDIF
                                IF "<CLIENTE_COMPLEMENTO>" $ loc_lcDadA
                                    loc_lcAtu = THIS.TiraAcima128(fLimpaTexto(ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_COMPLEMENTO>", "</CLIENTE_COMPLEMENTO>"))))
                                    IF !EMPTY(loc_lcAtu)
                                        SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Compls = " + EscaparSQL(LEFT(loc_lcAtu, 20)) + " WHERE IClis = " + EscaparSQL(loc_lcContaDs) + " AND (RTRIM(ISNULL(Compls,'')) = '' OR RTRIM(Compls) <> " + EscaparSQL(LEFT(loc_lcAtu, 20)) + ")")
                                    ENDIF
                                ENDIF
                                IF "<CLIENTE_BAIRRO>" $ loc_lcDadA
                                    loc_lcAtu = THIS.TiraAcima128(fLimpaTexto(ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_BAIRRO>", "</CLIENTE_BAIRRO>"))))
                                    IF !EMPTY(loc_lcAtu)
                                        SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Bairs = " + EscaparSQL(LEFT(loc_lcAtu, 20)) + " WHERE IClis = " + EscaparSQL(loc_lcContaDs) + " AND (RTRIM(ISNULL(Bairs,'')) = '' OR RTRIM(Bairs) <> " + EscaparSQL(LEFT(loc_lcAtu, 20)) + ")")
                                    ENDIF
                                ENDIF
                                IF "<CLIENTE_CIDADE>" $ loc_lcDadA
                                    loc_lcAtu = THIS.TiraAcima128(fLimpaTexto(ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_CIDADE>", "</CLIENTE_CIDADE>"))))
                                    IF !EMPTY(loc_lcAtu)
                                        SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Cidas = " + EscaparSQL(LEFT(loc_lcAtu, 20)) + " WHERE IClis = " + EscaparSQL(loc_lcContaDs) + " AND (RTRIM(ISNULL(Cidas,'')) = '' OR RTRIM(Cidas) <> " + EscaparSQL(LEFT(loc_lcAtu, 20)) + ")")
                                    ENDIF
                                ENDIF
                                IF "<CLIENTE_ESTADO>" $ loc_lcDadA
                                    loc_lcAtu = THIS.TiraAcima128(fLimpaTexto(ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_ESTADO>", "</CLIENTE_ESTADO>"))))
                                    loc_lcQuery = "select estados from sigcdufs Where descrs = '" + ALLTRIM(loc_lcAtu) + "'"
                                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_Uf") > 0
                                        SELECT cursor_4c_Uf
                                        GO TOP
                                        IF !EOF() AND !EMPTY(ALLTRIM(cursor_4c_Uf.estados))
                                            SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Estas = " + EscaparSQL(ALLTRIM(cursor_4c_Uf.estados)) + " WHERE IClis = " + EscaparSQL(loc_lcContaDs))
                                        ENDIF
                                        USE IN cursor_4c_Uf
                                    ENDIF
                                ENDIF
                                IF "<CLIENTE_CEP>" $ loc_lcDadA
                                    loc_lcAtu = ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_CEP>", "</CLIENTE_CEP>"))
                                    IF !EMPTY(loc_lcAtu)
                                        LOCAL loc_lcCepFmt
                                        loc_lcCepFmt = LEFT(loc_lcAtu, 5) + "-" + RIGHT(loc_lcAtu, 3)
                                        SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Ceps = " + EscaparSQL(loc_lcCepFmt) + " WHERE IClis = " + EscaparSQL(loc_lcContaDs) + " AND (RTRIM(ISNULL(Ceps,'')) = '' OR RTRIM(Ceps) <> " + EscaparSQL(loc_lcCepFmt) + ")")
                                    ENDIF
                                ENDIF
                                IF "<CLIENTE_TELEFONE_1>" $ loc_lcDadA
                                    loc_lcAtu = ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_TELEFONE_1>", "</CLIENTE_TELEFONE_1>"))
                                    IF !EMPTY(loc_lcAtu)
                                        SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Tel1s = " + EscaparSQL(LEFT(loc_lcAtu, 20)) + " WHERE IClis = " + EscaparSQL(loc_lcContaDs) + " AND (RTRIM(ISNULL(Tel1s,'')) = '' OR RTRIM(Tel1s) <> " + EscaparSQL(LEFT(loc_lcAtu, 20)) + ")")
                                    ENDIF
                                ENDIF
                                IF "<CLIENTE_TELEFONE_2>" $ loc_lcDadA
                                    loc_lcAtu = ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_TELEFONE_2>", "</CLIENTE_TELEFONE_2>"))
                                    IF !EMPTY(loc_lcAtu)
                                        SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Tel2s = " + EscaparSQL(LEFT(loc_lcAtu, 20)) + " WHERE IClis = " + EscaparSQL(loc_lcContaDs) + " AND (RTRIM(ISNULL(Tel2s,'')) = '' OR RTRIM(Tel2s) <> " + EscaparSQL(LEFT(loc_lcAtu, 20)) + ")")
                                    ENDIF
                                ENDIF
                                IF "<CLIENTE_IE_RG_DOCUMENTO>" $ loc_lcDadA
                                    loc_lcAtu = ALLTRIM(STREXTRACT(loc_lcDadA, "<CLIENTE_IE_RG_DOCUMENTO>", "</CLIENTE_IE_RG_DOCUMENTO>"))
                                    IF !EMPTY(loc_lcAtu) AND !INLIST(UPPER(ALLTRIM(loc_lcAtu)), "ISENTO", "ISENTA")
                                        SQLEXEC(gnConnHandle, "UPDATE SigCdCli SET Rgs = " + EscaparSQL(LEFT(loc_lcAtu, 20)) + " WHERE IClis = " + EscaparSQL(loc_lcContaDs) + " AND (RTRIM(ISNULL(Rgs,'')) = '' OR RTRIM(Rgs) <> " + EscaparSQL(LEFT(loc_lcAtu, 20)) + ")")
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- INSERT SigMvCab
                        IF loc_lSucesso
                            loc_lcSQLCab = "INSERT INTO SigMvCab (" + ;
                                "emps, dopes, numes, mascnum, " + ;
                                "datars, datas, datatrans, dtalts, " + ;
                                "transps, usuals, usuars, vends, resps, " + ;
                                "obses, opers, ultgrvs, " + ;
                                "empdopnums, empgopnums, grupoos, contaos, " + ;
                                "grupods, grvends, grresps, cidchaves, " + ;
                                "notas, contads, valvars, valinis, valos" + ;
                                ") VALUES (" + ;
                                EscaparSQL(PADR(loc_lcEmp, 3)) + ", " + ;
                                EscaparSQL(PADR(loc_lcDop, 20)) + ", " + ;
                                FormatarNumeroSQL(loc_lnNum, 0) + ", " + ;
                                EscaparSQL(PADR(loc_lcMascNum, 10)) + ", " + ;
                                "GETDATE(), " + ;
                                IIF(EMPTY(loc_lcDat), "GETDATE()", "'" + loc_lcDat + "'") + ", " + ;
                                "NULL, NULL, " + ;
                                "0, '', " + ;
                                EscaparSQL(PADR(loc_lcUsu, 10)) + ", " + ;
                                EscaparSQL(PADR(loc_lcUsu, 10)) + ", " + ;
                                EscaparSQL(PADR(loc_lcUsu, 10)) + ", " + ;
                                EscaparSQL(LEFT(loc_lcObsesCab, 4000)) + ", " + ;
                                "'S', " + ;
                                EscaparSQL(LEFT("SIGPRMEI - " + TTOC(DATETIME()), 40)) + ", " + ;
                                EscaparSQL(PADR(loc_lcEdn, 29)) + ", " + ;
                                EscaparSQL(PADR(loc_lcEgn, 29)) + ", " + ;
                                EscaparSQL(PADR(loc_lcGrO, 10)) + ", " + ;
                                EscaparSQL(PADR(loc_lcCtO, 10)) + ", " + ;
                                EscaparSQL(PADR(loc_lcGrD, 10)) + ", " + ;
                                EscaparSQL(PADR(loc_lcGrV, 10)) + ", " + ;
                                EscaparSQL(PADR(loc_lcGrV, 10)) + ", " + ;
                                EscaparSQL(PADR(loc_lcIdCab, 20)) + ", " + ;
                                EscaparSQL(PADR(loc_lcNotasCab, 6)) + ", " + ;
                                EscaparSQL(PADR(loc_lcContaDs, 10)) + ", " + ;
                                FormatarNumeroSQL(loc_lnValVars, 2) + ", " + ;
                                FormatarNumeroSQL(loc_lnValInis, 2) + ", " + ;
                                FormatarNumeroSQL(loc_lnValos, 2) + ;
                                ")"

                            IF SQLEXEC(gnConnHandle, loc_lcSQLCab) < 1
                                MsgErro("Falha ao inserir cabe" + CHR(231) + "alho SigMvCab [Pedido: " + loc_lcNotasCab + "]", "SIGPRMEIBO.LerArquivos")
                                loc_lSucesso = .F.
                            ENDIF
                        ENDIF

                        *-- INSERT SigMvpar (pagamento)
                        IF loc_lSucesso AND !EMPTY(loc_lcFpg)
                            loc_lnNop   = fGerUniqueKey("SIGMVCCR")
                            loc_lcIdPar = fUniqueIds()

                            loc_lcSQLPar = "INSERT INTO SigMvpar (" + ;
                                "fpags, emps, dopes, numes, empdopnums, " + ;
                                "datas, datatrans, vencs, dtalts, dpags, dtdeps, " + ;
                                "nopers, cotfpgs, parcs, tparcs, pagos, moefpgs, " + ;
                                "valos, vpags, cidchaves, " + ;
                                "agencias, bancos, cartaos, contas, dcarts, " + ;
                                "ec_numes, grclis, iclis, impcars, inschs, locals, " + ;
                                "ncarnes, ncarts, ncopias, nocreditos, nrecs, ntrans, " + ;
                                "numchqs, numeros, numolds, outros, cotusus, " + ;
                                "cnidtefs, cnnsupars, numlotechs, nidcheps, empos, " + ;
                                "valocurs, trocos, cpfs, digagencs, digchqs, digcontas, " + ;
                                "pracas, valdescs, codbcrts, lcancelas, " + ;
                                "vcofins, vcsll, virf, vlrtrbfs, vpis, " + ;
                                "adquirente, autoriza, nsu, chaveexterna" + ;
                                ") VALUES (" + ;
                                EscaparSQL(PADR(loc_lcFpg, 12)) + ", " + ;
                                EscaparSQL(PADR(loc_lcEmp, 3)) + ", " + ;
                                EscaparSQL(PADR(loc_lcDop, 20)) + ", " + ;
                                FormatarNumeroSQL(loc_lnNum, 0) + ", " + ;
                                EscaparSQL(PADR(loc_lcEdn, 29)) + ", " + ;
                                IIF(EMPTY(loc_lcDat), "GETDATE()", "'" + loc_lcDat + "'") + ", " + ;
                                "NULL, " + ;
                                IIF(EMPTY(loc_lcDat), "GETDATE()", "'" + loc_lcDat + "'") + ", " + ;
                                "NULL, NULL, NULL, " + ;
                                FormatarNumeroSQL(loc_lnNop, 0) + ", " + ;
                                "1, 1, 1, '1', 'R  ', " + ;
                                FormatarNumeroSQL(loc_lnVal, 2) + ", " + ;
                                "0, " + ;
                                EscaparSQL(PADR(loc_lcIdPar, 20)) + ", " + ;
                                "'    ', '   ', '                    ', '          ', '            ', " + ;
                                "0, '          ', '          ', ' ', 0, '          ', " + ;
                                "'           ', 0, 0, '          ', 0, 0, " + ;
                                "'        ', '      ', 0, '                    ', '                              ', " + ;
                                "'          ', '            ', 0, 0, '   ', " + ;
                                "0, 0, '                    ', ' ', ' ', ' ', " + ;
                                "'   ', 0, '     ', 0, " + ;
                                "0, 0, 0, 0, 0, " + ;
                                "'        ', '      ', '                                                  ', '                                 '" + ;
                                ")"

                            IF SQLEXEC(gnConnHandle, loc_lcSQLPar) < 1
                                MsgErro("Falha ao inserir pagamento SigMvpar [Pedido: " + loc_lcNotasCab + "]", "SIGPRMEIBO.LerArquivos")
                                loc_lSucesso = .F.
                            ENDIF
                        ENDIF

                        *-- INSERT itens do pedido
                        IF loc_lSucesso AND loc_lnTit > 0
                            loc_lnItn = 1
                            DO WHILE "<PRODUTO_CODIGO>" $ loc_lcDadA AND loc_lnItn <= loc_lnTit AND loc_lSucesso
                                loc_lcCPros = "PRODUTOWEB        "
                                loc_lcCod   = ALLTRIM(STREXTRACT(loc_lcDadA, "<PRODUTO_CODIGO>", "</PRODUTO_CODIGO>"))
                                loc_lcObsItn = loc_lcCod + " "
                                loc_lcDPros  = ""
                                loc_lnQtds   = 0
                                loc_lnUnits  = 0
                                loc_lnTotas  = 0
                                loc_lcCUnis  = "PC "
                                loc_lnEncargos = 0

                                IF "<PRODUTO_VARIACAO_INFORMACAO>" $ loc_lcDadA
                                    loc_lcObsItn = loc_lcObsItn + ALLTRIM(STREXTRACT(loc_lcDadA, "<PRODUTO_VARIACAO_INFORMACAO>", "</PRODUTO_VARIACAO_INFORMACAO>"))
                                ENDIF

                                IF "<PRODUTO_PRECO_TOTAL>" $ loc_lcDadA
                                    loc_lnTotas = VAL(ALLTRIM(STREXTRACT(loc_lcDadA, "<PRODUTO_PRECO_TOTAL>", "</PRODUTO_PRECO_TOTAL>")))
                                ENDIF

                                IF "<PRODUTO_QUANTIDADE>" $ loc_lcDadA
                                    loc_lnQtds = VAL(ALLTRIM(STREXTRACT(loc_lcDadA, "<PRODUTO_QUANTIDADE>", "</PRODUTO_QUANTIDADE>")))
                                ENDIF

                                IF "<PRODUTO_REFERENCIA>" $ loc_lcDadA
                                    loc_lcDad = ALLTRIM(STREXTRACT(loc_lcDadA, "<PRODUTO_REFERENCIA>", "</PRODUTO_REFERENCIA>"))
                                    loc_lcQuery = "Select CUnis From SigCdPro Where CPros = '" + PADR(loc_lcDad, 14) + "'"
                                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_Pro") > 0
                                        SELECT cursor_4c_Pro
                                        GO TOP
                                        IF !EOF()
                                            loc_lcCPros = PADR(loc_lcDad, 14)
                                            loc_lcCUnis = PADR(ALLTRIM(cursor_4c_Pro.CUnis), 3)
                                        ENDIF
                                        USE IN cursor_4c_Pro
                                    ENDIF
                                ENDIF

                                IF "<PRODUTO_PRECO>" $ loc_lcDadA
                                    loc_lnUnits = VAL(ALLTRIM(STREXTRACT(loc_lcDadA, "<PRODUTO_PRECO>", "</PRODUTO_PRECO>")))
                                ENDIF

                                IF "<PRODUTO_NOME>" $ loc_lcDadA
                                    loc_lcDPros = LEFT(ALLTRIM(STREXTRACT(loc_lcDadA, "<PRODUTO_NOME>", "</PRODUTO_NOME>")), 65)
                                ENDIF

                                *-- Retirar IPI (Encargos) do valor unitario e total
                                loc_lcQuery = "Select Encargos From SigCdPro Where CPros = '" + ALLTRIM(loc_lcCPros) + "'"
                                IF SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_Enc") > 0
                                    SELECT cursor_4c_Enc
                                    GO TOP
                                    IF !EOF() AND !EMPTY(cursor_4c_Enc.Encargos) AND cursor_4c_Enc.Encargos <> 0
                                        loc_lnEncargos = cursor_4c_Enc.Encargos
                                        loc_lnUnits = loc_lnUnits - ((loc_lnUnits * loc_lnEncargos) / 100)
                                        loc_lnTotas = loc_lnQtds * loc_lnUnits
                                    ENDIF
                                    USE IN cursor_4c_Enc
                                ENDIF

                                loc_lcIdItn = fUniqueIds()

                                loc_lcSQLItn = "INSERT INTO SigMvItn (" + ;
                                    "citens, cpros, emps, dopes, numes, datatrans, dtalts, " + ;
                                    "empdopnums, fatvals, moevals, opers, moedas, moevs, cunis, " + ;
                                    "cidchaves, obs, qtds, units, totas, dpros" + ;
                                    ") VALUES (" + ;
                                    FormatarNumeroSQL(loc_lnItn, 0) + ", " + ;
                                    EscaparSQL(PADR(ALLTRIM(loc_lcCPros), 14)) + ", " + ;
                                    EscaparSQL(PADR(loc_lcEmp, 3)) + ", " + ;
                                    EscaparSQL(PADR(loc_lcDop, 20)) + ", " + ;
                                    FormatarNumeroSQL(loc_lnNum, 0) + ", " + ;
                                    "NULL, NULL, " + ;
                                    EscaparSQL(PADR(loc_lcEdn, 29)) + ", " + ;
                                    "1, 1, 'S', 'R  ', 'R  ', " + ;
                                    EscaparSQL(PADR(ALLTRIM(loc_lcCUnis), 3)) + ", " + ;
                                    EscaparSQL(PADR(loc_lcIdItn, 20)) + ", " + ;
                                    EscaparSQL(LEFT(loc_lcObsItn, 4000)) + ", " + ;
                                    FormatarNumeroSQL(loc_lnQtds, 3) + ", " + ;
                                    FormatarNumeroSQL(loc_lnUnits, 6) + ", " + ;
                                    FormatarNumeroSQL(loc_lnTotas, 2) + ", " + ;
                                    EscaparSQL(loc_lcDPros) + ;
                                    ")"

                                IF SQLEXEC(gnConnHandle, loc_lcSQLItn) < 1
                                    MsgErro("Falha ao inserir item " + TRANSFORM(loc_lnItn) + " [Pedido: " + loc_lcNotasCab + "]", "SIGPRMEIBO.LerArquivos")
                                    loc_lSucesso = .F.
                                ENDIF

                                *-- Avanca para proximo produto no XML (consome tag </PRODUTO>)
                                loc_lcDadA = STREXTRACT(loc_lcDadA, "</PRODUTO>", "")
                                loc_lnItn  = loc_lnItn + 1
                            ENDDO
                        ENDIF

                        *-- Commit ou Rollback
                        IF loc_lSucesso
                            SQLEXEC(gnConnHandle, "COMMIT")
                            loc_lTransAberta = .F.
                            this_nArqProcessados = this_nArqProcessados + 1

                            *-- Mover arquivo processado para pasta OK
                            loc_lcOK1 = loc_lcDpd + "OK\"
                            IF !DIRECTORY(loc_lcOK1)
                                MKDIR (loc_lcOK1)
                            ENDIF
                            IF DIRECTORY(loc_lcOK1)
                                loc_lcDst = loc_lcOK1 + ALLTRIM(loc_laArq(loc_lnPrc, 1))
                                IF FILE(loc_lcArq)
                                    COPY FILE (loc_lcArq) TO (loc_lcDst)
                                ENDIF
                                IF FILE(loc_lcDst) AND FILE(loc_lcArq)
                                    DELETE FILE (loc_lcArq)
                                ENDIF
                            ENDIF
                        ELSE
                            SQLEXEC(gnConnHandle, "ROLLBACK")
                            loc_lTransAberta = .F.
                        ENDIF

                    ENDIF && !EMPTY(loc_lcDadA)
                NEXT
            ENDIF && loc_lnArq > 0

        CATCH TO loc_oErro
            IF loc_lTransAberta
                SQLEXEC(gnConnHandle, "ROLLBACK")
                loc_lTransAberta = .F.
            ENDIF
            MsgErro(loc_oErro.Message + " [LN=" + TRANSFORM(loc_oErro.LineNo) + "]", "SIGPRMEIBO.LerArquivos")
            loc_lSucesso = .F.
        ENDTRY

        this_lUltResultado = loc_lSucesso
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * TiraAcima128 - Remove caracteres com codigo ASCII acima de 127
    * Portado de funcao legada TiraAcima128 (Framework)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TiraAcima128(par_cTexto)
        LOCAL loc_cResult, loc_lnI, loc_lnCod
        loc_cResult = ""
        FOR loc_lnI = 1 TO LEN(par_cTexto)
            loc_lnCod = ASC(SUBSTR(par_cTexto, loc_lnI, 1))
            IF loc_lnCod <= 127
                loc_cResult = loc_cResult + SUBSTR(par_cTexto, loc_lnI, 1)
            ENDIF
        NEXT
        RETURN loc_cResult
    ENDPROC

ENDDEFINE

