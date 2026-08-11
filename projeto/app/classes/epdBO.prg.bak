*******************************************************************************
* epdBO.prg - Business Object para Finalizacao Antecipada
* Tabela principal: SigCdNec
* Chave: EmpDNps (Emps C3 + Dopps C20 + Str(Numps,10))
*******************************************************************************

DEFINE CLASS epdBO AS BusinessBase

    *-- Chave primaria composta
    this_cEmpDNps    = ""    && C(33) Chave: Emps+Dopps+Str(Numps,10)
    this_cEmpDNpsC   = ""    && C(29) Chave curta: Emps+Dopps+Str(Numps,6)

    *-- Campos de SigCdNec (confirmados por ControlSource)
    this_cEmps       = ""    && C(3)  Empresa
    this_cDopps      = ""    && C(20) Tipo de Operacao (fixo: ENCERRAMENTO DIRETO)
    this_nNumps      = 0     && N(10) Numero do necessario (codigo)
    this_dDatas      = {}    && D     Data de finalizacao

    *-- Origem (ControlSource: tmpnens.grupoos, tmpnens.contaos)
    this_cGrupoOs    = ""    && C     Grupo de origem
    this_cContaOs    = ""    && C     Conta de origem (IClis)

    *-- Destino (ControlSource: tmpnens.grupods, tmpnens.contads)
    this_cGrupoDs    = ""    && C     Grupo de destino
    this_cContaDs    = ""    && C     Conta de destino (IClis)

    *-- Responsavel (ControlSource: tmpnens.grvends, tmpnens.vends)
    this_cGrVends    = ""    && C     Grupo do responsavel
    this_cVends      = ""    && C     Conta do responsavel (IClis)

    *-- Controles operacionais (propriedades do form original)
    this_cDopp       = ""    && C(20) Operacao fixa ENCERRAMENTO DIRETO
    this_lAutomatico = .F.   && L     Modo automatico (parametro)
    this_lEditaOrig  = .T.   && L     Permite editar origem (editaorigem)
    this_nNops       = 0     && N     Numero da ordem de producao

    *====================================================================
    PROCEDURE Init()
    *====================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdNec"
            THIS.this_cCampoChave = "EmpDNps"
            THIS.this_cDopp       = PADR("ENCERRAMENTO DIRETO", 20)
            loc_lResultado        = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
    *====================================================================
        RETURN THIS.this_cEmpDNps
    ENDPROC

    *====================================================================
    FUNCTION Buscar(par_cFiltro)
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cOpI, loc_cOpF
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cEmpresa = go_4c_Sistema.cCodEmpresa
            loc_cOpI     = loc_cEmpresa + THIS.this_cDopp + STR(0,          10)
            loc_cOpF     = loc_cEmpresa + THIS.this_cDopp + STR(9999999999, 10)

            loc_cSQL = "SELECT a.empdnps, a.emps, a.dopps, a.numps," + ;
                       " a.datas, a.grupoos, a.contaos, a.grupods," + ;
                       " a.contads, a.grvends, a.vends, a.cidchaves," + ;
                       " a.chksubn, a.usuars, a.obss" + ;
                       " FROM SigCdNec a" + ;
                       " WHERE a.empdnps BETWEEN " + EscaparSQL(loc_cOpI) + " AND " + EscaparSQL(loc_cOpF)

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.numps"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    FUNCTION CarregarPorCodigo(par_cChave)
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.empdnps, a.emps, a.dopps, a.numps," + ;
                       " a.datas, a.grupoos, a.contaos, a.grupods," + ;
                       " a.contads, a.grvends, a.vends, a.cidchaves," + ;
                       " a.chksubn, a.usuars, a.obss" + ;
                       " FROM SigCdNec a" + ;
                       " WHERE a.empdnps = " + EscaparSQL(par_cChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado       = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
    *====================================================================
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps     = TratarNulo(emps,    "C")
                THIS.this_cDopps    = TratarNulo(dopps,   "C")
                THIS.this_nNumps    = TratarNulo(numps,   "N")
                THIS.this_dDatas    = TratarNulo(datas,   "D")
                THIS.this_cGrupoOs  = TratarNulo(grupoos, "C")
                THIS.this_cContaOs  = TratarNulo(contaos, "C")
                THIS.this_cGrupoDs  = TratarNulo(grupods, "C")
                THIS.this_cContaDs  = TratarNulo(contads, "C")
                THIS.this_cGrVends  = TratarNulo(grvends, "C")
                THIS.this_cVends    = TratarNulo(vends,   "C")
                THIS.this_cEmpDNps  = TratarNulo(empdnps, "C")
                THIS.this_cEmpDNpsC = THIS.this_cEmps + THIS.this_cDopps + ;
                                      STR(THIS.this_nNumps, 6)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION Inserir()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCidChave
        loc_lResultado = .F.

        TRY
            THIS.this_cEmps  = go_4c_Sistema.cCodEmpresa
            THIS.this_cDopps = THIS.this_cDopp

            THIS.this_cEmpDNps  = THIS.this_cEmps + THIS.this_cDopps + ;
                                   STR(THIS.this_nNumps, 10)
            THIS.this_cEmpDNpsC = THIS.this_cEmps + THIS.this_cDopps + ;
                                   STR(THIS.this_nNumps, 6)

            loc_cCidChave = SUBSTR(THIS.this_cEmpDNps, 14, 20)

            loc_cSQL = "INSERT INTO SigCdNec" + ;
                       " (emps, dopps, numps, datas," + ;
                       "  grupoos, contaos, grupods, contads," + ;
                       "  grvends, vends, empdnps, cidchaves, usuars," + ;
                       "  chksubn, totpesos, imprs, lccs, procbals, procdbal," + ;
                       "  docus, locals, ntrans, nops, naceites, retrabs," + ;
                       "  autos, libprods, codnconfs, numbalds, numbals, codobs," + ;
                       "  empds, nconforms, nlotes, jobs, pesolancs, usulibs," + ;
                       "  chkbaixa, usuconfs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cEmps)    + "," + ;
                       EscaparSQL(THIS.this_cDopps)   + "," + ;
                       FormatarNumeroSQL(THIS.this_nNumps) + "," + ;
                       FormatarDataSQL(THIS.this_dDatas)   + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrupoOs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cContaOs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrupoDs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cContaDs, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cGrVends, 10)) + "," + ;
                       EscaparSQL(LEFT(THIS.this_cVends,   10)) + "," + ;
                       EscaparSQL(THIS.this_cEmpDNps)  + "," + ;
                       EscaparSQL(loc_cCidChave)       + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + "," + ;
                       "0,0,0,0,0,0," + ;
                       "'          ','          ',0,0,0,0," + ;
                       "0,'          ','          ',0,0,0," + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ",0,0,'          ',0," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ",0,'          ')"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION Atualizar()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdNec SET" + ;
                       "  datas   = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       "  grupoos = " + EscaparSQL(LEFT(THIS.this_cGrupoOs, 10)) + "," + ;
                       "  contaos = " + EscaparSQL(LEFT(THIS.this_cContaOs, 10)) + "," + ;
                       "  grupods = " + EscaparSQL(LEFT(THIS.this_cGrupoDs, 10)) + "," + ;
                       "  contads = " + EscaparSQL(LEFT(THIS.this_cContaDs, 10)) + "," + ;
                       "  grvends = " + EscaparSQL(LEFT(THIS.this_cGrVends, 10)) + "," + ;
                       "  vends   = " + EscaparSQL(LEFT(THIS.this_cVends,   10)) + "," + ;
                       "  usuars  = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ;
                       " WHERE empdnps = " + EscaparSQL(THIS.this_cEmpDNps)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    PROTECTED FUNCTION ExecutarExclusao()
    *====================================================================
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            *-- Excluir itens de SigCdNei primeiro (integridade referencial)
            loc_cSQL    = "DELETE FROM SigCdNei WHERE empdnps = " + ;
                          EscaparSQL(THIS.this_cEmpDNps)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir itens (SigCdNei):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Excluir registro principal de SigCdNec
                loc_cSQL    = "DELETE FROM SigCdNec WHERE empdnps = " + ;
                              EscaparSQL(THIS.this_cEmpDNps)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
