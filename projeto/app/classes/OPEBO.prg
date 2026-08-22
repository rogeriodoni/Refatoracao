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
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNCTION

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- Fase 2: implementar
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em Buscar")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNCTION

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (dopes)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- Fase 2: implementar
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em CarregarPorCodigo")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNCTION

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                *-- Fase 2: implementar campos
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
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- Fase 2: implementar
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em Inserir")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdOpe
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- Fase 2: implementar
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em Atualizar")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdOpe
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            *-- Fase 2: implementar
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro em ExecutarExclusao")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
