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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (12572 linhas total):

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

*-- Linhas 3473 a 3491:
3473:             .GridLineWidth      = 1
3474:             .GridLineColor      = RGB(238, 238, 238)
3475:             .RecordMark         = .F.
3476:             .DeleteMark         = .F.
3477:             .AllowRowSizing     = .F.
3478:             .ReadOnly           = .T.
3479:             .BackColor          = RGB(255, 255, 255)
3480:             .ForeColor          = RGB(90, 90, 90)
3481:             .HighlightBackColor = RGB(255, 255, 255)
3482:             .HighlightForeColor = RGB(15, 41, 104)
3483:             .HighlightStyle     = 2
3484:             .RowHeight          = 16
3485:             .ScrollBars         = 2
3486:         ENDWITH
3487:     ENDPROC
3488: 
3489:     *--------------------------------------------------------------------------
3490:     * BtnIncluirClick - Incluir novo produto
3491:     *--------------------------------------------------------------------------

*-- Linhas 4615 a 4691:
4615:             *-- Descricao do Grupo (cgrus -> SigCdGrp.dgrus)
4616:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
4617:             IF !EMPTY(loc_cCod)
4618:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4619:                     "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCod), ;
4620:                     "cursor_4c_TmpDgru")
4621:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpDgru") > 0
4622:                     loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpDgru.dgrus)
4623:                 ENDIF
4624:                 IF USED("cursor_4c_TmpDgru")
4625:                     USE IN cursor_4c_TmpDgru
4626:                 ENDIF
4627:             ENDIF
4628: 
4629:             *-- Descricao do SubGrupo (sgrus -> SigCdPsg.descricaos, filtrado por cgrus)
4630:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CSGru.Value)
4631:             IF !EMPTY(loc_cCod)
4632:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4633:                     "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cCod) + ;
4634:                     " AND cgrus = " + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CgruP.Value)), ;
4635:                     "cursor_4c_TmpSGru")
4636:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4637:                     loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4638:                 ENDIF
4639:                 IF USED("cursor_4c_TmpSGru")
4640:                     USE IN cursor_4c_TmpSGru
4641:                 ENDIF
4642:             ENDIF
4643: 
4644:             *-- Descricao da Linha (linhas -> SigCdLin.descs)
4645:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Lin.Value)
4646:             IF !EMPTY(loc_cCod)
4647:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4648:                     "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cCod), ;
4649:                     "cursor_4c_TmpLin")
4650:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLin") > 0
4651:                     loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_TmpLin.descs)
4652:                 ENDIF
4653:                 IF USED("cursor_4c_TmpLin")
4654:                     USE IN cursor_4c_TmpLin
4655:                 ENDIF
4656:             ENDIF
4657: 
4658:             *-- Descricao do Grupo de Venda (colecoes -> SIGCDCOL.descs)
4659:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Col.Value)
4660:             IF !EMPTY(loc_cCod)
4661:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4662:                     "SELECT descs FROM SIGCDCOL WHERE colecoes = " + EscaparSQL(loc_cCod), ;
4663:                     "cursor_4c_TmpCol")
4664:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCol") > 0
4665:                     loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_TmpCol.descs)
4666:                 ENDIF
4667:                 IF USED("cursor_4c_TmpCol")
4668:                     USE IN cursor_4c_TmpCol
4669:                 ENDIF
4670:             ENDIF
4671: 
4672:             *-- Descricao do Fornecedor (ifors -> SigCdCli.rclis)
4673:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Ifor.Value)
4674:             IF !EMPTY(loc_cCod)
4675:                 loc_nRet = SQLEXEC(gnConnHandle, ;
4676:                     "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCod), ;
4677:                     "cursor_4c_TmpIfor")
4678:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpIfor") > 0
4679:                     loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_TmpIfor.rclis)
4680:                 ENDIF
4681:                 IF USED("cursor_4c_TmpIfor")
4682:                     USE IN cursor_4c_TmpIfor
4683:                 ENDIF
4684:             ENDIF
4685: 
4686:         CATCH TO loc_oErro
4687:             MsgErro(loc_oErro.Message, "Erro ao preencher descri" + CHR(231) + CHR(245) + "es")
4688:         ENDTRY
4689:     ENDPROC
4690: 
4691:     *==========================================================================

*-- Linhas 4716 a 4735:
4716:         ENDIF
4717: 
4718:         TRY
4719:             loc_nRet = SQLEXEC(gnConnHandle, ;
4720:                 "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(loc_cCgru), ;
4721:                 "cursor_4c_TmpGruP")
4722:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpGruP") > 0
4723:                 loc_oPg.txt_4c_DgruP.Value = ALLTRIM(cursor_4c_TmpGruP.dgrus)
4724:                 *-- Limpar subgrupo ao trocar grupo
4725:                 loc_oPg.txt_4c_CSGru.Value = ""
4726:                 loc_oPg.txt_4c_DsGru.Value = ""
4727:             ELSE
4728:                 MsgAviso("Grupo '" + loc_cCgru + "' n" + CHR(227) + "o encontrado!")
4729:                 loc_oPg.txt_4c_CgruP.Value = ""
4730:                 loc_oPg.txt_4c_DgruP.Value = ""
4731:             ENDIF
4732:             IF USED("cursor_4c_TmpGruP")
4733:                 USE IN cursor_4c_TmpGruP
4734:             ENDIF
4735:         CATCH TO loc_oErro

*-- Linhas 4801 a 4821:
4801:         ENDIF
4802: 
4803:         TRY
4804:             loc_nRet = SQLEXEC(gnConnHandle, ;
4805:                 "SELECT descricaos FROM SigCdPsg WHERE codigos = " + EscaparSQL(loc_cSGru) + ;
4806:                 IIF(EMPTY(loc_cCgru), "", " AND cgrus = " + EscaparSQL(loc_cCgru)), ;
4807:                 "cursor_4c_TmpSGru")
4808:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpSGru") > 0
4809:                 loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_TmpSGru.descricaos)
4810:             ELSE
4811:                 MsgAviso("Subgrupo '" + loc_cSGru + "' n" + CHR(227) + "o encontrado!")
4812:                 loc_oPg.txt_4c_CSGru.Value = ""
4813:                 loc_oPg.txt_4c_DsGru.Value = ""
4814:             ENDIF
4815:             IF USED("cursor_4c_TmpSGru")
4816:                 USE IN cursor_4c_TmpSGru
4817:             ENDIF
4818:         CATCH TO loc_oErro
4819:             MsgErro(loc_oErro.Message, "Erro ao validar subgrupo")
4820:         ENDTRY
4821:     ENDPROC

*-- Linhas 4830 a 4848:
4830:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4831:                 "SigCdPsg", "cursor_4c_BuscaSGru", "codigos", loc_cAtual, ;
4832:                 "Buscar Subgrupo", .F., .T., ;
4833:                 IIF(EMPTY(loc_cCgru), "", "cgrus = " + EscaparSQL(loc_cCgru)))
4834:             IF VARTYPE(loc_oBusca) = "O"
4835:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
4836:                     IF USED("cursor_4c_BuscaSGru")
4837:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4838:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4839:                     ENDIF
4840:                 ELSE
4841:                     IF !loc_oBusca.this_lAchouRegistro
4842:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
4843:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4844:                     loc_oBusca.Show()
4845:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGru")
4846:                         loc_oPg.txt_4c_CSGru.Value = ALLTRIM(cursor_4c_BuscaSGru.codigos)
4847:                         loc_oPg.txt_4c_DsGru.Value = ALLTRIM(cursor_4c_BuscaSGru.descricaos)
4848:                     ENDIF

*-- Linhas 4881 a 4900:
4881:         ENDIF
4882: 
4883:         TRY
4884:             loc_nRet = SQLEXEC(gnConnHandle, ;
4885:                 "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(loc_cLin), ;
4886:                 "cursor_4c_TmpLin")
4887:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLin") > 0
4888:                 loc_oPg.txt_4c_DLin.Value = ALLTRIM(cursor_4c_TmpLin.descs)
4889:             ELSE
4890:                 MsgAviso("Linha '" + loc_cLin + "' n" + CHR(227) + "o encontrada!")
4891:                 loc_oPg.txt_4c_Lin.Value  = ""
4892:                 loc_oPg.txt_4c_DLin.Value = ""
4893:             ENDIF
4894:             IF USED("cursor_4c_TmpLin")
4895:                 USE IN cursor_4c_TmpLin
4896:             ENDIF
4897:         CATCH TO loc_oErro
4898:             MsgErro(loc_oErro.Message, "Erro ao validar linha")
4899:         ENDTRY
4900:     ENDPROC

*-- Linhas 4958 a 4977:
4958:         ENDIF
4959: 
4960:         TRY
4961:             loc_nRet = SQLEXEC(gnConnHandle, ;
4962:                 "SELECT descs FROM SIGCDCOL WHERE colecoes = " + EscaparSQL(loc_cCol), ;
4963:                 "cursor_4c_TmpCol")
4964:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCol") > 0
4965:                 loc_oPg.txt_4c_DCol.Value = ALLTRIM(cursor_4c_TmpCol.descs)
4966:             ELSE
4967:                 MsgAviso("Grupo de Venda '" + loc_cCol + "' n" + CHR(227) + "o encontrado!")
4968:                 loc_oPg.txt_4c_Col.Value  = ""
4969:                 loc_oPg.txt_4c_DCol.Value = ""
4970:             ENDIF
4971:             IF USED("cursor_4c_TmpCol")
4972:                 USE IN cursor_4c_TmpCol
4973:             ENDIF
4974:         CATCH TO loc_oErro
4975:             MsgErro(loc_oErro.Message, "Erro ao validar grupo de venda")
4976:         ENDTRY
4977:     ENDPROC

*-- Linhas 5035 a 5054:
5035:         ENDIF
5036: 
5037:         TRY
5038:             loc_nRet = SQLEXEC(gnConnHandle, ;
5039:                 "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cIfor), ;
5040:                 "cursor_4c_TmpIfor")
5041:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpIfor") > 0
5042:                 loc_oPg.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_TmpIfor.rclis)
5043:             ELSE
5044:                 MsgAviso("Fornecedor '" + loc_cIfor + "' n" + CHR(227) + "o encontrado!")
5045:                 loc_oPg.txt_4c_Ifor.Value = ""
5046:                 loc_oPg.txt_4c_Dfor.Value = ""
5047:             ENDIF
5048:             IF USED("cursor_4c_TmpIfor")
5049:                 USE IN cursor_4c_TmpIfor
5050:             ENDIF
5051:         CATCH TO loc_oErro
5052:             MsgErro(loc_oErro.Message, "Erro ao validar fornecedor")
5053:         ENDTRY
5054:     ENDPROC

*-- Linhas 5111 a 5130:
5111:         ENDIF
5112: 
5113:         TRY
5114:             loc_nRet = SQLEXEC(gnConnHandle, ;
5115:                 "SELECT cpros FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpro), ;
5116:                 "cursor_4c_TmpProEq")
5117:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpProEq") = 0
5118:                 MsgAviso("Produto equivalente '" + loc_cCpro + "' n" + CHR(227) + "o encontrado!")
5119:                 loc_oPg.txt_4c_CProEq.Value = ""
5120:             ENDIF
5121:             IF USED("cursor_4c_TmpProEq")
5122:                 USE IN cursor_4c_TmpProEq
5123:             ENDIF
5124:         CATCH TO loc_oErro
5125:             MsgErro(loc_oErro.Message, "Erro ao validar produto equivalente")
5126:         ENDTRY
5127:     ENDPROC
5128: 
5129:     PROCEDURE AbrirLookupProdEq()
5130:         LOCAL loc_oBusca, loc_oPg, loc_cAtual

*-- Linhas 5179 a 5198:
5179: 
5180:         TRY
5181:             *-- Busca conjuntos distintos ja cadastrados em SigCdPro
5182:             loc_nRet = SQLEXEC(gnConnHandle, ;
5183:                 "SELECT DISTINCT conjunts FROM SigCdPro WHERE LTRIM(RTRIM(conjunts)) <> '' ORDER BY conjunts", ;
5184:                 "cursor_4c_BuscaCnj")
5185: 
5186:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaCnj") > 0
5187:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5188:                 IF VARTYPE(loc_oBusca) = "O"
5189:                     loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaCnj"
5190:                     loc_oBusca.this_cTitulo        = "Buscar Conjunto"
5191:                     loc_oBusca.mAddColuna("conjunts", "", "Conjunto")
5192:                     loc_oBusca.Show()
5193:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnj")
5194:                         loc_oPg.txt_4c_Conjunto.Value = ALLTRIM(cursor_4c_BuscaCnj.conjunts)
5195:                     ENDIF
5196:                     loc_oBusca.Release()
5197:                 ENDIF
5198:             ENDIF

*-- Linhas 6666 a 6757:
6666:             *-- Descricao Unidade 1 (cunis -> SigCdUni.dunis)
6667:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6668:             IF !EMPTY(loc_cCod)
6669:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6670:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6671:                     "cursor_4c_TmpUni")
6672:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUni") > 0
6673:                     loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpUni.dunis)
6674:                 ENDIF
6675:                 IF USED("cursor_4c_TmpUni")
6676:                     USE IN cursor_4c_TmpUni
6677:                 ENDIF
6678:             ENDIF
6679: 
6680:             *-- Descricao Unidade 2 (cunips -> SigCdUni.dunis)
6681:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6682:             IF !EMPTY(loc_cCod)
6683:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6684:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6685:                     "cursor_4c_TmpUnip")
6686:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUnip") > 0
6687:                     loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpUnip.dunis)
6688:                 ENDIF
6689:                 IF USED("cursor_4c_TmpUnip")
6690:                     USE IN cursor_4c_TmpUnip
6691:                 ENDIF
6692:             ENDIF
6693: 
6694:             *-- Descricao Modelo (codfinp -> SigCdFip.descs)
6695:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6696:             IF !EMPTY(loc_cCod)
6697:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6698:                     "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6699:                     "cursor_4c_TmpFinP")
6700:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6701:                     loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6702:                 ENDIF
6703:                 IF USED("cursor_4c_TmpFinP")
6704:                     USE IN cursor_4c_TmpFinP
6705:                 ENDIF
6706:             ENDIF
6707: 
6708:             *-- Descricao Acabamento (codacbs -> SigCdAca.descrs)
6709:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
6710:             IF !EMPTY(loc_cCod)
6711:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6712:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
6713:                     "cursor_4c_TmpAcb")
6714:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
6715:                     loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
6716:                 ENDIF
6717:                 IF USED("cursor_4c_TmpAcb")
6718:                     USE IN cursor_4c_TmpAcb
6719:                 ENDIF
6720:             ENDIF
6721: 
6722:             *-- Descricao Classificacao (cclass -> SigCdCls.descs, filtrado por cgrus)
6723:             loc_cCod  = ALLTRIM(loc_oPg.txt_4c_Class.Value)
6724:             loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
6725:             IF !EMPTY(loc_cCod)
6726:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6727:                     "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
6728:                     IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
6729:                     "cursor_4c_TmpClass")
6730:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
6731:                     loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
6732:                 ENDIF
6733:                 IF USED("cursor_4c_TmpClass")
6734:                     USE IN cursor_4c_TmpClass
6735:                 ENDIF
6736:             ENDIF
6737: 
6738:             *-- Descricao Local (locals -> SigPrLcl.descricaos)
6739:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Local.Value)
6740:             IF !EMPTY(loc_cCod)
6741:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6742:                     "SELECT descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
6743:                     "cursor_4c_TmpLocal")
6744:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLocal") > 0
6745:                     *-- Local nao tem campo descricao visivel separado, apenas atualiza silenciosamente
6746:                     *-- O campo txt_4c_Local ja exibe o codigo (10 chars)
6747:                 ENDIF
6748:                 IF USED("cursor_4c_TmpLocal")
6749:                     USE IN cursor_4c_TmpLocal
6750:                 ENDIF
6751:             ENDIF
6752: 
6753:         CATCH TO loc_oErro
6754:             MsgErro(loc_oErro.Message, "Erro ao preencher descri" + CHR(231) + CHR(245) + "es P2")
6755:         ENDTRY
6756:     ENDPROC
6757: 

*-- Linhas 6783 a 6802:
6783:         ENDIF
6784: 
6785:         TRY
6786:             loc_nRet = SQLEXEC(gnConnHandle, ;
6787:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCuni), ;
6788:                 "cursor_4c_TmpCuni")
6789:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCuni") > 0
6790:                 loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpCuni.dunis)
6791:             ELSE
6792:                 MsgAviso("Unidade '" + loc_cCuni + "' n" + CHR(227) + "o encontrada!")
6793:                 loc_oPg.txt_4c_Cuni.Value = ""
6794:                 loc_oPg.txt_4c_DUni.Value = ""
6795:             ENDIF
6796:             IF USED("cursor_4c_TmpCuni")
6797:                 USE IN cursor_4c_TmpCuni
6798:             ENDIF
6799:         CATCH TO loc_oErro
6800:             MsgErro(loc_oErro.Message, "Erro ao validar unidade")
6801:         ENDTRY
6802:     ENDPROC

*-- Linhas 6860 a 6879:
6860:         ENDIF
6861: 
6862:         TRY
6863:             loc_nRet = SQLEXEC(gnConnHandle, ;
6864:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCunip), ;
6865:                 "cursor_4c_TmpCunip")
6866:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCunip") > 0
6867:                 loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpCunip.dunis)
6868:             ELSE
6869:                 MsgAviso("Unidade '" + loc_cCunip + "' n" + CHR(227) + "o encontrada!")
6870:                 loc_oPg.txt_4c_Cunip.Value = ""
6871:                 loc_oPg.txt_4c_DUnip.Value = ""
6872:             ENDIF
6873:             IF USED("cursor_4c_TmpCunip")
6874:                 USE IN cursor_4c_TmpCunip
6875:             ENDIF
6876:         CATCH TO loc_oErro
6877:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
6878:         ENDTRY
6879:     ENDPROC

*-- Linhas 6937 a 6956:
6937:         ENDIF
6938: 
6939:         TRY
6940:             loc_nRet = SQLEXEC(gnConnHandle, ;
6941:                 "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6942:                 "cursor_4c_TmpFinP")
6943:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6944:                 loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6945:             ELSE
6946:                 MsgAviso("Modelo '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
6947:                 loc_oPg.txt_4c_CodFinP.Value = ""
6948:                 loc_oPg.txt_4c_DFinP.Value   = ""
6949:             ENDIF
6950:             IF USED("cursor_4c_TmpFinP")
6951:                 USE IN cursor_4c_TmpFinP
6952:             ENDIF
6953:         CATCH TO loc_oErro
6954:             MsgErro(loc_oErro.Message, "Erro ao validar modelo")
6955:         ENDTRY
6956:     ENDPROC

*-- Linhas 7014 a 7033:
7014:         ENDIF
7015: 
7016:         TRY
7017:             loc_nRet = SQLEXEC(gnConnHandle, ;
7018:                 "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
7019:                 "cursor_4c_TmpAcb")
7020:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
7021:                 loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
7022:             ELSE
7023:                 MsgAviso("Acabamento '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7024:                 loc_oPg.txt_4c_CodAcb.Value = ""
7025:                 loc_oPg.txt_4c_DAcb.Value   = ""
7026:             ENDIF
7027:             IF USED("cursor_4c_TmpAcb")
7028:                 USE IN cursor_4c_TmpAcb
7029:             ENDIF
7030:         CATCH TO loc_oErro
7031:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
7032:         ENDTRY
7033:     ENDPROC

*-- Linhas 7093 a 7113:
7093:         ENDIF
7094: 
7095:         TRY
7096:             loc_nRet = SQLEXEC(gnConnHandle, ;
7097:                 "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
7098:                 IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
7099:                 "cursor_4c_TmpClass")
7100:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
7101:                 loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
7102:             ELSE
7103:                 MsgAviso("Classifica" + CHR(231) + CHR(227) + "o '" + loc_cCod + "' n" + CHR(227) + "o encontrada!")
7104:                 loc_oPg.txt_4c_Class.Value  = ""
7105:                 loc_oPg.txt_4c_DClass.Value = ""
7106:             ENDIF
7107:             IF USED("cursor_4c_TmpClass")
7108:                 USE IN cursor_4c_TmpClass
7109:             ENDIF
7110:         CATCH TO loc_oErro
7111:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
7112:         ENDTRY
7113:     ENDPROC

*-- Linhas 7122 a 7140:
7122:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7123:                 "SigCdCls", "cursor_4c_BuscaClass", "cods", loc_cAtual, ;
7124:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o", .F., .T., ;
7125:                 IIF(EMPTY(loc_cCgru), "", "(cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"))
7126:             IF VARTYPE(loc_oBusca) = "O"
7127:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7128:                     IF USED("cursor_4c_BuscaClass")
7129:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7130:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7131:                     ENDIF
7132:                 ELSE
7133:                     IF !loc_oBusca.this_lAchouRegistro
7134:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
7135:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7136:                     loc_oBusca.Show()
7137:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
7138:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7139:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7140:                     ENDIF

*-- Linhas 7172 a 7191:
7172:         ENDIF
7173: 
7174:         TRY
7175:             loc_nRet = SQLEXEC(gnConnHandle, ;
7176:                 "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
7177:                 "cursor_4c_TmpLocal")
7178:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpLocal") = 0
7179:                 MsgAviso("Local '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7180:                 loc_oPg.txt_4c_Local.Value = ""
7181:             ENDIF
7182:             IF USED("cursor_4c_TmpLocal")
7183:                 USE IN cursor_4c_TmpLocal
7184:             ENDIF
7185:         CATCH TO loc_oErro
7186:             MsgErro(loc_oErro.Message, "Erro ao validar local")
7187:         ENDTRY
7188:     ENDPROC
7189: 
7190:     PROCEDURE AbrirLookupLocal()
7191:         LOCAL loc_oBusca, loc_oPg, loc_cAtual

*-- Linhas 7239 a 7276:
7239:         *----------------------------------------------------------------------
7240:         IF !USED("cursor_4c_GrdCons")
7241:             SET NULL ON
7242:             CREATE CURSOR cursor_4c_GrdCons (;
7243:                 mats      C(14), ;
7244:                 qtds      N(12,4), ;
7245:                 unicompos C(5), ;
7246:                 Grupos    C(3), ;
7247:                 Descrs    C(65), ;
7248:                 Ordems    N(5,0), ;
7249:                 consumo   N(12,4), ;
7250:                 Cods      C(5), ;
7251:                 dcats     C(65), ;
7252:                 Dopes     C(5))
7253:             SET NULL OFF
7254:         ENDIF
7255: 
7256:         *----------------------------------------------------------------------
7257:         *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
7258:         *----------------------------------------------------------------------
7259:         IF !USED("cursor_4c_GrDTEMP")
7260:             SET NULL ON
7261:             CREATE CURSOR cursor_4c_GrDTEMP (;
7262:                 agrup C(30), ;
7263:                 tempo N(12,4))
7264:             SET NULL OFF
7265:         ENDIF
7266: 
7267:         *----------------------------------------------------------------------
7268:         *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
7269:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
7270:         *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao
7271:         *----------------------------------------------------------------------
7272:         loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
7273:         loc_oGrd = loc_oPg.grd_4c_GrdCons
7274: 
7275:         WITH loc_oGrd
7276:             .Top              = 155

*-- Linhas 7284 a 7380:
7284:             .GridLineWidth    = 1
7285:             .GridLineColor    = RGB(238, 238, 238)
7286:             .RecordMark       = .F.
7287:             .DeleteMark       = .F.
7288:             .AllowRowSizing   = .F.
7289:             .ReadOnly         = .F.
7290:             .BackColor        = RGB(255, 255, 255)
7291:             .ForeColor        = RGB(90, 90, 90)
7292:             .HighlightBackColor = RGB(220, 230, 242)
7293:             .HighlightForeColor = RGB(15, 41, 104)
7294:             .HighlightStyle   = 2
7295:             .RowHeight        = 16
7296:             .ScrollBars       = 2
7297:             .Themes           = .F.
7298:             .Visible          = .T.
7299:         ENDWITH
7300: 
7301:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7302:         loc_oPg.grd_4c_GrdCons.RecordSource = "cursor_4c_GrdCons"
7303: 
7304:         *-- Configurar colunas APOS RecordSource
7305:         WITH loc_oPg.grd_4c_GrdCons
7306:             *-- Col1: Componente (mats C14) W:140 - readonly
7307:             .Column1.Header1.Caption = "Componente"
7308:             .Column1.Width           = 140
7309:             .Column1.ControlSource   = "cursor_4c_GrdCons.mats"
7310:             .Column1.Alignment       = 0
7311:             .Column1.ReadOnly        = .T.
7312: 
7313:             *-- Col2: Qtde. (qtds N) W:70 - readonly
7314:             .Column2.Header1.Caption = "Qtde."
7315:             .Column2.Width           = 70
7316:             .Column2.ControlSource   = "cursor_4c_GrdCons.qtds"
7317:             .Column2.Alignment       = 1
7318:             .Column2.ReadOnly        = .T.
7319: 
7320:             *-- Col3: Uni (unicompos C5) W:40 - readonly
7321:             .Column3.Header1.Caption = "Uni"
7322:             .Column3.Width           = 40
7323:             .Column3.ControlSource   = "cursor_4c_GrdCons.unicompos"
7324:             .Column3.Alignment       = 0
7325:             .Column3.ReadOnly        = .T.
7326: 
7327:             *-- Col4: Fase (Grupos C3) W:45 - editable, F4 abre lookup SigCdPrf
7328:             .Column4.Header1.Caption = "Fase"
7329:             .Column4.Width           = 45
7330:             .Column4.ControlSource   = "cursor_4c_GrdCons.Grupos"
7331:             .Column4.Alignment       = 0
7332:             .Column4.ReadOnly        = .F.
7333: 
7334:             *-- Col5: Descricao de fase (Descrs C65) W:250 - editable quando Col4 vazia
7335:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7336:             .Column5.Width           = 250
7337:             .Column5.ControlSource   = "cursor_4c_GrdCons.Descrs"
7338:             .Column5.Alignment       = 0
7339:             .Column5.ReadOnly        = .F.
7340: 
7341:             *-- Col6: Ord. (Ordems N) W:40 - readonly
7342:             .Column6.Header1.Caption = "Ord."
7343:             .Column6.Width           = 40
7344:             .Column6.ControlSource   = "cursor_4c_GrdCons.Ordems"
7345:             .Column6.Alignment       = 1
7346:             .Column6.ReadOnly        = .T.
7347: 
7348:             *-- Col7: Consumo (consumo N) W:80 - editable em INCLUIR/ALTERAR
7349:             .Column7.Header1.Caption = "Consumo"
7350:             .Column7.Width           = 80
7351:             .Column7.ControlSource   = "cursor_4c_GrdCons.consumo"
7352:             .Column7.Alignment       = 1
7353:             .Column7.ReadOnly        = .F.
7354: 
7355:             *-- Col8: Cat. (Cods C5) W:45 - editable, F4 abre lookup SigCdCat
7356:             .Column8.Header1.Caption = "Cat."
7357:             .Column8.Width           = 45
7358:             .Column8.ControlSource   = "cursor_4c_GrdCons.Cods"
7359:             .Column8.Alignment       = 0
7360:             .Column8.ReadOnly        = .F.
7361: 
7362:             *-- Col9: Descricao de categoria (dcats C65) W:277 - editable
7363:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7364:             .Column9.Width           = 277
7365:             .Column9.ControlSource   = "cursor_4c_GrdCons.dcats"
7366:             .Column9.Alignment       = 0
7367:             .Column9.ReadOnly        = .F.
7368:         ENDWITH
7369: 
7370:         *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
7371:         BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
7372:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
7373:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
7374:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
7375: 
7376:         *----------------------------------------------------------------------
7377:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7378:         *----------------------------------------------------------------------
7379:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7380:         WITH loc_oPg.lbl_4c_Label7

*-- Linhas 7467 a 7514:
7467:             .GridLineWidth    = 1
7468:             .GridLineColor    = RGB(238, 238, 238)
7469:             .RecordMark       = .F.
7470:             .DeleteMark       = .F.
7471:             .AllowRowSizing   = .F.
7472:             .ReadOnly         = .T.
7473:             .BackColor        = RGB(255, 255, 255)
7474:             .ForeColor        = RGB(90, 90, 90)
7475:             .HighlightBackColor = RGB(220, 230, 242)
7476:             .HighlightForeColor = RGB(15, 41, 104)
7477:             .HighlightStyle   = 2
7478:             .RowHeight        = 16
7479:             .ScrollBars       = 2
7480:             .Themes           = .F.
7481:             .Visible          = .T.
7482:         ENDWITH
7483: 
7484:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7485:         loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
7486: 
7487:         *-- Configurar colunas do grDTEMP APOS RecordSource
7488:         WITH loc_oPg.grd_4c_GrDTEMP
7489:             *-- Col1: Agrupamento (agrup C30) W:100 - readonly
7490:             .Column1.Header1.Caption = "Agrupamento"
7491:             .Column1.Width           = 100
7492:             .Column1.ControlSource   = "cursor_4c_GrDTEMP.agrup"
7493:             .Column1.Alignment       = 0
7494:             .Column1.ReadOnly        = .T.
7495: 
7496:             *-- Col2: Tempo % (tempo N) W:72 - readonly
7497:             .Column2.Header1.Caption = "Tempo %"
7498:             .Column2.Width           = 72
7499:             .Column2.ControlSource   = "cursor_4c_GrDTEMP.tempo"
7500:             .Column2.Alignment       = 1
7501:             .Column2.ReadOnly        = .T.
7502:         ENDWITH
7503: 
7504:     ENDPROC
7505: 
7506:     *==========================================================================
7507:     * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
7508:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
7509:     *==========================================================================
7510: 
7511:     *--------------------------------------------------------------------------
7512:     * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
7513:     *--------------------------------------------------------------------------
7514:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)

*-- Linhas 7547 a 7565:
7547:                     ENDIF
7548:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
7549:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7550:                             SELECT cursor_4c_GrdCons
7551:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
7552:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
7553:                         ENDIF
7554:                     ENDIF
7555:                     loc_oBusca.Release()
7556:                 ENDIF
7557:                 IF USED("cursor_4c_BuscaPrf")
7558:                     USE IN cursor_4c_BuscaPrf
7559:                 ENDIF
7560:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7561:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7562:                 ENDIF
7563:             CATCH TO loc_oErro
7564:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
7565:             ENDTRY

*-- Linhas 7603 a 7621:
7603:                     ENDIF
7604:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
7605:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7606:                             SELECT cursor_4c_GrdCons
7607:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
7608:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
7609:                             IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
7610:                                 REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
7611:                             ENDIF
7612:                             IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
7613:                                 REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
7614:                             ENDIF
7615:                         ENDIF
7616:                     ENDIF
7617:                     loc_oBusca.Release()
7618:                 ENDIF
7619:                 IF USED("cursor_4c_BuscaPrf2")
7620:                     USE IN cursor_4c_BuscaPrf2
7621:                 ENDIF

*-- Linhas 7655 a 7673:
7655:                     ENDIF
7656:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
7657:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7658:                             SELECT cursor_4c_GrdCons
7659:                             REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
7660:                             REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
7661:                         ENDIF
7662:                     ENDIF
7663:                     loc_oBusca.Release()
7664:                 ENDIF
7665:                 IF USED("cursor_4c_BuscaCat")
7666:                     USE IN cursor_4c_BuscaCat
7667:                 ENDIF
7668:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7669:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7670:                 ENDIF
7671:             CATCH TO loc_oErro
7672:                 MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
7673:             ENDTRY

*-- Linhas 7745 a 7849:
7745:             .GridLineWidth     = 1
7746:             .GridLineColor     = RGB(238, 238, 238)
7747:             .RecordMark        = .F.
7748:             .DeleteMark        = .F.
7749:             .AllowRowSizing    = .F.
7750:             .ReadOnly          = .F.
7751:             .BackColor         = RGB(255, 255, 255)
7752:             .ForeColor         = RGB(90, 90, 90)
7753:             .HighlightBackColor = RGB(220, 230, 242)
7754:             .HighlightForeColor = RGB(15, 41, 104)
7755:             .HighlightStyle    = 2
7756:             .RowHeight         = 16
7757:             .ScrollBars        = 2
7758:             .Visible           = .T.
7759:         ENDWITH
7760: 
7761:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7762:         loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"
7763: 
7764:         *-- Configurar colunas APOS RecordSource
7765:         WITH loc_oPg.grd_4c_CustoCompo
7766:             *-- Col1: Item/Material (C14) W:80
7767:             .Column1.Header1.Caption   = "Item"
7768:             .Column1.Width             = 80
7769:             .Column1.ControlSource     = "cursor_4c_Compo.mats"
7770:             .Column1.Alignment         = 0
7771: 
7772:             *-- Col2: Descricao (C65) W:185
7773:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
7774:             .Column2.Width             = 185
7775:             .Column2.ControlSource     = "cursor_4c_Compo.dcomps"
7776:             .Column2.Alignment         = 0
7777: 
7778:             *-- Col3: Un (C5) W:35 - readonly (When=.F.)
7779:             .Column3.Header1.Caption   = "Un"
7780:             .Column3.Width             = 35
7781:             .Column3.ControlSource     = "cursor_4c_Compo.unicompos"
7782:             .Column3.ReadOnly          = .T.
7783: 
7784:             *-- Col4: Valor (N12,4) W:65
7785:             .Column4.Header1.Caption   = "Valor"
7786:             .Column4.Width             = 65
7787:             .Column4.ControlSource     = "cursor_4c_Compo.pcompos"
7788:             .Column4.Alignment         = 1
7789: 
7790:             *-- Col5: Qtd (N12,4) W:55
7791:             .Column5.Header1.Caption   = "Qtd"
7792:             .Column5.Width             = 55
7793:             .Column5.ControlSource     = "cursor_4c_Compo.qtds"
7794:             .Column5.Alignment         = 1
7795: 
7796:             *-- Col6: Total (N12,4) W:65 - readonly (calculado, When=.F.)
7797:             .Column6.Header1.Caption   = "Total"
7798:             .Column6.Width             = 65
7799:             .Column6.ControlSource     = "cursor_4c_Compo.totals"
7800:             .Column6.Alignment         = 1
7801:             .Column6.ReadOnly          = .T.
7802: 
7803:             *-- Col7: Moe/Moeda (C5) W:35
7804:             .Column7.Header1.Caption   = "Moe"
7805:             .Column7.Width             = 35
7806:             .Column7.ControlSource     = "cursor_4c_Compo.bloqueio"
7807: 
7808:             *-- Col8: Observacao (C40) W:95
7809:             .Column8.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
7810:             .Column8.Width             = 95
7811:             .Column8.ControlSource     = "cursor_4c_Compo.obscompos"
7812:             .Column8.Alignment         = 0
7813: 
7814:             *-- Col9: Etiq (C1) W:30
7815:             .Column9.Header1.Caption   = "Etiq"
7816:             .Column9.Width             = 30
7817:             .Column9.ControlSource     = "cursor_4c_Compo.etiq"
7818: 
7819:             *-- Col10: Consumo (N12,4) W:65
7820:             .Column10.Header1.Caption  = "Consumo"
7821:             .Column10.Width            = 65
7822:             .Column10.ControlSource    = "cursor_4c_Compo.consumo"
7823:             .Column10.Alignment        = 1
7824: 
7825:             *-- Col11: Qtd cons (N12,4) W:55
7826:             .Column11.Header1.Caption  = "Qtd"
7827:             .Column11.Width            = 55
7828:             .Column11.ControlSource    = "cursor_4c_Compo.qtd2"
7829:             .Column11.Alignment        = 1
7830: 
7831:             *-- Col12: Un cons (C5) W:30 - readonly (When=.F.)
7832:             .Column12.Header1.Caption  = "Un"
7833:             .Column12.Width            = 30
7834:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7835:             .Column12.ReadOnly         = .T.
7836:         ENDWITH
7837:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7838: 
7839:         *----------------------------------------------------------------------
7840:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7841:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7842:         *----------------------------------------------------------------------
7843:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7844:         WITH loc_oPg.cnt_4c_BotoesCusto
7845:             .Top         = 240
7846:             .Left        = 851
7847:             .Width       = 50
7848:             .Height      = 90
7849:             .BackStyle = 1

*-- Linhas 8002 a 8072:
8002:             .GridLineWidth     = 1
8003:             .GridLineColor     = RGB(238, 238, 238)
8004:             .RecordMark        = .F.
8005:             .DeleteMark        = .F.
8006:             .AllowRowSizing    = .F.
8007:             .ReadOnly          = .T.
8008:             .BackColor         = RGB(255, 255, 255)
8009:             .ForeColor         = RGB(90, 90, 90)
8010:             .HighlightBackColor = RGB(220, 230, 242)
8011:             .HighlightForeColor = RGB(15, 41, 104)
8012:             .HighlightStyle    = 2
8013:             .RowHeight         = 16
8014:             .ScrollBars        = 2
8015:             .Visible           = .T.
8016:         ENDWITH
8017: 
8018:         *-- RecordSource FORA do WITH
8019:         loc_oPg.grd_4c_GrupoCusto.RecordSource = "cursor_4c_Grupo"
8020: 
8021:         *-- Configurar colunas APOS RecordSource
8022:         WITH loc_oPg.grd_4c_GrupoCusto
8023:             *-- Col1: Grupo (C3) W:40 - readonly
8024:             .Column1.Header1.Caption   = "Grp"
8025:             .Column1.Width             = 40
8026:             .Column1.ControlSource     = "cursor_4c_Grupo.cgrus"
8027:             .Column1.ReadOnly          = .T.
8028: 
8029:             *-- Col2: Total (N12,4) W:100 - readonly
8030:             .Column2.Header1.Caption   = "Total"
8031:             .Column2.Width             = 100
8032:             .Column2.ControlSource     = "cursor_4c_Grupo.valgr"
8033:             .Column2.Alignment         = 1
8034:             .Column2.ReadOnly          = .T.
8035: 
8036:             *-- Col3: Moeda (C5) W:50 - readonly
8037:             .Column3.Header1.Caption   = "Moe"
8038:             .Column3.Width             = 50
8039:             .Column3.ControlSource     = "cursor_4c_Grupo.moeds"
8040:             .Column3.ReadOnly          = .T.
8041:         ENDWITH
8042:     ENDPROC
8043: 
8044:     *--------------------------------------------------------------------------
8045:     * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
8046:     *--------------------------------------------------------------------------
8047:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
8048:         LOCAL loc_oPg, loc_nRet
8049:         TRY
8050:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8051:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
8052:                 loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
8053:                 *-- Buscar descricao do grupo
8054:                 IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
8055:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8056:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
8057:                         EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
8058:                         "cursor_4c_TmpGrpCusto")
8059:                     IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
8060:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)
8061:                     ELSE
8062:                         loc_oPg.txt_4c_DGruCompos.Value = ""
8063:                     ENDIF
8064:                     IF USED("cursor_4c_TmpGrpCusto")
8065:                         USE IN cursor_4c_TmpGrpCusto
8066:                     ENDIF
8067:                 ELSE
8068:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8069:                 ENDIF
8070:             ENDIF
8071:         CATCH TO loc_oErro
8072:             *-- silencioso: refresh de display nao deve bloquear navegacao

*-- Linhas 8104 a 8150:
8104:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
8105:             ENDIF
8106:             IF USED("cursor_4c_Compo")
8107:                 SELECT cursor_4c_Compo
8108:                 GO TOP IN cursor_4c_Compo
8109:                 LOCATE FOR EMPTY(mats)
8110:                 IF EOF("cursor_4c_Compo")
8111:                     INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
8112:                 ENDIF
8113:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8114:                 IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
8115:                     loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
8116:                 ENDIF
8117:             ENDIF
8118:         CATCH TO loc_oErro
8119:             MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
8120:         ENDTRY
8121:     ENDPROC
8122: 
8123:     *--------------------------------------------------------------------------
8124:     * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
8125:     *--------------------------------------------------------------------------
8126:     PROCEDURE CmdExcluirCustoClick()
8127:         LOCAL loc_oPg
8128:         TRY
8129:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8130:                 RETURN
8131:             ENDIF
8132:             IF USED("cursor_4c_Compo")
8133:                 SELECT cursor_4c_Compo
8134:                 IF !EOF("cursor_4c_Compo")
8135:                     DELETE
8136:                     IF !EOF("cursor_4c_Compo")
8137:                         SKIP
8138:                         SKIP -1
8139:                     ENDIF
8140:                     GO BOTTOM IN cursor_4c_Compo
8141:                 ENDIF
8142:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8143:                 loc_oPg.grd_4c_CustoCompo.SetFocus()
8144:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8145:             ENDIF
8146:         CATCH TO loc_oErro
8147:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8148:         ENDTRY
8149:     ENDPROC
8150: 

*-- Linhas 8181 a 8221:
8181:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8182: 
8183:         *----------------------------------------------------------------------
8184:         *-- Cursor placeholder cursor_4c_GradFase (SigCdPrf + SigCdGcr JOIN)
8185:         *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
8186:         *----------------------------------------------------------------------
8187:         IF !USED("cursor_4c_GradFase")
8188:             SET NULL ON
8189:             CREATE CURSOR cursor_4c_GradFase (;
8190:                 Ordems   N(5,0), ;
8191:                 Grupos   C(10), ;
8192:                 Descrs   C(65), ;
8193:                 UniPrdts C(10), ;
8194:                 MatPrdts C(15), ;
8195:                 Obs      M, ;
8196:                 FigProcs M)
8197:             SET NULL OFF
8198:         ENDIF
8199: 
8200:         *----------------------------------------------------------------------
8201:         *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
8202:         *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
8203:         *----------------------------------------------------------------------
8204:         IF !USED("cursor_4c_SigPrMtz")
8205:             SET NULL ON
8206:             CREATE CURSOR cursor_4c_SigPrMtz (;
8207:                 CMats C(14), ;
8208:                 DLocs C(40), ;
8209:                 Qtds  N(3,0))
8210:             SET NULL OFF
8211:         ENDIF
8212: 
8213:         *----------------------------------------------------------------------
8214:         *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
8215:         *----------------------------------------------------------------------
8216:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8217:         WITH loc_oPg.shp_4c_ShpFig
8218:             .Top         = 152
8219:             .Left        = 231
8220:             .Width       = 244
8221:             .Height      = 148

*-- Linhas 8262 a 8330:
8262:             .GridLineWidth      = 1
8263:             .GridLineColor      = RGB(238, 238, 238)
8264:             .RecordMark         = .F.
8265:             .DeleteMark         = .F.
8266:             .AllowRowSizing     = .F.
8267:             .ReadOnly           = .F.
8268:             .BackColor          = RGB(255, 255, 255)
8269:             .ForeColor          = RGB(90, 90, 90)
8270:             .HighlightBackColor = RGB(220, 230, 242)
8271:             .HighlightForeColor = RGB(15, 41, 104)
8272:             .HighlightStyle     = 2
8273:             .RowHeight          = 16
8274:             .ScrollBars         = 2
8275:             .Themes             = .F.
8276:             .Visible            = .T.
8277:         ENDWITH
8278: 
8279:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8280:         loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8281: 
8282:         *-- Configurar colunas APOS RecordSource
8283:         WITH loc_oPg.grd_4c_GradFase
8284:             *-- Col1: Ordem (Ordems N5) W:50 - readonly (When=.F. no legado)
8285:             .Column1.Header1.Caption = "Ordem"
8286:             .Column1.Width           = 50
8287:             .Column1.ControlSource   = "cursor_4c_GradFase.Ordems"
8288:             .Column1.Alignment       = 1
8289:             .Column1.ReadOnly        = .T.
8290: 
8291:             *-- Col2: Fase (Grupos C10) W:80 - editable, F4 lookup SigCdGcr
8292:             .Column2.Header1.Caption = "Fase"
8293:             .Column2.Width           = 80
8294:             .Column2.ControlSource   = "cursor_4c_GradFase.Grupos"
8295:             .Column2.Alignment       = 0
8296:             .Column2.ReadOnly        = .F.
8297: 
8298:             *-- Col3: Utilizacao (Descrs C65) W:130 - readonly
8299:             .Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8300:             .Column3.Width           = 130
8301:             .Column3.ControlSource   = "cursor_4c_GradFase.Descrs"
8302:             .Column3.Alignment       = 0
8303:             .Column3.ReadOnly        = .T.
8304: 
8305:             *-- Col4: Uni. Produtiva (UniPrdts C10) W:80 - editable, F4 lookup SigCdUpd
8306:             .Column4.Header1.Caption = "Uni. Produtiva"
8307:             .Column4.Width           = 80
8308:             .Column4.ControlSource   = "cursor_4c_GradFase.UniPrdts"
8309:             .Column4.Alignment       = 0
8310:             .Column4.ReadOnly        = .F.
8311: 
8312:             *-- Col5: Material (MatPrdts C15) W:80 - editable, F4 lookup SigOpOpt
8313:             .Column5.Header1.Caption = "Material"
8314:             .Column5.Width           = 80
8315:             .Column5.ControlSource   = "cursor_4c_GradFase.MatPrdts"
8316:             .Column5.Alignment       = 0
8317:             .Column5.ReadOnly        = .F.
8318:         ENDWITH
8319: 
8320:         *-- BINDEVENT: GradFase
8321:         BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
8322:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
8323:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
8324:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
8325:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
8326:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")
8327: 
8328:         *----------------------------------------------------------------------
8329:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8330:         *-- Legado: inserir.Click - insere nova linha com resequenciamento

*-- Linhas 8885 a 8939:
8885:             .GridLineWidth      = 1
8886:             .GridLineColor      = RGB(238, 238, 238)
8887:             .RecordMark         = .F.
8888:             .DeleteMark         = .F.
8889:             .AllowRowSizing     = .F.
8890:             .ReadOnly           = .F.
8891:             .BackColor          = RGB(255, 255, 255)
8892:             .ForeColor          = RGB(90, 90, 90)
8893:             .HighlightBackColor = RGB(220, 230, 242)
8894:             .HighlightForeColor = RGB(15, 41, 104)
8895:             .HighlightStyle     = 2
8896:             .RowHeight          = 16
8897:             .ScrollBars         = 2
8898:             .Themes             = .F.
8899:             .Visible            = .T.
8900:         ENDWITH
8901: 
8902:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8903:         loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_SigPrMtz"
8904: 
8905:         *-- Configurar colunas APOS RecordSource
8906:         WITH loc_oPg.grd_4c_Matrizes
8907:             *-- Col1: Matriz (CMats C14) W:70 - editable, F4 lookup crMatrizes
8908:             .Column1.Header1.Caption = "Matriz"
8909:             .Column1.Width           = 70
8910:             .Column1.ControlSource   = "cursor_4c_SigPrMtz.CMats"
8911:             .Column1.Alignment       = 0
8912:             .Column1.ReadOnly        = .F.
8913: 
8914:             *-- Col2: Local (DLocs C40) W:120 - readonly (preenchido pelo lookup)
8915:             .Column2.Header1.Caption = "Local"
8916:             .Column2.Width           = 120
8917:             .Column2.ControlSource   = "cursor_4c_SigPrMtz.DLocs"
8918:             .Column2.Alignment       = 0
8919:             .Column2.ReadOnly        = .T.
8920: 
8921:             *-- Col3: Qtde (Qtds N3) W:56 - editable em modo edicao
8922:             .Column3.Header1.Caption = "Qtde"
8923:             .Column3.Width           = 56
8924:             .Column3.ControlSource   = "cursor_4c_SigPrMtz.Qtds"
8925:             .Column3.Alignment       = 1
8926:             .Column3.ReadOnly        = .F.
8927:         ENDWITH
8928: 
8929:         *-- BINDEVENT: grdMatrizes
8930:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8931:         BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")
8932: 
8933:         *----------------------------------------------------------------------
8934:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8935:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8936:         *----------------------------------------------------------------------
8937:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8938:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8939:             .Caption       = "+"

*-- Linhas 9208 a 9233:
9208:             IF loc_lResultado
9209:                 *-- Calcular Ordem2 para resequenciamento
9210:                 loc_nPonteiro = RECNO("cursor_4c_GradFase")
9211:                 SELECT cursor_4c_GradFase
9212:                 SCAN
9213:                     IF RECNO() # loc_nPonteiro
9214:                         REPLACE Ordems WITH cursor_4c_GradFase.Ordems IN cursor_4c_GradFase
9215:                     ENDIF
9216:                 ENDSCAN
9217:                 GO loc_nPonteiro IN cursor_4c_GradFase
9218:                 SELECT cursor_4c_GradFase
9219:                 *-- Reordenar por Ordems para refletir nova sequencia
9220:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9221:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9222:                 ENDIF
9223:             ENDIF
9224:         CATCH TO loc_oErro
9225:             MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
9226:         ENDTRY
9227:     ENDPROC
9228: 
9229:     *--------------------------------------------------------------------------
9230:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
9231:     * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
9232:     *         Apos selecao: preenche Grupos e Descrs no cursor
9233:     *--------------------------------------------------------------------------

*-- Linhas 9253 a 9271:
9253:                     ENDIF
9254:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
9255:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9256:                             SELECT cursor_4c_GradFase
9257:                             REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
9258:                             REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
9259:                         ENDIF
9260:                     ENDIF
9261:                     loc_oBusca.Release()
9262:                 ENDIF
9263:                 IF USED("cursor_4c_BuscaGcr")
9264:                     USE IN cursor_4c_BuscaGcr
9265:                 ENDIF
9266:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9267:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9268:                 ENDIF
9269:             CATCH TO loc_oErro
9270:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
9271:             ENDTRY

*-- Linhas 9292 a 9327:
9292:                 ENDIF
9293:                 *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
9294:                 IF !EMPTY(loc_cGrupos)
9295:                     loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
9296:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9297:                 ELSE
9298:                     loc_cSQL = "SELECT DISTINCT UniPrdts FROM SigCdUpd"
9299:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9300:                 ENDIF
9301:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaUpd")
9302:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9303:                         "SigCdUpd", "cursor_4c_BuscaUpd2", "UniPrdts", loc_cAtual, ;
9304:                         "Buscar Uni. Produtiva")
9305:                     IF VARTYPE(loc_oBusca) = "O"
9306:                         IF !loc_oBusca.this_lAchouRegistro
9307:                             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
9308:                             loc_oBusca.Show()
9309:                         ENDIF
9310:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
9311:                             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9312:                                 SELECT cursor_4c_GradFase
9313:                                 REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
9314:                             ENDIF
9315:                         ENDIF
9316:                         loc_oBusca.Release()
9317:                     ENDIF
9318:                     IF USED("cursor_4c_BuscaUpd2")
9319:                         USE IN cursor_4c_BuscaUpd2
9320:                     ENDIF
9321:                 ENDIF
9322:                 IF USED("cursor_4c_BuscaUpd")
9323:                     USE IN cursor_4c_BuscaUpd
9324:                 ENDIF
9325:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9326:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9327:                 ENDIF

*-- Linhas 9358 a 9376:
9358:                     ENDIF
9359:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
9360:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9361:                             SELECT cursor_4c_GradFase
9362:                             REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
9363:                         ENDIF
9364:                     ENDIF
9365:                     loc_oBusca.Release()
9366:                 ENDIF
9367:                 IF USED("cursor_4c_BuscaOpt")
9368:                     USE IN cursor_4c_BuscaOpt
9369:                 ENDIF
9370:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9371:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9372:                 ENDIF
9373:             CATCH TO loc_oErro
9374:                 MsgErro(loc_oErro.Message, "Erro ao buscar material")
9375:             ENDTRY
9376:         ENDIF

*-- Linhas 9399 a 9419:
9399:             *-- Carregar imagem da borracha do produto-matriz corrente
9400:             IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9401:                 IF !EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9402:                     loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
9403:                                EscaparSQL(ALLTRIM(cursor_4c_SigPrMtz.CMats))
9404:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalImgPro")
9405:                     IF loc_nRet > 0 AND USED("cursor_4c_LocalImgPro")
9406:                         GO TOP IN cursor_4c_LocalImgPro
9407:                         IF !EOF("cursor_4c_LocalImgPro")
9408:                             IF TYPE("cursor_4c_LocalImgPro.FigJpgs") # "U"
9409:                                 IF !EMPTY(NVL(cursor_4c_LocalImgPro.FigJpgs, ""))
9410:                                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_bor.jpg"
9411:                                     IF STRTOFILE(cursor_4c_LocalImgPro.FigJpgs, loc_lcArquivo) > 0
9412:                                         loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9413:                                         loc_oPg.img_4c_ImgBorracha.Visible = .T.
9414:                                     ENDIF
9415:                                 ENDIF
9416:                             ENDIF
9417:                         ENDIF
9418:                         USE IN cursor_4c_LocalImgPro
9419:                     ENDIF

*-- Linhas 9455 a 9473:
9455:                     ENDIF
9456:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
9457:                         IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9458:                             SELECT cursor_4c_SigPrMtz
9459:                             REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
9460:                             IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
9461:                                 REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
9462:                             ENDIF
9463:                         ENDIF
9464:                     ENDIF
9465:                     loc_oBusca.Release()
9466:                 ENDIF
9467:                 IF USED("cursor_4c_BuscaMatriz")
9468:                     USE IN cursor_4c_BuscaMatriz
9469:                 ENDIF
9470:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9471:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
9472:                 ENDIF
9473:             CATCH TO loc_oErro

*-- Linhas 9492 a 9568:
9492:             *-- Calcular proximo numero de ordem
9493:             loc_nOrdem = 0
9494:             IF !EOF("cursor_4c_GradFase")
9495:                 SELECT MAX(Ordems) AS nMaxOrdem FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpOrd NOFILTER
9496:                 IF USED("cursor_4c_TmpOrd") AND !EOF("cursor_4c_TmpOrd")
9497:                     loc_nOrdem = NVL(cursor_4c_TmpOrd.nMaxOrdem, 0)
9498:                 ENDIF
9499:                 IF USED("cursor_4c_TmpOrd")
9500:                     USE IN cursor_4c_TmpOrd
9501:                 ENDIF
9502:             ENDIF
9503:             loc_nOrdem = loc_nOrdem + 1
9504:             *-- Inserir nova linha
9505:             INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9506:                 VALUES (loc_nOrdem, "", "", "", "")
9507:             *-- Posicionar no novo registro e focar grid
9508:             GO BOTTOM IN cursor_4c_GradFase
9509:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9510:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9511:                 IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9512:                     loc_oPg.grd_4c_GradFase.Refresh()
9513:                     loc_oPg.grd_4c_GradFase.SetFocus()
9514:                 ENDIF
9515:             ENDIF
9516:         CATCH TO loc_oErro
9517:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9518:         ENDTRY
9519:     ENDPROC
9520: 
9521:     *--------------------------------------------------------------------------
9522:     * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
9523:     * Legado: excluir.Click - DELETE e resequencia Ordems
9524:     *--------------------------------------------------------------------------
9525:     PROCEDURE CmdExcluirFaseClick()
9526:         LOCAL loc_oPg, loc_lResultado
9527:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9528:             RETURN
9529:         ENDIF
9530:         loc_lResultado = .T.
9531:         TRY
9532:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9533:                 loc_lResultado = .F.
9534:             ENDIF
9535:             IF loc_lResultado
9536:                 IF !MsgConfirma("Excluir fase selecionada?")
9537:                     loc_lResultado = .F.
9538:                 ENDIF
9539:             ENDIF
9540:             IF loc_lResultado
9541:                 SELECT cursor_4c_GradFase
9542:                 DELETE
9543:                 IF !EOF("cursor_4c_GradFase")
9544:                     SKIP
9545:                 ENDIF
9546:                 IF EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
9547:                     GO BOTTOM IN cursor_4c_GradFase
9548:                 ENDIF
9549:                 *-- Resequenciar Ordems
9550:                 LOCAL loc_nSeq
9551:                 loc_nSeq = 1
9552:                 GO TOP IN cursor_4c_GradFase
9553:                 SCAN FOR !DELETED()
9554:                     REPLACE Ordems WITH loc_nSeq
9555:                     loc_nSeq = loc_nSeq + 1
9556:                 ENDSCAN
9557:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9558:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9559:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9560:                         loc_oPg.grd_4c_GradFase.Refresh()
9561:                     ENDIF
9562:                 ENDIF
9563:             ENDIF
9564:         CATCH TO loc_oErro
9565:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9566:         ENDTRY
9567:     ENDPROC
9568: 

*-- Linhas 9593 a 9620:
9593:                 loc_cUni    = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9594:                 loc_cMat    = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9595:                 *-- Calcular proxima ordem
9596:                 SELECT MAX(Ordems) AS nMaxOrd FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpAlt NOFILTER
9597:                 loc_nOrdem = 1
9598:                 IF USED("cursor_4c_TmpAlt") AND !EOF("cursor_4c_TmpAlt")
9599:                     loc_nOrdem = NVL(cursor_4c_TmpAlt.nMaxOrd, 0) + 1
9600:                 ENDIF
9601:                 IF USED("cursor_4c_TmpAlt")
9602:                     USE IN cursor_4c_TmpAlt
9603:                 ENDIF
9604:                 *-- Inserir copia como alternativa
9605:                 INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9606:                     VALUES (loc_nOrdem, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat)
9607:                 GO BOTTOM IN cursor_4c_GradFase
9608:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9609:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9610:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9611:                         loc_oPg.grd_4c_GradFase.Refresh()
9612:                     ENDIF
9613:                 ENDIF
9614:             ENDIF
9615:         CATCH TO loc_oErro
9616:             MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
9617:         ENDTRY
9618:     ENDPROC
9619: 
9620:     *--------------------------------------------------------------------------

*-- Linhas 9641 a 9665:
9641:                 IF USED("CsCabecalho")
9642:                     USE IN CsCabecalho
9643:                 ENDIF
9644:                 CREATE CURSOR CsCabecalho (;
9645:                     _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
9646:                     _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
9647:                     _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
9648:                     _nPeso N(9,2))
9649:                 WITH THIS.this_oBusinessObject
9650:                     INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
9651:                         VALUES (loc_cNmEmp, ;
9652:                                 "Ficha T" + CHR(233) + "cnica de Produto", ;
9653:                                 ALLTRIM(.this_cCpros), ;
9654:                                 ALLTRIM(.this_cDpros), ;
9655:                                 ALLTRIM(.this_cCgrus), ;
9656:                                 .this_nPesobs)
9657:                 ENDWITH
9658:                 *-- Verificar e executar relatorio
9659:                 LOCAL loc_cRepPath
9660:                 loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
9661:                 IF FILE(loc_cRepPath)
9662:                     REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
9663:                 ELSE
9664:                     MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")
9665:                 ENDIF

*-- Linhas 9693 a 9711:
9693:                 IF !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9694:                     *-- Armazenar imagem binaria no campo memo FigProcs
9695:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9696:                         SELECT cursor_4c_GradFase
9697:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9698:                     ENDIF
9699:                     *-- Atualizar exibicao da imagem
9700:                     THIS.GradFaseAfterRowColChange(0)
9701:                 ENDIF
9702:             ENDIF
9703:         CATCH TO loc_oErro
9704:             MsgErro(loc_oErro.Message, "Erro ao selecionar imagem")
9705:         ENDTRY
9706:     ENDPROC
9707: 
9708:     *--------------------------------------------------------------------------
9709:     * CmdgFigCamClick - Captura imagem via webcam (SigImage form)
9710:     * Legado: cmdgFigCam.Click - DO form SigImage TO lcFigura e armazena
9711:     *--------------------------------------------------------------------------

*-- Linhas 9730 a 9748:
9730:                 ENDIF
9731:                 IF loc_lResultado AND !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9732:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9733:                         SELECT cursor_4c_GradFase
9734:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9735:                     ENDIF
9736:                     THIS.GradFaseAfterRowColChange(0)
9737:                 ENDIF
9738:             ENDIF
9739:         CATCH TO loc_oErro
9740:             MsgErro(loc_oErro.Message, "Erro ao capturar imagem via webcam")
9741:         ENDTRY
9742:     ENDPROC
9743: 
9744:     *--------------------------------------------------------------------------
9745:     * ImgFigJpgClick - Abre imagem da fase em zoom (SigOpZom form)
9746:     * Legado: ImgFigJpg.Click - StrToFile e DO form SigOpZom
9747:     *--------------------------------------------------------------------------
9748:     PROCEDURE ImgFigJpgClick()

*-- Linhas 9767 a 9843:
9767: 
9768:     *--------------------------------------------------------------------------
9769:     * BtnInsereMtxClick - Insere nova linha de matriz em cursor_4c_SigPrMtz
9770:     * Legado: btnInsereMtx.Click - Insert Into crSigPrMtz se vazio
9771:     *--------------------------------------------------------------------------
9772:     PROCEDURE BtnInsereMtxClick()
9773:         LOCAL loc_oPg, loc_lResultado
9774:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9775:             RETURN
9776:         ENDIF
9777:         loc_lResultado = .T.
9778:         TRY
9779:             IF !USED("cursor_4c_SigPrMtz")
9780:                 loc_lResultado = .F.
9781:             ENDIF
9782:             IF loc_lResultado
9783:                 *-- Verificar se ja existe linha vazia (evitar duplicatas)
9784:                 GO TOP IN cursor_4c_SigPrMtz
9785:                 LOCATE FOR EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9786:                 IF !EOF("cursor_4c_SigPrMtz")
9787:                     *-- Ja existe linha vazia - apenas focar
9788:                     loc_lResultado = .F.
9789:                 ENDIF
9790:             ENDIF
9791:             IF loc_lResultado
9792:                 INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9793:                 GO BOTTOM IN cursor_4c_SigPrMtz
9794:             ENDIF
9795:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9796:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9797:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9798:                     loc_oPg.grd_4c_Matrizes.Refresh()
9799:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9800:                 ENDIF
9801:             ENDIF
9802:         CATCH TO loc_oErro
9803:             MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
9804:         ENDTRY
9805:     ENDPROC
9806: 
9807:     *--------------------------------------------------------------------------
9808:     * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
9809:     * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
9810:     *--------------------------------------------------------------------------
9811:     PROCEDURE BtnExcluiMtzClick()
9812:         LOCAL loc_oPg, loc_lResultado
9813:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9814:             RETURN
9815:         ENDIF
9816:         loc_lResultado = .T.
9817:         TRY
9818:             IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
9819:                 loc_lResultado = .F.
9820:             ENDIF
9821:             IF loc_lResultado
9822:                 SELECT cursor_4c_SigPrMtz
9823:                 DELETE
9824:                 *-- Se cursor ficou vazio, reinsere linha placeholder
9825:                 GO TOP IN cursor_4c_SigPrMtz
9826:                 LOCATE FOR !DELETED()
9827:                 IF EOF("cursor_4c_SigPrMtz")
9828:                     INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9829:                 ENDIF
9830:             ENDIF
9831:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9832:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9833:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9834:                     loc_oPg.grd_4c_Matrizes.Refresh()
9835:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9836:                 ENDIF
9837:             ENDIF
9838:         CATCH TO loc_oErro
9839:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9840:         ENDTRY
9841:     ENDPROC
9842: 
9843:     *--------------------------------------------------------------------------

*-- Linhas 10014 a 10032:
10014: 
10015:     *--------------------------------------------------------------------------
10016:     * TxtConquilhaLostFocus - Valida conquilha (SigCdCnq) ao sair do campo
10017:     * Legado: getConquilha.Valid = SQL SELECT conquilhas FROM SigCdCnq + fwBuscaInt
10018:     *--------------------------------------------------------------------------
10019:     PROCEDURE TxtConquilhaLostFocus()
10020:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
10021:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10022:             RETURN
10023:         ENDIF
10024:         *-- Guard: evita reabrir lookup se valor nao mudou
10025:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
10026:             LOCAL loc_cGuardaCnq
10027:             loc_cGuardaCnq = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Conquilha.Value, ""))
10028:             IF loc_cGuardaCnq = THIS.this_cUltimoTxtConquilhaLostFocusValidado
10029:                 RETURN
10030:             ENDIF
10031:             THIS.this_cUltimoTxtConquilhaLostFocusValidado = loc_cGuardaCnq
10032:         ENDIF

*-- Linhas 10045 a 10066:
10045:             ENDIF
10046:             IF loc_lResultado
10047:                 *-- Buscar conquilhas disponiveis em SigCdCnq
10048:                 loc_cSQL = "SELECT DISTINCT conquilhas FROM SigCdCnq"
10049:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaCnq")
10050:                 IF loc_nRet > 0 AND USED("cursor_4c_ListaCnq")
10051:                     SELECT cursor_4c_ListaCnq
10052:                     LOCATE FOR ALLTRIM(NVL(conquilhas, "")) = PADR(loc_cCod, 10)
10053:                     IF !EOF("cursor_4c_ListaCnq")
10054:                         *-- Encontrado direto
10055:                         loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_ListaCnq.conquilhas)
10056:                         THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10057:                     ELSE
10058:                         *-- Nao encontrado - abrir lookup
10059:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10060:                             "SigCdCnq", "cursor_4c_BuscaCnq", "conquilhas", loc_cCod, ;
10061:                             "Buscar Conquilha")
10062:                         IF VARTYPE(loc_oBusca) = "O"
10063:                             IF !loc_oBusca.this_lAchouRegistro
10064:                                 loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
10065:                                 loc_oBusca.Show()
10066:                             ENDIF

*-- Linhas 10101 a 10119:
10101:         *----------------------------------------------------------------------
10102:         IF !USED("cursor_4c_Cmv")
10103:             SET NULL ON
10104:             CREATE CURSOR cursor_4c_Cmv (;
10105:                 Datas   D, ;
10106:                 ValCuss N(12,3), ;
10107:                 Moedas  C(3))
10108:             SET NULL OFF
10109:         ENDIF
10110: 
10111:         *----------------------------------------------------------------------
10112:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10113:         *----------------------------------------------------------------------
10114:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10115:         WITH loc_oPg.lbl_4c_LblGruCus
10116:             .Caption   = "Grupo C.C. :"
10117:             .Top       = 165
10118:             .Left      = 138
10119:             .Width     = 63

*-- Linhas 10900 a 10948:
10900:             .FontName    = "Tahoma"
10901:             .FontSize    = 8
10902:             .RowHeight   = 17
10903:             .DeleteMark  = .F.
10904:             .RecordMark  = .T.
10905:             .ReadOnly    = .T.
10906:             .ScrollBars  = 3
10907:             .Themes      = .F.
10908:             .Visible     = .T.
10909:         ENDWITH
10910:         loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
10911:         WITH loc_oPg.grd_4c_Cmv
10912:             WITH .Column1
10913:                 .ControlSource    = "cursor_4c_Cmv.Datas"
10914:                 .Header1.Caption  = "Per" + CHR(237) + "odo"
10915:                 .Header1.FontName = "Tahoma"
10916:                 .Header1.FontSize = 8
10917:                 .Width            = 59
10918:                 .Movable          = .F.
10919:                 .Resizable        = .F.
10920:                 .ReadOnly         = .T.
10921:             ENDWITH
10922:             WITH .Column2
10923:                 .ControlSource    = "cursor_4c_Cmv.ValCuss"
10924:                 .Header1.Caption  = "Valor Custo GR"
10925:                 .Header1.FontName = "Tahoma"
10926:                 .Header1.FontSize = 8
10927:                 .Width            = 100
10928:                 .Movable          = .F.
10929:                 .Resizable        = .F.
10930:                 .ReadOnly         = .T.
10931:             ENDWITH
10932:             WITH .Column3
10933:                 .ControlSource    = "cursor_4c_Cmv.Moedas"
10934:                 .Header1.Caption  = "Moe"
10935:                 .Header1.FontName = "Tahoma"
10936:                 .Header1.FontSize = 8
10937:                 .Width            = 31
10938:                 .Movable          = .F.
10939:                 .Resizable        = .F.
10940:                 .ReadOnly         = .T.
10941:             ENDWITH
10942:         ENDWITH
10943:     ENDPROC
10944: 
10945:     *--------------------------------------------------------------------------
10946:     * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
10947:     * Chamado por BOParaForm apos carregar dados de SigCdPro
10948:     *--------------------------------------------------------------------------

*-- Linhas 11571 a 11593:
11571:             ENDIF
11572:             IF loc_lResultado
11573:                 *-- Carregar lista de metais (Tipos='M') para lookup
11574:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos = 'M'"
11575:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlM")
11576:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlM")
11577:                     *-- Verificar se codigo existe diretamente
11578:                     SELECT cursor_4c_BuscaMtlM
11579:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11580:                     IF !EOF("cursor_4c_BuscaMtlM")
11581:                         IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11582:                             loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlM.Descs, ""))
11583:                         ENDIF
11584:                         THIS.this_oBusinessObject.this_cMetals = loc_cCod
11585:                     ELSE
11586:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11587:                             "SigCdMtl", "cursor_4c_BuscaMtlSel", "Codigos", loc_cCod, ;
11588:                             "Buscar Metal")
11589:                         IF VARTYPE(loc_oBusca) = "O"
11590:                             IF !loc_oBusca.this_lAchouRegistro
11591:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11592:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11593:                                 loc_oBusca.Show()

*-- Linhas 11653 a 11674:
11653:                 ENDIF
11654:             ENDIF
11655:             IF loc_lResultado
11656:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos <> 'M'"
11657:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlT")
11658:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlT")
11659:                     SELECT cursor_4c_BuscaMtlT
11660:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11661:                     IF !EOF("cursor_4c_BuscaMtlT")
11662:                         IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11663:                             loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlT.Descs, ""))
11664:                         ENDIF
11665:                         THIS.this_oBusinessObject.this_cTeors = loc_cCod
11666:                     ELSE
11667:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11668:                             "SigCdMtl", "cursor_4c_BuscaTeorSel", "Codigos", loc_cCod, ;
11669:                             "Buscar Teor")
11670:                         IF VARTYPE(loc_oBusca) = "O"
11671:                             IF !loc_oBusca.this_lAchouRegistro
11672:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11673:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11674:                                 loc_oBusca.Show()

*-- Linhas 11803 a 11836:
11803:         *----------------------------------------------------------------------
11804:         IF !USED("cursor_4c_SigPrTar")
11805:             SET NULL ON
11806:             CREATE CURSOR cursor_4c_SigPrTar (;
11807:                 DtInis  D NULL, ;
11808:                 DtFims  D NULL, ;
11809:                 Usuars  C(10), ;
11810:                 Tarefas C(10), ;
11811:                 ObsTars M)
11812:             SET NULL OFF
11813:         ENDIF
11814: 
11815:         *----------------------------------------------------------------------
11816:         *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
11817:         *-- Campos: Arquivos
11818:         *----------------------------------------------------------------------
11819:         IF !USED("cursor_4c_SigPrArq")
11820:             SET NULL ON
11821:             CREATE CURSOR cursor_4c_SigPrArq (;
11822:                 Arquivos C(200))
11823:             SET NULL OFF
11824:         ENDIF
11825: 
11826:         *----------------------------------------------------------------------
11827:         *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
11828:         *----------------------------------------------------------------------
11829:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11830:         WITH loc_oPg.shp_4c_ArqFundo
11831:             .Top         = 415
11832:             .Left        = 584
11833:             .Width       = 407
11834:             .Height      = 202
11835:             .BackColor   = RGB(230, 230, 230)
11836:             .BorderColor = RGB(180, 180, 180)

*-- Linhas 11869 a 11954:
11869:             .ColumnCount = 4
11870:             .FontName    = "Tahoma"
11871:             .FontSize    = 8
11872:             .DeleteMark  = .F.
11873:             .ScrollBars  = 2
11874:             .Themes      = .F.
11875:             .Visible     = .T.
11876:             .RecordMark   = .F.
11877:         ENDWITH
11878:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_SigPrTar"
11879:         WITH loc_oPg.grd_4c_Designer
11880:             WITH .Column1
11881:                 .ControlSource     = "cursor_4c_SigPrTar.DtInis"
11882:                 .Header1.Caption   = "Data de In" + CHR(237) + "cio"
11883:                 .Header1.FontName  = "Tahoma"
11884:                 .Header1.FontSize  = 8
11885:                 .Header1.Alignment = 2
11886:                 .Width             = 140
11887:                 .Movable           = .F.
11888:                 .Resizable         = .F.
11889:                 .ReadOnly          = .T.
11890:                 .Alignment         = 2
11891:             ENDWITH
11892:             WITH .Column2
11893:                 .ControlSource     = "cursor_4c_SigPrTar.DtFims"
11894:                 .Header1.Caption   = "Data de Conclus" + CHR(227) + "o"
11895:                 .Header1.FontName  = "Tahoma"
11896:                 .Header1.FontSize  = 8
11897:                 .Header1.Alignment = 2
11898:                 .Width             = 140
11899:                 .Movable           = .F.
11900:                 .Resizable         = .F.
11901:                 .ReadOnly          = .T.
11902:                 .Alignment         = 2
11903:             ENDWITH
11904:             WITH .Column3
11905:                 .ControlSource     = "cursor_4c_SigPrTar.Usuars"
11906:                 .Header1.Caption   = "Usu" + CHR(225) + "rio"
11907:                 .Header1.FontName  = "Tahoma"
11908:                 .Header1.FontSize  = 8
11909:                 .Header1.Alignment = 2
11910:                 .Width             = 90
11911:                 .Movable           = .F.
11912:                 .Resizable         = .F.
11913:                 .ReadOnly          = .T.
11914:             ENDWITH
11915:             WITH .Column4
11916:                 .ControlSource     = "cursor_4c_SigPrTar.Tarefas"
11917:                 .Header1.Caption   = "Tarefa"
11918:                 .Header1.FontName  = "Tahoma"
11919:                 .Header1.FontSize  = 8
11920:                 .Header1.Alignment = 2
11921:                 .Width             = 90
11922:                 .Movable           = .F.
11923:                 .Resizable         = .F.
11924:                 .ReadOnly          = .F.
11925:             ENDWITH
11926:         ENDWITH
11927:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
11928: 
11929:         *----------------------------------------------------------------------
11930:         *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
11931:         *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
11932:         *----------------------------------------------------------------------
11933:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11934:         WITH loc_oPg.obj_4c_ObsTarefas
11935:             .Top              = 160
11936:             .Left             = 584
11937:             .Width            = 407
11938:             .Height           = 238
11939:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11940:             .FontName         = "Tahoma"
11941:             .FontSize         = 8
11942:             .SpecialEffect    = 1
11943:             .ForeColor        = RGB(36, 84, 155)
11944:             .Enabled          = .T.
11945:             .Visible          = .T.
11946:         ENDWITH
11947: 
11948:         *----------------------------------------------------------------------
11949:         *-- btnIniTarefa: Iniciar Tarefa (T:168 L:509 W:42 H:42)
11950:         *----------------------------------------------------------------------
11951:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11952:         WITH loc_oPg.cmd_4c_IniTarefa
11953:             .Top             = 168
11954:             .Left            = 509

*-- Linhas 11997 a 12025:
11997:             .ColumnCount = 1
11998:             .FontName    = "Tahoma"
11999:             .FontSize    = 8
12000:             .DeleteMark  = .F.
12001:             .ScrollBars  = 2
12002:             .ReadOnly    = .T.
12003:             .Themes      = .F.
12004:             .Visible     = .T.
12005:             .RecordMark   = .F.
12006:         ENDWITH
12007:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
12008:         WITH loc_oPg.grd_4c_Arquivos
12009:             WITH .Column1
12010:                 .ControlSource     = "cursor_4c_SigPrArq.Arquivos"
12011:                 .Header1.Caption   = "Arquivos Para Designer"
12012:                 .Header1.FontName  = "Tahoma"
12013:                 .Header1.FontSize  = 8
12014:                 .Header1.Alignment = 2
12015:                 .Width             = 464
12016:                 .Movable           = .F.
12017:                 .Resizable         = .F.
12018:                 .ReadOnly          = .T.
12019:             ENDWITH
12020:         ENDWITH
12021:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
12022: 
12023:         *----------------------------------------------------------------------
12024:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
12025:         *----------------------------------------------------------------------

*-- Linhas 12198 a 12237:
12198:             ENDIF
12199:             IF loc_lResultado
12200:                 *-- Verificar se existe tarefa nao encerrada para este usuario
12201:                 SELECT cursor_4c_SigPrTar
12202:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12203:                     AND EMPTY(NVL(DtFims, {}))
12204:                 IF !EOF("cursor_4c_SigPrTar")
12205:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12206:                         CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12207:                     loc_lResultado = .F.
12208:                 ENDIF
12209:             ENDIF
12210:             IF loc_lResultado
12211:                 *-- Verificar se existe tarefa sem codigo informado
12212:                 SELECT cursor_4c_SigPrTar
12213:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12214:                     AND EMPTY(Tarefas)
12215:                 IF !EOF("cursor_4c_SigPrTar")
12216:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", "Aten" + CHR(231) + CHR(227) + "o")
12217:                     loc_lResultado = .F.
12218:                 ENDIF
12219:             ENDIF
12220:             IF loc_lResultado
12221:                 *-- Inserir nova tarefa com data/hora de inicio
12222:                 SELECT cursor_4c_SigPrTar
12223:                 APPEND BLANK
12224:                 REPLACE cursor_4c_SigPrTar.DtInis  WITH DATE()
12225:                 REPLACE cursor_4c_SigPrTar.Usuars  WITH PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
12226:                 REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
12227:                 REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
12228:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12229:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12230:                 ENDIF
12231:             ENDIF
12232:         CATCH TO loc_oErro
12233:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12234:         ENDTRY
12235:     ENDPROC
12236: 
12237:     *--------------------------------------------------------------------------

*-- Linhas 12261 a 12306:
12261:                 ENDIF
12262:             ENDIF
12263:             IF loc_lResultado
12264:                 SELECT cursor_4c_SigPrTar
12265:                 REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
12266:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12267:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12268:                 ENDIF
12269:             ENDIF
12270:         CATCH TO loc_oErro
12271:             MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
12272:         ENDTRY
12273:     ENDPROC
12274: 
12275:     *--------------------------------------------------------------------------
12276:     * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
12277:     * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
12278:     *--------------------------------------------------------------------------
12279:     PROCEDURE BtnInsArqsClick()
12280:         LOCAL loc_cArq, loc_lResultado
12281:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12282:             RETURN
12283:         ENDIF
12284:         loc_lResultado = .T.
12285:         TRY
12286:             loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
12287:             IF EMPTY(loc_cArq)
12288:                 loc_lResultado = .F.
12289:             ENDIF
12290:             IF loc_lResultado AND USED("cursor_4c_SigPrArq")
12291:                 SELECT cursor_4c_SigPrArq
12292:                 APPEND BLANK
12293:                 REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
12294:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12295:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12296:                 ENDIF
12297:             ENDIF
12298:         CATCH TO loc_oErro
12299:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12300:         ENDTRY
12301:     ENDPROC
12302: 
12303:     *--------------------------------------------------------------------------
12304:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
12305:     * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
12306:     *--------------------------------------------------------------------------

*-- Linhas 12336 a 12373:
12336: 
12337:     *--------------------------------------------------------------------------
12338:     * BtnExcArqsClick - Exclui arquivo da lista de arquivos designer
12339:     * Legado: btnExcArqs.Click - Delete In crSigPrArq + Refresh
12340:     *--------------------------------------------------------------------------
12341:     PROCEDURE BtnExcArqsClick()
12342:         LOCAL loc_lResultado
12343:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12344:             RETURN
12345:         ENDIF
12346:         loc_lResultado = .T.
12347:         TRY
12348:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12349:                 loc_lResultado = .F.
12350:             ENDIF
12351:             IF loc_lResultado
12352:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, "")))
12353:                     loc_lResultado = .F.
12354:                 ENDIF
12355:             ENDIF
12356:             IF loc_lResultado
12357:                 SELECT cursor_4c_SigPrArq
12358:                 DELETE
12359:                 IF !EOF("cursor_4c_SigPrArq")
12360:                     SKIP
12361:                     SKIP -1
12362:                 ENDIF
12363:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12364:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12365:                 ENDIF
12366:                 *-- Limpar imagem ao excluir arquivo
12367:                 LOCAL loc_oPg
12368:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12369:                 IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
12370:                     CLEAR RESOURCES
12371:                     loc_oPg.img_4c_ArqJpg.Picture = ""
12372:                     loc_oPg.img_4c_ArqJpg.Visible = .F.
12373:                 ENDIF

