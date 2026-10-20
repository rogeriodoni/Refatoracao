*============================================================================
* sigopaccBO.prg - Business Object para Lancamento de Conta Corrente
*
* Tabela principal : SigMvCcr  (PK: cidchaves char(20))
* Lookup grupo/conta: SigCdGrp / SigCdCta (ou equivalentes, grupo+conta normal e contrapartida)
* Lookup emissor    : SigCdGrp / SigCdCta (GrupEms / ContEms)
* Lookup job         : SigCdJob (ou equivalente)
* Lookup moeda       : SigCdMoe
*
* Este BO suporta um dialogo OPERACIONAL de ALTERACAO de um lancamento
* ja existente de SigMvCcr (edicao pontual de um registro de movimento de
* conta corrente), espelhando o comportamento do legado SIGOPACC.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS sigopaccBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigMvCcr (campos do banco - chave e dados)
    *==========================================================================
    this_cCidchaves = ""   && char(20)      - Chave primaria (PK, fUniqueIds())
    this_dDatas      = {}  && datetime NULL - Data do lancamento
    this_cOpers      = ""  && char(1)       - Operacao (D/C)
    this_cDocus      = ""  && char(10)      - Documento
    this_cNfs        = ""  && char(10)      - Nota Fiscal
    this_nValors     = 0   && numeric(11,2) - Valor
    this_nCotacaos   = 0   && numeric(15,7) - Cotacao
    this_dVencs      = {}  && datetime NULL - Vencimento
    this_cHists      = ""  && char(60)      - Historico
    this_cHist2s     = ""  && char(80)      - Historico complementar
    this_cSopers     = ""  && char(1)       - Operacao contrapartida (D/C)
    this_nSvalors    = 0   && numeric(11,2) - Valor contrapartida
    this_nScotacaos  = 0   && numeric(15,7) - Cotacao contrapartida
    this_cGrupos     = ""  && char(10)      - Grupo
    this_cContas     = ""  && char(10)      - Conta
    this_cSgrupos    = ""  && char(10)      - Grupo contrapartida
    this_cScontas    = ""  && char(10)      - Conta contrapartida
    this_cMoedas     = ""  && char(3)       - Moeda
    this_cSmoedas    = ""  && char(3)       - Moeda contrapartida
    this_cGrupems    = ""  && char(10)      - Grupo emissor
    this_cContems    = ""  && char(10)      - Conta emissor
    this_cJobs       = ""  && char(10)      - Job
    this_nContapgs   = 0   && numeric(1,0)  - Conta a Pagar (flag/opcao do lancamento original)
    this_cCotusus    = ""  && char(10)      - Usuario que alterou a cotacao

    *==========================================================================
    * Propriedades das demais colunas de SigMvCcr (nao editadas na tela, mas
    * obrigatorias no INSERT - regra #22 CLAUDE.md: INSERT cobre TODA coluna
    * NOT NULL). Nomeadas como as colunas do schema (docs/schema.sql).
    *==========================================================================
    this_lAutos      = .F.  && bit           - autos
    this_lConcs      = .F.  && bit           - concs
    this_cContages   = ""   && char(10)      - contages
    this_dDatalts    = {}   && datetime NULL - datalts (data de alteracao)
    this_dDataconcs  = {}   && datetime NULL - dataconcs
    this_dDatatrans  = {}   && datetime NULL - datatrans
    this_dDatexcs    = {}   && datetime NULL - datexcs
    this_cDopes      = ""   && char(20)      - dopes
    this_dDtemis     = {}   && datetime NULL - dtemis
    this_cEmps       = ""   && char(3)       - emps (empresa)
    this_cGrupages   = ""   && char(10)      - grupages
    this_cLocals     = ""   && char(10)      - locals
    this_nNlancs     = 0    && numeric(6,0)  - nlancs
    this_nNopers     = 0    && numeric(7,0)  - nopers (numero da operacao)
    this_nNtrans     = 0    && numeric(6,0)  - ntrans
    this_nNumes      = 0    && numeric(6,0)  - numes
    this_nSaldocs    = 0    && numeric(15,2) - saldocs
    this_nSaldons    = 0    && numeric(15,2) - saldons
    this_nSaldos     = 0    && numeric(15,2) - saldos
    this_cShists     = ""   && char(40)      - shists
    this_cTipos      = ""   && char(1)       - tipos
    this_cTitbans    = ""   && char(12)      - titbans
    this_cTitulos    = ""   && char(10)      - titulos
    this_cUsualts    = ""   && char(10)      - usualts (usuario que alterou)
    this_cUsuexcs    = ""   && char(10)      - usuexcs
    this_nValliqs    = 0    && numeric(11,2) - valliqs
    this_nValocurs   = 0    && numeric(11,2) - valocurs
    this_nValpags    = 0    && numeric(11,2) - valpags
    this_cVlancs     = ""   && char(10)      - vlancs
    this_cVopers     = ""   && char(13)      - vopers
    this_cDopcs      = ""   && char(20)      - dopcs
    this_nNumcs      = 0    && numeric(6,0)  - numcs
    this_cBcontas    = ""   && char(10)      - bcontas
    this_cBgrupos    = ""   && char(10)      - bgrupos
    this_nBorderos   = 0    && numeric(6,0)  - borderos
    this_nIntconts   = 0    && numeric(6,0)  - intconts
    this_cUsuconcs   = ""   && char(10)      - usuconcs
    this_cAuditors   = ""   && char(10)      - auditors
    this_dDtaudits   = {}   && datetime NULL - dtaudits
    this_nValprev    = 0    && numeric(11,2) - valprev
    this_cEmpdopncs  = ""   && char(29)      - empdopncs (posicional: emps+dopes+numcs)
    this_cEmpdopnums = ""   && char(29)      - empdopnums (posicional: emps+dopes+numes)
    this_cGruconmoes = ""   && char(23)      - gruconmoes (grupos+contas+moedas)
    this_cPagos      = ""   && char(1)       - pagos (0/1 conforme valors = valpags)
    this_cDopotps    = ""   && char(23)      - dopotps
    this_cUsupagos   = ""   && char(10)      - usupagos
    this_nTitcancs   = 0    && numeric(1,0)  - titcancs
    this_dDtconfs    = {}   && datetime NULL - dtconfs
    this_cUsuconfs   = ""   && char(10)      - usuconfs
    this_nNopercancs = 0    && numeric(7,0)  - nopercancs
    this_cEspecienfs = ""   && char(6)       - especienfs
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
    * Propriedades de controle da tela - nao persistidas diretamente
    *==========================================================================
    this_cUsuario     = ""  && Usuario corrente exibido no cabecalho (auditoria)
    this_nOpcaoConta  = 0   && OptionGroup Acerto (D/C) - indice 1-based

    *==========================================================================
    * Propriedades de exibicao (descricoes de lookup) - nao armazenadas no banco
    *==========================================================================
    this_cDescGrupo    = ""  && Descricao do Grupo (this_cGrupos)
    this_cDescConta    = ""  && Descricao da Conta (this_cContas)
    this_cDescSGrupo   = ""  && Descricao do Grupo contrapartida (this_cSgrupos)
    this_cDescSConta   = ""  && Descricao da Conta contrapartida (this_cScontas)
    this_cDescGrupEms  = ""  && Descricao do Grupo emissor (this_cGrupems)
    this_cDescContEms  = ""  && Descricao da Conta emissor (this_cContems)
    this_cDescJob      = ""  && Descricao do Job (this_cJobs)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            *-- A tabela TEM de ir no DODEFAULT: BusinessBase.Init() so cria
            *-- this_oDataAccess quando recebe pcTabela. Com DODEFAULT() vazio
            *-- o objeto de acesso a dados fica .NULL. e todo metodo herdado
            *-- que depende dele (Buscar) devolve .F. com "Objeto de acesso a
            *-- dados nao inicializado".
            DODEFAULT("SigMvCcr")
            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para uso em
    * RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *==========================================================================
    * CarregarPorChave - Le UM lancamento de SigMvCcr pela PK (cidchaves) e
    * popula as propriedades do BO atraves de CarregarDoCursor().
    *
    * No legado o registro ja chegava posicionado: o form pai mantinha o cursor
    * crAltcc e o SIGOPACC lia tudo por ControlSource. A arquitetura nova nao
    * compartilha cursor entre telas, entao quem abre o dialogo passa a PK e o
    * BO busca o registro.
    *
    * SQLEXEC direto (mesmo estilo de Inserir/Atualizar deste BO) em vez do
    * Buscar() herdado: aqui o nome do cursor e EXPLICITO, em vez de depender
    * do default interno do DataAccess ("cur" + tabela).
    *==========================================================================
    PROCEDURE CarregarPorChave(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cCidchaves) != "C" OR EMPTY(ALLTRIM(par_cCidchaves))
                THIS.this_cMensagemErro = "Chave do lan" + CHR(231) + "amento n" + CHR(227) + "o informada."
            ELSE
                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF

                loc_cSQL = "SELECT * FROM SigMvCcr" + ;
                    " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao ler o lan" + CHR(231) + "amento." + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "sigopaccBO.CarregarPorChave")
                    THIS.this_lErroExibido = .T.
                ELSE
                    IF RECCOUNT("cursor_4c_Dados") = 0
                        THIS.this_cMensagemErro = "Lan" + CHR(231) + "amento n" + CHR(227) + "o encontrado."
                    ELSE
                        SELECT cursor_4c_Dados
                        GO TOP
                        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Dados")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "sigopaccBO.CarregarPorChave")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL (SELECT * FROM
    * SigMvCcr) para as propriedades do BO. SEMPRE usar SELECT (par_cAliasCursor)
    * antes de acessar os campos (regra #8 CLAUDE.md).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
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
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo lancamento em SigMvCcr
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            IF EMPTY(ALLTRIM(NVL(THIS.this_cEmps, "")))
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF

            THIS.this_cUsualts = gc_4c_UsuarioLogado
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

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lan" + CHR(231) + "amento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza lancamento existente em SigMvCcr (por cidchaves)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cUsualts = gc_4c_UsuarioLogado
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
                MsgErro("Erro ao atualizar lan" + CHR(231) + "amento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em sigopaccBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
