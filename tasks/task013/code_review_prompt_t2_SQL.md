# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-COLUNA] Coluna '" + loc_cCols + "' em INSERT INTO SigCdPro NAO existe. Colunas validas: matprincs, dtcomps, cbars, cgrus, clfiscals, colecoes, comis, cpros, cunis, custofs, cvens, datas, datatrans, descfis, dpros, dtfilms, fcustos, figjpgs, flagctabs, fvendas, icms, ifors, linhas, locals, margems, moecs, moecusfs, moedas, moepcs, moepvs, moevs, notas, obspeds, obspes, origmercs, pcuss, pesoms, pvens, pvideals, qmins, reffs, sittricms, tcomps, tipos, transps, valors, varias, situas, dtincs, sgrus, metals, teors, cftios, codservs, mftios, pftios, codcors, codtams, compos, montadescs, digimaxs, ordcompos, ean13, cproeqs, qtdcpnts, impetiqs, chkfunds, casas, mercs, pesobs, tamhs, tamls, tamps, tptribs, volumes, ipis, dpro2s, dsccompras, encoms, figtecs, obscompras, codacbs, cravcers, cunips, obsetqs, ultcomps, vultcomps, multcomps, markupa, tinsts, cclass, nivelqs, cftiocs, pftiocs, usuincs, diasinas, idecpros, fabrproprs, qtminfabs, tents, codfinp, codmatp, dpro3s, consigs, ltminsv, status, aliqipis, codgarras, descecfs, encargos, idpro, nidentfixa, pesobris, pesometal, pesopdrs, extipi, iats, conquilhas, fatuals, fideals, contaccus, gruccus, dtsituas, prodvars, prodwebs, codident, conjunts, pmins, cotacalcp, qtdultcomp, figjpgs64, diasgar, chkgarvit, altura, largura, diametro, espessura, compriment, mohs, refracao, refracaodp, ativosite, categoria, codctgsite, coddptsite, custocp, dtlacto, foralinha, mostruario, mtiposervs, obsinsp, obsmkt, precode, prodnovo, prodoff, segfem, seginf, segkids, segmasc, seguni, semconsulta, skuvtex, varpesoms, dtalts, usuaalts, bestseller, obrtamser, prototipo, lancamento, fimdtlacto, origemlac, codmacro, reposauto, procfigjpgs, propriedades, unidade1, resultado1, valorminimo, valormaximo, metodoreferencia1, qtped

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (12589 linhas total):

*-- Linhas 488 a 563:
488:         *----------------------------------------------------------------------
489:         IF !USED("cursor_4c_Dados")
490:             SET NULL ON
491:             CREATE CURSOR cursor_4c_Dados (;
492:                 cpros    C(14), dpros  C(65), cgrus C(3), ;
493:                 sgrus    C(6),  reffs  C(40), ;
494:                 usuaalts C(20), situas N(1,0))
495:             SET NULL OFF
496:         ENDIF
497: 
498:         *----------------------------------------------------------------------
499:         *-- Grid principal da lista (Grade: Top=183, Left=5)
500:         *-- ColumnCount e Visible no WITH; RecordSource FORA do WITH
501:         *----------------------------------------------------------------------
502:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
503:         WITH loc_oPagina.grd_4c_Lista
504:             .Top         = 183
505:             .Left        = 5
506:             .Width       = 950
507:             .Height      = 389
508:             .ColumnCount = 7
509:             .Visible     = .T.
510:             .RecordMark   = .F.
511:             .DeleteMark   = .F.
512:         ENDWITH
513: 
514:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
515:         loc_oPagina.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
516: 
517:         *-- ControlSources e larguras APOS RecordSource
518:         loc_oPagina.grd_4c_Lista.Column1.ControlSource   = "cursor_4c_Dados.cpros"
519:         loc_oPagina.grd_4c_Lista.Column1.Width            = 70
520:         loc_oPagina.grd_4c_Lista.Column1.ReadOnly         = .T.
521:         loc_oPagina.grd_4c_Lista.Column1.Header1.Caption  = "Produto"
522: 
523:         loc_oPagina.grd_4c_Lista.Column2.ControlSource   = "cursor_4c_Dados.dpros"
524:         loc_oPagina.grd_4c_Lista.Column2.Width            = 315
525:         loc_oPagina.grd_4c_Lista.Column2.ReadOnly         = .T.
526:         loc_oPagina.grd_4c_Lista.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
527: 
528:         loc_oPagina.grd_4c_Lista.Column3.ControlSource   = "cursor_4c_Dados.cgrus"
529:         loc_oPagina.grd_4c_Lista.Column3.Width            = 55
530:         loc_oPagina.grd_4c_Lista.Column3.ReadOnly         = .T.
531:         loc_oPagina.grd_4c_Lista.Column3.Header1.Caption  = "Grupo"
532: 
533:         loc_oPagina.grd_4c_Lista.Column4.ControlSource   = "cursor_4c_Dados.sgrus"
534:         loc_oPagina.grd_4c_Lista.Column4.Width            = 70
535:         loc_oPagina.grd_4c_Lista.Column4.ReadOnly         = .T.
536:         loc_oPagina.grd_4c_Lista.Column4.Header1.Caption  = "Subgrp."
537: 
538:         loc_oPagina.grd_4c_Lista.Column5.ControlSource   = "cursor_4c_Dados.reffs"
539:         loc_oPagina.grd_4c_Lista.Column5.Width            = 225
540:         loc_oPagina.grd_4c_Lista.Column5.ReadOnly         = .T.
541:         loc_oPagina.grd_4c_Lista.Column5.Header1.Caption  = "Ref. Fornecedor"
542: 
543:         loc_oPagina.grd_4c_Lista.Column6.ControlSource   = "cursor_4c_Dados.usuaalts"
544:         loc_oPagina.grd_4c_Lista.Column6.Width            = 150
545:         loc_oPagina.grd_4c_Lista.Column6.ReadOnly         = .T.
546:         loc_oPagina.grd_4c_Lista.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
547: 
548:         loc_oPagina.grd_4c_Lista.Column7.ControlSource   = "cursor_4c_Dados.situas"
549:         loc_oPagina.grd_4c_Lista.Column7.Width            = 30
550:         loc_oPagina.grd_4c_Lista.Column7.ReadOnly         = .T.
551:         loc_oPagina.grd_4c_Lista.Column7.Header1.Caption  = "I"
552: 
553:         *-- Formatacao padrao (Verdana 8, gridlines, RowHeight=16)
554:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
555: 
556:         *-- Label de contagem de produtos (lblProdutos: Top=584 + 29 = 613 -> 575)
557:         loc_oPagina.AddObject("lbl_4c_Contagem", "Label")
558:         WITH loc_oPagina.lbl_4c_Contagem
559:             .Caption   = "Produtos Selecionados : 0"
560:             .Top       = 575
561:             .Left      = 38
562:             .Width     = 200
563:             .Height    = 15

*-- Linhas 741 a 789:
741:         *----------------------------------------------------------------------
742:         IF !USED("cursor_4c_Compo")
743:             SET NULL ON
744:             CREATE CURSOR cursor_4c_Compo (;
745:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
746:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
747:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
748:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
749:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
750:                 cgrus    C(3),  moeds    C(5))
751:             SET NULL OFF
752:         ENDIF
753: 
754:         *----------------------------------------------------------------------
755:         *-- Cursor placeholder para grdsubcp (SigSubCp)
756:         *----------------------------------------------------------------------
757:         IF !USED("cursor_4c_SubCp")
758:             SET NULL ON
759:             CREATE CURSOR cursor_4c_SubCp (;
760:                 cpros    C(14), mats     C(14), dcomps   C(65), ;
761:                 unicompos C(5), pcompos  N(12,4), qtds   N(12,4), ;
762:                 totals   N(12,4), bloqueio C(5), obscompos C(40), ;
763:                 etiq     C(1),  consumo  N(12,4), qtd2   N(12,4), ;
764:                 uni2     C(5),  ord      N(5,0),  matrizes C(14), ;
765:                 tamanhos C(20))
766:             SET NULL OFF
767:         ENDIF
768: 
769:         *----------------------------------------------------------------------
770:         *-- Cursor placeholder para GradeGRUPO (TotGrupo)
771:         *----------------------------------------------------------------------
772:         IF !USED("cursor_4c_Grupo")
773:             SET NULL ON
774:             CREATE CURSOR cursor_4c_Grupo (cgrus C(3), valgr N(12,4), moeds C(5))
775:             SET NULL OFF
776:         ENDIF
777: 
778:         *----------------------------------------------------------------------
779:         *-- Linha OBS da OF: Say4 + getObsOFs
780:         *-- Say4: "Obs. da OF :" (T:300 L:36 W:64)
781:         *-- getObsOFs: (T:297 L:99 W:850 H:21)
782:         *----------------------------------------------------------------------
783:         loc_oPg.AddObject("lbl_4c_ObsOF", "Label")
784:         WITH loc_oPg.lbl_4c_ObsOF
785:             .Caption   = "Obs. da OF :"
786:             .Top       = 300
787:             .Left      = 36
788:             .Width     = 64
789:             .Height    = 15

*-- Linhas 892 a 1008:
892:             .GridLineWidth = 1
893:             .GridLineColor = RGB(238, 238, 238)
894:             .RecordMark  = .F.
895:             .DeleteMark  = .F.
896:             .AllowRowSizing = .F.
897:             .ReadOnly    = .F.
898:             .BackColor   = RGB(255, 255, 255)
899:             .ForeColor   = RGB(90, 90, 90)
900:             .HighlightBackColor = RGB(220, 230, 242)
901:             .HighlightForeColor = RGB(15, 41, 104)
902:             .HighlightStyle = 2
903:             .RowHeight   = 16
904:             .ScrollBars  = 2
905:             .Visible     = .T.
906:         ENDWITH
907: 
908:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
909:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
910: 
911:         *-- Configurar colunas do grd_4c_Compo APOS RecordSource
912:         WITH loc_oPg.grd_4c_Compo
913:             *-- Col1: Material (C14) W:80
914:             .Column1.Header1.Caption       = "Material"
915:             .Column1.Width                 = 80
916:             .Column1.ControlSource         = "cursor_4c_Compo.mats"
917:             .Column1.Alignment             = 0
918: 
919:             *-- Col2: Descricao (C65) W:200
920:             .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
921:             .Column2.Width                 = 200
922:             .Column2.ControlSource         = "cursor_4c_Compo.dcomps"
923:             .Column2.Alignment             = 0
924: 
925:             *-- Col3: Un (C5) W:35 - readonly
926:             .Column3.Header1.Caption       = "Un"
927:             .Column3.Width                 = 35
928:             .Column3.ControlSource         = "cursor_4c_Compo.unicompos"
929:             .Column3.ReadOnly              = .T.
930: 
931:             *-- Col4: Valor (N) W:65
932:             .Column4.Header1.Caption       = "Valor"
933:             .Column4.Width                 = 65
934:             .Column4.ControlSource         = "cursor_4c_Compo.pcompos"
935:             .Column4.Alignment             = 1
936: 
937:             *-- Col5: Qtde (N) W:60
938:             .Column5.Header1.Caption       = "Qtde."
939:             .Column5.Width                 = 60
940:             .Column5.ControlSource         = "cursor_4c_Compo.qtds"
941:             .Column5.Alignment             = 1
942: 
943:             *-- Col6: Total (N) W:65 - readonly (calculado)
944:             .Column6.Header1.Caption       = "Total"
945:             .Column6.Width                 = 65
946:             .Column6.ControlSource         = "cursor_4c_Compo.totals"
947:             .Column6.Alignment             = 1
948:             .Column6.ReadOnly              = .T.
949: 
950:             *-- Col7: Moe (C5) W:35
951:             .Column7.Header1.Caption       = "Moe"
952:             .Column7.Width                 = 35
953:             .Column7.ControlSource         = "cursor_4c_Compo.bloqueio"
954: 
955:             *-- Col8: Observacao (C40) W:100
956:             .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
957:             .Column8.Width                 = 100
958:             .Column8.ControlSource         = "cursor_4c_Compo.obscompos"
959:             .Column8.Alignment             = 0
960: 
961:             *-- Col9: E (C1) W:25
962:             .Column9.Header1.Caption       = "E"
963:             .Column9.Width                 = 25
964:             .Column9.ControlSource         = "cursor_4c_Compo.etiq"
965: 
966:             *-- Col10: Consumo (N) W:65
967:             .Column10.Header1.Caption      = "Consumo"
968:             .Column10.Width                = 65
969:             .Column10.ControlSource        = "cursor_4c_Compo.consumo"
970:             .Column10.Alignment            = 1
971: 
972:             *-- Col11: Qtde cons (N) W:60
973:             .Column11.Header1.Caption      = "Qtde."
974:             .Column11.Width                = 60
975:             .Column11.ControlSource        = "cursor_4c_Compo.qtd2"
976:             .Column11.Alignment            = 1
977: 
978:             *-- Col12: Un cons (C5) W:35 - readonly
979:             .Column12.Header1.Caption      = "Un"
980:             .Column12.Width                = 35
981:             .Column12.ControlSource        = "cursor_4c_Compo.uni2"
982:             .Column12.ReadOnly             = .T.
983: 
984:             *-- Col13: Ord (N) W:35
985:             .Column13.Header1.Caption      = "Ord"
986:             .Column13.Width                = 35
987:             .Column13.ControlSource        = "cursor_4c_Compo.ord"
988:             .Column13.Alignment            = 1
989: 
990:             *-- Col14: Material alt (C14) W:83
991:             .Column14.Header1.Caption      = "Material"
992:             .Column14.Width                = 83
993:             .Column14.ControlSource        = "cursor_4c_Compo.matrizes"
994:         ENDWITH
995:         BINDEVENT(loc_oPg.grd_4c_Compo, "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
996: 
997:         *----------------------------------------------------------------------
998:         *-- Botoes do grdCompo (cmdgCompo: 5 botoes, Right of grid)
999:         *-- Container em T:145 L:947 W:50 H:210 (cada botao 50x42)
1000:         *----------------------------------------------------------------------
1001:         loc_oPg.AddObject("cnt_4c_BotoesCompo", "Container")
1002:         WITH loc_oPg.cnt_4c_BotoesCompo
1003:             .Top         = 145
1004:             .Left        = 947
1005:             .Width       = 50
1006:             .Height      = 210
1007:             .BackStyle = 1
1008:             .BackColor = RGB(53, 53, 53)

*-- Linhas 1119 a 1224:
1119:             .GridLineWidth = 1
1120:             .GridLineColor = RGB(238, 238, 238)
1121:             .RecordMark  = .F.
1122:             .DeleteMark  = .F.
1123:             .AllowRowSizing = .F.
1124:             .ReadOnly    = .F.
1125:             .BackColor   = RGB(255, 255, 255)
1126:             .ForeColor   = RGB(90, 90, 90)
1127:             .HighlightBackColor = RGB(220, 230, 242)
1128:             .HighlightForeColor = RGB(15, 41, 104)
1129:             .HighlightStyle = 2
1130:             .RowHeight   = 16
1131:             .ScrollBars  = 2
1132:             .Visible     = .T.
1133:         ENDWITH
1134: 
1135:         *-- RecordSource FORA do WITH
1136:         loc_oPg.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
1137: 
1138:         *-- Configurar colunas do grd_4c_SubCp APOS RecordSource
1139:         WITH loc_oPg.grd_4c_SubCp
1140:             .Column1.Header1.Caption       = "Material"
1141:             .Column1.Width                 = 75
1142:             .Column1.ControlSource         = "cursor_4c_SubCp.mats"
1143: 
1144:             .Column2.Header1.Caption       = "Descri" + CHR(231) + CHR(227) + "o"
1145:             .Column2.Width                 = 175
1146:             .Column2.ControlSource         = "cursor_4c_SubCp.dcomps"
1147:             .Column2.Alignment             = 0
1148: 
1149:             .Column3.Header1.Caption       = "Un"
1150:             .Column3.Width                 = 30
1151:             .Column3.ControlSource         = "cursor_4c_SubCp.unicompos"
1152:             .Column3.ReadOnly              = .T.
1153: 
1154:             .Column4.Header1.Caption       = "Valor"
1155:             .Column4.Width                 = 60
1156:             .Column4.ControlSource         = "cursor_4c_SubCp.pcompos"
1157:             .Column4.Alignment             = 1
1158: 
1159:             .Column5.Header1.Caption       = "Qtde."
1160:             .Column5.Width                 = 55
1161:             .Column5.ControlSource         = "cursor_4c_SubCp.qtds"
1162:             .Column5.Alignment             = 1
1163: 
1164:             .Column6.Header1.Caption       = "Total"
1165:             .Column6.Width                 = 60
1166:             .Column6.ControlSource         = "cursor_4c_SubCp.totals"
1167:             .Column6.Alignment             = 1
1168:             .Column6.ReadOnly              = .T.
1169: 
1170:             .Column7.Header1.Caption       = "Moe"
1171:             .Column7.Width                 = 30
1172:             .Column7.ControlSource         = "cursor_4c_SubCp.bloqueio"
1173: 
1174:             .Column8.Header1.Caption       = "Observa" + CHR(231) + CHR(227) + "o"
1175:             .Column8.Width                 = 90
1176:             .Column8.ControlSource         = "cursor_4c_SubCp.obscompos"
1177:             .Column8.Alignment             = 0
1178: 
1179:             .Column9.Header1.Caption       = "E"
1180:             .Column9.Width                 = 25
1181:             .Column9.ControlSource         = "cursor_4c_SubCp.etiq"
1182: 
1183:             .Column10.Header1.Caption      = "Consumo"
1184:             .Column10.Width                = 60
1185:             .Column10.ControlSource        = "cursor_4c_SubCp.consumo"
1186:             .Column10.Alignment            = 1
1187: 
1188:             .Column11.Header1.Caption      = "Qtde."
1189:             .Column11.Width                = 55
1190:             .Column11.ControlSource        = "cursor_4c_SubCp.qtd2"
1191:             .Column11.Alignment            = 1
1192: 
1193:             .Column12.Header1.Caption      = "Un"
1194:             .Column12.Width                = 30
1195:             .Column12.ControlSource        = "cursor_4c_SubCp.uni2"
1196:             .Column12.ReadOnly             = .T.
1197: 
1198:             .Column13.Header1.Caption      = "Ord"
1199:             .Column13.Width                = 30
1200:             .Column13.ControlSource        = "cursor_4c_SubCp.ord"
1201:             .Column13.Alignment            = 1
1202: 
1203:             .Column14.Header1.Caption      = "Material"
1204:             .Column14.Width                = 80
1205:             .Column14.ControlSource        = "cursor_4c_SubCp.matrizes"
1206: 
1207:             .Column15.Header1.Caption      = "Tam"
1208:             .Column15.Width                = 88
1209:             .Column15.ControlSource        = "cursor_4c_SubCp.tamanhos"
1210:             .Column15.Alignment            = 0
1211:         ENDWITH
1212:         BINDEVENT(loc_oPg.grd_4c_SubCp, "AfterRowColChange", THIS, "GrdSubCpAfterRowColChange")
1213: 
1214:         *----------------------------------------------------------------------
1215:         *-- Botoes do grdsubcp (cmdgSubCp: 2 botoes, Right of grid)
1216:         *-- Container em T:345 L:947 W:50 H:90 (cada botao 50x45)
1217:         *----------------------------------------------------------------------
1218:         loc_oPg.AddObject("cnt_4c_BotoesSubCp", "Container")
1219:         WITH loc_oPg.cnt_4c_BotoesSubCp
1220:             .Top         = 345
1221:             .Left        = 947
1222:             .Width       = 50
1223:             .Height      = 90
1224:             .BackStyle = 1

*-- Linhas 1347 a 1394:
1347:             .GridLineWidth = 1
1348:             .GridLineColor = RGB(238, 238, 238)
1349:             .RecordMark  = .F.
1350:             .DeleteMark  = .F.
1351:             .AllowRowSizing = .F.
1352:             .ReadOnly    = .T.
1353:             .BackColor   = RGB(255, 255, 255)
1354:             .ForeColor   = RGB(90, 90, 90)
1355:             .HighlightBackColor = RGB(220, 230, 242)
1356:             .HighlightForeColor = RGB(15, 41, 104)
1357:             .HighlightStyle = 2
1358:             .RowHeight   = 16
1359:             .ScrollBars  = 2
1360:             .Visible     = .T.
1361:         ENDWITH
1362: 
1363:         *-- RecordSource FORA do WITH
1364:         loc_oPg.grd_4c_Grupo.RecordSource = "cursor_4c_Grupo"
1365: 
1366:         *-- Colunas do GradeGRUPO APOS RecordSource
1367:         WITH loc_oPg.grd_4c_Grupo
1368:             .Column1.Header1.Caption = "Grupo"
1369:             .Column1.Width           = 50
1370:             .Column1.ControlSource   = "cursor_4c_Grupo.cgrus"
1371: 
1372:             .Column2.Header1.Caption = "Total"
1373:             .Column2.Width           = 100
1374:             .Column2.ControlSource   = "cursor_4c_Grupo.valgr"
1375:             .Column2.Alignment       = 1
1376: 
1377:             .Column3.Header1.Caption = "Moeda"
1378:             .Column3.Width           = 79
1379:             .Column3.ControlSource   = "cursor_4c_Grupo.moeds"
1380:         ENDWITH
1381: 
1382:         *----------------------------------------------------------------------
1383:         *-- Labels de secao Custo / Venda
1384:         *-- Say1: " Custo " (T:473 L:47 W:46 - secao de custo)
1385:         *-- Say2: " Venda " (T:474 L:361 W:48 - secao de venda)
1386:         *----------------------------------------------------------------------
1387:         loc_oPg.AddObject("lbl_4c_SecCusto", "Label")
1388:         WITH loc_oPg.lbl_4c_SecCusto
1389:             .Caption   = " Custo "
1390:             .Top       = 473
1391:             .Left      = 47
1392:             .Width     = 46
1393:             .Height    = 16
1394:             .FontName  = "Tahoma"

*-- Linhas 2569 a 2609:
2569:                 RETURN
2570:             ENDIF
2571:             IF USED("cursor_4c_Compo")
2572:                 SELECT cursor_4c_Compo
2573:                 APPEND BLANK
2574:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2575:             ENDIF
2576:         CATCH TO loc_oErro
2577:             MsgErro(loc_oErro.Message, "Erro ao inserir componente")
2578:         ENDTRY
2579:     ENDPROC
2580: 
2581:     *--------------------------------------------------------------------------
2582:     * CmdExcluirCompoClick - Remove linha da composicao
2583:     *--------------------------------------------------------------------------
2584:     PROCEDURE CmdExcluirCompoClick()
2585:         LOCAL loc_lConfirma
2586:         TRY
2587:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2588:                 RETURN
2589:             ENDIF
2590:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
2591:                 loc_lConfirma = MsgConfirma("Excluir componente selecionado?")
2592:                 IF loc_lConfirma
2593:                     SELECT cursor_4c_Compo
2594:                     DELETE
2595:                     IF !EOF()
2596:                         SKIP
2597:                         SKIP -1
2598:                     ENDIF
2599:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Compo.Refresh()
2600:                 ENDIF
2601:             ENDIF
2602:         CATCH TO loc_oErro
2603:             MsgErro(loc_oErro.Message, "Erro ao excluir componente")
2604:         ENDTRY
2605:     ENDPROC
2606: 
2607:     *--------------------------------------------------------------------------
2608:     * CmdCalcFornecClick - Recalcula precos de custo via fornecedor
2609:     *--------------------------------------------------------------------------

*-- Linhas 2664 a 2682:
2664:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo") AND ;
2665:                !EMPTY(cursor_4c_Compo.mats)
2666:                 IF USED("cursor_4c_SubCp")
2667:                     SELECT cursor_4c_SubCp
2668:                     APPEND BLANK
2669:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2670:                 ENDIF
2671:             ELSE
2672:                 MsgAviso("Selecione um componente antes de adicionar sub-componente.")
2673:             ENDIF
2674:         CATCH TO loc_oErro
2675:             MsgErro(loc_oErro.Message, "Erro ao inserir sub-componente")
2676:         ENDTRY
2677:     ENDPROC
2678: 
2679:     *--------------------------------------------------------------------------
2680:     * CmdExcluirSubCpClick - Remove linha do grid de sub-componentes
2681:     *--------------------------------------------------------------------------
2682:     PROCEDURE CmdExcluirSubCpClick()

*-- Linhas 2688 a 2707:
2688:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
2689:                 loc_lConfirma = MsgConfirma("Excluir sub-componente selecionado?")
2690:                 IF loc_lConfirma
2691:                     SELECT cursor_4c_SubCp
2692:                     DELETE
2693:                     IF !EOF()
2694:                         SKIP
2695:                         SKIP -1
2696:                     ENDIF
2697:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_SubCp.Refresh()
2698:                 ENDIF
2699:             ENDIF
2700:         CATCH TO loc_oErro
2701:             MsgErro(loc_oErro.Message, "Erro ao excluir sub-componente")
2702:         ENDTRY
2703:     ENDPROC
2704: 
2705:     *--------------------------------------------------------------------------
2706:     * CmdCalcValsClick - Calcular valores de preco/custo/venda
2707:     *--------------------------------------------------------------------------

*-- Linhas 2867 a 2900:
2867:     ENDPROC
2868: 
2869:     *--------------------------------------------------------------------------
2870:     * ValidarMoedaCompo - Valida codigo de moeda via SQLEXEC
2871:     *--------------------------------------------------------------------------
2872:     PROCEDURE ValidarMoedaCompo(par_cCampo)
2873:         LOCAL loc_oPg, loc_oCtrl, loc_cMoe, loc_nRet
2874:         TRY
2875:             IF NOT (TYPE("gnConnHandle") = "N" AND gnConnHandle > 0)
2876:                 RETURN
2877:             ENDIF
2878:             loc_oPg   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2879:             loc_oCtrl = EVALUATE("loc_oPg." + par_cCampo)
2880:             loc_cMoe  = ALLTRIM(loc_oCtrl.Value)
2881:             IF EMPTY(loc_cMoe)
2882:                 RETURN
2883:             ENDIF
2884:             loc_nRet = SQLEXEC(gnConnHandle, ;
2885:                 "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoe), ;
2886:                 "cursor_4c_TmpMoe")
2887:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_TmpMoe") < 1
2888:                 MsgAviso("Moeda '" + loc_cMoe + "' n" + CHR(227) + "o encontrada!")
2889:                 loc_oCtrl.Value = ""
2890:             ENDIF
2891:             IF USED("cursor_4c_TmpMoe")
2892:                 USE IN cursor_4c_TmpMoe
2893:             ENDIF
2894:         CATCH TO loc_oErro
2895:             MsgErro(loc_oErro.Message, "Erro ao validar moeda")
2896:         ENDTRY
2897:     ENDPROC
2898: 
2899:     *--------------------------------------------------------------------------
2900:     * CalcPrecoCompo - Chama calculo de preco pelo BO

*-- Linhas 2951 a 2970:
2951:             ENDIF
2952:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
2953:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_GetCmkpc.Value)
2954:             loc_nRet = SQLEXEC(gnConnHandle, ;
2955:                 "SELECT Cods, Descs, Moedas, Valors, TpFtios FROM SigPrFti WHERE Tipos = 1", ;
2956:                 "cursor_4c_ListaFtioCusto")
2957:             IF loc_nRet > 0
2958:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2959:                     "SigPrFti", "cursor_4c_BuscaFtioCusto", "Cods", loc_cAtual, ;
2960:                     "Fator de Custo")
2961:                 IF VARTYPE(loc_oBusca) = "O"
2962:                     IF !loc_oBusca.this_lAchouRegistro
2963:                         loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "d.")
2964:                         loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2965:                         loc_oBusca.mAddColuna("Moedas", "", "Moeda")
2966:                         loc_oBusca.Show()
2967:                     ENDIF
2968:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioCusto")
2969:                         loc_oPg.txt_4c_GetCmkpc.Value = ALLTRIM(cursor_4c_BuscaFtioCusto.Cods)
2970:                     ENDIF

*-- Linhas 3030 a 3049:
3030:             ENDIF
3031:             loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3032:             loc_cAtual = ALLTRIM(loc_oPg.txt_4c_Getftio.Value)
3033:             loc_nRet = SQLEXEC(gnConnHandle, ;
3034:                 "SELECT Cods, Descs FROM SigPrFti", ;
3035:                 "cursor_4c_ListaFtioVenda")
3036:             IF loc_nRet > 0
3037:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3038:                     "SigPrFti", "cursor_4c_BuscaFtioVenda", "Cods", loc_cAtual, ;
3039:                     "Fator de Venda")
3040:                 IF VARTYPE(loc_oBusca) = "O"
3041:                     IF !loc_oBusca.this_lAchouRegistro
3042:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
3043:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3044:                         loc_oBusca.Show()
3045:                     ENDIF
3046:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFtioVenda")
3047:                         loc_oPg.txt_4c_Getftio.Value = ALLTRIM(cursor_4c_BuscaFtioVenda.Cods)
3048:                     ENDIF
3049:                     loc_oBusca.Release()

*-- Linhas 3094 a 3113:
3094:             IF EMPTY(loc_cSts)
3095:                 RETURN
3096:             ENDIF
3097:             loc_nRet = SQLEXEC(gnConnHandle, ;
3098:                 "SELECT Cods FROM SigCdPst WHERE Cods = " + EscaparSQL(loc_cSts), ;
3099:                 "cursor_4c_TmpSts")
3100:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_TmpSts") < 1
3101:                 MsgAviso("Status '" + loc_cSts + "' n" + CHR(227) + "o encontrado!")
3102:                 loc_oPg.txt_4c_GetStatus.Value = ""
3103:             ENDIF
3104:             IF USED("cursor_4c_TmpSts")
3105:                 USE IN cursor_4c_TmpSts
3106:             ENDIF
3107:         CATCH TO loc_oErro
3108:             MsgErro(loc_oErro.Message, "Erro ao validar status")
3109:         ENDTRY
3110:     ENDPROC
3111: 
3112:     PROCEDURE AbrirLookupStatusCompo()
3113:         LOCAL loc_oPg, loc_oBusca, loc_cAtual

*-- Linhas 3201 a 3220:
3201:                 loc_oPg.txt_4c_Desc.Value = ""
3202:                 RETURN
3203:             ENDIF
3204:             loc_nRet = SQLEXEC(gnConnHandle, ;
3205:                 "SELECT cpros, dpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cMatP), ;
3206:                 "cursor_4c_TmpMatP")
3207:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpMatP") > 0
3208:                 loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_TmpMatP.dpros)
3209:             ELSE
3210:                 MsgAviso("Produto '" + loc_cMatP + "' n" + CHR(227) + "o encontrado!")
3211:                 loc_oPg.txt_4c_MatP.Value = ""
3212:                 loc_oPg.txt_4c_Desc.Value = ""
3213:             ENDIF
3214:             IF USED("cursor_4c_TmpMatP")
3215:                 USE IN cursor_4c_TmpMatP
3216:             ENDIF
3217:         CATCH TO loc_oErro
3218:             MsgErro(loc_oErro.Message, "Erro ao validar material principal")
3219:         ENDTRY
3220:     ENDPROC

*-- Linhas 3280 a 3298:
3280:             *-- Construir WHERE clause
3281:             loc_cFiltro = "situas BETWEEN " + TRANSFORM(loc_nSitI) + " AND " + TRANSFORM(loc_nSitF)
3282:             IF !EMPTY(loc_cCgru)
3283:                 loc_cFiltro = loc_cFiltro + " AND cgrus = " + EscaparSQL(loc_cCgru)
3284:             ENDIF
3285: 
3286:             *-- Buscar dados via BO (ZAP+APPEND preserva estrutura do cursor/grid)
3287:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
3288: 
3289:                 *-- Redefinir headers APOS cada Buscar() (VFP9 pode resetar)
3290:                 IF VARTYPE(loc_oPagina.grd_4c_Lista) = "O"
3291:                     loc_oGrid = loc_oPagina.grd_4c_Lista
3292:                     loc_oGrid.Column1.Header1.Caption = "Produto"
3293:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3294:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
3295:                     loc_oGrid.Column4.Header1.Caption = "Subgrp."
3296:                     loc_oGrid.Column5.Header1.Caption = "Ref. Fornecedor"
3297:                     loc_oGrid.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"
3298:                     loc_oGrid.Column7.Header1.Caption = "I"

*-- Linhas 3362 a 3381:
3362: 
3363:         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3364:             TRY
3365:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3366:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
3367:                     "cursor_4c_TmpGrupo")
3368: 
3369:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGrupo") > 0
3370:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_TmpGrupo.dgrus)
3371:                 ELSE
3372:                     MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
3373:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Cgru.Value = ""
3374:                     loc_oPagina.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
3375:                 ENDIF
3376: 
3377:                 IF USED("cursor_4c_TmpGrupo")
3378:                     USE IN cursor_4c_TmpGrupo
3379:                 ENDIF
3380:             CATCH TO loc_oErro
3381:                 MsgErro(loc_oErro.Message, "Erro ao validar grupo")

*-- Linhas 3490 a 3508:
3490:             .GridLineWidth      = 1
3491:             .GridLineColor      = RGB(238, 238, 238)
3492:             .RecordMark         = .F.
3493:             .DeleteMark         = .F.
3494:             .AllowRowSizing     = .F.
3495:             .ReadOnly           = .T.
3496:             .BackColor          = RGB(255, 255, 255)
3497:             .ForeColor          = RGB(90, 90, 90)
3498:             .HighlightBackColor = RGB(255, 255, 255)
3499:             .HighlightForeColor = RGB(15, 41, 104)
3500:             .HighlightStyle     = 2
3501:             .RowHeight          = 16
3502:             .ScrollBars         = 2
3503:         ENDWITH
3504:     ENDPROC
3505: 
3506:     *--------------------------------------------------------------------------
3507:     * BtnIncluirClick - Incluir novo produto
3508:     *--------------------------------------------------------------------------

*-- Linhas 4632 a 4708:
4632:             *-- Descricao do Grupo (cgrus -> SigCdGrp.dgrus)
4633:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4634:             IF !EMPTY(loc_cCod)
4635:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4636:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
4637:                     "cursor_4c_TmpDgru")
4638:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpDgru") > 0
4639:                     loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpDgru.dgrus)
4640:                 ENDIF
4641:                 IF USED("cursor_4c_TmpDgru")
4642:                     USE IN cursor_4c_TmpDgru
4643:                 ENDIF
4644:             ENDIF
4645: 
4646:             *-- Descricao do SubGrupo (sgrus -> SigCdPsg.descricaos, filtrado por cgrus)
4647:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4648:             IF !EMPTY(loc_cCod)
4649:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4650:                     "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cCod) + ;
4651:                     " AND cgrus = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CgruP.Value)), ;
4652:                     "cursor_4c_TmpSGru")
4653:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4654:                     loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4655:                 ENDIF
4656:                 IF USED("cursor_4c_TmpSGru")
4657:                     USE IN cursor_4c_TmpSGru
4658:                 ENDIF
4659:             ENDIF
4660: 
4661:             *-- Descricao da Linha (linhas -> SigCdLin.descs)
4662:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4663:             IF !EMPTY(loc_cCod)
4664:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4665:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
4666:                     "cursor_4c_TmpLin")
4667:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLin") > 0
4668:                     loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_TmpLin.descs)
4669:                 ENDIF
4670:                 IF USED("cursor_4c_TmpLin")
4671:                     USE IN cursor_4c_TmpLin
4672:                 ENDIF
4673:             ENDIF
4674: 
4675:             *-- Descricao do Grupo de Venda (colecoes -> SIGCDCOL.descs)
4676:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Col.Value)
4677:             IF !EMPTY(loc_cCod)
4678:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4679:                     "SELECT descs FROM SIGCDCOL WHERE colecoes = " + EscaparSQL(loc_cCod), ;
4680:                     "cursor_4c_TmpCol")
4681:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCol") > 0
4682:                     loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_TmpCol.descs)
4683:                 ENDIF
4684:                 IF USED("cursor_4c_TmpCol")
4685:                     USE IN cursor_4c_TmpCol
4686:                 ENDIF
4687:             ENDIF
4688: 
4689:             *-- Descricao do Fornecedor (ifors -> SigCdCli.rclis)
4690:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
4691:             IF !EMPTY(loc_cCod)
4692:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4693:                     "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCod), ;
4694:                     "cursor_4c_TmpIfor")
4695:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpIfor") > 0
4696:                     loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_TmpIfor.rclis)
4697:                 ENDIF
4698:                 IF USED("cursor_4c_TmpIfor")
4699:                     USE IN cursor_4c_TmpIfor
4700:                 ENDIF
4701:             ENDIF
4702: 
4703:         CATCH TO loc_oErro
4704:             MsgErro(loc_oErro.Message, "Erro ao preencher descri" + CHR(231) + CHR(245) + "es")
4705:         ENDTRY
4706:     ENDPROC
4707: 
4708:     *==========================================================================

*-- Linhas 4733 a 4752:
4733:         ENDIF
4734: 
4735:         TRY
4736:             loc_nRet = SQLEXEC(gnConnHandle, ;
4737:                 "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
4738:                 "cursor_4c_TmpGruP")
4739:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGruP") > 0
4740:                 loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpGruP.dgrus)
4741:                 *-- Limpar subgrupo ao trocar grupo
4742:                 loc_oPg.txt_4c_CSGru.Value = ""
4743:                 loc_oPg.txt_4c_DsGru.Value = ""
4744:             ELSE
4745:                 MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
4746:                 loc_oPg.txt_4c_CgruP.Value = ""
4747:                 loc_oPg.txt_4c_DgruP.Value = ""
4748:             ENDIF
4749:             IF USED("cursor_4c_TmpGruP")
4750:                 USE IN cursor_4c_TmpGruP
4751:             ENDIF
4752:         CATCH TO loc_oErro

*-- Linhas 4818 a 4838:
4818:         ENDIF
4819: 
4820:         TRY
4821:             loc_nRet = SQLEXEC(gnConnHandle, ;
4822:                 "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cSGru) + ;
4823:                 IIF(EMPTY(loc_cCgru), "", " AND cgrus = " + EscaparSQL(loc_cCgru)), ;
4824:                 "cursor_4c_TmpSGru")
4825:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4826:                 loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4827:             ELSE
4828:                 MsgAviso("Subgrupo '" + loc_cSGru + "' n" + CHR(227) + "o encontrado!")
4829:                 loc_oPg.txt_4c_CSGru.Value = ""
4830:                 loc_oPg.txt_4c_DsGru.Value = ""
4831:             ENDIF
4832:             IF USED("cursor_4c_TmpSGru")
4833:                 USE IN cursor_4c_TmpSGru
4834:             ENDIF
4835:         CATCH TO loc_oErro
4836:             MsgErro(loc_oErro.Message, "Erro ao validar subgrupo")
4837:         ENDTRY
4838:     ENDPROC

*-- Linhas 4847 a 4865:
4847:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4848:                 "SigCdPsg", "cursor_4c_BuscaSGru", "codigos", loc_cAtual, ;
4849:                 "Buscar Subgrupo", .F., .T., ;
4850:                 IIF(EMPTY(loc_cCgru), "", "cgrus = " + EscaparSQL(loc_cCgru)))
4851:             IF VARTYPE(loc_oBusca) = "O"
4852:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4853:                     IF USED("cursor_4c_BuscaSGru")
4854:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4855:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4856:                     ENDIF
4857:                 ELSE
4858:                     IF !loc_oBusca.this_lAchouRegistro
4859:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
4860:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4861:                     loc_oBusca.Show()
4862:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
4863:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4864:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4865:                     ENDIF

*-- Linhas 4898 a 4917:
4898:         ENDIF
4899: 
4900:         TRY
4901:             loc_nRet = SQLEXEC(gnConnHandle, ;
4902:                 "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cLin), ;
4903:                 "cursor_4c_TmpLin")
4904:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLin") > 0
4905:                 loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_TmpLin.descs)
4906:             ELSE
4907:                 MsgAviso("Linha '" + loc_cLin + "' n" + CHR(227) + "o encontrada!")
4908:                 loc_oPg.txt_4c_Lin.Value  = ""
4909:                 loc_oPg.txt_4c_DLin.Value = ""
4910:             ENDIF
4911:             IF USED("cursor_4c_TmpLin")
4912:                 USE IN cursor_4c_TmpLin
4913:             ENDIF
4914:         CATCH TO loc_oErro
4915:             MsgErro(loc_oErro.Message, "Erro ao validar linha")
4916:         ENDTRY
4917:     ENDPROC

*-- Linhas 4975 a 4994:
4975:         ENDIF
4976: 
4977:         TRY
4978:             loc_nRet = SQLEXEC(gnConnHandle, ;
4979:                 "SELECT descs FROM SIGCDCOL WHERE colecoes = " + EscaparSQL(loc_cCol), ;
4980:                 "cursor_4c_TmpCol")
4981:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCol") > 0
4982:                 loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_TmpCol.descs)
4983:             ELSE
4984:                 MsgAviso("Grupo de Venda '" + loc_cCol + "' n" + CHR(227) + "o encontrado!")
4985:                 loc_oPg.txt_4c_Col.Value  = ""
4986:                 loc_oPg.txt_4c_DCol.Value = ""
4987:             ENDIF
4988:             IF USED("cursor_4c_TmpCol")
4989:                 USE IN cursor_4c_TmpCol
4990:             ENDIF
4991:         CATCH TO loc_oErro
4992:             MsgErro(loc_oErro.Message, "Erro ao validar grupo de venda")
4993:         ENDTRY
4994:     ENDPROC

*-- Linhas 5052 a 5071:
5052:         ENDIF
5053: 
5054:         TRY
5055:             loc_nRet = SQLEXEC(gnConnHandle, ;
5056:                 "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cIfor), ;
5057:                 "cursor_4c_TmpIfor")
5058:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpIfor") > 0
5059:                 loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_TmpIfor.rclis)
5060:             ELSE
5061:                 MsgAviso("Fornecedor '" + loc_cIfor + "' n" + CHR(227) + "o encontrado!")
5062:                 loc_oPg.txt_4c_Ifor.Value = ""
5063:                 loc_oPg.txt_4c_Dfor.Value = ""
5064:             ENDIF
5065:             IF USED("cursor_4c_TmpIfor")
5066:                 USE IN cursor_4c_TmpIfor
5067:             ENDIF
5068:         CATCH TO loc_oErro
5069:             MsgErro(loc_oErro.Message, "Erro ao validar fornecedor")
5070:         ENDTRY
5071:     ENDPROC

*-- Linhas 5128 a 5147:
5128:         ENDIF
5129: 
5130:         TRY
5131:             loc_nRet = SQLEXEC(gnConnHandle, ;
5132:                 "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpro), ;
5133:                 "cursor_4c_TmpProEq")
5134:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpProEq") = 0
5135:                 MsgAviso("Produto equivalente '" + loc_cCpro + "' n" + CHR(227) + "o encontrado!")
5136:                 loc_oPg.txt_4c_CProEq.Value = ""
5137:             ENDIF
5138:             IF USED("cursor_4c_TmpProEq")
5139:                 USE IN cursor_4c_TmpProEq
5140:             ENDIF
5141:         CATCH TO loc_oErro
5142:             MsgErro(loc_oErro.Message, "Erro ao validar produto equivalente")
5143:         ENDTRY
5144:     ENDPROC
5145: 
5146:     PROCEDURE AbrirLookupProdEq()
5147:         LOCAL loc_oBusca, loc_oPg, loc_cAtual

*-- Linhas 5196 a 5215:
5196: 
5197:         TRY
5198:             *-- Busca conjuntos distintos ja cadastrados em SigCdPro
5199:             loc_nRet = SQLEXEC(gnConnHandle, ;
5200:                 "SELECT DISTINCT conjunts FROM SigCdPro WHERE LTRIM(RTRIM(conjunts)) <> '' ORDER BY conjunts", ;
5201:                 "cursor_4c_BuscaCnj")
5202: 
5203:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaCnj") > 0
5204:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5205:                 IF VARTYPE(loc_oBusca) = "O"
5206:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCnj"
5207:                     loc_oBusca.this_cTitulo        = "Buscar Conjunto"
5208:                     loc_oBusca.mAddColuna("conjunts", "", "Conjunto")
5209:                     loc_oBusca.Show()
5210:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnj")
5211:                         loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_BuscaCnj.conjunts)
5212:                     ENDIF
5213:                     loc_oBusca.Release()
5214:                 ENDIF
5215:             ENDIF

*-- Linhas 6683 a 6774:
6683:             *-- Descricao Unidade 1 (cunis -> SigCdUni.dunis)
6684:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6685:             IF !EMPTY(loc_cCod)
6686:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6687:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6688:                     "cursor_4c_TmpUni")
6689:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUni") > 0
6690:                     loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpUni.dunis)
6691:                 ENDIF
6692:                 IF USED("cursor_4c_TmpUni")
6693:                     USE IN cursor_4c_TmpUni
6694:                 ENDIF
6695:             ENDIF
6696: 
6697:             *-- Descricao Unidade 2 (cunips -> SigCdUni.dunis)
6698:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6699:             IF !EMPTY(loc_cCod)
6700:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6701:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6702:                     "cursor_4c_TmpUnip")
6703:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUnip") > 0
6704:                     loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpUnip.dunis)
6705:                 ENDIF
6706:                 IF USED("cursor_4c_TmpUnip")
6707:                     USE IN cursor_4c_TmpUnip
6708:                 ENDIF
6709:             ENDIF
6710: 
6711:             *-- Descricao Modelo (codfinp -> SigCdFip.descs)
6712:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6713:             IF !EMPTY(loc_cCod)
6714:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6715:                     "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6716:                     "cursor_4c_TmpFinP")
6717:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6718:                     loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6719:                 ENDIF
6720:                 IF USED("cursor_4c_TmpFinP")
6721:                     USE IN cursor_4c_TmpFinP
6722:                 ENDIF
6723:             ENDIF
6724: 
6725:             *-- Descricao Acabamento (codacbs -> SigCdAca.descrs)
6726:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
6727:             IF !EMPTY(loc_cCod)
6728:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6729:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
6730:                     "cursor_4c_TmpAcb")
6731:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
6732:                     loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
6733:                 ENDIF
6734:                 IF USED("cursor_4c_TmpAcb")
6735:                     USE IN cursor_4c_TmpAcb
6736:                 ENDIF
6737:             ENDIF
6738: 
6739:             *-- Descricao Classificacao (cclass -> SigCdCls.descs, filtrado por cgrus)
6740:             loc_cCod  = ALLTRIM(loc_oPg.txt_4c_Class.Value)
6741:             loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
6742:             IF !EMPTY(loc_cCod)
6743:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6744:                     "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
6745:                     IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
6746:                     "cursor_4c_TmpClass")
6747:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
6748:                     loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
6749:                 ENDIF
6750:                 IF USED("cursor_4c_TmpClass")
6751:                     USE IN cursor_4c_TmpClass
6752:                 ENDIF
6753:             ENDIF
6754: 
6755:             *-- Descricao Local (locals -> SigPrLcl.descricaos)
6756:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Local.Value)
6757:             IF !EMPTY(loc_cCod)
6758:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6759:                     "SELECT descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
6760:                     "cursor_4c_TmpLocal")
6761:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLocal") > 0
6762:                     *-- Local nao tem campo descricao visivel separado, apenas atualiza silenciosamente
6763:                     *-- O campo txt_4c_Local ja exibe o codigo (10 chars)
6764:                 ENDIF
6765:                 IF USED("cursor_4c_TmpLocal")
6766:                     USE IN cursor_4c_TmpLocal
6767:                 ENDIF
6768:             ENDIF
6769: 
6770:         CATCH TO loc_oErro
6771:             MsgErro(loc_oErro.Message, "Erro ao preencher descri" + CHR(231) + CHR(245) + "es P2")
6772:         ENDTRY
6773:     ENDPROC
6774: 

*-- Linhas 6800 a 6819:
6800:         ENDIF
6801: 
6802:         TRY
6803:             loc_nRet = SQLEXEC(gnConnHandle, ;
6804:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCuni), ;
6805:                 "cursor_4c_TmpCuni")
6806:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCuni") > 0
6807:                 loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpCuni.dunis)
6808:             ELSE
6809:                 MsgAviso("Unidade '" + loc_cCuni + "' n" + CHR(227) + "o encontrada!")
6810:                 loc_oPg.txt_4c_Cuni.Value = ""
6811:                 loc_oPg.txt_4c_DUni.Value = ""
6812:             ENDIF
6813:             IF USED("cursor_4c_TmpCuni")
6814:                 USE IN cursor_4c_TmpCuni
6815:             ENDIF
6816:         CATCH TO loc_oErro
6817:             MsgErro(loc_oErro.Message, "Erro ao validar unidade")
6818:         ENDTRY
6819:     ENDPROC

*-- Linhas 6877 a 6896:
6877:         ENDIF
6878: 
6879:         TRY
6880:             loc_nRet = SQLEXEC(gnConnHandle, ;
6881:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCunip), ;
6882:                 "cursor_4c_TmpCunip")
6883:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCunip") > 0
6884:                 loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpCunip.dunis)
6885:             ELSE
6886:                 MsgAviso("Unidade '" + loc_cCunip + "' n" + CHR(227) + "o encontrada!")
6887:                 loc_oPg.txt_4c_Cunip.Value = ""
6888:                 loc_oPg.txt_4c_DUnip.Value = ""
6889:             ENDIF
6890:             IF USED("cursor_4c_TmpCunip")
6891:                 USE IN cursor_4c_TmpCunip
6892:             ENDIF
6893:         CATCH TO loc_oErro
6894:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
6895:         ENDTRY
6896:     ENDPROC

*-- Linhas 6954 a 6973:
6954:         ENDIF
6955: 
6956:         TRY
6957:             loc_nRet = SQLEXEC(gnConnHandle, ;
6958:                 "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6959:                 "cursor_4c_TmpFinP")
6960:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6961:                 loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6962:             ELSE
6963:                 MsgAviso("Modelo '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
6964:                 loc_oPg.txt_4c_CodFinP.Value = ""
6965:                 loc_oPg.txt_4c_DFinP.Value   = ""
6966:             ENDIF
6967:             IF USED("cursor_4c_TmpFinP")
6968:                 USE IN cursor_4c_TmpFinP
6969:             ENDIF
6970:         CATCH TO loc_oErro
6971:             MsgErro(loc_oErro.Message, "Erro ao validar modelo")
6972:         ENDTRY
6973:     ENDPROC

*-- Linhas 7031 a 7050:
7031:         ENDIF
7032: 
7033:         TRY
7034:             loc_nRet = SQLEXEC(gnConnHandle, ;
7035:                 "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
7036:                 "cursor_4c_TmpAcb")
7037:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
7038:                 loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
7039:             ELSE
7040:                 MsgAviso("Acabamento '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7041:                 loc_oPg.txt_4c_CodAcb.Value = ""
7042:                 loc_oPg.txt_4c_DAcb.Value   = ""
7043:             ENDIF
7044:             IF USED("cursor_4c_TmpAcb")
7045:                 USE IN cursor_4c_TmpAcb
7046:             ENDIF
7047:         CATCH TO loc_oErro
7048:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
7049:         ENDTRY
7050:     ENDPROC

*-- Linhas 7110 a 7130:
7110:         ENDIF
7111: 
7112:         TRY
7113:             loc_nRet = SQLEXEC(gnConnHandle, ;
7114:                 "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
7115:                 IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
7116:                 "cursor_4c_TmpClass")
7117:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
7118:                 loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
7119:             ELSE
7120:                 MsgAviso("Classifica" + CHR(231) + CHR(227) + "o '" + loc_cCod + "' n" + CHR(227) + "o encontrada!")
7121:                 loc_oPg.txt_4c_Class.Value  = ""
7122:                 loc_oPg.txt_4c_DClass.Value = ""
7123:             ENDIF
7124:             IF USED("cursor_4c_TmpClass")
7125:                 USE IN cursor_4c_TmpClass
7126:             ENDIF
7127:         CATCH TO loc_oErro
7128:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
7129:         ENDTRY
7130:     ENDPROC

*-- Linhas 7139 a 7157:
7139:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7140:                 "SigCdCls", "cursor_4c_BuscaClass", "cods", loc_cAtual, ;
7141:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o", .F., .T., ;
7142:                 IIF(EMPTY(loc_cCgru), "", "(cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"))
7143:             IF VARTYPE(loc_oBusca) = "O"
7144:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7145:                     IF USED("cursor_4c_BuscaClass")
7146:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7147:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7148:                     ENDIF
7149:                 ELSE
7150:                     IF !loc_oBusca.this_lAchouRegistro
7151:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
7152:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7153:                     loc_oBusca.Show()
7154:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
7155:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7156:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7157:                     ENDIF

*-- Linhas 7189 a 7208:
7189:         ENDIF
7190: 
7191:         TRY
7192:             loc_nRet = SQLEXEC(gnConnHandle, ;
7193:                 "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
7194:                 "cursor_4c_TmpLocal")
7195:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpLocal") = 0
7196:                 MsgAviso("Local '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7197:                 loc_oPg.txt_4c_Local.Value = ""
7198:             ENDIF
7199:             IF USED("cursor_4c_TmpLocal")
7200:                 USE IN cursor_4c_TmpLocal
7201:             ENDIF
7202:         CATCH TO loc_oErro
7203:             MsgErro(loc_oErro.Message, "Erro ao validar local")
7204:         ENDTRY
7205:     ENDPROC
7206: 
7207:     PROCEDURE AbrirLookupLocal()
7208:         LOCAL loc_oBusca, loc_oPg, loc_cAtual

*-- Linhas 7256 a 7293:
7256:         *----------------------------------------------------------------------
7257:         IF !USED("cursor_4c_GrdCons")
7258:             SET NULL ON
7259:             CREATE CURSOR cursor_4c_GrdCons (;
7260:                 mats      C(14), ;
7261:                 qtds      N(12,4), ;
7262:                 unicompos C(5), ;
7263:                 Grupos    C(3), ;
7264:                 Descrs    C(65), ;
7265:                 Ordems    N(5,0), ;
7266:                 consumo   N(12,4), ;
7267:                 Cods      C(5), ;
7268:                 dcats     C(65), ;
7269:                 Dopes     C(5))
7270:             SET NULL OFF
7271:         ENDIF
7272: 
7273:         *----------------------------------------------------------------------
7274:         *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
7275:         *----------------------------------------------------------------------
7276:         IF !USED("cursor_4c_GrDTEMP")
7277:             SET NULL ON
7278:             CREATE CURSOR cursor_4c_GrDTEMP (;
7279:                 agrup C(30), ;
7280:                 tempo N(12,4))
7281:             SET NULL OFF
7282:         ENDIF
7283: 
7284:         *----------------------------------------------------------------------
7285:         *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
7286:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
7287:         *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao
7288:         *----------------------------------------------------------------------
7289:         loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
7290:         loc_oGrd = loc_oPg.grd_4c_GrdCons
7291: 
7292:         WITH loc_oGrd
7293:             .Top              = 155

*-- Linhas 7301 a 7397:
7301:             .GridLineWidth    = 1
7302:             .GridLineColor    = RGB(238, 238, 238)
7303:             .RecordMark       = .F.
7304:             .DeleteMark       = .F.
7305:             .AllowRowSizing   = .F.
7306:             .ReadOnly         = .F.
7307:             .BackColor        = RGB(255, 255, 255)
7308:             .ForeColor        = RGB(90, 90, 90)
7309:             .HighlightBackColor = RGB(220, 230, 242)
7310:             .HighlightForeColor = RGB(15, 41, 104)
7311:             .HighlightStyle   = 2
7312:             .RowHeight        = 16
7313:             .ScrollBars       = 2
7314:             .Themes           = .F.
7315:             .Visible          = .T.
7316:         ENDWITH
7317: 
7318:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7319:         loc_oPg.grd_4c_GrdCons.RecordSource = "cursor_4c_GrdCons"
7320: 
7321:         *-- Configurar colunas APOS RecordSource
7322:         WITH loc_oPg.grd_4c_GrdCons
7323:             *-- Col1: Componente (mats C14) W:140 - readonly
7324:             .Column1.Header1.Caption = "Componente"
7325:             .Column1.Width           = 140
7326:             .Column1.ControlSource   = "cursor_4c_GrdCons.mats"
7327:             .Column1.Alignment       = 0
7328:             .Column1.ReadOnly        = .T.
7329: 
7330:             *-- Col2: Qtde. (qtds N) W:70 - readonly
7331:             .Column2.Header1.Caption = "Qtde."
7332:             .Column2.Width           = 70
7333:             .Column2.ControlSource   = "cursor_4c_GrdCons.qtds"
7334:             .Column2.Alignment       = 1
7335:             .Column2.ReadOnly        = .T.
7336: 
7337:             *-- Col3: Uni (unicompos C5) W:40 - readonly
7338:             .Column3.Header1.Caption = "Uni"
7339:             .Column3.Width           = 40
7340:             .Column3.ControlSource   = "cursor_4c_GrdCons.unicompos"
7341:             .Column3.Alignment       = 0
7342:             .Column3.ReadOnly        = .T.
7343: 
7344:             *-- Col4: Fase (Grupos C3) W:45 - editable, F4 abre lookup SigCdPrf
7345:             .Column4.Header1.Caption = "Fase"
7346:             .Column4.Width           = 45
7347:             .Column4.ControlSource   = "cursor_4c_GrdCons.Grupos"
7348:             .Column4.Alignment       = 0
7349:             .Column4.ReadOnly        = .F.
7350: 
7351:             *-- Col5: Descricao de fase (Descrs C65) W:250 - editable quando Col4 vazia
7352:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7353:             .Column5.Width           = 250
7354:             .Column5.ControlSource   = "cursor_4c_GrdCons.Descrs"
7355:             .Column5.Alignment       = 0
7356:             .Column5.ReadOnly        = .F.
7357: 
7358:             *-- Col6: Ord. (Ordems N) W:40 - readonly
7359:             .Column6.Header1.Caption = "Ord."
7360:             .Column6.Width           = 40
7361:             .Column6.ControlSource   = "cursor_4c_GrdCons.Ordems"
7362:             .Column6.Alignment       = 1
7363:             .Column6.ReadOnly        = .T.
7364: 
7365:             *-- Col7: Consumo (consumo N) W:80 - editable em INCLUIR/ALTERAR
7366:             .Column7.Header1.Caption = "Consumo"
7367:             .Column7.Width           = 80
7368:             .Column7.ControlSource   = "cursor_4c_GrdCons.consumo"
7369:             .Column7.Alignment       = 1
7370:             .Column7.ReadOnly        = .F.
7371: 
7372:             *-- Col8: Cat. (Cods C5) W:45 - editable, F4 abre lookup SigCdCat
7373:             .Column8.Header1.Caption = "Cat."
7374:             .Column8.Width           = 45
7375:             .Column8.ControlSource   = "cursor_4c_GrdCons.Cods"
7376:             .Column8.Alignment       = 0
7377:             .Column8.ReadOnly        = .F.
7378: 
7379:             *-- Col9: Descricao de categoria (dcats C65) W:277 - editable
7380:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7381:             .Column9.Width           = 277
7382:             .Column9.ControlSource   = "cursor_4c_GrdCons.dcats"
7383:             .Column9.Alignment       = 0
7384:             .Column9.ReadOnly        = .F.
7385:         ENDWITH
7386: 
7387:         *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
7388:         BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
7389:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
7390:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
7391:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
7392: 
7393:         *----------------------------------------------------------------------
7394:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7395:         *----------------------------------------------------------------------
7396:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7397:         WITH loc_oPg.lbl_4c_Label7

*-- Linhas 7484 a 7531:
7484:             .GridLineWidth    = 1
7485:             .GridLineColor    = RGB(238, 238, 238)
7486:             .RecordMark       = .F.
7487:             .DeleteMark       = .F.
7488:             .AllowRowSizing   = .F.
7489:             .ReadOnly         = .T.
7490:             .BackColor        = RGB(255, 255, 255)
7491:             .ForeColor        = RGB(90, 90, 90)
7492:             .HighlightBackColor = RGB(220, 230, 242)
7493:             .HighlightForeColor = RGB(15, 41, 104)
7494:             .HighlightStyle   = 2
7495:             .RowHeight        = 16
7496:             .ScrollBars       = 2
7497:             .Themes           = .F.
7498:             .Visible          = .T.
7499:         ENDWITH
7500: 
7501:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7502:         loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
7503: 
7504:         *-- Configurar colunas do grDTEMP APOS RecordSource
7505:         WITH loc_oPg.grd_4c_GrDTEMP
7506:             *-- Col1: Agrupamento (agrup C30) W:100 - readonly
7507:             .Column1.Header1.Caption = "Agrupamento"
7508:             .Column1.Width           = 100
7509:             .Column1.ControlSource   = "cursor_4c_GrDTEMP.agrup"
7510:             .Column1.Alignment       = 0
7511:             .Column1.ReadOnly        = .T.
7512: 
7513:             *-- Col2: Tempo % (tempo N) W:72 - readonly
7514:             .Column2.Header1.Caption = "Tempo %"
7515:             .Column2.Width           = 72
7516:             .Column2.ControlSource   = "cursor_4c_GrDTEMP.tempo"
7517:             .Column2.Alignment       = 1
7518:             .Column2.ReadOnly        = .T.
7519:         ENDWITH
7520: 
7521:     ENDPROC
7522: 
7523:     *==========================================================================
7524:     * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
7525:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
7526:     *==========================================================================
7527: 
7528:     *--------------------------------------------------------------------------
7529:     * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
7530:     *--------------------------------------------------------------------------
7531:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)

*-- Linhas 7564 a 7582:
7564:                     ENDIF
7565:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
7566:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7567:                             SELECT cursor_4c_GrdCons
7568:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
7569:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
7570:                         ENDIF
7571:                     ENDIF
7572:                     loc_oBusca.Release()
7573:                 ENDIF
7574:                 IF USED("cursor_4c_BuscaPrf")
7575:                     USE IN cursor_4c_BuscaPrf
7576:                 ENDIF
7577:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7578:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7579:                 ENDIF
7580:             CATCH TO loc_oErro
7581:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
7582:             ENDTRY

*-- Linhas 7620 a 7638:
7620:                     ENDIF
7621:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
7622:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7623:                             SELECT cursor_4c_GrdCons
7624:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
7625:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
7626:                             IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
7627:                                 REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
7628:                             ENDIF
7629:                             IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
7630:                                 REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
7631:                             ENDIF
7632:                         ENDIF
7633:                     ENDIF
7634:                     loc_oBusca.Release()
7635:                 ENDIF
7636:                 IF USED("cursor_4c_BuscaPrf2")
7637:                     USE IN cursor_4c_BuscaPrf2
7638:                 ENDIF

*-- Linhas 7672 a 7690:
7672:                     ENDIF
7673:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
7674:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7675:                             SELECT cursor_4c_GrdCons
7676:                             REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
7677:                             REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
7678:                         ENDIF
7679:                     ENDIF
7680:                     loc_oBusca.Release()
7681:                 ENDIF
7682:                 IF USED("cursor_4c_BuscaCat")
7683:                     USE IN cursor_4c_BuscaCat
7684:                 ENDIF
7685:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7686:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7687:                 ENDIF
7688:             CATCH TO loc_oErro
7689:                 MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
7690:             ENDTRY

*-- Linhas 7762 a 7866:
7762:             .GridLineWidth     = 1
7763:             .GridLineColor     = RGB(238, 238, 238)
7764:             .RecordMark        = .F.
7765:             .DeleteMark        = .F.
7766:             .AllowRowSizing    = .F.
7767:             .ReadOnly          = .F.
7768:             .BackColor         = RGB(255, 255, 255)
7769:             .ForeColor         = RGB(90, 90, 90)
7770:             .HighlightBackColor = RGB(220, 230, 242)
7771:             .HighlightForeColor = RGB(15, 41, 104)
7772:             .HighlightStyle    = 2
7773:             .RowHeight         = 16
7774:             .ScrollBars        = 2
7775:             .Visible           = .T.
7776:         ENDWITH
7777: 
7778:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7779:         loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"
7780: 
7781:         *-- Configurar colunas APOS RecordSource
7782:         WITH loc_oPg.grd_4c_CustoCompo
7783:             *-- Col1: Item/Material (C14) W:80
7784:             .Column1.Header1.Caption   = "Item"
7785:             .Column1.Width             = 80
7786:             .Column1.ControlSource     = "cursor_4c_Compo.mats"
7787:             .Column1.Alignment         = 0
7788: 
7789:             *-- Col2: Descricao (C65) W:185
7790:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
7791:             .Column2.Width             = 185
7792:             .Column2.ControlSource     = "cursor_4c_Compo.dcomps"
7793:             .Column2.Alignment         = 0
7794: 
7795:             *-- Col3: Un (C5) W:35 - readonly (When=.F.)
7796:             .Column3.Header1.Caption   = "Un"
7797:             .Column3.Width             = 35
7798:             .Column3.ControlSource     = "cursor_4c_Compo.unicompos"
7799:             .Column3.ReadOnly          = .T.
7800: 
7801:             *-- Col4: Valor (N12,4) W:65
7802:             .Column4.Header1.Caption   = "Valor"
7803:             .Column4.Width             = 65
7804:             .Column4.ControlSource     = "cursor_4c_Compo.pcompos"
7805:             .Column4.Alignment         = 1
7806: 
7807:             *-- Col5: Qtd (N12,4) W:55
7808:             .Column5.Header1.Caption   = "Qtd"
7809:             .Column5.Width             = 55
7810:             .Column5.ControlSource     = "cursor_4c_Compo.qtds"
7811:             .Column5.Alignment         = 1
7812: 
7813:             *-- Col6: Total (N12,4) W:65 - readonly (calculado, When=.F.)
7814:             .Column6.Header1.Caption   = "Total"
7815:             .Column6.Width             = 65
7816:             .Column6.ControlSource     = "cursor_4c_Compo.totals"
7817:             .Column6.Alignment         = 1
7818:             .Column6.ReadOnly          = .T.
7819: 
7820:             *-- Col7: Moe/Moeda (C5) W:35
7821:             .Column7.Header1.Caption   = "Moe"
7822:             .Column7.Width             = 35
7823:             .Column7.ControlSource     = "cursor_4c_Compo.bloqueio"
7824: 
7825:             *-- Col8: Observacao (C40) W:95
7826:             .Column8.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
7827:             .Column8.Width             = 95
7828:             .Column8.ControlSource     = "cursor_4c_Compo.obscompos"
7829:             .Column8.Alignment         = 0
7830: 
7831:             *-- Col9: Etiq (C1) W:30
7832:             .Column9.Header1.Caption   = "Etiq"
7833:             .Column9.Width             = 30
7834:             .Column9.ControlSource     = "cursor_4c_Compo.etiq"
7835: 
7836:             *-- Col10: Consumo (N12,4) W:65
7837:             .Column10.Header1.Caption  = "Consumo"
7838:             .Column10.Width            = 65
7839:             .Column10.ControlSource    = "cursor_4c_Compo.consumo"
7840:             .Column10.Alignment        = 1
7841: 
7842:             *-- Col11: Qtd cons (N12,4) W:55
7843:             .Column11.Header1.Caption  = "Qtd"
7844:             .Column11.Width            = 55
7845:             .Column11.ControlSource    = "cursor_4c_Compo.qtd2"
7846:             .Column11.Alignment        = 1
7847: 
7848:             *-- Col12: Un cons (C5) W:30 - readonly (When=.F.)
7849:             .Column12.Header1.Caption  = "Un"
7850:             .Column12.Width            = 30
7851:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7852:             .Column12.ReadOnly         = .T.
7853:         ENDWITH
7854:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7855: 
7856:         *----------------------------------------------------------------------
7857:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7858:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7859:         *----------------------------------------------------------------------
7860:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7861:         WITH loc_oPg.cnt_4c_BotoesCusto
7862:             .Top         = 240
7863:             .Left        = 851
7864:             .Width       = 50
7865:             .Height      = 90
7866:             .BackStyle = 1

*-- Linhas 8019 a 8089:
8019:             .GridLineWidth     = 1
8020:             .GridLineColor     = RGB(238, 238, 238)
8021:             .RecordMark        = .F.
8022:             .DeleteMark        = .F.
8023:             .AllowRowSizing    = .F.
8024:             .ReadOnly          = .T.
8025:             .BackColor         = RGB(255, 255, 255)
8026:             .ForeColor         = RGB(90, 90, 90)
8027:             .HighlightBackColor = RGB(220, 230, 242)
8028:             .HighlightForeColor = RGB(15, 41, 104)
8029:             .HighlightStyle    = 2
8030:             .RowHeight         = 16
8031:             .ScrollBars        = 2
8032:             .Visible           = .T.
8033:         ENDWITH
8034: 
8035:         *-- RecordSource FORA do WITH
8036:         loc_oPg.grd_4c_GrupoCusto.RecordSource = "cursor_4c_Grupo"
8037: 
8038:         *-- Configurar colunas APOS RecordSource
8039:         WITH loc_oPg.grd_4c_GrupoCusto
8040:             *-- Col1: Grupo (C3) W:40 - readonly
8041:             .Column1.Header1.Caption   = "Grp"
8042:             .Column1.Width             = 40
8043:             .Column1.ControlSource     = "cursor_4c_Grupo.cgrus"
8044:             .Column1.ReadOnly          = .T.
8045: 
8046:             *-- Col2: Total (N12,4) W:100 - readonly
8047:             .Column2.Header1.Caption   = "Total"
8048:             .Column2.Width             = 100
8049:             .Column2.ControlSource     = "cursor_4c_Grupo.valgr"
8050:             .Column2.Alignment         = 1
8051:             .Column2.ReadOnly          = .T.
8052: 
8053:             *-- Col3: Moeda (C5) W:50 - readonly
8054:             .Column3.Header1.Caption   = "Moe"
8055:             .Column3.Width             = 50
8056:             .Column3.ControlSource     = "cursor_4c_Grupo.moeds"
8057:             .Column3.ReadOnly          = .T.
8058:         ENDWITH
8059:     ENDPROC
8060: 
8061:     *--------------------------------------------------------------------------
8062:     * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
8063:     *--------------------------------------------------------------------------
8064:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
8065:         LOCAL loc_oPg, loc_nRet
8066:         TRY
8067:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8068:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
8069:                 loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
8070:                 *-- Buscar descricao do grupo
8071:                 IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
8072:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8073:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
8074:                         EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
8075:                         "cursor_4c_TmpGrpCusto")
8076:                     IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
8077:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)
8078:                     ELSE
8079:                         loc_oPg.txt_4c_DGruCompos.Value = ""
8080:                     ENDIF
8081:                     IF USED("cursor_4c_TmpGrpCusto")
8082:                         USE IN cursor_4c_TmpGrpCusto
8083:                     ENDIF
8084:                 ELSE
8085:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8086:                 ENDIF
8087:             ENDIF
8088:         CATCH TO loc_oErro
8089:             *-- silencioso: refresh de display nao deve bloquear navegacao

*-- Linhas 8121 a 8167:
8121:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
8122:             ENDIF
8123:             IF USED("cursor_4c_Compo")
8124:                 SELECT cursor_4c_Compo
8125:                 GO TOP IN cursor_4c_Compo
8126:                 LOCATE FOR EMPTY(mats)
8127:                 IF EOF("cursor_4c_Compo")
8128:                     INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
8129:                 ENDIF
8130:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8131:                 IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
8132:                     loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
8133:                 ENDIF
8134:             ENDIF
8135:         CATCH TO loc_oErro
8136:             MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
8137:         ENDTRY
8138:     ENDPROC
8139: 
8140:     *--------------------------------------------------------------------------
8141:     * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
8142:     *--------------------------------------------------------------------------
8143:     PROCEDURE CmdExcluirCustoClick()
8144:         LOCAL loc_oPg
8145:         TRY
8146:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8147:                 RETURN
8148:             ENDIF
8149:             IF USED("cursor_4c_Compo")
8150:                 SELECT cursor_4c_Compo
8151:                 IF !EOF("cursor_4c_Compo")
8152:                     DELETE
8153:                     IF !EOF("cursor_4c_Compo")
8154:                         SKIP
8155:                         SKIP -1
8156:                     ENDIF
8157:                     GO BOTTOM IN cursor_4c_Compo
8158:                 ENDIF
8159:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8160:                 loc_oPg.grd_4c_CustoCompo.SetFocus()
8161:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8162:             ENDIF
8163:         CATCH TO loc_oErro
8164:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8165:         ENDTRY
8166:     ENDPROC
8167: 

*-- Linhas 8198 a 8238:
8198:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8199: 
8200:         *----------------------------------------------------------------------
8201:         *-- Cursor placeholder cursor_4c_GradFase (SigCdPrf + SigCdGcr JOIN)
8202:         *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
8203:         *----------------------------------------------------------------------
8204:         IF !USED("cursor_4c_GradFase")
8205:             SET NULL ON
8206:             CREATE CURSOR cursor_4c_GradFase (;
8207:                 Ordems   N(5,0), ;
8208:                 Grupos   C(10), ;
8209:                 Descrs   C(65), ;
8210:                 UniPrdts C(10), ;
8211:                 MatPrdts C(15), ;
8212:                 Obs      M, ;
8213:                 FigProcs M)
8214:             SET NULL OFF
8215:         ENDIF
8216: 
8217:         *----------------------------------------------------------------------
8218:         *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
8219:         *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
8220:         *----------------------------------------------------------------------
8221:         IF !USED("cursor_4c_SigPrMtz")
8222:             SET NULL ON
8223:             CREATE CURSOR cursor_4c_SigPrMtz (;
8224:                 CMats C(14), ;
8225:                 DLocs C(40), ;
8226:                 Qtds  N(3,0))
8227:             SET NULL OFF
8228:         ENDIF
8229: 
8230:         *----------------------------------------------------------------------
8231:         *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
8232:         *----------------------------------------------------------------------
8233:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8234:         WITH loc_oPg.shp_4c_ShpFig
8235:             .Top         = 152
8236:             .Left        = 231
8237:             .Width       = 244
8238:             .Height      = 148

*-- Linhas 8279 a 8347:
8279:             .GridLineWidth      = 1
8280:             .GridLineColor      = RGB(238, 238, 238)
8281:             .RecordMark         = .F.
8282:             .DeleteMark         = .F.
8283:             .AllowRowSizing     = .F.
8284:             .ReadOnly           = .F.
8285:             .BackColor          = RGB(255, 255, 255)
8286:             .ForeColor          = RGB(90, 90, 90)
8287:             .HighlightBackColor = RGB(220, 230, 242)
8288:             .HighlightForeColor = RGB(15, 41, 104)
8289:             .HighlightStyle     = 2
8290:             .RowHeight          = 16
8291:             .ScrollBars         = 2
8292:             .Themes             = .F.
8293:             .Visible            = .T.
8294:         ENDWITH
8295: 
8296:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8297:         loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8298: 
8299:         *-- Configurar colunas APOS RecordSource
8300:         WITH loc_oPg.grd_4c_GradFase
8301:             *-- Col1: Ordem (Ordems N5) W:50 - readonly (When=.F. no legado)
8302:             .Column1.Header1.Caption = "Ordem"
8303:             .Column1.Width           = 50
8304:             .Column1.ControlSource   = "cursor_4c_GradFase.Ordems"
8305:             .Column1.Alignment       = 1
8306:             .Column1.ReadOnly        = .T.
8307: 
8308:             *-- Col2: Fase (Grupos C10) W:80 - editable, F4 lookup SigCdGcr
8309:             .Column2.Header1.Caption = "Fase"
8310:             .Column2.Width           = 80
8311:             .Column2.ControlSource   = "cursor_4c_GradFase.Grupos"
8312:             .Column2.Alignment       = 0
8313:             .Column2.ReadOnly        = .F.
8314: 
8315:             *-- Col3: Utilizacao (Descrs C65) W:130 - readonly
8316:             .Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8317:             .Column3.Width           = 130
8318:             .Column3.ControlSource   = "cursor_4c_GradFase.Descrs"
8319:             .Column3.Alignment       = 0
8320:             .Column3.ReadOnly        = .T.
8321: 
8322:             *-- Col4: Uni. Produtiva (UniPrdts C10) W:80 - editable, F4 lookup SigCdUpd
8323:             .Column4.Header1.Caption = "Uni. Produtiva"
8324:             .Column4.Width           = 80
8325:             .Column4.ControlSource   = "cursor_4c_GradFase.UniPrdts"
8326:             .Column4.Alignment       = 0
8327:             .Column4.ReadOnly        = .F.
8328: 
8329:             *-- Col5: Material (MatPrdts C15) W:80 - editable, F4 lookup SigOpOpt
8330:             .Column5.Header1.Caption = "Material"
8331:             .Column5.Width           = 80
8332:             .Column5.ControlSource   = "cursor_4c_GradFase.MatPrdts"
8333:             .Column5.Alignment       = 0
8334:             .Column5.ReadOnly        = .F.
8335:         ENDWITH
8336: 
8337:         *-- BINDEVENT: GradFase
8338:         BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
8339:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
8340:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
8341:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
8342:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
8343:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")
8344: 
8345:         *----------------------------------------------------------------------
8346:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8347:         *-- Legado: inserir.Click - insere nova linha com resequenciamento

*-- Linhas 8902 a 8956:
8902:             .GridLineWidth      = 1
8903:             .GridLineColor      = RGB(238, 238, 238)
8904:             .RecordMark         = .F.
8905:             .DeleteMark         = .F.
8906:             .AllowRowSizing     = .F.
8907:             .ReadOnly           = .F.
8908:             .BackColor          = RGB(255, 255, 255)
8909:             .ForeColor          = RGB(90, 90, 90)
8910:             .HighlightBackColor = RGB(220, 230, 242)
8911:             .HighlightForeColor = RGB(15, 41, 104)
8912:             .HighlightStyle     = 2
8913:             .RowHeight          = 16
8914:             .ScrollBars         = 2
8915:             .Themes             = .F.
8916:             .Visible            = .T.
8917:         ENDWITH
8918: 
8919:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8920:         loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_SigPrMtz"
8921: 
8922:         *-- Configurar colunas APOS RecordSource
8923:         WITH loc_oPg.grd_4c_Matrizes
8924:             *-- Col1: Matriz (CMats C14) W:70 - editable, F4 lookup crMatrizes
8925:             .Column1.Header1.Caption = "Matriz"
8926:             .Column1.Width           = 70
8927:             .Column1.ControlSource   = "cursor_4c_SigPrMtz.CMats"
8928:             .Column1.Alignment       = 0
8929:             .Column1.ReadOnly        = .F.
8930: 
8931:             *-- Col2: Local (DLocs C40) W:120 - readonly (preenchido pelo lookup)
8932:             .Column2.Header1.Caption = "Local"
8933:             .Column2.Width           = 120
8934:             .Column2.ControlSource   = "cursor_4c_SigPrMtz.DLocs"
8935:             .Column2.Alignment       = 0
8936:             .Column2.ReadOnly        = .T.
8937: 
8938:             *-- Col3: Qtde (Qtds N3) W:56 - editable em modo edicao
8939:             .Column3.Header1.Caption = "Qtde"
8940:             .Column3.Width           = 56
8941:             .Column3.ControlSource   = "cursor_4c_SigPrMtz.Qtds"
8942:             .Column3.Alignment       = 1
8943:             .Column3.ReadOnly        = .F.
8944:         ENDWITH
8945: 
8946:         *-- BINDEVENT: grdMatrizes
8947:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8948:         BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")
8949: 
8950:         *----------------------------------------------------------------------
8951:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8952:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8953:         *----------------------------------------------------------------------
8954:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8955:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8956:             .Caption       = "+"

*-- Linhas 9225 a 9250:
9225:             IF loc_lResultado
9226:                 *-- Calcular Ordem2 para resequenciamento
9227:                 loc_nPonteiro = RECNO("cursor_4c_GradFase")
9228:                 SELECT cursor_4c_GradFase
9229:                 SCAN
9230:                     IF RECNO() # loc_nPonteiro
9231:                         REPLACE Ordems WITH cursor_4c_GradFase.Ordems IN cursor_4c_GradFase
9232:                     ENDIF
9233:                 ENDSCAN
9234:                 GO loc_nPonteiro IN cursor_4c_GradFase
9235:                 SELECT cursor_4c_GradFase
9236:                 *-- Reordenar por Ordems para refletir nova sequencia
9237:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9238:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9239:                 ENDIF
9240:             ENDIF
9241:         CATCH TO loc_oErro
9242:             MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
9243:         ENDTRY
9244:     ENDPROC
9245: 
9246:     *--------------------------------------------------------------------------
9247:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
9248:     * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
9249:     *         Apos selecao: preenche Grupos e Descrs no cursor
9250:     *--------------------------------------------------------------------------

*-- Linhas 9270 a 9288:
9270:                     ENDIF
9271:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
9272:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9273:                             SELECT cursor_4c_GradFase
9274:                             REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
9275:                             REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
9276:                         ENDIF
9277:                     ENDIF
9278:                     loc_oBusca.Release()
9279:                 ENDIF
9280:                 IF USED("cursor_4c_BuscaGcr")
9281:                     USE IN cursor_4c_BuscaGcr
9282:                 ENDIF
9283:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9284:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9285:                 ENDIF
9286:             CATCH TO loc_oErro
9287:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
9288:             ENDTRY

*-- Linhas 9309 a 9344:
9309:                 ENDIF
9310:                 *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
9311:                 IF !EMPTY(loc_cGrupos)
9312:                     loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
9313:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9314:                 ELSE
9315:                     loc_cSQL = "SELECT DISTINCT UniPrdts FROM SigCdUpd"
9316:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9317:                 ENDIF
9318:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaUpd")
9319:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9320:                         "SigCdUpd", "cursor_4c_BuscaUpd2", "UniPrdts", loc_cAtual, ;
9321:                         "Buscar Uni. Produtiva")
9322:                     IF VARTYPE(loc_oBusca) = "O"
9323:                         IF !loc_oBusca.this_lAchouRegistro
9324:                             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
9325:                             loc_oBusca.Show()
9326:                         ENDIF
9327:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
9328:                             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9329:                                 SELECT cursor_4c_GradFase
9330:                                 REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
9331:                             ENDIF
9332:                         ENDIF
9333:                         loc_oBusca.Release()
9334:                     ENDIF
9335:                     IF USED("cursor_4c_BuscaUpd2")
9336:                         USE IN cursor_4c_BuscaUpd2
9337:                     ENDIF
9338:                 ENDIF
9339:                 IF USED("cursor_4c_BuscaUpd")
9340:                     USE IN cursor_4c_BuscaUpd
9341:                 ENDIF
9342:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9343:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9344:                 ENDIF

*-- Linhas 9375 a 9393:
9375:                     ENDIF
9376:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
9377:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9378:                             SELECT cursor_4c_GradFase
9379:                             REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
9380:                         ENDIF
9381:                     ENDIF
9382:                     loc_oBusca.Release()
9383:                 ENDIF
9384:                 IF USED("cursor_4c_BuscaOpt")
9385:                     USE IN cursor_4c_BuscaOpt
9386:                 ENDIF
9387:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9388:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9389:                 ENDIF
9390:             CATCH TO loc_oErro
9391:                 MsgErro(loc_oErro.Message, "Erro ao buscar material")
9392:             ENDTRY
9393:         ENDIF

*-- Linhas 9416 a 9436:
9416:             *-- Carregar imagem da borracha do produto-matriz corrente
9417:             IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9418:                 IF !EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9419:                     loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
9420:                                EscaparSQL(ALLTRIM(cursor_4c_SigPrMtz.CMats))
9421:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalImgPro")
9422:                     IF loc_nRet > 0 AND USED("cursor_4c_LocalImgPro")
9423:                         GO TOP IN cursor_4c_LocalImgPro
9424:                         IF !EOF("cursor_4c_LocalImgPro")
9425:                             IF TYPE("cursor_4c_LocalImgPro.FigJpgs") # "U"
9426:                                 IF !EMPTY(NVL(cursor_4c_LocalImgPro.FigJpgs, ""))
9427:                                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_bor.jpg"
9428:                                     IF STRTOFILE(cursor_4c_LocalImgPro.FigJpgs, loc_lcArquivo) > 0
9429:                                         loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9430:                                         loc_oPg.img_4c_ImgBorracha.Visible = .T.
9431:                                     ENDIF
9432:                                 ENDIF
9433:                             ENDIF
9434:                         ENDIF
9435:                         USE IN cursor_4c_LocalImgPro
9436:                     ENDIF

*-- Linhas 9472 a 9490:
9472:                     ENDIF
9473:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
9474:                         IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9475:                             SELECT cursor_4c_SigPrMtz
9476:                             REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
9477:                             IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
9478:                                 REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
9479:                             ENDIF
9480:                         ENDIF
9481:                     ENDIF
9482:                     loc_oBusca.Release()
9483:                 ENDIF
9484:                 IF USED("cursor_4c_BuscaMatriz")
9485:                     USE IN cursor_4c_BuscaMatriz
9486:                 ENDIF
9487:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9488:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
9489:                 ENDIF
9490:             CATCH TO loc_oErro

*-- Linhas 9509 a 9585:
9509:             *-- Calcular proximo numero de ordem
9510:             loc_nOrdem = 0
9511:             IF !EOF("cursor_4c_GradFase")
9512:                 SELECT MAX(Ordems) AS nMaxOrdem FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpOrd NOFILTER
9513:                 IF USED("cursor_4c_TmpOrd") AND !EOF("cursor_4c_TmpOrd")
9514:                     loc_nOrdem = NVL(cursor_4c_TmpOrd.nMaxOrdem, 0)
9515:                 ENDIF
9516:                 IF USED("cursor_4c_TmpOrd")
9517:                     USE IN cursor_4c_TmpOrd
9518:                 ENDIF
9519:             ENDIF
9520:             loc_nOrdem = loc_nOrdem + 1
9521:             *-- Inserir nova linha
9522:             INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9523:                 VALUES (loc_nOrdem, "", "", "", "")
9524:             *-- Posicionar no novo registro e focar grid
9525:             GO BOTTOM IN cursor_4c_GradFase
9526:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9527:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9528:                 IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9529:                     loc_oPg.grd_4c_GradFase.Refresh()
9530:                     loc_oPg.grd_4c_GradFase.SetFocus()
9531:                 ENDIF
9532:             ENDIF
9533:         CATCH TO loc_oErro
9534:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9535:         ENDTRY
9536:     ENDPROC
9537: 
9538:     *--------------------------------------------------------------------------
9539:     * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
9540:     * Legado: excluir.Click - DELETE e resequencia Ordems
9541:     *--------------------------------------------------------------------------
9542:     PROCEDURE CmdExcluirFaseClick()
9543:         LOCAL loc_oPg, loc_lResultado
9544:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9545:             RETURN
9546:         ENDIF
9547:         loc_lResultado = .T.
9548:         TRY
9549:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9550:                 loc_lResultado = .F.
9551:             ENDIF
9552:             IF loc_lResultado
9553:                 IF !MsgConfirma("Excluir fase selecionada?")
9554:                     loc_lResultado = .F.
9555:                 ENDIF
9556:             ENDIF
9557:             IF loc_lResultado
9558:                 SELECT cursor_4c_GradFase
9559:                 DELETE
9560:                 IF !EOF("cursor_4c_GradFase")
9561:                     SKIP
9562:                 ENDIF
9563:                 IF EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
9564:                     GO BOTTOM IN cursor_4c_GradFase
9565:                 ENDIF
9566:                 *-- Resequenciar Ordems
9567:                 LOCAL loc_nSeq
9568:                 loc_nSeq = 1
9569:                 GO TOP IN cursor_4c_GradFase
9570:                 SCAN FOR !DELETED()
9571:                     REPLACE Ordems WITH loc_nSeq
9572:                     loc_nSeq = loc_nSeq + 1
9573:                 ENDSCAN
9574:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9575:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9576:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9577:                         loc_oPg.grd_4c_GradFase.Refresh()
9578:                     ENDIF
9579:                 ENDIF
9580:             ENDIF
9581:         CATCH TO loc_oErro
9582:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9583:         ENDTRY
9584:     ENDPROC
9585: 

*-- Linhas 9610 a 9637:
9610:                 loc_cUni    = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9611:                 loc_cMat    = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9612:                 *-- Calcular proxima ordem
9613:                 SELECT MAX(Ordems) AS nMaxOrd FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpAlt NOFILTER
9614:                 loc_nOrdem = 1
9615:                 IF USED("cursor_4c_TmpAlt") AND !EOF("cursor_4c_TmpAlt")
9616:                     loc_nOrdem = NVL(cursor_4c_TmpAlt.nMaxOrd, 0) + 1
9617:                 ENDIF
9618:                 IF USED("cursor_4c_TmpAlt")
9619:                     USE IN cursor_4c_TmpAlt
9620:                 ENDIF
9621:                 *-- Inserir copia como alternativa
9622:                 INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9623:                     VALUES (loc_nOrdem, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat)
9624:                 GO BOTTOM IN cursor_4c_GradFase
9625:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9626:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9627:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9628:                         loc_oPg.grd_4c_GradFase.Refresh()
9629:                     ENDIF
9630:                 ENDIF
9631:             ENDIF
9632:         CATCH TO loc_oErro
9633:             MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
9634:         ENDTRY
9635:     ENDPROC
9636: 
9637:     *--------------------------------------------------------------------------

*-- Linhas 9658 a 9682:
9658:                 IF USED("CsCabecalho")
9659:                     USE IN CsCabecalho
9660:                 ENDIF
9661:                 CREATE CURSOR CsCabecalho (;
9662:                     _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
9663:                     _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
9664:                     _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
9665:                     _nPeso N(9,2))
9666:                 WITH THIS.this_oBusinessObject
9667:                     INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
9668:                         VALUES (loc_cNmEmp, ;
9669:                                 "Ficha T" + CHR(233) + "cnica de Produto", ;
9670:                                 ALLTRIM(.this_cCpros), ;
9671:                                 ALLTRIM(.this_cDpros), ;
9672:                                 ALLTRIM(.this_cCgrus), ;
9673:                                 .this_nPesobs)
9674:                 ENDWITH
9675:                 *-- Verificar e executar relatorio
9676:                 LOCAL loc_cRepPath
9677:                 loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
9678:                 IF FILE(loc_cRepPath)
9679:                     REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
9680:                 ELSE
9681:                     MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")
9682:                 ENDIF

*-- Linhas 9710 a 9728:
9710:                 IF !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9711:                     *-- Armazenar imagem binaria no campo memo FigProcs
9712:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9713:                         SELECT cursor_4c_GradFase
9714:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9715:                     ENDIF
9716:                     *-- Atualizar exibicao da imagem
9717:                     THIS.GradFaseAfterRowColChange(0)
9718:                 ENDIF
9719:             ENDIF
9720:         CATCH TO loc_oErro
9721:             MsgErro(loc_oErro.Message, "Erro ao selecionar imagem")
9722:         ENDTRY
9723:     ENDPROC
9724: 
9725:     *--------------------------------------------------------------------------
9726:     * CmdgFigCamClick - Captura imagem via webcam (SigImage form)
9727:     * Legado: cmdgFigCam.Click - DO form SigImage TO lcFigura e armazena
9728:     *--------------------------------------------------------------------------

*-- Linhas 9747 a 9765:
9747:                 ENDIF
9748:                 IF loc_lResultado AND !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9749:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9750:                         SELECT cursor_4c_GradFase
9751:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9752:                     ENDIF
9753:                     THIS.GradFaseAfterRowColChange(0)
9754:                 ENDIF
9755:             ENDIF
9756:         CATCH TO loc_oErro
9757:             MsgErro(loc_oErro.Message, "Erro ao capturar imagem via webcam")
9758:         ENDTRY
9759:     ENDPROC
9760: 
9761:     *--------------------------------------------------------------------------
9762:     * ImgFigJpgClick - Abre imagem da fase em zoom (SigOpZom form)
9763:     * Legado: ImgFigJpg.Click - StrToFile e DO form SigOpZom
9764:     *--------------------------------------------------------------------------
9765:     PROCEDURE ImgFigJpgClick()

*-- Linhas 9784 a 9860:
9784: 
9785:     *--------------------------------------------------------------------------
9786:     * BtnInsereMtxClick - Insere nova linha de matriz em cursor_4c_SigPrMtz
9787:     * Legado: btnInsereMtx.Click - Insert Into crSigPrMtz se vazio
9788:     *--------------------------------------------------------------------------
9789:     PROCEDURE BtnInsereMtxClick()
9790:         LOCAL loc_oPg, loc_lResultado
9791:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9792:             RETURN
9793:         ENDIF
9794:         loc_lResultado = .T.
9795:         TRY
9796:             IF !USED("cursor_4c_SigPrMtz")
9797:                 loc_lResultado = .F.
9798:             ENDIF
9799:             IF loc_lResultado
9800:                 *-- Verificar se ja existe linha vazia (evitar duplicatas)
9801:                 GO TOP IN cursor_4c_SigPrMtz
9802:                 LOCATE FOR EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9803:                 IF !EOF("cursor_4c_SigPrMtz")
9804:                     *-- Ja existe linha vazia - apenas focar
9805:                     loc_lResultado = .F.
9806:                 ENDIF
9807:             ENDIF
9808:             IF loc_lResultado
9809:                 INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9810:                 GO BOTTOM IN cursor_4c_SigPrMtz
9811:             ENDIF
9812:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9813:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9814:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9815:                     loc_oPg.grd_4c_Matrizes.Refresh()
9816:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9817:                 ENDIF
9818:             ENDIF
9819:         CATCH TO loc_oErro
9820:             MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
9821:         ENDTRY
9822:     ENDPROC
9823: 
9824:     *--------------------------------------------------------------------------
9825:     * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
9826:     * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
9827:     *--------------------------------------------------------------------------
9828:     PROCEDURE BtnExcluiMtzClick()
9829:         LOCAL loc_oPg, loc_lResultado
9830:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9831:             RETURN
9832:         ENDIF
9833:         loc_lResultado = .T.
9834:         TRY
9835:             IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
9836:                 loc_lResultado = .F.
9837:             ENDIF
9838:             IF loc_lResultado
9839:                 SELECT cursor_4c_SigPrMtz
9840:                 DELETE
9841:                 *-- Se cursor ficou vazio, reinsere linha placeholder
9842:                 GO TOP IN cursor_4c_SigPrMtz
9843:                 LOCATE FOR !DELETED()
9844:                 IF EOF("cursor_4c_SigPrMtz")
9845:                     INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9846:                 ENDIF
9847:             ENDIF
9848:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9849:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9850:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9851:                     loc_oPg.grd_4c_Matrizes.Refresh()
9852:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9853:                 ENDIF
9854:             ENDIF
9855:         CATCH TO loc_oErro
9856:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9857:         ENDTRY
9858:     ENDPROC
9859: 
9860:     *--------------------------------------------------------------------------

*-- Linhas 10031 a 10049:
10031: 
10032:     *--------------------------------------------------------------------------
10033:     * TxtConquilhaLostFocus - Valida conquilha (SigCdCnq) ao sair do campo
10034:     * Legado: getConquilha.Valid = SQL SELECT conquilhas FROM SigCdCnq + fwBuscaInt
10035:     *--------------------------------------------------------------------------
10036:     PROCEDURE TxtConquilhaLostFocus()
10037:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
10038:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10039:             RETURN
10040:         ENDIF
10041:         *-- Guard: evita reabrir lookup se valor nao mudou
10042:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
10043:             LOCAL loc_cGuardaCnq
10044:             loc_cGuardaCnq = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Conquilha.Value, ""))
10045:             IF loc_cGuardaCnq = THIS.this_cUltimoTxtConquilhaLostFocusValidado
10046:                 RETURN
10047:             ENDIF
10048:             THIS.this_cUltimoTxtConquilhaLostFocusValidado = loc_cGuardaCnq
10049:         ENDIF

*-- Linhas 10062 a 10083:
10062:             ENDIF
10063:             IF loc_lResultado
10064:                 *-- Buscar conquilhas disponiveis em SigCdCnq
10065:                 loc_cSQL = "SELECT DISTINCT conquilhas FROM SigCdCnq"
10066:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaCnq")
10067:                 IF loc_nRet > 0 AND USED("cursor_4c_ListaCnq")
10068:                     SELECT cursor_4c_ListaCnq
10069:                     LOCATE FOR ALLTRIM(NVL(conquilhas, "")) = PADR(loc_cCod, 10)
10070:                     IF !EOF("cursor_4c_ListaCnq")
10071:                         *-- Encontrado direto
10072:                         loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_ListaCnq.conquilhas)
10073:                         THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10074:                     ELSE
10075:                         *-- Nao encontrado - abrir lookup
10076:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10077:                             "SigCdCnq", "cursor_4c_BuscaCnq", "conquilhas", loc_cCod, ;
10078:                             "Buscar Conquilha")
10079:                         IF VARTYPE(loc_oBusca) = "O"
10080:                             IF !loc_oBusca.this_lAchouRegistro
10081:                                 loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
10082:                                 loc_oBusca.Show()
10083:                             ENDIF

*-- Linhas 10118 a 10136:
10118:         *----------------------------------------------------------------------
10119:         IF !USED("cursor_4c_Cmv")
10120:             SET NULL ON
10121:             CREATE CURSOR cursor_4c_Cmv (;
10122:                 Datas   D, ;
10123:                 ValCuss N(12,3), ;
10124:                 Moedas  C(3))
10125:             SET NULL OFF
10126:         ENDIF
10127: 
10128:         *----------------------------------------------------------------------
10129:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10130:         *----------------------------------------------------------------------
10131:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10132:         WITH loc_oPg.lbl_4c_LblGruCus
10133:             .Caption   = "Grupo C.C. :"
10134:             .Top       = 165
10135:             .Left      = 138
10136:             .Width     = 63

*-- Linhas 10917 a 10965:
10917:             .FontName    = "Tahoma"
10918:             .FontSize    = 8
10919:             .RowHeight   = 17
10920:             .DeleteMark  = .F.
10921:             .RecordMark  = .T.
10922:             .ReadOnly    = .T.
10923:             .ScrollBars  = 3
10924:             .Themes      = .F.
10925:             .Visible     = .T.
10926:         ENDWITH
10927:         loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
10928:         WITH loc_oPg.grd_4c_Cmv
10929:             WITH .Column1
10930:                 .ControlSource    = "cursor_4c_Cmv.Datas"
10931:                 .Header1.Caption  = "Per" + CHR(237) + "odo"
10932:                 .Header1.FontName = "Tahoma"
10933:                 .Header1.FontSize = 8
10934:                 .Width            = 59
10935:                 .Movable          = .F.
10936:                 .Resizable        = .F.
10937:                 .ReadOnly         = .T.
10938:             ENDWITH
10939:             WITH .Column2
10940:                 .ControlSource    = "cursor_4c_Cmv.ValCuss"
10941:                 .Header1.Caption  = "Valor Custo GR"
10942:                 .Header1.FontName = "Tahoma"
10943:                 .Header1.FontSize = 8
10944:                 .Width            = 100
10945:                 .Movable          = .F.
10946:                 .Resizable        = .F.
10947:                 .ReadOnly         = .T.
10948:             ENDWITH
10949:             WITH .Column3
10950:                 .ControlSource    = "cursor_4c_Cmv.Moedas"
10951:                 .Header1.Caption  = "Moe"
10952:                 .Header1.FontName = "Tahoma"
10953:                 .Header1.FontSize = 8
10954:                 .Width            = 31
10955:                 .Movable          = .F.
10956:                 .Resizable        = .F.
10957:                 .ReadOnly         = .T.
10958:             ENDWITH
10959:         ENDWITH
10960:     ENDPROC
10961: 
10962:     *--------------------------------------------------------------------------
10963:     * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
10964:     * Chamado por BOParaForm apos carregar dados de SigCdPro
10965:     *--------------------------------------------------------------------------

*-- Linhas 11588 a 11610:
11588:             ENDIF
11589:             IF loc_lResultado
11590:                 *-- Carregar lista de metais (Tipos='M') para lookup
11591:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos = 'M'"
11592:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlM")
11593:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlM")
11594:                     *-- Verificar se codigo existe diretamente
11595:                     SELECT cursor_4c_BuscaMtlM
11596:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11597:                     IF !EOF("cursor_4c_BuscaMtlM")
11598:                         IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11599:                             loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlM.Descs, ""))
11600:                         ENDIF
11601:                         THIS.this_oBusinessObject.this_cMetals = loc_cCod
11602:                     ELSE
11603:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11604:                             "SigCdMtl", "cursor_4c_BuscaMtlSel", "Codigos", loc_cCod, ;
11605:                             "Buscar Metal")
11606:                         IF VARTYPE(loc_oBusca) = "O"
11607:                             IF !loc_oBusca.this_lAchouRegistro
11608:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11609:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11610:                                 loc_oBusca.Show()

*-- Linhas 11670 a 11691:
11670:                 ENDIF
11671:             ENDIF
11672:             IF loc_lResultado
11673:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos <> 'M'"
11674:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlT")
11675:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlT")
11676:                     SELECT cursor_4c_BuscaMtlT
11677:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11678:                     IF !EOF("cursor_4c_BuscaMtlT")
11679:                         IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11680:                             loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlT.Descs, ""))
11681:                         ENDIF
11682:                         THIS.this_oBusinessObject.this_cTeors = loc_cCod
11683:                     ELSE
11684:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11685:                             "SigCdMtl", "cursor_4c_BuscaTeorSel", "Codigos", loc_cCod, ;
11686:                             "Buscar Teor")
11687:                         IF VARTYPE(loc_oBusca) = "O"
11688:                             IF !loc_oBusca.this_lAchouRegistro
11689:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11690:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11691:                                 loc_oBusca.Show()

*-- Linhas 11820 a 11853:
11820:         *----------------------------------------------------------------------
11821:         IF !USED("cursor_4c_SigPrTar")
11822:             SET NULL ON
11823:             CREATE CURSOR cursor_4c_SigPrTar (;
11824:                 DtInis  D NULL, ;
11825:                 DtFims  D NULL, ;
11826:                 Usuars  C(10), ;
11827:                 Tarefas C(10), ;
11828:                 ObsTars M)
11829:             SET NULL OFF
11830:         ENDIF
11831: 
11832:         *----------------------------------------------------------------------
11833:         *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
11834:         *-- Campos: Arquivos
11835:         *----------------------------------------------------------------------
11836:         IF !USED("cursor_4c_SigPrArq")
11837:             SET NULL ON
11838:             CREATE CURSOR cursor_4c_SigPrArq (;
11839:                 Arquivos C(200))
11840:             SET NULL OFF
11841:         ENDIF
11842: 
11843:         *----------------------------------------------------------------------
11844:         *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
11845:         *----------------------------------------------------------------------
11846:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11847:         WITH loc_oPg.shp_4c_ArqFundo
11848:             .Top         = 415
11849:             .Left        = 584
11850:             .Width       = 407
11851:             .Height      = 202
11852:             .BackColor   = RGB(230, 230, 230)
11853:             .BorderColor = RGB(180, 180, 180)

*-- Linhas 11886 a 11971:
11886:             .ColumnCount = 4
11887:             .FontName    = "Tahoma"
11888:             .FontSize    = 8
11889:             .DeleteMark  = .F.
11890:             .ScrollBars  = 2
11891:             .Themes      = .F.
11892:             .Visible     = .T.
11893:             .RecordMark   = .F.
11894:         ENDWITH
11895:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_SigPrTar"
11896:         WITH loc_oPg.grd_4c_Designer
11897:             WITH .Column1
11898:                 .ControlSource     = "cursor_4c_SigPrTar.DtInis"
11899:                 .Header1.Caption   = "Data de In" + CHR(237) + "cio"
11900:                 .Header1.FontName  = "Tahoma"
11901:                 .Header1.FontSize  = 8
11902:                 .Header1.Alignment = 2
11903:                 .Width             = 140
11904:                 .Movable           = .F.
11905:                 .Resizable         = .F.
11906:                 .ReadOnly          = .T.
11907:                 .Alignment         = 2
11908:             ENDWITH
11909:             WITH .Column2
11910:                 .ControlSource     = "cursor_4c_SigPrTar.DtFims"
11911:                 .Header1.Caption   = "Data de Conclus" + CHR(227) + "o"
11912:                 .Header1.FontName  = "Tahoma"
11913:                 .Header1.FontSize  = 8
11914:                 .Header1.Alignment = 2
11915:                 .Width             = 140
11916:                 .Movable           = .F.
11917:                 .Resizable         = .F.
11918:                 .ReadOnly          = .T.
11919:                 .Alignment         = 2
11920:             ENDWITH
11921:             WITH .Column3
11922:                 .ControlSource     = "cursor_4c_SigPrTar.Usuars"
11923:                 .Header1.Caption   = "Usu" + CHR(225) + "rio"
11924:                 .Header1.FontName  = "Tahoma"
11925:                 .Header1.FontSize  = 8
11926:                 .Header1.Alignment = 2
11927:                 .Width             = 90
11928:                 .Movable           = .F.
11929:                 .Resizable         = .F.
11930:                 .ReadOnly          = .T.
11931:             ENDWITH
11932:             WITH .Column4
11933:                 .ControlSource     = "cursor_4c_SigPrTar.Tarefas"
11934:                 .Header1.Caption   = "Tarefa"
11935:                 .Header1.FontName  = "Tahoma"
11936:                 .Header1.FontSize  = 8
11937:                 .Header1.Alignment = 2
11938:                 .Width             = 90
11939:                 .Movable           = .F.
11940:                 .Resizable         = .F.
11941:                 .ReadOnly          = .F.
11942:             ENDWITH
11943:         ENDWITH
11944:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
11945: 
11946:         *----------------------------------------------------------------------
11947:         *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
11948:         *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
11949:         *----------------------------------------------------------------------
11950:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11951:         WITH loc_oPg.obj_4c_ObsTarefas
11952:             .Top              = 160
11953:             .Left             = 584
11954:             .Width            = 407
11955:             .Height           = 238
11956:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11957:             .FontName         = "Tahoma"
11958:             .FontSize         = 8
11959:             .SpecialEffect    = 1
11960:             .ForeColor        = RGB(36, 84, 155)
11961:             .Enabled          = .T.
11962:             .Visible          = .T.
11963:         ENDWITH
11964: 
11965:         *----------------------------------------------------------------------
11966:         *-- btnIniTarefa: Iniciar Tarefa (T:168 L:509 W:42 H:42)
11967:         *----------------------------------------------------------------------
11968:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11969:         WITH loc_oPg.cmd_4c_IniTarefa
11970:             .Top             = 168
11971:             .Left            = 509

*-- Linhas 12014 a 12042:
12014:             .ColumnCount = 1
12015:             .FontName    = "Tahoma"
12016:             .FontSize    = 8
12017:             .DeleteMark  = .F.
12018:             .ScrollBars  = 2
12019:             .ReadOnly    = .T.
12020:             .Themes      = .F.
12021:             .Visible     = .T.
12022:             .RecordMark   = .F.
12023:         ENDWITH
12024:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
12025:         WITH loc_oPg.grd_4c_Arquivos
12026:             WITH .Column1
12027:                 .ControlSource     = "cursor_4c_SigPrArq.Arquivos"
12028:                 .Header1.Caption   = "Arquivos Para Designer"
12029:                 .Header1.FontName  = "Tahoma"
12030:                 .Header1.FontSize  = 8
12031:                 .Header1.Alignment = 2
12032:                 .Width             = 464
12033:                 .Movable           = .F.
12034:                 .Resizable         = .F.
12035:                 .ReadOnly          = .T.
12036:             ENDWITH
12037:         ENDWITH
12038:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
12039: 
12040:         *----------------------------------------------------------------------
12041:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
12042:         *----------------------------------------------------------------------

*-- Linhas 12215 a 12254:
12215:             ENDIF
12216:             IF loc_lResultado
12217:                 *-- Verificar se existe tarefa nao encerrada para este usuario
12218:                 SELECT cursor_4c_SigPrTar
12219:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12220:                     AND EMPTY(NVL(DtFims, {}))
12221:                 IF !EOF("cursor_4c_SigPrTar")
12222:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12223:                         CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12224:                     loc_lResultado = .F.
12225:                 ENDIF
12226:             ENDIF
12227:             IF loc_lResultado
12228:                 *-- Verificar se existe tarefa sem codigo informado
12229:                 SELECT cursor_4c_SigPrTar
12230:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12231:                     AND EMPTY(Tarefas)
12232:                 IF !EOF("cursor_4c_SigPrTar")
12233:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", "Aten" + CHR(231) + CHR(227) + "o")
12234:                     loc_lResultado = .F.
12235:                 ENDIF
12236:             ENDIF
12237:             IF loc_lResultado
12238:                 *-- Inserir nova tarefa com data/hora de inicio
12239:                 SELECT cursor_4c_SigPrTar
12240:                 APPEND BLANK
12241:                 REPLACE cursor_4c_SigPrTar.DtInis  WITH DATE()
12242:                 REPLACE cursor_4c_SigPrTar.Usuars  WITH PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
12243:                 REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
12244:                 REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
12245:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12246:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12247:                 ENDIF
12248:             ENDIF
12249:         CATCH TO loc_oErro
12250:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12251:         ENDTRY
12252:     ENDPROC
12253: 
12254:     *--------------------------------------------------------------------------

*-- Linhas 12278 a 12323:
12278:                 ENDIF
12279:             ENDIF
12280:             IF loc_lResultado
12281:                 SELECT cursor_4c_SigPrTar
12282:                 REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
12283:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12284:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12285:                 ENDIF
12286:             ENDIF
12287:         CATCH TO loc_oErro
12288:             MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
12289:         ENDTRY
12290:     ENDPROC
12291: 
12292:     *--------------------------------------------------------------------------
12293:     * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
12294:     * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
12295:     *--------------------------------------------------------------------------
12296:     PROCEDURE BtnInsArqsClick()
12297:         LOCAL loc_cArq, loc_lResultado
12298:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12299:             RETURN
12300:         ENDIF
12301:         loc_lResultado = .T.
12302:         TRY
12303:             loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
12304:             IF EMPTY(loc_cArq)
12305:                 loc_lResultado = .F.
12306:             ENDIF
12307:             IF loc_lResultado AND USED("cursor_4c_SigPrArq")
12308:                 SELECT cursor_4c_SigPrArq
12309:                 APPEND BLANK
12310:                 REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
12311:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12312:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12313:                 ENDIF
12314:             ENDIF
12315:         CATCH TO loc_oErro
12316:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12317:         ENDTRY
12318:     ENDPROC
12319: 
12320:     *--------------------------------------------------------------------------
12321:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
12322:     * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
12323:     *--------------------------------------------------------------------------

*-- Linhas 12353 a 12390:
12353: 
12354:     *--------------------------------------------------------------------------
12355:     * BtnExcArqsClick - Exclui arquivo da lista de arquivos designer
12356:     * Legado: btnExcArqs.Click - Delete In crSigPrArq + Refresh
12357:     *--------------------------------------------------------------------------
12358:     PROCEDURE BtnExcArqsClick()
12359:         LOCAL loc_lResultado
12360:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12361:             RETURN
12362:         ENDIF
12363:         loc_lResultado = .T.
12364:         TRY
12365:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12366:                 loc_lResultado = .F.
12367:             ENDIF
12368:             IF loc_lResultado
12369:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, "")))
12370:                     loc_lResultado = .F.
12371:                 ENDIF
12372:             ENDIF
12373:             IF loc_lResultado
12374:                 SELECT cursor_4c_SigPrArq
12375:                 DELETE
12376:                 IF !EOF("cursor_4c_SigPrArq")
12377:                     SKIP
12378:                     SKIP -1
12379:                 ENDIF
12380:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12381:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12382:                 ENDIF
12383:                 *-- Limpar imagem ao excluir arquivo
12384:                 LOCAL loc_oPg
12385:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12386:                 IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
12387:                     CLEAR RESOURCES
12388:                     loc_oPg.img_4c_ArqJpg.Picture = ""
12389:                     loc_oPg.img_4c_ArqJpg.Visible = .F.
12390:                 ENDIF

