# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (10)
- [SQL-COLUNA] Coluna 'matsubs' referenciada como 'C.matsubs' NAO existe na tabela SIGPRCPO. (voce quis dizer 'mats'?) Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'codtams' referenciada como 'C.codtams' NAO existe na tabela SIGPRCPO. Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'descrs' referenciada como 'PF.descrs' NAO existe na tabela SigCdPrf. Colunas validas: produtos, ordems, grupos, etiquetas, figprocs, obs, ordem2, cidchaves, minutos, uniprdts, matprdts
- [SQL-COLUNA] Coluna 'tpcalccus' em INSERT INTO sigsubcp NAO existe. Colunas validas: cats, cgrus, cidchaves, compos, cpros, cunips, datatrans, dcompos, dscgrp, dtmovs, etiqs, grupos, markcvs, mats, matsubs, moeds, obscompos, ordcompos, ordems, ordts, pcompos, pesos, qtdcvs, qtds, qtscons, tipos, totas, tpalts, unicompos, vlrcvs, vlrpvs, matriz, codtams
- [SQL-COLUNA] Coluna 'tpcalccus' em INSERT INTO SIGPRCPO NAO existe. Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'margens' em INSERT INTO SigCdPro NAO existe. (voce quis dizer 'margems'?) Colunas validas: matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, cunis, custofs, cvens, datas, datatrans, descfis, dpros, dtfilms, fcustos, figjpgs, flagctabs, fvendas, icms, ifors, linhas, locals, margems, moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, tamps, tptribs, volumes, ipis, dpro2s, dsccompras, encoms, figtecs, obscompras, codacbs, cravcers, cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, fabrproprs, qtminfabs, tents, codfinp, codmatp, dpro3s, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, conquilhas, fatuals, fideals, contaccus, gruccus, dtsituas, prodvars, prodwebs, codident, conjunts, pmins, cotacalcp, qtdultcomp, figjpgs64, diasgar, chkgarvit, altura, largura, diametro, espessura, compriment, mohs, refracao, refracaodp, ativosite, categoria, codctgsite, coddptsite, custocp, dtlacto, foralinha, mostruario, mtiposervs, obsinsp, obsmkt, precode, prodnovo, prodoff, segfem, seginf, segkids, segmasc, seguni, semconsulta, skuvtex, varpesoms, dtalts, usuaalts, bestseller, obrtamser, prototipo, lancamento, fimdtlacto, origemlac, codmacro, reposauto, procfigjpgs, propriedades, unidade1, resultado1, valorminimo, valormaximo, metodoreferencia1, qtped
- [SQL-COLUNA] Coluna 'margens' em UPDATE SigCdPro SET NAO existe. (voce quis dizer 'margems'?) Colunas validas: matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, cunis, custofs, cvens, datas, datatrans, descfis, dpros, dtfilms, fcustos, figjpgs, flagctabs, fvendas, icms, ifors, linhas, locals, margems, moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, tamps, tptribs, volumes, ipis, dpro2s, dsccompras, encoms, figtecs, obscompras, codacbs, cravcers, cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, fabrproprs, qtminfabs, tents, codfinp, codmatp, dpro3s, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, conquilhas, fatuals, fideals, contaccus, gruccus, dtsituas, prodvars, prodwebs, codident, conjunts, pmins, cotacalcp, qtdultcomp, figjpgs64, diasgar, chkgarvit, altura, largura, diametro, espessura, compriment, mohs, refracao, refracaodp, ativosite, categoria, codctgsite, coddptsite, custocp, dtlacto, foralinha, mostruario, mtiposervs, obsinsp, obsmkt, precode, prodnovo, prodoff, segfem, seginf, segkids, segmasc, seguni, semconsulta, skuvtex, varpesoms, dtalts, usuaalts, bestseller, obrtamser, prototipo, lancamento, fimdtlacto, origemlac, codmacro, reposauto, procfigjpgs, propriedades, unidade1, resultado1, valorminimo, valormaximo, metodoreferencia1, qtped
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DTALTS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DTFIMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ATIVO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "crSigCdPro.cpros"
  ControlSource = "crSigCdPro.dpros"
  ControlSource = "crSigCdPro.cbars"
  ControlSource = "crSigCdPro.ifors"
  ControlSource = "crSigCdPro.reffs"
  ControlSource = "crSigCdPro.custofs"
  ControlSource = "crSigCdPro.pvens"
  ControlSource = "crSigCdPro.fvendas"
  ControlSource = "crSigCdPro.obspes"
  ControlSource = "crSigCdPro.obspeds"
  ControlSource = "crSigCdPro.moecusfs"
  ControlSource = "crSigCdPro.moevs"
  ControlSource = "crSigCdPro.moepvs"
  ControlSource = "crSigCdPro.linhas"
  ControlSource = "crSigCdPro.colecoes"
  ControlSource = "crSigCdPro.cgrus"
  ControlSource = "crSigCdPro.dtincs"
  ControlSource = "crSigCdPro.SGrus"
  ControlSource = "crSigCdPro.ean13"
  ControlSource = "crSigCdPro.mercs"
  ControlSource = "crSigCdPro.cproeqs"
  ControlSource = "crSigCdPro.dpro2s"
  ControlSource = "crSigCdPro.cunis"
  ControlSource = "crSigCdPro.qmins"
  ControlSource = "crSigCdPro.locals"
  ControlSource = "crSigCdPro.cunips"
  ControlSource = "crSigCdPro.situas"
  ControlSource = "crSigCdPro.obsetqs"
  ControlSource = "crSigCdPro.UltComps"
  ControlSource = "crSigCdPro.vUltComps"
  ControlSource = "crSigCdPro.MUltComps"
  ControlSource = "crSigCdPro.cClass"
  ControlSource = "crSigCdPro.UsuIncs"
  ControlSource = "crSigCdPro.IdeCPros"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigCdPro.CodFinP"
  ControlSource = "crSigCdPro.ltminsv"
  ControlSource = "crSigCdPro.dsccompras"
  ControlSource = "crSigCdPro.obscompras"
  ControlSource = "crSigCdPro.DPro3s"
  ControlSource = "crSigCdPro.pesoms"
  ControlSource = "crSigCdPro.pesobs"
  ControlSource = "crSigCdPro.volumes"
  ControlSource = "crSigCdPro.tamps"
  ControlSource = "crSigCdPro.tamls"
  ControlSource = "crSigCdPro.tamhs"
  ControlSource = "crSigCdPro.tents"
  ControlSource = "crSigCdPro.consigs"
  ControlSource = "crSigCdPro.fabrproprs"
  ControlSource = "crSigCdPro.CodTams"
  ControlSource = "crSigCdPro.CodCors"
  ControlSource = "crSigCdPro.codAcbs"
  ControlSource = "crSigCdPro.encoms"
  ControlSource = "crSigCdPro.DtSituas"
  ControlSource = "crSigCdPro.prodwebs"
  ControlSource = "crSigCdPro.prodvars"
  ControlSource = "crSigCdPro.Conjunts"
  ControlSource = "crSigCdPro.qtdultcomp"
  ControlSource = "crSigCdPro.CodIdent"
  ControlSource = "crSigCdPro.DiasGar"
  ControlSource = "crSigCdPro.ChkGarVit"
  ControlSource = "crSigCdPro.altura"
  ControlSource = "crSigCdPro.largura"
  ControlSource = "crSigCdPro.diametro"
  ControlSource = "crSigCdPro.espessura"
  ControlSource = "crSigCdPro.compriment"
  ControlSource = "crSigCdPro.qtPed"
  ControlSource = "crSigCdPro.MarkupA"
  Column1.ControlSource = ""
  Column1.SelectOnEntry = .F.
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = "crSigCdPro.pcuss"
  ControlSource = "crSigCdPro.montadescs"
  ControlSource = "crSigCdPro.digimaxs"
  ControlSource = "crSigCdPro.ordcompos"
  ControlSource = "crSigCdPro.compos"
  ControlSource = "crSigCdPro.casas"
  ControlSource = "crSigCdPro.pesoms"
  ControlSource = "crSigCdPro.fcustos"
  ControlSource = "crSigCdPro.custofs"
  ControlSource = "crSigCdPro.moecs"
  ControlSource = "crSigCdPro.moepcs"
  ControlSource = "crSigCdPro.moecusfs"
  DeleteMark = .F.
  Column1.ControlSource = "TotGrupo.Grupo"
  Column2.ControlSource = "TotGrupo.ValGrupo"
  Column3.ControlSource = "TotGrupo.Moeda"
  ControlSource = "crSigCdPro.cftios"
  ControlSource = "crSigCdPro.moedas"
  ControlSource = "crSigCdPro.mftios"
  ControlSource = "crSigCdPro.pftios"
  ControlSource = "crSigCdPro.moepvs"
  ControlSource = "crSigCdPro.moevs"
  ControlSource = "crSigCdPro.fvendas"
  ControlSource = "crSigCdPro.pvens"
  ControlSource = "crSigCdPro.margems"
  ControlSource = "crSigCdPro.MatPrincs"
  ControlSource = "crSigCdPro.pvideals"
  ControlSource = "CrSigPrCpo.Dcompos"
  ControlSource = "crSigCdPro.cftiocs"
  ControlSource = "crSigCdPro.pftiocs"
  ControlSource = "crSigCdPro.Status"
  ControlSource = "crSigCdPro.Encargos"
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = "CrSigSubCp.Dcompos"
  ControlSource = "crSigSubCp.matsubs"
  ControlSource = "crSigCdPro.FAtuals"
  ControlSource = "crSigCdPro.fideals"
  ControlSource = "CrSigPrCpo.ObsOFs"
  ControlSource = "crSigCdPro.cotaCalcP"
  ControlSource = "crSigCdPro.clfiscals"
  ControlSource = "crSigCdPro.origmercs"
  ControlSource = "crSigCdPro.tptribs"
  ControlSource = "crSigCdPro.sittricms"
  ControlSource = "crSigCdPro.CodServs"
  ControlSource = "crSigCdPro.teors"
  ControlSource = "crSigCdPro.metals"
  ControlSource = "crSigCdPro.descfis"
  ControlSource = "crSigCdPro.valors"
  ControlSource = "crSigCdPro.moedas"
  ControlSource = "crSigCdPro.icms"
  ControlSource = "crSigCdPro.descecfs"
  ControlSource = "crSigCdPro.AliqIpis"
  ControlSource = "crSigCdPro.extipi"
  ControlSource = "crSigCdPro.iats"
  DeleteMark = .F.
  ControlSource = "crSigCdPro.gruccus"
  ControlSource = "crSigCdPro.contaccus"
  ControlSource = ""
  ControlSource = "crSigCdPrf.Obs"
  ControlSource = "crSigCdGcr.descrs"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "crSigCdPro.codAcbs"
  ControlSource = "crSigCdPro.qtminFabs"
  ControlSource = "crSigCdPro.CodTams"
  ControlSource = "crSigCdPro.CodCors"
  ControlSource = "crSigCdPro.PesoPdrs"
  ControlSource = "crSigCdPro.PesoBris"
  ControlSource = "crSigCdPro.CodGarras"
  ControlSource = "crSigCdPro.PesoMetal"
  ControlSource = "crSigCdPro.Varias"
  ControlSource = "crSigCdPro.CravCers"
  ControlSource = "crSigCdPro.Conquilhas"
  DeleteMark = .F.
  Column1.ControlSource = ""
  ControlSource = "crSigCdPro.qtdcpnts"
  ControlSource = "crSigCdPro.chkFunds"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  ControlSource = "crSigPrCpo.Dcompos"
  DeleteMark = .F.
  Column1.ControlSource = "TotGrupo2.Grupo"
  Column2.ControlSource = "TotGrupo2.ValGrupo"
  Column3.ControlSource = "TotGrupo2.Moeda"
  DeleteMark = .F.
  ControlSource = "crSigPrTar.ObsTars"
  DeleteMark = .F.
		Select crSigPrCpo
Select crSigCdPro
	Select Cgrus, Moeds, pCompos, Qtds From crSigPrCp2 into cursor crtmp
	Select crTmp
		Select TotGrupo
			Insert Into TotGrupo (Grupo, ValGrupo, Moeda) Values (crTmp.Cgrus, Valgr, crTmp.Moeds)
		Select TotGrupo2
			Insert Into TotGrupo2 (Grupo, ValGrupo, Moeda) Values (crTmp.Cgrus, Valgr, crTmp.Moeds)
		Select Cgrus, Moeds, pCompos, Iif(chkInstalas=2, Pesos, Qtds) as Qtds ;
		  From crSigPrCpo Where TpCalcCus = 1 into cursor crtmp
		Select Cgrus, Moeds, pCompos, Iif(chkInstalas=2, Pesos, Qtds) as Qtds ;
		  From crSigPrCpo Into cursor crtmp
	Select crTmp
		Select TotGrupo
			Insert Into TotGrupo (Grupo, ValGrupo, Moeda, Estimado ) Values ;
		Select Cgrus, Moeds, pCompos, Iif(chkInstalas=2, Pesos, Qtds) as Qtds ;
		  From crSigPrCpo ;
		Select Cgrus, Moeds, pCompos, Iif(chkInstalas=2, Pesos, Qtds) as Qtds From crSigPrCpo Into cursor crtmp
	Select crTmp
		Select TotGrupo2
			Insert Into TotGrupo2 (Grupo, ValGrupo, Moeda, Estimado ) Values ;
	Select TotGrupo
	Select TotGrupo2
SELECT CrSigPrCpo
lcQuery = [Select * ] + ;
		    [From SigOpEtq ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEti') < 1)
	Update crSigCdPro Set ImpEtiqs = crTmp.ImpEtiqs Where CPros = ThisForm.Produto
Select crSigCdPro
Select crSigCdPrd
			lcQuery = [Select Descs ] + ;
					    [From SigCdCor ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCor]) < 1)
			Select * ;
			  From crSigCdCls ;
			Select LocalClas
			Select LocalClas
		Select crSigCdDic
	Select Cgrus, Moeds, VlrCvs, QtdCvs From crSigPrCp2 Into cursor CrTmp
	Select crTmp
		Select TotGrucv
			Insert Into TotGrucv (Grupo, ValGrupo, Moeda) Values (crTmp.Cgrus, Valgr, crTmp.Moeds)
	Select Cgrus, Moeds, VlrCvs, QtdCvs, pCompos, Iif(chkInstalas=2, Pesos, Qtds) as Qtds ;
	  From crSigPrCpo Where TpCalcCus = 1 Into cursor crtmp
	Select crTmp
		Select TotGrucv
			Insert Into TotGrucv (Grupo, ValGrupo, Moeda) Values (crTmp.Cgrus, Valgr, crTmp.Moeds)
SELECT CrSigPrCpo
	.DeleteMark            = .F.
	.Column1.ControlSource = 'crListaPro.CPros'
	.Column2.ControlSource = 'Iif(ThisForm.OrdGrade = 2, crListaPro.DPro2s, crListaPro.DPros)'
		.Column4.ControlSource   = 'crListaPro.PVens'
		.Column5.ControlSource   = 'Dtoc(crListaPro.DataAlts) + Space(4) + crListaPro.HoraAlts'
		.Column6.ControlSource   = 'crListaPro.UsuaAlts'
		.Column7.ControlSource   = 'crListaPro.ImpEtiqs'
		.Column3.ControlSource   = []
		.Column3.ControlSource   = 'crListaPro.CGrus'
		.Column4.ControlSource   = 'crListaPro.SGrus'
			.Column5.ControlSource   = 'crListaPro.Compos'
			.Column5.ControlSource   = 'crListaPro.Reffs'
		.Column6.ControlSource   = 'crListaPro.Colecoes'
		.Column7.ControlSource   = 'crListaPro.ImpEtiqs'
	.Column1.ControlSource  = 'crSigCdMin.Emps'
	.Column2.ControlSource  = 'crSigCdMin.QMins'
	.DeleteMark             = .F.
	.Column1.ControlSource  = 'crSigPrCpo.Mats'
	.Column2.ControlSource  = 'crSigPrCpo.DCompos'
	.Column3.ControlSource  = 'crSigPrCpo.UniCompos'
	.Column4.ControlSource  = 'crSigPrCpo.PCompos'
	.Column5.ControlSource  = 'crSigPrCpo.Qtds'
	.Column6.ControlSource  = 'Round(Iif(crSigPrCpo.chkInstalas=2, crSigPrCpo.Pesos, crSigPrCpo.Qtds) * crSigPrCpo.PCompos, 3)'
	.Column7.ControlSource  = 'crSigPrCpo.Moeds'
	.Column8.ControlSource  = 'crSigPrCpo.ObsCompos'
	.Column9.ControlSource  = 'crSigPrCpo.Etiqs'
	.Column10.ControlSource = 'crSigPrCpo.QtsCons'
	.Column11.ControlSource = 'crSigPrCpo.Pesos'
	.Column12.ControlSource = 'crSigPrCpo.cUniPs'
	.Column13.ControlSource = 'crSigPrCpo.OrdTs'
	.Column14.ControlSource = 'crSigPrCpo.Matriz'
	.DeleteMark             = .F.
	.Column1.ControlSource  = 'crSigSubCp.Mats'
	.Column2.ControlSource  = 'crSigSubCp.DCompos'
	.Column3.ControlSource  = 'crSigSubCp.UniCompos'
	.Column4.ControlSource  = 'crSigSubCp.PCompos'
	.Column5.ControlSource  = 'crSigSubCp.Qtds'
	.Column6.ControlSource  = 'crSigSubCp.Qtds * crSigSubCp.PCompos'
	.Column7.ControlSource  = 'crSigSubCp.Moeds'
	.Column8.ControlSource  = 'crSigSubCp.ObsCompos'
	.Column9.ControlSource  = 'crSigSubCp.Etiqs'
	.Column10.ControlSource = 'crSigSubCp.QtsCons'
	.Column11.ControlSource = 'crSigSubCp.Pesos'
	.Column12.ControlSource = 'crSigSubCp.cUniPs'
	.Column13.ControlSource = 'crSigSubCp.OrdTs'
	.Column14.ControlSource = 'crSigSubCp.Matriz'
	.Column15.ControlSource = 'crSigSubCp.CodTams'	
	.DeleteMark             = .F.
	.Column1.ControlSource  = 'crSigPrCpo.Mats'
	.Column2.ControlSource  = 'crSigPrCpo.DCompos'
	.Column3.ControlSource  = 'crSigPrCpo.UniCompos'
	.Column4.ControlSource  = 'crSigPrCpo.PCompos'
	.Column5.ControlSource  = 'crSigPrCpo.Qtds'
	.Column6.ControlSource  = 'iif(crSigPrCpo.chkInstalas=2, crSigPrCpo.Pesos, crSigPrCpo.Qtds) * crSigPrCpo.PCompos'
	.Column7.ControlSource  = 'crSigPrCpo.Moeds'
	.Column8.ControlSource  = 'crSigPrCpo.ObsCompos'
	.Column9.ControlSource  = 'crSigPrCpo.Etiqs'
	.Column10.ControlSource = 'crSigPrCpo.QtsCons'
	.Column11.ControlSource = 'crSigPrCpo.Pesos'
	.Column12.ControlSource = 'crSigPrCpo.cUniPs'
	.DeleteMark             = .F.
	.Column1.ControlSource  = 'crSigCdPrf.Ordems'
	.Column2.ControlSource  = 'crSigCdPrf.Grupos'
	.Column3.ControlSource  = 'crSigCdPrf.Minutos'
	.Column4.ControlSource  = 'crSigCdPrf.UniPrdts'
	.Column5.ControlSource  = 'crSigCdPrf.MatPrdts'
	.Column1.ControlSource  = 'crSigProTp.agrupas'
	.Column2.ControlSource  = 'crSigProTp.pertemps'
	.Column1.ControlSource  = 'crSigCdCmv.Datas'
	.Column2.ControlSource  = 'crSigCdCmv.ValCuss'
	.Column3.ControlSource  = 'crSigCdCmv.Moedas'	
	.DeleteMark             = .F.
	.Column1.ControlSource  = 'crSigPrMtz.CMats'
	.Column3.ControlSource  = 'crSigPrMtz.Locals'
	.Column4.ControlSource  = 'crSigPrMtz.Qtds'
	.DeleteMark             = .f.
	.Column1.ControlSource  = [crSigPrTar.DtInis]
	.Column2.ControlSource  = [crSigPrTar.DtFims]
	.Column3.ControlSource  = [crSigPrTar.Usuars]
	.Column4.ControlSource  = [crSigPrTar.Tarefas]
	.DeleteMark             = .f.
	.Column1.ControlSource  = [crSigPrArq.Arquivos]
	.Column1.ControlSource  = 'crSigPrCpo.Mats'
	.Column2.ControlSource  = 'crSigPrCpo.Qtds'
	.Column3.ControlSource  = 'crSigPrCpo.UniCompos'
	.Column4.ControlSource  = 'crSigPrCpo.Grupos'
	.Column5.ControlSource  = 'crSigPrCpo.Dscgrp'
	.Column6.ControlSource  = 'crSigPrCpo.Ordems'
	.Column7.ControlSource  = 'crSigPrCpo.QtsCons'
	.Column8.ControlSource  = 'crSigPrCpo.Cats'
	.Column9.ControlSource  = 'crSigPrCpo.Dcompos'
Select crSigCdPrf
Select crSigPrCpo
Update crSigPrCpo Set Etiqs = [N] Where Not Etiqs = [S]
Select crSigSubCp
Update crSigSubCp Set Etiqs = [N] Where Not Etiqs = [S]
Select crSigPrCpo
Select crListaPro
Select crSigPrCpo
Select crSigSubCp
Select crSigCdPrc
Select crSigPrCp2
Select crSigSubC2
Select crSigCdPrf
Select crSigCdPfc
Select crSigPrMt2
Select crSigPrMdc
Select crSigCdGrp
Select crSigPrTam
Select crSigPrTa2
Select crSigPrCa2
Select crSigPrTar
Select crSigCdPro
	Select crSigCdGrp
	Select crSigCdGpr
	Select * From crSigPrCpo Into Cursor csTemCompo
		Select CrSigPrCpo
			Select LocalLinI
				lcSql = [Select CustoFs as pCompos, MoeCusfs as Moeds From SigCdPro Where Cpros = ']+LocalLini.Mats+[']
				ThisForm.PodataMgr.SqlExecute(lcSql,'TmpProL')
				Select TmpProl
				Insert Into crSigPrCpo From Memvar
Select &cCompo.
ThisForm.poDatamgr.SqlExecute([Select EstMins From SigCdPac],'csSigCdPac')
	Select crSigCdMin
Select Cgrus As Grupo, Mats As CPros, Moeds As Moeda, Pesos, Qtds, PCompos, 00000000.000 As ValGrupo, chkInstalas, Space(6) As sGrus ;
	From crSigPrCpo ;
Update LocalTGrupo Set ValGrupo = Iif(chkInstalas=2, Pesos, Qtds) * PCompos
Select LocalTGrupo
	Select crTmpSGr
	Select LocalTGrupo
	lcSql = [Select * From SigPrFti Where Cods = ']+MarkCus+[']
	Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
		lcSql = [Select a.*, b.Dgrus From SigPrFto a, SigCdGrp b ] + ;
		Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtioC')
			Select LocalTGrupo
				Select TmpFtioC
					Select CsGrade
			Select CsGrade
		lcSql = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where a.Cods = ']+MarkCus+[' And ]+;
		Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtioC')
		Select TmpFtioC
			Select CsGrade
	lcSql = [Select * From SigPrFti Where Cods = ']+MarkVen+[']
	Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
		lcSql = [Select a.*, b.Dgrus, 0 as altcoef ] + ;
			[From SigPrFto a, SigCdGrp b ] + ;
		Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtioC')
		Select crPrFtp
				Select TmpFtioC
			Select LocalTGrupo
				Select TmpFtioC
					Select CsGrade
			Select CsGrade
		lcSql = [Select a.*, b.Dpros From SigPrFto a, SigCdPro b Where a.Cods = ']+MarkVen+[' And ]+;
		Thisform.poDataMgr.Sqlexecute(lcSql,'TmpFtioC')
		Select TmpFtioC
			Select CsGrade
		Select CsGrade
	lcQuery = [Select Top 1 CPros, Datars ] + ;
				[From SigMvHst ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalHis') < 1)
Select crSigPrCpo
Select Mats, ObsCompos ;
  From crSigPrCpo ;
Select crMontaCPros
Select CrSigPrCpo
Update crSigPrCpo Set CPros = pPro
Update crSigSubCp Set CPros = pPro
Update crSigPrMdl Set CPros = pPro
Update crSigCdPrc Set CPros = pPro
Update crSigPrCp2 Set CPros = pPro
Update crSigSubC2 Set CPros = pPro
Update crSigPrMdc Set CPros = pPro
Update crSigPrPmi Set CPros = pPro
Update crSigCdMin Set CPros = pPro
Update crSigPrCrr Set CPros = pPro
Update crSigCdPft Set CPros = pPro, ProCarTits = Cpros + CCars + CTits
Update crSigCdPrf Set Produtos = pPro
Update crSigPrMtz Set CPros = pPro
Update crSigCdPfc Set Produtos = pPro
Update crSigPrMt2 Set CPros = pPro
Update crSigPrTam Set CPros = pPro
Update crSigPrCar Set CPros = pPro
Update crSigPrTa2 Set CPros = pPro
Update crSigPrCa2 Set CPros = pPro
Update crListaPro Set CPros = pPro &&& Tiago - 17/07/2013 - Inclui para atualizar o cursor principal pois quando copiava um produto estava gravado o produto copiado com o código do original
Update crSigPrTar Set CPros = pPro
Update crSigPrArq Set CPros = pPro
lcQuery = [Select * From SigCdPro Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarPro]) < 1)
Select CopiarPro
Insert Into crSigCdPro From Memvar
Insert Into crListaPro From Memvar
lcQuery = [Select * From SigPrCpo Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarCompo]) < 1)
Select CopiarCompo
	Insert Into crSigPrCpo From Memvar
lcQuery = [Select * From SigCdPrf Where Produtos = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarProF]) < 1)
Select CopiarProF
	Insert Into crSigCdPrf From Memvar
lcQuery = [Select * From SigPrMtz Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarMtz]) < 1)
Select CopiarMtz
	Insert Into crSigPrMtz From Memvar
lcQuery = [Select * From SigPrTar Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarTar]) < 1)
Select CopiarTar
	Insert Into crSigPrTar From Memvar
lcQuery = [Select * From SigPrArq Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarArq]) < 1)
Select CopiarArq
	Insert Into crSigPrArq From Memvar
lcQuery = [Select * From SigCdPft Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarProFt]) < 1)
Select CopiarProFt
	Insert Into crSigCdPft From Memvar
lcQuery = [Select * From SigPrTam Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarProTam]) < 1)
Select CopiarProTam
	Insert Into crSigPrTam From Memvar
lcQuery = [Select * From SigPrCar Where CPros = '] + lcPro + [']
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CopiarProCar]) < 1)
Select CopiarProCar
	Insert Into crSigPrCar From Memvar
Select CrSigPrCpo
Update crSigPrCpo ;
Select CrSigSubCp
Update CrSigSubCp ;
Update crSigCdPrf ;
Update crSigPrMtz ;
Update crSigCdPft ;
Update crSigPrTam ;
Update crSigPrCar ;
Update crSigPrTar ;
Update crSigPrArq ;
ThisForm.poDataMgr.Update([crSigCdPft])
	Select &cCompo.
		Select &cCompo.
			Select crSigCdCom
			Select &cCompo.
					Select crSigCdCom
Select &cCompo.
lcQuery = [Select * ] + ;
		    [From SigPrFnc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalFPro]) < 1)
			Select LocalFPro
			Select LocalFPro
			Select LocalFPro
			Select LocalFPro
Select crSigPrCpo
		lcQuery = [Select CGrus ] + ;
				    [From SigCdGrp ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
			Select *, 999 as DigiMaxs ;
			  From crSigPrCpo ;
			Select crOrdCompos
			Select crSigPrCpo
					Select crSigPrCpo
					Insert Into crOrdCompos From Memvar								
			Select crOrdCompos
		Select Mats From CrSigPrCpo Where Etiqs = 'S' Into Cursor selecao Order by OrdTs
		Select Selecao
				Select CsClass
					Insert Into csClass (Cods ) Values (CrTmp.cClass)
	Select &lcArea
lcQuery = [Select resultado from SigPrSic where cIdChaves = ']+lcChave+[']
If( ThisForm.poDataMgr.SQLExecute(lcQuery,[crSigPrSic]) < 1 )
	lcQuery = [Insert into SigPrSic(cTipos,Mercs,Indicador,ValorCmp,Resultado,cIdChaves) Values ('] + ;
	ThisForm.poDataMgr.SQLExecute(lcQuery)
Select Distinct CGrus, Linguas, TpMontas ;
  From crSigCdPrd ;
Select LocalMontas
			Select crSigCdDic
Select crSigPrCpo
Select crSigPrCpo
	Select crSigPrCpo
			lcQuery = [Select a.cUnis, a.cUnips, b.BPesos ] + ;
					  [From SigCdPro a, SigCdGrp b ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSomaGru') < 1)
				lcSql = [Select Fators From SigCdUni Where Cunis = ']+Iif(CrSomaGru.bPesos=1,CrSomaGru.Cunis,CrSomagru.CUnips)+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalUni')
				Select crSigPrCpo
		Select crSigPrCpo
	Select CrSigPrCpo
	SELECT crSigPrCpo
		lcSql = [Select a.*, b.rClis From SigPrFnc a Inner Join SigCdCli b on b.iClis = a.IFors Where cPros = ']+crSigPrCpo.mats+[']
		lcSql = [Select * ] + ;
				    [From SigPrFnc ] + ;
		thisform.Podatamgr.Sqlexecute(lcSql,'CrSigPrFnctmp')
		SELECT CrSigPrFnctmp
			SELECT crSigPrCpo
			SELECT CrSigPrFnctmp
	lcSql = [Select * From SigcdCpo Where grupos = ']+crSigCdPro.cgrus+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'crSigCdCpo')
	SELECT crSigcdCpo
		lcQ = [SELECT * from crsigcdcpo where 1=1 ]+lcCheTp + lcCheVal + [ into cursor crCpo]
		SELECT crCpo
	SELECT crSigcdPro
lcQuery = [Select b.chkInstalas ] + ;
			[From SigCdPro a, SigCdGrp b ] + ;
If ThisForm.poDataMgr.SqlExecute(lcQuery,'LocalInstal') < 1
Select crSigPrCpo
		lcQuery = [Select a.PesoMs, b.CfgGerGprs ] + ;
				    [From SigCdPro a, SigCdGrp b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalProCp]) < 1)
		Select crSigPrCpo
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigOpArq Where fkChaves = '] + Padr(pPro, 30) + ['], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdPro Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrMdl Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdPrf Where Produtos = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrCpo Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrPmi Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrCrr Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdPft Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigSubCp Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdCat Where Cods = '] + Left(pPro,6) + ['], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdSvc Where cCats = '] + Left(pPro,6) + ['], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrFnc Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrTam Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrCar Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigOpArq Where fkChaves = '] + Padr(pPro, 30) + ['], '') < 1)
	If Not ThisForm.poDataMgr.Update('crSigCdPrc')
	If Not ThisForm.poDataMgr.Update('crSigPrMdc')
	If Not ThisForm.poDataMgr.Update('crSigCdPfc')
	If Not ThisForm.poDataMgr.Update('crSigPrMt2')
	If Not ThisForm.poDataMgr.Update('crSigPrCp2')
	If Not ThisForm.poDataMgr.Update('crSigPrCrr')
	If Not ThisForm.poDataMgr.Update('crSigSubC2')
	If Not ThisForm.poDataMgr.Update('crSigPrTa2')
	If Not ThisForm.poDataMgr.Update('crSigPrCa2')
	Delete From crProcurar Where CPros = pPro
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrMdl Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdPrf Where Produtos = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrCpo Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrPmi Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrCrr Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigCdPft Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigSubCp Where CPros = ?pPro], '') < 1)
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrFtp Where CPros = ?pPro], '') < 1)
	If Not ThisForm.poDataMgr.Update('crSigCdPro')
	If Not ThisForm.poDataMgr.Update('crSigPrMdl')
	If Not ThisForm.poDataMgr.Update('crSigCdPrf')
	If Not ThisForm.poDataMgr.Update('crSigPrMtz')
	If Not ThisForm.poDataMgr.Update('crSigPrCpo')
	If Not ThisForm.poDataMgr.Update('crSigPrPmi')
	If Not ThisForm.poDataMgr.Update('crSigCdPrc')
	If Not ThisForm.poDataMgr.Update('crSigPrMdc')
	If Not ThisForm.poDataMgr.Update('crSigCdPfc')
	If Not ThisForm.poDataMgr.Update('crSigPrMt2')
	If Not ThisForm.poDataMgr.Update('crSigPrCp2')
	If Not ThisForm.poDataMgr.Update('crSigPrCrr')
	If Not ThisForm.poDataMgr.Update('crSigPrFnc')
	If Not ThisForm.poDataMgr.Update('CrSigCdCat')
	If Not ThisForm.poDataMgr.Update('crSigCdSvc')
	If Not ThisForm.poDataMgr.Update('crSigSubCp')
	If Not ThisForm.poDataMgr.Update('crSigSubC2')
	If  Not ThisForm.poDataMgr.Update('crSigCdPft')
	If Not ThisForm.poDataMgr.Update('crSigPrFtp')
	If Not ThisForm.poDataMgr.Update('crSigPrTam')
	If Not ThisForm.poDataMgr.Update('crSigPrCar')
	If Not ThisForm.poDataMgr.Update('crSigPrTa2')
	If Not ThisForm.poDataMgr.Update('crSigPrCa2')
	If Not ThisForm.poDataMgr.Update('crSigPrTar')
	If Not ThisForm.poDataMgr.Update('crSigPrArq')
	Select crListaPro
	If Seek(lcChv, 'crProcurar', 'CPros')
		Select crProcurar
	Select crListaPro
	If Not ThisForm.poDataMgr.Update('crSigCdPro')
	If Not ThisForm.poDataMgr.Update('crSigPrMdl')
	If Not ThisForm.poDataMgr.Update('crSigCdPrf')
	If Not ThisForm.poDataMgr.Update('crSigPrMtz')
	If Not ThisForm.poDataMgr.Update('crSigPrCpo')
	If Not ThisForm.poDataMgr.Update('crSigPrPmi')
	If Not ThisForm.poDataMgr.Update('crSigCdPrc')
	If Not ThisForm.poDataMgr.Update('crSigPrMdc')
	If Not ThisForm.poDataMgr.Update('crSigCdPfc')
	If Not ThisForm.poDataMgr.Update('crSigPrMt2')
	If Not ThisForm.poDataMgr.Update('crSigPrCp2')
	If Not ThisForm.poDataMgr.Update('crSigPrCrr')
	If not ThisForm.podatamgr.Update('crSigPrFnc')
	If Not ThisForm.poDataMgr.Update('CrSigCdCat')
	If Not ThisForm.poDataMgr.Update('crSigCdSvc')
	If Not ThisForm.poDataMgr.Update('crSigCdPft')
	If Not ThisForm.poDataMgr.Update('crSigSubCp')
	If Not ThisForm.poDataMgr.Update('crSigSubC2')
	If Not ThisForm.poDataMgr.Update('crSigPrTam')
	If Not ThisForm.poDataMgr.Update('crSigPrCar')
	If Not ThisForm.poDataMgr.Update('crSigPrTa2')
	If Not ThisForm.poDataMgr.Update('crSigPrCa2')
	If Not ThisForm.poDataMgr.Update('crSigPrTar')
	If Not ThisForm.poDataMgr.Update('crSigPrArq')
Delete From crProcurar Where CPros = pPro
			ThisForm.poDataMgr.SqlExecute([Select * From SigCdPrc Where ] + lcBus + [DPros = ?pDes], [crTmp])
			ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where ] + lcBus + [DPros = ?pDes], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPrc Where ] + lcBus + [Rtrim(DPros) Like ?pDes], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where ] + lcBus + [Rtrim(DPros) Like ?pDes], [crTmp])
			ThisForm.poDataMgr.SqlExecute([Select * From SigCdPrc Where ] + lcBus + [DPro2s = ?pD2s], [crTmp])
			ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where ] + lcBus + [DPro2s = ?pD2s], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPrc Where ] + lcBus + [Rtrim(DPro2s) Like ?pD2s], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where ] + lcBus + [Rtrim(DPro2s) Like ?pD2s], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPrc Where Rtrim(Reffs) Like ?pRff], [crTmp])
					ThisForm.poDataMgr.SqlExecute([Select * From SigCdPro Where Rtrim(Reffs) Like ?pRff], [crTmp])
	Select CrTmp
		If Not Seek(CrTmp.Cgrus,'crSigCdGrpFilter','CGrus')
			Delete In CrTmp
	Select * From CrTmp Into Cursor CrTmp2 ReadWrite
		Select crTmp2
				If Not Seek(CrTmp2.Cgrus,'crSigCdGrpFilter','CGrus')
				If Not Seek(lcChv, [crProcurar], [cIdChaves])
				 	Insert Into crProcurar From MemVar
				If Not Seek(crTmp2.Cgrus,'crSigCdGrpFilter','CGrus')
				If Not Seek(lcChv, [crProcurar], [CPros])
				 	Insert Into crProcurar From MemVar
Select crListaPro
Select crListaPro
		Select crProcurar
			If Not Seek(lcChv, 'crListaPro', 'cIdChaves')
			 	Insert Into crListaPro From MemVar
		Select crProcurar
			If Not Seek(lcChv, 'crListaPro', 'CPros')
			 	Insert Into crListaPro From MemVar
Select crListaPro
	lcLstPro = [Select CPros, DPros, DPro2s, CGrus, SGrus, Reffs, Colecoes, ImpEtiqs, Situas, Compos, ] + ;
				 [From SigCdPrc ] + ;
	lcQryPro = [Select * From SigCdPrc Where cIdChaves = ?pIds]
	lcQryCompo = 'Select *, 0 as TpCalcCus, Space(20) as Tipos, 0 as Bloqueio, 0 as chkInstalas From SigPrCp2 Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
	lcQrySubCp = 'Select *, 0 as TpCalcCus, Space(20) as Tipos, 0 as Bloqueio From SigSubC2 Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
	lcQryModP  = 'Select * From SigPrMdc Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
	lcQryProF  = 'Select a.*,b.Descrs From SigCdPfc a Inner Join SigCdGcr b On a.Grupos = b.Codigos Where Produtos = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
	lcQryMtz   = 'Select a.*, b.Locals From SigPrMt2 a Inner Join SigCdPro b On a.CMats = b.CPros Where a.CPros = ?pPro And a.DataAlts = ?pDtA And a.HoraAlts = ?pHrA And a.UsuaAlts = ?pUsA'
		lcQryPro = [Select *, Space(20) as cIdChaves From SigCdPro Where CPros = ?pPro]
			lcLstPro = [Select a.CPros, a.DPros, a.DPro2s, a.CGrus, a.SGrus, a.Reffs, a.Colecoes, a.ImpEtiqs, ] + ;
						 [From SigCdPro a, SigCdPst b ] + ;
			lcLstPro = [Select CPros, DPros, DPro2s, CGrus, SGrus, Reffs, Colecoes, ImpEtiqs, Situas, ] + ;
						 [From SigCdPro ] + ;
		lcQryPro = [Select *, Space(20) as cIdChaves ] + ;
					 [From SigCdPro ] + ;
	lcQryCompo = 'Select *, 0 as TpCalcCus, 0 as Bloqueio, 0 as chkInstalas From SigPrCpo Where CPros = ?pPro Order by OrdTs'
	lcQrySubCp = 'Select *, 0 as TpCalcCus, 0 as Bloqueio From SigSubCp Where CPros = ?pPro Order by OrdTs'	
	lcQryModP  = 'Select * From SigPrMdl  Where CPros = ?pPro'
	lcQryProF  = 'Select a.*,b.Descrs, a.Grupos+Str(a.Ordems,2) as GrpOrdem From SigCdPrf a Inner Join SigCdGcr b On a.Grupos = b.Codigos Where Produtos = ?pPro'
	lcQryMtz   = 'Select a.*, b.Locals From SigPrMtz a Inner Join SigCdPro b On a.CMats = b.CPros Where a.CPros = ?pPro'
lcQryPro2  = 'Select * From SigCdPrc Where CPros = ?pPro'
lcQryComp2 = 'Select * From SigPrCp2 Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
lcQrySubC2 = 'Select * From SigSubC2 Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
lcQryModP2 = 'Select * From SigPrMdc Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
lcQryProF2 = 'Select * From SigCdPfc Where Produtos = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
lcQryMtz2  = 'Select * From SigPrMt2 Where CPros = ?pPro And DataAlts = ?pDtA And HoraAlts = ?pHrA And UsuaAlts = ?pUsA'
lcQryProMI = 'Select * From SigPrPmi Where CPros = ?pPro'
lcQryPrEmp = 'Select * From SigCdMin Where CPros = ?pPro'
lcQryGru   = 'Select * From SigCdGrp Where CGrus = ?pGru'
lcQrySGru  = 'Select * From SigCdPsg Where CGrus = ?pGru And Codigos = ?pSGr'
lcQryCrPro = 'Select * From SigPrCrr Where CPros = ?pPro'
lcQryProFT = 'Select * From SigCdPft Where CPros = ?pPro'
lcQryFPro  = 'Select a.*, b.rClis From SigPrFnc a Inner Join SigCdCli b on b.iClis = a.IFors Where cPros = ?pPro'
lcQryGccr  = 'Select * From SigCdGcr'
lcQryParam = 'Select * From SigCdPam'
lcQryMTal  = 'Select * From SigCdMtl'
lcQryPFtp  = 'Select * From SigPrFtp'
lcQryProTp = 'Select * from SigProTp Where Cpros = ?pPro'
lcQryCmv = 'Select * from SigCdCmv where Cpros = ?pPro'
lcQryPrTam = [Select a.*, b.Descs from SigPrTam a Inner Join SigCdTam b On a.CodTams = b.Cods where a.Cpros = ?pPro]
lcQryPrCar = [Select a.*, b.Descrs from SigPrCar a Inner Join SigCrRap b On a.Codigos = b.Codigos Where a.CPros = ?pPro]
lcQryPrTa2 = [Select a.*, b.Descs from SigPrTa2 a Inner Join SigCdTam b On a.CodTams = b.Cods where a.Cpros = ?pPro And a.DataAlts = ?pDtA And a.HoraAlts = ?pHrA And a.UsuaAlts = ?pUsA]
lcQryPrCa2 = [Select a.*, b.Descrs from SigPrCa2 a Inner Join SigCrRap b On a.Codigos = b.Codigos Where a.CPros = ?pPro And a.DataAlts = ?pDtA And a.HoraAlts = ?pHrA And a.UsuaAlts = ?pUsA]
lcQryPrTar = [Select * From SigPrTar Where CPros = ?pPro]
lcQryPrArq = [Select * From SigPrArq Where CPros = ?pPro]
		Select LocalGru
lcQuery = [select cgrus,codigos, cgrucods  from sigcdpsg]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSubGrupo]) < 1)
Select crSubGrupo
lcQuery = [Select a.Tipos, a.Custos, b.CGrus ] + ;
		    [From SigCdTpc a, SigCdCom b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdCom]) < 1)
Select crSigCdCom
lcQuery = [Select a.Cods, a.Descs, b.CGrus ] + ;
			[From SigCdCls a ] + ;
			[Left Join SigCdCla b On a.Cods = b.Cods]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdCls]) < 1)
Select crSigCdCls
Update crSigCdCls Set CGrus = [] Where IsNull(CGrus )
lcQuery = [Select * From SigCdPrd]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdPrd]) < 1)
Select crSigCdPrd
lcQuery = [Select Tipos ] + ;
		    [From SigCdTpc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdTpc]) < 1)
Select crSigCdTpc
lcSql = [Select Count(1) as Qt From SigCdUni WherE cEstos = '3' ]
If (ThisForm.poDataMgr.SqlExecute(lcSql, 'CstmpUni') < 1)
lcSql = [Select * From SigCdPac]
If (ThisForm.poDataMgr.SqlExecute(lcSql, 'CrSigCdPac') < 1)
lcQuery = [Select * From SigCdCat]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CsProCat]) < 1)
Select CsProCat
lcQuery = [Select * From SigCdSvc ]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [CsProSer]) < 1)
Select CsProSer
Select crSigCdGcr
lStrQuery = [Select Distinct a.CPros, a.DPros, a.Locals, a.CGrus, a.MontaDescs, b.MtPrimas, Space(20) as Tipos, 1 as Custos, b.CfgGerGprs, a.Situas, a.Reffs ] + ;
			  [From SigCdPro a, SigCdGrp b ] + ;
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrMtPrimaC') < 1
Select * From CrMtPrimaC Where MtPrimas = 4 Into Cursor crMatrizes ReadWrite
Select crMatrizes
Select * From CrMtPrimaC Where MtPrimas In (1, 2) And Iif(Int(Val(Substr(CfgGerGprs, 38, 1))) = 1,Situas = 1,.t.) Into Cursor crMtPrima ReadWrite
Select CrMtPrima
lcQuery = [Select Distinct a.Conjunts From SigCdPro a Inner Join SigCdGrp b On a.CGrus = b.CGrus Where b.MtPrimas = 3 And a.Conjunts <> '' Order By a.Conjunts]
If ThisForm.poDataMgr.SqlExecute(lcQuery,'CrConjunto') < 1
Select crConjunto
lStrQuery = [Select Tipos From SigCdCom]			  
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'LocalCdCom') < 1
	Select * From CrMtPrima Into Cursor CrMtPrimaT ReadWrite
	lStrQuery = [Select Distinct a.CPros, a.DPros, a.CGrus, a.MontaDescs, b.MtPrimas, c.Tipos, d.Custos, a.Reffs ] + ;
				  [From SigCdPro a, SigCdGrp b, SigCdCom c, SigCdTpc d ] + ;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrMtPrimaT') < 1
	Select CrMtPrimaT
lcQuery = [Select CGrus, DGrus, Mercs, Margems, 'S' as Apagar From SigCdGrp]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdGrpFilter') < 1)
Select crSigCdGrpFilter
		If Not Empty(lcBus) And Seek(lcBus, 'crSigCdGrpFilter', 'CGrus')
Delete From crSigCdGrpFilter Where Apagar = 'S'
Select crSigCdMtl
		Insert Into TmpMtal (Codigos, Descs) Values (crSigCdMtl.Codigos, crSigCdMtl.Descs)
		Insert Into TmpTeor (Codigos, Descs) Values (crSigCdMtl.Codigos, crSigCdMtl.Descs)
Select * From crListaPro Into Cursor crProcurar ReadWrite
		Select crListaPro
			Select crListaPro
	Select crListaPro
		Select crListaPro
				Select crTmp
				Insert Into crProcurar From Memvar
lcQuery = [Select Distinct a.Cods, a.Cond1s, a.Cond2s, a.Cond3s, a.Cond4s ] + ;
			[From SigCdPst a ] + ;
		   		[Select Distinct b.Resumos ] + ;
		   		  [From SigSyCpo b ] + ;
		   		[Select Distinct b.Resumos ] + ;
		   		  [From SigSyCpo b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdPst]) < 1)
lcQuery = [Select Str(Len(Ltrim(Rtrim(a.Expressao))), 10) as COrdems, a.Expressao, a.Traducao ] + ;
			[From SigCdDic a ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crSigCdDic]) < 1)
	lcQuery = [Select Left(CodCads, 10) as CodCads, DesCads ] + ;
				[From SigCdCad ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crTarefas]) < 1)
	Select crTarefas
	lcSql = [Select FigJpgs From SigCdPro where Cpros = ']+CrListaPro.Cpros+[']
	If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalPro') > 0
Select crListaPro
		Select crListaPro
		Select crSigCdPro
SELECT *, pkchaves as cidChaves from crSigPrFtp where cpros = pPro1 into cursor crPrFtp READWRITE
Select crListaPro
	lcQuery = [Update SigCdPro Set DPros = ?pcDpro Where CPros = '] + crSigCdPro.CPros + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Select AltProds ] + ;
					[From SigCdCol ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crBusCol]) < 1)
		Select crBusCol
lcSql = [Select TpCalcPs,PesMts,MarkAplics,MoeMrkaps,CodProds From SigCdGrp Where Cgrus = ']+pGru+[']
ThisForm.poDataMgr.SqlExecute(lcSql, [crTmpGru])
	Select crSigCdPro
				Select crSigCdPrd
	Select crSigCdGrp
	Select crSigCdPro
		Select crSigPrCpo
		lcQuery = [Select * ] + ;
				    [From SigCdCli ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
	Select crSigCdPrf
	=Seek(crSigCdPro.Metals, 'TmpMtal', 'Codigos')
	=Seek(crSigCdPro.Teors,  'TmpTeor', 'Codigos')
	Select crSigPrCpo
	Update crSigPrCpo Set Etiqs = [N] Where Not Etiqs = [S]
	Select crSigSubCp
	Update crSigSubCp Set Etiqs = [N] Where Not Etiqs = [S]
	Select crSigPrMtz
			Insert Into crSigPrMtz (CPros, cIdChaves) Values (crSigCdPro.CPros, fUniqueIds())
Select crSigCdPro
		lStrQuery = [Select Top 1 UsuaAlts ] + ;
					  [From SigCdPrc ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lStrQuery, 'TmpUltimo') < 1)
	Select crSigCdPro
	Insert Into crSigCdPrc From MemVar
	Select crSigPrCpo
		Select crSigPrCpo
		Insert Into crSigPrCp2 From MemVar
	Select crSigSubCp
		Select crSigSubCp
		Insert Into crSigSubC2 From MemVar
	Select crSigCdPrf
		Select crSigCdPrf
		Insert Into crSigCdPfc From MemVar
	Select crSigPrMtz
		Select crSigPrMtz
		Insert Into crSigPrMt2 From MemVar
	Select crSigPrMdl
		Select crSigPrMdl
		Insert Into crSigPrMdc From MemVar
	Select crSigPrTam
		Select crSigPrTam
		Insert Into crSigPrTa2 From MemVar
	Select crSigPrCar
		Select crSigPrCar
		Insert Into crSigPrCa2 From MemVar
		Insert Into crSigPrCrr (CPros, cIdChaves) Values (crSigCdPro.CPros, fUniqueIds())
=Seek(pGru, 'crSigCdGrpFilter', 'CGrus')
Select crSigCdPro
		lcQuery = [Select a.Linhas, b.Descs ] + ;
				    [From SigCdGpr a, SigCdLin b ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalLinha]) < 1)
lnOldSel = Select()
		Select crEstoque 
		lcQuery=[select a.Emps, a.Grupos, a.Estos, a.Sqtds, a.Cpros, c.Dpros, a.codtams, a.codcors ] + ;
				[From sigmvest a ] + ;
				[Join SigCdEmp b on a.emps = b.cemps ] + ;
				[Join SigCdPro c on a.Cpros = c.Cpros ] + ;
		If ThisForm.podatamgr.SqlExecute(lcQuery,[crTmpEst]) < 1
		Select crTmpEst
			Select crEstoque
		Select crEstoque
Select(lnOldSel)
		Select crSigCdTpc
		Select crSigPrCpo
				Select crSigCdCom
		Select crSigSubCp
				Select crSigCdCom
	Select crSigCdPro
	Select crSigCdPro
	lcQuery = [Select DataAlts, UsuaAlts ] +;
				[From SigCdPrc ] +;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crBusPro2]) < 1)
	Select crBusPro2
	lcQuery = [Select e.Sqtds ] + ;
				[From SigMvEst e ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crBusPro2]) < 1)
	Select crBusPro2
		Select * ;
		  From crSigCdCls ;
Select crSigCdPro
Select crSigPrCpo
Select crSigSubCp
Select crSigCdPrf
	lcQuery = [Select CPros ] + ;
			    [From SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
Delete From crSigPrMtz Where Qtds <= 0 Or Empty(CMats)
Delete From crSigPrTar Where IsEmpty(DtInis) Or Empty(Tarefas)
Delete From crSigPrArq Where Empty(Arquivos)
		lcQuery = [Select CPros From SigCdPro Where Reffs = '] + crSigcdpro.reffs + ['] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
		Select LocalPro
		lcQuery = [Select CPros, Cunis, CuniPs ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
		lcQuery = [Select CPros, DPros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
	Select crSigPrCpo
				Select CrMtPrima
			  		Select crSigPrCpo
				Select CrMtPrima
			  		Select crSigPrCpo
		Select crSigPrCpo
				Select Produtos ;
				  From crSigCdPrf ;
		Select cpros,Mats from CrSigPrCpo Where cats = ' ' group by cpros,mats having sum(1) > 1 ;
		Select CsDuplCompo
	Select crSigPrCpo
			Delete
			lcQuery = [Select CGrus ] + ;
					    [From SigCdGrp ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
				Select *, 999 as DigiMaxs ;
				  From crSigPrCpo ;
				Select crOrdCompos
				Select crSigPrCpo
						Select crSigPrCpo
						Insert Into crOrdCompos From Memvar								
				Select crOrdCompos
			Select Mats From CrSigPrCpo Where Etiqs = 'S' Into Cursor selecao Order by OrdTs
			Select Selecao
					Select CsClass
						Insert Into csClass (Cods ) Values (CrTmp.cClass)
					lcSql = [Select * From SigPrFti Where Cods = ']+MarkVd+[']
					ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select LocalProCo
		Select LocalGru
		Select a.Mats,a.Cgrus,b.Mercs From CrSigPrCpo a, LocalGru b Where a.Cgrus = b.cgrus ;
		Select LocalProCo
					Select CsComposicao
						Select CsComposicao
						Select CsComposicao
						Select CsComposicao
						Select CsComposicao
					Select CsComposicao
					Select crSigCdPrd
	Select crSigCdPro
		Select crSigCdPrf
	Select crSigCdPro
	lcSQLCmd = 'Delete From SigPrCrr Where CPros = ?pPro'
	If (ThisForm.poDataMgr.SQLExecute(lcSQLCmd, '') < 1)
	lcQrySGru  = [Select * From SigCdPsg Where CGrus = ']+oPag.PgDados.Getcgru.Value+[' Order By nFaixaFins]
	If (ThisForm.poDatamgr.SqlExecute(lcQrySGru,'csSigCdPsg') < 1)
	Select csSigCdPsg
			Select crSigCdPro
			Select crSigCdPro
	Select CrSigPrFtp
	Select CrSigCdCat
	Select CrSigCdSvc
			Insert Into CrSigCdCat (Cods,Descs,Desc2s,CidChaves) Values ;
			Insert Into CrSigCdSvc (cCats,cMoeds,Bases,GruFins,CidChaves,coefs,coefretrs) Values ;
			lcQuery = [Select * from SigCdSvc where cCats = '] + Left(crSigCdPro.CPros,6) + [']
			ThisForm.poDataMgr.SqlExecute(lcQuery,[TmpServ])
			Select TmpServ
				Insert into CrSigCdSvc from MEMVAR
	SELECT csGrade
			Insert Into CrSigPrFtp (cGrus, cods, coefs, cpros, PkChaves) Values ;
	lcQuery = [Delete From SigPrPrt Where CPros = '] + CrSigCdPro.Cpros + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, []) < 1)
		lcQuery = [Select Emps, Cpros, Sum(Sqtds) as Qtds ] + ;
					[From SigMvEst ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'dbImp') < 1)
		Select dbImp
						lcSql = [Select Str(Cbars,14) as Cpros, Empos as EmpS, Qtds From SigOpEtq ]+;
						ThisForm.Podatamgr.Sqlexecute(lcsql,'DbImp')
						Select dbImp
							Insert Into dbImpressao (Cpros, Qtds, Empresa) Values (dbImp.Cpros, dbImp.Qtds, dbImp.Emps)
							Insert Into dbImpressao (Cpros, Qtds, Empresa) Values (pPro, _QtEtiq, _Empr)
							Select dbImp
								Insert Into dbImpressao (Cpros, Qtds, Empresa) Values (pPro, dbImp.Qtds, dbImp.Emps)
						Select dbImpressao
			Select crUni
						Select crSigCdPro
						Select crSigCdPro
	Select crSigCdPro
	Select crSigCdPro
	Select crSigCdPrf
	Delete From crSigCdPrf Where Produtos=ThisForm.CodAnt
	Select crSigCdPro
			Delete From crSigPrMdl Where CPros = This.Parent.Parent.pgframeDados.pgDados.getCpro.Value
			Delete From crSigPrMdl ;
		Update crSigCdPro ;
		Update crSigPrMdl ;
		Update crSigCdPrf ;
		Update crSigPrMtz ;
		Update crSigPrCpo ;
		Update crSigPrPmi ;
		Update crSigPrTar ;
		Update crSigPrArq ;
	Update crSigCdPrc ;
	Update crSigPrMdc ;
	Update crSigCdPfc ;
	Update crSigPrMt2 ;
	Update crSigPrCp2 ;
	Update crSigSubC2 ;
	Delete From crSigPrCrr ;
	Update crSigPrCrr Set Cidchaves = fUniqueIds() Where IsEmpty(Cidchaves)
	Update crSigPrTa2 ;
	Update crSigPrCa2 ;
		lStrQuery = [Select Distinct a.CPros, a.DPros, a.CGrus, a.MontaDescs, b.MtPrimas, b.CfgGerGprs, a.Situas, a.Reffs ] + ;
					  [From SigCdPro a, SigCdGrp b ] + ;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'LocalMtP') < 1
		Select LocalMtP
			Select LocalMtP
			Select crMtPrima
				Insert Into crMtPrima From Memvar
		Select crConjunto
		If !Seek(pConj,[crConjunto],[Conjunts])
			Insert Into crConjunto(Conjunts) Values (pConj)
			Delete From crMtPrima where CPros = Padr(pPro, 14)
		lcQuery = [Select Conjunts From SigCdPro Where Conjunts = '] + pConj + [']
		If ThisForm.poDataMgr.SqlExecute(lcQuery,'LocalConj') < 1
		Select LocalConj
			Delete From crConjunto Where Conjunts = pConj
	Select crSigCdPrf
	Select crSigCdPro
	Select crSigCdPro
	Select crSigCdPro
Select crSigCdPro
SELECT *, pkchaves as cidChaves from crSigPrFtp where cpros = pPro1 into cursor crPrFtp READWRITE
lStrQuery = [Select CGrus,CodProds,IdeCPros,Mercs From SigCdGrp Where CGrus = ']+lcCGrus+[' ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
Select TmpGruPro
Select crListaPro
lStrQuery = [Select CGrus, Mercs, CodProds, IdeCPros, CfgGerGprs From SigCdGrp Where CGrus = '] + this.Parent.getNewCGrus.Value + [']
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
Select TmpGruPro
	lcQuery = [Select CPros From SigCdPro Where Reffs = '] + ALLTRIM(lcNewRefs) + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [crTmp]) < 1)
	Select crTmp
	If (ThisForm.poDataMgr.SqlExecute([Select IdeCpros, iFors From SigCdPro Where Cpros = '] + ALLTRIM(lcLocPros) + ['], [crTmpIdPro]) < 1)
Select crSigPrCpo
	Select crTmp
		Select crTmp
		Insert Into crSigPrCpo From Memvar
Select crSigCdPrf
	Select crTmp
		Select crTmp
		Insert Into crSigCdPrf From Memvar
Select crSigPrMtz 
	Select crTmp
		Select crTmp
			Insert Into crSigPrMtz From Memvar
Select CrSigCdPft
	Select crTmp
		Select crTmp
		Insert Into crSigCdPft From Memvar
Select crSigPrTar
	Select crTmp
		Select crTmp
		Insert Into crSigPrTar From Memvar
Select crSigPrCar
	Select crTmp
		Select crTmp
		Insert Into crSigPrCar From Memvar
Select crSigPrArq
	Select crTmp
		Select crTmp
		Insert Into crSigPrArq From Memvar
lcQuery = [Select * ] + ;
		    [From SigCdPro ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCPros]) < 1)
Select LocalCPros
Insert Into crSigCdPro From Memvar
Insert Into crListaPro From Memvar
Select crSigCdPro
ThisForm.poDataMgr.Update('crSigCdPft')
Select crListaPro
lStrQuery = [Select CGrus,CodProds,IdeCPros From SigCdGrp Where CGrus = ']+lcCGrus+[' ]
If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
Select TmpGruPro
		Select TmpGruPro
	lStrQuery = [Select CGrus, Mercs, CodProds, IdeCPros From SigCdGrp Where CGrus = '] + lcCGrus + [']
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
	Select TmpGruPro
			Select crSigCdGpr1
		lcQuery = [Select CPros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
		Select LocalPro
			Select LocalPro
		lcQuery = [Select CPros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
		Select LocalPro
			Select LocalPro
	If Not Seek(This.Value, 'crSigCdGrpFilter', 'CGrus')
	If Not Seek(This.Value, 'crSigCdGrpFilter', 'DGrus')
Select crSigCdPro
	Select crSigCdPrf
	Select crSigCdPro
Select TmpAux
Select crSigCdPrf
		Insert Into TmpAux (Ordems, Grupo, Descr) Values (crSigCdPrf.Ordems, crTmp.Codigos, crTmp.Descrs)
Select crSigCdPro
		Select crSigCdPro
		Select crSigCdPro
			Select crSigPrCpo
			Update crSigPrCpo ;
			Select crSigSubCp
			Update crSigSubCp ;
			Update crSigCdPrf ;
			Insert Into crSigPrCrr (CPros, cIdChaves) Values (crSigCdPro.CPros, fUniqueIds())
	Select crSigCdPro
			Select crSigCdPro
				Select crSigCdPro
					Select crSigPrCpo
					Update crSigPrCpo ;
					Select crSigSubCp
					Update crSigSubCp ;
				Select crSigCdPro
			Select crSigCdPro
		Select crSigCdPro
			Select crSigCdPro
				Select crSigCdPro
					Select crSigPrCpo
					Update crSigPrCpo ;
					Select crSigSubCp
					Update crSigSubCp ;
				Select crSigCdPro
			Select crSigCdPro
		Select crSigCdPro
		lcQuery = [Select CPros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalPro]) < 1)
		Select LocalPro
			Select LocalPro
			Select crSigCdPrf
			lcSql = [Select a.*, b.descrs from SigCdLnf a, SigCdGcr b where a.linhas = ']+this.Value+[' ]+;
			If ThisForm.poDataMgr.sqlexecute(lcsql, 'crTmp') > 0
				Select crTmp
					Select crSigCdPrf
						Insert Into crSigCdPrf (Produtos, Grupos, Obs, UniPrdts, MatPrdts, cIdChaves, Descrs, Ordem2) ;
			Select crSigCdPrf
			lcSql = [Select a.*, b.descrs from SigCdLnf a, SigCdGcr b where a.linhas = ']+This.Parent.GetLin.Value+[' ]+;
			If ThisForm.poDataMgr.sqlexecute(lcsql, 'crTmp') > 0
				Select crTmp
					Select crSigCdPrf
						Insert Into crSigCdPrf (Produtos, Grupos, Obs, UniPrdts, MatPrdts, cIdChaves, Descrs, Ordem2) ;
	If Not Seek(This.Value, 'crSigCdGrpFilter', 'CGrus')
Select crSigCdPro
		lcSql = [Select cEstos From SigCdUni Where cunis = '] + crSigCdPro.CUnis+[']
		ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
						Select crSigCdPrd
				Select crSigPrCpo
				Update crSigPrCpo ;
				Select crSigSubCp
				Update crSigSubCp ;
			Select crSigCdPro
	Select crSigCdPro
	Select crSigCdPro
	If Not Seek(This.Value, 'crSigCdGrpFilter', 'DGrus')
Select crSigCdPro
						Select crSigCdPrd
				Select crSigPrCpo
				Update crSigPrCpo ;
				Select crSigSubCp
				Update crSigSubCp ;
			Select crSigCdPro
Select crSigCdPro
		Select crSigCdPro
			Delete File (lcFigura)
Select crSigCdPro
	.Column1.ControlSource  = 'crSigCdMin.Emps'
	.Column2.ControlSource  = 'crSigCdMin.QMins'
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+CrSigCdPro.cUnis+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
	Select * ;
	  From crSigCdCls ;
	Select LocalClas
	Select LocalClas
		lcQuery = [Select a.CPros ] + ;
					[From SigCdMin a ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBusca]) < 1)
Select crSigCdPro
		Select crSigCdPro
			Delete File (lcFigura)
	Select crConjunto
	If !Seek(lcConjunto,[crConjunto],[Conjunts])
Select crSigCdPro
		Select crSigCdPro
			Delete File (lcFigura)
	Select crSigCdPro
	Select crSigPrCpo
		Insert Into crSigPrCpo (Cpros, DtMovs, cIdChaves, TpCalcCus) Values (crSigCdPro.Cpros, DateTime(), fUniqueIds(), 1)
	Select crSigPrCpo
		Delete
Select crSigPrCpo
Select crSigPrCpo
		Select crSigPrCpo
			lcQuery = [Select a.cUnis, a.cUnips, b.BPesos, A.Moevs, b.chkInstalas, b.AtuComps ] + ;
						[From SigCdPro a, SigCdGrp b ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSomaGru') < 1)
				lcSql = [Select Fators From SigCdUni Where Cunis = ']+Iif(CrSomaGru.bPesos=1,CrSomaGru.Cunis,CrSomagru.CUnips)+[']
				=ThisForm.Podatamgr.Sqlexecute(lcsql,'LocalUni')
				Select crSigPrCpo
			Select crSigPrCpo
		Select CrSigPrCpo
Select CrSigCdPro
Select crSigPrCpo
Select crSigPrCpo
Select CrSigPrCpo
lnOldSel = Select()
Select(lnOldSel)
		Select &lcArq.
		Select crSigCdPro
			If Not Seek(Padr(This.Value, 14), lcArq, [CPros]) And Not Seek(This.Value, lcArq, [Reffs])
				If Not Seek(Padr(This.Value, 14), lcArq, [CPros]) And Not Seek(This.Value, lcArq, [Reffs])
							If Not Seek(Padr(This.Value, 14), lcArq, [CPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								[From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrListaRemota') < 1
						Select &lcArq.
							Select CrSigCdPrf
						Select CrSigPrCpo
				Select &lcArq.
	Select &lcArq.
	Select crSigPrCpo
		Select &lcArq.
		Select crSigCdPro
			Select &lcArq.
			If Not Seek(Padr(This.Value, 65), lcArq, [DPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								  [From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery, [crListaRemota]) < 1
						Select &lcArq.
							Select CrSigCdPrf
						Select CrSigPrCpo
				Select &lcArq.
	Select &lcArq.
	Select crSigPrCpo
	Select crSigPrCpo
	lcQuery = [Select b.pCustVens ] + ;
			    [From SigCdPro a, SigCdGrp b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select crSigPrCpo	
	lcQuery = [Select b.pCustVens,b.Fators,qtequalps, a.PesoMs, a.cGrus ] + ;
			    [From SigCdPro a, SigCdUni b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select crSigPrCpo
	Select crSigPrCpo
	Select crSigPrCpo	
	lcQuery = [Select b.pCustVens,b.Fators, a.PesoMs, a.cGrus ] + ;
			    [From SigCdPro a, SigCdUni b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select crSigPrCpo
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+CrSigPrCpo.UniCompos+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
	Select crMatrizes
	If Not Seek(Padr(This.Value, 14), [crMatrizes], [CPros])
	Select CrSigPrCpo
	lcSql = [Select Cods, Descs, Moedas, Acrescs From SigPrFti Where Tipos <> 1]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
	If Not Seek(This.Value,'TmpFtio','Cods')
	lcSql = [Select * From SigPrFti Where Cods = ']+MarkVd+[']
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	lcSql = [Select Cods, Descs, Moedas, Valors, TpFtios From SigPrFti Where Tipos = 1]
	ThisForm.Podatamgr.Sqlexecute(lcSql,'TmpFtio')
	Select TmpFtio
	If Not Seek(This.Value,'TmpFtio','Cods')
		Select &lcArq.
		Select crSigCdPro
			If Not Seek(Padr(This.Value, 14), lcArq, [CPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								[From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrListaRemota') < 1
						Select &lcArq.
						Select CrSigSubCp
				Select &lcArq.
	Select &lcArq.
	Select crSigSubCp
		Select &lcArq.
		Select crSigCdPro
			Select &lcArq.
			If Not Seek(Padr(This.Value, 40), lcArq, [DPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								  [From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery, [crListaRemota]) < 1
						Select &lcArq.
						Select CrSigSubCp
				Select &lcArq.
	Select &lcArq.
	Select crSigSubCp
	lcQuery = [Select b.pCustVens ] + ;
			    [From SigCdPro a, SigCdGrp b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select crSigSubCp	
	Select crSigSubCp
	lcQuery = [Select b.pCustVens,b.Fators,qtequalps ] + ;
			    [From SigCdPro a, SigCduni b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select CrSigSubCp
	Select crSigSubCp	
	Select crSigSubCp
	lcSql = [Select cEstos From SigCduni Where cunis = ']+crSIGPRCPO.UniCompos+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
	lcQuery = [Select b.pCustVens,b.Fators ] + ;
			    [From SigCdPro a, SigCduni b ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp') < 1)
	Select CrSigSubCp
	Select crMatrizes
	If Not Seek(Padr(This.Value, 14), [crMatrizes], [CPros])
	Select crSIGPRCPO
	Select crSigSubCp
		Insert Into crSigSubCp (Cpros, DtMovs, cIdChaves, TpCalcCus, matsubs) Values (crSigCdPro.Cpros, DateTime(), fUniqueIds(), 1, crSIGPRCPO.mats)
	Select crSigSubCp
		Delete
	Select TmpTeor
	If Not Seek(This.Value, 'TmpTeor', 'Codigos')
	Select TmpMTal
	If Not Seek(This.Value, 'TmpMTal', 'Codigos')
Select crSigCdPrf
			Delete File (lcFigura)
=Seek(CrSigCdPrf.Grupos,'CrSigCdGcr')
	Select crSigCdPrf
	Select crSigCdPrf
Select crSigCdPrf
	lcSql = [Select UniPrdts From SigCdUpd Where Codigos = ']+crSigCdPrf.Grupos+[']
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigCdUpd')
	Select CrSigCdUpd
	If Seek(This.Value,'crSigCdUpd','UniPrdts')
Select crSigCdPrf
Select crSigCdPrf
	Select CrSigCdPrf
	Select CrSigPrCpo
	Select CrSigCdPrf
Select CrSigCdPrf
Insert Into crSigCdPrf (Produtos, Ordems, Ordem2, cIdChaves) ;
Select crSigCdPrf
Delete
		Select CrSigCdPrf
		Select CrSigPrCpo
		Select CrSigCdPrf
Select crSigCdPrf
Select crSigCdPrf
Select crSigCdPrf
Insert Into crSigCdPrf (Produtos, Ordems, Ordem2, cIdChaves) ;
Insert Into csCabecalho From Memvar
Select crSigCdPrf
	Select f.produtos, f.ordems, f.grupos, f.figProcs, f.Descrs, f.Ordem2, ;
	  From crSigCdPrf f ;
	Select f.produtos, f.ordems, f.grupos, f.figProcs, f.Descrs, f.Ordem2, ;
	From crSigCdPrf f ;
Select CsDetalhes
Update CsDetalhes Set Ordem2 = Recno()
Update CsDetalhes Set Ident  = 'TP'+PADL(allt(str(Ordem2)),3,'0') 
Select CrBranco
Append Memo Branco From (lcFigJpg) Overwrite
Select CsDetalhes
lcQuery = [Select conquilhas From SigCdCnq group by conquilhas]
IF (ThisForm.poDataMgr.SqlExecute(lcQuery, [crLocal])) >0
		Select crLocal
		If Not Seek(Padr(This.Value, 10), [crLocal], [con])
Select crSigPrMtz
	Insert Into crSigPrMtz (CPros, cIdChaves) Values (crSigCdPro.CPros, fUniqueIds())
Select crSigPrMtz
	Delete In crSigPrMtz
	Insert Into crSigPrMtz (CPros, cIdChaves) Values (crSigCdPro.CPros, fUniqueIds())
	lcQuery = [Select * ] + ;
			    [From SigCdPro ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalImgPro]) < 1)
	Select crMatrizes
	If Not Seek(Padr(This.Value, 14), [crMatrizes], [CPros])
Select crSigCdPrf
			Delete File (lcFigura)
			lcQuery = [Select * ] + ;
					    [From SigCdPro ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrListaRemota') < 1)
			lcQuery = [Select * ] + ;
					    [From SigCdPro ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'CrListaRemota') < 1)
Select CrSigCdPrf
	Select crSigCdPrf
	Select crSigPrCpo
	Select crSigCdPrf
	Select crSigPrCpo
Select crSigPrCpo
		Select &lcArq.
		Select crSigCdPro
			If Not Seek(Padr(This.Value, 14), lcArq, [CPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								[From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CrListaRemota') < 1
						Select &lcArq.
						Select CrSigPrCpo
				Select &lcArq.
	Select &lcArq.
	Select crSigPrCpo
		Select &lcArq.
		Select crSigCdPro
			Select &lcArq.
			If Not Seek(Padr(This.Value, 40), lcArq, [DPros])
					Select &lcArq.
					lStrQuery = [Select * ] + ;
								  [From SigCdPro ] + ;
					If ThisForm.poDataMgr.SqlExecute(lStrQuery, [crListaRemota]) < 1
						Select &lcArq.
						Select CrSigPrCpo
				Select &lcArq.
	Select &lcArq.
	Select crSigPrCpo
	Select crSigPrCpo
	Select crSigPrCpo
	lcSql = [Select cEstos From SigCdUni Where cunis = ']+CrSigPrCpo.UniCompos+[']
	ThisForm.Podatamgr.Sqlexecute(lcsql,'TmpUni')
	Select crSigPrCpo
		Insert Into crSigPrCpo (Cpros, DtMovs, cIdChaves, Tipos) Values (crSigCdPro.Cpros, DateTime(), fUniqueIds(), lcTip)
	Select crSigPrCpo
		Delete
	Select crTarefas
Select crSigPrTar
Select crSigPrTar
Insert Into crSigPrTar (CPros, pkChaves, DtInis, Usuars) ;
	Insert Into crSigPrArq (CPros, pkChaves, Arquivos) Values (crSigCdPro.CPros, fUniqueIds(), Upper(lcArq))
	Delete In crSigPrArq

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (13437 linhas total):

*-- Linhas 507 a 525:
507:             .Width             = 940
508:             .Height            = 395
509:             .ReadOnly          = .T.
510:             .DeleteMark        = .F.
511:             .RecordMark        = .F.
512:             .ScrollBars        = 3
513:             .GridLines         = 3
514:             .ColumnCount       = 7
515:             .AllowHeaderSizing = .T.
516:             .Visible           = .T.
517:         ENDWITH
518:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdLista_DblClick")
519: 
520:         THIS.TornarControlesVisiveis(loc_oPagina)
521:     ENDPROC
522: 
523:     *--------------------------------------------------------------------------
524:     * ConfigurarPaginaDados - Configura Page2 (Dados do Produto)
525:     * Legado: Optiongroup1 top=5->34, pgframeDados top=-54->-54

*-- Linhas 2762 a 2780:
2762:             .Width       = 229
2763:             .Height      = 107
2764:             .ReadOnly    = .T.
2765:             .DeleteMark  = .F.
2766:             .RecordMark  = .F.
2767:             .ScrollBars  = 3
2768:             .GridLines   = 3
2769:             .ColumnCount = 3
2770:             .FontName    = "Verdana"
2771:             .FontSize    = 8
2772:             .Visible     = .T.
2773:         ENDWITH
2774:         WITH loc_oPg.grd_4c_GrupoCompo
2775:             .Column1.Header1.Caption = "Grupo"
2776:             .Column1.Width = 70
2777:             .Column2.Header1.Caption = "Total"
2778:             .Column2.Width = 95
2779:             .Column3.Header1.Caption = "Moe"
2780:             .Column3.Width = 50

*-- Linhas 2789 a 2807:
2789:             .Width       = 943
2790:             .Height      = 147
2791:             .ReadOnly    = .T.
2792:             .DeleteMark  = .F.
2793:             .RecordMark  = .F.
2794:             .ScrollBars  = 3
2795:             .GridLines   = 3
2796:             .ColumnCount = 14
2797:             .FontName    = "Verdana"
2798:             .FontSize    = 8
2799:             .Visible     = .T.
2800:         ENDWITH
2801:         WITH loc_oPg.grd_4c_Compo
2802:             .Column1.Header1.Caption  = "Material"
2803:             .Column1.Width  = 90
2804:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2805:             .Column2.Width  = 190
2806:             .Column3.Header1.Caption  = "Un"
2807:             .Column3.Width  = 35

*-- Linhas 2838 a 2856:
2838:             .Width       = 943
2839:             .Height      = 83
2840:             .ReadOnly    = .T.
2841:             .DeleteMark  = .F.
2842:             .RecordMark  = .F.
2843:             .ScrollBars  = 3
2844:             .GridLines   = 3
2845:             .ColumnCount = 15
2846:             .FontName    = "Verdana"
2847:             .FontSize    = 8
2848:             .Visible     = .T.
2849:         ENDWITH
2850:         WITH loc_oPg.grd_4c_SubCompo
2851:             .Column1.Header1.Caption  = "Material"
2852:             .Column1.Width  = 80
2853:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2854:             .Column2.Width  = 160
2855:             .Column3.Header1.Caption  = "Un"
2856:             .Column3.Width  = 35

*-- Linhas 4048 a 4120:
4048:         *-- Criar cursors placeholder para os grids (evitar erro de RecordSource vazio)
4049:         IF !USED("cursor_4c_Compo")
4050:             SET NULL ON
4051:             CREATE CURSOR cursor_4c_Compo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), compos C(10))
4052:             SET NULL OFF
4053:         ENDIF
4054:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
4055:         WITH loc_oPg.grd_4c_Compo
4056:             .Column1.ControlSource  = "cursor_4c_Compo.mats"
4057:             .Column2.ControlSource  = "cursor_4c_Compo.dcompos"
4058:             .Column3.ControlSource  = "cursor_4c_Compo.unicompos"
4059:             .Column4.ControlSource  = "cursor_4c_Compo.pcompos"
4060:             .Column5.ControlSource  = "cursor_4c_Compo.qtds"
4061:             .Column6.ControlSource  = "cursor_4c_Compo.totas"
4062:             .Column7.ControlSource  = "cursor_4c_Compo.moeds"
4063:             .Column8.ControlSource  = "cursor_4c_Compo.obscompos"
4064:             .Column9.ControlSource  = "cursor_4c_Compo.etiqs"
4065:             .Column10.ControlSource = "cursor_4c_Compo.qtscons"
4066:             .Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
4067:             .Column12.ControlSource = "cursor_4c_Compo.cunips"
4068:             .Column13.ControlSource = "cursor_4c_Compo.ordems"
4069:             .Column14.ControlSource = "cursor_4c_Compo.compos"
4070:         ENDWITH
4071: 
4072:         IF !USED("cursor_4c_SubCompo")
4073:             SET NULL ON
4074:             CREATE CURSOR cursor_4c_SubCompo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), matsubs C(14), codtams C(4))
4075:             SET NULL OFF
4076:         ENDIF
4077:         loc_oPg.grd_4c_SubCompo.RecordSource = "cursor_4c_SubCompo"
4078:         WITH loc_oPg.grd_4c_SubCompo
4079:             .Column1.ControlSource  = "cursor_4c_SubCompo.mats"
4080:             .Column2.ControlSource  = "cursor_4c_SubCompo.dcompos"
4081:             .Column3.ControlSource  = "cursor_4c_SubCompo.unicompos"
4082:             .Column4.ControlSource  = "cursor_4c_SubCompo.pcompos"
4083:             .Column5.ControlSource  = "cursor_4c_SubCompo.qtds"
4084:             .Column6.ControlSource  = "cursor_4c_SubCompo.totas"
4085:             .Column7.ControlSource  = "cursor_4c_SubCompo.moeds"
4086:             .Column8.ControlSource  = "cursor_4c_SubCompo.obscompos"
4087:             .Column9.ControlSource  = "cursor_4c_SubCompo.etiqs"
4088:             .Column10.ControlSource = "cursor_4c_SubCompo.qtscons"
4089:             .Column11.ControlSource = "cursor_4c_SubCompo.qtdcvs"
4090:             .Column12.ControlSource = "cursor_4c_SubCompo.cunips"
4091:             .Column13.ControlSource = "cursor_4c_SubCompo.ordems"
4092:             .Column14.ControlSource = "cursor_4c_SubCompo.matsubs"
4093:             .Column15.ControlSource = "cursor_4c_SubCompo.codtams"
4094:         ENDWITH
4095: 
4096:         IF !USED("cursor_4c_GrupoCompo")
4097:             SET NULL ON
4098:             CREATE CURSOR cursor_4c_GrupoCompo (grupos C(10), totas N(11,3), moeds C(3))
4099:             SET NULL OFF
4100:         ENDIF
4101:         loc_oPg.grd_4c_GrupoCompo.RecordSource = "cursor_4c_GrupoCompo"
4102:         WITH loc_oPg.grd_4c_GrupoCompo
4103:             .Column1.ControlSource = "cursor_4c_GrupoCompo.grupos"
4104:             .Column2.ControlSource = "cursor_4c_GrupoCompo.totas"
4105:             .Column3.ControlSource = "cursor_4c_GrupoCompo.moeds"
4106:         ENDWITH
4107:     ENDPROC
4108: 
4109:     *--------------------------------------------------------------------------
4110:     * ConfigurarTabCustos - Aba 3: Custo da composicao (pgCusto)
4111:     * Legado: pgframeDados.pgCusto (grdCompo 12-col, cmbTipos, cmdgCompo)
4112:     * FASE 9: implementacao completa com BINDEVENTs e botoes
4113:     *--------------------------------------------------------------------------
4114:     PROTECTED PROCEDURE ConfigurarTabCustos()
4115:         LOCAL loc_oPg
4116:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
4117: 
4118:         *-- Label "Tipo :" (top=159, left=112)
4119:         loc_oPg.AddObject("lbl_4c_TipoCusto", "Label")
4120:         WITH loc_oPg.lbl_4c_TipoCusto

*-- Linhas 4159 a 4177:
4159:             .Width       = 813
4160:             .Height      = 230
4161:             .ReadOnly    = .F.
4162:             .DeleteMark  = .F.
4163:             .RecordMark  = .F.
4164:             .ScrollBars  = 3
4165:             .GridLines   = 3
4166:             .ColumnCount = 12
4167:             .FontName    = "Verdana"
4168:             .FontSize    = 8
4169:             .Visible     = .T.
4170:         ENDWITH
4171:         WITH loc_oPg.grd_4c_CompoCusto
4172:             .Column1.Header1.Caption  = "Item"
4173:             .Column1.Width  = 80
4174:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4175:             .Column2.Width  = 180
4176:             .Column3.Header1.Caption  = "Un"
4177:             .Column3.Width  = 35

*-- Linhas 4334 a 4402:
4334:             .Width       = 195
4335:             .Height      = 141
4336:             .ReadOnly    = .T.
4337:             .DeleteMark  = .F.
4338:             .RecordMark  = .F.
4339:             .ScrollBars  = 3
4340:             .GridLines   = 3
4341:             .ColumnCount = 3
4342:             .FontName    = "Verdana"
4343:             .FontSize    = 8
4344:             .Visible     = .T.
4345:         ENDWITH
4346:         WITH loc_oPg.grd_4c_GrupoCompo2
4347:             .Column1.Header1.Caption = "Grp"
4348:             .Column1.Width = 55
4349:             .Column2.Header1.Caption = "Total"
4350:             .Column2.Width = 100
4351:             .Column3.Header1.Caption = "Moe"
4352:             .Column3.Width = 35
4353:         ENDWITH
4354: 
4355:         *-- Cursor placeholder para grd_4c_CompoCusto
4356:         IF !USED("cursor_4c_CompoCusto")
4357:             SET NULL ON
4358:             CREATE CURSOR cursor_4c_CompoCusto (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3))
4359:             SET NULL OFF
4360:         ENDIF
4361:         loc_oPg.grd_4c_CompoCusto.RecordSource = "cursor_4c_CompoCusto"
4362:         WITH loc_oPg.grd_4c_CompoCusto
4363:             .Column1.ControlSource  = "cursor_4c_CompoCusto.mats"
4364:             .Column2.ControlSource  = "cursor_4c_CompoCusto.dcompos"
4365:             .Column3.ControlSource  = "cursor_4c_CompoCusto.unicompos"
4366:             .Column4.ControlSource  = "cursor_4c_CompoCusto.pcompos"
4367:             .Column5.ControlSource  = "cursor_4c_CompoCusto.qtds"
4368:             .Column6.ControlSource  = "cursor_4c_CompoCusto.totas"
4369:             .Column7.ControlSource  = "cursor_4c_CompoCusto.moeds"
4370:             .Column8.ControlSource  = "cursor_4c_CompoCusto.obscompos"
4371:             .Column9.ControlSource  = "cursor_4c_CompoCusto.etiqs"
4372:             .Column10.ControlSource = "cursor_4c_CompoCusto.qtscons"
4373:             .Column11.ControlSource = "cursor_4c_CompoCusto.qtdcvs"
4374:             .Column12.ControlSource = "cursor_4c_CompoCusto.cunips"
4375:         ENDWITH
4376: 
4377:         *-- Cursor placeholder para grd_4c_GrupoCompo2
4378:         IF !USED("cursor_4c_GrupoCompo2")
4379:             SET NULL ON
4380:             CREATE CURSOR cursor_4c_GrupoCompo2 (grupos C(10), totas N(11,3), moeds C(3))
4381:             SET NULL OFF
4382:         ENDIF
4383:         loc_oPg.grd_4c_GrupoCompo2.RecordSource = "cursor_4c_GrupoCompo2"
4384:         WITH loc_oPg.grd_4c_GrupoCompo2
4385:             .Column1.ControlSource = "cursor_4c_GrupoCompo2.grupos"
4386:             .Column2.ControlSource = "cursor_4c_GrupoCompo2.totas"
4387:             .Column3.ControlSource = "cursor_4c_GrupoCompo2.moeds"
4388:         ENDWITH
4389:     ENDPROC
4390: 
4391:     *--------------------------------------------------------------------------
4392:     * ConfigurarTabDadosFiscais - Aba 4: Dados fiscais (pgDadosFiscais)
4393:     * IMPLEMENTADO NA FASE 6
4394:     *--------------------------------------------------------------------------
4395:     PROTECTED PROCEDURE ConfigurarTabDadosFiscais()
4396:         LOCAL loc_oPg
4397:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4398: 
4399:         *-- Classificacao Fiscal (top=211, left=206, width=94)
4400:         loc_oPg.AddObject("lbl_4c_Clfiscal", "Label")
4401:         WITH loc_oPg.lbl_4c_Clfiscal
4402:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"

*-- Linhas 5022 a 5071:
5022: 
5023:         IF !USED("cursor_4c_Cmv")
5024:             SET NULL ON
5025:             CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
5026:             SET NULL OFF
5027:         ENDIF
5028: 
5029:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")
5030:         WITH loc_oPg.grd_4c_Cmv
5031:             .Top         = 338
5032:             .Left        = 754
5033:             .Width       = 223
5034:             .Height      = 141
5035:             .ReadOnly    = .T.
5036:             .DeleteMark  = .F.
5037:             .RecordMark  = .F.
5038:             .ScrollBars  = 3
5039:             .GridLines   = 3
5040:             .ColumnCount = 3
5041:             .FontName    = "Verdana"
5042:             .FontSize    = 8
5043:         ENDWITH
5044:         loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
5045:         WITH loc_oPg.grd_4c_Cmv
5046:             .Column1.Header1.Caption = "Per" + CHR(237) + "odo"
5047:             .Column1.Width           = 65
5048:             .Column1.ControlSource   = "cursor_4c_Cmv.periodos"
5049:             .Column1.ReadOnly        = .T.
5050:             .Column2.Header1.Caption = "Valor Custo GR"
5051:             .Column2.Width           = 105
5052:             .Column2.ControlSource   = "cursor_4c_Cmv.valcustos"
5053:             .Column2.ReadOnly        = .T.
5054:             .Column3.Header1.Caption = "Moe"
5055:             .Column3.Width           = 40
5056:             .Column3.ControlSource   = "cursor_4c_Cmv.moedas"
5057:             .Column3.ReadOnly        = .T.
5058:         ENDWITH
5059: 
5060:         *-- === BOTAO GERAR DESCRICAO FISCAL (btnDescFis: top=359, left=162) ======
5061: 
5062:         loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
5063:         WITH loc_oPg.cmd_4c_BtnDescFis
5064:             .Caption         = ""
5065:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
5066:             .PicturePosition = 5
5067:             .Top             = 359
5068:             .Left            = 162
5069:             .Width           = 40
5070:             .Height          = 40
5071:             .FontName        = "Tahoma"

*-- Linhas 5109 a 5127:
5109:             .Width       = 495
5110:             .Height      = 238
5111:             .ReadOnly    = .T.
5112:             .DeleteMark  = .F.
5113:             .RecordMark  = .F.
5114:             .ScrollBars  = 3
5115:             .GridLines   = 3
5116:             .ColumnCount = 4
5117:             .FontName    = "Verdana"
5118:             .FontSize    = 8
5119:             .Visible     = .T.
5120:         ENDWITH
5121:         WITH loc_oPg.grd_4c_Designer
5122:             .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
5123:             .Column1.Width = 110
5124:             .Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
5125:             .Column2.Width = 120
5126:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
5127:             .Column3.Width = 100

*-- Linhas 5193 a 5211:
5193:             .Width       = 495
5194:             .Height      = 202
5195:             .ReadOnly    = .T.
5196:             .DeleteMark  = .F.
5197:             .RecordMark  = .F.
5198:             .ScrollBars  = 3
5199:             .GridLines   = 3
5200:             .ColumnCount = 1
5201:             .FontName    = "Verdana"
5202:             .FontSize    = 8
5203:             .Visible     = .T.
5204:         ENDWITH
5205:         WITH loc_oPg.grd_4c_Arquivos
5206:             .Column1.Header1.Caption = "Arquivos Para Designer"
5207:             .Column1.Width = 492
5208:         ENDWITH
5209: 
5210:         *-- Botoes de arquivo (top=416, 458, 500, left=509)
5211:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")

*-- Linhas 5253 a 5289:
5253:         *-- Criar cursors placeholder
5254:         IF !USED("cursor_4c_Designer")
5255:             SET NULL ON
5256:             CREATE CURSOR cursor_4c_Designer (dtinis D, dtfims D, usuars C(10), tarefas C(20))
5257:             SET NULL OFF
5258:         ENDIF
5259:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_Designer"
5260:         WITH loc_oPg.grd_4c_Designer
5261:             .Column1.ControlSource = "cursor_4c_Designer.dtinis"
5262:             .Column2.ControlSource = "cursor_4c_Designer.dtfims"
5263:             .Column3.ControlSource = "cursor_4c_Designer.usuars"
5264:             .Column4.ControlSource = "cursor_4c_Designer.tarefas"
5265:         ENDWITH
5266: 
5267:         IF !USED("cursor_4c_Arquivos")
5268:             SET NULL ON
5269:             CREATE CURSOR cursor_4c_Arquivos (arquivos C(250))
5270:             SET NULL OFF
5271:         ENDIF
5272:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_Arquivos"
5273:         WITH loc_oPg.grd_4c_Arquivos
5274:             .Column1.ControlSource = "cursor_4c_Arquivos.arquivos"
5275:         ENDWITH
5276:     ENDPROC
5277: 
5278:     *--------------------------------------------------------------------------
5279:     * ConfigurarPgpgDesigner - Completa Aba 5 Designer
5280:     * Adiciona img_4c_ImgArqJpg, shp_4c_Shape1 e todos os BINDEVENTs
5281:     * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDesigner()
5282:     *--------------------------------------------------------------------------
5283:     PROTECTED PROCEDURE ConfigurarPgpgDesigner()
5284:         LOCAL loc_oPg
5285:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
5286: 
5287:         *-- Corrigir ReadOnly do grd_4c_Designer: .F. para Column4 ser editavel
5288:         *-- Colunas 1-3 usam When=.F. via BINDEVENT para somente leitura
5289:         loc_oPg.grd_4c_Designer.ReadOnly = .F.

*-- Linhas 5332 a 5430:
5332: 
5333:         *-- Cursor de tarefas para lookup do Column4 (codigo + descricao)
5334:         IF !USED("cursor_4c_Tarefas")
5335:             CREATE CURSOR cursor_4c_Tarefas (CodCads C(20), DesCads C(50))
5336:         ENDIF
5337:     ENDPROC
5338: 
5339:     *--------------------------------------------------------------------------
5340:     * ConfigurarTabConsulta - Aba 6: Consulta de componentes por fase (PgDadosConsP)
5341:     * Legado: PgDadosConsP com GrdCons (9 cols editaveis) e grDTEMP (2 cols)
5342:     * IMPLEMENTADO NA FASE 9
5343:     *--------------------------------------------------------------------------
5344:     PROTECTED PROCEDURE ConfigurarTabConsulta()
5345:         LOCAL loc_oPg
5346:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
5347: 
5348:         *-- Criar cursors placeholder ANTES dos grids (evitar erro de RecordSource vazio)
5349:         *-- cursor_4c_Consulta: SIGPRCPO - componentes com fase (SigCdPrf) e categoria (SigCdCat)
5350:         IF !USED("cursor_4c_Consulta")
5351:             SET NULL ON
5352:             CREATE CURSOR cursor_4c_Consulta (mats C(14) NULL, qtds N(8,3) NULL, unicompos C(3) NULL, grupos C(10) NULL, dcompos C(40) NULL, ordems N(2,0) NULL, qtscons N(8,3) NULL, cats C(6) NULL, dscgrp C(20) NULL)
5353:             SET NULL OFF
5354:         ENDIF
5355: 
5356:         *-- cursor_4c_Temp: agrupamento x tempo (grDTEMP)
5357:         IF !USED("cursor_4c_Temp")
5358:             SET NULL ON
5359:             CREATE CURSOR cursor_4c_Temp (grupos C(10) NULL, totas N(11,3) NULL)
5360:             SET NULL OFF
5361:         ENDIF
5362: 
5363:         *-- GrdCons - Grid de componentes consulta (top=155, left=6, width=987, height=362, 9 cols)
5364:         *-- Colunas editaveis (INSERIR/ALTERAR): 4-Fase, 5-Descricao, 7-Consumo, 8-Cat
5365:         *-- Colunas somente leitura: 1-Componente, 2-Qtde, 3-Uni, 6-Ord, 9-DescCat
5366:         loc_oPg.AddObject("grd_4c_Consulta", "Grid")
5367:         WITH loc_oPg.grd_4c_Consulta
5368:             .Top         = 155
5369:             .Left        = 6
5370:             .Width       = 987
5371:             .Height      = 362
5372:             .ReadOnly    = .F.
5373:             .DeleteMark  = .F.
5374:             .RecordMark  = .F.
5375:             .ScrollBars  = 3
5376:             .GridLines   = 3
5377:             .ColumnCount = 9
5378:             .FontName    = "Verdana"
5379:             .FontSize    = 8
5380:             .Visible     = .T.
5381:         ENDWITH
5382:         *-- RecordSource ANTES dos headers/ControlSources (evita reset de colunas)
5383:         loc_oPg.grd_4c_Consulta.RecordSource = "cursor_4c_Consulta"
5384:         WITH loc_oPg.grd_4c_Consulta
5385:             .Column1.Header1.Caption = "Componente"
5386:             .Column1.Width           = 110
5387:             .Column1.ControlSource   = "cursor_4c_Consulta.mats"
5388:             .Column1.ReadOnly        = .T.
5389:             .Column2.Header1.Caption = "Qtde."
5390:             .Column2.Width           = 65
5391:             .Column2.ControlSource   = "cursor_4c_Consulta.qtds"
5392:             .Column2.ReadOnly        = .T.
5393:             .Column3.Header1.Caption = "Uni"
5394:             .Column3.Width           = 40
5395:             .Column3.ControlSource   = "cursor_4c_Consulta.unicompos"
5396:             .Column3.ReadOnly        = .T.
5397:             .Column4.Header1.Caption = "Fase"
5398:             .Column4.Width           = 80
5399:             .Column4.ControlSource   = "cursor_4c_Consulta.grupos"
5400:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5401:             .Column5.Width           = 180
5402:             .Column5.ControlSource   = "cursor_4c_Consulta.dcompos"
5403:             .Column6.Header1.Caption = "Ord."
5404:             .Column6.Width           = 40
5405:             .Column6.ControlSource   = "cursor_4c_Consulta.ordems"
5406:             .Column6.ReadOnly        = .T.
5407:             .Column7.Header1.Caption = "Consumo"
5408:             .Column7.Width           = 75
5409:             .Column7.ControlSource   = "cursor_4c_Consulta.qtscons"
5410:             .Column8.Header1.Caption = "Cat."
5411:             .Column8.Width           = 55
5412:             .Column8.ControlSource   = "cursor_4c_Consulta.cats"
5413:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5414:             .Column9.Width           = 150
5415:             .Column9.ControlSource   = "cursor_4c_Consulta.dscgrp"
5416:             .Column9.ReadOnly        = .T.
5417:         ENDWITH
5418:         BINDEVENT(loc_oPg.grd_4c_Consulta, "AfterRowColChange", THIS, "ConsultaGrd_AfterRowColChange")
5419: 
5420:         *-- Say7/lbl_4c_QtdCpnt: "Qtde Componentes :" (top=523, left=25)
5421:         loc_oPg.AddObject("lbl_4c_QtdCpnt", "Label")
5422:         WITH loc_oPg.lbl_4c_QtdCpnt
5423:             .Caption   = "Qtde Componentes : "
5424:             .Top       = 523
5425:             .Left      = 25
5426:             .Width     = 115
5427:             .Height    = 15
5428:             .FontName  = "Tahoma"
5429:             .FontSize  = 8
5430:             .BackStyle = 0

*-- Linhas 5482 a 5540:
5482:             .Width       = 172
5483:             .Height      = 107
5484:             .ReadOnly    = .T.
5485:             .DeleteMark  = .F.
5486:             .RecordMark  = .F.
5487:             .ScrollBars  = 3
5488:             .GridLines   = 3
5489:             .ColumnCount = 2
5490:             .FontName    = "Verdana"
5491:             .FontSize    = 8
5492:             .Visible     = .T.
5493:         ENDWITH
5494:         *-- RecordSource ANTES dos headers/ControlSources
5495:         loc_oPg.grd_4c_Temp.RecordSource = "cursor_4c_Temp"
5496:         WITH loc_oPg.grd_4c_Temp
5497:             .Column1.Header1.Caption = "Agrupamento"
5498:             .Column1.Width           = 100
5499:             .Column1.ControlSource   = "cursor_4c_Temp.grupos"
5500:             .Column2.Header1.Caption = "Tempo %"
5501:             .Column2.Width           = 65
5502:             .Column2.ControlSource   = "cursor_4c_Temp.totas"
5503:         ENDWITH
5504:     ENDPROC
5505: 
5506:     *--------------------------------------------------------------------------
5507:     * ConfigurarTabFases - Aba 7: Fases de producao (PgDadosFaseP)
5508:     * IMPLEMENTADO NA FASE 7
5509:     *--------------------------------------------------------------------------
5510:     PROTECTED PROCEDURE ConfigurarTabFases()
5511:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oCtrl, loc_oLbl, loc_oChk
5512:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5513: 
5514:         *-- Cursor placeholder para GradFase (SigCdPrf)
5515:         *-- ordems N(2,0), grupos C(10), minutos N(9,1), uniprdts C(10), matprdts C(15)
5516:         IF !USED("cursor_4c_Fases")
5517:             SET NULL ON
5518:             CREATE CURSOR cursor_4c_Fases (ordems N(2,0) NULL, grupos C(10) NULL, minutos N(9,1) NULL, uniprdts C(10) NULL, matprdts C(15) NULL)
5519:             SET NULL OFF
5520:         ENDIF
5521: 
5522:         *-- Cursor placeholder para grdMatrizes (SigPrMtz + Locals de SigCdPro)
5523:         IF !USED("cursor_4c_Matrizes")
5524:             SET NULL ON
5525:             CREATE CURSOR cursor_4c_Matrizes (cidchaves C(20) NULL, cmats C(14) NULL, cpros C(14) NULL, qtds N(3,0) NULL, locals C(10) NULL)
5526:             SET NULL OFF
5527:         ENDIF
5528: 
5529:         *======================================================
5530:         *-- LABEL: Say13 - "Qtd. Min. Producao :"
5531:         *======================================================
5532:         loc_oPg.AddObject("lbl_4c_Qmin", "Label")
5533:         WITH loc_oPg.lbl_4c_Qmin
5534:             .Top      = 156
5535:             .Left     = 33
5536:             .Width    = 102
5537:             .Height   = 15
5538:             .Caption  = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5539:             .AutoSize = .F.
5540:             .FontName = "Tahoma"

*-- Linhas 5845 a 5922:
5845:             .Width          = 420
5846:             .Height         = 312
5847:             .ReadOnly       = .F.
5848:             .DeleteMark     = .F.
5849:             .RecordMark     = .F.
5850:             .GridLines      = 3
5851:             .FontName       = "Tahoma"
5852:             .FontSize       = 8
5853:             .Themes         = .F.
5854:             .Visible        = .T.
5855:         ENDWITH
5856:         loc_oPg.grd_4c_Fases.ColumnCount = 5
5857:         loc_oPg.grd_4c_Fases.RecordSource = "cursor_4c_Fases"
5858:         WITH loc_oPg.grd_4c_Fases
5859:             .Column1.Header1.Caption  = "Ordem"
5860:             .Column1.Width            = 40
5861:             .Column1.ControlSource    = "cursor_4c_Fases.ordems"
5862:             .Column2.Header1.Caption  = "Fase"
5863:             .Column2.Width            = 80
5864:             .Column2.ControlSource    = "cursor_4c_Fases.grupos"
5865:             .Column3.Header1.Caption  = "Utiliza" + CHR(231) + CHR(227) + "o"
5866:             .Column3.Width            = 70
5867:             .Column3.ControlSource    = "cursor_4c_Fases.minutos"
5868:             .Column4.Header1.Caption  = "Uni. Produtiva"
5869:             .Column4.Width            = 90
5870:             .Column4.ControlSource    = "cursor_4c_Fases.uniprdts"
5871:             .Column5.Header1.Caption  = "Material"
5872:             .Column5.Width            = 120
5873:             .Column5.ControlSource    = "cursor_4c_Fases.matprdts"
5874:         ENDWITH
5875: 
5876:         *======================================================
5877:         *-- GRID: grd_4c_Matrizes - 3 colunas - SigPrMtz
5878:         *-- top=380, left=7, width=246, height=240
5879:         *-- Matriz | Local | Qtde
5880:         *======================================================
5881:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
5882:         WITH loc_oPg.grd_4c_Matrizes
5883:             .Top            = 380
5884:             .Left           = 7
5885:             .Width          = 246
5886:             .Height         = 240
5887:             .ReadOnly       = .F.
5888:             .DeleteMark     = .F.
5889:             .RecordMark     = .F.
5890:             .GridLines      = 3
5891:             .FontName       = "Tahoma"
5892:             .FontSize       = 8
5893:             .Themes         = .F.
5894:             .Visible        = .T.
5895:         ENDWITH
5896:         loc_oPg.grd_4c_Matrizes.ColumnCount = 3
5897:         loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_Matrizes"
5898:         WITH loc_oPg.grd_4c_Matrizes
5899:             .Column1.Header1.Caption  = "Matriz"
5900:             .Column1.Width            = 100
5901:             .Column1.ControlSource    = "cursor_4c_Matrizes.cmats"
5902:             .Column2.Header1.Caption  = "Local"
5903:             .Column2.Width            = 80
5904:             .Column2.ControlSource    = "cursor_4c_Matrizes.locals"
5905:             .Column3.Header1.Caption  = "Qtde"
5906:             .Column3.Width            = 60
5907:             .Column3.ControlSource    = "cursor_4c_Matrizes.qtds"
5908:         ENDWITH
5909: 
5910:         *======================================================
5911:         *-- LABEL + TEXTBOX: Get_Desc - Descricao da fase selecionada
5912:         *======================================================
5913:         loc_oPg.AddObject("lbl_4c_DescFase", "Label")
5914:         WITH loc_oPg.lbl_4c_DescFase
5915:             .Top      = 474
5916:             .Left     = 527
5917:             .Width    = 67
5918:             .Height   = 17
5919:             .Caption  = "Descri" + CHR(231) + CHR(227) + "o :"
5920:             .AutoSize = .F.
5921:             .FontName = "Tahoma"
5922:             .FontSize = 8

*-- Linhas 6274 a 6292:
6274:             ENDIF
6275: 
6276:             IF !EMPTY(loc_cCgru)
6277:                 loc_cFiltro = "p.cgrus = " + EscaparSQL(loc_cCgru)
6278:             ENDIF
6279: 
6280:             *-- Filtro situacao
6281:             loc_nSit = 1
6282:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
6283:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas, "Value", 5)
6284:                     loc_nSit = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas.Value
6285:                 ENDIF
6286:             ENDIF
6287: 
6288:             IF loc_nSit = 2   && Apenas ativos (situas=1)
6289:                 IF !EMPTY(loc_cFiltro)
6290:                     loc_cFiltro = loc_cFiltro + " AND p.situas = 1"
6291:                 ELSE
6292:                     loc_cFiltro = "p.situas = 1"

*-- Linhas 6314 a 6363:
6314: 
6315:             IF !EMPTY(loc_dIni)
6316:                 LOCAL loc_cDataIni
6317:                 loc_cDataIni = FormatarDataSQL(loc_dIni)
6318:                 IF !EMPTY(loc_cFiltro)
6319:                     loc_cFiltro = loc_cFiltro + " AND p.dtalts >= " + loc_cDataIni
6320:                 ELSE
6321:                     loc_cFiltro = "p.dtalts >= " + loc_cDataIni
6322:                 ENDIF
6323:             ENDIF
6324:             IF !EMPTY(loc_dFim)
6325:                 LOCAL loc_cDataFim
6326:                 loc_cDataFim = FormatarDataSQL(loc_dFim)
6327:                 IF !EMPTY(loc_cFiltro)
6328:                     loc_cFiltro = loc_cFiltro + " AND p.dtalts <= " + loc_cDataFim
6329:                 ELSE
6330:                     loc_cFiltro = "p.dtalts <= " + loc_cDataFim
6331:                 ENDIF
6332:             ENDIF
6333: 
6334:             *-- Buscar dados no BO
6335:             IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
6336:                 loc_lResultado = .F.
6337:             ELSE
6338:                 *-- Definir RecordSource (ISSO RESETA AS COLUNAS)
6339:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
6340: 
6341:                 *-- Reconfigurar ControlSource APOS RecordSource
6342:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
6343:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
6344:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
6345:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
6346:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
6347:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.usuaalts"
6348:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.situas"
6349: 
6350:                 *-- Larguras
6351:                 loc_oGrid.Column1.Width = 110
6352:                 loc_oGrid.Column2.Width = 330
6353:                 loc_oGrid.Column3.Width = 55
6354:                 loc_oGrid.Column4.Width = 60
6355:                 loc_oGrid.Column5.Width = 160
6356:                 loc_oGrid.Column6.Width = 120
6357:                 loc_oGrid.Column7.Width = 40
6358: 
6359:                 *-- Cabecalhos (legado: Produto, Descricao, Grupo, Subgrp., Ref. Fornecedor, Usuario, I)
6360:                 loc_oGrid.Column1.Header1.Caption = "Produto"
6361:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
6362:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
6363:                 loc_oGrid.Column4.Header1.Caption = "Subgrp."

*-- Linhas 7969 a 7987:
7969:             RETURN
7970:         ENDIF
7971: 
7972:         SELECT cursor_4c_Dados
7973:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
7974: 
7975:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
7976:             THIS.BOParaForm()
7977:             THIS.this_cModoAtual = "VISUALIZAR"
7978:             THIS.HabilitarCampos(.F.)
7979:             THIS.AjustarBotoesPorModo()
7980:             THIS.AlternarPagina(2)
7981:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
7982:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
7983:         ENDIF
7984:     ENDPROC
7985: 
7986:     *--------------------------------------------------------------------------
7987:     * BtnAlterarClick - Alterar produto selecionado

*-- Linhas 7998 a 8016:
7998:             RETURN
7999:         ENDIF
8000: 
8001:         SELECT cursor_4c_Dados
8002:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8003: 
8004:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8005:             THIS.this_oBusinessObject.EditarRegistro()
8006:             THIS.BOParaForm()
8007:             THIS.this_cModoAtual = "ALTERAR"
8008:             THIS.HabilitarCampos(.T.)
8009:             THIS.AjustarBotoesPorModo()
8010:             THIS.AlternarPagina(2)
8011:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8012:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8013:         ENDIF
8014:     ENDPROC
8015: 
8016:     *--------------------------------------------------------------------------

*-- Linhas 8029 a 8059:
8029:             RETURN
8030:         ENDIF
8031: 
8032:         SELECT cursor_4c_Dados
8033:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8034: 
8035:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8036: 
8037:             *-- Verificar uso em itens de pedido (SigMvCIte)
8038:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8039:                 SELECT COUNT(*) AS nExiste
8040:                 FROM SigMvCIte
8041:                 WHERE cpros = <<EscaparSQL(loc_cCodigo)>>
8042:             ENDTEXT
8043: 
8044:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerPro")
8045: 
8046:             IF loc_nResultado < 0
8047:                 MsgErro("Falha ao verificar uso do produto!")
8048:                 IF USED("cursor_4c_VerPro")
8049:                     USE IN cursor_4c_VerPro
8050:                 ENDIF
8051:                 RETURN
8052:             ENDIF
8053: 
8054:             IF NVL(cursor_4c_VerPro.nExiste, 0) > 0
8055:                 MsgAviso("Produto em uso em pedidos - n" + CHR(227) + "o pode ser exclu" + CHR(237) + "do!")
8056:                 IF USED("cursor_4c_VerPro")
8057:                     USE IN cursor_4c_VerPro
8058:                 ENDIF
8059:                 RETURN

*-- Linhas 8099 a 8120:
8099:                 loc_cCodNovo = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
8100: 
8101:                 TEXT TO loc_cSQLDup TEXTMERGE NOSHOW
8102:                     SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = <<EscaparSQL(loc_cCodNovo)>>
8103:                 ENDTEXT
8104: 
8105:                 loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupPro")
8106: 
8107:                 IF loc_nDup >= 0 AND NVL(cursor_4c_DupPro.nExiste, 0) > 0
8108:                     IF USED("cursor_4c_DupPro")
8109:                         USE IN cursor_4c_DupPro
8110:                     ENDIF
8111:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
8112:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8113:                         loc_oPg.txt_4c_Cpros.SetFocus()
8114:                     ENDIF
8115:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8116:                     THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8117:                     RETURN
8118:                 ENDIF
8119: 
8120:                 IF USED("cursor_4c_DupPro")

*-- Linhas 8227 a 8248:
8227: 
8228:         TRY
8229:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8230:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCgru)>>
8231:             ENDTEXT
8232: 
8233:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerGru")
8234: 
8235:             IF loc_nRes > 0 AND !EOF("cursor_4c_VerGru")
8236:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_VerGru.dgrus)
8237:             ELSE
8238:                 *-- Codigo nao encontrado: abrir lookup
8239:                 THIS.AbrirLookupFiltroGrupo()
8240:             ENDIF
8241: 
8242:             IF USED("cursor_4c_VerGru")
8243:                 USE IN cursor_4c_VerGru
8244:             ENDIF
8245:         CATCH TO loc_oErro
8246:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarFiltroGrupo")
8247:         ENDTRY
8248:     ENDPROC

*-- Linhas 8392 a 8412:
8392: 
8393:         TRY
8394:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8395:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCod)>>
8396:             ENDTEXT
8397:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGrp")
8398:             IF loc_nR > 0 AND !EOF("cursor_4c_VGrp")
8399:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8400:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_VGrp.dgrus)
8401:                 ENDIF
8402:             ELSE
8403:                 THIS.AbrirLookupGrupo()
8404:             ENDIF
8405:             IF USED("cursor_4c_VGrp")
8406:                 USE IN cursor_4c_VGrp
8407:             ENDIF
8408:         CATCH TO loc_oErro
8409:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CgruLostFocus")
8410:         ENDTRY
8411:     ENDPROC
8412: 

*-- Linhas 8481 a 8501:
8481: 
8482:         TRY
8483:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8484:                 SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = <<EscaparSQL(loc_cCod)>>
8485:             ENDTEXT
8486:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VLin")
8487:             IF loc_nR > 0 AND !EOF("cursor_4c_VLin")
8488:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8489:                     loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_VLin.Descs)
8490:                 ENDIF
8491:             ELSE
8492:                 THIS.AbrirLookupLinha()
8493:             ENDIF
8494:             IF USED("cursor_4c_VLin")
8495:                 USE IN cursor_4c_VLin
8496:             ENDIF
8497:         CATCH TO loc_oErro
8498:             MsgErro("Erro ao validar linha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_LinhasLostFocus")
8499:         ENDTRY
8500:     ENDPROC
8501: 

*-- Linhas 8570 a 8590:
8570: 
8571:         TRY
8572:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8573:                 SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = <<EscaparSQL(loc_cCod)>>
8574:             ENDTEXT
8575:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCol")
8576:             IF loc_nR > 0 AND !EOF("cursor_4c_VCol")
8577:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8578:                     loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_VCol.Descs)
8579:                 ENDIF
8580:             ELSE
8581:                 THIS.AbrirLookupColecao()
8582:             ENDIF
8583:             IF USED("cursor_4c_VCol")
8584:                 USE IN cursor_4c_VCol
8585:             ENDIF
8586:         CATCH TO loc_oErro
8587:             MsgErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_ColecoesLostFocus")
8588:         ENDTRY
8589:     ENDPROC
8590: 

*-- Linhas 8659 a 8679:
8659: 
8660:         TRY
8661:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8662:                 SELECT TOP 1 IClis, Rclis FROM SigCdCli WHERE IClis = <<EscaparSQL(loc_cCod)>>
8663:             ENDTEXT
8664:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VFor")
8665:             IF loc_nR > 0 AND !EOF("cursor_4c_VFor")
8666:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8667:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_VFor.Rclis)
8668:                 ENDIF
8669:             ELSE
8670:                 THIS.AbrirLookupFornecedor()
8671:             ENDIF
8672:             IF USED("cursor_4c_VFor")
8673:                 USE IN cursor_4c_VFor
8674:             ENDIF
8675:         CATCH TO loc_oErro
8676:             MsgErro("Erro ao validar fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_IforsLostFocus")
8677:         ENDTRY
8678:     ENDPROC
8679: 

*-- Linhas 8850 a 8870:
8850: 
8851:         TRY
8852:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8853:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8854:             ENDTEXT
8855:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUni")
8856:             IF loc_nR > 0 AND !EOF("cursor_4c_VUni")
8857:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
8858:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_VUni.dunis)
8859:                 ENDIF
8860:             ELSE
8861:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
8862:             ENDIF
8863:             IF USED("cursor_4c_VUni")
8864:                 USE IN cursor_4c_VUni
8865:             ENDIF
8866:         CATCH TO loc_oErro
8867:             MsgErro("Erro ao validar unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunisLostFocus")
8868:         ENDTRY
8869:     ENDPROC
8870: 

*-- Linhas 8898 a 8918:
8898: 
8899:         TRY
8900:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8901:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8902:             ENDTEXT
8903:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUn2")
8904:             IF loc_nR > 0 AND !EOF("cursor_4c_VUn2")
8905:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
8906:                     loc_oPg.txt_4c_Dunips.Value = ALLTRIM(cursor_4c_VUn2.dunis)
8907:                 ENDIF
8908:             ELSE
8909:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
8910:             ENDIF
8911:             IF USED("cursor_4c_VUn2")
8912:                 USE IN cursor_4c_VUn2
8913:             ENDIF
8914:         CATCH TO loc_oErro
8915:             MsgErro("Erro ao validar unidade 2:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunipsLostFocus")
8916:         ENDTRY
8917:     ENDPROC
8918: 

*-- Linhas 8990 a 9010:
8990: 
8991:         TRY
8992:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8993:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
8994:             ENDTEXT
8995:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcb")
8996:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcb")
8997:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
8998:                     loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_VAcb.descrs)
8999:                 ENDIF
9000:             ELSE
9001:                 THIS.AbrirLookupAcabamento()
9002:             ENDIF
9003:             IF USED("cursor_4c_VAcb")
9004:                 USE IN cursor_4c_VAcb
9005:             ENDIF
9006:         CATCH TO loc_oErro
9007:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodacbsLostFocus")
9008:         ENDTRY
9009:     ENDPROC
9010: 

*-- Linhas 9076 a 9096:
9076: 
9077:         TRY
9078:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9079:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
9080:             ENDTEXT
9081:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCor")
9082:             IF loc_nR <= 0
9083:                 THIS.AbrirLookupCor()
9084:             ELSE
9085:                 IF EOF("cursor_4c_VCor")
9086:                     THIS.AbrirLookupCor()
9087:                 ENDIF
9088:             ENDIF
9089:             IF USED("cursor_4c_VCor")
9090:                 USE IN cursor_4c_VCor
9091:             ENDIF
9092:         CATCH TO loc_oErro
9093:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodcorsLostFocus")
9094:         ENDTRY
9095:     ENDPROC
9096: 

*-- Linhas 9185 a 9351:
9185:         IF !EMPTY(par_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
9186:             TRY
9187:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9188:                     SELECT TOP 1 <<par_cCampoDesc>> FROM <<par_cTabela>> WHERE <<par_cCampoChave>> = <<EscaparSQL(par_cValor)>>
9189:                 ENDTEXT
9190:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescH")
9191:                 IF loc_nR > 0 AND !EOF("cursor_4c_DescH")
9192:                     loc_cAliasField = "cursor_4c_DescH." + par_cCampoDesc
9193:                     loc_cDesc = ALLTRIM(&loc_cAliasField)
9194:                 ENDIF
9195:                 IF USED("cursor_4c_DescH")
9196:                     USE IN cursor_4c_DescH
9197:                 ENDIF
9198:             CATCH TO loc_oErro
9199:                 MsgErro("Erro ao carregar descricao:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDesc")
9200:             ENDTRY
9201:         ENDIF
9202: 
9203:         RETURN loc_cDesc
9204:     ENDFUNC
9205: 
9206:     *--------------------------------------------------------------------------
9207:     * CarregarComposicao - Carrega grid de composicao (Tab 2)
9208:     * Tabela: SIGPRCPO JOIN SigCdPro
9209:     *--------------------------------------------------------------------------
9210:     PROTECTED PROCEDURE CarregarComposicao()
9211:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9212:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9213:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9214: 
9215:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9216:             RETURN
9217:         ENDIF
9218: 
9219:         TRY
9220:             *-- Composicao principal
9221:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9222:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9223:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9224:                        c.qtdcvs, c.cunips, c.ordems, c.compos
9225:                 FROM SIGPRCPO c
9226:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9227:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9228:                 ORDER BY c.ordems
9229:             ENDTEXT
9230:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTmp")
9231:             IF loc_nR > 0
9232:                 IF USED("cursor_4c_Compo")
9233:                     SELECT cursor_4c_Compo
9234:                     ZAP
9235:                     APPEND FROM DBF("cursor_4c_CompoTmp")
9236:                 ENDIF
9237:                 IF USED("cursor_4c_CompoTmp")
9238:                     USE IN cursor_4c_CompoTmp
9239:                 ENDIF
9240:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
9241:                     loc_oPg.grd_4c_Compo.Refresh()
9242:                 ENDIF
9243:             ENDIF
9244: 
9245:             *-- Sub-composicao
9246:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9247:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9248:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9249:                        c.qtdcvs, c.cunips, c.ordems, c.matsubs, c.codtams
9250:                 FROM sigsubcp c
9251:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9252:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9253:                 ORDER BY c.ordems
9254:             ENDTEXT
9255:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubCompoTmp")
9256:             IF loc_nR > 0
9257:                 IF USED("cursor_4c_SubCompo")
9258:                     SELECT cursor_4c_SubCompo
9259:                     ZAP
9260:                     APPEND FROM DBF("cursor_4c_SubCompoTmp")
9261:                 ENDIF
9262:                 IF USED("cursor_4c_SubCompoTmp")
9263:                     USE IN cursor_4c_SubCompoTmp
9264:                 ENDIF
9265:                 IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
9266:                     loc_oPg.grd_4c_SubCompo.Refresh()
9267:                 ENDIF
9268:             ENDIF
9269: 
9270:         CATCH TO loc_oErro
9271:             MsgErro("Erro ao carregar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarComposicao")
9272:         ENDTRY
9273:     ENDPROC
9274: 
9275:     *--------------------------------------------------------------------------
9276:     * CarregarConsultaP - Carrega grids da aba Consulta P. (Tab 6 - PgDadosConsP)
9277:     * GrdCons: SIGPRCPO JOIN SigCdPrf(fase) JOIN SigCdCat(categoria)
9278:     * grDTEMP:  SIGPRCPO agrupado por fase (consumo total)
9279:     *--------------------------------------------------------------------------
9280:     PROTECTED PROCEDURE CarregarConsultaP()
9281:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nCount, loc_oPg
9282:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9283:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9284: 
9285:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9286:             RETURN
9287:         ENDIF
9288: 
9289:         TRY
9290:             *-- Carregar componentes com descricao de fase e categoria
9291:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9292:                 SELECT c.mats, c.qtds, c.unicompos, c.grupos,
9293:                        ISNULL((SELECT TOP 1 pf.descrs FROM SigCdPrf pf WHERE RTRIM(pf.grupos) = RTRIM(c.grupos)), '') AS dcompos,
9294:                        c.ordems, c.qtscons, c.cats,
9295:                        ISNULL(cat.descs, '') AS dscgrp
9296:                 FROM SIGPRCPO c
9297:                 LEFT JOIN SigCdCat cat ON RTRIM(c.cats) = RTRIM(cat.cods)
9298:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9299:                 ORDER BY c.ordems, c.mats
9300:             ENDTEXT
9301:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaTmp")
9302:             IF loc_nR > 0
9303:                 IF USED("cursor_4c_Consulta")
9304:                     SELECT cursor_4c_Consulta
9305:                     ZAP
9306:                     APPEND FROM DBF("cursor_4c_ConsultaTmp")
9307:                 ENDIF
9308:                 IF USED("cursor_4c_ConsultaTmp")
9309:                     USE IN cursor_4c_ConsultaTmp
9310:                 ENDIF
9311:                 *-- Atualizar contagem de componentes
9312:                 loc_nCount = RECCOUNT("cursor_4c_Consulta")
9313:                 IF PEMSTATUS(loc_oPg, "txt_4c_QtdCpnt", 5)
9314:                     loc_oPg.txt_4c_QtdCpnt.Value = loc_nCount
9315:                 ENDIF
9316:                 IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
9317:                     loc_oPg.grd_4c_Consulta.Refresh()
9318:                 ENDIF
9319:             ENDIF
9320: 
9321:             *-- Carregar dados grDTEMP: consumo total agrupado por fase
9322:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9323:                 SELECT c.grupos, SUM(c.qtscons) AS totas
9324:                 FROM SIGPRCPO c
9325:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9326:                   AND c.grupos IS NOT NULL
9327:                   AND RTRIM(c.grupos) <> ''
9328:                 GROUP BY c.grupos
9329:                 ORDER BY c.grupos
9330:             ENDTEXT
9331:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempTmp")
9332:             IF loc_nR > 0
9333:                 IF USED("cursor_4c_Temp")
9334:                     SELECT cursor_4c_Temp
9335:                     ZAP
9336:                     APPEND FROM DBF("cursor_4c_TempTmp")
9337:                 ENDIF
9338:                 IF USED("cursor_4c_TempTmp")
9339:                     USE IN cursor_4c_TempTmp
9340:                 ENDIF
9341:                 IF PEMSTATUS(loc_oPg, "grd_4c_Temp", 5)
9342:                     loc_oPg.grd_4c_Temp.Refresh()
9343:                 ENDIF
9344:             ENDIF
9345: 
9346:         CATCH TO loc_oErro
9347:             MsgErro("Erro ao carregar consulta de componentes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarConsultaP")
9348:         ENDTRY
9349:     ENDPROC
9350: 
9351:     *--------------------------------------------------------------------------

*-- Linhas 9371 a 9466:
9371:             *-- Composicao de custo
9372:             IF loc_nTipo = 0
9373:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9374:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9375:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9376:                            c.qtdcvs, c.cunips
9377:                     FROM SIGPRCPO c
9378:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9379:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9380:                     AND c.tipos IS NOT NULL
9381:                     ORDER BY c.mats
9382:                 ENDTEXT
9383:             ELSE
9384:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9385:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9386:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9387:                            c.qtdcvs, c.cunips
9388:                     FROM SIGPRCPO c
9389:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9390:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9391:                     AND c.tipos = <<TRANSFORM(loc_nTipo)>>
9392:                     ORDER BY c.mats
9393:                 ENDTEXT
9394:             ENDIF
9395: 
9396:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoCustoTmp")
9397:             IF loc_nR > 0
9398:                 IF USED("cursor_4c_CompoCusto")
9399:                     SELECT cursor_4c_CompoCusto
9400:                     ZAP
9401:                     APPEND FROM DBF("cursor_4c_CompoCustoTmp")
9402:                 ENDIF
9403:                 IF USED("cursor_4c_CompoCustoTmp")
9404:                     USE IN cursor_4c_CompoCustoTmp
9405:                 ENDIF
9406:                 IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
9407:                     WITH loc_oPg.grd_4c_CompoCusto
9408:                         .Column1.ControlSource  = "cursor_4c_CompoCusto.mats"
9409:                         .Column2.ControlSource  = "cursor_4c_CompoCusto.dcompos"
9410:                         .Column3.ControlSource  = "cursor_4c_CompoCusto.unicompos"
9411:                         .Column4.ControlSource  = "cursor_4c_CompoCusto.pcompos"
9412:                         .Column5.ControlSource  = "cursor_4c_CompoCusto.qtds"
9413:                         .Column6.ControlSource  = "cursor_4c_CompoCusto.totas"
9414:                         .Column7.ControlSource  = "cursor_4c_CompoCusto.moeds"
9415:                         .Column8.ControlSource  = "cursor_4c_CompoCusto.obscompos"
9416:                         .Column9.ControlSource  = "cursor_4c_CompoCusto.etiqs"
9417:                         .Column10.ControlSource = "cursor_4c_CompoCusto.qtscons"
9418:                         .Column11.ControlSource = "cursor_4c_CompoCusto.qtdcvs"
9419:                         .Column12.ControlSource = "cursor_4c_CompoCusto.cunips"
9420:                     ENDWITH
9421:                     loc_oPg.grd_4c_CompoCusto.Refresh()
9422:                 ENDIF
9423:             ENDIF
9424: 
9425:             *-- Totais por grupo de custo (GradeGRUPO2)
9426:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9427:                 SELECT RTRIM(m.cgrus) AS grupos,
9428:                        SUM(c.totas) AS totas,
9429:                        MAX(c.moeds) AS moeds
9430:                 FROM SIGPRCPO c
9431:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9432:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9433:                 AND c.tipos IS NOT NULL
9434:                 GROUP BY m.cgrus
9435:                 ORDER BY m.cgrus
9436:             ENDTEXT
9437:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoCompo2Tmp")
9438:             IF loc_nR > 0
9439:                 IF USED("cursor_4c_GrupoCompo2")
9440:                     SELECT cursor_4c_GrupoCompo2
9441:                     ZAP
9442:                     APPEND FROM DBF("cursor_4c_GrupoCompo2Tmp")
9443:                 ENDIF
9444:                 IF USED("cursor_4c_GrupoCompo2Tmp")
9445:                     USE IN cursor_4c_GrupoCompo2Tmp
9446:                 ENDIF
9447:                 IF PEMSTATUS(loc_oPg, "grd_4c_GrupoCompo2", 5)
9448:                     WITH loc_oPg.grd_4c_GrupoCompo2
9449:                         .Column1.ControlSource = "cursor_4c_GrupoCompo2.grupos"
9450:                         .Column2.ControlSource = "cursor_4c_GrupoCompo2.totas"
9451:                         .Column3.ControlSource = "cursor_4c_GrupoCompo2.moeds"
9452:                     ENDWITH
9453:                     loc_oPg.grd_4c_GrupoCompo2.Refresh()
9454:                 ENDIF
9455:             ENDIF
9456: 
9457:         CATCH TO loc_oErro
9458:             MsgErro("Erro ao carregar custos:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarCustos")
9459:         ENDTRY
9460:     ENDPROC
9461: 
9462:     *--------------------------------------------------------------------------
9463:     * CarregarFases - Carrega grid de fases (Tab 7)
9464:     * Tabela: SigCdPrf
9465:     *--------------------------------------------------------------------------
9466:     PROTECTED PROCEDURE CarregarFases()

*-- Linhas 9476 a 9504:
9476:         TRY
9477:             *-- Fases de producao
9478:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9479:                 SELECT ordems, grupos, minutos, uniprdts, matprdts
9480:                 FROM SigCdPrf
9481:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9482:                 ORDER BY ordems
9483:             ENDTEXT
9484:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")
9485:             IF loc_nR > 0
9486:                 IF USED("cursor_4c_Fases")
9487:                     SELECT cursor_4c_Fases
9488:                     ZAP
9489:                     APPEND FROM DBF("cursor_4c_FasesTmp")
9490:                 ENDIF
9491:                 IF USED("cursor_4c_FasesTmp")
9492:                     USE IN cursor_4c_FasesTmp
9493:                 ENDIF
9494:                 IF PEMSTATUS(loc_oPg, "grd_4c_Fases", 5)
9495:                     loc_oPg.grd_4c_Fases.Refresh()
9496:                 ENDIF
9497:             ENDIF
9498: 
9499:             *-- Matrizes
9500:             THIS.CarregarMatrizes()
9501: 
9502:             *-- Preencher campos do BO nas textboxes da tab
9503:             IF PEMSTATUS(loc_oPg, "txt_4c_Qminfab", 5)
9504:                 loc_oPg.txt_4c_Qminfab.Value   = loc_oBO.this_nQtminfabs

*-- Linhas 9544 a 9585:
9544: 
9545:     *--------------------------------------------------------------------------
9546:     * CarregarMatrizes - Carrega grid de matrizes (Tab 7 - sub-grid)
9547:     * Tabela: SigPrMtz JOIN SigCdPro (para Locals)
9548:     *--------------------------------------------------------------------------
9549:     PROTECTED PROCEDURE CarregarMatrizes()
9550:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9551:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9552:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
9553: 
9554:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9555:             RETURN
9556:         ENDIF
9557: 
9558:         TRY
9559:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9560:                 SELECT a.cidchaves, a.cmats, a.cpros, a.qtds, b.locals
9561:                 FROM SigPrMtz a
9562:                 INNER JOIN SigCdPro b ON RTRIM(a.cmats) = RTRIM(b.cpros)
9563:                 WHERE RTRIM(a.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9564:             ENDTEXT
9565:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizesTmp")
9566:             IF loc_nR > 0
9567:                 IF USED("cursor_4c_Matrizes")
9568:                     SELECT cursor_4c_Matrizes
9569:                     ZAP
9570:                     APPEND FROM DBF("cursor_4c_MatrizesTmp")
9571:                 ENDIF
9572:                 IF USED("cursor_4c_MatrizesTmp")
9573:                     USE IN cursor_4c_MatrizesTmp
9574:                 ENDIF
9575:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
9576:                     loc_oPg.grd_4c_Matrizes.Refresh()
9577:                 ENDIF
9578:             ENDIF
9579: 
9580:         CATCH TO loc_oErro
9581:             MsgErro("Erro ao carregar matrizes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarMatrizes")
9582:         ENDTRY
9583:     ENDPROC
9584: 
9585:     *--------------------------------------------------------------------------

*-- Linhas 9592 a 9613:
9592:         IF !EMPTY(par_cSgrus) AND !EMPTY(par_cCgrus) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
9593:             TRY
9594:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9595:                     SELECT TOP 1 codigos, descricaos FROM SigCdPsg
9596:                     WHERE cgrus = <<EscaparSQL(par_cCgrus)>> AND codigos = <<EscaparSQL(par_cSgrus)>>
9597:                 ENDTEXT
9598:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescSg")
9599:                 IF loc_nR > 0 AND !EOF("cursor_4c_DescSg")
9600:                     loc_cDesc = ALLTRIM(cursor_4c_DescSg.descricaos)
9601:                 ENDIF
9602:                 IF USED("cursor_4c_DescSg")
9603:                     USE IN cursor_4c_DescSg
9604:                 ENDIF
9605:             CATCH TO loc_oErro
9606:                 MsgErro("Erro ao carregar subgrupo:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDescSgru")
9607:             ENDTRY
9608:         ENDIF
9609: 
9610:         RETURN loc_cDesc
9611:     ENDFUNC
9612: 
9613:     *--------------------------------------------------------------------------

*-- Linhas 9744 a 9764:
9744:                     *-- Popula AliqIPI com aliqipis da classificacao fiscal
9745:                     IF PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
9746:                         TEXT TO loc_cSQL TEXTMERGE NOSHOW
9747:                             SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(cursor_4c_ClfV.Codigos))>>)
9748:                         ENDTEXT
9749:                         loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliq")
9750:                         IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliq")
9751:                             loc_oPg.txt_4c_AliqIPI.Value = cursor_4c_ClfAliq.aliqipis
9752:                         ENDIF
9753:                         IF USED("cursor_4c_ClfAliq")
9754:                             USE IN cursor_4c_ClfAliq
9755:                         ENDIF
9756:                     ENDIF
9757:                 ENDIF
9758:             ELSE
9759:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9760:                     loc_oPg.txt_4c_Clfiscal.Value  = ""
9761:                 ENDIF
9762:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9763:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9764:                 ENDIF

*-- Linhas 10186 a 10206:
10186: 
10187:         TRY
10188:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10189:                 SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))>>)
10190:             ENDTEXT
10191:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliqV")
10192:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliqV")
10193:                 loc_nAliqClf = cursor_4c_ClfAliqV.aliqipis
10194:                 IF loc_nVal = loc_nAliqClf
10195:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal." + CHR(13) + "Deixe zero para utilizar a classifica" + CHR(231) + CHR(227) + "o fiscal.", "Al" + CHR(237) + "quota IPI")
10196:                 ENDIF
10197:             ENDIF
10198:             IF USED("cursor_4c_ClfAliqV")
10199:                 USE IN cursor_4c_ClfAliqV
10200:             ENDIF
10201:         CATCH TO loc_oErro
10202:             MsgErro("Erro ao validar al" + CHR(237) + "quota IPI:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarAliqIPI")
10203:         ENDTRY
10204:     ENDPROC
10205: 
10206:     *--------------------------------------------------------------------------

*-- Linhas 10539 a 10559:
10539: 
10540:         TRY
10541:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10542:                 SELECT IpiProds FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cClf)>>)
10543:             ENDTEXT
10544:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfIpi")
10545:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfIpi")
10546:                 loc_lHabilitar = (ALLTRIM(cursor_4c_ClfIpi.IpiProds) = "S")
10547:             ENDIF
10548:             IF USED("cursor_4c_ClfIpi")
10549:                 USE IN cursor_4c_ClfIpi
10550:             ENDIF
10551:         CATCH TO loc_oErro
10552:             MsgErro("Erro ao verificar IpiProds:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFiscal_ExtIpiGotFocus")
10553:         ENDTRY
10554: 
10555:         IF !loc_lHabilitar
10556:             IF PEMSTATUS(loc_oPg, "txt_4c_Extipi", 5)
10557:                 loc_oPg.txt_4c_Extipi.ReadOnly = .T.
10558:             ENDIF
10559:         ENDIF

*-- Linhas 10597 a 10648:
10597: 
10598:         TRY
10599:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10600:                 SELECT Datas AS periodos, ValCuss AS valcustos, Moedas AS moedas
10601:                 FROM SigCdCmv
10602:                 WHERE RTRIM(Cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10603:                 ORDER BY Datas DESC
10604:             ENDTEXT
10605: 
10606:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp")
10607: 
10608:             IF USED("cursor_4c_Cmv")
10609:                 ZAP IN cursor_4c_Cmv
10610:             ENDIF
10611: 
10612:             IF loc_nR > 0
10613:                 IF !USED("cursor_4c_Cmv")
10614:                     SET NULL ON
10615:                     CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
10616:                     SET NULL OFF
10617:                 ENDIF
10618:                 IF USED("cursor_4c_CmvTemp")
10619:                     SELECT cursor_4c_Cmv
10620:                     APPEND FROM DBF("cursor_4c_CmvTemp")
10621:                 ENDIF
10622:             ENDIF
10623: 
10624:             IF USED("cursor_4c_CmvTemp")
10625:                 USE IN cursor_4c_CmvTemp
10626:             ENDIF
10627: 
10628:             IF PEMSTATUS(loc_oPg, "grd_4c_Cmv", 5)
10629:                 loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
10630:                 WITH loc_oPg.grd_4c_Cmv
10631:                     .Column1.ControlSource = "cursor_4c_Cmv.periodos"
10632:                     .Column2.ControlSource = "cursor_4c_Cmv.valcustos"
10633:                     .Column3.ControlSource = "cursor_4c_Cmv.moedas"
10634:                 ENDWITH
10635:                 loc_oPg.grd_4c_Cmv.Refresh()
10636:             ENDIF
10637:         CATCH TO loc_oErro
10638:             MsgErro("Erro ao carregar dados CMV:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDadosFiscais")
10639:         ENDTRY
10640:     ENDPROC
10641: 
10642:     *--------------------------------------------------------------------------
10643:     * BtnIniTarefaClick - Registra inicio de tarefa do Designer
10644:     * Tabela: sigprtar (cpros, dtinis, usuars)
10645:     *--------------------------------------------------------------------------
10646:     PROCEDURE BtnIniTarefaClick()
10647:         LOCAL loc_cCpros, loc_cSQL, loc_nR
10648:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

*-- Linhas 10654 a 10675:
10654: 
10655:         TRY
10656:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10657:                 INSERT INTO sigprtar (cpros, dtinis, usuars)
10658:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<FormatarDataSQL(DATE())>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>)
10659:             ENDTEXT
10660:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10661:             IF loc_nR > 0
10662:                 THIS.CarregarDesigner()
10663:             ELSE
10664:                 MsgErro("Erro ao registrar in" + CHR(237) + "cio de tarefa.", "FormProduto.BtnIniTarefaClick")
10665:             ENDIF
10666:         CATCH TO loc_oErro
10667:             MsgErro("Erro ao iniciar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnIniTarefaClick")
10668:         ENDTRY
10669:     ENDPROC
10670: 
10671:     *--------------------------------------------------------------------------
10672:     * BtnFimTarefaClick - Registra fim de tarefa do Designer
10673:     * Atualiza dtfims na ultima tarefa em aberto (dtfims IS NULL)
10674:     *--------------------------------------------------------------------------
10675:     PROCEDURE BtnFimTarefaClick()

*-- Linhas 10683 a 10704:
10683: 
10684:         TRY
10685:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10686:                 UPDATE TOP(1) sigprtar SET dtfims = <<FormatarDataSQL(DATE())>>
10687:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND dtfims IS NULL
10688:             ENDTEXT
10689:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10690:             IF loc_nR > 0
10691:                 THIS.CarregarDesigner()
10692:             ELSE
10693:                 MsgErro("Nenhuma tarefa em aberto para finalizar.", "FormProduto.BtnFimTarefaClick")
10694:             ENDIF
10695:         CATCH TO loc_oErro
10696:             MsgErro("Erro ao finalizar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnFimTarefaClick")
10697:         ENDTRY
10698:     ENDPROC
10699: 
10700:     *--------------------------------------------------------------------------
10701:     * BtnInsArqsClick - Insere arquivo do Designer via dialogo de arquivo
10702:     * Tabela: sigprarq (cpros, arquivos)
10703:     *--------------------------------------------------------------------------
10704:     PROCEDURE BtnInsArqsClick()

*-- Linhas 10717 a 10738:
10717: 
10718:         TRY
10719:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10720:                 INSERT INTO sigprarq (cpros, arquivos)
10721:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<EscaparSQL(loc_cArquivo)>>)
10722:             ENDTEXT
10723:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10724:             IF loc_nR > 0
10725:                 THIS.CarregarDesigner()
10726:             ELSE
10727:                 MsgErro("Erro ao inserir arquivo.", "FormProduto.BtnInsArqsClick")
10728:             ENDIF
10729:         CATCH TO loc_oErro
10730:             MsgErro("Erro ao inserir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInsArqsClick")
10731:         ENDTRY
10732:     ENDPROC
10733: 
10734:     *--------------------------------------------------------------------------
10735:     * BtnExcArqsClick - Exclui arquivo selecionado no grid de arquivos
10736:     *--------------------------------------------------------------------------
10737:     PROCEDURE BtnExcArqsClick()
10738:         LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR

*-- Linhas 10748 a 10769:
10748:         IF MsgConfirma("Excluir o arquivo selecionado?", "Arquivos Designer")
10749:             TRY
10750:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
10751:                     DELETE FROM sigprarq
10752:                     WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND RTRIM(arquivos) = RTRIM(<<EscaparSQL(loc_cArquivo)>>)
10753:                 ENDTEXT
10754:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10755:                 IF loc_nR > 0
10756:                     THIS.CarregarDesigner()
10757:                 ELSE
10758:                     MsgErro("Erro ao excluir arquivo.", "FormProduto.BtnExcArqsClick")
10759:                 ENDIF
10760:             CATCH TO loc_oErro
10761:                 MsgErro("Erro ao excluir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcArqsClick")
10762:             ENDTRY
10763:         ENDIF
10764:     ENDPROC
10765: 
10766:     *--------------------------------------------------------------------------
10767:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao
10768:     *--------------------------------------------------------------------------
10769:     PROCEDURE BtnOpnArqsClick()

*-- Linhas 10807 a 10873:
10807:         TRY
10808:             *-- Tarefas do Designer
10809:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10810:                 SELECT dtinis, dtfims, usuars, tarefas
10811:                 FROM sigprtar
10812:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10813:                 ORDER BY dtinis DESC
10814:             ENDTEXT
10815:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesignerTmp")
10816:             IF loc_nR > 0
10817:                 IF USED("cursor_4c_Designer")
10818:                     SELECT cursor_4c_Designer
10819:                     ZAP
10820:                     APPEND FROM DBF("cursor_4c_DesignerTmp")
10821:                 ENDIF
10822:                 IF USED("cursor_4c_DesignerTmp")
10823:                     USE IN cursor_4c_DesignerTmp
10824:                 ENDIF
10825:                 IF PEMSTATUS(loc_oPg, "grd_4c_Designer", 5)
10826:                     loc_oPg.grd_4c_Designer.Refresh()
10827:                 ENDIF
10828:             ENDIF
10829: 
10830:             *-- Arquivos do Designer
10831:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10832:                 SELECT arquivos FROM sigprarq
10833:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10834:                 ORDER BY arquivos
10835:             ENDTEXT
10836:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArquivosTmp")
10837:             IF loc_nR > 0
10838:                 IF USED("cursor_4c_Arquivos")
10839:                     SELECT cursor_4c_Arquivos
10840:                     ZAP
10841:                     APPEND FROM DBF("cursor_4c_ArquivosTmp")
10842:                 ENDIF
10843:                 IF USED("cursor_4c_ArquivosTmp")
10844:                     USE IN cursor_4c_ArquivosTmp
10845:                 ENDIF
10846:                 IF PEMSTATUS(loc_oPg, "grd_4c_Arquivos", 5)
10847:                     loc_oPg.grd_4c_Arquivos.Refresh()
10848:                 ENDIF
10849:             ENDIF
10850: 
10851:             *-- Tarefas dispon?veis para lookup Column4 (SigPrTrf = tabela mestre de tarefas)
10852:             IF USED("cursor_4c_Tarefas")
10853:                 ZAP IN cursor_4c_Tarefas
10854:             ENDIF
10855:             loc_nR = SQLEXEC(gnConnHandle, "SELECT CodCads, DesCads FROM SigPrTrf WHERE ativo = 1 ORDER BY CodCads", "cursor_4c_TarefasTmp")
10856:             IF loc_nR > 0
10857:                 IF USED("cursor_4c_Tarefas")
10858:                     APPEND FROM DBF("cursor_4c_TarefasTmp")
10859:                 ENDIF
10860:                 IF USED("cursor_4c_TarefasTmp")
10861:                     USE IN cursor_4c_TarefasTmp
10862:                 ENDIF
10863:             ELSE
10864:                 *-- Tabela SigPrTrf nao localizada: cursor fica vazio (lookup manual)
10865:                 IF USED("cursor_4c_TarefasTmp")
10866:                     USE IN cursor_4c_TarefasTmp
10867:                 ENDIF
10868:             ENDIF
10869: 
10870:         CATCH TO loc_oErro
10871:             MsgErro("Erro ao carregar designer:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDesigner")
10872:         ENDTRY
10873:     ENDPROC

*-- Linhas 11054 a 11082:
11054:             ENDIF
11055: 
11056:             gb_4c_ValidandoUI = .T.
11057:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11058:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecTmp")
11059:             gb_4c_ValidandoUI = .F.
11060: 
11061:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecTmp")
11062:                 *-- Nao encontrou: abre lookup
11063:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11064:                 loc_oForm.Caption = "Moedas"
11065:                 loc_oForm.mAddColuna("CMoes", "C" + CHR(243) + "digo", "C", 6)
11066:                 loc_oForm.mAddColuna("DMoes", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11067:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11068:                 loc_oForm.Show()
11069:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11070:                     loc_oPg.txt_4c_PcusMoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11071:                     USE IN cursor_4c_BuscaAux
11072:                 ELSE
11073:                     loc_oPg.txt_4c_PcusMoe.Value = ""
11074:                 ENDIF
11075:                 loc_oForm.Release()
11076:             ENDIF
11077:             IF USED("cursor_4c_MoecTmp")
11078:                 USE IN cursor_4c_MoecTmp
11079:             ENDIF
11080:         CATCH TO loc_oErro
11081:             gb_4c_ValidandoUI = .F.
11082:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecLostFocus")

*-- Linhas 11105 a 11132:
11105:             ENDIF
11106: 
11107:             gb_4c_ValidandoUI = .T.
11108:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11109:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecusfTmp")
11110:             gb_4c_ValidandoUI = .F.
11111: 
11112:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecusfTmp")
11113:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11114:                 loc_oForm.Caption = "Moedas"
11115:                 loc_oForm.mAddColuna("CMoes", "C" + CHR(243) + "digo", "C", 6)
11116:                 loc_oForm.mAddColuna("DMoes", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11117:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11118:                 loc_oForm.Show()
11119:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11120:                     loc_oPg.txt_4c_MoecusFoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11121:                     USE IN cursor_4c_BuscaAux
11122:                 ELSE
11123:                     loc_oPg.txt_4c_MoecusFoe.Value = ""
11124:                 ENDIF
11125:                 loc_oForm.Release()
11126:             ENDIF
11127:             IF USED("cursor_4c_MoecusfTmp")
11128:                 USE IN cursor_4c_MoecusfTmp
11129:             ENDIF
11130:         CATCH TO loc_oErro
11131:             gb_4c_ValidandoUI = .F.
11132:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecusfLostFocus")

*-- Linhas 11155 a 11182:
11155:             ENDIF
11156: 
11157:             gb_4c_ValidandoUI = .T.
11158:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11159:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaTmp")
11160:             gb_4c_ValidandoUI = .F.
11161: 
11162:             IF loc_nR <= 0 OR EOF("cursor_4c_MoedaTmp")
11163:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11164:                 loc_oForm.Caption = "Moedas"
11165:                 loc_oForm.mAddColuna("CMoes", "C" + CHR(243) + "digo", "C", 6)
11166:                 loc_oForm.mAddColuna("DMoes", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11167:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11168:                 loc_oForm.Show()
11169:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11170:                     loc_oPg.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11171:                     USE IN cursor_4c_BuscaAux
11172:                 ELSE
11173:                     loc_oPg.txt_4c_Moeda.Value = ""
11174:                 ENDIF
11175:                 loc_oForm.Release()
11176:             ENDIF
11177:             IF USED("cursor_4c_MoedaTmp")
11178:                 USE IN cursor_4c_MoedaTmp
11179:             ENDIF
11180:         CATCH TO loc_oErro
11181:             gb_4c_ValidandoUI = .F.
11182:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoedaLostFocus")

*-- Linhas 11205 a 11232:
11205:             ENDIF
11206: 
11207:             gb_4c_ValidandoUI = .T.
11208:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11209:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoepvTmp")
11210:             gb_4c_ValidandoUI = .F.
11211: 
11212:             IF loc_nR <= 0 OR EOF("cursor_4c_MoepvTmp")
11213:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11214:                 loc_oForm.Caption = "Moedas"
11215:                 loc_oForm.mAddColuna("CMoes", "C" + CHR(243) + "digo", "C", 6)
11216:                 loc_oForm.mAddColuna("DMoes", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11217:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11218:                 loc_oForm.Show()
11219:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11220:                     loc_oPg.txt_4c_Moepv.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11221:                     USE IN cursor_4c_BuscaAux
11222:                 ELSE
11223:                     loc_oPg.txt_4c_Moepv.Value = ""
11224:                 ENDIF
11225:                 loc_oForm.Release()
11226:             ENDIF
11227:             IF USED("cursor_4c_MoepvTmp")
11228:                 USE IN cursor_4c_MoepvTmp
11229:             ENDIF
11230:         CATCH TO loc_oErro
11231:             gb_4c_ValidandoUI = .F.
11232:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoepvLostFocus")

*-- Linhas 11255 a 11282:
11255:             ENDIF
11256: 
11257:             gb_4c_ValidandoUI = .T.
11258:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11259:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoevTmp")
11260:             gb_4c_ValidandoUI = .F.
11261: 
11262:             IF loc_nR <= 0 OR EOF("cursor_4c_MoevTmp")
11263:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11264:                 loc_oForm.Caption = "Moedas"
11265:                 loc_oForm.mAddColuna("CMoes", "C" + CHR(243) + "digo", "C", 6)
11266:                 loc_oForm.mAddColuna("DMoes", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11267:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11268:                 loc_oForm.Show()
11269:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11270:                     loc_oPg.txt_4c_Moev.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11271:                     USE IN cursor_4c_BuscaAux
11272:                 ELSE
11273:                     loc_oPg.txt_4c_Moev.Value = ""
11274:                 ENDIF
11275:                 loc_oForm.Release()
11276:             ENDIF
11277:             IF USED("cursor_4c_MoevTmp")
11278:                 USE IN cursor_4c_MoevTmp
11279:             ENDIF
11280:         CATCH TO loc_oErro
11281:             gb_4c_ValidandoUI = .F.
11282:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoevLostFocus")

*-- Linhas 11306 a 11333:
11306:             ENDIF
11307: 
11308:             gb_4c_ValidandoUI = .T.
11309:             loc_cSQL = "SELECT Cods, Descs, Acrescs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos<>1"
11310:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtioTmp")
11311:             gb_4c_ValidandoUI = .F.
11312: 
11313:             IF loc_nR <= 0 OR EOF("cursor_4c_FtioTmp")
11314:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11315:                 loc_oForm.Caption = "Feitios"
11316:                 loc_oForm.mAddColuna("Cods", "C" + CHR(243) + "digo", "C", 8)
11317:                 loc_oForm.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11318:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos<>1 ORDER BY Cods"
11319:                 loc_oForm.Show()
11320:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11321:                     loc_oPg.txt_4c_Ftio.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11322:                     USE IN cursor_4c_BuscaAux
11323:                 ELSE
11324:                     loc_oPg.txt_4c_Ftio.Value = ""
11325:                     IF USED("cursor_4c_FtioTmp")
11326:                         USE IN cursor_4c_FtioTmp
11327:                     ENDIF
11328:                     THIS.CarregarComposicao()
11329:                     RETURN
11330:                 ENDIF
11331:                 loc_oForm.Release()
11332:             ENDIF
11333:             IF USED("cursor_4c_FtioTmp")

*-- Linhas 11363 a 11390:
11363:             ENDIF
11364: 
11365:             gb_4c_ValidandoUI = .T.
11366:             loc_cSQL = "SELECT Cods, Descs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos=1"
11367:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmkpcTmp")
11368:             gb_4c_ValidandoUI = .F.
11369: 
11370:             IF loc_nR <= 0 OR EOF("cursor_4c_CmkpcTmp")
11371:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11372:                 loc_oForm.Caption = "Feitios de Custo"
11373:                 loc_oForm.mAddColuna("Cods", "C" + CHR(243) + "digo", "C", 8)
11374:                 loc_oForm.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", "C", 30)
11375:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos=1 ORDER BY Cods"
11376:                 loc_oForm.Show()
11377:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11378:                     loc_oPg.txt_4c_Cmkpc.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11379:                     USE IN cursor_4c_BuscaAux
11380:                 ELSE
11381:                     loc_oPg.txt_4c_Cmkpc.Value = ""
11382:                     IF USED("cursor_4c_CmkpcTmp")
11383:                         USE IN cursor_4c_CmkpcTmp
11384:                     ENDIF
11385:                     THIS.CarregarComposicao()
11386:                     RETURN
11387:                 ENDIF
11388:                 loc_oForm.Release()
11389:             ENDIF
11390:             IF USED("cursor_4c_CmkpcTmp")

*-- Linhas 11455 a 11482:
11455:             ENDIF
11456: 
11457:             gb_4c_ValidandoUI = .T.
11458:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11459:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTmp")
11460:             gb_4c_ValidandoUI = .F.
11461: 
11462:             IF loc_nR <= 0 OR EOF("cursor_4c_DescTmp")
11463:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11464:                 loc_oForm.Caption = "Produtos"
11465:                 loc_oForm.mAddColuna("CPros", "C" + CHR(243) + "digo", "C", 14)
11466:                 loc_oForm.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", "C", 40)
11467:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11468:                 loc_oForm.Show()
11469:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11470:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11471:                     IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11472:                         loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11473:                     ENDIF
11474:                     USE IN cursor_4c_BuscaAux
11475:                 ELSE
11476:                     loc_oPg.txt_4c_Desc.Value = ""
11477:                 ENDIF
11478:                 loc_oForm.Release()
11479:             ELSE
11480:                 IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11481:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_DescTmp.CPros)
11482:                 ENDIF

*-- Linhas 11512 a 11539:
11512:             ENDIF
11513: 
11514:             gb_4c_ValidandoUI = .T.
11515:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11516:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatPTmp")
11517:             gb_4c_ValidandoUI = .F.
11518: 
11519:             IF loc_nR <= 0 OR EOF("cursor_4c_MatPTmp")
11520:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11521:                 loc_oForm.Caption = "Material Principal"
11522:                 loc_oForm.mAddColuna("CPros", "C" + CHR(243) + "digo", "C", 14)
11523:                 loc_oForm.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", "C", 40)
11524:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11525:                 loc_oForm.Show()
11526:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11527:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11528:                     IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11529:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11530:                     ENDIF
11531:                     USE IN cursor_4c_BuscaAux
11532:                 ELSE
11533:                     loc_oPg.txt_4c_MatP.Value = ""
11534:                 ENDIF
11535:                 loc_oForm.Release()
11536:             ELSE
11537:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11538:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_MatPTmp.DPros)
11539:                 ENDIF

*-- Linhas 11569 a 11596:
11569:             ENDIF
11570: 
11571:             gb_4c_ValidandoUI = .T.
11572:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11573:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesccpTmp")
11574:             gb_4c_ValidandoUI = .F.
11575: 
11576:             IF loc_nR <= 0 OR EOF("cursor_4c_DesccpTmp")
11577:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11578:                 loc_oForm.Caption = "Sub-Componentes"
11579:                 loc_oForm.mAddColuna("CPros", "C" + CHR(243) + "digo", "C", 14)
11580:                 loc_oForm.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", "C", 40)
11581:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11582:                 loc_oForm.Show()
11583:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11584:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11585:                     IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11586:                         loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11587:                     ENDIF
11588:                     USE IN cursor_4c_BuscaAux
11589:                 ELSE
11590:                     loc_oPg.txt_4c__desccp.Value = ""
11591:                 ENDIF
11592:                 loc_oForm.Release()
11593:             ELSE
11594:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11595:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_DesccpTmp.CPros)
11596:                 ENDIF

*-- Linhas 11626 a 11653:
11626:             ENDIF
11627: 
11628:             gb_4c_ValidandoUI = .T.
11629:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11630:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatsubTmp")
11631:             gb_4c_ValidandoUI = .F.
11632: 
11633:             IF loc_nR <= 0 OR EOF("cursor_4c_MatsubTmp")
11634:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11635:                 loc_oForm.Caption = "Produto Substituto"
11636:                 loc_oForm.mAddColuna("CPros", "C" + CHR(243) + "digo", "C", 14)
11637:                 loc_oForm.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", "C", 40)
11638:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11639:                 loc_oForm.Show()
11640:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11641:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11642:                     IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11643:                         loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11644:                     ENDIF
11645:                     USE IN cursor_4c_BuscaAux
11646:                 ELSE
11647:                     loc_oPg.txt_4c__matsub.Value = ""
11648:                 ENDIF
11649:                 loc_oForm.Release()
11650:             ELSE
11651:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11652:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_MatsubTmp.DPros)
11653:                 ENDIF

*-- Linhas 11677 a 11697:
11677:         ENDIF
11678: 
11679:         TRY
11680:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves, tpcalccus) VALUES (" + ;
11681:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), 1)"
11682:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11683:             IF loc_nR > 0
11684:                 THIS.CarregarComposicao()
11685:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
11686:                     loc_oPg.grd_4c_Compo.SetFocus()
11687:                 ENDIF
11688:             ELSE
11689:                 MsgErro("Erro ao incluir linha na composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoIncluirClick")
11690:             ENDIF
11691:         CATCH TO loc_oErro
11692:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoIncluirClick")
11693:         ENDTRY
11694:     ENDPROC
11695: 
11696:     *--------------------------------------------------------------------------
11697:     * CmdCompoExcluirClick - Botao excluir linha da composicao (grdCompo)

*-- Linhas 11713 a 11733:
11713:             IF EMPTY(loc_cMats)
11714:                 RETURN
11715:             ENDIF
11716:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11717:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11718:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11719:             IF loc_nR > 0
11720:                 THIS.CarregarComposicao()
11721:             ELSE
11722:                 MsgErro("Erro ao excluir linha da composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoExcluirClick")
11723:             ENDIF
11724:         CATCH TO loc_oErro
11725:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoExcluirClick")
11726:         ENDTRY
11727:     ENDPROC
11728: 
11729:     *--------------------------------------------------------------------------
11730:     * CmdCompoAtualizarClick - Botao atualizar/recalcular precos da composicao
11731:     *--------------------------------------------------------------------------
11732:     PROCEDURE CmdCompoAtualizarClick()
11733:         TRY

*-- Linhas 11784 a 11804:
11784:                 MsgErro("Item da composi" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido.", "FormProduto.CmdSubCpIncluirClick")
11785:                 RETURN
11786:             ENDIF
11787:             loc_cSQL = "INSERT INTO sigsubcp (cpros, dtmovs, cidchaves, tpcalccus, matsubs) VALUES (" + ;
11788:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), 1, " + EscaparSQL(loc_cMats) + ")"
11789:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11790:             IF loc_nR > 0
11791:                 THIS.CarregarComposicao()
11792:                 IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
11793:                     loc_oPg.grd_4c_SubCompo.SetFocus()
11794:                 ENDIF
11795:             ELSE
11796:                 MsgErro("Erro ao incluir sub-componente.", "FormProduto.CmdSubCpIncluirClick")
11797:             ENDIF
11798:         CATCH TO loc_oErro
11799:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpIncluirClick")
11800:         ENDTRY
11801:     ENDPROC
11802: 
11803:     *--------------------------------------------------------------------------
11804:     * CmdSubCpExcluirClick - Botao excluir sub-componente (grdsubcp)

*-- Linhas 11819 a 11839:
11819:             IF EMPTY(loc_cMats)
11820:                 RETURN
11821:             ENDIF
11822:             loc_cSQL = "DELETE FROM sigsubcp WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11823:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11824:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11825:             IF loc_nR > 0
11826:                 THIS.CarregarComposicao()
11827:             ELSE
11828:                 MsgErro("Erro ao excluir sub-componente.", "FormProduto.CmdSubCpExcluirClick")
11829:             ENDIF
11830:         CATCH TO loc_oErro
11831:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpExcluirClick")
11832:         ENDTRY
11833:     ENDPROC
11834: 
11835:     *--------------------------------------------------------------------------
11836:     * CmdCalcValsClick - Botao calcular valores de preco/custo
11837:     *--------------------------------------------------------------------------
11838:     PROCEDURE CmdCalcValsClick()
11839:         TRY

*-- Linhas 11857 a 11879:
11857: 
11858:         TRY
11859:             *-- Busca peso calculado a partir da composicao
11860:             loc_cSQL = "SELECT SUM(c.qtds * p.pesobs) AS peso_calc " + ;
11861:                        "FROM SIGPRCPO c " + ;
11862:                        "LEFT JOIN SigCdPro p ON RTRIM(c.mats) = RTRIM(p.cpros) " + ;
11863:                        "WHERE RTRIM(c.cpros) = " + EscaparSQL(loc_cCpros)
11864:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesoMTmp")
11865:             IF loc_nR > 0 AND !EOF("cursor_4c_PesoMTmp")
11866:                 IF PEMSTATUS(loc_oPg, "txt_4c_Pesom", 5)
11867:                     loc_oPg.txt_4c_Pesom.Value = NVL(cursor_4c_PesoMTmp.peso_calc, 0)
11868:                 ENDIF
11869:             ENDIF
11870:             IF USED("cursor_4c_PesoMTmp")
11871:                 USE IN cursor_4c_PesoMTmp
11872:             ENDIF
11873:         CATCH TO loc_oErro
11874:             MsgErro(loc_oErro.Message, "FormProduto.CmdPesoMClick")
11875:         ENDTRY
11876:     ENDPROC
11877: 
11878:     *--------------------------------------------------------------------------
11879:     * CustosGrd_AfterRowColChange - Grid custos: ao mudar linha/coluna

*-- Linhas 11893 a 11915:
11893:                 *-- Buscar descricao do grupo com base no material
11894:                 loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
11895:                 IF !EMPTY(loc_cMats) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
11896:                     loc_cSQL = "SELECT g.dgrus FROM SigCdPro p " + ;
11897:                                "INNER JOIN SigCdGrp g ON RTRIM(p.cgrus) = RTRIM(g.cgrus) " + ;
11898:                                "WHERE RTRIM(p.cpros) = " + EscaparSQL(loc_cMats)
11899:                     gb_4c_ValidandoUI = .T.
11900:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoTmpC")
11901:                     gb_4c_ValidandoUI = .F.
11902:                     IF loc_nR > 0 AND !EOF("cursor_4c_GrupoTmpC")
11903:                         IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
11904:                             loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(NVL(cursor_4c_GrupoTmpC.dgrus, ""))
11905:                         ENDIF
11906:                     ENDIF
11907:                     IF USED("cursor_4c_GrupoTmpC")
11908:                         USE IN cursor_4c_GrupoTmpC
11909:                     ENDIF
11910:                 ELSE
11911:                     IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
11912:                         loc_oPg.txt_4c_DGruCompos.Value = ""
11913:                     ENDIF
11914:                 ENDIF
11915:             ENDIF

*-- Linhas 11944 a 12000:
11944:             CASE par_nColIndex = 4
11945:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
11946:                 IF !EMPTY(loc_cGrupos)
11947:                     loc_cSQL = "SELECT TOP 1 descrs FROM SigCdPrf WHERE RTRIM(grupos) = " + EscaparSQL(loc_cGrupos)
11948:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfDesc")
11949:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfDesc")
11950:                         REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfDesc.descrs, ""))
11951:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
11952:                             loc_oPg.grd_4c_Consulta.Refresh()
11953:                         ENDIF
11954:                     ELSE
11955:                         THIS.AbrirLookupConsultaFase()
11956:                     ENDIF
11957:                     IF USED("cursor_4c_PrfDesc")
11958:                         USE IN cursor_4c_PrfDesc
11959:                     ENDIF
11960:                 ENDIF
11961: 
11962:             *-- Coluna 5 (Descricao fase): busca grupos em SigCdPrf por descricao
11963:             CASE par_nColIndex = 5
11964:                 loc_cDcompos = ALLTRIM(NVL(cursor_4c_Consulta.dcompos, ""))
11965:                 IF !EMPTY(loc_cDcompos)
11966:                     loc_cSQL = "SELECT TOP 1 grupos, descrs FROM SigCdPrf WHERE RTRIM(descrs) = " + EscaparSQL(loc_cDcompos)
11967:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfGrp")
11968:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfGrp")
11969:                         REPLACE cursor_4c_Consulta.grupos  WITH ALLTRIM(NVL(cursor_4c_PrfGrp.grupos, ""))
11970:                         REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfGrp.descrs, ""))
11971:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
11972:                             loc_oPg.grd_4c_Consulta.Refresh()
11973:                         ENDIF
11974:                     ENDIF
11975:                     IF USED("cursor_4c_PrfGrp")
11976:                         USE IN cursor_4c_PrfGrp
11977:                     ENDIF
11978:                 ENDIF
11979: 
11980:             *-- Coluna 8 (Cat): busca descricao em SigCdCat
11981:             CASE par_nColIndex = 8
11982:                 loc_cCats = ALLTRIM(NVL(cursor_4c_Consulta.cats, ""))
11983:                 IF !EMPTY(loc_cCats)
11984:                     loc_cSQL = "SELECT TOP 1 descs FROM SigCdCat WHERE RTRIM(cods) = " + EscaparSQL(loc_cCats)
11985:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CatDesc")
11986:                     IF loc_nR > 0 AND !EOF("cursor_4c_CatDesc")
11987:                         REPLACE cursor_4c_Consulta.dscgrp WITH ALLTRIM(NVL(cursor_4c_CatDesc.descs, ""))
11988:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
11989:                             loc_oPg.grd_4c_Consulta.Refresh()
11990:                         ENDIF
11991:                     ELSE
11992:                         THIS.AbrirLookupConsultaCat()
11993:                     ENDIF
11994:                     IF USED("cursor_4c_CatDesc")
11995:                         USE IN cursor_4c_CatDesc
11996:                     ENDIF
11997:                 ENDIF
11998: 
11999:             ENDCASE
12000:         CATCH TO loc_oErro

*-- Linhas 12129 a 12149:
12129:                 ENDIF
12130:             ENDIF
12131: 
12132:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves, tipos) VALUES (" + ;
12133:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + TRANSFORM(loc_nTipo) + ")"
12134:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12135:             IF loc_nR > 0
12136:                 THIS.CarregarCustos()
12137:                 IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
12138:                     loc_oPg.grd_4c_CompoCusto.SetFocus()
12139:                 ENDIF
12140:             ELSE
12141:                 MsgErro("Erro ao incluir linha no custo.", "FormProduto.CmdCustoIncluirClick")
12142:             ENDIF
12143:         CATCH TO loc_oErro
12144:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoIncluirClick")
12145:         ENDTRY
12146:     ENDPROC
12147: 
12148:     *--------------------------------------------------------------------------
12149:     * CmdCustoExcluirClick - Botao excluir linha do grid de custo

*-- Linhas 12174 a 12194:
12174:                 RETURN
12175:             ENDIF
12176: 
12177:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCpros) + ;
12178:                        " AND RTRIM(mats) = " + EscaparSQL(loc_cMats)
12179:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12180:             IF loc_nR > 0
12181:                 THIS.CarregarCustos()
12182:             ELSE
12183:                 MsgErro("Erro ao excluir linha do custo.", "FormProduto.CmdCustoExcluirClick")
12184:             ENDIF
12185:         CATCH TO loc_oErro
12186:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoExcluirClick")
12187:         ENDTRY
12188:     ENDPROC
12189: 
12190:     *==========================================================================
12191:     * METODOS DA ABA FASES (Tab 7 - PgDadosFaseP)
12192:     *==========================================================================
12193: 
12194:     *--------------------------------------------------------------------------

*-- Linhas 12220 a 12264:
12220:             *-- Carregar imagem FigProcs da fase atual (campo binario em SigCdPrf)
12221:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND loc_nOrdems > 0
12222:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
12223:                     SELECT TOP 1 FigProcs FROM SigCdPrf
12224:                     WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12225:                     AND ordems = <<loc_nOrdems>>
12226:                 ENDTEXT
12227:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigFase")
12228:                 IF loc_nR > 0 AND !EOF("cursor_4c_FigFase")
12229:                     IF !EMPTY(NVL(cursor_4c_FigFase.FigProcs, ""))
12230:                         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12231:                         IF (STRTOFILE(cursor_4c_FigFase.FigProcs, loc_cArquivo) > 0)
12232:                             IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
12233:                                 loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
12234:                                 loc_oPg.img_4c_ImgFigJpg.Visible = .T.
12235:                             ENDIF
12236:                         ENDIF
12237:                     ENDIF
12238:                 ENDIF
12239:                 IF USED("cursor_4c_FigFase")
12240:                     USE IN cursor_4c_FigFase
12241:                 ENDIF
12242:             ENDIF
12243: 
12244:             *-- Carregar descricao e observacao da fase (SigCdGcr)
12245:             IF !EMPTY(loc_cGrupos) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
12246:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
12247:                     SELECT TOP 1 Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cGrupos)>>)
12248:                 ENDTEXT
12249:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FaseDesc")
12250:                 IF loc_nR > 0 AND !EOF("cursor_4c_FaseDesc")
12251:                     IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
12252:                         loc_oPg.txt_4c_DescFase.Value = ALLTRIM(NVL(cursor_4c_FaseDesc.Descrs, ""))
12253:                     ENDIF
12254:                 ELSE
12255:                     IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
12256:                         loc_oPg.txt_4c_DescFase.Value = ""
12257:                     ENDIF
12258:                 ENDIF
12259:                 IF USED("cursor_4c_FaseDesc")
12260:                     USE IN cursor_4c_FaseDesc
12261:                 ENDIF
12262:             ELSE
12263:                 IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
12264:                     loc_oPg.txt_4c_DescFase.Value = ""

*-- Linhas 12301 a 12321:
12301: 
12302:             *-- Carregar imagem FigJpgs do produto matriz (SigCdPro)
12303:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12304:                 SELECT TOP 1 FigJpgs FROM SigCdPro WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
12305:             ENDTEXT
12306:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigBorr")
12307:             IF loc_nR > 0 AND !EOF("cursor_4c_FigBorr")
12308:                 loc_cFigB64 = NVL(cursor_4c_FigBorr.FigJpgs, "")
12309:                 IF !EMPTY(loc_cFigB64)
12310:                     *-- Converter de Base64 para binario
12311:                     LOCAL loc_cFigBin
12312:                     loc_cFigBin = STRCONV( ;
12313:                         STRTRAN(STRTRAN(STRTRAN(loc_cFigB64, ;
12314:                             "data:image/png;base64,", ""), ;
12315:                             "data:image/jpeg;base64,", ""), ;
12316:                             "data:image/jpg;base64,", ""), 14)
12317:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12318:                     IF STRTOFILE(loc_cFigBin, loc_cArquivo) > 0
12319:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
12320:                             loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
12321:                             loc_oPg.img_4c_ImgBorracha.Visible = .T.

*-- Linhas 12371 a 12391:
12371:         ENDIF
12372:         TRY
12373:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12374:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
12375:             ENDTEXT
12376:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCorFas")
12377:             IF loc_nR <= 0 OR EOF("cursor_4c_VCorFas")
12378:                 THIS.AbrirLookupCorFas()
12379:             ELSE
12380:                 THIS.this_oBusinessObject.this_cCodcors = loc_cCod
12381:             ENDIF
12382:             IF USED("cursor_4c_VCorFas")
12383:                 USE IN cursor_4c_VCorFas
12384:             ENDIF
12385:         CATCH TO loc_oErro
12386:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodcorsLostFocus")
12387:         ENDTRY
12388:     ENDPROC
12389: 
12390:     *--------------------------------------------------------------------------
12391:     * AbrirLookupCorFas - Lookup Cor para a aba Fases

*-- Linhas 12455 a 12475:
12455:         ENDIF
12456:         TRY
12457:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12458:                 SELECT TOP 1 Cods FROM SigCdTam WHERE Cods = <<EscaparSQL(loc_cCod)>>
12459:             ENDTEXT
12460:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VTamFas")
12461:             IF loc_nR <= 0 OR EOF("cursor_4c_VTamFas")
12462:                 THIS.AbrirLookupTamanhoFas()
12463:             ELSE
12464:                 THIS.this_oBusinessObject.this_cCodtams = loc_cCod
12465:             ENDIF
12466:             IF USED("cursor_4c_VTamFas")
12467:                 USE IN cursor_4c_VTamFas
12468:             ENDIF
12469:         CATCH TO loc_oErro
12470:             MsgErro("Erro ao validar tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodtamsLostFocus")
12471:         ENDTRY
12472:     ENDPROC
12473: 
12474:     *--------------------------------------------------------------------------
12475:     * AbrirLookupTamanhoFas - Lookup Tamanho para a aba Fases

*-- Linhas 12541 a 12561:
12541:         ENDIF
12542:         TRY
12543:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12544:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
12545:             ENDTEXT
12546:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcbFas")
12547:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcbFas")
12548:                 IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
12549:                     loc_oPg.txt_4c_DacbsFas.Value = ALLTRIM(cursor_4c_VAcbFas.descrs)
12550:                 ENDIF
12551:                 THIS.this_oBusinessObject.this_cCodacbs = loc_cCod
12552:             ELSE
12553:                 THIS.AbrirLookupAcabamentoFas()
12554:             ENDIF
12555:             IF USED("cursor_4c_VAcbFas")
12556:                 USE IN cursor_4c_VAcbFas
12557:             ENDIF
12558:         CATCH TO loc_oErro
12559:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodacbsLostFocus")
12560:         ENDTRY
12561:     ENDPROC

*-- Linhas 12637 a 12657:
12637:         ENDIF
12638:         TRY
12639:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12640:                 SELECT TOP 1 conquilhas FROM SigCdCnq WHERE RTRIM(conquilhas) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12641:             ENDTEXT
12642:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCnq")
12643:             IF loc_nR <= 0 OR EOF("cursor_4c_VCnq")
12644:                 THIS.AbrirLookupConquilha()
12645:             ELSE
12646:                 THIS.this_oBusinessObject.this_cConquilhas = loc_cCod
12647:             ENDIF
12648:             IF USED("cursor_4c_VCnq")
12649:                 USE IN cursor_4c_VCnq
12650:             ENDIF
12651:         CATCH TO loc_oErro
12652:             MsgErro("Erro ao validar conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_ConquilhaLostFocus")
12653:         ENDTRY
12654:     ENDPROC
12655: 
12656:     *--------------------------------------------------------------------------
12657:     * AbrirLookupConquilha - Lookup para campo Conquilha (SigCdCnq)

*-- Linhas 12715 a 12735:
12715:         ENDIF
12716:         TRY
12717:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12718:                 SELECT TOP 1 codgarras FROM SigCdGar WHERE RTRIM(codgarras) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12719:             ENDTEXT
12720:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGar")
12721:             IF loc_nR <= 0 OR EOF("cursor_4c_VGar")
12722:                 THIS.AbrirLookupGarra()
12723:             ELSE
12724:                 THIS.this_oBusinessObject.this_cCodgarras = loc_cCod
12725:             ENDIF
12726:             IF USED("cursor_4c_VGar")
12727:                 USE IN cursor_4c_VGar
12728:             ENDIF
12729:         CATCH TO loc_oErro
12730:             MsgErro("Erro ao validar garra:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_GarraLostFocus")
12731:         ENDTRY
12732:     ENDPROC
12733: 
12734:     *--------------------------------------------------------------------------
12735:     * AbrirLookupGarra - Lookup para campo Garra (SigCdGar)

*-- Linhas 12788 a 12824:
12788:         TRY
12789:             *-- Calcular proximo numero de ordem
12790:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12791:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
12792:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12793:             ENDTEXT
12794:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdem")
12795:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdem")
12796:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdem.proximo, 1)
12797:             ELSE
12798:                 loc_nProxOrdem = 1
12799:             ENDIF
12800:             IF USED("cursor_4c_MaxOrdem")
12801:                 USE IN cursor_4c_MaxOrdem
12802:             ENDIF
12803: 
12804:             *-- Inserir nova fase
12805:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12806:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
12807:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, '', 0, '', '')
12808:             ENDTEXT
12809:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12810:             IF loc_nR > 0
12811:                 THIS.CarregarFases()
12812:                 LOCAL loc_oPg7
12813:                 loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12814:                 IF PEMSTATUS(loc_oPg7, "grd_4c_Fases", 5)
12815:                     loc_oPg7.grd_4c_Fases.SetFocus()
12816:                 ENDIF
12817:             ELSE
12818:                 MsgErro("Erro ao inserir fase.", "FormProduto.BtnInserirFaseClick")
12819:             ENDIF
12820:         CATCH TO loc_oErro
12821:             MsgErro("Erro ao inserir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirFaseClick")
12822:         ENDTRY
12823:     ENDPROC
12824: 

*-- Linhas 12852 a 12874:
12852: 
12853:         TRY
12854:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12855:                 DELETE FROM SigCdPrf
12856:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12857:                 AND ordems = <<loc_nOrdems>>
12858:             ENDTEXT
12859:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12860:             IF loc_nR > 0
12861:                 THIS.CarregarFases()
12862:             ELSE
12863:                 MsgErro("Erro ao excluir fase.", "FormProduto.BtnExcluirFaseClick")
12864:             ENDIF
12865:         CATCH TO loc_oErro
12866:             MsgErro("Erro ao excluir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirFaseClick")
12867:         ENDTRY
12868:     ENDPROC
12869: 
12870:     *--------------------------------------------------------------------------
12871:     * BtnAlternativaFaseClick - Inserir fase alternativa (alternativa da fase atual)
12872:     *--------------------------------------------------------------------------
12873:     PROCEDURE BtnAlternativaFaseClick()
12874:         LOCAL loc_cCpros, loc_cGrupoAtual, loc_cSQL, loc_nR, loc_nProxOrdem

*-- Linhas 12898 a 12934:
12898:         TRY
12899:             *-- Calcular proximo numero de ordem
12900:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12901:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
12902:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12903:             ENDTEXT
12904:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdAlt")
12905:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdAlt")
12906:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdAlt.proximo, 1)
12907:             ELSE
12908:                 loc_nProxOrdem = 1
12909:             ENDIF
12910:             IF USED("cursor_4c_MaxOrdAlt")
12911:                 USE IN cursor_4c_MaxOrdAlt
12912:             ENDIF
12913: 
12914:             *-- Inserir fase alternativa copiando o grupo da fase atual
12915:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12916:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
12917:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, <<EscaparSQL(loc_cGrupoAtual)>>, 0, '', '')
12918:             ENDTEXT
12919:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12920:             IF loc_nR > 0
12921:                 THIS.CarregarFases()
12922:             ELSE
12923:                 MsgErro("Erro ao inserir fase alternativa.", "FormProduto.BtnAlternativaFaseClick")
12924:             ENDIF
12925:         CATCH TO loc_oErro
12926:             MsgErro("Erro ao inserir alternativa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnAlternativaFaseClick")
12927:         ENDTRY
12928:     ENDPROC
12929: 
12930:     *--------------------------------------------------------------------------
12931:     * CmdFichaClick - Imprimir ficha tecnica das fases do produto
12932:     *--------------------------------------------------------------------------
12933:     PROCEDURE CmdFichaClick()
12934:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oBO

*-- Linhas 12946 a 12970:
12946:             IF USED("CsCabecalho")
12947:                 USE IN CsCabecalho
12948:             ENDIF
12949:             CREATE CURSOR CsCabecalho ( ;
12950:                 _NmEmp  C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
12951:                 _cGrus  C(03), _dGrus C(20), _sGrus C(06), _sDesc C(20), ;
12952:                 _cLinh  C(10), _dLinh C(40), _cGVen C(10), _dGVen C(40), ;
12953:                 _nPeso  N(9,2), _DtIni D(08), _DtFin D(08), _TExec C(15), _cMode C(10))
12954: 
12955:             INSERT INTO CsCabecalho ;
12956:                 (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _dGrus, _cMode) ;
12957:                 VALUES( ;
12958:                     go_4c_Sistema.cEmpresa, ;
12959:                     "Ficha T" + CHR(233) + "cnica de Fases", ;
12960:                     loc_cCpros, ;
12961:                     loc_oBO.this_cDpros, ;
12962:                     loc_oBO.this_cCgrus, ;
12963:                     THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus"), ;
12964:                     THIS.this_cModoAtual)
12965: 
12966:             MsgInfo("Ficha t" + CHR(233) + "cnica gerada. Configure o relat" + CHR(243) + "rio RelFase.frx para impress" + CHR(227) + "o.", "Ficha T" + CHR(233) + "cnica")
12967: 
12968:             IF USED("CsCabecalho")
12969:                 USE IN CsCabecalho
12970:             ENDIF

*-- Linhas 13003 a 13043:
13003:         TRY
13004:             *-- Verificar se ja tem imagem
13005:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13006:                 SELECT TOP 1 CASE WHEN FigProcs IS NULL OR LEN(RTRIM(FigProcs))=0 THEN 0 ELSE 1 END AS temFig
13007:                 FROM SigCdPrf
13008:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13009:             ENDTEXT
13010:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerFig")
13011:             LOCAL loc_lTemFig
13012:             loc_lTemFig = .F.
13013:             IF loc_nR > 0 AND !EOF("cursor_4c_VerFig")
13014:                 loc_lTemFig = (cursor_4c_VerFig.temFig > 0)
13015:             ENDIF
13016:             IF USED("cursor_4c_VerFig")
13017:                 USE IN cursor_4c_VerFig
13018:             ENDIF
13019: 
13020:             IF loc_lTemFig
13021:                 *-- Oferecer opcoes: substituir ou remover
13022:                 loc_lConfirma = MsgConfirma("Esta fase j" + CHR(225) + " possui imagem. Deseja remov" + CHR(234) + "-la?", "Imagem da Fase")
13023:                 IF loc_lConfirma
13024:                     TEXT TO loc_cSQL TEXTMERGE NOSHOW
13025:                         UPDATE SigCdPrf SET FigProcs = NULL
13026:                         WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13027:                     ENDTEXT
13028:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13029:                     IF loc_nR > 0
13030:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
13031:                             loc_oPg.img_4c_ImgFigJpg.Picture = ""
13032:                             loc_oPg.img_4c_ImgFigJpg.Visible = .F.
13033:                         ENDIF
13034:                         MsgInfo("Imagem removida.", "FormProduto")
13035:                     ENDIF
13036:                     RETURN
13037:                 ENDIF
13038:             ENDIF
13039: 
13040:             *-- Selecionar arquivo de imagem
13041:             loc_cFig = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar Imagem da Fase:")
13042:             IF EMPTY(loc_cFig) OR !FILE(loc_cFig)
13043:                 RETURN

*-- Linhas 13052 a 13073:
13052:             ENDIF
13053: 
13054:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13055:                 UPDATE SigCdPrf SET FigProcs = ?loc_cBinImg
13056:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13057:             ENDTEXT
13058:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13059:             IF loc_nR > 0
13060:                 *-- Exibir imagem carregada
13061:                 loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
13062:                 STRTOFILE(loc_cBinImg, loc_cArquivo)
13063:                 IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
13064:                     loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
13065:                     loc_oPg.img_4c_ImgFigJpg.Visible = .T.
13066:                 ENDIF
13067:             ELSE
13068:                 MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFiguraClick")
13069:             ENDIF
13070: 
13071:         CATCH TO loc_oErro
13072:             MsgErro("Erro ao carregar imagem:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFiguraClick")
13073:         ENDTRY

*-- Linhas 13115 a 13136:
13115:             loc_cB64 = "data:image/jpeg;base64," + STRCONV(loc_cBinImg, 13)
13116: 
13117:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13118:                 UPDATE SigCdPro SET FigJpgs = ?loc_cB64
13119:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
13120:             ENDTEXT
13121:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13122:             IF loc_nR > 0
13123:                 *-- Exibir imagem
13124:                 loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
13125:                 STRTOFILE(loc_cBinImg, loc_cArquivo)
13126:                 IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
13127:                     loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
13128:                     loc_oPg.img_4c_ImgBorracha.Visible = .T.
13129:                 ENDIF
13130:             ELSE
13131:                 MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFigCamClick")
13132:             ENDIF
13133: 
13134:         CATCH TO loc_oErro
13135:             MsgErro("Erro ao carregar imagem de borracha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFigCamClick")
13136:         ENDTRY

*-- Linhas 13156 a 13177:
13156:         TRY
13157:             *-- Inserir nova linha vazia em SigPrMtz com cIdChaves unico
13158:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13159:                 INSERT INTO SigPrMtz (cpros, cidchaves, cmats, qtds)
13160:                 VALUES (<<EscaparSQL(loc_cCpros)>>, NEWID(), '', 0)
13161:             ENDTEXT
13162:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13163:             IF loc_nR > 0
13164:                 THIS.CarregarMatrizes()
13165:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13166:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
13167:                     loc_oPg.grd_4c_Matrizes.SetFocus()
13168:                 ENDIF
13169:             ELSE
13170:                 MsgErro("Erro ao inserir matriz.", "FormProduto.BtnInserirMatrizClick")
13171:             ENDIF
13172:         CATCH TO loc_oErro
13173:             MsgErro("Erro ao inserir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirMatrizClick")
13174:         ENDTRY
13175:     ENDPROC
13176: 
13177:     *--------------------------------------------------------------------------

*-- Linhas 13204 a 13225:
13204: 
13205:         TRY
13206:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13207:                 DELETE FROM SigPrMtz
13208:                 WHERE RTRIM(cidchaves) = RTRIM(<<EscaparSQL(loc_cCidChaves)>>)
13209:             ENDTEXT
13210:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13211:             IF loc_nR > 0
13212:                 THIS.CarregarMatrizes()
13213:             ELSE
13214:                 MsgErro("Erro ao excluir matriz.", "FormProduto.BtnExcluirMatrizClick")
13215:             ENDIF
13216:         CATCH TO loc_oErro
13217:             MsgErro("Erro ao excluir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirMatrizClick")
13218:         ENDTRY
13219:     ENDPROC
13220: 
13221:     *--------------------------------------------------------------------------
13222:     * DesignerGrd_AfterRowColChange - Grid tarefas: ao navegar linha/coluna
13223:     * Atualiza txt_4c_ObsTarefas com descricao da tarefa da linha atual
13224:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
13225:     *--------------------------------------------------------------------------

*-- Linhas 13234 a 13252:
13234: 
13235:                 *-- Buscar descricao no cursor de tarefas
13236:                 IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas") AND !EMPTY(loc_cCodTarefa)
13237:                     SELECT cursor_4c_Tarefas
13238:                     LOCATE FOR ALLTRIM(CodCads) = loc_cCodTarefa
13239:                     IF !EOF("cursor_4c_Tarefas")
13240:                         loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13241:                     ENDIF
13242:                 ENDIF
13243: 
13244:                 IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13245:                     loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13246:                     loc_oPg.txt_4c_ObsTarefas.Refresh()
13247:                 ENDIF
13248:             ENDIF
13249:         CATCH TO loc_oErro
13250:             MsgErro(loc_oErro.Message, "FormProduto.DesignerGrd_AfterRowColChange")
13251:         ENDTRY
13252:     ENDPROC

*-- Linhas 13356 a 13374:
13356:             loc_cCodTarefa = ""
13357:             loc_cDesTarefa = ""
13358: 
13359:             SELECT cursor_4c_Tarefas
13360:             LOCATE FOR ALLTRIM(CodCads) = loc_cValor
13361:             IF !EOF("cursor_4c_Tarefas")
13362:                 loc_lEncontrou = .T.
13363:                 loc_cCodTarefa = ALLTRIM(cursor_4c_Tarefas.CodCads)
13364:                 loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13365:             ENDIF
13366: 
13367:             *-- Atualizar descricao se encontrou; limpar se nao encontrou
13368:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13369:                 IF loc_lEncontrou
13370:                     IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13371:                         loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13372:                     ENDIF
13373:                 ELSE
13374:                     MsgAviso("C" + CHR(243) + "digo de tarefa n" + CHR(227) + "o encontrado.", "Tarefa Designer")

