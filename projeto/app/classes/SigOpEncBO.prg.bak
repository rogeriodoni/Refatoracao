*==============================================================================
* SigOpEncBO.prg - Business Object para Encerramento de Contas
*
* Legado           : SIGOPENC.SCX (form OPERACIONAL, task730)
* Tabela principal : SigMvCcr (PK: cidchaves char(20)) - lancamentos de conta
*                    corrente gerados pelo encerramento
* Tabela auxiliar  : SigMvCab (PK: cidchaves char(20)) - cabecalho do movimento,
*                    criado apenas quando ainda nao existe para Emps+Dopes
* Tabelas de leitura: SigMvSlc (saldos por grupo/conta/moeda) + SigCdCli (razao
*                    social e situacao da conta)
* Parametros       : SigCdPac (sigkeys e dopzers)
* Lookup grupo     : SigCdGcr (codigos char(10) / descrs char(40)) via
*                    fAcessoContab
* Lookup conta     : SigCdCli (iclis char(10) / rclis char(50)) via
*                    fAcessoContas
*
* OBSERVACAO SOBRE A TABELA PRINCIPAL
* -----------------------------------
* O analise.json desta task aponta SigMvCab como tabela principal, porque o
* Init do legado faz dois AddCursor e SigMvCab e o segundo deles. O alvo real
* do processamento, porem, e SigMvCcr: o Click do cmdProcessa gera UM
* lancamento de encerramento mais a sua contra-partida para cada conta marcada
* na grade, e so toca em SigMvCab quando o cabecalho Emps+Dopes ainda nao
* existe. Por isso this_cTabela = "SigMvCcr", espelhando o sigopaccBO (mesma
* familia de telas de conta corrente).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpEncBO AS BusinessBase

    *==========================================================================
    * FILTRO DA TELA - bloco "Filtro" do Container1 do legado
    * (Get_Grupo / Get_DGrupo / Get_Conta / get_Dconta)
    *==========================================================================
    this_cGrupoFiltro     = ""   && char(10) SigCdGcr.codigos - Grupo do filtro
    this_cDescGrupoFiltro = ""   && char(40) SigCdGcr.descrs
    this_cContaFiltro     = ""   && char(10) SigCdCli.iclis - Conta do filtro
    this_cDescContaFiltro = ""   && char(50) SigCdCli.rclis

    *==========================================================================
    * CONTRA-PARTIDA - bloco "Contra-Partida" do Container1 do legado
    * (Get_GrupoC / Get_DgrupoC / Get_contaC / Get_DcontaC)
    *==========================================================================
    this_cGrupoContra     = ""   && char(10) SigCdGcr.codigos - Grupo contra-partida
    this_cDescGrupoContra = ""   && char(40) SigCdGcr.descrs
    this_cContaContra     = ""   && char(10) SigCdCli.iclis - Conta contra-partida
    this_cDescContaContra = ""   && char(50) SigCdCli.rclis

    *==========================================================================
    * PARAMETROS DO SISTEMA - SigCdPac (lidos no Init do legado)
    * Get_Dope e somente leitura (o When do legado devolve .F.) e recebe DopZers
    *==========================================================================
    this_cOperacao = ""   && char(20) SigCdPac.dopzers - Operacao de Mov.Estoque
    this_cSigKey   = ""   && char(3)  SigCdPac.sigkeys - sufixo da PK cidchaves

    *==========================================================================
    * CONTEXTO DA SESSAO - no legado vinham das PUBLIC _Empr e Usuar
    *==========================================================================
    this_cEmpresa = ""   && char(3)  Empresa corrente (go_4c_Sistema.cCodEmpresa)
    this_cUsuario = ""   && char(10) Usuario logado (gc_4c_UsuarioLogado)

    *==========================================================================
    * CURSORES DE TRABALHO - equivalentes aos cursores do legado
    *   crSigMvSlc -> saldos exibidos na grade (com as colunas Flag e Marcas)
    *   crSigMvCcr -> lancamentos montados antes da gravacao
    *   crSigMvCab -> cabecalhos de movimento montados antes da gravacao
    *   crSigCdPac -> parametros do sistema
    *==========================================================================
    this_cCursorSaldos      = "cursor_4c_Saldos"
    this_cCursorLancamentos = "cursor_4c_Lancamentos"
    this_cCursorCabecalhos  = "cursor_4c_Cabecalhos"
    this_cCursorParametros  = "cursor_4c_Parametros"

    *==========================================================================
    * ESTADO DO PROCESSAMENTO
    *==========================================================================
    this_lProcessando        = .F.  && Guarda de reentrancia do Processar
    this_nContasSelecionadas = 0    && Linhas com Marcas = 1 na grade
    this_nContasProcessadas  = 0    && Linhas efetivamente encerradas
    this_nLancamentosGerados = 0    && Registros gravados em SigMvCcr
    this_nCabecalhosGerados  = 0    && Registros gravados em SigMvCab

    *==========================================================================
    * LINHA CORRENTE DE SigMvSlc - o saldo que esta sendo encerrado no SCAN
    *==========================================================================
    this_cSaldoEmps   = ""  && char(3)       SigMvSlc.emps
    this_cSaldoGrupos = ""  && char(10)      SigMvSlc.grupos
    this_cSaldoContas = ""  && char(10)      SigMvSlc.contas
    this_cSaldoMoedas = ""  && char(3)       SigMvSlc.moedas
    this_nSaldoSaldos = 0   && numeric(13,2) SigMvSlc.saldos

    *==========================================================================
    * COLUNAS DE SigMvCcr
    *
    * Todas as 86 colunas da tabela estao declaradas, nao apenas as que a tela
    * preenche: o INSERT tem de cobrir TODA coluna NOT NULL sem DEFAULT (regra
    * #22 do CLAUDE.md), e no legado isso acontecia de graca porque o AddCursor
    * trazia o registro em branco inteiro e o TableUpdate gravava tudo.
    * Os nomes espelham as colunas do schema (docs/schema.sql).
    *==========================================================================
    this_lAutos      = .F.  && bit           - autos (lancamento automatico)
    this_lConcs      = .F.  && bit           - concs
    this_cContages   = ""   && char(10)      - contages
    this_cContas     = ""   && char(10)      - contas
    this_cContems    = ""   && char(10)      - contems
    this_nCotacaos   = 0    && numeric(15,7) - cotacaos
    this_dDatalts    = {}   && datetime NULL - datalts
    this_dDatas      = {}   && datetime NULL - datas
    this_dDataconcs  = {}   && datetime NULL - dataconcs
    this_dDatatrans  = {}   && datetime NULL - datatrans
    this_dDatexcs    = {}   && datetime NULL - datexcs
    this_cDocus      = ""   && char(10)      - docus
    this_cDopes      = ""   && char(20)      - dopes
    this_dDtemis     = {}   && datetime NULL - dtemis
    this_cEmps       = ""   && char(3)       - emps
    this_cGrupages   = ""   && char(10)      - grupages
    this_cGrupems    = ""   && char(10)      - grupems
    this_cGrupos     = ""   && char(10)      - grupos
    this_cHists      = ""   && char(60) NULL - hists
    this_cLocals     = ""   && char(10)      - locals
    this_cMoedas     = ""   && char(3)       - moedas
    this_cNfs        = ""   && char(10)      - nfs
    this_nNlancs     = 0    && numeric(6,0)  - nlancs
    this_nNopers     = 0    && numeric(7,0)  - nopers
    this_nNtrans     = 0    && numeric(6,0)  - ntrans
    this_nNumes      = 0    && numeric(6,0)  - numes
    this_cOpers      = ""   && char(1)       - opers (D/C)
    this_nSaldocs    = 0    && numeric(15,2) - saldocs
    this_nSaldons    = 0    && numeric(15,2) - saldons
    this_nSaldos     = 0    && numeric(15,2) - saldos
    this_cScontas    = ""   && char(10)      - scontas
    this_nScotacaos  = 0    && numeric(15,7) - scotacaos
    this_cSgrupos    = ""   && char(10)      - sgrupos
    this_cShists     = ""   && char(40)      - shists
    this_cSmoedas    = ""   && char(3)       - smoedas
    this_cSopers     = ""   && char(1)       - sopers (D/C invertido)
    this_nSvalors    = 0    && numeric(11,2) - svalors
    this_cTipos      = ""   && char(1)       - tipos
    this_cTitbans    = ""   && char(12)      - titbans
    this_cTitulos    = ""   && char(10)      - titulos
    this_cUsualts    = ""   && char(10)      - usualts
    this_cUsuexcs    = ""   && char(10)      - usuexcs
    this_nValliqs    = 0    && numeric(11,2) - valliqs
    this_nValocurs   = 0    && numeric(11,2) - valocurs
    this_nValors     = 0    && numeric(11,2) - valors
    this_nValpags    = 0    && numeric(11,2) - valpags
    this_dVencs      = {}   && datetime NULL - vencs
    this_cVlancs     = ""   && char(10)      - vlancs
    this_cVopers     = ""   && char(13)      - vopers
    this_nContapgs   = 0    && numeric(1,0)  - contapgs
    this_cDopcs      = ""   && char(20)      - dopcs
    this_nNumcs      = 0    && numeric(6,0)  - numcs
    this_cCotusus    = ""   && char(10)      - cotusus
    this_cBcontas    = ""   && char(10)      - bcontas
    this_cBgrupos    = ""   && char(10)      - bgrupos
    this_nBorderos   = 0    && numeric(6,0)  - borderos
    this_cHist2s     = ""   && char(80) NULL - hist2s
    this_nIntconts   = 0    && numeric(6,0)  - intconts
    this_cUsuconcs   = ""   && char(10)      - usuconcs
    this_cAuditors   = ""   && char(10)      - auditors
    this_dDtaudits   = {}   && datetime NULL - dtaudits
    this_nValprev    = 0    && numeric(11,2) - valprev
    this_cCidchaves  = ""   && char(20)      - cidchaves (PK)
    this_cEmpdopncs  = ""   && char(29)      - empdopncs (emps+dopcs+numcs)
    this_cEmpdopnums = ""   && char(29)      - empdopnums (emps+dopes+numes)
    this_cGruconmoes = ""   && char(23)      - gruconmoes (grupos+contas+moedas)
    this_cPagos      = ""   && char(1)       - pagos
    this_cDopotps    = ""   && char(23)      - dopotps
    this_cUsupagos   = ""   && char(10)      - usupagos
    this_nTitcancs   = 0    && numeric(1,0)  - titcancs
    this_dDtconfs    = {}   && datetime NULL - dtconfs
    this_cUsuconfs   = ""   && char(10)      - usuconfs
    this_nNopercancs = 0    && numeric(7,0)  - nopercancs
    this_cEspecienfs = ""   && char(6)       - especienfs
    this_cJobs       = ""   && char(10)      - jobs
    this_nImpostos   = 0    && numeric(11,2) - impostos
    this_nTpimpostos = 0    && numeric(2,0)  - tpimpostos
    this_cTitpais    = ""   && char(10)      - titpais
    this_cEmpccs     = ""   && char(3)       - empccs
    this_nRecor      = 0    && numeric(1,0)  - recor
    this_cCompet     = ""   && char(7)       - compet
    this_cEmpos      = ""   && char(3)       - empos
    this_cOridopnums = ""   && char(29)      - oridopnums
    this_cPastas     = ""   && text NULL     - pastas
    this_cRcontas    = ""   && char(10)      - rcontas
    this_cTpdocnf    = ""   && char(2)       - tpdocnf

    *==========================================================================
    * COLUNAS DE SigMvCab preenchidas pelo legado quando cria o cabecalho do
    * movimento (Insert Into CrSigMvCab do Click do cmdProcessa).
    * Prefixo Cab para nao colidir com as colunas homonimas de SigMvCcr -
    * emps, dopes, numes, datas e cidchaves existem nas DUAS tabelas.
    *==========================================================================
    this_cCabEmps       = ""  && char(3)       SigMvCab.emps
    this_cCabDopes      = ""  && char(20)      SigMvCab.dopes
    this_nCabNumes      = 0   && numeric(6,0)  SigMvCab.numes (fGerUniqueKey)
    this_cCabUsuars     = ""  && char(10)      SigMvCab.usuars
    this_dCabDatars     = {}  && datetime NULL SigMvCab.datars
    this_dCabDatas      = {}  && datetime NULL SigMvCab.datas
    this_cCabMascnum    = ""  && char(10)      SigMvCab.mascnum (fGerMascara)
    this_cCabEmpdopnums = ""  && char(29)      SigMvCab.empdopnums
    this_cCabCidchaves  = ""  && char(20)      SigMvCab.cidchaves (fUniqueIds)
    this_dCabDtalts     = {}  && datetime NULL SigMvCab.dtalts

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *
    * A tabela VAI no DODEFAULT: BusinessBase.Init() so instancia
    * this_oDataAccess quando recebe o parametro pcTabela. Com DODEFAULT() sem
    * argumento o objeto de acesso a dados fica .NULL. e todo metodo herdado
    * que depende dele devolve .F. reclamando que o acesso a dados nao foi
    * inicializado.
    *
    * Empresa e usuario sao resolvidos aqui porque no legado eram as variaveis
    * PUBLIC _Empr e Usuar, lidas direto dentro do Click do cmdProcessa.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigMvCcr")

            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"

            *-- Contexto da sessao (equivalente as PUBLIC _Empr e Usuar)
            IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
                THIS.this_cEmpresa = ALLTRIM(TratarNulo(go_4c_Sistema.cCodEmpresa, ""))
            ENDIF

            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEncBO.Init")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave usada por RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas de SigMvCcr (SELECT * FROM
    * SigMvCcr) para as propriedades do BO. SEMPRE usar SELECT (par_cAliasCursor)
    * antes de acessar os campos (regra #8 CLAUDE.md).
    *
    * Carrega UM lancamento de SigMvCcr - usado quando a Fase 7/8 precisar
    * reler um lancamento ja gravado (ex.: conferencia apos o Processar()).
    * As colunas de SigMvCab (this_cCab*) e os filtros da tela NAO entram aqui -
    * tem fonte propria (CarregarParametros/CarregarSaldos, Fase 4).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                IF VARTYPE(autos) = "L"
                    THIS.this_lAutos = autos
                ELSE
                    THIS.this_lAutos = (NVL(autos, 0) = 1)
                ENDIF
                IF VARTYPE(concs) = "L"
                    THIS.this_lConcs = concs
                ELSE
                    THIS.this_lConcs = (NVL(concs, 0) = 1)
                ENDIF
                THIS.this_cContages = TratarNulo(contages, "")
                THIS.this_cContas = TratarNulo(contas, "")
                THIS.this_cContems = TratarNulo(contems, "")
                THIS.this_nCotacaos = TratarNulo(cotacaos, 0)
                THIS.this_dDatalts = TratarNulo(datalts, {})
                THIS.this_dDatas = TratarNulo(datas, {})
                THIS.this_dDataconcs = TratarNulo(dataconcs, {})
                THIS.this_dDatatrans = TratarNulo(datatrans, {})
                THIS.this_dDatexcs = TratarNulo(datexcs, {})
                THIS.this_cDocus = TratarNulo(docus, "")
                THIS.this_cDopes = TratarNulo(dopes, "")
                THIS.this_dDtemis = TratarNulo(dtemis, {})
                THIS.this_cEmps = TratarNulo(emps, "")
                THIS.this_cGrupages = TratarNulo(grupages, "")
                THIS.this_cGrupems = TratarNulo(grupems, "")
                THIS.this_cGrupos = TratarNulo(grupos, "")
                THIS.this_cHists = TratarNulo(hists, "")
                THIS.this_cLocals = TratarNulo(locals, "")
                THIS.this_cMoedas = TratarNulo(moedas, "")
                THIS.this_cNfs = TratarNulo(nfs, "")
                THIS.this_nNlancs = TratarNulo(nlancs, 0)
                THIS.this_nNopers = TratarNulo(nopers, 0)
                THIS.this_nNtrans = TratarNulo(ntrans, 0)
                THIS.this_nNumes = TratarNulo(numes, 0)
                THIS.this_cOpers = TratarNulo(opers, "")
                THIS.this_nSaldocs = TratarNulo(saldocs, 0)
                THIS.this_nSaldons = TratarNulo(saldons, 0)
                THIS.this_nSaldos = TratarNulo(saldos, 0)
                THIS.this_cScontas = TratarNulo(scontas, "")
                THIS.this_nScotacaos = TratarNulo(scotacaos, 0)
                THIS.this_cSgrupos = TratarNulo(sgrupos, "")
                THIS.this_cShists = TratarNulo(shists, "")
                THIS.this_cSmoedas = TratarNulo(smoedas, "")
                THIS.this_cSopers = TratarNulo(sopers, "")
                THIS.this_nSvalors = TratarNulo(svalors, 0)
                THIS.this_cTipos = TratarNulo(tipos, "")
                THIS.this_cTitbans = TratarNulo(titbans, "")
                THIS.this_cTitulos = TratarNulo(titulos, "")
                THIS.this_cUsualts = TratarNulo(usualts, "")
                THIS.this_cUsuexcs = TratarNulo(usuexcs, "")
                THIS.this_nValliqs = TratarNulo(valliqs, 0)
                THIS.this_nValocurs = TratarNulo(valocurs, 0)
                THIS.this_nValors = TratarNulo(valors, 0)
                THIS.this_nValpags = TratarNulo(valpags, 0)
                THIS.this_dVencs = TratarNulo(vencs, {})
                THIS.this_cVlancs = TratarNulo(vlancs, "")
                THIS.this_cVopers = TratarNulo(vopers, "")
                THIS.this_nContapgs = TratarNulo(contapgs, 0)
                THIS.this_cDopcs = TratarNulo(dopcs, "")
                THIS.this_nNumcs = TratarNulo(numcs, 0)
                THIS.this_cCotusus = TratarNulo(cotusus, "")
                THIS.this_cBcontas = TratarNulo(bcontas, "")
                THIS.this_cBgrupos = TratarNulo(bgrupos, "")
                THIS.this_nBorderos = TratarNulo(borderos, 0)
                THIS.this_cHist2s = TratarNulo(hist2s, "")
                THIS.this_nIntconts = TratarNulo(intconts, 0)
                THIS.this_cUsuconcs = TratarNulo(usuconcs, "")
                THIS.this_cAuditors = TratarNulo(auditors, "")
                THIS.this_dDtaudits = TratarNulo(dtaudits, {})
                THIS.this_nValprev = TratarNulo(valprev, 0)
                THIS.this_cEmpdopncs = TratarNulo(empdopncs, "")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")
                THIS.this_cGruconmoes = TratarNulo(gruconmoes, "")
                THIS.this_cPagos = TratarNulo(pagos, "")
                THIS.this_cDopotps = TratarNulo(dopotps, "")
                THIS.this_cUsupagos = TratarNulo(usupagos, "")
                THIS.this_nTitcancs = TratarNulo(titcancs, 0)
                THIS.this_dDtconfs = TratarNulo(dtconfs, {})
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "")
                THIS.this_nNopercancs = TratarNulo(nopercancs, 0)
                THIS.this_cEspecienfs = TratarNulo(especienfs, "")
                THIS.this_cJobs = TratarNulo(jobs, "")
                THIS.this_nImpostos = TratarNulo(impostos, 0)
                THIS.this_nTpimpostos = TratarNulo(tpimpostos, 0)
                THIS.this_cTitpais = TratarNulo(titpais, "")
                THIS.this_cEmpccs = TratarNulo(empccs, "")
                THIS.this_nRecor = TratarNulo(recor, 0)
                THIS.this_cCompet = TratarNulo(compet, "")
                THIS.this_cEmpos = TratarNulo(empos, "")
                THIS.this_cOridopnums = TratarNulo(oridopnums, "")
                THIS.this_cPastas = TratarNulo(pastas, "")
                THIS.this_cRcontas = TratarNulo(rcontas, "")
                THIS.this_cTpdocnf = TratarNulo(tpdocnf, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SigOpEncBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarSaldos - Popula cursor_4c_Saldos com os saldos das contas do
    * grupo filtrado. Equivalente ao MontaTela() do legado (SIGOPENC).
    *
    * Consulta TRANSCRITA do legado (criterio de selecao e regra de negocio -
    * regra #17 CLAUDE.md):
    *   Select a.emps, a.grupos, a.contas, a.moedas, a.saldos, b.Rclis,
    *          b.Situas, 0 as Flag, 0 as Marcas
    *     From SigMvSlc a, SigCdCli b
    *    Where a.grupos = '<grupo>' [And a.Contas = '<conta>']
    *      And a.Contas = b.Iclis And a.Saldos <> 0
    * Order By a.Contas, a.Moedas
    *
    * O SENTINELA 'ZYWZYWZYWZ' para grupo vazio e DO LEGADO e NAO e
    * descartavel: o filtro e aplicado SEMPRE, inclusive vazio, e com o
    * sentinela a consulta nao casa nada - a grade abre VAZIA de proposito,
    * esperando o usuario escolher o grupo (regra #35a). Trocar por "sem
    * WHERE" traria a tabela INTEIRA.
    *
    * NAO filtra por empresa nem por Situas: o legado SELECIONA a.emps e
    * b.Situas mas nao os usa no WHERE - acrescentar filtro que o legado nao
    * tem e inventar regra de negocio.
    *
    * Colunas conferidas no schema canonico: SigMvSlc(emps char(3),
    * grupos char(10), contas char(10), moedas char(3), saldos numeric(13,2))
    * e SigCdCli(iclis char(10), rclis char(50), situas char(3)). SigMvSlc e
    * tabela de MOVIMENTO e usa emps SEM o prefixo C (regra #48).
    *
    * O SQLEXEC vai para cursor TEMPORARIO e o cursor da grade e recarregado
    * com ZAP + APPEND FROM DBF(): SQLEXEC direto sobre o alias da grade
    * FECHA e RECRIA o alias, zerando o ColumnCount e destruindo o Check1 que
    * a Column5 recebeu por AddObject. O APPEND casa as colunas por NOME,
    * por isso a lista do SELECT e a do CREATE CURSOR do form sao identicas.
    *==========================================================================
    PROCEDURE CarregarSaldos()
        LOCAL loc_cSQL, loc_cGrupo, loc_cConta, loc_cCursor, loc_cTmp
        LOCAL loc_nResult, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorSaldos
        loc_cTmp     = "cursor_4c_SaldosTmp"

        TRY
            *-- Sentinela do legado: grupo vazio nao casa nenhum registro
            loc_cGrupo = ALLTRIM(TratarNulo(THIS.this_cGrupoFiltro, ""))
            IF EMPTY(loc_cGrupo)
                loc_cGrupo = "ZYWZYWZYWZ"
            ENDIF
            loc_cConta = ALLTRIM(TratarNulo(THIS.this_cContaFiltro, ""))

            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "Cursor de saldos (" + loc_cCursor + ;
                    ") nao inicializado."
                MsgErro(THIS.this_cMensagemErro, "SigOpEncBO.CarregarSaldos")
                THIS.this_lErroExibido = .T.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    *-- Sem conexao (modo teste / validacao de UI): grade vazia,
                    *-- mesmo resultado visual do sentinela
                    SELECT (loc_cCursor)
                    ZAP
                    loc_lSucesso = .T.
                ELSE
                    loc_cSQL = "SELECT a.emps, a.grupos, a.contas, a.moedas," + ;
                        " a.saldos, b.rclis, b.situas," + ;
                        " 0 AS flag, 0 AS marcas" + ;
                        " FROM SigMvSlc a, SigCdCli b" + ;
                        " WHERE a.grupos = " + EscaparSQL(loc_cGrupo)

                    IF !EMPTY(loc_cConta)
                        loc_cSQL = loc_cSQL + ;
                            " AND a.contas = " + EscaparSQL(loc_cConta)
                    ENDIF

                    loc_cSQL = loc_cSQL + ;
                        " AND a.contas = b.iclis" + ;
                        " AND a.saldos <> 0" + ;
                        " ORDER BY a.contas, a.moedas"

                    IF USED(loc_cTmp)
                        IF CURSORGETPROP("Buffering", loc_cTmp) > 1
                            TABLEREVERT(.T., loc_cTmp)
                        ENDIF
                        USE IN (loc_cTmp)
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTmp)

                    IF loc_nResult >= 0
                        SELECT (loc_cCursor)
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF(loc_cTmp)
                        SET NULL OFF
                        loc_lSucesso = .T.
                    ELSE
                        *-- Mensagem do legado: MessageBox('Favor Reinicializar o
                        *-- Processo!!!', 16, 'Falha na Conexao (crSigMvSlc)')
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
                        THIS.this_lErroExibido = .T.
                    ENDIF

                    IF USED(loc_cTmp)
                        USE IN (loc_cTmp)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    SELECT (loc_cCursor)
                    GO TOP
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEncBO.CarregarSaldos")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere um lancamento de encerramento em SigMvCcr
    *
    * Equivalente ao bloco "Select CrSigMvCcr / Append Blank / Replace ..." do
    * cmdProcessa.Click do legado, para UMA conta. A PK (cidchaves) e gerada
    * via fUniqueIds() se ainda nao preenchida (regra #22 CLAUDE.md); o legado
    * monta a chave so depois do SCAN inteiro (Dtos(Datas)+fGerUniqueKey+SigKey),
    * mas fUniqueIds() e o gerador de PK canonico do projeto e evita colisao no
    * indice unico sem depender de SigKey/fGerUniqueKey, que nao foram portados.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = THIS.MontarSQLInsertCcr()

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento de encerramento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                THIS.this_nLancamentosGerados = THIS.this_nLancamentosGerados + 1
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SigOpEncBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarSQLInsertCcr - Monta (sem executar) a instrucao INSERT INTO
    * SigMvCcr com os valores correntes das propriedades this_*. Extraido de
    * Inserir() para ser reutilizado por ProcessarEncerramento(), que precisa
    * encadear VARIOS INSERT (um lancamento + a contra-partida, para cada
    * conta marcada) num UNICO lote atomico (SAVE TRANSACTION) - regra
    * CLAUDE.md sobre BEGIN/COMMIT via SQLEXEC nao proteger operacao
    * multi-statement; aqui a atomicidade vem de mandar tudo em UM SQLEXEC.
    *==========================================================================
    PROTECTED FUNCTION MontarSQLInsertCcr()
        LOCAL loc_cSQL

        IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
            THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
        ENDIF

        IF EMPTY(ALLTRIM(NVL(THIS.this_cEmps, "")))
            THIS.this_cEmps = THIS.this_cEmpresa
        ENDIF

        THIS.this_cUsualts = THIS.this_cUsuario
        THIS.this_dDatalts = DATETIME()

        *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
        THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

        *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
        THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
        THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

        *-- Campo computado: Pagos - '0' se valor pago igual ao valor do lancamento
        THIS.this_cPagos = IIF(THIS.this_nValors = THIS.this_nValpags, "0", "1")

        *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCcr ("
            loc_cSQL = loc_cSQL + "cidchaves, autos, concs, contages, contas, contems, cotacaos, datalts,"
            loc_cSQL = loc_cSQL + "datas, dataconcs, datatrans, datexcs, docus, dopes, dtemis, emps,"
            loc_cSQL = loc_cSQL + "grupages, grupems, grupos, hists, locals, moedas, nfs, nlancs,"
            loc_cSQL = loc_cSQL + "nopers, ntrans, numes, opers, saldocs, saldons, saldos, scontas,"
            loc_cSQL = loc_cSQL + "scotacaos, sgrupos, shists, smoedas, sopers, svalors, tipos, titbans,"
            loc_cSQL = loc_cSQL + "titulos, usualts, usuexcs, valliqs, valocurs, valors, valpags, vencs,"
            loc_cSQL = loc_cSQL + "vlancs, vopers, contapgs, dopcs, numcs, cotusus, bcontas, bgrupos,"
            loc_cSQL = loc_cSQL + "borderos, hist2s, intconts, usuconcs, auditors, dtaudits, valprev, empdopncs,"
            loc_cSQL = loc_cSQL + "empdopnums, gruconmoes, pagos, dopotps, usupagos, titcancs, dtconfs, usuconfs,"
            loc_cSQL = loc_cSQL + "nopercancs, especienfs, jobs, impostos, tpimpostos, titpais, empccs, recor,"
            loc_cSQL = loc_cSQL + "compet, empos, oridopnums, pastas, rcontas, tpdocnf"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lAutos, "1", "0") + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lConcs, "1", "0") + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2)) + ")"

        RETURN loc_cSQL
    ENDFUNC

    *==========================================================================
    * CarregarParametros - Le o parametro SigCdPac (sigkeys e dopzers), igual
    * ao bloco do Init do legado:
    *   ThisForm.poDataMgr.CursorQuery('SigCdPac', 'crSigCdPac')
    *   ThisForm.SigKey = CrSigCdPac.SigKeys
    *   ThisForm.Container1.Get_Dope.Value = CrSigCdPac.DopZers
    *
    * this_cSigKey fica guardado para a fase de Processar (fase 7/8), que monta
    * a PK cidchaves (Dtos(Datas) + fGerUniqueKey + SigKey do legado).
    * this_cOperacao e o valor que o Form copia para txt_4c_Dope.Value.
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_cCursor, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorParametros

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Sem conexao (modo teste / validacao de UI): segue sem parametros
                loc_lSucesso = .T.
            ELSE
                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT sigkeys, dopzers FROM SigCdPac", loc_cCursor)

                IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                    SELECT (loc_cCursor)
                    GO TOP
                    THIS.this_cSigKey   = ALLTRIM(TratarNulo(sigkeys, ""))
                    THIS.this_cOperacao = ALLTRIM(TratarNulo(dopzers, ""))
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + ;
                        "o de Par" + CHR(226) + "metros do Sistema (SigCdPac) n" + CHR(227) + "o encontrada."
                    MsgErro(THIS.this_cMensagemErro, "SigOpEncBO.CarregarParametros")
                    THIS.this_lErroExibido = .T.
                ENDIF

                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEncBO.CarregarParametros")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza um lancamento existente de SigMvCcr (por cidchaves)
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsualts = THIS.this_cUsuario
            THIS.this_dDatalts = DATETIME()

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Campo computado: Pagos - '0' se valor pago igual ao valor do lancamento
            THIS.this_cPagos = IIF(THIS.this_nValors = THIS.this_nValpags, "0", "1")

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCcr SET"
            loc_cSQL = loc_cSQL + " autos = " + IIF(THIS.this_lAutos, "1", "0") + ","
            loc_cSQL = loc_cSQL + " concs = " + IIF(THIS.this_lConcs, "1", "0") + ","
            loc_cSQL = loc_cSQL + " contages = " + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + " contems = " + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + " cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " datalts = " + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dataconcs = " + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + " datexcs = " + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + " docus = " + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grupages = " + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + " grupems = " + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " hists = " + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " nfs = " + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nlancs = " + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + " nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + " saldocs = " + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + " saldons = " + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + " saldos = " + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + " scontas = " + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + " scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " sgrupos = " + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " shists = " + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + " smoedas = " + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " sopers = " + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + " svalors = " + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + " tipos = " + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + " titbans = " + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + " titulos = " + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + " usualts = " + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + " usuexcs = " + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + " valliqs = " + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + " valocurs = " + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + " valpags = " + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + " vencs = " + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + " vlancs = " + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + " vopers = " + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + " contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + " dopcs = " + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + " numcs = " + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + " cotusus = " + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + " bcontas = " + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " bgrupos = " + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " borderos = " + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + " hist2s = " + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + " intconts = " + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + " usuconcs = " + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + " dtaudits = " + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + " valprev = " + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + " empdopncs = " + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " gruconmoes = " + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + " pagos = " + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + " dopotps = " + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + " usupagos = " + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + " titcancs = " + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + " dtconfs = " + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + " usuconfs = " + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nopercancs = " + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + " jobs = " + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + " impostos = " + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + " tpimpostos = " + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + " titpais = " + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + " empccs = " + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + " recor = " + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + " compet = " + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + " empos = " + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + " oridopnums = " + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " pastas = " + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + " rcontas = " + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " tpdocnf = " + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento de encerramento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SigOpEncBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ProcessarEncerramento - cmdProcessa.Click do legado: para CADA conta
    * marcada (Marcas = 1) na grade de saldos, gera DOIS lancamentos em
    * SigMvCcr que se espelham (debito/credito trocados, grupo/conta trocados
    * entre a conta original e a contra-partida) - a dupla entrada que
    * encerra o saldo da conta original contra o grupo/conta informados em
    * par_cGrupoC/par_cContaC. O cabecalho do movimento (SigMvCab) e criado
    * UMA vez por execucao (o legado tambem cria so um, porque ZAPa a propria
    * cursor local a cada clique e faz o Seek contra ela, nao contra o banco).
    *
    * par_cGrupo/par_cGrupoC/par_cContaC/par_cDope chegam do Form, ja
    * validados la (os 4 guards do Click legado: "Obrigatorio Informar o
    * Grupo de Filtro", "Grupo de Contra-Partida nao Informado", "Conta de
    * Contra-Partida nao informada", "Operacao de Mov.Estoque nao cadastrada
    * nos Parametros do Sistema").
    *
    * ATOMICIDADE: BEGIN/COMMIT TRANSACTION mandados via SQLEXEC NAO protegem
    * operacao multi-statement nesta conexao (Transactions=2 MANUAL faz o
    * par so aninhar - regra CLAUDE.md). O cabecalho + os N*2 lancamentos vao
    * num UNICO SQLEXEC, com o SAVE TRANSACTION/TRY/CATCH/THROW do T-SQL
    * (mesmo padrao de SigOpBcbBO.prg:Inserir()) - assim, se qualquer INSERT
    * falhar, nenhum dos outros fica gravado.
    *
    * this_lEmLookup nao se aplica aqui (nao ha picker); a guarda de
    * reentrancia do Processar fica no proprio Form (botao so clicavel uma
    * vez por vez, Click nao e reentrante).
    *==========================================================================
    PROCEDURE ProcessarEncerramento(par_cGrupo, par_cGrupoC, par_cContaC, par_cDope)
        LOCAL loc_cCursor, loc_cBatch, loc_cFrag, loc_nResult, loc_lSucesso, loc_lManual
        LOCAL loc_cEmpresa, loc_xOper, loc_xsOper, loc_nValor, loc_nOper, loc_cVOper, loc_nCota
        LOCAL loc_cHist, loc_cHist2, loc_dAgora, loc_oErro

        loc_lSucesso = .F.
        loc_lManual  = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
        loc_cCursor  = THIS.this_cCursorSaldos
        loc_cEmpresa = THIS.this_cEmpresa
        loc_dAgora   = DATETIME()

        TRY
            IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
                THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " saldos carregados para processar."
                MsgErro(THIS.this_cMensagemErro, "SigOpEncBO.ProcessarEncerramento")
                THIS.this_lErroExibido = .T.
            ELSE
                *-- Cabecalho do movimento - gerado UMA vez por execucao
                *-- (Insert Into CrSigMvCab do legado, antes do Seek achar um
                *-- ja existente NA MESMA execucao)
                THIS.this_cCabEmps       = loc_cEmpresa
                THIS.this_cCabDopes      = par_cDope
                THIS.this_nCabNumes      = fGerUniqueKey(ALLTRIM(par_cDope) + loc_cEmpresa)

                IF THIS.this_nCabNumes = 0
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar o n" + ;
                        CHR(250) + "mero do movimento (SigMvCab)."
                    MsgErro(THIS.this_cMensagemErro, "SigOpEncBO.ProcessarEncerramento")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.this_cCabMascnum    = fGerMascara(THIS.this_nCabNumes)
                    THIS.this_cCabEmpdopnums = PADR(loc_cEmpresa, 3) + PADR(par_cDope, 20) + STR(THIS.this_nCabNumes, 6)
                    THIS.this_cCabCidchaves  = LEFT(fUniqueIds(), 20)
                    THIS.this_cCabUsuars     = THIS.this_cUsuario
                    THIS.this_dCabDatars     = loc_dAgora
                    THIS.this_dCabDatas      = loc_dAgora
                    THIS.this_dCabDtalts     = loc_dAgora

                    *-- cursor_4c_PendAud guarda so os cidchaves de SigMvCcr -
                    *-- RegistrarAuditoria() usa THIS.this_cTabela ("SigMvCcr",
                    *-- fixado no Init), entao o cabecalho (SigMvCab) nao entra
                    *-- aqui para nao ser auditado com a tabela errada.
                    IF USED("cursor_4c_PendAud")
                        USE IN cursor_4c_PendAud
                    ENDIF
                    SET NULL ON
                    CREATE CURSOR cursor_4c_PendAud (cidchaves C(20))
                    SET NULL OFF

                    loc_cBatch = "SET NOCOUNT ON; " + ;
                        "DECLARE @nivel4c int = @@TRANCOUNT; " + ;
                        "IF @nivel4c = 0 BEGIN TRANSACTION " + ;
                        "ELSE SAVE TRANSACTION Enc4c; " + ;
                        "BEGIN TRY " + ;
                        THIS.MontarSQLInsertCab() + "; "

                    THIS.this_nContasProcessadas = 0

                    SELECT (loc_cCursor)
                    SCAN FOR marcas = 1
                        SCATTER MEMVAR

                        REPLACE flag WITH 1

                        loc_xOper  = IIF(m.saldos > 0, "C", "D")
                        loc_xsOper = IIF(loc_xOper = "C", "D", "C")
                        loc_nValor = ABS(m.saldos)
                        loc_nOper  = fGerUniqueKey("SigMvCcr")
                        loc_cVOper = loc_cEmpresa + ALLTRIM(STR(loc_nOper, 9))
                        loc_nCota  = fBuscarCotacao(m.moedas, DATE(), gnConnHandle)
                        loc_cHist  = "Encerramento de conta - Grupo:" + ALLTRIM(par_cGrupo)
                        loc_cHist2 = "com Contra-Partida:" + ALLTRIM(par_cGrupoC) + "-" + ALLTRIM(par_cContaC)

                        *-- Entrada DIRETA: encerra a conta do saldo marcado
                        *-- (Select CrSigMvCcr / Append Blank / Replace ... do
                        *-- cmdProcessa.Click)
                        THIS.this_cCidchaves = ""
                        THIS.this_cEmps      = loc_cEmpresa
                        THIS.this_lAutos     = .T.
                        THIS.this_nNopers    = loc_nOper
                        THIS.this_cVopers    = loc_cVOper
                        THIS.this_cOpers     = loc_xOper
                        THIS.this_cSopers    = loc_xsOper
                        THIS.this_cGrupos    = m.grupos
                        THIS.this_cContas    = m.contas
                        THIS.this_cSgrupos   = par_cGrupoC
                        THIS.this_cScontas   = par_cContaC
                        THIS.this_cMoedas    = m.moedas
                        THIS.this_cSmoedas   = m.moedas
                        THIS.this_nCotacaos  = loc_nCota
                        THIS.this_nScotacaos = loc_nCota
                        THIS.this_cDopes     = par_cDope
                        THIS.this_nNumes     = THIS.this_nCabNumes
                        THIS.this_cHists     = loc_cHist
                        THIS.this_cHist2s    = loc_cHist2
                        THIS.this_nValors    = loc_nValor
                        THIS.this_nSvalors   = loc_nValor
                        THIS.this_dDatas     = loc_dAgora
                        THIS.this_dVencs     = loc_dAgora
                        THIS.this_nNlancs    = 0
                        THIS.this_cVlancs    = ""
                        THIS.this_nValpags   = 0

                        loc_cFrag = THIS.MontarSQLInsertCcr()
                        loc_cBatch = loc_cBatch + loc_cFrag + "; "
                        INSERT INTO cursor_4c_PendAud (cidchaves) VALUES (THIS.this_cCidchaves)

                        fRecalculaS(THIS.this_cGrupos, THIS.this_cContas, THIS.this_dDatas, THIS.this_cMoedas, gnConnHandle)

                        *-- Entrada CONTRA-PARTIDA (FazContra do legado): MESMO
                        *-- NOpers/VOpers/Moedas/Cotacaos/Valors/Datas/Dopes/
                        *-- Numes/Hists/Hist2s da entrada direta, so com
                        *-- Grupos/Contas/Opers invertidos com SGrupos/SContas/
                        *-- SOpers - e Autos fica .F. (FazContra nao seta Autos)
                        THIS.this_cCidchaves = ""
                        THIS.this_lAutos     = .F.
                        THIS.this_cGrupos    = par_cGrupoC
                        THIS.this_cContas    = par_cContaC
                        THIS.this_cOpers     = loc_xsOper
                        THIS.this_cSgrupos   = m.grupos
                        THIS.this_cScontas   = m.contas
                        THIS.this_cSopers    = loc_xOper

                        loc_cFrag = THIS.MontarSQLInsertCcr()
                        loc_cBatch = loc_cBatch + loc_cFrag + "; "
                        INSERT INTO cursor_4c_PendAud (cidchaves) VALUES (THIS.this_cCidchaves)

                        fRecalculaS(THIS.this_cGrupos, THIS.this_cContas, THIS.this_dDatas, THIS.this_cMoedas, gnConnHandle)

                        THIS.this_nContasProcessadas = THIS.this_nContasProcessadas + 1
                    ENDSCAN

                    IF THIS.this_nContasProcessadas = 0
                        THIS.this_cMensagemErro = "Nenhuma Conta Selecionada!"
                        MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_cBatch = loc_cBatch + ;
                            "IF @nivel4c = 0 COMMIT TRANSACTION; " + ;
                            "END TRY " + ;
                            "BEGIN CATCH " + ;
                            "IF @nivel4c = 0 " + ;
                            "BEGIN " + ;
                            "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; " + ;
                            "END " + ;
                            "ELSE " + ;
                            "BEGIN " + ;
                            "IF XACT_STATE() = 1 ROLLBACK TRANSACTION Enc4c; " + ;
                            "END; " + ;
                            "THROW; " + ;
                            "END CATCH"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cBatch)

                        IF loc_nResult < 0
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                            MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                                "Falha no Processamento do Encerramento")
                            THIS.this_lErroExibido = .T.
                        ELSE
                            IF !fRecalculaS(.T., gnConnHandle)
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                                MsgErro(THIS.this_cMensagemErro, "Falha no Rec" + CHR(225) + "lculo de Saldos (SigOpClS)")
                                THIS.this_lErroExibido = .T.
                            ELSE
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF

                        IF loc_lManual
                            IF loc_lSucesso
                                = SQLCOMMIT(gnConnHandle)
                            ELSE
                                = SQLROLLBACK(gnConnHandle)
                            ENDIF
                        ENDIF

                        IF loc_lSucesso
                            SELECT cursor_4c_PendAud
                            SCAN
                                THIS.this_cCidchaves = cidchaves
                                THIS.RegistrarAuditoria("INSERT")
                            ENDSCAN

                            THIS.this_nLancamentosGerados = THIS.this_nLancamentosGerados + (THIS.this_nContasProcessadas * 2)
                            THIS.this_nCabecalhosGerados  = THIS.this_nCabecalhosGerados + 1
                        ENDIF
                    ENDIF

                    IF USED("cursor_4c_PendAud")
                        USE IN cursor_4c_PendAud
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEncBO.ProcessarEncerramento")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarSQLInsertCab - Monta (sem executar) o INSERT INTO SigMvCab do
    * cabecalho do movimento. Colunas primarias (Emps, Dopes, Numes, Usuars,
    * Datars, Datas, MascNum, EmpDopNums, cIdChaves, DtAlts) iguais as que o
    * legado grava explicitamente ("Insert Into CrSigMvCab (Emps, Dopes,
    * Numes, Usuars, Datars, Datas, MascNum, EmpDopNums, CidChaves, DtAlts)").
    *
    * As demais colunas NOT NULL sem DEFAULT no banco (regra CLAUDE.md #22) -
    * SigMvCab tem ~90 delas, a maioria de dominios completamente estranhos a
    * este form (pedido, nota fiscal, boleto) - usam a MESMA lista e os
    * MESMOS defaults ja provados contra o schema em
    * SigOpBcbBO.prg:Inserir() (mesma tabela). "grupoos" e
    * "contaos" sao acrescentados ao FINAL de cada lista porque la eles eram
    * preenchidos com o grupo/conta do codigo de barras - aqui o legado nao
    * tem valor equivalente, entao ficam no default "" como os demais.
    *==========================================================================
    PROTECTED FUNCTION MontarSQLInsertCab()
        LOCAL loc_cColsCab, loc_cValsCab, loc_cSQL

        loc_cColsCab = "npedclis, acres, antecs, chksubn, codpeds, contads, " + ;
            "desc2s, descs, devols, empds, grresps, grupods, " + ;
            "grupos, grvends, iclis, ifors, locals, lotechqs, " + ;
            "lprecos, ncarnecs, nemps, nops, notas, nrcons, " + ;
            "ntrans, numolds, opers, resps, tabds, tpfats, " + ;
            "transps, usuals, usulibs, valacres, valdes2s, valdescs, " + ;
            "valdevs, valencs, valinis, valos, valservs, valvars, " + ;
            "vars, vends, cotusus, espes, qtdes, lcancelas, " + ;
            "cofs, livros, chkbxparcs, ecfs, codobs, dgopes, " + ;
            "trfisicos, utilizados, valndevs, valobxs, noforms, auditors, " + ;
            "empgopnums, contaes, localents, localizas, chkpagos, chkpgs, " + ;
            "codtrans, empdnbxs, empdncrds, obsagends, operadors, vcompensas, " + ;
            "motdscs, ndeclaras, numbalds, numbals, priors, procbals, " + ;
            "procdbal, protats, usupagos, ultgrvs, moeits, rnops, " + ;
            "impress, pstatus, valvarps, cifccfs, cupfis, idconta, " + ;
            "ncupoms, status, valtrans, impcpfs, ccfgnfs, fpubls, " + ;
            "jobs, ptax1s, ptax2s, ptax3s, obscabmovs, codobs2, " + ;
            "grupoos, contaos"

        loc_cValsCab = FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,4) + ", " + EscaparSQL("") + ", " + "0" + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,4) + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
            FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
            FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,4) + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + "0" + ", " + ;
            "0" + ", " + "0" + ", " + "0" + ", " + EscaparSQL("") + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + ;
            FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + ;
            "0" + ", " + "0" + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + ;
            EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + "0" + ", " + "0" + ", " + FormatarNumeroSQL(0,0) + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,0) + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + EscaparSQL("") + ", " + ;
            FormatarNumeroSQL(0,0) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + FormatarNumeroSQL(0,2) + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("") + ", " + ;
            EscaparSQL("") + ", " + EscaparSQL("")

        loc_cSQL = "INSERT INTO SigMvCab (Emps, Dopes, Numes, Usuars, Datars, Datas, MascNum, EmpDopNums, cIdChaves, DtAlts, " + loc_cColsCab + ") "
        loc_cSQL = loc_cSQL + "VALUES (" + EscaparSQL(THIS.this_cCabEmps) + ", " + EscaparSQL(THIS.this_cCabDopes) + ", " + ;
            FormatarNumeroSQL(THIS.this_nCabNumes, 0) + ", " + EscaparSQL(THIS.this_cCabUsuars) + ", " + ;
            FormatarDataSQL(THIS.this_dCabDatars) + ", " + FormatarDataSQL(THIS.this_dCabDatas) + ", " + ;
            EscaparSQL(THIS.this_cCabMascnum) + ", " + EscaparSQL(THIS.this_cCabEmpdopnums) + ", " + ;
            EscaparSQL(THIS.this_cCabCidchaves) + ", " + FormatarDataSQL(THIS.this_dCabDtalts) + ", " + loc_cValsCab + ")"

        RETURN loc_cSQL
    ENDFUNC

ENDDEFINE
