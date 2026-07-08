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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (13624 linhas total):

*-- Linhas 526 a 544:
526:             .Width             = 940
527:             .Height            = 395
528:             .ReadOnly          = .T.
529:             .DeleteMark        = .F.
530:             .RecordMark        = .F.
531:             .ScrollBars        = 3
532:             .GridLines         = 3
533:             .ColumnCount       = 7
534:             .AllowHeaderSizing = .T.
535:             .Visible           = .T.
536:         ENDWITH
537:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdLista_DblClick")
538: 
539:         THIS.TornarControlesVisiveis(loc_oPagina)
540:     ENDPROC
541: 
542:     *--------------------------------------------------------------------------
543:     * ConfigurarPaginaDados - Configura Page2 (Dados do Produto)
544:     * Legado: Optiongroup1 top=5->34, pgframeDados top=-54->-54

*-- Linhas 2784 a 2802:
2784:             .Width       = 229
2785:             .Height      = 107
2786:             .ReadOnly    = .T.
2787:             .DeleteMark  = .F.
2788:             .RecordMark  = .F.
2789:             .ScrollBars  = 3
2790:             .GridLines   = 3
2791:             .ColumnCount = 3
2792:             .FontName    = "Verdana"
2793:             .FontSize    = 8
2794:             .Visible     = .T.
2795:         ENDWITH
2796:         WITH loc_oPg.grd_4c_GrupoCompo
2797:             .Column1.Header1.Caption = "Grupo"
2798:             .Column1.Width = 70
2799:             .Column2.Header1.Caption = "Total"
2800:             .Column2.Width = 95
2801:             .Column3.Header1.Caption = "Moe"
2802:             .Column3.Width = 50

*-- Linhas 2811 a 2829:
2811:             .Width       = 943
2812:             .Height      = 147
2813:             .ReadOnly    = .T.
2814:             .DeleteMark  = .F.
2815:             .RecordMark  = .F.
2816:             .ScrollBars  = 3
2817:             .GridLines   = 3
2818:             .ColumnCount = 14
2819:             .FontName    = "Verdana"
2820:             .FontSize    = 8
2821:             .Visible     = .T.
2822:         ENDWITH
2823:         WITH loc_oPg.grd_4c_Compo
2824:             .Column1.Header1.Caption  = "Material"
2825:             .Column1.Width  = 90
2826:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2827:             .Column2.Width  = 190
2828:             .Column3.Header1.Caption  = "Un"
2829:             .Column3.Width  = 35

*-- Linhas 2860 a 2878:
2860:             .Width       = 943
2861:             .Height      = 83
2862:             .ReadOnly    = .T.
2863:             .DeleteMark  = .F.
2864:             .RecordMark  = .F.
2865:             .ScrollBars  = 3
2866:             .GridLines   = 3
2867:             .ColumnCount = 15
2868:             .FontName    = "Verdana"
2869:             .FontSize    = 8
2870:             .Visible     = .T.
2871:         ENDWITH
2872:         WITH loc_oPg.grd_4c_SubCompo
2873:             .Column1.Header1.Caption  = "Material"
2874:             .Column1.Width  = 80
2875:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2876:             .Column2.Width  = 160
2877:             .Column3.Header1.Caption  = "Un"
2878:             .Column3.Width  = 35

*-- Linhas 4070 a 4142:
4070:         *-- Criar cursors placeholder para os grids (evitar erro de RecordSource vazio)
4071:         IF !USED("cursor_4c_Compo")
4072:             SET NULL ON
4073:             CREATE CURSOR cursor_4c_Compo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), compos C(10))
4074:             SET NULL OFF
4075:         ENDIF
4076:         loc_oPg.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
4077:         WITH loc_oPg.grd_4c_Compo
4078:             .Column1.ControlSource  = "cursor_4c_Compo.mats"
4079:             .Column2.ControlSource  = "cursor_4c_Compo.dcompos"
4080:             .Column3.ControlSource  = "cursor_4c_Compo.unicompos"
4081:             .Column4.ControlSource  = "cursor_4c_Compo.pcompos"
4082:             .Column5.ControlSource  = "cursor_4c_Compo.qtds"
4083:             .Column6.ControlSource  = "cursor_4c_Compo.totas"
4084:             .Column7.ControlSource  = "cursor_4c_Compo.moeds"
4085:             .Column8.ControlSource  = "cursor_4c_Compo.obscompos"
4086:             .Column9.ControlSource  = "cursor_4c_Compo.etiqs"
4087:             .Column10.ControlSource = "cursor_4c_Compo.qtscons"
4088:             .Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
4089:             .Column12.ControlSource = "cursor_4c_Compo.cunips"
4090:             .Column13.ControlSource = "cursor_4c_Compo.ordems"
4091:             .Column14.ControlSource = "cursor_4c_Compo.compos"
4092:         ENDWITH
4093: 
4094:         IF !USED("cursor_4c_SubCompo")
4095:             SET NULL ON
4096:             CREATE CURSOR cursor_4c_SubCompo (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3), ordems N(2,0), matsubs C(14), codtams C(4))
4097:             SET NULL OFF
4098:         ENDIF
4099:         loc_oPg.grd_4c_SubCompo.RecordSource = "cursor_4c_SubCompo"
4100:         WITH loc_oPg.grd_4c_SubCompo
4101:             .Column1.ControlSource  = "cursor_4c_SubCompo.mats"
4102:             .Column2.ControlSource  = "cursor_4c_SubCompo.dcompos"
4103:             .Column3.ControlSource  = "cursor_4c_SubCompo.unicompos"
4104:             .Column4.ControlSource  = "cursor_4c_SubCompo.pcompos"
4105:             .Column5.ControlSource  = "cursor_4c_SubCompo.qtds"
4106:             .Column6.ControlSource  = "cursor_4c_SubCompo.totas"
4107:             .Column7.ControlSource  = "cursor_4c_SubCompo.moeds"
4108:             .Column8.ControlSource  = "cursor_4c_SubCompo.obscompos"
4109:             .Column9.ControlSource  = "cursor_4c_SubCompo.etiqs"
4110:             .Column10.ControlSource = "cursor_4c_SubCompo.qtscons"
4111:             .Column11.ControlSource = "cursor_4c_SubCompo.qtdcvs"
4112:             .Column12.ControlSource = "cursor_4c_SubCompo.cunips"
4113:             .Column13.ControlSource = "cursor_4c_SubCompo.ordems"
4114:             .Column14.ControlSource = "cursor_4c_SubCompo.matsubs"
4115:             .Column15.ControlSource = "cursor_4c_SubCompo.codtams"
4116:         ENDWITH
4117: 
4118:         IF !USED("cursor_4c_GrupoCompo")
4119:             SET NULL ON
4120:             CREATE CURSOR cursor_4c_GrupoCompo (grupos C(10), totas N(11,3), moeds C(3))
4121:             SET NULL OFF
4122:         ENDIF
4123:         loc_oPg.grd_4c_GrupoCompo.RecordSource = "cursor_4c_GrupoCompo"
4124:         WITH loc_oPg.grd_4c_GrupoCompo
4125:             .Column1.ControlSource = "cursor_4c_GrupoCompo.grupos"
4126:             .Column2.ControlSource = "cursor_4c_GrupoCompo.totas"
4127:             .Column3.ControlSource = "cursor_4c_GrupoCompo.moeds"
4128:         ENDWITH
4129:     ENDPROC
4130: 
4131:     *--------------------------------------------------------------------------
4132:     * ConfigurarTabCustos - Aba 3: Custo da composicao (pgCusto)
4133:     * Legado: pgframeDados.pgCusto (grdCompo 12-col, cmbTipos, cmdgCompo)
4134:     * FASE 9: implementacao completa com BINDEVENTs e botoes
4135:     *--------------------------------------------------------------------------
4136:     PROTECTED PROCEDURE ConfigurarTabCustos()
4137:         LOCAL loc_oPg
4138:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3
4139: 
4140:         *-- Label "Tipo :" (top=159, left=112)
4141:         loc_oPg.AddObject("lbl_4c_TipoCusto", "Label")
4142:         WITH loc_oPg.lbl_4c_TipoCusto

*-- Linhas 4181 a 4199:
4181:             .Width       = 813
4182:             .Height      = 230
4183:             .ReadOnly    = .F.
4184:             .DeleteMark  = .F.
4185:             .RecordMark  = .F.
4186:             .ScrollBars  = 3
4187:             .GridLines   = 3
4188:             .ColumnCount = 12
4189:             .FontName    = "Verdana"
4190:             .FontSize    = 8
4191:             .Visible     = .T.
4192:         ENDWITH
4193:         WITH loc_oPg.grd_4c_CompoCusto
4194:             .Column1.Header1.Caption  = "Item"
4195:             .Column1.Width  = 80
4196:             .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4197:             .Column2.Width  = 180
4198:             .Column3.Header1.Caption  = "Un"
4199:             .Column3.Width  = 35

*-- Linhas 4356 a 4424:
4356:             .Width       = 195
4357:             .Height      = 141
4358:             .ReadOnly    = .T.
4359:             .DeleteMark  = .F.
4360:             .RecordMark  = .F.
4361:             .ScrollBars  = 3
4362:             .GridLines   = 3
4363:             .ColumnCount = 3
4364:             .FontName    = "Verdana"
4365:             .FontSize    = 8
4366:             .Visible     = .T.
4367:         ENDWITH
4368:         WITH loc_oPg.grd_4c_GrupoCompo2
4369:             .Column1.Header1.Caption = "Grp"
4370:             .Column1.Width = 55
4371:             .Column2.Header1.Caption = "Total"
4372:             .Column2.Width = 100
4373:             .Column3.Header1.Caption = "Moe"
4374:             .Column3.Width = 35
4375:         ENDWITH
4376: 
4377:         *-- Cursor placeholder para grd_4c_CompoCusto
4378:         IF !USED("cursor_4c_CompoCusto")
4379:             SET NULL ON
4380:             CREATE CURSOR cursor_4c_CompoCusto (mats C(14), dcompos C(40), unicompos C(3), pcompos N(11,3), qtds N(8,3), totas N(11,3), moeds C(3), obscompos C(10), etiqs C(1), qtscons N(8,3), qtdcvs N(11,3), cunips C(3))
4381:             SET NULL OFF
4382:         ENDIF
4383:         loc_oPg.grd_4c_CompoCusto.RecordSource = "cursor_4c_CompoCusto"
4384:         WITH loc_oPg.grd_4c_CompoCusto
4385:             .Column1.ControlSource  = "cursor_4c_CompoCusto.mats"
4386:             .Column2.ControlSource  = "cursor_4c_CompoCusto.dcompos"
4387:             .Column3.ControlSource  = "cursor_4c_CompoCusto.unicompos"
4388:             .Column4.ControlSource  = "cursor_4c_CompoCusto.pcompos"
4389:             .Column5.ControlSource  = "cursor_4c_CompoCusto.qtds"
4390:             .Column6.ControlSource  = "cursor_4c_CompoCusto.totas"
4391:             .Column7.ControlSource  = "cursor_4c_CompoCusto.moeds"
4392:             .Column8.ControlSource  = "cursor_4c_CompoCusto.obscompos"
4393:             .Column9.ControlSource  = "cursor_4c_CompoCusto.etiqs"
4394:             .Column10.ControlSource = "cursor_4c_CompoCusto.qtscons"
4395:             .Column11.ControlSource = "cursor_4c_CompoCusto.qtdcvs"
4396:             .Column12.ControlSource = "cursor_4c_CompoCusto.cunips"
4397:         ENDWITH
4398: 
4399:         *-- Cursor placeholder para grd_4c_GrupoCompo2
4400:         IF !USED("cursor_4c_GrupoCompo2")
4401:             SET NULL ON
4402:             CREATE CURSOR cursor_4c_GrupoCompo2 (grupos C(10), totas N(11,3), moeds C(3))
4403:             SET NULL OFF
4404:         ENDIF
4405:         loc_oPg.grd_4c_GrupoCompo2.RecordSource = "cursor_4c_GrupoCompo2"
4406:         WITH loc_oPg.grd_4c_GrupoCompo2
4407:             .Column1.ControlSource = "cursor_4c_GrupoCompo2.grupos"
4408:             .Column2.ControlSource = "cursor_4c_GrupoCompo2.totas"
4409:             .Column3.ControlSource = "cursor_4c_GrupoCompo2.moeds"
4410:         ENDWITH
4411:     ENDPROC
4412: 
4413:     *--------------------------------------------------------------------------
4414:     * ConfigurarTabDadosFiscais - Aba 4: Dados fiscais (pgDadosFiscais)
4415:     * IMPLEMENTADO NA FASE 6
4416:     *--------------------------------------------------------------------------
4417:     PROTECTED PROCEDURE ConfigurarTabDadosFiscais()
4418:         LOCAL loc_oPg
4419:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
4420: 
4421:         *-- Classificacao Fiscal (top=211, left=206, width=94)
4422:         loc_oPg.AddObject("lbl_4c_Clfiscal", "Label")
4423:         WITH loc_oPg.lbl_4c_Clfiscal
4424:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o Fiscal :"

*-- Linhas 5044 a 5093:
5044: 
5045:         IF !USED("cursor_4c_Cmv")
5046:             SET NULL ON
5047:             CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
5048:             SET NULL OFF
5049:         ENDIF
5050: 
5051:         loc_oPg.AddObject("grd_4c_Cmv", "Grid")
5052:         WITH loc_oPg.grd_4c_Cmv
5053:             .Top         = 338
5054:             .Left        = 754
5055:             .Width       = 223
5056:             .Height      = 141
5057:             .ReadOnly    = .T.
5058:             .DeleteMark  = .F.
5059:             .RecordMark  = .F.
5060:             .ScrollBars  = 3
5061:             .GridLines   = 3
5062:             .ColumnCount = 3
5063:             .FontName    = "Verdana"
5064:             .FontSize    = 8
5065:         ENDWITH
5066:         loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
5067:         WITH loc_oPg.grd_4c_Cmv
5068:             .Column1.Header1.Caption = "Per" + CHR(237) + "odo"
5069:             .Column1.Width           = 65
5070:             .Column1.ControlSource   = "cursor_4c_Cmv.periodos"
5071:             .Column1.ReadOnly        = .T.
5072:             .Column2.Header1.Caption = "Valor Custo GR"
5073:             .Column2.Width           = 105
5074:             .Column2.ControlSource   = "cursor_4c_Cmv.valcustos"
5075:             .Column2.ReadOnly        = .T.
5076:             .Column3.Header1.Caption = "Moe"
5077:             .Column3.Width           = 40
5078:             .Column3.ControlSource   = "cursor_4c_Cmv.moedas"
5079:             .Column3.ReadOnly        = .T.
5080:         ENDWITH
5081: 
5082:         *-- === BOTAO GERAR DESCRICAO FISCAL (btnDescFis: top=359, left=162) ======
5083: 
5084:         loc_oPg.AddObject("cmd_4c_BtnDescFis", "CommandButton")
5085:         WITH loc_oPg.cmd_4c_BtnDescFis
5086:             .Caption         = ""
5087:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_32.jpg"
5088:             .PicturePosition = 5
5089:             .Top             = 359
5090:             .Left            = 162
5091:             .Width           = 40
5092:             .Height          = 40
5093:             .FontName        = "Tahoma"

*-- Linhas 5131 a 5149:
5131:             .Width       = 495
5132:             .Height      = 238
5133:             .ReadOnly    = .T.
5134:             .DeleteMark  = .F.
5135:             .RecordMark  = .F.
5136:             .ScrollBars  = 3
5137:             .GridLines   = 3
5138:             .ColumnCount = 4
5139:             .FontName    = "Verdana"
5140:             .FontSize    = 8
5141:             .Visible     = .T.
5142:         ENDWITH
5143:         WITH loc_oPg.grd_4c_Designer
5144:             .Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
5145:             .Column1.Width = 110
5146:             .Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
5147:             .Column2.Width = 120
5148:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
5149:             .Column3.Width = 100

*-- Linhas 5215 a 5233:
5215:             .Width       = 495
5216:             .Height      = 202
5217:             .ReadOnly    = .T.
5218:             .DeleteMark  = .F.
5219:             .RecordMark  = .F.
5220:             .ScrollBars  = 3
5221:             .GridLines   = 3
5222:             .ColumnCount = 1
5223:             .FontName    = "Verdana"
5224:             .FontSize    = 8
5225:             .Visible     = .T.
5226:         ENDWITH
5227:         WITH loc_oPg.grd_4c_Arquivos
5228:             .Column1.Header1.Caption = "Arquivos Para Designer"
5229:             .Column1.Width = 492
5230:         ENDWITH
5231: 
5232:         *-- Botoes de arquivo (top=416, 458, 500, left=509)
5233:         loc_oPg.AddObject("cmd_4c_InsArqs", "CommandButton")

*-- Linhas 5275 a 5311:
5275:         *-- Criar cursors placeholder
5276:         IF !USED("cursor_4c_Designer")
5277:             SET NULL ON
5278:             CREATE CURSOR cursor_4c_Designer (dtinis D, dtfims D, usuars C(10), tarefas C(20))
5279:             SET NULL OFF
5280:         ENDIF
5281:         loc_oPg.grd_4c_Designer.RecordSource = "cursor_4c_Designer"
5282:         WITH loc_oPg.grd_4c_Designer
5283:             .Column1.ControlSource = "cursor_4c_Designer.dtinis"
5284:             .Column2.ControlSource = "cursor_4c_Designer.dtfims"
5285:             .Column3.ControlSource = "cursor_4c_Designer.usuars"
5286:             .Column4.ControlSource = "cursor_4c_Designer.tarefas"
5287:         ENDWITH
5288: 
5289:         IF !USED("cursor_4c_Arquivos")
5290:             SET NULL ON
5291:             CREATE CURSOR cursor_4c_Arquivos (arquivos C(250))
5292:             SET NULL OFF
5293:         ENDIF
5294:         loc_oPg.grd_4c_Arquivos.RecordSource = "cursor_4c_Arquivos"
5295:         WITH loc_oPg.grd_4c_Arquivos
5296:             .Column1.ControlSource = "cursor_4c_Arquivos.arquivos"
5297:         ENDWITH
5298:     ENDPROC
5299: 
5300:     *--------------------------------------------------------------------------
5301:     * ConfigurarPgpgDesigner - Completa Aba 5 Designer
5302:     * Adiciona img_4c_ImgArqJpg, shp_4c_Shape1 e todos os BINDEVENTs
5303:     * Chamado de ConfigurarPaginaDados() APOS ConfigurarTabDesigner()
5304:     *--------------------------------------------------------------------------
5305:     PROTECTED PROCEDURE ConfigurarPgpgDesigner()
5306:         LOCAL loc_oPg
5307:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
5308: 
5309:         *-- Corrigir ReadOnly do grd_4c_Designer: .F. para Column4 ser editavel
5310:         *-- Colunas 1-3 usam When=.F. via BINDEVENT para somente leitura
5311:         loc_oPg.grd_4c_Designer.ReadOnly = .F.

*-- Linhas 5355 a 5454:
5355:         *-- Cursor de tarefas para lookup do Column4 (codigo + descricao)
5356:         IF !USED("cursor_4c_Tarefas")
5357:             SET NULL ON
5358:             CREATE CURSOR cursor_4c_Tarefas (CodCads C(20), DesCads C(50))
5359:             SET NULL OFF
5360:         ENDIF
5361:     ENDPROC
5362: 
5363:     *--------------------------------------------------------------------------
5364:     * ConfigurarTabConsulta - Aba 6: Consulta de componentes por fase (PgDadosConsP)
5365:     * Legado: PgDadosConsP com GrdCons (9 cols editaveis) e grDTEMP (2 cols)
5366:     * IMPLEMENTADO NA FASE 9
5367:     *--------------------------------------------------------------------------
5368:     PROTECTED PROCEDURE ConfigurarTabConsulta()
5369:         LOCAL loc_oPg
5370:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
5371: 
5372:         *-- Criar cursors placeholder ANTES dos grids (evitar erro de RecordSource vazio)
5373:         *-- cursor_4c_Consulta: SIGPRCPO - componentes com fase (SigCdPrf) e categoria (SigCdCat)
5374:         IF !USED("cursor_4c_Consulta")
5375:             SET NULL ON
5376:             CREATE CURSOR cursor_4c_Consulta (mats C(14) NULL, qtds N(8,3) NULL, unicompos C(3) NULL, grupos C(10) NULL, dcompos C(40) NULL, ordems N(2,0) NULL, qtscons N(8,3) NULL, cats C(6) NULL, dscgrp C(20) NULL)
5377:             SET NULL OFF
5378:         ENDIF
5379: 
5380:         *-- cursor_4c_Temp: agrupamento x tempo (grDTEMP)
5381:         IF !USED("cursor_4c_Temp")
5382:             SET NULL ON
5383:             CREATE CURSOR cursor_4c_Temp (grupos C(10) NULL, totas N(11,3) NULL)
5384:             SET NULL OFF
5385:         ENDIF
5386: 
5387:         *-- GrdCons - Grid de componentes consulta (top=155, left=6, width=987, height=362, 9 cols)
5388:         *-- Colunas editaveis (INSERIR/ALTERAR): 4-Fase, 5-Descricao, 7-Consumo, 8-Cat
5389:         *-- Colunas somente leitura: 1-Componente, 2-Qtde, 3-Uni, 6-Ord, 9-DescCat
5390:         loc_oPg.AddObject("grd_4c_Consulta", "Grid")
5391:         WITH loc_oPg.grd_4c_Consulta
5392:             .Top         = 155
5393:             .Left        = 6
5394:             .Width       = 987
5395:             .Height      = 362
5396:             .ReadOnly    = .F.
5397:             .DeleteMark  = .F.
5398:             .RecordMark  = .F.
5399:             .ScrollBars  = 3
5400:             .GridLines   = 3
5401:             .ColumnCount = 9
5402:             .FontName    = "Verdana"
5403:             .FontSize    = 8
5404:             .Visible     = .T.
5405:         ENDWITH
5406:         *-- RecordSource ANTES dos headers/ControlSources (evita reset de colunas)
5407:         loc_oPg.grd_4c_Consulta.RecordSource = "cursor_4c_Consulta"
5408:         WITH loc_oPg.grd_4c_Consulta
5409:             .Column1.Header1.Caption = "Componente"
5410:             .Column1.Width           = 110
5411:             .Column1.ControlSource   = "cursor_4c_Consulta.mats"
5412:             .Column1.ReadOnly        = .T.
5413:             .Column2.Header1.Caption = "Qtde."
5414:             .Column2.Width           = 65
5415:             .Column2.ControlSource   = "cursor_4c_Consulta.qtds"
5416:             .Column2.ReadOnly        = .T.
5417:             .Column3.Header1.Caption = "Uni"
5418:             .Column3.Width           = 40
5419:             .Column3.ControlSource   = "cursor_4c_Consulta.unicompos"
5420:             .Column3.ReadOnly        = .T.
5421:             .Column4.Header1.Caption = "Fase"
5422:             .Column4.Width           = 80
5423:             .Column4.ControlSource   = "cursor_4c_Consulta.grupos"
5424:             .Column5.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5425:             .Column5.Width           = 180
5426:             .Column5.ControlSource   = "cursor_4c_Consulta.dcompos"
5427:             .Column6.Header1.Caption = "Ord."
5428:             .Column6.Width           = 40
5429:             .Column6.ControlSource   = "cursor_4c_Consulta.ordems"
5430:             .Column6.ReadOnly        = .T.
5431:             .Column7.Header1.Caption = "Consumo"
5432:             .Column7.Width           = 75
5433:             .Column7.ControlSource   = "cursor_4c_Consulta.qtscons"
5434:             .Column8.Header1.Caption = "Cat."
5435:             .Column8.Width           = 55
5436:             .Column8.ControlSource   = "cursor_4c_Consulta.cats"
5437:             .Column9.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5438:             .Column9.Width           = 150
5439:             .Column9.ControlSource   = "cursor_4c_Consulta.dscgrp"
5440:             .Column9.ReadOnly        = .T.
5441:         ENDWITH
5442:         BINDEVENT(loc_oPg.grd_4c_Consulta, "AfterRowColChange", THIS, "ConsultaGrd_AfterRowColChange")
5443: 
5444:         *-- Say7/lbl_4c_QtdCpnt: "Qtde Componentes :" (top=523, left=25)
5445:         loc_oPg.AddObject("lbl_4c_QtdCpnt", "Label")
5446:         WITH loc_oPg.lbl_4c_QtdCpnt
5447:             .Caption   = "Qtde Componentes : "
5448:             .Top       = 523
5449:             .Left      = 25
5450:             .Width     = 115
5451:             .Height    = 15
5452:             .FontName  = "Tahoma"
5453:             .FontSize  = 8
5454:             .BackStyle = 0

*-- Linhas 5506 a 5564:
5506:             .Width       = 172
5507:             .Height      = 107
5508:             .ReadOnly    = .T.
5509:             .DeleteMark  = .F.
5510:             .RecordMark  = .F.
5511:             .ScrollBars  = 3
5512:             .GridLines   = 3
5513:             .ColumnCount = 2
5514:             .FontName    = "Verdana"
5515:             .FontSize    = 8
5516:             .Visible     = .T.
5517:         ENDWITH
5518:         *-- RecordSource ANTES dos headers/ControlSources
5519:         loc_oPg.grd_4c_Temp.RecordSource = "cursor_4c_Temp"
5520:         WITH loc_oPg.grd_4c_Temp
5521:             .Column1.Header1.Caption = "Agrupamento"
5522:             .Column1.Width           = 100
5523:             .Column1.ControlSource   = "cursor_4c_Temp.grupos"
5524:             .Column2.Header1.Caption = "Tempo %"
5525:             .Column2.Width           = 65
5526:             .Column2.ControlSource   = "cursor_4c_Temp.totas"
5527:         ENDWITH
5528:     ENDPROC
5529: 
5530:     *--------------------------------------------------------------------------
5531:     * ConfigurarTabFases - Aba 7: Fases de producao (PgDadosFaseP)
5532:     * IMPLEMENTADO NA FASE 7
5533:     *--------------------------------------------------------------------------
5534:     PROTECTED PROCEDURE ConfigurarTabFases()
5535:         LOCAL loc_oPg, loc_oGrid, loc_oGrid2, loc_oCtrl, loc_oLbl, loc_oChk
5536:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
5537: 
5538:         *-- Cursor placeholder para GradFase (SigCdPrf)
5539:         *-- ordems N(2,0), grupos C(10), minutos N(9,1), uniprdts C(10), matprdts C(15)
5540:         IF !USED("cursor_4c_Fases")
5541:             SET NULL ON
5542:             CREATE CURSOR cursor_4c_Fases (ordems N(2,0) NULL, grupos C(10) NULL, minutos N(9,1) NULL, uniprdts C(10) NULL, matprdts C(15) NULL)
5543:             SET NULL OFF
5544:         ENDIF
5545: 
5546:         *-- Cursor placeholder para grdMatrizes (SigPrMtz + Locals de SigCdPro)
5547:         IF !USED("cursor_4c_Matrizes")
5548:             SET NULL ON
5549:             CREATE CURSOR cursor_4c_Matrizes (cidchaves C(20) NULL, cmats C(14) NULL, cpros C(14) NULL, qtds N(3,0) NULL, locals C(10) NULL)
5550:             SET NULL OFF
5551:         ENDIF
5552: 
5553:         *======================================================
5554:         *-- LABEL: Say13 - "Qtd. Min. Producao :"
5555:         *======================================================
5556:         loc_oPg.AddObject("lbl_4c_Qmin", "Label")
5557:         WITH loc_oPg.lbl_4c_Qmin
5558:             .Top      = 156
5559:             .Left     = 33
5560:             .Width    = 102
5561:             .Height   = 15
5562:             .Caption  = "Qtd. M" + CHR(237) + "n. Produ" + CHR(231) + CHR(227) + "o :"
5563:             .AutoSize = .F.
5564:             .FontName = "Tahoma"

*-- Linhas 5869 a 5946:
5869:             .Width          = 420
5870:             .Height         = 312
5871:             .ReadOnly       = .F.
5872:             .DeleteMark     = .F.
5873:             .RecordMark     = .F.
5874:             .GridLines      = 3
5875:             .FontName       = "Tahoma"
5876:             .FontSize       = 8
5877:             .Themes         = .F.
5878:             .Visible        = .T.
5879:         ENDWITH
5880:         loc_oPg.grd_4c_Fases.ColumnCount = 5
5881:         loc_oPg.grd_4c_Fases.RecordSource = "cursor_4c_Fases"
5882:         WITH loc_oPg.grd_4c_Fases
5883:             .Column1.Header1.Caption  = "Ordem"
5884:             .Column1.Width            = 40
5885:             .Column1.ControlSource    = "cursor_4c_Fases.ordems"
5886:             .Column2.Header1.Caption  = "Fase"
5887:             .Column2.Width            = 80
5888:             .Column2.ControlSource    = "cursor_4c_Fases.grupos"
5889:             .Column3.Header1.Caption  = "Utiliza" + CHR(231) + CHR(227) + "o"
5890:             .Column3.Width            = 70
5891:             .Column3.ControlSource    = "cursor_4c_Fases.minutos"
5892:             .Column4.Header1.Caption  = "Uni. Produtiva"
5893:             .Column4.Width            = 90
5894:             .Column4.ControlSource    = "cursor_4c_Fases.uniprdts"
5895:             .Column5.Header1.Caption  = "Material"
5896:             .Column5.Width            = 120
5897:             .Column5.ControlSource    = "cursor_4c_Fases.matprdts"
5898:         ENDWITH
5899: 
5900:         *======================================================
5901:         *-- GRID: grd_4c_Matrizes - 3 colunas - SigPrMtz
5902:         *-- top=380, left=7, width=246, height=240
5903:         *-- Matriz | Local | Qtde
5904:         *======================================================
5905:         loc_oPg.AddObject("grd_4c_Matrizes", "Grid")
5906:         WITH loc_oPg.grd_4c_Matrizes
5907:             .Top            = 380
5908:             .Left           = 7
5909:             .Width          = 246
5910:             .Height         = 240
5911:             .ReadOnly       = .F.
5912:             .DeleteMark     = .F.
5913:             .RecordMark     = .F.
5914:             .GridLines      = 3
5915:             .FontName       = "Tahoma"
5916:             .FontSize       = 8
5917:             .Themes         = .F.
5918:             .Visible        = .T.
5919:         ENDWITH
5920:         loc_oPg.grd_4c_Matrizes.ColumnCount = 3
5921:         loc_oPg.grd_4c_Matrizes.RecordSource = "cursor_4c_Matrizes"
5922:         WITH loc_oPg.grd_4c_Matrizes
5923:             .Column1.Header1.Caption  = "Matriz"
5924:             .Column1.Width            = 100
5925:             .Column1.ControlSource    = "cursor_4c_Matrizes.cmats"
5926:             .Column2.Header1.Caption  = "Local"
5927:             .Column2.Width            = 80
5928:             .Column2.ControlSource    = "cursor_4c_Matrizes.locals"
5929:             .Column3.Header1.Caption  = "Qtde"
5930:             .Column3.Width            = 60
5931:             .Column3.ControlSource    = "cursor_4c_Matrizes.qtds"
5932:         ENDWITH
5933: 
5934:         *======================================================
5935:         *-- LABEL + TEXTBOX: Get_Desc - Descricao da fase selecionada
5936:         *======================================================
5937:         loc_oPg.AddObject("lbl_4c_DescFase", "Label")
5938:         WITH loc_oPg.lbl_4c_DescFase
5939:             .Top      = 474
5940:             .Left     = 527
5941:             .Width    = 67
5942:             .Height   = 17
5943:             .Caption  = "Descri" + CHR(231) + CHR(227) + "o :"
5944:             .AutoSize = .F.
5945:             .FontName = "Tahoma"
5946:             .FontSize = 8

*-- Linhas 6327 a 6345:
6327:             ENDIF
6328: 
6329:             IF !EMPTY(loc_cCgru)
6330:                 loc_cFiltro = "p.cgrus = " + EscaparSQL(loc_cCgru)
6331:             ENDIF
6332: 
6333:             *-- Filtro situacao
6334:             loc_nSit = 1
6335:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros, "ControlCount", 5)
6336:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas, "Value", 5)
6337:                     loc_nSit = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.opt_4c_FiltraSituas.Value
6338:                 ENDIF
6339:             ENDIF
6340: 
6341:             IF loc_nSit = 2   && Apenas ativos (situas=1)
6342:                 IF !EMPTY(loc_cFiltro)
6343:                     loc_cFiltro = loc_cFiltro + " AND p.situas = 1"
6344:                 ELSE
6345:                     loc_cFiltro = "p.situas = 1"

*-- Linhas 6373 a 6398:
6373:                 *-- Definir RecordSource (ISSO RESETA AS COLUNAS)
6374:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
6375: 
6376:                 *-- Reconfigurar ControlSource APOS RecordSource
6377:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
6378:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
6379:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
6380:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.sgrus"
6381:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.reffs"
6382:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.usuaalts"
6383:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.situas"
6384: 
6385:                 *-- Larguras
6386:                 loc_oGrid.Column1.Width = 110
6387:                 loc_oGrid.Column2.Width = 330
6388:                 loc_oGrid.Column3.Width = 55
6389:                 loc_oGrid.Column4.Width = 60
6390:                 loc_oGrid.Column5.Width = 160
6391:                 loc_oGrid.Column6.Width = 120
6392:                 loc_oGrid.Column7.Width = 40
6393: 
6394:                 *-- Cabecalhos (legado: Produto, Descricao, Grupo, Subgrp., Ref. Fornecedor, Usuario, I)
6395:                 loc_oGrid.Column1.Header1.Caption = "Produto"
6396:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
6397:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
6398:                 loc_oGrid.Column4.Header1.Caption = "Subgrp."

*-- Linhas 8004 a 8022:
8004:             RETURN
8005:         ENDIF
8006: 
8007:         SELECT cursor_4c_Dados
8008:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8009: 
8010:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8011:             THIS.BOParaForm()
8012:             THIS.this_cModoAtual = "VISUALIZAR"
8013:             THIS.HabilitarCampos(.F.)
8014:             THIS.AjustarBotoesPorModo()
8015:             THIS.AlternarPagina(2)
8016:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8017:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8018:         ENDIF
8019:     ENDPROC
8020: 
8021:     *--------------------------------------------------------------------------
8022:     * BtnAlterarClick - Alterar produto selecionado

*-- Linhas 8033 a 8051:
8033:             RETURN
8034:         ENDIF
8035: 
8036:         SELECT cursor_4c_Dados
8037:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8038: 
8039:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8040:             THIS.this_oBusinessObject.EditarRegistro()
8041:             THIS.BOParaForm()
8042:             THIS.this_cModoAtual = "ALTERAR"
8043:             THIS.HabilitarCampos(.T.)
8044:             THIS.AjustarBotoesPorModo()
8045:             THIS.AlternarPagina(2)
8046:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8047:             THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8048:         ENDIF
8049:     ENDPROC
8050: 
8051:     *--------------------------------------------------------------------------

*-- Linhas 8064 a 8094:
8064:             RETURN
8065:         ENDIF
8066: 
8067:         SELECT cursor_4c_Dados
8068:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cpros)
8069: 
8070:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
8071: 
8072:             *-- Verificar uso em itens de pedido (SigMvCIte)
8073:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8074:                 SELECT COUNT(*) AS nExiste
8075:                 FROM SigMvCIte
8076:                 WHERE cpros = <<EscaparSQL(loc_cCodigo)>>
8077:             ENDTEXT
8078: 
8079:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerPro")
8080: 
8081:             IF loc_nResultado < 0
8082:                 MsgErro("Falha ao verificar uso do produto!")
8083:                 IF USED("cursor_4c_VerPro")
8084:                     USE IN cursor_4c_VerPro
8085:                 ENDIF
8086:                 RETURN
8087:             ENDIF
8088: 
8089:             IF NVL(cursor_4c_VerPro.nExiste, 0) > 0
8090:                 MsgAviso("Produto em uso em pedidos - n" + CHR(227) + "o pode ser exclu" + CHR(237) + "do!")
8091:                 IF USED("cursor_4c_VerPro")
8092:                     USE IN cursor_4c_VerPro
8093:                 ENDIF
8094:                 RETURN

*-- Linhas 8134 a 8155:
8134:                 loc_cCodNovo = ALLTRIM(loc_oPg.txt_4c_Cpros.Value)
8135: 
8136:                 TEXT TO loc_cSQLDup TEXTMERGE NOSHOW
8137:                     SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = <<EscaparSQL(loc_cCodNovo)>>
8138:                 ENDTEXT
8139: 
8140:                 loc_nDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupPro")
8141: 
8142:                 IF loc_nDup >= 0 AND NVL(cursor_4c_DupPro.nExiste, 0) > 0
8143:                     IF USED("cursor_4c_DupPro")
8144:                         USE IN cursor_4c_DupPro
8145:                     ENDIF
8146:                     MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
8147:                     IF PEMSTATUS(loc_oPg, "txt_4c_Cpros", 5)
8148:                         loc_oPg.txt_4c_Cpros.SetFocus()
8149:                     ENDIF
8150:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
8151:                     THIS.pgf_4c_Paginas.Page2.opt_4c_Abas.Value = 1
8152:                     RETURN
8153:                 ENDIF
8154: 
8155:                 IF USED("cursor_4c_DupPro")

*-- Linhas 8267 a 8288:
8267: 
8268:         TRY
8269:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8270:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCgru)>>
8271:             ENDTEXT
8272: 
8273:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerGru")
8274: 
8275:             IF loc_nRes > 0 AND !EOF("cursor_4c_VerGru")
8276:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.txt_4c_FiltroDgru.Value = ALLTRIM(cursor_4c_VerGru.dgrus)
8277:             ELSE
8278:                 *-- Codigo nao encontrado: abrir lookup
8279:                 THIS.AbrirLookupFiltroGrupo()
8280:             ENDIF
8281: 
8282:             IF USED("cursor_4c_VerGru")
8283:                 USE IN cursor_4c_VerGru
8284:             ENDIF
8285:         CATCH TO loc_oErro
8286:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarFiltroGrupo")
8287:         ENDTRY
8288:     ENDPROC

*-- Linhas 8437 a 8457:
8437: 
8438:         TRY
8439:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8440:                 SELECT TOP 1 cgrus, dgrus FROM SigCdGrp WHERE cgrus = <<EscaparSQL(loc_cCod)>>
8441:             ENDTEXT
8442:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGrp")
8443:             IF loc_nR > 0 AND !EOF("cursor_4c_VGrp")
8444:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dgrus", 5)
8445:                     loc_oPg.txt_4c_Dgrus.Value = ALLTRIM(cursor_4c_VGrp.dgrus)
8446:                 ENDIF
8447:             ELSE
8448:                 THIS.AbrirLookupGrupo()
8449:             ENDIF
8450:             IF USED("cursor_4c_VGrp")
8451:                 USE IN cursor_4c_VGrp
8452:             ENDIF
8453:         CATCH TO loc_oErro
8454:             MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CgruLostFocus")
8455:         ENDTRY
8456:     ENDPROC
8457: 

*-- Linhas 8531 a 8551:
8531: 
8532:         TRY
8533:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8534:                 SELECT TOP 1 Linhas, Descs FROM SigCdLin WHERE Linhas = <<EscaparSQL(loc_cCod)>>
8535:             ENDTEXT
8536:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VLin")
8537:             IF loc_nR > 0 AND !EOF("cursor_4c_VLin")
8538:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dlinhas", 5)
8539:                     loc_oPg.txt_4c_Dlinhas.Value = ALLTRIM(cursor_4c_VLin.Descs)
8540:                 ENDIF
8541:             ELSE
8542:                 THIS.AbrirLookupLinha()
8543:             ENDIF
8544:             IF USED("cursor_4c_VLin")
8545:                 USE IN cursor_4c_VLin
8546:             ENDIF
8547:         CATCH TO loc_oErro
8548:             MsgErro("Erro ao validar linha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_LinhasLostFocus")
8549:         ENDTRY
8550:     ENDPROC
8551: 

*-- Linhas 8625 a 8645:
8625: 
8626:         TRY
8627:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8628:                 SELECT TOP 1 Colecoes, Descs FROM SigCdCol WHERE Colecoes = <<EscaparSQL(loc_cCod)>>
8629:             ENDTEXT
8630:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCol")
8631:             IF loc_nR > 0 AND !EOF("cursor_4c_VCol")
8632:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcolecoes", 5)
8633:                     loc_oPg.txt_4c_Dcolecoes.Value = ALLTRIM(cursor_4c_VCol.Descs)
8634:                 ENDIF
8635:             ELSE
8636:                 THIS.AbrirLookupColecao()
8637:             ENDIF
8638:             IF USED("cursor_4c_VCol")
8639:                 USE IN cursor_4c_VCol
8640:             ENDIF
8641:         CATCH TO loc_oErro
8642:             MsgErro("Erro ao validar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_ColecoesLostFocus")
8643:         ENDTRY
8644:     ENDPROC
8645: 

*-- Linhas 8719 a 8739:
8719: 
8720:         TRY
8721:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8722:                 SELECT TOP 1 IClis, Rclis FROM SigCdCli WHERE IClis = <<EscaparSQL(loc_cCod)>>
8723:             ENDTEXT
8724:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VFor")
8725:             IF loc_nR > 0 AND !EOF("cursor_4c_VFor")
8726:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dfors", 5)
8727:                     loc_oPg.txt_4c_Dfors.Value = ALLTRIM(cursor_4c_VFor.Rclis)
8728:                 ENDIF
8729:             ELSE
8730:                 THIS.AbrirLookupFornecedor()
8731:             ENDIF
8732:             IF USED("cursor_4c_VFor")
8733:                 USE IN cursor_4c_VFor
8734:             ENDIF
8735:         CATCH TO loc_oErro
8736:             MsgErro("Erro ao validar fornecedor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_IforsLostFocus")
8737:         ENDTRY
8738:     ENDPROC
8739: 

*-- Linhas 8915 a 8935:
8915: 
8916:         TRY
8917:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8918:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8919:             ENDTEXT
8920:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUni")
8921:             IF loc_nR > 0 AND !EOF("cursor_4c_VUni")
8922:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunis", 5)
8923:                     loc_oPg.txt_4c_Dunis.Value = ALLTRIM(cursor_4c_VUni.dunis)
8924:                 ENDIF
8925:             ELSE
8926:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunis", "txt_4c_Dunis")
8927:             ENDIF
8928:             IF USED("cursor_4c_VUni")
8929:                 USE IN cursor_4c_VUni
8930:             ENDIF
8931:         CATCH TO loc_oErro
8932:             MsgErro("Erro ao validar unidade:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunisLostFocus")
8933:         ENDTRY
8934:     ENDPROC
8935: 

*-- Linhas 8968 a 8988:
8968: 
8969:         TRY
8970:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
8971:                 SELECT TOP 1 cunis, dunis FROM SigCdUni WHERE cunis = <<EscaparSQL(loc_cCod)>>
8972:             ENDTEXT
8973:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VUn2")
8974:             IF loc_nR > 0 AND !EOF("cursor_4c_VUn2")
8975:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dunips", 5)
8976:                     loc_oPg.txt_4c_Dunips.Value = ALLTRIM(cursor_4c_VUn2.dunis)
8977:                 ENDIF
8978:             ELSE
8979:                 THIS.AbrirLookupUnidade("cunis", "txt_4c_Cunips", "txt_4c_Dunips")
8980:             ENDIF
8981:             IF USED("cursor_4c_VUn2")
8982:                 USE IN cursor_4c_VUn2
8983:             ENDIF
8984:         CATCH TO loc_oErro
8985:             MsgErro("Erro ao validar unidade 2:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CunipsLostFocus")
8986:         ENDTRY
8987:     ENDPROC
8988: 

*-- Linhas 9065 a 9085:
9065: 
9066:         TRY
9067:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9068:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
9069:             ENDTEXT
9070:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcb")
9071:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcb")
9072:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dcodacbs", 5)
9073:                     loc_oPg.txt_4c_Dcodacbs.Value = ALLTRIM(cursor_4c_VAcb.descrs)
9074:                 ENDIF
9075:             ELSE
9076:                 THIS.AbrirLookupAcabamento()
9077:             ENDIF
9078:             IF USED("cursor_4c_VAcb")
9079:                 USE IN cursor_4c_VAcb
9080:             ENDIF
9081:         CATCH TO loc_oErro
9082:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodacbsLostFocus")
9083:         ENDTRY
9084:     ENDPROC
9085: 

*-- Linhas 9156 a 9176:
9156: 
9157:         TRY
9158:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9159:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
9160:             ENDTEXT
9161:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCor")
9162:             IF loc_nR <= 0
9163:                 THIS.AbrirLookupCor()
9164:             ELSE
9165:                 IF EOF("cursor_4c_VCor")
9166:                     THIS.AbrirLookupCor()
9167:                 ENDIF
9168:             ENDIF
9169:             IF USED("cursor_4c_VCor")
9170:                 USE IN cursor_4c_VCor
9171:             ENDIF
9172:         CATCH TO loc_oErro
9173:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabPrincipal_CodcorsLostFocus")
9174:         ENDTRY
9175:     ENDPROC
9176: 

*-- Linhas 9265 a 9431:
9265:         IF !EMPTY(par_cValor) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
9266:             TRY
9267:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9268:                     SELECT TOP 1 <<par_cCampoDesc>> FROM <<par_cTabela>> WHERE <<par_cCampoChave>> = <<EscaparSQL(par_cValor)>>
9269:                 ENDTEXT
9270:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescH")
9271:                 IF loc_nR > 0 AND !EOF("cursor_4c_DescH")
9272:                     loc_cAliasField = "cursor_4c_DescH." + par_cCampoDesc
9273:                     loc_cDesc = ALLTRIM(&loc_cAliasField)
9274:                 ENDIF
9275:                 IF USED("cursor_4c_DescH")
9276:                     USE IN cursor_4c_DescH
9277:                 ENDIF
9278:             CATCH TO loc_oErro
9279:                 MsgErro("Erro ao carregar descricao:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDesc")
9280:             ENDTRY
9281:         ENDIF
9282: 
9283:         RETURN loc_cDesc
9284:     ENDFUNC
9285: 
9286:     *--------------------------------------------------------------------------
9287:     * CarregarComposicao - Carrega grid de composicao (Tab 2)
9288:     * Tabela: SIGPRCPO JOIN SigCdPro
9289:     *--------------------------------------------------------------------------
9290:     PROTECTED PROCEDURE CarregarComposicao()
9291:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9292:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9293:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
9294: 
9295:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9296:             RETURN
9297:         ENDIF
9298: 
9299:         TRY
9300:             *-- Composicao principal
9301:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9302:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9303:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9304:                        c.qtdcvs, c.cunips, c.ordems, c.compos
9305:                 FROM SIGPRCPO c
9306:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9307:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9308:                 ORDER BY c.ordems
9309:             ENDTEXT
9310:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTmp")
9311:             IF loc_nR > 0
9312:                 IF USED("cursor_4c_Compo")
9313:                     SELECT cursor_4c_Compo
9314:                     ZAP
9315:                     APPEND FROM DBF("cursor_4c_CompoTmp")
9316:                 ENDIF
9317:                 IF USED("cursor_4c_CompoTmp")
9318:                     USE IN cursor_4c_CompoTmp
9319:                 ENDIF
9320:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
9321:                     loc_oPg.grd_4c_Compo.Refresh()
9322:                 ENDIF
9323:             ENDIF
9324: 
9325:             *-- Sub-composicao
9326:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9327:                 SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9328:                        c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9329:                        c.qtdcvs, c.cunips, c.ordems, c.matsubs, c.codtams
9330:                 FROM sigsubcp c
9331:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9332:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9333:                 ORDER BY c.ordems
9334:             ENDTEXT
9335:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubCompoTmp")
9336:             IF loc_nR > 0
9337:                 IF USED("cursor_4c_SubCompo")
9338:                     SELECT cursor_4c_SubCompo
9339:                     ZAP
9340:                     APPEND FROM DBF("cursor_4c_SubCompoTmp")
9341:                 ENDIF
9342:                 IF USED("cursor_4c_SubCompoTmp")
9343:                     USE IN cursor_4c_SubCompoTmp
9344:                 ENDIF
9345:                 IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
9346:                     loc_oPg.grd_4c_SubCompo.Refresh()
9347:                 ENDIF
9348:             ENDIF
9349: 
9350:         CATCH TO loc_oErro
9351:             MsgErro("Erro ao carregar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarComposicao")
9352:         ENDTRY
9353:     ENDPROC
9354: 
9355:     *--------------------------------------------------------------------------
9356:     * CarregarConsultaP - Carrega grids da aba Consulta P. (Tab 6 - PgDadosConsP)
9357:     * GrdCons: SIGPRCPO JOIN SigCdPrf(fase) JOIN SigCdCat(categoria)
9358:     * grDTEMP:  SIGPRCPO agrupado por fase (consumo total)
9359:     *--------------------------------------------------------------------------
9360:     PROTECTED PROCEDURE CarregarConsultaP()
9361:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_nCount, loc_oPg
9362:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9363:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page6
9364: 
9365:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9366:             RETURN
9367:         ENDIF
9368: 
9369:         TRY
9370:             *-- Carregar componentes com descricao de fase e categoria
9371:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9372:                 SELECT c.mats, c.qtds, c.unicompos, c.grupos,
9373:                        ISNULL((SELECT TOP 1 g.Descrs FROM SigCdGcr g WHERE RTRIM(g.Codigos) = RTRIM(c.grupos)), '') AS dcompos,
9374:                        c.ordems, c.qtscons, c.cats,
9375:                        ISNULL(cat.descs, '') AS dscgrp
9376:                 FROM SIGPRCPO c
9377:                 LEFT JOIN SigCdCat cat ON RTRIM(c.cats) = RTRIM(cat.cods)
9378:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9379:                 ORDER BY c.ordems, c.mats
9380:             ENDTEXT
9381:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsultaTmp")
9382:             IF loc_nR > 0
9383:                 IF USED("cursor_4c_Consulta")
9384:                     SELECT cursor_4c_Consulta
9385:                     ZAP
9386:                     APPEND FROM DBF("cursor_4c_ConsultaTmp")
9387:                 ENDIF
9388:                 IF USED("cursor_4c_ConsultaTmp")
9389:                     USE IN cursor_4c_ConsultaTmp
9390:                 ENDIF
9391:                 *-- Atualizar contagem de componentes
9392:                 loc_nCount = RECCOUNT("cursor_4c_Consulta")
9393:                 IF PEMSTATUS(loc_oPg, "txt_4c_QtdCpnt", 5)
9394:                     loc_oPg.txt_4c_QtdCpnt.Value = loc_nCount
9395:                 ENDIF
9396:                 IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
9397:                     loc_oPg.grd_4c_Consulta.Refresh()
9398:                 ENDIF
9399:             ENDIF
9400: 
9401:             *-- Carregar dados grDTEMP: consumo total agrupado por fase
9402:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9403:                 SELECT c.grupos, SUM(c.qtscons) AS totas
9404:                 FROM SIGPRCPO c
9405:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9406:                   AND c.grupos IS NOT NULL
9407:                   AND RTRIM(c.grupos) <> ''
9408:                 GROUP BY c.grupos
9409:                 ORDER BY c.grupos
9410:             ENDTEXT
9411:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TempTmp")
9412:             IF loc_nR > 0
9413:                 IF USED("cursor_4c_Temp")
9414:                     SELECT cursor_4c_Temp
9415:                     ZAP
9416:                     APPEND FROM DBF("cursor_4c_TempTmp")
9417:                 ENDIF
9418:                 IF USED("cursor_4c_TempTmp")
9419:                     USE IN cursor_4c_TempTmp
9420:                 ENDIF
9421:                 IF PEMSTATUS(loc_oPg, "grd_4c_Temp", 5)
9422:                     loc_oPg.grd_4c_Temp.Refresh()
9423:                 ENDIF
9424:             ENDIF
9425: 
9426:         CATCH TO loc_oErro
9427:             MsgErro("Erro ao carregar consulta de componentes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarConsultaP")
9428:         ENDTRY
9429:     ENDPROC
9430: 
9431:     *--------------------------------------------------------------------------

*-- Linhas 9451 a 9546:
9451:             *-- Composicao de custo
9452:             IF loc_nTipo = 0
9453:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9454:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9455:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9456:                            c.qtdcvs, c.cunips
9457:                     FROM SIGPRCPO c
9458:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9459:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9460:                     AND c.tipos IS NOT NULL
9461:                     ORDER BY c.mats
9462:                 ENDTEXT
9463:             ELSE
9464:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9465:                     SELECT c.mats, m.dpros AS dcompos, c.unicompos, c.pcompos, c.qtds,
9466:                            c.totas, c.moeds, c.obscompos, c.etiqs, c.qtscons,
9467:                            c.qtdcvs, c.cunips
9468:                     FROM SIGPRCPO c
9469:                     LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9470:                     WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9471:                     AND c.tipos = <<TRANSFORM(loc_nTipo)>>
9472:                     ORDER BY c.mats
9473:                 ENDTEXT
9474:             ENDIF
9475: 
9476:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoCustoTmp")
9477:             IF loc_nR > 0
9478:                 IF USED("cursor_4c_CompoCusto")
9479:                     SELECT cursor_4c_CompoCusto
9480:                     ZAP
9481:                     APPEND FROM DBF("cursor_4c_CompoCustoTmp")
9482:                 ENDIF
9483:                 IF USED("cursor_4c_CompoCustoTmp")
9484:                     USE IN cursor_4c_CompoCustoTmp
9485:                 ENDIF
9486:                 IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
9487:                     WITH loc_oPg.grd_4c_CompoCusto
9488:                         .Column1.ControlSource  = "cursor_4c_CompoCusto.mats"
9489:                         .Column2.ControlSource  = "cursor_4c_CompoCusto.dcompos"
9490:                         .Column3.ControlSource  = "cursor_4c_CompoCusto.unicompos"
9491:                         .Column4.ControlSource  = "cursor_4c_CompoCusto.pcompos"
9492:                         .Column5.ControlSource  = "cursor_4c_CompoCusto.qtds"
9493:                         .Column6.ControlSource  = "cursor_4c_CompoCusto.totas"
9494:                         .Column7.ControlSource  = "cursor_4c_CompoCusto.moeds"
9495:                         .Column8.ControlSource  = "cursor_4c_CompoCusto.obscompos"
9496:                         .Column9.ControlSource  = "cursor_4c_CompoCusto.etiqs"
9497:                         .Column10.ControlSource = "cursor_4c_CompoCusto.qtscons"
9498:                         .Column11.ControlSource = "cursor_4c_CompoCusto.qtdcvs"
9499:                         .Column12.ControlSource = "cursor_4c_CompoCusto.cunips"
9500:                     ENDWITH
9501:                     loc_oPg.grd_4c_CompoCusto.Refresh()
9502:                 ENDIF
9503:             ENDIF
9504: 
9505:             *-- Totais por grupo de custo (GradeGRUPO2)
9506:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9507:                 SELECT RTRIM(m.cgrus) AS grupos,
9508:                        SUM(c.totas) AS totas,
9509:                        MAX(c.moeds) AS moeds
9510:                 FROM SIGPRCPO c
9511:                 LEFT JOIN SigCdPro m ON RTRIM(c.mats) = RTRIM(m.cpros)
9512:                 WHERE RTRIM(c.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9513:                 AND c.tipos IS NOT NULL
9514:                 GROUP BY m.cgrus
9515:                 ORDER BY m.cgrus
9516:             ENDTEXT
9517:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoCompo2Tmp")
9518:             IF loc_nR > 0
9519:                 IF USED("cursor_4c_GrupoCompo2")
9520:                     SELECT cursor_4c_GrupoCompo2
9521:                     ZAP
9522:                     APPEND FROM DBF("cursor_4c_GrupoCompo2Tmp")
9523:                 ENDIF
9524:                 IF USED("cursor_4c_GrupoCompo2Tmp")
9525:                     USE IN cursor_4c_GrupoCompo2Tmp
9526:                 ENDIF
9527:                 IF PEMSTATUS(loc_oPg, "grd_4c_GrupoCompo2", 5)
9528:                     WITH loc_oPg.grd_4c_GrupoCompo2
9529:                         .Column1.ControlSource = "cursor_4c_GrupoCompo2.grupos"
9530:                         .Column2.ControlSource = "cursor_4c_GrupoCompo2.totas"
9531:                         .Column3.ControlSource = "cursor_4c_GrupoCompo2.moeds"
9532:                     ENDWITH
9533:                     loc_oPg.grd_4c_GrupoCompo2.Refresh()
9534:                 ENDIF
9535:             ENDIF
9536: 
9537:         CATCH TO loc_oErro
9538:             MsgErro("Erro ao carregar custos:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarCustos")
9539:         ENDTRY
9540:     ENDPROC
9541: 
9542:     *--------------------------------------------------------------------------
9543:     * CarregarFases - Carrega grid de fases (Tab 7)
9544:     * Tabela: SigCdPrf
9545:     *--------------------------------------------------------------------------
9546:     PROTECTED PROCEDURE CarregarFases()

*-- Linhas 9556 a 9584:
9556:         TRY
9557:             *-- Fases de producao
9558:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9559:                 SELECT ordems, grupos, minutos, uniprdts, matprdts
9560:                 FROM SigCdPrf
9561:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9562:                 ORDER BY ordems
9563:             ENDTEXT
9564:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesTmp")
9565:             IF loc_nR > 0
9566:                 IF USED("cursor_4c_Fases")
9567:                     SELECT cursor_4c_Fases
9568:                     ZAP
9569:                     APPEND FROM DBF("cursor_4c_FasesTmp")
9570:                 ENDIF
9571:                 IF USED("cursor_4c_FasesTmp")
9572:                     USE IN cursor_4c_FasesTmp
9573:                 ENDIF
9574:                 IF PEMSTATUS(loc_oPg, "grd_4c_Fases", 5)
9575:                     loc_oPg.grd_4c_Fases.Refresh()
9576:                 ENDIF
9577:             ENDIF
9578: 
9579:             *-- Matrizes
9580:             THIS.CarregarMatrizes()
9581: 
9582:             *-- Preencher campos do BO nas textboxes da tab
9583:             IF PEMSTATUS(loc_oPg, "txt_4c_Qminfab", 5)
9584:                 loc_oPg.txt_4c_Qminfab.Value   = loc_oBO.this_nQtminfabs

*-- Linhas 9624 a 9665:
9624: 
9625:     *--------------------------------------------------------------------------
9626:     * CarregarMatrizes - Carrega grid de matrizes (Tab 7 - sub-grid)
9627:     * Tabela: SigPrMtz JOIN SigCdPro (para Locals)
9628:     *--------------------------------------------------------------------------
9629:     PROTECTED PROCEDURE CarregarMatrizes()
9630:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oPg
9631:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)
9632:         loc_oPg    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
9633: 
9634:         IF EMPTY(loc_cCpros) OR TYPE("gnConnHandle") # "N" OR gnConnHandle <= 0
9635:             RETURN
9636:         ENDIF
9637: 
9638:         TRY
9639:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
9640:                 SELECT a.cidchaves, a.cmats, a.cpros, a.qtds, b.locals
9641:                 FROM SigPrMtz a
9642:                 INNER JOIN SigCdPro b ON RTRIM(a.cmats) = RTRIM(b.cpros)
9643:                 WHERE RTRIM(a.cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
9644:             ENDTEXT
9645:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatrizesTmp")
9646:             IF loc_nR > 0
9647:                 IF USED("cursor_4c_Matrizes")
9648:                     SELECT cursor_4c_Matrizes
9649:                     ZAP
9650:                     APPEND FROM DBF("cursor_4c_MatrizesTmp")
9651:                 ENDIF
9652:                 IF USED("cursor_4c_MatrizesTmp")
9653:                     USE IN cursor_4c_MatrizesTmp
9654:                 ENDIF
9655:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
9656:                     loc_oPg.grd_4c_Matrizes.Refresh()
9657:                 ENDIF
9658:             ENDIF
9659: 
9660:         CATCH TO loc_oErro
9661:             MsgErro("Erro ao carregar matrizes:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarMatrizes")
9662:         ENDTRY
9663:     ENDPROC
9664: 
9665:     *--------------------------------------------------------------------------

*-- Linhas 9672 a 9693:
9672:         IF !EMPTY(par_cSgrus) AND !EMPTY(par_cCgrus) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
9673:             TRY
9674:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
9675:                     SELECT TOP 1 codigos, descricaos FROM SigCdPsg
9676:                     WHERE cgrus = <<EscaparSQL(par_cCgrus)>> AND codigos = <<EscaparSQL(par_cSgrus)>>
9677:                 ENDTEXT
9678:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescSg")
9679:                 IF loc_nR > 0 AND !EOF("cursor_4c_DescSg")
9680:                     loc_cDesc = ALLTRIM(cursor_4c_DescSg.descricaos)
9681:                 ENDIF
9682:                 IF USED("cursor_4c_DescSg")
9683:                     USE IN cursor_4c_DescSg
9684:                 ENDIF
9685:             CATCH TO loc_oErro
9686:                 MsgErro("Erro ao carregar subgrupo:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDescSgru")
9687:             ENDTRY
9688:         ENDIF
9689: 
9690:         RETURN loc_cDesc
9691:     ENDFUNC
9692: 
9693:     *--------------------------------------------------------------------------

*-- Linhas 9824 a 9844:
9824:                     *-- Popula AliqIPI com aliqipis da classificacao fiscal
9825:                     IF PEMSTATUS(loc_oPg, "txt_4c_AliqIPI", 5)
9826:                         TEXT TO loc_cSQL TEXTMERGE NOSHOW
9827:                             SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(cursor_4c_ClfV.Codigos))>>)
9828:                         ENDTEXT
9829:                         loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliq")
9830:                         IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliq")
9831:                             loc_oPg.txt_4c_AliqIPI.Value = cursor_4c_ClfAliq.aliqipis
9832:                         ENDIF
9833:                         IF USED("cursor_4c_ClfAliq")
9834:                             USE IN cursor_4c_ClfAliq
9835:                         ENDIF
9836:                     ENDIF
9837:                 ENDIF
9838:             ELSE
9839:                 IF PEMSTATUS(loc_oPg, "txt_4c_Clfiscal", 5)
9840:                     loc_oPg.txt_4c_Clfiscal.Value  = ""
9841:                 ENDIF
9842:                 IF PEMSTATUS(loc_oPg, "txt_4c_Dclfiscal", 5)
9843:                     loc_oPg.txt_4c_Dclfiscal.Value = ""
9844:                 ENDIF

*-- Linhas 10286 a 10306:
10286: 
10287:         TRY
10288:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10289:                 SELECT aliqipis FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Clfiscal.Value))>>)
10290:             ENDTEXT
10291:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfAliqV")
10292:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfAliqV")
10293:                 loc_nAliqClf = cursor_4c_ClfAliqV.aliqipis
10294:                 IF loc_nVal = loc_nAliqClf
10295:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal." + CHR(13) + "Deixe zero para utilizar a classifica" + CHR(231) + CHR(227) + "o fiscal.", "Al" + CHR(237) + "quota IPI")
10296:                 ENDIF
10297:             ENDIF
10298:             IF USED("cursor_4c_ClfAliqV")
10299:                 USE IN cursor_4c_ClfAliqV
10300:             ENDIF
10301:         CATCH TO loc_oErro
10302:             MsgErro("Erro ao validar al" + CHR(237) + "quota IPI:" + CHR(13) + loc_oErro.Message, "FormProduto.ValidarAliqIPI")
10303:         ENDTRY
10304:         THIS.CarregarDadosFiscais()
10305:     ENDPROC
10306: 

*-- Linhas 10651 a 10671:
10651: 
10652:         TRY
10653:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10654:                 SELECT IpiProds FROM SigCdClf WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cClf)>>)
10655:             ENDTEXT
10656:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClfIpi")
10657:             IF loc_nR > 0 AND !EOF("cursor_4c_ClfIpi")
10658:                 loc_lHabilitar = (ALLTRIM(cursor_4c_ClfIpi.IpiProds) = "S")
10659:             ENDIF
10660:             IF USED("cursor_4c_ClfIpi")
10661:                 USE IN cursor_4c_ClfIpi
10662:             ENDIF
10663:         CATCH TO loc_oErro
10664:             MsgErro("Erro ao verificar IpiProds:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFiscal_ExtIpiGotFocus")
10665:         ENDTRY
10666: 
10667:         IF !loc_lHabilitar
10668:             IF PEMSTATUS(loc_oPg, "txt_4c_Extipi", 5)
10669:                 loc_oPg.txt_4c_Extipi.ReadOnly = .T.
10670:             ENDIF
10671:         ENDIF

*-- Linhas 10709 a 10760:
10709: 
10710:         TRY
10711:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10712:                 SELECT Datas AS periodos, ValCuss AS valcustos, Moedas AS moedas
10713:                 FROM SigCdCmv
10714:                 WHERE RTRIM(Cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10715:                 ORDER BY Datas DESC
10716:             ENDTEXT
10717: 
10718:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp")
10719: 
10720:             IF USED("cursor_4c_Cmv")
10721:                 ZAP IN cursor_4c_Cmv
10722:             ENDIF
10723: 
10724:             IF loc_nR > 0
10725:                 IF !USED("cursor_4c_Cmv")
10726:                     SET NULL ON
10727:                     CREATE CURSOR cursor_4c_Cmv (periodos C(10) NULL, valcustos N(12, 2) NULL, moedas C(3) NULL)
10728:                     SET NULL OFF
10729:                 ENDIF
10730:                 IF USED("cursor_4c_CmvTemp")
10731:                     SELECT cursor_4c_Cmv
10732:                     APPEND FROM DBF("cursor_4c_CmvTemp")
10733:                 ENDIF
10734:             ENDIF
10735: 
10736:             IF USED("cursor_4c_CmvTemp")
10737:                 USE IN cursor_4c_CmvTemp
10738:             ENDIF
10739: 
10740:             IF PEMSTATUS(loc_oPg, "grd_4c_Cmv", 5)
10741:                 loc_oPg.grd_4c_Cmv.RecordSource = "cursor_4c_Cmv"
10742:                 WITH loc_oPg.grd_4c_Cmv
10743:                     .Column1.ControlSource = "cursor_4c_Cmv.periodos"
10744:                     .Column2.ControlSource = "cursor_4c_Cmv.valcustos"
10745:                     .Column3.ControlSource = "cursor_4c_Cmv.moedas"
10746:                 ENDWITH
10747:                 loc_oPg.grd_4c_Cmv.Refresh()
10748:             ENDIF
10749:         CATCH TO loc_oErro
10750:             MsgErro("Erro ao carregar dados CMV:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDadosFiscais")
10751:         ENDTRY
10752:     ENDPROC
10753: 
10754:     *--------------------------------------------------------------------------
10755:     * BtnIniTarefaClick - Registra inicio de tarefa do Designer
10756:     * Tabela: sigprtar (cpros, dtinis, usuars)
10757:     *--------------------------------------------------------------------------
10758:     PROCEDURE BtnIniTarefaClick()
10759:         LOCAL loc_cCpros, loc_cSQL, loc_nR
10760:         loc_cCpros = ALLTRIM(THIS.this_oBusinessObject.this_cCpros)

*-- Linhas 10766 a 10787:
10766: 
10767:         TRY
10768:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10769:                 INSERT INTO sigprtar (cpros, dtinis, usuars)
10770:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<FormatarDataSQL(DATE())>>, <<EscaparSQL(gc_4c_UsuarioLogado)>>)
10771:             ENDTEXT
10772:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10773:             IF loc_nR > 0
10774:                 THIS.CarregarDesigner()
10775:             ELSE
10776:                 MsgErro("Erro ao registrar in" + CHR(237) + "cio de tarefa.", "FormProduto.BtnIniTarefaClick")
10777:             ENDIF
10778:         CATCH TO loc_oErro
10779:             MsgErro("Erro ao iniciar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnIniTarefaClick")
10780:         ENDTRY
10781:     ENDPROC
10782: 
10783:     *--------------------------------------------------------------------------
10784:     * BtnFimTarefaClick - Registra fim de tarefa do Designer
10785:     * Atualiza dtfims na ultima tarefa em aberto (dtfims IS NULL)
10786:     *--------------------------------------------------------------------------
10787:     PROCEDURE BtnFimTarefaClick()

*-- Linhas 10795 a 10816:
10795: 
10796:         TRY
10797:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10798:                 UPDATE TOP(1) sigprtar SET dtfims = <<FormatarDataSQL(DATE())>>
10799:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10800:             ENDTEXT
10801:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10802:             IF loc_nR > 0
10803:                 THIS.CarregarDesigner()
10804:             ELSE
10805:                 MsgErro("Nenhuma tarefa em aberto para finalizar.", "FormProduto.BtnFimTarefaClick")
10806:             ENDIF
10807:         CATCH TO loc_oErro
10808:             MsgErro("Erro ao finalizar tarefa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnFimTarefaClick")
10809:         ENDTRY
10810:     ENDPROC
10811: 
10812:     *--------------------------------------------------------------------------
10813:     * BtnInsArqsClick - Insere arquivo do Designer via dialogo de arquivo
10814:     * Tabela: sigprarq (cpros, arquivos)
10815:     *--------------------------------------------------------------------------
10816:     PROCEDURE BtnInsArqsClick()

*-- Linhas 10829 a 10850:
10829: 
10830:         TRY
10831:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10832:                 INSERT INTO sigprarq (cpros, arquivos)
10833:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<EscaparSQL(loc_cArquivo)>>)
10834:             ENDTEXT
10835:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10836:             IF loc_nR > 0
10837:                 THIS.CarregarDesigner()
10838:             ELSE
10839:                 MsgErro("Erro ao inserir arquivo.", "FormProduto.BtnInsArqsClick")
10840:             ENDIF
10841:         CATCH TO loc_oErro
10842:             MsgErro("Erro ao inserir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInsArqsClick")
10843:         ENDTRY
10844:     ENDPROC
10845: 
10846:     *--------------------------------------------------------------------------
10847:     * BtnExcArqsClick - Exclui arquivo selecionado no grid de arquivos
10848:     *--------------------------------------------------------------------------
10849:     PROCEDURE BtnExcArqsClick()
10850:         LOCAL loc_cCpros, loc_cArquivo, loc_cSQL, loc_nR

*-- Linhas 10860 a 10881:
10860:         IF MsgConfirma("Excluir o arquivo selecionado?", "Arquivos Designer")
10861:             TRY
10862:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
10863:                     DELETE FROM sigprarq
10864:                     WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND RTRIM(arquivos) = RTRIM(<<EscaparSQL(loc_cArquivo)>>)
10865:                 ENDTEXT
10866:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
10867:                 IF loc_nR > 0
10868:                     THIS.CarregarDesigner()
10869:                 ELSE
10870:                     MsgErro("Erro ao excluir arquivo.", "FormProduto.BtnExcArqsClick")
10871:                 ENDIF
10872:             CATCH TO loc_oErro
10873:                 MsgErro("Erro ao excluir arquivo:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcArqsClick")
10874:             ENDTRY
10875:         ENDIF
10876:     ENDPROC
10877: 
10878:     *--------------------------------------------------------------------------
10879:     * BtnOpnArqsClick - Abre arquivo selecionado com aplicativo padrao
10880:     *--------------------------------------------------------------------------
10881:     PROCEDURE BtnOpnArqsClick()

*-- Linhas 10919 a 10985:
10919:         TRY
10920:             *-- Tarefas do Designer
10921:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10922:                 SELECT dtinis, dtfims, usuars, tarefas
10923:                 FROM sigprtar
10924:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10925:                 ORDER BY dtinis DESC
10926:             ENDTEXT
10927:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesignerTmp")
10928:             IF loc_nR > 0
10929:                 IF USED("cursor_4c_Designer")
10930:                     SELECT cursor_4c_Designer
10931:                     ZAP
10932:                     APPEND FROM DBF("cursor_4c_DesignerTmp")
10933:                 ENDIF
10934:                 IF USED("cursor_4c_DesignerTmp")
10935:                     USE IN cursor_4c_DesignerTmp
10936:                 ENDIF
10937:                 IF PEMSTATUS(loc_oPg, "grd_4c_Designer", 5)
10938:                     loc_oPg.grd_4c_Designer.Refresh()
10939:                 ENDIF
10940:             ENDIF
10941: 
10942:             *-- Arquivos do Designer
10943:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
10944:                 SELECT arquivos FROM sigprarq
10945:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
10946:                 ORDER BY arquivos
10947:             ENDTEXT
10948:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArquivosTmp")
10949:             IF loc_nR > 0
10950:                 IF USED("cursor_4c_Arquivos")
10951:                     SELECT cursor_4c_Arquivos
10952:                     ZAP
10953:                     APPEND FROM DBF("cursor_4c_ArquivosTmp")
10954:                 ENDIF
10955:                 IF USED("cursor_4c_ArquivosTmp")
10956:                     USE IN cursor_4c_ArquivosTmp
10957:                 ENDIF
10958:                 IF PEMSTATUS(loc_oPg, "grd_4c_Arquivos", 5)
10959:                     loc_oPg.grd_4c_Arquivos.Refresh()
10960:                 ENDIF
10961:             ENDIF
10962: 
10963:             *-- Tarefas dispon?veis para lookup Column4 (SigPrTrf = tabela mestre de tarefas)
10964:             IF USED("cursor_4c_Tarefas")
10965:                 ZAP IN cursor_4c_Tarefas
10966:             ENDIF
10967:             loc_nR = SQLEXEC(gnConnHandle, "SELECT CodCads, DesCads FROM SigPrTrf ORDER BY CodCads", "cursor_4c_TarefasTmp")
10968:             IF loc_nR > 0
10969:                 IF USED("cursor_4c_Tarefas")
10970:                     APPEND FROM DBF("cursor_4c_TarefasTmp")
10971:                 ENDIF
10972:                 IF USED("cursor_4c_TarefasTmp")
10973:                     USE IN cursor_4c_TarefasTmp
10974:                 ENDIF
10975:             ELSE
10976:                 *-- Tabela SigPrTrf nao localizada: cursor fica vazio (lookup manual)
10977:                 IF USED("cursor_4c_TarefasTmp")
10978:                     USE IN cursor_4c_TarefasTmp
10979:                 ENDIF
10980:             ENDIF
10981: 
10982:         CATCH TO loc_oErro
10983:             MsgErro("Erro ao carregar designer:" + CHR(13) + loc_oErro.Message, "FormProduto.CarregarDesigner")
10984:         ENDTRY
10985:     ENDPROC

*-- Linhas 11170 a 11199:
11170:             THIS.this_cUltimoTabCompo_MoecLostFocusValidado = loc_cCod
11171: 
11172:             gb_4c_ValidandoUI = .T.
11173:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11174:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecTmp")
11175:             gb_4c_ValidandoUI = .F.
11176: 
11177:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecTmp")
11178:                 *-- Nao encontrou: abre lookup
11179:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11180:                 loc_oForm.Caption = "Moedas"
11181:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11182:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11183:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11184:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11185:                 loc_oForm.Show()
11186:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11187:                     loc_oPg.txt_4c_PcusMoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11188:                     USE IN cursor_4c_BuscaAux
11189:                 ELSE
11190:                     loc_oPg.txt_4c_PcusMoe.Value = ""
11191:                 ENDIF
11192:                 loc_oForm.Release()
11193:             ENDIF
11194:             IF USED("cursor_4c_MoecTmp")
11195:                 USE IN cursor_4c_MoecTmp
11196:             ENDIF
11197:         CATCH TO loc_oErro
11198:             gb_4c_ValidandoUI = .F.
11199:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecLostFocus")

*-- Linhas 11226 a 11254:
11226:             THIS.this_cUltimoTabCompo_MoecusfLostFocusValidado = loc_cCod
11227: 
11228:             gb_4c_ValidandoUI = .T.
11229:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11230:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoecusfTmp")
11231:             gb_4c_ValidandoUI = .F.
11232: 
11233:             IF loc_nR <= 0 OR EOF("cursor_4c_MoecusfTmp")
11234:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11235:                 loc_oForm.Caption = "Moedas"
11236:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11237:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11238:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11239:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11240:                 loc_oForm.Show()
11241:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11242:                     loc_oPg.txt_4c_MoecusFoe.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11243:                     USE IN cursor_4c_BuscaAux
11244:                 ELSE
11245:                     loc_oPg.txt_4c_MoecusFoe.Value = ""
11246:                 ENDIF
11247:                 loc_oForm.Release()
11248:             ENDIF
11249:             IF USED("cursor_4c_MoecusfTmp")
11250:                 USE IN cursor_4c_MoecusfTmp
11251:             ENDIF
11252:         CATCH TO loc_oErro
11253:             gb_4c_ValidandoUI = .F.
11254:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoecusfLostFocus")

*-- Linhas 11281 a 11309:
11281:             THIS.this_cUltimoTabCompo_MoedaLostFocusValidado = loc_cCod
11282: 
11283:             gb_4c_ValidandoUI = .T.
11284:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11285:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaTmp")
11286:             gb_4c_ValidandoUI = .F.
11287: 
11288:             IF loc_nR <= 0 OR EOF("cursor_4c_MoedaTmp")
11289:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11290:                 loc_oForm.Caption = "Moedas"
11291:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11292:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11293:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11294:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11295:                 loc_oForm.Show()
11296:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11297:                     loc_oPg.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11298:                     USE IN cursor_4c_BuscaAux
11299:                 ELSE
11300:                     loc_oPg.txt_4c_Moeda.Value = ""
11301:                 ENDIF
11302:                 loc_oForm.Release()
11303:             ENDIF
11304:             IF USED("cursor_4c_MoedaTmp")
11305:                 USE IN cursor_4c_MoedaTmp
11306:             ENDIF
11307:         CATCH TO loc_oErro
11308:             gb_4c_ValidandoUI = .F.
11309:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoedaLostFocus")

*-- Linhas 11336 a 11364:
11336:             THIS.this_cUltimoTabCompo_MoepvLostFocusValidado = loc_cCod
11337: 
11338:             gb_4c_ValidandoUI = .T.
11339:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11340:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoepvTmp")
11341:             gb_4c_ValidandoUI = .F.
11342: 
11343:             IF loc_nR <= 0 OR EOF("cursor_4c_MoepvTmp")
11344:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11345:                 loc_oForm.Caption = "Moedas"
11346:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11347:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11348:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11349:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11350:                 loc_oForm.Show()
11351:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11352:                     loc_oPg.txt_4c_Moepv.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11353:                     USE IN cursor_4c_BuscaAux
11354:                 ELSE
11355:                     loc_oPg.txt_4c_Moepv.Value = ""
11356:                 ENDIF
11357:                 loc_oForm.Release()
11358:             ENDIF
11359:             IF USED("cursor_4c_MoepvTmp")
11360:                 USE IN cursor_4c_MoepvTmp
11361:             ENDIF
11362:         CATCH TO loc_oErro
11363:             gb_4c_ValidandoUI = .F.
11364:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoepvLostFocus")

*-- Linhas 11391 a 11419:
11391:             THIS.this_cUltimoTabCompo_MoevLostFocusValidado = loc_cCod
11392: 
11393:             gb_4c_ValidandoUI = .T.
11394:             loc_cSQL = "SELECT CMoes FROM SigCdMoe WHERE RTRIM(CMoes)=" + EscaparSQL(loc_cCod)
11395:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoevTmp")
11396:             gb_4c_ValidandoUI = .F.
11397: 
11398:             IF loc_nR <= 0 OR EOF("cursor_4c_MoevTmp")
11399:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11400:                 loc_oForm.Caption = "Moedas"
11401:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11402:                 loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11403:                 loc_oForm.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11404:                 loc_oForm.mSQL = "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes"
11405:                 loc_oForm.Show()
11406:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11407:                     loc_oPg.txt_4c_Moev.Value = ALLTRIM(cursor_4c_BuscaAux.CMoes)
11408:                     USE IN cursor_4c_BuscaAux
11409:                 ELSE
11410:                     loc_oPg.txt_4c_Moev.Value = ""
11411:                 ENDIF
11412:                 loc_oForm.Release()
11413:             ENDIF
11414:             IF USED("cursor_4c_MoevTmp")
11415:                 USE IN cursor_4c_MoevTmp
11416:             ENDIF
11417:         CATCH TO loc_oErro
11418:             gb_4c_ValidandoUI = .F.
11419:             MsgErro(loc_oErro.Message, "FormProduto.TabCompo_MoevLostFocus")

*-- Linhas 11447 a 11475:
11447:             THIS.this_cUltimoTabCompo_FtioLostFocusValidado = loc_cCod
11448: 
11449:             gb_4c_ValidandoUI = .T.
11450:             loc_cSQL = "SELECT Cods, Descs, Acrescs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos<>1"
11451:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FtioTmp")
11452:             gb_4c_ValidandoUI = .F.
11453: 
11454:             IF loc_nR <= 0 OR EOF("cursor_4c_FtioTmp")
11455:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11456:                 loc_oForm.Caption = "Feitios"
11457:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11458:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11459:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11460:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos<>1 ORDER BY Cods"
11461:                 loc_oForm.Show()
11462:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11463:                     loc_oPg.txt_4c_Ftio.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11464:                     USE IN cursor_4c_BuscaAux
11465:                 ELSE
11466:                     loc_oPg.txt_4c_Ftio.Value = ""
11467:                     IF USED("cursor_4c_FtioTmp")
11468:                         USE IN cursor_4c_FtioTmp
11469:                     ENDIF
11470:                     THIS.CarregarComposicao()
11471:                     RETURN
11472:                 ENDIF
11473:                 loc_oForm.Release()
11474:             ENDIF
11475:             IF USED("cursor_4c_FtioTmp")

*-- Linhas 11509 a 11537:
11509:             THIS.this_cUltimoTabCompo_CmkpcLostFocusValidado = loc_cCod
11510: 
11511:             gb_4c_ValidandoUI = .T.
11512:             loc_cSQL = "SELECT Cods, Descs FROM SigPrFti WHERE RTRIM(Cods)=" + EscaparSQL(loc_cCod) + " AND Tipos=1"
11513:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmkpcTmp")
11514:             gb_4c_ValidandoUI = .F.
11515: 
11516:             IF loc_nR <= 0 OR EOF("cursor_4c_CmkpcTmp")
11517:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11518:                 loc_oForm.Caption = "Feitios de Custo"
11519:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11520:                 loc_oForm.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
11521:                 loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11522:                 loc_oForm.mSQL = "SELECT Cods, Descs FROM SigPrFti WHERE Tipos=1 ORDER BY Cods"
11523:                 loc_oForm.Show()
11524:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11525:                     loc_oPg.txt_4c_Cmkpc.Value = ALLTRIM(cursor_4c_BuscaAux.Cods)
11526:                     USE IN cursor_4c_BuscaAux
11527:                 ELSE
11528:                     loc_oPg.txt_4c_Cmkpc.Value = ""
11529:                     IF USED("cursor_4c_CmkpcTmp")
11530:                         USE IN cursor_4c_CmkpcTmp
11531:                     ENDIF
11532:                     THIS.CarregarComposicao()
11533:                     RETURN
11534:                 ENDIF
11535:                 loc_oForm.Release()
11536:             ENDIF
11537:             IF USED("cursor_4c_CmkpcTmp")

*-- Linhas 11606 a 11634:
11606:             THIS.this_cUltimoTabCompo_DescLostFocusValidado = loc_cDesc
11607: 
11608:             gb_4c_ValidandoUI = .T.
11609:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11610:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTmp")
11611:             gb_4c_ValidandoUI = .F.
11612: 
11613:             IF loc_nR <= 0 OR EOF("cursor_4c_DescTmp")
11614:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11615:                 loc_oForm.Caption = "Produtos"
11616:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11617:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11618:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11619:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11620:                 loc_oForm.Show()
11621:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11622:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11623:                     IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11624:                         loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11625:                     ENDIF
11626:                     USE IN cursor_4c_BuscaAux
11627:                 ELSE
11628:                     loc_oPg.txt_4c_Desc.Value = ""
11629:                 ENDIF
11630:                 loc_oForm.Release()
11631:             ELSE
11632:                 IF PEMSTATUS(loc_oPg, "txt_4c_MatP", 5)
11633:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_DescTmp.CPros)
11634:                 ENDIF

*-- Linhas 11668 a 11696:
11668:             THIS.this_cUltimoTabCompo_MatPLostFocusValidado = loc_cCod
11669: 
11670:             gb_4c_ValidandoUI = .T.
11671:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11672:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatPTmp")
11673:             gb_4c_ValidandoUI = .F.
11674: 
11675:             IF loc_nR <= 0 OR EOF("cursor_4c_MatPTmp")
11676:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11677:                 loc_oForm.Caption = "Material Principal"
11678:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11679:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11680:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11681:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11682:                 loc_oForm.Show()
11683:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11684:                     loc_oPg.txt_4c_MatP.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11685:                     IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11686:                         loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11687:                     ENDIF
11688:                     USE IN cursor_4c_BuscaAux
11689:                 ELSE
11690:                     loc_oPg.txt_4c_MatP.Value = ""
11691:                 ENDIF
11692:                 loc_oForm.Release()
11693:             ELSE
11694:                 IF PEMSTATUS(loc_oPg, "txt_4c_Desc", 5)
11695:                     loc_oPg.txt_4c_Desc.Value = ALLTRIM(cursor_4c_MatPTmp.DPros)
11696:                 ENDIF

*-- Linhas 11730 a 11758:
11730:             THIS.this_cUltimoTabCompo_DesccpLostFocusValidado = loc_cDesc
11731: 
11732:             gb_4c_ValidandoUI = .T.
11733:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(DPros)=" + EscaparSQL(loc_cDesc)
11734:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DesccpTmp")
11735:             gb_4c_ValidandoUI = .F.
11736: 
11737:             IF loc_nR <= 0 OR EOF("cursor_4c_DesccpTmp")
11738:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11739:                 loc_oForm.Caption = "Sub-Componentes"
11740:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11741:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11742:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11743:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY DPros"
11744:                 loc_oForm.Show()
11745:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11746:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11747:                     IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11748:                         loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11749:                     ENDIF
11750:                     USE IN cursor_4c_BuscaAux
11751:                 ELSE
11752:                     loc_oPg.txt_4c__desccp.Value = ""
11753:                 ENDIF
11754:                 loc_oForm.Release()
11755:             ELSE
11756:                 IF PEMSTATUS(loc_oPg, "txt_4c__matsub", 5)
11757:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_DesccpTmp.CPros)
11758:                 ENDIF

*-- Linhas 11792 a 11820:
11792:             THIS.this_cUltimoTabCompo_MatsubLostFocusValidado = loc_cCod
11793: 
11794:             gb_4c_ValidandoUI = .T.
11795:             loc_cSQL = "SELECT CPros, DPros FROM SigCdPro WHERE RTRIM(CPros)=" + EscaparSQL(loc_cCod)
11796:             loc_nR   = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MatsubTmp")
11797:             gb_4c_ValidandoUI = .F.
11798: 
11799:             IF loc_nR <= 0 OR EOF("cursor_4c_MatsubTmp")
11800:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
11801:                 loc_oForm.Caption = "Produto Substituto"
11802:                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaAux"
11803:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
11804:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
11805:                 loc_oForm.mSQL = "SELECT CPros, DPros FROM SigCdPro ORDER BY CPros"
11806:                 loc_oForm.Show()
11807:                 IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaAux")
11808:                     loc_oPg.txt_4c__matsub.Value = ALLTRIM(cursor_4c_BuscaAux.CPros)
11809:                     IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11810:                         loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_BuscaAux.DPros)
11811:                     ENDIF
11812:                     USE IN cursor_4c_BuscaAux
11813:                 ELSE
11814:                     loc_oPg.txt_4c__matsub.Value = ""
11815:                 ENDIF
11816:                 loc_oForm.Release()
11817:             ELSE
11818:                 IF PEMSTATUS(loc_oPg, "txt_4c__desccp", 5)
11819:                     loc_oPg.txt_4c__desccp.Value = ALLTRIM(cursor_4c_MatsubTmp.DPros)
11820:                 ENDIF

*-- Linhas 11844 a 11864:
11844:         ENDIF
11845: 
11846:         TRY
11847:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves) VALUES (" + ;
11848:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID())"
11849:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11850:             IF loc_nR > 0
11851:                 THIS.CarregarComposicao()
11852:                 IF PEMSTATUS(loc_oPg, "grd_4c_Compo", 5)
11853:                     loc_oPg.grd_4c_Compo.SetFocus()
11854:                 ENDIF
11855:             ELSE
11856:                 MsgErro("Erro ao incluir linha na composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoIncluirClick")
11857:             ENDIF
11858:         CATCH TO loc_oErro
11859:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoIncluirClick")
11860:         ENDTRY
11861:     ENDPROC
11862: 
11863:     *--------------------------------------------------------------------------
11864:     * CmdCompoExcluirClick - Botao excluir linha da composicao (grdCompo)

*-- Linhas 11880 a 11900:
11880:             IF EMPTY(loc_cMats)
11881:                 RETURN
11882:             ENDIF
11883:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11884:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11885:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11886:             IF loc_nR > 0
11887:                 THIS.CarregarComposicao()
11888:             ELSE
11889:                 MsgErro("Erro ao excluir linha da composi" + CHR(231) + CHR(227) + "o.", "FormProduto.CmdCompoExcluirClick")
11890:             ENDIF
11891:         CATCH TO loc_oErro
11892:             MsgErro(loc_oErro.Message, "FormProduto.CmdCompoExcluirClick")
11893:         ENDTRY
11894:     ENDPROC
11895: 
11896:     *--------------------------------------------------------------------------
11897:     * CmdCompoAtualizarClick - Botao atualizar/recalcular precos da composicao
11898:     *--------------------------------------------------------------------------
11899:     PROCEDURE CmdCompoAtualizarClick()
11900:         TRY

*-- Linhas 11951 a 11971:
11951:                 MsgErro("Item da composi" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido.", "FormProduto.CmdSubCpIncluirClick")
11952:                 RETURN
11953:             ENDIF
11954:             loc_cSQL = "INSERT INTO sigsubcp (cpros, dtmovs, cidchaves, matsubs) VALUES (" + ;
11955:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + EscaparSQL(loc_cMats) + ")"
11956:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11957:             IF loc_nR > 0
11958:                 THIS.CarregarComposicao()
11959:                 IF PEMSTATUS(loc_oPg, "grd_4c_SubCompo", 5)
11960:                     loc_oPg.grd_4c_SubCompo.SetFocus()
11961:                 ENDIF
11962:             ELSE
11963:                 MsgErro("Erro ao incluir sub-componente.", "FormProduto.CmdSubCpIncluirClick")
11964:             ENDIF
11965:         CATCH TO loc_oErro
11966:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpIncluirClick")
11967:         ENDTRY
11968:     ENDPROC
11969: 
11970:     *--------------------------------------------------------------------------
11971:     * CmdSubCpExcluirClick - Botao excluir sub-componente (grdsubcp)

*-- Linhas 11986 a 12006:
11986:             IF EMPTY(loc_cMats)
11987:                 RETURN
11988:             ENDIF
11989:             loc_cSQL = "DELETE FROM sigsubcp WHERE RTRIM(cpros)=" + EscaparSQL(loc_cCpros) + ;
11990:                        " AND RTRIM(mats)=" + EscaparSQL(loc_cMats)
11991:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
11992:             IF loc_nR > 0
11993:                 THIS.CarregarComposicao()
11994:             ELSE
11995:                 MsgErro("Erro ao excluir sub-componente.", "FormProduto.CmdSubCpExcluirClick")
11996:             ENDIF
11997:         CATCH TO loc_oErro
11998:             MsgErro(loc_oErro.Message, "FormProduto.CmdSubCpExcluirClick")
11999:         ENDTRY
12000:     ENDPROC
12001: 
12002:     *--------------------------------------------------------------------------
12003:     * CmdCalcValsClick - Botao calcular valores de preco/custo
12004:     *--------------------------------------------------------------------------
12005:     PROCEDURE CmdCalcValsClick()
12006:         TRY

*-- Linhas 12024 a 12046:
12024: 
12025:         TRY
12026:             *-- Busca peso calculado a partir da composicao
12027:             loc_cSQL = "SELECT SUM(c.qtds * p.pesobs) AS peso_calc " + ;
12028:                        "FROM SIGPRCPO c " + ;
12029:                        "LEFT JOIN SigCdPro p ON RTRIM(c.mats) = RTRIM(p.cpros) " + ;
12030:                        "WHERE RTRIM(c.cpros) = " + EscaparSQL(loc_cCpros)
12031:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PesoMTmp")
12032:             IF loc_nR > 0 AND !EOF("cursor_4c_PesoMTmp")
12033:                 IF PEMSTATUS(loc_oPg, "txt_4c_Pesom", 5)
12034:                     loc_oPg.txt_4c_Pesom.Value = NVL(cursor_4c_PesoMTmp.peso_calc, 0)
12035:                 ENDIF
12036:             ENDIF
12037:             IF USED("cursor_4c_PesoMTmp")
12038:                 USE IN cursor_4c_PesoMTmp
12039:             ENDIF
12040:         CATCH TO loc_oErro
12041:             MsgErro(loc_oErro.Message, "FormProduto.CmdPesoMClick")
12042:         ENDTRY
12043:     ENDPROC
12044: 
12045:     *--------------------------------------------------------------------------
12046:     * CustosGrd_AfterRowColChange - Grid custos: ao mudar linha/coluna

*-- Linhas 12060 a 12082:
12060:                 *-- Buscar descricao do grupo com base no material
12061:                 loc_cMats = ALLTRIM(NVL(cursor_4c_CompoCusto.mats, ""))
12062:                 IF !EMPTY(loc_cMats) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
12063:                     loc_cSQL = "SELECT g.dgrus FROM SigCdPro p " + ;
12064:                                "INNER JOIN SigCdGrp g ON RTRIM(p.cgrus) = RTRIM(g.cgrus) " + ;
12065:                                "WHERE RTRIM(p.cpros) = " + EscaparSQL(loc_cMats)
12066:                     gb_4c_ValidandoUI = .T.
12067:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoTmpC")
12068:                     gb_4c_ValidandoUI = .F.
12069:                     IF loc_nR > 0 AND !EOF("cursor_4c_GrupoTmpC")
12070:                         IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
12071:                             loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(NVL(cursor_4c_GrupoTmpC.dgrus, ""))
12072:                         ENDIF
12073:                     ENDIF
12074:                     IF USED("cursor_4c_GrupoTmpC")
12075:                         USE IN cursor_4c_GrupoTmpC
12076:                     ENDIF
12077:                 ELSE
12078:                     IF PEMSTATUS(loc_oPg, "txt_4c_DGruCompos", 5)
12079:                         loc_oPg.txt_4c_DGruCompos.Value = ""
12080:                     ENDIF
12081:                 ENDIF
12082:             ENDIF

*-- Linhas 12111 a 12167:
12111:             CASE par_nColIndex = 4
12112:                 loc_cGrupos = ALLTRIM(NVL(cursor_4c_Consulta.grupos, ""))
12113:                 IF !EMPTY(loc_cGrupos)
12114:                     loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = " + EscaparSQL(loc_cGrupos)
12115:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfDesc")
12116:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfDesc")
12117:                         REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfDesc.descrs, ""))
12118:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12119:                             loc_oPg.grd_4c_Consulta.Refresh()
12120:                         ENDIF
12121:                     ELSE
12122:                         THIS.AbrirLookupConsultaFase()
12123:                     ENDIF
12124:                     IF USED("cursor_4c_PrfDesc")
12125:                         USE IN cursor_4c_PrfDesc
12126:                     ENDIF
12127:                 ENDIF
12128: 
12129:             *-- Coluna 5 (Descricao fase): busca grupos em SigCdPrf por descricao
12130:             CASE par_nColIndex = 5
12131:                 loc_cDcompos = ALLTRIM(NVL(cursor_4c_Consulta.dcompos, ""))
12132:                 IF !EMPTY(loc_cDcompos)
12133:                     loc_cSQL = "SELECT TOP 1 Codigos AS grupos, Descrs AS descrs FROM SigCdGcr WHERE RTRIM(Descrs) = " + EscaparSQL(loc_cDcompos)
12134:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfGrp")
12135:                     IF loc_nR > 0 AND !EOF("cursor_4c_PrfGrp")
12136:                         REPLACE cursor_4c_Consulta.grupos  WITH ALLTRIM(NVL(cursor_4c_PrfGrp.grupos, ""))
12137:                         REPLACE cursor_4c_Consulta.dcompos WITH ALLTRIM(NVL(cursor_4c_PrfGrp.descrs, ""))
12138:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12139:                             loc_oPg.grd_4c_Consulta.Refresh()
12140:                         ENDIF
12141:                     ENDIF
12142:                     IF USED("cursor_4c_PrfGrp")
12143:                         USE IN cursor_4c_PrfGrp
12144:                     ENDIF
12145:                 ENDIF
12146: 
12147:             *-- Coluna 8 (Cat): busca descricao em SigCdCat
12148:             CASE par_nColIndex = 8
12149:                 loc_cCats = ALLTRIM(NVL(cursor_4c_Consulta.cats, ""))
12150:                 IF !EMPTY(loc_cCats)
12151:                     loc_cSQL = "SELECT TOP 1 descs FROM SigCdCat WHERE RTRIM(cods) = " + EscaparSQL(loc_cCats)
12152:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CatDesc")
12153:                     IF loc_nR > 0 AND !EOF("cursor_4c_CatDesc")
12154:                         REPLACE cursor_4c_Consulta.dscgrp WITH ALLTRIM(NVL(cursor_4c_CatDesc.descs, ""))
12155:                         IF PEMSTATUS(loc_oPg, "grd_4c_Consulta", 5)
12156:                             loc_oPg.grd_4c_Consulta.Refresh()
12157:                         ENDIF
12158:                     ELSE
12159:                         THIS.AbrirLookupConsultaCat()
12160:                     ENDIF
12161:                     IF USED("cursor_4c_CatDesc")
12162:                         USE IN cursor_4c_CatDesc
12163:                     ENDIF
12164:                 ENDIF
12165: 
12166:             ENDCASE
12167:         CATCH TO loc_oErro

*-- Linhas 12296 a 12316:
12296:                 ENDIF
12297:             ENDIF
12298: 
12299:             loc_cSQL = "INSERT INTO SIGPRCPO (cpros, dtmovs, cidchaves, tipos) VALUES (" + ;
12300:                        EscaparSQL(loc_cCpros) + ", GETDATE(), NEWID(), " + TRANSFORM(loc_nTipo) + ")"
12301:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12302:             IF loc_nR > 0
12303:                 THIS.CarregarCustos()
12304:                 IF PEMSTATUS(loc_oPg, "grd_4c_CompoCusto", 5)
12305:                     loc_oPg.grd_4c_CompoCusto.SetFocus()
12306:                 ENDIF
12307:             ELSE
12308:                 MsgErro("Erro ao incluir linha no custo.", "FormProduto.CmdCustoIncluirClick")
12309:             ENDIF
12310:         CATCH TO loc_oErro
12311:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoIncluirClick")
12312:         ENDTRY
12313:     ENDPROC
12314: 
12315:     *--------------------------------------------------------------------------
12316:     * CmdCustoExcluirClick - Botao excluir linha do grid de custo

*-- Linhas 12341 a 12361:
12341:                 RETURN
12342:             ENDIF
12343: 
12344:             loc_cSQL = "DELETE FROM SIGPRCPO WHERE RTRIM(cpros) = " + EscaparSQL(loc_cCpros) + ;
12345:                        " AND RTRIM(mats) = " + EscaparSQL(loc_cMats)
12346:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12347:             IF loc_nR > 0
12348:                 THIS.CarregarCustos()
12349:             ELSE
12350:                 MsgErro("Erro ao excluir linha do custo.", "FormProduto.CmdCustoExcluirClick")
12351:             ENDIF
12352:         CATCH TO loc_oErro
12353:             MsgErro(loc_oErro.Message, "FormProduto.CmdCustoExcluirClick")
12354:         ENDTRY
12355:     ENDPROC
12356: 
12357:     *==========================================================================
12358:     * METODOS DA ABA FASES (Tab 7 - PgDadosFaseP)
12359:     *==========================================================================
12360: 
12361:     *--------------------------------------------------------------------------

*-- Linhas 12387 a 12431:
12387:             *-- Carregar imagem FigProcs da fase atual (campo binario em SigCdPrf)
12388:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND loc_nOrdems > 0
12389:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
12390:                     SELECT TOP 1 FigProcs FROM SigCdPrf
12391:                     WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12392:                     AND ordems = <<loc_nOrdems>>
12393:                 ENDTEXT
12394:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigFase")
12395:                 IF loc_nR > 0 AND !EOF("cursor_4c_FigFase")
12396:                     IF !EMPTY(NVL(cursor_4c_FigFase.FigProcs, ""))
12397:                         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12398:                         IF (STRTOFILE(cursor_4c_FigFase.FigProcs, loc_cArquivo) > 0)
12399:                             IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
12400:                                 loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
12401:                                 loc_oPg.img_4c_ImgFigJpg.Visible = .T.
12402:                             ENDIF
12403:                         ENDIF
12404:                     ENDIF
12405:                 ENDIF
12406:                 IF USED("cursor_4c_FigFase")
12407:                     USE IN cursor_4c_FigFase
12408:                 ENDIF
12409:             ENDIF
12410: 
12411:             *-- Carregar descricao e observacao da fase (SigCdGcr)
12412:             IF !EMPTY(loc_cGrupos) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
12413:                 TEXT TO loc_cSQL TEXTMERGE NOSHOW
12414:                     SELECT TOP 1 Descrs FROM SigCdGcr WHERE RTRIM(Codigos) = RTRIM(<<EscaparSQL(loc_cGrupos)>>)
12415:                 ENDTEXT
12416:                 loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FaseDesc")
12417:                 IF loc_nR > 0 AND !EOF("cursor_4c_FaseDesc")
12418:                     IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
12419:                         loc_oPg.txt_4c_DescFase.Value = ALLTRIM(NVL(cursor_4c_FaseDesc.Descrs, ""))
12420:                     ENDIF
12421:                 ELSE
12422:                     IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
12423:                         loc_oPg.txt_4c_DescFase.Value = ""
12424:                     ENDIF
12425:                 ENDIF
12426:                 IF USED("cursor_4c_FaseDesc")
12427:                     USE IN cursor_4c_FaseDesc
12428:                 ENDIF
12429:             ELSE
12430:                 IF PEMSTATUS(loc_oPg, "txt_4c_DescFase", 5)
12431:                     loc_oPg.txt_4c_DescFase.Value = ""

*-- Linhas 12468 a 12488:
12468: 
12469:             *-- Carregar imagem FigJpgs do produto matriz (SigCdPro)
12470:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12471:                 SELECT TOP 1 FigJpgs FROM SigCdPro WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
12472:             ENDTEXT
12473:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FigBorr")
12474:             IF loc_nR > 0 AND !EOF("cursor_4c_FigBorr")
12475:                 loc_cFigB64 = NVL(cursor_4c_FigBorr.FigJpgs, "")
12476:                 IF !EMPTY(loc_cFigB64)
12477:                     *-- Converter de Base64 para binario
12478:                     LOCAL loc_cFigBin
12479:                     loc_cFigBin = STRCONV( ;
12480:                         STRTRAN(STRTRAN(STRTRAN(loc_cFigB64, ;
12481:                             "data:image/png;base64,", ""), ;
12482:                             "data:image/jpeg;base64,", ""), ;
12483:                             "data:image/jpg;base64,", ""), 14)
12484:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
12485:                     IF STRTOFILE(loc_cFigBin, loc_cArquivo) > 0
12486:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
12487:                             loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
12488:                             loc_oPg.img_4c_ImgBorracha.Visible = .T.

*-- Linhas 12542 a 12562:
12542:         ENDIF
12543:         TRY
12544:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12545:                 SELECT TOP 1 cods FROM SigCdCor WHERE cods = <<EscaparSQL(loc_cCod)>>
12546:             ENDTEXT
12547:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCorFas")
12548:             IF loc_nR <= 0 OR EOF("cursor_4c_VCorFas")
12549:                 THIS.AbrirLookupCorFas()
12550:             ELSE
12551:                 THIS.this_oBusinessObject.this_cCodcors = loc_cCod
12552:             ENDIF
12553:             IF USED("cursor_4c_VCorFas")
12554:                 USE IN cursor_4c_VCorFas
12555:             ENDIF
12556:         CATCH TO loc_oErro
12557:             MsgErro("Erro ao validar cor:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodcorsLostFocus")
12558:         ENDTRY
12559:     ENDPROC
12560: 
12561:     *--------------------------------------------------------------------------
12562:     * AbrirLookupCorFas - Lookup Cor para a aba Fases

*-- Linhas 12630 a 12650:
12630:         ENDIF
12631:         TRY
12632:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12633:                 SELECT TOP 1 Cods FROM SigCdTam WHERE Cods = <<EscaparSQL(loc_cCod)>>
12634:             ENDTEXT
12635:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VTamFas")
12636:             IF loc_nR <= 0 OR EOF("cursor_4c_VTamFas")
12637:                 THIS.AbrirLookupTamanhoFas()
12638:             ELSE
12639:                 THIS.this_oBusinessObject.this_cCodtams = loc_cCod
12640:             ENDIF
12641:             IF USED("cursor_4c_VTamFas")
12642:                 USE IN cursor_4c_VTamFas
12643:             ENDIF
12644:         CATCH TO loc_oErro
12645:             MsgErro("Erro ao validar tamanho:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodtamsLostFocus")
12646:         ENDTRY
12647:     ENDPROC
12648: 
12649:     *--------------------------------------------------------------------------
12650:     * AbrirLookupTamanhoFas - Lookup Tamanho para a aba Fases

*-- Linhas 12720 a 12740:
12720:         ENDIF
12721:         TRY
12722:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12723:                 SELECT TOP 1 cods, descrs FROM SigCdAca WHERE cods = <<EscaparSQL(loc_cCod)>>
12724:             ENDTEXT
12725:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VAcbFas")
12726:             IF loc_nR > 0 AND !EOF("cursor_4c_VAcbFas")
12727:                 IF PEMSTATUS(loc_oPg, "txt_4c_DacbsFas", 5)
12728:                     loc_oPg.txt_4c_DacbsFas.Value = ALLTRIM(cursor_4c_VAcbFas.descrs)
12729:                 ENDIF
12730:                 THIS.this_oBusinessObject.this_cCodacbs = loc_cCod
12731:             ELSE
12732:                 THIS.AbrirLookupAcabamentoFas()
12733:             ENDIF
12734:             IF USED("cursor_4c_VAcbFas")
12735:                 USE IN cursor_4c_VAcbFas
12736:             ENDIF
12737:         CATCH TO loc_oErro
12738:             MsgErro("Erro ao validar acabamento:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_CodacbsLostFocus")
12739:         ENDTRY
12740:     ENDPROC

*-- Linhas 12820 a 12840:
12820:         ENDIF
12821:         TRY
12822:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12823:                 SELECT TOP 1 conquilhas FROM SigCdCnq WHERE RTRIM(conquilhas) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12824:             ENDTEXT
12825:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCnq")
12826:             IF loc_nR <= 0 OR EOF("cursor_4c_VCnq")
12827:                 THIS.AbrirLookupConquilha()
12828:             ELSE
12829:                 THIS.this_oBusinessObject.this_cConquilhas = loc_cCod
12830:             ENDIF
12831:             IF USED("cursor_4c_VCnq")
12832:                 USE IN cursor_4c_VCnq
12833:             ENDIF
12834:         CATCH TO loc_oErro
12835:             MsgErro("Erro ao validar conquilha:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_ConquilhaLostFocus")
12836:         ENDTRY
12837:     ENDPROC
12838: 
12839:     *--------------------------------------------------------------------------
12840:     * AbrirLookupConquilha - Lookup para campo Conquilha (SigCdCnq)

*-- Linhas 12902 a 12922:
12902:         ENDIF
12903:         TRY
12904:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12905:                 SELECT TOP 1 codgarras FROM SigCdGar WHERE RTRIM(codgarras) = RTRIM(<<EscaparSQL(loc_cCod)>>)
12906:             ENDTEXT
12907:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGar")
12908:             IF loc_nR <= 0 OR EOF("cursor_4c_VGar")
12909:                 THIS.AbrirLookupGarra()
12910:             ELSE
12911:                 THIS.this_oBusinessObject.this_cCodgarras = loc_cCod
12912:             ENDIF
12913:             IF USED("cursor_4c_VGar")
12914:                 USE IN cursor_4c_VGar
12915:             ENDIF
12916:         CATCH TO loc_oErro
12917:             MsgErro("Erro ao validar garra:" + CHR(13) + loc_oErro.Message, "FormProduto.TabFases_GarraLostFocus")
12918:         ENDTRY
12919:     ENDPROC
12920: 
12921:     *--------------------------------------------------------------------------
12922:     * AbrirLookupGarra - Lookup para campo Garra (SigCdGar)

*-- Linhas 12975 a 13011:
12975:         TRY
12976:             *-- Calcular proximo numero de ordem
12977:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12978:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
12979:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
12980:             ENDTEXT
12981:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdem")
12982:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdem")
12983:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdem.proximo, 1)
12984:             ELSE
12985:                 loc_nProxOrdem = 1
12986:             ENDIF
12987:             IF USED("cursor_4c_MaxOrdem")
12988:                 USE IN cursor_4c_MaxOrdem
12989:             ENDIF
12990: 
12991:             *-- Inserir nova fase
12992:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
12993:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
12994:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, '', 0, '', '')
12995:             ENDTEXT
12996:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
12997:             IF loc_nR > 0
12998:                 THIS.CarregarFases()
12999:                 LOCAL loc_oPg7
13000:                 loc_oPg7 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13001:                 IF PEMSTATUS(loc_oPg7, "grd_4c_Fases", 5)
13002:                     loc_oPg7.grd_4c_Fases.SetFocus()
13003:                 ENDIF
13004:             ELSE
13005:                 MsgErro("Erro ao inserir fase.", "FormProduto.BtnInserirFaseClick")
13006:             ENDIF
13007:         CATCH TO loc_oErro
13008:             MsgErro("Erro ao inserir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirFaseClick")
13009:         ENDTRY
13010:     ENDPROC
13011: 

*-- Linhas 13039 a 13061:
13039: 
13040:         TRY
13041:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13042:                 DELETE FROM SigCdPrf
13043:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
13044:                 AND ordems = <<loc_nOrdems>>
13045:             ENDTEXT
13046:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13047:             IF loc_nR > 0
13048:                 THIS.CarregarFases()
13049:             ELSE
13050:                 MsgErro("Erro ao excluir fase.", "FormProduto.BtnExcluirFaseClick")
13051:             ENDIF
13052:         CATCH TO loc_oErro
13053:             MsgErro("Erro ao excluir fase:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirFaseClick")
13054:         ENDTRY
13055:     ENDPROC
13056: 
13057:     *--------------------------------------------------------------------------
13058:     * BtnAlternativaFaseClick - Inserir fase alternativa (alternativa da fase atual)
13059:     *--------------------------------------------------------------------------
13060:     PROCEDURE BtnAlternativaFaseClick()
13061:         LOCAL loc_cCpros, loc_cGrupoAtual, loc_cSQL, loc_nR, loc_nProxOrdem

*-- Linhas 13085 a 13121:
13085:         TRY
13086:             *-- Calcular proximo numero de ordem
13087:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13088:                 SELECT ISNULL(MAX(ordems), 0) + 1 AS proximo FROM SigCdPrf
13089:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>)
13090:             ENDTEXT
13091:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxOrdAlt")
13092:             IF loc_nR > 0 AND !EOF("cursor_4c_MaxOrdAlt")
13093:                 loc_nProxOrdem = NVL(cursor_4c_MaxOrdAlt.proximo, 1)
13094:             ELSE
13095:                 loc_nProxOrdem = 1
13096:             ENDIF
13097:             IF USED("cursor_4c_MaxOrdAlt")
13098:                 USE IN cursor_4c_MaxOrdAlt
13099:             ENDIF
13100: 
13101:             *-- Inserir fase alternativa copiando o grupo da fase atual
13102:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13103:                 INSERT INTO SigCdPrf (produtos, ordems, grupos, minutos, uniprdts, matprdts)
13104:                 VALUES (<<EscaparSQL(loc_cCpros)>>, <<loc_nProxOrdem>>, <<EscaparSQL(loc_cGrupoAtual)>>, 0, '', '')
13105:             ENDTEXT
13106:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13107:             IF loc_nR > 0
13108:                 THIS.CarregarFases()
13109:             ELSE
13110:                 MsgErro("Erro ao inserir fase alternativa.", "FormProduto.BtnAlternativaFaseClick")
13111:             ENDIF
13112:         CATCH TO loc_oErro
13113:             MsgErro("Erro ao inserir alternativa:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnAlternativaFaseClick")
13114:         ENDTRY
13115:     ENDPROC
13116: 
13117:     *--------------------------------------------------------------------------
13118:     * CmdFichaClick - Imprimir ficha tecnica das fases do produto
13119:     *--------------------------------------------------------------------------
13120:     PROCEDURE CmdFichaClick()
13121:         LOCAL loc_cCpros, loc_cSQL, loc_nR, loc_oBO

*-- Linhas 13133 a 13157:
13133:             IF USED("CsCabecalho")
13134:                 USE IN CsCabecalho
13135:             ENDIF
13136:             CREATE CURSOR CsCabecalho ( ;
13137:                 _NmEmp  C(80), _NmTit C(99), _cPros C(14), _dPros C(65), ;
13138:                 _cGrus  C(03), _dGrus C(20), _sGrus C(06), _sDesc C(20), ;
13139:                 _cLinh  C(10), _dLinh C(40), _cGVen C(10), _dGVen C(40), ;
13140:                 _nPeso  N(9,2), _DtIni D(08), _DtFin D(08), _TExec C(15), _cMode C(10))
13141: 
13142:             INSERT INTO CsCabecalho ;
13143:                 (_NmEmp, _NmTit, _cPros, _dPros, _cGrus, _dGrus, _cMode) ;
13144:                 VALUES( ;
13145:                     go_4c_Sistema.cEmpresa, ;
13146:                     "Ficha T" + CHR(233) + "cnica de Fases", ;
13147:                     loc_cCpros, ;
13148:                     loc_oBO.this_cDpros, ;
13149:                     loc_oBO.this_cCgrus, ;
13150:                     THIS.CarregarDesc("SigCdGrp", "cgrus", loc_oBO.this_cCgrus, "dgrus"), ;
13151:                     THIS.this_cModoAtual)
13152: 
13153:             MsgInfo("Ficha t" + CHR(233) + "cnica gerada. Configure o relat" + CHR(243) + "rio RelFase.frx para impress" + CHR(227) + "o.", "Ficha T" + CHR(233) + "cnica")
13154: 
13155:             IF USED("CsCabecalho")
13156:                 USE IN CsCabecalho
13157:             ENDIF

*-- Linhas 13190 a 13230:
13190:         TRY
13191:             *-- Verificar se ja tem imagem
13192:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13193:                 SELECT TOP 1 CASE WHEN FigProcs IS NULL OR LEN(RTRIM(FigProcs))=0 THEN 0 ELSE 1 END AS temFig
13194:                 FROM SigCdPrf
13195:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13196:             ENDTEXT
13197:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerFig")
13198:             LOCAL loc_lTemFig
13199:             loc_lTemFig = .F.
13200:             IF loc_nR > 0 AND !EOF("cursor_4c_VerFig")
13201:                 loc_lTemFig = (cursor_4c_VerFig.temFig > 0)
13202:             ENDIF
13203:             IF USED("cursor_4c_VerFig")
13204:                 USE IN cursor_4c_VerFig
13205:             ENDIF
13206: 
13207:             IF loc_lTemFig
13208:                 *-- Oferecer opcoes: substituir ou remover
13209:                 loc_lConfirma = MsgConfirma("Esta fase j" + CHR(225) + " possui imagem. Deseja remov" + CHR(234) + "-la?", "Imagem da Fase")
13210:                 IF loc_lConfirma
13211:                     TEXT TO loc_cSQL TEXTMERGE NOSHOW
13212:                         UPDATE SigCdPrf SET FigProcs = NULL
13213:                         WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13214:                     ENDTEXT
13215:                     loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13216:                     IF loc_nR > 0
13217:                         IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5)
13218:                             loc_oPg.img_4c_ImgFigJpg.Picture = ""
13219:                             loc_oPg.img_4c_ImgFigJpg.Visible = .F.
13220:                         ENDIF
13221:                         MsgInfo("Imagem removida.", "FormProduto")
13222:                     ENDIF
13223:                     RETURN
13224:                 ENDIF
13225:             ENDIF
13226: 
13227:             *-- Selecionar arquivo de imagem
13228:             loc_cFig = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar Imagem da Fase:")
13229:             IF EMPTY(loc_cFig) OR !FILE(loc_cFig)
13230:                 RETURN

*-- Linhas 13239 a 13260:
13239:             ENDIF
13240: 
13241:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13242:                 UPDATE SigCdPrf SET FigProcs = ?loc_cBinImg
13243:                 WHERE RTRIM(produtos) = RTRIM(<<EscaparSQL(loc_cCpros)>>) AND ordems = <<loc_nOrdems>>
13244:             ENDTEXT
13245:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13246:             IF loc_nR > 0
13247:                 *-- Exibir imagem carregada
13248:                 loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
13249:                 STRTOFILE(loc_cBinImg, loc_cArquivo)
13250:                 IF PEMSTATUS(loc_oPg, "img_4c_ImgFigJpg", 5) AND FILE(loc_cArquivo)
13251:                     loc_oPg.img_4c_ImgFigJpg.Picture = loc_cArquivo
13252:                     loc_oPg.img_4c_ImgFigJpg.Visible = .T.
13253:                 ENDIF
13254:             ELSE
13255:                 MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFiguraClick")
13256:             ENDIF
13257: 
13258:         CATCH TO loc_oErro
13259:             MsgErro("Erro ao carregar imagem:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFiguraClick")
13260:         ENDTRY

*-- Linhas 13302 a 13323:
13302:             loc_cB64 = "data:image/jpeg;base64," + STRCONV(loc_cBinImg, 13)
13303: 
13304:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13305:                 UPDATE SigCdPro SET FigJpgs = ?loc_cB64
13306:                 WHERE RTRIM(cpros) = RTRIM(<<EscaparSQL(loc_cCmats)>>)
13307:             ENDTEXT
13308:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13309:             IF loc_nR > 0
13310:                 *-- Exibir imagem
13311:                 loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
13312:                 STRTOFILE(loc_cBinImg, loc_cArquivo)
13313:                 IF PEMSTATUS(loc_oPg, "img_4c_ImgBorracha", 5) AND FILE(loc_cArquivo)
13314:                     loc_oPg.img_4c_ImgBorracha.Picture = loc_cArquivo
13315:                     loc_oPg.img_4c_ImgBorracha.Visible = .T.
13316:                 ENDIF
13317:             ELSE
13318:                 MsgErro("Erro ao salvar imagem.", "FormProduto.CmdgFigCamClick")
13319:             ENDIF
13320: 
13321:         CATCH TO loc_oErro
13322:             MsgErro("Erro ao carregar imagem de borracha:" + CHR(13) + loc_oErro.Message, "FormProduto.CmdgFigCamClick")
13323:         ENDTRY

*-- Linhas 13343 a 13364:
13343:         TRY
13344:             *-- Inserir nova linha vazia em SigPrMtz com cIdChaves unico
13345:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13346:                 INSERT INTO SigPrMtz (cpros, cidchaves, cmats, qtds)
13347:                 VALUES (<<EscaparSQL(loc_cCpros)>>, NEWID(), '', 0)
13348:             ENDTEXT
13349:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13350:             IF loc_nR > 0
13351:                 THIS.CarregarMatrizes()
13352:                 loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7
13353:                 IF PEMSTATUS(loc_oPg, "grd_4c_Matrizes", 5)
13354:                     loc_oPg.grd_4c_Matrizes.SetFocus()
13355:                 ENDIF
13356:             ELSE
13357:                 MsgErro("Erro ao inserir matriz.", "FormProduto.BtnInserirMatrizClick")
13358:             ENDIF
13359:         CATCH TO loc_oErro
13360:             MsgErro("Erro ao inserir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnInserirMatrizClick")
13361:         ENDTRY
13362:     ENDPROC
13363: 
13364:     *--------------------------------------------------------------------------

*-- Linhas 13391 a 13412:
13391: 
13392:         TRY
13393:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
13394:                 DELETE FROM SigPrMtz
13395:                 WHERE RTRIM(cidchaves) = RTRIM(<<EscaparSQL(loc_cCidChaves)>>)
13396:             ENDTEXT
13397:             loc_nR = SQLEXEC(gnConnHandle, loc_cSQL)
13398:             IF loc_nR > 0
13399:                 THIS.CarregarMatrizes()
13400:             ELSE
13401:                 MsgErro("Erro ao excluir matriz.", "FormProduto.BtnExcluirMatrizClick")
13402:             ENDIF
13403:         CATCH TO loc_oErro
13404:             MsgErro("Erro ao excluir matriz:" + CHR(13) + loc_oErro.Message, "FormProduto.BtnExcluirMatrizClick")
13405:         ENDTRY
13406:     ENDPROC
13407: 
13408:     *--------------------------------------------------------------------------
13409:     * DesignerGrd_AfterRowColChange - Grid tarefas: ao navegar linha/coluna
13410:     * Atualiza txt_4c_ObsTarefas com descricao da tarefa da linha atual
13411:     * LPARAMETERS obrigatorio (BINDEVENT AfterRowColChange)
13412:     *--------------------------------------------------------------------------

*-- Linhas 13421 a 13439:
13421: 
13422:                 *-- Buscar descricao no cursor de tarefas
13423:                 IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas") AND !EMPTY(loc_cCodTarefa)
13424:                     SELECT cursor_4c_Tarefas
13425:                     LOCATE FOR ALLTRIM(CodCads) = loc_cCodTarefa
13426:                     IF !EOF("cursor_4c_Tarefas")
13427:                         loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13428:                     ENDIF
13429:                 ENDIF
13430: 
13431:                 IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13432:                     loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13433:                     loc_oPg.txt_4c_ObsTarefas.Refresh()
13434:                 ENDIF
13435:             ENDIF
13436:         CATCH TO loc_oErro
13437:             MsgErro(loc_oErro.Message, "FormProduto.DesignerGrd_AfterRowColChange")
13438:         ENDTRY
13439:     ENDPROC

*-- Linhas 13543 a 13561:
13543:             loc_cCodTarefa = ""
13544:             loc_cDesTarefa = ""
13545: 
13546:             SELECT cursor_4c_Tarefas
13547:             LOCATE FOR ALLTRIM(CodCads) = loc_cValor
13548:             IF !EOF("cursor_4c_Tarefas")
13549:                 loc_lEncontrou = .T.
13550:                 loc_cCodTarefa = ALLTRIM(cursor_4c_Tarefas.CodCads)
13551:                 loc_cDesTarefa = ALLTRIM(NVL(cursor_4c_Tarefas.DesCads, ""))
13552:             ENDIF
13553: 
13554:             *-- Atualizar descricao se encontrou; limpar se nao encontrou
13555:             IF USED("cursor_4c_Designer") AND !EOF("cursor_4c_Designer")
13556:                 IF loc_lEncontrou
13557:                     IF PEMSTATUS(loc_oPg, "txt_4c_ObsTarefas", 5)
13558:                         loc_oPg.txt_4c_ObsTarefas.Value = loc_cDesTarefa
13559:                     ENDIF
13560:                 ELSE
13561:                     MsgAviso("C" + CHR(243) + "digo de tarefa n" + CHR(227) + "o encontrado.", "Tarefa Designer")

