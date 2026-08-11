*==============================================================================
* cfoBO.prg - Business Object para Cadastro de CFOP
* Tabela: SigCdCfo
* Chave: codigos
*==============================================================================

DEFINE CLASS cfoBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Campos da tabela SigCdCfo (mapeados diretamente do schema)
    *--------------------------------------------------------------------------

    *-- Identificacao e descricao
    this_cCodigos    = ""    && codigos     char(10)  PK
    this_cDescricaos = ""    && descricaos  char(60)  Descricao nota fiscal
    this_cDesc2s     = ""    && desc2s      char(60)  Descricao consulta

    *-- Operacao e tipo
    this_cOperacaos  = ""    && operacaos   char(1)   E=Entrada S=Saida
    this_nTipos      = 0     && tipos       numeric(1,0)
    this_nNdigitos   = 0     && ndigitos    numeric(2,0)  Digitos para NF

    *-- ICMS
    this_cIcms       = ""    && icms        char(1)   T=Tributado I=Isento O=Outros N=N.Tributa
    this_cSittribs   = ""    && sittribs    char(3)   Situacao tributaria ICMS
    this_nAliqivcs   = 0     && aliqivcs    numeric(4,2)  Aliquota venda consumidor
    this_nInclicms   = 0     && inclicms    numeric(1,0)  Incluir ICMS na base
    this_nIcmsdscs   = 0     && icmsdscs    numeric(1,0)  ICMS incluso no preco
    this_nIcmsincs   = 0     && icmsincs    numeric(1,0)  Integrar valores ICMS
    this_nIncicmnfs  = 0     && incicmnfs   numeric(1,0)  Incluir ICMS no total da NF
    this_cCgergia1s  = ""    && cgergia1s   char(1)   Destaca ICMS na NF S/N
    this_nFrticms    = 0     && frticms     numeric(1,0)  Frete compoe base ICMS
    this_nSegicms    = 0     && segicms     numeric(1,0)  Seguro compoe base ICMS
    this_nDesicms    = 0     && desicms     numeric(1,0)  Despesas compoe base ICMS

    *-- Substituicao tributaria ICMS
    this_cSubtribs   = ""    && subtribs    char(1)   Substituicao tributaria S/N
    this_nPbcsts     = 0     && pbcsts      numeric(5,2)  % base ST
    this_cCfosts     = ""    && cfosts      char(10)  CFOP subst. tributaria
    this_cCoddests   = ""    && coddests    char(10)  CFOP destino
    this_nTransps    = 0     && transps     numeric(1,0)  CFOP transporte

    *-- IPI
    this_cIpis       = ""    && ipis        char(1)   T=Tributado I=Isento O=Outros
    this_cIpi_icms   = ""    && ipi_icms    char(1)   IPI sobre ICMS
    this_nInclipis   = 0     && inclipis    numeric(1,0)  Incluir IPI na base
    this_nPbcipis    = 0     && pbcipis     numeric(5,2)  % base IPI
    this_cBcipis     = ""    && bcipis      char(1)   Base de calculo IPI
    this_nAliqipis   = 0     && aliqipis    numeric(4,2)  Aliquota IPI
    this_cAcresipis  = ""    && acresipis   char(1)   Acrescenta na base
    this_cIpiimpors  = ""    && ipiimpors   char(1)   IPI importacao
    this_cIpiom2s    = ""    && ipiom2s     char(1)   IPI calc. p/ origem mercadoria=2
    this_nFrtipis    = 0     && frtipis     numeric(1,0)  Frete compoe base IPI
    this_nSegipis    = 0     && segipis     numeric(1,0)  Seguro compoe base IPI
    this_nDesipis    = 0     && desipis     numeric(1,0)  Despesas compoe base IPI
    this_nIpincreds  = 0     && ipincreds   numeric(1,0)  IPI nao creditado
    this_nPontedescs = 0     && pontedescs  numeric(1,0)  Retira IPI do valor
    this_cIpicst     = ""    && ipicst      char(2)   Codigo IPI sit. tributaria NF-e
    this_cIpienq     = ""    && ipienq      char(3)   Enquadramento IPI
    this_cUnitimps   = ""    && unitimps    char(1)   Inibe valor unitario NF importacao

    *-- PIS / COFINS / ISSQN / II
    this_cPiscst     = ""    && piscst      char(2)   Codigo PIS sit. tributaria
    this_cCofcst     = ""    && cofcst      char(2)   Codigo COFINS sit. tributaria
    this_cIssqnl     = ""    && issqnl      char(5)   Codigo ISSQN lista servicos
    this_nAliqpis    = 0     && aliqpis     numeric(5,2)  Aliquota PIS
    this_nAliqcofins = 0     && aliqcofins  numeric(5,2)  Aliquota COFINS
    this_nAliqissqn  = 0     && aliqissqn   numeric(5,2)  Aliquota ISSQN
    this_nAliqii     = 0     && aliqii      numeric(5,2)  Aliquota II
    this_nCtissqn    = 0     && ctissqn     numeric(1,0)  Codigo tributacao ISSQN
    this_nRettribs   = 0     && rettribs    numeric(1,0)  Informa retencao de tributos

    *-- Contribuinte / Situacao
    this_cContribs   = ""    && contribs    char(1)   S=Sim N=Nao O=Outros
    this_nSituas     = 0     && situas      numeric(1,0)  0=Ativo 1=Inativo
    this_cCfost60s   = ""    && cfost60s    char(10)  CFOP ST60
    this_nSomaicmfrete = 0   && somaicmfrete numeric(1,0)
    this_cMotdeson   = ""    && motdeson    char(2)   Motivo desoneracao ICMS

    *-- Integracao Contabil - Contas DB/CR
    this_cContconts  = ""    && contconts   char(1)   Pega conta contabil da NF
    this_cContvcds   = ""    && contvcds    char(9)   Conta valor contabil DB
    this_cContvccs   = ""    && contvccs    char(9)   Conta valor contabil CR
    this_cContipds   = ""    && contipds    char(9)   Conta IPI DB
    this_cContipcs   = ""    && contipcs    char(9)   Conta IPI CR
    this_cConticds   = ""    && conticds    char(9)   Conta ICMS DB
    this_cConticcs   = ""    && conticcs    char(9)   Conta ICMS CR
    this_cContfrt    = ""    && contfrt     char(9)   Conta frete
    this_cContseg    = ""    && contseg     char(9)   Conta seguro
    this_cContda     = ""    && contda      char(9)   Conta despesas acessorias

    *-- Integracao Contabil - Opcoes
    this_nAgrupas    = 0     && agrupas     numeric(1,0)  Agrupa CFO na integracao
    this_nZeradas    = 0     && zeradas     numeric(1,0)  Integracao zerada
    this_nIntvlrcont = 0     && intvlrcont  numeric(1,0)  Integrar valor contabil
    this_nIntvlricms = 0     && intvlricms  numeric(1,0)  Integrar valores ICMS
    this_nIntvlripi  = 0     && intvlripi   numeric(1,0)  Integrar valores IPI
    this_nUtilvars   = 0     && utilvars    numeric(1,0)  Utilizar variacao CFOP
    this_nIndmov     = 0     && indmov      numeric(1,0)  Movimentacao fisica estoque
    this_nIndpagto   = 0     && indpagto    numeric(1,0)  Indicacao pagamento
    this_nTiporecs   = 0     && tiporecs    numeric(1,0)  Data lancamento contabil
    this_nObspads    = 0     && obspads     numeric(3,0)  Observacao padrao
    this_nDtintfis   = 0     && dtintfis    numeric(1,0)  Integracao fiscal

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCfo"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos      = TratarNulo(codigos,      "C")
                THIS.this_cDescricaos   = TratarNulo(descricaos,   "C")
                THIS.this_cDesc2s       = TratarNulo(desc2s,       "C")
                THIS.this_cOperacaos    = TratarNulo(operacaos,    "C")
                THIS.this_nTipos        = TratarNulo(tipos,        "N")
                THIS.this_nNdigitos     = TratarNulo(ndigitos,     "N")
                THIS.this_cIcms         = TratarNulo(icms,         "C")
                THIS.this_cSittribs     = TratarNulo(sittribs,     "C")
                THIS.this_nAliqivcs     = TratarNulo(aliqivcs,     "N")
                THIS.this_nInclicms     = TratarNulo(inclicms,     "N")
                THIS.this_nIcmsdscs     = TratarNulo(icmsdscs,     "N")
                THIS.this_nIcmsincs     = TratarNulo(icmsincs,     "N")
                THIS.this_nIncicmnfs    = TratarNulo(incicmnfs,    "N")
                THIS.this_cCgergia1s    = TratarNulo(cgergia1s,    "C")
                THIS.this_nFrticms      = TratarNulo(frticms,      "N")
                THIS.this_nSegicms      = TratarNulo(segicms,      "N")
                THIS.this_nDesicms      = TratarNulo(desicms,      "N")
                THIS.this_cSubtribs     = TratarNulo(subtribs,     "C")
                THIS.this_nPbcsts       = TratarNulo(pbcsts,       "N")
                THIS.this_cCfosts       = TratarNulo(cfosts,       "C")
                THIS.this_cCoddests     = TratarNulo(coddests,     "C")
                THIS.this_nTransps      = TratarNulo(transps,      "N")
                THIS.this_cIpis         = TratarNulo(ipis,         "C")
                THIS.this_cIpi_icms     = TratarNulo(ipi_icms,     "C")
                THIS.this_nInclipis     = TratarNulo(inclipis,     "N")
                THIS.this_nPbcipis      = TratarNulo(pbcipis,      "N")
                THIS.this_cBcipis       = TratarNulo(bcipis,       "C")
                THIS.this_nAliqipis     = TratarNulo(aliqipis,     "N")
                THIS.this_cAcresipis    = TratarNulo(acresipis,    "C")
                THIS.this_cIpiimpors    = TratarNulo(ipiimpors,    "C")
                THIS.this_cIpiom2s      = TratarNulo(ipiom2s,      "C")
                THIS.this_nFrtipis      = TratarNulo(frtipis,      "N")
                THIS.this_nSegipis      = TratarNulo(segipis,      "N")
                THIS.this_nDesipis      = TratarNulo(desipis,      "N")
                THIS.this_nIpincreds    = TratarNulo(ipincreds,    "N")
                THIS.this_nPontedescs   = TratarNulo(pontedescs,   "N")
                THIS.this_cIpicst       = TratarNulo(ipicst,       "C")
                THIS.this_cIpienq       = TratarNulo(ipienq,       "C")
                THIS.this_cUnitimps     = TratarNulo(unitimps,     "C")
                THIS.this_cPiscst       = TratarNulo(piscst,       "C")
                THIS.this_cCofcst       = TratarNulo(cofcst,       "C")
                THIS.this_cIssqnl       = TratarNulo(issqnl,       "C")
                THIS.this_nAliqpis      = TratarNulo(aliqpis,      "N")
                THIS.this_nAliqcofins   = TratarNulo(aliqcofins,   "N")
                THIS.this_nAliqissqn    = TratarNulo(aliqissqn,    "N")
                THIS.this_nAliqii       = TratarNulo(aliqii,       "N")
                THIS.this_nCtissqn      = TratarNulo(ctissqn,      "N")
                THIS.this_nRettribs     = TratarNulo(rettribs,     "N")
                THIS.this_cContribs     = TratarNulo(contribs,     "C")
                THIS.this_nSituas       = TratarNulo(situas,       "N")
                THIS.this_cCfost60s     = TratarNulo(cfost60s,     "C")
                THIS.this_nSomaicmfrete = TratarNulo(somaicmfrete, "N")
                THIS.this_cMotdeson     = TratarNulo(motdeson,     "C")
                THIS.this_cContconts    = TratarNulo(contconts,    "C")
                THIS.this_cContvcds     = TratarNulo(contvcds,     "C")
                THIS.this_cContvccs     = TratarNulo(contvccs,     "C")
                THIS.this_cContipds     = TratarNulo(contipds,     "C")
                THIS.this_cContipcs     = TratarNulo(contipcs,     "C")
                THIS.this_cConticds     = TratarNulo(conticds,     "C")
                THIS.this_cConticcs     = TratarNulo(conticcs,     "C")
                THIS.this_cContfrt      = TratarNulo(contfrt,      "C")
                THIS.this_cContseg      = TratarNulo(contseg,      "C")
                THIS.this_cContda       = TratarNulo(contda,       "C")
                THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
                THIS.this_nZeradas      = TratarNulo(zeradas,      "N")
                THIS.this_nIntvlrcont   = TratarNulo(intvlrcont,   "N")
                THIS.this_nIntvlricms   = TratarNulo(intvlricms,   "N")
                THIS.this_nIntvlripi    = TratarNulo(intvlripi,    "N")
                THIS.this_nUtilvars     = TratarNulo(utilvars,     "N")
                THIS.this_nIndmov       = TratarNulo(indmov,       "N")
                THIS.this_nIndpagto     = TratarNulo(indpagto,     "N")
                THIS.this_nTiporecs     = TratarNulo(tiporecs,     "N")
                THIS.this_nObspads      = TratarNulo(obspads,      "N")
                THIS.this_nDtintfis     = TratarNulo(dtintfis,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, ;
                "cfoBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cVals, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cVals = EscaparSQL(THIS.this_cCodigos) + ", " + ;
                EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                EscaparSQL(THIS.this_cIcms) + ", " + ;
                EscaparSQL(THIS.this_cSittribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                EscaparSQL(THIS.this_cCfosts) + ", " + ;
                EscaparSQL(THIS.this_cCoddests) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpis) + ", " + ;
                EscaparSQL(THIS.this_cIpi_icms) + ", " + ;
                FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                EscaparSQL(THIS.this_cBcipis) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                EscaparSQL(THIS.this_cIpicst) + ", " + ;
                EscaparSQL(THIS.this_cIpienq) + ", " + ;
                EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                EscaparSQL(THIS.this_cPiscst) + ", " + ;
                EscaparSQL(THIS.this_cCofcst) + ", " + ;
                EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                EscaparSQL(THIS.this_cContribs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                EscaparSQL(THIS.this_cContconts) + ", " + ;
                EscaparSQL(THIS.this_cContvcds) + ", " + ;
                EscaparSQL(THIS.this_cContvccs) + ", " + ;
                EscaparSQL(THIS.this_cContipds) + ", " + ;
                EscaparSQL(THIS.this_cContipcs) + ", " + ;
                EscaparSQL(THIS.this_cConticds) + ", " + ;
                EscaparSQL(THIS.this_cConticcs) + ", " + ;
                EscaparSQL(THIS.this_cContfrt) + ", " + ;
                EscaparSQL(THIS.this_cContseg) + ", " + ;
                EscaparSQL(THIS.this_cContda) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObspads, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nDtintfis, 0)

            loc_cSQL = "INSERT INTO SigCdCfo (" + ;
                "codigos, descricaos, desc2s, operacaos, tipos, ndigitos," + ;
                " icms, sittribs, aliqivcs, inclicms, icmsdscs, icmsincs, incicmnfs, cgergia1s," + ;
                " frticms, segicms, desicms, subtribs, pbcsts, cfosts, coddests, transps," + ;
                " ipis, ipi_icms, inclipis, pbcipis, bcipis, aliqipis, acresipis, ipiimpors," + ;
                " ipiom2s, frtipis, segipis, desipis, ipincreds, pontedescs, ipicst, ipienq," + ;
                " unitimps, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn, aliqii," + ;
                " ctissqn, rettribs, contribs, situas, cfost60s, somaicmfrete, motdeson," + ;
                " contconts, contvcds, contvccs, contipds, contipcs, conticds, conticcs," + ;
                " contfrt, contseg, contda, agrupas, zeradas, intvlrcont, intvlricms," + ;
                " intvlripi, utilvars, indmov, indpagto, tiporecs, obspads, dtintfis" + ;
                ") VALUES (" + loc_cVals + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "cfoBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_cSet, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSet = "descricaos = "  + EscaparSQL(THIS.this_cDescricaos) + ", " + ;
                "desc2s = "             + EscaparSQL(THIS.this_cDesc2s) + ", " + ;
                "operacaos = "          + EscaparSQL(THIS.this_cOperacaos) + ", " + ;
                "tipos = "              + FormatarNumeroSQL(THIS.this_nTipos, 0) + ", " + ;
                "ndigitos = "           + FormatarNumeroSQL(THIS.this_nNdigitos, 0) + ", " + ;
                "icms = "               + EscaparSQL(THIS.this_cIcms) + ", " + ;
                "sittribs = "           + EscaparSQL(THIS.this_cSittribs) + ", " + ;
                "aliqivcs = "           + FormatarNumeroSQL(THIS.this_nAliqivcs, 2) + ", " + ;
                "inclicms = "           + FormatarNumeroSQL(THIS.this_nInclicms, 0) + ", " + ;
                "icmsdscs = "           + FormatarNumeroSQL(THIS.this_nIcmsdscs, 0) + ", " + ;
                "icmsincs = "           + FormatarNumeroSQL(THIS.this_nIcmsincs, 0) + ", " + ;
                "incicmnfs = "          + FormatarNumeroSQL(THIS.this_nIncicmnfs, 0) + ", " + ;
                "cgergia1s = "          + EscaparSQL(THIS.this_cCgergia1s) + ", " + ;
                "frticms = "            + FormatarNumeroSQL(THIS.this_nFrticms, 0) + ", " + ;
                "segicms = "            + FormatarNumeroSQL(THIS.this_nSegicms, 0) + ", " + ;
                "desicms = "            + FormatarNumeroSQL(THIS.this_nDesicms, 0) + ", " + ;
                "subtribs = "           + EscaparSQL(THIS.this_cSubtribs) + ", " + ;
                "pbcsts = "             + FormatarNumeroSQL(THIS.this_nPbcsts, 2) + ", " + ;
                "cfosts = "             + EscaparSQL(THIS.this_cCfosts) + ", " + ;
                "coddests = "           + EscaparSQL(THIS.this_cCoddests) + ", " + ;
                "transps = "            + FormatarNumeroSQL(THIS.this_nTransps, 0) + ", " + ;
                "ipis = "               + EscaparSQL(THIS.this_cIpis) + ", " + ;
                "ipi_icms = "           + EscaparSQL(THIS.this_cIpi_icms) + ", " + ;
                "inclipis = "           + FormatarNumeroSQL(THIS.this_nInclipis, 0) + ", " + ;
                "pbcipis = "            + FormatarNumeroSQL(THIS.this_nPbcipis, 2) + ", " + ;
                "bcipis = "             + EscaparSQL(THIS.this_cBcipis) + ", " + ;
                "aliqipis = "           + FormatarNumeroSQL(THIS.this_nAliqipis, 2) + ", " + ;
                "acresipis = "          + EscaparSQL(THIS.this_cAcresipis) + ", " + ;
                "ipiimpors = "          + EscaparSQL(THIS.this_cIpiimpors) + ", " + ;
                "ipiom2s = "            + EscaparSQL(THIS.this_cIpiom2s) + ", " + ;
                "frtipis = "            + FormatarNumeroSQL(THIS.this_nFrtipis, 0) + ", " + ;
                "segipis = "            + FormatarNumeroSQL(THIS.this_nSegipis, 0) + ", " + ;
                "desipis = "            + FormatarNumeroSQL(THIS.this_nDesipis, 0) + ", " + ;
                "ipincreds = "          + FormatarNumeroSQL(THIS.this_nIpincreds, 0) + ", " + ;
                "pontedescs = "         + FormatarNumeroSQL(THIS.this_nPontedescs, 0) + ", " + ;
                "ipicst = "             + EscaparSQL(THIS.this_cIpicst) + ", " + ;
                "ipienq = "             + EscaparSQL(THIS.this_cIpienq) + ", " + ;
                "unitimps = "           + EscaparSQL(THIS.this_cUnitimps) + ", " + ;
                "piscst = "             + EscaparSQL(THIS.this_cPiscst) + ", " + ;
                "cofcst = "             + EscaparSQL(THIS.this_cCofcst) + ", " + ;
                "issqnl = "             + EscaparSQL(THIS.this_cIssqnl) + ", " + ;
                "aliqpis = "            + FormatarNumeroSQL(THIS.this_nAliqpis, 2) + ", " + ;
                "aliqcofins = "         + FormatarNumeroSQL(THIS.this_nAliqcofins, 2) + ", " + ;
                "aliqissqn = "          + FormatarNumeroSQL(THIS.this_nAliqissqn, 2) + ", " + ;
                "aliqii = "             + FormatarNumeroSQL(THIS.this_nAliqii, 2) + ", " + ;
                "ctissqn = "            + FormatarNumeroSQL(THIS.this_nCtissqn, 0) + ", " + ;
                "rettribs = "           + FormatarNumeroSQL(THIS.this_nRettribs, 0) + ", " + ;
                "contribs = "           + EscaparSQL(THIS.this_cContribs) + ", " + ;
                "situas = "             + FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                "cfost60s = "           + EscaparSQL(THIS.this_cCfost60s) + ", " + ;
                "somaicmfrete = "       + FormatarNumeroSQL(THIS.this_nSomaicmfrete, 0) + ", " + ;
                "motdeson = "           + EscaparSQL(THIS.this_cMotdeson) + ", " + ;
                "contconts = "          + EscaparSQL(THIS.this_cContconts) + ", " + ;
                "contvcds = "           + EscaparSQL(THIS.this_cContvcds) + ", " + ;
                "contvccs = "           + EscaparSQL(THIS.this_cContvccs) + ", " + ;
                "contipds = "           + EscaparSQL(THIS.this_cContipds) + ", " + ;
                "contipcs = "           + EscaparSQL(THIS.this_cContipcs) + ", " + ;
                "conticds = "           + EscaparSQL(THIS.this_cConticds) + ", " + ;
                "conticcs = "           + EscaparSQL(THIS.this_cConticcs) + ", " + ;
                "contfrt = "            + EscaparSQL(THIS.this_cContfrt) + ", " + ;
                "contseg = "            + EscaparSQL(THIS.this_cContseg) + ", " + ;
                "contda = "             + EscaparSQL(THIS.this_cContda) + ", " + ;
                "agrupas = "            + FormatarNumeroSQL(THIS.this_nAgrupas, 0) + ", " + ;
                "zeradas = "            + FormatarNumeroSQL(THIS.this_nZeradas, 0) + ", " + ;
                "intvlrcont = "         + FormatarNumeroSQL(THIS.this_nIntvlrcont, 0) + ", " + ;
                "intvlricms = "         + FormatarNumeroSQL(THIS.this_nIntvlricms, 0) + ", " + ;
                "intvlripi = "          + FormatarNumeroSQL(THIS.this_nIntvlripi, 0) + ", " + ;
                "utilvars = "           + FormatarNumeroSQL(THIS.this_nUtilvars, 0) + ", " + ;
                "indmov = "             + FormatarNumeroSQL(THIS.this_nIndmov, 0) + ", " + ;
                "indpagto = "           + FormatarNumeroSQL(THIS.this_nIndpagto, 0) + ", " + ;
                "tiporecs = "           + FormatarNumeroSQL(THIS.this_nTiporecs, 0) + ", " + ;
                "obspads = "            + FormatarNumeroSQL(THIS.this_nObspads, 0) + ", " + ;
                "dtintfis = "           + FormatarNumeroSQL(THIS.this_nDtintfis, 0)

            loc_cSQL = "UPDATE SigCdCfo SET " + loc_cSet + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "cfoBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCfo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCfo WHERE codigos = " + ;
                EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "cfoBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com codigos, descricaos, desc2s, operacaos, situas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (codigos C(10), descricaos C(60), ;
                        desc2s C(60), operacaos C(1), situas N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            loc_cSQL = "SELECT codigos, descricaos, desc2s, operacaos, situas" + ;
                " FROM SigCdCfo"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            IF USED("cursor_4c_Dados")
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                IF loc_nResultado >= 0
                    SELECT cursor_4c_Dados
                    ZAP
                    SET NULL ON
                    APPEND FROM DBF("cursor_4c_DadosTmp")
                    SET NULL OFF
                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOPs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar CFOPs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "cfoBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descricaos, desc2s, operacaos, tipos, ndigitos," + ;
                " icms, sittribs, aliqivcs, inclicms, icmsdscs, icmsincs, incicmnfs, cgergia1s," + ;
                " frticms, segicms, desicms, subtribs, pbcsts, cfosts, coddests, transps," + ;
                " ipis, ipi_icms, inclipis, pbcipis, bcipis, aliqipis, acresipis, ipiimpors," + ;
                " ipiom2s, frtipis, segipis, desipis, ipincreds, pontedescs, ipicst, ipienq," + ;
                " unitimps, piscst, cofcst, issqnl, aliqpis, aliqcofins, aliqissqn, aliqii," + ;
                " ctissqn, rettribs, contribs, situas, cfost60s, somaicmfrete, motdeson," + ;
                " contconts, contvcds, contvccs, contipds, contipcs, conticds, conticcs," + ;
                " contfrt, contseg, contda, agrupas, zeradas, intvlrcont, intvlricms," + ;
                " intvlripi, utilvars, indmov, indpagto, tiporecs, obspads, dtintfis" + ;
                " FROM SigCdCfo WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("CFOP n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar CFOP:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "cfoBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cDescricaos))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da nota fiscal obrigat" + CHR(243) + "ria!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

ENDDEFINE
