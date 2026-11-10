*==============================================================================
* sigopindBO.PRG
* Business Object do form OPERACIONAL "Individual" (SIGOPIND)
* Conciliacao / extrato individual de Conta Corrente (Contas a Receber/Pagar)
*
* Tabela principal : SigMvCcr   (PK: CidChaves char(20))
* Tabelas de apoio  : SigMvSlc (saldos por conta/moeda), SigCdCli (contas),
*                      SigCdMoe (moedas), SigCdGcr (grupos de conta corrente),
*                      SigCdPam (parametros do sistema), SigCdEmp (empresa),
*                      SigCqOch (follow-up), SigCdPbx (parcelas/quitacao)
*
* Nao possui Incluir(): os lancamentos de SigMvCcr sao criados por outras
* telas (SigCdLch/SigCdPgr); este BO consulta, concilia, audita, exclui e
* imprime - o padrao do legado (SIGOPIND.SCX) nunca tem botao "Incluir".
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS sigopindBO AS BusinessBase

    *==========================================================================
    * Estado operacional - espelha as propriedades customizadas do form legado
    * SIGOPIND (SECAO 2 do dump + atribuicoes "With ThisForm" do Init)
    *==========================================================================

    *-- legado: ThisForm.GrupoOper - limpo no Init, sem outro uso localizado
    this_cGrupoOper = ""

    *-- legado: ThisForm.Cliente - conta (SigCdCli.Iclis) da operacao corrente
    this_cCliente = ""

    *-- legado: ThisForm.Operacao - modo da operacao corrente ("" ou "CONSULTA")
    this_cOperacao = ""

    *-- legado: ThisForm.DataConcilia - data informada para a conciliacao
    this_dDataConcilia = {}

    *-- legado: ThisForm.Matrizes - .T. quando a conta selecionada eh matriz
    this_lMatrizes = .F.

    *-- legado: ThisForm.TxtDeb/ThisForm.TxtCre - rotulos D/C vindos de
    *-- SigCdPam.Drivets (posicoes 1-3 e 5-7), com fallback "D"/"C"
    this_cTxtDeb = "D"
    this_cTxtCre = "C"

    *-- legado: ThisForm.reg - RECNO salvo para reposicionar a grade de
    *-- lancamentos apos Conciliar/Auditar (comentario original: "flag criado
    *-- para manter o posicionamento da grade apos o botao conciliacao")
    this_nReg = 0

    *-- Chave (SigMvCcr.CidChaves) do lancamento selecionado na grade de
    *-- Historico - usada por Conciliar/Auditar/Excluir/FollowUp
    this_cCidChaves = ""

    *==========================================================================
    * Parametros do sistema (SigCdPam) usados nas acoes de conciliacao -
    * lcPag = GrupoPags + ContaPags + Moeda / lcRec = GrupoRecs + ContaRecs + Moeda
    *==========================================================================
    this_cGrupoPags = ""
    this_cContaPags = ""
    this_cGrupoRecs = ""
    this_cContaRecs = ""

    *==========================================================================
    * Dados da empresa atual (SigCdEmp.Razas) - cabecalho dos relatorios de
    * Saldo e Historico (legado: lcNomeEmpresa = crEmpresa.Razas)
    *==========================================================================
    this_cRazaoSocial = ""

    *==========================================================================
    * Cursores de trabalho das grades (populados nas fases seguintes)
    *==========================================================================
    this_cCursorSaldo     = "cursor_4c_Saldo"
    this_cCursorHistorico = "cursor_4c_Historico"
    this_cCursorQuitacao  = "cursor_4c_Quitacao"

    *==========================================================================
    * Dados do lancamento corrente de SigMvCcr (linha selecionada na grade de
    * Historico) - mapeados em CarregarDoCursor(), persistidos em Atualizar().
    * cidchaves (PK) ja existe como this_cCidChaves, declarado na Fase 1.
    *==========================================================================
    this_lAutos        = .F.
    this_lConcs        = .F.
    this_cContages     = ""
    this_cContas       = ""
    this_cContems      = ""
    this_nCotacaos     = 0
    this_dDatalts      = {}
    this_dDatas        = {}
    this_dDataconcs    = {}
    this_dDatatrans    = {}
    this_dDatexcs      = {}
    this_cDocus        = ""
    this_cDopes        = ""
    this_dDtemis       = {}
    this_cEmps         = ""
    this_cGrupages     = ""
    this_cGrupems      = ""
    this_cGrupos       = ""
    this_cHists        = ""
    this_cLocals       = ""
    this_cMoedas       = ""
    this_cNfs          = ""
    this_nNlancs       = 0
    this_nNopers       = 0
    this_nNtrans       = 0
    this_nNumes        = 0
    this_cOpers        = ""
    this_nSaldocs      = 0
    this_nSaldons      = 0
    this_nSaldos       = 0
    this_cScontas      = ""
    this_nScotacaos    = 0
    this_cSgrupos      = ""
    this_cShists       = ""
    this_cSmoedas      = ""
    this_cSopers       = ""
    this_nSvalors      = 0
    this_cTipos        = ""
    this_cTitbans      = ""
    this_cTitulos      = ""
    this_cUsualts      = ""
    this_cUsuexcs      = ""
    this_nValliqs      = 0
    this_nValocurs     = 0
    this_nValors       = 0
    this_nValpags      = 0
    this_dVencs        = {}
    this_cVlancs       = ""
    this_cVopers       = ""
    this_nContapgs     = 0
    this_cDopcs        = ""
    this_nNumcs        = 0
    this_cCotusus      = ""
    this_cBcontas      = ""
    this_cBgrupos      = ""
    this_nBorderos     = 0
    this_cHist2s       = ""
    this_nIntconts     = 0
    this_cUsuconcs     = ""
    this_cAuditors     = ""
    this_dDtaudits     = {}
    this_nValprev      = 0
    this_cEmpdopncs    = ""
    this_cEmpdopnums   = ""
    this_cGruconmoes   = ""
    this_cPagos        = ""
    this_cDopotps      = ""
    this_cUsupagos     = ""
    this_nTitcancs     = 0
    this_dDtconfs      = {}
    this_cUsuconfs     = ""
    this_nNopercancs   = 0
    this_cEspecienfs   = ""
    this_cJobs         = ""
    this_nImpostos     = 0
    this_nTpimpostos   = 0
    this_cTitpais      = ""
    this_cEmpccs       = ""
    this_nRecor        = 0
    this_cCompet       = ""
    this_cEmpos        = ""
    this_cOridopnums   = ""
    this_cPastas       = ""
    this_cRcontas      = ""
    this_cTpdocnf      = ""

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "CidChaves"

            THIS.this_cGrupoOper    = ""
            THIS.this_cCliente      = ""
            THIS.this_cOperacao     = ""
            THIS.this_dDataConcilia = {}
            THIS.this_lMatrizes     = .F.
            THIS.this_cTxtDeb       = "D"
            THIS.this_cTxtCre       = "C"
            THIS.this_nReg          = 0
            THIS.this_cCidChaves    = ""

            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigMvCcr (linha corrente
    * do alias informado) para as propriedades this_* do lancamento.
    * Usado apos SQLEXEC/Requery de CrSigMvCcr / CrAltcc, antes de Conciliar,
    * Auditar, Excluir ou qualquer acao que dependa dos dados do lancamento
    * selecionado na grade de Historico.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves  = TratarNulo(cidchaves, "")
                THIS.this_lAutos      = ConverterParaLogico(autos)
                THIS.this_lConcs      = ConverterParaLogico(concs)
                THIS.this_cContages   = TratarNulo(contages, "")
                THIS.this_cContas     = TratarNulo(contas, "")
                THIS.this_cContems    = TratarNulo(contems, "")
                THIS.this_nCotacaos   = TratarNulo(cotacaos, 0)
                THIS.this_dDatalts    = TratarNulo(datalts, {})
                THIS.this_dDatas      = TratarNulo(datas, {})
                THIS.this_dDataconcs  = TratarNulo(dataconcs, {})
                THIS.this_dDatatrans  = TratarNulo(datatrans, {})
                THIS.this_dDatexcs    = TratarNulo(datexcs, {})
                THIS.this_cDocus      = TratarNulo(docus, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_dDtemis     = TratarNulo(dtemis, {})
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cGrupages   = TratarNulo(grupages, "")
                THIS.this_cGrupems    = TratarNulo(grupems, "")
                THIS.this_cGrupos     = TratarNulo(grupos, "")
                THIS.this_cHists      = TratarNulo(hists, "")
                THIS.this_cLocals     = TratarNulo(locals, "")
                THIS.this_cMoedas     = TratarNulo(moedas, "")
                THIS.this_cNfs        = TratarNulo(nfs, "")
                THIS.this_nNlancs     = TratarNulo(nlancs, 0)
                THIS.this_nNopers     = TratarNulo(nopers, 0)
                THIS.this_nNtrans     = TratarNulo(ntrans, 0)
                THIS.this_nNumes      = TratarNulo(numes, 0)
                THIS.this_cOpers      = TratarNulo(opers, "")
                THIS.this_nSaldocs    = TratarNulo(saldocs, 0)
                THIS.this_nSaldons    = TratarNulo(saldons, 0)
                THIS.this_nSaldos     = TratarNulo(saldos, 0)
                THIS.this_cScontas    = TratarNulo(scontas, "")
                THIS.this_nScotacaos  = TratarNulo(scotacaos, 0)
                THIS.this_cSgrupos    = TratarNulo(sgrupos, "")
                THIS.this_cShists     = TratarNulo(shists, "")
                THIS.this_cSmoedas    = TratarNulo(smoedas, "")
                THIS.this_cSopers     = TratarNulo(sopers, "")
                THIS.this_nSvalors    = TratarNulo(svalors, 0)
                THIS.this_cTipos      = TratarNulo(tipos, "")
                THIS.this_cTitbans    = TratarNulo(titbans, "")
                THIS.this_cTitulos    = TratarNulo(titulos, "")
                THIS.this_cUsualts    = TratarNulo(usualts, "")
                THIS.this_cUsuexcs    = TratarNulo(usuexcs, "")
                THIS.this_nValliqs    = TratarNulo(valliqs, 0)
                THIS.this_nValocurs   = TratarNulo(valocurs, 0)
                THIS.this_nValors     = TratarNulo(valors, 0)
                THIS.this_nValpags    = TratarNulo(valpags, 0)
                THIS.this_dVencs      = TratarNulo(vencs, {})
                THIS.this_cVlancs     = TratarNulo(vlancs, "")
                THIS.this_cVopers     = TratarNulo(vopers, "")
                THIS.this_nContapgs   = TratarNulo(contapgs, 0)
                THIS.this_cDopcs      = TratarNulo(dopcs, "")
                THIS.this_nNumcs      = TratarNulo(numcs, 0)
                THIS.this_cCotusus    = TratarNulo(cotusus, "")
                THIS.this_cBcontas    = TratarNulo(bcontas, "")
                THIS.this_cBgrupos    = TratarNulo(bgrupos, "")
                THIS.this_nBorderos   = TratarNulo(borderos, 0)
                THIS.this_cHist2s     = TratarNulo(hist2s, "")
                THIS.this_nIntconts   = TratarNulo(intconts, 0)
                THIS.this_cUsuconcs   = TratarNulo(usuconcs, "")
                THIS.this_cAuditors   = TratarNulo(auditors, "")
                THIS.this_dDtaudits   = TratarNulo(dtaudits, {})
                THIS.this_nValprev    = TratarNulo(valprev, 0)
                THIS.this_cEmpdopncs  = TratarNulo(empdopncs, "")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_cGruconmoes = TratarNulo(gruconmoes, "")
                THIS.this_cPagos      = TratarNulo(pagos, "")
                THIS.this_cDopotps    = TratarNulo(dopotps, "")
                THIS.this_cUsupagos   = TratarNulo(usupagos, "")
                THIS.this_nTitcancs   = TratarNulo(titcancs, 0)
                THIS.this_dDtconfs    = TratarNulo(dtconfs, {})
                THIS.this_cUsuconfs   = TratarNulo(usuconfs, "")
                THIS.this_nNopercancs = TratarNulo(nopercancs, 0)
                THIS.this_cEspecienfs = TratarNulo(especienfs, "")
                THIS.this_cJobs       = TratarNulo(jobs, "")
                THIS.this_nImpostos   = TratarNulo(impostos, 0)
                THIS.this_nTpimpostos = TratarNulo(tpimpostos, 0)
                THIS.this_cTitpais    = TratarNulo(titpais, "")
                THIS.this_cEmpccs     = TratarNulo(empccs, "")
                THIS.this_nRecor      = TratarNulo(recor, 0)
                THIS.this_cCompet     = TratarNulo(compet, "")
                THIS.this_cEmpos      = TratarNulo(empos, "")
                THIS.this_cOridopnums = TratarNulo(oridopnums, "")
                THIS.this_cPastas     = TratarNulo(pastas, "")
                THIS.this_cRcontas    = TratarNulo(rcontas, "")
                THIS.this_cTpdocnf    = TratarNulo(tpdocnf, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "sigopindBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do lancamento corrente (SigMvCcr.CidChaves)
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * Inserir - SIGOPIND (Individual - Conciliacao/Extrato de Conta Corrente)
    * NUNCA cria lancamento: no legado o grupo de botoes da grade de Historico
    * nao tem "Incluir" - os lancamentos de SigMvCcr nascem nas telas de
    * Lancamento (SigCdLch) e Programacao (SigCdPgr). Este metodo apenas
    * recusa a operacao e explica o motivo, para o chamador nunca ficar mudo.
    *==========================================================================
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Lan" + CHR(231) + "amentos de Conta Corrente s" + CHR(227) + ;
            "o criados pelas telas de Lan" + CHR(231) + "amento (SigCdLch) ou Programa" + ;
            CHR(231) + CHR(227) + "o (SigCdPgr) - esta tela n" + CHR(227) + "o inclui registros."
        RETURN .F.
    ENDPROC

    *==========================================================================
    * Atualizar - Grava de volta em SigMvCcr as colunas do lancamento corrente
    * (this_* populadas por CarregarDoCursor). Usado pelas acoes desta tela
    * que alteram o lancamento sem reabrir a edicao completa (Conciliar,
    * Auditar, Quitacao/Follow-up, confirmacao de pagamento) - cada acao ajusta
    * as propriedades correspondentes e chama THIS.Atualizar() para persistir.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cMensagemErro = "Lan" + CHR(231) + "amento n" + CHR(227) + "o selecionado."
            RETURN .F.
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigMvCcr
                SET autos      = <<IIF(THIS.this_lAutos, 1, 0)>>,
                    concs       = <<IIF(THIS.this_lConcs, 1, 0)>>,
                    contages    = <<EscaparSQL(THIS.this_cContages)>>,
                    contas      = <<EscaparSQL(THIS.this_cContas)>>,
                    contems     = <<EscaparSQL(THIS.this_cContems)>>,
                    cotacaos    = <<FormatarNumeroSQL(THIS.this_nCotacaos, 7)>>,
                    datalts     = <<FormatarDataSQL(THIS.this_dDatalts)>>,
                    datas       = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    dataconcs   = <<FormatarDataSQL(THIS.this_dDataconcs)>>,
                    datatrans   = <<FormatarDataSQL(THIS.this_dDatatrans)>>,
                    datexcs     = <<FormatarDataSQL(THIS.this_dDatexcs)>>,
                    docus       = <<EscaparSQL(THIS.this_cDocus)>>,
                    dopes       = <<EscaparSQL(THIS.this_cDopes)>>,
                    dtemis      = <<FormatarDataSQL(THIS.this_dDtemis)>>,
                    emps        = <<EscaparSQL(THIS.this_cEmps)>>,
                    grupages    = <<EscaparSQL(THIS.this_cGrupages)>>,
                    grupems     = <<EscaparSQL(THIS.this_cGrupems)>>,
                    grupos      = <<EscaparSQL(THIS.this_cGrupos)>>,
                    hists       = <<EscaparSQL(THIS.this_cHists)>>,
                    locals      = <<EscaparSQL(THIS.this_cLocals)>>,
                    moedas      = <<EscaparSQL(THIS.this_cMoedas)>>,
                    nfs         = <<EscaparSQL(THIS.this_cNfs)>>,
                    nlancs      = <<FormatarNumeroSQL(THIS.this_nNlancs, 0)>>,
                    nopers      = <<FormatarNumeroSQL(THIS.this_nNopers, 0)>>,
                    ntrans      = <<FormatarNumeroSQL(THIS.this_nNtrans, 0)>>,
                    numes       = <<FormatarNumeroSQL(THIS.this_nNumes, 0)>>,
                    opers       = <<EscaparSQL(THIS.this_cOpers)>>,
                    saldocs     = <<FormatarNumeroSQL(THIS.this_nSaldocs, 2)>>,
                    saldons     = <<FormatarNumeroSQL(THIS.this_nSaldons, 2)>>,
                    saldos      = <<FormatarNumeroSQL(THIS.this_nSaldos, 2)>>,
                    scontas     = <<EscaparSQL(THIS.this_cScontas)>>,
                    scotacaos   = <<FormatarNumeroSQL(THIS.this_nScotacaos, 7)>>,
                    sgrupos     = <<EscaparSQL(THIS.this_cSgrupos)>>,
                    shists      = <<EscaparSQL(THIS.this_cShists)>>,
                    smoedas     = <<EscaparSQL(THIS.this_cSmoedas)>>,
                    sopers      = <<EscaparSQL(THIS.this_cSopers)>>,
                    svalors     = <<FormatarNumeroSQL(THIS.this_nSvalors, 2)>>,
                    tipos       = <<EscaparSQL(THIS.this_cTipos)>>,
                    titbans     = <<EscaparSQL(THIS.this_cTitbans)>>,
                    titulos     = <<EscaparSQL(THIS.this_cTitulos)>>,
                    usualts     = <<EscaparSQL(THIS.this_cUsualts)>>,
                    usuexcs     = <<EscaparSQL(THIS.this_cUsuexcs)>>,
                    valliqs     = <<FormatarNumeroSQL(THIS.this_nValliqs, 2)>>,
                    valocurs    = <<FormatarNumeroSQL(THIS.this_nValocurs, 2)>>,
                    valors      = <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
                    valpags     = <<FormatarNumeroSQL(THIS.this_nValpags, 2)>>,
                    vencs       = <<FormatarDataSQL(THIS.this_dVencs)>>,
                    vlancs      = <<EscaparSQL(THIS.this_cVlancs)>>,
                    vopers      = <<EscaparSQL(THIS.this_cVopers)>>,
                    contapgs    = <<FormatarNumeroSQL(THIS.this_nContapgs, 0)>>,
                    dopcs       = <<EscaparSQL(THIS.this_cDopcs)>>,
                    numcs       = <<FormatarNumeroSQL(THIS.this_nNumcs, 0)>>,
                    cotusus     = <<EscaparSQL(THIS.this_cCotusus)>>,
                    bcontas     = <<EscaparSQL(THIS.this_cBcontas)>>,
                    bgrupos     = <<EscaparSQL(THIS.this_cBgrupos)>>,
                    borderos    = <<FormatarNumeroSQL(THIS.this_nBorderos, 0)>>,
                    hist2s      = <<EscaparSQL(THIS.this_cHist2s)>>,
                    intconts    = <<FormatarNumeroSQL(THIS.this_nIntconts, 0)>>,
                    usuconcs    = <<EscaparSQL(THIS.this_cUsuconcs)>>,
                    auditors    = <<EscaparSQL(THIS.this_cAuditors)>>,
                    dtaudits    = <<FormatarDataSQL(THIS.this_dDtaudits)>>,
                    valprev     = <<FormatarNumeroSQL(THIS.this_nValprev, 2)>>,
                    empdopncs   = <<EscaparSQL(THIS.this_cEmpdopncs)>>,
                    empdopnums  = <<EscaparSQL(THIS.this_cEmpdopnums)>>,
                    gruconmoes  = <<EscaparSQL(THIS.this_cGruconmoes)>>,
                    pagos       = <<EscaparSQL(THIS.this_cPagos)>>,
                    dopotps     = <<EscaparSQL(THIS.this_cDopotps)>>,
                    usupagos    = <<EscaparSQL(THIS.this_cUsupagos)>>,
                    titcancs    = <<FormatarNumeroSQL(THIS.this_nTitcancs, 0)>>,
                    dtconfs     = <<FormatarDataSQL(THIS.this_dDtconfs)>>,
                    usuconfs    = <<EscaparSQL(THIS.this_cUsuconfs)>>,
                    nopercancs  = <<FormatarNumeroSQL(THIS.this_nNopercancs, 0)>>,
                    especienfs  = <<EscaparSQL(THIS.this_cEspecienfs)>>,
                    jobs        = <<EscaparSQL(THIS.this_cJobs)>>,
                    impostos    = <<FormatarNumeroSQL(THIS.this_nImpostos, 2)>>,
                    tpimpostos  = <<FormatarNumeroSQL(THIS.this_nTpimpostos, 0)>>,
                    titpais     = <<EscaparSQL(THIS.this_cTitpais)>>,
                    empccs      = <<EscaparSQL(THIS.this_cEmpccs)>>,
                    recor       = <<FormatarNumeroSQL(THIS.this_nRecor, 0)>>,
                    compet      = <<EscaparSQL(THIS.this_cCompet)>>,
                    empos       = <<EscaparSQL(THIS.this_cEmpos)>>,
                    oridopnums  = <<EscaparSQL(THIS.this_cOridopnums)>>,
                    pastas      = <<EscaparSQL(THIS.this_cPastas)>>,
                    rcontas     = <<EscaparSQL(THIS.this_cRcontas)>>,
                    tpdocnf     = <<EscaparSQL(THIS.this_cTpdocnf)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar lan" + CHR(231) + "amento:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "sigopindBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarSaldos - Carrega os saldos por conta/moeda do Grupo informado,
    * equivalente ao PROCEDURE MontaGrade(pGru) do legado SIGOPIND.SCX
    * (linhas 4452-4499 do dump). par_nFiltro espelha
    * ThisForm.Page.Saldo.optFiltro.Value: 1=Global (sem filtro),
    * 2=Positivos (Saldos>0), 3=Negativos (Saldos<0).
    *
    * SQLEXEC roda num cursor TEMPORARIO; o cursor do Grid
    * (THIS.this_cCursorSaldo = "cursor_4c_Saldo", criado pelo Form em
    * ConfigurarGridSaldo) e' atualizado com ZAP + APPEND FROM DBF(), para
    * nunca derrubar o RecordSource/ControlSource ja ligados ao Grid
    * (regra do projeto para forms OPERACIONAIS).
    *
    * Matriz ('M'/'F'/' ') reproduz o
    * "Update CrSigMvSlc Set Matriz = Iif(Empty(ContaMats), '', ..." do
    * legado, calculado dentro do proprio SELECT (ISNULL() do SQL Server,
    * NUNCA NVL() que e' funcao do VFP - regra do projeto).
    *==========================================================================
    PROCEDURE BuscarSaldos(par_cGrupo, par_nFiltro)
        LOCAL loc_cSQL, loc_cFiltroSaldo, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_cCursorTemp
        loc_lSucesso = .F.
        loc_cCursorTemp = "cursor_4c_SaldoTmp"

        TRY
            DO CASE
                CASE par_nFiltro = 2
                    loc_cFiltroSaldo = " AND a.Saldos > 0"
                CASE par_nFiltro = 3
                    loc_cFiltroSaldo = " AND a.Saldos < 0"
                OTHERWISE
                    loc_cFiltroSaldo = ""
            ENDCASE

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT a.Emps, a.Grupos, a.Contas, a.Moedas, a.Saldos,
                       b.RClis, b.Situas, b.Cpfs, b.ContaMats,
                       CASE WHEN LTRIM(RTRIM(ISNULL(b.ContaMats,''))) = '' THEN ' '
                            WHEN a.Contas = b.ContaMats THEN 'M'
                            ELSE 'F' END AS Matriz
                FROM SigMvSlc a
                INNER JOIN SigCdCli b ON a.Contas = b.IClis
                WHERE a.Grupos = <<EscaparSQL(par_cGrupo)>> <<loc_cFiltroSaldo>>
                ORDER BY a.Contas, a.Moedas
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorTemp)

            IF loc_nResultado >= 0
                IF USED(THIS.this_cCursorSaldo)
                    SELECT (THIS.this_cCursorSaldo)
                    ZAP
                    APPEND FROM DBF(loc_cCursorTemp)
                    GO TOP
                ENDIF

                loc_lSucesso = .T.
            ELSE
                MostrarErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar os saldos:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED(loc_cCursorTemp)
                USE IN (loc_cCursorTemp)
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "sigopindBO.BuscarSaldos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
