*====================================================================
* sigmvitnBO.prg
*
* Business Object para Caixa - Itens da Movimentacao (SIGMVITN)
* Tabela: SigMvItn
* Chave: cidchaves (fUniqueIds())
* Herda de: BusinessBase
*
* CarregarDoCursor, Inserir, Atualizar, ObterChavePrimaria e RegistrarAuditoria
* (via BusinessBase) - gravacao completa da linha de SigMvItn, caso um fluxo
* futuro precise chamar Salvar()/Excluir() nela.
*
* CarregarItensMovimento/CarregarParametrosOperacao - unicos metodos
* efetivamente chamados por Formsigmvitn.prg (FASE 4-8): trazem, via
* SQLEXEC direto (PILAR 3 - acesso a dados nunca dentro do form), os itens
* ja lancados na movimentacao corrente e os dois parametros de operacao
* (IdentPro/OpCrs) que definem como cada linha do cupom e montada. A
* finalizacao fiscal da venda (INSERT/UPDATE real de SigMvItn) permanece
* responsabilidade do form de movimentacao PAI - Formsigmvitn e um form
* filho (Caixa) que so lanca/consulta itens localmente e devolve o
* controle via THIS.Release() (ver cabecalho de Formsigmvitn.prg).
*====================================================================

DEFINE CLASS sigmvitnBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvItn)
    this_nAqtds          = 0    && aqtds numeric(9,3)
    this_nCitens         = 0    && citens numeric(10,0)
    this_nCodbarras      = 0    && codbarras numeric(14,0)
    this_cCpros          = ""   && cpros char(14)
    this_cCunis          = ""   && cunis char(3)
    this_dDatatrans      = {}   && datatrans datetime NULL
    this_nDescvals       = 0    && descvals numeric(7,2)
    this_cDopes          = ""   && dopes char(20)
    this_cDpros          = ""   && dpros char(65)
    this_cEmps           = ""   && emps char(3)
    this_lEtiesps        = .F.  && etiesps bit
    this_nFators         = 0    && fators numeric(8,3)
    this_nFatvals        = 0    && fatvals numeric(15,6)
    this_lFvals          = .F.  && fvals bit
    this_lIconfs         = .F.  && iconfs bit
    this_cLocals         = ""   && locals char(10)
    this_cMoedas         = ""   && moedas char(3)
    this_cMoefats        = ""   && moefats char(3)
    this_nMoevals        = 0    && moevals numeric(15,6)
    this_cNotas          = ""   && notas char(6)
    this_cNrcons         = ""   && nrcons char(10)
    this_nNtrans         = 0    && ntrans numeric(6,0)
    this_nNumes          = 0    && numes numeric(6,0)
    this_nNumolds        = 0    && numolds numeric(6,0)
    this_cObs            = ""   && obs text NULL (memo)
    this_cOpers          = ""   && opers char(1)
    this_nPesos          = 0    && pesos numeric(9,3)
    this_nQtbaixas       = 0    && qtbaixas numeric(9,3)
    this_nQtbxprods      = 0    && qtbxprods numeric(9,3)
    this_nQtds           = 0    && qtds numeric(9,3)
    this_nQtprods        = 0    && qtprods numeric(9,3)
    this_nTotas          = 0    && totas numeric(11,2)
    this_nTpesos         = 0    && tpesos numeric(11,2)
    this_nUnitembs       = 0    && unitembs numeric(11,4)
    this_nUnits          = 0    && units numeric(15,6)
    this_nUnivals        = 0    && univals numeric(15,6)
    this_nVcoms          = 0    && vcoms numeric(8,2)
    this_nAliqs          = 0    && aliqs numeric(4,2)
    this_cSitribs        = ""   && sitribs char(2)
    this_cTpipis         = ""   && tpipis char(1)
    this_nValipis        = 0    && valipis numeric(11,2)
    this_nAliqicms       = 0    && aliqicms numeric(5,2)
    this_nValdescs       = 0    && valdescs numeric(9,2)
    this_cEmpos          = ""   && empos char(3)
    this_cMoevs          = ""   && moevs char(3)
    this_nUtilizas       = 0    && utilizas numeric(4,0)
    this_nNcodigos       = 0    && ncodigos numeric(10,0)
    this_nQtreservas     = 0    && qtreservas numeric(9,3)
    this_cCidchaves      = ""   && cidchaves char(20) - PK (fUniqueIds())
    this_nNlotes         = 0    && nlotes numeric(10,0)
    this_dDtalts         = {}   && dtalts datetime NULL
    this_cEmpdopnums     = ""   && empdopnums char(29)
    this_nBaseicms       = 0    && baseicms numeric(11,2)
    this_lChksubn        = .F.  && chksubn bit
    this_nUnit2s         = 0    && unit2s numeric(15,6)
    this_cUsulibs        = ""   && usulibs char(10)
    this_nValrats        = 0    && valrats numeric(14,6)
    this_nCodlprecs      = 0    && codlprecs numeric(6,0)
    this_cCunips         = ""   && cunips char(3)
    this_cMotdscs        = ""   && motdscs char(10)
    this_cTipos          = ""   && tipos char(1)
    this_nUnitinfs       = 0    && unitinfs numeric(14,6)
    this_cCpro2s         = ""   && cpro2s char(50)
    this_cAbrevis        = ""   && abrevis char(3)
    this_nBcicmss        = 0    && bcicmss numeric(15,2)
    this_nBcipis         = 0    && bcipis numeric(15,2)
    this_nIcms           = 0    && icms numeric(15,2)
    this_nIcmss          = 0    && icmss numeric(15,2)
    this_nPdescs         = 0    && pdescs numeric(5,2)
    this_nNchvtbds       = 0    && nchvtbds numeric(6,0)
    this_nIdpro          = 0    && idpro numeric(10,0)
    this_nUnitorigs      = 0    && unitorigs numeric(14,6)
    this_cOrigmercs      = ""   && origmercs char(1)
    this_nBaseicm2s      = 0    && baseicm2s numeric(11,2)
    this_nBaseicm3s      = 0    && baseicm3s numeric(11,2)
    this_nBaseipi2s      = 0    && baseipi2s numeric(11,2)
    this_nBaseipi3s      = 0    && baseipi3s numeric(11,2)
    this_cCfops          = ""   && cfops char(10)
    this_nRatdacs        = 0    && ratdacs numeric(11,2)
    this_nRatfrts        = 0    && ratfrts numeric(11,2)
    this_nRaticmds       = 0    && raticmds numeric(11,2)
    this_nRaticms        = 0    && raticms numeric(11,2)
    this_nRatsegs        = 0    && ratsegs numeric(11,2)
    this_cSittricms      = ""   && sittricms char(3)
    this_nAliqiis        = 0    && aliqiis numeric(4,2)
    this_nCitem2         = 0    && citem2 numeric(10,0)
    this_nTaxaiis        = 0    && taxaiis numeric(11,2)
    this_nVcofins        = 0    && vcofins numeric(11,2)
    this_nVpis           = 0    && vpis numeric(11,2)
    this_nAliqorigs      = 0    && aliqorigs numeric(4,2)
    this_lLcancelas      = .F.  && lcancelas bit
    this_nCompris        = 0    && compris numeric(6,2)
    this_cCodfabs        = ""   && codfabs char(60)
    this_nNadis          = 0    && nadis numeric(3,0)
    this_nNiadis         = 0    && niadis numeric(3,0)
    this_nAliqcofs       = 0    && aliqcofs numeric(4,2)
    this_nAliqpis        = 0    && aliqpis numeric(4,2)
    this_nCssl           = 0    && cssl numeric(11,2)
    this_nInss           = 0    && inss numeric(11,2)
    this_nIrrf           = 0    && irrf numeric(11,2)
    this_nIss            = 0    && iss numeric(11,2)
    this_nValbases       = 0    && valbases numeric(11,2)
    this_cLocalos        = ""   && localos char(10)
    this_nPfcpst         = 0    && pfcpst numeric(5,2)
    this_nVfcpst         = 0    && vfcpst numeric(11,2)
    this_cOb2s           = ""   && ob2s char(100)
    this_cPedidoweb      = ""   && pedidoweb char(50)
    this_nQtresres       = 0    && qtresres numeric(9,3)
    this_nBarraref       = 0    && barraref numeric(14,0)
    this_cItemped        = ""   && itemped char(4)
    this_cNumeronota     = ""   && numeronota char(10)
    this_cDopesorig      = ""   && dopesorig char(20)
    this_cChaveexterna   = ""   && chaveexterna char(33)
    this_nCkpresente     = 0    && ckpresente numeric(1,0)
    this_cGravacao       = ""   && gravacao char(20)
    this_cIfors          = ""   && ifors char(10)
    this_cPropriedades   = ""   && propriedades nvarchar(40) NULL
    this_cUnidade1       = ""   && unidade1 nvarchar(15) NULL
    this_cResultado1     = ""   && resultado1 nvarchar(15) NULL
    this_cValorMinimo    = ""   && valorMinimo nvarchar(15) NULL
    this_cValorMaximo    = ""   && valorMaximo nvarchar(15) NULL
    this_cMetodoReferencia1 = "" && metodoReferencia1 nvarchar(15) NULL

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigmvitnBO.Init")
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

                THIS.this_nAqtds = TratarNulo(aqtds, "N")
                THIS.this_nCitens = TratarNulo(citens, "N")
                THIS.this_nCodbarras = TratarNulo(codbarras, "N")
                THIS.this_cCpros = TratarNulo(cpros, "C")
                THIS.this_cCunis = TratarNulo(cunis, "C")
                THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                THIS.this_nDescvals = TratarNulo(descvals, "N")
                THIS.this_cDopes = TratarNulo(dopes, "C")
                THIS.this_cDpros = TratarNulo(dpros, "C")
                THIS.this_cEmps = TratarNulo(emps, "C")
                IF VARTYPE(etiesps) = "L"
                    THIS.this_lEtiesps = etiesps
                ELSE
                    THIS.this_lEtiesps = (NVL(etiesps, 0) = 1)
                ENDIF
                THIS.this_nFators = TratarNulo(fators, "N")
                THIS.this_nFatvals = TratarNulo(fatvals, "N")
                IF VARTYPE(fvals) = "L"
                    THIS.this_lFvals = fvals
                ELSE
                    THIS.this_lFvals = (NVL(fvals, 0) = 1)
                ENDIF
                IF VARTYPE(iconfs) = "L"
                    THIS.this_lIconfs = iconfs
                ELSE
                    THIS.this_lIconfs = (NVL(iconfs, 0) = 1)
                ENDIF
                THIS.this_cLocals = TratarNulo(locals, "C")
                THIS.this_cMoedas = TratarNulo(moedas, "C")
                THIS.this_cMoefats = TratarNulo(moefats, "C")
                THIS.this_nMoevals = TratarNulo(moevals, "N")
                THIS.this_cNotas = TratarNulo(notas, "C")
                THIS.this_cNrcons = TratarNulo(nrcons, "C")
                THIS.this_nNtrans = TratarNulo(ntrans, "N")
                THIS.this_nNumes = TratarNulo(numes, "N")
                THIS.this_nNumolds = TratarNulo(numolds, "N")
                THIS.this_cObs = TratarNulo(obs, "C")
                THIS.this_cOpers = TratarNulo(opers, "C")
                THIS.this_nPesos = TratarNulo(pesos, "N")
                THIS.this_nQtbaixas = TratarNulo(qtbaixas, "N")
                THIS.this_nQtbxprods = TratarNulo(qtbxprods, "N")
                THIS.this_nQtds = TratarNulo(qtds, "N")
                THIS.this_nQtprods = TratarNulo(qtprods, "N")
                THIS.this_nTotas = TratarNulo(totas, "N")
                THIS.this_nTpesos = TratarNulo(tpesos, "N")
                THIS.this_nUnitembs = TratarNulo(unitembs, "N")
                THIS.this_nUnits = TratarNulo(units, "N")
                THIS.this_nUnivals = TratarNulo(univals, "N")
                THIS.this_nVcoms = TratarNulo(vcoms, "N")
                THIS.this_nAliqs = TratarNulo(aliqs, "N")
                THIS.this_cSitribs = TratarNulo(sitribs, "C")
                THIS.this_cTpipis = TratarNulo(tpipis, "C")
                THIS.this_nValipis = TratarNulo(valipis, "N")
                THIS.this_nAliqicms = TratarNulo(aliqicms, "N")
                THIS.this_nValdescs = TratarNulo(valdescs, "N")
                THIS.this_cEmpos = TratarNulo(empos, "C")
                THIS.this_cMoevs = TratarNulo(moevs, "C")
                THIS.this_nUtilizas = TratarNulo(utilizas, "N")
                THIS.this_nNcodigos = TratarNulo(ncodigos, "N")
                THIS.this_nQtreservas = TratarNulo(qtreservas, "N")
                THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
                THIS.this_nNlotes = TratarNulo(nlotes, "N")
                THIS.this_dDtalts = TratarNulo(dtalts, "D")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                THIS.this_nBaseicms = TratarNulo(baseicms, "N")
                IF VARTYPE(chksubn) = "L"
                    THIS.this_lChksubn = chksubn
                ELSE
                    THIS.this_lChksubn = (NVL(chksubn, 0) = 1)
                ENDIF
                THIS.this_nUnit2s = TratarNulo(unit2s, "N")
                THIS.this_cUsulibs = TratarNulo(usulibs, "C")
                THIS.this_nValrats = TratarNulo(valrats, "N")
                THIS.this_nCodlprecs = TratarNulo(codlprecs, "N")
                THIS.this_cCunips = TratarNulo(cunips, "C")
                THIS.this_cMotdscs = TratarNulo(motdscs, "C")
                THIS.this_cTipos = TratarNulo(tipos, "C")
                THIS.this_nUnitinfs = TratarNulo(unitinfs, "N")
                THIS.this_cCpro2s = TratarNulo(cpro2s, "C")
                THIS.this_cAbrevis = TratarNulo(abrevis, "C")
                THIS.this_nBcicmss = TratarNulo(bcicmss, "N")
                THIS.this_nBcipis = TratarNulo(bcipis, "N")
                THIS.this_nIcms = TratarNulo(icms, "N")
                THIS.this_nIcmss = TratarNulo(icmss, "N")
                THIS.this_nPdescs = TratarNulo(pdescs, "N")
                THIS.this_nNchvtbds = TratarNulo(nchvtbds, "N")
                THIS.this_nIdpro = TratarNulo(idpro, "N")
                THIS.this_nUnitorigs = TratarNulo(unitorigs, "N")
                THIS.this_cOrigmercs = TratarNulo(origmercs, "C")
                THIS.this_nBaseicm2s = TratarNulo(baseicm2s, "N")
                THIS.this_nBaseicm3s = TratarNulo(baseicm3s, "N")
                THIS.this_nBaseipi2s = TratarNulo(baseipi2s, "N")
                THIS.this_nBaseipi3s = TratarNulo(baseipi3s, "N")
                THIS.this_cCfops = TratarNulo(cfops, "C")
                THIS.this_nRatdacs = TratarNulo(ratdacs, "N")
                THIS.this_nRatfrts = TratarNulo(ratfrts, "N")
                THIS.this_nRaticmds = TratarNulo(raticmds, "N")
                THIS.this_nRaticms = TratarNulo(raticms, "N")
                THIS.this_nRatsegs = TratarNulo(ratsegs, "N")
                THIS.this_cSittricms = TratarNulo(sittricms, "C")
                THIS.this_nAliqiis = TratarNulo(aliqiis, "N")
                THIS.this_nCitem2 = TratarNulo(citem2, "N")
                THIS.this_nTaxaiis = TratarNulo(taxaiis, "N")
                THIS.this_nVcofins = TratarNulo(vcofins, "N")
                THIS.this_nVpis = TratarNulo(vpis, "N")
                THIS.this_nAliqorigs = TratarNulo(aliqorigs, "N")
                IF VARTYPE(lcancelas) = "L"
                    THIS.this_lLcancelas = lcancelas
                ELSE
                    THIS.this_lLcancelas = (NVL(lcancelas, 0) = 1)
                ENDIF
                THIS.this_nCompris = TratarNulo(compris, "N")
                THIS.this_cCodfabs = TratarNulo(codfabs, "C")
                THIS.this_nNadis = TratarNulo(nadis, "N")
                THIS.this_nNiadis = TratarNulo(niadis, "N")
                THIS.this_nAliqcofs = TratarNulo(aliqcofs, "N")
                THIS.this_nAliqpis = TratarNulo(aliqpis, "N")
                THIS.this_nCssl = TratarNulo(cssl, "N")
                THIS.this_nInss = TratarNulo(inss, "N")
                THIS.this_nIrrf = TratarNulo(irrf, "N")
                THIS.this_nIss = TratarNulo(iss, "N")
                THIS.this_nValbases = TratarNulo(valbases, "N")
                THIS.this_cLocalos = TratarNulo(localos, "C")
                THIS.this_nPfcpst = TratarNulo(pfcpst, "N")
                THIS.this_nVfcpst = TratarNulo(vfcpst, "N")
                THIS.this_cOb2s = TratarNulo(ob2s, "C")
                THIS.this_cPedidoweb = TratarNulo(pedidoweb, "C")
                THIS.this_nQtresres = TratarNulo(qtresres, "N")
                THIS.this_nBarraref = TratarNulo(barraref, "N")
                THIS.this_cItemped = TratarNulo(itemped, "C")
                THIS.this_cNumeronota = TratarNulo(numeronota, "C")
                THIS.this_cDopesorig = TratarNulo(dopesorig, "C")
                THIS.this_cChaveexterna = TratarNulo(chaveexterna, "C")
                THIS.this_nCkpresente = TratarNulo(ckpresente, "N")
                THIS.this_cGravacao = TratarNulo(gravacao, "C")
                THIS.this_cIfors = TratarNulo(ifors, "C")
                THIS.this_cPropriedades = TratarNulo(propriedades, "C")
                THIS.this_cUnidade1 = TratarNulo(unidade1, "C")
                THIS.this_cResultado1 = TratarNulo(resultado1, "C")
                THIS.this_cValorMinimo = TratarNulo(valorMinimo, "C")
                THIS.this_cValorMaximo = TratarNulo(valorMaximo, "C")
                THIS.this_cMetodoReferencia1 = TratarNulo(metodoReferencia1, "C")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitnBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigMvItn
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Campo computado: Emps + Dopes + Numes (chave da movimentacao, liga o item ao cabecalho)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvItn ("
            loc_cSQL = loc_cSQL + "aqtds, citens, codbarras, cpros, cunis, datatrans, descvals, dopes,"
            loc_cSQL = loc_cSQL + "dpros, emps, etiesps, fators, fatvals, fvals, iconfs, locals,"
            loc_cSQL = loc_cSQL + "moedas, moefats, moevals, notas, nrcons, ntrans, numes, numolds,"
            loc_cSQL = loc_cSQL + "obs, opers, pesos, qtbaixas, qtbxprods, qtds, qtprods, totas,"
            loc_cSQL = loc_cSQL + "tpesos, unitembs, units, univals, vcoms, aliqs, sitribs, tpipis,"
            loc_cSQL = loc_cSQL + "valipis, aliqicms, valdescs, empos, moevs, utilizas, ncodigos, qtreservas,"
            loc_cSQL = loc_cSQL + "cidchaves, nlotes, dtalts, empdopnums, baseicms, chksubn, unit2s, usulibs,"
            loc_cSQL = loc_cSQL + "valrats, codlprecs, cunips, motdscs, tipos, unitinfs, cpro2s, abrevis,"
            loc_cSQL = loc_cSQL + "bcicmss, bcipis, icms, icmss, pdescs, nchvtbds, idpro, unitorigs,"
            loc_cSQL = loc_cSQL + "origmercs, baseicm2s, baseicm3s, baseipi2s, baseipi3s, cfops, ratdacs, ratfrts,"
            loc_cSQL = loc_cSQL + "raticmds, raticms, ratsegs, sittricms, aliqiis, citem2, taxaiis, vcofins,"
            loc_cSQL = loc_cSQL + "vpis, aliqorigs, lcancelas, compris, codfabs, nadis, niadis, aliqcofs,"
            loc_cSQL = loc_cSQL + "aliqpis, cssl, inss, irrf, iss, valbases, localos, pfcpst,"
            loc_cSQL = loc_cSQL + "vfcpst, ob2s, pedidoweb, qtresres, barraref, itemped, numeronota, dopesorig,"
            loc_cSQL = loc_cSQL + "chaveexterna, ckpresente, gravacao, ifors, propriedades, unidade1, resultado1, valorMinimo,"
            loc_cSQL = loc_cSQL + "valorMaximo, metodoReferencia1"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nAqtds, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCodbarras, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nDescvals, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lEtiesps, "1", "0") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFators, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFatvals, 6) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lFvals, "1", "0") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lIconfs, "1", "0") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nMoevals, 6) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNrcons, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumolds, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPesos, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtbaixas, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtbxprods, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtds, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtprods, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpesos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnitembs, 4) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnits, 6) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnivals, 6) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVcoms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nAliqs, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSitribs, 2)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpipis, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValipis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nAliqicms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValdescs, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNcodigos, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtreservas, 3) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNlotes, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtalts) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBaseicms, 2) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lChksubn, "1", "0") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnit2s, 6) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsulibs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValrats, 6) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCodlprecs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnitinfs, 6) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCpro2s, 50)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAbrevis, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBcicmss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBcipis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIcms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIcmss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPdescs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNchvtbds, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIdpro, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnitorigs, 6) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOrigmercs, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBaseicm2s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBaseicm3s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBaseipi2s, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBaseipi3s, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCfops, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRatdacs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRatfrts, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRaticmds, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRaticms, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRatsegs, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSittricms, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nAliqiis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTaxaiis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVcofins, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nAliqorigs, 2) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lLcancelas, "1", "0") + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCompris, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodfabs, 60)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNadis, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNiadis, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nAliqcofs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCssl, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nInss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIrrf, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIss, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValbases, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocalos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPfcpst, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nVfcpst, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOb2s, 100)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPedidoweb, 50)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtresres, 3) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBarraref, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cItemped, 4)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNumeronota, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopesorig, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCkpresente, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGravacao, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cIfors, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPropriedades, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUnidade1, 15)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cResultado1, 15)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cValorMinimo, 15)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cValorMaximo, 15)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMetodoReferencia1, 15)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir item da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitnBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigMvItn (por cidchaves)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Emps + Dopes + Numes (chave da movimentacao, liga o item ao cabecalho)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            *-- Data de alteracao
            THIS.this_dDtalts = DATETIME()

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvItn SET"
            loc_cSQL = loc_cSQL + " aqtds = " + FormatarNumeroSQL(THIS.this_nAqtds, 3) + ","
            loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
            loc_cSQL = loc_cSQL + " codbarras = " + FormatarNumeroSQL(THIS.this_nCodbarras, 0) + ","
            loc_cSQL = loc_cSQL + " cpros = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
            loc_cSQL = loc_cSQL + " cunis = " + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
            loc_cSQL = loc_cSQL + " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + " descvals = " + FormatarNumeroSQL(THIS.this_nDescvals, 2) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " dpros = " + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " etiesps = " + IIF(THIS.this_lEtiesps, "1", "0") + ","
            loc_cSQL = loc_cSQL + " fators = " + FormatarNumeroSQL(THIS.this_nFators, 3) + ","
            loc_cSQL = loc_cSQL + " fatvals = " + FormatarNumeroSQL(THIS.this_nFatvals, 6) + ","
            loc_cSQL = loc_cSQL + " fvals = " + IIF(THIS.this_lFvals, "1", "0") + ","
            loc_cSQL = loc_cSQL + " iconfs = " + IIF(THIS.this_lIconfs, "1", "0") + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " moefats = " + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
            loc_cSQL = loc_cSQL + " moevals = " + FormatarNumeroSQL(THIS.this_nMoevals, 6) + ","
            loc_cSQL = loc_cSQL + " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 6)) + ","
            loc_cSQL = loc_cSQL + " nrcons = " + EscaparSQL(LEFT(THIS.this_cNrcons, 10)) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " numolds = " + FormatarNumeroSQL(THIS.this_nNumolds, 0) + ","
            loc_cSQL = loc_cSQL + " obs = " + EscaparSQL(THIS.this_cObs) + ","
            loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + " pesos = " + FormatarNumeroSQL(THIS.this_nPesos, 3) + ","
            loc_cSQL = loc_cSQL + " qtbaixas = " + FormatarNumeroSQL(THIS.this_nQtbaixas, 3) + ","
            loc_cSQL = loc_cSQL + " qtbxprods = " + FormatarNumeroSQL(THIS.this_nQtbxprods, 3) + ","
            loc_cSQL = loc_cSQL + " qtds = " + FormatarNumeroSQL(THIS.this_nQtds, 3) + ","
            loc_cSQL = loc_cSQL + " qtprods = " + FormatarNumeroSQL(THIS.this_nQtprods, 3) + ","
            loc_cSQL = loc_cSQL + " totas = " + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
            loc_cSQL = loc_cSQL + " tpesos = " + FormatarNumeroSQL(THIS.this_nTpesos, 2) + ","
            loc_cSQL = loc_cSQL + " unitembs = " + FormatarNumeroSQL(THIS.this_nUnitembs, 4) + ","
            loc_cSQL = loc_cSQL + " units = " + FormatarNumeroSQL(THIS.this_nUnits, 6) + ","
            loc_cSQL = loc_cSQL + " univals = " + FormatarNumeroSQL(THIS.this_nUnivals, 6) + ","
            loc_cSQL = loc_cSQL + " vcoms = " + FormatarNumeroSQL(THIS.this_nVcoms, 2) + ","
            loc_cSQL = loc_cSQL + " aliqs = " + FormatarNumeroSQL(THIS.this_nAliqs, 2) + ","
            loc_cSQL = loc_cSQL + " sitribs = " + EscaparSQL(LEFT(THIS.this_cSitribs, 2)) + ","
            loc_cSQL = loc_cSQL + " tpipis = " + EscaparSQL(LEFT(THIS.this_cTpipis, 1)) + ","
            loc_cSQL = loc_cSQL + " valipis = " + FormatarNumeroSQL(THIS.this_nValipis, 2) + ","
            loc_cSQL = loc_cSQL + " aliqicms = " + FormatarNumeroSQL(THIS.this_nAliqicms, 2) + ","
            loc_cSQL = loc_cSQL + " valdescs = " + FormatarNumeroSQL(THIS.this_nValdescs, 2) + ","
            loc_cSQL = loc_cSQL + " empos = " + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + " moevs = " + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
            loc_cSQL = loc_cSQL + " utilizas = " + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
            loc_cSQL = loc_cSQL + " ncodigos = " + FormatarNumeroSQL(THIS.this_nNcodigos, 0) + ","
            loc_cSQL = loc_cSQL + " qtreservas = " + FormatarNumeroSQL(THIS.this_nQtreservas, 3) + ","
            loc_cSQL = loc_cSQL + " nlotes = " + FormatarNumeroSQL(THIS.this_nNlotes, 0) + ","
            loc_cSQL = loc_cSQL + " dtalts = " + FormatarDataSQL(THIS.this_dDtalts) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " baseicms = " + FormatarNumeroSQL(THIS.this_nBaseicms, 2) + ","
            loc_cSQL = loc_cSQL + " chksubn = " + IIF(THIS.this_lChksubn, "1", "0") + ","
            loc_cSQL = loc_cSQL + " unit2s = " + FormatarNumeroSQL(THIS.this_nUnit2s, 6) + ","
            loc_cSQL = loc_cSQL + " usulibs = " + EscaparSQL(LEFT(THIS.this_cUsulibs, 10)) + ","
            loc_cSQL = loc_cSQL + " valrats = " + FormatarNumeroSQL(THIS.this_nValrats, 6) + ","
            loc_cSQL = loc_cSQL + " codlprecs = " + FormatarNumeroSQL(THIS.this_nCodlprecs, 0) + ","
            loc_cSQL = loc_cSQL + " cunips = " + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
            loc_cSQL = loc_cSQL + " motdscs = " + EscaparSQL(LEFT(THIS.this_cMotdscs, 10)) + ","
            loc_cSQL = loc_cSQL + " tipos = " + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + " unitinfs = " + FormatarNumeroSQL(THIS.this_nUnitinfs, 6) + ","
            loc_cSQL = loc_cSQL + " cpro2s = " + EscaparSQL(LEFT(THIS.this_cCpro2s, 50)) + ","
            loc_cSQL = loc_cSQL + " abrevis = " + EscaparSQL(LEFT(THIS.this_cAbrevis, 3)) + ","
            loc_cSQL = loc_cSQL + " bcicmss = " + FormatarNumeroSQL(THIS.this_nBcicmss, 2) + ","
            loc_cSQL = loc_cSQL + " bcipis = " + FormatarNumeroSQL(THIS.this_nBcipis, 2) + ","
            loc_cSQL = loc_cSQL + " icms = " + FormatarNumeroSQL(THIS.this_nIcms, 2) + ","
            loc_cSQL = loc_cSQL + " icmss = " + FormatarNumeroSQL(THIS.this_nIcmss, 2) + ","
            loc_cSQL = loc_cSQL + " pdescs = " + FormatarNumeroSQL(THIS.this_nPdescs, 2) + ","
            loc_cSQL = loc_cSQL + " nchvtbds = " + FormatarNumeroSQL(THIS.this_nNchvtbds, 0) + ","
            loc_cSQL = loc_cSQL + " idpro = " + FormatarNumeroSQL(THIS.this_nIdpro, 0) + ","
            loc_cSQL = loc_cSQL + " unitorigs = " + FormatarNumeroSQL(THIS.this_nUnitorigs, 6) + ","
            loc_cSQL = loc_cSQL + " origmercs = " + EscaparSQL(LEFT(THIS.this_cOrigmercs, 1)) + ","
            loc_cSQL = loc_cSQL + " baseicm2s = " + FormatarNumeroSQL(THIS.this_nBaseicm2s, 2) + ","
            loc_cSQL = loc_cSQL + " baseicm3s = " + FormatarNumeroSQL(THIS.this_nBaseicm3s, 2) + ","
            loc_cSQL = loc_cSQL + " baseipi2s = " + FormatarNumeroSQL(THIS.this_nBaseipi2s, 2) + ","
            loc_cSQL = loc_cSQL + " baseipi3s = " + FormatarNumeroSQL(THIS.this_nBaseipi3s, 2) + ","
            loc_cSQL = loc_cSQL + " cfops = " + EscaparSQL(LEFT(THIS.this_cCfops, 10)) + ","
            loc_cSQL = loc_cSQL + " ratdacs = " + FormatarNumeroSQL(THIS.this_nRatdacs, 2) + ","
            loc_cSQL = loc_cSQL + " ratfrts = " + FormatarNumeroSQL(THIS.this_nRatfrts, 2) + ","
            loc_cSQL = loc_cSQL + " raticmds = " + FormatarNumeroSQL(THIS.this_nRaticmds, 2) + ","
            loc_cSQL = loc_cSQL + " raticms = " + FormatarNumeroSQL(THIS.this_nRaticms, 2) + ","
            loc_cSQL = loc_cSQL + " ratsegs = " + FormatarNumeroSQL(THIS.this_nRatsegs, 2) + ","
            loc_cSQL = loc_cSQL + " sittricms = " + EscaparSQL(LEFT(THIS.this_cSittricms, 3)) + ","
            loc_cSQL = loc_cSQL + " aliqiis = " + FormatarNumeroSQL(THIS.this_nAliqiis, 2) + ","
            loc_cSQL = loc_cSQL + " citem2 = " + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
            loc_cSQL = loc_cSQL + " taxaiis = " + FormatarNumeroSQL(THIS.this_nTaxaiis, 2) + ","
            loc_cSQL = loc_cSQL + " vcofins = " + FormatarNumeroSQL(THIS.this_nVcofins, 2) + ","
            loc_cSQL = loc_cSQL + " vpis = " + FormatarNumeroSQL(THIS.this_nVpis, 2) + ","
            loc_cSQL = loc_cSQL + " aliqorigs = " + FormatarNumeroSQL(THIS.this_nAliqorigs, 2) + ","
            loc_cSQL = loc_cSQL + " lcancelas = " + IIF(THIS.this_lLcancelas, "1", "0") + ","
            loc_cSQL = loc_cSQL + " compris = " + FormatarNumeroSQL(THIS.this_nCompris, 2) + ","
            loc_cSQL = loc_cSQL + " codfabs = " + EscaparSQL(LEFT(THIS.this_cCodfabs, 60)) + ","
            loc_cSQL = loc_cSQL + " nadis = " + FormatarNumeroSQL(THIS.this_nNadis, 0) + ","
            loc_cSQL = loc_cSQL + " niadis = " + FormatarNumeroSQL(THIS.this_nNiadis, 0) + ","
            loc_cSQL = loc_cSQL + " aliqcofs = " + FormatarNumeroSQL(THIS.this_nAliqcofs, 2) + ","
            loc_cSQL = loc_cSQL + " aliqpis = " + FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ","
            loc_cSQL = loc_cSQL + " cssl = " + FormatarNumeroSQL(THIS.this_nCssl, 2) + ","
            loc_cSQL = loc_cSQL + " inss = " + FormatarNumeroSQL(THIS.this_nInss, 2) + ","
            loc_cSQL = loc_cSQL + " irrf = " + FormatarNumeroSQL(THIS.this_nIrrf, 2) + ","
            loc_cSQL = loc_cSQL + " iss = " + FormatarNumeroSQL(THIS.this_nIss, 2) + ","
            loc_cSQL = loc_cSQL + " valbases = " + FormatarNumeroSQL(THIS.this_nValbases, 2) + ","
            loc_cSQL = loc_cSQL + " localos = " + EscaparSQL(LEFT(THIS.this_cLocalos, 10)) + ","
            loc_cSQL = loc_cSQL + " pfcpst = " + FormatarNumeroSQL(THIS.this_nPfcpst, 2) + ","
            loc_cSQL = loc_cSQL + " vfcpst = " + FormatarNumeroSQL(THIS.this_nVfcpst, 2) + ","
            loc_cSQL = loc_cSQL + " ob2s = " + EscaparSQL(LEFT(THIS.this_cOb2s, 100)) + ","
            loc_cSQL = loc_cSQL + " pedidoweb = " + EscaparSQL(LEFT(THIS.this_cPedidoweb, 50)) + ","
            loc_cSQL = loc_cSQL + " qtresres = " + FormatarNumeroSQL(THIS.this_nQtresres, 3) + ","
            loc_cSQL = loc_cSQL + " barraref = " + FormatarNumeroSQL(THIS.this_nBarraref, 0) + ","
            loc_cSQL = loc_cSQL + " itemped = " + EscaparSQL(LEFT(THIS.this_cItemped, 4)) + ","
            loc_cSQL = loc_cSQL + " numeronota = " + EscaparSQL(LEFT(THIS.this_cNumeronota, 10)) + ","
            loc_cSQL = loc_cSQL + " dopesorig = " + EscaparSQL(LEFT(THIS.this_cDopesorig, 20)) + ","
            loc_cSQL = loc_cSQL + " chaveexterna = " + EscaparSQL(LEFT(THIS.this_cChaveexterna, 33)) + ","
            loc_cSQL = loc_cSQL + " ckpresente = " + FormatarNumeroSQL(THIS.this_nCkpresente, 0) + ","
            loc_cSQL = loc_cSQL + " gravacao = " + EscaparSQL(LEFT(THIS.this_cGravacao, 20)) + ","
            loc_cSQL = loc_cSQL + " ifors = " + EscaparSQL(LEFT(THIS.this_cIfors, 10)) + ","
            loc_cSQL = loc_cSQL + " propriedades = " + EscaparSQL(LEFT(THIS.this_cPropriedades, 40)) + ","
            loc_cSQL = loc_cSQL + " unidade1 = " + EscaparSQL(LEFT(THIS.this_cUnidade1, 15)) + ","
            loc_cSQL = loc_cSQL + " resultado1 = " + EscaparSQL(LEFT(THIS.this_cResultado1, 15)) + ","
            loc_cSQL = loc_cSQL + " valorMinimo = " + EscaparSQL(LEFT(THIS.this_cValorMinimo, 15)) + ","
            loc_cSQL = loc_cSQL + " valorMaximo = " + EscaparSQL(LEFT(THIS.this_cValorMaximo, 15)) + ","
            loc_cSQL = loc_cSQL + " metodoReferencia1 = " + EscaparSQL(LEFT(THIS.this_cMetodoReferencia1, 15))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar item da movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvitnBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarItensMovimento - Le do SQL Server TODOS os itens ja lancados
    * da movimentacao (Empresa + Operacao + Numero) e devolve no cursor
    * TEMPORARIO par_cCursorDestino.
    *
    * Equivale ao que o form PAI fazia no legado: o SIGMVITN.SCX nao busca
    * os itens por conta propria - recebe o cursor crTpmMvItn ja montado
    * pela tela de movimentacao (datasession compartilhada). Como o form
    * migrado usa DataSession = 2 (isolado), a carga passa a ser feita aqui,
    * no BO (PILAR 3: acesso a dados NUNCA dentro do form).
    *
    * Devolve SEMPRE cursor TEMPORARIO - NUNCA o cursor ligado a grade: o
    * form faz ZAP + APPEND FROM DBF() no cursor da grade, preservando a
    * estrutura do CREATE CURSOR e o binding das colunas.
    *
    * Colunas: as 23 de SigMvItn que o legado referencia em crTpmMvItn (ver
    * dump tasks\task571\sigmvitn_form_codigo_fonte.txt). As outras duas -
    * ImpCupFis e LPrecos - NAO existem em SigMvItn: sao campos de CONTROLE
    * que so existem no cursor local do form, e por isso ficam de fora do
    * SELECT (o APPEND FROM preenche apenas o que casa por nome).
    *====================================================================
    PROCEDURE CarregarItensMovimento(par_cEmps, par_cDopes, par_nNumes, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCursor
        loc_lSucesso = .F.

        TRY
            loc_cCursor = IIF(VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino), ;
                ALLTRIM(par_cCursorDestino), "cursor_4c_ItensTmp")

            loc_cSQL = "SELECT i.citens, i.cpros, i.dpros, i.cunis, i.codbarras,"
            loc_cSQL = loc_cSQL + " i.codlprecs, i.empdopnums, i.etiesps, i.fators,"
            loc_cSQL = loc_cSQL + " i.fatvals, i.moedas, i.moefats, i.moevals, i.notas,"
            loc_cSQL = loc_cSQL + " i.opers, i.pesos, i.qtds, i.totas, i.units,"
            loc_cSQL = loc_cSQL + " i.univals, i.utilizas, i.valdescs, i.obs,"
            *-- Colunas de APOIO (nao existem em SigMvItn): reproduzem o cursor
            *-- xPro que o legado consultava item a item em SigCdPro dentro do
            *-- AtuaCupom, para montar a linha do cupom. Vem no MESMO SELECT
            *-- para evitar uma consulta por item (o legado fazia uma por item).
            loc_cSQL = loc_cSQL + " ISNULL(p.cbars, 0) AS procbars,"
            loc_cSQL = loc_cSQL + " ISNULL(p.descecfs, SPACE(29)) AS prodescecf,"
            loc_cSQL = loc_cSQL + " ISNULL(CAST(p.descfis AS VARCHAR(100)), SPACE(100)) AS prodescfis"
            loc_cSQL = loc_cSQL + " FROM SigMvItn i"
            loc_cSQL = loc_cSQL + " LEFT JOIN SigCdPro p ON p.cpros = i.cpros"
            loc_cSQL = loc_cSQL + " WHERE i.emps = " + EscaparSQL(LEFT(TratarNulo(par_cEmps, "C"), 3))
            loc_cSQL = loc_cSQL + " AND i.dopes = " + EscaparSQL(LEFT(TratarNulo(par_cDopes, "C"), 20))
            loc_cSQL = loc_cSQL + " AND i.numes = " + FormatarNumeroSQL(TratarNulo(par_nNumes, "N"), 0)
            loc_cSQL = loc_cSQL + " ORDER BY i.citens"

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResult < 0
                MsgErro("Erro ao carregar os itens da movimenta" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + ;
                CHR(13) + "Procedure: " + loException.Procedure, ;
                "Erro em sigmvitnBO.CarregarItensMovimento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarParametrosOperacao - Le os dois parametros da OPERACAO que
    * governam como cada linha do cupom e montada:
    *   SigOpCdd.IdentPro - 1 = identificar o produto pela Descricao Fiscal
    *                       (Mline(DescFis,1) truncada em 40), demais valores
    *                       = identificar pelo codigo de barras.
    *   SigCdOpe.OpCrs    - tipo da operacao de credito; OpCrs = 4 desliga a
    *                       identificacao por Descricao Fiscal (ver o
    *                       AtuaCupom do dump legado).
    * No legado esses dois valores vinham dos cursores globais CrSigOpCdd e
    * CrSigCdOpe, carregados pela tela de movimentacao na datasession
    * compartilhada. Com DataSession = 2 o form le pelo BO.
    *====================================================================
    PROCEDURE CarregarParametrosOperacao(par_cDopes, par_cCursorDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCursor
        loc_lSucesso = .F.

        TRY
            loc_cCursor = IIF(VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino), ;
                ALLTRIM(par_cCursorDestino), "cursor_4c_ParOperacao")

            loc_cSQL = "SELECT ISNULL(d.identpro, 0) AS identpro,"
            loc_cSQL = loc_cSQL + " ISNULL(o.opcrs, 0) AS opcrs"
            loc_cSQL = loc_cSQL + " FROM SigCdOpe o"
            loc_cSQL = loc_cSQL + " LEFT JOIN SigOpCdd d ON d.dopes = o.dopes"
            loc_cSQL = loc_cSQL + " WHERE o.dopes = " + EscaparSQL(LEFT(TratarNulo(par_cDopes, "C"), 20))

            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResult < 0
                MsgErro("Erro ao carregar os par" + CHR(226) + "metros da opera" + CHR(231) + ;
                    CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + ;
                CHR(13) + "Procedure: " + loException.Procedure, ;
                "Erro em sigmvitnBO.CarregarParametrosOperacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
