CORRECAO OBRIGATORIA: Colunas SQL invalidas detectadas pelo ValidadorSQLSchema.

PROBLEMAS ENCONTRADOS:
- [SQL-SCHEMA] Linha ~5753: INSERT na tabela 'sigmvcab' OMITE coluna(s) NOT NULL sem DEFAULT: npedclis, acres, antecs, chksubn, codpeds, desc2s, descs, devols, empds, grresps, grupos, iclis, ifors, locals, lotechqs, lprecos, ncarnecs, nemps, nops, notas, nrcons, ntrans, numolds, tabds, tpfats, transps, usuals, usulibs, valacres, valdes2s, valdescs, valdevs, valencs, valservs, valvars, vars, vends, cotusus, espes, qtdes, lcancelas, cofs, livros, chkbxparcs, ecfs, dgopes, trfisicos, utilizados, valndevs, valobxs, noforms, auditors, localizas, chkpagos, chkpgs, codtrans, empdnbxs, empdncrds, obsagends, operadors, vcompensas, motdscs, ndeclaras, numbalds, numbals, priors, procbals, procdbal, protats, ultgrvs, moeits, rnops, impress, pstatus, valvarps, cifccfs, cupfis, idconta, ncupoms, status, valtrans, impcpfs, ccfgnfs, fpubls, ptax1s, ptax2s, ptax3s, obscabmovs, codobs2. O SQL Server recusa o INSERT inteiro. Acrescentar as colunas que faltam (NAO trocar as existentes - cuidado com colunas gemeas de nome parecido). Preenchimento: cidchaves/pkchaves = EscaparSQL(fUniqueIds()) (NUNCA string vazia); usuars/usualts = gc_4c_UsuarioLogado; com property no BO = a property; char sem property = EscaparSQL(''); numeric = FormatarNumeroSQL(0, <decimais>); bit = 0; datetime = sentinela '19000101'.
- [SQL-SCHEMA] Linha ~5813: INSERT na tabela 'sigmvitn' OMITE coluna(s) NOT NULL sem DEFAULT: codbarras, descvals, etiesps, fators, fatvals, fvals, iconfs, locals, notas, nrcons, ntrans, numolds, pesos, qtbaixas, qtbxprods, qtprods, tpesos, unitembs, univals, vcoms, aliqs, sitribs, tpipis, valipis, aliqicms, valdescs, empos, moevs, utilizas, ncodigos, qtreservas, nlotes, baseicms, chksubn, unit2s, usulibs, valrats, codlprecs, cunips, motdscs, tipos, unitinfs, cpro2s, abrevis, bcicmss, bcipis, icms, icmss, pdescs, nchvtbds, idpro, unitorigs, origmercs, baseicm2s, baseicm3s, baseipi2s, baseipi3s, cfops, ratdacs, ratfrts, raticmds, raticms, ratsegs, sittricms, aliqiis, citem2, taxaiis, vcofins, vpis, aliqorigs, lcancelas, compris, codfabs, nadis, niadis, aliqcofs, aliqpis, cssl, inss, irrf, iss, valbases, localos. O SQL Server recusa o INSERT inteiro. Acrescentar as colunas que faltam (NAO trocar as existentes - cuidado com colunas gemeas de nome parecido). Preenchimento: cidchaves/pkchaves = EscaparSQL(fUniqueIds()) (NUNCA string vazia); usuars/usualts = gc_4c_UsuarioLogado; com property no BO = a property; char sem property = EscaparSQL(''); numeric = FormatarNumeroSQL(0, <decimais>); bit = 0; datetime = sentinela '19000101'.
- [SQL-SCHEMA] Linha ~5859: INSERT na tabela 'sigmvits' OMITE coluna(s) NOT NULL sem DEFAULT: codembs, qtdembs, aqtdembs, qtbaixas, prembs, codembents, qtdents, codbarras, pesos, qtbxprods, qtprods, locals, ntrans, qtreservas, compris. O SQL Server recusa o INSERT inteiro. Acrescentar as colunas que faltam (NAO trocar as existentes - cuidado com colunas gemeas de nome parecido). Preenchimento: cidchaves/pkchaves = EscaparSQL(fUniqueIds()) (NUNCA string vazia); usuars/usualts = gc_4c_UsuarioLogado; com property no BO = a property; char sem property = EscaparSQL(''); numeric = FormatarNumeroSQL(0, <decimais>); bit = 0; datetime = sentinela '19000101'.
- [SQL-SCHEMA] Linha ~5895: INSERT na tabela 'sigmvpar' OMITE coluna(s) NOT NULL sem DEFAULT: agencias, bancos, cartaos, contas, dcarts, ec_numes, grclis, iclis, impcars, inschs, locals, ncarnes, ncarts, ncopias, nocreditos, nrecs, ntrans, numchqs, numeros, numolds, outros, vpags, cotusus, cnidtefs, cnnsuparcs, numlotechs, nidcheps, empos, valocurs, trocos, cpfs, digagencs, digchqs, digcontas, pracas, tparcs, valdescs, codbcrts, lcancelas, vcofins, vcsll, virf, vlrtrbfs, vpis, adquirente, autoriza, nsu. O SQL Server recusa o INSERT inteiro. Acrescentar as colunas que faltam (NAO trocar as existentes - cuidado com colunas gemeas de nome parecido). Preenchimento: cidchaves/pkchaves = EscaparSQL(fUniqueIds()) (NUNCA string vazia); usuars/usualts = gc_4c_UsuarioLogado; com property no BO = a property; char sem property = EscaparSQL(''); numeric = FormatarNumeroSQL(0, <decimais>); bit = 0; datetime = sentinela '19000101'.


SCHEMA DAS TABELAS REFERENCIADAS (colunas validas):

-- Tabela: sigmvcab
CREATE TABLE [dbo].[SigMvCab](
	[npedclis] [numeric](11, 0) NOT NULL,
	[acres] [numeric](8, 4) NOT NULL,
	[antecs] [char](6) NOT NULL,
	[chksubn] [bit] NOT NULL,
	[codpeds] [numeric](8, 0) NOT NULL,
	[contads] [char](10) NOT NULL,
	[contaos] [char](10) NOT NULL,
	[datars] [datetime] NULL,
	[datas] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[desc2s] [numeric](5, 2) NOT NULL,
	[descs] [numeric](8, 4) NOT NULL,
	[devols] [numeric](8, 0) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[empds] [char](3) NOT NULL,
	[emps] [char](3) NOT NULL,
	[grresps] [char](10) NOT NULL,
	[grupods] [char](10) NOT NULL,
	[grupoos] [char](10) NOT NULL,
	[grupos] [char](10) NOT NULL,
	[grvends] [char](10) NOT NULL,
	[iclis] [char](10) NOT NULL,
	[ifors] [char](10) NOT NULL,
	[locals] [char](10) NOT NULL,
	[lotechqs] [numeric](8, 0) NOT NULL,
	[lprecos] [char](30) NOT NULL,
	[mascnum] [char](10) NOT NULL,
	[ncarnecs] [char](11) NOT NULL,
	[nemps] [char](40) NOT NULL,
	[nops] [numeric](10, 0) NOT NULL,
	[notas] [char](6) NOT NULL,
	[nrcons] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[numolds] [numeric](6, 0) NOT NULL,
	[obses] [text] NULL,
	[opers] [char](1) NOT NULL,
	[prazoents] [datetime] NULL,
	[resps] [char](10) NOT NULL,
	[tabds] [char](10) NOT NULL,
	[tpfats] [char](3) NOT NULL,
	[transps] [bit] NOT NULL,
	[usuals] [char](10) NOT NULL,
	[usuars] [char](10) NOT NULL,
	[usulibs] [char](10) NOT NULL,
	[valacres] [numeric](11, 2) NOT NULL,
	[valdes2s] [numeric](11, 2) NOT NULL,
	[valdescs] [numeric](11, 2) NOT NULL,
	[valdevs] [numeric](11, 2) NOT NULL,
	[valencs] [numeric](11, 2) NOT NULL,
	[valinis] [numeric](11, 2) NOT NULL,
	[valos] [numeric](11, 2) NOT NULL,
	[valservs] [numeric](11, 2) NOT NULL,
	[valvars] [numeric](11, 2) NOT NULL,
	[vars] [numeric](9, 4) NOT NULL,
	[vends] [char](10) NOT NULL,
	[cotusus] [char](10) NOT NULL,
	[dtemis] [datetime] NULL,
	[espes] [char](10) NOT NULL,
	[pbrus] [numeric](10, 3) NULL,
	[pliqs] [numeric](10, 3) NULL,
	[qtdes] [numeric](6, 0) NOT NULL,
	[lcancelas] [bit] NOT NULL,
	[cofs] [bit] NOT NULL,
	[livros] [bit] NOT NULL,
	[dttransms] [datetime] NULL,
	[chkbxparcs] [bit] NOT NULL,
	[ecfs] [char](7) NOT NULL,
	[codobs] [numeric](3, 0) NOT NULL,
	[dgopes] [char](20) NOT NULL,
	[dtfechas] [datetime] NULL,
	[trfisicos] [numeric](2, 0) NOT NULL,
	[utilizados] [numeric](1, 0) NOT NULL,
	[valndevs] [numeric](11, 2) NOT NULL,
	[valobxs] [numeric](11, 2) NOT NULL,
	[noforms] [char](10) NOT NULL,
	[auditors] [char](10) NOT NULL,
	[dtaudits] [datetime] NULL,
	[cidchaves] [char](20) NOT NULL,
	[dtalts] [datetime] NULL,
	[empdopnums] [char](29) NOT NULL,
	[dtbaixas] [datetime] NULL,
	[dtrecs] [datetime] NULL,
	[empgopnums] [char](29) NOT NULL,
	[contaes] [char](10) NOT NULL,
	[dtagends] [datetime] NULL,
	[localents] [numeric](10, 0) NOT NULL,
	[localizas] [char](6) NOT NULL,
	[chkpagos] [bit] NOT NULL,
	[
-- (truncado)

-- Tabela: sigmvitn
CREATE TABLE [dbo].[SigMvItn](
	[aqtds] [numeric](9, 3) NOT NULL,
	[citens] [numeric](10, 0) NOT NULL,
	[codbarras] [numeric](14, 0) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[cunis] [char](3) NOT NULL,
	[datatrans] [datetime] NULL,
	[descvals] [numeric](7, 2) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[dpros] [char](65) NOT NULL,
	[emps] [char](3) NOT NULL,
	[etiesps] [bit] NOT NULL,
	[fators] [numeric](8, 3) NOT NULL,
	[fatvals] [numeric](15, 6) NOT NULL,
	[fvals] [bit] NOT NULL,
	[iconfs] [bit] NOT NULL,
	[locals] [char](10) NOT NULL,
	[moedas] [char](3) NOT NULL,
	[moefats] [char](3) NOT NULL,
	[moevals] [numeric](15, 6) NOT NULL,
	[notas] [char](6) NOT NULL,
	[nrcons] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[numolds] [numeric](6, 0) NOT NULL,
	[obs] [text] NULL,
	[opers] [char](1) NOT NULL,
	[pesos] [numeric](9, 3) NOT NULL,
	[qtbaixas] [numeric](9, 3) NOT NULL,
	[qtbxprods] [numeric](9, 3) NOT NULL,
	[qtds] [numeric](9, 3) NOT NULL,
	[qtprods] [numeric](9, 3) NOT NULL,
	[totas] [numeric](11, 2) NOT NULL,
	[tpesos] [numeric](11, 2) NOT NULL,
	[unitembs] [numeric](11, 4) NOT NULL,
	[units] [numeric](15, 6) NOT NULL,
	[univals] [numeric](15, 6) NOT NULL,
	[vcoms] [numeric](8, 2) NOT NULL,
	[aliqs] [numeric](4, 2) NOT NULL,
	[sitribs] [char](2) NOT NULL,
	[tpipis] [char](1) NOT NULL,
	[valipis] [numeric](11, 2) NOT NULL,
	[aliqicms] [numeric](5, 2) NOT NULL,
	[valdescs] [numeric](9, 2) NOT NULL,
	[empos] [char](3) NOT NULL,
	[moevs] [char](3) NOT NULL,
	[utilizas] [numeric](4, 0) NOT NULL,
	[ncodigos] [numeric](10, 0) NOT NULL,
	[qtreservas] [numeric](9, 3) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[nlotes] [numeric](10, 0) NOT NULL,
	[dtalts] [datetime] NULL,
	[empdopnums] [char](29) NOT NULL,
	[baseicms] [numeric](11, 2) NOT NULL,
	[chksubn] [bit] NOT NULL,
	[unit2s] [numeric](15, 6) NOT NULL,
	[usulibs] [char](10) NOT NULL,
	[valrats] [numeric](14, 6) NOT NULL,
	[codlprecs] [numeric](6, 0) NOT NULL,
	[cunips] [char](3) NOT NULL,
	[motdscs] [char](10) NOT NULL,
	[tipos] [char](1) NOT NULL,
	[unitinfs] [numeric](14, 6) NOT NULL,
	[cpro2s] [char](50) NOT NULL,
	[abrevis] [char](3) NOT NULL,
	[bcicmss] [numeric](15, 2) NOT NULL,
	[bcipis] [numeric](15, 2) NOT NULL,
	[icms] [numeric](15, 2) NOT NULL,
	[icmss] [numeric](15, 2) NOT NULL,
	[pdescs] [numeric](5, 2) NOT NULL,
	[nchvtbds] [numeric](6, 0) NOT NULL,
	[idpro] [numeric](10, 0) NOT NULL,
	[unitorigs] [numeric](14, 6) NOT NULL,
	[origmercs] [char](1) NOT NULL,
	[baseicm2s] [numeric](11, 2) NOT NULL,
	[baseicm3s] [numeric](11, 2) NOT NULL,
	[baseipi2s] [numeric](11, 2) NOT NULL,
	[baseipi3s] [numeric](11, 2) NOT NULL,
	[cfops] [char](10) NOT NULL,
	[ratdacs] [numeric](11, 2) NOT NULL,
	[ratfrts] [numeric](11, 2) NOT NULL,
	[raticmds] [numeric](11, 2) NOT NULL,
	[raticms] [numeric](11, 2) NOT NULL,
	[ratsegs] [numeric](11, 2) NOT NULL,
	[sittricms] [char](3) 
-- (truncado)

-- Tabela: sigmvits
CREATE TABLE [dbo].[SigMvIts](
	[citens] [numeric](4, 0) NOT NULL,
	[emps] [char](3) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[cpros] [char](14) NOT NULL,
	[codembs] [char](3) NOT NULL,
	[codtams] [char](4) NOT NULL,
	[codcors] [char](4) NOT NULL,
	[qtds] [numeric](9, 3) NOT NULL,
	[aqtds] [numeric](9, 3) NOT NULL,
	[qtdembs] [numeric](5, 1) NOT NULL,
	[aqtdembs] [numeric](5, 1) NOT NULL,
	[qtbaixas] [numeric](9, 3) NOT NULL,
	[prembs] [numeric](9, 3) NOT NULL,
	[codembents] [char](3) NOT NULL,
	[qtdents] [numeric](9, 3) NOT NULL,
	[codbarras] [numeric](14, 0) NOT NULL,
	[pesos] [numeric](9, 3) NOT NULL,
	[qtbxprods] [numeric](9, 3) NOT NULL,
	[qtprods] [numeric](9, 3) NOT NULL,
	[datatrans] [datetime] NULL,
	[locals] [char](10) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[qtreservas] [numeric](9, 3) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[chksubn] [bit] NOT NULL,
	[compris] [numeric](6, 2) NOT NULL,
	[dtalts] [datetime] NULL,
	[chaveexterna] [char](33) NOT NULL,
 

-- Tabela: sigmvpar
CREATE TABLE [dbo].[SigMvPar](
	[agencias] [char](4) NOT NULL,
	[bancos] [char](3) NOT NULL,
	[cartaos] [char](20) NOT NULL,
	[contas] [char](10) NOT NULL,
	[cotfpgs] [numeric](11, 4) NOT NULL,
	[datas] [datetime] NULL,
	[datatrans] [datetime] NULL,
	[dcarts] [char](12) NOT NULL,
	[dopes] [char](20) NOT NULL,
	[dpags] [datetime] NULL,
	[dtdeps] [datetime] NULL,
	[ec_numes] [numeric](6, 0) NOT NULL,
	[emps] [char](3) NOT NULL,
	[fpags] [char](12) NOT NULL,
	[grclis] [char](10) NOT NULL,
	[iclis] [char](10) NOT NULL,
	[impcars] [char](1) NOT NULL,
	[inschs] [bit] NOT NULL,
	[locals] [char](10) NOT NULL,
	[moefpgs] [char](3) NOT NULL,
	[ncarnes] [char](11) NOT NULL,
	[ncarts] [numeric](10, 0) NOT NULL,
	[ncopias] [numeric](6, 0) NOT NULL,
	[nocreditos] [char](10) NOT NULL,
	[nopers] [numeric](7, 0) NOT NULL,
	[nrecs] [numeric](11, 0) NOT NULL,
	[ntrans] [numeric](6, 0) NOT NULL,
	[numchqs] [char](8) NOT NULL,
	[numeros] [char](6) NOT NULL,
	[numes] [numeric](6, 0) NOT NULL,
	[numolds] [numeric](6, 0) NOT NULL,
	[outros] [char](20) NOT NULL,
	[valos] [numeric](11, 2) NOT NULL,
	[vencs] [datetime] NULL,
	[vpags] [numeric](11, 2) NOT NULL,
	[cotusus] [char](30) NOT NULL,
	[obs] [text] NULL,
	[parcs] [numeric](2, 0) NOT NULL,
	[cnidtefs] [char](10) NOT NULL,
	[cnnsuparcs] [char](12) NOT NULL,
	[numlotechs] [numeric](8, 0) NOT NULL,
	[nidcheps] [numeric](10, 0) NOT NULL,
	[empos] [char](3) NOT NULL,
	[cidchaves] [char](20) NOT NULL,
	[valocurs] [numeric](11, 2) NOT NULL,
	[trocos] [numeric](1, 0) NOT NULL,
	[empdopnums] [char](29) NOT NULL,
	[pagos] [char](1) NOT NULL,
	[dtalts] [datetime] NULL,
	[cpfs] [char](20) NOT NULL,
	[digagencs] [char](1) NOT NULL,
	[digchqs] [char](1) NOT NULL,
	[digcontas] [char](1) NOT NULL,
	[pracas] [char](3) NOT NULL,
	[tparcs] [numeric](2, 0) NOT NULL,
	[valdescs] [numeric](11, 2) NOT NULL,
	[codbcrts] [char](5) NOT NULL,
	[lcancelas] [bit] NOT NULL,
	[vcofins] [numeric](14, 2) NOT NULL,
	[vcsll] [numeric](14, 2) NOT NULL,
	[virf] [numeric](14, 2) NOT NULL,
	[vlrtrbfs] [numeric](14, 2) NOT NULL,
	[vpis] [numeric](14, 2) NOT NULL,
	[adquirente] [char](8) NOT NULL,
	[autoriza] [char](6) NOT NULL,
	[nsu] [char](50) NOT NULL,
	[chaveexterna] [char](33) NOT NULL,
 


## Trechos relevantes do Form (C:\4c\projeto\app\forms\operacionais\Formsigmvcot.prg):

--- Linhas 5734 a 5774 ---
5734:                 EscaparSQL(loc_cGrD) + ", " + EscaparSQL(loc_cCtD) + ", " + EscaparSQL(loc_cCtE) + ", " + ;
5735:                 FormatarNumeroSQL(loc_nObs, 0) + ", " + EscaparSQL(loc_cObs) + ")"
5736: 
5737:             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5738:                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPc)" + CHR(13) + CapturarErroSQL()
5739:                 loc_lOk = .F.
5740:             ENDIF
5741: 
5742:             SELECT cursor_4c_CabOperas
5743:             GO TOP
5744:             DO WHILE loc_lOk AND !EOF("cursor_4c_CabOperas")
5745:                 loc_nNumesGrupo = cursor_4c_CabOperas.Numes
5746: 
5747:                 loc_nNum = fGerUniqueKey(ALLTRIM(loc_cDop) + loc_cEmp)
5748:                 loc_nNop = fGerUniqueKey("SIGMVCCR")
5749:                 loc_cEmpDopNums = loc_cEmp + loc_cDop + STR(loc_nNum, 6)
5750:                 loc_cEmpGopNums = loc_cEmp + SPACE(20) + STR(loc_nNum, 6)
5751: 
5752:                 *-- SigMvCab - cabecalho da movimentacao (1 por fornecedor)
5753:                 loc_cSQL = "INSERT INTO SigMvCab (cidchaves, emps, dopes, numes, empdopnums, mascnum, " + ;
5754:                     "opers, datas, datars, dtalts, grupoos, contaos, grupods, contads, contaes, " + ;
5755:                     "localents, codobs, obses, valos, valinis, usuars, prazoents, empgopnums, " + ;
5756:                     "usupagos, grvends, resps, jobs) VALUES (" + ;
5757:                     EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + ;
5758:                     EscaparSQL(loc_cEmp) + ", " + EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5759:                     EscaparSQL(loc_cEmpDopNums) + ", " + EscaparSQL(ALLTRIM(fGerMascara(loc_nNum))) + ", " + ;
5760:                     EscaparSQL(loc_cOpe) + ", " + FormatarDataSQL(loc_dDat) + ", GETDATE(), GETDATE(), " + ;
5761:                     EscaparSQL(loc_cGrO) + ", " + EscaparSQL(cursor_4c_CabOperas.IFors) + ", " + ;
5762:                     EscaparSQL(loc_cGrD) + ", " + EscaparSQL(loc_cCtD) + ", " + EscaparSQL(loc_cCtE) + ", " + ;
5763:                     FormatarNumeroSQL(loc_nEnt, 0) + ", " + FormatarNumeroSQL(loc_nObs, 0) + ", " + ;
5764:                     EscaparSQL(loc_cObs) + ", " + FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 2) + ", " + ;
5765:                     FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 2) + ", " + EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
5766:                     FormatarDataSQL(cursor_4c_CabOperas.DtEnts) + ", " + EscaparSQL(loc_cEmpGopNums) + ", " + ;
5767:                     EscaparSQL(LEFT(loc_oBO.this_cAprovador, 10)) + ", " + EscaparSQL(loc_cGrv) + ", " + ;
5768:                     EscaparSQL(LEFT(loc_oBO.this_cComprador, 12)) + ", " + ;
5769:                     EscaparSQL(LEFT(NVL(cursor_4c_CabOperas.Jobs, ""), 10)) + ")"
5770: 
5771:                 IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5772:                     loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvCab)" + CHR(13) + CapturarErroSQL()
5773:                     loc_lOk = .F.
5774:                 ENDIF

--- Linhas 5794 a 5834 ---
5794:                         EscaparSQL(LEFT(cursor_4c_CabOperas.Fornecs, 50)) + ", " + ;
5795:                         EscaparSQL(LEFT(cursor_4c_CabOperas.FPags, 12)) + ", " + ;
5796:                         FormatarDataSQL(cursor_4c_CabOperas.DtEnts) + ", " + ;
5797:                         FormatarNumeroSQL(cursor_4c_CabOperas.Qtds, 2) + ", " + ;
5798:                         FormatarNumeroSQL(cursor_4c_CabOperas.Valors, 6) + ", " + ;
5799:                         EscaparSQL(LEFT(NVL(cursor_4c_CabOperas.Fretes, ""), 12)) + ", " + ;
5800:                         FormatarNumeroSQL(cursor_4c_CabOperas.VlFretes, 2) + ")"
5801:                     IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5802:                         loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPe)" + CHR(13) + CapturarErroSQL()
5803:                         loc_lOk = .F.
5804:                     ENDIF
5805:                 ENDIF
5806: 
5807:                 *-- Itens do fornecedor corrente (cursor_4c_ItnOperas.Numes = loc_nNumesGrupo)
5808:                 IF loc_lOk
5809:                     SELECT cursor_4c_ItnOperas
5810:                     GO TOP
5811:                     LOCATE FOR cursor_4c_ItnOperas.Numes = loc_nNumesGrupo
5812:                     DO WHILE loc_lOk AND !EOF("cursor_4c_ItnOperas") AND cursor_4c_ItnOperas.Numes = loc_nNumesGrupo
5813:                         loc_cSQL = "INSERT INTO SigMvItn (cidchaves, emps, dopes, numes, empdopnums, dtalts, " + ;
5814:                             "citens, cpros, dpros, obs, opers, moedas, moefats, moevals, qtds, aqtds, units, " + ;
5815:                             "totas, cunis) VALUES (" + ;
5816:                             EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5817:                             EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5818:                             EscaparSQL(loc_cEmpDopNums) + ", GETDATE(), " + ;
5819:                             FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5820:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5821:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.DPros), 65)) + ", " + ;
5822:                             EscaparSQL(NVL(cursor_4c_ItnOperas.Obs, "")) + ", " + ;
5823:                             EscaparSQL(loc_cOpe) + ", " + EscaparSQL(loc_cMoe) + ", " + EscaparSQL(loc_cMoe) + ", " + ;
5824:                             FormatarNumeroSQL(1, 0) + ", " + ;
5825:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5826:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5827:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Units, 6) + ", " + ;
5828:                             FormatarNumeroSQL(cursor_4c_ItnOperas.Valors, 2) + ", " + ;
5829:                             EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CUnis), 3)) + ")"
5830: 
5831:                         IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5832:                             loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvItn)" + CHR(13) + CapturarErroSQL()
5833:                             loc_lOk = .F.
5834:                         ENDIF

--- Linhas 5840 a 5880 ---
5840:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5841:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Numes, 0) + ", " + ;
5842:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5843:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.DPros), 50)) + ", " + ;
5844:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodCors, ""), 4)) + ", " + ;
5845:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodTams, ""), 4)) + ", " + ;
5846:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CUnis), 3)) + ", " + ;
5847:                                 EscaparSQL(NVL(cursor_4c_ItnOperas.Obs, "")) + ", " + ;
5848:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 2) + ", " + ;
5849:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Units, 6) + ", " + ;
5850:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Valors, 6) + ")"
5851:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5852:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigCtTPi)" + CHR(13) + CapturarErroSQL()
5853:                                 loc_lOk = .F.
5854:                             ENDIF
5855:                         ENDIF
5856: 
5857:                         *-- SigMvIts - detalhe de cor/tamanho, so quando informado
5858:                         IF loc_lOk AND (!EMPTY(cursor_4c_ItnOperas.CodCors) OR !EMPTY(cursor_4c_ItnOperas.CodTams))
5859:                             loc_cSQL = "INSERT INTO SigMvIts (cidchaves, emps, dopes, numes, citens, cpros, " + ;
5860:                                 "codcors, codtams, qtds, aqtds, empdopnums, chksubn) VALUES (" + ;
5861:                                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5862:                                 EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5863:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.CItens, 0) + ", " + ;
5864:                                 EscaparSQL(LEFT(ALLTRIM(cursor_4c_ItnOperas.CPros), 14)) + ", " + ;
5865:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodCors, ""), 4)) + ", " + ;
5866:                                 EscaparSQL(LEFT(NVL(cursor_4c_ItnOperas.CodTams, ""), 4)) + ", " + ;
5867:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5868:                                 FormatarNumeroSQL(cursor_4c_ItnOperas.Qtds, 3) + ", " + ;
5869:                                 EscaparSQL(loc_cEmpDopNums) + ", 0)"
5870:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5871:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvIts)" + CHR(13) + CapturarErroSQL()
5872:                                 loc_lOk = .F.
5873:                             ENDIF
5874:                         ENDIF
5875: 
5876:                         IF loc_lOk
5877:                             SKIP IN cursor_4c_ItnOperas
5878:                         ENDIF
5879:                     ENDDO
5880:                 ENDIF

--- Linhas 5876 a 5916 ---
5876:                         IF loc_lOk
5877:                             SKIP IN cursor_4c_ItnOperas
5878:                         ENDIF
5879:                     ENDDO
5880:                 ENDIF
5881: 
5882:                 *-- SigMvPar - parcelas financeiras conforme a condicao de pagamento
5883:                 IF loc_lOk
5884:                     loc_cSQL = "SELECT FParcs, MoeFpgs, TVens, Dias FROM SigOpFp WHERE FPags = " + ;
5885:                         EscaparSQL(ALLTRIM(cursor_4c_CabOperas.FPags))
5886:                     loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalFPag")
5887: 
5888:                     IF loc_nResultado >= 0 AND USED("cursor_4c_LocalFPag") AND !EOF("cursor_4c_LocalFPag")
5889:                         loc_nPar = IIF(NVL(cursor_4c_LocalFPag.FParcs, 0) < 1, 1, cursor_4c_LocalFPag.FParcs)
5890:                         loc_dDtV = loc_dDat
5891:                         loc_cMdf = IIF(EMPTY(NVL(cursor_4c_LocalFPag.MoeFpgs, "")), loc_cMoe, ;
5892:                             ALLTRIM(cursor_4c_LocalFPag.MoeFpgs))
5893: 
5894:                         FOR loc_nI = 1 TO loc_nPar
5895:                             loc_cSQL = "INSERT INTO SigMvPar (cidchaves, emps, dopes, numes, empdopnums, " + ;
5896:                                 "datas, cotfpgs, fpags, moefpgs, nopers, valos, vencs, parcs, pagos, dtalts) VALUES (" + ;
5897:                                 EscaparSQL(LEFT(fUniqueIds(), 20)) + ", " + EscaparSQL(loc_cEmp) + ", " + ;
5898:                                 EscaparSQL(loc_cDop) + ", " + FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
5899:                                 EscaparSQL(loc_cEmpDopNums) + ", " + FormatarDataSQL(loc_dDat) + ", " + ;
5900:                                 FormatarNumeroSQL(1, 4) + ", " + EscaparSQL(LEFT(cursor_4c_CabOperas.FPags, 12)) + ", " + ;
5901:                                 EscaparSQL(LEFT(loc_cMdf, 3)) + ", " + FormatarNumeroSQL(loc_nNop, 0) + ", " + ;
5902:                                 FormatarNumeroSQL(cursor_4c_CabOperas.Valors / loc_nPar, 2) + ", " + ;
5903:                                 FormatarDataSQL(loc_dDtV) + ", " + FormatarNumeroSQL(loc_nI, 0) + ", " + ;
5904:                                 EscaparSQL("1") + ", GETDATE())"
5905: 
5906:                             IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
5907:                                 loc_cErro = "Falha na Conex" + CHR(227) + "o (GravaPedidos - SigMvPar)" + CHR(13) + CapturarErroSQL()
5908:                                 loc_lOk = .F.
5909:                             ENDIF
5910: 
5911:                             IF UPPER(ALLTRIM(NVL(cursor_4c_LocalFPag.TVens, ""))) == "F"
5912:                                 loc_dDtV = GOMONTH(loc_dDat, loc_nI)
5913:                             ELSE
5914:                                 loc_dDtV = loc_dDtV + NVL(cursor_4c_LocalFPag.Dias, 0)
5915:                             ENDIF
5916:                         ENDFOR



## Trechos relevantes do BO (C:\4c\projeto\app\classes\sigmvcotBO.prg):


REGRAS:
1. Use APENAS colunas que existem no schema acima
2. NAO invente nomes - copie EXATAMENTE do schema
3. Se uma coluna nao existe, encontre o nome correto mais proximo no schema
4. Ajuste CREATE CURSOR, SELECT, INSERT, UPDATE e ControlSource
5. NAO altere propriedades visuais (Width, Height, Top, Left, BackColor, etc.)
6. Verifique tipos: SQL BIT = VFP L (Logical), SQL DATETIME = VFP T, SQL CHAR = VFP C

Arquivos para corrigir:
- Form: C:\4c\projeto\app\forms\operacionais\Formsigmvcot.prg
- BO: C:\4c\projeto\app\classes\sigmvcotBO.prg
