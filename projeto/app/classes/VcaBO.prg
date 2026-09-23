*==============================================================================
* VcaBO.prg - Business Object para Vinculo Cliente x Vendedor (SIGALTDT)
* Tabela Principal: SigCdVca (PK: pkchaves)
* Tabelas Relacionadas:
*   - SigCdCli (dados do cliente - rclis)
*   - SigCdUsu (dados do usuario/vendedor responsavel - ncomps, deptos)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS VcaBO AS BusinessBase

    *-- Propriedades: SigCdVca
    this_cIclis    = ""   && iclis char(10) NOT NULL - codigo do cliente (SigCdCli.Iclis)
    this_cResp     = ""   && resp char(20) NOT NULL - codigo do usuario responsavel (SigCdUsu.Usuarios)
    this_cPkChaves = ""   && pkchaves char(20) NOT NULL - PK (gerada com fUniqueIds())

    *-- Propriedades de exibicao (JOIN - nao persistidas em SigCdVca)
    this_cRclis    = ""   && SigCdCli.rclis char(50) - razao/nome do cliente
    this_cUsuario  = ""   && SigCdUsu.ncomps char(30) - nome do usuario responsavel (alias "usuario" na query legado)
    this_cDeptos   = ""   && SigCdUsu.deptos char(10) - departamento do usuario responsavel

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdVca"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * Cursor pode vir da query com JOIN (rclis/usuario/deptos presentes) ou de
    * um SELECT simples em SigCdVca (so iclis/resp/pkchaves) - por isso as
    * colunas de exibicao sao lidas com TYPE() antes de acessar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cIclis    = TratarNulo(iclis, "C")
            THIS.this_cResp     = TratarNulo(resp, "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")

            IF TYPE(par_cAliasCursor + ".rclis") != "U"
                THIS.this_cRclis = TratarNulo(rclis, "C")
            ELSE
                THIS.this_cRclis = ""
            ENDIF

            IF TYPE(par_cAliasCursor + ".usuario") != "U"
                THIS.this_cUsuario = TratarNulo(usuario, "C")
            ELSE
                THIS.this_cUsuario = ""
            ENDIF

            IF TYPE(par_cAliasCursor + ".deptos") != "U"
                THIS.this_cDeptos = TratarNulo(deptos, "C")
            ELSE
                THIS.this_cDeptos = ""
            ENDIF

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdVca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)

            loc_cSQL = "INSERT INTO SigCdVca (iclis, resp, pkchaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10)) + "," + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cResp), 20)) + "," + ;
                       EscaparSQL(THIS.this_cPkChaves) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdVca
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdVca SET" + ;
                       " iclis = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIclis), 10)) + "," + ;
                       " resp = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cResp), 20)) + ;
                       " WHERE RTRIM(pkchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar v" + CHR(237) + "nculo Cliente x Vendedor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Popula cursor_4c_Dados (READWRITE) com o JOIN do legado
    * (lcQryVca do SIGALTDT.Init): SigCdVca + SigCdCli (rclis) + SigCdUsu
    * (deptos/ncomps). A grade tem colunas editaveis (Iclis/Resp), por isso o
    * cursor precisa ser READWRITE - SQLEXEC() sozinho gera cursor read-only.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Iclis C(10), Resp C(20), PkChaves C(20), ;
                                                    Rclis C(50), Deptos C(10), Usuario C(30))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.iclis AS Iclis, a.resp AS Resp, a.pkchaves AS PkChaves," + ;
                           " c.rclis AS Rclis, b.deptos AS Deptos, b.ncomps AS Usuario" + ;
                           " FROM SigCdVca a" + ;
                           " INNER JOIN SigCdUsu b ON a.resp = b.usuarios" + ;
                           " INNER JOIN SigCdCli c ON a.iclis = c.iclis"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

                IF loc_nResultado >= 0
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF
                    SET NULL ON
                    SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                    SET NULL OFF
                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF

                    SELECT cursor_4c_Dados
                    INDEX ON Iclis   TAG Iclis   ADDITIVE
                    INDEX ON Resp    TAG Resp    ADDITIVE
                    INDEX ON Rclis   TAG Rclis   ADDITIVE
                    INDEX ON Deptos  TAG Deptos  ADDITIVE
                    INDEX ON Usuario TAG Usuario ADDITIVE
                    SET ORDER TO TAG Iclis
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar v" + CHR(237) + "nculos Cliente x Vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarLista - Substitui TODO o conteudo de SigCdVca pelas linhas validas
    * do cursor da grade (mesma semantica do legado cmdok.Click: apaga tudo e
    * reinsere com pkchaves novo). Linhas com Iclis ou Resp vazios (linha em
    * branco ainda nao preenchida) sao descartadas, equivalente ao
    * "Delete From CrSigCdVca Where Empty(IClis) or Empty(Resp)" do legado.
    *--------------------------------------------------------------------------
    PROCEDURE SalvarLista(par_cCursorAlias)
        LOCAL loc_lSucesso, loc_lTransacaoAberta, loc_lErroScan, loc_nResultado

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroScan        = .F.

        TRY
            IF !USED(par_cCursorAlias)
                THIS.this_cMensagemErro = "Cursor de v" + CHR(237) + "nculos n" + CHR(227) + "o inicializado."
                MsgErro(THIS.this_cMensagemErro, "Erro em SalvarLista")
            ELSE
                SQLSETPROP(gnConnHandle, "Transactions", 2)
                loc_lTransacaoAberta = .T.

                loc_nResultado = SQLEXEC(gnConnHandle, "DELETE FROM SigCdVca")
                IF loc_nResultado < 0
                    loc_lErroScan = .T.
                    THIS.this_cMensagemErro = "Falha ao limpar v" + CHR(237) + "nculos anteriores:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro em SalvarLista")
                ELSE
                    SELECT (par_cCursorAlias)
                    GO TOP
                    SCAN FOR !EMPTY(Iclis) AND !EMPTY(Resp)
                        THIS.this_cIclis = Iclis
                        THIS.this_cResp  = Resp
                        IF NOT THIS.Inserir()
                            loc_lErroScan = .T.
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                IF loc_lErroScan
                    SQLTRANSACT(gnConnHandle, "ROLLBACK")
                ELSE
                    SQLTRANSACT(gnConnHandle, "COMMIT")
                    loc_lSucesso = .T.
                ENDIF
                SQLSETPROP(gnConnHandle, "Transactions", 1)
                loc_lTransacaoAberta = .F.
            ENDIF
        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLTRANSACT(gnConnHandle, "ROLLBACK")
                SQLSETPROP(gnConnHandle, "Transactions", 1)
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
