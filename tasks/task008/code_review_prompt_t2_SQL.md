# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (12587 linhas total):

*-- Linhas 334 a 352:
334:                 USE IN cursor_4c_Lista
335:             ENDIF
336:             SET NULL ON
337:             CREATE CURSOR cursor_4c_Lista (;
338:                 CPros    C(14)  NULL, ;
339:                 DPros    C(40)  NULL, ;
340:                 DPro2s   C(30)  NULL, ;
341:                 CGrus    C(10)  NULL, ;
342:                 DGrus    C(30)  NULL, ;
343:                 SGrus    C(10)  NULL, ;
344:                 Reffs    C(30)  NULL, ;
345:                 UsuaAlts C(15)  NULL, ;
346:                 Instalas N(1,0) NULL  ;
347:             )
348:             SET NULL OFF
349: 
350:             *-- Container de filtros (cntFiltros no legado) - Top = 82+29 = 111
351:             par_oPage.AddObject("cnt_4c_Filtros", "Container")
352:             WITH par_oPage.cnt_4c_Filtros

*-- Linhas 915 a 958:
915:             par_oPage.grd_4c_Lista.HighlightBackColor = RGB(255,255,255)
916:             par_oPage.grd_4c_Lista.HighlightForeColor = RGB(15,41,104)
917:             par_oPage.grd_4c_Lista.HighlightStyle   = 2
918:             par_oPage.grd_4c_Lista.DeleteMark        = .F.
919:             par_oPage.grd_4c_Lista.RecordMark        = .F.
920:             par_oPage.grd_4c_Lista.RowHeight         = 16
921:             par_oPage.grd_4c_Lista.ScrollBars        = 2
922:             par_oPage.grd_4c_Lista.Themes            = .F.
923:             par_oPage.grd_4c_Lista.Visible           = .T.
924: 
925:             *-- CheckBox na Column7 ANTES de RecordSource
926:             par_oPage.grd_4c_Lista.Column7.AddObject("Check1", "CheckBox")
927:             par_oPage.grd_4c_Lista.Column7.CurrentControl = "Check1"
928:             par_oPage.grd_4c_Lista.Column7.Check1.Themes  = .F.
929:             par_oPage.grd_4c_Lista.Column7.Check1.Value   = 0
930: 
931:             *-- RecordSource FORA de WITH (critico: evita "Unknown member COLUMN1")
932:             par_oPage.grd_4c_Lista.RecordSource = "cursor_4c_Lista"
933: 
934:             *-- Redefinir ControlSources apos RecordSource (VFP faz auto-bind pela ordem dos campos)
935:             par_oPage.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Lista.CPros"
936:             par_oPage.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Lista.DPros"
937:             par_oPage.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Lista.DGrus"
938:             par_oPage.grd_4c_Lista.Column4.ControlSource = "cursor_4c_Lista.SGrus"
939:             par_oPage.grd_4c_Lista.Column5.ControlSource = "cursor_4c_Lista.Reffs"
940:             par_oPage.grd_4c_Lista.Column6.ControlSource = "cursor_4c_Lista.UsuaAlts"
941:             par_oPage.grd_4c_Lista.Column7.ControlSource = "cursor_4c_Lista.Instalas"
942: 
943:             *-- Configurar colunas APOS RecordSource (evita reset de headers/ControlSource)
944:             THIS.FormatarGridLista(par_oPage.grd_4c_Lista)
945: 
946:         CATCH TO loc_oErro
947:             MsgErro(loc_oErro.Message, "Erro ao configurar Page1")
948:         ENDTRY
949:     ENDPROC
950: 
951:     *--------------------------------------------------------------------------
952:     PROTECTED PROCEDURE ConfigurarPage2(par_oPage)
953:         LOCAL loc_oContainer
954:         TRY
955:             *-- Botoes de acao (Grupo_Salva no legado) - Top = 9+29 = 38
956:             par_oPage.AddObject("cnt_4c_BotoesAcao", "Container")
957:             WITH par_oPage.cnt_4c_BotoesAcao
958:                 .Top         = 38

*-- Linhas 1059 a 1120:
1059: 
1060:             *-- Column1: Produto (CPros)
1061:             loc_oGrid.Column1.Header1.Caption  = "Produto"
1062:             loc_oGrid.Column1.ControlSource    = "cursor_4c_Lista.CPros"
1063:             loc_oGrid.Column1.Width            = 80
1064:             loc_oGrid.Column1.ReadOnly         = .T.
1065:             loc_oGrid.Column1.Header1.FontBold = .T.
1066: 
1067:             *-- Column2: Descricao (DPros)
1068:             loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
1069:             loc_oGrid.Column2.ControlSource    = "cursor_4c_Lista.DPros"
1070:             loc_oGrid.Column2.Width            = 250
1071:             loc_oGrid.Column2.ReadOnly         = .T.
1072:             loc_oGrid.Column2.Header1.FontBold = .T.
1073: 
1074:             *-- Column3: Grupo (DGrus - descricao do grupo via JOIN)
1075:             loc_oGrid.Column3.Header1.Caption  = "Grupo"
1076:             loc_oGrid.Column3.ControlSource    = "cursor_4c_Lista.DGrus"
1077:             loc_oGrid.Column3.Width            = 100
1078:             loc_oGrid.Column3.ReadOnly         = .T.
1079:             loc_oGrid.Column3.Header1.FontBold = .T.
1080: 
1081:             *-- Column4: Subgrupo (SGrus)
1082:             loc_oGrid.Column4.Header1.Caption  = "Subgrp."
1083:             loc_oGrid.Column4.ControlSource    = "cursor_4c_Lista.SGrus"
1084:             loc_oGrid.Column4.Width            = 70
1085:             loc_oGrid.Column4.ReadOnly         = .T.
1086:             loc_oGrid.Column4.Header1.FontBold = .T.
1087: 
1088:             *-- Column5: Ref. Fornecedor (Reffs)
1089:             loc_oGrid.Column5.Header1.Caption  = "Ref. Fornecedor"
1090:             loc_oGrid.Column5.ControlSource    = "cursor_4c_Lista.Reffs"
1091:             loc_oGrid.Column5.Width            = 180
1092:             loc_oGrid.Column5.ReadOnly         = .T.
1093:             loc_oGrid.Column5.Header1.FontBold = .T.
1094: 
1095:             *-- Column6: Usuario (UsuaAlts)
1096:             loc_oGrid.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
1097:             loc_oGrid.Column6.ControlSource    = "cursor_4c_Lista.UsuaAlts"
1098:             loc_oGrid.Column6.Width            = 100
1099:             loc_oGrid.Column6.ReadOnly         = .T.
1100:             loc_oGrid.Column6.Header1.FontBold = .T.
1101: 
1102:             *-- Column7: Instalacao - CheckBox (Instalas)
1103:             *-- ControlSource definido na Column (NAO no Check1) - evita Error 1767
1104:             loc_oGrid.Column7.Header1.Caption  = "I"
1105:             loc_oGrid.Column7.ControlSource    = "cursor_4c_Lista.Instalas"
1106:             loc_oGrid.Column7.Width            = 30
1107:             loc_oGrid.Column7.ReadOnly         = .T.
1108:             loc_oGrid.Column7.Header1.FontBold = .T.
1109:             loc_oGrid.Column7.Alignment        = 2
1110: 
1111:         CATCH TO loc_oErro
1112:             MsgErro(loc_oErro.Message, "Erro ao formatar grid lista")
1113:         ENDTRY
1114:     ENDPROC
1115: 
1116:     *--------------------------------------------------------------------------
1117:     * AlternarPagina - Troca entre Page1 (Lista) e Page2 (Dados)
1118:     *--------------------------------------------------------------------------
1119:     PROCEDURE AlternarPagina(par_nPagina)
1120:         LOCAL loc_oErro

*-- Linhas 1186 a 1251:
1186:             loc_cWhere = " WHERE (1=1)"
1187:             IF !EMPTY(loc_cCodGrupo)
1188:                 loc_cWhere = loc_cWhere + ;
1189:                     " AND p.CGrus = " + EscaparSQL(PADR(loc_cCodGrupo, 10))
1190:             ENDIF
1191:             IF !EMPTY(loc_dDtIni)
1192:                 loc_cWhere = loc_cWhere + ;
1193:                     " AND p.DataAlts >= " + FormatarDataSQL(loc_dDtIni)
1194:             ENDIF
1195:             IF !EMPTY(loc_dDtFim)
1196:                 loc_cWhere = loc_cWhere + ;
1197:                     " AND p.DataAlts <= " + FormatarDataSQL(loc_dDtFim)
1198:             ENDIF
1199:             DO CASE
1200:                 CASE loc_nSituacao = 2
1201:                     loc_cWhere = loc_cWhere + " AND ISNULL(g.chkInstalas, 0) = 1"
1202:                 CASE loc_nSituacao = 3
1203:                     loc_cWhere = loc_cWhere + " AND ISNULL(g.chkInstalas, 0) = 0"
1204:             ENDCASE
1205: 
1206:             *-- SQL completo com JOIN para descricao do grupo
1207:             loc_cSQL = "SELECT p.CPros, p.DPros, p.DPro2s, " + ;
1208:                        "       p.CGrus, ISNULL(g.DGrus, '') AS DGrus, " + ;
1209:                        "       p.SGrus, p.Reffs, p.UsuaAlts, " + ;
1210:                        "       CAST(ISNULL(g.chkInstalas, 0) AS INT) AS Instalas " + ;
1211:                        "FROM SigCdPro p " + ;
1212:                        "LEFT JOIN SigCdGrp g ON g.CGrus = p.CGrus " + ;
1213:                        loc_cWhere + ;
1214:                        " ORDER BY p.CPros"
1215: 
1216:             *-- Executar em cursor temporario
1217:             IF USED("cursor_4c_ListaTemp")
1218:                 USE IN cursor_4c_ListaTemp
1219:             ENDIF
1220:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaTemp")
1221:             IF loc_nRet < 1
1222:                 MsgErro("Erro ao carregar lista de produtos.", "Erro")
1223:                 loc_lContinuar = .F.
1224:             ENDIF
1225: 
1226:             IF loc_lContinuar
1227:                 *-- Atualizar cursor principal (preserva estrutura de colunas do grid)
1228:                 SELECT cursor_4c_Lista
1229:                 ZAP
1230:                 APPEND FROM DBF("cursor_4c_ListaTemp")
1231:                 IF USED("cursor_4c_ListaTemp")
1232:                     USE IN cursor_4c_ListaTemp
1233:                 ENDIF
1234: 
1235:                 *-- Posicionar no inicio e atualizar contador
1236:                 SELECT cursor_4c_Lista
1237:                 GO TOP
1238:                 loc_oPage1.grd_4c_Lista.Refresh()
1239:                 loc_nCount = RECCOUNT("cursor_4c_Lista")
1240:                 loc_oPage1.lbl_4c_Produtos.Caption = ;
1241:                     "Produtos Selecionados : " + LTRIM(STR(loc_nCount))
1242:             ENDIF
1243: 
1244:         CATCH TO loc_oErro
1245:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de produtos")
1246:         ENDTRY
1247:     ENDPROC
1248: 
1249:     *--------------------------------------------------------------------------
1250:     * ConfigurarEventos - BINDEVENT para botoes e filtros
1251:     * IMPORTANTE: todos os handlers devem ser PUBLIC

*-- Linhas 1500 a 1518:
1500:                 loc_lContinuar = .F.
1501:             ENDIF
1502:             IF loc_lContinuar
1503:                 SELECT cursor_4c_Lista
1504:                 loc_cCodigo = ALLTRIM(CPros)
1505:                 IF EMPTY(loc_cCodigo)
1506:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1507:                     loc_lContinuar = .F.
1508:                 ENDIF
1509:             ENDIF
1510:             IF loc_lContinuar
1511:                 THIS.AlternarPagina(2)
1512:                 this_lNovoRegistro = .F.
1513:                 this_lEmEdicao     = .F.
1514:                 this_cCodigo       = loc_cCodigo
1515:                 this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1516:                 THIS.BOParaForm()
1517:                 THIS.HabilitarCampos(.F.)
1518:             ENDIF

*-- Linhas 1530 a 1548:
1530:                 loc_lContinuar = .F.
1531:             ENDIF
1532:             IF loc_lContinuar
1533:                 SELECT cursor_4c_Lista
1534:                 loc_cCodigo = ALLTRIM(CPros)
1535:                 IF EMPTY(loc_cCodigo)
1536:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1537:                     loc_lContinuar = .F.
1538:                 ENDIF
1539:             ENDIF
1540:             IF loc_lContinuar
1541:                 THIS.AlternarPagina(2)
1542:                 this_lNovoRegistro = .F.
1543:                 this_lEmEdicao     = .T.
1544:                 this_cCodigo       = loc_cCodigo
1545:                 this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1546:                 this_oBusinessObject.EditarRegistro()
1547:                 THIS.BOParaForm()
1548:                 THIS.HabilitarCampos(.T.)

*-- Linhas 1561 a 1579:
1561:                 loc_lContinuar = .F.
1562:             ENDIF
1563:             IF loc_lContinuar
1564:                 SELECT cursor_4c_Lista
1565:                 loc_cCodigo = ALLTRIM(CPros)
1566:                 IF EMPTY(loc_cCodigo)
1567:                     MsgAviso("Nenhum produto selecionado.", "Aviso")
1568:                     loc_lContinuar = .F.
1569:                 ENDIF
1570:             ENDIF
1571:             IF loc_lContinuar
1572:                 loc_lConfirmou = MsgConfirma("Deseja excluir o produto [" + ;
1573:                     loc_cCodigo + "]?", ;
1574:                     "Confirmar Exclus" + CHR(227) + "o")
1575:                 IF loc_lConfirmou
1576:                     this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1577:                     IF this_oBusinessObject.Excluir()
1578:                         MsgInfo("Produto exclu" + CHR(237) + "do com sucesso.", "Sucesso")
1579:                         THIS.CarregarLista()

*-- Linhas 1791 a 1813:
1791:             loc_oPgFaseP.img_4c_ImgBorracha.Picture = ""
1792:             loc_oPgFaseP.img_4c_ImgBorracha.Visible = .F.
1793:             IF USED("cursor_4c_PrfFase")
1794:                 SELECT cursor_4c_PrfFase
1795:                 ZAP
1796:             ENDIF
1797:             IF USED("cursor_4c_Mtz")
1798:                 SELECT cursor_4c_Mtz
1799:                 ZAP
1800:             ENDIF
1801:         CATCH TO loc_oErro
1802:             MsgErro(loc_oErro.Message, "Erro ao limpar campos")
1803:         ENDTRY
1804:     ENDPROC
1805: 
1806:     *--------------------------------------------------------------------------
1807:     * HabilitarCampos - Habilita/desabilita campos de edicao
1808:     *--------------------------------------------------------------------------
1809:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1810:         LOCAL loc_oPgDados, loc_oErro
1811:         TRY
1812:             loc_oPgDados = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page1
1813:             *-- Codigo: somente editavel em novo registro

*-- Linhas 1924 a 2018:
1924:             *-- Descricoes de grupo e subgrupo (lookup)
1925:             IF gnConnHandle > 0 AND !gb_4c_ValidandoUI
1926:                 IF !EMPTY(loc_oBO.this_cCgrus)
1927:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1928:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
1929:                         EscaparSQL(PADR(ALLTRIM(loc_oBO.this_cCgrus), 10)), ;
1930:                         "cursor_4c_BODGru")
1931:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODGru") > 0
1932:                         SELECT cursor_4c_BODGru
1933:                         loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(DGrus)
1934:                     ENDIF
1935:                     IF USED("cursor_4c_BODGru")
1936:                         USE IN cursor_4c_BODGru
1937:                     ENDIF
1938:                 ELSE
1939:                     loc_oPgDados.txt_4c_Dgru.Value = ""
1940:                 ENDIF
1941:                 IF !EMPTY(loc_oBO.this_cSGrus)
1942:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1943:                         "SELECT Descricaos AS DSGrus FROM SigCdPsg WHERE Codigos = " + ;
1944:                         EscaparSQL(PADR(ALLTRIM(loc_oBO.this_cSGrus), 10)), ;
1945:                         "cursor_4c_BODSGru")
1946:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODSGru") > 0
1947:                         SELECT cursor_4c_BODSGru
1948:                         loc_oPgDados.txt_4c_DsGru.Value = ALLTRIM(DSGrus)
1949:                     ENDIF
1950:                     IF USED("cursor_4c_BODSGru")
1951:                         USE IN cursor_4c_BODSGru
1952:                     ENDIF
1953:                 ELSE
1954:                     loc_oPgDados.txt_4c_DsGru.Value = ""
1955:                 ENDIF
1956:             ENDIF
1957: 
1958:             *-- === Linha / Colecao ===
1959:             loc_oPgDados.txt_4c_Lin.Value = ALLTRIM(loc_oBO.this_cLins)
1960:             loc_oPgDados.txt_4c_Col.Value = ALLTRIM(loc_oBO.this_cCols)
1961:             *-- Descricoes de linha e colecao (lookup)
1962:             IF gnConnHandle > 0 AND !gb_4c_ValidandoUI
1963:                 IF !EMPTY(loc_oBO.this_cLins)
1964:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1965:                         "SELECT Descs AS DLins FROM SigCdLin WHERE Linhas = " + ;
1966:                         EscaparSQL(PADR(ALLTRIM(loc_oBO.this_cLins), 5)), ;
1967:                         "cursor_4c_BODLin")
1968:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODLin") > 0
1969:                         SELECT cursor_4c_BODLin
1970:                         loc_oPgDados.txt_4c_DLin.Value = ALLTRIM(DLins)
1971:                     ENDIF
1972:                     IF USED("cursor_4c_BODLin")
1973:                         USE IN cursor_4c_BODLin
1974:                     ENDIF
1975:                 ELSE
1976:                     loc_oPgDados.txt_4c_DLin.Value = ""
1977:                 ENDIF
1978:                 IF !EMPTY(loc_oBO.this_cCols)
1979:                     loc_nRet = SQLEXEC(gnConnHandle, ;
1980:                         "SELECT Descs AS DCols FROM SigCdCol WHERE Colecoes = " + ;
1981:                         EscaparSQL(PADR(ALLTRIM(loc_oBO.this_cCols), 5)), ;
1982:                         "cursor_4c_BODCol")
1983:                     IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODCol") > 0
1984:                         SELECT cursor_4c_BODCol
1985:                         loc_oPgDados.txt_4c_DCol.Value = ALLTRIM(DCols)
1986:                     ENDIF
1987:                     IF USED("cursor_4c_BODCol")
1988:                         USE IN cursor_4c_BODCol
1989:                     ENDIF
1990:                 ELSE
1991:                     loc_oPgDados.txt_4c_DCol.Value = ""
1992:                 ENDIF
1993:             ENDIF
1994: 
1995:             *-- === Fornecedor ===
1996:             loc_oPgDados.txt_4c_Ifor.Value = ALLTRIM(loc_oBO.this_cIFors)
1997:             IF gnConnHandle > 0 AND !gb_4c_ValidandoUI AND !EMPTY(loc_oBO.this_cIFors)
1998:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1999:                     "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
2000:                     EscaparSQL(ALLTRIM(loc_oBO.this_cIFors)), ;
2001:                     "cursor_4c_BODfor")
2002:                 IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BODfor") > 0
2003:                     SELECT cursor_4c_BODfor
2004:                     loc_oPgDados.txt_4c_Dfor.Value = ALLTRIM(RClis)
2005:                 ENDIF
2006:                 IF USED("cursor_4c_BODfor")
2007:                     USE IN cursor_4c_BODfor
2008:                 ENDIF
2009:             ELSE
2010:                 loc_oPgDados.txt_4c_Dfor.Value = ""
2011:             ENDIF
2012: 
2013:             *-- === Quantidades / Lote ===
2014:             loc_oPgDados.txt_4c_Qmin.Value      = loc_oBO.this_nQmins
2015:             loc_oPgDados.txt_4c_LtMinsV.Value   = loc_oBO.this_nLtMinsVs
2016:             loc_oPgDados.txt_4c_Conjunto.Value  = loc_oBO.this_nConjuntos
2017:             loc_oPgDados.txt_4c_QtPed.Value     = loc_oBO.this_nQtPeds
2018:             loc_oPgDados.txt_4c_DiasGar.Value   = loc_oBO.this_nDiasGars

*-- Linhas 2121 a 2144:
2121:                 IF USED(loc_cAlias)
2122:                     USE IN (loc_cAlias)
2123:                 ENDIF
2124:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2125:                     "SELECT " + par_cCampoDes + " FROM " + par_cTabela + ;
2126:                     " WHERE " + par_cCampoPK + " = " + EscaparSQL(par_cCodigo), ;
2127:                     loc_cAlias)
2128:                 IF loc_nRet > 0 AND RECCOUNT(loc_cAlias) > 0
2129:                     SELECT (loc_cAlias)
2130:                     par_oTextBox.Value = ALLTRIM(&par_cCampoDes)
2131:                 ELSE
2132:                     par_oTextBox.Value = ""
2133:                 ENDIF
2134:                 IF USED(loc_cAlias)
2135:                     USE IN (loc_cAlias)
2136:                 ENDIF
2137:             ENDIF
2138:         CATCH TO loc_oErro
2139:             *-- Tolerado: lookup nao critico
2140:         ENDTRY
2141:     ENDPROC
2142: 
2143:     *--------------------------------------------------------------------------
2144:     * FormParaBO - Le campos do form e envia para o BO (COMPLETO)

*-- Linhas 4776 a 4799:
4776:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ""
4777:                 RETURN
4778:             ENDIF
4779:             loc_nRet = SQLEXEC(gnConnHandle, ;
4780:                 "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
4781:                 EscaparSQL(PADR(loc_cCodGrupo, 10)), ;
4782:                 "cursor_4c_BuscaGrp")
4783:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_BuscaGrp") > 0
4784:                 SELECT cursor_4c_BuscaGrp
4785:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ALLTRIM(DGrus)
4786:             ELSE
4787:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = ""
4788:                 loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value = ""
4789:             ENDIF
4790:             IF USED("cursor_4c_BuscaGrp")
4791:                 USE IN cursor_4c_BuscaGrp
4792:             ENDIF
4793:             THIS.CarregarLista()
4794:         CATCH TO loc_oErro
4795:             MsgErro(loc_oErro.Message, "Erro ao validar grupo")
4796:         ENDTRY
4797:     ENDPROC
4798: 
4799:     *-- AbrirLookupGrupo: lookup para o FILTRO da Page1 (txt_4c_CodGrupo)

*-- Linhas 4939 a 4962:
4939:                 loc_oPgDados.txt_4c_Dgru.Value = ""
4940:                 RETURN
4941:             ENDIF
4942:             loc_nRet = SQLEXEC(gnConnHandle, ;
4943:                 "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + ;
4944:                 EscaparSQL(PADR(loc_cCodGru, 10)), ;
4945:                 "cursor_4c_ValGru")
4946:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValGru") > 0
4947:                 SELECT cursor_4c_ValGru
4948:                 loc_oPgDados.txt_4c_Dgru.Value = ALLTRIM(DGrus)
4949:             ELSE
4950:                 loc_oPgDados.txt_4c_Cgru.Value = ""
4951:                 loc_oPgDados.txt_4c_Dgru.Value = ""
4952:             ENDIF
4953:             IF USED("cursor_4c_ValGru")
4954:                 USE IN cursor_4c_ValGru
4955:             ENDIF
4956:             THIS.CarregarLista()
4957:         CATCH TO loc_oErro
4958:             MsgErro(loc_oErro.Message, "Erro ao validar grupo")
4959:         ENDTRY
4960:     ENDPROC
4961: 
4962:     *-- SubGrupo (SigCdPsg: Codigos / Descricaos, filtrado por CGrus)

*-- Linhas 4995 a 5026:
4995:                 USE IN cursor_4c_BuscaCSGru
4996:             ENDIF
4997:             IF EMPTY(loc_cCodGru)
4998:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos"
4999:             ELSE
5000:                 loc_cSQL = "SELECT Codigos, Descricaos FROM SigCdPsg " + ;
5001:                            "WHERE CGrus = " + EscaparSQL(PADR(loc_cCodGru, 10)) + ;
5002:                            " ORDER BY Codigos"
5003:             ENDIF
5004:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCSGru")
5005:             IF loc_nRet < 1 OR RECCOUNT("cursor_4c_BuscaCSGru") = 0
5006:                 IF USED("cursor_4c_BuscaCSGru")
5007:                     USE IN cursor_4c_BuscaCSGru
5008:                 ENDIF
5009:                 *-- Sem filtro de grupo
5010:                 loc_nRet = SQLEXEC(gnConnHandle, ;
5011:                     "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos", ;
5012:                     "cursor_4c_BuscaCSGru")
5013:             ENDIF
5014:             IF loc_nRet < 1
5015:                 MsgErro("Erro ao carregar subgrupos.", "Erro")
5016:                 RETURN
5017:             ENDIF
5018:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPsg", ;
5019:                 "cursor_4c_BuscaCSGru2", "Codigos", ;
5020:                 ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value), ;
5021:                 "Subgrupo")
5022:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
5023:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
5024:             loc_oBusca.Show()
5025:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCSGru2")
5026:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCSGru2.Codigos)

*-- Linhas 5052 a 5075:
5052:                 loc_oPgDados.txt_4c_DsGru.Value = ""
5053:                 RETURN
5054:             ENDIF
5055:             loc_nRet = SQLEXEC(gnConnHandle, ;
5056:                 "SELECT Descricaos FROM SigCdPsg WHERE Codigos = " + ;
5057:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5058:                 "cursor_4c_ValCSGru")
5059:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCSGru") > 0
5060:                 SELECT cursor_4c_ValCSGru
5061:                 loc_oPgDados.txt_4c_DsGru.Value = ALLTRIM(Descricaos)
5062:             ELSE
5063:                 loc_oPgDados.txt_4c_CSGru.Value = ""
5064:                 loc_oPgDados.txt_4c_DsGru.Value = ""
5065:             ENDIF
5066:             IF USED("cursor_4c_ValCSGru")
5067:                 USE IN cursor_4c_ValCSGru
5068:             ENDIF
5069:             THIS.CarregarLista()
5070:         CATCH TO loc_oErro
5071:             MsgErro(loc_oErro.Message, "Erro ao validar subgrupo")
5072:         ENDTRY
5073:     ENDPROC
5074: 
5075:     *-- Linha (SigCdLin: Linhas / Descs)

*-- Linhas 5135 a 5158:
5135:                 loc_oPgDados.txt_4c_DLin.Value = ""
5136:                 RETURN
5137:             ENDIF
5138:             loc_nRet = SQLEXEC(gnConnHandle, ;
5139:                 "SELECT Descs FROM SigCdLin WHERE Linhas = " + ;
5140:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5141:                 "cursor_4c_ValLin")
5142:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValLin") > 0
5143:                 SELECT cursor_4c_ValLin
5144:                 loc_oPgDados.txt_4c_DLin.Value = ALLTRIM(Descs)
5145:             ELSE
5146:                 loc_oPgDados.txt_4c_Lin.Value  = ""
5147:                 loc_oPgDados.txt_4c_DLin.Value = ""
5148:             ENDIF
5149:             IF USED("cursor_4c_ValLin")
5150:                 USE IN cursor_4c_ValLin
5151:             ENDIF
5152:             THIS.CarregarLista()
5153:         CATCH TO loc_oErro
5154:             MsgErro(loc_oErro.Message, "Erro ao validar linha")
5155:         ENDTRY
5156:     ENDPROC
5157: 
5158:     *-- Colecao / Grupo de Venda (SigCdCol: Colecoes / Descs)

*-- Linhas 5218 a 5241:
5218:                 loc_oPgDados.txt_4c_DCol.Value = ""
5219:                 RETURN
5220:             ENDIF
5221:             loc_nRet = SQLEXEC(gnConnHandle, ;
5222:                 "SELECT Descs FROM SigCdCol WHERE Colecoes = " + ;
5223:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5224:                 "cursor_4c_ValCol")
5225:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCol") > 0
5226:                 SELECT cursor_4c_ValCol
5227:                 loc_oPgDados.txt_4c_DCol.Value = ALLTRIM(Descs)
5228:             ELSE
5229:                 loc_oPgDados.txt_4c_Col.Value  = ""
5230:                 loc_oPgDados.txt_4c_DCol.Value = ""
5231:             ENDIF
5232:             IF USED("cursor_4c_ValCol")
5233:                 USE IN cursor_4c_ValCol
5234:             ENDIF
5235:             THIS.CarregarLista()
5236:         CATCH TO loc_oErro
5237:             MsgErro(loc_oErro.Message, "Erro ao validar grupo de venda")
5238:         ENDTRY
5239:     ENDPROC
5240: 
5241:     *-- Fornecedor (SigCdCli: IClis / RClis)

*-- Linhas 5301 a 5324:
5301:                 loc_oPgDados.txt_4c_Dfor.Value = ""
5302:                 RETURN
5303:             ENDIF
5304:             loc_nRet = SQLEXEC(gnConnHandle, ;
5305:                 "SELECT RClis FROM SigCdCli WHERE IClis = " + ;
5306:                 EscaparSQL(PADR(loc_cCod, 10)), ;
5307:                 "cursor_4c_ValIfor")
5308:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValIfor") > 0
5309:                 SELECT cursor_4c_ValIfor
5310:                 loc_oPgDados.txt_4c_Dfor.Value = ALLTRIM(RClis)
5311:             ELSE
5312:                 loc_oPgDados.txt_4c_Ifor.Value = ""
5313:                 loc_oPgDados.txt_4c_Dfor.Value = ""
5314:             ENDIF
5315:             IF USED("cursor_4c_ValIfor")
5316:                 USE IN cursor_4c_ValIfor
5317:             ENDIF
5318:             THIS.CarregarLista()
5319:         CATCH TO loc_oErro
5320:             MsgErro(loc_oErro.Message, "Erro ao validar fornecedor")
5321:         ENDTRY
5322:     ENDPROC
5323: 
5324:     *-- Cor (SigCdCor: Cods / Descs)

*-- Linhas 5472 a 5495:
5472:                 loc_oPgDados.txt_4c_DesFinP.Value = ""
5473:                 RETURN
5474:             ENDIF
5475:             loc_nRet = SQLEXEC(gnConnHandle, ;
5476:                 "SELECT Descs FROM SigCdFip WHERE Cods = " + ;
5477:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5478:                 "cursor_4c_ValFinP")
5479:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValFinP") > 0
5480:                 SELECT cursor_4c_ValFinP
5481:                 loc_oPgDados.txt_4c_DesFinP.Value = ALLTRIM(Descs)
5482:             ELSE
5483:                 loc_oPgDados.txt_4c_CodFinP.Value = ""
5484:                 loc_oPgDados.txt_4c_DesFinP.Value = ""
5485:             ENDIF
5486:             IF USED("cursor_4c_ValFinP")
5487:                 USE IN cursor_4c_ValFinP
5488:             ENDIF
5489:             THIS.CarregarLista()
5490:         CATCH TO loc_oErro
5491:             MsgErro(loc_oErro.Message, "Erro ao validar finalidade")
5492:         ENDTRY
5493:     ENDPROC
5494: 
5495:     *-- Acabamento (SigCdAca: Cods / Descrs)

*-- Linhas 5555 a 5578:
5555:                 loc_oPgDados.txt_4c_DesAcb.Value = ""
5556:                 RETURN
5557:             ENDIF
5558:             loc_nRet = SQLEXEC(gnConnHandle, ;
5559:                 "SELECT Descrs FROM SigCdAca WHERE Cods = " + ;
5560:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5561:                 "cursor_4c_ValAcb")
5562:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValAcb") > 0
5563:                 SELECT cursor_4c_ValAcb
5564:                 loc_oPgDados.txt_4c_DesAcb.Value = ALLTRIM(Descrs)
5565:             ELSE
5566:                 loc_oPgDados.txt_4c_CodAcb.Value = ""
5567:                 loc_oPgDados.txt_4c_DesAcb.Value = ""
5568:             ENDIF
5569:             IF USED("cursor_4c_ValAcb")
5570:                 USE IN cursor_4c_ValAcb
5571:             ENDIF
5572:             THIS.CarregarLista()
5573:         CATCH TO loc_oErro
5574:             MsgErro(loc_oErro.Message, "Erro ao validar acabamento")
5575:         ENDTRY
5576:     ENDPROC
5577: 
5578:     *-- Classificacao (SigCdCls: Cods / Descs, filtrado por CGrus)

*-- Linhas 5607 a 5629:
5607:             ENDIF
5608:             loc_cCodGru = ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value)
5609:             IF !EMPTY(loc_cCodGru)
5610:                 loc_cSQL = "SELECT Cods, Descs FROM SigCdCls " + ;
5611:                            "WHERE CGrus IN (" + EscaparSQL(PADR(loc_cCodGru, 10)) + ;
5612:                            ", '          ') ORDER BY Cods"
5613:             ELSE
5614:                 loc_cSQL = "SELECT Cods, Descs FROM SigCdCls ORDER BY Cods"
5615:             ENDIF
5616:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCls", ;
5617:                 "cursor_4c_BuscaClass", "Cods", ;
5618:                 ALLTRIM(loc_oPgDados.txt_4c_Class.Value), ;
5619:                 "Classifica" + CHR(231) + CHR(227) + "o")
5620:             loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
5621:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5622:             loc_oBusca.Show()
5623:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
5624:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaClass.Cods)
5625:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaClass.Descs)
5626:                 loc_oPgDados.txt_4c_Class.Value  = loc_cCodigo
5627:                 loc_oPgDados.txt_4c_DClass.Value = loc_cDescricao
5628:             ENDIF
5629:             IF USED("cursor_4c_BuscaClass")

*-- Linhas 5647 a 5670:
5647:                 loc_oPgDados.txt_4c_DClass.Value = ""
5648:                 RETURN
5649:             ENDIF
5650:             loc_nRet = SQLEXEC(gnConnHandle, ;
5651:                 "SELECT Descs FROM SigCdCls WHERE Cods = " + ;
5652:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5653:                 "cursor_4c_ValClass")
5654:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValClass") > 0
5655:                 SELECT cursor_4c_ValClass
5656:                 loc_oPgDados.txt_4c_DClass.Value = ALLTRIM(Descs)
5657:             ELSE
5658:                 loc_oPgDados.txt_4c_Class.Value  = ""
5659:                 loc_oPgDados.txt_4c_DClass.Value = ""
5660:             ENDIF
5661:             IF USED("cursor_4c_ValClass")
5662:                 USE IN cursor_4c_ValClass
5663:             ENDIF
5664:             THIS.CarregarLista()
5665:         CATCH TO loc_oErro
5666:             MsgErro(loc_oErro.Message, "Erro ao validar classifica" + CHR(231) + CHR(227) + "o")
5667:         ENDTRY
5668:     ENDPROC
5669: 
5670:     *-- Local (SigPrLcl: Codigos / Descricaos)

*-- Linhas 5774 a 5797:
5774:                 loc_oPgDados.txt_4c_Duni.Value = ""
5775:                 RETURN
5776:             ENDIF
5777:             loc_nRet = SQLEXEC(gnConnHandle, ;
5778:                 "SELECT DUnis FROM SigCdUni WHERE CUnis = " + ;
5779:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5780:                 "cursor_4c_ValCuni")
5781:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCuni") > 0
5782:                 SELECT cursor_4c_ValCuni
5783:                 loc_oPgDados.txt_4c_Duni.Value = ALLTRIM(DUnis)
5784:             ELSE
5785:                 loc_oPgDados.txt_4c_Cuni.Value = ""
5786:                 loc_oPgDados.txt_4c_Duni.Value = ""
5787:             ENDIF
5788:             IF USED("cursor_4c_ValCuni")
5789:                 USE IN cursor_4c_ValCuni
5790:             ENDIF
5791:             THIS.CarregarLista()
5792:         CATCH TO loc_oErro
5793:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 1")
5794:         ENDTRY
5795:     ENDPROC
5796: 
5797:     *-- Unidade 2 (SigCdUni: CUnis / DUnis)

*-- Linhas 5857 a 5880:
5857:                 loc_oPgDados.txt_4c_Dunip.Value = ""
5858:                 RETURN
5859:             ENDIF
5860:             loc_nRet = SQLEXEC(gnConnHandle, ;
5861:                 "SELECT DUnis FROM SigCdUni WHERE CUnis = " + ;
5862:                 EscaparSQL(PADR(loc_cCod, 5)), ;
5863:                 "cursor_4c_ValCunip")
5864:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ValCunip") > 0
5865:                 SELECT cursor_4c_ValCunip
5866:                 loc_oPgDados.txt_4c_Dunip.Value = ALLTRIM(DUnis)
5867:             ELSE
5868:                 loc_oPgDados.txt_4c_Cunip.Value = ""
5869:                 loc_oPgDados.txt_4c_Dunip.Value = ""
5870:             ENDIF
5871:             IF USED("cursor_4c_ValCunip")
5872:                 USE IN cursor_4c_ValCunip
5873:             ENDIF
5874:             THIS.CarregarLista()
5875:         CATCH TO loc_oErro
5876:             MsgErro(loc_oErro.Message, "Erro ao validar unidade 2")
5877:         ENDTRY
5878:     ENDPROC
5879: 
5880:     *==========================================================================

*-- Linhas 5889 a 5946:
5889:             IF USED("cursor_4c_Compo")
5890:                 USE IN cursor_4c_Compo
5891:             ENDIF
5892:             CREATE CURSOR cursor_4c_Compo (;
5893:                 Mats     C(14)    NULL, ;
5894:                 DPros    C(40)    NULL, ;
5895:                 Unisp    C(5)     NULL, ;
5896:                 Vals     N(15,6)  NULL, ;
5897:                 Qtds     N(15,6)  NULL, ;
5898:                 Totals   N(15,6)  NULL, ;
5899:                 Moedas   C(10)    NULL, ;
5900:                 Obss     C(50)    NULL, ;
5901:                 Es       C(10)    NULL, ;
5902:                 Conss    N(15,6)  NULL, ;
5903:                 Qtdss    N(15,6)  NULL, ;
5904:                 Unis     C(5)     NULL, ;
5905:                 Ords     N(5,0)   NULL, ;
5906:                 Bloqueio C(14)    NULL  ;
5907:             )
5908:             IF USED("cursor_4c_SubCp")
5909:                 USE IN cursor_4c_SubCp
5910:             ENDIF
5911:             CREATE CURSOR cursor_4c_SubCp (;
5912:                 Mats     C(14)    NULL, ;
5913:                 DPros    C(40)    NULL, ;
5914:                 Unisp    C(5)     NULL, ;
5915:                 Vals     N(15,6)  NULL, ;
5916:                 Qtds     N(15,6)  NULL, ;
5917:                 Totals   N(15,6)  NULL, ;
5918:                 Moedas   C(10)    NULL, ;
5919:                 Obss     C(50)    NULL, ;
5920:                 Es       C(10)    NULL, ;
5921:                 Conss    N(15,6)  NULL, ;
5922:                 Qtdss    N(15,6)  NULL, ;
5923:                 Unis     C(5)     NULL, ;
5924:                 Ords     N(5,0)   NULL, ;
5925:                 Bloqueio C(14)    NULL, ;
5926:                 Tams     C(10)    NULL  ;
5927:             )
5928:             IF USED("cursor_4c_GrupoCompo")
5929:                 USE IN cursor_4c_GrupoCompo
5930:             ENDIF
5931:             CREATE CURSOR cursor_4c_GrupoCompo (;
5932:                 CGrus  C(10)   NULL, ;
5933:                 Totals N(15,6) NULL, ;
5934:                 Moedas C(10)   NULL  ;
5935:             )
5936:             SET NULL OFF
5937: 
5938:             *-- === Obs. da OF (getObsOFs) - top=297+29=326 ===
5939:             par_oPage.AddObject("lbl_4c_LblObsOF", "Label")
5940:             WITH par_oPage.lbl_4c_LblObsOF
5941:                 .Top       = 329
5942:                 .Left      = 36
5943:                 .Width     = 64
5944:                 .Height    = 15
5945:                 .FontName  = "Tahoma"
5946:                 .FontSize  = 8

*-- Linhas 6024 a 6151:
6024:             par_oPage.grd_4c_Grupo.FontName    = "Tahoma"
6025:             par_oPage.grd_4c_Grupo.FontSize    = 8
6026:             par_oPage.grd_4c_Grupo.GridLines   = 3
6027:             par_oPage.grd_4c_Grupo.DeleteMark  = .F.
6028:             par_oPage.grd_4c_Grupo.RecordMark  = .F.
6029:             par_oPage.grd_4c_Grupo.ReadOnly    = .T.
6030:             par_oPage.grd_4c_Grupo.ScrollBars  = 2
6031:             par_oPage.grd_4c_Grupo.Themes      = .F.
6032:             par_oPage.grd_4c_Grupo.Visible     = .T.
6033: 
6034:             par_oPage.grd_4c_Grupo.RecordSource = "cursor_4c_GrupoCompo"
6035: 
6036:             par_oPage.grd_4c_Grupo.Column1.Header1.Caption  = "Grupo"
6037:             par_oPage.grd_4c_Grupo.Column1.ControlSource    = "cursor_4c_GrupoCompo.CGrus"
6038:             par_oPage.grd_4c_Grupo.Column1.Width            = 60
6039:             par_oPage.grd_4c_Grupo.Column1.Header1.FontBold = .T.
6040: 
6041:             par_oPage.grd_4c_Grupo.Column2.Header1.Caption  = "Total"
6042:             par_oPage.grd_4c_Grupo.Column2.ControlSource    = "cursor_4c_GrupoCompo.Totals"
6043:             par_oPage.grd_4c_Grupo.Column2.Width            = 90
6044:             par_oPage.grd_4c_Grupo.Column2.Header1.FontBold = .T.
6045: 
6046:             par_oPage.grd_4c_Grupo.Column3.Header1.Caption  = "Moeda"
6047:             par_oPage.grd_4c_Grupo.Column3.ControlSource    = "cursor_4c_GrupoCompo.Moedas"
6048:             par_oPage.grd_4c_Grupo.Column3.Width            = 65
6049:             par_oPage.grd_4c_Grupo.Column3.Header1.FontBold = .T.
6050: 
6051:             *-- === grdCompo (composicao principal) - top=148+29=177 ===
6052:             par_oPage.AddObject("grd_4c_Compo", "Grid")
6053:             par_oPage.grd_4c_Compo.Top         = 177
6054:             par_oPage.grd_4c_Compo.Left        = 6
6055:             par_oPage.grd_4c_Compo.Width       = 943
6056:             par_oPage.grd_4c_Compo.Height      = 147
6057:             par_oPage.grd_4c_Compo.ColumnCount = 14
6058:             par_oPage.grd_4c_Compo.FontName    = "Tahoma"
6059:             par_oPage.grd_4c_Compo.FontSize    = 8
6060:             par_oPage.grd_4c_Compo.GridLines   = 3
6061:             par_oPage.grd_4c_Compo.DeleteMark  = .F.
6062:             par_oPage.grd_4c_Compo.RecordMark  = .F.
6063:             par_oPage.grd_4c_Compo.RowHeight   = 16
6064:             par_oPage.grd_4c_Compo.ScrollBars  = 3
6065:             par_oPage.grd_4c_Compo.Themes      = .F.
6066:             par_oPage.grd_4c_Compo.Visible     = .T.
6067: 
6068:             par_oPage.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
6069: 
6070:             par_oPage.grd_4c_Compo.Column1.Header1.Caption  = "Material"
6071:             par_oPage.grd_4c_Compo.Column1.ControlSource    = "cursor_4c_Compo.Mats"
6072:             par_oPage.grd_4c_Compo.Column1.Width            = 80
6073:             par_oPage.grd_4c_Compo.Column1.Header1.FontBold = .T.
6074: 
6075:             par_oPage.grd_4c_Compo.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
6076:             par_oPage.grd_4c_Compo.Column2.ControlSource    = "cursor_4c_Compo.DPros"
6077:             par_oPage.grd_4c_Compo.Column2.Width            = 155
6078:             par_oPage.grd_4c_Compo.Column2.Header1.FontBold = .T.
6079: 
6080:             par_oPage.grd_4c_Compo.Column3.Header1.Caption  = "Un"
6081:             par_oPage.grd_4c_Compo.Column3.ControlSource    = "cursor_4c_Compo.Unisp"
6082:             par_oPage.grd_4c_Compo.Column3.Width            = 35
6083:             par_oPage.grd_4c_Compo.Column3.Header1.FontBold = .T.
6084: 
6085:             par_oPage.grd_4c_Compo.Column4.Header1.Caption  = "Valor"
6086:             par_oPage.grd_4c_Compo.Column4.ControlSource    = "cursor_4c_Compo.Vals"
6087:             par_oPage.grd_4c_Compo.Column4.Width            = 75
6088:             par_oPage.grd_4c_Compo.Column4.Header1.FontBold = .T.
6089: 
6090:             par_oPage.grd_4c_Compo.Column5.Header1.Caption  = "Qtde."
6091:             par_oPage.grd_4c_Compo.Column5.ControlSource    = "cursor_4c_Compo.Qtds"
6092:             par_oPage.grd_4c_Compo.Column5.Width            = 65
6093:             par_oPage.grd_4c_Compo.Column5.Header1.FontBold = .T.
6094: 
6095:             par_oPage.grd_4c_Compo.Column6.Header1.Caption  = "Total"
6096:             par_oPage.grd_4c_Compo.Column6.ControlSource    = "cursor_4c_Compo.Totals"
6097:             par_oPage.grd_4c_Compo.Column6.Width            = 75
6098:             par_oPage.grd_4c_Compo.Column6.Header1.FontBold = .T.
6099: 
6100:             par_oPage.grd_4c_Compo.Column7.Header1.Caption  = "Moe"
6101:             par_oPage.grd_4c_Compo.Column7.ControlSource    = "cursor_4c_Compo.Moedas"
6102:             par_oPage.grd_4c_Compo.Column7.Width            = 35
6103:             par_oPage.grd_4c_Compo.Column7.Header1.FontBold = .T.
6104: 
6105:             par_oPage.grd_4c_Compo.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
6106:             par_oPage.grd_4c_Compo.Column8.ControlSource    = "cursor_4c_Compo.Obss"
6107:             par_oPage.grd_4c_Compo.Column8.Width            = 100
6108:             par_oPage.grd_4c_Compo.Column8.Header1.FontBold = .T.
6109: 
6110:             par_oPage.grd_4c_Compo.Column9.Header1.Caption  = "E"
6111:             par_oPage.grd_4c_Compo.Column9.ControlSource    = "cursor_4c_Compo.Es"
6112:             par_oPage.grd_4c_Compo.Column9.Width            = 25
6113:             par_oPage.grd_4c_Compo.Column9.Header1.FontBold = .T.
6114: 
6115:             par_oPage.grd_4c_Compo.Column10.Header1.Caption  = "Consumo"
6116:             par_oPage.grd_4c_Compo.Column10.ControlSource    = "cursor_4c_Compo.Conss"
6117:             par_oPage.grd_4c_Compo.Column10.Width            = 65
6118:             par_oPage.grd_4c_Compo.Column10.Header1.FontBold = .T.
6119: 
6120:             par_oPage.grd_4c_Compo.Column11.Header1.Caption  = "Qtde."
6121:             par_oPage.grd_4c_Compo.Column11.ControlSource    = "cursor_4c_Compo.Qtdss"
6122:             par_oPage.grd_4c_Compo.Column11.Width            = 65
6123:             par_oPage.grd_4c_Compo.Column11.Header1.FontBold = .T.
6124: 
6125:             par_oPage.grd_4c_Compo.Column12.Header1.Caption  = "Un"
6126:             par_oPage.grd_4c_Compo.Column12.ControlSource    = "cursor_4c_Compo.Unis"
6127:             par_oPage.grd_4c_Compo.Column12.Width            = 35
6128:             par_oPage.grd_4c_Compo.Column12.Header1.FontBold = .T.
6129: 
6130:             par_oPage.grd_4c_Compo.Column13.Header1.Caption  = "Ord"
6131:             par_oPage.grd_4c_Compo.Column13.ControlSource    = "cursor_4c_Compo.Ords"
6132:             par_oPage.grd_4c_Compo.Column13.Width            = 35
6133:             par_oPage.grd_4c_Compo.Column13.Header1.FontBold = .T.
6134: 
6135:             par_oPage.grd_4c_Compo.Column14.Header1.Caption  = "Matriz"
6136:             par_oPage.grd_4c_Compo.Column14.ControlSource    = "cursor_4c_Compo.Bloqueio"
6137:             par_oPage.grd_4c_Compo.Column14.Width            = 90
6138:             par_oPage.grd_4c_Compo.Column14.Header1.FontBold = .T.
6139: 
6140:             *-- === cmdgCompo (CommandGroup 5 botoes) - top=145+29=174 ===
6141:             par_oPage.AddObject("cmdg_4c_Compo", "CommandGroup")
6142:             WITH par_oPage.cmdg_4c_Compo
6143:                 .Top         = 174
6144:                 .Left        = 947
6145:                 .Width       = 50
6146:                 .Height      = 210
6147:                 .ButtonCount = 5
6148:                 .Themes      = .F.
6149:                 .Visible     = .T.
6150:             ENDWITH
6151: 

*-- Linhas 6269 a 6367:
6269:             par_oPage.grd_4c_SubCp.FontName    = "Tahoma"
6270:             par_oPage.grd_4c_SubCp.FontSize    = 8
6271:             par_oPage.grd_4c_SubCp.GridLines   = 3
6272:             par_oPage.grd_4c_SubCp.DeleteMark  = .F.
6273:             par_oPage.grd_4c_SubCp.RecordMark  = .F.
6274:             par_oPage.grd_4c_SubCp.RowHeight   = 16
6275:             par_oPage.grd_4c_SubCp.ScrollBars  = 3
6276:             par_oPage.grd_4c_SubCp.Themes      = .F.
6277:             par_oPage.grd_4c_SubCp.Visible     = .T.
6278: 
6279:             par_oPage.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
6280: 
6281:             par_oPage.grd_4c_SubCp.Column1.Header1.Caption  = "Material"
6282:             par_oPage.grd_4c_SubCp.Column1.ControlSource    = "cursor_4c_SubCp.Mats"
6283:             par_oPage.grd_4c_SubCp.Column1.Width            = 80
6284:             par_oPage.grd_4c_SubCp.Column1.Header1.FontBold = .T.
6285: 
6286:             par_oPage.grd_4c_SubCp.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
6287:             par_oPage.grd_4c_SubCp.Column2.ControlSource    = "cursor_4c_SubCp.DPros"
6288:             par_oPage.grd_4c_SubCp.Column2.Width            = 140
6289:             par_oPage.grd_4c_SubCp.Column2.Header1.FontBold = .T.
6290: 
6291:             par_oPage.grd_4c_SubCp.Column3.Header1.Caption  = "Un"
6292:             par_oPage.grd_4c_SubCp.Column3.ControlSource    = "cursor_4c_SubCp.Unisp"
6293:             par_oPage.grd_4c_SubCp.Column3.Width            = 30
6294:             par_oPage.grd_4c_SubCp.Column3.Header1.FontBold = .T.
6295: 
6296:             par_oPage.grd_4c_SubCp.Column4.Header1.Caption  = "Valor"
6297:             par_oPage.grd_4c_SubCp.Column4.ControlSource    = "cursor_4c_SubCp.Vals"
6298:             par_oPage.grd_4c_SubCp.Column4.Width            = 65
6299:             par_oPage.grd_4c_SubCp.Column4.Header1.FontBold = .T.
6300: 
6301:             par_oPage.grd_4c_SubCp.Column5.Header1.Caption  = "Qtde."
6302:             par_oPage.grd_4c_SubCp.Column5.ControlSource    = "cursor_4c_SubCp.Qtds"
6303:             par_oPage.grd_4c_SubCp.Column5.Width            = 60
6304:             par_oPage.grd_4c_SubCp.Column5.Header1.FontBold = .T.
6305: 
6306:             par_oPage.grd_4c_SubCp.Column6.Header1.Caption  = "Total"
6307:             par_oPage.grd_4c_SubCp.Column6.ControlSource    = "cursor_4c_SubCp.Totals"
6308:             par_oPage.grd_4c_SubCp.Column6.Width            = 65
6309:             par_oPage.grd_4c_SubCp.Column6.Header1.FontBold = .T.
6310: 
6311:             par_oPage.grd_4c_SubCp.Column7.Header1.Caption  = "Moe"
6312:             par_oPage.grd_4c_SubCp.Column7.ControlSource    = "cursor_4c_SubCp.Moedas"
6313:             par_oPage.grd_4c_SubCp.Column7.Width            = 30
6314:             par_oPage.grd_4c_SubCp.Column7.Header1.FontBold = .T.
6315: 
6316:             par_oPage.grd_4c_SubCp.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
6317:             par_oPage.grd_4c_SubCp.Column8.ControlSource    = "cursor_4c_SubCp.Obss"
6318:             par_oPage.grd_4c_SubCp.Column8.Width            = 90
6319:             par_oPage.grd_4c_SubCp.Column8.Header1.FontBold = .T.
6320: 
6321:             par_oPage.grd_4c_SubCp.Column9.Header1.Caption  = "E"
6322:             par_oPage.grd_4c_SubCp.Column9.ControlSource    = "cursor_4c_SubCp.Es"
6323:             par_oPage.grd_4c_SubCp.Column9.Width            = 20
6324:             par_oPage.grd_4c_SubCp.Column9.Header1.FontBold = .T.
6325: 
6326:             par_oPage.grd_4c_SubCp.Column10.Header1.Caption  = "Consumo"
6327:             par_oPage.grd_4c_SubCp.Column10.ControlSource    = "cursor_4c_SubCp.Conss"
6328:             par_oPage.grd_4c_SubCp.Column10.Width            = 60
6329:             par_oPage.grd_4c_SubCp.Column10.Header1.FontBold = .T.
6330: 
6331:             par_oPage.grd_4c_SubCp.Column11.Header1.Caption  = "Qtde."
6332:             par_oPage.grd_4c_SubCp.Column11.ControlSource    = "cursor_4c_SubCp.Qtdss"
6333:             par_oPage.grd_4c_SubCp.Column11.Width            = 60
6334:             par_oPage.grd_4c_SubCp.Column11.Header1.FontBold = .T.
6335: 
6336:             par_oPage.grd_4c_SubCp.Column12.Header1.Caption  = "Un"
6337:             par_oPage.grd_4c_SubCp.Column12.ControlSource    = "cursor_4c_SubCp.Unis"
6338:             par_oPage.grd_4c_SubCp.Column12.Width            = 30
6339:             par_oPage.grd_4c_SubCp.Column12.Header1.FontBold = .T.
6340: 
6341:             par_oPage.grd_4c_SubCp.Column13.Header1.Caption  = "Ord"
6342:             par_oPage.grd_4c_SubCp.Column13.ControlSource    = "cursor_4c_SubCp.Ords"
6343:             par_oPage.grd_4c_SubCp.Column13.Width            = 30
6344:             par_oPage.grd_4c_SubCp.Column13.Header1.FontBold = .T.
6345: 
6346:             par_oPage.grd_4c_SubCp.Column14.Header1.Caption  = "Matriz"
6347:             par_oPage.grd_4c_SubCp.Column14.ControlSource    = "cursor_4c_SubCp.Bloqueio"
6348:             par_oPage.grd_4c_SubCp.Column14.Width            = 75
6349:             par_oPage.grd_4c_SubCp.Column14.Header1.FontBold = .T.
6350: 
6351:             par_oPage.grd_4c_SubCp.Column15.Header1.Caption  = "Tam"
6352:             par_oPage.grd_4c_SubCp.Column15.ControlSource    = "cursor_4c_SubCp.Tams"
6353:             par_oPage.grd_4c_SubCp.Column15.Width            = 55
6354:             par_oPage.grd_4c_SubCp.Column15.Header1.FontBold = .T.
6355: 
6356:             *-- === cmdgSubCp (CommandGroup 2 botoes) - top=345+29=374 ===
6357:             par_oPage.AddObject("cmdg_4c_SubCp", "CommandGroup")
6358:             WITH par_oPage.cmdg_4c_SubCp
6359:                 .Top         = 374
6360:                 .Left        = 947
6361:                 .Width       = 50
6362:                 .Height      = 90
6363:                 .ButtonCount = 2
6364:                 .Themes      = .F.
6365:                 .Visible     = .T.
6366:             ENDWITH
6367: 

*-- Linhas 7277 a 7314:
7277:             IF USED("cursor_4c_CustoCompo")
7278:                 USE IN cursor_4c_CustoCompo
7279:             ENDIF
7280:             CREATE CURSOR cursor_4c_CustoCompo (;
7281:                 Mats     C(14)    NULL, ;
7282:                 DPros    C(40)    NULL, ;
7283:                 Unisp    C(5)     NULL, ;
7284:                 Vals     N(15,6)  NULL, ;
7285:                 Qtds     N(15,6)  NULL, ;
7286:                 Totals   N(15,6)  NULL, ;
7287:                 Moedas   C(10)    NULL, ;
7288:                 Obss     C(50)    NULL, ;
7289:                 Es       C(10)    NULL, ;
7290:                 Conss    N(15,6)  NULL, ;
7291:                 Qtdss    N(15,6)  NULL, ;
7292:                 Unis     C(5)     NULL, ;
7293:                 CGrus    C(10)    NULL, ;
7294:                 Bloqueio C(14)    NULL  ;
7295:             )
7296:             IF USED("cursor_4c_GrupoCompo2")
7297:                 USE IN cursor_4c_GrupoCompo2
7298:             ENDIF
7299:             CREATE CURSOR cursor_4c_GrupoCompo2 (;
7300:                 CGrus  C(10)   NULL, ;
7301:                 Totals N(15,6) NULL, ;
7302:                 Moedas C(10)   NULL  ;
7303:             )
7304:             SET NULL OFF
7305: 
7306:             *-- === Say1: label "Tipo:" - top=159+29=188, left=112 ===
7307:             par_oPage.AddObject("lbl_4c_LblTipo", "Label")
7308:             WITH par_oPage.lbl_4c_LblTipo
7309:                 .Top       = 188
7310:                 .Left      = 112
7311:                 .Width     = 29
7312:                 .Height    = 15
7313:                 .FontName  = "Tahoma"
7314:                 .FontSize  = 8

*-- Linhas 7343 a 7428:
7343:             par_oPage.grd_4c_GrdCustoCompo.FontName    = "Tahoma"
7344:             par_oPage.grd_4c_GrdCustoCompo.FontSize    = 8
7345:             par_oPage.grd_4c_GrdCustoCompo.GridLines   = 3
7346:             par_oPage.grd_4c_GrdCustoCompo.DeleteMark  = .F.
7347:             par_oPage.grd_4c_GrdCustoCompo.RecordMark  = .F.
7348:             par_oPage.grd_4c_GrdCustoCompo.RowHeight   = 16
7349:             par_oPage.grd_4c_GrdCustoCompo.ScrollBars  = 3
7350:             par_oPage.grd_4c_GrdCustoCompo.Themes      = .F.
7351:             par_oPage.grd_4c_GrdCustoCompo.Visible     = .T.
7352: 
7353:             par_oPage.grd_4c_GrdCustoCompo.RecordSource = "cursor_4c_CustoCompo"
7354: 
7355:             par_oPage.grd_4c_GrdCustoCompo.Column1.Header1.Caption  = "Item"
7356:             par_oPage.grd_4c_GrdCustoCompo.Column1.ControlSource    = "cursor_4c_CustoCompo.Mats"
7357:             par_oPage.grd_4c_GrdCustoCompo.Column1.Width            = 80
7358:             par_oPage.grd_4c_GrdCustoCompo.Column1.Header1.FontBold = .T.
7359: 
7360:             par_oPage.grd_4c_GrdCustoCompo.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
7361:             par_oPage.grd_4c_GrdCustoCompo.Column2.ControlSource    = "cursor_4c_CustoCompo.DPros"
7362:             par_oPage.grd_4c_GrdCustoCompo.Column2.Width            = 160
7363:             par_oPage.grd_4c_GrdCustoCompo.Column2.Header1.FontBold = .T.
7364: 
7365:             par_oPage.grd_4c_GrdCustoCompo.Column3.Header1.Caption  = "Un"
7366:             par_oPage.grd_4c_GrdCustoCompo.Column3.ControlSource    = "cursor_4c_CustoCompo.Unisp"
7367:             par_oPage.grd_4c_GrdCustoCompo.Column3.Width            = 35
7368:             par_oPage.grd_4c_GrdCustoCompo.Column3.ReadOnly         = .T.
7369:             par_oPage.grd_4c_GrdCustoCompo.Column3.Header1.FontBold = .T.
7370: 
7371:             par_oPage.grd_4c_GrdCustoCompo.Column4.Header1.Caption  = "Valor"
7372:             par_oPage.grd_4c_GrdCustoCompo.Column4.ControlSource    = "cursor_4c_CustoCompo.Vals"
7373:             par_oPage.grd_4c_GrdCustoCompo.Column4.Width            = 80
7374:             par_oPage.grd_4c_GrdCustoCompo.Column4.Header1.FontBold = .T.
7375: 
7376:             par_oPage.grd_4c_GrdCustoCompo.Column5.Header1.Caption  = "Qtde."
7377:             par_oPage.grd_4c_GrdCustoCompo.Column5.ControlSource    = "cursor_4c_CustoCompo.Qtds"
7378:             par_oPage.grd_4c_GrdCustoCompo.Column5.Width            = 65
7379:             par_oPage.grd_4c_GrdCustoCompo.Column5.Header1.FontBold = .T.
7380: 
7381:             par_oPage.grd_4c_GrdCustoCompo.Column6.Header1.Caption  = "Total"
7382:             par_oPage.grd_4c_GrdCustoCompo.Column6.ControlSource    = "cursor_4c_CustoCompo.Totals"
7383:             par_oPage.grd_4c_GrdCustoCompo.Column6.Width            = 80
7384:             par_oPage.grd_4c_GrdCustoCompo.Column6.ReadOnly         = .T.
7385:             par_oPage.grd_4c_GrdCustoCompo.Column6.Header1.FontBold = .T.
7386: 
7387:             par_oPage.grd_4c_GrdCustoCompo.Column7.Header1.Caption  = "Moe"
7388:             par_oPage.grd_4c_GrdCustoCompo.Column7.ControlSource    = "cursor_4c_CustoCompo.Moedas"
7389:             par_oPage.grd_4c_GrdCustoCompo.Column7.Width            = 40
7390:             par_oPage.grd_4c_GrdCustoCompo.Column7.Header1.FontBold = .T.
7391: 
7392:             par_oPage.grd_4c_GrdCustoCompo.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
7393:             par_oPage.grd_4c_GrdCustoCompo.Column8.ControlSource    = "cursor_4c_CustoCompo.Obss"
7394:             par_oPage.grd_4c_GrdCustoCompo.Column8.Width            = 100
7395:             par_oPage.grd_4c_GrdCustoCompo.Column8.Header1.FontBold = .T.
7396: 
7397:             par_oPage.grd_4c_GrdCustoCompo.Column9.Header1.Caption  = "E"
7398:             par_oPage.grd_4c_GrdCustoCompo.Column9.ControlSource    = "cursor_4c_CustoCompo.Es"
7399:             par_oPage.grd_4c_GrdCustoCompo.Column9.Width            = 30
7400:             par_oPage.grd_4c_GrdCustoCompo.Column9.Header1.FontBold = .T.
7401: 
7402:             par_oPage.grd_4c_GrdCustoCompo.Column10.Header1.Caption  = "Consumo"
7403:             par_oPage.grd_4c_GrdCustoCompo.Column10.ControlSource    = "cursor_4c_CustoCompo.Conss"
7404:             par_oPage.grd_4c_GrdCustoCompo.Column10.Width            = 65
7405:             par_oPage.grd_4c_GrdCustoCompo.Column10.Header1.FontBold = .T.
7406: 
7407:             par_oPage.grd_4c_GrdCustoCompo.Column11.Header1.Caption  = "Qtde."
7408:             par_oPage.grd_4c_GrdCustoCompo.Column11.ControlSource    = "cursor_4c_CustoCompo.Qtdss"
7409:             par_oPage.grd_4c_GrdCustoCompo.Column11.Width            = 65
7410:             par_oPage.grd_4c_GrdCustoCompo.Column11.Header1.FontBold = .T.
7411: 
7412:             par_oPage.grd_4c_GrdCustoCompo.Column12.Header1.Caption  = "Un"
7413:             par_oPage.grd_4c_GrdCustoCompo.Column12.ControlSource    = "cursor_4c_CustoCompo.Unis"
7414:             par_oPage.grd_4c_GrdCustoCompo.Column12.Width            = 35
7415:             par_oPage.grd_4c_GrdCustoCompo.Column12.ReadOnly         = .T.
7416:             par_oPage.grd_4c_GrdCustoCompo.Column12.Header1.FontBold = .T.
7417: 
7418:             *-- === cmdgCompo (2 botoes +/-) - top=240+29=269, left=851, w=50, h=90 ===
7419:             par_oPage.AddObject("cmdg_4c_CustoCompo", "CommandGroup")
7420:             WITH par_oPage.cmdg_4c_CustoCompo
7421:                 .Top         = 269
7422:                 .Left        = 851
7423:                 .Width       = 50
7424:                 .Height      = 90
7425:                 .ButtonCount = 2
7426:                 .Themes      = .F.
7427:                 .Visible     = .T.
7428:             ENDWITH

*-- Linhas 7543 a 7581:
7543:             par_oPage.grd_4c_GrupoCompo2.FontName    = "Tahoma"
7544:             par_oPage.grd_4c_GrupoCompo2.FontSize    = 8
7545:             par_oPage.grd_4c_GrupoCompo2.GridLines   = 3
7546:             par_oPage.grd_4c_GrupoCompo2.DeleteMark  = .F.
7547:             par_oPage.grd_4c_GrupoCompo2.RecordMark  = .F.
7548:             par_oPage.grd_4c_GrupoCompo2.ReadOnly    = .T.
7549:             par_oPage.grd_4c_GrupoCompo2.ScrollBars  = 2
7550:             par_oPage.grd_4c_GrupoCompo2.Themes      = .F.
7551:             par_oPage.grd_4c_GrupoCompo2.Visible     = .T.
7552: 
7553:             par_oPage.grd_4c_GrupoCompo2.RecordSource = "cursor_4c_GrupoCompo2"
7554: 
7555:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.Caption  = "Grp"
7556:             par_oPage.grd_4c_GrupoCompo2.Column1.ControlSource    = "cursor_4c_GrupoCompo2.CGrus"
7557:             par_oPage.grd_4c_GrupoCompo2.Column1.Width            = 60
7558:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.FontBold = .T.
7559: 
7560:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.Caption  = "Total"
7561:             par_oPage.grd_4c_GrupoCompo2.Column2.ControlSource    = "cursor_4c_GrupoCompo2.Totals"
7562:             par_oPage.grd_4c_GrupoCompo2.Column2.Width            = 90
7563:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.FontBold = .T.
7564: 
7565:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.Caption  = "Moe"
7566:             par_oPage.grd_4c_GrupoCompo2.Column3.ControlSource    = "cursor_4c_GrupoCompo2.Moedas"
7567:             par_oPage.grd_4c_GrupoCompo2.Column3.Width            = 40
7568:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.FontBold = .T.
7569: 
7570:         CATCH TO loc_oErro
7571:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina Custo")
7572:         ENDTRY
7573:     ENDPROC
7574: 
7575:     *==========================================================================
7576:     * CarregarComposicao - Carrega SigPrCpo e SigPrScp para o produto atual
7577:     *==========================================================================
7578:     PROCEDURE CarregarComposicao()
7579:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgComp, loc_oErro
7580:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
7581:             RETURN

*-- Linhas 7590 a 7689:
7590:             IF USED("cursor_4c_CompoTemp")
7591:                 USE IN cursor_4c_CompoTemp
7592:             ENDIF
7593:             loc_cSQL = "SELECT c.mats, ISNULL(p.DPros,'') AS DPros, " + ;
7594:                        "       c.unicompos AS Unisp, c.pcompos AS Vals, c.qtds, c.totas AS Totals, c.moeds AS Moedas, " + ;
7595:                        "       ISNULL(c.obscompos,'') AS Obss, ISNULL(c.etiqs,'') AS Es, " + ;
7596:                        "       c.qtscons AS Conss, c.pesos AS Qtdss, ISNULL(c.cunips,'') AS Unis, " + ;
7597:                        "       c.ordts AS Ords, ISNULL(c.matriz,'') AS Bloqueio " + ;
7598:                        "FROM SigPrCpo c " + ;
7599:                        "LEFT JOIN SigCdPro p ON p.CPros = c.mats " + ;
7600:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7601:                        " ORDER BY c.ordts"
7602:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoTemp")
7603:             IF loc_nRet > 0
7604:                 SELECT cursor_4c_Compo
7605:                 ZAP
7606:                 APPEND FROM DBF("cursor_4c_CompoTemp")
7607:                 IF USED("cursor_4c_CompoTemp")
7608:                     USE IN cursor_4c_CompoTemp
7609:                 ENDIF
7610:                 SELECT cursor_4c_Compo
7611:                 GO TOP
7612:             ENDIF
7613: 
7614:             *-- Carregar subcomposicao (SigPrScp)
7615:             IF USED("cursor_4c_SubCpTemp")
7616:                 USE IN cursor_4c_SubCpTemp
7617:             ENDIF
7618:             loc_cSQL = "SELECT s.Mats, ISNULL(p.DPros,'') AS DPros, " + ;
7619:                        "       s.Unisp, s.Vals, s.Qtds, s.Totals, s.Moedas, " + ;
7620:                        "       ISNULL(s.Obss,'') AS Obss, ISNULL(s.Es,'') AS Es, " + ;
7621:                        "       s.Conss, s.Qtdss, ISNULL(s.Unis,'') AS Unis, " + ;
7622:                        "       s.Ords, ISNULL(s.Bloqueio,'') AS Bloqueio, " + ;
7623:                        "       ISNULL(s.Tams,'') AS Tams " + ;
7624:                        "FROM SigPrScp s " + ;
7625:                        "LEFT JOIN SigCdPro p ON p.CPros = s.Mats " + ;
7626:                        "WHERE s.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7627:                        " ORDER BY s.Ords"
7628:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SubCpTemp")
7629:             IF loc_nRet > 0
7630:                 SELECT cursor_4c_SubCp
7631:                 ZAP
7632:                 APPEND FROM DBF("cursor_4c_SubCpTemp")
7633:                 IF USED("cursor_4c_SubCpTemp")
7634:                     USE IN cursor_4c_SubCpTemp
7635:                 ENDIF
7636:                 SELECT cursor_4c_SubCp
7637:                 GO TOP
7638:             ENDIF
7639: 
7640:             *-- Refresh grids
7641:             loc_oPgComp = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7642:             loc_oPgComp.grd_4c_Compo.Refresh()
7643:             loc_oPgComp.grd_4c_SubCp.Refresh()
7644:             loc_oPgComp.grd_4c_Grupo.Refresh()
7645: 
7646:         CATCH TO loc_oErro
7647:             MsgErro(loc_oErro.Message, "Erro ao carregar composi" + CHR(231) + CHR(227) + "o")
7648:         ENDTRY
7649:     ENDPROC
7650: 
7651:     *==========================================================================
7652:     * Handlers de composicao (PUBLIC - obrigatorio para BINDEVENT)
7653:     *==========================================================================
7654:     PROCEDURE CompoAfterRowColChange(par_nColIndex)
7655:         LOCAL loc_oPg, loc_oErro
7656:         TRY
7657:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7658:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
7659:                 SELECT cursor_4c_Compo
7660:                 loc_oPg.txt_4c_Desc.Value    = ALLTRIM(DPros)
7661:                 loc_oPg.txt_4c_MatP.Value    = ALLTRIM(Mats)
7662:                 loc_oPg.txt_4c_ObsOFs.Value  = ALLTRIM(Obss)
7663:             ENDIF
7664:         CATCH TO loc_oErro
7665:             *-- Tolerado
7666:         ENDTRY
7667:     ENDPROC
7668: 
7669:     PROCEDURE SubCpAfterRowColChange(par_nColIndex)
7670:         LOCAL loc_oPg, loc_oErro
7671:         TRY
7672:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7673:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
7674:                 SELECT cursor_4c_SubCp
7675:                 loc_oPg.txt_4c_Desccp.Value = ALLTRIM(DPros)
7676:                 loc_oPg.txt_4c_Matsub.Value = ALLTRIM(Mats)
7677:             ENDIF
7678:         CATCH TO loc_oErro
7679:             *-- Tolerado
7680:         ENDTRY
7681:     ENDPROC
7682: 
7683:     PROCEDURE LiberaCustoChange()
7684:         LOCAL loc_oPg, loc_lLibera, loc_oErro
7685:         TRY
7686:             loc_oPg     = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7687:             loc_lLibera = (loc_oPg.chk_4c_ChkLiberaCusto.Value = 1) AND this_lEmEdicao
7688:             loc_oPg.txt_4c_Pcus.ReadOnly    = !loc_lLibera
7689:             loc_oPg.txt_4c_Moec.ReadOnly    = !loc_lLibera

*-- Linhas 7855 a 7875:
7855:                 ENDIF
7856:             ENDIF
7857:             IF loc_lContinuar AND gnConnHandle > 0
7858:                 loc_nRet = SQLEXEC(gnConnHandle, ;
7859:                     "INSERT INTO SigPrCpo (CPros, DtMovs, cIdChaves, TpCalcCus) " + ;
7860:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7861:                     ", GETDATE(), NEWID(), 1)")
7862:                 IF loc_nRet < 1
7863:                     MsgErro("Erro ao incluir linha de composi" + CHR(231) + CHR(227) + "o.", "Erro")
7864:                 ELSE
7865:                     THIS.CarregarComposicao()
7866:                 ENDIF
7867:             ENDIF
7868:         CATCH TO loc_oErro
7869:             MsgErro(loc_oErro.Message, "Erro ao incluir linha de composi" + CHR(231) + CHR(227) + "o")
7870:         ENDTRY
7871:     ENDPROC
7872: 
7873:     *-- Excluir linha da composicao principal
7874:     PROCEDURE CompoExcluirClick()
7875:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar

*-- Linhas 7888 a 7910:
7888:             IF loc_lContinuar
7889:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de composi" + CHR(231) + CHR(227) + "o?", "Confirmar")
7890:                 IF loc_lConfirmou AND gnConnHandle > 0
7891:                     SELECT cursor_4c_Compo
7892:                     loc_cMats = ALLTRIM(Mats)
7893:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
7894:                         "DELETE FROM SigPrCpo WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
7895:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
7896:                     THIS.CarregarComposicao()
7897:                 ENDIF
7898:             ENDIF
7899:         CATCH TO loc_oErro
7900:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de composi" + CHR(231) + CHR(227) + "o")
7901:         ENDTRY
7902:     ENDPROC
7903: 
7904:     PROCEDURE CompoAtualizaClick()
7905:         LOCAL loc_oErro
7906:         TRY
7907:             THIS.CarregarComposicao()
7908:         CATCH TO loc_oErro
7909:             MsgErro(loc_oErro.Message, "Erro ao atualizar composi" + CHR(231) + CHR(227) + "o")
7910:         ENDTRY

*-- Linhas 7944 a 7964:
7944:                 ENDIF
7945:             ENDIF
7946:             IF loc_lContinuar AND gnConnHandle > 0
7947:                 loc_nRet = SQLEXEC(gnConnHandle, ;
7948:                     "INSERT INTO SigPrScp (CPros, DtMovs, cIdChaves) " + ;
7949:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
7950:                     ", GETDATE(), NEWID())")
7951:                 IF loc_nRet < 1
7952:                     MsgErro("Erro ao incluir linha de subcomposi" + CHR(231) + CHR(227) + "o.", "Erro")
7953:                 ELSE
7954:                     THIS.CarregarComposicao()
7955:                 ENDIF
7956:             ENDIF
7957:         CATCH TO loc_oErro
7958:             MsgErro(loc_oErro.Message, "Erro ao incluir subcomposi" + CHR(231) + CHR(227) + "o")
7959:         ENDTRY
7960:     ENDPROC
7961: 
7962:     *-- Excluir linha da subcomposicao
7963:     PROCEDURE SubCpExcluirClick()
7964:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar

*-- Linhas 7975 a 7997:
7975:             IF loc_lContinuar
7976:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de subcomposi" + CHR(231) + CHR(227) + "o?", "Confirmar")
7977:                 IF loc_lConfirmou AND gnConnHandle > 0
7978:                     SELECT cursor_4c_SubCp
7979:                     loc_cMats = ALLTRIM(Mats)
7980:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
7981:                         "DELETE FROM SigPrScp WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
7982:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
7983:                     THIS.CarregarComposicao()
7984:                 ENDIF
7985:             ENDIF
7986:         CATCH TO loc_oErro
7987:             MsgErro(loc_oErro.Message, "Erro ao excluir subcomposi" + CHR(231) + CHR(227) + "o")
7988:         ENDTRY
7989:     ENDPROC
7990: 
7991:     *==========================================================================
7992:     * Helpers de composicao (PROTECTED)
7993:     *==========================================================================
7994:     PROTECTED PROCEDURE AbrirLookupMoedaComp(par_oTextBox)
7995:         LOCAL loc_oBusca, loc_cCodigo, loc_oErro
7996:         TRY
7997:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 8028 a 8048:
8028:             IF EMPTY(loc_cCod)
8029:                 RETURN
8030:             ENDIF
8031:             loc_nRet = SQLEXEC(gnConnHandle, ;
8032:                 "SELECT Cods FROM SigPrFti WHERE Cods = " + ;
8033:                 EscaparSQL(PADR(loc_cCod, 5)), ;
8034:                 "cursor_4c_ValFtio")
8035:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_ValFtio") = 0
8036:                 loc_oPg.txt_4c_Ftio.Value = ""
8037:             ENDIF
8038:             IF USED("cursor_4c_ValFtio")
8039:                 USE IN cursor_4c_ValFtio
8040:             ENDIF
8041:             THIS.CarregarLista()
8042:         CATCH TO loc_oErro
8043:             MsgErro(loc_oErro.Message, "Erro ao validar feitio")
8044:         ENDTRY
8045:     ENDPROC
8046: 
8047:     PROTECTED PROCEDURE ValidarCmkpc()
8048:         LOCAL loc_oPg, loc_cCod, loc_nRet, loc_oErro

*-- Linhas 8055 a 8075:
8055:             IF EMPTY(loc_cCod)
8056:                 RETURN
8057:             ENDIF
8058:             loc_nRet = SQLEXEC(gnConnHandle, ;
8059:                 "SELECT Cods FROM SigPrFti WHERE Cods = " + ;
8060:                 EscaparSQL(PADR(loc_cCod, 5)), ;
8061:                 "cursor_4c_ValCmkpc")
8062:             IF loc_nRet <= 0 OR RECCOUNT("cursor_4c_ValCmkpc") = 0
8063:                 loc_oPg.txt_4c_Cmkpc.Value = ""
8064:             ENDIF
8065:             IF USED("cursor_4c_ValCmkpc")
8066:                 USE IN cursor_4c_ValCmkpc
8067:             ENDIF
8068:             THIS.CarregarLista()
8069:         CATCH TO loc_oErro
8070:             MsgErro(loc_oErro.Message, "Erro ao validar markup custo")
8071:         ENDTRY
8072:     ENDPROC
8073: 
8074:     *==========================================================================
8075:     * CarregarCusto - Carrega SigPrCpo filtrado por Tipos para pgCusto

*-- Linhas 8097 a 8192:
8097:             IF USED("cursor_4c_CustoCompoTemp")
8098:                 USE IN cursor_4c_CustoCompoTemp
8099:             ENDIF
8100:             loc_cSQL = "SELECT c.mats, ISNULL(p.DPros,'') AS DPros, " + ;
8101:                        "       c.unicompos AS Unisp, c.pcompos AS Vals, c.qtds, c.totas AS Totals, c.moeds AS Moedas, " + ;
8102:                        "       ISNULL(c.obscompos,'') AS Obss, ISNULL(c.etiqs,'') AS Es, " + ;
8103:                        "       c.qtscons AS Conss, c.pesos AS Qtdss, ISNULL(c.cunips,'') AS Unis, " + ;
8104:                        "       ISNULL(p.CGrus,'') AS CGrus, ISNULL(c.matriz,'') AS Bloqueio " + ;
8105:                        "FROM SigPrCpo c " + ;
8106:                        "LEFT JOIN SigCdPro p ON p.CPros = c.mats " + ;
8107:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
8108:             IF loc_nTipo > 0
8109:                 loc_cSQL = loc_cSQL + " AND ISNULL(c.Tipos, 0) = " + LTRIM(STR(loc_nTipo))
8110:             ENDIF
8111:             loc_cSQL = loc_cSQL + " ORDER BY c.ordts"
8112: 
8113:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CustoCompoTemp")
8114:             IF loc_nRet > 0
8115:                 SELECT cursor_4c_CustoCompo
8116:                 ZAP
8117:                 APPEND FROM DBF("cursor_4c_CustoCompoTemp")
8118:                 IF USED("cursor_4c_CustoCompoTemp")
8119:                     USE IN cursor_4c_CustoCompoTemp
8120:                 ENDIF
8121:                 SELECT cursor_4c_CustoCompo
8122:                 GO TOP
8123:             ENDIF
8124: 
8125:             *-- Carregar resumo por grupo (GradeGRUPO2)
8126:             IF USED("cursor_4c_GrupoCompo2Temp")
8127:                 USE IN cursor_4c_GrupoCompo2Temp
8128:             ENDIF
8129:             loc_cSQL = "SELECT ISNULL(p.CGrus,'') AS CGrus, " + ;
8130:                        "       SUM(c.totas) AS Totals, MIN(c.moeds) AS Moedas " + ;
8131:                        "FROM SigPrCpo c " + ;
8132:                        "LEFT JOIN SigCdPro p ON p.CPros = c.mats " + ;
8133:                        "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
8134:             IF loc_nTipo > 0
8135:                 loc_cSQL = loc_cSQL + " AND ISNULL(c.Tipos, 0) = " + LTRIM(STR(loc_nTipo))
8136:             ENDIF
8137:             loc_cSQL = loc_cSQL + " GROUP BY p.CGrus ORDER BY p.CGrus"
8138: 
8139:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoCompo2Temp")
8140:             IF loc_nRet > 0
8141:                 SELECT cursor_4c_GrupoCompo2
8142:                 ZAP
8143:                 APPEND FROM DBF("cursor_4c_GrupoCompo2Temp")
8144:                 IF USED("cursor_4c_GrupoCompo2Temp")
8145:                     USE IN cursor_4c_GrupoCompo2Temp
8146:                 ENDIF
8147:                 SELECT cursor_4c_GrupoCompo2
8148:                 GO TOP
8149:             ENDIF
8150: 
8151:             *-- Refresh grids
8152:             loc_oPgCusto.grd_4c_GrdCustoCompo.Refresh()
8153:             loc_oPgCusto.grd_4c_GrupoCompo2.Refresh()
8154: 
8155:         CATCH TO loc_oErro
8156:             MsgErro(loc_oErro.Message, "Erro ao carregar custo")
8157:         ENDTRY
8158:     ENDPROC
8159: 
8160:     *==========================================================================
8161:     * Handlers da pagina Custo (PUBLIC - obrigatorio para BINDEVENT)
8162:     *==========================================================================
8163:     PROCEDURE GrdCustoCompoAfterRowColChange(par_nColIndex)
8164:         LOCAL loc_oPg, loc_cSQL, loc_nRet, loc_cGrus, loc_cDGrus, loc_oErro
8165:         TRY
8166:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page6
8167:             IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
8168:                 SELECT cursor_4c_CustoCompo
8169:                 loc_oPg.txt_4c_DescCus.Value  = ALLTRIM(DPros)
8170:                 loc_cGrus = ALLTRIM(CGrus)
8171:                 *-- Buscar descricao do grupo
8172:                 IF !EMPTY(loc_cGrus) AND gnConnHandle > 0
8173:                     IF USED("cursor_4c_GruCusto")
8174:                         USE IN cursor_4c_GruCusto
8175:                     ENDIF
8176:                     loc_cSQL = "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(PADR(loc_cGrus, 10))
8177:                     loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruCusto")
8178:                     IF loc_nRet > 0 AND !EOF("cursor_4c_GruCusto")
8179:                         loc_cDGrus = ALLTRIM(cursor_4c_GruCusto.DGrus)
8180:                     ELSE
8181:                         loc_cDGrus = ""
8182:                     ENDIF
8183:                     IF USED("cursor_4c_GruCusto")
8184:                         USE IN cursor_4c_GruCusto
8185:                     ENDIF
8186:                     loc_oPg.txt_4c_DGruCompos.Value = loc_cDGrus
8187:                 ELSE
8188:                     loc_oPg.txt_4c_DGruCompos.Value = ""
8189:                 ENDIF
8190:             ENDIF
8191:         CATCH TO loc_oErro
8192:             *-- Tolerado

*-- Linhas 8223 a 8243:
8223:                 IF VARTYPE(loc_oPgCusto.cbo_4c_CmbTipos.Value) = "N"
8224:                     loc_nTipo = INT(loc_oPgCusto.cbo_4c_CmbTipos.Value)
8225:                 ENDIF
8226:                 loc_nRet = SQLEXEC(gnConnHandle, ;
8227:                     "INSERT INTO SigPrCpo (CPros, DtMovs, cIdChaves, Tipos) " + ;
8228:                     "VALUES (" + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8229:                     ", GETDATE(), NEWID(), " + LTRIM(STR(loc_nTipo)) + ")")
8230:                 IF loc_nRet < 1
8231:                     MsgErro("Erro ao incluir linha de custo.", "Erro")
8232:                 ELSE
8233:                     THIS.CarregarCusto()
8234:                 ENDIF
8235:             ENDIF
8236:         CATCH TO loc_oErro
8237:             MsgErro(loc_oErro.Message, "Erro ao incluir linha de custo")
8238:         ENDTRY
8239:     ENDPROC
8240: 
8241:     PROCEDURE CustoCompoExcluirClick()
8242:         LOCAL loc_nRet, loc_cMats, loc_lConfirmou, loc_oErro, loc_lContinuar
8243:         loc_lContinuar = .T.

*-- Linhas 8255 a 8313:
8255:             IF loc_lContinuar
8256:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta linha de custo?", "Confirmar")
8257:                 IF loc_lConfirmou AND gnConnHandle > 0
8258:                     SELECT cursor_4c_CustoCompo
8259:                     loc_cMats = ALLTRIM(Mats)
8260:                     loc_nRet  = SQLEXEC(gnConnHandle, ;
8261:                         "DELETE FROM SigPrCpo WHERE CPros = " + EscaparSQL(PADR(ALLTRIM(this_cCodigo), 14)) + ;
8262:                         " AND Mats = " + EscaparSQL(PADR(loc_cMats, 14)))
8263:                     THIS.CarregarCusto()
8264:                 ENDIF
8265:             ENDIF
8266:         CATCH TO loc_oErro
8267:             MsgErro(loc_oErro.Message, "Erro ao excluir linha de custo")
8268:         ENDTRY
8269:     ENDPROC
8270: 
8271:     *==========================================================================
8272:     * ConfigurarPgPgDadosConsP - PgDadosConsP (Page5 do pgf_4c_DadosInterno)
8273:     * Cons P: GrdCons (9 colunas), Getqtcpnt, chkFund, grDTEMP (2 colunas)
8274:     * Posicoes: original_top + 29
8275:     *==========================================================================
8276:     PROTECTED PROCEDURE ConfigurarPgPgDadosConsP(par_oPage)
8277:         LOCAL loc_oGrd, loc_oErro
8278:         TRY
8279:             *-- === Cursores placeholder ANTES dos grids ===
8280:             SET NULL ON
8281:             IF USED("cursor_4c_ConsP")
8282:                 USE IN cursor_4c_ConsP
8283:             ENDIF
8284:             CREATE CURSOR cursor_4c_ConsP (;
8285:                 Mats   C(14)   NULL, ;
8286:                 Qtds   N(15,6) NULL, ;
8287:                 Unisp  C(5)    NULL, ;
8288:                 Grupos C(10)   NULL, ;
8289:                 Descrs C(50)   NULL, ;
8290:                 Ordems N(5,0)  NULL, ;
8291:                 Conss  N(15,6) NULL, ;
8292:                 Ccats  C(10)   NULL, ;
8293:                 DCats  C(50)   NULL  ;
8294:             )
8295:             IF USED("cursor_4c_DTemp")
8296:                 USE IN cursor_4c_DTemp
8297:             ENDIF
8298:             CREATE CURSOR cursor_4c_DTemp (;
8299:                 Grupos C(10)   NULL, ;
8300:                 TempoP N(10,2) NULL  ;
8301:             )
8302:             SET NULL OFF
8303: 
8304:             *-- === Say7: label "Qtde Componentes :" - top=523+29=552, left=25 ===
8305:             par_oPage.AddObject("lbl_4c_Label7", "Label")
8306:             WITH par_oPage.lbl_4c_Label7
8307:                 .Top       = 552
8308:                 .Left      = 25
8309:                 .Width     = 105
8310:                 .Height    = 15
8311:                 .FontName  = "Tahoma"
8312:                 .FontSize  = 8
8313:                 .BackStyle = 0

*-- Linhas 8369 a 8479:
8369:             loc_oGrd.FontName    = "Tahoma"
8370:             loc_oGrd.FontSize    = 8
8371:             loc_oGrd.GridLines   = 3
8372:             loc_oGrd.DeleteMark  = .F.
8373:             loc_oGrd.RecordMark  = .F.
8374:             loc_oGrd.RowHeight   = 16
8375:             loc_oGrd.ScrollBars  = 3
8376:             loc_oGrd.Themes      = .F.
8377:             loc_oGrd.Visible     = .T.
8378: 
8379:             loc_oGrd.RecordSource = "cursor_4c_ConsP"
8380: 
8381:             loc_oGrd.Column1.Header1.Caption  = "Componente"
8382:             loc_oGrd.Column1.ControlSource    = "cursor_4c_ConsP.Mats"
8383:             loc_oGrd.Column1.Width            = 100
8384:             loc_oGrd.Column1.ReadOnly         = .T.
8385:             loc_oGrd.Column1.Header1.FontBold = .T.
8386: 
8387:             loc_oGrd.Column2.Header1.Caption  = "Qtde."
8388:             loc_oGrd.Column2.ControlSource    = "cursor_4c_ConsP.Qtds"
8389:             loc_oGrd.Column2.Width            = 65
8390:             loc_oGrd.Column2.ReadOnly         = .T.
8391:             loc_oGrd.Column2.Header1.FontBold = .T.
8392: 
8393:             loc_oGrd.Column3.Header1.Caption  = "Uni"
8394:             loc_oGrd.Column3.ControlSource    = "cursor_4c_ConsP.Unisp"
8395:             loc_oGrd.Column3.Width            = 45
8396:             loc_oGrd.Column3.ReadOnly         = .T.
8397:             loc_oGrd.Column3.Header1.FontBold = .T.
8398: 
8399:             loc_oGrd.Column4.Header1.Caption  = "Fase"
8400:             loc_oGrd.Column4.ControlSource    = "cursor_4c_ConsP.Grupos"
8401:             loc_oGrd.Column4.Width            = 65
8402:             loc_oGrd.Column4.Header1.FontBold = .T.
8403: 
8404:             loc_oGrd.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
8405:             loc_oGrd.Column5.ControlSource    = "cursor_4c_ConsP.Descrs"
8406:             loc_oGrd.Column5.Width            = 200
8407:             loc_oGrd.Column5.Header1.FontBold = .T.
8408: 
8409:             loc_oGrd.Column6.Header1.Caption  = "Ord."
8410:             loc_oGrd.Column6.ControlSource    = "cursor_4c_ConsP.Ordems"
8411:             loc_oGrd.Column6.Width            = 40
8412:             loc_oGrd.Column6.ReadOnly         = .T.
8413:             loc_oGrd.Column6.Header1.FontBold = .T.
8414: 
8415:             loc_oGrd.Column7.Header1.Caption  = "Consumo"
8416:             loc_oGrd.Column7.ControlSource    = "cursor_4c_ConsP.Conss"
8417:             loc_oGrd.Column7.Width            = 80
8418:             loc_oGrd.Column7.Header1.FontBold = .T.
8419: 
8420:             loc_oGrd.Column8.Header1.Caption  = "Cat."
8421:             loc_oGrd.Column8.ControlSource    = "cursor_4c_ConsP.Ccats"
8422:             loc_oGrd.Column8.Width            = 60
8423:             loc_oGrd.Column8.Header1.FontBold = .T.
8424: 
8425:             loc_oGrd.Column9.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
8426:             loc_oGrd.Column9.ControlSource    = "cursor_4c_ConsP.DCats"
8427:             loc_oGrd.Column9.Width            = 150
8428:             loc_oGrd.Column9.ReadOnly         = .T.
8429:             loc_oGrd.Column9.Header1.FontBold = .T.
8430: 
8431:             *-- BINDEVENT para colunas editaveis (F4=115 dispara lookup)
8432:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
8433:             BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
8434:             BINDEVENT(loc_oGrd.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
8435: 
8436:             *-- === grDTEMP - top=519+29=548, left=821, w=172, h=107, 2 colunas ===
8437:             par_oPage.AddObject("grd_4c_GrDTEMP", "Grid")
8438:             WITH par_oPage.grd_4c_GrDTEMP
8439:                 .Top         = 548
8440:                 .Left        = 821
8441:                 .Width       = 172
8442:                 .Height      = 107
8443:                 .ColumnCount = 2
8444:                 .FontName    = "Tahoma"
8445:                 .FontSize    = 8
8446:                 .GridLines   = 3
8447:                 .DeleteMark  = .F.
8448:                 .RecordMark  = .F.
8449:                 .RowHeight   = 16
8450:                 .ScrollBars  = 3
8451:                 .Themes      = .F.
8452:                 .Visible     = .T.
8453:             ENDWITH
8454: 
8455:             par_oPage.grd_4c_GrDTEMP.RecordSource = "cursor_4c_DTemp"
8456: 
8457:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.Caption  = "Agrupamento"
8458:             par_oPage.grd_4c_GrDTEMP.Column1.ControlSource    = "cursor_4c_DTemp.Grupos"
8459:             par_oPage.grd_4c_GrDTEMP.Column1.Width            = 90
8460:             par_oPage.grd_4c_GrDTEMP.Column1.ReadOnly         = .T.
8461:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.FontBold = .T.
8462: 
8463:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.Caption  = "Tempo %"
8464:             par_oPage.grd_4c_GrDTEMP.Column2.ControlSource    = "cursor_4c_DTemp.TempoP"
8465:             par_oPage.grd_4c_GrDTEMP.Column2.Width            = 70
8466:             par_oPage.grd_4c_GrDTEMP.Column2.ReadOnly         = .T.
8467:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.FontBold = .T.
8468: 
8469:         CATCH TO loc_oErro
8470:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina ConsP")
8471:         ENDTRY
8472:     ENDPROC
8473: 
8474:     *==========================================================================
8475:     * CarregarConsP - Carrega SigPrCpo com fase (SigCdPrf) e cat (SigCdCat)
8476:     *==========================================================================
8477:     PROCEDURE CarregarConsP()
8478:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgConsP, loc_oErro, loc_lContinuar
8479:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 8491 a 8556:
8491:                 IF USED("cursor_4c_ConsPTemp")
8492:                     USE IN cursor_4c_ConsPTemp
8493:                 ENDIF
8494:                 loc_cSQL = "SELECT c.mats, ISNULL(c.qtds,0) AS Qtds, " + ;
8495:                            "       ISNULL(c.unicompos,'') AS Unisp, " + ;
8496:                            "       ISNULL(c.grupos,'') AS Grupos, " + ;
8497:                            "       ISNULL(gcr.Descrs,'') AS Descrs, " + ;
8498:                            "       ISNULL(c.ordems,0) AS Ordems, " + ;
8499:                            "       ISNULL(c.qtscons,0) AS Conss, " + ;
8500:                            "       ISNULL(c.cats,'') AS Ccats, " + ;
8501:                            "       ISNULL(cat.Descs,'') AS DCats " + ;
8502:                            "FROM SigPrCpo c " + ;
8503:                            "LEFT JOIN SigCdGcr gcr ON gcr.Codigos = c.grupos " + ;
8504:                            "LEFT JOIN SigCdCat cat ON LTRIM(RTRIM(cat.Cods)) = LTRIM(RTRIM(c.cats)) " + ;
8505:                            "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8506:                            " ORDER BY c.ordems, c.mats"
8507:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConsPTemp")
8508:                 IF loc_nRet > 0
8509:                     SELECT cursor_4c_ConsP
8510:                     ZAP
8511:                     APPEND FROM DBF("cursor_4c_ConsPTemp")
8512:                     IF USED("cursor_4c_ConsPTemp")
8513:                         USE IN cursor_4c_ConsPTemp
8514:                     ENDIF
8515:                     SELECT cursor_4c_ConsP
8516:                     GO TOP
8517: 
8518:                     loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8519:                     loc_oPgConsP.txt_4c_Qtcpnt.Value = LTRIM(STR(RECCOUNT("cursor_4c_ConsP")))
8520:                     loc_oPgConsP.grd_4c_GrdCons.Refresh()
8521:                 ENDIF
8522: 
8523:                 *-- Carregar DTemp (consumo agrupado por fase/grupo)
8524:                 IF USED("cursor_4c_DTempLoad")
8525:                     USE IN cursor_4c_DTempLoad
8526:                 ENDIF
8527:                 loc_cSQL = "SELECT ISNULL(c.grupos,'') AS Grupos, " + ;
8528:                            "       ISNULL(SUM(c.qtscons),0) AS TempoP " + ;
8529:                            "FROM SigPrCpo c " + ;
8530:                            "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8531:                            "  AND c.grupos IS NOT NULL AND LTRIM(RTRIM(c.grupos)) <> '' " + ;
8532:                            "GROUP BY c.grupos ORDER BY c.grupos"
8533:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DTempLoad")
8534:                 IF loc_nRet > 0
8535:                     SELECT cursor_4c_DTemp
8536:                     ZAP
8537:                     APPEND FROM DBF("cursor_4c_DTempLoad")
8538:                     IF USED("cursor_4c_DTempLoad")
8539:                         USE IN cursor_4c_DTempLoad
8540:                     ENDIF
8541:                     SELECT cursor_4c_DTemp
8542:                     GO TOP
8543:                     IF VARTYPE(loc_oPgConsP) = "O"
8544:                         loc_oPgConsP.grd_4c_GrDTEMP.Refresh()
8545:                     ENDIF
8546:                 ENDIF
8547:             ENDIF
8548: 
8549:         CATCH TO loc_oErro
8550:             MsgErro(loc_oErro.Message, "Erro ao carregar ConsP")
8551:         ENDTRY
8552:     ENDPROC
8553: 
8554:     *==========================================================================
8555:     * GrdConsCol4KeyPress - F4 em Column4 (Fase) abre lookup SigCdPrf
8556:     *==========================================================================

*-- Linhas 8717 a 8746:
8717:             IF USED("cursor_4c_PrfFase")
8718:                 USE IN cursor_4c_PrfFase
8719:             ENDIF
8720:             CREATE CURSOR cursor_4c_PrfFase (;
8721:                 CIdChaves C(20)  NULL, ;
8722:                 Ordems    N(2,0) NULL, ;
8723:                 Grupos    C(10)  NULL, ;
8724:                 Descrs    C(50)  NULL, ;
8725:                 UniPrdts  C(10)  NULL, ;
8726:                 MatPrdts  C(15)  NULL  ;
8727:             )
8728:             IF USED("cursor_4c_Mtz")
8729:                 USE IN cursor_4c_Mtz
8730:             ENDIF
8731:             CREATE CURSOR cursor_4c_Mtz (;
8732:                 CIdChaves C(20)  NULL, ;
8733:                 CMats     C(14)  NULL, ;
8734:                 DPros     C(65)  NULL, ;
8735:                 Locals    C(10)  NULL, ;
8736:                 Qtds      N(3,0) NULL  ;
8737:             )
8738:             SET NULL OFF
8739: 
8740:             *-- === Shape fundo imagem fase (shpFig, top=152+29=181, left=231, w=244, h=148) ===
8741:             par_oPage.AddObject("shp_4c_ShpFig", "Shape")
8742:             WITH par_oPage.shp_4c_ShpFig
8743:                 .Top    = 181
8744:                 .Left   = 231
8745:                 .Width  = 244
8746:                 .Height = 148

*-- Linhas 9102 a 9151:
9102:             loc_oGrd.FontName    = "Tahoma"
9103:             loc_oGrd.FontSize    = 8
9104:             loc_oGrd.GridLines   = 3
9105:             loc_oGrd.DeleteMark  = .F.
9106:             loc_oGrd.RecordMark  = .F.
9107:             loc_oGrd.RowHeight   = 16
9108:             loc_oGrd.ScrollBars  = 3
9109:             loc_oGrd.Themes      = .F.
9110:             loc_oGrd.Visible     = .T.
9111: 
9112:             loc_oGrd.RecordSource = "cursor_4c_PrfFase"
9113: 
9114:             loc_oGrd.Column1.Header1.Caption  = "Ordem"
9115:             loc_oGrd.Column1.ControlSource    = "cursor_4c_PrfFase.Ordems"
9116:             loc_oGrd.Column1.Width            = 40
9117:             loc_oGrd.Column1.Header1.FontBold = .T.
9118: 
9119:             loc_oGrd.Column2.Header1.Caption  = "Fase"
9120:             loc_oGrd.Column2.ControlSource    = "cursor_4c_PrfFase.Grupos"
9121:             loc_oGrd.Column2.Width            = 70
9122:             loc_oGrd.Column2.Header1.FontBold = .T.
9123: 
9124:             loc_oGrd.Column3.Header1.Caption  = "Utiliza" + CHR(231) + CHR(227) + "o"
9125:             loc_oGrd.Column3.ControlSource    = "cursor_4c_PrfFase.Descrs"
9126:             loc_oGrd.Column3.Width            = 160
9127:             loc_oGrd.Column3.ReadOnly         = .T.
9128:             loc_oGrd.Column3.Header1.FontBold = .T.
9129: 
9130:             loc_oGrd.Column4.Header1.Caption  = "Uni. Produtiva"
9131:             loc_oGrd.Column4.ControlSource    = "cursor_4c_PrfFase.UniPrdts"
9132:             loc_oGrd.Column4.Width            = 75
9133:             loc_oGrd.Column4.Header1.FontBold = .T.
9134: 
9135:             loc_oGrd.Column5.Header1.Caption  = "Material"
9136:             loc_oGrd.Column5.ControlSource    = "cursor_4c_PrfFase.MatPrdts"
9137:             loc_oGrd.Column5.Width            = 75
9138:             loc_oGrd.Column5.Header1.FontBold = .T.
9139: 
9140:             *-- BINDEVENTs para GradFase
9141:             BINDEVENT(loc_oGrd,             "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
9142:             BINDEVENT(loc_oGrd.Column1.Text1, "GotFocus",         THIS, "GradFaseCol1GotFocus")
9143:             BINDEVENT(loc_oGrd.Column1.Text1, "LostFocus",        THIS, "GradFaseCol1LostFocus")
9144:             BINDEVENT(loc_oGrd.Column2.Text1, "KeyPress",         THIS, "GradFaseCol2KeyPress")
9145:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress",         THIS, "GradFaseCol4KeyPress")
9146:             BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress",         THIS, "GradFaseCol5KeyPress")
9147: 
9148:             *-- === Botao Incluir fase (inserir, top=152+29=181, left=950, w=40, h=40) ===
9149:             par_oPage.AddObject("cmd_4c_Incluir", "CommandButton")
9150:             WITH par_oPage.cmd_4c_Incluir
9151:                 .Top     = 181

*-- Linhas 9251 a 9296:
9251:             loc_oGrd2.FontName    = "Tahoma"
9252:             loc_oGrd2.FontSize    = 8
9253:             loc_oGrd2.GridLines   = 3
9254:             loc_oGrd2.DeleteMark  = .F.
9255:             loc_oGrd2.RecordMark  = .F.
9256:             loc_oGrd2.RowHeight   = 16
9257:             loc_oGrd2.ScrollBars  = 3
9258:             loc_oGrd2.Themes      = .F.
9259:             loc_oGrd2.Visible     = .T.
9260: 
9261:             loc_oGrd2.RecordSource = "cursor_4c_Mtz"
9262: 
9263:             loc_oGrd2.Column1.Header1.Caption  = "Matriz"
9264:             loc_oGrd2.Column1.ControlSource    = "cursor_4c_Mtz.CMats"
9265:             loc_oGrd2.Column1.Width            = 60
9266:             loc_oGrd2.Column1.Header1.FontBold = .T.
9267: 
9268:             loc_oGrd2.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
9269:             loc_oGrd2.Column2.ControlSource    = "cursor_4c_Mtz.DPros"
9270:             loc_oGrd2.Column2.Width            = 100
9271:             loc_oGrd2.Column2.ReadOnly         = .T.
9272:             loc_oGrd2.Column2.Header1.FontBold = .T.
9273: 
9274:             loc_oGrd2.Column3.Header1.Caption  = "Local"
9275:             loc_oGrd2.Column3.ControlSource    = "cursor_4c_Mtz.Locals"
9276:             loc_oGrd2.Column3.Width            = 50
9277:             loc_oGrd2.Column3.ReadOnly         = .T.
9278:             loc_oGrd2.Column3.Header1.FontBold = .T.
9279: 
9280:             loc_oGrd2.Column4.Header1.Caption  = "Qtde"
9281:             loc_oGrd2.Column4.ControlSource    = "cursor_4c_Mtz.Qtds"
9282:             loc_oGrd2.Column4.Width            = 36
9283:             loc_oGrd2.Column4.Header1.FontBold = .T.
9284: 
9285:             *-- BINDEVENTs para Matrizes
9286:             BINDEVENT(loc_oGrd2,              "AfterRowColChange", THIS, "MatrizesAfterRowColChange")
9287:             BINDEVENT(loc_oGrd2.Column1.Text1, "GotFocus",         THIS, "MatrizesCol1GotFocus")
9288:             BINDEVENT(loc_oGrd2.Column1.Text1, "KeyPress",         THIS, "MatrizesCol1KeyPress")
9289: 
9290:             *-- === Botao Inserir Matriz (btnInsereMtx, top=380+29=409, left=258, w=40, h=40) ===
9291:             par_oPage.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
9292:             WITH par_oPage.cmd_4c_BtnInsereMtx
9293:                 .Top     = 409
9294:                 .Left   = 258
9295:                 .Width   = 40
9296:                 .Height = 40

*-- Linhas 9421 a 9526:
9421:     ENDPROC
9422: 
9423:     *==========================================================================
9424:     * CarregarFaseP - SQLEXEC SigCdPrf -> cursor_4c_PrfFase
9425:     *==========================================================================
9426:     PROCEDURE CarregarFaseP()
9427:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgFaseP, loc_oErro, loc_lContinuar
9428:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9429:             RETURN
9430:         ENDIF
9431:         loc_lContinuar = .T.
9432:         TRY
9433:             loc_cCPros = ALLTRIM(this_cCodigo)
9434:             IF EMPTY(loc_cCPros)
9435:                 loc_lContinuar = .F.
9436:             ENDIF
9437:             IF loc_lContinuar
9438:                 IF USED("cursor_4c_PrfFaseTemp")
9439:                     USE IN cursor_4c_PrfFaseTemp
9440:                 ENDIF
9441:                 loc_cSQL = "SELECT prf.CIdChaves, prf.Ordems, prf.Grupos, " + ;
9442:                            "ISNULL(gcr.Descrs,'') AS Descrs, " + ;
9443:                            "ISNULL(prf.UniPrdts,'') AS UniPrdts, " + ;
9444:                            "ISNULL(prf.MatPrdts,'') AS MatPrdts " + ;
9445:                            "FROM SigCdPrf prf " + ;
9446:                            "LEFT JOIN SigCdGcr gcr ON gcr.Codigos = prf.Grupos " + ;
9447:                            "WHERE prf.Produtos = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
9448:                            " ORDER BY prf.Ordems"
9449:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PrfFaseTemp")
9450:                 IF loc_nRet > 0
9451:                     SELECT cursor_4c_PrfFase
9452:                     ZAP
9453:                     IF RECCOUNT("cursor_4c_PrfFaseTemp") > 0
9454:                         APPEND FROM DBF("cursor_4c_PrfFaseTemp")
9455:                     ENDIF
9456:                     IF USED("cursor_4c_PrfFaseTemp")
9457:                         USE IN cursor_4c_PrfFaseTemp
9458:                     ENDIF
9459:                     SELECT cursor_4c_PrfFase
9460:                     GO TOP
9461:                     loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9462:                     loc_oPgFaseP.grd_4c_GradFase.Refresh()
9463:                     *-- Carregar imagem da primeira linha
9464:                     THIS.GradFaseAfterRowColChange(0)
9465:                 ELSE
9466:                     IF USED("cursor_4c_PrfFaseTemp")
9467:                         USE IN cursor_4c_PrfFaseTemp
9468:                     ENDIF
9469:                 ENDIF
9470:             ENDIF
9471:         CATCH TO loc_oErro
9472:             MsgErro(loc_oErro.Message, "Erro ao carregar Fase P")
9473:         ENDTRY
9474:     ENDPROC
9475: 
9476:     *==========================================================================
9477:     * CarregarMatrizes - SQLEXEC sigprmtz -> cursor_4c_Mtz
9478:     *==========================================================================
9479:     PROCEDURE CarregarMatrizes()
9480:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgFaseP, loc_oErro, loc_lContinuar
9481:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9482:             RETURN
9483:         ENDIF
9484:         loc_lContinuar = .T.
9485:         TRY
9486:             loc_cCPros = ALLTRIM(this_cCodigo)
9487:             IF EMPTY(loc_cCPros)
9488:                 loc_lContinuar = .F.
9489:             ENDIF
9490:             IF loc_lContinuar
9491:                 IF USED("cursor_4c_MtzTemp")
9492:                     USE IN cursor_4c_MtzTemp
9493:                 ENDIF
9494:                 loc_cSQL = "SELECT mtz.CIdChaves, mtz.CMats, " + ;
9495:                            "ISNULL(pro.DPros,'') AS DPros, " + ;
9496:                            "ISNULL(pro.Locals,'') AS Locals, " + ;
9497:                            "ISNULL(mtz.Qtds,0) AS Qtds " + ;
9498:                            "FROM SigPrMtz mtz " + ;
9499:                            "LEFT JOIN SigCdPro pro ON pro.CPros = mtz.CMats " + ;
9500:                            "WHERE mtz.CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
9501:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MtzTemp")
9502:                 IF loc_nRet > 0
9503:                     SELECT cursor_4c_Mtz
9504:                     ZAP
9505:                     IF RECCOUNT("cursor_4c_MtzTemp") > 0
9506:                         APPEND FROM DBF("cursor_4c_MtzTemp")
9507:                     ENDIF
9508:                     IF USED("cursor_4c_MtzTemp")
9509:                         USE IN cursor_4c_MtzTemp
9510:                     ENDIF
9511:                     SELECT cursor_4c_Mtz
9512:                     GO TOP
9513:                     loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9514:                     loc_oPgFaseP.grd_4c_Matrizes.Refresh()
9515:                     *-- Carregar imagem da primeira matriz
9516:                     THIS.MatrizesAfterRowColChange(0)
9517:                 ELSE
9518:                     IF USED("cursor_4c_MtzTemp")
9519:                         USE IN cursor_4c_MtzTemp
9520:                     ENDIF
9521:                 ENDIF
9522:             ENDIF
9523:         CATCH TO loc_oErro
9524:             MsgErro(loc_oErro.Message, "Erro ao carregar Matrizes")
9525:         ENDTRY
9526:     ENDPROC

*-- Linhas 9542 a 9576:
9542:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase") OR BOF("cursor_4c_PrfFase")
9543:                 RETURN
9544:             ENDIF
9545:             SELECT cursor_4c_PrfFase
9546:             loc_cCIdChaves = ALLTRIM(CIdChaves)
9547:             *-- Preencher descricao da fase atual (ja carregada no cursor)
9548:             loc_oPgFaseP.txt_4c_Desc.Value = ALLTRIM(NVL(Descrs, ""))
9549:             IF EMPTY(loc_cCIdChaves)
9550:                 RETURN
9551:             ENDIF
9552:             *-- Carregar FigProcs e Obs do banco
9553:             IF USED("cursor_4c_FigPrfTmp")
9554:                 USE IN cursor_4c_FigPrfTmp
9555:             ENDIF
9556:             loc_nRet = SQLEXEC(gnConnHandle, ;
9557:                 "SELECT FigProcs, CONVERT(NVARCHAR(MAX), obs) AS ObsText " + ;
9558:                 "FROM SigCdPrf WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves), ;
9559:                 "cursor_4c_FigPrfTmp")
9560:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_FigPrfTmp") > 0
9561:                 SELECT cursor_4c_FigPrfTmp
9562:                 *-- Preencher obs
9563:                 IF !ISNULL(ObsText)
9564:                     loc_oPgFaseP.edt_4c_Get_Obs.Value = ALLTRIM(ObsText)
9565:                 ENDIF
9566:                 *-- Exibir imagem
9567:                 IF !EMPTY(FigProcs) AND !ISNULL(FigProcs)
9568:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9569:                     IF STRTOFILE(FigProcs, loc_cArquivo) > 0
9570:                         loc_oPgFaseP.img_4c_ImgFigJpg.Visible = .T.
9571:                         loc_oPgFaseP.img_4c_ImgFigJpg.Picture = loc_cArquivo
9572:                     ENDIF
9573:                 ENDIF
9574:             ENDIF
9575:             IF USED("cursor_4c_FigPrfTmp")
9576:                 USE IN cursor_4c_FigPrfTmp

*-- Linhas 9587 a 9631:
9587:         LOCAL loc_oErro
9588:         TRY
9589:             IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
9590:                 SELECT cursor_4c_PrfFase
9591:                 this_nAntOrd = NVL(Ordems, 0)
9592:             ENDIF
9593:         CATCH TO loc_oErro
9594:             *-- Tolerado
9595:         ENDTRY
9596:     ENDPROC
9597: 
9598:     *==========================================================================
9599:     * GradFaseCol1LostFocus - Aplica reordenacao se Ordems mudou
9600:     *==========================================================================
9601:     PROCEDURE GradFaseCol1LostFocus()
9602:         LOCAL loc_nNovoOrd, loc_cCIdChaves, loc_nRet, loc_oErro
9603:         TRY
9604:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9605:                 RETURN
9606:             ENDIF
9607:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
9608:                 RETURN
9609:             ENDIF
9610:             SELECT cursor_4c_PrfFase
9611:             loc_nNovoOrd   = NVL(Ordems, 0)
9612:             loc_cCIdChaves = ALLTRIM(CIdChaves)
9613:             IF loc_nNovoOrd > 0 AND loc_nNovoOrd <> this_nAntOrd AND !EMPTY(loc_cCIdChaves)
9614:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9615:                     "UPDATE SigCdPrf SET Ordems = " + FormatarNumeroSQL(loc_nNovoOrd) + ;
9616:                     " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9617:                 THIS.CarregarFaseP()
9618:             ENDIF
9619:         CATCH TO loc_oErro
9620:             MsgErro(loc_oErro.Message, "Erro ao reordenar fase")
9621:         ENDTRY
9622:     ENDPROC
9623: 
9624:     *==========================================================================
9625:     * GradFaseCol2KeyPress - F4 abre lookup de Fase (SigCdGcr)
9626:     *==========================================================================
9627:     PROCEDURE GradFaseCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9628:         LOCAL loc_oErro
9629:         TRY
9630:             IF par_nKeyCode = 115
9631:                 THIS.AbrirLookupGradFaseFase()

*-- Linhas 9684 a 9722:
9684:             IF loc_lContinuar AND gnConnHandle > 0
9685:                 *-- Calcular proximo Ordems
9686:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
9687:                     SELECT cursor_4c_PrfFase
9688:                     loc_cGrupos = ALLTRIM(Grupos)
9689:                     GO BOTTOM
9690:                     loc_nOrdems = NVL(Ordems, 0) + 1
9691:                     GO TOP
9692:                 ELSE
9693:                     loc_cGrupos = ""
9694:                     loc_nOrdems = 1
9695:                 ENDIF
9696:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9697:                     "INSERT INTO SigCdPrf (Produtos, Ordems, Grupos, CIdChaves) VALUES (" + ;
9698:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", " + ;
9699:                     FormatarNumeroSQL(loc_nOrdems) + ", " + ;
9700:                     EscaparSQL(PADR(loc_cGrupos, 10)) + ", NEWID())")
9701:                 IF loc_nRet < 1
9702:                     MsgErro("Erro ao incluir linha de fase.", "Erro")
9703:                 ELSE
9704:                     THIS.CarregarFaseP()
9705:                     *-- Posicionar na nova linha (ultima)
9706:                     IF USED("cursor_4c_PrfFase")
9707:                         SELECT cursor_4c_PrfFase
9708:                         GO BOTTOM
9709:                     ENDIF
9710:                 ENDIF
9711:             ENDIF
9712:         CATCH TO loc_oErro
9713:             MsgErro(loc_oErro.Message, "Erro ao incluir fase")
9714:         ENDTRY
9715:     ENDPROC
9716: 
9717:     *==========================================================================
9718:     * FasePExcluirClick - Exclui linha atual de GradFase (SigCdPrf)
9719:     *==========================================================================
9720:     PROCEDURE FasePExcluirClick()
9721:         LOCAL loc_nRet, loc_cCIdChaves, loc_lConfirmou, loc_oErro, loc_lContinuar
9722:         loc_lContinuar = .T.

*-- Linhas 9731 a 9759:
9731:                 ENDIF
9732:             ENDIF
9733:             IF loc_lContinuar
9734:                 SELECT cursor_4c_PrfFase
9735:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
9736:                 IF EMPTY(loc_cCIdChaves)
9737:                     loc_lContinuar = .F.
9738:                 ENDIF
9739:             ENDIF
9740:             IF loc_lContinuar
9741:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta fase?", "Confirmar")
9742:                 IF loc_lConfirmou AND gnConnHandle > 0
9743:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9744:                         "DELETE FROM SigCdPrf WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9745:                     THIS.CarregarFaseP()
9746:                 ENDIF
9747:             ENDIF
9748:         CATCH TO loc_oErro
9749:             MsgErro(loc_oErro.Message, "Erro ao excluir fase")
9750:         ENDTRY
9751:     ENDPROC
9752: 
9753:     *==========================================================================
9754:     * FasePAlternativaClick - Insere fase alternativa (copia grupos da atual)
9755:     *==========================================================================
9756:     PROCEDURE FasePAlternativaClick()
9757:         LOCAL loc_nRet, loc_cCPros, loc_cGrupos, loc_nOrdems, loc_oErro, loc_lContinuar
9758:         loc_lContinuar = .T.
9759:         TRY

*-- Linhas 9774 a 9809:
9774:                 ENDIF
9775:             ENDIF
9776:             IF loc_lContinuar AND gnConnHandle > 0
9777:                 SELECT cursor_4c_PrfFase
9778:                 loc_cGrupos = ALLTRIM(Grupos)
9779:                 loc_nOrdems = NVL(Ordems, 0)
9780:                 *-- Inserir alternativa logo apos a atual (Ordems atual + 0.5 => usa Ordems+1 e reordena depois)
9781:                 GO BOTTOM
9782:                 loc_nOrdems = NVL(Ordems, 0) + 1
9783:                 GO TOP
9784:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9785:                     "INSERT INTO SigCdPrf (Produtos, Ordems, Grupos, CIdChaves) VALUES (" + ;
9786:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", " + ;
9787:                     FormatarNumeroSQL(loc_nOrdems) + ", " + ;
9788:                     EscaparSQL(PADR(loc_cGrupos, 10)) + ", NEWID())")
9789:                 IF loc_nRet < 1
9790:                     MsgErro("Erro ao incluir alternativa de fase.", "Erro")
9791:                 ELSE
9792:                     THIS.CarregarFaseP()
9793:                     IF USED("cursor_4c_PrfFase")
9794:                         SELECT cursor_4c_PrfFase
9795:                         GO BOTTOM
9796:                     ENDIF
9797:                 ENDIF
9798:             ENDIF
9799:         CATCH TO loc_oErro
9800:             MsgErro(loc_oErro.Message, "Erro ao incluir alternativa de fase")
9801:         ENDTRY
9802:     ENDPROC
9803: 
9804:     *==========================================================================
9805:     * FasePCmdFichaClick - Ficha tecnica da fase (relatorio legado)
9806:     *==========================================================================
9807:     PROCEDURE FasePCmdFichaClick()
9808:         LOCAL loc_oErro
9809:         TRY

*-- Linhas 9846 a 9877:
9846:                 ENDIF
9847:             ENDIF
9848:             IF loc_lContinuar
9849:                 SELECT cursor_4c_PrfFase
9850:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
9851:                 IF EMPTY(loc_cCIdChaves)
9852:                     loc_lContinuar = .F.
9853:                 ENDIF
9854:             ENDIF
9855:             IF loc_lContinuar AND gnConnHandle > 0
9856:                 loc_cArquivo = GETPICT("Formato Jpeg:JPG;Formato Bitmap:BMP", "Selecionar imagem")
9857:                 IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
9858:                     loc_cDados = FILETOSTR(loc_cArquivo)
9859:                     IF !EMPTY(loc_cDados)
9860:                         loc_nRet = SQLEXEC(gnConnHandle, ;
9861:                             "UPDATE SigCdPrf SET FigProcs = " + EscaparSQL(loc_cDados) + ;
9862:                             " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
9863:                         IF loc_nRet > 0
9864:                             *-- Exibir imagem
9865:                             loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9866:                             loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
9867:                             IF STRTOFILE(loc_cDados, loc_cArqTemp) > 0
9868:                                 loc_oPgFaseP.img_4c_ImgFigJpg.Visible = .T.
9869:                                 loc_oPgFaseP.img_4c_ImgFigJpg.Picture = loc_cArqTemp
9870:                             ENDIF
9871:                         ENDIF
9872:                     ENDIF
9873:                 ENDIF
9874:             ENDIF
9875:         CATCH TO loc_oErro
9876:             MsgErro(loc_oErro.Message, "Erro ao carregar imagem da fase")
9877:         ENDTRY

*-- Linhas 9904 a 9935:
9904:             IF !USED("cursor_4c_Mtz") OR EOF("cursor_4c_Mtz") OR BOF("cursor_4c_Mtz")
9905:                 RETURN
9906:             ENDIF
9907:             SELECT cursor_4c_Mtz
9908:             loc_cCMats = ALLTRIM(CMats)
9909:             IF EMPTY(loc_cCMats)
9910:                 RETURN
9911:             ENDIF
9912:             *-- Buscar imagem do produto matriz
9913:             IF USED("cursor_4c_MtzImgTmp")
9914:                 USE IN cursor_4c_MtzImgTmp
9915:             ENDIF
9916:             loc_nRet = SQLEXEC(gnConnHandle, ;
9917:                 "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(PADR(loc_cCMats, 14)), ;
9918:                 "cursor_4c_MtzImgTmp")
9919:             IF loc_nRet > 0 AND RECCOUNT("cursor_4c_MtzImgTmp") > 0
9920:                 SELECT cursor_4c_MtzImgTmp
9921:                 IF !EMPTY(FigJpgs) AND !ISNULL(FigJpgs)
9922:                     loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
9923:                     IF STRTOFILE(FigJpgs, loc_cArquivo) > 0
9924:                         loc_oPgFaseP.img_4c_ImgBorracha.Visible = .T.
9925:                         loc_oPgFaseP.img_4c_ImgBorracha.Picture = loc_cArquivo
9926:                     ENDIF
9927:                 ENDIF
9928:             ENDIF
9929:             IF USED("cursor_4c_MtzImgTmp")
9930:                 USE IN cursor_4c_MtzImgTmp
9931:             ENDIF
9932:         CATCH TO loc_oErro
9933:             *-- Tolerado: exibicao de imagem nao critica
9934:         ENDTRY
9935:     ENDPROC

*-- Linhas 9982 a 10008:
9982:                 ENDIF
9983:             ENDIF
9984:             IF loc_lContinuar AND gnConnHandle > 0
9985:                 loc_nRet = SQLEXEC(gnConnHandle, ;
9986:                     "INSERT INTO SigPrMtz (CPros, CMats, Qtds, CIdChaves) VALUES (" + ;
9987:                     EscaparSQL(PADR(loc_cCPros, 14)) + ", '', 0, NEWID())")
9988:                 IF loc_nRet < 1
9989:                     MsgErro("Erro ao incluir linha de matriz.", "Erro")
9990:                 ELSE
9991:                     THIS.CarregarMatrizes()
9992:                     IF USED("cursor_4c_Mtz")
9993:                         SELECT cursor_4c_Mtz
9994:                         GO BOTTOM
9995:                     ENDIF
9996:                 ENDIF
9997:             ENDIF
9998:         CATCH TO loc_oErro
9999:             MsgErro(loc_oErro.Message, "Erro ao incluir matriz")
10000:         ENDTRY
10001:     ENDPROC
10002: 
10003:     *==========================================================================
10004:     * FasePBtnExcluiMtzClick - Exclui linha atual de grdMatrizes (SigPrMtz)
10005:     *==========================================================================
10006:     PROCEDURE FasePBtnExcluiMtzClick()
10007:         LOCAL loc_nRet, loc_cCIdChaves, loc_lConfirmou, loc_oErro, loc_lContinuar
10008:         loc_lContinuar = .T.

*-- Linhas 10017 a 10045:
10017:                 ENDIF
10018:             ENDIF
10019:             IF loc_lContinuar
10020:                 SELECT cursor_4c_Mtz
10021:                 loc_cCIdChaves = ALLTRIM(CIdChaves)
10022:                 IF EMPTY(loc_cCIdChaves)
10023:                     loc_lContinuar = .F.
10024:                 ENDIF
10025:             ENDIF
10026:             IF loc_lContinuar
10027:                 loc_lConfirmou = MsgConfirma("Deseja excluir esta matriz?", "Confirmar")
10028:                 IF loc_lConfirmou AND gnConnHandle > 0
10029:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10030:                         "DELETE FROM SigPrMtz WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10031:                     THIS.CarregarMatrizes()
10032:                 ENDIF
10033:             ENDIF
10034:         CATCH TO loc_oErro
10035:             MsgErro(loc_oErro.Message, "Erro ao excluir matriz")
10036:         ENDTRY
10037:     ENDPROC
10038: 
10039:     *==========================================================================
10040:     * FasePCodAcbKeyPress - F4 abre lookup de Acabamento (SigCdAca)
10041:     *==========================================================================
10042:     PROCEDURE FasePCodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
10043:         LOCAL loc_oErro
10044:         TRY
10045:             IF par_nKeyCode = 115

*-- Linhas 10125 a 10145:
10125:                     REPLACE cursor_4c_PrfFase.Descrs WITH PADR(loc_cDescrs,  50)
10126:                 ENDIF
10127:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10128:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10129:                         "UPDATE SigCdPrf SET Grupos = " + EscaparSQL(PADR(loc_cCodigos, 10)) + ;
10130:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10131:                 ENDIF
10132:                 loc_oGrd.Column2.Text1.Value = loc_cCodigos
10133:                 loc_oGrd.Column3.Text1.Value = loc_cDescrs
10134:                 loc_oGrd.Refresh()
10135:             ENDIF
10136:             IF USED("cursor_4c_BuscaGcr")
10137:                 USE IN cursor_4c_BuscaGcr
10138:             ENDIF
10139:             loc_oBusca.Release()
10140:         CATCH TO loc_oErro
10141:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de fase")
10142:         ENDTRY
10143:     ENDPROC
10144: 
10145:     *==========================================================================

*-- Linhas 10166 a 10195:
10166:             *-- Filtrar por Codigos = Grupos atual (conforme legado)
10167:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUpd", ;
10168:                 "cursor_4c_BuscaUpd", "UniPrdts", loc_cUniPrdts, "Unidade Produtiva", ;
10169:                 .F., .F., "Codigos = " + EscaparSQL(PADR(loc_cGruposUpd, 10)))
10170:             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
10171:             loc_oBusca.Show()
10172:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd")
10173:                 loc_cUniPrdts = ALLTRIM(cursor_4c_BuscaUpd.UniPrdts)
10174:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
10175:                     REPLACE cursor_4c_PrfFase.UniPrdts WITH PADR(loc_cUniPrdts, 10)
10176:                 ENDIF
10177:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10178:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10179:                         "UPDATE SigCdPrf SET UniPrdts = " + EscaparSQL(PADR(loc_cUniPrdts, 10)) + ;
10180:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10181:                 ENDIF
10182:                 loc_oGrd.Column4.Text1.Value = loc_cUniPrdts
10183:                 loc_oGrd.Refresh()
10184:             ENDIF
10185:             IF USED("cursor_4c_BuscaUpd")
10186:                 USE IN cursor_4c_BuscaUpd
10187:             ENDIF
10188:             loc_oBusca.Release()
10189:         CATCH TO loc_oErro
10190:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de unidade produtiva")
10191:         ENDTRY
10192:     ENDPROC
10193: 
10194:     *==========================================================================
10195:     * AbrirLookupGradFaseOpt - Lookup SigOpOpt para Column5 (MatPrdts)

*-- Linhas 10221 a 10241:
10221:                     REPLACE cursor_4c_PrfFase.MatPrdts WITH PADR(loc_cMatPrdts, 15)
10222:                 ENDIF
10223:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10224:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10225:                         "UPDATE SigCdPrf SET MatPrdts = " + EscaparSQL(PADR(loc_cMatPrdts, 15)) + ;
10226:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10227:                 ENDIF
10228:                 loc_oGrd.Column5.Text1.Value = loc_cMatPrdts
10229:                 loc_oGrd.Refresh()
10230:             ENDIF
10231:             IF USED("cursor_4c_BuscaOpt")
10232:                 USE IN cursor_4c_BuscaOpt
10233:             ENDIF
10234:             loc_oBusca.Release()
10235:         CATCH TO loc_oErro
10236:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de material")
10237:         ENDTRY
10238:     ENDPROC
10239: 
10240:     *==========================================================================
10241:     * AbrirLookupMatrizesCol1 - Lookup SigCdPro para Column1 de grdMatrizes

*-- Linhas 10273 a 10293:
10273:                     REPLACE cursor_4c_Mtz.Locals WITH PADR(loc_cLocals, 10)
10274:                 ENDIF
10275:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10276:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10277:                         "UPDATE SigPrMtz SET CMats = " + EscaparSQL(PADR(loc_cCMats, 14)) + ;
10278:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10279:                 ENDIF
10280:                 loc_oGrd2.Column1.Text1.Value = loc_cCMats
10281:                 loc_oGrd2.Column2.Text1.Value = loc_cDPros
10282:                 loc_oGrd2.Column3.Text1.Value = loc_cLocals
10283:                 loc_oGrd2.Refresh()
10284:                 THIS.MatrizesAfterRowColChange(0)
10285:             ENDIF
10286:             IF USED("cursor_4c_BuscaMtz")
10287:                 USE IN cursor_4c_BuscaMtz
10288:             ENDIF
10289:             loc_oBusca.Release()
10290:         CATCH TO loc_oErro
10291:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de matriz")
10292:         ENDTRY
10293:     ENDPROC

*-- Linhas 10430 a 10448:
10430:             IF USED("cursor_4c_Cmv")
10431:                 USE IN cursor_4c_Cmv
10432:             ENDIF
10433:             CREATE CURSOR cursor_4c_Cmv (;
10434:                 Periodo C(7)    NULL, ;
10435:                 ValGR   N(15,6) NULL, ;
10436:                 Moe     C(3)    NULL  ;
10437:             )
10438:             SET NULL OFF
10439: 
10440:             *-- === Say16: "Grupo C.C. :" - top=165+29=194, left=138, w=63, h=15 ===
10441:             par_oPage.AddObject("lbl_4c_Label16", "Label")
10442:             WITH par_oPage.lbl_4c_Label16
10443:                 .Top       = 194
10444:                 .Left      = 138
10445:                 .Width     = 63
10446:                 .Height    = 15
10447:                 .FontName  = "Tahoma"
10448:                 .FontSize  = 8

*-- Linhas 10478 a 10496:
10478:                 .FontSize       = 8
10479:                 .SpecialEffect  = 1
10480:                 .Themes         = .F.
10481:                 .ControlSource  = "crSigCdPro.gruccus"
10482:                 .Visible        = .T.
10483:             ENDWITH
10484: 
10485:             *-- === get_dgruccus: top=161+29=190, left=288, w=318, h=23 ===
10486:             par_oPage.AddObject("txt_4c__dgruccus", "TextBox")
10487:             WITH par_oPage.txt_4c__dgruccus
10488:                 .Top            = 190
10489:                 .Left           = 288
10490:                 .Width          = 318
10491:                 .Height         = 23
10492:                 .FontName       = "Tahoma"
10493:                 .FontSize       = 8
10494:                 .SpecialEffect  = 1
10495:                 .Themes         = .F.
10496:                 .Visible        = .T.

*-- Linhas 10507 a 10525:
10507:                 .FontSize       = 8
10508:                 .SpecialEffect  = 1
10509:                 .Themes         = .F.
10510:                 .ControlSource  = "crSigCdPro.contaccus"
10511:                 .Visible        = .T.
10512:             ENDWITH
10513: 
10514:             *-- === get_dcontaccus: top=186+29=215, left=288, w=318, h=23 ===
10515:             par_oPage.AddObject("txt_4c__dcontaccus", "TextBox")
10516:             WITH par_oPage.txt_4c__dcontaccus
10517:                 .Top            = 215
10518:                 .Left           = 288
10519:                 .Width          = 318
10520:                 .Height         = 23
10521:                 .FontName       = "Tahoma"
10522:                 .FontSize       = 8
10523:                 .SpecialEffect  = 1
10524:                 .Themes         = .F.
10525:                 .Visible        = .T.

*-- Linhas 10553 a 10571:
10553:                 .InputMask      = "9999.99.9999"
10554:                 .MaxLength      = 12
10555:                 .Themes         = .F.
10556:                 .ControlSource  = "crSigCdPro.clfiscals"
10557:                 .Visible        = .T.
10558:             ENDWITH
10559: 
10560:             *-- === getDclfiscal: top=211+29=240, left=303, w=303, h=23 ===
10561:             par_oPage.AddObject("txt_4c_Dclfiscal", "TextBox")
10562:             WITH par_oPage.txt_4c_Dclfiscal
10563:                 .Top            = 240
10564:                 .Left           = 303
10565:                 .Width          = 303
10566:                 .Height         = 23
10567:                 .FontName       = "Tahoma"
10568:                 .FontSize       = 8
10569:                 .SpecialEffect  = 1
10570:                 .Format         = "!"
10571:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

*-- Linhas 10600 a 10618:
10600:                 .SpecialEffect  = 1
10601:                 .MaxLength      = 1
10602:                 .Themes         = .F.
10603:                 .ControlSource  = "crSigCdPro.origmercs"
10604:                 .Visible        = .T.
10605:             ENDWITH
10606: 
10607:             *-- === getDorigmerc: top=236+29=265, left=226, w=380, h=23 ===
10608:             par_oPage.AddObject("txt_4c_Dorigmerc", "TextBox")
10609:             WITH par_oPage.txt_4c_Dorigmerc
10610:                 .Top            = 265
10611:                 .Left           = 226
10612:                 .Width          = 380
10613:                 .Height         = 23
10614:                 .FontName       = "Tahoma"
10615:                 .FontSize       = 8
10616:                 .SpecialEffect  = 1
10617:                 .Format         = "!"
10618:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

*-- Linhas 10647 a 10665:
10647:                 .SpecialEffect  = 1
10648:                 .MaxLength      = 3
10649:                 .Themes         = .F.
10650:                 .ControlSource  = "crSigCdPro.sittricms"
10651:                 .Visible        = .T.
10652:             ENDWITH
10653: 
10654:             *-- === getDsittricm: top=261+29=290, left=240, w=366, h=23 ===
10655:             par_oPage.AddObject("txt_4c_Dsittricm", "TextBox")
10656:             WITH par_oPage.txt_4c_Dsittricm
10657:                 .Top            = 290
10658:                 .Left           = 240
10659:                 .Width          = 366
10660:                 .Height         = 23
10661:                 .FontName       = "Tahoma"
10662:                 .FontSize       = 8
10663:                 .SpecialEffect  = 1
10664:                 .Format         = "!"
10665:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

*-- Linhas 10695 a 10713:
10695:                 .InputMask      = "9999"
10696:                 .MaxLength      = 4
10697:                 .Themes         = .F.
10698:                 .ControlSource  = "crSigCdPro.CodServs"
10699:                 .Visible        = .T.
10700:             ENDWITH
10701: 
10702:             *-- === Say8: "Aliquota ICMS :" - top=291+29=320, left=250, w=76, h=15 ===
10703:             par_oPage.AddObject("lbl_4c_Label8", "Label")
10704:             WITH par_oPage.lbl_4c_Label8
10705:                 .Top       = 320
10706:                 .Left      = 250
10707:                 .Width     = 76
10708:                 .Height    = 15
10709:                 .FontName  = "Tahoma"
10710:                 .FontSize  = 8
10711:                 .BackStyle = 0
10712:                 .Caption   = "Al" + CHR(237) + "quota ICMS :"
10713:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10727 a 10745:
10727:                 .InputMask      = "99.99"
10728:                 .MaxLength      = 5
10729:                 .Themes         = .F.
10730:                 .ControlSource  = "crSigCdPro.icms"
10731:                 .Visible        = .T.
10732:             ENDWITH
10733: 
10734:             *-- === Say4: "Tipo de Tributacao :" - top=291+29=320, left=395, w=98 ===
10735:             par_oPage.AddObject("lbl_4c_Label4", "Label")
10736:             WITH par_oPage.lbl_4c_Label4
10737:                 .Top       = 320
10738:                 .Left      = 395
10739:                 .Width     = 98
10740:                 .FontName  = "Tahoma"
10741:                 .FontSize  = 8
10742:                 .BackStyle = 0
10743:                 .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
10744:                 .ForeColor = RGB(90,90,90)
10745:                 .Visible   = .T.

*-- Linhas 10757 a 10775:
10757:                 .SpecialEffect  = 1
10758:                 .MaxLength      = 4
10759:                 .Themes         = .F.
10760:                 .ControlSource  = "crSigCdPro.tptribs"
10761:                 .Visible        = .T.
10762:             ENDWITH
10763: 
10764:             *-- === Say41: "IAT :" - top=290+29=319, left=558, w=26, h=15 ===
10765:             par_oPage.AddObject("lbl_4c_Label41", "Label")
10766:             WITH par_oPage.lbl_4c_Label41
10767:                 .Top       = 319
10768:                 .Left      = 558
10769:                 .Width     = 26
10770:                 .Height    = 15
10771:                 .FontName  = "Tahoma"
10772:                 .FontSize  = 8
10773:                 .BackStyle = 0
10774:                 .Caption   = "IAT :"
10775:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10788 a 10806:
10788:                 .SpecialEffect  = 1
10789:                 .MaxLength      = 1
10790:                 .Themes         = .F.
10791:                 .ControlSource  = "crSigCdPro.iats"
10792:                 .Visible        = .T.
10793:             ENDWITH
10794: 
10795:             *-- === Say42: "[A]rredondamento [T]runcamento" - top=290+29=319, left=609, w=165, h=15 ===
10796:             par_oPage.AddObject("lbl_4c_Label42", "Label")
10797:             WITH par_oPage.lbl_4c_Label42
10798:                 .Top       = 319
10799:                 .Left      = 609
10800:                 .Width     = 165
10801:                 .Height    = 15
10802:                 .FontName  = "Tahoma"
10803:                 .FontSize  = 8
10804:                 .BackStyle = 0
10805:                 .Caption   = "[A]rredondamento [T]runcamento"
10806:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10865 a 10883:
10865:                 .InputMask      = "99.99"
10866:                 .MaxLength      = 5
10867:                 .Themes         = .F.
10868:                 .ControlSource  = "crSigCdPro.AliqIpis"
10869:                 .Visible        = .T.
10870:             ENDWITH
10871: 
10872:             *-- === Say13: "Excecao da TIPI :" - top=316+29=345, left=495, w=87, h=15 ===
10873:             par_oPage.AddObject("lbl_4c_Label13", "Label")
10874:             WITH par_oPage.lbl_4c_Label13
10875:                 .Top       = 345
10876:                 .Left      = 495
10877:                 .Width     = 87
10878:                 .Height    = 15
10879:                 .FontName  = "Tahoma"
10880:                 .FontSize  = 8
10881:                 .BackStyle = 0
10882:                 .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
10883:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10897 a 10915:
10897:                 .MaxLength      = 3
10898:                 .Format         = "K"
10899:                 .Themes         = .F.
10900:                 .ControlSource  = "crSigCdPro.extipi"
10901:                 .Visible        = .T.
10902:             ENDWITH
10903: 
10904:             *-- === Say18: "Descricao Fiscal :" - top=341+29=370, left=117, w=84, h=15 ===
10905:             par_oPage.AddObject("lbl_4c_Label18", "Label")
10906:             WITH par_oPage.lbl_4c_Label18
10907:                 .Top       = 370
10908:                 .Left      = 117
10909:                 .Width     = 84
10910:                 .Height    = 15
10911:                 .FontName  = "Tahoma"
10912:                 .FontSize  = 8
10913:                 .BackStyle = 0
10914:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
10915:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10939 a 10957:
10939:                 .FontSize       = 8
10940:                 .SpecialEffect  = 1
10941:                 .Themes         = .F.
10942:                 .ControlSource  = "crSigCdPro.descfis"
10943:                 .Visible        = .T.
10944:             ENDWITH
10945: 
10946:             *-- === Say9: "Valor do Grama Produzido" - top=320+29=349, left=756, w=125, h=15 ===
10947:             par_oPage.AddObject("lbl_4c_Label9", "Label")
10948:             WITH par_oPage.lbl_4c_Label9
10949:                 .Top       = 349
10950:                 .Left      = 756
10951:                 .Width     = 125
10952:                 .Height    = 15
10953:                 .FontName  = "Tahoma"
10954:                 .FontSize  = 8
10955:                 .BackStyle = 0
10956:                 .Caption   = "Valor do Grama Produzido"
10957:                 .ForeColor = RGB(90,90,90)

*-- Linhas 10968 a 11019:
10968:             par_oPage.grd_4c_Dados.FontName    = "Tahoma"
10969:             par_oPage.grd_4c_Dados.FontSize    = 8
10970:             par_oPage.grd_4c_Dados.ReadOnly    = .T.
10971:             par_oPage.grd_4c_Dados.DeleteMark  = .F.
10972:             par_oPage.grd_4c_Dados.RecordMark  = .F.
10973:             par_oPage.grd_4c_Dados.RowHeight   = 17
10974:             par_oPage.grd_4c_Dados.GridLines   = 3
10975:             par_oPage.grd_4c_Dados.ScrollBars  = 3
10976:             par_oPage.grd_4c_Dados.Themes      = .F.
10977:             par_oPage.grd_4c_Dados.Visible     = .T.
10978: 
10979:             par_oPage.grd_4c_Dados.RecordSource = "cursor_4c_Cmv"
10980: 
10981:             par_oPage.grd_4c_Dados.Column1.Header1.Caption  = "Per" + CHR(237) + "odo"
10982:             par_oPage.grd_4c_Dados.Column1.ControlSource    = "cursor_4c_Cmv.Periodo"
10983:             par_oPage.grd_4c_Dados.Column1.Width            = 59
10984:             par_oPage.grd_4c_Dados.Column1.ReadOnly         = .T.
10985:             par_oPage.grd_4c_Dados.Column1.Movable          = .F.
10986:             par_oPage.grd_4c_Dados.Column1.Resizable        = .F.
10987:             par_oPage.grd_4c_Dados.Column1.FontName         = "Tahoma"
10988:             par_oPage.grd_4c_Dados.Column1.FontSize         = 8
10989:             par_oPage.grd_4c_Dados.Column1.Header1.FontBold = .T.
10990:             par_oPage.grd_4c_Dados.Column1.Header1.Alignment = 2
10991: 
10992:             par_oPage.grd_4c_Dados.Column2.Header1.Caption  = "Valor Custo GR"
10993:             par_oPage.grd_4c_Dados.Column2.ControlSource    = "cursor_4c_Cmv.ValGR"
10994:             par_oPage.grd_4c_Dados.Column2.Width            = 100
10995:             par_oPage.grd_4c_Dados.Column2.ReadOnly         = .T.
10996:             par_oPage.grd_4c_Dados.Column2.Movable          = .F.
10997:             par_oPage.grd_4c_Dados.Column2.Resizable        = .F.
10998:             par_oPage.grd_4c_Dados.Column2.FontName         = "Tahoma"
10999:             par_oPage.grd_4c_Dados.Column2.FontSize         = 8
11000:             par_oPage.grd_4c_Dados.Column2.Header1.FontBold = .T.
11001:             par_oPage.grd_4c_Dados.Column2.Header1.Alignment = 2
11002: 
11003:             par_oPage.grd_4c_Dados.Column3.Header1.Caption  = "Moe"
11004:             par_oPage.grd_4c_Dados.Column3.ControlSource    = "cursor_4c_Cmv.Moe"
11005:             par_oPage.grd_4c_Dados.Column3.Width            = 31
11006:             par_oPage.grd_4c_Dados.Column3.ReadOnly         = .T.
11007:             par_oPage.grd_4c_Dados.Column3.FontName         = "Tahoma"
11008:             par_oPage.grd_4c_Dados.Column3.Header1.FontBold = .T.
11009:             par_oPage.grd_4c_Dados.Column3.Header1.Alignment = 2
11010: 
11011:             *-- === Say12: "Descricao ECF :" - top=433+29=462, left=124, w=77, h=15 ===
11012:             par_oPage.AddObject("lbl_4c_Label12", "Label")
11013:             WITH par_oPage.lbl_4c_Label12
11014:                 .Top       = 462
11015:                 .Left      = 124
11016:                 .Width     = 77
11017:                 .Height    = 15
11018:                 .FontName  = "Tahoma"
11019:                 .FontSize  = 8

*-- Linhas 11035 a 11053:
11035:                 .SpecialEffect  = 1
11036:                 .MaxLength      = 29
11037:                 .Themes         = .F.
11038:                 .ControlSource  = "crSigCdPro.descecfs"
11039:                 .Visible        = .T.
11040:             ENDWITH
11041: 
11042:             *-- === Say11: "Metal :" - top=433+29=462, left=494, w=35 ===
11043:             par_oPage.AddObject("lbl_4c_Label11", "Label")
11044:             WITH par_oPage.lbl_4c_Label11
11045:                 .Top       = 462
11046:                 .Left      = 494
11047:                 .Width     = 35
11048:                 .FontName  = "Tahoma"
11049:                 .FontSize  = 8
11050:                 .BackStyle = 0
11051:                 .Caption   = "Metal :"
11052:                 .ForeColor = RGB(90,90,90)
11053:                 .Visible   = .T.

*-- Linhas 11064 a 11082:
11064:                 .FontSize       = 8
11065:                 .SpecialEffect  = 1
11066:                 .Themes         = .F.
11067:                 .ControlSource  = "crSigCdPro.metals"
11068:                 .Visible        = .T.
11069:             ENDWITH
11070: 
11071:             *-- === Get_DesMetal: top=429+29=458, left=564, w=150, h=23 ===
11072:             par_oPage.AddObject("txt_4c_DesMetal", "TextBox")
11073:             WITH par_oPage.txt_4c_DesMetal
11074:                 .Top            = 458
11075:                 .Left           = 564
11076:                 .Width          = 150
11077:                 .Height         = 23
11078:                 .FontName       = "Tahoma"
11079:                 .FontSize       = 8
11080:                 .SpecialEffect  = 1
11081:                 .Format         = "!"
11082:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXX"

*-- Linhas 11114 a 11148:
11114:                 .InputMask      = "999,999,999.99"
11115:                 .MaxLength      = 14
11116:                 .Themes         = .F.
11117:                 .ControlSource  = "crSigCdPro.valors"
11118:                 .Visible        = .T.
11119:             ENDWITH
11120: 
11121:             *-- === GetMvalor: top=454+29=483, left=317, w=31, h=23 ===
11122:             par_oPage.AddObject("txt_4c_Mvalor", "TextBox")
11123:             WITH par_oPage.txt_4c_Mvalor
11124:                 .Top            = 483
11125:                 .Left           = 317
11126:                 .Width          = 31
11127:                 .Height         = 23
11128:                 .FontName       = "Tahoma"
11129:                 .FontSize       = 8
11130:                 .SpecialEffect  = 1
11131:                 .MaxLength      = 3
11132:                 .Themes         = .F.
11133:                 .ControlSource  = "crSigCdPro.moedas"
11134:                 .Visible        = .T.
11135:             ENDWITH
11136: 
11137:             *-- === Say15: "Teor :" - top=458+29=487, left=498, w=31 ===
11138:             par_oPage.AddObject("lbl_4c_Label15", "Label")
11139:             WITH par_oPage.lbl_4c_Label15
11140:                 .Top       = 487
11141:                 .Left      = 498
11142:                 .Width     = 31
11143:                 .FontName  = "Tahoma"
11144:                 .FontSize  = 8
11145:                 .BackStyle = 0
11146:                 .Caption   = "Teor :"
11147:                 .ForeColor = RGB(90,90,90)
11148:                 .Visible   = .T.

*-- Linhas 11159 a 11177:
11159:                 .FontSize       = 8
11160:                 .SpecialEffect  = 1
11161:                 .Themes         = .F.
11162:                 .ControlSource  = "crSigCdPro.teors"
11163:                 .Visible        = .T.
11164:             ENDWITH
11165: 
11166:             *-- === Get_DesTeor: top=454+29=483, left=564, w=150, h=23 ===
11167:             par_oPage.AddObject("txt_4c_DesTeor", "TextBox")
11168:             WITH par_oPage.txt_4c_DesTeor
11169:                 .Top            = 483
11170:                 .Left           = 564
11171:                 .Width          = 150
11172:                 .Height         = 23
11173:                 .FontName       = "Tahoma"
11174:                 .FontSize       = 8
11175:                 .SpecialEffect  = 1
11176:                 .Format         = "!"
11177:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXX"

*-- Linhas 11704 a 11724:
11704:                 loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11705:                 IF !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)) AND ;
11706:                    !EMPTY(ALLTRIM(loc_oPgFisc.txt_4c_AliqIPI.Value))
11707:                     loc_nRet = SQLEXEC(gnConnHandle, ;
11708:                         "SELECT TOP 1 aIpis FROM SigCdClf WHERE Codigos = " + ;
11709:                         EscaparSQL(ALLTRIM(loc_oPgFisc.txt_4c_Clfiscal.Value)), ;
11710:                         "cursor_4c_TmpClf")
11711:                     IF loc_nRet > 0 AND !EOF("cursor_4c_TmpClf")
11712:                         loc_nAliqClf = cursor_4c_TmpClf.aIpis
11713:                         IF loc_oPgFisc.txt_4c_AliqIPI.Value = loc_nAliqClf
11714:                             MsgAviso("Al" + CHR(237) + "quota de IPI id" + CHR(234) + "ntica " + ;
11715:                                 CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal. " + ;
11716:                                 "Deixe zero para usar a da classifica" + CHR(231) + CHR(227) + "o fiscal!", ;
11717:                                 "Aten" + CHR(231) + CHR(227) + "o")
11718:                         ENDIF
11719:                     ENDIF
11720:                     IF USED("cursor_4c_TmpClf")
11721:                         USE IN cursor_4c_TmpClf
11722:                     ENDIF
11723:                 ENDIF
11724:             ENDIF

*-- Linhas 11800 a 11818:
11800:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11801:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Metal.Value)
11802:             IF !EMPTY(loc_cCodigo) AND USED("TmpMTal")
11803:                 SELECT TmpMTal
11804:                 SET ORDER TO Codigos
11805:                 SET NEAR ON
11806:                 IF !SEEK(loc_cCodigo, "TmpMTal", "Codigos")
11807:                     *-- Nao encontrou exato: mant?m valor digitado
11808:                 ENDIF
11809:                 SET NEAR OFF
11810:                 loc_oPgFisc.txt_4c_Metal.Value    = ALLTRIM(TmpMTal.Codigos)
11811:                 loc_oPgFisc.txt_4c_DesMetal.Value = ALLTRIM(TmpMTal.Descs)
11812:                 loc_oPgFisc.txt_4c_Metal.Refresh
11813:                 loc_oPgFisc.txt_4c_DesMetal.Refresh
11814:             ENDIF
11815:         CATCH TO loc_oErro
11816:             MsgErro(loc_oErro.Message, "Erro ao validar metal")
11817:         ENDTRY
11818:     ENDPROC

*-- Linhas 11844 a 11862:
11844:             loc_oPgFisc = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page3
11845:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Teor.Value)
11846:             IF !EMPTY(loc_cCodigo) AND USED("TmpTeor")
11847:                 SELECT TmpTeor
11848:                 SET ORDER TO Codigos
11849:                 SET NEAR ON
11850:                 IF !SEEK(loc_cCodigo, "TmpTeor", "Codigos")
11851:                     *-- Nao encontrou exato: mant?m valor digitado
11852:                 ENDIF
11853:                 SET NEAR OFF
11854:                 loc_oPgFisc.txt_4c_Teor.Value    = ALLTRIM(TmpTeor.Codigos)
11855:                 loc_oPgFisc.txt_4c_DesTeor.Value = ALLTRIM(TmpTeor.Descs)
11856:                 loc_oPgFisc.txt_4c_Teor.Refresh
11857:                 loc_oPgFisc.txt_4c_DesTeor.Refresh
11858:             ENDIF
11859:         CATCH TO loc_oErro
11860:             MsgErro(loc_oErro.Message, "Erro ao validar teor")
11861:         ENDTRY
11862:     ENDPROC

*-- Linhas 11899 a 11929:
11899:             IF USED("crSigPrTar")
11900:                 USE IN crSigPrTar
11901:             ENDIF
11902:             CREATE CURSOR crSigPrTar (;
11903:                 CPros    C(14)  NULL, ;
11904:                 pkChaves C(30)  NULL, ;
11905:                 DtInis   T      NULL, ;
11906:                 DtFims   T      NULL, ;
11907:                 Usuars   C(20)  NULL, ;
11908:                 Tarefas  C(10)  NULL, ;
11909:                 ObsTars  M      NULL  ;
11910:             )
11911:             IF USED("crSigPrArq")
11912:                 USE IN crSigPrArq
11913:             ENDIF
11914:             CREATE CURSOR crSigPrArq (;
11915:                 CPros    C(14)  NULL, ;
11916:                 pkChaves C(30)  NULL, ;
11917:                 Arquivos C(254) NULL  ;
11918:             )
11919:             SET NULL OFF
11920: 
11921:             *-- === lbl_4c_ObsTar (Say31): top=144+29=173, left=583, w=126, h=15 ===
11922:             par_oPage.AddObject("lbl_4c_ObsTar", "Label")
11923:             WITH par_oPage.lbl_4c_ObsTar
11924:                 .Top       = 173
11925:                 .Left      = 583
11926:                 .Width     = 126
11927:                 .Height    = 15
11928:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
11929:                 .FontName  = "Tahoma"

*-- Linhas 11945 a 11991:
11945:             loc_oGrd.FontName    = "Tahoma"
11946:             loc_oGrd.FontSize    = 8
11947:             loc_oGrd.GridLines   = 3
11948:             loc_oGrd.DeleteMark  = .F.
11949:             loc_oGrd.RecordMark  = .F.
11950:             loc_oGrd.RowHeight   = 16
11951:             loc_oGrd.ScrollBars  = 3
11952:             loc_oGrd.Themes      = .F.
11953:             loc_oGrd.Visible     = .T.
11954: 
11955:             loc_oGrd.RecordSource = "crSigPrTar"
11956: 
11957:             loc_oGrd.Column1.Header1.Caption  = "Data de In" + CHR(237) + "cio"
11958:             loc_oGrd.Column1.ControlSource    = "crSigPrTar.DtInis"
11959:             loc_oGrd.Column1.Width            = 110
11960:             loc_oGrd.Column1.ReadOnly         = .T.
11961:             loc_oGrd.Column1.Header1.FontBold = .T.
11962: 
11963:             loc_oGrd.Column2.Header1.Caption  = "Data de Conclus" + CHR(227) + "o"
11964:             loc_oGrd.Column2.ControlSource    = "crSigPrTar.DtFims"
11965:             loc_oGrd.Column2.Width            = 120
11966:             loc_oGrd.Column2.ReadOnly         = .T.
11967:             loc_oGrd.Column2.Header1.FontBold = .T.
11968: 
11969:             loc_oGrd.Column3.Header1.Caption  = "Usu" + CHR(225) + "rio"
11970:             loc_oGrd.Column3.ControlSource    = "crSigPrTar.Usuars"
11971:             loc_oGrd.Column3.Width            = 100
11972:             loc_oGrd.Column3.ReadOnly         = .T.
11973:             loc_oGrd.Column3.Header1.FontBold = .T.
11974: 
11975:             loc_oGrd.Column4.Header1.Caption  = "Tarefa"
11976:             loc_oGrd.Column4.ControlSource    = "crSigPrTar.Tarefas"
11977:             loc_oGrd.Column4.Width            = 165
11978:             loc_oGrd.Column4.ReadOnly         = .T.
11979:             loc_oGrd.Column4.Header1.FontBold = .T.
11980: 
11981:             *-- BINDEVENTs para grd_4c_Designer
11982:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "DesignerAfterRowColChange")
11983:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "DesignerCol4KeyPress")
11984: 
11985:             *-- === cmd_4c_BtnIniTarefa (btnIniTarefa): top=161+29=190, left=509, w=42, h=42 ===
11986:             par_oPage.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
11987:             WITH par_oPage.cmd_4c_BtnIniTarefa
11988:                 .Top     = 190
11989:                 .Left    = 509
11990:                 .Width   = 42
11991:                 .Height  = 42

*-- Linhas 12017 a 12035:
12017:                 .Left        = 584
12018:                 .Width       = 407
12019:                 .Height      = 238
12020:                 .ControlSource = "crSigPrTar.ObsTars"
12021:                 .FontName    = "Tahoma"
12022:                 .FontSize    = 8
12023:                 .ScrollBars  = 2
12024:                 .ReadOnly    = .T.
12025:                 .Themes      = .F.
12026:                 .Visible     = .T.
12027:             ENDWITH
12028: 
12029:             *-- === shp_4c_Shape1 (Shape1): top=415+29=444, left=584, w=407, h=202 ===
12030:             par_oPage.AddObject("shp_4c_Shape1", "Shape")
12031:             WITH par_oPage.shp_4c_Shape1
12032:                 .Top         = 444
12033:                 .Left        = 584
12034:                 .Width       = 407
12035:                 .Height      = 202

*-- Linhas 12050 a 12078:
12050:             loc_oGrdArq.FontName    = "Tahoma"
12051:             loc_oGrdArq.FontSize    = 8
12052:             loc_oGrdArq.GridLines   = 3
12053:             loc_oGrdArq.DeleteMark  = .F.
12054:             loc_oGrdArq.RecordMark  = .F.
12055:             loc_oGrdArq.RowHeight   = 16
12056:             loc_oGrdArq.ScrollBars  = 3
12057:             loc_oGrdArq.Themes      = .F.
12058:             loc_oGrdArq.Visible     = .T.
12059: 
12060:             loc_oGrdArq.RecordSource = "crSigPrArq"
12061: 
12062:             loc_oGrdArq.Column1.Header1.Caption  = "Arquivos Para Designer"
12063:             loc_oGrdArq.Column1.ControlSource    = "crSigPrArq.Arquivos"
12064:             loc_oGrdArq.Column1.Width            = 495
12065:             loc_oGrdArq.Column1.ReadOnly         = .T.
12066:             loc_oGrdArq.Column1.Header1.FontBold = .T.
12067: 
12068:             *-- BINDEVENTs para grd_4c_Arquivos
12069:             BINDEVENT(loc_oGrdArq, "AfterRowColChange", THIS, "ArquivosAfterRowColChange")
12070: 
12071:             *-- === cmd_4c_BtnInsArqs (btnInsArqs): top=416+29=445, left=509, w=42, h=42 ===
12072:             par_oPage.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
12073:             WITH par_oPage.cmd_4c_BtnInsArqs
12074:                 .Top     = 445
12075:                 .Left    = 509
12076:                 .Width   = 42
12077:                 .Height  = 42
12078:                 .Caption = ""

*-- Linhas 12148 a 12205:
12148:                 IF USED("cursor_4c_TarTemp")
12149:                     USE IN cursor_4c_TarTemp
12150:                 ENDIF
12151:                 loc_cSQL = "SELECT CPros, pkChaves, DtInis, DtFims, Usuars, Tarefas, " + ;
12152:                            "CONVERT(NVARCHAR(MAX), ObsTars) AS ObsTars " + ;
12153:                            "FROM SigPrTar WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
12154:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TarTemp")
12155:                 IF loc_nRet > 0
12156:                     SELECT crSigPrTar
12157:                     ZAP
12158:                     IF RECCOUNT("cursor_4c_TarTemp") > 0
12159:                         APPEND FROM DBF("cursor_4c_TarTemp")
12160:                     ENDIF
12161:                     IF USED("cursor_4c_TarTemp")
12162:                         USE IN cursor_4c_TarTemp
12163:                     ENDIF
12164:                     SELECT crSigPrTar
12165:                     GO TOP
12166:                     loc_oPgDesigner.grd_4c_Designer.Refresh()
12167:                     THIS.DesignerAfterRowColChange(0)
12168:                 ELSE
12169:                     IF USED("cursor_4c_TarTemp")
12170:                         USE IN cursor_4c_TarTemp
12171:                     ENDIF
12172:                 ENDIF
12173: 
12174:                 *-- Carregar crSigPrArq de SigPrArq
12175:                 IF USED("cursor_4c_ArqTemp")
12176:                     USE IN cursor_4c_ArqTemp
12177:                 ENDIF
12178:                 loc_cSQL = "SELECT CPros, pkChaves, Arquivos FROM SigPrArq " + ;
12179:                            "WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
12180:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArqTemp")
12181:                 IF loc_nRet > 0
12182:                     SELECT crSigPrArq
12183:                     ZAP
12184:                     IF RECCOUNT("cursor_4c_ArqTemp") > 0
12185:                         APPEND FROM DBF("cursor_4c_ArqTemp")
12186:                     ENDIF
12187:                     IF USED("cursor_4c_ArqTemp")
12188:                         USE IN cursor_4c_ArqTemp
12189:                     ENDIF
12190:                     SELECT crSigPrArq
12191:                     GO TOP
12192:                     loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12193:                     THIS.ArquivosAfterRowColChange(0)
12194:                 ELSE
12195:                     IF USED("cursor_4c_ArqTemp")
12196:                         USE IN cursor_4c_ArqTemp
12197:                     ENDIF
12198:                 ENDIF
12199: 
12200:                 *-- Carregar crTarefas de SigCdCad (se ainda nao carregado)
12201:                 IF !USED("crTarefas")
12202:                     THIS.CarregarTarefas()
12203:                 ENDIF
12204:             ENDIF
12205:         CATCH TO loc_oErro

*-- Linhas 12219 a 12240:
12219:             IF USED("crTarefas")
12220:                 USE IN crTarefas
12221:             ENDIF
12222:             loc_cSQL = "SELECT LEFT(CodCads, 10) AS CodCads, DesCads " + ;
12223:                        "FROM SigCdCad " + ;
12224:                        "WHERE TipoCads = " + EscaparSQL(PADR("TAREFAS", 20))
12225:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crTarefas")
12226:             IF loc_nRet < 1
12227:                 IF USED("crTarefas")
12228:                     USE IN crTarefas
12229:                 ENDIF
12230:             ENDIF
12231:         CATCH TO loc_oErro
12232:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de tarefas")
12233:         ENDTRY
12234:     ENDPROC
12235: 
12236:     *==========================================================================
12237:     * DesignerAfterRowColChange - Atualiza ObsTarefas e controla edicao Tarefa
12238:     *==========================================================================
12239:     PROCEDURE DesignerAfterRowColChange(par_nColIndex)
12240:         LOCAL loc_oPgDesigner, loc_lPodeEditar, loc_oErro

*-- Linhas 12249 a 12267:
12249:             loc_lPodeEditar = .F.
12250:             IF INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12251:                 IF USED("crSigPrTar") AND !EOF("crSigPrTar") AND !BOF("crSigPrTar")
12252:                     SELECT crSigPrTar
12253:                     IF ALLTRIM(NVL(Usuars, "")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12254:                        AND EMPTY(NVL(DtFims, {}))
12255:                         loc_lPodeEditar = .T.
12256:                     ENDIF
12257:                 ENDIF
12258:             ENDIF
12259:             loc_oPgDesigner.grd_4c_Designer.Column4.ReadOnly = !loc_lPodeEditar
12260:         CATCH TO loc_oErro
12261:             *-- Tolerado: controle da coluna nao critico
12262:         ENDTRY
12263:     ENDPROC
12264: 
12265:     *==========================================================================
12266:     * DesignerCol4KeyPress - F4 abre lookup de Tarefa (crTarefas/SigCdCad)
12267:     *==========================================================================

*-- Linhas 12303 a 12384:
12303:             IF VARTYPE(loc_oBusca) = "O"
12304:                 IF loc_oBusca.this_lSelecionou
12305:                     IF USED("cursor_4c_BuscaTar") AND RECCOUNT("cursor_4c_BuscaTar") > 0
12306:                         SELECT cursor_4c_BuscaTar
12307:                         REPLACE crSigPrTar.Tarefas WITH ALLTRIM(CodCads)
12308:                         loc_oGrd.Refresh()
12309:                     ENDIF
12310:                 ELSE
12311:                     loc_oBusca.mAddColuna("CodCads",  "", "C" + CHR(243) + "digo")
12312:                     loc_oBusca.mAddColuna("DesCads",  "", "Descri" + CHR(231) + CHR(227) + "o")
12313:                     loc_oBusca.Show()
12314:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12315:                         SELECT cursor_4c_BuscaTar
12316:                         REPLACE crSigPrTar.Tarefas WITH ALLTRIM(CodCads)
12317:                         loc_oGrd.Refresh()
12318:                     ENDIF
12319:                 ENDIF
12320:                 loc_oBusca.Release()
12321:             ENDIF
12322:             IF USED("cursor_4c_BuscaTar")
12323:                 USE IN cursor_4c_BuscaTar
12324:             ENDIF
12325:         CATCH TO loc_oErro
12326:             MsgErro(loc_oErro.Message, "Erro ao buscar tarefa")
12327:         ENDTRY
12328:     ENDPROC
12329: 
12330:     *==========================================================================
12331:     * BtnIniTarefaClick - Inicia nova tarefa (INSERT Into crSigPrTar)
12332:     *==========================================================================
12333:     PROCEDURE BtnIniTarefaClick()
12334:         LOCAL loc_oPgDesigner, loc_oGrd, loc_dtAgora, loc_lContinuar, loc_oErro
12335:         loc_lContinuar = .T.
12336:         TRY
12337:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12338:                 loc_lContinuar = .F.
12339:             ENDIF
12340:             IF loc_lContinuar AND !USED("crSigPrTar")
12341:                 loc_lContinuar = .F.
12342:             ENDIF
12343:             IF loc_lContinuar
12344:                 *-- Verificar se existe tarefa nao encerrada para o usuario
12345:                 SELECT crSigPrTar
12346:                 GO TOP
12347:                 LOCATE FOR ALLTRIM(NVL(Usuars,"")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12348:                          AND EMPTY(NVL(DtFims, {}))
12349:                 IF !EOF("crSigPrTar")
12350:                     MsgAviso("Existe uma tarefa n" + CHR(227) + "o encerrada para esse usu" + ;
12351:                              CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12352:                     loc_lContinuar = .F.
12353:                 ENDIF
12354:             ENDIF
12355:             IF loc_lContinuar
12356:                 *-- Verificar se existe tarefa com campo Tarefas vazio
12357:                 SELECT crSigPrTar
12358:                 GO TOP
12359:                 LOCATE FOR ALLTRIM(NVL(Usuars,"")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12360:                          AND EMPTY(NVL(Tarefas,""))
12361:                 IF !EOF("crSigPrTar")
12362:                     MsgAviso("Existe uma tarefa ainda n" + CHR(227) + "o informada!", ;
12363:                              "Aten" + CHR(231) + CHR(227) + "o")
12364:                     loc_lContinuar = .F.
12365:                 ENDIF
12366:             ENDIF
12367:             IF loc_lContinuar
12368:                 loc_dtAgora = DATETIME()
12369:                 INSERT INTO crSigPrTar (CPros, pkChaves, DtInis, Usuars) ;
12370:                     VALUES (PADR(ALLTRIM(this_cCodigo), 14), ;
12371:                             PADR(SYS(2015), 30), ;
12372:                             loc_dtAgora, ;
12373:                             PADR(ALLTRIM(gc_4c_UsuarioLogado), 20))
12374:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12375:                 loc_oPgDesigner.grd_4c_Designer.Refresh()
12376:             ENDIF
12377:         CATCH TO loc_oErro
12378:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12379:         ENDTRY
12380:     ENDPROC
12381: 
12382:     *==========================================================================
12383:     * BtnFimTarefaClick - Finaliza tarefa atual (Replace DtFims)
12384:     *==========================================================================

*-- Linhas 12393 a 12420:
12393:                 loc_lContinuar = .F.
12394:             ENDIF
12395:             IF loc_lContinuar
12396:                 SELECT crSigPrTar
12397:                 *-- Verificar se a tarefa pertence ao usuario atual
12398:                 IF ALLTRIM(NVL(Usuars,"")) <> ALLTRIM(gc_4c_UsuarioLogado)
12399:                     MsgAviso("Essa tarefa n" + CHR(227) + "o pertence a esse usu" + ;
12400:                              CHR(225) + "rio!", "Aten" + CHR(231) + CHR(227) + "o")
12401:                     loc_lContinuar = .F.
12402:                 ENDIF
12403:             ENDIF
12404:             IF loc_lContinuar
12405:                 SELECT crSigPrTar
12406:                 *-- Verificar se a tarefa ja esta finalizada
12407:                 IF !EMPTY(NVL(DtFims, {}))
12408:                     MsgAviso("Essa tarefa j" + CHR(225) + " se encontra finalizada!", ;
12409:                              "Aten" + CHR(231) + CHR(227) + "o")
12410:                     loc_lContinuar = .F.
12411:                 ENDIF
12412:             ENDIF
12413:             IF loc_lContinuar
12414:                 loc_dtAgora = DATETIME()
12415:                 REPLACE DtFims WITH loc_dtAgora IN crSigPrTar
12416:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12417:                 loc_oPgDesigner.grd_4c_Designer.Refresh()
12418:                 THIS.DesignerAfterRowColChange(0)
12419:             ENDIF
12420:         CATCH TO loc_oErro

*-- Linhas 12437 a 12455:
12437:             IF !USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq")
12438:                 RETURN
12439:             ENDIF
12440:             SELECT crSigPrArq
12441:             loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12442:             IF EMPTY(loc_cArq)
12443:                 RETURN
12444:             ENDIF
12445:             loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
12446:             IF INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG") AND FILE(loc_cArq)
12447:                 CLEAR RESOURCES
12448:                 loc_oPgDesigner.img_4c_ImgArqJpg.Picture  = loc_cArq
12449:                 loc_oPgDesigner.img_4c_ImgArqJpg.Visible  = .T.
12450:             ENDIF
12451:         CATCH TO loc_oErro
12452:             *-- Tolerado: preview de imagem nao critico
12453:         ENDTRY
12454:     ENDPROC
12455: 

*-- Linhas 12467 a 12485:
12467:                 loc_cArq = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
12468:                     "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
12469:                 IF !EMPTY(loc_cArq)
12470:                     INSERT INTO crSigPrArq (CPros, pkChaves, Arquivos) ;
12471:                         VALUES (PADR(ALLTRIM(this_cCodigo), 14), ;
12472:                                 PADR(SYS(2015), 30), ;
12473:                                 UPPER(loc_cArq))
12474:                     loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12475:                     loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12476:                 ENDIF
12477:             ENDIF
12478:         CATCH TO loc_oErro
12479:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12480:         ENDTRY
12481:     ENDPROC
12482: 
12483:     *==========================================================================
12484:     * BtnOpnArqsClick - Abre arquivo selecionado com Shell.Application
12485:     *==========================================================================

*-- Linhas 12491 a 12509:
12491:                 loc_lContinuar = .F.
12492:             ENDIF
12493:             IF loc_lContinuar
12494:                 SELECT crSigPrArq
12495:                 loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12496:                 IF EMPTY(loc_cArq)
12497:                     loc_lContinuar = .F.
12498:                 ENDIF
12499:             ENDIF
12500:             IF loc_lContinuar
12501:                 IF FILE(loc_cArq)
12502:                     loc_oShell = CREATEOBJECT("Shell.Application")
12503:                     IF VARTYPE(loc_oShell) = "O"
12504:                         loc_oShell.Open(loc_cArq)
12505:                     ENDIF
12506:                 ELSE
12507:                     MsgAviso("Arquivo n" + CHR(227) + "o encontrado: " + loc_cArq, ;
12508:                              "Aten" + CHR(231) + CHR(227) + "o")
12509:                 ENDIF

*-- Linhas 12527 a 12547:
12527:                 loc_lContinuar = .F.
12528:             ENDIF
12529:             IF loc_lContinuar
12530:                 SELECT crSigPrArq
12531:                 IF !EMPTY(ALLTRIM(NVL(Arquivos, "")))
12532:                     DELETE IN crSigPrArq
12533:                     IF !EOF("crSigPrArq")
12534:                         SKIP IN crSigPrArq
12535:                     ENDIF
12536:                 ENDIF
12537:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12538:                 loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12539:                 THIS.ArquivosAfterRowColChange(0)
12540:             ENDIF
12541:         CATCH TO loc_oErro
12542:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12543:         ENDTRY
12544:     ENDPROC
12545: 
12546:     *==========================================================================
12547:     * ImgArqJpgClick - Zoom na imagem (abre SigOpZom se for imagem valida)

*-- Linhas 12554 a 12572:
12554:                 loc_lContinuar = .F.
12555:             ENDIF
12556:             IF loc_lContinuar
12557:                 SELECT crSigPrArq
12558:                 loc_cArq = ALLTRIM(NVL(Arquivos, ""))
12559:                 IF EMPTY(loc_cArq)
12560:                     loc_lContinuar = .F.
12561:                 ENDIF
12562:             ENDIF
12563:             IF loc_lContinuar
12564:                 loc_cExt = ALLTRIM(UPPER(SUBSTR(loc_cArq, AT(".", loc_cArq), 5)))
12565:                 IF FILE(loc_cArq) AND INLIST(loc_cExt, ".JPG", ".ICO", ".BMP", ".JPEG")
12566:                     DO FORM SigOpZom WITH loc_cArq, "Arquivo: " + loc_cArq
12567:                 ENDIF
12568:             ENDIF
12569:         CATCH TO loc_oErro
12570:             MsgErro(loc_oErro.Message, "Erro ao exibir imagem em zoom")
12571:         ENDTRY
12572:     ENDPROC


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos (SigCdPro)
* Gerado: Fase 8/8 - Completo, tabela SigCdPro
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *-- Identificacao
    this_cCpros       = ""    && CPros  char(14) - PK: codigo do produto
    *-- Descricoes
    this_cDpros       = ""    && DPros  - descricao principal
    this_cDPro2s      = ""    && DPro2s - descricao secundaria
    this_cDPro3s      = ""    && DPro3s - descricao memo (editbox)
    *-- Grupo / Subgrupo
    this_cCgrus       = ""    && CGrus  - codigo do grupo
    this_cSGrus       = ""    && SGrus  - codigo do subgrupo
    *-- Fornecedor / Referencia / Colecao
    this_cIFors       = ""    && IFors  - codigo do fornecedor
    this_cReffs       = ""    && Reffs  - referencia do fornecedor
    this_cColecoes    = ""    && Colecoes - colecao
    *-- Codigos auxiliares
    this_cCbars       = ""    && Cbars    - codigo de barras
    this_cEAN13       = ""    && EAN13    - EAN-13 (se campo separado)
    this_cCProEqs     = ""    && CProEqs  - produto equivalente
    this_cIdeCPros    = ""    && IdeCPros - identificador
    this_cMercs       = ""    && Mercs    - mercadoria
    *-- Linha / Colecao
    this_cLins        = ""    && Lins     - codigo da linha
    this_cCols        = ""    && Cols     - codigo da colecao/grupo venda
    *-- Unidades
    this_cCUnis       = ""    && CUnis    - unidade 1
    this_cCUnips      = ""    && CUnips   - unidade 2
    *-- Dimensoes
    this_nAlturas     = 0     && Alturas
    this_nLarguras    = 0     && Larguras
    this_nDiametros   = 0     && Diametros
    this_nEspessuras  = 0     && Espessuras
    this_nCompriments = 0     && Compriments
    this_nPesoMs      = 0     && PesoMs      - peso base
    this_nPesoBs      = 0     && PesoBs      - peso bruto
    this_nPesoPmedios = 0     && PesoPmedios - peso medio
    *-- Classificacoes
    this_cTams        = ""    && Tams     - tamanho
    this_cCorPros     = ""    && CorPros  - cor
    this_cCodFinPs    = ""    && CodFinPs - finalidade
    this_cCodAcbs     = ""    && CodAcbs  - acabamento
    this_cLocals      = ""    && Locals   - local
    this_cClasss      = ""    && Classs   - classificacao
    *-- Precos e moedas
    this_nPvens       = 0     && Pvens    - preco de venda
    this_cMoevs       = ""    && Moevs    - moeda venda
    this_nFvendas     = 0     && Fvendas  - fator venda
    this_cMfvendas    = ""    && Mfvendas - moeda fator venda
    this_nCustofs     = 0     && Custofs  - custo
    this_cMoecs       = ""    && Moecs    - moeda custo
    this_nMargems     = 0     && Margems  - margem
    this_nPcuss       = 0     && Pcuss    - preco custo unitario
    this_cMoePcs      = ""    && MoePcs   - moeda preco custo
    this_nFcustos     = 0     && Fcustos  - fator custo
    this_nPFTioCs     = 0     && PFTioCs  - feitio custo
    this_nPFTios      = 0     && PFTios   - feitio venda
    *-- Quantidades e lotes
    this_nQmins       = 0     && Qmins    - quantidade minima
    this_nLtMinsVs    = 0     && LtMinsVs - lote minimo venda
    this_nConjuntos   = 0     && Conjuntos - conjunto
    this_nQtPeds      = 0     && QtPeds   - quantidade pedido
    *-- Flags booleanos (armazenados como INT 0/1)
    this_nGarVits     = 0     && GarVits     - garantia vitrine
    this_nConsigs     = 0     && Consigs     - consignado
    this_nFabrProprs  = 0     && FabrProprs  - fabricacao propria
    this_nEncoms      = 0     && Encoms      - encomenda
    this_nProdWebs    = 0     && ProdWebs    - produto web
    this_nOpcVars     = 0     && OpcVars     - opcao variacao
    this_nInstalas    = 0     && Instalas    - instalado/ativo (chkInstalas)
    *-- Status e situacao
    this_nSituas      = 0     && Situas  - situacao
    this_dDtSituas    = {}    && DtSituas - data situacao
    *-- Observacoes
    this_cObs1s       = ""    && Obs1s
    this_cObs2s       = ""    && Obs2s
    this_cObs3s       = ""    && Obs3s
    this_cDscCompras  = ""    && DscCompras - descricao compras (memo)
    this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
    *-- Campos customizados
    this_cFwget3s     = ""    && Fwget3s
    this_cFwget4s     = ""    && Fwget4s
    this_cFwget5s     = ""    && Fwget5s
    this_cFwget6s     = ""    && Fwget6s
    this_cCodIdents   = ""    && CodIdents
    this_cTEnts       = ""    && TEnts  - tipo entrada
    this_nDiasGars    = 0     && DiasGars - dias de garantia
    *-- Campos FaseP (Fase P - dados de processo)
    this_nQtMinFabs   = 0     && QtMinFabs  - qtd minima fabricacao
    this_cCodGarras   = ""    && CodGarras  - codigo de garras
    this_cConquilhas  = ""    && Conquilhas - conquilha padrao
    this_nPesoBris    = 0     && PesoBris   - peso brilhante
    this_nPesoMetal   = 0     && PesoMetal  - peso metal
    this_nPesoPdrs    = 0     && PesoPdrs   - peso pedra
    this_nCravCers    = 0     && CravCers   - cravacao em cera (0/1)
    this_nVarias      = 0     && Varias     - peso variavel (0/1)
    *-- Estoque e auditoria (somente leitura)
    this_nEstoques    = 0     && Estoques
    this_nQtdEsts     = 0     && QtdEsts
    this_dDtIncs      = {}    && DtIncs  - data de inclusao
    this_dDataAlts    = {}    && DataAlts - data alteracao
    this_cHoraAlts    = ""    && HoraAlts - hora alteracao
    this_cUsuaIncs    = ""    && UsuaIncs - usuario inclusao
    this_cUsuaAlts    = ""    && UsuaAlts - usuario alteracao
    this_dDtucps      = {}    && Dtucps  - data ult. compra
    this_nVucps       = 0     && Vucps   - valor ult. compra
    this_cMucps       = ""    && Mucps   - moeda ult. compra
    this_nQtdUltComps = 0     && QtdUltComps - qtd ult. compra

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCpros       = TratarNulo(CPros,       "C")
                THIS.this_cDpros       = TratarNulo(DPros,       "C")
                THIS.this_cDPro2s      = TratarNulo(DPro2s,      "C")
                THIS.this_cDPro3s      = TratarNulo(DPro3s,      "C")
                THIS.this_cCgrus       = TratarNulo(CGrus,       "C")
                THIS.this_cSGrus       = TratarNulo(SGrus,       "C")
                THIS.this_cIFors       = TratarNulo(IFors,       "C")
                THIS.this_cReffs       = TratarNulo(Reffs,       "C")
                THIS.this_cColecoes    = TratarNulo(Colecoes,    "C")
                THIS.this_cCbars       = TratarNulo(Cbars,       "C")
                THIS.this_cCProEqs     = TratarNulo(CProEqs,     "C")
                THIS.this_cIdeCPros    = TratarNulo(IdeCPros,    "C")
                THIS.this_cMercs       = TratarNulo(Mercs,       "C")
                THIS.this_cLins        = TratarNulo(Lins,        "C")
                THIS.this_cCols        = TratarNulo(Cols,        "C")
                THIS.this_cCUnis       = TratarNulo(CUnis,       "C")
                THIS.this_cCUnips      = TratarNulo(CUnips,      "C")
                THIS.this_nAlturas     = TratarNulo(Alturas,     "N")
                THIS.this_nLarguras    = TratarNulo(Larguras,    "N")
                THIS.this_nDiametros   = TratarNulo(Diametros,   "N")
                THIS.this_nEspessuras  = TratarNulo(Espessuras,  "N")
                THIS.this_nCompriments = TratarNulo(Compriments, "N")
                THIS.this_nPesoMs      = TratarNulo(PesoMs,      "N")
                THIS.this_nPesoBs      = TratarNulo(PesoBs,      "N")
                THIS.this_nPesoPmedios = TratarNulo(PesoPmedios, "N")
                THIS.this_cTams        = TratarNulo(Tams,        "C")
                THIS.this_cCorPros     = TratarNulo(CorPros,     "C")
                THIS.this_cCodFinPs    = TratarNulo(CodFinPs,    "C")
                THIS.this_cCodAcbs     = TratarNulo(CodAcbs,     "C")
                THIS.this_cLocals      = TratarNulo(Locals,      "C")
                THIS.this_cClasss      = TratarNulo(Classs,      "C")
                THIS.this_nPvens       = TratarNulo(Pvens,       "N")
                THIS.this_cMoevs       = TratarNulo(Moevs,       "C")
                THIS.this_nFvendas     = TratarNulo(Fvendas,     "N")
                THIS.this_cMfvendas    = TratarNulo(Mfvendas,    "C")
                THIS.this_nCustofs     = TratarNulo(Custofs,     "N")
                THIS.this_cMoecs       = TratarNulo(Moecs,       "C")
                THIS.this_nMargems     = TratarNulo(Margems,     "N")
                THIS.this_nQmins       = TratarNulo(Qmins,       "N")
                THIS.this_nLtMinsVs    = TratarNulo(LtMinsVs,    "N")
                THIS.this_nConjuntos   = TratarNulo(Conjuntos,   "N")
                THIS.this_nQtPeds      = TratarNulo(QtPeds,      "N")
                THIS.this_nGarVits     = TratarNulo(GarVits,     "N")
                THIS.this_nConsigs     = TratarNulo(Consigs,     "N")
                THIS.this_nFabrProprs  = TratarNulo(FabrProprs,  "N")
                THIS.this_nEncoms      = TratarNulo(Encoms,      "N")
                THIS.this_nProdWebs    = TratarNulo(ProdWebs,    "N")
                THIS.this_nOpcVars     = TratarNulo(OpcVars,     "N")
                THIS.this_nInstalas    = TratarNulo(Instalas,    "N")
                THIS.this_nSituas      = TratarNulo(Situas,      "N")
                THIS.this_dDtSituas    = TratarNulo(DtSituas,    "D")
                THIS.this_cObs1s       = TratarNulo(Obs1s,       "C")
                THIS.this_cObs2s       = TratarNulo(Obs2s,       "C")
                THIS.this_cObs3s       = TratarNulo(Obs3s,       "C")
                THIS.this_cDscCompras  = TratarNulo(DscCompras,  "C")
                THIS.this_cObsCompras  = TratarNulo(ObsCompras,  "C")
                THIS.this_cFwget3s     = TratarNulo(Fwget3s,     "C")
                THIS.this_cFwget4s     = TratarNulo(Fwget4s,     "C")
                THIS.this_cFwget5s     = TratarNulo(Fwget5s,     "C")
                THIS.this_cFwget6s     = TratarNulo(Fwget6s,     "C")
                THIS.this_cCodIdents   = TratarNulo(CodIdents,   "C")
                THIS.this_cTEnts       = TratarNulo(TEnts,       "C")
                THIS.this_nDiasGars    = TratarNulo(DiasGars,    "N")
                THIS.this_nQtMinFabs   = TratarNulo(QtMinFabs,   "N")
                THIS.this_cCodGarras   = TratarNulo(CodGarras,   "C")
                THIS.this_cConquilhas  = TratarNulo(Conquilhas,  "C")
                THIS.this_nPesoBris    = TratarNulo(PesoBris,    "N")
                THIS.this_nPesoMetal   = TratarNulo(PesoMetal,   "N")
                THIS.this_nPesoPdrs    = TratarNulo(PesoPdrs,    "N")
                THIS.this_nCravCers    = TratarNulo(CravCers,    "N")
                THIS.this_nVarias      = TratarNulo(Varias,      "N")
                THIS.this_nEstoques    = TratarNulo(Estoques,    "N")
                THIS.this_nQtdEsts     = TratarNulo(QtdEsts,     "N")
                THIS.this_dDtIncs      = TratarNulo(DtIncs,      "D")
                THIS.this_dDataAlts    = TratarNulo(DataAlts,    "D")
                THIS.this_cHoraAlts    = TratarNulo(HoraAlts,    "C")
                THIS.this_cUsuaIncs    = TratarNulo(UsuaIncs,    "C")
                THIS.this_cUsuaAlts    = TratarNulo(UsuaAlts,    "C")
                THIS.this_dDtucps      = TratarNulo(Dtucps,      "D")
                THIS.this_nVucps       = TratarNulo(Vucps,       "N")
                THIS.this_cMucps       = TratarNulo(Mucps,       "C")
                THIS.this_nQtdUltComps = TratarNulo(QtdUltComps, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar produto do cursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Busca o produto no banco pelo CPros
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_nRet, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cCodigo) OR gnConnHandle <= 0
                loc_lSucesso = loc_lSucesso
            ENDIF
            IF USED("cursor_4c_ProdutoBO")
                USE IN cursor_4c_ProdutoBO
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(PADR(ALLTRIM(par_cCodigo), 14)), ;
                "cursor_4c_ProdutoBO")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ProdutoBO") > 0
                THIS.CarregarDoCursor("cursor_4c_ProdutoBO")
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_ProdutoBO")
                USE IN cursor_4c_ProdutoBO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna cursor com lista de produtos (filtro SQL WHERE opcional)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nRet, loc_oErro
        TRY
            IF USED("cursor_4c_BuscarBO")
                USE IN cursor_4c_BuscarBO
            ENDIF
            loc_cSQL = "SELECT CPros, DPros, CGrus, SGrus, Reffs, " + ;
                       "UsuaAlts, CAST(ISNULL(Instalas,0) AS INT) AS Instalas " + ;
                       "FROM SigCdPro"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY CPros"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscarBO")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
        ENDTRY
        RETURN loc_nRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdPro (" + ;
                "CPros, DPros, DPro2s, CGrus, SGrus, IFors, Reffs, Colecoes, " + ;
                "Cbars, CProEqs, IdeCPros, Mercs, Lins, Cols, CUnis, CUnips, " + ;
                "Alturas, Larguras, Diametros, Espessuras, Compriments, " + ;
                "PesoMs, PesoBs, PesoPmedios, Tams, CorPros, CodFinPs, " + ;
                "CodAcbs, Locals, Classs, " + ;
                "Pvens, Moevs, Fvendas, Mfvendas, Custofs, Moecs, Margems, " + ;
                "Qmins, LtMinsVs, Conjuntos, QtPeds, DiasGars, " + ;
                "GarVits, Consigs, FabrProprs, Encoms, ProdWebs, OpcVars, Instalas, " + ;
                "Situas, DtSituas, Obs1s, Obs2s, Obs3s, DscCompras, ObsCompras, " + ;
                "Fwget3s, Fwget4s, Fwget5s, Fwget6s, CodIdents, TEnts, " + ;
                "QtMinFabs, CodGarras, Conquilhas, PesoBris, PesoMetal, PesoPdrs, CravCers, Varias, " + ;
                "DtIncs, UsuaIncs, DataAlts, UsuaAlts" + ;
                ") VALUES (" + ;
                EscaparSQL(PADR(THIS.this_cCpros, 14)) + "," + ;
                EscaparSQL(THIS.this_cDpros) + "," + ;
                EscaparSQL(THIS.this_cDPro2s) + "," + ;
                EscaparSQL(PADR(THIS.this_cCgrus, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cSGrus, 10)) + "," + ;
                EscaparSQL(THIS.this_cIFors) + "," + ;
                EscaparSQL(THIS.this_cReffs) + "," + ;
                EscaparSQL(THIS.this_cColecoes) + "," + ;
                EscaparSQL(THIS.this_cCbars) + "," + ;
                EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
                EscaparSQL(THIS.this_cIdeCPros) + "," + ;
                EscaparSQL(THIS.this_cMercs) + "," + ;
                EscaparSQL(THIS.this_cLins) + "," + ;
                EscaparSQL(THIS.this_cCols) + "," + ;
                EscaparSQL(THIS.this_cCUnis) + "," + ;
                EscaparSQL(THIS.this_cCUnips) + "," + ;
                FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
                FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
                FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
                FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
                FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
                EscaparSQL(THIS.this_cTams) + "," + ;
                EscaparSQL(THIS.this_cCorPros) + "," + ;
                EscaparSQL(THIS.this_cCodFinPs) + "," + ;
                EscaparSQL(THIS.this_cCodAcbs) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cClasss) + "," + ;
                FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
                EscaparSQL(THIS.this_cMoevs) + "," + ;
                FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
                EscaparSQL(THIS.this_cMfvendas) + "," + ;
                FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
                EscaparSQL(THIS.this_cMoecs) + "," + ;
                FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
                FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
                FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
                FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
                FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
                FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
                FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
                FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
                FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
                FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
                FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
                FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
                FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
                FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
                FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
                EscaparSQL(THIS.this_cObs1s) + "," + ;
                EscaparSQL(THIS.this_cObs2s) + "," + ;
                EscaparSQL(THIS.this_cObs3s) + "," + ;
                EscaparSQL(THIS.this_cDscCompras) + "," + ;
                EscaparSQL(THIS.this_cObsCompras) + "," + ;
                EscaparSQL(THIS.this_cFwget3s) + "," + ;
                EscaparSQL(THIS.this_cFwget4s) + "," + ;
                EscaparSQL(THIS.this_cFwget5s) + "," + ;
                EscaparSQL(THIS.this_cFwget6s) + "," + ;
                EscaparSQL(THIS.this_cCodIdents) + "," + ;
                EscaparSQL(THIS.this_cTEnts) + "," + ;
                FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
                EscaparSQL(THIS.this_cCodGarras) + "," + ;
                EscaparSQL(THIS.this_cConquilhas) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoMetal) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoPdrs) + "," + ;
                FormatarNumeroSQL(THIS.this_nCravCers) + "," + ;
                FormatarNumeroSQL(THIS.this_nVarias) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ;
                ")"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdPro SET " + ;
                "DPros       = " + EscaparSQL(THIS.this_cDpros) + "," + ;
                "DPro2s      = " + EscaparSQL(THIS.this_cDPro2s) + "," + ;
                "CGrus       = " + EscaparSQL(PADR(THIS.this_cCgrus, 10)) + "," + ;
                "SGrus       = " + EscaparSQL(PADR(THIS.this_cSGrus, 10)) + "," + ;
                "IFors       = " + EscaparSQL(THIS.this_cIFors) + "," + ;
                "Reffs       = " + EscaparSQL(THIS.this_cReffs) + "," + ;
                "Colecoes    = " + EscaparSQL(THIS.this_cColecoes) + "," + ;
                "Cbars       = " + EscaparSQL(THIS.this_cCbars) + "," + ;
                "CProEqs     = " + EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
                "IdeCPros    = " + EscaparSQL(THIS.this_cIdeCPros) + "," + ;
                "Mercs       = " + EscaparSQL(THIS.this_cMercs) + "," + ;
                "Lins        = " + EscaparSQL(THIS.this_cLins) + "," + ;
                "Cols        = " + EscaparSQL(THIS.this_cCols) + "," + ;
                "CUnis       = " + EscaparSQL(THIS.this_cCUnis) + "," + ;
                "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
                "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
                "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
                "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
                "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
                "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
                "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
                "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
                "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
                "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;
                "CorPros     = " + EscaparSQL(THIS.this_cCorPros) + "," + ;
                "CodFinPs    = " + EscaparSQL(THIS.this_cCodFinPs) + "," + ;
                "CodAcbs     = " + EscaparSQL(THIS.this_cCodAcbs) + "," + ;
                "Locals      = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                "Classs      = " + EscaparSQL(THIS.this_cClasss) + "," + ;
                "Pvens       = " + FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
                "Moevs       = " + EscaparSQL(THIS.this_cMoevs) + "," + ;
                "Fvendas     = " + FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
                "Mfvendas    = " + EscaparSQL(THIS.this_cMfvendas) + "," + ;
                "Custofs     = " + FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
                "Moecs       = " + EscaparSQL(THIS.this_cMoecs) + "," + ;
                "Margems     = " + FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
                "Qmins       = " + FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
                "LtMinsVs    = " + FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
                "Conjuntos   = " + FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
                "QtPeds      = " + FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
                "DiasGars    = " + FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
                "GarVits     = " + FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
                "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
                "FabrProprs  = " + FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
                "Encoms      = " + FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
                "ProdWebs    = " + FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
                "OpcVars     = " + FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
                "Instalas    = " + FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
                "Situas      = " + FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
                "DtSituas    = " + FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
                "Obs1s       = " + EscaparSQL(THIS.this_cObs1s) + "," + ;
                "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;
                "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;
                "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
                "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
                "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
                "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;
                "Fwget5s     = " + EscaparSQL(THIS.this_cFwget5s) + "," + ;
                "Fwget6s     = " + EscaparSQL(THIS.this_cFwget6s) + "," + ;
                "CodIdents   = " + EscaparSQL(THIS.this_cCodIdents) + "," + ;
                "TEnts       = " + EscaparSQL(THIS.this_cTEnts) + "," + ;
                "QtMinFabs   = " + FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
                "CodGarras   = " + EscaparSQL(THIS.this_cCodGarras) + "," + ;
                "Conquilhas  = " + EscaparSQL(THIS.this_cConquilhas) + "," + ;
                "PesoBris    = " + FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;
                "PesoMetal   = " + FormatarNumeroSQL(THIS.this_nPesoMetal) + "," + ;
                "PesoPdrs    = " + FormatarNumeroSQL(THIS.this_nPesoPdrs) + "," + ;
                "CravCers    = " + FormatarNumeroSQL(THIS.this_nCravCers) + "," + ;
                "Varias      = " + FormatarNumeroSQL(THIS.this_nVarias) + "," + ;
                "DataAlts    = GETDATE()," + ;
                "UsuaAlts    = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE CPros = " + EscaparSQL(PADR(THIS.this_cCpros, 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdPro (chamado por Excluir() do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(PADR(THIS.this_cCpros, 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

