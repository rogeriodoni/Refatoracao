*==============================================================================
* PGRBO.prg - Business Object para Pagamentos e Recebimentos
*==============================================================================
* Tabela   : SigCdPgr
* PK real  : cidchaves (CHAR 20, gerado por fUniqueIds)
* Chave neg: empdopnums = emps + dopes + PADL(STR(numes),6)
* Herda de : BusinessBase (app\classes\businessbase.prg)
*
* Fases 1-2/8 - Propriedades, Init, CRUD:
*   Buscar, CarregarPorCodigo, CarregarDoCursor,
*   Inserir, Atualizar, ExecutarExclusao
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS PGRBO AS BusinessBase

    *==========================================================================
    *-- PROPRIEDADES DA TABELA SigCdPgr (schema exato)
    *==========================================================================

    *-- Chave primaria real e chave de negocio derivada
    this_cCidChaves  = ""    && cidchaves  CHAR(20)   - PK (fUniqueIds)
    this_cEmpDopNums = ""    && empdopnums CHAR(29)   - emps+dopes+padl(numes,6)

    *-- Chave de negocio composta: Emps + Dopes + Numes
    this_cEmps       = ""    && emps       CHAR(3)    - Empresa
    this_cDopes      = ""    && dopes      CHAR(20)   - Tipo de Operacao
    this_nNumes      = 0     && numes      NUM(6,0)   - Numero sequencial
    this_cMascNum    = ""    && mascnum    CHAR(6)    - Mascara de numero exibida

    *-- Datas (nullable)
    this_tDataRcs    = {}    && datarcs    DATETIME NULL - Data lancamento/recebimento
    this_tDataLims   = {}    && datalims   DATETIME NULL - Data limite do periodo
    this_tDataTrans  = {}    && datatrans  DATETIME NULL - Data da transacao

    *-- Contabil e localizacao
    this_cGrupos     = ""    && grupos     CHAR(10)   - Grupo contabil
    this_cContas     = ""    && contas     CHAR(10)   - Conta contabil
    this_cLocals     = ""    && locals     CHAR(10)   - Localizacao

    *-- Usuario e controle
    this_cUsuars     = ""    && usuars     CHAR(10)   - Usuario de inclusao
    this_nNTrans     = 0     && ntrans     NUM(6,0)   - Numero de transacao

    *-- Flags de status (BIT -> logical)
    this_lAutos      = .F.   && autos      BIT        - Automatico (baixa automatica)
    this_lConcs      = .F.   && concs      BIT        - Conciliado com extrato bancario

    *-- Configuracoes numericas
    this_nPgUnicos   = 0     && pgunicos   NUM(1,0)   - Pagamento unico (1=sim)
    this_nCNotas     = 0     && cnotas     NUM(1,0)   - Config notas fiscais
    this_nPJuros     = 0     && pjuros     NUM(4,2)   - Percentual de juros
    this_nPMulta     = 0     && pmulta     NUM(4,2)   - Percentual de multa

    *-- Texto livre
    this_cObs        = ""    && obs        TEXT       - Observacoes do lancamento

    *-- Propriedades de runtime (nao persistidas na tabela)
    this_cTipo       = ""    && D=Debito (pagamento) / C=Credito (recebimento)
    this_cJustDel    = ""    && Justificativa de cancelamento/exclusao

    *==========================================================================
    *-- INICIALIZACAO
    *==========================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPgr"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PGRBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- AUDITORIA: retorna PK real para RegistrarAuditoria()
    *==========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *==========================================================================
    *-- BUSCAR - SELECT lista no cursor_4c_Dados
    *-- par_cFiltro: condicao WHERE (sem a palavra WHERE) ou "" para todos
    *==========================================================================

    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT cidchaves, numes, mascnum, datarcs, grupos, contas," + ;
                           " usuars, emps," + ;
                           " SUBSTRING(CAST(obs AS VARCHAR(8000)),1,40) AS obs," + ;
                           " dopes, empdopnums" + ;
                           " FROM SigCdPgr" + ;
                           " ORDER BY datarcs DESC, numes DESC"
            ELSE
                loc_cSQL = "SELECT cidchaves, numes, mascnum, datarcs, grupos, contas," + ;
                           " usuars, emps," + ;
                           " SUBSTRING(CAST(obs AS VARCHAR(8000)),1,40) AS obs," + ;
                           " dopes, empdopnums" + ;
                           " FROM SigCdPgr" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY datarcs DESC, numes DESC"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar Pagamentos e Recebimentos:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PGRBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    *-- CARREGAR POR CODIGO - Carrega registro pelo cidchaves (PK real)
    *==========================================================================

    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cidchaves, empdopnums, emps, dopes, numes, mascnum," + ;
                       " datarcs, datalims, datatrans, grupos, contas, locals," + ;
                       " usuars, ntrans, autos, concs, pgunicos, cnotas, pjuros, pmulta," + ;
                       " CAST(obs AS VARCHAR(8000)) AS obs" + ;
                       " FROM SigCdPgr" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar Pagamento/Recebimento:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PGRBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    *-- CARREGAR DO CURSOR - Copia campos do cursor para propriedades do BO
    *-- Usa {} como default para campos datetime NULLaveis (nao "T" - causa erro)
    *==========================================================================

    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves   = TratarNulo(cidchaves,  "")
                THIS.this_cEmpDopNums  = TratarNulo(empdopnums, "")
                THIS.this_cEmps        = TratarNulo(emps,       "")
                THIS.this_cDopes       = TratarNulo(dopes,      "")
                THIS.this_nNumes       = TratarNulo(numes,      0)
                THIS.this_cMascNum     = TratarNulo(mascnum,    "")
                THIS.this_tDataRcs     = TratarNulo(datarcs,    {})
                THIS.this_tDataLims    = TratarNulo(datalims,   {})
                THIS.this_tDataTrans   = TratarNulo(datatrans,  {})
                THIS.this_cGrupos      = TratarNulo(grupos,     "")
                THIS.this_cContas      = TratarNulo(contas,     "")
                THIS.this_cLocals      = TratarNulo(locals,     "")
                THIS.this_cUsuars      = TratarNulo(usuars,     "")
                THIS.this_nNTrans      = TratarNulo(ntrans,     0)
                THIS.this_lAutos       = (TratarNulo(autos,     0) <> 0)
                THIS.this_lConcs       = (TratarNulo(concs,     0) <> 0)
                THIS.this_nPgUnicos    = TratarNulo(pgunicos,   0)
                THIS.this_nCNotas      = TratarNulo(cnotas,     0)
                THIS.this_nPJuros      = TratarNulo(pjuros,     0)
                THIS.this_nPMulta      = TratarNulo(pmulta,     0)
                THIS.this_cObs         = TratarNulo(obs,        "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PGRBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    *-- INSERIR - INSERT INTO SigCdPgr
    *-- Gera cidchaves via fUniqueIds() e numes via ObterProxNumes()
    *==========================================================================

    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves  = fUniqueIds()
            THIS.this_nNumes      = THIS.ObterProxNumes(THIS.this_cEmps, THIS.this_cDopes)
            THIS.this_cMascNum    = PADL(TRANSFORM(THIS.this_nNumes), 6, "0")
            THIS.this_cEmpDopNums = ALLTRIM(THIS.this_cEmps) + ;
                                    ALLTRIM(THIS.this_cDopes) + ;
                                    PADL(TRANSFORM(THIS.this_nNumes), 6, "0")
            THIS.this_cUsuars     = gc_4c_UsuarioLogado

            loc_cSQL = "INSERT INTO SigCdPgr" + ;
                " (cidchaves, empdopnums, emps, dopes, numes, mascnum," + ;
                "  datarcs, datalims, datatrans, grupos, contas, locals," + ;
                "  usuars, ntrans, autos, concs, pgunicos, cnotas, pjuros, pmulta, obs)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)           + ", " + ;
                EscaparSQL(THIS.this_cEmpDopNums)          + ", " + ;
                EscaparSQL(THIS.this_cEmps)                + ", " + ;
                EscaparSQL(THIS.this_cDopes)               + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes)        + ", " + ;
                EscaparSQL(THIS.this_cMascNum)             + ", " + ;
                FormatarDataSQL(THIS.this_tDataRcs)        + ", " + ;
                FormatarDataSQL(THIS.this_tDataLims)       + ", " + ;
                FormatarDataSQL(THIS.this_tDataTrans)      + ", " + ;
                EscaparSQL(THIS.this_cGrupos)              + ", " + ;
                EscaparSQL(THIS.this_cContas)              + ", " + ;
                EscaparSQL(THIS.this_cLocals)              + ", " + ;
                EscaparSQL(THIS.this_cUsuars)              + ", " + ;
                FormatarNumeroSQL(THIS.this_nNTrans)       + ", " + ;
                IIF(THIS.this_lAutos, "1", "0")            + ", " + ;
                IIF(THIS.this_lConcs, "1", "0")            + ", " + ;
                FormatarNumeroSQL(THIS.this_nPgUnicos)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nCNotas)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nPJuros)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nPMulta)       + ", " + ;
                EscaparSQL(THIS.this_cObs)                 + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir Pagamento/Recebimento:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PGRBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    *-- ATUALIZAR - UPDATE SigCdPgr WHERE cidchaves = ...
    *==========================================================================

    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cEmpDopNums = ALLTRIM(THIS.this_cEmps) + ;
                                    ALLTRIM(THIS.this_cDopes) + ;
                                    PADL(TRANSFORM(THIS.this_nNumes), 6, "0")

            loc_cSQL = "UPDATE SigCdPgr SET" + ;
                " empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)       + ", " + ;
                " datarcs    = " + FormatarDataSQL(THIS.this_tDataRcs)     + ", " + ;
                " datalims   = " + FormatarDataSQL(THIS.this_tDataLims)    + ", " + ;
                " datatrans  = " + FormatarDataSQL(THIS.this_tDataTrans)   + ", " + ;
                " grupos     = " + EscaparSQL(THIS.this_cGrupos)           + ", " + ;
                " contas     = " + EscaparSQL(THIS.this_cContas)           + ", " + ;
                " locals     = " + EscaparSQL(THIS.this_cLocals)           + ", " + ;
                " ntrans     = " + FormatarNumeroSQL(THIS.this_nNTrans)    + ", " + ;
                " autos      = " + IIF(THIS.this_lAutos, "1", "0")        + ", " + ;
                " concs      = " + IIF(THIS.this_lConcs, "1", "0")        + ", " + ;
                " pgunicos   = " + FormatarNumeroSQL(THIS.this_nPgUnicos)  + ", " + ;
                " cnotas     = " + FormatarNumeroSQL(THIS.this_nCNotas)    + ", " + ;
                " pjuros     = " + FormatarNumeroSQL(THIS.this_nPJuros)    + ", " + ;
                " pmulta     = " + FormatarNumeroSQL(THIS.this_nPMulta)    + ", " + ;
                " obs        = " + EscaparSQL(THIS.this_cObs)              + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar Pagamento/Recebimento:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PGRBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    *-- EXECUTAR EXCLUSAO - DELETE FROM SigCdPgr WHERE cidchaves = ...
    *-- Chamado por Excluir() no BusinessBase (nao chamar diretamente)
    *-- Nota: validacoes de relacionamentos (SigCdPgc, SigMvCcr) ficam no form
    *==========================================================================

    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPgr" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir Pagamento/Recebimento:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PGRBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    *-- OBTER PROX NUMES - Calcula proximo numes para emps+dopes
    *-- Consulta MAX(numes)+1 no banco para garantir unicidade por operacao
    *==========================================================================

    PROTECTED FUNCTION ObterProxNumes(par_cEmps, par_cDopes)
        LOCAL loc_cSQL, loc_nResult, loc_nNumes
        loc_nNumes = 1

        TRY
            IF USED("cursor_4c_MaxNumes")
                USE IN cursor_4c_MaxNumes
            ENDIF

            loc_cSQL = "SELECT ISNULL(MAX(numes), 0) + 1 AS proxnumes" + ;
                       " FROM SigCdPgr" + ;
                       " WHERE emps  = " + EscaparSQL(par_cEmps)  + ;
                       " AND   dopes = " + EscaparSQL(par_cDopes)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxNumes")

            IF loc_nResult > 0 AND !EOF("cursor_4c_MaxNumes")
                loc_nNumes = cursor_4c_MaxNumes.proxnumes
            ENDIF

            IF USED("cursor_4c_MaxNumes")
                USE IN cursor_4c_MaxNumes
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em PGRBO.ObterProxNumes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nNumes
    ENDFUNC

ENDDEFINE
