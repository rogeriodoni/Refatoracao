*==============================================================================
* cfiBO.prg - Business Object para ICMS Cupom Fiscal (SIGCDCFI)
*==============================================================================
* Tabela : SIGCDCFI
* PK     : cidchaves char(20) - gerado via SYS(2015)
* Regra  : unicidade por grupos + ests + clfiscals (ChkRegister original)
*==============================================================================

DEFINE CLASS cfiBO AS BusinessBase

    *-- Chave primaria
    this_cCidchaves  = ""

    *-- Campos da tabela SIGCDCFI
    this_cEsts       = ""   && char(2)  - Estado (FK SigCdUfs.Estados)
    this_cGrupos     = ""   && char(3)  - Grupo (FK SigCdGrp.Cgrus)
    this_nIcms       = 0    && numeric(5,2) - Aliquota ICMS
    this_cTpicms     = ""   && char(1)  - Tipo ICMS: T/S/I/N/F
    this_cTptribs    = ""   && char(4)  - Tipo Tributacao (FK SigPrTri.Tipos)
    this_nOrdicms    = 0    && numeric(2,0) - Ordem ICMS
    this_cSittricms  = ""   && char(3)  - Situacao Tributaria ICMS (FK SigCdIcm.Codigos)
    this_cCfops      = ""   && char(10) - CFOP (FK SigCdCfo.codigos)
    this_cCodtrib    = ""   && char(20) - Codigo Tributacao
    this_nIssqn      = 0    && numeric(5,2) - Aliquota ISSQN
    this_cItemls     = ""   && char(5)  - Item da Lista de Servicos
    this_cNatope     = ""   && char(2)  - Natureza da Operacao
    this_cClfiscals  = ""   && char(10) - Classificacao Fiscal (FK SigCdClf.Codigos)

    *-- Campos de exibicao (lookup - nao armazenados em SIGCDCFI)
    this_cDgrus      = ""   && Descricao do Grupo (SigCdGrp.Dgrus)
    this_cDsittricms = ""   && Descricao Sit. Tributaria (SigCdIcm.Descricaos)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela      = "SIGCDCFI"
        THIS.this_cCampoChave  = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCidchaves
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cEsts       = TratarNulo(ests,       "C")
            THIS.this_cGrupos     = TratarNulo(grupos,     "C")
            THIS.this_nIcms       = TratarNulo(icms,       "N")
            THIS.this_cTpicms     = TratarNulo(tpicms,     "C")
            THIS.this_cTptribs    = TratarNulo(tptribs,    "C")
            THIS.this_nOrdicms    = TratarNulo(ordicms,    "N")
            THIS.this_cSittricms  = TratarNulo(sittricms,  "C")
            THIS.this_cCfops      = TratarNulo(cfops,      "C")
            THIS.this_cCodtrib    = TratarNulo(codtrib,    "C")
            THIS.this_nIssqn      = TratarNulo(issqn,      "N")
            THIS.this_cItemls     = TratarNulo(itemls,     "C")
            THIS.this_cNatope     = TratarNulo(natope,     "C")
            THIS.this_cClfiscals  = TratarNulo(clfiscals,  "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT geral com filtro opcional
    * par_cFiltro: string WHERE extra (vazio = todos)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.grupos, a.ests, a.icms," + ;
                       " a.tpicms, a.tptribs, a.ordicms, a.sittricms," + ;
                       " a.cfops, a.codtrib, a.issqn, a.itemls," + ;
                       " a.natope, a.clfiscals" + ;
                       " FROM SIGCDCFI a"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.grupos, a.ests, a.tpicms"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros de ICMS Cupom Fiscal:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela PK (cidchaves)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidchaves)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.grupos, a.ests, a.icms," + ;
                       " a.tpicms, a.tptribs, a.ordicms, a.sittricms," + ;
                       " a.cfops, a.codtrib, a.issqn, a.itemls," + ;
                       " a.natope, a.clfiscals" + ;
                       " FROM SIGCDCFI a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Valida unicidade por grupos+ests+clfiscals
    *--------------------------------------------------------------------------
    FUNCTION VerificarDuplicidade()
    *--------------------------------------------------------------------------
        LOCAL loc_lDuplicado, loc_cSQL, loc_nResult
        loc_lDuplicado = .F.

        TRY
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SIGCDCFI" + ;
                       " WHERE grupos = " + EscaparSQL(THIS.this_cGrupos) + ;
                       " AND ests = " + EscaparSQL(THIS.this_cEsts) + ;
                       " AND clfiscals = " + EscaparSQL(THIS.this_cClfiscals)

            IF THIS.this_lNovoRegistro = .F.
                loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(THIS.this_cCidchaves)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dup")
                TABLEREVERT(.T., "cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")

            IF loc_nResult >= 0
                SELECT cursor_4c_Dup
                loc_lDuplicado = (qtd > 0)
            ENDIF

            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.VerificarDuplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cCidchaves = LEFT(SYS(2015), 20)

            IF THIS.VerificarDuplicidade()
                MsgErro("Grupo, Estado e Classifica" + CHR(231) + CHR(227) + "o j" + ;
                        CHR(225) + " cadastrado!", "Duplicidade")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGCDCFI" + ;
                           " (cidchaves, ests, grupos, icms, tpicms, tptribs," + ;
                           "  ordicms, sittricms, cfops, codtrib, issqn," + ;
                           "  itemls, natope, clfiscals)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                           EscaparSQL(THIS.this_cEsts)      + ", " + ;
                           EscaparSQL(THIS.this_cGrupos)    + ", " + ;
                           FormatarNumeroSQL(THIS.this_nIcms)   + ", " + ;
                           EscaparSQL(THIS.this_cTpicms)    + ", " + ;
                           EscaparSQL(THIS.this_cTptribs)   + ", " + ;
                           FormatarNumeroSQL(THIS.this_nOrdicms) + ", " + ;
                           EscaparSQL(THIS.this_cSittricms) + ", " + ;
                           EscaparSQL(THIS.this_cCfops)     + ", " + ;
                           EscaparSQL(THIS.this_cCodtrib)   + ", " + ;
                           FormatarNumeroSQL(THIS.this_nIssqn)  + ", " + ;
                           EscaparSQL(THIS.this_cItemls)    + ", " + ;
                           EscaparSQL(THIS.this_cNatope)    + ", " + ;
                           EscaparSQL(THIS.this_cClfiscals) + ")"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao incluir ICMS Cupom Fiscal:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF THIS.VerificarDuplicidade()
                MsgErro("Grupo, Estado e Classifica" + CHR(231) + CHR(227) + "o j" + ;
                        CHR(225) + " cadastrado!", "Duplicidade")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "UPDATE SIGCDCFI SET" + ;
                           " ests      = " + EscaparSQL(THIS.this_cEsts)      + "," + ;
                           " grupos    = " + EscaparSQL(THIS.this_cGrupos)    + "," + ;
                           " icms      = " + FormatarNumeroSQL(THIS.this_nIcms)   + "," + ;
                           " tpicms    = " + EscaparSQL(THIS.this_cTpicms)    + "," + ;
                           " tptribs   = " + EscaparSQL(THIS.this_cTptribs)   + "," + ;
                           " ordicms   = " + FormatarNumeroSQL(THIS.this_nOrdicms) + "," + ;
                           " sittricms = " + EscaparSQL(THIS.this_cSittricms) + "," + ;
                           " cfops     = " + EscaparSQL(THIS.this_cCfops)     + "," + ;
                           " codtrib   = " + EscaparSQL(THIS.this_cCodtrib)   + "," + ;
                           " issqn     = " + FormatarNumeroSQL(THIS.this_nIssqn)  + "," + ;
                           " itemls    = " + EscaparSQL(THIS.this_cItemls)    + "," + ;
                           " natope    = " + EscaparSQL(THIS.this_cNatope)    + "," + ;
                           " clfiscals = " + EscaparSQL(THIS.this_cClfiscals) + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao atualizar ICMS Cupom Fiscal:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDCFI" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir ICMS Cupom Fiscal:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em cfiBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
