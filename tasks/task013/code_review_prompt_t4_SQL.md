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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (12560 linhas total):

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

*-- Linhas 6686 a 6777:
6686:             *-- Descricao Unidade 1 (cunis -> SigCdUni.dunis)
6687:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cuni.Value)
6688:             IF !EMPTY(loc_cCod)
6689:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6690:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6691:                     "cursor_4c_TmpUni")
6692:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUni") > 0
6693:                     loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpUni.dunis)
6694:                 ENDIF
6695:                 IF USED("cursor_4c_TmpUni")
6696:                     USE IN cursor_4c_TmpUni
6697:                 ENDIF
6698:             ENDIF
6699: 
6700:             *-- Descricao Unidade 2 (cunips -> SigCdUni.dunis)
6701:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Cunip.Value)
6702:             IF !EMPTY(loc_cCod)
6703:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6704:                     "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCod), ;
6705:                     "cursor_4c_TmpUnip")
6706:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpUnip") > 0
6707:                     loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpUnip.dunis)
6708:                 ENDIF
6709:                 IF USED("cursor_4c_TmpUnip")
6710:                     USE IN cursor_4c_TmpUnip
6711:                 ENDIF
6712:             ENDIF
6713: 
6714:             *-- Descricao Modelo (codfinp -> SigCdFip.descs)
6715:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodFinP.Value)
6716:             IF !EMPTY(loc_cCod)
6717:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6718:                     "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6719:                     "cursor_4c_TmpFinP")
6720:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6721:                     loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6722:                 ENDIF
6723:                 IF USED("cursor_4c_TmpFinP")
6724:                     USE IN cursor_4c_TmpFinP
6725:                 ENDIF
6726:             ENDIF
6727: 
6728:             *-- Descricao Acabamento (codacbs -> SigCdAca.descrs)
6729:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_CodAcb.Value)
6730:             IF !EMPTY(loc_cCod)
6731:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6732:                     "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
6733:                     "cursor_4c_TmpAcb")
6734:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
6735:                     loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
6736:                 ENDIF
6737:                 IF USED("cursor_4c_TmpAcb")
6738:                     USE IN cursor_4c_TmpAcb
6739:                 ENDIF
6740:             ENDIF
6741: 
6742:             *-- Descricao Classificacao (cclass -> SigCdCls.descs, filtrado por cgrus)
6743:             loc_cCod  = ALLTRIM(loc_oPg.txt_4c_Class.Value)
6744:             loc_cCgru = ALLTRIM(loc_oPg.txt_4c_CgruP.Value)
6745:             IF !EMPTY(loc_cCod)
6746:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6747:                     "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
6748:                     IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
6749:                     "cursor_4c_TmpClass")
6750:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
6751:                     loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
6752:                 ENDIF
6753:                 IF USED("cursor_4c_TmpClass")
6754:                     USE IN cursor_4c_TmpClass
6755:                 ENDIF
6756:             ENDIF
6757: 
6758:             *-- Descricao Local (locals -> SigPrLcl.descricaos)
6759:             loc_cCod = ALLTRIM(loc_oPg.txt_4c_Local.Value)
6760:             IF !EMPTY(loc_cCod)
6761:                 loc_nRet = SQLEXEC(gnConnHandle, ;
6762:                     "SELECT descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
6763:                     "cursor_4c_TmpLocal")
6764:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpLocal") > 0
6765:                     *-- Local nao tem campo descricao visivel separado, apenas atualiza silenciosamente
6766:                     *-- O campo txt_4c_Local ja exibe o codigo (10 chars)
6767:                 ENDIF
6768:                 IF USED("cursor_4c_TmpLocal")
6769:                     USE IN cursor_4c_TmpLocal
6770:                 ENDIF
6771:             ENDIF
6772: 
6773:         CATCH TO loc_oErro
6774:             MsgErro(loc_oErro.Message, "Erro ao preencher descri" + CHR(231) + CHR(245) + "es P2")
6775:         ENDTRY
6776:     ENDPROC
6777: 

*-- Linhas 6803 a 6822:
6803:         ENDIF
6804: 
6805:         TRY
6806:             loc_nRet = SQLEXEC(gnConnHandle, ;
6807:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCuni), ;
6808:                 "cursor_4c_TmpCuni")
6809:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCuni") > 0
6810:                 loc_oPg.txt_4c_DUni.Value = ALLTRIM(cursor_4c_TmpCuni.dunis)
6811:             ELSE
6812:                 MsgAviso("Unidade '" + loc_cCuni + "' n" + CHR(227) + "o encontrada!")
6813:                 loc_oPg.txt_4c_Cuni.Value = ""
6814:                 loc_oPg.txt_4c_DUni.Value = ""
6815:             ENDIF
6816:             IF USED("cursor_4c_TmpCuni")
6817:                 USE IN cursor_4c_TmpCuni
6818:             ENDIF
6819:         CATCH TO loc_oErro
6820:             MsgErro(loc_oErro.Message, "Erro ao validar unidade")
6821:         ENDTRY
6822:     ENDPROC

*-- Linhas 6880 a 6899:
6880:         ENDIF
6881: 
6882:         TRY
6883:             loc_nRet = SQLEXEC(gnConnHandle, ;
6884:                 "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(loc_cCunip), ;
6885:                 "cursor_4c_TmpCunip")
6886:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpCunip") > 0
6887:                 loc_oPg.txt_4c_DUnip.Value = ALLTRIM(cursor_4c_TmpCunip.dunis)
6888:             ELSE
6889:                 MsgAviso("Unidade '" + loc_cCunip + "' n" + CHR(227) + "o encontrada!")
6890:                 loc_oPg.txt_4c_Cunip.Value = ""
6891:                 loc_oPg.txt_4c_DUnip.Value = ""
6892:             ENDIF
6893:             IF USED("cursor_4c_TmpCunip")
6894:                 USE IN cursor_4c_TmpCunip
6895:             ENDIF
6896:         CATCH TO loc_oErro
6897:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
6898:         ENDTRY
6899:     ENDPROC

*-- Linhas 6957 a 6976:
6957:         ENDIF
6958: 
6959:         TRY
6960:             loc_nRet = SQLEXEC(gnConnHandle, ;
6961:                 "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(loc_cCod), ;
6962:                 "cursor_4c_TmpFinP")
6963:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpFinP") > 0
6964:                 loc_oPg.txt_4c_DFinP.Value = ALLTRIM(cursor_4c_TmpFinP.descs)
6965:             ELSE
6966:                 MsgAviso("Modelo '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
6967:                 loc_oPg.txt_4c_CodFinP.Value = ""
6968:                 loc_oPg.txt_4c_DFinP.Value   = ""
6969:             ENDIF
6970:             IF USED("cursor_4c_TmpFinP")
6971:                 USE IN cursor_4c_TmpFinP
6972:             ENDIF
6973:         CATCH TO loc_oErro
6974:             MsgErro(loc_oErro.Message, "Erro ao validar modelo")
6975:         ENDTRY
6976:     ENDPROC

*-- Linhas 7034 a 7053:
7034:         ENDIF
7035: 
7036:         TRY
7037:             loc_nRet = SQLEXEC(gnConnHandle, ;
7038:                 "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCod), ;
7039:                 "cursor_4c_TmpAcb")
7040:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpAcb") > 0
7041:                 loc_oPg.txt_4c_DAcb.Value = ALLTRIM(cursor_4c_TmpAcb.descrs)
7042:             ELSE
7043:                 MsgAviso("Acabamento '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7044:                 loc_oPg.txt_4c_CodAcb.Value = ""
7045:                 loc_oPg.txt_4c_DAcb.Value   = ""
7046:             ENDIF
7047:             IF USED("cursor_4c_TmpAcb")
7048:                 USE IN cursor_4c_TmpAcb
7049:             ENDIF
7050:         CATCH TO loc_oErro
7051:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
7052:         ENDTRY
7053:     ENDPROC

*-- Linhas 7113 a 7133:
7113:         ENDIF
7114: 
7115:         TRY
7116:             loc_nRet = SQLEXEC(gnConnHandle, ;
7117:                 "SELECT descs FROM SigCdCls WHERE cods = " + EscaparSQL(loc_cCod) + ;
7118:                 IIF(EMPTY(loc_cCgru), "", " AND (cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"), ;
7119:                 "cursor_4c_TmpClass")
7120:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_TmpClass") > 0
7121:                 loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_TmpClass.descs)
7122:             ELSE
7123:                 MsgAviso("Classifica" + CHR(231) + CHR(227) + "o '" + loc_cCod + "' n" + CHR(227) + "o encontrada!")
7124:                 loc_oPg.txt_4c_Class.Value  = ""
7125:                 loc_oPg.txt_4c_DClass.Value = ""
7126:             ENDIF
7127:             IF USED("cursor_4c_TmpClass")
7128:                 USE IN cursor_4c_TmpClass
7129:             ENDIF
7130:         CATCH TO loc_oErro
7131:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
7132:         ENDTRY
7133:     ENDPROC

*-- Linhas 7142 a 7160:
7142:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
7143:                 "SigCdCls", "cursor_4c_BuscaClass", "cods", loc_cAtual, ;
7144:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o", .F., .T., ;
7145:                 IIF(EMPTY(loc_cCgru), "", "(cgrus = " + EscaparSQL(loc_cCgru) + " OR LTRIM(RTRIM(cgrus)) = '')"))
7146:             IF VARTYPE(loc_oBusca) = "O"
7147:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
7148:                     IF USED("cursor_4c_BuscaClass")
7149:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7150:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7151:                     ENDIF
7152:                 ELSE
7153:                     IF !loc_oBusca.this_lAchouRegistro
7154:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
7155:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
7156:                     loc_oBusca.Show()
7157:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
7158:                         loc_oPg.txt_4c_Class.Value  = ALLTRIM(cursor_4c_BuscaClass.cods)
7159:                         loc_oPg.txt_4c_DClass.Value = ALLTRIM(cursor_4c_BuscaClass.descs)
7160:                     ENDIF

*-- Linhas 7192 a 7211:
7192:         ENDIF
7193: 
7194:         TRY
7195:             loc_nRet = SQLEXEC(gnConnHandle, ;
7196:                 "SELECT codigos FROM SigPrLcl WHERE codigos = " + EscaparSQL(loc_cCod), ;
7197:                 "cursor_4c_TmpLocal")
7198:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_TmpLocal") = 0
7199:                 MsgAviso("Local '" + loc_cCod + "' n" + CHR(227) + "o encontrado!")
7200:                 loc_oPg.txt_4c_Local.Value = ""
7201:             ENDIF
7202:             IF USED("cursor_4c_TmpLocal")
7203:                 USE IN cursor_4c_TmpLocal
7204:             ENDIF
7205:         CATCH TO loc_oErro
7206:             MsgErro(loc_oErro.Message, "Erro ao validar local")
7207:         ENDTRY
7208:     ENDPROC
7209: 
7210:     PROCEDURE AbrirLookupLocal()
7211:         LOCAL loc_oBusca, loc_oPg, loc_cAtual

*-- Linhas 7259 a 7296:
7259:         *----------------------------------------------------------------------
7260:         IF !USED("cursor_4c_GrdCons")
7261:             SET NULL ON
7262:             CREATE CURSOR cursor_4c_GrdCons (;
7263:                 mats      C(14), ;
7264:                 qtds      N(12,4), ;
7265:                 unicompos C(5), ;
7266:                 Grupos    C(3), ;
7267:                 Descrs    C(65), ;
7268:                 Ordems    N(5,0), ;
7269:                 consumo   N(12,4), ;
7270:                 Cods      C(5), ;
7271:                 dcats     C(65), ;
7272:                 Dopes     C(5))
7273:             SET NULL OFF
7274:         ENDIF
7275: 
7276:         *----------------------------------------------------------------------
7277:         *-- Cursor placeholder para grDTEMP (Tempo por Agrupamento)
7278:         *----------------------------------------------------------------------
7279:         IF !USED("cursor_4c_GrDTEMP")
7280:             SET NULL ON
7281:             CREATE CURSOR cursor_4c_GrDTEMP (;
7282:                 agrup C(30), ;
7283:                 tempo N(12,4))
7284:             SET NULL OFF
7285:         ENDIF
7286: 
7287:         *----------------------------------------------------------------------
7288:         *-- Grid GrdCons (T:155 L:6 W:987 H:362) - 9 colunas
7289:         *-- Legado: SIGCDPRO.Pagina.Dados.pgframeDados.PgDadosConsP.GrdCons
7290:         *-- Cols: Componente, Qtde., Uni, Fase, Descricao, Ord., Consumo, Cat., Descricao
7291:         *----------------------------------------------------------------------
7292:         loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
7293:         loc_oGrd = loc_oPg.grd_4c_GrdCons
7294: 
7295:         WITH loc_oGrd
7296:             .Top              = 155

*-- Linhas 7304 a 7400:
7304:             .GridLineWidth    = 1
7305:             .GridLineColor    = RGB(238, 238, 238)
7306:             .RecordMark       = .F.
7307:             .DeleteMark       = .F.
7308:             .AllowRowSizing   = .F.
7309:             .ReadOnly         = .F.
7310:             .BackColor        = RGB(255, 255, 255)
7311:             .ForeColor        = RGB(90, 90, 90)
7312:             .HighlightBackColor = RGB(220, 230, 242)
7313:             .HighlightForeColor = RGB(15, 41, 104)
7314:             .HighlightStyle   = 2
7315:             .RowHeight        = 16
7316:             .ScrollBars       = 2
7317:             .Themes           = .F.
7318:             .Visible          = .T.
7319:         ENDWITH
7320: 
7321:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7322:         loc_oPg.grd_4c_GrdCons.RecordSource = "cursor_4c_GrdCons"
7323: 
7324:         *-- Configurar colunas APOS RecordSource
7325:         WITH loc_oPg.grd_4c_GrdCons
7326:             *-- Col1: Componente (mats C14) W:140 - readonly
7327:             .Column1.Header1.Caption = "Componente"
7328:             .Column1.Width           = 140
7329:             .Column1.ControlSource   = "cursor_4c_GrdCons.mats"
7330:             .Column1.Alignment       = 0
7331:             .Column1.ReadOnly        = .T.
7332: 
7333:             *-- Col2: Qtde. (qtds N) W:70 - readonly
7334:             .Column2.Header1.Caption = "Qtde."
7335:             .Column2.Width           = 70
7336:             .Column2.ControlSource   = "cursor_4c_GrdCons.qtds"
7337:             .Column2.Alignment       = 1
7338:             .Column2.ReadOnly        = .T.
7339: 
7340:             *-- Col3: Uni (unicompos C5) W:40 - readonly
7341:             .Column3.Header1.Caption = "Uni"
7342:             .Column3.Width           = 40
7343:             .Column3.ControlSource   = "cursor_4c_GrdCons.unicompos"
7344:             .Column3.Alignment       = 0
7345:             .Column3.ReadOnly        = .T.
7346: 
7347:             *-- Col4: Fase (Grupos C3) W:45 - editable, F4 abre lookup SigCdPrf
7348:             .Column4.Header1.Caption = "Fase"
7349:             .Column4.Width           = 45
7350:             .Column4.ControlSource   = "cursor_4c_GrdCons.Grupos"
7351:             .Column4.Alignment       = 0
7352:             .Column4.ReadOnly        = .F.
7353: 
7354:             *-- Col5: Descricao de fase (Descrs C65) W:250 - editable quando Col4 vazia
7355:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7356:             .Column5.Width           = 250
7357:             .Column5.ControlSource   = "cursor_4c_GrdCons.Descrs"
7358:             .Column5.Alignment       = 0
7359:             .Column5.ReadOnly        = .F.
7360: 
7361:             *-- Col6: Ord. (Ordems N) W:40 - readonly
7362:             .Column6.Header1.Caption = "Ord."
7363:             .Column6.Width           = 40
7364:             .Column6.ControlSource   = "cursor_4c_GrdCons.Ordems"
7365:             .Column6.Alignment       = 1
7366:             .Column6.ReadOnly        = .T.
7367: 
7368:             *-- Col7: Consumo (consumo N) W:80 - editable em INCLUIR/ALTERAR
7369:             .Column7.Header1.Caption = "Consumo"
7370:             .Column7.Width           = 80
7371:             .Column7.ControlSource   = "cursor_4c_GrdCons.consumo"
7372:             .Column7.Alignment       = 1
7373:             .Column7.ReadOnly        = .F.
7374: 
7375:             *-- Col8: Cat. (Cods C5) W:45 - editable, F4 abre lookup SigCdCat
7376:             .Column8.Header1.Caption = "Cat."
7377:             .Column8.Width           = 45
7378:             .Column8.ControlSource   = "cursor_4c_GrdCons.Cods"
7379:             .Column8.Alignment       = 0
7380:             .Column8.ReadOnly        = .F.
7381: 
7382:             *-- Col9: Descricao de categoria (dcats C65) W:277 - editable
7383:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7384:             .Column9.Width           = 277
7385:             .Column9.ControlSource   = "cursor_4c_GrdCons.dcats"
7386:             .Column9.Alignment       = 0
7387:             .Column9.ReadOnly        = .F.
7388:         ENDWITH
7389: 
7390:         *-- BINDEVENT: AfterRowColChange + KeyPress nos campos de lookup
7391:         BINDEVENT(loc_oPg.grd_4c_GrdCons, "AfterRowColChange", THIS, "GrdConsAfterRowColChange")
7392:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
7393:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
7394:         BINDEVENT(loc_oPg.grd_4c_GrdCons.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
7395: 
7396:         *----------------------------------------------------------------------
7397:         *-- Label "Qtde Componentes : " (Say7: T:523 L:25 W:105 H:15)
7398:         *----------------------------------------------------------------------
7399:         loc_oPg.AddObject("lbl_4c_Label7", "Label")
7400:         WITH loc_oPg.lbl_4c_Label7

*-- Linhas 7487 a 7534:
7487:             .GridLineWidth    = 1
7488:             .GridLineColor    = RGB(238, 238, 238)
7489:             .RecordMark       = .F.
7490:             .DeleteMark       = .F.
7491:             .AllowRowSizing   = .F.
7492:             .ReadOnly         = .T.
7493:             .BackColor        = RGB(255, 255, 255)
7494:             .ForeColor        = RGB(90, 90, 90)
7495:             .HighlightBackColor = RGB(220, 230, 242)
7496:             .HighlightForeColor = RGB(15, 41, 104)
7497:             .HighlightStyle   = 2
7498:             .RowHeight        = 16
7499:             .ScrollBars       = 2
7500:             .Themes           = .F.
7501:             .Visible          = .T.
7502:         ENDWITH
7503: 
7504:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7505:         loc_oPg.grd_4c_GrDTEMP.RecordSource = "cursor_4c_GrDTEMP"
7506: 
7507:         *-- Configurar colunas do grDTEMP APOS RecordSource
7508:         WITH loc_oPg.grd_4c_GrDTEMP
7509:             *-- Col1: Agrupamento (agrup C30) W:100 - readonly
7510:             .Column1.Header1.Caption = "Agrupamento"
7511:             .Column1.Width           = 100
7512:             .Column1.ControlSource   = "cursor_4c_GrDTEMP.agrup"
7513:             .Column1.Alignment       = 0
7514:             .Column1.ReadOnly        = .T.
7515: 
7516:             *-- Col2: Tempo % (tempo N) W:72 - readonly
7517:             .Column2.Header1.Caption = "Tempo %"
7518:             .Column2.Width           = 72
7519:             .Column2.ControlSource   = "cursor_4c_GrDTEMP.tempo"
7520:             .Column2.Alignment       = 1
7521:             .Column2.ReadOnly        = .T.
7522:         ENDWITH
7523: 
7524:     ENDPROC
7525: 
7526:     *==========================================================================
7527:     * FASE 11 - Handlers publicos da aba Consulta de Componentes (PgDadosConsP)
7528:     * BINDEVENT requer PUBLIC: sem prefixo PROTECTED
7529:     *==========================================================================
7530: 
7531:     *--------------------------------------------------------------------------
7532:     * GrdConsAfterRowColChange - Naveg. no GrdCons: refresh silencioso
7533:     *--------------------------------------------------------------------------
7534:     PROCEDURE GrdConsAfterRowColChange(par_nColIndex)

*-- Linhas 7567 a 7585:
7567:                     ENDIF
7568:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf")
7569:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7570:                             SELECT cursor_4c_GrdCons
7571:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf.Grupos)
7572:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf.Descrs)
7573:                         ENDIF
7574:                     ENDIF
7575:                     loc_oBusca.Release()
7576:                 ENDIF
7577:                 IF USED("cursor_4c_BuscaPrf")
7578:                     USE IN cursor_4c_BuscaPrf
7579:                 ENDIF
7580:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7581:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7582:                 ENDIF
7583:             CATCH TO loc_oErro
7584:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
7585:             ENDTRY

*-- Linhas 7623 a 7641:
7623:                     ENDIF
7624:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaPrf2")
7625:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7626:                             SELECT cursor_4c_GrdCons
7627:                             REPLACE Descrs WITH ALLTRIM(cursor_4c_BuscaPrf2.Descrs)
7628:                             REPLACE Grupos WITH ALLTRIM(cursor_4c_BuscaPrf2.Grupos)
7629:                             IF TYPE("cursor_4c_BuscaPrf2.Ordems") = "N"
7630:                                 REPLACE Ordems WITH cursor_4c_BuscaPrf2.Ordems
7631:                             ENDIF
7632:                             IF PEMSTATUS(cursor_4c_BuscaPrf2, "Dopes", 5)
7633:                                 REPLACE Dopes WITH ALLTRIM(NVL(cursor_4c_BuscaPrf2.Dopes, ""))
7634:                             ENDIF
7635:                         ENDIF
7636:                     ENDIF
7637:                     loc_oBusca.Release()
7638:                 ENDIF
7639:                 IF USED("cursor_4c_BuscaPrf2")
7640:                     USE IN cursor_4c_BuscaPrf2
7641:                 ENDIF

*-- Linhas 7675 a 7693:
7675:                     ENDIF
7676:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
7677:                         IF USED("cursor_4c_GrdCons") AND !EOF("cursor_4c_GrdCons")
7678:                             SELECT cursor_4c_GrdCons
7679:                             REPLACE Cods  WITH ALLTRIM(cursor_4c_BuscaCat.Cods)
7680:                             REPLACE dcats WITH ALLTRIM(cursor_4c_BuscaCat.Descs)
7681:                         ENDIF
7682:                     ENDIF
7683:                     loc_oBusca.Release()
7684:                 ENDIF
7685:                 IF USED("cursor_4c_BuscaCat")
7686:                     USE IN cursor_4c_BuscaCat
7687:                 ENDIF
7688:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
7689:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5.grd_4c_GrdCons.Refresh()
7690:                 ENDIF
7691:             CATCH TO loc_oErro
7692:                 MsgErro(loc_oErro.Message, "Erro ao buscar categoria")
7693:             ENDTRY

*-- Linhas 7765 a 7869:
7765:             .GridLineWidth     = 1
7766:             .GridLineColor     = RGB(238, 238, 238)
7767:             .RecordMark        = .F.
7768:             .DeleteMark        = .F.
7769:             .AllowRowSizing    = .F.
7770:             .ReadOnly          = .F.
7771:             .BackColor         = RGB(255, 255, 255)
7772:             .ForeColor         = RGB(90, 90, 90)
7773:             .HighlightBackColor = RGB(220, 230, 242)
7774:             .HighlightForeColor = RGB(15, 41, 104)
7775:             .HighlightStyle    = 2
7776:             .RowHeight         = 16
7777:             .ScrollBars        = 2
7778:             .Visible           = .T.
7779:         ENDWITH
7780: 
7781:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
7782:         loc_oPg.grd_4c_CustoCompo.RecordSource = "cursor_4c_Compo"
7783: 
7784:         *-- Configurar colunas APOS RecordSource
7785:         WITH loc_oPg.grd_4c_CustoCompo
7786:             *-- Col1: Item/Material (C14) W:80
7787:             .Column1.Header1.Caption   = "Item"
7788:             .Column1.Width             = 80
7789:             .Column1.ControlSource     = "cursor_4c_Compo.mats"
7790:             .Column1.Alignment         = 0
7791: 
7792:             *-- Col2: Descricao (C65) W:185
7793:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
7794:             .Column2.Width             = 185
7795:             .Column2.ControlSource     = "cursor_4c_Compo.dcomps"
7796:             .Column2.Alignment         = 0
7797: 
7798:             *-- Col3: Un (C5) W:35 - readonly (When=.F.)
7799:             .Column3.Header1.Caption   = "Un"
7800:             .Column3.Width             = 35
7801:             .Column3.ControlSource     = "cursor_4c_Compo.unicompos"
7802:             .Column3.ReadOnly          = .T.
7803: 
7804:             *-- Col4: Valor (N12,4) W:65
7805:             .Column4.Header1.Caption   = "Valor"
7806:             .Column4.Width             = 65
7807:             .Column4.ControlSource     = "cursor_4c_Compo.pcompos"
7808:             .Column4.Alignment         = 1
7809: 
7810:             *-- Col5: Qtd (N12,4) W:55
7811:             .Column5.Header1.Caption   = "Qtd"
7812:             .Column5.Width             = 55
7813:             .Column5.ControlSource     = "cursor_4c_Compo.qtds"
7814:             .Column5.Alignment         = 1
7815: 
7816:             *-- Col6: Total (N12,4) W:65 - readonly (calculado, When=.F.)
7817:             .Column6.Header1.Caption   = "Total"
7818:             .Column6.Width             = 65
7819:             .Column6.ControlSource     = "cursor_4c_Compo.totals"
7820:             .Column6.Alignment         = 1
7821:             .Column6.ReadOnly          = .T.
7822: 
7823:             *-- Col7: Moe/Moeda (C5) W:35
7824:             .Column7.Header1.Caption   = "Moe"
7825:             .Column7.Width             = 35
7826:             .Column7.ControlSource     = "cursor_4c_Compo.bloqueio"
7827: 
7828:             *-- Col8: Observacao (C40) W:95
7829:             .Column8.Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
7830:             .Column8.Width             = 95
7831:             .Column8.ControlSource     = "cursor_4c_Compo.obscompos"
7832:             .Column8.Alignment         = 0
7833: 
7834:             *-- Col9: Etiq (C1) W:30
7835:             .Column9.Header1.Caption   = "Etiq"
7836:             .Column9.Width             = 30
7837:             .Column9.ControlSource     = "cursor_4c_Compo.etiq"
7838: 
7839:             *-- Col10: Consumo (N12,4) W:65
7840:             .Column10.Header1.Caption  = "Consumo"
7841:             .Column10.Width            = 65
7842:             .Column10.ControlSource    = "cursor_4c_Compo.consumo"
7843:             .Column10.Alignment        = 1
7844: 
7845:             *-- Col11: Qtd cons (N12,4) W:55
7846:             .Column11.Header1.Caption  = "Qtd"
7847:             .Column11.Width            = 55
7848:             .Column11.ControlSource    = "cursor_4c_Compo.qtd2"
7849:             .Column11.Alignment        = 1
7850: 
7851:             *-- Col12: Un cons (C5) W:30 - readonly (When=.F.)
7852:             .Column12.Header1.Caption  = "Un"
7853:             .Column12.Width            = 30
7854:             .Column12.ControlSource    = "cursor_4c_Compo.uni2"
7855:             .Column12.ReadOnly         = .T.
7856:         ENDWITH
7857:         BINDEVENT(loc_oPg.grd_4c_CustoCompo, "AfterRowColChange", THIS, "GrdCustoAfterRowColChange")
7858: 
7859:         *----------------------------------------------------------------------
7860:         *-- Botoes do grdCompo (cmdgCompo: 2 botoes)
7861:         *-- Container: T:240 L:851 W:50 H:90 (cada botao 50x45)
7862:         *----------------------------------------------------------------------
7863:         loc_oPg.AddObject("cnt_4c_BotoesCusto", "Container")
7864:         WITH loc_oPg.cnt_4c_BotoesCusto
7865:             .Top         = 240
7866:             .Left        = 851
7867:             .Width       = 50
7868:             .Height      = 90
7869:             .BackStyle = 1

*-- Linhas 8022 a 8092:
8022:             .GridLineWidth     = 1
8023:             .GridLineColor     = RGB(238, 238, 238)
8024:             .RecordMark        = .F.
8025:             .DeleteMark        = .F.
8026:             .AllowRowSizing    = .F.
8027:             .ReadOnly          = .T.
8028:             .BackColor         = RGB(255, 255, 255)
8029:             .ForeColor         = RGB(90, 90, 90)
8030:             .HighlightBackColor = RGB(220, 230, 242)
8031:             .HighlightForeColor = RGB(15, 41, 104)
8032:             .HighlightStyle    = 2
8033:             .RowHeight         = 16
8034:             .ScrollBars        = 2
8035:             .Visible           = .T.
8036:         ENDWITH
8037: 
8038:         *-- RecordSource FORA do WITH
8039:         loc_oPg.grd_4c_GrupoCusto.RecordSource = "cursor_4c_Grupo"
8040: 
8041:         *-- Configurar colunas APOS RecordSource
8042:         WITH loc_oPg.grd_4c_GrupoCusto
8043:             *-- Col1: Grupo (C3) W:40 - readonly
8044:             .Column1.Header1.Caption   = "Grp"
8045:             .Column1.Width             = 40
8046:             .Column1.ControlSource     = "cursor_4c_Grupo.cgrus"
8047:             .Column1.ReadOnly          = .T.
8048: 
8049:             *-- Col2: Total (N12,4) W:100 - readonly
8050:             .Column2.Header1.Caption   = "Total"
8051:             .Column2.Width             = 100
8052:             .Column2.ControlSource     = "cursor_4c_Grupo.valgr"
8053:             .Column2.Alignment         = 1
8054:             .Column2.ReadOnly          = .T.
8055: 
8056:             *-- Col3: Moeda (C5) W:50 - readonly
8057:             .Column3.Header1.Caption   = "Moe"
8058:             .Column3.Width             = 50
8059:             .Column3.ControlSource     = "cursor_4c_Grupo.moeds"
8060:             .Column3.ReadOnly          = .T.
8061:         ENDWITH
8062:     ENDPROC
8063: 
8064:     *--------------------------------------------------------------------------
8065:     * GrdCustoAfterRowColChange - Atualiza Descricao e Grupo ao navegar pgCusto
8066:     *--------------------------------------------------------------------------
8067:     PROCEDURE GrdCustoAfterRowColChange(par_nColIndex)
8068:         LOCAL loc_oPg, loc_nRet
8069:         TRY
8070:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8071:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
8072:                 loc_oPg.txt_4c_CustoDesc.Value = ALLTRIM(cursor_4c_Compo.dcomps)
8073:                 *-- Buscar descricao do grupo
8074:                 IF !EMPTY(ALLTRIM(cursor_4c_Compo.cgrus))
8075:                     loc_nRet = SQLEXEC(gnConnHandle, ;
8076:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
8077:                         EscaparSQL(ALLTRIM(cursor_4c_Compo.cgrus)), ;
8078:                         "cursor_4c_TmpGrpCusto")
8079:                     IF loc_nRet >= 1 AND !EOF("cursor_4c_TmpGrpCusto")
8080:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_TmpGrpCusto.DGrus)
8081:                     ELSE
8082:                         loc_oPg.txt_4c_DGruCompos.Value = ""
8083:                     ENDIF
8084:                     IF USED("cursor_4c_TmpGrpCusto")
8085:                         USE IN cursor_4c_TmpGrpCusto
8086:                     ENDIF
8087:                 ELSE
8088:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8089:                 ENDIF
8090:             ENDIF
8091:         CATCH TO loc_oErro
8092:             *-- silencioso: refresh de display nao deve bloquear navegacao

*-- Linhas 8124 a 8170:
8124:                 loc_cTipo = ALLTRIM(NVL(loc_oPg.cbo_4c_CmbTipos.Value, ""))
8125:             ENDIF
8126:             IF USED("cursor_4c_Compo")
8127:                 SELECT cursor_4c_Compo
8128:                 GO TOP IN cursor_4c_Compo
8129:                 LOCATE FOR EMPTY(mats)
8130:                 IF EOF("cursor_4c_Compo")
8131:                     INSERT INTO cursor_4c_Compo (cpros) VALUES ("")
8132:                 ENDIF
8133:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8134:                 IF VARTYPE(loc_oPg.grd_4c_CustoCompo.Column1) = "O"
8135:                     loc_oPg.grd_4c_CustoCompo.Column1.SetFocus()
8136:                 ENDIF
8137:             ENDIF
8138:         CATCH TO loc_oErro
8139:             MsgErro(loc_oErro.Message, "Erro ao inserir linha de custo")
8140:         ENDTRY
8141:     ENDPROC
8142: 
8143:     *--------------------------------------------------------------------------
8144:     * CmdExcluirCustoClick - Remove linha de custo selecionada (pgCusto)
8145:     *--------------------------------------------------------------------------
8146:     PROCEDURE CmdExcluirCustoClick()
8147:         LOCAL loc_oPg
8148:         TRY
8149:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
8150:                 RETURN
8151:             ENDIF
8152:             IF USED("cursor_4c_Compo")
8153:                 SELECT cursor_4c_Compo
8154:                 IF !EOF("cursor_4c_Compo")
8155:                     DELETE
8156:                     IF !EOF("cursor_4c_Compo")
8157:                         SKIP
8158:                         SKIP -1
8159:                     ENDIF
8160:                     GO BOTTOM IN cursor_4c_Compo
8161:                 ENDIF
8162:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
8163:                 loc_oPg.grd_4c_CustoCompo.SetFocus()
8164:                 loc_oPg.grd_4c_CustoCompo.Refresh()
8165:             ENDIF
8166:         CATCH TO loc_oErro
8167:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8168:         ENDTRY
8169:     ENDPROC
8170: 

*-- Linhas 8201 a 8241:
8201:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
8202: 
8203:         *----------------------------------------------------------------------
8204:         *-- Cursor placeholder cursor_4c_GradFase (SigCdPrf + SigCdGcr JOIN)
8205:         *-- Campos: Ordems, Grupos (fase code), Descrs (utilizacao), UniPrdts, MatPrdts
8206:         *----------------------------------------------------------------------
8207:         IF !USED("cursor_4c_GradFase")
8208:             SET NULL ON
8209:             CREATE CURSOR cursor_4c_GradFase (;
8210:                 Ordems   N(5,0), ;
8211:                 Grupos   C(10), ;
8212:                 Descrs   C(65), ;
8213:                 UniPrdts C(10), ;
8214:                 MatPrdts C(15), ;
8215:                 Obs      M, ;
8216:                 FigProcs M)
8217:             SET NULL OFF
8218:         ENDIF
8219: 
8220:         *----------------------------------------------------------------------
8221:         *-- Cursor placeholder cursor_4c_SigPrMtz (SigPrMtz + SigCdPro JOIN)
8222:         *-- Campos: CMats (cod matriz), DLocs (local), Qtds (quantidade)
8223:         *----------------------------------------------------------------------
8224:         IF !USED("cursor_4c_SigPrMtz")
8225:             SET NULL ON
8226:             CREATE CURSOR cursor_4c_SigPrMtz (;
8227:                 CMats C(14), ;
8228:                 DLocs C(40), ;
8229:                 Qtds  N(3,0))
8230:             SET NULL OFF
8231:         ENDIF
8232: 
8233:         *----------------------------------------------------------------------
8234:         *-- Shape: shpFig (T:152 L:231 W:244 H:148) - borda imagem de fase
8235:         *----------------------------------------------------------------------
8236:         loc_oPg.AddObject("shp_4c_ShpFig", "Shape")
8237:         WITH loc_oPg.shp_4c_ShpFig
8238:             .Top         = 152
8239:             .Left        = 231
8240:             .Width       = 244
8241:             .Height      = 148

*-- Linhas 8282 a 8350:
8282:             .GridLineWidth      = 1
8283:             .GridLineColor      = RGB(238, 238, 238)
8284:             .RecordMark         = .F.
8285:             .DeleteMark         = .F.
8286:             .AllowRowSizing     = .F.
8287:             .ReadOnly           = .F.
8288:             .BackColor          = RGB(255, 255, 255)
8289:             .ForeColor          = RGB(90, 90, 90)
8290:             .HighlightBackColor = RGB(220, 230, 242)
8291:             .HighlightForeColor = RGB(15, 41, 104)
8292:             .HighlightStyle     = 2
8293:             .RowHeight          = 16
8294:             .ScrollBars         = 2
8295:             .Themes             = .F.
8296:             .Visible            = .T.
8297:         ENDWITH
8298: 
8299:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8300:         loc_oPg.grd_4c_GradFase.RecordSource = "cursor_4c_GradFase"
8301: 
8302:         *-- Configurar colunas APOS RecordSource
8303:         WITH loc_oPg.grd_4c_GradFase
8304:             *-- Col1: Ordem (Ordems N5) W:50 - readonly (When=.F. no legado)
8305:             .Column1.Header1.Caption = "Ordem"
8306:             .Column1.Width           = 50
8307:             .Column1.ControlSource   = "cursor_4c_GradFase.Ordems"
8308:             .Column1.Alignment       = 1
8309:             .Column1.ReadOnly        = .T.
8310: 
8311:             *-- Col2: Fase (Grupos C10) W:80 - editable, F4 lookup SigCdGcr
8312:             .Column2.Header1.Caption = "Fase"
8313:             .Column2.Width           = 80
8314:             .Column2.ControlSource   = "cursor_4c_GradFase.Grupos"
8315:             .Column2.Alignment       = 0
8316:             .Column2.ReadOnly        = .F.
8317: 
8318:             *-- Col3: Utilizacao (Descrs C65) W:130 - readonly
8319:             .Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
8320:             .Column3.Width           = 130
8321:             .Column3.ControlSource   = "cursor_4c_GradFase.Descrs"
8322:             .Column3.Alignment       = 0
8323:             .Column3.ReadOnly        = .T.
8324: 
8325:             *-- Col4: Uni. Produtiva (UniPrdts C10) W:80 - editable, F4 lookup SigCdUpd
8326:             .Column4.Header1.Caption = "Uni. Produtiva"
8327:             .Column4.Width           = 80
8328:             .Column4.ControlSource   = "cursor_4c_GradFase.UniPrdts"
8329:             .Column4.Alignment       = 0
8330:             .Column4.ReadOnly        = .F.
8331: 
8332:             *-- Col5: Material (MatPrdts C15) W:80 - editable, F4 lookup SigOpOpt
8333:             .Column5.Header1.Caption = "Material"
8334:             .Column5.Width           = 80
8335:             .Column5.ControlSource   = "cursor_4c_GradFase.MatPrdts"
8336:             .Column5.Alignment       = 0
8337:             .Column5.ReadOnly        = .F.
8338:         ENDWITH
8339: 
8340:         *-- BINDEVENT: GradFase
8341:         BINDEVENT(loc_oPg.grd_4c_GradFase, "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
8342:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "GotFocus",  THIS, "GradFaseCol1GotFocus")
8343:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column1.Text1, "LostFocus", THIS, "GradFaseCol1LostFocus")
8344:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column2.Text1, "KeyPress",  THIS, "GradFaseCol2KeyPress")
8345:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column4.Text1, "KeyPress",  THIS, "GradFaseCol4KeyPress")
8346:         BINDEVENT(loc_oPg.grd_4c_GradFase.Column5.Text1, "KeyPress",  THIS, "GradFaseCol5KeyPress")
8347: 
8348:         *----------------------------------------------------------------------
8349:         *-- Botao Incluir Fase (inserir: T:152 L:950 W:38 H:38)
8350:         *-- Legado: inserir.Click - insere nova linha com resequenciamento

*-- Linhas 8887 a 8941:
8887:             .GridLineWidth      = 1
8888:             .GridLineColor      = RGB(238, 238, 238)
8889:             .RecordMark         = .F.
8890:             .DeleteMark         = .F.
8891:             .AllowRowSizing     = .F.
8892:             .ReadOnly           = .F.
8893:             .BackColor          = RGB(255, 255, 255)
8894:             .ForeColor          = RGB(90, 90, 90)
8895:             .HighlightBackColor = RGB(220, 230, 242)
8896:             .HighlightForeColor = RGB(15, 41, 104)
8897:             .HighlightStyle     = 2
8898:             .RowHeight          = 16
8899:             .ScrollBars         = 2
8900:             .Themes             = .F.
8901:             .Visible            = .T.
8902:         ENDWITH
8903: 
8904:         *-- RecordSource FORA do WITH (evita "Unknown member COLUMN1")
8905:         loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_SigPrMtz"
8906: 
8907:         *-- Configurar colunas APOS RecordSource
8908:         WITH loc_oPg.grd_4c_Matrizes
8909:             *-- Col1: Matriz (CMats C14) W:70 - editable, F4 lookup crMatrizes
8910:             .Column1.Header1.Caption = "Matriz"
8911:             .Column1.Width           = 70
8912:             .Column1.ControlSource   = "cursor_4c_SigPrMtz.CMats"
8913:             .Column1.Alignment       = 0
8914:             .Column1.ReadOnly        = .F.
8915: 
8916:             *-- Col2: Local (DLocs C40) W:120 - readonly (preenchido pelo lookup)
8917:             .Column2.Header1.Caption = "Local"
8918:             .Column2.Width           = 120
8919:             .Column2.ControlSource   = "cursor_4c_SigPrMtz.DLocs"
8920:             .Column2.Alignment       = 0
8921:             .Column2.ReadOnly        = .T.
8922: 
8923:             *-- Col3: Qtde (Qtds N3) W:56 - editable em modo edicao
8924:             .Column3.Header1.Caption = "Qtde"
8925:             .Column3.Width           = 56
8926:             .Column3.ControlSource   = "cursor_4c_SigPrMtz.Qtds"
8927:             .Column3.Alignment       = 1
8928:             .Column3.ReadOnly        = .F.
8929:         ENDWITH
8930: 
8931:         *-- BINDEVENT: grdMatrizes
8932:         BINDEVENT(loc_oPg.grd_4c_Matrizes, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
8933:         BINDEVENT(loc_oPg.grd_4c_Matrizes.Column1.Text1, "KeyPress", THIS, "GrdMatrizesCol1KeyPress")
8934: 
8935:         *----------------------------------------------------------------------
8936:         *-- Botao Inserir Matriz (btnInsereMtx: T:380 L:258 W:38 H:38)
8937:         *-- Legado: btnInsereMtx.Click - insere linha vazia em crSigPrMtz
8938:         *----------------------------------------------------------------------
8939:         loc_oPg.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
8940:         WITH loc_oPg.cmd_4c_BtnInsereMtx
8941:             .Caption       = "+"

*-- Linhas 9212 a 9237:
9212:             IF loc_lResultado
9213:                 *-- Calcular Ordem2 para resequenciamento
9214:                 loc_nPonteiro = RECNO("cursor_4c_GradFase")
9215:                 SELECT cursor_4c_GradFase
9216:                 SCAN
9217:                     IF RECNO() # loc_nPonteiro
9218:                         REPLACE Ordems WITH cursor_4c_GradFase.Ordems IN cursor_4c_GradFase
9219:                     ENDIF
9220:                 ENDSCAN
9221:                 GO loc_nPonteiro IN cursor_4c_GradFase
9222:                 SELECT cursor_4c_GradFase
9223:                 *-- Reordenar por Ordems para refletir nova sequencia
9224:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9225:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9226:                 ENDIF
9227:             ENDIF
9228:         CATCH TO loc_oErro
9229:             MsgErro(loc_oErro.Message, "Erro ao resequenciar fases")
9230:         ENDTRY
9231:     ENDPROC
9232: 
9233:     *--------------------------------------------------------------------------
9234:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr) para coluna Grupos
9235:     * Legado: Column2.Text1.Valid = fwBuscaExt on SigCdGcr by Codigos
9236:     *         Apos selecao: preenche Grupos e Descrs no cursor
9237:     *--------------------------------------------------------------------------

*-- Linhas 9257 a 9275:
9257:                     ENDIF
9258:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
9259:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9260:                             SELECT cursor_4c_GradFase
9261:                             REPLACE Grupos WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Codigos, ""))
9262:                             REPLACE Descrs WITH ALLTRIM(NVL(cursor_4c_BuscaGcr.Descrs,  ""))
9263:                         ENDIF
9264:                     ENDIF
9265:                     loc_oBusca.Release()
9266:                 ENDIF
9267:                 IF USED("cursor_4c_BuscaGcr")
9268:                     USE IN cursor_4c_BuscaGcr
9269:                 ENDIF
9270:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9271:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9272:                 ENDIF
9273:             CATCH TO loc_oErro
9274:                 MsgErro(loc_oErro.Message, "Erro ao buscar fase")
9275:             ENDTRY

*-- Linhas 9296 a 9331:
9296:                 ENDIF
9297:                 *-- Busca unidades produtivas filtradas pelo grupo da fase corrente
9298:                 IF !EMPTY(loc_cGrupos)
9299:                     loc_cSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupos)
9300:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9301:                 ELSE
9302:                     loc_cSQL = "SELECT DISTINCT UniPrdts FROM SigCdUpd"
9303:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaUpd")
9304:                 ENDIF
9305:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaUpd")
9306:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
9307:                         "SigCdUpd", "cursor_4c_BuscaUpd2", "UniPrdts", loc_cAtual, ;
9308:                         "Buscar Uni. Produtiva")
9309:                     IF VARTYPE(loc_oBusca) = "O"
9310:                         IF !loc_oBusca.this_lAchouRegistro
9311:                             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
9312:                             loc_oBusca.Show()
9313:                         ENDIF
9314:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd2")
9315:                             IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9316:                                 SELECT cursor_4c_GradFase
9317:                                 REPLACE UniPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaUpd2.UniPrdts, ""))
9318:                             ENDIF
9319:                         ENDIF
9320:                         loc_oBusca.Release()
9321:                     ENDIF
9322:                     IF USED("cursor_4c_BuscaUpd2")
9323:                         USE IN cursor_4c_BuscaUpd2
9324:                     ENDIF
9325:                 ENDIF
9326:                 IF USED("cursor_4c_BuscaUpd")
9327:                     USE IN cursor_4c_BuscaUpd
9328:                 ENDIF
9329:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9330:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9331:                 ENDIF

*-- Linhas 9362 a 9380:
9362:                     ENDIF
9363:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
9364:                         IF USED("cursor_4c_GradFase") AND !EOF("cursor_4c_GradFase")
9365:                             SELECT cursor_4c_GradFase
9366:                             REPLACE MatPrdts WITH ALLTRIM(NVL(cursor_4c_BuscaOpt.Cods, ""))
9367:                         ENDIF
9368:                     ENDIF
9369:                     loc_oBusca.Release()
9370:                 ENDIF
9371:                 IF USED("cursor_4c_BuscaOpt")
9372:                     USE IN cursor_4c_BuscaOpt
9373:                 ENDIF
9374:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9375:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_GradFase.Refresh()
9376:                 ENDIF
9377:             CATCH TO loc_oErro
9378:                 MsgErro(loc_oErro.Message, "Erro ao buscar material")
9379:             ENDTRY
9380:         ENDIF

*-- Linhas 9403 a 9423:
9403:             *-- Carregar imagem da borracha do produto-matriz corrente
9404:             IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9405:                 IF !EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9406:                     loc_cSQL = "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + ;
9407:                                EscaparSQL(ALLTRIM(cursor_4c_SigPrMtz.CMats))
9408:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalImgPro")
9409:                     IF loc_nRet > 0 AND USED("cursor_4c_LocalImgPro")
9410:                         GO TOP IN cursor_4c_LocalImgPro
9411:                         IF !EOF("cursor_4c_LocalImgPro")
9412:                             IF TYPE("cursor_4c_LocalImgPro.FigJpgs") # "U"
9413:                                 IF !EMPTY(NVL(cursor_4c_LocalImgPro.FigJpgs, ""))
9414:                                     loc_lcArquivo = SYS(2023) + "\" + SYS(2015) + "_bor.jpg"
9415:                                     IF STRTOFILE(cursor_4c_LocalImgPro.FigJpgs, loc_lcArquivo) > 0
9416:                                         loc_oPg.img_4c_ImgBorracha.Picture = loc_lcArquivo
9417:                                         loc_oPg.img_4c_ImgBorracha.Visible = .T.
9418:                                     ENDIF
9419:                                 ENDIF
9420:                             ENDIF
9421:                         ENDIF
9422:                         USE IN cursor_4c_LocalImgPro
9423:                     ENDIF

*-- Linhas 9459 a 9477:
9459:                     ENDIF
9460:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMatriz")
9461:                         IF USED("cursor_4c_SigPrMtz") AND !EOF("cursor_4c_SigPrMtz")
9462:                             SELECT cursor_4c_SigPrMtz
9463:                             REPLACE CMats WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.CPros, ""))
9464:                             IF PEMSTATUS(cursor_4c_BuscaMatriz, "Locals", 5)
9465:                                 REPLACE DLocs WITH ALLTRIM(NVL(cursor_4c_BuscaMatriz.Locals, ""))
9466:                             ENDIF
9467:                         ENDIF
9468:                     ENDIF
9469:                     loc_oBusca.Release()
9470:                 ENDIF
9471:                 IF USED("cursor_4c_BuscaMatriz")
9472:                     USE IN cursor_4c_BuscaMatriz
9473:                 ENDIF
9474:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9475:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_Matrizes.Refresh()
9476:                 ENDIF
9477:             CATCH TO loc_oErro

*-- Linhas 9496 a 9572:
9496:             *-- Calcular proximo numero de ordem
9497:             loc_nOrdem = 0
9498:             IF !EOF("cursor_4c_GradFase")
9499:                 SELECT MAX(Ordems) AS nMaxOrdem FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpOrd NOFILTER
9500:                 IF USED("cursor_4c_TmpOrd") AND !EOF("cursor_4c_TmpOrd")
9501:                     loc_nOrdem = NVL(cursor_4c_TmpOrd.nMaxOrdem, 0)
9502:                 ENDIF
9503:                 IF USED("cursor_4c_TmpOrd")
9504:                     USE IN cursor_4c_TmpOrd
9505:                 ENDIF
9506:             ENDIF
9507:             loc_nOrdem = loc_nOrdem + 1
9508:             *-- Inserir nova linha
9509:             INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9510:                 VALUES (loc_nOrdem, "", "", "", "")
9511:             *-- Posicionar no novo registro e focar grid
9512:             GO BOTTOM IN cursor_4c_GradFase
9513:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9514:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9515:                 IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9516:                     loc_oPg.grd_4c_GradFase.Refresh()
9517:                     loc_oPg.grd_4c_GradFase.SetFocus()
9518:                 ENDIF
9519:             ENDIF
9520:         CATCH TO loc_oErro
9521:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9522:         ENDTRY
9523:     ENDPROC
9524: 
9525:     *--------------------------------------------------------------------------
9526:     * CmdExcluirFaseClick - Exclui linha corrente de cursor_4c_GradFase
9527:     * Legado: excluir.Click - DELETE e resequencia Ordems
9528:     *--------------------------------------------------------------------------
9529:     PROCEDURE CmdExcluirFaseClick()
9530:         LOCAL loc_oPg, loc_lResultado
9531:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9532:             RETURN
9533:         ENDIF
9534:         loc_lResultado = .T.
9535:         TRY
9536:             IF !USED("cursor_4c_GradFase") OR EOF("cursor_4c_GradFase") OR BOF("cursor_4c_GradFase")
9537:                 loc_lResultado = .F.
9538:             ENDIF
9539:             IF loc_lResultado
9540:                 IF !MsgConfirma("Excluir fase selecionada?")
9541:                     loc_lResultado = .F.
9542:                 ENDIF
9543:             ENDIF
9544:             IF loc_lResultado
9545:                 SELECT cursor_4c_GradFase
9546:                 DELETE
9547:                 IF !EOF("cursor_4c_GradFase")
9548:                     SKIP
9549:                 ENDIF
9550:                 IF EOF("cursor_4c_GradFase") AND !BOF("cursor_4c_GradFase")
9551:                     GO BOTTOM IN cursor_4c_GradFase
9552:                 ENDIF
9553:                 *-- Resequenciar Ordems
9554:                 LOCAL loc_nSeq
9555:                 loc_nSeq = 1
9556:                 GO TOP IN cursor_4c_GradFase
9557:                 SCAN FOR !DELETED()
9558:                     REPLACE Ordems WITH loc_nSeq
9559:                     loc_nSeq = loc_nSeq + 1
9560:                 ENDSCAN
9561:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9562:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9563:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9564:                         loc_oPg.grd_4c_GradFase.Refresh()
9565:                     ENDIF
9566:                 ENDIF
9567:             ENDIF
9568:         CATCH TO loc_oErro
9569:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9570:         ENDTRY
9571:     ENDPROC
9572: 

*-- Linhas 9597 a 9624:
9597:                 loc_cUni    = ALLTRIM(NVL(cursor_4c_GradFase.UniPrdts, ""))
9598:                 loc_cMat    = ALLTRIM(NVL(cursor_4c_GradFase.MatPrdts, ""))
9599:                 *-- Calcular proxima ordem
9600:                 SELECT MAX(Ordems) AS nMaxOrd FROM cursor_4c_GradFase INTO CURSOR cursor_4c_TmpAlt NOFILTER
9601:                 loc_nOrdem = 1
9602:                 IF USED("cursor_4c_TmpAlt") AND !EOF("cursor_4c_TmpAlt")
9603:                     loc_nOrdem = NVL(cursor_4c_TmpAlt.nMaxOrd, 0) + 1
9604:                 ENDIF
9605:                 IF USED("cursor_4c_TmpAlt")
9606:                     USE IN cursor_4c_TmpAlt
9607:                 ENDIF
9608:                 *-- Inserir copia como alternativa
9609:                 INSERT INTO cursor_4c_GradFase (Ordems, Grupos, Descrs, UniPrdts, MatPrdts) ;
9610:                     VALUES (loc_nOrdem, loc_cGrupos, loc_cDescrs, loc_cUni, loc_cMat)
9611:                 GO BOTTOM IN cursor_4c_GradFase
9612:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9613:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9614:                     IF VARTYPE(loc_oPg.grd_4c_GradFase) = "O"
9615:                         loc_oPg.grd_4c_GradFase.Refresh()
9616:                     ENDIF
9617:                 ENDIF
9618:             ENDIF
9619:         CATCH TO loc_oErro
9620:             MsgErro(loc_oErro.Message, "Erro ao criar alternativa de fase")
9621:         ENDTRY
9622:     ENDPROC
9623: 
9624:     *--------------------------------------------------------------------------

*-- Linhas 9645 a 9669:
9645:                 IF USED("CsCabecalho")
9646:                     USE IN CsCabecalho
9647:                 ENDIF
9648:                 CREATE CURSOR CsCabecalho (;
9649:                     _NmEmp C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
9650:                     _cGrus C(3),  _dGrus C(20),  _sGrus C(6),  _sDesc C(20), ;
9651:                     _cLinh C(10), _dLinh C(40),  _cGVen C(10), _dGVen C(40), ;
9652:                     _nPeso N(9,2))
9653:                 WITH THIS.this_oBusinessObject
9654:                     INSERT INTO CsCabecalho (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _nPeso) ;
9655:                         VALUES (loc_cNmEmp, ;
9656:                                 "Ficha T" + CHR(233) + "cnica de Produto", ;
9657:                                 ALLTRIM(.this_cCpros), ;
9658:                                 ALLTRIM(.this_cDpros), ;
9659:                                 ALLTRIM(.this_cCgrus), ;
9660:                                 .this_nPesobs)
9661:                 ENDWITH
9662:                 *-- Verificar e executar relatorio
9663:                 LOCAL loc_cRepPath
9664:                 loc_cRepPath = gc_4c_CaminhoReports + "TP_FasePro.frx"
9665:                 IF FILE(loc_cRepPath)
9666:                     REPORT FORM (loc_cRepPath) PREVIEW NOCONSOLE
9667:                 ELSE
9668:                     MsgAviso("Relat" + CHR(243) + "rio TP_FasePro.frx n" + CHR(227) + "o encontrado.")
9669:                 ENDIF

*-- Linhas 9697 a 9715:
9697:                 IF !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9698:                     *-- Armazenar imagem binaria no campo memo FigProcs
9699:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9700:                         SELECT cursor_4c_GradFase
9701:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9702:                     ENDIF
9703:                     *-- Atualizar exibicao da imagem
9704:                     THIS.GradFaseAfterRowColChange(0)
9705:                 ENDIF
9706:             ENDIF
9707:         CATCH TO loc_oErro
9708:             MsgErro(loc_oErro.Message, "Erro ao selecionar imagem")
9709:         ENDTRY
9710:     ENDPROC
9711: 
9712:     *--------------------------------------------------------------------------
9713:     * CmdgFigCamClick - Captura imagem via webcam (SigImage form)
9714:     * Legado: cmdgFigCam.Click - DO form SigImage TO lcFigura e armazena
9715:     *--------------------------------------------------------------------------

*-- Linhas 9734 a 9752:
9734:                 ENDIF
9735:                 IF loc_lResultado AND !EMPTY(loc_cFigura) AND FILE(loc_cFigura)
9736:                     IF TYPE("cursor_4c_GradFase.FigProcs") # "U"
9737:                         SELECT cursor_4c_GradFase
9738:                         REPLACE FigProcs WITH FILETOSTR(loc_cFigura)
9739:                     ENDIF
9740:                     THIS.GradFaseAfterRowColChange(0)
9741:                 ENDIF
9742:             ENDIF
9743:         CATCH TO loc_oErro
9744:             MsgErro(loc_oErro.Message, "Erro ao capturar imagem via webcam")
9745:         ENDTRY
9746:     ENDPROC
9747: 
9748:     *--------------------------------------------------------------------------
9749:     * ImgFigJpgClick - Abre imagem da fase em zoom (SigOpZom form)
9750:     * Legado: ImgFigJpg.Click - StrToFile e DO form SigOpZom
9751:     *--------------------------------------------------------------------------
9752:     PROCEDURE ImgFigJpgClick()

*-- Linhas 9771 a 9847:
9771: 
9772:     *--------------------------------------------------------------------------
9773:     * BtnInsereMtxClick - Insere nova linha de matriz em cursor_4c_SigPrMtz
9774:     * Legado: btnInsereMtx.Click - Insert Into crSigPrMtz se vazio
9775:     *--------------------------------------------------------------------------
9776:     PROCEDURE BtnInsereMtxClick()
9777:         LOCAL loc_oPg, loc_lResultado
9778:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9779:             RETURN
9780:         ENDIF
9781:         loc_lResultado = .T.
9782:         TRY
9783:             IF !USED("cursor_4c_SigPrMtz")
9784:                 loc_lResultado = .F.
9785:             ENDIF
9786:             IF loc_lResultado
9787:                 *-- Verificar se ja existe linha vazia (evitar duplicatas)
9788:                 GO TOP IN cursor_4c_SigPrMtz
9789:                 LOCATE FOR EMPTY(ALLTRIM(NVL(cursor_4c_SigPrMtz.CMats, "")))
9790:                 IF !EOF("cursor_4c_SigPrMtz")
9791:                     *-- Ja existe linha vazia - apenas focar
9792:                     loc_lResultado = .F.
9793:                 ENDIF
9794:             ENDIF
9795:             IF loc_lResultado
9796:                 INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9797:                 GO BOTTOM IN cursor_4c_SigPrMtz
9798:             ENDIF
9799:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9800:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9801:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9802:                     loc_oPg.grd_4c_Matrizes.Refresh()
9803:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9804:                 ENDIF
9805:             ENDIF
9806:         CATCH TO loc_oErro
9807:             MsgErro(loc_oErro.Message, "Erro ao inserir matriz")
9808:         ENDTRY
9809:     ENDPROC
9810: 
9811:     *--------------------------------------------------------------------------
9812:     * BtnExcluiMtzClick - Exclui linha corrente de cursor_4c_SigPrMtz
9813:     * Legado: btnExcluiMtz.Click - DELETE e reinsere placeholder se vazio
9814:     *--------------------------------------------------------------------------
9815:     PROCEDURE BtnExcluiMtzClick()
9816:         LOCAL loc_oPg, loc_lResultado
9817:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9818:             RETURN
9819:         ENDIF
9820:         loc_lResultado = .T.
9821:         TRY
9822:             IF !USED("cursor_4c_SigPrMtz") OR EOF("cursor_4c_SigPrMtz")
9823:                 loc_lResultado = .F.
9824:             ENDIF
9825:             IF loc_lResultado
9826:                 SELECT cursor_4c_SigPrMtz
9827:                 DELETE
9828:                 *-- Se cursor ficou vazio, reinsere linha placeholder
9829:                 GO TOP IN cursor_4c_SigPrMtz
9830:                 LOCATE FOR !DELETED()
9831:                 IF EOF("cursor_4c_SigPrMtz")
9832:                     INSERT INTO cursor_4c_SigPrMtz (CMats, DLocs, Qtds) VALUES ("", "", 0)
9833:                 ENDIF
9834:             ENDIF
9835:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
9836:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
9837:                 IF VARTYPE(loc_oPg.grd_4c_Matrizes) = "O"
9838:                     loc_oPg.grd_4c_Matrizes.Refresh()
9839:                     loc_oPg.grd_4c_Matrizes.SetFocus()
9840:                 ENDIF
9841:             ENDIF
9842:         CATCH TO loc_oErro
9843:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
9844:         ENDTRY
9845:     ENDPROC
9846: 
9847:     *--------------------------------------------------------------------------

*-- Linhas 10018 a 10036:
10018: 
10019:     *--------------------------------------------------------------------------
10020:     * TxtConquilhaLostFocus - Valida conquilha (SigCdCnq) ao sair do campo
10021:     * Legado: getConquilha.Valid = SQL SELECT conquilhas FROM SigCdCnq + fwBuscaInt
10022:     *--------------------------------------------------------------------------
10023:     PROCEDURE TxtConquilhaLostFocus()
10024:         LOCAL loc_oPg, loc_oBusca, loc_cCod, loc_lResultado, loc_cSQL, loc_nRet
10025:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
10026:             RETURN
10027:         ENDIF
10028:         *-- Guard: evita reabrir lookup se valor nao mudou
10029:         IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
10030:             LOCAL loc_cGuardaCnq
10031:             loc_cGuardaCnq = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.txt_4c_Conquilha.Value, ""))
10032:             IF loc_cGuardaCnq = THIS.this_cUltimoTxtConquilhaLostFocusValidado
10033:                 RETURN
10034:             ENDIF
10035:             THIS.this_cUltimoTxtConquilhaLostFocusValidado = loc_cGuardaCnq
10036:         ENDIF

*-- Linhas 10049 a 10070:
10049:             ENDIF
10050:             IF loc_lResultado
10051:                 *-- Buscar conquilhas disponiveis em SigCdCnq
10052:                 loc_cSQL = "SELECT DISTINCT conquilhas FROM SigCdCnq"
10053:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaCnq")
10054:                 IF loc_nRet > 0 AND USED("cursor_4c_ListaCnq")
10055:                     SELECT cursor_4c_ListaCnq
10056:                     LOCATE FOR ALLTRIM(NVL(conquilhas, "")) = PADR(loc_cCod, 10)
10057:                     IF !EOF("cursor_4c_ListaCnq")
10058:                         *-- Encontrado direto
10059:                         loc_oPg.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_ListaCnq.conquilhas)
10060:                         THIS.this_oBusinessObject.this_cConquilhas = loc_oPg.txt_4c_Conquilha.Value
10061:                     ELSE
10062:                         *-- Nao encontrado - abrir lookup
10063:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10064:                             "SigCdCnq", "cursor_4c_BuscaCnq", "conquilhas", loc_cCod, ;
10065:                             "Buscar Conquilha")
10066:                         IF VARTYPE(loc_oBusca) = "O"
10067:                             IF !loc_oBusca.this_lAchouRegistro
10068:                                 loc_oBusca.mAddColuna("conquilhas", "", "Conquilha")
10069:                                 loc_oBusca.Show()
10070:                             ENDIF

*-- Linhas 10105 a 10123:
10105:         *----------------------------------------------------------------------
10106:         IF !USED("cursor_4c_Cmv")
10107:             SET NULL ON
10108:             CREATE CURSOR cursor_4c_Cmv (;
10109:                 Datas   D, ;
10110:                 ValCuss N(12,3), ;
10111:                 Moedas  C(3))
10112:             SET NULL OFF
10113:         ENDIF
10114: 
10115:         *----------------------------------------------------------------------
10116:         *-- Labels (Say16/17 = Grupo CC / Conta CC no topo da pagina)
10117:         *----------------------------------------------------------------------
10118:         loc_oPg.AddObject("lbl_4c_LblGruCus", "Label")
10119:         WITH loc_oPg.lbl_4c_LblGruCus
10120:             .Caption   = "Grupo C.C. :"
10121:             .Top       = 165
10122:             .Left      = 138
10123:             .Width     = 63

*-- Linhas 10904 a 10947:
10904:             .FontName    = "Tahoma"
10905:             .FontSize    = 8
10906:             .RowHeight   = 17
10907:             .DeleteMark  = .F.
10908:             .RecordMark  = .T.
10909:             .ReadOnly    = .T.
10910:             .ScrollBars  = 3
10911:             .Themes      = .F.
10912:             .Visible     = .T.
10913:         ENDWITH
10914:         loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
10915:         WITH loc_oPg.grd_4c_Cmv
10916:             .Column1.ControlSource    = "cursor_4c_Cmv.Datas"
10917:             .Column1.Header1.Caption  = "Per" + CHR(237) + "odo"
10918:             .Column1.Header1.FontName = "Tahoma"
10919:             .Column1.Header1.FontSize = 8
10920:             .Column1.Width            = 59
10921:             .Column1.Movable          = .F.
10922:             .Column1.Resizable        = .F.
10923:             .Column1.ReadOnly         = .T.
10924:             .Column2.ControlSource    = "cursor_4c_Cmv.ValCuss"
10925:             .Column2.Header1.Caption  = "Valor Custo GR"
10926:             .Column2.Header1.FontName = "Tahoma"
10927:             .Column2.Header1.FontSize = 8
10928:             .Column2.Width            = 100
10929:             .Column2.Movable          = .F.
10930:             .Column2.Resizable        = .F.
10931:             .Column2.ReadOnly         = .T.
10932:             .Column3.ControlSource    = "cursor_4c_Cmv.Moedas"
10933:             .Column3.Header1.Caption  = "Moe"
10934:             .Column3.Header1.FontName = "Tahoma"
10935:             .Column3.Header1.FontSize = 8
10936:             .Column3.Width            = 31
10937:             .Column3.Movable          = .F.
10938:             .Column3.Resizable        = .F.
10939:             .Column3.ReadOnly         = .T.
10940:         ENDWITH
10941:     ENDPROC
10942: 
10943:     *--------------------------------------------------------------------------
10944:     * PreencherCamposFiscais - Popula controles de pgDadosFiscais a partir do BO
10945:     * Chamado por BOParaForm apos carregar dados de SigCdPro
10946:     *--------------------------------------------------------------------------
10947:     PROTECTED PROCEDURE PreencherCamposFiscais()

*-- Linhas 11569 a 11591:
11569:             ENDIF
11570:             IF loc_lResultado
11571:                 *-- Carregar lista de metais (Tipos='M') para lookup
11572:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos = 'M'"
11573:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlM")
11574:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlM")
11575:                     *-- Verificar se codigo existe diretamente
11576:                     SELECT cursor_4c_BuscaMtlM
11577:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11578:                     IF !EOF("cursor_4c_BuscaMtlM")
11579:                         IF VARTYPE(loc_oPg.txt_4c_DesMetal) = "O"
11580:                             loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlM.Descs, ""))
11581:                         ENDIF
11582:                         THIS.this_oBusinessObject.this_cMetals = loc_cCod
11583:                     ELSE
11584:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11585:                             "SigCdMtl", "cursor_4c_BuscaMtlSel", "Codigos", loc_cCod, ;
11586:                             "Buscar Metal")
11587:                         IF VARTYPE(loc_oBusca) = "O"
11588:                             IF !loc_oBusca.this_lAchouRegistro
11589:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11590:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11591:                                 loc_oBusca.Show()

*-- Linhas 11651 a 11672:
11651:                 ENDIF
11652:             ENDIF
11653:             IF loc_lResultado
11654:                 loc_cSQL = "SELECT Codigos, Descs FROM SigCdMtl WHERE Tipos <> 'M'"
11655:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMtlT")
11656:                 IF loc_nRet > 0 AND USED("cursor_4c_BuscaMtlT")
11657:                     SELECT cursor_4c_BuscaMtlT
11658:                     LOCATE FOR ALLTRIM(NVL(Codigos, "")) = loc_cCod
11659:                     IF !EOF("cursor_4c_BuscaMtlT")
11660:                         IF VARTYPE(loc_oPg.txt_4c_DesTeor) = "O"
11661:                             loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(NVL(cursor_4c_BuscaMtlT.Descs, ""))
11662:                         ENDIF
11663:                         THIS.this_oBusinessObject.this_cTeors = loc_cCod
11664:                     ELSE
11665:                         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
11666:                             "SigCdMtl", "cursor_4c_BuscaTeorSel", "Codigos", loc_cCod, ;
11667:                             "Buscar Teor")
11668:                         IF VARTYPE(loc_oBusca) = "O"
11669:                             IF !loc_oBusca.this_lAchouRegistro
11670:                                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "d.")
11671:                                 loc_oBusca.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
11672:                                 loc_oBusca.Show()

*-- Linhas 11801 a 11834:
11801:         *----------------------------------------------------------------------
11802:         IF !USED("cursor_4c_SigPrTar")
11803:             SET NULL ON
11804:             CREATE CURSOR cursor_4c_SigPrTar (;
11805:                 DtInis  D NULL, ;
11806:                 DtFims  D NULL, ;
11807:                 Usuars  C(10), ;
11808:                 Tarefas C(10), ;
11809:                 ObsTars M)
11810:             SET NULL OFF
11811:         ENDIF
11812: 
11813:         *----------------------------------------------------------------------
11814:         *-- Cursor placeholder cursor_4c_SigPrArq (SigPrArq - Arquivos Designer)
11815:         *-- Campos: Arquivos
11816:         *----------------------------------------------------------------------
11817:         IF !USED("cursor_4c_SigPrArq")
11818:             SET NULL ON
11819:             CREATE CURSOR cursor_4c_SigPrArq (;
11820:                 Arquivos C(200))
11821:             SET NULL OFF
11822:         ENDIF
11823: 
11824:         *----------------------------------------------------------------------
11825:         *-- Shape1: fundo da area de imagem (T:415 L:584 W:407 H:202)
11826:         *----------------------------------------------------------------------
11827:         loc_oPg.AddObject("shp_4c_ArqFundo", "Shape")
11828:         WITH loc_oPg.shp_4c_ArqFundo
11829:             .Top         = 415
11830:             .Left        = 584
11831:             .Width       = 407
11832:             .Height      = 202
11833:             .BackColor   = RGB(230, 230, 230)
11834:             .BorderColor = RGB(180, 180, 180)

*-- Linhas 11867 a 11944:
11867:             .ColumnCount = 4
11868:             .FontName    = "Tahoma"
11869:             .FontSize    = 8
11870:             .DeleteMark  = .F.
11871:             .ScrollBars  = 2
11872:             .Themes      = .F.
11873:             .Visible     = .T.
11874:             .RecordMark   = .F.
11875:         ENDWITH
11876:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_SigPrTar"
11877:         WITH loc_oPg.grd_4c_Designer
11878:             .Column1.ControlSource     = "cursor_4c_SigPrTar.DtInis"
11879:             .Column1.Header1.Caption   = "Data de In" + CHR(237) + "cio"
11880:             .Column1.Header1.FontName  = "Tahoma"
11881:             .Column1.Header1.FontSize  = 8
11882:             .Column1.Header1.Alignment = 2
11883:             .Column1.Width             = 140
11884:             .Column1.Movable           = .F.
11885:             .Column1.Resizable         = .F.
11886:             .Column1.ReadOnly          = .T.
11887:             .Column1.Alignment         = 2
11888:             .Column2.ControlSource     = "cursor_4c_SigPrTar.DtFims"
11889:             .Column2.Header1.Caption   = "Data de Conclus" + CHR(227) + "o"
11890:             .Column2.Header1.FontName  = "Tahoma"
11891:             .Column2.Header1.FontSize  = 8
11892:             .Column2.Header1.Alignment = 2
11893:             .Column2.Width             = 140
11894:             .Column2.Movable           = .F.
11895:             .Column2.Resizable         = .F.
11896:             .Column2.ReadOnly          = .T.
11897:             .Column2.Alignment         = 2
11898:             .Column3.ControlSource     = "cursor_4c_SigPrTar.Usuars"
11899:             .Column3.Header1.Caption   = "Usu" + CHR(225) + "rio"
11900:             .Column3.Header1.FontName  = "Tahoma"
11901:             .Column3.Header1.FontSize  = 8
11902:             .Column3.Header1.Alignment = 2
11903:             .Column3.Width             = 90
11904:             .Column3.Movable           = .F.
11905:             .Column3.Resizable         = .F.
11906:             .Column3.ReadOnly          = .T.
11907:             .Column4.ControlSource     = "cursor_4c_SigPrTar.Tarefas"
11908:             .Column4.Header1.Caption   = "Tarefa"
11909:             .Column4.Header1.FontName  = "Tahoma"
11910:             .Column4.Header1.FontSize  = 8
11911:             .Column4.Header1.Alignment = 2
11912:             .Column4.Width             = 90
11913:             .Column4.Movable           = .F.
11914:             .Column4.Resizable         = .F.
11915:             .Column4.ReadOnly          = .F.
11916:         ENDWITH
11917:         BINDEVENT(loc_oPg.grd_4c_Designer, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")
11918: 
11919:         *----------------------------------------------------------------------
11920:         *-- EditBox getObsTarefas: Obs da Tarefa (T:160 L:584 W:407 H:238)
11921:         *-- ControlSource ? cursor_4c_SigPrTar.ObsTars (sincronizado automaticamente)
11922:         *----------------------------------------------------------------------
11923:         loc_oPg.AddObject("obj_4c_ObsTarefas", "EditBox")
11924:         WITH loc_oPg.obj_4c_ObsTarefas
11925:             .Top              = 160
11926:             .Left             = 584
11927:             .Width            = 407
11928:             .Height           = 238
11929:             .ControlSource    = "cursor_4c_SigPrTar.ObsTars"
11930:             .FontName         = "Tahoma"
11931:             .FontSize         = 8
11932:             .SpecialEffect    = 1
11933:             .ForeColor        = RGB(36, 84, 155)
11934:             .Enabled          = .T.
11935:             .Visible          = .T.
11936:         ENDWITH
11937: 
11938:         *----------------------------------------------------------------------
11939:         *-- btnIniTarefa: Iniciar Tarefa (T:168 L:509 W:42 H:42)
11940:         *----------------------------------------------------------------------
11941:         loc_oPg.AddObject("cmd_4c_IniTarefa", "CommandButton")
11942:         WITH loc_oPg.cmd_4c_IniTarefa
11943:             .Top             = 168
11944:             .Left            = 509

*-- Linhas 11987 a 12014:
11987:             .ColumnCount = 1
11988:             .FontName    = "Tahoma"
11989:             .FontSize    = 8
11990:             .DeleteMark  = .F.
11991:             .ScrollBars  = 2
11992:             .ReadOnly    = .T.
11993:             .Themes      = .F.
11994:             .Visible     = .T.
11995:             .RecordMark   = .F.
11996:         ENDWITH
11997:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_SigPrArq"
11998:         WITH loc_oPg.grd_4c_Arquivos
11999:             .Column1.ControlSource     = "cursor_4c_SigPrArq.Arquivos"
12000:             .Column1.Header1.Caption   = "Arquivos Para Designer"
12001:             .Column1.Header1.FontName  = "Tahoma"
12002:             .Column1.Header1.FontSize  = 8
12003:             .Column1.Header1.Alignment = 2
12004:             .Column1.Width             = 464
12005:             .Column1.Movable           = .F.
12006:             .Column1.Resizable         = .F.
12007:             .Column1.ReadOnly          = .T.
12008:         ENDWITH
12009:         BINDEVENT(loc_oPg.grd_4c_Arquivos, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
12010: 
12011:         *----------------------------------------------------------------------
12012:         *-- btnInsArqs: Inserir Arquivo (T:416 L:509 W:42 H:42)
12013:         *----------------------------------------------------------------------
12014:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")

*-- Linhas 12186 a 12225:
12186:             ENDIF
12187:             IF loc_lResultado
12188:                 *-- Verificar se existe tarefa nao encerrada para este usuario
12189:                 SELECT cursor_4c_SigPrTar
12190:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12191:                     AND EMPTY(NVL(DtFims, {}))
12192:                 IF !EOF("cursor_4c_SigPrTar")
12193:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12194:                         CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12195:                     loc_lResultado = .F.
12196:                 ENDIF
12197:             ENDIF
12198:             IF loc_lResultado
12199:                 *-- Verificar se existe tarefa sem codigo informado
12200:                 SELECT cursor_4c_SigPrTar
12201:                 LOCATE FOR ALLTRIM(NVL(Usuars, "")) = ALLTRIM(gc_4c_UsuarioLogado) ;
12202:                     AND EMPTY(Tarefas)
12203:                 IF !EOF("cursor_4c_SigPrTar")
12204:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", "Aten" + CHR(231) + CHR(227) + "o")
12205:                     loc_lResultado = .F.
12206:                 ENDIF
12207:             ENDIF
12208:             IF loc_lResultado
12209:                 *-- Inserir nova tarefa com data/hora de inicio
12210:                 SELECT cursor_4c_SigPrTar
12211:                 APPEND BLANK
12212:                 REPLACE cursor_4c_SigPrTar.DtInis  WITH DATE()
12213:                 REPLACE cursor_4c_SigPrTar.Usuars  WITH PADR(ALLTRIM(gc_4c_UsuarioLogado), 10)
12214:                 REPLACE cursor_4c_SigPrTar.Tarefas WITH ""
12215:                 REPLACE cursor_4c_SigPrTar.ObsTars WITH ""
12216:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12217:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12218:                 ENDIF
12219:             ENDIF
12220:         CATCH TO loc_oErro
12221:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12222:         ENDTRY
12223:     ENDPROC
12224: 
12225:     *--------------------------------------------------------------------------

*-- Linhas 12249 a 12294:
12249:                 ENDIF
12250:             ENDIF
12251:             IF loc_lResultado
12252:                 SELECT cursor_4c_SigPrTar
12253:                 REPLACE cursor_4c_SigPrTar.DtFims WITH DATE()
12254:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12255:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer.Refresh()
12256:                 ENDIF
12257:             ENDIF
12258:         CATCH TO loc_oErro
12259:             MsgErro(loc_oErro.Message, "Erro ao encerrar tarefa")
12260:         ENDTRY
12261:     ENDPROC
12262: 
12263:     *--------------------------------------------------------------------------
12264:     * BtnInsArqsClick - Seleciona e insere arquivo na lista de arquivos designer
12265:     * Legado: btnInsArqs.Click - GETFILE + INSERT INTO crSigPrArq
12266:     *--------------------------------------------------------------------------
12267:     PROCEDURE BtnInsArqsClick()
12268:         LOCAL loc_cArq, loc_lResultado
12269:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12270:             RETURN
12271:         ENDIF
12272:         loc_lResultado = .T.
12273:         TRY
12274:             loc_cArq = GETFILE("*.*", "Selecione o Arquivo", "Selecione o Arquivo", 0)
12275:             IF EMPTY(loc_cArq)
12276:                 loc_lResultado = .F.
12277:             ENDIF
12278:             IF loc_lResultado AND USED("cursor_4c_SigPrArq")
12279:                 SELECT cursor_4c_SigPrArq
12280:                 APPEND BLANK
12281:                 REPLACE cursor_4c_SigPrArq.Arquivos WITH UPPER(ALLTRIM(loc_cArq))
12282:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12283:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12284:                 ENDIF
12285:             ENDIF
12286:         CATCH TO loc_oErro
12287:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12288:         ENDTRY
12289:     ENDPROC
12290: 
12291:     *--------------------------------------------------------------------------
12292:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao do SO
12293:     * Legado: btnOpnArqs.Click - Shell.Application.Open(lcArq)
12294:     *--------------------------------------------------------------------------

*-- Linhas 12324 a 12361:
12324: 
12325:     *--------------------------------------------------------------------------
12326:     * BtnExcArqsClick - Exclui arquivo da lista de arquivos designer
12327:     * Legado: btnExcArqs.Click - Delete In crSigPrArq + Refresh
12328:     *--------------------------------------------------------------------------
12329:     PROCEDURE BtnExcArqsClick()
12330:         LOCAL loc_lResultado
12331:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
12332:             RETURN
12333:         ENDIF
12334:         loc_lResultado = .T.
12335:         TRY
12336:             IF !USED("cursor_4c_SigPrArq") OR EOF("cursor_4c_SigPrArq")
12337:                 loc_lResultado = .F.
12338:             ENDIF
12339:             IF loc_lResultado
12340:                 IF EMPTY(ALLTRIM(NVL(cursor_4c_SigPrArq.Arquivos, "")))
12341:                     loc_lResultado = .F.
12342:                 ENDIF
12343:             ENDIF
12344:             IF loc_lResultado
12345:                 SELECT cursor_4c_SigPrArq
12346:                 DELETE
12347:                 IF !EOF("cursor_4c_SigPrArq")
12348:                     SKIP
12349:                     SKIP -1
12350:                 ENDIF
12351:                 IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
12352:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos.Refresh()
12353:                 ENDIF
12354:                 *-- Limpar imagem ao excluir arquivo
12355:                 LOCAL loc_oPg
12356:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12357:                 IF VARTYPE(loc_oPg.img_4c_ArqJpg) = "O"
12358:                     CLEAR RESOURCES
12359:                     loc_oPg.img_4c_ArqJpg.Picture = ""
12360:                     loc_oPg.img_4c_ArqJpg.Visible = .F.
12361:                 ENDIF

