*====================================================================
* ProdutoBO.prg
*
* Business Object para Cadastro de Produtos
* Tabela principal: SigCdPro
* Herda de: BusinessBase
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

    *-- Controle interno (nao sao colunas da tabela)
    this_cChaveOriginal      = ""   && cpros como veio do banco (WHERE do UPDATE/DELETE)
    this_cCampoFoco          = ""   && campo que o form deve focar quando a validacao recusa
    this_cPaginaFoco         = ""   && pagina desse campo: DADOS / FISCAL / COMPOSICAO
    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPro"
            THIS.this_cCampoChave = "cpros"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "ProdutoBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave usada pelo LogAuditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCpros, ""))
    ENDPROC

    *====================================================================
    * ObterChaveGravacao - Chave usada no WHERE de UPDATE / DELETE
    *
    * Enquanto o registro nao foi carregado do banco (INCLUIR) a chave
    * original esta vazia; nesse caso vale o codigo corrente.
    *====================================================================
    PROTECTED PROCEDURE ObterChaveGravacao()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(NVL(THIS.this_cChaveOriginal, ""))
        IF EMPTY(loc_cChave)
            loc_cChave = ALLTRIM(NVL(THIS.this_cCpros, ""))
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *====================================================================
    * LimparDados - Zera todas as propriedades (usado no INCLUIR)
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()

            THIS.this_cCpros              = ""
            THIS.this_nIdpro              = 0
            THIS.this_cCodident           = ""
            THIS.this_cDpros              = ""
            THIS.this_cDpro2s             = ""
            THIS.this_mDpro3s             = ""
            THIS.this_cCgrus              = ""
            THIS.this_cSgrus              = ""
            THIS.this_cLinhas             = ""
            THIS.this_cColecoes           = ""
            THIS.this_cConjunts           = ""
            THIS.this_cTipos              = ""
            THIS.this_cStatus             = ""
            THIS.this_nSituas             = 0
            THIS.this_dDtsituas           = {}
            THIS.this_cCclass             = ""
            THIS.this_cNivelqs            = ""
            THIS.this_cCategoria          = ""
            THIS.this_cCodctgsite         = ""
            THIS.this_cCoddptsite         = ""
            THIS.this_cCodmacro           = ""
            THIS.this_cIfors              = ""
            THIS.this_cReffs              = ""
            THIS.this_cCvens              = ""
            THIS.this_cCodcors            = ""
            THIS.this_cCodtams            = ""
            THIS.this_cMatprincs          = ""
            THIS.this_cMetals             = ""
            THIS.this_cTeors              = ""
            THIS.this_cCompos             = ""
            THIS.this_cConquilhas         = ""
            THIS.this_cPropriedades       = ""
            THIS.this_nCravcers           = 0
            THIS.this_nPcuss              = 0
            THIS.this_nPvens              = 0
            THIS.this_nPvideals           = 0
            THIS.this_nPrecode            = 0
            THIS.this_nCustofs            = 0
            THIS.this_nCustocp            = 0
            THIS.this_nValors             = 0
            THIS.this_nMarkupa            = 0
            THIS.this_nMargems            = 0
            THIS.this_nFcustos            = 0
            THIS.this_nFvendas            = 0
            THIS.this_nFatuals            = 0
            THIS.this_nFideals            = 0
            THIS.this_nCotacalcp          = 0
            THIS.this_cMoecs              = ""
            THIS.this_cMoecusfs           = ""
            THIS.this_cMoedas             = ""
            THIS.this_cMoepcs             = ""
            THIS.this_cMoepvs             = ""
            THIS.this_cMoevs              = ""
            THIS.this_cClfiscals          = ""
            THIS.this_cSittricms          = ""
            THIS.this_nIcms               = 0
            THIS.this_nAliqipis           = 0
            THIS.this_cIpis               = ""
            THIS.this_cTptribs            = ""
            THIS.this_cOrigmercs          = ""
            THIS.this_cExtipi             = ""
            THIS.this_cMercs              = ""
            THIS.this_cDescecfs           = ""
            THIS.this_cCodgarras          = ""
            THIS.this_cMftios             = ""
            THIS.this_nPftios             = 0
            THIS.this_cCftios             = ""
            THIS.this_cCftiocs            = ""
            THIS.this_nPftiocs            = 0
            THIS.this_cCodservs           = ""
            THIS.this_cIats               = ""
            THIS.this_cCodacbs            = ""
            THIS.this_nEncargos           = 0
            THIS.this_cCodfinp            = ""
            THIS.this_cCodmatp            = ""
            THIS.this_cIdecpros           = ""
            THIS.this_nPesoms             = 0
            THIS.this_nPesobs             = 0
            THIS.this_nPesometal          = 0
            THIS.this_nPesobris           = 0
            THIS.this_nPesopdrs           = 0
            THIS.this_nAltura             = 0
            THIS.this_nLargura            = 0
            THIS.this_nDiametro           = 0
            THIS.this_nEspessura          = 0
            THIS.this_nCompriment         = 0
            THIS.this_nVarias             = 0
            THIS.this_nVarpesoms          = 0
            THIS.this_nQmins              = 0
            THIS.this_nPmins              = 0
            THIS.this_nQtminfabs          = 0
            THIS.this_nLtminsv            = 0
            THIS.this_nQtdultcomp         = 0
            THIS.this_nVultcomps          = 0
            THIS.this_cMultcomps          = ""
            THIS.this_dUltcomps           = {}
            THIS.this_nQtped              = 0
            THIS.this_nEncoms             = 0
            THIS.this_nConsigs            = 0
            THIS.this_cCunis              = ""
            THIS.this_cCunips             = ""
            THIS.this_nCbars              = 0
            THIS.this_nEan13              = 0
            THIS.this_cSkuvtex            = ""
            THIS.this_cCproeqs            = ""
            THIS.this_nQtdcpnts           = 0
            THIS.this_nMontadescs         = 0
            THIS.this_nDigimaxs           = 0
            THIS.this_nOrdcompos          = 0
            THIS.this_nCasas              = 0
            THIS.this_nVolumes            = 0
            THIS.this_nTamhs              = 0
            THIS.this_nTamls              = 0
            THIS.this_nTamps              = 0
            THIS.this_nFabrproprs         = 0
            THIS.this_nTents              = 0
            THIS.this_nTinsts             = 0
            THIS.this_nDiasinas           = 0
            THIS.this_nProdvars           = 0
            THIS.this_nProdwebs           = 0
            THIS.this_nProtnovo           = 0
            THIS.this_nProdoff            = 0
            THIS.this_nPrototipo          = 0
            THIS.this_nReposauto          = 0
            THIS.this_nProcfigjpgs        = 0
            THIS.this_cContaccus          = ""
            THIS.this_cGruccus            = ""
            THIS.this_nComis              = 0
            THIS.this_cLocals             = ""
            THIS.this_cNotas              = ""
            THIS.this_cObsetqs            = ""
            THIS.this_cObspeds            = ""
            THIS.this_cObspes             = ""
            THIS.this_cObsmkt             = ""
            THIS.this_mObscompras         = ""
            THIS.this_mObsinsp            = ""
            THIS.this_mDsccompras         = ""
            THIS.this_mDescfis            = ""
            THIS.this_mFigjpgs            = ""
            THIS.this_mFigjpgs64          = ""
            THIS.this_mFigtecs            = ""
            THIS.this_mMtiposervs         = ""
            THIS.this_nAtivosite          = 0
            THIS.this_nForalinha          = 0
            THIS.this_nMostruario         = 0
            THIS.this_nBestseller         = 0
            THIS.this_nSegfem             = 0
            THIS.this_nSeginf             = 0
            THIS.this_nSegkids            = 0
            THIS.this_nSegmasc            = 0
            THIS.this_nSeguni             = 0
            THIS.this_nSemconsulta        = 0
            THIS.this_cLancamento         = ""
            THIS.this_cOrigemlac          = ""
            THIS.this_nDiasgar            = 0
            THIS.this_nChkgarvit          = 0
            THIS.this_nMohs               = 0
            THIS.this_cRefracao           = ""
            THIS.this_cRefracaodp         = ""
            THIS.this_cUnidade1           = ""
            THIS.this_cResultado1         = ""
            THIS.this_cValorminimo        = ""
            THIS.this_cValormaximo        = ""
            THIS.this_cMetodoreferencia1  = ""
            THIS.this_lFlagctabs          = .F.
            THIS.this_lTcomps             = .F.
            THIS.this_lTransps            = .F.
            THIS.this_lImpetiqs           = .F.
            THIS.this_lChkfunds           = .F.
            THIS.this_dDatas              = {}
            THIS.this_dDatatrans          = {}
            THIS.this_dDtfilms            = {}
            THIS.this_dDtincs             = {}
            THIS.this_dDtcomps            = {}
            THIS.this_dDtalts             = {}
            THIS.this_dDtlacto            = {}
            THIS.this_dFimdtlacto         = {}
            THIS.this_cUsuincs            = ""
            THIS.this_cUsuaalts           = ""
            THIS.this_nNidentfixa         = 0
            THIS.this_nObrtamser          = 0


        THIS.this_cChaveOriginal = ""
        THIS.this_cCampoFoco     = ""
        THIS.this_cPaginaFoco    = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Defaults do registro NOVO
    *
    * Transcrito do legado (SIGCDPRO, Grupo_Op.Click / opcao INSERIR):
    *   Replace Datas With DateTime(), DtIncs With DateTime(),
    *           Situas With 1, CravCers With 2, UsuIncs With Usuar,
    *           Consigs With 1 In crSigCdPro
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        DODEFAULT()

        THIS.this_dDatas    = DATETIME()
        THIS.this_dDtincs   = DATETIME()
        THIS.this_nSituas   = 1
        THIS.this_nCravcers = 2
        THIS.this_nConsigs  = 1
        THIS.this_cUsuincs  = THIS.ObterUsuarioLogado()

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterUsuarioLogado - Usuario corrente (vazio quando nao ha sessao)
    *====================================================================
    PROTECTED PROCEDURE ObterUsuarioLogado()
        LOCAL loc_cUsuario
        loc_cUsuario = ""
        IF TYPE("gc_4c_UsuarioLogado") = "C"
            loc_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
        ENDIF
        RETURN loc_cUsuario
    ENDPROC

    *====================================================================
    * AplicarCarimboInclusao - Carimbo de INCLUSAO
    *
    * idpro eh NOT NULL e NAO eh IDENTITY: o legado gera com
    * fGerUniqueKey([IDPRO]) antes de gravar.
    *====================================================================
    PROTECTED PROCEDURE AplicarCarimboInclusao()
        IF THIS.this_nIdpro = 0
            THIS.this_nIdpro = fGerUniqueKey("IDPRO")
        ENDIF

        IF EMPTY(THIS.this_dDatas)
            THIS.this_dDatas = DATETIME()
        ENDIF

        IF EMPTY(THIS.this_dDtincs)
            THIS.this_dDtincs = DATETIME()
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cUsuincs))
            THIS.this_cUsuincs = THIS.ObterUsuarioLogado()
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * AplicarCarimboAlteracao - Carimbo de ALTERACAO
    *
    * dtalts / usuaalts guardam a ultima alteracao do produto e sao lidos
    * pela tela (bloco "Data / Usuario"). Mesma convencao dos demais BOs
    * do projeto (sigprccpBO / sigprimaBO).
    *====================================================================
    PROTECTED PROCEDURE AplicarCarimboAlteracao()
        THIS.this_dDtalts   = DATETIME()
        THIS.this_cUsuaalts = THIS.ObterUsuarioLogado()
        RETURN .T.
    ENDPROC

    *====================================================================
    * CarregarConfigGrupo - Le a configuracao do grupo do produto
    *
    * As obrigatoriedades do cadastro NAO sao fixas: moram no grupo
    * (SigCdGrp). O legado le crSigCdGrp e consulta ObrSGrus, ObrigFiscs,
    * ObrIdecs, ObrCclas, ObrFinps, ObrLinha, ObrColec, ObrDimes, AJPvens
    * e as posicoes de CfgGerGprs.
    *
    * Retorna .T. quando o cursor cursor_4c_CfgGrupo ficou disponivel.
    *====================================================================
    PROTECTED PROCEDURE CarregarConfigGrupo()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_CfgGrupo")
                USE IN cursor_4c_CfgGrupo
            ENDIF

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT cgrus, dgrus, mercs, obrsgrus, obrigfiscs, obridecs," + ;
                    " obrcclas, obrfinps, obrlinha, obrcolec, obrdimes, ajpvens, cfggergprs" + ;
                    " FROM SigCdGrp WHERE cgrus = " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cCgrus), 3))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgGrupo")

                IF loc_nResultado >= 0 AND USED("cursor_4c_CfgGrupo")
                    GO TOP IN cursor_4c_CfgGrupo
                    loc_lSucesso = (RECCOUNT("cursor_4c_CfgGrupo") > 0)
                ELSE
                    THIS.this_cMensagemErro = "Erro ao ler a configura" + CHR(231) + CHR(227) + ;
                        "o do grupo:" + CHR(13) + CapturarErroSQL()
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro, "ProdutoBO.CarregarConfigGrupo")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GerarCompoPorFaixa - Gera "compos" pela tabela de faixas SigCdCpo
    *
    * Transcrito do legado (procedure obrigatorios): quando o grupo exige
    * composicao e o campo esta vazio, o codigo eh deduzido da tabela de
    * intervalos SigCdCpo, cruzando o tipo (MODELO / CLASSIFICA /
    * SUBGRUPO / LINHA) com a faixa de valor (PV = preco de venda,
    * PC = preco de custo).
    *====================================================================
    PROTECTED PROCEDURE GerarCompoPorFaixa()
        LOCAL loc_cSQL, loc_nResultado, loc_cTipo, loc_cValorRef
        LOCAL loc_cChaveTipo, loc_nValorRef, loc_lAchou, loc_oErro
        loc_lAchou = .F.

        TRY
            IF USED("cursor_4c_CpoFaixa")
                USE IN cursor_4c_CpoFaixa
            ENDIF

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT tipos, valors, vltps, fxinis, fxfins, compos" + ;
                    " FROM SigCdCpo WHERE grupos = " + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cCgrus), 10))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpoFaixa")

                IF loc_nResultado >= 0 AND USED("cursor_4c_CpoFaixa")
                    SELECT cursor_4c_CpoFaixa
                    SCAN
                        loc_cTipo     = UPPER(ALLTRIM(NVL(cursor_4c_CpoFaixa.tipos, "")))
                        loc_cValorRef = UPPER(ALLTRIM(NVL(cursor_4c_CpoFaixa.valors, "")))

                        *-- Valor do produto que casa com o tipo da faixa
                        DO CASE
                            CASE loc_cTipo == "MODELO"
                                loc_cChaveTipo = ALLTRIM(THIS.this_cCodfinp)
                            CASE loc_cTipo == "CLASSIFICA"
                                loc_cChaveTipo = ALLTRIM(THIS.this_cCclass)
                            CASE loc_cTipo == "SUBGRUPO"
                                loc_cChaveTipo = ALLTRIM(THIS.this_cSgrus)
                            CASE loc_cTipo == "LINHA"
                                loc_cChaveTipo = ALLTRIM(THIS.this_cLinhas)
                            OTHERWISE
                                loc_cChaveTipo = ""
                        ENDCASE

                        *-- Preco que a faixa compara
                        DO CASE
                            CASE loc_cValorRef == "PV"
                                loc_nValorRef = THIS.this_nPvens
                            CASE loc_cValorRef == "PC"
                                loc_nValorRef = THIS.this_nPcuss
                            OTHERWISE
                                loc_nValorRef = 0
                        ENDCASE

                        loc_lAchou = .T.

                        *-- Sem tipo declarado a linha nao filtra por tipo
                        IF !EMPTY(loc_cTipo) AND ;
                           !(loc_cChaveTipo == ALLTRIM(NVL(cursor_4c_CpoFaixa.vltps, "")))
                            loc_lAchou = .F.
                        ENDIF

                        *-- Sem faixa declarada a linha nao filtra por valor
                        IF loc_lAchou AND !EMPTY(loc_cValorRef)
                            IF !(NVL(cursor_4c_CpoFaixa.fxinis, 0) <= loc_nValorRef AND ;
                                 NVL(cursor_4c_CpoFaixa.fxfins, 0) > loc_nValorRef)
                                loc_lAchou = .F.
                            ENDIF
                        ENDIF

                        IF loc_lAchou
                            THIS.this_cCompos = ALLTRIM(NVL(cursor_4c_CpoFaixa.compos, ""))
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_CpoFaixa")
                    USE IN cursor_4c_CpoFaixa
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            *-- Regra #9: CATCH nunca silencioso.
            MostrarErro(loc_oErro, "ProdutoBO.GerarCompoPorFaixa")
            loc_lAchou = .F.
        ENDTRY

        RETURN loc_lAchou
    ENDPROC

    *====================================================================
    * ValidarDados - Obrigatoriedades do cadastro
    *
    * Transcricao da PROCEDURE obrigatorios do SIGCDPRO legado. As regras
    * NAO sao fixas: vem do GRUPO do produto (SigCdGrp).
    * A navegacao (ActivePage / SetFocus) do legado vira o par
    * this_cPaginaFoco / this_cCampoFoco, que o formulario usa para
    * posicionar o cursor sem acoplar o BO a tela.
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_cCampo, loc_nMinimo, loc_oErro
        LOCAL loc_nObrSGrus, loc_nObrigFiscs, loc_nObrIdecs, loc_nObrCclas
        LOCAL loc_nObrFinps, loc_nObrLinha, loc_nObrColec, loc_nObrDimes
        LOCAL loc_nAJPvens, loc_cCfg

        loc_lValido             = .T.
        loc_cCfg                = SPACE(200)
        loc_nObrSGrus           = 0
        loc_nObrigFiscs         = 0
        loc_nObrIdecs           = 0
        loc_nObrCclas           = 0
        loc_nObrFinps           = 0
        loc_nObrLinha           = 0
        loc_nObrColec           = 0
        loc_nObrDimes           = 0
        loc_nAJPvens            = 0
        THIS.this_cCampoFoco    = ""
        THIS.this_cPaginaFoco   = ""
        THIS.this_cMensagemErro = ""

        TRY
            *-- Codigo do produto
            IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCpros))
                THIS.this_cMensagemErro = "O C" + CHR(243) + "digo do Produto Necessita Ser Preenchido!!!"
                THIS.this_cPaginaFoco   = "DADOS"
                THIS.this_cCampoFoco    = "txt_4c_Cpro"
                loc_lValido = .F.
            ENDIF

            *-- Grupo do produto: o legado exige o grupo antes de qualquer campo
            IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCgrus))
                THIS.this_cMensagemErro = "Informe o Grupo de Produto!!!"
                THIS.this_cPaginaFoco   = "DADOS"
                THIS.this_cCampoFoco    = "txt_4c_Cgru"
                loc_lValido = .F.
            ENDIF

            *-- Configuracao do grupo: sem ela nao ha como aplicar as regras
            IF loc_lValido
                IF THIS.CarregarConfigGrupo()
                    loc_nObrSGrus   = NVL(cursor_4c_CfgGrupo.obrsgrus,   0)
                    loc_nObrigFiscs = NVL(cursor_4c_CfgGrupo.obrigfiscs, 0)
                    loc_nObrIdecs   = NVL(cursor_4c_CfgGrupo.obridecs,   0)
                    loc_nObrCclas   = NVL(cursor_4c_CfgGrupo.obrcclas,   0)
                    loc_nObrFinps   = NVL(cursor_4c_CfgGrupo.obrfinps,   0)
                    loc_nObrLinha   = NVL(cursor_4c_CfgGrupo.obrlinha,   0)
                    loc_nObrColec   = NVL(cursor_4c_CfgGrupo.obrcolec,   0)
                    loc_nObrDimes   = NVL(cursor_4c_CfgGrupo.obrdimes,   0)
                    loc_nAJPvens    = NVL(cursor_4c_CfgGrupo.ajpvens,    0)
                    loc_cCfg        = PADR(NVL(cursor_4c_CfgGrupo.cfggergprs, ""), 200)
                ELSE
                    THIS.this_cMensagemErro = "Grupo de Produto n" + CHR(227) + "o encontrado!!!"
                    THIS.this_cPaginaFoco   = "DADOS"
                    THIS.this_cCampoFoco    = "txt_4c_Cgru"
                    loc_lValido = .F.
                ENDIF
            ENDIF

            *-- Subgrupo Obrigatorio
            IF loc_lValido AND loc_nObrSGrus = 1 AND EMPTY(ALLTRIM(THIS.this_cSgrus))
                THIS.this_cMensagemErro = "O Subgrupo Necessita Ser Preenchido Neste Grupo!!!"
                THIS.this_cPaginaFoco   = "DADOS"
                THIS.this_cCampoFoco    = "txt_4c_CSGru"
                loc_lValido = .F.
            ENDIF

            *-- Classificacao Fiscal Obrigatoria: o legado descarta os pontos
            IF loc_lValido AND loc_nObrigFiscs = 1
                loc_cCampo = ALLTRIM(STRTRAN(THIS.this_cClfiscals, ".", ""))
                IF EMPTY(loc_cCampo)
                    THIS.this_cMensagemErro = "A Classifica" + CHR(231) + CHR(227) + ;
                        "o Fiscal Necessita Ser Preenchida Neste Grupo!!!"
                    THIS.this_cPaginaFoco   = "FISCAL"
                    THIS.this_cCampoFoco    = "txt_4c_Clfiscal"
                    loc_lValido = .F.
                ENDIF
            ENDIF

            *-- Identificador Obrigatorio
            IF loc_lValido AND loc_nObrIdecs = 1 AND EMPTY(ALLTRIM(THIS.this_cIdecpros))
                THIS.this_cMensagemErro = "O Identificador Necessita Ser Preenchido Neste Grupo!!!"
                THIS.this_cPaginaFoco   = "DADOS"
                THIS.this_cCampoFoco    = "txt_4c_IdeCPros"
                loc_lValido = .F.
            ENDIF

            *-- Classificacao Obrigatoria
            IF loc_lValido AND loc_nObrCclas = 1 AND EMPTY(ALLTRIM(THIS.this_cCclass))
                THIS.this_cMensagemErro = "A Classifica" + CHR(231) + CHR(227) + ;
                    "o Necessita Ser Preenchida Neste Grupo!!!"
                THIS.this_cPaginaFoco   = "DADOS"
                THIS.this_cCampoFoco    = "txt_4c_Class"
                loc_lValido = .F.
            ENDIF

            *-- Modelo Obrigatorio
            IF loc_lValido AND loc_nObrFinps = 1 AND EMPTY(ALLTRIM(THIS.this_cCodfinp))
                THIS.this_cMensagemErro = "O Modelo Necessita Ser Preenchido Neste Grupo!!!"
                THIS.this_cPaginaFoco   = "DADOS"
                THIS.this_cCampoFoco    = "txt_4c_CodFinP"
                loc_lValido = .F.
            ENDIF

            *-- Linha Obrigatoria
            IF loc_lValido AND loc_nObrLinha = 1 AND EMPTY(ALLTRIM(THIS.this_cLinhas))
                THIS.this_cMensagemErro = "A Linha Necessita Ser Preenchida Neste Grupo!!!"
                THIS.this_cPaginaFoco   = "DADOS"
                THIS.this_cCampoFoco    = "txt_4c_Lin"
                loc_lValido = .F.
            ENDIF

            *-- Grupo de Venda Obrigatorio
            IF loc_lValido AND loc_nObrColec = 1 AND EMPTY(ALLTRIM(THIS.this_cColecoes))
                THIS.this_cMensagemErro = "O Grupo de Venda Necessita Ser Preenchido Neste Grupo!!!"
                THIS.this_cPaginaFoco   = "DADOS"
                THIS.this_cCampoFoco    = "txt_4c_Col"
                loc_lValido = .F.
            ENDIF

            *-- Dimensoes Obrigatorias: o legado exige ao menos UMA preenchida
            IF loc_lValido AND loc_nObrDimes = 1 AND ;
               EMPTY(THIS.this_nTamps) AND EMPTY(THIS.this_nTamhs) AND EMPTY(THIS.this_nTamls)
                THIS.this_cMensagemErro = "Dimens" + CHR(245) + ;
                    "es Necessitam Ser Preenchidas Neste Grupo!!!"
                THIS.this_cPaginaFoco   = "DADOS"
                THIS.this_cCampoFoco    = "txt_4c_Dimensao"
                loc_lValido = .F.
            ENDIF

            *-- Cor Obrigatoria
            IF loc_lValido AND loc_nAJPvens = 1 AND EMPTY(ALLTRIM(THIS.this_cCodcors))
                THIS.this_cMensagemErro = "A Cor Necessita Ser Preenchida Neste Grupo!!!"
                THIS.this_cPaginaFoco   = "DADOS"
                THIS.this_cCampoFoco    = "txt_4c_Cor"
                loc_lValido = .F.
            ENDIF

            *-- Produto Equivalente Obrigatorio: CfgGerGprs posicao 1
            IF loc_lValido AND !EMPTY(SUBSTR(loc_cCfg, 1, 1)) AND ;
               EMPTY(ALLTRIM(THIS.this_cCproeqs))
                THIS.this_cMensagemErro = "O Produto Equivalente Necessita Ser Preenchido Neste Grupo!!!"
                THIS.this_cPaginaFoco   = "DADOS"
                THIS.this_cCampoFoco    = "txt_4c_CProEq"
                loc_lValido = .F.
            ENDIF

            *-- Tamanho minimo da Ref. do Fornecedor: CfgGerGprs posicoes 3-4
            IF loc_lValido
                loc_nMinimo = INT(VAL(SUBSTR(loc_cCfg, 3, 2)))
                IF loc_nMinimo > 0 AND LEN(ALLTRIM(THIS.this_cReffs)) < loc_nMinimo
                    THIS.this_cMensagemErro = "A Ref. do Fornecedor Necessita Ser Preenchida" + CHR(13) + ;
                        "Com No M" + CHR(237) + "nimo " + ALLTRIM(STR(loc_nMinimo, 12, 0)) + ;
                        " Caracteres Neste Grupo!!!"
                    THIS.this_cPaginaFoco   = "DADOS"
                    THIS.this_cCampoFoco    = "txt_4c_Refs"
                    loc_lValido = .F.
                ENDIF
            ENDIF

            *-- Tamanho minimo da Obs. de Componente: CfgGerGprs posicoes 7-8
            IF loc_lValido
                loc_nMinimo = INT(VAL(SUBSTR(loc_cCfg, 7, 2)))
                IF loc_nMinimo > 0 AND LEN(ALLTRIM(THIS.this_cObsetqs)) < loc_nMinimo
                    THIS.this_cMensagemErro = "A Obs. do Componente Necessita Ser Preenchida" + CHR(13) + ;
                        "Com No M" + CHR(237) + "nimo " + ALLTRIM(STR(loc_nMinimo, 12, 0)) + ;
                        " Caracteres Neste Grupo!!!"
                    THIS.this_cPaginaFoco   = "DADOS"
                    THIS.this_cCampoFoco    = "txt_4c_Obs3"
                    loc_lValido = .F.
                ENDIF
            ENDIF

            *-- Composicao Obrigatoria: CfgGerGprs posicao 16
            IF loc_lValido AND INT(VAL(SUBSTR(loc_cCfg, 16, 1))) = 1 AND ;
               EMPTY(ALLTRIM(THIS.this_cCompos))
                *-- Antes de recusar, o legado tenta deduzir pela faixa de valores
                THIS.GerarCompoPorFaixa()

                IF EMPTY(ALLTRIM(THIS.this_cCompos))
                    THIS.this_cMensagemErro = "A Composi" + CHR(231) + CHR(227) + ;
                        "o do Produto Necessita Ser Preenchida Neste Grupo!!!"
                    THIS.this_cPaginaFoco   = "COMPOSICAO"
                    THIS.this_cCampoFoco    = "txt_4c_Compos"
                    loc_lValido = .F.
                ENDIF
            ENDIF

            *-- Material Principal Obrigatorio: CfgGerGprs posicao 39
            IF loc_lValido AND INT(VAL(SUBSTR(loc_cCfg, 39, 1))) = 1 AND ;
               EMPTY(ALLTRIM(THIS.this_cMatprincs))
                THIS.this_cMensagemErro = "Material Principal necessita ser preenchido neste grupo!!!"
                THIS.this_cPaginaFoco   = "COMPOSICAO"
                THIS.this_cCampoFoco    = "txt_4c_MatP"
                loc_lValido = .F.
            ENDIF

            IF USED("cursor_4c_CfgGrupo")
                USE IN cursor_4c_CfgGrupo
            ENDIF
        CATCH TO loc_oErro
            *-- Regra #9 / #20: a mensagem NAO fica muda - BusinessBase.Salvar
            *-- chama ExibirFalha() quando ValidarDados devolve .F.
            THIS.this_cMensagemErro = "Erro ao validar o produto: " + loc_oErro.Message
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Le o registro do cursor para as propriedades
    *
    * Regra #9 do CLAUDE.md: usa SELECT (par_cAliasCursor) ANTES de ler os
    * campos. Acessar campo eh sintaxe invalida no VFP9.
    * Os nomes de campo sao os da COLUNA REAL de SigCdPro (o SELECT * do
    * CarregarPorCodigo devolve o cursor com a grafia do banco).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCpros              = ALLTRIM(NVL(cpros, ""))
                THIS.this_nIdpro              = NVL(idpro, 0)
                THIS.this_cCodident           = ALLTRIM(NVL(codident, ""))
                THIS.this_cDpros              = ALLTRIM(NVL(dpros, ""))
                THIS.this_cDpro2s             = ALLTRIM(NVL(dpro2s, ""))
                THIS.this_mDpro3s             = ALLTRIM(NVL(dpro3s, ""))
                THIS.this_cCgrus              = ALLTRIM(NVL(cgrus, ""))
                THIS.this_cSgrus              = ALLTRIM(NVL(sgrus, ""))
                THIS.this_cLinhas             = ALLTRIM(NVL(linhas, ""))
                THIS.this_cColecoes           = ALLTRIM(NVL(colecoes, ""))
                THIS.this_cConjunts           = ALLTRIM(NVL(conjunts, ""))
                THIS.this_cTipos              = ALLTRIM(NVL(tipos, ""))
                THIS.this_cStatus             = ALLTRIM(NVL(status, ""))
                THIS.this_nSituas             = NVL(situas, 0)
                THIS.this_dDtsituas           = NVL(dtsituas, {})
                THIS.this_cCclass             = ALLTRIM(NVL(cclass, ""))
                THIS.this_cNivelqs            = ALLTRIM(NVL(nivelqs, ""))
                THIS.this_cCategoria          = ALLTRIM(NVL(categoria, ""))
                THIS.this_cCodctgsite         = ALLTRIM(NVL(codctgsite, ""))
                THIS.this_cCoddptsite         = ALLTRIM(NVL(coddptsite, ""))
                THIS.this_cCodmacro           = ALLTRIM(NVL(codmacro, ""))
                THIS.this_cIfors              = ALLTRIM(NVL(ifors, ""))
                THIS.this_cReffs              = ALLTRIM(NVL(reffs, ""))
                THIS.this_cCvens              = ALLTRIM(NVL(cvens, ""))
                THIS.this_cCodcors            = ALLTRIM(NVL(codcors, ""))
                THIS.this_cCodtams            = ALLTRIM(NVL(codtams, ""))
                THIS.this_cMatprincs          = ALLTRIM(NVL(matprincs, ""))
                THIS.this_cMetals             = ALLTRIM(NVL(metals, ""))
                THIS.this_cTeors              = ALLTRIM(NVL(teors, ""))
                THIS.this_cCompos             = ALLTRIM(NVL(compos, ""))
                THIS.this_cConquilhas         = ALLTRIM(NVL(conquilhas, ""))
                THIS.this_cPropriedades       = ALLTRIM(NVL(propriedades, ""))
                THIS.this_nCravcers           = NVL(cravcers, 0)
                THIS.this_nPcuss              = NVL(pcuss, 0)
                THIS.this_nPvens              = NVL(pvens, 0)
                THIS.this_nPvideals           = NVL(pvideals, 0)
                THIS.this_nPrecode            = NVL(precode, 0)
                THIS.this_nCustofs            = NVL(custofs, 0)
                THIS.this_nCustocp            = NVL(custocp, 0)
                THIS.this_nValors             = NVL(valors, 0)
                THIS.this_nMarkupa            = NVL(markupa, 0)
                THIS.this_nMargems            = NVL(margems, 0)
                THIS.this_nFcustos            = NVL(fcustos, 0)
                THIS.this_nFvendas            = NVL(fvendas, 0)
                THIS.this_nFatuals            = NVL(fatuals, 0)
                THIS.this_nFideals            = NVL(fideals, 0)
                THIS.this_nCotacalcp          = NVL(cotacalcp, 0)
                THIS.this_cMoecs              = ALLTRIM(NVL(moecs, ""))
                THIS.this_cMoecusfs           = ALLTRIM(NVL(moecusfs, ""))
                THIS.this_cMoedas             = ALLTRIM(NVL(moedas, ""))
                THIS.this_cMoepcs             = ALLTRIM(NVL(moepcs, ""))
                THIS.this_cMoepvs             = ALLTRIM(NVL(moepvs, ""))
                THIS.this_cMoevs              = ALLTRIM(NVL(moevs, ""))
                THIS.this_cClfiscals          = ALLTRIM(NVL(clfiscals, ""))
                THIS.this_cSittricms          = ALLTRIM(NVL(sittricms, ""))
                THIS.this_nIcms               = NVL(icms, 0)
                THIS.this_nAliqipis           = NVL(aliqipis, 0)
                THIS.this_cIpis               = ALLTRIM(NVL(ipis, ""))
                THIS.this_cTptribs            = ALLTRIM(NVL(tptribs, ""))
                THIS.this_cOrigmercs          = ALLTRIM(NVL(origmercs, ""))
                THIS.this_cExtipi             = ALLTRIM(NVL(extipi, ""))
                THIS.this_cMercs              = ALLTRIM(NVL(mercs, ""))
                THIS.this_cDescecfs           = ALLTRIM(NVL(descecfs, ""))
                THIS.this_cCodgarras          = ALLTRIM(NVL(codgarras, ""))
                THIS.this_cMftios             = ALLTRIM(NVL(mftios, ""))
                THIS.this_nPftios             = NVL(pftios, 0)
                THIS.this_cCftios             = ALLTRIM(NVL(cftios, ""))
                THIS.this_cCftiocs            = ALLTRIM(NVL(cftiocs, ""))
                THIS.this_nPftiocs            = NVL(pftiocs, 0)
                THIS.this_cCodservs           = ALLTRIM(NVL(codservs, ""))
                THIS.this_cIats               = ALLTRIM(NVL(iats, ""))
                THIS.this_cCodacbs            = ALLTRIM(NVL(codacbs, ""))
                THIS.this_nEncargos           = NVL(encargos, 0)
                THIS.this_cCodfinp            = ALLTRIM(NVL(codfinp, ""))
                THIS.this_cCodmatp            = ALLTRIM(NVL(codmatp, ""))
                THIS.this_cIdecpros           = ALLTRIM(NVL(idecpros, ""))
                THIS.this_nPesoms             = NVL(pesoms, 0)
                THIS.this_nPesobs             = NVL(pesobs, 0)
                THIS.this_nPesometal          = NVL(pesometal, 0)
                THIS.this_nPesobris           = NVL(pesobris, 0)
                THIS.this_nPesopdrs           = NVL(pesopdrs, 0)
                THIS.this_nAltura             = NVL(altura, 0)
                THIS.this_nLargura            = NVL(largura, 0)
                THIS.this_nDiametro           = NVL(diametro, 0)
                THIS.this_nEspessura          = NVL(espessura, 0)
                THIS.this_nCompriment         = NVL(compriment, 0)
                THIS.this_nVarias             = NVL(varias, 0)
                THIS.this_nVarpesoms          = NVL(varpesoms, 0)
                THIS.this_nQmins              = NVL(qmins, 0)
                THIS.this_nPmins              = NVL(pmins, 0)
                THIS.this_nQtminfabs          = NVL(qtminfabs, 0)
                THIS.this_nLtminsv            = NVL(ltminsv, 0)
                THIS.this_nQtdultcomp         = NVL(qtdultcomp, 0)
                THIS.this_nVultcomps          = NVL(vultcomps, 0)
                THIS.this_cMultcomps          = ALLTRIM(NVL(multcomps, ""))
                THIS.this_dUltcomps           = NVL(ultcomps, {})
                THIS.this_nQtped              = NVL(qtped, 0)
                THIS.this_nEncoms             = NVL(encoms, 0)
                THIS.this_nConsigs            = NVL(consigs, 0)
                THIS.this_cCunis              = ALLTRIM(NVL(cunis, ""))
                THIS.this_cCunips             = ALLTRIM(NVL(cunips, ""))
                THIS.this_nCbars              = NVL(cbars, 0)
                THIS.this_nEan13              = NVL(ean13, 0)
                THIS.this_cSkuvtex            = ALLTRIM(NVL(skuvtex, ""))
                THIS.this_cCproeqs            = ALLTRIM(NVL(cproeqs, ""))
                THIS.this_nQtdcpnts           = NVL(qtdcpnts, 0)
                THIS.this_nMontadescs         = NVL(montadescs, 0)
                THIS.this_nDigimaxs           = NVL(digimaxs, 0)
                THIS.this_nOrdcompos          = NVL(ordcompos, 0)
                THIS.this_nCasas              = NVL(casas, 0)
                THIS.this_nVolumes            = NVL(volumes, 0)
                THIS.this_nTamhs              = NVL(tamhs, 0)
                THIS.this_nTamls              = NVL(tamls, 0)
                THIS.this_nTamps              = NVL(tamps, 0)
                THIS.this_nFabrproprs         = NVL(fabrproprs, 0)
                THIS.this_nTents              = NVL(tents, 0)
                THIS.this_nTinsts             = NVL(tinsts, 0)
                THIS.this_nDiasinas           = NVL(diasinas, 0)
                THIS.this_nProdvars           = NVL(prodvars, 0)
                THIS.this_nProdwebs           = NVL(prodwebs, 0)
                THIS.this_nProtnovo           = NVL(prodnovo, 0)
                THIS.this_nProdoff            = NVL(prodoff, 0)
                THIS.this_nPrototipo          = NVL(prototipo, 0)
                THIS.this_nReposauto          = NVL(reposauto, 0)
                THIS.this_nProcfigjpgs        = NVL(procfigjpgs, 0)
                THIS.this_cContaccus          = ALLTRIM(NVL(contaccus, ""))
                THIS.this_cGruccus            = ALLTRIM(NVL(gruccus, ""))
                THIS.this_nComis              = NVL(comis, 0)
                THIS.this_cLocals             = ALLTRIM(NVL(locals, ""))
                THIS.this_cNotas              = ALLTRIM(NVL(notas, ""))
                THIS.this_cObsetqs            = ALLTRIM(NVL(obsetqs, ""))
                THIS.this_cObspeds            = ALLTRIM(NVL(obspeds, ""))
                THIS.this_cObspes             = ALLTRIM(NVL(obspes, ""))
                THIS.this_cObsmkt             = ALLTRIM(NVL(obsmkt, ""))
                THIS.this_mObscompras         = ALLTRIM(NVL(obscompras, ""))
                THIS.this_mObsinsp            = ALLTRIM(NVL(obsinsp, ""))
                THIS.this_mDsccompras         = ALLTRIM(NVL(dsccompras, ""))
                THIS.this_mDescfis            = ALLTRIM(NVL(descfis, ""))
                THIS.this_mFigjpgs            = ALLTRIM(NVL(figjpgs, ""))
                THIS.this_mFigjpgs64          = ALLTRIM(NVL(figjpgs64, ""))
                THIS.this_mFigtecs            = ALLTRIM(NVL(figtecs, ""))
                THIS.this_mMtiposervs         = ALLTRIM(NVL(mtiposervs, ""))
                THIS.this_nAtivosite          = NVL(ativosite, 0)
                THIS.this_nForalinha          = NVL(foralinha, 0)
                THIS.this_nMostruario         = NVL(mostruario, 0)
                THIS.this_nBestseller         = NVL(bestseller, 0)
                THIS.this_nSegfem             = NVL(segfem, 0)
                THIS.this_nSeginf             = NVL(seginf, 0)
                THIS.this_nSegkids            = NVL(segkids, 0)
                THIS.this_nSegmasc            = NVL(segmasc, 0)
                THIS.this_nSeguni             = NVL(seguni, 0)
                THIS.this_nSemconsulta        = NVL(semconsulta, 0)
                THIS.this_cLancamento         = ALLTRIM(NVL(lancamento, ""))
                THIS.this_cOrigemlac          = ALLTRIM(NVL(origemlac, ""))
                THIS.this_nDiasgar            = NVL(diasgar, 0)
                THIS.this_nChkgarvit          = NVL(chkgarvit, 0)
                THIS.this_nMohs               = NVL(mohs, 0)
                THIS.this_cRefracao           = ALLTRIM(NVL(refracao, ""))
                THIS.this_cRefracaodp         = ALLTRIM(NVL(refracaodp, ""))
                THIS.this_cUnidade1           = ALLTRIM(NVL(unidade1, ""))
                THIS.this_cResultado1         = ALLTRIM(NVL(resultado1, ""))
                THIS.this_cValorminimo        = ALLTRIM(NVL(valorminimo, ""))
                THIS.this_cValormaximo        = ALLTRIM(NVL(valormaximo, ""))
                THIS.this_cMetodoreferencia1  = ALLTRIM(NVL(metodoreferencia1, ""))
                THIS.this_lFlagctabs          = ConverterParaLogico(flagctabs)
                THIS.this_lTcomps             = ConverterParaLogico(tcomps)
                THIS.this_lTransps            = ConverterParaLogico(transps)
                THIS.this_lImpetiqs           = ConverterParaLogico(impetiqs)
                THIS.this_lChkfunds           = ConverterParaLogico(chkfunds)
                THIS.this_dDatas              = NVL(datas, {})
                THIS.this_dDatatrans          = NVL(datatrans, {})
                THIS.this_dDtfilms            = NVL(dtfilms, {})
                THIS.this_dDtincs             = NVL(dtincs, {})
                THIS.this_dDtcomps            = NVL(dtcomps, {})
                THIS.this_dDtalts             = NVL(dtalts, {})
                THIS.this_dDtlacto            = NVL(dtlacto, {})
                THIS.this_dFimdtlacto         = NVL(fimdtlacto, {})
                THIS.this_cUsuincs            = ALLTRIM(NVL(usuincs, ""))
                THIS.this_cUsuaalts           = ALLTRIM(NVL(usuaalts, ""))
                THIS.this_nNidentfixa         = NVL(nidentfixa, 0)
                THIS.this_nObrtamser          = NVL(obrtamser, 0)

                *-- Chave original: o UPDATE/DELETE usam esta copia no WHERE,
                *-- para que renomear o codigo na tela nao perca o registro.
                THIS.this_cChaveOriginal = THIS.this_cCpros

                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de dados do produto n" + CHR(227) + "o est" + CHR(225) + " aberto."
                MsgErro(THIS.this_cMensagemErro, "ProdutoBO.CarregarDoCursor")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro, "ProdutoBO.CarregarDoCursor")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * MontarSQLInclusao - Monta o INSERT completo de SigCdPro
    *
    * Regra #22 do CLAUDE.md: a lista de colunas vem do SCHEMA, nao da
    * tela. SigCdPro tem 181 colunas, quase todas NOT NULL e sem DEFAULT,
    * por isso TODAS entram no INSERT.
    *
    * Fica separado de Inserir() para poder ser conferido sem banco.
    *====================================================================
    PROTECTED PROCEDURE MontarSQLInclusao()
        LOCAL loc_cCampos, loc_cValores
        *-- Lista de colunas: as 181 colunas de SigCdPro. Nenhuma NOT NULL
        *-- fica de fora (regra #22 do CLAUDE.md).
        loc_cCampos = ""
        loc_cCampos = loc_cCampos + "cpros, idpro, codident, dpros, dpro2s, dpro3s, cgrus, sgrus, "
        loc_cCampos = loc_cCampos + "linhas, colecoes, conjunts, tipos, status, situas, dtsituas, cclass, "
        loc_cCampos = loc_cCampos + "nivelqs, categoria, codctgsite, coddptsite, codmacro, ifors, reffs, cvens, "
        loc_cCampos = loc_cCampos + "codcors, codtams, matprincs, metals, teors, compos, conquilhas, propriedades, "
        loc_cCampos = loc_cCampos + "cravcers, pcuss, pvens, pvideals, precode, custofs, custocp, valors, "
        loc_cCampos = loc_cCampos + "markupa, margems, fcustos, fvendas, fatuals, fideals, cotacalcp, moecs, "
        loc_cCampos = loc_cCampos + "moecusfs, moedas, moepcs, moepvs, moevs, clfiscals, sittricms, icms, "
        loc_cCampos = loc_cCampos + "aliqipis, ipis, tptribs, origmercs, extipi, mercs, descecfs, codgarras, "
        loc_cCampos = loc_cCampos + "mftios, pftios, cftios, cftiocs, pftiocs, codservs, iats, codacbs, "
        loc_cCampos = loc_cCampos + "encargos, codfinp, codmatp, idecpros, pesoms, pesobs, pesometal, pesobris, "
        loc_cCampos = loc_cCampos + "pesopdrs, altura, largura, diametro, espessura, compriment, varias, varpesoms, "
        loc_cCampos = loc_cCampos + "qmins, pmins, qtminfabs, ltminsv, qtdultcomp, vultcomps, multcomps, ultcomps, "
        loc_cCampos = loc_cCampos + "qtped, encoms, consigs, cunis, cunips, cbars, ean13, skuvtex, "
        loc_cCampos = loc_cCampos + "cproeqs, qtdcpnts, montadescs, digimaxs, ordcompos, casas, volumes, tamhs, "
        loc_cCampos = loc_cCampos + "tamls, tamps, fabrproprs, tents, tinsts, diasinas, prodvars, prodwebs, "
        loc_cCampos = loc_cCampos + "prodnovo, prodoff, prototipo, reposauto, procfigjpgs, contaccus, gruccus, comis, "
        loc_cCampos = loc_cCampos + "locals, notas, obsetqs, obspeds, obspes, obsmkt, obscompras, obsinsp, "
        loc_cCampos = loc_cCampos + "dsccompras, descfis, figjpgs, figjpgs64, figtecs, mtiposervs, ativosite, foralinha, "
        loc_cCampos = loc_cCampos + "mostruario, bestseller, segfem, seginf, segkids, segmasc, seguni, semconsulta, "
        loc_cCampos = loc_cCampos + "lancamento, origemlac, diasgar, chkgarvit, mohs, refracao, refracaodp, unidade1, "
        loc_cCampos = loc_cCampos + "resultado1, valorminimo, valormaximo, metodoreferencia1, flagctabs, tcomps, transps, impetiqs, "
        loc_cCampos = loc_cCampos + "chkfunds, datas, datatrans, dtfilms, dtincs, dtcomps, dtalts, dtlacto, "
        loc_cCampos = loc_cCampos + "fimdtlacto, usuincs, usuaalts, nidentfixa, obrtamser, "

        *-- Valores, na MESMA ordem das colunas acima.
        loc_cValores = ""
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCpros), 14)) + ", " + FormatarNumeroSQL(THIS.this_nIdpro, 0) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodident), 20)) + ", "   && cpros, idpro, codident
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDpros), 65)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDpro2s), 45)) + ", " + EscaparSQL(THIS.this_mDpro3s) + ", "   && dpros, dpro2s, dpro3s
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCgrus), 3)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cSgrus), 6)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cLinhas), 10)) + ", "   && cgrus, sgrus, linhas
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cColecoes), 10)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cConjunts), 6)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipos), 1)) + ", "   && colecoes, conjunts, tipos
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cStatus), 3)) + ", " + FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + FormatarDataSQL(THIS.this_dDtsituas) + ", "   && status, situas, dtsituas
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCclass), 3)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNivelqs), 10)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCategoria), 6)) + ", "   && cclass, nivelqs, categoria
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodctgsite), 2)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCoddptsite), 2)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodmacro), 6)) + ", "   && codctgsite, coddptsite, codmacro
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIfors), 10)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cReffs), 40)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCvens), 10)) + ", "   && ifors, reffs, cvens
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodcors), 4)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodtams), 4)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMatprincs), 14)) + ", "   && codcors, codtams, matprincs
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMetals), 2)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTeors), 2)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCompos), 30)) + ", "   && metals, teors, compos
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cConquilhas), 10)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cPropriedades), 40)) + ", " + FormatarNumeroSQL(THIS.this_nCravcers, 0) + ", "   && conquilhas, propriedades, cravcers
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nPcuss, 5) + ", " + FormatarNumeroSQL(THIS.this_nPvens, 5) + ", " + FormatarNumeroSQL(THIS.this_nPvideals, 5) + ", "   && pcuss, pvens, pvideals
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nPrecode, 5) + ", " + FormatarNumeroSQL(THIS.this_nCustofs, 3) + ", " + FormatarNumeroSQL(THIS.this_nCustocp, 5) + ", "   && precode, custofs, custocp
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nValors, 2) + ", " + FormatarNumeroSQL(THIS.this_nMarkupa, 3) + ", " + FormatarNumeroSQL(THIS.this_nMargems, 6) + ", "   && valors, markupa, margems
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nFcustos, 5) + ", " + FormatarNumeroSQL(THIS.this_nFvendas, 3) + ", " + FormatarNumeroSQL(THIS.this_nFatuals, 5) + ", "   && fcustos, fvendas, fatuals
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nFideals, 5) + ", " + FormatarNumeroSQL(THIS.this_nCotacalcp, 6) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoecs), 3)) + ", "   && fideals, cotacalcp, moecs
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoecusfs), 3)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoedas), 3)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoepcs), 3)) + ", "   && moecusfs, moedas, moepcs
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoepvs), 3)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoevs), 3)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cClfiscals), 10)) + ", "   && moepvs, moevs, clfiscals
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cSittricms), 3)) + ", " + FormatarNumeroSQL(THIS.this_nIcms, 2) + ", " + FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", "   && sittricms, icms, aliqipis
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIpis), 1)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTptribs), 4)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cOrigmercs), 1)) + ", "   && ipis, tptribs, origmercs
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cExtipi), 3)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMercs), 3)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescecfs), 29)) + ", "   && extipi, mercs, descecfs
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodgarras), 10)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMftios), 3)) + ", " + FormatarNumeroSQL(THIS.this_nPftios, 3) + ", "   && codgarras, mftios, pftios
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCftios), 2)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCftiocs), 2)) + ", " + FormatarNumeroSQL(THIS.this_nPftiocs, 3) + ", "   && cftios, cftiocs, pftiocs
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodservs), 4)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIats), 1)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodacbs), 3)) + ", "   && codservs, iats, codacbs
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nEncargos, 4) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodfinp), 3)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodmatp), 3)) + ", "   && encargos, codfinp, codmatp
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIdecpros), 3)) + ", " + FormatarNumeroSQL(THIS.this_nPesoms, 3) + ", " + FormatarNumeroSQL(THIS.this_nPesobs, 3) + ", "   && idecpros, pesoms, pesobs
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nPesometal, 3) + ", " + FormatarNumeroSQL(THIS.this_nPesobris, 3) + ", " + FormatarNumeroSQL(THIS.this_nPesopdrs, 3) + ", "   && pesometal, pesobris, pesopdrs
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nAltura, 4) + ", " + FormatarNumeroSQL(THIS.this_nLargura, 4) + ", " + FormatarNumeroSQL(THIS.this_nDiametro, 4) + ", "   && altura, largura, diametro
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nEspessura, 4) + ", " + FormatarNumeroSQL(THIS.this_nCompriment, 4) + ", " + FormatarNumeroSQL(THIS.this_nVarias, 0) + ", "   && espessura, compriment, varias
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nVarpesoms, 2) + ", " + FormatarNumeroSQL(THIS.this_nQmins, 3) + ", " + FormatarNumeroSQL(THIS.this_nPmins, 3) + ", "   && varpesoms, qmins, pmins
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nQtminfabs, 3) + ", " + FormatarNumeroSQL(THIS.this_nLtminsv, 3) + ", " + FormatarNumeroSQL(THIS.this_nQtdultcomp, 0) + ", "   && qtminfabs, ltminsv, qtdultcomp
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nVultcomps, 2) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMultcomps), 3)) + ", " + FormatarDataSQL(THIS.this_dUltcomps) + ", "   && vultcomps, multcomps, ultcomps
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nQtped, 3) + ", " + FormatarNumeroSQL(THIS.this_nEncoms, 0) + ", " + FormatarNumeroSQL(THIS.this_nConsigs, 0) + ", "   && qtped, encoms, consigs
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCunis), 3)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCunips), 3)) + ", " + FormatarNumeroSQL(THIS.this_nCbars, 0) + ", "   && cunis, cunips, cbars
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nEan13, 0) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cSkuvtex), 50)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCproeqs), 14)) + ", "   && ean13, skuvtex, cproeqs
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nQtdcpnts, 0) + ", " + FormatarNumeroSQL(THIS.this_nMontadescs, 0) + ", " + FormatarNumeroSQL(THIS.this_nDigimaxs, 0) + ", "   && qtdcpnts, montadescs, digimaxs
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nOrdcompos, 0) + ", " + FormatarNumeroSQL(THIS.this_nCasas, 0) + ", " + FormatarNumeroSQL(THIS.this_nVolumes, 0) + ", "   && ordcompos, casas, volumes
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nTamhs, 2) + ", " + FormatarNumeroSQL(THIS.this_nTamls, 2) + ", " + FormatarNumeroSQL(THIS.this_nTamps, 2) + ", "   && tamhs, tamls, tamps
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nFabrproprs, 0) + ", " + FormatarNumeroSQL(THIS.this_nTents, 0) + ", " + FormatarNumeroSQL(THIS.this_nTinsts, 0) + ", "   && fabrproprs, tents, tinsts
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nDiasinas, 0) + ", " + FormatarNumeroSQL(THIS.this_nProdvars, 0) + ", " + FormatarNumeroSQL(THIS.this_nProdwebs, 0) + ", "   && diasinas, prodvars, prodwebs
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nProtnovo, 0) + ", " + FormatarNumeroSQL(THIS.this_nProdoff, 0) + ", " + FormatarNumeroSQL(THIS.this_nPrototipo, 0) + ", "   && prodnovo, prodoff, prototipo
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nReposauto, 0) + ", " + FormatarNumeroSQL(THIS.this_nProcfigjpgs, 0) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContaccus), 10)) + ", "   && reposauto, procfigjpgs, contaccus
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGruccus), 10)) + ", " + FormatarNumeroSQL(THIS.this_nComis, 2) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cLocals), 10)) + ", "   && gruccus, comis, locals
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNotas), 6)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObsetqs), 10)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObspeds), 30)) + ", "   && notas, obsetqs, obspeds
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObspes), 30)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObsmkt), 100)) + ", " + EscaparSQL(THIS.this_mObscompras) + ", "   && obspes, obsmkt, obscompras
        loc_cValores = loc_cValores + EscaparSQL(THIS.this_mObsinsp) + ", " + EscaparSQL(THIS.this_mDsccompras) + ", " + EscaparSQL(THIS.this_mDescfis) + ", "   && obsinsp, dsccompras, descfis
        loc_cValores = loc_cValores + EscaparSQL(THIS.this_mFigjpgs) + ", " + EscaparSQL(THIS.this_mFigjpgs64) + ", " + EscaparSQL(THIS.this_mFigtecs) + ", "   && figjpgs, figjpgs64, figtecs
        loc_cValores = loc_cValores + EscaparSQL(THIS.this_mMtiposervs) + ", " + FormatarNumeroSQL(THIS.this_nAtivosite, 0) + ", " + FormatarNumeroSQL(THIS.this_nForalinha, 0) + ", "   && mtiposervs, ativosite, foralinha
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nMostruario, 0) + ", " + FormatarNumeroSQL(THIS.this_nBestseller, 0) + ", " + FormatarNumeroSQL(THIS.this_nSegfem, 0) + ", "   && mostruario, bestseller, segfem
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nSeginf, 0) + ", " + FormatarNumeroSQL(THIS.this_nSegkids, 0) + ", " + FormatarNumeroSQL(THIS.this_nSegmasc, 0) + ", "   && seginf, segkids, segmasc
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nSeguni, 0) + ", " + FormatarNumeroSQL(THIS.this_nSemconsulta, 0) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cLancamento), 30)) + ", "   && seguni, semconsulta, lancamento
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cOrigemlac), 40)) + ", " + FormatarNumeroSQL(THIS.this_nDiasgar, 0) + ", " + FormatarNumeroSQL(THIS.this_nChkgarvit, 0) + ", "   && origemlac, diasgar, chkgarvit
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nMohs, 0) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cRefracao), 16)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cRefracaodp), 16)) + ", "   && mohs, refracao, refracaodp
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUnidade1), 15)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cResultado1), 15)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cValorminimo), 15)) + ", "   && unidade1, resultado1, valorminimo
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cValormaximo), 15)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMetodoreferencia1), 15)) + ", " + IIF(THIS.this_lFlagctabs, "1", "0") + ", "   && valormaximo, metodoreferencia1, flagctabs
        loc_cValores = loc_cValores + IIF(THIS.this_lTcomps, "1", "0") + ", " + IIF(THIS.this_lTransps, "1", "0") + ", " + IIF(THIS.this_lImpetiqs, "1", "0") + ", "   && tcomps, transps, impetiqs
        loc_cValores = loc_cValores + IIF(THIS.this_lChkfunds, "1", "0") + ", " + FormatarDataSQL(THIS.this_dDatas) + ", " + FormatarDataSQL(THIS.this_dDatatrans) + ", "   && chkfunds, datas, datatrans
        loc_cValores = loc_cValores + FormatarDataSQL(THIS.this_dDtfilms) + ", " + FormatarDataSQL(THIS.this_dDtincs) + ", " + FormatarDataSQL(THIS.this_dDtcomps) + ", "   && dtfilms, dtincs, dtcomps
        loc_cValores = loc_cValores + FormatarDataSQL(THIS.this_dDtalts) + ", " + FormatarDataSQL(THIS.this_dDtlacto) + ", " + FormatarDataSQL(THIS.this_dFimdtlacto) + ", "   && dtalts, dtlacto, fimdtlacto
        loc_cValores = loc_cValores + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuincs), 10)) + ", " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuaalts), 20)) + ", " + FormatarNumeroSQL(THIS.this_nNidentfixa, 0) + ", "   && usuincs, usuaalts, nidentfixa
        loc_cValores = loc_cValores + FormatarNumeroSQL(THIS.this_nObrtamser, 0) + ", "   && obrtamser

        *-- Remove o separador final de cada lista
        loc_cCampos  = LEFT(loc_cCampos,  LEN(loc_cCampos)  - 2)
        loc_cValores = LEFT(loc_cValores, LEN(loc_cValores) - 2)

        RETURN "INSERT INTO SigCdPro (" + loc_cCampos + ") VALUES (" + loc_cValores + ")"
    ENDPROC

    *====================================================================
    * MontarSQLAlteracao - Monta o UPDATE completo de SigCdPro
    *
    * O WHERE usa a chave ORIGINAL (a que veio do banco), para que trocar
    * o codigo na tela continue localizando o registro certo.
    *====================================================================
    PROTECTED PROCEDURE MontarSQLAlteracao()
        LOCAL loc_cSet
        *-- SET com as 181 colunas. cpros entra no SET (para suportar troca
        *-- de codigo) e a chave ORIGINAL fica no WHERE.
        loc_cSet = ""
        loc_cSet = loc_cSet + "cpros = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCpros), 14)) + ", " + "idpro = " + FormatarNumeroSQL(THIS.this_nIdpro, 0) + ", "
        loc_cSet = loc_cSet + "codident = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodident), 20)) + ", " + "dpros = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDpros), 65)) + ", "
        loc_cSet = loc_cSet + "dpro2s = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDpro2s), 45)) + ", " + "dpro3s = " + EscaparSQL(THIS.this_mDpro3s) + ", "
        loc_cSet = loc_cSet + "cgrus = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCgrus), 3)) + ", " + "sgrus = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cSgrus), 6)) + ", "
        loc_cSet = loc_cSet + "linhas = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cLinhas), 10)) + ", " + "colecoes = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cColecoes), 10)) + ", "
        loc_cSet = loc_cSet + "conjunts = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cConjunts), 6)) + ", " + "tipos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipos), 1)) + ", "
        loc_cSet = loc_cSet + "status = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cStatus), 3)) + ", " + "situas = " + FormatarNumeroSQL(THIS.this_nSituas, 0) + ", "
        loc_cSet = loc_cSet + "dtsituas = " + FormatarDataSQL(THIS.this_dDtsituas) + ", " + "cclass = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCclass), 3)) + ", "
        loc_cSet = loc_cSet + "nivelqs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNivelqs), 10)) + ", " + "categoria = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCategoria), 6)) + ", "
        loc_cSet = loc_cSet + "codctgsite = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodctgsite), 2)) + ", " + "coddptsite = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCoddptsite), 2)) + ", "
        loc_cSet = loc_cSet + "codmacro = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodmacro), 6)) + ", " + "ifors = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIfors), 10)) + ", "
        loc_cSet = loc_cSet + "reffs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cReffs), 40)) + ", " + "cvens = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCvens), 10)) + ", "
        loc_cSet = loc_cSet + "codcors = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodcors), 4)) + ", " + "codtams = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodtams), 4)) + ", "
        loc_cSet = loc_cSet + "matprincs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMatprincs), 14)) + ", " + "metals = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMetals), 2)) + ", "
        loc_cSet = loc_cSet + "teors = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTeors), 2)) + ", " + "compos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCompos), 30)) + ", "
        loc_cSet = loc_cSet + "conquilhas = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cConquilhas), 10)) + ", " + "propriedades = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cPropriedades), 40)) + ", "
        loc_cSet = loc_cSet + "cravcers = " + FormatarNumeroSQL(THIS.this_nCravcers, 0) + ", " + "pcuss = " + FormatarNumeroSQL(THIS.this_nPcuss, 5) + ", "
        loc_cSet = loc_cSet + "pvens = " + FormatarNumeroSQL(THIS.this_nPvens, 5) + ", " + "pvideals = " + FormatarNumeroSQL(THIS.this_nPvideals, 5) + ", "
        loc_cSet = loc_cSet + "precode = " + FormatarNumeroSQL(THIS.this_nPrecode, 5) + ", " + "custofs = " + FormatarNumeroSQL(THIS.this_nCustofs, 3) + ", "
        loc_cSet = loc_cSet + "custocp = " + FormatarNumeroSQL(THIS.this_nCustocp, 5) + ", " + "valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ", "
        loc_cSet = loc_cSet + "markupa = " + FormatarNumeroSQL(THIS.this_nMarkupa, 3) + ", " + "margems = " + FormatarNumeroSQL(THIS.this_nMargems, 6) + ", "
        loc_cSet = loc_cSet + "fcustos = " + FormatarNumeroSQL(THIS.this_nFcustos, 5) + ", " + "fvendas = " + FormatarNumeroSQL(THIS.this_nFvendas, 3) + ", "
        loc_cSet = loc_cSet + "fatuals = " + FormatarNumeroSQL(THIS.this_nFatuals, 5) + ", " + "fideals = " + FormatarNumeroSQL(THIS.this_nFideals, 5) + ", "
        loc_cSet = loc_cSet + "cotacalcp = " + FormatarNumeroSQL(THIS.this_nCotacalcp, 6) + ", " + "moecs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoecs), 3)) + ", "
        loc_cSet = loc_cSet + "moecusfs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoecusfs), 3)) + ", " + "moedas = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoedas), 3)) + ", "
        loc_cSet = loc_cSet + "moepcs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoepcs), 3)) + ", " + "moepvs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoepvs), 3)) + ", "
        loc_cSet = loc_cSet + "moevs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMoevs), 3)) + ", " + "clfiscals = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cClfiscals), 10)) + ", "
        loc_cSet = loc_cSet + "sittricms = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cSittricms), 3)) + ", " + "icms = " + FormatarNumeroSQL(THIS.this_nIcms, 2) + ", "
        loc_cSet = loc_cSet + "aliqipis = " + FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + "ipis = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIpis), 1)) + ", "
        loc_cSet = loc_cSet + "tptribs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTptribs), 4)) + ", " + "origmercs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cOrigmercs), 1)) + ", "
        loc_cSet = loc_cSet + "extipi = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cExtipi), 3)) + ", " + "mercs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMercs), 3)) + ", "
        loc_cSet = loc_cSet + "descecfs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescecfs), 29)) + ", " + "codgarras = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodgarras), 10)) + ", "
        loc_cSet = loc_cSet + "mftios = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMftios), 3)) + ", " + "pftios = " + FormatarNumeroSQL(THIS.this_nPftios, 3) + ", "
        loc_cSet = loc_cSet + "cftios = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCftios), 2)) + ", " + "cftiocs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCftiocs), 2)) + ", "
        loc_cSet = loc_cSet + "pftiocs = " + FormatarNumeroSQL(THIS.this_nPftiocs, 3) + ", " + "codservs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodservs), 4)) + ", "
        loc_cSet = loc_cSet + "iats = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIats), 1)) + ", " + "codacbs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodacbs), 3)) + ", "
        loc_cSet = loc_cSet + "encargos = " + FormatarNumeroSQL(THIS.this_nEncargos, 4) + ", " + "codfinp = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodfinp), 3)) + ", "
        loc_cSet = loc_cSet + "codmatp = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodmatp), 3)) + ", " + "idecpros = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIdecpros), 3)) + ", "
        loc_cSet = loc_cSet + "pesoms = " + FormatarNumeroSQL(THIS.this_nPesoms, 3) + ", " + "pesobs = " + FormatarNumeroSQL(THIS.this_nPesobs, 3) + ", "
        loc_cSet = loc_cSet + "pesometal = " + FormatarNumeroSQL(THIS.this_nPesometal, 3) + ", " + "pesobris = " + FormatarNumeroSQL(THIS.this_nPesobris, 3) + ", "
        loc_cSet = loc_cSet + "pesopdrs = " + FormatarNumeroSQL(THIS.this_nPesopdrs, 3) + ", " + "altura = " + FormatarNumeroSQL(THIS.this_nAltura, 4) + ", "
        loc_cSet = loc_cSet + "largura = " + FormatarNumeroSQL(THIS.this_nLargura, 4) + ", " + "diametro = " + FormatarNumeroSQL(THIS.this_nDiametro, 4) + ", "
        loc_cSet = loc_cSet + "espessura = " + FormatarNumeroSQL(THIS.this_nEspessura, 4) + ", " + "compriment = " + FormatarNumeroSQL(THIS.this_nCompriment, 4) + ", "
        loc_cSet = loc_cSet + "varias = " + FormatarNumeroSQL(THIS.this_nVarias, 0) + ", " + "varpesoms = " + FormatarNumeroSQL(THIS.this_nVarpesoms, 2) + ", "
        loc_cSet = loc_cSet + "qmins = " + FormatarNumeroSQL(THIS.this_nQmins, 3) + ", " + "pmins = " + FormatarNumeroSQL(THIS.this_nPmins, 3) + ", "
        loc_cSet = loc_cSet + "qtminfabs = " + FormatarNumeroSQL(THIS.this_nQtminfabs, 3) + ", " + "ltminsv = " + FormatarNumeroSQL(THIS.this_nLtminsv, 3) + ", "
        loc_cSet = loc_cSet + "qtdultcomp = " + FormatarNumeroSQL(THIS.this_nQtdultcomp, 0) + ", " + "vultcomps = " + FormatarNumeroSQL(THIS.this_nVultcomps, 2) + ", "
        loc_cSet = loc_cSet + "multcomps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMultcomps), 3)) + ", " + "ultcomps = " + FormatarDataSQL(THIS.this_dUltcomps) + ", "
        loc_cSet = loc_cSet + "qtped = " + FormatarNumeroSQL(THIS.this_nQtped, 3) + ", " + "encoms = " + FormatarNumeroSQL(THIS.this_nEncoms, 0) + ", "
        loc_cSet = loc_cSet + "consigs = " + FormatarNumeroSQL(THIS.this_nConsigs, 0) + ", " + "cunis = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCunis), 3)) + ", "
        loc_cSet = loc_cSet + "cunips = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCunips), 3)) + ", " + "cbars = " + FormatarNumeroSQL(THIS.this_nCbars, 0) + ", "
        loc_cSet = loc_cSet + "ean13 = " + FormatarNumeroSQL(THIS.this_nEan13, 0) + ", " + "skuvtex = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cSkuvtex), 50)) + ", "
        loc_cSet = loc_cSet + "cproeqs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCproeqs), 14)) + ", " + "qtdcpnts = " + FormatarNumeroSQL(THIS.this_nQtdcpnts, 0) + ", "
        loc_cSet = loc_cSet + "montadescs = " + FormatarNumeroSQL(THIS.this_nMontadescs, 0) + ", " + "digimaxs = " + FormatarNumeroSQL(THIS.this_nDigimaxs, 0) + ", "
        loc_cSet = loc_cSet + "ordcompos = " + FormatarNumeroSQL(THIS.this_nOrdcompos, 0) + ", " + "casas = " + FormatarNumeroSQL(THIS.this_nCasas, 0) + ", "
        loc_cSet = loc_cSet + "volumes = " + FormatarNumeroSQL(THIS.this_nVolumes, 0) + ", " + "tamhs = " + FormatarNumeroSQL(THIS.this_nTamhs, 2) + ", "
        loc_cSet = loc_cSet + "tamls = " + FormatarNumeroSQL(THIS.this_nTamls, 2) + ", " + "tamps = " + FormatarNumeroSQL(THIS.this_nTamps, 2) + ", "
        loc_cSet = loc_cSet + "fabrproprs = " + FormatarNumeroSQL(THIS.this_nFabrproprs, 0) + ", " + "tents = " + FormatarNumeroSQL(THIS.this_nTents, 0) + ", "
        loc_cSet = loc_cSet + "tinsts = " + FormatarNumeroSQL(THIS.this_nTinsts, 0) + ", " + "diasinas = " + FormatarNumeroSQL(THIS.this_nDiasinas, 0) + ", "
        loc_cSet = loc_cSet + "prodvars = " + FormatarNumeroSQL(THIS.this_nProdvars, 0) + ", " + "prodwebs = " + FormatarNumeroSQL(THIS.this_nProdwebs, 0) + ", "
        loc_cSet = loc_cSet + "prodnovo = " + FormatarNumeroSQL(THIS.this_nProtnovo, 0) + ", " + "prodoff = " + FormatarNumeroSQL(THIS.this_nProdoff, 0) + ", "
        loc_cSet = loc_cSet + "prototipo = " + FormatarNumeroSQL(THIS.this_nPrototipo, 0) + ", " + "reposauto = " + FormatarNumeroSQL(THIS.this_nReposauto, 0) + ", "
        loc_cSet = loc_cSet + "procfigjpgs = " + FormatarNumeroSQL(THIS.this_nProcfigjpgs, 0) + ", " + "contaccus = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContaccus), 10)) + ", "
        loc_cSet = loc_cSet + "gruccus = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGruccus), 10)) + ", " + "comis = " + FormatarNumeroSQL(THIS.this_nComis, 2) + ", "
        loc_cSet = loc_cSet + "locals = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cLocals), 10)) + ", " + "notas = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNotas), 6)) + ", "
        loc_cSet = loc_cSet + "obsetqs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObsetqs), 10)) + ", " + "obspeds = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObspeds), 30)) + ", "
        loc_cSet = loc_cSet + "obspes = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObspes), 30)) + ", " + "obsmkt = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cObsmkt), 100)) + ", "
        loc_cSet = loc_cSet + "obscompras = " + EscaparSQL(THIS.this_mObscompras) + ", " + "obsinsp = " + EscaparSQL(THIS.this_mObsinsp) + ", "
        loc_cSet = loc_cSet + "dsccompras = " + EscaparSQL(THIS.this_mDsccompras) + ", " + "descfis = " + EscaparSQL(THIS.this_mDescfis) + ", "
        loc_cSet = loc_cSet + "figjpgs = " + EscaparSQL(THIS.this_mFigjpgs) + ", " + "figjpgs64 = " + EscaparSQL(THIS.this_mFigjpgs64) + ", "
        loc_cSet = loc_cSet + "figtecs = " + EscaparSQL(THIS.this_mFigtecs) + ", " + "mtiposervs = " + EscaparSQL(THIS.this_mMtiposervs) + ", "
        loc_cSet = loc_cSet + "ativosite = " + FormatarNumeroSQL(THIS.this_nAtivosite, 0) + ", " + "foralinha = " + FormatarNumeroSQL(THIS.this_nForalinha, 0) + ", "
        loc_cSet = loc_cSet + "mostruario = " + FormatarNumeroSQL(THIS.this_nMostruario, 0) + ", " + "bestseller = " + FormatarNumeroSQL(THIS.this_nBestseller, 0) + ", "
        loc_cSet = loc_cSet + "segfem = " + FormatarNumeroSQL(THIS.this_nSegfem, 0) + ", " + "seginf = " + FormatarNumeroSQL(THIS.this_nSeginf, 0) + ", "
        loc_cSet = loc_cSet + "segkids = " + FormatarNumeroSQL(THIS.this_nSegkids, 0) + ", " + "segmasc = " + FormatarNumeroSQL(THIS.this_nSegmasc, 0) + ", "
        loc_cSet = loc_cSet + "seguni = " + FormatarNumeroSQL(THIS.this_nSeguni, 0) + ", " + "semconsulta = " + FormatarNumeroSQL(THIS.this_nSemconsulta, 0) + ", "
        loc_cSet = loc_cSet + "lancamento = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cLancamento), 30)) + ", " + "origemlac = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cOrigemlac), 40)) + ", "
        loc_cSet = loc_cSet + "diasgar = " + FormatarNumeroSQL(THIS.this_nDiasgar, 0) + ", " + "chkgarvit = " + FormatarNumeroSQL(THIS.this_nChkgarvit, 0) + ", "
        loc_cSet = loc_cSet + "mohs = " + FormatarNumeroSQL(THIS.this_nMohs, 0) + ", " + "refracao = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cRefracao), 16)) + ", "
        loc_cSet = loc_cSet + "refracaodp = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cRefracaodp), 16)) + ", " + "unidade1 = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUnidade1), 15)) + ", "
        loc_cSet = loc_cSet + "resultado1 = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cResultado1), 15)) + ", " + "valorminimo = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cValorminimo), 15)) + ", "
        loc_cSet = loc_cSet + "valormaximo = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cValormaximo), 15)) + ", " + "metodoreferencia1 = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cMetodoreferencia1), 15)) + ", "
        loc_cSet = loc_cSet + "flagctabs = " + IIF(THIS.this_lFlagctabs, "1", "0") + ", " + "tcomps = " + IIF(THIS.this_lTcomps, "1", "0") + ", "
        loc_cSet = loc_cSet + "transps = " + IIF(THIS.this_lTransps, "1", "0") + ", " + "impetiqs = " + IIF(THIS.this_lImpetiqs, "1", "0") + ", "
        loc_cSet = loc_cSet + "chkfunds = " + IIF(THIS.this_lChkfunds, "1", "0") + ", " + "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", "
        loc_cSet = loc_cSet + "datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ", " + "dtfilms = " + FormatarDataSQL(THIS.this_dDtfilms) + ", "
        loc_cSet = loc_cSet + "dtincs = " + FormatarDataSQL(THIS.this_dDtincs) + ", " + "dtcomps = " + FormatarDataSQL(THIS.this_dDtcomps) + ", "
        loc_cSet = loc_cSet + "dtalts = " + FormatarDataSQL(THIS.this_dDtalts) + ", " + "dtlacto = " + FormatarDataSQL(THIS.this_dDtlacto) + ", "
        loc_cSet = loc_cSet + "fimdtlacto = " + FormatarDataSQL(THIS.this_dFimdtlacto) + ", " + "usuincs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuincs), 10)) + ", "
        loc_cSet = loc_cSet + "usuaalts = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cUsuaalts), 20)) + ", " + "nidentfixa = " + FormatarNumeroSQL(THIS.this_nNidentfixa, 0) + ", "
        loc_cSet = loc_cSet + "obrtamser = " + FormatarNumeroSQL(THIS.this_nObrtamser, 0) + ", "

        *-- Remove o separador final
        loc_cSet = LEFT(loc_cSet, LEN(loc_cSet) - 2)

        RETURN "UPDATE SigCdPro SET " + loc_cSet + ;
            " WHERE cpros = " + EscaparSQL(THIS.ObterChaveGravacao())
    ENDPROC

    *====================================================================
    * Inserir - INSERT do produto
    *
    * Em caso de falha apenas PREENCHE this_cMensagemErro: quem exibe eh
    * o BusinessBase.Salvar() via ExibirFalha() (regra #20). Exibir aqui
    * tambem mostraria a mesma mensagem duas vezes.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.AplicarCarimboInclusao()

            loc_cSQL       = THIS.MontarSQLInclusao()
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cChaveOriginal = ALLTRIM(THIS.this_cCpros)
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao incluir o produto:" + CHR(13) + CapturarErroSQL()
                loc_lSucesso = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao incluir o produto:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE do produto
    *
    * Falha so preenche this_cMensagemErro (regra #20).
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.AplicarCarimboAlteracao()

            loc_cSQL       = THIS.MontarSQLAlteracao()
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cChaveOriginal = ALLTRIM(THIS.this_cCpros)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao alterar o produto:" + CHR(13) + CapturarErroSQL()
                loc_lSucesso = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao alterar o produto:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE do produto e das tabelas relacionadas
    *
    * Transcrito da PROCEDURE msv_excluir do legado, na MESMA ordem e com
    * as MESMAS chaves:
    *   SigOpArq  por fkChaves = Padr(CPros, 30)
    *   SigCdPrf  por Produtos
    *   SigCdCat / SigCdSvc por Left(CPros, 6)
    *   as demais por CPros
    *
    * Chamado por BusinessBase.Excluir() (PUBLIC). NUNCA chamar de fora.
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cChave, loc_cChaveArq, loc_cChaveCat, loc_lSucesso, loc_oErro
        LOCAL loc_nI, loc_cSQL, loc_nResultado
        LOCAL ARRAY loc_aComandos[15]

        loc_lSucesso = .F.

        TRY
            loc_cChave    = THIS.ObterChaveGravacao()
            loc_cChaveArq = PADR(loc_cChave, 30)
            loc_cChaveCat = LEFT(loc_cChave, 6)

            IF EMPTY(loc_cChave)
                THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                    " produto selecionado para excluir."
            ELSE
                *-- Ordem identica a do legado (msv_excluir)
                loc_aComandos[ 1] = "DELETE FROM SigOpArq WHERE fkChaves = " + EscaparSQL(loc_cChaveArq)
                loc_aComandos[ 2] = "DELETE FROM SigCdPro WHERE CPros = "    + EscaparSQL(loc_cChave)
                loc_aComandos[ 3] = "DELETE FROM SigPrMdl WHERE CPros = "    + EscaparSQL(loc_cChave)
                loc_aComandos[ 4] = "DELETE FROM SigCdPrf WHERE Produtos = " + EscaparSQL(loc_cChave)
                loc_aComandos[ 5] = "DELETE FROM SigPrCpo WHERE CPros = "    + EscaparSQL(loc_cChave)
                loc_aComandos[ 6] = "DELETE FROM SigPrPmi WHERE CPros = "    + EscaparSQL(loc_cChave)
                loc_aComandos[ 7] = "DELETE FROM SigPrCrr WHERE CPros = "    + EscaparSQL(loc_cChave)
                loc_aComandos[ 8] = "DELETE FROM SigCdPft WHERE CPros = "    + EscaparSQL(loc_cChave)
                loc_aComandos[ 9] = "DELETE FROM SigSubCp WHERE CPros = "    + EscaparSQL(loc_cChave)
                loc_aComandos[10] = "DELETE FROM SigCdCat WHERE Cods = "     + EscaparSQL(loc_cChaveCat)
                loc_aComandos[11] = "DELETE FROM SigCdSvc WHERE cCats = "    + EscaparSQL(loc_cChaveCat)
                loc_aComandos[12] = "DELETE FROM SigPrFnc WHERE CPros = "    + EscaparSQL(loc_cChave)
                loc_aComandos[13] = "DELETE FROM SigPrTam WHERE CPros = "    + EscaparSQL(loc_cChave)
                loc_aComandos[14] = "DELETE FROM SigPrCar WHERE CPros = "    + EscaparSQL(loc_cChave)
                loc_aComandos[15] = "DELETE FROM SigSerPr WHERE CPros = "    + EscaparSQL(loc_cChave)

                loc_lSucesso = .T.

                FOR loc_nI = 1 TO ALEN(loc_aComandos)
                    IF loc_lSucesso
                        loc_cSQL       = loc_aComandos[loc_nI]
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                        IF loc_nResultado < 0
                            THIS.this_cMensagemErro = "Erro ao excluir o produto:" + CHR(13) + ;
                                CapturarErroSQL()
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                ENDFOR

                IF loc_lSucesso
                    THIS.RegistrarAuditoria("DELETE")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir o produto:" + CHR(13) + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Le um produto pelo codigo
    *
    * SELECT * como no legado (lcQryPro = [Select * From SigCdPro Where
    * CPros = ?pPro]). Medido no VFP9: cursor aceita nome de campo com
    * mais de 10 caracteres, entao a grafia do banco chega intacta e
    * CarregarDoCursor le as colunas reais.
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(LEFT(ALLTRIM(NVL(par_cCodigo, "")), 14))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    GO TOP IN cursor_4c_Carrega
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado!"
                    MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    THIS.this_lErroExibido = .T.
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar o produto:" + CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro, "ProdutoBO.CarregarPorCodigo")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterColunasLista - Colunas que a grade da pagina Lista consome
    *
    * Transcrito do lcLstPro do Init legado. Mexer aqui exige mexer nos
    * ControlSource da grade (regra #35 do CLAUDE.md).
    *====================================================================
    PROTECTED PROCEDURE ObterColunasLista()
        RETURN "cpros, dpros, dpro2s, cgrus, sgrus, reffs, colecoes," + ;
            " impetiqs, situas, encoms, cbars, cproeqs, compos, codcors," + ;
            " usuaalts, dtalts"
    ENDPROC

    *====================================================================
    * BuscarLista - Consulta da pagina Lista, com os filtros do legado
    *
    * Transcricao do lcLstPro + PreparaDados:
    *   Where Datas BetWeen ?pDtI And ?pDtF
    *     And CGrus = ?pGru
    *     And Situas In (?pStI, ?pStF)
    * com pStI = Iif(optFilSituas.Value = 3, 2, 1)
    *     pStF = Iif(optFilSituas.Value = 2, 1, 2)
    *
    * Regra #35: o filtro eh aplicado SEMPRE, inclusive com o grupo
    * VAZIO - nesse caso a lista abre vazia DE PROPOSITO, esperando o
    * usuario escolher o grupo. Trocar isso por "sem filtro = tudo"
    * traria a tabela inteira.
    *
    * par_nSituacao: 1 = Geral, 2 = Ativos, 3 = Inativos (optFilSituas)
    *====================================================================
    PROCEDURE BuscarLista(par_cGrupo, par_dDtIni, par_dDtFim, par_nSituacao)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        LOCAL loc_nSitIni, loc_nSitFim, loc_nOpcao
        loc_lSucesso = .F.

        TRY
            loc_nOpcao  = IIF(VARTYPE(par_nSituacao) = "N", par_nSituacao, 1)
            loc_nSitIni = IIF(loc_nOpcao = 3, 2, 1)
            loc_nSitFim = IIF(loc_nOpcao = 2, 1, 2)

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT " + THIS.ObterColunasLista() + ;
                " FROM SigCdPro" + ;
                " WHERE Datas BETWEEN " + FormatarDataSQL(par_dDtIni) + ;
                " AND " + FormatarDataSQL(par_dDtFim) + ;
                " AND cgrus = " + EscaparSQL(PADR(ALLTRIM(NVL(par_cGrupo, "")), 3)) + ;
                " AND situas IN (" + FormatarNumeroSQL(loc_nSitIni, 0) + ", " + ;
                FormatarNumeroSQL(loc_nSitFim, 0) + ")" + ;
                " ORDER BY cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                GO TOP IN cursor_4c_Dados
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao listar os produtos:" + CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro, "ProdutoBO.BuscarLista")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Carga da grade sem os filtros de periodo/situacao
    *
    * Usada quando a tela ainda nao tem contexto de filtro. par_cFiltro
    * eh a clausula WHERE ja montada pelo chamador (sem a palavra WHERE).
    *====================================================================
    PROCEDURE Buscar(par_cFiltro, par_cOrdenacao, par_cCampos)
        LOCAL loc_cSQL, loc_cFiltro, loc_cOrdem, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cFiltro = ALLTRIM(IIF(VARTYPE(par_cFiltro) = "C", par_cFiltro, ""))
            loc_cOrdem  = ALLTRIM(IIF(VARTYPE(par_cOrdenacao) = "C", par_cOrdenacao, "cpros"))

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT " + THIS.ObterColunasLista() + " FROM SigCdPro"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + loc_cFiltro
            ENDIF

            IF !EMPTY(loc_cOrdem)
                loc_cSQL = loc_cSQL + " ORDER BY " + loc_cOrdem
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                GO TOP IN cursor_4c_Dados
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro, "ProdutoBO.Buscar")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExisteProduto - .T. quando o codigo ja esta gravado
    *
    * Usado pelo formulario antes de incluir, para nao violar a PK.
    *====================================================================
    PROCEDURE ExisteProduto(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste, loc_oErro
        loc_lExiste = .F.

        TRY
            IF USED("cursor_4c_ExistePro")
                USE IN cursor_4c_ExistePro
            ENDIF

            loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(LEFT(ALLTRIM(NVL(par_cCodigo, "")), 14))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExistePro")

            IF loc_nResultado >= 0
                loc_lExiste = (RECCOUNT("cursor_4c_ExistePro") > 0)
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar o produto:" + CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF

            IF USED("cursor_4c_ExistePro")
                USE IN cursor_4c_ExistePro
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MostrarErro(loc_oErro, "ProdutoBO.ExisteProduto")
            THIS.this_lErroExibido = .T.
            loc_lExiste = .F.
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

ENDDEFINE
