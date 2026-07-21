*==============================================================================
* sigmvccrBO.prg - Business Object para Movimentos de Conta Corrente
* Data: 2026-04-11
* Tabela: SigMvCcr | PK: cidchaves (clustered)
* Operacao principal: nopers (numero da operacao)
*==============================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - campos BIT (logico)
    *--------------------------------------------------------------------------
    this_lAutos   = .F.    && autos   BIT - Lancamento automatico
    this_lConcs   = .F.    && concs   BIT - Conciliado

    *--------------------------------------------------------------------------
    * Propriedades - campos CHAR
    *--------------------------------------------------------------------------
    this_cEmps        = ""    && emps        CHAR(3)  - Empresa (FK)
    this_cEmpccs      = ""    && empccs      CHAR(3)  - Empresa contra-partida
    this_cEmpos       = ""    && empos       CHAR(3)  - Empresa origem

    this_cCidchaves   = ""    && cidchaves   CHAR(20) - Chave unica (PK)
    this_cGruconmoes  = ""    && gruconmoes  CHAR(23) - Grupos+Contas+Moedas (computado)
    this_cEmpdopncs   = ""    && empdopncs   CHAR(29) - Emps+Dopes+Numcs
    this_cEmpdopnums  = ""    && empdopnums  CHAR(29) - Emps+Dopes+Numes
    this_cDopotps     = ""    && dopotps     CHAR(23) - Dopes+Opers+Tipos+Pagos

    this_cDopes       = ""    && dopes       CHAR(20) - Operacao debito
    this_cDopcs       = ""    && dopcs       CHAR(20) - Operacao credito
    this_cVopers      = ""    && vopers      CHAR(13) - Operacao estendida
    this_cOpers       = ""    && opers       CHAR(1)  - Tipo D/C (debito/credito)
    this_cSopers      = ""    && sopers      CHAR(1)  - Tipo D/C contra-partida
    this_cTipos       = ""    && tipos       CHAR(1)  - Tipo de lancamento
    this_cPagos       = ""    && pagos       CHAR(1)  - Pago (S/N)

    this_cGrupos      = ""    && grupos      CHAR(10) - Grupo debito
    this_cContas      = ""    && contas      CHAR(10) - Conta debito
    this_cMoedas      = ""    && moedas      CHAR(3)  - Moeda debito
    this_cSgrupos     = ""    && sgrupos     CHAR(10) - Grupo credito
    this_cScontas     = ""    && scontas     CHAR(10) - Conta credito
    this_cSmoedas     = ""    && smoedas     CHAR(3)  - Moeda credito

    this_cContages    = ""    && contages    CHAR(10) - Conta gerencial
    this_cGrupages    = ""    && grupages    CHAR(10) - Grupo gerencial
    this_cContems     = ""    && contems     CHAR(10) - Conta empresa
    this_cGrupems     = ""    && grupems     CHAR(10) - Grupo empresa
    this_cLocals      = ""    && locals      CHAR(10) - Local
    this_cBcontas     = ""    && bcontas     CHAR(10) - Conta bancaria
    this_cBgrupos     = ""    && bgrupos     CHAR(10) - Grupo bancario
    this_cRcontas     = ""    && rcontas     CHAR(10) - Conta referencia
    this_cVlancs      = ""    && vlancs      CHAR(10) - Vinculo lancamento

    this_cNfs         = ""    && nfs         CHAR(10) - Numero nota fiscal
    this_cDocus       = ""    && docus       CHAR(10) - Documento
    this_cEspecienfs  = ""    && especienfs  CHAR(6)  - Especie NF
    this_cTpdocnf     = ""    && tpdocnf     CHAR(2)  - Tipo documento NF
    this_cTitulos     = ""    && titulos     CHAR(10) - Titulo
    this_cTitbans     = ""    && titbans     CHAR(12) - Titulo bancario
    this_cTitpais     = ""    && titpais     CHAR(10) - Titulo pai

    this_cHists       = ""    && hists       CHAR(60) - Historico
    this_cHist2s      = ""    && hist2s      CHAR(80) - Historico 2
    this_cShists      = ""    && shists      CHAR(40) - Historico complementar

    this_cJobs        = ""    && jobs        CHAR(10) - Job/Projeto
    this_cCompet      = ""    && compet      CHAR(7)  - Competencia (AAAAMM)
    this_cOridopnums  = ""    && oridopnums  CHAR(29) - Operacao origem
    this_cCotusus     = ""    && cotusus     CHAR(10) - Cotacao usuario

    this_cUsualts     = ""    && usualts     CHAR(10) - Usuario alteracao
    this_cUsuexcs     = ""    && usuexcs     CHAR(10) - Usuario exclusao
    this_cUsuconcs    = ""    && usuconcs    CHAR(10) - Usuario conciliacao
    this_cAuditors    = ""    && auditors    CHAR(10) - Auditor
    this_cUsuconfs    = ""    && usuconfs    CHAR(10) - Usuario confirmacao
    this_cUsupagos    = ""    && usupagos    CHAR(10) - Usuario pagamento

    this_cPastas      = ""    && pastas      TEXT     - Pasta (memo)

    *--------------------------------------------------------------------------
    * Propriedades - campos NUMERIC
    *--------------------------------------------------------------------------
    this_nNopers      = 0     && nopers      NUMERIC(7,0)   - Numero operacao
    this_nNumes       = 0     && numes       NUMERIC(6,0)   - Numero debito
    this_nNumcs       = 0     && numcs       NUMERIC(6,0)   - Numero credito
    this_nNlancs      = 0     && nlancs      NUMERIC(6,0)   - Numero lancamento
    this_nNtrans      = 0     && ntrans      NUMERIC(6,0)   - Numero transferencia
    this_nBorderos    = 0     && borderos    NUMERIC(6,0)   - Bordereau
    this_nIntconts    = 0     && intconts    NUMERIC(6,0)   - Integracao contabil
    this_nNopercancs  = 0     && nopercancs  NUMERIC(7,0)   - Numero operacao cancelada

    this_nCotacaos    = 0     && cotacaos    NUMERIC(15,7)  - Cotacao debito
    this_nScotacaos   = 0     && scotacaos   NUMERIC(15,7)  - Cotacao credito

    this_nValors      = 0     && valors      NUMERIC(11,2)  - Valor debito
    this_nSvalors     = 0     && svalors     NUMERIC(11,2)  - Valor credito
    this_nValliqs     = 0     && valliqs     NUMERIC(11,2)  - Valor liquido
    this_nValocurs    = 0     && valocurs    NUMERIC(11,2)  - Valor ocorrencia
    this_nValpags     = 0     && valpags     NUMERIC(11,2)  - Valor pago
    this_nValprev     = 0     && valprev     NUMERIC(11,2)  - Valor previsto
    this_nImpostos    = 0     && impostos    NUMERIC(11,2)  - Impostos

    this_nSaldos      = 0     && saldos      NUMERIC(15,2)  - Saldo geral
    this_nSaldocs     = 0     && saldocs     NUMERIC(15,2)  - Saldo credito
    this_nSaldons     = 0     && saldons     NUMERIC(15,2)  - Saldo debito

    this_nContapgs    = 0     && contapgs    NUMERIC(1,0)   - Opcao conta (0=Global/1=Cred/2=Deb)
    this_nTitcancs    = 0     && titcancs    NUMERIC(1,0)   - Titulo cancelado
    this_nTpimpostos  = 0     && tpimpostos  NUMERIC(2,0)   - Tipo imposto
    this_nRecor       = 0     && recor       NUMERIC(1,0)   - Recorrencia

    *--------------------------------------------------------------------------
    * Propriedades - campos DATETIME
    *--------------------------------------------------------------------------
    this_dDatas     = {}      && datas       DATETIME - Data lancamento
    this_dVencs     = {}      && vencs       DATETIME - Data vencimento
    this_dDtemis    = {}      && dtemis      DATETIME - Data emissao
    this_dDatalts   = {}      && datalts     DATETIME - Data alteracao
    this_dDatexcs   = {}      && datexcs     DATETIME - Data exclusao
    this_dDataconcs = {}      && dataconcs   DATETIME - Data conciliacao
    this_dDatatrans = {}      && datatrans   DATETIME - Data transferencia
    this_dDtaudits  = {}      && dtaudits    DATETIME - Data auditoria
    this_dDtconfs   = {}      && dtconfs     DATETIME - Data confirmacao

    *--------------------------------------------------------------------------
    * Propriedades de filtro para Buscar()
    *--------------------------------------------------------------------------
    this_dFiltroInicio = {}   && Data inicial do filtro de periodo
    this_dFiltroFim    = {}   && Data final do filtro de periodo

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista movimentos de conta corrente com filtro de periodo
    * par_cFiltro: clausula WHERE adicional (opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF !EMPTY(THIS.this_dFiltroInicio) AND !EMPTY(THIS.this_dFiltroFim)
                loc_cWhere = loc_cWhere + ;
                    " AND a.Datas >= " + FormatarDataSQL(THIS.this_dFiltroInicio) + ;
                    " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dFiltroFim) + ")"
            ENDIF

            IF !EMPTY(par_cFiltro)
                loc_cWhere = loc_cWhere + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Vencs, a.Dtemis," + ;
                       " a.Grupos, a.Contas, a.Moedas, a.Opers," + ;
                       " a.Sgrupos, a.Scontas, a.Smoedas, a.Sopers," + ;
                       " a.Valors, a.Svalors, a.Cotacaos, a.Scotacaos," + ;
                       " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                       " a.Cidchaves, a.Autos, a.Concs," + ;
                       " a.Vopers, a.Dopes, a.Dopcs," + ;
                       " a.Jobs, a.Usualts, a.Contapgs," + ;
                       " a.Saldos, a.Saldocs, a.Saldons" + ;
                       " FROM SigMvCcr a" + ;
                       loc_cWhere + ;
                       " ORDER BY a.Datas, a.Nopers"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar movimentos de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Vencs, a.Dtemis," + ;
                       " a.Grupos, a.Contas, a.Moedas, a.Opers," + ;
                       " a.Sgrupos, a.Scontas, a.Smoedas, a.Sopers," + ;
                       " a.Valors, a.Svalors, a.Cotacaos, a.Scotacaos," + ;
                       " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                       " a.Cidchaves, a.Autos, a.Concs, a.Pagos," + ;
                       " a.Vopers, a.Dopes, a.Dopcs," + ;
                       " a.Jobs, a.Usualts, a.Contapgs," + ;
                       " a.Saldos, a.Saldocs, a.Saldons," + ;
                       " a.Valliqs, a.Valocurs, a.Valpags, a.Valprev," + ;
                       " a.Impostos, a.Tpimpostos," + ;
                       " a.Nlancs, a.Ntrans, a.Numes, a.Numcs," + ;
                       " a.Borderos, a.Intconts, a.Nopercancs," + ;
                       " a.Titulos, a.Titbans, a.Titpais," + ;
                       " a.Contages, a.Grupages, a.Contems, a.Grupems," + ;
                       " a.Locals, a.Bcontas, a.Bgrupos, a.Rcontas," + ;
                       " a.Vlancs, a.Cotusus, a.Compet," + ;
                       " a.Empccs, a.Empos, a.Oridopnums," + ;
                       " a.Datalts, a.Datexcs, a.Dataconcs, a.Datatrans," + ;
                       " a.Dtaudits, a.Dtconfs," + ;
                       " a.Usuexcs, a.Usuconcs, a.Auditors," + ;
                       " a.Usuconfs, a.Usupagos," + ;
                       " a.Tipos, a.Gruconmoes, a.Empdopncs, a.Empdopnums," + ;
                       " a.Dopotps, a.Titcancs, a.Especienfs, a.Tpdocnf," + ;
                       " a.Recor" + ;
                       " FROM SigMvCcr a" + ;
                       " WHERE a.Cidchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves   = TratarNulo(cidchaves, "C")
                THIS.this_cEmps        = TratarNulo(emps, "C")
                THIS.this_nNopers      = TratarNulo(nopers, "N")
                THIS.this_dDatas       = TratarNulo(datas, "D")
                THIS.this_dVencs       = TratarNulo(vencs, "D")
                THIS.this_dDtemis      = TratarNulo(dtemis, "D")

                THIS.this_cGrupos      = TratarNulo(grupos, "C")
                THIS.this_cContas      = TratarNulo(contas, "C")
                THIS.this_cMoedas      = TratarNulo(moedas, "C")
                THIS.this_cOpers       = TratarNulo(opers, "C")
                THIS.this_cSgrupos     = TratarNulo(sgrupos, "C")
                THIS.this_cScontas     = TratarNulo(scontas, "C")
                THIS.this_cSmoedas     = TratarNulo(smoedas, "C")
                THIS.this_cSopers      = TratarNulo(sopers, "C")

                THIS.this_nValors      = TratarNulo(valors, "N")
                THIS.this_nSvalors     = TratarNulo(svalors, "N")
                THIS.this_nCotacaos    = TratarNulo(cotacaos, "N")
                THIS.this_nScotacaos   = TratarNulo(scotacaos, "N")

                THIS.this_cHists       = TratarNulo(hists, "C")
                THIS.this_cHist2s      = TratarNulo(hist2s, "C")
                THIS.this_cShists      = TratarNulo(shists, "C")
                THIS.this_cNfs         = TratarNulo(nfs, "C")
                THIS.this_cDocus       = TratarNulo(docus, "C")

                IF VARTYPE(autos) = "L"
                    THIS.this_lAutos = autos
                ELSE
                    IF VARTYPE(autos) = "L"
                        THIS.this_lAutos = autos
                    ELSE
                        IF VARTYPE(autos) = "L"
                            THIS.this_lAutos = autos
                        ELSE
                            IF VARTYPE(autos) = "L"
                                THIS.this_lAutos = autos
                            ELSE
                                IF VARTYPE(autos) = "L"
                                    THIS.this_lAutos = autos
                                ELSE
                                    IF VARTYPE(autos) = "L"
                                        THIS.this_lAutos = autos
                                    ELSE
                                        IF VARTYPE(autos) = "L"
                                            THIS.this_lAutos = autos
                                        ELSE
                                            IF VARTYPE(autos) = "L"
                                                THIS.this_lAutos = autos
                                            ELSE
                                                IF VARTYPE(autos) = "L"
                                                    THIS.this_lAutos = autos
                                                ELSE
                                                    IF VARTYPE(autos) = "L"
                                                        THIS.this_lAutos = autos
                                                    ELSE
                                                        IF VARTYPE(autos) = "L"
                                                            THIS.this_lAutos = autos
                                                        ELSE
                                                            IF VARTYPE(autos) = "L"
                                                                THIS.this_lAutos = autos
                                                            ELSE
                                                                IF VARTYPE(autos) = "L"
                                                                    THIS.this_lAutos = autos
                                                                ELSE
                                                                    IF VARTYPE(autos) = "L"
                                                                        THIS.this_lAutos = autos
                                                                    ELSE
                                                                        IF VARTYPE(autos) = "L"
                                                                            THIS.this_lAutos = autos
                                                                        ELSE
                                                                            IF VARTYPE(autos) = "L"
                                                                                THIS.this_lAutos = autos
                                                                            ELSE
                                                                                IF VARTYPE(autos) = "L"
                                                                                    THIS.this_lAutos = autos
                                                                                ELSE
                                                                                    IF VARTYPE(autos) = "L"
                                                                                        THIS.this_lAutos = autos
                                                                                    ELSE
                                                                                        IF VARTYPE(autos) = "L"
                                                                                            THIS.this_lAutos = autos
                                                                                        ELSE
                                                                                            IF VARTYPE(autos) = "L"
                                                                                                THIS.this_lAutos = autos
                                                                                            ELSE
                                                                                                IF VARTYPE(autos) = "L"
                                                                                                    THIS.this_lAutos = autos
                                                                                                ELSE
                                                                                                    IF VARTYPE(autos) = "L"
                                                                                                        THIS.this_lAutos = autos
                                                                                                    ELSE
                                                                                                        IF VARTYPE(autos) = "L"
                                                                                                            THIS.this_lAutos = autos
                                                                                                        ELSE
                                                                                                            IF VARTYPE(autos) = "L"
                                                                                                                THIS.this_lAutos = autos
                                                                                                            ELSE
                                                                                                                IF VARTYPE(autos) = "L"
                                                                                                                    THIS.this_lAutos = autos
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(autos) = "L"
                                                                                                                        THIS.this_lAutos = autos
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(autos) = "L"
                                                                                                                            THIS.this_lAutos = autos
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(autos) = "L"
                                                                                                                                THIS.this_lAutos = autos
                                                                                                                            ELSE
                                                                                                                                IF VARTYPE(autos) = "L"
                                                                                                                                    THIS.this_lAutos = autos
                                                                                                                                ELSE
                                                                                                                                    IF VARTYPE(autos) = "L"
                                                                                                                                        THIS.this_lAutos = autos
                                                                                                                                    ELSE
                                                                                                                                        THIS.this_lAutos = (NVL(autos, 0) = 1)
                                                                                                                                    ENDIF
                                                                                                                                ENDIF
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(concs) = "L"
                    THIS.this_lConcs = concs
                ELSE
                    IF VARTYPE(concs) = "L"
                        THIS.this_lConcs = concs
                    ELSE
                        IF VARTYPE(concs) = "L"
                            THIS.this_lConcs = concs
                        ELSE
                            IF VARTYPE(concs) = "L"
                                THIS.this_lConcs = concs
                            ELSE
                                IF VARTYPE(concs) = "L"
                                    THIS.this_lConcs = concs
                                ELSE
                                    IF VARTYPE(concs) = "L"
                                        THIS.this_lConcs = concs
                                    ELSE
                                        IF VARTYPE(concs) = "L"
                                            THIS.this_lConcs = concs
                                        ELSE
                                            IF VARTYPE(concs) = "L"
                                                THIS.this_lConcs = concs
                                            ELSE
                                                IF VARTYPE(concs) = "L"
                                                    THIS.this_lConcs = concs
                                                ELSE
                                                    IF VARTYPE(concs) = "L"
                                                        THIS.this_lConcs = concs
                                                    ELSE
                                                        IF VARTYPE(concs) = "L"
                                                            THIS.this_lConcs = concs
                                                        ELSE
                                                            IF VARTYPE(concs) = "L"
                                                                THIS.this_lConcs = concs
                                                            ELSE
                                                                IF VARTYPE(concs) = "L"
                                                                    THIS.this_lConcs = concs
                                                                ELSE
                                                                    IF VARTYPE(concs) = "L"
                                                                        THIS.this_lConcs = concs
                                                                    ELSE
                                                                        IF VARTYPE(concs) = "L"
                                                                            THIS.this_lConcs = concs
                                                                        ELSE
                                                                            IF VARTYPE(concs) = "L"
                                                                                THIS.this_lConcs = concs
                                                                            ELSE
                                                                                IF VARTYPE(concs) = "L"
                                                                                    THIS.this_lConcs = concs
                                                                                ELSE
                                                                                    IF VARTYPE(concs) = "L"
                                                                                        THIS.this_lConcs = concs
                                                                                    ELSE
                                                                                        IF VARTYPE(concs) = "L"
                                                                                            THIS.this_lConcs = concs
                                                                                        ELSE
                                                                                            IF VARTYPE(concs) = "L"
                                                                                                THIS.this_lConcs = concs
                                                                                            ELSE
                                                                                                IF VARTYPE(concs) = "L"
                                                                                                    THIS.this_lConcs = concs
                                                                                                ELSE
                                                                                                    IF VARTYPE(concs) = "L"
                                                                                                        THIS.this_lConcs = concs
                                                                                                    ELSE
                                                                                                        IF VARTYPE(concs) = "L"
                                                                                                            THIS.this_lConcs = concs
                                                                                                        ELSE
                                                                                                            IF VARTYPE(concs) = "L"
                                                                                                                THIS.this_lConcs = concs
                                                                                                            ELSE
                                                                                                                IF VARTYPE(concs) = "L"
                                                                                                                    THIS.this_lConcs = concs
                                                                                                                ELSE
                                                                                                                    IF VARTYPE(concs) = "L"
                                                                                                                        THIS.this_lConcs = concs
                                                                                                                    ELSE
                                                                                                                        IF VARTYPE(concs) = "L"
                                                                                                                            THIS.this_lConcs = concs
                                                                                                                        ELSE
                                                                                                                            IF VARTYPE(concs) = "L"
                                                                                                                                THIS.this_lConcs = concs
                                                                                                                            ELSE
                                                                                                                                IF VARTYPE(concs) = "L"
                                                                                                                                    THIS.this_lConcs = concs
                                                                                                                                ELSE
                                                                                                                                    IF VARTYPE(concs) = "L"
                                                                                                                                        THIS.this_lConcs = concs
                                                                                                                                    ELSE
                                                                                                                                        THIS.this_lConcs = (NVL(concs, 0) = 1)
                                                                                                                                    ENDIF
                                                                                                                                ENDIF
                                                                                                                            ENDIF
                                                                                                                        ENDIF
                                                                                                                    ENDIF
                                                                                                                ENDIF
                                                                                                            ENDIF
                                                                                                        ENDIF
                                                                                                    ENDIF
                                                                                                ENDIF
                                                                                            ENDIF
                                                                                        ENDIF
                                                                                    ENDIF
                                                                                ENDIF
                                                                            ENDIF
                                                                        ENDIF
                                                                    ENDIF
                                                                ENDIF
                                                            ENDIF
                                                        ENDIF
                                                    ENDIF
                                                ENDIF
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
                THIS.this_cPagos       = TratarNulo(pagos, "C")

                THIS.this_cVopers      = TratarNulo(vopers, "C")
                THIS.this_cDopes       = TratarNulo(dopes, "C")
                THIS.this_cDopcs       = TratarNulo(dopcs, "C")
                THIS.this_cJobs        = TratarNulo(jobs, "C")
                THIS.this_cUsualts     = TratarNulo(usualts, "C")
                THIS.this_nContapgs    = TratarNulo(contapgs, "N")

                THIS.this_nSaldos      = TratarNulo(saldos, "N")
                THIS.this_nSaldocs     = TratarNulo(saldocs, "N")
                THIS.this_nSaldons     = TratarNulo(saldons, "N")

                *-- Campos adicionais (presentes apenas em CarregarPorCodigo)
                IF TYPE(par_cAliasCursor + ".nlancs") != "U"
                    THIS.this_nNlancs    = TratarNulo(nlancs, "N")
                    THIS.this_nNtrans    = TratarNulo(ntrans, "N")
                    THIS.this_nNumes     = TratarNulo(numes, "N")
                    THIS.this_nNumcs     = TratarNulo(numcs, "N")
                    THIS.this_nBorderos  = TratarNulo(borderos, "N")
                    THIS.this_nIntconts  = TratarNulo(intconts, "N")
                    THIS.this_cTitulos   = TratarNulo(titulos, "C")
                    THIS.this_cTitbans   = TratarNulo(titbans, "C")
                    THIS.this_cTitpais   = TratarNulo(titpais, "C")
                    THIS.this_cContages  = TratarNulo(contages, "C")
                    THIS.this_cGrupages  = TratarNulo(grupages, "C")
                    THIS.this_cContems   = TratarNulo(contems, "C")
                    THIS.this_cGrupems   = TratarNulo(grupems, "C")
                    THIS.this_cLocals    = TratarNulo(locals, "C")
                    THIS.this_cBcontas   = TratarNulo(bcontas, "C")
                    THIS.this_cBgrupos   = TratarNulo(bgrupos, "C")
                    THIS.this_cRcontas   = TratarNulo(rcontas, "C")
                    THIS.this_cVlancs    = TratarNulo(vlancs, "C")
                    THIS.this_cCotusus   = TratarNulo(cotusus, "C")
                    THIS.this_cCompet    = TratarNulo(compet, "C")
                    THIS.this_cEmpccs    = TratarNulo(empccs, "C")
                    THIS.this_cEmpos     = TratarNulo(empos, "C")
                    THIS.this_cOridopnums = TratarNulo(oridopnums, "C")
                    THIS.this_dDatalts   = TratarNulo(datalts, "D")
                    THIS.this_dDatexcs   = TratarNulo(datexcs, "D")
                    THIS.this_dDataconcs = TratarNulo(dataconcs, "D")
                    THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                    THIS.this_dDtaudits  = TratarNulo(dtaudits, "D")
                    THIS.this_dDtconfs   = TratarNulo(dtconfs, "D")
                    THIS.this_cUsuexcs   = TratarNulo(usuexcs, "C")
                    THIS.this_cUsuconcs  = TratarNulo(usuconcs, "C")
                    THIS.this_cAuditors  = TratarNulo(auditors, "C")
                    THIS.this_cUsuconfs  = TratarNulo(usuconfs, "C")
                    THIS.this_cUsupagos  = TratarNulo(usupagos, "C")
                    THIS.this_cTipos     = TratarNulo(tipos, "C")
                    THIS.this_cGruconmoes = TratarNulo(gruconmoes, "C")
                    THIS.this_cEmpdopncs  = TratarNulo(empdopncs, "C")
                    THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                    THIS.this_cDopotps    = TratarNulo(dopotps, "C")
                    THIS.this_nTitcancs   = TratarNulo(titcancs, "N")
                    THIS.this_cEspecienfs = TratarNulo(especienfs, "C")
                    THIS.this_cTpdocnf    = TratarNulo(tpdocnf, "C")
                    THIS.this_nRecor      = TratarNulo(recor, "N")
                    THIS.this_nNopercancs = TratarNulo(nopercancs, "N")
                    THIS.this_nValliqs    = TratarNulo(valliqs, "N")
                    THIS.this_nValocurs   = TratarNulo(valocurs, "N")
                    THIS.this_nValpags    = TratarNulo(valpags, "N")
                    THIS.this_nValprev    = TratarNulo(valprev, "N")
                    THIS.this_nImpostos   = TratarNulo(impostos, "N")
                    THIS.this_nTpimpostos = TratarNulo(tpimpostos, "N")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigMvCcr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_nNopers, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Obter proximo nopers para a empresa
            loc_cSQL = "SELECT ISNULL(MAX(Nopers), 0) + 1 AS ProxNopers" + ;
                       " FROM SigMvCcr WITH (UPDLOCK, HOLDLOCK)" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF USED("cursor_4c_ProxNoper")
                USE IN cursor_4c_ProxNoper
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxNoper")

            IF loc_nResult < 0 OR RECCOUNT("cursor_4c_ProxNoper") = 0
                MsgErro("Erro ao obter numero de operacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ProxNoper")
                    USE IN cursor_4c_ProxNoper
                ENDIF
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_ProxNoper
            loc_nNopers = cursor_4c_ProxNoper.ProxNopers
            THIS.this_nNopers = loc_nNopers

            IF USED("cursor_4c_ProxNoper")
                USE IN cursor_4c_ProxNoper
            ENDIF

            *-- Gerar cidchaves: YYYYMMDD + nopers 6 digitos
            THIS.this_cCidchaves = DTOS(THIS.this_dDatas) + ;
                PADL(ALLTRIM(STR(loc_nNopers, 7, 0)), 7, "0")

            *-- Campos computados
            THIS.this_cGruconmoes  = ALLTRIM(THIS.this_cGrupos) + ;
                ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)
            THIS.this_cEmpdopncs   = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopcs) + ALLTRIM(STR(THIS.this_nNumcs, 6, 0))
            THIS.this_cEmpdopnums  = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopes) + ALLTRIM(STR(THIS.this_nNumes, 6, 0))
            THIS.this_cDopotps     = ALLTRIM(THIS.this_cDopes) + ;
                ALLTRIM(THIS.this_cOpers) + ALLTRIM(THIS.this_cTipos) + ;
                ALLTRIM(THIS.this_cPagos)

            *-- INSERT com colunas sem duplicatas (82 colunas)
            loc_cSQL = "INSERT INTO SigMvCcr (" + ;
                       " Emps, Nopers, Cidchaves, Datas, Vencs, Dtemis," + ;
                       " Grupos, Contas, Moedas, Opers," + ;
                       " Sgrupos, Scontas, Smoedas, Sopers," + ;
                       " Valors, Svalors, Cotacaos, Scotacaos," + ;
                       " Hists, Hist2s, Shists, Nfs, Docus," + ;
                       " Autos, Concs, Pagos, Tipos," + ;
                       " Vopers, Dopes, Dopcs, Jobs, Contapgs," + ;
                       " Saldos, Saldocs, Saldons," + ;
                       " Valliqs, Valocurs, Valpags, Valprev, Impostos, Tpimpostos," + ;
                       " Nlancs, Ntrans, Numes, Numcs, Borderos, Intconts, Nopercancs," + ;
                       " Titulos, Titbans, Titpais, Titcancs," + ;
                       " Contages, Grupages, Contems, Grupems," + ;
                       " Locals, Bcontas, Bgrupos, Rcontas, Vlancs, Cotusus," + ;
                       " Compet, Empccs, Empos, Oridopnums, Tpdocnf, Especienfs, Recor," + ;
                       " Gruconmoes, Empdopncs, Empdopnums, Dopotps," + ;
                       " Usualts, Usuexcs, Usuconcs, Auditors, Usuconfs, Usupagos" + ;
                       ") VALUES ("

            *-- Valores linha 1: chaves e datas (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopers) + "," + ;
                EscaparSQL(THIS.this_cCidchaves) + "," + ;
                FormatarDataSQL(THIS.this_dDatas) + "," + ;
                FormatarDataSQL(THIS.this_dVencs) + "," + ;
                FormatarDataSQL(THIS.this_dDtemis) + ","

            *-- Valores linha 2: grupos, contas, moedas, operacoes (8 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cGrupos) + "," + ;
                EscaparSQL(THIS.this_cContas) + "," + ;
                EscaparSQL(THIS.this_cMoedas) + "," + ;
                EscaparSQL(THIS.this_cOpers) + "," + ;
                EscaparSQL(THIS.this_cSgrupos) + "," + ;
                EscaparSQL(THIS.this_cScontas) + "," + ;
                EscaparSQL(THIS.this_cSmoedas) + "," + ;
                EscaparSQL(THIS.this_cSopers) + ","

            *-- Valores linha 3: valores e cotacoes (4 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                FormatarNumeroSQL(THIS.this_nScotacaos) + ","

            *-- Valores linha 4: historico, nf, documento (5 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cHists) + "," + ;
                EscaparSQL(THIS.this_cHist2s) + "," + ;
                EscaparSQL(THIS.this_cShists) + "," + ;
                EscaparSQL(THIS.this_cNfs) + "," + ;
                EscaparSQL(THIS.this_cDocus) + ","

            *-- Valores linha 5: flags, tipos, operacoes (11 valores)
            loc_cSQL = loc_cSQL + ;
                IIF(THIS.this_lAutos, "1", "0") + "," + ;
                IIF(THIS.this_lConcs, "1", "0") + "," + ;
                EscaparSQL(THIS.this_cPagos) + "," + ;
                EscaparSQL(THIS.this_cTipos) + "," + ;
                EscaparSQL(THIS.this_cVopers) + "," + ;
                EscaparSQL(THIS.this_cDopes) + "," + ;
                EscaparSQL(THIS.this_cDopcs) + "," + ;
                EscaparSQL(THIS.this_cJobs) + "," + ;
                FormatarNumeroSQL(THIS.this_nContapgs) + ","

            *-- Valores linha 6: saldos (3 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nSaldos) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldocs) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldons) + ","

            *-- Valores linha 7: valores complementares e numeradores (13 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nValliqs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValocurs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValpags) + "," + ;
                FormatarNumeroSQL(THIS.this_nValprev) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpostos) + "," + ;
                FormatarNumeroSQL(THIS.this_nTpimpostos) + "," + ;
                FormatarNumeroSQL(THIS.this_nNlancs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                FormatarNumeroSQL(THIS.this_nBorderos) + "," + ;
                FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopercancs) + ","

            *-- Valores linha 8: titulos (4 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cTitulos) + "," + ;
                EscaparSQL(THIS.this_cTitbans) + "," + ;
                EscaparSQL(THIS.this_cTitpais) + "," + ;
                FormatarNumeroSQL(THIS.this_nTitcancs) + ","

            *-- Valores linha 9: contas gerenciais (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cContages) + "," + ;
                EscaparSQL(THIS.this_cGrupages) + "," + ;
                EscaparSQL(THIS.this_cContems) + "," + ;
                EscaparSQL(THIS.this_cGrupems) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cBcontas) + "," + ;
                EscaparSQL(THIS.this_cBgrupos) + "," + ;
                EscaparSQL(THIS.this_cRcontas) + "," + ;
                EscaparSQL(THIS.this_cVlancs) + "," + ;
                EscaparSQL(THIS.this_cCotusus) + ","

            *-- Valores linha 10: empresa/compet e campos computados (17 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCompet) + "," + ;
                EscaparSQL(THIS.this_cEmpccs) + "," + ;
                EscaparSQL(THIS.this_cEmpos) + "," + ;
                EscaparSQL(THIS.this_cOridopnums) + "," + ;
                EscaparSQL(THIS.this_cTpdocnf) + "," + ;
                EscaparSQL(THIS.this_cEspecienfs) + "," + ;
                FormatarNumeroSQL(THIS.this_nRecor) + "," + ;
                EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                EscaparSQL(THIS.this_cEmpdopncs) + "," + ;
                EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                EscaparSQL(THIS.this_cDopotps) + ","

            *-- Valores linha 11: usuarios de auditoria (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigMvCcr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campos computados
            THIS.this_cGruconmoes  = ALLTRIM(THIS.this_cGrupos) + ;
                ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)
            THIS.this_cEmpdopncs   = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopcs) + ALLTRIM(STR(THIS.this_nNumcs, 6, 0))
            THIS.this_cEmpdopnums  = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopes) + ALLTRIM(STR(THIS.this_nNumes, 6, 0))
            THIS.this_cDopotps     = ALLTRIM(THIS.this_cDopes) + ;
                ALLTRIM(THIS.this_cOpers) + ALLTRIM(THIS.this_cTipos) + ;
                ALLTRIM(THIS.this_cPagos)

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                       " Datas = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " Vencs = " + FormatarDataSQL(THIS.this_dVencs) + "," + ;
                       " Dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + "," + ;
                       " Grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " Moedas = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                       " Opers = " + EscaparSQL(THIS.this_cOpers) + "," + ;
                       " Sgrupos = " + EscaparSQL(THIS.this_cSgrupos) + "," + ;
                       " Scontas = " + EscaparSQL(THIS.this_cScontas) + "," + ;
                       " Smoedas = " + EscaparSQL(THIS.this_cSmoedas) + "," + ;
                       " Sopers = " + EscaparSQL(THIS.this_cSopers) + ","

            loc_cSQL = loc_cSQL + ;
                       " Valors = " + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                       " Svalors = " + FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                       " Cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                       " Scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                       " Hists = " + EscaparSQL(THIS.this_cHists) + "," + ;
                       " Hist2s = " + EscaparSQL(THIS.this_cHist2s) + "," + ;
                       " Shists = " + EscaparSQL(THIS.this_cShists) + "," + ;
                       " Nfs = " + EscaparSQL(THIS.this_cNfs) + "," + ;
                       " Docus = " + EscaparSQL(THIS.this_cDocus) + ","

            loc_cSQL = loc_cSQL + ;
                       " Contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                       " Jobs = " + EscaparSQL(THIS.this_cJobs) + "," + ;
                       " Vopers = " + EscaparSQL(THIS.this_cVopers) + "," + ;
                       " Dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " Dopcs = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                       " Gruconmoes = " + EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                       " Empdopncs = " + EscaparSQL(THIS.this_cEmpdopncs) + "," + ;
                       " Empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                       " Dopotps = " + EscaparSQL(THIS.this_cDopotps) + "," + ;
                       " Usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       " Datalts = GETDATE()" + ;
                       " WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigMvCcr por cidchaves
    * Nota: Registra data/usuario de exclusao antes de deletar fisicamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Marcar exclusao logica primeiro (DatExcs/UsuExcs)
            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                       " Datexcs = GETDATE()," + ;
                       " Usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdExc")

            IF loc_nResult < 0
                MsgErro("Erro ao marcar exclusao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UpdExc")
                    USE IN cursor_4c_UpdExc
                ENDIF

                *-- Exclusao fisica
                loc_cSQL = "DELETE FROM SigMvCcr" + ;
                           " WHERE Emps = " + EscaparSQL(THIS.this_cEmps) + ;
                           " AND Nopers = " + FormatarNumeroSQL(THIS.this_nNopers)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    IF USED("cursor_4c_Delete")
                        USE IN cursor_4c_Delete
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
