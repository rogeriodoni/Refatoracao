*==============================================================================
* sigpremaBO.prg - Business Object: Processamento e Geracao de Email
* Herda de: BusinessBase
* Form: Formsigprema.prg (OPERACIONAL)
*==============================================================================

DEFINE CLASS sigpremaBO AS BusinessBase

    *-- Parametros de entrada do processo
    this_cEmpDopNums = ""    && Identificador completo do movimento (Emps+Dopes+Numes C29)
    this_cEmps       = ""    && Codigo da empresa (3 chars)
    this_cDopes      = ""    && Tipo de operacao (chars 4-23)
    this_nNumes      = 0     && Numero do movimento (chars 24-29)
    this_lAutomatico = .F.   && Modo automatico: processa e encerra sem interacao

    *-- Estado do processo de email
    this_cArqEmail   = ""    && Caminho do arquivo PDF gerado para anexo
    this_cEscolha    = ""    && Escolha de operacao retornada pelo ImpDocto

    *-- Configuracoes de email extraidas de SigCdEmp
    this_cPadEmails  = ""    && Email remetente (PadEmails)
    this_cPadServs   = ""    && Servidor SMTP (PadServs)
    this_cPadSenhas  = ""    && Senha SMTP (PadSenhas)
    this_nPadPortas  = 0     && Porta SMTP (PadPortas)

    *-- Estado da disponibilidade do PDFCreator
    this_lEmailAtivo = .F.   && .T. se PDFCreator esta registrado no sistema

    *-- Propriedades da linha do cursor (para CarregarDoCursor)
    this_cContas     = ""    && Codigo da conta/cliente (Iclis)
    this_cRclis      = ""    && Nome do cliente/conta (Rclis)
    this_cEmails     = ""    && Endereco de email
    this_cGrupos     = ""    && Grupo do cliente
    this_cMensagems  = ""    && Corpo da mensagem
    this_cPrioridade = ""    && Prioridade (NORMAL/etc)
    this_nChecks     = 0     && Flag de selecao para envio (0=nao, 1=sim)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nChecks     = TratarNulo(Checks, "N")
            THIS.this_cGrupos     = TratarNulo(grupos, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cRclis      = TratarNulo(Rclis, "C")
            THIS.this_cEmails     = TratarNulo(emails, "C")
            THIS.this_cMensagems  = TratarNulo(mensagems, "C")
            THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
            THIS.this_cPrioridade = TratarNulo(prioridade, "C")
            THIS.this_cEmps       = SUBSTR(THIS.this_cEmpDopNums, 1, 3)
            THIS.this_cDopes      = SUBSTR(THIS.this_cEmpDopNums, 4, 20)
            THIS.this_nNumes      = VAL(SUBSTR(THIS.this_cEmpDopNums, 24, 6))
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarListaEmail - Carrega cursor_4c_Local com movimentos para envio
    * par_cDopes: EmpDopNums do movimento especifico (vazio = todos do dia)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarListaEmail(par_cDopes)
        LOCAL loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Local")
                USE IN cursor_4c_Local
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Local (;
                Checks     N(1)    NULL,;
                grupos     C(10)   NULL,;
                Contas     C(10)   NULL,;
                Rclis      C(30)   NULL,;
                emails     C(50)   NULL,;
                mensagems  M,;
                EmpDopNums C(29)   NULL,;
                prioridade C(15)   NULL;
            )
            SET NULL OFF
            INDEX ON Contas     TAG Contas
            INDEX ON Rclis      TAG Rclis
            INDEX ON emails     TAG Emails

            *-- Carrega movimentos: especifico ou todos do dia sem log
            IF EMPTY(par_cDopes)
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, " + ;
                             "b.Rclis, b.Rclis AS Rclis2, b.emails, b.grupos, b.iclis " + ;
                             "FROM SigMvCab a " + ;
                             "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                             "WHERE CONVERT(date, a.datatrans) = CONVERT(date, GETDATE()) " + ;
                             "AND a.EmpDopNums NOT IN (" + ;
                             "  SELECT transacaos FROM SigOpLog WHERE progs = 'SIGPREMA'" + ;
                             ") " + ;
                             "ORDER BY a.EmpDopNums"
            ELSE
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, " + ;
                             "b.Rclis, b.Rclis AS Rclis2, b.emails, b.grupos, b.iclis " + ;
                             "FROM SigMvCab a " + ;
                             "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                             "WHERE a.EmpDopNums = " + EscaparSQL(par_cDopes)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_MvTemp") < 1
                MsgErro("Falha ao carregar movimentos para email.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_MvTemp
            SCAN
                INSERT INTO cursor_4c_Local ;
                    (Checks, grupos, Contas, Rclis, emails, prioridade, EmpDopNums) ;
                    VALUES (cursor_4c_MvTemp.Checks, cursor_4c_MvTemp.grupos, ;
                            cursor_4c_MvTemp.iclis, cursor_4c_MvTemp.Rclis, ;
                            cursor_4c_MvTemp.emails, "NORMAL", cursor_4c_MvTemp.EmpDopNums)
            ENDSCAN
            IF USED("cursor_4c_MvTemp")
                USE IN cursor_4c_MvTemp
            ENDIF

            *-- Carrega clientes do grupo PAM (SigCdPam)
            loc_cQuery = "SELECT 0 AS Checks, c.grupos, c.iclis AS Contas, " + ;
                         "c.rclis, c.emails, '' AS prioridade " + ;
                         "FROM SigCdPam p " + ;
                         "INNER JOIN SigCdCli c ON c.grupos = p.grpadats"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_PamTemp") >= 1
                SELECT cursor_4c_PamTemp
                SCAN
                    LOCAL loc_cJobQuery, loc_cContasPam, loc_cRclisPam, loc_cEmailsPam
                    loc_cContasPam = cursor_4c_PamTemp.Contas
                    loc_cRclisPam  = cursor_4c_PamTemp.Rclis
                    loc_cEmailsPam = cursor_4c_PamTemp.emails

                    *-- Verifica se cliente tem job associado ao movimento
                    loc_cJobQuery = "SELECT Jobs FROM SigClJob WHERE Iclis = " + ;
                                   EscaparSQL(loc_cContasPam)
                    IF SQLEXEC(gnConnHandle, loc_cJobQuery, "cursor_4c_JobTemp") >= 1
                        SELECT cursor_4c_JobTemp
                        GO TOP
                        IF !EOF()
                            *-- Insere apenas se nao existe ja no cursor
                            SELECT cursor_4c_Local
                            LOCATE FOR ALLTRIM(cursor_4c_Local.Contas) = ALLTRIM(loc_cContasPam) ;
                                    AND ALLTRIM(cursor_4c_Local.Rclis)  = ALLTRIM(loc_cRclisPam)
                            IF EOF()
                                INSERT INTO cursor_4c_Local ;
                                    (Checks, grupos, Contas, Rclis, emails, EmpDopNums, prioridade) ;
                                    VALUES (0, "", loc_cContasPam, loc_cRclisPam, ;
                                            loc_cEmailsPam, par_cDopes, "NORMAL")
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_JobTemp")
                            USE IN cursor_4c_JobTemp
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_PamTemp
                ENDSCAN
                IF USED("cursor_4c_PamTemp")
                    USE IN cursor_4c_PamTemp
                ENDIF
            ENDIF

            SELECT cursor_4c_Local
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao carregar lista de email")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConfigEmail - Carrega configuracoes SMTP de sigcdemp para this_*
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConfigEmail()
        LOCAL loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.

        TRY
            loc_cQuery = "SELECT pademails, padservs, padsenhas, padportas " + ;
                         "FROM sigcdemp WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_EmpEmail") >= 1
                SELECT cursor_4c_EmpEmail
                GO TOP
                IF !EOF()
                    THIS.this_cPadEmails = ALLTRIM(NVL(pademails, ""))
                    THIS.this_cPadServs  = ALLTRIM(NVL(padservs, ""))
                    THIS.this_cPadSenhas = ALLTRIM(NVL(padsenhas, ""))
                    THIS.this_nPadPortas = NVL(padportas, 0)
                    loc_lSucesso = .T.
                ENDIF
                IF USED("cursor_4c_EmpEmail")
                    USE IN cursor_4c_EmpEmail
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de email")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra envio de email no log de operacoes (SigOpLog)
    * Chamado apos cada email enviado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cEmpDopNums))
                MsgAviso("Identifica" + CHR(231) + CHR(227) + "o do movimento n" + ;
                         CHR(227) + "o informada.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "INSERT INTO SigOpLog " + ;
                       "(usuaredes, datars, horas, progs, opers, usuasis, " + ;
                       " parametros, transacaos, cversaos, cidchaves, copias) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                       "'SIGPREMA', 'T', " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "'', " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpDopNums)) + ", " + ;
                       "'', '', 0)"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao registrar log de envio de email.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao registrar email")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para este form operacional
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do movimento atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Operacao, Tabela, ChaveRegistro, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       "'SigMvCab', " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
