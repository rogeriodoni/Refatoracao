*==============================================================================
* Formsigprsen.prg - Form Operacional: Gerar e Enviar Senha do Dia
* Herda de: FormBase
* Tipo: OPERACIONAL - utilitario de geracao e envio de senha diaria por e-mail
* SCX Origem: sigprsen.SCX
*==============================================================================
DEFINE CLASS Formsigprsen AS FormBase

    *-- Dimensoes pixel-perfect do SCX original (PILAR 1)
    Width       = 500
    Height      = 119
    Caption     = "4Control"
    AutoCenter  = .T.
    ShowTips    = .T.
    ShowWindow = 1
    WindowType = 1
    ControlBox  = .F.
    Closable    = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    ClipControls = .F.
    DataSession = 2

    *-- Estado operacional
    this_lAutomatico = .F.

    *--------------------------------------------------------------------------
    * Init - Inicializa form recebendo flag de execucao automatica
    * par_lAutomatico: .T. = execucao headless (sem dialogs, fecha sozinho)
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_lAutomatico)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        THIS.this_lAutomatico = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)

        loc_lResultado = DODEFAULT()

        IF loc_lResultado AND THIS.this_lAutomatico
            THIS.CmdGerarSenhaClick()
            THIS.Release()
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria BO, aplica background e monta controles
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigprsenBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
                THIS.ConfigurarPageFrame()
                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
                THIS.TornarControlesVisiveis(THIS)
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao criar sigprsenBO. VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Entry point de layout do form OPERACIONAL
    * Este form nao usa PageFrame (dialog 500x119 com controles diretos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarPaginaLista()
        THIS.ConfigurarPaginaDados()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Monta a view principal do form (unica "pagina")
    * Neste form operacional minimalista a "lista" e o proprio painel de acao:
    * cabecalho escuro com titulo + botoes Gerar Senha e Encerrar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoes()
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Garante estado visual correto dos controles de acao
    * par_nPagina ignorado: form de pagina unica sem PageFrame.
    * Chamado pelo pipeline para homogeneidade entre forms OPERACIONAIS.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF VARTYPE(THIS.cmd_4c_GerarSenha) = "O" AND ;
           VARTYPE(THIS.cmd_4c_Encerrar)   = "O"
            THIS.cmd_4c_GerarSenha.Visible = .T.
            THIS.cmd_4c_Encerrar.Visible   = .T.
            THIS.cmd_4c_GerarSenha.Enabled = !THIS.this_lAutomatico
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCab

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
        ENDWITH
        loc_oCab = THIS.cnt_4c_Cabecalho

        loc_oCab.AddObject("lbl_4c_Sombra", "Label")
        WITH loc_oCab.lbl_4c_Sombra
            .Top       = 18
            .Left      = 10
            .Width     = loc_oCab.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .ForeColor = RGB(0, 0, 0)
            .Caption   = THIS.Caption
        ENDWITH

        loc_oCab.AddObject("lbl_4c_Titulo", "Label")
        WITH loc_oCab.lbl_4c_Titulo
            .Top       = 17
            .Left      = 10
            .Width     = loc_oCab.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 18
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - Botoes de acao standalone (Gerar Senha, Encerrar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        *-- Botao Gerar Senha (replica btnGerSen, posicao original Top=4 Left=348)
        THIS.AddObject("cmd_4c_GerarSenha", "CommandButton")
        WITH THIS.cmd_4c_GerarSenha
            .Top             = 4
            .Left            = 348
            .Width           = 75
            .Height          = 75
            .Caption         = "Gerar Senha"
            .Picture         = gc_4c_CaminhoIcones + "geral_chaves_60.jpg"
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .TabIndex        = 1
        ENDWITH

        *-- Botao Encerrar (replica Saida, posicao original Top=4 Left=423)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top             = 4
            .Left            = 423
            .Width           = 75
            .Height          = 75
            .Caption         = "Encerrar"
            .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel          = .T.
            .FontName        = "Tahoma"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes           = .T.
            .SpecialEffect   = 0
            .PicturePosition = 13
            .MousePointer    = 15
            .WordWrap        = .T.
            .AutoSize        = .F.
            .TabIndex        = 2
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna todos os controles visiveis apos AddObject
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl, loc_p

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)

            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    FOR loc_p = 1 TO loc_oControl.PageCount
                        THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Wiring de eventos (form sem campos de dados)
    * Este form operacional nao possui Page2 nem TextBoxes ? toda a interacao
    * ocorre via 2 botoes. Esta fase conecta os handlers via BINDEVENT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        IF VARTYPE(THIS.cmd_4c_GerarSenha) = "O"
            BINDEVENT(THIS.cmd_4c_GerarSenha, "Click", THIS, "CmdGerarSenhaClick")
        ENDIF
        IF VARTYPE(THIS.cmd_4c_Encerrar) = "O"
            BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdGerarSenhaClick - Delega processamento completo ao BO
    * Chamado diretamente em Init() quando this_lAutomatico = .T.
    * Chamado via BINDEVENT no evento Click de cmd_4c_GerarSenha.
    *--------------------------------------------------------------------------
    PROCEDURE CmdGerarSenhaClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = THIS.this_oBusinessObject.Processar(THIS.this_lAutomatico)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gerar senha")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CmdEncerrarClick - Fecha o form
    * Chamado via BINDEVENT no evento Click de cmd_4c_Encerrar.
    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Gera e envia nova senha do dia
    * Para este form OPERACIONAL, "Incluir" corresponde a gerar uma nova senha,
    * enviar por e-mail e registrar o evento (operacao GERAR) em LogAuditoria.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = THIS.this_oBusinessObject.Processar(THIS.this_lAutomatico)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao gerar senha")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Regera e reenvia a senha do dia
    * Para forms OPERACIONAIS sem tabela de negocio, "Alterar" equivale a
    * reprocessar a senha do dia e registrar o evento (operacao REGERAR).
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_lSucesso, loc_lConfirmado, loc_oBO, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_oBO = THIS.this_oBusinessObject
                loc_lConfirmado = .T.

                IF !THIS.this_lAutomatico
                    loc_lConfirmado = MsgConfirma("Deseja reenviar a senha do dia?")
                ENDIF

                IF loc_lConfirmado
                    IF loc_oBO.GerarSenha()
                        IF loc_oBO.EnviarEmail(loc_oBO.this_cSenha)
                            loc_oBO.Atualizar()
                            loc_lSucesso = .T.

                            IF !THIS.this_lAutomatico
                                MsgInfo("Senha reenviada com sucesso." + CHR(13) + ;
                                        "Senha: " + loc_oBO.this_cSenha)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao reenviar senha")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe a senha corrente ja gerada nesta sessao
    * Para forms OPERACIONAIS sem tabela, "Visualizar" mostra o estado atual
    * do processamento (senha gerada) ou avisa que ainda nao foi gerada.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_lSucesso, loc_cSenha, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_cSenha = THIS.this_oBusinessObject.this_cSenha

                IF EMPTY(loc_cSenha)
                    IF !THIS.this_lAutomatico
                        MsgAviso("Senha do dia ainda n" + CHR(227) + "o foi gerada." + ;
                                CHR(13) + "Clique em 'Gerar Senha' para gerar e enviar.")
                    ENDIF
                    loc_lSucesso = .F.
                ELSE
                    IF !THIS.this_lAutomatico
                        MsgInfo("Senha do Dia:" + CHR(13) + CHR(13) + ;
                                ALLTRIM(loc_cSenha) + CHR(13) + CHR(13) + ;
                                "Data: " + DTOC(DATE()))
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao visualizar senha")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Descarta a senha corrente da sessao
    * Para forms OPERACIONAIS sem tabela de negocio persistida, "Excluir" limpa
    * o estado da senha em memoria. Nao remove registros da LogAuditoria (essa
    * e mantida por politica de retencao de eventos).
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_lSucesso, loc_lConfirmado, loc_oBO, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Business Object n" + CHR(227) + "o inicializado.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_oBO = THIS.this_oBusinessObject

                IF EMPTY(loc_oBO.this_cSenha)
                    IF !THIS.this_lAutomatico
                        MsgAviso("Nenhuma senha gerada nesta sess" + CHR(227) + "o.")
                    ENDIF
                    loc_lSucesso = .F.
                ELSE
                    loc_lConfirmado = .T.
                    IF !THIS.this_lAutomatico
                        loc_lConfirmado = MsgConfirma("Descartar a senha gerada nesta sess" + ;
                                                     CHR(227) + "o?")
                    ENDIF

                    IF loc_lConfirmado
                        loc_oBO.this_cSenha = ""
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro ao descartar senha")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Form operacional sem grid; garante estado visual correto
    * Chamado pelo pipeline para homogeneidade entre forms OPERACIONAIS.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.AlternarPagina(1)
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarLista")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado visual dos botoes conforme modo atual
    * Form OPERACIONAL: Gerar Senha habilitado exceto quando this_lAutomatico=.T.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF VARTYPE(THIS.cmd_4c_GerarSenha) = "O"
            THIS.cmd_4c_GerarSenha.Enabled = !THIS.this_lAutomatico
        ENDIF

        IF VARTYPE(THIS.cmd_4c_Encerrar) = "O"
            THIS.cmd_4c_Encerrar.Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Sincroniza estado do form para o BO
    * Sincroniza apenas this_lAutomatico (form sem campos de entrada).
    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_lAutomatico = THIS.this_lAutomatico
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Sincroniza estado do BO para o form
    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_lAutomatico = THIS.this_oBusinessObject.this_lAutomatico
            THIS.AjustarBotoesPorModo()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles
    * par_lHabilitar: .T. = habilitar, .F. = desabilitar
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(THIS.cmd_4c_GerarSenha) = "O"
            THIS.cmd_4c_GerarSenha.Enabled = par_lHabilitar AND !THIS.this_lAutomatico
        ENDIF

        IF VARTYPE(THIS.cmd_4c_Encerrar) = "O"
            THIS.cmd_4c_Encerrar.Enabled = par_lHabilitar
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Descarta a senha gerada na sessao corrente
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cSenha = ""
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnBuscarClick - No contexto OPERACIONAL equivale a processar senha
    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
        THIS.CmdGerarSenhaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o form
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Confirma processamento (alias de Processar)
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        THIS.CmdGerarSenhaClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela e fecha o form
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera BO e delega ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
