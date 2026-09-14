# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-COLUNA] Coluna '" + loc_cCols + "' em INSERT INTO SigCdPro NAO existe. Colunas validas: matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, cunis, custofs, cvens, datas, datatrans, descfis, dpros, dtfilms, fcustos, figjpgs, flagctabs, fvendas, icms, ifors, linhas, locals, margems, moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, tamps, tptribs, volumes, ipis, dpro2s, dsccompras, encoms, figtecs, obscompras, codacbs, cravcers, cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, fabrproprs, qtminfabs, tents, codfinp, codmatp, dpro3s, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, conquilhas, fatuals, fideals, contaccus, gruccus, dtsituas, prodvars, prodwebs, codident, conjunts, pmins, cotacalcp, qtdultcomp, figjpgs64, diasgar, chkgarvit, altura, largura, diametro, espessura, compriment, mohs, refracao, refracaodp, ativosite, categoria, codctgsite, coddptsite, custocp, dtlacto, foralinha, mostruario, mtiposervs, obsinsp, obsmkt, precode, prodnovo, prodoff, segfem, seginf, segkids, segmasc, seguni, semconsulta, skuvtex, varpesoms, dtalts, usuaalts, bestseller, obrtamser, prototipo, lancamento, fimdtlacto, origemlac, codmacro, reposauto, procfigjpgs, propriedades, unidade1, resultado1, valorminimo, valormaximo, metodoreferencia1, qtped
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (12479 linhas total):

*-- Linhas 474 a 548:
474:         *-- Campos identicos ao que ProdutoBO.Buscar() cria
475:         *----------------------------------------------------------------------
476:         IF !USED("cursor_4c_Dados")
477:             CREATE CURSOR cursor_4c_Dados (;
478:                 cpros    C(14), dpros  C(65), cgrus C(3), ;
479:                 sgrus    C(6),  reffs  C(40), ;
480:                 usuaalts C(20), situas N(1,0))
481:         ENDIF
482: 
483:         *----------------------------------------------------------------------
484:         *-- Grid principal da lista (Grade: Top=183, Left=5)
485:         *-- ColumnCount e Visible no WITH; RecordSource FORA do WITH
486:         *----------------------------------------------------------------------
487:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
488:         WITH loc_oPagina.grd_4c_Lista
489:             .Top         = 183
490:             .Left        = 5
491:             .Width       = 950
492:             .Height      = 389
493:             .ColumnCount = 7
494:             .Visible     = .T.
495:             .RecordMark   = .F.
496:             .DeleteMark   = .F.
497:         ENDWITH
498: 
499:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
500:         loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
501: 
502:         *-- ControlSources e larguras APOS RecordSource
503:         loc_oPagina.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.cpros"
504:         loc_oPagina.grd_4c_Lista.Column1.Width            = 70
505:         loc_oPagina.grd_4c_Lista.Column1.ReadOnly         = .T.
506:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption  = "Produto"
507: 
508:         loc_oPagina.grd_4c_Lista.Column2.ControlSource   = "cursor_4c_Dados.dpros"
509:         loc_oPagina.grd_4c_Lista.Column2.Width            = 315
510:         loc_oPagina.grd_4c_Lista.Column2.ReadOnly         = .T.
511:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
512: 
513:         loc_oPagina.grd_4c_Lista.Column3.ControlSource   = "cursor_4c_Dados.cgrus"
514:         loc_oPagina.grd_4c_Lista.Column3.Width            = 55
515:         loc_oPagina.grd_4c_Lista.Column3.ReadOnly         = .T.
516:         loc_oPagina.grd_4c_Lista.Column3.Header1.Caption  = "Grupo"
517: 
518:         loc_oPagina.grd_4c_Lista.Column4.ControlSource   = "cursor_4c_Dados.sgrus"
519:         loc_oPagina.grd_4c_Lista.Column4.Width            = 70
520:         loc_oPagina.grd_4c_Lista.Column4.ReadOnly         = .T.
521:         loc_oPagina.grd_4c_Lista.Column4.Header1.Caption  = "Subgrupo"
522: 
523:         loc_oPagina.grd_4c_Lista.Column5.ControlSource   = "cursor_4c_Dados.reffs"
524:         loc_oPagina.grd_4c_Lista.Column5.Width            = 225
525:         loc_oPagina.grd_4c_Lista.Column5.ReadOnly         = .T.
526:         loc_oPagina.grd_4c_Lista.Column5.Header1.Caption  = "Ref. Fornecedor"
527: 
528:         loc_oPagina.grd_4c_Lista.Column6.ControlSource   = "cursor_4c_Dados.usuaalts"
529:         loc_oPagina.grd_4c_Lista.Column6.Width            = 150
530:         loc_oPagina.grd_4c_Lista.Column6.ReadOnly         = .T.
531:         loc_oPagina.grd_4c_Lista.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
532: 
533:         loc_oPagina.grd_4c_Lista.Column7.ControlSource   = "cursor_4c_Dados.situas"
534:         loc_oPagina.grd_4c_Lista.Column7.Width            = 30
535:         loc_oPagina.grd_4c_Lista.Column7.ReadOnly         = .T.
536:         loc_oPagina.grd_4c_Lista.Column7.Header1.Caption  = "I"
537: 
538:         *-- Formatacao padrao (Verdana 8, gridlines, RowHeight=16)
539:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
540: 
541:         *-- Label de contagem de produtos (lblProdutos: Top=584 + 29 = 613 -> 575)
542:         loc_oPagina.AddObject("lbl_4c_Contagem", "Label")
543:         WITH loc_oPagina.lbl_4c_Contagem
544:             .Caption   = "Produtos Selecionados : 0"
545:             .Top       = 575
546:             .Left      = 38
547:             .Width     = 200
548:             .Height    = 15

*-- Linhas 726 a 774:
726:         *----------------------------------------------------------------------
727:         IF !USED("cursor_4c_Compo")
728:             SET NULL ON
729:             CREATE CURSOR cursor_4c_Compo (;
730:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
731:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
732:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
733:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
734:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
735:                 cgrus    C(3),  moeds    C(5))
736:             SET NULL OFF
737:         ENDIF
738: 
739:         *----------------------------------------------------------------------
740:         *-- Cursor placeholder para grdsubcp (SigSubCp)
741:         *----------------------------------------------------------------------
742:         IF !USED("cursor_4c_SubCp")
743:             SET NULL ON
744:             CREATE CURSOR cursor_4c_SubCp (;
745:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
746:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
747:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
748:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
749:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
750:                 tamanhos C(20))
751:             SET NULL OFF
752:         ENDIF
753: 
754:         *----------------------------------------------------------------------
755:         *-- Cursor placeholder para GradeGRUPO (TotGrupo)
756:         *----------------------------------------------------------------------
757:         IF !USED("cursor_4c_Grupo")
758:             SET NULL ON
759:             CREATE CURSOR cursor_4c_Grupo (cgrus C(3), valgr N(12,4), moeds C(5))
760:             SET NULL OFF
761:         ENDIF
762: 
763:         *----------------------------------------------------------------------
764:         *-- Linha OBS da OF: Say4 + getObsOFs
765:         *-- Say4: "Obs. da OF :" (T:300 L:36 W:64)
766:         *-- getObsOFs: (T:297 L:99 W:850 H:21)
767:         *----------------------------------------------------------------------
768:         loc_oPg.AddObject("lbl_4c_ObsOF", "Label")
769:         WITH loc_oPg.lbl_4c_ObsOF
770:             .Caption   = "Obs. da OF :"
771:             .Top       = 300
772:             .Left      = 36
773:             .Width     = 64
774:             .Height    = 15

*-- Linhas 877 a 993:
877:             .GridLineWidth = 1
878:             .GridLineColor = RGB(238, 238, 238)
879:             .RecordMark  = .F.
880:             .DeleteMark  = .F.
881:             .AllowRowSizing = .F.
882:             .ReadOnly    = .F.
883:             .BackColor   = RGB(255, 255, 255)
884:             .ForeColor   = RGB(90, 90, 90)
885:             .HighlightBackColor = RGB(220, 230, 242)
886:             .HighlightForeColor = RGB(15, 41, 104)
887:             .HighlightStyle = 2
888:             .RowHeight   = 16
889:             .ScrollBars  = 2
890:             .Visible     = .T.
891:         ENDWITH
892: 
893:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
894:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
895: 
896:         *-- Configurar colunas do grd_4c_Compo APOS RecordSource
897:         WITH loc_oPg.grd_4c_Compo
898:             *-- Col1: Material (C14) W:80
899:             .Column1.Header1.Caption       = "Material"
900:             .Column1.Width                 = 80
901:             .Column1.ControlSource         = "cursor_4c_Compo.mats"
902:             .Column1.Alignment             = 0
903: 
904:             *-- Col2: Descricao (C65) W:200
905:             .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
906:             .Column2.Width                 = 200
907:             .Column2.ControlSource         = "cursor_4c_Compo.dcomps"
908:             .Column2.Alignment             = 0
909: 
910:             *-- Col3: Un (C5) W:35 - readonly
911:             .Column3.Header1.Caption       = "Un"
912:             .Column3.Width                 = 35
913:             .Column3.ControlSource         = "cursor_4c_Compo.unicompos"
914:             .Column3.ReadOnly              = .T.
915: 
916:             *-- Col4: Valor (N) W:65
917:             .Column4.Header1.Caption       = "Valor"
918:             .Column4.Width                 = 65
919:             .Column4.ControlSource         = "cursor_4c_Compo.pcompos"
920:             .Column4.Alignment             = 1
921: 
922:             *-- Col5: Qtde (N) W:60
923:             .Column5.Header1.Caption       = "Qtde."
924:             .Column5.Width                 = 60
925:             .Column5.ControlSource         = "cursor_4c_Compo.qtds"
926:             .Column5.Alignment             = 1
927: 
928:             *-- Col6: Total (N) W:65 - readonly (calculado)
929:             .Column6.Header1.Caption       = "Total"
930:             .Column6.Width                 = 65
931:             .Column6.ControlSource         = "cursor_4c_Compo.totals"
932:             .Column6.Alignment             = 1
933:             .Column6.ReadOnly              = .T.
934: 
935:             *-- Col7: Moe (C5) W:35
936:             .Column7.Header1.Caption       = "Moe"
937:             .Column7.Width                 = 35
938:             .Column7.ControlSource         = "cursor_4c_Compo.bloqueio"
939: 
940:             *-- Col8: Observacao (C40) W:100
941:             .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
942:             .Column8.Width                 = 100
943:             .Column8.ControlSource         = "cursor_4c_Compo.obscompos"
944:             .Column8.Alignment             = 0
945: 
946:             *-- Col9: E (C1) W:25
947:             .Column9.Header1.Caption       = "E"
948:             .Column9.Width                 = 25
949:             .Column9.ControlSource         = "cursor_4c_Compo.etiq"
950: 
951:             *-- Col10: Consumo (N) W:65
952:             .Column10.Header1.Caption      = "Consumo"
953:             .Column10.Width                = 65
954:             .Column10.ControlSource        = "cursor_4c_Compo.consumo"
955:             .Column10.Alignment            = 1
956: 
957:             *-- Col11: Qtde cons (N) W:60
958:             .Column11.Header1.Caption      = "Qtde."
959:             .Column11.Width                = 60
960:             .Column11.ControlSource        = "cursor_4c_Compo.qtd2"
961:             .Column11.Alignment            = 1
962: 
963:             *-- Col12: Un cons (C5) W:35 - readonly
964:             .Column12.Header1.Caption      = "Un"
965:             .Column12.Width                = 35
966:             .Column12.ControlSource        = "cursor_4c_Compo.uni2"
967:             .Column12.ReadOnly             = .T.
968: 
969:             *-- Col13: Ord (N) W:35
970:             .Column13.Header1.Caption      = "Ord"
971:             .Column13.Width                = 35
972:             .Column13.ControlSource        = "cursor_4c_Compo.ord"
973:             .Column13.Alignment            = 1
974: 
975:             *-- Col14: Material alt (C14) W:83
976:             .Column14.Header1.Caption      = "Material"
977:             .Column14.Width                = 83
978:             .Column14.ControlSource        = "cursor_4c_Compo.matrizes"
979:         ENDWITH
980:         BINDEVENT(loc_oPg.grd_4c_Compo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
981: 
982:         *----------------------------------------------------------------------
983:         *-- Botoes do grdCompo (cmdgCompo: 5 botoes, Right of grid)
984:         *-- Container em T:145 L:947 W:50 H:210 (cada botao 50x42)
985:         *----------------------------------------------------------------------
986:         loc_oPg.AddObject("cnt_4c_BotoesCompo", "Container")
987:         WITH loc_oPg.cnt_4c_BotoesCompo
988:             .Top         = 145
989:             .Left        = 947
990:             .Width       = 50
991:             .Height      = 210
992:             .BackStyle = 1
993:             .BackColor = RGB(53, 53, 53)

*-- Linhas 1104 a 1209:
1104:             .GridLineWidth = 1
1105:             .GridLineColor = RGB(238, 238, 238)
1106:             .RecordMark  = .F.
1107:             .DeleteMark  = .F.
1108:             .AllowRowSizing = .F.
1109:             .ReadOnly    = .F.
1110:             .BackColor   = RGB(255, 255, 255)
1111:             .ForeColor   = RGB(90, 90, 90)
1112:             .HighlightBackColor = RGB(220, 230, 242)
1113:             .HighlightForeColor = RGB(15, 41, 104)
1114:             .HighlightStyle = 2
1115:             .RowHeight   = 16
1116:             .ScrollBars  = 2
1117:             .Visible     = .T.
1118:         ENDWITH
1119: 
1120:         *-- RecordSource FORA do WITH
1121:         loc_oPg.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
1122: 
1123:         *-- Configurar colunas do grd_4c_SubCp APOS RecordSource
1124:         WITH loc_oPg.grd_4c_SubCp
1125:             .Column1.Header1.Caption       = "Material"
1126:             .Column1.Width                 = 75
1127:             .Column1.ControlSource         = "cursor_4c_SubCp.mats"
1128: 
1129:             .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
1130:             .Column2.Width                 = 175
1131:             .Column2.ControlSource         = "cursor_4c_SubCp.dcomps"
1132:             .Column2.Alignment             = 0
1133: 
1134:             .Column3.Header1.Caption       = "Un"
1135:             .Column3.Width                 = 30
1136:             .Column3.ControlSource         = "cursor_4c_SubCp.unicompos"
1137:             .Column3.ReadOnly              = .T.
1138: 
1139:             .Column4.Header1.Caption       = "Valor"
1140:             .Column4.Width                 = 60
1141:             .Column4.ControlSource         = "cursor_4c_SubCp.pcompos"
1142:             .Column4.Alignment             = 1
1143: 
1144:             .Column5.Header1.Caption       = "Qtde."
1145:             .Column5.Width                 = 55
1146:             .Column5.ControlSource         = "cursor_4c_SubCp.qtds"
1147:             .Column5.Alignment             = 1
1148: 
1149:             .Column6.Header1.Caption       = "Total"
1150:             .Column6.Width                 = 60
1151:             .Column6.ControlSource         = "cursor_4c_SubCp.totals"
1152:             .Column6.Alignment             = 1
1153:             .Column6.ReadOnly              = .T.
1154: 
1155:             .Column7.Header1.Caption       = "Moe"
1156:             .Column7.Width                 = 30
1157:             .Column7.ControlSource         = "cursor_4c_SubCp.bloqueio"
1158: 
1159:             .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
1160:             .Column8.Width                 = 90
1161:             .Column8.ControlSource         = "cursor_4c_SubCp.obscompos"
1162:             .Column8.Alignment             = 0
1163: 
1164:             .Column9.Header1.Caption       = "E"
1165:             .Column9.Width                 = 25
1166:             .Column9.ControlSource         = "cursor_4c_SubCp.etiq"
1167: 
1168:             .Column10.Header1.Caption      = "Consumo"
1169:             .Column10.Width                = 60
1170:             .Column10.ControlSource        = "cursor_4c_SubCp.consumo"
1171:             .Column10.Alignment            = 1
1172: 
1173:             .Column11.Header1.Caption      = "Qtde."
1174:             .Column11.Width                = 55
1175:             .Column11.ControlSource        = "cursor_4c_SubCp.qtd2"
1176:             .Column11.Alignment            = 1
1177: 
1178:             .Column12.Header1.Caption      = "Un"
1179:             .Column12.Width                = 30
1180:             .Column12.ControlSource        = "cursor_4c_SubCp.uni2"
1181:             .Column12.ReadOnly             = .T.
1182: 
1183:             .Column13.Header1.Caption      = "Ord"
1184:             .Column13.Width                = 30
1185:             .Column13.ControlSource        = "cursor_4c_SubCp.ord"
1186:             .Column13.Alignment            = 1
1187: 
1188:             .Column14.Header1.Caption      = "Material"
1189:             .Column14.Width                = 80
1190:             .Column14.ControlSource        = "cursor_4c_SubCp.matrizes"
1191: 
1192:             .Column15.Header1.Caption      = "Tam"
1193:             .Column15.Width                = 88
1194:             .Column15.ControlSource        = "cursor_4c_SubCp.tamanhos"
1195:             .Column15.Alignment            = 0
1196:         ENDWITH
1197:         BINDEVENT(loc_oPg.grd_4c_SubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
1198: 
1199:         *----------------------------------------------------------------------
1200:         *-- Botoes do grdsubcp (cmdgSubCp: 2 botoes, Right of grid)
1201:         *-- Container em T:345 L:947 W:50 H:90 (cada botao 50x45)
1202:         *----------------------------------------------------------------------
1203:         loc_oPg.AddObject("cnt_4c_BotoesSubCp", "Container")
1204:         WITH loc_oPg.cnt_4c_BotoesSubCp
1205:             .Top         = 345
1206:             .Left        = 947
1207:             .Width       = 50
1208:             .Height      = 90
1209:             .BackStyle = 1

*-- Linhas 1332 a 1379:
1332:             .GridLineWidth = 1
1333:             .GridLineColor = RGB(238, 238, 238)
1334:             .RecordMark  = .F.
1335:             .DeleteMark  = .F.
1336:             .AllowRowSizing = .F.
1337:             .ReadOnly    = .T.
1338:             .BackColor   = RGB(255, 255, 255)
1339:             .ForeColor   = RGB(90, 90, 90)
1340:             .HighlightBackColor = RGB(220, 230, 242)
1341:             .HighlightForeColor = RGB(15, 41, 104)
1342:             .HighlightStyle = 2
1343:             .RowHeight   = 16
1344:             .ScrollBars  = 2
1345:             .Visible     = .T.
1346:         ENDWITH
1347: 
1348:         *-- RecordSource FORA do WITH
1349:         loc_oPg.grd_4c_Grupo.RecordSource = "cursor_4c_Grupo"
1350: 
1351:         *-- Colunas do GradeGRUPO APOS RecordSource
1352:         WITH loc_oPg.grd_4c_Grupo
1353:             .Column1.Header1.Caption = "Grupo"
1354:             .Column1.Width           = 50
1355:             .Column1.ControlSource   = "cursor_4c_Grupo.cgrus"
1356: 
1357:             .Column2.Header1.Caption = "Total "
1358:             .Column2.Width           = 100
1359:             .Column2.ControlSource   = "cursor_4c_Grupo.valgr"
1360:             .Column2.Alignment       = 1
1361: 
1362:             .Column3.Header1.Caption = "Moeda"
1363:             .Column3.Width           = 79
1364:             .Column3.ControlSource   = "cursor_4c_Grupo.moeds"
1365:         ENDWITH
1366: 
1367:         *----------------------------------------------------------------------
1368:         *-- Labels de secao Custo / Venda
1369:         *-- Say1: " Custo " (T:473 L:47 W:46 - secao de custo)
1370:         *-- Say2: " Venda " (T:474 L:361 W:48 - secao de venda)
1371:         *----------------------------------------------------------------------
1372:         loc_oPg.AddObject("lbl_4c_SecCusto", "Label")
1373:         WITH loc_oPg.lbl_4c_SecCusto
1374:             .Caption   = " Custo "
1375:             .Top       = 473
1376:             .Left      = 47
1377:             .Width     = 46
1378:             .Height    = 16
1379:             .FontName  = "Tahoma"

*-- Linhas 2554 a 2594:
2554:                 RETURN
2555:             ENDIF
2556:             IF USED("cursor_4c_Compo")
2557:                 SELECT cursor_4c_Compo
2558:                 APPEND BLANK
2559:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2560:             ENDIF
2561:         CATCH TO loc_oErro
2562:             MsgErro(loc_oErro.Message, "Erro ao inserir componente")
2563:         ENDTRY
2564:     ENDPROC
2565: 
2566:     *--------------------------------------------------------------------------
2567:     * CmdExcluirCompoClick - Remove linha da composicao
2568:     *--------------------------------------------------------------------------
2569:     PROCEDURE CmdExcluirCompoClick()
2570:         LOCAL loc_lConfirma
2571:         TRY
2572:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2573:                 RETURN
2574:             ENDIF
2575:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
2576:                 loc_lConfirma = MsgConfirma("Excluir componente selecionado?")
2577:                 IF loc_lConfirma
2578:                     SELECT cursor_4c_Compo
2579:                     DELETE
2580:                     IF !EOF()
2581:                         SKIP
2582:                         SKIP -1
2583:                     ENDIF
2584:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2585:                 ENDIF
2586:             ENDIF
2587:         CATCH TO loc_oErro
2588:             MsgErro(loc_oErro.Message, "Erro ao excluir componente")
2589:         ENDTRY
2590:     ENDPROC
2591: 
2592:     *--------------------------------------------------------------------------
2593:     * CmdCalcFornecClick - Recalcula precos de custo via fornecedor
2594:     *--------------------------------------------------------------------------

*-- Linhas 2649 a 2667:
2649:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo") AND ;
2650:                !EMPTY(cursor_4c_Compo.mats)
2651:                 IF USED("cursor_4c_SubCp")
2652:                     SELECT cursor_4c_SubCp
2653:                     APPEND BLANK
2654:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2655:                 ENDIF
2656:             ELSE
2657:                 MsgAviso("Selecione um componente antes de adicionar sub-componente.")
2658:             ENDIF
2659:         CATCH TO loc_oErro
2660:             MsgErro(loc_oErro.Message, "Erro ao inserir sub-componente")
2661:         ENDTRY
2662:     ENDPROC
2663: 
2664:     *--------------------------------------------------------------------------
2665:     * CmdExcluirSubCpClick - Remove linha do grid de sub-componentes
2666:     *--------------------------------------------------------------------------
2667:     PROCEDURE CmdExcluirSubCpClick()

*-- Linhas 2673 a 2692:
2673:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
2674:                 loc_lConfirma = MsgConfirma("Excluir sub-componente selecionado?")
2675:                 IF loc_lConfirma
2676:                     SELECT cursor_4c_SubCp
2677:                     DELETE
2678:                     IF !EOF()
2679:                         SKIP
2680:                         SKIP -1
2681:                     ENDIF
2682:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2683:                 ENDIF
2684:             ENDIF
2685:         CATCH TO loc_oErro
2686:             MsgErro(loc_oErro.Message, "Erro ao excluir sub-componente")
2687:         ENDTRY
2688:     ENDPROC
2689: 
2690:     *--------------------------------------------------------------------------
2691:     * CmdCalcValsClick - Calcular valores de preco/custo/venda
2692:     *--------------------------------------------------------------------------

*-- Linhas 2852 a 2885:
2852:     ENDPROC
2853: 
2854:     *--------------------------------------------------------------------------
2855:     * ValidarMoedaCompo - Valida codigo de moeda via SQLEXEC
2856:     *--------------------------------------------------------------------------
2857:     PROCEDURE ValidarMoedaCompo(par_cCampo)
2858:         LOCAL loc_oPg, loc_oCtrl, loc_cMoe, loc_nRet
2859:         TRY
2860:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
2861:                 RETURN
2862:             ENDIF
2863:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2864:             loc_oCtrl = EVALUATE("loc_oPg." + par_cCampo)
2865:             loc_cMoe  = ALLTRIM(loc_oCtrl.Value)
2866:             IF EMPTY(loc_cMoe)
2867:                 RETURN
2868:             ENDIF
2869:             loc_nRet = SQLEXEC(gnConnHandle, ;
2870:                 "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoe), ;
2871:                 "cursor_4c_TmpMoe")
2872:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_TmpMoe") < 1
2873:                 MsgAviso("Moeda '" + loc_cMoe + "' n" + CHR(227) + "o encontrada!")
2874:                 loc_oCtrl.Value = ""
2875:             ENDIF
2876:             IF USED("cursor_4c_TmpMoe")
2877:                 USE IN cursor_4c_TmpMoe
2878:             ENDIF
2879:         CATCH TO loc_oErro
2880:             MsgErro(loc_oErro.Message, "Erro ao validar moeda")
2881:         ENDTRY
2882:     ENDPROC
2883: 
2884:     *--------------------------------------------------------------------------
2885:     * CalcPrecoCompo - Chama calculo de preco pelo BO

*-- Linhas 2936 a 2955:
2936:             ENDIF
2937:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2938:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_GetCmkpc.Value)
2939:             loc_nRet = SQLEXEC(gnConnHandle, ;
2940:                 "SELECT Cods, Descs, Moedas, Valors, TpFtios FROM SigPrFti WHERE Tipos = 1", ;
2941:                 "cursor_4c_ListaFtioCusto")
2942:             IF loc_nRet > 0
2943:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2944:                     "SigPrFti", "cursor_4c_BuscaFtioCusto", "Cods", loc_cAtual, ;
2945:                     "Fator de Custo")
2946:                 IF VARTYPE(loc_oBusca) = "O"
2947:                     IF !loc_oBusca.this_lAchouRegistro
2948:                         loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "d.")
2949:                         loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2950:                         loc_oBusca.mAddColuna("Moedas", "", "Moeda")
2951:                         loc_oBusca.Show()
2952:                     ENDIF
2953:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioCusto")
2954:                         loc_oPg.txt_4c_GetCmkpc.Value = ALLTRIM(cursor_4c_BuscaFtioCusto.Cods)
2955:                     ENDIF

*-- Linhas 3015 a 3034:
3015:             ENDIF
3016:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3017:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Getftio.Value)
3018:             loc_nRet = SQLEXEC(gnConnHandle, ;
3019:                 "SELECT Cods, Descs FROM SigPrFti", ;
3020:                 "cursor_4c_ListaFtioVenda")
3021:             IF loc_nRet > 0
3022:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3023:                     "SigPrFti", "cursor_4c_BuscaFtioVenda", "Cods", loc_cAtual, ;
3024:                     "Fator de Venda")
3025:                 IF VARTYPE(loc_oBusca) = "O"
3026:                     IF !loc_oBusca.this_lAchouRegistro
3027:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
3028:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3029:                         loc_oBusca.Show()
3030:                     ENDIF
3031:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioVenda")
3032:                         loc_oPg.txt_4c_Getftio.Value = ALLTRIM(cursor_4c_BuscaFtioVenda.Cods)
3033:                     ENDIF
3034:                     loc_oBusca.Release()

*-- Linhas 3079 a 3098:
3079:             IF EMPTY(loc_cSts)
3080:                 RETURN
3081:             ENDIF
3082:             loc_nRet = SQLEXEC(gnConnHandle, ;
3083:                 "SELECT Cods FROM SigCdPst WHERE Cods = " + EscaparSQL(loc_cSts), ;
3084:                 "cursor_4c_TmpSts")
3085:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_TmpSts") < 1
3086:                 MsgAviso("Status '" + loc_cSts + "' n" + CHR(227) + "o encontrado!")
3087:                 loc_oPg.txt_4c_GetStatus.Value = ""
3088:             ENDIF
3089:             IF USED("cursor_4c_TmpSts")
3090:                 USE IN cursor_4c_TmpSts
3091:             ENDIF
3092:         CATCH TO loc_oErro
3093:             MsgErro(loc_oErro.Message, "Erro ao validar status")
3094:         ENDTRY
3095:     ENDPROC
3096: 
3097:     PROCEDURE AbrirLookupStatusCompo()
3098:         LOCAL loc_oPg, loc_oBusca, loc_cAtual

*-- Linhas 3186 a 3205:
3186:                 loc_oPg.txt_4c_Desc.Value = ""
3187:                 RETURN
3188:             ENDIF
3189:             loc_nRet = SQLEXEC(gnConnHandle, ;
3190:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cMatP), ;
3191:                 "cursor_4c_TmpMatP")
3192:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpMatP") > 0
3193:                 loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_TmpMatP.dpros)
3194:             ELSE
3195:                 MsgAviso("Produto '" + loc_cMatP + "' n" + CHR(227) + "o encontrado!")
3196:                 loc_oPg.txt_4c_MatP.Value = ""
3197:                 loc_oPg.txt_4c_Desc.Value = ""
3198:             ENDIF
3199:             IF USED("cursor_4c_TmpMatP")
3200:                 USE IN cursor_4c_TmpMatP
3201:             ENDIF
3202:         CATCH TO loc_oErro
3203:             MsgErro(loc_oErro.Message, "Erro ao validar material principal")
3204:         ENDTRY
3205:     ENDPROC

*-- Linhas 3265 a 3283:
3265:             *-- Construir WHERE clause
3266:             loc_cFiltro = "situas BETWEEN " + TRANSFORM(loc_nSitI) + " AND " + TRANSFORM(loc_nSitF)
3267:             IF !EMPTY(loc_cCgru)
3268:                 loc_cFiltro = loc_cFiltro + " AND cgrus = " + EscaparSQL(loc_cCgru)
3269:             ENDIF
3270: 
3271:             *-- Buscar dados via BO (ZAP+APPEND preserva estrutura do cursor/grid)
3272:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
3273: 
3274:                 *-- Redefinir headers APOS cada Buscar() (VFP9 pode resetar)
3275:                 IF VARTYPE(loc_oPagina.grd_4c_Lista) = "O"
3276:                     loc_oGrid = loc_oPagina.grd_4c_Lista
3277:                     loc_oGrid.Column1.Header1.Caption = "Produto"
3278:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3279:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
3280:                     loc_oGrid.Column4.Header1.Caption = "Subgrupo"
3281:                     loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
3282:                     loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
3283:                     loc_oGrid.Column7.Header1.Caption = "I"

*-- Linhas 3347 a 3366:
3347: 
3348:         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3349:             TRY
3350:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3351:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
3352:                     "cursor_4c_TmpGrupo")
3353: 
3354:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGrupo") > 0
3355:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_TmpGrupo.dgrus)
3356:                 ELSE
3357:                     MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
3358:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value = ""
3359:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
3360:                 ENDIF
3361: 
3362:                 IF USED("cursor_4c_TmpGrupo")
3363:                     USE IN cursor_4c_TmpGrupo
3364:                 ENDIF
3365:             CATCH TO loc_oErro
3366:                 MsgErro(loc_oErro.Message, "Erro ao validar grupo")

*-- Linhas 3470 a 3488:
3470:             .GridLineWidth      = 1
3471:             .GridLineColor      = RGB(238, 238, 238)
3472:             .RecordMark         = .F.
3473:             .DeleteMark         = .F.
3474:             .AllowRowSizing     = .F.
3475:             .ReadOnly           = .T.
3476:             .BackColor          = RGB(255, 255, 255)
3477:             .ForeColor          = RGB(90, 90, 90)
3478:             .HighlightBackColor = RGB(255, 255, 255)
3479:             .HighlightForeColor = RGB(15, 41, 104)
3480:             .HighlightStyle     = 2
3481:             .RowHeight          = 16
3482:             .ScrollBars         = 2
3483:         ENDWITH
3484:     ENDPROC
3485: 
3486:     *--------------------------------------------------------------------------
3487:     * BtnIncluirClick - Incluir novo produto
3488:     *--------------------------------------------------------------------------

*-- Linhas 4612 a 4688:
4612:             *-- Descricao do Grupo (cgrus -> SigCdGrp.dgrus)
4613:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4614:             IF !EMPTY(loc_cCod)
4615:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4616:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
4617:                     "cursor_4c_TmpDgru")
4618:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpDgru") > 0
4619:                     loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpDgru.dgrus)
4620:                 ENDIF
4621:                 IF USED("cursor_4c_TmpDgru")
4622:                     USE IN cursor_4c_TmpDgru
4623:                 ENDIF
4624:             ENDIF
4625: 
4626:             *-- Descricao do SubGrupo (sgrus -> SigCdPsg.descricaos, filtrado por cgrus)
4627:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4628:             IF !EMPTY(loc_cCod)
4629:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4630:                     "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cCod) + ;
4631:                     " AND cgrus = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CgruP.Value)), ;
4632:                     "cursor_4c_TmpSGru")
4633:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4634:                     loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4635:                 ENDIF
4636:                 IF USED("cursor_4c_TmpSGru")
4637:                     USE IN cursor_4c_TmpSGru
4638:                 ENDIF
4639:             ENDIF
4640: 
4641:             *-- Descricao da Linha (linhas -> SigCdLin.descs)
4642:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4643:             IF !EMPTY(loc_cCod)
4644:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4645:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
4646:                     "cursor_4c_TmpLin")
4647:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLin") > 0
4648:                     loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_TmpLin.descs)
4649:                 ENDIF
4650:                 IF USED("cursor_4c_TmpLin")
4651:                     USE IN cursor_4c_TmpLin
4652:                 ENDIF
4653:             ENDIF
4654: 
4655:             *-- Descricao do Grupo de Venda (colecoes -> SIGCDCOL.descs)
4656:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Col.Value)
4657:             IF !EMPTY(loc_cCod)
4658:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4659:                     "SELECT descs FROM SIGCDCOL WHERE colecoes = " + EscaparSQL(loc_cCod), ;
4660:                     "cursor_4c_TmpCol")
4661:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCol") > 0
4662:                     loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_TmpCol.descs)
4663:                 ENDIF
4664:                 IF USED("cursor_4c_TmpCol")
4665:                     USE IN cursor_4c_TmpCol
4666:                 ENDIF
4667:             ENDIF
4668: 
4669:             *-- Descricao do Fornecedor (ifors -> SigCdCli.rclis)
4670:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
4671:             IF !EMPTY(loc_cCod)
4672:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4673:                     "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCod), ;
4674:                     "cursor_4c_TmpIfor")
4675:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpIfor") > 0
4676:                     loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_TmpIfor.rclis)
4677:                 ENDIF
4678:                 IF USED("cursor_4c_TmpIfor")
4679:                     USE IN cursor_4c_TmpIfor
4680:                 ENDIF
4681:             ENDIF
4682: 
4683:         CATCH TO loc_oErro
4684:             MsgErro(loc_oErro.Message, "Erro ao preencher descri" + CHR(231) + CHR(245) + "es")
4685:         ENDTRY
4686:     ENDPROC
4687: 
4688:     *==========================================================================

*-- Linhas 4713 a 4732:
4713:         ENDIF
4714: 
4715:         TRY
4716:             loc_nRet = SQLEXEC(gnConnHandle, ;
4717:                 "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
4718:                 "cursor_4c_TmpGruP")
4719:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGruP") > 0
4720:                 loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpGruP.dgrus)
4721:                 *-- Limpar subgrupo ao trocar grupo
4722:                 loc_oPg.txt_4c_CSGru.Value = ""
4723:                 loc_oPg.txt_4c_DsGru.Value = ""
4724:             ELSE
4725:                 MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
4726:                 loc_oPg.txt_4c_CgruP.Value = ""
4727:                 loc_oPg.txt_4c_DgruP.Value = ""
4728:             ENDIF
4729:             IF USED("cursor_4c_TmpGruP")
4730:                 USE IN cursor_4c_TmpGruP
4731:             ENDIF
4732:         CATCH TO loc_oErro

*-- Linhas 4798 a 4818:
4798:         ENDIF
4799: 
4800:         TRY
4801:             loc_nRet = SQLEXEC(gnConnHandle, ;
4802:                 "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cSGru) + ;
4803:                 IIF(EMPTY(loc_cCgru), "", " AND cgrus = " + EscaparSQL(loc_cCgru)), ;
4804:                 "cursor_4c_TmpSGru")
4805:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4806:                 loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4807:             ELSE
4808:                 MsgAviso("Subgrupo '" + loc_cSGru + "' n" + CHR(227) + "o encontrado!")
4809:                 loc_oPg.txt_4c_CSGru.Value = ""
4810:                 loc_oPg.txt_4c_DsGru.Value = ""
4811:             ENDIF
4812:             IF USED("cursor_4c_TmpSGru")
4813:                 USE IN cursor_4c_TmpSGru
4814:             ENDIF
4815:         CATCH TO loc_oErro
4816:             MsgErro(loc_oErro.Message, "Erro ao validar subgrupo")
4817:         ENDTRY
4818:     ENDPROC

*-- Linhas 4827 a 4845:
4827:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4828:                 "SigCdPsg", "cursor_4c_BuscaSGru", "codigos", loc_cAtual, ;
4829:                 "Buscar Subgrupo", .F., .T., ;
4830:                 IIF(EMPTY(loc_cCgru), "", "cgrus = " + EscaparSQL(loc_cCgru)))
4831:             IF VARTYPE(loc_oBusca) = "O"
4832:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4833:                     IF USED("cursor_4c_BuscaSGru")
4834:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4835:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4836:                     ENDIF
4837:                 ELSE
4838:                     IF !loc_oBusca.this_lAchouRegistro
4839:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
4840:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4841:                     loc_oBusca.Show()
4842:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
4843:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4844:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4845:                     ENDIF

*-- Linhas 4878 a 4897:
4878:         ENDIF
4879: 
4880:         TRY
4881:             loc_nRet = SQLEXEC(gnConnHandle, ;
4882:                 "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cLin), ;
4883:                 "cursor_4c_TmpLin")
4884:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLin") > 0
4885:                 loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_TmpLin.descs)
4886:             ELSE
4887:                 MsgAviso("Linha '" + loc_cLin + "' n" + CHR(227) + "o encontrada!")
4888:                 loc_oPg.txt_4c_Lin.Value  = ""
4889:                 loc_oPg.txt_4c_DLin.Value = ""
4890:             ENDIF
4891:             IF USED("cursor_4c_TmpLin")
4892:                 USE IN cursor_4c_TmpLin
4893:             ENDIF
4894:         CATCH TO loc_oErro
4895:             MsgErro(loc_oErro.Message, "Erro ao validar linha")
4896:         ENDTRY
4897:     ENDPROC

*-- Linhas 4955 a 4974:
4955:         ENDIF
4956: 
4957:         TRY
4958:             loc_nRet = SQLEXEC(gnConnHandle, ;
4959:                 "SELECT descs FROM SIGCDCOL WHERE colecoes = " + EscaparSQL(loc_cCol), ;
4960:                 "cursor_4c_TmpCol")
4961:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCol") > 0
4962:                 loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_TmpCol.descs)
4963:             ELSE
4964:                 MsgAviso("Grupo de Venda '" + loc_cCol + "' n" + CHR(227) + "o encontrado!")
4965:                 loc_oPg.txt_4c_Col.Value  = ""
4966:                 loc_oPg.txt_4c_DCol.Value = ""
4967:             ENDIF
4968:             IF USED("cursor_4c_TmpCol")
4969:                 USE IN cursor_4c_TmpCol
4970:             ENDIF
4971:         CATCH TO loc_oErro
4972:             MsgErro(loc_oErro.Message, "Erro ao validar grupo de venda")
4973:         ENDTRY
4974:     ENDPROC

*-- Linhas 5032 a 5051:
5032:         ENDIF
5033: 
5034:         TRY
5035:             loc_nRet = SQLEXEC(gnConnHandle, ;
5036:                 "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cIfor), ;
5037:                 "cursor_4c_TmpIfor")
5038:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpIfor") > 0
5039:                 loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_TmpIfor.rclis)
5040:             ELSE
5041:                 MsgAviso("Fornecedor '" + loc_cIfor + "' n" + CHR(227) + "o encontrado!")
5042:                 loc_oPg.txt_4c_Ifor.Value = ""
5043:                 loc_oPg.txt_4c_Dfor.Value = ""
5044:             ENDIF
5045:             IF USED("cursor_4c_TmpIfor")
5046:                 USE IN cursor_4c_TmpIfor
5047:             ENDIF
5048:         CATCH TO loc_oErro
5049:             MsgErro(loc_oErro.Message, "Erro ao validar fornecedor")
5050:         ENDTRY
5051:     ENDPROC

*-- Linhas 5108 a 5127:
5108:         ENDIF
5109: 
5110:         TRY
5111:             loc_nRet = SQLEXEC(gnConnHandle, ;
5112:                 "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpro), ;
5113:                 "cursor_4c_TmpProEq")
5114:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpProEq") = 0
5115:                 MsgAviso("Produto equivalente '" + loc_cCpro + "' n" + CHR(227) + "o encontrado!")
5116:                 loc_oPg.txt_4c_CProEq.Value = ""
5117:             ENDIF
5118:             IF USED("cursor_4c_TmpProEq")
5119:                 USE IN cursor_4c_TmpProEq
5120:             ENDIF
5121:         CATCH TO loc_oErro
5122:             MsgErro(loc_oErro.Message, "Erro ao validar produto equivalente")
5123:         ENDTRY
5124:     ENDPROC
5125: 
5126:     PROCEDURE AbrirLookupProdEq()
5127:         LOCAL loc_oBusca, loc_oPg, loc_cAtual

*-- Linhas 5176 a 5195:
5176: 
5177:         TRY
5178:             *-- Busca conjuntos distintos ja cadastrados em SigCdPro
5179:             loc_nRet = SQLEXEC(gnConnHandle, ;
5180:                 "SELECT DISTINCT conjunts FROM SigCdPro WHERE LTRIM(RTRIM(conjunts)) <> '' ORDER BY conjunts", ;
5181:                 "cursor_4c_BuscaCnj")
5182: 
5183:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaCnj") > 0
5184:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5185:                 IF VARTYPE(loc_oBusca) = "O"
5186:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCnj"
5187:                     loc_oBusca.this_cTitulo        = "Buscar Conjunto"
5188:                     loc_oBusca.mAddColuna("conjunts", "", "Conjunto")
5189:                     loc_oBusca.Show()
5190:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnj")
5191:                         loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_BuscaCnj.conjunts)
5192:                     ENDIF
5193:                     loc_oBusca.Release()
5194:                 ENDIF
5195:             ENDIF

*-- Linhas 6663 a 6754:
6663:             *-- Descricao Unidade 1 (cunis -> SigCdUni.dunis)
6664:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6665:             IF !EMPTY(loc_cCod)
6666:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6667:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6668:                     "cursor_4c_TmpUni")
6669:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUni") > 0
6670:                     loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpUni.dunis)
6671:                 ENDIF
6672:                 IF USED("cursor_4c_TmpUni")
6673:                     USE IN cursor_4c_TmpUni
6674:                 ENDIF
6675:             ENDIF
6676: 
6677:             *-- Descricao Unidade 2 (cunips -> SigCdUni.dunis)
6678:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6679:             IF !EMPTY(loc_cCod)
6680:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6681:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6682:                     "cursor_4c_TmpUnip")
6683:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUnip") > 0
6684:                     loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpUnip.dunis)
6685:                 ENDIF
6686:                 IF USED("cursor_4c_TmpUnip")
6687:                     USE IN cursor_4c_TmpUnip
6688:                 ENDIF
6689:             ENDIF
6690: 
6691:             *-- Descricao Modelo (codfinp -> SigCdFip.descs)
6692:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6693:             IF !EMPTY(loc_cCod)
6694:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6695:                     "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6696:                     "cursor_4c_TmpFinP")
6697:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6698:                     loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6699:                 ENDIF
6700:                 IF USED("cursor_4c_TmpFinP")
6701:                     USE IN cursor_4c_TmpFinP
6702:                 ENDIF
6703:             ENDIF
6704: 
6705:             *-- Descricao Acabamento (codacbs -> SigCdAca.descrs)
6706:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
6707:             IF !EMPTY(loc_cCod)
6708:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6709:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
6710:                     "cursor_4c_TmpAcb")
6711:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
6712:                     loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
6713:                 ENDIF
6714:                 IF USED("cursor_4c_TmpAcb")
6715:                     USE IN cursor_4c_TmpAcb
6716:                 ENDIF
6717:             ENDIF
6718: 
6719:             *-- Descricao Classificacao (cclass -> SigCdCls.descs, filtrado por cgrus)
6720:             loc_cCod  = ALLTRIM(loc_oPg.txt_4c_Class.Value)
6721:             loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
6722:             IF !EMPTY(loc_cCod)
6723:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6724:                     "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
6725:                     IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
6726:                     "cursor_4c_TmpClass")
6727:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
6728:                     loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
6729:                 ENDIF
6730:                 IF USED("cursor_4c_TmpClass")
6731:                     USE IN cursor_4c_TmpClass
6732:                 ENDIF
6733:             ENDIF
6734: 
6735:             *-- Descricao Local (locals -> SigPrLcl.descricaos)
6736:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Local.Value)
6737:             IF !EMPTY(loc_cCod)
6738:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6739:                     "SELECT descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
6740:                     "cursor_4c_TmpLocal")
6741:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLocal") > 0
6742:                     *-- Local nao tem campo descricao visivel separado, apenas atualiza silenciosamente
6743:                     *-- O campo txt_4c_Local ja exibe o codigo (10 chars)
6744:                 ENDIF
6745:                 IF USED("cursor_4c_TmpLocal")
6746:                     USE IN cursor_4c_TmpLocal
6747:                 ENDIF
6748:             ENDIF
6749: 
6750:         CATCH TO loc_oErro
6751:             MsgErro(loc_oErro.Message, "Erro ao preencher descri" + CHR(231) + CHR(245) + "es P2")
6752:         ENDTRY
6753:     ENDPROC
6754: 

*-- Linhas 6780 a 6799:
6780:         ENDIF
6781: 
6782:         TRY
6783:             loc_nRet = SQLEXEC(gnConnHandle, ;
6784:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCuni), ;
6785:                 "cursor_4c_TmpCuni")
6786:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCuni") > 0
6787:                 loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpCuni.dunis)
6788:             ELSE
6789:                 MsgAviso("Unidade '" + loc_cCuni + "' n" + CHR(227) + "o encontrada!")
6790:                 loc_oPg.txt_4c_Cuni.Value = ""
6791:                 loc_oPg.txt_4c_DUni.Value = ""
6792:             ENDIF
6793:             IF USED("cursor_4c_TmpCuni")
6794:                 USE IN cursor_4c_TmpCuni
6795:             ENDIF
6796:         CATCH TO loc_oErro
6797:             MsgErro(loc_oErro.Message, "Erro ao validar unidade")
6798:         ENDTRY
6799:     ENDPROC

*-- Linhas 6857 a 6876:
6857:         ENDIF
6858: 
6859:         TRY
6860:             loc_nRet = SQLEXEC(gnConnHandle, ;
6861:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCunip), ;
6862:                 "cursor_4c_TmpCunip")
6863:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCunip") > 0
6864:                 loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpCunip.dunis)
6865:             ELSE
6866:                 MsgAviso("Unidade '" + loc_cCunip + "' n" + CHR(227) + "o encontrada!")
6867:                 loc_oPg.txt_4c_Cunip.Value = ""
6868:                 loc_oPg.txt_4c_DUnip.Value = ""
6869:             ENDIF
6870:             IF USED("cursor_4c_TmpCunip")
6871:                 USE IN cursor_4c_TmpCunip
6872:             ENDIF
6873:         CATCH TO loc_oErro
6874:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
6875:         ENDTRY
6876:     ENDPROC

*-- Linhas 6934 a 6953:
6934:         ENDIF
6935: 
6936:         TRY
6937:             loc_nRet = SQLEXEC(gnConnHandle, ;
6938:                 "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6939:                 "cursor_4c_TmpFinP")
6940:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6941:                 loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6942:             ELSE
6943:                 MsgAviso("Modelo '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
6944:                 loc_oPg.txt_4c_CodFinP.Value = ""
6945:                 loc_oPg.txt_4c_DFinP.Value   = ""
6946:             ENDIF
6947:             IF USED("cursor_4c_TmpFinP")
6948:                 USE IN cursor_4c_TmpFinP
6949:             ENDIF
6950:         CATCH TO loc_oErro
6951:             MsgErro(loc_oErro.Message, "Erro ao validar modelo")
6952:         ENDTRY
6953:     ENDPROC

*-- Linhas 7011 a 7030:
7011:         ENDIF
7012: 
7013:         TRY
7014:             loc_nRet = SQLEXEC(gnConnHandle, ;
7015:                 "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
7016:                 "cursor_4c_TmpAcb")
7017:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
7018:                 loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
7019:             ELSE
7020:                 MsgAviso("Acabamento '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7021:                 loc_oPg.txt_4c_CodAcb.Value = ""
7022:                 loc_oPg.txt_4c_DAcb.Value   = ""
7023:             ENDIF
7024:             IF USED("cursor_4c_TmpAcb")
7025:                 USE IN cursor_4c_TmpAcb
7026:             ENDIF
7027:         CATCH TO loc_oErro
7028:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
7029:         ENDTRY
7030:     ENDPROC

*-- Linhas 7090 a 7110:
7090:         ENDIF
7091: 
7092:         TRY
7093:             loc_nRet = SQLEXEC(gnConnHandle, ;
7094:                 "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
7095:                 IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
7096:                 "cursor_4c_TmpClass")
7097:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
7098:                 loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
7099:             ELSE
7100:                 MsgAviso("Classifica" + CHR(231) + CHR(227) + "o '" + loc_cCod + "' n" + CHR(227) + "o encontrada!")
7101:                 loc_oPg.txt_4c_Class.Value  = ""
7102:                 loc_oPg.txt_4c_DClass.Value = ""
7103:             ENDIF
7104:             IF USED("cursor_4c_TmpClass")
7105:                 USE IN cursor_4c_TmpClass
7106:             ENDIF
7107:         CATCH TO loc_oErro
7108:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
7109:         ENDTRY
7110:     ENDPROC

*-- Linhas 7119 a 7137:
7119:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7120:                 "SigCdCls", "cursor_4c_BuscaClass", "cods", loc_cAtual, ;
7121:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o", .F., .T., ;
7122:                 IIF(EMPTY(loc_cCgru), "", "(cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"))
7123:             IF VARTYPE(loc_oBusca) = "O"
7124:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7125:                     IF USED("cursor_4c_BuscaClass")
7126:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7127:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7128:                     ENDIF
7129:                 ELSE
7130:                     IF !loc_oBusca.this_lAchouRegistro
7131:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
7132:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7133:                     loc_oBusca.Show()
7134:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
7135:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7136:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7137:                     ENDIF

*-- Linhas 7169 a 7188:
7169:         ENDIF
7170: 
7171:         TRY
7172:             loc_nRet = SQLEXEC(gnConnHandle, ;
7173:                 "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
7174:                 "cursor_4c_TmpLocal")
7175:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpLocal") = 0
7176:                 MsgAviso("Local '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7177:                 loc_oPg.txt_4c_Local.Value = ""
7178:             ENDIF
7179:             IF USED("cursor_4c_TmpLocal")
7180:                 USE IN cursor_4c_TmpLocal
7181:             ENDIF
7182:         CATCH TO loc_oErro
7183:             MsgErro(loc_oErro.Message, "Erro ao validar local")
7184:         ENDTRY
7185:     ENDPROC
7186: 
7187:     PROCEDURE AbrirLookupLocal()
7188:         LOCAL loc_oBusca, loc_oPg, loc_cAtual

*-- Linhas 7236 a 7273:
7236:         *----------------------------------------------------------------------
7237:         IF !USED("cursor_4c_GrdCons")
7238:             SET NULL ON
7239:             CREATE CURSOR cursor_4c_GrdCons (;
7240:                 mats      C(14), ;
7241:                 qtds      N(12,4), ;
7242:                 unicompos C(5), ;
7243:                 Grupos    C(3), ;
7244:                 Descrs    C(65), ;
7245:                 Ordems    N(5,0), ;
7246:                 consumo   N(12,4), ;
7247:                 Cods      C(5), ;
7248:                 dcats     C(65), ;
7249:                 Dopes     C(5))
7250:             SET NULL OFF
7251:         ENDIF
7252: 
7253:         *----------------------------------------------------------------------
7254:         *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
7255:         *----------------------------------------------------------------------
7256:         IF !USED("cursor_4c_GrDTEMP")
7257:             SET NULL ON
7258:             CREATE CURSOR cursor_4c_GrDTEMP (;
7259:                 agrup C(30), ;
7260:                 tempo N(12,4))
7261:             SET NULL OFF
7262:         ENDIF
7263: 
7264:         *----------------------------------------------------------------------
7265:         *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
7266:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
7267:         *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao
7268:         *----------------------------------------------------------------------
7269:         loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
7270:         loc_oGrd = loc_oPg.grd_4c_GrdCons
7271: 
7272:         WITH loc_oGrd
7273:             .Top              = 155

*-- Linhas 7281 a 7377:
7281:             .GridLineWidth    = 1
7282:             .GridLineColor    = RGB(238, 238, 238)
7283:             .RecordMark       = .F.
7284:             .DeleteMark       = .F.
7285:             .AllowRowSizing   = .F.
7286:             .ReadOnly         = .F.
7287:             .BackColor        = RGB(255, 255, 255)
7288:             .ForeColor        = RGB(90, 90, 90)
7289:             .HighlightBackColor = RGB(220, 230, 242)
7290:             .HighlightForeColor = RGB(15, 41, 104)
7291:             .HighlightStyle   = 2
7292:             .RowHeight        = 16
7293:             .ScrollBars       = 2
7294:             .Themes           = .F.
7295:             .Visible          = .T.
7296:         ENDWITH
7297: 
7298:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7299:         loc_oPg.grd_4c_GrdCons.RecordSource = "cursor_4c_GrdCons"
7300: 
7301:         *-- Configurar colunas APOS RecordSource
7302:         WITH loc_oPg.grd_4c_GrdCons
7303:             *-- Col1: Componente (mats C14) W:140 - readonly
7304:             .Column1.Header1.Caption = "Componente"
7305:             .Column1.Width           = 140
7306:             .Column1.ControlSource   = "cursor_4c_GrdCons.mats"
7307:             .Column1.Alignment       = 0
7308:             .Column1.ReadOnly        = .T.
7309: 
7310:             *-- Col2: Qtde. (qtds N) W:70 - readonly
7311:             .Column2.Header1.Caption = "Qtde."
7312:             .Column2.Width           = 70
7313:             .Column2.ControlSource   = "cursor_4c_GrdCons.qtds"
7314:             .Column2.Alignment       = 1
7315:             .Column2.ReadOnly        = .T.
7316: 
7317:             *-- Col3: Uni (unicompos C5) W:40 - readonly
7318:             .Column3.Header1.Caption = "Uni"
7319:             .Column3.Width           = 40
7320:             .Column3.ControlSource   = "cursor_4c_GrdCons.unicompos"
7321:             .Column3.Alignment       = 0
7322:             .Column3.ReadOnly        = .T.
7323: 
7324:             *-- Col4: Fase (Grupos C3) W:45 - editable, F4 abre lookup SigCdPrf
7325:             .Column4.Header1.Caption = "Fase"
7326:             .Column4.Width           = 45
7327:             .Column4.ControlSource   = "cursor_4c_GrdCons.Grupos"
7328:             .Column4.Alignment       = 0
7329:             .Column4.ReadOnly        = .F.
7330: 
7331:             *-- Col5: Descricao de fase (Descrs C65) W:250 - editable quando Col4 vazia
7332:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7333:             .Column5.Width           = 250
7334:             .Column5.ControlSource   = "cursor_4c_GrdCons.Descrs"
7335:             .Column5.Alignment       = 0
7336:             .Column5.ReadOnly        = .F.
7337: 
7338:             *-- Col6: Ord. (Ordems N) W:40 - readonly
7339:             .Column6.Header1.Caption = "Ord."
7340:             .Column6.Width           = 40
7341:             .Column6.ControlSource   = "cursor_4c_GrdCons.Ordems"
7342:             .Column6.Alignment       = 1
7343:             .Column6.ReadOnly        = .T.
7344: 
7345:             *-- Col7: Consumo (consumo N) W:80 - editable em INCLUIR/ALTERAR
7346:             .Column7.Header1.Caption = "Consumo"
7347:             .Column7.Width           = 80
7348:             .Column7.ControlSource   = "cursor_4c_GrdCons.consumo"
7349:             .Column7.Alignment       = 1
7350:             .Column7.ReadOnly        = .F.
7351: 
7352:             *-- Col8: Cat. (Cods C5) W:45 - editable, F4 abre lookup SigCdCat
7353:             .Column8.Header1.Caption = "Cat."
7354:             .Column8.Width           = 45
7355:             .Column8.ControlSource   = "cursor_4c_GrdCons.Cods"
7356:             .Column8.Alignment       = 0
7357:             .Column8.ReadOnly        = .F.
7358: 
7359:             *-- Col9: Descricao de categoria (dcats C65) W:277 - editable
7360:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7361:             .Column9.Width           = 277
7362:             .Column9.ControlSource   = "cursor_4c_GrdCons.dcats"
7363:             .Column9.Alignment       = 0
7364:             .Column9.ReadOnly        = .F.
7365:         ENDWITH
7366: 
7367:         *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
7368:         BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
7369:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
7370:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
7371:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
7372: 
7373:         *----------------------------------------------------------------------
7374:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7375:         *----------------------------------------------------------------------
7376:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7377:         WITH loc_oPg.lbl_4c_Label7

*-- Linhas 7464 a 7511:
7464:             .GridLineWidth    = 1
7465:             .GridLineColor    = RGB(238, 238, 238)
7466:             .RecordMark       = .F.
7467:             .DeleteMark       = .F.
7468:             .AllowRowSizing   = .F.
7469:             .ReadOnly         = .T.
7470:             .BackColor        = RGB(255, 255, 255)
7471:             .ForeColor        = RGB(90, 90, 90)
7472:             .HighlightBackColor = RGB(220, 230, 242)
7473:             .HighlightForeColor = RGB(15, 41, 104)
7474:             .HighlightStyle   = 2
7475:             .RowHeight        = 16
7476:             .ScrollBars       = 2
7477:             .Themes           = .F.
7478:             .Visible          = .T.
7479:         ENDWITH
7480: 
7481:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7482:         loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
7483: 
7484:         *-- Configurar colunas do grDTEMP APOS RecordSource
7485:         WITH loc_oPg.grd_4c_GrDTEMP
7486:             *-- Col1: Agrupamento (agrup C30) W:100 - readonly
7487:             .Column1.Header1.Caption = "Agrupamento"
7488:             .Column1.Width           = 100
7489:             .Column1.ControlSource   = "cursor_4c_GrDTEMP.agrup"
7490:             .Column1.Alignment       = 0
7491:             .Column1.ReadOnly        = .T.
7492: 
7493:             *-- Col2: Tempo % (tempo N) W:72 - readonly
7494:             .Column2.Header1.Caption = "Tempo %"
7495:             .Column2.Width           = 72
7496:             .Column2.ControlSource   = "cursor_4c_GrDTEMP.tempo"
7497:             .Column2.Alignment       = 1
7498:             .Column2.ReadOnly        = .T.
7499:         ENDWITH
7500: 
7501:     ENDPROC
7502: 
7503:     *==========================================================================
7504:     * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
7505:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
7506:     *==========================================================================
7507: 
7508:     *--------------------------------------------------------------------------
7509:     * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
7510:     *--------------------------------------------------------------------------
7511:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)

*-- Linhas 7544 a 7562:
7544:                     ENDIF
7545:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
7546:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7547:                             SELECT cursor_4c_GrdCons
7548:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
7549:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
7550:                         ENDIF
7551:                     ENDIF
7552:                     loc_oBusca.Release()
7553:                 ENDIF
7554:                 IF USED("cursor_4c_BuscaPrf")
7555:                     USE IN cursor_4c_BuscaPrf
7556:                 ENDIF
7557:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7558:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7559:                 ENDIF
7560:             CATCH TO loc_oErro
7561:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
7562:             ENDTRY

*-- Linhas 7600 a 7618:
7600:                     ENDIF
7601:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
7602:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7603:                             SELECT cursor_4c_GrdCons
7604:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
7605:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
7606:                             IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
7607:                                 REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
7608:                             ENDIF
7609:                             IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
7610:                                 REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
7611:                             ENDIF
7612:                         ENDIF
7613:                     ENDIF
7614:                     loc_oBusca.Release()
7615:                 ENDIF
7616:                 IF USED("cursor_4c_BuscaPrf2")
7617:                     USE IN cursor_4c_BuscaPrf2
7618:                 ENDIF

*-- Linhas 7652 a 7670:
7652:                     ENDIF
7653:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
7654:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7655:                             SELECT cursor_4c_GrdCons
7656:                             REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
7657:                             REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
7658:                         ENDIF
7659:                     ENDIF
7660:                     loc_oBusca.Release()
7661:                 ENDIF
7662:                 IF USED("cursor_4c_BuscaCat")
7663:                     USE IN cursor_4c_BuscaCat
7664:                 ENDIF
7665:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7666:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7667:                 ENDIF
7668:             CATCH TO loc_oErro
7669:                 MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
7670:             ENDTRY

*-- Linhas 7742 a 7846:
7742:             .GridLineWidth     = 1
7743:             .GridLineColor     = RGB(238, 238, 238)
7744:             .RecordMark        = .F.
7745:             .DeleteMark        = .F.
7746:             .AllowRowSizing    = .F.
7747:             .ReadOnly          = .F.
7748:             .BackColor         = RGB(255, 255, 255)
7749:             .ForeColor         = RGB(90, 90, 90)
7750:             .HighlightBackColor = RGB(220, 230, 242)
7751:             .HighlightForeColor = RGB(15, 41, 104)
7752:             .HighlightStyle    = 2
7753:             .RowHeight         = 16
7754:             .ScrollBars        = 2
7755:             .Visible           = .T.
7756:         ENDWITH
7757: 
7758:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7759:         loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"
7760: 
7761:         *-- Configurar colunas APOS RecordSource
7762:         WITH loc_oPg.grd_4c_CustoCompo
7763:             *-- Col1: Item/Material (C14) W:80
7764:             .Column1.Header1.Caption   = "Item"
7765:             .Column1.Width             = 80
7766:             .Column1.ControlSource     = "cursor_4c_Compo.mats"
7767:             .Column1.Alignment         = 0
7768: 
7769:             *-- Col2: Descricao (C65) W:185
7770:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
7771:             .Column2.Width             = 185
7772:             .Column2.ControlSource     = "cursor_4c_Compo.dcomps"
7773:             .Column2.Alignment         = 0
7774: 
7775:             *-- Col3: Un (C5) W:35 - readonly (When=.F.)
7776:             .Column3.Header1.Caption   = "Un"
7777:             .Column3.Width             = 35
7778:             .Column3.ControlSource     = "cursor_4c_Compo.unicompos"
7779:             .Column3.ReadOnly          = .T.
7780: 
7781:             *-- Col4: Valor (N12,4) W:65
7782:             .Column4.Header1.Caption   = "Valor"
7783:             .Column4.Width             = 65
7784:             .Column4.ControlSource     = "cursor_4c_Compo.pcompos"
7785:             .Column4.Alignment         = 1
7786: 
7787:             *-- Col5: Qtd (N12,4) W:55
7788:             .Column5.Header1.Caption   = "Qtd"
7789:             .Column5.Width             = 55
7790:             .Column5.ControlSource     = "cursor_4c_Compo.qtds"
7791:             .Column5.Alignment         = 1
7792: 
7793:             *-- Col6: Total (N12,4) W:65 - readonly (calculado, When=.F.)
7794:             .Column6.Header1.Caption   = "Total"
7795:             .Column6.Width             = 65
7796:             .Column6.ControlSource     = "cursor_4c_Compo.totals"
7797:             .Column6.Alignment         = 1
7798:             .Column6.ReadOnly          = .T.
7799: 
7800:             *-- Col7: Moe/Moeda (C5) W:35
7801:             .Column7.Header1.Caption   = "Moe"
7802:             .Column7.Width             = 35
7803:             .Column7.ControlSource     = "cursor_4c_Compo.bloqueio"
7804: 
7805:             *-- Col8: Observacao (C40) W:95
7806:             .Column8.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
7807:             .Column8.Width             = 95
7808:             .Column8.ControlSource     = "cursor_4c_Compo.obscompos"
7809:             .Column8.Alignment         = 0
7810: 
7811:             *-- Col9: Etiq (C1) W:30
7812:             .Column9.Header1.Caption   = "Etiq"
7813:             .Column9.Width             = 30
7814:             .Column9.ControlSource     = "cursor_4c_Compo.etiq"
7815: 
7816:             *-- Col10: Consumo (N12,4) W:65
7817:             .Column10.Header1.Caption  = "Consumo"
7818:             .Column10.Width            = 65
7819:             .Column10.ControlSource    = "cursor_4c_Compo.consumo"
7820:             .Column10.Alignment        = 1
7821: 
7822:             *-- Col11: Qtd cons (N12,4) W:55
7823:             .Column11.Header1.Caption  = "Qtd"
7824:             .Column11.Width            = 55
7825:             .Column11.ControlSource    = "cursor_4c_Compo.qtd2"
7826:             .Column11.Alignment        = 1
7827: 
7828:             *-- Col12: Un cons (C5) W:30 - readonly (When=.F.)
7829:             .Column12.Header1.Caption  = "Un"
7830:             .Column12.Width            = 30
7831:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7832:             .Column12.ReadOnly         = .T.
7833:         ENDWITH
7834:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7835: 
7836:         *----------------------------------------------------------------------
7837:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7838:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7839:         *----------------------------------------------------------------------
7840:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7841:         WITH loc_oPg.cnt_4c_BotoesCusto
7842:             .Top         = 240
7843:             .Left        = 851
7844:             .Width       = 50
7845:             .Height      = 90
7846:             .BackStyle = 1

*-- Linhas 7999 a 8069:
7999:             .GridLineWidth     = 1
8000:             .GridLineColor     = RGB(238, 238, 238)
8001:             .RecordMark        = .F.
8002:             .DeleteMark        = .F.
8003:             .AllowRowSizing    = .F.
8004:             .ReadOnly          = .T.
8005:             .BackColor         = RGB(255, 255, 255)
8006:             .ForeColor         = RGB(90, 90, 90)
8007:             .HighlightBackColor = RGB(220, 230, 242)
8008:             .HighlightForeColor = RGB(15, 41, 104)
8009:             .HighlightStyle    = 2
8010:             .RowHeight         = 16
8011:             .ScrollBars        = 2
8012:             .Visible           = .T.
8013:         ENDWITH
8014: 
8015:         *-- RecordSource FORA do WITH
8016:         loc_oPg.grd_4c_GrupoCusto.RecordSource = "cursor_4c_Grupo"
8017: 
8018:         *-- Configurar colunas APOS RecordSource
8019:         WITH loc_oPg.grd_4c_GrupoCusto
8020:             *-- Col1: Grupo (C3) W:40 - readonly
8021:             .Column1.Header1.Caption   = "Grp"
8022:             .Column1.Width             = 40
8023:             .Column1.ControlSource     = "cursor_4c_Grupo.cgrus"
8024:             .Column1.ReadOnly          = .T.
8025: 
8026:             *-- Col2: Total (N12,4) W:100 - readonly
8027:             .Column2.Header1.Caption   = "Total "
8028:             .Column2.Width             = 100
8029:             .Column2.ControlSource     = "cursor_4c_Grupo.valgr"
8030:             .Column2.Alignment         = 1
8031:             .Column2.ReadOnly          = .T.
8032: 
8033:             *-- Col3: Moeda (C5) W:50 - readonly
8034:             .Column3.Header1.Caption   = "Moe"
8035:             .Column3.Width             = 50
8036:             .Column3.ControlSource     = "cursor_4c_Grupo.moeds"
8037:             .Column3.ReadOnly          = .T.
8038:         ENDWITH
8039:     ENDPROC
8040: 
8041:     *--------------------------------------------------------------------------
8042:     * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
8043:     *--------------------------------------------------------------------------
8044:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
8045:         LOCAL loc_oPg, loc_nRet
8046:         TRY
8047:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8048:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
8049:                 loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
8050:                 *-- Buscar descricao do grupo
8051:                 IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
8052:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8053:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
8054:                         EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
8055:                         "cursor_4c_TmpGrpCusto")
8056:                     IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
8057:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)
8058:                     ELSE
8059:                         loc_oPg.txt_4c_DGruCompos.Value = ""
8060:                     ENDIF
8061:                     IF USED("cursor_4c_TmpGrpCusto")
8062:                         USE IN cursor_4c_TmpGrpCusto
8063:                     ENDIF
8064:                 ELSE
8065:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8066:                 ENDIF
8067:             ENDIF
8068:         CATCH TO loc_oErro
8069:             *-- silencioso: refresh de display nao deve bloquear navegacao

*-- Linhas 8101 a 8147:
8101:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
8102:             ENDIF
8103:             IF USED("cursor_4c_Compo")
8104:                 SELECT cursor_4c_Compo
8105:                 GO TOP IN cursor_4c_Compo
8106:                 LOCATE FOR EMPTY(mats)
8107:                 IF EOF("cursor_4c_Compo")
8108:                     INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
8109:                 ENDIF
8110:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8111:                 IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
8112:                     loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
8113:                 ENDIF
8114:             ENDIF
8115:         CATCH TO loc_oErro
8116:             MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
8117:         ENDTRY
8118:     ENDPROC
8119: 
8120:     *--------------------------------------------------------------------------
8121:     * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
8122:     *--------------------------------------------------------------------------
8123:     PROCEDURE CmdExcluirCustoClick()
8124:         LOCAL loc_oPg
8125:         TRY
8126:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8127:                 RETURN
8128:             ENDIF
8129:             IF USED("cursor_4c_Compo")
8130:                 SELECT cursor_4c_Compo
8131:                 IF !EOF("cursor_4c_Compo")
8132:                     DELETE
8133:                     IF !EOF("cursor_4c_Compo")
8134:                         SKIP
8135:                         SKIP -1
8136:                     ENDIF
8137:                     GO BOTTOM IN cursor_4c_Compo
8138:                 ENDIF
8139:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8140:                 loc_oPg.grd_4c_CustoCompo.SetFocus()
8141:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8142:             ENDIF
8143:         CATCH TO loc_oErro
8144:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8145:         ENDTRY
8146:     ENDPROC
8147: 

*-- Linhas 8178 a 8218:
8178:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8179: 
8180:         *----------------------------------------------------------------------
8181:         *-- Cursor placeholder cursor_4c_GradFase (SigCdPrf + SigCdGcr JOIN)
8182:         *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
8183:         *----------------------------------------------------------------------
8184:         IF !USED("cursor_4c_GradFase")
8185:             SET NULL ON
8186:             CREATE CURSOR cursor_4c_GradFase (;
8187:                 Ordems   N(5,0), ;
8188:                 Grupos   C(10), ;
8189:                 Descrs   C(65), ;
8190:                 UniPrdts C(10), ;
8191:                 MatPrdts C(15), ;
8192:                 Obs      M, ;
8193:                 FigProcs M)
8194:             SET NULL OFF
8195:         ENDIF
8196: 
8197:         *----------------------------------------------------------------------
8198:         *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
8199:         *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
8200:         *----------------------------------------------------------------------
8201:         IF !USED("cursor_4c_SigPrMtz")
8202:             SET NULL ON
8203:             CREATE CURSOR cursor_4c_SigPrMtz (;
8204:                 CMats C(14), ;
8205:                 DLocs C(40), ;
8206:                 Qtds  N(3,0))
8207:             SET NULL OFF
8208:         ENDIF
8209: 
8210:         *----------------------------------------------------------------------
8211:         *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
8212:         *----------------------------------------------------------------------
8213:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8214:         WITH loc_oPg.shp_4c_ShpFig
8215:             .Top         = 152
8216:             .Left        = 231
8217:             .Width       = 244
8218:             .Height      = 148

*-- Linhas 8259 a 8327:
8259:             .GridLineWidth      = 1
8260:             .GridLineColor      = RGB(238, 238, 238)
8261:             .RecordMark         = .F.
8262:             .DeleteMark         = .F.
8263:             .AllowRowSizing     = .F.
8264:             .ReadOnly           = .F.
8265:             .BackColor          = RGB(255, 255, 255)
8266:             .ForeColor          = RGB(90, 90, 90)
8267:             .HighlightBackColor = RGB(220, 230, 242)
8268:             .HighlightForeColor = RGB(15, 41, 104)
8269:             .HighlightStyle     = 2
8270:             .RowHeight          = 16
8271:             .ScrollBars         = 2
8272:             .Themes             = .F.
8273:             .Visible            = .T.
8274:         ENDWITH
8275: 
8276:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8277:         loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8278: 
8279:         *-- Configurar colunas APOS RecordSource
8280:         WITH loc_oPg.grd_4c_GradFase
8281:             *-- Col1: Ordem (Ordems N5) W:50 - readonly (When=.F. no legado)
8282:             .Column1.Header1.Caption = "Ordem"
8283:             .Column1.Width           = 50
8284:             .Column1.ControlSource   = "cursor_4c_GradFase.Ordems"
8285:             .Column1.Alignment       = 1
8286:             .Column1.ReadOnly        = .T.
8287: 
8288:             *-- Col2: Fase (Grupos C10) W:80 - editable, F4 lookup SigCdGcr
8289:             .Column2.Header1.Caption = "Fase"
8290:             .Column2.Width           = 80
8291:             .Column2.ControlSource   = "cursor_4c_GradFase.Grupos"
8292:             .Column2.Alignment       = 0
8293:             .Column2.ReadOnly        = .F.
8294: 
8295:             *-- Col3: Utilizacao (Descrs C65) W:130 - readonly
8296:             .Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8297:             .Column3.Width           = 130
8298:             .Column3.ControlSource   = "cursor_4c_GradFase.Descrs"
8299:             .Column3.Alignment       = 0
8300:             .Column3.ReadOnly        = .T.
8301: 
8302:             *-- Col4: Uni. Produtiva (UniPrdts C10) W:80 - editable, F4 lookup SigCdUpd
8303:             .Column4.Header1.Caption = "Uni. Produtiva"
8304:             .Column4.Width           = 80
8305:             .Column4.ControlSource   = "cursor_4c_GradFase.UniPrdts"
8306:             .Column4.Alignment       = 0
8307:             .Column4.ReadOnly        = .F.
8308: 
8309:             *-- Col5: Material (MatPrdts C15) W:80 - editable, F4 lookup SigOpOpt
8310:             .Column5.Header1.Caption = "Material"
8311:             .Column5.Width           = 80
8312:             .Column5.ControlSource   = "cursor_4c_GradFase.MatPrdts"
8313:             .Column5.Alignment       = 0
8314:             .Column5.ReadOnly        = .F.
8315:         ENDWITH
8316: 
8317:         *-- BINDEVENT: GradFase
8318:         BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
8319:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
8320:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
8321:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
8322:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
8323:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")
8324: 
8325:         *----------------------------------------------------------------------
8326:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8327:         *-- Legado: inserir.Click - insere nova linha com resequenciamento

*-- Linhas 8882 a 8936:
8882:             .GridLineWidth      = 1
8883:             .GridLineColor      = RGB(238, 238, 238)
8884:             .RecordMark         = .F.
8885:             .DeleteMark         = .F.
8886:             .AllowRowSizing     = .F.
8887:             .ReadOnly           = .F.
8888:             .BackColor          = RGB(255, 255, 255)
8889:             .ForeColor          = RGB(90, 90, 90)
8890:             .HighlightBackColor = RGB(220, 230, 242)
8891:             .HighlightForeColor = RGB(15, 41, 104)
8892:             .HighlightStyle     = 2
8893:             .RowHeight          = 16
8894:             .ScrollBars         = 2
8895:             .Themes             = .F.
8896:             .Visible            = .T.
8897:         ENDWITH
8898: 
8899:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8900:         loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_SigPrMtz"
8901: 
8902:         *-- Configurar colunas APOS RecordSource
8903:         WITH loc_oPg.grd_4c_Matrizes
8904:             *-- Col1: Matriz (CMats C14) W:70 - editable, F4 lookup crMatrizes
8905:             .Column1.Header1.Caption = "Matriz"
8906:             .Column1.Width           = 70
8907:             .Column1.ControlSource   = "cursor_4c_SigPrMtz.CMats"
8908:             .Column1.Alignment       = 0
8909:             .Column1.ReadOnly        = .F.
8910: 
8911:             *-- Col2: Local (DLocs C40) W:120 - readonly (preenchido pelo lookup)
8912:             .Column2.Header1.Caption = "Local"
8913:             .Column2.Width           = 120
8914:             .Column2.ControlSource   = "cursor_4c_SigPrMtz.DLocs"
8915:             .Column2.Alignment       = 0
8916:             .Column2.ReadOnly        = .T.
8917: 
8918:             *-- Col3: Qtde (Qtds N3) W:56 - editable em modo edicao
8919:             .Column3.Header1.Caption = "Qtde"
8920:             .Column3.Width           = 56
8921:             .Column3.ControlSource   = "cursor_4c_SigPrMtz.Qtds"
8922:             .Column3.Alignment       = 1
8923:             .Column3.ReadOnly        = .F.
8924:         ENDWITH
8925: 
8926:         *-- BINDEVENT: grdMatrizes
8927:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8928:         BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")
8929: 
8930:         *----------------------------------------------------------------------
8931:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8932:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8933:         *----------------------------------------------------------------------
8934:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8935:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8936:             .Caption       = "+"

*-- Linhas 9205 a 9230:
9205:             IF loc_lResultado
9206:                 *-- Calcular Ordem2 para resequenciamento
9207:                 loc_nPonteiro = RECNO("cursor_4c_GradFase")
9208:                 SELECT cursor_4c_GradFase
9209:                 SCAN
9210:                     IF RECNO() # loc_nPonteiro
9211:                         REPLACE Ordems WITH cursor_4c_GradFase.Ordems IN cursor_4c_GradFase
9212:                     ENDIF
9213:                 ENDSCAN
9214:                 GO loc_nPonteiro IN cursor_4c_GradFase
9215:                 SELECT cursor_4c_GradFase
9216:                 *-- Reordenar por Ordems para refletir nova sequencia
9217:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9218:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9219:                 ENDIF
9220:             ENDIF
9221:         CATCH TO loc_oErro
9222:             MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
9223:         ENDTRY
9224:     ENDPROC
9225: 
9226:     *--------------------------------------------------------------------------
9227:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
9228:     * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
9229:     *         Apos selecao: preenche Grupos e Descrs no cursor
9230:     *--------------------------------------------------------------------------

*-- Linhas 9250 a 9268:
9250:                     ENDIF
9251:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
9252:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9253:                             SELECT cursor_4c_GradFase
9254:                             REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
9255:                             REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
9256:                         ENDIF
9257:                     ENDIF
9258:                     loc_oBusca.Release()
9259:                 ENDIF
9260:                 IF USED("cursor_4c_BuscaGcr")
9261:                     USE IN cursor_4c_BuscaGcr
9262:                 ENDIF
9263:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9264:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9265:                 ENDIF
9266:             CATCH TO loc_oErro
9267:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
9268:             ENDTRY

*-- Linhas 9289 a 9324:
9289:                 ENDIF
9290:                 *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
9291:                 IF !EMPTY(loc_cGrupos)
9292:                     loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
9293:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9294:                 ELSE
9295:                     loc_cSQL = "SELECT DISTINCT UniPrdts FROM SigCdUpd"
9296:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9297:                 ENDIF
9298:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaUpd")
9299:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9300:                         "SigCdUpd", "cursor_4c_BuscaUpd2", "UniPrdts", loc_cAtual, ;
9301:                         "Buscar Uni. Produtiva")
9302:                     IF VARTYPE(loc_oBusca) = "O"
9303:                         IF !loc_oBusca.this_lAchouRegistro
9304:                             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
9305:                             loc_oBusca.Show()
9306:                         ENDIF
9307:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
9308:                             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9309:                                 SELECT cursor_4c_GradFase
9310:                                 REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
9311:                             ENDIF
9312:                         ENDIF
9313:                         loc_oBusca.Release()
9314:                     ENDIF
9315:                     IF USED("cursor_4c_BuscaUpd2")
9316:                         USE IN cursor_4c_BuscaUpd2
9317:                     ENDIF
9318:                 ENDIF
9319:                 IF USED("cursor_4c_BuscaUpd")
9320:                     USE IN cursor_4c_BuscaUpd
9321:                 ENDIF
9322:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9323:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9324:                 ENDIF

*-- Linhas 9355 a 9373:
9355:                     ENDIF
9356:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
9357:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9358:                             SELECT cursor_4c_GradFase
9359:                             REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
9360:                         ENDIF
9361:                     ENDIF
9362:                     loc_oBusca.Release()
9363:                 ENDIF
9364:                 IF USED("cursor_4c_BuscaOpt")
9365:                     USE IN cursor_4c_BuscaOpt
9366:                 ENDIF
9367:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9368:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9369:                 ENDIF
9370:             CATCH TO loc_oErro
9371:                 MsgErro(loc_oErro.Message, "Erro ao buscar material")
9372:             ENDTRY
9373:         ENDIF

*-- Linhas 9396 a 9416:
9396:             *-- Carregar imagem da borracha do produto-matriz corrente
9397:             IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9398:                 IF !EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9399:                     loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
9400:                                EscaparSQL(ALLTRIM(cursor_4c_SigPrMtz.CMats))
9401:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalImgPro")
9402:                     IF loc_nRet > 0 AND USED("cursor_4c_LocalImgPro")
9403:                         GO TOP IN cursor_4c_LocalImgPro
9404:                         IF !EOF("cursor_4c_LocalImgPro")
9405:                             IF TYPE("cursor_4c_LocalImgPro.FigJpgs") # "U"
9406:                                 IF !EMPTY(NVL(cursor_4c_LocalImgPro.FigJpgs, ""))
9407:                                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_bor.jpg"
9408:                                     IF STRTOFILE(cursor_4c_LocalImgPro.FigJpgs, loc_lcArquivo) > 0
9409:                                         loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9410:                                         loc_oPg.img_4c_ImgBorracha.Visible = .T.
9411:                                     ENDIF
9412:                                 ENDIF
9413:                             ENDIF
9414:                         ENDIF
9415:                         USE IN cursor_4c_LocalImgPro
9416:                     ENDIF

*-- Linhas 9452 a 9470:
9452:                     ENDIF
9453:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
9454:                         IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9455:                             SELECT cursor_4c_SigPrMtz
9456:                             REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
9457:                             IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
9458:                                 REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
9459:                             ENDIF
9460:                         ENDIF
9461:                     ENDIF
9462:                     loc_oBusca.Release()
9463:                 ENDIF
9464:                 IF USED("cursor_4c_BuscaMatriz")
9465:                     USE IN cursor_4c_BuscaMatriz
9466:                 ENDIF
9467:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9468:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
9469:                 ENDIF
9470:             CATCH TO loc_oErro

*-- Linhas 9489 a 9565:
9489:             *-- Calcular proximo numero de ordem
9490:             loc_nOrdem = 0
9491:             IF !EOF("cursor_4c_GradFase")
9492:                 SELECT MAX(Ordems) AS nMaxOrdem FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpOrd NOFILTER
9493:                 IF USED("cursor_4c_TmpOrd") AND !EOF("cursor_4c_TmpOrd")
9494:                     loc_nOrdem = NVL(cursor_4c_TmpOrd.nMaxOrdem, 0)
9495:                 ENDIF
9496:                 IF USED("cursor_4c_TmpOrd")
9497:                     USE IN cursor_4c_TmpOrd
9498:                 ENDIF
9499:             ENDIF
9500:             loc_nOrdem = loc_nOrdem + 1
9501:             *-- Inserir nova linha
9502:             INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9503:                 VALUES (loc_nOrdem, "", "", "", "")
9504:             *-- Posicionar no novo registro e focar grid
9505:             GO BOTTOM IN cursor_4c_GradFase
9506:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9507:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9508:                 IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9509:                     loc_oPg.grd_4c_GradFase.Refresh()
9510:                     loc_oPg.grd_4c_GradFase.SetFocus()
9511:                 ENDIF
9512:             ENDIF
9513:         CATCH TO loc_oErro
9514:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9515:         ENDTRY
9516:     ENDPROC
9517: 
9518:     *--------------------------------------------------------------------------
9519:     * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
9520:     * Legado: excluir.Click - DELETE e resequencia Ordems
9521:     *--------------------------------------------------------------------------
9522:     PROCEDURE CmdExcluirFaseClick()
9523:         LOCAL loc_oPg, loc_lResultado
9524:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9525:             RETURN
9526:         ENDIF
9527:         loc_lResultado = .T.
9528:         TRY
9529:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9530:                 loc_lResultado = .F.
9531:             ENDIF
9532:             IF loc_lResultado
9533:                 IF !MsgConfirma("Excluir fase selecionada?")
9534:                     loc_lResultado = .F.
9535:                 ENDIF
9536:             ENDIF
9537:             IF loc_lResultado
9538:                 SELECT cursor_4c_GradFase
9539:                 DELETE
9540:                 IF !EOF("cursor_4c_GradFase")
9541:                     SKIP
9542:                 ENDIF
9543:                 IF EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
9544:                     GO BOTTOM IN cursor_4c_GradFase
9545:                 ENDIF
9546:                 *-- Resequenciar Ordems
9547:                 LOCAL loc_nSeq
9548:                 loc_nSeq = 1
9549:                 GO TOP IN cursor_4c_GradFase
9550:                 SCAN FOR !DELETED()
9551:                     REPLACE Ordems WITH loc_nSeq
9552:                     loc_nSeq = loc_nSeq + 1
9553:                 ENDSCAN
9554:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9555:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9556:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9557:                         loc_oPg.grd_4c_GradFase.Refresh()
9558:                     ENDIF
9559:                 ENDIF
9560:             ENDIF
9561:         CATCH TO loc_oErro
9562:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9563:         ENDTRY
9564:     ENDPROC
9565: 

*-- Linhas 9590 a 9617:
9590:                 loc_cUni    = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9591:                 loc_cMat    = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9592:                 *-- Calcular proxima ordem
9593:                 SELECT MAX(Ordems) AS nMaxOrd FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpAlt NOFILTER
9594:                 loc_nOrdem = 1
9595:                 IF USED("cursor_4c_TmpAlt") AND !EOF("cursor_4c_TmpAlt")
9596:                     loc_nOrdem = NVL(cursor_4c_TmpAlt.nMaxOrd, 0) + 1
9597:                 ENDIF
9598:                 IF USED("cursor_4c_TmpAlt")
9599:                     USE IN cursor_4c_TmpAlt
9600:                 ENDIF
9601:                 *-- Inserir copia como alternativa
9602:                 INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9603:                     VALUES (loc_nOrdem, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat)
9604:                 GO BOTTOM IN cursor_4c_GradFase
9605:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9606:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9607:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9608:                         loc_oPg.grd_4c_GradFase.Refresh()
9609:                     ENDIF
9610:                 ENDIF
9611:             ENDIF
9612:         CATCH TO loc_oErro
9613:             MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
9614:         ENDTRY
9615:     ENDPROC
9616: 
9617:     *--------------------------------------------------------------------------

*-- Linhas 9634 a 9671:
9634:             IF loc_lResultado
9635:                 *-- Buscar nome da empresa
9636:                 loc_cNmEmp = ""
9637:                 loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
9638:                            EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
9639:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmp")
9640:                 IF loc_nRet > 0 AND USED("cursor_4c_TmpEmp") AND !EOF("cursor_4c_TmpEmp")
9641:                     loc_cNmEmp = ALLTRIM(NVL(cursor_4c_TmpEmp.Razas, ""))
9642:                 ENDIF
9643:                 IF USED("cursor_4c_TmpEmp")
9644:                     USE IN cursor_4c_TmpEmp
9645:                 ENDIF
9646:                 *-- Preparar cursor de cabecalho para o relatorio
9647:                 IF USED("CsCabecalho")
9648:                     USE IN CsCabecalho
9649:                 ENDIF
9650:                 CREATE CURSOR CsCabecalho (;
9651:                     _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
9652:                     _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
9653:                     _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
9654:                     _nPeso N(9,2))
9655:                 WITH THIS.this_oBusinessObject
9656:                     INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
9657:                         VALUES (loc_cNmEmp, ;
9658:                                 "Ficha T" + CHR(233) + "cnica de Produto", ;
9659:                                 ALLTRIM(.this_cCpros), ;
9660:                                 ALLTRIM(.this_cDpros), ;
9661:                                 ALLTRIM(.this_cCgrus), ;
9662:                                 .this_nPesobs)
9663:                 ENDWITH
9664:                 *-- Verificar e executar relatorio
9665:                 LOCAL loc_cRepPath
9666:                 loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
9667:                 IF FILE(loc_cRepPath)
9668:                     REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
9669:                 ELSE
9670:                     MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")
9671:                 ENDIF

*-- Linhas 9699 a 9717:
9699:                 IF !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9700:                     *-- Armazenar imagem binaria no campo memo FigProcs
9701:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9702:                         SELECT cursor_4c_GradFase
9703:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9704:                     ENDIF
9705:                     *-- Atualizar exibicao da imagem
9706:                     THIS.GradFaseAfterRowColChange(0)
9707:                 ENDIF
9708:             ENDIF
9709:         CATCH TO loc_oErro
9710:             MsgErro(loc_oErro.Message, "Erro ao selecionar imagem")
9711:         ENDTRY
9712:     ENDPROC
9713: 
9714:     *--------------------------------------------------------------------------
9715:     * CmdgFigCamClick - Captura imagem via webcam (SigImage form)
9716:     * Legado: cmdgFigCam.Click - DO form SigImage TO lcFigura e armazena
9717:     *--------------------------------------------------------------------------

*-- Linhas 9736 a 9754:
9736:                 ENDIF
9737:                 IF loc_lResultado AND !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9738:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9739:                         SELECT cursor_4c_GradFase
9740:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9741:                     ENDIF
9742:                     THIS.GradFaseAfterRowColChange(0)
9743:                 ENDIF
9744:             ENDIF
9745:         CATCH TO loc_oErro
9746:             MsgErro(loc_oErro.Message, "Erro ao capturar imagem via webcam")
9747:         ENDTRY
9748:     ENDPROC
9749: 
9750:     *--------------------------------------------------------------------------
9751:     * ImgFigJpgClick - Abre imagem da fase em zoom (SigOpZom form)
9752:     * Legado: ImgFigJpg.Click - StrToFile e DO form SigOpZom
9753:     *--------------------------------------------------------------------------
9754:     PROCEDURE ImgFigJpgClick()

*-- Linhas 9773 a 9849:
9773: 
9774:     *--------------------------------------------------------------------------
9775:     * BtnInsereMtxClick - Insere nova linha de matriz em cursor_4c_SigPrMtz
9776:     * Legado: btnInsereMtx.Click - Insert Into crSigPrMtz se vazio
9777:     *--------------------------------------------------------------------------
9778:     PROCEDURE BtnInsereMtxClick()
9779:         LOCAL loc_oPg, loc_lResultado
9780:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9781:             RETURN
9782:         ENDIF
9783:         loc_lResultado = .T.
9784:         TRY
9785:             IF !USED("cursor_4c_SigPrMtz")
9786:                 loc_lResultado = .F.
9787:             ENDIF
9788:             IF loc_lResultado
9789:                 *-- Verificar se ja existe linha vazia (evitar duplicatas)
9790:                 GO TOP IN cursor_4c_SigPrMtz
9791:                 LOCATE FOR EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9792:                 IF !EOF("cursor_4c_SigPrMtz")
9793:                     *-- Ja existe linha vazia - apenas focar
9794:                     loc_lResultado = .F.
9795:                 ENDIF
9796:             ENDIF
9797:             IF loc_lResultado
9798:                 INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9799:                 GO BOTTOM IN cursor_4c_SigPrMtz
9800:             ENDIF
9801:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9802:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9803:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9804:                     loc_oPg.grd_4c_Matrizes.Refresh()
9805:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9806:                 ENDIF
9807:             ENDIF
9808:         CATCH TO loc_oErro
9809:             MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
9810:         ENDTRY
9811:     ENDPROC
9812: 
9813:     *--------------------------------------------------------------------------
9814:     * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
9815:     * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
9816:     *--------------------------------------------------------------------------
9817:     PROCEDURE BtnExcluiMtzClick()
9818:         LOCAL loc_oPg, loc_lResultado
9819:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9820:             RETURN
9821:         ENDIF
9822:         loc_lResultado = .T.
9823:         TRY
9824:             IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
9825:                 loc_lResultado = .F.
9826:             ENDIF
9827:             IF loc_lResultado
9828:                 SELECT cursor_4c_SigPrMtz
9829:                 DELETE
9830:                 *-- Se cursor ficou vazio, reinsere linha placeholder
9831:                 GO TOP IN cursor_4c_SigPrMtz
9832:                 LOCATE FOR !DELETED()
9833:                 IF EOF("cursor_4c_SigPrMtz")
9834:                     INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9835:                 ENDIF
9836:             ENDIF
9837:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9838:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9839:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9840:                     loc_oPg.grd_4c_Matrizes.Refresh()
9841:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9842:                 ENDIF
9843:             ENDIF
9844:         CATCH TO loc_oErro
9845:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9846:         ENDTRY
9847:     ENDPROC
9848: 
9849:     *--------------------------------------------------------------------------

*-- Linhas 10002 a 10045:
10002: 
10003:     *--------------------------------------------------------------------------
10004:     * TxtConquilhaLostFocus - Valida conquilha (SigCdCnq) ao sair do campo
10005:     * Legado: getConquilha.Valid = SQL SELECT conquilhas FROM SigCdCnq + fwBuscaInt
10006:     *--------------------------------------------------------------------------
10007:     PROCEDURE TxtConquilhaLostFocus()
10008:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
10009:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10010:             RETURN
10011:         ENDIF
10012:         loc_lResultado = .T.
10013:         TRY
10014:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10015:                 loc_lResultado = .F.
10016:             ENDIF
10017:             IF loc_lResultado
10018:                 loc_oPg  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
10019:                 loc_cCod = ALLTRIM(NVL(loc_oPg.txt_4c_Conquilha.Value, ""))
10020:                 IF EMPTY(loc_cCod)
10021:                     THIS.this_oBusinessObject.this_cConquilhas = ""
10022:                     loc_lResultado = .F.
10023:                 ENDIF
10024:             ENDIF
10025:             IF loc_lResultado
10026:                 *-- Buscar conquilhas disponiveis em SigCdCnq
10027:                 loc_cSQL = "SELECT DISTINCT conquilhas FROM SigCdCnq"
10028:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaCnq")
10029:                 IF loc_nRet > 0 AND USED("cursor_4c_ListaCnq")
10030:                     SELECT cursor_4c_ListaCnq
10031:                     LOCATE FOR ALLTRIM(NVL(conquilhas, "")) = PADR(loc_cCod, 10)
10032:                     IF !EOF("cursor_4c_ListaCnq")
10033:                         *-- Encontrado direto
10034:                         loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_ListaCnq.conquilhas)
10035:                         THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10036:                     ELSE
10037:                         *-- Nao encontrado - abrir lookup
10038:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10039:                             "SigCdCnq", "cursor_4c_BuscaCnq", "conquilhas", loc_cCod, ;
10040:                             "Buscar Conquilha")
10041:                         IF VARTYPE(loc_oBusca) = "O"
10042:                             IF !loc_oBusca.this_lAchouRegistro
10043:                                 loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
10044:                                 loc_oBusca.Show()
10045:                             ENDIF

*-- Linhas 10080 a 10098:
10080:         *----------------------------------------------------------------------
10081:         IF !USED("cursor_4c_Cmv")
10082:             SET NULL ON
10083:             CREATE CURSOR cursor_4c_Cmv (;
10084:                 Datas   D, ;
10085:                 ValCuss N(12,3), ;
10086:                 Moedas  C(3))
10087:             SET NULL OFF
10088:         ENDIF
10089: 
10090:         *----------------------------------------------------------------------
10091:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10092:         *----------------------------------------------------------------------
10093:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10094:         WITH loc_oPg.lbl_4c_LblGruCus
10095:             .Caption   = "Grupo C.C. :"
10096:             .Top       = 165
10097:             .Left      = 138
10098:             .Width     = 63

*-- Linhas 10879 a 10934:
10879:             .FontName    = "Tahoma"
10880:             .FontSize    = 8
10881:             .RowHeight   = 17
10882:             .DeleteMark  = .F.
10883:             .RecordMark  = .T.
10884:             .ReadOnly    = .T.
10885:             .ScrollBars  = 3
10886:             .Themes      = .F.
10887:             .Visible     = .T.
10888:         ENDWITH
10889:         loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
10890:         WITH loc_oPg.grd_4c_Cmv
10891:             WITH .Column1
10892:                 .Header1.Caption  = "Per" + CHR(237) + "odo"
10893:                 .Header1.FontName = "Tahoma"
10894:                 .Header1.FontSize = 8
10895:                 .Width            = 59
10896:                 .Movable          = .F.
10897:                 .Resizable        = .F.
10898:                 .ReadOnly         = .T.
10899:                 .ControlSource    = "cursor_4c_Cmv.Datas"
10900:             ENDWITH
10901:             WITH .Column2
10902:                 .Header1.Caption  = "Valor Custo GR"
10903:                 .Header1.FontName = "Tahoma"
10904:                 .Header1.FontSize = 8
10905:                 .Width            = 100
10906:                 .Movable          = .F.
10907:                 .Resizable        = .F.
10908:                 .ReadOnly         = .T.
10909:                 .ControlSource    = "cursor_4c_Cmv.ValCuss"
10910:             ENDWITH
10911:             WITH .Column3
10912:                 .Header1.Caption  = "Moe"
10913:                 .Header1.FontName = "Tahoma"
10914:                 .Header1.FontSize = 8
10915:                 .Width            = 31
10916:                 .Movable          = .F.
10917:                 .Resizable        = .F.
10918:                 .ReadOnly         = .T.
10919:                 .ControlSource    = "cursor_4c_Cmv.Moedas"
10920:             ENDWITH
10921:         ENDWITH
10922:     ENDPROC
10923: 
10924:     *--------------------------------------------------------------------------
10925:     * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
10926:     * Chamado por BOParaForm apos carregar dados de SigCdPro
10927:     *--------------------------------------------------------------------------
10928:     PROTECTED PROCEDURE PreencherCamposFiscais()
10929:         LOCAL loc_oPg, loc_cIpiVal
10930:         TRY
10931:             IF VARTYPE(THIS.pgf_4c_Paginas) # "O"
10932:                 RETURN
10933:             ENDIF
10934:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3

*-- Linhas 11487 a 11509:
11487:             ENDIF
11488:             IF loc_lResultado
11489:                 *-- Carregar lista de metais (Tipos='M') para lookup
11490:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos = 'M'"
11491:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlM")
11492:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlM")
11493:                     *-- Verificar se codigo existe diretamente
11494:                     SELECT cursor_4c_BuscaMtlM
11495:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11496:                     IF !EOF("cursor_4c_BuscaMtlM")
11497:                         IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11498:                             loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlM.Descs, ""))
11499:                         ENDIF
11500:                         THIS.this_oBusinessObject.this_cMetals = loc_cCod
11501:                     ELSE
11502:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11503:                             "SigCdMtl", "cursor_4c_BuscaMtlSel", "Codigos", loc_cCod, ;
11504:                             "Buscar Metal")
11505:                         IF VARTYPE(loc_oBusca) = "O"
11506:                             IF !loc_oBusca.this_lAchouRegistro
11507:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11508:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11509:                                 loc_oBusca.Show()

*-- Linhas 11560 a 11581:
11560:                 ENDIF
11561:             ENDIF
11562:             IF loc_lResultado
11563:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos <> 'M'"
11564:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlT")
11565:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlT")
11566:                     SELECT cursor_4c_BuscaMtlT
11567:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11568:                     IF !EOF("cursor_4c_BuscaMtlT")
11569:                         IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11570:                             loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlT.Descs, ""))
11571:                         ENDIF
11572:                         THIS.this_oBusinessObject.this_cTeors = loc_cCod
11573:                     ELSE
11574:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11575:                             "SigCdMtl", "cursor_4c_BuscaTeorSel", "Codigos", loc_cCod, ;
11576:                             "Buscar Teor")
11577:                         IF VARTYPE(loc_oBusca) = "O"
11578:                             IF !loc_oBusca.this_lAchouRegistro
11579:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11580:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11581:                                 loc_oBusca.Show()

*-- Linhas 11710 a 11743:
11710:         *----------------------------------------------------------------------
11711:         IF !USED("cursor_4c_SigPrTar")
11712:             SET NULL ON
11713:             CREATE CURSOR cursor_4c_SigPrTar (;
11714:                 DtInis  D NULL, ;
11715:                 DtFims  D NULL, ;
11716:                 Usuars  C(10), ;
11717:                 Tarefas C(10), ;
11718:                 ObsTars M)
11719:             SET NULL OFF
11720:         ENDIF
11721: 
11722:         *----------------------------------------------------------------------
11723:         *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
11724:         *-- Campos: Arquivos
11725:         *----------------------------------------------------------------------
11726:         IF !USED("cursor_4c_SigPrArq")
11727:             SET NULL ON
11728:             CREATE CURSOR cursor_4c_SigPrArq (;
11729:                 Arquivos C(200))
11730:             SET NULL OFF
11731:         ENDIF
11732: 
11733:         *----------------------------------------------------------------------
11734:         *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
11735:         *----------------------------------------------------------------------
11736:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11737:         WITH loc_oPg.shp_4c_ArqFundo
11738:             .Top         = 415
11739:             .Left        = 584
11740:             .Width       = 407
11741:             .Height      = 202
11742:             .BackColor   = RGB(230, 230, 230)
11743:             .BorderColor = RGB(180, 180, 180)

*-- Linhas 11776 a 11861:
11776:             .ColumnCount = 4
11777:             .FontName    = "Tahoma"
11778:             .FontSize    = 8
11779:             .DeleteMark  = .F.
11780:             .ScrollBars  = 2
11781:             .Themes      = .F.
11782:             .Visible     = .T.
11783:             .RecordMark   = .F.
11784:         ENDWITH
11785:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_SigPrTar"
11786:         WITH loc_oPg.grd_4c_Designer
11787:             WITH .Column1
11788:                 .Header1.Caption   = "Data de In" + CHR(237) + "cio"
11789:                 .Header1.FontName  = "Tahoma"
11790:                 .Header1.FontSize  = 8
11791:                 .Header1.Alignment = 2
11792:                 .Width             = 140
11793:                 .Movable           = .F.
11794:                 .Resizable         = .F.
11795:                 .ReadOnly          = .T.
11796:                 .Alignment         = 2
11797:                 .ControlSource     = "cursor_4c_SigPrTar.DtInis"
11798:             ENDWITH
11799:             WITH .Column2
11800:                 .Header1.Caption   = "Data de Conclus" + CHR(227) + "o"
11801:                 .Header1.FontName  = "Tahoma"
11802:                 .Header1.FontSize  = 8
11803:                 .Header1.Alignment = 2
11804:                 .Width             = 140
11805:                 .Movable           = .F.
11806:                 .Resizable         = .F.
11807:                 .ReadOnly          = .T.
11808:                 .Alignment         = 2
11809:                 .ControlSource     = "cursor_4c_SigPrTar.DtFims"
11810:             ENDWITH
11811:             WITH .Column3
11812:                 .Header1.Caption   = "Usu" + CHR(225) + "rio"
11813:                 .Header1.FontName  = "Tahoma"
11814:                 .Header1.FontSize  = 8
11815:                 .Header1.Alignment = 2
11816:                 .Width             = 90
11817:                 .Movable           = .F.
11818:                 .Resizable         = .F.
11819:                 .ReadOnly          = .T.
11820:                 .ControlSource     = "cursor_4c_SigPrTar.Usuars"
11821:             ENDWITH
11822:             WITH .Column4
11823:                 .Header1.Caption   = "Tarefa"
11824:                 .Header1.FontName  = "Tahoma"
11825:                 .Header1.FontSize  = 8
11826:                 .Header1.Alignment = 2
11827:                 .Width             = 90
11828:                 .Movable           = .F.
11829:                 .Resizable         = .F.
11830:                 .ReadOnly          = .F.
11831:                 .ControlSource     = "cursor_4c_SigPrTar.Tarefas"
11832:             ENDWITH
11833:         ENDWITH
11834:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
11835: 
11836:         *----------------------------------------------------------------------
11837:         *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
11838:         *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
11839:         *----------------------------------------------------------------------
11840:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11841:         WITH loc_oPg.obj_4c_ObsTarefas
11842:             .Top              = 160
11843:             .Left             = 584
11844:             .Width            = 407
11845:             .Height           = 238
11846:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11847:             .FontName         = "Tahoma"
11848:             .FontSize         = 8
11849:             .SpecialEffect    = 1
11850:             .ForeColor        = RGB(36, 84, 155)
11851:             .Enabled          = .T.
11852:             .Visible          = .T.
11853:         ENDWITH
11854: 
11855:         *----------------------------------------------------------------------
11856:         *-- btnIniTarefa: Iniciar Tarefa (T:161 L:509 W:42 H:42)
11857:         *----------------------------------------------------------------------
11858:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11859:         WITH loc_oPg.cmd_4c_IniTarefa
11860:             .Top             = 161
11861:             .Left            = 509

*-- Linhas 11904 a 11940:
11904:             .ColumnCount = 1
11905:             .FontName    = "Tahoma"
11906:             .FontSize    = 8
11907:             .DeleteMark  = .F.
11908:             .ScrollBars  = 2
11909:             .ReadOnly    = .T.
11910:             .Themes      = .F.
11911:             .Visible     = .T.
11912:             .RecordMark   = .F.
11913:         ENDWITH
11914:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
11915:         WITH loc_oPg.grd_4c_Arquivos
11916:             WITH .Column1
11917:                 .Header1.Caption   = "Arquivos Para Designer"
11918:                 .Header1.FontName  = "Tahoma"
11919:                 .Header1.FontSize  = 8
11920:                 .Header1.Alignment = 2
11921:                 .Width             = 464
11922:                 .Movable           = .F.
11923:                 .Resizable         = .F.
11924:                 .ReadOnly          = .T.
11925:                 .ControlSource     = "cursor_4c_SigPrArq.Arquivos"
11926:             ENDWITH
11927:         ENDWITH
11928:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
11929: 
11930:         *----------------------------------------------------------------------
11931:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
11932:         *----------------------------------------------------------------------
11933:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")
11934:         WITH loc_oPg.cmd_4c_InsArqs
11935:             .Top             = 416
11936:             .Left            = 509
11937:             .Width           = 42
11938:             .Height          = 42
11939:             .Caption         = ""
11940:             .Picture         = gc_4c_CaminhoIcones + "geral_arquivo_26.bmp"

*-- Linhas 12105 a 12144:
12105:             ENDIF
12106:             IF loc_lResultado
12107:                 *-- Verificar se existe tarefa nao encerrada para este usuario
12108:                 SELECT cursor_4c_SigPrTar
12109:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12110:                     AND EMPTY(NVL(DtFims, {}))
12111:                 IF !EOF("cursor_4c_SigPrTar")
12112:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12113:                         CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12114:                     loc_lResultado = .F.
12115:                 ENDIF
12116:             ENDIF
12117:             IF loc_lResultado
12118:                 *-- Verificar se existe tarefa sem codigo informado
12119:                 SELECT cursor_4c_SigPrTar
12120:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12121:                     AND EMPTY(Tarefas)
12122:                 IF !EOF("cursor_4c_SigPrTar")
12123:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", "Aten" + CHR(231) + CHR(227) + "o")
12124:                     loc_lResultado = .F.
12125:                 ENDIF
12126:             ENDIF
12127:             IF loc_lResultado
12128:                 *-- Inserir nova tarefa com data/hora de inicio
12129:                 SELECT cursor_4c_SigPrTar
12130:                 APPEND BLANK
12131:                 REPLACE cursor_4c_SigPrTar.DtInis  WITH DATE()
12132:                 REPLACE cursor_4c_SigPrTar.Usuars  WITH PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
12133:                 REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
12134:                 REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
12135:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12136:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12137:                 ENDIF
12138:             ENDIF
12139:         CATCH TO loc_oErro
12140:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12141:         ENDTRY
12142:     ENDPROC
12143: 
12144:     *--------------------------------------------------------------------------

*-- Linhas 12168 a 12213:
12168:                 ENDIF
12169:             ENDIF
12170:             IF loc_lResultado
12171:                 SELECT cursor_4c_SigPrTar
12172:                 REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
12173:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12174:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12175:                 ENDIF
12176:             ENDIF
12177:         CATCH TO loc_oErro
12178:             MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
12179:         ENDTRY
12180:     ENDPROC
12181: 
12182:     *--------------------------------------------------------------------------
12183:     * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
12184:     * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
12185:     *--------------------------------------------------------------------------
12186:     PROCEDURE BtnInsArqsClick()
12187:         LOCAL loc_cArq, loc_lResultado
12188:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12189:             RETURN
12190:         ENDIF
12191:         loc_lResultado = .T.
12192:         TRY
12193:             loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
12194:             IF EMPTY(loc_cArq)
12195:                 loc_lResultado = .F.
12196:             ENDIF
12197:             IF loc_lResultado AND USED("cursor_4c_SigPrArq")
12198:                 SELECT cursor_4c_SigPrArq
12199:                 APPEND BLANK
12200:                 REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
12201:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12202:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12203:                 ENDIF
12204:             ENDIF
12205:         CATCH TO loc_oErro
12206:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12207:         ENDTRY
12208:     ENDPROC
12209: 
12210:     *--------------------------------------------------------------------------
12211:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
12212:     * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
12213:     *--------------------------------------------------------------------------

*-- Linhas 12243 a 12280:
12243: 
12244:     *--------------------------------------------------------------------------
12245:     * BtnExcArqsClick - Exclui arquivo da lista de arquivos designer
12246:     * Legado: btnExcArqs.Click - Delete In crSigPrArq + Refresh
12247:     *--------------------------------------------------------------------------
12248:     PROCEDURE BtnExcArqsClick()
12249:         LOCAL loc_lResultado
12250:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12251:             RETURN
12252:         ENDIF
12253:         loc_lResultado = .T.
12254:         TRY
12255:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12256:                 loc_lResultado = .F.
12257:             ENDIF
12258:             IF loc_lResultado
12259:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, "")))
12260:                     loc_lResultado = .F.
12261:                 ENDIF
12262:             ENDIF
12263:             IF loc_lResultado
12264:                 SELECT cursor_4c_SigPrArq
12265:                 DELETE
12266:                 IF !EOF("cursor_4c_SigPrArq")
12267:                     SKIP
12268:                     SKIP -1
12269:                 ENDIF
12270:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12271:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12272:                 ENDIF
12273:                 *-- Limpar imagem ao excluir arquivo
12274:                 LOCAL loc_oPg
12275:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12276:                 IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
12277:                     CLEAR RESOURCES
12278:                     loc_oPg.img_4c_ArqJpg.Picture = ""
12279:                     loc_oPg.img_4c_ArqJpg.Visible = .F.
12280:                 ENDIF

