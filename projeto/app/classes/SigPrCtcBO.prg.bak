*==============================================================================
* SigPrCtcBO.prg - Business Object para Cota" + CHR(231) + CHR(245) + "es por Opera" + CHR(231) + CHR(245) + "es
* Herda de: BusinessBase
* Tabela principal: SIGPRCTC
* Lookup: SigCdMoe (CMoes / DMoes)
*==============================================================================

DEFINE CLASS SigPrCtcBO AS BusinessBase

    *-- Chave combinada de operacao (pcEmps + pcDopes + STR(pnNumes,6))
    this_cEmpDopNums = ""

    *-- Componentes individuais da chave de operacao
    this_cEmps       = ""   && Codigo da empresa
    this_cDopes      = ""   && Codigo da operacao
    this_nNumes      = 0    && Numero da operacao

    *-- Chave primaria do registro de cotacao (fUniqueIds)
    this_cPkChaves   = ""

    *-- Dados da cotacao (linha do grid)
    this_cMoes       = ""   && Codigo da moeda (CMoes de SigCdMoe)
    this_cDescMoes   = ""   && Descricao da moeda (DMoes de SigCdMoe, alias Descrs)
    this_nValos      = 0    && Valor/cotacao (Valos)

    *-- Controle de permissao
    this_cEscolha    = ""   && Restricao de operacao (INSERIR / ALTERAR / VISUALIZAR)

    *-- Flags de controle de alteracoes no grid (rastreamento de sessao)
    this_lHouveExcl  = .F.  && .T. se houve exclusao na sessao atual
    this_lHouveIns   = .F.  && .T. se houve insercao na sessao atual

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGPRCTC"
        THIS.this_cCampoChave = "pkChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para registro de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursor - Cria cursor local para o grid de cotacoes
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursor()
        IF USED("cursor_4c_CtMoe")
            USE IN cursor_4c_CtMoe
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_CtMoe ( ;
            EmpDopNums C(20), ;
            cMoes      C(10), ;
            Descrs     C(60), ;
            Valos      N(14,7), ;
            pkChaves   C(36)  ;
        )
        SET NULL OFF
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega cotacoes da operacao no cursor local (par_cFiltro = EmpDopNums)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            THIS.InicializarCursor()

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT a.EmpDopNums, a.cMoes, b.dMoes AS Descrs," + ;
                           " a.Valos, a.pkChaves" + ;
                           " FROM SIGPRCTC a" + ;
                           " LEFT JOIN SigCdMoe b ON b.CMoes = a.cMoes" + ;
                           " WHERE a.EmpDopNums = " + EscaparSQL(par_cFiltro)

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_CtMoeTemp")
                    TABLEREVERT(.T., "cursor_4c_CtMoeTemp")
                    USE IN cursor_4c_CtMoeTemp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtMoeTemp")

                IF loc_nResultado > 0
                    SELECT cursor_4c_CtMoe
                    SELECT cursor_4c_CtMoe
                    ZAP
                    IF RECCOUNT("cursor_4c_CtMoeTemp") > 0
                        APPEND FROM DBF("cursor_4c_CtMoeTemp")
                    ENDIF
                    IF USED("cursor_4c_CtMoeTemp")
                        USE IN cursor_4c_CtMoeTemp
                    ENDIF
                    GO TOP IN cursor_4c_CtMoe
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao carregar cota" + CHR(231) + CHR(245) + "es: " + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirLinha - Adiciona linha em branco no cursor local
    *--------------------------------------------------------------------------
    FUNCTION InserirLinha(par_cEmpDopNums)
        LOCAL loc_lResultado, loc_cPk
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_CtMoe")
                THIS.InicializarCursor()
            ENDIF

            SELECT cursor_4c_CtMoe
            LOCATE FOR EMPTY(ALLTRIM(cMoes))
            IF EOF()
                loc_cPk = FUniqueIds()
                INSERT INTO cursor_4c_CtMoe (EmpDopNums, pkChaves, cMoes, Descrs, Valos) ;
                    VALUES (par_cEmpDopNums, loc_cPk, " ", "", 0)
            ENDIF

            THIS.this_lHouveIns = .T.
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao inserir linha: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirLinhaAtual - Marca linha atual como excluida no cursor local
    *--------------------------------------------------------------------------
    FUNCTION ExcluirLinhaAtual()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_CtMoe") AND !EOF("cursor_4c_CtMoe")
                SELECT cursor_4c_CtMoe
                DELETE
                SKIP
                IF EOF()
                    SKIP -1
                ENDIF
                THIS.this_lHouveExcl = .T.
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir linha: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDuplicidade - Verifica se ha moedas duplicadas no cursor local
    *--------------------------------------------------------------------------
    FUNCTION ValidarDuplicidade()
        LOCAL loc_lResultado
        loc_lResultado = .T.

        TRY
            IF USED("cursor_4c_CtMoe")
                SELECT cMoes, SUM(1) AS TT ;
                    FROM cursor_4c_CtMoe ;
                    WHERE !DELETED() AND !EMPTY(ALLTRIM(cMoes)) ;
                    GROUP BY cMoes ;
                    INTO CURSOR cursor_4c_Totais NOFILTER

                SELECT cursor_4c_Totais
                SCAN
                    IF TT > 1
                        MsgErro("Moedas " + ALLTRIM(cMoes) + " Digitada em Duplicidade!!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lResultado = .F.
                        EXIT
                    ENDIF
                ENDSCAN

                IF USED("cursor_4c_Totais")
                    USE IN cursor_4c_Totais
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarCotacoes - Persiste todas as cotacoes no SQL Server (DELETE + INSERT)
    *--------------------------------------------------------------------------
    FUNCTION SalvarCotacoes(par_cEmpDopNums)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cInsSQL, loc_cPk
        loc_lResultado = .F.

        IF !THIS.ValidarDuplicidade()
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_StgCtc")
                USE IN cursor_4c_StgCtc
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_StgCtc ( ;
                EmpDopNums C(20), ;
                cMoes      C(10), ;
                pkChaves   C(36), ;
                Valos      N(14,7) ;
            )
            SET NULL OFF

            SELECT cursor_4c_CtMoe
            SCAN FOR !DELETED() AND !EMPTY(ALLTRIM(cMoes))
                loc_cPk = FUniqueIds()
                INSERT INTO cursor_4c_StgCtc (EmpDopNums, cMoes, pkChaves, Valos) ;
                    VALUES (par_cEmpDopNums, ALLTRIM(cMoes), loc_cPk, Valos)
            ENDSCAN

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Trx")
                TABLEREVERT(.T., "cursor_4c_Trx")
                USE IN cursor_4c_Trx
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, "BEGIN TRANSACTION", "cursor_4c_Trx")
            IF USED("cursor_4c_Trx")
                USE IN cursor_4c_Trx
            ENDIF

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SIGPRCTC WHERE EmpDopNums = " + ;
                    EscaparSQL(par_cEmpDopNums)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Del")
                    TABLEREVERT(.T., "cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF

                IF loc_nResultado >= 0
                    loc_lResultado = .T.
                    SELECT cursor_4c_StgCtc
                    SCAN
                        loc_cInsSQL = "INSERT INTO SIGPRCTC (EmpDopNums, cMoes, pkChaves, Valos)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(EmpDopNums)) + ", " + ;
                            EscaparSQL(ALLTRIM(cMoes)) + ", " + ;
                            EscaparSQL(ALLTRIM(pkChaves)) + ", " + ;
                            FormatarNumeroSQL(Valos) + ")"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_Ins")
                            TABLEREVERT(.T., "cursor_4c_Ins")
                            USE IN cursor_4c_Ins
                        ENDIF

                        IF SQLEXEC(gnConnHandle, loc_cInsSQL, "cursor_4c_Ins") < 0
                            MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o: " + ;
                                CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                            EXIT
                        ENDIF
                        IF USED("cursor_4c_Ins")
                            USE IN cursor_4c_Ins
                        ENDIF
                    ENDSCAN
                ELSE
                    MsgErro("Erro ao excluir cota" + CHR(231) + CHR(245) + "es: " + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao iniciar transa" + CHR(231) + CHR(227) + "o: " + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF loc_lResultado
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Cmt")
                    TABLEREVERT(.T., "cursor_4c_Cmt")
                    USE IN cursor_4c_Cmt
                ENDIF

                SQLEXEC(gnConnHandle, "COMMIT TRANSACTION", "cursor_4c_Cmt")
                IF USED("cursor_4c_Cmt")
                    USE IN cursor_4c_Cmt
                ENDIF
                THIS.RegistrarAuditoria("UPDATE")
            ELSE
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Rb")
                    TABLEREVERT(.T., "cursor_4c_Rb")
                    USE IN cursor_4c_Rb
                ENDIF

                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_Rb")
                IF USED("cursor_4c_Rb")
                    USE IN cursor_4c_Rb
                ENDIF
            ENDIF

            IF USED("cursor_4c_StgCtc")
                USE IN cursor_4c_StgCtc
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao salvar: " + loException.Message, "Erro")
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_RbEx")
                TABLEREVERT(.T., "cursor_4c_RbEx")
                USE IN cursor_4c_RbEx
            ENDIF

            SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION", "cursor_4c_RbEx")
            IF USED("cursor_4c_RbEx")
                USE IN cursor_4c_RbEx
            ENDIF
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMoeda - Lookup na tabela SigCdMoe
    *--------------------------------------------------------------------------
    FUNCTION BuscarMoeda(par_cCodigo, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT CMoes, dMoes AS Descrs FROM SigCdMoe"
            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = loc_cSQL + " WHERE CMoes = " + EscaparSQL(ALLTRIM(par_cCodigo))
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY CMoes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)
            loc_lResultado = (loc_nResultado > 0)

            IF !loc_lResultado
                MsgErro("Erro ao buscar moedas: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves   = TratarNulo(pkChaves, "C")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                THIS.this_cMoes       = TratarNulo(cMoes, "C")
                THIS.this_nValos      = TratarNulo(Valos, "N")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere um registro individual de cotacao no SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                THIS.this_cPkChaves = FUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SIGPRCTC (EmpDopNums, cMoes, pkChaves, Valos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                       EscaparSQL(THIS.this_cMoes) + ", " + ;
                       EscaparSQL(THIS.this_cPkChaves) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValos) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir cota" + CHR(231) + CHR(227) + "o: " + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza um registro individual de cotacao no SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SIGPRCTC SET" + ;
                       " cMoes = " + EscaparSQL(THIS.this_cMoes) + "," + ;
                       " Valos = " + FormatarNumeroSQL(THIS.this_nValos) + ;
                       " WHERE pkChaves = " + EscaparSQL(THIS.this_cPkChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar cota" + CHR(231) + CHR(227) + "o: " + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove um registro de cotacao do SQL Server por pkChaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGPRCTC WHERE pkChaves = " + ;
                EscaparSQL(THIS.this_cPkChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir cota" + CHR(231) + CHR(227) + "o: " + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
