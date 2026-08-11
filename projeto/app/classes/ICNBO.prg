*==============================================================================
* ICNBO.prg - Business Object para Icones de Acesso (sigcdprg)
* Form OPERACIONAL: gerencia atribuicao de icones aos programas do sistema
* Herda de: BusinessBase
* Tabela: sigcdprg | PK: pkchaves
*==============================================================================
DEFINE CLASS ICNBO AS BusinessBase

    *-- Configuracao da tabela
    this_cTabela     = "sigcdprg"
    this_cCampoChave = "pkchaves"

    *-- Cursores utilizados pelo form
    this_cCursorProg         = "cursor_4c_Prog"
    this_cCursorProgFiltrado = "cursor_4c_ProgFiltrado"
    this_cCursorIcones       = "cursor_4c_Icones"

    *-- Diretorio temporario para arquivos .ico extraidos de SigSyIco.marqicones
    this_cDirTmp = ""

    *-- Indica se as alteracoes foram confirmadas pelo usuario
    this_lSalvo = .F.

    *-- Propriedades do registro corrente (CarregarDoCursor / ObterChavePrimaria)
    this_cDescricaos = ""
    this_cProgramas  = ""
    this_cBarrapict  = ""
    this_cBarraforms = ""
    this_cParametros = ""
    this_cPkChaves   = ""

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE InicializarDados()
    *==========================================================================
    * Carrega programas e icones do banco para os cursores de trabalho
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN loc_lSucesso
        ENDIF
        TRY
            IF THIS.CarregarProgramas()
                loc_lSucesso = THIS.CarregarIcones()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarProgramas()
    *==========================================================================
    * Busca sigcdprg e cria cursor_4c_Prog (todos) e cursor_4c_ProgFiltrado
    * (apenas registros com descricaos preenchida, exibido no Grid)
    *==========================================================================
        LOCAL loc_cSQL, loc_lSucesso, loc_nRet, loc_cCursorSrc, loc_cCursorDst
        loc_lSucesso  = .F.
        loc_cCursorSrc = THIS.this_cCursorProg
        loc_cCursorDst = THIS.this_cCursorProgFiltrado
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN loc_lSucesso
        ENDIF
        TRY
            IF USED(THIS.this_cCursorProg)
                USE IN (THIS.this_cCursorProg)
            ENDIF
            IF USED(THIS.this_cCursorProgFiltrado)
                USE IN (THIS.this_cCursorProgFiltrado)
            ENDIF

            loc_cSQL = "SELECT a.descricaos, a.programas, a.barrapict, " + ;
                       "a.barraforms, a.pkChaves " + ;
                       "FROM sigcdprg a " + ;
                       "ORDER BY a.descricaos"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProg)

            IF loc_nRet > 0 AND USED(THIS.this_cCursorProg)
                SELECT (THIS.this_cCursorProg)
                INDEX ON pkChaves TAG pkChaves
                REPLACE ALL barrapict WITH LOWER(ALLTRIM(JUSTFNAME(barrapict)))
                SET ORDER TO ""
                GO TOP

                SELECT a.descricaos, a.programas, a.barrapict, a.barraforms, a.pkChaves ;
                    FROM (loc_cCursorSrc) a ;
                    WHERE NOT EMPTY(a.descricaos) ;
                    ORDER BY a.descricaos ;
                    INTO CURSOR (loc_cCursorDst) READWRITE
                INDEX ON pkChaves TAG pkChaves
                SET ORDER TO ""
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de programas do sistema.", ;
                        "Erro em CarregarProgramas")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarProgramas")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE CarregarIcones()
    *==========================================================================
    * Busca SigSyIco e extrai cada icone para arquivo .ico em diretorio temp
    *==========================================================================
        LOCAL loc_cSQL, loc_lSucesso, loc_nRet, loc_cArqIcone, loc_nTamIcone
        loc_lSucesso = .F.
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN loc_lSucesso
        ENDIF
        TRY
            IF USED(THIS.this_cCursorIcones)
                USE IN (THIS.this_cCursorIcones)
            ENDIF

            THIS.this_cDirTmp = ADDBS(SYS(2023))

            loc_cSQL = "SELECT a.carqicones, a.marqicones, " + ;
                       "SPACE(255) AS ctmpicones " + ;
                       "FROM SigSyIco a " + ;
                       "ORDER BY a.carqicones"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorIcones)

            IF loc_nRet > 0 AND USED(THIS.this_cCursorIcones)
                SELECT (THIS.this_cCursorIcones)
                INDEX ON carqicones TAG carqicones
                SET ORDER TO ""
                GO TOP

                IF NOT EOF(THIS.this_cCursorIcones)
                    INSERT INTO (THIS.this_cCursorIcones) (carqicones) VALUES (' < Nenhum >')
                ENDIF
                GO TOP IN (THIS.this_cCursorIcones)

                SELECT (THIS.this_cCursorIcones)
                SCAN
                    IF NOT EMPTY(ALLTRIM(carqicones))
                        loc_cArqIcone  = THIS.this_cDirTmp + "ArqIcone" + SYS(2015) + ".ico"
                        loc_nTamIcone = STRTOFILE(marqicones, loc_cArqIcone)
                        IF loc_nTamIcone > 0
                            REPLACE ctmpicones WITH loc_cArqIcone IN (THIS.this_cCursorIcones)
                        ENDIF
                    ENDIF
                ENDSCAN

                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar lista de " + CHR(237) + "cones do sistema.", ;
                        "Erro em CarregarIcones")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarIcones")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE SalvarAlteracoes()
    *==========================================================================
    * Persiste todas as alteracoes de icones em sigcdprg (UPDATE em massa)
    * Itera por todos os registros de cursor_4c_Prog e chama THIS.Atualizar()
    * para cada linha, dentro de uma transacao unica
    *==========================================================================
        LOCAL loc_lSucesso, loc_lTransacaoAberta, loc_lErroScan
        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroScan        = .F.
        TRY
            IF NOT USED(THIS.this_cCursorProg)
                MsgErro("Cursor de programas n" + CHR(227) + "o inicializado.", ;
                        "Erro em SalvarAlteracoes")
            ELSE
                SQLSETPROP(gnConnHandle, "Transactions", 2)
                loc_lTransacaoAberta = .T.

                SELECT (THIS.this_cCursorProg)
                SET ORDER TO ""
                GO TOP

                SCAN
                    IF NOT THIS.CarregarDoCursor(THIS.this_cCursorProg)
                        loc_lErroScan = .T.
                        EXIT
                    ENDIF
                    IF NOT THIS.Atualizar()
                        loc_lErroScan = .T.
                        MsgErro("Erro ao salvar programa " + ALLTRIM(THIS.this_cDescricaos) + ;
                                " (chave: " + ALLTRIM(THIS.this_cPkChaves) + ")" + CHR(13) + ;
                                THIS.this_cMensagemErro, ;
                                "Erro em SalvarAlteracoes")
                        EXIT
                    ENDIF
                ENDSCAN

                IF loc_lErroScan
                    SQLTRANSACT(gnConnHandle, "ROLLBACK")
                ELSE
                    SQLTRANSACT(gnConnHandle, "COMMIT")
                    THIS.this_lSalvo = .T.
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
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SalvarAlteracoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Inserir()
    *==========================================================================
    * INSERT em sigcdprg com propriedades correntes (this_cPkChaves,
    * this_cDescricaos, this_cProgramas, this_cBarrapict, this_cBarraforms,
    * this_cParametros). Todas as colunas da tabela sao NOT NULL char.
    *==========================================================================
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o n" + CHR(227) + "o estabelecida."
            RETURN loc_lSucesso
        ENDIF
        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria " + ;
                    "(pkChaves) obrigat" + CHR(243) + "ria para inserir."
            ELSE
                loc_cSQL = "INSERT INTO sigcdprg " + ;
                           "(barraforms, barrapict, descricaos, parametros, programas, pkchaves) " + ;
                           "VALUES (" + ;
                           EscaparSQL(ALLTRIM(THIS.this_cBarraforms)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cBarrapict))  + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDescricaos)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cParametros)) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cProgramas))  + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cPkChaves))   + ")"
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao inserir registro em sigcdprg."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
    *==========================================================================
    * UPDATE em sigcdprg (barrapict, barraforms) filtrado por pkChaves.
    * Usado individualmente pelo form (SalvarAlteracoes itera cursor e chama)
    *==========================================================================
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o n" + CHR(227) + "o estabelecida."
            RETURN loc_lSucesso
        ENDIF
        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria " + ;
                    "(pkChaves) obrigat" + CHR(243) + "ria para atualizar."
            ELSE
                loc_cSQL = "UPDATE sigcdprg SET " + ;
                           "barrapict = "  + EscaparSQL(ALLTRIM(THIS.this_cBarrapict))  + ", " + ;
                           "barraforms = " + EscaparSQL(ALLTRIM(THIS.this_cBarraforms)) + " " + ;
                           "WHERE pkchaves = " + EscaparSQL(ALLTRIM(THIS.this_cPkChaves))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet > 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar registro em sigcdprg."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *==========================================================================
    * Carrega propriedades do BO a partir do registro corrente de um cursor
    *==========================================================================
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDescricaos = TratarNulo(descricaos, "C")
                THIS.this_cProgramas  = TratarNulo(programas,  "C")
                THIS.this_cBarrapict  = TratarNulo(barrapict,  "C")
                THIS.this_cBarraforms = TratarNulo(barraforms,  "C")
                THIS.this_cPkChaves   = TratarNulo(pkChaves,   "C")
                IF TYPE(par_cAliasCursor + ".parametros") == "C"
                    THIS.this_cParametros = TratarNulo(EVALUATE(par_cAliasCursor + ".parametros"), "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    PROCEDURE LimparArquivosTemp()
    *==========================================================================
    * Remove arquivos .ico temporarios criados durante o carregamento de icones
    *==========================================================================
        LOCAL loc_cArqIcone
        TRY
            IF USED(THIS.this_cCursorIcones)
                SELECT (THIS.this_cCursorIcones)
                SET ORDER TO ""
                GO TOP
                SCAN
                    loc_cArqIcone = ALLTRIM(ctmpicones)
                    IF NOT EMPTY(loc_cArqIcone) AND FILE(loc_cArqIcone)
                        DELETE FILE (loc_cArqIcone)
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em LimparArquivosTemp")
        ENDTRY
    ENDPROC

    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        TRY
            THIS.LimparArquivosTemp()
            IF USED(THIS.this_cCursorIcones)
                USE IN (THIS.this_cCursorIcones)
            ENDIF
            IF USED(THIS.this_cCursorProgFiltrado)
                USE IN (THIS.this_cCursorProgFiltrado)
            ENDIF
            IF USED(THIS.this_cCursorProg)
                USE IN (THIS.this_cCursorProg)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em ICNBO.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE
