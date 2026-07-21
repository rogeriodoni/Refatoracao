*==============================================================================
* SigPrSerBO.prg - Business Object: Servi?os Lan?ados
* Tipo: OPERACIONAL (somente leitura - popup filho de form de processamento)
* Tabelas: SigPdMvf, SigCdNei, SigCdNec, SigCdPro, SigCdCli
*==============================================================================

DEFINE CLASS SigPrSerBO AS BusinessBase

    *-- Identifica??o da entidade
    this_cTabela        = "SigCdNei"
    this_cCampoChave    = "cidchaves"

    *-- Chave prim?ria composta (char(20)) do registro corrente em SigCdNei
    this_cCidchaves     = ""

    *-- Dados da opera??o pai (exibidos no container Opera??o)
    this_cEmpdnps       = ""  && char(33) - chave composta emp+op+num
    this_cEmps          = ""  && char(3)  - empresa
    this_nNumps         = 0   && numeric(10,0) - n?mero do processamento
    this_cDopps         = ""  && char(20) - descri??o da opera??o

    *-- Campos do registro corrente do grid (TmpDistrib)
    this_cGrupoos       = ""  && char(10) - grupo de origem (SigCdNec)
    this_cContaos       = ""  && char(10) - conta de origem (SigCdNec)
    this_cGrupods       = ""  && char(10) - grupo de destino (SigCdNec)
    this_cContads       = ""  && char(10) - conta de destino (SigCdNec)
    this_nNops          = 0   && numeric(10,0) - n?mero da opera??o (SigCdNei)
    this_cCmats         = ""  && char(14) - c?digo do material/servi?o (SigCdNei)
    this_nFators        = 0   && numeric(7,4) - fator unit?rio (SigCdNei)
    this_nQtds          = 0   && numeric(9,3) - quantidade (SigCdNei)
    this_cCretrabs      = ""  && char(6) - c?digo retrabalho (SigCdNei)
    this_lRetrabs       = .F. && bit - flag retrabalho (SigCdNec)
    this_cCdescs        = ""  && char(40) - descri??o complementar (SigCdNei)
    this_cDpros         = ""  && char(?) - descri??o do produto/servi?o (SigCdPro)
    this_cDescOrig      = ""  && char(60) - descri??o conta origem (SigCdCli.Rclis)
    this_cDescDest      = ""  && char(60) - descri??o conta destino (SigCdCli.Rclis)

    *-- Totais acumulados do grid
    this_nQtdTotal      = 0   && SUM(qtds)
    this_nValTotal      = 0   && SUM(qtds * fators)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()

        THIS.this_cTabela     = "SigCdNei"
        THIS.this_cCampoChave = "cidchaves"
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarServicos(par_nNops)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nNops, loc_oErro
        loc_lSucesso = .F.
        loc_nNops    = IIF(VARTYPE(par_nNops) = "N", par_nNops, 0)

        TRY
            *-- Cursor placeholder (estrutura identica ao SQLEXEC)
            IF USED("TmpDistrib")
                TABLEREVERT(.T., "TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib ( ;
                Empdnps  C(33)  NULL, ;
                Grupoos  C(10)  NULL, ;
                Contaos  C(10)  NULL, ;
                Grupods  C(10)  NULL, ;
                Contads  C(10)  NULL, ;
                Nops     N(10,0) NULL, ;
                cMats    C(14)  NULL, ;
                Fators   N(7,4)  NULL, ;
                Qtds     N(9,3)  NULL, ;
                Cretrabs C(6)   NULL, ;
                Retrabs  I      NULL, ;
                CDescs   C(40)  NULL, ;
                Dpros    C(40)  NULL, ;
                DescOrig C(60)  NULL, ;
                DescDest C(60)  NULL  ;
            )
            SET NULL OFF

            *-- SELECT base com where 0=1 para criar estrutura
            loc_cSQL = "SELECT a.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, " + ;
                       "b.nOps, b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, " + ;
                       "b.CDescs, d.Dpros, " + ;
                       "e.Rclis as DescOrig, f.Rclis as DescDest " + ;
                       "FROM SigPdMvf a " + ;
                       "INNER JOIN SigCdNei b ON a.Empdnps = b.Empdnps " + ;
                       "INNER JOIN SigCdNec c ON a.Empdnps = c.Empdnps " + ;
                       "INNER JOIN SigCdPro d ON b.Cmats = d.Cpros " + ;
                       "INNER JOIN SigCdCli e ON c.Contaos = e.Iclis " + ;
                       "INNER JOIN SigCdCli f ON c.Contads = f.Iclis " + ;
                       "WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
                       " AND b.servicos = 1 AND b.Cats <> ''"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ServicosTmp") < 1
                THIS.this_cMensagemErro = "Falha ao carregar servi" + CHR(231) + CHR(245) + "os lan" + CHR(231) + "ados."
            ELSE
                SELECT TmpDistrib
                ZAP
                APPEND FROM DBF("cursor_4c_ServicosTmp")
                IF USED("cursor_4c_ServicosTmp")
                    USE IN cursor_4c_ServicosTmp
                ENDIF
                SELECT TmpDistrib
                GO TOP
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarServicosDeXMfas(par_cCursorXMfas)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nNops, loc_oErro, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(VARTYPE(par_cCursorXMfas) = "C" AND !EMPTY(par_cCursorXMfas), par_cCursorXMfas, "xMfas")

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        TRY
            *-- Criar/recriar cursor TmpDistrib
            IF USED("TmpDistrib")
                TABLEREVERT(.T., "TmpDistrib")
                USE IN TmpDistrib
            ENDIF

            SET NULL ON
            CREATE CURSOR TmpDistrib ( ;
                Empdnps  C(33)  NULL, ;
                Grupoos  C(10)  NULL, ;
                Contaos  C(10)  NULL, ;
                Grupods  C(10)  NULL, ;
                Contads  C(10)  NULL, ;
                Nops     N(10,0) NULL, ;
                cMats    C(14)  NULL, ;
                Fators   N(7,4)  NULL, ;
                Qtds     N(9,3)  NULL, ;
                Cretrabs C(6)   NULL, ;
                Retrabs  I      NULL, ;
                CDescs   C(40)  NULL, ;
                Dpros    C(40)  NULL, ;
                DescOrig C(60)  NULL, ;
                DescDest C(60)  NULL  ;
            )
            SET NULL OFF

            *-- Percorre fases do cursor xMfas (mesmo padr?o do legado)
            SELECT (loc_cAlias)
            SCAN
                loc_nNops = Nops

                loc_cSQL = "SELECT b.Empdnps, c.grupoos, c.contaos, c.grupods, c.contads, " + ;
                           "b.cmats, b.fators, b.qtds, b.cretrabs, c.retrabs, " + ;
                           "b.CDescs, d.dpros, " + ;
                           "e.Rclis as DescOrig, f.Rclis as DescDest " + ;
                           "FROM SigPdMvf a " + ;
                           "INNER JOIN SigCdNei b ON a.Empdnps = b.Empdnps " + ;
                           "INNER JOIN SigCdNec c ON a.Empdnps = c.Empdnps " + ;
                           "INNER JOIN SigCdPro d ON b.Cmats = d.Cpros " + ;
                           "INNER JOIN SigCdCli e ON c.Contaos = e.Iclis " + ;
                           "INNER JOIN SigCdCli f ON c.Contads = f.Iclis " + ;
                           "WHERE a.Nops = " + FormatarNumeroSQL(loc_nNops, 0) + ;
                           " AND b.servicos = 1 AND b.Cats <> ''"

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalMFas4") >= 1
                    SELECT cursor_4c_LocalMFas4
                    SCAN
                        SCATTER MEMO MEMVAR
                        SELECT TmpDistrib
                        INSERT INTO TmpDistrib FROM MEMVAR
                    ENDSCAN
                    IF USED("cursor_4c_LocalMFas4")
                        USE IN cursor_4c_LocalMFas4
                    ENDIF
                ENDIF
            ENDSCAN

            SELECT TmpDistrib
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Acumular()
    *--------------------------------------------------------------------------
        LOCAL loc_nQtdTotal, loc_nValTotal, loc_oErro
        loc_nQtdTotal = 0
        loc_nValTotal = 0

        TRY
            IF USED("TmpDistrib") AND RECCOUNT("TmpDistrib") > 0
                SELECT SUM(Qtds) AS loc_nQtd, SUM(Qtds * Fators) AS loc_nVal ;
                    FROM TmpDistrib ;
                    INTO CURSOR cursor_4c_Acumulado READWRITE
                IF USED("cursor_4c_Acumulado")
                    SELECT cursor_4c_Acumulado
                    loc_nQtdTotal = NVL(loc_nQtd, 0)
                    loc_nValTotal = NVL(loc_nVal, 0)
                    USE IN cursor_4c_Acumulado
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        THIS.this_nQtdTotal = loc_nQtdTotal
        THIS.this_nValTotal = loc_nValTotal
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cCursorAlias)
    *--------------------------------------------------------------------------
        LOCAL loc_cAlias
        loc_cAlias = IIF(VARTYPE(par_cCursorAlias) = "C" AND !EMPTY(par_cCursorAlias), par_cCursorAlias, "TmpDistrib")

        IF !USED(loc_cAlias)
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        THIS.this_cEmpdnps  = TratarNulo(Empdnps,  "C")
        THIS.this_cGrupoos  = TratarNulo(Grupoos,  "C")
        THIS.this_cContaos  = TratarNulo(Contaos,  "C")
        THIS.this_cGrupods  = TratarNulo(Grupods,  "C")
        THIS.this_cContads  = TratarNulo(Contads,  "C")
        THIS.this_nNops     = TratarNulo(Nops,     "N")
        THIS.this_cCmats    = TratarNulo(cMats,    "C")
        THIS.this_nFators   = TratarNulo(Fators,   "N")
        THIS.this_nQtds     = TratarNulo(Qtds,     "N")
        THIS.this_cCretrabs = TratarNulo(Cretrabs, "C")
        IF VARTYPE(Retrabs) = "L"
            THIS.this_lRetrabs = Retrabs
        ELSE
            IF VARTYPE(Retrabs) = "L"
                THIS.this_lRetrabs = Retrabs
            ELSE
                IF VARTYPE(Retrabs) = "L"
                    THIS.this_lRetrabs = Retrabs
                ELSE
                    IF VARTYPE(Retrabs) = "L"
                        THIS.this_lRetrabs = Retrabs
                    ELSE
                        IF VARTYPE(Retrabs) = "L"
                            THIS.this_lRetrabs = Retrabs
                        ELSE
                            IF VARTYPE(Retrabs) = "L"
                                THIS.this_lRetrabs = Retrabs
                            ELSE
                                IF VARTYPE(Retrabs) = "L"
                                    THIS.this_lRetrabs = Retrabs
                                ELSE
                                    THIS.this_lRetrabs = (NVL(Retrabs, 0) = 1)
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        ENDIF
        THIS.this_cCdescs   = TratarNulo(CDescs,   "C")
        THIS.this_cDpros    = TratarNulo(Dpros,    "C")
        THIS.this_cDescOrig = TratarNulo(DescOrig, "C")
        THIS.this_cDescDest = TratarNulo(DescDest, "C")

        *-- Chave prim?ria opcional (SigCdNei.cidchaves) quando presente no cursor
        IF TYPE(loc_cAlias + ".Cidchaves") != "U"
            THIS.this_cCidchaves = TratarNulo(Cidchaves, "C")
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves (char(20)) do registro em SigCdNei
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdNei do servi?o corrente
    *   Persiste os campos do registro carregado (Empdnps, Nops, Cmats, Qtds,
    *   Fators, Cretrabs, CDescs). Marca Servicos=1 e gera chave prim?ria
    *   cidchaves quando ausente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cCats, loc_oErro, loc_nResultado
        loc_lSucesso = .F.

        TRY
            *-- Cats = primeiros 6 chars do c?digo do material (padr?o legado)
            loc_cCats = LEFT(THIS.this_cCmats, 6)

            *-- Gera chave prim?ria composta se ainda n?o houver
            IF EMPTY(THIS.this_cCidchaves)
                loc_cChave = LEFT(ALLTRIM(THIS.this_cEmpdnps) + ;
                                  PADL(ALLTRIM(TRANSFORM(THIS.this_nNops)), 10, "0") + ;
                                  ALLTRIM(loc_cCats), 20)
                THIS.this_cCidchaves = loc_cChave
            ENDIF

            loc_cSQL = "INSERT INTO SigCdNei (" + ;
                       "cidchaves, Empdnps, Nops, Cmats, Cats, " + ;
                       "Qtds, Fators, Cretrabs, Cdescs, Servicos, " + ;
                       "Emps, Numps, Dopps" + ;
                       ") VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cEmpdnps, 33)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCmats, 14)) + ", " + ;
                       EscaparSQL(LEFT(loc_cCats, 6)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFators, 4) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCretrabs, 6)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCdescs, 40)) + ", " + ;
                       "1, " + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps, 0) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cDopps, 20)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Falha ao inserir servi" + CHR(231) + "o em SigCdNei."
            ELSE
                THIS.RegistrarAuditoria("INCLUSAO")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdNei do servi?o corrente por Empdnps+Cmats
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_nResultado
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cEmpdnps) OR EMPTY(THIS.this_cCmats)
            THIS.this_cMensagemErro = "Empdnps ou Cmats n" + CHR(227) + "o informado."
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdNei SET " + ;
                       "Nops     = " + FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                       "Cats     = " + EscaparSQL(LEFT(THIS.this_cCmats, 6)) + ", " + ;
                       "Qtds     = " + FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                       "Fators   = " + FormatarNumeroSQL(THIS.this_nFators, 4) + ", " + ;
                       "Cretrabs = " + EscaparSQL(LEFT(THIS.this_cCretrabs, 6)) + ", " + ;
                       "Cdescs   = " + EscaparSQL(LEFT(THIS.this_cCdescs, 40)) + ", " + ;
                       "Servicos = 1 " + ;
                       "WHERE Empdnps = " + EscaparSQL(LEFT(THIS.this_cEmpdnps, 33)) + ;
                       " AND Cmats = " + EscaparSQL(LEFT(THIS.this_cCmats, 14))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Falha ao atualizar servi" + CHR(231) + "o em SigCdNei."
            ELSE
                THIS.RegistrarAuditoria("ALTERACAO")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
