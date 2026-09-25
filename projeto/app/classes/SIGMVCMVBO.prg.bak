*==============================================================================
* SIGMVCMVBO.PRG
* Business Object - Processamento de Lancamentos de Centro de Custos
* nao lancados (SigMvCcr)
* Origem: tasks\task563\SIGMVCMV_form_codigo_fonte.txt
*==============================================================================

DEFINE CLASS SIGMVCMVBO AS BusinessBase

    *-- Filtros de processamento (espelham os campos do form)
    this_dDataInicial = {}      && getDtInicial - inicio do periodo
    this_dDataFinal = {}        && getDtFinal - fim do periodo
    this_cCdMoeda = ""          && get_cd_moeda - moeda para conversao
    this_cDsMoeda = ""          && get_ds_moeda - descricao da moeda
    this_cCdEmpresa = ""        && getEmpresa - codigo da empresa
    this_cDsEmpresa = ""        && getDEmpresa - descricao da empresa

    *-- Chave de sessao usada na composicao de cidchaves (Sigkey no legado)
    this_cChaveSessao = ""

    *-- Resultado do ultimo Processamento() (consumido pelo Form)
    this_nQtdProcessada = 0    && quantidade de pares D/C gravados
    this_nQtdVisTit = 0        && operacoes marcadas que pedem visualizacao de titulos (SigMvTi2 - nao migrado)

    *-- Nomes dos cursores de trabalho (multiplos cursores, form OPERACIONAL)
    this_cCursorOperacoes = "cursor_4c_Operacoes"   && espelha csOperacaos (grade de operacoes)
    this_cCursorAltCc = "cursor_4c_AltCc"           && espelha CrAltcc (mirror de SigMvCcr)
    this_cCursorMovimento = "cursor_4c_Movimento"   && espelha csMovimento (agregacao de custos)
    this_cCursorSigOpFin = "cursor_4c_SigOpFin"     && espelha crSigOpFin (operacoes financeiras validas)
    this_cCursorSigCdCot = "cursor_4c_SigCdCot"     && espelha crSigCdCot (cotacoes de moeda)
    this_cCursorSigCdMoe = "cursor_4c_SigCdMoe"     && espelha crSigCdMoe (moedas cadastradas)

    *-- Propriedades da entidade (mapeamento para tabela SigMvCcr - registro
    *-- de lancamento de conta corrente que o processamento insere/atualiza)
    this_cCidchaves    = ""    && cidchaves   char(20)   - PK
    this_lAutos        = .F.   && autos       bit
    this_lConcs        = .F.   && concs       bit
    this_cContages     = ""    && contages    char(10)
    this_cContas       = ""    && contas      char(10)
    this_cContems      = ""    && contems     char(10)
    this_nCotacaos     = 0     && cotacaos    numeric(15,7)
    this_dDatalts      = {}    && datalts     datetime
    this_dDatas        = {}    && datas       datetime
    this_dDataconcs    = {}    && dataconcs   datetime
    this_dDatatrans    = {}    && datatrans   datetime
    this_dDatexcs      = {}    && datexcs     datetime
    this_cDocus        = ""    && docus       char(10)
    this_cDopes        = ""    && dopes       char(20)
    this_dDtemis       = {}    && dtemis      datetime
    this_cEmps         = ""    && emps        char(3)
    this_cGrupages     = ""    && grupages    char(10)
    this_cGrupems      = ""    && grupems     char(10)
    this_cGrupos       = ""    && grupos      char(10)
    this_cHists        = ""    && hists       char(60)
    this_cLocals       = ""    && locals      char(10)
    this_cMoedas       = ""    && moedas      char(3)
    this_cNfs          = ""    && nfs         char(10)
    this_nNlancs       = 0     && nlancs      numeric(6,0)
    this_nNopers       = 0     && nopers      numeric(7,0)
    this_nNtrans       = 0     && ntrans      numeric(6,0)
    this_nNumes        = 0     && numes       numeric(6,0)
    this_cOpers        = ""    && opers       char(1) - D/C
    this_nSaldocs      = 0     && saldocs     numeric(15,2)
    this_nSaldons      = 0     && saldons     numeric(15,2)
    this_nSaldos       = 0     && saldos      numeric(15,2)
    this_cScontas      = ""    && scontas     char(10)
    this_nScotacaos    = 0     && scotacaos   numeric(15,7)
    this_cSgrupos      = ""    && sgrupos     char(10)
    this_cShists       = ""    && shists      char(40)
    this_cSmoedas      = ""    && smoedas     char(3)
    this_cSopers       = ""    && sopers      char(1) - D/C
    this_nSvalors      = 0     && svalors     numeric(11,2)
    this_cTipos        = ""    && tipos       char(1)
    this_cTitbans      = ""    && titbans     char(12)
    this_cTitulos      = ""    && titulos     char(10)
    this_cUsualts      = ""    && usualts     char(10)
    this_cUsuexcs      = ""    && usuexcs     char(10)
    this_nValliqs      = 0     && valliqs     numeric(11,2)
    this_nValocurs     = 0     && valocurs    numeric(11,2)
    this_nValors       = 0     && valors      numeric(11,2)
    this_nValpags      = 0     && valpags     numeric(11,2)
    this_dVencs        = {}    && vencs       datetime
    this_cVlancs       = ""    && vlancs      char(10)
    this_cVopers       = ""    && vopers      char(13)
    this_nContapgs     = 0     && contapgs    numeric(1,0)
    this_cDopcs        = ""    && dopcs       char(20)
    this_nNumcs        = 0     && numcs       numeric(6,0)
    this_cCotusus      = ""    && cotusus     char(10)
    this_cBcontas      = ""    && bcontas     char(10)
    this_cBgrupos      = ""    && bgrupos     char(10)
    this_nBorderos     = 0     && borderos    numeric(6,0)
    this_cHist2s       = ""    && hist2s      char(80)
    this_nIntconts     = 0     && intconts    numeric(6,0)
    this_cUsuconcs     = ""    && usuconcs    char(10)
    this_cAuditors     = ""    && auditors    char(10)
    this_dDtaudits     = {}    && dtaudits    datetime
    this_nValprev      = 0     && valprev     numeric(11,2)
    this_cEmpdopncs    = ""    && empdopncs   char(29)
    this_cEmpdopnums   = ""    && empdopnums  char(29)
    this_cGruconmoes   = ""    && gruconmoes  char(23)
    this_cPagos        = ""    && pagos       char(1)
    this_cDopotps      = ""    && dopotps     char(23)
    this_cUsupagos     = ""    && usupagos    char(10)
    this_nTitcancs     = 0     && titcancs    numeric(1,0)
    this_dDtconfs      = {}    && dtconfs     datetime
    this_cUsuconfs     = ""    && usuconfs    char(10)
    this_nNopercancs   = 0     && nopercancs  numeric(7,0)
    this_cEspecienfs   = ""    && especienfs  char(6)
    this_cJobs         = ""    && jobs        char(10)
    this_nImpostos     = 0     && impostos    numeric(11,2)
    this_nTpimpostos   = 0     && tpimpostos  numeric(2,0)
    this_cTitpais      = ""    && titpais     char(10)
    this_cEmpccs       = ""    && empccs      char(3)
    this_nRecor        = 0     && recor       numeric(1,0)
    this_cCompet       = ""    && compet      char(7)
    this_cEmpos        = ""    && empos       char(3)
    this_cOridopnums   = ""    && oridopnums  char(29)
    this_cPastas       = ""    && pastas      text
    this_cRcontas      = ""    && rcontas     char(10)
    this_cTpdocnf      = ""    && tpdocnf     char(2)

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"
            THIS.this_cChaveSessao = ""
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGMVCMVBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL/cursor de
    * trabalho (CrAltcc/cursor_4c_AltCc) para as propriedades do BO.
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar os campos
    * (regra #8 CLAUDE.md - nunca campo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
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
                THIS.this_cContages = TratarNulo(contages, "C")
                THIS.this_cContas = TratarNulo(contas, "C")
                THIS.this_cContems = TratarNulo(contems, "C")
                THIS.this_nCotacaos = TratarNulo(cotacaos, "N")
                THIS.this_dDatalts = TratarNulo(datalts, "D")
                THIS.this_dDatas = TratarNulo(datas, "D")
                THIS.this_dDataconcs = TratarNulo(dataconcs, "D")
                THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                THIS.this_dDatexcs = TratarNulo(datexcs, "D")
                THIS.this_cDocus = TratarNulo(docus, "C")
                THIS.this_cDopes = TratarNulo(dopes, "C")
                THIS.this_dDtemis = TratarNulo(dtemis, "D")
                THIS.this_cEmps = TratarNulo(emps, "C")
                THIS.this_cGrupages = TratarNulo(grupages, "C")
                THIS.this_cGrupems = TratarNulo(grupems, "C")
                THIS.this_cGrupos = TratarNulo(grupos, "C")
                THIS.this_cHists = TratarNulo(hists, "C")
                THIS.this_cLocals = TratarNulo(locals, "C")
                THIS.this_cMoedas = TratarNulo(moedas, "C")
                THIS.this_cNfs = TratarNulo(nfs, "C")
                THIS.this_nNlancs = TratarNulo(nlancs, "N")
                THIS.this_nNopers = TratarNulo(nopers, "N")
                THIS.this_nNtrans = TratarNulo(ntrans, "N")
                THIS.this_nNumes = TratarNulo(numes, "N")
                THIS.this_cOpers = TratarNulo(opers, "C")
                THIS.this_nSaldocs = TratarNulo(saldocs, "N")
                THIS.this_nSaldons = TratarNulo(saldons, "N")
                THIS.this_nSaldos = TratarNulo(saldos, "N")
                THIS.this_cScontas = TratarNulo(scontas, "C")
                THIS.this_nScotacaos = TratarNulo(scotacaos, "N")
                THIS.this_cSgrupos = TratarNulo(sgrupos, "C")
                THIS.this_cShists = TratarNulo(shists, "C")
                THIS.this_cSmoedas = TratarNulo(smoedas, "C")
                THIS.this_cSopers = TratarNulo(sopers, "C")
                THIS.this_nSvalors = TratarNulo(svalors, "N")
                THIS.this_cTipos = TratarNulo(tipos, "C")
                THIS.this_cTitbans = TratarNulo(titbans, "C")
                THIS.this_cTitulos = TratarNulo(titulos, "C")
                THIS.this_cUsualts = TratarNulo(usualts, "C")
                THIS.this_cUsuexcs = TratarNulo(usuexcs, "C")
                THIS.this_nValliqs = TratarNulo(valliqs, "N")
                THIS.this_nValocurs = TratarNulo(valocurs, "N")
                THIS.this_nValors = TratarNulo(valors, "N")
                THIS.this_nValpags = TratarNulo(valpags, "N")
                THIS.this_dVencs = TratarNulo(vencs, "D")
                THIS.this_cVlancs = TratarNulo(vlancs, "C")
                THIS.this_cVopers = TratarNulo(vopers, "C")
                THIS.this_nContapgs = TratarNulo(contapgs, "N")
                THIS.this_cDopcs = TratarNulo(dopcs, "C")
                THIS.this_nNumcs = TratarNulo(numcs, "N")
                THIS.this_cCotusus = TratarNulo(cotusus, "C")
                THIS.this_cBcontas = TratarNulo(bcontas, "C")
                THIS.this_cBgrupos = TratarNulo(bgrupos, "C")
                THIS.this_nBorderos = TratarNulo(borderos, "N")
                THIS.this_cHist2s = TratarNulo(hist2s, "C")
                THIS.this_nIntconts = TratarNulo(intconts, "N")
                THIS.this_cUsuconcs = TratarNulo(usuconcs, "C")
                THIS.this_cAuditors = TratarNulo(auditors, "C")
                THIS.this_dDtaudits = TratarNulo(dtaudits, "D")
                THIS.this_nValprev = TratarNulo(valprev, "N")
                THIS.this_cEmpdopncs = TratarNulo(empdopncs, "C")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                THIS.this_cGruconmoes = TratarNulo(gruconmoes, "C")
                THIS.this_cPagos = TratarNulo(pagos, "C")
                THIS.this_cDopotps = TratarNulo(dopotps, "C")
                THIS.this_cUsupagos = TratarNulo(usupagos, "C")
                THIS.this_nTitcancs = TratarNulo(titcancs, "N")
                THIS.this_dDtconfs = TratarNulo(dtconfs, "D")
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "C")
                THIS.this_nNopercancs = TratarNulo(nopercancs, "N")
                THIS.this_cEspecienfs = TratarNulo(especienfs, "C")
                THIS.this_cJobs = TratarNulo(jobs, "C")
                THIS.this_nImpostos = TratarNulo(impostos, "N")
                THIS.this_nTpimpostos = TratarNulo(tpimpostos, "N")
                THIS.this_cTitpais = TratarNulo(titpais, "C")
                THIS.this_cEmpccs = TratarNulo(empccs, "C")
                THIS.this_nRecor = TratarNulo(recor, "N")
                THIS.this_cCompet = TratarNulo(compet, "C")
                THIS.this_cEmpos = TratarNulo(empos, "C")
                THIS.this_cOridopnums = TratarNulo(oridopnums, "C")
                THIS.this_cPastas = TratarNulo(pastas, "C")
                THIS.this_cRcontas = TratarNulo(rcontas, "C")
                THIS.this_cTpdocnf = TratarNulo(tpdocnf, "C")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SIGMVCMVBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo lancamento em SigMvCcr (registro D/C gerado pelo
    * processamento em lote - fazcontra/processamento do legado). A PK
    * (cidchaves) segue a formula do legado (Dtos(Datas) + chave unica + Sigkey
    * de sessao); se o chamador nao a tiver montado ainda, cai no fallback
    * generico fUniqueIds() para nao gravar com PK vazia.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

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
            loc_cSQL = loc_cSQL + IIF(THIS.this_lAutos, 1, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lConcs, 1, 0) + ","
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
                THIS.this_cMensagemErro = "Erro ao inserir lan" + CHR(231) + "amento de centro de custos:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em SIGMVCMVBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza lancamento existente em SigMvCcr (por cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Data de alteracao
            THIS.this_dDatalts = DATETIME()

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCcr SET"
            loc_cSQL = loc_cSQL + " autos = " + IIF(THIS.this_lAutos, 1, 0) + ","
            loc_cSQL = loc_cSQL + " concs = " + IIF(THIS.this_lConcs, 1, 0) + ","
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
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao atualizar lan" + CHR(231) + "amento de centro de custos:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro em SIGMVCMVBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC


    *--------------------------------------------------------------------------
    * CarregarOperacoes - Popula o cursor de operacoes financeiras validas
    * (espelha o bloco do PROCEDURE Init legado:
    *
    *   lcQuery = [select distinct SigOpFin.Dopes,
    *              convert(int,(substring(lbltxidCs,24,1))) as VisTit ] + ...
    *   Thisform.poDatamgr.SqlExecute(lcQuery,'crSigOpFin')
    *   Select crSigOpFin / Index On Dopes Tag Dopes / Go Top
    *
    * A query, os JOINs e os filtros (opeinatvs = 0 / contaeds <> space(11))
    * sao TRANSCRITOS do legado - sao regra de negocio (definem QUAIS operacoes
    * podem ser processadas), nao se reescrevem. A coluna VisTit sai do 24o
    * caractere de SigOpCdi.lbltxidcs, exatamente como no original.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cSQL, loc_nResult, loc_cCursor, loc_cTmp, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorSigOpFin
        loc_cTmp     = loc_cCursor + "Tmp"

        TRY
            loc_cSQL = "select distinct SigOpFin.Dopes, "
            loc_cSQL = loc_cSQL + "convert(int,(substring(lbltxidCs,24,1))) as VisTit "
            loc_cSQL = loc_cSQL + "from SigOpFin "
            loc_cSQL = loc_cSQL + "join SigOpCdc on SigOpCdc.dopes = SigOpFin.dopes "
            loc_cSQL = loc_cSQL + "join SigOpCdi on SigOpCdi.dopes = SigOpFin.dopes "
            loc_cSQL = loc_cSQL + "And SigOpCdc.opeinatvs = 0 "
            loc_cSQL = loc_cSQL + "where contaeds <> space(11) "
            loc_cSQL = loc_cSQL + "order by 1"

            IF USED(loc_cTmp)
                USE IN (loc_cTmp)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTmp)

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar as opera" + CHR(231) + CHR(245) + ;
                    "es financeiras:" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ELSE
                *-- Cursor de SQLEXEC nasce SOMENTE-LEITURA; o INDEX ON e o SCAN
                *-- de carga da grade precisam de cursor READWRITE proprio
                IF USED(loc_cCursor)
                    USE IN (loc_cCursor)
                ENDIF
                SELECT * FROM (loc_cTmp) INTO CURSOR (loc_cCursor) READWRITE
                IF USED(loc_cTmp)
                    USE IN (loc_cTmp)
                ENDIF

                SELECT (loc_cCursor)
                INDEX ON Dopes TAG Dopes
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.CarregarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorAltCc - Cria cursor_4c_AltCc (mirror de SigMvCcr), equivalente
    * ao AddCursor('SigMvCcr','CidChaves','CrAltcc','','',[Select * From
    * SigMvCcr]) do Init legado - so a ESTRUTURA (zero linhas), READWRITE
    * para o processamento poder popular localmente antes de gravar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorAltCc()
        LOCAL loc_cTmp, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        loc_cTmp = THIS.this_cCursorAltCc + "Tmp"

        TRY
            IF USED(loc_cTmp)
                USE IN (loc_cTmp)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigMvCcr WHERE 1 = 0", loc_cTmp)

            IF loc_nResult >= 0 AND USED(loc_cTmp)
                IF USED(THIS.this_cCursorAltCc)
                    USE IN (THIS.this_cCursorAltCc)
                ENDIF
                SELECT * FROM (loc_cTmp) INTO CURSOR (THIS.this_cCursorAltCc) READWRITE
                USE IN (loc_cTmp)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.CriarCursorAltCc")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCotacoesEMoedas - Popula cursor_4c_SigCdCot/cursor_4c_SigCdMoe,
    * equivalente aos dois CursorQuery('SigCdCot'...)/CursorQuery('SigCdMoe'...)
    * do Init legado - fonte para CarregarCambio() (fCarregarCambio nao
    * portada - ver CLAUDE.md regra #27/skill vfp9-migration).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarCotacoesEMoedas()
        LOCAL loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorSigCdCot)
                USE IN (THIS.this_cCursorSigCdCot)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Datas, Valos FROM SigCdCot", THIS.this_cCursorSigCdCot)
            IF loc_nResult >= 0 AND USED(THIS.this_cCursorSigCdCot)
                SELECT (THIS.this_cCursorSigCdCot)
                INDEX ON CMoes + DTOS(Datas) TAG CMoeData
                SET ORDER TO CMoeData DESCENDING
            ENDIF

            IF USED(THIS.this_cCursorSigCdMoe)
                USE IN (THIS.this_cCursorSigCdMoe)
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Cotas FROM SigCdMoe", THIS.this_cCursorSigCdMoe)
            IF loc_nResult >= 0 AND USED(THIS.this_cCursorSigCdMoe)
                SELECT (THIS.this_cCursorSigCdMoe)
                INDEX ON CMoes TAG CMoes
            ENDIF

            loc_lSucesso = USED(THIS.this_cCursorSigCdCot) AND USED(THIS.this_cCursorSigCdMoe)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.CarregarCotacoesEMoedas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCambio - Retorna a cotacao da moeda na data informada.
    * Equivalente a fCarregarCambio() do sistema legado (NAO portada - ver
    * CLAUDE.md regra #27). Usa cursor_4c_SigCdMoe + cursor_4c_SigCdCot
    * carregados por CarregarCotacoesEMoedas(). Template canonico: ver
    * SigReAtmBO.CarregarCambio.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda, loc_dData, loc_oErro, loc_cCot, loc_cMoe
        loc_nCotacao = 0
        loc_cMoeda   = ALLTRIM(NVL(par_cMoeda, ""))
        loc_dData    = IIF(EMPTY(par_dData), DATE(), par_dData)
        loc_cCot     = THIS.this_cCursorSigCdCot
        loc_cMoe     = THIS.this_cCursorSigCdMoe

        IF !EMPTY(loc_cMoeda)
            TRY
                IF USED(loc_cMoe)
                    SELECT (loc_cMoe)
                    SET ORDER TO CMoes
                    IF SEEK(loc_cMoeda) AND NVL(Cotas, 0) <> 0
                        IF USED(loc_cCot)
                            SELECT (loc_cCot)
                            SET ORDER TO CMoeData DESCENDING
                            SET NEAR ON
                            SEEK loc_cMoeda + DTOS(loc_dData)
                            SET NEAR OFF
                            IF !EOF(loc_cCot) AND ALLTRIM(CMoes) = loc_cMoeda
                                loc_nCotacao = Valos
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                SET NEAR OFF
            ENDTRY
        ENDIF

        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * RecalcularSaldos - Recalcula o saldo corrente (rollforward de razao
    * contabil) de SigMvCcr para o Grupo+Conta+Moeda informados.
    *
    * fRecalculaS() do legado e uma funcao EXTERNA, fora do dump do form/VCX
    * (nao esta no acervo) - nao ha formula para TRANSCREVER (a regra "nunca
    * reescrever formula do legado" pressupoe a formula disponivel; aqui nao
    * esta). Grava numero errado em silencio seria pior que a ausencia (regra
    * CLAUDE.md #27, categoria "deixar ausente" para funcao de CALCULO) -
    * por isso esta implementacao fica restrita ao UNICO comportamento
    * evidenciado no proprio dump: cada lancamento marca opers='D' (soma) ou
    * 'C' (subtrai) e a contrapartida sempre inverte D/C - convencao padrao
    * de razao contabil de dupla entrada, nao formula proprietaria (imposto/
    * tarifa). Recalcula so a coluna 'saldos' (saldo corrente); 'saldocs' e
    * 'saldons' (saldo em conta corrente / saldo nominal) nao tem fonte para
    * derivar e ficam com o valor gravado pelo INSERT (0) - preservados
    * assim em vez de adivinhados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RecalcularSaldos(par_cGrupo, par_cConta, par_cMoeda)
        LOCAL loc_cSQL, loc_nResult, loc_nSaldo, loc_cCursor, loc_oErro, loc_lSucesso
        loc_lSucesso = .F.
        loc_cCursor  = "cursor_4c_RecalcSaldo"

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT cidchaves, opers, valors FROM SigMvCcr" + ;
                " WHERE grupos = " + EscaparSQL(ALLTRIM(par_cGrupo)) + ;
                " AND contas = " + EscaparSQL(ALLTRIM(par_cConta)) + ;
                " AND moedas = " + EscaparSQL(ALLTRIM(par_cMoeda)) + ;
                " ORDER BY datas, nopers"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResult >= 0 AND USED(loc_cCursor)
                loc_nSaldo = 0
                SELECT (loc_cCursor)
                SCAN
                    IF UPPER(ALLTRIM(NVL(opers, ""))) = "D"
                        loc_nSaldo = loc_nSaldo + NVL(valors, 0)
                    ELSE
                        loc_nSaldo = loc_nSaldo - NVL(valors, 0)
                    ENDIF

                    SQLEXEC(gnConnHandle, "UPDATE SigMvCcr SET saldos = " + ;
                        FormatarNumeroSQL(loc_nSaldo, 2) + " WHERE cidchaves = " + ;
                        EscaparSQL(cidchaves))
                ENDSCAN
                USE IN (loc_cCursor)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.RecalcularSaldos")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCamposLancamento - Zera todas as propriedades de dados do BO
    * antes de montar um novo lancamento (entrada D ou contrapartida C) -
    * evita que valor de um lancamento anterior vaze para o proximo via
    * THIS.Inserir().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCamposLancamento()
        THIS.this_cCidchaves    = ""
        THIS.this_lAutos        = .F.
        THIS.this_lConcs        = .F.
        THIS.this_cContages     = ""
        THIS.this_cContas       = ""
        THIS.this_cContems      = ""
        THIS.this_nCotacaos     = 0
        THIS.this_dDatalts      = {}
        THIS.this_dDatas        = {}
        THIS.this_dDataconcs    = {}
        THIS.this_dDatatrans    = {}
        THIS.this_dDatexcs      = {}
        THIS.this_cDocus        = ""
        THIS.this_cDopes        = ""
        THIS.this_dDtemis       = {}
        THIS.this_cEmps         = ""
        THIS.this_cGrupages     = ""
        THIS.this_cGrupems      = ""
        THIS.this_cGrupos       = ""
        THIS.this_cHists        = ""
        THIS.this_cLocals       = ""
        THIS.this_cMoedas       = ""
        THIS.this_cNfs          = ""
        THIS.this_nNlancs       = 0
        THIS.this_nNopers       = 0
        THIS.this_nNtrans       = 0
        THIS.this_nNumes        = 0
        THIS.this_cOpers        = ""
        THIS.this_nSaldocs      = 0
        THIS.this_nSaldons      = 0
        THIS.this_nSaldos       = 0
        THIS.this_cScontas      = ""
        THIS.this_nScotacaos    = 0
        THIS.this_cSgrupos      = ""
        THIS.this_cShists       = ""
        THIS.this_cSmoedas      = ""
        THIS.this_cSopers       = ""
        THIS.this_nSvalors      = 0
        THIS.this_cTipos        = ""
        THIS.this_cTitbans      = ""
        THIS.this_cTitulos      = ""
        THIS.this_cUsualts      = ""
        THIS.this_cUsuexcs      = ""
        THIS.this_nValliqs      = 0
        THIS.this_nValocurs     = 0
        THIS.this_nValors       = 0
        THIS.this_nValpags      = 0
        THIS.this_dVencs        = {}
        THIS.this_cVlancs       = ""
        THIS.this_cVopers       = ""
        THIS.this_nContapgs     = 0
        THIS.this_cDopcs        = ""
        THIS.this_nNumcs        = 0
        THIS.this_cCotusus      = ""
        THIS.this_cBcontas      = ""
        THIS.this_cBgrupos      = ""
        THIS.this_nBorderos     = 0
        THIS.this_cHist2s       = ""
        THIS.this_nIntconts     = 0
        THIS.this_cUsuconcs     = ""
        THIS.this_cAuditors     = ""
        THIS.this_dDtaudits     = {}
        THIS.this_nValprev      = 0
        THIS.this_cEmpdopncs    = ""
        THIS.this_cEmpdopnums   = ""
        THIS.this_cGruconmoes   = ""
        THIS.this_cPagos        = ""
        THIS.this_cDopotps      = ""
        THIS.this_cUsupagos     = ""
        THIS.this_nTitcancs     = 0
        THIS.this_dDtconfs      = {}
        THIS.this_cUsuconfs     = ""
        THIS.this_nNopercancs   = 0
        THIS.this_cEspecienfs   = ""
        THIS.this_cJobs         = ""
        THIS.this_nImpostos     = 0
        THIS.this_nTpimpostos   = 0
        THIS.this_cTitpais      = ""
        THIS.this_cEmpccs       = ""
        THIS.this_nRecor        = 0
        THIS.this_cCompet       = ""
        THIS.this_cEmpos        = ""
        THIS.this_cOridopnums   = ""
        THIS.this_cPastas       = ""
        THIS.this_cRcontas      = ""
        THIS.this_cTpdocnf      = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarLancamentos - Motor do processamento em lote (equivalente ao
    * PROCEDURE processamento do form legado). Gera pares de lancamento D/C
    * (debito na conta de destino, credito na conta de origem) em SigMvCcr a
    * partir do custo das operacoes financeiras marcadas na grade
    * (cursor_4c_Operacoes), convertendo moeda via CarregarCambio() quando a
    * moeda de conversao (filtro do form) estiver preenchida.
    *
    * Adaptacao de arquitetura (nao muda o RESULTADO, so a MECANICA de
    * persistencia): o legado acumula tudo num cursor bufferizado (CrAltcc)
    * e faz UM TableUpdate('Craltcc') no final; aqui cada linha e gravada via
    * THIS.Inserir() dentro de UMA unica transacao manual (a conexao deste
    * ambiente nasce com Transactions=2 - SQLCOMMIT/SQLROLLBACK explicitos em
    * GravarLancamentos), preservando a atomicidade "tudo ou nada" do
    * Update/Rollback original. A recalculo GLOBAL fRecalculaS(.T., datamgr)
    * do final do legado (varredura de escopo desconhecido) fica FORA deste
    * metodo - ver nota em RecalcularSaldos.
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarLancamentos(par_dDataIni, par_dDataFim, par_cEmpresa, par_cMoedaConversao)
        LOCAL loc_cPDtI, loc_cPDtF, loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro
        LOCAL loc_cTmp, loc_lProsseguir
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro  = ""
        THIS.this_nQtdVisTit     = 0
        THIS.this_nQtdProcessada = 0
        loc_cTmp = "cursor_4c_TmpMov"

        TRY
            THIS.CarregarCotacoesEMoedas()

            IF !USED(THIS.this_cCursorAltCc)
                THIS.CriarCursorAltCc()
            ENDIF
            IF !USED(THIS.this_cCursorAltCc)
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar a estrutura de lan" + CHR(231) + "amentos (SigMvCcr)."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT (THIS.this_cCursorAltCc)
                ZAP

                IF USED(THIS.this_cCursorMovimento)
                    USE IN (THIS.this_cCursorMovimento)
                ENDIF
                CREATE CURSOR (THIS.this_cCursorMovimento) (Emps C(3), Dopes C(20), DataS T, ;
                    custofs N(12,3), pcuss N(12,5), moecusfs C(3), moedas C(3), qtds N(10,3), ;
                    GrupoEDs C(11), ContaEDs C(11), GrupoECs C(11), ContaECs C(11), MoeOpFin C(3), ;
                    Cotacaos N(16,7), Numes N(6), EmpDopNums C(29))
                SELECT (THIS.this_cCursorMovimento)
                INDEX ON Emps + Dopes + TTOC(DataS) TAG EDD

                loc_cPDtI = FormatarDataSQL(par_dDataIni)
                loc_cPDtF = FormatarDataSQL(DATETIME(YEAR(par_dDataFim), MONTH(par_dDataFim), ;
                    DAY(par_dDataFim), 23, 59, 59))

                *-- Operacoes financeiras que ainda NAO foram lancadas (nao
                *-- gravadas em SigMvCcr) no periodo/empresa informados -
                *-- JOINs e filtros TRANSCRITOS do legado (regra de negocio).
                loc_cSQL = "select sigmvcab.valos, sigmvcab.Datas, sigmvcab.Emps, sigmvcab.dopes, sigmvcab.Numes, sigmvcab.empdopnums "
                loc_cSQL = loc_cSQL + "from sigmvcab "
                loc_cSQL = loc_cSQL + "join sigcdope on sigcdope.dopes = sigmvcab.Dopes "
                loc_cSQL = loc_cSQL + "join SigOpCdc on SigOpCdc.dopes = sigcdope.dopes "
                loc_cSQL = loc_cSQL + "And SigOpCdc.opeinatvs = 0 "
                loc_cSQL = loc_cSQL + "where sigcdope.vendas=1 and sigcdope.copers in(1,2) and sigcdope.caixas=1 "
                loc_cSQL = loc_cSQL + "And empdopnums not in ( Select distinct a.empdopnums from sigmvccr a "
                loc_cSQL = loc_cSQL + "join sigcdope on sigcdope.dopes = a.Dopes "
                loc_cSQL = loc_cSQL + "and sigcdope.vendas=1 and sigcdope.copers=1 and sigcdope.caixas=1 "
                loc_cSQL = loc_cSQL + "join SigOpCdc on SigOpCdc.dopes = sigcdope.dopes "
                loc_cSQL = loc_cSQL + "And SigOpCdc.opeinatvs = 0 "
                loc_cSQL = loc_cSQL + "join (select GrupoEDs, ContaEDs, GrupoECs, ContaECs, SigOpFin.Dopes, SigOpFin.Moedas "
                loc_cSQL = loc_cSQL + "from SigOpFin "
                loc_cSQL = loc_cSQL + "join SigOpCdc on SigOpCdc.dopes = SigOpFin.dopes "
                loc_cSQL = loc_cSQL + "And SigOpCdc.opeinatvs = 0 "
                loc_cSQL = loc_cSQL + "where contaeds <> space(11)) b on a.dopes = b.dopes "
                loc_cSQL = loc_cSQL + "and a.contas = b.contaecs and a.scontas = b.ContaEDs "
                loc_cSQL = loc_cSQL + "and a.grupos = b.GrupoECs and a.sgrupos = b.GrupoEDs) "
                loc_cSQL = loc_cSQL + "And sigmvcab.Datas Between " + loc_cPDtI + " and " + loc_cPDtF + " "
                IF !EMPTY(ALLTRIM(NVL(par_cEmpresa, "")))
                    loc_cSQL = loc_cSQL + "And sigmvcab.Emps = " + EscaparSQL(ALLTRIM(par_cEmpresa))
                ENDIF

                IF USED(loc_cTmp)
                    USE IN (loc_cTmp)
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTmp)

                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Favor Reiniciar o Processo!!!" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                *-- Filtra so as operacoes MARCADAS na grade (equivalente ao
                *-- "Select crTmpMov.* From crTmpMov, csOperacaos Where
                *-- csOperacaos.Operacaos = crTmpMov.Dopes And csOperacaos.
                *-- Marcas = .T."). this_cCursorOperacoes e uma constante
                *-- fixa da classe ("cursor_4c_Operacoes") - usada aqui como
                *-- literal para permitir o JOIN local por nome.
                IF USED("cursor_4c_Mov")
                    USE IN cursor_4c_Mov
                ENDIF

                SELECT cursor_4c_TmpMov.* ;
                    FROM cursor_4c_TmpMov, cursor_4c_Operacoes ;
                    WHERE cursor_4c_Operacoes.Operacaos = cursor_4c_TmpMov.Dopes ;
                    AND cursor_4c_Operacoes.Marcas = .T. ;
                    INTO CURSOR cursor_4c_Mov READWRITE

                IF USED(loc_cTmp)
                    USE IN (loc_cTmp)
                ENDIF

                IF !USED("cursor_4c_Mov") OR RECCOUNT("cursor_4c_Mov") = 0
                    THIS.this_cMensagemErro = "Nenhum registro foi selecionado."
                    MsgAviso(THIS.this_cMensagemErro, "Aviso")
                    loc_lProsseguir = .F.
                ELSE
                    SELECT cursor_4c_Mov
                    INDEX ON Dopes TAG Dopes
                    GO TOP
                ENDIF
            ENDIF

            IF loc_lProsseguir
                loc_lProsseguir = THIS.GerarMovimentosECustos(par_cMoedaConversao)
            ENDIF

            IF loc_lProsseguir
                loc_lSucesso = THIS.GravarLancamentos()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.ProcessarLancamentos")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarMovimentosECustos - Para cada operacao marcada (cursor_4c_Mov),
    * agrega o custo/quantidade de SigMvItn+SigCdPro (join com SigOpFin para
    * achar Grupo/Conta origem-destino) e acumula em cursor_4c_Movimento,
    * convertendo moeda via CarregarCambio quando a moeda de conversao
    * (filtro do form) estiver preenchida. Consulta e regra de conversao
    * TRANSCRITAS do PROCEDURE processamento legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarMovimentosECustos(par_cMoedaConversao)
        LOCAL loc_cSQL, loc_nResult, loc_lProsseguir, loc_oErro
        LOCAL loc_cMoeCf, loc_cMoeda, loc_nCotacao, loc_nCotaMoe, loc_nCustofs, loc_nPcuss
        loc_lProsseguir = .T.

        SELECT cursor_4c_Mov
        GO TOP
        DO WHILE loc_lProsseguir AND !EOF("cursor_4c_Mov")
            TRY
                loc_cSQL = "Select distinct a.Emps, a.dopes, a.numes, a.EmpDopnums, a.datas, sum(c.custofs) as custofs, "
                loc_cSQL = loc_cSQL + "Sum(c.pcuss) as pcuss, c.moecusfs, b.moedas, SUM(b.qtds) as qtds, "
                loc_cSQL = loc_cSQL + "d.GrupoEDs, d.ContaEDs, d.GrupoECs, d.ContaECs, d.Moedas as MoeOpFin "
                loc_cSQL = loc_cSQL + "From sigmvcab a "
                loc_cSQL = loc_cSQL + "join SigMvItn b on b.empdopnums = a.empdopnums "
                loc_cSQL = loc_cSQL + "join SigCdPro c on c.Cpros = b.Cpros "
                loc_cSQL = loc_cSQL + "join (select GrupoEDs, ContaEDs, GrupoECs, ContaECs, SigOpFin.Dopes, SigOpFin.Moedas "
                loc_cSQL = loc_cSQL + "from SigOpFin "
                loc_cSQL = loc_cSQL + "join SigOpCdc on SigOpCdc.dopes = SigOpFin.dopes "
                loc_cSQL = loc_cSQL + "And SigOpCdc.opeinatvs = 0 "
                loc_cSQL = loc_cSQL + "where contaeds <> space(11)) d on d.dopes = a.dopes "
                loc_cSQL = loc_cSQL + "Where c.pcuss >0 "
                loc_cSQL = loc_cSQL + "And a.empdopnums = " + EscaparSQL(cursor_4c_Mov.empdopnums) + " "
                loc_cSQL = loc_cSQL + "group by a.Emps, a.dopes, c.moecusfs, b.moedas, a.datas, "
                loc_cSQL = loc_cSQL + "d.GrupoEDs, d.ContaEDs, d.GrupoECs, d.ContaECs, d.Moedas, a.numes, a.EmpDopnums"

                IF USED("cursor_4c_MovIt")
                    USE IN cursor_4c_MovIt
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovIt")

                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Favor Reiniciar o Processo!!!" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                    loc_lProsseguir = .F.
                ELSE
                    SELECT cursor_4c_MovIt
                    SCAN
                        loc_nCustofs = NVL(custofs, 0)
                        loc_nPcuss   = NVL(pcuss, 0)
                        loc_cMoeCf   = IIF(EMPTY(moecusfs), moedas, moecusfs)
                        loc_cMoeda   = IIF(!EMPTY(ALLTRIM(NVL(par_cMoedaConversao, ""))), ;
                            ALLTRIM(par_cMoedaConversao), IIF(EMPTY(MoeOpFin), loc_cMoeCf, MoeOpFin))

                        loc_nCotacao = THIS.CarregarCambio(loc_cMoeCf, ConverterParaData(DataS))
                        loc_nCotaMoe = THIS.CarregarCambio(loc_cMoeda, ConverterParaData(DataS))

                        loc_nCustofs = ROUND(loc_nCustofs * loc_nCotacao / loc_nCotaMoe, 2)
                        loc_nPcuss   = ROUND(loc_nPcuss * loc_nCotacao / loc_nCotaMoe, 2)

                        INSERT INTO (THIS.this_cCursorMovimento) (Emps, Dopes, Numes, EmpDopNums, DataS, ;
                            moecusfs, moedas, GrupoEDs, ContaEDs, GrupoECs, ContaECs, MoeOpFin, Cotacaos, ;
                            custofs, pcuss, qtds) ;
                            VALUES (cursor_4c_MovIt.Emps, cursor_4c_MovIt.Dopes, cursor_4c_MovIt.Numes, ;
                            cursor_4c_MovIt.EmpDopNums, cursor_4c_MovIt.DataS, cursor_4c_MovIt.moecusfs, ;
                            cursor_4c_MovIt.moedas, cursor_4c_MovIt.GrupoEDs, cursor_4c_MovIt.ContaEDs, ;
                            cursor_4c_MovIt.GrupoECs, cursor_4c_MovIt.ContaECs, loc_cMoeda, loc_nCotaMoe, ;
                            loc_nCustofs, loc_nPcuss, cursor_4c_MovIt.qtds)
                    ENDSCAN
                    IF USED("cursor_4c_MovIt")
                        USE IN cursor_4c_MovIt
                    ENDIF
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SIGMVCMVBO.GerarMovimentosECustos")
                loc_lProsseguir = .F.
            ENDTRY

            IF loc_lProsseguir
                SKIP IN cursor_4c_Mov
            ENDIF
        ENDDO

        RETURN loc_lProsseguir
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarLancamentos - Agrupa cursor_4c_Movimento (equivalente ao "Select
    * ... From csMovimento Group By ... Into Cursor CrMvCCr") e grava o par
    * de lancamentos D/C para cada grupo, numa UNICA transacao manual
    * (Transactions=2 - regra do ambiente): tudo confirmado (SQLCOMMIT) so
    * se TODAS as linhas gravarem; qualquer falha reverte tudo (SQLROLLBACK),
    * equivalente ao Rollback do TableUpdate legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarLancamentos()
        LOCAL loc_lManual, loc_lSucesso, loc_lProsseguir, loc_oErro
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.
        loc_lManual     = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        TRY
            IF USED("cursor_4c_MvCCr")
                USE IN cursor_4c_MvCCr
            ENDIF

            SELECT Emps, Dopes, DataS, SUM(custofs) AS custofs, SUM(pcuss) AS pcuss, moecusfs, moedas, ;
                SUM(qtds) AS qtds, GrupoEDs, ContaEDs, GrupoECs, ContaECs, MoeOpFin, Cotacaos, Numes, EmpDopNums ;
                FROM (THIS.this_cCursorMovimento) ;
                GROUP BY Emps, Dopes, DataS, moecusfs, moedas, GrupoEDs, ContaEDs, GrupoECs, ContaECs, ;
                MoeOpFin, Cotacaos, Numes, EmpDopNums ;
                INTO CURSOR cursor_4c_MvCCr READWRITE

            IF !USED("cursor_4c_MvCCr") OR RECCOUNT("cursor_4c_MvCCr") = 0
                THIS.this_cMensagemErro = "Nenhum registro foi selecionado."
                loc_lProsseguir = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.GravarLancamentos")
            loc_lProsseguir = .F.
        ENDTRY

        IF loc_lProsseguir
            SELECT cursor_4c_MvCCr
            GO TOP
            DO WHILE loc_lProsseguir AND !EOF("cursor_4c_MvCCr")
                loc_lProsseguir = THIS.GerarParDC()
                IF loc_lProsseguir
                    SKIP IN cursor_4c_MvCCr
                ENDIF
            ENDDO
        ENDIF

        IF loc_lProsseguir
            IF loc_lManual
                = SQLCOMMIT(gnConnHandle)
            ENDIF
            loc_lSucesso = .T.
            THIS.ContarOperacoesVisTit()
            MsgInfo("Processamento realizado com sucesso!!!", "Confirmar")
        ELSE
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF
            IF EMPTY(THIS.this_cMensagemErro)
                THIS.this_cMensagemErro = "Favor reinicializar o processo."
            ENDIF
            MsgErro(THIS.this_cMensagemErro, "Falha no Processamento")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarParDC - Gera o par de lancamentos Debito/Credito para o grupo de
    * custo corrente de cursor_4c_MvCCr (equivalente ao Scatter+FazContra do
    * legado): entrada "D" na conta de destino (GrupoECs/ContaECs) e a
    * contrapartida "C" na conta de origem (GrupoEDs/ContaEDs), mesmo valor,
    * mesmo Nopers/Vopers (numero/identificador da transacao).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarParDC()
        LOCAL loc_lSucesso, loc_oErro, loc_nNopers, loc_cHist, loc_cHist2, loc_cVopers
        LOCAL loc_cEmps, loc_cDopes, loc_dDataS, loc_nNumes, loc_cEmpDopNums
        LOCAL loc_cGrupoEDs, loc_cContaEDs, loc_cGrupoECs, loc_cContaECs
        LOCAL loc_cMoeOpFin, loc_nCotacaos, loc_nValor, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cEmps       = cursor_4c_MvCCr.Emps
            loc_cDopes      = cursor_4c_MvCCr.Dopes
            loc_dDataS      = ConverterParaData(cursor_4c_MvCCr.DataS)
            loc_nNumes      = NVL(cursor_4c_MvCCr.Numes, 0)
            loc_cEmpDopNums = cursor_4c_MvCCr.EmpDopNums
            loc_cGrupoEDs   = cursor_4c_MvCCr.GrupoEDs
            loc_cContaEDs   = cursor_4c_MvCCr.ContaEDs
            loc_cGrupoECs   = cursor_4c_MvCCr.GrupoECs
            loc_cContaECs   = cursor_4c_MvCCr.ContaECs
            loc_cMoeOpFin   = cursor_4c_MvCCr.MoeOpFin
            loc_nCotacaos   = NVL(cursor_4c_MvCCr.Cotacaos, 0)
            loc_nValor      = NVL(cursor_4c_MvCCr.pcuss, 0)

            *-- Historico (hists/hist2s) do SigCdOpe.Dopes, equivalente ao
            *-- CursorQuery('SigCdOpe','crSigCdOpe','Dopes',m.Dopes,'hists, hist2s')
            IF USED("cursor_4c_SigCdOpeTmp")
                USE IN cursor_4c_SigCdOpeTmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT hists, hist2s FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
                "cursor_4c_SigCdOpeTmp")

            loc_cHist  = ALLTRIM(loc_cEmpDopNums)
            loc_cHist2 = ""
            IF loc_nResult > 0 AND USED("cursor_4c_SigCdOpeTmp") AND RECCOUNT("cursor_4c_SigCdOpeTmp") > 0
                SELECT cursor_4c_SigCdOpeTmp
                IF !EMPTY(NVL(hists, ""))
                    loc_cHist = ALLTRIM(hists)
                ENDIF
                IF !EMPTY(NVL(hist2s, ""))
                    loc_cHist2 = ALLTRIM(hist2s)
                ENDIF
            ENDIF
            IF USED("cursor_4c_SigCdOpeTmp")
                USE IN cursor_4c_SigCdOpeTmp
            ENDIF

            loc_nNopers = fGerUniqueKey("SigMvCcr")
            loc_cVopers = ALLTRIM(loc_cEmps) + ALLTRIM(STR(loc_nNopers, 9))

            *-- Entrada D (destino) - REPLACE do legado, transcrito literalmente
            THIS.LimparCamposLancamento()
            THIS.this_cGrupos      = loc_cGrupoECs
            THIS.this_cContas      = loc_cContaECs
            THIS.this_cSgrupos     = loc_cGrupoEDs
            THIS.this_cScontas     = loc_cContaEDs
            THIS.this_cMoedas      = loc_cMoeOpFin
            THIS.this_cSmoedas     = loc_cMoeOpFin
            THIS.this_nCotacaos    = loc_nCotacaos
            THIS.this_nScotacaos   = loc_nCotacaos
            THIS.this_dVencs       = loc_dDataS
            THIS.this_dDtemis      = loc_dDataS
            THIS.this_cOpers       = "D"
            THIS.this_cSopers      = "C"
            THIS.this_cHists       = loc_cHist
            THIS.this_cHist2s      = loc_cHist2
            THIS.this_dDatas       = loc_dDataS
            THIS.this_nNopers      = loc_nNopers
            THIS.this_cVopers      = loc_cVopers
            THIS.this_cEmps        = loc_cEmps
            THIS.this_nSvalors     = loc_nValor
            THIS.this_nValors      = loc_nValor
            THIS.this_nContapgs    = 2
            THIS.this_lAutos       = .T.
            THIS.this_cPagos       = "1"
            THIS.this_nValpags     = 0
            THIS.this_cUsualts     = gc_4c_UsuarioLogado
            THIS.this_cDopes       = loc_cDopes
            THIS.this_nNumes       = loc_nNumes
            THIS.this_cEmpdopnums  = loc_cEmpDopNums
            THIS.this_cCidchaves   = LEFT(DTOS(loc_dDataS) + ;
                TRANSFORM(fGerUniqueKey(DTOS(loc_dDataS)), "@L 999999") + THIS.this_cChaveSessao, 20)

            loc_lSucesso = THIS.Inserir()

            IF loc_lSucesso
                THIS.RecalcularSaldos(THIS.this_cGrupos, THIS.this_cContas, THIS.this_cMoedas)

                *-- Contrapartida C (origem) - mesma transacao (Nopers/Vopers),
                *-- grupo/conta principal e secundario invertidos, opers/sopers trocados
                THIS.LimparCamposLancamento()
                THIS.this_cGrupos      = loc_cGrupoEDs
                THIS.this_cContas      = loc_cContaEDs
                THIS.this_cSgrupos     = loc_cGrupoECs
                THIS.this_cScontas     = loc_cContaECs
                THIS.this_cMoedas      = loc_cMoeOpFin
                THIS.this_cSmoedas     = loc_cMoeOpFin
                THIS.this_nCotacaos    = loc_nCotacaos
                THIS.this_nScotacaos   = loc_nCotacaos
                THIS.this_dVencs       = loc_dDataS
                THIS.this_dDtemis      = loc_dDataS
                THIS.this_cOpers       = "C"
                THIS.this_cSopers      = "D"
                THIS.this_cHists       = loc_cHist
                THIS.this_cHist2s      = loc_cHist2
                THIS.this_dDatas       = loc_dDataS
                THIS.this_nNopers      = loc_nNopers
                THIS.this_cVopers      = loc_cVopers
                THIS.this_cEmps        = loc_cEmps
                THIS.this_nSvalors     = loc_nValor
                THIS.this_nValors      = loc_nValor
                THIS.this_nContapgs    = 2
                THIS.this_lAutos       = .T.
                THIS.this_cPagos       = "1"
                THIS.this_nValpags     = 0
                THIS.this_cUsualts     = gc_4c_UsuarioLogado
                THIS.this_cDopes       = loc_cDopes
                THIS.this_nNumes       = loc_nNumes
                THIS.this_cEmpdopnums  = loc_cEmpDopNums
                THIS.this_cCidchaves   = LEFT(DTOS(loc_dDataS) + ;
                    TRANSFORM(fGerUniqueKey(DTOS(loc_dDataS)), "@L 999999") + THIS.this_cChaveSessao, 20)

                loc_lSucesso = THIS.Inserir()

                IF loc_lSucesso
                    THIS.RecalcularSaldos(THIS.this_cGrupos, THIS.this_cContas, THIS.this_cMoedas)
                    THIS.this_nQtdProcessada = THIS.this_nQtdProcessada + 1
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.GerarParDC")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ContarOperacoesVisTit - Conta quantas operacoes marcadas pedem
    * visualizacao de titulos (VisTit = 1), equivalente ao filtro final do
    * legado que abria "Do Form SigMvTi2". Esse form NAO faz parte desta
    * migracao (fora do acervo/tasks atuais) - o resultado fica em
    * this_nQtdVisTit para o Form avisar o usuario, em vez de tentar abrir
    * uma tela inexistente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ContarOperacoesVisTit()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_VisTit")
                USE IN cursor_4c_VisTit
            ENDIF

            SELECT Dopes, VisTit FROM (THIS.this_cCursorOperacoes) ;
                WHERE Marcas = .T. AND VisTit = 1 ;
                INTO CURSOR cursor_4c_VisTit READWRITE

            IF USED("cursor_4c_VisTit")
                THIS.this_nQtdVisTit = RECCOUNT("cursor_4c_VisTit")
                USE IN cursor_4c_VisTit
            ENDIF
        CATCH TO loc_oErro
            THIS.this_nQtdVisTit = 0
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGMVCMVBO.ContarOperacoesVisTit")
        ENDTRY
    ENDPROC

ENDDEFINE