*==============================================================================
* Formsigprrcu.prg - Formulario Operacional: Recalculo de Custos de Produto
* Tipo: OPERACIONAL (dialog de processamento batch)
* Migrado de SIGPRRCU.SCX
* Logica: Processa fila SigOpClC chamando fRecalculaC para cada produto
*==============================================================================
DEFINE CLASS Formsigprrcu AS FormBase

    *-- Dimensoes identicas ao legado (580x150 - dialog pequeno de processamento)
    Width       = 580
    Height      = 150
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    WindowType  = 1
    ShowWindow  = 1
    ShowTips    = .T.
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Closable    = .F.
    DataSession = 2
    FontName    = "Tahoma"
    FontSize    = 8
    Themes      = .F.
    Caption     = "Rec" + CHR(225) + "lculo de Custos de Produto"

    *-- Estado interno
    this_lParametrizado = .F.
    this_lProcessando   = .F.
    this_cMensagemErro  = ""

    *==========================================================================
    * Init - Captura parametro opcional e chama base (conexao validada em InicializarForm)
    * par_cParametro: quando passado (string), indica modo Fortyus.Exe
    *==========================================================================
    PROCEDURE Init(par_cParametro)
        THIS.this_lParametrizado = (TYPE("par_cParametro") = "C" AND !EMPTY(par_cParametro))
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Monta estrutura visual e inicializa BO
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF gnConnHandle <= 0
            IF !THIS.this_lParametrizado
                MsgErro("Imposs" + CHR(237) + "vel efetuar conex" + CHR(227) + "o com Servidor de Banco de Dados.", ;
                        "Erro de Conex" + CHR(227) + "o")
            ENDIF
            RETURN loc_lSucesso
        ENDIF

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprrcuBO")

            IF VARTYPE(THIS.this_oBusinessObject) # "O"
                MsgErro("Erro ao criar sigprrcuBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ELSE
                IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                    THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                ENDIF

                THIS.ConfigurarPageFrame()
                THIS.ConfigurarPaginaLista()
                THIS.ConfigurarPaginaDados()
                THIS.TornarControlesVisiveis(THIS)
                THIS.ConfigurarBINDEVENTs()

                IF THIS.this_lParametrizado
                    THIS.this_oBusinessObject.IniciarLog()
                ENDIF

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: " + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cabecalho cinza com titulo do form
    * OPERACIONAL: cabecalho direto no form (sem PageFrame CRUD)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top       = 18
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
            .WordWrap  = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = THIS.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .WordWrap  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Botoes de acao (Processar e Encerrar) + Shape decorativo
    * OPERACIONAL: sem paginas CRUD, controles direto no form
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        *-- Botao Processar (legado: OK - Left=430)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 430
            .Width           = 75
            .Height          = 75
            .Caption         = "Processar"
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .WordWrap        = .T.
            .PicturePosition = 13
            .MousePointer    = 15
            .ToolTipText     = "Processar recalculo de custos"
        ENDWITH

        *-- Shape decorativo ao redor do botao Encerrar (legado: Shape1 - Top=-5, Left=498)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = -5
            .Left        = 498
            .Width       = 90
            .Height      = 110
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
        ENDWITH

        *-- Botao Encerrar (legado: SAIR - Left=505)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 3
            .Left            = 505
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .WordWrap        = .T.
            .PicturePosition = 13
            .MousePointer    = 15
            .ToolTipText     = "[ESC] Encerrar"
        ENDWITH

    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Painel de status/dados de processamento
    * OPERACIONAL: sem Page2/CRUD; este metodo cria o container de exibicao
    * de dados dinamicos (mensagem de status animada durante o loop de recalculo).
    * Legado: SIGPRRCU.Label1 (Top=108, Left=129, Width=321, Height=16).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- Container do painel de status (agrupa area de dados dinamicos)
        THIS.AddObject("cnt_4c_Dados", "Container")
        WITH THIS.cnt_4c_Dados
            .Top         = 100
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 40
            .BorderWidth = 0
            .BackStyle   = 0
            .Visible     = .T.
        ENDWITH

        *-- Label de status (animacao de progresso durante processamento)
        THIS.cnt_4c_Dados.AddObject("lbl_4c_Status", "Label")
        WITH THIS.cnt_4c_Dados.lbl_4c_Status
            .Top       = 8
            .Left      = 129
            .Width     = 321
            .Height    = 16
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .FontBold  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Caption   = ""
            .Alignment = 0
        ENDWITH
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna controles do container visiveis
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        IF VARTYPE(par_oContainer) # "O"
            RETURN
        ENDIF
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                loc_oControl.Visible = .T.
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Vincula Click dos botoes aos handlers
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,  "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna estado operacional do form
    * OPERACIONAL sem PageFrame: alterna entre IDLE e PROCESSANDO ajustando
    * enable dos botoes, flag interna e mensagem de status.
    *   par_cEstado: "PROCESSANDO" | "AGUARDANDO" | "IDLE"
    *==========================================================================
    PROTECTED PROCEDURE AlternarPagina(par_cEstado)
        LOCAL loc_cEstado
        loc_cEstado = UPPER(ALLTRIM(par_cEstado))

        DO CASE
            CASE loc_cEstado = "PROCESSANDO"
                THIS.cmd_4c_Processar.Enabled = .F.
                THIS.cmd_4c_Encerrar.Enabled  = .F.
                THIS.this_lProcessando        = .T.

            CASE loc_cEstado = "AGUARDANDO"
                *-- Entre ciclos de scan: usuario pode interromper com ESC
                THIS.cmd_4c_Processar.Enabled = .F.
                THIS.cmd_4c_Encerrar.Enabled  = .T.
                THIS.this_lProcessando        = .T.

            CASE loc_cEstado = "IDLE"
                THIS.cmd_4c_Processar.Enabled = .T.
                THIS.cmd_4c_Encerrar.Enabled  = .T.
                THIS.this_lProcessando        = .F.
                THIS.cnt_4c_Dados.lbl_4c_Status.Caption    = ""
        ENDCASE

        THIS.Refresh()
    ENDPROC

    *==========================================================================
    * Activate - Se acionado via Fortyus.Exe, inicia processamento automatico
    *==========================================================================
    PROCEDURE Activate()
        DODEFAULT()
        IF THIS.this_lParametrizado
            THIS.CmdProcessarClick()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdProcessarClick - Loop principal de recalculo de custos de produto
    * Replica SIGPRRCU.OK.Click:
    *   1. Busca produtos na fila SigOpClC
    *   2. Para cada item: marca em processamento (UPDATE), chama fRecalculaC (x2)
    *   3. Remove da fila (DELETE) e confirma (COMMIT)
    *   4. Repete continuamente ate ESC ou erro de conexao
    *==========================================================================
    PROCEDURE CmdProcessarClick()
        LOCAL loc_lOk, loc_lErroConexao, loc_nMov, loc_cCidChave, loc_nErro, loc_nKey

        THIS.AlternarPagina("PROCESSANDO")
        loc_lErroConexao = .F.
        loc_nMov         = 1

        SET CURSOR OFF

        DO WHILE .T.
            THIS.cmd_4c_Encerrar.Enabled = .F.

            THIS.cnt_4c_Dados.lbl_4c_Status.Caption = "Aguardando Produtos Para Processar" + REPLICATE(".", loc_nMov)
            THIS.Refresh()
            loc_nMov = IIF(loc_nMov < 5, loc_nMov + 1, 1)

            *-- Busca proximos itens da fila SigOpClC
            loc_lOk = THIS.this_oBusinessObject.BuscarProdutosPendentes(gnConnHandle)

            IF !loc_lOk
                loc_lErroConexao = .T.
            ELSE
                SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                SELECT CrSigOpClC

                SCAN
                    loc_cCidChave = TratarNulo(CrSigOpClC.CidChaves, "C")

                    *-- Marca item em processamento (lock transacional via UPDATE Usuars)
                    loc_nErro = THIS.this_oBusinessObject.MarcarEmProcessamento(gnConnHandle, loc_cCidChave)
                    loc_lOk   = (loc_nErro > 0)

                    IF !loc_lOk
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        IF loc_nErro < 0
                            loc_lErroConexao = .T.
                            EXIT
                        ENDIF
                        LOOP
                    ENDIF

                    IF USED("TmpCustPro")
                        USE IN TmpCustPro
                    ENDIF

                    *-- 1a chamada fRecalculaC: recalcula custo do produto na data
                    loc_lOk = THIS.this_oBusinessObject.ExecutarRecalculo( ;
                                  TratarNulo(CrSigOpClC.Emps,  "C"), ;
                                  TratarNulo(CrSigOpClC.Cpros, "C"), ;
                                  TratarNulo(CrSigOpClC.Datas, "D"))

                    IF !loc_lOk
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        LOOP
                    ENDIF

                    *-- 2a chamada fRecalculaC: confirma calculo com handle de transacao
                    loc_lOk = THIS.this_oBusinessObject.ExecutarRecalculoFinal(gnConnHandle)

                    IF !loc_lOk
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        LOOP
                    ENDIF

                    *-- Remove item processado da fila
                    loc_lOk = THIS.this_oBusinessObject.RemoverDaFila(gnConnHandle, loc_cCidChave)

                    IF !loc_lOk
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        LOOP
                    ENDIF

                    loc_lOk = (SQLEXEC(gnConnHandle, "COMMIT") > 0)
                    IF !loc_lOk
                        SQLEXEC(gnConnHandle, "ROLLBACK")
                        LOOP
                    ENDIF
                    SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

                ENDSCAN
            ENDIF

            SQLEXEC(gnConnHandle, "ROLLBACK")
            THIS.AlternarPagina("AGUARDANDO")

            *-- Aguarda 0.5s por tecla ou mouse; ESC (27) encerra o loop
            loc_nKey = INKEY(0.5, "M")

            IF !THIS.this_lParametrizado OR loc_nKey = 27 OR loc_lErroConexao
                EXIT
            ENDIF
        ENDDO

        SET CURSOR ON

        THIS.AlternarPagina("IDLE")

        IF THIS.this_lParametrizado
            THIS.this_oBusinessObject.ConcluirLog()
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * CmdEncerrarClick - Fecha o formulario (apenas se nao estiver processando)
    *==========================================================================
    PROCEDURE CmdEncerrarClick()
        IF !THIS.this_lProcessando
            THIS.Release()
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Libera Business Object
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Handlers CRUD (BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick)
    * ----------------------------------------------------------------------------
    * Form OPERACIONAL de processamento batch (Rec" + CHR(225) + "lculo de Custos):
    * o legado SIGPRRCU.SCX possui apenas 2 bot" + CHR(245) + "es (OK/Processar e SAIR).
    * As opera" + CHR(231) + CHR(245) + "es CRUD n" + CHR(227) + "o s" + CHR(227) + "o aplic" + CHR(225) + "veis. O gerenciamento de
    * produtos, custos e movimenta" + CHR(231) + CHR(245) + "es de estoque " + CHR(233) + " feito em cadastros
    * espec" + CHR(237) + "ficos (FormSigPrPro/FormSigPrCad/FormSigCstMov).
    * Handlers presentes apenas para conformidade com o contrato do FormBase.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        MsgAviso("Este " + CHR(233) + " um formul" + CHR(225) + "rio de processamento em lote." + CHR(13) + ;
                 "Para incluir produtos na fila de rec" + CHR(225) + "lculo, utilize os" + CHR(13) + ;
                 "cadastros de produto ou opera" + CHR(231) + CHR(245) + "es de estoque.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    PROCEDURE BtnAlterarClick()
        MsgAviso("Este " + CHR(233) + " um formul" + CHR(225) + "rio de processamento em lote." + CHR(13) + ;
                 "Altera" + CHR(231) + CHR(245) + "es em produtos ou custos devem ser feitas" + CHR(13) + ;
                 "nos cadastros espec" + CHR(237) + "ficos.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    PROCEDURE BtnVisualizarClick()
        MsgAviso("Este " + CHR(233) + " um formul" + CHR(225) + "rio de processamento em lote." + CHR(13) + ;
                 "Para consultar produtos processados, acesse o" + CHR(13) + ;
                 "cadastro de produtos ou hist" + CHR(243) + "rico de custos.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    PROCEDURE BtnExcluirClick()
        MsgAviso("Este " + CHR(233) + " um formul" + CHR(225) + "rio de processamento em lote." + CHR(13) + ;
                 "Itens da fila SigOpClC s" + CHR(227) + "o removidos automaticamente" + CHR(13) + ;
                 "ap" + CHR(243) + "s o rec" + CHR(225) + "lculo bem-sucedido de cada produto.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Nao aplicavel para form OPERACIONAL
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        MsgAviso("Este " + CHR(233) + " um formul" + CHR(225) + "rio de processamento em lote." + CHR(13) + ;
                 "A localiza" + CHR(231) + CHR(227) + "o de produtos " + CHR(233) + " feita automaticamente" + CHR(13) + ;
                 "durante o ciclo de recalculo de custos.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Delega ao handler canonico CmdEncerrarClick
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Nao aplicavel para form OPERACIONAL
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        MsgAviso("Este " + CHR(233) + " um formul" + CHR(225) + "rio de processamento em lote." + CHR(13) + ;
                 "O registro dos resultados ocorre automaticamente" + CHR(13) + ;
                 "ao concluir o recalculo de cada produto.", ;
                 "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o dispon" + CHR(237) + "vel")
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Delega ao handler CmdEncerrarClick
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * FormParaBO - Sincroniza estado do form com o BO
    * OPERACIONAL: sem campos editaveis; replica apenas flags de controle
    *==========================================================================
    PROCEDURE FormParaBO()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado
                THIS.this_oBusinessObject.this_lProcessando   = THIS.this_lProcessando
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Sincroniza estado do BO com o form
    * OPERACIONAL: sem campos editaveis; captura mensagem de erro se houver
    *==========================================================================
    PROCEDURE BOParaForm()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    THIS.this_cMensagemErro = THIS.this_oBusinessObject.this_cMensagemErro
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita/desabilita botoes conforme modo de operacao
    * OPERACIONAL: gerencia Processar e Encerrar conforme estado do loop
    *==========================================================================
    PROCEDURE HabilitarCampos(par_cModo)
        LOCAL loc_cModo
        loc_cModo = UPPER(ALLTRIM(IIF(TYPE("par_cModo") = "C", par_cModo, "IDLE")))

        DO CASE
            CASE loc_cModo = "PROCESSANDO"
                THIS.cmd_4c_Processar.Enabled = .F.
                THIS.cmd_4c_Encerrar.Enabled  = .F.

            CASE loc_cModo = "AGUARDANDO"
                THIS.cmd_4c_Processar.Enabled = .F.
                THIS.cmd_4c_Encerrar.Enabled  = .T.

            OTHERWISE
                THIS.cmd_4c_Processar.Enabled = .T.
                THIS.cmd_4c_Encerrar.Enabled  = .T.
        ENDCASE
    ENDPROC

    *==========================================================================
    * LimparCampos - Limpa mensagem de status e reseta estado interno
    * OPERACIONAL: sem campos de dados editaveis
    *==========================================================================
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.cnt_4c_Dados) = "O"
            IF VARTYPE(THIS.cnt_4c_Dados.lbl_4c_Status) = "O"
                THIS.cnt_4c_Dados.lbl_4c_Status.Caption = ""
            ENDIF
        ENDIF
        THIS.this_lProcessando  = .F.
        THIS.this_cMensagemErro = ""
    ENDPROC

    *==========================================================================
    * CarregarLista - Nao aplicavel para form OPERACIONAL (sem grid de lista)
    * Implementado apenas para conformidade com o contrato do FormBase
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
    * OPERACIONAL: delega a HabilitarCampos com base na flag this_lProcessando
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_cModo
        IF THIS.this_lProcessando
            loc_cModo = "PROCESSANDO"
        ELSE
            loc_cModo = "IDLE"
        ENDIF
        THIS.HabilitarCampos(loc_cModo)
    ENDPROC

ENDDEFINE
