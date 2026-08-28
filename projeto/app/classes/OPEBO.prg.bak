*====================================================================
* OPEBO.prg
*
* Business Object para Cadastro de Tipos de Operacao
* Tabela: SigCdOpe
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS OPEBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdOpe)
    *-- PK
    this_cDopes         = ""    && dopes char(20) - PK
    *-- numeric(1,0) flags / boolean-like
    this_nPedclis       = 0     && pedclis numeric(1,0)
    this_nZerqtds       = 0     && zerqtds numeric(1,0)
    this_nValinotas     = 0     && valinotas numeric(1,0)
    this_nValitems      = 0     && valitems numeric(1,0)
    this_nExibsits      = 0     && exibsits numeric(1,0)
    this_nChkqtds       = 0     && chkqtds numeric(1,0)
    this_nDtcontab      = 0     && dtcontab numeric(1,0)
    this_nAltdescs      = 0     && altdescs numeric(1,0)
    this_nAntecs        = 0     && antecs numeric(1,0)
    this_nAptpfats      = 0     && aptpfats numeric(1,0)
    this_nArreds        = 0     && arreds numeric(1,0)
    this_nBaixasns      = 0     && baixasns numeric(1,0)
    this_nBxautos       = 0     && bxautos numeric(1,0)
    this_nBxparcials    = 0     && bxparcials numeric(1,0)
    this_nCadclis       = 0     && cadclis numeric(1,0)
    this_nCaixas        = 0     && caixas numeric(1,0)
    this_nCalcfecs      = 0     && calcfecs numeric(1,0)
    this_nCarnes        = 0     && carnes numeric(1,0)
    this_nCcomis        = 0     && ccomis numeric(1,0)
    this_nCdesps        = 0     && cdesps numeric(1,0)
    this_nChdtentrs     = 0     && chdtentrs numeric(1,0)
    this_nCheqs         = 0     && cheqs numeric(1,0)
    this_nCodbars       = 0     && codbars numeric(1,0)
    this_nComcargs      = 0     && comcargs numeric(1,0)
    this_nCondsubs      = 0     && condsubs numeric(1,0)
    this_nConfes        = 0     && confes numeric(1,0)
    this_nConosubs      = 0     && conosubs numeric(1,0)
    this_nConsclis      = 0     && consclis numeric(1,0)
    this_nConsers       = 0     && consers numeric(1,0)
    this_nConsgs        = 0     && consgs numeric(1,0)
    this_nCopers        = 0     && copers numeric(1,0)
    this_nCrepls        = 0     && crepls numeric(1,0)
    this_nCtipos        = 0     && ctipos numeric(1,0)
    this_nCupfis        = 0     && cupfis numeric(1,0)
    this_nDeacrs        = 0     && deacrs numeric(1,0)
    this_nDesmembs      = 0     && desmembs numeric(1,0)
    this_nDestinos      = 0     && destinos numeric(1,0)
    this_nDfpags        = 0     && dfpags numeric(1,0)
    this_nDigdoc        = 0     && digdoc numeric(1,0)
    this_nDigitens      = 0     && digitens numeric(1,0)
    this_nDigobs        = 0     && digobs numeric(1,0)
    this_nDtentrs       = 0     && dtentrs numeric(1,0)
    this_nEdcotas       = 0     && edcotas numeric(1,0)
    this_nEdtpfats      = 0     && edtpfats numeric(1,0)
    this_nEfators       = 0     && efators numeric(1,0)
    this_nEpesos        = 0     && epesos numeric(1,0)
    this_nEprecos       = 0     && eprecos numeric(1,0)
    this_nEstdests      = 0     && estdests numeric(1,0)
    this_nEstoqs        = 0     && estoqs numeric(1,0)
    this_nEstorigs      = 0     && estorigs numeric(1,0)
    this_nExpends       = 0     && expends numeric(1,0)
    this_nFatauts       = 0     && fatauts numeric(1,0)
    this_nGlobalizas    = 0     && globalizas numeric(1,0)
    this_nImagems       = 0     && imagems numeric(1,0)
    this_nItemalfas     = 0     && itemalfas numeric(1,0)
    this_nItemzeros     = 0     && itemzeros numeric(1,0)
    this_nLimcres       = 0     && limcres numeric(1,0)
    this_nLimpauts      = 0     && limpauts numeric(1,0)
    this_nLprecos       = 0     && lprecos numeric(1,0)
    this_nMestoqs       = 0     && mestoqs numeric(1,0)
    this_nNdebitos      = 0     && ndebitos numeric(1,0)
    this_nNfiscals      = 0     && nfiscals numeric(1,0)
    this_nNumeras       = 0     && numeras numeric(1,0)
    this_nOpcrs         = 0     && opcrs numeric(1,0)
    this_nOpers         = 0     && opers numeric(1,0)
    this_nOrigems       = 0     && origems numeric(1,0)
    this_nParautos      = 0     && parautos numeric(1,0)
    this_nParcontas     = 0     && parcontas numeric(1,0)
    this_nParcs         = 0     && parcs numeric(1,0)
    this_nParrecals     = 0     && parrecals numeric(1,0)
    this_nPesoauts      = 0     && pesoauts numeric(1,0)
    this_nPesods        = 0     && pesods numeric(1,0)
    this_nPesos         = 0     && pesos numeric(1,0)
    this_nPesovts       = 0     && pesovts numeric(1,0)
    this_nPrecoauts     = 0     && precoauts numeric(1,0)
    this_nPrecods       = 0     && precods numeric(1,0)
    this_nPrecovts      = 0     && precovts numeric(1,0)
    this_nProduc        = 0     && produc numeric(1,0)
    this_nQtdpesos      = 0     && qtdpesos numeric(1,0)
    this_nQtdprecos     = 0     && qtdprecos numeric(1,0)
    this_nQtdrelevs     = 0     && qtdrelevs numeric(1,0)
    this_nRelfechas     = 0     && relfechas numeric(1,0)
    this_nReservas      = 0     && reservas numeric(1,0)
    this_nResults       = 0     && results numeric(1,0)
    this_nSituas        = 0     && situas numeric(1,0)
    this_nSubns         = 0     && subns numeric(1,0)
    this_nTabdescs      = 0     && tabdescs numeric(1,0)
    this_nTransons      = 0     && transons numeric(1,0)
    this_nTransps       = 0     && transps numeric(1,0)
    this_nTranss        = 0     && transs numeric(1,0)
    this_nUnitpesos     = 0     && unitpesos numeric(1,0)
    this_nValests       = 0     && valests numeric(1,0)
    this_nValpends      = 0     && valpends numeric(1,0)
    this_nValpres       = 0     && valpres numeric(1,0)
    this_nVars          = 0     && vars numeric(1,0)
    this_nVendas        = 0     && vendas numeric(1,0)
    this_nVendes        = 0     && vendes numeric(1,0)
    this_nSemetiqs      = 0     && semetiqs numeric(1,0)
    this_nCasas         = 0     && casas numeric(1,0)
    this_nAlttrans      = 0     && alttrans numeric(1,0)
    this_nDadosnotas    = 0     && dadosnotas numeric(1,0)
    this_nObsdests      = 0     && obsdests numeric(1,0)
    this_nObsorigs      = 0     && obsorigs numeric(1,0)
    this_nServicos      = 0     && servicos numeric(1,0)
    this_nSubnobrigs    = 0     && subnobrigs numeric(1,0)
    this_nTphist2s      = 0     && tphist2s numeric(1,0)
    this_nTphists       = 0     && tphists numeric(1,0)
    this_nBlqdatas      = 0     && blqdatas numeric(1,0)
    this_nSenhads       = 0     && senhads numeric(1,0)
    this_nSenhaos       = 0     && senhaos numeric(1,0)
    this_nDemocreds     = 0     && democreds numeric(1,0)
    this_nDigcpfs       = 0     && digcpfs numeric(1,0)
    this_nCongvends     = 0     && congvends numeric(1,0)
    this_nChkqtdss      = 0     && chkqtdss numeric(1,0)
    this_nValitnegs     = 0     && valitnegs numeric(1,0)
    this_nCalcmos       = 0     && calcmos numeric(1,0)
    this_nChkdval       = 0     && chkdval numeric(1,0)
    this_nTabdobrigs    = 0     && tabdobrigs numeric(1,0)
    this_nDtemis        = 0     && dtemis numeric(1,0)
    this_nConprecs      = 0     && conprecs numeric(1,0)
    this_nTrocoauts     = 0     && trocoauts numeric(1,0)
    this_nParczeros     = 0     && parczeros numeric(1,0)
    this_nBxvlopcrs     = 0     && bxvlopcrs numeric(1,0)
    this_nCadcliauts    = 0     && cadcliauts numeric(1,0)
    this_nObsitems      = 0     && obsitems numeric(1,0)
    this_nVaritems      = 0     && varitems numeric(1,0)
    this_nItsituas      = 0     && itsituas numeric(1,0)
    this_nHabsubits     = 0     && habsubits numeric(1,0)
    this_nOppends       = 0     && oppends numeric(1,0)
    this_nCadprods      = 0     && cadprods numeric(1,0)
    this_nSubnautos     = 0     && subnautos numeric(1,0)
    this_nSenhars       = 0     && senhars numeric(1,0)
    this_nTotcompos     = 0     && totcompos numeric(1,0)
    this_nChkedesc      = 0     && chkedesc numeric(1,0)
    this_nNcpesos       = 0     && ncpesos numeric(1,0)
    this_nEditdocs      = 0     && editdocs numeric(1,0)
    this_nCempsubns     = 0     && cempsubns numeric(1,0)
    this_nCarcbars      = 0     && carcbars numeric(1,0)
    this_nCtrllotes     = 0     && ctrllotes numeric(1,0)
    this_nOrilotes      = 0     && orilotes numeric(1,0)
    this_nReffs         = 0     && reffs numeric(1,0)
    this_nCcustos       = 0     && ccustos numeric(1,0)
    this_nDcpns         = 0     && dcpns numeric(1,0)
    this_nDtbars        = 0     && dtbars numeric(1,0)
    this_nAciosens      = 0     && aciosens numeric(1,0)
    this_nCliods        = 0     && cliods numeric(1,0)
    this_nEdcomis       = 0     && edcomis numeric(1,0)
    this_nInfoipis      = 0     && infoipis numeric(1,0)
    this_nAgrupas       = 0     && agrupas numeric(1,0)
    this_nDigenves      = 0     && digenves numeric(1,0)
    this_nDigrecs       = 0     && digrecs numeric(1,0)
    this_nEmpsubns      = 0     && empsubns numeric(1,0)
    this_nFechmals      = 0     && fechmals numeric(1,0)
    this_nHabservs      = 0     && habservs numeric(1,0)
    this_nMarcasubns    = 0     && marcasubns numeric(1,0)
    this_nTiponfs       = 0     && tiponfs numeric(1,0)
    this_nChkacpro      = 0     && chkacpro numeric(1,0)
    this_nEdunis        = 0     && edunis numeric(1,0)
    this_nAnprodzs      = 0     && anprodzs numeric(1,0)
    this_nAutenticas    = 0     && autenticas numeric(1,0)
    this_nAutoins       = 0     && autoins numeric(1,0)
    this_nBxpagos       = 0     && bxpagos numeric(1,0)
    this_nCarvends      = 0     && carvends numeric(1,0)
    this_nCbxsubns      = 0     && cbxsubns numeric(1,0)
    this_nChecpagos     = 0     && checpagos numeric(1,0)
    this_nChkagends     = 0     && chkagends numeric(1,0)
    this_nInibcchqs     = 0     && inibcchqs numeric(1,0)
    this_nInibmens      = 0     && inibmens numeric(1,0)
    this_nInibmlcs      = 0     && inibmlcs numeric(1,0)
    this_nNcarsubs      = 0     && ncarsubs numeric(1,0)
    this_nObrigvd2s     = 0     && obrigvd2s numeric(1,0)
    this_nObrigvds      = 0     && obrigvds numeric(1,0)
    this_nTplprecs      = 0     && tplprecs numeric(1,0)
    this_nFpubl         = 0     && fpubl numeric(1,0)
    this_nNfcompls      = 0     && nfcompls numeric(1,0)
    *-- numeric(2,0)
    this_nDocus         = 0     && docus numeric(2,0)
    this_nItautos       = 0     && itautos numeric(2,0)
    this_nPrecops       = 0     && precops numeric(2,0)
    this_nComisdivs     = 0     && comisdivs numeric(2,0)
    this_nTipoops       = 0     && tipoops numeric(2,0)
    this_nTrnfis        = 0     && trnfis numeric(2,0)
    *-- numeric(3,0)
    this_nObspads       = 0     && obspads numeric(3,0)
    this_nObsfins       = 0     && obsfins numeric(3,0)
    this_nObsinis       = 0     && obsinis numeric(3,0)
    this_nCdopes        = 0     && cdopes numeric(3,0)
    *-- numeric(4,0)
    this_nNdopes        = 0     && ndopes numeric(4,0)
    this_nOrdes         = 0     && ordes numeric(4,0)
    this_nQtdites       = 0     && qtdites numeric(4,0)
    *-- numeric(5,2)
    this_nPorcs         = 0     && porcs numeric(5,2)
    this_nVcompensas    = 0     && vcompensas numeric(5,2)
    *-- bit columns
    this_lFixcdests     = .F.   && fixcdests bit
    this_lFixcnopes     = .F.   && fixcnopes bit
    this_lFixcorigs     = .F.   && fixcorigs bit
    this_lFixgdests     = .F.   && fixgdests bit
    this_lFixgorigs     = .F.   && fixgorigs bit
    this_lFixgropes     = .F.   && fixgropes bit
    this_lFixgvends     = .F.   && fixgvends bit
    this_lChkfunds      = .F.   && chkfunds bit
    this_lFixgven2s     = .F.   && fixgven2s bit
    *-- datetime
    this_dDatatrans     = {}    && datatrans datetime
    *-- char columns
    this_cDopeetrfs     = ""    && dopeetrfs char(20)
    this_cAbrevs        = ""    && abrevs char(3)
    this_cCcentrals     = ""    && ccentrals char(2)
    this_cCmoes         = ""    && cmoes char(3)
    this_cCnopes        = ""    && cnopes char(10)
    this_cCondests      = ""    && condests char(10)
    this_cConorigs      = ""    && conorigs char(10)
    this_cContas        = ""    && contas char(10)
    this_cEmppads       = ""    && emppads char(3)
    this_cGrudests      = ""    && grudests char(10)
    this_cGruorigs      = ""    && gruorigs char(10)
    this_cGrupos        = ""    && grupos char(10)
    this_cGrvends       = ""    && grvends char(20)
    this_cMenus         = ""    && menus char(10)
    this_cNivels        = ""    && nivels char(20)
    this_cNopcrs        = ""    && nopcrs char(20)
    this_cTabdps        = ""    && tabdps char(10)
    this_cDopcs         = ""    && dopcs char(20)
    this_cEspecies      = ""    && especies char(6)
    this_cSeries        = ""    && series char(3)
    this_cHist2s        = ""    && hist2s char(30)
    this_cHists         = ""    && hists char(30)
    this_cSubmenus      = ""    && submenus char(15)
    this_cGrucados      = ""    && grucados char(10)
    this_cGrucadds      = ""    && grucadds char(10)
    this_cGrucadvs      = ""    && grucadvs char(20)
    this_cCfos          = ""    && cfos char(10)
    this_cRelfechgrs    = ""    && relfechgrs char(2)
    this_cTitopes       = ""    && titopes char(30)
    this_cDopestrfs     = ""    && dopestrfs char(20)
    this_cOperchqes     = ""    && operchqes char(15)
    this_cOperchqss     = ""    && operchqss char(15)
    this_cGremiss       = ""    && gremiss char(10)
    this_cConemiss      = ""    && conemiss char(10)
    this_cOperfisics    = ""    && operfisics char(2)
    this_cCodpropads    = ""    && codpropads char(14)
    this_cFpagopcrs     = ""    && fpagopcrs char(12)
    this_cLprecopads    = ""    && lprecopads char(30)
    this_cMascvens      = ""    && mascvens char(20)
    this_cImpclis       = ""    && impclis char(1)
    this_cOpernf        = ""    && opernf char(2)
    this_cCodconpads    = ""    && codconpads char(10)
    this_cEmpbxs        = ""    && empbxs char(3)
    this_cEmplancs      = ""    && emplancs char(3)
    this_cOpepads       = ""    && opepads char(1)
    this_cProgramas     = ""    && programas char(15)
    this_cCtipomarms    = ""    && ctipomarms char(1) NULL
    this_cCarqicones    = ""    && carqicones char(64) NULL
    this_cDopcreds      = ""    && dopcreds char(20)
    this_cCfgfinancs    = ""    && cfgfinancs char(20)
    *-- text/memo
    this_mObsopes       = ""    && obsopes text

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        IF !DODEFAULT()
            RETURN .F.
        ENDIF
        THIS.this_cTabela     = "SigCdOpe"
        THIS.this_cCampoChave = "dopes"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_BuscaOPE")
                USE IN SELECT("cursor_4c_BuscaOPE")
            ENDIF
            loc_cSQL = "SELECT a.dopes, a.titopes, a.tipoops, a.situas, a.opers " + ;
                       "FROM SigCdOpe a"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY a.dopes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOPE")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro em Buscar")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em Buscar")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (dopes)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_OPE_tmp")
                USE IN SELECT("cursor_4c_OPE_tmp")
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdOpe WHERE dopes = " + EscaparSQL(par_cCodigo)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OPE_tmp")
            IF loc_nResult > 0 AND !EOF("cursor_4c_OPE_tmp")
                THIS.CarregarDoCursor("cursor_4c_OPE_tmp")
                THIS.this_lNovoRegistro = .F.
                loc_lResultado = .T.
            ENDIF
            IF USED("cursor_4c_OPE_tmp")
                USE IN SELECT("cursor_4c_OPE_tmp")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarPorCodigo")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                *-- PK
                THIS.this_cDopes         = ALLTRIM(dopes)
                *-- char
                THIS.this_cTitopes       = ALLTRIM(titopes)
                THIS.this_cAbrevs        = ALLTRIM(abrevs)
                THIS.this_cCcentrals     = ALLTRIM(ccentrals)
                THIS.this_cCmoes         = ALLTRIM(cmoes)
                THIS.this_cCnopes        = ALLTRIM(cnopes)
                THIS.this_cCondests      = ALLTRIM(condests)
                THIS.this_cConorigs      = ALLTRIM(conorigs)
                THIS.this_cContas        = ALLTRIM(contas)
                THIS.this_cEmppads       = ALLTRIM(emppads)
                THIS.this_cGrudests      = ALLTRIM(grudests)
                THIS.this_cGruorigs      = ALLTRIM(gruorigs)
                THIS.this_cGrupos        = ALLTRIM(grupos)
                THIS.this_cGrvends       = ALLTRIM(grvends)
                THIS.this_cMenus         = ALLTRIM(menus)
                THIS.this_cNivels        = ALLTRIM(nivels)
                THIS.this_cNopcrs        = ALLTRIM(nopcrs)
                THIS.this_cTabdps        = ALLTRIM(tabdps)
                THIS.this_cDopcs         = ALLTRIM(dopcs)
                THIS.this_cEspecies      = ALLTRIM(especies)
                THIS.this_cSeries        = ALLTRIM(series)
                THIS.this_cHist2s        = ALLTRIM(hist2s)
                THIS.this_cHists         = ALLTRIM(hists)
                THIS.this_cSubmenus      = ALLTRIM(submenus)
                THIS.this_cGrucados      = ALLTRIM(grucados)
                THIS.this_cGrucadds      = ALLTRIM(grucadds)
                THIS.this_cGrucadvs      = ALLTRIM(grucadvs)
                THIS.this_cCfos          = ALLTRIM(cfos)
                THIS.this_cRelfechgrs    = ALLTRIM(relfechgrs)
                THIS.this_cDopeetrfs     = ALLTRIM(dopeetrfs)
                THIS.this_cDopestrfs     = ALLTRIM(dopestrfs)
                THIS.this_cOperchqes     = ALLTRIM(operchqes)
                THIS.this_cOperchqss     = ALLTRIM(operchqss)
                THIS.this_cGremiss       = ALLTRIM(gremiss)
                THIS.this_cConemiss      = ALLTRIM(conemiss)
                THIS.this_cOperfisics    = ALLTRIM(operfisics)
                THIS.this_cCodpropads    = ALLTRIM(codpropads)
                THIS.this_cFpagopcrs     = ALLTRIM(fpagopcrs)
                THIS.this_cLprecopads    = ALLTRIM(lprecopads)
                THIS.this_cMascvens      = ALLTRIM(mascvens)
                THIS.this_cImpclis       = ALLTRIM(impclis)
                THIS.this_cOpernf        = ALLTRIM(opernf)
                THIS.this_cCodconpads    = ALLTRIM(codconpads)
                THIS.this_cEmpbxs        = ALLTRIM(empbxs)
                THIS.this_cEmplancs      = ALLTRIM(emplancs)
                THIS.this_cOpepads       = ALLTRIM(opepads)
                THIS.this_cProgramas     = ALLTRIM(programas)
                THIS.this_cCtipomarms    = ALLTRIM(NVL(ctipomarms, ""))
                THIS.this_cCarqicones    = ALLTRIM(NVL(carqicones, ""))
                THIS.this_cDopcreds      = ALLTRIM(dopcreds)
                THIS.this_cCfgfinancs    = ALLTRIM(cfgfinancs)
                *-- numeric(1,0)
                THIS.this_nPedclis       = pedclis
                THIS.this_nZerqtds       = zerqtds
                THIS.this_nValinotas     = valinotas
                THIS.this_nValitems      = valitems
                THIS.this_nExibsits      = exibsits
                THIS.this_nChkqtds       = chkqtds
                THIS.this_nDtcontab      = dtcontab
                THIS.this_nAltdescs      = altdescs
                THIS.this_nAntecs        = antecs
                THIS.this_nAptpfats      = aptpfats
                THIS.this_nArreds        = arreds
                THIS.this_nBaixasns      = baixasns
                THIS.this_nBxautos       = bxautos
                THIS.this_nBxparcials    = bxparcials
                THIS.this_nCadclis       = cadclis
                THIS.this_nCaixas        = caixas
                THIS.this_nCalcfecs      = calcfecs
                THIS.this_nCarnes        = carnes
                THIS.this_nCcomis        = ccomis
                THIS.this_nCdesps        = cdesps
                THIS.this_nChdtentrs     = chdtentrs
                THIS.this_nCheqs         = cheqs
                THIS.this_nCodbars       = codbars
                THIS.this_nComcargs      = comcargs
                THIS.this_nCondsubs      = condsubs
                THIS.this_nConfes        = confes
                THIS.this_nConosubs      = conosubs
                THIS.this_nConsclis      = consclis
                THIS.this_nConsers       = consers
                THIS.this_nConsgs        = consgs
                THIS.this_nCopers        = copers
                THIS.this_nCrepls        = crepls
                THIS.this_nCtipos        = ctipos
                THIS.this_nCupfis        = cupfis
                THIS.this_nDeacrs        = deacrs
                THIS.this_nDesmembs      = desmembs
                THIS.this_nDestinos      = destinos
                THIS.this_nDfpags        = dfpags
                THIS.this_nDigdoc        = digdoc
                THIS.this_nDigitens      = digitens
                THIS.this_nDigobs        = digobs
                THIS.this_nDtentrs       = dtentrs
                THIS.this_nEdcotas       = edcotas
                THIS.this_nEdtpfats      = edtpfats
                THIS.this_nEfators       = efators
                THIS.this_nEpesos        = epesos
                THIS.this_nEprecos       = eprecos
                THIS.this_nEstdests      = estdests
                THIS.this_nEstoqs        = estoqs
                THIS.this_nEstorigs      = estorigs
                THIS.this_nExpends       = expends
                THIS.this_nFatauts       = fatauts
                THIS.this_nGlobalizas    = globalizas
                THIS.this_nImagems       = imagems
                THIS.this_nItemalfas     = itemalfas
                THIS.this_nItemzeros     = itemzeros
                THIS.this_nLimcres       = limcres
                THIS.this_nLimpauts      = limpauts
                THIS.this_nLprecos       = lprecos
                THIS.this_nMestoqs       = mestoqs
                THIS.this_nNdebitos      = ndebitos
                THIS.this_nNfiscals      = nfiscals
                THIS.this_nNumeras       = numeras
                THIS.this_nOpcrs         = opcrs
                THIS.this_nOpers         = opers
                THIS.this_nOrigems       = origems
                THIS.this_nParautos      = parautos
                THIS.this_nParcontas     = parcontas
                THIS.this_nParcs         = parcs
                THIS.this_nParrecals     = parrecals
                THIS.this_nPesoauts      = pesoauts
                THIS.this_nPesods        = pesods
                THIS.this_nPesos         = pesos
                THIS.this_nPesovts       = pesovts
                THIS.this_nPrecoauts     = precoauts
                THIS.this_nPrecods       = precods
                THIS.this_nPrecovts      = precovts
                THIS.this_nProduc        = produc
                THIS.this_nQtdpesos      = qtdpesos
                THIS.this_nQtdprecos     = qtdprecos
                THIS.this_nQtdrelevs     = qtdrelevs
                THIS.this_nRelfechas     = relfechas
                THIS.this_nReservas      = reservas
                THIS.this_nResults       = results
                THIS.this_nSituas        = situas
                THIS.this_nSubns         = subns
                THIS.this_nTabdescs      = tabdescs
                THIS.this_nTransons      = transons
                THIS.this_nTransps       = transps
                THIS.this_nTranss        = transs
                THIS.this_nUnitpesos     = unitpesos
                THIS.this_nValests       = valests
                THIS.this_nValpends      = valpends
                THIS.this_nValpres       = valpres
                THIS.this_nVars          = vars
                THIS.this_nVendas        = vendas
                THIS.this_nVendes        = vendes
                THIS.this_nSemetiqs      = semetiqs
                THIS.this_nCasas         = casas
                THIS.this_nAlttrans      = alttrans
                THIS.this_nDadosnotas    = dadosnotas
                THIS.this_nObsdests      = obsdests
                THIS.this_nObsorigs      = obsorigs
                THIS.this_nServicos      = servicos
                THIS.this_nSubnobrigs    = subnobrigs
                THIS.this_nTphist2s      = tphist2s
                THIS.this_nTphists       = tphists
                THIS.this_nBlqdatas      = blqdatas
                THIS.this_nSenhads       = senhads
                THIS.this_nSenhaos       = senhaos
                THIS.this_nDemocreds     = democreds
                THIS.this_nDigcpfs       = digcpfs
                THIS.this_nCongvends     = congvends
                THIS.this_nChkqtdss      = chkqtdss
                THIS.this_nValitnegs     = valitnegs
                THIS.this_nCalcmos       = calcmos
                THIS.this_nChkdval       = chkdval
                THIS.this_nTabdobrigs    = tabdobrigs
                THIS.this_nDtemis        = dtemis
                THIS.this_nConprecs      = conprecs
                THIS.this_nTrocoauts     = trocoauts
                THIS.this_nParczeros     = parczeros
                THIS.this_nBxvlopcrs     = bxvlopcrs
                THIS.this_nCadcliauts    = cadcliauts
                THIS.this_nObsitems      = obsitems
                THIS.this_nVaritems      = varitems
                THIS.this_nItsituas      = itsituas
                THIS.this_nHabsubits     = habsubits
                THIS.this_nOppends       = oppends
                THIS.this_nCadprods      = cadprods
                THIS.this_nSubnautos     = subnautos
                THIS.this_nSenhars       = senhars
                THIS.this_nTotcompos     = totcompos
                THIS.this_nChkedesc      = chkedesc
                THIS.this_nNcpesos       = ncpesos
                THIS.this_nEditdocs      = editdocs
                THIS.this_nCempsubns     = cempsubns
                THIS.this_nCarcbars      = carcbars
                THIS.this_nCtrllotes     = ctrllotes
                THIS.this_nOrilotes      = orilotes
                THIS.this_nReffs         = reffs
                THIS.this_nCcustos       = ccustos
                THIS.this_nDcpns         = dcpns
                THIS.this_nDtbars        = dtbars
                THIS.this_nAciosens      = aciosens
                THIS.this_nCliods        = cliods
                THIS.this_nEdcomis       = edcomis
                THIS.this_nInfoipis      = infoipis
                THIS.this_nAgrupas       = agrupas
                THIS.this_nDigenves      = digenves
                THIS.this_nDigrecs       = digrecs
                THIS.this_nEmpsubns      = empsubns
                THIS.this_nFechmals      = fechmals
                THIS.this_nHabservs      = habservs
                THIS.this_nMarcasubns    = marcasubns
                THIS.this_nTiponfs       = tiponfs
                THIS.this_nChkacpro      = chkacpro
                THIS.this_nEdunis        = edunis
                THIS.this_nAnprodzs      = anprodzs
                THIS.this_nAutenticas    = autenticas
                THIS.this_nAutoins       = autoins
                THIS.this_nBxpagos       = bxpagos
                THIS.this_nCarvends      = carvends
                THIS.this_nCbxsubns      = cbxsubns
                THIS.this_nChecpagos     = checpagos
                THIS.this_nChkagends     = chkagends
                THIS.this_nInibcchqs     = inibcchqs
                THIS.this_nInibmens      = inibmens
                THIS.this_nInibmlcs      = inibmlcs
                THIS.this_nNcarsubs      = ncarsubs
                THIS.this_nObrigvd2s     = obrigvd2s
                THIS.this_nObrigvds      = obrigvds
                THIS.this_nTplprecs      = tplprecs
                THIS.this_nFpubl         = fpubl
                THIS.this_nNfcompls      = nfcompls
                *-- numeric(2,0)
                THIS.this_nDocus         = docus
                THIS.this_nItautos       = itautos
                THIS.this_nPrecops       = precops
                THIS.this_nComisdivs     = comisdivs
                THIS.this_nTipoops       = tipoops
                THIS.this_nTrnfis        = trnfis
                *-- numeric(3,0)
                THIS.this_nObspads       = obspads
                THIS.this_nObsfins       = obsfins
                THIS.this_nObsinis       = obsinis
                THIS.this_nCdopes        = cdopes
                *-- numeric(4,0)
                THIS.this_nNdopes        = ndopes
                THIS.this_nOrdes         = ordes
                THIS.this_nQtdites       = qtdites
                *-- numeric(5,2)
                THIS.this_nPorcs         = porcs
                THIS.this_nVcompensas    = vcompensas
                *-- bit (SQL Server bit -> VFP numeric 0/1 -> logical)
                THIS.this_lFixcdests     = (fixcdests = 1)
                THIS.this_lFixcnopes     = (fixcnopes = 1)
                THIS.this_lFixcorigs     = (fixcorigs = 1)
                THIS.this_lFixgdests     = (fixgdests = 1)
                THIS.this_lFixgorigs     = (fixgorigs = 1)
                THIS.this_lFixgropes     = (fixgropes = 1)
                THIS.this_lFixgvends     = (fixgvends = 1)
                THIS.this_lChkfunds      = (chkfunds = 1)
                THIS.this_lFixgven2s     = (fixgven2s = 1)
                *-- datetime
                THIS.this_dDatatrans     = datatrans
                *-- text/memo
                THIS.this_mObsopes       = ALLTRIM(obsopes)
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarDoCursor")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdOpe
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_cCols, loc_cVals, loc_nResult
        LOCAL loc_cDatatrans
        loc_lResultado = .F.
        TRY
            THIS.RegistrarAuditoria("I")
            IF EMPTY(THIS.this_dDatatrans)
                loc_cDatatrans = "NULL"
            ELSE
                loc_cDatatrans = FormatarDataSQL(THIS.this_dDatatrans)
            ENDIF
            loc_cCols = "dopes, titopes, tipoops, situas, opers, pedclis, zerqtds, valinotas, " + ;
                        "valitems, exibsits, chkqtds, dtcontab, altdescs, antecs, aptpfats, arreds, " + ;
                        "baixasns, bxautos, bxparcials, cadclis, caixas, calcfecs, carnes, ccomis, " + ;
                        "cdesps, chdtentrs, cheqs, codbars, comcargs, condsubs, confes, conosubs, " + ;
                        "consclis, consers, consgs, copers, crepls, ctipos, cupfis, deacrs, " + ;
                        "desmembs, destinos, dfpags, digdoc, digitens, digobs, dtentrs, edcotas, " + ;
                        "edtpfats, efators, epesos, eprecos, estdests, estoqs, estorigs, expends, " + ;
                        "fatauts, globalizas, imagems, itemalfas, itemzeros, limcres, limpauts, " + ;
                        "lprecos, mestoqs, ndebitos, nfiscals, numeras, opcrs, origems, parautos, " + ;
                        "parcontas, parcs, parrecals, pesoauts, pesods, pesos, pesovts, precoauts, " + ;
                        "precods, precovts, produc, qtdpesos, qtdprecos, qtdrelevs, relfechas, " + ;
                        "reservas, results, subns, tabdescs, transons, transps, transs, unitpesos, " + ;
                        "valests, valpends, valpres, vars, vendas, vendes, semetiqs, casas, " + ;
                        "alttrans, dadosnotas, obsdests, obsorigs, servicos, subnobrigs, tphist2s, " + ;
                        "tphists, blqdatas, senhads, senhaos, democreds, digcpfs, congvends, " + ;
                        "chkqtdss, valitnegs, calcmos, chkdval, tabdobrigs, dtemis, conprecs, " + ;
                        "trocoauts, parczeros, bxvlopcrs, cadcliauts, obsitems, varitems, itsituas, " + ;
                        "habsubits, oppends, cadprods, subnautos, senhars, totcompos, chkedesc, " + ;
                        "ncpesos, editdocs, cempsubns, carcbars, ctrllotes, orilotes, reffs, " + ;
                        "ccustos, dcpns, dtbars, aciosens, cliods, edcomis, infoipis, agrupas, " + ;
                        "digenves, digrecs, empsubns, fechmals, habservs, marcasubns, tiponfs, " + ;
                        "chkacpro, edunis, anprodzs, autenticas, autoins, bxpagos, carvends, " + ;
                        "cbxsubns, checpagos, chkagends, inibcchqs, inibmens, inibmlcs, ncarsubs, " + ;
                        "obrigvd2s, obrigvds, tplprecs, fpubl, nfcompls, " + ;
                        "docus, itautos, precops, comisdivs, trnfis, " + ;
                        "obspads, obsfins, obsinis, cdopes, " + ;
                        "ndopes, ordes, qtdites, " + ;
                        "porcs, vcompensas, " + ;
                        "fixcdests, fixcnopes, fixcorigs, fixgdests, fixgorigs, fixgropes, fixgvends, " + ;
                        "chkfunds, fixgven2s, datatrans, " + ;
                        "dopeetrfs, abrevs, ccentrals, cmoes, cnopes, condests, conorigs, contas, " + ;
                        "emppads, grudests, gruorigs, grupos, grvends, menus, nivels, nopcrs, " + ;
                        "tabdps, dopcs, especies, series, hist2s, hists, submenus, grucados, " + ;
                        "grucadds, grucadvs, cfos, relfechgrs, dopestrfs, operchqes, operchqss, " + ;
                        "gremiss, conemiss, operfisics, codpropads, fpagopcrs, lprecopads, " + ;
                        "mascvens, impclis, opernf, codconpads, empbxs, emplancs, opepads, " + ;
                        "programas, ctipomarms, carqicones, dopcreds, cfgfinancs, obsopes"
            loc_cVals = EscaparSQL(THIS.this_cDopes) + ", " + ;
                        EscaparSQL(THIS.this_cTitopes) + ", " + ;
                        TRANSFORM(THIS.this_nTipoops) + ", " + ;
                        TRANSFORM(THIS.this_nSituas) + ", " + ;
                        TRANSFORM(THIS.this_nOpers) + ", " + ;
                        TRANSFORM(THIS.this_nPedclis) + ", " + ;
                        TRANSFORM(THIS.this_nZerqtds) + ", " + ;
                        TRANSFORM(THIS.this_nValinotas) + ", " + ;
                        TRANSFORM(THIS.this_nValitems) + ", " + ;
                        TRANSFORM(THIS.this_nExibsits) + ", " + ;
                        TRANSFORM(THIS.this_nChkqtds) + ", " + ;
                        TRANSFORM(THIS.this_nDtcontab) + ", " + ;
                        TRANSFORM(THIS.this_nAltdescs) + ", " + ;
                        TRANSFORM(THIS.this_nAntecs) + ", " + ;
                        TRANSFORM(THIS.this_nAptpfats) + ", " + ;
                        TRANSFORM(THIS.this_nArreds) + ", " + ;
                        TRANSFORM(THIS.this_nBaixasns) + ", " + ;
                        TRANSFORM(THIS.this_nBxautos) + ", " + ;
                        TRANSFORM(THIS.this_nBxparcials) + ", " + ;
                        TRANSFORM(THIS.this_nCadclis) + ", " + ;
                        TRANSFORM(THIS.this_nCaixas) + ", " + ;
                        TRANSFORM(THIS.this_nCalcfecs) + ", " + ;
                        TRANSFORM(THIS.this_nCarnes) + ", " + ;
                        TRANSFORM(THIS.this_nCcomis) + ", " + ;
                        TRANSFORM(THIS.this_nCdesps) + ", " + ;
                        TRANSFORM(THIS.this_nChdtentrs) + ", " + ;
                        TRANSFORM(THIS.this_nCheqs) + ", " + ;
                        TRANSFORM(THIS.this_nCodbars) + ", " + ;
                        TRANSFORM(THIS.this_nComcargs) + ", " + ;
                        TRANSFORM(THIS.this_nCondsubs) + ", " + ;
                        TRANSFORM(THIS.this_nConfes) + ", " + ;
                        TRANSFORM(THIS.this_nConosubs) + ", " + ;
                        TRANSFORM(THIS.this_nConsclis) + ", " + ;
                        TRANSFORM(THIS.this_nConsers) + ", " + ;
                        TRANSFORM(THIS.this_nConsgs) + ", " + ;
                        TRANSFORM(THIS.this_nCopers) + ", " + ;
                        TRANSFORM(THIS.this_nCrepls) + ", " + ;
                        TRANSFORM(THIS.this_nCtipos) + ", " + ;
                        TRANSFORM(THIS.this_nCupfis) + ", " + ;
                        TRANSFORM(THIS.this_nDeacrs) + ", "
            loc_cVals = loc_cVals + ;
                        TRANSFORM(THIS.this_nDesmembs) + ", " + ;
                        TRANSFORM(THIS.this_nDestinos) + ", " + ;
                        TRANSFORM(THIS.this_nDfpags) + ", " + ;
                        TRANSFORM(THIS.this_nDigdoc) + ", " + ;
                        TRANSFORM(THIS.this_nDigitens) + ", " + ;
                        TRANSFORM(THIS.this_nDigobs) + ", " + ;
                        TRANSFORM(THIS.this_nDtentrs) + ", " + ;
                        TRANSFORM(THIS.this_nEdcotas) + ", " + ;
                        TRANSFORM(THIS.this_nEdtpfats) + ", " + ;
                        TRANSFORM(THIS.this_nEfators) + ", " + ;
                        TRANSFORM(THIS.this_nEpesos) + ", " + ;
                        TRANSFORM(THIS.this_nEprecos) + ", " + ;
                        TRANSFORM(THIS.this_nEstdests) + ", " + ;
                        TRANSFORM(THIS.this_nEstoqs) + ", " + ;
                        TRANSFORM(THIS.this_nEstorigs) + ", " + ;
                        TRANSFORM(THIS.this_nExpends) + ", " + ;
                        TRANSFORM(THIS.this_nFatauts) + ", " + ;
                        TRANSFORM(THIS.this_nGlobalizas) + ", " + ;
                        TRANSFORM(THIS.this_nImagems) + ", " + ;
                        TRANSFORM(THIS.this_nItemalfas) + ", " + ;
                        TRANSFORM(THIS.this_nItemzeros) + ", " + ;
                        TRANSFORM(THIS.this_nLimcres) + ", " + ;
                        TRANSFORM(THIS.this_nLimpauts) + ", " + ;
                        TRANSFORM(THIS.this_nLprecos) + ", " + ;
                        TRANSFORM(THIS.this_nMestoqs) + ", " + ;
                        TRANSFORM(THIS.this_nNdebitos) + ", " + ;
                        TRANSFORM(THIS.this_nNfiscals) + ", " + ;
                        TRANSFORM(THIS.this_nNumeras) + ", " + ;
                        TRANSFORM(THIS.this_nOpcrs) + ", " + ;
                        TRANSFORM(THIS.this_nOrigems) + ", " + ;
                        TRANSFORM(THIS.this_nParautos) + ", " + ;
                        TRANSFORM(THIS.this_nParcontas) + ", " + ;
                        TRANSFORM(THIS.this_nParcs) + ", " + ;
                        TRANSFORM(THIS.this_nParrecals) + ", " + ;
                        TRANSFORM(THIS.this_nPesoauts) + ", " + ;
                        TRANSFORM(THIS.this_nPesods) + ", " + ;
                        TRANSFORM(THIS.this_nPesos) + ", " + ;
                        TRANSFORM(THIS.this_nPesovts) + ", " + ;
                        TRANSFORM(THIS.this_nPrecoauts) + ", "
            loc_cVals = loc_cVals + ;
                        TRANSFORM(THIS.this_nPrecods) + ", " + ;
                        TRANSFORM(THIS.this_nPrecovts) + ", " + ;
                        TRANSFORM(THIS.this_nProduc) + ", " + ;
                        TRANSFORM(THIS.this_nQtdpesos) + ", " + ;
                        TRANSFORM(THIS.this_nQtdprecos) + ", " + ;
                        TRANSFORM(THIS.this_nQtdrelevs) + ", " + ;
                        TRANSFORM(THIS.this_nRelfechas) + ", " + ;
                        TRANSFORM(THIS.this_nReservas) + ", " + ;
                        TRANSFORM(THIS.this_nResults) + ", " + ;
                        TRANSFORM(THIS.this_nSubns) + ", " + ;
                        TRANSFORM(THIS.this_nTabdescs) + ", " + ;
                        TRANSFORM(THIS.this_nTransons) + ", " + ;
                        TRANSFORM(THIS.this_nTransps) + ", " + ;
                        TRANSFORM(THIS.this_nTranss) + ", " + ;
                        TRANSFORM(THIS.this_nUnitpesos) + ", " + ;
                        TRANSFORM(THIS.this_nValests) + ", " + ;
                        TRANSFORM(THIS.this_nValpends) + ", " + ;
                        TRANSFORM(THIS.this_nValpres) + ", " + ;
                        TRANSFORM(THIS.this_nVars) + ", " + ;
                        TRANSFORM(THIS.this_nVendas) + ", " + ;
                        TRANSFORM(THIS.this_nVendes) + ", " + ;
                        TRANSFORM(THIS.this_nSemetiqs) + ", " + ;
                        TRANSFORM(THIS.this_nCasas) + ", " + ;
                        TRANSFORM(THIS.this_nAlttrans) + ", " + ;
                        TRANSFORM(THIS.this_nDadosnotas) + ", " + ;
                        TRANSFORM(THIS.this_nObsdests) + ", " + ;
                        TRANSFORM(THIS.this_nObsorigs) + ", " + ;
                        TRANSFORM(THIS.this_nServicos) + ", " + ;
                        TRANSFORM(THIS.this_nSubnobrigs) + ", " + ;
                        TRANSFORM(THIS.this_nTphist2s) + ", " + ;
                        TRANSFORM(THIS.this_nTphists) + ", " + ;
                        TRANSFORM(THIS.this_nBlqdatas) + ", " + ;
                        TRANSFORM(THIS.this_nSenhads) + ", " + ;
                        TRANSFORM(THIS.this_nSenhaos) + ", " + ;
                        TRANSFORM(THIS.this_nDemocreds) + ", " + ;
                        TRANSFORM(THIS.this_nDigcpfs) + ", " + ;
                        TRANSFORM(THIS.this_nCongvends) + ", " + ;
                        TRANSFORM(THIS.this_nChkqtdss) + ", " + ;
                        TRANSFORM(THIS.this_nValitnegs) + ", " + ;
                        TRANSFORM(THIS.this_nCalcmos) + ", "
            loc_cVals = loc_cVals + ;
                        TRANSFORM(THIS.this_nChkdval) + ", " + ;
                        TRANSFORM(THIS.this_nTabdobrigs) + ", " + ;
                        TRANSFORM(THIS.this_nDtemis) + ", " + ;
                        TRANSFORM(THIS.this_nConprecs) + ", " + ;
                        TRANSFORM(THIS.this_nTrocoauts) + ", " + ;
                        TRANSFORM(THIS.this_nParczeros) + ", " + ;
                        TRANSFORM(THIS.this_nBxvlopcrs) + ", " + ;
                        TRANSFORM(THIS.this_nCadcliauts) + ", " + ;
                        TRANSFORM(THIS.this_nObsitems) + ", " + ;
                        TRANSFORM(THIS.this_nVaritems) + ", " + ;
                        TRANSFORM(THIS.this_nItsituas) + ", " + ;
                        TRANSFORM(THIS.this_nHabsubits) + ", " + ;
                        TRANSFORM(THIS.this_nOppends) + ", " + ;
                        TRANSFORM(THIS.this_nCadprods) + ", " + ;
                        TRANSFORM(THIS.this_nSubnautos) + ", " + ;
                        TRANSFORM(THIS.this_nSenhars) + ", " + ;
                        TRANSFORM(THIS.this_nTotcompos) + ", " + ;
                        TRANSFORM(THIS.this_nChkedesc) + ", " + ;
                        TRANSFORM(THIS.this_nNcpesos) + ", " + ;
                        TRANSFORM(THIS.this_nEditdocs) + ", " + ;
                        TRANSFORM(THIS.this_nCempsubns) + ", " + ;
                        TRANSFORM(THIS.this_nCarcbars) + ", " + ;
                        TRANSFORM(THIS.this_nCtrllotes) + ", " + ;
                        TRANSFORM(THIS.this_nOrilotes) + ", " + ;
                        TRANSFORM(THIS.this_nReffs) + ", " + ;
                        TRANSFORM(THIS.this_nCcustos) + ", " + ;
                        TRANSFORM(THIS.this_nDcpns) + ", " + ;
                        TRANSFORM(THIS.this_nDtbars) + ", " + ;
                        TRANSFORM(THIS.this_nAciosens) + ", " + ;
                        TRANSFORM(THIS.this_nCliods) + ", " + ;
                        TRANSFORM(THIS.this_nEdcomis) + ", " + ;
                        TRANSFORM(THIS.this_nInfoipis) + ", " + ;
                        TRANSFORM(THIS.this_nAgrupas) + ", " + ;
                        TRANSFORM(THIS.this_nDigenves) + ", " + ;
                        TRANSFORM(THIS.this_nDigrecs) + ", " + ;
                        TRANSFORM(THIS.this_nEmpsubns) + ", " + ;
                        TRANSFORM(THIS.this_nFechmals) + ", " + ;
                        TRANSFORM(THIS.this_nHabservs) + ", " + ;
                        TRANSFORM(THIS.this_nMarcasubns) + ", "
            loc_cVals = loc_cVals + ;
                        TRANSFORM(THIS.this_nTiponfs) + ", " + ;
                        TRANSFORM(THIS.this_nChkacpro) + ", " + ;
                        TRANSFORM(THIS.this_nEdunis) + ", " + ;
                        TRANSFORM(THIS.this_nAnprodzs) + ", " + ;
                        TRANSFORM(THIS.this_nAutenticas) + ", " + ;
                        TRANSFORM(THIS.this_nAutoins) + ", " + ;
                        TRANSFORM(THIS.this_nBxpagos) + ", " + ;
                        TRANSFORM(THIS.this_nCarvends) + ", " + ;
                        TRANSFORM(THIS.this_nCbxsubns) + ", " + ;
                        TRANSFORM(THIS.this_nChecpagos) + ", " + ;
                        TRANSFORM(THIS.this_nChkagends) + ", " + ;
                        TRANSFORM(THIS.this_nInibcchqs) + ", " + ;
                        TRANSFORM(THIS.this_nInibmens) + ", " + ;
                        TRANSFORM(THIS.this_nInibmlcs) + ", " + ;
                        TRANSFORM(THIS.this_nNcarsubs) + ", " + ;
                        TRANSFORM(THIS.this_nObrigvd2s) + ", " + ;
                        TRANSFORM(THIS.this_nObrigvds) + ", " + ;
                        TRANSFORM(THIS.this_nTplprecs) + ", " + ;
                        TRANSFORM(THIS.this_nFpubl) + ", " + ;
                        TRANSFORM(THIS.this_nNfcompls) + ", " + ;
                        TRANSFORM(THIS.this_nDocus) + ", " + ;
                        TRANSFORM(THIS.this_nItautos) + ", " + ;
                        TRANSFORM(THIS.this_nPrecops) + ", " + ;
                        TRANSFORM(THIS.this_nComisdivs) + ", " + ;
                        TRANSFORM(THIS.this_nTrnfis) + ", " + ;
                        TRANSFORM(THIS.this_nObspads) + ", " + ;
                        TRANSFORM(THIS.this_nObsfins) + ", " + ;
                        TRANSFORM(THIS.this_nObsinis) + ", " + ;
                        TRANSFORM(THIS.this_nCdopes) + ", " + ;
                        TRANSFORM(THIS.this_nNdopes) + ", " + ;
                        TRANSFORM(THIS.this_nOrdes) + ", " + ;
                        TRANSFORM(THIS.this_nQtdites) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nPorcs) + ", " + ;
                        FormatarNumeroSQL(THIS.this_nVcompensas) + ", " + ;
                        IIF(THIS.this_lFixcdests, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixcnopes, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixcorigs, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixgdests, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixgorigs, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixgropes, "1", "0") + ", " + ;
                        IIF(THIS.this_lFixgvends, "1", "0") + ", " + ;
                        IIF(THIS.this_lChkfunds,  "1", "0") + ", " + ;
                        IIF(THIS.this_lFixgven2s, "1", "0") + ", " + ;
                        loc_cDatatrans + ", "
            loc_cVals = loc_cVals + ;
                        EscaparSQL(THIS.this_cDopeetrfs) + ", " + ;
                        EscaparSQL(THIS.this_cAbrevs) + ", " + ;
                        EscaparSQL(THIS.this_cCcentrals) + ", " + ;
                        EscaparSQL(THIS.this_cCmoes) + ", " + ;
                        EscaparSQL(THIS.this_cCnopes) + ", " + ;
                        EscaparSQL(THIS.this_cCondests) + ", " + ;
                        EscaparSQL(THIS.this_cConorigs) + ", " + ;
                        EscaparSQL(THIS.this_cContas) + ", " + ;
                        EscaparSQL(THIS.this_cEmppads) + ", " + ;
                        EscaparSQL(THIS.this_cGrudests) + ", " + ;
                        EscaparSQL(THIS.this_cGruorigs) + ", " + ;
                        EscaparSQL(THIS.this_cGrupos) + ", " + ;
                        EscaparSQL(THIS.this_cGrvends) + ", " + ;
                        EscaparSQL(THIS.this_cMenus) + ", " + ;
                        EscaparSQL(THIS.this_cNivels) + ", " + ;
                        EscaparSQL(THIS.this_cNopcrs) + ", " + ;
                        EscaparSQL(THIS.this_cTabdps) + ", " + ;
                        EscaparSQL(THIS.this_cDopcs) + ", " + ;
                        EscaparSQL(THIS.this_cEspecies) + ", " + ;
                        EscaparSQL(THIS.this_cSeries) + ", " + ;
                        EscaparSQL(THIS.this_cHist2s) + ", " + ;
                        EscaparSQL(THIS.this_cHists) + ", " + ;
                        EscaparSQL(THIS.this_cSubmenus) + ", " + ;
                        EscaparSQL(THIS.this_cGrucados) + ", " + ;
                        EscaparSQL(THIS.this_cGrucadds) + ", " + ;
                        EscaparSQL(THIS.this_cGrucadvs) + ", " + ;
                        EscaparSQL(THIS.this_cCfos) + ", " + ;
                        EscaparSQL(THIS.this_cRelfechgrs) + ", " + ;
                        EscaparSQL(THIS.this_cDopestrfs) + ", " + ;
                        EscaparSQL(THIS.this_cOperchqes) + ", " + ;
                        EscaparSQL(THIS.this_cOperchqss) + ", " + ;
                        EscaparSQL(THIS.this_cGremiss) + ", " + ;
                        EscaparSQL(THIS.this_cConemiss) + ", " + ;
                        EscaparSQL(THIS.this_cOperfisics) + ", " + ;
                        EscaparSQL(THIS.this_cCodpropads) + ", " + ;
                        EscaparSQL(THIS.this_cFpagopcrs) + ", " + ;
                        EscaparSQL(THIS.this_cLprecopads) + ", " + ;
                        EscaparSQL(THIS.this_cMascvens) + ", " + ;
                        EscaparSQL(THIS.this_cImpclis) + ", " + ;
                        EscaparSQL(THIS.this_cOpernf) + ", " + ;
                        EscaparSQL(THIS.this_cCodconpads) + ", " + ;
                        EscaparSQL(THIS.this_cEmpbxs) + ", " + ;
                        EscaparSQL(THIS.this_cEmplancs) + ", " + ;
                        EscaparSQL(THIS.this_cOpepads) + ", " + ;
                        EscaparSQL(THIS.this_cProgramas) + ", " + ;
                        IIF(EMPTY(THIS.this_cCtipomarms), "NULL", EscaparSQL(THIS.this_cCtipomarms)) + ", " + ;
                        IIF(EMPTY(THIS.this_cCarqicones), "NULL", EscaparSQL(THIS.this_cCarqicones)) + ", " + ;
                        EscaparSQL(THIS.this_cDopcreds) + ", " + ;
                        EscaparSQL(THIS.this_cCfgfinancs) + ", " + ;
                        EscaparSQL(THIS.this_mObsopes)
            loc_cSQL = "INSERT INTO SigCdOpe (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o.", "Erro em Inserir")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em Inserir")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdOpe
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_cSet, loc_nResult, loc_cDatatrans
        loc_lResultado = .F.
        TRY
            THIS.RegistrarAuditoria("A")
            IF EMPTY(THIS.this_dDatatrans)
                loc_cDatatrans = "NULL"
            ELSE
                loc_cDatatrans = FormatarDataSQL(THIS.this_dDatatrans)
            ENDIF
            loc_cSet = "titopes = "     + EscaparSQL(THIS.this_cTitopes)   + ", " + ;
                       "tipoops = "     + TRANSFORM(THIS.this_nTipoops)    + ", " + ;
                       "situas = "      + TRANSFORM(THIS.this_nSituas)     + ", " + ;
                       "opers = "       + TRANSFORM(THIS.this_nOpers)      + ", " + ;
                       "pedclis = "     + TRANSFORM(THIS.this_nPedclis)    + ", " + ;
                       "zerqtds = "     + TRANSFORM(THIS.this_nZerqtds)    + ", " + ;
                       "valinotas = "   + TRANSFORM(THIS.this_nValinotas)  + ", " + ;
                       "valitems = "    + TRANSFORM(THIS.this_nValitems)   + ", " + ;
                       "exibsits = "    + TRANSFORM(THIS.this_nExibsits)   + ", " + ;
                       "chkqtds = "     + TRANSFORM(THIS.this_nChkqtds)    + ", " + ;
                       "dtcontab = "    + TRANSFORM(THIS.this_nDtcontab)   + ", " + ;
                       "altdescs = "    + TRANSFORM(THIS.this_nAltdescs)   + ", " + ;
                       "antecs = "      + TRANSFORM(THIS.this_nAntecs)     + ", " + ;
                       "aptpfats = "    + TRANSFORM(THIS.this_nAptpfats)   + ", " + ;
                       "arreds = "      + TRANSFORM(THIS.this_nArreds)     + ", " + ;
                       "baixasns = "    + TRANSFORM(THIS.this_nBaixasns)   + ", " + ;
                       "bxautos = "     + TRANSFORM(THIS.this_nBxautos)    + ", " + ;
                       "bxparcials = "  + TRANSFORM(THIS.this_nBxparcials) + ", " + ;
                       "cadclis = "     + TRANSFORM(THIS.this_nCadclis)    + ", " + ;
                       "caixas = "      + TRANSFORM(THIS.this_nCaixas)     + ", "
            loc_cSet = loc_cSet + ;
                       "calcfecs = "    + TRANSFORM(THIS.this_nCalcfecs)   + ", " + ;
                       "carnes = "      + TRANSFORM(THIS.this_nCarnes)     + ", " + ;
                       "ccomis = "      + TRANSFORM(THIS.this_nCcomis)     + ", " + ;
                       "cdesps = "      + TRANSFORM(THIS.this_nCdesps)     + ", " + ;
                       "chdtentrs = "   + TRANSFORM(THIS.this_nChdtentrs)  + ", " + ;
                       "cheqs = "       + TRANSFORM(THIS.this_nCheqs)      + ", " + ;
                       "codbars = "     + TRANSFORM(THIS.this_nCodbars)    + ", " + ;
                       "comcargs = "    + TRANSFORM(THIS.this_nComcargs)   + ", " + ;
                       "condsubs = "    + TRANSFORM(THIS.this_nCondsubs)   + ", " + ;
                       "confes = "      + TRANSFORM(THIS.this_nConfes)     + ", " + ;
                       "conosubs = "    + TRANSFORM(THIS.this_nConosubs)   + ", " + ;
                       "consclis = "    + TRANSFORM(THIS.this_nConsclis)   + ", " + ;
                       "consers = "     + TRANSFORM(THIS.this_nConsers)    + ", " + ;
                       "consgs = "      + TRANSFORM(THIS.this_nConsgs)     + ", " + ;
                       "copers = "      + TRANSFORM(THIS.this_nCopers)     + ", " + ;
                       "crepls = "      + TRANSFORM(THIS.this_nCrepls)     + ", " + ;
                       "ctipos = "      + TRANSFORM(THIS.this_nCtipos)     + ", " + ;
                       "cupfis = "      + TRANSFORM(THIS.this_nCupfis)     + ", " + ;
                       "deacrs = "      + TRANSFORM(THIS.this_nDeacrs)     + ", " + ;
                       "desmembs = "    + TRANSFORM(THIS.this_nDesmembs)   + ", "
            loc_cSet = loc_cSet + ;
                       "destinos = "    + TRANSFORM(THIS.this_nDestinos)   + ", " + ;
                       "dfpags = "      + TRANSFORM(THIS.this_nDfpags)     + ", " + ;
                       "digdoc = "      + TRANSFORM(THIS.this_nDigdoc)     + ", " + ;
                       "digitens = "    + TRANSFORM(THIS.this_nDigitens)   + ", " + ;
                       "digobs = "      + TRANSFORM(THIS.this_nDigobs)     + ", " + ;
                       "dtentrs = "     + TRANSFORM(THIS.this_nDtentrs)    + ", " + ;
                       "edcotas = "     + TRANSFORM(THIS.this_nEdcotas)    + ", " + ;
                       "edtpfats = "    + TRANSFORM(THIS.this_nEdtpfats)   + ", " + ;
                       "efators = "     + TRANSFORM(THIS.this_nEfators)    + ", " + ;
                       "epesos = "      + TRANSFORM(THIS.this_nEpesos)     + ", " + ;
                       "eprecos = "     + TRANSFORM(THIS.this_nEprecos)    + ", " + ;
                       "estdests = "    + TRANSFORM(THIS.this_nEstdests)   + ", " + ;
                       "estoqs = "      + TRANSFORM(THIS.this_nEstoqs)     + ", " + ;
                       "estorigs = "    + TRANSFORM(THIS.this_nEstorigs)   + ", " + ;
                       "expends = "     + TRANSFORM(THIS.this_nExpends)    + ", " + ;
                       "fatauts = "     + TRANSFORM(THIS.this_nFatauts)    + ", " + ;
                       "globalizas = "  + TRANSFORM(THIS.this_nGlobalizas) + ", " + ;
                       "imagems = "     + TRANSFORM(THIS.this_nImagems)    + ", " + ;
                       "itemalfas = "   + TRANSFORM(THIS.this_nItemalfas)  + ", " + ;
                       "itemzeros = "   + TRANSFORM(THIS.this_nItemzeros)  + ", "
            loc_cSet = loc_cSet + ;
                       "limcres = "     + TRANSFORM(THIS.this_nLimcres)    + ", " + ;
                       "limpauts = "    + TRANSFORM(THIS.this_nLimpauts)   + ", " + ;
                       "lprecos = "     + TRANSFORM(THIS.this_nLprecos)    + ", " + ;
                       "mestoqs = "     + TRANSFORM(THIS.this_nMestoqs)    + ", " + ;
                       "ndebitos = "    + TRANSFORM(THIS.this_nNdebitos)   + ", " + ;
                       "nfiscals = "    + TRANSFORM(THIS.this_nNfiscals)   + ", " + ;
                       "numeras = "     + TRANSFORM(THIS.this_nNumeras)    + ", " + ;
                       "opcrs = "       + TRANSFORM(THIS.this_nOpcrs)      + ", " + ;
                       "origems = "     + TRANSFORM(THIS.this_nOrigems)    + ", " + ;
                       "parautos = "    + TRANSFORM(THIS.this_nParautos)   + ", " + ;
                       "parcontas = "   + TRANSFORM(THIS.this_nParcontas)  + ", " + ;
                       "parcs = "       + TRANSFORM(THIS.this_nParcs)      + ", " + ;
                       "parrecals = "   + TRANSFORM(THIS.this_nParrecals)  + ", " + ;
                       "pesoauts = "    + TRANSFORM(THIS.this_nPesoauts)   + ", " + ;
                       "pesods = "      + TRANSFORM(THIS.this_nPesods)     + ", " + ;
                       "pesos = "       + TRANSFORM(THIS.this_nPesos)      + ", " + ;
                       "pesovts = "     + TRANSFORM(THIS.this_nPesovts)    + ", " + ;
                       "precoauts = "   + TRANSFORM(THIS.this_nPrecoauts)  + ", " + ;
                       "precods = "     + TRANSFORM(THIS.this_nPrecods)    + ", " + ;
                       "precovts = "    + TRANSFORM(THIS.this_nPrecovts)   + ", "
            loc_cSet = loc_cSet + ;
                       "produc = "      + TRANSFORM(THIS.this_nProduc)     + ", " + ;
                       "qtdpesos = "    + TRANSFORM(THIS.this_nQtdpesos)   + ", " + ;
                       "qtdprecos = "   + TRANSFORM(THIS.this_nQtdprecos)  + ", " + ;
                       "qtdrelevs = "   + TRANSFORM(THIS.this_nQtdrelevs)  + ", " + ;
                       "relfechas = "   + TRANSFORM(THIS.this_nRelfechas)  + ", " + ;
                       "reservas = "    + TRANSFORM(THIS.this_nReservas)   + ", " + ;
                       "results = "     + TRANSFORM(THIS.this_nResults)    + ", " + ;
                       "subns = "       + TRANSFORM(THIS.this_nSubns)      + ", " + ;
                       "tabdescs = "    + TRANSFORM(THIS.this_nTabdescs)   + ", " + ;
                       "transons = "    + TRANSFORM(THIS.this_nTransons)   + ", " + ;
                       "transps = "     + TRANSFORM(THIS.this_nTransps)    + ", " + ;
                       "transs = "      + TRANSFORM(THIS.this_nTranss)     + ", " + ;
                       "unitpesos = "   + TRANSFORM(THIS.this_nUnitpesos)  + ", " + ;
                       "valests = "     + TRANSFORM(THIS.this_nValests)    + ", " + ;
                       "valpends = "    + TRANSFORM(THIS.this_nValpends)   + ", " + ;
                       "valpres = "     + TRANSFORM(THIS.this_nValpres)    + ", " + ;
                       "vars = "        + TRANSFORM(THIS.this_nVars)       + ", " + ;
                       "vendas = "      + TRANSFORM(THIS.this_nVendas)     + ", " + ;
                       "vendes = "      + TRANSFORM(THIS.this_nVendes)     + ", " + ;
                       "semetiqs = "    + TRANSFORM(THIS.this_nSemetiqs)   + ", "
            loc_cSet = loc_cSet + ;
                       "casas = "       + TRANSFORM(THIS.this_nCasas)      + ", " + ;
                       "alttrans = "    + TRANSFORM(THIS.this_nAlttrans)   + ", " + ;
                       "dadosnotas = "  + TRANSFORM(THIS.this_nDadosnotas) + ", " + ;
                       "obsdests = "    + TRANSFORM(THIS.this_nObsdests)   + ", " + ;
                       "obsorigs = "    + TRANSFORM(THIS.this_nObsorigs)   + ", " + ;
                       "servicos = "    + TRANSFORM(THIS.this_nServicos)   + ", " + ;
                       "subnobrigs = "  + TRANSFORM(THIS.this_nSubnobrigs) + ", " + ;
                       "tphist2s = "    + TRANSFORM(THIS.this_nTphist2s)   + ", " + ;
                       "tphists = "     + TRANSFORM(THIS.this_nTphists)    + ", " + ;
                       "blqdatas = "    + TRANSFORM(THIS.this_nBlqdatas)   + ", " + ;
                       "senhads = "     + TRANSFORM(THIS.this_nSenhads)    + ", " + ;
                       "senhaos = "     + TRANSFORM(THIS.this_nSenhaos)    + ", " + ;
                       "democreds = "   + TRANSFORM(THIS.this_nDemocreds)  + ", " + ;
                       "digcpfs = "     + TRANSFORM(THIS.this_nDigcpfs)    + ", " + ;
                       "congvends = "   + TRANSFORM(THIS.this_nCongvends)  + ", " + ;
                       "chkqtdss = "    + TRANSFORM(THIS.this_nChkqtdss)   + ", " + ;
                       "valitnegs = "   + TRANSFORM(THIS.this_nValitnegs)  + ", " + ;
                       "calcmos = "     + TRANSFORM(THIS.this_nCalcmos)    + ", " + ;
                       "chkdval = "     + TRANSFORM(THIS.this_nChkdval)    + ", " + ;
                       "tabdobrigs = "  + TRANSFORM(THIS.this_nTabdobrigs) + ", "
            loc_cSet = loc_cSet + ;
                       "dtemis = "      + TRANSFORM(THIS.this_nDtemis)     + ", " + ;
                       "conprecs = "    + TRANSFORM(THIS.this_nConprecs)   + ", " + ;
                       "trocoauts = "   + TRANSFORM(THIS.this_nTrocoauts)  + ", " + ;
                       "parczeros = "   + TRANSFORM(THIS.this_nParczeros)  + ", " + ;
                       "bxvlopcrs = "   + TRANSFORM(THIS.this_nBxvlopcrs)  + ", " + ;
                       "cadcliauts = "  + TRANSFORM(THIS.this_nCadcliauts) + ", " + ;
                       "obsitems = "    + TRANSFORM(THIS.this_nObsitems)   + ", " + ;
                       "varitems = "    + TRANSFORM(THIS.this_nVaritems)   + ", " + ;
                       "itsituas = "    + TRANSFORM(THIS.this_nItsituas)   + ", " + ;
                       "habsubits = "   + TRANSFORM(THIS.this_nHabsubits)  + ", " + ;
                       "oppends = "     + TRANSFORM(THIS.this_nOppends)    + ", " + ;
                       "cadprods = "    + TRANSFORM(THIS.this_nCadprods)   + ", " + ;
                       "subnautos = "   + TRANSFORM(THIS.this_nSubnautos)  + ", " + ;
                       "senhars = "     + TRANSFORM(THIS.this_nSenhars)    + ", " + ;
                       "totcompos = "   + TRANSFORM(THIS.this_nTotcompos)  + ", " + ;
                       "chkedesc = "    + TRANSFORM(THIS.this_nChkedesc)   + ", " + ;
                       "ncpesos = "     + TRANSFORM(THIS.this_nNcpesos)    + ", " + ;
                       "editdocs = "    + TRANSFORM(THIS.this_nEditdocs)   + ", " + ;
                       "cempsubns = "   + TRANSFORM(THIS.this_nCempsubns)  + ", " + ;
                       "carcbars = "    + TRANSFORM(THIS.this_nCarcbars)   + ", "
            loc_cSet = loc_cSet + ;
                       "ctrllotes = "   + TRANSFORM(THIS.this_nCtrllotes)  + ", " + ;
                       "orilotes = "    + TRANSFORM(THIS.this_nOrilotes)   + ", " + ;
                       "reffs = "       + TRANSFORM(THIS.this_nReffs)      + ", " + ;
                       "ccustos = "     + TRANSFORM(THIS.this_nCcustos)    + ", " + ;
                       "dcpns = "       + TRANSFORM(THIS.this_nDcpns)      + ", " + ;
                       "dtbars = "      + TRANSFORM(THIS.this_nDtbars)     + ", " + ;
                       "aciosens = "    + TRANSFORM(THIS.this_nAciosens)   + ", " + ;
                       "cliods = "      + TRANSFORM(THIS.this_nCliods)     + ", " + ;
                       "edcomis = "     + TRANSFORM(THIS.this_nEdcomis)    + ", " + ;
                       "infoipis = "    + TRANSFORM(THIS.this_nInfoipis)   + ", " + ;
                       "agrupas = "     + TRANSFORM(THIS.this_nAgrupas)    + ", " + ;
                       "digenves = "    + TRANSFORM(THIS.this_nDigenves)   + ", " + ;
                       "digrecs = "     + TRANSFORM(THIS.this_nDigrecs)    + ", " + ;
                       "empsubns = "    + TRANSFORM(THIS.this_nEmpsubns)   + ", " + ;
                       "fechmals = "    + TRANSFORM(THIS.this_nFechmals)   + ", " + ;
                       "habservs = "    + TRANSFORM(THIS.this_nHabservs)   + ", " + ;
                       "marcasubns = "  + TRANSFORM(THIS.this_nMarcasubns) + ", " + ;
                       "tiponfs = "     + TRANSFORM(THIS.this_nTiponfs)    + ", " + ;
                       "chkacpro = "    + TRANSFORM(THIS.this_nChkacpro)   + ", " + ;
                       "edunis = "      + TRANSFORM(THIS.this_nEdunis)     + ", "
            loc_cSet = loc_cSet + ;
                       "anprodzs = "    + TRANSFORM(THIS.this_nAnprodzs)   + ", " + ;
                       "autenticas = "  + TRANSFORM(THIS.this_nAutenticas) + ", " + ;
                       "autoins = "     + TRANSFORM(THIS.this_nAutoins)    + ", " + ;
                       "bxpagos = "     + TRANSFORM(THIS.this_nBxpagos)    + ", " + ;
                       "carvends = "    + TRANSFORM(THIS.this_nCarvends)   + ", " + ;
                       "cbxsubns = "    + TRANSFORM(THIS.this_nCbxsubns)   + ", " + ;
                       "checpagos = "   + TRANSFORM(THIS.this_nChecpagos)  + ", " + ;
                       "chkagends = "   + TRANSFORM(THIS.this_nChkagends)  + ", " + ;
                       "inibcchqs = "   + TRANSFORM(THIS.this_nInibcchqs)  + ", " + ;
                       "inibmens = "    + TRANSFORM(THIS.this_nInibmens)   + ", " + ;
                       "inibmlcs = "    + TRANSFORM(THIS.this_nInibmlcs)   + ", " + ;
                       "ncarsubs = "    + TRANSFORM(THIS.this_nNcarsubs)   + ", " + ;
                       "obrigvd2s = "   + TRANSFORM(THIS.this_nObrigvd2s)  + ", " + ;
                       "obrigvds = "    + TRANSFORM(THIS.this_nObrigvds)   + ", " + ;
                       "tplprecs = "    + TRANSFORM(THIS.this_nTplprecs)   + ", " + ;
                       "fpubl = "       + TRANSFORM(THIS.this_nFpubl)      + ", " + ;
                       "nfcompls = "    + TRANSFORM(THIS.this_nNfcompls)   + ", " + ;
                       "docus = "       + TRANSFORM(THIS.this_nDocus)      + ", " + ;
                       "itautos = "     + TRANSFORM(THIS.this_nItautos)    + ", " + ;
                       "precops = "     + TRANSFORM(THIS.this_nPrecops)    + ", "
            loc_cSet = loc_cSet + ;
                       "comisdivs = "   + TRANSFORM(THIS.this_nComisdivs)  + ", " + ;
                       "trnfis = "      + TRANSFORM(THIS.this_nTrnfis)     + ", " + ;
                       "obspads = "     + TRANSFORM(THIS.this_nObspads)    + ", " + ;
                       "obsfins = "     + TRANSFORM(THIS.this_nObsfins)    + ", " + ;
                       "obsinis = "     + TRANSFORM(THIS.this_nObsinis)    + ", " + ;
                       "cdopes = "      + TRANSFORM(THIS.this_nCdopes)     + ", " + ;
                       "ndopes = "      + TRANSFORM(THIS.this_nNdopes)     + ", " + ;
                       "ordes = "       + TRANSFORM(THIS.this_nOrdes)      + ", " + ;
                       "qtdites = "     + TRANSFORM(THIS.this_nQtdites)    + ", " + ;
                       "porcs = "       + FormatarNumeroSQL(THIS.this_nPorcs)      + ", " + ;
                       "vcompensas = "  + FormatarNumeroSQL(THIS.this_nVcompensas) + ", " + ;
                       "fixcdests = "   + IIF(THIS.this_lFixcdests, "1", "0") + ", " + ;
                       "fixcnopes = "   + IIF(THIS.this_lFixcnopes, "1", "0") + ", " + ;
                       "fixcorigs = "   + IIF(THIS.this_lFixcorigs, "1", "0") + ", " + ;
                       "fixgdests = "   + IIF(THIS.this_lFixgdests, "1", "0") + ", " + ;
                       "fixgorigs = "   + IIF(THIS.this_lFixgorigs, "1", "0") + ", " + ;
                       "fixgropes = "   + IIF(THIS.this_lFixgropes, "1", "0") + ", " + ;
                       "fixgvends = "   + IIF(THIS.this_lFixgvends, "1", "0") + ", " + ;
                       "chkfunds = "    + IIF(THIS.this_lChkfunds,  "1", "0") + ", " + ;
                       "fixgven2s = "   + IIF(THIS.this_lFixgven2s, "1", "0") + ", " + ;
                       "datatrans = "   + loc_cDatatrans + ", "
            loc_cSet = loc_cSet + ;
                       "dopeetrfs = "   + EscaparSQL(THIS.this_cDopeetrfs)  + ", " + ;
                       "abrevs = "      + EscaparSQL(THIS.this_cAbrevs)     + ", " + ;
                       "ccentrals = "   + EscaparSQL(THIS.this_cCcentrals)  + ", " + ;
                       "cmoes = "       + EscaparSQL(THIS.this_cCmoes)      + ", " + ;
                       "cnopes = "      + EscaparSQL(THIS.this_cCnopes)     + ", " + ;
                       "condests = "    + EscaparSQL(THIS.this_cCondests)   + ", " + ;
                       "conorigs = "    + EscaparSQL(THIS.this_cConorigs)   + ", " + ;
                       "contas = "      + EscaparSQL(THIS.this_cContas)     + ", " + ;
                       "emppads = "     + EscaparSQL(THIS.this_cEmppads)    + ", " + ;
                       "grudests = "    + EscaparSQL(THIS.this_cGrudests)   + ", " + ;
                       "gruorigs = "    + EscaparSQL(THIS.this_cGruorigs)   + ", " + ;
                       "grupos = "      + EscaparSQL(THIS.this_cGrupos)     + ", " + ;
                       "grvends = "     + EscaparSQL(THIS.this_cGrvends)    + ", " + ;
                       "menus = "       + EscaparSQL(THIS.this_cMenus)      + ", " + ;
                       "nivels = "      + EscaparSQL(THIS.this_cNivels)     + ", " + ;
                       "nopcrs = "      + EscaparSQL(THIS.this_cNopcrs)     + ", " + ;
                       "tabdps = "      + EscaparSQL(THIS.this_cTabdps)     + ", " + ;
                       "dopcs = "       + EscaparSQL(THIS.this_cDopcs)      + ", " + ;
                       "especies = "    + EscaparSQL(THIS.this_cEspecies)   + ", " + ;
                       "series = "      + EscaparSQL(THIS.this_cSeries)     + ", "
            loc_cSet = loc_cSet + ;
                       "hist2s = "      + EscaparSQL(THIS.this_cHist2s)     + ", " + ;
                       "hists = "       + EscaparSQL(THIS.this_cHists)      + ", " + ;
                       "submenus = "    + EscaparSQL(THIS.this_cSubmenus)   + ", " + ;
                       "grucados = "    + EscaparSQL(THIS.this_cGrucados)   + ", " + ;
                       "grucadds = "    + EscaparSQL(THIS.this_cGrucadds)   + ", " + ;
                       "grucadvs = "    + EscaparSQL(THIS.this_cGrucadvs)   + ", " + ;
                       "cfos = "        + EscaparSQL(THIS.this_cCfos)       + ", " + ;
                       "relfechgrs = "  + EscaparSQL(THIS.this_cRelfechgrs) + ", " + ;
                       "dopestrfs = "   + EscaparSQL(THIS.this_cDopestrfs)  + ", " + ;
                       "operchqes = "   + EscaparSQL(THIS.this_cOperchqes)  + ", " + ;
                       "operchqss = "   + EscaparSQL(THIS.this_cOperchqss)  + ", " + ;
                       "gremiss = "     + EscaparSQL(THIS.this_cGremiss)    + ", " + ;
                       "conemiss = "    + EscaparSQL(THIS.this_cConemiss)   + ", " + ;
                       "operfisics = "  + EscaparSQL(THIS.this_cOperfisics) + ", " + ;
                       "codpropads = "  + EscaparSQL(THIS.this_cCodpropads) + ", " + ;
                       "fpagopcrs = "   + EscaparSQL(THIS.this_cFpagopcrs)  + ", " + ;
                       "lprecopads = "  + EscaparSQL(THIS.this_cLprecopads) + ", " + ;
                       "mascvens = "    + EscaparSQL(THIS.this_cMascvens)   + ", " + ;
                       "impclis = "     + EscaparSQL(THIS.this_cImpclis)    + ", " + ;
                       "opernf = "      + EscaparSQL(THIS.this_cOpernf)     + ", "
            loc_cSet = loc_cSet + ;
                       "codconpads = "  + EscaparSQL(THIS.this_cCodconpads) + ", " + ;
                       "empbxs = "      + EscaparSQL(THIS.this_cEmpbxs)     + ", " + ;
                       "emplancs = "    + EscaparSQL(THIS.this_cEmplancs)   + ", " + ;
                       "opepads = "     + EscaparSQL(THIS.this_cOpepads)    + ", " + ;
                       "programas = "   + EscaparSQL(THIS.this_cProgramas)  + ", " + ;
                       "ctipomarms = "  + IIF(EMPTY(THIS.this_cCtipomarms), "NULL", EscaparSQL(THIS.this_cCtipomarms)) + ", " + ;
                       "carqicones = "  + IIF(EMPTY(THIS.this_cCarqicones), "NULL", EscaparSQL(THIS.this_cCarqicones)) + ", " + ;
                       "dopcreds = "    + EscaparSQL(THIS.this_cDopcreds)   + ", " + ;
                       "cfgfinancs = "  + EscaparSQL(THIS.this_cCfgfinancs) + ", " + ;
                       "obsopes = "     + EscaparSQL(THIS.this_mObsopes)
            loc_cSQL = "UPDATE SigCdOpe SET " + loc_cSet + ;
                       " WHERE dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o.", "Erro em Atualizar")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em Atualizar")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdOpe
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            THIS.RegistrarAuditoria("E")
            loc_cSQL = "DELETE FROM SigCdOpe WHERE dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o.", "Erro em ExecutarExclusao")
            ELSE
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ExecutarExclusao")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
