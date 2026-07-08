*==============================================================================
* sigpdmp6BO.prg - Business Object para Movimentacao de Industria
* Tabela principal: SigCdNec | PK: cidchaves (char 20, gerado por fUniqueIds)
* Chave composta: empdnps = emps(3) + dopps(20) + str(numps,10) -> char(33)
*==============================================================================

DEFINE CLASS sigpdmp6BO AS BusinessBase

    *-- Identificacao e Chave
    this_cCidChaves  = ""    && cidchaves  CHAR(20) - PK (gerado por fUniqueIds)
    this_cEmpDnPs    = ""    && empdnps    CHAR(33) - Chave composta (emps+dopps+str(numps,10))

    *-- Campos da chave composta
    this_cEmps       = ""    && emps       CHAR(3)  - Empresa
    this_cDopps      = ""    && dopps      CHAR(20) - Codigo da operacao/documento
    this_nNumps      = 0     && numps      NUMERIC(10,0) - Numero do movimento

    *-- Datas
    this_tDatars     = {}    && datars     DATETIME - Data/hora do registro
    this_dDatas      = {}    && datas      DATETIME - Data do movimento
    this_tDataTrans  = {}    && datatrans  DATETIME - Data de transferencia

    *-- Origem
    this_cGrupoos    = ""    && grupoos    CHAR(10) - Grupo de conta corrente de origem
    this_cContaos    = ""    && contaos    CHAR(10) - Conta de origem

    *-- Destino
    this_cGrupods    = ""    && grupods    CHAR(10) - Grupo de conta corrente de destino
    this_cContads    = ""    && contads    CHAR(10) - Conta de destino
    this_cEmpds      = ""    && empds      CHAR(3)  - Empresa de destino

    *-- Vendedor
    this_cGrVends    = ""    && grvends    CHAR(10) - Grupo do vendedor
    this_cVends      = ""    && vends      CHAR(10) - Vendedor

    *-- Pesos e Totais
    this_nTotPesos   = 0     && totpesos   NUMERIC(11,3) - Peso total
    this_nPesoLancs  = 0     && pesolancs  NUMERIC(11,3) - Peso lancado

    *-- Lotes e OPs
    this_nNLotes     = 0     && nlotes     NUMERIC(10,0) - Numero do lote (0=sem lote)
    this_nNAceites   = 0     && naceites   NUMERIC(10,0) - Numero de aceites
    this_nNops       = 0     && nops       NUMERIC(10,0) - Numero da OP

    *-- Transacao e Local
    this_nNTrans     = 0     && ntrans     NUMERIC(6,0)  - Numero de transacao
    this_cLocals     = ""    && locals     CHAR(10) - Local
    this_cJobs       = ""    && jobs       CHAR(10) - Job

    *-- Documento e Observacao
    this_cDocus      = ""    && docus      CHAR(10) - Numero do documento
    this_nCodObs     = 0     && codobs     NUMERIC(3,0) - Codigo de observacao
    this_cObss       = ""    && obss       TEXT     - Texto de observacao

    *-- Nao Conformidade
    this_lNConforms  = .F.   && nconforms  BIT      - Nao conforme (flag)
    this_cCodNConfs  = ""    && codnconfs  CHAR(10) - Codigo de nao conformidade

    *-- Balancos
    this_nNumBals    = 0     && numbals    NUMERIC(6,0) - Numero do balanco
    this_nNumBalds   = 0     && numbalds   NUMERIC(6,0) - Numero do balanco destino

    *-- Usuarios
    this_cUsuars     = ""    && usuars     CHAR(10) - Usuario que lancou
    this_cUsuLibs    = ""    && usulibs    CHAR(10) - Usuario que liberou
    this_cUsuConfs   = ""    && usuconfs   CHAR(10) - Usuario que confirmou

    *-- Flags bit
    this_lRetrabs    = .F.   && retrabs    BIT - Retrabalho
    this_lChksubn    = .F.   && chksubn    BIT - Subnivel/lote fechado
    this_lProcbals   = .F.   && procbals   BIT - Processado no balancete
    this_lProcdbal   = .F.   && procdbal   BIT - Processado no balancete 2
    this_lImprs      = .F.   && imprs      BIT - Impresso
    this_lAutos      = .F.   && autos      BIT - Processamento automatico
    this_lLccs       = .F.   && lccs       BIT - LCC (Lote Controle Cliente)
    this_nChkBaixa   = 0     && chkbaixa   NUMERIC(1,0) - Flag baixa

    *-- Liberacao (char, nao bit)
    this_cLibProds   = ""    && libprods   CHAR(10) - Liberado para producao

    *-- Descricoes lookup (nao armazenadas)
    this_cNomeContaOs  = ""  && Nome da conta de origem (lookup SigCdCli)
    this_cNomeContads  = ""  && Nome da conta de destino (lookup SigCdCli)
    this_cNomeVends    = ""  && Nome do vendedor (lookup SigCdCli)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdNec"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cEmpDnPs    = TratarNulo(empdnps,    "C")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cDopps      = TratarNulo(dopps,      "C")
                THIS.this_nNumps      = TratarNulo(numps,      "N")
                THIS.this_dDatas      = TratarNulo(datas,      "D")
                THIS.this_tDatars     = TratarNulo(datars,     "T")
                THIS.this_tDataTrans  = TratarNulo(datatrans,  "T")
                THIS.this_cGrupoos    = TratarNulo(grupoos,    "C")
                THIS.this_cContaos    = TratarNulo(contaos,    "C")
                THIS.this_cGrupods    = TratarNulo(grupods,    "C")
                THIS.this_cContads    = TratarNulo(contads,    "C")
                THIS.this_cEmpds      = TratarNulo(empds,      "C")
                THIS.this_cGrVends    = TratarNulo(grvends,    "C")
                THIS.this_cVends      = TratarNulo(vends,      "C")
                THIS.this_nTotPesos   = TratarNulo(totpesos,   "N")
                THIS.this_nPesoLancs  = TratarNulo(pesolancs,  "N")
                THIS.this_nNLotes     = TratarNulo(nlotes,     "N")
                THIS.this_nNAceites   = TratarNulo(naceites,   "N")
                THIS.this_nNops       = TratarNulo(nops,       "N")
                THIS.this_nNTrans     = TratarNulo(ntrans,     "N")
                THIS.this_cLocals     = TratarNulo(locals,     "C")
                THIS.this_cJobs       = TratarNulo(jobs,       "C")
                THIS.this_cDocus      = TratarNulo(docus,      "C")
                THIS.this_nCodObs     = TratarNulo(codobs,     "N")
                THIS.this_cObss       = TratarNulo(obss,       "C")
                THIS.this_lNConforms  = ConverterParaLogico(nconforms)
                THIS.this_cCodNConfs  = TratarNulo(codnconfs,  "C")
                THIS.this_nNumBals    = TratarNulo(numbals,    "N")
                THIS.this_nNumBalds   = TratarNulo(numbalds,   "N")
                THIS.this_cUsuars     = TratarNulo(usuars,     "C")
                THIS.this_cUsuLibs    = TratarNulo(usulibs,    "C")
                THIS.this_cUsuConfs   = TratarNulo(usuconfs,   "C")
                THIS.this_lRetrabs    = ConverterParaLogico(retrabs)
                THIS.this_lChksubn    = ConverterParaLogico(chksubn)
                THIS.this_lProcbals   = ConverterParaLogico(procbals)
                THIS.this_lProcdbal   = ConverterParaLogico(procdbal)
                THIS.this_lImprs      = ConverterParaLogico(imprs)
                THIS.this_lAutos      = ConverterParaLogico(autos)
                THIS.this_lLccs       = ConverterParaLogico(lccs)
                THIS.this_nChkBaixa   = TratarNulo(chkbaixa,  "N")
                THIS.this_cLibProds   = TratarNulo(libprods,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentos em cursor_4c_Dados
    * par_cFiltro: clausula WHERE sem a palavra WHERE (vazio = sem filtro)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.cidchaves, n.empdnps, n.emps, n.dopps, n.numps," + ;
                       " n.datas, n.datars, n.grupoos, n.contaos, n.grupods, n.contads," + ;
                       " n.grvends, n.vends, n.usuars, n.codobs, n.docus, n.nlotes," + ;
                       " n.naceites, n.nops, n.totpesos, n.pesolancs," + ;
                       " n.retrabs, n.chksubn, n.nconforms, n.imprs, n.autos," + ;
                       " n.lccs, n.libprods, n.codnconfs, n.jobs, n.locals," + ;
                       " n.empds, n.chkbaixa" + ;
                       " FROM SigCdNec n"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY n.datas DESC, n.numps DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos de ind" + CHR(250) + "stria:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorPeriodo - Busca movimentos por empresa, operacao e periodo
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorPeriodo(par_cEmps, par_cDopp, par_dDtI, par_dDtF)
        LOCAL loc_cFiltro, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cFiltro = "n.emps = " + EscaparSQL(par_cEmps)

            IF !EMPTY(ALLTRIM(par_cDopp))
                loc_cFiltro = loc_cFiltro + " AND n.dopps = " + EscaparSQL(par_cDopp)
            ENDIF

            IF !EMPTY(par_dDtI)
                loc_cFiltro = loc_cFiltro + " AND CONVERT(date, n.datas) >= " + ;
                    "CONVERT(date, " + FormatarDataSQL(par_dDtI) + ")"
            ENDIF

            IF !EMPTY(par_dDtF)
                loc_cFiltro = loc_cFiltro + " AND CONVERT(date, n.datas) <= " + ;
                    "CONVERT(date, " + FormatarDataSQL(par_dDtF) + ")"
            ENDIF

            loc_lSucesso = THIS.Buscar(loc_cFiltro)

        CATCH TO loc_oErro
            MsgErro("Erro em BuscarPorPeriodo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT n.cidchaves, n.empdnps, n.emps, n.dopps, n.numps," + ;
                       " n.datas, n.datars, n.datatrans, n.grupoos, n.contaos," + ;
                       " n.grupods, n.contads, n.empds, n.grvends, n.vends," + ;
                       " n.usuars, n.codobs, n.obss, n.docus, n.nlotes, n.naceites," + ;
                       " n.nops, n.ntrans, n.locals, n.jobs, n.totpesos, n.pesolancs," + ;
                       " n.retrabs, n.chksubn, n.nconforms, n.codnconfs," + ;
                       " n.procbals, n.procdbal, n.imprs, n.autos, n.lccs," + ;
                       " n.libprods, n.numbals, n.numbalds," + ;
                       " n.usulibs, n.chkbaixa, n.usuconfs" + ;
                       " FROM SigCdNec n" + ;
                       " WHERE n.cidchaves = " + EscaparSQL(par_cCidChaves)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                IF loc_lSucesso
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorEmpDnPs - Carrega pelo empdnps (chave composta alternativa)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorEmpDnPs(par_cEmpDnPs)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cCidChaves
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdNec WHERE empdnps = " + ;
                       EscaparSQL(par_cEmpDnPs)

            IF USED("cursor_4c_ChaveBusca")
                USE IN cursor_4c_ChaveBusca
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChaveBusca")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChaveBusca") > 0
                SELECT cursor_4c_ChaveBusca
                loc_cCidChaves = ALLTRIM(cursor_4c_ChaveBusca.cidchaves)
                IF USED("cursor_4c_ChaveBusca")
                    USE IN cursor_4c_ChaveBusca
                ENDIF
                loc_lSucesso = THIS.CarregarPorCodigo(loc_cCidChaves)
            ELSE
                IF USED("cursor_4c_ChaveBusca")
                    USE IN cursor_4c_ChaveBusca
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorEmpDnPs:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdNec (PROTECTED)
    * Nota: cidchaves deve ser gerado antes (via fUniqueIds ou equivalente)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Monta chave composta empdnps
            THIS.this_cEmpDnPs = PADR(ALLTRIM(THIS.this_cEmps), 3)  + ;
                                  PADR(ALLTRIM(THIS.this_cDopps), 20) + ;
                                  STR(THIS.this_nNumps, 10)

            *-- Usuario logado
            THIS.this_cUsuars = gc_4c_UsuarioLogado

            loc_cSQL = "INSERT INTO SigCdNec" + ;
                       " (cidchaves, empdnps, emps, dopps, numps," + ;
                       "  datas, grupoos, contaos, grupods, contads, empds," + ;
                       "  grvends, vends, usuars, codobs, docus," + ;
                       "  nlotes, naceites, nops, ntrans, locals, jobs," + ;
                       "  totpesos, pesolancs, retrabs, chksubn," + ;
                       "  nconforms, codnconfs, procbals, procdbal," + ;
                       "  imprs, autos, lccs, libprods, chkbaixa)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)            + ", " + ;
                       EscaparSQL(THIS.this_cEmpDnPs)              + ", " + ;
                       EscaparSQL(THIS.this_cEmps)                 + ", " + ;
                       EscaparSQL(THIS.this_cDopps)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps)          + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)            + ", " + ;
                       EscaparSQL(THIS.this_cGrupoos)              + ", " + ;
                       EscaparSQL(THIS.this_cContaos)              + ", " + ;
                       EscaparSQL(THIS.this_cGrupods)              + ", " + ;
                       EscaparSQL(THIS.this_cContads)              + ", " + ;
                       EscaparSQL(THIS.this_cEmpds)                + ", " + ;
                       EscaparSQL(THIS.this_cGrVends)              + ", " + ;
                       EscaparSQL(THIS.this_cVends)                + ", " + ;
                       EscaparSQL(THIS.this_cUsuars)               + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodObs)         + ", " + ;
                       EscaparSQL(THIS.this_cDocus)                + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNLotes)         + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNAceites)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops)           + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNTrans)         + ", " + ;
                       EscaparSQL(THIS.this_cLocals)               + ", " + ;
                       EscaparSQL(THIS.this_cJobs)                 + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotPesos)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesoLancs)      + ", " + ;
                       IIF(THIS.this_lRetrabs,   "1", "0")          + ", " + ;
                       IIF(THIS.this_lChksubn,   "1", "0")          + ", " + ;
                       IIF(THIS.this_lNConforms, "1", "0")          + ", " + ;
                       EscaparSQL(THIS.this_cCodNConfs)            + ", " + ;
                       IIF(THIS.this_lProcbals,  "1", "0")          + ", " + ;
                       IIF(THIS.this_lProcdbal,  "1", "0")          + ", " + ;
                       IIF(THIS.this_lImprs,     "1", "0")          + ", " + ;
                       IIF(THIS.this_lAutos,     "1", "0")          + ", " + ;
                       IIF(THIS.this_lLccs,      "1", "0")          + ", " + ;
                       EscaparSQL(THIS.this_cLibProds)             + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkBaixa)       + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Salvar obss (TEXT) separadamente se preenchido
                IF !EMPTY(ALLTRIM(THIS.this_cObss))
                    THIS.AtualizarObss()
                ENDIF
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdNec (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET" + ;
                       "  datas     = " + FormatarDataSQL(THIS.this_dDatas)    + ", " + ;
                       "  grupoos   = " + EscaparSQL(THIS.this_cGrupoos)       + ", " + ;
                       "  contaos   = " + EscaparSQL(THIS.this_cContaos)       + ", " + ;
                       "  grupods   = " + EscaparSQL(THIS.this_cGrupods)       + ", " + ;
                       "  contads   = " + EscaparSQL(THIS.this_cContads)       + ", " + ;
                       "  empds     = " + EscaparSQL(THIS.this_cEmpds)         + ", " + ;
                       "  grvends   = " + EscaparSQL(THIS.this_cGrVends)       + ", " + ;
                       "  vends     = " + EscaparSQL(THIS.this_cVends)         + ", " + ;
                       "  codobs    = " + FormatarNumeroSQL(THIS.this_nCodObs) + ", " + ;
                       "  docus     = " + EscaparSQL(THIS.this_cDocus)         + ", " + ;
                       "  nlotes    = " + FormatarNumeroSQL(THIS.this_nNLotes) + ", " + ;
                       "  naceites  = " + FormatarNumeroSQL(THIS.this_nNAceites) + ", " + ;
                       "  nops      = " + FormatarNumeroSQL(THIS.this_nNops)   + ", " + ;
                       "  totpesos  = " + FormatarNumeroSQL(THIS.this_nTotPesos) + ", " + ;
                       "  pesolancs = " + FormatarNumeroSQL(THIS.this_nPesoLancs) + ", " + ;
                       "  retrabs   = " + IIF(THIS.this_lRetrabs, "1", "0")   + ", " + ;
                       "  chksubn   = " + IIF(THIS.this_lChksubn, "1", "0")   + ", " + ;
                       "  nconforms = " + IIF(THIS.this_lNConforms, "1", "0") + ", " + ;
                       "  codnconfs = " + EscaparSQL(THIS.this_cCodNConfs)    + ", " + ;
                       "  imprs     = " + IIF(THIS.this_lImprs, "1", "0")     + ", " + ;
                       "  autos     = " + IIF(THIS.this_lAutos, "1", "0")     + ", " + ;
                       "  lccs      = " + IIF(THIS.this_lLccs, "1", "0")      + ", " + ;
                       "  libprods  = " + EscaparSQL(THIS.this_cLibProds)     + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Atualizar obss (TEXT) separadamente
                THIS.AtualizarObss()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarObss - Salva campo TEXT obss separadamente
    * Campos TEXT/NTEXT exigem UPDATE separado em alguns cenarios ODBC
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarObss()
        LOCAL loc_cSQL, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET obss = " + EscaparSQL(THIS.this_cObss) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar observa" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdNec (PROTECTED)
    * Exclui apenas o cabecalho. A logica do form deve excluir SigCdNei,
    * SigMvHst, SigMvCab e demais tabelas filhas antes de chamar Excluir().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir itens do movimento (SigCdNei) antes do cabecalho
            loc_cSQL = "DELETE FROM SigCdNei WHERE empdnps = " + EscaparSQL(THIS.this_cEmpDnPs)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens do movimento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir cabecalho
                loc_cSQL = "DELETE FROM SigCdNec WHERE cidchaves = " + ;
                           EscaparSQL(THIS.this_cCidChaves)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir movimento:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
