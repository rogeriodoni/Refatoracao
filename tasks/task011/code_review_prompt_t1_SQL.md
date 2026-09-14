# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (11392 linhas total):

*-- Linhas 455 a 484:
455:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
456: 
457:         *-- Grade principal (Grade: Left=38, Top=173+29=202, W=922, H=409, 7 colunas)
458:         *-- IMPORTANTE: RecordMark=.F., DeleteMark=.F.
459:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
460:         loc_oGrade = loc_oPagina.grd_4c_Dados
461:         WITH loc_oGrade
462:             .Top           = 202
463:             .Left          = 38
464:             .Width         = 922
465:             .Height        = 409
466:             .FontName      = "Arial"
467:             .FontSize      = 8
468:             .RecordMark    = .F.
469:             .DeleteMark    = .F.
470:             .GridLines     = 3
471:             .ReadOnly      = .T.
472:             .Themes        = .F.
473:             .ColumnCount   = 7
474:             .Visible       = .T.
475:         ENDWITH
476: 
477:         *-- Configurar colunas APOS ColumnCount (cabecalhos serao re-aplicados pos RecordSource)
478:         WITH loc_oGrade.Column1
479:             .Width     = 110
480:             .Movable   = .F.
481:             .Resizable = .F.
482:             .ReadOnly  = .T.
483:         ENDWITH
484:         WITH loc_oGrade.Column2

*-- Linhas 1882 a 1939:
1882:             USE IN cursor_4c_Compo
1883:         ENDIF
1884:         SET NULL OFF
1885:         CREATE CURSOR cursor_4c_Compo ( ;
1886:             mats      C(14), dcompos C(40), unicompos C(3),  ;
1887:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
1888:             moeds     C(3),  obscompos C(10), etiqs C(1),    ;
1889:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
1890:             ordems    N(2,0), tipos C(20))
1891: 
1892:         *-- cursor_4c_SubCp - sub-composicao (sigsubcp)
1893:         IF USED("cursor_4c_SubCp")
1894:             USE IN cursor_4c_SubCp
1895:         ENDIF
1896:         CREATE CURSOR cursor_4c_SubCp ( ;
1897:             mats      C(14), dcompos C(40), unicompos C(3),  ;
1898:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
1899:             moeds     C(3),  obscompos C(10), etiqs C(1),    ;
1900:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
1901:             ordems    N(2,0), matsubs C(14), codtams C(4))
1902: 
1903:         *-- cursor_4c_TotGrupo - totais por grupo (calculado)
1904:         IF USED("cursor_4c_TotGrupo")
1905:             USE IN cursor_4c_TotGrupo
1906:         ENDIF
1907:         CREATE CURSOR cursor_4c_TotGrupo ( ;
1908:             Grupo     C(3), ValGrupo N(11,3), Moeda C(3))
1909: 
1910:         *-- ===================================================================
1911:         *-- GRID grd_4c_Compo - Composicao principal (grdCompo: top=148, left=6, w=943, h=147)
1912:         *-- 14 colunas de SIGPRCPO
1913:         *-- ===================================================================
1914:         loc_oPg.AddObject("grd_4c_Compo", "Grid")
1915:         loc_oGrd = loc_oPg.grd_4c_Compo
1916:         WITH loc_oGrd
1917:             .Top         = 148
1918:             .Left        = 6
1919:             .Width       = 943
1920:             .Height      = 147
1921:             .FontName    = "Tahoma"
1922:             .FontSize    = 8
1923:             .RecordMark  = .F.
1924:             .DeleteMark  = .F.
1925:             .GridLines   = 3
1926:             .ReadOnly    = .F.
1927:             .RowHeight   = 16
1928:             .ScrollBars  = 2
1929:             .Themes      = .F.
1930:             .ColumnCount = 14
1931:             .Visible     = .T.
1932:         ENDWITH
1933: 
1934:         *-- Coluna 1: Material (mats, w=108)
1935:         WITH loc_oGrd.Column1
1936:             .Width     = 108
1937:             .Movable   = .F.
1938:             .Resizable = .F.
1939:             .InputMask = "XXXXXXXXXXXXXX"

*-- Linhas 2013 a 2045:
2013:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
2014:         loc_oGrd.RecordSource = "cursor_4c_Compo"
2015: 
2016:         *-- ControlSource APOS RecordSource (obrigatorio)
2017:         loc_oGrd.Column1.ControlSource  = "cursor_4c_Compo.mats"
2018:         loc_oGrd.Column2.ControlSource  = "cursor_4c_Compo.dcompos"
2019:         loc_oGrd.Column3.ControlSource  = "cursor_4c_Compo.unicompos"
2020:         loc_oGrd.Column4.ControlSource  = "cursor_4c_Compo.pcompos"
2021:         loc_oGrd.Column5.ControlSource  = "cursor_4c_Compo.qtds"
2022:         loc_oGrd.Column6.ControlSource  = "cursor_4c_Compo.totas"
2023:         loc_oGrd.Column7.ControlSource  = "cursor_4c_Compo.moeds"
2024:         loc_oGrd.Column8.ControlSource  = "cursor_4c_Compo.obscompos"
2025:         loc_oGrd.Column9.ControlSource  = "cursor_4c_Compo.etiqs"
2026:         loc_oGrd.Column10.ControlSource = "cursor_4c_Compo.qtscons"
2027:         loc_oGrd.Column11.ControlSource = "cursor_4c_Compo.qtdcvs"
2028:         loc_oGrd.Column12.ControlSource = "cursor_4c_Compo.cunips"
2029:         loc_oGrd.Column13.ControlSource = "cursor_4c_Compo.ordems"
2030:         loc_oGrd.Column14.ControlSource = "cursor_4c_Compo.tipos"
2031: 
2032:         *-- Cabecalhos APOS RecordSource
2033:         loc_oGrd.Column1.Header1.Caption  = "Material"
2034:         loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2035:         loc_oGrd.Column3.Header1.Caption  = "Un"
2036:         loc_oGrd.Column4.Header1.Caption  = "Valor"
2037:         loc_oGrd.Column5.Header1.Caption  = "Qtde."
2038:         loc_oGrd.Column6.Header1.Caption  = "Total"
2039:         loc_oGrd.Column7.Header1.Caption  = "Moe"
2040:         loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
2041:         loc_oGrd.Column9.Header1.Caption  = "E"
2042:         loc_oGrd.Column10.Header1.Caption = "Consumo"
2043:         loc_oGrd.Column11.Header1.Caption = "Qtde."
2044:         loc_oGrd.Column12.Header1.Caption = "Un"
2045:         loc_oGrd.Column13.Header1.Caption = "Ord"

*-- Linhas 2078 a 2096:
2078:             .FontName    = "Tahoma"
2079:             .FontSize    = 8
2080:             .RecordMark  = .F.
2081:             .DeleteMark  = .F.
2082:             .GridLines   = 3
2083:             .ReadOnly    = .F.
2084:             .RowHeight   = 16
2085:             .ScrollBars  = 2
2086:             .Themes      = .F.
2087:             .ColumnCount = 15
2088:             .Visible     = .T.
2089:         ENDWITH
2090: 
2091:         *-- Colunas grd_4c_SubCp
2092:         WITH loc_oGrd2.Column1
2093:             .Width = 108
2094:             .Movable = .F.
2095:             .Resizable = .F.
2096:         ENDWITH

*-- Linhas 2161 a 2194:
2161:         *-- RecordSource APOS ColumnCount
2162:         loc_oGrd2.RecordSource = "cursor_4c_SubCp"
2163: 
2164:         *-- ControlSource APOS RecordSource
2165:         loc_oGrd2.Column1.ControlSource  = "cursor_4c_SubCp.mats"
2166:         loc_oGrd2.Column2.ControlSource  = "cursor_4c_SubCp.dcompos"
2167:         loc_oGrd2.Column3.ControlSource  = "cursor_4c_SubCp.unicompos"
2168:         loc_oGrd2.Column4.ControlSource  = "cursor_4c_SubCp.pcompos"
2169:         loc_oGrd2.Column5.ControlSource  = "cursor_4c_SubCp.qtds"
2170:         loc_oGrd2.Column6.ControlSource  = "cursor_4c_SubCp.totas"
2171:         loc_oGrd2.Column7.ControlSource  = "cursor_4c_SubCp.moeds"
2172:         loc_oGrd2.Column8.ControlSource  = "cursor_4c_SubCp.obscompos"
2173:         loc_oGrd2.Column9.ControlSource  = "cursor_4c_SubCp.etiqs"
2174:         loc_oGrd2.Column10.ControlSource = "cursor_4c_SubCp.qtscons"
2175:         loc_oGrd2.Column11.ControlSource = "cursor_4c_SubCp.qtdcvs"
2176:         loc_oGrd2.Column12.ControlSource = "cursor_4c_SubCp.cunips"
2177:         loc_oGrd2.Column13.ControlSource = "cursor_4c_SubCp.ordems"
2178:         loc_oGrd2.Column14.ControlSource = "cursor_4c_SubCp.matsubs"
2179:         loc_oGrd2.Column15.ControlSource = "cursor_4c_SubCp.codtams"
2180: 
2181:         *-- Cabecalhos grd_4c_SubCp APOS RecordSource
2182:         loc_oGrd2.Column1.Header1.Caption  = "Material"
2183:         loc_oGrd2.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2184:         loc_oGrd2.Column3.Header1.Caption  = "Un"
2185:         loc_oGrd2.Column4.Header1.Caption  = "Valor"
2186:         loc_oGrd2.Column5.Header1.Caption  = "Qtde."
2187:         loc_oGrd2.Column6.Header1.Caption  = "Total"
2188:         loc_oGrd2.Column7.Header1.Caption  = "Moe"
2189:         loc_oGrd2.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
2190:         loc_oGrd2.Column9.Header1.Caption  = "E"
2191:         loc_oGrd2.Column10.Header1.Caption = "Consumo"
2192:         loc_oGrd2.Column11.Header1.Caption = "Qtde."
2193:         loc_oGrd2.Column12.Header1.Caption = "Un"
2194:         loc_oGrd2.Column13.Header1.Caption = "Ord"

*-- Linhas 2229 a 2247:
2229:             .FontName    = "Courier New"
2230:             .FontSize    = 8
2231:             .RecordMark  = .F.
2232:             .DeleteMark  = .F.
2233:             .GridLines   = 3
2234:             .ReadOnly    = .T.
2235:             .RowHeight   = 17
2236:             .Themes      = .F.
2237:             .ColumnCount = 3
2238:             .Visible     = .T.
2239:         ENDWITH
2240: 
2241:         WITH loc_oGrd3.Column1
2242:             .Width     = 35
2243:             .Movable   = .F.
2244:             .Resizable = .F.
2245:             .ReadOnly  = .T.
2246:         ENDWITH
2247:         WITH loc_oGrd3.Column2

*-- Linhas 2259 a 2279:
2259:         ENDWITH
2260: 
2261:         loc_oGrd3.RecordSource = "cursor_4c_TotGrupo"
2262:         loc_oGrd3.Column1.ControlSource = "cursor_4c_TotGrupo.Grupo"
2263:         loc_oGrd3.Column2.ControlSource = "cursor_4c_TotGrupo.ValGrupo"
2264:         loc_oGrd3.Column3.ControlSource = "cursor_4c_TotGrupo.Moeda"
2265:         loc_oGrd3.Column1.Header1.Caption = "Grupo"
2266:         loc_oGrd3.Column2.Header1.Caption = "Total "
2267:         loc_oGrd3.Column3.Header1.Caption = "Moeda"
2268:         loc_oGrd3.Column1.Width = 35
2269:         loc_oGrd3.Column2.Width = 134
2270:         loc_oGrd3.Column3.Width = 37
2271: 
2272:         *-- ===================================================================
2273:         *-- CONTAINER cntMtPrima (top=511, left=752, w=242, h=108)
2274:         *-- Controles de montagem de descricao automatica
2275:         *-- ===================================================================
2276:         loc_oPg.AddObject("cnt_4c_MtPrima", "Container")
2277:         loc_oCnt = loc_oPg.cnt_4c_MtPrima
2278:         WITH loc_oCnt
2279:             .Top         = 511

*-- Linhas 3590 a 3608:
3590:             USE IN cursor_4c_Cmv
3591:         ENDIF
3592:         SET NULL OFF
3593:         CREATE CURSOR cursor_4c_Cmv ( ;
3594:             datas    C(7), ;
3595:             valcuss  N(10,2), ;
3596:             moedas   C(3))
3597: 
3598:         *-- ===================================================================
3599:         *-- LABELS
3600:         *-- ===================================================================
3601: 
3602:         *-- Say16: Grupo C.C.
3603:         loc_oPg.AddObject("lbl_4c_Say16", "Label")
3604:         WITH loc_oPg.lbl_4c_Say16
3605:             .Caption  = "Grupo C.C. :"
3606:             .Top      = 165
3607:             .Left     = 138
3608:             .Width    = 63

*-- Linhas 4215 a 4233:
4215:             .FontName    = "Tahoma"
4216:             .FontSize    = 8
4217:             .RecordMark  = .F.
4218:             .DeleteMark  = .F.
4219:             .GridLines   = 3
4220:             .ReadOnly    = .T.
4221:             .RowHeight   = 16
4222:             .ScrollBars  = 2
4223:             .Themes      = .F.
4224:             .ColumnCount = 3
4225:             .Visible     = .T.
4226:         ENDWITH
4227: 
4228:         *-- Cabecalhos ANTES do RecordSource
4229:         loc_oGrd.Column1.Header1.Caption = "Per" + CHR(237) + "odo"
4230:         loc_oGrd.Column2.Header1.Caption = "Valor Custo GR"
4231:         loc_oGrd.Column3.Header1.Caption = "Moe"
4232: 
4233:         *-- Larguras das colunas

*-- Linhas 4250 a 4271:
4250:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4251:         loc_oGrd.RecordSource = "cursor_4c_Cmv"
4252: 
4253:         *-- ControlSource APOS RecordSource (obrigatorio)
4254:         loc_oGrd.Column1.ControlSource = "cursor_4c_Cmv.datas"
4255:         loc_oGrd.Column2.ControlSource = "cursor_4c_Cmv.valcuss"
4256:         loc_oGrd.Column3.ControlSource = "cursor_4c_Cmv.moedas"
4257: 
4258:         *-- Reaplica larguras apos RecordSource (RecordSource pode resetar)
4259:         loc_oGrd.Column1.Width = 60
4260:         loc_oGrd.Column2.Width = 120
4261:         loc_oGrd.Column3.Width = 40
4262: 
4263:         *-- ===================================================================
4264:         *-- TEXTBOXES - Descricao ECF, Metal/Teor, Valor Estimado, IPPT/CST
4265:         *-- ===================================================================
4266: 
4267:         *-- getDescEcfs (txt_4c_DescEcfs): T:429, L:206, W:213, H:23
4268:         loc_oPg.AddObject("txt_4c_DescEcfs", "TextBox")
4269:         WITH loc_oPg.txt_4c_DescEcfs
4270:             .Value    = ""
4271:             .Top      = 429

*-- Linhas 4403 a 4432:
4403:             USE IN cursor_4c_CustoCompo
4404:         ENDIF
4405:         SET NULL OFF
4406:         CREATE CURSOR cursor_4c_CustoCompo ( ;
4407:             mats      C(14), dcompos C(40), unicompos C(3),  ;
4408:             pcompos   N(11,3), qtds N(8,3), totas N(11,3),   ;
4409:             moeds     C(3), obscompos C(10), etiqs C(1),     ;
4410:             qtscons   N(8,3), qtdcvs N(11,3), cunips C(3),   ;
4411:             CGrus     C(3), tipos C(20))
4412: 
4413:         *-- cursor_4c_TotGrupoCusto - totais por grupo custo (calculado)
4414:         IF USED("cursor_4c_TotGrupoCusto")
4415:             USE IN cursor_4c_TotGrupoCusto
4416:         ENDIF
4417:         CREATE CURSOR cursor_4c_TotGrupoCusto ( ;
4418:             Grupo     C(3), ValGrupo N(11,3), Moeda C(3))
4419: 
4420:         *-- ===================================================================
4421:         *-- COMBO cbo_4c_CmbTipos (cmbTipos: top=154, left=143, w=187, h=23)
4422:         *-- ===================================================================
4423:         loc_oPg.AddObject("cbo_4c_CmbTipos", "ComboBox")
4424:         WITH loc_oPg.cbo_4c_CmbTipos
4425:             .Top           = 154
4426:             .Left          = 143
4427:             .Width         = 187
4428:             .Height        = 23
4429:             .FontName      = "Tahoma"
4430:             .FontSize      = 8
4431:             .RowSourceType = 1
4432:             .RowSource     = ""

*-- Linhas 4466 a 4484:
4466:             .FontName    = "Tahoma"
4467:             .FontSize    = 8
4468:             .RecordMark  = .F.
4469:             .DeleteMark  = .F.
4470:             .GridLines   = 3
4471:             .ReadOnly    = .F.
4472:             .RowHeight   = 16
4473:             .ScrollBars  = 2
4474:             .Themes      = .F.
4475:             .ColumnCount = 12
4476:             .Visible     = .T.
4477:         ENDWITH
4478: 
4479:         *-- Coluna 1: Item (mats, w=108)
4480:         WITH loc_oGrd.Column1
4481:             .Width     = 108
4482:             .Movable   = .F.
4483:             .Resizable = .F.
4484:             .InputMask = "XXXXXXXXXXXXXX"

*-- Linhas 4552 a 4582:
4552:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4553:         loc_oGrd.RecordSource = "cursor_4c_CustoCompo"
4554: 
4555:         *-- ControlSource APOS RecordSource (obrigatorio)
4556:         loc_oGrd.Column1.ControlSource  = "cursor_4c_CustoCompo.mats"
4557:         loc_oGrd.Column2.ControlSource  = "cursor_4c_CustoCompo.dcompos"
4558:         loc_oGrd.Column3.ControlSource  = "cursor_4c_CustoCompo.unicompos"
4559:         loc_oGrd.Column4.ControlSource  = "cursor_4c_CustoCompo.pcompos"
4560:         loc_oGrd.Column5.ControlSource  = "cursor_4c_CustoCompo.qtds"
4561:         loc_oGrd.Column6.ControlSource  = "cursor_4c_CustoCompo.totas"
4562:         loc_oGrd.Column7.ControlSource  = "cursor_4c_CustoCompo.moeds"
4563:         loc_oGrd.Column8.ControlSource  = "cursor_4c_CustoCompo.obscompos"
4564:         loc_oGrd.Column9.ControlSource  = "cursor_4c_CustoCompo.etiqs"
4565:         loc_oGrd.Column10.ControlSource = "cursor_4c_CustoCompo.qtscons"
4566:         loc_oGrd.Column11.ControlSource = "cursor_4c_CustoCompo.qtdcvs"
4567:         loc_oGrd.Column12.ControlSource = "cursor_4c_CustoCompo.cunips"
4568: 
4569:         *-- Cabecalhos APOS RecordSource
4570:         loc_oGrd.Column1.Header1.Caption  = "Item"
4571:         loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
4572:         loc_oGrd.Column3.Header1.Caption  = "Un"
4573:         loc_oGrd.Column4.Header1.Caption  = "Valor"
4574:         loc_oGrd.Column5.Header1.Caption  = "Qtd"
4575:         loc_oGrd.Column6.Header1.Caption  = "Total"
4576:         loc_oGrd.Column7.Header1.Caption  = "Moe"
4577:         loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
4578:         loc_oGrd.Column9.Header1.Caption  = "Etiq"
4579:         loc_oGrd.Column10.Header1.Caption = "Consumo"
4580:         loc_oGrd.Column11.Header1.Caption = "Qtd"
4581:         loc_oGrd.Column12.Header1.Caption = "Un"
4582: 

*-- Linhas 4752 a 4770:
4752:             .FontName    = "Courier New"
4753:             .FontSize    = 8
4754:             .RecordMark  = .F.
4755:             .DeleteMark  = .F.
4756:             .GridLines   = 3
4757:             .ReadOnly    = .T.
4758:             .RowHeight   = 17
4759:             .Themes      = .F.
4760:             .ColumnCount = 3
4761:             .Visible     = .T.
4762:         ENDWITH
4763: 
4764:         WITH loc_oGrd2.Column1
4765:             .Width     = 35
4766:             .Movable   = .F.
4767:             .Resizable = .F.
4768:             .ReadOnly  = .T.
4769:         ENDWITH
4770:         WITH loc_oGrd2.Column2

*-- Linhas 4782 a 4802:
4782:         ENDWITH
4783: 
4784:         loc_oGrd2.RecordSource = "cursor_4c_TotGrupoCusto"
4785:         loc_oGrd2.Column1.ControlSource = "cursor_4c_TotGrupoCusto.Grupo"
4786:         loc_oGrd2.Column2.ControlSource = "cursor_4c_TotGrupoCusto.ValGrupo"
4787:         loc_oGrd2.Column3.ControlSource = "cursor_4c_TotGrupoCusto.Moeda"
4788:         loc_oGrd2.Column1.Header1.Caption = "Grp"
4789:         loc_oGrd2.Column2.Header1.Caption = "Total "
4790:         loc_oGrd2.Column3.Header1.Caption = "Moe"
4791:         loc_oGrd2.Column1.Width = 35
4792:         loc_oGrd2.Column2.Width = 134
4793:         loc_oGrd2.Column3.Width = 37
4794: 
4795:     ENDPROC
4796: 
4797:     *--------------------------------------------------------------------------
4798:     * ConfigurarPgPgDadosConsP - Aba "Cons. P." (Page5 de pgf_4c_DadosInternos)
4799:     * Grid grd_4c_GrdCons (9 cols) - RecordSource: crSigPrCpo
4800:     * Ordem visual: Mats | Dcompos | Qtds | UniCompos | Grupos | Dscgrp | Ordems | QtsCons | Cats
4801:     * par_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page5
4802:     *--------------------------------------------------------------------------

*-- Linhas 4817 a 4868:
4817:             USE IN cursor_4c_GrdCons
4818:         ENDIF
4819:         SET NULL OFF
4820:         CREATE CURSOR cursor_4c_GrdCons ( ;
4821:             Mats      C(14), ;
4822:             Dcompos   C(40), ;
4823:             Qtds      N(12,4), ;
4824:             UniCompos C(3), ;
4825:             Grupos    C(3), ;
4826:             Dscgrp    C(40), ;
4827:             Ordems    N(3,0), ;
4828:             QtsCons   N(12,4), ;
4829:             Cats      C(3))
4830: 
4831:         *-- cursor_4c_GrDTEMP - tempo por agrupamento (baseado em crSigProTp)
4832:         IF USED("cursor_4c_GrDTEMP")
4833:             USE IN cursor_4c_GrDTEMP
4834:         ENDIF
4835:         CREATE CURSOR cursor_4c_GrDTEMP ( ;
4836:             agrupas   C(3), ;
4837:             pertemps  N(12,3))
4838: 
4839:         *-- ===================================================================
4840:         *-- GRID grd_4c_GrdCons
4841:         *-- Original: top=155, left=6, w=987, h=362, RowHeight=17
4842:         *-- ===================================================================
4843:         loc_oPg.AddObject("grd_4c_GrdCons", "Grid")
4844:         loc_oGrd = loc_oPg.grd_4c_GrdCons
4845:         WITH loc_oGrd
4846:             .Top         = 155
4847:             .Left        = 6
4848:             .Width       = 987
4849:             .Height      = 362
4850:             .FontName    = "Tahoma"
4851:             .FontSize    = 8
4852:             .RecordMark  = .F.
4853:             .DeleteMark  = .F.
4854:             .GridLines   = 3
4855:             .ReadOnly    = .F.
4856:             .RowHeight   = 17
4857:             .ScrollBars  = 2
4858:             .Themes      = .F.
4859:             .ColumnCount = 9
4860:             .Visible     = .T.
4861:         ENDWITH
4862: 
4863:         *-- Col1: Componente/Mats (108px, ReadOnly)
4864:         WITH loc_oGrd.Column1
4865:             .Width     = 108
4866:             .Movable   = .F.
4867:             .Resizable = .F.
4868:             .ReadOnly  = .T.

*-- Linhas 4924 a 4951:
4924:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
4925:         loc_oGrd.RecordSource = "cursor_4c_GrdCons"
4926: 
4927:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
4928:         loc_oGrd.Column1.ControlSource = "cursor_4c_GrdCons.Mats"
4929:         loc_oGrd.Column2.ControlSource = "cursor_4c_GrdCons.Dcompos"
4930:         loc_oGrd.Column3.ControlSource = "cursor_4c_GrdCons.Qtds"
4931:         loc_oGrd.Column4.ControlSource = "cursor_4c_GrdCons.UniCompos"
4932:         loc_oGrd.Column5.ControlSource = "cursor_4c_GrdCons.Grupos"
4933:         loc_oGrd.Column6.ControlSource = "cursor_4c_GrdCons.Dscgrp"
4934:         loc_oGrd.Column7.ControlSource = "cursor_4c_GrdCons.Ordems"
4935:         loc_oGrd.Column8.ControlSource = "cursor_4c_GrdCons.QtsCons"
4936:         loc_oGrd.Column9.ControlSource = "cursor_4c_GrdCons.Cats"
4937: 
4938:         *-- Cabecalhos APOS RecordSource
4939:         loc_oGrd.Column1.Header1.Caption = "Componente"
4940:         loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4941:         loc_oGrd.Column3.Header1.Caption = "Qtde."
4942:         loc_oGrd.Column4.Header1.Caption = "Uni"
4943:         loc_oGrd.Column5.Header1.Caption = "Fase"
4944:         loc_oGrd.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
4945:         loc_oGrd.Column7.Header1.Caption = "Ord."
4946:         loc_oGrd.Column8.Header1.Caption = "Consumo"
4947:         loc_oGrd.Column9.Header1.Caption = "Cat."
4948: 
4949:         *-- Larguras re-aplicadas APOS RecordSource
4950:         loc_oGrd.Column1.Width = 108
4951:         loc_oGrd.Column2.Width = 223

*-- Linhas 4973 a 4991:
4973:             .FontName    = "Tahoma"
4974:             .FontSize    = 8
4975:             .RecordMark  = .T.
4976:             .DeleteMark  = .F.
4977:             .GridLines   = 3
4978:             .ReadOnly    = .T.
4979:             .RowHeight   = 17
4980:             .ScrollBars  = 2
4981:             .Themes      = .F.
4982:             .ColumnCount = 2
4983:             .Visible     = .T.
4984:         ENDWITH
4985: 
4986:         *-- Col1: Agrupamento/agrupas (80px, ReadOnly)
4987:         WITH loc_oGrd2.Column1
4988:             .Width     = 80
4989:             .Movable   = .F.
4990:             .Resizable = .F.
4991:             .ReadOnly  = .T.

*-- Linhas 5002 a 5022:
5002:         *-- RecordSource APOS ColumnCount
5003:         loc_oGrd2.RecordSource = "cursor_4c_GrDTEMP"
5004: 
5005:         *-- ControlSource APOS RecordSource
5006:         loc_oGrd2.Column1.ControlSource = "cursor_4c_GrDTEMP.agrupas"
5007:         loc_oGrd2.Column2.ControlSource = "cursor_4c_GrDTEMP.pertemps"
5008: 
5009:         *-- Cabecalhos APOS RecordSource
5010:         loc_oGrd2.Column1.Header1.Caption = "Agrupamento"
5011:         loc_oGrd2.Column2.Header1.Caption = "Tempo %"
5012: 
5013:         *-- Larguras re-aplicadas APOS RecordSource
5014:         loc_oGrd2.Column1.Width = 80
5015:         loc_oGrd2.Column2.Width = 60
5016: 
5017:         *-- ===================================================================
5018:         *-- LABEL lbl_4c_Say7 (Say7 "Qtde Componentes :": top=523, left=25, w=105, h=15)
5019:         *-- ===================================================================
5020:         loc_oPg.AddObject("lbl_4c_Say7", "Label")
5021:         WITH loc_oPg.lbl_4c_Say7
5022:             .Caption   = "Qtde Componentes : "

*-- Linhas 5118 a 5177:
5118:             USE IN cursor_4c_Fase
5119:         ENDIF
5120:         SET NULL OFF
5121:         CREATE CURSOR cursor_4c_Fase ( ;
5122:             Ordems    N(3,0), ;
5123:             Grupos    C(10), ;
5124:             Descrs    C(40), ;
5125:             UniPrdts  C(10), ;
5126:             TpMats    C(3), ;
5127:             FigProcs  M, ;
5128:             FkChaves  C(30), ;
5129:             GrpOrdem  C(12))
5130: 
5131:         *-- cursor_4c_Matrizes - matrizes do produto (baseado em crSigPrMtz)
5132:         *-- Ordem visual: CMats | Locals | QMatz
5133:         IF USED("cursor_4c_Matrizes")
5134:             USE IN cursor_4c_Matrizes
5135:         ENDIF
5136:         SET NULL OFF
5137:         CREATE CURSOR cursor_4c_Matrizes ( ;
5138:             CMats     C(14), ;
5139:             Locals    C(20), ;
5140:             QMatz     N(5,2), ;
5141:             CPros     C(14), ;
5142:             cIdChaves C(30), ;
5143:             DPros     C(40))
5144:         *-- Linha vazia placeholder (grdMatrizes sempre tem ao menos 1 linha)
5145:         INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
5146:             VALUES ("", "", 0, "", "", "")
5147: 
5148:         *-- ===================================================================
5149:         *-- GRID grd_4c_FasePro (GradFase: top=152, left=527, w=420, h=312, 5 cols)
5150:         *-- crSigCdPrf: Ordems N(3), Grupos C(10), Descrs C(40), UniPrdts C(10), TpMats C(3)
5151:         *-- ===================================================================
5152:         loc_oPg.AddObject("grd_4c_FasePro", "Grid")
5153:         loc_oGrd = loc_oPg.grd_4c_FasePro
5154:         WITH loc_oGrd
5155:             .Top         = 152
5156:             .Left        = 527
5157:             .Width       = 420
5158:             .Height      = 312
5159:             .FontName    = "Tahoma"
5160:             .FontSize    = 8
5161:             .RecordMark  = .F.
5162:             .DeleteMark  = .F.
5163:             .GridLines   = 3
5164:             .ReadOnly    = .F.
5165:             .RowHeight   = 17
5166:             .ScrollBars  = 2
5167:             .Themes      = .F.
5168:             .ColumnCount = 5
5169:             .Visible     = .T.
5170:         ENDWITH
5171: 
5172:         *-- Col1: Ordem/Ordems (40px)
5173:         WITH loc_oGrd.Column1
5174:             .Width     = 40
5175:             .Movable   = .F.
5176:             .Resizable = .F.
5177:         ENDWITH

*-- Linhas 5207 a 5230:
5207:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
5208:         loc_oGrd.RecordSource = "cursor_4c_Fase"
5209: 
5210:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
5211:         loc_oGrd.Column1.ControlSource = "cursor_4c_Fase.Ordems"
5212:         loc_oGrd.Column2.ControlSource = "cursor_4c_Fase.Grupos"
5213:         loc_oGrd.Column3.ControlSource = "cursor_4c_Fase.Descrs"
5214:         loc_oGrd.Column4.ControlSource = "cursor_4c_Fase.UniPrdts"
5215:         loc_oGrd.Column5.ControlSource = "cursor_4c_Fase.TpMats"
5216: 
5217:         *-- Cabecalhos APOS RecordSource
5218:         loc_oGrd.Column1.Header1.Caption = "Ordem"
5219:         loc_oGrd.Column2.Header1.Caption = "Fase"
5220:         loc_oGrd.Column3.Header1.Caption = "Utiliza" + CHR(231) + CHR(227) + "o"
5221:         loc_oGrd.Column4.Header1.Caption = "Uni. Produtiva"
5222:         loc_oGrd.Column5.Header1.Caption = "Material"
5223: 
5224:         *-- Larguras re-aplicadas APOS RecordSource
5225:         loc_oGrd.Column1.Width = 40
5226:         loc_oGrd.Column2.Width = 70
5227:         loc_oGrd.Column3.Width = 165
5228:         loc_oGrd.Column4.Width = 100
5229:         loc_oGrd.Column5.Width = 45
5230: 

*-- Linhas 5826 a 5844:
5826:             .FontName    = "Tahoma"
5827:             .FontSize    = 8
5828:             .RecordMark  = .F.
5829:             .DeleteMark  = .F.
5830:             .GridLines   = 3
5831:             .ReadOnly    = .F.
5832:             .RowHeight   = 17
5833:             .ScrollBars  = 2
5834:             .Themes      = .F.
5835:             .ColumnCount = 3
5836:             .Visible     = .T.
5837:         ENDWITH
5838: 
5839:         *-- Col1: Matriz/CMats (80px, editavel com lookup)
5840:         WITH loc_oGrd2.Column1
5841:             .Width     = 80
5842:             .Movable   = .F.
5843:             .Resizable = .F.
5844:             .Sparse    = .F.

*-- Linhas 5860 a 5881:
5860:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
5861:         loc_oGrd2.RecordSource = "cursor_4c_Matrizes"
5862: 
5863:         *-- ControlSource APOS RecordSource
5864:         loc_oGrd2.Column1.ControlSource = "cursor_4c_Matrizes.CMats"
5865:         loc_oGrd2.Column2.ControlSource = "cursor_4c_Matrizes.Locals"
5866:         loc_oGrd2.Column3.ControlSource = "cursor_4c_Matrizes.QMatz"
5867: 
5868:         *-- Cabecalhos APOS RecordSource
5869:         loc_oGrd2.Column1.Header1.Caption = "Matriz"
5870:         loc_oGrd2.Column2.Header1.Caption = "Local"
5871:         loc_oGrd2.Column3.Header1.Caption = "Qtde"
5872: 
5873:         *-- Larguras re-aplicadas APOS RecordSource
5874:         loc_oGrd2.Column1.Width = 80
5875:         loc_oGrd2.Column2.Width = 116
5876:         loc_oGrd2.Column3.Width = 50
5877: 
5878:         *-- BINDEVENT grd_4c_Matrizes
5879:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdMatrizesAfterRowColChange")
5880:         BINDEVENT(loc_oGrd2.Column1.Text1, "Valid", THIS, "MatrizGrdCol1Valid")
5881: 

*-- Linhas 5973 a 6024:
5973:             USE IN cursor_4c_Tarefas
5974:         ENDIF
5975:         SET NULL OFF
5976:         CREATE CURSOR cursor_4c_Tarefas ( ;
5977:             DtInis      T, ;
5978:             DtFims      T, ;
5979:             Usuars      C(10), ;
5980:             Tarefas     C(10), ;
5981:             ObsTarefas  M, ;
5982:             CPros       C(14), ;
5983:             pkChaves    C(30))
5984: 
5985:         *-- cursor_4c_Arquivos - arquivos do designer (baseado em crSigPrArq)
5986:         IF USED("cursor_4c_Arquivos")
5987:             USE IN cursor_4c_Arquivos
5988:         ENDIF
5989:         SET NULL OFF
5990:         CREATE CURSOR cursor_4c_Arquivos ( ;
5991:             Arquivos    C(254), ;
5992:             CPros       C(14), ;
5993:             pkChaves    C(30))
5994: 
5995:         *-- ===================================================================
5996:         *-- GRID grd_4c_Designer (grdDesigner: top=160, left=10, w=495, h=238, 4 cols)
5997:         *-- crSigPrTar: DtInis T | DtFims T | Usuars C(10) | Tarefas C(10)
5998:         *-- ===================================================================
5999:         loc_oPg.AddObject("grd_4c_Designer", "Grid")
6000:         loc_oGrd = loc_oPg.grd_4c_Designer
6001:         WITH loc_oGrd
6002:             .Top         = 160
6003:             .Left        = 10
6004:             .Width       = 495
6005:             .Height      = 238
6006:             .FontName    = "Tahoma"
6007:             .FontSize    = 8
6008:             .RecordMark  = .F.
6009:             .DeleteMark  = .F.
6010:             .GridLines   = 3
6011:             .ReadOnly    = .F.
6012:             .RowHeight   = 17
6013:             .ScrollBars  = 2
6014:             .Themes      = .F.
6015:             .ColumnCount = 4
6016:             .Visible     = .T.
6017:         ENDWITH
6018: 
6019:         *-- Col1: Data de Inicio/DtInis (120px, ReadOnly)
6020:         WITH loc_oGrd.Column1
6021:             .Width     = 120
6022:             .Movable   = .F.
6023:             .Resizable = .F.
6024:             .ReadOnly  = .T.

*-- Linhas 6048 a 6070:
6048:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
6049:         loc_oGrd.RecordSource = "cursor_4c_Tarefas"
6050: 
6051:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
6052:         loc_oGrd.Column1.ControlSource = "cursor_4c_Tarefas.DtInis"
6053:         loc_oGrd.Column2.ControlSource = "cursor_4c_Tarefas.DtFims"
6054:         loc_oGrd.Column3.ControlSource = "cursor_4c_Tarefas.Usuars"
6055:         loc_oGrd.Column4.ControlSource = "cursor_4c_Tarefas.Tarefas"
6056: 
6057:         *-- Cabecalhos APOS RecordSource
6058:         loc_oGrd.Column1.Header1.Caption = "Data de In" + CHR(237) + "cio"
6059:         loc_oGrd.Column2.Header1.Caption = "Data de Conclus" + CHR(227) + "o"
6060:         loc_oGrd.Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
6061:         loc_oGrd.Column4.Header1.Caption = "Tarefa"
6062: 
6063:         *-- Larguras re-aplicadas APOS RecordSource
6064:         loc_oGrd.Column1.Width = 120
6065:         loc_oGrd.Column2.Width = 120
6066:         loc_oGrd.Column3.Width = 100
6067:         loc_oGrd.Column4.Width = 155
6068: 
6069:         *-- BINDEVENT grd_4c_Designer
6070:         BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GrdDesignerAfterRowColChange")

*-- Linhas 6103 a 6121:
6103:             .ScrollBars    = 2
6104:             .ReadOnly      = .F.
6105:             .Themes        = .F.
6106:             .ControlSource = "cursor_4c_Tarefas.ObsTarefas"
6107:             .Visible       = .T.
6108:         ENDWITH
6109: 
6110:         *-- ===================================================================
6111:         *-- COMMANDBUTTON cmd_4c_BtnIniTarefa (btnIniTarefa: top=161, left=509, w=42, h=42)
6112:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6113:         *-- Click: Valida tarefa aberta + insere nova linha em cursor_4c_Tarefas
6114:         *-- ===================================================================
6115:         loc_oPg.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
6116:         WITH loc_oPg.cmd_4c_BtnIniTarefa
6117:             .Top             = 161
6118:             .Left            = 509
6119:             .Width           = 42
6120:             .Height          = 42
6121:             .Caption         = ""

*-- Linhas 6169 a 6223:
6169:             .FontName    = "Tahoma"
6170:             .FontSize    = 8
6171:             .RecordMark  = .F.
6172:             .DeleteMark  = .F.
6173:             .GridLines   = 3
6174:             .ReadOnly    = .F.
6175:             .RowHeight   = 17
6176:             .ScrollBars  = 2
6177:             .Themes      = .F.
6178:             .ColumnCount = 1
6179:             .Visible     = .T.
6180:         ENDWITH
6181: 
6182:         *-- Col1: Arquivos (495px, editavel)
6183:         WITH loc_oGrd2.Column1
6184:             .Width     = 495
6185:             .Movable   = .F.
6186:             .Resizable = .F.
6187:             .Sparse    = .F.
6188:         ENDWITH
6189: 
6190:         *-- RecordSource APOS ColumnCount (NUNCA dentro de WITH)
6191:         loc_oGrd2.RecordSource = "cursor_4c_Arquivos"
6192: 
6193:         *-- ControlSource APOS RecordSource (obrigatorio re-aplicar apos RecordSource)
6194:         loc_oGrd2.Column1.ControlSource = "cursor_4c_Arquivos.Arquivos"
6195: 
6196:         *-- Cabecalho APOS RecordSource
6197:         loc_oGrd2.Column1.Header1.Caption = "Arquivos Para Designer"
6198: 
6199:         *-- Largura re-aplicada APOS RecordSource
6200:         loc_oGrd2.Column1.Width = 495
6201: 
6202:         *-- BINDEVENT grd_4c_Arquivos
6203:         BINDEVENT(loc_oGrd2, "AfterRowColChange", THIS, "GrdArquivosAfterRowColChange")
6204: 
6205:         *-- ===================================================================
6206:         *-- COMMANDBUTTON cmd_4c_BtnInsArqs (btnInsArqs: top=416, left=509, w=42, h=42)
6207:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6208:         *-- Click: GetFile -> Insert Into cursor_4c_Arquivos
6209:         *-- ===================================================================
6210:         loc_oPg.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
6211:         WITH loc_oPg.cmd_4c_BtnInsArqs
6212:             .Top             = 416
6213:             .Left            = 509
6214:             .Width           = 42
6215:             .Height          = 42
6216:             .Caption         = ""
6217:             .Picture         = gc_4c_CaminhoIcones + "geral_adicao_26.jpg"
6218:             .PicturePosition = 13
6219:             .ToolTipText     = "Inserir Arquivo"
6220:             .FontName        = "Tahoma"
6221:             .FontSize        = 8
6222:             .Themes          = .F.
6223:             .SpecialEffect   = 0

*-- Linhas 6229 a 6247:
6229:         *-- ===================================================================
6230:         *-- COMMANDBUTTON cmd_4c_BtnExcArqs (btnExcArqs: top=458, left=509, w=42, h=42)
6231:         *-- When: InList(pcEscolha, INSERIR, ALTERAR)
6232:         *-- Click: Delete from cursor_4c_Arquivos
6233:         *-- ===================================================================
6234:         loc_oPg.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
6235:         WITH loc_oPg.cmd_4c_BtnExcArqs
6236:             .Top             = 458
6237:             .Left            = 509
6238:             .Width           = 42
6239:             .Height          = 42
6240:             .Caption         = ""
6241:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
6242:             .PicturePosition = 13
6243:             .ToolTipText     = "Excluir Arquivo"
6244:             .FontName        = "Tahoma"
6245:             .FontSize        = 8
6246:             .Themes          = .F.
6247:             .SpecialEffect   = 0

*-- Linhas 6337 a 6374:
6337:             IF EMPTY(loc_cCodigo)
6338:                 loc_lResultado = loc_lResultado
6339:             ENDIF
6340:             loc_lcSQL = "SELECT CodCads, DesCads FROM SigCdCad WHERE CodCads = " + EscaparSQL(loc_cCodigo)
6341:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTarefas") <= 0 OR EOF("cursor_4c_ValTarefas")
6342:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6343:                 loc_oLookup.mAddColuna("CodCads", "C" + CHR(243) + "digo", 80)
6344:                 loc_oLookup.mAddColuna("DesCads", "Descri" + CHR(231) + CHR(227) + "o", 220)
6345:                 loc_oLookup.cTabela     = "SigCdCad"
6346:                 loc_oLookup.cCampoChave = "CodCads"
6347:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6348:                 loc_oLookup.Show()
6349:                 IF loc_oLookup.this_lSelecionou
6350:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6351:                 ELSE
6352:                     loc_cCodigo = ""
6353:                 ENDIF
6354:             ENDIF
6355:             IF USED("cursor_4c_ValTarefas")
6356:                 USE IN cursor_4c_ValTarefas
6357:             ENDIF
6358:             IF USED("cursor_4c_Tarefas") AND !EOF("cursor_4c_Tarefas")
6359:                 SELECT cursor_4c_Tarefas
6360:                 REPLACE Tarefas WITH PADR(loc_cCodigo, 10) IN cursor_4c_Tarefas
6361:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6362:             ENDIF
6363:         CATCH TO loc_oErro
6364:             MsgErro(loc_oErro.Message, "Erro")
6365:         ENDTRY
6366:         RETURN loc_lResultado
6367:     ENDPROC
6368: 
6369:     *--------------------------------------------------------------------------
6370:     * GrdArquivosAfterRowColChange - Handler AfterRowColChange do grd_4c_Arquivos
6371:     * Exibe preview de imagem se arquivo for JPG/ICO/BMP/JPEG
6372:     *--------------------------------------------------------------------------
6373:     PROCEDURE GrdArquivosAfterRowColChange(par_nColIndex)
6374:         LOCAL loc_lcArq, loc_oPg, loc_nPonto

*-- Linhas 6406 a 6450:
6406:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Designer
6407: 
6408:             *-- Validar: nao pode ter tarefa aberta (DtFims vazia) para este usuario
6409:             SELECT cursor_4c_Tarefas
6410:             GO TOP IN cursor_4c_Tarefas
6411:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(DtFims)
6412:             IF !EOF("cursor_4c_Tarefas")
6413:                 MsgAviso("Existe Uma Tarefa N" + CHR(227) + "o Encerrada Para Esse Usu" + CHR(225) + "rio!!!")
6414:                 loc_oGrd.Column4.SetFocus()
6415:                 loc_lResultado = loc_lResultado
6416:             ENDIF
6417: 
6418:             *-- Validar: nao pode ter tarefa com codigo vazio para este usuario
6419:             SELECT cursor_4c_Tarefas
6420:             GO TOP IN cursor_4c_Tarefas
6421:             LOCATE FOR ALLTRIM(Usuars) = ALLTRIM(gc_4c_UsuarioLogado) AND EMPTY(Tarefas)
6422:             IF !EOF("cursor_4c_Tarefas")
6423:                 MsgAviso("Existe Uma Tarefa Ainda N" + CHR(227) + "o Informada!!!")
6424:                 loc_oGrd.Column4.SetFocus()
6425:                 loc_lResultado = loc_lResultado
6426:             ENDIF
6427: 
6428:             *-- Inserir nova linha com DtInis = agora, DtFims = vazio ({})
6429:             loc_tDataHora = DATETIME()
6430:             INSERT INTO cursor_4c_Tarefas (DtInis, DtFims, Usuars, Tarefas, CPros, pkChaves) ;
6431:                 VALUES (loc_tDataHora, {}, ;
6432:                         PADR(gc_4c_UsuarioLogado, 10), PADR("", 10), ;
6433:                         PADR(THIS.this_oBusinessObject.this_cCpros, 14), "")
6434: 
6435:             SELECT cursor_4c_Tarefas
6436:             GO BOTTOM IN cursor_4c_Tarefas
6437:             loc_oGrd.Refresh()
6438:             loc_oGrd.Column4.SetFocus()
6439:             loc_lResultado = .T.
6440:         CATCH TO loc_oErro
6441:             MsgErro(loc_oErro.Message, "Erro")
6442:         ENDTRY
6443:         RETURN loc_lResultado
6444:     ENDPROC
6445: 
6446:     *--------------------------------------------------------------------------
6447:     * BtnFimTarefaClick - Finaliza tarefa corrente no grd_4c_Designer
6448:     * Valida: tarefa pertence ao usuario + nao esta ja finalizada
6449:     *--------------------------------------------------------------------------
6450:     PROCEDURE BtnFimTarefaClick()

*-- Linhas 6472 a 6512:
6472: 
6473:             *-- Registrar data/hora de finalizacao
6474:             loc_tDataHora = DATETIME()
6475:             SELECT cursor_4c_Tarefas
6476:             REPLACE DtFims WITH loc_tDataHora IN cursor_4c_Tarefas
6477: 
6478:             loc_oGrd.Refresh()
6479:             loc_lResultado = .T.
6480:         CATCH TO loc_oErro
6481:             MsgErro(loc_oErro.Message, "Erro")
6482:         ENDTRY
6483:         RETURN loc_lResultado
6484:     ENDPROC
6485: 
6486:     *--------------------------------------------------------------------------
6487:     * BtnInsArqsClick - Insere arquivo no grd_4c_Arquivos via dialog GetFile
6488:     *--------------------------------------------------------------------------
6489:     PROCEDURE BtnInsArqsClick()
6490:         LOCAL loc_lResultado, loc_lcArq, loc_oGrd
6491:         loc_lResultado = .F.
6492:         TRY
6493:             loc_oGrd  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6494:             loc_lcArq = GETFILE("", "Selecione o Arquivo", "Selecione o Arquivo", 0, ;
6495:                 "Sele" + CHR(231) + CHR(227) + "o de Arquivos")
6496:             IF !EMPTY(loc_lcArq)
6497:                 INSERT INTO cursor_4c_Arquivos (CPros, pkChaves, Arquivos) ;
6498:                     VALUES (PADR(THIS.this_oBusinessObject.this_cCpros, 14), "", UPPER(loc_lcArq))
6499:                 loc_oGrd.Refresh()
6500:             ENDIF
6501:             loc_lResultado = .T.
6502:         CATCH TO loc_oErro
6503:             MsgErro(loc_oErro.Message, "Erro")
6504:         ENDTRY
6505:         RETURN loc_lResultado
6506:     ENDPROC
6507: 
6508:     *--------------------------------------------------------------------------
6509:     * BtnOpnArqsClick - Abre arquivo selecionado no grd_4c_Arquivos com Shell
6510:     *--------------------------------------------------------------------------
6511:     PROCEDURE BtnOpnArqsClick()
6512:         LOCAL loc_lResultado, loc_lcArq, loc_oApp

*-- Linhas 6541 a 6560:
6541:             ENDIF
6542:             loc_oGrd = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page7.grd_4c_Arquivos
6543:             IF !EMPTY(cursor_4c_Arquivos.Arquivos)
6544:                 SELECT cursor_4c_Arquivos
6545:                 DELETE IN cursor_4c_Arquivos
6546:                 IF !EOF("cursor_4c_Arquivos")
6547:                     SKIP IN cursor_4c_Arquivos
6548:                 ENDIF
6549:                 IF EOF("cursor_4c_Arquivos")
6550:                     GO BOTTOM IN cursor_4c_Arquivos
6551:                 ENDIF
6552:                 PACK IN cursor_4c_Arquivos
6553:             ENDIF
6554:             loc_oGrd.Refresh()
6555:             loc_lResultado = .T.
6556:         CATCH TO loc_oErro
6557:             MsgErro(loc_oErro.Message, "Erro")
6558:         ENDTRY
6559:         RETURN loc_lResultado
6560:     ENDPROC

*-- Linhas 6630 a 6650:
6630:                 loc_oPage.img_4c_ImgBorracha.Picture = ""
6631:                 loc_oPage.img_4c_ImgBorracha.Visible = .F.
6632:                 IF !EMPTY(cursor_4c_Matrizes.CMats)
6633:                     loc_lcSQL = "SELECT FigProcs FROM SigCdPro WHERE CPros = '" + ;
6634:                         EscaparSQL(ALLTRIM(cursor_4c_Matrizes.CMats))
6635:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_BorrachaImg") > 0
6636:                         IF !EOF("cursor_4c_BorrachaImg")
6637:                             IF !EMPTY(cursor_4c_BorrachaImg.FigProcs) AND !ISNULL(cursor_4c_BorrachaImg.FigProcs)
6638:                                 IF STRTOFILE(cursor_4c_BorrachaImg.FigProcs, loc_lcArquivo) > 0
6639:                                     loc_oPage.img_4c_ImgBorracha.Visible = .T.
6640:                                     loc_oPage.img_4c_ImgBorracha.Picture = loc_lcArquivo
6641:                                 ENDIF
6642:                             ENDIF
6643:                         ENDIF
6644:                         IF USED("cursor_4c_BorrachaImg")
6645:                             USE IN cursor_4c_BorrachaImg
6646:                         ENDIF
6647:                     ENDIF
6648:                 ENDIF
6649:                 loc_oPage.grd_4c_Matrizes.Refresh()
6650:             ENDIF

*-- Linhas 6691 a 6709:
6691:             IF !EMPTY(loc_lcFigura)
6692:                 loc_lcArquivo = SYS(2023) + "\" + go_4c_Sistema.Sys2015Tmp + SYS(2015) + ".jpg"
6693:                 CLEAR RESOURCES
6694:                 SELECT cursor_4c_Fase
6695:                 REPLACE FigProcs WITH FILETOSTR(loc_lcFigura) IN cursor_4c_Fase
6696:                 IF STRTOFILE(cursor_4c_Fase.FigProcs, loc_lcArquivo) > 0
6697:                     loc_oPage.img_4c_ImgFigJpg.Visible = .T.
6698:                     loc_oPage.img_4c_ImgFigJpg.Picture = loc_lcArquivo
6699:                 ENDIF
6700:             ENDIF
6701:         CATCH TO loc_oErro
6702:             MsgErro(loc_oErro.Message, "Erro")
6703:         ENDTRY
6704:     ENDPROC
6705: 
6706:     *--------------------------------------------------------------------------
6707:     * CmdgFigCamClick - Captura foto via camera (reutiliza logica de GetPict)
6708:     *--------------------------------------------------------------------------
6709:     PROCEDURE CmdgFigCamClick()

*-- Linhas 6721 a 6755:
6721:                 loc_lResultado = loc_lResultado
6722:             ENDIF
6723:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6724:             SELECT cursor_4c_Fase
6725:             IF !EOF("cursor_4c_Fase")
6726:                 IF EMPTY(cursor_4c_Fase.Grupos)
6727:                     loc_oPage.grd_4c_FasePro.SetFocus()
6728:                     loc_lResultado = loc_lResultado
6729:                 ENDIF
6730:                 loc_nOrdem = cursor_4c_Fase.Ordems
6731:             ELSE
6732:                 loc_nOrdem = 0
6733:             ENDIF
6734:             *-- Incrementa ordens dos registros apos o atual
6735:             SELECT cursor_4c_Fase
6736:             SCAN FOR Ordems > loc_nOrdem
6737:                 REPLACE Ordems WITH cursor_4c_Fase.Ordems + 1 IN cursor_4c_Fase
6738:             ENDSCAN
6739:             *-- Insere nova linha com ordem logo apos o atual
6740:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6741:                 VALUES (loc_nOrdem + 1, "", "", "", "", "")
6742:             GO TOP IN cursor_4c_Fase
6743:             LOCATE FOR Ordems = loc_nOrdem + 1 AND EMPTY(Grupos)
6744:             loc_oPage.grd_4c_FasePro.Refresh()
6745:             loc_oPage.grd_4c_FasePro.SetFocus()
6746:             loc_lResultado = .T.
6747:         CATCH TO loc_oErro
6748:             MsgErro(loc_oErro.Message, "Erro")
6749:         ENDTRY
6750:         RETURN loc_lResultado
6751:     ENDPROC
6752: 
6753:     *--------------------------------------------------------------------------
6754:     * FaseExcluirClick - Exclui linha atual do grd_4c_FasePro
6755:     *--------------------------------------------------------------------------

*-- Linhas 6761 a 6780:
6761:                 loc_lResultado = loc_lResultado
6762:             ENDIF
6763:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6764:             SELECT cursor_4c_Fase
6765:             DELETE IN cursor_4c_Fase
6766:             IF !EOF("cursor_4c_Fase")
6767:                 SKIP IN cursor_4c_Fase
6768:             ENDIF
6769:             IF EOF("cursor_4c_Fase")
6770:                 GO BOTTOM IN cursor_4c_Fase
6771:             ENDIF
6772:             PACK IN cursor_4c_Fase
6773:             loc_oPage.grd_4c_FasePro.Refresh()
6774:             loc_oPage.grd_4c_FasePro.SetFocus()
6775:             loc_oPage.grd_4c_FasePro.Column2.SetFocus()
6776:             loc_lResultado = .T.
6777:         CATCH TO loc_oErro
6778:             MsgErro(loc_oErro.Message, "Erro")
6779:         ENDTRY
6780:         RETURN loc_lResultado

*-- Linhas 6791 a 6816:
6791:                 loc_lResultado = loc_lResultado
6792:             ENDIF
6793:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
6794:             SELECT cursor_4c_Fase
6795:             IF EOF("cursor_4c_Fase") OR BOF("cursor_4c_Fase")
6796:                 loc_oPage.grd_4c_FasePro.SetFocus()
6797:                 loc_lResultado = loc_lResultado
6798:             ENDIF
6799:             loc_nOrdem = cursor_4c_Fase.Ordems
6800:             *-- Insere linha alternativa com mesma ordem (alternativa ao atual)
6801:             INSERT INTO cursor_4c_Fase (Ordems, Grupos, Descrs, UniPrdts, TpMats, FkChaves) ;
6802:                 VALUES (loc_nOrdem, "", "", "", "", "")
6803:             GO TOP IN cursor_4c_Fase
6804:             LOCATE FOR Ordems = loc_nOrdem AND EMPTY(Grupos)
6805:             loc_oPage.grd_4c_FasePro.Refresh()
6806:             loc_oPage.grd_4c_FasePro.SetFocus()
6807:             loc_lResultado = .T.
6808:         CATCH TO loc_oErro
6809:             MsgErro(loc_oErro.Message, "Erro")
6810:         ENDTRY
6811:         RETURN loc_lResultado
6812:     ENDPROC
6813: 
6814:     *--------------------------------------------------------------------------
6815:     * CmdFichaClick - Abre Ficha Tecnica do produto
6816:     *--------------------------------------------------------------------------

*-- Linhas 6839 a 6888:
6839:             IF EMPTY(loc_cCodigo)
6840:                 loc_lResultado = loc_lResultado
6841:             ENDIF
6842:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6843:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") <= 0 OR EOF("cursor_4c_ValGcr")
6844:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6845:                 loc_oLookup.mAddColuna("Codigos", "C" + CHR(243) + "digo",       60)
6846:                 loc_oLookup.mAddColuna("Descrs",  "Descri" + CHR(231) + CHR(227) + "o", 200)
6847:                 loc_oLookup.cTabela     = "SigCdGcr"
6848:                 loc_oLookup.cCampoChave = "Codigos"
6849:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6850:                 loc_oLookup.Show()
6851:                 IF loc_oLookup.this_lSelecionou
6852:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6853:                     loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
6854:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGcr") > 0 AND !EOF("cursor_4c_ValGcr")
6855:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
6856:                     ELSE
6857:                         loc_cDescr = ""
6858:                     ENDIF
6859:                 ELSE
6860:                     loc_cCodigo = ""
6861:                     loc_cDescr  = ""
6862:                 ENDIF
6863:                 IF USED("cursor_4c_ValGcr")
6864:                     USE IN cursor_4c_ValGcr
6865:                 ENDIF
6866:             ELSE
6867:                 loc_cDescr = ALLTRIM(NVL(cursor_4c_ValGcr.Descrs, ""))
6868:                 IF USED("cursor_4c_ValGcr")
6869:                     USE IN cursor_4c_ValGcr
6870:                 ENDIF
6871:             ENDIF
6872:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6873:                 SELECT cursor_4c_Fase
6874:                 REPLACE Grupos WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6875:                 REPLACE Descrs WITH PADR(loc_cDescr,  40) IN cursor_4c_Fase
6876:                 loc_oGrd.Column2.Text1.Value = loc_cCodigo
6877:                 loc_oGrd.Column3.Text1.Value = loc_cDescr
6878:             ENDIF
6879:         CATCH TO loc_oErro
6880:             MsgErro(loc_oErro.Message, "Erro")
6881:         ENDTRY
6882:         RETURN loc_lResultado
6883:     ENDPROC
6884: 
6885:     *--------------------------------------------------------------------------
6886:     * FaseGrdCol4Valid - Valid do Column4 (Uni. Produtiva/UniPrdts) do grd_4c_FasePro
6887:     * Lookup: SigCdUpd (UniPrdts) filtrado pelo Grupo atual
6888:     *--------------------------------------------------------------------------

*-- Linhas 6900 a 6989:
6900:                 loc_cGrupo = ALLTRIM(cursor_4c_Fase.Grupos)
6901:             ENDIF
6902:             IF !EMPTY(loc_cGrupo)
6903:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd WHERE Codigos = " + EscaparSQL(loc_cGrupo)
6904:             ELSE
6905:                 loc_lcSQL = "SELECT UniPrdts FROM SigCdUpd"
6906:             ENDIF
6907:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValUpd") <= 0
6908:                 IF USED("cursor_4c_ValUpd")
6909:                     USE IN cursor_4c_ValUpd
6910:                 ENDIF
6911:                 loc_lResultado = loc_lResultado
6912:             ENDIF
6913:             SELECT cursor_4c_ValUpd
6914:             LOCATE FOR ALLTRIM(UniPrdts) = loc_cCodigo
6915:             IF EOF("cursor_4c_ValUpd")
6916:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6917:                 loc_oLookup.mAddColuna("UniPrdts", "Uni. Produtiva", 120)
6918:                 loc_oLookup.cTabela     = "SigCdUpd"
6919:                 loc_oLookup.cCampoChave = "UniPrdts"
6920:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6921:                 loc_oLookup.Show()
6922:                 IF loc_oLookup.this_lSelecionou
6923:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6924:                 ELSE
6925:                     loc_cCodigo = ""
6926:                 ENDIF
6927:             ENDIF
6928:             IF USED("cursor_4c_ValUpd")
6929:                 USE IN cursor_4c_ValUpd
6930:             ENDIF
6931:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6932:                 SELECT cursor_4c_Fase
6933:                 REPLACE UniPrdts WITH PADR(loc_cCodigo, 10) IN cursor_4c_Fase
6934:                 loc_oGrd.Column4.Text1.Value = loc_cCodigo
6935:             ENDIF
6936:         CATCH TO loc_oErro
6937:             MsgErro(loc_oErro.Message, "Erro")
6938:         ENDTRY
6939:         RETURN loc_lResultado
6940:     ENDPROC
6941: 
6942:     *--------------------------------------------------------------------------
6943:     * FaseGrdCol5Valid - Valid do Column5 (Material/TpMats) do grd_4c_FasePro
6944:     * Lookup: SigOpOpt (Cods / Descs)
6945:     *--------------------------------------------------------------------------
6946:     PROCEDURE FaseGrdCol5Valid(par_nColIndex)
6947:         LOCAL loc_lResultado, loc_oLookup, loc_oGrd, loc_cCodigo, loc_lcSQL
6948:         loc_lResultado = .T.
6949:         TRY
6950:             loc_oGrd    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4.grd_4c_FasePro
6951:             loc_cCodigo = ALLTRIM(NVL(loc_oGrd.Column5.Text1.Value, ""))
6952:             IF EMPTY(loc_cCodigo)
6953:                 loc_lResultado = loc_lResultado
6954:             ENDIF
6955:             loc_lcSQL = "SELECT Cods, Descs FROM SigOpOpt WHERE Cods = " + EscaparSQL(loc_cCodigo)
6956:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOpt") <= 0 OR EOF("cursor_4c_ValOpt")
6957:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
6958:                 loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
6959:                 loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
6960:                 loc_oLookup.cTabela     = "SigOpOpt"
6961:                 loc_oLookup.cCampoChave = "Cods"
6962:                 loc_oLookup.cFiltroIni  = loc_cCodigo
6963:                 loc_oLookup.Show()
6964:                 IF loc_oLookup.this_lSelecionou
6965:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
6966:                 ELSE
6967:                     loc_cCodigo = ""
6968:                 ENDIF
6969:             ENDIF
6970:             IF USED("cursor_4c_ValOpt")
6971:                 USE IN cursor_4c_ValOpt
6972:             ENDIF
6973:             IF USED("cursor_4c_Fase") AND !EOF("cursor_4c_Fase")
6974:                 SELECT cursor_4c_Fase
6975:                 REPLACE TpMats WITH PADR(loc_cCodigo, 3) IN cursor_4c_Fase
6976:                 loc_oGrd.Column5.Text1.Value = loc_cCodigo
6977:             ENDIF
6978:             loc_oGrd.Refresh()
6979:         CATCH TO loc_oErro
6980:             MsgErro(loc_oErro.Message, "Erro")
6981:         ENDTRY
6982:         RETURN loc_lResultado
6983:     ENDPROC
6984: 
6985:     *--------------------------------------------------------------------------
6986:     * ValidarAcabamento - LostFocus do txt_4c_CodAcb
6987:     * Lookup: SigCdAca (Cods / Descrs) -> preenche txt_4c_Dacb
6988:     *--------------------------------------------------------------------------
6989:     PROCEDURE ValidarAcabamento()

*-- Linhas 6996 a 7026:
6996:                 loc_oPage.txt_4c_Dacb.Value = ""
6997:                 loc_lResultado = loc_lResultado
6998:             ENDIF
6999:             loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7000:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") <= 0 OR EOF("cursor_4c_ValAca")
7001:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7002:                 loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
7003:                 loc_oLookup.mAddColuna("Descrs", "Descri" + CHR(231) + CHR(227) + "o", 200)
7004:                 loc_oLookup.cTabela     = "SigCdAca"
7005:                 loc_oLookup.cCampoChave = "Cods"
7006:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7007:                 loc_oLookup.Show()
7008:                 IF loc_oLookup.this_lSelecionou
7009:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7010:                     loc_lcSQL = "SELECT Cods, Descrs FROM SigCdAca WHERE Cods = " + EscaparSQL(loc_cCodigo)
7011:                     IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAca") > 0 AND !EOF("cursor_4c_ValAca")
7012:                         loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7013:                     ELSE
7014:                         loc_cDescr = ""
7015:                     ENDIF
7016:                 ELSE
7017:                     loc_cCodigo = ""
7018:                     loc_cDescr  = ""
7019:                 ENDIF
7020:             ELSE
7021:                 loc_cDescr = ALLTRIM(NVL(cursor_4c_ValAca.Descrs, ""))
7022:             ENDIF
7023:             IF USED("cursor_4c_ValAca")
7024:                 USE IN cursor_4c_ValAca
7025:             ENDIF
7026:             loc_oPage.txt_4c_CodAcb.Value = loc_cCodigo

*-- Linhas 7044 a 7064:
7044:             IF EMPTY(loc_cValor)
7045:                 loc_lResultado = loc_lResultado
7046:             ENDIF
7047:             loc_lcSQL = "SELECT conquilhas FROM SigCdCnq GROUP BY conquilhas"
7048:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCnq") > 0
7049:                 SELECT cursor_4c_ValCnq
7050:                 LOCATE FOR ALLTRIM(conquilhas) = loc_cValor
7051:                 IF EOF("cursor_4c_ValCnq")
7052:                     loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7053:                     loc_oLookup.mAddColuna("conquilhas", "Conquilhas", 120)
7054:                     loc_oLookup.cTabela     = "SigCdCnq"
7055:                     loc_oLookup.cCampoChave = "conquilhas"
7056:                     loc_oLookup.cFiltroIni  = loc_cValor
7057:                     loc_oLookup.Show()
7058:                     IF loc_oLookup.this_lSelecionou
7059:                         loc_cValor = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7060:                     ELSE
7061:                         loc_cValor = ""
7062:                     ENDIF
7063:                 ENDIF
7064:                 IF USED("cursor_4c_ValCnq")

*-- Linhas 7085 a 7104:
7085:             IF EMPTY(loc_cCodigo)
7086:                 loc_lResultado = loc_lResultado
7087:             ENDIF
7088:             loc_lcSQL = "SELECT Cods FROM SigCdCor WHERE Cods = " + EscaparSQL(loc_cCodigo)
7089:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCor") <= 0 OR EOF("cursor_4c_ValCor")
7090:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7091:                 loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
7092:                 loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
7093:                 loc_oLookup.cTabela     = "SigCdCor"
7094:                 loc_oLookup.cCampoChave = "Cods"
7095:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7096:                 loc_oLookup.Show()
7097:                 IF loc_oLookup.this_lSelecionou
7098:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7099:                 ELSE
7100:                     loc_cCodigo = ""
7101:                 ENDIF
7102:             ENDIF
7103:             IF USED("cursor_4c_ValCor")
7104:                 USE IN cursor_4c_ValCor

*-- Linhas 7124 a 7143:
7124:             IF EMPTY(loc_cCodigo)
7125:                 loc_lResultado = loc_lResultado
7126:             ENDIF
7127:             loc_lcSQL = "SELECT Cods FROM SigCdTam WHERE Cods = " + EscaparSQL(loc_cCodigo)
7128:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTam") <= 0 OR EOF("cursor_4c_ValTam")
7129:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7130:                 loc_oLookup.mAddColuna("Cods",  "C" + CHR(243) + "digo",       60)
7131:                 loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
7132:                 loc_oLookup.cTabela     = "SigCdTam"
7133:                 loc_oLookup.cCampoChave = "Cods"
7134:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7135:                 loc_oLookup.Show()
7136:                 IF loc_oLookup.this_lSelecionou
7137:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7138:                 ELSE
7139:                     loc_cCodigo = ""
7140:                 ENDIF
7141:             ENDIF
7142:             IF USED("cursor_4c_ValTam")
7143:                 USE IN cursor_4c_ValTam

*-- Linhas 7161 a 7184:
7161:                 loc_lResultado = loc_lResultado
7162:             ENDIF
7163:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7164:             SELECT cursor_4c_Matrizes
7165:             *-- Localiza linha vazia (placeholder); se nao houver, insere uma nova
7166:             GO TOP IN cursor_4c_Matrizes
7167:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7168:             IF EOF("cursor_4c_Matrizes")
7169:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7170:                     VALUES ("", "", 0, "", "", "")
7171:             ENDIF
7172:             loc_oPage.grd_4c_Matrizes.Refresh()
7173:             loc_oPage.grd_4c_Matrizes.SetFocus()
7174:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7175:             loc_lResultado = .T.
7176:         CATCH TO loc_oErro
7177:             MsgErro(loc_oErro.Message, "Erro")
7178:         ENDTRY
7179:         RETURN loc_lResultado
7180:     ENDPROC
7181: 
7182:     *--------------------------------------------------------------------------
7183:     * BtnExcluiMtzClick - Exclui linha atual do grd_4c_Matrizes
7184:     * Garante sempre ao menos uma linha vazia no cursor

*-- Linhas 7191 a 7216:
7191:                 loc_lResultado = loc_lResultado
7192:             ENDIF
7193:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page4
7194:             SELECT cursor_4c_Matrizes
7195:             DELETE IN cursor_4c_Matrizes
7196:             PACK IN cursor_4c_Matrizes
7197:             *-- Garante sempre ao menos uma linha vazia
7198:             GO TOP IN cursor_4c_Matrizes
7199:             LOCATE FOR EMPTY(cursor_4c_Matrizes.CMats)
7200:             IF EOF("cursor_4c_Matrizes")
7201:                 INSERT INTO cursor_4c_Matrizes (CMats, Locals, QMatz, CPros, cIdChaves, DPros) ;
7202:                     VALUES ("", "", 0, "", "", "")
7203:             ENDIF
7204:             loc_oPage.grd_4c_Matrizes.Refresh()
7205:             loc_oPage.grd_4c_Matrizes.SetFocus()
7206:             loc_oPage.grd_4c_Matrizes.Column1.SetFocus()
7207:             loc_lResultado = .T.
7208:         CATCH TO loc_oErro
7209:             MsgErro(loc_oErro.Message, "Erro")
7210:         ENDTRY
7211:         RETURN loc_lResultado
7212:     ENDPROC
7213: 
7214:     *--------------------------------------------------------------------------
7215:     * MatrizGrdCol1Valid - Valid do Column1 (Matriz/CMats) do grd_4c_Matrizes
7216:     * Lookup: SigCdPro (CPros / DPros) - produto usado como matriz

*-- Linhas 7224 a 7261:
7224:             IF EMPTY(loc_cCodigo)
7225:                 loc_lResultado = loc_lResultado
7226:             ENDIF
7227:             loc_lcSQL = "SELECT CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCodigo)
7228:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMtz") <= 0 OR EOF("cursor_4c_ValMtz")
7229:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
7230:                 loc_oLookup.mAddColuna("CPros", "Matriz",                       80)
7231:                 loc_oLookup.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", 200)
7232:                 loc_oLookup.cTabela     = "SigCdPro"
7233:                 loc_oLookup.cCampoChave = "CPros"
7234:                 loc_oLookup.cFiltroIni  = loc_cCodigo
7235:                 loc_oLookup.Show()
7236:                 IF loc_oLookup.this_lSelecionou
7237:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
7238:                 ELSE
7239:                     loc_cCodigo = ""
7240:                 ENDIF
7241:             ENDIF
7242:             IF USED("cursor_4c_ValMtz")
7243:                 USE IN cursor_4c_ValMtz
7244:             ENDIF
7245:             IF USED("cursor_4c_Matrizes") AND !EOF("cursor_4c_Matrizes")
7246:                 SELECT cursor_4c_Matrizes
7247:                 REPLACE CMats WITH PADR(loc_cCodigo, 14) IN cursor_4c_Matrizes
7248:                 loc_oGrd.Column1.Text1.Value = loc_cCodigo
7249:                 loc_oGrd.Refresh()
7250:             ENDIF
7251:         CATCH TO loc_oErro
7252:             MsgErro(loc_oErro.Message, "Erro")
7253:         ENDTRY
7254:         RETURN loc_lResultado
7255:     ENDPROC
7256: 
7257:     *--------------------------------------------------------------------------
7258:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
7259:     * par_oContainer: container a processar (Page1, Page2, etc.)
7260:     *--------------------------------------------------------------------------
7261:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)

*-- Linhas 7298 a 7358:
7298:     ENDPROC
7299: 
7300:     *--------------------------------------------------------------------------
7301:     * CarregarLista - Busca registros do SigPrFtp com JOIN SigCdPro
7302:     *--------------------------------------------------------------------------
7303:     PROCEDURE CarregarLista()
7304:         LOCAL loc_lResultado, loc_cSQL, loc_cWhere
7305:         loc_lResultado = .F.
7306: 
7307:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
7308:             RETURN loc_lResultado
7309:         ENDIF
7310: 
7311:         TRY
7312:             loc_cWhere = THIS.MontarFiltro()
7313: 
7314:             loc_cSQL = "SELECT t.pkchaves, t.cpros, " + ;
7315:                 "ISNULL(p.dpros,'') AS dpros, " + ;
7316:                 "t.cgrus, t.cods, " + ;
7317:                 "ISNULL(p.reffs,'') AS reffs, " + ;
7318:                 "ISNULL(p.usuincs,'') AS usuincs, " + ;
7319:                 "ISNULL(p.situas,0) AS situas " + ;
7320:                 "FROM sigprftp t " + ;
7321:                 "LEFT JOIN SigCdPro p ON p.cpros = t.cpros "
7322: 
7323:             IF !EMPTY(loc_cWhere)
7324:                 loc_cSQL = loc_cSQL + "WHERE " + loc_cWhere + " "
7325:             ENDIF
7326: 
7327:             loc_cSQL = loc_cSQL + "ORDER BY t.cpros"
7328: 
7329:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
7330:                 LOCAL loc_oGrd
7331:                 loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
7332: 
7333:                 *-- RecordSource FORA de WITH (causa erro se acessar .Column dentro do WITH)
7334:                 loc_oGrd.RecordSource = "cursor_4c_Dados"
7335: 
7336:                 *-- Definir ControlSource (OBRIGATORIO apos RecordSource)
7337:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.cpros"
7338:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.dpros"
7339:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.cgrus"
7340:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.cods"
7341:                 loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.reffs"
7342:                 loc_oGrd.Column6.ControlSource = "cursor_4c_Dados.usuincs"
7343:                 loc_oGrd.Column7.ControlSource = "cursor_4c_Dados.situas"
7344: 
7345:                 *-- Re-aplicar larguras e cabecalhos (RecordSource reseta esses valores)
7346:                 loc_oGrd.Column1.Width = 110
7347:                 loc_oGrd.Column2.Width = 408
7348:                 loc_oGrd.Column3.Width = 40
7349:                 loc_oGrd.Column4.Width = 70
7350:                 loc_oGrd.Column5.Width = 150
7351:                 loc_oGrd.Column6.Width = 100
7352:                 loc_oGrd.Column7.Width = 16
7353:                 loc_oGrd.Column1.Header1.Caption = "Produto"
7354:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
7355:                 loc_oGrd.Column3.Header1.Caption = "Grupo"
7356:                 loc_oGrd.Column4.Header1.Caption = "Subgrp."
7357:                 loc_oGrd.Column5.Header1.Caption = "Ref. Fornecedor"
7358:                 loc_oGrd.Column6.Header1.Caption = "Usu" + CHR(225) + "rio"

*-- Linhas 7386 a 7418:
7386:             loc_nSitua = THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.obj_4c_OptFilSituas.Value
7387: 
7388:             IF !EMPTY(loc_cCgru)
7389:                 loc_cWhere = "t.cgrus = " + EscaparSQL(loc_cCgru)
7390:             ENDIF
7391: 
7392:             IF !EMPTY(loc_dDtIni)
7393:                 IF !EMPTY(loc_cWhere)
7394:                     loc_cWhere = loc_cWhere + " AND "
7395:                 ENDIF
7396:                 loc_cWhere = loc_cWhere + "p.datas >= " + FormatarDataSQL(loc_dDtIni)
7397:             ENDIF
7398: 
7399:             IF !EMPTY(loc_dDtFim)
7400:                 IF !EMPTY(loc_cWhere)
7401:                     loc_cWhere = loc_cWhere + " AND "
7402:                 ENDIF
7403:                 loc_cWhere = loc_cWhere + "p.datas <= " + FormatarDataSQL(loc_dDtFim)
7404:             ENDIF
7405: 
7406:             IF loc_nSitua = 2
7407:                 IF !EMPTY(loc_cWhere)
7408:                     loc_cWhere = loc_cWhere + " AND "
7409:                 ENDIF
7410:                 loc_cWhere = loc_cWhere + "p.situas = 0"
7411:             ENDIF
7412:             IF loc_nSitua = 3
7413:                 IF !EMPTY(loc_cWhere)
7414:                     loc_cWhere = loc_cWhere + " AND "
7415:                 ENDIF
7416:                 loc_cWhere = loc_cWhere + "p.situas = 1"
7417:             ENDIF
7418:         CATCH TO loc_oErro

*-- Linhas 7424 a 7442:
7424: 
7425:     *--------------------------------------------------------------------------
7426:     * FormatarGridLista - Formata visual do grid (FontName/Size)
7427:     * RecordSource + ControlSource ja definidos em CarregarLista
7428:     *--------------------------------------------------------------------------
7429:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
7430:         WITH par_oGrid
7431:             IF .ColumnCount > 0
7432:                 .FontName = "Arial"
7433:                 .FontSize = 8
7434:             ENDIF
7435:         ENDWITH
7436:     ENDPROC
7437: 
7438:     *--------------------------------------------------------------------------
7439:     * AtualizarContagemProdutos - Atualiza label de contagem
7440:     *--------------------------------------------------------------------------
7441:     PROTECTED PROCEDURE AtualizarContagemProdutos()
7442:         LOCAL loc_nTotal

*-- Linhas 7582 a 7609:
7582:             USE IN cursor_4c_Cmv
7583:         ENDIF
7584:         SET NULL OFF
7585:         CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
7586:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.grd_4c_Dados.Refresh()
7587: 
7588:         IF EMPTY(par_cCpros)
7589:             RETURN
7590:         ENDIF
7591: 
7592:         TRY
7593:             *-- Fase 5+6: colunas corretas de SigCdPro (linhas=linha, colecoes=col.venda)
7594:             loc_cSQL = "SELECT p.dpros, ISNULL(p.dpro2s,'') AS dpro2s, " + ;
7595:                 "ISNULL(p.cbars,'') AS cbars, " + ;
7596:                 "ISNULL(p.cgrus,'') AS cgrus, " + ;
7597:                 "ISNULL(p.linhas,'') AS linhas, " + ;
7598:                 "ISNULL(p.colecoes,'') AS colecoes, " + ;
7599:                 "ISNULL(p.ifors,'') AS ifors, ISNULL(p.reffs,'') AS reffs, " + ;
7600:                 "ISNULL(p.codcors,'') AS codcors, ISNULL(p.codtams,'') AS codtams, " + ;
7601:                 "ISNULL(p.codfinp,'') AS codfinp, ISNULL(p.codacbs,'') AS codacbs, " + ;
7602:                 "ISNULL(p.cclass,'') AS cclass, ISNULL(p.locals,'') AS locals, " + ;
7603:                 "ISNULL(p.cunis,'') AS cunis, ISNULL(p.cunips,'') AS cunips, " + ;
7604:                 "ISNULL(p.moecs,'') AS moecs, ISNULL(p.moepvs,'') AS moepvs, " + ;
7605:                 "ISNULL(p.moevs,'') AS moevs, " + ;
7606:                 "ISNULL(p.custofs,0) AS custofs, ISNULL(p.pvens,0) AS pvens, " + ;
7607:                 "ISNULL(p.fvendas,0) AS fvendas, ISNULL(p.pesobs,0) AS pesobs, " + ;
7608:                 "ISNULL(p.pcuss,0) AS pcuss, ISNULL(p.codident,'') AS codident, " + ;
7609:                 "ISNULL(p.dsccompras,'') AS dsccompras, ISNULL(p.dpro3s,'') AS dpro3s, " + ;

*-- Linhas 7622 a 7645:
7622:                 "ISNULL(p.descecfs,'') AS descecfs, " + ;
7623:                 "ISNULL(p.metals,'') AS metals, ISNULL(p.valors,0) AS valors, " + ;
7624:                 "ISNULL(p.moedas,'') AS moedas, ISNULL(p.teors,'') AS teors " + ;
7625:                 "FROM SigCdPro p " + ;
7626:                 "WHERE p.cpros = " + EscaparSQL(par_cCpros)
7627: 
7628:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdDados") > 0
7629:                 IF !EOF("cursor_4c_ProdDados")
7630:                     SELECT cursor_4c_ProdDados
7631:                     *-- Fase 5: campos basicos
7632:                     loc_oPg.txt_4c_Dpros.Value   = ALLTRIM(dpros)
7633:                     loc_oPg.txt_4c_DPro2s.Value  = ALLTRIM(dpro2s)
7634:                     loc_oPg.txt_4c_Cbar.Value    = ALLTRIM(cbars)
7635:                     loc_oPg.txt_4c_Cgrus.Value   = ALLTRIM(cgrus)
7636:                     loc_oPg.txt_4c_Lin.Value     = ALLTRIM(linhas)
7637:                     loc_oPg.txt_4c_Col.Value     = ALLTRIM(colecoes)
7638:                     loc_oPg.txt_4c_Ifor.Value    = ALLTRIM(ifors)
7639:                     loc_oPg.txt_4c_Refs.Value    = ALLTRIM(reffs)
7640:                     *-- Fase 6: campos novos
7641:                     loc_oPg.txt_4c_Cor.Value          = ALLTRIM(codcors)
7642:                     loc_oPg.txt_4c_Tam.Value          = ALLTRIM(codtams)
7643:                     loc_oPg.txt_4c_CodFinP.Value      = ALLTRIM(codfinp)
7644:                     loc_oPg.txt_4c_CodAcb.Value       = ALLTRIM(codacbs)
7645:                     loc_oPg.txt_4c_Class.Value        = ALLTRIM(cclass)

*-- Linhas 7762 a 7783:
7762:         ENDIF
7763: 
7764:         TRY
7765:             loc_cSQL = "SELECT dgrus FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCgrus)
7766:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGru") > 0
7767:                 IF !EOF("cursor_4c_DescGru")
7768:                     SELECT cursor_4c_DescGru
7769:                     loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
7770:                 ELSE
7771:                     loc_oPg.txt_4c_DgruDisplay.Value = ""
7772:                 ENDIF
7773:                 IF USED("cursor_4c_DescGru")
7774:                     USE IN cursor_4c_DescGru
7775:                 ENDIF
7776:             ENDIF
7777:         CATCH TO loc_oErro
7778:             MsgErro(loc_oErro.Message, "Erro ao buscar grupo")
7779:         ENDTRY
7780:     ENDPROC
7781: 
7782:     *--------------------------------------------------------------------------
7783:     * CarregarDescCods - Carrega descricao do subgrupo (via SigCdGrp ou tabela propria)

*-- Linhas 7792 a 7813:
7792:         ENDIF
7793: 
7794:         TRY
7795:             loc_cSQL = "SELECT dgrus AS descSubGrupo FROM SigCdGrp WHERE cgrus = " + EscaparSQL(par_cCods)
7796:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCods") > 0
7797:                 IF !EOF("cursor_4c_DescCods")
7798:                     SELECT cursor_4c_DescCods
7799:                     loc_oPg.txt_4c_DcodsDisplay.Value = ALLTRIM(descSubGrupo)
7800:                 ELSE
7801:                     loc_oPg.txt_4c_DcodsDisplay.Value = ""
7802:                 ENDIF
7803:                 IF USED("cursor_4c_DescCods")
7804:                     USE IN cursor_4c_DescCods
7805:                 ENDIF
7806:             ELSE
7807:                 loc_oPg.txt_4c_DcodsDisplay.Value = ""
7808:             ENDIF
7809:         CATCH TO loc_oErro
7810:             MsgErro(loc_oErro.Message, "Erro ao buscar subgrupo")
7811:         ENDTRY
7812:     ENDPROC
7813: 

*-- Linhas 7824 a 7845:
7824:         ENDIF
7825: 
7826:         TRY
7827:             loc_cSQL = "SELECT descs FROM SigCdLin WHERE linhas = " + EscaparSQL(par_cLinhas)
7828:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLin") > 0
7829:                 IF !EOF("cursor_4c_DescLin")
7830:                     SELECT cursor_4c_DescLin
7831:                     loc_oPg.txt_4c_DLinDisplay.Value = ALLTRIM(descs)
7832:                 ELSE
7833:                     loc_oPg.txt_4c_DLinDisplay.Value = ""
7834:                 ENDIF
7835:                 IF USED("cursor_4c_DescLin")
7836:                     USE IN cursor_4c_DescLin
7837:                 ENDIF
7838:             ENDIF
7839:         CATCH TO loc_oErro
7840:             MsgErro(loc_oErro.Message, "Erro ao buscar linha")
7841:         ENDTRY
7842:     ENDPROC
7843: 
7844:     *--------------------------------------------------------------------------
7845:     * CarregarDescCol - Exibe colecoes (campo texto direto em SigCdPro)

*-- Linhas 7866 a 7887:
7866: 
7867:         TRY
7868:             *-- Fornecedor buscado via SigCdCli (ou tabela de fornecedores)
7869:             loc_cSQL = "SELECT Rclis AS dfors FROM SigCdCli WHERE Iclis = " + EscaparSQL(par_cIfors)
7870:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescIfor") > 0
7871:                 IF !EOF("cursor_4c_DescIfor")
7872:                     SELECT cursor_4c_DescIfor
7873:                     loc_oPg.txt_4c_DforDisplay.Value = ALLTRIM(dfors)
7874:                 ELSE
7875:                     loc_oPg.txt_4c_DforDisplay.Value = ""
7876:                 ENDIF
7877:                 IF USED("cursor_4c_DescIfor")
7878:                     USE IN cursor_4c_DescIfor
7879:                 ENDIF
7880:             ENDIF
7881:         CATCH TO loc_oErro
7882:             MsgErro(loc_oErro.Message, "Erro ao buscar fornecedor")
7883:         ENDTRY
7884:     ENDPROC
7885: 
7886:     *--------------------------------------------------------------------------
7887:     * CarregarDescCor - Carrega descricao da cor (SigCdCor, PK=cods, desc=descs)

*-- Linhas 7893 a 7965:
7893:             RETURN
7894:         ENDIF
7895:         TRY
7896:             loc_cSQL = "SELECT descs FROM SigCdCor WHERE cods = " + EscaparSQL(par_cCodCor)
7897:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCor") > 0
7898:                 IF !EOF("cursor_4c_DescCor")
7899:                     SELECT cursor_4c_DescCor
7900:                     loc_oPg.txt_4c_Cor.ToolTipText = ALLTRIM(descs)
7901:                 ENDIF
7902:                 IF USED("cursor_4c_DescCor")
7903:                     USE IN cursor_4c_DescCor
7904:                 ENDIF
7905:             ENDIF
7906:         CATCH TO loc_oErro
7907:             MsgErro(loc_oErro.Message, "Erro ao buscar cor")
7908:         ENDTRY
7909:     ENDPROC
7910: 
7911:     *--------------------------------------------------------------------------
7912:     * CarregarDescTam - Carrega descricao do tamanho (SigCdTam, PK=cods, desc=descs)
7913:     *--------------------------------------------------------------------------
7914:     PROTECTED PROCEDURE CarregarDescTam(par_cCodTam)
7915:         LOCAL loc_cSQL, loc_oPg
7916:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7917:         IF EMPTY(par_cCodTam)
7918:             RETURN
7919:         ENDIF
7920:         TRY
7921:             loc_cSQL = "SELECT descs FROM SigCdTam WHERE cods = " + EscaparSQL(par_cCodTam)
7922:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescTam") > 0
7923:                 IF !EOF("cursor_4c_DescTam")
7924:                     SELECT cursor_4c_DescTam
7925:                     loc_oPg.txt_4c_Tam.ToolTipText = ALLTRIM(descs)
7926:                 ENDIF
7927:                 IF USED("cursor_4c_DescTam")
7928:                     USE IN cursor_4c_DescTam
7929:                 ENDIF
7930:             ENDIF
7931:         CATCH TO loc_oErro
7932:             MsgErro(loc_oErro.Message, "Erro ao buscar tamanho")
7933:         ENDTRY
7934:     ENDPROC
7935: 
7936:     *--------------------------------------------------------------------------
7937:     * CarregarDescFinP - Carrega descricao da ficha (SigCdFip, PK=cods, desc=descs)
7938:     *--------------------------------------------------------------------------
7939:     PROTECTED PROCEDURE CarregarDescFinP(par_cCodFinP)
7940:         LOCAL loc_cSQL, loc_oPg
7941:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
7942:         IF EMPTY(par_cCodFinP)
7943:             loc_oPg.txt_4c_DesFinP.Value = ""
7944:             RETURN
7945:         ENDIF
7946:         TRY
7947:             loc_cSQL = "SELECT descs FROM SigCdFip WHERE cods = " + EscaparSQL(par_cCodFinP)
7948:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFinP") > 0
7949:                 IF !EOF("cursor_4c_DescFinP")
7950:                     SELECT cursor_4c_DescFinP
7951:                     loc_oPg.txt_4c_DesFinP.Value = ALLTRIM(descs)
7952:                 ELSE
7953:                     loc_oPg.txt_4c_DesFinP.Value = ""
7954:                 ENDIF
7955:                 IF USED("cursor_4c_DescFinP")
7956:                     USE IN cursor_4c_DescFinP
7957:                 ENDIF
7958:             ENDIF
7959:         CATCH TO loc_oErro
7960:             MsgErro(loc_oErro.Message, "Erro ao buscar ficha")
7961:         ENDTRY
7962:     ENDPROC
7963: 
7964:     *--------------------------------------------------------------------------
7965:     * CarregarDescAcb - Carrega descricao do acabamento (SigCdAca, PK=cods, desc=descrs)

*-- Linhas 7972 a 7993:
7972:             RETURN
7973:         ENDIF
7974:         TRY
7975:             loc_cSQL = "SELECT descrs FROM SigCdAca WHERE cods = " + EscaparSQL(par_cCodAcb)
7976:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescAcb") > 0
7977:                 IF !EOF("cursor_4c_DescAcb")
7978:                     SELECT cursor_4c_DescAcb
7979:                     loc_oPg.txt_4c_DacbDisplay.Value = ALLTRIM(descrs)
7980:                 ELSE
7981:                     loc_oPg.txt_4c_DacbDisplay.Value = ""
7982:                 ENDIF
7983:                 IF USED("cursor_4c_DescAcb")
7984:                     USE IN cursor_4c_DescAcb
7985:                 ENDIF
7986:             ENDIF
7987:         CATCH TO loc_oErro
7988:             MsgErro(loc_oErro.Message, "Erro ao buscar acabamento")
7989:         ENDTRY
7990:     ENDPROC
7991: 
7992:     *--------------------------------------------------------------------------
7993:     * CarregarDescClass - Carrega descricao da classificacao (SIGCDCLS, PK=cods, desc=descs)

*-- Linhas 8000 a 8021:
8000:             RETURN
8001:         ENDIF
8002:         TRY
8003:             loc_cSQL = "SELECT descs FROM SIGCDCLS WHERE cods = " + EscaparSQL(par_cCclass)
8004:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescClass") > 0
8005:                 IF !EOF("cursor_4c_DescClass")
8006:                     SELECT cursor_4c_DescClass
8007:                     loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
8008:                 ELSE
8009:                     loc_oPg.txt_4c_DClassDisplay.Value = ""
8010:                 ENDIF
8011:                 IF USED("cursor_4c_DescClass")
8012:                     USE IN cursor_4c_DescClass
8013:                 ENDIF
8014:             ENDIF
8015:         CATCH TO loc_oErro
8016:             MsgErro(loc_oErro.Message, "Erro ao buscar classifica" + CHR(231) + CHR(227) + "o")
8017:         ENDTRY
8018:     ENDPROC
8019: 
8020:     *--------------------------------------------------------------------------
8021:     * CarregarDescLocal - Carrega descricao do local (SigPrLcl, PK=codigos, desc=descricaos)

*-- Linhas 8027 a 8048:
8027:             RETURN
8028:         ENDIF
8029:         TRY
8030:             loc_cSQL = "SELECT descricaos FROM SigPrLcl WHERE codigos = " + EscaparSQL(par_cLocals)
8031:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescLocal") > 0
8032:                 IF !EOF("cursor_4c_DescLocal")
8033:                     SELECT cursor_4c_DescLocal
8034:                     loc_oPg.txt_4c_Local.ToolTipText = ALLTRIM(descricaos)
8035:                 ENDIF
8036:                 IF USED("cursor_4c_DescLocal")
8037:                     USE IN cursor_4c_DescLocal
8038:                 ENDIF
8039:             ENDIF
8040:         CATCH TO loc_oErro
8041:             MsgErro(loc_oErro.Message, "Erro ao buscar local")
8042:         ENDTRY
8043:     ENDPROC
8044: 
8045:     *--------------------------------------------------------------------------
8046:     * CarregarDescUni - Carrega descricao da unidade (SigCdUni, PK=cunis, desc=dunis)
8047:     * par_cTipo: "uni" = unidade principal, "unip" = unidade de pedido
8048:     *--------------------------------------------------------------------------

*-- Linhas 8058 a 8079:
8058:             RETURN
8059:         ENDIF
8060:         TRY
8061:             loc_cSQL = "SELECT dunis FROM SigCdUni WHERE cunis = " + EscaparSQL(par_cCunis)
8062:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescUni") > 0
8063:                 IF !EOF("cursor_4c_DescUni")
8064:                     SELECT cursor_4c_DescUni
8065:                     IF par_cTipo = "uni"
8066:                         loc_oPg.txt_4c_DuniDisplay.Value  = ALLTRIM(dunis)
8067:                     ELSE
8068:                         loc_oPg.txt_4c_DunipDisplay.Value = ALLTRIM(dunis)
8069:                     ENDIF
8070:                 ELSE
8071:                     IF par_cTipo = "uni"
8072:                         loc_oPg.txt_4c_DuniDisplay.Value  = ""
8073:                     ELSE
8074:                         loc_oPg.txt_4c_DunipDisplay.Value = ""
8075:                     ENDIF
8076:                 ENDIF
8077:                 IF USED("cursor_4c_DescUni")
8078:                     USE IN cursor_4c_DescUni
8079:                 ENDIF

*-- Linhas 8095 a 8116:
8095:             RETURN
8096:         ENDIF
8097:         TRY
8098:             loc_cSQL = "SELECT dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(par_cCmoes)
8099:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescMoe") > 0
8100:                 IF !EOF("cursor_4c_DescMoe")
8101:                     SELECT cursor_4c_DescMoe
8102:                     loc_cDesc = ALLTRIM(dmoes)
8103:                 ENDIF
8104:                 IF USED("cursor_4c_DescMoe")
8105:                     USE IN cursor_4c_DescMoe
8106:                 ENDIF
8107:             ENDIF
8108:         CATCH TO loc_oErro
8109:             MsgErro(loc_oErro.Message, "Erro ao buscar moeda")
8110:         ENDTRY
8111:         DO CASE
8112:         CASE par_cTipo = "total"
8113:             loc_oPg.txt_4c_Mctotal.ToolTipText = loc_cDesc
8114:         CASE par_cTipo = "pvenda"
8115:             loc_oPg.txt_4c_Mpvenda.ToolTipText = loc_cDesc
8116:         CASE par_cTipo = "fvenda"

*-- Linhas 8131 a 8246:
8131:         TRY
8132:             *-- Grupo CC (SigCdGcr)
8133:             IF !EMPTY(par_cGruccus)
8134:                 loc_cSQL = "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(par_cGruccus)
8135:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8136:                     loc_oPg3.txt_4c_Dgruccus.Value = ALLTRIM(cursor_4c_DescFisc.descrs)
8137:                 ENDIF
8138:                 IF USED("cursor_4c_DescFisc")
8139:                     USE IN cursor_4c_DescFisc
8140:                 ENDIF
8141:             ENDIF
8142: 
8143:             *-- Conta CC (SigCdCli)
8144:             IF !EMPTY(par_cContaccus)
8145:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(par_cContaccus)
8146:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8147:                     loc_oPg3.txt_4c_Dcontaccus.Value = ALLTRIM(cursor_4c_DescFisc.Rclis)
8148:                 ENDIF
8149:                 IF USED("cursor_4c_DescFisc")
8150:                     USE IN cursor_4c_DescFisc
8151:                 ENDIF
8152:             ENDIF
8153: 
8154:             *-- Classificacao Fiscal (SigCdClf)
8155:             IF !EMPTY(par_cClfiscals)
8156:                 loc_cSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(par_cClfiscals)
8157:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8158:                     loc_oPg3.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_DescFisc.Descricaos)
8159:                 ENDIF
8160:                 IF USED("cursor_4c_DescFisc")
8161:                     USE IN cursor_4c_DescFisc
8162:                 ENDIF
8163:             ENDIF
8164: 
8165:             *-- Origem da Mercadoria (SigCdOrg)
8166:             IF !EMPTY(par_cOrigmercs)
8167:                 loc_cSQL = "SELECT Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(par_cOrigmercs)
8168:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8169:                     loc_oPg3.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_DescFisc.Descricaos)
8170:                 ENDIF
8171:                 IF USED("cursor_4c_DescFisc")
8172:                     USE IN cursor_4c_DescFisc
8173:                 ENDIF
8174:             ENDIF
8175: 
8176:             *-- Situacao Tributaria ICMS (SigCdIcm)
8177:             IF !EMPTY(par_cSittricms)
8178:                 loc_cSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(par_cSittricms)
8179:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescFisc") > 0 AND !EOF("cursor_4c_DescFisc")
8180:                     loc_oPg3.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_DescFisc.Descricaos)
8181:                 ENDIF
8182:                 IF USED("cursor_4c_DescFisc")
8183:                     USE IN cursor_4c_DescFisc
8184:                 ENDIF
8185:             ENDIF
8186: 
8187:             *-- Metal (TmpMTal - cursor carregado em runtime)
8188:             IF !EMPTY(par_cMetals) AND USED("TmpMTal")
8189:                 SELECT TmpMTal
8190:                 LOCATE FOR ALLTRIM(TmpMTal.Metals) == par_cMetals
8191:                 IF FOUND()
8192:                     loc_oPg3.txt_4c_DesMetal.Value = ALLTRIM(TmpMTal.DesMetals)
8193:                 ENDIF
8194:             ENDIF
8195: 
8196:             *-- Teor (TmpTeor - cursor carregado em runtime)
8197:             IF !EMPTY(par_cTeors) AND USED("TmpTeor")
8198:                 SELECT TmpTeor
8199:                 LOCATE FOR ALLTRIM(TmpTeor.Teors) == par_cTeors
8200:                 IF FOUND()
8201:                     loc_oPg3.txt_4c_DesTeor.Value = ALLTRIM(TmpTeor.DesTeors)
8202:                 ENDIF
8203:             ENDIF
8204: 
8205:             *-- Carregar historico CMV (sigcdcmv)
8206:             IF !EMPTY(par_cCpros)
8207:                 loc_cSQL = "SELECT datas, valcuss, moedas FROM sigcdcmv " + ;
8208:                            "WHERE cpros = " + EscaparSQL(par_cCpros) + " ORDER BY datas DESC"
8209:                 IF USED("cursor_4c_Cmv")
8210:                     USE IN cursor_4c_Cmv
8211:                 ENDIF
8212:                 SET NULL OFF
8213:                 CREATE CURSOR cursor_4c_Cmv (datas C(7), valcuss N(10,2), moedas C(3))
8214:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CmvTemp") > 0
8215:                     IF !EOF("cursor_4c_CmvTemp")
8216:                         SELECT cursor_4c_CmvTemp
8217:                         GO TOP
8218:                         SCAN
8219:                             LOCAL loc_cDatas, loc_nValcuss, loc_cMoedas
8220:                             loc_cDatas   = ALLTRIM(cursor_4c_CmvTemp.datas)
8221:                             loc_nValcuss = cursor_4c_CmvTemp.valcuss
8222:                             loc_cMoedas  = ALLTRIM(cursor_4c_CmvTemp.moedas)
8223:                             INSERT INTO cursor_4c_Cmv (datas, valcuss, moedas) ;
8224:                                 VALUES (loc_cDatas, loc_nValcuss, loc_cMoedas)
8225:                         ENDSCAN
8226:                     ENDIF
8227:                     IF USED("cursor_4c_CmvTemp")
8228:                         USE IN cursor_4c_CmvTemp
8229:                     ENDIF
8230:                 ENDIF
8231:                 SELECT cursor_4c_Cmv
8232:                 IF RECCOUNT() > 0
8233:                     GO TOP
8234:                 ENDIF
8235:                 loc_oPg3.grd_4c_Dados.Refresh()
8236:             ENDIF
8237: 
8238:         CATCH TO loc_oErro
8239:             MsgErro(loc_oErro.Message, "Erro ao carregar dados fiscais")
8240:         ENDTRY
8241:     ENDPROC
8242: 
8243:     *--------------------------------------------------------------------------
8244:     * HabilitarCampos - Habilita/desabilita campos editaveis conforme modo
8245:     *--------------------------------------------------------------------------
8246:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)

*-- Linhas 8644 a 8669:
8644: 
8645:             IF loc_oBusca.this_lSelecionou
8646:                 IF USED("cursor_4c_Busca")
8647:                     SELECT cursor_4c_Busca
8648:                     loc_cCpros = ALLTRIM(cpros)
8649:                     USE IN cursor_4c_Busca
8650:                 ENDIF
8651: 
8652:                 *-- Posiciona grid na linha do produto selecionado
8653:                 IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Dados")
8654:                     SELECT cursor_4c_Dados
8655:                     LOCATE FOR ALLTRIM(cpros) = loc_cCpros
8656:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
8657:                 ENDIF
8658:             ENDIF
8659: 
8660:             IF VARTYPE(loc_oBusca) = "O"
8661:                 loc_oBusca.Release()
8662:                 loc_oBusca = .NULL.
8663:             ENDIF
8664:         CATCH TO loc_oErro
8665:             MsgErro(loc_oErro.Message, "Erro ao procurar produto")
8666:         ENDTRY
8667:     ENDPROC
8668: 
8669:     *--------------------------------------------------------------------------

*-- Linhas 8836 a 8857:
8836: 
8837:         TRY
8838:             *-- Verificar se produto existe antes de carregar todos os dados
8839:             loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
8840: 
8841:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro") > 0
8842:                 SELECT cursor_4c_ValPro
8843:                 IF nExiste > 0
8844:                     IF USED("cursor_4c_ValPro")
8845:                         USE IN cursor_4c_ValPro
8846:                     ENDIF
8847:                     THIS.CarregarDadosSigCdPro(loc_cCpros)
8848:                 ELSE
8849:                     IF USED("cursor_4c_ValPro")
8850:                         USE IN cursor_4c_ValPro
8851:                     ENDIF
8852:                     THIS.CarregarDadosSigCdPro("")
8853:                     MsgAviso("Produto " + loc_cCpros + " n" + CHR(227) + "o encontrado.", "Produto Inv" + CHR(225) + "lido")
8854:                 ENDIF
8855:             ENDIF
8856:         CATCH TO loc_oErro
8857:             MsgErro(loc_oErro.Message, "Erro ao validar produto")

*-- Linhas 8954 a 8972:
8954: 
8955:             IF loc_oBusca.this_lSelecionou
8956:                 IF USED("cursor_4c_Busca")
8957:                     SELECT cursor_4c_Busca
8958:                     loc_oPg.txt_4c_Cpros.Value = ALLTRIM(cpros)
8959:                     loc_oPg.txt_4c_Dpros.Value = ALLTRIM(dpros)
8960:                     USE IN cursor_4c_Busca
8961:                 ENDIF
8962:             ENDIF
8963: 
8964:             loc_oBusca.Release()
8965:             loc_oBusca = .NULL.
8966:         CATCH TO loc_oErro
8967:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de produto")
8968:         ENDTRY
8969:     ENDPROC
8970: 
8971:     *--------------------------------------------------------------------------
8972:     * AbrirLookupGrupo - Abre busca de grupo (SigCdGrp)

*-- Linhas 8983 a 9001:
8983: 
8984:             IF loc_oBusca.this_lSelecionou
8985:                 IF USED("cursor_4c_Busca")
8986:                     SELECT cursor_4c_Busca
8987:                     loc_oPg.txt_4c_Cgrus.Value       = ALLTRIM(cgrus)
8988:                     loc_oPg.txt_4c_DgruDisplay.Value = ALLTRIM(dgrus)
8989:                     USE IN cursor_4c_Busca
8990:                 ENDIF
8991:             ENDIF
8992: 
8993:             loc_oBusca.Release()
8994:             loc_oBusca = .NULL.
8995:         CATCH TO loc_oErro
8996:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo")
8997:         ENDTRY
8998:     ENDPROC
8999: 
9000:     *--------------------------------------------------------------------------
9001:     * AbrirLookupLin - Abre busca de linha (SigCdLin)

*-- Linhas 9012 a 9030:
9012: 
9013:             IF loc_oBusca.this_lSelecionou
9014:                 IF USED("cursor_4c_Busca")
9015:                     SELECT cursor_4c_Busca
9016:                     loc_oPg.txt_4c_Lin.Value          = ALLTRIM(clins)
9017:                     loc_oPg.txt_4c_DLinDisplay.Value  = ALLTRIM(dlins)
9018:                     USE IN cursor_4c_Busca
9019:                 ENDIF
9020:             ENDIF
9021: 
9022:             loc_oBusca.Release()
9023:             loc_oBusca = .NULL.
9024:         CATCH TO loc_oErro
9025:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de linha")
9026:         ENDTRY
9027:     ENDPROC
9028: 
9029:     *--------------------------------------------------------------------------
9030:     * AbrirLookupCol - Abre busca de grupo de venda (SigCdCol)

*-- Linhas 9041 a 9059:
9041: 
9042:             IF loc_oBusca.this_lSelecionou
9043:                 IF USED("cursor_4c_Busca")
9044:                     SELECT cursor_4c_Busca
9045:                     loc_oPg.txt_4c_Col.Value          = ALLTRIM(ccols)
9046:                     loc_oPg.txt_4c_DColDisplay.Value  = ALLTRIM(dcols)
9047:                     USE IN cursor_4c_Busca
9048:                 ENDIF
9049:             ENDIF
9050: 
9051:             loc_oBusca.Release()
9052:             loc_oBusca = .NULL.
9053:         CATCH TO loc_oErro
9054:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo de venda")
9055:         ENDTRY
9056:     ENDPROC
9057: 
9058:     *--------------------------------------------------------------------------
9059:     * AbrirLookupIfor - Abre busca de fornecedor (SigCdCli)

*-- Linhas 9070 a 9088:
9070: 
9071:             IF loc_oBusca.this_lSelecionou
9072:                 IF USED("cursor_4c_Busca")
9073:                     SELECT cursor_4c_Busca
9074:                     loc_oPg.txt_4c_Ifor.Value         = ALLTRIM(Iclis)
9075:                     loc_oPg.txt_4c_DforDisplay.Value  = ALLTRIM(Rclis)
9076:                     USE IN cursor_4c_Busca
9077:                 ENDIF
9078:             ENDIF
9079: 
9080:             loc_oBusca.Release()
9081:             loc_oBusca = .NULL.
9082:         CATCH TO loc_oErro
9083:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de fornecedor")
9084:         ENDTRY
9085:     ENDPROC
9086: 
9087:     *==========================================================================
9088:     * HANDLERS DE KEYPRESS - FASE 6 (novos campos com lookup)

*-- Linhas 9407 a 9426:
9407:         ENDIF
9408:         loc_lOk = .F.
9409:         TRY
9410:             loc_cSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodMoe)
9411:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoeCompo") > 0
9412:                 loc_lOk = .T.
9413:             ENDIF
9414:         CATCH TO loc_oErro
9415:             MsgErro(loc_oErro.Message, "Erro ao validar moeda")
9416:         ENDTRY
9417:         IF loc_lOk
9418:             IF EOF("cursor_4c_BuscaMoeCompo")
9419:                 MsgAviso("Moeda " + loc_cCodMoe + " n" + CHR(227) + "o encontrada.", "Inv" + CHR(225) + "lido")
9420:                 loc_oTxt.Value = ""
9421:             ENDIF
9422:             IF USED("cursor_4c_BuscaMoeCompo")
9423:                 USE IN cursor_4c_BuscaMoeCompo
9424:             ENDIF
9425:         ENDIF
9426:     ENDPROC

*-- Linhas 9520 a 9551:
9520:                 RETURN
9521:             ENDIF
9522:             IF USED("cursor_4c_Compo")
9523:                 SELECT cursor_4c_Compo
9524:                 APPEND BLANK
9525:                 loc_oGrd.Refresh()
9526:             ENDIF
9527: 
9528:         CASE loc_nBtn = 2
9529:             *-- Excluir item de composicao
9530:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9531:                 RETURN
9532:             ENDIF
9533:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
9534:                 IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
9535:                     SELECT cursor_4c_Compo
9536:                     DELETE
9537:                     IF !EOF("cursor_4c_Compo")
9538:                         SKIP
9539:                         SKIP -1
9540:                     ENDIF
9541:                     loc_oGrd.Refresh()
9542:                 ENDIF
9543:             ENDIF
9544: 
9545:         CASE loc_nBtn = 3
9546:             *-- Atualizar custo
9547:             THIS.CalcPrecoComposicao()
9548: 
9549:         CASE loc_nBtn = 4
9550:             *-- Atualizar preco
9551:             THIS.CalcPrecoComposicao()

*-- Linhas 9579 a 9610:
9579:                 RETURN
9580:             ENDIF
9581:             IF USED("cursor_4c_SubCp")
9582:                 SELECT cursor_4c_SubCp
9583:                 APPEND BLANK
9584:                 loc_oGrd.Refresh()
9585:             ENDIF
9586: 
9587:         CASE loc_nBtn = 2
9588:             *-- Excluir item de sub-composicao
9589:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9590:                 RETURN
9591:             ENDIF
9592:             IF USED("cursor_4c_SubCp") AND !EOF("cursor_4c_SubCp")
9593:                 IF MsgConfirma("Excluir o sub-item selecionado?", "Confirmar")
9594:                     SELECT cursor_4c_SubCp
9595:                     DELETE
9596:                     IF !EOF("cursor_4c_SubCp")
9597:                         SKIP
9598:                         SKIP -1
9599:                     ENDIF
9600:                     loc_oGrd.Refresh()
9601:                 ENDIF
9602:             ENDIF
9603: 
9604:         ENDCASE
9605:     ENDPROC
9606: 
9607:     *--------------------------------------------------------------------------
9608:     * GrdCustoCompoAfterRowColChange - AfterRowColChange do grid Custo
9609:     * Atualiza txt_4c_Desc (descricao item) e txt_4c_DGruCompos (desc grupo)
9610:     *--------------------------------------------------------------------------

*-- Linhas 9617 a 9636:
9617:             loc_cGrupo = ALLTRIM(cursor_4c_CustoCompo.CGrus)
9618:             IF !EMPTY(loc_cGrupo)
9619:                 TRY
9620:                     loc_nRet = SQLEXEC(gnConnHandle, ;
9621:                         "SELECT DGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cGrupo), ;
9622:                         "cursor_4c_GruCustoDesc")
9623:                     IF loc_nRet > 0 AND USED("cursor_4c_GruCustoDesc") AND !EOF("cursor_4c_GruCustoDesc")
9624:                         loc_oPg.txt_4c_DGruCompos.Value = ALLTRIM(cursor_4c_GruCustoDesc.DGrus)
9625:                     ELSE
9626:                         loc_oPg.txt_4c_DGruCompos.Value = ""
9627:                     ENDIF
9628:                     IF USED("cursor_4c_GruCustoDesc")
9629:                         USE IN cursor_4c_GruCustoDesc
9630:                     ENDIF
9631:                 CATCH TO loc_oErro
9632:                     MsgErro(loc_oErro.Message, "Erro ao buscar grupo da composi" + CHR(231) + CHR(227) + "o")
9633:                 ENDTRY
9634:             ELSE
9635:                 loc_oPg.txt_4c_DGruCompos.Value = ""
9636:             ENDIF

*-- Linhas 9662 a 9693:
9662:                 RETURN
9663:             ENDIF
9664:             IF USED("cursor_4c_CustoCompo")
9665:                 SELECT cursor_4c_CustoCompo
9666:                 APPEND BLANK
9667:                 loc_oGrd.Refresh()
9668:             ENDIF
9669: 
9670:         CASE loc_nBtn = 2
9671:             *-- Excluir item de composicao custo
9672:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
9673:                 RETURN
9674:             ENDIF
9675:             IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
9676:                 IF MsgConfirma("Excluir o item selecionado?", "Confirmar")
9677:                     SELECT cursor_4c_CustoCompo
9678:                     DELETE
9679:                     IF !EOF("cursor_4c_CustoCompo")
9680:                         SKIP
9681:                         SKIP -1
9682:                     ENDIF
9683:                     loc_oGrd.Refresh()
9684:                 ENDIF
9685:             ENDIF
9686: 
9687:         ENDCASE
9688:     ENDPROC
9689: 
9690:     *--------------------------------------------------------------------------
9691:     * CboTiposCustoInteractiveChange - InteractiveChange do cmbTipos na aba Custo
9692:     * Filtra/recarrega grid de composicao pelo tipo selecionado
9693:     *--------------------------------------------------------------------------

*-- Linhas 9868 a 9886:
9868:             loc_oBusca.Show()
9869:             IF loc_oBusca.this_lSelecionou
9870:                 IF USED("cursor_4c_BuscaCor")
9871:                     SELECT cursor_4c_BuscaCor
9872:                     loc_oPg.txt_4c_Cor.Value = ALLTRIM(cods)
9873:                     USE IN cursor_4c_BuscaCor
9874:                 ENDIF
9875:             ENDIF
9876:             loc_oBusca.Release()
9877:             loc_oBusca = .NULL.
9878:         CATCH TO loc_oErro
9879:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de cor")
9880:         ENDTRY
9881:     ENDPROC
9882: 
9883:     *--------------------------------------------------------------------------
9884:     * AbrirLookupTam - Abre busca de tamanho (SigCdTam)
9885:     *--------------------------------------------------------------------------
9886:     PROCEDURE AbrirLookupTam()

*-- Linhas 9895 a 9913:
9895:             loc_oBusca.Show()
9896:             IF loc_oBusca.this_lSelecionou
9897:                 IF USED("cursor_4c_BuscaTam")
9898:                     SELECT cursor_4c_BuscaTam
9899:                     loc_oPg.txt_4c_Tam.Value = ALLTRIM(cods)
9900:                     USE IN cursor_4c_BuscaTam
9901:                 ENDIF
9902:             ENDIF
9903:             loc_oBusca.Release()
9904:             loc_oBusca = .NULL.
9905:         CATCH TO loc_oErro
9906:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tamanho")
9907:         ENDTRY
9908:     ENDPROC
9909: 
9910:     *--------------------------------------------------------------------------
9911:     * AbrirLookupFinP - Abre busca de ficha de produto (SigCdFip)
9912:     *--------------------------------------------------------------------------
9913:     PROCEDURE AbrirLookupFinP()

*-- Linhas 9922 a 9940:
9922:             loc_oBusca.Show()
9923:             IF loc_oBusca.this_lSelecionou
9924:                 IF USED("cursor_4c_BuscaFinP")
9925:                     SELECT cursor_4c_BuscaFinP
9926:                     loc_oPg.txt_4c_CodFinP.Value  = ALLTRIM(cods)
9927:                     loc_oPg.txt_4c_DesFinP.Value  = ALLTRIM(descs)
9928:                     USE IN cursor_4c_BuscaFinP
9929:                 ENDIF
9930:             ENDIF
9931:             loc_oBusca.Release()
9932:             loc_oBusca = .NULL.
9933:         CATCH TO loc_oErro
9934:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de ficha")
9935:         ENDTRY
9936:     ENDPROC
9937: 
9938:     *--------------------------------------------------------------------------
9939:     * AbrirLookupAcb - Abre busca de acabamento (SigCdAca)
9940:     *--------------------------------------------------------------------------

*-- Linhas 9950 a 9968:
9950:             loc_oBusca.Show()
9951:             IF loc_oBusca.this_lSelecionou
9952:                 IF USED("cursor_4c_BuscaAcb")
9953:                     SELECT cursor_4c_BuscaAcb
9954:                     loc_oPg.txt_4c_CodAcb.Value       = ALLTRIM(cods)
9955:                     loc_oPg.txt_4c_DacbDisplay.Value  = ALLTRIM(descrs)
9956:                     USE IN cursor_4c_BuscaAcb
9957:                 ENDIF
9958:             ENDIF
9959:             loc_oBusca.Release()
9960:             loc_oBusca = .NULL.
9961:         CATCH TO loc_oErro
9962:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de acabamento")
9963:         ENDTRY
9964:     ENDPROC
9965: 
9966:     *--------------------------------------------------------------------------
9967:     * AbrirLookupClass - Abre busca de classificacao (SIGCDCLS)
9968:     *--------------------------------------------------------------------------

*-- Linhas 9979 a 9997:
9979:             loc_oBusca.Show()
9980:             IF loc_oBusca.this_lSelecionou
9981:                 IF USED("cursor_4c_BuscaClass")
9982:                     SELECT cursor_4c_BuscaClass
9983:                     loc_oPg.txt_4c_Class.Value         = ALLTRIM(cods)
9984:                     loc_oPg.txt_4c_DClassDisplay.Value = ALLTRIM(descs)
9985:                     USE IN cursor_4c_BuscaClass
9986:                 ENDIF
9987:             ENDIF
9988:             loc_oBusca.Release()
9989:             loc_oBusca = .NULL.
9990:         CATCH TO loc_oErro
9991:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o")
9992:         ENDTRY
9993:     ENDPROC
9994: 
9995:     *--------------------------------------------------------------------------
9996:     * AbrirLookupLocal - Abre busca de local (SigPrLcl)
9997:     *--------------------------------------------------------------------------

*-- Linhas 10007 a 10025:
10007:             loc_oBusca.Show()
10008:             IF loc_oBusca.this_lSelecionou
10009:                 IF USED("cursor_4c_BuscaLocal")
10010:                     SELECT cursor_4c_BuscaLocal
10011:                     loc_oPg.txt_4c_Local.Value = ALLTRIM(codigos)
10012:                     USE IN cursor_4c_BuscaLocal
10013:                 ENDIF
10014:             ENDIF
10015:             loc_oBusca.Release()
10016:             loc_oBusca = .NULL.
10017:         CATCH TO loc_oErro
10018:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de local")
10019:         ENDTRY
10020:     ENDPROC
10021: 
10022:     *--------------------------------------------------------------------------
10023:     * AbrirLookupUni - Abre busca de unidade (SigCdUni) para campo Cuni
10024:     *--------------------------------------------------------------------------
10025:     PROCEDURE AbrirLookupUni()

*-- Linhas 10034 a 10052:
10034:             loc_oBusca.Show()
10035:             IF loc_oBusca.this_lSelecionou
10036:                 IF USED("cursor_4c_BuscaUni")
10037:                     SELECT cursor_4c_BuscaUni
10038:                     loc_oPg.txt_4c_Cuni.Value          = ALLTRIM(cunis)
10039:                     loc_oPg.txt_4c_DuniDisplay.Value   = ALLTRIM(dunis)
10040:                     USE IN cursor_4c_BuscaUni
10041:                 ENDIF
10042:             ENDIF
10043:             loc_oBusca.Release()
10044:             loc_oBusca = .NULL.
10045:         CATCH TO loc_oErro
10046:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade")
10047:         ENDTRY
10048:     ENDPROC
10049: 
10050:     *--------------------------------------------------------------------------
10051:     * AbrirLookupUniP - Abre busca de unidade de pedido (SigCdUni) para campo Cunip
10052:     *--------------------------------------------------------------------------

*-- Linhas 10062 a 10080:
10062:             loc_oBusca.Show()
10063:             IF loc_oBusca.this_lSelecionou
10064:                 IF USED("cursor_4c_BuscaUniP")
10065:                     SELECT cursor_4c_BuscaUniP
10066:                     loc_oPg.txt_4c_Cunip.Value          = ALLTRIM(cunis)
10067:                     loc_oPg.txt_4c_DunipDisplay.Value   = ALLTRIM(dunis)
10068:                     USE IN cursor_4c_BuscaUniP
10069:                 ENDIF
10070:             ENDIF
10071:             loc_oBusca.Release()
10072:             loc_oBusca = .NULL.
10073:         CATCH TO loc_oErro
10074:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de unidade de pedido")
10075:         ENDTRY
10076:     ENDPROC
10077: 
10078:     *--------------------------------------------------------------------------
10079:     * AbrirLookupMctotal - Abre busca de moeda custo (SigCdMoe)
10080:     *--------------------------------------------------------------------------

*-- Linhas 10090 a 10108:
10090:             loc_oBusca.Show()
10091:             IF loc_oBusca.this_lSelecionou
10092:                 IF USED("cursor_4c_BuscaMoe")
10093:                     SELECT cursor_4c_BuscaMoe
10094:                     loc_oPg.txt_4c_Mctotal.Value = ALLTRIM(cmoes)
10095:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "total")
10096:                     USE IN cursor_4c_BuscaMoe
10097:                 ENDIF
10098:             ENDIF
10099:             loc_oBusca.Release()
10100:             loc_oBusca = .NULL.
10101:         CATCH TO loc_oErro
10102:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10103:         ENDTRY
10104:     ENDPROC
10105: 
10106:     *--------------------------------------------------------------------------
10107:     * AbrirLookupMpvenda - Abre busca de moeda P.Venda (SigCdMoe)
10108:     *--------------------------------------------------------------------------

*-- Linhas 10118 a 10136:
10118:             loc_oBusca.Show()
10119:             IF loc_oBusca.this_lSelecionou
10120:                 IF USED("cursor_4c_BuscaMoe")
10121:                     SELECT cursor_4c_BuscaMoe
10122:                     loc_oPg.txt_4c_Mpvenda.Value = ALLTRIM(cmoes)
10123:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "pvenda")
10124:                     USE IN cursor_4c_BuscaMoe
10125:                 ENDIF
10126:             ENDIF
10127:             loc_oBusca.Release()
10128:             loc_oBusca = .NULL.
10129:         CATCH TO loc_oErro
10130:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10131:         ENDTRY
10132:     ENDPROC
10133: 
10134:     *--------------------------------------------------------------------------
10135:     * AbrirLookupMfvenda - Abre busca de moeda F.Venda (SigCdMoe)
10136:     *--------------------------------------------------------------------------

*-- Linhas 10146 a 10164:
10146:             loc_oBusca.Show()
10147:             IF loc_oBusca.this_lSelecionou
10148:                 IF USED("cursor_4c_BuscaMoe")
10149:                     SELECT cursor_4c_BuscaMoe
10150:                     loc_oPg.txt_4c_Mfvenda.Value = ALLTRIM(cmoes)
10151:                     THIS.CarregarDescMoe(ALLTRIM(cmoes), "fvenda")
10152:                     USE IN cursor_4c_BuscaMoe
10153:                 ENDIF
10154:             ENDIF
10155:             loc_oBusca.Release()
10156:             loc_oBusca = .NULL.
10157:         CATCH TO loc_oErro
10158:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
10159:         ENDTRY
10160:     ENDPROC
10161: 
10162:     *==========================================================================
10163:     * HANDLERS - FASE 13: pgDadosFiscais
10164:     *==========================================================================

*-- Linhas 10191 a 10236:
10191:                 loc_oPage.txt_4c_Dcontaccus.Value  = ""
10192:                 loc_lResultado = loc_lResultado
10193:             ENDIF
10194:             loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10195:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus") <= 0 OR EOF("cursor_4c_ValGruccus")
10196:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10197:                 loc_oLookup.mAddColuna("Codigos", "C" + CHR(243) + "digo",       80)
10198:                 loc_oLookup.mAddColuna("Descrs",  "Descri" + CHR(231) + CHR(227) + "o", 200)
10199:                 loc_oLookup.cTabela     = "SigCdGcr"
10200:                 loc_oLookup.cCampoChave = "Codigos"
10201:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10202:                 loc_oLookup.Show()
10203:                 IF loc_oLookup.this_lSelecionou
10204:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10205:                 ELSE
10206:                     loc_cCodigo = ""
10207:                 ENDIF
10208:             ELSE
10209:                 SELECT cursor_4c_ValGruccus
10210:                 loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10211:             ENDIF
10212:             IF USED("cursor_4c_ValGruccus")
10213:                 USE IN cursor_4c_ValGruccus
10214:             ENDIF
10215:             IF !EMPTY(loc_cCodigo)
10216:                 loc_oPage.txt_4c_Gruccus.Value = loc_cCodigo
10217:                 loc_oPage.txt_4c_Gruccus.Refresh()
10218:                 *-- Recarregar descricao se veio do lookup
10219:                 loc_lcSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10220:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValGruccus2") > 0 AND !EOF("cursor_4c_ValGruccus2")
10221:                     SELECT cursor_4c_ValGruccus2
10222:                     loc_oPage.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10223:                 ENDIF
10224:                 IF USED("cursor_4c_ValGruccus2")
10225:                     USE IN cursor_4c_ValGruccus2
10226:                 ENDIF
10227:             ELSE
10228:                 loc_oPage.txt_4c_Gruccus.Value    = ""
10229:                 loc_oPage.txt_4c_Dgruccus.Value   = ""
10230:                 loc_oPage.txt_4c_Contaccus.Value  = ""
10231:                 loc_oPage.txt_4c_Dcontaccus.Value = ""
10232:             ENDIF
10233:             loc_oPage.txt_4c_Dgruccus.Refresh()
10234:         CATCH TO loc_oErro
10235:             MsgErro(loc_oErro.Message, "Erro")
10236:         ENDTRY

*-- Linhas 10252 a 10270:
10252:             loc_oBusca.Show()
10253:             IF loc_oBusca.this_lSelecionou
10254:                 IF USED("cursor_4c_BuscaGruccus")
10255:                     SELECT cursor_4c_BuscaGruccus
10256:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10257:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10258:                     USE IN cursor_4c_BuscaGruccus
10259:                 ENDIF
10260:             ENDIF
10261:             loc_oBusca.Release()
10262:             loc_oBusca = .NULL.
10263:         CATCH TO loc_oErro
10264:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10265:         ENDTRY
10266:     ENDPROC
10267: 
10268:     *--------------------------------------------------------------------------
10269:     * TxtDgruccusKeyPress - KeyPress em txt_4c_Dgruccus (F4 abre lookup por descricao)
10270:     *--------------------------------------------------------------------------

*-- Linhas 10289 a 10307:
10289:             loc_oBusca.Show()
10290:             IF loc_oBusca.this_lSelecionou
10291:                 IF USED("cursor_4c_BuscaGruccus")
10292:                     SELECT cursor_4c_BuscaGruccus
10293:                     loc_oPg.txt_4c_Gruccus.Value  = ALLTRIM(Codigos)
10294:                     loc_oPg.txt_4c_Dgruccus.Value = ALLTRIM(Descrs)
10295:                     USE IN cursor_4c_BuscaGruccus
10296:                 ENDIF
10297:             ENDIF
10298:             loc_oBusca.Release()
10299:             loc_oBusca = .NULL.
10300:         CATCH TO loc_oErro
10301:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de grupo C.C.")
10302:         ENDTRY
10303:     ENDPROC
10304: 
10305:     *--------------------------------------------------------------------------
10306:     * TxtContaccusKeyPress - KeyPress em txt_4c_Contaccus (F4 abre lookup SigCdCli)
10307:     *--------------------------------------------------------------------------

*-- Linhas 10329 a 10358:
10329:                 loc_oPage.txt_4c_Dcontaccus.Value = ""
10330:                 loc_lResultado = loc_lResultado
10331:             ENDIF
10332:             loc_lcSQL = "SELECT IClis, Rclis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cCodigo)
10333:             IF !EMPTY(loc_cGrupo)
10334:                 loc_lcSQL = loc_lcSQL + " AND Grupos = " + EscaparSQL(loc_cGrupo)
10335:             ENDIF
10336:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValContaccus") <= 0 OR EOF("cursor_4c_ValContaccus")
10337:                 IF USED("cursor_4c_ValContaccus")
10338:                     USE IN cursor_4c_ValContaccus
10339:                 ENDIF
10340:                 THIS.AbrirLookupContaccus()
10341:                 loc_lResultado = loc_lResultado
10342:             ENDIF
10343:             SELECT cursor_4c_ValContaccus
10344:             loc_oPage.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10345:             loc_oPage.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10346:             loc_oPage.txt_4c_Contaccus.Refresh()
10347:             loc_oPage.txt_4c_Dcontaccus.Refresh()
10348:             IF USED("cursor_4c_ValContaccus")
10349:                 USE IN cursor_4c_ValContaccus
10350:             ENDIF
10351:         CATCH TO loc_oErro
10352:             MsgErro(loc_oErro.Message, "Erro")
10353:         ENDTRY
10354:         RETURN loc_lResultado
10355:     ENDPROC
10356: 
10357:     *--------------------------------------------------------------------------
10358:     * AbrirLookupContaccus - Abre busca de conta C.C. (SigCdCli filtrado por grupo)

*-- Linhas 10364 a 10393:
10364:         TRY
10365:             loc_cTabela = "SigCdCli"
10366:             IF !EMPTY(loc_cGrupo)
10367:                 loc_cTabela = "SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo)
10368:                 loc_cTabela = "(SELECT IClis, Rclis FROM SigCdCli WHERE Grupos = " + EscaparSQL(loc_cGrupo) + ") AS t"
10369:             ENDIF
10370:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
10371:                 "SigCdCli", "cursor_4c_BuscaContaccus", "IClis", ;
10372:                 ALLTRIM(loc_oPg.txt_4c_Contaccus.Value), "Busca de Conta C.C.")
10373:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
10374:             loc_oBusca.mAddColuna("Rclis", "", "Nome")
10375:             loc_oBusca.Show()
10376:             IF loc_oBusca.this_lSelecionou
10377:                 IF USED("cursor_4c_BuscaContaccus")
10378:                     SELECT cursor_4c_BuscaContaccus
10379:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10380:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10381:                     USE IN cursor_4c_BuscaContaccus
10382:                 ENDIF
10383:             ENDIF
10384:             loc_oBusca.Release()
10385:             loc_oBusca = .NULL.
10386:         CATCH TO loc_oErro
10387:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10388:         ENDTRY
10389:     ENDPROC
10390: 
10391:     *--------------------------------------------------------------------------
10392:     * TxtDcontaccusKeyPress - KeyPress em txt_4c_Dcontaccus (F4 abre lookup por nome)
10393:     *--------------------------------------------------------------------------

*-- Linhas 10412 a 10430:
10412:             loc_oBusca.Show()
10413:             IF loc_oBusca.this_lSelecionou
10414:                 IF USED("cursor_4c_BuscaContaccus")
10415:                     SELECT cursor_4c_BuscaContaccus
10416:                     loc_oPg.txt_4c_Contaccus.Value  = ALLTRIM(IClis)
10417:                     loc_oPg.txt_4c_Dcontaccus.Value = ALLTRIM(Rclis)
10418:                     USE IN cursor_4c_BuscaContaccus
10419:                 ENDIF
10420:             ENDIF
10421:             loc_oBusca.Release()
10422:             loc_oBusca = .NULL.
10423:         CATCH TO loc_oErro
10424:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de conta C.C.")
10425:         ENDTRY
10426:     ENDPROC
10427: 
10428:     *--------------------------------------------------------------------------
10429:     * TxtClfiscalKeyPress - KeyPress em txt_4c_Clfiscal (F4 abre lookup SigCdClf)
10430:     *--------------------------------------------------------------------------

*-- Linhas 10451 a 10495:
10451:                 loc_oPage.txt_4c_Dclfiscal.Value = ""
10452:                 loc_lResultado = loc_lResultado
10453:             ENDIF
10454:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10455:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf") <= 0 OR EOF("cursor_4c_ValClf")
10456:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10457:                 loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       100)
10458:                 loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 300)
10459:                 loc_oLookup.cTabela     = "SigCdClf"
10460:                 loc_oLookup.cCampoChave = "Codigos"
10461:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10462:                 loc_oLookup.Show()
10463:                 IF loc_oLookup.this_lSelecionou
10464:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10465:                 ELSE
10466:                     loc_cCodigo = ""
10467:                 ENDIF
10468:             ELSE
10469:                 SELECT cursor_4c_ValClf
10470:                 loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10471:             ENDIF
10472:             IF USED("cursor_4c_ValClf")
10473:                 USE IN cursor_4c_ValClf
10474:             ENDIF
10475:             loc_oPage.txt_4c_Clfiscal.Value = loc_cCodigo
10476:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dclfiscal.Value)
10477:                 *-- Recarregar descricao apos lookup
10478:                 loc_lcSQL = "SELECT Descricaos FROM SigCdClf WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10479:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValClf2") > 0 AND !EOF("cursor_4c_ValClf2")
10480:                     SELECT cursor_4c_ValClf2
10481:                     loc_oPage.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10482:                 ENDIF
10483:                 IF USED("cursor_4c_ValClf2")
10484:                     USE IN cursor_4c_ValClf2
10485:                 ENDIF
10486:             ENDIF
10487:             loc_oPage.txt_4c_Clfiscal.Refresh()
10488:             loc_oPage.txt_4c_Dclfiscal.Refresh()
10489:         CATCH TO loc_oErro
10490:             MsgErro(loc_oErro.Message, "Erro")
10491:         ENDTRY
10492:         RETURN loc_lResultado
10493:     ENDPROC
10494: 
10495:     *--------------------------------------------------------------------------

*-- Linhas 10507 a 10525:
10507:             loc_oBusca.Show()
10508:             IF loc_oBusca.this_lSelecionou
10509:                 IF USED("cursor_4c_BuscaClf")
10510:                     SELECT cursor_4c_BuscaClf
10511:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10512:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10513:                     USE IN cursor_4c_BuscaClf
10514:                 ENDIF
10515:             ENDIF
10516:             loc_oBusca.Release()
10517:             loc_oBusca = .NULL.
10518:         CATCH TO loc_oErro
10519:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10520:         ENDTRY
10521:     ENDPROC
10522: 
10523:     *--------------------------------------------------------------------------
10524:     * TxtDclfiscalKeyPress - KeyPress em txt_4c_Dclfiscal (F4 busca reversa)
10525:     *--------------------------------------------------------------------------

*-- Linhas 10544 a 10562:
10544:             loc_oBusca.Show()
10545:             IF loc_oBusca.this_lSelecionou
10546:                 IF USED("cursor_4c_BuscaClf")
10547:                     SELECT cursor_4c_BuscaClf
10548:                     loc_oPg.txt_4c_Clfiscal.Value  = ALLTRIM(Codigos)
10549:                     loc_oPg.txt_4c_Dclfiscal.Value = ALLTRIM(Descricaos)
10550:                     USE IN cursor_4c_BuscaClf
10551:                 ENDIF
10552:             ENDIF
10553:             loc_oBusca.Release()
10554:             loc_oBusca = .NULL.
10555:         CATCH TO loc_oErro
10556:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de classifica" + CHR(231) + CHR(227) + "o fiscal")
10557:         ENDTRY
10558:     ENDPROC
10559: 
10560:     *--------------------------------------------------------------------------
10561:     * TxtOrigmercKeyPress - KeyPress em txt_4c_Origmerc (F4 abre lookup SigCdOrg)
10562:     *--------------------------------------------------------------------------

*-- Linhas 10583 a 10626:
10583:                 loc_oPage.txt_4c_Dorigmerc.Value = ""
10584:                 loc_lResultado = loc_lResultado
10585:             ENDIF
10586:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10587:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg") <= 0 OR EOF("cursor_4c_ValOrg")
10588:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10589:                 loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       60)
10590:                 loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 200)
10591:                 loc_oLookup.cTabela     = "SigCdOrg"
10592:                 loc_oLookup.cCampoChave = "Codigos"
10593:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10594:                 loc_oLookup.Show()
10595:                 IF loc_oLookup.this_lSelecionou
10596:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10597:                 ELSE
10598:                     loc_cCodigo = ""
10599:                 ENDIF
10600:             ELSE
10601:                 SELECT cursor_4c_ValOrg
10602:                 loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10603:             ENDIF
10604:             IF USED("cursor_4c_ValOrg")
10605:                 USE IN cursor_4c_ValOrg
10606:             ENDIF
10607:             loc_oPage.txt_4c_Origmerc.Value = loc_cCodigo
10608:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dorigmerc.Value)
10609:                 loc_lcSQL = "SELECT Descricaos FROM SigCdOrg WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10610:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValOrg2") > 0 AND !EOF("cursor_4c_ValOrg2")
10611:                     SELECT cursor_4c_ValOrg2
10612:                     loc_oPage.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10613:                 ENDIF
10614:                 IF USED("cursor_4c_ValOrg2")
10615:                     USE IN cursor_4c_ValOrg2
10616:                 ENDIF
10617:             ENDIF
10618:             loc_oPage.txt_4c_Origmerc.Refresh()
10619:             loc_oPage.txt_4c_Dorigmerc.Refresh()
10620:         CATCH TO loc_oErro
10621:             MsgErro(loc_oErro.Message, "Erro")
10622:         ENDTRY
10623:         RETURN loc_lResultado
10624:     ENDPROC
10625: 
10626:     *--------------------------------------------------------------------------

*-- Linhas 10638 a 10656:
10638:             loc_oBusca.Show()
10639:             IF loc_oBusca.this_lSelecionou
10640:                 IF USED("cursor_4c_BuscaOrg")
10641:                     SELECT cursor_4c_BuscaOrg
10642:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10643:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10644:                     USE IN cursor_4c_BuscaOrg
10645:                 ENDIF
10646:             ENDIF
10647:             loc_oBusca.Release()
10648:             loc_oBusca = .NULL.
10649:         CATCH TO loc_oErro
10650:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10651:         ENDTRY
10652:     ENDPROC
10653: 
10654:     *--------------------------------------------------------------------------
10655:     * TxtDorigmercKeyPress - KeyPress em txt_4c_Dorigmerc (F4 busca reversa)
10656:     *--------------------------------------------------------------------------

*-- Linhas 10675 a 10693:
10675:             loc_oBusca.Show()
10676:             IF loc_oBusca.this_lSelecionou
10677:                 IF USED("cursor_4c_BuscaOrg")
10678:                     SELECT cursor_4c_BuscaOrg
10679:                     loc_oPg.txt_4c_Origmerc.Value  = ALLTRIM(Codigos)
10680:                     loc_oPg.txt_4c_Dorigmerc.Value = ALLTRIM(Descricaos)
10681:                     USE IN cursor_4c_BuscaOrg
10682:                 ENDIF
10683:             ENDIF
10684:             loc_oBusca.Release()
10685:             loc_oBusca = .NULL.
10686:         CATCH TO loc_oErro
10687:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de origem da mercadoria")
10688:         ENDTRY
10689:     ENDPROC
10690: 
10691:     *--------------------------------------------------------------------------
10692:     * TxtSittricmKeyPress - KeyPress em txt_4c_Sittricm (F4 abre lookup SigCdIcm)
10693:     *--------------------------------------------------------------------------

*-- Linhas 10714 a 10757:
10714:                 loc_oPage.txt_4c_Dsittricm.Value = ""
10715:                 loc_lResultado = loc_lResultado
10716:             ENDIF
10717:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10718:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm") <= 0 OR EOF("cursor_4c_ValIcm")
10719:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10720:                 loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       60)
10721:                 loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 250)
10722:                 loc_oLookup.cTabela     = "SigCdIcm"
10723:                 loc_oLookup.cCampoChave = "Codigos"
10724:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10725:                 loc_oLookup.Show()
10726:                 IF loc_oLookup.this_lSelecionou
10727:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10728:                 ELSE
10729:                     loc_cCodigo = ""
10730:                 ENDIF
10731:             ELSE
10732:                 SELECT cursor_4c_ValIcm
10733:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10734:             ENDIF
10735:             IF USED("cursor_4c_ValIcm")
10736:                 USE IN cursor_4c_ValIcm
10737:             ENDIF
10738:             loc_oPage.txt_4c_Sittricm.Value = loc_cCodigo
10739:             IF !EMPTY(loc_cCodigo) AND EMPTY(loc_oPage.txt_4c_Dsittricm.Value)
10740:                 loc_lcSQL = "SELECT Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10741:                 IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValIcm2") > 0 AND !EOF("cursor_4c_ValIcm2")
10742:                     SELECT cursor_4c_ValIcm2
10743:                     loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10744:                 ENDIF
10745:                 IF USED("cursor_4c_ValIcm2")
10746:                     USE IN cursor_4c_ValIcm2
10747:                 ENDIF
10748:             ENDIF
10749:             loc_oPage.txt_4c_Sittricm.Refresh()
10750:             loc_oPage.txt_4c_Dsittricm.Refresh()
10751:         CATCH TO loc_oErro
10752:             MsgErro(loc_oErro.Message, "Erro")
10753:         ENDTRY
10754:         RETURN loc_lResultado
10755:     ENDPROC
10756: 
10757:     *--------------------------------------------------------------------------

*-- Linhas 10769 a 10787:
10769:             loc_oBusca.Show()
10770:             IF loc_oBusca.this_lSelecionou
10771:                 IF USED("cursor_4c_BuscaIcm")
10772:                     SELECT cursor_4c_BuscaIcm
10773:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10774:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10775:                     USE IN cursor_4c_BuscaIcm
10776:                 ENDIF
10777:             ENDIF
10778:             loc_oBusca.Release()
10779:             loc_oBusca = .NULL.
10780:         CATCH TO loc_oErro
10781:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10782:         ENDTRY
10783:     ENDPROC
10784: 
10785:     *--------------------------------------------------------------------------
10786:     * TxtDsittricmKeyPress - KeyPress em txt_4c_Dsittricm (F4 busca reversa)
10787:     *--------------------------------------------------------------------------

*-- Linhas 10806 a 10824:
10806:             loc_oBusca.Show()
10807:             IF loc_oBusca.this_lSelecionou
10808:                 IF USED("cursor_4c_BuscaIcm")
10809:                     SELECT cursor_4c_BuscaIcm
10810:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10811:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10812:                     USE IN cursor_4c_BuscaIcm
10813:                 ENDIF
10814:             ENDIF
10815:             loc_oBusca.Release()
10816:             loc_oBusca = .NULL.
10817:         CATCH TO loc_oErro
10818:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de situa" + CHR(231) + CHR(227) + "o tribut" + CHR(225) + "ria ICMS")
10819:         ENDTRY
10820:     ENDPROC
10821: 
10822:     *--------------------------------------------------------------------------
10823:     * TxtCodServsKeyPress - KeyPress em txt_4c_CodServs (F4 abre lookup SigCdIcm)
10824:     *--------------------------------------------------------------------------

*-- Linhas 10844 a 10878:
10844:             IF EMPTY(loc_cCodigo)
10845:                 loc_lResultado = loc_lResultado
10846:             ENDIF
10847:             loc_lcSQL = "SELECT Codigos, Descricaos FROM SigCdIcm WHERE Codigos = " + EscaparSQL(loc_cCodigo)
10848:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValCodServs") <= 0 OR EOF("cursor_4c_ValCodServs")
10849:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10850:                 loc_oLookup.mAddColuna("Codigos",    "C" + CHR(243) + "digo",       60)
10851:                 loc_oLookup.mAddColuna("Descricaos", "Descri" + CHR(231) + CHR(227) + "o", 250)
10852:                 loc_oLookup.cTabela     = "SigCdIcm"
10853:                 loc_oLookup.cCampoChave = "Codigos"
10854:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10855:                 loc_oLookup.Show()
10856:                 IF loc_oLookup.this_lSelecionou
10857:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10858:                 ELSE
10859:                     loc_cCodigo = ""
10860:                 ENDIF
10861:             ELSE
10862:                 *-- Get_CodServs preenche txt_4c_Sittricm (conforme original)
10863:                 SELECT cursor_4c_ValCodServs
10864:                 loc_oPage.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10865:                 loc_oPage.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10866:                 loc_oPage.txt_4c_Sittricm.Refresh()
10867:                 loc_oPage.txt_4c_Dsittricm.Refresh()
10868:             ENDIF
10869:             IF USED("cursor_4c_ValCodServs")
10870:                 USE IN cursor_4c_ValCodServs
10871:             ENDIF
10872:             loc_oPage.txt_4c_CodServs.Value = loc_cCodigo
10873:             loc_oPage.txt_4c_CodServs.Refresh()
10874:         CATCH TO loc_oErro
10875:             MsgErro(loc_oErro.Message, "Erro")
10876:         ENDTRY
10877:         RETURN loc_lResultado
10878:     ENDPROC

*-- Linhas 10892 a 10910:
10892:             loc_oBusca.Show()
10893:             IF loc_oBusca.this_lSelecionou
10894:                 IF USED("cursor_4c_BuscaIcm")
10895:                     SELECT cursor_4c_BuscaIcm
10896:                     loc_oPg.txt_4c_CodServs.Value  = ALLTRIM(Codigos)
10897:                     loc_oPg.txt_4c_Sittricm.Value  = ALLTRIM(Codigos)
10898:                     loc_oPg.txt_4c_Dsittricm.Value = ALLTRIM(Descricaos)
10899:                     USE IN cursor_4c_BuscaIcm
10900:                 ENDIF
10901:             ENDIF
10902:             loc_oBusca.Release()
10903:             loc_oBusca = .NULL.
10904:         CATCH TO loc_oErro
10905:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de c" + CHR(243) + "digo de servi" + CHR(231) + "os")
10906:         ENDTRY
10907:     ENDPROC
10908: 
10909:     *--------------------------------------------------------------------------
10910:     * TxtTpTribKeyPress - KeyPress em txt_4c_TpTrib (F4 abre lookup SigPrTri)

*-- Linhas 10931 a 10950:
10931:             IF EMPTY(loc_cCodigo)
10932:                 loc_lResultado = loc_lResultado
10933:             ENDIF
10934:             loc_lcSQL = "SELECT Tipos FROM SigPrTri WHERE Tipos = " + EscaparSQL(loc_cCodigo)
10935:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValTrib") <= 0 OR EOF("cursor_4c_ValTrib")
10936:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
10937:                 loc_oLookup.mAddColuna("Tipos", "Tipo",       60)
10938:                 loc_oLookup.mAddColuna("Descs", "Descri" + CHR(231) + CHR(227) + "o", 200)
10939:                 loc_oLookup.cTabela     = "SigPrTri"
10940:                 loc_oLookup.cCampoChave = "Tipos"
10941:                 loc_oLookup.cFiltroIni  = loc_cCodigo
10942:                 loc_oLookup.Show()
10943:                 IF loc_oLookup.this_lSelecionou
10944:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
10945:                 ELSE
10946:                     loc_cCodigo = ""
10947:                 ENDIF
10948:             ENDIF
10949:             IF USED("cursor_4c_ValTrib")
10950:                 USE IN cursor_4c_ValTrib

*-- Linhas 10972 a 10990:
10972:             loc_oBusca.Show()
10973:             IF loc_oBusca.this_lSelecionou
10974:                 IF USED("cursor_4c_BuscaTrib")
10975:                     SELECT cursor_4c_BuscaTrib
10976:                     loc_oPg.txt_4c_TpTrib.Value = ALLTRIM(Tipos)
10977:                     USE IN cursor_4c_BuscaTrib
10978:                 ENDIF
10979:             ENDIF
10980:             loc_oBusca.Release()
10981:             loc_oBusca = .NULL.
10982:         CATCH TO loc_oErro
10983:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de tipo de tributa" + CHR(231) + CHR(227) + "o")
10984:         ENDTRY
10985:     ENDPROC
10986: 
10987:     *--------------------------------------------------------------------------
10988:     * ValidarIat - LostFocus em txt_4c_Iat
10989:     * Valida: deve ser 'A' (Arredondamento) ou 'T' (Truncamento) ou vazio
10990:     *--------------------------------------------------------------------------

*-- Linhas 11021 a 11041:
11021:             IF EMPTY(ALLTRIM(NVL(loc_oPage.txt_4c_Clfiscal.Value, ""))) OR loc_nAliq = 0
11022:                 RETURN
11023:             ENDIF
11024:             loc_lcSQL = "SELECT aIpis FROM SigCdClf WHERE Codigos = " + EscaparSQL(ALLTRIM(loc_oPage.txt_4c_Clfiscal.Value))
11025:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValAliqIPI") > 0 AND !EOF("cursor_4c_ValAliqIPI")
11026:                 SELECT cursor_4c_ValAliqIPI
11027:                 loc_nAliqClf = aIpis
11028:                 IF loc_nAliq = loc_nAliqClf
11029:                     MsgAviso("Al" + CHR(237) + "quota de IPI informada no produto id" + CHR(234) + "ntica " + ;
11030:                         CHR(224) + " classifica" + CHR(231) + CHR(227) + "o fiscal, " + ;
11031:                         "deixe zero e ser" + CHR(225) + " utilizada a classifica" + CHR(231) + CHR(227) + "o fiscal!")
11032:                 ENDIF
11033:             ENDIF
11034:             IF USED("cursor_4c_ValAliqIPI")
11035:                 USE IN cursor_4c_ValAliqIPI
11036:             ENDIF
11037:         CATCH TO loc_oErro
11038:             MsgErro(loc_oErro.Message, "Erro")
11039:         ENDTRY
11040:     ENDPROC
11041: 

*-- Linhas 11064 a 11083:
11064:             IF EMPTY(loc_cCodigo)
11065:                 loc_lResultado = loc_lResultado
11066:             ENDIF
11067:             loc_lcSQL = "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodigo)
11068:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_ValMvalor") <= 0 OR EOF("cursor_4c_ValMvalor")
11069:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
11070:                 loc_oLookup.mAddColuna("cmoes", "C" + CHR(243) + "digo",       60)
11071:                 loc_oLookup.mAddColuna("dmoes", "Descri" + CHR(231) + CHR(227) + "o", 200)
11072:                 loc_oLookup.cTabela     = "SigCdMoe"
11073:                 loc_oLookup.cCampoChave = "cmoes"
11074:                 loc_oLookup.cFiltroIni  = loc_cCodigo
11075:                 loc_oLookup.Show()
11076:                 IF loc_oLookup.this_lSelecionou
11077:                     loc_cCodigo = ALLTRIM(loc_oLookup.this_cCodigoSelecionado)
11078:                 ELSE
11079:                     loc_cCodigo = ""
11080:                 ENDIF
11081:             ENDIF
11082:             IF USED("cursor_4c_ValMvalor")
11083:                 USE IN cursor_4c_ValMvalor

*-- Linhas 11105 a 11123:
11105:             loc_oBusca.Show()
11106:             IF loc_oBusca.this_lSelecionou
11107:                 IF USED("cursor_4c_BuscaMvalor")
11108:                     SELECT cursor_4c_BuscaMvalor
11109:                     loc_oPg.txt_4c_Mvalor.Value = ALLTRIM(cmoes)
11110:                     USE IN cursor_4c_BuscaMvalor
11111:                 ENDIF
11112:             ENDIF
11113:             loc_oBusca.Release()
11114:             loc_oBusca = .NULL.
11115:         CATCH TO loc_oErro
11116:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de moeda")
11117:         ENDTRY
11118:     ENDPROC
11119: 
11120:     *--------------------------------------------------------------------------
11121:     * TxtMetalKeyPress - KeyPress em txt_4c_Metal (F4 abre lookup metal)
11122:     *--------------------------------------------------------------------------
11123:     PROCEDURE TxtMetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 11143 a 11161:
11143:                 loc_oBusca.Show()
11144:                 IF loc_oBusca.this_lSelecionou
11145:                     IF USED("cursor_4c_BuscaMetal")
11146:                         SELECT cursor_4c_BuscaMetal
11147:                         loc_oPg.txt_4c_Metal.Value   = ALLTRIM(Codigos)
11148:                         loc_oPg.txt_4c_DesMetal.Value = ALLTRIM(Descs)
11149:                         USE IN cursor_4c_BuscaMetal
11150:                     ENDIF
11151:                 ENDIF
11152:                 loc_oBusca.Release()
11153:                 loc_oBusca = .NULL.
11154:             ENDIF
11155:         CATCH TO loc_oErro
11156:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de metal")
11157:         ENDTRY
11158:     ENDPROC
11159: 
11160:     *--------------------------------------------------------------------------
11161:     * TxtTeorKeyPress - KeyPress em txt_4c_Teor (F4 abre lookup teor)

*-- Linhas 11183 a 11201:
11183:                 loc_oBusca.Show()
11184:                 IF loc_oBusca.this_lSelecionou
11185:                     IF USED("cursor_4c_BuscaTeor")
11186:                         SELECT cursor_4c_BuscaTeor
11187:                         loc_oPg.txt_4c_Teor.Value   = ALLTRIM(Codigos)
11188:                         loc_oPg.txt_4c_DesTeor.Value = ALLTRIM(Descs)
11189:                         USE IN cursor_4c_BuscaTeor
11190:                     ENDIF
11191:                 ENDIF
11192:                 loc_oBusca.Release()
11193:                 loc_oBusca = .NULL.
11194:             ENDIF
11195:         CATCH TO loc_oErro
11196:             MsgErro(loc_oErro.Message, "Erro ao abrir busca de teor")
11197:         ENDTRY
11198:     ENDPROC
11199: 
11200:     *--------------------------------------------------------------------------
11201:     * CmdBtnDescFisClick - Click em cmd_4c_BtnDescFis

*-- Linhas 11211 a 11240:
11211:                 RETURN
11212:             ENDIF
11213:             *-- Gerar descricao fiscal baseada na composicao do produto (simplificado)
11214:             loc_lcSQL = "SELECT TOP 1 dpros + ' ' + ISNULL(dpro2s,'') AS descFis " + ;
11215:                 "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros)
11216:             IF SQLEXEC(gnConnHandle, loc_lcSQL, "cursor_4c_DescFis") > 0 AND !EOF("cursor_4c_DescFis")
11217:                 SELECT cursor_4c_DescFis
11218:                 loc_cDescFis = ALLTRIM(descFis)
11219:                 IF !EMPTY(loc_cDescFis)
11220:                     loc_oPage.obj_4c_Mgetdescfi.Value = loc_cDescFis
11221:                     loc_oPage.obj_4c_Mgetdescfi.Refresh()
11222:                     *-- Persistir no banco
11223:                     loc_lcSQL = "UPDATE SigCdPro SET DescFis = " + EscaparSQL(loc_cDescFis) + ;
11224:                         " WHERE cpros = " + EscaparSQL(loc_cCpros)
11225:                     SQLEXEC(gnConnHandle, loc_lcSQL)
11226:                 ELSE
11227:                     MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
11228:                 ENDIF
11229:             ELSE
11230:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar a descri" + CHR(231) + CHR(227) + "o fiscal!")
11231:             ENDIF
11232:             IF USED("cursor_4c_DescFis")
11233:                 USE IN cursor_4c_DescFis
11234:             ENDIF
11235:         CATCH TO loc_oErro
11236:             MsgErro(loc_oErro.Message, "Erro ao gerar descri" + CHR(231) + CHR(227) + "o fiscal")
11237:         ENDTRY
11238:     ENDPROC
11239: 
11240:     *--------------------------------------------------------------------------

*-- Linhas 11265 a 11333:
11265:         loc_cIpiVal = LEFT(UPPER(ALLTRIM(loc_oPg3U.cbo_4c_CmbIpi.Value)), 1)
11266: 
11267:         TRY
11268:             loc_cSQL = "UPDATE SigCdPro SET " + ;
11269:                 "dpro2s = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_DPro2s.Value))      + ", " + ;
11270:                 "cbars = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cbar.Value))        + ", " + ;
11271:                 "cgrus = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cgrus.Value))       + ", " + ;
11272:                 "linhas = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Lin.Value))         + ", " + ;
11273:                 "colecoes = "   + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Col.Value))         + ", " + ;
11274:                 "ifors = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Ifor.Value))        + ", " + ;
11275:                 "reffs = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Refs.Value))        + ", " + ;
11276:                 "codcors = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cor.Value))         + ", " + ;
11277:                 "codtams = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Tam.Value))         + ", " + ;
11278:                 "codfinp = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodFinP.Value))     + ", " + ;
11279:                 "pesobs = "     + FormatarNumeroSQL(loc_oPg.txt_4c_PesoB.Value)         + ", " + ;
11280:                 "codacbs = "    + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodAcb.Value))      + ", " + ;
11281:                 "cclass = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Class.Value))       + ", " + ;
11282:                 "locals = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Local.Value))       + ", " + ;
11283:                 "cunis = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cuni.Value))        + ", " + ;
11284:                 "cunips = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Cunip.Value))       + ", " + ;
11285:                 "custofs = "    + FormatarNumeroSQL(loc_oPg.txt_4c_Ctotal.Value)        + ", " + ;
11286:                 "moecs = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Mctotal.Value))     + ", " + ;
11287:                 "pvens = "      + FormatarNumeroSQL(loc_oPg.txt_4c_Pvenda.Value)        + ", " + ;
11288:                 "moepvs = "     + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Mpvenda.Value))     + ", " + ;
11289:                 "codident = "   + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_CodIdent.Value))    + ", " + ;
11290:                 "fvendas = "    + FormatarNumeroSQL(loc_oPg.txt_4c_Fvenda.Value)        + ", " + ;
11291:                 "moevs = "      + EscaparSQL(ALLTRIM(loc_oPg.txt_4c_Mfvenda.Value))     + ", " + ;
11292:                 "dsccompras = " + EscaparSQL(ALLTRIM(loc_oPg.edt_4c_DscCompras.Value))  + ", " + ;
11293:                 "dpro3s = "     + EscaparSQL(ALLTRIM(loc_oPg.edt_4c_DPro3s.Value))      + ", " + ;
11294:                 "obscompras = " + EscaparSQL(ALLTRIM(loc_oPg.edt_4c_ObsCompras.Value))  + ", " + ;
11295:                 "fabrproprs = " + TRANSFORM(loc_lFabrProprs)                            + ", " + ;
11296:                 "consigs = "    + TRANSFORM(loc_lConsig)                                + ", " + ;
11297:                 "encoms = "     + TRANSFORM(loc_lEncoms)                                + ", " + ;
11298:                 "gruccus = "    + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Gruccus.Value))   + ", " + ;
11299:                 "contaccus = "  + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Contaccus.Value)) + ", " + ;
11300:                 "clfiscals = "  + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Clfiscal.Value))  + ", " + ;
11301:                 "origmercs = "  + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Origmerc.Value))  + ", " + ;
11302:                 "sittricms = "  + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Sittricm.Value))  + ", " + ;
11303:                 "codservs = "   + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_CodServs.Value))  + ", " + ;
11304:                 "icms = "       + FormatarNumeroSQL(loc_oPg3U.txt_4c_Icms.Value)        + ", " + ;
11305:                 "tptribs = "    + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_TpTrib.Value))    + ", " + ;
11306:                 "iats = "       + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Iat.Value))       + ", " + ;
11307:                 "ipis = "       + EscaparSQL(loc_cIpiVal)                               + ", " + ;
11308:                 "aliqipis = "   + FormatarNumeroSQL(loc_oPg3U.txt_4c_AliqIPI.Value)     + ", " + ;
11309:                 "extipi = "     + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Extipi.Value))    + ", " + ;
11310:                 "descfis = "    + EscaparSQL(ALLTRIM(loc_oPg3U.obj_4c_Mgetdescfi.Value))+ ", " + ;
11311:                 "descecfs = "   + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_DescEcfs.Value))  + ", " + ;
11312:                 "metals = "     + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Metal.Value))     + ", " + ;
11313:                 "valors = "     + FormatarNumeroSQL(loc_oPg3U.txt_4c_Valor.Value)       + ", " + ;
11314:                 "moedas = "     + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Mvalor.Value))    + ", " + ;
11315:                 "teors = "      + EscaparSQL(ALLTRIM(loc_oPg3U.txt_4c_Teor.Value))      + ;
11316:                 " WHERE cpros = " + EscaparSQL(loc_cCpros)
11317: 
11318:             SQLEXEC(gnConnHandle, loc_cSQL)
11319:         CATCH TO loc_oErro
11320:             MsgErro(loc_oErro.Message, "Erro ao atualizar dados do produto em SigCdPro")
11321:         ENDTRY
11322:     ENDPROC
11323: 
11324:     *--------------------------------------------------------------------------
11325:     * Destroy - Liberacao de recursos
11326:     *--------------------------------------------------------------------------
11327:     PROCEDURE Destroy()
11328:         LOCAL loc_aCursors(42), loc_nI
11329:         *-- Lista de todos os cursors possiveis deste form
11330:         loc_aCursors(1)  = "cursor_4c_Dados"
11331:         loc_aCursors(2)  = "cursor_4c_Busca"
11332:         loc_aCursors(3)  = "cursor_4c_ProdDados"
11333:         loc_aCursors(4)  = "cursor_4c_DescGru"


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Produtos
* Tabela: SigPrFtp
*==============================================================================
DEFINE CLASS ProdutoBO AS BusinessBase

  *-- Propriedades da tabela SigPrFtp
  this_cCgrus    = ""   && char(3)   - Grupo
  this_cCods     = ""   && char(2)   - Codigo
  this_nCoefs    = 0    && numeric(6,4) - Coeficiente
  this_cCpros    = ""   && char(14)  - Codigo do Produto
  this_cPkchaves = ""   && char(20)  - Chave Primaria
  this_nValors   = 0    && numeric(10,2) - Valor

  *===========================================================================
  FUNCTION Init()
  *===========================================================================
    THIS.this_cTabela     = "SigPrFtp"
    THIS.this_cCampoChave = "pkchaves"

    RETURN DODEFAULT()
  ENDFUNC

  *===========================================================================
  FUNCTION ObterChavePrimaria()
  *===========================================================================
    RETURN THIS.this_cPkchaves
  ENDFUNC

  *===========================================================================
  FUNCTION CarregarDoCursor(par_cAliasCursor)
  *===========================================================================
    LOCAL loc_lResultado
    loc_lResultado = .F.

    TRY
      SELECT (par_cAliasCursor)
      THIS.this_cCgrus    = ALLTRIM(cgrus)
      THIS.this_cCods     = ALLTRIM(cods)
      THIS.this_nCoefs    = coefs
      THIS.this_cCpros    = ALLTRIM(cpros)
      THIS.this_cPkchaves = ALLTRIM(pkchaves)
      THIS.this_nValors   = valors
      loc_lResultado = .T.
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao carregar cursor")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  FUNCTION Buscar(par_cFiltro)
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      IF EMPTY(par_cFiltro)
        loc_cSQL = "SELECT * FROM SigPrFtp ORDER BY cpros"
      ELSE
        loc_cSQL = "SELECT * FROM SigPrFtp WHERE " + par_cFiltro + " ORDER BY cpros"
      ENDIF

      IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") > 0
        loc_lResultado = .T.
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  FUNCTION CarregarPorCodigo(par_cCodigo)
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "SELECT * FROM SigPrFtp WHERE pkchaves = " + EscaparSQL(par_cCodigo)

      IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Registro") > 0
        IF !EOF("cursor_4c_Registro")
          loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Registro")
        ENDIF
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao carregar produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED PROCEDURE Inserir()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "INSERT INTO SigPrFtp (cgrus, cods, coefs, cpros, pkchaves, valors) VALUES (" + ;
        EscaparSQL(THIS.this_cCgrus)    + ", " + ;
        EscaparSQL(THIS.this_cCods)     + ", " + ;
        FormatarNumeroSQL(THIS.this_nCoefs)   + ", " + ;
        EscaparSQL(THIS.this_cCpros)    + ", " + ;
        EscaparSQL(THIS.this_cPkchaves) + ", " + ;
        FormatarNumeroSQL(THIS.this_nValors)  + ")"

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
        THIS.RegistrarAuditoria("I")
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao inserir produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED PROCEDURE Atualizar()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      loc_cSQL = "UPDATE SigPrFtp SET " + ;
        "cgrus = "   + EscaparSQL(THIS.this_cCgrus)          + ", " + ;
        "cods = "    + EscaparSQL(THIS.this_cCods)           + ", " + ;
        "coefs = "   + FormatarNumeroSQL(THIS.this_nCoefs)   + ", " + ;
        "cpros = "   + EscaparSQL(THIS.this_cCpros)          + ", " + ;
        "valors = "  + FormatarNumeroSQL(THIS.this_nValors)  + ;
        " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkchaves)

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
        THIS.RegistrarAuditoria("A")
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

  *===========================================================================
  PROTECTED FUNCTION ExecutarExclusao()
  *===========================================================================
    LOCAL loc_lResultado, loc_cSQL
    loc_lResultado = .F.

    TRY
      THIS.RegistrarAuditoria("E")

      loc_cSQL = "DELETE FROM SigPrFtp WHERE pkchaves = " + EscaparSQL(THIS.this_cPkchaves)

      IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
        loc_lResultado = .T.
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro ao excluir produto")
    ENDTRY

    RETURN loc_lResultado
  ENDFUNC

ENDDEFINE

