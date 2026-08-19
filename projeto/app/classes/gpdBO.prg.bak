* gpdBO.prg - Business Object para Cadastro de Grupo de Produto
* Tabela: SigCdGrp | PK: cgrus

DEFINE CLASS gpdBO AS BusinessBase

    *-- Identificacao principal
    this_cCgrus               = ""   && cgrus char(3) - PK
    this_cDgrus               = ""   && dgrus char(20)
    this_cMercs               = ""   && mercs char(3)
    this_cIdecpros            = ""   && idecpros char(2)
    this_cCodcols             = ""   && codcols char(1)
    this_nCodprods            = 0    && codprods numeric(2,0)
    this_lDiggprs             = .F.  && diggprs numeric(1,0)
    this_nIds                 = 0    && ids numeric(10,0)
    this_cCgrus2              = ""   && cgrus2 char(3)
    this_dDatatrans           = {}   && datatrans datetime NULL

    *-- Movimento / Contabil
    this_cConcmvs             = ""   && concmvs char(10)
    this_cGrucmvs             = ""   && grucmvs char(10)
    this_cConestps            = ""   && conestps char(10)
    this_cGruestps            = ""   && gruestps char(10)
    this_cContabxps           = ""   && contabxps char(10)
    this_cGrupobxps           = ""   && grupobxps char(10)
    this_cGrctobccs           = ""   && grctobccs char(21)
    this_cGrufins             = ""   && grufins char(10)
    this_lGeratubs            = .F.  && geratubs numeric(1,0)

    *-- Estoque
    this_lCestoqs             = .F.  && cestoqs numeric(1,0)
    this_lTipestos            = .F.  && tipestos numeric(1,0)
    this_lInvents             = .F.  && invents numeric(1,0)
    this_lCalcsalds           = .F.  && calcsalds numeric(1,0)
    this_lTpmovs              = .F.  && tpmovs numeric(1,0)
    this_lPesoms              = .F.  && pesoms numeric(1,0)
    this_lBpesos              = .F.  && bpesos numeric(1,0)
    this_lPesos               = .F.  && pesos numeric(1,0)
    this_nMontagrds           = 0    && montagrds numeric(2,0)
    this_lAvalests            = .F.  && avalests numeric(1,0)
    this_lAvalest2gs          = .F.  && avalest2gs numeric(1,0)
    this_lAvalest2s           = .F.  && avalest2s numeric(1,0)
    this_lAvalestigs          = .F.  && avalestigs numeric(1,0)
    this_lAvalestis           = .F.  && avalestis numeric(1,0)
    this_lAvalestngs          = .F.  && avalestngs numeric(1,0)
    this_cUnificas            = ""   && unificas char(3)

    *-- Config produto / Tipo
    this_lCores               = .F.  && cores numeric(1,0)
    this_lTams                = .F.  && tams numeric(1,0)
    this_lEmbs                = .F.  && embs numeric(1,0)
    this_lServicos            = .F.  && servicos numeric(1,0)
    this_lSemiacabs           = .F.  && semiacabs numeric(1,0)
    this_nMtprimas            = 0    && mtprimas numeric(1,0) - 1=Prim, 2=Sec, 3=Acab, 4=Matriz
    this_lEntregas            = .F.  && entregas numeric(1,0)
    this_lFornecs             = .F.  && fornecs numeric(1,0)
    this_lCaracteris          = .F.  && caracteris numeric(1,0)
    this_lEtidups             = .F.  && etidups numeric(1,0)
    this_cCodservs            = ""   && codservs char(4)
    this_lAtucomps            = .F.  && atucomps numeric(1,0)
    this_lRepauts             = .F.  && repauts numeric(1,0)
    this_lMontagens           = .F.  && montagens numeric(1,0)
    this_lNtipjoals           = .F.  && ntipjoals numeric(1,0)
    this_cBases               = ""   && bases char(1)
    this_cEtipads             = ""   && etipads char(1)
    this_cDcats               = ""   && dcats char(15)
    this_cCunips              = ""   && cunips char(3)

    *-- Composicao / Codificacao
    this_cCompos              = ""   && compos char(30)
    this_nDigimaxs            = 0    && digimaxs numeric(2,0)
    this_nOrdcompos           = 0    && ordcompos numeric(2,0)
    this_nCasas               = 0    && casas numeric(2,0)
    this_lMontadescs          = .F.  && montadescs numeric(1,0)
    this_lMkpobrigs           = .F.  && mkpobrigs numeric(1,0)
    this_lMncompos            = .F.  && mncompos numeric(1,0)
    this_lPvcompos            = .F.  && pvcompos numeric(1,0)
    this_lRetiras             = .F.  && retiras numeric(1,0)
    this_lTraduz              = .F.  && traduz numeric(1,0)
    this_lChkforcomp          = .F.  && chkforcomp numeric(1,0)
    this_lFtecsubs            = .F.  && ftecsubs numeric(1,0)
    this_mMfictecs            = ""   && mfictecs text NULL
    this_lLocalobrig          = .F.  && localobrig numeric(1,0)

    *-- Campos obrigatorios (obr*)
    this_lObrigfiscs          = .F.  && obrigfiscs numeric(1,0)
    this_lNchkdims            = .F.  && nchkdims numeric(1,0)
    this_lNchkimps            = .F.  && nchkimps numeric(1,0)
    this_lNchkpess            = .F.  && nchkpess numeric(1,0)
    this_lNchktems            = .F.  && nchktems numeric(1,0)
    this_lNfixfigs            = .F.  && nfixfigs numeric(1,0)
    this_lNchkcerts           = .F.  && nchkcerts numeric(1,0)
    this_lNgenerics           = .F.  && ngenerics numeric(1,0)
    this_lObrdimes            = .F.  && obrdimes numeric(1,0)
    this_lObrcclas            = .F.  && obrcclas numeric(1,0)
    this_lObrcolec            = .F.  && obrcolec numeric(1,0)
    this_lObrfinps            = .F.  && obrfinps numeric(1,0)
    this_lObridecs            = .F.  && obridecs numeric(1,0)
    this_lObrlinha            = .F.  && obrlinha numeric(1,0)
    this_lObrsgrus            = .F.  && obrsgrus numeric(1,0)
    this_lObrpesoms           = .F.  && obrpesoms numeric(1,0)
    this_lObriggrd            = .F.  && obriggrd numeric(1,0)
    this_lObrconjuts          = .F.  && obrconjuts numeric(1,0)
    this_lObrservico          = .F.  && obrservico numeric(1,0)
    this_lObrconjunts         = .F.  && obrconjunts numeric(1,0)
    this_lObrfigjpgs          = .F.  && obrfigjpgs numeric(1,0)
    this_lObrreffs            = .F.  && obrreffs numeric(1,0)
    this_lObralt              = .F.  && obralt numeric(1,0)
    this_lObrlarg             = .F.  && obrlarg numeric(1,0)
    this_lObrdiam             = .F.  && obrdiam numeric(1,0)
    this_lObrespes            = .F.  && obrespes numeric(1,0)
    this_lObrcompr            = .F.  && obrcompr numeric(1,0)

    *-- Fiscal / Tributario
    this_cClfiscals           = ""   && clfiscals char(10)
    this_cOrigmercs           = ""   && origmercs char(1)
    this_cSittricms           = ""   && sittricms char(3)
    this_cTptribs             = ""   && tptribs char(4)
    this_nIcms                = 0    && icms numeric(5,2)
    this_nIpifabs             = 0    && ipifabs numeric(9,2)
    this_nIpiimpors           = 0    && ipiimpors numeric(9,2)
    this_nComiss              = 0    && comiss numeric(5,2)
    this_lCjicms              = .F.  && cjicms numeric(1,0)
    this_lImpops              = .F.  && impops numeric(1,0)
    this_lImpcps              = .F.  && impcps numeric(1,0)
    this_lOmoecs              = .F.  && omoecs numeric(1,0)
    this_lOmoecusfs           = .F.  && omoecusfs numeric(1,0)
    this_lOmoedas             = .F.  && omoedas numeric(1,0)
    this_lOmoevs              = .F.  && omoevs numeric(1,0)
    this_nPctdctleis          = 0    && pctdctleis numeric(4,2)

    *-- Precos / Custos
    this_nMargens             = 0    && margens numeric(9,6)
    this_nPmargens            = 0    && pmargens numeric(9,6)
    this_nArreds              = 0    && arreds numeric(6,2)
    this_nArredcs             = 0    && arredcs numeric(6,2)
    this_nCoefs               = 0    && coefs numeric(7,4)
    this_nPcustvens           = 0    && pcustvens numeric(5,2)
    this_nCustofs             = 0    && custofs numeric(11,3)
    this_nFcustos             = 0    && fcustos numeric(7,3)
    this_nMarkupa             = 0    && markupa numeric(11,3)
    this_nPcuss               = 0    && pcuss numeric(11,3)
    this_nPremios             = 0    && premios numeric(11,4)
    this_nPvens               = 0    && pvens numeric(11,2)
    this_nPvideals            = 0    && pvideals numeric(11,2)
    this_nMarkaplics          = 0    && markaplics numeric(9,6)
    this_nPadmargens          = 0    && padmargens numeric(9,6)
    this_lAjpvens             = .F.  && ajpvens numeric(1,0)
    this_lTpcalcps            = .F.  && tpcalcps numeric(1,0)
    this_lDwvendas            = .F.  && dwvendas numeric(1,0)
    this_lSugestoas           = .F.  && sugestoas numeric(1,0)
    this_lIcustos             = .F.  && icustos numeric(1,0)
    this_lCvestims            = .F.  && cvestims numeric(1,0)
    this_lFabrproprs          = .F.  && fabrproprs numeric(1,0)
    this_lDsccompras          = .F.  && dsccompras numeric(1,0)

    *-- Moedas padrao
    this_cMoecusts            = ""   && moecusts char(3)
    this_cCmoeds              = ""   && cmoeds char(3)
    this_cMoemrkaps           = ""   && moemrkaps char(3)
    this_cPadmoecs            = ""   && padmoecs char(3)
    this_cPadmoepcs           = ""   && padmoepcs char(3)
    this_cPadmoedas           = ""   && padmoedas char(3)
    this_cPadmoevs            = ""   && padmoevs char(3)
    this_cPadmoetcs           = ""   && padmoetcs char(3)

    *-- Descricoes preco / labels configurados
    this_cDscfatuals          = ""   && dscfatuals char(15)
    this_cDscfcustos          = ""   && dscfcustos char(15)
    this_cDscfideals          = ""   && dscfideals char(15)
    this_cDscpcuss            = ""   && dscpcuss char(15)
    this_cDscpvens            = ""   && dscpvens char(15)
    this_cDscpvideals         = ""   && dscpvideals char(15)
    this_cDscpvideal          = ""   && dscpvideal char(15)

    *-- Padrao obrigatorios (pad*)
    this_cPadcclas            = ""   && padcclas char(3)
    this_cPadcolec            = ""   && padcolec char(10)
    this_cPadfinps            = ""   && padfinps char(3)
    this_cPadlinha            = ""   && padlinha char(10)
    this_cPadfase             = ""   && padfase char(10)

    *-- Conjuntos / Peso / Dimensoes
    this_lEncoms              = .F.  && encoms numeric(1,0)
    this_lMultipeso           = .F.  && multipeso numeric(1,0)
    this_lVendpeso            = .F.  && vendpeso numeric(1,0)
    this_lPesoetq             = .F.  && pesoetq numeric(1,0)
    this_nVarcustots          = 0    && varcustots numeric(5,2)
    this_nVarpesos            = 0    && varpesos numeric(5,2)
    this_nVarpesoms           = 0    && varpesoms numeric(5,2)
    this_lVldconjuts          = .F.  && vldconjuts numeric(1,0)
    this_lBlqpesun2s          = .F.  && blqpesun2s numeric(1,0)
    this_lCnjtsQtds           = .F.  && CnjtsQtds numeric(1,0)
    this_lVldvarpeso          = .F.  && vldvarpeso numeric(1,0)
    this_nDiasgar             = 0    && diasgar numeric(4,0) NULL
    this_nDiasents            = 0    && diasents numeric(3,0)
    this_lAtupretam           = .F.  && atupretam numeric(1,0)
    this_lAtucodide           = .F.  && atucodide numeric(1,0)
    this_lCodideobr           = .F.  && codideobr numeric(1,0)
    this_lLogalt              = .F.  && logalt numeric(1,0)

    *-- Local / Instalacao
    this_cLocalpdr            = ""   && localpdr char(10)
    this_lLoclivre            = .F.  && loclivre numeric(1,0)
    this_lChkinstala          = .F.  && chkinstala numeric(1,0)
    this_lChkinstalas         = .F.  && chkinstalas decimal(1,0)
    this_lChkinstal2          = .F.  && chkinstal2 numeric(1,0)

    *-- Patrimonio / Responsavel
    this_lNagmts              = .F.  && nagmts numeric(1,0)
    this_lPesmts              = .F.  && pesmts numeric(1,0)
    this_lRespcads            = .F.  && respcads numeric(1,0)
    this_lPatricustos         = .F.  && patricustos numeric(1,0)
    this_lPatrireals          = .F.  && patrireals numeric(1,0)
    this_lPatricusto          = .F.  && patricusto numeric(1,0)

    *-- Servico / Frete / Despacho
    this_lServprds            = .F.  && servprds numeric(1,0)
    this_lDespacfs            = .F.  && despacfs numeric(1,0)
    this_lDespacgs            = .F.  && despacgs numeric(1,0)
    this_lFrtsegfs            = .F.  && frtsegfs numeric(1,0)
    this_lFrtseggs            = .F.  && frtseggs numeric(1,0)
    this_lPrdrefcmp           = .F.  && prdrefcmp numeric(1,0)

    *-- Configuracao geral / Titulo
    this_cCfggergprs          = ""   && cfggergprs char(200)
    this_cTitulospro          = ""   && titulospro char(200)

    *-- Outros flags
    this_lProdmostr           = .F.  && prodmostr numeric(1,0)
    this_lExibecatlink        = .F.  && exibecatlink numeric(1,0)
    this_nSelectDescriCompra  = 0    && selectDescriCompra int
    this_lChkMultForn         = .F.  && chkMultForn numeric(1,0)

    *== PROCEDIMENTOS ==========================================================

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGrp"
        THIS.this_cCampoChave = "cgrus"
        RETURN .T.
    ENDPROC

    *== METODOS CRUD =============================================================

    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT cgrus, dgrus, mercs, idecpros FROM SigCdGrp"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY cgrus"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [" + loc_oErro.Procedure + ":" + LTRIM(STR(loc_oErro.LineNo)) + "]", "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Busca")
                TABLEREVERT(.T., "cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca")
            IF loc_nResult > 0 AND !EOF("cursor_4c_Busca")
                THIS.CarregarDoCursor("cursor_4c_Busca")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [" + loc_oErro.Procedure + ":" + LTRIM(STR(loc_oErro.LineNo)) + "]", "Erro")
        ENDTRY
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
        RETURN loc_lResultado
    ENDFUNC

    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cCgrus             = ALLTRIM(cgrus)
        THIS.this_cDgrus             = ALLTRIM(dgrus)
        THIS.this_cMercs             = ALLTRIM(mercs)
        THIS.this_cIdecpros          = ALLTRIM(idecpros)
        THIS.this_cCodcols           = ALLTRIM(codcols)
        THIS.this_nCodprods          = codprods
        THIS.this_lDiggprs           = (diggprs = 1)
        THIS.this_nIds               = ids
        THIS.this_cCgrus2            = ALLTRIM(cgrus2)
        THIS.this_dDatatrans         = datatrans
        THIS.this_cConcmvs           = ALLTRIM(concmvs)
        THIS.this_cGrucmvs           = ALLTRIM(grucmvs)
        THIS.this_cConestps          = ALLTRIM(conestps)
        THIS.this_cGruestps          = ALLTRIM(gruestps)
        THIS.this_cContabxps         = ALLTRIM(contabxps)
        THIS.this_cGrupobxps         = ALLTRIM(grupobxps)
        THIS.this_cGrctobccs         = ALLTRIM(grctobccs)
        THIS.this_cGrufins           = ALLTRIM(grufins)
        THIS.this_lGeratubs          = (geratubs = 1)
        THIS.this_lCestoqs           = (cestoqs = 1)
        THIS.this_lTipestos          = (tipestos = 1)
        THIS.this_lInvents           = (invents = 1)
        THIS.this_lCalcsalds         = (calcsalds = 1)
        THIS.this_lTpmovs            = (tpmovs = 1)
        THIS.this_lPesoms            = (pesoms = 1)
        THIS.this_lBpesos            = (bpesos = 1)
        THIS.this_lPesos             = (pesos = 1)
        THIS.this_nMontagrds         = montagrds
        THIS.this_lAvalests          = (avalests = 1)
        THIS.this_lAvalest2gs        = (avalest2gs = 1)
        THIS.this_lAvalest2s         = (avalest2s = 1)
        THIS.this_lAvalestigs        = (avalestigs = 1)
        THIS.this_lAvalestis         = (avalestis = 1)
        THIS.this_lAvalestngs        = (avalestngs = 1)
        THIS.this_cUnificas          = ALLTRIM(unificas)
        THIS.this_lCores             = (cores = 1)
        THIS.this_lTams              = (tams = 1)
        THIS.this_lEmbs              = (embs = 1)
        THIS.this_lServicos          = (servicos = 1)
        THIS.this_lSemiacabs         = (semiacabs = 1)
        THIS.this_nMtprimas          = mtprimas
        THIS.this_lEntregas          = (entregas = 1)
        THIS.this_lFornecs           = (fornecs = 1)
        THIS.this_lCaracteris        = (caracteris = 1)
        THIS.this_lEtidups           = (etidups = 1)
        THIS.this_cCodservs          = ALLTRIM(codservs)
        THIS.this_lAtucomps          = (atucomps = 1)
        THIS.this_lRepauts           = (repauts = 1)
        THIS.this_lMontagens         = (montagens = 1)
        THIS.this_lNtipjoals         = (ntipjoals = 1)
        THIS.this_cBases             = ALLTRIM(bases)
        THIS.this_cEtipads           = ALLTRIM(etipads)
        THIS.this_cDcats             = ALLTRIM(dcats)
        THIS.this_cCunips            = ALLTRIM(cunips)
        THIS.this_cCompos            = ALLTRIM(compos)
        THIS.this_nDigimaxs          = digimaxs
        THIS.this_nOrdcompos         = ordcompos
        THIS.this_nCasas             = casas
        THIS.this_lMontadescs        = (montadescs = 1)
        THIS.this_lMkpobrigs         = (mkpobrigs = 1)
        THIS.this_lMncompos          = (mncompos = 1)
        THIS.this_lPvcompos          = (pvcompos = 1)
        THIS.this_lRetiras           = (retiras = 1)
        THIS.this_lTraduz            = (traduz = 1)
        THIS.this_lChkforcomp        = (chkforcomp = 1)
        THIS.this_lFtecsubs          = (ftecsubs = 1)
        THIS.this_mMfictecs          = mfictecs
        THIS.this_lLocalobrig        = (localobrig = 1)
        THIS.this_lObrigfiscs        = (obrigfiscs = 1)
        THIS.this_lNchkdims          = (nchkdims = 1)
        THIS.this_lNchkimps          = (nchkimps = 1)
        THIS.this_lNchkpess          = (nchkpess = 1)
        THIS.this_lNchktems          = (nchktems = 1)
        THIS.this_lNfixfigs          = (nfixfigs = 1)
        THIS.this_lNchkcerts         = (nchkcerts = 1)
        THIS.this_lNgenerics         = (ngenerics = 1)
        THIS.this_lObrdimes          = (obrdimes = 1)
        THIS.this_lObrcclas          = (obrcclas = 1)
        THIS.this_lObrcolec          = (obrcolec = 1)
        THIS.this_lObrfinps          = (obrfinps = 1)
        THIS.this_lObridecs          = (obridecs = 1)
        THIS.this_lObrlinha          = (obrlinha = 1)
        THIS.this_lObrsgrus          = (obrsgrus = 1)
        THIS.this_lObrpesoms         = (obrpesoms = 1)
        THIS.this_lObriggrd          = (obriggrd = 1)
        THIS.this_lObrconjuts        = (obrconjuts = 1)
        THIS.this_lObrservico        = (obrservico = 1)
        THIS.this_lObrconjunts       = (obrconjunts = 1)
        THIS.this_lObrfigjpgs        = (obrfigjpgs = 1)
        THIS.this_lObrreffs          = (obrreffs = 1)
        THIS.this_lObralt            = (obralt = 1)
        THIS.this_lObrlarg           = (obrlarg = 1)
        THIS.this_lObrdiam           = (obrdiam = 1)
        THIS.this_lObrespes          = (obrespes = 1)
        THIS.this_lObrcompr          = (obrcompr = 1)
        THIS.this_cClfiscals         = ALLTRIM(clfiscals)
        THIS.this_cOrigmercs         = ALLTRIM(origmercs)
        THIS.this_cSittricms         = ALLTRIM(sittricms)
        THIS.this_cTptribs           = ALLTRIM(tptribs)
        THIS.this_nIcms              = icms
        THIS.this_nIpifabs           = ipifabs
        THIS.this_nIpiimpors         = ipiimpors
        THIS.this_nComiss            = comiss
        THIS.this_lCjicms            = (cjicms = 1)
        THIS.this_lImpops            = (impops = 1)
        THIS.this_lImpcps            = (impcps = 1)
        THIS.this_lOmoecs            = (omoecs = 1)
        THIS.this_lOmoecusfs         = (omoecusfs = 1)
        THIS.this_lOmoedas           = (omoedas = 1)
        THIS.this_lOmoevs            = (omoevs = 1)
        THIS.this_nPctdctleis        = pctdctleis
        THIS.this_nMargens           = margens
        THIS.this_nPmargens          = pmargens
        THIS.this_nArreds            = arreds
        THIS.this_nArredcs           = arredcs
        THIS.this_nCoefs             = coefs
        THIS.this_nPcustvens         = pcustvens
        THIS.this_nCustofs           = custofs
        THIS.this_nFcustos           = fcustos
        THIS.this_nMarkupa           = markupa
        THIS.this_nPcuss             = pcuss
        THIS.this_nPremios           = premios
        THIS.this_nPvens             = pvens
        THIS.this_nPvideals          = pvideals
        THIS.this_nMarkaplics        = markaplics
        THIS.this_nPadmargens        = padmargens
        THIS.this_lAjpvens           = (ajpvens = 1)
        THIS.this_lTpcalcps          = (tpcalcps = 1)
        THIS.this_lDwvendas          = (dwvendas = 1)
        THIS.this_lSugestoas         = (sugestoas = 1)
        THIS.this_lIcustos           = (icustos = 1)
        THIS.this_lCvestims          = (cvestims = 1)
        THIS.this_lFabrproprs        = (fabrproprs = 1)
        THIS.this_lDsccompras        = (dsccompras = 1)
        THIS.this_cMoecusts          = ALLTRIM(moecusts)
        THIS.this_cCmoeds            = ALLTRIM(cmoeds)
        THIS.this_cMoemrkaps         = ALLTRIM(moemrkaps)
        THIS.this_cPadmoecs          = ALLTRIM(padmoecs)
        THIS.this_cPadmoepcs         = ALLTRIM(padmoepcs)
        THIS.this_cPadmoedas         = ALLTRIM(padmoedas)
        THIS.this_cPadmoevs          = ALLTRIM(padmoevs)
        THIS.this_cPadmoetcs         = ALLTRIM(padmoetcs)
        THIS.this_cDscfatuals        = ALLTRIM(dscfatuals)
        THIS.this_cDscfcustos        = ALLTRIM(dscfcustos)
        THIS.this_cDscfideals        = ALLTRIM(dscfideals)
        THIS.this_cDscpcuss          = ALLTRIM(dscpcuss)
        THIS.this_cDscpvens          = ALLTRIM(dscpvens)
        THIS.this_cDscpvideals       = ALLTRIM(dscpvideals)
        THIS.this_cDscpvideal        = ALLTRIM(dscpvideal)
        THIS.this_cPadcclas          = ALLTRIM(padcclas)
        THIS.this_cPadcolec          = ALLTRIM(padcolec)
        THIS.this_cPadfinps          = ALLTRIM(padfinps)
        THIS.this_cPadlinha          = ALLTRIM(padlinha)
        THIS.this_cPadfase           = ALLTRIM(padfase)
        THIS.this_lEncoms            = (encoms = 1)
        THIS.this_lMultipeso         = (multipeso = 1)
        THIS.this_lVendpeso          = (vendpeso = 1)
        THIS.this_lPesoetq           = (pesoetq = 1)
        THIS.this_nVarcustots        = varcustots
        THIS.this_nVarpesos          = varpesos
        THIS.this_nVarpesoms         = varpesoms
        THIS.this_lVldconjuts        = (vldconjuts = 1)
        THIS.this_lBlqpesun2s        = (blqpesun2s = 1)
        THIS.this_lCnjtsQtds         = (CnjtsQtds = 1)
        THIS.this_lVldvarpeso        = (vldvarpeso = 1)
        THIS.this_nDiasgar           = diasgar
        THIS.this_nDiasents          = diasents
        THIS.this_lAtupretam         = (atupretam = 1)
        THIS.this_lAtucodide         = (atucodide = 1)
        THIS.this_lCodideobr         = (codideobr = 1)
        THIS.this_lLogalt            = (logalt = 1)
        THIS.this_cLocalpdr          = ALLTRIM(localpdr)
        THIS.this_lLoclivre          = (loclivre = 1)
        THIS.this_lChkinstala        = (chkinstala = 1)
        THIS.this_lChkinstalas       = (chkinstalas = 1)
        THIS.this_lChkinstal2        = (chkinstal2 = 1)
        THIS.this_lNagmts            = (nagmts = 1)
        THIS.this_lPesmts            = (pesmts = 1)
        THIS.this_lRespcads          = (respcads = 1)
        THIS.this_lPatricustos       = (patricustos = 1)
        THIS.this_lPatrireals        = (patrireals = 1)
        THIS.this_lPatricusto        = (patricusto = 1)
        THIS.this_lServprds          = (servprds = 1)
        THIS.this_lDespacfs          = (despacfs = 1)
        THIS.this_lDespacgs          = (despacgs = 1)
        THIS.this_lFrtsegfs          = (frtsegfs = 1)
        THIS.this_lFrtseggs          = (frtseggs = 1)
        THIS.this_lPrdrefcmp         = (prdrefcmp = 1)
        THIS.this_cCfggergprs        = ALLTRIM(cfggergprs)
        THIS.this_cTitulospro        = ALLTRIM(titulospro)
        THIS.this_lProdmostr         = (prodmostr = 1)
        THIS.this_lExibecatlink      = (exibecatlink = 1)
        THIS.this_nSelectDescriCompra = selectDescriCompra
        THIS.this_lChkMultForn       = (chkMultForn = 1)
    ENDPROC

    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCgrus)
    ENDFUNC

    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdGrp (" + ;
                "cgrus, dgrus, mercs, idecpros, codcols, codprods, diggprs, ids, cgrus2, datatrans, " + ;
                "concmvs, grucmvs, conestps, gruestps, contabxps, grupobxps, grctobccs, grufins, geratubs, " + ;
                "cestoqs, tipestos, invents, calcsalds, tpmovs, pesoms, bpesos, pesos, montagrds, " + ;
                "avalests, avalest2gs, avalest2s, avalestigs, avalestis, avalestngs, unificas, " + ;
                "cores, tams, embs, servicos, semiacabs, mtprimas, entregas, fornecs, caracteris, etidups, " + ;
                "codservs, atucomps, repauts, montagens, ntipjoals, bases, etipads, dcats, cunips, " + ;
                "compos, digimaxs, ordcompos, casas, montadescs, mkpobrigs, mncompos, pvcompos, " + ;
                "retiras, traduz, chkforcomp, ftecsubs, mfictecs, localobrig, " + ;
                "obrigfiscs, nchkdims, nchkimps, nchkpess, nchktems, nfixfigs, nchkcerts, ngenerics, " + ;
                "obrdimes, obrcclas, obrcolec, obrfinps, obridecs, obrlinha, obrsgrus, obrpesoms, " + ;
                "obriggrd, obrconjuts, obrservico, obrconjunts, obrfigjpgs, obrreffs, " + ;
                "obralt, obrlarg, obrdiam, obrespes, obrcompr, " + ;
                "clfiscals, origmercs, sittricms, tptribs, icms, ipifabs, ipiimpors, comiss, " + ;
                "cjicms, impops, impcps, omoecs, omoecusfs, omoedas, omoevs, pctdctleis, " + ;
                "margens, pmargens, arreds, arredcs, coefs, pcustvens, custofs, fcustos, markupa, pcuss, " + ;
                "premios, pvens, pvideals, markaplics, padmargens, " + ;
                "ajpvens, tpcalcps, dwvendas, sugestoas, icustos, cvestims, fabrproprs, dsccompras, " + ;
                "moecusts, cmoeds, moemrkaps, padmoecs, padmoepcs, padmoedas, padmoevs, padmoetcs, " + ;
                "dscfatuals, dscfcustos, dscfideals, dscpcuss, dscpvens, dscpvideals, dscpvideal, " + ;
                "padcclas, padcolec, padfinps, padlinha, padfase, " + ;
                "encoms, multipeso, vendpeso, pesoetq, varcustots, varpesos, varpesoms, " + ;
                "vldconjuts, blqpesun2s, CnjtsQtds, vldvarpeso, diasgar, diasents, " + ;
                "atupretam, atucodide, codideobr, logalt, " + ;
                "localpdr, loclivre, chkinstala, chkinstalas, chkinstal2, " + ;
                "nagmts, pesmts, respcads, patricustos, patrireals, patricusto, " + ;
                "servprds, despacfs, despacgs, frtsegfs, frtseggs, prdrefcmp, " + ;
                "cfggergprs, titulospro, " + ;
                "prodmostr, exibecatlink, selectDescriCompra, chkMultForn) VALUES ("
            *-- Erro104: linha logica acima >8192 chars quando concatenada com VALUES -
            *-- quebrar via reassign para nao estourar limite do compilador VFP9.
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCgrus) + ", " + EscaparSQL(THIS.this_cDgrus) + ", " + ;
                EscaparSQL(THIS.this_cMercs) + ", " + EscaparSQL(THIS.this_cIdecpros) + ", " + ;
                EscaparSQL(THIS.this_cCodcols) + ", " + FormatarNumeroSQL(THIS.this_nCodprods) + ", " + ;
                STR(IIF(THIS.this_lDiggprs,1,0),1) + ", " + FormatarNumeroSQL(THIS.this_nIds) + ", " + ;
                EscaparSQL(THIS.this_cCgrus2) + ", GETDATE(), " + ;
                EscaparSQL(THIS.this_cConcmvs) + ", " + EscaparSQL(THIS.this_cGrucmvs) + ", " + ;
                EscaparSQL(THIS.this_cConestps) + ", " + EscaparSQL(THIS.this_cGruestps) + ", " + ;
                EscaparSQL(THIS.this_cContabxps) + ", " + EscaparSQL(THIS.this_cGrupobxps) + ", " + ;
                EscaparSQL(THIS.this_cGrctobccs) + ", " + EscaparSQL(THIS.this_cGrufins) + ", " + ;
                STR(IIF(THIS.this_lGeratubs,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lCestoqs,1,0),1) + ", " + STR(IIF(THIS.this_lTipestos,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lInvents,1,0),1) + ", " + STR(IIF(THIS.this_lCalcsalds,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lTpmovs,1,0),1) + ", " + STR(IIF(THIS.this_lPesoms,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lBpesos,1,0),1) + ", " + STR(IIF(THIS.this_lPesos,1,0),1) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMontagrds) + ", " + ;
                STR(IIF(THIS.this_lAvalests,1,0),1) + ", " + STR(IIF(THIS.this_lAvalest2gs,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lAvalest2s,1,0),1) + ", " + STR(IIF(THIS.this_lAvalestigs,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lAvalestis,1,0),1) + ", " + STR(IIF(THIS.this_lAvalestngs,1,0),1) + ", " + ;
                EscaparSQL(THIS.this_cUnificas) + ", " + ;
                STR(IIF(THIS.this_lCores,1,0),1) + ", " + STR(IIF(THIS.this_lTams,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lEmbs,1,0),1) + ", " + STR(IIF(THIS.this_lServicos,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lSemiacabs,1,0),1) + ", " + STR(THIS.this_nMtprimas, 1) + ", " + ;
                STR(IIF(THIS.this_lEntregas,1,0),1) + ", " + STR(IIF(THIS.this_lFornecs,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lCaracteris,1,0),1) + ", " + STR(IIF(THIS.this_lEtidups,1,0),1) + ", " + ;
                EscaparSQL(THIS.this_cCodservs) + ", " + STR(IIF(THIS.this_lAtucomps,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lRepauts,1,0),1) + ", " + STR(IIF(THIS.this_lMontagens,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lNtipjoals,1,0),1) + ", " + EscaparSQL(THIS.this_cBases) + ", " + ;
                EscaparSQL(THIS.this_cEtipads) + ", " + EscaparSQL(THIS.this_cDcats) + ", " + ;
                EscaparSQL(THIS.this_cCunips) + ", " + ;
                EscaparSQL(THIS.this_cCompos) + ", " + FormatarNumeroSQL(THIS.this_nDigimaxs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nOrdcompos) + ", " + FormatarNumeroSQL(THIS.this_nCasas) + ", " + ;
                STR(IIF(THIS.this_lMontadescs,1,0),1) + ", " + STR(IIF(THIS.this_lMkpobrigs,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lMncompos,1,0),1) + ", " + STR(IIF(THIS.this_lPvcompos,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lRetiras,1,0),1) + ", " + STR(IIF(THIS.this_lTraduz,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lChkforcomp,1,0),1) + ", " + STR(IIF(THIS.this_lFtecsubs,1,0),1) + ", " + ;
                EscaparSQL(THIS.this_mMfictecs) + ", " + STR(IIF(THIS.this_lLocalobrig,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lObrigfiscs,1,0),1) + ", " + STR(IIF(THIS.this_lNchkdims,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lNchkimps,1,0),1) + ", " + STR(IIF(THIS.this_lNchkpess,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lNchktems,1,0),1) + ", " + STR(IIF(THIS.this_lNfixfigs,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lNchkcerts,1,0),1) + ", " + STR(IIF(THIS.this_lNgenerics,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lObrdimes,1,0),1) + ", " + STR(IIF(THIS.this_lObrcclas,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lObrcolec,1,0),1) + ", " + STR(IIF(THIS.this_lObrfinps,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lObridecs,1,0),1) + ", " + STR(IIF(THIS.this_lObrlinha,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lObrsgrus,1,0),1) + ", " + STR(IIF(THIS.this_lObrpesoms,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lObriggrd,1,0),1) + ", " + STR(IIF(THIS.this_lObrconjuts,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lObrservico,1,0),1) + ", " + STR(IIF(THIS.this_lObrconjunts,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lObrfigjpgs,1,0),1) + ", " + STR(IIF(THIS.this_lObrreffs,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lObralt,1,0),1) + ", " + STR(IIF(THIS.this_lObrlarg,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lObrdiam,1,0),1) + ", " + STR(IIF(THIS.this_lObrespes,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lObrcompr,1,0),1) + ", "
            *-- Erro104: partir SQL para respeitar limite de 8192 chars por linha logica.
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cClfiscals) + ", " + EscaparSQL(THIS.this_cOrigmercs) + ", " + ;
                EscaparSQL(THIS.this_cSittricms) + ", " + EscaparSQL(THIS.this_cTptribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcms) + ", " + FormatarNumeroSQL(THIS.this_nIpifabs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIpiimpors) + ", " + FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                STR(IIF(THIS.this_lCjicms,1,0),1) + ", " + STR(IIF(THIS.this_lImpops,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lImpcps,1,0),1) + ", " + STR(IIF(THIS.this_lOmoecs,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lOmoecusfs,1,0),1) + ", " + STR(IIF(THIS.this_lOmoedas,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lOmoevs,1,0),1) + ", " + FormatarNumeroSQL(THIS.this_nPctdctleis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMargens) + ", " + FormatarNumeroSQL(THIS.this_nPmargens) + ", " + ;
                FormatarNumeroSQL(THIS.this_nArreds) + ", " + FormatarNumeroSQL(THIS.this_nArredcs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCoefs) + ", " + FormatarNumeroSQL(THIS.this_nPcustvens) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCustofs) + ", " + FormatarNumeroSQL(THIS.this_nFcustos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMarkupa) + ", " + FormatarNumeroSQL(THIS.this_nPcuss) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPremios) + ", " + FormatarNumeroSQL(THIS.this_nPvens) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPvideals) + ", " + FormatarNumeroSQL(THIS.this_nMarkaplics) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPadmargens) + ", " + ;
                STR(IIF(THIS.this_lAjpvens,1,0),1) + ", " + STR(IIF(THIS.this_lTpcalcps,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lDwvendas,1,0),1) + ", " + STR(IIF(THIS.this_lSugestoas,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lIcustos,1,0),1) + ", " + STR(IIF(THIS.this_lCvestims,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lFabrproprs,1,0),1) + ", " + STR(IIF(THIS.this_lDsccompras,1,0),1) + ", " + ;
                EscaparSQL(THIS.this_cMoecusts) + ", " + EscaparSQL(THIS.this_cCmoeds) + ", " + ;
                EscaparSQL(THIS.this_cMoemrkaps) + ", " + EscaparSQL(THIS.this_cPadmoecs) + ", " + ;
                EscaparSQL(THIS.this_cPadmoepcs) + ", " + EscaparSQL(THIS.this_cPadmoedas) + ", " + ;
                EscaparSQL(THIS.this_cPadmoevs) + ", " + EscaparSQL(THIS.this_cPadmoetcs) + ", " + ;
                EscaparSQL(THIS.this_cDscfatuals) + ", " + EscaparSQL(THIS.this_cDscfcustos) + ", " + ;
                EscaparSQL(THIS.this_cDscfideals) + ", " + EscaparSQL(THIS.this_cDscpcuss) + ", " + ;
                EscaparSQL(THIS.this_cDscpvens) + ", " + EscaparSQL(THIS.this_cDscpvideals) + ", " + ;
                EscaparSQL(THIS.this_cDscpvideal) + ", " + ;
                EscaparSQL(THIS.this_cPadcclas) + ", " + EscaparSQL(THIS.this_cPadcolec) + ", " + ;
                EscaparSQL(THIS.this_cPadfinps) + ", " + EscaparSQL(THIS.this_cPadlinha) + ", " + ;
                EscaparSQL(THIS.this_cPadfase) + ", " + ;
                STR(IIF(THIS.this_lEncoms,1,0),1) + ", " + STR(IIF(THIS.this_lMultipeso,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lVendpeso,1,0),1) + ", " + STR(IIF(THIS.this_lPesoetq,1,0),1) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVarcustots) + ", " + FormatarNumeroSQL(THIS.this_nVarpesos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nVarpesoms) + ", " + ;
                STR(IIF(THIS.this_lVldconjuts,1,0),1) + ", " + STR(IIF(THIS.this_lBlqpesun2s,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lCnjtsQtds,1,0),1) + ", " + STR(IIF(THIS.this_lVldvarpeso,1,0),1) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDiasgar) + ", " + FormatarNumeroSQL(THIS.this_nDiasents) + ", " + ;
                STR(IIF(THIS.this_lAtupretam,1,0),1) + ", " + STR(IIF(THIS.this_lAtucodide,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lCodideobr,1,0),1) + ", " + STR(IIF(THIS.this_lLogalt,1,0),1) + ", " + ;
                EscaparSQL(THIS.this_cLocalpdr) + ", " + STR(IIF(THIS.this_lLoclivre,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lChkinstala,1,0),1) + ", " + STR(IIF(THIS.this_lChkinstalas,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lChkinstal2,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lNagmts,1,0),1) + ", " + STR(IIF(THIS.this_lPesmts,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lRespcads,1,0),1) + ", " + STR(IIF(THIS.this_lPatricustos,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lPatrireals,1,0),1) + ", " + STR(IIF(THIS.this_lPatricusto,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lServprds,1,0),1) + ", " + STR(IIF(THIS.this_lDespacfs,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lDespacgs,1,0),1) + ", " + STR(IIF(THIS.this_lFrtsegfs,1,0),1) + ", " + ;
                STR(IIF(THIS.this_lFrtseggs,1,0),1) + ", " + STR(IIF(THIS.this_lPrdrefcmp,1,0),1) + ", " + ;
                EscaparSQL(THIS.this_cCfggergprs) + ", " + EscaparSQL(THIS.this_cTitulospro) + ", " + ;
                STR(IIF(THIS.this_lProdmostr,1,0),1) + ", " + STR(IIF(THIS.this_lExibecatlink,1,0),1) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSelectDescriCompra) + ", " + ;
                STR(IIF(THIS.this_lChkMultForn,1,0),1) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir grupo de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [" + loc_oErro.Procedure + ":" + LTRIM(STR(loc_oErro.LineNo)) + "]", "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SigCdGrp SET " + ;
                "dgrus = " + EscaparSQL(THIS.this_cDgrus) + ", " + ;
                "mercs = " + EscaparSQL(THIS.this_cMercs) + ", " + ;
                "idecpros = " + EscaparSQL(THIS.this_cIdecpros) + ", " + ;
                "codcols = " + EscaparSQL(THIS.this_cCodcols) + ", " + ;
                "codprods = " + FormatarNumeroSQL(THIS.this_nCodprods) + ", " + ;
                "diggprs = " + STR(IIF(THIS.this_lDiggprs,1,0),1) + ", " + ;
                "ids = " + FormatarNumeroSQL(THIS.this_nIds) + ", " + ;
                "cgrus2 = " + EscaparSQL(THIS.this_cCgrus2) + ", " + ;
                "concmvs = " + EscaparSQL(THIS.this_cConcmvs) + ", " + ;
                "grucmvs = " + EscaparSQL(THIS.this_cGrucmvs) + ", " + ;
                "conestps = " + EscaparSQL(THIS.this_cConestps) + ", " + ;
                "gruestps = " + EscaparSQL(THIS.this_cGruestps) + ", " + ;
                "contabxps = " + EscaparSQL(THIS.this_cContabxps) + ", " + ;
                "grupobxps = " + EscaparSQL(THIS.this_cGrupobxps) + ", " + ;
                "grctobccs = " + EscaparSQL(THIS.this_cGrctobccs) + ", " + ;
                "grufins = " + EscaparSQL(THIS.this_cGrufins) + ", " + ;
                "geratubs = " + STR(IIF(THIS.this_lGeratubs,1,0),1) + ", " + ;
                "cestoqs = " + STR(IIF(THIS.this_lCestoqs,1,0),1) + ", " + ;
                "tipestos = " + STR(IIF(THIS.this_lTipestos,1,0),1) + ", " + ;
                "invents = " + STR(IIF(THIS.this_lInvents,1,0),1) + ", " + ;
                "calcsalds = " + STR(IIF(THIS.this_lCalcsalds,1,0),1) + ", " + ;
                "tpmovs = " + STR(IIF(THIS.this_lTpmovs,1,0),1) + ", " + ;
                "pesoms = " + STR(IIF(THIS.this_lPesoms,1,0),1) + ", " + ;
                "bpesos = " + STR(IIF(THIS.this_lBpesos,1,0),1) + ", " + ;
                "pesos = " + STR(IIF(THIS.this_lPesos,1,0),1) + ", " + ;
                "montagrds = " + FormatarNumeroSQL(THIS.this_nMontagrds) + ", " + ;
                "avalests = " + STR(IIF(THIS.this_lAvalests,1,0),1) + ", " + ;
                "avalest2gs = " + STR(IIF(THIS.this_lAvalest2gs,1,0),1) + ", " + ;
                "avalest2s = " + STR(IIF(THIS.this_lAvalest2s,1,0),1) + ", " + ;
                "avalestigs = " + STR(IIF(THIS.this_lAvalestigs,1,0),1) + ", " + ;
                "avalestis = " + STR(IIF(THIS.this_lAvalestis,1,0),1) + ", " + ;
                "avalestngs = " + STR(IIF(THIS.this_lAvalestngs,1,0),1) + ", " + ;
                "unificas = " + EscaparSQL(THIS.this_cUnificas) + ", " + ;
                "cores = " + STR(IIF(THIS.this_lCores,1,0),1) + ", " + ;
                "tams = " + STR(IIF(THIS.this_lTams,1,0),1) + ", " + ;
                "embs = " + STR(IIF(THIS.this_lEmbs,1,0),1) + ", " + ;
                "servicos = " + STR(IIF(THIS.this_lServicos,1,0),1) + ", " + ;
                "semiacabs = " + STR(IIF(THIS.this_lSemiacabs,1,0),1) + ", " + ;
                "mtprimas = " + STR(THIS.this_nMtprimas, 1) + ", " + ;
                "entregas = " + STR(IIF(THIS.this_lEntregas,1,0),1) + ", " + ;
                "fornecs = " + STR(IIF(THIS.this_lFornecs,1,0),1) + ", " + ;
                "caracteris = " + STR(IIF(THIS.this_lCaracteris,1,0),1) + ", " + ;
                "etidups = " + STR(IIF(THIS.this_lEtidups,1,0),1) + ", " + ;
                "codservs = " + EscaparSQL(THIS.this_cCodservs) + ", " + ;
                "atucomps = " + STR(IIF(THIS.this_lAtucomps,1,0),1) + ", " + ;
                "repauts = " + STR(IIF(THIS.this_lRepauts,1,0),1) + ", " + ;
                "montagens = " + STR(IIF(THIS.this_lMontagens,1,0),1) + ", " + ;
                "ntipjoals = " + STR(IIF(THIS.this_lNtipjoals,1,0),1) + ", " + ;
                "bases = " + EscaparSQL(THIS.this_cBases) + ", " + ;
                "etipads = " + EscaparSQL(THIS.this_cEtipads) + ", " + ;
                "dcats = " + EscaparSQL(THIS.this_cDcats) + ", " + ;
                "cunips = " + EscaparSQL(THIS.this_cCunips) + ", " + ;
                "compos = " + EscaparSQL(THIS.this_cCompos) + ", " + ;
                "digimaxs = " + FormatarNumeroSQL(THIS.this_nDigimaxs) + ", " + ;
                "ordcompos = " + FormatarNumeroSQL(THIS.this_nOrdcompos) + ", " + ;
                "casas = " + FormatarNumeroSQL(THIS.this_nCasas) + ", " + ;
                "montadescs = " + STR(IIF(THIS.this_lMontadescs,1,0),1) + ", " + ;
                "mkpobrigs = " + STR(IIF(THIS.this_lMkpobrigs,1,0),1) + ", " + ;
                "mncompos = " + STR(IIF(THIS.this_lMncompos,1,0),1) + ", " + ;
                "pvcompos = " + STR(IIF(THIS.this_lPvcompos,1,0),1) + ", " + ;
                "retiras = " + STR(IIF(THIS.this_lRetiras,1,0),1) + ", " + ;
                "traduz = " + STR(IIF(THIS.this_lTraduz,1,0),1) + ", " + ;
                "chkforcomp = " + STR(IIF(THIS.this_lChkforcomp,1,0),1) + ", " + ;
                "ftecsubs = " + STR(IIF(THIS.this_lFtecsubs,1,0),1) + ", " + ;
                "mfictecs = " + EscaparSQL(THIS.this_mMfictecs) + ", " + ;
                "localobrig = " + STR(IIF(THIS.this_lLocalobrig,1,0),1) + ", " + ;
                "obrigfiscs = " + STR(IIF(THIS.this_lObrigfiscs,1,0),1) + ", " + ;
                "nchkdims = " + STR(IIF(THIS.this_lNchkdims,1,0),1) + ", " + ;
                "nchkimps = " + STR(IIF(THIS.this_lNchkimps,1,0),1) + ", " + ;
                "nchkpess = " + STR(IIF(THIS.this_lNchkpess,1,0),1) + ", " + ;
                "nchktems = " + STR(IIF(THIS.this_lNchktems,1,0),1) + ", " + ;
                "nfixfigs = " + STR(IIF(THIS.this_lNfixfigs,1,0),1) + ", " + ;
                "nchkcerts = " + STR(IIF(THIS.this_lNchkcerts,1,0),1) + ", " + ;
                "ngenerics = " + STR(IIF(THIS.this_lNgenerics,1,0),1) + ", " + ;
                "obrdimes = " + STR(IIF(THIS.this_lObrdimes,1,0),1) + ", " + ;
                "obrcclas = " + STR(IIF(THIS.this_lObrcclas,1,0),1) + ", " + ;
                "obrcolec = " + STR(IIF(THIS.this_lObrcolec,1,0),1) + ", " + ;
                "obrfinps = " + STR(IIF(THIS.this_lObrfinps,1,0),1) + ", " + ;
                "obridecs = " + STR(IIF(THIS.this_lObridecs,1,0),1) + ", " + ;
                "obrlinha = " + STR(IIF(THIS.this_lObrlinha,1,0),1) + ", " + ;
                "obrsgrus = " + STR(IIF(THIS.this_lObrsgrus,1,0),1) + ", " + ;
                "obrpesoms = " + STR(IIF(THIS.this_lObrpesoms,1,0),1) + ", " + ;
                "obriggrd = " + STR(IIF(THIS.this_lObriggrd,1,0),1) + ", " + ;
                "obrconjuts = " + STR(IIF(THIS.this_lObrconjuts,1,0),1) + ", " + ;
                "obrservico = " + STR(IIF(THIS.this_lObrservico,1,0),1) + ", " + ;
                "obrconjunts = " + STR(IIF(THIS.this_lObrconjunts,1,0),1) + ", " + ;
                "obrfigjpgs = " + STR(IIF(THIS.this_lObrfigjpgs,1,0),1) + ", " + ;
                "obrreffs = " + STR(IIF(THIS.this_lObrreffs,1,0),1) + ", " + ;
                "obralt = " + STR(IIF(THIS.this_lObralt,1,0),1) + ", " + ;
                "obrlarg = " + STR(IIF(THIS.this_lObrlarg,1,0),1) + ", " + ;
                "obrdiam = " + STR(IIF(THIS.this_lObrdiam,1,0),1) + ", " + ;
                "obrespes = " + STR(IIF(THIS.this_lObrespes,1,0),1) + ", " + ;
                "obrcompr = " + STR(IIF(THIS.this_lObrcompr,1,0),1) + ", "
            *-- Erro104: partir SQL UPDATE para respeitar limite de 8192 chars.
            loc_cSQL = loc_cSQL + ;
                "clfiscals = " + EscaparSQL(THIS.this_cClfiscals) + ", " + ;
                "origmercs = " + EscaparSQL(THIS.this_cOrigmercs) + ", " + ;
                "sittricms = " + EscaparSQL(THIS.this_cSittricms) + ", " + ;
                "tptribs = " + EscaparSQL(THIS.this_cTptribs) + ", " + ;
                "icms = " + FormatarNumeroSQL(THIS.this_nIcms) + ", " + ;
                "ipifabs = " + FormatarNumeroSQL(THIS.this_nIpifabs) + ", " + ;
                "ipiimpors = " + FormatarNumeroSQL(THIS.this_nIpiimpors) + ", " + ;
                "comiss = " + FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                "cjicms = " + STR(IIF(THIS.this_lCjicms,1,0),1) + ", " + ;
                "impops = " + STR(IIF(THIS.this_lImpops,1,0),1) + ", " + ;
                "impcps = " + STR(IIF(THIS.this_lImpcps,1,0),1) + ", " + ;
                "omoecs = " + STR(IIF(THIS.this_lOmoecs,1,0),1) + ", " + ;
                "omoecusfs = " + STR(IIF(THIS.this_lOmoecusfs,1,0),1) + ", " + ;
                "omoedas = " + STR(IIF(THIS.this_lOmoedas,1,0),1) + ", " + ;
                "omoevs = " + STR(IIF(THIS.this_lOmoevs,1,0),1) + ", " + ;
                "pctdctleis = " + FormatarNumeroSQL(THIS.this_nPctdctleis) + ", " + ;
                "margens = " + FormatarNumeroSQL(THIS.this_nMargens) + ", " + ;
                "pmargens = " + FormatarNumeroSQL(THIS.this_nPmargens) + ", " + ;
                "arreds = " + FormatarNumeroSQL(THIS.this_nArreds) + ", " + ;
                "arredcs = " + FormatarNumeroSQL(THIS.this_nArredcs) + ", " + ;
                "coefs = " + FormatarNumeroSQL(THIS.this_nCoefs) + ", " + ;
                "pcustvens = " + FormatarNumeroSQL(THIS.this_nPcustvens) + ", " + ;
                "custofs = " + FormatarNumeroSQL(THIS.this_nCustofs) + ", " + ;
                "fcustos = " + FormatarNumeroSQL(THIS.this_nFcustos) + ", " + ;
                "markupa = " + FormatarNumeroSQL(THIS.this_nMarkupa) + ", " + ;
                "pcuss = " + FormatarNumeroSQL(THIS.this_nPcuss) + ", " + ;
                "premios = " + FormatarNumeroSQL(THIS.this_nPremios) + ", " + ;
                "pvens = " + FormatarNumeroSQL(THIS.this_nPvens) + ", " + ;
                "pvideals = " + FormatarNumeroSQL(THIS.this_nPvideals) + ", " + ;
                "markaplics = " + FormatarNumeroSQL(THIS.this_nMarkaplics) + ", " + ;
                "padmargens = " + FormatarNumeroSQL(THIS.this_nPadmargens) + ", " + ;
                "ajpvens = " + STR(IIF(THIS.this_lAjpvens,1,0),1) + ", " + ;
                "tpcalcps = " + STR(IIF(THIS.this_lTpcalcps,1,0),1) + ", " + ;
                "dwvendas = " + STR(IIF(THIS.this_lDwvendas,1,0),1) + ", " + ;
                "sugestoas = " + STR(IIF(THIS.this_lSugestoas,1,0),1) + ", " + ;
                "icustos = " + STR(IIF(THIS.this_lIcustos,1,0),1) + ", " + ;
                "cvestims = " + STR(IIF(THIS.this_lCvestims,1,0),1) + ", " + ;
                "fabrproprs = " + STR(IIF(THIS.this_lFabrproprs,1,0),1) + ", " + ;
                "dsccompras = " + STR(IIF(THIS.this_lDsccompras,1,0),1) + ", " + ;
                "moecusts = " + EscaparSQL(THIS.this_cMoecusts) + ", " + ;
                "cmoeds = " + EscaparSQL(THIS.this_cCmoeds) + ", " + ;
                "moemrkaps = " + EscaparSQL(THIS.this_cMoemrkaps) + ", " + ;
                "padmoecs = " + EscaparSQL(THIS.this_cPadmoecs) + ", " + ;
                "padmoepcs = " + EscaparSQL(THIS.this_cPadmoepcs) + ", " + ;
                "padmoedas = " + EscaparSQL(THIS.this_cPadmoedas) + ", " + ;
                "padmoevs = " + EscaparSQL(THIS.this_cPadmoevs) + ", " + ;
                "padmoetcs = " + EscaparSQL(THIS.this_cPadmoetcs) + ", " + ;
                "dscfatuals = " + EscaparSQL(THIS.this_cDscfatuals) + ", " + ;
                "dscfcustos = " + EscaparSQL(THIS.this_cDscfcustos) + ", " + ;
                "dscfideals = " + EscaparSQL(THIS.this_cDscfideals) + ", " + ;
                "dscpcuss = " + EscaparSQL(THIS.this_cDscpcuss) + ", " + ;
                "dscpvens = " + EscaparSQL(THIS.this_cDscpvens) + ", " + ;
                "dscpvideals = " + EscaparSQL(THIS.this_cDscpvideals) + ", " + ;
                "dscpvideal = " + EscaparSQL(THIS.this_cDscpvideal) + ", " + ;
                "padcclas = " + EscaparSQL(THIS.this_cPadcclas) + ", " + ;
                "padcolec = " + EscaparSQL(THIS.this_cPadcolec) + ", " + ;
                "padfinps = " + EscaparSQL(THIS.this_cPadfinps) + ", " + ;
                "padlinha = " + EscaparSQL(THIS.this_cPadlinha) + ", " + ;
                "padfase = " + EscaparSQL(THIS.this_cPadfase) + ", " + ;
                "encoms = " + STR(IIF(THIS.this_lEncoms,1,0),1) + ", " + ;
                "multipeso = " + STR(IIF(THIS.this_lMultipeso,1,0),1) + ", " + ;
                "vendpeso = " + STR(IIF(THIS.this_lVendpeso,1,0),1) + ", " + ;
                "pesoetq = " + STR(IIF(THIS.this_lPesoetq,1,0),1) + ", " + ;
                "varcustots = " + FormatarNumeroSQL(THIS.this_nVarcustots) + ", " + ;
                "varpesos = " + FormatarNumeroSQL(THIS.this_nVarpesos) + ", " + ;
                "varpesoms = " + FormatarNumeroSQL(THIS.this_nVarpesoms) + ", " + ;
                "vldconjuts = " + STR(IIF(THIS.this_lVldconjuts,1,0),1) + ", " + ;
                "blqpesun2s = " + STR(IIF(THIS.this_lBlqpesun2s,1,0),1) + ", " + ;
                "CnjtsQtds = " + STR(IIF(THIS.this_lCnjtsQtds,1,0),1) + ", " + ;
                "vldvarpeso = " + STR(IIF(THIS.this_lVldvarpeso,1,0),1) + ", " + ;
                "diasgar = " + FormatarNumeroSQL(THIS.this_nDiasgar) + ", " + ;
                "diasents = " + FormatarNumeroSQL(THIS.this_nDiasents) + ", " + ;
                "atupretam = " + STR(IIF(THIS.this_lAtupretam,1,0),1) + ", " + ;
                "atucodide = " + STR(IIF(THIS.this_lAtucodide,1,0),1) + ", " + ;
                "codideobr = " + STR(IIF(THIS.this_lCodideobr,1,0),1) + ", " + ;
                "logalt = " + STR(IIF(THIS.this_lLogalt,1,0),1) + ", " + ;
                "localpdr = " + EscaparSQL(THIS.this_cLocalpdr) + ", " + ;
                "loclivre = " + STR(IIF(THIS.this_lLoclivre,1,0),1) + ", " + ;
                "chkinstala = " + STR(IIF(THIS.this_lChkinstala,1,0),1) + ", " + ;
                "chkinstalas = " + STR(IIF(THIS.this_lChkinstalas,1,0),1) + ", " + ;
                "chkinstal2 = " + STR(IIF(THIS.this_lChkinstal2,1,0),1) + ", " + ;
                "nagmts = " + STR(IIF(THIS.this_lNagmts,1,0),1) + ", " + ;
                "pesmts = " + STR(IIF(THIS.this_lPesmts,1,0),1) + ", " + ;
                "respcads = " + STR(IIF(THIS.this_lRespcads,1,0),1) + ", " + ;
                "patricustos = " + STR(IIF(THIS.this_lPatricustos,1,0),1) + ", " + ;
                "patrireals = " + STR(IIF(THIS.this_lPatrireals,1,0),1) + ", " + ;
                "patricusto = " + STR(IIF(THIS.this_lPatricusto,1,0),1) + ", " + ;
                "servprds = " + STR(IIF(THIS.this_lServprds,1,0),1) + ", " + ;
                "despacfs = " + STR(IIF(THIS.this_lDespacfs,1,0),1) + ", " + ;
                "despacgs = " + STR(IIF(THIS.this_lDespacgs,1,0),1) + ", " + ;
                "frtsegfs = " + STR(IIF(THIS.this_lFrtsegfs,1,0),1) + ", " + ;
                "frtseggs = " + STR(IIF(THIS.this_lFrtseggs,1,0),1) + ", " + ;
                "prdrefcmp = " + STR(IIF(THIS.this_lPrdrefcmp,1,0),1) + ", " + ;
                "cfggergprs = " + EscaparSQL(THIS.this_cCfggergprs) + ", " + ;
                "titulospro = " + EscaparSQL(THIS.this_cTitulospro) + ", " + ;
                "prodmostr = " + STR(IIF(THIS.this_lProdmostr,1,0),1) + ", " + ;
                "exibecatlink = " + STR(IIF(THIS.this_lExibecatlink,1,0),1) + ", " + ;
                "selectDescriCompra = " + FormatarNumeroSQL(THIS.this_nSelectDescriCompra) + ", " + ;
                "chkMultForn = " + STR(IIF(THIS.this_lChkMultForn,1,0),1) + ;
                " WHERE cgrus = " + EscaparSQL(THIS.this_cCgrus)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [" + loc_oErro.Procedure + ":" + LTRIM(STR(loc_oErro.LineNo)) + "]", "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdGrp WHERE cgrus = " + EscaparSQL(THIS.this_cCgrus)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir grupo de produto.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [" + loc_oErro.Procedure + ":" + LTRIM(STR(loc_oErro.LineNo)) + "]", "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *=========================================================================
    * BuscarSubgrupos - Busca sub-grupos de um grupo pelo cgrus (SigCdPsg)
    * Cria cursor_4c_SubGrupos com (codigos, descricaos, marckupa)
    *=========================================================================
    FUNCTION BuscarSubgrupos(par_cCgrus)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        IF USED("cursor_4c_SubGrupos")
            USE IN cursor_4c_SubGrupos
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cCgrus))
                CREATE CURSOR cursor_4c_SubGrupos (codigos C(6), descricaos C(20), marckupa N(8,2))
                loc_lResultado = .T.
            ELSE
                loc_cSQL = "SELECT codigos, descricaos, marckupa FROM SigCdPsg " + ;
                    "WHERE cgrus = " + EscaparSQL(ALLTRIM(par_cCgrus)) + ;
                    " ORDER BY codigos"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_SubGrupos")
                    TABLEREVERT(.T., "cursor_4c_SubGrupos")
                    USE IN cursor_4c_SubGrupos
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubGrupos")
                IF loc_nResult > 0
                    loc_lResultado = .T.
                ELSE
                    CREATE CURSOR cursor_4c_SubGrupos (codigos C(6), descricaos C(20), marckupa N(8,2))
                    loc_lResultado = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " [" + loc_oErro.Procedure + ":" + LTRIM(STR(loc_oErro.LineNo)) + "]", "Erro")
            IF !USED("cursor_4c_SubGrupos")
                CREATE CURSOR cursor_4c_SubGrupos (codigos C(6), descricaos C(20), marckupa N(8,2))
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
