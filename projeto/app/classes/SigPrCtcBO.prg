*==============================================================================
* SigPrCtcBO.prg - Business Object para Cotacoes por Operacoes
* Herda de BusinessBase
* Tabela principal: sigprctc
* PK: pkchaves (char 20)
* Fase 1: Propriedades e Init()
*==============================================================================

DEFINE CLASS SigPrCtcBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificador composto da operacao (pcEmps + pcDopes + STR(pnNumes,6))
    * Chave de agrupamento de todas as cotacoes da operacao
    *--------------------------------------------------------------------------
    this_cEmpDopNums = ""    && empdopnums char(29) - chave da operacao

    *--------------------------------------------------------------------------
    * Campos da linha corrente de sigprctc
    *--------------------------------------------------------------------------
    this_cCmoes      = ""    && cmoes    char(3)       - codigo da moeda (FK SigCdMoe)
    this_nValos      = 0     && valos    numeric(11,6) - cotacao da moeda
    this_cPkChaves   = ""    && pkchaves char(20)      - chave primaria (PK)
    this_dDtalts     = {}    && dtalts   datetime NULL - data/hora alteracao
    this_cUsuars     = ""    && usuars   char(10)      - usuario que gravou

    *--------------------------------------------------------------------------
    * Campo auxiliar vindo do JOIN com SigCdMoe (nao persistido em sigprctc)
    *--------------------------------------------------------------------------
    this_cDescrs     = ""    && dmoes char(15) - descricao da moeda (SigCdMoe.dmoes)

    *--------------------------------------------------------------------------
    * Controle interno de estado da colecao
    *--------------------------------------------------------------------------
    this_lHouveInsercao  = .F.  && .T. se alguma linha foi inserida na sessao
    this_lHouveExclusao  = .F.  && .T. se alguma linha foi removida na sessao

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.this_cTabela     = "sigprctc"
            THIS.this_cCampoChave = "pkchaves"

            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SigPrCtcBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria (auditoria)
    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades de uma linha do cursor
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cCmoes      = TratarNulo(cmoes,      "C")
                THIS.this_nValos      = TratarNulo(valos,      "N")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,   "C")
                THIS.this_cDescrs     = TratarNulo(Descrs,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParaEdicao - Carrega cotacoes da operacao em cursor VFP local
    * par_cEmpDopNums: chave da operacao (emps+dopes+numes, 29 chars)
    * Cria cursor_4c_Dados para edicao em memoria
    *==========================================================================
    PROCEDURE CarregarParaEdicao(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ;
                (empdopnums C(29), cmoes C(3), valos N(11,6), pkchaves C(20), Descrs C(15))
            SET NULL OFF

            loc_cSQL = "SELECT a.empdopnums, a.cmoes, a.valos, a.pkchaves," + ;
                       " ISNULL(b.dmoes,'') AS Descrs" + ;
                       " FROM sigprctc a" + ;
                       " LEFT JOIN SigCdMoe b ON b.cmoes = a.cmoes" + ;
                       " WHERE a.empdopnums = " + EscaparSQL(ALLTRIM(par_cEmpDopNums))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtMoeTemp")

            IF loc_nResult > 0 AND USED("cursor_4c_CtMoeTemp") AND RECCOUNT("cursor_4c_CtMoeTemp") > 0
                SELECT cursor_4c_Dados
                APPEND FROM DBF("cursor_4c_CtMoeTemp")
            ENDIF

            IF USED("cursor_4c_CtMoeTemp")
                USE IN cursor_4c_CtMoeTemp
            ENDIF

            SELECT cursor_4c_Dados
            GO TOP

            THIS.this_lHouveInsercao = .F.
            THIS.this_lHouveExclusao = .F.

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro CarregarParaEdicao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirLinhaLocal - Insere nova linha em branco no cursor local
    * par_cEmpDopNums: chave da operacao para preencher o campo de agrupamento
    *==========================================================================
    PROCEDURE InserirLinhaLocal(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cPkChave
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                SELECT cursor_4c_Dados
                LOCATE FOR EMPTY(cmoes) AND !DELETED()
                IF EOF()
                    loc_cPkChave = LEFT(SYS(2015) + PADR(TRANSFORM(RECCOUNT("cursor_4c_Dados") + 1), 10, "0"), 20)
                    INSERT INTO cursor_4c_Dados (empdopnums, cmoes, valos, pkchaves, Descrs) ;
                        VALUES (ALLTRIM(par_cEmpDopNums), SPACE(3), 0, loc_cPkChave, SPACE(15))
                    GO BOTTOM
                ELSE
                    GO RECNO()
                ENDIF
                THIS.this_lHouveInsercao = .T.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro InserirLinhaLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExcluirLinhaLocal - Remove linha corrente do cursor local (marca deleted)
    *==========================================================================
    PROCEDURE ExcluirLinhaLocal()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Dados")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                IF !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                DELETE
                SKIP
                IF EOF()
                    SKIP -1
                ENDIF
                THIS.this_lHouveExclusao = .T.
                loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExcluirLinhaLocal")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDuplicidade - Verifica se ha moedas duplicadas no cursor local
    * Retorna .T. se valido (sem duplicatas), .F. se ha moedas repetidas
    *==========================================================================
    PROCEDURE ValidarDuplicidade()
        LOCAL loc_lValido, loc_cMoesDup
        loc_lValido  = .F.
        loc_cMoesDup = ""

        TRY
            IF !USED("cursor_4c_Dados")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                IF USED("cursor_4c_Totais")
                    USE IN cursor_4c_Totais
                ENDIF

                SELECT cmoes, SUM(1) AS tt FROM cursor_4c_Dados ;
                    WHERE !DELETED() AND !EMPTY(ALLTRIM(cmoes)) ;
                    GROUP BY cmoes ;
                    INTO CURSOR cursor_4c_Totais

                IF USED("cursor_4c_Totais")
                    SELECT cursor_4c_Totais
                    SCAN
                        IF tt > 1
                            IF !EMPTY(loc_cMoesDup)
                                loc_cMoesDup = loc_cMoesDup + ", "
                            ENDIF
                            loc_cMoesDup = loc_cMoesDup + ALLTRIM(cmoes)
                        ENDIF
                    ENDSCAN
                    USE IN cursor_4c_Totais
                ENDIF

                IF !EMPTY(loc_cMoesDup)
                    MsgErro("Moeda(s) digitada(s) em duplicidade: " + loc_cMoesDup, ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ELSE
                    loc_lValido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ValidarDuplicidade")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * BuscarMoeda - Busca moeda por codigo em SigCdMoe
    * par_cCodigo: codigo da moeda (cmoes)
    * Popula cursor_4c_BuscaMoeda; retorna .T. se encontrou codigo exato
    *==========================================================================
    PROCEDURE BuscarMoeda(par_cCodigo)
        LOCAL loc_lEncontrou, loc_cSQL, loc_nResult
        loc_lEncontrou = .F.

        TRY
            IF USED("cursor_4c_BuscaMoeda")
                USE IN cursor_4c_BuscaMoeda
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes AS Descrs FROM SigCdMoe" + ;
                       " WHERE cmoes LIKE " + EscaparSQL(ALLTRIM(par_cCodigo) + "%") + ;
                       " ORDER BY cmoes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeda")

            IF loc_nResult > 0 AND USED("cursor_4c_BuscaMoeda") AND RECCOUNT("cursor_4c_BuscaMoeda") > 0
                SELECT cursor_4c_BuscaMoeda
                GO TOP
                IF RECCOUNT("cursor_4c_BuscaMoeda") = 1 AND ;
                   UPPER(ALLTRIM(cursor_4c_BuscaMoeda.cmoes)) == UPPER(ALLTRIM(par_cCodigo))
                    THIS.this_cCmoes  = ALLTRIM(cursor_4c_BuscaMoeda.cmoes)
                    THIS.this_cDescrs = ALLTRIM(cursor_4c_BuscaMoeda.Descrs)
                    loc_lEncontrou = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro BuscarMoeda")
        ENDTRY

        RETURN loc_lEncontrou
    ENDPROC

    *==========================================================================
    * AtualizarDescricaoMoeda - Atualiza campo Descrs na linha corrente do cursor local
    *==========================================================================
    PROCEDURE AtualizarDescricaoMoeda(par_cDescrs)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                SELECT cursor_4c_Dados
                REPLACE Descrs WITH PADR(ALLTRIM(par_cDescrs), 15)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AtualizarDescricaoMoeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * SalvarCotacoes - Persiste cotacoes no SQL Server (DELETE all + INSERT validas)
    * par_cEmpDopNums: chave da operacao
    * Logica: deleta todos da operacao, re-insere linhas validas do cursor local
    *==========================================================================
    PROCEDURE SalvarCotacoes(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_nLinha, loc_cPkChave
        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDuplicidade()
                *-- mensagem ja exibida por ValidarDuplicidade
            ELSE
                IF !USED("cursor_4c_Dados")
                MsgErro("Cursor de edi" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o iniciado.", "Erro")
            ELSE
                *-- Passo 1: Remove todos os registros da operacao no SQL Server
                loc_cSQL = "DELETE FROM sigprctc WHERE empdopnums = " + ;
                           EscaparSQL(ALLTRIM(par_cEmpDopNums))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir cota" + CHR(231) + CHR(245) + "es anteriores:" + ;
                            CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Passo 2: Re-insere todas as linhas validas do cursor local
                    SELECT cursor_4c_Dados
                    GO TOP
                    loc_lSucesso = .T.
                    loc_nLinha   = 0

                    SCAN WHILE loc_lSucesso
                        IF DELETED()
                            LOOP
                        ENDIF
                        IF EMPTY(ALLTRIM(cmoes))
                            LOOP
                        ENDIF

                        loc_nLinha   = loc_nLinha + 1
                        loc_cPkChave = LEFT(SYS(2015) + PADR(TRANSFORM(loc_nLinha), 10, "0"), 20)

                        loc_cSQL = "INSERT INTO sigprctc (empdopnums, cmoes, valos, pkchaves, dtalts, usuars)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(ALLTRIM(par_cEmpDopNums)) + "," + ;
                                   EscaparSQL(ALLTRIM(cmoes)) + "," + ;
                                   FormatarNumeroSQL(valos) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   "GETDATE()," + ;
                                   EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ;
                                   ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                        IF USED("cursor_4c_Ins")
                            USE IN cursor_4c_Ins
                        ENDIF

                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o da moeda " + ;
                                    ALLTRIM(cmoes) + ":" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDSCAN

                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("SALVAR_COTACOES")
                    ENDIF
                ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro SalvarCotacoes")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
