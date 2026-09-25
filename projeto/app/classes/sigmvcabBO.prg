*====================================================================
* sigmvcabBO.prg
*
* Business Object para Movimentacao (Cabecalho) - SIGMVCAB
* Tabela: SigMvCab
* Chave: cidchaves (fUniqueIds())
* Herda de: BusinessBase
*
* FASE 1/8: Propriedades e Init() - demais metodos vem nas proximas fases
*====================================================================

DEFINE CLASS sigmvcabBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvCab)
    this_nNpedclis      = 0    && npedclis numeric(11,0)
    this_nAcres         = 0    && acres numeric(8,4)
    this_cAntecs        = ""   && antecs char(6)
    this_lChksubn       = .F.  && chksubn bit
    this_nCodpeds       = 0    && codpeds numeric(8,0)
    this_cContads       = ""   && contads char(10)
    this_cContaos       = ""   && contaos char(10)
    this_dDatars        = {}   && datars datetime NULL
    this_dDatas         = {}   && datas datetime NULL
    this_dDatatrans     = {}   && datatrans datetime NULL
    this_nDesc2s        = 0    && desc2s numeric(5,2)
    this_nDescs         = 0    && descs numeric(8,4)
    this_nDevols        = 0    && devols numeric(8,0)
    this_cDopes         = ""   && dopes char(20)
    this_cEmpds         = ""   && empds char(3)
    this_cEmps          = ""   && emps char(3)
    this_cGrresps       = ""   && grresps char(10)
    this_cGrupods       = ""   && grupods char(10)
    this_cGrupoos       = ""   && grupoos char(10)
    this_cGrupos        = ""   && grupos char(10)
    this_cGrvends       = ""   && grvends char(10)
    this_cIclis         = ""   && iclis char(10)
    this_cIfors         = ""   && ifors char(10)
    this_cLocals        = ""   && locals char(10)
    this_nLotechqs      = 0    && lotechqs numeric(8,0)
    this_cLprecos       = ""   && lprecos char(30)
    this_cMascnum       = ""   && mascnum char(10)
    this_cNcarnecs      = ""   && ncarnecs char(11)
    this_cNemps         = ""   && nemps char(40)
    this_nNops          = 0    && nops numeric(10,0)
    this_cNotas         = ""   && notas char(6)
    this_cNrcons        = ""   && nrcons char(10)
    this_nNtrans        = 0    && ntrans numeric(6,0)
    this_nNumes         = 0    && numes numeric(6,0)
    this_nNumolds       = 0    && numolds numeric(6,0)
    this_cObses         = ""   && obses text NULL (memo)
    this_cOpers         = ""   && opers char(1)
    this_dPrazoents     = {}   && prazoents datetime NULL
    this_cResps         = ""   && resps char(10)
    this_cTabds         = ""   && tabds char(10)
    this_cTpfats        = ""   && tpfats char(3)
    this_lTransps       = .F.  && transps bit
    this_cUsuals        = ""   && usuals char(10)
    this_cUsuars        = ""   && usuars char(10)
    this_cUsulibs       = ""   && usulibs char(10)
    this_nValacres      = 0    && valacres numeric(11,2)
    this_nValdes2s      = 0    && valdes2s numeric(11,2)
    this_nValdescs      = 0    && valdescs numeric(11,2)
    this_nValdevs       = 0    && valdevs numeric(11,2)
    this_nValencs       = 0    && valencs numeric(11,2)
    this_nValinis       = 0    && valinis numeric(11,2)
    this_nValos         = 0    && valos numeric(11,2)
    this_nValservs      = 0    && valservs numeric(11,2)
    this_nValvars       = 0    && valvars numeric(11,2)
    this_nVars          = 0    && vars numeric(9,4)
    this_cVends         = ""   && vends char(10)
    this_cCotusus       = ""   && cotusus char(10)
    this_dDtemis        = {}   && dtemis datetime NULL
    this_cEspes         = ""   && espes char(10)
    this_nPbrus         = 0    && pbrus numeric(10,3) NULL
    this_nPliqs         = 0    && pliqs numeric(10,3) NULL
    this_nQtdes         = 0    && qtdes numeric(6,0)
    this_lLcancelas     = .F.  && lcancelas bit
    this_lCofs          = .F.  && cofs bit
    this_lLivros        = .F.  && livros bit
    this_dDttransms     = {}   && dttransms datetime NULL
    this_lChkbxparcs    = .F.  && chkbxparcs bit
    this_cEcfs          = ""   && ecfs char(7)
    this_nCodobs        = 0    && codobs numeric(3,0)
    this_cDgopes        = ""   && dgopes char(20)
    this_dDtfechas      = {}   && dtfechas datetime NULL
    this_nTrfisicos     = 0    && trfisicos numeric(2,0)
    this_nUtilizados    = 0    && utilizados numeric(1,0)
    this_nValndevs      = 0    && valndevs numeric(11,2)
    this_nValobxs       = 0    && valobxs numeric(11,2)
    this_cNoforms       = ""   && noforms char(10)
    this_cAuditors      = ""   && auditors char(10)
    this_dDtaudits      = {}   && dtaudits datetime NULL
    this_cCidchaves     = ""   && cidchaves char(20) - PK (fUniqueIds())
    this_dDtalts        = {}   && dtalts datetime NULL
    this_cEmpdopnums    = ""   && empdopnums char(29)
    this_dDtbaixas      = {}   && dtbaixas datetime NULL
    this_dDtrecs        = {}   && dtrecs datetime NULL
    this_cEmpgopnums    = ""   && empgopnums char(29)
    this_cContaes       = ""   && contaes char(10)
    this_dDtagends      = {}   && dtagends datetime NULL
    this_nLocalents     = 0    && localents numeric(10,0)
    this_cLocalizas     = ""   && localizas char(6)
    this_lChkpagos      = .F.  && chkpagos bit
    this_lChkpgs        = .F.  && chkpgs bit
    this_cCodtrans      = ""   && codtrans char(10)
    this_dDtbxestqs     = {}   && dtbxestqs datetime NULL
    this_cEmpdnbxs      = ""   && empdnbxs char(29)
    this_cEmpdncrds     = ""   && empdncrds char(29)
    this_cObsagends     = ""   && obsagends char(15)
    this_cOperadors     = ""   && operadors char(10)
    this_nVcompensas    = 0    && vcompensas numeric(5,2)
    this_dDtrtrans      = {}   && dtrtrans datetime NULL
    this_cMotdscs       = ""   && motdscs char(10)
    this_nNdeclaras     = 0    && ndeclaras numeric(10,0)
    this_nNumbalds      = 0    && numbalds numeric(6,0)
    this_nNumbals       = 0    && numbals numeric(6,0)
    this_nPriors        = 0    && priors numeric(2,0)
    this_lProcbals      = .F.  && procbals bit
    this_lProcdbal      = .F.  && procdbal bit
    this_nProtats       = 0    && protats numeric(6,0)
    this_cUsupagos      = ""   && usupagos char(10)
    this_cUltgrvs       = ""   && ultgrvs char(40)
    this_cMoeits        = ""   && moeits char(3)
    this_dDtagendfs     = {}   && dtagendfs datetime NULL
    this_nRnops         = 0    && rnops numeric(10,0)
    this_nImpress       = 0    && impress numeric(1,0)
    this_dPrzclis       = {}   && przclis datetime NULL
    this_cPstatus       = ""   && pstatus char(1)
    this_nValvarps      = 0    && valvarps numeric(11,2)
    this_cCifccfs       = ""   && cifccfs char(6)
    this_nCupfis        = 0    && cupfis numeric(1,0)
    this_nIdconta       = 0    && idconta numeric(10,0)
    this_cNcupoms       = ""   && ncupoms char(6)
    this_cStatus        = ""   && status char(3)
    this_nValtrans      = 0    && valtrans numeric(8,2)
    this_nImpcpfs       = 0    && impcpfs numeric(1,0)
    this_cCcfgnfs       = ""   && ccfgnfs char(6)
    this_cFpubls        = ""   && fpubls char(3)
    this_cJobs          = ""   && jobs char(10)
    this_nPtax1s        = 0    && ptax1s numeric(4,2)
    this_nPtax2s        = 0    && ptax2s numeric(4,2)
    this_nPtax3s        = 0    && ptax3s numeric(4,2)
    this_cObscabmovs    = ""   && obscabmovs char(40)
    this_cCodobs2       = ""   && codobs2 char(60)
    this_nValserfix     = 0    && valserfix numeric(12,2)
    this_nPerserfix     = 0    && perserfix numeric(5,2)
    this_nValosfix      = 0    && valosfix numeric(12,2)
    this_nChkencerra    = 0    && chkencerra numeric(1,0)
    this_nPerdesc       = 0    && perdesc numeric(4,2)
    this_cCompet        = ""   && compet char(10)
    this_cPedidoweb     = ""   && pedidoweb char(50)
    this_cCdrastreio    = ""   && cdrastreio char(20)
    this_cIdentrega     = ""   && identrega char(50)
    this_cIdtransp      = ""   && idtransp char(15)
    this_nPeracresc     = 0    && peracresc numeric(4,2)
    this_cTpmovs        = ""   && tpmovs char(2)
    this_cEmpfats       = ""   && empfats char(3)
    this_cNumeronota    = ""   && numeronota char(10)
    this_cMeiotrans     = ""   && meiotrans char(50)
    this_cChavenota     = ""   && chavenota char(44)
    this_cContaccs      = ""   && contaccs char(10)
    this_cGrupoccs      = ""   && grupoccs char(10)
    this_nNatend        = 0    && natend numeric(6,0)
    this_nNlivdg        = 0    && nlivdg numeric(15,0)
    this_nPresente      = 0    && presente numeric(1,0)
    this_cChaveexterna  = ""   && chaveexterna char(33)
    this_cEmpret        = ""   && empret char(3)
    this_cMsgpresnte    = ""   && msgpresnte char(150)
    this_nCkoperpend    = 0    && ckoperpend numeric(1,0)
    this_dDtfabricacao  = {}   && dtfabricacao datetime NULL
    this_dDtvalidade    = {}   && dtvalidade datetime NULL
    this_cUsuconfs      = ""   && usuconfs char(10)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigmvcabBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para
    * uso em RegistrarAuditoria()
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL para as
    * propriedades do BO. SEMPRE usar SELECT (par_cAliasCursor) antes de
    * acessar os campos (regra #8 CLAUDE.md).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nNpedclis = TratarNulo(npedclis, "N")
                THIS.this_nAcres = TratarNulo(acres, "N")
                THIS.this_cAntecs = TratarNulo(antecs, "C")
                IF VARTYPE(chksubn) = "L"
                    THIS.this_lChksubn = chksubn
                ELSE
                    THIS.this_lChksubn = (NVL(chksubn, 0) = 1)
                ENDIF
                THIS.this_nCodpeds = TratarNulo(codpeds, "N")
                THIS.this_cContads = TratarNulo(contads, "C")
                THIS.this_cContaos = TratarNulo(contaos, "C")
                THIS.this_dDatars = TratarNulo(datars, "D")
                THIS.this_dDatas = TratarNulo(datas, "D")
                THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                THIS.this_nDesc2s = TratarNulo(desc2s, "N")
                THIS.this_nDescs = TratarNulo(descs, "N")
                THIS.this_nDevols = TratarNulo(devols, "N")
                THIS.this_cDopes = TratarNulo(dopes, "C")
                THIS.this_cEmpds = TratarNulo(empds, "C")
                THIS.this_cEmps = TratarNulo(emps, "C")
                THIS.this_cGrresps = TratarNulo(grresps, "C")
                THIS.this_cGrupods = TratarNulo(grupods, "C")
                THIS.this_cGrupoos = TratarNulo(grupoos, "C")
                THIS.this_cGrupos = TratarNulo(grupos, "C")
                THIS.this_cGrvends = TratarNulo(grvends, "C")
                THIS.this_cIclis = TratarNulo(iclis, "C")
                THIS.this_cIfors = TratarNulo(ifors, "C")
                THIS.this_cLocals = TratarNulo(locals, "C")
                THIS.this_nLotechqs = TratarNulo(lotechqs, "N")
                THIS.this_cLprecos = TratarNulo(lprecos, "C")
                THIS.this_cMascnum = TratarNulo(mascnum, "C")
                THIS.this_cNcarnecs = TratarNulo(ncarnecs, "C")
                THIS.this_cNemps = TratarNulo(nemps, "C")
                THIS.this_nNops = TratarNulo(nops, "N")
                THIS.this_cNotas = TratarNulo(notas, "C")
                THIS.this_cNrcons = TratarNulo(nrcons, "C")
                THIS.this_nNtrans = TratarNulo(ntrans, "N")
                THIS.this_nNumes = TratarNulo(numes, "N")
                THIS.this_nNumolds = TratarNulo(numolds, "N")
                THIS.this_cObses = TratarNulo(obses, "C")
                THIS.this_cOpers = TratarNulo(opers, "C")
                THIS.this_dPrazoents = TratarNulo(prazoents, "D")
                THIS.this_cResps = TratarNulo(resps, "C")
                THIS.this_cTabds = TratarNulo(tabds, "C")
                THIS.this_cTpfats = TratarNulo(tpfats, "C")
                IF VARTYPE(transps) = "L"
                    THIS.this_lTransps = transps
                ELSE
                    THIS.this_lTransps = (NVL(transps, 0) = 1)
                ENDIF
                THIS.this_cUsuals = TratarNulo(usuals, "C")
                THIS.this_cUsuars = TratarNulo(usuars, "C")
                THIS.this_cUsulibs = TratarNulo(usulibs, "C")
                THIS.this_nValacres = TratarNulo(valacres, "N")
                THIS.this_nValdes2s = TratarNulo(valdes2s, "N")
                THIS.this_nValdescs = TratarNulo(valdescs, "N")
                THIS.this_nValdevs = TratarNulo(valdevs, "N")
                THIS.this_nValencs = TratarNulo(valencs, "N")
                THIS.this_nValinis = TratarNulo(valinis, "N")
                THIS.this_nValos = TratarNulo(valos, "N")
                THIS.this_nValservs = TratarNulo(valservs, "N")
                THIS.this_nValvars = TratarNulo(valvars, "N")
                THIS.this_nVars = TratarNulo(vars, "N")
                THIS.this_cVends = TratarNulo(vends, "C")
                THIS.this_cCotusus = TratarNulo(cotusus, "C")
                THIS.this_dDtemis = TratarNulo(dtemis, "D")
                THIS.this_cEspes = TratarNulo(espes, "C")
                THIS.this_nPbrus = TratarNulo(pbrus, "N")
                THIS.this_nPliqs = TratarNulo(pliqs, "N")
                THIS.this_nQtdes = TratarNulo(qtdes, "N")
                IF VARTYPE(lcancelas) = "L"
                    THIS.this_lLcancelas = lcancelas
                ELSE
                    THIS.this_lLcancelas = (NVL(lcancelas, 0) = 1)
                ENDIF
                IF VARTYPE(cofs) = "L"
                    THIS.this_lCofs = cofs
                ELSE
                    THIS.this_lCofs = (NVL(cofs, 0) = 1)
                ENDIF
                IF VARTYPE(livros) = "L"
                    THIS.this_lLivros = livros
                ELSE
                    THIS.this_lLivros = (NVL(livros, 0) = 1)
                ENDIF
                THIS.this_dDttransms = TratarNulo(dttransms, "D")
                IF VARTYPE(chkbxparcs) = "L"
                    THIS.this_lChkbxparcs = chkbxparcs
                ELSE
                    THIS.this_lChkbxparcs = (NVL(chkbxparcs, 0) = 1)
                ENDIF
                THIS.this_cEcfs = TratarNulo(ecfs, "C")
                THIS.this_nCodobs = TratarNulo(codobs, "N")
                THIS.this_cDgopes = TratarNulo(dgopes, "C")
                THIS.this_dDtfechas = TratarNulo(dtfechas, "D")
                THIS.this_nTrfisicos = TratarNulo(trfisicos, "N")
                THIS.this_nUtilizados = TratarNulo(utilizados, "N")
                THIS.this_nValndevs = TratarNulo(valndevs, "N")
                THIS.this_nValobxs = TratarNulo(valobxs, "N")
                THIS.this_cNoforms = TratarNulo(noforms, "C")
                THIS.this_cAuditors = TratarNulo(auditors, "C")
                THIS.this_dDtaudits = TratarNulo(dtaudits, "D")
                THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
                THIS.this_dDtalts = TratarNulo(dtalts, "D")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                THIS.this_dDtbaixas = TratarNulo(dtbaixas, "D")
                THIS.this_dDtrecs = TratarNulo(dtrecs, "D")
                THIS.this_cEmpgopnums = TratarNulo(empgopnums, "C")
                THIS.this_cContaes = TratarNulo(contaes, "C")
                THIS.this_dDtagends = TratarNulo(dtagends, "D")
                THIS.this_nLocalents = TratarNulo(localents, "N")
                THIS.this_cLocalizas = TratarNulo(localizas, "C")
                IF VARTYPE(chkpagos) = "L"
                    THIS.this_lChkpagos = chkpagos
                ELSE
                    THIS.this_lChkpagos = (NVL(chkpagos, 0) = 1)
                ENDIF
                IF VARTYPE(chkpgs) = "L"
                    THIS.this_lChkpgs = chkpgs
                ELSE
                    THIS.this_lChkpgs = (NVL(chkpgs, 0) = 1)
                ENDIF
                THIS.this_cCodtrans = TratarNulo(codtrans, "C")
                THIS.this_dDtbxestqs = TratarNulo(dtbxestqs, "D")
                THIS.this_cEmpdnbxs = TratarNulo(empdnbxs, "C")
                THIS.this_cEmpdncrds = TratarNulo(empdncrds, "C")
                THIS.this_cObsagends = TratarNulo(obsagends, "C")
                THIS.this_cOperadors = TratarNulo(operadors, "C")
                THIS.this_nVcompensas = TratarNulo(vcompensas, "N")
                THIS.this_dDtrtrans = TratarNulo(dtrtrans, "D")
                THIS.this_cMotdscs = TratarNulo(motdscs, "C")
                THIS.this_nNdeclaras = TratarNulo(ndeclaras, "N")
                THIS.this_nNumbalds = TratarNulo(numbalds, "N")
                THIS.this_nNumbals = TratarNulo(numbals, "N")
                THIS.this_nPriors = TratarNulo(priors, "N")
                IF VARTYPE(procbals) = "L"
                    THIS.this_lProcbals = procbals
                ELSE
                    THIS.this_lProcbals = (NVL(procbals, 0) = 1)
                ENDIF
                IF VARTYPE(procdbal) = "L"
                    THIS.this_lProcdbal = procdbal
                ELSE
                    THIS.this_lProcdbal = (NVL(procdbal, 0) = 1)
                ENDIF
                THIS.this_nProtats = TratarNulo(protats, "N")
                THIS.this_cUsupagos = TratarNulo(usupagos, "C")
                THIS.this_cUltgrvs = TratarNulo(ultgrvs, "C")
                THIS.this_cMoeits = TratarNulo(moeits, "C")
                THIS.this_dDtagendfs = TratarNulo(dtagendfs, "D")
                THIS.this_nRnops = TratarNulo(rnops, "N")
                THIS.this_nImpress = TratarNulo(impress, "N")
                THIS.this_dPrzclis = TratarNulo(przclis, "D")
                THIS.this_cPstatus = TratarNulo(pstatus, "C")
                THIS.this_nValvarps = TratarNulo(valvarps, "N")
                THIS.this_cCifccfs = TratarNulo(cifccfs, "C")
                THIS.this_nCupfis = TratarNulo(cupfis, "N")
                THIS.this_nIdconta = TratarNulo(idconta, "N")
                THIS.this_cNcupoms = TratarNulo(ncupoms, "C")
                THIS.this_cStatus = TratarNulo(status, "C")
                THIS.this_nValtrans = TratarNulo(valtrans, "N")
                THIS.this_nImpcpfs = TratarNulo(impcpfs, "N")
                THIS.this_cCcfgnfs = TratarNulo(ccfgnfs, "C")
                THIS.this_cFpubls = TratarNulo(fpubls, "C")
                THIS.this_cJobs = TratarNulo(jobs, "C")
                THIS.this_nPtax1s = TratarNulo(ptax1s, "N")
                THIS.this_nPtax2s = TratarNulo(ptax2s, "N")
                THIS.this_nPtax3s = TratarNulo(ptax3s, "N")
                THIS.this_cObscabmovs = TratarNulo(obscabmovs, "C")
                THIS.this_cCodobs2 = TratarNulo(codobs2, "C")
                THIS.this_nValserfix = TratarNulo(valserfix, "N")
                THIS.this_nPerserfix = TratarNulo(perserfix, "N")
                THIS.this_nValosfix = TratarNulo(valosfix, "N")
                THIS.this_nChkencerra = TratarNulo(chkencerra, "N")
                THIS.this_nPerdesc = TratarNulo(perdesc, "N")
                THIS.this_cCompet = TratarNulo(compet, "C")
                THIS.this_cPedidoweb = TratarNulo(pedidoweb, "C")
                THIS.this_cCdrastreio = TratarNulo(cdrastreio, "C")
                THIS.this_cIdentrega = TratarNulo(identrega, "C")
                THIS.this_cIdtransp = TratarNulo(idtransp, "C")
                THIS.this_nPeracresc = TratarNulo(peracresc, "N")
                THIS.this_cTpmovs = TratarNulo(tpmovs, "C")
                THIS.this_cEmpfats = TratarNulo(empfats, "C")
                THIS.this_cNumeronota = TratarNulo(numeronota, "C")
                THIS.this_cMeiotrans = TratarNulo(meiotrans, "C")
                THIS.this_cChavenota = TratarNulo(chavenota, "C")
                THIS.this_cContaccs = TratarNulo(contaccs, "C")
                THIS.this_cGrupoccs = TratarNulo(grupoccs, "C")
                THIS.this_nNatend = TratarNulo(natend, "N")
                THIS.this_nNlivdg = TratarNulo(nlivdg, "N")
                THIS.this_nPresente = TratarNulo(presente, "N")
                THIS.this_cChaveexterna = TratarNulo(chaveexterna, "C")
                THIS.this_cEmpret = TratarNulo(empret, "C")
                THIS.this_cMsgpresnte = TratarNulo(msgpresnte, "C")
                THIS.this_nCkoperpend = TratarNulo(ckoperpend, "N")
                THIS.this_dDtfabricacao = TratarNulo(dtfabricacao, "D")
                THIS.this_dDtvalidade = TratarNulo(dtvalidade, "D")
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "C")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvcabBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigMvCab
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCab ("
            loc_cSQL = loc_cSQL + "npedclis, acres, antecs, chksubn, codpeds, contads, contaos, datars,"
            loc_cSQL = loc_cSQL + "datas, datatrans, desc2s, descs, devols, dopes, empds, emps,"
            loc_cSQL = loc_cSQL + "grresps, grupods, grupoos, grupos, grvends, iclis, ifors, locals,"
            loc_cSQL = loc_cSQL + "lotechqs, lprecos, mascnum, ncarnecs, nemps, nops, notas, nrcons,"
            loc_cSQL = loc_cSQL + "ntrans, numes, numolds, obses, opers, prazoents, resps, tabds,"
            loc_cSQL = loc_cSQL + "tpfats, transps, usuals, usuars, usulibs, valacres, valdes2s, valdescs,"
            loc_cSQL = loc_cSQL + "valdevs, valencs, valinis, valos, valservs, valvars, vars, vends,"
            loc_cSQL = loc_cSQL + "cotusus, dtemis, espes, pbrus, pliqs, qtdes, lcancelas, cofs,"
            loc_cSQL = loc_cSQL + "livros, dttransms, chkbxparcs, ecfs, codobs, dgopes, dtfechas, trfisicos,"
            loc_cSQL = loc_cSQL + "utilizados, valndevs, valobxs, noforms, auditors, dtaudits, cidchaves, dtalts,"
            loc_cSQL = loc_cSQL + "empdopnums, dtbaixas, dtrecs, empgopnums, contaes, dtagends, localents, localizas,"
            loc_cSQL = loc_cSQL + "chkpagos, chkpgs, codtrans, dtbxestqs, empdnbxs, empdncrds, obsagends, operadors,"
            loc_cSQL = loc_cSQL + "vcompensas, dtrtrans, motdscs, ndeclaras, numbalds, numbals, priors, procbals,"
            loc_cSQL = loc_cSQL + "procdbal, protats, usupagos, ultgrvs, moeits, dtagendfs, rnops, impress,"
            loc_cSQL = loc_cSQL + "przclis, pstatus, valvarps, cifccfs, cupfis, idconta, ncupoms, status,"
            loc_cSQL = loc_cSQL + "valtrans, impcpfs, ccfgnfs, fpubls, jobs, ptax1s, ptax2s, ptax3s,"
            loc_cSQL = loc_cSQL + "obscabmovs, codobs2, valserfix, perserfix, valosfix, chkencerra, perdesc, compet,"
            loc_cSQL = loc_cSQL + "pedidoweb, cdrastreio, identrega, idtransp, peracresc, tpmovs, empfats, numeronota,"
            loc_cSQL = loc_cSQL + "meiotrans, chavenota, contaccs, grupoccs, natend, nlivdg, presente, chaveexterna,"
            loc_cSQL = loc_cSQL + "empret, msgpresnte, ckoperpend, dtfabricacao, dtvalidade, usuconfs"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNpedclis, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nAcres, 4) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAntecs, 6)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChksubn, 1, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCodpeds, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContads, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContaos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatars) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDesc2s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDescs, 4) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDevols, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cIclis, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cIfors, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nLotechqs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNcarnecs, 11)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNemps, 40)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNops, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNrcons, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumolds, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObses) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dPrazoents) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cResps, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTabds, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lTransps, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuals, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsulibs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValacres, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValdes2s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValdescs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValdevs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValencs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValinis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValservs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValvars, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVars, 4) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVends, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPbrus, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPliqs, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lLcancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lCofs, 1, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lLivros, 1, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDttransms) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChkbxparcs, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCodobs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDgopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtfechas) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTrfisicos, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUtilizados, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValndevs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValobxs, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNoforms, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtalts) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtbaixas) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtrecs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpgopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContaes, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtagends) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nLocalents, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocalizas, 6)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChkpagos, 1, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChkpgs, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtbxestqs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdnbxs, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdncrds, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObsagends, 15)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOperadors, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVcompensas, 2) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtrtrans) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNdeclaras, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumbalds, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumbals, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPriors, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lProcbals, 1, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lProcdbal, 1, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nProtats, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUltgrvs, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoeits, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtagendfs) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRnops, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpress, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dPrzclis) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPstatus, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValvarps, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCifccfs, 6)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCupfis, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIdconta, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNcupoms, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cStatus, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValtrans, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpcpfs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCcfgnfs, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cFpubls, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPtax1s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPtax2s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPtax3s, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cObscabmovs, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodobs2, 60)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValserfix, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPerserfix, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValosfix, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nChkencerra, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPerdesc, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCompet, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPedidoweb, 50)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCdrastreio, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cIdentrega, 50)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cIdtransp, 15)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPeracresc, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpmovs, 2)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpfats, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNumeronota, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMeiotrans, 50)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChavenota, 44)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContaccs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupoccs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNatend, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNlivdg, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPresente, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpret, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMsgpresnte, 150)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCkoperpend, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtfabricacao) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtvalidade) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

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
            MsgErro(loException.Message, "Erro em sigmvcabBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigMvCab (por cidchaves)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Emps + Dopes + Numes (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Data de alteracao
            THIS.this_dDtalts = DATETIME()

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCab SET"
            loc_cSQL = loc_cSQL + " npedclis = " + FormatarNumeroSQL(THIS.this_nNpedclis, 0) + ","
            loc_cSQL = loc_cSQL + " acres = " + FormatarNumeroSQL(THIS.this_nAcres, 4) + ","
            loc_cSQL = loc_cSQL + " antecs = " + EscaparSQL(LEFT(THIS.this_cAntecs, 6)) + ","
            loc_cSQL = loc_cSQL + " chksubn = " + IIF(THIS.this_lChksubn, 1, 0) + ","
            loc_cSQL = loc_cSQL + " codpeds = " + FormatarNumeroSQL(THIS.this_nCodpeds, 0) + ","
            loc_cSQL = loc_cSQL + " contads = " + EscaparSQL(LEFT(THIS.this_cContads, 10)) + ","
            loc_cSQL = loc_cSQL + " contaos = " + EscaparSQL(LEFT(THIS.this_cContaos, 10)) + ","
            loc_cSQL = loc_cSQL + " datars = " + FormatarDataSQL(THIS.this_dDatars) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + " desc2s = " + FormatarNumeroSQL(THIS.this_nDesc2s, 2) + ","
            loc_cSQL = loc_cSQL + " descs = " + FormatarNumeroSQL(THIS.this_nDescs, 4) + ","
            loc_cSQL = loc_cSQL + " devols = " + FormatarNumeroSQL(THIS.this_nDevols, 0) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " empds = " + EscaparSQL(LEFT(THIS.this_cEmpds, 3)) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grresps = " + EscaparSQL(LEFT(THIS.this_cGrresps, 10)) + ","
            loc_cSQL = loc_cSQL + " grupods = " + EscaparSQL(LEFT(THIS.this_cGrupods, 10)) + ","
            loc_cSQL = loc_cSQL + " grupoos = " + EscaparSQL(LEFT(THIS.this_cGrupoos, 10)) + ","
            loc_cSQL = loc_cSQL + " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " grvends = " + EscaparSQL(LEFT(THIS.this_cGrvends, 10)) + ","
            loc_cSQL = loc_cSQL + " iclis = " + EscaparSQL(LEFT(THIS.this_cIclis, 10)) + ","
            loc_cSQL = loc_cSQL + " ifors = " + EscaparSQL(LEFT(THIS.this_cIfors, 10)) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " lotechqs = " + FormatarNumeroSQL(THIS.this_nLotechqs, 0) + ","
            loc_cSQL = loc_cSQL + " lprecos = " + EscaparSQL(LEFT(THIS.this_cLprecos, 30)) + ","
            loc_cSQL = loc_cSQL + " mascnum = " + EscaparSQL(LEFT(THIS.this_cMascnum, 10)) + ","
            loc_cSQL = loc_cSQL + " ncarnecs = " + EscaparSQL(LEFT(THIS.this_cNcarnecs, 11)) + ","
            loc_cSQL = loc_cSQL + " nemps = " + EscaparSQL(LEFT(THIS.this_cNemps, 40)) + ","
            loc_cSQL = loc_cSQL + " nops = " + FormatarNumeroSQL(THIS.this_nNops, 0) + ","
            loc_cSQL = loc_cSQL + " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + " nrcons = " + EscaparSQL(LEFT(THIS.this_cNrcons, 10)) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " numolds = " + FormatarNumeroSQL(THIS.this_nNumolds, 0) + ","
            loc_cSQL = loc_cSQL + " obses = " + EscaparSQL(THIS.this_cObses) + ","
            loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + " prazoents = " + FormatarDataSQL(THIS.this_dPrazoents) + ","
            loc_cSQL = loc_cSQL + " resps = " + EscaparSQL(LEFT(THIS.this_cResps, 10)) + ","
            loc_cSQL = loc_cSQL + " tabds = " + EscaparSQL(LEFT(THIS.this_cTabds, 10)) + ","
            loc_cSQL = loc_cSQL + " tpfats = " + EscaparSQL(LEFT(THIS.this_cTpfats, 3)) + ","
            loc_cSQL = loc_cSQL + " transps = " + IIF(THIS.this_lTransps, 1, 0) + ","
            loc_cSQL = loc_cSQL + " usuals = " + EscaparSQL(LEFT(THIS.this_cUsuals, 10)) + ","
            loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
            loc_cSQL = loc_cSQL + " usulibs = " + EscaparSQL(LEFT(THIS.this_cUsulibs, 10)) + ","
            loc_cSQL = loc_cSQL + " valacres = " + FormatarNumeroSQL(THIS.this_nValacres, 2) + ","
            loc_cSQL = loc_cSQL + " valdes2s = " + FormatarNumeroSQL(THIS.this_nValdes2s, 2) + ","
            loc_cSQL = loc_cSQL + " valdescs = " + FormatarNumeroSQL(THIS.this_nValdescs, 2) + ","
            loc_cSQL = loc_cSQL + " valdevs = " + FormatarNumeroSQL(THIS.this_nValdevs, 2) + ","
            loc_cSQL = loc_cSQL + " valencs = " + FormatarNumeroSQL(THIS.this_nValencs, 2) + ","
            loc_cSQL = loc_cSQL + " valinis = " + FormatarNumeroSQL(THIS.this_nValinis, 2) + ","
            loc_cSQL = loc_cSQL + " valos = " + FormatarNumeroSQL(THIS.this_nValos, 2) + ","
            loc_cSQL = loc_cSQL + " valservs = " + FormatarNumeroSQL(THIS.this_nValservs, 2) + ","
            loc_cSQL = loc_cSQL + " valvars = " + FormatarNumeroSQL(THIS.this_nValvars, 2) + ","
            loc_cSQL = loc_cSQL + " vars = " + FormatarNumeroSQL(THIS.this_nVars, 4) + ","
            loc_cSQL = loc_cSQL + " vends = " + EscaparSQL(LEFT(THIS.this_cVends, 10)) + ","
            loc_cSQL = loc_cSQL + " cotusus = " + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + " dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + " espes = " + EscaparSQL(LEFT(THIS.this_cEspes, 10)) + ","
            loc_cSQL = loc_cSQL + " pbrus = " + FormatarNumeroSQL(THIS.this_nPbrus, 3) + ","
            loc_cSQL = loc_cSQL + " pliqs = " + FormatarNumeroSQL(THIS.this_nPliqs, 3) + ","
            loc_cSQL = loc_cSQL + " qtdes = " + FormatarNumeroSQL(THIS.this_nQtdes, 0) + ","
            loc_cSQL = loc_cSQL + " lcancelas = " + IIF(THIS.this_lLcancelas, 1, 0) + ","
            loc_cSQL = loc_cSQL + " cofs = " + IIF(THIS.this_lCofs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " livros = " + IIF(THIS.this_lLivros, 1, 0) + ","
            loc_cSQL = loc_cSQL + " dttransms = " + FormatarDataSQL(THIS.this_dDttransms) + ","
            loc_cSQL = loc_cSQL + " chkbxparcs = " + IIF(THIS.this_lChkbxparcs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " ecfs = " + EscaparSQL(LEFT(THIS.this_cEcfs, 7)) + ","
            loc_cSQL = loc_cSQL + " codobs = " + FormatarNumeroSQL(THIS.this_nCodobs, 0) + ","
            loc_cSQL = loc_cSQL + " dgopes = " + EscaparSQL(LEFT(THIS.this_cDgopes, 20)) + ","
            loc_cSQL = loc_cSQL + " dtfechas = " + FormatarDataSQL(THIS.this_dDtfechas) + ","
            loc_cSQL = loc_cSQL + " trfisicos = " + FormatarNumeroSQL(THIS.this_nTrfisicos, 0) + ","
            loc_cSQL = loc_cSQL + " utilizados = " + FormatarNumeroSQL(THIS.this_nUtilizados, 0) + ","
            loc_cSQL = loc_cSQL + " valndevs = " + FormatarNumeroSQL(THIS.this_nValndevs, 2) + ","
            loc_cSQL = loc_cSQL + " valobxs = " + FormatarNumeroSQL(THIS.this_nValobxs, 2) + ","
            loc_cSQL = loc_cSQL + " noforms = " + EscaparSQL(LEFT(THIS.this_cNoforms, 10)) + ","
            loc_cSQL = loc_cSQL + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + " dtaudits = " + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + " dtalts = " + FormatarDataSQL(THIS.this_dDtalts) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " dtbaixas = " + FormatarDataSQL(THIS.this_dDtbaixas) + ","
            loc_cSQL = loc_cSQL + " dtrecs = " + FormatarDataSQL(THIS.this_dDtrecs) + ","
            loc_cSQL = loc_cSQL + " empgopnums = " + EscaparSQL(LEFT(THIS.this_cEmpgopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " contaes = " + EscaparSQL(LEFT(THIS.this_cContaes, 10)) + ","
            loc_cSQL = loc_cSQL + " dtagends = " + FormatarDataSQL(THIS.this_dDtagends) + ","
            loc_cSQL = loc_cSQL + " localents = " + FormatarNumeroSQL(THIS.this_nLocalents, 0) + ","
            loc_cSQL = loc_cSQL + " localizas = " + EscaparSQL(LEFT(THIS.this_cLocalizas, 6)) + ","
            loc_cSQL = loc_cSQL + " chkpagos = " + IIF(THIS.this_lChkpagos, 1, 0) + ","
            loc_cSQL = loc_cSQL + " chkpgs = " + IIF(THIS.this_lChkpgs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " codtrans = " + EscaparSQL(LEFT(THIS.this_cCodtrans, 10)) + ","
            loc_cSQL = loc_cSQL + " dtbxestqs = " + FormatarDataSQL(THIS.this_dDtbxestqs) + ","
            loc_cSQL = loc_cSQL + " empdnbxs = " + EscaparSQL(LEFT(THIS.this_cEmpdnbxs, 29)) + ","
            loc_cSQL = loc_cSQL + " empdncrds = " + EscaparSQL(LEFT(THIS.this_cEmpdncrds, 29)) + ","
            loc_cSQL = loc_cSQL + " obsagends = " + EscaparSQL(LEFT(THIS.this_cObsagends, 15)) + ","
            loc_cSQL = loc_cSQL + " operadors = " + EscaparSQL(LEFT(THIS.this_cOperadors, 10)) + ","
            loc_cSQL = loc_cSQL + " vcompensas = " + FormatarNumeroSQL(THIS.this_nVcompensas, 2) + ","
            loc_cSQL = loc_cSQL + " dtrtrans = " + FormatarDataSQL(THIS.this_dDtrtrans) + ","
            loc_cSQL = loc_cSQL + " motdscs = " + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + " ndeclaras = " + FormatarNumeroSQL(THIS.this_nNdeclaras, 0) + ","
            loc_cSQL = loc_cSQL + " numbalds = " + FormatarNumeroSQL(THIS.this_nNumbalds, 0) + ","
            loc_cSQL = loc_cSQL + " numbals = " + FormatarNumeroSQL(THIS.this_nNumbals, 0) + ","
            loc_cSQL = loc_cSQL + " priors = " + FormatarNumeroSQL(THIS.this_nPriors, 0) + ","
            loc_cSQL = loc_cSQL + " procbals = " + IIF(THIS.this_lProcbals, 1, 0) + ","
            loc_cSQL = loc_cSQL + " procdbal = " + IIF(THIS.this_lProcdbal, 1, 0) + ","
            loc_cSQL = loc_cSQL + " protats = " + FormatarNumeroSQL(THIS.this_nProtats, 0) + ","
            loc_cSQL = loc_cSQL + " usupagos = " + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + " ultgrvs = " + EscaparSQL(LEFT(THIS.this_cUltgrvs, 40)) + ","
            loc_cSQL = loc_cSQL + " moeits = " + EscaparSQL(LEFT(THIS.this_cMoeits, 3)) + ","
            loc_cSQL = loc_cSQL + " dtagendfs = " + FormatarDataSQL(THIS.this_dDtagendfs) + ","
            loc_cSQL = loc_cSQL + " rnops = " + FormatarNumeroSQL(THIS.this_nRnops, 0) + ","
            loc_cSQL = loc_cSQL + " impress = " + FormatarNumeroSQL(THIS.this_nImpress, 0) + ","
            loc_cSQL = loc_cSQL + " przclis = " + FormatarDataSQL(THIS.this_dPrzclis) + ","
            loc_cSQL = loc_cSQL + " pstatus = " + EscaparSQL(LEFT(THIS.this_cPstatus, 1)) + ","
            loc_cSQL = loc_cSQL + " valvarps = " + FormatarNumeroSQL(THIS.this_nValvarps, 2) + ","
            loc_cSQL = loc_cSQL + " cifccfs = " + EscaparSQL(LEFT(THIS.this_cCifccfs, 6)) + ","
            loc_cSQL = loc_cSQL + " cupfis = " + FormatarNumeroSQL(THIS.this_nCupfis, 0) + ","
            loc_cSQL = loc_cSQL + " idconta = " + FormatarNumeroSQL(THIS.this_nIdconta, 0) + ","
            loc_cSQL = loc_cSQL + " ncupoms = " + EscaparSQL(LEFT(THIS.this_cNcupoms, 6)) + ","
            loc_cSQL = loc_cSQL + " status = " + EscaparSQL(LEFT(THIS.this_cStatus, 3)) + ","
            loc_cSQL = loc_cSQL + " valtrans = " + FormatarNumeroSQL(THIS.this_nValtrans, 2) + ","
            loc_cSQL = loc_cSQL + " impcpfs = " + FormatarNumeroSQL(THIS.this_nImpcpfs, 0) + ","
            loc_cSQL = loc_cSQL + " ccfgnfs = " + EscaparSQL(LEFT(THIS.this_cCcfgnfs, 6)) + ","
            loc_cSQL = loc_cSQL + " fpubls = " + EscaparSQL(LEFT(THIS.this_cFpubls, 3)) + ","
            loc_cSQL = loc_cSQL + " jobs = " + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + " ptax1s = " + FormatarNumeroSQL(THIS.this_nPtax1s, 2) + ","
            loc_cSQL = loc_cSQL + " ptax2s = " + FormatarNumeroSQL(THIS.this_nPtax2s, 2) + ","
            loc_cSQL = loc_cSQL + " ptax3s = " + FormatarNumeroSQL(THIS.this_nPtax3s, 2) + ","
            loc_cSQL = loc_cSQL + " obscabmovs = " + EscaparSQL(LEFT(THIS.this_cObscabmovs, 40)) + ","
            loc_cSQL = loc_cSQL + " codobs2 = " + EscaparSQL(LEFT(THIS.this_cCodobs2, 60)) + ","
            loc_cSQL = loc_cSQL + " valserfix = " + FormatarNumeroSQL(THIS.this_nValserfix, 2) + ","
            loc_cSQL = loc_cSQL + " perserfix = " + FormatarNumeroSQL(THIS.this_nPerserfix, 2) + ","
            loc_cSQL = loc_cSQL + " valosfix = " + FormatarNumeroSQL(THIS.this_nValosfix, 2) + ","
            loc_cSQL = loc_cSQL + " chkencerra = " + FormatarNumeroSQL(THIS.this_nChkencerra, 0) + ","
            loc_cSQL = loc_cSQL + " perdesc = " + FormatarNumeroSQL(THIS.this_nPerdesc, 2) + ","
            loc_cSQL = loc_cSQL + " compet = " + EscaparSQL(LEFT(THIS.this_cCompet, 10)) + ","
            loc_cSQL = loc_cSQL + " pedidoweb = " + EscaparSQL(LEFT(THIS.this_cPedidoweb, 50)) + ","
            loc_cSQL = loc_cSQL + " cdrastreio = " + EscaparSQL(LEFT(THIS.this_cCdrastreio, 20)) + ","
            loc_cSQL = loc_cSQL + " identrega = " + EscaparSQL(LEFT(THIS.this_cIdentrega, 50)) + ","
            loc_cSQL = loc_cSQL + " idtransp = " + EscaparSQL(LEFT(THIS.this_cIdtransp, 15)) + ","
            loc_cSQL = loc_cSQL + " peracresc = " + FormatarNumeroSQL(THIS.this_nPeracresc, 2) + ","
            loc_cSQL = loc_cSQL + " tpmovs = " + EscaparSQL(LEFT(THIS.this_cTpmovs, 2)) + ","
            loc_cSQL = loc_cSQL + " empfats = " + EscaparSQL(LEFT(THIS.this_cEmpfats, 3)) + ","
            loc_cSQL = loc_cSQL + " numeronota = " + EscaparSQL(LEFT(THIS.this_cNumeronota, 10)) + ","
            loc_cSQL = loc_cSQL + " meiotrans = " + EscaparSQL(LEFT(THIS.this_cMeiotrans, 50)) + ","
            loc_cSQL = loc_cSQL + " chavenota = " + EscaparSQL(LEFT(THIS.this_cChavenota, 44)) + ","
            loc_cSQL = loc_cSQL + " contaccs = " + EscaparSQL(LEFT(THIS.this_cContaccs, 10)) + ","
            loc_cSQL = loc_cSQL + " grupoccs = " + EscaparSQL(LEFT(THIS.this_cGrupoccs, 10)) + ","
            loc_cSQL = loc_cSQL + " natend = " + FormatarNumeroSQL(THIS.this_nNatend, 0) + ","
            loc_cSQL = loc_cSQL + " nlivdg = " + FormatarNumeroSQL(THIS.this_nNlivdg, 0) + ","
            loc_cSQL = loc_cSQL + " presente = " + FormatarNumeroSQL(THIS.this_nPresente, 0) + ","
            loc_cSQL = loc_cSQL + " chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ","
            loc_cSQL = loc_cSQL + " empret = " + EscaparSQL(LEFT(THIS.this_cEmpret, 3)) + ","
            loc_cSQL = loc_cSQL + " msgpresnte = " + EscaparSQL(LEFT(THIS.this_cMsgpresnte, 150)) + ","
            loc_cSQL = loc_cSQL + " ckoperpend = " + FormatarNumeroSQL(THIS.this_nCkoperpend, 0) + ","
            loc_cSQL = loc_cSQL + " dtfabricacao = " + FormatarDataSQL(THIS.this_dDtfabricacao) + ","
            loc_cSQL = loc_cSQL + " dtvalidade = " + FormatarDataSQL(THIS.this_dDtvalidade) + ","
            loc_cSQL = loc_cSQL + " usuconfs = " + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

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
            MsgErro(loException.Message, "Erro em sigmvcabBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro de SigMvCab (por cidchaves)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigMvCab WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "sigmvcabBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Lista movimentos para o Grid da Page1 (cursor_4c_Dados)
    * Colunas: Emps, Dopes, Numes, Datas, ContaOs, ContaDs, Valos, cidchaves
    * TOP 300 ORDER BY Datas DESC: SigMvCab acumula todo o historico de
    * movimentacao (tabela de milhoes de linhas); sem os filtros de
    * periodo/empresa da tela legada (fase futura), limitar o volume
    * evita carregar a tabela inteira no Grid. Filtro extra (ex.: busca
    * por cidchaves) se sobrepoe ao TOP 300 normalmente.
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 300 Emps, Dopes, Numes, Datas, ContaOs, ContaDs," + ;
                " Valos, cidchaves FROM SigMvCab"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Datas DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar movimenta" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "sigmvcabBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigMvCab WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "sigmvcabBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
