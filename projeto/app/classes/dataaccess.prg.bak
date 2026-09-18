*==============================================================================
* DATAACCESS.PRG
* Classe base para acesso a dados SQL Server
* Responsabilidade: executar queries, gerenciar cursores e transacoes
*==============================================================================

DEFINE CLASS DataAccess AS Custom

    *-- Propriedades (nomenclatura: this_ + tipo)
    this_cTabela = ""           && Nome da tabela principal
    this_cCursorName = ""       && Nome do cursor de trabalho
    this_lEmTransacao = .F.     && Indica se esta em transacao
    this_nUltimoErro = 0        && Codigo do ultimo erro SQL
    this_cMensagemErro = ""     && Mensagem do ultimo erro

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init(pcTabela)
        IF VARTYPE(pcTabela) = "C" AND !EMPTY(pcTabela)
            THIS.this_cTabela = ALLTRIM(pcTabela)
            THIS.this_cCursorName = "cur" + THIS.this_cTabela
        ENDIF

        * Limpa erros anteriores
        THIS.LimparErro()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarQuery - Executa uma query SQL e retorna resultado em cursor
    * Parametros:
    *   pcSQL: string com comando SQL
    *   pcCursorDestino: nome do cursor (opcional, usa padrao se nao informado)
    * Retorno: .T. se sucesso, .F. se erro
    *--------------------------------------------------------------------------
    PROCEDURE ExecutarQuery(pcSQL, pcCursorDestino)
        LOCAL lnResultado, lcCursor, llSucesso

        llSucesso = .F.

        * Valida conexao
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.RegistrarErro(-1, "Conex" + CHR(227) + "o com banco de dados n" + CHR(227) + "o estabelecida")
            RETURN llSucesso
        ENDIF

        * Define nome do cursor
        lcCursor = IIF(VARTYPE(pcCursorDestino) = "C" AND !EMPTY(pcCursorDestino), ;
                       ALLTRIM(pcCursorDestino), ;
                       THIS.this_cCursorName)

        * Limpa erros anteriores
        THIS.LimparErro()

        TRY
            * Executa query
            lnResultado = SQLEXEC(gnConnHandle, pcSQL, lcCursor)

            IF lnResultado < 0
                * Captura erro do SQL Server
                THIS.RegistrarErro(lnResultado, "Erro ao executar query SQL")
                llSucesso = .F.
            ELSE
                llSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.RegistrarErro(-999, "Exce" + CHR(231) + CHR(227) + "o: " + loException.Message)
            llSucesso = .F.
        ENDTRY

        RETURN llSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarTransacao - Inicia transacao SQL
    *--------------------------------------------------------------------------
    PROCEDURE IniciarTransacao()
        LOCAL lnResultado, llSucesso

        llSucesso = .F.

        IF THIS.this_lEmTransacao
            THIS.RegistrarErro(-1, "J" + CHR(225) + " existe uma transa" + CHR(231) + CHR(227) + "o ativa")
            RETURN llSucesso
        ENDIF

        TRY
            lnResultado = SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            IF lnResultado < 0
                THIS.RegistrarErro(lnResultado, "Erro ao iniciar transa" + CHR(231) + CHR(227) + "o")
                llSucesso = .F.
            ELSE
                THIS.this_lEmTransacao = .T.
                llSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.RegistrarErro(-999, "Exce" + CHR(231) + CHR(227) + "o ao iniciar transa" + CHR(231) + CHR(227) + "o: " + loException.Message)
            llSucesso = .F.
        ENDTRY

        RETURN llSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarTransacao - Confirma (commit) transacao SQL
    *--------------------------------------------------------------------------
    PROCEDURE ConfirmarTransacao()
        LOCAL lnResultado, llSucesso

        llSucesso = .F.

        IF !THIS.this_lEmTransacao
            THIS.RegistrarErro(-1, "N" + CHR(227) + "o h" + CHR(225) + " transa" + CHR(231) + CHR(227) + "o ativa para confirmar")
            RETURN llSucesso
        ENDIF

        TRY
            lnResultado = SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")

            IF lnResultado < 0
                THIS.RegistrarErro(lnResultado, "Erro ao confirmar transa" + CHR(231) + CHR(227) + "o")
                llSucesso = .F.
            ELSE
                THIS.this_lEmTransacao = .F.
                llSucesso = .T.
            ENDIF

        CATCH TO loException
            THIS.RegistrarErro(-999, "Exce" + CHR(231) + CHR(227) + "o ao confirmar transa" + CHR(231) + CHR(227) + "o: " + loException.Message)
            llSucesso = .F.
        ENDTRY

        RETURN llSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ReverterTransacao - Reverte (rollback) transacao SQL
    *--------------------------------------------------------------------------
    PROCEDURE ReverterTransacao()
        LOCAL lnResultado, llSucesso

        llSucesso = .T.

        IF !THIS.this_lEmTransacao
            RETURN llSucesso  && Nada a reverter
        ENDIF

        TRY
            lnResultado = SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            THIS.this_lEmTransacao = .F.
            llSucesso = (lnResultado >= 0)

        CATCH TO loException
            THIS.RegistrarErro(-999, "Exce" + CHR(231) + CHR(227) + "o ao reverter transa" + CHR(231) + CHR(227) + "o: " + loException.Message)
            THIS.this_lEmTransacao = .F.
            llSucesso = .F.
        ENDTRY

        RETURN llSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Executa SELECT e retorna dados
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(pcFiltro, pcOrdenacao, pcCampos)
        LOCAL lcSQL, lcCampos, lcFiltro, lcOrdenacao

        * Define campos a buscar
        lcCampos = IIF(VARTYPE(pcCampos) = "C" AND !EMPTY(pcCampos), ;
                       ALLTRIM(pcCampos), "*")

        * Monta SQL base
        lcSQL = "SELECT " + lcCampos + " FROM " + THIS.this_cTabela

        * Adiciona filtro se fornecido
        IF VARTYPE(pcFiltro) = "C" AND !EMPTY(pcFiltro)
            lcSQL = lcSQL + " WHERE " + ALLTRIM(pcFiltro)
        ENDIF

        * Adiciona ordenacao se fornecida
        IF VARTYPE(pcOrdenacao) = "C" AND !EMPTY(pcOrdenacao)
            lcSQL = lcSQL + " ORDER BY " + ALLTRIM(pcOrdenacao)
        ENDIF

        RETURN THIS.ExecutarQuery(lcSQL)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarErro - Registra informacoes de erro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarErro(pnCodigo, pcMensagem)
        THIS.this_nUltimoErro = pnCodigo
        THIS.this_cMensagemErro = pcMensagem

        * Se for erro SQL, captura detalhes adicionais
        IF pnCodigo < 0 AND TYPE("gnConnHandle") = "N"
            LOCAL ARRAY laErro[1]
            IF AERROR(laErro) > 0
                THIS.this_cMensagemErro = THIS.this_cMensagemErro + CHR(13) + ;
                                     "Detalhes: " + laErro[2]
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparErro - Limpa registros de erro
    *--------------------------------------------------------------------------
    PROCEDURE LimparErro()
        THIS.this_nUltimoErro = 0
        THIS.this_cMensagemErro = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro formatada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        IF THIS.this_nUltimoErro = 0
            RETURN ""
        ENDIF

        RETURN "Erro " + TRANSFORM(THIS.this_nUltimoErro) + ": " + THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - Destrutor
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        * Garante que nao ha transacao pendente
        IF THIS.this_lEmTransacao
            THIS.ReverterTransacao()
        ENDIF
    ENDPROC

ENDDEFINE
