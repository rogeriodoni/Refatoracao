*==============================================================================
* sigpdmp7BO.prg - Business Object para Movimentacao por Funcionario
* Tabela principal: SigCdNec | PK: cidchaves
* Chave de negocio: empdnps (emps + dopps + str(numps,10))
*==============================================================================

DEFINE CLASS sigpdmp7BO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SigCdNec)
    *-- Identificacao / chaves
    this_cCidchaves  = ""   && cidchaves CHAR(20)   - PK do sistema
    this_cEmpdnps    = ""   && empdnps   CHAR(33)   - Chave de negocio (emps+dopps+numps)
    this_cEmps       = ""   && emps      CHAR(3)    - Empresa
    this_cEmpds      = ""   && empds     CHAR(3)    - Empresa destino
    this_cDopps      = ""   && dopps     CHAR(20)   - Operacao
    this_nNumps      = 0    && numps     NUMERIC(10)- Numero do processo

    *-- Datas
    this_dDatas      = {}   && datas     DATETIME   - Data da movimentacao
    this_dDatars     = {}   && datars    DATETIME   - Data de registro
    this_dDatatrans  = {}   && datatrans DATETIME   - Data da transacao

    *-- Totais e pesos
    this_nTotpesos   = 0    && totpesos  NUMERIC(11,3) - Total de pesos
    this_nPesolancs  = 0    && pesolancs NUMERIC(11,3) - Peso lancado

    *-- Grupos e contas - Origem
    this_cGrupoos    = ""   && grupoos   CHAR(10)   - Grupo de Origem
    this_cContaos    = ""   && contaos   CHAR(10)   - Conta de Origem

    *-- Grupos e contas - Destino
    this_cGrupods    = ""   && grupods   CHAR(10)   - Grupo de Destino
    this_cContads    = ""   && contads   CHAR(10)   - Conta de Destino

    *-- Responsavel/Vendedor
    this_cGrvends    = ""   && grvends   CHAR(10)   - Grupo do responsavel
    this_cVends      = ""   && vends     CHAR(10)   - Vendedor/Responsavel

    *-- Observacao
    this_cObss       = ""   && obss      TEXT       - Observacao

    *-- Usuario
    this_cUsuars     = ""   && usuars    CHAR(10)   - Usuario lancamento
    this_cUsulibs    = ""   && usulibs   CHAR(10)   - Usuario liberacao
    this_cUsuconfs   = ""   && usuconfs  CHAR(10)   - Usuario confirmacao

    *-- Documentos e localidade
    this_cDocus      = ""   && docus     CHAR(10)   - Documento
    this_cLocals     = ""   && locals    CHAR(10)   - Local
    this_cJobs       = ""   && jobs      CHAR(10)   - Job
    this_cCodnconfs  = ""   && codnconfs CHAR(10)   - Codigo nao conformidade
    this_cLibprods   = ""   && libprods  CHAR(10)   - Liberacao producao

    *-- Contadores numericos
    this_nNtrans     = 0    && ntrans    NUMERIC(6) - Numero transacao
    this_nNops       = 0    && nops      NUMERIC(10)- Numero de operacoes
    this_nNaceites   = 0    && naceites  NUMERIC(10)- Numero de aceites
    this_nNumbalds   = 0    && numbalds  NUMERIC(6) - Numero balancete dest
    this_nNumbals    = 0    && numbals   NUMERIC(6) - Numero balancete orig
    this_nCodobs     = 0    && codobs    NUMERIC(3) - Codigo observacao
    this_nNlotes     = 0    && nlotes    NUMERIC(10)- Numero do lote
    this_nChkbaixa   = 0    && chkbaixa  NUMERIC(1) - Check baixa

    *-- Flags logicos (bit)
    this_lChksubn    = .F.  && chksubn   BIT        - Check sub-numero
    this_lImprs      = .F.  && imprs     BIT        - Impresso
    this_lLccs       = .F.  && lccs      BIT        - LCC
    this_lProcbals   = .F.  && procbals  BIT        - Processado balanco orig
    this_lProcdbal   = .F.  && procdbal  BIT        - Processado balanco dest
    this_lRetrabs    = .F.  && retrabs   BIT        - Retrabalho
    this_lAutos      = .F.  && autos     BIT        - Automatico
    this_lNconforms  = .F.  && nconforms BIT        - Nao conformidade

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro("Erro ao inicializar sigpdmp7BO: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarChaveComposta - Calcula empdnps a partir dos componentes
    *--------------------------------------------------------------------------
    FUNCTION MontarChaveComposta()
        LOCAL loc_cChave
        loc_cChave = PADR(ALLTRIM(THIS.this_cEmps),  3) + ;
                     PADR(ALLTRIM(THIS.this_cDopps), 20) + ;
                     STR(THIS.this_nNumps, 10)
        THIS.this_cEmpdnps = loc_cChave
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir do cursor informado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            *-- Chave primaria e chave composta
            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "")
            THIS.this_cEmpdnps    = TratarNulo(empdnps,    "")
            THIS.this_cEmps       = TratarNulo(emps,       "")
            THIS.this_cEmpds      = TratarNulo(empds,      "")
            THIS.this_cDopps      = TratarNulo(dopps,      "")
            THIS.this_nNumps      = TratarNulo(numps,       0)

            *-- Datas (SQLEXEC retorna DateTime)
            THIS.this_dDatas     = IIF(VARTYPE(datas)     = "T", TTOD(datas),     TratarNulo(datas,     {}))
            THIS.this_dDatars    = IIF(VARTYPE(datars)    = "T", TTOD(datars),    TratarNulo(datars,    {}))
            THIS.this_dDatatrans = IIF(VARTYPE(datatrans) = "T", TTOD(datatrans), TratarNulo(datatrans, {}))

            *-- Totais
            THIS.this_nTotpesos   = TratarNulo(totpesos,   0)
            THIS.this_nPesolancs  = TratarNulo(pesolancs,  0)

            *-- Origem
            THIS.this_cGrupoos    = TratarNulo(grupoos,    "")
            THIS.this_cContaos    = TratarNulo(contaos,    "")

            *-- Destino
            THIS.this_cGrupods    = TratarNulo(grupods,    "")
            THIS.this_cContads    = TratarNulo(contads,    "")

            *-- Responsavel
            THIS.this_cGrvends    = TratarNulo(grvends,    "")
            THIS.this_cVends      = TratarNulo(vends,      "")

            *-- Observacao (campo text/memo)
            THIS.this_cObss       = TratarNulo(obss,       "")

            *-- Usuarios
            THIS.this_cUsuars     = TratarNulo(usuars,     "")
            THIS.this_cUsulibs    = TratarNulo(usulibs,    "")
            THIS.this_cUsuconfs   = TratarNulo(usuconfs,   "")

            *-- Documentos e localidade
            THIS.this_cDocus      = TratarNulo(docus,      "")
            THIS.this_cLocals     = TratarNulo(locals,     "")
            THIS.this_cJobs       = TratarNulo(jobs,       "")
            THIS.this_cCodnconfs  = TratarNulo(codnconfs,  "")
            THIS.this_cLibprods   = TratarNulo(libprods,   "")

            *-- Contadores numericos
            THIS.this_nNtrans     = TratarNulo(ntrans,      0)
            THIS.this_nNops       = TratarNulo(nops,        0)
            THIS.this_nNaceites   = TratarNulo(naceites,    0)
            THIS.this_nNumbalds   = TratarNulo(numbalds,    0)
            THIS.this_nNumbals    = TratarNulo(numbals,     0)
            THIS.this_nCodobs     = TratarNulo(codobs,      0)
            THIS.this_nNlotes     = TratarNulo(nlotes,      0)
            THIS.this_nChkbaixa   = TratarNulo(chkbaixa,   0)

            *-- Flags logicos (BIT -> LOGICAL)
            THIS.this_lChksubn    = (TratarNulo(chksubn,   0) = 1)
            THIS.this_lImprs      = (TratarNulo(imprs,     0) = 1)
            THIS.this_lLccs       = (TratarNulo(lccs,      0) = 1)
            THIS.this_lProcbals   = (TratarNulo(procbals,  0) = 1)
            THIS.this_lProcdbal   = (TratarNulo(procdbal,  0) = 1)
            THIS.this_lRetrabs    = (TratarNulo(retrabs,   0) = 1)
            THIS.this_lAutos      = (TratarNulo(autos,     0) = 1)
            THIS.this_lNconforms  = (TratarNulo(nconforms, 0) = 1)

            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria cidchaves
    * par_cChave : valor de cidchaves (C20)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, empdnps, emps, empds, dopps, numps," + ;
                       " datas, datars, datatrans," + ;
                       " totpesos, pesolancs," + ;
                       " grupoos, contaos, grupods, contads," + ;
                       " grvends, vends, obss," + ;
                       " usuars, usulibs, usuconfs," + ;
                       " docus, locals, jobs, codnconfs, libprods," + ;
                       " ntrans, nops, naceites, numbalds, numbals," + ;
                       " codobs, nlotes, chkbaixa," + ;
                       " chksubn, imprs, lccs, procbals, procdbal," + ;
                       " retrabs, autos, nconforms" + ;
                       " FROM SigCdNec" + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cChave))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega lista de movimentacoes para cursor_4c_Dados
    * par_cFiltro : filtro livre (emps ou dopps - pode ser vazio)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lSucesso = .F.

        TRY
            loc_cWhere = " WHERE 1=1"

            loc_cSQL = "SELECT cidchaves, empdnps, emps, dopps, numps," + ;
                       " datas, totpesos, usuars," + ;
                       " grupoos, contaos, grupods, contads" + ;
                       " FROM SigCdNec" + ;
                       loc_cWhere + ;
                       " ORDER BY datas DESC, numps DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Dados") > 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar movimenta" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCdNec
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves unico se nao informado
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = LEFT(SYS(2015) + SYS(2015), 20)
            ENDIF

            *-- Montar chave composta
            THIS.MontarChaveComposta()

            *-- Usuario logado
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdNec (" + ;
                       "cidchaves, empdnps, emps, empds, dopps, numps," + ;
                       " datas, datars, datatrans," + ;
                       " totpesos, pesolancs," + ;
                       " grupoos, contaos, grupods, contads," + ;
                       " grvends, vends, obss," + ;
                       " usuars, usulibs, usuconfs," + ;
                       " docus, locals, jobs, codnconfs, libprods," + ;
                       " ntrans, nops, naceites, numbalds, numbals," + ;
                       " codobs, nlotes, chkbaixa," + ;
                       " chksubn, imprs, lccs, procbals, procdbal," + ;
                       " retrabs, autos, nconforms)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpdnps) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(THIS.this_cEmpds) + ", " + ;
                       EscaparSQL(THIS.this_cDopps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatars) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotpesos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesolancs) + ", " + ;
                       EscaparSQL(THIS.this_cGrupoos) + ", " + ;
                       EscaparSQL(THIS.this_cContaos) + ", " + ;
                       EscaparSQL(THIS.this_cGrupods) + ", " + ;
                       EscaparSQL(THIS.this_cContads) + ", " + ;
                       EscaparSQL(THIS.this_cGrvends) + ", " + ;
                       EscaparSQL(THIS.this_cVends) + ", " + ;
                       EscaparSQL(THIS.this_cObss) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       EscaparSQL(THIS.this_cUsulibs) + ", " + ;
                       EscaparSQL(THIS.this_cUsuconfs) + ", " + ;
                       EscaparSQL(THIS.this_cDocus) + ", " + ;
                       EscaparSQL(THIS.this_cLocals) + ", " + ;
                       EscaparSQL(THIS.this_cJobs) + ", " + ;
                       EscaparSQL(THIS.this_cCodnconfs) + ", " + ;
                       EscaparSQL(THIS.this_cLibprods) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNaceites) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumbalds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumbals) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodobs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNlotes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkbaixa) + ", " + ;
                       IIF(THIS.this_lChksubn,  "1", "0") + ", " + ;
                       IIF(THIS.this_lImprs,    "1", "0") + ", " + ;
                       IIF(THIS.this_lLccs,     "1", "0") + ", " + ;
                       IIF(THIS.this_lProcbals, "1", "0") + ", " + ;
                       IIF(THIS.this_lProcdbal, "1", "0") + ", " + ;
                       IIF(THIS.this_lRetrabs,  "1", "0") + ", " + ;
                       IIF(THIS.this_lAutos,    "1", "0") + ", " + ;
                       IIF(THIS.this_lNconforms,"1", "0") + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir movimenta" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigCdNec
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                MostrarErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + "o informada para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ELSE
                *-- Remontar chave composta
                THIS.MontarChaveComposta()

                loc_cSQL = "UPDATE SigCdNec SET " + ;
                           "empdnps    = " + EscaparSQL(THIS.this_cEmpdnps) + ", " + ;
                           "emps       = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                           "empds      = " + EscaparSQL(THIS.this_cEmpds) + ", " + ;
                           "dopps      = " + EscaparSQL(THIS.this_cDopps) + ", " + ;
                           "numps      = " + FormatarNumeroSQL(THIS.this_nNumps) + ", " + ;
                           "datas      = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "datars     = " + FormatarDataSQL(THIS.this_dDatars) + ", " + ;
                           "datatrans  = " + FormatarDataSQL(THIS.this_dDatatrans) + ", " + ;
                           "totpesos   = " + FormatarNumeroSQL(THIS.this_nTotpesos) + ", " + ;
                           "pesolancs  = " + FormatarNumeroSQL(THIS.this_nPesolancs) + ", " + ;
                           "grupoos    = " + EscaparSQL(THIS.this_cGrupoos) + ", " + ;
                           "contaos    = " + EscaparSQL(THIS.this_cContaos) + ", " + ;
                           "grupods    = " + EscaparSQL(THIS.this_cGrupods) + ", " + ;
                           "contads    = " + EscaparSQL(THIS.this_cContads) + ", " + ;
                           "grvends    = " + EscaparSQL(THIS.this_cGrvends) + ", " + ;
                           "vends      = " + EscaparSQL(THIS.this_cVends) + ", " + ;
                           "obss       = " + EscaparSQL(THIS.this_cObss) + ", " + ;
                           "usuars     = " + EscaparSQL(THIS.this_cUsuars) + ", " + ;
                           "usulibs    = " + EscaparSQL(THIS.this_cUsulibs) + ", " + ;
                           "usuconfs   = " + EscaparSQL(THIS.this_cUsuconfs) + ", " + ;
                           "docus      = " + EscaparSQL(THIS.this_cDocus) + ", " + ;
                           "locals     = " + EscaparSQL(THIS.this_cLocals) + ", " + ;
                           "jobs       = " + EscaparSQL(THIS.this_cJobs) + ", " + ;
                           "codnconfs  = " + EscaparSQL(THIS.this_cCodnconfs) + ", " + ;
                           "libprods   = " + EscaparSQL(THIS.this_cLibprods) + ", " + ;
                           "ntrans     = " + FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                           "nops       = " + FormatarNumeroSQL(THIS.this_nNops) + ", " + ;
                           "naceites   = " + FormatarNumeroSQL(THIS.this_nNaceites) + ", " + ;
                           "numbalds   = " + FormatarNumeroSQL(THIS.this_nNumbalds) + ", " + ;
                           "numbals    = " + FormatarNumeroSQL(THIS.this_nNumbals) + ", " + ;
                           "codobs     = " + FormatarNumeroSQL(THIS.this_nCodobs) + ", " + ;
                           "nlotes     = " + FormatarNumeroSQL(THIS.this_nNlotes) + ", " + ;
                           "chkbaixa   = " + FormatarNumeroSQL(THIS.this_nChkbaixa) + ", " + ;
                           "chksubn    = " + IIF(THIS.this_lChksubn,  "1", "0") + ", " + ;
                           "imprs      = " + IIF(THIS.this_lImprs,    "1", "0") + ", " + ;
                           "lccs       = " + IIF(THIS.this_lLccs,     "1", "0") + ", " + ;
                           "procbals   = " + IIF(THIS.this_lProcbals, "1", "0") + ", " + ;
                           "procdbal   = " + IIF(THIS.this_lProcdbal, "1", "0") + ", " + ;
                           "retrabs    = " + IIF(THIS.this_lRetrabs,  "1", "0") + ", " + ;
                           "autos      = " + IIF(THIS.this_lAutos,    "1", "0") + ", " + ;
                           "nconforms  = " + IIF(THIS.this_lNconforms,"1", "0") + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao atualizar movimenta" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigCdNec pela PK cidchaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                MostrarErro("Chave prim" + CHR(225) + "ria n" + CHR(227) + ;
                    "o informada para exclus" + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "DELETE FROM SigCdNec" + ;
                           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir movimenta" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigpdmp7BO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarPeriodoBloqueado - Verifica se a data cai em periodo bloqueado
    * Equivalente ao fVerificaBloqueio + fBloqueioPorPeriodo do Framework legado
    * par_dData: data a verificar
    * Retorno: .T. se bloqueado, .F. se permitido
    *--------------------------------------------------------------------------
    PROCEDURE VerificarPeriodoBloqueado(par_dData)
        LOCAL loc_lBloqueado, loc_nResultado, loc_cSQL
        loc_lBloqueado = .F.

        TRY
            IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
                loc_lBloqueado = .F.
            ELSE
                *-- Tenta usar funcoes do Framework legado se disponiveis no ambiente
                TRY
                    IF PEMSTATUS(_VFP, "fVerificaBloqueio", 5) OR ;
                       TYPE("fVerificaBloqueio") = "FP"
                        IF fVerificaBloqueio(par_dData, gnConnHandle) <> 0
                            loc_lBloqueado = .T.
                        ENDIF
                    ENDIF
                CATCH
                    *-- Framework nao disponivel, nao bloquear
                    loc_lBloqueado = .F.
                ENDTRY

                IF !loc_lBloqueado
                    TRY
                        IF PEMSTATUS(_VFP, "fBloqueioPorPeriodo", 5) OR ;
                           TYPE("fBloqueioPorPeriodo") = "FP"
                            IF fBloqueioPorPeriodo(par_dData, gnConnHandle) <> 0
                                loc_lBloqueado = .T.
                            ENDIF
                        ENDIF
                    CATCH
                        *-- Framework nao disponivel, nao bloquear
                        loc_lBloqueado = .F.
                    ENDTRY
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar per" + CHR(237) + "odo:" + ;
                CHR(13) + loException.Message, "Erro")
            loc_lBloqueado = .F.
        ENDTRY

        RETURN loc_lBloqueado
    ENDPROC

ENDDEFINE
