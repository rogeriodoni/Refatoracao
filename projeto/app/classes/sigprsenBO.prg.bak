*==============================================================================
* sigprsenBO.prg - Business Object para Senha do Dia
* Herda de: BusinessBase
* Tipo: OPERACIONAL - geracao de senha diaria e envio de e-mail
*==============================================================================
DEFINE CLASS sigprsenBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela      = ""
    this_cCampoChave  = ""

    *-- Estado operacional
    this_lAutomatico  = .F.
    this_cSenha       = ""

    *-- Configuracao SMTP (espelhando valores do legado)
    this_cSmtpServer      = "mail.4control.com.br"
    this_nSmtpPort        = 25
    this_cSmtpUser        = "errormail@4control.com.br"
    this_cSmtpSenha       = "PswError2@"
    this_cEmailDe         = "desenvolvimento@4control.com.br"
    this_cEmailPara       = "config4c@4control.com.br"

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarSenha - Gera a senha do dia usando algoritmo proprietario 4Control
    * Retorno: .T. se a senha foi gerada com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE GerarSenha()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cSenha = fGerPswDiario(VAL(SYS(1)), DATE(), 0)
            loc_lSucesso = !EMPTY(THIS.this_cSenha)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gerar senha")
            THIS.this_cSenha = ""
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmail - Envia a senha do dia por e-mail via CDO
    * par_cSenha: senha a ser enviada
    * Retorno: .T. se enviado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmail(par_cSenha)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSch, loc_oObs, loc_oMsg, loc_cCabecalho
        loc_lSucesso = .F.

        loc_cSch       = "http://schemas.microsoft.com/cdo/configuration/"
        loc_cCabecalho = "Senha do Dia : " + par_cSenha

        TRY
            loc_oObs = CREATEOBJECT("CDO.Configuration")

            WITH loc_oObs.Fields
                .Item(loc_cSch + "smtpserver")            = THIS.this_cSmtpServer
                .Item(loc_cSch + "smtpserverport")        = THIS.this_nSmtpPort
                .Item(loc_cSch + "sendusing")             = 2
                .Item(loc_cSch + "smtpauthenticate")      = 1
                .Item(loc_cSch + "smtpusessl")            = .F.
                .Item(loc_cSch + "sendusername")          = THIS.this_cSmtpUser
                .Item(loc_cSch + "sendpassword")          = THIS.this_cSmtpSenha
                .Item(loc_cSch + "smtpconnectiontimeout") = 60
                .Update
            ENDWITH

            loc_oMsg = CREATEOBJECT("CDO.Message")

            WITH loc_oMsg
                .Configuration         = loc_oObs
                .From                  = THIS.this_cEmailDe
                .To                    = THIS.this_cEmailPara
                .Subject               = loc_cCabecalho
                .AutoGenerateTextBody  = .F.
                =INKEY(1, "MH")
                .Send()
            ENDWITH

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            IF !THIS.this_lAutomatico
                MsgErro("Erro: " + TRANSFORM(loc_oErro.ErrorNo) + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                        "Mensagem: " + loc_oErro.Message, "Aviso")
            ENDIF
            loc_lSucesso = .F.
        FINALLY
            loc_oObs = .NULL.
            loc_oMsg = .NULL.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Fluxo completo: confirmacao + geracao de senha + envio por e-mail
    * par_lAutomatico: .T. = execucao automatica (sem dialogs)
    * Retorno: .T. se processamento concluido com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_lAutomatico)
        LOCAL loc_lSucesso, loc_oErro, loc_lConfirmado
        loc_lSucesso   = .F.
        loc_lConfirmado = .T.

        THIS.this_lAutomatico = par_lAutomatico

        TRY
            IF !THIS.this_lAutomatico
                loc_lConfirmado = MsgConfirma("Deseja realmente gerar a senha?")
            ENDIF

            IF loc_lConfirmado
                IF THIS.GerarSenha()
                    IF !THIS.this_lAutomatico
                        MsgInfo("Favor Anotar a Senha :" + CHR(13) + CHR(13) + ;
                                THIS.this_cSenha + CHR(13) + CHR(13))
                    ENDIF

                    IF THIS.EnviarEmail(THIS.this_cSenha)
                        THIS.Inserir()
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do registro operacional
    * A senha do dia e identificada pela data de geracao (YYYYMMDD)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN DTOS(DATE())
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega estado operacional a partir de um cursor
    * Para SIGPRSEN nao existe tabela persistida; o cursor opcional pode
    * conter a senha gerada por outro processo (par_cAliasCursor com campo Senha).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE(par_cAliasCursor + ".Senha") != "U"
                    THIS.this_cSenha = TratarNulo(Senha, "C")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar cursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra a geracao da senha do dia na auditoria
    * Como esta e uma operacao sem tabela de negocio, o "Inserir" corresponde
    * ao registro do evento de geracao em LogAuditoria via RegistrarAuditoria.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cSenha)
                THIS.this_cMensagemErro = "Senha n" + CHR(227) + "o gerada"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("GERAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao registrar auditoria")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa a geracao da senha do dia
    * Para forms operacionais sem tabela, atualizar e equivalente a executar
    * novamente o Processar e registrar o evento na auditoria.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cSenha)
                THIS.this_cMensagemErro = "Senha n" + CHR(227) + "o gerada"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("REGERAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao registrar auditoria")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Grava evento de geracao/reenvio em LogAuditoria
    * par_cOperacao: "GERAR" (primeira geracao do dia) ou "REGERAR" (reenvio)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario, loc_cChave
        loc_lSucesso = .F.

        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria" + ;
                       " (Tabela, Operacao, ChaveRegistro, Usuario, DataHora, DadosNovos)" + ;
                       " VALUES (" + ;
                       EscaparSQL("SIGPRSEN") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("Senha do Dia gerada e enviada por e-mail") + ;
                       ")"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao registrar auditoria")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
