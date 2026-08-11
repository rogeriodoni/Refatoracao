SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS empBO AS BusinessBase

    *-- Identificacao
    this_cCodigo            = ""
    this_nNumero            = 0

    *-- Razao Social / Fantasia
    this_cRazaoSocial       = ""
    this_cNomeFantasia      = ""
    this_cNomeReduzido      = ""

    *-- Documentos
    this_cCgc               = ""
    this_nTipoCgc           = 0
    this_cIe                = ""
    this_cIm                = ""
    this_cCnae              = ""
    this_cEan13             = ""

    *-- Endereco
    this_cCep               = ""
    this_cPais              = ""
    this_cEndereco          = ""
    this_cNumEndereco       = ""
    this_cComplemento       = ""
    this_cBairro            = ""
    this_cCidade            = ""
    this_cEstado            = ""
    this_nFusoHorario       = 0
    this_cRegiao            = ""

    *-- Contatos
    this_cTelefone1         = ""
    this_cTelefone2         = ""
    this_cFax               = ""
    this_cEmail             = ""

    *-- Responsavel
    this_cResponsavel       = ""
    this_cCargo             = ""
    this_cPostoFiscal       = ""

    *-- Classificacao
    this_nSituacao          = 0
    this_cGrupoEmpresarial  = ""
    this_cClassificacaoEmp  = ""
    this_cGrupoCC           = ""
    this_cContaArls         = ""
    this_cContaC            = ""
    this_cCEstoque          = ""
    this_cCodEmpresa        = ""
    this_cCodRepres         = ""
    this_lEscritorio        = .F.
    this_lAnaVends          = .F.

    *-- Datas e Regime
    this_dDtCadastro        = {}
    this_dDtEncerramento    = {}
    this_dDtInicioOperacao  = {}
    this_cNumProtBx         = ""
    this_dDtProtBx          = {}
    this_nRegimeTrib        = 0

    *-- Aliquotas Page1
    this_nAliqIR            = 0
    this_nServCSLL          = 0
    this_nServPIS           = 0
    this_nServCofins        = 0
    this_nMercIR            = 0
    this_nMercCSLL          = 0
    this_nMercPIS           = 0
    this_nMercCofins        = 0
    this_nAliqCSLL          = 0
    this_nServIR            = 0
    this_nAliqSimples       = 0

    *-- De Olho (opt_mostraImp / opt_mostraPara / AliqImpAprox)
    this_nMostraImp         = 0
    this_nMostraPara        = 0
    this_nAliqImpAprox      = 0

    *-- Email Alerta (cntAlerta - Page1)
    this_cSmtpAlerta        = ""
    this_nPortaAlerta       = 0
    this_cEmailAlerta       = ""
    this_cSenhaAlerta       = ""

    *-- Page2: Impressao e Saida
    this_cImpressora        = ""
    this_cCarrAutomatico    = ""
    this_cEtiqProd          = ""
    this_cMemoBoleto        = ""
    this_cTipoOf            = ""   && coluna tiponfs
    this_nDifPeso           = 0
    this_cEstoqueCtrl       = ""   && coluna verests
    this_cPinPadLinha1      = ""
    this_cPinPadLinha2      = ""
    this_cDopInt            = ""

    *-- Page2: Comissao
    this_nOpcComis          = 0
    this_nPerComis          = 0

    *-- Page2: Invoice CBD
    this_cBanco             = ""
    this_cAgencia           = ""
    this_cConta             = ""
    this_cDac               = ""

    *-- Page2: Sitef / Bonus / Adicional
    this_cEmpSitef          = ""
    this_nPercCreds         = 0
    this_nAdicional         = 0

    *-- Page2: Transporte
    this_nTpTrans           = 0
    this_nAltTrans          = 0

    *-- Page2: Servico Saida
    this_cCodServSaida      = ""
    this_cDescServSaida     = ""

    *-- Page2: Empresa OS / Custo / Mrcf
    this_cEmpBal            = ""
    this_nCalcCustos        = 0
    this_nChkMrcfs          = 0    && coluna nChkMrcfs

    *-- Page2: SEDEX
    this_cContratoDef       = ""
    this_cAgenciaSedex      = ""
    this_cCartaoSedex       = ""

    *-- Page2: Supervisor / Distribuicao / CDL / Briefing
    this_cSupervisor        = ""
    this_cSaiCol            = ""
    this_cCdlSenha          = ""
    this_nBriefing          = 0

    *-- Page2: Email Padrao (cntEmailPad)
    this_cSmtpEmail         = ""
    this_cEmailPad          = ""
    this_cSenhaEmail        = ""
    this_nPortaEmail        = 0

    *-- Page2: E-commerce / Bloqueio / Subtempo / Imagens
    this_nEcommerce         = 0
    this_lBlqDt             = .F.
    this_nTempoSub          = 0
    this_cImagemFig         = ""
    this_cImagemFigR        = ""

    *-- Page3: CFOP / Moeda / Mrcf
    this_cCfoInt            = ""
    this_cMcTotal           = ""
    this_nMrcf              = 0

    *-- Page3: Grupos e Contas Contabeis (10 pares)
    this_cGrupoIcmsOrig     = ""
    this_cContaIcmsOrig     = ""
    this_cGrupoIcmsDeb      = ""
    this_cContaIcmsDeb      = ""
    this_cGrupoPis          = ""
    this_cContaPis          = ""
    this_cGrupoCofins       = ""
    this_cContaCofins       = ""
    this_cGrupoIpi          = ""
    this_cContaIpi          = ""
    this_cGrupoIcmsDevOrig  = ""
    this_cContaIcmsDevOrig  = ""
    this_cGrupoIcmsDevDeb   = ""
    this_cContaIcmsDevDeb   = ""
    this_cGrupoPisDev       = ""
    this_cContaPisDev       = ""
    this_cGrupoCofDev       = ""
    this_cContaCofDev       = ""
    this_cGrupoIpiDev       = ""
    this_cContaIpiDev       = ""

    *-- Page3: Outras Aliquotas e Configuracoes Fiscais
    this_nPorcCons          = 0
    this_nPorcPis           = 0
    this_nRegTribCat44      = 0
    this_cCcustos           = ""
    this_cPerfil            = ""
    this_nIndica            = 0
    this_cTipoEfd           = ""

    *-- Page3: Email NF-e
    this_cSmtpNfe           = ""
    this_cEmailNfe          = ""
    this_cSenhaNfe          = ""
    this_nPortaNfe          = 0
    this_cPastaEmail        = ""

    *-- Page3: Textos / Logo / Pastas / Regime
    this_cTextoNfe          = ""
    this_cTextoPaf          = ""
    this_cLogo              = ""
    this_cPastaFci          = ""
    this_cRegEsp            = ""
    this_cCodOper           = ""
    this_cCodSMun           = ""

    *-- Page3: Campos Ocultos
    this_cEntCol            = ""
    this_cEmpRel            = ""
    this_nOrdem             = 0

    *-- Page4: NFC-e
    this_cChaveParceiro     = ""
    this_cChaveContrib      = ""
    this_cCsc               = ""

    PROCEDURE Init
        DODEFAULT()
        THIS.this_cTabela     = "SigCdEmp"
        THIS.this_cCampoChave = "Cemps"
    ENDPROC

    FUNCTION ObterChavePrimaria
        RETURN THIS.this_cCodigo
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *===========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_oErro
        TRY
            SELECT (par_cAliasCursor)

            *-- Identificacao
            THIS.this_cCodigo           = TratarNulo(cemps,          "C")
            THIS.this_nNumero           = TratarNulo(nemps,          "N")

            *-- Razao Social / Fantasia
            THIS.this_cRazaoSocial      = TratarNulo(razsocs,        "C")
            THIS.this_cNomeFantasia     = TratarNulo(razas,          "C")
            THIS.this_cNomeReduzido     = TratarNulo(prins,          "C")

            *-- Documentos
            THIS.this_cCgc              = TratarNulo(cgcs,           "C")
            THIS.this_nTipoCgc          = TratarNulo(tpemps,         "N")
            THIS.this_cIe               = TratarNulo(ies,            "C")
            THIS.this_cIm               = TratarNulo(ims,            "C")
            THIS.this_cCnae             = TratarNulo(cnae,           "C")
            THIS.this_cEan13            = LTRIM(STR(TratarNulo(ean13, "N"), 13, 0))

            *-- Endereco
            THIS.this_cCep              = TratarNulo(ceps,           "C")
            THIS.this_cPais             = TratarNulo(paises,         "C")
            THIS.this_cEndereco         = TratarNulo(endes,          "C")
            THIS.this_cNumEndereco      = TratarNulo(numeros,        "C")
            THIS.this_cComplemento      = TratarNulo(compls,         "C")
            THIS.this_cBairro           = TratarNulo(bairs,          "C")
            THIS.this_cCidade           = TratarNulo(cidas,          "C")
            THIS.this_cEstado           = TratarNulo(estas,          "C")
            THIS.this_nFusoHorario      = TratarNulo(nfshora1s,      "N")
            THIS.this_cRegiao           = TratarNulo(regiaos,        "C")

            *-- Contatos
            THIS.this_cTelefone1        = TratarNulo(tel1s,          "C")
            THIS.this_cTelefone2        = TratarNulo(tel2s,          "C")
            THIS.this_cFax              = TratarNulo(faxs,           "C")
            THIS.this_cEmail            = TratarNulo(emails,         "C")

            *-- Responsavel
            THIS.this_cResponsavel      = TratarNulo(resp_nome,      "C")
            THIS.this_cCargo            = TratarNulo(resp_cargo,     "C")
            THIS.this_cPostoFiscal      = TratarNulo(pfiscals,       "C")

            *-- Classificacao
            THIS.this_nSituacao         = TratarNulo(ativas,         "N")
            THIS.this_cGrupoEmpresarial = TratarNulo(grupo,          "C")
            THIS.this_cClassificacaoEmp = TratarNulo(class,          "C")
            THIS.this_cGrupoCC          = TratarNulo(grufranqs,      "C")
            THIS.this_cContaArls        = TratarNulo(contarls,       "C")
            THIS.this_cContaC           = TratarNulo(confranqs,      "C")
            THIS.this_cCEstoque         = TratarNulo(cestoque,       "C")
            THIS.this_cCodEmpresa       = LTRIM(STR(TratarNulo(codemps, "N"), 4, 0))
            THIS.this_cCodRepres        = TratarNulo(codrepres,      "C")
            THIS.this_lEscritorio       = (TratarNulo(chkesc,        "N") <> 0)
            THIS.this_lAnaVends         = (TratarNulo(oficial1,      "N") <> 0)

            *-- Datas e Regime
            THIS.this_dDtCadastro       = TratarNulo(dtcadas,        "D")
            THIS.this_dDtEncerramento   = TratarNulo(dtencerras,     "D")
            THIS.this_dDtInicioOperacao = TratarNulo(dtiniops,       "D")
            THIS.this_cNumProtBx        = LTRIM(STR(TratarNulo(nnumprotbx, "N"), 8, 0))
            THIS.this_dDtProtBx         = TratarNulo(dtprotbx,       "D")
            THIS.this_nRegimeTrib       = TratarNulo(regimes,        "N")

            *-- Aliquotas Page1
            THIS.this_nAliqIR           = TratarNulo(airs,           "N")
            THIS.this_nServCSLL         = TratarNulo(scslls,         "N")
            THIS.this_nServPIS          = TratarNulo(spiss,          "N")
            THIS.this_nServCofins       = TratarNulo(scofs,          "N")
            THIS.this_nMercIR           = TratarNulo(mirs,           "N")
            THIS.this_nMercCSLL         = TratarNulo(mcslls,         "N")
            THIS.this_nMercPIS          = TratarNulo(mpiss,          "N")
            THIS.this_nMercCofins       = TratarNulo(mcofs,          "N")
            THIS.this_nAliqCSLL         = TratarNulo(acslls,         "N")
            THIS.this_nServIR           = TratarNulo(sirs,           "N")
            THIS.this_nAliqSimples      = TratarNulo(acsn,           "N")

            *-- De Olho
            THIS.this_nMostraImp        = TratarNulo(mostraim,       "N")
            THIS.this_nMostraPara       = TratarNulo(mostrapara,     "N")
            THIS.this_nAliqImpAprox     = TratarNulo(aliqia,         "N")

            *-- Email Alerta
            THIS.this_cSmtpAlerta       = TratarNulo(aleservs,       "C")
            THIS.this_nPortaAlerta      = TratarNulo(aleportas,      "N")
            THIS.this_cEmailAlerta      = TratarNulo(aleemails,      "C")
            THIS.this_cSenhaAlerta      = TratarNulo(alesenhas,      "C")

            *-- Page2: Impressao e Saida
            THIS.this_cImpressora       = TratarNulo(impcars,        "C")
            THIS.this_cCarrAutomatico   = TratarNulo(cautos,         "C")
            THIS.this_cEtiqProd         = TratarNulo(obsetiqs,       "C")
            THIS.this_cMemoBoleto       = TratarNulo(obs,            "C")
            THIS.this_cTipoOf           = LTRIM(STR(TratarNulo(tiponfs,  "N"), 1, 0))
            THIS.this_nDifPeso          = VAL(ALLTRIM(TratarNulo(difpes,  "C")))
            THIS.this_cEstoqueCtrl      = LTRIM(STR(TratarNulo(verests,  "N"), 1, 0))
            THIS.this_cPinPadLinha1     = TratarNulo(pplinha1s,      "C")
            THIS.this_cPinPadLinha2     = TratarNulo(pplinha2s,      "C")
            THIS.this_cDopInt           = TratarNulo(dope_int,       "C")

            *-- Page2: Comissao
            THIS.this_nOpcComis         = TratarNulo(comiss,         "N")
            THIS.this_nPerComis         = TratarNulo(percomis,       "N")

            *-- Page2: Invoice CBD
            THIS.this_cBanco            = TratarNulo(bancs,          "C")
            THIS.this_cAgencia          = TratarNulo(agencs,         "C")
            THIS.this_cConta            = TratarNulo(contas,         "C")
            THIS.this_cDac              = TratarNulo(emprefs,        "C")

            *-- Page2: Sitef / Bonus / Adicional
            THIS.this_cEmpSitef         = TratarNulo(cempsitefs,     "C")
            THIS.this_nPercCreds        = TratarNulo(perccrs,        "N")
            THIS.this_nAdicional        = TratarNulo(adics,          "N")

            *-- Page2: Transporte
            THIS.this_nTpTrans          = VAL(ALLTRIM(TratarNulo(tptrans, "C")))
            THIS.this_nAltTrans         = TratarNulo(nchkmrcfs,      "N")

            *-- Page2: Servico Saida
            THIS.this_cCodServSaida     = TratarNulo(codservs,       "C")
            THIS.this_cDescServSaida    = TratarNulo(descservs,      "C")

            *-- Page2: Empresa OS / Custo / Mrcf
            THIS.this_cEmpBal           = TratarNulo(empbals,        "C")
            THIS.this_nCalcCustos       = TratarNulo(calccustos,     "N")
            THIS.this_nChkMrcfs         = TratarNulo(nchkmrcfs,      "N")

            *-- Page2: SEDEX
            THIS.this_cContratoDef      = TratarNulo(nums,           "C")
            THIS.this_cAgenciaSedex     = TratarNulo(cfilas,         "C")
            THIS.this_cCartaoSedex      = TratarNulo(supervs,        "C")

            *-- Page2: Supervisor / Distribuicao / CDL / Briefing
            THIS.this_cSupervisor       = TratarNulo(supervs,        "C")
            THIS.this_cSaiCol           = TratarNulo(dircolouts,     "C")
            THIS.this_cCdlSenha         = TratarNulo(cdlsenhas,      "C")
            THIS.this_nBriefing         = TratarNulo(divnotas,       "N")

            *-- Page2: Email Padrao
            THIS.this_cSmtpEmail        = TratarNulo(padservs,       "C")
            THIS.this_cEmailPad         = TratarNulo(pademails,      "C")
            THIS.this_cSenhaEmail       = TratarNulo(padsenhas,      "C")
            THIS.this_nPortaEmail       = TratarNulo(padportas,      "N")

            *-- Page2: E-commerce / Bloqueio / Subtempo / Imagens
            THIS.this_nEcommerce        = TratarNulo(nchkecomm,      "N")
            THIS.this_lBlqDt            = (TratarNulo(blqdatas,      "N") <> 0)
            THIS.this_nTempoSub         = TratarNulo(nrlocsorts,     "N")

            *-- Page3: CFOP / Moeda / Mrcf
            THIS.this_cCfoInt           = TratarNulo(cfis_int,       "C")
            THIS.this_cMcTotal          = TratarNulo(moedas,         "C")
            THIS.this_nMrcf             = TratarNulo(nchkmrcfs,      "N")

            *-- Page3: Grupos e Contas Contabeis
            THIS.this_cGrupoIcmsOrig    = TratarNulo(gruorigs,       "C")
            THIS.this_cContaIcmsOrig    = TratarNulo(conorigs,       "C")
            THIS.this_cGrupoIcmsDeb     = TratarNulo(gruicmos,       "C")
            THIS.this_cContaIcmsDeb     = TratarNulo(conicmos,       "C")
            THIS.this_cGrupoPis         = TratarNulo(grupisos,       "C")
            THIS.this_cContaPis         = TratarNulo(conpisos,       "C")
            THIS.this_cGrupoCofins      = TratarNulo(gruconos,       "C")
            THIS.this_cContaCofins      = TratarNulo(conconos,       "C")
            THIS.this_cGrupoIpi         = TratarNulo(gruipios,       "C")
            THIS.this_cContaIpi         = TratarNulo(conipios,       "C")
            THIS.this_cGrupoIcmsDevOrig = TratarNulo(grudests,       "C")
            THIS.this_cContaIcmsDevOrig = TratarNulo(condests,       "C")
            THIS.this_cGrupoIcmsDevDeb  = TratarNulo(gruicmds,       "C")
            THIS.this_cContaIcmsDevDeb  = TratarNulo(conicmds,       "C")
            THIS.this_cGrupoPisDev      = TratarNulo(grupisds,       "C")
            THIS.this_cContaPisDev      = TratarNulo(conpisds,       "C")
            THIS.this_cGrupoCofDev      = TratarNulo(gruconds,       "C")
            THIS.this_cContaCofDev      = TratarNulo(conconds,       "C")
            THIS.this_cGrupoIpiDev      = TratarNulo(gruipids,       "C")
            THIS.this_cContaIpiDev      = TratarNulo(conipids,       "C")

            *-- Page3: Outras Aliquotas e Config Fiscais
            THIS.this_nPorcCons         = TratarNulo(porccons,       "N")
            THIS.this_nPorcPis          = TratarNulo(porcpis,        "N")
            THIS.this_nRegTribCat44     = VAL(ALLTRIM(TratarNulo(regtribs, "C")))
            THIS.this_cCcustos          = TratarNulo(ccustos,        "C")
            THIS.this_cPerfil           = TratarNulo(perfils,        "C")
            THIS.this_nIndica           = VAL(ALLTRIM(TratarNulo(indicas,  "C")))
            THIS.this_cTipoEfd          = LTRIM(STR(TratarNulo(ntpefds,  "N"), 1, 0))

            *-- Page3: Email NF-e
            THIS.this_cSmtpNfe          = TratarNulo(servs,          "C")
            THIS.this_cEmailNfe         = TratarNulo(emailnfe,       "C")
            THIS.this_cSenhaNfe         = TratarNulo(senhas,         "C")
            THIS.this_nPortaNfe         = TratarNulo(portas,         "N")
            THIS.this_cPastaEmail       = TratarNulo(pastas,         "C")

            *-- Page3: Textos / Logo / Pastas / Regime
            THIS.this_cTextoNfe         = TratarNulo(textonfe,       "C")
            THIS.this_cTextoPaf         = TratarNulo(textopaf,       "C")
            THIS.this_cLogo             = TratarNulo(logonfe,        "C")
            THIS.this_cPastaFci         = TratarNulo(pastafci,       "C")
            THIS.this_cRegEsp           = TratarNulo(empofs,         "C")
            THIS.this_cCodOper          = TratarNulo(codopers,       "C")
            THIS.this_cCodSMun          = SUBSTR(TratarNulo(dirs,    "C"), 1, 8)

            *-- Page3: Campos Ocultos
            THIS.this_cEntCol           = TratarNulo(dircolins,      "C")
            THIS.this_cEmpRel           = TratarNulo(emprels,        "C")
            THIS.this_nOrdem            = TratarNulo(ordems,         "N")

            *-- Page4: NFC-e
            THIS.this_cChaveParceiro    = TratarNulo(chavep,         "C")
            THIS.this_cChaveContrib     = TratarNulo(chavec,         "C")
            THIS.this_cCsc              = TratarNulo(csc,            "C")

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *===========================================================================
    * Buscar - Lista empresas em cursor_4c_Dados
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nRet, loc_lResultado, loc_oErro
        loc_lResultado = .T.
        TRY
            loc_cSQL = "SELECT cemps, nemps, razsocs, razas, cgcs, ativas " + ;
                       "FROM SigCdEmp "
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + "WHERE " + par_cFiltro + " "
            ENDIF
            loc_cSQL = loc_cSQL + "ORDER BY cemps"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nRet < 0
                MsgErro("Erro ao buscar empresas. " + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega empresa pelo codigo PK
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nRet, loc_lResultado, loc_oErro
        loc_lResultado = .T.
        TRY
            loc_cSQL = "SELECT * FROM SigCdEmp " + ;
                       "WHERE cemps = " + EscaparSQL(par_cCodigo)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Busca")
                TABLEREVERT(.T., "cursor_4c_Busca")
                USE IN cursor_4c_Busca
            ENDIF

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Busca")
            IF loc_nRet < 0 OR !USED("cursor_4c_Busca") OR RECCOUNT("cursor_4c_Busca") = 0
                MsgErro("Empresa n" + CHR(227) + "o encontrada.", "Erro")
                loc_lResultado = .F.
            ELSE
                THIS.CarregarDoCursor("cursor_4c_Busca")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        IF USED("cursor_4c_Busca")
            USE IN cursor_4c_Busca
        ENDIF
        RETURN loc_lResultado
    ENDFUNC

    *===========================================================================
    * Inserir - INSERT INTO SigCdEmp
    *===========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cVals, loc_nRet, loc_lResultado, loc_oErro
        loc_lResultado = .T.
        TRY

            loc_cVals = EscaparSQL(LEFT(THIS.this_cCodigo, 3)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nNumero, 0) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cRazaoSocial, 50)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cNomeFantasia, 40)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cNomeReduzido, 15)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCgc, 20)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nTipoCgc, 0) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cIe, 15)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cIm, 15)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCnae, 15)) + "," + ;
                        FormatarNumeroSQL(VAL(THIS.this_cEan13), 0) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cCep, 9)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cPais, 30)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cEndereco, 60)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cNumEndereco, 21)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cComplemento, 25)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cBairro, 40)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCidade, 30)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cEstado, 2)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nFusoHorario, 0) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cRegiao, 10)) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cTelefone1, 20)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cTelefone2, 20)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cFax, 20)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cEmail, 50)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cResponsavel, 40)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCargo, 40)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cPostoFiscal, 15)) + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nSituacao, 0) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoEmpresarial, 15)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cClassificacaoEmp, 15)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoCC, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaArls, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaC, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCEstoque, 10)) + "," + ;
                        FormatarNumeroSQL(VAL(THIS.this_cCodEmpresa), 0) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCodRepres, 4)) + "," + ;
                        FormatarNumeroSQL(IIF(THIS.this_lEscritorio, 1, 0), 0) + "," + ;
                        FormatarNumeroSQL(IIF(THIS.this_lAnaVends, 1, 0), 0) + ","

            loc_cVals = loc_cVals + ;
                        IIF(EMPTY(THIS.this_dDtCadastro),       "NULL", FormatarDataSQL(THIS.this_dDtCadastro)) + "," + ;
                        IIF(EMPTY(THIS.this_dDtEncerramento),   "NULL", FormatarDataSQL(THIS.this_dDtEncerramento)) + "," + ;
                        IIF(EMPTY(THIS.this_dDtInicioOperacao), "NULL", FormatarDataSQL(THIS.this_dDtInicioOperacao)) + "," + ;
                        FormatarNumeroSQL(VAL(THIS.this_cNumProtBx), 0) + "," + ;
                        IIF(EMPTY(THIS.this_dDtProtBx),         "NULL", FormatarDataSQL(THIS.this_dDtProtBx)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nRegimeTrib, 0) + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nAliqIR, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nServCSLL, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nServPIS, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nServCofins, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nMercIR, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nMercCSLL, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nMercPIS, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nMercCofins, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nAliqCSLL, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nServIR, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nAliqSimples, 2) + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nMostraImp, 0) + "," + ;
                        FormatarNumeroSQL(THIS.this_nMostraPara, 0) + "," + ;
                        FormatarNumeroSQL(THIS.this_nAliqImpAprox, 2) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cSmtpAlerta, 30)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nPortaAlerta, 0) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cEmailAlerta, 50)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cSenhaAlerta, 30)) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cImpressora, 1)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCarrAutomatico, 1)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cEtiqProd, 1)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cMemoBoleto, 150)) + "," + ;
                        FormatarNumeroSQL(VAL(THIS.this_cTipoOf), 0) + "," + ;
                        EscaparSQL(LEFT(LTRIM(STR(THIS.this_nDifPeso, 1, 0)), 1)) + "," + ;
                        FormatarNumeroSQL(VAL(THIS.this_cEstoqueCtrl), 0) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cPinPadLinha1, 16)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cPinPadLinha2, 16)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cDopInt, 20)) + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nOpcComis, 0) + "," + ;
                        FormatarNumeroSQL(THIS.this_nPerComis, 2) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cBanco, 4)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cAgencia, 5)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cConta, 11)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cDac, 3)) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cEmpSitef, 3)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nPercCreds, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nAdicional, 0) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(LTRIM(STR(THIS.this_nTpTrans, 6, 0)), 6)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nChkMrcfs, 0) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCodServSaida, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cDescServSaida, 40)) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cEmpBal, 3)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nCalcCustos, 0) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContratoDef, 21)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cAgenciaSedex, 8)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cSupervisor, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cSaiCol, 254)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCdlSenha, 10)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nBriefing, 0) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cSmtpEmail, 50)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cEmailPad, 50)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cSenhaEmail, 30)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nPortaEmail, 0) + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nEcommerce, 0) + "," + ;
                        FormatarNumeroSQL(IIF(THIS.this_lBlqDt, 1, 0), 0) + "," + ;
                        FormatarNumeroSQL(THIS.this_nTempoSub, 0) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cCfoInt, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cMcTotal, 3)) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoIcmsOrig, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaIcmsOrig, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoIcmsDeb, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaIcmsDeb, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoPis, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaPis, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoCofins, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaCofins, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoIpi, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaIpi, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoIcmsDevOrig, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaIcmsDevOrig, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoIcmsDevDeb, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaIcmsDevDeb, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoPisDev, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaPisDev, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoCofDev, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaCofDev, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cGrupoIpiDev, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cContaIpiDev, 10)) + ","

            loc_cVals = loc_cVals + ;
                        FormatarNumeroSQL(THIS.this_nPorcCons, 2) + "," + ;
                        FormatarNumeroSQL(THIS.this_nPorcPis, 2) + "," + ;
                        EscaparSQL(LEFT(LTRIM(STR(THIS.this_nRegTribCat44, 2, 0)), 2)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCcustos, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cPerfil, 1)) + "," + ;
                        EscaparSQL(LEFT(LTRIM(STR(THIS.this_nIndica, 1, 0)), 1)) + "," + ;
                        FormatarNumeroSQL(VAL(THIS.this_cTipoEfd), 0) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cSmtpNfe, 50)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cEmailNfe, 250)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cSenhaNfe, 30)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nPortaNfe, 0) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cPastaEmail, 50)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cTextoNfe, 4000)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cTextoPaf, 4000)) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cLogo, 250)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cPastaFci, 50)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cRegEsp, 3)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCodOper, 10)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCodSMun, 30)) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cEntCol, 254)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cEmpRel, 3)) + "," + ;
                        FormatarNumeroSQL(THIS.this_nOrdem, 0) + ","

            loc_cVals = loc_cVals + ;
                        EscaparSQL(LEFT(THIS.this_cChaveParceiro, 50)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cChaveContrib, 50)) + "," + ;
                        EscaparSQL(LEFT(THIS.this_cCsc, 50)) + ","

            *-- Colunas legado sem propriedade BO (defaults)
            *-- Ordem: drivels,drivers,drivets,etpads,modems,naudits,paths,prget1s,prget2s,
            *--        rectrans,tipos,transps,arqcnabs,clrarqs,colexes,
            *--        dirftpls,dirftpts,contfins,ddd1s,ddd2s,ramal1s,ramal2s,desopers,
            *--        ctacreest,ctadebest,dctacreest,dctadebest,nchkdatas,intconts,
            *--        ftpdel,ftpend,ftpsenha,ftpusuario,lnaotransp,locdel,tpconexao,altmovtrs,codipcs,
            *--        emplivros,empconts,empbxfs,locsorts,anavends,codigoscrm
            loc_cVals = loc_cVals + ;
                        "'','','',0,0,0,'','','',0,'',0,'',0,'','','','','','','','','','','','','',0,0,0,'','','',0,0,'',0,'','','','','',0,''"

            loc_cSQL = "INSERT INTO SigCdEmp (" + ;
                       "cemps,nemps,razsocs,razas,prins,cgcs,tpemps,ies,ims,cnae,ean13," + ;
                       "ceps,paises,endes,numeros,compls,bairs,cidas,estas,nfshora1s,regiaos," + ;
                       "tel1s,tel2s,faxs,emails,resp_nome,resp_cargo,pfiscals," + ;
                       "ativas,grupo,class,grufranqs,contarls,confranqs,cestoque,codemps,codrepres," + ;
                       "chkesc,oficial1,dtcadas,dtencerras,dtiniops,nnumprotbx,dtprotbx,regimes," + ;
                       "airs,scslls,spiss,scofs,mirs,mcslls,mpiss,mcofs,acslls,sirs,acsn," + ;
                       "mostraim,mostrapara,aliqia," + ;
                       "aleservs,aleportas,aleemails,alesenhas," + ;
                       "impcars,cautos,obsetiqs,obs,tiponfs,difpes,verests,pplinha1s,pplinha2s,dope_int," + ;
                       "comiss,percomis,bancs,agencs,contas,emprefs," + ;
                       "cempsitefs,perccrs,adics," + ;
                       "tptrans,nchkmrcfs,codservs,descservs," + ;
                       "empbals,calccustos,nums,cfilas,supervs,dircolouts,cdlsenhas,divnotas," + ;
                       "padservs,pademails,padsenhas,padportas," + ;
                       "nchkecomm,blqdatas,nrlocsorts," + ;
                       "cfis_int,moedas," + ;
                       "gruorigs,conorigs,gruicmos,conicmos,grupisos,conpisos,gruconos,conconos,gruipios,conipios," + ;
                       "grudests,condests,gruicmds,conicmds,grupisds,conpisds,gruconds,conconds,gruipids,conipids," + ;
                       "porccons,porcpis,regtribs,ccustos,perfils,indicas,ntpefds," + ;
                       "servs,emailnfe,senhas,portas,pastas,textonfe,textopaf," + ;
                       "logonfe,pastafci,empofs,codopers,dirs," + ;
                       "dircolins,emprels,ordems," + ;
                       "chavep,chavec,csc," + ;
                       "drivels,drivers,drivets,etpads,modems,naudits,paths,prget1s,prget2s," + ;
                       "rectrans,tipos,transps,arqcnabs,clrarqs,colexes," + ;
                       "dirftpls,dirftpts,contfins,ddd1s,ddd2s,ramal1s,ramal2s,desopers," + ;
                       "ctacreest,ctadebest,dctacreest,dctadebest,nchkdatas,intconts," + ;
                       "ftpdel,ftpend,ftpsenha,ftpusuario,lnaotransp,locdel,tpconexao,altmovtrs,codipcs," + ;
                       "emplivros,empconts,empbxfs,locsorts," + ;
                       "anavends,codigoscrm" + ;
                       ") VALUES (" + loc_cVals + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 0
                MsgErro("Erro ao incluir empresa. " + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * Atualizar - UPDATE SigCdEmp
    *===========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nRet, loc_lResultado, loc_oErro
        loc_lResultado = .T.
        TRY
            loc_cSQL = "UPDATE SigCdEmp SET " + ;
                       "  nemps="          + FormatarNumeroSQL(THIS.this_nNumero, 0) + "," + ;
                       "  razsocs="        + EscaparSQL(LEFT(THIS.this_cRazaoSocial, 50)) + "," + ;
                       "  razas="          + EscaparSQL(LEFT(THIS.this_cNomeFantasia, 40)) + "," + ;
                       "  prins="          + EscaparSQL(LEFT(THIS.this_cNomeReduzido, 15)) + "," + ;
                       "  cgcs="           + EscaparSQL(LEFT(THIS.this_cCgc, 20)) + "," + ;
                       "  tpemps="         + FormatarNumeroSQL(THIS.this_nTipoCgc, 0) + "," + ;
                       "  ies="            + EscaparSQL(LEFT(THIS.this_cIe, 15)) + "," + ;
                       "  ims="            + EscaparSQL(LEFT(THIS.this_cIm, 15)) + "," + ;
                       "  cnae="           + EscaparSQL(LEFT(THIS.this_cCnae, 15)) + "," + ;
                       "  ean13="          + FormatarNumeroSQL(VAL(THIS.this_cEan13), 0) + ","

            loc_cSQL = loc_cSQL + ;
                       "  ceps="           + EscaparSQL(LEFT(THIS.this_cCep, 9)) + "," + ;
                       "  paises="         + EscaparSQL(LEFT(THIS.this_cPais, 30)) + "," + ;
                       "  endes="          + EscaparSQL(LEFT(THIS.this_cEndereco, 60)) + "," + ;
                       "  numeros="        + EscaparSQL(LEFT(THIS.this_cNumEndereco, 21)) + "," + ;
                       "  compls="         + EscaparSQL(LEFT(THIS.this_cComplemento, 25)) + "," + ;
                       "  bairs="          + EscaparSQL(LEFT(THIS.this_cBairro, 40)) + "," + ;
                       "  cidas="          + EscaparSQL(LEFT(THIS.this_cCidade, 30)) + "," + ;
                       "  estas="          + EscaparSQL(LEFT(THIS.this_cEstado, 2)) + "," + ;
                       "  nfshora1s="      + FormatarNumeroSQL(THIS.this_nFusoHorario, 0) + "," + ;
                       "  regiaos="        + EscaparSQL(LEFT(THIS.this_cRegiao, 10)) + ","

            loc_cSQL = loc_cSQL + ;
                       "  tel1s="          + EscaparSQL(LEFT(THIS.this_cTelefone1, 20)) + "," + ;
                       "  tel2s="          + EscaparSQL(LEFT(THIS.this_cTelefone2, 20)) + "," + ;
                       "  faxs="           + EscaparSQL(LEFT(THIS.this_cFax, 20)) + "," + ;
                       "  emails="         + EscaparSQL(LEFT(THIS.this_cEmail, 50)) + "," + ;
                       "  resp_nome="      + EscaparSQL(LEFT(THIS.this_cResponsavel, 40)) + "," + ;
                       "  resp_cargo="     + EscaparSQL(LEFT(THIS.this_cCargo, 40)) + "," + ;
                       "  pfiscals="       + EscaparSQL(LEFT(THIS.this_cPostoFiscal, 15)) + ","

            loc_cSQL = loc_cSQL + ;
                       "  ativas="         + FormatarNumeroSQL(THIS.this_nSituacao, 0) + "," + ;
                       "  grupo="          + EscaparSQL(LEFT(THIS.this_cGrupoEmpresarial, 15)) + "," + ;
                       "  class="          + EscaparSQL(LEFT(THIS.this_cClassificacaoEmp, 15)) + "," + ;
                       "  grufranqs="      + EscaparSQL(LEFT(THIS.this_cGrupoCC, 10)) + "," + ;
                       "  contarls="       + EscaparSQL(LEFT(THIS.this_cContaArls, 10)) + "," + ;
                       "  confranqs="      + EscaparSQL(LEFT(THIS.this_cContaC, 10)) + "," + ;
                       "  cestoque="       + EscaparSQL(LEFT(THIS.this_cCEstoque, 10)) + "," + ;
                       "  codemps="        + FormatarNumeroSQL(VAL(THIS.this_cCodEmpresa), 0) + "," + ;
                       "  codrepres="      + EscaparSQL(LEFT(THIS.this_cCodRepres, 4)) + "," + ;
                       "  chkesc="         + FormatarNumeroSQL(IIF(THIS.this_lEscritorio, 1, 0), 0) + "," + ;
                       "  oficial1="       + FormatarNumeroSQL(IIF(THIS.this_lAnaVends, 1, 0), 0) + ","

            loc_cSQL = loc_cSQL + ;
                       "  dtcadas="        + IIF(EMPTY(THIS.this_dDtCadastro),       "NULL", FormatarDataSQL(THIS.this_dDtCadastro)) + "," + ;
                       "  dtencerras="     + IIF(EMPTY(THIS.this_dDtEncerramento),   "NULL", FormatarDataSQL(THIS.this_dDtEncerramento)) + "," + ;
                       "  dtiniops="       + IIF(EMPTY(THIS.this_dDtInicioOperacao), "NULL", FormatarDataSQL(THIS.this_dDtInicioOperacao)) + "," + ;
                       "  nnumprotbx="     + FormatarNumeroSQL(VAL(THIS.this_cNumProtBx), 0) + "," + ;
                       "  dtprotbx="       + IIF(EMPTY(THIS.this_dDtProtBx), "NULL", FormatarDataSQL(THIS.this_dDtProtBx)) + "," + ;
                       "  regimes="        + FormatarNumeroSQL(THIS.this_nRegimeTrib, 0) + ","

            loc_cSQL = loc_cSQL + ;
                       "  airs="           + FormatarNumeroSQL(THIS.this_nAliqIR, 2) + "," + ;
                       "  scslls="         + FormatarNumeroSQL(THIS.this_nServCSLL, 2) + "," + ;
                       "  spiss="          + FormatarNumeroSQL(THIS.this_nServPIS, 2) + "," + ;
                       "  scofs="          + FormatarNumeroSQL(THIS.this_nServCofins, 2) + "," + ;
                       "  mirs="           + FormatarNumeroSQL(THIS.this_nMercIR, 2) + "," + ;
                       "  mcslls="         + FormatarNumeroSQL(THIS.this_nMercCSLL, 2) + "," + ;
                       "  mpiss="          + FormatarNumeroSQL(THIS.this_nMercPIS, 2) + "," + ;
                       "  mcofs="          + FormatarNumeroSQL(THIS.this_nMercCofins, 2) + "," + ;
                       "  acslls="         + FormatarNumeroSQL(THIS.this_nAliqCSLL, 2) + "," + ;
                       "  sirs="           + FormatarNumeroSQL(THIS.this_nServIR, 2) + "," + ;
                       "  acsn="           + FormatarNumeroSQL(THIS.this_nAliqSimples, 2) + ","

            loc_cSQL = loc_cSQL + ;
                       "  mostraim="       + FormatarNumeroSQL(THIS.this_nMostraImp, 0) + "," + ;
                       "  mostrapara="     + FormatarNumeroSQL(THIS.this_nMostraPara, 0) + "," + ;
                       "  aliqia="         + FormatarNumeroSQL(THIS.this_nAliqImpAprox, 2) + ","

            loc_cSQL = loc_cSQL + ;
                       "  aleservs="       + EscaparSQL(LEFT(THIS.this_cSmtpAlerta, 30)) + "," + ;
                       "  aleportas="      + FormatarNumeroSQL(THIS.this_nPortaAlerta, 0) + "," + ;
                       "  aleemails="      + EscaparSQL(LEFT(THIS.this_cEmailAlerta, 50)) + "," + ;
                       "  alesenhas="      + EscaparSQL(LEFT(THIS.this_cSenhaAlerta, 30)) + ","

            loc_cSQL = loc_cSQL + ;
                       "  impcars="        + EscaparSQL(LEFT(THIS.this_cImpressora, 1)) + "," + ;
                       "  cautos="         + EscaparSQL(LEFT(THIS.this_cCarrAutomatico, 1)) + "," + ;
                       "  obsetiqs="       + EscaparSQL(LEFT(THIS.this_cEtiqProd, 1)) + "," + ;
                       "  obs="            + EscaparSQL(LEFT(THIS.this_cMemoBoleto, 150)) + "," + ;
                       "  tiponfs="        + FormatarNumeroSQL(VAL(THIS.this_cTipoOf), 0) + "," + ;
                       "  difpes="         + EscaparSQL(LEFT(LTRIM(STR(THIS.this_nDifPeso, 1, 0)), 1)) + "," + ;
                       "  verests="        + FormatarNumeroSQL(VAL(THIS.this_cEstoqueCtrl), 0) + "," + ;
                       "  pplinha1s="      + EscaparSQL(LEFT(THIS.this_cPinPadLinha1, 16)) + "," + ;
                       "  pplinha2s="      + EscaparSQL(LEFT(THIS.this_cPinPadLinha2, 16)) + "," + ;
                       "  dope_int="       + EscaparSQL(LEFT(THIS.this_cDopInt, 20)) + ","

            loc_cSQL = loc_cSQL + ;
                       "  comiss="         + FormatarNumeroSQL(THIS.this_nOpcComis, 0) + "," + ;
                       "  percomis="       + FormatarNumeroSQL(THIS.this_nPerComis, 2) + "," + ;
                       "  bancs="          + EscaparSQL(LEFT(THIS.this_cBanco, 4)) + "," + ;
                       "  agencs="         + EscaparSQL(LEFT(THIS.this_cAgencia, 5)) + "," + ;
                       "  contas="         + EscaparSQL(LEFT(THIS.this_cConta, 11)) + "," + ;
                       "  emprefs="        + EscaparSQL(LEFT(THIS.this_cDac, 3)) + ","

            loc_cSQL = loc_cSQL + ;
                       "  cempsitefs="     + EscaparSQL(LEFT(THIS.this_cEmpSitef, 3)) + "," + ;
                       "  perccrs="        + FormatarNumeroSQL(THIS.this_nPercCreds, 2) + "," + ;
                       "  adics="          + FormatarNumeroSQL(THIS.this_nAdicional, 0) + ","

            loc_cSQL = loc_cSQL + ;
                       "  tptrans="        + EscaparSQL(LEFT(LTRIM(STR(THIS.this_nTpTrans, 6, 0)), 6)) + "," + ;
                       "  nchkmrcfs="      + FormatarNumeroSQL(THIS.this_nChkMrcfs, 0) + "," + ;
                       "  codservs="       + EscaparSQL(LEFT(THIS.this_cCodServSaida, 10)) + "," + ;
                       "  descservs="      + EscaparSQL(LEFT(THIS.this_cDescServSaida, 40)) + ","

            loc_cSQL = loc_cSQL + ;
                       "  empbals="        + EscaparSQL(LEFT(THIS.this_cEmpBal, 3)) + "," + ;
                       "  calccustos="     + FormatarNumeroSQL(THIS.this_nCalcCustos, 0) + "," + ;
                       "  nums="           + EscaparSQL(LEFT(THIS.this_cContratoDef, 21)) + "," + ;
                       "  cfilas="         + EscaparSQL(LEFT(THIS.this_cAgenciaSedex, 8)) + "," + ;
                       "  supervs="        + EscaparSQL(LEFT(THIS.this_cSupervisor, 10)) + "," + ;
                       "  dircolouts="     + EscaparSQL(LEFT(THIS.this_cSaiCol, 254)) + "," + ;
                       "  cdlsenhas="      + EscaparSQL(LEFT(THIS.this_cCdlSenha, 10)) + "," + ;
                       "  divnotas="       + FormatarNumeroSQL(THIS.this_nBriefing, 0) + ","

            loc_cSQL = loc_cSQL + ;
                       "  padservs="       + EscaparSQL(LEFT(THIS.this_cSmtpEmail, 50)) + "," + ;
                       "  pademails="      + EscaparSQL(LEFT(THIS.this_cEmailPad, 50)) + "," + ;
                       "  padsenhas="      + EscaparSQL(LEFT(THIS.this_cSenhaEmail, 30)) + "," + ;
                       "  padportas="      + FormatarNumeroSQL(THIS.this_nPortaEmail, 0) + ","

            loc_cSQL = loc_cSQL + ;
                       "  nchkecomm="      + FormatarNumeroSQL(THIS.this_nEcommerce, 0) + "," + ;
                       "  blqdatas="       + FormatarNumeroSQL(IIF(THIS.this_lBlqDt, 1, 0), 0) + "," + ;
                       "  nrlocsorts="     + FormatarNumeroSQL(THIS.this_nTempoSub, 0) + ","

            loc_cSQL = loc_cSQL + ;
                       "  cfis_int="       + EscaparSQL(LEFT(THIS.this_cCfoInt, 10)) + "," + ;
                       "  moedas="         + EscaparSQL(LEFT(THIS.this_cMcTotal, 3)) + ","

            loc_cSQL = loc_cSQL + ;
                       "  gruorigs="       + EscaparSQL(LEFT(THIS.this_cGrupoIcmsOrig, 10)) + "," + ;
                       "  conorigs="       + EscaparSQL(LEFT(THIS.this_cContaIcmsOrig, 10)) + "," + ;
                       "  gruicmos="       + EscaparSQL(LEFT(THIS.this_cGrupoIcmsDeb, 10)) + "," + ;
                       "  conicmos="       + EscaparSQL(LEFT(THIS.this_cContaIcmsDeb, 10)) + "," + ;
                       "  grupisos="       + EscaparSQL(LEFT(THIS.this_cGrupoPis, 10)) + "," + ;
                       "  conpisos="       + EscaparSQL(LEFT(THIS.this_cContaPis, 10)) + "," + ;
                       "  gruconos="       + EscaparSQL(LEFT(THIS.this_cGrupoCofins, 10)) + "," + ;
                       "  conconos="       + EscaparSQL(LEFT(THIS.this_cContaCofins, 10)) + "," + ;
                       "  gruipios="       + EscaparSQL(LEFT(THIS.this_cGrupoIpi, 10)) + "," + ;
                       "  conipios="       + EscaparSQL(LEFT(THIS.this_cContaIpi, 10)) + ","

            loc_cSQL = loc_cSQL + ;
                       "  grudests="       + EscaparSQL(LEFT(THIS.this_cGrupoIcmsDevOrig, 10)) + "," + ;
                       "  condests="       + EscaparSQL(LEFT(THIS.this_cContaIcmsDevOrig, 10)) + "," + ;
                       "  gruicmds="       + EscaparSQL(LEFT(THIS.this_cGrupoIcmsDevDeb, 10)) + "," + ;
                       "  conicmds="       + EscaparSQL(LEFT(THIS.this_cContaIcmsDevDeb, 10)) + "," + ;
                       "  grupisds="       + EscaparSQL(LEFT(THIS.this_cGrupoPisDev, 10)) + "," + ;
                       "  conpisds="       + EscaparSQL(LEFT(THIS.this_cContaPisDev, 10)) + "," + ;
                       "  gruconds="       + EscaparSQL(LEFT(THIS.this_cGrupoCofDev, 10)) + "," + ;
                       "  conconds="       + EscaparSQL(LEFT(THIS.this_cContaCofDev, 10)) + "," + ;
                       "  gruipids="       + EscaparSQL(LEFT(THIS.this_cGrupoIpiDev, 10)) + "," + ;
                       "  conipids="       + EscaparSQL(LEFT(THIS.this_cContaIpiDev, 10)) + ","

            loc_cSQL = loc_cSQL + ;
                       "  porccons="       + FormatarNumeroSQL(THIS.this_nPorcCons, 2) + "," + ;
                       "  porcpis="        + FormatarNumeroSQL(THIS.this_nPorcPis, 2) + "," + ;
                       "  regtribs="       + EscaparSQL(LEFT(LTRIM(STR(THIS.this_nRegTribCat44, 2, 0)), 2)) + "," + ;
                       "  ccustos="        + EscaparSQL(LEFT(THIS.this_cCcustos, 10)) + "," + ;
                       "  perfils="        + EscaparSQL(LEFT(THIS.this_cPerfil, 1)) + "," + ;
                       "  indicas="        + EscaparSQL(LEFT(LTRIM(STR(THIS.this_nIndica, 1, 0)), 1)) + "," + ;
                       "  ntpefds="        + FormatarNumeroSQL(VAL(THIS.this_cTipoEfd), 0) + ","

            loc_cSQL = loc_cSQL + ;
                       "  servs="          + EscaparSQL(LEFT(THIS.this_cSmtpNfe, 50)) + "," + ;
                       "  emailnfe="       + EscaparSQL(LEFT(THIS.this_cEmailNfe, 250)) + "," + ;
                       "  senhas="         + EscaparSQL(LEFT(THIS.this_cSenhaNfe, 30)) + "," + ;
                       "  portas="         + FormatarNumeroSQL(THIS.this_nPortaNfe, 0) + "," + ;
                       "  pastas="         + EscaparSQL(LEFT(THIS.this_cPastaEmail, 50)) + "," + ;
                       "  textonfe="       + EscaparSQL(LEFT(THIS.this_cTextoNfe, 4000)) + "," + ;
                       "  textopaf="       + EscaparSQL(LEFT(THIS.this_cTextoPaf, 4000)) + ","

            loc_cSQL = loc_cSQL + ;
                       "  logonfe="        + EscaparSQL(LEFT(THIS.this_cLogo, 250)) + "," + ;
                       "  pastafci="       + EscaparSQL(LEFT(THIS.this_cPastaFci, 50)) + "," + ;
                       "  empofs="         + EscaparSQL(LEFT(THIS.this_cRegEsp, 3)) + "," + ;
                       "  codopers="       + EscaparSQL(LEFT(THIS.this_cCodOper, 10)) + "," + ;
                       "  dirs="           + EscaparSQL(LEFT(THIS.this_cCodSMun, 30)) + ","

            loc_cSQL = loc_cSQL + ;
                       "  dircolins="      + EscaparSQL(LEFT(THIS.this_cEntCol, 254)) + "," + ;
                       "  emprels="        + EscaparSQL(LEFT(THIS.this_cEmpRel, 3)) + "," + ;
                       "  ordems="         + FormatarNumeroSQL(THIS.this_nOrdem, 0) + ","

            loc_cSQL = loc_cSQL + ;
                       "  chavep="         + EscaparSQL(LEFT(THIS.this_cChaveParceiro, 50)) + "," + ;
                       "  chavec="         + EscaparSQL(LEFT(THIS.this_cChaveContrib, 50)) + "," + ;
                       "  csc="            + EscaparSQL(LEFT(THIS.this_cCsc, 50))

            loc_cSQL = loc_cSQL + ;
                       " WHERE cemps = " + EscaparSQL(THIS.this_cCodigo)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 0
                MsgErro("Erro ao atualizar empresa. " + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *===========================================================================
    * ExecutarExclusao - DELETE FROM SigCdEmp
    *===========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nRet, loc_lResultado, loc_oErro
        loc_lResultado = .T.
        TRY
            loc_cSQL = "DELETE FROM SigCdEmp WHERE cemps = " + EscaparSQL(THIS.this_cCodigo)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 0
                MsgErro("Erro ao excluir empresa. " + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("DELETE")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE
