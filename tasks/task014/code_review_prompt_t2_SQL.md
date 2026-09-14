# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-COLUNA] Coluna 'matsubs' referenciada como 'C.matsubs' NAO existe na tabela SIGPRCPO. (voce quis dizer 'mats'?) Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal
- [SQL-COLUNA] Coluna 'codtams' referenciada como 'C.codtams' NAO existe na tabela SIGPRCPO. Colunas validas: cats, cgrus, cpros, datatrans, dcompos, dscgrp, etiqs, grupos, mats, moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, ordcompos, cidchaves, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, obsofs, PedraPrincipal

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (13541 linhas total):

*-- Linhas 508 a 526:
508:             .Width             = 940
509:             .Height            = 395
510:             .ReadOnly          = .T.
511:             .DeleteMark        = .F.
512:             .RecordMark        = .F.
513:             .ScrollBars        = 3
514:             .GridLines         = 3
515:             .ColumnCount       = 7
516:             .AllowHeaderSizing = .T.
517:             .Visible           = .T.
518:         ENDWITH
519:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdLista_DblClick")
520: 
521:         THIS.TornarControlesVisiveis(loc_oPagina)
522:     ENDPROC
523: 
524:     *--------------------------------------------------------------------------
525:     * ConfigurarPaginaDados - Configura Page2 (Dados do Produto)
526:     * Legado: Optiongroup1 top=5->34, pgframeDados top=-54->-54

*-- Linhas 2766 a 2784:
2766:             .Width       = 229
2767:             .Height      = 107
2768:             .ReadOnly    = .T.
2769:             .DeleteMark  = .F.
2770:             .RecordMark  = .F.
2771:             .ScrollBars  = 3
2772:             .GridLines   = 3
2773:             .ColumnCount = 3
2774:             .FontName    = "Verdana"
2775:             .FontSize    = 8
2776:             .Visible     = .T.
2777:         ENDWITH
2778:         WITH loc_oPg.grd_4c_GrupoCompo
2779:             .Column1.Header1.Caption = "Grupo"
2780:             .Column1.Width = 70
2781:             .Column2.Header1.Caption = "Total"
2782:             .Column2.Width = 95
2783:             .Column3.Header1.Caption = "Moe"
2784:             .Column3.Width = 50

*-- Linhas 2793 a 2811:
2793:             .Width       = 943
2794:             .Height      = 147
2795:             .ReadOnly    = .T.
2796:             .DeleteMark  = .F.
2797:             .RecordMark  = .F.
2798:             .ScrollBars  = 3
2799:             .GridLines   = 3
2800:             .ColumnCount = 14
2801:             .FontName    = "Verdana"
2802:             .FontSize    = 8
2803:             .Visible     = .T.
2804:         ENDWITH
2805:         WITH loc_oPg.grd_4c_Compo
2806:             .Column1.Header1.Caption  = "Material"
2807:             .Column1.Width  = 90
2808:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2809:             .Column2.Width  = 190
2810:             .Column3.Header1.Caption  = "Un"
2811:             .Column3.Width  = 35

*-- Linhas 2842 a 2860:
2842:             .Width       = 943
2843:             .Height      = 83
2844:             .ReadOnly    = .T.
2845:             .DeleteMark  = .F.
2846:             .RecordMark  = .F.
2847:             .ScrollBars  = 3
2848:             .GridLines   = 3
2849:             .ColumnCount = 15
2850:             .FontName    = "Verdana"
2851:             .FontSize    = 8
2852:             .Visible     = .T.
2853:         ENDWITH
2854:         WITH loc_oPg.grd_4c_SubCompo
2855:             .Column1.Header1.Caption  = "Material"
2856:             .Column1.Width  = 80
2857:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2858:             .Column2.Width  = 160
2859:             .Column3.Header1.Caption  = "Un"
2860:             .Column3.Width  = 35

*-- Linhas 4052 a 4124:
4052:         *-- Criar cursors placeholder para os grids (evitar erro de RecordSource vazio)
4053:         IF !USED("cursor_4c_Compo")
4054:             SET NULL ON
4055:             CREATE CURSOR cursor_4c_Compo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), compos C(10))
4056:             SET NULL OFF
4057:         ENDIF
4058:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
4059:         WITH loc_oPg.grd_4c_Compo
4060:             .Column1.ControlSource  = "cursor_4c_Compo.mats"
4061:             .Column2.ControlSource  = "cursor_4c_Compo.dcompos"
4062:             .Column3.ControlSource  = "cursor_4c_Compo.unicompos"
4063:             .Column4.ControlSource  = "cursor_4c_Compo.pcompos"
4064:             .Column5.ControlSource  = "cursor_4c_Compo.qtds"
4065:             .Column6.ControlSource  = "cursor_4c_Compo.totas"
4066:             .Column7.ControlSource  = "cursor_4c_Compo.moeds"
4067:             .Column8.ControlSource  = "cursor_4c_Compo.obscompos"
4068:             .Column9.ControlSource  = "cursor_4c_Compo.etiqs"
4069:             .Column10.ControlSource = "cursor_4c_Compo.qtscons"
4070:             .Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
4071:             .Column12.ControlSource = "cursor_4c_Compo.cunips"
4072:             .Column13.ControlSource = "cursor_4c_Compo.ordems"
4073:             .Column14.ControlSource = "cursor_4c_Compo.compos"
4074:         ENDWITH
4075: 
4076:         IF !USED("cursor_4c_SubCompo")
4077:             SET NULL ON
4078:             CREATE CURSOR cursor_4c_SubCompo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), matsubs C(14), codtams C(4))
4079:             SET NULL OFF
4080:         ENDIF
4081:         loc_oPg.grd_4c_SubCompo.RecordSource = "cursor_4c_SubCompo"
4082:         WITH loc_oPg.grd_4c_SubCompo
4083:             .Column1.ControlSource  = "cursor_4c_SubCompo.mats"
4084:             .Column2.ControlSource  = "cursor_4c_SubCompo.dcompos"
4085:             .Column3.ControlSource  = "cursor_4c_SubCompo.unicompos"
4086:             .Column4.ControlSource  = "cursor_4c_SubCompo.pcompos"
4087:             .Column5.ControlSource  = "cursor_4c_SubCompo.qtds"
4088:             .Column6.ControlSource  = "cursor_4c_SubCompo.totas"
4089:             .Column7.ControlSource  = "cursor_4c_SubCompo.moeds"
4090:             .Column8.ControlSource  = "cursor_4c_SubCompo.obscompos"
4091:             .Column9.ControlSource  = "cursor_4c_SubCompo.etiqs"
4092:             .Column10.ControlSource = "cursor_4c_SubCompo.qtscons"
4093:             .Column11.ControlSource = "cursor_4c_SubCompo.qtdcvs"
4094:             .Column12.ControlSource = "cursor_4c_SubCompo.cunips"
4095:             .Column13.ControlSource = "cursor_4c_SubCompo.ordems"
4096:             .Column14.ControlSource = "cursor_4c_SubCompo.matsubs"
4097:             .Column15.ControlSource = "cursor_4c_SubCompo.codtams"
4098:         ENDWITH
4099: 
4100:         IF !USED("cursor_4c_GrupoCompo")
4101:             SET NULL ON
4102:             CREATE CURSOR cursor_4c_GrupoCompo (grupos C(10), totas N(11,3), moeds C(3))
4103:             SET NULL OFF
4104:         ENDIF
4105:         loc_oPg.grd_4c_GrupoCompo.RecordSource = "cursor_4c_GrupoCompo"
4106:         WITH loc_oPg.grd_4c_GrupoCompo
4107:             .Column1.ControlSource = "cursor_4c_GrupoCompo.grupos"
4108:             .Column2.ControlSource = "cursor_4c_GrupoCompo.totas"
4109:             .Column3.ControlSource = "cursor_4c_GrupoCompo.moeds"
4110:         ENDWITH
4111:     ENDPROC
4112: 
4113:     *--------------------------------------------------------------------------
4114:     * ConfigurarTabCustos - Aba 3: Custo da composicao (pgCusto)
4115:     * Legado: pgframeDados.pgCusto (grdCompo 12-col, cmbTipos, cmdgCompo)
4116:     * FASE 9: implementacao completa com BINDEVENTs e botoes
4117:     *--------------------------------------------------------------------------
4118:     PROTECTED PROCEDURE ConfigurarTabCustos()
4119:         LOCAL loc_oPg
4120:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
4121: 
4122:         *-- Label "Tipo :" (top=159, left=112)
4123:         loc_oPg.AddObject("lbl_4c_TipoCusto", "Label")
4124:         WITH loc_oPg.lbl_4c_TipoCusto

*-- Linhas 4163 a 4181:
4163:             .Width       = 813
4164:             .Height      = 230
4165:             .ReadOnly    = .F.
4166:             .DeleteMark  = .F.
4167:             .RecordMark  = .F.
4168:             .ScrollBars  = 3
4169:             .GridLines   = 3
4170:             .ColumnCount = 12
4171:             .FontName    = "Verdana"
4172:             .FontSize    = 8
4173:             .Visible     = .T.
4174:         ENDWITH
4175:         WITH loc_oPg.grd_4c_CompoCusto
4176:             .Column1.Header1.Caption  = "Item"
4177:             .Column1.Width  = 80
4178:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4179:             .Column2.Width  = 180
4180:             .Column3.Header1.Caption  = "Un"
4181:             .Column3.Width  = 35

*-- Linhas 4338 a 4406:
4338:             .Width       = 195
4339:             .Height      = 141
4340:             .ReadOnly    = .T.
4341:             .DeleteMark  = .F.
4342:             .RecordMark  = .F.
4343:             .ScrollBars  = 3
4344:             .GridLines   = 3
4345:             .ColumnCount = 3
4346:             .FontName    = "Verdana"
4347:             .FontSize    = 8
4348:             .Visible     = .T.
4349:         ENDWITH
4350:         WITH loc_oPg.grd_4c_GrupoCompo2
4351:             .Column1.Header1.Caption = "Grp"
4352:             .Column1.Width = 55
4353:             .Column2.Header1.Caption = "Total"
4354:             .Column2.Width = 100
4355:             .Column3.Header1.Caption = "Moe"
4356:             .Column3.Width = 35
4357:         ENDWITH
4358: 
4359:         *-- Cursor placeholder para grd_4c_CompoCusto
4360:         IF !USED("cursor_4c_CompoCusto")
4361:             SET NULL ON
4362:             CREATE CURSOR cursor_4c_CompoCusto (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3))
4363:             SET NULL OFF
4364:         ENDIF
4365:         loc_oPg.grd_4c_CompoCusto.RecordSource = "cursor_4c_CompoCusto"
4366:         WITH loc_oPg.grd_4c_CompoCusto
4367:             .Column1.ControlSource  = "cursor_4c_CompoCusto.mats"
4368:             .Column2.ControlSource  = "cursor_4c_CompoCusto.dcompos"
4369:             .Column3.ControlSource  = "cursor_4c_CompoCusto.unicompos"
4370:             .Column4.ControlSource  = "cursor_4c_CompoCusto.pcompos"
4371:             .Column5.ControlSource  = "cursor_4c_CompoCusto.qtds"
4372:             .Column6.ControlSource  = "cursor_4c_CompoCusto.totas"
4373:             .Column7.ControlSource  = "cursor_4c_CompoCusto.moeds"
4374:             .Column8.ControlSource  = "cursor_4c_CompoCusto.obscompos"
4375:             .Column9.ControlSource  = "cursor_4c_CompoCusto.etiqs"
4376:             .Column10.ControlSource = "cursor_4c_CompoCusto.qtscons"
4377:             .Column11.ControlSource = "cursor_4c_CompoCusto.qtdcvs"
4378:             .Column12.ControlSource = "cursor_4c_CompoCusto.cunips"
4379:         ENDWITH
4380: 
4381:         *-- Cursor placeholder para grd_4c_GrupoCompo2
4382:         IF !USED("cursor_4c_GrupoCompo2")
4383:             SET NULL ON
4384:             CREATE CURSOR cursor_4c_GrupoCompo2 (grupos C(10), totas N(11,3), moeds C(3))
4385:             SET NULL OFF
4386:         ENDIF
4387:         loc_oPg.grd_4c_GrupoCompo2.RecordSource = "cursor_4c_GrupoCompo2"
4388:         WITH loc_oPg.grd_4c_GrupoCompo2
4389:             .Column1.ControlSource = "cursor_4c_GrupoCompo2.grupos"
4390:             .Column2.ControlSource = "cursor_4c_GrupoCompo2.totas"
4391:             .Column3.ControlSource = "cursor_4c_GrupoCompo2.moeds"
4392:         ENDWITH
4393:     ENDPROC
4394: 
4395:     *--------------------------------------------------------------------------
4396:     * ConfigurarTabDadosFiscais - Aba 4: Dados fiscais (pgDadosFiscais)
4397:     * IMPLEMENTADO NA FASE 6
4398:     *--------------------------------------------------------------------------
4399:     PROTECTED PROCEDURE ConfigurarTabDadosFiscais()
4400:         LOCAL loc_oPg
4401:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4402: 
4403:         *-- Classificacao Fiscal (top=211, left=206, width=94)
4404:         loc_oPg.AddObject("lbl_4c_Clfiscal", "Label")
4405:         WITH loc_oPg.lbl_4c_Clfiscal
4406:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"

*-- Linhas 5026 a 5075:
5026: 
5027:         IF !USED("cursor_4c_Cmv")
5028:             SET NULL ON
5029:             CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
5030:             SET NULL OFF
5031:         ENDIF
5032: 
5033:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")
5034:         WITH loc_oPg.grd_4c_Cmv
5035:             .Top         = 338
5036:             .Left        = 754
5037:             .Width       = 223
5038:             .Height      = 141
5039:             .ReadOnly    = .T.
5040:             .DeleteMark  = .F.
5041:             .RecordMark  = .F.
5042:             .ScrollBars  = 3
5043:             .GridLines   = 3
5044:             .ColumnCount = 3
5045:             .FontName    = "Verdana"
5046:             .FontSize    = 8
5047:         ENDWITH
5048:         loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
5049:         WITH loc_oPg.grd_4c_Cmv
5050:             .Column1.Header1.Caption = "Per" + CHR(237) + "odo"
5051:             .Column1.Width           = 65
5052:             .Column1.ControlSource   = "cursor_4c_Cmv.periodos"
5053:             .Column1.ReadOnly        = .T.
5054:             .Column2.Header1.Caption = "Valor Custo GR"
5055:             .Column2.Width           = 105
5056:             .Column2.ControlSource   = "cursor_4c_Cmv.valcustos"
5057:             .Column2.ReadOnly        = .T.
5058:             .Column3.Header1.Caption = "Moe"
5059:             .Column3.Width           = 40
5060:             .Column3.ControlSource   = "cursor_4c_Cmv.moedas"
5061:             .Column3.ReadOnly        = .T.
5062:         ENDWITH
5063: 
5064:         *-- === BOTAO GERAR DESCRICAO FISCAL (btnDescFis: top=359, left=162) ======
5065: 
5066:         loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
5067:         WITH loc_oPg.cmd_4c_BtnDescFis
5068:             .Caption         = ""
5069:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
5070:             .PicturePosition = 5
5071:             .Top             = 359
5072:             .Left            = 162
5073:             .Width           = 40
5074:             .Height          = 40
5075:             .FontName        = "Tahoma"

*-- Linhas 5113 a 5131:
5113:             .Width       = 495
5114:             .Height      = 238
5115:             .ReadOnly    = .T.
5116:             .DeleteMark  = .F.
5117:             .RecordMark  = .F.
5118:             .ScrollBars  = 3
5119:             .GridLines   = 3
5120:             .ColumnCount = 4
5121:             .FontName    = "Verdana"
5122:             .FontSize    = 8
5123:             .Visible     = .T.
5124:         ENDWITH
5125:         WITH loc_oPg.grd_4c_Designer
5126:             .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
5127:             .Column1.Width = 110
5128:             .Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
5129:             .Column2.Width = 120
5130:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
5131:             .Column3.Width = 100

*-- Linhas 5197 a 5215:
5197:             .Width       = 495
5198:             .Height      = 202
5199:             .ReadOnly    = .T.
5200:             .DeleteMark  = .F.
5201:             .RecordMark  = .F.
5202:             .ScrollBars  = 3
5203:             .GridLines   = 3
5204:             .ColumnCount = 1
5205:             .FontName    = "Verdana"
5206:             .FontSize    = 8
5207:             .Visible     = .T.
5208:         ENDWITH
5209:         WITH loc_oPg.grd_4c_Arquivos
5210:             .Column1.Header1.Caption = "Arquivos Para Designer"
5211:             .Column1.Width = 492
5212:         ENDWITH
5213: 
5214:         *-- Botoes de arquivo (top=416, 458, 500, left=509)
5215:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")

*-- Linhas 5257 a 5293:
5257:         *-- Criar cursors placeholder
5258:         IF !USED("cursor_4c_Designer")
5259:             SET NULL ON
5260:             CREATE CURSOR cursor_4c_Designer (dtinis D, dtfims D, usuars C(10), tarefas C(20))
5261:             SET NULL OFF
5262:         ENDIF
5263:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_Designer"
5264:         WITH loc_oPg.grd_4c_Designer
5265:             .Column1.ControlSource = "cursor_4c_Designer.dtinis"
5266:             .Column2.ControlSource = "cursor_4c_Designer.dtfims"
5267:             .Column3.ControlSource = "cursor_4c_Designer.usuars"
5268:             .Column4.ControlSource = "cursor_4c_Designer.tarefas"
5269:         ENDWITH
5270: 
5271:         IF !USED("cursor_4c_Arquivos")
5272:             SET NULL ON
5273:             CREATE CURSOR cursor_4c_Arquivos (arquivos C(250))
5274:             SET NULL OFF
5275:         ENDIF
5276:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_Arquivos"
5277:         WITH loc_oPg.grd_4c_Arquivos
5278:             .Column1.ControlSource = "cursor_4c_Arquivos.arquivos"
5279:         ENDWITH
5280:     ENDPROC
5281: 
5282:     *--------------------------------------------------------------------------
5283:     * ConfigurarPgpgDesigner - Completa Aba 5 Designer
5284:     * Adiciona img_4c_ImgArqJpg, shp_4c_Shape1 e todos os BINDEVENTs
5285:     * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDesigner()
5286:     *--------------------------------------------------------------------------
5287:     PROTECTED PROCEDURE ConfigurarPgpgDesigner()
5288:         LOCAL loc_oPg
5289:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
5290: 
5291:         *-- Corrigir ReadOnly do grd_4c_Designer: .F. para Column4 ser editavel
5292:         *-- Colunas 1-3 usam When=.F. via BINDEVENT para somente leitura
5293:         loc_oPg.grd_4c_Designer.ReadOnly = .F.

*-- Linhas 5337 a 5436:
5337:         *-- Cursor de tarefas para lookup do Column4 (codigo + descricao)
5338:         IF !USED("cursor_4c_Tarefas")
5339:             SET NULL ON
5340:             CREATE CURSOR cursor_4c_Tarefas (CodCads C(20), DesCads C(50))
5341:             SET NULL OFF
5342:         ENDIF
5343:     ENDPROC
5344: 
5345:     *--------------------------------------------------------------------------
5346:     * ConfigurarTabConsulta - Aba 6: Consulta de componentes por fase (PgDadosConsP)
5347:     * Legado: PgDadosConsP com GrdCons (9 cols editaveis) e grDTEMP (2 cols)
5348:     * IMPLEMENTADO NA FASE 9
5349:     *--------------------------------------------------------------------------
5350:     PROTECTED PROCEDURE ConfigurarTabConsulta()
5351:         LOCAL loc_oPg
5352:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
5353: 
5354:         *-- Criar cursors placeholder ANTES dos grids (evitar erro de RecordSource vazio)
5355:         *-- cursor_4c_Consulta: SIGPRCPO - componentes com fase (SigCdPrf) e categoria (SigCdCat)
5356:         IF !USED("cursor_4c_Consulta")
5357:             SET NULL ON
5358:             CREATE CURSOR cursor_4c_Consulta (mats C(14) NULL, qtds N(8,3) NULL, unicompos C(3) NULL, grupos C(10) NULL, dcompos C(40) NULL, ordems N(2,0) NULL, qtscons N(8,3) NULL, cats C(6) NULL, dscgrp C(20) NULL)
5359:             SET NULL OFF
5360:         ENDIF
5361: 
5362:         *-- cursor_4c_Temp: agrupamento x tempo (grDTEMP)
5363:         IF !USED("cursor_4c_Temp")
5364:             SET NULL ON
5365:             CREATE CURSOR cursor_4c_Temp (grupos C(10) NULL, totas N(11,3) NULL)
5366:             SET NULL OFF
5367:         ENDIF
5368: 
5369:         *-- GrdCons - Grid de componentes consulta (top=155, left=6, width=987, height=362, 9 cols)
5370:         *-- Colunas editaveis (INSERIR/ALTERAR): 4-Fase, 5-Descricao, 7-Consumo, 8-Cat
5371:         *-- Colunas somente leitura: 1-Componente, 2-Qtde, 3-Uni, 6-Ord, 9-DescCat
5372:         loc_oPg.AddObject("grd_4c_Consulta", "Grid")
5373:         WITH loc_oPg.grd_4c_Consulta
5374:             .Top         = 155
5375:             .Left        = 6
5376:             .Width       = 987
5377:             .Height      = 362
5378:             .ReadOnly    = .F.
5379:             .DeleteMark  = .F.
5380:             .RecordMark  = .F.
5381:             .ScrollBars  = 3
5382:             .GridLines   = 3
5383:             .ColumnCount = 9
5384:             .FontName    = "Verdana"
5385:             .FontSize    = 8
5386:             .Visible     = .T.
5387:         ENDWITH
5388:         *-- RecordSource ANTES dos headers/ControlSources (evita reset de colunas)
5389:         loc_oPg.grd_4c_Consulta.RecordSource = "cursor_4c_Consulta"
5390:         WITH loc_oPg.grd_4c_Consulta
5391:             .Column1.Header1.Caption = "Componente"
5392:             .Column1.Width           = 110
5393:             .Column1.ControlSource   = "cursor_4c_Consulta.mats"
5394:             .Column1.ReadOnly        = .T.
5395:             .Column2.Header1.Caption = "Qtde."
5396:             .Column2.Width           = 65
5397:             .Column2.ControlSource   = "cursor_4c_Consulta.qtds"
5398:             .Column2.ReadOnly        = .T.
5399:             .Column3.Header1.Caption = "Uni"
5400:             .Column3.Width           = 40
5401:             .Column3.ControlSource   = "cursor_4c_Consulta.unicompos"
5402:             .Column3.ReadOnly        = .T.
5403:             .Column4.Header1.Caption = "Fase"
5404:             .Column4.Width           = 80
5405:             .Column4.ControlSource   = "cursor_4c_Consulta.grupos"
5406:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5407:             .Column5.Width           = 180
5408:             .Column5.ControlSource   = "cursor_4c_Consulta.dcompos"
5409:             .Column6.Header1.Caption = "Ord."
5410:             .Column6.Width           = 40
5411:             .Column6.ControlSource   = "cursor_4c_Consulta.ordems"
5412:             .Column6.ReadOnly        = .T.
5413:             .Column7.Header1.Caption = "Consumo"
5414:             .Column7.Width           = 75
5415:             .Column7.ControlSource   = "cursor_4c_Consulta.qtscons"
5416:             .Column8.Header1.Caption = "Cat."
5417:             .Column8.Width           = 55
5418:             .Column8.ControlSource   = "cursor_4c_Consulta.cats"
5419:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5420:             .Column9.Width           = 150
5421:             .Column9.ControlSource   = "cursor_4c_Consulta.dscgrp"
5422:             .Column9.ReadOnly        = .T.
5423:         ENDWITH
5424:         BINDEVENT(loc_oPg.grd_4c_Consulta, "AfterRowColChange", THIS, "ConsultaGrd_AfterRowColChange")
5425: 
5426:         *-- Say7/lbl_4c_QtdCpnt: "Qtde Componentes :" (top=523, left=25)
5427:         loc_oPg.AddObject("lbl_4c_QtdCpnt", "Label")
5428:         WITH loc_oPg.lbl_4c_QtdCpnt
5429:             .Caption   = "Qtde Componentes : "
5430:             .Top       = 523
5431:             .Left      = 25
5432:             .Width     = 115
5433:             .Height    = 15
5434:             .FontName  = "Tahoma"
5435:             .FontSize  = 8
5436:             .BackStyle = 0

*-- Linhas 5488 a 5546:
5488:             .Width       = 172
5489:             .Height      = 107
5490:             .ReadOnly    = .T.
5491:             .DeleteMark  = .F.
5492:             .RecordMark  = .F.
5493:             .ScrollBars  = 3
5494:             .GridLines   = 3
5495:             .ColumnCount = 2
5496:             .FontName    = "Verdana"
5497:             .FontSize    = 8
5498:             .Visible     = .T.
5499:         ENDWITH
5500:         *-- RecordSource ANTES dos headers/ControlSources
5501:         loc_oPg.grd_4c_Temp.RecordSource = "cursor_4c_Temp"
5502:         WITH loc_oPg.grd_4c_Temp
5503:             .Column1.Header1.Caption = "Agrupamento"
5504:             .Column1.Width           = 100
5505:             .Column1.ControlSource   = "cursor_4c_Temp.grupos"
5506:             .Column2.Header1.Caption = "Tempo %"
5507:             .Column2.Width           = 65
5508:             .Column2.ControlSource   = "cursor_4c_Temp.totas"
5509:         ENDWITH
5510:     ENDPROC
5511: 
5512:     *--------------------------------------------------------------------------
5513:     * ConfigurarTabFases - Aba 7: Fases de producao (PgDadosFaseP)
5514:     * IMPLEMENTADO NA FASE 7
5515:     *--------------------------------------------------------------------------
5516:     PROTECTED PROCEDURE ConfigurarTabFases()
5517:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oCtrl, loc_oLbl, loc_oChk
5518:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5519: 
5520:         *-- Cursor placeholder para GradFase (SigCdPrf)
5521:         *-- ordems N(2,0), grupos C(10), minutos N(9,1), uniprdts C(10), matprdts C(15)
5522:         IF !USED("cursor_4c_Fases")
5523:             SET NULL ON
5524:             CREATE CURSOR cursor_4c_Fases (ordems N(2,0) NULL, grupos C(10) NULL, minutos N(9,1) NULL, uniprdts C(10) NULL, matprdts C(15) NULL)
5525:             SET NULL OFF
5526:         ENDIF
5527: 
5528:         *-- Cursor placeholder para grdMatrizes (SigPrMtz + Locals de SigCdPro)
5529:         IF !USED("cursor_4c_Matrizes")
5530:             SET NULL ON
5531:             CREATE CURSOR cursor_4c_Matrizes (cidchaves C(20) NULL, cmats C(14) NULL, cpros C(14) NULL, qtds N(3,0) NULL, locals C(10) NULL)
5532:             SET NULL OFF
5533:         ENDIF
5534: 
5535:         *======================================================
5536:         *-- LABEL: Say13 - "Qtd. Min. Producao :"
5537:         *======================================================
5538:         loc_oPg.AddObject("lbl_4c_Qmin", "Label")
5539:         WITH loc_oPg.lbl_4c_Qmin
5540:             .Top      = 156
5541:             .Left     = 33
5542:             .Width    = 102
5543:             .Height   = 15
5544:             .Caption  = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5545:             .AutoSize = .F.
5546:             .FontName = "Tahoma"

*-- Linhas 5851 a 5928:
5851:             .Width          = 420
5852:             .Height         = 312
5853:             .ReadOnly       = .F.
5854:             .DeleteMark     = .F.
5855:             .RecordMark     = .F.
5856:             .GridLines      = 3
5857:             .FontName       = "Tahoma"
5858:             .FontSize       = 8
5859:             .Themes         = .F.
5860:             .Visible        = .T.
5861:         ENDWITH
5862:         loc_oPg.grd_4c_Fases.ColumnCount = 5
5863:         loc_oPg.grd_4c_Fases.RecordSource = "cursor_4c_Fases"
5864:         WITH loc_oPg.grd_4c_Fases
5865:             .Column1.Header1.Caption  = "Ordem"
5866:             .Column1.Width            = 40
5867:             .Column1.ControlSource    = "cursor_4c_Fases.ordems"
5868:             .Column2.Header1.Caption  = "Fase"
5869:             .Column2.Width            = 80
5870:             .Column2.ControlSource    = "cursor_4c_Fases.grupos"
5871:             .Column3.Header1.Caption  = "Utiliza" + CHR(231) + CHR(227) + "o"
5872:             .Column3.Width            = 70
5873:             .Column3.ControlSource    = "cursor_4c_Fases.minutos"
5874:             .Column4.Header1.Caption  = "Uni. Produtiva"
5875:             .Column4.Width            = 90
5876:             .Column4.ControlSource    = "cursor_4c_Fases.uniprdts"
5877:             .Column5.Header1.Caption  = "Material"
5878:             .Column5.Width            = 120
5879:             .Column5.ControlSource    = "cursor_4c_Fases.matprdts"
5880:         ENDWITH
5881: 
5882:         *======================================================
5883:         *-- GRID: grd_4c_Matrizes - 3 colunas - SigPrMtz
5884:         *-- top=380, left=7, width=246, height=240
5885:         *-- Matriz | Local | Qtde
5886:         *======================================================
5887:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
5888:         WITH loc_oPg.grd_4c_Matrizes
5889:             .Top            = 380
5890:             .Left           = 7
5891:             .Width          = 246
5892:             .Height         = 240
5893:             .ReadOnly       = .F.
5894:             .DeleteMark     = .F.
5895:             .RecordMark     = .F.
5896:             .GridLines      = 3
5897:             .FontName       = "Tahoma"
5898:             .FontSize       = 8
5899:             .Themes         = .F.
5900:             .Visible        = .T.
5901:         ENDWITH
5902:         loc_oPg.grd_4c_Matrizes.ColumnCount = 3
5903:         loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_Matrizes"
5904:         WITH loc_oPg.grd_4c_Matrizes
5905:             .Column1.Header1.Caption  = "Matriz"
5906:             .Column1.Width            = 100
5907:             .Column1.ControlSource    = "cursor_4c_Matrizes.cmats"
5908:             .Column2.Header1.Caption  = "Local"
5909:             .Column2.Width            = 80
5910:             .Column2.ControlSource    = "cursor_4c_Matrizes.locals"
5911:             .Column3.Header1.Caption  = "Qtde"
5912:             .Column3.Width            = 60
5913:             .Column3.ControlSource    = "cursor_4c_Matrizes.qtds"
5914:         ENDWITH
5915: 
5916:         *======================================================
5917:         *-- LABEL + TEXTBOX: Get_Desc - Descricao da fase selecionada
5918:         *======================================================
5919:         loc_oPg.AddObject("lbl_4c_DescFase", "Label")
5920:         WITH loc_oPg.lbl_4c_DescFase
5921:             .Top      = 474
5922:             .Left     = 527
5923:             .Width    = 67
5924:             .Height   = 17
5925:             .Caption  = "Descri" + CHR(231) + CHR(227) + "o :"
5926:             .AutoSize = .F.
5927:             .FontName = "Tahoma"
5928:             .FontSize = 8

*-- Linhas 6309 a 6327:
6309:             ENDIF
6310: 
6311:             IF !EMPTY(loc_cCgru)
6312:                 loc_cFiltro = "p.cgrus = " + EscaparSQL(loc_cCgru)
6313:             ENDIF
6314: 
6315:             *-- Filtro situacao
6316:             loc_nSit = 1
6317:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
6318:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas, "Value", 5)
6319:                     loc_nSit = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas.Value
6320:                 ENDIF
6321:             ENDIF
6322: 
6323:             IF loc_nSit = 2   && Apenas ativos (situas=1)
6324:                 IF !EMPTY(loc_cFiltro)
6325:                     loc_cFiltro = loc_cFiltro + " AND p.situas = 1"
6326:                 ELSE
6327:                     loc_cFiltro = "p.situas = 1"

*-- Linhas 6355 a 6380:
6355:                 *-- Definir RecordSource (ISSO RESETA AS COLUNAS)
6356:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
6357: 
6358:                 *-- Reconfigurar ControlSource APOS RecordSource
6359:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
6360:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
6361:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
6362:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
6363:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
6364:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.usuaalts"
6365:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.situas"
6366: 
6367:                 *-- Larguras
6368:                 loc_oGrid.Column1.Width = 110
6369:                 loc_oGrid.Column2.Width = 330
6370:                 loc_oGrid.Column3.Width = 55
6371:                 loc_oGrid.Column4.Width = 60
6372:                 loc_oGrid.Column5.Width = 160
6373:                 loc_oGrid.Column6.Width = 120
6374:                 loc_oGrid.Column7.Width = 40
6375: 
6376:                 *-- Cabecalhos (legado: Produto, Descricao, Grupo, Subgrp., Ref. Fornecedor, Usuario, I)
6377:                 loc_oGrid.Column1.Header1.Caption = "Produto"
6378:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
6379:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
6380:                 loc_oGrid.Column4.Header1.Caption = "Subgrp."

*-- Linhas 7986 a 8004:
7986:             RETURN
7987:         ENDIF
7988: 
7989:         SELECT cursor_4c_Dados
7990:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
7991: 
7992:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
7993:             THIS.BOParaForm()
7994:             THIS.this_cModoAtual = "VISUALIZAR"
7995:             THIS.HabilitarCampos(.F.)
7996:             THIS.AjustarBotoesPorModo()
7997:             THIS.AlternarPagina(2)
7998:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
7999:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8000:         ENDIF
8001:     ENDPROC
8002: 
8003:     *--------------------------------------------------------------------------
8004:     * BtnAlterarClick - Alterar produto selecionado

*-- Linhas 8015 a 8033:
8015:             RETURN
8016:         ENDIF
8017: 
8018:         SELECT cursor_4c_Dados
8019:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8020: 
8021:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8022:             THIS.this_oBusinessObject.EditarRegistro()
8023:             THIS.BOParaForm()
8024:             THIS.this_cModoAtual = "ALTERAR"
8025:             THIS.HabilitarCampos(.T.)
8026:             THIS.AjustarBotoesPorModo()
8027:             THIS.AlternarPagina(2)
8028:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8029:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8030:         ENDIF
8031:     ENDPROC
8032: 
8033:     *--------------------------------------------------------------------------

*-- Linhas 8046 a 8076:
8046:             RETURN
8047:         ENDIF
8048: 
8049:         SELECT cursor_4c_Dados
8050:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8051: 
8052:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8053: 
8054:             *-- Verificar uso em itens de pedido (SigMvCIte)
8055:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8056:                 SELECT COUNT(*) AS nExiste
8057:                 FROM SigMvCIte
8058:                 WHERE cpros = <<EscaparSQL(loc_cCodigo)>>
8059:             ENDTEXT
8060: 
8061:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerPro")
8062: 
8063:             IF loc_nResultado < 0
8064:                 MsgErro("Falha ao verificar uso do produto!")
8065:                 IF USED("cursor_4c_VerPro")
8066:                     USE IN cursor_4c_VerPro
8067:                 ENDIF
8068:                 RETURN
8069:             ENDIF
8070: 
8071:             IF NVL(cursor_4c_VerPro.nExiste, 0) > 0
8072:                 MsgAviso("Produto em uso em pedidos - n" + CHR(227) + "o pode ser exclu" + CHR(237) + "do!")
8073:                 IF USED("cursor_4c_VerPro")
8074:                     USE IN cursor_4c_VerPro
8075:                 ENDIF
8076:                 RETURN

*-- Linhas 8116 a 8137:
8116:                 loc_cCodNovo = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
8117: 
8118:                 TEXT TO loc_cSQLDup TEXTMERGE NOSHOW
8119:                     SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = <<EscaparSQL(loc_cCodNovo)>>
8120:                 ENDTEXT
8121: 
8122:                 loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupPro")
8123: 
8124:                 IF loc_nDup >= 0 AND NVL(cursor_4c_DupPro.nExiste, 0) > 0
8125:                     IF USED("cursor_4c_DupPro")
8126:                         USE IN cursor_4c_DupPro
8127:                     ENDIF
8128:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
8129:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8130:                         loc_oPg.txt_4c_Cpros.SetFocus()
8131:                     ENDIF
8132:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8133:                     THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8134:                     RETURN
8135:                 ENDIF
8136: 
8137:                 IF USED("cursor_4c_DupPro")

*-- Linhas 8249 a 8270:
8249: 
8250:         TRY
8251:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8252:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCgru)>>
8253:             ENDTEXT
8254: 
8255:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerGru")
8256: 
8257:             IF loc_nRes > 0 AND !EOF("cursor_4c_VerGru")
8258:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_VerGru.dgrus)
8259:             ELSE
8260:                 *-- Codigo nao encontrado: abrir lookup
8261:                 THIS.AbrirLookupFiltroGrupo()
8262:             ENDIF
8263: 
8264:             IF USED("cursor_4c_VerGru")
8265:                 USE IN cursor_4c_VerGru
8266:             ENDIF
8267:         CATCH TO loc_oErro
8268:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarFiltroGrupo")
8269:         ENDTRY
8270:     ENDPROC

*-- Linhas 8419 a 8439:
8419: 
8420:         TRY
8421:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8422:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCod)>>
8423:             ENDTEXT
8424:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGrp")
8425:             IF loc_nR > 0 AND !EOF("cursor_4c_VGrp")
8426:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8427:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_VGrp.dgrus)
8428:                 ENDIF
8429:             ELSE
8430:                 THIS.AbrirLookupGrupo()
8431:             ENDIF
8432:             IF USED("cursor_4c_VGrp")
8433:                 USE IN cursor_4c_VGrp
8434:             ENDIF
8435:         CATCH TO loc_oErro
8436:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CgruLostFocus")
8437:         ENDTRY
8438:     ENDPROC
8439: 

*-- Linhas 8513 a 8533:
8513: 
8514:         TRY
8515:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8516:                 SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = <<EscaparSQL(loc_cCod)>>
8517:             ENDTEXT
8518:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VLin")
8519:             IF loc_nR > 0 AND !EOF("cursor_4c_VLin")
8520:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8521:                     loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_VLin.Descs)
8522:                 ENDIF
8523:             ELSE
8524:                 THIS.AbrirLookupLinha()
8525:             ENDIF
8526:             IF USED("cursor_4c_VLin")
8527:                 USE IN cursor_4c_VLin
8528:             ENDIF
8529:         CATCH TO loc_oErro
8530:             MsgErro("Erro ao validar linha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_LinhasLostFocus")
8531:         ENDTRY
8532:     ENDPROC
8533: 

*-- Linhas 8607 a 8627:
8607: 
8608:         TRY
8609:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8610:                 SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = <<EscaparSQL(loc_cCod)>>
8611:             ENDTEXT
8612:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCol")
8613:             IF loc_nR > 0 AND !EOF("cursor_4c_VCol")
8614:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8615:                     loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_VCol.Descs)
8616:                 ENDIF
8617:             ELSE
8618:                 THIS.AbrirLookupColecao()
8619:             ENDIF
8620:             IF USED("cursor_4c_VCol")
8621:                 USE IN cursor_4c_VCol
8622:             ENDIF
8623:         CATCH TO loc_oErro
8624:             MsgErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_ColecoesLostFocus")
8625:         ENDTRY
8626:     ENDPROC
8627: 

*-- Linhas 8701 a 8721:
8701: 
8702:         TRY
8703:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8704:                 SELECT TOP 1 IClis, Rclis FROM SigCdCli WHERE IClis = <<EscaparSQL(loc_cCod)>>
8705:             ENDTEXT
8706:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VFor")
8707:             IF loc_nR > 0 AND !EOF("cursor_4c_VFor")
8708:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8709:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_VFor.Rclis)
8710:                 ENDIF
8711:             ELSE
8712:                 THIS.AbrirLookupFornecedor()
8713:             ENDIF
8714:             IF USED("cursor_4c_VFor")
8715:                 USE IN cursor_4c_VFor
8716:             ENDIF
8717:         CATCH TO loc_oErro
8718:             MsgErro("Erro ao validar fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_IforsLostFocus")
8719:         ENDTRY
8720:     ENDPROC
8721: 

*-- Linhas 8897 a 8917:
8897: 
8898:         TRY
8899:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8900:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8901:             ENDTEXT
8902:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUni")
8903:             IF loc_nR > 0 AND !EOF("cursor_4c_VUni")
8904:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
8905:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_VUni.dunis)
8906:                 ENDIF
8907:             ELSE
8908:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
8909:             ENDIF
8910:             IF USED("cursor_4c_VUni")
8911:                 USE IN cursor_4c_VUni
8912:             ENDIF
8913:         CATCH TO loc_oErro
8914:             MsgErro("Erro ao validar unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunisLostFocus")
8915:         ENDTRY
8916:     ENDPROC
8917: 

*-- Linhas 8950 a 8970:
8950: 
8951:         TRY
8952:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8953:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8954:             ENDTEXT
8955:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUn2")
8956:             IF loc_nR > 0 AND !EOF("cursor_4c_VUn2")
8957:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
8958:                     loc_oPg.txt_4c_Dunips.Value = ALLTRIM(cursor_4c_VUn2.dunis)
8959:                 ENDIF
8960:             ELSE
8961:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
8962:             ENDIF
8963:             IF USED("cursor_4c_VUn2")
8964:                 USE IN cursor_4c_VUn2
8965:             ENDIF
8966:         CATCH TO loc_oErro
8967:             MsgErro("Erro ao validar unidade 2:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunipsLostFocus")
8968:         ENDTRY
8969:     ENDPROC
8970: 

*-- Linhas 9047 a 9067:
9047: 
9048:         TRY
9049:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9050:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
9051:             ENDTEXT
9052:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcb")
9053:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcb")
9054:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9055:                     loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_VAcb.descrs)
9056:                 ENDIF
9057:             ELSE
9058:                 THIS.AbrirLookupAcabamento()
9059:             ENDIF
9060:             IF USED("cursor_4c_VAcb")
9061:                 USE IN cursor_4c_VAcb
9062:             ENDIF
9063:         CATCH TO loc_oErro
9064:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodacbsLostFocus")
9065:         ENDTRY
9066:     ENDPROC
9067: 

*-- Linhas 9138 a 9158:
9138: 
9139:         TRY
9140:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9141:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
9142:             ENDTEXT
9143:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCor")
9144:             IF loc_nR <= 0
9145:                 THIS.AbrirLookupCor()
9146:             ELSE
9147:                 IF EOF("cursor_4c_VCor")
9148:                     THIS.AbrirLookupCor()
9149:                 ENDIF
9150:             ENDIF
9151:             IF USED("cursor_4c_VCor")
9152:                 USE IN cursor_4c_VCor
9153:             ENDIF
9154:         CATCH TO loc_oErro
9155:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodcorsLostFocus")
9156:         ENDTRY
9157:     ENDPROC
9158: 

*-- Linhas 9247 a 9413:
9247:         IF !EMPTY(par_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
9248:             TRY
9249:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9250:                     SELECT TOP 1 <<par_cCampoDesc>> FROM <<par_cTabela>> WHERE <<par_cCampoChave>> = <<EscaparSQL(par_cValor)>>
9251:                 ENDTEXT
9252:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescH")
9253:                 IF loc_nR > 0 AND !EOF("cursor_4c_DescH")
9254:                     loc_cAliasField = "cursor_4c_DescH." + par_cCampoDesc
9255:                     loc_cDesc = ALLTRIM(&loc_cAliasField)
9256:                 ENDIF
9257:                 IF USED("cursor_4c_DescH")
9258:                     USE IN cursor_4c_DescH
9259:                 ENDIF
9260:             CATCH TO loc_oErro
9261:                 MsgErro("Erro ao carregar descricao:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDesc")
9262:             ENDTRY
9263:         ENDIF
9264: 
9265:         RETURN loc_cDesc
9266:     ENDFUNC
9267: 
9268:     *--------------------------------------------------------------------------
9269:     * CarregarComposicao - Carrega grid de composicao (Tab 2)
9270:     * Tabela: SIGPRCPO JOIN SigCdPro
9271:     *--------------------------------------------------------------------------
9272:     PROTECTED PROCEDURE CarregarComposicao()
9273:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9274:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9275:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9276: 
9277:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9278:             RETURN
9279:         ENDIF
9280: 
9281:         TRY
9282:             *-- Composicao principal
9283:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9284:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9285:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9286:                        c.qtdcvs, c.cunips, c.ordems, c.compos
9287:                 FROM SIGPRCPO c
9288:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9289:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9290:                 ORDER BY c.ordems
9291:             ENDTEXT
9292:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTmp")
9293:             IF loc_nR > 0
9294:                 IF USED("cursor_4c_Compo")
9295:                     SELECT cursor_4c_Compo
9296:                     ZAP
9297:                     APPEND FROM DBF("cursor_4c_CompoTmp")
9298:                 ENDIF
9299:                 IF USED("cursor_4c_CompoTmp")
9300:                     USE IN cursor_4c_CompoTmp
9301:                 ENDIF
9302:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
9303:                     loc_oPg.grd_4c_Compo.Refresh()
9304:                 ENDIF
9305:             ENDIF
9306: 
9307:             *-- Sub-composicao
9308:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9309:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9310:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9311:                        c.qtdcvs, c.cunips, c.ordems, c.matsubs, c.codtams
9312:                 FROM sigsubcp c
9313:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9314:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9315:                 ORDER BY c.ordems
9316:             ENDTEXT
9317:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubCompoTmp")
9318:             IF loc_nR > 0
9319:                 IF USED("cursor_4c_SubCompo")
9320:                     SELECT cursor_4c_SubCompo
9321:                     ZAP
9322:                     APPEND FROM DBF("cursor_4c_SubCompoTmp")
9323:                 ENDIF
9324:                 IF USED("cursor_4c_SubCompoTmp")
9325:                     USE IN cursor_4c_SubCompoTmp
9326:                 ENDIF
9327:                 IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
9328:                     loc_oPg.grd_4c_SubCompo.Refresh()
9329:                 ENDIF
9330:             ENDIF
9331: 
9332:         CATCH TO loc_oErro
9333:             MsgErro("Erro ao carregar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarComposicao")
9334:         ENDTRY
9335:     ENDPROC
9336: 
9337:     *--------------------------------------------------------------------------
9338:     * CarregarConsultaP - Carrega grids da aba Consulta P. (Tab 6 - PgDadosConsP)
9339:     * GrdCons: SIGPRCPO JOIN SigCdPrf(fase) JOIN SigCdCat(categoria)
9340:     * grDTEMP:  SIGPRCPO agrupado por fase (consumo total)
9341:     *--------------------------------------------------------------------------
9342:     PROTECTED PROCEDURE CarregarConsultaP()
9343:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nCount, loc_oPg
9344:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9345:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9346: 
9347:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9348:             RETURN
9349:         ENDIF
9350: 
9351:         TRY
9352:             *-- Carregar componentes com descricao de fase e categoria
9353:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9354:                 SELECT c.mats, c.qtds, c.unicompos, c.grupos,
9355:                        ISNULL((SELECT TOP 1 g.Descrs FROM SigCdGcr g WHERE RTRIM(g.Codigos) = RTRIM(c.grupos)), '') AS dcompos,
9356:                        c.ordems, c.qtscons, c.cats,
9357:                        ISNULL(cat.descs, '') AS dscgrp
9358:                 FROM SIGPRCPO c
9359:                 LEFT JOIN SigCdCat cat ON RTRIM(c.cats) = RTRIM(cat.cods)
9360:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9361:                 ORDER BY c.ordems, c.mats
9362:             ENDTEXT
9363:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaTmp")
9364:             IF loc_nR > 0
9365:                 IF USED("cursor_4c_Consulta")
9366:                     SELECT cursor_4c_Consulta
9367:                     ZAP
9368:                     APPEND FROM DBF("cursor_4c_ConsultaTmp")
9369:                 ENDIF
9370:                 IF USED("cursor_4c_ConsultaTmp")
9371:                     USE IN cursor_4c_ConsultaTmp
9372:                 ENDIF
9373:                 *-- Atualizar contagem de componentes
9374:                 loc_nCount = RECCOUNT("cursor_4c_Consulta")
9375:                 IF PEMSTATUS(loc_oPg, "txt_4c_QtdCpnt", 5)
9376:                     loc_oPg.txt_4c_QtdCpnt.Value = loc_nCount
9377:                 ENDIF
9378:                 IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
9379:                     loc_oPg.grd_4c_Consulta.Refresh()
9380:                 ENDIF
9381:             ENDIF
9382: 
9383:             *-- Carregar dados grDTEMP: consumo total agrupado por fase
9384:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9385:                 SELECT c.grupos, SUM(c.qtscons) AS totas
9386:                 FROM SIGPRCPO c
9387:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9388:                   AND c.grupos IS NOT NULL
9389:                   AND RTRIM(c.grupos) <> ''
9390:                 GROUP BY c.grupos
9391:                 ORDER BY c.grupos
9392:             ENDTEXT
9393:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempTmp")
9394:             IF loc_nR > 0
9395:                 IF USED("cursor_4c_Temp")
9396:                     SELECT cursor_4c_Temp
9397:                     ZAP
9398:                     APPEND FROM DBF("cursor_4c_TempTmp")
9399:                 ENDIF
9400:                 IF USED("cursor_4c_TempTmp")
9401:                     USE IN cursor_4c_TempTmp
9402:                 ENDIF
9403:                 IF PEMSTATUS(loc_oPg, "grd_4c_Temp", 5)
9404:                     loc_oPg.grd_4c_Temp.Refresh()
9405:                 ENDIF
9406:             ENDIF
9407: 
9408:         CATCH TO loc_oErro
9409:             MsgErro("Erro ao carregar consulta de componentes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarConsultaP")
9410:         ENDTRY
9411:     ENDPROC
9412: 
9413:     *--------------------------------------------------------------------------

*-- Linhas 9433 a 9528:
9433:             *-- Composicao de custo
9434:             IF loc_nTipo = 0
9435:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9436:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9437:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9438:                            c.qtdcvs, c.cunips
9439:                     FROM SIGPRCPO c
9440:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9441:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9442:                     AND c.tipos IS NOT NULL
9443:                     ORDER BY c.mats
9444:                 ENDTEXT
9445:             ELSE
9446:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9447:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9448:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9449:                            c.qtdcvs, c.cunips
9450:                     FROM SIGPRCPO c
9451:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9452:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9453:                     AND c.tipos = <<TRANSFORM(loc_nTipo)>>
9454:                     ORDER BY c.mats
9455:                 ENDTEXT
9456:             ENDIF
9457: 
9458:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoCustoTmp")
9459:             IF loc_nR > 0
9460:                 IF USED("cursor_4c_CompoCusto")
9461:                     SELECT cursor_4c_CompoCusto
9462:                     ZAP
9463:                     APPEND FROM DBF("cursor_4c_CompoCustoTmp")
9464:                 ENDIF
9465:                 IF USED("cursor_4c_CompoCustoTmp")
9466:                     USE IN cursor_4c_CompoCustoTmp
9467:                 ENDIF
9468:                 IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
9469:                     WITH loc_oPg.grd_4c_CompoCusto
9470:                         .Column1.ControlSource  = "cursor_4c_CompoCusto.mats"
9471:                         .Column2.ControlSource  = "cursor_4c_CompoCusto.dcompos"
9472:                         .Column3.ControlSource  = "cursor_4c_CompoCusto.unicompos"
9473:                         .Column4.ControlSource  = "cursor_4c_CompoCusto.pcompos"
9474:                         .Column5.ControlSource  = "cursor_4c_CompoCusto.qtds"
9475:                         .Column6.ControlSource  = "cursor_4c_CompoCusto.totas"
9476:                         .Column7.ControlSource  = "cursor_4c_CompoCusto.moeds"
9477:                         .Column8.ControlSource  = "cursor_4c_CompoCusto.obscompos"
9478:                         .Column9.ControlSource  = "cursor_4c_CompoCusto.etiqs"
9479:                         .Column10.ControlSource = "cursor_4c_CompoCusto.qtscons"
9480:                         .Column11.ControlSource = "cursor_4c_CompoCusto.qtdcvs"
9481:                         .Column12.ControlSource = "cursor_4c_CompoCusto.cunips"
9482:                     ENDWITH
9483:                     loc_oPg.grd_4c_CompoCusto.Refresh()
9484:                 ENDIF
9485:             ENDIF
9486: 
9487:             *-- Totais por grupo de custo (GradeGRUPO2)
9488:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9489:                 SELECT RTRIM(m.cgrus) AS grupos,
9490:                        SUM(c.totas) AS totas,
9491:                        MAX(c.moeds) AS moeds
9492:                 FROM SIGPRCPO c
9493:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9494:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9495:                 AND c.tipos IS NOT NULL
9496:                 GROUP BY m.cgrus
9497:                 ORDER BY m.cgrus
9498:             ENDTEXT
9499:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoCompo2Tmp")
9500:             IF loc_nR > 0
9501:                 IF USED("cursor_4c_GrupoCompo2")
9502:                     SELECT cursor_4c_GrupoCompo2
9503:                     ZAP
9504:                     APPEND FROM DBF("cursor_4c_GrupoCompo2Tmp")
9505:                 ENDIF
9506:                 IF USED("cursor_4c_GrupoCompo2Tmp")
9507:                     USE IN cursor_4c_GrupoCompo2Tmp
9508:                 ENDIF
9509:                 IF PEMSTATUS(loc_oPg, "grd_4c_GrupoCompo2", 5)
9510:                     WITH loc_oPg.grd_4c_GrupoCompo2
9511:                         .Column1.ControlSource = "cursor_4c_GrupoCompo2.grupos"
9512:                         .Column2.ControlSource = "cursor_4c_GrupoCompo2.totas"
9513:                         .Column3.ControlSource = "cursor_4c_GrupoCompo2.moeds"
9514:                     ENDWITH
9515:                     loc_oPg.grd_4c_GrupoCompo2.Refresh()
9516:                 ENDIF
9517:             ENDIF
9518: 
9519:         CATCH TO loc_oErro
9520:             MsgErro("Erro ao carregar custos:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarCustos")
9521:         ENDTRY
9522:     ENDPROC
9523: 
9524:     *--------------------------------------------------------------------------
9525:     * CarregarFases - Carrega grid de fases (Tab 7)
9526:     * Tabela: SigCdPrf
9527:     *--------------------------------------------------------------------------
9528:     PROTECTED PROCEDURE CarregarFases()

*-- Linhas 9538 a 9566:
9538:         TRY
9539:             *-- Fases de producao
9540:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9541:                 SELECT ordems, grupos, minutos, uniprdts, matprdts
9542:                 FROM SigCdPrf
9543:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9544:                 ORDER BY ordems
9545:             ENDTEXT
9546:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")
9547:             IF loc_nR > 0
9548:                 IF USED("cursor_4c_Fases")
9549:                     SELECT cursor_4c_Fases
9550:                     ZAP
9551:                     APPEND FROM DBF("cursor_4c_FasesTmp")
9552:                 ENDIF
9553:                 IF USED("cursor_4c_FasesTmp")
9554:                     USE IN cursor_4c_FasesTmp
9555:                 ENDIF
9556:                 IF PEMSTATUS(loc_oPg, "grd_4c_Fases", 5)
9557:                     loc_oPg.grd_4c_Fases.Refresh()
9558:                 ENDIF
9559:             ENDIF
9560: 
9561:             *-- Matrizes
9562:             THIS.CarregarMatrizes()
9563: 
9564:             *-- Preencher campos do BO nas textboxes da tab
9565:             IF PEMSTATUS(loc_oPg, "txt_4c_Qminfab", 5)
9566:                 loc_oPg.txt_4c_Qminfab.Value   = loc_oBO.this_nQtminfabs

*-- Linhas 9606 a 9647:
9606: 
9607:     *--------------------------------------------------------------------------
9608:     * CarregarMatrizes - Carrega grid de matrizes (Tab 7 - sub-grid)
9609:     * Tabela: SigPrMtz JOIN SigCdPro (para Locals)
9610:     *--------------------------------------------------------------------------
9611:     PROTECTED PROCEDURE CarregarMatrizes()
9612:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9613:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9614:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
9615: 
9616:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9617:             RETURN
9618:         ENDIF
9619: 
9620:         TRY
9621:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9622:                 SELECT a.cidchaves, a.cmats, a.cpros, a.qtds, b.locals
9623:                 FROM SigPrMtz a
9624:                 INNER JOIN SigCdPro b ON RTRIM(a.cmats) = RTRIM(b.cpros)
9625:                 WHERE RTRIM(a.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9626:             ENDTEXT
9627:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizesTmp")
9628:             IF loc_nR > 0
9629:                 IF USED("cursor_4c_Matrizes")
9630:                     SELECT cursor_4c_Matrizes
9631:                     ZAP
9632:                     APPEND FROM DBF("cursor_4c_MatrizesTmp")
9633:                 ENDIF
9634:                 IF USED("cursor_4c_MatrizesTmp")
9635:                     USE IN cursor_4c_MatrizesTmp
9636:                 ENDIF
9637:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
9638:                     loc_oPg.grd_4c_Matrizes.Refresh()
9639:                 ENDIF
9640:             ENDIF
9641: 
9642:         CATCH TO loc_oErro
9643:             MsgErro("Erro ao carregar matrizes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarMatrizes")
9644:         ENDTRY
9645:     ENDPROC
9646: 
9647:     *--------------------------------------------------------------------------

*-- Linhas 9654 a 9675:
9654:         IF !EMPTY(par_cSgrus) AND !EMPTY(par_cCgrus) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
9655:             TRY
9656:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9657:                     SELECT TOP 1 codigos, descricaos FROM SigCdPsg
9658:                     WHERE cgrus = <<EscaparSQL(par_cCgrus)>> AND codigos = <<EscaparSQL(par_cSgrus)>>
9659:                 ENDTEXT
9660:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescSg")
9661:                 IF loc_nR > 0 AND !EOF("cursor_4c_DescSg")
9662:                     loc_cDesc = ALLTRIM(cursor_4c_DescSg.descricaos)
9663:                 ENDIF
9664:                 IF USED("cursor_4c_DescSg")
9665:                     USE IN cursor_4c_DescSg
9666:                 ENDIF
9667:             CATCH TO loc_oErro
9668:                 MsgErro("Erro ao carregar subgrupo:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDescSgru")
9669:             ENDTRY
9670:         ENDIF
9671: 
9672:         RETURN loc_cDesc
9673:     ENDFUNC
9674: 
9675:     *--------------------------------------------------------------------------

*-- Linhas 9806 a 9826:
9806:                     *-- Popula AliqIPI com aliqipis da classificacao fiscal
9807:                     IF PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
9808:                         TEXT TO loc_cSQL TEXTMERGE NOSHOW
9809:                             SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(cursor_4c_ClfV.Codigos))>>)
9810:                         ENDTEXT
9811:                         loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliq")
9812:                         IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliq")
9813:                             loc_oPg.txt_4c_AliqIPI.Value = cursor_4c_ClfAliq.aliqipis
9814:                         ENDIF
9815:                         IF USED("cursor_4c_ClfAliq")
9816:                             USE IN cursor_4c_ClfAliq
9817:                         ENDIF
9818:                     ENDIF
9819:                 ENDIF
9820:             ELSE
9821:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9822:                     loc_oPg.txt_4c_Clfiscal.Value  = ""
9823:                 ENDIF
9824:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9825:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9826:                 ENDIF

*-- Linhas 10256 a 10276:
10256: 
10257:         TRY
10258:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10259:                 SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))>>)
10260:             ENDTEXT
10261:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliqV")
10262:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliqV")
10263:                 loc_nAliqClf = cursor_4c_ClfAliqV.aliqipis
10264:                 IF loc_nVal = loc_nAliqClf
10265:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal." + CHR(13) + "Deixe zero para utilizar a classifica" + CHR(231) + CHR(227) + "o fiscal.", "Al" + CHR(237) + "quota IPI")
10266:                 ENDIF
10267:             ENDIF
10268:             IF USED("cursor_4c_ClfAliqV")
10269:                 USE IN cursor_4c_ClfAliqV
10270:             ENDIF
10271:         CATCH TO loc_oErro
10272:             MsgErro("Erro ao validar al" + CHR(237) + "quota IPI:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarAliqIPI")
10273:         ENDTRY
10274:     ENDPROC
10275: 
10276:     *--------------------------------------------------------------------------

*-- Linhas 10612 a 10632:
10612: 
10613:         TRY
10614:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10615:                 SELECT IpiProds FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cClf)>>)
10616:             ENDTEXT
10617:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfIpi")
10618:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfIpi")
10619:                 loc_lHabilitar = (ALLTRIM(cursor_4c_ClfIpi.IpiProds) = "S")
10620:             ENDIF
10621:             IF USED("cursor_4c_ClfIpi")
10622:                 USE IN cursor_4c_ClfIpi
10623:             ENDIF
10624:         CATCH TO loc_oErro
10625:             MsgErro("Erro ao verificar IpiProds:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFiscal_ExtIpiGotFocus")
10626:         ENDTRY
10627: 
10628:         IF !loc_lHabilitar
10629:             IF PEMSTATUS(loc_oPg, "txt_4c_Extipi", 5)
10630:                 loc_oPg.txt_4c_Extipi.ReadOnly = .T.
10631:             ENDIF
10632:         ENDIF

*-- Linhas 10670 a 10721:
10670: 
10671:         TRY
10672:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10673:                 SELECT Datas AS periodos, ValCuss AS valcustos, Moedas AS moedas
10674:                 FROM SigCdCmv
10675:                 WHERE RTRIM(Cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10676:                 ORDER BY Datas DESC
10677:             ENDTEXT
10678: 
10679:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp")
10680: 
10681:             IF USED("cursor_4c_Cmv")
10682:                 ZAP IN cursor_4c_Cmv
10683:             ENDIF
10684: 
10685:             IF loc_nR > 0
10686:                 IF !USED("cursor_4c_Cmv")
10687:                     SET NULL ON
10688:                     CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
10689:                     SET NULL OFF
10690:                 ENDIF
10691:                 IF USED("cursor_4c_CmvTemp")
10692:                     SELECT cursor_4c_Cmv
10693:                     APPEND FROM DBF("cursor_4c_CmvTemp")
10694:                 ENDIF
10695:             ENDIF
10696: 
10697:             IF USED("cursor_4c_CmvTemp")
10698:                 USE IN cursor_4c_CmvTemp
10699:             ENDIF
10700: 
10701:             IF PEMSTATUS(loc_oPg, "grd_4c_Cmv", 5)
10702:                 loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
10703:                 WITH loc_oPg.grd_4c_Cmv
10704:                     .Column1.ControlSource = "cursor_4c_Cmv.periodos"
10705:                     .Column2.ControlSource = "cursor_4c_Cmv.valcustos"
10706:                     .Column3.ControlSource = "cursor_4c_Cmv.moedas"
10707:                 ENDWITH
10708:                 loc_oPg.grd_4c_Cmv.Refresh()
10709:             ENDIF
10710:         CATCH TO loc_oErro
10711:             MsgErro("Erro ao carregar dados CMV:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDadosFiscais")
10712:         ENDTRY
10713:     ENDPROC
10714: 
10715:     *--------------------------------------------------------------------------
10716:     * BtnIniTarefaClick - Registra inicio de tarefa do Designer
10717:     * Tabela: sigprtar (cpros, dtinis, usuars)
10718:     *--------------------------------------------------------------------------
10719:     PROCEDURE BtnIniTarefaClick()
10720:         LOCAL loc_cCpros, loc_cSQL, loc_nR
10721:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

*-- Linhas 10727 a 10748:
10727: 
10728:         TRY
10729:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10730:                 INSERT INTO sigprtar (cpros, dtinis, usuars)
10731:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<FormatarDataSQL(DATE())>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>)
10732:             ENDTEXT
10733:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10734:             IF loc_nR > 0
10735:                 THIS.CarregarDesigner()
10736:             ELSE
10737:                 MsgErro("Erro ao registrar in" + CHR(237) + "cio de tarefa.", "FormProduto.BtnIniTarefaClick")
10738:             ENDIF
10739:         CATCH TO loc_oErro
10740:             MsgErro("Erro ao iniciar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnIniTarefaClick")
10741:         ENDTRY
10742:     ENDPROC
10743: 
10744:     *--------------------------------------------------------------------------
10745:     * BtnFimTarefaClick - Registra fim de tarefa do Designer
10746:     * Atualiza dtfims na ultima tarefa em aberto (dtfims IS NULL)
10747:     *--------------------------------------------------------------------------
10748:     PROCEDURE BtnFimTarefaClick()

*-- Linhas 10756 a 10777:
10756: 
10757:         TRY
10758:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10759:                 UPDATE TOP(1) sigprtar SET dtfims = <<FormatarDataSQL(DATE())>>
10760:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10761:             ENDTEXT
10762:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10763:             IF loc_nR > 0
10764:                 THIS.CarregarDesigner()
10765:             ELSE
10766:                 MsgErro("Nenhuma tarefa em aberto para finalizar.", "FormProduto.BtnFimTarefaClick")
10767:             ENDIF
10768:         CATCH TO loc_oErro
10769:             MsgErro("Erro ao finalizar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnFimTarefaClick")
10770:         ENDTRY
10771:     ENDPROC
10772: 
10773:     *--------------------------------------------------------------------------
10774:     * BtnInsArqsClick - Insere arquivo do Designer via dialogo de arquivo
10775:     * Tabela: sigprarq (cpros, arquivos)
10776:     *--------------------------------------------------------------------------
10777:     PROCEDURE BtnInsArqsClick()

*-- Linhas 10790 a 10811:
10790: 
10791:         TRY
10792:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10793:                 INSERT INTO sigprarq (cpros, arquivos)
10794:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<EscaparSQL(loc_cArquivo)>>)
10795:             ENDTEXT
10796:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10797:             IF loc_nR > 0
10798:                 THIS.CarregarDesigner()
10799:             ELSE
10800:                 MsgErro("Erro ao inserir arquivo.", "FormProduto.BtnInsArqsClick")
10801:             ENDIF
10802:         CATCH TO loc_oErro
10803:             MsgErro("Erro ao inserir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInsArqsClick")
10804:         ENDTRY
10805:     ENDPROC
10806: 
10807:     *--------------------------------------------------------------------------
10808:     * BtnExcArqsClick - Exclui arquivo selecionado no grid de arquivos
10809:     *--------------------------------------------------------------------------
10810:     PROCEDURE BtnExcArqsClick()
10811:         LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR

*-- Linhas 10821 a 10842:
10821:         IF MsgConfirma("Excluir o arquivo selecionado?", "Arquivos Designer")
10822:             TRY
10823:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
10824:                     DELETE FROM sigprarq
10825:                     WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND RTRIM(arquivos) = RTRIM(<<EscaparSQL(loc_cArquivo)>>)
10826:                 ENDTEXT
10827:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10828:                 IF loc_nR > 0
10829:                     THIS.CarregarDesigner()
10830:                 ELSE
10831:                     MsgErro("Erro ao excluir arquivo.", "FormProduto.BtnExcArqsClick")
10832:                 ENDIF
10833:             CATCH TO loc_oErro
10834:                 MsgErro("Erro ao excluir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcArqsClick")
10835:             ENDTRY
10836:         ENDIF
10837:     ENDPROC
10838: 
10839:     *--------------------------------------------------------------------------
10840:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao
10841:     *--------------------------------------------------------------------------
10842:     PROCEDURE BtnOpnArqsClick()

*-- Linhas 10880 a 10946:
10880:         TRY
10881:             *-- Tarefas do Designer
10882:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10883:                 SELECT dtinis, dtfims, usuars, tarefas
10884:                 FROM sigprtar
10885:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10886:                 ORDER BY dtinis DESC
10887:             ENDTEXT
10888:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesignerTmp")
10889:             IF loc_nR > 0
10890:                 IF USED("cursor_4c_Designer")
10891:                     SELECT cursor_4c_Designer
10892:                     ZAP
10893:                     APPEND FROM DBF("cursor_4c_DesignerTmp")
10894:                 ENDIF
10895:                 IF USED("cursor_4c_DesignerTmp")
10896:                     USE IN cursor_4c_DesignerTmp
10897:                 ENDIF
10898:                 IF PEMSTATUS(loc_oPg, "grd_4c_Designer", 5)
10899:                     loc_oPg.grd_4c_Designer.Refresh()
10900:                 ENDIF
10901:             ENDIF
10902: 
10903:             *-- Arquivos do Designer
10904:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10905:                 SELECT arquivos FROM sigprarq
10906:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10907:                 ORDER BY arquivos
10908:             ENDTEXT
10909:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArquivosTmp")
10910:             IF loc_nR > 0
10911:                 IF USED("cursor_4c_Arquivos")
10912:                     SELECT cursor_4c_Arquivos
10913:                     ZAP
10914:                     APPEND FROM DBF("cursor_4c_ArquivosTmp")
10915:                 ENDIF
10916:                 IF USED("cursor_4c_ArquivosTmp")
10917:                     USE IN cursor_4c_ArquivosTmp
10918:                 ENDIF
10919:                 IF PEMSTATUS(loc_oPg, "grd_4c_Arquivos", 5)
10920:                     loc_oPg.grd_4c_Arquivos.Refresh()
10921:                 ENDIF
10922:             ENDIF
10923: 
10924:             *-- Tarefas dispon?veis para lookup Column4 (SigPrTrf = tabela mestre de tarefas)
10925:             IF USED("cursor_4c_Tarefas")
10926:                 ZAP IN cursor_4c_Tarefas
10927:             ENDIF
10928:             loc_nR = SQLEXEC(gnConnHandle, "SELECT CodCads, DesCads FROM SigPrTrf ORDER BY CodCads", "cursor_4c_TarefasTmp")
10929:             IF loc_nR > 0
10930:                 IF USED("cursor_4c_Tarefas")
10931:                     APPEND FROM DBF("cursor_4c_TarefasTmp")
10932:                 ENDIF
10933:                 IF USED("cursor_4c_TarefasTmp")
10934:                     USE IN cursor_4c_TarefasTmp
10935:                 ENDIF
10936:             ELSE
10937:                 *-- Tabela SigPrTrf nao localizada: cursor fica vazio (lookup manual)
10938:                 IF USED("cursor_4c_TarefasTmp")
10939:                     USE IN cursor_4c_TarefasTmp
10940:                 ENDIF
10941:             ENDIF
10942: 
10943:         CATCH TO loc_oErro
10944:             MsgErro("Erro ao carregar designer:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDesigner")
10945:         ENDTRY
10946:     ENDPROC

*-- Linhas 11127 a 11156:
11127:             ENDIF
11128: 
11129:             gb_4c_ValidandoUI = .T.
11130:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11131:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecTmp")
11132:             gb_4c_ValidandoUI = .F.
11133: 
11134:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecTmp")
11135:                 *-- Nao encontrou: abre lookup
11136:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11137:                 loc_oForm.Caption = "Moedas"
11138:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11139:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11140:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11141:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11142:                 loc_oForm.Show()
11143:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11144:                     loc_oPg.txt_4c_PcusMoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11145:                     USE IN cursor_4c_BuscaAux
11146:                 ELSE
11147:                     loc_oPg.txt_4c_PcusMoe.Value = ""
11148:                 ENDIF
11149:                 loc_oForm.Release()
11150:             ENDIF
11151:             IF USED("cursor_4c_MoecTmp")
11152:                 USE IN cursor_4c_MoecTmp
11153:             ENDIF
11154:         CATCH TO loc_oErro
11155:             gb_4c_ValidandoUI = .F.
11156:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecLostFocus")

*-- Linhas 11179 a 11207:
11179:             ENDIF
11180: 
11181:             gb_4c_ValidandoUI = .T.
11182:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11183:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecusfTmp")
11184:             gb_4c_ValidandoUI = .F.
11185: 
11186:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecusfTmp")
11187:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11188:                 loc_oForm.Caption = "Moedas"
11189:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11190:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11191:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11192:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11193:                 loc_oForm.Show()
11194:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11195:                     loc_oPg.txt_4c_MoecusFoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11196:                     USE IN cursor_4c_BuscaAux
11197:                 ELSE
11198:                     loc_oPg.txt_4c_MoecusFoe.Value = ""
11199:                 ENDIF
11200:                 loc_oForm.Release()
11201:             ENDIF
11202:             IF USED("cursor_4c_MoecusfTmp")
11203:                 USE IN cursor_4c_MoecusfTmp
11204:             ENDIF
11205:         CATCH TO loc_oErro
11206:             gb_4c_ValidandoUI = .F.
11207:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecusfLostFocus")

*-- Linhas 11230 a 11258:
11230:             ENDIF
11231: 
11232:             gb_4c_ValidandoUI = .T.
11233:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11234:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaTmp")
11235:             gb_4c_ValidandoUI = .F.
11236: 
11237:             IF loc_nR <= 0 OR EOF("cursor_4c_MoedaTmp")
11238:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11239:                 loc_oForm.Caption = "Moedas"
11240:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11241:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11242:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11243:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11244:                 loc_oForm.Show()
11245:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11246:                     loc_oPg.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11247:                     USE IN cursor_4c_BuscaAux
11248:                 ELSE
11249:                     loc_oPg.txt_4c_Moeda.Value = ""
11250:                 ENDIF
11251:                 loc_oForm.Release()
11252:             ENDIF
11253:             IF USED("cursor_4c_MoedaTmp")
11254:                 USE IN cursor_4c_MoedaTmp
11255:             ENDIF
11256:         CATCH TO loc_oErro
11257:             gb_4c_ValidandoUI = .F.
11258:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoedaLostFocus")

*-- Linhas 11281 a 11309:
11281:             ENDIF
11282: 
11283:             gb_4c_ValidandoUI = .T.
11284:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11285:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoepvTmp")
11286:             gb_4c_ValidandoUI = .F.
11287: 
11288:             IF loc_nR <= 0 OR EOF("cursor_4c_MoepvTmp")
11289:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11290:                 loc_oForm.Caption = "Moedas"
11291:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11292:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11293:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11294:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11295:                 loc_oForm.Show()
11296:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11297:                     loc_oPg.txt_4c_Moepv.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11298:                     USE IN cursor_4c_BuscaAux
11299:                 ELSE
11300:                     loc_oPg.txt_4c_Moepv.Value = ""
11301:                 ENDIF
11302:                 loc_oForm.Release()
11303:             ENDIF
11304:             IF USED("cursor_4c_MoepvTmp")
11305:                 USE IN cursor_4c_MoepvTmp
11306:             ENDIF
11307:         CATCH TO loc_oErro
11308:             gb_4c_ValidandoUI = .F.
11309:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoepvLostFocus")

*-- Linhas 11332 a 11360:
11332:             ENDIF
11333: 
11334:             gb_4c_ValidandoUI = .T.
11335:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11336:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoevTmp")
11337:             gb_4c_ValidandoUI = .F.
11338: 
11339:             IF loc_nR <= 0 OR EOF("cursor_4c_MoevTmp")
11340:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11341:                 loc_oForm.Caption = "Moedas"
11342:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11343:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11344:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11345:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11346:                 loc_oForm.Show()
11347:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11348:                     loc_oPg.txt_4c_Moev.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11349:                     USE IN cursor_4c_BuscaAux
11350:                 ELSE
11351:                     loc_oPg.txt_4c_Moev.Value = ""
11352:                 ENDIF
11353:                 loc_oForm.Release()
11354:             ENDIF
11355:             IF USED("cursor_4c_MoevTmp")
11356:                 USE IN cursor_4c_MoevTmp
11357:             ENDIF
11358:         CATCH TO loc_oErro
11359:             gb_4c_ValidandoUI = .F.
11360:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoevLostFocus")

*-- Linhas 11384 a 11412:
11384:             ENDIF
11385: 
11386:             gb_4c_ValidandoUI = .T.
11387:             loc_cSQL = "SELECT Cods, Descs, Acrescs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos<>1"
11388:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtioTmp")
11389:             gb_4c_ValidandoUI = .F.
11390: 
11391:             IF loc_nR <= 0 OR EOF("cursor_4c_FtioTmp")
11392:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11393:                 loc_oForm.Caption = "Feitios"
11394:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11395:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11396:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11397:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos<>1 ORDER BY Cods"
11398:                 loc_oForm.Show()
11399:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11400:                     loc_oPg.txt_4c_Ftio.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11401:                     USE IN cursor_4c_BuscaAux
11402:                 ELSE
11403:                     loc_oPg.txt_4c_Ftio.Value = ""
11404:                     IF USED("cursor_4c_FtioTmp")
11405:                         USE IN cursor_4c_FtioTmp
11406:                     ENDIF
11407:                     THIS.CarregarComposicao()
11408:                     RETURN
11409:                 ENDIF
11410:                 loc_oForm.Release()
11411:             ENDIF
11412:             IF USED("cursor_4c_FtioTmp")

*-- Linhas 11442 a 11470:
11442:             ENDIF
11443: 
11444:             gb_4c_ValidandoUI = .T.
11445:             loc_cSQL = "SELECT Cods, Descs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos=1"
11446:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmkpcTmp")
11447:             gb_4c_ValidandoUI = .F.
11448: 
11449:             IF loc_nR <= 0 OR EOF("cursor_4c_CmkpcTmp")
11450:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11451:                 loc_oForm.Caption = "Feitios de Custo"
11452:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11453:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11454:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11455:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos=1 ORDER BY Cods"
11456:                 loc_oForm.Show()
11457:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11458:                     loc_oPg.txt_4c_Cmkpc.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11459:                     USE IN cursor_4c_BuscaAux
11460:                 ELSE
11461:                     loc_oPg.txt_4c_Cmkpc.Value = ""
11462:                     IF USED("cursor_4c_CmkpcTmp")
11463:                         USE IN cursor_4c_CmkpcTmp
11464:                     ENDIF
11465:                     THIS.CarregarComposicao()
11466:                     RETURN
11467:                 ENDIF
11468:                 loc_oForm.Release()
11469:             ENDIF
11470:             IF USED("cursor_4c_CmkpcTmp")

*-- Linhas 11535 a 11563:
11535:             ENDIF
11536: 
11537:             gb_4c_ValidandoUI = .T.
11538:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11539:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTmp")
11540:             gb_4c_ValidandoUI = .F.
11541: 
11542:             IF loc_nR <= 0 OR EOF("cursor_4c_DescTmp")
11543:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11544:                 loc_oForm.Caption = "Produtos"
11545:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11546:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11547:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11548:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11549:                 loc_oForm.Show()
11550:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11551:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11552:                     IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11553:                         loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11554:                     ENDIF
11555:                     USE IN cursor_4c_BuscaAux
11556:                 ELSE
11557:                     loc_oPg.txt_4c_Desc.Value = ""
11558:                 ENDIF
11559:                 loc_oForm.Release()
11560:             ELSE
11561:                 IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11562:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_DescTmp.CPros)
11563:                 ENDIF

*-- Linhas 11593 a 11621:
11593:             ENDIF
11594: 
11595:             gb_4c_ValidandoUI = .T.
11596:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11597:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatPTmp")
11598:             gb_4c_ValidandoUI = .F.
11599: 
11600:             IF loc_nR <= 0 OR EOF("cursor_4c_MatPTmp")
11601:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11602:                 loc_oForm.Caption = "Material Principal"
11603:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11604:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11605:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11606:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11607:                 loc_oForm.Show()
11608:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11609:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11610:                     IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11611:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11612:                     ENDIF
11613:                     USE IN cursor_4c_BuscaAux
11614:                 ELSE
11615:                     loc_oPg.txt_4c_MatP.Value = ""
11616:                 ENDIF
11617:                 loc_oForm.Release()
11618:             ELSE
11619:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11620:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_MatPTmp.DPros)
11621:                 ENDIF

*-- Linhas 11651 a 11679:
11651:             ENDIF
11652: 
11653:             gb_4c_ValidandoUI = .T.
11654:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11655:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesccpTmp")
11656:             gb_4c_ValidandoUI = .F.
11657: 
11658:             IF loc_nR <= 0 OR EOF("cursor_4c_DesccpTmp")
11659:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11660:                 loc_oForm.Caption = "Sub-Componentes"
11661:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11662:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11663:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11664:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11665:                 loc_oForm.Show()
11666:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11667:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11668:                     IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11669:                         loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11670:                     ENDIF
11671:                     USE IN cursor_4c_BuscaAux
11672:                 ELSE
11673:                     loc_oPg.txt_4c__desccp.Value = ""
11674:                 ENDIF
11675:                 loc_oForm.Release()
11676:             ELSE
11677:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11678:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_DesccpTmp.CPros)
11679:                 ENDIF

*-- Linhas 11709 a 11737:
11709:             ENDIF
11710: 
11711:             gb_4c_ValidandoUI = .T.
11712:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11713:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatsubTmp")
11714:             gb_4c_ValidandoUI = .F.
11715: 
11716:             IF loc_nR <= 0 OR EOF("cursor_4c_MatsubTmp")
11717:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11718:                 loc_oForm.Caption = "Produto Substituto"
11719:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11720:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11721:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11722:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11723:                 loc_oForm.Show()
11724:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11725:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11726:                     IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11727:                         loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11728:                     ENDIF
11729:                     USE IN cursor_4c_BuscaAux
11730:                 ELSE
11731:                     loc_oPg.txt_4c__matsub.Value = ""
11732:                 ENDIF
11733:                 loc_oForm.Release()
11734:             ELSE
11735:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11736:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_MatsubTmp.DPros)
11737:                 ENDIF

*-- Linhas 11761 a 11781:
11761:         ENDIF
11762: 
11763:         TRY
11764:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves) VALUES (" + ;
11765:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID())"
11766:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11767:             IF loc_nR > 0
11768:                 THIS.CarregarComposicao()
11769:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
11770:                     loc_oPg.grd_4c_Compo.SetFocus()
11771:                 ENDIF
11772:             ELSE
11773:                 MsgErro("Erro ao incluir linha na composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoIncluirClick")
11774:             ENDIF
11775:         CATCH TO loc_oErro
11776:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoIncluirClick")
11777:         ENDTRY
11778:     ENDPROC
11779: 
11780:     *--------------------------------------------------------------------------
11781:     * CmdCompoExcluirClick - Botao excluir linha da composicao (grdCompo)

*-- Linhas 11797 a 11817:
11797:             IF EMPTY(loc_cMats)
11798:                 RETURN
11799:             ENDIF
11800:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11801:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11802:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11803:             IF loc_nR > 0
11804:                 THIS.CarregarComposicao()
11805:             ELSE
11806:                 MsgErro("Erro ao excluir linha da composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoExcluirClick")
11807:             ENDIF
11808:         CATCH TO loc_oErro
11809:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoExcluirClick")
11810:         ENDTRY
11811:     ENDPROC
11812: 
11813:     *--------------------------------------------------------------------------
11814:     * CmdCompoAtualizarClick - Botao atualizar/recalcular precos da composicao
11815:     *--------------------------------------------------------------------------
11816:     PROCEDURE CmdCompoAtualizarClick()
11817:         TRY

*-- Linhas 11868 a 11888:
11868:                 MsgErro("Item da composi" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido.", "FormProduto.CmdSubCpIncluirClick")
11869:                 RETURN
11870:             ENDIF
11871:             loc_cSQL = "INSERT INTO sigsubcp (cpros, dtmovs, cidchaves, matsubs) VALUES (" + ;
11872:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + EscaparSQL(loc_cMats) + ")"
11873:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11874:             IF loc_nR > 0
11875:                 THIS.CarregarComposicao()
11876:                 IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
11877:                     loc_oPg.grd_4c_SubCompo.SetFocus()
11878:                 ENDIF
11879:             ELSE
11880:                 MsgErro("Erro ao incluir sub-componente.", "FormProduto.CmdSubCpIncluirClick")
11881:             ENDIF
11882:         CATCH TO loc_oErro
11883:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpIncluirClick")
11884:         ENDTRY
11885:     ENDPROC
11886: 
11887:     *--------------------------------------------------------------------------
11888:     * CmdSubCpExcluirClick - Botao excluir sub-componente (grdsubcp)

*-- Linhas 11903 a 11923:
11903:             IF EMPTY(loc_cMats)
11904:                 RETURN
11905:             ENDIF
11906:             loc_cSQL = "DELETE FROM sigsubcp WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11907:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11908:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11909:             IF loc_nR > 0
11910:                 THIS.CarregarComposicao()
11911:             ELSE
11912:                 MsgErro("Erro ao excluir sub-componente.", "FormProduto.CmdSubCpExcluirClick")
11913:             ENDIF
11914:         CATCH TO loc_oErro
11915:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpExcluirClick")
11916:         ENDTRY
11917:     ENDPROC
11918: 
11919:     *--------------------------------------------------------------------------
11920:     * CmdCalcValsClick - Botao calcular valores de preco/custo
11921:     *--------------------------------------------------------------------------
11922:     PROCEDURE CmdCalcValsClick()
11923:         TRY

*-- Linhas 11941 a 11963:
11941: 
11942:         TRY
11943:             *-- Busca peso calculado a partir da composicao
11944:             loc_cSQL = "SELECT SUM(c.qtds * p.pesobs) AS peso_calc " + ;
11945:                        "FROM SIGPRCPO c " + ;
11946:                        "LEFT JOIN SigCdPro p ON RTRIM(c.mats) = RTRIM(p.cpros) " + ;
11947:                        "WHERE RTRIM(c.cpros) = " + EscaparSQL(loc_cCpros)
11948:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesoMTmp")
11949:             IF loc_nR > 0 AND !EOF("cursor_4c_PesoMTmp")
11950:                 IF PEMSTATUS(loc_oPg, "txt_4c_Pesom", 5)
11951:                     loc_oPg.txt_4c_Pesom.Value = NVL(cursor_4c_PesoMTmp.peso_calc, 0)
11952:                 ENDIF
11953:             ENDIF
11954:             IF USED("cursor_4c_PesoMTmp")
11955:                 USE IN cursor_4c_PesoMTmp
11956:             ENDIF
11957:         CATCH TO loc_oErro
11958:             MsgErro(loc_oErro.Message, "FormProduto.CmdPesoMClick")
11959:         ENDTRY
11960:     ENDPROC
11961: 
11962:     *--------------------------------------------------------------------------
11963:     * CustosGrd_AfterRowColChange - Grid custos: ao mudar linha/coluna

*-- Linhas 11977 a 11999:
11977:                 *-- Buscar descricao do grupo com base no material
11978:                 loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
11979:                 IF !EMPTY(loc_cMats) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
11980:                     loc_cSQL = "SELECT g.dgrus FROM SigCdPro p " + ;
11981:                                "INNER JOIN SigCdGrp g ON RTRIM(p.cgrus) = RTRIM(g.cgrus) " + ;
11982:                                "WHERE RTRIM(p.cpros) = " + EscaparSQL(loc_cMats)
11983:                     gb_4c_ValidandoUI = .T.
11984:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoTmpC")
11985:                     gb_4c_ValidandoUI = .F.
11986:                     IF loc_nR > 0 AND !EOF("cursor_4c_GrupoTmpC")
11987:                         IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
11988:                             loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(NVL(cursor_4c_GrupoTmpC.dgrus, ""))
11989:                         ENDIF
11990:                     ENDIF
11991:                     IF USED("cursor_4c_GrupoTmpC")
11992:                         USE IN cursor_4c_GrupoTmpC
11993:                     ENDIF
11994:                 ELSE
11995:                     IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
11996:                         loc_oPg.txt_4c_DGruCompos.Value = ""
11997:                     ENDIF
11998:                 ENDIF
11999:             ENDIF

*-- Linhas 12028 a 12084:
12028:             CASE par_nColIndex = 4
12029:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
12030:                 IF !EMPTY(loc_cGrupos)
12031:                     loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = " + EscaparSQL(loc_cGrupos)
12032:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfDesc")
12033:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfDesc")
12034:                         REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfDesc.descrs, ""))
12035:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12036:                             loc_oPg.grd_4c_Consulta.Refresh()
12037:                         ENDIF
12038:                     ELSE
12039:                         THIS.AbrirLookupConsultaFase()
12040:                     ENDIF
12041:                     IF USED("cursor_4c_PrfDesc")
12042:                         USE IN cursor_4c_PrfDesc
12043:                     ENDIF
12044:                 ENDIF
12045: 
12046:             *-- Coluna 5 (Descricao fase): busca grupos em SigCdPrf por descricao
12047:             CASE par_nColIndex = 5
12048:                 loc_cDcompos = ALLTRIM(NVL(cursor_4c_Consulta.dcompos, ""))
12049:                 IF !EMPTY(loc_cDcompos)
12050:                     loc_cSQL = "SELECT TOP 1 Codigos AS grupos, Descrs AS descrs FROM SigCdGcr WHERE RTRIM(Descrs) = " + EscaparSQL(loc_cDcompos)
12051:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfGrp")
12052:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfGrp")
12053:                         REPLACE cursor_4c_Consulta.grupos  WITH ALLTRIM(NVL(cursor_4c_PrfGrp.grupos, ""))
12054:                         REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfGrp.descrs, ""))
12055:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12056:                             loc_oPg.grd_4c_Consulta.Refresh()
12057:                         ENDIF
12058:                     ENDIF
12059:                     IF USED("cursor_4c_PrfGrp")
12060:                         USE IN cursor_4c_PrfGrp
12061:                     ENDIF
12062:                 ENDIF
12063: 
12064:             *-- Coluna 8 (Cat): busca descricao em SigCdCat
12065:             CASE par_nColIndex = 8
12066:                 loc_cCats = ALLTRIM(NVL(cursor_4c_Consulta.cats, ""))
12067:                 IF !EMPTY(loc_cCats)
12068:                     loc_cSQL = "SELECT TOP 1 descs FROM SigCdCat WHERE RTRIM(cods) = " + EscaparSQL(loc_cCats)
12069:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CatDesc")
12070:                     IF loc_nR > 0 AND !EOF("cursor_4c_CatDesc")
12071:                         REPLACE cursor_4c_Consulta.dscgrp WITH ALLTRIM(NVL(cursor_4c_CatDesc.descs, ""))
12072:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12073:                             loc_oPg.grd_4c_Consulta.Refresh()
12074:                         ENDIF
12075:                     ELSE
12076:                         THIS.AbrirLookupConsultaCat()
12077:                     ENDIF
12078:                     IF USED("cursor_4c_CatDesc")
12079:                         USE IN cursor_4c_CatDesc
12080:                     ENDIF
12081:                 ENDIF
12082: 
12083:             ENDCASE
12084:         CATCH TO loc_oErro

*-- Linhas 12213 a 12233:
12213:                 ENDIF
12214:             ENDIF
12215: 
12216:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves, tipos) VALUES (" + ;
12217:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + TRANSFORM(loc_nTipo) + ")"
12218:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12219:             IF loc_nR > 0
12220:                 THIS.CarregarCustos()
12221:                 IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
12222:                     loc_oPg.grd_4c_CompoCusto.SetFocus()
12223:                 ENDIF
12224:             ELSE
12225:                 MsgErro("Erro ao incluir linha no custo.", "FormProduto.CmdCustoIncluirClick")
12226:             ENDIF
12227:         CATCH TO loc_oErro
12228:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoIncluirClick")
12229:         ENDTRY
12230:     ENDPROC
12231: 
12232:     *--------------------------------------------------------------------------
12233:     * CmdCustoExcluirClick - Botao excluir linha do grid de custo

*-- Linhas 12258 a 12278:
12258:                 RETURN
12259:             ENDIF
12260: 
12261:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCpros) + ;
12262:                        " AND RTRIM(mats) = " + EscaparSQL(loc_cMats)
12263:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12264:             IF loc_nR > 0
12265:                 THIS.CarregarCustos()
12266:             ELSE
12267:                 MsgErro("Erro ao excluir linha do custo.", "FormProduto.CmdCustoExcluirClick")
12268:             ENDIF
12269:         CATCH TO loc_oErro
12270:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoExcluirClick")
12271:         ENDTRY
12272:     ENDPROC
12273: 
12274:     *==========================================================================
12275:     * METODOS DA ABA FASES (Tab 7 - PgDadosFaseP)
12276:     *==========================================================================
12277: 
12278:     *--------------------------------------------------------------------------

*-- Linhas 12304 a 12348:
12304:             *-- Carregar imagem FigProcs da fase atual (campo binario em SigCdPrf)
12305:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND loc_nOrdems > 0
12306:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
12307:                     SELECT TOP 1 FigProcs FROM SigCdPrf
12308:                     WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12309:                     AND ordems = <<loc_nOrdems>>
12310:                 ENDTEXT
12311:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigFase")
12312:                 IF loc_nR > 0 AND !EOF("cursor_4c_FigFase")
12313:                     IF !EMPTY(NVL(cursor_4c_FigFase.FigProcs, ""))
12314:                         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12315:                         IF (STRTOFILE(cursor_4c_FigFase.FigProcs, loc_cArquivo) > 0)
12316:                             IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
12317:                                 loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
12318:                                 loc_oPg.img_4c_ImgFigJpg.Visible = .T.
12319:                             ENDIF
12320:                         ENDIF
12321:                     ENDIF
12322:                 ENDIF
12323:                 IF USED("cursor_4c_FigFase")
12324:                     USE IN cursor_4c_FigFase
12325:                 ENDIF
12326:             ENDIF
12327: 
12328:             *-- Carregar descricao e observacao da fase (SigCdGcr)
12329:             IF !EMPTY(loc_cGrupos) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
12330:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
12331:                     SELECT TOP 1 Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cGrupos)>>)
12332:                 ENDTEXT
12333:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FaseDesc")
12334:                 IF loc_nR > 0 AND !EOF("cursor_4c_FaseDesc")
12335:                     IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
12336:                         loc_oPg.txt_4c_DescFase.Value = ALLTRIM(NVL(cursor_4c_FaseDesc.Descrs, ""))
12337:                     ENDIF
12338:                 ELSE
12339:                     IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
12340:                         loc_oPg.txt_4c_DescFase.Value = ""
12341:                     ENDIF
12342:                 ENDIF
12343:                 IF USED("cursor_4c_FaseDesc")
12344:                     USE IN cursor_4c_FaseDesc
12345:                 ENDIF
12346:             ELSE
12347:                 IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
12348:                     loc_oPg.txt_4c_DescFase.Value = ""

*-- Linhas 12385 a 12405:
12385: 
12386:             *-- Carregar imagem FigJpgs do produto matriz (SigCdPro)
12387:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12388:                 SELECT TOP 1 FigJpgs FROM SigCdPro WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
12389:             ENDTEXT
12390:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigBorr")
12391:             IF loc_nR > 0 AND !EOF("cursor_4c_FigBorr")
12392:                 loc_cFigB64 = NVL(cursor_4c_FigBorr.FigJpgs, "")
12393:                 IF !EMPTY(loc_cFigB64)
12394:                     *-- Converter de Base64 para binario
12395:                     LOCAL loc_cFigBin
12396:                     loc_cFigBin = STRCONV( ;
12397:                         STRTRAN(STRTRAN(STRTRAN(loc_cFigB64, ;
12398:                             "data:image/png;base64,", ""), ;
12399:                             "data:image/jpeg;base64,", ""), ;
12400:                             "data:image/jpg;base64,", ""), 14)
12401:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12402:                     IF STRTOFILE(loc_cFigBin, loc_cArquivo) > 0
12403:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
12404:                             loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
12405:                             loc_oPg.img_4c_ImgBorracha.Visible = .T.

*-- Linhas 12459 a 12479:
12459:         ENDIF
12460:         TRY
12461:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12462:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
12463:             ENDTEXT
12464:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCorFas")
12465:             IF loc_nR <= 0 OR EOF("cursor_4c_VCorFas")
12466:                 THIS.AbrirLookupCorFas()
12467:             ELSE
12468:                 THIS.this_oBusinessObject.this_cCodcors = loc_cCod
12469:             ENDIF
12470:             IF USED("cursor_4c_VCorFas")
12471:                 USE IN cursor_4c_VCorFas
12472:             ENDIF
12473:         CATCH TO loc_oErro
12474:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodcorsLostFocus")
12475:         ENDTRY
12476:     ENDPROC
12477: 
12478:     *--------------------------------------------------------------------------
12479:     * AbrirLookupCorFas - Lookup Cor para a aba Fases

*-- Linhas 12547 a 12567:
12547:         ENDIF
12548:         TRY
12549:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12550:                 SELECT TOP 1 Cods FROM SigCdTam WHERE Cods = <<EscaparSQL(loc_cCod)>>
12551:             ENDTEXT
12552:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VTamFas")
12553:             IF loc_nR <= 0 OR EOF("cursor_4c_VTamFas")
12554:                 THIS.AbrirLookupTamanhoFas()
12555:             ELSE
12556:                 THIS.this_oBusinessObject.this_cCodtams = loc_cCod
12557:             ENDIF
12558:             IF USED("cursor_4c_VTamFas")
12559:                 USE IN cursor_4c_VTamFas
12560:             ENDIF
12561:         CATCH TO loc_oErro
12562:             MsgErro("Erro ao validar tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodtamsLostFocus")
12563:         ENDTRY
12564:     ENDPROC
12565: 
12566:     *--------------------------------------------------------------------------
12567:     * AbrirLookupTamanhoFas - Lookup Tamanho para a aba Fases

*-- Linhas 12637 a 12657:
12637:         ENDIF
12638:         TRY
12639:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12640:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
12641:             ENDTEXT
12642:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcbFas")
12643:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcbFas")
12644:                 IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
12645:                     loc_oPg.txt_4c_DacbsFas.Value = ALLTRIM(cursor_4c_VAcbFas.descrs)
12646:                 ENDIF
12647:                 THIS.this_oBusinessObject.this_cCodacbs = loc_cCod
12648:             ELSE
12649:                 THIS.AbrirLookupAcabamentoFas()
12650:             ENDIF
12651:             IF USED("cursor_4c_VAcbFas")
12652:                 USE IN cursor_4c_VAcbFas
12653:             ENDIF
12654:         CATCH TO loc_oErro
12655:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodacbsLostFocus")
12656:         ENDTRY
12657:     ENDPROC

*-- Linhas 12737 a 12757:
12737:         ENDIF
12738:         TRY
12739:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12740:                 SELECT TOP 1 conquilhas FROM SigCdCnq WHERE RTRIM(conquilhas) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12741:             ENDTEXT
12742:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCnq")
12743:             IF loc_nR <= 0 OR EOF("cursor_4c_VCnq")
12744:                 THIS.AbrirLookupConquilha()
12745:             ELSE
12746:                 THIS.this_oBusinessObject.this_cConquilhas = loc_cCod
12747:             ENDIF
12748:             IF USED("cursor_4c_VCnq")
12749:                 USE IN cursor_4c_VCnq
12750:             ENDIF
12751:         CATCH TO loc_oErro
12752:             MsgErro("Erro ao validar conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_ConquilhaLostFocus")
12753:         ENDTRY
12754:     ENDPROC
12755: 
12756:     *--------------------------------------------------------------------------
12757:     * AbrirLookupConquilha - Lookup para campo Conquilha (SigCdCnq)

*-- Linhas 12819 a 12839:
12819:         ENDIF
12820:         TRY
12821:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12822:                 SELECT TOP 1 codgarras FROM SigCdGar WHERE RTRIM(codgarras) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12823:             ENDTEXT
12824:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGar")
12825:             IF loc_nR <= 0 OR EOF("cursor_4c_VGar")
12826:                 THIS.AbrirLookupGarra()
12827:             ELSE
12828:                 THIS.this_oBusinessObject.this_cCodgarras = loc_cCod
12829:             ENDIF
12830:             IF USED("cursor_4c_VGar")
12831:                 USE IN cursor_4c_VGar
12832:             ENDIF
12833:         CATCH TO loc_oErro
12834:             MsgErro("Erro ao validar garra:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_GarraLostFocus")
12835:         ENDTRY
12836:     ENDPROC
12837: 
12838:     *--------------------------------------------------------------------------
12839:     * AbrirLookupGarra - Lookup para campo Garra (SigCdGar)

*-- Linhas 12892 a 12928:
12892:         TRY
12893:             *-- Calcular proximo numero de ordem
12894:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12895:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
12896:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12897:             ENDTEXT
12898:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdem")
12899:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdem")
12900:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdem.proximo, 1)
12901:             ELSE
12902:                 loc_nProxOrdem = 1
12903:             ENDIF
12904:             IF USED("cursor_4c_MaxOrdem")
12905:                 USE IN cursor_4c_MaxOrdem
12906:             ENDIF
12907: 
12908:             *-- Inserir nova fase
12909:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12910:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
12911:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, '', 0, '', '')
12912:             ENDTEXT
12913:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12914:             IF loc_nR > 0
12915:                 THIS.CarregarFases()
12916:                 LOCAL loc_oPg7
12917:                 loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
12918:                 IF PEMSTATUS(loc_oPg7, "grd_4c_Fases", 5)
12919:                     loc_oPg7.grd_4c_Fases.SetFocus()
12920:                 ENDIF
12921:             ELSE
12922:                 MsgErro("Erro ao inserir fase.", "FormProduto.BtnInserirFaseClick")
12923:             ENDIF
12924:         CATCH TO loc_oErro
12925:             MsgErro("Erro ao inserir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirFaseClick")
12926:         ENDTRY
12927:     ENDPROC
12928: 

*-- Linhas 12956 a 12978:
12956: 
12957:         TRY
12958:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12959:                 DELETE FROM SigCdPrf
12960:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12961:                 AND ordems = <<loc_nOrdems>>
12962:             ENDTEXT
12963:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12964:             IF loc_nR > 0
12965:                 THIS.CarregarFases()
12966:             ELSE
12967:                 MsgErro("Erro ao excluir fase.", "FormProduto.BtnExcluirFaseClick")
12968:             ENDIF
12969:         CATCH TO loc_oErro
12970:             MsgErro("Erro ao excluir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirFaseClick")
12971:         ENDTRY
12972:     ENDPROC
12973: 
12974:     *--------------------------------------------------------------------------
12975:     * BtnAlternativaFaseClick - Inserir fase alternativa (alternativa da fase atual)
12976:     *--------------------------------------------------------------------------
12977:     PROCEDURE BtnAlternativaFaseClick()
12978:         LOCAL loc_cCpros, loc_cGrupoAtual, loc_cSQL, loc_nR, loc_nProxOrdem

*-- Linhas 13002 a 13038:
13002:         TRY
13003:             *-- Calcular proximo numero de ordem
13004:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13005:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
13006:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
13007:             ENDTEXT
13008:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdAlt")
13009:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdAlt")
13010:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdAlt.proximo, 1)
13011:             ELSE
13012:                 loc_nProxOrdem = 1
13013:             ENDIF
13014:             IF USED("cursor_4c_MaxOrdAlt")
13015:                 USE IN cursor_4c_MaxOrdAlt
13016:             ENDIF
13017: 
13018:             *-- Inserir fase alternativa copiando o grupo da fase atual
13019:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13020:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
13021:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, <<EscaparSQL(loc_cGrupoAtual)>>, 0, '', '')
13022:             ENDTEXT
13023:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13024:             IF loc_nR > 0
13025:                 THIS.CarregarFases()
13026:             ELSE
13027:                 MsgErro("Erro ao inserir fase alternativa.", "FormProduto.BtnAlternativaFaseClick")
13028:             ENDIF
13029:         CATCH TO loc_oErro
13030:             MsgErro("Erro ao inserir alternativa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnAlternativaFaseClick")
13031:         ENDTRY
13032:     ENDPROC
13033: 
13034:     *--------------------------------------------------------------------------
13035:     * CmdFichaClick - Imprimir ficha tecnica das fases do produto
13036:     *--------------------------------------------------------------------------
13037:     PROCEDURE CmdFichaClick()
13038:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oBO

*-- Linhas 13050 a 13074:
13050:             IF USED("CsCabecalho")
13051:                 USE IN CsCabecalho
13052:             ENDIF
13053:             CREATE CURSOR CsCabecalho ( ;
13054:                 _NmEmp  C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
13055:                 _cGrus  C(03), _dGrus C(20), _sGrus C(06), _sDesc C(20), ;
13056:                 _cLinh  C(10), _dLinh C(40), _cGVen C(10), _dGVen C(40), ;
13057:                 _nPeso  N(9,2), _DtIni D(08), _DtFin D(08), _TExec C(15), _cMode C(10))
13058: 
13059:             INSERT INTO CsCabecalho ;
13060:                 (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _dGrus, _cMode) ;
13061:                 VALUES( ;
13062:                     go_4c_Sistema.cEmpresa, ;
13063:                     "Ficha T" + CHR(233) + "cnica de Fases", ;
13064:                     loc_cCpros, ;
13065:                     loc_oBO.this_cDpros, ;
13066:                     loc_oBO.this_cCgrus, ;
13067:                     THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus"), ;
13068:                     THIS.this_cModoAtual)
13069: 
13070:             MsgInfo("Ficha t" + CHR(233) + "cnica gerada. Configure o relat" + CHR(243) + "rio RelFase.frx para impress" + CHR(227) + "o.", "Ficha T" + CHR(233) + "cnica")
13071: 
13072:             IF USED("CsCabecalho")
13073:                 USE IN CsCabecalho
13074:             ENDIF

*-- Linhas 13107 a 13147:
13107:         TRY
13108:             *-- Verificar se ja tem imagem
13109:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13110:                 SELECT TOP 1 CASE WHEN FigProcs IS NULL OR LEN(RTRIM(FigProcs))=0 THEN 0 ELSE 1 END AS temFig
13111:                 FROM SigCdPrf
13112:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13113:             ENDTEXT
13114:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerFig")
13115:             LOCAL loc_lTemFig
13116:             loc_lTemFig = .F.
13117:             IF loc_nR > 0 AND !EOF("cursor_4c_VerFig")
13118:                 loc_lTemFig = (cursor_4c_VerFig.temFig > 0)
13119:             ENDIF
13120:             IF USED("cursor_4c_VerFig")
13121:                 USE IN cursor_4c_VerFig
13122:             ENDIF
13123: 
13124:             IF loc_lTemFig
13125:                 *-- Oferecer opcoes: substituir ou remover
13126:                 loc_lConfirma = MsgConfirma("Esta fase j" + CHR(225) + " possui imagem. Deseja remov" + CHR(234) + "-la?", "Imagem da Fase")
13127:                 IF loc_lConfirma
13128:                     TEXT TO loc_cSQL TEXTMERGE NOSHOW
13129:                         UPDATE SigCdPrf SET FigProcs = NULL
13130:                         WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13131:                     ENDTEXT
13132:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13133:                     IF loc_nR > 0
13134:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
13135:                             loc_oPg.img_4c_ImgFigJpg.Picture = ""
13136:                             loc_oPg.img_4c_ImgFigJpg.Visible = .F.
13137:                         ENDIF
13138:                         MsgInfo("Imagem removida.", "FormProduto")
13139:                     ENDIF
13140:                     RETURN
13141:                 ENDIF
13142:             ENDIF
13143: 
13144:             *-- Selecionar arquivo de imagem
13145:             loc_cFig = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar Imagem da Fase:")
13146:             IF EMPTY(loc_cFig) OR !FILE(loc_cFig)
13147:                 RETURN

*-- Linhas 13156 a 13177:
13156:             ENDIF
13157: 
13158:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13159:                 UPDATE SigCdPrf SET FigProcs = ?loc_cBinImg
13160:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13161:             ENDTEXT
13162:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13163:             IF loc_nR > 0
13164:                 *-- Exibir imagem carregada
13165:                 loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
13166:                 STRTOFILE(loc_cBinImg, loc_cArquivo)
13167:                 IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
13168:                     loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
13169:                     loc_oPg.img_4c_ImgFigJpg.Visible = .T.
13170:                 ENDIF
13171:             ELSE
13172:                 MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFiguraClick")
13173:             ENDIF
13174: 
13175:         CATCH TO loc_oErro
13176:             MsgErro("Erro ao carregar imagem:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFiguraClick")
13177:         ENDTRY

*-- Linhas 13219 a 13240:
13219:             loc_cB64 = "data:image/jpeg;base64," + STRCONV(loc_cBinImg, 13)
13220: 
13221:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13222:                 UPDATE SigCdPro SET FigJpgs = ?loc_cB64
13223:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
13224:             ENDTEXT
13225:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13226:             IF loc_nR > 0
13227:                 *-- Exibir imagem
13228:                 loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
13229:                 STRTOFILE(loc_cBinImg, loc_cArquivo)
13230:                 IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
13231:                     loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
13232:                     loc_oPg.img_4c_ImgBorracha.Visible = .T.
13233:                 ENDIF
13234:             ELSE
13235:                 MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFigCamClick")
13236:             ENDIF
13237: 
13238:         CATCH TO loc_oErro
13239:             MsgErro("Erro ao carregar imagem de borracha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFigCamClick")
13240:         ENDTRY

*-- Linhas 13260 a 13281:
13260:         TRY
13261:             *-- Inserir nova linha vazia em SigPrMtz com cIdChaves unico
13262:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13263:                 INSERT INTO SigPrMtz (cpros, cidchaves, cmats, qtds)
13264:                 VALUES (<<EscaparSQL(loc_cCpros)>>, NEWID(), '', 0)
13265:             ENDTEXT
13266:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13267:             IF loc_nR > 0
13268:                 THIS.CarregarMatrizes()
13269:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13270:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
13271:                     loc_oPg.grd_4c_Matrizes.SetFocus()
13272:                 ENDIF
13273:             ELSE
13274:                 MsgErro("Erro ao inserir matriz.", "FormProduto.BtnInserirMatrizClick")
13275:             ENDIF
13276:         CATCH TO loc_oErro
13277:             MsgErro("Erro ao inserir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirMatrizClick")
13278:         ENDTRY
13279:     ENDPROC
13280: 
13281:     *--------------------------------------------------------------------------

*-- Linhas 13308 a 13329:
13308: 
13309:         TRY
13310:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13311:                 DELETE FROM SigPrMtz
13312:                 WHERE RTRIM(cidchaves) = RTRIM(<<EscaparSQL(loc_cCidChaves)>>)
13313:             ENDTEXT
13314:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13315:             IF loc_nR > 0
13316:                 THIS.CarregarMatrizes()
13317:             ELSE
13318:                 MsgErro("Erro ao excluir matriz.", "FormProduto.BtnExcluirMatrizClick")
13319:             ENDIF
13320:         CATCH TO loc_oErro
13321:             MsgErro("Erro ao excluir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirMatrizClick")
13322:         ENDTRY
13323:     ENDPROC
13324: 
13325:     *--------------------------------------------------------------------------
13326:     * DesignerGrd_AfterRowColChange - Grid tarefas: ao navegar linha/coluna
13327:     * Atualiza txt_4c_ObsTarefas com descricao da tarefa da linha atual
13328:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
13329:     *--------------------------------------------------------------------------

*-- Linhas 13338 a 13356:
13338: 
13339:                 *-- Buscar descricao no cursor de tarefas
13340:                 IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas") AND !EMPTY(loc_cCodTarefa)
13341:                     SELECT cursor_4c_Tarefas
13342:                     LOCATE FOR ALLTRIM(CodCads) = loc_cCodTarefa
13343:                     IF !EOF("cursor_4c_Tarefas")
13344:                         loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13345:                     ENDIF
13346:                 ENDIF
13347: 
13348:                 IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13349:                     loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13350:                     loc_oPg.txt_4c_ObsTarefas.Refresh()
13351:                 ENDIF
13352:             ENDIF
13353:         CATCH TO loc_oErro
13354:             MsgErro(loc_oErro.Message, "FormProduto.DesignerGrd_AfterRowColChange")
13355:         ENDTRY
13356:     ENDPROC

*-- Linhas 13460 a 13478:
13460:             loc_cCodTarefa = ""
13461:             loc_cDesTarefa = ""
13462: 
13463:             SELECT cursor_4c_Tarefas
13464:             LOCATE FOR ALLTRIM(CodCads) = loc_cValor
13465:             IF !EOF("cursor_4c_Tarefas")
13466:                 loc_lEncontrou = .T.
13467:                 loc_cCodTarefa = ALLTRIM(cursor_4c_Tarefas.CodCads)
13468:                 loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13469:             ENDIF
13470: 
13471:             *-- Atualizar descricao se encontrou; limpar se nao encontrou
13472:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13473:                 IF loc_lEncontrou
13474:                     IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13475:                         loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13476:                     ENDIF
13477:                 ELSE
13478:                     MsgAviso("C" + CHR(243) + "digo de tarefa n" + CHR(227) + "o encontrado.", "Tarefa Designer")

