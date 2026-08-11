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
                IF gnConnHandle > 0
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
                ENDIF

                THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
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
            .FontName        = "Tahoma"
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
            .FontName        = "Tahoma"
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
    * dos XMLs em fila ("incluir novo lote de movimentos"), sem entrar no
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
    * BtnAlterarClick - Reprocessa: releitura imediata de arquivos em fila
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
    * BtnBuscarClick - Verifica XMLs em fila no diretorio de entrada
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
                loc_cMsg = "Nenhum pedido em fila de processamento." + CHR(13) + CHR(13) + ;
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
