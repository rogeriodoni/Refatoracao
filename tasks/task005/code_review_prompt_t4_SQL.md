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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS SQL (5784 linhas total):

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

*-- Linhas 918 a 936:
918:     *--------------------------------------------------------------------------
919:     * ConfigurarPgDados1 - Page1 dos Dados Internos (pgDados) - Parte 1/2
920:     * Campos: identificacao, grupos, fornecedor, codigos, status, EAN, Cor, Tam
921:     * Top values: FROM layout.json AS-IS (sem compensacao - pageframe interno)
922:     *--------------------------------------------------------------------------
923:     PROTECTED PROCEDURE ConfigurarPgDados1()
924:         LOCAL loc_oPg1
925:         loc_oPg1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInternos.Page1
926: 
927:         *----------------------------------------------------------------------
928:         *-- ROW 1 (Top=130): Produto + Descricao + Status + DtSituas
929:         *----------------------------------------------------------------------
930:         *-- Label "Produto:" (top=134, left=58, w=53)
931:         loc_oPg1.AddObject("lbl_4c_LblProduto", "Label")
932:         WITH loc_oPg1.lbl_4c_LblProduto
933:             .Caption   = "Produto :"
934:             .Top       = 134
935:             .Left      = 58
936:             .Width     = 53

*-- Linhas 3213 a 3231:
3213:     * CarregarLista - Carrega grid da pagina Lista com dados do SQL Server
3214:     * Filtros: getCgru (grupo), getDtIni/getDtFim (DataAlts), optFilSituas (Situas)
3215:     * Situacao: Situas=1 Ativo(verde/preto), Situas=2 Inativo(vermelho)
3216:     * Padrao SQLEXEC: query em temp ? ZAP cursor_4c_Lista ? APPEND FROM DBF
3217:     *--------------------------------------------------------------------------
3218:     PROCEDURE CarregarLista()
3219:         LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cCgru, loc_dIni, loc_dFim
3220:         LOCAL loc_nStI, loc_nStF, loc_cFiltroGrupo, loc_cFiltroSitua, loc_oGrid, loc_oPg1
3221:         LOCAL loc_aErros(1)
3222:         loc_lSucesso = .F.
3223: 
3224:         TRY
3225:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
3226:                 loc_lSucesso = .T.
3227:             ELSE
3228:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
3229: 
3230:                 *-- Ler filtros com defaults seguros
3231:                 loc_cCgru = ""

*-- Linhas 3260 a 3312:
3260:                 *-- Filtro grupo (opcional - se vazio carrega todos)
3261:                 loc_cFiltroGrupo = ""
3262:                 IF !EMPTY(loc_cCgru)
3263:                     loc_cFiltroGrupo = " AND CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
3264:                 ENDIF
3265: 
3266:                 *-- Filtro situacao: Situas IN (loc_nStI, loc_nStF)
3267:                 loc_cFiltroSitua = " AND ISNULL(Situas, 1) IN (" + ;
3268:                     TRANSFORM(loc_nStI) + "," + TRANSFORM(loc_nStF) + ")"
3269: 
3270:                 *-- Montar SQL com ISNULL para campos potencialmente nulos
3271:                 loc_cSQL = "SELECT " + ;
3272:                     "ISNULL(CPros,'') AS cpros, " + ;
3273:                     "ISNULL(DPros,'') AS dpros, " + ;
3274:                     "ISNULL(CGrus,'') AS cgrus, " + ;
3275:                     "ISNULL(SGrus,'') AS sgrus, " + ;
3276:                     "ISNULL(Reffs,'') AS reffs, " + ;
3277:                     "ISNULL(Colecoes,'') AS colecoes, " + ;
3278:                     "CAST(ISNULL(ImpEtiqs,0) AS BIT) AS ImpEtiqs, " + ;
3279:                     "ISNULL(Situas,1) AS Situas " + ;
3280:                     "FROM SigCdPro " + ;
3281:                     "WHERE CONVERT(date, ISNULL(DataAlts,'19000101')) >= " + FormatarDataSQL(loc_dIni) + ;
3282:                     " AND CONVERT(date, ISNULL(DataAlts,'19000101')) <= " + FormatarDataSQL(loc_dFim) + ;
3283:                     loc_cFiltroGrupo + loc_cFiltroSitua + ;
3284:                     " ORDER BY CPros"
3285: 
3286:                 *-- Executar query em cursor temporario
3287:                 IF USED("cursor_4c_Temp_Pro")
3288:                     USE IN cursor_4c_Temp_Pro
3289:                 ENDIF
3290:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Temp_Pro")
3291: 
3292:                 IF loc_nResult > 0
3293:                     *-- ZAP + APPEND mantem RecordSource do grid intacto (nao destroi colunas)
3294:                     SELECT cursor_4c_Lista
3295:                     ZAP
3296:                     IF RECCOUNT("cursor_4c_Temp_Pro") > 0
3297:                         APPEND FROM DBF("cursor_4c_Temp_Pro")
3298:                     ENDIF
3299:                     IF USED("cursor_4c_Temp_Pro")
3300:                         USE IN cursor_4c_Temp_Pro
3301:                     ENDIF
3302:                     GO TOP IN cursor_4c_Lista
3303:                 ELSE
3304:                     AERROR(loc_aErros)
3305:                     MsgErro("Erro ao consultar produtos:" + CHR(13) + ;
3306:                         TRANSFORM(loc_aErros(1, 2)), "Erro SQL")
3307:                     IF USED("cursor_4c_Temp_Pro")
3308:                         USE IN cursor_4c_Temp_Pro
3309:                     ENDIF
3310:                 ENDIF
3311: 
3312:                 *-- Atualizar contador

*-- Linhas 3740 a 3758:
3740:                 USE IN cursor_4c_Busca
3741:             ENDIF
3742:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3743:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
3744:             ENDIF
3745:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
3746:             IF !ISNULL(loc_oBusca)
3747:                 loc_oBusca.this_cTabela        = "SigCdPro"
3748:                 loc_oBusca.this_cCampoChave    = "cpros"
3749:                 loc_oBusca.this_cCampoBusca    = "cpros"
3750:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
3751:                 loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
3752:                 loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
3753:                 loc_oBusca.Caption = "Buscar Produto"
3754:                 loc_oBusca.Show()
3755:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
3756:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cpros)
3757:                 ENDIF
3758:                 IF USED("cursor_4c_Busca")

*-- Linhas 3984 a 4004:
3984:             loc_oPg1.txt_4c_Dgru.Value = ""
3985:         ELSE
3986:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3987:                 loc_cSQL    = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
3988:                               "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
3989:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruD")
3990:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruD") > 0
3991:                     loc_oPg1.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruD.DGrus)
3992:                 ELSE
3993:                     loc_oPg1.txt_4c_Dgru.Value = ""
3994:                     loc_oPg1.txt_4c_Cgru.Value = ""
3995:                     MsgAviso("Grupo n" + CHR(227) + "o encontrado: " + loc_cCgru, "Aviso")
3996:                 ENDIF
3997:                 IF USED("cursor_4c_GruD")
3998:                     USE IN cursor_4c_GruD
3999:                 ENDIF
4000:             ENDIF
4001:         ENDIF
4002:         THIS.CarregarLista()
4003:     ENDPROC
4004: 

*-- Linhas 4013 a 4033:
4013:             loc_oPg1.txt_4c_DLin.Value = ""
4014:         ELSE
4015:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4016:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdLin " + ;
4017:                               "WHERE Linhas = " + EscaparSQL(PADR(loc_cLin, 10))
4018:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinD")
4019:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LinD") > 0
4020:                     loc_oPg1.txt_4c_DLin.Value = ALLTRIM(cursor_4c_LinD.Descs)
4021:                 ELSE
4022:                     loc_oPg1.txt_4c_DLin.Value = ""
4023:                     loc_oPg1.txt_4c_Lin.Value  = ""
4024:                     MsgAviso("Linha n" + CHR(227) + "o encontrada: " + loc_cLin, "Aviso")
4025:                 ENDIF
4026:                 IF USED("cursor_4c_LinD")
4027:                     USE IN cursor_4c_LinD
4028:                 ENDIF
4029:             ENDIF
4030:         ENDIF
4031:         THIS.CarregarLista()
4032:     ENDPROC
4033: 

*-- Linhas 4042 a 4062:
4042:             loc_oPg1.txt_4c_DCol.Value = ""
4043:         ELSE
4044:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4045:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SIGCDCOL " + ;
4046:                               "WHERE Colecoes = " + EscaparSQL(PADR(loc_cCol, 10))
4047:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColD")
4048:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ColD") > 0
4049:                     loc_oPg1.txt_4c_DCol.Value = ALLTRIM(cursor_4c_ColD.Descs)
4050:                 ELSE
4051:                     loc_oPg1.txt_4c_DCol.Value = ""
4052:                     loc_oPg1.txt_4c_Col.Value  = ""
4053:                     MsgAviso("Cole" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cCol, "Aviso")
4054:                 ENDIF
4055:                 IF USED("cursor_4c_ColD")
4056:                     USE IN cursor_4c_ColD
4057:                 ENDIF
4058:             ENDIF
4059:         ENDIF
4060:         THIS.CarregarLista()
4061:     ENDPROC
4062: 

*-- Linhas 4071 a 4091:
4071:             loc_oPg1.txt_4c_Dfor.Value = ""
4072:         ELSE
4073:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4074:                 loc_cSQL    = "SELECT ISNULL(RClis,'') AS RClis FROM SIGCDCLI " + ;
4075:                               "WHERE IClis = " + EscaparSQL(PADR(loc_cIfor, 10))
4076:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_IforD")
4077:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_IforD") > 0
4078:                     loc_oPg1.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_IforD.RClis)
4079:                 ELSE
4080:                     loc_oPg1.txt_4c_Dfor.Value = ""
4081:                     loc_oPg1.txt_4c_Ifor.Value = ""
4082:                     MsgAviso("Fornecedor n" + CHR(227) + "o encontrado: " + loc_cIfor, "Aviso")
4083:                 ENDIF
4084:                 IF USED("cursor_4c_IforD")
4085:                     USE IN cursor_4c_IforD
4086:                 ENDIF
4087:             ENDIF
4088:         ENDIF
4089:         THIS.CarregarLista()
4090:     ENDPROC
4091: 

*-- Linhas 4100 a 4120:
4100:             *-- Cor vazia e valida (produto sem cor padrao)
4101:         ELSE
4102:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4103:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdCor " + ;
4104:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCor, 4))
4105:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CorD")
4106:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_CorD") > 0
4107:                     IF cursor_4c_CorD.nExiste = 0
4108:                         loc_oPg1.txt_4c_Cor.Value = ""
4109:                         MsgAviso("Cor n" + CHR(227) + "o encontrada: " + loc_cCor, "Aviso")
4110:                     ENDIF
4111:                 ENDIF
4112:                 IF USED("cursor_4c_CorD")
4113:                     USE IN cursor_4c_CorD
4114:                 ENDIF
4115:             ENDIF
4116:         ENDIF
4117:         THIS.CarregarLista()
4118:     ENDPROC
4119: 
4120:     *--------------------------------------------------------------------------

*-- Linhas 4128 a 4148:
4128:             *-- Tamanho vazio e valido (produto sem tamanho padrao)
4129:         ELSE
4130:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4131:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdTam " + ;
4132:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cTam, 4))
4133:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TamD")
4134:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_TamD") > 0
4135:                     IF cursor_4c_TamD.nExiste = 0
4136:                         loc_oPg1.txt_4c_Tam.Value = ""
4137:                         MsgAviso("Tamanho n" + CHR(227) + "o encontrado: " + loc_cTam, "Aviso")
4138:                     ENDIF
4139:                 ENDIF
4140:                 IF USED("cursor_4c_TamD")
4141:                     USE IN cursor_4c_TamD
4142:                 ENDIF
4143:             ENDIF
4144:         ENDIF
4145:         THIS.CarregarLista()
4146:     ENDPROC
4147: 
4148:     *--------------------------------------------------------------------------

*-- Linhas 4156 a 4176:
4156:             loc_oPg1.txt_4c_DesFinP.Value = ""
4157:         ELSE
4158:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4159:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM sigcdmod " + ;
4160:                               "WHERE Codigos = " + EscaparSQL(PADR(loc_cCod, 3))
4161:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ModD")
4162:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ModD") > 0
4163:                     loc_oPg1.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_ModD.Descs)
4164:                 ELSE
4165:                     loc_oPg1.txt_4c_DesFinP.Value = ""
4166:                     loc_oPg1.txt_4c_CodFinP.Value = ""
4167:                     MsgAviso("Modelo n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4168:                 ENDIF
4169:                 IF USED("cursor_4c_ModD")
4170:                     USE IN cursor_4c_ModD
4171:                 ENDIF
4172:             ENDIF
4173:         ENDIF
4174:         THIS.CarregarLista()
4175:     ENDPROC
4176: 

*-- Linhas 4185 a 4205:
4185:             loc_oPg1.txt_4c_Dacb.Value = ""
4186:         ELSE
4187:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4188:                 loc_cSQL    = "SELECT ISNULL(Descrs,'') AS Descrs FROM SigCdAca " + ;
4189:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
4190:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcaD")
4191:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_AcaD") > 0
4192:                     loc_oPg1.txt_4c_Dacb.Value = ALLTRIM(cursor_4c_AcaD.Descrs)
4193:                 ELSE
4194:                     loc_oPg1.txt_4c_Dacb.Value = ""
4195:                     loc_oPg1.txt_4c_Codacb.Value = ""
4196:                     MsgAviso("Acabamento n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4197:                 ENDIF
4198:                 IF USED("cursor_4c_AcaD")
4199:                     USE IN cursor_4c_AcaD
4200:                 ENDIF
4201:             ENDIF
4202:         ENDIF
4203:         THIS.CarregarLista()
4204:     ENDPROC
4205: 

*-- Linhas 4214 a 4234:
4214:             *-- Equivalente vazio e valido
4215:         ELSE
4216:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4217:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdPro " + ;
4218:                               "WHERE CPros = " + EscaparSQL(PADR(loc_cCod, 14))
4219:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EqD")
4220:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_EqD") > 0
4221:                     IF cursor_4c_EqD.nExiste = 0
4222:                         loc_oPg1.txt_4c_CProEq.Value = ""
4223:                         MsgAviso("Produto equivalente n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4224:                     ENDIF
4225:                 ENDIF
4226:                 IF USED("cursor_4c_EqD")
4227:                     USE IN cursor_4c_EqD
4228:                 ENDIF
4229:             ENDIF
4230:         ENDIF
4231:         THIS.CarregarLista()
4232:     ENDPROC
4233: 
4234:     *--------------------------------------------------------------------------

*-- Linhas 4242 a 4262:
4242:             loc_oPg1.txt_4c_DClass.Value = ""
4243:         ELSE
4244:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4245:                 loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdCls " + ;
4246:                               "WHERE Cods = " + EscaparSQL(PADR(loc_cCod, 3))
4247:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClsD")
4248:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ClsD") > 0
4249:                     loc_oPg1.txt_4c_DClass.Value = ALLTRIM(cursor_4c_ClsD.Descs)
4250:                 ELSE
4251:                     loc_oPg1.txt_4c_DClass.Value = ""
4252:                     loc_oPg1.txt_4c_Class.Value  = ""
4253:                     MsgAviso("Classifica" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4254:                 ENDIF
4255:                 IF USED("cursor_4c_ClsD")
4256:                     USE IN cursor_4c_ClsD
4257:                 ENDIF
4258:             ENDIF
4259:         ENDIF
4260:         THIS.CarregarLista()
4261:     ENDPROC
4262: 

*-- Linhas 4269 a 4289:
4269:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Local.Value)
4270:         IF !EMPTY(loc_cCod)
4271:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4272:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigPrLcl " + ;
4273:                               "WHERE Codigos = " + EscaparSQL(PADR(loc_cCod, 10))
4274:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LclD")
4275:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LclD") > 0
4276:                     IF cursor_4c_LclD.nExiste = 0
4277:                         loc_oPg1.txt_4c_Local.Value = ""
4278:                         MsgAviso("Local de estoque n" + CHR(227) + "o encontrado: " + loc_cCod, "Aviso")
4279:                     ENDIF
4280:                 ENDIF
4281:                 IF USED("cursor_4c_LclD")
4282:                     USE IN cursor_4c_LclD
4283:                 ENDIF
4284:             ENDIF
4285:         ENDIF
4286:         THIS.CarregarLista()
4287:     ENDPROC
4288: 
4289:     *--------------------------------------------------------------------------

*-- Linhas 4297 a 4317:
4297:             loc_oPg1.txt_4c_Duni.Value = ""
4298:         ELSE
4299:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4300:                 loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
4301:                               "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
4302:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniD")
4303:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UniD") > 0
4304:                     loc_oPg1.txt_4c_Duni.Value = ALLTRIM(cursor_4c_UniD.DUnis)
4305:                 ELSE
4306:                     loc_oPg1.txt_4c_Duni.Value = ""
4307:                     loc_oPg1.txt_4c_Cuni.Value = ""
4308:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4309:                 ENDIF
4310:                 IF USED("cursor_4c_UniD")
4311:                     USE IN cursor_4c_UniD
4312:                 ENDIF
4313:             ENDIF
4314:         ENDIF
4315:         THIS.CarregarLista()
4316:     ENDPROC
4317: 

*-- Linhas 4326 a 4346:
4326:             loc_oPg1.txt_4c_Dunip.Value = ""
4327:         ELSE
4328:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4329:                 loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
4330:                               "WHERE CUnis = " + EscaparSQL(PADR(loc_cCod, 3))
4331:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UnipD")
4332:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UnipD") > 0
4333:                     loc_oPg1.txt_4c_Dunip.Value = ALLTRIM(cursor_4c_UnipD.DUnis)
4334:                 ELSE
4335:                     loc_oPg1.txt_4c_Dunip.Value = ""
4336:                     loc_oPg1.txt_4c_Cunip.Value = ""
4337:                     MsgAviso("Unidade n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4338:                 ENDIF
4339:                 IF USED("cursor_4c_UnipD")
4340:                     USE IN cursor_4c_UnipD
4341:                 ENDIF
4342:             ENDIF
4343:         ENDIF
4344:         THIS.CarregarLista()
4345:     ENDPROC
4346: 

*-- Linhas 4353 a 4373:
4353:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mctotal.Value)
4354:         IF !EMPTY(loc_cCod)
4355:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4356:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4357:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4358:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeCtD")
4359:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeCtD") > 0
4360:                     IF cursor_4c_MoeCtD.nExiste = 0
4361:                         loc_oPg1.txt_4c_Mctotal.Value = ""
4362:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4363:                     ENDIF
4364:                 ENDIF
4365:                 IF USED("cursor_4c_MoeCtD")
4366:                     USE IN cursor_4c_MoeCtD
4367:                 ENDIF
4368:             ENDIF
4369:         ENDIF
4370:         THIS.CarregarLista()
4371:     ENDPROC
4372: 
4373:     *--------------------------------------------------------------------------

*-- Linhas 4379 a 4399:
4379:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mpvenda.Value)
4380:         IF !EMPTY(loc_cCod)
4381:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4382:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4383:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4384:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoePvD")
4385:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoePvD") > 0
4386:                     IF cursor_4c_MoePvD.nExiste = 0
4387:                         loc_oPg1.txt_4c_Mpvenda.Value = ""
4388:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4389:                     ENDIF
4390:                 ENDIF
4391:                 IF USED("cursor_4c_MoePvD")
4392:                     USE IN cursor_4c_MoePvD
4393:                 ENDIF
4394:             ENDIF
4395:         ENDIF
4396:         THIS.CarregarLista()
4397:     ENDPROC
4398: 
4399:     *--------------------------------------------------------------------------

*-- Linhas 4405 a 4425:
4405:         loc_cCod = ALLTRIM(loc_oPg1.txt_4c_Mfvenda.Value)
4406:         IF !EMPTY(loc_cCod)
4407:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4408:                 loc_cSQL    = "SELECT COUNT(*) AS nExiste FROM SigCdMoe " + ;
4409:                               "WHERE CMoes = " + EscaparSQL(PADR(loc_cCod, 3))
4410:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeFvD")
4411:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MoeFvD") > 0
4412:                     IF cursor_4c_MoeFvD.nExiste = 0
4413:                         loc_oPg1.txt_4c_Mfvenda.Value = ""
4414:                         MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + loc_cCod, "Aviso")
4415:                     ENDIF
4416:                 ENDIF
4417:                 IF USED("cursor_4c_MoeFvD")
4418:                     USE IN cursor_4c_MoeFvD
4419:                 ENDIF
4420:             ENDIF
4421:         ENDIF
4422:         THIS.CarregarLista()
4423:     ENDPROC
4424: 
4425:     *==========================================================================

*-- Linhas 4439 a 4457:
4439:                 USE IN cursor_4c_Busca
4440:             ENDIF
4441:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4442:                 SQLEXEC(gnConnHandle, "SELECT CGrus AS cgrus, DGrus AS dgrus FROM SigCdGrp ORDER BY CGrus", "cursor_4c_Busca")
4443:             ENDIF
4444:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4445:             IF !ISNULL(loc_oBusca)
4446:                 loc_oBusca.this_cTabela        = "SigCdGrp"
4447:                 loc_oBusca.this_cCampoChave    = "cgrus"
4448:                 loc_oBusca.this_cCampoBusca    = "cgrus"
4449:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4450:                 loc_oBusca.mAddColuna("cgrus", "XXXXX",                                  "Grupo")
4451:                 loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4452:                 loc_oBusca.Caption = "Buscar Grupo de Produto"
4453:                 loc_oBusca.Show()
4454:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4455:                     loc_cCgru = ALLTRIM(cursor_4c_Busca.cgrus)
4456:                     loc_cDgru = ALLTRIM(cursor_4c_Busca.dgrus)
4457:                 ENDIF

*-- Linhas 4484 a 4502:
4484:                 USE IN cursor_4c_Busca
4485:             ENDIF
4486:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4487:                 SQLEXEC(gnConnHandle, "SELECT Linhas AS linhas, Descs AS descs FROM SigCdLin ORDER BY Linhas", "cursor_4c_Busca")
4488:             ENDIF
4489:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4490:             IF !ISNULL(loc_oBusca)
4491:                 loc_oBusca.this_cTabela        = "SigCdLin"
4492:                 loc_oBusca.this_cCampoChave    = "linhas"
4493:                 loc_oBusca.this_cCampoBusca    = "linhas"
4494:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4495:                 loc_oBusca.mAddColuna("linhas", "XXXXXXXXXX",                               "Linha")
4496:                 loc_oBusca.mAddColuna("descs",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4497:                 loc_oBusca.Caption = "Buscar Linha"
4498:                 loc_oBusca.Show()
4499:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4500:                     loc_cLin  = ALLTRIM(cursor_4c_Busca.linhas)
4501:                     loc_cDLin = ALLTRIM(cursor_4c_Busca.descs)
4502:                 ENDIF

*-- Linhas 4529 a 4547:
4529:                 USE IN cursor_4c_Busca
4530:             ENDIF
4531:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4532:                 SQLEXEC(gnConnHandle, "SELECT Colecoes AS colecoes, Descs AS descs FROM SIGCDCOL ORDER BY Colecoes", "cursor_4c_Busca")
4533:             ENDIF
4534:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4535:             IF !ISNULL(loc_oBusca)
4536:                 loc_oBusca.this_cTabela        = "SIGCDCOL"
4537:                 loc_oBusca.this_cCampoChave    = "colecoes"
4538:                 loc_oBusca.this_cCampoBusca    = "colecoes"
4539:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4540:                 loc_oBusca.mAddColuna("colecoes", "XXXXXXXXXX",                               "Cole" + CHR(231) + CHR(227) + "o")
4541:                 loc_oBusca.mAddColuna("descs",    "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4542:                 loc_oBusca.Caption = "Buscar Grupo de Venda"
4543:                 loc_oBusca.Show()
4544:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4545:                     loc_cCol  = ALLTRIM(cursor_4c_Busca.colecoes)
4546:                     loc_cDCol = ALLTRIM(cursor_4c_Busca.descs)
4547:                 ENDIF

*-- Linhas 4574 a 4592:
4574:                 USE IN cursor_4c_Busca
4575:             ENDIF
4576:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4577:                 SQLEXEC(gnConnHandle, "SELECT IClis AS iclis, RClis AS rclis FROM SIGCDCLI ORDER BY IClis", "cursor_4c_Busca")
4578:             ENDIF
4579:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4580:             IF !ISNULL(loc_oBusca)
4581:                 loc_oBusca.this_cTabela        = "SIGCDCLI"
4582:                 loc_oBusca.this_cCampoChave    = "iclis"
4583:                 loc_oBusca.this_cCampoBusca    = "iclis"
4584:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4585:                 loc_oBusca.mAddColuna("iclis", "XXXXXXXXXX",                               "Fornecedor")
4586:                 loc_oBusca.mAddColuna("rclis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Raz" + CHR(227) + "o Social")
4587:                 loc_oBusca.Caption = "Buscar Fornecedor"
4588:                 loc_oBusca.Show()
4589:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4590:                     loc_cIfor = ALLTRIM(cursor_4c_Busca.iclis)
4591:                     loc_cDfor = ALLTRIM(cursor_4c_Busca.rclis)
4592:                 ENDIF

*-- Linhas 4618 a 4636:
4618:                 USE IN cursor_4c_Busca
4619:             ENDIF
4620:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4621:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descs AS descs FROM SigCdCor ORDER BY Cods", "cursor_4c_Busca")
4622:             ENDIF
4623:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4624:             IF !ISNULL(loc_oBusca)
4625:                 loc_oBusca.this_cTabela        = "SigCdCor"
4626:                 loc_oBusca.this_cCampoChave    = "cods"
4627:                 loc_oBusca.this_cCampoBusca    = "cods"
4628:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4629:                 loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Cor")
4630:                 loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4631:                 loc_oBusca.Caption = "Buscar Cor"
4632:                 loc_oBusca.Show()
4633:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4634:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4635:                 ENDIF
4636:                 IF USED("cursor_4c_Busca")

*-- Linhas 4660 a 4678:
4660:                 USE IN cursor_4c_Busca
4661:             ENDIF
4662:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4663:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descs AS descs FROM SigCdTam ORDER BY Cods", "cursor_4c_Busca")
4664:             ENDIF
4665:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4666:             IF !ISNULL(loc_oBusca)
4667:                 loc_oBusca.this_cTabela        = "SigCdTam"
4668:                 loc_oBusca.this_cCampoChave    = "cods"
4669:                 loc_oBusca.this_cCampoBusca    = "cods"
4670:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4671:                 loc_oBusca.mAddColuna("cods",  "XXXX",                                      "Tamanho")
4672:                 loc_oBusca.mAddColuna("descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4673:                 loc_oBusca.Caption = "Buscar Tamanho"
4674:                 loc_oBusca.Show()
4675:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4676:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4677:                 ENDIF
4678:                 IF USED("cursor_4c_Busca")

*-- Linhas 4703 a 4721:
4703:                 USE IN cursor_4c_Busca
4704:             ENDIF
4705:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4706:                 SQLEXEC(gnConnHandle, "SELECT pkchave, Descs AS descs FROM sigcdmod ORDER BY pkchave", "cursor_4c_Busca")
4707:             ENDIF
4708:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4709:             IF !ISNULL(loc_oBusca)
4710:                 loc_oBusca.this_cTabela        = "sigcdmod"
4711:                 loc_oBusca.this_cCampoChave    = "pkchave"
4712:                 loc_oBusca.this_cCampoBusca    = "pkchave"
4713:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4714:                 loc_oBusca.mAddColuna("pkchave", "XXX",                                      "Modelo")
4715:                 loc_oBusca.mAddColuna("descs",   "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4716:                 loc_oBusca.Caption = "Buscar Modelo"
4717:                 loc_oBusca.Show()
4718:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4719:                     loc_cCod = ALLTRIM(cursor_4c_Busca.pkchave)
4720:                     loc_cDes = ALLTRIM(cursor_4c_Busca.descs)
4721:                 ENDIF

*-- Linhas 4748 a 4766:
4748:                 USE IN cursor_4c_Busca
4749:             ENDIF
4750:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4751:                 SQLEXEC(gnConnHandle, "SELECT Cods AS cods, Descrs AS descrs FROM SigCdAca ORDER BY Cods", "cursor_4c_Busca")
4752:             ENDIF
4753:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4754:             IF !ISNULL(loc_oBusca)
4755:                 loc_oBusca.this_cTabela        = "SigCdAca"
4756:                 loc_oBusca.this_cCampoChave    = "cods"
4757:                 loc_oBusca.this_cCampoBusca    = "cods"
4758:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4759:                 loc_oBusca.mAddColuna("cods",   "XXX",                                      "Acabamento")
4760:                 loc_oBusca.mAddColuna("descrs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4761:                 loc_oBusca.Caption = "Buscar Acabamento"
4762:                 loc_oBusca.Show()
4763:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4764:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cods)
4765:                     loc_cDes = ALLTRIM(cursor_4c_Busca.descrs)
4766:                 ENDIF

*-- Linhas 4792 a 4810:
4792:                 USE IN cursor_4c_Busca
4793:             ENDIF
4794:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4795:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
4796:             ENDIF
4797:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4798:             IF !ISNULL(loc_oBusca)
4799:                 loc_oBusca.this_cTabela        = "SigCdPro"
4800:                 loc_oBusca.this_cCampoChave    = "cpros"
4801:                 loc_oBusca.this_cCampoBusca    = "cpros"
4802:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4803:                 loc_oBusca.mAddColuna("cpros", "XXXXXXXXXXXXXX",                             "Produto")
4804:                 loc_oBusca.mAddColuna("dpros", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4805:                 loc_oBusca.Caption = "Buscar Produto Equivalente"
4806:                 loc_oBusca.Show()
4807:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4808:                     loc_cCod = ALLTRIM(cursor_4c_Busca.cpros)
4809:                 ENDIF
4810:                 IF USED("cursor_4c_Busca")

*-- Linhas 4835 a 4853:
4835:                 USE IN cursor_4c_Busca
4836:             ENDIF
4837:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4838:                 SQLEXEC(gnConnHandle, "SELECT Cods, Descs FROM SigCdCls ORDER BY Cods", "cursor_4c_Busca")
4839:             ENDIF
4840:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4841:             IF !ISNULL(loc_oBusca)
4842:                 loc_oBusca.this_cTabela        = "SigCdCls"
4843:                 loc_oBusca.this_cCampoChave    = "Cods"
4844:                 loc_oBusca.this_cCampoBusca    = "Cods"
4845:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4846:                 loc_oBusca.mAddColuna("Cods",  "XXXXX",                                    "Cod")
4847:                 loc_oBusca.mAddColuna("Descs", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4848:                 loc_oBusca.Caption = "Buscar Classifica" + CHR(231) + CHR(227) + "o"
4849:                 loc_oBusca.Show()
4850:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4851:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.Cods)
4852:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.Descs)
4853:                 ENDIF

*-- Linhas 4879 a 4897:
4879:                 USE IN cursor_4c_Busca
4880:             ENDIF
4881:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4882:                 SQLEXEC(gnConnHandle, "SELECT Codigos, Descricaos FROM SigPrLcl ORDER BY Codigos", "cursor_4c_Busca")
4883:             ENDIF
4884:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4885:             IF !ISNULL(loc_oBusca)
4886:                 loc_oBusca.this_cTabela        = "SigPrLcl"
4887:                 loc_oBusca.this_cCampoChave    = "Codigos"
4888:                 loc_oBusca.this_cCampoBusca    = "Codigos"
4889:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4890:                 loc_oBusca.mAddColuna("Codigos",    "XXXXXXXXXX",                               "Cod")
4891:                 loc_oBusca.mAddColuna("Descricaos", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4892:                 loc_oBusca.Caption = "Buscar Local de Estoque"
4893:                 loc_oBusca.Show()
4894:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4895:                     loc_cCod = ALLTRIM(cursor_4c_Busca.Codigos)
4896:                 ENDIF
4897:                 IF USED("cursor_4c_Busca")

*-- Linhas 4922 a 4940:
4922:                 USE IN cursor_4c_Busca
4923:             ENDIF
4924:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4925:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_Busca")
4926:             ENDIF
4927:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4928:             IF !ISNULL(loc_oBusca)
4929:                 loc_oBusca.this_cTabela        = "SigCdUni"
4930:                 loc_oBusca.this_cCampoChave    = "CUnis"
4931:                 loc_oBusca.this_cCampoBusca    = "CUnis"
4932:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4933:                 loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
4934:                 loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4935:                 loc_oBusca.Caption = "Buscar Unidade"
4936:                 loc_oBusca.Show()
4937:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4938:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.CUnis)
4939:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.DUnis)
4940:                 ENDIF

*-- Linhas 4967 a 4985:
4967:                 USE IN cursor_4c_Busca
4968:             ENDIF
4969:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
4970:                 SQLEXEC(gnConnHandle, "SELECT CUnis, DUnis FROM SigCdUni ORDER BY CUnis", "cursor_4c_Busca")
4971:             ENDIF
4972:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4973:             IF !ISNULL(loc_oBusca)
4974:                 loc_oBusca.this_cTabela        = "SigCdUni"
4975:                 loc_oBusca.this_cCampoChave    = "CUnis"
4976:                 loc_oBusca.this_cCampoBusca    = "CUnis"
4977:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
4978:                 loc_oBusca.mAddColuna("CUnis", "XXXXX",                                    "Unidade")
4979:                 loc_oBusca.mAddColuna("DUnis", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
4980:                 loc_oBusca.Caption = "Buscar Unidade de Pauta"
4981:                 loc_oBusca.Show()
4982:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
4983:                     loc_cCod  = ALLTRIM(cursor_4c_Busca.CUnis)
4984:                     loc_cDesc = ALLTRIM(cursor_4c_Busca.DUnis)
4985:                 ENDIF

*-- Linhas 5011 a 5029:
5011:                 USE IN cursor_4c_Busca
5012:             ENDIF
5013:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5014:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
5015:             ENDIF
5016:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5017:             IF !ISNULL(loc_oBusca)
5018:                 loc_oBusca.this_cTabela        = "SigCdMoe"
5019:                 loc_oBusca.this_cCampoChave    = "CMoes"
5020:                 loc_oBusca.this_cCampoBusca    = "CMoes"
5021:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5022:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5023:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5024:                 loc_oBusca.Caption = "Buscar Moeda (Custo)"
5025:                 loc_oBusca.Show()
5026:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5027:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5028:                 ENDIF
5029:                 IF USED("cursor_4c_Busca")

*-- Linhas 5053 a 5071:
5053:                 USE IN cursor_4c_Busca
5054:             ENDIF
5055:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5056:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
5057:             ENDIF
5058:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5059:             IF !ISNULL(loc_oBusca)
5060:                 loc_oBusca.this_cTabela        = "SigCdMoe"
5061:                 loc_oBusca.this_cCampoChave    = "CMoes"
5062:                 loc_oBusca.this_cCampoBusca    = "CMoes"
5063:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5064:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5065:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5066:                 loc_oBusca.Caption = "Buscar Moeda (Pre" + CHR(231) + "o Venda)"
5067:                 loc_oBusca.Show()
5068:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5069:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5070:                 ENDIF
5071:                 IF USED("cursor_4c_Busca")

*-- Linhas 5095 a 5113:
5095:                 USE IN cursor_4c_Busca
5096:             ENDIF
5097:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5098:                 SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_Busca")
5099:             ENDIF
5100:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5101:             IF !ISNULL(loc_oBusca)
5102:                 loc_oBusca.this_cTabela        = "SigCdMoe"
5103:                 loc_oBusca.this_cCampoChave    = "CMoes"
5104:                 loc_oBusca.this_cCampoBusca    = "CMoes"
5105:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5106:                 loc_oBusca.mAddColuna("CMoes", "XXXXX",                                    "Moeda")
5107:                 loc_oBusca.mAddColuna("DMoes", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5108:                 loc_oBusca.Caption = "Buscar Moeda (Fator Venda)"
5109:                 loc_oBusca.Show()
5110:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5111:                     loc_cCod = ALLTRIM(cursor_4c_Busca.CMoes)
5112:                 ENDIF
5113:                 IF USED("cursor_4c_Busca")

*-- Linhas 5140 a 5274:
5140:         *-- Grupo
5141:         loc_cCgru = ALLTRIM(par_oPg1.txt_4c_Cgru.Value)
5142:         IF !EMPTY(loc_cCgru)
5143:             loc_cSQL    = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
5144:                           "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
5145:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruBof")
5146:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruBof") > 0
5147:                 par_oPg1.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruBof.DGrus)
5148:             ENDIF
5149:             IF USED("cursor_4c_GruBof")
5150:                 USE IN cursor_4c_GruBof
5151:             ENDIF
5152:         ENDIF
5153: 
5154:         *-- Linha
5155:         loc_cLin = ALLTRIM(par_oPg1.txt_4c_Lin.Value)
5156:         IF !EMPTY(loc_cLin)
5157:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdLin " + ;
5158:                           "WHERE Linhas = " + EscaparSQL(PADR(loc_cLin, 10))
5159:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinBof")
5160:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_LinBof") > 0
5161:                 par_oPg1.txt_4c_DLin.Value = ALLTRIM(cursor_4c_LinBof.Descs)
5162:             ENDIF
5163:             IF USED("cursor_4c_LinBof")
5164:                 USE IN cursor_4c_LinBof
5165:             ENDIF
5166:         ENDIF
5167: 
5168:         *-- Colecao/Grupo de Venda
5169:         loc_cCol = ALLTRIM(par_oPg1.txt_4c_Col.Value)
5170:         IF !EMPTY(loc_cCol)
5171:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SIGCDCOL " + ;
5172:                           "WHERE Colecoes = " + EscaparSQL(PADR(loc_cCol, 10))
5173:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ColBof")
5174:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ColBof") > 0
5175:                 par_oPg1.txt_4c_DCol.Value = ALLTRIM(cursor_4c_ColBof.Descs)
5176:             ENDIF
5177:             IF USED("cursor_4c_ColBof")
5178:                 USE IN cursor_4c_ColBof
5179:             ENDIF
5180:         ENDIF
5181: 
5182:         *-- Fornecedor
5183:         loc_cIfor = ALLTRIM(par_oPg1.txt_4c_Ifor.Value)
5184:         IF !EMPTY(loc_cIfor)
5185:             loc_cSQL    = "SELECT ISNULL(RClis,'') AS RClis FROM SIGCDCLI " + ;
5186:                           "WHERE IClis = " + EscaparSQL(PADR(loc_cIfor, 10))
5187:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_IforBof")
5188:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_IforBof") > 0
5189:                 par_oPg1.txt_4c_Dfor.Value = ALLTRIM(cursor_4c_IforBof.RClis)
5190:             ENDIF
5191:             IF USED("cursor_4c_IforBof")
5192:                 USE IN cursor_4c_IforBof
5193:             ENDIF
5194:         ENDIF
5195: 
5196:         *-- Modelo
5197:         loc_cCodFinP = ALLTRIM(par_oPg1.txt_4c_CodFinP.Value)
5198:         IF !EMPTY(loc_cCodFinP)
5199:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM sigcdmod " + ;
5200:                           "WHERE Codigos = " + EscaparSQL(PADR(loc_cCodFinP, 3))
5201:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ModBof")
5202:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ModBof") > 0
5203:                 par_oPg1.txt_4c_DesFinP.Value = ALLTRIM(cursor_4c_ModBof.Descs)
5204:             ENDIF
5205:             IF USED("cursor_4c_ModBof")
5206:                 USE IN cursor_4c_ModBof
5207:             ENDIF
5208:         ENDIF
5209: 
5210:         *-- Acabamento
5211:         loc_cCodacb = ALLTRIM(par_oPg1.txt_4c_Codacb.Value)
5212:         IF !EMPTY(loc_cCodacb)
5213:             loc_cSQL    = "SELECT ISNULL(Descrs,'') AS Descrs FROM SigCdAca " + ;
5214:                           "WHERE Cods = " + EscaparSQL(PADR(loc_cCodacb, 3))
5215:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcaBof")
5216:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_AcaBof") > 0
5217:                 par_oPg1.txt_4c_Dacb.Value = ALLTRIM(cursor_4c_AcaBof.Descrs)
5218:             ENDIF
5219:             IF USED("cursor_4c_AcaBof")
5220:                 USE IN cursor_4c_AcaBof
5221:             ENDIF
5222:         ENDIF
5223: 
5224:         *-- Classificacao (SigCdCls: Cods/Descs)
5225:         LOCAL loc_cClass
5226:         loc_cClass = ALLTRIM(par_oPg1.txt_4c_Class.Value)
5227:         IF !EMPTY(loc_cClass)
5228:             loc_cSQL    = "SELECT ISNULL(Descs,'') AS Descs FROM SigCdCls " + ;
5229:                           "WHERE Cods = " + EscaparSQL(PADR(loc_cClass, 3))
5230:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ClsBof")
5231:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ClsBof") > 0
5232:                 par_oPg1.txt_4c_DClass.Value = ALLTRIM(cursor_4c_ClsBof.Descs)
5233:             ENDIF
5234:             IF USED("cursor_4c_ClsBof")
5235:                 USE IN cursor_4c_ClsBof
5236:             ENDIF
5237:         ENDIF
5238: 
5239:         *-- Unidade (SigCdUni: CUnis/DUnis)
5240:         LOCAL loc_cCuni, loc_cCunip
5241:         loc_cCuni = ALLTRIM(par_oPg1.txt_4c_Cuni.Value)
5242:         IF !EMPTY(loc_cCuni)
5243:             loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
5244:                           "WHERE CUnis = " + EscaparSQL(PADR(loc_cCuni, 3))
5245:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UniBof")
5246:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UniBof") > 0
5247:                 par_oPg1.txt_4c_Duni.Value = ALLTRIM(cursor_4c_UniBof.DUnis)
5248:             ENDIF
5249:             IF USED("cursor_4c_UniBof")
5250:                 USE IN cursor_4c_UniBof
5251:             ENDIF
5252:         ENDIF
5253: 
5254:         *-- Unidade de Pauta (SigCdUni: CUnis/DUnis)
5255:         loc_cCunip = ALLTRIM(par_oPg1.txt_4c_Cunip.Value)
5256:         IF !EMPTY(loc_cCunip)
5257:             loc_cSQL    = "SELECT ISNULL(DUnis,'') AS DUnis FROM SigCdUni " + ;
5258:                           "WHERE CUnis = " + EscaparSQL(PADR(loc_cCunip, 3))
5259:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UnipBof")
5260:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_UnipBof") > 0
5261:                 par_oPg1.txt_4c_Dunip.Value = ALLTRIM(cursor_4c_UnipBof.DUnis)
5262:             ENDIF
5263:             IF USED("cursor_4c_UnipBof")
5264:                 USE IN cursor_4c_UnipBof
5265:             ENDIF
5266:         ENDIF
5267:     ENDPROC
5268: 
5269:     *--------------------------------------------------------------------------
5270:     * AjustarBotoesPorModo - Ajusta visibilidade/estado dos botoes por modo atual
5271:     *--------------------------------------------------------------------------
5272:     PROTECTED PROCEDURE AjustarBotoesPorModo()
5273:         LOCAL loc_oPg1, loc_oPg2, loc_lEditing
5274:         loc_oPg1    = THIS.pgf_4c_Paginas.Page1

*-- Linhas 5296 a 5314:
5296:     *--------------------------------------------------------------------------
5297:     PROTECTED PROCEDURE ObterCodigoSelecionado()
5298:         IF USED("cursor_4c_Lista") AND RECCOUNT("cursor_4c_Lista") > 0
5299:             SELECT cursor_4c_Lista
5300:             RETURN ALLTRIM(cursor_4c_Lista.cpros)
5301:         ENDIF
5302:         RETURN ""
5303:     ENDPROC
5304: 
5305:     *==========================================================================
5306:     *-- HANDLERS DE BOTOES - Page1 (Lista)
5307:     *==========================================================================
5308: 
5309:     *--------------------------------------------------------------------------
5310:     * BtnIncluirClick - Modo INCLUIR: prepara formulario para novo registro
5311:     *--------------------------------------------------------------------------
5312:     PROCEDURE BtnIncluirClick()
5313:         THIS.this_cModoAtual   = "INCLUIR"
5314:         THIS.this_lNovoRegistro = .T.

*-- Linhas 5396 a 5414:
5396:                 USE IN cursor_4c_Busca
5397:             ENDIF
5398:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5399:                 SQLEXEC(gnConnHandle, "SELECT CPros AS cpros, DPros AS dpros, CGrus AS cgrus FROM SigCdPro ORDER BY CPros", "cursor_4c_Busca")
5400:             ENDIF
5401:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5402:             IF !ISNULL(loc_oBusca)
5403:                 loc_oBusca.this_cTabela        = "SigCdPro"
5404:                 loc_oBusca.this_cCampoChave    = "cpros"
5405:                 loc_oBusca.this_cCampoBusca    = "cpros"
5406:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5407:                 loc_oBusca.mAddColuna("cpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXX", "Produto")
5408:                 loc_oBusca.mAddColuna("dpros",  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5409:                 loc_oBusca.mAddColuna("cgrus",  "XXXXX", "Grupo")
5410:                 loc_oBusca.Caption = "Buscar Produto"
5411:                 loc_oBusca.Show()
5412:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5413:                     loc_cCodigo = ALLTRIM(cursor_4c_Busca.cpros)
5414:                 ENDIF

*-- Linhas 5527 a 5545:
5527:                 USE IN cursor_4c_Busca
5528:             ENDIF
5529:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5530:                 SQLEXEC(gnConnHandle, "SELECT CGrus AS cgrus, DGrus AS dgrus FROM SigCdGrp ORDER BY CGrus", "cursor_4c_Busca")
5531:             ENDIF
5532:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
5533:             IF !ISNULL(loc_oBusca)
5534:                 loc_oBusca.this_cTabela        = "SigCdGrp"
5535:                 loc_oBusca.this_cCampoChave    = "cgrus"
5536:                 loc_oBusca.this_cCampoBusca    = "cgrus"
5537:                 loc_oBusca.this_cCursorDestino = "cursor_4c_Busca"
5538:                 loc_oBusca.mAddColuna("cgrus", "XXXXX",                                     "Grupo")
5539:                 loc_oBusca.mAddColuna("dgrus", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Descri" + CHR(231) + CHR(227) + "o")
5540:                 loc_oBusca.Caption = "Buscar Grupo de Produto"
5541:                 loc_oBusca.Show()
5542:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
5543:                     loc_cCgru = ALLTRIM(cursor_4c_Busca.cgrus)
5544:                     loc_cDgru = ALLTRIM(cursor_4c_Busca.dgrus)
5545:                 ENDIF

*-- Linhas 5572 a 5592:
5572:             loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
5573:         ELSE
5574:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
5575:                 loc_cSQL = "SELECT ISNULL(DGrus,'') AS DGrus FROM SigCdGrp " + ;
5576:                            "WHERE CGrus = " + EscaparSQL(PADR(loc_cCgru, 3))
5577:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruFiltro")
5578:                 IF loc_nResult > 0 AND RECCOUNT("cursor_4c_GruFiltro") > 0
5579:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ALLTRIM(cursor_4c_GruFiltro.DGrus)
5580:                 ELSE
5581:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Dgru.Value = ""
5582:                     loc_oPg1.cnt_4c_Filtros.txt_4c_Cgru.Value = ""
5583:                 ENDIF
5584:                 IF USED("cursor_4c_GruFiltro")
5585:                     USE IN cursor_4c_GruFiltro
5586:                 ENDIF
5587:             ENDIF
5588:         ENDIF
5589:         THIS.CarregarLista()
5590:     ENDPROC
5591: 
5592:     *==========================================================================


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

