# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TOP' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: MOEMRKAPS, TPCALCPS, TPCALCP, ACRESCS, VALORS, TPFTIOS, ARREDCS, VENDPESO, TPCALCCUS, TIPOS, ESTIMADO, CPROS, CGRUS, PGRU, CODS, I, SGRUS, ALTCOEF, QTDS, PRODUTOS, CUSTOS, MATS, IFORS, REFFS, COLECOES, UNICOMPOS, CUNIPS, MTPRIMAS, 0, ETIQS, CIDCHAVES, _XNRG, CUNIS, PCOMPOS, LCCPO, GRUPOS, VLTPS, FXINIS, FXFINS, 1, SINALS, FKCHAVES, CCATS, PRCON, DATAALTS, HORAALTS, USUAALTS, STATUS, DATAS, CODIGOS, CESTOS, CONJUNTS, USARPAS, APAGAR, VERSAOWEB, LIBERAS, ARQUIVOS, COND3S, IDIOMA, TIPOCADS, VALUE, ICLIS, CONSESTOQ, CODTAMS, CODCORS, EAN13, CATS, OBGFATOR, ENCOMS, MKPOBRIGS, MERCS, CARACTERIS, NCHKSUBGRS, NFAIXAFINS, CONTAS, PCESCOLHA, ETIQCDPRO, ETIQREF, DWVENDAS, LINHAS, LNMARCKUPA, TPCONGLOP, CNJTSQTDS, QTEQUALPS, TAG, ORDEMS, DESCRS, CODCADS, USUARS, OPERS, SITUAS, COND4S, EMPGRUESTS, CMOES

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (5761 linhas total):

*-- Linhas 471 a 597:
471:         *----------------------------------------------------------------------
472:         *-- Grid lista principal (Grade: Top=173+29=202, Left=38, W=922, H=409)
473:         *-- 7 colunas: cpros, dpros, cgrus, subgru, reffs, usuario, inativo(chk)
474:         *-- Conteudo detalhado (colunas, ControlSource): FASE 4
475:         *----------------------------------------------------------------------
476:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
477:         WITH loc_oPagina.grd_4c_Lista
478:             .Top             = 202
479:             .Left            = 38
480:             .Width           = 922
481:             .Height          = 409
482:             .FontName        = "Tahoma"
483:             .FontSize        = 8
484:             .GridLines       = 1
485:             .GridLineColor   = RGB(200, 200, 200)
486:             .HeaderHeight    = 23
487:             .RowHeight       = 20
488:             .DeleteMark      = .F.
489:             .RecordMark      = .F.
490:             .Themes          = .F.
491:             .ReadOnly        = .T.
492:             .ColumnCount     = 0
493:             .Visible         = .T.
494:         ENDWITH
495:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "GrdListaDblClick")
496: 
497:         *-- Criar cursor placeholder ANTES do RecordSource (evita auto-bind errado)
498:         *-- Campos: cpros, dpros, cgrus, sgrus, reffs, colecoes, ImpEtiqs(L), Situas(N)
499:         IF USED("cursor_4c_Lista")
500:             USE IN cursor_4c_Lista
501:         ENDIF
502:         SET NULL ON
503:         CREATE CURSOR cursor_4c_Lista ;
504:             (cpros C(25), dpros C(80), cgrus C(5), sgrus C(5), ;
505:              reffs C(25), colecoes C(20), ImpEtiqs L, Situas N(1,0))
506:         SET NULL OFF
507: 
508:         *-- RecordSource + ColumnCount OBRIGATORIAMENTE FORA do WITH (regra VFP9)
509:         LOCAL loc_oGrid
510:         loc_oGrid = loc_oPagina.grd_4c_Lista
511:         loc_oGrid.RecordSource = "cursor_4c_Lista"
512:         loc_oGrid.ColumnCount  = 7
513: 
514:         *-- Re-definir ControlSource de TODAS as colunas apos RecordSource (GRID-AUTOBIND)
515:         *-- VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior
516:         loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.cpros"
517:         loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.dpros"
518:         loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.cgrus"
519:         loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.sgrus"
520:         loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.reffs"
521:         loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.colecoes"
522:         *-- Column7 (CheckBox): ControlSource definido apos AddObject/CurrentControl abaixo
523: 
524:         *-- Coluna 1: Produto (CPros) - 100px
525:         WITH loc_oGrid.Column1
526:             .ControlSource   = "cursor_4c_Lista.cpros"
527:             .Width           = 100
528:             .ReadOnly        = .T.
529:             .Header1.Caption = "Produto"
530:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
531:         ENDWITH
532: 
533:         *-- Coluna 2: Descricao (DPros) - 305px
534:         WITH loc_oGrid.Column2
535:             .ControlSource   = "cursor_4c_Lista.dpros"
536:             .Width           = 305
537:             .ReadOnly        = .T.
538:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
539:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
540:         ENDWITH
541: 
542:         *-- Coluna 3: Grupo (CGrus) - 65px
543:         WITH loc_oGrid.Column3
544:             .ControlSource   = "cursor_4c_Lista.cgrus"
545:             .Width           = 65
546:             .ReadOnly        = .T.
547:             .Header1.Caption = "Grupo"
548:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
549:         ENDWITH
550: 
551:         *-- Coluna 4: Subgrupo (SGrus) - 65px
552:         WITH loc_oGrid.Column4
553:             .ControlSource   = "cursor_4c_Lista.sgrus"
554:             .Width           = 65
555:             .ReadOnly        = .T.
556:             .Header1.Caption = "Subgrp."
557:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
558:         ENDWITH
559: 
560:         *-- Coluna 5: Ref. Fornecedor (Reffs) - 155px
561:         WITH loc_oGrid.Column5
562:             .ControlSource   = "cursor_4c_Lista.reffs"
563:             .Width           = 155
564:             .ReadOnly        = .T.
565:             .Header1.Caption = "Ref. Fornecedor"
566:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
567:         ENDWITH
568: 
569:         *-- Coluna 6: Grp.Venda (Colecoes) - 150px
570:         WITH loc_oGrid.Column6
571:             .ControlSource   = "cursor_4c_Lista.colecoes"
572:             .Width           = 150
573:             .ReadOnly        = .T.
574:             .Header1.Caption = "Grp"
575:             .DynamicForeColor = "IIF(cursor_4c_Lista.Situas=1,RGB(0,0,0),RGB(255,0,0))"
576:         ENDWITH
577: 
578:         *-- Coluna 7: ImpEtiqs CheckBox ("I") - 30px
579:         *-- OBRIGATORIO: AddObject ANTES de CurrentControl ANTES de ControlSource
580:         loc_oGrid.Column7.AddObject("Check1", "CheckBox")
581:         loc_oGrid.Column7.CurrentControl    = "Check1"
582:         loc_oGrid.Column7.ControlSource     = "cursor_4c_Lista.ImpEtiqs"
583:         loc_oGrid.Column7.Width             = 30
584:         loc_oGrid.Column7.ReadOnly          = .T.
585:         loc_oGrid.Column7.Header1.Caption   = "I"
586:         WITH loc_oGrid.Column7.Check1
587:             .Caption   = ""
588:             .BackStyle = 0
589:             .Enabled   = .F.
590:             .Themes    = .F.
591:         ENDWITH
592: 
593:         *-- Label contador de registros (lblProdutos: Top=584+29=613 mas limitado)
594:         loc_oPagina.AddObject("lbl_4c_Contador", "Label")
595:         WITH loc_oPagina.lbl_4c_Contador
596:             .Caption   = "Produtos Selecionados : 0"
597:             .Top       = 613

*-- Linhas 911 a 929:
911:     *--------------------------------------------------------------------------
912:     * ConfigurarPgDados1 - Page1 dos Dados Internos (pgDados) - Parte 1/2
913:     * Campos: identificacao, grupos, fornecedor, codigos, status, EAN, Cor, Tam
914:     * Top values: FROM layout.json AS-IS (sem compensacao - pageframe interno)
915:     *--------------------------------------------------------------------------
916:     PROTECTED PROCEDURE ConfigurarPgDados1()
917:         LOCAL loc_oPg1
918:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
919: 
920:         *----------------------------------------------------------------------
921:         *-- ROW 1 (Top=130): Produto + Descricao + Status + DtSituas
922:         *----------------------------------------------------------------------
923:         *-- Label "Produto:" (top=134, left=58, w=53)
924:         loc_oPg1.AddObject("lbl_4c_LblProduto", "Label")
925:         WITH loc_oPg1.lbl_4c_LblProduto
926:             .Caption   = "Produto :"
927:             .Top       = 134
928:             .Left      = 58
929:             .Width     = 53

*-- Linhas 3206 a 3224:
3206:     * CarregarLista - Carrega grid da pagina Lista com dados do SQL Server
3207:     * Filtros: getCgru (grupo), getDtIni/getDtFim (DataAlts), optFilSituas (Situas)
3208:     * Situacao: Situas=1 Ativo(verde/preto), Situas=2 Inativo(vermelho)
3209:     * Padrao SQLEXEC: query em temp ? ZAP cursor_4c_Lista ? APPEND FROM DBF
3210:     *--------------------------------------------------------------------------
3211:     PROCEDURE CarregarLista()
3212:         LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCgru, loc_dIni, loc_dFim
3213:         LOCAL loc_nStI, loc_nStF, loc_cFiltroGrupo, loc_cFiltroSitua, loc_oGrid, loc_oPg1
3214:         LOCAL loc_aErros(1)
3215:         loc_lSucesso = .F.
3216: 
3217:         TRY
3218:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
3219:                 loc_lSucesso = .T.
3220:             ELSE
3221:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
3222: 
3223:                 *-- Ler filtros com defaults seguros
3224:                 loc_cCgru = ""

*-- Linhas 3253 a 3305:
3253:                 *-- Filtro grupo (opcional - se vazio carrega todos)
3254:                 loc_cFiltroGrupo = ""
3255:                 IF !EMPTY(loc_cCgru)
3256:                     loc_cFiltroGrupo = " AND CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
3257:                 ENDIF
3258: 
3259:                 *-- Filtro situacao: Situas IN (loc_nStI, loc_nStF)
3260:                 loc_cFiltroSitua = " AND ISNULL(Situas, 1) IN (" + ;
3261:                     TRANSFORM(loc_nStI) + "," + TRANSFORM(loc_nStF) + ")"
3262: 
3263:                 *-- Montar SQL com ISNULL para campos potencialmente nulos
3264:                 loc_cSQL = "SELECT " + ;
3265:                     "ISNULL(CPros,'') AS cpros, " + ;
3266:                     "ISNULL(DPros,'') AS dpros, " + ;
3267:                     "ISNULL(CGrus,'') AS cgrus, " + ;
3268:                     "ISNULL(SGrus,'') AS sgrus, " + ;
3269:                     "ISNULL(Reffs,'') AS reffs, " + ;
3270:                     "ISNULL(Colecoes,'') AS colecoes, " + ;
3271:                     "CAST(ISNULL(ImpEtiqs,0) AS BIT) AS ImpEtiqs, " + ;
3272:                     "ISNULL(Situas,1) AS Situas " + ;
3273:                     "FROM SigCdPro " + ;
3274:                     "WHERE CONVERT(date, ISNULL(DataAlts,'19000101')) >= " + FormatarDataSQL(loc_dIni) + ;
3275:                     " AND CONVERT(date, ISNULL(DataAlts,'19000101')) <= " + FormatarDataSQL(loc_dFim) + ;
3276:                     loc_cFiltroGrupo + loc_cFiltroSitua + ;
3277:                     " ORDER BY CPros"
3278: 
3279:                 *-- Executar query em cursor temporario
3280:                 IF USED("cursor_4c_Temp_Pro")
3281:                     USE IN cursor_4c_Temp_Pro
3282:                 ENDIF
3283:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp_Pro")
3284: 
3285:                 IF loc_nResult > 0
3286:                     *-- ZAP + APPEND mantem RecordSource do grid intacto (nao destroi colunas)
3287:                     SELECT cursor_4c_Lista
3288:                     ZAP
3289:                     IF RECCOUNT("cursor_4c_Temp_Pro") > 0
3290:                         APPEND FROM DBF("cursor_4c_Temp_Pro")
3291:                     ENDIF
3292:                     IF USED("cursor_4c_Temp_Pro")
3293:                         USE IN cursor_4c_Temp_Pro
3294:                     ENDIF
3295:                     GO TOP IN cursor_4c_Lista
3296:                 ELSE
3297:                     AERROR(loc_aErros)
3298:                     MsgErro("Erro ao consultar produtos:" + CHR(13) + ;
3299:                         TRANSFORM(loc_aErros(1, 2)), "Erro SQL")
3300:                     IF USED("cursor_4c_Temp_Pro")
3301:                         USE IN cursor_4c_Temp_Pro
3302:                     ENDIF
3303:                 ENDIF
3304: 
3305:                 *-- Atualizar contador

*-- Linhas 3733 a 3751:
3733:                 USE IN cursor_4c_Busca
3734:             ENDIF
3735:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3736:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
3737:             ENDIF
3738:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3739:             IF !ISNULL(loc_oBusca)
3740:                 loc_oBusca.this_cTabela        = "SigCdPro"
3741:                 loc_oBusca.this_cCampoChave    = "cpros"
3742:                 loc_oBusca.this_cCampoBusca    = "cpros"
3743:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
3744:                 loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
3745:                 loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3746:                 loc_oBusca.Caption = "Buscar Produto"
3747:                 loc_oBusca.Show()
3748:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3749:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cpros)
3750:                 ENDIF
3751:                 IF USED("cursor_4c_Busca")

*-- Linhas 3977 a 3997:
3977:             loc_oPg1.txt_4c_Dgru.Value = ""
3978:         ELSE
3979:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3980:                 loc_cSQL    = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
3981:                               "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
3982:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruD")
3983:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruD") > 0
3984:                     loc_oPg1.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruD.DGrus)
3985:                 ELSE
3986:                     loc_oPg1.txt_4c_Dgru.Value = ""
3987:                     loc_oPg1.txt_4c_Cgru.Value = ""
3988:                     MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCgru, "Aviso")
3989:                 ENDIF
3990:                 IF USED("cursor_4c_GruD")
3991:                     USE IN cursor_4c_GruD
3992:                 ENDIF
3993:             ENDIF
3994:         ENDIF
3995:     ENDPROC
3996: 
3997:     *--------------------------------------------------------------------------

*-- Linhas 4005 a 4025:
4005:             loc_oPg1.txt_4c_DLin.Value = ""
4006:         ELSE
4007:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4008:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdLin " + ;
4009:                               "WHERE Linhas = " + EscaparSQL(PADR(loc_cLin, 10))
4010:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinD")
4011:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LinD") > 0
4012:                     loc_oPg1.txt_4c_DLin.Value = ALLTRIM(cursor_4c_LinD.Descs)
4013:                 ELSE
4014:                     loc_oPg1.txt_4c_DLin.Value = ""
4015:                     loc_oPg1.txt_4c_Lin.Value  = ""
4016:                     MsgAviso("Linha n" + CHR(227) + "o encontrada: " + loc_cLin, "Aviso")
4017:                 ENDIF
4018:                 IF USED("cursor_4c_LinD")
4019:                     USE IN cursor_4c_LinD
4020:                 ENDIF
4021:             ENDIF
4022:         ENDIF
4023:     ENDPROC
4024: 
4025:     *--------------------------------------------------------------------------

*-- Linhas 4033 a 4053:
4033:             loc_oPg1.txt_4c_DCol.Value = ""
4034:         ELSE
4035:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4036:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SIGCDCOL " + ;
4037:                               "WHERE Colecoes = " + EscaparSQL(PADR(loc_cCol, 10))
4038:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColD")
4039:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ColD") > 0
4040:                     loc_oPg1.txt_4c_DCol.Value = ALLTRIM(cursor_4c_ColD.Descs)
4041:                 ELSE
4042:                     loc_oPg1.txt_4c_DCol.Value = ""
4043:                     loc_oPg1.txt_4c_Col.Value  = ""
4044:                     MsgAviso("Cole" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cCol, "Aviso")
4045:                 ENDIF
4046:                 IF USED("cursor_4c_ColD")
4047:                     USE IN cursor_4c_ColD
4048:                 ENDIF
4049:             ENDIF
4050:         ENDIF
4051:     ENDPROC
4052: 
4053:     *--------------------------------------------------------------------------

*-- Linhas 4061 a 4081:
4061:             loc_oPg1.txt_4c_Dfor.Value = ""
4062:         ELSE
4063:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4064:                 loc_cSQL    = "SELECT ISNULL(RClis,'') AS RClis FROM SIGCDCLI " + ;
4065:                               "WHERE IClis = " + EscaparSQL(PADR(loc_cIfor, 10))
4066:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_IforD")
4067:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_IforD") > 0
4068:                     loc_oPg1.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_IforD.RClis)
4069:                 ELSE
4070:                     loc_oPg1.txt_4c_Dfor.Value = ""
4071:                     loc_oPg1.txt_4c_Ifor.Value = ""
4072:                     MsgAviso("Fornecedor n" + CHR(227) + "o encontrado: " + loc_cIfor, "Aviso")
4073:                 ENDIF
4074:                 IF USED("cursor_4c_IforD")
4075:                     USE IN cursor_4c_IforD
4076:                 ENDIF
4077:             ENDIF
4078:         ENDIF
4079:     ENDPROC
4080: 
4081:     *--------------------------------------------------------------------------

*-- Linhas 4089 a 4109:
4089:             *-- Cor vazia e valida (produto sem cor padrao)
4090:         ELSE
4091:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4092:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdCor " + ;
4093:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCor, 4))
4094:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CorD")
4095:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_CorD") > 0
4096:                     IF cursor_4c_CorD.nExiste = 0
4097:                         loc_oPg1.txt_4c_Cor.Value = ""
4098:                         MsgAviso("Cor n" + CHR(227) + "o encontrada: " + loc_cCor, "Aviso")
4099:                     ENDIF
4100:                 ENDIF
4101:                 IF USED("cursor_4c_CorD")
4102:                     USE IN cursor_4c_CorD
4103:                 ENDIF
4104:             ENDIF
4105:         ENDIF
4106:     ENDPROC
4107: 
4108:     *--------------------------------------------------------------------------
4109:     * ValidarDadosTam - Valida tamanho (SigCdTam: cods/descs)

*-- Linhas 4116 a 4136:
4116:             *-- Tamanho vazio e valido (produto sem tamanho padrao)
4117:         ELSE
4118:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4119:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdTam " + ;
4120:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cTam, 4))
4121:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TamD")
4122:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_TamD") > 0
4123:                     IF cursor_4c_TamD.nExiste = 0
4124:                         loc_oPg1.txt_4c_Tam.Value = ""
4125:                         MsgAviso("Tamanho n" + CHR(227) + "o encontrado: " + loc_cTam, "Aviso")
4126:                     ENDIF
4127:                 ENDIF
4128:                 IF USED("cursor_4c_TamD")
4129:                     USE IN cursor_4c_TamD
4130:                 ENDIF
4131:             ENDIF
4132:         ENDIF
4133:     ENDPROC
4134: 
4135:     *--------------------------------------------------------------------------
4136:     * ValidarDadosCodFinP - Valida modelo (sigcdmod: pkchave/descs)

*-- Linhas 4143 a 4163:
4143:             loc_oPg1.txt_4c_DesFinP.Value = ""
4144:         ELSE
4145:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4146:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM sigcdmod " + ;
4147:                               "WHERE Codigos = " + EscaparSQL(PADR(loc_cCod, 3))
4148:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ModD")
4149:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ModD") > 0
4150:                     loc_oPg1.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_ModD.Descs)
4151:                 ELSE
4152:                     loc_oPg1.txt_4c_DesFinP.Value = ""
4153:                     loc_oPg1.txt_4c_CodFinP.Value = ""
4154:                     MsgAviso("Modelo n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4155:                 ENDIF
4156:                 IF USED("cursor_4c_ModD")
4157:                     USE IN cursor_4c_ModD
4158:                 ENDIF
4159:             ENDIF
4160:         ENDIF
4161:     ENDPROC
4162: 
4163:     *--------------------------------------------------------------------------

*-- Linhas 4171 a 4191:
4171:             loc_oPg1.txt_4c_Dacb.Value = ""
4172:         ELSE
4173:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4174:                 loc_cSQL    = "SELECT ISNULL(Descrs,'') AS Descrs FROM SigCdAca " + ;
4175:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
4176:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcaD")
4177:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_AcaD") > 0
4178:                     loc_oPg1.txt_4c_Dacb.Value = ALLTRIM(cursor_4c_AcaD.Descrs)
4179:                 ELSE
4180:                     loc_oPg1.txt_4c_Dacb.Value = ""
4181:                     loc_oPg1.txt_4c_Codacb.Value = ""
4182:                     MsgAviso("Acabamento n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4183:                 ENDIF
4184:                 IF USED("cursor_4c_AcaD")
4185:                     USE IN cursor_4c_AcaD
4186:                 ENDIF
4187:             ENDIF
4188:         ENDIF
4189:     ENDPROC
4190: 
4191:     *--------------------------------------------------------------------------

*-- Linhas 4199 a 4219:
4199:             *-- Equivalente vazio e valido
4200:         ELSE
4201:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4202:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdPro " + ;
4203:                               "WHERE CPros = " + EscaparSQL(PADR(loc_cCod, 14))
4204:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EqD")
4205:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_EqD") > 0
4206:                     IF cursor_4c_EqD.nExiste = 0
4207:                         loc_oPg1.txt_4c_CProEq.Value = ""
4208:                         MsgAviso("Produto equivalente n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4209:                     ENDIF
4210:                 ENDIF
4211:                 IF USED("cursor_4c_EqD")
4212:                     USE IN cursor_4c_EqD
4213:                 ENDIF
4214:             ENDIF
4215:         ENDIF
4216:     ENDPROC
4217: 
4218:     *--------------------------------------------------------------------------
4219:     * ValidarDadosClass - Valida classificacao (SigCdCls: Cods/Descs)

*-- Linhas 4226 a 4246:
4226:             loc_oPg1.txt_4c_DClass.Value = ""
4227:         ELSE
4228:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4229:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdCls " + ;
4230:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
4231:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClsD")
4232:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ClsD") > 0
4233:                     loc_oPg1.txt_4c_DClass.Value = ALLTRIM(cursor_4c_ClsD.Descs)
4234:                 ELSE
4235:                     loc_oPg1.txt_4c_DClass.Value = ""
4236:                     loc_oPg1.txt_4c_Class.Value  = ""
4237:                     MsgAviso("Classifica" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4238:                 ENDIF
4239:                 IF USED("cursor_4c_ClsD")
4240:                     USE IN cursor_4c_ClsD
4241:                 ENDIF
4242:             ENDIF
4243:         ENDIF
4244:     ENDPROC
4245: 
4246:     *--------------------------------------------------------------------------

*-- Linhas 4252 a 4272:
4252:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Local.Value)
4253:         IF !EMPTY(loc_cCod)
4254:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4255:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigPrLcl " + ;
4256:                               "WHERE Codigos = " + EscaparSQL(PADR(loc_cCod, 10))
4257:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LclD")
4258:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LclD") > 0
4259:                     IF cursor_4c_LclD.nExiste = 0
4260:                         loc_oPg1.txt_4c_Local.Value = ""
4261:                         MsgAviso("Local de estoque n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4262:                     ENDIF
4263:                 ENDIF
4264:                 IF USED("cursor_4c_LclD")
4265:                     USE IN cursor_4c_LclD
4266:                 ENDIF
4267:             ENDIF
4268:         ENDIF
4269:     ENDPROC
4270: 
4271:     *--------------------------------------------------------------------------
4272:     * ValidarDadosCuni - Valida unidade (SigCdUni: CUnis/DUnis)

*-- Linhas 4279 a 4299:
4279:             loc_oPg1.txt_4c_Duni.Value = ""
4280:         ELSE
4281:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4282:                 loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
4283:                               "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
4284:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniD")
4285:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UniD") > 0
4286:                     loc_oPg1.txt_4c_Duni.Value = ALLTRIM(cursor_4c_UniD.DUnis)
4287:                 ELSE
4288:                     loc_oPg1.txt_4c_Duni.Value = ""
4289:                     loc_oPg1.txt_4c_Cuni.Value = ""
4290:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4291:                 ENDIF
4292:                 IF USED("cursor_4c_UniD")
4293:                     USE IN cursor_4c_UniD
4294:                 ENDIF
4295:             ENDIF
4296:         ENDIF
4297:     ENDPROC
4298: 
4299:     *--------------------------------------------------------------------------

*-- Linhas 4307 a 4327:
4307:             loc_oPg1.txt_4c_Dunip.Value = ""
4308:         ELSE
4309:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4310:                 loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
4311:                               "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
4312:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UnipD")
4313:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UnipD") > 0
4314:                     loc_oPg1.txt_4c_Dunip.Value = ALLTRIM(cursor_4c_UnipD.DUnis)
4315:                 ELSE
4316:                     loc_oPg1.txt_4c_Dunip.Value = ""
4317:                     loc_oPg1.txt_4c_Cunip.Value = ""
4318:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4319:                 ENDIF
4320:                 IF USED("cursor_4c_UnipD")
4321:                     USE IN cursor_4c_UnipD
4322:                 ENDIF
4323:             ENDIF
4324:         ENDIF
4325:     ENDPROC
4326: 
4327:     *--------------------------------------------------------------------------

*-- Linhas 4333 a 4403:
4333:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mctotal.Value)
4334:         IF !EMPTY(loc_cCod)
4335:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4336:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4337:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4338:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeCtD")
4339:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeCtD") > 0
4340:                     IF cursor_4c_MoeCtD.nExiste = 0
4341:                         loc_oPg1.txt_4c_Mctotal.Value = ""
4342:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4343:                     ENDIF
4344:                 ENDIF
4345:                 IF USED("cursor_4c_MoeCtD")
4346:                     USE IN cursor_4c_MoeCtD
4347:                 ENDIF
4348:             ENDIF
4349:         ENDIF
4350:     ENDPROC
4351: 
4352:     *--------------------------------------------------------------------------
4353:     * ValidarDadosMpvenda - Valida moeda preco venda (SigCdMoe: CMoes/DMoes)
4354:     *--------------------------------------------------------------------------
4355:     PROTECTED PROCEDURE ValidarDadosMpvenda()
4356:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4357:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4358:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mpvenda.Value)
4359:         IF !EMPTY(loc_cCod)
4360:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4361:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4362:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4363:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoePvD")
4364:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoePvD") > 0
4365:                     IF cursor_4c_MoePvD.nExiste = 0
4366:                         loc_oPg1.txt_4c_Mpvenda.Value = ""
4367:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4368:                     ENDIF
4369:                 ENDIF
4370:                 IF USED("cursor_4c_MoePvD")
4371:                     USE IN cursor_4c_MoePvD
4372:                 ENDIF
4373:             ENDIF
4374:         ENDIF
4375:     ENDPROC
4376: 
4377:     *--------------------------------------------------------------------------
4378:     * ValidarDadosMfvenda - Valida moeda fator venda (SigCdMoe: CMoes/DMoes)
4379:     *--------------------------------------------------------------------------
4380:     PROTECTED PROCEDURE ValidarDadosMfvenda()
4381:         LOCAL loc_oPg1, loc_cCod, loc_cSQL, loc_nResult
4382:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
4383:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mfvenda.Value)
4384:         IF !EMPTY(loc_cCod)
4385:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4386:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4387:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4388:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeFvD")
4389:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeFvD") > 0
4390:                     IF cursor_4c_MoeFvD.nExiste = 0
4391:                         loc_oPg1.txt_4c_Mfvenda.Value = ""
4392:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4393:                     ENDIF
4394:                 ENDIF
4395:                 IF USED("cursor_4c_MoeFvD")
4396:                     USE IN cursor_4c_MoeFvD
4397:                 ENDIF
4398:             ENDIF
4399:         ENDIF
4400:     ENDPROC
4401: 
4402:     *==========================================================================
4403:     *-- LOOKUPS - Abertura de FormBuscaAuxiliar (F4)

*-- Linhas 4416 a 4434:
4416:                 USE IN cursor_4c_Busca
4417:             ENDIF
4418:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4419:                 SQLEXEC(gnConnHandle, "SELECT CGrus AS cgrus, DGrus AS dgrus FROM SigCdGrp ORDER BY CGrus", "cursor_4c_Busca")
4420:             ENDIF
4421:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4422:             IF !ISNULL(loc_oBusca)
4423:                 loc_oBusca.this_cTabela        = "SigCdGrp"
4424:                 loc_oBusca.this_cCampoChave    = "cgrus"
4425:                 loc_oBusca.this_cCampoBusca    = "cgrus"
4426:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4427:                 loc_oBusca.mAddColuna("cgrus", "XXXXX",                                  "Grupo")
4428:                 loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4429:                 loc_oBusca.Caption = "Buscar Grupo de Produto"
4430:                 loc_oBusca.Show()
4431:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4432:                     loc_cCgru = ALLTRIM(cursor_4c_Busca.cgrus)
4433:                     loc_cDgru = ALLTRIM(cursor_4c_Busca.dgrus)
4434:                 ENDIF

*-- Linhas 4461 a 4479:
4461:                 USE IN cursor_4c_Busca
4462:             ENDIF
4463:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4464:                 SQLEXEC(gnConnHandle, "SELECT Linhas AS linhas, Descs AS descs FROM SigCdLin ORDER BY Linhas", "cursor_4c_Busca")
4465:             ENDIF
4466:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4467:             IF !ISNULL(loc_oBusca)
4468:                 loc_oBusca.this_cTabela        = "SigCdLin"
4469:                 loc_oBusca.this_cCampoChave    = "linhas"
4470:                 loc_oBusca.this_cCampoBusca    = "linhas"
4471:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4472:                 loc_oBusca.mAddColuna("linhas", "XXXXXXXXXX",                               "Linha")
4473:                 loc_oBusca.mAddColuna("descs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4474:                 loc_oBusca.Caption = "Buscar Linha"
4475:                 loc_oBusca.Show()
4476:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4477:                     loc_cLin  = ALLTRIM(cursor_4c_Busca.linhas)
4478:                     loc_cDLin = ALLTRIM(cursor_4c_Busca.descs)
4479:                 ENDIF

*-- Linhas 4506 a 4524:
4506:                 USE IN cursor_4c_Busca
4507:             ENDIF
4508:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4509:                 SQLEXEC(gnConnHandle, "SELECT Colecoes AS colecoes, Descs AS descs FROM SIGCDCOL ORDER BY Colecoes", "cursor_4c_Busca")
4510:             ENDIF
4511:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4512:             IF !ISNULL(loc_oBusca)
4513:                 loc_oBusca.this_cTabela        = "SIGCDCOL"
4514:                 loc_oBusca.this_cCampoChave    = "colecoes"
4515:                 loc_oBusca.this_cCampoBusca    = "colecoes"
4516:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4517:                 loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX",                               "Cole" + CHR(231) + CHR(227) + "o")
4518:                 loc_oBusca.mAddColuna("descs",    "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4519:                 loc_oBusca.Caption = "Buscar Grupo de Venda"
4520:                 loc_oBusca.Show()
4521:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4522:                     loc_cCol  = ALLTRIM(cursor_4c_Busca.colecoes)
4523:                     loc_cDCol = ALLTRIM(cursor_4c_Busca.descs)
4524:                 ENDIF

*-- Linhas 4551 a 4569:
4551:                 USE IN cursor_4c_Busca
4552:             ENDIF
4553:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4554:                 SQLEXEC(gnConnHandle, "SELECT IClis AS iclis, RClis AS rclis FROM SIGCDCLI ORDER BY IClis", "cursor_4c_Busca")
4555:             ENDIF
4556:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4557:             IF !ISNULL(loc_oBusca)
4558:                 loc_oBusca.this_cTabela        = "SIGCDCLI"
4559:                 loc_oBusca.this_cCampoChave    = "iclis"
4560:                 loc_oBusca.this_cCampoBusca    = "iclis"
4561:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4562:                 loc_oBusca.mAddColuna("iclis", "XXXXXXXXXX",                               "Fornecedor")
4563:                 loc_oBusca.mAddColuna("rclis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Raz" + CHR(227) + "o Social")
4564:                 loc_oBusca.Caption = "Buscar Fornecedor"
4565:                 loc_oBusca.Show()
4566:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4567:                     loc_cIfor = ALLTRIM(cursor_4c_Busca.iclis)
4568:                     loc_cDfor = ALLTRIM(cursor_4c_Busca.rclis)
4569:                 ENDIF

*-- Linhas 4595 a 4613:
4595:                 USE IN cursor_4c_Busca
4596:             ENDIF
4597:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4598:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descs AS descs FROM SigCdCor ORDER BY Cods", "cursor_4c_Busca")
4599:             ENDIF
4600:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4601:             IF !ISNULL(loc_oBusca)
4602:                 loc_oBusca.this_cTabela        = "SigCdCor"
4603:                 loc_oBusca.this_cCampoChave    = "cods"
4604:                 loc_oBusca.this_cCampoBusca    = "cods"
4605:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4606:                 loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Cor")
4607:                 loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4608:                 loc_oBusca.Caption = "Buscar Cor"
4609:                 loc_oBusca.Show()
4610:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4611:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4612:                 ENDIF
4613:                 IF USED("cursor_4c_Busca")

*-- Linhas 4637 a 4655:
4637:                 USE IN cursor_4c_Busca
4638:             ENDIF
4639:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4640:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descs AS descs FROM SigCdTam ORDER BY Cods", "cursor_4c_Busca")
4641:             ENDIF
4642:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4643:             IF !ISNULL(loc_oBusca)
4644:                 loc_oBusca.this_cTabela        = "SigCdTam"
4645:                 loc_oBusca.this_cCampoChave    = "cods"
4646:                 loc_oBusca.this_cCampoBusca    = "cods"
4647:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4648:                 loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Tamanho")
4649:                 loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4650:                 loc_oBusca.Caption = "Buscar Tamanho"
4651:                 loc_oBusca.Show()
4652:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4653:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4654:                 ENDIF
4655:                 IF USED("cursor_4c_Busca")

*-- Linhas 4680 a 4698:
4680:                 USE IN cursor_4c_Busca
4681:             ENDIF
4682:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4683:                 SQLEXEC(gnConnHandle, "SELECT pkchave, Descs AS descs FROM sigcdmod ORDER BY pkchave", "cursor_4c_Busca")
4684:             ENDIF
4685:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4686:             IF !ISNULL(loc_oBusca)
4687:                 loc_oBusca.this_cTabela        = "sigcdmod"
4688:                 loc_oBusca.this_cCampoChave    = "pkchave"
4689:                 loc_oBusca.this_cCampoBusca    = "pkchave"
4690:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4691:                 loc_oBusca.mAddColuna("pkchave", "XXX",                                      "Modelo")
4692:                 loc_oBusca.mAddColuna("descs",   "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4693:                 loc_oBusca.Caption = "Buscar Modelo"
4694:                 loc_oBusca.Show()
4695:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4696:                     loc_cCod = ALLTRIM(cursor_4c_Busca.pkchave)
4697:                     loc_cDes = ALLTRIM(cursor_4c_Busca.descs)
4698:                 ENDIF

*-- Linhas 4725 a 4743:
4725:                 USE IN cursor_4c_Busca
4726:             ENDIF
4727:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4728:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descrs AS descrs FROM SigCdAca ORDER BY Cods", "cursor_4c_Busca")
4729:             ENDIF
4730:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4731:             IF !ISNULL(loc_oBusca)
4732:                 loc_oBusca.this_cTabela        = "SigCdAca"
4733:                 loc_oBusca.this_cCampoChave    = "cods"
4734:                 loc_oBusca.this_cCampoBusca    = "cods"
4735:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4736:                 loc_oBusca.mAddColuna("cods",   "XXX",                                      "Acabamento")
4737:                 loc_oBusca.mAddColuna("descrs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4738:                 loc_oBusca.Caption = "Buscar Acabamento"
4739:                 loc_oBusca.Show()
4740:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4741:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4742:                     loc_cDes = ALLTRIM(cursor_4c_Busca.descrs)
4743:                 ENDIF

*-- Linhas 4769 a 4787:
4769:                 USE IN cursor_4c_Busca
4770:             ENDIF
4771:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4772:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
4773:             ENDIF
4774:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4775:             IF !ISNULL(loc_oBusca)
4776:                 loc_oBusca.this_cTabela        = "SigCdPro"
4777:                 loc_oBusca.this_cCampoChave    = "cpros"
4778:                 loc_oBusca.this_cCampoBusca    = "cpros"
4779:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4780:                 loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
4781:                 loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4782:                 loc_oBusca.Caption = "Buscar Produto Equivalente"
4783:                 loc_oBusca.Show()
4784:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4785:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cpros)
4786:                 ENDIF
4787:                 IF USED("cursor_4c_Busca")

*-- Linhas 4812 a 4830:
4812:                 USE IN cursor_4c_Busca
4813:             ENDIF
4814:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4815:                 SQLEXEC(gnConnHandle, "SELECT Cods, Descs FROM SigCdCls ORDER BY Cods", "cursor_4c_Busca")
4816:             ENDIF
4817:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4818:             IF !ISNULL(loc_oBusca)
4819:                 loc_oBusca.this_cTabela        = "SigCdCls"
4820:                 loc_oBusca.this_cCampoChave    = "Cods"
4821:                 loc_oBusca.this_cCampoBusca    = "Cods"
4822:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4823:                 loc_oBusca.mAddColuna("Cods",  "XXXXX",                                    "Cod")
4824:                 loc_oBusca.mAddColuna("Descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4825:                 loc_oBusca.Caption = "Buscar Classifica" + CHR(231) + CHR(227) + "o"
4826:                 loc_oBusca.Show()
4827:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4828:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.Cods)
4829:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.Descs)
4830:                 ENDIF

*-- Linhas 4856 a 4874:
4856:                 USE IN cursor_4c_Busca
4857:             ENDIF
4858:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4859:                 SQLEXEC(gnConnHandle, "SELECT Codigos, Descricaos FROM SigPrLcl ORDER BY Codigos", "cursor_4c_Busca")
4860:             ENDIF
4861:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4862:             IF !ISNULL(loc_oBusca)
4863:                 loc_oBusca.this_cTabela        = "SigPrLcl"
4864:                 loc_oBusca.this_cCampoChave    = "Codigos"
4865:                 loc_oBusca.this_cCampoBusca    = "Codigos"
4866:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4867:                 loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX",                               "Cod")
4868:                 loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4869:                 loc_oBusca.Caption = "Buscar Local de Estoque"
4870:                 loc_oBusca.Show()
4871:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4872:                     loc_cCod = ALLTRIM(cursor_4c_Busca.Codigos)
4873:                 ENDIF
4874:                 IF USED("cursor_4c_Busca")

*-- Linhas 4899 a 4917:
4899:                 USE IN cursor_4c_Busca
4900:             ENDIF
4901:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4902:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_Busca")
4903:             ENDIF
4904:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4905:             IF !ISNULL(loc_oBusca)
4906:                 loc_oBusca.this_cTabela        = "SigCdUni"
4907:                 loc_oBusca.this_cCampoChave    = "CUnis"
4908:                 loc_oBusca.this_cCampoBusca    = "CUnis"
4909:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4910:                 loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
4911:                 loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4912:                 loc_oBusca.Caption = "Buscar Unidade"
4913:                 loc_oBusca.Show()
4914:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4915:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.CUnis)
4916:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.DUnis)
4917:                 ENDIF

*-- Linhas 4944 a 4962:
4944:                 USE IN cursor_4c_Busca
4945:             ENDIF
4946:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4947:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_Busca")
4948:             ENDIF
4949:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4950:             IF !ISNULL(loc_oBusca)
4951:                 loc_oBusca.this_cTabela        = "SigCdUni"
4952:                 loc_oBusca.this_cCampoChave    = "CUnis"
4953:                 loc_oBusca.this_cCampoBusca    = "CUnis"
4954:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4955:                 loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
4956:                 loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4957:                 loc_oBusca.Caption = "Buscar Unidade de Pauta"
4958:                 loc_oBusca.Show()
4959:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4960:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.CUnis)
4961:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.DUnis)
4962:                 ENDIF

*-- Linhas 4988 a 5006:
4988:                 USE IN cursor_4c_Busca
4989:             ENDIF
4990:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4991:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
4992:             ENDIF
4993:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4994:             IF !ISNULL(loc_oBusca)
4995:                 loc_oBusca.this_cTabela        = "SigCdMoe"
4996:                 loc_oBusca.this_cCampoChave    = "CMoes"
4997:                 loc_oBusca.this_cCampoBusca    = "CMoes"
4998:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4999:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5000:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5001:                 loc_oBusca.Caption = "Buscar Moeda (Custo)"
5002:                 loc_oBusca.Show()
5003:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5004:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5005:                 ENDIF
5006:                 IF USED("cursor_4c_Busca")

*-- Linhas 5030 a 5048:
5030:                 USE IN cursor_4c_Busca
5031:             ENDIF
5032:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5033:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
5034:             ENDIF
5035:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5036:             IF !ISNULL(loc_oBusca)
5037:                 loc_oBusca.this_cTabela        = "SigCdMoe"
5038:                 loc_oBusca.this_cCampoChave    = "CMoes"
5039:                 loc_oBusca.this_cCampoBusca    = "CMoes"
5040:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5041:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5042:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5043:                 loc_oBusca.Caption = "Buscar Moeda (Pre" + CHR(231) + "o Venda)"
5044:                 loc_oBusca.Show()
5045:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5046:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5047:                 ENDIF
5048:                 IF USED("cursor_4c_Busca")

*-- Linhas 5072 a 5090:
5072:                 USE IN cursor_4c_Busca
5073:             ENDIF
5074:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5075:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
5076:             ENDIF
5077:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5078:             IF !ISNULL(loc_oBusca)
5079:                 loc_oBusca.this_cTabela        = "SigCdMoe"
5080:                 loc_oBusca.this_cCampoChave    = "CMoes"
5081:                 loc_oBusca.this_cCampoBusca    = "CMoes"
5082:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5083:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5084:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5085:                 loc_oBusca.Caption = "Buscar Moeda (Fator Venda)"
5086:                 loc_oBusca.Show()
5087:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5088:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5089:                 ENDIF
5090:                 IF USED("cursor_4c_Busca")

*-- Linhas 5117 a 5251:
5117:         *-- Grupo
5118:         loc_cCgru = ALLTRIM(par_oPg1.txt_4c_Cgru.Value)
5119:         IF !EMPTY(loc_cCgru)
5120:             loc_cSQL    = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
5121:                           "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
5122:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruBof")
5123:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruBof") > 0
5124:                 par_oPg1.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruBof.DGrus)
5125:             ENDIF
5126:             IF USED("cursor_4c_GruBof")
5127:                 USE IN cursor_4c_GruBof
5128:             ENDIF
5129:         ENDIF
5130: 
5131:         *-- Linha
5132:         loc_cLin = ALLTRIM(par_oPg1.txt_4c_Lin.Value)
5133:         IF !EMPTY(loc_cLin)
5134:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdLin " + ;
5135:                           "WHERE Linhas = " + EscaparSQL(PADR(loc_cLin, 10))
5136:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinBof")
5137:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LinBof") > 0
5138:                 par_oPg1.txt_4c_DLin.Value = ALLTRIM(cursor_4c_LinBof.Descs)
5139:             ENDIF
5140:             IF USED("cursor_4c_LinBof")
5141:                 USE IN cursor_4c_LinBof
5142:             ENDIF
5143:         ENDIF
5144: 
5145:         *-- Colecao/Grupo de Venda
5146:         loc_cCol = ALLTRIM(par_oPg1.txt_4c_Col.Value)
5147:         IF !EMPTY(loc_cCol)
5148:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SIGCDCOL " + ;
5149:                           "WHERE Colecoes = " + EscaparSQL(PADR(loc_cCol, 10))
5150:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColBof")
5151:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ColBof") > 0
5152:                 par_oPg1.txt_4c_DCol.Value = ALLTRIM(cursor_4c_ColBof.Descs)
5153:             ENDIF
5154:             IF USED("cursor_4c_ColBof")
5155:                 USE IN cursor_4c_ColBof
5156:             ENDIF
5157:         ENDIF
5158: 
5159:         *-- Fornecedor
5160:         loc_cIfor = ALLTRIM(par_oPg1.txt_4c_Ifor.Value)
5161:         IF !EMPTY(loc_cIfor)
5162:             loc_cSQL    = "SELECT ISNULL(RClis,'') AS RClis FROM SIGCDCLI " + ;
5163:                           "WHERE IClis = " + EscaparSQL(PADR(loc_cIfor, 10))
5164:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_IforBof")
5165:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_IforBof") > 0
5166:                 par_oPg1.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_IforBof.RClis)
5167:             ENDIF
5168:             IF USED("cursor_4c_IforBof")
5169:                 USE IN cursor_4c_IforBof
5170:             ENDIF
5171:         ENDIF
5172: 
5173:         *-- Modelo
5174:         loc_cCodFinP = ALLTRIM(par_oPg1.txt_4c_CodFinP.Value)
5175:         IF !EMPTY(loc_cCodFinP)
5176:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM sigcdmod " + ;
5177:                           "WHERE Codigos = " + EscaparSQL(PADR(loc_cCodFinP, 3))
5178:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ModBof")
5179:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ModBof") > 0
5180:                 par_oPg1.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_ModBof.Descs)
5181:             ENDIF
5182:             IF USED("cursor_4c_ModBof")
5183:                 USE IN cursor_4c_ModBof
5184:             ENDIF
5185:         ENDIF
5186: 
5187:         *-- Acabamento
5188:         loc_cCodacb = ALLTRIM(par_oPg1.txt_4c_Codacb.Value)
5189:         IF !EMPTY(loc_cCodacb)
5190:             loc_cSQL    = "SELECT ISNULL(Descrs,'') AS Descrs FROM SigCdAca " + ;
5191:                           "WHERE Cods = " + EscaparSQL(PADR(loc_cCodacb, 3))
5192:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcaBof")
5193:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_AcaBof") > 0
5194:                 par_oPg1.txt_4c_Dacb.Value = ALLTRIM(cursor_4c_AcaBof.Descrs)
5195:             ENDIF
5196:             IF USED("cursor_4c_AcaBof")
5197:                 USE IN cursor_4c_AcaBof
5198:             ENDIF
5199:         ENDIF
5200: 
5201:         *-- Classificacao (SigCdCls: Cods/Descs)
5202:         LOCAL loc_cClass
5203:         loc_cClass = ALLTRIM(par_oPg1.txt_4c_Class.Value)
5204:         IF !EMPTY(loc_cClass)
5205:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdCls " + ;
5206:                           "WHERE Cods = " + EscaparSQL(PADR(loc_cClass, 3))
5207:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClsBof")
5208:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ClsBof") > 0
5209:                 par_oPg1.txt_4c_DClass.Value = ALLTRIM(cursor_4c_ClsBof.Descs)
5210:             ENDIF
5211:             IF USED("cursor_4c_ClsBof")
5212:                 USE IN cursor_4c_ClsBof
5213:             ENDIF
5214:         ENDIF
5215: 
5216:         *-- Unidade (SigCdUni: CUnis/DUnis)
5217:         LOCAL loc_cCuni, loc_cCunip
5218:         loc_cCuni = ALLTRIM(par_oPg1.txt_4c_Cuni.Value)
5219:         IF !EMPTY(loc_cCuni)
5220:             loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
5221:                           "WHERE CUnis = " + EscaparSQL(PADR(loc_cCuni, 3))
5222:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniBof")
5223:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UniBof") > 0
5224:                 par_oPg1.txt_4c_Duni.Value = ALLTRIM(cursor_4c_UniBof.DUnis)
5225:             ENDIF
5226:             IF USED("cursor_4c_UniBof")
5227:                 USE IN cursor_4c_UniBof
5228:             ENDIF
5229:         ENDIF
5230: 
5231:         *-- Unidade de Pauta (SigCdUni: CUnis/DUnis)
5232:         loc_cCunip = ALLTRIM(par_oPg1.txt_4c_Cunip.Value)
5233:         IF !EMPTY(loc_cCunip)
5234:             loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
5235:                           "WHERE CUnis = " + EscaparSQL(PADR(loc_cCunip, 3))
5236:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UnipBof")
5237:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UnipBof") > 0
5238:                 par_oPg1.txt_4c_Dunip.Value = ALLTRIM(cursor_4c_UnipBof.DUnis)
5239:             ENDIF
5240:             IF USED("cursor_4c_UnipBof")
5241:                 USE IN cursor_4c_UnipBof
5242:             ENDIF
5243:         ENDIF
5244:     ENDPROC
5245: 
5246:     *--------------------------------------------------------------------------
5247:     * AjustarBotoesPorModo - Ajusta visibilidade/estado dos botoes por modo atual
5248:     *--------------------------------------------------------------------------
5249:     PROTECTED PROCEDURE AjustarBotoesPorModo()
5250:         LOCAL loc_oPg1, loc_oPg2, loc_lEditing
5251:         loc_oPg1    = THIS.pgf_4c_Paginas.Page1

*-- Linhas 5273 a 5291:
5273:     *--------------------------------------------------------------------------
5274:     PROTECTED PROCEDURE ObterCodigoSelecionado()
5275:         IF USED("cursor_4c_Lista") AND RECCOUNT("cursor_4c_Lista") > 0
5276:             SELECT cursor_4c_Lista
5277:             RETURN ALLTRIM(cursor_4c_Lista.cpros)
5278:         ENDIF
5279:         RETURN ""
5280:     ENDPROC
5281: 
5282:     *==========================================================================
5283:     *-- HANDLERS DE BOTOES - Page1 (Lista)
5284:     *==========================================================================
5285: 
5286:     *--------------------------------------------------------------------------
5287:     * BtnIncluirClick - Modo INCLUIR: prepara formulario para novo registro
5288:     *--------------------------------------------------------------------------
5289:     PROCEDURE BtnIncluirClick()
5290:         THIS.this_cModoAtual   = "INCLUIR"
5291:         THIS.this_lNovoRegistro = .T.

*-- Linhas 5373 a 5391:
5373:                 USE IN cursor_4c_Busca
5374:             ENDIF
5375:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5376:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros, CGrus AS cgrus FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
5377:             ENDIF
5378:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5379:             IF !ISNULL(loc_oBusca)
5380:                 loc_oBusca.this_cTabela        = "SigCdPro"
5381:                 loc_oBusca.this_cCampoChave    = "cpros"
5382:                 loc_oBusca.this_cCampoBusca    = "cpros"
5383:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5384:                 loc_oBusca.mAddColuna("cpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXX", "Produto")
5385:                 loc_oBusca.mAddColuna("dpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5386:                 loc_oBusca.mAddColuna("cgrus",  "XXXXX", "Grupo")
5387:                 loc_oBusca.Caption = "Buscar Produto"
5388:                 loc_oBusca.Show()
5389:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5390:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
5391:                 ENDIF

*-- Linhas 5504 a 5522:
5504:                 USE IN cursor_4c_Busca
5505:             ENDIF
5506:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5507:                 SQLEXEC(gnConnHandle, "SELECT CGrus AS cgrus, DGrus AS dgrus FROM SigCdGrp ORDER BY CGrus", "cursor_4c_Busca")
5508:             ENDIF
5509:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5510:             IF !ISNULL(loc_oBusca)
5511:                 loc_oBusca.this_cTabela        = "SigCdGrp"
5512:                 loc_oBusca.this_cCampoChave    = "cgrus"
5513:                 loc_oBusca.this_cCampoBusca    = "cgrus"
5514:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5515:                 loc_oBusca.mAddColuna("cgrus", "XXXXX",                                     "Grupo")
5516:                 loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5517:                 loc_oBusca.Caption = "Buscar Grupo de Produto"
5518:                 loc_oBusca.Show()
5519:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5520:                     loc_cCgru = ALLTRIM(cursor_4c_Busca.cgrus)
5521:                     loc_cDgru = ALLTRIM(cursor_4c_Busca.dgrus)
5522:                 ENDIF

*-- Linhas 5549 a 5569:
5549:             loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
5550:         ELSE
5551:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5552:                 loc_cSQL = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
5553:                            "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
5554:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruFiltro")
5555:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruFiltro") > 0
5556:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruFiltro.DGrus)
5557:                 ELSE
5558:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
5559:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value = ""
5560:                 ENDIF
5561:                 IF USED("cursor_4c_GruFiltro")
5562:                     USE IN cursor_4c_GruFiltro
5563:                 ENDIF
5564:             ENDIF
5565:         ENDIF
5566:         THIS.CarregarLista()
5567:     ENDPROC
5568: 
5569:     *==========================================================================


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos
* Tabela: SigCdPro | PK: cpros (C14)
* Data: 2026-04-09
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *-- Identificacao
    this_cCpros     = ""   && C(14) - Codigo do produto (PK)
    this_cDpros     = ""   && C(65) - Descricao principal
    this_cDpro2s    = ""   && C(45) - Descricao secundaria (descritivo)

    *-- Classificacao/grupo
    this_cCgrus     = ""   && C(3)  - Grupo
    this_cSgrus     = ""   && C(6)  - Subgrupo
    this_cLinhas    = ""   && C(10) - Linha
    this_cColecoes  = ""   && C(10) - Colecao / Grupo de Venda
    this_cMercs     = ""   && C(3)  - Mercado
    this_cIdecpros  = ""   && C(3)  - Identificador
    this_cCclass    = ""   && C(3)  - Classificacao

    *-- Fornecedor
    this_cIfors     = ""   && C(10) - Codigo do fornecedor
    this_cReffs     = ""   && C(40) - Referencia do fornecedor

    *-- Codigos produto
    this_cCodfinp   = ""   && C(3)  - Codigo do modelo (finishing product)
    this_cCodacbs   = ""   && C(3)  - Codigo do acabamento
    this_cCodcors   = ""   && C(4)  - Codigo da cor
    this_cCodtams   = ""   && C(4)  - Codigo do tamanho
    this_cCproeqs   = ""   && C(14) - Produto equivalente

    *-- Status e datas
    this_nSituas    = 1    && N(1)  - Status: 1=Ativo, 2=Inativo
    this_dDatas     = {}   && Date  - Data do status
    this_dDtincs    = {}   && Date  - Data de inclusao (read-only)
    this_cUsuincs   = ""   && C(10) - Usuario de inclusao

    *-- Codigos de barra
    this_nCbars     = 0    && N(14,0) - Codigo de barra
    this_nEan13     = 0    && N(13,0) - EAN13/GTIN

    *-- Quantidades e lotes
    this_nLtminsv   = 0    && N(9,3) - Lote minimo de venda
    this_nQmins     = 0    && N(9,3) - Quantidade minima
    this_nQtped     = 0    && N(9,3) - Quantidade de pedido

    *-- Unidades
    this_cCunis     = ""   && C(3)  - Unidade (1)
    this_cCunips    = ""   && C(3)  - Unidade (2)

    *-- Pesos e dimensoes
    this_nPesobs    = 0    && N(7,3) - Peso bruto
    this_nPesoms    = 0    && N(8,3) - Peso medio/liquido

    *-- Localizacao
    this_cLocals    = ""   && C(10) - Local

    *-- Precos e custos
    this_nPvens     = 0    && N(11,5) - Preco de venda
    this_nFvendas   = 0    && N(7,3)  - Fator de venda
    this_nPcuss     = 0    && N(11,5) - Preco de custo
    this_cMoecs     = ""   && C(3)   - Moeda de custo
    this_cMoepvs    = ""   && C(3)   - Moeda de venda

    *-- Ultima compra
    this_dUltcomps  = {}   && Date  - Data da ultima compra
    this_nVultcomps = 0    && N(11,2) - Valor da ultima compra
    this_cMultcomps = ""   && C(3)   - Moeda da ultima compra
    this_nQultcomp  = 0    && N(9,3) - Qtde da ultima compra

    *-- Dias de garantia
    this_nDiasinas  = 0    && N(5,0) - Dias de garantia/inatividade

    *-- Checkboxes
    this_nConsigs   = 0    && N(1) - Consignado
    this_nFabrproprs= 0    && N(1) - Fabricacao propria
    this_nEncoms    = 0    && N(1) - Encomenda
    this_nChkfunds  = 0    && N(1) - Fundo

    *-- Observacoes
    this_cObspeds   = ""   && C(30) - Observacao 1
    this_cObspes    = ""   && C(30) - Observacao 2
    this_cObsetqs   = ""   && C(10) - Observacao componente

    *-- Memos (text fields)
    this_cDpro3s    = ""   && text  - Descricao completa
    this_cDsccompras= ""   && text  - Descricao compra
    this_cObscompras= ""   && text  - Observacao compra

    *-- Variacao e web
    this_nVarias    = 0    && N(1) - Variacao (0=nenhum, 1=cor-tam)
    this_nWebpros   = 0    && N(1) - Produto web (0=nenhum, 1=sim, 2=nao, 3=destaque)

    *-- Dimensoes
    this_nTamhs     = 0    && N(5,2) - Altura
    this_nTamls     = 0    && N(5,2) - Largura
    this_nTamps     = 0    && N(5,2) - Profundidade
    this_nVolumes   = 0    && N(3,0) - Volumes
    this_nTents     = 0    && N(3,0) - Entradas

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cCpros
    ENDPROC

    *--------------------------------------------------------------------------
    * NovoRegistro - Limpa propriedades para inclusao
    *--------------------------------------------------------------------------
    PROCEDURE NovoRegistro()
        DODEFAULT()
        THIS.this_cCpros      = ""
        THIS.this_cDpros      = ""
        THIS.this_cDpro2s     = ""
        THIS.this_cCgrus      = ""
        THIS.this_cSgrus      = ""
        THIS.this_cLinhas     = ""
        THIS.this_cColecoes   = ""
        THIS.this_cMercs      = ""
        THIS.this_cIdecpros   = ""
        THIS.this_cCclass     = ""
        THIS.this_cIfors      = ""
        THIS.this_cReffs      = ""
        THIS.this_cCodfinp    = ""
        THIS.this_cCodacbs    = ""
        THIS.this_cCodcors    = ""
        THIS.this_cCodtams    = ""
        THIS.this_cCproeqs    = ""
        THIS.this_nSituas     = 1
        THIS.this_dDatas      = DATE()
        THIS.this_dDtincs     = DATE()
        THIS.this_cUsuincs    = gc_4c_UsuarioLogado
        THIS.this_nCbars      = 0
        THIS.this_nEan13      = 0
        THIS.this_nLtminsv    = 0
        THIS.this_nQmins      = 0
        THIS.this_nQtped      = 0
        THIS.this_cCunis      = ""
        THIS.this_cCunips     = ""
        THIS.this_nPesobs     = 0
        THIS.this_nPesoms     = 0
        THIS.this_cLocals     = ""
        THIS.this_nPvens      = 0
        THIS.this_nFvendas    = 1
        THIS.this_nPcuss      = 0
        THIS.this_cMoecs      = ""
        THIS.this_cMoepvs     = ""
        THIS.this_dUltcomps   = {}
        THIS.this_nVultcomps  = 0
        THIS.this_cMultcomps  = ""
        THIS.this_nQultcomp   = 0
        THIS.this_nDiasinas   = 0
        THIS.this_nConsigs    = 0
        THIS.this_nFabrproprs = 0
        THIS.this_nEncoms     = 0
        THIS.this_nChkfunds   = 0
        THIS.this_cObspeds    = ""
        THIS.this_cObspes     = ""
        THIS.this_cObsetqs    = ""
        THIS.this_cDpro3s     = ""
        THIS.this_cDsccompras = ""
        THIS.this_cObscompras = ""
        THIS.this_nVarias     = 0
        THIS.this_nWebpros    = 0
        THIS.this_nTamhs      = 0
        THIS.this_nTamls      = 0
        THIS.this_nTamps      = 0
        THIS.this_nVolumes    = 0
        THIS.this_nTents      = 0
    ENDPROC

    *--------------------------------------------------------------------------
    * EditarRegistro - Prepara para edicao (dados ja carregados via CarregarPorCodigo)
    *--------------------------------------------------------------------------
    PROCEDURE EditarRegistro()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega cursor_4c_Dados com registros conforme filtro
    * par_cFiltro: "" = todos | "WHERE ..." = com filtro
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_aErros(1)
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .T.
            ELSE
                loc_cSQL = "SELECT " + ;
                    "ISNULL(CPros,'')       AS cpros, " + ;
                    "ISNULL(DPros,'')       AS dpros, " + ;
                    "ISNULL(DPro2s,'')      AS dpro2s, " + ;
                    "ISNULL(CGrus,'')       AS cgrus, " + ;
                    "ISNULL(SGrus,'')       AS sgrus, " + ;
                    "ISNULL(Linhas,'')      AS linhas, " + ;
                    "ISNULL(Colecoes,'')    AS colecoes, " + ;
                    "ISNULL(Mercs,'')       AS mercs, " + ;
                    "ISNULL(IdeCPros,'')    AS idecpros, " + ;
                    "ISNULL(CClass,'')      AS cclass, " + ;
                    "ISNULL(IFors,'')       AS ifors, " + ;
                    "ISNULL(Reffs,'')       AS reffs, " + ;
                    "ISNULL(CodFinP,'')     AS codfinp, " + ;
                    "ISNULL(CodAcbs,'')     AS codacbs, " + ;
                    "ISNULL(CodCors,'')     AS codcors, " + ;
                    "ISNULL(CodTams,'')     AS codtams, " + ;
                    "ISNULL(CProEqs,'')     AS cproeqs, " + ;
                    "ISNULL(Situas,1)       AS situas, " + ;
                    "ISNULL(Datas,GETDATE()) AS datas, " + ;
                    "ISNULL(DtIncs,GETDATE()) AS dtincs, " + ;
                    "ISNULL(UsuIncs,'')     AS usuincs, " + ;
                    "ISNULL(CBars,0)        AS cbars, " + ;
                    "ISNULL(EAN13,0)        AS ean13, " + ;
                    "ISNULL(LtMinsV,0)      AS ltminsv, " + ;
                    "ISNULL(QMins,0)        AS qmins, " + ;
                    "ISNULL(QtPed,0)        AS qtped, " + ;
                    "ISNULL(Locals,'')      AS locals, " + ;
                    "ISNULL(CUnis,'')       AS cunis, " + ;
                    "ISNULL(CUniPs,'')      AS cunips, " + ;
                    "ISNULL(PesoBS,0)       AS pesobs, " + ;
                    "ISNULL(PesoMs,0)       AS pesoms, " + ;
                    "ISNULL(PVens,0)        AS pvens, " + ;
                    "ISNULL(FVendas,1)      AS fvendas, " + ;
                    "ISNULL(PCuss,0)        AS pcuss, " + ;
                    "ISNULL(MoECs,'')       AS moecs, " + ;
                    "ISNULL(MoePVs,'')      AS moepvs, " + ;
                    "ISNULL(UltComps,NULL)  AS ultcomps, " + ;
                    "ISNULL(VultComps,0)    AS vultcomps, " + ;
                    "ISNULL(MultComps,'')   AS multcomps, " + ;
                    "ISNULL(qtdultcomp,0)   AS qultcomp, " + ;
                    "ISNULL(DiasINas,0)     AS diasinas, " + ;
                    "ISNULL(ConSigs,0)      AS consigs, " + ;
                    "ISNULL(FabrProprs,0)   AS fabrproprs, " + ;
                    "ISNULL(EnComs,0)       AS encoms, " + ;
                    "ISNULL(ChkFunds,0)     AS chkfunds, " + ;
                    "ISNULL(ObsPeds,'')     AS obspeds, " + ;
                    "ISNULL(ObsPes,'')      AS obspes, " + ;
                    "ISNULL(ObsEtqs,'')     AS obsetqs, " + ;
                    "ISNULL(DPro3s,'')      AS dpro3s, " + ;
                    "ISNULL(DscCompras,'')  AS dsccompras, " + ;
                    "ISNULL(ObsCompras,'')  AS obscompras, " + ;
                    "ISNULL(Varias,0)       AS varias, " + ;
                    "ISNULL(prodwebs,0)     AS webpros, " + ;
                    "ISNULL(TamHs,0)        AS tamhs, " + ;
                    "ISNULL(TamLs,0)        AS tamls, " + ;
                    "ISNULL(TamPs,0)        AS tamps, " + ;
                    "ISNULL(Volumes,0)      AS volumes, " + ;
                    "ISNULL(TEnts,0)        AS tents " + ;
                    "FROM SigCdPro " + par_cFiltro + " ORDER BY CPros"

                IF USED("cursor_4c_Temp_Dados")
                    USE IN cursor_4c_Temp_Dados
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp_Dados")

                IF loc_nRet > 0
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF
                    SELECT cursor_4c_Temp_Dados
                    IF RECCOUNT() > 0
                        SELECT * FROM cursor_4c_Temp_Dados INTO CURSOR cursor_4c_Dados READWRITE
                        SELECT cursor_4c_Dados
                    ELSE
                        SET NULL ON
                        CREATE CURSOR cursor_4c_Dados ;
                            (cpros C(14), dpros C(65), dpro2s C(45), cgrus C(3), sgrus C(6), ;
                             linhas C(10), colecoes C(10), mercs C(3), idecpros C(3), cclass C(3), ;
                             ifors C(10), reffs C(40), codfinp C(3), codacbs C(3), codcors C(4), ;
                             codtams C(4), cproeqs C(14), situas N(1,0), datas D, dtincs D, ;
                             usuincs C(10), cbars N(14,0), ean13 N(13,0), ltminsv N(9,3), ;
                             qmins N(9,3), qtped N(9,3), locals C(10), cunis C(3), cunips C(3), ;
                             pesobs N(7,3), pesoms N(8,3), pvens N(11,5), fvendas N(7,3), ;
                             pcuss N(11,5), moecs C(3), moepvs C(3), ultcomps D, ;
                             vultcomps N(11,2), multcomps C(3), qultcomp N(9,3), ;
                             diasinas N(5,0), consigs N(1,0), fabrproprs N(1,0), ;
                             encoms N(1,0), chkfunds N(1,0), obspeds C(30), obspes C(30), ;
                             obsetqs C(10), dpro3s C(254), dsccompras C(254), obscompras C(254), ;
                             varias N(1,0), webpros N(1,0), tamhs N(5,2), tamls N(5,2), ;
                             tamps N(5,2), volumes N(3,0), tents N(3,0))
                        SET NULL OFF
                    ENDIF
                    IF USED("cursor_4c_Temp_Dados")
                        USE IN cursor_4c_Temp_Dados
                    ENDIF
                    loc_lResultado = .T.
                ELSE
                    AERROR(loc_aErros)
                    THIS.this_cMensagemErro = "Erro SQL ao buscar produtos: " + TRANSFORM(loc_aErros(1,2))
                    IF USED("cursor_4c_Temp_Dados")
                        USE IN cursor_4c_Temp_Dados
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega dados de um produto pelo codigo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nRet, loc_aErros(1)
        loc_lResultado = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lResultado = .T.
            ELSE
                loc_cSQL = "SELECT " + ;
                    "ISNULL(CPros,'')       AS cpros, " + ;
                    "ISNULL(DPros,'')       AS dpros, " + ;
                    "ISNULL(DPro2s,'')      AS dpro2s, " + ;
                    "ISNULL(CGrus,'')       AS cgrus, " + ;
                    "ISNULL(SGrus,'')       AS sgrus, " + ;
                    "ISNULL(Linhas,'')      AS linhas, " + ;
                    "ISNULL(Colecoes,'')    AS colecoes, " + ;
                    "ISNULL(Mercs,'')       AS mercs, " + ;
                    "ISNULL(IdeCPros,'')    AS idecpros, " + ;
                    "ISNULL(CClass,'')      AS cclass, " + ;
                    "ISNULL(IFors,'')       AS ifors, " + ;
                    "ISNULL(Reffs,'')       AS reffs, " + ;
                    "ISNULL(CodFinP,'')     AS codfinp, " + ;
                    "ISNULL(CodAcbs,'')     AS codacbs, " + ;
                    "ISNULL(CodCors,'')     AS codcors, " + ;
                    "ISNULL(CodTams,'')     AS codtams, " + ;
                    "ISNULL(CProEqs,'')     AS cproeqs, " + ;
                    "ISNULL(Situas,1)       AS situas, " + ;
                    "CONVERT(date,ISNULL(Datas,GETDATE())) AS datas, " + ;
                    "CONVERT(date,ISNULL(DtIncs,GETDATE())) AS dtincs, " + ;
                    "ISNULL(UsuIncs,'')     AS usuincs, " + ;
                    "ISNULL(CBars,0)        AS cbars, " + ;
                    "ISNULL(EAN13,0)        AS ean13, " + ;
                    "ISNULL(LtMinsV,0)      AS ltminsv, " + ;
                    "ISNULL(QMins,0)        AS qmins, " + ;
                    "ISNULL(QtPed,0)        AS qtped, " + ;
                    "ISNULL(Locals,'')      AS locals, " + ;
                    "ISNULL(CUnis,'')       AS cunis, " + ;
                    "ISNULL(CUniPs,'')      AS cunips, " + ;
                    "ISNULL(PesoBS,0)       AS pesobs, " + ;
                    "ISNULL(PesoMs,0)       AS pesoms, " + ;
                    "ISNULL(PVens,0)        AS pvens, " + ;
                    "ISNULL(FVendas,1)      AS fvendas, " + ;
                    "ISNULL(PCuss,0)        AS pcuss, " + ;
                    "ISNULL(MoECs,'')       AS moecs, " + ;
                    "ISNULL(MoePVs,'')      AS moepvs, " + ;
                    "CONVERT(date,ISNULL(UltComps,NULL)) AS ultcomps, " + ;
                    "ISNULL(VultComps,0)    AS vultcomps, " + ;
                    "ISNULL(MultComps,'')   AS multcomps, " + ;
                    "ISNULL(qtdultcomp,0)   AS qultcomp, " + ;
                    "ISNULL(DiasINas,0)     AS diasinas, " + ;
                    "ISNULL(ConSigs,0)      AS consigs, " + ;
                    "ISNULL(FabrProprs,0)   AS fabrproprs, " + ;
                    "ISNULL(EnComs,0)       AS encoms, " + ;
                    "ISNULL(ChkFunds,0)     AS chkfunds, " + ;
                    "ISNULL(ObsPeds,'')     AS obspeds, " + ;
                    "ISNULL(ObsPes,'')      AS obspes, " + ;
                    "ISNULL(ObsEtqs,'')     AS obsetqs, " + ;
                    "ISNULL(CONVERT(varchar(2000),DPro3s),'')     AS dpro3s, " + ;
                    "ISNULL(CONVERT(varchar(2000),DscCompras),'') AS dsccompras, " + ;
                    "ISNULL(CONVERT(varchar(2000),ObsCompras),'') AS obscompras, " + ;
                    "ISNULL(Varias,0)       AS varias, " + ;
                    "ISNULL(prodwebs,0)     AS webpros, " + ;
                    "ISNULL(TamHs,0)        AS tamhs, " + ;
                    "ISNULL(TamLs,0)        AS tamls, " + ;
                    "ISNULL(TamPs,0)        AS tamps, " + ;
                    "ISNULL(Volumes,0)      AS volumes, " + ;
                    "ISNULL(TEnts,0)        AS tents " + ;
                    "FROM SigCdPro " + ;
                    "WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCodigo))

                IF USED("cursor_4c_CarregaPro")
                    USE IN cursor_4c_CarregaPro
                ENDIF
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaPro")

                IF loc_nRet > 0 AND RECCOUNT("cursor_4c_CarregaPro") > 0
                    THIS.CarregarDoCursor("cursor_4c_CarregaPro")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado: " + ALLTRIM(par_cCodigo)
                ENDIF

                IF USED("cursor_4c_CarregaPro")
                    USE IN cursor_4c_CarregaPro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao carregar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor ativo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        SELECT (par_cAliasCursor)
        THIS.this_cCpros      = ALLTRIM(cpros)
        THIS.this_cDpros      = ALLTRIM(dpros)
        THIS.this_cDpro2s     = ALLTRIM(dpro2s)
        THIS.this_cCgrus      = ALLTRIM(cgrus)
        THIS.this_cSgrus      = ALLTRIM(sgrus)
        THIS.this_cLinhas     = ALLTRIM(linhas)
        THIS.this_cColecoes   = ALLTRIM(colecoes)
        THIS.this_cMercs      = ALLTRIM(mercs)
        THIS.this_cIdecpros   = ALLTRIM(idecpros)
        THIS.this_cCclass     = ALLTRIM(cclass)
        THIS.this_cIfors      = ALLTRIM(ifors)
        THIS.this_cReffs      = ALLTRIM(reffs)
        THIS.this_cCodfinp    = ALLTRIM(codfinp)
        THIS.this_cCodacbs    = ALLTRIM(codacbs)
        THIS.this_cCodcors    = ALLTRIM(codcors)
        THIS.this_cCodtams    = ALLTRIM(codtams)
        THIS.this_cCproeqs    = ALLTRIM(cproeqs)
        THIS.this_nSituas     = NVL(situas, 1)
        THIS.this_dDatas      = IIF(EMPTY(datas), DATE(), datas)
        THIS.this_dDtincs     = IIF(EMPTY(dtincs), DATE(), dtincs)
        THIS.this_cUsuincs    = ALLTRIM(usuincs)
        THIS.this_nCbars      = NVL(cbars, 0)
        THIS.this_nEan13      = NVL(ean13, 0)
        THIS.this_nLtminsv    = NVL(ltminsv, 0)
        THIS.this_nQmins      = NVL(qmins, 0)
        THIS.this_nQtped      = NVL(qtped, 0)
        THIS.this_cLocals     = ALLTRIM(locals)
        THIS.this_cCunis      = ALLTRIM(cunis)
        THIS.this_cCunips     = ALLTRIM(cunips)
        THIS.this_nPesobs     = NVL(pesobs, 0)
        THIS.this_nPesoms     = NVL(pesoms, 0)
        THIS.this_nPvens      = NVL(pvens, 0)
        THIS.this_nFvendas    = NVL(fvendas, 1)
        THIS.this_nPcuss      = NVL(pcuss, 0)
        THIS.this_cMoecs      = ALLTRIM(moecs)
        THIS.this_cMoepvs     = ALLTRIM(moepvs)
        THIS.this_dUltcomps   = IIF(EMPTY(ultcomps), {}, ultcomps)
        THIS.this_nVultcomps  = NVL(vultcomps, 0)
        THIS.this_cMultcomps  = ALLTRIM(multcomps)
        THIS.this_nQultcomp   = NVL(qultcomp, 0)
        THIS.this_nDiasinas   = NVL(diasinas, 0)
        THIS.this_nConsigs    = NVL(consigs, 0)
        THIS.this_nFabrproprs = NVL(fabrproprs, 0)
        THIS.this_nEncoms     = NVL(encoms, 0)
        THIS.this_nChkfunds   = NVL(chkfunds, 0)
        THIS.this_cObspeds    = ALLTRIM(obspeds)
        THIS.this_cObspes     = ALLTRIM(obspes)
        THIS.this_cObsetqs    = ALLTRIM(obsetqs)
        THIS.this_cDpro3s     = ALLTRIM(dpro3s)
        THIS.this_cDsccompras = ALLTRIM(dsccompras)
        THIS.this_cObscompras = ALLTRIM(obscompras)
        THIS.this_nVarias     = NVL(varias, 0)
        THIS.this_nWebpros    = NVL(webpros, 0)
        THIS.this_nTamhs      = NVL(tamhs, 0)
        THIS.this_nTamls      = NVL(tamls, 0)
        THIS.this_nTamps      = NVL(tamps, 0)
        THIS.this_nVolumes    = NVL(volumes, 0)
        THIS.this_nTents      = NVL(tents, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo produto em SigCdPro
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            *-- Verificar codigo duplicado
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                LOCAL loc_nExiste
                loc_nExiste = 0
                SQLEXEC(gnConnHandle, "SELECT COUNT(*) AS nExiste FROM SigCdPro WHERE CPros = " + ;
                    EscaparSQL(THIS.this_cCpros), "cursor_4c_ChkPro")
                IF USED("cursor_4c_ChkPro")
                    SELECT cursor_4c_ChkPro
                    loc_nExiste = nExiste
                    USE IN cursor_4c_ChkPro
                ENDIF
                IF loc_nExiste > 0
                    THIS.this_cMensagemErro = "Produto j" + CHR(225) + " existe: " + ALLTRIM(THIS.this_cCpros)
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            loc_cSQL = THIS.MontarSQL_INSERT()
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros(1)
                AERROR(loc_aErros)
                THIS.this_cMensagemErro = "Erro ao inserir produto: " + TRANSFORM(loc_aErros(1,2))
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao inserir produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza produto existente
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_cSQL = THIS.MontarSQL_UPDATE()
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                LOCAL loc_aErros(1)
                AERROR(loc_aErros)
                THIS.this_cMensagemErro = "Erro ao atualizar produto: " + TRANSFORM(loc_aErros(1,2))
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove produto (chamado por Excluir() da BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_nRet
        loc_lResultado = .F.

        TRY
            loc_nRet = SQLEXEC(gnConnHandle, "DELETE FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(THIS.this_cCpros))
            IF loc_nRet > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir produto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao excluir produto")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQL_INSERT - Gera SQL de insercao (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQL_INSERT()
        LOCAL loc_cSQL
        loc_cSQL = "INSERT INTO SigCdPro " + ;
            "(CPros, DPros, DPro2s, CGrus, SGrus, Linhas, Colecoes, Mercs, IdeCPros, CClass, " + ;
            " IFors, Reffs, CodFinP, CodAcbs, CodCors, CodTams, CProEqs, Situas, Datas, DtIncs, " + ;
            " UsuIncs, CBars, EAN13, LtMinsV, QMins, QtPed, Locals, CUnis, CUniPs, PesoBS, PesoMs, " + ;
            " PVens, FVendas, PCuss, MoECs, MoePVs, UltComps, VultComps, MultComps, qtdultcomp, " + ;
            " DiasINas, ConSigs, FabrProprs, EnComs, ChkFunds, ObsPeds, ObsPes, " + ;
            " ObsEtqs, DPro3s, DscCompras, ObsCompras, Varias, prodwebs, TamHs, TamLs, TamPs, " + ;
            " Volumes, TEnts) " + ;
            "VALUES (" + ;
            EscaparSQL(THIS.this_cCpros)                     + ", " + ;
            EscaparSQL(THIS.this_cDpros)                     + ", " + ;
            EscaparSQL(THIS.this_cDpro2s)                    + ", " + ;
            EscaparSQL(PADR(THIS.this_cCgrus,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cSgrus,6))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cLinhas,10))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cColecoes,10))         + ", " + ;
            EscaparSQL(PADR(THIS.this_cMercs,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cIdecpros,3))          + ", " + ;
            EscaparSQL(PADR(THIS.this_cCclass,3))            + ", " + ;
            EscaparSQL(PADR(THIS.this_cIfors,10))            + ", " + ;
            EscaparSQL(THIS.this_cReffs)                     + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodfinp,3))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodacbs,3))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodcors,4))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCodtams,4))           + ", " + ;
            EscaparSQL(THIS.this_cCproeqs)                   + ", " + ;
            FormatarNumeroSQL(THIS.this_nSituas)              + ", " + ;
            FormatarDataSQL(THIS.this_dDatas)                 + ", " + ;
            FormatarDataSQL(DATE())                           + ", " + ;
            EscaparSQL(gc_4c_UsuarioLogado)                  + ", " + ;
            FormatarNumeroSQL(THIS.this_nCbars)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nEan13)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nLtminsv)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nQmins)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nQtped)               + ", " + ;
            EscaparSQL(PADR(THIS.this_cLocals,10))           + ", " + ;
            EscaparSQL(PADR(THIS.this_cCunis,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cCunips,3))            + ", " + ;
            FormatarNumeroSQL(THIS.this_nPesobs)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nPesoms)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nPvens)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nFvendas)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nPcuss)               + ", " + ;
            EscaparSQL(PADR(THIS.this_cMoecs,3))             + ", " + ;
            EscaparSQL(PADR(THIS.this_cMoepvs,3))            + ", " + ;
            FormatarDataSQL(THIS.this_dUltcomps)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nVultcomps)           + ", " + ;
            EscaparSQL(PADR(THIS.this_cMultcomps,3))          + ", " + ;
            FormatarNumeroSQL(THIS.this_nQultcomp)            + ", " + ;
            FormatarNumeroSQL(THIS.this_nDiasinas)            + ", " + ;
            FormatarNumeroSQL(THIS.this_nConsigs)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nFabrproprs)          + ", " + ;
            FormatarNumeroSQL(THIS.this_nEncoms)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nChkfunds)            + ", " + ;
            EscaparSQL(THIS.this_cObspeds)                   + ", " + ;
            EscaparSQL(THIS.this_cObspes)                    + ", " + ;
            EscaparSQL(THIS.this_cObsetqs)                   + ", " + ;
            EscaparSQL(THIS.this_cDpro3s)                    + ", " + ;
            EscaparSQL(THIS.this_cDsccompras)                + ", " + ;
            EscaparSQL(THIS.this_cObscompras)                + ", " + ;
            FormatarNumeroSQL(THIS.this_nVarias)              + ", " + ;
            FormatarNumeroSQL(THIS.this_nWebpros)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamhs)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamls)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nTamps)               + ", " + ;
            FormatarNumeroSQL(THIS.this_nVolumes)             + ", " + ;
            FormatarNumeroSQL(THIS.this_nTents)               + ")"

        RETURN loc_cSQL
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarSQL_UPDATE - Gera SQL de atualizacao (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarSQL_UPDATE()
        LOCAL loc_cSQL
        loc_cSQL = "UPDATE SigCdPro SET " + ;
            "DPros = "       + EscaparSQL(THIS.this_cDpros)              + ", " + ;
            "DPro2s = "      + EscaparSQL(THIS.this_cDpro2s)             + ", " + ;
            "CGrus = "       + EscaparSQL(PADR(THIS.this_cCgrus,3))      + ", " + ;
            "SGrus = "       + EscaparSQL(PADR(THIS.this_cSgrus,6))      + ", " + ;
            "Linhas = "      + EscaparSQL(PADR(THIS.this_cLinhas,10))    + ", " + ;
            "Colecoes = "    + EscaparSQL(PADR(THIS.this_cColecoes,10))  + ", " + ;
            "Mercs = "       + EscaparSQL(PADR(THIS.this_cMercs,3))      + ", " + ;
            "IdeCPros = "    + EscaparSQL(PADR(THIS.this_cIdecpros,3))   + ", " + ;
            "CClass = "      + EscaparSQL(PADR(THIS.this_cCclass,3))     + ", " + ;
            "IFors = "       + EscaparSQL(PADR(THIS.this_cIfors,10))     + ", " + ;
            "Reffs = "       + EscaparSQL(THIS.this_cReffs)              + ", " + ;
            "CodFinP = "     + EscaparSQL(PADR(THIS.this_cCodfinp,3))    + ", " + ;
            "CodAcbs = "     + EscaparSQL(PADR(THIS.this_cCodacbs,3))    + ", " + ;
            "CodCors = "     + EscaparSQL(PADR(THIS.this_cCodcors,4))    + ", " + ;
            "CodTams = "     + EscaparSQL(PADR(THIS.this_cCodtams,4))    + ", " + ;
            "CProEqs = "     + EscaparSQL(THIS.this_cCproeqs)            + ", " + ;
            "Situas = "      + FormatarNumeroSQL(THIS.this_nSituas)       + ", " + ;
            "Datas = "       + FormatarDataSQL(THIS.this_dDatas)          + ", " + ;
            "CBars = "       + FormatarNumeroSQL(THIS.this_nCbars)        + ", " + ;
            "EAN13 = "       + FormatarNumeroSQL(THIS.this_nEan13)        + ", " + ;
            "LtMinsV = "     + FormatarNumeroSQL(THIS.this_nLtminsv)      + ", " + ;
            "QMins = "       + FormatarNumeroSQL(THIS.this_nQmins)        + ", " + ;
            "QtPed = "       + FormatarNumeroSQL(THIS.this_nQtped)       + ", " + ;
            "Locals = "      + EscaparSQL(PADR(THIS.this_cLocals,10))    + ", " + ;
            "CUnis = "       + EscaparSQL(PADR(THIS.this_cCunis,3))      + ", " + ;
            "CUniPs = "      + EscaparSQL(PADR(THIS.this_cCunips,3))     + ", " + ;
            "PesoBS = "      + FormatarNumeroSQL(THIS.this_nPesobs)       + ", " + ;
            "PesoMs = "      + FormatarNumeroSQL(THIS.this_nPesoms)       + ", " + ;
            "PVens = "       + FormatarNumeroSQL(THIS.this_nPvens)        + ", " + ;
            "FVendas = "     + FormatarNumeroSQL(THIS.this_nFvendas)      + ", " + ;
            "PCuss = "       + FormatarNumeroSQL(THIS.this_nPcuss)        + ", " + ;
            "MoECs = "       + EscaparSQL(PADR(THIS.this_cMoecs,3))      + ", " + ;
            "MoePVs = "      + EscaparSQL(PADR(THIS.this_cMoepvs,3))     + ", " + ;
            "UltComps = "    + FormatarDataSQL(THIS.this_dUltcomps)       + ", " + ;
            "VultComps = "   + FormatarNumeroSQL(THIS.this_nVultcomps)    + ", " + ;
            "MultComps = "   + EscaparSQL(PADR(THIS.this_cMultcomps,3))   + ", " + ;
            "qtdultcomp = "  + FormatarNumeroSQL(THIS.this_nQultcomp)     + ", " + ;
            "DiasINas = "    + FormatarNumeroSQL(THIS.this_nDiasinas)     + ", " + ;
            "ConSigs = "     + FormatarNumeroSQL(THIS.this_nConsigs)      + ", " + ;
            "FabrProprs = "  + FormatarNumeroSQL(THIS.this_nFabrproprs)   + ", " + ;
            "EnComs = "      + FormatarNumeroSQL(THIS.this_nEncoms)       + ", " + ;
            "ChkFunds = "    + FormatarNumeroSQL(THIS.this_nChkfunds)    + ", " + ;
            "ObsPeds = "     + EscaparSQL(THIS.this_cObspeds)            + ", " + ;
            "ObsPes = "      + EscaparSQL(THIS.this_cObspes)             + ", " + ;
            "ObsEtqs = "     + EscaparSQL(THIS.this_cObsetqs)            + ", " + ;
            "DPro3s = "      + EscaparSQL(THIS.this_cDpro3s)             + ", " + ;
            "DscCompras = "  + EscaparSQL(THIS.this_cDsccompras)         + ", " + ;
            "ObsCompras = "  + EscaparSQL(THIS.this_cObscompras)         + ", " + ;
            "Varias = "      + FormatarNumeroSQL(THIS.this_nVarias)       + ", " + ;
            "prodwebs = "    + FormatarNumeroSQL(THIS.this_nWebpros)      + ", " + ;
            "TamHs = "       + FormatarNumeroSQL(THIS.this_nTamhs)        + ", " + ;
            "TamLs = "       + FormatarNumeroSQL(THIS.this_nTamls)        + ", " + ;
            "TamPs = "       + FormatarNumeroSQL(THIS.this_nTamps)        + ", " + ;
            "Volumes = "     + FormatarNumeroSQL(THIS.this_nVolumes)      + ", " + ;
            "TEnts = "       + FormatarNumeroSQL(THIS.this_nTents)        + " " + ;
            "WHERE CPros = " + EscaparSQL(THIS.this_cCpros)

        RETURN loc_cSQL
    ENDPROC

ENDDEFINE

