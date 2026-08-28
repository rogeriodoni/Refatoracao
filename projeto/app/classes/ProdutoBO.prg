*====================================================================
* ProdutoBO.prg
*
* Business Object para Cadastro de Produtos
* Tabela principal: SigCdPro
*====================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

	*-- Chave primaria e identificacao
	this_cCpros              = ""   && cpros        char(14) PK
	this_nIdpro              = 0    && idpro         numeric(10,0)
	this_cCodident           = ""   && codident      char(20) nullable

	*-- Descricoes
	this_cDpros              = ""   && dpros         char(65)
	this_cDpro2s             = ""   && dpro2s        char(45)
	this_mDpro3s             = ""   && dpro3s        text

	*-- Classificacao
	this_cCgrus              = ""   && cgrus         char(3)
	this_cSgrus              = ""   && sgrus         char(6)
	this_cLinhas             = ""   && linhas        char(10)
	this_cColecoes           = ""   && colecoes      char(10)
	this_cConjunts           = ""   && conjunts      char(6)
	this_cTipos              = ""   && tipos         char(1)
	this_cStatus             = ""   && status        char(3)
	this_nSituas             = 0    && situas        numeric(1,0)
	this_dDtsituas           = {}   && dtsituas      datetime
	this_cCclass             = ""   && cclass        char(3)
	this_cNivelqs            = ""   && nivelqs       char(10)
	this_cCategoria          = ""   && categoria     char(6)
	this_cCodctgsite         = ""   && codctgsite    char(2)
	this_cCoddptsite         = ""   && coddptsite    char(2)
	this_cCodmacro           = ""   && codmacro      char(6)

	*-- Fornecedor e referencia
	this_cIfors              = ""   && ifors         char(10)
	this_cReffs              = ""   && reffs         char(40)
	this_cCvens              = ""   && cvens         char(10)

	*-- Cor, tamanho e material
	this_cCodcors            = ""   && codcors       char(4)
	this_cCodtams            = ""   && codtams       char(4)
	this_cMatprincs          = ""   && matprincs     char(14)
	this_cMetals             = ""   && metals        char(2)
	this_cTeors              = ""   && teors         char(2)
	this_cCompos             = ""   && compos        char(30)
	this_cConquilhas         = ""   && conquilhas    char(10)
	this_cPropriedades       = ""   && propriedades  char(40)
	this_nCravcers           = 0    && cravcers      numeric(1,0)

	*-- Precos e custos
	this_nPcuss              = 0    && pcuss         numeric(11,5)
	this_nPvens              = 0    && pvens         numeric(11,5)
	this_nPvideals           = 0    && pvideals      numeric(11,5)
	this_nPrecode            = 0    && precode       numeric(11,5)
	this_nCustofs            = 0    && custofs       numeric(11,3)
	this_nCustocp            = 0    && custocp       numeric(11,5)
	this_nValors             = 0    && valors        numeric(11,2)
	this_nMarkupa            = 0    && markupa       numeric(11,3)
	this_nMargems            = 0    && margems       numeric(9,6)
	this_nFcustos            = 0    && fcustos       numeric(11,5)
	this_nFvendas            = 0    && fvendas       numeric(7,3)
	this_nFatuals            = 0    && fatuals       numeric(11,5)
	this_nFideals            = 0    && fideals       numeric(11,5)
	this_nCotacalcp          = 0    && cotacalcp     numeric(11,6)

	*-- Moedas
	this_cMoecs              = ""   && moecs         char(3)
	this_cMoecusfs           = ""   && moecusfs      char(3)
	this_cMoedas             = ""   && moedas        char(3)
	this_cMoepcs             = ""   && moepcs        char(3)
	this_cMoepvs             = ""   && moepvs        char(3)
	this_cMoevs              = ""   && moevs         char(3)

	*-- Fiscal
	this_cClfiscals          = ""   && clfiscals     char(10)
	this_cSittricms          = ""   && sittricms     char(3)
	this_nIcms               = 0    && icms          numeric(5,2)
	this_nAliqipis           = 0    && aliqipis      numeric(5,2)
	this_cIpis               = ""   && ipis          char(1)
	this_cTptribs            = ""   && tptribs       char(4)
	this_cOrigmercs          = ""   && origmercs     char(1)
	this_cExtipi             = ""   && extipi        char(3)
	this_cMercs              = ""   && mercs         char(3)
	this_cDescecfs           = ""   && descecfs      char(29)
	this_cCodgarras          = ""   && codgarras     char(10)
	this_cMftios             = ""   && mftios        char(3)
	this_nPftios             = 0    && pftios        numeric(11,3)
	this_cCftios             = ""   && cftios        char(2)
	this_cCftiocs            = ""   && cftiocs       char(2)
	this_nPftiocs            = 0    && pftiocs       numeric(11,3)
	this_cCodservs           = ""   && codservs      char(4)
	this_cIats               = ""   && iats          char(1)
	this_cCodacbs            = ""   && codacbs       char(3)
	this_nEncargos           = 0    && encargos      numeric(7,4)
	this_cCodfinp            = ""   && codfinp       char(3)
	this_cCodmatp            = ""   && codmatp       char(3)
	this_cIdecpros           = ""   && idecpros      char(3)

	*-- Peso e dimensoes
	this_nPesoms             = 0    && pesoms        numeric(8,3)
	this_nPesobs             = 0    && pesobs        numeric(7,3)
	this_nPesometal          = 0    && pesometal     numeric(9,3)
	this_nPesobris           = 0    && pesobris      numeric(9,3)
	this_nPesopdrs           = 0    && pesopdrs      numeric(9,3)
	this_nAltura             = 0    && altura        numeric(7,4)
	this_nLargura            = 0    && largura       numeric(7,4)
	this_nDiametro           = 0    && diametro      numeric(7,4)
	this_nEspessura          = 0    && espessura     numeric(7,4)
	this_nCompriment         = 0    && compriment    numeric(7,4)
	this_nVarias             = 0    && varias        numeric(1,0)
	this_nVarpesoms          = 0    && varpesoms     numeric(5,2)

	*-- Estoque e compras
	this_nQmins              = 0    && qmins         numeric(9,3)
	this_nPmins              = 0    && pmins         numeric(7,3)
	this_nQtminfabs          = 0    && qtminfabs     numeric(9,3)
	this_nLtminsv            = 0    && ltminsv       numeric(9,3)
	this_nQtdultcomp         = 0    && qtdultcomp    numeric(12,0)
	this_nVultcomps          = 0    && vultcomps     numeric(11,2)
	this_cMultcomps          = ""   && multcomps     char(3)
	this_dUltcomps           = {}   && ultcomps      datetime
	this_nQtped              = 0    && qtped         numeric(9,3)
	this_nEncoms             = 0    && encoms        numeric(1,0)
	this_nConsigs            = 0    && consigs       numeric(1,0)

	*-- Unidades e codigos de barras
	this_cCunis              = ""   && cunis         char(3)
	this_cCunips             = ""   && cunips        char(3)
	this_nCbars              = 0    && cbars         numeric(14,0)
	this_nEan13              = 0    && ean13         numeric(13,0)
	this_cSkuvtex            = ""   && skuvtex       char(50)

	*-- Composicao e montagem
	this_cCproeqs            = ""   && cproeqs       char(14)
	this_nQtdcpnts           = 0    && qtdcpnts      numeric(3,0)
	this_nMontadescs         = 0    && montadescs    numeric(1,0)
	this_nDigimaxs           = 0    && digimaxs      numeric(2,0)
	this_nOrdcompos          = 0    && ordcompos     numeric(2,0)
	this_nCasas              = 0    && casas         numeric(2,0)
	this_nVolumes            = 0    && volumes       numeric(3,0)

	*-- Dimensoes de tamanho padrao
	this_nTamhs              = 0    && tamhs         numeric(5,2)
	this_nTamls              = 0    && tamls         numeric(5,2)
	this_nTamps              = 0    && tamps         numeric(5,2)

	*-- Fabricacao e producao
	this_nFabrproprs         = 0    && fabrproprs    numeric(1,0)
	this_nTents              = 0    && tents         numeric(3,0)
	this_nTinsts             = 0    && tinsts        numeric(3,0)
	this_nDiasinas           = 0    && diasinas      numeric(5,0)
	this_nProdvars           = 0    && prodvars      numeric(1,0)
	this_nProdwebs           = 0    && prodwebs      numeric(1,0)
	this_nProtnovo           = 0    && prodnovo      numeric(1,0)
	this_nProdoff            = 0    && prodoff       numeric(1,0)
	this_nPrototipo          = 0    && prototipo     numeric(1,0)
	this_nReposauto          = 0    && reposauto     numeric(1,0)
	this_nProcfigjpgs        = 0    && procfigjpgs   numeric(1,0)

	*-- Contabilidade
	this_cContaccus          = ""   && contaccus     char(10)
	this_cGruccus            = ""   && gruccus       char(10)
	this_nComis              = 0    && comis         numeric(5,2)

	*-- Localizacao e armazenagem
	this_cLocals             = ""   && locals        char(10)
	this_cNotas              = ""   && notas         char(6)
	this_cObsetqs            = ""   && obsetqs       char(10)

	*-- Observacoes e textos
	this_cObspeds            = ""   && obspeds       char(30)
	this_cObspes             = ""   && obspes        char(30)
	this_cObsmkt             = ""   && obsmkt        char(100)
	this_mObscompras         = ""   && obscompras    text
	this_mObsinsp            = ""   && obsinsp       text
	this_mDsccompras         = ""   && dsccompras    text
	this_mDescfis            = ""   && descfis       text

	*-- Imagens e arquivos
	this_mFigjpgs            = ""   && figjpgs       text
	this_mFigjpgs64          = ""   && figjpgs64     text
	this_mFigtecs            = ""   && figtecs       text

	*-- Tipo de servico
	this_mMtiposervs         = ""   && mtiposervs    text

	*-- Marketing e site
	this_nAtivosite          = 0    && ativosite     numeric(1,0)
	this_nForalinha          = 0    && foralinha     numeric(1,0)
	this_nMostruario         = 0    && mostruario    numeric(1,0)
	this_nBestseller         = 0    && bestseller    numeric(1,0)
	this_nSegfem             = 0    && segfem        numeric(1,0)
	this_nSeginf             = 0    && seginf        numeric(1,0)
	this_nSegkids            = 0    && segkids       numeric(1,0)
	this_nSegmasc            = 0    && segmasc       numeric(1,0)
	this_nSeguni             = 0    && seguni        numeric(1,0)
	this_nSemconsulta        = 0    && semconsulta   numeric(1,0)
	this_cLancamento         = ""   && lancamento    char(30)
	this_cOrigemlac          = ""   && origemlac     char(40)

	*-- Garantia
	this_nDiasgar            = 0    && diasgar       numeric(4,0) nullable
	this_nChkgarvit          = 0    && chkgarvit     numeric(1,0)

	*-- Gemologia
	this_nMohs               = 0    && mohs          numeric(3,0)
	this_cRefracao           = ""   && refracao      char(16)
	this_cRefracaodp         = ""   && refracaodp    char(16)

	*-- Laboratorio e qualidade
	this_cUnidade1           = ""   && unidade1          char(15)
	this_cResultado1         = ""   && resultado1        char(15)
	this_cValorminimo        = ""   && valorminimo       char(15)
	this_cValormaximo        = ""   && valormaximo       char(15)
	this_cMetodoreferencia1  = ""   && metodoreferencia1 char(15)

	*-- Flags booleanos (bit)
	this_lFlagctabs          = .F.  && flagctabs     bit
	this_lTcomps             = .F.  && tcomps        bit
	this_lTransps            = .F.  && transps       bit
	this_lImpetiqs           = .F.  && impetiqs      bit
	this_lChkfunds           = .F.  && chkfunds      bit

	*-- Auditoria e controle de datas
	this_dDatas              = {}   && datas         datetime
	this_dDatatrans          = {}   && datatrans     datetime
	this_dDtfilms            = {}   && dtfilms       datetime
	this_dDtincs             = {}   && dtincs        datetime
	this_dDtcomps            = {}   && dtcomps       datetime
	this_dDtalts             = {}   && dtalts        datetime
	this_dDtlacto            = {}   && dtlacto       datetime
	this_dFimdtlacto         = {}   && fimdtlacto    datetime
	this_cUsuincs            = ""   && usuincs       char(10)
	this_cUsuaalts           = ""   && usuaalts      char(20)
	this_nNidentfixa         = 0    && nidentfixa    numeric(1,0)
	this_nObrtamser          = 0    && obrtamser     numeric(1,0)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdPro"
		THIS.this_cCampoChave = "cpros"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna o valor da chave primaria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN THIS.this_cCpros
	ENDFUNC

	*====================================================================
	* Buscar - SELECT lista para o grid
	*====================================================================
	FUNCTION Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
		loc_lSucesso = .F.
		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF
			loc_cWhere = ""
			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
				loc_cWhere = " WHERE " + par_cFiltro
			ENDIF
			loc_cSQL = "SELECT cpros, dpros, cgrus, sgrus, linhas, tipos, situas, ifors," + ;
			           " pvens, pcuss, custofs, cunis, matprincs, codcors, codtams," + ;
			           " reffs, colecoes, idpro" + ;
			           " FROM SigCdPro" + loc_cWhere + ;
			           " ORDER BY dpros"
			*-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
			IF USED("cursor_4c_Dados")
			    TABLEREVERT(.T., "cursor_4c_Dados")
			    USE IN cursor_4c_Dados
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResult >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.Buscar:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarPorCodigo - Carrega produto pelo cpros (PK)
	*====================================================================
	FUNCTION CarregarPorCodigo(par_cCpros)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			IF USED("cursor_4c_Registro")
				USE IN cursor_4c_Registro
			ENDIF
			loc_cSQL    = "SELECT * FROM SigCdPro WHERE cpros = " + EscaparSQL(par_cCpros)
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro")
			IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Registro") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Registro")
			ENDIF
			IF USED("cursor_4c_Registro")
				USE IN cursor_4c_Registro
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Popula propriedades a partir do cursor
	*====================================================================
	FUNCTION CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCpros              = TratarNulo(cpros,              "")
				THIS.this_nIdpro              = TratarNulo(idpro,              0)
				THIS.this_cCodident           = TratarNulo(codident,           "")
				THIS.this_cDpros              = TratarNulo(dpros,              "")
				THIS.this_cDpro2s             = TratarNulo(dpro2s,             "")
				THIS.this_mDpro3s             = TratarNulo(dpro3s,             "")
				THIS.this_cCgrus              = TratarNulo(cgrus,              "")
				THIS.this_cSgrus              = TratarNulo(sgrus,              "")
				THIS.this_cLinhas             = TratarNulo(linhas,             "")
				THIS.this_cColecoes           = TratarNulo(colecoes,           "")
				THIS.this_cConjunts           = TratarNulo(conjunts,           "")
				THIS.this_cTipos              = TratarNulo(tipos,              "")
				THIS.this_cStatus             = TratarNulo(status,             "")
				THIS.this_nSituas             = TratarNulo(situas,             0)
				THIS.this_dDtsituas           = TratarNulo(dtsituas,           {})
				THIS.this_cCclass             = TratarNulo(cclass,             "")
				THIS.this_cNivelqs            = TratarNulo(nivelqs,            "")
				THIS.this_cCategoria          = TratarNulo(categoria,          "")
				THIS.this_cCodctgsite         = TratarNulo(codctgsite,         "")
				THIS.this_cCoddptsite         = TratarNulo(coddptsite,         "")
				THIS.this_cCodmacro           = TratarNulo(codmacro,           "")
				THIS.this_cIfors              = TratarNulo(ifors,              "")
				THIS.this_cReffs              = TratarNulo(reffs,              "")
				THIS.this_cCvens              = TratarNulo(cvens,              "")
				THIS.this_cCodcors            = TratarNulo(codcors,            "")
				THIS.this_cCodtams            = TratarNulo(codtams,            "")
				THIS.this_cMatprincs          = TratarNulo(matprincs,          "")
				THIS.this_cMetals             = TratarNulo(metals,             "")
				THIS.this_cTeors              = TratarNulo(teors,              "")
				THIS.this_cCompos             = TratarNulo(compos,             "")
				THIS.this_cConquilhas         = TratarNulo(conquilhas,         "")
				THIS.this_cPropriedades       = TratarNulo(propriedades,       "")
				THIS.this_nCravcers           = TratarNulo(cravcers,           0)
				THIS.this_nPcuss              = TratarNulo(pcuss,              0)
				THIS.this_nPvens              = TratarNulo(pvens,              0)
				THIS.this_nPvideals           = TratarNulo(pvideals,           0)
				THIS.this_nPrecode            = TratarNulo(precode,            0)
				THIS.this_nCustofs            = TratarNulo(custofs,            0)
				THIS.this_nCustocp            = TratarNulo(custocp,            0)
				THIS.this_nValors             = TratarNulo(valors,             0)
				THIS.this_nMarkupa            = TratarNulo(markupa,            0)
				THIS.this_nMargems            = TratarNulo(margems,            0)
				THIS.this_nFcustos            = TratarNulo(fcustos,            0)
				THIS.this_nFvendas            = TratarNulo(fvendas,            0)
				THIS.this_nFatuals            = TratarNulo(fatuals,            0)
				THIS.this_nFideals            = TratarNulo(fideals,            0)
				THIS.this_nCotacalcp          = TratarNulo(cotacalcp,          0)
				THIS.this_cMoecs              = TratarNulo(moecs,              "")
				THIS.this_cMoecusfs           = TratarNulo(moecusfs,           "")
				THIS.this_cMoedas             = TratarNulo(moedas,             "")
				THIS.this_cMoepcs             = TratarNulo(moepcs,             "")
				THIS.this_cMoepvs             = TratarNulo(moepvs,             "")
				THIS.this_cMoevs              = TratarNulo(moevs,              "")
				THIS.this_cClfiscals          = TratarNulo(clfiscals,          "")
				THIS.this_cSittricms          = TratarNulo(sittricms,          "")
				THIS.this_nIcms               = TratarNulo(icms,               0)
				THIS.this_nAliqipis           = TratarNulo(aliqipis,           0)
				THIS.this_cIpis               = TratarNulo(ipis,               "")
				THIS.this_cTptribs            = TratarNulo(tptribs,            "")
				THIS.this_cOrigmercs          = TratarNulo(origmercs,          "")
				THIS.this_cExtipi             = TratarNulo(extipi,             "")
				THIS.this_cMercs              = TratarNulo(mercs,              "")
				THIS.this_cDescecfs           = TratarNulo(descecfs,           "")
				THIS.this_cCodgarras          = TratarNulo(codgarras,          "")
				THIS.this_cMftios             = TratarNulo(mftios,             "")
				THIS.this_nPftios             = TratarNulo(pftios,             0)
				THIS.this_cCftios             = TratarNulo(cftios,             "")
				THIS.this_cCftiocs            = TratarNulo(cftiocs,            "")
				THIS.this_nPftiocs            = TratarNulo(pftiocs,            0)
				THIS.this_cCodservs           = TratarNulo(codservs,           "")
				THIS.this_cIats               = TratarNulo(iats,               "")
				THIS.this_cCodacbs            = TratarNulo(codacbs,            "")
				THIS.this_nEncargos           = TratarNulo(encargos,           0)
				THIS.this_cCodfinp            = TratarNulo(codfinp,            "")
				THIS.this_cCodmatp            = TratarNulo(codmatp,            "")
				THIS.this_cIdecpros           = TratarNulo(idecpros,           "")
				THIS.this_nPesoms             = TratarNulo(pesoms,             0)
				THIS.this_nPesobs             = TratarNulo(pesobs,             0)
				THIS.this_nPesometal          = TratarNulo(pesometal,          0)
				THIS.this_nPesobris           = TratarNulo(pesobris,           0)
				THIS.this_nPesopdrs           = TratarNulo(pesopdrs,           0)
				THIS.this_nAltura             = TratarNulo(altura,             0)
				THIS.this_nLargura            = TratarNulo(largura,            0)
				THIS.this_nDiametro           = TratarNulo(diametro,           0)
				THIS.this_nEspessura          = TratarNulo(espessura,          0)
				THIS.this_nCompriment         = TratarNulo(compriment,         0)
				THIS.this_nVarias             = TratarNulo(varias,             0)
				THIS.this_nVarpesoms          = TratarNulo(varpesoms,          0)
				THIS.this_nQmins              = TratarNulo(qmins,              0)
				THIS.this_nPmins              = TratarNulo(pmins,              0)
				THIS.this_nQtminfabs          = TratarNulo(qtminfabs,          0)
				THIS.this_nLtminsv            = TratarNulo(ltminsv,            0)
				THIS.this_nQtdultcomp         = TratarNulo(qtdultcomp,         0)
				THIS.this_nVultcomps          = TratarNulo(vultcomps,          0)
				THIS.this_cMultcomps          = TratarNulo(multcomps,          "")
				THIS.this_dUltcomps           = TratarNulo(ultcomps,           {})
				THIS.this_nQtped              = TratarNulo(qtped,              0)
				THIS.this_nEncoms             = TratarNulo(encoms,             0)
				THIS.this_nConsigs            = TratarNulo(consigs,            0)
				THIS.this_cCunis              = TratarNulo(cunis,              "")
				THIS.this_cCunips             = TratarNulo(cunips,             "")
				THIS.this_nCbars              = TratarNulo(cbars,              0)
				THIS.this_nEan13              = TratarNulo(ean13,              0)
				THIS.this_cSkuvtex            = TratarNulo(skuvtex,            "")
				THIS.this_cCproeqs            = TratarNulo(cproeqs,            "")
				THIS.this_nQtdcpnts           = TratarNulo(qtdcpnts,           0)
				THIS.this_nMontadescs         = TratarNulo(montadescs,         0)
				THIS.this_nDigimaxs           = TratarNulo(digimaxs,           0)
				THIS.this_nOrdcompos          = TratarNulo(ordcompos,          0)
				THIS.this_nCasas              = TratarNulo(casas,              0)
				THIS.this_nVolumes            = TratarNulo(volumes,            0)
				THIS.this_nTamhs              = TratarNulo(tamhs,              0)
				THIS.this_nTamls              = TratarNulo(tamls,              0)
				THIS.this_nTamps              = TratarNulo(tamps,              0)
				THIS.this_nFabrproprs         = TratarNulo(fabrproprs,         0)
				THIS.this_nTents              = TratarNulo(tents,              0)
				THIS.this_nTinsts             = TratarNulo(tinsts,             0)
				THIS.this_nDiasinas           = TratarNulo(diasinas,           0)
				THIS.this_nProdvars           = TratarNulo(prodvars,           0)
				THIS.this_nProdwebs           = TratarNulo(prodwebs,           0)
				THIS.this_nProtnovo           = TratarNulo(prodnovo,           0)
				THIS.this_nProdoff            = TratarNulo(prodoff,            0)
				THIS.this_nPrototipo          = TratarNulo(prototipo,          0)
				THIS.this_nReposauto          = TratarNulo(reposauto,          0)
				THIS.this_nProcfigjpgs        = TratarNulo(procfigjpgs,        0)
				THIS.this_cContaccus          = TratarNulo(contaccus,          "")
				THIS.this_cGruccus            = TratarNulo(gruccus,            "")
				THIS.this_nComis              = TratarNulo(comis,              0)
				THIS.this_cLocals             = TratarNulo(locals,             "")
				THIS.this_cNotas              = TratarNulo(notas,              "")
				THIS.this_cObsetqs            = TratarNulo(obsetqs,            "")
				THIS.this_cObspeds            = TratarNulo(obspeds,            "")
				THIS.this_cObspes             = TratarNulo(obspes,             "")
				THIS.this_cObsmkt             = TratarNulo(obsmkt,             "")
				THIS.this_mObscompras         = TratarNulo(obscompras,         "")
				THIS.this_mObsinsp            = TratarNulo(obsinsp,            "")
				THIS.this_mDsccompras         = TratarNulo(dsccompras,         "")
				THIS.this_mDescfis            = TratarNulo(descfis,            "")
				THIS.this_mFigjpgs            = TratarNulo(figjpgs,            "")
				THIS.this_mFigjpgs64          = TratarNulo(figjpgs64,          "")
				THIS.this_mFigtecs            = TratarNulo(figtecs,            "")
				THIS.this_mMtiposervs         = TratarNulo(mtiposervs,         "")
				THIS.this_nAtivosite          = TratarNulo(ativosite,          0)
				THIS.this_nForalinha          = TratarNulo(foralinha,          0)
				THIS.this_nMostruario         = TratarNulo(mostruario,         0)
				THIS.this_nBestseller         = TratarNulo(bestseller,         0)
				THIS.this_nSegfem             = TratarNulo(segfem,             0)
				THIS.this_nSeginf             = TratarNulo(seginf,             0)
				THIS.this_nSegkids            = TratarNulo(segkids,            0)
				THIS.this_nSegmasc            = TratarNulo(segmasc,            0)
				THIS.this_nSeguni             = TratarNulo(seguni,             0)
				THIS.this_nSemconsulta        = TratarNulo(semconsulta,        0)
				THIS.this_cLancamento         = TratarNulo(lancamento,         "")
				THIS.this_cOrigemlac          = TratarNulo(origemlac,          "")
				THIS.this_nDiasgar            = TratarNulo(diasgar,            0)
				THIS.this_nChkgarvit          = TratarNulo(chkgarvit,          0)
				THIS.this_nMohs               = TratarNulo(mohs,               0)
				THIS.this_cRefracao           = TratarNulo(refracao,           "")
				THIS.this_cRefracaodp         = TratarNulo(refracaodp,         "")
				THIS.this_cUnidade1           = TratarNulo(unidade1,           "")
				THIS.this_cResultado1         = TratarNulo(resultado1,         "")
				THIS.this_cValorminimo        = TratarNulo(valorminimo,        "")
				THIS.this_cValormaximo        = TratarNulo(valormaximo,        "")
				THIS.this_cMetodoreferencia1  = TratarNulo(metodoreferencia1,  "")
				THIS.this_lFlagctabs          = (TratarNulo(flagctabs,         0) <> 0)
				THIS.this_lTcomps             = (TratarNulo(tcomps,            0) <> 0)
				THIS.this_lTransps            = (TratarNulo(transps,           0) <> 0)
				THIS.this_lImpetiqs           = (TratarNulo(impetiqs,          0) <> 0)
				THIS.this_lChkfunds           = (TratarNulo(chkfunds,          0) <> 0)
				THIS.this_dDatas              = TratarNulo(datas,              {})
				THIS.this_dDatatrans          = TratarNulo(datatrans,          {})
				THIS.this_dDtfilms            = TratarNulo(dtfilms,            {})
				THIS.this_dDtincs             = TratarNulo(dtincs,             {})
				THIS.this_dDtcomps            = TratarNulo(dtcomps,            {})
				THIS.this_dDtalts             = TratarNulo(dtalts,             {})
				THIS.this_dDtlacto            = TratarNulo(dtlacto,            {})
				THIS.this_dFimdtlacto         = TratarNulo(fimdtlacto,         {})
				THIS.this_cUsuincs            = TratarNulo(usuincs,            "")
				THIS.this_cUsuaalts           = TratarNulo(usuaalts,           "")
				THIS.this_nNidentfixa         = TratarNulo(nidentfixa,         0)
				THIS.this_nObrtamser          = TratarNulo(obrtamser,          0)
				THIS.this_lNovoRegistro       = .F.
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ObterProxIdPro - Gera proximo idpro (MAX+1)
	*====================================================================
	PROTECTED FUNCTION ObterProxIdPro()
		LOCAL loc_cSQL, loc_nResult, loc_nProx
		loc_nProx = 1
		TRY
			IF USED("cursor_4c_MaxIdPro")
				USE IN cursor_4c_MaxIdPro
			ENDIF
			loc_cSQL    = "SELECT ISNULL(MAX(idpro), 0) + 1 AS proximoidpro FROM SigCdPro"
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxIdPro")
			IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MaxIdPro") > 0
				SELECT cursor_4c_MaxIdPro
				loc_nProx = proximoidpro
			ENDIF
			IF USED("cursor_4c_MaxIdPro")
				USE IN cursor_4c_MaxIdPro
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.ObterProxIdPro:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_nProx
	ENDFUNC

	*====================================================================
	* Inserir - INSERT INTO SigCdPro
	*====================================================================
	PROTECTED FUNCTION Inserir()
		LOCAL loc_cCols, loc_cVals, loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			THIS.this_nIdpro   = THIS.ObterProxIdPro()
			THIS.this_dDtincs  = DATETIME()
			THIS.this_cUsuincs = gc_4c_UsuarioLogado

			loc_cCols = "cpros, dpros, dpro2s, cgrus, sgrus, linhas, colecoes, conjunts, tipos," + ;
			            " status, situas, cclass, nivelqs, categoria, codctgsite, coddptsite, codmacro," + ;
			            " ifors, reffs, cvens," + ;
			            " codcors, codtams, matprincs, metals, teors, compos, conquilhas, propriedades, cravcers," + ;
			            " pcuss, pvens, pvideals, precode, custofs, custocp, valors, markupa, margems," + ;
			            " fcustos, fvendas, fatuals, fideals, cotacalcp," + ;
			            " moecs, moecusfs, moedas, moepcs, moepvs, moevs," + ;
			            " clfiscals, sittricms, icms, aliqipis, ipis, tptribs, origmercs, extipi, mercs," + ;
			            " descecfs, codgarras, mftios, pftios, cftios, cftiocs, pftiocs," + ;
			            " codservs, iats, codacbs, encargos, codfinp, codmatp, idecpros," + ;
			            " pesoms, pesobs, pesometal, pesobris, pesopdrs," + ;
			            " altura, largura, diametro, espessura, compriment, varias, varpesoms," + ;
			            " qmins, pmins, qtminfabs, ltminsv, qtdultcomp, vultcomps, multcomps, qtped, encoms, consigs," + ;
			            " cunis, cunips, cbars, ean13, skuvtex," + ;
			            " cproeqs, qtdcpnts, montadescs, digimaxs, ordcompos, casas, volumes, tamhs, tamls, tamps," + ;
			            " fabrproprs, tents, tinsts, diasinas, prodvars, prodwebs, prodnovo, prodoff," + ;
			            " prototipo, reposauto, procfigjpgs," + ;
			            " contaccus, gruccus, comis, locals, notas, obsetqs, obspeds, obspes, obsmkt," + ;
			            " ativosite, foralinha, mostruario, bestseller," + ;
			            " segfem, seginf, segkids, segmasc, seguni, semconsulta, lancamento, origemlac," + ;
			            " chkgarvit, mohs, refracao, refracaodp," + ;
			            " unidade1, resultado1, valorminimo, valormaximo, metodoreferencia1," + ;
			            " flagctabs, tcomps, transps, impetiqs, chkfunds," + ;
			            " usuincs, usuaalts, nidentfixa, obrtamser, idpro," + ;
			            " dtsituas, dtincs, datas, datatrans, dtfilms, dtcomps, dtalts, dtlacto, fimdtlacto, ultcomps, diasgar," + ;
			            " dpro3s, descfis, figjpgs, figjpgs64, figtecs, obscompras, obsinsp, dsccompras, mtiposervs, codident"

			loc_cVals  = EscaparSQL(THIS.this_cCpros)             + ", " + ;
			             EscaparSQL(THIS.this_cDpros)              + ", " + ;
			             EscaparSQL(THIS.this_cDpro2s)             + ", " + ;
			             EscaparSQL(THIS.this_cCgrus)              + ", " + ;
			             EscaparSQL(THIS.this_cSgrus)              + ", " + ;
			             EscaparSQL(THIS.this_cLinhas)             + ", " + ;
			             EscaparSQL(THIS.this_cColecoes)           + ", " + ;
			             EscaparSQL(THIS.this_cConjunts)           + ", " + ;
			             EscaparSQL(THIS.this_cTipos)              + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cStatus)             + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSituas)      + ", " + ;
			             EscaparSQL(THIS.this_cCclass)             + ", " + ;
			             EscaparSQL(THIS.this_cNivelqs)            + ", " + ;
			             EscaparSQL(THIS.this_cCategoria)          + ", " + ;
			             EscaparSQL(THIS.this_cCodctgsite)         + ", " + ;
			             EscaparSQL(THIS.this_cCoddptsite)         + ", " + ;
			             EscaparSQL(THIS.this_cCodmacro)           + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cIfors)              + ", " + ;
			             EscaparSQL(THIS.this_cReffs)              + ", " + ;
			             EscaparSQL(THIS.this_cCvens)              + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cCodcors)            + ", " + ;
			             EscaparSQL(THIS.this_cCodtams)            + ", " + ;
			             EscaparSQL(THIS.this_cMatprincs)          + ", " + ;
			             EscaparSQL(THIS.this_cMetals)             + ", " + ;
			             EscaparSQL(THIS.this_cTeors)              + ", " + ;
			             EscaparSQL(THIS.this_cCompos)             + ", " + ;
			             EscaparSQL(THIS.this_cConquilhas)         + ", " + ;
			             EscaparSQL(THIS.this_cPropriedades)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCravcers)    + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nPcuss)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPvens)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPvideals)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPrecode)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCustofs)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCustocp)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nValors)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nMarkupa)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nMargems)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nFcustos)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nFvendas)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nFatuals)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nFideals)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCotacalcp)   + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cMoecs)              + ", " + ;
			             EscaparSQL(THIS.this_cMoecusfs)           + ", " + ;
			             EscaparSQL(THIS.this_cMoedas)             + ", " + ;
			             EscaparSQL(THIS.this_cMoepcs)             + ", " + ;
			             EscaparSQL(THIS.this_cMoepvs)             + ", " + ;
			             EscaparSQL(THIS.this_cMoevs)              + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cClfiscals)          + ", " + ;
			             EscaparSQL(THIS.this_cSittricms)          + ", " + ;
			             FormatarNumeroSQL(THIS.this_nIcms)        + ", " + ;
			             FormatarNumeroSQL(THIS.this_nAliqipis)    + ", " + ;
			             EscaparSQL(THIS.this_cIpis)               + ", " + ;
			             EscaparSQL(THIS.this_cTptribs)            + ", " + ;
			             EscaparSQL(THIS.this_cOrigmercs)          + ", " + ;
			             EscaparSQL(THIS.this_cExtipi)             + ", " + ;
			             EscaparSQL(THIS.this_cMercs)              + ", " + ;
			             EscaparSQL(THIS.this_cDescecfs)           + ", " + ;
			             EscaparSQL(THIS.this_cCodgarras)          + ", " + ;
			             EscaparSQL(THIS.this_cMftios)             + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPftios)      + ", " + ;
			             EscaparSQL(THIS.this_cCftios)             + ", " + ;
			             EscaparSQL(THIS.this_cCftiocs)            + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPftiocs)     + ", " + ;
			             EscaparSQL(THIS.this_cCodservs)           + ", " + ;
			             EscaparSQL(THIS.this_cIats)               + ", " + ;
			             EscaparSQL(THIS.this_cCodacbs)            + ", " + ;
			             FormatarNumeroSQL(THIS.this_nEncargos)    + ", " + ;
			             EscaparSQL(THIS.this_cCodfinp)            + ", " + ;
			             EscaparSQL(THIS.this_cCodmatp)            + ", " + ;
			             EscaparSQL(THIS.this_cIdecpros)           + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nPesoms)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPesobs)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPesometal)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPesobris)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPesopdrs)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nAltura)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nLargura)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nDiametro)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nEspessura)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCompriment)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nVarias)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nVarpesoms)   + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nQmins)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPmins)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nQtminfabs)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nLtminsv)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nQtdultcomp)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nVultcomps)   + ", " + ;
			             EscaparSQL(THIS.this_cMultcomps)          + ", " + ;
			             FormatarNumeroSQL(THIS.this_nQtped)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nEncoms)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nConsigs)     + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cCunis)              + ", " + ;
			             EscaparSQL(THIS.this_cCunips)             + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCbars)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nEan13)       + ", " + ;
			             EscaparSQL(THIS.this_cSkuvtex)            + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cCproeqs)            + ", " + ;
			             FormatarNumeroSQL(THIS.this_nQtdcpnts)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nMontadescs)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nDigimaxs)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nOrdcompos)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nCasas)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nVolumes)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nTamhs)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nTamls)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nTamps)       + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nFabrproprs)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nTents)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nTinsts)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nDiasinas)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nProdvars)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nProdwebs)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nProtnovo)    + ", " + ;
			             FormatarNumeroSQL(THIS.this_nProdoff)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nPrototipo)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nReposauto)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nProcfigjpgs) + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cContaccus)          + ", " + ;
			             EscaparSQL(THIS.this_cGruccus)            + ", " + ;
			             FormatarNumeroSQL(THIS.this_nComis)       + ", " + ;
			             EscaparSQL(THIS.this_cLocals)             + ", " + ;
			             EscaparSQL(THIS.this_cNotas)              + ", " + ;
			             EscaparSQL(THIS.this_cObsetqs)            + ", " + ;
			             EscaparSQL(THIS.this_cObspeds)            + ", " + ;
			             EscaparSQL(THIS.this_cObspes)             + ", " + ;
			             EscaparSQL(THIS.this_cObsmkt)             + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nAtivosite)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nForalinha)   + ", " + ;
			             FormatarNumeroSQL(THIS.this_nMostruario)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nBestseller)  + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSegfem)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSeginf)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSegkids)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSegmasc)     + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSeguni)      + ", " + ;
			             FormatarNumeroSQL(THIS.this_nSemconsulta) + ", " + ;
			             EscaparSQL(THIS.this_cLancamento)         + ", " + ;
			             EscaparSQL(THIS.this_cOrigemlac)          + ", "

			loc_cVals  = loc_cVals + ;
			             FormatarNumeroSQL(THIS.this_nChkgarvit)        + ", " + ;
			             FormatarNumeroSQL(THIS.this_nMohs)             + ", " + ;
			             EscaparSQL(THIS.this_cRefracao)                + ", " + ;
			             EscaparSQL(THIS.this_cRefracaodp)              + ", " + ;
			             EscaparSQL(THIS.this_cUnidade1)                + ", " + ;
			             EscaparSQL(THIS.this_cResultado1)              + ", " + ;
			             EscaparSQL(THIS.this_cValorminimo)             + ", " + ;
			             EscaparSQL(THIS.this_cValormaximo)             + ", " + ;
			             EscaparSQL(THIS.this_cMetodoreferencia1)       + ", "

			loc_cVals  = loc_cVals + ;
			             IIF(THIS.this_lFlagctabs, "1", "0")       + ", " + ;
			             IIF(THIS.this_lTcomps,    "1", "0")       + ", " + ;
			             IIF(THIS.this_lTransps,   "1", "0")       + ", " + ;
			             IIF(THIS.this_lImpetiqs,  "1", "0")       + ", " + ;
			             IIF(THIS.this_lChkfunds,  "1", "0")       + ", "

			loc_cVals  = loc_cVals + ;
			             EscaparSQL(THIS.this_cUsuincs)                 + ", " + ;
			             EscaparSQL(THIS.this_cUsuincs)                 + ", " + ;
			             FormatarNumeroSQL(THIS.this_nNidentfixa)       + ", " + ;
			             FormatarNumeroSQL(THIS.this_nObrtamser)        + ", " + ;
			             FormatarNumeroSQL(THIS.this_nIdpro)            + ", "

			loc_cVals  = loc_cVals + ;
			             IIF(EMPTY(THIS.this_dDtsituas),  "NULL", FormatarDataSQL(THIS.this_dDtsituas))   + ", " + ;
			             FormatarDataSQL(THIS.this_dDtincs)                                                + ", " + ;
			             IIF(EMPTY(THIS.this_dDatas),     "NULL", FormatarDataSQL(THIS.this_dDatas))      + ", " + ;
			             IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))  + ", " + ;
			             IIF(EMPTY(THIS.this_dDtfilms),   "NULL", FormatarDataSQL(THIS.this_dDtfilms))    + ", " + ;
			             IIF(EMPTY(THIS.this_dDtcomps),   "NULL", FormatarDataSQL(THIS.this_dDtcomps))    + ", " + ;
			             IIF(EMPTY(THIS.this_dDtalts),    "NULL", FormatarDataSQL(THIS.this_dDtalts))     + ", " + ;
			             IIF(EMPTY(THIS.this_dDtlacto),   "NULL", FormatarDataSQL(THIS.this_dDtlacto))    + ", " + ;
			             IIF(EMPTY(THIS.this_dFimdtlacto),"NULL", FormatarDataSQL(THIS.this_dFimdtlacto)) + ", " + ;
			             IIF(EMPTY(THIS.this_dUltcomps),  "NULL", FormatarDataSQL(THIS.this_dUltcomps))   + ", " + ;
			             IIF(THIS.this_nDiasgar = 0,      "NULL", FormatarNumeroSQL(THIS.this_nDiasgar))  + ", "

			loc_cVals  = loc_cVals + ;
			             IIF(EMPTY(THIS.this_mDpro3s),    "NULL", EscaparSQL(THIS.this_mDpro3s))     + ", " + ;
			             IIF(EMPTY(THIS.this_mDescfis),   "NULL", EscaparSQL(THIS.this_mDescfis))    + ", " + ;
			             IIF(EMPTY(THIS.this_mFigjpgs),   "NULL", EscaparSQL(THIS.this_mFigjpgs))    + ", " + ;
			             IIF(EMPTY(THIS.this_mFigjpgs64), "NULL", EscaparSQL(THIS.this_mFigjpgs64))  + ", " + ;
			             IIF(EMPTY(THIS.this_mFigtecs),   "NULL", EscaparSQL(THIS.this_mFigtecs))    + ", " + ;
			             IIF(EMPTY(THIS.this_mObscompras),"NULL", EscaparSQL(THIS.this_mObscompras)) + ", " + ;
			             IIF(EMPTY(THIS.this_mObsinsp),   "NULL", EscaparSQL(THIS.this_mObsinsp))    + ", " + ;
			             IIF(EMPTY(THIS.this_mDsccompras),"NULL", EscaparSQL(THIS.this_mDsccompras)) + ", " + ;
			             IIF(EMPTY(THIS.this_mMtiposervs),"NULL", EscaparSQL(THIS.this_mMtiposervs)) + ", " + ;
			             IIF(EMPTY(THIS.this_cCodident),  "NULL", EscaparSQL(THIS.this_cCodident))

			loc_cSQL   = "INSERT INTO SigCdPro (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult >= 0
				THIS.RegistrarAuditoria("INSERT")
				THIS.SalvarFaseP()
				THIS.SalvarServicos()
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.Inserir:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* Atualizar - UPDATE SigCdPro
	*====================================================================
	PROTECTED FUNCTION Atualizar()
		LOCAL loc_cSet, loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			THIS.this_dDtalts   = DATETIME()
			THIS.this_cUsuaalts = gc_4c_UsuarioLogado

			loc_cSet  = " dpros = "        + EscaparSQL(THIS.this_cDpros)            + "," + ;
			            " dpro2s = "       + EscaparSQL(THIS.this_cDpro2s)           + "," + ;
			            " cgrus = "        + EscaparSQL(THIS.this_cCgrus)            + "," + ;
			            " sgrus = "        + EscaparSQL(THIS.this_cSgrus)            + "," + ;
			            " linhas = "       + EscaparSQL(THIS.this_cLinhas)           + "," + ;
			            " colecoes = "     + EscaparSQL(THIS.this_cColecoes)         + "," + ;
			            " conjunts = "     + EscaparSQL(THIS.this_cConjunts)         + "," + ;
			            " tipos = "        + EscaparSQL(THIS.this_cTipos)            + ","

			loc_cSet  = loc_cSet + ;
			            " status = "       + EscaparSQL(THIS.this_cStatus)           + "," + ;
			            " situas = "       + FormatarNumeroSQL(THIS.this_nSituas)    + "," + ;
			            " cclass = "       + EscaparSQL(THIS.this_cCclass)           + "," + ;
			            " nivelqs = "      + EscaparSQL(THIS.this_cNivelqs)          + "," + ;
			            " categoria = "    + EscaparSQL(THIS.this_cCategoria)        + "," + ;
			            " codctgsite = "   + EscaparSQL(THIS.this_cCodctgsite)       + "," + ;
			            " coddptsite = "   + EscaparSQL(THIS.this_cCoddptsite)       + "," + ;
			            " codmacro = "     + EscaparSQL(THIS.this_cCodmacro)         + ","

			loc_cSet  = loc_cSet + ;
			            " ifors = "        + EscaparSQL(THIS.this_cIfors)            + "," + ;
			            " reffs = "        + EscaparSQL(THIS.this_cReffs)            + "," + ;
			            " cvens = "        + EscaparSQL(THIS.this_cCvens)            + ","

			loc_cSet  = loc_cSet + ;
			            " codcors = "      + EscaparSQL(THIS.this_cCodcors)          + "," + ;
			            " codtams = "      + EscaparSQL(THIS.this_cCodtams)          + "," + ;
			            " matprincs = "    + EscaparSQL(THIS.this_cMatprincs)        + "," + ;
			            " metals = "       + EscaparSQL(THIS.this_cMetals)           + "," + ;
			            " teors = "        + EscaparSQL(THIS.this_cTeors)            + "," + ;
			            " compos = "       + EscaparSQL(THIS.this_cCompos)           + "," + ;
			            " conquilhas = "   + EscaparSQL(THIS.this_cConquilhas)       + "," + ;
			            " propriedades = " + EscaparSQL(THIS.this_cPropriedades)     + "," + ;
			            " cravcers = "     + FormatarNumeroSQL(THIS.this_nCravcers)  + ","

			loc_cSet  = loc_cSet + ;
			            " pcuss = "        + FormatarNumeroSQL(THIS.this_nPcuss)     + "," + ;
			            " pvens = "        + FormatarNumeroSQL(THIS.this_nPvens)     + "," + ;
			            " pvideals = "     + FormatarNumeroSQL(THIS.this_nPvideals)  + "," + ;
			            " precode = "      + FormatarNumeroSQL(THIS.this_nPrecode)   + "," + ;
			            " custofs = "      + FormatarNumeroSQL(THIS.this_nCustofs)   + "," + ;
			            " custocp = "      + FormatarNumeroSQL(THIS.this_nCustocp)   + "," + ;
			            " valors = "       + FormatarNumeroSQL(THIS.this_nValors)    + "," + ;
			            " markupa = "      + FormatarNumeroSQL(THIS.this_nMarkupa)   + "," + ;
			            " margems = "      + FormatarNumeroSQL(THIS.this_nMargems)   + "," + ;
			            " fcustos = "      + FormatarNumeroSQL(THIS.this_nFcustos)   + "," + ;
			            " fvendas = "      + FormatarNumeroSQL(THIS.this_nFvendas)   + "," + ;
			            " fatuals = "      + FormatarNumeroSQL(THIS.this_nFatuals)   + "," + ;
			            " fideals = "      + FormatarNumeroSQL(THIS.this_nFideals)   + "," + ;
			            " cotacalcp = "    + FormatarNumeroSQL(THIS.this_nCotacalcp) + ","

			loc_cSet  = loc_cSet + ;
			            " moecs = "        + EscaparSQL(THIS.this_cMoecs)            + "," + ;
			            " moecusfs = "     + EscaparSQL(THIS.this_cMoecusfs)         + "," + ;
			            " moedas = "       + EscaparSQL(THIS.this_cMoedas)           + "," + ;
			            " moepcs = "       + EscaparSQL(THIS.this_cMoepcs)           + "," + ;
			            " moepvs = "       + EscaparSQL(THIS.this_cMoepvs)           + "," + ;
			            " moevs = "        + EscaparSQL(THIS.this_cMoevs)            + ","

			loc_cSet  = loc_cSet + ;
			            " clfiscals = "    + EscaparSQL(THIS.this_cClfiscals)        + "," + ;
			            " sittricms = "    + EscaparSQL(THIS.this_cSittricms)        + "," + ;
			            " icms = "         + FormatarNumeroSQL(THIS.this_nIcms)      + "," + ;
			            " aliqipis = "     + FormatarNumeroSQL(THIS.this_nAliqipis)  + "," + ;
			            " ipis = "         + EscaparSQL(THIS.this_cIpis)             + "," + ;
			            " tptribs = "      + EscaparSQL(THIS.this_cTptribs)          + "," + ;
			            " origmercs = "    + EscaparSQL(THIS.this_cOrigmercs)        + "," + ;
			            " extipi = "       + EscaparSQL(THIS.this_cExtipi)           + "," + ;
			            " mercs = "        + EscaparSQL(THIS.this_cMercs)            + "," + ;
			            " descecfs = "     + EscaparSQL(THIS.this_cDescecfs)         + "," + ;
			            " codgarras = "    + EscaparSQL(THIS.this_cCodgarras)        + "," + ;
			            " mftios = "       + EscaparSQL(THIS.this_cMftios)           + "," + ;
			            " pftios = "       + FormatarNumeroSQL(THIS.this_nPftios)    + "," + ;
			            " cftios = "       + EscaparSQL(THIS.this_cCftios)           + "," + ;
			            " cftiocs = "      + EscaparSQL(THIS.this_cCftiocs)          + "," + ;
			            " pftiocs = "      + FormatarNumeroSQL(THIS.this_nPftiocs)   + "," + ;
			            " codservs = "     + EscaparSQL(THIS.this_cCodservs)         + "," + ;
			            " iats = "         + EscaparSQL(THIS.this_cIats)             + "," + ;
			            " codacbs = "      + EscaparSQL(THIS.this_cCodacbs)          + "," + ;
			            " encargos = "     + FormatarNumeroSQL(THIS.this_nEncargos)  + "," + ;
			            " codfinp = "      + EscaparSQL(THIS.this_cCodfinp)          + "," + ;
			            " codmatp = "      + EscaparSQL(THIS.this_cCodmatp)          + "," + ;
			            " idecpros = "     + EscaparSQL(THIS.this_cIdecpros)         + ","

			loc_cSet  = loc_cSet + ;
			            " pesoms = "       + FormatarNumeroSQL(THIS.this_nPesoms)    + "," + ;
			            " pesobs = "       + FormatarNumeroSQL(THIS.this_nPesobs)    + "," + ;
			            " pesometal = "    + FormatarNumeroSQL(THIS.this_nPesometal) + "," + ;
			            " pesobris = "     + FormatarNumeroSQL(THIS.this_nPesobris)  + "," + ;
			            " pesopdrs = "     + FormatarNumeroSQL(THIS.this_nPesopdrs)  + "," + ;
			            " altura = "       + FormatarNumeroSQL(THIS.this_nAltura)    + "," + ;
			            " largura = "      + FormatarNumeroSQL(THIS.this_nLargura)   + "," + ;
			            " diametro = "     + FormatarNumeroSQL(THIS.this_nDiametro)  + "," + ;
			            " espessura = "    + FormatarNumeroSQL(THIS.this_nEspessura) + "," + ;
			            " compriment = "   + FormatarNumeroSQL(THIS.this_nCompriment)+ "," + ;
			            " varias = "       + FormatarNumeroSQL(THIS.this_nVarias)    + "," + ;
			            " varpesoms = "    + FormatarNumeroSQL(THIS.this_nVarpesoms) + ","

			loc_cSet  = loc_cSet + ;
			            " qmins = "        + FormatarNumeroSQL(THIS.this_nQmins)     + "," + ;
			            " pmins = "        + FormatarNumeroSQL(THIS.this_nPmins)     + "," + ;
			            " qtminfabs = "    + FormatarNumeroSQL(THIS.this_nQtminfabs) + "," + ;
			            " ltminsv = "      + FormatarNumeroSQL(THIS.this_nLtminsv)   + "," + ;
			            " qtdultcomp = "   + FormatarNumeroSQL(THIS.this_nQtdultcomp)+ "," + ;
			            " vultcomps = "    + FormatarNumeroSQL(THIS.this_nVultcomps) + "," + ;
			            " multcomps = "    + EscaparSQL(THIS.this_cMultcomps)        + "," + ;
			            " qtped = "        + FormatarNumeroSQL(THIS.this_nQtped)     + "," + ;
			            " encoms = "       + FormatarNumeroSQL(THIS.this_nEncoms)    + "," + ;
			            " consigs = "      + FormatarNumeroSQL(THIS.this_nConsigs)   + ","

			loc_cSet  = loc_cSet + ;
			            " cunis = "        + EscaparSQL(THIS.this_cCunis)            + "," + ;
			            " cunips = "       + EscaparSQL(THIS.this_cCunips)           + "," + ;
			            " cbars = "        + FormatarNumeroSQL(THIS.this_nCbars)     + "," + ;
			            " ean13 = "        + FormatarNumeroSQL(THIS.this_nEan13)     + "," + ;
			            " skuvtex = "      + EscaparSQL(THIS.this_cSkuvtex)          + ","

			loc_cSet  = loc_cSet + ;
			            " cproeqs = "      + EscaparSQL(THIS.this_cCproeqs)          + "," + ;
			            " qtdcpnts = "     + FormatarNumeroSQL(THIS.this_nQtdcpnts)  + "," + ;
			            " montadescs = "   + FormatarNumeroSQL(THIS.this_nMontadescs)+ "," + ;
			            " digimaxs = "     + FormatarNumeroSQL(THIS.this_nDigimaxs)  + "," + ;
			            " ordcompos = "    + FormatarNumeroSQL(THIS.this_nOrdcompos) + "," + ;
			            " casas = "        + FormatarNumeroSQL(THIS.this_nCasas)     + "," + ;
			            " volumes = "      + FormatarNumeroSQL(THIS.this_nVolumes)   + "," + ;
			            " tamhs = "        + FormatarNumeroSQL(THIS.this_nTamhs)     + "," + ;
			            " tamls = "        + FormatarNumeroSQL(THIS.this_nTamls)     + "," + ;
			            " tamps = "        + FormatarNumeroSQL(THIS.this_nTamps)     + ","

			loc_cSet  = loc_cSet + ;
			            " fabrproprs = "   + FormatarNumeroSQL(THIS.this_nFabrproprs)  + "," + ;
			            " tents = "        + FormatarNumeroSQL(THIS.this_nTents)       + "," + ;
			            " tinsts = "       + FormatarNumeroSQL(THIS.this_nTinsts)      + "," + ;
			            " diasinas = "     + FormatarNumeroSQL(THIS.this_nDiasinas)    + "," + ;
			            " prodvars = "     + FormatarNumeroSQL(THIS.this_nProdvars)    + "," + ;
			            " prodwebs = "     + FormatarNumeroSQL(THIS.this_nProdwebs)    + "," + ;
			            " prodnovo = "     + FormatarNumeroSQL(THIS.this_nProtnovo)    + "," + ;
			            " prodoff = "      + FormatarNumeroSQL(THIS.this_nProdoff)     + "," + ;
			            " prototipo = "    + FormatarNumeroSQL(THIS.this_nPrototipo)   + "," + ;
			            " reposauto = "    + FormatarNumeroSQL(THIS.this_nReposauto)   + "," + ;
			            " procfigjpgs = "  + FormatarNumeroSQL(THIS.this_nProcfigjpgs) + ","

			loc_cSet  = loc_cSet + ;
			            " contaccus = "    + EscaparSQL(THIS.this_cContaccus)         + "," + ;
			            " gruccus = "      + EscaparSQL(THIS.this_cGruccus)           + "," + ;
			            " comis = "        + FormatarNumeroSQL(THIS.this_nComis)      + "," + ;
			            " locals = "       + EscaparSQL(THIS.this_cLocals)            + "," + ;
			            " notas = "        + EscaparSQL(THIS.this_cNotas)             + "," + ;
			            " obsetqs = "      + EscaparSQL(THIS.this_cObsetqs)           + "," + ;
			            " obspeds = "      + EscaparSQL(THIS.this_cObspeds)           + "," + ;
			            " obspes = "       + EscaparSQL(THIS.this_cObspes)            + "," + ;
			            " obsmkt = "       + EscaparSQL(THIS.this_cObsmkt)            + ","

			loc_cSet  = loc_cSet + ;
			            " ativosite = "    + FormatarNumeroSQL(THIS.this_nAtivosite)  + "," + ;
			            " foralinha = "    + FormatarNumeroSQL(THIS.this_nForalinha)  + "," + ;
			            " mostruario = "   + FormatarNumeroSQL(THIS.this_nMostruario) + "," + ;
			            " bestseller = "   + FormatarNumeroSQL(THIS.this_nBestseller) + "," + ;
			            " segfem = "       + FormatarNumeroSQL(THIS.this_nSegfem)     + "," + ;
			            " seginf = "       + FormatarNumeroSQL(THIS.this_nSeginf)     + "," + ;
			            " segkids = "      + FormatarNumeroSQL(THIS.this_nSegkids)    + "," + ;
			            " segmasc = "      + FormatarNumeroSQL(THIS.this_nSegmasc)    + "," + ;
			            " seguni = "       + FormatarNumeroSQL(THIS.this_nSeguni)     + "," + ;
			            " semconsulta = "  + FormatarNumeroSQL(THIS.this_nSemconsulta)+ "," + ;
			            " lancamento = "   + EscaparSQL(THIS.this_cLancamento)        + "," + ;
			            " origemlac = "    + EscaparSQL(THIS.this_cOrigemlac)         + ","

			loc_cSet  = loc_cSet + ;
			            " chkgarvit = "    + FormatarNumeroSQL(THIS.this_nChkgarvit)       + "," + ;
			            " mohs = "         + FormatarNumeroSQL(THIS.this_nMohs)            + "," + ;
			            " refracao = "     + EscaparSQL(THIS.this_cRefracao)               + "," + ;
			            " refracaodp = "   + EscaparSQL(THIS.this_cRefracaodp)             + "," + ;
			            " unidade1 = "     + EscaparSQL(THIS.this_cUnidade1)               + "," + ;
			            " resultado1 = "   + EscaparSQL(THIS.this_cResultado1)             + "," + ;
			            " valorminimo = "  + EscaparSQL(THIS.this_cValorminimo)            + "," + ;
			            " valormaximo = "  + EscaparSQL(THIS.this_cValormaximo)            + "," + ;
			            " metodoreferencia1 = " + EscaparSQL(THIS.this_cMetodoreferencia1) + ","

			loc_cSet  = loc_cSet + ;
			            " flagctabs = "    + IIF(THIS.this_lFlagctabs, "1", "0")      + "," + ;
			            " tcomps = "       + IIF(THIS.this_lTcomps,    "1", "0")      + "," + ;
			            " transps = "      + IIF(THIS.this_lTransps,   "1", "0")      + "," + ;
			            " impetiqs = "     + IIF(THIS.this_lImpetiqs,  "1", "0")      + "," + ;
			            " chkfunds = "     + IIF(THIS.this_lChkfunds,  "1", "0")      + ","

			loc_cSet  = loc_cSet + ;
			            " usuaalts = "     + EscaparSQL(THIS.this_cUsuaalts)               + "," + ;
			            " nidentfixa = "   + FormatarNumeroSQL(THIS.this_nNidentfixa)      + "," + ;
			            " obrtamser = "    + FormatarNumeroSQL(THIS.this_nObrtamser)       + ","

			loc_cSet  = loc_cSet + ;
			            " dtsituas = "     + IIF(EMPTY(THIS.this_dDtsituas),  "NULL", FormatarDataSQL(THIS.this_dDtsituas))   + "," + ;
			            " datas = "        + IIF(EMPTY(THIS.this_dDatas),     "NULL", FormatarDataSQL(THIS.this_dDatas))      + "," + ;
			            " datatrans = "    + IIF(EMPTY(THIS.this_dDatatrans), "NULL", FormatarDataSQL(THIS.this_dDatatrans))  + "," + ;
			            " dtfilms = "      + IIF(EMPTY(THIS.this_dDtfilms),   "NULL", FormatarDataSQL(THIS.this_dDtfilms))    + "," + ;
			            " dtcomps = "      + IIF(EMPTY(THIS.this_dDtcomps),   "NULL", FormatarDataSQL(THIS.this_dDtcomps))    + "," + ;
			            " dtalts = "       + FormatarDataSQL(THIS.this_dDtalts)                                               + "," + ;
			            " dtlacto = "      + IIF(EMPTY(THIS.this_dDtlacto),   "NULL", FormatarDataSQL(THIS.this_dDtlacto))    + "," + ;
			            " fimdtlacto = "   + IIF(EMPTY(THIS.this_dFimdtlacto),"NULL", FormatarDataSQL(THIS.this_dFimdtlacto)) + "," + ;
			            " ultcomps = "     + IIF(EMPTY(THIS.this_dUltcomps),  "NULL", FormatarDataSQL(THIS.this_dUltcomps))   + "," + ;
			            " diasgar = "      + IIF(THIS.this_nDiasgar = 0,      "NULL", FormatarNumeroSQL(THIS.this_nDiasgar))  + "," + ;
			            " codident = "     + IIF(EMPTY(THIS.this_cCodident),  "NULL", EscaparSQL(THIS.this_cCodident))        + ","

			loc_cSet  = loc_cSet + ;
			            " dpro3s = "       + IIF(EMPTY(THIS.this_mDpro3s),    "NULL", EscaparSQL(THIS.this_mDpro3s))     + "," + ;
			            " descfis = "      + IIF(EMPTY(THIS.this_mDescfis),   "NULL", EscaparSQL(THIS.this_mDescfis))    + "," + ;
			            " figjpgs = "      + IIF(EMPTY(THIS.this_mFigjpgs),   "NULL", EscaparSQL(THIS.this_mFigjpgs))    + "," + ;
			            " figjpgs64 = "    + IIF(EMPTY(THIS.this_mFigjpgs64), "NULL", EscaparSQL(THIS.this_mFigjpgs64))  + "," + ;
			            " figtecs = "      + IIF(EMPTY(THIS.this_mFigtecs),   "NULL", EscaparSQL(THIS.this_mFigtecs))    + "," + ;
			            " obscompras = "   + IIF(EMPTY(THIS.this_mObscompras),"NULL", EscaparSQL(THIS.this_mObscompras)) + "," + ;
			            " obsinsp = "      + IIF(EMPTY(THIS.this_mObsinsp),   "NULL", EscaparSQL(THIS.this_mObsinsp))    + "," + ;
			            " dsccompras = "   + IIF(EMPTY(THIS.this_mDsccompras),"NULL", EscaparSQL(THIS.this_mDsccompras)) + "," + ;
			            " mtiposervs = "   + IIF(EMPTY(THIS.this_mMtiposervs),"NULL", EscaparSQL(THIS.this_mMtiposervs))

			loc_cSQL   = "UPDATE SigCdPro SET" + loc_cSet + ;
			             " WHERE cpros = " + EscaparSQL(THIS.this_cCpros)
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult >= 0
				THIS.RegistrarAuditoria("UPDATE")
				THIS.SalvarFaseP()
				THIS.SalvarServicos()
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.Atualizar:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* ExecutarExclusao - DELETE FROM SigCdPro
	*====================================================================
	PROTECTED FUNCTION ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			*-- Excluir sub-tabelas de processos e matrizes antes do produto principal
			SQLEXEC(gnConnHandle, "DELETE FROM SigCdPrf WHERE produtos = " + EscaparSQL(THIS.this_cCpros))
			SQLEXEC(gnConnHandle, "DELETE FROM sigprmtz WHERE cpros = "    + EscaparSQL(THIS.this_cCpros))

			loc_cSQL    = "DELETE FROM SigCdPro WHERE cpros = " + EscaparSQL(THIS.this_cCpros)
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ProdutoBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY
		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* SalvarFaseP - Persiste cursor_4c_GradFase -> SigCdPrf
	*               e cursor_4c_GrdMatrizes -> sigprmtz
	* Chamado por Inserir() e Atualizar() apos sucesso no SigCdPro.
	* Estrategia SigCdPrf: UPDATE linhas existentes (preserva figprocs),
	*   INSERT novas, DELETE removidas.
	* Estrategia sigprmtz: DELETE + INSERT simples.
	*====================================================================
	PROTECTED PROCEDURE SalvarFaseP()
		LOCAL loc_cCpros, loc_nRet, loc_cSQL, loc_cKey, loException
		TRY
			loc_cCpros = ALLTRIM(THIS.this_cCpros)

			*--------------------------------------------------------------
			*-- SigCdPrf: processos de producao (cursor_4c_GradFase)
			*--------------------------------------------------------------
			IF USED("cursor_4c_GradFase")
				*-- Obter cidchaves existentes no banco para este produto
				SET NULL ON
				loc_nRet = SQLEXEC(gnConnHandle, ;
					"SELECT cidchaves FROM SigCdPrf WHERE produtos = " + EscaparSQL(loc_cCpros), ;
					"cursor_4c_PrfExist")
				SET NULL OFF
				IF loc_nRet < 0
					IF USED("cursor_4c_PrfExist")
						USE IN cursor_4c_PrfExist
					ENDIF
					CREATE CURSOR cursor_4c_PrfExist (cidchaves C(20))
				ENDIF

				*-- Coletar cidchaves dos registros nao-deletados do cursor
				LOCAL loc_cKeysAtivos
				loc_cKeysAtivos = ","
				SELECT cursor_4c_GradFase
				SCAN
					loc_cKeysAtivos = loc_cKeysAtivos + ALLTRIM(cursor_4c_GradFase.cidchaves) + ","
				ENDSCAN

				*-- INSERT/UPDATE linhas do cursor (SCAN ignora registros deletados)
				SELECT cursor_4c_GradFase
				SCAN
					loc_cKey = ALLTRIM(cursor_4c_GradFase.cidchaves)
					SELECT cursor_4c_PrfExist
					LOCATE FOR ALLTRIM(cursor_4c_PrfExist.cidchaves) = loc_cKey
					IF FOUND()
						*-- Linha existente: UPDATE (preserva figprocs e etiquetas)
						loc_cSQL = "UPDATE SigCdPrf SET" + ;
							" ordems   = " + TRANSFORM(cursor_4c_GradFase.ordems)             + "," + ;
							" grupos   = " + EscaparSQL(ALLTRIM(cursor_4c_GradFase.grupos))   + "," + ;
							" minutos  = " + TRANSFORM(cursor_4c_GradFase.minutos)            + "," + ;
							" uniprdts = " + EscaparSQL(ALLTRIM(cursor_4c_GradFase.uniprdts)) + "," + ;
							" matprdts = " + EscaparSQL(ALLTRIM(cursor_4c_GradFase.matprdts)) + "," + ;
							" obs      = " + IIF(EMPTY(cursor_4c_GradFase.obs), "NULL", ;
								EscaparSQL(ALLTRIM(cursor_4c_GradFase.obs))) + ;
							" WHERE cidchaves = " + EscaparSQL(loc_cKey)
					ELSE
						*-- Linha nova: INSERT com figprocs NULL
						loc_cSQL = "INSERT INTO SigCdPrf" + ;
							" (produtos, ordems, grupos, etiquetas, ordem2, cidchaves," + ;
							"  minutos, uniprdts, matprdts, obs)" + ;
							" VALUES (" + ;
							EscaparSQL(loc_cCpros)                                             + "," + ;
							TRANSFORM(cursor_4c_GradFase.ordems)                               + "," + ;
							EscaparSQL(ALLTRIM(cursor_4c_GradFase.grupos))                     + "," + ;
							"0,0," + ;
							EscaparSQL(loc_cKey)                                               + "," + ;
							TRANSFORM(cursor_4c_GradFase.minutos)                              + "," + ;
							EscaparSQL(ALLTRIM(cursor_4c_GradFase.uniprdts))                   + "," + ;
							EscaparSQL(ALLTRIM(cursor_4c_GradFase.matprdts))                   + "," + ;
							IIF(EMPTY(cursor_4c_GradFase.obs), "NULL", ;
								EscaparSQL(ALLTRIM(cursor_4c_GradFase.obs))) + ")"
					ENDIF
					SELECT cursor_4c_GradFase
					SQLEXEC(gnConnHandle, loc_cSQL)
				ENDSCAN

				*-- DELETE linhas removidas (em DB mas nao no cursor ativo)
				IF USED("cursor_4c_PrfExist") AND RECCOUNT("cursor_4c_PrfExist") > 0
					SELECT cursor_4c_PrfExist
					SCAN
						loc_cKey = ALLTRIM(cursor_4c_PrfExist.cidchaves)
						IF !( ("," + loc_cKey + ",") $ loc_cKeysAtivos )
							SQLEXEC(gnConnHandle, ;
								"DELETE FROM SigCdPrf WHERE cidchaves = " + EscaparSQL(loc_cKey))
						ENDIF
					ENDSCAN
				ENDIF

				IF USED("cursor_4c_PrfExist")
					USE IN cursor_4c_PrfExist
				ENDIF
			ENDIF

			*--------------------------------------------------------------
			*-- sigprmtz: matrizes (cursor_4c_GrdMatrizes) — DELETE + INSERT simples
			*--------------------------------------------------------------
			IF USED("cursor_4c_GrdMatrizes")
				SQLEXEC(gnConnHandle, ;
					"DELETE FROM sigprmtz WHERE cpros = " + EscaparSQL(loc_cCpros))

				SELECT cursor_4c_GrdMatrizes
				SCAN
					IF !EMPTY(ALLTRIM(cursor_4c_GrdMatrizes.cmats))
						loc_cSQL = "INSERT INTO sigprmtz (cidchaves, cmats, cpros, qtds) VALUES (" + ;
							EscaparSQL(ALLTRIM(cursor_4c_GrdMatrizes.cidchaves)) + "," + ;
							EscaparSQL(ALLTRIM(cursor_4c_GrdMatrizes.cmats))     + "," + ;
							EscaparSQL(loc_cCpros)                               + "," + ;
							TRANSFORM(cursor_4c_GrdMatrizes.qtds)                + ")"
						SQLEXEC(gnConnHandle, loc_cSQL)
					ENDIF
				ENDSCAN
			ENDIF

		CATCH TO loException
			MsgErro("Erro ao salvar processos/matrizes:" + CHR(13) + loException.Message + ;
				CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
				"ProdutoBO.SalvarFaseP")
		ENDTRY
	ENDPROC

	*====================================================================
	* SalvarServicos - Persiste cursor_4c_GrdServico -> SigSerPr
	* Estrategia: DELETE todos do produto + INSERT novos com Marcas=1
	* Chamado por Inserir() e Atualizar() apos sucesso em SigCdPro.
	*====================================================================
	PROTECTED PROCEDURE SalvarServicos()
		LOCAL loc_cCpros, loc_cCods, loc_cIdChaves, loc_cSQL, loException
		TRY
			loc_cCpros = ALLTRIM(THIS.this_cCpros)

			*-- Remover associacoes anteriores do produto
			SQLEXEC(gnConnHandle, "DELETE FROM SigSerPr WHERE cpros = " + EscaparSQL(loc_cCpros))

			*-- Inserir servicos marcados (Marcas=1) do cursor de tela
			IF USED("cursor_4c_GrdServico")
				SELECT cursor_4c_GrdServico
				GO TOP
				SCAN FOR cursor_4c_GrdServico.Marcas = 1
					loc_cCods     = ALLTRIM(cursor_4c_GrdServico.Cods)
					loc_cIdChaves = fUniqueIds()
					loc_cSQL      = "INSERT INTO SigSerPr (cidchaves, cods, cpros) VALUES (" + ;
					               EscaparSQL(loc_cIdChaves) + ", " + ;
					               EscaparSQL(loc_cCods)     + ", " + ;
					               EscaparSQL(loc_cCpros)    + ")"
					SQLEXEC(gnConnHandle, loc_cSQL)
				ENDSCAN
			ENDIF

		CATCH TO loException
			MsgErro("Erro ao salvar Servi" + CHR(231) + "os:" + CHR(13) + ;
				loException.Message + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo), ;
				"ProdutoBO.SalvarServicos")
		ENDTRY
	ENDPROC

ENDDEFINE
